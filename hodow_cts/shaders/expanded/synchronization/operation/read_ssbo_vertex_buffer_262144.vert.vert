#version 440

layout(location = 0) in vec4 v_in_position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(set = 0, binding = 0, std140) readonly buffer Input {
    uvec4 data[16384];
} b_in;

layout(set = 0, binding = 1, std140) writeonly buffer Output {
    uvec4 data[16384];
} b_out;

void main (void)
{
    gl_Position = v_in_position;
    for (int i = 0; i < 16384; ++i) {
        b_out.data[i] = b_in.data[i];
    }
}
