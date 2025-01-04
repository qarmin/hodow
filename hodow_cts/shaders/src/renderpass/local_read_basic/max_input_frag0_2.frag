#version 450
layout(push_constant) uniform InputDraw {
  uint count;
} inputDraw;
layout(location=0) out uint outColor0;
layout(location=1) out uint outColor1;
void main()
{
  outColor0 = 2u * inputDraw.count + 1;
  outColor0 *= outColor0;
  outColor1 = 2u * inputDraw.count + 2;
  outColor1 *= outColor1;
}
