local addon, dark_addon = ...

dark_addon.rotation = {
  classes = {
    deathknight = { blood = 250, frost = 251, unholy = 252, Initial = 1455 },
    demonhunter = { havoc = 577, vengeance = 581, Initial = 1456 },
    druid = { balance = 102, feral = 103, guardian = 104, restoration = 105, Initial = 1447 },
    hunter = { beastmastery = 253, marksmanship = 254, survival = 255, Initial = 1448 },
    mage = { arcane = 62, fire = 63, frost = 64, Initial = 1449 },
    monk = { brewmaster = 268, windwalker = 269, mistweaver = 270, Initial = 1450},
    paladin = { holy = 65, protection = 66, retribution = 70, Initial = 1451 },
    priest = { discipline = 256, holy = 257, shadow = 258, Initial = 1452 },
    rogue = { assassination = 259, outlaw = 260, subtlety = 261, Initial = 1453 },
    shaman = { elemental = 262, enhancement = 263, restoration = 264, Initial = 1444 },
    warlock = { affliction = 265, demonology = 266, destruction = 267, Initial = 1454 },
    warrior = { arms = 71, fury = 72, protection = 73, Initial = 1446 },
    evoker = { devastation = 1467, preservation = 1468, Initial = 1465 },
  },
  rotation_store = { },
  spellbooks = { },
  talentbooks = { },
  dispellbooks = { },
  active_rotation = false
}

function dark_addon.rotation.register(config)
  if config.gcd then
    setfenv(config.gcd, dark_addon.environment.env)
  end
  if config.combat then
    setfenv(config.combat, dark_addon.environment.env)
  end
  if config.resting then
    setfenv(config.resting, dark_addon.environment.env)
  end
  dark_addon.rotation.rotation_store[config.name .. config.spec] = config
end



if (GetLocale() == "ruRU") then
  L_LoadedProfileF = "Не найдено: "
  L_LoadedProfileS = "Загружено: "
 else
  L_LoadedProfileF = "Not found: "
  L_LoadedProfileS = "Loaded: "
 end
 

function dark_addon.rotation.load(name)
	local color = dark_addon.toolkit.CheckColor()
	local currentSpec = GetSpecialization()
	local _, SpecName, _, icon, _ = GetSpecializationInfo(currentSpec)
	local class = UnitClass('player')
  local rotation
  for _, rot in pairs(dark_addon.rotation.rotation_store) do
    if (rot.spec == dark_addon.rotation.current_spec or rot.spec == false) and rot.name == name then
      rotation = rot
    end
  end

  if rotation then
    dark_addon.settings.store('active_rotation_' .. dark_addon.rotation.current_spec, name)
    dark_addon.rotation.active_rotation = rotation
    dark_addon.interface.buttons.reset()
    if rotation.interface then
      rotation.interface(rotation)
    end
	stateval = dark_addon.settings.fetch('ssc')
   if stateval == 2 then 
		 dark_addon.log(L_LoadedProfileS .. name)
		 Splash('\n'..color..class..' - '..SpecName..' \n|cff4384D0'.."FunPay-Rotation's"..'\n|cff0e89d1')
   end
  else
    dark_addon.error(L_LoadedProfileF .. name)
  end

end
local loading_wait = false

local function init()
  if not loading_wait then
     C_Timer.After(3.3, function()
      dark_addon.rotation.current_spec = GetSpecializationInfo(GetSpecialization())
	  if dark_addon.rotation.current_spec then
		  local active_rotation = dark_addon.settings.fetch('active_rotation_' .. dark_addon.rotation.current_spec, false)
		  if active_rotation then
			dark_addon.rotation.load(active_rotation)
		  else
		  end
      end
      loading_wait = false
    end)
  end
end


dark_addon.on_ready(function()
  init()

local function lol()
	dark_addon.interface.buttons.reset()
	dark_addon.rotation.current_spec = GetSpecializationInfo(GetSpecialization())
	if dark_addon.rotation.current_spec then
		local active_rotation = dark_addon.settings.fetch('active_rotation_' .. dark_addon.rotation.current_spec, false)
		if active_rotation then
			dark_addon.rotation.load(active_rotation)
		else
		end
	end
end

dark_addon.Listener:Add('PLAYER_LOGIN', 'PLAYER_LOGIN', function() lol() end)
dark_addon.Listener:Add('PLAYER_ENTERING_WORLD', 'PLAYER_ENTERING_WORLD', function() lol() end)
dark_addon.Listener:Add('VARIABLES_LOADED', 'VARIABLES_LOADED', function() lol() end)


  loading_wait = true
end)

dark_addon.event.register("ACTIVE_TALENT_GROUP_CHANGED", function(...)
  init()
  loading_wait = true
end)

