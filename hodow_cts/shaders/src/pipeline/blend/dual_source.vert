#version 450
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 color0;
layout(location = 2) in highp vec4 color1;
layout(location = 0) out highp vec4 vtxColor0;
layout(location = 1) out highp vec4 vtxColor1;
void main (void)
{
    gl_Position = position;
    vtxColor0 = color0;
    vtxColor1 = color1;
}
