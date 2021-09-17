include("WindowInput.jl")

import GLFW, ModernGL
import Base:String, UInt

struct WindowException <: Exception
    var::String
end

struct WindowProps
    width::UInt16
    height::UInt16
    name::String
    eventCallback::Function
end

struct WindowData
    NativeWindow::GLFW.Window
end

function Window_Init(props::WindowProps)::WindowData
    try
        @debug "Initializating window context"
        GLFW.Init() != true && thrown(WindowException("Failed to initialize GLFW"))

        GLFW.WindowHint(GLFW.CONTEXT_VERSION_MAJOR, 3)
        GLFW.WindowHint(GLFW.CONTEXT_VERSION_MINOR, 3)
        GLFW.WindowHint(GLFW.OPENGL_PROFILE, GLFW.OPENGL_CORE_PROFILE)
        GLFW.WindowHint(GLFW.OPENGL_FORWARD_COMPAT, true)
  
        @debug "Creating GLFW window context"
        nativeWindow = GLFW.CreateWindow(props.width, props.height, props.name)
        nativeWindow == C_NULL && thrown(WindowException("Failed to create GLFW window context"))

        GLFW.MakeContextCurrent(nativeWindow)

        WindowInput_RegisterInputCallbacks(nativeWindow, props.eventCallback)

        @debug "Window initialization complete"
        return WindowData(nativeWindow)
    catch e
        Shutdown()
        @error "Error encountered when setting up window: " e
    end
end

function Window_Update(windowData::WindowData)
    GLFW.PollEvents()
    GLFW.SwapBuffers(windowData.NativeWindow)
end

function Window_Shutdown(windowData::WindowData)
    @debug "Shutting down GLFW window context"
    GLFW.DestroyWindow(windowData.NativeWindow)
end

function Window_ShouldClose(windowData::WindowData)::Bool
    GLFW.WindowShouldClose(windowData.NativeWindow)
end

# 
# Mode: [ GLFW.CURSOR_DISABLED, GLFW.CURSOR_HIDDEN, GLFW.CURSOR_NORMAL ]
# 
function SetCursorMode(windowData::WindowData, mode::UInt32)
    @debug "Window cursor mode changed to: " mode
    GLFW.SetInputMode(windowData.NativeWindow, GLFW.CURSOR, mode)
end