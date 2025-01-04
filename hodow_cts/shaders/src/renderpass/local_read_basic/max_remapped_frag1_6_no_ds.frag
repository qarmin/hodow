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
