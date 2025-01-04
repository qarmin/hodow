#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DMSArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DMSArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DMSArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 16; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 431 + gl_GlobalInvocationID.y) * 151 + gl_GlobalInvocationID.x) * 16 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
   }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DMSArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DMSArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DMSArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 16; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 431 + gl_GlobalInvocationID.y) * 151 + gl_GlobalInvocationID.x) * 16 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
      depthbuf.b[idx] = texelFetch(depthTex, ivec3(gl_GlobalInvocationID.xyz), i).x;
      stencilbuf.b[idx] = texelFetch(stencilTex, ivec3(gl_GlobalInvocationID.xyz), i).x;
   }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DMSArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DMSArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DMSArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 16; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 1 + gl_GlobalInvocationID.y) * 1 + gl_GlobalInvocationID.x) * 16 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
   }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DMSArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DMSArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DMSArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 16; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 1 + gl_GlobalInvocationID.y) * 1 + gl_GlobalInvocationID.x) * 16 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
      depthbuf.b[idx] = texelFetch(depthTex, ivec3(gl_GlobalInvocationID.xyz), i).x;
      stencilbuf.b[idx] = texelFetch(stencilTex, ivec3(gl_GlobalInvocationID.xyz), i).x;
   }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DMSArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DMSArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DMSArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 16; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 256 + gl_GlobalInvocationID.y) * 256 + gl_GlobalInvocationID.x) * 16 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
   }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DMSArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DMSArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DMSArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 16; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 256 + gl_GlobalInvocationID.y) * 256 + gl_GlobalInvocationID.x) * 16 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
      depthbuf.b[idx] = texelFetch(depthTex, ivec3(gl_GlobalInvocationID.xyz), i).x;
      stencilbuf.b[idx] = texelFetch(stencilTex, ivec3(gl_GlobalInvocationID.xyz), i).x;
   }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DMSArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DMSArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DMSArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 16; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 35 + gl_GlobalInvocationID.y) * 33 + gl_GlobalInvocationID.x) * 16 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
   }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DMSArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DMSArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DMSArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 16; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 35 + gl_GlobalInvocationID.y) * 33 + gl_GlobalInvocationID.x) * 16 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
      depthbuf.b[idx] = texelFetch(depthTex, ivec3(gl_GlobalInvocationID.xyz), i).x;
      stencilbuf.b[idx] = texelFetch(stencilTex, ivec3(gl_GlobalInvocationID.xyz), i).x;
   }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DMSArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DMSArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DMSArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 16; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 4 + gl_GlobalInvocationID.y) * 4 + gl_GlobalInvocationID.x) * 16 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
   }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DMSArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DMSArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DMSArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 16; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 4 + gl_GlobalInvocationID.y) * 4 + gl_GlobalInvocationID.x) * 16 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
      depthbuf.b[idx] = texelFetch(depthTex, ivec3(gl_GlobalInvocationID.xyz), i).x;
      stencilbuf.b[idx] = texelFetch(stencilTex, ivec3(gl_GlobalInvocationID.xyz), i).x;
   }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 1; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 431 + gl_GlobalInvocationID.y) * 151 + gl_GlobalInvocationID.x) * 1 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
   }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 1; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 431 + gl_GlobalInvocationID.y) * 151 + gl_GlobalInvocationID.x) * 1 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
      depthbuf.b[idx] = texelFetch(depthTex, ivec3(gl_GlobalInvocationID.xyz), i).x;
      stencilbuf.b[idx] = texelFetch(stencilTex, ivec3(gl_GlobalInvocationID.xyz), i).x;
   }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 1; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 1 + gl_GlobalInvocationID.y) * 1 + gl_GlobalInvocationID.x) * 1 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
   }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 1; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 1 + gl_GlobalInvocationID.y) * 1 + gl_GlobalInvocationID.x) * 1 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
      depthbuf.b[idx] = texelFetch(depthTex, ivec3(gl_GlobalInvocationID.xyz), i).x;
      stencilbuf.b[idx] = texelFetch(stencilTex, ivec3(gl_GlobalInvocationID.xyz), i).x;
   }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 1; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 256 + gl_GlobalInvocationID.y) * 256 + gl_GlobalInvocationID.x) * 1 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
   }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 1; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 256 + gl_GlobalInvocationID.y) * 256 + gl_GlobalInvocationID.x) * 1 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
      depthbuf.b[idx] = texelFetch(depthTex, ivec3(gl_GlobalInvocationID.xyz), i).x;
      stencilbuf.b[idx] = texelFetch(stencilTex, ivec3(gl_GlobalInvocationID.xyz), i).x;
   }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 1; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 35 + gl_GlobalInvocationID.y) * 33 + gl_GlobalInvocationID.x) * 1 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
   }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 1; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 35 + gl_GlobalInvocationID.y) * 33 + gl_GlobalInvocationID.x) * 1 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
      depthbuf.b[idx] = texelFetch(depthTex, ivec3(gl_GlobalInvocationID.xyz), i).x;
      stencilbuf.b[idx] = texelFetch(stencilTex, ivec3(gl_GlobalInvocationID.xyz), i).x;
   }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 1; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 4 + gl_GlobalInvocationID.y) * 4 + gl_GlobalInvocationID.x) * 1 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
   }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 1; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 4 + gl_GlobalInvocationID.y) * 4 + gl_GlobalInvocationID.x) * 1 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
      depthbuf.b[idx] = texelFetch(depthTex, ivec3(gl_GlobalInvocationID.xyz), i).x;
      stencilbuf.b[idx] = texelFetch(stencilTex, ivec3(gl_GlobalInvocationID.xyz), i).x;
   }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DMSArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DMSArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DMSArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 2; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 431 + gl_GlobalInvocationID.y) * 151 + gl_GlobalInvocationID.x) * 2 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
   }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DMSArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DMSArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DMSArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 2; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 431 + gl_GlobalInvocationID.y) * 151 + gl_GlobalInvocationID.x) * 2 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
      depthbuf.b[idx] = texelFetch(depthTex, ivec3(gl_GlobalInvocationID.xyz), i).x;
      stencilbuf.b[idx] = texelFetch(stencilTex, ivec3(gl_GlobalInvocationID.xyz), i).x;
   }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DMSArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DMSArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DMSArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 2; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 1 + gl_GlobalInvocationID.y) * 1 + gl_GlobalInvocationID.x) * 2 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
   }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DMSArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DMSArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DMSArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 2; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 1 + gl_GlobalInvocationID.y) * 1 + gl_GlobalInvocationID.x) * 2 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
      depthbuf.b[idx] = texelFetch(depthTex, ivec3(gl_GlobalInvocationID.xyz), i).x;
      stencilbuf.b[idx] = texelFetch(stencilTex, ivec3(gl_GlobalInvocationID.xyz), i).x;
   }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DMSArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DMSArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DMSArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 2; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 256 + gl_GlobalInvocationID.y) * 256 + gl_GlobalInvocationID.x) * 2 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
   }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DMSArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DMSArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DMSArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 2; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 256 + gl_GlobalInvocationID.y) * 256 + gl_GlobalInvocationID.x) * 2 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
      depthbuf.b[idx] = texelFetch(depthTex, ivec3(gl_GlobalInvocationID.xyz), i).x;
      stencilbuf.b[idx] = texelFetch(stencilTex, ivec3(gl_GlobalInvocationID.xyz), i).x;
   }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DMSArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DMSArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DMSArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 2; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 35 + gl_GlobalInvocationID.y) * 33 + gl_GlobalInvocationID.x) * 2 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
   }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DMSArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DMSArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DMSArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 2; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 35 + gl_GlobalInvocationID.y) * 33 + gl_GlobalInvocationID.x) * 2 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
      depthbuf.b[idx] = texelFetch(depthTex, ivec3(gl_GlobalInvocationID.xyz), i).x;
      stencilbuf.b[idx] = texelFetch(stencilTex, ivec3(gl_GlobalInvocationID.xyz), i).x;
   }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DMSArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DMSArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DMSArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 2; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 4 + gl_GlobalInvocationID.y) * 4 + gl_GlobalInvocationID.x) * 2 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
   }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DMSArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DMSArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DMSArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 2; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 4 + gl_GlobalInvocationID.y) * 4 + gl_GlobalInvocationID.x) * 2 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
      depthbuf.b[idx] = texelFetch(depthTex, ivec3(gl_GlobalInvocationID.xyz), i).x;
      stencilbuf.b[idx] = texelFetch(stencilTex, ivec3(gl_GlobalInvocationID.xyz), i).x;
   }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DMSArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DMSArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DMSArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 4; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 431 + gl_GlobalInvocationID.y) * 151 + gl_GlobalInvocationID.x) * 4 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
   }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DMSArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DMSArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DMSArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 4; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 431 + gl_GlobalInvocationID.y) * 151 + gl_GlobalInvocationID.x) * 4 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
      depthbuf.b[idx] = texelFetch(depthTex, ivec3(gl_GlobalInvocationID.xyz), i).x;
      stencilbuf.b[idx] = texelFetch(stencilTex, ivec3(gl_GlobalInvocationID.xyz), i).x;
   }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DMSArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DMSArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DMSArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 4; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 1 + gl_GlobalInvocationID.y) * 1 + gl_GlobalInvocationID.x) * 4 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
   }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DMSArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DMSArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DMSArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 4; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 1 + gl_GlobalInvocationID.y) * 1 + gl_GlobalInvocationID.x) * 4 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
      depthbuf.b[idx] = texelFetch(depthTex, ivec3(gl_GlobalInvocationID.xyz), i).x;
      stencilbuf.b[idx] = texelFetch(stencilTex, ivec3(gl_GlobalInvocationID.xyz), i).x;
   }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DMSArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DMSArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DMSArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 4; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 256 + gl_GlobalInvocationID.y) * 256 + gl_GlobalInvocationID.x) * 4 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
   }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DMSArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DMSArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DMSArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 4; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 256 + gl_GlobalInvocationID.y) * 256 + gl_GlobalInvocationID.x) * 4 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
      depthbuf.b[idx] = texelFetch(depthTex, ivec3(gl_GlobalInvocationID.xyz), i).x;
      stencilbuf.b[idx] = texelFetch(stencilTex, ivec3(gl_GlobalInvocationID.xyz), i).x;
   }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DMSArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DMSArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DMSArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 4; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 33 + gl_GlobalInvocationID.y) * 32 + gl_GlobalInvocationID.x) * 4 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
   }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DMSArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DMSArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DMSArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 4; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 35 + gl_GlobalInvocationID.y) * 33 + gl_GlobalInvocationID.x) * 4 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
   }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DMSArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DMSArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DMSArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 4; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 35 + gl_GlobalInvocationID.y) * 33 + gl_GlobalInvocationID.x) * 4 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
      depthbuf.b[idx] = texelFetch(depthTex, ivec3(gl_GlobalInvocationID.xyz), i).x;
      stencilbuf.b[idx] = texelFetch(stencilTex, ivec3(gl_GlobalInvocationID.xyz), i).x;
   }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DMSArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DMSArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DMSArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 4; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 4 + gl_GlobalInvocationID.y) * 4 + gl_GlobalInvocationID.x) * 4 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
   }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DMSArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DMSArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DMSArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 4; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 4 + gl_GlobalInvocationID.y) * 4 + gl_GlobalInvocationID.x) * 4 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
      depthbuf.b[idx] = texelFetch(depthTex, ivec3(gl_GlobalInvocationID.xyz), i).x;
      stencilbuf.b[idx] = texelFetch(stencilTex, ivec3(gl_GlobalInvocationID.xyz), i).x;
   }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DMSArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DMSArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DMSArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 8; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 431 + gl_GlobalInvocationID.y) * 151 + gl_GlobalInvocationID.x) * 8 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
   }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DMSArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DMSArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DMSArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 8; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 431 + gl_GlobalInvocationID.y) * 151 + gl_GlobalInvocationID.x) * 8 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
      depthbuf.b[idx] = texelFetch(depthTex, ivec3(gl_GlobalInvocationID.xyz), i).x;
      stencilbuf.b[idx] = texelFetch(stencilTex, ivec3(gl_GlobalInvocationID.xyz), i).x;
   }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DMSArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DMSArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DMSArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 8; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 1 + gl_GlobalInvocationID.y) * 1 + gl_GlobalInvocationID.x) * 8 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
   }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DMSArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DMSArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DMSArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 8; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 1 + gl_GlobalInvocationID.y) * 1 + gl_GlobalInvocationID.x) * 8 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
      depthbuf.b[idx] = texelFetch(depthTex, ivec3(gl_GlobalInvocationID.xyz), i).x;
      stencilbuf.b[idx] = texelFetch(stencilTex, ivec3(gl_GlobalInvocationID.xyz), i).x;
   }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DMSArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DMSArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DMSArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 8; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 256 + gl_GlobalInvocationID.y) * 256 + gl_GlobalInvocationID.x) * 8 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
   }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DMSArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DMSArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DMSArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 8; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 256 + gl_GlobalInvocationID.y) * 256 + gl_GlobalInvocationID.x) * 8 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
      depthbuf.b[idx] = texelFetch(depthTex, ivec3(gl_GlobalInvocationID.xyz), i).x;
      stencilbuf.b[idx] = texelFetch(stencilTex, ivec3(gl_GlobalInvocationID.xyz), i).x;
   }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DMSArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DMSArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DMSArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 8; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 35 + gl_GlobalInvocationID.y) * 33 + gl_GlobalInvocationID.x) * 8 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
   }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DMSArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DMSArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DMSArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 8; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 35 + gl_GlobalInvocationID.y) * 33 + gl_GlobalInvocationID.x) * 8 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
      depthbuf.b[idx] = texelFetch(depthTex, ivec3(gl_GlobalInvocationID.xyz), i).x;
      stencilbuf.b[idx] = texelFetch(stencilTex, ivec3(gl_GlobalInvocationID.xyz), i).x;
   }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DMSArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DMSArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DMSArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 8; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 4 + gl_GlobalInvocationID.y) * 4 + gl_GlobalInvocationID.x) * 8 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
   }
}
#version 450 core
#extension GL_EXT_samplerless_texture_functions : enable
layout(set = 0, binding = 1) uniform utexture2DMSArray colorTex;
layout(set = 0, binding = 2, std430) buffer Block0 { uvec4 b[]; } colorbuf;
layout(set = 0, binding = 4, std430) buffer Block1 { float b[]; } depthbuf;
layout(set = 0, binding = 5, std430) buffer Block2 { uint b[]; } stencilbuf;
layout(set = 0, binding = 6) uniform texture2DMSArray depthTex;
layout(set = 0, binding = 7) uniform utexture2DMSArray stencilTex;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main()
{
   for (int i = 0; i < 8; ++i) {
      uint idx = ((gl_GlobalInvocationID.z * 4 + gl_GlobalInvocationID.y) * 4 + gl_GlobalInvocationID.x) * 8 + i;
      colorbuf.b[idx] = texelFetch(colorTex, ivec3(gl_GlobalInvocationID.xyz), i);
      depthbuf.b[idx] = texelFetch(depthTex, ivec3(gl_GlobalInvocationID.xyz), i).x;
      stencilbuf.b[idx] = texelFetch(stencilTex, ivec3(gl_GlobalInvocationID.xyz), i).x;
   }
}
#version 450 core
#extension GL_EXT_fragment_shading_rate : enable
#extension GL_ARB_shader_stencil_export : enable
#extension GL_ARB_fragment_shader_interlock : enable
layout(location = 0) out uvec4 col0;
layout(set = 0, binding = 0) buffer Block { uint counter; } buf;
layout(set = 0, binding = 3) uniform usampler2D tex;
layout(location = 0) flat in int instanceIndex;
layout(location = 1) flat in int readbackok;
layout(location = 2) in float zero;
void main()
{
  col0.x = gl_ShadingRateEXT;
  col0.y = 0;
  col0.z = (instanceIndex << 24) | ((atomicAdd(buf.counter, 1) + 1) & 0x00FFFFFFu);
  ivec2 fragCoordXY = ivec2(gl_FragCoord.xy);
  ivec2 fragSize = ivec2(1<<((gl_ShadingRateEXT/4)&3), 1<<(gl_ShadingRateEXT&3));
  col0.w = uint(zero);
  if (((fragCoordXY - fragSize / 2) % fragSize) != ivec2(0,0))
    col0.w = 1;
  if (dFdx(gl_FragCoord.xy) != ivec2(fragSize.x, 0) || dFdy(gl_FragCoord.xy) != ivec2(0, fragSize.y))
    col0.w = (fragSize.y << 26) | (fragSize.x << 20) | (int(dFdx(gl_FragCoord.xy)) << 14) | (int(dFdx(gl_FragCoord.xy)) << 8) | 3;
  uint implicitDerivX = texture(tex, vec2(gl_FragCoord.x / textureSize(tex, 0).x, 0)).x;
  uint implicitDerivY = texture(tex, vec2(0, gl_FragCoord.y / textureSize(tex, 0).y)).x;
  if (implicitDerivX != fragSize.x || implicitDerivY != fragSize.y)
    col0.w = (fragSize.y << 26) | (fragSize.x << 20) | (implicitDerivY << 14) | (implicitDerivX << 8) | 4;
}
#version 450 core
#extension GL_EXT_fragment_shading_rate : enable
#extension GL_ARB_shader_stencil_export : enable
#extension GL_ARB_fragment_shader_interlock : enable
layout(location = 0) out uvec4 col0;
layout(set = 0, binding = 0) buffer Block { uint counter; } buf;
layout(set = 0, binding = 3) uniform usampler2D tex;
layout(location = 0) flat in int instanceIndex;
layout(location = 1) flat in int readbackok;
layout(location = 2) in float zero;
void main()
{
  col0.x = gl_ShadingRateEXT;
  col0.y = 0;
  col0.z = (instanceIndex << 24) | ((atomicAdd(buf.counter, 1) + 1) & 0x00FFFFFFu);
  ivec2 fragCoordXY = ivec2(gl_FragCoord.xy);
  ivec2 fragSize = ivec2(1<<((gl_ShadingRateEXT/4)&3), 1<<(gl_ShadingRateEXT&3));
  col0.w = uint(zero);
  if (((fragCoordXY - fragSize / 2) % fragSize) != ivec2(0,0))
    col0.w = 1;
  if (dFdx(gl_FragCoord.xy) != ivec2(fragSize.x, 0) || dFdy(gl_FragCoord.xy) != ivec2(0, fragSize.y))
    col0.w = (fragSize.y << 26) | (fragSize.x << 20) | (int(dFdx(gl_FragCoord.xy)) << 14) | (int(dFdx(gl_FragCoord.xy)) << 8) | 3;
  uint implicitDerivX = texture(tex, vec2(gl_FragCoord.x / textureSize(tex, 0).x, 0)).x;
  uint implicitDerivY = texture(tex, vec2(0, gl_FragCoord.y / textureSize(tex, 0).y)).x;
  if (implicitDerivX != fragSize.x || implicitDerivY != fragSize.y)
    col0.w = (fragSize.y << 26) | (fragSize.x << 20) | (implicitDerivY << 14) | (implicitDerivX << 8) | 4;
  col0.y = (gl_SampleMaskIn[0]);
}
#version 450 core
#extension GL_EXT_fragment_shading_rate : enable
#extension GL_ARB_shader_stencil_export : enable
#extension GL_ARB_fragment_shader_interlock : enable
layout(location = 0) out uvec4 col0;
layout(set = 0, binding = 0) buffer Block { uint counter; } buf;
layout(set = 0, binding = 3) uniform usampler2D tex;
layout(location = 0) flat in int instanceIndex;
layout(location = 1) flat in int readbackok;
layout(location = 2) in float zero;
void main()
{
  col0.x = gl_ShadingRateEXT;
  col0.y = 0;
  col0.z = (instanceIndex << 24) | ((atomicAdd(buf.counter, 1) + 1) & 0x00FFFFFFu);
  ivec2 fragCoordXY = ivec2(gl_FragCoord.xy);
  ivec2 fragSize = ivec2(1<<((gl_ShadingRateEXT/4)&3), 1<<(gl_ShadingRateEXT&3));
  col0.w = uint(zero);
  if (((fragCoordXY - fragSize / 2) % fragSize) != ivec2(0,0))
    col0.w = 1;
  if (dFdx(gl_FragCoord.xy) != ivec2(fragSize.x, 0) || dFdy(gl_FragCoord.xy) != ivec2(0, fragSize.y))
    col0.w = (fragSize.y << 26) | (fragSize.x << 20) | (int(dFdx(gl_FragCoord.xy)) << 14) | (int(dFdx(gl_FragCoord.xy)) << 8) | 3;
  uint implicitDerivX = texture(tex, vec2(gl_FragCoord.x / textureSize(tex, 0).x, 0)).x;
  uint implicitDerivY = texture(tex, vec2(0, gl_FragCoord.y / textureSize(tex, 0).y)).x;
  if (implicitDerivX != fragSize.x || implicitDerivY != fragSize.y)
    col0.w = (fragSize.y << 26) | (fragSize.x << 20) | (implicitDerivY << 14) | (implicitDerivX << 8) | 4;
  gl_SampleMask[0] = 0x55555555;
  col0.y = (gl_SampleMaskIn[0] & 0x55555555);
}
#version 450 core
#extension GL_EXT_fragment_shading_rate : enable
#extension GL_ARB_shader_stencil_export : enable
#extension GL_ARB_fragment_shader_interlock : enable
layout(location = 0) out uvec4 col0;
layout(set = 0, binding = 0) buffer Block { uint counter; } buf;
layout(set = 0, binding = 3) uniform usampler2D tex;
layout(location = 0) flat in int instanceIndex;
layout(location = 1) flat in int readbackok;
layout(location = 2) in float zero;
void main()
{
  col0.x = gl_ShadingRateEXT;
  col0.y = 0;
  col0.z = (instanceIndex << 24) | ((atomicAdd(buf.counter, 1) + 1) & 0x00FFFFFFu);
  ivec2 fragCoordXY = ivec2(gl_FragCoord.xy);
  ivec2 fragSize = ivec2(1<<((gl_ShadingRateEXT/4)&3), 1<<(gl_ShadingRateEXT&3));
  col0.w = uint(zero);
  if (((fragCoordXY - fragSize / 2) % fragSize) != ivec2(0,0))
    col0.w = 1;
}
#version 450 core
#extension GL_EXT_fragment_shading_rate : enable
#extension GL_ARB_shader_stencil_export : enable
#extension GL_ARB_fragment_shader_interlock : enable
layout(location = 0) out uvec4 col0;
layout(set = 0, binding = 0) buffer Block { uint counter; } buf;
layout(set = 0, binding = 3) uniform usampler2D tex;
layout(location = 0) flat in int instanceIndex;
layout(location = 1) flat in int readbackok;
layout(location = 2) sample in float zero;
void main()
{
  col0.x = gl_ShadingRateEXT;
  col0.y = 0;
  col0.z = (instanceIndex << 24) | ((atomicAdd(buf.counter, 1) + 1) & 0x00FFFFFFu);
  ivec2 fragCoordXY = ivec2(gl_FragCoord.xy);
  ivec2 fragSize = ivec2(1<<((gl_ShadingRateEXT/4)&3), 1<<(gl_ShadingRateEXT&3));
  col0.w = uint(zero) * gl_SampleID;
  if (((fragCoordXY - fragSize / 2) % fragSize) != ivec2(0,0))
    col0.w = 1;
}
#version 450 core
#extension GL_EXT_fragment_shading_rate : enable
#extension GL_ARB_shader_stencil_export : enable
#extension GL_ARB_fragment_shader_interlock : enable
layout(location = 0) out uvec4 col0;
layout(set = 0, binding = 0) buffer Block { uint counter; } buf;
layout(set = 0, binding = 3) uniform usampler2D tex;
layout(location = 0) flat in int instanceIndex;
layout(location = 1) flat in int readbackok;
layout(location = 2) in float zero;
layout(pixel_interlock_ordered) in;
void main()
{
  beginInvocationInterlockARB();
  col0.x = gl_ShadingRateEXT;
  col0.y = 0;
  col0.z = (instanceIndex << 24) | ((atomicAdd(buf.counter, 1) + 1) & 0x00FFFFFFu);
  ivec2 fragCoordXY = ivec2(gl_FragCoord.xy);
  ivec2 fragSize = ivec2(1<<((gl_ShadingRateEXT/4)&3), 1<<(gl_ShadingRateEXT&3));
  col0.w = uint(zero);
  if (((fragCoordXY - fragSize / 2) % fragSize) != ivec2(0,0))
    col0.w = 1;
  if (dFdx(gl_FragCoord.xy) != ivec2(fragSize.x, 0) || dFdy(gl_FragCoord.xy) != ivec2(0, fragSize.y))
    col0.w = (fragSize.y << 26) | (fragSize.x << 20) | (int(dFdx(gl_FragCoord.xy)) << 14) | (int(dFdx(gl_FragCoord.xy)) << 8) | 3;
  uint implicitDerivX = texture(tex, vec2(gl_FragCoord.x / textureSize(tex, 0).x, 0)).x;
  uint implicitDerivY = texture(tex, vec2(0, gl_FragCoord.y / textureSize(tex, 0).y)).x;
  if (implicitDerivX != fragSize.x || implicitDerivY != fragSize.y)
    col0.w = (fragSize.y << 26) | (fragSize.x << 20) | (implicitDerivY << 14) | (implicitDerivX << 8) | 4;
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_EXT_fragment_shading_rate : enable
#extension GL_ARB_shader_stencil_export : enable
#extension GL_ARB_fragment_shader_interlock : enable
layout(location = 0) out uvec4 col0;
layout(set = 0, binding = 0) buffer Block { uint counter; } buf;
layout(set = 0, binding = 3) uniform usampler2D tex;
layout(location = 0) flat in int instanceIndex;
layout(location = 1) flat in int readbackok;
layout(location = 2) in float zero;
void main()
{
  col0.x = gl_ShadingRateEXT;
  col0.y = 0;
  col0.z = (instanceIndex << 24) | ((atomicAdd(buf.counter, 1) + 1) & 0x00FFFFFFu);
  ivec2 fragCoordXY = ivec2(gl_FragCoord.xy);
  ivec2 fragSize = ivec2(1<<((gl_ShadingRateEXT/4)&3), 1<<(gl_ShadingRateEXT&3));
  col0.w = uint(zero);
  if (((fragCoordXY - fragSize / 2) % fragSize) != ivec2(0,0))
    col0.w = 1;
  if (dFdx(gl_FragCoord.xy) != ivec2(fragSize.x, 0) || dFdy(gl_FragCoord.xy) != ivec2(0, fragSize.y))
    col0.w = (fragSize.y << 26) | (fragSize.x << 20) | (int(dFdx(gl_FragCoord.xy)) << 14) | (int(dFdx(gl_FragCoord.xy)) << 8) | 3;
  uint implicitDerivX = texture(tex, vec2(gl_FragCoord.x / textureSize(tex, 0).x, 0)).x;
  uint implicitDerivY = texture(tex, vec2(0, gl_FragCoord.y / textureSize(tex, 0).y)).x;
  if (implicitDerivX != fragSize.x || implicitDerivY != fragSize.y)
    col0.w = (fragSize.y << 26) | (fragSize.x << 20) | (implicitDerivY << 14) | (implicitDerivX << 8) | 4;
  gl_FragStencilRefARB = instanceIndex;
}
#version 450 core
#extension GL_EXT_fragment_shading_rate : enable
#extension GL_ARB_shader_stencil_export : enable
#extension GL_ARB_fragment_shader_interlock : enable
layout(location = 0) out uvec4 col0;
layout(set = 0, binding = 0) buffer Block { uint counter; } buf;
layout(set = 0, binding = 3) uniform usampler2D tex;
layout(location = 0) flat in int instanceIndex;
layout(location = 1) flat in int readbackok;
layout(location = 2) in float zero;
void main()
{
  col0.x = gl_ShadingRateEXT;
  col0.y = 0;
  col0.z = (instanceIndex << 24) | ((atomicAdd(buf.counter, 1) + 1) & 0x00FFFFFFu);
  ivec2 fragCoordXY = ivec2(gl_FragCoord.xy);
  ivec2 fragSize = ivec2(1<<((gl_ShadingRateEXT/4)&3), 1<<(gl_ShadingRateEXT&3));
  col0.w = uint(zero);
  if (((fragCoordXY - fragSize / 2) % fragSize) != ivec2(0,0))
    col0.w = 1;
  if (dFdx(gl_FragCoord.xy) != ivec2(fragSize.x, 0) || dFdy(gl_FragCoord.xy) != ivec2(0, fragSize.y))
    col0.w = (fragSize.y << 26) | (fragSize.x << 20) | (int(dFdx(gl_FragCoord.xy)) << 14) | (int(dFdx(gl_FragCoord.xy)) << 8) | 3;
  uint implicitDerivX = texture(tex, vec2(gl_FragCoord.x / textureSize(tex, 0).x, 0)).x;
  uint implicitDerivY = texture(tex, vec2(0, gl_FragCoord.y / textureSize(tex, 0).y)).x;
  if (implicitDerivX != fragSize.x || implicitDerivY != fragSize.y)
    col0.w = (fragSize.y << 26) | (fragSize.x << 20) | (implicitDerivY << 14) | (implicitDerivX << 8) | 4;
  gl_FragDepth = float(instanceIndex) / float(81);
}
#version 450 core
#extension GL_EXT_fragment_shading_rate : enable
#extension GL_ARB_shader_stencil_export : enable
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_AMD_shader_early_and_late_fragment_tests : enable
layout(location = 0) out uvec4 col0;
layout(set = 0, binding = 0) buffer Block { uint counter; } buf;
layout(set = 0, binding = 3) uniform usampler2D tex;
layout(location = 0) flat in int instanceIndex;
layout(location = 1) flat in int readbackok;
layout(location = 2) in float zero;
layout(early_and_late_fragment_tests_amd) in;
layout(stencil_ref_less_front_amd) out int gl_FragStencilRefARB;
void main()
{
  col0.x = gl_ShadingRateEXT;
  col0.y = 0;
  col0.z = (instanceIndex << 24) | ((atomicAdd(buf.counter, 1) + 1) & 0x00FFFFFFu);
  ivec2 fragCoordXY = ivec2(gl_FragCoord.xy);
  ivec2 fragSize = ivec2(1<<((gl_ShadingRateEXT/4)&3), 1<<(gl_ShadingRateEXT&3));
  col0.w = uint(zero);
  if (((fragCoordXY - fragSize / 2) % fragSize) != ivec2(0,0))
    col0.w = 1;
  if (dFdx(gl_FragCoord.xy) != ivec2(fragSize.x, 0) || dFdy(gl_FragCoord.xy) != ivec2(0, fragSize.y))
    col0.w = (fragSize.y << 26) | (fragSize.x << 20) | (int(dFdx(gl_FragCoord.xy)) << 14) | (int(dFdx(gl_FragCoord.xy)) << 8) | 3;
  uint implicitDerivX = texture(tex, vec2(gl_FragCoord.x / textureSize(tex, 0).x, 0)).x;
  uint implicitDerivY = texture(tex, vec2(0, gl_FragCoord.y / textureSize(tex, 0).y)).x;
  if (implicitDerivX != fragSize.x || implicitDerivY != fragSize.y)
    col0.w = (fragSize.y << 26) | (fragSize.x << 20) | (implicitDerivY << 14) | (implicitDerivX << 8) | 4;
  gl_FragStencilRefARB = instanceIndex;
}
#version 450 core
#extension GL_EXT_fragment_shading_rate : enable
#extension GL_ARB_shader_stencil_export : enable
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_AMD_shader_early_and_late_fragment_tests : enable
layout(location = 0) out uvec4 col0;
layout(set = 0, binding = 0) buffer Block { uint counter; } buf;
layout(set = 0, binding = 3) uniform usampler2D tex;
layout(location = 0) flat in int instanceIndex;
layout(location = 1) flat in int readbackok;
layout(location = 2) in float zero;
layout(early_and_late_fragment_tests_amd) in;
layout(depth_less) out float gl_FragDepth;
void main()
{
  col0.x = gl_ShadingRateEXT;
  col0.y = 0;
  col0.z = (instanceIndex << 24) | ((atomicAdd(buf.counter, 1) + 1) & 0x00FFFFFFu);
  ivec2 fragCoordXY = ivec2(gl_FragCoord.xy);
  ivec2 fragSize = ivec2(1<<((gl_ShadingRateEXT/4)&3), 1<<(gl_ShadingRateEXT&3));
  col0.w = uint(zero);
  if (((fragCoordXY - fragSize / 2) % fragSize) != ivec2(0,0))
    col0.w = 1;
  if (dFdx(gl_FragCoord.xy) != ivec2(fragSize.x, 0) || dFdy(gl_FragCoord.xy) != ivec2(0, fragSize.y))
    col0.w = (fragSize.y << 26) | (fragSize.x << 20) | (int(dFdx(gl_FragCoord.xy)) << 14) | (int(dFdx(gl_FragCoord.xy)) << 8) | 3;
  uint implicitDerivX = texture(tex, vec2(gl_FragCoord.x / textureSize(tex, 0).x, 0)).x;
  uint implicitDerivY = texture(tex, vec2(0, gl_FragCoord.y / textureSize(tex, 0).y)).x;
  if (implicitDerivX != fragSize.x || implicitDerivY != fragSize.y)
    col0.w = (fragSize.y << 26) | (fragSize.x << 20) | (implicitDerivY << 14) | (implicitDerivX << 8) | 4;
  gl_FragDepth = float(instanceIndex) / float(81);
}
#version 450 core
#extension GL_EXT_fragment_shading_rate : enable
#extension GL_ARB_shader_stencil_export : enable
#extension GL_ARB_fragment_shader_interlock : enable
layout(location = 0) out uvec4 col0;
layout(set = 0, binding = 0) buffer Block { uint counter; } buf;
layout(set = 0, binding = 3) uniform usampler2D tex;
layout(location = 0) flat in int instanceIndex;
layout(location = 1) flat in int readbackok;
layout(location = 2) in float zero;
void main()
{
  col0.x = gl_ShadingRateEXT;
  col0.y = 0;
  col0.z = (instanceIndex << 24) | ((atomicAdd(buf.counter, 1) + 1) & 0x00FFFFFFu);
  ivec2 fragCoordXY = ivec2(gl_FragCoord.xy);
  ivec2 fragSize = ivec2(1<<((gl_ShadingRateEXT/4)&3), 1<<(gl_ShadingRateEXT&3));
  col0.w = uint(zero);
  if (((fragCoordXY - fragSize / 2) % fragSize) != ivec2(0,0))
    col0.w = 1;
  if (readbackok != 1)
    col0.w = 2;
  if (dFdx(gl_FragCoord.xy) != ivec2(fragSize.x, 0) || dFdy(gl_FragCoord.xy) != ivec2(0, fragSize.y))
    col0.w = (fragSize.y << 26) | (fragSize.x << 20) | (int(dFdx(gl_FragCoord.xy)) << 14) | (int(dFdx(gl_FragCoord.xy)) << 8) | 3;
  uint implicitDerivX = texture(tex, vec2(gl_FragCoord.x / textureSize(tex, 0).x, 0)).x;
  uint implicitDerivY = texture(tex, vec2(0, gl_FragCoord.y / textureSize(tex, 0).y)).x;
  if (implicitDerivX != fragSize.x || implicitDerivY != fragSize.y)
    col0.w = (fragSize.y << 26) | (fragSize.x << 20) | (implicitDerivY << 14) | (implicitDerivX << 8) | 4;
}
#version 450 core
#extension GL_EXT_fragment_shading_rate : enable
#extension GL_ARB_shader_stencil_export : enable
#extension GL_ARB_fragment_shader_interlock : enable
layout(location = 0) out uvec4 col0;
layout(set = 0, binding = 0) buffer Block { uint counter; } buf;
layout(set = 0, binding = 3) uniform usampler2D tex;
layout(location = 0) flat in int instanceIndex;
layout(location = 1) flat in int readbackok;
layout(location = 2) in float zero;
void main()
{
  col0.x = gl_ShadingRateEXT;
  col0.y = 0;
  col0.z = (instanceIndex << 24) | ((atomicAdd(buf.counter, 1) + 1) & 0x00FFFFFFu);
  ivec2 fragCoordXY = ivec2(gl_FragCoord.xy);
  ivec2 fragSize = ivec2(1<<((gl_ShadingRateEXT/4)&3), 1<<(gl_ShadingRateEXT&3));
  col0.w = uint(zero);
  if (((fragCoordXY - fragSize / 2) % fragSize) != ivec2(0,0))
    col0.w = 1;
  if (readbackok != 1)
    col0.w = 2;
  if (dFdx(gl_FragCoord.xy) != ivec2(fragSize.x, 0) || dFdy(gl_FragCoord.xy) != ivec2(0, fragSize.y))
    col0.w = (fragSize.y << 26) | (fragSize.x << 20) | (int(dFdx(gl_FragCoord.xy)) << 14) | (int(dFdx(gl_FragCoord.xy)) << 8) | 3;
  uint implicitDerivX = texture(tex, vec2(gl_FragCoord.x / textureSize(tex, 0).x, 0)).x;
  uint implicitDerivY = texture(tex, vec2(0, gl_FragCoord.y / textureSize(tex, 0).y)).x;
  if (implicitDerivX != fragSize.x || implicitDerivY != fragSize.y)
    col0.w = (fragSize.y << 26) | (fragSize.x << 20) | (implicitDerivY << 14) | (implicitDerivX << 8) | 4;
  col0.y = (gl_SampleMaskIn[0]);
}
#version 450 core
#extension GL_EXT_fragment_shading_rate : enable
#extension GL_ARB_shader_stencil_export : enable
#extension GL_ARB_fragment_shader_interlock : enable
layout(location = 0) out uvec4 col0;
layout(set = 0, binding = 0) buffer Block { uint counter; } buf;
layout(set = 0, binding = 3) uniform usampler2D tex;
layout(location = 0) flat in int instanceIndex;
layout(location = 1) flat in int readbackok;
layout(location = 2) in float zero;
void main()
{
  col0.x = gl_ShadingRateEXT;
  col0.y = 0;
  col0.z = (instanceIndex << 24) | ((atomicAdd(buf.counter, 1) + 1) & 0x00FFFFFFu);
  ivec2 fragCoordXY = ivec2(gl_FragCoord.xy);
  ivec2 fragSize = ivec2(1<<((gl_ShadingRateEXT/4)&3), 1<<(gl_ShadingRateEXT&3));
  col0.w = uint(zero);
  if (((fragCoordXY - fragSize / 2) % fragSize) != ivec2(0,0))
    col0.w = 1;
  if (readbackok != 1)
    col0.w = 2;
  if (dFdx(gl_FragCoord.xy) != ivec2(fragSize.x, 0) || dFdy(gl_FragCoord.xy) != ivec2(0, fragSize.y))
    col0.w = (fragSize.y << 26) | (fragSize.x << 20) | (int(dFdx(gl_FragCoord.xy)) << 14) | (int(dFdx(gl_FragCoord.xy)) << 8) | 3;
  uint implicitDerivX = texture(tex, vec2(gl_FragCoord.x / textureSize(tex, 0).x, 0)).x;
  uint implicitDerivY = texture(tex, vec2(0, gl_FragCoord.y / textureSize(tex, 0).y)).x;
  if (implicitDerivX != fragSize.x || implicitDerivY != fragSize.y)
    col0.w = (fragSize.y << 26) | (fragSize.x << 20) | (implicitDerivY << 14) | (implicitDerivX << 8) | 4;
  gl_SampleMask[0] = 0x55555555;
  col0.y = (gl_SampleMaskIn[0] & 0x55555555);
}
#version 450 core
#extension GL_EXT_fragment_shading_rate : enable
#extension GL_ARB_shader_stencil_export : enable
#extension GL_ARB_fragment_shader_interlock : enable
layout(location = 0) out uvec4 col0;
layout(set = 0, binding = 0) buffer Block { uint counter; } buf;
layout(set = 0, binding = 3) uniform usampler2D tex;
layout(location = 0) flat in int instanceIndex;
layout(location = 1) flat in int readbackok;
layout(location = 2) in float zero;
void main()
{
  col0.x = gl_ShadingRateEXT;
  col0.y = 0;
  col0.z = (instanceIndex << 24) | ((atomicAdd(buf.counter, 1) + 1) & 0x00FFFFFFu);
  ivec2 fragCoordXY = ivec2(gl_FragCoord.xy);
  ivec2 fragSize = ivec2(1<<((gl_ShadingRateEXT/4)&3), 1<<(gl_ShadingRateEXT&3));
  col0.w = uint(zero);
  if (((fragCoordXY - fragSize / 2) % fragSize) != ivec2(0,0))
    col0.w = 1;
  if (readbackok != 1)
    col0.w = 2;
}
#version 450 core
#extension GL_EXT_fragment_shading_rate : enable
#extension GL_ARB_shader_stencil_export : enable
#extension GL_ARB_fragment_shader_interlock : enable
layout(location = 0) out uvec4 col0;
layout(set = 0, binding = 0) buffer Block { uint counter; } buf;
layout(set = 0, binding = 3) uniform usampler2D tex;
layout(location = 0) flat in int instanceIndex;
layout(location = 1) flat in int readbackok;
layout(location = 2) sample in float zero;
void main()
{
  col0.x = gl_ShadingRateEXT;
  col0.y = 0;
  col0.z = (instanceIndex << 24) | ((atomicAdd(buf.counter, 1) + 1) & 0x00FFFFFFu);
  ivec2 fragCoordXY = ivec2(gl_FragCoord.xy);
  ivec2 fragSize = ivec2(1<<((gl_ShadingRateEXT/4)&3), 1<<(gl_ShadingRateEXT&3));
  col0.w = uint(zero) * gl_SampleID;
  if (((fragCoordXY - fragSize / 2) % fragSize) != ivec2(0,0))
    col0.w = 1;
  if (readbackok != 1)
    col0.w = 2;
}
#version 450 core
#extension GL_EXT_fragment_shading_rate : enable
#extension GL_ARB_shader_stencil_export : enable
#extension GL_ARB_fragment_shader_interlock : enable
layout(location = 0) out uvec4 col0;
layout(set = 0, binding = 0) buffer Block { uint counter; } buf;
layout(set = 0, binding = 3) uniform usampler2D tex;
layout(location = 0) flat in int instanceIndex;
layout(location = 1) flat in int readbackok;
layout(location = 2) in float zero;
void main()
{
  col0.x = gl_ShadingRateEXT;
  col0.y = uint(gl_HelperInvocation);
  col0.z = (instanceIndex << 24) | ((atomicAdd(buf.counter, 1) + 1) & 0x00FFFFFFu);
  ivec2 fragCoordXY = ivec2(gl_FragCoord.xy);
  ivec2 fragSize = ivec2(1<<((gl_ShadingRateEXT/4)&3), 1<<(gl_ShadingRateEXT&3));
  col0.w = uint(zero);
  if (((fragCoordXY - fragSize / 2) % fragSize) != ivec2(0,0))
    col0.w = 1;
  if (readbackok != 1)
    col0.w = 2;
  if (dFdx(gl_FragCoord.xy) != ivec2(fragSize.x, 0) || dFdy(gl_FragCoord.xy) != ivec2(0, fragSize.y))
    col0.w = (fragSize.y << 26) | (fragSize.x << 20) | (int(dFdx(gl_FragCoord.xy)) << 14) | (int(dFdx(gl_FragCoord.xy)) << 8) | 3;
  uint implicitDerivX = texture(tex, vec2(gl_FragCoord.x / textureSize(tex, 0).x, 0)).x;
  uint implicitDerivY = texture(tex, vec2(0, gl_FragCoord.y / textureSize(tex, 0).y)).x;
  if (implicitDerivX != fragSize.x || implicitDerivY != fragSize.y)
    col0.w = (fragSize.y << 26) | (fragSize.x << 20) | (implicitDerivY << 14) | (implicitDerivX << 8) | 4;
}
#version 450 core
#extension GL_EXT_fragment_shading_rate : enable
#extension GL_ARB_shader_stencil_export : enable
#extension GL_ARB_fragment_shader_interlock : enable
layout(location = 0) out uvec4 col0;
layout(set = 0, binding = 0) buffer Block { uint counter; } buf;
layout(set = 0, binding = 3) uniform usampler2D tex;
layout(location = 0) flat in int instanceIndex;
layout(location = 1) flat in int readbackok;
layout(location = 2) in float zero;
layout(pixel_interlock_ordered) in;
void main()
{
  beginInvocationInterlockARB();
  col0.x = gl_ShadingRateEXT;
  col0.y = 0;
  col0.z = (instanceIndex << 24) | ((atomicAdd(buf.counter, 1) + 1) & 0x00FFFFFFu);
  ivec2 fragCoordXY = ivec2(gl_FragCoord.xy);
  ivec2 fragSize = ivec2(1<<((gl_ShadingRateEXT/4)&3), 1<<(gl_ShadingRateEXT&3));
  col0.w = uint(zero);
  if (((fragCoordXY - fragSize / 2) % fragSize) != ivec2(0,0))
    col0.w = 1;
  if (readbackok != 1)
    col0.w = 2;
  if (dFdx(gl_FragCoord.xy) != ivec2(fragSize.x, 0) || dFdy(gl_FragCoord.xy) != ivec2(0, fragSize.y))
    col0.w = (fragSize.y << 26) | (fragSize.x << 20) | (int(dFdx(gl_FragCoord.xy)) << 14) | (int(dFdx(gl_FragCoord.xy)) << 8) | 3;
  uint implicitDerivX = texture(tex, vec2(gl_FragCoord.x / textureSize(tex, 0).x, 0)).x;
  uint implicitDerivY = texture(tex, vec2(0, gl_FragCoord.y / textureSize(tex, 0).y)).x;
  if (implicitDerivX != fragSize.x || implicitDerivY != fragSize.y)
    col0.w = (fragSize.y << 26) | (fragSize.x << 20) | (implicitDerivY << 14) | (implicitDerivX << 8) | 4;
  endInvocationInterlockARB();
}
#version 450 core
#extension GL_EXT_fragment_shading_rate : enable
#extension GL_ARB_shader_stencil_export : enable
#extension GL_ARB_fragment_shader_interlock : enable
layout(location = 0) out uvec4 col0;
layout(set = 0, binding = 0) buffer Block { uint counter; } buf;
layout(set = 0, binding = 3) uniform usampler2D tex;
layout(location = 0) flat in int instanceIndex;
layout(location = 1) flat in int readbackok;
layout(location = 2) in float zero;
void main()
{
  col0.x = gl_ShadingRateEXT;
  col0.y = 0;
  col0.z = (instanceIndex << 24) | ((atomicAdd(buf.counter, 1) + 1) & 0x00FFFFFFu);
  ivec2 fragCoordXY = ivec2(gl_FragCoord.xy);
  ivec2 fragSize = ivec2(1<<((gl_ShadingRateEXT/4)&3), 1<<(gl_ShadingRateEXT&3));
  col0.w = uint(zero);
  if (((fragCoordXY - fragSize / 2) % fragSize) != ivec2(0,0))
    col0.w = 1;
  if (readbackok != 1)
    col0.w = 2;
  if (dFdx(gl_FragCoord.xy) != ivec2(fragSize.x, 0) || dFdy(gl_FragCoord.xy) != ivec2(0, fragSize.y))
    col0.w = (fragSize.y << 26) | (fragSize.x << 20) | (int(dFdx(gl_FragCoord.xy)) << 14) | (int(dFdx(gl_FragCoord.xy)) << 8) | 3;
  uint implicitDerivX = texture(tex, vec2(gl_FragCoord.x / textureSize(tex, 0).x, 0)).x;
  uint implicitDerivY = texture(tex, vec2(0, gl_FragCoord.y / textureSize(tex, 0).y)).x;
  if (implicitDerivX != fragSize.x || implicitDerivY != fragSize.y)
    col0.w = (fragSize.y << 26) | (fragSize.x << 20) | (implicitDerivY << 14) | (implicitDerivX << 8) | 4;
  gl_FragStencilRefARB = instanceIndex;
}
#version 450 core
#extension GL_EXT_fragment_shading_rate : enable
#extension GL_ARB_shader_stencil_export : enable
#extension GL_ARB_fragment_shader_interlock : enable
layout(location = 0) out uvec4 col0;
layout(set = 0, binding = 0) buffer Block { uint counter; } buf;
layout(set = 0, binding = 3) uniform usampler2D tex;
layout(location = 0) flat in int instanceIndex;
layout(location = 1) flat in int readbackok;
layout(location = 2) in float zero;
void main()
{
  col0.x = gl_ShadingRateEXT;
  col0.y = 0;
  col0.z = (instanceIndex << 24) | ((atomicAdd(buf.counter, 1) + 1) & 0x00FFFFFFu);
  ivec2 fragCoordXY = ivec2(gl_FragCoord.xy);
  ivec2 fragSize = ivec2(1<<((gl_ShadingRateEXT/4)&3), 1<<(gl_ShadingRateEXT&3));
  col0.w = uint(zero);
  if (((fragCoordXY - fragSize / 2) % fragSize) != ivec2(0,0))
    col0.w = 1;
  if (readbackok != 1)
    col0.w = 2;
  if (dFdx(gl_FragCoord.xy) != ivec2(fragSize.x, 0) || dFdy(gl_FragCoord.xy) != ivec2(0, fragSize.y))
    col0.w = (fragSize.y << 26) | (fragSize.x << 20) | (int(dFdx(gl_FragCoord.xy)) << 14) | (int(dFdx(gl_FragCoord.xy)) << 8) | 3;
  uint implicitDerivX = texture(tex, vec2(gl_FragCoord.x / textureSize(tex, 0).x, 0)).x;
  uint implicitDerivY = texture(tex, vec2(0, gl_FragCoord.y / textureSize(tex, 0).y)).x;
  if (implicitDerivX != fragSize.x || implicitDerivY != fragSize.y)
    col0.w = (fragSize.y << 26) | (fragSize.x << 20) | (implicitDerivY << 14) | (implicitDerivX << 8) | 4;
  gl_FragDepth = float(instanceIndex) / float(81);
}
#version 450 core
#extension GL_EXT_fragment_shading_rate : enable
#extension GL_ARB_shader_stencil_export : enable
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_AMD_shader_early_and_late_fragment_tests : enable
layout(location = 0) out uvec4 col0;
layout(set = 0, binding = 0) buffer Block { uint counter; } buf;
layout(set = 0, binding = 3) uniform usampler2D tex;
layout(location = 0) flat in int instanceIndex;
layout(location = 1) flat in int readbackok;
layout(location = 2) in float zero;
layout(early_and_late_fragment_tests_amd) in;
layout(stencil_ref_less_front_amd) out int gl_FragStencilRefARB;
void main()
{
  col0.x = gl_ShadingRateEXT;
  col0.y = 0;
  col0.z = (instanceIndex << 24) | ((atomicAdd(buf.counter, 1) + 1) & 0x00FFFFFFu);
  ivec2 fragCoordXY = ivec2(gl_FragCoord.xy);
  ivec2 fragSize = ivec2(1<<((gl_ShadingRateEXT/4)&3), 1<<(gl_ShadingRateEXT&3));
  col0.w = uint(zero);
  if (((fragCoordXY - fragSize / 2) % fragSize) != ivec2(0,0))
    col0.w = 1;
  if (readbackok != 1)
    col0.w = 2;
  if (dFdx(gl_FragCoord.xy) != ivec2(fragSize.x, 0) || dFdy(gl_FragCoord.xy) != ivec2(0, fragSize.y))
    col0.w = (fragSize.y << 26) | (fragSize.x << 20) | (int(dFdx(gl_FragCoord.xy)) << 14) | (int(dFdx(gl_FragCoord.xy)) << 8) | 3;
  uint implicitDerivX = texture(tex, vec2(gl_FragCoord.x / textureSize(tex, 0).x, 0)).x;
  uint implicitDerivY = texture(tex, vec2(0, gl_FragCoord.y / textureSize(tex, 0).y)).x;
  if (implicitDerivX != fragSize.x || implicitDerivY != fragSize.y)
    col0.w = (fragSize.y << 26) | (fragSize.x << 20) | (implicitDerivY << 14) | (implicitDerivX << 8) | 4;
  gl_FragStencilRefARB = instanceIndex;
}
#version 450 core
#extension GL_EXT_fragment_shading_rate : enable
#extension GL_ARB_shader_stencil_export : enable
#extension GL_ARB_fragment_shader_interlock : enable
#extension GL_AMD_shader_early_and_late_fragment_tests : enable
layout(location = 0) out uvec4 col0;
layout(set = 0, binding = 0) buffer Block { uint counter; } buf;
layout(set = 0, binding = 3) uniform usampler2D tex;
layout(location = 0) flat in int instanceIndex;
layout(location = 1) flat in int readbackok;
layout(location = 2) in float zero;
layout(early_and_late_fragment_tests_amd) in;
layout(depth_less) out float gl_FragDepth;
void main()
{
  col0.x = gl_ShadingRateEXT;
  col0.y = 0;
  col0.z = (instanceIndex << 24) | ((atomicAdd(buf.counter, 1) + 1) & 0x00FFFFFFu);
  ivec2 fragCoordXY = ivec2(gl_FragCoord.xy);
  ivec2 fragSize = ivec2(1<<((gl_ShadingRateEXT/4)&3), 1<<(gl_ShadingRateEXT&3));
  col0.w = uint(zero);
  if (((fragCoordXY - fragSize / 2) % fragSize) != ivec2(0,0))
    col0.w = 1;
  if (readbackok != 1)
    col0.w = 2;
  if (dFdx(gl_FragCoord.xy) != ivec2(fragSize.x, 0) || dFdy(gl_FragCoord.xy) != ivec2(0, fragSize.y))
    col0.w = (fragSize.y << 26) | (fragSize.x << 20) | (int(dFdx(gl_FragCoord.xy)) << 14) | (int(dFdx(gl_FragCoord.xy)) << 8) | 3;
  uint implicitDerivX = texture(tex, vec2(gl_FragCoord.x / textureSize(tex, 0).x, 0)).x;
  uint implicitDerivY = texture(tex, vec2(0, gl_FragCoord.y / textureSize(tex, 0).y)).x;
  if (implicitDerivX != fragSize.x || implicitDerivY != fragSize.y)
    col0.w = (fragSize.y << 26) | (fragSize.x << 20) | (implicitDerivY << 14) | (implicitDerivX << 8) | 4;
  gl_FragDepth = float(instanceIndex) / float(81);
}
#version 450 core
#extension GL_EXT_mesh_shader : enable
layout(local_size_x=3) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;
layout(push_constant, std430) uniform PC {
  int shadingRate;
  uint instanceIndex;
} pc;
layout(set=1, binding=0, std430) readonly buffer PosBuffer {
  vec2 vertexPositions[];
} pb;
layout(location = 0) flat out int instanceIndex[];
layout(location = 1) flat out int readbackok[];
layout(location = 2) out float zero[];
void main()
{
  SetMeshOutputsEXT(3u, 1u);
  const uint vertexIdx = (pc.instanceIndex * 3u + gl_LocalInvocationIndex);
  float vtxDepth = 0.0;
  gl_MeshVerticesEXT[gl_LocalInvocationIndex].gl_Position = vec4(pb.vertexPositions[vertexIdx], vtxDepth, 1);
  if (gl_LocalInvocationIndex == 0) {
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
  }
  instanceIndex[gl_LocalInvocationIndex] = int(pc.instanceIndex);
  readbackok[gl_LocalInvocationIndex] = 1;
  zero[gl_LocalInvocationIndex] = 0;
}
#version 450 core
#extension GL_EXT_mesh_shader : enable
layout(local_size_x=3) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;
layout(push_constant, std430) uniform PC {
  int shadingRate;
  uint instanceIndex;
} pc;
layout(set=1, binding=0, std430) readonly buffer PosBuffer {
  vec2 vertexPositions[];
} pb;
layout(location = 0) flat out int instanceIndex[];
layout(location = 1) flat out int readbackok[];
layout(location = 2) out float zero[];
void main()
{
  SetMeshOutputsEXT(3u, 1u);
  const uint vertexIdx = (pc.instanceIndex * 3u + gl_LocalInvocationIndex);
  float vtxDepth = 0.4;
  gl_MeshVerticesEXT[gl_LocalInvocationIndex].gl_Position = vec4(pb.vertexPositions[vertexIdx], vtxDepth, 1);
  if (gl_LocalInvocationIndex == 0) {
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
  }
  instanceIndex[gl_LocalInvocationIndex] = int(pc.instanceIndex);
  readbackok[gl_LocalInvocationIndex] = 1;
  zero[gl_LocalInvocationIndex] = 0;
}
#version 450 core
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_fragment_shading_rate : enable
layout(local_size_x=3) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;
layout(push_constant, std430) uniform PC {
  int shadingRate;
  uint instanceIndex;
} pc;
layout(set=1, binding=0, std430) readonly buffer PosBuffer {
  vec2 vertexPositions[];
} pb;
layout(location = 0) flat out int instanceIndex[];
layout(location = 1) flat out int readbackok[];
layout(location = 2) out float zero[];
perprimitiveEXT out gl_MeshPerPrimitiveEXT {
  int gl_PrimitiveShadingRateEXT;
} gl_MeshPrimitivesEXT[];
void main()
{
  SetMeshOutputsEXT(3u, 1u);
  const uint vertexIdx = (pc.instanceIndex * 3u + gl_LocalInvocationIndex);
  float vtxDepth = 0.0;
  gl_MeshVerticesEXT[gl_LocalInvocationIndex].gl_Position = vec4(pb.vertexPositions[vertexIdx], vtxDepth, 1);
  if (gl_LocalInvocationIndex == 0) {
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
  }
  instanceIndex[gl_LocalInvocationIndex] = int(pc.instanceIndex);
  readbackok[gl_LocalInvocationIndex] = 1;
  zero[gl_LocalInvocationIndex] = 0;
  gl_MeshPrimitivesEXT[0].gl_PrimitiveShadingRateEXT = pc.shadingRate;
}
#version 450 core
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_fragment_shading_rate : enable
layout(local_size_x=3) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;
layout(push_constant, std430) uniform PC {
  int shadingRate;
  uint instanceIndex;
} pc;
layout(set=1, binding=0, std430) readonly buffer PosBuffer {
  vec2 vertexPositions[];
} pb;
layout(location = 0) flat out int instanceIndex[];
layout(location = 1) flat out int readbackok[];
layout(location = 2) out float zero[];
perprimitiveEXT out gl_MeshPerPrimitiveEXT {
  int gl_PrimitiveShadingRateEXT;
} gl_MeshPrimitivesEXT[];
void main()
{
  SetMeshOutputsEXT(3u, 1u);
  const uint vertexIdx = (pc.instanceIndex * 3u + gl_LocalInvocationIndex);
  float vtxDepth = 0.4;
  gl_MeshVerticesEXT[gl_LocalInvocationIndex].gl_Position = vec4(pb.vertexPositions[vertexIdx], vtxDepth, 1);
  if (gl_LocalInvocationIndex == 0) {
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
  }
  instanceIndex[gl_LocalInvocationIndex] = int(pc.instanceIndex);
  readbackok[gl_LocalInvocationIndex] = 1;
  zero[gl_LocalInvocationIndex] = 0;
  gl_MeshPrimitivesEXT[0].gl_PrimitiveShadingRateEXT = pc.shadingRate;
}
#version 450 core
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_fragment_shading_rate : enable
layout(local_size_x=3) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;
layout(push_constant, std430) uniform PC {
  int shadingRate;
  uint instanceIndex;
} pc;
layout(set=1, binding=0, std430) readonly buffer PosBuffer {
  vec2 vertexPositions[];
} pb;
layout(location = 0) flat out int instanceIndex[];
layout(location = 1) flat out int readbackok[];
layout(location = 2) out float zero[];
perprimitiveEXT out gl_MeshPerPrimitiveEXT {
  int gl_Layer;
  int gl_PrimitiveShadingRateEXT;
} gl_MeshPrimitivesEXT[];
void main()
{
  SetMeshOutputsEXT(3u, 1u);
  const uint vertexIdx = (pc.instanceIndex * 3u + gl_LocalInvocationIndex);
  float vtxDepth = 0.0;
  gl_MeshVerticesEXT[gl_LocalInvocationIndex].gl_Position = vec4(pb.vertexPositions[vertexIdx], vtxDepth, 1);
  if (gl_LocalInvocationIndex == 0) {
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
  }
  instanceIndex[gl_LocalInvocationIndex] = int(pc.instanceIndex);
  readbackok[gl_LocalInvocationIndex] = 1;
  zero[gl_LocalInvocationIndex] = 0;
  gl_MeshPrimitivesEXT[0].gl_PrimitiveShadingRateEXT = pc.shadingRate;
  gl_MeshPrimitivesEXT[0].gl_Layer = int((pc.instanceIndex & 2) >> 1);
}
#version 450 core
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_fragment_shading_rate : enable
layout(local_size_x=3) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;
layout(push_constant, std430) uniform PC {
  int shadingRate;
  uint instanceIndex;
} pc;
layout(set=1, binding=0, std430) readonly buffer PosBuffer {
  vec2 vertexPositions[];
} pb;
layout(location = 0) flat out int instanceIndex[];
layout(location = 1) flat out int readbackok[];
layout(location = 2) out float zero[];
perprimitiveEXT out gl_MeshPerPrimitiveEXT {
  int gl_ViewportIndex;
  int gl_PrimitiveShadingRateEXT;
} gl_MeshPrimitivesEXT[];
void main()
{
  SetMeshOutputsEXT(3u, 1u);
  const uint vertexIdx = (pc.instanceIndex * 3u + gl_LocalInvocationIndex);
  float vtxDepth = 0.0;
  gl_MeshVerticesEXT[gl_LocalInvocationIndex].gl_Position = vec4(pb.vertexPositions[vertexIdx], vtxDepth, 1);
  if (gl_LocalInvocationIndex == 0) {
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
  }
  instanceIndex[gl_LocalInvocationIndex] = int(pc.instanceIndex);
  readbackok[gl_LocalInvocationIndex] = 1;
  zero[gl_LocalInvocationIndex] = 0;
  gl_MeshPrimitivesEXT[0].gl_PrimitiveShadingRateEXT = pc.shadingRate;
  gl_MeshPrimitivesEXT[0].gl_ViewportIndex = int(pc.instanceIndex & 1);
}
#version 450

layout(location = 0) in vec4 in_position;

out gl_PerVertex {
    vec4 gl_Position;
};

void main(void)
{
    gl_Position = in_position;
}
#version 450

#extension GL_EXT_fragment_shading_rate : enable
#extension GL_ARB_shader_stencil_export : enable

layout(location = 0) out uvec4 o_color;

void main(void)
{
    if (gl_ShadingRateEXT == 0)
        o_color = uvec4(128, 128, 128, 1);
    else
        o_color = uvec4(255, 0, 0, 1);

}
#version 450

layout(location = 0) in vec4 in_position;

out gl_PerVertex {
    vec4 gl_Position;
};

void main(void)
{
    gl_Position = in_position;
gl_Position.z = 0.4;
}
#version 450

#extension GL_EXT_fragment_shading_rate : enable
#extension GL_ARB_shader_stencil_export : enable

layout(location = 0) out uvec4 o_color;

void main(void)
{
    if (gl_ShadingRateEXT == 0)
        o_color = uvec4(128, 128, 128, 1);
    else
        o_color = uvec4(255, 0, 0, 1);

    if (gl_ShadingRateEXT == 0)
       gl_FragStencilRefARB = 1;
    else
       gl_FragStencilRefARB = 2;
}
#version 450

#extension GL_EXT_fragment_shading_rate : enable
#extension GL_ARB_shader_stencil_export : enable

layout(location = 0) out uvec4 o_color;

void main(void)
{
    if (gl_ShadingRateEXT == 0)
        o_color = uvec4(128, 128, 128, 1);
    else
        o_color = uvec4(255, 0, 0, 1);

    if (gl_ShadingRateEXT == 0)
       gl_FragDepth = 0.4;
    else
       gl_FragDepth = 0.2;

}
#version 450 core
#extension GL_EXT_fragment_shading_rate : enable
#extension GL_ARB_shader_viewport_layer_array : enable
layout(push_constant) uniform PC {
    int shadingRate;
} pc;
layout(location = 0) in vec2 pos;
layout(location = 0) out int instanceIndex;
layout(location = 1) out int readbackok;
layout(location = 2) out float zero;
out gl_PerVertex
{
   vec4 gl_Position;
};
void main()
{
  float vtxDepth = 0.0;
  gl_Position = vec4(pos, vtxDepth, 1);
  instanceIndex = gl_InstanceIndex;
  readbackok = 1;
  zero = 0;
}
#version 450 core
#extension GL_EXT_fragment_shading_rate : enable
#extension GL_ARB_shader_viewport_layer_array : enable
layout(push_constant) uniform PC {
    int shadingRate;
} pc;
layout(location = 0) in vec2 pos;
layout(location = 0) out int instanceIndex;
layout(location = 1) out int readbackok;
layout(location = 2) out float zero;
out gl_PerVertex
{
   vec4 gl_Position;
};
void main()
{
  float vtxDepth = 0.4;
  gl_Position = vec4(pos, vtxDepth, 1);
  instanceIndex = gl_InstanceIndex;
  readbackok = 1;
  zero = 0;
}
#version 450 core
#extension GL_EXT_fragment_shading_rate : enable
#extension GL_ARB_shader_viewport_layer_array : enable
layout(push_constant) uniform PC {
    int shadingRate;
} pc;
layout(location = 0) in vec2 pos;
layout(location = 0) out int instanceIndex;
layout(location = 1) out int readbackok;
layout(location = 2) out float zero;
out gl_PerVertex
{
   vec4 gl_Position;
};
void main()
{
  float vtxDepth = 0.0;
  gl_Position = vec4(pos, vtxDepth, 1);
  instanceIndex = gl_InstanceIndex;
  readbackok = 1;
  zero = 0;
  gl_PrimitiveShadingRateEXT = pc.shadingRate;
  if (gl_PrimitiveShadingRateEXT != pc.shadingRate) readbackok = 0;
}
#version 450 core
#extension GL_EXT_fragment_shading_rate : enable
#extension GL_ARB_shader_viewport_layer_array : enable
layout(push_constant) uniform PC {
    int shadingRate;
} pc;
layout(location = 0) in vec2 pos;
layout(location = 0) out int instanceIndex;
layout(location = 1) out int readbackok;
layout(location = 2) out float zero;
out gl_PerVertex
{
   vec4 gl_Position;
};
void main()
{
  float vtxDepth = 0.4;
  gl_Position = vec4(pos, vtxDepth, 1);
  instanceIndex = gl_InstanceIndex;
  readbackok = 1;
  zero = 0;
  gl_PrimitiveShadingRateEXT = pc.shadingRate;
  if (gl_PrimitiveShadingRateEXT != pc.shadingRate) readbackok = 0;
}
#version 450 core
#extension GL_EXT_fragment_shading_rate : enable
#extension GL_ARB_shader_viewport_layer_array : enable
layout(push_constant) uniform PC {
    int shadingRate;
} pc;
layout(location = 0) in vec2 pos;
layout(location = 0) out int instanceIndex;
layout(location = 1) out int readbackok;
layout(location = 2) out float zero;
out gl_PerVertex
{
   vec4 gl_Position;
};
void main()
{
  float vtxDepth = 0.0;
  gl_Position = vec4(pos, vtxDepth, 1);
  instanceIndex = gl_InstanceIndex;
  readbackok = 1;
  zero = 0;
  gl_PrimitiveShadingRateEXT = pc.shadingRate;
  if (gl_PrimitiveShadingRateEXT != pc.shadingRate) readbackok = 0;
  gl_Layer = ((instanceIndex & 2) >> 1);
}
#version 450 core
#extension GL_EXT_fragment_shading_rate : enable
#extension GL_ARB_shader_viewport_layer_array : enable
layout(push_constant) uniform PC {
    int shadingRate;
} pc;
layout(location = 0) in vec2 pos;
layout(location = 0) out int instanceIndex;
layout(location = 1) out int readbackok;
layout(location = 2) out float zero;
out gl_PerVertex
{
   vec4 gl_Position;
};
void main()
{
  float vtxDepth = 0.0;
  gl_Position = vec4(pos, vtxDepth, 1);
  instanceIndex = gl_InstanceIndex;
  readbackok = 1;
  zero = 0;
  gl_PrimitiveShadingRateEXT = pc.shadingRate;
  if (gl_PrimitiveShadingRateEXT != pc.shadingRate) readbackok = 0;
  gl_ViewportIndex = instanceIndex & 1;
}
#version 450 core
#extension GL_EXT_fragment_shading_rate : enable

layout(push_constant) uniform PC {
    int shadingRate;
} pc;

in gl_PerVertex
{
   vec4 gl_Position;
} gl_in[3];

layout(location = 0) in int inInstanceIndex[];
layout(location = 0) out int outInstanceIndex;
layout(location = 1) out int readbackok;
layout(location = 2) out float zero;
layout(triangles) in;
layout(triangle_strip, max_vertices=3) out;

out gl_PerVertex {
   vec4 gl_Position;
};

void main(void)
{
   gl_Position = gl_in[0].gl_Position;
   outInstanceIndex = inInstanceIndex[0];
   readbackok  = 1;
   zero = 0;
  gl_PrimitiveShadingRateEXT = pc.shadingRate;
  if (gl_PrimitiveShadingRateEXT != pc.shadingRate) readbackok = 0;
   EmitVertex();
   gl_Position = gl_in[1].gl_Position;
   outInstanceIndex = inInstanceIndex[1];
   readbackok = 1;
   zero = 0;
  gl_PrimitiveShadingRateEXT = pc.shadingRate;
  if (gl_PrimitiveShadingRateEXT != pc.shadingRate) readbackok = 0;
   EmitVertex();
   gl_Position = gl_in[2].gl_Position;
   outInstanceIndex = inInstanceIndex[2];
   readbackok = 1;
   zero = 0;
  gl_PrimitiveShadingRateEXT = pc.shadingRate;
  if (gl_PrimitiveShadingRateEXT != pc.shadingRate) readbackok = 0;
   EmitVertex();}
#version 450 core
#extension GL_EXT_fragment_shading_rate : enable

layout(push_constant) uniform PC {
    int shadingRate;
} pc;

in gl_PerVertex
{
   vec4 gl_Position;
} gl_in[3];

layout(location = 0) in int inInstanceIndex[];
layout(location = 0) out int outInstanceIndex;
layout(location = 1) out int readbackok;
layout(location = 2) out float zero;
layout(triangles) in;
layout(triangle_strip, max_vertices=3) out;

out gl_PerVertex {
   vec4 gl_Position;
};

void main(void)
{
   gl_Position = gl_in[0].gl_Position;
   outInstanceIndex = inInstanceIndex[0];
   readbackok  = 1;
   zero = 0;
  gl_PrimitiveShadingRateEXT = pc.shadingRate;
  if (gl_PrimitiveShadingRateEXT != pc.shadingRate) readbackok = 0;
  gl_Layer = (inInstanceIndex[0] & 2) >> 1;
   EmitVertex();
   gl_Position = gl_in[1].gl_Position;
   outInstanceIndex = inInstanceIndex[1];
   readbackok = 1;
   zero = 0;
  gl_PrimitiveShadingRateEXT = pc.shadingRate;
  if (gl_PrimitiveShadingRateEXT != pc.shadingRate) readbackok = 0;
  gl_Layer = (inInstanceIndex[0] & 2) >> 1;
   EmitVertex();
   gl_Position = gl_in[2].gl_Position;
   outInstanceIndex = inInstanceIndex[2];
   readbackok = 1;
   zero = 0;
  gl_PrimitiveShadingRateEXT = pc.shadingRate;
  if (gl_PrimitiveShadingRateEXT != pc.shadingRate) readbackok = 0;
  gl_Layer = (inInstanceIndex[0] & 2) >> 1;
   EmitVertex();}
#version 450 core
#extension GL_EXT_fragment_shading_rate : enable

layout(push_constant) uniform PC {
    int shadingRate;
} pc;

in gl_PerVertex
{
   vec4 gl_Position;
} gl_in[3];

layout(location = 0) in int inInstanceIndex[];
layout(location = 0) out int outInstanceIndex;
layout(location = 1) out int readbackok;
layout(location = 2) out float zero;
layout(triangles) in;
layout(triangle_strip, max_vertices=3) out;

out gl_PerVertex {
   vec4 gl_Position;
};

void main(void)
{
   gl_Position = gl_in[0].gl_Position;
   outInstanceIndex = inInstanceIndex[0];
   readbackok  = 1;
   zero = 0;
  gl_PrimitiveShadingRateEXT = pc.shadingRate;
  if (gl_PrimitiveShadingRateEXT != pc.shadingRate) readbackok = 0;
  gl_ViewportIndex = inInstanceIndex[0] & 1;
   EmitVertex();
   gl_Position = gl_in[1].gl_Position;
   outInstanceIndex = inInstanceIndex[1];
   readbackok = 1;
   zero = 0;
  gl_PrimitiveShadingRateEXT = pc.shadingRate;
  if (gl_PrimitiveShadingRateEXT != pc.shadingRate) readbackok = 0;
  gl_ViewportIndex = inInstanceIndex[0] & 1;
   EmitVertex();
   gl_Position = gl_in[2].gl_Position;
   outInstanceIndex = inInstanceIndex[2];
   readbackok = 1;
   zero = 0;
  gl_PrimitiveShadingRateEXT = pc.shadingRate;
  if (gl_PrimitiveShadingRateEXT != pc.shadingRate) readbackok = 0;
  gl_ViewportIndex = inInstanceIndex[0] & 1;
   EmitVertex();}
