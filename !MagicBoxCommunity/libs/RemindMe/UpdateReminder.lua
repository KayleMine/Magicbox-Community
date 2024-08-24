local frame = CreateFrame("Button","UIPanelButtonTemplateTest",
GameMenuFrame, "UIPanelButtonTemplate")
frame:SetHeight(20)
frame:SetWidth(145)
frame:ClearAllPoints()
frame:SetPoint("TOP", 0, -72)
frame:RegisterForClicks("AnyUp")

local function b()
    local c = {year = 2022, month = 10, day = 01, hour = 00, min = 00, sec = 00} -- new patch in next month.
    local d = time(c)
    return d
end
local function e()
    local f = time()
    return f
end
local function g()
    local function h(time)
	local i = floor(time / 86400)
	local j = floor(mod(time, 86400) / 3600)
	local k = floor(mod(time, 3600) / 60)
	local l = floor(mod(time, 60))
	return format("Обнови через %d Д.", i, j, k, l)
    end
    local m = b() - e()
    local n = h(m)
    return n
end
local function g2()
    local function h(time)
	local i = floor(time / 86400)
	local j = floor(mod(time, 86400) / 3600)
	local k = floor(mod(time, 3600) / 60)
	local l = floor(mod(time, 60))
	return format("Update after %d D.", i, j, k, l)
    end
    local m = b() - e()
    local n = h(m)
    return n
end

local function g3()
    local function h(time)
	local i = floor(time / 86400)
	local j = floor(mod(time, 86400) / 3600)
	local k = floor(mod(time, 3600) / 60)
	local l = floor(mod(time, 60))
	return format("%d", i, j, k, l)
    end
    local m = b() - e()
    local n = h(m)
    return n
end

if (GetLocale() == "ruRU") then
frame:SetText(g())
else
frame:SetText(g2())
end


frame:SetScript("OnClick", function()
if (GetLocale() == "ruRU") then
if e() < b() then
    return message("Addon updated!\n\n|cff00ff52Не нужно обновлять.|r")
elseif e() >= b() then
    return message("Аддон вероятно устарел".." на "..g3().." дней!\n\n|cffFFFFFFОткройте раздел|r |cff00ff52Community|r|cffFFFFFF, в софте. \n\ Свяжитесь с продавцом.|r")
end
else
if e() < b() then
    return message("Addon updated!\n\n|cff00ff52Not need to update.|r")
elseif e() >= b() then
    return message("Probably outdated "..g3().." days!\n\n|cffFFFFFFOpen |r |cff00ff52Community|r|cffFFFFFF, in software. \n\ Contact with seller.|r")
end
end
end )