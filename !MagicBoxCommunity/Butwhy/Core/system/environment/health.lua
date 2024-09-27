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
	--print(self.unitID)
	local incomingheals = UnitGetIncomingHeals(self.unitID) and UnitGetIncomingHeals(self.unitID) or 0
	local PercentWithIncoming = 100 * ( UnitHealth(self.unitID) + incomingheals ) / UnitHealthMax(self.unitID)
	local ActualWithIncoming = ( UnitHealthMax(self.unitID) - ( UnitHealth(self.unitID) + incomingheals ) )
	if PercentWithIncoming and ActualWithIncoming then
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
