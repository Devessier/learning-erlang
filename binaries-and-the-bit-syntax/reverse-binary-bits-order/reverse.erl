-module(reverse).

-export([rev/1]).

-include_lib("eunit/include/eunit.hrl").

rev(Bistring) ->
    rev(Bistring, <<>>).

rev(<<X:1, Bitstring/bitstring>>, Acc) ->
    rev(Bitstring, <<X:1, Acc/bitstring>>);
rev(<<>>, Acc) ->
    Acc.

rev_test_() ->
    [
        {"returns empty binary when receiving empty binary",
            ?_assertMatch(
                <<>>,
                rev(<<>>)
            )
        },
        {"reverses single byte",
            ?_assertMatch(
                <<2#01010101>>,
                rev(<<2#10101010>>)
            )
        },
        {"reverses several bytes",
            ?_assertMatch(
                <<16#00, 16#00, 16#01>>,
                rev(<<16#80, 16#00, 16#00>>)
            )
        }
    ].
