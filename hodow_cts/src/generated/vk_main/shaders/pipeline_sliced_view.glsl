#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 1) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 2) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 3) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 4) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 5) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 6) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 7) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 8) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 9) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 10) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 11) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 12) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 13) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 14) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 15) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 16) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 17) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 18) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 19) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 20) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 21) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 22) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 23) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 24) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 25) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 26) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 27) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 28) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 29) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 30) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 31) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 32) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (local_size_x=4, local_size_y=4, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 1) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (local_size_x=4, local_size_y=4, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 2) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (local_size_x=4, local_size_y=4, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 3) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (local_size_x=4, local_size_y=4, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 4) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (local_size_x=2, local_size_y=2, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 1) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (local_size_x=2, local_size_y=2, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 2) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (local_size_x=1, local_size_y=1, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 1) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=2) in;
layout (set=0, binding=0) uniform usampler3D combinedSampler;
layout (set=0, binding=1, rgba8ui) uniform uimage3D auxiliarImage;
void main() {
    const vec3 levelExtent = vec3(8, 8, 2);
    const vec3 sampleCoords = vec3(
        (float(gl_LocalInvocationID.x) + 0.5) / levelExtent.x,
        (float(gl_LocalInvocationID.y) + 0.5) / levelExtent.y,
        (float(gl_LocalInvocationID.z) + 0.5) / levelExtent.z);
    const ivec3 storeCoords = ivec3(int(gl_LocalInvocationID.x), int(gl_LocalInvocationID.y), int(gl_LocalInvocationID.z));
    const uvec4 sampledColor = texture(combinedSampler, sampleCoords);
    imageStore(auxiliarImage, storeCoords, sampledColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=4) in;
layout (set=0, binding=0) uniform usampler3D combinedSampler;
layout (set=0, binding=1, rgba8ui) uniform uimage3D auxiliarImage;
void main() {
    const vec3 levelExtent = vec3(8, 8, 4);
    const vec3 sampleCoords = vec3(
        (float(gl_LocalInvocationID.x) + 0.5) / levelExtent.x,
        (float(gl_LocalInvocationID.y) + 0.5) / levelExtent.y,
        (float(gl_LocalInvocationID.z) + 0.5) / levelExtent.z);
    const ivec3 storeCoords = ivec3(int(gl_LocalInvocationID.x), int(gl_LocalInvocationID.y), int(gl_LocalInvocationID.z));
    const uvec4 sampledColor = texture(combinedSampler, sampleCoords);
    imageStore(auxiliarImage, storeCoords, sampledColor);
}
#version 460
layout (location=0) out flat int zCoord;
vec2 positions[3] = vec2[](
    vec2(-1.0, -1.0),
    vec2( 3.0, -1.0),
    vec2(-1.0,  3.0)
);
void main() {
    gl_Position = vec4(positions[gl_VertexIndex % 3], 0.0, 1.0);
    zCoord = int(gl_InstanceIndex);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 1) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 2) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 3) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 4) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 5) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 6) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 7) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 8) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 9) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 10) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 11) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 12) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 13) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 14) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 15) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 16) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 17) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 18) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 19) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 20) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 21) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 22) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 23) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 24) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 25) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 26) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 27) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 28) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 29) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 30) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 31) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(slicedImage, coords);
    const uvec4 storedColor = ((size.z == 32) ? goodColor : badColor);
    imageStore(auxiliarImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 1) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 2) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 3) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 4) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 5) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 6) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 7) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 8) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 9) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 10) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 11) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 12) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 13) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 14) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 15) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 16) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 17) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 18) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 19) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 20) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 21) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 22) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 23) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 24) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 25) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 26) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 27) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 28) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 29) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 30) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 31) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (local_size_x=8, local_size_y=8, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 32) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (local_size_x=4, local_size_y=4, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 1) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (local_size_x=4, local_size_y=4, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 2) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (local_size_x=4, local_size_y=4, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 3) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (local_size_x=4, local_size_y=4, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 4) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (local_size_x=2, local_size_y=2, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 1) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (local_size_x=2, local_size_y=2, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 2) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (local_size_x=1, local_size_y=1, local_size_z=1) in;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_LocalInvocationID.xy), int(gl_WorkGroupID.x));
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 1) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 1) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 2) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 3) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 4) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 5) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 6) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 7) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 8) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 9) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 10) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 11) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 12) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 13) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 14) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 15) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 16) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 17) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 18) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 19) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 20) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 21) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 22) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 23) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 24) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 25) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 26) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 27) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 28) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 29) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 30) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 31) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
#version 460
layout (location=0) in flat int zCoord;
layout (rgba8ui, set=0, binding=0) uniform uimage3D slicedImage;
layout (rgba8ui, set=0, binding=1) uniform uimage3D auxiliarImage;
void main (void) {
    const ivec3 coords = ivec3(ivec2(gl_FragCoord.xy), zCoord);
    const ivec3 size = imageSize(slicedImage);
    const uvec4 badColor = uvec4(0, 0, 0, 0);
    const uvec4 goodColor = imageLoad(auxiliarImage, coords);
    const uvec4 storedColor = ((size.z == 32) ? goodColor : badColor);
    imageStore(slicedImage, coords, storedColor);
}
