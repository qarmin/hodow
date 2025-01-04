#version 450
#extension GL_ARB_gpu_shader_int64 : require
#extension GL_EXT_shader_realtime_clock : require

layout(location = 0) in highp vec4 a_position;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
}
