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
layout(location=0) flat in uint colorMultiplier;
layout(location=0) out vec4 color;
void main() {
    color = vec4(pushConstants.triangleColor);
    color = color * float(colorMultiplier);
}
