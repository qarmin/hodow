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
