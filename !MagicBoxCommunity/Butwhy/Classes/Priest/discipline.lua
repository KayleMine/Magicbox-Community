local  addon, dark_addon = ...
local support = dark_addon.support
local SB = {}
local Disc = {}

Disc.stuff = function()

end
 
local function combat()
end

local function resting()
end

function interface()
local settings = {
    key = 'discipline_community',
    title = 'Discipline Priest',
    width = 250,
    height = 350,
    resize = true,
    show = false,
    template = {
		{ type = 'header', text = "Discipline Priest Settings"},

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
  spec = dark_addon.rotation.classes.priest.discipline,
  name = 'disc',
  label = '',
  combat = combat,
  resting = resting,
  interface = interface
})

for _, func in pairs(Disc) do
    setfenv(func, dark_addon.environment.env)
end