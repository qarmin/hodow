#version 460
layout (set=0, binding=0) buffer OutputBufferBlock { uint results[]; } output_buffer;
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
void main (void)
{
    const uint totalWorkGroupSize     = gl_WorkGroupSize.x * gl_WorkGroupSize.y * gl_WorkGroupSize.z;
    const uint workGroupIndex         = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z + gl_NumWorkGroups.x * gl_WorkGroupID.y + gl_WorkGroupID.x;
    const uint globalInvocationIndex  = workGroupIndex * totalWorkGroupSize + gl_LocalInvocationIndex;

    const uint offset = 0;
    output_buffer.results[globalInvocationIndex] = uint(sqrt(float(globalInvocationIndex))) + offset;
}
#version 460
layout (set=0, binding=0) buffer OutputBufferBlock { uint results[]; } output_buffer;
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (push_constant, std430) uniform PCBlock { uint value; } pc;
void main (void)
{
    const uint totalWorkGroupSize     = gl_WorkGroupSize.x * gl_WorkGroupSize.y * gl_WorkGroupSize.z;
    const uint workGroupIndex         = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z + gl_NumWorkGroups.x * gl_WorkGroupID.y + gl_WorkGroupID.x;
    const uint globalInvocationIndex  = workGroupIndex * totalWorkGroupSize + gl_LocalInvocationIndex;

    const uint offset = pc.value;
    output_buffer.results[globalInvocationIndex] = uint(sqrt(float(globalInvocationIndex))) + offset;
}
