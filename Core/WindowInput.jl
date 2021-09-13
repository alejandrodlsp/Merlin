module WindowInput

import GLFW, ModernGL
import Event

export RegisterInputCallbacks

# 
#  Called when a key event is registered (Pressed / Released)
# 
function OnKeyCallback(window::GLFW.Window, key::GLFW.Key, scancode::Cint, action::GLFW.Action, mods::Cint)
    if (action == GLFW.PRESS)
        Event.Dispatch(Event.KeyEventData(Event.EventTypeKeyPressed, UInt16(key), 0))
    else (action == GLFW.RELEASE)
        Event.Dispatch(Event.KeyEventData(Event.EventTypeKeyReleased, UInt16(key), 0))
    end
end

# 
#  Called when a mouse moved event is registered
# 
function OnMouseMovedCallback(window::GLFW.Window, xpos::Cdouble, ypos::Cdouble)
    Event.Dispatch(Event.MouseMovedEventData(Float64(xpos), Float64(ypos)))
end

# 
#  Called when a mouse button event is registed (Pressed / Released)
# 
function OnMouseButtonCallback(window::GLFW.Window, button::GLFW.MouseButton, action::GLFW.Action, mods::Cint)
    if (action == GLFW.PRESS)
        Event.Dispatch(Event.MouseButtonEventData(Event.EventTypeMouseButtonPressed, UInt16(button)))
    else (action == GLFW.RELEASE)
        Event.Dispatch(Event.MouseButtonEventData(Event.EventTypeMouseButtonReleased, UInt16(button)))
    end
end

# 
# 
# 
function OnMouseScrollCallback(window::GLFW.Window, offsetX::Cdouble, offsetY::Cdouble)
    Event.Dispatch(Event.MouseScrollEventData(Float64(offsetX), Float64(offsetY)))
end

# 
# 
# 
function OnWindowCloseCallback(window::GLFW.Window)
    Event.Dispatch(Event.WindowCloseEvent())
end

# 
# 
# 
function OnWindowSizeCallback(window::GLFW.Window, width::Cint, height::Cint)
    glViewport(0, 0, width, height) # TODO: Move viewport resize call to renderer
    Event.Dispatch(Event.WindowSizeEvent(width, height))
end

# 
# 
# 
function OnWindowMovedCallback(window::GLFW.Window, posx::Cint, posy::Cint)
    Event.Dispatch(Event.WindowMovedEvent(posx, posy))
end

# 
# 
# 
function RegisterInputCallbacks(window::GLFW.Window)
    GLFW.SetKeyCallback(window, OnKeyCallback)
    GLFW.SetCursorPosCallback(window, OnMouseMovedCallback)
    GLFW.SetMouseButtonCallback(window, OnMouseButtonCallback)
    GLFW.SetScrollCallback(window, OnMouseScrollCallback)
    GLFW.SetWindowCloseCallback(window, OnWindowCloseCallback)
    GLFW.SetFramebufferSizeCallback(window, OnWindowSizeCallback)
    GLFW.SetWindowPosCallback(window, OnWindowMovedCallback)
end


# module
end