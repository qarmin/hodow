#version 460
layout (push_constant, std430) uniform PushConstantBlock {
    vec2 scale;
    vec2 offset;
    float depth;
} pc;
layout (location=0) in vec4 inPos;
void main (void) {
float depth = pc.depth;
    gl_Position = vec4(inPos.xy * pc.scale + pc.offset, depth, 1.0);
    gl_PointSize = 1.0;
}
