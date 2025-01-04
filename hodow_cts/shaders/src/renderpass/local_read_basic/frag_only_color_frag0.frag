#version 450
layout(location = 0) out uint outColor0;
layout(location = 1) out uint outColor1;
layout(location = 2) out uint outColor2;
void main()
{
  outColor0 = 1u;
  outColor1 = 10u;
  outColor2 = 100u;
}
