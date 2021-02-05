-module(math_functions).

-export([even/1, odd/1, filter/2, split_list_comprehension/1, split_list_comprehension_with_filter/1, split_with_acc/1]).

-include_lib("eunit/include/eunit.hrl").

even(X) when is_integer(X) ->
    X rem 2 =:= 0.

odd(X) when is_integer(X) ->
    abs(X rem 2) =:= 1.

filter(F, [H|T]) when is_function(F) ->
    case F(H) of
        true -> [H|filter(F, T)];
        false -> filter(F, T)
    end;
filter(_F, []) when is_function(_F) ->
    [].

split_list_comprehension(L) when is_list(L) ->
    Evens = [X || X <- L, even(X) ],
    Odds = [X || X <- L, odd(X) ],
    {Evens, Odds}.

split_list_comprehension_with_filter(L) when is_list(L) ->
    Evens = [X || X <- filter(fun even/1, L) ],
    Odds = [X || X <- filter(fun odd/1, L) ],
    {Evens, Odds}.

split_with_acc(L) when is_list(L) ->
    {Evens, Odds} = split_acc(L, [], []),
    {Evens, Odds}.

split_acc([H|T], EvensAcc, OddsAcc) ->
    case even(H) of
        true -> split_acc(T, [H|EvensAcc], OddsAcc);
        false -> split_acc(T, EvensAcc, [H|OddsAcc])
    end;
split_acc([], EvensAcc, OddsAcc) ->
    {lists:reverse(EvensAcc), lists:reverse(OddsAcc)}.

even_test_() ->
    [?_assertMatch(true, even(0)),
        ?_assertMatch(true, even(2)),
        ?_assertMatch(true, even(-2)),
        ?_assertNotMatch(true, even(1)),
        ?_assertNotMatch(true, even(-1)),
        ?_assertError(function_clause, even(0.0))].

odd_test_() ->
    [?_assertMatch(true, odd(1)),
        ?_assertMatch(true, odd(3)),
        ?_assertMatch(true, odd(-1)),
        ?_assertNotMatch(true, odd(2)),
        ?_assertNotMatch(true, odd(-2)),
        ?_assertError(function_clause, odd(0.0))].

filter_test_() ->
    [?_assertMatch([-2, 0, 2, 4, 6], filter(fun even/1, [-2, -1, 0, 1, 2, 3, 4, 5, 6])),
        ?_assertMatch([-1, 1, 3, 5], filter(fun odd/1, [-2, -1, 0, 1, 2, 3, 4, 5, 6]))].

split_list_comprehension_test_() ->
    [?_assertMatch({[0, 2, 4], [1, 3, 5]}, split_list_comprehension([0, 1, 2, 3, 4, 5]))].

split_list_comprehension_with_filter_test_() ->
    [?_assertMatch({[0, 2, 4], [1, 3, 5]}, split_list_comprehension_with_filter([0, 1, 2, 3, 4, 5]))].

split_acc_test_() ->
    [?_assertMatch({[0, 2, 4], [1, 3, 5]}, split_with_acc([0, 1, 2, 3, 4, 5]))].
