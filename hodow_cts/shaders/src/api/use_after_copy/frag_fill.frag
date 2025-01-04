#version 460
layout (location=0) in flat uint layerIndex;
${out_decl}layout (set=0, binding=0) readonly buffer PixelValuesBlock {
    vec4 values[];
} pixels;
layout (push_constant, std430) uniform PushConstantBlock {
    float width;
    float height;
} pc;
void main (void) {
    const uint pixelsPerLayer = uint(pc.width * pc.height);
    const uint pixelIndex = pixelsPerLayer * layerIndex + uint(floor(gl_FragCoord.y) * pc.width + floor(gl_FragCoord.x));
    const uint sampleIndex = pixelIndex * ${samples} + uint(gl_SampleID);
${assign}}
