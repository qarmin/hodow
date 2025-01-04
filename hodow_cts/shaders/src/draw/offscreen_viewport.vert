#version 460
const int vertexCount = 4;
vec2 positions[vertexCount] = vec2[](
    vec2(-1.0, -1.0),
    vec2(-1.0,  1.0),
    vec2( 1.0, -1.0),
    vec2( 1.0,  1.0)
);
void main (void) { gl_Position = vec4(positions[gl_VertexIndex % vertexCount], 0.0, 1.0); }
