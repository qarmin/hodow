#version 440

layout(location = 0) in vec4 v_in_position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(set = 0, binding = 0, std140) coherent buffer Data {
    uint value;
} sb_out;

void main (void)
{
    gl_Position = v_in_position;
    atomicAdd(sb_out.value, 1u);
}
