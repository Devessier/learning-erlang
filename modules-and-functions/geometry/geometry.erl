-module(geometry).

-export([area/1]).
-export([perimeter/1]).

-include_lib("eunit/include/eunit.hrl").

area({rectangle, Width, Height}) ->
    Width * Height;
area({square, Side}) ->
    Side * Side;
area({circle, Radius}) ->
    math:pi() * Radius * Radius;
area({triangle, Base, Height}) ->
    (Base * Height) / 2.

perimeter({rectangle, Width, Height}) ->
    Width * 2 + Height * 2;
perimeter({square, Side}) ->
    Side * 4;
perimeter({circle, Radius}) ->
    2 * math:pi() * Radius;
perimeter({triangle, Base, Height}) ->
    Base + Height + math:sqrt(Base * Base + Height * Height).

area_test_() ->
    [
        ?_assert(area({rectangle, 10, 5}) =:= 50),
        ?_assert(area({rectangle, 0, 0}) =:= 0),
        ?_assert(area({square, 10}) =:= 100),
        ?_assert(area({circle, 10}) =:= 314.1592653589793),
        ?_assert(area({triangle, 10, 5}) =:= 25.0)
    ].

perimeter_test_() ->
    [
        ?_assert(perimeter({rectangle, 10, 5}) =:= 30),
        ?_assert(perimeter({rectangle, 0, 0}) =:= 0),
        ?_assert(perimeter({square, 10}) =:= 40),
        ?_assert(perimeter({circle, 10}) =:= 62.83185307179586),
        ?_assert(perimeter({triangle, 10, 5}) =:= 26.180339887498949)
    ].
