#version 460
layout (set=0, binding=0, std430) readonly buffer ColorBlock0 {
    vec4 values[];
} inputBuffer0;
// For the push constants below: .x=width, .y=height, .w=samples
layout (push_constant, std430) uniform PushConstantBlock {
    ivec4 imageSize; // .xyz is the actual size, and .w is the sample count
} pc;
void main(void) {
    ivec2 pixelCoord = ivec2(gl_FragCoord.xy);
    int pixelIndex = pixelCoord.y * pc.imageSize.x + pixelCoord.x;
    int bufferIndex = pixelIndex * pc.imageSize.w + 0;
    gl_FragDepth = inputBuffer0.values[bufferIndex].x;
}
