#version 450
layout(location = 0) out vec4 outColor0;
layout(location = 1) out vec4 outColor1;
layout(location = 2) out vec4 outColor2;
layout(location = 3) out vec4 outColor3;
layout(location = 4) out vec4 outColor4;
layout(location = 5) out vec4 outColor5;
layout(location = 6) out vec4 outColor6;
layout(location = 7) out vec4 outColor7;
void main (void)
{
  outColor0 = vec4(0, 0, 1, 1);
  outColor1 = vec4(0, 1, 0, 1);
  outColor2 = vec4(0, 1, 1, 1);
  outColor3 = vec4(1, 0, 0, 1);
  outColor4 = vec4(1, 0, 1, 1);
  outColor5 = vec4(1, 1, 0, 1);
  outColor6 = vec4(1, 1, 1, 1);
  outColor7 = vec4(0.5, 0.5, 0.5, 1);
}
