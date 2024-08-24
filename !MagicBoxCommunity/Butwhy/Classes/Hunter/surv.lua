local  addon, dark_addon = ...
local support = dark_addon.support
local SB = {}
local Surv = {}

Surv.stuff = function()

end

local function combat()

end

local function resting()

end

local function interface()
local settings = {
	key = 'survival_community',
	title = 'Hunter Survival',
	width = 300,
	height = 400,
	color = "3caf00",
	resize = true,
	show = false,
	template = {
		{ type = "header", text = "Survival Settings", align='center'  },
           
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
      if configWindow.parent:IsShown() then
        configWindow.parent:Hide()
      else
        configWindow.parent:Show()
      end
    end
  })
end



dark_addon.rotation.register({
spec = dark_addon.rotation.classes.hunter.survival,
name = 'surv',
label = '',
combat = combat,
resting = resting,
interface = interface
})

for _, func in pairs(Surv) do
    setfenv(func, dark_addon.environment.env)
end