-module(config_parser).

-export([parse/1]).

-include_lib("eunit/include/eunit.hrl").

parse({Path, Schema}) when is_map(Schema) ->
    Config = get_config_file(Path),
    assert_config({Config, Schema}).

get_config_file(Path) ->
    {ok, Binary} = file:read_file(Path),
    jsx:decode(Binary).

assert_config({Config, Schema}) ->
    maps:map(
        fun(Key, Type) ->
            Value = maps:get(list_to_binary(Key), Config),
            case assert_type({Value, Type}) of
                true -> {ok, Value};
                false -> {error, Type}
            end
        end,
        Schema
    ).

assert_type({Value, Type}) ->
    case Type of
        string -> is_bitstring(Value);
        number -> is_number(Value);
        boolean -> is_boolean(Value);
        _ -> false
    end.

parse_test_() ->
    {ok, CurrentDirectory} = file:get_cwd(),
    TestConfigPath = filename:join(CurrentDirectory, "./test/config.json"),
    [
        {"parse basic config",
            ?_assertMatch(
                #{
                    "language" := {ok, <<"erlang">>},
                    "quality" := {ok, <<"max">>}
                },
                parse(
                    {TestConfigPath, #{
                        "language" => string,
                        "quality" => string
                    }}
                )
            )}
    ].

assert_config_test_() ->
    {"parse config file not matching expected types",
        ?_assertMatch(
            #{
                "language" := {error, string},
                "quality" := {ok, <<"max">>}
            },
            assert_config(
                {
                    #{
                        <<"language">> => 3,
                        <<"quality">> => <<"max">>
                    },
                    #{
                        "language" => string,
                        "quality" => string
                    }
                }
            )
        )}.
