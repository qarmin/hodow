#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp ivec2 x;
	highp ivec2 y;
};
struct Outputs
{
	highp ivec2 msb;
	highp ivec2 lsb;
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
	ivec2 x = ivec2(inputs[invocationId].x);
	ivec2 y = ivec2(inputs[invocationId].y);
	ivec2 msb;
	ivec2 lsb;

	imulExtended(x, y, msb, lsb);

	outputs[invocationId].msb = msb;
	outputs[invocationId].lsb = lsb;
}
