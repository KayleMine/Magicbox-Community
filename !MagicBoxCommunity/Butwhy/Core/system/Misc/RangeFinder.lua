local addon, dark_addon = ...

local FriendItems  = {
    [2] = {
        37727, -- Ruby Acorn
    },
    [3] = {
        42732, -- Everfrost Razor
    },
    [5] = {
        8149, -- Voodoo Charm
        136605, -- Solendra's Compassion
        63427, -- Worgsaw
    },
    [8] = {
        34368, -- Attuned Crystal Cores
        33278, -- Burning Torch
    },
    [10] = {
        32321, -- Sparrowhawk Net
        17626, -- Frostwolf Muzzle
    },
    [15] = {
        1251, -- Linen Bandage
        2581, -- Heavy Linen Bandage
        3530, -- Wool Bandage
        3531, -- Heavy Wool Bandage
        6450, -- Silk Bandage
        6451, -- Heavy Silk Bandage
        8544, -- Mageweave Bandage
        8545, -- Heavy Mageweave Bandage
        14529, -- Runecloth Bandage
        14530, -- Heavy Runecloth Bandage
        21990, -- Netherweave Bandage
        21991, -- Heavy Netherweave Bandage
        34721, -- Frostweave Bandage
        34722, -- Heavy Frostweave Bandage
        38643, -- Thick Frostweave Bandage
        38640, -- Dense Frostweave Bandage
    },
    [20] = {
        21519, -- Mistletoe
    },
    [25] = {
        31463, -- Zezzak's Shard
        13289, -- Egan's Blaster
    },
    [30] = {
        1180, -- Scroll of Stamina
        1478, -- Scroll of Protection II
        3012, -- Scroll of Agility
        1712, -- Scroll of Spirit II
        2290, -- Scroll of Intellect II
        1711, -- Scroll of Stamina II
        34191, -- Handful of Snowflakes
    },
    [35] = {
        18904, -- Zorbin's Ultra-Shrinker
    },
    [40] = {
        34471, -- Vial of the Sunwell
    },
    [45] = {
        32698, -- Wrangling Rope
    },
    [60] = {
        32825, -- Soul Cannon
        37887, -- Seeds of Nature's Wrath
    },
    [70] = {
        41265, -- Eyesore Blaster
    },
    [80] = {
        35278, -- Reinforced Net
    },
    [100] = {
        41058, -- Hyldnir Harpoon
    },
    [150] = {
        46954, -- Flaming Spears
    },
}

local versionClientNew = 0;
local versionClientOld = 0;

local version, build, date, tocversion = GetBuildInfo();
if (string.find(version, "^1%.")) then
    --classic_era since 11300
    if (tocversion >= 11300) then
        versionClientNew = 1;
    else
        versionClientOld = 1;
    end
elseif (string.find(version, "^2%.")) then
    --bcc since 20500
    if (tocversion >= 20500) then
        versionClientNew = 2;
    else
        versionClientOld = 2;
    end
elseif (string.find(version, "^3%.")) then
    --wotlkc since 30400
    if (tocversion >= 30400) then
        versionClientNew = 3;
    else
        versionClientOld = 3;
    end
elseif (string.find(version, "^4%.")) then
    --cata since 40400?
    if (tocversion >= 40400) then
        versionClientNew = 4;
    else
        versionClientOld = 4;
    end
elseif (string.find(version, "^5%.")) then
    --mop since 50500?
    if (tocversion >= 50500) then
        versionClientNew = 5;
    else
        versionClientOld = 5;
    end
elseif (string.find(version, "^6%.")) then
    --wod since 60300?
    if (tocversion >= 60300) then
        versionClientNew = 6;
    else
        versionClientOld = 6;
    end
elseif (string.find(version, "^7%.")) then
    --legion since 70400?
    if (tocversion >= 70400) then
        versionClientNew = 7;
    else
        versionClientOld = 7;
    end
elseif (string.find(version, "^8%.")) then
    --bfa since 80400?
    if (tocversion >= 80400) then
        versionClientNew = 8;
    else
        versionClientOld = 8;
    end
elseif (string.find(version, "^9%.")) then
    --sl since 90300?
    if (tocversion >= 90300) then
        versionClientNew = 9;
    else
        versionClientOld = 9;
    end
else
    versionClientNew = tonumber(string.match(version,"^%d+"));
end


local function checkVersionOld(startVersion,endVersion)
	if startVersion == nil then return false; end
    if endVersion == nil then
        return (versionClientOld >= startVersion);
    else
        return (versionClientOld >= startVersion and versionClientOld <= endVersion);
    end
end

local function checkVersionNew(startVersion,endVersion)
	if startVersion == nil then return false; end
    if endVersion == nil then
        return (versionClientNew >= startVersion);
    else
        return (versionClientNew >= startVersion and versionClientNew <= endVersion);
    end
end

if (checkVersionOld(5) or checkVersionNew(5)) then
    FriendItems[1] = {
        90175, -- Gin-Ji Knife Set -- doesn't seem to work for pets (always returns nil)
    }
end
if (checkVersionOld(7) or checkVersionNew(7)) then
    FriendItems[4] = {
        129055, -- Shoe Shine Kit
    }
end
if (checkVersionOld(4) or checkVersionNew(4)) then
    FriendItems[7] = {
        61323, -- Ruby Seeds
    }
end
if (checkVersionOld(7) or checkVersionNew(7)) then
    FriendItems[38] = {
        140786, -- Ley Spider Eggs
    }
end
if (checkVersionOld(5) or checkVersionNew(5)) then
    FriendItems[55] = {
        74637, -- Kiryn's Poison Vial
    }
end
if (checkVersionOld(6) or checkVersionNew(6)) then
    FriendItems[50] = {
        116139, -- Haunting Memento
    }
end
if (checkVersionOld(7) or checkVersionNew(7)) then
    FriendItems[90] = {
        133925, -- Fel Lash
    }
end
if (checkVersionOld(5) or checkVersionNew(5)) then
    FriendItems[200] = {
        75208, -- Rancher's Lariat
    }
end


-- Pre-cache item names for performance
local preCachedItems = {}

local function preloadFriendItems()
    for range, items in pairs(FriendItems) do
        for _, item in ipairs(items) do
            local itemName = GetItemInfo(item)
            if itemName then
                preCachedItems[item] = itemName
            end
        end
    end
end

-- Call this once at initialization to populate preCachedItems
preloadFriendItems()

local function _IsItemInRange(item, unitID)
	if issecure() and IsItemInRange then --ояебу ну так точно нет проблем
        return IsItemInRange(item, unitID)
	end
	return false
end
 
dark_addon.RaidRanges = function(unitID)
    -- Проверяем возможность взаимодействия с юнитом
    if not UnitCanAssist("player", unitID) then
        return 1000 -- Вернуть максимальную дистанцию, если юнит недоступен
    end

    -- Проверяем диапазоны и предметы
    for range, items in pairs(FriendItems) do
        for _, item in ipairs(items) do
            if preCachedItems[item] and _IsItemInRange(item, unitID) then
                return range -- Немедленно вернуть диапазон, если условие выполнено
            end
        end
    end

    return 1000 -- Вернуть максимальную дистанцию, если ничего не найдено
end
