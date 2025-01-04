#version 450

layout(isolines, equal_spacing) in;

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
	gl_Position = vec4(gl_TessCoord.x, 0.0, 0.0, 1.0);
	highp uint invocationId = uint(gl_PrimitiveID)*2u + (gl_TessCoord.x > 0.5 ? 1u : 0u);
	uvec2 x = uvec2(inputs[invocationId].x);
	uvec2 y = uvec2(inputs[invocationId].y);
	uvec2 diff;
	uvec2 carry;

	diff = usubBorrow(x, y, carry);

	outputs[invocationId].diff = diff;
	outputs[invocationId].carry = carry;
}
