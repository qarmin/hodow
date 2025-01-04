#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp uvec2 x;
	highp uvec2 y;
};
struct Outputs
{
	highp uvec2 diff;
	lowp uvec2 carry;
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
	gl_TessLevelInner[0] = 1.0;
	gl_TessLevelInner[1] = 1.0;
	gl_TessLevelOuter[0] = 1.0;
	gl_TessLevelOuter[1] = 1.0;
	gl_TessLevelOuter[2] = 1.0;
	gl_TessLevelOuter[3] = 1.0;

	highp uint invocationId = uint(gl_PrimitiveID);
	uvec2 x = uvec2(inputs[invocationId].x);
	uvec2 y = uvec2(inputs[invocationId].y);
	uvec2 diff;
	uvec2 carry;

	diff = usubBorrow(x, y, carry);

	outputs[invocationId].diff = diff;
	outputs[invocationId].carry = carry;
}
