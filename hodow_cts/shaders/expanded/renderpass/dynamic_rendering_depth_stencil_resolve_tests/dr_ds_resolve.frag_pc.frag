#version 450
layout (push_constant, std430) uniform PushConstants {
    vec4 color;
} pc;
layout (location=0) out vec4 outColor;
void main (void) {
    outColor = pc.color;
}
