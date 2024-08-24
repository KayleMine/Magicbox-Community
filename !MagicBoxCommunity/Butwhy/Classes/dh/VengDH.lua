local  addon, dark_addon = ...
local support = dark_addon.support
local Vengeance = {}

Vengeance.stuff = function()

end
 
local function combat()

end

local function resting()

end


local function interface()
   -- CreateMacroIfNotExist("Misery:P", "#showtooltip " .. GetSpellInfo(207684) .. "\n/fd csf 207684")
  -- CreateMacroIfNotExist("Misery:C", "#showtooltip " .. GetSpellInfo(207684) .. "\n/fd csu 207684 cursor")
local settings = {
	key = "vengeance_community",
	title = "Vengeance Demon Hunter",
	width = 320,
	height = 750,
	resize = true,
	show = false,
	template = {
		{type = "header", text = "Vengeance DH Settings", align = "center"},
			
	}
}

    configWindow = dark_addon.interface.builder.buildGUI(settings)

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

-- This is what actually tells DR about your custom rotation
dark_addon.rotation.register(
    {
        spec = dark_addon.rotation.classes.demonhunter.vengeance,
        name = "veng",
        label = "",
        combat = combat,
        resting = resting,
        interface = interface
    }
)

for _, func in pairs(Vengeance) do
    setfenv(func, dark_addon.environment.env)
end
