#version 450
#extension GL_EXT_long_vector : enable
layout(location = 0) in highp vec4 vtxColor;
layout(location = 0) out highp vec4 fragColor;
layout(push_constant) uniform Material
{
    layout(offset = 12) int unused1;
    layout(offset = 16) vec4 unused2;
    layout(offset = 32) vec4 color;
} matInst;
void main (void)
{
    fragColor = vtxColor;
    fragColor += matInst.color;
    fragColor = min(mod(fragColor, 2.0), 2.0 - mod(fragColor, 2.0));
}
