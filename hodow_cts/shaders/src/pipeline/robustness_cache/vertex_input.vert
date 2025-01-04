#version 450
layout(location = 0) in float in_values[16];
layout(location = 0) out float out_value;
layout (set=0, binding=1) restrict readonly buffer IndexBuffer { uint index; };
void main()
{
    vec2 vertex = vec2(gl_VertexIndex & 1u, (gl_VertexIndex >> 1u) & 1u);
    gl_Position = vec4(vertex * 2.0f - 1.0f, 0.0f, 1.0f);
    out_value = in_values[index];
}
