using ModernGL

import Logger
import Window

Logger.Init()
Window.Init(Window.WindowProps(UInt16(1000), UInt16(1000), "ASd"))

while !Window.ShouldClose()
    Window.Update()
    glClearColor(0.2, 0.3, 0.3, 1.0)
    glClear(GL_COLOR_BUFFER_BIT)
end

Window.Shutdown()
Logger.Shutdown()

