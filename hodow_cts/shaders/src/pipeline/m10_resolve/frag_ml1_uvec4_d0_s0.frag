#version 460
layout (location=0) out uvec4 outColor;
struct PixelData {
    uvec4 colorValue;
    vec4 dsValue; // .x = depth, .y = stencil (as float)
};
layout (set=0, binding=0) readonly buffer PixelValuesBlock {
    PixelData values[];
} pixels;
layout (push_constant, std430) uniform PushConstantBlock {
    float width;
    float height;
} pc;
void main (void) {
    const uint prevPixels = uint(pc.width * pc.height) * uint(gl_Layer);
    const uint pixelIndex = uint(floor(gl_FragCoord.y) * pc.width + floor(gl_FragCoord.x)) + prevPixels;
    const uint sampleIndex = pixelIndex * 4 + uint(gl_SampleID);
    outColor = pixels.values[sampleIndex].colorValue;
}
