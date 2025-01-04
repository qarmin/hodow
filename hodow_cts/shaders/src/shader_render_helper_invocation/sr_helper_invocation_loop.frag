#version 450
#extension GL_KHR_shader_subgroup_basic : require
#extension GL_KHR_shader_subgroup_quad : require
layout(location = 0) out vec4 o_color;
layout(set = 0, binding = 0) uniform sampler2D u_tex;
layout(set = 0, binding = 1) buffer ResultBlock { uint results[]; };
void main (void)
{
    const vec2 fbSize = vec2(16.0, 16.0);
    vec2 uv = gl_FragCoord.xy / fbSize;
    ivec2 quadId = ivec2(gl_FragCoord.xy) / ivec2(2);
    int iters = 1 + (quadId.x & 3);
    vec4 loaded = vec4(0.0);
    for (int k = 0; k < iters; ++k)
    {
        vec4 sampled = texture(u_tex, uv);
        vec4 scratch[32];
        for (int i = 0; i < 32; ++i)
            scratch[i] = vec4(float(i) - 13.0);
        uint sx = uint(gl_FragCoord.x);
        uint sy = uint(gl_FragCoord.y);
        int storeIdx = int((sx * 7u + sy * 13u + 1u) % uint(32));
        scratch[storeIdx] = sampled;
        int loadIdx = 0;
        for (int i = 0; i < 32; ++i)
            if (i == storeIdx)
                loadIdx = i;
        loaded = scratch[loadIdx];
    }
    bool ok = true;
    uint helperBits = 0u;
    {
        vec4 laneLoaded = subgroupQuadBroadcast(loaded, 0u);
        vec4 laneCoord = subgroupQuadBroadcast(gl_FragCoord, 0u);
        helperBits |= subgroupQuadBroadcast(uint(gl_HelperInvocation), 0u);
        ivec2 lanePix = clamp(ivec2(laneCoord.xy), ivec2(0), ivec2(15, 15));
        vec4 expected = texelFetch(u_tex, lanePix, 0);
        if (any(greaterThan(abs(laneLoaded - expected), vec4(0.01))))
            ok = false;
    }
    {
        vec4 laneLoaded = subgroupQuadBroadcast(loaded, 1u);
        vec4 laneCoord = subgroupQuadBroadcast(gl_FragCoord, 1u);
        helperBits |= subgroupQuadBroadcast(uint(gl_HelperInvocation), 1u);
        ivec2 lanePix = clamp(ivec2(laneCoord.xy), ivec2(0), ivec2(15, 15));
        vec4 expected = texelFetch(u_tex, lanePix, 0);
        if (any(greaterThan(abs(laneLoaded - expected), vec4(0.01))))
            ok = false;
    }
    {
        vec4 laneLoaded = subgroupQuadBroadcast(loaded, 2u);
        vec4 laneCoord = subgroupQuadBroadcast(gl_FragCoord, 2u);
        helperBits |= subgroupQuadBroadcast(uint(gl_HelperInvocation), 2u);
        ivec2 lanePix = clamp(ivec2(laneCoord.xy), ivec2(0), ivec2(15, 15));
        vec4 expected = texelFetch(u_tex, lanePix, 0);
        if (any(greaterThan(abs(laneLoaded - expected), vec4(0.01))))
            ok = false;
    }
    {
        vec4 laneLoaded = subgroupQuadBroadcast(loaded, 3u);
        vec4 laneCoord = subgroupQuadBroadcast(gl_FragCoord, 3u);
        helperBits |= subgroupQuadBroadcast(uint(gl_HelperInvocation), 3u);
        ivec2 lanePix = clamp(ivec2(laneCoord.xy), ivec2(0), ivec2(15, 15));
        vec4 expected = texelFetch(u_tex, lanePix, 0);
        if (any(greaterThan(abs(laneLoaded - expected), vec4(0.01))))
            ok = false;
    }
    uint px = uint(gl_FragCoord.x);
    uint py = uint(gl_FragCoord.y);
    uint idx = py * uint(16) + px;
    if (idx < uint(256))
        results[idx] = (ok ? 1u : 0u) | (helperBits != 0u ? 2u : 0u);
    o_color = ok ? vec4(0.0, 1.0, 0.0, 1.0) : vec4(1.0, 0.0, 0.0, 1.0);
}
