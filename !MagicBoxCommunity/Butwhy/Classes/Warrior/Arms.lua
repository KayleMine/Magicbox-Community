local  addon, dark_addon = ...
local support = dark_addon.support
local SB = {}
local Arms = {}

Arms.stuff = function()

end

local function combat()
	
end

local function resting()
	
end


local function interface()
local settings = {
    key = "arms_community",
    title = "Arms Warrior",
    width = 360,
    height = 520,
    resize = true,
    show = false,
    template = {
        { type = "header", text = 'Arms Warrior', align = 'center'},

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
    spec = dark_addon.rotation.classes.warrior.arms,
    name = "arms",
    label = "",
    combat = combat,
    resting = resting,
    interface = interface
  }
)

for _, func in pairs(Arms) do
    setfenv(func, dark_addon.environment.env)
end
