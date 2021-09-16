module Input

import GLFW
import Window
include("KeyCode.jl")
include("MouseCode.jl")

export IsKeyPressed, IsMouseButtonPressed, GetMousePos, GetMouseX, GetMouseY

function IsKeyPressed(keycode)
    GLFW.GetKey(Window.GetNativeWindow(), Cint(keycode))
end

function IsMouseButtonPressed(button)
    GLFW.GetMouseButton(Window.GetNativeWindow(), Cint(button))
end

function GetMousePos()
    GLFW.GetCursorPos(Window.GetMativeWindow())
end

function GetMouseX()
    x, y = GLFW.GetCursorPos(Window.GetMativeWindow())
    x
end

function GetMouseY()
    x, y = GLFW.GetCursorPos(Window.GetMativeWindow())
    y
end

# module
end