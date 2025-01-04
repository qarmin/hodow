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
