-module(gid_http).
-export([start_link/0, init/0,init/2, merge_util/2, get_products/0, enter_qty/1]).

  


  start_link()->
    process_flag('trap_exit', true), 
    Pid = spawn_link('gid_http', init, []),
     Pid ! {'ok', self()},
     receive
      {'init', Value}-> Value, io:format("ok it") 
     end,
     {'ok', self()}
    .


  merge_util([], V) ->V
  ;
  merge_util([H|T], V) ->
    proplists:lookup(<<"categories">>, H),
    List = H ++ V,
    merge_util(T, List).

  init()->
    application:ensure_all_started(inets),
    application:ensure_all_started(ssl),
    
     receive 
      {'ok', From} -> 
        Where = ets:whereis('Products'),
       case Where  of 
     'undefined' -> io:format("did it again");
      _ -> io:format("didn't http again"),  'defined'
     end,
     From ! {'init', Where };
     _ -> exit("failed")

     end,
    F = init(1, []),
    {'ok', F }
  . 

  init('done', Values) ->
    Map_Values = fun G([],A,  _) -> A;
    G ([H|T], A, I ) ->
  
    case {proplists:get_value(<<"categories">>,H), proplists:get_value(<<"prices">>,H) }of
    {[[_,_,{<<"slug">>, <<"cookies">>},_], _], P} -> V =  
    { I, proplists:get_value(<<"name">>, H), proplists:get_value(<<"regular_price">>, P)}, G(T, [V | A], I + 1) ;
     _ -> G(T, A, I)
    end
    end,

    Map = Map_Values(Values, [], 1),
    % Reverse_Map = lists:reverse(Map),
    
    ets:insert('Products',Map);






  init(P, Values)->
    Page = integer_to_list(P),
    URL = "https://gideonsbakehouse.com/wp-json/wc/store/products?per_page=100&page=" ++ Page,

    case  httpc:request(URL) of
    {'ok', {{_,200, _},_, "[]"}} ->    init('done', Values);
    {'ok', {{_,200, _}, _, Value}} ->
    PageNow = P + 1,
    New_State = jsx:decode(list_to_binary(Value),  [{return_maps, false}])  ++ Values,





    init(PageNow, New_State);
     V -> io:format("server isn't working ~p", [V])
    end.



    get_products()-> L = ets:tab2list('Products'), lists:reverse(L).


  enter_qty(Binary_Qty)->
   
    _L = "1:1 2:2 3:3", 
    S = string:split(Binary_Qty, " ", all),
    M = lists:map(fun(X) -> list_to_tuple(string:split(X, ":")) end, S), 
   
     fun()-> 
     Ets_Product= ets:tab2list('Products'),
     erlang:display(Ets_Product),  
    PROPS = [[{<<"name">>, Cookie}, {<<"qty">>, QTY_INT}, {<<"price">>, Price}]|| 
     {EV, Cookie, Price}<-Ets_Product,
     {IV, Qty}<- M,
     {QTY_INT, _} <- [string:to_integer(Qty)],
     {IV_INT, _}<- [string:to_integer(IV)], 
		EV =:= IV_INT ],
      erlang:display(PROPS),     
       [{<<"cookies">>, PROPS}]
  
   %  jsx:encode([{'cookies', PROPS}])
  end()
.




 
