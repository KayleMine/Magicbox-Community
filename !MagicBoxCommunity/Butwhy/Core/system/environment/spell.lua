local addon, dark_addon = ...
local IsUsableSpell = C_Spell.IsSpellUsable
local GetSpellCharges = C_Spell.GetSpellCharges
local spell = { }

function spell:cooldown()
	_table = C_Spell.GetSpellCooldown(self.spell.spellID)
	if not _table then return 0 end
	local time, value = _table.startTime,  _table.duration, _table.isEnabled
  if not time or time == 0 then
    return 0
  end
  local cd = time + value - GetTime()
  if cd > 0 and not dark_addon.settings.fetch('_engine_turbo', false) then
    return cd
  else
    return 0
  end
end


function spell:icon() 
  local textureA, textureB = C_Spell.GetSpellTexture(self.spell.spellID)
  return textureA ~= textureB
end


function spell:cooldown_duration()
  local haste_mod = 1 + UnitSpellHaste("player") / 100
  local cooldown_ms, gcd_ms = GetSpellBaseCooldown(self.spell.spellID)
  return (cooldown_ms / haste_mod ) / 1000
end

function spell:exists()
  return IsPlayerSpell(self.spell.spellID)
end

function spell:casting_remains()
  local casting_name, _, _, _, casting_end_time = UnitCastingInfo(self.unitID)
  local channel_name, _, _, _, channel_end_time = UnitChannelInfo(self.unitID)
  if casting_name == self.spell.spellID then return casting_end_time / 1000 - GetTime() end
  if channel_name == self.spell.spellID then return channel_end_time / 1000 - GetTime() end
  return 0
end

function spell:castingtime()
  local name =  C_Spell.GetSpellInfo(self.spell.spellID).name
  local castingTime = C_Spell.GetSpellInfo(self.spell.spellID).castTime
  if name and castingTime then
    return castingTime / 1000
  end
  return 9999
end

function spell:charges()
  return GetSpellCharges(self.spell.spellID).currentCharges or 0
end

local syncTime
local lastSync


function spell:fractionalcharges()
  local _table  = GetSpellCharges(self.spell.spellID)
  local currentCharges, maxCharges, Start, Duration = _table.currentCharges, _table.maxCharges, _table.cooldownStartTime, _table.cooldownDuration

  local currentSync = GetTime() - Start
  if syncTime == nil then
    syncTime = currentSync
    lastSync = Start
  elseif Start ~= lastSync then
    syncTime = currentSync
    lastSync = Start
  end
  local syncedTime = GetTime() - syncTime
  local currentChargesFraction = (syncedTime - Start) / Duration
  local fractionalCharges = math.floor((currentCharges + currentChargesFraction)*100)/100
  if fractionalCharges > maxCharges then
    return maxCharges
  else
    return fractionalCharges
  end
end

function spell:recharge()
  local _table  = GetSpellCharges(self.spell.spellID)
  local Charges, MaxCharges, CDTime, CDValue = _table.currentCharges, _table.maxCharges, _table.cooldownStartTime, _table.cooldownDuration
  
  if Charges == MaxCharges then
    return 0;
  end
  local CD = CDTime + CDValue - GetTime()
  if CD > 0 then
    return CD;
  else
    return 0;
  end
end

function spell:recharge_duration()
  local current_charges, max_charges, cooldown_start, cooldown_duration = GetSpellCharges(self.spell.spellID)
  return cooldown_duration
end

function spell:full_recharge_time()
  local current_charges, max_charges, cooldown_start, cooldown_duration = GetSpellCharges(self.spell.spellID)
  if not current_charges then return 0 end
  local diff = max_charges - current_charges
  if not current_charges or diff == 0 then return 0 end
  return cooldown_start + cooldown_duration * diff - GetTime()
end

function spell:lastcast()
  local lastcast = dark_addon.tmp.fetch('lastcast', false)
  return lastcast == self.spell.spellID
end

function spell:castable()
  local usable, noMana = C_Spell.IsSpellUsable(self.spell.spellID)
  if usable then
    if self.cooldown == 0 then
      return true
    else
      return false
    end
  end
  return false
end

function spell:current()
  local casting, _ = UnitCastingInfo(self.unitID)
  local channel, _ = UnitChannelInfo(self.unitID)
  if casting then return self.spell.spellID == casting end
  if channel then return self.spell.spellID == channel end
  return false
end

function dark_addon.environment.conditions.spell(unit)
  return setmetatable({
    unitID = unit.unitID
  }, {
    __index = function(t, k)
      if t.unitID then
        local result = spell[k](t)
        local spellName = t.spell and (type(t.spell) == "table" and t.spell.name or tostring(t.spell)) or "nil"
        dark_addon.console.debug(4, 'spell', 'indigo', t.unitID .. '.spell(' .. spellName .. ').' .. k .. ' = ' .. dark_addon.format(result))
        return result
      end
      return false
    end,
    __call = function(t, k)
      t.spell = k
      if tonumber(t.spell) then
        t.spell = C_Spell.GetSpellInfo(t.spell)
      end
      return t
    end,
    __unm = function(t)
      local result = spell['cooldown'](t)
      local spellName = t.spell and (type(t.spell) == "table" and t.spell.name or tostring(t.spell)) or "nil"
      dark_addon.console.debug(4, 'spell', 'indigo', t.unitID .. '.spell(' .. spellName .. ').cooldown = ' .. dark_addon.format(result))
      return result
    end
  })
end
