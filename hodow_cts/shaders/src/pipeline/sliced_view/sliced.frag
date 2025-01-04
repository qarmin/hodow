#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(${load_from}, coords);
    const uvec4 storedColor = ((size.z == ${range}) ? goodColor : badColor);
    imageStore(${store_to}, coords, storedColor);
}
