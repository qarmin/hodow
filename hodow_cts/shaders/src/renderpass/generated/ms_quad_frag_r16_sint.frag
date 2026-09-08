#version 450
layout(location = 0) out highp ivec4 o_color;
layout(push_constant) uniform PushConstant {
	highp uint sampleIndex;
} pushConstants;
void main (void)
{
	highp uint sampleIndex = pushConstants.sampleIndex;
	gl_SampleMask[0] = int(0x1u << sampleIndex);
	highp int color[4];
	highp uint x = sampleIndex ^ uint(gl_FragCoord.x);
	highp uint y = sampleIndex ^ uint(gl_FragCoord.y);
	color[0] = 0;
	color[1] = 0;
	color[2] = 0;
	color[3] = 0;
	color[0] += 32768 * int(bitfieldExtract(x, 0, 1));
	color[0] += 16384 * int(bitfieldExtract(y, 0, 1));
	color[0] += 8192 * int(bitfieldExtract(x, 1, 1));
	color[0] += 4096 * int(bitfieldExtract(y, 1, 1));
	color[0] += 2048 * int(bitfieldExtract(x, 2, 1));
	color[0] += 1024 * int(bitfieldExtract(y, 2, 1));
	color[0] += 512 * int(bitfieldExtract(x, 3, 1));
	color[0] += 256 * int(bitfieldExtract(y, 3, 1));
	color[0] += 128 * int(bitfieldExtract(x, 4, 1));
	color[0] += 64 * int(bitfieldExtract(y, 4, 1));
	o_color = clamp(ivec4(color[0], color[1], color[2], color[3]), ivec4(-32768, -2147483648, -2147483648, -2147483648), ivec4(32767, 2147483647, 2147483647, 2147483647));
}
