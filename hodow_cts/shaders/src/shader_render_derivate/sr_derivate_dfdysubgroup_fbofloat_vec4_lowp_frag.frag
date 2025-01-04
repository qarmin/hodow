#version 450
#extension GL_KHR_shader_subgroup_quad : require
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in lowp vec4 v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { lowp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { lowp vec4 u_bias; };
vec4 dFdySubgroup(vec4 f)
{
    vec4 top, bottom;
    if ((gl_SubgroupInvocationID & 1) == 0) {
        top = subgroupQuadBroadcast(f, 0);
        bottom = subgroupQuadBroadcast(f, 2);
    } else {
        top = subgroupQuadBroadcast(f, 1);
        bottom = subgroupQuadBroadcast(f, 3);
    }
    return bottom - top;
}

void main (void)
{
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    lowp vec4 res = dFdySubgroup(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(res);
}
