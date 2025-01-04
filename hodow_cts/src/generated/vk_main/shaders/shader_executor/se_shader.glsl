#version 450
#extension GL_ARB_gpu_shader_int64 : require
#extension GL_ARB_shader_clock : enable

layout(location = 0) in highp vec4 a_position;
layout(location = 0) flat out highp uvec2 vtx_out_out0;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uvec2 out0;
	uint64_t time1 = clockARB();
	uint64_t time2 = clockARB();
	out0 = uvec2(0, 0);
	if (time1 > time2) {
	    out0.x = 1;
	}
	vtx_out_out0 = out0;
}
#version 450
#extension GL_ARB_gpu_shader_int64 : require
#extension GL_ARB_shader_clock : enable

layout(location = 0) flat in highp uvec2 vtx_out_out0;
layout(location = 0) out highp uvec2 o_out0;

void main (void)
{
	o_out0 = vtx_out_out0;
}
#version 450
#extension GL_ARB_gpu_shader_int64 : require
#extension GL_ARB_shader_clock : enable

layout(location = 0) in highp vec4 a_position;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
}
#version 450
#extension GL_ARB_gpu_shader_int64 : require
#extension GL_ARB_shader_clock : enable

layout(location = 0) out highp uvec2 o_out0;

void main (void)
{
	highp uvec2 out0;
	uint64_t time1 = clockARB();
	uint64_t time2 = clockARB();
	out0 = uvec2(0, 0);
	if (time1 > time2) {
	    out0.x = 1;
	}
	o_out0 = out0;
}
#version 450
#extension GL_ARB_shader_clock : enable

layout(location = 0) in highp vec4 a_position;
layout(location = 0) flat out highp uvec2 vtx_out_out0;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uvec2 out0;
	uvec2 time1 = clock2x32ARB();
	uvec2 time2 = clock2x32ARB();
	out0 = uvec2(0, 0);
	if (time1.y > time2.y || (time1.y == time2.y && time1.x > time2.x)){
	    out0.x = 1;
	}
	vtx_out_out0 = out0;
}
#version 450
#extension GL_ARB_shader_clock : enable

layout(location = 0) flat in highp uvec2 vtx_out_out0;
layout(location = 0) out highp uvec2 o_out0;

void main (void)
{
	o_out0 = vtx_out_out0;
}
#version 450
#extension GL_ARB_shader_clock : enable

layout(location = 0) in highp vec4 a_position;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
}
#version 450
#extension GL_ARB_shader_clock : enable

layout(location = 0) out highp uvec2 o_out0;

void main (void)
{
	highp uvec2 out0;
	uvec2 time1 = clock2x32ARB();
	uvec2 time2 = clock2x32ARB();
	out0 = uvec2(0, 0);
	if (time1.y > time2.y || (time1.y == time2.y && time1.x > time2.x)){
	    out0.x = 1;
	}
	o_out0 = out0;
}
#version 450
#extension GL_ARB_gpu_shader_int64 : require
#extension GL_EXT_shader_realtime_clock : require

layout(location = 0) in highp vec4 a_position;
layout(location = 0) flat out highp uvec2 vtx_out_out0;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uvec2 out0;
	uint64_t time1 = clockRealtimeEXT();
	uint64_t time2 = clockRealtimeEXT();
	out0 = uvec2(0, 0);
	if (time1 > time2) {
	    out0.x = 1;
	}
	vtx_out_out0 = out0;
}
#version 450
#extension GL_ARB_gpu_shader_int64 : require
#extension GL_EXT_shader_realtime_clock : require

layout(location = 0) flat in highp uvec2 vtx_out_out0;
layout(location = 0) out highp uvec2 o_out0;

void main (void)
{
	o_out0 = vtx_out_out0;
}
#version 450
#extension GL_ARB_gpu_shader_int64 : require
#extension GL_EXT_shader_realtime_clock : require

layout(location = 0) in highp vec4 a_position;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
}
#version 450
#extension GL_ARB_gpu_shader_int64 : require
#extension GL_EXT_shader_realtime_clock : require

layout(location = 0) out highp uvec2 o_out0;

void main (void)
{
	highp uvec2 out0;
	uint64_t time1 = clockRealtimeEXT();
	uint64_t time2 = clockRealtimeEXT();
	out0 = uvec2(0, 0);
	if (time1 > time2) {
	    out0.x = 1;
	}
	o_out0 = out0;
}
#version 450
#extension GL_EXT_shader_realtime_clock : require

layout(location = 0) in highp vec4 a_position;
layout(location = 0) flat out highp uvec2 vtx_out_out0;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uvec2 out0;
	uvec2 time1 = clockRealtime2x32EXT();
	uvec2 time2 = clockRealtime2x32EXT();
	out0 = uvec2(0, 0);
	if (time1.y > time2.y || (time1.y == time2.y && time1.x > time2.x)){
	    out0.x = 1;
	}
	vtx_out_out0 = out0;
}
#version 450
#extension GL_EXT_shader_realtime_clock : require

layout(location = 0) flat in highp uvec2 vtx_out_out0;
layout(location = 0) out highp uvec2 o_out0;

void main (void)
{
	o_out0 = vtx_out_out0;
}
#version 450
#extension GL_EXT_shader_realtime_clock : require

layout(location = 0) in highp vec4 a_position;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
}
#version 450
#extension GL_EXT_shader_realtime_clock : require

layout(location = 0) out highp uvec2 o_out0;

void main (void)
{
	highp uvec2 out0;
	uvec2 time1 = clockRealtime2x32EXT();
	uvec2 time2 = clockRealtime2x32EXT();
	out0 = uvec2(0, 0);
	if (time1.y > time2.y || (time1.y == time2.y && time1.x > time2.x)){
	    out0.x = 1;
	}
	o_out0 = out0;
}
