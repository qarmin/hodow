#version 310 es
layout(location = 0) in vec4 position;
void main (void)
{
  gl_Position = position;
}
#version 310 es
layout(push_constant) uniform Color { highp vec4 color; };
layout(location = 0) out highp vec4 fragColor0;
void main (void)
{
  fragColor0 = color;
}
#version 310 es
layout(push_constant) uniform Color { highp vec4 color; };
layout(location = 0) out highp vec4 fragColor0;
layout(location = 1) out highp vec4 fragColor1;
void main (void)
{
  fragColor0 = color;
  fragColor1 = color;
}
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
layout(location = 8) out highp vec4 fragColor8;
layout(location = 9) out highp vec4 fragColor9;
layout(location = 10) out highp vec4 fragColor10;
layout(location = 11) out highp vec4 fragColor11;
layout(location = 12) out highp vec4 fragColor12;
layout(location = 13) out highp vec4 fragColor13;
layout(location = 14) out highp vec4 fragColor14;
layout(location = 15) out highp vec4 fragColor15;
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
  fragColor8 = color;
  fragColor9 = color;
  fragColor10 = color;
  fragColor11 = color;
  fragColor12 = color;
  fragColor13 = color;
  fragColor14 = color;
  fragColor15 = color;
}
