module Window

import GLFW, ModernGL
import Base:String, UInt
import WindowInput

export WindowProps, GetNativeWindow, Init, Shutdown, Update, ShouldClose

mNativeWindow = missing
mMonitor = missing

struct WindowProps
    width::UInt16
    height::UInt16
    name::String
    
    # Default constructor
    WindowProps() = new(1200, 512, "Julia Engine Window")
    WindowProps(Width::UInt16, Height::UInt16, Name::String) = new(Width, Height, Name)
end

function Init(props::WindowProps=WindowProps())
    GLFW.Init() != true && error("Failed to initialize GLFW")

    GLFW.WindowHint(GLFW.CONTEXT_VERSION_MAJOR, 3)
    GLFW.WindowHint(GLFW.CONTEXT_VERSION_MINOR, 3)
    GLFW.WindowHint(GLFW.OPENGL_PROFILE, GLFW.OPENGL_CORE_PROFILE)

    global mMonitor = GLFW.GetPrimaryMonitor()

    global mNativeWindow = GLFW.CreateWindow(props.width, props.height, props.name)
    mNativeWindow == C_NULL && error("Failed to create GLFW window context")

    GLFW.MakeContextCurrent(mNativeWindow)
    
    WindowInput.RegisterInputCallbacks(mNativeWindow)
end

function Update()
    GLFW.PollEvents()
    GLFW.SwapBuffers(mNativeWindow)
end

function Shutdown()
    GLFW.DestroyWindow(mNativeWindow)
end

function ShouldClose()
    GLFW.WindowShouldClose(mNativeWindow)
end

function GetNativeWindow()
    mNativeWindow
end

function SetFullscreen(fullscreen::Bool)
    if fullscreen
        GLFW.make_fullscreen(mNativeWindow, mMonitor)
    else
        GLFW.make_windowed(mNativeWindow)
    end
end

# 
# Mode: [ GLFW.CURSOR_DISABLED, GLFW.CURSOR_HIDDEN, GLFW.CURSOR_NORMAL ]
# 
function SetCursorMode(mode::UInt32)
    GLFW.SetInputMode(mNativeWindow, GLFW.CURSOR, mode)
end

# module
end