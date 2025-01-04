#version 450
layout(location = 0) in vec4 inPosition;
layout(location = 1) in vec2 inTexCoords;
layout(location = 0) out highp vec2 outTexCoords;
void main(void)
{
	gl_Position = inPosition;
	outTexCoords = inTexCoords;
}
#version 450
precision highp float;
precision highp int;
#extension GL_EXT_shader_quad_control: enable
#extension GL_KHR_shader_subgroup_vote: enable
layout(quad_derivatives) in;
layout(location = 0) in highp vec2 inTexCoords;
layout(location = 0) out vec4 outFragColor;
layout(binding = 0) uniform sampler2D texSampler;
void main (void)
{
	bool conditionTrueForOneFrag = (abs(gl_FragCoord.y - 8.5) < 0.1) && (mod(gl_FragCoord.x-3.5, 6.0) < 0.1);
	if (subgroupQuadAny(conditionTrueForOneFrag))
		outFragColor = texture(texSampler, inTexCoords);
	else
		outFragColor = vec4(0.9, 0.2, 0.2, 1.0);
}
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
#version 450
#extension GL_KHR_shader_subgroup_vote: enable
#extension GL_EXT_shader_quad_control: enable
precision highp float;
precision highp int;
layout(location = 0) out vec4 outFragColor;
bool checkCondition(int x, int y) {
	return (((x % 8) > 4) || (((x % 8) == 2) && bool(y % 2)));
}
void main (void)
{
	outFragColor = vec4(0.0, 0.0, 0.0, 1.0);
	int x = int(gl_FragCoord.x);
	int y = int(gl_FragCoord.y);
	if (checkCondition(x, y))
	{
		bool v = checkCondition(y, x);
		if (subgroupQuadAny(v))
			outFragColor.r = 1.0;
		if (subgroupQuadAll(v))
			outFragColor.g = 1.0;
	}
}
#version 450
#extension GL_EXT_terminate_invocation: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_KHR_shader_subgroup_vote: enable
#extension GL_EXT_shader_quad_control: enable
#extension GL_EXT_subgroup_uniform_control_flow: enable
layout(quad_derivatives) in;
layout(full_quads) in;
precision highp float;
precision highp int;
layout(location = 0) out vec4 outFragColor;
void main (void)
{
	outFragColor = vec4(vec3(0.0), 1.0);
	uvec4 maskA = subgroupBallot(true);
	int x = int(gl_FragCoord.x);
	int y = int(gl_FragCoord.y);
	bool isBottomRight = ((x % 2 == 1) && (y % 2 == 1));
	if (isBottomRight)
		terminateInvocation;
	uvec4 maskB = subgroupBallot(true);
	uint countA = subgroupBallotBitCount(maskA);
	uint countB = subgroupBallotBitCount(maskB);
	if (countA == countB)
		outFragColor.r += 0.4;
	if (subgroupQuadAny(isBottomRight))
		outFragColor.b += 0.4;
	if (!subgroupQuadAll(!isBottomRight))
		outFragColor.b += 0.4;
	outFragColor.g = step(outFragColor.r + outFragColor.b, 0.2);
}
#version 450
#extension GL_EXT_terminate_invocation: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_KHR_shader_subgroup_vote: enable
#extension GL_EXT_shader_quad_control: enable
#extension GL_EXT_maximal_reconvergence: enable
layout(quad_derivatives) in;
layout(full_quads) in;
precision highp float;
precision highp int;
layout(location = 0) out vec4 outFragColor;
void main (void)
{
	outFragColor = vec4(vec3(0.0), 1.0);
	uvec4 maskA = subgroupBallot(true);
	int x = int(gl_FragCoord.x);
	int y = int(gl_FragCoord.y);
	bool isBottomRight = ((x % 2 == 1) && (y % 2 == 1));
	if (isBottomRight)
		terminateInvocation;
	uvec4 maskB = subgroupBallot(true);
	uint countA = subgroupBallotBitCount(maskA);
	uint countB = subgroupBallotBitCount(maskB);
	if (countA == countB)
		outFragColor.r += 0.4;
	if (subgroupQuadAny(isBottomRight))
		outFragColor.b += 0.4;
	if (!subgroupQuadAll(!isBottomRight))
		outFragColor.b += 0.4;
	outFragColor.g = step(outFragColor.r + outFragColor.b, 0.2);
}
