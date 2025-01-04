#version 460
#pragma use_vulkan_memory_model
#extension GL_EXT_demote_to_helper_invocation : require
#extension GL_KHR_shader_subgroup_quad : require

layout(binding = 0) readonly buffer Block0
{
    float alpha[];
};

layout(binding = 1) buffer Block1
{
    uint atomics[];
};

layout(location = 0) out vec4 color;

float build_alpha_shuffle(float v)
{
    v = (gl_HelperInvocation ? 8.0 : roundEven(v));
    vec4 helpers;
    helpers.x = subgroupQuadBroadcast(v, 0u);
    helpers.y = subgroupQuadBroadcast(v, 1u);
    helpers.z = subgroupQuadBroadcast(v, 2u);
    helpers.w = subgroupQuadBroadcast(v, 3u);

    return dot(helpers, vec4(1, 10, 100, 1000));
}

void main()
{
    ivec2 coord = ivec2(gl_FragCoord.xy);
    int linear_coord = coord.y * 2 + coord.x;

    float alpha_value = alpha[linear_coord];
    float mask0 = build_alpha_shuffle(alpha_value);

    // Lane 1 and 2 should be nuked by this.
    if (fract(alpha_value) < 0.5)
    {
        demote;
    }

    float mask1 = build_alpha_shuffle(alpha_value);
    uint last_value = 0u;

    last_value = atomicAdd(atomics[linear_coord], 101u);

    if (linear_coord == 3 || last_value > 1000)
    {
        demote;
    }

    float mask2 = build_alpha_shuffle(alpha_value);

    color = vec4(1.0, mask0, mask1, mask2);
}
