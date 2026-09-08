#version 450
layout(push_constant) uniform PushConstant {
	highp uint sampleIndex;
} pushConstants;
void main (void)
{
	highp uint sampleIndex = pushConstants.sampleIndex;
	gl_SampleMask[0] = int((~0x0u) << sampleIndex);
	highp float depth;
	highp uint x = sampleIndex ^ uint(gl_FragCoord.x);
	highp uint y = sampleIndex ^ uint(gl_FragCoord.y);
	depth = 0;
	depth += 0.5 * float(bitfieldExtract(x, 0, 1));
	depth += 0.25 * float(bitfieldExtract(y, 0, 1));
	depth += 0.125 * float(bitfieldExtract(x, 1, 1));
	depth += 0.0625 * float(bitfieldExtract(y, 1, 1));
	depth += 0.03125 * float(bitfieldExtract(x, 2, 1));
	depth += 0.015625 * float(bitfieldExtract(y, 2, 1));
	depth += 0.0078125 * float(bitfieldExtract(x, 3, 1));
	depth += 0.00390625 * float(bitfieldExtract(y, 3, 1));
	depth += 0.00195312 * float(bitfieldExtract(x, 4, 1));
	depth += 0.000976562 * float(bitfieldExtract(y, 4, 1));
	gl_FragDepth = depth;
}
