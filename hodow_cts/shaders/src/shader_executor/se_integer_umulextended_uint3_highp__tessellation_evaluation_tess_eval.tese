#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp uvec3 x;
	highp uvec3 y;
};
struct Outputs
{
	highp uvec3 msb;
	highp uvec3 lsb;
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
	uvec3 msb;
	uvec3 lsb;

	umulExtended(x, y, msb, lsb);

	outputs[invocationId].msb = msb;
	outputs[invocationId].lsb = lsb;
}
