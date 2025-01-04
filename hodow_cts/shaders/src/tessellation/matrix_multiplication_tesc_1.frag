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
