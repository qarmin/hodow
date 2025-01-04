#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp uvec3 x;
	highp uvec3 y;
};
struct Outputs
{
	highp uvec3 sum;
	lowp uvec3 carry;
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
	uvec3 x = uvec3(inputs[invocationId].x);
	uvec3 y = uvec3(inputs[invocationId].y);
	uvec3 sum;
	uvec3 carry;

	sum = uaddCarry(x, y, carry);

	outputs[invocationId].sum = sum;
	outputs[invocationId].carry = carry;
}
