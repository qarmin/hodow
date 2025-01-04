#version 450

layout(vertices = 1) out;

struct Inputs
{
	mediump ivec4 value;
};
struct Outputs
{
	lowp ivec4 msb;
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
	ivec4 value = ivec4(inputs[invocationId].value);
	ivec4 msb;

	msb = findMSB(value);

	outputs[invocationId].msb = msb;
}
