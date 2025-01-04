#version 450
layout(push_constant) uniform InputDraw {
  uint count;
} inputDraw;
layout(location=0) out uint outColor0;
layout(location=1) out uint outColor1;
layout(location=2) out uint outColor2;
layout(location=3) out uint outColor3;
layout(location=4) out uint outColor4;
layout(location=5) out uint outColor5;
layout(location=6) out uint outColor6;
void main()
{
  outColor0 = 2u * inputDraw.count + 1;
  outColor0 *= outColor0;
  outColor1 = 2u * inputDraw.count + 2;
  outColor1 *= outColor1;
  outColor2 = 2u * inputDraw.count + 3;
  outColor2 *= outColor2;
  outColor3 = 2u * inputDraw.count + 4;
  outColor3 *= outColor3;
  outColor4 = 2u * inputDraw.count + 5;
  outColor4 *= outColor4;
  outColor5 = 2u * inputDraw.count + 6;
  outColor5 *= outColor5;
  outColor6 = 2u * inputDraw.count + 7;
  outColor6 *= outColor6;
}
