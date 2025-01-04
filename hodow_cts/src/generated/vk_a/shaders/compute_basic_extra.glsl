#version 310 es
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(binding = 0) buffer InOut {
    uint values[1024];
} sb_inout;
void main (void) {
    uvec3 size           = gl_NumWorkGroups * gl_WorkGroupSize;
    uint numValuesPerInv = uint(sb_inout.values.length()) / (size.x*size.y*size.z);
    uint groupNdx        = size.x*size.y*gl_GlobalInvocationID.z + size.x*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    uint offset          = numValuesPerInv*groupNdx;

    for (uint ndx = 0u; ndx < numValuesPerInv; ndx++)
        sb_inout.values[offset + ndx] = ~sb_inout.values[offset + ndx];
}
#version 310 es
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(binding = 0, std140) readonly buffer Input {
    uint values[];
} sb_in;
layout (binding = 1, std140) writeonly buffer Output {
    uint values[];
} sb_out;
void main (void) {
    uvec3 size           = gl_NumWorkGroups * gl_WorkGroupSize;
    uint numValuesPerInv = uint(sb_out.values.length()) / (size.x*size.y*size.z);
    uint groupNdx        = size.x*size.y*gl_GlobalInvocationID.z + size.x*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;
    uint offset          = numValuesPerInv*groupNdx;

    for (uint ndx = 0u; ndx < numValuesPerInv; ndx++)
        sb_out.values[offset + ndx] = ~sb_in.values[offset + ndx];
}
#version 450
layout (set = 0, binding = 0) buffer SSBO_0 {
  uint x;
} ssbo0;

layout(set = 0, binding = 1, std430) buffer SSBO_1 {
  vec4 data;
  uint not_set[];
} ssbo1;

void main() {
  ssbo0.x = 23;
  ssbo0.x = ssbo1.not_set.length();
  ssbo1.data *= 2.0;
}
#version 310 es
#extension GL_OES_shader_image_atomic : require
layout (local_size_x = 1) in;
layout(binding = 1, r32ui) coherent uniform highp uimage2D u_dstImg;
layout(binding = 0) readonly buffer Input {
    uint values[4096];
} sb_in;

void main (void) {
    uint stride = gl_NumWorkGroups.x*gl_WorkGroupSize.x;
    uint value  = sb_in.values[gl_GlobalInvocationID.y*stride + gl_GlobalInvocationID.x];

    if (gl_LocalInvocationIndex == 0u)
        imageStore(u_dstImg, ivec2(gl_WorkGroupID.xy), uvec4(0));
    memoryBarrierImage();
    barrier();
    imageAtomicAdd(u_dstImg, ivec2(gl_WorkGroupID.xy), value);
}
#version 310 es
#extension GL_OES_shader_image_atomic : require
layout (local_size_x = 8) in;
layout(binding = 1, r32ui) coherent uniform highp uimage2D u_dstImg;
layout(binding = 0) readonly buffer Input {
    uint values[32768];
} sb_in;

void main (void) {
    uint stride = gl_NumWorkGroups.x*gl_WorkGroupSize.x;
    uint value  = sb_in.values[gl_GlobalInvocationID.y*stride + gl_GlobalInvocationID.x];

    if (gl_LocalInvocationIndex == 0u)
        imageStore(u_dstImg, ivec2(gl_WorkGroupID.xy), uvec4(0));
    memoryBarrierImage();
    barrier();
    imageAtomicAdd(u_dstImg, ivec2(gl_WorkGroupID.xy), value);
}
#version 310 es
layout (local_size_x = 1) in;
layout(binding = 2) readonly uniform Constants {
    uint u_baseVal;
};
layout(binding = 1, r32ui) writeonly uniform highp uimage2D u_img;
void main (void) {
    uint offset = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;
    imageStore(u_img, ivec2(gl_WorkGroupID.xy), uvec4(offset + u_baseVal, 0, 0, 0));
}
#version 310 es
layout (local_size_x = 1) in;
layout(binding = 1, r32ui) readonly uniform highp uimage2D u_img;
layout(binding = 0) coherent buffer Output {
    uint sum;
};
void main (void) {
    uint value = imageLoad(u_img, ivec2(gl_WorkGroupID.xy)).x;
    atomicAdd(sum, value);
}
#version 450
layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

struct Bar {
    uint x;
    uint y;
    uint z[2];
};

layout(set = 0, binding = 0, std430) buffer foo {
    uvec4 a;
    Bar b;
    uint c;
};

void main() {
    Bar new_bar;
    b = new_bar;
    a = uvec4(1, 2, 3, 4);
    c = 5;
}
#version 450
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(std430, binding = 0) buffer CounterBuffer {
  uint counter;
};
void main() {
  atomicAdd(counter, 1);
}
