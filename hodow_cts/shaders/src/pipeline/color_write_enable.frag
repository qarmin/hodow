#version 450
layout(push_constant, std430) uniform PushConstantsBlock {
    vec4  triangleColor;
    float depthValue;
    float scaleX;
    float scaleY;
    float offsetX;
    float offsetY;
} pushConstants;
layout(location=0) out vec4 color0;
layout(location=1) out vec4 color1;
layout(location=2) out vec4 color2;
void main() {
    color0 = pushConstants.triangleColor * 1;
    color1 = pushConstants.triangleColor * 0.5;
    color2 = pushConstants.triangleColor * 0.25;
}
