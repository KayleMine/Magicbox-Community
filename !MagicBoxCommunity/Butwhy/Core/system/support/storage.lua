local addon, dark_addon = ...
if (GetLocale() == "ruRU") then
 L_Build = "Билд:"
 L_CreateProfile = "Создаю новый профиль настроек."
 L_LoadedCFG = "Настройки загружены."
else
 L_Build = "Build: "
 L_CreateProfile = "Creating settings profile."
 L_LoadedCFG = "Settings loaded."
end
    if dark_addon_storage == nil then 
      dark_addon_storage = { }
    end
local frame = CreateFrame('frame')
frame:RegisterEvent('ADDON_LOADED')
frame:SetScript('OnEvent', function(self, event, arg1)
  if event == 'ADDON_LOADED' and arg1 == addon then
    if dark_addon_storage == nil then
      dark_addon_storage = { }
	  state = 0
	  dark_addon.settings.store('ssc', state)
	  stateval = dark_addon.settings.fetch('ssc') 
   if stateval == 2 then dark_addon.log(L_Build .. dark_addon.version) end
   if stateval == 2 then dark_addon.log(L_CreateProfile) end
    else
  if stateval == 2 then dark_addon.log(L_LoadedCFG) end
    end
    dark_addon.settings_ready = true
  end
end)

dark_addon.settings = { }

function dark_addon.settings.store(key, value)
  dark_addon_storage[key] = value
  return true
end

function dark_addon.settings.fetch(key, default)
  local value = dark_addon_storage[key]
  return value == nil and default or value
end

function dark_addon.settings.store_toggle(key, value)
  if not dark_addon.rotation.current_spec then return end
  local active_rotation = dark_addon.settings.fetch('active_rotation_' .. dark_addon.rotation.current_spec, false)
  if not active_rotation then return end
  local full_key
  if dark_addon.rotation.active_rotation then
    full_key = active_rotation .. '_toggle_' .. key
  else
    full_key = 'toggle_' .. key
  end
  dark_addon_storage[full_key] = value
--[[  dark_addon.console.debug(2, 'settings', 'purple', string.format(
    '%s <= %s', full_key, tostring(value)
  ))]]
  return true
end

function dark_addon.settings.fetch_toggle(key, default)
  if not dark_addon.rotation.current_spec then return end
  local active_rotation = dark_addon.settings.fetch('active_rotation_' .. dark_addon.rotation.current_spec, false)
  if not active_rotation then return end
  local full_key
  if dark_addon.rotation.active_rotation then
    full_key = active_rotation .. '_toggle_' .. key
  else
    full_key = 'toggle_' .. key
  end
  if not string.find(full_key, 'master_toggle') then
    --[[dark_addon.console.debug(2, 'settings', 'purple', string.format(
      '%s => %s', full_key, tostring(default)
    ))]]
  end
  return dark_addon_storage[full_key] or default
end

dark_addon.tmp = {
  cache = { }
}

function dark_addon.tmp.store(key, value)
  dark_addon.tmp.cache[key] = value
  return true
end

function dark_addon.tmp.fetch(key, default)
  return dark_addon.tmp.cache[key] or default
end

dark_addon.on_ready(function()
  dark_addon.environment.hooks.toggle = function(key, default)
    return dark_addon.settings.fetch_toggle(key, default)
  end
  dark_addon.environment.hooks.storage = function(key, default)
    return dark_addon.settings.fetch(key, default)
  end
end)
