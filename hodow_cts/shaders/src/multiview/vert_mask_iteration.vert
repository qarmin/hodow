#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
vec2 positions[3] = vec2[](
    vec2(-1.0, -1.0),
    vec2(-1.0,  3.0),
    vec2( 3.0, -1.0)
);
void main() {
    gl_Position = vec4(positions[gl_VertexIndex % 3], 1.0, 1.0);
}
