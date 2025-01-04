#version 450

layout(vertices = 3) out;

void main (void)
{
    gl_TessLevelInner[0] = 5.0 + float(1);
    gl_TessLevelInner[1] = 5.0 + float(1);

    gl_TessLevelOuter[0] = 5.0;
    gl_TessLevelOuter[1] = 5.0;
    gl_TessLevelOuter[2] = 5.0;
    gl_TessLevelOuter[3] = 5.0;
}
