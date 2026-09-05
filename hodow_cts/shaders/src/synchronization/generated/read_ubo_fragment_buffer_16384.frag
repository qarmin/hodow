#version 440

layout(location = 0) out vec4 o_color;

layout(set = 0, binding = 0, std140) readonly uniform Input {
    uvec4 data[1024];
} b_in;

layout(set = 0, binding = 1, std140) writeonly buffer Output {
    uvec4 data[1024];
} b_out;

void main (void)
{
    o_color = vec4(1.0);

    for (int i = 0; i < 1024; ++i) {
        b_out.data[i] = b_in.data[i];
    }
}
