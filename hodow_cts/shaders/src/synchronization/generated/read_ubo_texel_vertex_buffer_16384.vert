#version 440

layout(location = 0) in vec4 v_in_position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(set = 0, binding = 0) uniform utextureBuffer Input;

layout(set = 0, binding = 1, std140) writeonly buffer Output {
    uvec4 data[1024];
} b_out;

void main (void)
{
    gl_Position = v_in_position;
    for (int i = 0; i < 1024; ++i) {
        b_out.data[i] = texelFetch(Input, i);
    }
}
