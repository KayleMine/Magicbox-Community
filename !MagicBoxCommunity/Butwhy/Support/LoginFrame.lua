--support functions etc.
local  addon, dark_addon = ...
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
-- Create the frame
local Login_Frame = CreateFrame("Frame", "Login_Frame", UIParent, "UIPanelDialogTemplate")
Login_Frame:SetSize(410, 190)
Login_Frame:SetPoint("CENTER")
Login_Frame:SetMovable(true)
Login_Frame:EnableMouse(true)
Login_Frame:RegisterForDrag("LeftButton")
Login_Frame:SetScript("OnDragStart", Login_Frame.StartMoving)
Login_Frame:SetScript("OnDragStop", Login_Frame.StopMovingOrSizing)


-- Create the checkbox
local instruction_check = CreateFrame("CheckButton", "instruction_check", Login_Frame, "ChatConfigCheckButtonTemplate")
instruction_check:SetPoint("TOPLEFT", 16, -155)

-- Add text to the checkbox
local instruction_text = instruction_check:CreateFontString(nil, "OVERLAY", "GameFontNormalLeftLightGreen")
instruction_text:SetPoint("LEFT", instruction_check, "RIGHT", 0, 1)
if GetLocale() == "ruRU" then
	instruction_text:SetText("Я прочитал, и понял что тут написано.")
else
	instruction_text:SetText("I've read text, and understand it.")	
end

local TitleBar_Name = instruction_check:CreateFontString(nil, "OVERLAY", "NumberFontNormalLargeYellow")
TitleBar_Name:SetPoint("TOPLEFT", instruction_check, "TOPLEFT", 205-85, 148)
TitleBar_Name:SetText("|cff8ccbffFunPlay|r - |CFF208ee8 Magic Box.|r")


local myLines = {}
for i = 1, 7 do
    myLines[i] = instruction_check:CreateFontString(nil, "OVERLAY", "DialogButtonNormalText")
    myLines[i]:SetPoint("TOPLEFT", instruction_check, "TOPLEFT", 16, 120 - (i-1)*17.7)
	myLines[i]:SetJustifyH("LEFT")

end

local centerLine = myLines[3]
local centerText = "Aload - An Example routine"
centerLine:SetText(centerText)
centerLine:SetJustifyH("CENTER")
centerLine:SetWidth(centerLine:GetStringWidth() + 90) -- add some padding to the width
centerLine:SetPoint("TOP", instruction_check, "TOP") -- center the line vertically

if GetLocale() == "ruRU" then
myLines[1]:SetText("1. Макросы в Discord канале.")
myLines[2]:SetText("2. Пиши /fd list:")
-- line 3
myLines[4]:SetText("     Теперь пиши: /fd load Aload")
myLines[5]:SetText("3. Нажми на 1 кнопку и готово.")
myLines[6]:SetText("4. Вопросы и Баг-репорты в Discord.")
else	
myLines[1]:SetText("1. Macro can be found in Discord channel.")
myLines[2]:SetText("2. Type /fd list and get all profiles:")
-- line 3
myLines[4]:SetText("2.2 Now type in chat: /fd load Aload")
myLines[5]:SetText("3. Now switch-on 1st button, and you done.")
myLines[6]:SetText("4. For support or bug-report visit discord.")
end

-- create the button with blue color
local myButton = CreateFrame("Button", "MyButton", Login_Frame, "UIPanelButtonTemplate")
myButton:SetPoint("TOPLEFT", Login_Frame, "TOPLEFT", 330, -150)
myButton:SetText("Discord")
myButton:SetSize(65, 28)

-- create a texture for the button background
local myTexture = myButton:CreateTexture(nil, "BACKGROUND")
myTexture:SetAllPoints()
myTexture:SetTexture(0, 0, 1) -- blue color

-- create a texture for the border
local borderTexture = myButton:CreateTexture(nil, "OVERLAY")
borderTexture:SetTexture("Interface\\BUTTONS\\UI-Quickslot2")
borderTexture:SetSize(32, 32)
borderTexture:SetPoint("CENTER", myButton, "CENTER", 0, 0)
borderTexture:SetVertexColor(1, 1, 1, 1)

-- define the animation
local frame = CreateFrame("Frame", nil, myButton)
frame.elapsed = 0
frame:SetScript("OnUpdate", function(self, elapsed)
  frame.elapsed = frame.elapsed + elapsed
  
  -- calculate the RGB values based on time
  local r = math.abs(math.sin(frame.elapsed * 2))
  local g = math.abs(math.sin(frame.elapsed * 3))
  local b = math.abs(math.sin(frame.elapsed * 5))
  
  -- set the color of the border texture
  borderTexture:SetVertexColor(r, g, b)
  
  -- anchor the border texture to the button
  borderTexture:ClearAllPoints()
  borderTexture:SetPoint("TOPLEFT", myButton, "TOPLEFT", -17, 7)
  borderTexture:SetPoint("BOTTOMRIGHT", myButton, "BOTTOMRIGHT", 19, -7)
end)

-- create the explosion particle system
local explosion = CreateFrame("PlayerModel", nil, myButton)
explosion:SetPoint("CENTER", myButton, "CENTER", 0, 0)
explosion:SetSize(64, 64)

-- hide the explosion by default
explosion:Hide()

-- create the timer for animating the explosion
local explosionTimer = nil

-- define the duration of the animation (in seconds)
local duration = 1

-- create the new frame
local myCopyFrame = CreateFrame("Frame", "MyCopyFrame", UIParent)
myCopyFrame:SetSize(200, 250)
myCopyFrame:SetPoint("CENTER")
myCopyFrame:Hide()

-- create the edit box
local myEditBox = CreateFrame("EditBox", "MyEditBox", myCopyFrame)
myEditBox:SetMultiLine(true)
myEditBox:SetMaxLetters(0)
myEditBox:EnableMouse(true)
myEditBox:SetAutoFocus(false)
myEditBox:SetFontObject("GameFontHighlightSmall")
myEditBox:SetWidth(myCopyFrame:GetWidth() - 20)
myEditBox:SetHeight(myCopyFrame:GetHeight() - 40)
myEditBox:SetPoint("TOPLEFT", 10, -10)
myEditBox:SetFrameStrata("DIALOG") -- make the edit box topmost

-- create the frame for the border
local myEditBoxBorder = CreateFrame("Frame", "MyEditBoxBorder", myEditBox, BackdropTemplateMixin and "BackdropTemplate")
myEditBoxBorder:SetPoint("TOPLEFT", -5, 7)
myEditBoxBorder:SetPoint("BOTTOMRIGHT", 7, -8)
myEditBoxBorder:SetBackdrop({
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    edgeSize = 16,
    insets = { left = 6, right = 6, top = 6, bottom = 6 },
})
myEditBoxBorder:SetBackdropBorderColor(0.8, 0.8, 0.8, 1)

-- create the texture for the background
local myEditBoxBG = myEditBox:CreateTexture(nil, "BACKGROUND")
myEditBoxBG:SetAllPoints(false)
myEditBoxBG:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background", 0.8) -- set the background color
myEditBoxBG:SetPoint("TOPLEFT", -4, 5)
myEditBoxBG:SetPoint("BOTTOMRIGHT", 6, -5)

-- create the close button with higher frame level
local myCloseButton = CreateFrame("Button", "MyCloseButton", myCopyFrame, "UIPanelCloseButton")
myCloseButton:SetPoint("TOPRIGHT", 0, 0)
myCloseButton:SetFrameLevel(myEditBox:GetFrameLevel() + 1) -- set the frame level higher than the edit box
myCloseButton:SetFrameStrata("DIALOG") -- make the close button topmost
--set the button script
myButton:SetScript("OnClick", function(self, button, down)
    local textToCopy = "Discord.gg/GVyXrjN9kM"
    if textToCopy then
        myEditBox:SetText(textToCopy)
        myCopyFrame:Show()
    end
  if not explosionTimer then
    -- set the display ID of the explosion effect
    local modelFileID = [[spells\ribbontrail_rainbow.m2]] -- model file ID for the explosion effect
    explosion:SetModel(1417024)
	explosion:SetScale(3) 
    --spells/ribbontrail_rainbow.m2"
    -- set the animation of the explosion effect
    explosion:SetAnimation(3)
    
    -- show the explosion
    explosion:Show()
    
    -- start the animation timer
    local startTime = GetTime()
    explosionTimer = C_Timer.NewTicker(0.05, function()
      -- calculate the elapsed time
      local elapsedTime = GetTime() - startTime
      
      -- stop the animation after the desired duration
      if elapsedTime >= duration then
        -- hide the explosion
        explosion:Hide()
        
        -- stop the animation timer
        explosionTimer:Cancel()
        explosionTimer = nil
      end
    end)
  end

end)


-- Show the frame
Login_Frame:Show()

-- Create a function to update the checkbox state
local function updateCheckboxState()
    local isChecked = dark_addon.settings.fetch('login_check') -- assume that we have a variable called MyAddonSettings.isChecked that stores the state of the checkbox
    instruction_check:SetChecked(isChecked)
	if isChecked then
		 Login_Frame:Hide()
	else
		 Login_Frame:Show()
	end
end

-- Call the update function when the addon is loaded
local L_Frame = CreateFrame("Frame")
L_Frame:RegisterEvent("ADDON_LOADED")
L_Frame:SetScript("OnEvent", function(self, event, addonName)
    if event == "ADDON_LOADED" and addonName == "!MagicBoxCommunity" then
        updateCheckboxState()
    end
end)

-- Create a function to handle the checkbox click event
local function handleCheckboxClick()
    local isChecked = instruction_check:GetChecked()
    dark_addon.settings.store('login_check', isChecked) -- assume that we want to store the state of the checkbox in a variable called MyAddonSettings.isChecked
end

-- Register the checkbox for the click event
instruction_check:SetScript("OnClick", handleCheckboxClick)

