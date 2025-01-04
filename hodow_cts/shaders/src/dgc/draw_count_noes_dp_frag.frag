#version 460
layout (location=0) in flat int inInstanceIndex;
layout (location=1) in flat int drawIndex;
layout (location=2) in flat int baseVertex;
layout (location=3) in flat int baseInstance;
layout (location=0) out vec4 outColor;

layout (set=1, binding=0, std430) readonly buffer ExpectedDrawParams { ivec4 values[]; } edp;
layout (push_constant, std430) uniform PushConstantBlock { uvec2 dim; } pc;


void main (void) {
    const uint pixelIdx = uint(gl_FragCoord.y) * pc.dim.x + uint(gl_FragCoord.x);
    const float red   = float(inInstanceIndex) / 255.0;
    const float green = 0.0;
    bool blueOK = true;
    blueOK = (blueOK && (drawIndex == edp.values[pixelIdx].x));
    blueOK = (blueOK && (baseVertex == edp.values[pixelIdx].y));
    blueOK = (blueOK && (baseInstance == edp.values[pixelIdx].z));
    const float blue  = (blueOK ? 1.0 : 0.0);
    outColor = vec4(red, green, blue, 1.0);
}
