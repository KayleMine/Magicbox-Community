local addon, dark_addon = ...
local UnitReverseDebuff = dark_addon.environment.unit_reverse_debuff

local group = { }

local function group_count(func)
  local count = 0
  for unit in dark_addon.environment.iterator() do
    if func(unit) then 
      count = count + 1
    end
  end
  return count
end

function group.count(func)
  return group_count(func)
end

local function group_match(func)
  for unit in dark_addon.environment.iterator() do
    if func(unit) then 
      return unit
    end
  end
  return false
end

function group.match(func)
  return group_match(func)
end

local function group_buffable(spell)
  return group_match(function (unit)
    return unit.alive and unit.buff(spell).down
  end)
end

function group.buffable(spell)
  return group_buffable(spell)
end


local function group_buffexist(spell)
  return group_match(function (unit)
    return unit.alive and unit.buff(spell).up
  end)
end

function group.exists(spell)
  return group_buffexist(spell)
end

local function check_removable(removable_type)
  return group_match(function (unit)
    local debuff, count, duration, expires, caster, found_debuff = UnitReverseDebuff(unit.unitID, dark_addon.data.removables[removable_type])
    return debuff and (count == 0 or count >= found_debuff.count) and unit.health.percent <= found_debuff.health
  end)
end

local function group_removable(...)
  for i = 1, select('#', ...) do
    local removable_type, _ = select(i, ...)
    if dark_addon.data.removables[removable_type] then
      local possible_unit = check_removable(removable_type)
      if possible_unit then
        return possible_unit
      end
    end
  end
  return false
end

function group:removable(...)
  return group_removable
end

 
 
local dispel_spell = {
    [4987] = {"Magic" }, --  "Poison", "Disease", 
    [213644] = { "Poison", "Disease" },
    [19801] = { "Magic" },
    [31224] = { "Poison", "Curse", "Disease", "Magic" },
    [527] = { "Magic" }, --  "Disease", 
    [32375] = { "Magic" },
    [528] = { "Magic" },
    [51886] = { "Curse" },
    [77130] = {"Magic" },-- "Curse", 
    [370] = { "Magic" },
    [475] = { "Curse" },
    [19505] = { "Magic" },
    [115450] = { "Magic" }, -- "Poison", "Disease", 
    [218164] = { "Poison", "Disease" },
    [2782] = { "Poison", "Curse" },
    [88423] = { "Magic" }, -- "Poison", "Curse", 
    [122288] = { "Poison", "Disease" },
    [365585] = { "Poison" },
    [374251] = { "Bleed", "Poison", "Curse", "Disease" },
    [360823] = { "Magic", "Poison" },
    [278326] = { "Magic" }
}


local forbiddenDebuffs = {
	[426736] = true,
	[451224] = true,
	[450095] = true,
	[442437] = true,
	[443305] = true,
}
    
local function ValidType(debuffType, spellID)
	local typesList = dispel_spell[spellID]
	if not typesList then return false end
	for _, validType in ipairs(typesList) do
		if validType == debuffType then
			return true
		end
	end
	return false
end
	
local function canDispel(Unit, spellID)
    local isFriend = UnitIsFriend(Unit, 'player')
    if isFriend then
        for i = 1, 40 do
            local debuffType = C_UnitAuras.GetDebuffDataByIndex( Unit, i)
			
			if not debuffType then break end
			local dispelName = debuffType.dispelName
			local sid = debuffType.spellId
            if forbiddenDebuffs[sid] then break end
            if ValidType(dispelName, spellID) or tonumber(sid) == 440313 then
                return true
            end
        end
	end
    return false
end


local function group_dispellable(spell)
  return group_match(function (unit)
    return canDispel(unit.unitID, spell)
  end)
end

function group.dispellable(spell)
  return group_dispellable(spell)
end



function percent_plus_incomingHeal(unitID)
	--print(unitID)
	local incomingheals = UnitGetIncomingHeals(unitID) and UnitGetIncomingHeals(unitID) or 0
	local PercentWithIncoming = 100 * ( UnitHealth(unitID) + incomingheals ) / UnitHealthMax(unitID)
	local ActualWithIncoming = ( UnitHealthMax(unitID) - ( UnitHealth(unitID) + incomingheals ) )
	if PercentWithIncoming and ActualWithIncoming then
		return PercentWithIncoming
	else
		return 100
	end	
end
 
local function group_under(percent, distance, effective)
  local count = 0
  for unit in dark_addon.environment.iterator() do
    if unit then
		if unit.alive and 
		  ((distance and unit.unitID ~= 'player' and UnitInRange(unit.unitID)) or not distance or unit.unitID == 'player') and 
		  ((effective and unit.health.effective < percent) or (not effective and unit.health.percent < percent)) then 
		  count = count + 1
		end
    end
  end
  return count
end

function group.under(percent, distance, effective)
  return group_under(percent, distance, effective)
end

function dark_addon.environment.conditions.group()
  return setmetatable({}, {
    __index = function(_, k)
      return group[k]
    end
  })
end

