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
layout(location=0) out uvec4 color;
void main() {
    color = uvec4(pushConstants.triangleColor);
}
