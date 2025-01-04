#version 460
#extension GL_ARB_shader_viewport_layer_array : require
const vec4 vertices[] = vec4[](
    vec4(-1.0, -1.0, 0.0, 1.0),
    vec4(-1.0,  3.0, 0.0, 1.0),
    vec4( 3.0, -1.0, 0.0, 1.0)
);
void main (void) {
    gl_Position = vertices[gl_VertexIndex % 3];
    gl_Layer = gl_InstanceIndex;
}
