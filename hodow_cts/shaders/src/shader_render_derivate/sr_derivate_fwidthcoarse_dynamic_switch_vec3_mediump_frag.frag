#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in mediump vec3 v_coord;
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { mediump vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { mediump vec3 u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    mediump vec3 res;
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    switch (int(quad_uniform))
    {
        case 0: res = fwidthCoarse(v_coord) * u_scale + u_bias;    break;
        case 1: res = fwidthCoarse(v_coord * float(ui_one)) * u_scale + u_bias;    break;
    }
    o_color = vec4(res, 1.0);
}
