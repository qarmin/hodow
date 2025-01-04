#version 450
void main()
{
    gl_Position = vec4(gl_VertexIndex & 1u, (gl_VertexIndex >> 1u) & 1u, 0.0f, 1.0f);
}
#version 450
layout(vertices = 1) out;

layout(location = 0) patch out mat4 x;

void main()
{
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

    x = m * x;

    gl_TessLevelInner[0u] = 1.;
    gl_TessLevelInner[1u] = 1.;
    gl_TessLevelOuter[0u] = 1.;
    gl_TessLevelOuter[1u] = 1.;
    gl_TessLevelOuter[2u] = 1.;
    gl_TessLevelOuter[3u] = 1.;
}
#version 450
layout(quads, cw, fractional_odd_spacing) in;

layout(location = 0) patch in mat4 x;
layout(location = 0) out mat4 x_fs;

void main()
{
    x_fs = x;
    gl_Position = vec4(gl_TessCoord.xy * 2. - 1., 0, 1);
}
#version 450

layout(location = 0) in mat4 x_fs;
layout(location = 0) out vec4 color;

void main()
{
    const mat4 expect = mat4(
        0.12378, -0.18672, -0.18444, 0.53455,
        0.1182, -0.13728, -0.21609, 0.67195,
        0.12351, -0.11109, -0.25968, 0.76376,
        0.1264, -0.10623, -0.27402, 0.77996
    );

    color = vec4(all(lessThan(abs(x_fs[0] - expect[0]), vec4(0.01))),
                 all(lessThan(abs(x_fs[1] - expect[1]), vec4(0.01))),
                 all(lessThan(abs(x_fs[2] - expect[2]), vec4(0.01))),
                 all(lessThan(abs(x_fs[3] - expect[3]), vec4(0.01))));
}
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
#version 450
layout(quads, cw, fractional_odd_spacing) in;

layout(location = 5) patch in vec4 col0;

layout(location = 0) out vec4 col0_fs;

void main()
{
    col0_fs = col0;
    gl_Position = vec4(gl_TessCoord.xy * 2. - 1., 0, 1);
}
#version 450
layout(location = 0) in vec4 col0_fs;
layout(location = 0) out vec4 color;

void main()
{
    color = vec4(abs(col0_fs.x - 0.53455) < 0.01,
                abs(col0_fs.y - 0.47307) < 0.01,
                abs(col0_fs.z - 0.34935) < 0.01,
                abs(col0_fs.w - 0.28717) < 0.01);
}
