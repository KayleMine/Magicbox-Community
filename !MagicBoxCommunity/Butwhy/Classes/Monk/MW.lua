local  addon, dark_addon = ...
local support = dark_addon.support
local SB = {}
local MW = {}

MW.stuff = function()

end

local function combat()
end

local function resting()
end


function interface()
local mw_gui = {
    key = 'mistweaver_community',
    title = 'Mistweaver',
    width = 350,
    height = 620,
    resize = true,
    show = false,
    template = {
		{ type = "header", text = "Mistweaver Monk", align='center' },
      		
    }
}

  configWindow = dark_addon.interface.builder.buildGUI(mw_gui)

  dark_addon.interface.buttons.add_toggle({
    name = 'settings',
    label = 'Rotation Settings',
    font = 'dark_addon_icon',
    on = {
      label = dark_addon.interface.icon('cog'),
      color = dark_addon.interface.color.warrior_brown,
      color2 = dark_addon.interface.color.warrior_brown
    },
    off = {
      label = dark_addon.interface.icon('cog'),
      color = dark_addon.interface.color.red,
      color2 = dark_addon.interface.color.red
    },
    callback = function(self)
      if configWindow.parent:IsShown() then
        configWindow.parent:Hide()
      else
        configWindow.parent:Show()
      end
    end
  })
end

dark_addon.rotation.register({
  spec = dark_addon.rotation.classes.monk.mistweaver,
  name = 'mw',
  label = '',
  combat = combat,
  resting = resting,
  interface = interface
})

for _, func in pairs(MW) do
    setfenv(func, dark_addon.environment.env)
end