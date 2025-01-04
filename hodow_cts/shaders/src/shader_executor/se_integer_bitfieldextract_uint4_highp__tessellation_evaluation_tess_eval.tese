#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp uvec4 value;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp uvec4 extracted;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
	gl_Position = vec4(gl_TessCoord.x, 0.0, 0.0, 1.0);
	highp uint invocationId = uint(gl_PrimitiveID)*2u + (gl_TessCoord.x > 0.5 ? 1u : 0u);
	uvec4 value = uvec4(inputs[invocationId].value);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	uvec4 extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationId].extracted = extracted;
}
