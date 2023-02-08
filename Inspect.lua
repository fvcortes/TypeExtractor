-------------------------------------------------------------------
-- File: Hook.lua                                                 -
-- Inspect local types; export function information               -
-------------------------------------------------------------------
local Type = require "Type"
Functions = {}
Stack = {}

local function add_parameter_types(types, func)
    if (Functions[func] == nil) then     -- first call
        Functions[func] = {tag = "function", parameterType = types}
    else
        for k,v in ipairs(types) do
            Functions[func].parameterType[k] = Functions[func].parameterType[k] + v
        end
    end
end

local function add_return_types(types,func)
    if(Functions[func].returnType == nil) then   -- first return
        Functions[func].returnType = types
    else
        for k,v in ipairs (types) do
            Functions[func].returnType[k] = v + Functions[func].returnType[k]
        end
    end
end

local function update_parameter_type(types,func)
    add_parameter_types(types,func)
end

local function update_return_type(types, func, istailcall)
    add_return_types(types,func)
    while istailcall do
        local p = table.remove(Stack)
        func = p.func
        istailcall = p.istailcall
        add_return_types(types,func)
    end
end

local function get_transfered_types(infos)
    local t = {}
    for i=infos.ftransfer,(infos.ftransfer + infos.ntransfer) - 1 do
        local _, value = debug.getlocal(4,i)
        table.insert(t, Type.new(value))
    end
    return t
end

function Inspect(event,infos)
    local transfered_types = get_transfered_types(infos)
    if(event == "call" or event == "tail call") then
        table.insert(Stack, infos)
        update_parameter_type(transfered_types,infos.func)
    else
        local p = table.remove(Stack)
        update_return_type(transfered_types, p.func, p.istailcall)
    end
end