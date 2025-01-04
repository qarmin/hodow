#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp uint in0;
};
struct Outputs
{
	highp vec4 out0;
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
	uint in0 = uint(inputs[invocationId].in0);
	vec4 out0;

	out0 = unpackSnorm4x8(in0);

	outputs[invocationId].out0 = out0;
}
