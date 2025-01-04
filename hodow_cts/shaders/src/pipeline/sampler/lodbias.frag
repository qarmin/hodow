#version 460
layout (location=0) out vec4 outColor;
layout (set=0, binding=0) uniform sampler2D texSampler;
layout (push_constant, std430) uniform PushConstantBlock {
    float lodLevel;
    float fbWidth;
    float fbHeight;
} pc;
void main (void) {
    outColor = ${sample_statement};
}
