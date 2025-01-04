#version 450

#extension GL_EXT_maximal_reconvergence : require
#extension GL_KHR_shader_subgroup_ballot : require
#extension GL_EXT_demote_to_helper_invocation : require

layout(binding = 0) readonly buffer X { uvec4 fragments; };
layout(binding = 1)          buffer Y { uint  result; };
layout(location = 0) out vec4 dEQP_FragColor;

void main()
[[maximally_reconverges]]
{
	const uvec4	fullBallot		= subgroupBallot( ! helperInvocationEXT() );
	const uint	fragmentID		= uint(gl_FragCoord.y) * 16 + uint(gl_FragCoord.x);
	const uvec4	quadBallot		= subgroupBallot((fragments[gl_SubgroupInvocationID % 4] - fragmentID) == 0);
	const bool	quadSubgroup	= subgroupBallotBitCount(quadBallot) == 1;

	if (quadSubgroup && subgroupInverseBallot(quadBallot))
	{
		switch (gl_SubgroupInvocationID % 4)
		{
		case 0:
			{
				while (true)
				{
					subgroupMemoryBarrier();
					if (subgroupElect())
					{
						break;
					}
				}
				demote;
			}
			break;
		case 1:
			{
				do
				{
					subgroupMemoryBarrierBuffer();
					if (subgroupElect())
					{
						break;
					}
				}
				while (quadSubgroup);
				demote;
			}
			break;
		case 2:
			{
				while (quadSubgroup)
				{
					subgroupMemoryBarrierBuffer();
					if (subgroupElect())
					{
						break;
					}
				}
				demote;
			}
			break;
		case 3:
			{
				for (;;)
				{
					subgroupMemoryBarrier();
					if (subgroupElect())
					{
						break;
					}
				}
				demote;
			}
			break;
		}
	}

	const uvec4 nonHelperBallot = subgroupBallot( ! helperInvocationEXT() );
	const uvec4	demotedBallot	= nonHelperBallot ^ fullBallot;
	const uint	writeInvocation	= subgroupBallotFindLSB(nonHelperBallot);

	if (quadSubgroup && gl_SubgroupInvocationID == writeInvocation)
	{
		result = (demotedBallot == quadBallot) ? 1 : 0;
	}

	dEQP_FragColor = vec4(1.0);
}
