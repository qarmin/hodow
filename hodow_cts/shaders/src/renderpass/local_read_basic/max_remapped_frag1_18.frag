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
