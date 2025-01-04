#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump uvec4 x;
	mediump uvec4 y;
};
struct Outputs
{
	mediump uvec4 sum;
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
	gl_Position = vec4(gl_TessCoord.x, 0.0, 0.0, 1.0);
	highp uint invocationId = uint(gl_PrimitiveID)*2u + (gl_TessCoord.x > 0.5 ? 1u : 0u);
	uvec4 x = uvec4(inputs[invocationId].x);
	uvec4 y = uvec4(inputs[invocationId].y);
	uvec4 sum;
	uvec4 carry;

	sum = uaddCarry(x, y, carry);

	outputs[invocationId].sum = sum;
	outputs[invocationId].carry = carry;
}
