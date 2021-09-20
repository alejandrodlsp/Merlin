# Load environment variables
using ConfigEnv
dotenv()

# Include main application
include("Core/Application.jl")

function onScroll(e)
    println("Moved")
end

function onEvent(e)
    Event_Dispatch(e, EventTypeWindowMoved, onScroll)    
end

# App loop
app_params = ApplicationParams(
  width=1500, 
  height=1500, 
  name="Merlin Engine",
  eventCallback=onEvent
)

app = Application_Init(app_params)
Application_Run(app)