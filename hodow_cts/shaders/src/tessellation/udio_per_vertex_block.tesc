#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(vertices = 5) out;

layout(location = 0) patch out highp vec2 in_te_positionScale;
layout(location = 1) patch out highp vec2 in_te_positionOffset;

struct S
{
	highp int x;
	highp vec4 y;
	highp float z[2];
};

layout(location = 2) out TheBlock
{
	S blockS;
	highp float blockFa[3];
	S blockSa[2];
	highp float blockF;
} tcBlock[];

layout(location = 0) in highp float in_tc_attr[${vertex_size}];

void main (void)
{
	{
		highp float v = 1.3;
		v += float(gl_InvocationID)*6.4;

		// Assign values to output tcBlock
		tcBlock[gl_InvocationID].blockS.x = int(v);
		v += 0.4;
		tcBlock[gl_InvocationID].blockS.y = vec4(v, v+0.8, v+1.6, v+2.4);
		v += 0.4;
		for (int i0 = 0; i0 < 2; ++i0)
		{
			tcBlock[gl_InvocationID].blockS.z[i0] = v;
			v += 0.4;
		}
		for (int i0 = 0; i0 < 3; ++i0)
		{
			tcBlock[gl_InvocationID].blockFa[i0] = v;
			v += 0.4;
		}
		for (int i0 = 0; i0 < 2; ++i0)
		{
			tcBlock[gl_InvocationID].blockSa[i0].x = int(v);
			v += 0.4;
			tcBlock[gl_InvocationID].blockSa[i0].y = vec4(v, v+0.8, v+1.6, v+2.4);
			v += 0.4;
			for (int i1 = 0; i1 < 2; ++i1)
			{
				tcBlock[gl_InvocationID].blockSa[i0].z[i1] = v;
				v += 0.4;
			}
		}
		tcBlock[gl_InvocationID].blockF = v;
		v += 0.4;
		v += float(5-gl_InvocationID-1)*6.4;
	}

    gl_TessLevelInner[0] = in_tc_attr[0];
    gl_TessLevelInner[1] = in_tc_attr[1];

    gl_TessLevelOuter[0] = in_tc_attr[2];
    gl_TessLevelOuter[1] = in_tc_attr[3];
    gl_TessLevelOuter[2] = in_tc_attr[4];
    gl_TessLevelOuter[3] = in_tc_attr[5];

    in_te_positionScale  = vec2(in_tc_attr[6], in_tc_attr[7]);
    in_te_positionOffset = vec2(in_tc_attr[8], in_tc_attr[9]);
}
