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
	color[0] += 1073741824 * bitfieldExtract(x, 0, 1);
	color[1] += 1073741824 * bitfieldExtract(y, 0, 1);
	color[2] += 1073741824 * bitfieldExtract(x, 1, 1);
	color[3] += 1073741824 * bitfieldExtract(y, 1, 1);
	color[0] += 536870912 * bitfieldExtract(x, 2, 1);
	color[1] += 536870912 * bitfieldExtract(y, 2, 1);
	color[2] += 536870912 * bitfieldExtract(x, 3, 1);
	color[3] += 536870912 * bitfieldExtract(y, 3, 1);
	color[0] += 268435456 * bitfieldExtract(x, 4, 1);
	color[1] += 268435456 * bitfieldExtract(y, 4, 1);
	color[2] += 268435456 * bitfieldExtract(x, 5, 1);
	color[3] += 268435456 * bitfieldExtract(y, 5, 1);
	o_color = uvec4(color[0], color[1], color[2], color[3]);
}
