#version 460
layout (set=0, binding=0) uniform sampler2DMS srcDepth;
// For the push constants below: .x=width, .y=height, .w=samples
layout (push_constant, std430) uniform PushConstantBlock {
    ivec4 imageSize; // .xyz is the actual size, and .w is the sample count
} pc;
void main(void) {
    ivec2 expandedPixelCoord = ivec2(gl_FragCoord.xy);
    int sampleID = expandedPixelCoord.x % pc.imageSize.w;
    int xCoordMS = expandedPixelCoord.x / pc.imageSize.w;
    int yCoordMS = expandedPixelCoord.y;
    gl_FragDepth = texelFetch(srcDepth, ivec2(xCoordMS, yCoordMS), sampleID).x;
}
