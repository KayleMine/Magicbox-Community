--support functions etc.
local  addon, dark_addon = ...
dark_addon.support = {}
support = dark_addon.support

support.isCC = function(target)
 for i = 1, 40 do
    local name, _, _, count, debuff_type, _, _, _, _, spell_id = UnitDebuff(target, i)
    if spell_id == nil then
      break
    end
    if name and dark_addon.rotation.CC[spell_id] then
      return true
    end
  end
  return false
end


local itemsets = {
  ["tier_t30_priest"] = { 202543, 202541 },
  ["tier_t29_priest"] = { 202543, 202541 },
}

support.checkforSet = function(tier)
  local set = itemsets[tier]
  if not set then
    return false
  end
  local count = 0
  for _, v in ipairs(set) do
    if IsEquippedItem(v) then
      count = count + 1
    end
  end
  return count
end

support.W_Enchant = function(enchantId)
    local hasEnchant = false
    local _, _, _, mainEnchantId, _, _, _, offEnchantId = GetWeaponEnchantInfo()
    if mainEnchantId == enchantId or offEnchantId == enchantId then
        hasEnchant = true
    end
    return hasEnchant
end
support.t_check = function(itemID)
    for i = 13, 14 do -- iterate over trinket slots
        local itemLink = GetInventoryItemLink("player", i)
        if itemLink and tonumber(string.match(itemLink, "item:(%d+)")) == itemID then
            local startTime, duration, isEnabled = GetItemCooldown(itemLink)
            if duration > 0 then
                local remainingTime = duration - (GetTime() - startTime)
                return i, remainingTime, false -- return slot number, remaining cooldown time, and false (on cooldown)
            else
                return i, 0, true -- return slot number, 0 (no cooldown), and true (ready to use)
            end
        end
    end
    return nil, nil, nil -- return nil if trinket is not equipped
end

support.GroupType = function()
  return IsInRaid() and "raid" or IsInGroup() and "party" or "solo"
end

support.getTanks = function()
  local tank1 = nil
  local tank2 = nil

  local group_type = support.GroupType()
  local members = GetNumGroupMembers()
  for i = 1, (members - 1) do
    local unit = group_type .. i
    if (UnitGroupRolesAssigned(unit) == "TANK") and not UnitCanAttack("player", unit) and not UnitIsDeadOrGhost(unit) then
      if tank1 == nil then
        tank1 = unit
      elseif tank2 == nil then
        tank2 = unit
        break
      end
    end
  end
  --print("The two tanks are: " .. tank1.name .. ", " .. tank2.name)
  if tank1 ~= nil then
    tank1 = dark_addon.environment.conditions.unit(tank1)
  end
  if tank2 ~= nil then
    tank2 = dark_addon.environment.conditions.unit(tank2)
  end
  return tank1, tank2
end
 
support.castGroupBuff = function(buff, min)
  local count = 0
  local group_type = support.GroupType()
  local members = GetNumGroupMembers()
  if group_type == "solo" then
    return min == 1 and not hasBuff("player", buff)
  end
  for i = 1, (members - 1) do
    if not hasBuff(group_type .. i, buff) then
      count = count + 1
      if (count >= min) then
        return true
      end
    end
  end
  return false
end


support.iknow = function(spellID)
    local isKnown = IsPlayerSpell(spellID, isPetSpell)
    local IsSpellKnown = IsSpellKnown(spellID, isPetSpell)
    local talent = dark_addon.rotation.allTalents[spellID]
    local isTalentActive = talent and talent.active or false

    if isKnown or IsSpellKnown or isTalentActive then
        return true 
    else 
        return false 
    end
end

support.talentRank = function(talentID)
    local talent = dark_addon.rotation.allTalents[talentID]
    local rank = talent and talent.rank or 0
    return rank
end


support.name = function(spell)
spell = select(1, C_Spell.GetSpellInfo(spell).name)
	return spell
end

local moveTime = 0
local moving = false
local duration = 0

support.GetMovementDuration = function()
 if player.moving then
        if not moving then
            moving = true
            moveTime = GetTime()
        end
        duration = math.floor((GetTime() - moveTime) * 10) / 10 -- duration in seconds, rounded to 1 decimal place
    else
        if moving then
            moving = false
            local result = duration
            duration = 0
            return result
        end
    end
    return duration
end

support.lowest_target = function()
if lowest.alive then
	return lowest.unitID
end
end


local group = dark_addon.environment.conditions.group()

-- Generalized function to collect units based on a condition
-- Generalized function to collect units based on a condition
local function collect_units(spell, condition)
  local units = {}
  for unit in dark_addon.environment.iterator() do
    if not dark_addon.is_blacklisted(unit.unitID) and unit and unit.alive and condition(unit, spell) then
      table.insert(units, unit)
    end
  end
  return units
end

-- Conditions for buff/debuff checks
local function is_buffable(unit, spell)
  return unit.buff(spell).down
end

local function is_buffed(unit, spell)
  return unit.buff(spell).up
end

local function is_debuffed(unit, spell)
  return unit.debuff(spell).up
end

-- Group functions using the generalized unit collection
function group:buffable_units(spell)
  return collect_units(spell, is_buffable)
end

function group:buffed_units(spell)
  return collect_units(spell, is_buffed)
end

function group:debuffed_units(spell)
  return collect_units(spell, is_debuffed)
end

-- Support table functions
support.buffable_table = function(spell)
  return group:buffable_units(spell)
end

support.buffed_table = function(spell)
  return group:buffed_units(spell)
end

support.debuffed_table = function(spell)
  return group:debuffed_units(spell)
end


support.CreateMacro = function(macroName, macroCommand)
    if GetMacroIndexByName(macroName) == 0 then
        CreateMacro(macroName, "INV_MISC_QUESTIONMARK", macroCommand, 1)
    end
end

for _, func in pairs(support) do
    setfenv(func, dark_addon.environment.env)
end
