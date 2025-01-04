#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(vertices = 5) out;

layout(location = 0) patch out highp vec2 in_te_positionScale;
layout(location = 1) patch out highp vec2 in_te_positionOffset;

struct S
{
	highp int x;
	highp vec4 y;
};

layout(location = 2) out S in_te_s[];
layout(location = 4) out highp float in_te_f[];

layout(location = 0) in highp float in_tc_attr[${vertex_size}];

void main (void)
{
	{
		highp float v = 1.3;
		v += float(gl_InvocationID)*0.8;

		// Assign values to output in_te_s
		in_te_s[gl_InvocationID].x = int(v);
		v += 0.4;
		in_te_s[gl_InvocationID].y = vec4(v, v+0.8, v+1.6, v+2.4);
		v += 0.4;
		v += float(5-gl_InvocationID-1)*0.8;
		v += float(gl_InvocationID)*0.4;

		// Assign values to output in_te_f
		in_te_f[gl_InvocationID] = v;
		v += 0.4;
		v += float(5-gl_InvocationID-1)*0.4;
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
