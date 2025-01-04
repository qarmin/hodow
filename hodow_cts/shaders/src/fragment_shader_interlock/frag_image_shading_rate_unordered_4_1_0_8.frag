#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(shading_rate_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 8;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
