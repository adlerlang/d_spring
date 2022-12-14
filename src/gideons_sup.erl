-module(gideons_sup).
-behaviour(supervisor).

-export([start_link/0]).
-export([init/1]).

start_link() ->
	supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init([]) ->
	ets:new('Products', [named_table, set, public]),
	Gid ={gid_http, 
	{gid_http, start_link, []}, 
	permanent, 2000, worker, [gid_http] 
    },
	{ok, {{one_for_one, 1, 5}, [Gid]}}.
