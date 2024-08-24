local  addon, dark_addon = ...
local support = dark_addon.support
local Frost = {}

Frost.stuff = function()

end

local function combat()

end

local function resting()


end



function interface()
local settings = {
	key = "frost_community",
	title = "Frost Deathknight",
	width = 300,
	height = 725,
	resize = true,
	show = false,
	template = {
		{ type = "header", text = "Frost Deathknight Settings", align = "center" },

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


dark_addon.rotation.register{
	spec = dark_addon.rotation.classes.deathknight.frost,
	name = 'frost',
	label = '',
	combat = combat,
	interface = interface,
	resting = resting,
} 

for _, func in pairs(Frost) do
    setfenv(func, dark_addon.environment.env)
end