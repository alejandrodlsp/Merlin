using Base:String
# Load environment variables
using ConfigEnv
dotenv()

# Include main application
include("Core/Application.jl")

# App loop
app = Application_Init(ApplicationParams(width=1500, height=1500, name="Merlin Engine", eventCallback=(e) -> println(e.type)))
Application_Run(app)