#version 450
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 color;
layout(location = 0) out highp vec4 vtxColor;
void main (void)
{
    gl_Position = position;
    vtxColor = color;
}
#version 450
layout(location = 0) in highp vec4 vtxColor;
layout(location = 0) out highp vec4 fragColor0;
layout(location = 1) out highp vec4 fragColor1;
layout(location = 2) out highp vec4 fragColor2;
void main (void)
{
    fragColor0 = vtxColor;
    fragColor1 = vtxColor;
    fragColor2 = vtxColor;
}
