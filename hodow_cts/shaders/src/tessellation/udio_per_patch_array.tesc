#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(vertices = 5) out;

layout(location = 0) patch out highp vec2 in_te_positionScale;
layout(location = 1) patch out highp vec2 in_te_positionOffset;

layout(location = 2) patch out highp float in_te_f[3];

layout(location = 0) in highp float in_tc_attr[${vertex_size}];

void main (void)
{
	{
		highp float v = 1.3;

		// Assign values to output in_te_f
		for (int i0 = 0; i0 < 3; ++i0)
		{
			in_te_f[i0] = v;
			v += 0.4;
		}
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
