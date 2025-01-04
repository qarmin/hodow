#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump uvec4 x;
	mediump uvec4 y;
};
struct Outputs
{
	mediump uvec4 diff;
	lowp uvec4 carry;
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
	uvec4 x = uvec4(inputs[invocationId].x);
	uvec4 y = uvec4(inputs[invocationId].y);
	uvec4 diff;
	uvec4 carry;

	diff = usubBorrow(x, y, carry);

	outputs[invocationId].diff = diff;
	outputs[invocationId].carry = carry;
}
