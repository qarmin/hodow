#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 64;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
