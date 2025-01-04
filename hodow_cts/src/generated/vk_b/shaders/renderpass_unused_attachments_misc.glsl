#version 460
void main()
{
    const float x = (-1.0+2.0*((gl_VertexIndex & 2)>>1));
    const float y = ( 1.0-2.0* (gl_VertexIndex % 2));
    gl_Position = vec4(x, y, 0.0, 1.0);
}
#version 460
layout (location=0) out vec4 outColor;
layout (push_constant) uniform PCBlock { vec4 color; } pc;
void main()
{
    outColor = pc.color;
}
