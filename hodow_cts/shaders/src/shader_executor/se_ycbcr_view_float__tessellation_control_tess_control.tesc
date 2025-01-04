#version 450
layout(binding = 1, set = 1) uniform highp sampler2D u_image;
layout(binding = 0, set = 1) uniform highp sampler2D u_planeView;


layout(vertices = 1) out;

struct Inputs
{
	highp vec2 texCoord;
};
struct Outputs
{
	highp vec4 result0;
	highp vec4 result1;
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
	vec2 texCoord = vec2(inputs[invocationId].texCoord);
	vec4 result0;
	vec4 result1;

	result0 = texture(u_image, texCoord);
	result1 = vec4(texture(u_planeView, texCoord));

	outputs[invocationId].result0 = result0;
	outputs[invocationId].result1 = result1;
}
