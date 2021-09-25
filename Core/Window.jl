include("WindowInput.jl")

import GLFW, ModernGL
import Base:String, UInt
using FileIO

struct WindowException <: Exception
    var::String
end

struct WindowProps
    windowSize::Tuple{Cint,Cint}
    maxWindowSize::Tuple{Cint,Cint}
    minWindowSize::Tuple{Cint,Cint}

    fullscreen::Bool
    
    name::String
    eventCallback::Function
end

struct WindowData
    NativeWindow::GLFW.Window
end

function Window_Init(props::WindowProps)::WindowData
    nativeWindow = C_NULL
    @debug "Initializating window context"
    GLFW.Init() != true && thrown(WindowException("Failed to initialize GLFW"))

    GLFW.WindowHint(GLFW.CONTEXT_VERSION_MAJOR, 3)
    GLFW.WindowHint(GLFW.CONTEXT_VERSION_MINOR, 3)
    GLFW.WindowHint(GLFW.OPENGL_PROFILE, GLFW.OPENGL_CORE_PROFILE)
    GLFW.WindowHint(GLFW.OPENGL_FORWARD_COMPAT, true)
  
    @debug "Creating GLFW window context"

    if props.fullscreen
        nativeWindow = GLFW.CreateWindow(props.windowSize[1], props.windowSize[2], props.name, GLFW.GetPrimaryMonitor())
    else
        nativeWindow = GLFW.CreateWindow(props.windowSize[1], props.windowSize[2], props.name)
    end
        
    nativeWindow == C_NULL && thrown(WindowException("Failed to create GLFW window context"))

    GLFW.MakeContextCurrent(nativeWindow)
        
    WindowInput_RegisterInputCallbacks(nativeWindow, props.eventCallback)

    GLFW.SetWindowSizeLimits(nativeWindow, 
          iszero(props.minWindowSize[1]) ? GLFW.DONT_CARE : props.minWindowSize[1], 
          iszero(props.minWindowSize[2]) ? GLFW.DONT_CARE : props.minWindowSize[2], 
          iszero(props.maxWindowSize[1]) ? GLFW.DONT_CARE : props.maxWindowSize[1], 
          iszero(props.maxWindowSize[2]) ? GLFW.DONT_CARE : props.maxWindowSize[2]);

        
    win_data::WindowData = WindowData(nativeWindow)
    Window_SetIcon(win_data)

    @debug "Window initialization complete"
    WindowData(nativeWindow)
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


function Window_SetIcon(windowData::WindowData)
    if !haskey(ENV, "MERLIN_RESOURCES_FOLDER_PATH")
      @info "Did not load window icon, resources folder not defined. Try setting ENV[MERLIN_RESOURCES_FOLDER_PATH]"
      return
    end

    if !isdir(ENV["MERLIN_RESOURCES_FOLDER_PATH"] * "/Icon")
      @info "Did not load window icon, resources folder not found. Did you create a /Icon/icon.png folder in your resources directory?"
    end

    icon = Texture_Load("Resources/Icon/icon.png").data
    Texture_Load("Resources/Icon/icon.png")
    
    buffs = reinterpret(NTuple{4,UInt8}, icon)
    
    GLFW.SetWindowIcon(windowData.NativeWindow, buffs)
    GLFW.PollEvents()
end

# 
# Mode: [ GLFW.CURSOR_DISABLED, GLFW.CURSOR_HIDDEN, GLFW.CURSOR_NORMAL ]
# 
function SetCursorMode(windowData::WindowData, mode::UInt32)
    @debug "Window cursor mode changed to: " mode
    GLFW.SetInputMode(windowData.NativeWindow, GLFW.CURSOR, mode)
end