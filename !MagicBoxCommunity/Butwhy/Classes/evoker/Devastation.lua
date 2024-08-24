local  addon, dark_addon = ...
local support = dark_addon.support
local SB             = {}
local FBLevel = 999

SB.FireBreath        = 357208

local EventFrame = _G.CreateFrame("Frame")
local _empower = 0
local slot = 0

function place_spell(spellID)
    local foundSlot = nil
    local spellAlreadyOnBar = false

    for slot = 1, 120 do
        local actionType, id = GetActionInfo(slot)

        if actionType == "spell" then
            if id == spellID then
                spellAlreadyOnBar = true
                foundSlot = slot
                break
            end
        elseif not actionType then
            foundSlot = slot
            break
        end
    end

    if spellAlreadyOnBar then
        return foundSlot
    end

    if not foundSlot then
        for slot = 1, 120 do
            local actionType, id = GetActionInfo(slot)

            if not actionType then
                foundSlot = slot
                break
            end
        end
    end

    if foundSlot then
        PickupSpell(spellID)
        PlaceAction(foundSlot)
    end

    return foundSlot
end

function use_spell_from_slot(slot)
    UseAction(slot)
end

EventFrame:RegisterEvent("UNIT_SPELLCAST_EMPOWER_START")
EventFrame:RegisterEvent("UNIT_SPELLCAST_EMPOWER_STOP")
EventFrame:RegisterEvent("UNIT_SPELLCAST_EMPOWER_UPDATE")
local empowerID = 0
local function onEvent(self, event, ...)
	if event == "UNIT_SPELLCAST_EMPOWER_START" then
			local SourceUnit = select(1, ...)
			local SpellID = select(3, ...)
			if SourceUnit == "player" then
				empowerID = SpellID
			end
		end
		if event == "UNIT_SPELLCAST_EMPOWER_STOP" then
			local SourceUnit = select(1, ...)
			local SpellID = select(3, ...)
			if SourceUnit == "player" then
				--print("Channel STOP")
				_empower = 0
				empowerID = 0
			end
		end
		if event == "UNIT_SPELLCAST_EMPOWER_UPDATE" then
			local SourceUnit = select(1, ...)
			local SpellID = select(3, ...)
			if SourceUnit == "player" then
				--print("Channel UP")
				empowerID = SpellID
			end
		end
		
end
EventFrame:SetScript("OnEvent", onEvent)


local maxStage = 0
function getEmpoweredRank(spellID)
	local stage = 0
	if empowerID and spellID == empowerID then
		local _, _, _, startTime, _, _, _, _, _, totalStages = _G.UnitChannelInfo("player")
		if totalStages and totalStages > 0 then
			maxStage = totalStages
			startTime = startTime / 1000 -- Doing this here so we don't divide by 1000 every loop index
			local currentTime = _G.GetTime() -- If you really want to get time each loop, go for it. But the time difference will be miniscule for a single frame loop
			local stageDuration = 0
			for i = 1, totalStages do
				stageDuration = stageDuration + _G.GetUnitEmpowerStageDuration("player", i-1) / 1000
				if startTime + stageDuration > currentTime then
				 	break -- Break early so we don't keep checking, we haven't hit this stage yet
				end
				stage = i
			end
		end
		if totalStages == nil then
			stage = maxStage
		end
	end
    return stage
end



local function empower(id, val) 
	if getEmpoweredRank(id) >= val then
			local actionSlot = place_spell(id)
			if actionSlot then
				use_spell_from_slot(actionSlot)
			end	
	end
end


local function cast_dragon(spell)
local actionSlot = place_spell(spell)
	if actionSlot then
		use_spell_from_slot(actionSlot)
	end	
end

local function combat()

if target.alive and (castable(SB.FireBreath) or empower(SB.FireBreath, 3)) then
	cast_dragon(SB.FireBreath)
	return true
end

end
 
 

local function resting()
 
end

dark_addon.rotation.register({
spec = dark_addon.rotation.classes.evoker.devastation,
name = 'evo',
label = 'huevo',
combat = combat,
resting = resting,
interface = interface
})
