#version 450 core
layout(location = 0) out int primID;
void main()
{
  primID = gl_InstanceIndex;
  gl_Position = vec4( 2.0*float(gl_VertexIndex&2) - 1.0, 4.0*(gl_VertexIndex&1)-1.0, 1.0 - 2.0 * float(gl_VertexIndex&1), 1);
}
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
  uint stride = 8;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 16;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 32;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 64;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 128;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 512;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 1024;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 8;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 16;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 32;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 64;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 128;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 512;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 1024;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 8;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 16;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 32;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 64;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 128;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 512;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 1024;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 8;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 16;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 32;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 64;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 128;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 256;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 512;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 1024;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 8;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 16;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 32;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 64;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 128;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 256;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 512;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 1024;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
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
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 16;
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
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 32;
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
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 64;
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
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 128;
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
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 256;
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
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 512;
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
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 1024;
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
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 8;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 16;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 32;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
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
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 128;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 256;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 512;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 1024;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
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
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 16;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 32;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 64;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 128;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 256;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 512;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 1024;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 8;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 16;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 32;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 128;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 256;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 512;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 1024;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 16;
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
  uint stride = 32;
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
  uint stride = 128;
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
  uint stride = 256;
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
  uint stride = 512;
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
  uint stride = 1024;
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
  uint stride = 8;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 16;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 32;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 64;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 128;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 256;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 1024;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 8;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 16;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 32;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 64;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 128;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 256;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 1024;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 8;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 16;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 32;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 64;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 128;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 256;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 1024;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 16;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 32;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 128;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 256;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 512;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 1024;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 16;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 32;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 128;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 256;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 512;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 1024;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
}
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
  uint stride = 16;
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
  uint stride = 32;
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
  uint stride = 128;
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
  uint stride = 256;
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
  uint stride = 512;
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
  uint stride = 1024;
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
  uint stride = 8;
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
  uint stride = 16;
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
  uint stride = 32;
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
  uint stride = 64;
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
  uint stride = 128;
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
  uint stride = 512;
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
  uint stride = 1024;
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
  uint stride = 8;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 16;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 32;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 64;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 128;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 512;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 1024;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 8;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 16;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 32;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 64;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 128;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 512;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 1024;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 8;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 16;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 32;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 64;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 128;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
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
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 512;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 1024;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 8;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 16;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 32;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 64;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 128;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 256;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 512;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 1024;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
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
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 16;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 32;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 64;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 128;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 256;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 512;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 1024;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 8;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 16;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 32;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
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
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 128;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 256;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 512;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 1024;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
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
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 16;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 32;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 64;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 128;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 256;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 512;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 1024;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 8;
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
  uint stride = 16;
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
  uint stride = 32;
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
  uint stride = 128;
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
  uint stride = 256;
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
  uint stride = 512;
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
  uint stride = 1024;
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
  uint stride = 8;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 16;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 32;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 128;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 256;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 512;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 1024;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 8;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 16;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 32;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 64;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 128;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 256;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 1024;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 8;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 16;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 32;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 64;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 128;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 256;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 1024;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 8;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 16;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 32;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 64;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 128;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 256;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 1024;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 16;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 32;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 128;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 256;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 512;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 1024;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 16;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 32;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 128;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 256;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 512;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 1024;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 16;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 32;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 128;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 256;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 512;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 1024;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  beginInvocationInterlockARB();
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
}
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
  uint stride = 8;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 2 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 16;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 4 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 32;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 8 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 64;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 16 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 128;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 32 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  if (coordxy.y < 64 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 512;
  uint bitsPerQuad = 1;
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
  uint stride = 1024;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 256 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 8;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 2 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 16;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 4 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 32;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 8 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 64;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 16 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 128;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 32 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 64 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 512;
  uint bitsPerQuad = 4;
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
  uint stride = 1024;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 256 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 8;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 2 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 16;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 4 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 32;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 8 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 64;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 16 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 128;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 32 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 64 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 512;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 128 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 1024;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 256 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 8;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 2 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 16;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 4 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 32;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 8 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 64;
  uint bitsPerQuad = 1;
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
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 128;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 32 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 256;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 64 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 512;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 128 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 1024;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 256 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 8;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 2 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 16;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 4 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 32;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 8 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 64;
  uint bitsPerQuad = 4;
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
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 128;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 32 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 256;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 64 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 512;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 128 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 1024;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 256 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 8;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 2 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 16;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 4 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 32;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 8 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 64;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 16 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 128;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 32 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 256;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 64 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 512;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 128 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 1024;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 256 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 8;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 2 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 16;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 4 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 32;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 8 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 64;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 16 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 128;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 32 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 256;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 64 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 512;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 128 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 1024;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 256 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 8;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 2 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 16;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 4 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 32;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 8 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 64;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 16 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 128;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 32 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 256;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 64 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 512;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 128 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 1024;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 256 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 8;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 2 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 16;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 4 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 32;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 8 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  if (coordxy.y < 16 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 128;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 32 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 256;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 64 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 512;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 128 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 1024;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 256 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 8;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 2 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 16;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 4 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 32;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 8 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 16 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 128;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 32 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 256;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 64 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 512;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 128 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 1024;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 256 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 8;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 2 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 16;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 4 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 32;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 8 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 128;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 32 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 256;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 64 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint bitsPerQuad = 4;
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
  uint stride = 1024;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 256 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 8;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 2 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 16;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 4 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 32;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 8 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 64;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 16 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 128;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 32 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 256;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 64 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 1024;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 256 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 8;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 2 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 16;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 4 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 32;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 8 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 64;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 16 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 128;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 32 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 256;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 64 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 128 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 1024;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 256 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 2 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 16;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 4 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 32;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 8 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 128;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 32 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 256;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 64 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 512;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 128 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 1024;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 256 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 2 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 16;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 4 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 32;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 8 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint bitsPerQuad = 16;
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
  uint stride = 128;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 32 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 256;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 64 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 1024;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 256 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  if (coordxy.y < 2 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 16;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 4 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 32;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 8 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 16 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 128;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 32 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 256;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 64 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 512;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 128 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 1024;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 256 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint temp = imageLoad(image0, coordxy).x;
  temp |= mask;
  imageStore(image0, coordxy, uvec4(temp, 0, 0, 0));
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 8;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 2 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 16;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 4 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 32;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 8 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 64;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 16 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 128;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 32 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  if (coordxy.y < 64 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 512;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 128 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 1024;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 256 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 8;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 2 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 16;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 4 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 32;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 8 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 64;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 16 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 128;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 32 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 64 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 512;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 128 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 1024;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 256 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 8;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 2 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 16;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 4 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 32;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 8 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 64;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 16 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 128;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 32 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 64 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 512;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 128 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 1024;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 256 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 8;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 2 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 16;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 4 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 32;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 8 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 64;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 16 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 128;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 32 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 256;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 64 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 512;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 128 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 1024;
  uint bitsPerQuad = 1;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 256 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 8;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 2 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 16;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 4 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 32;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 8 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 64;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 16 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 128;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 32 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 256;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 64 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 512;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 128 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 1024;
  uint bitsPerQuad = 4;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 256 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 8;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 2 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 16;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 4 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 32;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 8 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 64;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 16 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 128;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 32 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 256;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 64 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 512;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 128 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(pixel_interlock_unordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 1024;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 256 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 8;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 2 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 16;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 4 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 32;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 8 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 64;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 16 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 128;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 32 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 256;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 64 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 512;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 128 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 1024;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 256 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 8;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 2 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 16;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 4 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 32;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 8 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 64;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 16 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 128;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 32 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 256;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 64 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 512;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 128 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
#version 450 core
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_NV_shading_rate_image : enable
layout(r32ui, set = 0, binding = 0) coherent uniform uimage2D image0;
layout(std430, set = 0, binding = 1) coherent buffer B1 { uint x[]; } buf1;
layout(location = 0) flat in int primID;
layout(sample_interlock_ordered) in;
void main()
{
  ivec2 coordxy = ivec2(gl_FragCoord.xy);
  uint stride = 1024;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 256 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 8;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 2 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 16;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 4 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 32;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 8 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  if (coordxy.y < 16 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 128;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 32 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 256;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 64 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 512;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 128 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 1024;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 1 + gl_SampleID;
  stride *= 1;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 256 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 8;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 2 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 16;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 4 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 32;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 8 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 16 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 128;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 32 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 256;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 64 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 512;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 128 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 1024;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 256 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 8;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 2 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 16;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 4 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 32;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 8 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 64;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 16 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 128;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 32 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 256;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 64 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 128 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 1024;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 256 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 8;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 2 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 16;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 4 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 32;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 8 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 64;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 16 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 128;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 32 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 256;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 64 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 1024;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 256 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 8;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 2 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 16;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 4 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 32;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 8 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 64;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 16 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 128;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 32 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 256;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 64 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 128 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 1024;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 256 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  if ((temp & previousMask) == previousMask) temp |= mask; else temp = 0;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 2 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 16;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 4 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 32;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 8 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 128;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 32 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 256;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 64 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 512;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 128 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 1024;
  uint bitsPerQuad = 4;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 256 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 2 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 16;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 4 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 32;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 8 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 16 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 128;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 32 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 256;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 64 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 512;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 128 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 1024;
  uint bitsPerQuad = 16;
  coordxy /= 2;
  stride /= 2;
  uint mask = gl_SampleMaskIn[0] << (primID * bitsPerQuad);
  uint previousMask = (1 << (primID * bitsPerQuad))-1;
  if (coordxy.y < 256 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  if (coordxy.y < 2 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 16;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 4 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 32;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 8 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 16 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 128;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 32 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 256;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 64 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 512;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 128 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
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
  uint stride = 1024;
  uint bitsPerQuad = 1;
  coordxy.x = coordxy.x * 4 + gl_SampleID;
  stride *= 4;
  uint mask = 1 << primID;
  uint previousMask = (1 << primID)-1;
  if (coordxy.y < 256 && (coordxy.x & 1) != 0) discard;
  beginInvocationInterlockARB();
  if ((coordxy.x & 1) != 0) discard;
  uint coord = coordxy.y * stride + coordxy.x;
  uint temp = buf1.x[coord];
  temp |= mask;
  buf1.x[coord] = temp;
  endInvocationInterlockARB();
  discard;
}
