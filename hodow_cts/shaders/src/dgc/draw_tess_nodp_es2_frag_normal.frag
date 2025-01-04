#version 460
layout (push_constant, std430) uniform PushConstantBlock {
    float redValue;
} pc;
layout (location=0) in flat int instanceIndex;
layout (location=1) in flat float redOffset;
layout (location=0) out vec4 outColor;
void main (void) {
    bool drawParamsOK = true;
    const float alphaValue = (drawParamsOK ? 1.0 : 0.0);
    outColor = vec4(pc.redValue + redOffset, float(instanceIndex), 0, alphaValue);
}
