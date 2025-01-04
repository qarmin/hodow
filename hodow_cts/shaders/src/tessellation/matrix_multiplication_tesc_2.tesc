#version 450
layout(vertices = 1) out;

layout(location = 0) patch out mat4 x;
layout(location = 5) patch out vec4 col0;

void main()
{
    // Note: if |x| is not an |out| varying, the test passes.
    x = mat4(
        0.53455, 0.47307, 0.34935, 0.28717,
        0.67195, 0.59992, 0.48213, 0.43678,
        0.76376, 0.6772, 0.55361, 0.5165,
        0.77996, 0.68862, 0.56187, 0.52611
    );

    const mat4 m = mat4(
        vec4( -1.0, 3.0,-3.0, 1.0),
        vec4(  3.0,-6.0, 3.0, 0.0),
        vec4( -3.0, 3.0, 0.0, 0.0),
        vec4(  1.0, 0.0, 0.0, 0.0)
    );

    mat4 temp = x;

    // Note: On the failing driver, commenting this line makes the test pass.
    // However, the output being tested is |temp|, assigned above, not |x|.
    x = m * x;

    col0 = temp[0];

    gl_TessLevelInner[0u] = 1.;
    gl_TessLevelInner[1u] = 1.;
    gl_TessLevelOuter[0u] = 1.;
    gl_TessLevelOuter[1u] = 1.;
    gl_TessLevelOuter[2u] = 1.;
    gl_TessLevelOuter[3u] = 1.;
}
