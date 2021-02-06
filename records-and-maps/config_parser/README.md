config_parser
=====

An OTP library to parse a JSON configuration file.

**config_parser** is built via rebar3.

Quickstart
-----

To parse a config file available at a given path following a schema, you can write:

```erlang
1> config_parser:parse({
    "./config.json",
    #{
        "language" => string,
        "quality" => string
    }
}).
#{
    "language" => {ok, <<"erlang">>},
    "quality" => {ok, <<"max">>}
}
```

Build
-----

    $ rebar3 compile
