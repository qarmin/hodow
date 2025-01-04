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
