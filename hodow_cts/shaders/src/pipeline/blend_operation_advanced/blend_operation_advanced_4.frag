#version 310 es
layout(push_constant) uniform Color { highp vec4 color; };
layout(location = 0) out highp vec4 fragColor0;
layout(location = 1) out highp vec4 fragColor1;
layout(location = 2) out highp vec4 fragColor2;
layout(location = 3) out highp vec4 fragColor3;
void main (void)
{
  fragColor0 = color;
  fragColor1 = color;
  fragColor2 = color;
  fragColor3 = color;
}
