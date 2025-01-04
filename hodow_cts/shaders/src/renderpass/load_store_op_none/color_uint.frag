#version 450
layout(location = 0) in highp vec4 vtxColor;
layout(location = 0) out highp uvec4 fragColor;
void main (void)
{
    fragColor = uvec4(vtxColor * vec4(255));
    gl_FragDepth = 1.0;
}
