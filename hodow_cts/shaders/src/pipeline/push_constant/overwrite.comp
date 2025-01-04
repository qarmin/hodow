#version 450
layout (push_constant, std430) uniform PushConstants {
    ivec4   coords;
    uvec4   baseColor;
    uvec4   multiplier;
    uint    colorOffsets[4];
    uvec4   transparentGreen;
} pc;
layout(rgba8ui, set=0, binding=0) uniform uimage2D simage;
void main() {
    uvec4   colorOffsets = uvec4(pc.colorOffsets[0], pc.colorOffsets[1], pc.colorOffsets[2], pc.colorOffsets[3]);
    uvec4   finalColor   = pc.baseColor * pc.multiplier + colorOffsets + pc.transparentGreen;
    imageStore(simage, pc.coords.xy, finalColor);
}
