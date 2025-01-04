#version 460

layout ( quads ) in;

void main()
{
    const float u = gl_TessCoord.x;
    const float v = gl_TessCoord.y;
    gl_Position = (1 - u) * (1 - v) * gl_in[0].gl_Position + u * (1 - v) * gl_in[1].gl_Position + u * v * gl_in[2].gl_Position + (1 - u) * v * gl_in[3].gl_Position;
}
