#version 450
#extension GL_EXT_long_vector : enable
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 inColor;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex
{
    vec4 gl_Position;
};
layout(push_constant) uniform Material
{
    layout(offset = 12) int unused1;
    layout(offset = 16) vec4 unused2;
    layout(offset = 32) vec4 color;
} matInst;
void main()
{
    gl_Position = position;
    vec4 color = inColor;
    color += matInst.color;
    vtxColor = color;
}
