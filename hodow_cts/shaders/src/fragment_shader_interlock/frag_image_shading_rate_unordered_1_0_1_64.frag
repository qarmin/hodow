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
  uint stride = 64;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 16 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
