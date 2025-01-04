#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(shading_rate_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 512;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 128 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
