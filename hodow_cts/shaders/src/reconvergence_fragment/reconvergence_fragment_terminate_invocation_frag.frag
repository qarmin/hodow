#version 450

#extension GL_EXT_maximal_reconvergence : require
#extension GL_KHR_shader_subgroup_ballot : require
#extension GL_EXT_terminate_invocation : require

#define UINT_MAX	0xFFFFFFFF

layout(binding = 0) readonly buffer X { uint fragment; };
layout(binding = 1)          buffer Y { uint result; };
layout(location = 0) out vec4 dEQP_FragColor;

void resetBit(in out uvec4 ballot, uint bit) { if (bit < gl_SubgroupSize) ballot[bit/32] &= (UINT_MAX ^ (1u << (bit % 32))); }
uvec4 ballotResetBit(uvec4 ballot, uint bit) { resetBit(ballot, bit); return ballot; }
uint findBallotLSB(uvec4 ballot) { return subgroupBallotBitCount(ballot) > 0 ? subgroupBallotFindLSB(ballot) : UINT_MAX; }

void main()
[[maximally_reconverges]]
{
	const uint	fragmentID				= uint(gl_FragCoord.y) * 16 + uint(gl_FragCoord.x);
	const uvec4	terminateSubgroupBallot	= subgroupBallot(fragmentID == fragment);
	const uint	terminateInvocationID	= findBallotLSB(terminateSubgroupBallot);
	const bool	terminateSubgroup		= terminateInvocationID < gl_SubgroupSize;
	const uvec4	referenceBallot			= ballotResetBit(subgroupBallot(true), terminateInvocationID);


	if (terminateSubgroup && (gl_SubgroupInvocationID == terminateInvocationID))
	{
		terminateInvocation;
	}

	const uvec4	resultBallot	= subgroupBallot(true);

	const uvec4 nonHelperBallot = subgroupBallot( ! gl_HelperInvocation );
	const uint	writeInvocation	= subgroupBallotFindLSB(nonHelperBallot);

	if (terminateSubgroup && (gl_SubgroupInvocationID == writeInvocation))
	{
		result = (resultBallot == referenceBallot) ? 1 : 0;
	}

	dEQP_FragColor = vec4(1.0);
}
