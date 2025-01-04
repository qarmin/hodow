#version 450
#extension GL_EXT_long_vector : enable
layout(location = 0) in highp vec4 vtxColor;
layout(location = 0) out highp vec4 fragColor;
layout(push_constant) uniform Material
{
    layout(offset = 20) float color;
} matInst;
void main (void)
{
    fragColor = vtxColor;
    fragColor.x += matInst.color;
    fragColor = min(mod(fragColor, 2.0), 2.0 - mod(fragColor, 2.0));
}
