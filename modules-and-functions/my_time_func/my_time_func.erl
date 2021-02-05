-module(my_time_func).

-export([my_time_func/0]).

% See https://stackoverflow.com/a/9027675/11780994 for formatting.
my_time_func() ->
    {Year, Month, Day} = erlang:date(),
    {Hour, Minute, Second} = erlang:time(),
    io_lib:format("~2..0B:~2..0B:~2..0B ~2..0B/~2..0B/~4..0B", [Hour, Minute, Second, Day, Month, Year]).
