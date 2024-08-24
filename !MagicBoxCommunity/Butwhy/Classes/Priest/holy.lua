local  addon, dark_addon = ...
local support = dark_addon.support
local SB = {}
local Holy = {}

Holy.stuff = function()

end
 
local function combat()
end

local function resting()
end

function interface()
--CreateMacroIfNotExist("DISP", "/fd toggle dispel")
--CreateMacroIfNotExist("DPS", "/fd toggle dps")
--CreateMacroIfNotExist("Racial", "/fd toggle racial")
--CreateMacroIfNotExist("Targs", "/fd toggle useTarget")
--CreateMacroIfNotExist("Purge", "/fd toggle purgetar")
--CreateMacroIfNotExist("Filler", "/fd toggle filler")
local settingss = {
	key      = "holy_community",
	title    = "Holy Priest",
	width    = 420,
	height   = 750,
	resize   = false,
	profiles = true,
	show     = false,
	template = {
	{ type = "header", text = "Holy - Priest", align = "center" },

	}
}

configWindowtwo = dark_addon.interface.builder.buildGUI(settingss)


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

dark_addon.rotation.register(
        {
        spec      = dark_addon.rotation.classes.priest.holy,
        name      = "holy",
        label     = "",
        combat    = combat,
        resting   = resting,
        interface = interface
        }
)
 
for _, func in pairs(Holy) do
    setfenv(func, dark_addon.environment.env)
end