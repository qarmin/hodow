#version 450
layout(push_constant, std430) uniform PushConstantsBlock {
    vec4  triangleColor;
    float depthValue;
    int   viewPortIndex;
    float scaleX;
    float scaleY;
    float offsetX;
    float offsetY;
    float stripScale;
} pushConstants;
layout(location=0, index=0) out vec4 color;
layout(location=0, index=1) out vec4 color1;
void main() {
    color = vec4(1.0, 1.0, 1.0, 1.0);
    color1 = vec4(pushConstants.triangleColor);
}
