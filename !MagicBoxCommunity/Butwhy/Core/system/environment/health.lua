local addon, dark_addon = ...

local health = { }

function health:percent()
  return UnitHealth(self.unitID) / UnitHealthMax(self.unitID) * 100
end

function health:actual()
  return UnitHealth(self.unitID)
end

function health:effective()
  return (UnitHealth(self.unitID) + (UnitGetIncomingHeals(self.unitID) or 0)) / UnitHealthMax(self.unitID) * 100
end

function health:incoming()
  return UnitGetIncomingHeals(self.unitID) or 0
end

function health:missing()
  return (UnitHealthMax(self.unitID) - UnitHealth(self.unitID))/UnitHealthMax(self.unitID) * 100
end


function health:percent_plus_incomingHeal()
	local incomingheals = UnitGetIncomingHeals(self.unitID) and UnitGetIncomingHeals(self.unitID) or 0
	local PercentWithIncoming = 100 * ( UnitHealth(self.unitID) + incomingheals ) / UnitHealthMax(self.unitID)
	local ActualWithIncoming = ( UnitHealthMax(self.unitID) - ( UnitHealth(self.unitID) + incomingheals ) )
	if PercentWithIncoming and ActualWithIncoming then
		return PercentWithIncoming
	else
		return 100
	end
end

function health:percent_plus_shields()
    local totalAbsorbs = UnitGetTotalAbsorbs(self.unitID) or 0
    local currentHealth = UnitHealth(self.unitID)
    local maxHealth = UnitHealthMax(self.unitID)

    local effectiveHealth = currentHealth + totalAbsorbs
    local PercentWithIncoming = 100 * effectiveHealth / maxHealth

    if PercentWithIncoming then
        return PercentWithIncoming
    else
        return 100
    end
end

function health:percent_plus_incomingHeal_shields()
    local incomingheals = UnitGetIncomingHeals(self.unitID) or 0
    local totalAbsorbs = UnitGetTotalAbsorbs(self.unitID) or 0
    local currentHealth = UnitHealth(self.unitID)
    local maxHealth = UnitHealthMax(self.unitID)

    local effectiveHealth = currentHealth + incomingheals + totalAbsorbs
    local PercentWithIncoming = 100 * effectiveHealth / maxHealth

    if PercentWithIncoming then
        return PercentWithIncoming
    else
        return 100
    end
end

function dark_addon.environment.conditions.health(unit, called)
  return setmetatable({
    unitID = unit.unitID
  }, {
    __index = function(t, k)
      return health[k](t)
    end,
    __unm = function(t)
      return health['percent'](t)
    end
  })
end
