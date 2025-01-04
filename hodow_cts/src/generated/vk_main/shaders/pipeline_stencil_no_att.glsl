#version 460
vec2 positions[3] = vec2[](
    vec2(-1.0, -1.0),
    vec2( 3.0, -1.0),
    vec2(-1.0,  3.0)
);
layout (push_constant, std430) uniform PushConstantBlock {
    float depth;
} pc;
void main (void) {
    gl_Position = vec4(positions[gl_VertexIndex % 3], pc.depth, 1.0);
}
#version 460
layout (location=0) out vec4 outColor;
void main (void) {
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
}
