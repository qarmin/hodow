#version 450
precision highp int;
#extension GL_KHR_shader_subgroup_basic: enable
layout(location = 0) out uint out_color;
void main()
{
uint tempResult = gl_SubgroupSize;
     out_color = tempResult;
}
