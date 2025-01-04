#version 450
layout(binding = 0, set = 1) uniform highp sampler2D u_image;


layout(vertices = 1) out;

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
	gl_TessLevelInner[0] = 1.0;
	gl_TessLevelInner[1] = 1.0;
	gl_TessLevelOuter[0] = 1.0;
	gl_TessLevelOuter[1] = 1.0;
	gl_TessLevelOuter[2] = 1.0;
	gl_TessLevelOuter[3] = 1.0;

	highp uint invocationId = uint(gl_PrimitiveID);
	int lod = int(inputs[invocationId].lod);
	ivec2 result;

	result = textureSize(u_image, lod);

	outputs[invocationId].result = result;
}
