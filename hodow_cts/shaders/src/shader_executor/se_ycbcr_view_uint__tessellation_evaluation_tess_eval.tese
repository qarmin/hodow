#version 450
layout(binding = 1, set = 1) uniform highp sampler2D u_image;
layout(binding = 0, set = 1) uniform highp usampler2D u_planeView;


layout(isolines, equal_spacing) in;

struct Inputs
{
	highp vec2 texCoord;
};
struct Outputs
{
	highp vec4 result0;
	highp uvec4 result1;
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
	vec2 texCoord = vec2(inputs[invocationId].texCoord);
	vec4 result0;
	uvec4 result1;

	result0 = texture(u_image, texCoord);
	result1 = uvec4(texture(u_planeView, texCoord));

	outputs[invocationId].result0 = result0;
	outputs[invocationId].result1 = result1;
}
