#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump vec4 in0;
};
struct Outputs
{
	highp uint out0;
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
	vec4 in0 = vec4(inputs[invocationId].in0);
	uint out0;

	out0 = packSnorm4x8(in0);

	outputs[invocationId].out0 = out0;
}
