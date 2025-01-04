#version 450
void main (void)
{
  const float x = (-1.0+2.0*((gl_VertexIndex & 2)>>1));
  const float y = ( 1.0-2.0* (gl_VertexIndex % 2));
  gl_Position = vec4(x, y, 0.6, 1.0);
}
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
#version 450
layout(push_constant) uniform InputDraw {
  uint count;
} inputDraw;
layout(location=0) out uint outColor0;
layout(location=1) out uint outColor1;
layout(location=2) out uint outColor2;
void main()
{
  outColor0 = 2u * inputDraw.count + 1;
  outColor0 *= outColor0;
  outColor1 = 2u * inputDraw.count + 2;
  outColor1 *= outColor1;
  outColor2 = 2u * inputDraw.count + 3;
  outColor2 *= outColor2;
}
#version 450
layout(push_constant) uniform InputDraw {
  uint count;
} inputDraw;
layout(location=0) out uint outColor0;
layout(location=1) out uint outColor1;
layout(location=2) out uint outColor2;
layout(location=3) out uint outColor3;
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
}
#version 450
layout(push_constant) uniform InputDraw {
  uint count;
} inputDraw;
layout(location=0) out uint outColor0;
layout(location=1) out uint outColor1;
layout(location=2) out uint outColor2;
layout(location=3) out uint outColor3;
layout(location=4) out uint outColor4;
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
}
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
}
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
}
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
layout(location=14) out uint outColor14;
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
  outColor14 = 2u * inputDraw.count + 15;
  outColor14 *= outColor14;
}
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
layout(location=14) out uint outColor14;
layout(location=15) out uint outColor15;
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
  outColor14 = 2u * inputDraw.count + 15;
  outColor14 *= outColor14;
  outColor15 = 2u * inputDraw.count + 16;
  outColor15 *= outColor15;
}
#version 450
layout(input_attachment_index=0, binding=0) uniform usubpassInput inColor0;
layout(input_attachment_index=1, binding=1) uniform usubpassInput inColor1;
layout(input_attachment_index = 2, binding = 2) uniform subpassInput inDepth;
layout(input_attachment_index = 3, binding = 3) uniform usubpassInput inStencil;
layout(set=1, binding=0, std430) writeonly buffer Output
{
  uint v[];
} outBuffer;
void main()
{
  uint result = 0;
  result = result + 1 * subpassLoad(inColor0).x; 
  result = result + 2 * subpassLoad(inColor1).x; 
  result = result + uint(subpassLoad(inDepth).x * 1000);
  result = result + uint(subpassLoad(inStencil).x * 1000);
  const uvec2 i = uvec2(trunc(gl_FragCoord.xy));
  outBuffer.v[i.x+i.y*16] = result;
}
#version 450
layout(input_attachment_index=0, binding=0) uniform usubpassInput inColor0;
layout(input_attachment_index=1, binding=1) uniform usubpassInput inColor1;
layout(input_attachment_index=2, binding=2) uniform usubpassInput inColor2;
layout(input_attachment_index=3, binding=3) uniform usubpassInput inColor3;
layout(set=1, binding=0, std430) writeonly buffer Output
{
  uint v[];
} outBuffer;
void main()
{
  uint result = 0;
  result = result + 1 * subpassLoad(inColor0).x; 
  result = result + 2 * subpassLoad(inColor1).x; 
  result = result + 3 * subpassLoad(inColor2).x; 
  result = result + 4 * subpassLoad(inColor3).x; 
  const uvec2 i = uvec2(trunc(gl_FragCoord.xy));
  outBuffer.v[i.x+i.y*16] = result;
}
#version 450
layout(input_attachment_index=0, binding=0) uniform usubpassInput inColor0;
layout(input_attachment_index=1, binding=1) uniform usubpassInput inColor1;
layout(input_attachment_index=2, binding=2) uniform usubpassInput inColor2;
layout(input_attachment_index = 3, binding = 3) uniform subpassInput inDepth;
layout(input_attachment_index = 4, binding = 4) uniform usubpassInput inStencil;
layout(set=1, binding=0, std430) writeonly buffer Output
{
  uint v[];
} outBuffer;
void main()
{
  uint result = 0;
  result = result + 1 * subpassLoad(inColor0).x; 
  result = result + 2 * subpassLoad(inColor1).x; 
  result = result + 3 * subpassLoad(inColor2).x; 
  result = result + uint(subpassLoad(inDepth).x * 1000);
  result = result + uint(subpassLoad(inStencil).x * 1000);
  const uvec2 i = uvec2(trunc(gl_FragCoord.xy));
  outBuffer.v[i.x+i.y*16] = result;
}
#version 450
layout(input_attachment_index=0, binding=0) uniform usubpassInput inColor0;
layout(input_attachment_index=1, binding=1) uniform usubpassInput inColor1;
layout(input_attachment_index=2, binding=2) uniform usubpassInput inColor2;
layout(input_attachment_index=3, binding=3) uniform usubpassInput inColor3;
layout(input_attachment_index=4, binding=4) uniform usubpassInput inColor4;
layout(set=1, binding=0, std430) writeonly buffer Output
{
  uint v[];
} outBuffer;
void main()
{
  uint result = 0;
  result = result + 1 * subpassLoad(inColor0).x; 
  result = result + 2 * subpassLoad(inColor1).x; 
  result = result + 3 * subpassLoad(inColor2).x; 
  result = result + 4 * subpassLoad(inColor3).x; 
  result = result + 5 * subpassLoad(inColor4).x; 
  const uvec2 i = uvec2(trunc(gl_FragCoord.xy));
  outBuffer.v[i.x+i.y*16] = result;
}
#version 450
layout(input_attachment_index=0, binding=0) uniform usubpassInput inColor0;
layout(input_attachment_index=1, binding=1) uniform usubpassInput inColor1;
layout(input_attachment_index=2, binding=2) uniform usubpassInput inColor2;
layout(input_attachment_index=3, binding=3) uniform usubpassInput inColor3;
layout(input_attachment_index = 4, binding = 4) uniform subpassInput inDepth;
layout(input_attachment_index = 5, binding = 5) uniform usubpassInput inStencil;
layout(set=1, binding=0, std430) writeonly buffer Output
{
  uint v[];
} outBuffer;
void main()
{
  uint result = 0;
  result = result + 1 * subpassLoad(inColor0).x; 
  result = result + 2 * subpassLoad(inColor1).x; 
  result = result + 3 * subpassLoad(inColor2).x; 
  result = result + 4 * subpassLoad(inColor3).x; 
  result = result + uint(subpassLoad(inDepth).x * 1000);
  result = result + uint(subpassLoad(inStencil).x * 1000);
  const uvec2 i = uvec2(trunc(gl_FragCoord.xy));
  outBuffer.v[i.x+i.y*16] = result;
}
#version 450
layout(input_attachment_index=0, binding=0) uniform usubpassInput inColor0;
layout(input_attachment_index=1, binding=1) uniform usubpassInput inColor1;
layout(input_attachment_index=2, binding=2) uniform usubpassInput inColor2;
layout(input_attachment_index=3, binding=3) uniform usubpassInput inColor3;
layout(input_attachment_index=4, binding=4) uniform usubpassInput inColor4;
layout(input_attachment_index=5, binding=5) uniform usubpassInput inColor5;
layout(set=1, binding=0, std430) writeonly buffer Output
{
  uint v[];
} outBuffer;
void main()
{
  uint result = 0;
  result = result + 1 * subpassLoad(inColor0).x; 
  result = result + 2 * subpassLoad(inColor1).x; 
  result = result + 3 * subpassLoad(inColor2).x; 
  result = result + 4 * subpassLoad(inColor3).x; 
  result = result + 5 * subpassLoad(inColor4).x; 
  result = result + 6 * subpassLoad(inColor5).x; 
  const uvec2 i = uvec2(trunc(gl_FragCoord.xy));
  outBuffer.v[i.x+i.y*16] = result;
}
#version 450
layout(input_attachment_index=0, binding=0) uniform usubpassInput inColor0;
layout(input_attachment_index=1, binding=1) uniform usubpassInput inColor1;
layout(input_attachment_index=2, binding=2) uniform usubpassInput inColor2;
layout(input_attachment_index=3, binding=3) uniform usubpassInput inColor3;
layout(input_attachment_index=4, binding=4) uniform usubpassInput inColor4;
layout(input_attachment_index = 5, binding = 5) uniform subpassInput inDepth;
layout(input_attachment_index = 6, binding = 6) uniform usubpassInput inStencil;
layout(set=1, binding=0, std430) writeonly buffer Output
{
  uint v[];
} outBuffer;
void main()
{
  uint result = 0;
  result = result + 1 * subpassLoad(inColor0).x; 
  result = result + 2 * subpassLoad(inColor1).x; 
  result = result + 3 * subpassLoad(inColor2).x; 
  result = result + 4 * subpassLoad(inColor3).x; 
  result = result + 5 * subpassLoad(inColor4).x; 
  result = result + uint(subpassLoad(inDepth).x * 1000);
  result = result + uint(subpassLoad(inStencil).x * 1000);
  const uvec2 i = uvec2(trunc(gl_FragCoord.xy));
  outBuffer.v[i.x+i.y*16] = result;
}
#version 450
layout(input_attachment_index=0, binding=0) uniform usubpassInput inColor0;
layout(input_attachment_index=1, binding=1) uniform usubpassInput inColor1;
layout(input_attachment_index=2, binding=2) uniform usubpassInput inColor2;
layout(input_attachment_index=3, binding=3) uniform usubpassInput inColor3;
layout(input_attachment_index=4, binding=4) uniform usubpassInput inColor4;
layout(input_attachment_index=5, binding=5) uniform usubpassInput inColor5;
layout(input_attachment_index=6, binding=6) uniform usubpassInput inColor6;
layout(set=1, binding=0, std430) writeonly buffer Output
{
  uint v[];
} outBuffer;
void main()
{
  uint result = 0;
  result = result + 1 * subpassLoad(inColor0).x; 
  result = result + 2 * subpassLoad(inColor1).x; 
  result = result + 3 * subpassLoad(inColor2).x; 
  result = result + 4 * subpassLoad(inColor3).x; 
  result = result + 5 * subpassLoad(inColor4).x; 
  result = result + 6 * subpassLoad(inColor5).x; 
  result = result + 7 * subpassLoad(inColor6).x; 
  const uvec2 i = uvec2(trunc(gl_FragCoord.xy));
  outBuffer.v[i.x+i.y*16] = result;
}
#version 450
layout(input_attachment_index=0, binding=0) uniform usubpassInput inColor0;
layout(input_attachment_index=1, binding=1) uniform usubpassInput inColor1;
layout(input_attachment_index=2, binding=2) uniform usubpassInput inColor2;
layout(input_attachment_index=3, binding=3) uniform usubpassInput inColor3;
layout(input_attachment_index=4, binding=4) uniform usubpassInput inColor4;
layout(input_attachment_index=5, binding=5) uniform usubpassInput inColor5;
layout(input_attachment_index = 6, binding = 6) uniform subpassInput inDepth;
layout(input_attachment_index = 7, binding = 7) uniform usubpassInput inStencil;
layout(set=1, binding=0, std430) writeonly buffer Output
{
  uint v[];
} outBuffer;
void main()
{
  uint result = 0;
  result = result + 1 * subpassLoad(inColor0).x; 
  result = result + 2 * subpassLoad(inColor1).x; 
  result = result + 3 * subpassLoad(inColor2).x; 
  result = result + 4 * subpassLoad(inColor3).x; 
  result = result + 5 * subpassLoad(inColor4).x; 
  result = result + 6 * subpassLoad(inColor5).x; 
  result = result + uint(subpassLoad(inDepth).x * 1000);
  result = result + uint(subpassLoad(inStencil).x * 1000);
  const uvec2 i = uvec2(trunc(gl_FragCoord.xy));
  outBuffer.v[i.x+i.y*16] = result;
}
#version 450
layout(input_attachment_index=0, binding=0) uniform usubpassInput inColor0;
layout(input_attachment_index=1, binding=1) uniform usubpassInput inColor1;
layout(input_attachment_index=2, binding=2) uniform usubpassInput inColor2;
layout(input_attachment_index=3, binding=3) uniform usubpassInput inColor3;
layout(input_attachment_index=4, binding=4) uniform usubpassInput inColor4;
layout(input_attachment_index=5, binding=5) uniform usubpassInput inColor5;
layout(input_attachment_index=6, binding=6) uniform usubpassInput inColor6;
layout(input_attachment_index=7, binding=7) uniform usubpassInput inColor7;
layout(set=1, binding=0, std430) writeonly buffer Output
{
  uint v[];
} outBuffer;
void main()
{
  uint result = 0;
  result = result + 1 * subpassLoad(inColor0).x; 
  result = result + 2 * subpassLoad(inColor1).x; 
  result = result + 3 * subpassLoad(inColor2).x; 
  result = result + 4 * subpassLoad(inColor3).x; 
  result = result + 5 * subpassLoad(inColor4).x; 
  result = result + 6 * subpassLoad(inColor5).x; 
  result = result + 7 * subpassLoad(inColor6).x; 
  result = result + 8 * subpassLoad(inColor7).x; 
  const uvec2 i = uvec2(trunc(gl_FragCoord.xy));
  outBuffer.v[i.x+i.y*16] = result;
}
#version 450
layout(input_attachment_index=0, binding=0) uniform usubpassInput inColor0;
layout(input_attachment_index=1, binding=1) uniform usubpassInput inColor1;
layout(input_attachment_index=2, binding=2) uniform usubpassInput inColor2;
layout(input_attachment_index=3, binding=3) uniform usubpassInput inColor3;
layout(input_attachment_index=4, binding=4) uniform usubpassInput inColor4;
layout(input_attachment_index=5, binding=5) uniform usubpassInput inColor5;
layout(input_attachment_index=6, binding=6) uniform usubpassInput inColor6;
layout(input_attachment_index = 7, binding = 7) uniform subpassInput inDepth;
layout(input_attachment_index = 8, binding = 8) uniform usubpassInput inStencil;
layout(set=1, binding=0, std430) writeonly buffer Output
{
  uint v[];
} outBuffer;
void main()
{
  uint result = 0;
  result = result + 1 * subpassLoad(inColor0).x; 
  result = result + 2 * subpassLoad(inColor1).x; 
  result = result + 3 * subpassLoad(inColor2).x; 
  result = result + 4 * subpassLoad(inColor3).x; 
  result = result + 5 * subpassLoad(inColor4).x; 
  result = result + 6 * subpassLoad(inColor5).x; 
  result = result + 7 * subpassLoad(inColor6).x; 
  result = result + uint(subpassLoad(inDepth).x * 1000);
  result = result + uint(subpassLoad(inStencil).x * 1000);
  const uvec2 i = uvec2(trunc(gl_FragCoord.xy));
  outBuffer.v[i.x+i.y*16] = result;
}
#version 450
layout(input_attachment_index=0, binding=0) uniform usubpassInput inColor0;
layout(input_attachment_index=1, binding=1) uniform usubpassInput inColor1;
layout(input_attachment_index=2, binding=2) uniform usubpassInput inColor2;
layout(input_attachment_index=3, binding=3) uniform usubpassInput inColor3;
layout(input_attachment_index=4, binding=4) uniform usubpassInput inColor4;
layout(input_attachment_index=5, binding=5) uniform usubpassInput inColor5;
layout(input_attachment_index=6, binding=6) uniform usubpassInput inColor6;
layout(input_attachment_index=7, binding=7) uniform usubpassInput inColor7;
layout(input_attachment_index=8, binding=8) uniform usubpassInput inColor8;
layout(set=1, binding=0, std430) writeonly buffer Output
{
  uint v[];
} outBuffer;
void main()
{
  uint result = 0;
  result = result + 1 * subpassLoad(inColor0).x; 
  result = result + 2 * subpassLoad(inColor1).x; 
  result = result + 3 * subpassLoad(inColor2).x; 
  result = result + 4 * subpassLoad(inColor3).x; 
  result = result + 5 * subpassLoad(inColor4).x; 
  result = result + 6 * subpassLoad(inColor5).x; 
  result = result + 7 * subpassLoad(inColor6).x; 
  result = result + 8 * subpassLoad(inColor7).x; 
  result = result + 9 * subpassLoad(inColor8).x; 
  const uvec2 i = uvec2(trunc(gl_FragCoord.xy));
  outBuffer.v[i.x+i.y*16] = result;
}
#version 450
layout(input_attachment_index=0, binding=0) uniform usubpassInput inColor0;
layout(input_attachment_index=1, binding=1) uniform usubpassInput inColor1;
layout(input_attachment_index=2, binding=2) uniform usubpassInput inColor2;
layout(input_attachment_index=3, binding=3) uniform usubpassInput inColor3;
layout(input_attachment_index=4, binding=4) uniform usubpassInput inColor4;
layout(input_attachment_index=5, binding=5) uniform usubpassInput inColor5;
layout(input_attachment_index=6, binding=6) uniform usubpassInput inColor6;
layout(input_attachment_index=7, binding=7) uniform usubpassInput inColor7;
layout(input_attachment_index = 8, binding = 8) uniform subpassInput inDepth;
layout(input_attachment_index = 9, binding = 9) uniform usubpassInput inStencil;
layout(set=1, binding=0, std430) writeonly buffer Output
{
  uint v[];
} outBuffer;
void main()
{
  uint result = 0;
  result = result + 1 * subpassLoad(inColor0).x; 
  result = result + 2 * subpassLoad(inColor1).x; 
  result = result + 3 * subpassLoad(inColor2).x; 
  result = result + 4 * subpassLoad(inColor3).x; 
  result = result + 5 * subpassLoad(inColor4).x; 
  result = result + 6 * subpassLoad(inColor5).x; 
  result = result + 7 * subpassLoad(inColor6).x; 
  result = result + 8 * subpassLoad(inColor7).x; 
  result = result + uint(subpassLoad(inDepth).x * 1000);
  result = result + uint(subpassLoad(inStencil).x * 1000);
  const uvec2 i = uvec2(trunc(gl_FragCoord.xy));
  outBuffer.v[i.x+i.y*16] = result;
}
#version 450
layout(input_attachment_index=0, binding=0) uniform usubpassInput inColor0;
layout(input_attachment_index=1, binding=1) uniform usubpassInput inColor1;
layout(input_attachment_index=2, binding=2) uniform usubpassInput inColor2;
layout(input_attachment_index=3, binding=3) uniform usubpassInput inColor3;
layout(input_attachment_index=4, binding=4) uniform usubpassInput inColor4;
layout(input_attachment_index=5, binding=5) uniform usubpassInput inColor5;
layout(input_attachment_index=6, binding=6) uniform usubpassInput inColor6;
layout(input_attachment_index=7, binding=7) uniform usubpassInput inColor7;
layout(input_attachment_index=8, binding=8) uniform usubpassInput inColor8;
layout(input_attachment_index=9, binding=9) uniform usubpassInput inColor9;
layout(set=1, binding=0, std430) writeonly buffer Output
{
  uint v[];
} outBuffer;
void main()
{
  uint result = 0;
  result = result + 1 * subpassLoad(inColor0).x; 
  result = result + 2 * subpassLoad(inColor1).x; 
  result = result + 3 * subpassLoad(inColor2).x; 
  result = result + 4 * subpassLoad(inColor3).x; 
  result = result + 5 * subpassLoad(inColor4).x; 
  result = result + 6 * subpassLoad(inColor5).x; 
  result = result + 7 * subpassLoad(inColor6).x; 
  result = result + 8 * subpassLoad(inColor7).x; 
  result = result + 9 * subpassLoad(inColor8).x; 
  result = result + 10 * subpassLoad(inColor9).x; 
  const uvec2 i = uvec2(trunc(gl_FragCoord.xy));
  outBuffer.v[i.x+i.y*16] = result;
}
#version 450
layout(input_attachment_index=0, binding=0) uniform usubpassInput inColor0;
layout(input_attachment_index=1, binding=1) uniform usubpassInput inColor1;
layout(input_attachment_index=2, binding=2) uniform usubpassInput inColor2;
layout(input_attachment_index=3, binding=3) uniform usubpassInput inColor3;
layout(input_attachment_index=4, binding=4) uniform usubpassInput inColor4;
layout(input_attachment_index=5, binding=5) uniform usubpassInput inColor5;
layout(input_attachment_index=6, binding=6) uniform usubpassInput inColor6;
layout(input_attachment_index=7, binding=7) uniform usubpassInput inColor7;
layout(input_attachment_index=8, binding=8) uniform usubpassInput inColor8;
layout(input_attachment_index=9, binding=9) uniform usubpassInput inColor9;
layout(input_attachment_index=10, binding=10) uniform usubpassInput inColor10;
layout(input_attachment_index=11, binding=11) uniform usubpassInput inColor11;
layout(input_attachment_index=12, binding=12) uniform usubpassInput inColor12;
layout(input_attachment_index=13, binding=13) uniform usubpassInput inColor13;
layout(input_attachment_index = 14, binding = 14) uniform subpassInput inDepth;
layout(input_attachment_index = 15, binding = 15) uniform usubpassInput inStencil;
layout(set=1, binding=0, std430) writeonly buffer Output
{
  uint v[];
} outBuffer;
void main()
{
  uint result = 0;
  result = result + 1 * subpassLoad(inColor0).x; 
  result = result + 2 * subpassLoad(inColor1).x; 
  result = result + 3 * subpassLoad(inColor2).x; 
  result = result + 4 * subpassLoad(inColor3).x; 
  result = result + 5 * subpassLoad(inColor4).x; 
  result = result + 6 * subpassLoad(inColor5).x; 
  result = result + 7 * subpassLoad(inColor6).x; 
  result = result + 8 * subpassLoad(inColor7).x; 
  result = result + 9 * subpassLoad(inColor8).x; 
  result = result + 10 * subpassLoad(inColor9).x; 
  result = result + 11 * subpassLoad(inColor10).x; 
  result = result + 12 * subpassLoad(inColor11).x; 
  result = result + 13 * subpassLoad(inColor12).x; 
  result = result + 14 * subpassLoad(inColor13).x; 
  result = result + uint(subpassLoad(inDepth).x * 1000);
  result = result + uint(subpassLoad(inStencil).x * 1000);
  const uvec2 i = uvec2(trunc(gl_FragCoord.xy));
  outBuffer.v[i.x+i.y*16] = result;
}
#version 450
layout(input_attachment_index=0, binding=0) uniform usubpassInput inColor0;
layout(input_attachment_index=1, binding=1) uniform usubpassInput inColor1;
layout(input_attachment_index=2, binding=2) uniform usubpassInput inColor2;
layout(input_attachment_index=3, binding=3) uniform usubpassInput inColor3;
layout(input_attachment_index=4, binding=4) uniform usubpassInput inColor4;
layout(input_attachment_index=5, binding=5) uniform usubpassInput inColor5;
layout(input_attachment_index=6, binding=6) uniform usubpassInput inColor6;
layout(input_attachment_index=7, binding=7) uniform usubpassInput inColor7;
layout(input_attachment_index=8, binding=8) uniform usubpassInput inColor8;
layout(input_attachment_index=9, binding=9) uniform usubpassInput inColor9;
layout(input_attachment_index=10, binding=10) uniform usubpassInput inColor10;
layout(input_attachment_index=11, binding=11) uniform usubpassInput inColor11;
layout(input_attachment_index=12, binding=12) uniform usubpassInput inColor12;
layout(input_attachment_index=13, binding=13) uniform usubpassInput inColor13;
layout(input_attachment_index=14, binding=14) uniform usubpassInput inColor14;
layout(input_attachment_index=15, binding=15) uniform usubpassInput inColor15;
layout(set=1, binding=0, std430) writeonly buffer Output
{
  uint v[];
} outBuffer;
void main()
{
  uint result = 0;
  result = result + 1 * subpassLoad(inColor0).x; 
  result = result + 2 * subpassLoad(inColor1).x; 
  result = result + 3 * subpassLoad(inColor2).x; 
  result = result + 4 * subpassLoad(inColor3).x; 
  result = result + 5 * subpassLoad(inColor4).x; 
  result = result + 6 * subpassLoad(inColor5).x; 
  result = result + 7 * subpassLoad(inColor6).x; 
  result = result + 8 * subpassLoad(inColor7).x; 
  result = result + 9 * subpassLoad(inColor8).x; 
  result = result + 10 * subpassLoad(inColor9).x; 
  result = result + 11 * subpassLoad(inColor10).x; 
  result = result + 12 * subpassLoad(inColor11).x; 
  result = result + 13 * subpassLoad(inColor12).x; 
  result = result + 14 * subpassLoad(inColor13).x; 
  result = result + 15 * subpassLoad(inColor14).x; 
  result = result + 16 * subpassLoad(inColor15).x; 
  const uvec2 i = uvec2(trunc(gl_FragCoord.xy));
  outBuffer.v[i.x+i.y*16] = result;
}
#version 450
layout(input_attachment_index=0, binding=0) uniform usubpassInput inColor0;
layout(input_attachment_index=1, binding=1) uniform usubpassInput inColor1;
layout(input_attachment_index=2, binding=2) uniform usubpassInput inColor2;
layout(input_attachment_index=3, binding=3) uniform usubpassInput inColor3;
layout(input_attachment_index=4, binding=4) uniform usubpassInput inColor4;
layout(input_attachment_index=5, binding=5) uniform usubpassInput inColor5;
layout(input_attachment_index=6, binding=6) uniform usubpassInput inColor6;
layout(input_attachment_index=7, binding=7) uniform usubpassInput inColor7;
layout(input_attachment_index=8, binding=8) uniform usubpassInput inColor8;
layout(input_attachment_index=9, binding=9) uniform usubpassInput inColor9;
layout(input_attachment_index=10, binding=10) uniform usubpassInput inColor10;
layout(input_attachment_index=11, binding=11) uniform usubpassInput inColor11;
layout(input_attachment_index=12, binding=12) uniform usubpassInput inColor12;
layout(input_attachment_index=13, binding=13) uniform usubpassInput inColor13;
layout(input_attachment_index=14, binding=14) uniform usubpassInput inColor14;
layout(input_attachment_index = 15, binding = 15) uniform subpassInput inDepth;
layout(input_attachment_index = 16, binding = 16) uniform usubpassInput inStencil;
layout(set=1, binding=0, std430) writeonly buffer Output
{
  uint v[];
} outBuffer;
void main()
{
  uint result = 0;
  result = result + 1 * subpassLoad(inColor0).x; 
  result = result + 2 * subpassLoad(inColor1).x; 
  result = result + 3 * subpassLoad(inColor2).x; 
  result = result + 4 * subpassLoad(inColor3).x; 
  result = result + 5 * subpassLoad(inColor4).x; 
  result = result + 6 * subpassLoad(inColor5).x; 
  result = result + 7 * subpassLoad(inColor6).x; 
  result = result + 8 * subpassLoad(inColor7).x; 
  result = result + 9 * subpassLoad(inColor8).x; 
  result = result + 10 * subpassLoad(inColor9).x; 
  result = result + 11 * subpassLoad(inColor10).x; 
  result = result + 12 * subpassLoad(inColor11).x; 
  result = result + 13 * subpassLoad(inColor12).x; 
  result = result + 14 * subpassLoad(inColor13).x; 
  result = result + 15 * subpassLoad(inColor14).x; 
  result = result + uint(subpassLoad(inDepth).x * 1000);
  result = result + uint(subpassLoad(inStencil).x * 1000);
  const uvec2 i = uvec2(trunc(gl_FragCoord.xy));
  outBuffer.v[i.x+i.y*16] = result;
}
#version 450
layout(input_attachment_index=0, binding=0) uniform usubpassInput inColor0;
layout(input_attachment_index=1, binding=1) uniform usubpassInput inColor1;
layout(input_attachment_index=2, binding=2) uniform usubpassInput inColor2;
layout(input_attachment_index=3, binding=3) uniform usubpassInput inColor3;
layout(input_attachment_index=4, binding=4) uniform usubpassInput inColor4;
layout(input_attachment_index=5, binding=5) uniform usubpassInput inColor5;
layout(input_attachment_index=6, binding=6) uniform usubpassInput inColor6;
layout(input_attachment_index=7, binding=7) uniform usubpassInput inColor7;
layout(input_attachment_index=8, binding=8) uniform usubpassInput inColor8;
layout(input_attachment_index=9, binding=9) uniform usubpassInput inColor9;
layout(input_attachment_index=10, binding=10) uniform usubpassInput inColor10;
layout(input_attachment_index=11, binding=11) uniform usubpassInput inColor11;
layout(input_attachment_index=12, binding=12) uniform usubpassInput inColor12;
layout(input_attachment_index=13, binding=13) uniform usubpassInput inColor13;
layout(input_attachment_index=14, binding=14) uniform usubpassInput inColor14;
layout(input_attachment_index=15, binding=15) uniform usubpassInput inColor15;
layout(input_attachment_index=16, binding=16) uniform usubpassInput inColor16;
layout(set=1, binding=0, std430) writeonly buffer Output
{
  uint v[];
} outBuffer;
void main()
{
  uint result = 0;
  result = result + 1 * subpassLoad(inColor0).x; 
  result = result + 2 * subpassLoad(inColor1).x; 
  result = result + 3 * subpassLoad(inColor2).x; 
  result = result + 4 * subpassLoad(inColor3).x; 
  result = result + 5 * subpassLoad(inColor4).x; 
  result = result + 6 * subpassLoad(inColor5).x; 
  result = result + 7 * subpassLoad(inColor6).x; 
  result = result + 8 * subpassLoad(inColor7).x; 
  result = result + 9 * subpassLoad(inColor8).x; 
  result = result + 10 * subpassLoad(inColor9).x; 
  result = result + 11 * subpassLoad(inColor10).x; 
  result = result + 12 * subpassLoad(inColor11).x; 
  result = result + 13 * subpassLoad(inColor12).x; 
  result = result + 14 * subpassLoad(inColor13).x; 
  result = result + 15 * subpassLoad(inColor14).x; 
  result = result + 16 * subpassLoad(inColor15).x; 
  result = result + 17 * subpassLoad(inColor16).x; 
  const uvec2 i = uvec2(trunc(gl_FragCoord.xy));
  outBuffer.v[i.x+i.y*16] = result;
}
#version 450
layout(input_attachment_index=0, binding=0) uniform usubpassInput inColor0;
layout(input_attachment_index=1, binding=1) uniform usubpassInput inColor1;
layout(input_attachment_index=2, binding=2) uniform usubpassInput inColor2;
layout(input_attachment_index=3, binding=3) uniform usubpassInput inColor3;
layout(input_attachment_index=4, binding=4) uniform usubpassInput inColor4;
layout(input_attachment_index=5, binding=5) uniform usubpassInput inColor5;
layout(input_attachment_index=6, binding=6) uniform usubpassInput inColor6;
layout(input_attachment_index=7, binding=7) uniform usubpassInput inColor7;
layout(input_attachment_index=8, binding=8) uniform usubpassInput inColor8;
layout(input_attachment_index=9, binding=9) uniform usubpassInput inColor9;
layout(input_attachment_index=10, binding=10) uniform usubpassInput inColor10;
layout(input_attachment_index=11, binding=11) uniform usubpassInput inColor11;
layout(input_attachment_index=12, binding=12) uniform usubpassInput inColor12;
layout(input_attachment_index=13, binding=13) uniform usubpassInput inColor13;
layout(input_attachment_index=14, binding=14) uniform usubpassInput inColor14;
layout(input_attachment_index=15, binding=15) uniform usubpassInput inColor15;
layout(input_attachment_index = 16, binding = 16) uniform subpassInput inDepth;
layout(input_attachment_index = 17, binding = 17) uniform usubpassInput inStencil;
layout(set=1, binding=0, std430) writeonly buffer Output
{
  uint v[];
} outBuffer;
void main()
{
  uint result = 0;
  result = result + 1 * subpassLoad(inColor0).x; 
  result = result + 2 * subpassLoad(inColor1).x; 
  result = result + 3 * subpassLoad(inColor2).x; 
  result = result + 4 * subpassLoad(inColor3).x; 
  result = result + 5 * subpassLoad(inColor4).x; 
  result = result + 6 * subpassLoad(inColor5).x; 
  result = result + 7 * subpassLoad(inColor6).x; 
  result = result + 8 * subpassLoad(inColor7).x; 
  result = result + 9 * subpassLoad(inColor8).x; 
  result = result + 10 * subpassLoad(inColor9).x; 
  result = result + 11 * subpassLoad(inColor10).x; 
  result = result + 12 * subpassLoad(inColor11).x; 
  result = result + 13 * subpassLoad(inColor12).x; 
  result = result + 14 * subpassLoad(inColor13).x; 
  result = result + 15 * subpassLoad(inColor14).x; 
  result = result + 16 * subpassLoad(inColor15).x; 
  result = result + uint(subpassLoad(inDepth).x * 1000);
  result = result + uint(subpassLoad(inStencil).x * 1000);
  const uvec2 i = uvec2(trunc(gl_FragCoord.xy));
  outBuffer.v[i.x+i.y*16] = result;
}
#version 450
layout(input_attachment_index=0, binding=0) uniform usubpassInput inColor0;
layout(input_attachment_index=1, binding=1) uniform usubpassInput inColor1;
layout(input_attachment_index=2, binding=2) uniform usubpassInput inColor2;
layout(input_attachment_index=3, binding=3) uniform usubpassInput inColor3;
layout(input_attachment_index=4, binding=4) uniform usubpassInput inColor4;
layout(input_attachment_index=5, binding=5) uniform usubpassInput inColor5;
layout(input_attachment_index=6, binding=6) uniform usubpassInput inColor6;
layout(input_attachment_index=7, binding=7) uniform usubpassInput inColor7;
layout(input_attachment_index=8, binding=8) uniform usubpassInput inColor8;
layout(input_attachment_index=9, binding=9) uniform usubpassInput inColor9;
layout(input_attachment_index=10, binding=10) uniform usubpassInput inColor10;
layout(input_attachment_index=11, binding=11) uniform usubpassInput inColor11;
layout(input_attachment_index=12, binding=12) uniform usubpassInput inColor12;
layout(input_attachment_index=13, binding=13) uniform usubpassInput inColor13;
layout(input_attachment_index=14, binding=14) uniform usubpassInput inColor14;
layout(input_attachment_index=15, binding=15) uniform usubpassInput inColor15;
layout(input_attachment_index=16, binding=16) uniform usubpassInput inColor16;
layout(input_attachment_index=17, binding=17) uniform usubpassInput inColor17;
layout(set=1, binding=0, std430) writeonly buffer Output
{
  uint v[];
} outBuffer;
void main()
{
  uint result = 0;
  result = result + 1 * subpassLoad(inColor0).x; 
  result = result + 2 * subpassLoad(inColor1).x; 
  result = result + 3 * subpassLoad(inColor2).x; 
  result = result + 4 * subpassLoad(inColor3).x; 
  result = result + 5 * subpassLoad(inColor4).x; 
  result = result + 6 * subpassLoad(inColor5).x; 
  result = result + 7 * subpassLoad(inColor6).x; 
  result = result + 8 * subpassLoad(inColor7).x; 
  result = result + 9 * subpassLoad(inColor8).x; 
  result = result + 10 * subpassLoad(inColor9).x; 
  result = result + 11 * subpassLoad(inColor10).x; 
  result = result + 12 * subpassLoad(inColor11).x; 
  result = result + 13 * subpassLoad(inColor12).x; 
  result = result + 14 * subpassLoad(inColor13).x; 
  result = result + 15 * subpassLoad(inColor14).x; 
  result = result + 16 * subpassLoad(inColor15).x; 
  result = result + 17 * subpassLoad(inColor16).x; 
  result = result + 18 * subpassLoad(inColor17).x; 
  const uvec2 i = uvec2(trunc(gl_FragCoord.xy));
  outBuffer.v[i.x+i.y*16] = result;
}
OpCapability Shader
OpCapability InputAttachment
%1 = OpExtInstImport "GLSL.std.450";
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %4 "main" %51
OpExecutionMode %4 OriginUpperLeft
OpDecorate %11 DescriptorSet 0
OpDecorate %11 Binding 0
OpDecorate %11 InputAttachmentIndex 0
OpDecorate %21 DescriptorSet 0
OpDecorate %21 Binding 1
OpDecorate %21 InputAttachmentIndex 1
OpDecorate %30 DescriptorSet 0
OpDecorate %30 Binding 2
OpDecorate %40 DescriptorSet 0
OpDecorate %40 Binding 3
OpDecorate %51 BuiltIn FragCoord
OpDecorate %57 ArrayStride 4
OpMemberDecorate %58 0 NonReadable
OpMemberDecorate %58 0 Offset 0
OpDecorate %58 BufferBlock
OpDecorate %60 DescriptorSet 1
OpDecorate %60 Binding 0
%2 = OpTypeVoid
%3 = OpTypeFunction %2
%6 = OpTypeInt 32 0
%7 = OpTypePointer Function %6
%9 = OpTypeImage %6 SubpassData 0 0 0 2 Unknown
%10 = OpTypePointer UniformConstant %9
%11 = OpVariable %10 UniformConstant
%13 = OpTypeInt 32 1
%14 = OpConstant %13 0
%15 = OpTypeVector %13 2
%16 = OpConstantComposite %15 %14 %14
%17 = OpTypeVector %6 4
%19 = OpConstant %6 0
%21 = OpVariable %10 UniformConstant
%27 = OpTypeFloat 32
%28 = OpTypeImage %27 SubpassData 0 0 0 2 Unknown
%29 = OpTypePointer UniformConstant %28
%30 = OpVariable %29 UniformConstant
%32 = OpTypeVector %27 4
%35 = OpConstant %27 1000
%40 = OpVariable %10 UniformConstant
%44 = OpConstant %6 100
%47 = OpTypeVector %6 2
%48 = OpTypePointer Function %47
%50 = OpTypePointer Input %32
%51 = OpVariable %50 Input
%52 = OpTypeVector %27 2
%57 = OpTypeRuntimeArray %6
%58 = OpTypeStruct %57
%59 = OpTypePointer Uniform %58
%60 = OpVariable %59 Uniform
%63 = OpConstant %6 1
%66 = OpConstant %6 16
%70 = OpTypePointer Uniform %6
%4 = OpFunction %2 None %3
%5 = OpLabel
%8 = OpVariable %7 Function
%49 = OpVariable %48 Function
%12 = OpLoad %9 %11
%18 = OpImageRead %17 %12 %16
%20 = OpCompositeExtract %6 %18 0
%22 = OpLoad %9 %21
%23 = OpImageRead %17 %22 %16
%24 = OpCompositeExtract %6 %23 0
%25 = OpIAdd %6 %20 %24
OpStore %8 %25
%26 = OpLoad %6 %8
%31 = OpLoad %28 %30
%33 = OpImageRead %32 %31 %16
%34 = OpCompositeExtract %27 %33 0
%36 = OpFMul %27 %34 %35
%37 = OpConvertFToU %6 %36
%38 = OpIAdd %6 %26 %37
OpStore %8 %38
%39 = OpLoad %6 %8
%41 = OpLoad %9 %40
%42 = OpImageRead %17 %41 %16
%43 = OpCompositeExtract %6 %42 0
%45 = OpIMul %6 %43 %44
%46 = OpIAdd %6 %39 %45
OpStore %8 %46
%53 = OpLoad %32 %51
%54 = OpVectorShuffle %52 %53 %53 0 1
%55 = OpExtInst %52 %1 Trunc %54
%56 = OpConvertFToU %47 %55
OpStore %49 %56
%61 = OpAccessChain %7 %49 %19
%62 = OpLoad %6 %61
%64 = OpAccessChain %7 %49 %63
%65 = OpLoad %6 %64
%67 = OpIMul %6 %65 %66
%68 = OpIAdd %6 %62 %67
%69 = OpLoad %6 %8
%71 = OpAccessChain %70 %60 %14 %68
OpStore %71 %69
OpReturn
OpFunctionEnd
#version 450
layout(push_constant) uniform InputDraw {
  uint count;
} inputDraw;
void main()
{
}
OpCapability Shader
OpCapability InputAttachment
%1 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %4 "main" %29
OpExecutionMode %4 OriginUpperLeft
OpDecorate %12 Binding 0
OpDecorate %12 DescriptorSet 0
OpDecorate %29 BuiltIn FragCoord
OpDecorate %35 ArrayStride 4
OpDecorate %36 BufferBlock
OpMemberDecorate %36 0 NonReadable
OpMemberDecorate %36 0 Offset 0
OpDecorate %38 NonReadable
OpDecorate %38 Binding 0
OpDecorate %38 DescriptorSet 1
%2 = OpTypeVoid
%3 = OpTypeFunction %2
%6 = OpTypeInt 32 0
%7 = OpTypePointer Function %6
%9 = OpTypeFloat 32
%10 = OpTypeImage %9 SubpassData 0 0 0 2 Unknown
%11 = OpTypePointer UniformConstant %10
%12 = OpVariable %11 UniformConstant
%14 = OpTypeInt 32 1
%15 = OpConstant %14 0
%16 = OpTypeVector %14 2
%17 = OpConstantComposite %16 %15 %15
%18 = OpTypeVector %9 4
%50 = OpTypeVector %6 4
%20 = OpConstant %6 0
%22 = OpConstant %9 1000
%25 = OpTypeVector %6 2
%26 = OpTypePointer Function %25
%28 = OpTypePointer Input %18
%29 = OpVariable %28 Input
%30 = OpTypeVector %9 2
%35 = OpTypeRuntimeArray %6
%36 = OpTypeStruct %35
%37 = OpTypePointer Uniform %36
%38 = OpVariable %37 Uniform
%41 = OpConstant %6 1
%44 = OpConstant %6 16
%48 = OpTypePointer Uniform %6
%4 = OpFunction %2 None %3
%5 = OpLabel
%8 = OpVariable %7 Function
%27 = OpVariable %26 Function
%13 = OpLoad %10 %12
%19 = OpImageRead %18 %13 %17
%21 = OpCompositeExtract %9 %19 0
%23 = OpFMul %9 %21 %22
%24 = OpConvertFToU %6 %23
OpStore %8 %24
%31 = OpLoad %18 %29
%32 = OpVectorShuffle %30 %31 %31 0 1
%33 = OpExtInst %30 %1 Trunc %32
%34 = OpConvertFToU %25 %33
OpStore %27 %34
%39 = OpAccessChain %7 %27 %20
%40 = OpLoad %6 %39
%42 = OpAccessChain %7 %27 %41
%43 = OpLoad %6 %42
%45 = OpIMul %6 %43 %44
%46 = OpIAdd %6 %40 %45
%47 = OpLoad %6 %8
%49 = OpAccessChain %48 %38 %15 %46
OpStore %49 %47
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability InputAttachment
%1 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %4 "main" %29
OpExecutionMode %4 OriginUpperLeft
OpDecorate %12 Binding 0
OpDecorate %12 DescriptorSet 0
OpDecorate %29 BuiltIn FragCoord
OpDecorate %35 ArrayStride 4
OpDecorate %36 BufferBlock
OpMemberDecorate %36 0 NonReadable
OpMemberDecorate %36 0 Offset 0
OpDecorate %38 NonReadable
OpDecorate %38 Binding 0
OpDecorate %38 DescriptorSet 1
%2 = OpTypeVoid
%3 = OpTypeFunction %2
%6 = OpTypeInt 32 0
%7 = OpTypePointer Function %6
%9 = OpTypeFloat 32
%10 = OpTypeImage %6 SubpassData 0 0 0 2 Unknown
%11 = OpTypePointer UniformConstant %10
%12 = OpVariable %11 UniformConstant
%14 = OpTypeInt 32 1
%15 = OpConstant %14 0
%16 = OpTypeVector %14 2
%17 = OpConstantComposite %16 %15 %15
%18 = OpTypeVector %9 4
%50 = OpTypeVector %6 4
%20 = OpConstant %6 0
%22 = OpConstant %9 1000
%25 = OpTypeVector %6 2
%26 = OpTypePointer Function %25
%28 = OpTypePointer Input %18
%29 = OpVariable %28 Input
%30 = OpTypeVector %9 2
%35 = OpTypeRuntimeArray %6
%36 = OpTypeStruct %35
%37 = OpTypePointer Uniform %36
%38 = OpVariable %37 Uniform
%41 = OpConstant %6 1
%44 = OpConstant %6 16
%48 = OpTypePointer Uniform %6
%4 = OpFunction %2 None %3
%5 = OpLabel
%8 = OpVariable %7 Function
%27 = OpVariable %26 Function
%13 = OpLoad %10 %12
%19 = OpImageRead %50 %13 %17
%21 = OpCompositeExtract %6 %19 0
OpStore %8 %21
%31 = OpLoad %18 %29
%32 = OpVectorShuffle %30 %31 %31 0 1
%33 = OpExtInst %30 %1 Trunc %32
%34 = OpConvertFToU %25 %33
OpStore %27 %34
%39 = OpAccessChain %7 %27 %20
%40 = OpLoad %6 %39
%42 = OpAccessChain %7 %27 %41
%43 = OpLoad %6 %42
%45 = OpIMul %6 %43 %44
%46 = OpIAdd %6 %40 %45
%47 = OpLoad %6 %8
%49 = OpAccessChain %48 %38 %15 %46
OpStore %49 %47
OpReturn
OpFunctionEnd
#version 450
layout(input_attachment_index=0, binding=0) uniform usubpassInput inColor0;
layout(input_attachment_index=1, binding=1) uniform usubpassInput inColor1;
layout(input_attachment_index=2, binding=2) uniform usubpassInput inColor2;
layout(input_attachment_index=3, binding=3) uniform usubpassInput inColor3;
layout(input_attachment_index = 4, binding = 4) uniform subpassInput inDepth;
layout(set=1, binding=0, std430) writeonly buffer Output
{
  uint v[];
} outBuffer;
void main()
{
  uint result = 0;
  result = result + 1 * subpassLoad(inColor0).x; 
  result = result + 2 * subpassLoad(inColor1).x; 
  result = result + 3 * subpassLoad(inColor2).x; 
  result = result + 4 * subpassLoad(inColor3).x; 
  result = result + uint(subpassLoad(inDepth).x * 1000);
  const uvec2 i = uvec2(trunc(gl_FragCoord.xy));
  outBuffer.v[i.x+i.y*16] = result;
}
OpCapability Shader
                                            OpCapability InputAttachment
                                           %1 = OpExtInstImport "GLSL.std.450"
                                           OpMemoryModel Logical GLSL450
                                           OpEntryPoint Fragment %4 "main" %13
                                           OpExecutionMode %4 OriginUpperLeft
                                           OpDecorate %13 BuiltIn FragCoord
                                           OpDecorate %23 DescriptorSet 0
                                           OpDecorate %23 Binding 0
                                           OpDecorate %23 InputAttachmentIndex 0
                                           OpDecorate %34 DescriptorSet 0
                                           OpDecorate %34 Binding 1
                                           OpDecorate %34 InputAttachmentIndex 1
                                           OpDecorate %41 DescriptorSet 0
                                           OpDecorate %41 Binding 2
                                           OpDecorate %41 InputAttachmentIndex 2
                                           OpDecorate %47 ArrayStride 4
                                           OpMemberDecorate %48 0 NonReadable
                                           OpMemberDecorate %48 0 Offset 0
                                           OpDecorate %48 BufferBlock
                                           OpDecorate %50 DescriptorSet 1
                                           OpDecorate %50 Binding 0
                                           OpDecorate %62 DescriptorSet 0
OpDecorate %62 Binding 3

                                           %2 = OpTypeVoid
                                           %3 = OpTypeFunction %2
                                           %6 = OpTypeInt 32 0
                                           %7 = OpTypeVector %6 2
                                           %8 = OpTypePointer Function %7
                                           %10 = OpTypeFloat 32
                                           %11 = OpTypeVector %10 4
                                           %12 = OpTypePointer Input %11
                                           %13 = OpVariable %12 Input
                                           %14 = OpTypeVector %10 2
                                           %19 = OpTypePointer Function %6
                                           %21 = OpTypeImage %6 SubpassData 0 0 0 2 Unknown
                                           %22 = OpTypePointer UniformConstant %21
                                           %23 = OpVariable %22 UniformConstant
                                           %25 = OpTypeInt 32 1
                                           %26 = OpConstant %25 0
                                           %27 = OpTypeVector %25 2
                                           %28 = OpConstantComposite %27 %26 %26
                                           %29 = OpTypeVector %6 4
                                           %31 = OpConstant %6 0
                                           %33 = OpConstant %6 2
                                           %34 = OpVariable %22 UniformConstant
                                           %40 = OpConstant %6 3
                                           %41 = OpVariable %22 UniformConstant
                                           %47 = OpTypeRuntimeArray %6
                                           %48 = OpTypeStruct %47
                                           %49 = OpTypePointer Uniform %48
                                           %50 = OpVariable %49 Uniform
                                           %53 = OpConstant %6 1
                                           %56 = OpConstant %6 16
                                           %60 = OpTypeImage %10 SubpassData 0 0 0 2 Unknown
%61 = OpTypePointer UniformConstant %60
%62 = OpVariable %61 UniformConstant
%66 = OpConstant %10 1000

                                           %70 = OpTypePointer Uniform %6
                                           %4 = OpFunction %2 None %3
                                           %5 = OpLabel
                                           %9 = OpVariable %8 Function
                                           %20 = OpVariable %19 Function
                                           %15 = OpLoad %11 %13
                                           %16 = OpVectorShuffle %14 %15 %15 0 1
                                           %17 = OpExtInst %14 %1 Trunc %16
                                           %18 = OpConvertFToU %7 %17
                                           OpStore %9 %18
                                           %24 = OpLoad %21 %23
                                           %30 = OpImageRead %29 %24 %28
                                           %32 = OpCompositeExtract %6 %30 0
                                           %35 = OpLoad %21 %34
                                           %36 = OpImageRead %29 %35 %28
                                           %37 = OpCompositeExtract %6 %36 0
                                           %38 = OpIMul %6 %33 %37
                                           %39 = OpIAdd %6 %32 %38
                                           %42 = OpLoad %21 %41
                                           %43 = OpImageRead %29 %42 %28
                                           %44 = OpCompositeExtract %6 %43 0
                                           %45 = OpIMul %6 %40 %44
                                           %46 = OpIAdd %6 %39 %45
                                           OpStore %20 %46
                                           %51 = OpAccessChain %19 %9 %31
                                           %52 = OpLoad %6 %51
                                           %54 = OpAccessChain %19 %9 %53
                                           %55 = OpLoad %6 %54
                                           %57 = OpIMul %6 %55 %56
                                           %58 = OpIAdd %6 %52 %57
                                           %59 = OpLoad %6 %20
                                           %63 = OpLoad %60 %62
%64 = OpImageRead %11 %63 %28
%65 = OpCompositeExtract %10 %64 0
%67 = OpFMul %10 %65 %66
%68 = OpConvertFToU %6 %67
%69 = OpIAdd %6 %59 %68

                                           %71 = OpAccessChain %70 %50 %26 %58
                                           OpStore %71 %69
                                           OpReturn
                                           OpFunctionEnd
OpCapability Shader
                                            OpCapability InputAttachment
                                           %1 = OpExtInstImport "GLSL.std.450"
                                           OpMemoryModel Logical GLSL450
                                           OpEntryPoint Fragment %4 "main" %13
                                           OpExecutionMode %4 OriginUpperLeft
                                           OpDecorate %13 BuiltIn FragCoord
                                           OpDecorate %23 DescriptorSet 0
                                           OpDecorate %23 Binding 0
                                           OpDecorate %23 InputAttachmentIndex 0
                                           OpDecorate %34 DescriptorSet 0
                                           OpDecorate %34 Binding 1
                                           OpDecorate %34 InputAttachmentIndex 1
                                           OpDecorate %41 DescriptorSet 0
                                           OpDecorate %41 Binding 2
                                           OpDecorate %41 InputAttachmentIndex 2
                                           OpDecorate %47 ArrayStride 4
                                           OpMemberDecorate %48 0 NonReadable
                                           OpMemberDecorate %48 0 Offset 0
                                           OpDecorate %48 BufferBlock
                                           OpDecorate %50 DescriptorSet 1
                                           OpDecorate %50 Binding 0
                                           
                                           %2 = OpTypeVoid
                                           %3 = OpTypeFunction %2
                                           %6 = OpTypeInt 32 0
                                           %7 = OpTypeVector %6 2
                                           %8 = OpTypePointer Function %7
                                           %10 = OpTypeFloat 32
                                           %11 = OpTypeVector %10 4
                                           %12 = OpTypePointer Input %11
                                           %13 = OpVariable %12 Input
                                           %14 = OpTypeVector %10 2
                                           %19 = OpTypePointer Function %6
                                           %21 = OpTypeImage %6 SubpassData 0 0 0 2 Unknown
                                           %22 = OpTypePointer UniformConstant %21
                                           %23 = OpVariable %22 UniformConstant
                                           %25 = OpTypeInt 32 1
                                           %26 = OpConstant %25 0
                                           %27 = OpTypeVector %25 2
                                           %28 = OpConstantComposite %27 %26 %26
                                           %29 = OpTypeVector %6 4
                                           %31 = OpConstant %6 0
                                           %33 = OpConstant %6 2
                                           %34 = OpVariable %22 UniformConstant
                                           %40 = OpConstant %6 3
                                           %41 = OpVariable %22 UniformConstant
                                           %47 = OpTypeRuntimeArray %6
                                           %48 = OpTypeStruct %47
                                           %49 = OpTypePointer Uniform %48
                                           %50 = OpVariable %49 Uniform
                                           %53 = OpConstant %6 1
                                           %56 = OpConstant %6 16
                                           
                                           %70 = OpTypePointer Uniform %6
                                           %4 = OpFunction %2 None %3
                                           %5 = OpLabel
                                           %9 = OpVariable %8 Function
                                           %20 = OpVariable %19 Function
                                           %15 = OpLoad %11 %13
                                           %16 = OpVectorShuffle %14 %15 %15 0 1
                                           %17 = OpExtInst %14 %1 Trunc %16
                                           %18 = OpConvertFToU %7 %17
                                           OpStore %9 %18
                                           %24 = OpLoad %21 %23
                                           %30 = OpImageRead %29 %24 %28
                                           %32 = OpCompositeExtract %6 %30 0
                                           %35 = OpLoad %21 %34
                                           %36 = OpImageRead %29 %35 %28
                                           %37 = OpCompositeExtract %6 %36 0
                                           %38 = OpIMul %6 %33 %37
                                           %39 = OpIAdd %6 %32 %38
                                           %42 = OpLoad %21 %41
                                           %43 = OpImageRead %29 %42 %28
                                           %44 = OpCompositeExtract %6 %43 0
                                           %45 = OpIMul %6 %40 %44
                                           %46 = OpIAdd %6 %39 %45
                                           OpStore %20 %46
                                           %51 = OpAccessChain %19 %9 %31
                                           %52 = OpLoad %6 %51
                                           %54 = OpAccessChain %19 %9 %53
                                           %55 = OpLoad %6 %54
                                           %57 = OpIMul %6 %55 %56
                                           %58 = OpIAdd %6 %52 %57
                                           %59 = OpLoad %6 %20
                                           
                                           %71 = OpAccessChain %70 %50 %26 %58
                                           OpStore %71 %59
                                           OpReturn
                                           OpFunctionEnd
#version 450
layout(input_attachment_index = 0, binding = 0) uniform usubpassInput inColor0;
layout(input_attachment_index = 1, binding = 1) uniform usubpassInput inColor1;
layout(input_attachment_index = 2, binding = 2) uniform  subpassInput inDepth;
layout(input_attachment_index = 2, binding = 3) uniform usubpassInput inStencil;
layout(set=1, binding=0, std430) writeonly buffer Output
{
  uint v[];
} outBuffer;
void main()
{
  const uvec2 i = uvec2(trunc(gl_FragCoord.xy));
  outBuffer.v[i.x+i.y*16] = uint(subpassLoad(inDepth).x * 1000) + subpassLoad(inStencil).x;
}
#version 450
layout(input_attachment_index = 0, binding = 0) uniform usubpassInput inColor0;
layout(input_attachment_index = 1, binding = 1) uniform usubpassInput inColor1;
layout(input_attachment_index = 20, binding = 2) uniform  subpassInput inDepth;
layout(input_attachment_index = 21, binding = 3) uniform usubpassInput inStencil;
layout(set=1, binding=0, std430) writeonly buffer Output
{
  uint v[];
} outBuffer;
void main()
{
  const uvec2 i = uvec2(trunc(gl_FragCoord.xy));
  outBuffer.v[i.x+i.y*16] = uint(subpassLoad(inDepth).x * 1000) + subpassLoad(inStencil).x;
}
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
#version 450
layout(input_attachment_index = 0, binding = 0) uniform usubpassInput inColor0;
layout(input_attachment_index = 1, binding = 1) uniform usubpassInput inColor1;
layout(input_attachment_index = 2, binding = 2) uniform usubpassInput inColor2;
layout(location = 0) out uint outColor;
void main()
{
  outColor = 1u * subpassLoad(inColor0).x +
             2u * subpassLoad(inColor1).x +
             3u * subpassLoad(inColor2).x;
}
#version 450
layout(input_attachment_index = 0, binding = 0) uniform subpassInput inColor;
layout(location = 0) out vec4 outColor;
void main()
{
  vec2 uvNormalized = gl_FragCoord.xy / vec2(1024);
  vec4 color = subpassLoad(inColor);
  vec4 select = step(vec4(0.5), color);
  color += mix(vec4(0.2), vec4(-0.2), select);
  outColor = color;
}
#version 450
layout(input_attachment_index = 0, binding = 0) uniform subpassInputMS inColor;
layout(location = 0) out vec4 outColor;
void main()
{
  vec2 uvNormalized = gl_FragCoord.xy / vec2(1024);
  vec4 color = subpassLoad(inColor, gl_SampleID);
  vec4 select = step(vec4(0.5), color);
  color += mix(vec4(0.2), vec4(-0.2), select);
  outColor = color;
}
#version 450
layout(set=0, binding=0, std430) readonly buffer Input
{
  uint v[];
} inBuffer;
layout(location = 0) out vec4 outColor;
void main()
{
  uint index = uint(gl_FragCoord.y) * 1024 + uint(gl_FragCoord.x);
  outColor = unpackUnorm4x8(inBuffer.v[index]);
}
