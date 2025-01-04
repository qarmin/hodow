#version 450

layout (triangles) in;
layout (triangle_strip, max_vertices = 3) out;
layout (location = 3) in vec2 texCoordIn[];
layout (location = 3) out vec2 texCoordOut;

void main()
{
    gl_ViewportIndex = 0;
    for (int i = 0; i < 3; ++i) {
        gl_Position = gl_in[i].gl_Position;
        gl_PointSize = gl_in[i].gl_PointSize;
        texCoordOut = texCoordIn[i];
        EmitStreamVertex(0);
    }
    EndStreamPrimitive(0);
}
