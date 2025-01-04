#version 450
#extension GL_EXT_buffer_reference2 : require
#extension GL_EXT_buffer_reference_uvec2 : require
#extension GL_EXT_scalar_block_layout : require
layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (buffer_reference) buffer srcBuffer;
layout (buffer_reference, buffer_reference_align=4, std430) readonly buffer srcBuffer
{
    uint values[];
};

layout (buffer_reference) buffer dstBuffer;
layout (buffer_reference, buffer_reference_align=4, std430) writeonly buffer dstBuffer
{
    uint values[];
};

layout(push_constant, std430) uniform push_cb
{
    uvec2 srcBufferAddress;
    uvec2 dstBufferAddress;
} pc;

void main()
{
    const uint idx = gl_WorkGroupID.x;
    dstBuffer(pc.dstBufferAddress).values[idx] = srcBuffer(pc.srcBufferAddress).values[idx];
}
#version 450
#extension GL_EXT_buffer_reference2 : require
#extension GL_EXT_buffer_reference_uvec2 : require
#extension GL_EXT_scalar_block_layout : require
layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=0, binding=0, std430) readonly buffer SrcBufferBlock {
    uint values[];
} srcBuffer;

layout (set=0, binding=1, std430) writeonly buffer DstBufferBlock {
    uint values[];
} dstBuffer;

void main()
{
    const uint idx = gl_WorkGroupID.x;
    dstBuffer.values[idx] = srcBuffer.values[idx];
}
#version 450
#extension GL_EXT_buffer_reference2 : require
#extension GL_EXT_buffer_reference_uvec2 : require
#extension GL_EXT_scalar_block_layout : require
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;

layout (buffer_reference) buffer srcBuffer;
layout (buffer_reference, buffer_reference_align=4, std430) readonly buffer srcBuffer
{
    uint values[];
};

layout (buffer_reference) buffer dstBuffer;
layout (buffer_reference, buffer_reference_align=4, std430) writeonly buffer dstBuffer
{
    uint values[];
};

layout(push_constant, std430) uniform push_cb
{
    uvec2 srcBufferAddress;
    uvec2 dstBufferAddress;
} pc;

void main()
{
    const uint idx = gl_LocalInvocationIndex;
    dstBuffer(pc.dstBufferAddress).values[idx] = srcBuffer(pc.srcBufferAddress).values[idx];
}
#version 450
#extension GL_EXT_buffer_reference2 : require
#extension GL_EXT_buffer_reference_uvec2 : require
#extension GL_EXT_scalar_block_layout : require
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;

layout (set=0, binding=0, std430) readonly buffer SrcBufferBlock {
    uint values[];
} srcBuffer;

layout (set=0, binding=1, std430) writeonly buffer DstBufferBlock {
    uint values[];
} dstBuffer;

void main()
{
    const uint idx = gl_LocalInvocationIndex;
    dstBuffer.values[idx] = srcBuffer.values[idx];
}
#version 450
#extension GL_EXT_buffer_reference2 : require
#extension GL_EXT_buffer_reference_uvec2 : require
#extension GL_EXT_scalar_block_layout : require
layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=0, binding=0, std430) uniform SrcBufferBlock {
    uint values[64];
} srcBuffer;

layout (set=0, binding=1, std430) writeonly buffer DstBufferBlock {
    uint values[];
} dstBuffer;

void main()
{
    const uint idx = gl_WorkGroupID.x;
    dstBuffer.values[idx] = srcBuffer.values[idx];
}
#version 450
#extension GL_EXT_buffer_reference2 : require
#extension GL_EXT_buffer_reference_uvec2 : require
#extension GL_EXT_scalar_block_layout : require
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;

layout (set=0, binding=0, std430) uniform SrcBufferBlock {
    uint values[64];
} srcBuffer;

layout (set=0, binding=1, std430) writeonly buffer DstBufferBlock {
    uint values[];
} dstBuffer;

void main()
{
    const uint idx = gl_LocalInvocationIndex;
    dstBuffer.values[idx] = srcBuffer.values[idx];
}
#version 450
#extension GL_EXT_buffer_reference2 : require
#extension GL_EXT_buffer_reference_uvec2 : require
#extension GL_EXT_scalar_block_layout : require
layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=0, binding=0, r32ui) uniform uimageBuffer srcBuffer;
layout (set=0, binding=1, std430) writeonly buffer DstBufferBlock {
    uint values[];
} dstBuffer;

void main()
{
    const uint idx = gl_WorkGroupID.x;
    dstBuffer.values[idx] = imageLoad(srcBuffer, int(idx)).x;
}
#version 450
#extension GL_EXT_buffer_reference2 : require
#extension GL_EXT_buffer_reference_uvec2 : require
#extension GL_EXT_scalar_block_layout : require
layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=0, binding=0, std430) readonly buffer SrcBufferBlock {
    uint values[];
} srcBuffer;

layout (set=0, binding=1, r32ui) uniform uimageBuffer dstBuffer;
void main()
{
    const uint idx = gl_WorkGroupID.x;
    imageStore(dstBuffer, int(idx), ivec4(srcBuffer.values[idx], 0u, 0u, 0u));
}
#version 450
#extension GL_EXT_buffer_reference2 : require
#extension GL_EXT_buffer_reference_uvec2 : require
#extension GL_EXT_scalar_block_layout : require
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;

layout (set=0, binding=0, r32ui) uniform uimageBuffer srcBuffer;
layout (set=0, binding=1, std430) writeonly buffer DstBufferBlock {
    uint values[];
} dstBuffer;

void main()
{
    const uint idx = gl_LocalInvocationIndex;
    dstBuffer.values[idx] = imageLoad(srcBuffer, int(idx)).x;
}
#version 450
#extension GL_EXT_buffer_reference2 : require
#extension GL_EXT_buffer_reference_uvec2 : require
#extension GL_EXT_scalar_block_layout : require
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;

layout (set=0, binding=0, std430) readonly buffer SrcBufferBlock {
    uint values[];
} srcBuffer;

layout (set=0, binding=1, r32ui) uniform uimageBuffer dstBuffer;
void main()
{
    const uint idx = gl_LocalInvocationIndex;
    imageStore(dstBuffer, int(idx), ivec4(srcBuffer.values[idx], 0u, 0u, 0u));
}
#version 450
#extension GL_EXT_buffer_reference2 : require
#extension GL_EXT_buffer_reference_uvec2 : require
#extension GL_EXT_scalar_block_layout : require
layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=0, binding=0) uniform utextureBuffer srcBuffer;
layout (set=0, binding=1, std430) writeonly buffer DstBufferBlock {
    uint values[];
} dstBuffer;

void main()
{
    const uint idx = gl_WorkGroupID.x;
    dstBuffer.values[idx] = texelFetch(srcBuffer, int(idx)).x;
}
#version 450
#extension GL_EXT_buffer_reference2 : require
#extension GL_EXT_buffer_reference_uvec2 : require
#extension GL_EXT_scalar_block_layout : require
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;

layout (set=0, binding=0) uniform utextureBuffer srcBuffer;
layout (set=0, binding=1, std430) writeonly buffer DstBufferBlock {
    uint values[];
} dstBuffer;

void main()
{
    const uint idx = gl_LocalInvocationIndex;
    dstBuffer.values[idx] = texelFetch(srcBuffer, int(idx)).x;
}
