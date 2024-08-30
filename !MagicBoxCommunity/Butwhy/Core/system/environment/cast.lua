local addon, dark_addon = ...

local lastcasted_target = nil

function _CastSpellByName(spell, target)
	local target = target or "target"
	secured = false
	while not secured do
        RunScript(
          [[
        for index = 1, 500 do
          if not issecure() then
            return
          end
        end
        CastSpellByName("]] ..
            spell .. [[", "]] .. target .. [[")
        secured = true
      ]]
        )
        if secured then
		  lastcasted_target = target
          dark_addon.console.debug(2, "cast", "red", spell .. " on " .. target)
          -- --dark_addon.interface.status(spell)
        end
      end
end

function _CastGroundSpellByName(spell, target)
  local target = target or "target"
	
	if type(spell) == 'table' then
	_spelltable = spell
	local _, name = _spelltable
		spell = name
	else
		spell = spell
	end
	
      secured = false
      while not secured do
        RunScript(
          [[
        for index = 1, 500 do
          if not issecure() then
            return
          end
        end
        C_Macro.RunMacroText("/cast [@cursor] ]] ..
            spell .. [[", 255)
        secured = true
      ]]
        )
        if secured then
          dark_addon.console.debug(2, "cast", "red", spell .. " on " .. target)
          -- --dark_addon.interface.status(spell)
        end
      end
end

local lastprint = 0

function _CastSpellByID(spell, target)
local target = target or "target"
local debug_level = dark_addon.settings.fetch('debug_level', nil)	
	if debug_level >= 5 and lastprint ~= spell then
		print(FlexIcon(spell,20,20))
		lastprint = spell
	end
      secured = false
      while not secured do
        RunScript(
          [[
          for index = 1, 500 do
            if not issecure() then
              return
            end
          end
			CastSpellByID("]] ..
            spell .. [[", "]] .. target .. [[")
          secured = true
        ]]
        )
      end
end

function _CastGroundSpellByID(spell, target)
  return _CastSpellByID(spell, target)
end

function _SpellStopCasting()
      secured = false
      while not secured do
        RunScript(
          [[
        for index = 1, 500 do
          if not issecure() then
            return
          end
        end
        SpellStopCasting()
        secured = true
      ]]
        )
      end
end

local function auto_attack()
  if not C_Spell.IsCurrentSpell(6603) then
    if dark_addon.adv_protected then
      CastSpellByID(6603)
    else
      secured = false
      while not secured do
        RunScript(
          [[
          for index = 1, 500 do
            if not issecure() then
              return
            end
          end
          CastSpellByID(6603)
          secured = true
        ]]
        )
      end
    end
  end
end

local function auto_shot()
  if not C_Spell.IsCurrentSpell(75) then
    if dark_addon.adv_protected then
      CastSpellByID(75)
    else
      secured = false
      while not secured do
        RunScript(
          [[
          for index = 1, 500 do
            if not issecure() then
              return
            end
          end
          CastSpellByID(75)
          secured = true
        ]]
        )
      end
    end
  end
end

function RunMacroText(text)
      secured = false
      while not secured do
        RunScript(
          [[
        for index = 1, 500 do
          if not issecure() then
            return
          end
        end
        C_Macro.RunMacroText("]] ..
            text .. [[", 255)
        secured = true
      ]]
        )
        if secured then
          dark_addon.console.debug(2, "macro", "red", text)
          -- --dark_addon.interface.status("Macro")
        end
      end
end

dark_addon.tmp.store("lastcast", spell)

local function is_unlocked()
  unlocked = false
  for x = 1, 2000 do
    RunScript(
      [[
      for index = 1, 100 do
        if not issecure() then
          return
        end
      end
      unlocked = true
    ]]
    )
  end
  return unlocked
end

local turbo = false

function dark_addon.environment.hooks.cast(spell, target)
  turbo = dark_addon.settings.fetch("_engine_turbo", false)
  if not dark_addon.protected then
    return
  end
  if type(target) == "table" then
    target = target.unitID
  end
  if turbo or not UnitCastingInfo("player") then
    if target == "ground" then
      if tonumber(spell) then
		local why = C_Spell.GetSpellName(spell)
        _CastGroundSpellByName(why, target)
      else
        _CastGroundSpellByName(spell, target)
      end
    else
      if tonumber(spell) then
		local why = C_Spell.GetSpellName(spell)
        _CastSpellByName(why, target)
      else
        _CastSpellByName(spell, target)
      end
    end
  end
end


function dark_addon.environment.hooks.sequenceactive(sequence)
  if sequence.active then
    return true
  end
  return false
end

function dark_addon.environment.hooks.dosequence(sequence)
  if sequence.complete then
    return false
  end
  if #sequence.spells == 0 then
    return false
  end
  return true
end

function dark_addon.environment.hooks.sequence(sequence)
  if not dark_addon.protected then
    return
  end
  if sequence.complete then
    return true
  end
  if not sequence.active then
    sequence.active = true
  end
  if not sequence.copy then
    sequence.copy = {}
    for _, value in ipairs(sequence.spells) do
      table.insert(sequence.copy, value)
    end
  end
  local lastcast = dark_addon.tmp.fetch("lastcast", false)
  local nextcast = sequence.copy[1]
  if tonumber(nextcast.spell) then
    nextcast.spell = C_Spell.GetSpellInfo(nextcast.spell)
  end
  if lastcast ~= nextcast.spell then
    _CastSpellByName(nextcast.spell, nextcast.target)
  else
    table.remove(sequence.copy, 1)
    if #sequence.copy == 0 then
      sequence.complete = true
    end
  end
end

function dark_addon.environment.hooks.resetsequence(sequence)
  if sequence.copy then
    sequence.copy = nil
    sequence.complete = false
    sequence.active = false
  end
end

function dark_addon.environment.hooks.auto_attack()
  auto_attack()
end

function dark_addon.environment.hooks.auto_shot()
  auto_shot()
end

function dark_addon.environment.hooks.stopcast()
  _SpellStopCasting()
end

function dark_addon.environment.hooks.macro(text)
  RunMacroText(text)
end


function dark_addon.environment.virtual.targets.lastcasted_target()
  return lastcasted_target
end

local timer
timer =
  C_Timer.NewTicker(
  0.5,
  function()
      if not dark_addon.adv_protected and is_unlocked() then
		stateval = dark_addon.settings.fetch('ssc')
		if stateval == 2 then 
			dark_addon.log("LUA Unlocker Found! Enabled!")
			Splash('\n'.."LUA Unlocker Found!"..'\n|cff4384D0'.."Enabled...."..'\n|cff0e89d1')
		end
        dark_addon.protected = true
        dark_addon.protect_version = "777"
        dark_addon.adv_protected = false
        dark_addon.luabox = false
        timer:Cancel()
      end
  end
)

dark_addon.event.register(
  "UNIT_SPELLCAST_SUCCEEDED",
  function(...)
    local unitID, lineID, spellID = ...
    local spell = C_Spell.GetSpellInfo(spellID)
    if unitID == "player" then
      dark_addon.tmp.store("lastcast", spell)
    end
  end
)
