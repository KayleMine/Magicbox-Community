local addon, dark_addon = ...

dark_addon.interface.buttons = {
  buttons = { }
}

local buttons = dark_addon.interface.buttons.buttons
local button_size = 42
local button_padding = 2
local container_frame = CreateFrame('frame', 'dr_container_frame', UIParent)
local first_button
local last_button

fontObject = CreateFont("dark_addon_regular")
fontObject:SetFont("Interface\\Addons\\!MagicBoxCommunity\\Butwhy\\Core\\media\\OpenSans-Regular.ttf", button_size / 4,"OUTLINE, MONOCHROME")

fontObject = CreateFont("dark_addon_small")
fontObject:SetFont("Interface\\Addons\\!MagicBoxCommunity\\Butwhy\\Core\\media\\OpenSans-Regular.ttf", 12,"OUTLINE, MONOCHROME")

fontObject = CreateFont("dark_addon_bold")
fontObject:SetFont("Interface\\Addons\\!MagicBoxCommunity\\Butwhy\\Core\\media\\OpenSans-Bold.ttf", button_size / 4,"OUTLINE, MONOCHROME")

fontObject = CreateFont("dark_addon_icon")
fontObject:SetFont("Interface\\Addons\\!MagicBoxCommunity\\Butwhy\\Core\\media\\FontAwesomeProRegular.otf", button_size / 2,"OUTLINE, MONOCHROME")

container_frame.moving = false
container_frame:SetPoint('CENTER', UIParent)
container_frame:SetFrameStrata('MEDIUM')
container_frame:SetMovable(true)
container_frame:EnableMouse(true)
container_frame:RegisterForDrag('LeftButton')
container_frame:SetScript('OnDragStart', container_frame.StartMoving)
container_frame:SetScript('OnDragStop', container_frame.StopMovingOrSizing)

container_frame.text = container_frame:CreateFontString()
container_frame.text:SetAllPoints(true)
container_frame.text:SetFontObject("dark_addon_bold")
container_frame.text:SetText('Перетащи меня!')
container_frame.text:Hide()

container_frame.background = container_frame:CreateTexture()
container_frame.background:SetColorTexture(0, 0, 0, 0.75)
container_frame.background:SetAllPoints(container_frame)
container_frame.background:SetDrawLayer('BACKGROUND')

local tooltip_frame = CreateFrame('frame', 'dr_tooltip_frame', container_frame)

tooltip_frame.text = tooltip_frame:CreateFontString()
tooltip_frame.text:SetFontObject("dark_addon_small")
tooltip_frame:SetFrameStrata('HIGH')

tooltip_frame:SetWidth(100)
tooltip_frame:SetHeight(100)

tooltip_frame.background = tooltip_frame:CreateTexture()
tooltip_frame.background:SetColorTexture(0, 0, 0, 0.75)
tooltip_frame.background:SetAllPoints(tooltip_frame)
tooltip_frame.background:SetDrawLayer('BACKGROUND')

tooltip_frame.gradient = tooltip_frame:CreateTexture()
tooltip_frame.gradient:SetDrawLayer('ARTWORK')
do
  local minR, minG, minB = dark_addon.interface.color.hexToRgb(dark_addon.interface.color.red)
  local maxR, maxG, maxB = dark_addon.interface.color.hexToRgb(dark_addon.interface.color.dark_grey)
  tooltip_frame.gradient:SetColorTexture(1, 1, 1, 0.75)
  tooltip_frame.gradient:SetGradient('VERTICAL', {r=maxR, g=maxG, b=maxB, a=1}, {r=minR, g=minG, b=minB, a=1})   -- ("HORIZONTAL", {r=1, g=0, b=0, a=1}, {r=0, g=0, b=1, a=1})
end
tooltip_frame.gradient:SetPoint("TOPLEFT", tooltip_frame ,"TOPLEFT", button_padding, -button_padding)
tooltip_frame.gradient:SetPoint("BOTTOMRIGHT", tooltip_frame ,"BOTTOMRIGHT", -button_padding, button_padding)


local buttons_frame = CreateFrame('frame', 'dr_buttons_frame', container_frame)
buttons_frame:SetAllPoints(container_frame)

function dark_addon.interface.buttons.add(button)
  local frame = CreateFrame('frame', 'dr_button_' .. table.size(buttons), buttons_frame)
  local index = table.size(buttons)
  local offset = ( index * button_size ) + ( index * button_padding )

  frame.button = button
  frame.index = index
  frame:SetPoint('CENTER', container_frame)
  frame:SetPoint('LEFT', container_frame, 'LEFT', offset + 2, 0)
  frame:SetWidth(button_size)
  frame:SetHeight(button_size)
  frame:EnableMouse(true)
  frame:SetFrameStrata('MEDIUM')

  frame.background = frame:CreateTexture()
  frame.background:SetDrawLayer('BACKGROUND', 1)
  frame.background:SetAllPoints(frame)

  function frame.background:setColor(color)
    local r, g, b = dark_addon.interface.color.hexToRgb(color)
    self:SetColorTexture(r, g, b, 1)
  end

  function frame.background:setGradient(colorA, colorB)
    local minR, minG, minB = dark_addon.interface.color.hexToRgb(colorA)
    local maxR, maxG, maxB = dark_addon.interface.color.hexToRgb(colorB)
    self:SetColorTexture(1, 1, 1, 0.85)
    self:SetGradient('VERTICAL', {r=maxR, g=maxG, b=maxB, a=1}, {r=minR, g=minG, b=minB, a=1}) 
  end
  if button.color2 then
    frame.background:setColor('#ffffff')
    frame.background:setGradient(button.color, button.color2)
  else

  end

  -- frame.outline = frame:CreateTexture('background')
  -- frame.outline:SetColorTexture(r, g, b, 0.5)
  -- frame.outline:SetDrawLayer('BACKGROUND', -1)
  -- frame.outline:SetPoint('TOPLEFT', frame, 'TOPLEFT', -1, 1)
  -- frame.outline:SetPoint('BOTTOMRIGHT', frame, 'BOTTOMRIGHT', 1, -1)

  frame.text = frame:CreateFontString()
  frame.text:SetAllPoints(true)
  frame.text:SetFontObject("dark_addon_bold")
  frame.text:SetText(button.label)

  button.frame = frame

  frame:SetScript('OnMouseDown', function()
    button:callback()
  end)

  frame:SetScript('OnEnter', function(self)
    if button.state then
      button:set_color_on(0.75)
    else
      button:set_color_off(0.75)
    end
    local x, y = GetCursorPosition()
    tooltip_frame:Show()
    tooltip_frame.text:SetText(button.button.label)
    tooltip_frame:SetPoint("TOPLEFT", self, "BOTTOMLEFT", -2, -3)
    tooltip_frame.text:SetPoint("TOPLEFT", tooltip_frame, "TOPLEFT", 5, -5)
    tooltip_frame:SetWidth(tooltip_frame.text:GetStringWidth() + 11)
    tooltip_frame:SetHeight(tooltip_frame.text:GetHeight() + 9)

    -- tooltip_frame.text:SetWidth(tooltip_frame:GetRight() - tooltip_frame:GetLeft() - 10)
    -- tooltip_frame:SetHeight(tooltip_frame.text:GetHeight() + 15)
  end)

  frame:SetScript('OnLeave', function()
    if button.state then
      button:set_color_on(1)
    else
      button:set_color_off(1)
    end
    tooltip_frame:Hide()
  end)

  button:init()

  buttons[button.name] = button
  container_frame:SetWidth((table.size(buttons) * button_size) + (table.size(buttons) * button_padding) + 2)
  container_frame:SetHeight(button_size + button_padding + 2)

  return frame
end


function dark_addon.interface.buttons.addNoColor(button)
  local frame = CreateFrame('frame', 'dr_button_' .. table.size(buttons), buttons_frame)
  local index = table.size(buttons)
  local offset = ( index * button_size ) + ( index * button_padding )

  frame.button = button
  frame.index = index
  frame:SetPoint('CENTER', container_frame)
  frame:SetPoint('LEFT', container_frame, 'LEFT', offset + 2, 0)
  frame:SetWidth(button_size)
  frame:SetHeight(button_size)
  frame:EnableMouse(true)
  frame:SetFrameStrata('MEDIUM')

  frame.background = frame:CreateTexture()
  frame.background:SetDrawLayer('BACKGROUND', 1)
  frame.background:SetAllPoints(frame)


  function frame.background:setGradient(colorA, colorB)
    local minR, minG, minB = dark_addon.interface.color.hexToRgb(colorA)
    local maxR, maxG, maxB = dark_addon.interface.color.hexToRgb(colorB)
    self:SetColorTexture(1, 1, 1, 0.85)
    self:SetGradient('VERTICAL', {r=maxR, g=maxG, b=maxB, a=1}, {r=minR, g=minG, b=minB, a=1}) 
  end
  if button.color2 then

    frame.background:setGradient(button.color, button.color2)
  else

  end

  -- frame.outline = frame:CreateTexture('background')
  -- frame.outline:SetColorTexture(r, g, b, 0.5)
  -- frame.outline:SetDrawLayer('BACKGROUND', -1)
  -- frame.outline:SetPoint('TOPLEFT', frame, 'TOPLEFT', -1, 1)
  -- frame.outline:SetPoint('BOTTOMRIGHT', frame, 'BOTTOMRIGHT', 1, -1)

  frame.text = frame:CreateFontString()
  frame.text:SetAllPoints(true)
  frame.text:SetFontObject("dark_addon_bold")
  frame.text:SetText(button.label)

  button.frame = frame

  frame:SetScript('OnMouseDown', function()
    button:callback()
  end)

  frame:SetScript('OnEnter', function(self)
    local x, y = GetCursorPosition()
    tooltip_frame:Show()
    tooltip_frame.text:SetText(button.button.label)
    tooltip_frame:SetPoint("TOPLEFT", self, "BOTTOMLEFT", -2, -3)
    tooltip_frame.text:SetPoint("TOPLEFT", tooltip_frame, "TOPLEFT", 5, -5)
    tooltip_frame:SetWidth(tooltip_frame.text:GetStringWidth() + 11)
    tooltip_frame:SetHeight(tooltip_frame.text:GetHeight() + 9)

    -- tooltip_frame.text:SetWidth(tooltip_frame:GetRight() - tooltip_frame:GetLeft() - 10)
    -- tooltip_frame:SetHeight(tooltip_frame.text:GetHeight() + 15)
  end)

  frame:SetScript('OnLeave', function()
    tooltip_frame:Hide()
  end)

  button:init()

  buttons[button.name] = button
  container_frame:SetWidth((table.size(buttons) * button_size) + (table.size(buttons) * button_padding) + 2)
  container_frame:SetHeight(button_size + button_padding + 2)

  return frame
end

function dark_addon.interface.buttons.add_toggle(button)
  dark_addon.interface.buttons.add({
    button = button,
    name = button.name,
    label = button.label or false,
    core = button.core or false,
    label = button.on.text,
    color = button.on.color or false,
    state = false,
    set_color_on = function(self, ratio)
      if button.on.color2 then
        self.frame.background:setColor('#ffffff')
        self.frame.background:setGradient(
          dark_addon.interface.color.ratio(button.on.color, ratio),
          dark_addon.interface.color.ratio(button.on.color2, ratio)
        )
      else
        self.frame.background:setColor(
          dark_addon.interface.color.ratio(button.on.color, ratio)
        )
      end
    end,
    toggle_on = function(self)
      self.frame.text:SetText(button.on.label)
      self:set_color_on(1)
      if button.label then
        --dark_addon.interface.status_override(button.label .. ' work? again?', 1)
      end
    end,
    set_color_off = function(self, ratio)
      if button.off.color2 then
        self.frame.background:setColor('#ffffff')
        self.frame.background:setGradient(
          dark_addon.interface.color.ratio(button.off.color, ratio),
          dark_addon.interface.color.ratio(button.off.color2, ratio)
        )
      else
        self.frame.background:setColor(
          dark_addon.interface.color.ratio(button.off.color, ratio)
        )
      end
    end,
    toggle_off = function(self)
      self.frame.text:SetText(button.off.label)
      self:set_color_off(1)
      if button.label then
        --dark_addon.interface.status_override(button.label .. ' disable.', 1)
      end
    end,
    callback = function(self)
      self.state = not self.state
      if button.callback then
        button.callback(self)
      end
      if self.state then
        self:toggle_on()
      else
        self:toggle_off()
      end
      dark_addon.settings.store_toggle(button.name, self.state)
    end,
    init = function(self)
      local state = dark_addon.settings.fetch_toggle(button.name, false)
      self.state = state
      if state then
        self.frame.text:SetText(button.on.label)
        if button.on.color2 then
          self.frame.background:setColor('#ffffff')
          self.frame.background:setGradient(button.on.color, button.on.color2)
        else
          self.frame.background:setColor(button.on.color)
        end
      else
        self.frame.text:SetText(button.off.label)
        if button.off.color2 then
          self.frame.background:setColor('#ffffff')
          self.frame.background:setGradient(button.off.color, button.off.color2)
        else
          self.frame.background:setColor(button.off.color)
        end
      end
      if button.font then
        self.frame.text:SetFontObject(button.font)
      end
    end
  })
end

function dark_addon.interface.buttons.add_toggleNoColor(button)
  dark_addon.interface.buttons.addNoColor({
    button = button,
    name = button.name,
    label = button.label or false,
    core = button.core or false,
    label = button.on.text,
    color = button.on.color or false,
    state = false,

    toggle_on = function(self)
      self.frame.text:SetText(button.on.label)
      if button.label then
        --dark_addon.interface.status_override(button.label .. ' work? again?', 1)
      end
    end,

    toggle_off = function(self)
      self.frame.text:SetText(button.off.label)
      if button.label then
        --dark_addon.interface.status_override(button.label .. ' disable.', 1)
      end
    end,
    callback = function(self)
      self.state = not self.state
      if button.callback then
        button.callback(self)
      end
      if self.state then
        self:toggle_on()
      else
        self:toggle_off()
      end
      dark_addon.settings.store_toggle(button.name, self.state)
    end,
    init = function(self)
      local state = dark_addon.settings.fetch_toggle(button.name, false)
      self.state = state
      if state then
        self.frame.text:SetText(button.on.label)
        if button.on.color2 then
          self.frame.background:setColor('#ffffff')
        else end
      else
        self.frame.text:SetText(button.off.label)
        if button.off.color2 then
          self.frame.background:setColor('#ffffff')
        else end
      end
      if button.font then
        self.frame.text:SetFontObject(button.font)
      end
    end
  })
end

_G['button'] = buttons

function dark_addon.interface.buttons.reset()
  for key, button in pairs(buttons) do
    if not button.core then
      button.frame:Hide()
      buttons[button.name] = nil
    else
      local state = dark_addon.settings.fetch_toggle(button.name, button.default, button.core)
      button.state = state
      if state then
        button:toggle_on()
      else
        button:toggle_off()
      end
    end
  end
  container_frame:SetWidth((table.size(buttons) * button_size) + (table.size(buttons) * button_padding) + 2)
  container_frame:SetHeight(button_size + button_padding + 2)
end

function dark_addon.interface.buttons.resize()
  local fontObject
  button_size = dark_addon.settings.fetch('button_size', 32)

  fontObject = CreateFont("dark_addon_regular")
  fontObject:SetFont("Interface\\Addons\\!MagicBoxCommunity\\Butwhy\\Core\\media\\OpenSans-Regular.ttf", button_size / 4,"OUTLINE, MONOCHROME")

  fontObject = CreateFont("dark_addon_bold")
  fontObject:SetFont("Interface\\Addons\\!MagicBoxCommunity\\Butwhy\\Core\\media\\OpenSans-Bold.ttf", button_size / 4,"OUTLINE, MONOCHROME")

  fontObject = CreateFont("dark_addon_icon")
  fontObject:SetFont("Interface\\Addons\\!MagicBoxCommunity\\Butwhy\\Core\\media\\FontAwesomeProRegular.otf", button_size / 2,"OUTLINE, MONOCHROME")

  for key, button in pairs(buttons)  do
    local offset = ( button.frame.index * button_size ) + ( button.frame.index * button_padding )
    button.frame:SetPoint('LEFT', container_frame, 'LEFT', offset + 2, 0)
    button.frame:SetWidth(button_size)
    button.frame:SetHeight(button_size)
  end
  container_frame:SetWidth((table.size(buttons) * button_size) + (table.size(buttons) * button_padding) + 2)
  container_frame:SetHeight(button_size + button_padding + 2)
end
local R_c = GetItemIcon(124635);
local T_c = GetItemIcon(144258);


L_Move = 'Block | Unlock move panel'
L_Hide = 'hide window'
L_Show = 'show window'
L_Size = 'Change button size.'
L_Enable = 'Enable profile. \n [master_toggle]'
L_CDS = 'Enable CD. \n [cooldowns]'
L_Kick = 'Kick Cast. \n [interrupts]'

L_TRNK = 'Trinkets'
L_RNGS = 'Rings'
L_AITMS = 'Auto-Items'
L_ITMS = 'items!'
L_ITMS = 'items! \n [items]'

dark_addon.on_ready(function()
  button_size = dark_addon.settings.fetch('button_size', button_size)

  fontObject = CreateFont("dark_addon_regular")
  fontObject:SetFont("Interface\\Addons\\!MagicBoxCommunity\\Butwhy\\Core\\media\\OpenSans-Regular.ttf", button_size / 4,"OUTLINE, MONOCHROME")

  fontObject = CreateFont("dark_addon_bold")
  fontObject:SetFont("Interface\\Addons\\!MagicBoxCommunity\\Butwhy\\Core\\media\\OpenSans-Bold.ttf", button_size / 4,"OUTLINE, MONOCHROME")

  fontObject = CreateFont("dark_addon_icon")
  fontObject:SetFont("Interface\\Addons\\!MagicBoxCommunity\\Butwhy\\Core\\media\\FontAwesomeProRegular.otf", button_size / 2,"OUTLINE, MONOCHROME")

  dark_addon.commands.register({
    command = 'move',
    arguments = { },
    text = L_Move,
    callback = function(rotation_name)
      if container_frame.moving then
        container_frame.moving = false
        buttons_frame:Show()
        container_frame.text:Hide()
      else
        container_frame.moving = true
        buttons_frame:Hide()
        container_frame.text:Show()
      end
      return true
    end
  })
    dark_addon.commands.register({
    command = {'hide'},
    arguments = { },
    text = L_Hide,
    callback = function(ssc)
          state = 1
		   dark_addon.settings.store('ssc', state)
			ReloadUI();
	  return true
      end
  })    
  
  dark_addon.commands.register({
    command = {'show'},
    arguments = { },
    text = L_Show,
    callback = function(ssc)
          state = 2
		   dark_addon.settings.store('ssc', state)
			ReloadUI();
	  return true
      end
  })

  dark_addon.commands.register({
    command = {'size', 'resize'},
    arguments = {
      'button_size'
    },
    text = L_Size,
    callback = function(button_size)
      local size = tonumber(button_size)
      print(size, button_size)
      if size then
        dark_addon.settings.store('button_size', size)
        dark_addon.interface.buttons.resize()
        return true
      else
        return false
      end
    end
  })

  dark_addon.interface.buttons.add_toggle({
    core = true,
    name = 'master_toggle',
    label = L_Enable,
    font = 'dark_addon_icon',
    on = {
      label = dark_addon.interface.icon('toggle-on'),
      color = dark_addon.interface.color.green,
      color2 = dark_addon.interface.color.green
    },
    off = {
      label = dark_addon.interface.icon('toggle-off'),
      color = dark_addon.interface.color.red,
      color2 = dark_addon.interface.color.red
    }
  })
  
  dark_addon.interface.buttons.add_toggle({
    core = true,
    name = 'cooldowns',
    label = L_CDS,
    font = 'dark_addon_icon',
    on = {
      label = dark_addon.interface.icon('alarm-clock'),
      color = dark_addon.interface.color.green,
      color2 = dark_addon.interface.color.green
    },
    off = {
      label = dark_addon.interface.icon('alarm-clock'),
      color = dark_addon.interface.color.red,
      color2 = dark_addon.interface.color.red
    }
  })

  dark_addon.interface.buttons.add_toggle({
    core = true,
    name = 'interrupts',
      label = L_Kick,
    font = 'dark_addon_icon',
    on = {
      label = dark_addon.interface.icon('hand-paper'),
      color = dark_addon.interface.color.green,
      color2 = dark_addon.interface.color.green
    },
    off = {
      label = dark_addon.interface.icon('hand-paper'),
      color = dark_addon.interface.color.red,
      color2 = dark_addon.interface.color.red
    }
  })  

  dark_addon.interface.buttons.add_toggle({
    core = true,
    name = 'blacklist_tgl',
      label = "Blacklist enabled?",
    font = 'dark_addon_icon',
    on = {
      label = dark_addon.interface.icon('hand-paper'),
      color = dark_addon.interface.color.green,
      color2 = dark_addon.interface.color.green
    },
    off = {
      label = dark_addon.interface.icon('hand-paper'),
      color = dark_addon.interface.color.red,
      color2 = dark_addon.interface.color.red
    }
  })  

    dark_addon.interface.buttons.add_toggle({
		core = true,
        name = 'blacklist',
        label = 'Blacklist Healing',
        font = 'dark_addon_icon',
        on = {
            label = dark_addon.interface.icon('cog'),
            color = dark_addon.interface.color.green,
            color2 = dark_addon.interface.color.green
        },
        off = {
            label = dark_addon.interface.icon('cog'),
            color = dark_addon.interface.color.red,
            color2 = dark_addon.interface.color.red
        },
        callback = function(self)

		  if dark_addon._blacklisted.parent:IsShown() then
			dark_addon._blacklisted.parent:Hide()
		  else
			dark_addon._blacklisted.parent:Show()
		  end
		  return true

        end
    })
		
local item_s = {
key = "global_settings",
title = L_ITMS,
width = 280,
height = 210,
--	color = "3cff00",
color = "00a2ff",
resize = false,
show = false,
template = {
{ type = "rule"},
{ type = 'header', text = L_AITMS,align = 'CENTER'}, 
{ type = "rule"},
{ type = "spacer", size = 5},
{ key = 'Trinkets_k', type = 'dropdown', text = "\124T"..T_c..":22:22\124t :: "..L_TRNK, desc = '', default = 'Empty',
list = {
{ key = 'Empty', text = 'None' },
{ key = 'o', text = '13' },
{ key = 't', text = '14' },
{ key = 'ot', text = '13 & 14' },
} },
{ key = 'Rings_k', type = 'dropdown', text = "\124T"..R_c..":22:22\124t :: "..L_RNGS, desc = '', default = 'Empty',
list = {
{ key = 'Empty', text = 'None' },
{ key = 'o', text = '11' },
{ key = 't', text = '12' },
{ key = 'ot', text = '11 & 12' },
} },
{ type = "rule"},


}
}

item_menu = dark_addon.interface.builder.buildGUI(item_s)

dark_addon.interface.buttons.add_toggle({
core = true,
name = 'items',
label = L_ITMS,
font = 'dark_addon_icon',
on = {
label = dark_addon.interface.icon('coffee'),
color = dark_addon.interface.color.green,
color2 = dark_addon.interface.color.green
},
off = {
label = dark_addon.interface.icon('coffee'),
color = dark_addon.interface.color.red,
color2 = dark_addon.interface.color.red
},
callback = function(self)
if item_menu.parent:IsShown() then
item_menu.parent:Hide()
else
item_menu.parent:Show()
end
end
})
end)
