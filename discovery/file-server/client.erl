-module(client).
-export([client/0]).

read_dir_files(_, []) ->
    ok;
read_dir_files(ServerPID, [File|RestFiles]) ->
    ServerPID ! {self(), {get_file, File}},
    receive
        {_, {ok, FileContent}} ->
            io:fwrite("file ~p content is ~p~n", [File, FileContent])
    end,
    read_dir_files(ServerPID, RestFiles).

client() ->
    ServerPID = server:start("."),
    ServerPID ! {self(), list_dir},
    receive
        {_, {ok, Files}} ->
            io:fwrite("received ~p~n", [Files]),
            read_dir_files(ServerPID, Files)
    end.
