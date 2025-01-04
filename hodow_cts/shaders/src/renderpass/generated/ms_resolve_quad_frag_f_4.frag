#version 450
layout(push_constant) uniform PushConstant {
	highp uint sampleMask;
} pushConstants;
layout(location = 0) out vec4 o_color0;
layout(location = 1) out vec4 o_color1;
layout(location = 2) out vec4 o_color2;
layout(location = 3) out vec4 o_color3;
void main (void)
{
	gl_SampleMask[0] = int(pushConstants.sampleMask);
	o_color0 = vec4(1.0);
	o_color1 = vec4(1.0);
	o_color2 = vec4(1.0);
	o_color3 = vec4(1.0);
}
