-module(dict_module).

-export([count_exported_functions/0]).

-include_lib("eunit/include/eunit.hrl").

% Returns how many functions `dict` module exports.
count_exported_functions() ->
    ModuleInfo = dict:module_info(),
    {value, {exports, ExportedFunctions}} = lists:search(
        fun(Item) ->
            case Item of
                {exports, _} -> true;
                _ -> false
            end
        end,
        ModuleInfo
    ),
    length(ExportedFunctions).

count_exported_functions_test_() ->
    {
        "dict module exports 23 functions",
        ?_assertEqual(
            23,
            count_exported_functions()
        )
    }.
