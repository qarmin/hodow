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
