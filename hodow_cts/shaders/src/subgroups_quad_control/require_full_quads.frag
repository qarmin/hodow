#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_vote: enable
#extension GL_EXT_shader_quad_control: enable
precision highp float;
precision highp int;
layout(full_quads) in;
layout(location = 0) in highp vec2 inTexCoords;
layout(location = 0) out vec4 outFragColor;
layout(binding = 0) uniform sampler2D texSampler;
void main (void)
{
	uint quadID = gl_SubgroupInvocationID % 4;
	uint idSum = quadID;
	idSum += subgroupQuadSwapHorizontal(quadID);
	idSum += subgroupQuadSwapVertical(quadID);
	idSum += subgroupQuadSwapDiagonal(quadID);
	outFragColor = vec4(1.0, 0.0, 0.0, 0.0);
	if (idSum == 6)
		outFragColor.g = 1.0;
	if (subgroupQuadAny(gl_HelperInvocation))
		outFragColor.b = 1.0;
	if (subgroupQuadAll(!gl_HelperInvocation))
		outFragColor.a = 1.0;
}
