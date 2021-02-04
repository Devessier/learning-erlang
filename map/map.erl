-module(map).
-export([map/2]).

map(_, []) -> [];
map(Func, [Head|Tail]) ->
    [Func(Head)|map(Func, Tail)].
