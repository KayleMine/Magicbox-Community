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


function cstng()
    if UnitCastingInfo('player') or UnitChannelInfo('player') then
        return true
    end
    return false
end

local function items()
if UnitAffectingCombat("player") and not cstng() and target.exists and target.alive and target.enemy and target.time_to_die > 10 then
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

   if GetItemCooldown(hands) == 0 and not player.channeling() then
      macro('/use 7')
   end
end
end
setfenv(items, dark_addon.environment.env)

local forced_spell = false
local f_spell = 0
local f_unit = player
local f_icon = 0
 
function dark_addon.rotation.pause(spell, unit)
    icon = FlexIcon(spell, 25,25)
    cooldown_time = dark_addon.environment.hooks.spell(spell).cooldown
    castable = dark_addon.environment.hooks.castable(spell)
    
    if cooldown_time <= 2 and iknow(spell) then
        forced_spell = true
        f_spell = spell
        f_unit = unit
        f_icon = icon
    end
    if cooldown_time > 2 or not iknow(spell) then
        forced_spell = false
    end
end
local stateval = dark_addon.settings.fetch('ssc') 

function dark_addon.rotation.tick(ticker)
  turbo = dark_addon.settings.fetch('_engine_turbo', false)
  castclip = dark_addon.settings.fetch('_engine_castclip', 0.25)
  ticker._duration = dark_addon.settings.fetch('_engine_tickrate', 0.2)
  if ticker._duration ~= last_duration then
    last_duration = ticker._duration
    dark_addon.console.debug(2, 'engine', 'engine', string.format('Ticket Rate: %sms', last_duration * 1000))
  end
  local toggled = dark_addon.settings.fetch_toggle('master_toggle', false)
  if not toggled then
    -- --dark_addon.interface.status('Готов...')
    return
  end

  local do_gcd = dark_addon.settings.fetch('_engine_gcd', true)
  local gcd_wait, start, duration = false
  if gcd_spell and do_gcd then
    _table = C_Spell.GetSpellCooldown(gcd_spell)
	start, duration = _table.startTime,  _table.duration
  _table = C_Spell.GetSpellCooldown(gcd_spell)
  if not _table then return 0 end
  local time, value = _table.startTime,  _table.duration
  
    gcd_wait = start > 0 and (duration - (GetTime() - start)) or 0
  end

  if dark_addon.rotation.active_rotation then
    if IsMounted() then return end

    local _, _, lagHome, lagWorld = GetNetStats()
    --local lag = (((lagHome + lagWorld) / 2) / 1000) * 2
	--(1.5/((100+haste)/100))+lag
	local ownHaste = GetHaste()
	local elkek = (1.5/((100+ownHaste)/100))+lagWorld
    if elkek ~= lastLag then
      dark_addon.console.debug(2, 'engine', 'engine', string.format('Lag: %sms', elkek * 1000).." or "..elkek)
      lastLag = elkek
      dark_addon.rotation.timer.lag = elkek
    end

    if not turbo and (gcd_wait and gcd_wait > (elkek + castclip)) then
      if dark_addon.rotation.active_rotation.gcd then
        return dark_addon.rotation.active_rotation.gcd()
      else
        return
      end
    end


if not forced_spell then
	if UnitAffectingCombat('player') then
		  items()
		  dark_addon.rotation.active_rotation.combat()
	else
		  dark_addon.rotation.active_rotation.resting()
	if GetTime() - last_loading > loading_wait then
		last_loading = GetTime()
		loading_wait = math.random(120, 300)
	else
	end
	end
else
	dark_addon.environment.hooks.cast(f_spell, f_unit)
	if dark_addon.environment.hooks.spell(f_spell).lastcast then
		if stateval == 2 then print(f_icon, ' :: casted at :: ', f_unit) end
		forced_spell = false
	end
end
	
	
	
  end
end




dark_addon.on_ready(function()
  dark_addon.rotation.timer.ticker = C_Timer.NewAdvancedTicker(0.1, dark_addon.rotation.tick)
end)
