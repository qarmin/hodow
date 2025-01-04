#version 450
vec4 positions[4] = vec4[](
    vec4(-1.0f, -1.0f, 0.0f, 1.0f),
    vec4( 1.0f, -1.0f, 0.0f, 1.0f),
    vec4(-1.0f,  1.0f, 0.0f, 1.0f),
    vec4( 1.0f,  1.0f, 0.0f, 1.0f)
);

layout(location = 0) out vec4 out_color;

void main() {
    gl_Position = positions[gl_VertexIndex % 3];
    gl_PointSize = 1.0f;
    out_color = vec4(0.0f, 0.0f, 1.0f, 1.0f); // blue
}
