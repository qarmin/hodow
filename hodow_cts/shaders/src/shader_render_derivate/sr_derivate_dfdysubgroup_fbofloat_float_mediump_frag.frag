#version 450
#extension GL_KHR_shader_subgroup_quad : require
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump float v_coord;
layout(location = 0) out highp uvec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump float u_scale; };
layout(binding = 1, std140) uniform Bias { mediump float u_bias; };
float dFdySubgroup(float f)
{
    float top, bottom;
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
    mediump float res = dFdySubgroup(v_coord) * u_scale + u_bias;
    o_color = floatBitsToUint(vec4(res, 0.0, 0.0, 1.0));
}
