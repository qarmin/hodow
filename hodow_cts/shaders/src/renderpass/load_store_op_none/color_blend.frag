#version 450
layout(location = 0) in highp vec4 vtxColor;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = vec4(vtxColor.rgb, 0.5);
    gl_FragDepth = 1.0;
}
