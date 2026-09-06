#version 450
layout(push_constant) uniform PushConstant {
	highp uint sampleMask;
} pushConstants;
layout(location = 0) out ivec4 o_color0;
void main (void)
{
	gl_SampleMask[0] = int(pushConstants.sampleMask);
	o_color0 = ivec4(127);
}
