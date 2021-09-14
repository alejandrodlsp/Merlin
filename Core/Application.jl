module Application

using ModernGL

import Logger
import Window

mCloseRequested = false

function Run()
    Init()

    while !ShouldClose()
        Window.Update()
        glClearColor(0.2, 0.3, 0.3, 1.0)
        glClear(GL_COLOR_BUFFER_BIT)
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