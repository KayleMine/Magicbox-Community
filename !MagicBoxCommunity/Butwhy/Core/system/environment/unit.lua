local addon, dark_addon = ...
local rc = LibStub("LibRangeCheck-2.0")
local UnitReverseDebuff = dark_addon.environment.unit_reverse_debuff

local runeforge = {}
local unit = {}
local calledUnit

dummies = {
-- Misc/Unknown
	[79987]  = "Training Dummy", 	          -- Location Unknown
	[92169]  = "Raider's Training Dummy",     -- Tanking (Eastern Plaguelands)
	[96442]  = "Training Dummy", 			  -- Damage (Location Unknown)
	[109595] = "Training Dummy",              -- Location Unknown
	[113963] = "Raider's Training Dummy", 	  -- Damage (Location Unknown)
	[131985] = "Dungeoneer's Training Dummy", -- Damage (Zuldazar)
	[131990] = "Raider's Training Dummy",     -- Tanking (Zuldazar)
	[132976] = "Training Dummy", 			  -- Morale Booster (Zuldazar)
-- Level 1
	[17578]  = "Hellfire Training Dummy",     -- Lvl 1 (The Shattered Halls)
	[60197]  = "Training Dummy",              -- Lvl 1 (Scarlet Monastery)
	[64446]  = "Training Dummy",              -- Lvl 1 (Scarlet Monastery)
	[144077] = "Training Dummy",              -- Lvl 1 (Dazar'alor) - Morale Booster
-- Level 3
	[44171]  = "Training Dummy",              -- Lvl 3 (New Tinkertown, Dun Morogh)
	[44389]  = "Training Dummy",              -- Lvl 3 (Coldridge Valley)
	[44848]  = "Training Dummy", 			  -- Lvl 3 (Camp Narache, Mulgore)
	[44548]  = "Training Dummy",              -- Lvl 3 (Elwynn Forest)
	[44614]  = "Training Dummy",              -- Lvl 3 (Teldrassil, Shadowglen)
	[44703]  = "Training Dummy", 			  -- Lvl 3 (Ammen Vale)
	[44794]  = "Training Dummy", 			  -- Lvl 3 (Dethknell, Tirisfal Glades)
	[44820]  = "Training Dummy",              -- Lvl 3 (Valley of Trials, Durotar)
	[44937]  = "Training Dummy",              -- Lvl 3 (Eversong Woods, Sunstrider Isle)
	[48304]  = "Training Dummy",              -- Lvl 3 (Kezan)
-- Level 55
	[32541]  = "Initiate's Training Dummy",   -- Lvl 55 (Plaguelands: The Scarlet Enclave)
	[32545]  = "Initiate's Training Dummy",   -- Lvl 55 (Eastern Plaguelands)
-- Level 60
	[32666]  = "Training Dummy",              -- Lvl 60 (Siege of Orgrimmar, Darnassus, Ironforge, ...)
-- Level 65
	[32542]  = "Disciple's Training Dummy",   -- Lvl 65 (Eastern Plaguelands)
-- Level 70
	[32667]  = "Training Dummy",              -- Lvl 70 (Orgrimmar, Darnassus, Silvermoon City, ...)
-- Level 75
	[32543]  = "Veteran's Training Dummy",    -- Lvl 75 (Eastern Plaguelands)
-- Level 80
	[31144]  = "Training Dummy",              -- Lvl 80 (Orgrimmar, Darnassus, Ironforge, ...)
	[32546]  = "Ebon Knight's Training Dummy",-- Lvl 80 (Eastern Plaguelands)
-- Level 85
	[46647]  = "Training Dummy",              -- Lvl 85 (Orgrimmar, Stormwind City)
-- Level 90
	[67127]  = "Training Dummy",              -- Lvl 90 (Vale of Eternal Blossoms)
-- Level 95
	[79414]  = "Training Dummy",              -- Lvl 95 (Broken Shore, Talador)
-- Level 100
	[87317]  = "Training Dummy",              -- Lvl 100 (Lunarfall, Frostwall) - Damage
	[87321]  = "Training Dummy",              -- Lvl 100 (Stormshield) - Healing
	[87760]  = "Training Dummy",              -- Lvl 100 (Frostwall) - Damage
	[88289]  = "Training Dummy",              -- Lvl 100 (Frostwall) - Healing
	[88316]  = "Training Dummy",              -- Lvl 100 (Lunarfall) - Healing
	[88835]  = "Training Dummy",              -- Lvl 100 (Warspear) - Healing
	[88906]  = "Combat Dummy",                -- Lvl 100 (Nagrand)
	[88967]  = "Training Dummy",              -- Lvl 100 (Lunarfall, Frostwall)
	[89078]  = "Training Dummy",              -- Lvl 100 (Frostwall, Lunarfall)
-- Levl 100 - 110
	[92164]  = "Training Dummy", 			  -- Lvl 100 - 110 (Dalaran) - Damage
	[92165]  = "Dungeoneer's Training Dummy", -- Lvl 100 - 110 (Eastern Plaguelands) - Damage
	[92167]  = "Training Dummy",              -- Lvl 100 - 110 (The Maelstrom, Eastern Plaguelands, The Wandering Isle)
	[92168]  = "Dungeoneer's Training Dummy", -- Lvl 100 - 110 (The Wandering Isles, Easter Plaguelands)
	[100440] = "Training Bag", 				  -- Lvl 100 - 110 (The Wandering Isles)
	[100441] = "Dungeoneer's Training Bag",   -- Lvl 100 - 110 (The Wandering Isles)
	[102045] = "Rebellious Wrathguard",       -- Lvl 100 - 110 (Dreadscar Rift) - Dungeoneer
	[102048] = "Rebellious Felguard",         -- Lvl 100 - 110 (Dreadscar Rift)
	[102052] = "Rebellious Imp", 			  -- Lvl 100 - 110 (Dreadscar Rift) - AoE
	[103402] = "Lesser Bulwark Construct",    -- Lvl 100 - 110 (Hall of the Guardian)
	[103404] = "Bulwark Construct",           -- Lvl 100 - 110 (Hall of the Guardian) - Dungeoneer
	[107483] = "Lesser Sparring Partner",     -- Lvl 100 - 110 (Skyhold)
	[107555] = "Bound Void Wraith",           -- Lvl 100 - 110 (Netherlight Temple)
	[107557] = "Training Dummy",              -- Lvl 100 - 110 (Netherlight Temple) - Healing
	[108420] = "Training Dummy",              -- Lvl 100 - 110 (Stormwind City, Durotar)
	[111824] = "Training Dummy", 			  -- Lvl 100 - 110 (Azsuna)
	[113674] = "Imprisoned Centurion",        -- Lvl 100 - 110 (Mardum, the Shattered Abyss) - Dungeoneer
	[113676] = "Imprisoned Weaver", 	      -- Lvl 100 - 110 (Mardum, the Shattered Abyss)
	[113687] = "Imprisoned Imp",              -- Lvl 100 - 110 (Mardum, the Shattered Abyss) - Swarm
	[113858] = "Training Dummy",              -- Lvl 100 - 110 (Trueshot Lodge) - Damage
	[113859] = "Dungeoneer's Training Dummy", -- Lvl 100 - 110 (Trueshot Lodge) - Damage
	[113862] = "Training Dummy",              -- Lvl 100 - 110 (Trueshot Lodge) - Damage
	[113863] = "Dungeoneer's Training Dummy", -- Lvl 100 - 110 (Trueshot Lodge) - Damage
	[113871] = "Bombardier's Training Dummy", -- Lvl 100 - 110 (Trueshot Lodge) - Damage
	[113966] = "Dungeoneer's Training Dummy", -- Lvl 100 - 110 - Damage
	[113967] = "Training Dummy",              -- Lvl 100 - 110 (The Dreamgrove) - Healing
	[114832] = "PvP Training Dummy",          -- Lvl 100 - 110 (Stormwind City)
	[114840] = "PvP Training Dummy",          -- Lvl 100 - 110 (Orgrimmar)
-- Level 102
	[87318]  = "Dungeoneer's Training Dummy", -- Lvl 102 (Lunarfall) - Damage
	[87322]  = "Dungeoneer's Training Dummy", -- Lvl 102 (Stormshield) - Tank
	[87761]  = "Dungeoneer's Training Dummy", -- Lvl 102 (Frostwall) - Damage
	[88288]  = "Dungeoneer's Training Dummy", -- Lvl 102 (Frostwall) - Tank
	[88314]  = "Dungeoneer's Training Dummy", -- Lvl 102 (Lunarfall) - Tank
	[88836]  = "Dungeoneer's Training Dummy", -- Lvl 102 (Warspear) - Tank
	[93828]  = "Training Dummy",              -- Lvl 102 (Hellfire Citadel)
	[97668]  = "Boxer's Trianing Dummy",      -- Lvl 102 (Highmountain)
	[98581]  = "Prepfoot Training Dummy",     -- Lvl 102 (Highmountain)
-- Level 110 - 120
	[126781] = "Training Dummy", 			  -- Lvl 110 - 120 (Boralus) - Damage
	[131989] = "Training Dummy", 			  -- Lvl 110 - 120 (Boralus) - Damage
	[131994] = "Training Dummy", 			  -- Lvl 110 - 120 (Boralus) - Healing
	[144082] = "Training Dummy",              -- Lvl 110 - 120 (Dazar'alor) - PVP Damage
	[144085] = "Training Dummy", 			  -- Lvl 110 - 120 (Dazar'alor) - Damage
	[144081] = "Training Dummy",              -- Lvl 110 - 120 (Dazar'alor) - Damage
	[153285] = "Training Dummy", 			  -- Lvl 110 - 120 (Ogrimmar) - Damage
	[153292] = "Training Dummy", 			  -- Lvl 110 - 120 (Stormwind) - Damage
-- Level 111 - 120
	[131997] = "Training Dummy", 			  -- Lvl 111 - 120 (Boralus, Zuldazar) - PVP Damage
	[131998] = "Training Dummy",              -- Lvl 111 - 120 (Boralus, Zuldazar) - PVP Healing
-- Level 112 - 120
	[144074] = "Training Dummy", 			  -- Lvl 112 - 120 (Dazar'alor) - PVP Healing
-- Level 112 - 122
	[131992] = "Dungeoneer's Training Dummy",  -- Lvl 112 - 122 (Boralus) - Tanking
-- Level 113 - 120
	[132036] = "Training Dummy", 			  -- Lvl 113 - 120 (Boralus) - Healing
-- Level 113 - 122
	[144078] = "Dungeoneer's Training Dummy", -- Lvl 113 - 122 (Dazar'alor) - Tanking
-- Level 114 - 120
	[144075] = "Training Dummy", 			  -- Lvl 114 - 120 (Dazar'alor) - Healing
-- Level 60
	[174569] = "Training Dummy",			  -- Lvl 60 (Ardenweald)
	[174570] = "Swarm Training Dummy",		  -- Lvl 60 (Ardenweald)
	[174571] = "Cleave Training Dummy",		  -- Lvl 60 (Ardenweald)
	[174487] = "Competent Veteran", 		  -- Lvl 60 (Location Unknown)
	[173942] = "Training Dummy",			  -- Lvl 60 (Revendreth)
	[175456] = "Swarm Training Dummy",		  -- Lvl 60 (Revendreth)
	[175455] = "Cleave Training Dummy",		  -- Lvl 60 (Revendreth)
-- Level 62
	[174484] = "Immovable Champion", 		  -- Lvl 62 (Location Unknown)
	[175449] = "Dungeoneer's Training Dummy", -- Lvl 62 (Revendreth)
	[173957] = "Necrolord's Resolve",		  -- Lvl 62 (Oribos)
	[173955] = "Pride's Resolve",		 	  -- Lvl 62 (Oribos)
	[173954] = "Nature's Resolve",		 	  -- Lvl 62 (Oribos)
	[173919] = "Valiant's Resolve",		 	  -- Lvl 62 (Oribos)
-- Level ??
	[24792]  = "Advanced Training Dummy",     -- Lvl ?? Boss (Location Unknown)
	[30527]  = "Training Dummy", 		      -- Lvl ?? Boss (Location Unknown)
	[31146]  = "Raider's Training Dummy",     -- Lvl ?? (Orgrimmar, Stormwind City, Ironforge, ...)
	[87320]  = "Raider's Training Dummy",     -- Lvl ?? (Lunarfall, Stormshield) - Damage
	[87329]  = "Raider's Training Dummy",     -- Lvl ?? (Stormshield) - Tank
	[87762]  = "Raider's Training Dummy",     -- Lvl ?? (Frostwall, Warspear) - Damage
	[88837]  = "Raider's Training Dummy",     -- Lvl ?? (Warspear) - Tank
	[92166]  = "Raider's Training Dummy",     -- Lvl ?? (The Maelstrom, Dalaran, Eastern Plaguelands, ...) - Damage
	[101956] = "Rebellious Fel Lord",         -- lvl ?? (Dreadscar Rift) - Raider
	[103397] = "Greater Bulwark Construct",   -- Lvl ?? (Hall of the Guardian) - Raider
	[107202] = "Reanimated Monstrosity", 	  -- Lvl ?? (Broken Shore) - Raider
	[107484] = "Greater Sparring Partner",    -- Lvl ?? (Skyhold)
	[107556] = "Bound Void Walker",           -- Lvl ?? (Netherlight Temple) - Raider
	[113636] = "Imprisoned Forgefiend",       -- Lvl ?? (Mardum, the Shattered Abyss) - Raider
	[113860] = "Raider's Training Dummy",     -- Lvl ?? (Trueshot Lodge) - Damage
	[113864] = "Raider's Training Dummy",     -- Lvl ?? (Trueshot Lodge) - Damage
	[70245]  = "Training Dummy",              -- Lvl ?? (Throne of Thunder)
	[113964] = "Raider's Training Dummy",     -- Lvl ?? (The Dreamgrove) - Tanking
	[131983] = "Raider's Training Dummy",     -- Lvl ?? (Boralus) - Damage
	[144086] = "Raider's Training Dummy",     -- Lvl ?? (Dazal'alor) - Damage
	[174565] = "Raider's Training Dummy",	  -- Lvl ?? (Ardenweald)
	[174566] = "Dungeoneer's Tanking Dummy",  -- Lvl ?? (Ardenweald)
	[174567] = "Raider's Training Dummy",	  -- Lvl ?? (Ardenweald)
	[174568] = "Dungeoneer's Tanking Dummy",  -- Lvl ?? (Ardenweald)
	[174491] = "Iron Tester", 				  -- Lvl ?? (Location Unknown)
	[174488] = "Unbreakable Defender", 		  -- Lvl ?? (Location Unknown)
	-- [174489] = "Necromantic Guide", 		  -- Lvl ?? (Location Unknown)
	[174489] = "Raider's Training Dummy",	  -- Lvl ?? (Revendreth)
	[175452] = "Raider's Training Dummy",	  -- Lvl ?? (Location Unknown)
	[175451] = "Dungeoneer's Tanking Dummy",  -- Lvl ?? (Revendreth)
	[154580] = "Reinforced Guardian", 		  -- Elysian Hold
	[154583] = "Stalward Guardian", 		  -- Elysian Hold
	[154585] = "Valiant's Resolve",			  -- Elysian Hold
	[154586] = "Stalward Phalanx", 			  -- Elysian Hold
	[154564] = "Valiant's Humility", 		  -- Elysian Hold
	[154567] = "Purity's Cleansing", 		  -- Elysian Hold
	[160325] = "Humility's Obedience", 		  -- Elysian Hold
-- Dragonflight
	[194648] = "Training Dummy", 			  -- Valdrakken
	[194645] = "Training Dummy", 			  -- Valdrakken (Healing)
	[194649] = "Normal Tank Dummy",			  -- Valdrakken
	[198594] = "Cleave Training Dummy",	      -- Valdrakken
	[197833] = "PvP Training Dummy",		  -- Valdrakken
	[197834] = "PvP Training Dummy", 		  -- Valdrakken (Healing)
	[194646] = "Cleave Training Dummy",	      -- Valdrakken (Healing)
	[194643] = "Dungeoneer's Training Dummy", -- Valdrakken
	[194644] = "Dungeoneer's Training Dummy", -- Valdrakken (Tanking)
	[189632] = "Animated Duelist", 			  -- Valdrakken (Raider's Training Dummy)
	[189617] = "Boulderfist", 			      -- Valdrakken (Raider's Tanking Dummy)
	[225985] = "XXX", 			      -- XXX (Raider's Tanking Dummy)
}  

function dummy(unitID)
-- Get the target's ID
local unit = UnitGUID(unitID)
if unit then
local targetID = tonumber(UnitGUID(unitID):sub(-16, -12))
-- Check if the target's ID is in the dummies table
if dummies[targetID] then
	is = true
		else
	is = false
end
end
if is == nil or not unit then
	is = false
end
return is
end

 
function unit:id()
if UnitExists(self.unitID) then
	id =  UnitGUID(self.unitID):match("-(%d+)-%x+$")
	return id
end
	return 0
end


function unit:IsDummy()
  if dummy(self.unitID) then
    return true
  end
end

function unit:IsBoss()
	if dummy(self.unitID) then
		return true
	end
    if UnitIsUnit(self.unitID, "Boss1") or UnitIsUnit(self.unitID, "Boss2") or UnitIsUnit(self.unitID, "Boss3") or UnitIsUnit(self.unitID, "Boss4") or UnitIsUnit(self.unitID, "Boss5")  then
        return true
    end
    local inRaid = IsInRaid()
    if UnitLevel(self.unitID) == -1 or (not inRaid and UnitLevel(self.unitID) > 82) then
        return true
    end
    if UnitIsPlayer(self.unitID) and UnitCanAttack("player", self.unitID) then
        return true
    end
    return false
end


function unit:buff()
  return dark_addon.environment.conditions.buff(self)
end

function unit:debuff()
  return dark_addon.environment.conditions.debuff(self)
end

function unit:health()
  return dark_addon.environment.conditions.health(self)
end

function unit:spell()
  return dark_addon.environment.conditions.spell(self)
end

function unit:power()
  return dark_addon.environment.conditions.power(self)
end

function unit:enemies()
  return dark_addon.environment.conditions.enemies(self)
end

function unit:alive()
  return not UnitIsDeadOrGhost(self.unitID)
end

function unit:level()
  return UnitLevel(self.unitID)
end

function unit:dead()
  return UnitIsDeadOrGhost(self.unitID)
end

function unit:enemy()
  return UnitCanAttack("player", self.unitID)
end

function unit:friend()
  return not UnitCanAttack("player", self.unitID)
end

function unit:name()
  return UnitName(self.unitID)
end

function unit:exists()
  return UnitExists(self.unitID)
end

function unit:guid()
  return UnitGUID(self.unitID)
end
local function celectial_active(name)
  local haveTotem, totemName, startTime, duration
  for i = 1, 4 do
    haveTotem, totemName, startTime, duration = GetTotemInfo(i)
    if totemName == name then
      return true
    end
  end
  return false
end

function unit:celectial_active()
  return celectial_active
end
function unit:distance()
  if dark_addon.luaboxdev then
    if UnitExists(self.unitID) then
      local px, py, pz = __LB__.ObjectPosition("player")
      local tx, ty, tz = __LB__.ObjectPosition(self.unitID)
      if px and py and pz and tx and ty and tz then
        local dist = math.sqrt((px - tx) ^ 2 + (py - ty) ^ 2 + (pz - tz) ^ 2)
        dist = dist * 100
        dist = math.floor(dist)
        dist = dist / 100
        return dist
      else
        return 100
      end
    else
      return 100
    end
  elseif dark_addon.adv_protected then
    if ObjectExists(self.unitID) then
      local dist = GetDistanceBetweenObjects("player", self.unitID)
      if dist then
        dist = dist * 100
        dist = math.floor(dist)
        dist = dist / 100
        return dist
      else
        return 100
      end
    else
      return 100
    end
  else
    local minRange, maxRange = rc:GetRange(self.unitID)
    if not minRange then
      return 100
    elseif not maxRange then
      return 100
    else
      return maxRange
    end
  end
end

local function channeling(spell)
  local channeling_spell = UnitChannelInfo(calledUnit.unitID)
  if channeling_spell then
    if spell then
      if tonumber(spell) then
        spell = GetSpellInfo(spell)
      end
      if channeling_spell == spell then
        return true
      else
        return false
      end
    else
      return true
    end
  else
    return false
  end
end

function unit:channeling(spell)
  return channeling
end

function unit:castingpercent()
  local castingname, _, _, startTime, endTime, notInterruptible = UnitCastingInfo("player")
  if castingname then
    local castLength = (endTime - startTime) / 1000
    local secondsLeft = endTime / 1000 - GetTime()
    return ((secondsLeft / castLength) * 100)
  end
  return 0
end

function unit:moving()
  return GetUnitSpeed(self.unitID) ~= 0
end

function unit:has_stealable()
  local has_stealable = false
  for i = 1, 40 do
    buff, _, count, _, duration, expires, caster, stealable, _, spellID = _G["UnitBuff"](self.unitID, i)
    if stealable then
      has_stealable = true
    end
  end
  return has_stealable
end

function unit:combat()
  return UnitAffectingCombat(self.unitID)
end

local function unit_interrupt(percent, spell)
  local percent = tonumber(percent) or 100
  local spell = spell and C_Spell.GetSpellInfo(spell).name or false
  local name, startTime, endTime, notInterruptible
  name, _, _, startTime, endTime, _, _, notInterruptible, _ = UnitCastingInfo(calledUnit.unitID)
  if not name then
    name, _, _, startTime, endTime, _, _, notInterruptible, _ = UnitChannelInfo(calledUnit.unitID)
  end
  if name and startTime and endTime and ((spell and name == spell) or (not spell and not notInterruptible)) then
    local castTimeRemaining = endTime / 1000 - GetTime()
    local castTimeTotal = (endTime - startTime) / 1000
    if castTimeTotal > 0 and castTimeRemaining / castTimeTotal * 100 <= percent then
      return true
    end
  end
  return false
end

function unit:interrupt()
  return unit_interrupt
end

local function unit_in_range(spell)
  if tonumber(spell) then
    name = GetSpellInfo(spell)
  end
  return C_Spell.IsSpellInRange(spell, calledUnit.unitID) == 1
end

function unit:in_range()
  return unit_in_range
end

local function totem_cooldown(name)
  if tonumber(name) then
    name = GetSpellInfo(name)
  end
  local haveTotem, totemName, startTime, duration
  for i = 1, 4 do
    haveTotem, totemName, startTime, duration = GetTotemInfo(i)
    if totemName == name then
      return duration - (GetTime() - startTime)
    end
  end
  return 0
end

function unit:totem()
  return totem_cooldown
end

local function unit_talent(a, b)
  local tier, column
  if type(a) == "table" then
    tier = a[1]
    column = a[2]
  else
    tier = a
    column = b
  end
  local talentID, name, texture, selected, available, spellID, unknown, row, column, unknown, known =
    GetTalentInfo(tier, column, GetActiveSpecGroup())
  return available
end

function unit:talent()
  return unit_talent
end

local death_tracker = {}
function unit:time_to_die()
  if death_tracker[self.unitID] and death_tracker[self.unitID].guid == UnitGUID(self.unitID) then
    local health_change = death_tracker[self.unitID].health - UnitHealth(self.unitID)
    local time_change = GetTime() - death_tracker[self.unitID].time
    local health_per_time = health_change / time_change
    local time_to_die = UnitHealth(self.unitID) / health_per_time
    return math.min(math.max(time_to_die, 0), 9999) -- give it the clamps
  end
  if not death_tracker[self.unitID] then
    death_tracker[self.unitID] = {}
  end
  death_tracker[self.unitID].guid = UnitGUID(self.unitID)
  death_tracker[self.unitID].time = GetTime()
  death_tracker[self.unitID].health = UnitHealth(self.unitID)
  return 9999
end

local function spell_cooldown(spell)
  _table = C_Spell.GetSpellCooldown(spell)
  if not _table then return 0 end
  local time, value = _table.startTime,  _table.duration

  if not time or time == 0 then
    return 0
  end
  local cd = time + value - GetTime() - (select(4, GetNetStats()) / 1000)
  if cd > 0 then
    return cd
  else
    return 0
  end
end

local function spell_castable(spell)
  local spell = C_Spell.GetSpellInfo(spell).name
  local usable, noMana = C_Spell.IsSpellUsable(spell)
  --local inRange = C_Spell.IsSpellInRange(spell, calledUnit.unitID)
  if usable and not dark_addon.LineOfSight(calledUnit.unitID) then
    if spell_cooldown(spell) == 0 then
      return true
    else
      return false
    end
  end
  return false
end

function unit:castable()
  return spell_castable
end

local function check_removable(removable_type)
  local debuff, count, duration, expires, caster, found_debuff =
    UnitReverseDebuff(calledUnit.unitID, dark_addon.data.removables[removable_type])
  if debuff and (count == 0 or count >= found_debuff.count) and calledUnit.health.percent <= found_debuff.health then
    return unit
  end
  return false
end

local function unit_removable(...)
  for i = 1, select("#", ...) do
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

function unit:removable(...)
  return unit_removable
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

local function unit_dispellable(spell)
  return canDispel(calledUnit.unitID, spell)
end

function unit:dispellable(spell)
  return unit_dispellable
end

function dark_addon.environment.conditions.unit(unitID)
  return setmetatable(
    {
      unitID = unitID
    },
    {
      __index = function(t, k, k2)
        if t and k then
          calledUnit = t
          return unit[k](t)
        end
      end
    }
  )
end

local player_hook = dark_addon.environment.conditions.unit("player")
local player_spell_hook = player_hook["spell"]
dark_addon.environment.hooks.spell = player_spell_hook
dark_addon.environment.hooks.buff = player_hook["buff"]
dark_addon.environment.hooks.debuff = player_hook["debuff"]
dark_addon.environment.hooks.power = player_hook["power"]
dark_addon.environment.hooks.health = player_hook["health"]
dark_addon.environment.hooks.talent = player_hook["talent"]
dark_addon.environment.hooks.totem = player_hook["totem"]
dark_addon.environment.hooks.enemies = player_hook["enemies"]

dark_addon.environment.hooks.castable = function(spell)
  return player_spell_hook(spell)["castable"]
end

dark_addon.environment.hooks.lastcast = function(spell)
  return player_spell_hook(spell)["lastcast"]
end

dark_addon.environment.hooks.lastgcd = function()
  return dark_addon.tmp.fetch('lastgcd', 1.5)
end

