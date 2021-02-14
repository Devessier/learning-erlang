-module(term_packet).

-export([term_to_packet/1, packet_to_term/1]).

-include_lib("eunit/include/eunit.hrl").

% Protocol
% 
% Given Term, any erlang Term
% And Binary the result of `term_to_binary(Term)`,
% The packet is defined as :
%   <<BinarySize:4, Binary:BinarySize/binary>>

term_to_packet(Term) ->
    Binary = term_to_binary(Term),
    Size = byte_size(Binary),
    <<Size:4/integer, Binary:Size/binary>>.

packet_to_term(Packet) ->
    <<Size:4/integer, Binary:Size/binary>> = Packet,
    binary_to_term(Binary).

term_to_packet_test_() ->
    Term = {lol,"a"},
    Packet = <<216,54,128,38,64,0,54,198,246,198,176,0,22,1:4>>,
    ?_assertMatch(
        Packet,
        term_to_packet(Term)
    ).

packet_to_term_test_() ->
    Packet = <<216,54,128,38,64,0,54,198,246,198,176,0,22,1:4>>,
    Term = {lol,"a"},
    ?_assertMatch(
        Term,
        packet_to_term(Packet)
    ).
