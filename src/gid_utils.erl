-module(gid_utils).
-export([save_doc/2]).

save_doc(db,doc)->
couchbeam:save_doc(db,doc).