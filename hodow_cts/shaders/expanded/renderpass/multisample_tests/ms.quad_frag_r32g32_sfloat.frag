#version 450
layout(location = 0) out highp vec4 o_color;
layout(push_constant) uniform PushConstant {
	highp uint sampleIndex;
} pushConstants;
void main (void)
{
	highp uint sampleIndex = pushConstants.sampleIndex;
	gl_SampleMask[0] = int(0x1u << sampleIndex);
	highp float color[4];
	highp uint x = sampleIndex ^ uint(gl_FragCoord.x);
	highp uint y = sampleIndex ^ uint(gl_FragCoord.y);
	color[0] = -65536;
	color[1] = -65536;
	color[2] = 0;
	color[3] = 0;
	color[0] += 65536 * float(bitfieldExtract(x, 0, 1));
	color[1] += 65536 * float(bitfieldExtract(y, 0, 1));
	color[0] += 32768 * float(bitfieldExtract(x, 1, 1));
	color[1] += 32768 * float(bitfieldExtract(y, 1, 1));
	color[0] += 16384 * float(bitfieldExtract(x, 2, 1));
	color[1] += 16384 * float(bitfieldExtract(y, 2, 1));
	color[0] += 8192 * float(bitfieldExtract(x, 3, 1));
	color[1] += 8192 * float(bitfieldExtract(y, 3, 1));
	color[0] += 4096 * float(bitfieldExtract(x, 4, 1));
	color[1] += 4096 * float(bitfieldExtract(y, 4, 1));
	o_color = vec4(color[0], color[1], color[2], color[3]);
}
