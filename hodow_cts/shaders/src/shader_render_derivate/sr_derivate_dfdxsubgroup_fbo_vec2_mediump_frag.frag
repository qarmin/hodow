#version 450
#extension GL_KHR_shader_subgroup_ballot : require
#extension GL_KHR_shader_subgroup_quad : require
layout(location = 0) in mediump vec2 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec2 u_bias; };
vec2 dFdxSubgroup(vec2 f)
{
    vec2 left, right;
    if ((gl_SubgroupInvocationID & 2) == 0) {
        left = subgroupQuadBroadcast(f, 0);
        right = subgroupQuadBroadcast(f, 1);
    } else {
        left = subgroupQuadBroadcast(f, 2);
        right = subgroupQuadBroadcast(f, 3);
    }
    return right - left;
}

void main (void)
{
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    mediump vec2 res = dFdxSubgroup(v_coord) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
