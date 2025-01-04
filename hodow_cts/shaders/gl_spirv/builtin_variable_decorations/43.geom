#version 450

layout (triangles) in;
layout (triangle_strip, max_vertices = 3) out;

layout (location = 3) in vec4 teColor[];
layout (location = 4) out vec4 gColor;

void main()
{
    gColor = teColor[0];
    gColor.b = float(gl_PrimitiveIDIn);

    gl_Layer = 1;
    gl_ViewportIndex = 1;

    for (int i = 0; i < 3; ++i) {
        gl_ClipDistance[0] = gl_in[i].gl_ClipDistance[0];
        gl_CullDistance[0] = gl_in[i].gl_CullDistance[0];
        gl_Position = gl_in[i].gl_Position;
        EmitVertex();
    }
    EndPrimitive();
}
