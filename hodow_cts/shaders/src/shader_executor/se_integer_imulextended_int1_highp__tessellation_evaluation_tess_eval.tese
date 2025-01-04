#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp int x;
	highp int y;
};
struct Outputs
{
	highp int msb;
	highp int lsb;
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
	int x = int(inputs[invocationId].x);
	int y = int(inputs[invocationId].y);
	int msb;
	int lsb;

	imulExtended(x, y, msb, lsb);

	outputs[invocationId].msb = msb;
	outputs[invocationId].lsb = lsb;
}
