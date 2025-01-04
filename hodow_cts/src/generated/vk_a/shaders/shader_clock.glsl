#version 450
#extension GL_ARB_gpu_shader_int64 : require
#extension GL_ARB_shader_clock : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std430) buffer Output { uvec2 values[]; } outputBuffer;
void main()
{
    uvec2 out0;
    uint64_t time1 = clockARB();
    uint64_t time2 = clockARB();
    out0  = uvec2(0, 0);
    if (time1 > time2) {
        out0.x = 1;
    }
    outputBuffer.values[gl_GlobalInvocationID.x] = out0;
}
#version 450
#extension GL_ARB_shader_clock : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std430) buffer Output { uvec2 values[]; } outputBuffer;
void main()
{
    uvec2 out0;
    uvec2 time1 = clock2x32ARB();
    uvec2 time2 = clock2x32ARB();
    out0  = uvec2(0, 0);
    if (time1.y > time2.y || (time1.y == time2.y && time1.x > time2.x)){
        out0.x = 1;
    }
    outputBuffer.values[gl_GlobalInvocationID.x] = out0;
}
#version 450
#extension GL_ARB_gpu_shader_int64 : require
#extension GL_EXT_shader_realtime_clock : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std430) buffer Output { uvec2 values[]; } outputBuffer;
void main()
{
    uvec2 out0;
    uint64_t time1 = clockRealtimeEXT();
    uint64_t time2 = clockRealtimeEXT();
    out0  = uvec2(0, 0);
    if (time1 > time2) {
        out0.x = 1;
    }
    outputBuffer.values[gl_GlobalInvocationID.x] = out0;
}
#version 450
#extension GL_EXT_shader_realtime_clock : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std430) buffer Output { uvec2 values[]; } outputBuffer;
void main()
{
    uvec2 out0;
    uvec2 time1 = clockRealtime2x32EXT();
    uvec2 time2 = clockRealtime2x32EXT();
    out0  = uvec2(0, 0);
    if (time1.y > time2.y || (time1.y == time2.y && time1.x > time2.x)){
        out0.x = 1;
    }
    outputBuffer.values[gl_GlobalInvocationID.x] = out0;
}
