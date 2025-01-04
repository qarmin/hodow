#version 450
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_KHR_shader_subgroup_ballot : enable
layout(std430, binding = 0) buffer Outputs { uint sizes[]; };
layout(local_size_x_id = 0) in;
void main()
{
    if (subgroupElect())
    {
        sizes[gl_WorkGroupID.x * gl_NumSubgroups + gl_SubgroupID] = gl_SubgroupSize;
    }
}
