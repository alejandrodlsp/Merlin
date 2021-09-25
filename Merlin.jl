# Include main application
include("Core/Application.jl")

# App loop
app = Application_Init(ApplicationParams())
Application_Run(app)