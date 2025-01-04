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
layout(location=7) out uint outColor7;
layout(location=8) out uint outColor8;
layout(location=9) out uint outColor9;
layout(location=10) out uint outColor10;
layout(location=11) out uint outColor11;
layout(location=12) out uint outColor12;
layout(location=13) out uint outColor13;
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
  outColor7 = 2u * inputDraw.count + 8;
  outColor7 *= outColor7;
  outColor8 = 2u * inputDraw.count + 9;
  outColor8 *= outColor8;
  outColor9 = 2u * inputDraw.count + 10;
  outColor9 *= outColor9;
  outColor10 = 2u * inputDraw.count + 11;
  outColor10 *= outColor10;
  outColor11 = 2u * inputDraw.count + 12;
  outColor11 *= outColor11;
  outColor12 = 2u * inputDraw.count + 13;
  outColor12 *= outColor12;
  outColor13 = 2u * inputDraw.count + 14;
  outColor13 *= outColor13;
}
