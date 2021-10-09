using CSyntax, ModernGL

struct TriangleData
    vbo::GLuint
    vao::GLuint
    program::ProgramData
end

function Triangle_Create(vertices):TriangleData
    program = ProgramResource_Load(Program_DefaultProgramPath()).program

    # create buffers located in the memory of graphic card
    vbo = GLuint(0)
    @c glGenBuffers(1, &vbo)
    glBindBuffer(GL_ARRAY_BUFFER, vbo)
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW)

    # create VAO
    vao = GLuint(0)
    @c glGenVertexArrays(1, &vao)
    glBindVertexArray(vao)
    glBindBuffer(GL_ARRAY_BUFFER, vao)
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, C_NULL)
    glEnableVertexAttribArray(0)

    TriangleData(vbo, vao, program)
end

function Triangle_Render(triangle::TriangleData)
    Program_Use(triangle.program)
    glBindVertexArray(triangle.vao)
    glDrawArrays(GL_TRIANGLES, 0, 3)
end
