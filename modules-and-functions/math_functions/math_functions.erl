-module(math_functions).

-export([even/1, odd/1]).

-include_lib("eunit/include/eunit.hrl").

even(X) when is_integer(X) ->
    X rem 2 =:= 0.

odd(X) when is_integer(X) ->
    abs(X rem 2) =:= 1.

even_test_() ->
    [
        ?_assertMatch(true, even(0)),
        ?_assertMatch(true, even(2)),
        ?_assertMatch(true, even(-2)),
        ?_assertNotMatch(true, even(1)),
        ?_assertNotMatch(true, even(-1)),
        ?_assertError(function_clause, even(0.0))
    ].

odd_test_() ->
    [
        ?_assertMatch(true, odd(1)),
        ?_assertMatch(true, odd(3)),
        ?_assertMatch(true, odd(-1)),
        ?_assertNotMatch(true, odd(2)),
        ?_assertNotMatch(true, odd(-2)),
        ?_assertError(function_clause, odd(0.0))
    ].
