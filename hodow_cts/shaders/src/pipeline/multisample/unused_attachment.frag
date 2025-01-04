#version 310 es
layout(location = 0) in highp vec4 vtxColor;
layout(location = 0) out highp vec4 fragColor0;
layout(location = 1) out highp vec3 fragColor1;
void main (void)
{
    fragColor0 = vtxColor;
    fragColor1 = vtxColor.rgb;
}
