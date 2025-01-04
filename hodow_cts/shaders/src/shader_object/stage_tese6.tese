#version 450

layout(quads) in;

void main (void)
{
    highp float x = gl_TessCoord.x * float(6) - 1.0;
    highp float y = gl_TessCoord.y * float(6) - 1.0;
    gl_Position = vec4(x, y, 0.0, 1.0);
}
