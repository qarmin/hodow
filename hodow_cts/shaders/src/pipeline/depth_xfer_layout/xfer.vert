#version 460
const float geometryDepth = 1.0;
const vec4 vertices[] = vec4[](
    vec4(-1.0, -1.0, geometryDepth, 1.0),
    vec4(-1.0,  3.0, geometryDepth, 1.0),
    vec4( 3.0, -1.0, geometryDepth, 1.0)
);
void main (void) {
    gl_Position = vertices[gl_VertexIndex % 3];
}
