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

-- MouseButton3 with modifiers
function modifiers:SMB3()
  return IsShiftKeyDown() and IsMouseButtonDown(3) and GetCurrentKeyBoardFocus() == nil
end

function modifiers:CtrlMB3()
  return IsControlKeyDown() and IsMouseButtonDown(3) and GetCurrentKeyBoardFocus() == nil
end

function modifiers:AltMB3()
  return IsAltKeyDown() and IsMouseButtonDown(3) and GetCurrentKeyBoardFocus() == nil
end

function modifiers:RSMB3()
  return IsRightShiftKeyDown() and IsMouseButtonDown(3) and GetCurrentKeyBoardFocus() == nil
end

function modifiers:RCtrlMB3()
  return IsRightControlKeyDown() and IsMouseButtonDown(3) and GetCurrentKeyBoardFocus() == nil
end

function modifiers:RAltMB3()
  return IsRightAltKeyDown() and IsMouseButtonDown(3) and GetCurrentKeyBoardFocus() == nil
end

function modifiers:LSMB3()
  return IsLeftShiftKeyDown() and IsMouseButtonDown(3) and GetCurrentKeyBoardFocus() == nil
end

function modifiers:LCtrlMB3()
  return IsLeftControlKeyDown() and IsMouseButtonDown(3) and GetCurrentKeyBoardFocus() == nil
end

function modifiers:LAltMB3()
  return IsLeftAltKeyDown() and IsMouseButtonDown(3) and GetCurrentKeyBoardFocus() == nil
end

-- MouseButton4 with modifiers
function modifiers:SMB4()
  return IsShiftKeyDown() and IsMouseButtonDown(4) and GetCurrentKeyBoardFocus() == nil
end

function modifiers:CtrlMB4()
  return IsControlKeyDown() and IsMouseButtonDown(4) and GetCurrentKeyBoardFocus() == nil
end

function modifiers:AltMB4()
  return IsAltKeyDown() and IsMouseButtonDown(4) and GetCurrentKeyBoardFocus() == nil
end

function modifiers:RSMB4()
  return IsRightShiftKeyDown() and IsMouseButtonDown(4) and GetCurrentKeyBoardFocus() == nil
end

function modifiers:RCtrlMB4()
  return IsRightControlKeyDown() and IsMouseButtonDown(4) and GetCurrentKeyBoardFocus() == nil
end

function modifiers:RAltMB4()
  return IsRightAltKeyDown() and IsMouseButtonDown(4) and GetCurrentKeyBoardFocus() == nil
end

function modifiers:LSMB4()
  return IsLeftShiftKeyDown() and IsMouseButtonDown(4) and GetCurrentKeyBoardFocus() == nil
end

function modifiers:LCtrlMB4()
  return IsLeftControlKeyDown() and IsMouseButtonDown(4) and GetCurrentKeyBoardFocus() == nil
end

function modifiers:LAltMB4()
  return IsLeftAltKeyDown() and IsMouseButtonDown(4) and GetCurrentKeyBoardFocus() == nil
end

-- MouseButton5 with modifiers
function modifiers:SMB5()
  return IsShiftKeyDown() and IsMouseButtonDown(5) and GetCurrentKeyBoardFocus() == nil
end

function modifiers:CtrlMB5()
  return IsControlKeyDown() and IsMouseButtonDown(5) and GetCurrentKeyBoardFocus() == nil
end

function modifiers:AltMB5()
  return IsAltKeyDown() and IsMouseButtonDown(5) and GetCurrentKeyBoardFocus() == nil
end

function modifiers:RSMB5()
  return IsRightShiftKeyDown() and IsMouseButtonDown(5) and GetCurrentKeyBoardFocus() == nil
end

function modifiers:RCtrlMB5()
  return IsRightControlKeyDown() and IsMouseButtonDown(5) and GetCurrentKeyBoardFocus() == nil
end

function modifiers:RAltMB5()
  return IsRightAltKeyDown() and IsMouseButtonDown(5) and GetCurrentKeyBoardFocus() == nil
end

function modifiers:LSMB5()
  return IsLeftShiftKeyDown() and IsMouseButtonDown(5) and GetCurrentKeyBoardFocus() == nil
end

function modifiers:LCtrlMB5()
  return IsLeftControlKeyDown() and IsMouseButtonDown(5) and GetCurrentKeyBoardFocus() == nil
end

function modifiers:LAltMB5()
  return IsLeftAltKeyDown() and IsMouseButtonDown(5) and GetCurrentKeyBoardFocus() == nil
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
