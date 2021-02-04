-module(shop).
-export([cost/1, checkout/1]).

cost(apple) -> 2;
cost(iphone) -> 700;
cost(iphonex) -> 1000;
cost(computer) -> 800.

checkout(Products) -> checkout(Products, 0).

checkout([{Type, Count}|TailProducts], Total) ->
    NewTotal = Total + cost(Type) * Count,
    checkout(TailProducts, NewTotal);
checkout([], Total) -> Total.
