local  addon, dark_addon = ...
local support = dark_addon.support
local SB = {}
local Arcane = {}

Arcane.stuff = function()

end

local function combat()

end

local function resting()

end

local function interface()
local template = {
	key = 'arcane_community',
	title = 'Arcane Mage',
	width = 320,
	height = 450,
	resize = true,
	show = false,
	template = {
		{ type = "text", text = "Arcane Mage Settings", align = "CENTER"  },

	}
}

    configWindow = dark_addon.interface.builder.buildGUI(template)

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
   spec = dark_addon.rotation.classes.mage.arcane,
   name = 'arcane',
   label = '',
   combat = combat,
   resting = resting,
   interface = interface
})

for _, func in pairs(Arcane) do
    setfenv(func, dark_addon.environment.env)
end