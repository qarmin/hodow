#version 460
#extension GL_ARB_shader_stencil_export : require
struct PixelData {
    vec4 colorValue;
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
    const uint prevPixels = 0u;
    const uint pixelIndex = uint(floor(gl_FragCoord.y) * pc.width + floor(gl_FragCoord.x)) + prevPixels;
    const uint sampleIndex = pixelIndex * 4 + uint(gl_SampleID);
    gl_FragStencilRefARB = int(pixels.values[sampleIndex].dsValue.y);
}
