local addon, dark_addon = ...

local GetSpellInfo = C_Spell.GetSpellInfo

dark_addon.rotation.timer = {
  lag = 0
}

local gcd_spell = 61304
local gcd_spell_name = GetSpellInfo(61304)

local last_loading = GetTime()
local loading_wait = math.random(120, 300)
local last_duration = false
local lastLag = 0
local castclip = 0
local turbo = false


local function cstng()
    if UnitCastingInfo('player') or UnitChannelInfo('player') then
        return true
    end
    return false
end


local function getValidPotion(Potion_Items)
	for _, item in ipairs(Potion_Items) do
		--print(item)
		if GetItemCount( item, false ) > 0 and GetItemCooldown(item) == 0  then 
			--print(item, 'pass')
			return item 
		end
	end
end

local function iknow(spellID)
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

local function items()
	if player.buff(255274).up then return end
	if player.buff(27827).up then return end
	local Trinket13 = GetInventoryItemID("player", 13)
	local Trinket14 = GetInventoryItemID("player", 14)
	local ring1 = GetInventoryItemID("player", 11)
	local ring2 = GetInventoryItemID("player", 12)
	local Trinkets_k = dark_addon.settings.fetch("global_settings_Trinkets_k")
	local Rings_k = dark_addon.settings.fetch("global_settings_Rings_k")
	local isEquipped13 = GetInventoryItemID("player", 13)
	local isEquipped14 = GetInventoryItemID("player", 14)

	local isEquipped11 = GetInventoryItemID("player", 11)
	local isEquipped12 = GetInventoryItemID("player", 12)
	local hands = GetInventoryItemID("player", 10)

	local WarlockFood_Check			= dark_addon.settings.fetch("global_settings_WarlockFood.check", false)
	local WarlockFood_Spin	        = dark_addon.settings.fetch("global_settings_WarlockFood.spin", 85)

	if WarlockFood_Check and player.alive then
		if player.health.percent <= WarlockFood_Spin and GetItemCount(5512) >= 1 and GetItemCooldown(5512) == 0 then
			macro("/use item:5512")
		end
	end



	local PotionsMana_Check				= dark_addon.settings.fetch("global_settings_PotionsMana.check", false)
	local PotionsMana_Spin	        	= dark_addon.settings.fetch("global_settings_PotionsMana.spin", 55)

	local PotionsHealth_Check			= dark_addon.settings.fetch("global_settings_PotionsHealth.check", false)
	local PotionsHealth_Spin	        = dark_addon.settings.fetch("global_settings_PotionsHealth.spin", 85)

	local ManaPotions = { 212241, 212240, 212239, 212244, 212243, 212242, 191384 }
	local HealthPotions = { 211880, 212244, 212243, 212242, 191378, 211879, 211878 } --wowhead
	--print(PotionsHealth_Check)

	if PotionsHealth_Check and player.alive then
	local currentHealthPercent = player.health.percent
	--print(currentHealthPercent)
	--print(PotionsHealth_Spin)
	if currentHealthPercent <= PotionsHealth_Spin then
		local potion = getValidPotion(HealthPotions)
			if potion then
				local _, cooldown = GetItemCooldown(potion)
				if cooldown == 0 then
					macro('/use item:' .. potion)
				end
			end
		end
	end
	if PotionsMana_Check and player.alive then
		local currentManaPercent = player.power.mana.percent
		if currentManaPercent <= PotionsMana_Spin then
			local potion = getValidPotion(ManaPotions)
			if potion then
				local _, cooldown = GetItemCooldown(potion)
				if cooldown == 0 then
				macro('/use item:' .. potion)
				end
			end
		end
	end


	if UnitAffectingCombat("player") and not cstng() and target.exists and target.alive and target.enemy then
	if toggle('cooldowns', false) then
	if Trinkets_k == 'ot' then
		if isEquipped13 ~= nil and GetItemCooldown(Trinket13) == 0 then
			macro('/use 13')
		end

		if isEquipped14 ~= nil and GetItemCooldown(Trinket14) == 0 then
			macro('/use 14')
		end
	end

	if Trinkets_k == 'o' then
		if isEquipped13 ~= nil and GetItemCooldown(Trinket13) == 0 then
			macro('/use 13')
		end
	end
	if Trinkets_k == 't' then
		if isEquipped14 ~= nil and GetItemCooldown(Trinket14) == 0 then
			macro('/use 14')
		end
	end


	if Rings_k == 'ot' then
		if isEquipped11 ~= nil and GetItemCooldown(ring1) == 0 and not player.channeling() then
			macro('/use 11')
		end

		if isEquipped12 ~= nil and  GetItemCooldown(ring2) == 0 and not player.channeling() then
			macro('/use 12')
		end
	end

	if Rings_k == 'o' then
		if isEquipped11 ~= nil and GetItemCooldown(ring1) == 0 and not player.channeling() then
			macro('/use 11')
		end
	end
	if Rings_k == 't' then
		if isEquipped12 ~= nil and GetItemCooldown(ring2) == 0 and not player.channeling() then
			macro('/use 12')
		end
	end
	end
	end
end
setfenv(items, dark_addon.environment.env)


local forced_spell = false
local f_spell = 0
local f_unit = player
local f_icon = 0
 

local timerActive = false

local function startTimer(resetAfter, func)
    if not timerActive then
        timerActive = true
        C_Timer.After(resetAfter, function()
            func()
            timerActive = false;
        end)
    end
end

local function setunset(bool, spell, unit, id)
		forced_spell = bool
		f_spell = spell
		f_unit = unit
		f_icon = id
end

function dark_addon.rotation.pause(spell, unit)
    icon = FlexIcon(spell, 25,25)
    cooldown_time = dark_addon.environment.hooks.spell(spell).cooldown
    castable = dark_addon.environment.hooks.castable(spell)
	setunset(true, spell, unit, icon)

	startTimer(1.3, function()    
		setunset(false, nil, nil, nil)
	end )
end


local stateval = dark_addon.settings.fetch('ssc') 
local lastGarbageCollection = 0

local function togglePlates()
	-- disable that = no aoe for you today.
	if GetCVar("nameplateShowEnemies") == '0' then
		SetCVar("nameplateShowEnemies", 1)
	end
	if GetCVar("nameplateShowAll") == '0' then
		SetCVar("nameplateShowAll", 1)
	end
end

function dark_addon.rotation.tick(ticker)
	turbo = dark_addon.settings.fetch('_engine_turbo', false)
	castclip = dark_addon.settings.fetch('_engine_castclip', 0.25)
	ticker._duration = dark_addon.settings.fetch('_engine_tickrate', 0.2)
	local _, _, lagHome, lagWorld = GetNetStats()
	local ownHaste = GetHaste()
	local elkek = (1.5/((100+ownHaste)/100))+lagWorld 

	local do_gcd = dark_addon.settings.fetch('_engine_gcd', true)
	local gcd_wait, start, duration = false
	
	if ticker._duration ~= last_duration then
		last_duration = ticker._duration
	end
	
	local toggled = dark_addon.settings.fetch_toggle('master_toggle', false)
	if not toggled then
		return
	end
	
	togglePlates();

	if not forced_spell then
	else
		dark_addon.environment.hooks.cast(f_spell, f_unit)
		if dark_addon.environment.hooks.spell(f_spell).lastcast then
			print(f_icon, ' :: you casted at :: ', f_unit)
			forced_spell = false
		end
		return
	end
  

	

	if gcd_spell and do_gcd then
	local _table = C_Spell.GetSpellCooldown(gcd_spell)
	local start, duration = _table.startTime,  _table.duration
	local _table = C_Spell.GetSpellCooldown(gcd_spell)
	if not _table then return 0 end
	local time, value = _table.startTime,  _table.duration

	gcd_wait = start > 0 and (duration - (GetTime() - start)) or 0
	end

	if dark_addon.rotation.active_rotation then
	if IsMounted() then return end


	if elkek ~= lastLag then
		lastLag = elkek
		dark_addon.rotation.timer.lag = elkek
	end

	if not turbo and (gcd_wait and gcd_wait > (elkek/1000 + castclip)) then 
		if dark_addon.rotation.active_rotation.gcd then
			return dark_addon.rotation.active_rotation.gcd()
		else
			return
		end
	end


	if UnitAffectingCombat('player') then
		items()
		dark_addon.rotation.active_rotation.combat()
	else
		dark_addon.rotation.active_rotation.resting()
	end
	end
end




dark_addon.on_ready(function()
  dark_addon.rotation.timer.ticker = C_Timer.NewAdvancedTicker(0.1, dark_addon.rotation.tick)
end)