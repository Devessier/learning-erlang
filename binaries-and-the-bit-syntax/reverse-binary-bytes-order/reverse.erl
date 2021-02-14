-module(reverse).

-export([rev/1]).

% The default endianess is `big`, so we can reverse the bytes simply
% by casting it to a little endianess integer.
rev(Binary) ->
    Size = bit_size(Binary),
    <<X:Size/integer-big>> = Binary,
    <<X:Size/integer-little>>.
