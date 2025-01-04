#version 310 es
void main (void)
{
    gl_Position = vec4(float(1 - 2 * int(gl_VertexIndex != 1)),
                       float(1 - 2 * int(gl_VertexIndex > 0)), 0.0, 1.0);
}
#version 310 es
layout (location = 0) out highp vec4 color;
void main (void)
{
    color = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 450

void main (void)
{
   gl_Position = vec4(1);
}
#version 450

layout(location=0) out vec4 x;
layout(set=0) layout(binding=0) uniform foo { int x; int y; } bar;
void main (void)
{
   x = vec4(bar.y);
}
#version 450
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set=0) layout(binding=0) uniform foo { int x; int y; } bar;
void main (void)
{
    vec4 x = vec4(bar.y);
}
#version 450
layout (local_size_x=1, local_size_y=1, local_size_z=1) in;
layout (constant_id=0) const uint flag = 0;
layout (push_constant, std430) uniform PushConstants {
    uint base;
};
layout (set=0, binding=0, std430) buffer Block {
    uint data[];
};

void main() {
    if (flag != 0u) {
        uint idx = gl_GlobalInvocationID.x;
        data[idx] = data[idx] + base + idx;
    }
}
#version 450

void main (void)
{
   gl_Position = vec4(1.0f);
}
#version 450

void main (void)
{
}
#version 450
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main (void)
{
}
