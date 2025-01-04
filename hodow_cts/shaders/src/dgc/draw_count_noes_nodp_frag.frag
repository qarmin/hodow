#version 460
layout (location=0) in flat int inInstanceIndex;
layout (location=0) out vec4 outColor;



void main (void) {
    const float red   = float(inInstanceIndex) / 255.0;
    const float green = 0.0;
    bool blueOK = true;
    const float blue  = (blueOK ? 1.0 : 0.0);
    outColor = vec4(red, green, blue, 1.0);
}
