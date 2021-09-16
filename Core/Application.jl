module Application

using ModernGL
import GLFW

import Logger
import Window
import Input

mCloseRequested = false

function Run()
    Init()

    while !ShouldClose()
        Window.Update()
        glClearColor(0.2, 0.3, 0.3, 1.0)
        glClear(GL_COLOR_BUFFER_BIT)

        if (Input.IsKeyPressed(Cint(GLFW.KEY_A)))
            println("ASD")
        end
    end

    Shutdown()
end

function Init()
    Logger.Init()
    Window.Init(Window.WindowProps(UInt16(1200), UInt16(800), "Merlin Engine"))
end

function Shutdown()
    mCloseRequested = true
    Window.Shutdown()
    Logger.Shutdown()
end

function ShouldClose()
    mCloseRequested || Window.ShouldClose()
end

# module
end