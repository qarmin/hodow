#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 256;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
