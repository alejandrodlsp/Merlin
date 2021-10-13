# Include main application
include("Core/Application.jl")
using ModernGL

function render()
    Triangle_Render(triangle)
end

# App create
app = Application_Init(ApplicationParams(OnRender=render))

points = GLfloat[ 0.0,  0.5, 0.0,
                  0.5, -0.5, 0.0,
                  -0.5, -0.5, 0.0]
                  
colors = GLfloat[ 1.0, 0.0, 0.0,
                  0.0, 1.0, 0.0,
                  0.0, 0.0, 1.0]

triangle = Triangle_Create(points, colors)

# App run
Application_Run(app)
