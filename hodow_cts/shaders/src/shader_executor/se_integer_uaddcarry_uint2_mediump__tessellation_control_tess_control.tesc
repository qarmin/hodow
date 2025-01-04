#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump uvec2 x;
	mediump uvec2 y;
};
struct Outputs
{
	mediump uvec2 sum;
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
	uvec2 sum;
	uvec2 carry;

	sum = uaddCarry(x, y, carry);

	outputs[invocationId].sum = sum;
	outputs[invocationId].carry = carry;
}
