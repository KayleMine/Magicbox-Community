local addon, dark_addon = ...

dark_addon.name = 'MagicBox'
dark_addon.version = '1.4.8.8'
dark_addon.color = '727bad'
dark_addon.color2 = '72ad98'
dark_addon.color3 = '96ad72'
dark_addon.ready = false
dark_addon.settings_ready = false
dark_addon.ready_callbacks = { }
dark_addon.protected = false
dark_addon.adv_protected = false

function dark_addon.on_ready(callback)
  dark_addon.ready_callbacks[callback] = callback
end
