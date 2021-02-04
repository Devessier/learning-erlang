-module(geometry).

-export([area/1]).

-include_lib("eunit/include/eunit.hrl").

area({rectangle, Width, Height}) ->
    Width * Height;
area({square, Side}) ->
    Side * Side;
area({circle, Radius}) ->
    math:pi() * Radius * Radius;
area({triangle, Base, Height}) ->
    (Base * Height) / 2.

area_test_() ->
    [
        ?_assert(area({rectangle, 10, 5}) =:= 50),
        ?_assert(area({rectangle, 0, 0}) =:= 0),
        ?_assert(area({square, 10}) =:= 100),
        ?_assert(area({circle, 10}) =:= 314.1592653589793),
        ?_assert(area({triangle, 10, 5}) =:= 25.0)
    ].
