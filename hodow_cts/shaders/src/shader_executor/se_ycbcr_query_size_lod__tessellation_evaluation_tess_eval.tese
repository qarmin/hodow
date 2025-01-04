#version 450
layout(binding = 0, set = 1) uniform highp sampler2D u_image;


layout(isolines, equal_spacing) in;

struct Inputs
{
	highp int lod;
};
struct Outputs
{
	highp ivec2 result;
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
	int lod = int(inputs[invocationId].lod);
	ivec2 result;

	result = textureSize(u_image, lod);

	outputs[invocationId].result = result;
}
