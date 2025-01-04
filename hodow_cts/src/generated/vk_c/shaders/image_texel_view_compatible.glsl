#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rgba16) readonly uniform image1D u_image0;
layout (binding = 1, rgba16) writeonly uniform image1D u_image1;

void main (void)
{
    highp int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform sampler1D compressed_result;
layout (binding = 1) uniform sampler1D compressed_reference;
layout (binding = 2, rgba8) writeonly uniform image1D decompressed_result;
layout (binding = 3, rgba8) writeonly uniform image1D decompressed_reference;
layout (push_constant, std430) uniform PushConstants { uint layer; uint level; };

void main (void)
{
    const vec2 pixels_resolution = vec2(gl_NumWorkGroups.xy);
    const highp float coord = float(gl_GlobalInvocationID.x) / pixels_resolution.x;
    const highp int     pos = int(gl_GlobalInvocationID.x); 
    imageStore(decompressed_result, pos, texture(compressed_result, coord));
    imageStore(decompressed_reference, pos, texture(compressed_reference, coord));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rgba16) readonly uniform image2D u_image0;
layout (binding = 1, rgba16) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform sampler2D compressed_result;
layout (binding = 1) uniform sampler2D compressed_reference;
layout (binding = 2, rgba8) writeonly uniform image2D decompressed_result;
layout (binding = 3, rgba8) writeonly uniform image2D decompressed_reference;
layout (push_constant, std430) uniform PushConstants { uint layer; uint level; };

void main (void)
{
    const vec2 pixels_resolution = vec2(gl_NumWorkGroups.xy);
    const vec2 coord = vec2(gl_GlobalInvocationID.xy) / vec2(pixels_resolution);
    const ivec2  pos = ivec2(gl_GlobalInvocationID.xy); 
    imageStore(decompressed_result, pos, texture(compressed_result, coord));
    imageStore(decompressed_reference, pos, texture(compressed_reference, coord));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform sampler2D compressed_result;
layout (binding = 1) uniform sampler2DArray compressed_reference;
layout (binding = 2, rgba8) writeonly uniform image2D decompressed_result;
layout (binding = 3, rgba8) writeonly uniform image2D decompressed_reference;
layout (push_constant, std430) uniform PushConstants { uint layer; uint level; };

void main (void)
{
    const vec2 pixels_resolution = vec2(gl_NumWorkGroups.xy);
    const vec2 coord = vec2(gl_GlobalInvocationID.xy) / vec2(pixels_resolution);
    const ivec2  pos = ivec2(gl_GlobalInvocationID.xy); 
    imageStore(decompressed_result, pos, texture(compressed_result, coord));
    imageStore(decompressed_reference, pos, textureLod(compressed_reference, vec3(coord, layer), level));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rgba16) readonly uniform image2DArray u_image0;
layout (binding = 1, rgba16) writeonly uniform image2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform sampler2DArray compressed_result;
layout (binding = 1) uniform sampler2DArray compressed_reference;
layout (binding = 2, rgba8) writeonly uniform image2DArray decompressed_result;
layout (binding = 3, rgba8) writeonly uniform image2DArray decompressed_reference;
layout (push_constant, std430) uniform PushConstants { uint layer; uint level; };

void main (void)
{
    const vec2 pixels_resolution = vec2(gl_NumWorkGroups.xy);
    const vec2    v2 = vec2(gl_GlobalInvocationID.xy) / vec2(pixels_resolution);
    const vec3 coord = vec3(v2, gl_GlobalInvocationID.z);
    const ivec3  pos = ivec3(gl_GlobalInvocationID); 
    imageStore(decompressed_result, pos, texture(compressed_result, coord));
    imageStore(decompressed_reference, pos, texture(compressed_reference, coord));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rgba16) readonly uniform image3D u_image0;
layout (binding = 1, rgba16) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform sampler3D compressed_result;
layout (binding = 1) uniform sampler3D compressed_reference;
layout (binding = 2, rgba8) writeonly uniform image3D decompressed_result;
layout (binding = 3, rgba8) writeonly uniform image3D decompressed_reference;
layout (push_constant, std430) uniform PushConstants { uint layer; uint level; };

void main (void)
{
    const vec2 pixels_resolution = vec2(gl_NumWorkGroups.xy);
    const vec2    v2 = vec2(gl_GlobalInvocationID.xy) / vec2(pixels_resolution);
    const vec3 coord = vec3(v2, 0.0);
    const ivec3  pos = ivec3(gl_GlobalInvocationID); 
    imageStore(decompressed_result, pos, texture(compressed_result, coord));
    imageStore(decompressed_reference, pos, texture(compressed_reference, coord));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rgba16_snorm) readonly uniform image1D u_image0;
layout (binding = 1, rgba16_snorm) writeonly uniform image1D u_image1;

void main (void)
{
    highp int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rgba16_snorm) readonly uniform image2D u_image0;
layout (binding = 1, rgba16_snorm) writeonly uniform image2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rgba16_snorm) readonly uniform image2DArray u_image0;
layout (binding = 1, rgba16_snorm) writeonly uniform image2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rgba16_snorm) readonly uniform image3D u_image0;
layout (binding = 1, rgba16_snorm) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rgba16ui) readonly uniform uimage1D u_image0;
layout (binding = 1, rgba16ui) writeonly uniform uimage1D u_image1;

void main (void)
{
    highp int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rgba16ui) readonly uniform uimage2D u_image0;
layout (binding = 1, rgba16ui) writeonly uniform uimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rgba16ui) readonly uniform uimage2DArray u_image0;
layout (binding = 1, rgba16ui) writeonly uniform uimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rgba16ui) readonly uniform uimage3D u_image0;
layout (binding = 1, rgba16ui) writeonly uniform uimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rgba16i) readonly uniform iimage1D u_image0;
layout (binding = 1, rgba16i) writeonly uniform iimage1D u_image1;

void main (void)
{
    highp int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rgba16i) readonly uniform iimage2D u_image0;
layout (binding = 1, rgba16i) writeonly uniform iimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rgba16i) readonly uniform iimage2DArray u_image0;
layout (binding = 1, rgba16i) writeonly uniform iimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rgba16i) readonly uniform iimage3D u_image0;
layout (binding = 1, rgba16i) writeonly uniform iimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rg32ui) readonly uniform uimage1D u_image0;
layout (binding = 1, rg32ui) writeonly uniform uimage1D u_image1;

void main (void)
{
    highp int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rg32ui) readonly uniform uimage2D u_image0;
layout (binding = 1, rg32ui) writeonly uniform uimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rg32ui) readonly uniform uimage2DArray u_image0;
layout (binding = 1, rg32ui) writeonly uniform uimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rg32ui) readonly uniform uimage3D u_image0;
layout (binding = 1, rg32ui) writeonly uniform uimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rg32i) readonly uniform iimage1D u_image0;
layout (binding = 1, rg32i) writeonly uniform iimage1D u_image1;

void main (void)
{
    highp int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rg32i) readonly uniform iimage2D u_image0;
layout (binding = 1, rg32i) writeonly uniform iimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rg32i) readonly uniform iimage2DArray u_image0;
layout (binding = 1, rg32i) writeonly uniform iimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rg32i) readonly uniform iimage3D u_image0;
layout (binding = 1, rg32i) writeonly uniform iimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rgba32ui) readonly uniform uimage1D u_image0;
layout (binding = 1, rgba32ui) writeonly uniform uimage1D u_image1;

void main (void)
{
    highp int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rgba32ui) readonly uniform uimage2D u_image0;
layout (binding = 1, rgba32ui) writeonly uniform uimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rgba32ui) readonly uniform uimage2DArray u_image0;
layout (binding = 1, rgba32ui) writeonly uniform uimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rgba32ui) readonly uniform uimage3D u_image0;
layout (binding = 1, rgba32ui) writeonly uniform uimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rgba32i) readonly uniform iimage1D u_image0;
layout (binding = 1, rgba32i) writeonly uniform iimage1D u_image1;

void main (void)
{
    highp int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rgba32i) readonly uniform iimage2D u_image0;
layout (binding = 1, rgba32i) writeonly uniform iimage2D u_image1;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rgba32i) readonly uniform iimage2DArray u_image0;
layout (binding = 1, rgba32i) writeonly uniform iimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rgba32i) readonly uniform iimage3D u_image0;
layout (binding = 1, rgba32i) writeonly uniform iimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image1, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform sampler1D u_image0;
layout (binding = 1, rgba16) writeonly uniform image1D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(u_image1, pos.x, texelFetch(u_image0, pos.x, pos.z));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform sampler2D u_image0;
layout (binding = 1, rgba16) writeonly uniform image2D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(u_image1, pos.xy, texelFetch(u_image0, pos.xy, pos.z));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform sampler2DArray u_image0;
layout (binding = 1, rgba16) writeonly uniform image2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(u_image1, pos, texelFetch(u_image0, pos, 0));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform sampler3D u_image0;
layout (binding = 1, rgba16) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(u_image1, pos, texelFetch(u_image0, pos, pos.z));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform sampler1D u_image0;
layout (binding = 1, rgba16_snorm) writeonly uniform image1D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(u_image1, pos.x, texelFetch(u_image0, pos.x, pos.z));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform sampler2D u_image0;
layout (binding = 1, rgba16_snorm) writeonly uniform image2D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(u_image1, pos.xy, texelFetch(u_image0, pos.xy, pos.z));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform sampler2DArray u_image0;
layout (binding = 1, rgba16_snorm) writeonly uniform image2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(u_image1, pos, texelFetch(u_image0, pos, 0));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform sampler3D u_image0;
layout (binding = 1, rgba16_snorm) writeonly uniform image3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(u_image1, pos, texelFetch(u_image0, pos, pos.z));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform usampler1D u_image0;
layout (binding = 1, rgba16ui) writeonly uniform uimage1D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(u_image1, pos.x, texelFetch(u_image0, pos.x, pos.z));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform usampler2D u_image0;
layout (binding = 1, rgba16ui) writeonly uniform uimage2D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(u_image1, pos.xy, texelFetch(u_image0, pos.xy, pos.z));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform usampler2DArray u_image0;
layout (binding = 1, rgba16ui) writeonly uniform uimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(u_image1, pos, texelFetch(u_image0, pos, 0));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform usampler3D u_image0;
layout (binding = 1, rgba16ui) writeonly uniform uimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(u_image1, pos, texelFetch(u_image0, pos, pos.z));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform isampler1D u_image0;
layout (binding = 1, rgba16i) writeonly uniform iimage1D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(u_image1, pos.x, texelFetch(u_image0, pos.x, pos.z));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform isampler2D u_image0;
layout (binding = 1, rgba16i) writeonly uniform iimage2D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(u_image1, pos.xy, texelFetch(u_image0, pos.xy, pos.z));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform isampler2DArray u_image0;
layout (binding = 1, rgba16i) writeonly uniform iimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(u_image1, pos, texelFetch(u_image0, pos, 0));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform isampler3D u_image0;
layout (binding = 1, rgba16i) writeonly uniform iimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(u_image1, pos, texelFetch(u_image0, pos, pos.z));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform usampler1D u_image0;
layout (binding = 1, rg32ui) writeonly uniform uimage1D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(u_image1, pos.x, texelFetch(u_image0, pos.x, pos.z));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform usampler2D u_image0;
layout (binding = 1, rg32ui) writeonly uniform uimage2D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(u_image1, pos.xy, texelFetch(u_image0, pos.xy, pos.z));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform usampler2DArray u_image0;
layout (binding = 1, rg32ui) writeonly uniform uimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(u_image1, pos, texelFetch(u_image0, pos, 0));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform usampler3D u_image0;
layout (binding = 1, rg32ui) writeonly uniform uimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(u_image1, pos, texelFetch(u_image0, pos, pos.z));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform isampler1D u_image0;
layout (binding = 1, rg32i) writeonly uniform iimage1D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(u_image1, pos.x, texelFetch(u_image0, pos.x, pos.z));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform isampler2D u_image0;
layout (binding = 1, rg32i) writeonly uniform iimage2D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(u_image1, pos.xy, texelFetch(u_image0, pos.xy, pos.z));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform isampler2DArray u_image0;
layout (binding = 1, rg32i) writeonly uniform iimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(u_image1, pos, texelFetch(u_image0, pos, 0));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform isampler3D u_image0;
layout (binding = 1, rg32i) writeonly uniform iimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(u_image1, pos, texelFetch(u_image0, pos, pos.z));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform usampler1D u_image0;
layout (binding = 1, rgba32ui) writeonly uniform uimage1D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(u_image1, pos.x, texelFetch(u_image0, pos.x, pos.z));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform usampler2D u_image0;
layout (binding = 1, rgba32ui) writeonly uniform uimage2D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(u_image1, pos.xy, texelFetch(u_image0, pos.xy, pos.z));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform usampler2DArray u_image0;
layout (binding = 1, rgba32ui) writeonly uniform uimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(u_image1, pos, texelFetch(u_image0, pos, 0));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform usampler3D u_image0;
layout (binding = 1, rgba32ui) writeonly uniform uimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(u_image1, pos, texelFetch(u_image0, pos, pos.z));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform isampler1D u_image0;
layout (binding = 1, rgba32i) writeonly uniform iimage1D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(u_image1, pos.x, texelFetch(u_image0, pos.x, pos.z));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform isampler2D u_image0;
layout (binding = 1, rgba32i) writeonly uniform iimage2D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(u_image1, pos.xy, texelFetch(u_image0, pos.xy, pos.z));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform isampler2DArray u_image0;
layout (binding = 1, rgba32i) writeonly uniform iimage2DArray u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(u_image1, pos, texelFetch(u_image0, pos, 0));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform isampler3D u_image0;
layout (binding = 1, rgba32i) writeonly uniform iimage3D u_image1;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    imageStore(u_image1, pos, texelFetch(u_image0, pos, pos.z));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform sampler1D u_image0;
layout (binding = 1, rgba16) writeonly uniform image1D u_image1;

void main (void)
{
    const vec2 pixels_resolution = vec2(gl_NumWorkGroups.x, gl_NumWorkGroups.y);
    const int     pos = int(gl_GlobalInvocationID.x);
    const float coord = (float(gl_GlobalInvocationID.x) + 0.5) / pixels_resolution.x;
    imageStore(u_image1, pos, texture(u_image0, coord));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform sampler2D u_image0;
layout (binding = 1, rgba16) writeonly uniform image2D u_image1;

void main (void)
{
    const vec2 pixels_resolution = vec2(gl_NumWorkGroups.x, gl_NumWorkGroups.y);
    const ivec2  pos = ivec2(gl_GlobalInvocationID.xy);
    const vec2 coord = (vec2(gl_GlobalInvocationID.xy) + 0.5) / vec2(pixels_resolution);
    imageStore(u_image1, pos, texture(u_image0, coord));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform sampler2DArray u_image0;
layout (binding = 1, rgba16) writeonly uniform image2DArray u_image1;

void main (void)
{
    const vec2 pixels_resolution = vec2(gl_NumWorkGroups.x, gl_NumWorkGroups.y);
    const ivec3  pos = ivec3(gl_GlobalInvocationID.xyz);
    const vec2    v2 = (vec2(gl_GlobalInvocationID.xy) + 0.5) / vec2(pixels_resolution);
    const vec3 coord = vec3(v2, pos.z);
    imageStore(u_image1, pos, texture(u_image0, coord));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform sampler3D u_image0;
layout (binding = 1, rgba16) writeonly uniform image3D u_image1;

void main (void)
{
    const vec2 pixels_resolution = vec2(gl_NumWorkGroups.x, gl_NumWorkGroups.y);
    const ivec3  pos = ivec3(gl_GlobalInvocationID.xy, 0);
    const vec2    v2 = (vec2(gl_GlobalInvocationID.xy) + 0.5) / vec2(pixels_resolution);
    const vec3 coord = vec3(v2, 0.0);
    imageStore(u_image1, pos, texture(u_image0, coord));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform sampler1D u_image0;
layout (binding = 1, rgba16_snorm) writeonly uniform image1D u_image1;

void main (void)
{
    const vec2 pixels_resolution = vec2(gl_NumWorkGroups.x, gl_NumWorkGroups.y);
    const int     pos = int(gl_GlobalInvocationID.x);
    const float coord = (float(gl_GlobalInvocationID.x) + 0.5) / pixels_resolution.x;
    imageStore(u_image1, pos, texture(u_image0, coord));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform sampler2D u_image0;
layout (binding = 1, rgba16_snorm) writeonly uniform image2D u_image1;

void main (void)
{
    const vec2 pixels_resolution = vec2(gl_NumWorkGroups.x, gl_NumWorkGroups.y);
    const ivec2  pos = ivec2(gl_GlobalInvocationID.xy);
    const vec2 coord = (vec2(gl_GlobalInvocationID.xy) + 0.5) / vec2(pixels_resolution);
    imageStore(u_image1, pos, texture(u_image0, coord));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform sampler2DArray u_image0;
layout (binding = 1, rgba16_snorm) writeonly uniform image2DArray u_image1;

void main (void)
{
    const vec2 pixels_resolution = vec2(gl_NumWorkGroups.x, gl_NumWorkGroups.y);
    const ivec3  pos = ivec3(gl_GlobalInvocationID.xyz);
    const vec2    v2 = (vec2(gl_GlobalInvocationID.xy) + 0.5) / vec2(pixels_resolution);
    const vec3 coord = vec3(v2, pos.z);
    imageStore(u_image1, pos, texture(u_image0, coord));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform sampler3D u_image0;
layout (binding = 1, rgba16_snorm) writeonly uniform image3D u_image1;

void main (void)
{
    const vec2 pixels_resolution = vec2(gl_NumWorkGroups.x, gl_NumWorkGroups.y);
    const ivec3  pos = ivec3(gl_GlobalInvocationID.xy, 0);
    const vec2    v2 = (vec2(gl_GlobalInvocationID.xy) + 0.5) / vec2(pixels_resolution);
    const vec3 coord = vec3(v2, 0.0);
    imageStore(u_image1, pos, texture(u_image0, coord));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform usampler1D u_image0;
layout (binding = 1, rgba16ui) writeonly uniform uimage1D u_image1;

void main (void)
{
    const vec2 pixels_resolution = vec2(gl_NumWorkGroups.x, gl_NumWorkGroups.y);
    const int     pos = int(gl_GlobalInvocationID.x);
    const float coord = (float(gl_GlobalInvocationID.x) + 0.5) / pixels_resolution.x;
    imageStore(u_image1, pos, texture(u_image0, coord));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform usampler2D u_image0;
layout (binding = 1, rgba16ui) writeonly uniform uimage2D u_image1;

void main (void)
{
    const vec2 pixels_resolution = vec2(gl_NumWorkGroups.x, gl_NumWorkGroups.y);
    const ivec2  pos = ivec2(gl_GlobalInvocationID.xy);
    const vec2 coord = (vec2(gl_GlobalInvocationID.xy) + 0.5) / vec2(pixels_resolution);
    imageStore(u_image1, pos, texture(u_image0, coord));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform usampler2DArray u_image0;
layout (binding = 1, rgba16ui) writeonly uniform uimage2DArray u_image1;

void main (void)
{
    const vec2 pixels_resolution = vec2(gl_NumWorkGroups.x, gl_NumWorkGroups.y);
    const ivec3  pos = ivec3(gl_GlobalInvocationID.xyz);
    const vec2    v2 = (vec2(gl_GlobalInvocationID.xy) + 0.5) / vec2(pixels_resolution);
    const vec3 coord = vec3(v2, pos.z);
    imageStore(u_image1, pos, texture(u_image0, coord));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform usampler3D u_image0;
layout (binding = 1, rgba16ui) writeonly uniform uimage3D u_image1;

void main (void)
{
    const vec2 pixels_resolution = vec2(gl_NumWorkGroups.x, gl_NumWorkGroups.y);
    const ivec3  pos = ivec3(gl_GlobalInvocationID.xy, 0);
    const vec2    v2 = (vec2(gl_GlobalInvocationID.xy) + 0.5) / vec2(pixels_resolution);
    const vec3 coord = vec3(v2, 0.0);
    imageStore(u_image1, pos, texture(u_image0, coord));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform isampler1D u_image0;
layout (binding = 1, rgba16i) writeonly uniform iimage1D u_image1;

void main (void)
{
    const vec2 pixels_resolution = vec2(gl_NumWorkGroups.x, gl_NumWorkGroups.y);
    const int     pos = int(gl_GlobalInvocationID.x);
    const float coord = (float(gl_GlobalInvocationID.x) + 0.5) / pixels_resolution.x;
    imageStore(u_image1, pos, texture(u_image0, coord));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform isampler2D u_image0;
layout (binding = 1, rgba16i) writeonly uniform iimage2D u_image1;

void main (void)
{
    const vec2 pixels_resolution = vec2(gl_NumWorkGroups.x, gl_NumWorkGroups.y);
    const ivec2  pos = ivec2(gl_GlobalInvocationID.xy);
    const vec2 coord = (vec2(gl_GlobalInvocationID.xy) + 0.5) / vec2(pixels_resolution);
    imageStore(u_image1, pos, texture(u_image0, coord));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform isampler2DArray u_image0;
layout (binding = 1, rgba16i) writeonly uniform iimage2DArray u_image1;

void main (void)
{
    const vec2 pixels_resolution = vec2(gl_NumWorkGroups.x, gl_NumWorkGroups.y);
    const ivec3  pos = ivec3(gl_GlobalInvocationID.xyz);
    const vec2    v2 = (vec2(gl_GlobalInvocationID.xy) + 0.5) / vec2(pixels_resolution);
    const vec3 coord = vec3(v2, pos.z);
    imageStore(u_image1, pos, texture(u_image0, coord));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform isampler3D u_image0;
layout (binding = 1, rgba16i) writeonly uniform iimage3D u_image1;

void main (void)
{
    const vec2 pixels_resolution = vec2(gl_NumWorkGroups.x, gl_NumWorkGroups.y);
    const ivec3  pos = ivec3(gl_GlobalInvocationID.xy, 0);
    const vec2    v2 = (vec2(gl_GlobalInvocationID.xy) + 0.5) / vec2(pixels_resolution);
    const vec3 coord = vec3(v2, 0.0);
    imageStore(u_image1, pos, texture(u_image0, coord));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform usampler1D u_image0;
layout (binding = 1, rg32ui) writeonly uniform uimage1D u_image1;

void main (void)
{
    const vec2 pixels_resolution = vec2(gl_NumWorkGroups.x, gl_NumWorkGroups.y);
    const int     pos = int(gl_GlobalInvocationID.x);
    const float coord = (float(gl_GlobalInvocationID.x) + 0.5) / pixels_resolution.x;
    imageStore(u_image1, pos, texture(u_image0, coord));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform usampler2D u_image0;
layout (binding = 1, rg32ui) writeonly uniform uimage2D u_image1;

void main (void)
{
    const vec2 pixels_resolution = vec2(gl_NumWorkGroups.x, gl_NumWorkGroups.y);
    const ivec2  pos = ivec2(gl_GlobalInvocationID.xy);
    const vec2 coord = (vec2(gl_GlobalInvocationID.xy) + 0.5) / vec2(pixels_resolution);
    imageStore(u_image1, pos, texture(u_image0, coord));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform usampler2DArray u_image0;
layout (binding = 1, rg32ui) writeonly uniform uimage2DArray u_image1;

void main (void)
{
    const vec2 pixels_resolution = vec2(gl_NumWorkGroups.x, gl_NumWorkGroups.y);
    const ivec3  pos = ivec3(gl_GlobalInvocationID.xyz);
    const vec2    v2 = (vec2(gl_GlobalInvocationID.xy) + 0.5) / vec2(pixels_resolution);
    const vec3 coord = vec3(v2, pos.z);
    imageStore(u_image1, pos, texture(u_image0, coord));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform usampler3D u_image0;
layout (binding = 1, rg32ui) writeonly uniform uimage3D u_image1;

void main (void)
{
    const vec2 pixels_resolution = vec2(gl_NumWorkGroups.x, gl_NumWorkGroups.y);
    const ivec3  pos = ivec3(gl_GlobalInvocationID.xy, 0);
    const vec2    v2 = (vec2(gl_GlobalInvocationID.xy) + 0.5) / vec2(pixels_resolution);
    const vec3 coord = vec3(v2, 0.0);
    imageStore(u_image1, pos, texture(u_image0, coord));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform isampler1D u_image0;
layout (binding = 1, rg32i) writeonly uniform iimage1D u_image1;

void main (void)
{
    const vec2 pixels_resolution = vec2(gl_NumWorkGroups.x, gl_NumWorkGroups.y);
    const int     pos = int(gl_GlobalInvocationID.x);
    const float coord = (float(gl_GlobalInvocationID.x) + 0.5) / pixels_resolution.x;
    imageStore(u_image1, pos, texture(u_image0, coord));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform isampler2D u_image0;
layout (binding = 1, rg32i) writeonly uniform iimage2D u_image1;

void main (void)
{
    const vec2 pixels_resolution = vec2(gl_NumWorkGroups.x, gl_NumWorkGroups.y);
    const ivec2  pos = ivec2(gl_GlobalInvocationID.xy);
    const vec2 coord = (vec2(gl_GlobalInvocationID.xy) + 0.5) / vec2(pixels_resolution);
    imageStore(u_image1, pos, texture(u_image0, coord));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform isampler2DArray u_image0;
layout (binding = 1, rg32i) writeonly uniform iimage2DArray u_image1;

void main (void)
{
    const vec2 pixels_resolution = vec2(gl_NumWorkGroups.x, gl_NumWorkGroups.y);
    const ivec3  pos = ivec3(gl_GlobalInvocationID.xyz);
    const vec2    v2 = (vec2(gl_GlobalInvocationID.xy) + 0.5) / vec2(pixels_resolution);
    const vec3 coord = vec3(v2, pos.z);
    imageStore(u_image1, pos, texture(u_image0, coord));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform isampler3D u_image0;
layout (binding = 1, rg32i) writeonly uniform iimage3D u_image1;

void main (void)
{
    const vec2 pixels_resolution = vec2(gl_NumWorkGroups.x, gl_NumWorkGroups.y);
    const ivec3  pos = ivec3(gl_GlobalInvocationID.xy, 0);
    const vec2    v2 = (vec2(gl_GlobalInvocationID.xy) + 0.5) / vec2(pixels_resolution);
    const vec3 coord = vec3(v2, 0.0);
    imageStore(u_image1, pos, texture(u_image0, coord));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform usampler1D u_image0;
layout (binding = 1, rgba32ui) writeonly uniform uimage1D u_image1;

void main (void)
{
    const vec2 pixels_resolution = vec2(gl_NumWorkGroups.x, gl_NumWorkGroups.y);
    const int     pos = int(gl_GlobalInvocationID.x);
    const float coord = (float(gl_GlobalInvocationID.x) + 0.5) / pixels_resolution.x;
    imageStore(u_image1, pos, texture(u_image0, coord));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform usampler2D u_image0;
layout (binding = 1, rgba32ui) writeonly uniform uimage2D u_image1;

void main (void)
{
    const vec2 pixels_resolution = vec2(gl_NumWorkGroups.x, gl_NumWorkGroups.y);
    const ivec2  pos = ivec2(gl_GlobalInvocationID.xy);
    const vec2 coord = (vec2(gl_GlobalInvocationID.xy) + 0.5) / vec2(pixels_resolution);
    imageStore(u_image1, pos, texture(u_image0, coord));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform usampler2DArray u_image0;
layout (binding = 1, rgba32ui) writeonly uniform uimage2DArray u_image1;

void main (void)
{
    const vec2 pixels_resolution = vec2(gl_NumWorkGroups.x, gl_NumWorkGroups.y);
    const ivec3  pos = ivec3(gl_GlobalInvocationID.xyz);
    const vec2    v2 = (vec2(gl_GlobalInvocationID.xy) + 0.5) / vec2(pixels_resolution);
    const vec3 coord = vec3(v2, pos.z);
    imageStore(u_image1, pos, texture(u_image0, coord));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform usampler3D u_image0;
layout (binding = 1, rgba32ui) writeonly uniform uimage3D u_image1;

void main (void)
{
    const vec2 pixels_resolution = vec2(gl_NumWorkGroups.x, gl_NumWorkGroups.y);
    const ivec3  pos = ivec3(gl_GlobalInvocationID.xy, 0);
    const vec2    v2 = (vec2(gl_GlobalInvocationID.xy) + 0.5) / vec2(pixels_resolution);
    const vec3 coord = vec3(v2, 0.0);
    imageStore(u_image1, pos, texture(u_image0, coord));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform isampler1D u_image0;
layout (binding = 1, rgba32i) writeonly uniform iimage1D u_image1;

void main (void)
{
    const vec2 pixels_resolution = vec2(gl_NumWorkGroups.x, gl_NumWorkGroups.y);
    const int     pos = int(gl_GlobalInvocationID.x);
    const float coord = (float(gl_GlobalInvocationID.x) + 0.5) / pixels_resolution.x;
    imageStore(u_image1, pos, texture(u_image0, coord));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform isampler2D u_image0;
layout (binding = 1, rgba32i) writeonly uniform iimage2D u_image1;

void main (void)
{
    const vec2 pixels_resolution = vec2(gl_NumWorkGroups.x, gl_NumWorkGroups.y);
    const ivec2  pos = ivec2(gl_GlobalInvocationID.xy);
    const vec2 coord = (vec2(gl_GlobalInvocationID.xy) + 0.5) / vec2(pixels_resolution);
    imageStore(u_image1, pos, texture(u_image0, coord));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform isampler2DArray u_image0;
layout (binding = 1, rgba32i) writeonly uniform iimage2DArray u_image1;

void main (void)
{
    const vec2 pixels_resolution = vec2(gl_NumWorkGroups.x, gl_NumWorkGroups.y);
    const ivec3  pos = ivec3(gl_GlobalInvocationID.xyz);
    const vec2    v2 = (vec2(gl_GlobalInvocationID.xy) + 0.5) / vec2(pixels_resolution);
    const vec3 coord = vec3(v2, pos.z);
    imageStore(u_image1, pos, texture(u_image0, coord));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0) uniform isampler3D u_image0;
layout (binding = 1, rgba32i) writeonly uniform iimage3D u_image1;

void main (void)
{
    const vec2 pixels_resolution = vec2(gl_NumWorkGroups.x, gl_NumWorkGroups.y);
    const ivec3  pos = ivec3(gl_GlobalInvocationID.xy, 0);
    const vec2    v2 = (vec2(gl_GlobalInvocationID.xy) + 0.5) / vec2(pixels_resolution);
    const vec3 coord = vec3(v2, 0.0);
    imageStore(u_image1, pos, texture(u_image0, coord));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rgba16) uniform image1D           u_image0;
layout (binding = 1, rgba16) readonly uniform image1D  u_image1;
layout (binding = 2, rgba16) writeonly uniform image1D u_image2;

void main (void)
{
    highp int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image0, pos, imageLoad(u_image1, pos));
    imageStore(u_image2, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rgba16) uniform image2D           u_image0;
layout (binding = 1, rgba16) readonly uniform image2D  u_image1;
layout (binding = 2, rgba16) writeonly uniform image2D u_image2;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image0, pos, imageLoad(u_image1, pos));
    imageStore(u_image2, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rgba16) uniform image2DArray           u_image0;
layout (binding = 1, rgba16) readonly uniform image2DArray  u_image1;
layout (binding = 2, rgba16) writeonly uniform image2DArray u_image2;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image0, pos, imageLoad(u_image1, pos));
    imageStore(u_image2, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rgba16) uniform image3D           u_image0;
layout (binding = 1, rgba16) readonly uniform image3D  u_image1;
layout (binding = 2, rgba16) writeonly uniform image3D u_image2;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image0, pos, imageLoad(u_image1, pos));
    imageStore(u_image2, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rgba16_snorm) uniform image1D           u_image0;
layout (binding = 1, rgba16_snorm) readonly uniform image1D  u_image1;
layout (binding = 2, rgba16_snorm) writeonly uniform image1D u_image2;

void main (void)
{
    highp int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image0, pos, imageLoad(u_image1, pos));
    imageStore(u_image2, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rgba16_snorm) uniform image2D           u_image0;
layout (binding = 1, rgba16_snorm) readonly uniform image2D  u_image1;
layout (binding = 2, rgba16_snorm) writeonly uniform image2D u_image2;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image0, pos, imageLoad(u_image1, pos));
    imageStore(u_image2, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rgba16_snorm) uniform image2DArray           u_image0;
layout (binding = 1, rgba16_snorm) readonly uniform image2DArray  u_image1;
layout (binding = 2, rgba16_snorm) writeonly uniform image2DArray u_image2;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image0, pos, imageLoad(u_image1, pos));
    imageStore(u_image2, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rgba16_snorm) uniform image3D           u_image0;
layout (binding = 1, rgba16_snorm) readonly uniform image3D  u_image1;
layout (binding = 2, rgba16_snorm) writeonly uniform image3D u_image2;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image0, pos, imageLoad(u_image1, pos));
    imageStore(u_image2, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rgba16ui) uniform uimage1D           u_image0;
layout (binding = 1, rgba16ui) readonly uniform uimage1D  u_image1;
layout (binding = 2, rgba16ui) writeonly uniform uimage1D u_image2;

void main (void)
{
    highp int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image0, pos, imageLoad(u_image1, pos));
    imageStore(u_image2, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rgba16ui) uniform uimage2D           u_image0;
layout (binding = 1, rgba16ui) readonly uniform uimage2D  u_image1;
layout (binding = 2, rgba16ui) writeonly uniform uimage2D u_image2;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image0, pos, imageLoad(u_image1, pos));
    imageStore(u_image2, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rgba16ui) uniform uimage2DArray           u_image0;
layout (binding = 1, rgba16ui) readonly uniform uimage2DArray  u_image1;
layout (binding = 2, rgba16ui) writeonly uniform uimage2DArray u_image2;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image0, pos, imageLoad(u_image1, pos));
    imageStore(u_image2, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rgba16ui) uniform uimage3D           u_image0;
layout (binding = 1, rgba16ui) readonly uniform uimage3D  u_image1;
layout (binding = 2, rgba16ui) writeonly uniform uimage3D u_image2;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image0, pos, imageLoad(u_image1, pos));
    imageStore(u_image2, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rgba16i) uniform iimage1D           u_image0;
layout (binding = 1, rgba16i) readonly uniform iimage1D  u_image1;
layout (binding = 2, rgba16i) writeonly uniform iimage1D u_image2;

void main (void)
{
    highp int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image0, pos, imageLoad(u_image1, pos));
    imageStore(u_image2, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rgba16i) uniform iimage2D           u_image0;
layout (binding = 1, rgba16i) readonly uniform iimage2D  u_image1;
layout (binding = 2, rgba16i) writeonly uniform iimage2D u_image2;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image0, pos, imageLoad(u_image1, pos));
    imageStore(u_image2, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rgba16i) uniform iimage2DArray           u_image0;
layout (binding = 1, rgba16i) readonly uniform iimage2DArray  u_image1;
layout (binding = 2, rgba16i) writeonly uniform iimage2DArray u_image2;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image0, pos, imageLoad(u_image1, pos));
    imageStore(u_image2, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rgba16i) uniform iimage3D           u_image0;
layout (binding = 1, rgba16i) readonly uniform iimage3D  u_image1;
layout (binding = 2, rgba16i) writeonly uniform iimage3D u_image2;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image0, pos, imageLoad(u_image1, pos));
    imageStore(u_image2, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rg32ui) uniform uimage1D           u_image0;
layout (binding = 1, rg32ui) readonly uniform uimage1D  u_image1;
layout (binding = 2, rg32ui) writeonly uniform uimage1D u_image2;

void main (void)
{
    highp int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image0, pos, imageLoad(u_image1, pos));
    imageStore(u_image2, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rg32ui) uniform uimage2D           u_image0;
layout (binding = 1, rg32ui) readonly uniform uimage2D  u_image1;
layout (binding = 2, rg32ui) writeonly uniform uimage2D u_image2;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image0, pos, imageLoad(u_image1, pos));
    imageStore(u_image2, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rg32ui) uniform uimage2DArray           u_image0;
layout (binding = 1, rg32ui) readonly uniform uimage2DArray  u_image1;
layout (binding = 2, rg32ui) writeonly uniform uimage2DArray u_image2;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image0, pos, imageLoad(u_image1, pos));
    imageStore(u_image2, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rg32ui) uniform uimage3D           u_image0;
layout (binding = 1, rg32ui) readonly uniform uimage3D  u_image1;
layout (binding = 2, rg32ui) writeonly uniform uimage3D u_image2;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image0, pos, imageLoad(u_image1, pos));
    imageStore(u_image2, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rg32i) uniform iimage1D           u_image0;
layout (binding = 1, rg32i) readonly uniform iimage1D  u_image1;
layout (binding = 2, rg32i) writeonly uniform iimage1D u_image2;

void main (void)
{
    highp int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image0, pos, imageLoad(u_image1, pos));
    imageStore(u_image2, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rg32i) uniform iimage2D           u_image0;
layout (binding = 1, rg32i) readonly uniform iimage2D  u_image1;
layout (binding = 2, rg32i) writeonly uniform iimage2D u_image2;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image0, pos, imageLoad(u_image1, pos));
    imageStore(u_image2, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rg32i) uniform iimage2DArray           u_image0;
layout (binding = 1, rg32i) readonly uniform iimage2DArray  u_image1;
layout (binding = 2, rg32i) writeonly uniform iimage2DArray u_image2;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image0, pos, imageLoad(u_image1, pos));
    imageStore(u_image2, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rg32i) uniform iimage3D           u_image0;
layout (binding = 1, rg32i) readonly uniform iimage3D  u_image1;
layout (binding = 2, rg32i) writeonly uniform iimage3D u_image2;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image0, pos, imageLoad(u_image1, pos));
    imageStore(u_image2, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rgba32ui) uniform uimage1D           u_image0;
layout (binding = 1, rgba32ui) readonly uniform uimage1D  u_image1;
layout (binding = 2, rgba32ui) writeonly uniform uimage1D u_image2;

void main (void)
{
    highp int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image0, pos, imageLoad(u_image1, pos));
    imageStore(u_image2, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rgba32ui) uniform uimage2D           u_image0;
layout (binding = 1, rgba32ui) readonly uniform uimage2D  u_image1;
layout (binding = 2, rgba32ui) writeonly uniform uimage2D u_image2;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image0, pos, imageLoad(u_image1, pos));
    imageStore(u_image2, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rgba32ui) uniform uimage2DArray           u_image0;
layout (binding = 1, rgba32ui) readonly uniform uimage2DArray  u_image1;
layout (binding = 2, rgba32ui) writeonly uniform uimage2DArray u_image2;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image0, pos, imageLoad(u_image1, pos));
    imageStore(u_image2, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rgba32ui) uniform uimage3D           u_image0;
layout (binding = 1, rgba32ui) readonly uniform uimage3D  u_image1;
layout (binding = 2, rgba32ui) writeonly uniform uimage3D u_image2;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image0, pos, imageLoad(u_image1, pos));
    imageStore(u_image2, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rgba32i) uniform iimage1D           u_image0;
layout (binding = 1, rgba32i) readonly uniform iimage1D  u_image1;
layout (binding = 2, rgba32i) writeonly uniform iimage1D u_image2;

void main (void)
{
    highp int pos = int(gl_GlobalInvocationID.x);
    imageStore(u_image0, pos, imageLoad(u_image1, pos));
    imageStore(u_image2, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rgba32i) uniform iimage2D           u_image0;
layout (binding = 1, rgba32i) readonly uniform iimage2D  u_image1;
layout (binding = 2, rgba32i) writeonly uniform iimage2D u_image2;

void main (void)
{
    ivec2 pos = ivec2(gl_GlobalInvocationID.xy);
    imageStore(u_image0, pos, imageLoad(u_image1, pos));
    imageStore(u_image2, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rgba32i) uniform iimage2DArray           u_image0;
layout (binding = 1, rgba32i) readonly uniform iimage2DArray  u_image1;
layout (binding = 2, rgba32i) writeonly uniform iimage2DArray u_image2;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image0, pos, imageLoad(u_image1, pos));
    imageStore(u_image2, pos, imageLoad(u_image0, pos));
}
#version 450

layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout (binding = 0, rgba32i) uniform iimage3D           u_image0;
layout (binding = 1, rgba32i) readonly uniform iimage3D  u_image1;
layout (binding = 2, rgba32i) writeonly uniform iimage3D u_image2;

void main (void)
{
    ivec3 pos = ivec3(gl_GlobalInvocationID);
    imageStore(u_image0, pos, imageLoad(u_image1, pos));
    imageStore(u_image2, pos, imageLoad(u_image0, pos));
}
#version 450

layout(location = 0) in vec4 v_in_position;

void main (void)
{
    gl_Position = v_in_position;
}
#version 450

precision highp int;
precision highp float;

layout (location = 0) out highp vec4 o_color;
layout (input_attachment_index = 0, set = 0, binding = 0) uniform highp subpassInput inputImage1;

void main (void)
{
    o_color = vec4(subpassLoad(inputImage1));
}
#version 450

layout (binding = 0) uniform sampler1D u_imageIn0;
layout (binding = 1) uniform sampler1D u_imageIn1;
layout (binding = 2, rgba8) writeonly uniform image1D u_imageOut0;
layout (binding = 3, rgba8) writeonly uniform image1D u_imageOut1;

void main (void)
{
    const highp int out_pos = int(gl_FragCoord.x);
    const highp float pixels_resolution0 = textureSize(u_imageIn0, 0);
    const highp float in_pos0 = gl_FragCoord.x / pixels_resolution0;
    imageStore(u_imageOut0, out_pos, texture(u_imageIn0, in_pos0));

    const highp float pixels_resolution1 = textureSize(u_imageIn1, 0);
    const highp float in_pos1 = gl_FragCoord.x / pixels_resolution1;
    imageStore(u_imageOut1, out_pos, texture(u_imageIn1, in_pos1));
}
#version 450

layout (binding = 0) uniform sampler2D u_imageIn0;
layout (binding = 1) uniform sampler2D u_imageIn1;
layout (binding = 2, rgba8) writeonly uniform image2D u_imageOut0;
layout (binding = 3, rgba8) writeonly uniform image2D u_imageOut1;

void main (void)
{
    const ivec2 out_pos = ivec2(gl_FragCoord.xy);
    const vec2 pixels_resolution0 = vec2(textureSize(u_imageIn0, 0));
    const vec2 in_pos0 = vec2(gl_FragCoord.xy) / vec2(pixels_resolution0);
    imageStore(u_imageOut0, out_pos, texture(u_imageIn0, in_pos0));

    const vec2 pixels_resolution1 = vec2(textureSize(u_imageIn1, 0));
    const vec2 in_pos1 = vec2(gl_FragCoord.xy) / vec2(pixels_resolution1);
    imageStore(u_imageOut1, out_pos, texture(u_imageIn1, in_pos1));
}
#version 450

precision highp int;
precision highp float;

layout (location = 0) out highp uvec4 o_color;
layout (input_attachment_index = 0, set = 0, binding = 0) uniform highp usubpassInput inputImage1;

void main (void)
{
    o_color = uvec4(subpassLoad(inputImage1));
}
#version 450

precision highp int;
precision highp float;

layout (location = 0) out highp ivec4 o_color;
layout (input_attachment_index = 0, set = 0, binding = 0) uniform highp isubpassInput inputImage1;

void main (void)
{
    o_color = ivec4(subpassLoad(inputImage1));
}
#version 450

precision highp int;
precision highp float;

layout (location = 0) out highp uvec2 o_color;
layout (input_attachment_index = 0, set = 0, binding = 0) uniform highp usubpassInput inputImage1;

void main (void)
{
    o_color = uvec2(subpassLoad(inputImage1));
}
#version 450

precision highp int;
precision highp float;

layout (location = 0) out highp ivec2 o_color;
layout (input_attachment_index = 0, set = 0, binding = 0) uniform highp isubpassInput inputImage1;

void main (void)
{
    o_color = ivec2(subpassLoad(inputImage1));
}
#version 450

layout (binding = 0) uniform sampler1D u_imageIn;
layout (binding = 1, rgba16) writeonly uniform image1D u_imageOut;

void main (void)
{
    const highp int out_pos = int(gl_FragCoord.x);
    const highp float pixels_resolution = textureSize(u_imageIn, 0);
    const highp float in_pos = gl_FragCoord.x / pixels_resolution;
    imageStore(u_imageOut, out_pos, texture(u_imageIn, in_pos));
}
#version 450

layout (binding = 0) uniform sampler2D u_imageIn;
layout (binding = 1, rgba16) writeonly uniform image2D u_imageOut;

void main (void)
{
    const ivec2 out_pos = ivec2(gl_FragCoord.xy);
    const vec2 pixels_resolution = vec2(textureSize(u_imageIn, 0));
    const vec2 in_pos = vec2(gl_FragCoord.xy) / vec2(pixels_resolution);
    imageStore(u_imageOut, out_pos, texture(u_imageIn, in_pos));
}
#version 450

layout (binding = 0) uniform sampler3D u_imageIn;
layout (binding = 1, rgba16) writeonly uniform image3D u_imageOut;

void main (void)
{
    const ivec3 out_pos = ivec3(gl_FragCoord.xy, 0);
    const vec3 pixels_resolution = vec3(textureSize(u_imageIn, 0));
    const vec3 in_pos = vec3(gl_FragCoord.xy, 0) / vec3(pixels_resolution.xy, 1.0);
    imageStore(u_imageOut, out_pos, texture(u_imageIn, in_pos));
}
#version 450

layout (binding = 0) uniform sampler3D u_imageIn0;
layout (binding = 1) uniform sampler3D u_imageIn1;
layout (binding = 2, rgba8) writeonly uniform image3D u_imageOut0;
layout (binding = 3, rgba8) writeonly uniform image3D u_imageOut1;

void main (void)
{
    const ivec3 out_pos = ivec3(ivec2(gl_FragCoord.xy), 0);
    const vec3 pixels_resolution0 = vec3(textureSize(u_imageIn0, 0));
    const vec3 in_pos0 = vec3(gl_FragCoord.xy, 0) / vec3(pixels_resolution0.xy, 1.0);
    imageStore(u_imageOut0, out_pos, texture(u_imageIn0, in_pos0));

    const vec3 pixels_resolution1 = vec3(textureSize(u_imageIn1, 0));
    const vec3 in_pos1 = vec3(gl_FragCoord.xy, 0) / vec3(pixels_resolution1.xy, 1.0);
    imageStore(u_imageOut1, out_pos, texture(u_imageIn1, in_pos1));
}
#version 450

layout (binding = 0) uniform sampler1D u_imageIn;
layout (binding = 1, rgba16_snorm) writeonly uniform image1D u_imageOut;

void main (void)
{
    const highp int out_pos = int(gl_FragCoord.x);
    const highp float pixels_resolution = textureSize(u_imageIn, 0);
    const highp float in_pos = gl_FragCoord.x / pixels_resolution;
    imageStore(u_imageOut, out_pos, texture(u_imageIn, in_pos));
}
#version 450

layout (binding = 0) uniform sampler2D u_imageIn;
layout (binding = 1, rgba16_snorm) writeonly uniform image2D u_imageOut;

void main (void)
{
    const ivec2 out_pos = ivec2(gl_FragCoord.xy);
    const vec2 pixels_resolution = vec2(textureSize(u_imageIn, 0));
    const vec2 in_pos = vec2(gl_FragCoord.xy) / vec2(pixels_resolution);
    imageStore(u_imageOut, out_pos, texture(u_imageIn, in_pos));
}
#version 450

layout (binding = 0) uniform sampler3D u_imageIn;
layout (binding = 1, rgba16_snorm) writeonly uniform image3D u_imageOut;

void main (void)
{
    const ivec3 out_pos = ivec3(gl_FragCoord.xy, 0);
    const vec3 pixels_resolution = vec3(textureSize(u_imageIn, 0));
    const vec3 in_pos = vec3(gl_FragCoord.xy, 0) / vec3(pixels_resolution.xy, 1.0);
    imageStore(u_imageOut, out_pos, texture(u_imageIn, in_pos));
}
#version 450

layout (binding = 0) uniform usampler1D u_imageIn;
layout (binding = 1, rgba16ui) writeonly uniform uimage1D u_imageOut;

void main (void)
{
    const highp int out_pos = int(gl_FragCoord.x);
    const highp float pixels_resolution = textureSize(u_imageIn, 0);
    const highp float in_pos = gl_FragCoord.x / pixels_resolution;
    imageStore(u_imageOut, out_pos, texture(u_imageIn, in_pos));
}
#version 450

layout (binding = 0) uniform usampler2D u_imageIn;
layout (binding = 1, rgba16ui) writeonly uniform uimage2D u_imageOut;

void main (void)
{
    const ivec2 out_pos = ivec2(gl_FragCoord.xy);
    const vec2 pixels_resolution = vec2(textureSize(u_imageIn, 0));
    const vec2 in_pos = vec2(gl_FragCoord.xy) / vec2(pixels_resolution);
    imageStore(u_imageOut, out_pos, texture(u_imageIn, in_pos));
}
#version 450

layout (binding = 0) uniform usampler3D u_imageIn;
layout (binding = 1, rgba16ui) writeonly uniform uimage3D u_imageOut;

void main (void)
{
    const ivec3 out_pos = ivec3(gl_FragCoord.xy, 0);
    const vec3 pixels_resolution = vec3(textureSize(u_imageIn, 0));
    const vec3 in_pos = vec3(gl_FragCoord.xy, 0) / vec3(pixels_resolution.xy, 1.0);
    imageStore(u_imageOut, out_pos, texture(u_imageIn, in_pos));
}
#version 450

layout (binding = 0) uniform isampler1D u_imageIn;
layout (binding = 1, rgba16i) writeonly uniform iimage1D u_imageOut;

void main (void)
{
    const highp int out_pos = int(gl_FragCoord.x);
    const highp float pixels_resolution = textureSize(u_imageIn, 0);
    const highp float in_pos = gl_FragCoord.x / pixels_resolution;
    imageStore(u_imageOut, out_pos, texture(u_imageIn, in_pos));
}
#version 450

layout (binding = 0) uniform isampler2D u_imageIn;
layout (binding = 1, rgba16i) writeonly uniform iimage2D u_imageOut;

void main (void)
{
    const ivec2 out_pos = ivec2(gl_FragCoord.xy);
    const vec2 pixels_resolution = vec2(textureSize(u_imageIn, 0));
    const vec2 in_pos = vec2(gl_FragCoord.xy) / vec2(pixels_resolution);
    imageStore(u_imageOut, out_pos, texture(u_imageIn, in_pos));
}
#version 450

layout (binding = 0) uniform isampler3D u_imageIn;
layout (binding = 1, rgba16i) writeonly uniform iimage3D u_imageOut;

void main (void)
{
    const ivec3 out_pos = ivec3(gl_FragCoord.xy, 0);
    const vec3 pixels_resolution = vec3(textureSize(u_imageIn, 0));
    const vec3 in_pos = vec3(gl_FragCoord.xy, 0) / vec3(pixels_resolution.xy, 1.0);
    imageStore(u_imageOut, out_pos, texture(u_imageIn, in_pos));
}
#version 450

layout (binding = 0) uniform usampler1D u_imageIn;
layout (binding = 1, rg32ui) writeonly uniform uimage1D u_imageOut;

void main (void)
{
    const highp int out_pos = int(gl_FragCoord.x);
    const highp float pixels_resolution = textureSize(u_imageIn, 0);
    const highp float in_pos = gl_FragCoord.x / pixels_resolution;
    imageStore(u_imageOut, out_pos, texture(u_imageIn, in_pos));
}
#version 450

layout (binding = 0) uniform usampler2D u_imageIn;
layout (binding = 1, rg32ui) writeonly uniform uimage2D u_imageOut;

void main (void)
{
    const ivec2 out_pos = ivec2(gl_FragCoord.xy);
    const vec2 pixels_resolution = vec2(textureSize(u_imageIn, 0));
    const vec2 in_pos = vec2(gl_FragCoord.xy) / vec2(pixels_resolution);
    imageStore(u_imageOut, out_pos, texture(u_imageIn, in_pos));
}
#version 450

layout (binding = 0) uniform usampler3D u_imageIn;
layout (binding = 1, rg32ui) writeonly uniform uimage3D u_imageOut;

void main (void)
{
    const ivec3 out_pos = ivec3(gl_FragCoord.xy, 0);
    const vec3 pixels_resolution = vec3(textureSize(u_imageIn, 0));
    const vec3 in_pos = vec3(gl_FragCoord.xy, 0) / vec3(pixels_resolution.xy, 1.0);
    imageStore(u_imageOut, out_pos, texture(u_imageIn, in_pos));
}
#version 450

layout (binding = 0) uniform isampler1D u_imageIn;
layout (binding = 1, rg32i) writeonly uniform iimage1D u_imageOut;

void main (void)
{
    const highp int out_pos = int(gl_FragCoord.x);
    const highp float pixels_resolution = textureSize(u_imageIn, 0);
    const highp float in_pos = gl_FragCoord.x / pixels_resolution;
    imageStore(u_imageOut, out_pos, texture(u_imageIn, in_pos));
}
#version 450

layout (binding = 0) uniform isampler2D u_imageIn;
layout (binding = 1, rg32i) writeonly uniform iimage2D u_imageOut;

void main (void)
{
    const ivec2 out_pos = ivec2(gl_FragCoord.xy);
    const vec2 pixels_resolution = vec2(textureSize(u_imageIn, 0));
    const vec2 in_pos = vec2(gl_FragCoord.xy) / vec2(pixels_resolution);
    imageStore(u_imageOut, out_pos, texture(u_imageIn, in_pos));
}
#version 450

layout (binding = 0) uniform isampler3D u_imageIn;
layout (binding = 1, rg32i) writeonly uniform iimage3D u_imageOut;

void main (void)
{
    const ivec3 out_pos = ivec3(gl_FragCoord.xy, 0);
    const vec3 pixels_resolution = vec3(textureSize(u_imageIn, 0));
    const vec3 in_pos = vec3(gl_FragCoord.xy, 0) / vec3(pixels_resolution.xy, 1.0);
    imageStore(u_imageOut, out_pos, texture(u_imageIn, in_pos));
}
#version 450

layout (binding = 0) uniform usampler1D u_imageIn;
layout (binding = 1, rgba32ui) writeonly uniform uimage1D u_imageOut;

void main (void)
{
    const highp int out_pos = int(gl_FragCoord.x);
    const highp float pixels_resolution = textureSize(u_imageIn, 0);
    const highp float in_pos = gl_FragCoord.x / pixels_resolution;
    imageStore(u_imageOut, out_pos, texture(u_imageIn, in_pos));
}
#version 450

layout (binding = 0) uniform usampler2D u_imageIn;
layout (binding = 1, rgba32ui) writeonly uniform uimage2D u_imageOut;

void main (void)
{
    const ivec2 out_pos = ivec2(gl_FragCoord.xy);
    const vec2 pixels_resolution = vec2(textureSize(u_imageIn, 0));
    const vec2 in_pos = vec2(gl_FragCoord.xy) / vec2(pixels_resolution);
    imageStore(u_imageOut, out_pos, texture(u_imageIn, in_pos));
}
#version 450

layout (binding = 0) uniform usampler3D u_imageIn;
layout (binding = 1, rgba32ui) writeonly uniform uimage3D u_imageOut;

void main (void)
{
    const ivec3 out_pos = ivec3(gl_FragCoord.xy, 0);
    const vec3 pixels_resolution = vec3(textureSize(u_imageIn, 0));
    const vec3 in_pos = vec3(gl_FragCoord.xy, 0) / vec3(pixels_resolution.xy, 1.0);
    imageStore(u_imageOut, out_pos, texture(u_imageIn, in_pos));
}
#version 450

layout (binding = 0) uniform isampler1D u_imageIn;
layout (binding = 1, rgba32i) writeonly uniform iimage1D u_imageOut;

void main (void)
{
    const highp int out_pos = int(gl_FragCoord.x);
    const highp float pixels_resolution = textureSize(u_imageIn, 0);
    const highp float in_pos = gl_FragCoord.x / pixels_resolution;
    imageStore(u_imageOut, out_pos, texture(u_imageIn, in_pos));
}
#version 450

layout (binding = 0) uniform isampler2D u_imageIn;
layout (binding = 1, rgba32i) writeonly uniform iimage2D u_imageOut;

void main (void)
{
    const ivec2 out_pos = ivec2(gl_FragCoord.xy);
    const vec2 pixels_resolution = vec2(textureSize(u_imageIn, 0));
    const vec2 in_pos = vec2(gl_FragCoord.xy) / vec2(pixels_resolution);
    imageStore(u_imageOut, out_pos, texture(u_imageIn, in_pos));
}
#version 450

layout (binding = 0) uniform isampler3D u_imageIn;
layout (binding = 1, rgba32i) writeonly uniform iimage3D u_imageOut;

void main (void)
{
    const ivec3 out_pos = ivec3(gl_FragCoord.xy, 0);
    const vec3 pixels_resolution = vec3(textureSize(u_imageIn, 0));
    const vec3 in_pos = vec3(gl_FragCoord.xy, 0) / vec3(pixels_resolution.xy, 1.0);
    imageStore(u_imageOut, out_pos, texture(u_imageIn, in_pos));
}
