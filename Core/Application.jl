using ModernGL

# import Event
import Window
import Event

Window.Init(Window.WindowProps(UInt16(1000), UInt16(1000), "ASd"))

function onEvent(e)
    println(e.type)
end

Event.RegisterListener(onEvent)

while !Window.ShouldClose()
    Window.Update()
    glClearColor(0.2, 0.3, 0.3, 1.0)
    glClear(GL_COLOR_BUFFER_BIT)
end

Window.Shutdown()


