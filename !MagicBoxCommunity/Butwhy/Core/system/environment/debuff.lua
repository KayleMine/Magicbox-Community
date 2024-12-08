local addon, dark_addon = ...
local _damagePerTick, _tickInterval = 0,0
local UnitDebuff = dark_addon.environment.unit_debuff

local debuff = { }

function debuff:exists()
  local debuff, count, duration, expires, caster, id = UnitDebuff(self.unitID, self.spell, 'any')
  if id == self.spell and (not self.casterCheck and (caster == 'player' or caster == 'pet')) then
    return true
  end
  return false
end

function debuff:down()
  return not self.exists
end

function debuff:up()
  return self.exists
end

function debuff:any()
  local debuff, count, duration, expires, caster = UnitDebuff(self.unitID, self.spell, 'any')
  if debuff then
    return true
  end
  return false
end

function debuff:count()
  local debuff, count, duration, expires, caster, id  = UnitDebuff(self.unitID, self.spell, 'any')
  if id == self.spell and (not self.casterCheck and (caster == 'player' or caster == 'pet')) then
    return count
  end
  return 0
end

function debuff:remains()
  local debuff, count, duration, expires, caster, id = UnitDebuff(self.unitID, self.spell, 'any')
  if id == self.spell and (not self.casterCheck and (caster == 'player' or caster == 'pet')) then
    return expires - GetTime()
  end
  return 0
end

function debuff:duration()
  local debuff, count, duration, expires, caster = UnitDebuff(self.unitID, self.spell, 'any')
  if debuff and (not self.casterCheck and (caster == 'player' or caster == 'pet')) then
    return duration
  end
  return 0
end




local _self = {}

local function _remains()
    local _, _, _, expires, caster, id = UnitDebuff(_self.unitID, _self.spell, 'any')
    if id == _self.spell and (caster == 'player' or caster == 'pet') then
        return expires - GetTime()
    end
    return 0
end

local function _duration()
    local _, _, duration, _, caster = UnitDebuff(_self.unitID, _self.spell, 'any')
    if duration and (caster == 'player' or caster == 'pet') then
        return duration
    end
    return 0
end


local function debuff_text(unitID, spell)
    local index = 1
    while true do
        local aura = C_TooltipInfo.GetUnitAura(unitID, index, 'HARMFUL')
        if not aura then break end

        if aura.id == spell then
            local descriptionLine = aura.lines[2]
            if descriptionLine then
                for k, v in pairs(descriptionLine) do
                    if k == 'leftText' then
                        local numbers = {}
                        for num in v:gmatch("%d+[%.,]?%d*") do
                            num = num:gsub(",", ".")
                            table.insert(numbers, tonumber(num))
                        end

                        local damage = #numbers >= 1 and numbers[1] or nil
                        local interval = #numbers >= 2 and numbers[2] or nil

                        return v, damage, interval
                    end
                end
            end
        end

        index = index + 1
    end
end

local function updateDebuffData()
    local _, damage, interval = debuff_text(_self.unitID, _self.spell)
    if damage and interval then
        _damagePerTick = damage
        _tickInterval = interval
    else
        _damagePerTick = 0
        _tickInterval = 0
    end
end

function debuff:totalTicks()
    updateDebuffData()
    local dur = _duration()
    if dur > 0 and _tickInterval and _tickInterval > 0 then
        return math.floor(dur / _tickInterval)
    end
    return 0
end

function debuff:ticksDone()
    updateDebuffData()
    local remain = _remains()
    local dur = _duration()
    if dur > 0 and _tickInterval and _tickInterval > 0 then
        local done = math.floor((dur - remain) / _tickInterval)
        return (done >= 0) and done or 0
    end
    return 0
end

function debuff:ticksRemaining()
    return self.totalTicks - self.ticksDone
end

function debuff:getDamagePerTick()
    return _damagePerTick or 0
end

function debuff:tickPer()
    return _tickInterval or 0
end

function debuff:totalDamage()
    return self.totalTicks * self.getDamagePerTick
end

function debuff:damageDone()
    return self.ticksDone * self.getDamagePerTick
end

function debuff:damageRemaining()
    return self.totalDamage - self.damageDone
end

function dark_addon.environment.conditions.debuff(unit)
  return setmetatable({
    unitID = unit.unitID
  }, {
    __index = function(t, k)
      local result = debuff[k](t)
      dark_addon.console.debug(4, 'debuff', 'teal', t.unitID .. '.debuff(' .. t.spell .. ').' .. k .. ' = ' .. dark_addon.format(result))
      return result
    end,
    __call = function(t, k)
      t.spell = k
      if tonumber(t.spell) then
		t.spell = C_Spell.GetSpellInfo(t.spell).spellID
      end
		if type(bool) == 'boolean' then
		t.casterCheck = bool or false
	  else
		t.casterCheck = false -- uh, retard moment (._.)
	  end
	  _self.spell = t.spell
	  _self.unitID = t.unitID
      return t
    end,

    __unm = function(t)
      local result = debuff['exists'](t)
      dark_addon.console.debug(4, 'debuff', 'teal', t.unitID .. '.debuff(' .. t.spell .. ').exists = ' .. dark_addon.format(result))
      return debuff['exists'](t)
    end
  })
end