local addon, dark_addon = ...

dark_addon.commands = {
  commands = { }
}

function dark_addon.commands.register(command)
  if type(command.command) == 'table' then
    for _, command_key in ipairs(command.command) do
      dark_addon.commands.commands[command_key] = command
    end
  else
    dark_addon.commands.commands[command.command] = command
  end
end

local function format_help(command)
  local arguments = table.concat(command.arguments, ', ')
  local command_key
  if type(command.command) == 'table' then
    command_key = table.concat(command.command, '||')
  else
    command_key = command.command
  end
  return string.format('|cff%s/fd %s|r |cff%s%s|r %s', dark_addon.color2, command_key, dark_addon.color3, arguments, command.text)
end



if GetLocale() == "ruRU" then
  L_build = "Билд"
  L_command = "Напиши /fd help и получи список команд."
  L_command_used = "Использование команды:"
  L_help = "Показать все существующие команды"
  L_error = "Не понял, напиши /fd help и помоги мне понять что-ты хочешь."
  L_list_rot = "Доступные ротации:"
  L_list_help = "Команды:"
  L_load = "Загружает ротацию."
  L_list = "Список ротаций"
  L_debug = "Включить консоль отладки на опр. уровне."
  L_toggle = "Вкл\выкл конкретную кнопку."
  L_config = "Настройки ядра"

else
  L_build = "Build:"
  L_command = "To get all commands type: /fd help"
  L_command_used = "Call command:"
  L_help = "List all commands."
  L_error = "Incorrect, type: /fd help"
  L_list_rot = "Rotation list:"
  L_list_help = "Commands:"
  L_load = "Load rotation."
  L_list = "List all rotations."
  L_debug = "Enable debug console. [1-5] (/fd debug 1)"
  L_toggle = "Toggle button."
  L_config = "Core config"
end



local function handle_command(msg, editbox)
  local _, _, command, _arguments = string.find(msg, "%s?(%w+)%s?(.*)")
  local arguments = { }

  if not _arguments then
    dark_addon.log(L_build .. dark_addon.version)
    dark_addon.log(L_command)
    return
  end

  for argument in string.gmatch(_arguments, "%S+") do
    table.insert(arguments, argument)
  end

  command = dark_addon.commands.commands[command]
  if command then
    if #command.arguments == #arguments then
      result = command.callback(unpack(arguments))
      if not result then
        dark_addon.log(L_command_used)
        dark_addon.log(format_help(command))
      end
    else
      dark_addon.log(L_command_used)
      dark_addon.log(format_help(command))
    end
  else
    dark_addon.log(L_error)
  end
end

dark_addon.on_ready(function()
  dark_addon.commands.register({
    command = 'help',
    arguments = { },
    text = L_help,
    callback = function(rotation_name)
      dark_addon.log(L_list_help)
      local printed = { }
      for _, command in pairs(dark_addon.commands.commands) do
        if not printed[tostring(command)] then
          dark_addon.log(format_help(command))
          printed[tostring(command)] = true
        end
      end
      return true
    end
  })

  dark_addon.commands.register({
    command = 'load',
    arguments = {
      'rotation_name'
    },
    text = L_load,
    callback = function(rotation_name)
      dark_addon.rotation.load(rotation_name)
      return true
    end
  })

  dark_addon.commands.register({
    command = 'list',
    arguments = { },
    text = L_list,
    callback = function()
      dark_addon.log(L_list_rot)
      for name, rotation in pairs(dark_addon.rotation.rotation_store) do
        if rotation.spec == dark_addon.rotation.current_spec or rotation.spec == false then
          dark_addon.log(rotation.label and  rotation.name .. ' - ' .. rotation.label or rotation.name)
        end
      end
      return true
    end
  })
  
  dark_addon.commands.register({
    command = 'csu',
    arguments = { 'spell', 'unit', },
    text = 'cast spell at unit',
    callback = function(spell, unit)
		dark_addon.rotation.pause(spell, unit)
      return true
    end
  })
  
  dark_addon.commands.register({
    command = 'csf',
    arguments = { 'spell' },
    text = 'cast spell at self',
    callback = function(spell)
		unit = "player"
		dark_addon.rotation.pause(spell, unit)
      return true
    end
  })

  dark_addon.commands.register({
    command = 'debug',
    arguments = {
      'debug_level',
    },
    text = L_debug,
    callback = function(debug_level)
      if tonumber(debug_level) then
        dark_addon.console.set_level(debug_level)
        if tonumber(debug_level) > 0 then
          dark_addon.console.toggle(true)
        else
          dark_addon.console.toggle(false)
        end
        return true
      else
        return false
      end
    end
  })

  dark_addon.commands.register({
    command = 'toggle',
    arguments = {
      'button_name',
    },
    text = L_toggle,
    callback = function(button_name)
      if button_name and dark_addon.interface.buttons.buttons[button_name] then
        dark_addon.interface.buttons.buttons[button_name]:callback()
        return true
      end
      return false
    end
  })

  dark_addon.commands.register({
    command = 'config',
    arguments = { },
    text = L_config,
    callback = function(button_name)
      if dark_addon.econf.parent:IsShown() then
        dark_addon.econf.parent:Hide()
      else
        dark_addon.econf.parent:Show()
      end
      return true
    end
  })
end)

SLASH_FlexDruid1, SLASH_FlexDruid2 = '/flex', '/fd'
SlashCmdList["FlexDruid"] = handle_command
