#version 450
layout(location=0) out float texCoord;
vec2 positions[6] = vec2[](
    vec2(-1.0f, 1.0f),
    vec2(1.0f, 1.0f),
    vec2(-1.0f, -1.0f),
    vec2(-1.0f, -1.0f),
    vec2(1.0f, 1.0f),
    vec2(1.0f, -1.0f)
);

void main() {
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
    texCoord.x = (positions[gl_VertexIndex].x < 0.0) ? 0.0 : positions[gl_VertexIndex].x;
}
