local addon, dark_addon = ...

dark_addon.environment.virtual = {
  targets = {},
  resolvers = {},
  resolved = {},
  exclude_tanks = true
}

local function GroupType()
  return IsInRaid() and 'raid' or IsInGroup() and 'party' or 'solo'
end

function dark_addon.environment.virtual.validate(virtualID)
  if dark_addon.environment.virtual.targets[virtualID] or virtualID == 'group' then
    return true
  end
  return false
end

function dark_addon.environment.virtual.resolve(virtualID)
  if virtualID == 'group' then
    return 'group', 'group'
  else
    return dark_addon.environment.virtual.resolved[virtualID], 'unit'
  end
end

function dark_addon.environment.virtual.targets.lowest()
  local members = GetNumGroupMembers()
  local group_type = GroupType()
  if dark_addon.environment.virtual.resolvers[group_type] then
    return dark_addon.environment.virtual.resolvers[group_type](members)
  end
end

function dark_addon.environment.virtual.targets.tank()
  return dark_addon.environment.virtual.resolvers.tanks('MAINTANK')
end

function dark_addon.environment.virtual.targets.offtank()
  return dark_addon.environment.virtual.resolvers.tanks('MAINASSIST')
end

function dark_addon.environment.virtual.resolvers.unit(unitA, unitB)
  local healthA = UnitHealth(unitA) / UnitHealthMax(unitA) * 100
  local healthB = UnitHealth(unitB) / UnitHealthMax(unitB) * 100
  if healthA < healthB then
    return unitA, healthA
  else
    return unitB, healthB
  end
end
	

if not tLOS then tLOS = {} end
dark_addon.LoS_updateRate = 3;
local updateRate = dark_addon.LoS_updateRate
local currentTarget;

-- LineOfSight function definition
function LineOfSight(target)
currentTarget = target
    if #tLOS > 0 then
        if tLOS[1].unit == target then
            -- Return true if target is in LoS
            return true
        end
    end
    return false
end
function cLineOfSight(target)
    if #tLOS > 0 then
        if tLOS[1].unit == target then
            -- Return true if target is in LoS
            return true
        end
    end
    return false
end

local function fLOSOnEvent(event, spellFailed, errorMessage, unit)
            if spellFailed == SPELL_FAILED_LINE_OF_SIGHT or
               spellFailed == SPELL_FAILED_NOT_INFRONT or
               spellFailed == SPELL_FAILED_OUT_OF_RANGE or
               spellFailed == SPELL_FAILED_UNIT_NOT_INFRONT or
               spellFailed == SPELL_FAILED_UNIT_NOT_BEHIND or
               spellFailed == SPELL_FAILED_NOT_BEHIND or
               spellFailed == SPELL_FAILED_MOVING or
               spellFailed == SPELL_FAILED_IMMUNE or
               spellFailed == SPELL_FAILED_FLEEING or
               spellFailed == SPELL_FAILED_BAD_TARGETS or
               spellFailed == SPELL_FAILED_STUNNED or
               spellFailed == SPELL_FAILED_SILENCED or
               spellFailed == SPELL_FAILED_NOT_IN_CONTROL or
               spellFailed == SPELL_FAILED_VISION_OBSCURED or
               spellFailed == SPELL_FAILED_DAMAGE_IMMUNE or
               spellFailed == SPELL_FAILED_CHARMED then
 
			if currentTarget then
				tLOS = {}
				tinsert(tLOS, {unit = currentTarget, time = GetTime()})
			end
            end
end

local function cleanLOSTable()
    if #tLOS > 0 then
        local currentTime = GetTime()
        for i = #tLOS, 1, -1 do
            if (currentTime > tLOS[i].time + updateRate) then
                table.remove(tLOS, i) 
            end
        end
    end
end

C_Timer.NewTicker(3, function() -- uh eh umm
    cleanLOSTable()
end)

dark_addon.Listener:Add("FacingCheck", "UI_ERROR_MESSAGE", function(...)
    fLOSOnEvent(...)
end)


dark_addon.LineOfSight = LineOfSight;
dark_addon.LoS = cLineOfSight;

 
function dark_addon.environment.virtual.resolvers.party(members)
  local lowest = 'player'
  local lowest_health
  for i = 1, (members - 1) do
    local unit = 'party' .. i
 
		if not UnitCanAttack('player', unit) and UnitIsVisible(unit) and UnitIsConnected(unit) and UnitInRange(unit) and not UnitIsDeadOrGhost(unit) and not cLineOfSight(unit)
			and (not dark_addon.environment.virtual.exclude_tanks or not dark_addon.environment.virtual.resolvers.tank(unit)) then
		  if not lowest then
			lowest, lowest_health = dark_addon.environment.virtual.resolvers.unit(unit, 'player')
		  else
			lowest, lowest_health = dark_addon.environment.virtual.resolvers.unit(unit, lowest)
		  end
		end
 
  end
  return lowest
end

function dark_addon.environment.virtual.resolvers.raid(members)
  local lowest = 'player'
  local lowest_health
  for i = 1, members do
    local unit = 'raid' .. i

	if not UnitCanAttack('player', unit) and UnitIsVisible(unit) and UnitIsConnected(unit) and UnitInRange(unit) and not UnitIsDeadOrGhost(unit) and not cLineOfSight(unit)
		and (not dark_addon.environment.virtual.exclude_tanks or not dark_addon.environment.virtual.resolvers.tank(unit)) then
      if not lowest then
        lowest, lowest_health = unit, UnitHealth(unit)
      else
        lowest, lowest_health = dark_addon.environment.virtual.resolvers.unit(unit, lowest)
      end
    end


 return lowest
end
end

function dark_addon.environment.virtual.resolvers.tank(unit)
  return GetPartyAssignment('MAINTANK', unit) or GetPartyAssignment('MAINASSIST', unit) or UnitGroupRolesAssigned(unit) == 'TANK'
end

function dark_addon.environment.virtual.resolvers.tanks(assignment)
  local members = GetNumGroupMembers()
  local group_type = GroupType()
  if UnitExists('focus') and UnitIsVisible(unit) and UnitIsConnected(unit) and not UnitCanAttack('player', 'focus') and not UnitIsDeadOrGhost('focus') and assignment == 'MAINTANK' then
    return 'focus'
  end
  if group_type ~= 'solo' then
    for i = 1, (members - 1) do
      local unit = group_type .. i
      if (GetPartyAssignment(assignment, unit) or (assignment == 'MAINTANK' and UnitGroupRolesAssigned(unit) == 'TANK')) and not UnitCanAttack('player', unit) and not UnitIsDeadOrGhost(unit) then return unit end
    end
  end
  return 'player'
end

function dark_addon.environment.virtual.resolvers.solo()
  return 'player'
end

dark_addon.on_ready(function()
  C_Timer.NewTicker(0.1, function()
    for target, callback in pairs(dark_addon.environment.virtual.targets) do
      dark_addon.environment.virtual.resolved[target] = callback()
    end
  end)
end)

	
