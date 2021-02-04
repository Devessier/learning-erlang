-module(shop).
-export([cost/1, sum/1, checkout/1]).

cost(apple) -> 2;
cost(iphone) -> 700;
cost(iphonex) -> 1000;
cost(computer) -> 800.

sum(List) ->
    sum(List, 0).

sum([], Agg) -> Agg;
sum([Head|Tail], Agg) ->
    sum(Tail, Agg + Head).

checkout(Products) ->
    sum([cost(Type) * Count || {Type, Count} <- Products]).
