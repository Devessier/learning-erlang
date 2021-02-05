-module(mytuple_to_list).

-include_lib("eunit/include/eunit.hrl").

-export([mytuple_to_list/1]).

mytuple_to_list(Tuple) ->
    mytuple_to_list_acc(Tuple, 1, tuple_size(Tuple)).

mytuple_to_list_acc(Tuple, Index, Size) when Index =< Size ->
    [element(Index, Tuple)|mytuple_to_list_acc(Tuple, Index + 1, Size)];
mytuple_to_list_acc(_Tuple, _Index, _Size) -> [].

mytuple_to_list_test_() ->
    [
        ?_assertMatch([], mytuple_to_list({})),
        ?_assertMatch([a], mytuple_to_list({a})),
        ?_assertMatch([a, 3, "lol"], mytuple_to_list({a, 3, "lol"})),
        ?_assertNotMatch([a, '3', "lol"], mytuple_to_list({a, "3", "lol"}))
    ].
