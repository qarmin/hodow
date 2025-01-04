#version 310 es
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 color;
layout(location = 0) out highp vec4 vtxColor;
void main (void)
{
    gl_Position = position;
    vtxColor = color;
}
#version 310 es
layout(location = 0) in highp vec4 vtxColor;
layout(location = 0) out highp vec4 fragColor;
void main (void)
{
    fragColor = vtxColor;
}
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
#version 450
layout(location = 0) in highp vec4 vtxColor0;
layout(location = 1) in highp vec4 vtxColor1;
layout(location = 0, index = 0) out highp vec4 fragColor0;
layout(location = 0, index = 1) out highp vec4 fragColor1;
void main (void)
{
    fragColor0 = vtxColor0;
    fragColor1 = vtxColor1;
   if (int(gl_FragCoord.x) == 2 || int(gl_FragCoord.y) == 3)
      discard;
}
#version 450
layout(location = 0) in highp vec4 vtxColor0;
layout(location = 1) in highp vec4 vtxColor1;
layout(location = 0, index = 0) out highp vec4 fragColor0[1];
layout(location = 0, index = 1) out highp vec4 fragColor1[1];
void main (void)
{
    fragColor0[0] = vtxColor0;
    fragColor1[0] = vtxColor1;
   if (int(gl_FragCoord.x) == 2 || int(gl_FragCoord.y) == 3)
      discard;
}
