#version 310 es
layout(push_constant) uniform Color { highp vec4 color; };
layout(location = 0) out highp vec4 fragColor0;
layout(location = 1) out highp vec4 fragColor1;
layout(location = 2) out highp vec4 fragColor2;
layout(location = 3) out highp vec4 fragColor3;
layout(location = 4) out highp vec4 fragColor4;
layout(location = 5) out highp vec4 fragColor5;
layout(location = 6) out highp vec4 fragColor6;
layout(location = 7) out highp vec4 fragColor7;
void main (void)
{
  fragColor0 = color;
  fragColor1 = color;
  fragColor2 = color;
  fragColor3 = color;
  fragColor4 = color;
  fragColor5 = color;
  fragColor6 = color;
  fragColor7 = color;
}
