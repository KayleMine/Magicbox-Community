local  addon, dark_addon = ...
local support = dark_addon.support
local SB = {}
local Affliction = {}

Affliction.stuff = function()

end
 
local function combat()

end

local function resting()

end


local function interface()
local example = {
    key = 'affliction_community',
    title = 'Affli - Warlock',
    width = 290,
    height = 525,
    resize = true,
    show = false,
    template = {
		{ type = "header", text = "Affliction Warlock Settings", align= "center" },
 
    }
}

 configWindow = dark_addon.interface.builder.buildGUI(example)

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
  spec = dark_addon.rotation.classes.warlock.affliction,
  name = 'affli',
  label = '',
  combat = combat,
  resting = resting,
  gcd = gcd,
  interface = interface
})

for _, func in pairs(Affliction) do
    setfenv(func, dark_addon.environment.env)
end