#version 450
#extension GL_ARB_shader_viewport_layer_array : enable
layout (location=0) out float multiplier;

vec2 positions[4] = vec2[](
    vec2(-1.0, -1.0),
    vec2(-1.0,  1.0),
    vec2( 1.0, -1.0),
    vec2( 1.0,  1.0)
);
void main ()
{
    gl_Position = vec4(positions[gl_VertexIndex % 4], 0.0, 1.0);
    gl_Layer = 1;
    multiplier = (gl_VertexIndex < 1024 ? 1.0 : 0.0);
}
