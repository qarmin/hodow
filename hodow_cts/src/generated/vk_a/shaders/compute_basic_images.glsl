#version 310 es
layout (local_size_x = 1, local_size_y = 1) in;
layout(binding = 1, r32ui) readonly uniform highp uimage2D u_srcImg;
layout(binding = 0) writeonly buffer Output {
    uint values[4096];
} sb_out;

void main (void) {
    uint stride = gl_NumWorkGroups.x*gl_WorkGroupSize.x;
    uint value  = imageLoad(u_srcImg, ivec2(gl_GlobalInvocationID.xy)).x;
    sb_out.values[gl_GlobalInvocationID.y*stride + gl_GlobalInvocationID.x] = value;
}
#version 310 es
layout (local_size_x = 2, local_size_y = 4) in;
layout(binding = 1, r32ui) readonly uniform highp uimage2D u_srcImg;
layout(binding = 0) writeonly buffer Output {
    uint values[262144];
} sb_out;

void main (void) {
    uint stride = gl_NumWorkGroups.x*gl_WorkGroupSize.x;
    uint value  = imageLoad(u_srcImg, ivec2(gl_GlobalInvocationID.xy)).x;
    sb_out.values[gl_GlobalInvocationID.y*stride + gl_GlobalInvocationID.x] = value;
}
#version 310 es
layout (local_size_x = 1, local_size_y = 1) in;
layout(binding = 1, r32ui) writeonly uniform highp uimage2D u_dstImg;
layout(binding = 0) readonly buffer Input {
    uint values[4096];
} sb_in;

void main (void) {
    uint stride = gl_NumWorkGroups.x*gl_WorkGroupSize.x;
    uint value  = sb_in.values[gl_GlobalInvocationID.y*stride + gl_GlobalInvocationID.x];
    imageStore(u_dstImg, ivec2(gl_GlobalInvocationID.xy), uvec4(value, 0, 0, 0));
}
#version 310 es
layout (local_size_x = 2, local_size_y = 4) in;
layout(binding = 1, r32ui) writeonly uniform highp uimage2D u_dstImg;
layout(binding = 0) readonly buffer Input {
    uint values[262144];
} sb_in;

void main (void) {
    uint stride = gl_NumWorkGroups.x*gl_WorkGroupSize.x;
    uint value  = sb_in.values[gl_GlobalInvocationID.y*stride + gl_GlobalInvocationID.x];
    imageStore(u_dstImg, ivec2(gl_GlobalInvocationID.xy), uvec4(value, 0, 0, 0));
}
