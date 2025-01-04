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
