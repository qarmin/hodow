#version 460
const vec2 positions[4] = vec2[](
    vec2(-1.0 + 0.015625, -1.0 + 0.015625),
    vec2(-1.0 + 0.015625,  1.0 - 0.015625),
    vec2( 1.0 - 0.015625, -1.0 + 0.015625),
    vec2( 1.0 - 0.015625,  1.0 - 0.015625)
);
void main() {
    gl_Position  = vec4(positions[gl_VertexIndex % 4], 0.0, 1.0);
    gl_PointSize = 1.0;
}
