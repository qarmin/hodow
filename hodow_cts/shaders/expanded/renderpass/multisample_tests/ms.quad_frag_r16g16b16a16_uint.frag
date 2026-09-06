#version 450
layout(location = 0) out highp uvec4 o_color;
layout(push_constant) uniform PushConstant {
	highp uint sampleIndex;
} pushConstants;
void main (void)
{
	highp uint sampleIndex = pushConstants.sampleIndex;
	gl_SampleMask[0] = int(0x1u << sampleIndex);
	highp uint color[4];
	highp uint x = sampleIndex ^ uint(gl_FragCoord.x);
	highp uint y = sampleIndex ^ uint(gl_FragCoord.y);
	color[0] = 0;
	color[1] = 0;
	color[2] = 0;
	color[3] = 0;
	color[0] += 32768 * bitfieldExtract(x, 0, 1);
	color[1] += 32768 * bitfieldExtract(y, 0, 1);
	color[2] += 32768 * bitfieldExtract(x, 1, 1);
	color[3] += 32768 * bitfieldExtract(y, 1, 1);
	color[0] += 16384 * bitfieldExtract(x, 2, 1);
	color[1] += 16384 * bitfieldExtract(y, 2, 1);
	color[2] += 16384 * bitfieldExtract(x, 3, 1);
	color[3] += 16384 * bitfieldExtract(y, 3, 1);
	color[0] += 8192 * bitfieldExtract(x, 4, 1);
	color[1] += 8192 * bitfieldExtract(y, 4, 1);
	color[2] += 8192 * bitfieldExtract(x, 5, 1);
	color[3] += 8192 * bitfieldExtract(y, 5, 1);
	o_color = uvec4(color[0], color[1], color[2], color[3]);
}
