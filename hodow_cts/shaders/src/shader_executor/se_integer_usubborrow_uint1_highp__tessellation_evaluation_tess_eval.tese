#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp uint x;
	highp uint y;
};
struct Outputs
{
	highp uint diff;
	lowp uint carry;
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
	uint x = uint(inputs[invocationId].x);
	uint y = uint(inputs[invocationId].y);
	uint diff;
	uint carry;

	diff = usubBorrow(x, y, carry);

	outputs[invocationId].diff = diff;
	outputs[invocationId].carry = carry;
}
