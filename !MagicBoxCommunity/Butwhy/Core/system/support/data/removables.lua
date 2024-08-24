local addon, dark_addon = ...

dark_addon.data.removables = {
    curse = {
        -- Siege of Boralus
	
	[369365] = { name = "xxxxxxxx", count = 3, health = 100 }, -- xxxx
        [257168] = { name = "Cursed Slash", count = 1, health = 100 }, -- Irontide Marauder Curse 10  No  +15% Damage taken
        -- Waycrest Manor
        [260703] = { name = "Unstable Runic Mark", count = 1, health = 100 }, -- Sister Malady  Curse 6 No  Minor DoT, 6yd AoE on expiry
        [263905] = { name = "Marking Cleave", count = 1, health = 100 }, -- Heartsbane Runeweaver Curse 6 Yes Moderate DoT
        [265880] = { name = "Dread Mark", count = 1, health = 100 }, -- Matron Alma Curse 6 No  Minor DoT, 6rd AoE on expiry
        [265882] = { name = "Lingering Dread", count = 1, health = 100 }, -- Matron Alma  Curse 5 No  Minor DoT, follows Dread Mark
        [264105] = { name = "Runic Mark", count = 1, health = 100 }, -- Marked Sister Curse 6 Yes Minor DoT, 6yrd AoE on expiry
        -- Atal'Dazar
        [252781] = { name = "Unstable Hex", count = 1, health = 100 }, -- Zanchuli Witch-Doctor Curse 5 Yes Polymorph, spreads on expiry
        [250096] = { name = "Wracking Pain", count = 1, health = 100 }, -- Yazma  Curse 6 Yes Moderate DoT
        -- King's Rest
        [270492] = { name = "Hex", count = 1, health = 100 }, -- Spectral Hex Priest  Curse 10  Yes Polymorph
        -- Underrot
        [265468] = { name = "Withering Curse", count = 1, health = 100 }, -- Bloodsworm Defiler  Curse 12  Yes -10% damage done, +10% damage taken, Stacks, Channeled
        [326836] = { name = "Dispel me", count = 1, health = 100 }, -- 
        [336277] = { name = "Dispel me", count = 1, health = 100 }, -- 
        [328494] = { name = "Dispel me", count = 1, health = 100 }, -- 
        [319603] = { name = "Dispel me", count = 1, health = 100 }, -- 
        [325876] = { name = "Curse of Obliteration", count = 1, health = 100 },
		
        [356407] = { name = "Dispel me", count = 1, health = 100 },
        [156718] = { name = "Dispel me", count = 1, health = 100 },
        [300436] = { name = "Dispel me", count = 1, health = 100 },
        [29930] = { name = "Dispel me", count = 1, health = 100 },
        [230297] = { name = "Dispel me", count = 1, health = 100 },
        [228241] = { name = "Dispel me", count = 1, health = 100 },
        [153524] = { name = "Dispel me", count = 1, health = 100 },
        [391762] = { name = "Dispel me", count = 3, health = 100 }
       -- [25771] = { name = "test", count = 1, health = 100 }
    },
    disease = {
        -- Freehold
        [258323] = { name = "Infected Wound", count = 1, health = 100 }, --Irontide Bonesaw  Disease 12  No  -20% healing received
        [257775] = { name = "Plague Step", count = 1, health = 100 }, --Bilge Rat Padfoot  Disease 18  No  Moderate DoT, -25% healing received
        -- Siege of Boralus
        [272588] = { name = "Rotting Wounds", count = 1, health = 100 }, -- Bilge Rat Cutthroat  Disease 15  No  -25% Healing received
        -- Waycrest Manor
        [264050] = { name = "Infected Thorn", count = 1, health = 100 }, -- Coven Thornshaper  Disease 8 Yes Moderate DoT
        [261440] = { name = "Virulent Pathogen", count = 1, health = 100 }, -- Lord Waycrest Disease 5 No Moderate DoT, -50% Movement spd, spreads to nearby players on expiry
        -- Atal'Dazar
        [250371] = { name = "Lingering Nausea", count = 1, health = 100 }, -- Vol'Kaal Disease 12  - Moderate DoT, Stacks
        -- King's Rest
        [267763] = { name = "Wretched Discharge", count = 1, health = 100 }, -- Half-finished Mummy  Disease 12  Yes Moderate DoT
        -- MOTHERLODE!!
        [263074] = { name = "Festering Bite", count = 1, health = 100 }, -- Feckless Assistant Disease 10  No  Moderate DoT
        -- Temple of Sethraliss
        [269686] = { name = "Plague", count = 1, health = 100 }, -- Plague Toad  Disease 10  Yes -Minor DoT, -50% Healing done, Stacks
        -- Underrot
        [278961] = { name = "Decaying Mind", count = 1, health = 100 }, -- Diseased Lasher Disease 30  Yes Stun, Absorbs healing, Removed when absorb removed
        [55095] = { name = "Frost Fever", count = 1, health = 100 },
        [320512] = { name = "Corroded Claws", count = 1, health = 100 },
        [319070] = { name = "Corrosive Gunk", count = 1, health = 100 },
        [328002] = { name = "Hurl Spores", count = 1, health = 100 },
        [333711] = { name = "Decrepit Bite", count = 5, health = 100 },
        [321821] = { name = "Disgusting Guts", count = 1, health = 100 },
        [259714] = { name = "Decaying Spores", count = 1, health = 100 }, -- Sporecaller Zancha Disease 6 No  Moderate DoT, Stacks
		
        [163740] = { name = "Dispel me", count = 1, health = 100 }, 
        [300659] = { name = "Dispel me", count = 1, health = 100 }, 
        [300650] = { name = "Dispel me", count = 1, health = 100 }, 
        [298124] = { name = "Dispel me", count = 1, health = 100 }, 
        [228571] = { name = "Dispel me", count = 1, health = 100 },
		-- Uldaman
		[369818] = { name = "Diseased Bite", count = 1, health = 100 } --

    },
    magic = {
        -- Freehold 
	[417807] = { name = "Dispel me", count = 5, health = 100 },
        [391634] = { name = "Dispel me", count = 1, health = 100 },
        [389443] = { name = "Dispel me", count = 1, health = 100 },
        [257908] = { name = "Oiled Blade", count = 1, health = 100 }, --Irontide Officer  Magic 8 No  -75% healing received
        -- Shrine of the Storm
        [264560] = { name = "Choking Brine", count = 1, health = 100 }, --Aqu'sirr  Magic 20  No  Minor DoT, turns into swirls when dispelled
        [268233] = { name = "Electrifying Shock", count = 1, health = 100 },  --Guardian Elemental  Magic 20  No  Heavy DoT
        [268322] = { name = "Touch of the Drowned", count = 1, health = 100 }, --Drowned Depthbringer Magic 12  Yes Moderate DoT
        [268896] = { name = "Mind Rend", count = 1, health = 100 }, --Lord Stormsong  Magic 10  No  Minor DoT, -50% Movement Speed
        [269104] = { name = "Explosive Void", count = 1, health = 100 },  --Lord Stormsong  Magic 4 Yes Stun
        [267034] = { name = "Whispers of Power", count = 1, health = 100 }, --Vol'zith  Magic N/A No  +20% dmg / healing, can't be healed above X%, Stacks
        -- Siege of Boralus
        [272571] = { name = "Choking Waters", count = 1, health = 100 }, -- Bilge Rat Tempest Magic 6 Yes Moderate DoT, Silence
        [274991] = { name = "Putrid Waters", count = 1, health = 100 }, -- Viq'Goth Magic 30  No  Minor DoT, knocks back nearby allies if dispelled
        -- Tol Dagor
        [258128] = { name = "Debilitating Shout", count = 1, health = 100 }, -- Irontide Thug Magic 8 Yes -50% damage dealt
        [265889] = { name = "Torch Strike", count = 1, health = 100 }, -- Blacktooth Arsonist Magic 16  No  Minor DoT, Stacks
        [257791] = { name = "Howling Fear", count = 1, health = 100 }, -- Jes Howlis  Magic 6 Yes Fear
        [258864] = { name = "Suppression Fire", count = 1, health = 100 }, -- Ashvane Marine  Magic 12  No  Minor DoT
        [257028] = { name = "Fuselighter", count = 1, health = 100 }, -- Knight Captain Valyri  Magic 5 No  Minor DoT, explodes any barrels held
        [258917] = { name = "Righteous Flames", count = 1, health = 100 }, -- Ashvane Priest  Magic 8 Yes Minor DoT, Disorient
        -- Waycrest Manor
        [263891] = { name = "Grasping Thorns", count = 1, health = 100 }, -- Heartsbane Vinetwister Magic 4 Yes Stun
        [264378] = { name = "Fragment Soul", count = 1, health = 100 }, -- Coven Diviner  Magic 24  No  Minor DoT, but amplifies Consume Fragments cast so dispel quickly
        -- Atal'Dazar
        [253562] = { name = "Wildfire", count = 1, health = 100 }, -- Dazar'ai Augur  Magic 8 Yes Light DoT
        [255582] = { name = "Molten Gold", count = 1, health = 100 }, -- Priestess Alun'za  Magic 30  No  Moderate DoT
        [255041] = { name = "Terrifying Screech", count = 1, health = 100 }, -- Feasting Skyscreamer  Magic 6 Yes Fear
        [255371] = { name = "Terrifying Visage", count = 1, health = 100 }, -- Rezan  Magic 6 Yes Fear
        -- King's Rest
        [276031] = { name = "Pit of Despair", count = 1, health = 100 }, -- Minion of Zul Magic 6 Yes Fear
        --[265773] = { name = "Spit Gold", count = 1, health = 100 }, -- The Golden Serpent Magic 9 No  Heavy DoT, Spawns pool of gold on expiry
        --[270920] = { name = "Seduction", count = 1, health = 100 }, -- Queen Wasi Magic 30  No  Mind Control
        -- MOTHERLODE!!
        [280605] = { name = "Brain Freeze", count = 1, health = 100 }, -- Refreshment Vendor  Magic 6 Yes Stun
        [257337] = { name = "Shocking Claw", count = 1, health = 100 }, -- Coin-Operated Pummeler Magic 3 Yes Stun
        [270882] = { name = "Blazing Azerite", count = 1, health = 100 }, -- Coin-Operated Pummeler Magic 15  Yes +50% damage taken
        [268797] = { name = "Transmute: Enemy to Goo", count = 1, health = 100 }, -- Venture Co. Alchemist  Magic 10  Yes Polymorph
        [259856] = { name = "Chemical Burn", count = 1, health = 100 }, -- Rixxa Fluxflame  Magic 10  No  Moderate DoT
        -- Temple of Sethraliss
        [268013] = { name = "Flame Shock", count = 1, health = 100 }, -- Hoodoo Hexer Magic 15  No  Minor DoT
        [268008] = { name = "Snake Charm", count = 1, health = 100 }, -- Plague Doctor  Magic 15  No  Polymorph
        -- Underrot
        [272180] = { name = "Death Bolt", count = 1, health = 100 }, -- Grotesque Horror  Magic 6 Yes Moderate DoT, Stacks
        [272609] = { name = "Maddening Gaze", count = 1, health = 100 }, -- Faceless Corrupter  Magic 5 Yes Fear
        [320788] = { name = "Frozen Binds", count = 1, health = 100 }, -- диспел 9секунд (12-3)
        [322557] = { name = "Soul Split", count = 1, health = 100 },
        [328180] = { name = "Gripping Infection", count = 1, health = 100 },
        [329110] = { name = "Slime Injection", count = 1, health = 100 },
        [326632] = { name = "Stony Veins", count = 3, health = 100 },
        [326607] = { name = "Turn to Stone", count = 3, health = 100 },
        [325701] = { name = "Siphon Life", count = 1, health = 100 },
        [317936] = { name = "Forsworn Doctrine", count = 1, health = 100 },
        [317661] = { name = "Insidious Venom", count = 1, health = 100 },
        [328331] = { name = "Forced Confession", count = 1, health = 100 },
        [322818] = { name = "Lost Confidence", count = 1, health = 100 },
        [332707] = { name = "Shadow Word: Pain", count = 1, health = 100 },
        [332605] = { name = "Hex", count = 1, health = 100 },
        [340026] = { name = "Wailing Grief", count = 1, health = 100 },
        [325725] = { name = "Cosmic Artifice", count = 1, health = 100 }, ---- диспельнуть через 3с
        [323347] = { name = "Clinging Darkness", count = 4, health = 100 },
        [349954] = { name = "Dispel me", count = 1, health = 100 },
        [355915] = { name = "Dispel me", count = 1, health = 100 },
        [321038] = { name = "Dispel me", count = 1, health = 100 },
        [317963] = { name = "Dispel me", count = 1, health = 100 },
        [324293] = { name = "Dispel me", count = 1, health = 100 },
        [328664] = { name = "Dispel me", count = 1, health = 100 },
        [322977] = { name = "Dispel me", count = 1, health = 100 },
        [325876] = { name = "Dispel me", count = 1, health = 100 },
        [322410] = { name = "Dispel me", count = 1, health = 100 },
        [324914] = { name = "Dispel me", count = 1, health = 100 },
        [325224] = { name = "Dispel me", count = 1, health = 100 },
        [321968] = { name = "Dispel me", count = 1, health = 100 },
        [324859] = { name = "Dispel me", count = 1, health = 100 },
        [334505] = { name = "Dispel me", count = 1, health = 100 },
        [319626] = { name = "Dispel me", count = 1, health = 100 },
        [331399] = { name = "Dispel me", count = 3, health = 100 },
        [269301] = { name = "Putrid Blood", count = 1, health = 100 }, -- Unbound Abomination  Magic 12  No  Minor DoT, Stacks quickly     
		
		[372682] = { name = "Dispel me", count = 1, health = 100 },
		[391977] = { name = "Dispel me", count = 2, health = 100 },
		[425573] = { name = "Dispel me", count = 2, health = 100 },
		[392641] = { name = "Dispel me", count = 1, health = 100 },
		[377510] = { name = "Dispel me", count = 3, health = 100 },
		[392924] = { name = "Dispel me", count = 1, health = 100 },
		[373589] = { name = "Dispel me", count = 1, health = 100 },
		[386028] = { name = "Dispel me", count = 1, health = 100 },
		[386025] = { name = "Dispel me", count = 1, health = 100 },
		[386063] = { name = "Dispel me", count = 1, health = 100 },
		[373395] = { name = "Dispel me", count = 1, health = 100 },
		[376827] = { name = "Dispel me", count = 1, health = 100 },
		[381530] = { name = "Dispel me", count = 1, health = 100 },
		[387564] = { name = "Dispel me", count = 1, health = 100 },
		[375602] = { name = "Dispel me", count = 1, health = 100 },
		[370766] = { name = "Dispel me", count = 1, health = 100 },
		[386546] = { name = "Dispel me", count = 1, health = 100 },
		[386549] = { name = "Dispel me", count = 1, health = 100 },
		[371352] = { name = "Dispel me", count = 1, health = 100 },
		[377488] = { name = "Dispel me", count = 1, health = 100 },
		[396722] = { name = "Dispel me", count = 1, health = 100 },
		[384978] = { name = "Dispel me", count = 1, health = 100 },
		[388777] = { name = "Dispel me", count = 1, health = 100 },
		[388392] = { name = "Dispel me", count = 1, health = 100 },
		[227404] = { name = "Dispel me", count = 1, health = 100 },
		[209404] = { name = "Dispel me", count = 1, health = 100 },
		[209516] = { name = "Dispel me", count = 1, health = 100 },
		
		[209413] = { name = "Dispel me", count = 1, health = 100 },
		[211470] = { name = "Dispel me", count = 1, health = 100 },
		[397907] = { name = "Dispel me", count = 1, health = 100 },
		[208165] = { name = "Dispel me", count = 1, health = 100 },
		[214690] = { name = "Dispel me", count = 1, health = 100 },
		[214688] = { name = "Dispel me", count = 1, health = 100 },
		[152819] = { name = "Dispel me", count = 1, health = 100 },
		[397878] = { name = "Dispel me", count = 1, health = 100 },
		[395859] = { name = "Dispel me", count = 1, health = 100 },
		[114803] = { name = "Dispel me", count = 1, health = 100 },
		[106823] = { name = "Dispel me", count = 1, health = 100 },
		[356324] = { name = "Dispel me", count = 1, health = 100 },
		[356537] = { name = "Dispel me", count = 1, health = 100 },
		[357281] = { name = "Dispel me", count = 1, health = 100 },
		[355915] = { name = "Dispel me", count = 1, health = 100 },
		[385313] = { name = "Dispel me", count = 1, health = 100 },
		[357029] = { name = "Dispel me", count = 1, health = 100 },
		[357042] = { name = "Dispel me", count = 1, health = 100 },
		[347149] = { name = "Dispel me", count = 1, health = 100 },
		[356943] = { name = "Dispel me", count = 1, health = 100 },
		[356942] = { name = "Dispel me", count = 1, health = 100 },
		[349954] = { name = "Dispel me", count = 1, health = 100 },
		[350468] = { name = "Dispel me", count = 1, health = 100 },
		[356031] = { name = "Dispel me", count = 1, health = 100 },
		[355641] = { name = "Dispel me", count = 1, health = 100 },
		[355641] = { name = "Dispel me", count = 1, health = 100 },
		[373429] = { name = "Dispel me", count = 1, health = 100 },
		[373391] = { name = "Dispel me", count = 1, health = 100 },
		[373509] = { name = "Dispel me", count = 1, health = 100 },
		[164192] = { name = "Dispel me", count = 1, health = 100 },
		[172771] = { name = "Dispel me", count = 1, health = 100 },
		[284219] = { name = "Dispel me", count = 1, health = 100 },
		[299572] = { name = "Dispel me", count = 1, health = 100 },
		[294180] = { name = "Dispel me", count = 1, health = 100 },
		[398150] = { name = "Dispel me", count = 1, health = 100 },
		[294929] = { name = "Dispel me", count = 1, health = 100 },
		[397936] = { name = "Dispel me", count = 1, health = 100 },
		[294195] = { name = "Dispel me", count = 1, health = 100 },
		[295170] = { name = "Dispel me", count = 1, health = 100 },
		[295183] = { name = "Dispel me", count = 1, health = 100 },
		[285460] = { name = "Dispel me", count = 1, health = 100 },
		[228252] = { name = "Dispel me", count = 1, health = 100 },
		[227568] = { name = "Dispel me", count = 1, health = 100 },
		[29928] = { name = "Dispel me", count = 1, health = 100 },
		[228277] = { name = "Dispel me", count = 1, health = 100 },
		[228526] = { name = "Dispel me", count = 1, health = 100 },
		[228576] = { name = "Dispel me", count = 1, health = 100 },
		[241798] = { name = "Dispel me", count = 1, health = 100 },
		[228280] = { name = "Dispel me", count = 1, health = 100 },
		[238606] = { name = "Dispel me", count = 1, health = 100 },
		[227832] = { name = "Dispel me", count = 1, health = 100 },
		[228389] = { name = "Dispel me", count = 1, health = 100 },
		[229705] = { name = "Dispel me", count = 1, health = 100 },
		[229706] = { name = "Dispel me", count = 1, health = 100 },
		[229716] = { name = "Dispel me", count = 1, health = 100 },
		[229159] = { name = "Dispel me", count = 1, health = 100 },
		[229083] = { name = "Dispel me", count = 1, health = 100 },
		[351960] = { name = "Dispel me", count = 1, health = 100 },
		[395872] = { name = "Dispel me", count = 1, health = 100 },
		[381515] = { name = "Dispel me", count = 1, health = 100 },
		-- Uldaman
		[377405] = { name = "Dispel me", count = 1, health = 100 }, --
		[377510] = { name = "Dispel me", count = 5, health = 100 }, --
		-- Halls of Infusion
		[374724] = { name = "Dispel me", count = 1, health = 100 }, --
		[389179] = { name = "Dispel me", count = 1, health = 70 }, -- 1 БОСС + ВОЙДА ПОСЛЕ ДИСПЛ
		[385963] = { name = "Dispel me", count = 1, health = 70 }, -- 3БОС ЗАМЕДЛО  Dispel/freedom
		[387359] = { name = "Dispel me", count = 1, health = 70 }, --
		
		
    },
    poison = {
        -- Freehold
        [374389] = { name = "Dispel me", count = 1, health = 100 }, 
        [257436] = { name = "Poisoning Strike", count = 1, health = 100 }, --Irontide Corsair Poison  12  No  Minor DoT, Stacks
        -- Siege of Boralus
        [275835] = { name = "Stinging Venom", count = 1, health = 100 }, -- Coating  Ashvane Invader  Poison  10  No  Moderate DoT, Stacks
        -- Tol Dagor
        [257777] = { name = "Crippling Shiv", count = 1, health = 100 }, -- Jes Howlis  Poison  12  No  Minor DoT, -50% movement speed
        -- Atal'Dazar
        [252687] = { name = "Venomfang Strike", count = 1, health = 100 }, -- Shadowblade Stalker Poison  8 No  Doubles nature damage taken
        -- King's Rest
        [270865] = { name = "Hidden Blade", count = 1, health = 100 }, -- King A'akul Poison  8 No  Spawns poison pool underneath afflicted player every 2s
        [271564] = { name = "Embalming Fluid", count = 1, health = 100 }, -- Embalming Fluid  Poison  20  No  Light DoT, -10% Movement speed, Stacks
        [270507] = { name = "Poison Barrage", count = 1, health = 100 }, -- Spectral Beastmaster  Poison  20  No  Moderate DoT
        [267273] = { name = "Poison Nova", count = 1, health = 100 }, -- Zanazal the Wise Poison  20  Yes Moderate DoT
        -- MOTHERLODE!!
        [269302] = { name = "Toxic Blades", count = 1, health = 100 }, -- Hired Assassin  Poison  6 Yes Minor DoT
        -- Temple of Sethraliss
        [273563] = { name = "Neurotoxin", count = 1, health = 100 }, -- Sandswept Marksman  Poison  8 No  Player sleeps for 5s if they move
        [272657] = { name = "Noxious Breath", count = 1, health = 100 }, -- Scaled Krolusk Rider  Poison  9 Yes Minor DoT
        [267027] = { name = "Cytotoxin", count = 1, health = 100 }, -- Venomous Ophidian  Poison  6 No  Moderate DoT
        [325552] = { name = "Cytotoxic Slash", count = 1, health = 100 },
        [326092] = { name = "Debilitating Poison", count = 1, health = 100 },	--Если у танка не фул хп
        [334926] = { name = "Wretched Phlegm", count = 1, health = 100 },
        [272699] = { name = "Venomous Spit", count = 1, health = 100 }, -- Faithless Tender  Poison  9 No  Moderate DoT
        [338353] = { name = "Dispel me", count = 1, health = 100 }, --
        [321821] = { name = "Dispel me", count = 1, health = 100 }, --
        [324652] = { name = "Dispel me", count = 1, health = 100 }, --
        [319070] = { name = "Dispel me", count = 1, health = 100 }, --
        [328501] = { name = "Dispel me", count = 1, health = 100 }, --
        [320512] = { name = "Dispel me", count = 1, health = 100 }, --
        [327882] = { name = "Dispel me", count = 1, health = 100 }, --
        [328180] = { name = "Dispel me", count = 1, health = 100 }, --
		
        [300764] = { name = "Dispel me", count = 1, health = 100 }, --
        [156717] = { name = "Dispel me", count = 1, health = 100 }, --
        [227325] = { name = "Dispel me", count = 1, health = 100 }, --
        [228559] = { name = "Dispel me", count = 1, health = 100 }, --
        [229693] = { name = "Dispel me", count = 1, health = 100 }, --
		-- Uldaman
		[369417] = { name = "Venomous Fangs", count = 1, health = 100 } --
		-- Halls of Infusion
	
    },

    freedom = {
        [319941] = { name = "Stone Shattering Leap", count = 1, health = 100 }, -- 
        [330810] = { name = "Bind Soul", count = 1, health = 100 }, -- 
        [326827] = { name = "Dread Bindings", count = 1, health = 100 }, -- 
        [324608] = { name = "Charged Stomp", count = 1, health = 100 }, -- 
        [292942] = { name = "Iron Shackles", count = 1, health = 100 }, -- 
        [329326] = { name = "Dark Binding", count = 1, health = 100 }, -- 
        [295929] = { name = "Rats!", count = 1, health = 100 }, -- 
        [292910] = { name = "Shackles", count = 1, health = 100 }, -- 
        [334926] = { name = "Wretched Phlegm", count = 1, health = 100 }, -- 
        [329905] = { name = "Mass Slow", count = 1, health = 100 }, -- 
        [341746] = { name = "Rooted in Anima", count = 1, health = 100 }, -- 
        [324859] = { name = "Bramblethorn Entanglement", count = 1, health = 100 }, -- 
        [328180] = { name = "Gripping Infection", count = 1, health = 100 } -- 
    }
}
