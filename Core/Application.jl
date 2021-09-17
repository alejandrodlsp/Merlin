include("Window.jl")
include("Logger.jl")

using ModernGL

struct ApplicationParams
    windowWidth::Cint
    windowHeight::Cint
    windowName::String
    eventCallback::Function
    ApplicationParams(;width::Int, height::Int, name::String, eventCallback::Function=(e) -> ()) = new(Cint(width), Cint(height), name, eventCallback)
end

struct ApplicationData
    EventCallback::Function
    windowData::WindowData
    loggerData::LoggerData
end

function Application_Init(params::ApplicationParams)::ApplicationData
    loggerData = Logger_Init()
    windowData = Window_Init(WindowProps(params.windowWidth, params.windowHeight, params.windowName, params.eventCallback))
    ApplicationData(params.eventCallback, windowData, loggerData)
end

function Application_Run(applicationData::ApplicationData)
    while !Application_ShouldClose(applicationData)
        Window_Update(applicationData.windowData)
        glClearColor(0.2, 0.3, 0.3, 1.0)
        glClear(GL_COLOR_BUFFER_BIT)
    end
    
    Application_Shutdown(applicationData)
end

function Application_Shutdown(applicationData::ApplicationData)
    Window_Shutdown(applicationData.windowData)
    Logger_Shutdown(applicationData.loggerData)
end

function Application_ShouldClose(applicationData::ApplicationData)
    Window_ShouldClose(applicationData.windowData)
end