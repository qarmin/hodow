#version 450
vec2 positions[3] = vec2[](
    vec2(-1.0, -1.0),
    vec2(3.0, -1.0),
    vec2(-1.0, 3.0)
);
layout (location = 0) out float verify;
void main() {
    const uint triIdx     = gl_VertexIndex / 3u;
    const uint triVertIdx = gl_VertexIndex % 3u;
    gl_Position = vec4(positions[triVertIdx], 0.0, 1.0);
    verify = float(triIdx) + float(triVertIdx) / 16.0 + 0.75;
}
