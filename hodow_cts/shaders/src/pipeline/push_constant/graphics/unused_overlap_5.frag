#version 450
#extension GL_EXT_long_vector : enable
layout(location = 0) in highp vec4 vtxColor;
layout(location = 0) out highp vec4 fragColor;

void main (void)
{
    fragColor = vtxColor;

    fragColor = min(mod(fragColor, 2.0), 2.0 - mod(fragColor, 2.0));
}
