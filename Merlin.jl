# Include main application
include("Core/Application.jl")
using ModernGL

function render()
    Triangle_Render(triangle)
end

# App create
app = Application_Init(ApplicationParams(OnRender=render))

triangle = Triangle_Create(GLfloat[ 0.0,  0.5, 0.0,
                                    0.5, -0.5, 0.0,
                                    -0.5, -0.5, 0.0])

# App run
Application_Run(app)