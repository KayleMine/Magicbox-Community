local addon, dark_addon = ...
local onEvent = _G.onEvent
local CreateFrame = _G.CreateFrame

dark_addon.Listener = {}
local listeners = {}

local dark_listener = CreateFrame('Frame')
dark_listener:SetScript('OnEvent', function(_, event, ...)
    if not listeners[event] then return end
    for _, callback in pairs(listeners[event]) do
        callback(...)
    end
end)

function dark_addon.Listener:Add(name, event, callback)
    if not listeners[event] then
        dark_listener:RegisterEvent(event)
        listeners[event] = {}
    end
    listeners[event][name] = callback
end

function dark_addon.Listener:Remove(name, event)
    if listeners[event] then
        listeners[event][name] = nil
    end
end

function dark_addon.Listener:Trigger(event, ...)
    onEvent(nil, event, ...)
end
