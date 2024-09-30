local addon, dark_addon = ...

local modifiers = { }

function modifiers:shift()
  return IsShiftKeyDown() and GetCurrentKeyBoardFocus() == nil
end

function modifiers:control()
  return IsControlKeyDown() and GetCurrentKeyBoardFocus() == nil
end

function modifiers:alt()
  return IsAltKeyDown() and GetCurrentKeyBoardFocus() == nil
end

function modifiers:lshift()
  return IsLeftShiftKeyDown() and GetCurrentKeyBoardFocus() == nil
end

function modifiers:lcontrol()
  return IsLeftControlKeyDown() and GetCurrentKeyBoardFocus() == nil
end

function modifiers:lalt()
  return IsLeftAltKeyDown() and GetCurrentKeyBoardFocus() == nil
end

function modifiers:rshift()
  return IsRightShiftKeyDown() and GetCurrentKeyBoardFocus() == nil
end

function modifiers:rcontrol()
  return IsRightControlKeyDown() and GetCurrentKeyBoardFocus() == nil
end

function modifiers:ralt()
  return IsRightAltKeyDown() and GetCurrentKeyBoardFocus() == nil
end

function modifiers:MouseButton3()
  return IsMouseButtonDown(3) and GetCurrentKeyBoardFocus() == nil
end

function modifiers:MouseButton4()
  return IsMouseButtonDown(4) and GetCurrentKeyBoardFocus() == nil
end

function modifiers:MouseButton5()
  return IsMouseButtonDown(5) and GetCurrentKeyBoardFocus() == nil
end

dark_addon.environment.hooks.modifier = setmetatable({}, {
  __index = function(t, k)
    if modifiers[k] then
      return modifiers[k](t)
    else
      return nil
    end
  end
})
