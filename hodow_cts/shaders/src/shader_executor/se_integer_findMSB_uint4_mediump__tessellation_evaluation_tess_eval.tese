#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump uvec4 value;
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
	gl_Position = vec4(gl_TessCoord.x, 0.0, 0.0, 1.0);
	highp uint invocationId = uint(gl_PrimitiveID)*2u + (gl_TessCoord.x > 0.5 ? 1u : 0u);
	uvec4 value = uvec4(inputs[invocationId].value);
	ivec4 msb;

	msb = findMSB(value);

	outputs[invocationId].msb = msb;
}
