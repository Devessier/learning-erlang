-module(modules).

-export([get_module_exporting_most_functions/0, get_most_common_function_name/0, get_unambiguous_functions_names/0]).

get_all_modules() ->
    Modules = [ Module || {Module, _} <- code:all_loaded() ],
    ModulesWithExportedFunctions = lists:map(
        fun (Module) ->
            ModuleInfo = Module:module_info(),
            {value, {exports, ExportedFunctions}} = lists:search(
                fun(Item) ->
                    case Item of
                        {exports, _} -> true;
                        _ -> false
                    end
                end,
                ModuleInfo
            ),
            {Module, ExportedFunctions}
        end,
        Modules
    ),
    ModulesWithExportedFunctions.

get_module_exporting_most_functions() ->
    ModulesWithExportedFunctionsCount = [ {Module, length(ExportedFunctions)} || {Module, ExportedFunctions} <- get_all_modules() ],
    [{ModuleWithMostExportedFunctions, ExportedFunctionsCount}|_] = lists:sort(
        fun ({_, CountA}, {_, CountB}) ->
            CountA > CountB
        end,
        ModulesWithExportedFunctionsCount
    ),
    {ModuleWithMostExportedFunctions, ExportedFunctionsCount}.

get_most_common_function_name() ->
    FunctionsNamesList = count_functions_names(),
    [{MostUsedFunctionName, Count}|_Rest] = lists:sort(
        fun ({_, CountA}, {_, CountB}) ->
            CountA > CountB
        end,
        FunctionsNamesList
    ),
    {MostUsedFunctionName, Count}.

get_unambiguous_functions_names() ->
    FunctionsNamesList = count_functions_names(),
    UnambiguousFunctionsNames = [ FunctionName || {FunctionName, Count} <- FunctionsNamesList, Count =:= 1 ],
    UnambiguousFunctionsNames.

count_functions_names() ->
    ModulesWithExportedFunctions = get_all_modules(),
    Dict = aggregate_functions_names(ModulesWithExportedFunctions, #{}),
    FunctionsNamesList = maps:to_list(Dict),
    FunctionsNamesList.

aggregate_functions_names([{_Module, ExportedFunctions}|Tail], Dict) ->
    aggregate_functions_names(
        Tail,
        aggregate_functions_name_for_functions_list(ExportedFunctions, Dict)
    );
aggregate_functions_names([], Dict) ->
    Dict.

aggregate_functions_name_for_functions_list([{FunctionName, _Arity}|Rest], Dict) ->
    UpdatedDict = case Dict of
        #{ FunctionName := Count } ->
            Dict#{ FunctionName := Count+1 };
        _ ->
            Dict#{ FunctionName => 1 }
    end,
    aggregate_functions_name_for_functions_list(Rest, UpdatedDict);
aggregate_functions_name_for_functions_list([], Dict) ->
    Dict.
