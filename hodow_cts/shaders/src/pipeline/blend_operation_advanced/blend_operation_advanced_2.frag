#version 310 es
layout(push_constant) uniform Color { highp vec4 color; };
layout(location = 0) out highp vec4 fragColor0;
layout(location = 1) out highp vec4 fragColor1;
void main (void)
{
  fragColor0 = color;
  fragColor1 = color;
}
