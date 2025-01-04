#version 450
#extension GL_KHR_shader_subgroup_ballot : require
layout(location = 0) in highp float v_coord;
layout(location = 0) out highp vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp float u_scale; };
layout(binding = 1, std140) uniform Bias { highp float u_bias; };
layout(binding = 2, std140) uniform Ui_one { int ui_one; };
void main (void)
{
    highp float res = float(0.0);
    bool non_uniform = ((uint(gl_FragCoord.x * 0.4) + uint(gl_FragCoord.y * 0.3)) & 2) != 0;
    uvec4 quad_ballot = uvec4(0);
    quad_ballot[gl_SubgroupInvocationID >> 5] = 0xf << (gl_SubgroupInvocationID & 0x1c);
    bool quad_uniform = (subgroupBallot(non_uniform) & quad_ballot) == quad_ballot;
    for (int i = 0; i < ui_one + int(quad_uniform); i++)
        res = dFdxCoarse(v_coord * float(i - int(quad_uniform) + 1));
    res = res * u_scale + u_bias;
    o_color = vec4(res, 0.0, 0.0, 1.0);
}
