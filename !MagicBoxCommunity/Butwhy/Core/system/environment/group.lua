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

function group:count(func)
  return group_count
end

local function group_match(func)
  for unit in dark_addon.environment.iterator() do
    if func(unit) then 
      return unit
    end
  end
  return false
end

function group:match(func)
  return group_match
end

local function group_buffable(spell)
  return group_match(function (unit)
    return unit.alive and unit.buff(spell).down
  end)
end

function group:buffable(spell)
  return group_buffable
end


local function group_buffexist(spell)
  return group_match(function (unit)
    return unit.alive and unit.buff(spell).up
  end)
end

function group:exists(spell)
  return group_buffexist
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

function canDispel(Unit, spellID)
	local typesList = {}
	local HasValidDispel = false
	local ClassNum = select(3, _G.UnitClass("player"))
	if ClassNum == 1 then --Warrior
		typesList = {}
	end
	if ClassNum == 2 then --Paladin
		-- Cleanse (Holy)
		if spellID == 4987 then typesList = { "Poison", "Disease", "Magic" } end
		-- Cleanse Toxins (Ret, Prot)
		if spellID == 213644 then typesList = { "Poison", "Disease" } end
	end
	if ClassNum == 3 then                                                            --Hunter
		if spellID == 19801 then typesList = { "Magic", "" } end                     --tranq shot
	end
	if ClassNum == 4 then                                                            --Rogue
		if spellID == 31224 then typesList = { "Poison", "Curse", "Disease", "Magic" } end -- Cloak of Shadows
		if spellID == 5938 then typesList = { "" } end                               --shiv
	end
	if ClassNum == 5 then                                                            --Priest
		-- Purify
		if spellID == 527 then typesList = { "Disease", "Magic" } end
		-- Mass Dispell
		if spellID == 32375 then typesList = { "Magic" } end
		-- Dispel Magic
		if spellID == 528 then typesList = { "Magic" } end
	end
	if ClassNum == 6 then --Death Knight
		typesList = {}
	end
	if ClassNum == 7 then --Shaman
		-- Cleanse Spirit
		if spellID == 51886 then typesList = { "Curse" } end
		-- Purify Spirit
		if spellID == 77130 then typesList = { "Curse", "Magic" } end
		-- Purge
		if spellID == 370 then typesList = { "Magic" } end
	end
	if ClassNum == 8 then --Mage
		-- Remove Curse
		if spellID == 475 then typesList = { "Curse" } end
	end
	if ClassNum == 9 then --Warlock
		if spellID == 19505 then typesList = { "Magic" } end
	end
	if ClassNum == 10 then --Monk
		-- Detox (MW)
		--if GetSpecialization() == 2 then
		if spellID == 115450 then typesList = { "Poison", "Disease", "Magic" } end
		-- Detox (WW or BM)
		--else
		if spellID == 218164 then typesList = { "Poison", "Disease" } end
		--end
		-- Diffuse Magic
		-- if spellID == 122783 then typesList = { "Magic" } end
	end
	if ClassNum == 11 then --Druid
		-- Remove Corruption
		if spellID == 2782 then typesList = { "Poison", "Curse" } end
		-- Nature's Cure
		if spellID == 88423 then typesList = { "Poison", "Curse", "Magic" } end
		-- Symbiosis: Cleanse
		if spellID == 122288 then typesList = { "Poison", "Disease" } end
		-- Soothe
		if spellID == 2908 then
			typesList = { "" }
		end
	end
	if ClassNum == 12 then --Demon Hunter
		-- Consume Magic
		if spellID == 278326 then typesList = { "Magic" } end
	end
	if ClassNum == 13 then -- Evoker
		-- Expunge
		if spellID == 365585 then typesList = { "Poison" } end
		-- Cauterizing Flame
		if spellID == 374251 then typesList = { "Bleed", "Poison", "Curse", "Disease" } end
		-- Naturalize
		if spellID == 360823 then typesList = { "Magic", "Poison" } end
	end

	local function ValidType(debuffType)
		local typeCheck = false
		if typesList == nil then
			typeCheck = false
		else
			for i = 1, #typesList do
				if typesList[i] == debuffType then
					typeCheck = true
					break
				end
			end
		end
		return typeCheck
	end
	local i = 1
	
	
	function GetUnitIsFriend(Unit, otherUnit)
	if not UnitIsVisible(Unit) or not UnitIsVisible(otherUnit) then return false end
		return UnitIsFriend(Unit, otherUnit)
	end	
	
	if not UnitPhaseReason(Unit) then
		if GetUnitIsFriend("player", Unit) then
			while UnitDebuff(Unit, i) do
				local _, _, stacks, debuffType, debuffDuration, debuffExpire, _, _, _, debuffid = UnitDebuff(Unit, i)
				local debuffRemain = debuffExpire - _G.GetTime()
				if (debuffType and ValidType(debuffType)) then
					return true
				end
				i = i + 1
			end
		else
			while UnitBuff(Unit, i) do
				local _, _, stacks, buffType, buffDuration, buffExpire, _, _, _, buffid = UnitBuff(Unit, i)
				local buffRemain = buffExpire - GetTime()
				if (buffType and ValidType(buffType)) and not UnitIsPlayer(Unit) then
					return true
				end
				i = i + 1
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

function group:dispellable(spell)
  return group_dispellable
end

local function group_under(percent, distance, effective)
  local count = 0
  for unit in dark_addon.environment.iterator() do
    if unit and unit.alive and ((distance and unit.distance <= distance) or not distance) and ((effective and unit.health.effective <= percent) or (not effective and unit.health.percent <= percent)) then 
      count = count + 1
    end
  end
  return count
end

function group:under(...)
  return group_under
end

function dark_addon.environment.conditions.group()
  return setmetatable({ }, {
    __index = function(t, k)
      return group[k](t)
    end
  })
end
