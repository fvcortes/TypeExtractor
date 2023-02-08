-------------------------------------------------------------------
-- File: Hook.lua                                                 -
-- Inspect local types; export function information               -
-------------------------------------------------------------------
require "Inspect"
Counters = {}
Names = {}
Ignores = {}
Infos = {}
TotalCalls = 0
TotalFunctions = 0

function Hook (event)
    local infos = debug.getinfo(2,"fnrSt")
    local f = infos.func
    if (Ignores[f] == true) then
        return
    else
        if(Counters[f] == nil) then
            if (infos.what ~= "Lua") then
                Ignores[f] = true
                return
            else
                TotalFunctions = TotalFunctions + 1
                TotalCalls = TotalCalls + 1
                Counters[f] = 1
                Infos[f] = infos
            end
        else
            if(event == "call" or event == "tail call") then
                TotalCalls = TotalCalls + 1
                Counters[f] = Counters[f] + 1
            end
        end
        Inspect(event,infos)
    end
end