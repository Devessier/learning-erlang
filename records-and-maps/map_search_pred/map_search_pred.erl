-module(map_search_pred).

-export([map_search_pred/2]).

-include_lib("eunit/include/eunit.hrl").

map_search_pred(Map, Pred) ->
    List = maps:to_list(Map),
    is_matching(Pred, List).

is_matching(Pred, [{Key, Value}|Rest]) ->
    case Pred(Key, Value) of
        true -> {Key, Value};
        false -> is_matching(Pred, Rest)
    end;
is_matching(_Pred, []) -> false.

map_search_pred_test_() ->
    Pred = fun (Key, Value) -> Key =:= "key!" orelse Value =:= "lol" end,
    [
        {"returns false when predicate never matches",
            ?_assertMatch(
                false,
                map_search_pred(
                    #{
                        "a" => 3
                    },
                    Pred
                )
            )
        },
        {"finds match",
            ?_assertMatch(
                {"key!", 2},
                map_search_pred(
                    #{
                        "a" => 3,
                        "key!" => 2
                    },
                    Pred
                )
            )
        },
        {"finds first match",
            ?_assertMatch(
                {"key!", 2},
                map_search_pred(
                    #{
                        "a" => 3,
                        "key!" => 2,
                        "other one" => "lol"
                    },
                    Pred
                )
            )
        }
    ].