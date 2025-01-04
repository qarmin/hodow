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
