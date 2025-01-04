#version 450
#extension GL_EXT_long_vector : enable
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 color;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex { vec4 gl_Position; };
void main()
{
    gl_Position = position;
    vtxColor = color;
}
