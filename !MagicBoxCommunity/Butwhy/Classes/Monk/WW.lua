local  addon, dark_addon = ...
local support = dark_addon.support
local SB = {}
local WW = {}

WW.stuff = function()

end

local function combat()
end

local function resting()
end

function interface()
local ww_gui = {
    key = 'windwalker_community',
    title = 'Windwalker',
    width = 350,
    height = 250,
    resize = true,
    show = false,
    template = {
		{ type = "header", text = "Rotation Tricks", align="CENTER" },

	}
}

  configWindow = dark_addon.interface.builder.buildGUI(ww_gui)
 
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
      if configWindowtwo.parent:IsShown() then
        configWindowtwo.parent:Hide()
      else
        configWindowtwo.parent:Show()
      end
    end
  })
end

dark_addon.rotation.register({
  spec = dark_addon.rotation.classes.monk.windwalker,
  name = 'ww',
  label = '',
  combat = combat,
  resting = resting,
  interface = interface
})

for _, func in pairs(WW) do
    setfenv(func, dark_addon.environment.env)
end