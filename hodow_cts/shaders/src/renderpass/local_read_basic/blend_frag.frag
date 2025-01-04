#version 450
layout(location = 0) out vec4 outColor0;
layout(location = 1) out vec4 outColor1;
layout(location = 2) out vec4 outColor2;
layout(location = 3) out vec4 outColor3;
void main()
{
  if (gl_FragCoord.x > 8.0)
    discard;
  outColor0 = vec4(0.6, 0.8, 0.9, 0.2);
  outColor1 = vec4(0.6, 0.4, 0.2, 0.6);
  outColor2 = vec4(0.1, 0.3, 0.6, 0.2);
  outColor3 = vec4(0.0, 0.6, 0.4, 0.8);
}
