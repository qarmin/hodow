#version 460
layout (push_constant, std430) uniform PushConstantBlock {
    float redValue;
    int drawIndex;
    int baseVertex;
    int baseInstance;
} pc;
layout (location=0) in flat int instanceIndex;
layout (location=1) in flat float redOffset;
layout (location=3) in flat int drawIndex;
layout (location=4) in flat int baseVertex;
layout (location=5) in flat int baseInstance;
layout (location=0) out vec4 outColor;
void main (void) {
    bool drawParamsOK = true;
    drawParamsOK = (drawParamsOK && (drawIndex == pc.drawIndex));
    drawParamsOK = (drawParamsOK && (baseVertex == pc.baseVertex));
    drawParamsOK = (drawParamsOK && (baseInstance == pc.baseInstance));
    const float alphaValue = (drawParamsOK ? 1.0 : 0.0);
    outColor = vec4(pc.redValue + redOffset, float(instanceIndex), 0, alphaValue);
}
