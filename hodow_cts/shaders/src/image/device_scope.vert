#version 450
vec4 positions[6] = vec4[](
    vec4(-1.0f, -1.0f, 1.0f, 1.0f),
    vec4( 1.0f, -1.0f, 1.0f, 1.0f),
    vec4(-1.0f,  1.0f, 1.0f, 1.0f),
    vec4(-1.0f,  1.0f, 1.0f, 1.0f),
    vec4( 1.0f, -1.0f, 1.0f, 1.0f),
    vec4( 1.0f,  1.0f, 1.0f, 1.0f)
);

void main() {
    gl_Position = positions[gl_VertexIndex];
}
