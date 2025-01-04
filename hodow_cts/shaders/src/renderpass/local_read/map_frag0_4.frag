#version 450
layout(location = 0) out vec4 outColor0;
layout(location = 1) out vec4 outColor1;
layout(location = 2) out vec4 outColor2;
layout(location = 3) out vec4 outColor3;
void main (void)
{
  outColor0 = vec4(0, 0, 1, 1);
  outColor1 = vec4(0, 1, 0, 1);
  outColor2 = vec4(0, 1, 1, 1);
  outColor3 = vec4(1, 0, 0, 1);
}
