#version 310 es

layout(location = 0) in  highp float in_v_attr;
layout(location = 0) out highp float in_tc_attr;

void main (void)
{
    in_tc_attr = in_v_attr;
}
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

layout(location = 2) patch out S in_te_s;
layout(location = 4) patch out highp float in_te_f;

layout(location = 0) in highp float in_tc_attr[];

void main (void)
{
	{
		highp float v = 1.3;

		// Assign values to output in_te_s
		in_te_s.x = int(v);
		v += 0.4;
		in_te_s.y = vec4(v, v+0.8, v+1.6, v+2.4);
		v += 0.4;

		// Assign values to output in_te_f
		in_te_f = v;
		v += 0.4;
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
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

struct S
{
	highp int x;
	highp vec4 y;
};

layout(location = 2) patch in S in_te_s;
layout(location = 4) patch in highp float in_te_f;

layout(location = 0) out highp vec4 in_f_color;

// Will contain the index of the first incorrect input,
// or the number of inputs if all are correct
layout (set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
    uint firstFailedInputIndex[];
} sb_out;

bool compare_int   (int   a, int   b) { return a == b; }
bool compare_float (float a, float b) { return abs(a - b) < 0.01f; }
bool compare_vec4  (vec4  a, vec4  b) { return all(lessThan(abs(a - b), vec4(0.01f))); }

void main (void)
{
	bool allOk = true;
	highp uint firstFailedInputIndex = 0u;
	{
		highp float v = 1.3;

		// Check values in input in_te_s
		allOk = allOk && compare_int(in_te_s.x, int(v));
		v += 0.4;
		if (allOk) ++firstFailedInputIndex;
		allOk = allOk && compare_vec4(in_te_s.y, vec4(v, v+0.8, v+1.6, v+2.4));
		v += 0.4;
		if (allOk) ++firstFailedInputIndex;

		// Check values in input in_te_f
		allOk = allOk && compare_float(in_te_f, v);
		v += 0.4;
		if (allOk) ++firstFailedInputIndex;
	}

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
    in_f_color  = allOk ? vec4(0.0, 1.0, 0.0, 1.0)
                        : vec4(1.0, 0.0, 0.0, 1.0);

    int index = atomicAdd(sb_out.numInvocations, 1);
    sb_out.firstFailedInputIndex[index] = firstFailedInputIndex;
}
#version 310 es

layout(location = 0) in  highp   vec4 in_f_color;
layout(location = 0) out mediump vec4 o_color;

void main (void)
{
    o_color = in_f_color;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

struct S
{
	highp int x;
	highp vec4 y;
};

layout(location = 2) patch in S in_te_s;
layout(location = 4) patch in highp float in_te_f;

layout(location = 0) out highp vec4 in_f_color;

// Will contain the index of the first incorrect input,
// or the number of inputs if all are correct
layout (set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
    uint firstFailedInputIndex[];
} sb_out;

bool compare_int   (int   a, int   b) { return a == b; }
bool compare_float (float a, float b) { return abs(a - b) < 0.01f; }
bool compare_vec4  (vec4  a, vec4  b) { return all(lessThan(abs(a - b), vec4(0.01f))); }

void main (void)
{
	bool allOk = true;
	highp uint firstFailedInputIndex = 0u;
	{
		highp float v = 1.3;

		// Check values in input in_te_s
		allOk = allOk && compare_int(in_te_s.x, int(v));
		v += 0.4;
		if (allOk) ++firstFailedInputIndex;
		allOk = allOk && compare_vec4(in_te_s.y, vec4(v, v+0.8, v+1.6, v+2.4));
		v += 0.4;
		if (allOk) ++firstFailedInputIndex;

		// Check values in input in_te_f
		allOk = allOk && compare_float(in_te_f, v);
		v += 0.4;
		if (allOk) ++firstFailedInputIndex;
	}

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
    in_f_color  = allOk ? vec4(0.0, 1.0, 0.0, 1.0)
                        : vec4(1.0, 0.0, 0.0, 1.0);

    int index = atomicAdd(sb_out.numInvocations, 1);
    sb_out.firstFailedInputIndex[index] = firstFailedInputIndex;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(isolines) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

struct S
{
	highp int x;
	highp vec4 y;
};

layout(location = 2) patch in S in_te_s;
layout(location = 4) patch in highp float in_te_f;

layout(location = 0) out highp vec4 in_f_color;

// Will contain the index of the first incorrect input,
// or the number of inputs if all are correct
layout (set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
    uint firstFailedInputIndex[];
} sb_out;

bool compare_int   (int   a, int   b) { return a == b; }
bool compare_float (float a, float b) { return abs(a - b) < 0.01f; }
bool compare_vec4  (vec4  a, vec4  b) { return all(lessThan(abs(a - b), vec4(0.01f))); }

void main (void)
{
	bool allOk = true;
	highp uint firstFailedInputIndex = 0u;
	{
		highp float v = 1.3;

		// Check values in input in_te_s
		allOk = allOk && compare_int(in_te_s.x, int(v));
		v += 0.4;
		if (allOk) ++firstFailedInputIndex;
		allOk = allOk && compare_vec4(in_te_s.y, vec4(v, v+0.8, v+1.6, v+2.4));
		v += 0.4;
		if (allOk) ++firstFailedInputIndex;

		// Check values in input in_te_f
		allOk = allOk && compare_float(in_te_f, v);
		v += 0.4;
		if (allOk) ++firstFailedInputIndex;
	}

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
    in_f_color  = allOk ? vec4(0.0, 1.0, 0.0, 1.0)
                        : vec4(1.0, 0.0, 0.0, 1.0);

    int index = atomicAdd(sb_out.numInvocations, 1);
    sb_out.firstFailedInputIndex[index] = firstFailedInputIndex;
}
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

layout(location = 2) patch out S in_te_s;
layout(location = 4) patch out highp float in_te_f;

layout(location = 0) in highp float in_tc_attr[gl_MaxPatchVertices];

void main (void)
{
	{
		highp float v = 1.3;

		// Assign values to output in_te_s
		in_te_s.x = int(v);
		v += 0.4;
		in_te_s.y = vec4(v, v+0.8, v+1.6, v+2.4);
		v += 0.4;

		// Assign values to output in_te_f
		in_te_f = v;
		v += 0.4;
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

layout(location = 2) patch out S in_te_s;
layout(location = 4) patch out highp float in_te_f;

layout(location = 0) in highp float in_tc_attr[32];

void main (void)
{
	{
		highp float v = 1.3;

		// Assign values to output in_te_s
		in_te_s.x = int(v);
		v += 0.4;
		in_te_s.y = vec4(v, v+0.8, v+1.6, v+2.4);
		v += 0.4;

		// Assign values to output in_te_f
		in_te_f = v;
		v += 0.4;
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
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(vertices = 5) out;

layout(location = 0) patch out highp vec2 in_te_positionScale;
layout(location = 1) patch out highp vec2 in_te_positionOffset;

layout(location = 2) patch out highp float in_te_f[3];

layout(location = 0) in highp float in_tc_attr[];

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

layout(location = 2) patch in highp float in_te_f[3];

layout(location = 0) out highp vec4 in_f_color;

// Will contain the index of the first incorrect input,
// or the number of inputs if all are correct
layout (set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
    uint firstFailedInputIndex[];
} sb_out;

bool compare_int   (int   a, int   b) { return a == b; }
bool compare_float (float a, float b) { return abs(a - b) < 0.01f; }
bool compare_vec4  (vec4  a, vec4  b) { return all(lessThan(abs(a - b), vec4(0.01f))); }

void main (void)
{
	bool allOk = true;
	highp uint firstFailedInputIndex = 0u;
	{
		highp float v = 1.3;

		// Check values in input in_te_f
		for (int i0 = 0; i0 < 3; ++i0)
		{
			allOk = allOk && compare_float(in_te_f[i0], v);
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
		}
	}

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
    in_f_color  = allOk ? vec4(0.0, 1.0, 0.0, 1.0)
                        : vec4(1.0, 0.0, 0.0, 1.0);

    int index = atomicAdd(sb_out.numInvocations, 1);
    sb_out.firstFailedInputIndex[index] = firstFailedInputIndex;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

layout(location = 2) patch in highp float in_te_f[3];

layout(location = 0) out highp vec4 in_f_color;

// Will contain the index of the first incorrect input,
// or the number of inputs if all are correct
layout (set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
    uint firstFailedInputIndex[];
} sb_out;

bool compare_int   (int   a, int   b) { return a == b; }
bool compare_float (float a, float b) { return abs(a - b) < 0.01f; }
bool compare_vec4  (vec4  a, vec4  b) { return all(lessThan(abs(a - b), vec4(0.01f))); }

void main (void)
{
	bool allOk = true;
	highp uint firstFailedInputIndex = 0u;
	{
		highp float v = 1.3;

		// Check values in input in_te_f
		for (int i0 = 0; i0 < 3; ++i0)
		{
			allOk = allOk && compare_float(in_te_f[i0], v);
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
		}
	}

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
    in_f_color  = allOk ? vec4(0.0, 1.0, 0.0, 1.0)
                        : vec4(1.0, 0.0, 0.0, 1.0);

    int index = atomicAdd(sb_out.numInvocations, 1);
    sb_out.firstFailedInputIndex[index] = firstFailedInputIndex;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(isolines) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

layout(location = 2) patch in highp float in_te_f[3];

layout(location = 0) out highp vec4 in_f_color;

// Will contain the index of the first incorrect input,
// or the number of inputs if all are correct
layout (set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
    uint firstFailedInputIndex[];
} sb_out;

bool compare_int   (int   a, int   b) { return a == b; }
bool compare_float (float a, float b) { return abs(a - b) < 0.01f; }
bool compare_vec4  (vec4  a, vec4  b) { return all(lessThan(abs(a - b), vec4(0.01f))); }

void main (void)
{
	bool allOk = true;
	highp uint firstFailedInputIndex = 0u;
	{
		highp float v = 1.3;

		// Check values in input in_te_f
		for (int i0 = 0; i0 < 3; ++i0)
		{
			allOk = allOk && compare_float(in_te_f[i0], v);
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
		}
	}

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
    in_f_color  = allOk ? vec4(0.0, 1.0, 0.0, 1.0)
                        : vec4(1.0, 0.0, 0.0, 1.0);

    int index = atomicAdd(sb_out.numInvocations, 1);
    sb_out.firstFailedInputIndex[index] = firstFailedInputIndex;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(vertices = 5) out;

layout(location = 0) patch out highp vec2 in_te_positionScale;
layout(location = 1) patch out highp vec2 in_te_positionOffset;

layout(location = 2) patch out highp float in_te_f[3];

layout(location = 0) in highp float in_tc_attr[gl_MaxPatchVertices];

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(vertices = 5) out;

layout(location = 0) patch out highp vec2 in_te_positionScale;
layout(location = 1) patch out highp vec2 in_te_positionOffset;

layout(location = 2) patch out highp float in_te_f[3];

layout(location = 0) in highp float in_tc_attr[32];

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

layout(location = 2) patch out TheBlock
{
	S blockS;
	highp float blockFa[3];
	S blockSa[2];
	highp float blockF;
} tcBlock;

layout(location = 0) in highp float in_tc_attr[];

void main (void)
{
	{
		highp float v = 1.3;

		// Assign values to output tcBlock
		tcBlock.blockS.x = int(v);
		v += 0.4;
		tcBlock.blockS.y = vec4(v, v+0.8, v+1.6, v+2.4);
		v += 0.4;
		for (int i0 = 0; i0 < 2; ++i0)
		{
			tcBlock.blockS.z[i0] = v;
			v += 0.4;
		}
		for (int i0 = 0; i0 < 3; ++i0)
		{
			tcBlock.blockFa[i0] = v;
			v += 0.4;
		}
		for (int i0 = 0; i0 < 2; ++i0)
		{
			tcBlock.blockSa[i0].x = int(v);
			v += 0.4;
			tcBlock.blockSa[i0].y = vec4(v, v+0.8, v+1.6, v+2.4);
			v += 0.4;
			for (int i1 = 0; i1 < 2; ++i1)
			{
				tcBlock.blockSa[i0].z[i1] = v;
				v += 0.4;
			}
		}
		tcBlock.blockF = v;
		v += 0.4;
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
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

struct S
{
	highp int x;
	highp vec4 y;
	highp float z[2];
};

layout(location = 2) patch in TheBlock
{
	S blockS;
	highp float blockFa[3];
	S blockSa[2];
	highp float blockF;
} teBlock;

layout(location = 0) out highp vec4 in_f_color;

// Will contain the index of the first incorrect input,
// or the number of inputs if all are correct
layout (set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
    uint firstFailedInputIndex[];
} sb_out;

bool compare_int   (int   a, int   b) { return a == b; }
bool compare_float (float a, float b) { return abs(a - b) < 0.01f; }
bool compare_vec4  (vec4  a, vec4  b) { return all(lessThan(abs(a - b), vec4(0.01f))); }

void main (void)
{
	bool allOk = true;
	highp uint firstFailedInputIndex = 0u;
	{
		highp float v = 1.3;

		// Check values in input teBlock
		allOk = allOk && compare_int(teBlock.blockS.x, int(v));
		v += 0.4;
		if (allOk) ++firstFailedInputIndex;
		allOk = allOk && compare_vec4(teBlock.blockS.y, vec4(v, v+0.8, v+1.6, v+2.4));
		v += 0.4;
		if (allOk) ++firstFailedInputIndex;
		for (int i0 = 0; i0 < 2; ++i0)
		{
			allOk = allOk && compare_float(teBlock.blockS.z[i0], v);
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
		}
		for (int i0 = 0; i0 < 3; ++i0)
		{
			allOk = allOk && compare_float(teBlock.blockFa[i0], v);
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
		}
		for (int i0 = 0; i0 < 2; ++i0)
		{
			allOk = allOk && compare_int(teBlock.blockSa[i0].x, int(v));
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
			allOk = allOk && compare_vec4(teBlock.blockSa[i0].y, vec4(v, v+0.8, v+1.6, v+2.4));
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
			for (int i1 = 0; i1 < 2; ++i1)
			{
				allOk = allOk && compare_float(teBlock.blockSa[i0].z[i1], v);
				v += 0.4;
				if (allOk) ++firstFailedInputIndex;
			}
		}
		allOk = allOk && compare_float(teBlock.blockF, v);
		v += 0.4;
		if (allOk) ++firstFailedInputIndex;
	}

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
    in_f_color  = allOk ? vec4(0.0, 1.0, 0.0, 1.0)
                        : vec4(1.0, 0.0, 0.0, 1.0);

    int index = atomicAdd(sb_out.numInvocations, 1);
    sb_out.firstFailedInputIndex[index] = firstFailedInputIndex;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

struct S
{
	highp int x;
	highp vec4 y;
	highp float z[2];
};

layout(location = 2) patch in TheBlock
{
	S blockS;
	highp float blockFa[3];
	S blockSa[2];
	highp float blockF;
} teBlock;

layout(location = 0) out highp vec4 in_f_color;

// Will contain the index of the first incorrect input,
// or the number of inputs if all are correct
layout (set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
    uint firstFailedInputIndex[];
} sb_out;

bool compare_int   (int   a, int   b) { return a == b; }
bool compare_float (float a, float b) { return abs(a - b) < 0.01f; }
bool compare_vec4  (vec4  a, vec4  b) { return all(lessThan(abs(a - b), vec4(0.01f))); }

void main (void)
{
	bool allOk = true;
	highp uint firstFailedInputIndex = 0u;
	{
		highp float v = 1.3;

		// Check values in input teBlock
		allOk = allOk && compare_int(teBlock.blockS.x, int(v));
		v += 0.4;
		if (allOk) ++firstFailedInputIndex;
		allOk = allOk && compare_vec4(teBlock.blockS.y, vec4(v, v+0.8, v+1.6, v+2.4));
		v += 0.4;
		if (allOk) ++firstFailedInputIndex;
		for (int i0 = 0; i0 < 2; ++i0)
		{
			allOk = allOk && compare_float(teBlock.blockS.z[i0], v);
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
		}
		for (int i0 = 0; i0 < 3; ++i0)
		{
			allOk = allOk && compare_float(teBlock.blockFa[i0], v);
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
		}
		for (int i0 = 0; i0 < 2; ++i0)
		{
			allOk = allOk && compare_int(teBlock.blockSa[i0].x, int(v));
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
			allOk = allOk && compare_vec4(teBlock.blockSa[i0].y, vec4(v, v+0.8, v+1.6, v+2.4));
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
			for (int i1 = 0; i1 < 2; ++i1)
			{
				allOk = allOk && compare_float(teBlock.blockSa[i0].z[i1], v);
				v += 0.4;
				if (allOk) ++firstFailedInputIndex;
			}
		}
		allOk = allOk && compare_float(teBlock.blockF, v);
		v += 0.4;
		if (allOk) ++firstFailedInputIndex;
	}

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
    in_f_color  = allOk ? vec4(0.0, 1.0, 0.0, 1.0)
                        : vec4(1.0, 0.0, 0.0, 1.0);

    int index = atomicAdd(sb_out.numInvocations, 1);
    sb_out.firstFailedInputIndex[index] = firstFailedInputIndex;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(isolines) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

struct S
{
	highp int x;
	highp vec4 y;
	highp float z[2];
};

layout(location = 2) patch in TheBlock
{
	S blockS;
	highp float blockFa[3];
	S blockSa[2];
	highp float blockF;
} teBlock;

layout(location = 0) out highp vec4 in_f_color;

// Will contain the index of the first incorrect input,
// or the number of inputs if all are correct
layout (set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
    uint firstFailedInputIndex[];
} sb_out;

bool compare_int   (int   a, int   b) { return a == b; }
bool compare_float (float a, float b) { return abs(a - b) < 0.01f; }
bool compare_vec4  (vec4  a, vec4  b) { return all(lessThan(abs(a - b), vec4(0.01f))); }

void main (void)
{
	bool allOk = true;
	highp uint firstFailedInputIndex = 0u;
	{
		highp float v = 1.3;

		// Check values in input teBlock
		allOk = allOk && compare_int(teBlock.blockS.x, int(v));
		v += 0.4;
		if (allOk) ++firstFailedInputIndex;
		allOk = allOk && compare_vec4(teBlock.blockS.y, vec4(v, v+0.8, v+1.6, v+2.4));
		v += 0.4;
		if (allOk) ++firstFailedInputIndex;
		for (int i0 = 0; i0 < 2; ++i0)
		{
			allOk = allOk && compare_float(teBlock.blockS.z[i0], v);
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
		}
		for (int i0 = 0; i0 < 3; ++i0)
		{
			allOk = allOk && compare_float(teBlock.blockFa[i0], v);
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
		}
		for (int i0 = 0; i0 < 2; ++i0)
		{
			allOk = allOk && compare_int(teBlock.blockSa[i0].x, int(v));
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
			allOk = allOk && compare_vec4(teBlock.blockSa[i0].y, vec4(v, v+0.8, v+1.6, v+2.4));
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
			for (int i1 = 0; i1 < 2; ++i1)
			{
				allOk = allOk && compare_float(teBlock.blockSa[i0].z[i1], v);
				v += 0.4;
				if (allOk) ++firstFailedInputIndex;
			}
		}
		allOk = allOk && compare_float(teBlock.blockF, v);
		v += 0.4;
		if (allOk) ++firstFailedInputIndex;
	}

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
    in_f_color  = allOk ? vec4(0.0, 1.0, 0.0, 1.0)
                        : vec4(1.0, 0.0, 0.0, 1.0);

    int index = atomicAdd(sb_out.numInvocations, 1);
    sb_out.firstFailedInputIndex[index] = firstFailedInputIndex;
}
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

layout(location = 2) patch out TheBlock
{
	S blockS;
	highp float blockFa[3];
	S blockSa[2];
	highp float blockF;
} tcBlock;

layout(location = 0) in highp float in_tc_attr[gl_MaxPatchVertices];

void main (void)
{
	{
		highp float v = 1.3;

		// Assign values to output tcBlock
		tcBlock.blockS.x = int(v);
		v += 0.4;
		tcBlock.blockS.y = vec4(v, v+0.8, v+1.6, v+2.4);
		v += 0.4;
		for (int i0 = 0; i0 < 2; ++i0)
		{
			tcBlock.blockS.z[i0] = v;
			v += 0.4;
		}
		for (int i0 = 0; i0 < 3; ++i0)
		{
			tcBlock.blockFa[i0] = v;
			v += 0.4;
		}
		for (int i0 = 0; i0 < 2; ++i0)
		{
			tcBlock.blockSa[i0].x = int(v);
			v += 0.4;
			tcBlock.blockSa[i0].y = vec4(v, v+0.8, v+1.6, v+2.4);
			v += 0.4;
			for (int i1 = 0; i1 < 2; ++i1)
			{
				tcBlock.blockSa[i0].z[i1] = v;
				v += 0.4;
			}
		}
		tcBlock.blockF = v;
		v += 0.4;
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

layout(location = 2) patch out TheBlock
{
	S blockS;
	highp float blockFa[3];
	S blockSa[2];
	highp float blockF;
} tcBlock;

layout(location = 0) in highp float in_tc_attr[32];

void main (void)
{
	{
		highp float v = 1.3;

		// Assign values to output tcBlock
		tcBlock.blockS.x = int(v);
		v += 0.4;
		tcBlock.blockS.y = vec4(v, v+0.8, v+1.6, v+2.4);
		v += 0.4;
		for (int i0 = 0; i0 < 2; ++i0)
		{
			tcBlock.blockS.z[i0] = v;
			v += 0.4;
		}
		for (int i0 = 0; i0 < 3; ++i0)
		{
			tcBlock.blockFa[i0] = v;
			v += 0.4;
		}
		for (int i0 = 0; i0 < 2; ++i0)
		{
			tcBlock.blockSa[i0].x = int(v);
			v += 0.4;
			tcBlock.blockSa[i0].y = vec4(v, v+0.8, v+1.6, v+2.4);
			v += 0.4;
			for (int i1 = 0; i1 < 2; ++i1)
			{
				tcBlock.blockSa[i0].z[i1] = v;
				v += 0.4;
			}
		}
		tcBlock.blockF = v;
		v += 0.4;
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

layout(location = 2) patch out TheBlock
{
	highp float blockFa[3];
	S blockSa[2];
	highp float blockF;
} tcBlock[2];

layout(location = 0) in highp float in_tc_attr[];

void main (void)
{
	{
		highp float v = 1.3;

		// Assign values to output tcBlock
		for (int i0 = 0; i0 < 2; ++i0)
		{
			for (int i1 = 0; i1 < 3; ++i1)
			{
				tcBlock[i0].blockFa[i1] = v;
				v += 0.4;
			}
			for (int i1 = 0; i1 < 2; ++i1)
			{
				tcBlock[i0].blockSa[i1].x = int(v);
				v += 0.4;
				tcBlock[i0].blockSa[i1].y = vec4(v, v+0.8, v+1.6, v+2.4);
				v += 0.4;
				for (int i2 = 0; i2 < 2; ++i2)
				{
					tcBlock[i0].blockSa[i1].z[i2] = v;
					v += 0.4;
				}
			}
			tcBlock[i0].blockF = v;
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
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

struct S
{
	highp int x;
	highp vec4 y;
	highp float z[2];
};

layout(location = 2) patch in TheBlock
{
	highp float blockFa[3];
	S blockSa[2];
	highp float blockF;
} teBlock[2];

layout(location = 0) out highp vec4 in_f_color;

// Will contain the index of the first incorrect input,
// or the number of inputs if all are correct
layout (set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
    uint firstFailedInputIndex[];
} sb_out;

bool compare_int   (int   a, int   b) { return a == b; }
bool compare_float (float a, float b) { return abs(a - b) < 0.01f; }
bool compare_vec4  (vec4  a, vec4  b) { return all(lessThan(abs(a - b), vec4(0.01f))); }

void main (void)
{
	bool allOk = true;
	highp uint firstFailedInputIndex = 0u;
	{
		highp float v = 1.3;

		// Check values in input teBlock
		for (int i0 = 0; i0 < 2; ++i0)
		{
			for (int i1 = 0; i1 < 3; ++i1)
			{
				allOk = allOk && compare_float(teBlock[i0].blockFa[i1], v);
				v += 0.4;
				if (allOk) ++firstFailedInputIndex;
			}
			for (int i1 = 0; i1 < 2; ++i1)
			{
				allOk = allOk && compare_int(teBlock[i0].blockSa[i1].x, int(v));
				v += 0.4;
				if (allOk) ++firstFailedInputIndex;
				allOk = allOk && compare_vec4(teBlock[i0].blockSa[i1].y, vec4(v, v+0.8, v+1.6, v+2.4));
				v += 0.4;
				if (allOk) ++firstFailedInputIndex;
				for (int i2 = 0; i2 < 2; ++i2)
				{
					allOk = allOk && compare_float(teBlock[i0].blockSa[i1].z[i2], v);
					v += 0.4;
					if (allOk) ++firstFailedInputIndex;
				}
			}
			allOk = allOk && compare_float(teBlock[i0].blockF, v);
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
		}
	}

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
    in_f_color  = allOk ? vec4(0.0, 1.0, 0.0, 1.0)
                        : vec4(1.0, 0.0, 0.0, 1.0);

    int index = atomicAdd(sb_out.numInvocations, 1);
    sb_out.firstFailedInputIndex[index] = firstFailedInputIndex;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

struct S
{
	highp int x;
	highp vec4 y;
	highp float z[2];
};

layout(location = 2) patch in TheBlock
{
	highp float blockFa[3];
	S blockSa[2];
	highp float blockF;
} teBlock[2];

layout(location = 0) out highp vec4 in_f_color;

// Will contain the index of the first incorrect input,
// or the number of inputs if all are correct
layout (set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
    uint firstFailedInputIndex[];
} sb_out;

bool compare_int   (int   a, int   b) { return a == b; }
bool compare_float (float a, float b) { return abs(a - b) < 0.01f; }
bool compare_vec4  (vec4  a, vec4  b) { return all(lessThan(abs(a - b), vec4(0.01f))); }

void main (void)
{
	bool allOk = true;
	highp uint firstFailedInputIndex = 0u;
	{
		highp float v = 1.3;

		// Check values in input teBlock
		for (int i0 = 0; i0 < 2; ++i0)
		{
			for (int i1 = 0; i1 < 3; ++i1)
			{
				allOk = allOk && compare_float(teBlock[i0].blockFa[i1], v);
				v += 0.4;
				if (allOk) ++firstFailedInputIndex;
			}
			for (int i1 = 0; i1 < 2; ++i1)
			{
				allOk = allOk && compare_int(teBlock[i0].blockSa[i1].x, int(v));
				v += 0.4;
				if (allOk) ++firstFailedInputIndex;
				allOk = allOk && compare_vec4(teBlock[i0].blockSa[i1].y, vec4(v, v+0.8, v+1.6, v+2.4));
				v += 0.4;
				if (allOk) ++firstFailedInputIndex;
				for (int i2 = 0; i2 < 2; ++i2)
				{
					allOk = allOk && compare_float(teBlock[i0].blockSa[i1].z[i2], v);
					v += 0.4;
					if (allOk) ++firstFailedInputIndex;
				}
			}
			allOk = allOk && compare_float(teBlock[i0].blockF, v);
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
		}
	}

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
    in_f_color  = allOk ? vec4(0.0, 1.0, 0.0, 1.0)
                        : vec4(1.0, 0.0, 0.0, 1.0);

    int index = atomicAdd(sb_out.numInvocations, 1);
    sb_out.firstFailedInputIndex[index] = firstFailedInputIndex;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(isolines) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

struct S
{
	highp int x;
	highp vec4 y;
	highp float z[2];
};

layout(location = 2) patch in TheBlock
{
	highp float blockFa[3];
	S blockSa[2];
	highp float blockF;
} teBlock[2];

layout(location = 0) out highp vec4 in_f_color;

// Will contain the index of the first incorrect input,
// or the number of inputs if all are correct
layout (set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
    uint firstFailedInputIndex[];
} sb_out;

bool compare_int   (int   a, int   b) { return a == b; }
bool compare_float (float a, float b) { return abs(a - b) < 0.01f; }
bool compare_vec4  (vec4  a, vec4  b) { return all(lessThan(abs(a - b), vec4(0.01f))); }

void main (void)
{
	bool allOk = true;
	highp uint firstFailedInputIndex = 0u;
	{
		highp float v = 1.3;

		// Check values in input teBlock
		for (int i0 = 0; i0 < 2; ++i0)
		{
			for (int i1 = 0; i1 < 3; ++i1)
			{
				allOk = allOk && compare_float(teBlock[i0].blockFa[i1], v);
				v += 0.4;
				if (allOk) ++firstFailedInputIndex;
			}
			for (int i1 = 0; i1 < 2; ++i1)
			{
				allOk = allOk && compare_int(teBlock[i0].blockSa[i1].x, int(v));
				v += 0.4;
				if (allOk) ++firstFailedInputIndex;
				allOk = allOk && compare_vec4(teBlock[i0].blockSa[i1].y, vec4(v, v+0.8, v+1.6, v+2.4));
				v += 0.4;
				if (allOk) ++firstFailedInputIndex;
				for (int i2 = 0; i2 < 2; ++i2)
				{
					allOk = allOk && compare_float(teBlock[i0].blockSa[i1].z[i2], v);
					v += 0.4;
					if (allOk) ++firstFailedInputIndex;
				}
			}
			allOk = allOk && compare_float(teBlock[i0].blockF, v);
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
		}
	}

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
    in_f_color  = allOk ? vec4(0.0, 1.0, 0.0, 1.0)
                        : vec4(1.0, 0.0, 0.0, 1.0);

    int index = atomicAdd(sb_out.numInvocations, 1);
    sb_out.firstFailedInputIndex[index] = firstFailedInputIndex;
}
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

layout(location = 2) patch out TheBlock
{
	highp float blockFa[3];
	S blockSa[2];
	highp float blockF;
} tcBlock[2];

layout(location = 0) in highp float in_tc_attr[gl_MaxPatchVertices];

void main (void)
{
	{
		highp float v = 1.3;

		// Assign values to output tcBlock
		for (int i0 = 0; i0 < 2; ++i0)
		{
			for (int i1 = 0; i1 < 3; ++i1)
			{
				tcBlock[i0].blockFa[i1] = v;
				v += 0.4;
			}
			for (int i1 = 0; i1 < 2; ++i1)
			{
				tcBlock[i0].blockSa[i1].x = int(v);
				v += 0.4;
				tcBlock[i0].blockSa[i1].y = vec4(v, v+0.8, v+1.6, v+2.4);
				v += 0.4;
				for (int i2 = 0; i2 < 2; ++i2)
				{
					tcBlock[i0].blockSa[i1].z[i2] = v;
					v += 0.4;
				}
			}
			tcBlock[i0].blockF = v;
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

layout(location = 2) patch out TheBlock
{
	highp float blockFa[3];
	S blockSa[2];
	highp float blockF;
} tcBlock[2];

layout(location = 0) in highp float in_tc_attr[32];

void main (void)
{
	{
		highp float v = 1.3;

		// Assign values to output tcBlock
		for (int i0 = 0; i0 < 2; ++i0)
		{
			for (int i1 = 0; i1 < 3; ++i1)
			{
				tcBlock[i0].blockFa[i1] = v;
				v += 0.4;
			}
			for (int i1 = 0; i1 < 2; ++i1)
			{
				tcBlock[i0].blockSa[i1].x = int(v);
				v += 0.4;
				tcBlock[i0].blockSa[i1].y = vec4(v, v+0.8, v+1.6, v+2.4);
				v += 0.4;
				for (int i2 = 0; i2 < 2; ++i2)
				{
					tcBlock[i0].blockSa[i1].z[i2] = v;
					v += 0.4;
				}
			}
			tcBlock[i0].blockF = v;
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

layout(location = 0) in highp float in_tc_attr[];

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

struct S
{
	highp int x;
	highp vec4 y;
};

layout(location = 2) in S in_te_s[];
layout(location = 4) in highp float in_te_f[];

layout(location = 0) out highp vec4 in_f_color;

// Will contain the index of the first incorrect input,
// or the number of inputs if all are correct
layout (set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
    uint firstFailedInputIndex[];
} sb_out;

bool compare_int   (int   a, int   b) { return a == b; }
bool compare_float (float a, float b) { return abs(a - b) < 0.01f; }
bool compare_vec4  (vec4  a, vec4  b) { return all(lessThan(abs(a - b), vec4(0.01f))); }

void main (void)
{
	bool allOk = true;
	highp uint firstFailedInputIndex = 0u;
	{
		highp float v = 1.3;

		// Check values in input in_te_s
		for (int i0 = 0; i0 < 5; ++i0)
		{
			allOk = allOk && compare_int(in_te_s[i0].x, int(v));
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
			allOk = allOk && compare_vec4(in_te_s[i0].y, vec4(v, v+0.8, v+1.6, v+2.4));
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
		}

		// Check values in input in_te_f
		for (int i0 = 0; i0 < 5; ++i0)
		{
			allOk = allOk && compare_float(in_te_f[i0], v);
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
		}
	}

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
    in_f_color  = allOk ? vec4(0.0, 1.0, 0.0, 1.0)
                        : vec4(1.0, 0.0, 0.0, 1.0);

    int index = atomicAdd(sb_out.numInvocations, 1);
    sb_out.firstFailedInputIndex[index] = firstFailedInputIndex;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

struct S
{
	highp int x;
	highp vec4 y;
};

layout(location = 2) in S in_te_s[];
layout(location = 4) in highp float in_te_f[];

layout(location = 0) out highp vec4 in_f_color;

// Will contain the index of the first incorrect input,
// or the number of inputs if all are correct
layout (set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
    uint firstFailedInputIndex[];
} sb_out;

bool compare_int   (int   a, int   b) { return a == b; }
bool compare_float (float a, float b) { return abs(a - b) < 0.01f; }
bool compare_vec4  (vec4  a, vec4  b) { return all(lessThan(abs(a - b), vec4(0.01f))); }

void main (void)
{
	bool allOk = true;
	highp uint firstFailedInputIndex = 0u;
	{
		highp float v = 1.3;

		// Check values in input in_te_s
		for (int i0 = 0; i0 < 5; ++i0)
		{
			allOk = allOk && compare_int(in_te_s[i0].x, int(v));
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
			allOk = allOk && compare_vec4(in_te_s[i0].y, vec4(v, v+0.8, v+1.6, v+2.4));
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
		}

		// Check values in input in_te_f
		for (int i0 = 0; i0 < 5; ++i0)
		{
			allOk = allOk && compare_float(in_te_f[i0], v);
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
		}
	}

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
    in_f_color  = allOk ? vec4(0.0, 1.0, 0.0, 1.0)
                        : vec4(1.0, 0.0, 0.0, 1.0);

    int index = atomicAdd(sb_out.numInvocations, 1);
    sb_out.firstFailedInputIndex[index] = firstFailedInputIndex;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(isolines) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

struct S
{
	highp int x;
	highp vec4 y;
};

layout(location = 2) in S in_te_s[];
layout(location = 4) in highp float in_te_f[];

layout(location = 0) out highp vec4 in_f_color;

// Will contain the index of the first incorrect input,
// or the number of inputs if all are correct
layout (set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
    uint firstFailedInputIndex[];
} sb_out;

bool compare_int   (int   a, int   b) { return a == b; }
bool compare_float (float a, float b) { return abs(a - b) < 0.01f; }
bool compare_vec4  (vec4  a, vec4  b) { return all(lessThan(abs(a - b), vec4(0.01f))); }

void main (void)
{
	bool allOk = true;
	highp uint firstFailedInputIndex = 0u;
	{
		highp float v = 1.3;

		// Check values in input in_te_s
		for (int i0 = 0; i0 < 5; ++i0)
		{
			allOk = allOk && compare_int(in_te_s[i0].x, int(v));
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
			allOk = allOk && compare_vec4(in_te_s[i0].y, vec4(v, v+0.8, v+1.6, v+2.4));
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
		}

		// Check values in input in_te_f
		for (int i0 = 0; i0 < 5; ++i0)
		{
			allOk = allOk && compare_float(in_te_f[i0], v);
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
		}
	}

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
    in_f_color  = allOk ? vec4(0.0, 1.0, 0.0, 1.0)
                        : vec4(1.0, 0.0, 0.0, 1.0);

    int index = atomicAdd(sb_out.numInvocations, 1);
    sb_out.firstFailedInputIndex[index] = firstFailedInputIndex;
}
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

layout(location = 0) in highp float in_tc_attr[gl_MaxPatchVertices];

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

struct S
{
	highp int x;
	highp vec4 y;
};

layout(location = 2) in S in_te_s[gl_MaxPatchVertices];
layout(location = 4) in highp float in_te_f[gl_MaxPatchVertices];

layout(location = 0) out highp vec4 in_f_color;

// Will contain the index of the first incorrect input,
// or the number of inputs if all are correct
layout (set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
    uint firstFailedInputIndex[];
} sb_out;

bool compare_int   (int   a, int   b) { return a == b; }
bool compare_float (float a, float b) { return abs(a - b) < 0.01f; }
bool compare_vec4  (vec4  a, vec4  b) { return all(lessThan(abs(a - b), vec4(0.01f))); }

void main (void)
{
	bool allOk = true;
	highp uint firstFailedInputIndex = 0u;
	{
		highp float v = 1.3;

		// Check values in input in_te_s
		for (int i0 = 0; i0 < 5; ++i0)
		{
			allOk = allOk && compare_int(in_te_s[i0].x, int(v));
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
			allOk = allOk && compare_vec4(in_te_s[i0].y, vec4(v, v+0.8, v+1.6, v+2.4));
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
		}

		// Check values in input in_te_f
		for (int i0 = 0; i0 < 5; ++i0)
		{
			allOk = allOk && compare_float(in_te_f[i0], v);
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
		}
	}

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
    in_f_color  = allOk ? vec4(0.0, 1.0, 0.0, 1.0)
                        : vec4(1.0, 0.0, 0.0, 1.0);

    int index = atomicAdd(sb_out.numInvocations, 1);
    sb_out.firstFailedInputIndex[index] = firstFailedInputIndex;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

struct S
{
	highp int x;
	highp vec4 y;
};

layout(location = 2) in S in_te_s[gl_MaxPatchVertices];
layout(location = 4) in highp float in_te_f[gl_MaxPatchVertices];

layout(location = 0) out highp vec4 in_f_color;

// Will contain the index of the first incorrect input,
// or the number of inputs if all are correct
layout (set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
    uint firstFailedInputIndex[];
} sb_out;

bool compare_int   (int   a, int   b) { return a == b; }
bool compare_float (float a, float b) { return abs(a - b) < 0.01f; }
bool compare_vec4  (vec4  a, vec4  b) { return all(lessThan(abs(a - b), vec4(0.01f))); }

void main (void)
{
	bool allOk = true;
	highp uint firstFailedInputIndex = 0u;
	{
		highp float v = 1.3;

		// Check values in input in_te_s
		for (int i0 = 0; i0 < 5; ++i0)
		{
			allOk = allOk && compare_int(in_te_s[i0].x, int(v));
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
			allOk = allOk && compare_vec4(in_te_s[i0].y, vec4(v, v+0.8, v+1.6, v+2.4));
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
		}

		// Check values in input in_te_f
		for (int i0 = 0; i0 < 5; ++i0)
		{
			allOk = allOk && compare_float(in_te_f[i0], v);
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
		}
	}

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
    in_f_color  = allOk ? vec4(0.0, 1.0, 0.0, 1.0)
                        : vec4(1.0, 0.0, 0.0, 1.0);

    int index = atomicAdd(sb_out.numInvocations, 1);
    sb_out.firstFailedInputIndex[index] = firstFailedInputIndex;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(isolines) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

struct S
{
	highp int x;
	highp vec4 y;
};

layout(location = 2) in S in_te_s[gl_MaxPatchVertices];
layout(location = 4) in highp float in_te_f[gl_MaxPatchVertices];

layout(location = 0) out highp vec4 in_f_color;

// Will contain the index of the first incorrect input,
// or the number of inputs if all are correct
layout (set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
    uint firstFailedInputIndex[];
} sb_out;

bool compare_int   (int   a, int   b) { return a == b; }
bool compare_float (float a, float b) { return abs(a - b) < 0.01f; }
bool compare_vec4  (vec4  a, vec4  b) { return all(lessThan(abs(a - b), vec4(0.01f))); }

void main (void)
{
	bool allOk = true;
	highp uint firstFailedInputIndex = 0u;
	{
		highp float v = 1.3;

		// Check values in input in_te_s
		for (int i0 = 0; i0 < 5; ++i0)
		{
			allOk = allOk && compare_int(in_te_s[i0].x, int(v));
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
			allOk = allOk && compare_vec4(in_te_s[i0].y, vec4(v, v+0.8, v+1.6, v+2.4));
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
		}

		// Check values in input in_te_f
		for (int i0 = 0; i0 < 5; ++i0)
		{
			allOk = allOk && compare_float(in_te_f[i0], v);
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
		}
	}

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
    in_f_color  = allOk ? vec4(0.0, 1.0, 0.0, 1.0)
                        : vec4(1.0, 0.0, 0.0, 1.0);

    int index = atomicAdd(sb_out.numInvocations, 1);
    sb_out.firstFailedInputIndex[index] = firstFailedInputIndex;
}
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

layout(location = 0) in highp float in_tc_attr[32];

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

struct S
{
	highp int x;
	highp vec4 y;
};

layout(location = 2) in S in_te_s[32];
layout(location = 4) in highp float in_te_f[32];

layout(location = 0) out highp vec4 in_f_color;

// Will contain the index of the first incorrect input,
// or the number of inputs if all are correct
layout (set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
    uint firstFailedInputIndex[];
} sb_out;

bool compare_int   (int   a, int   b) { return a == b; }
bool compare_float (float a, float b) { return abs(a - b) < 0.01f; }
bool compare_vec4  (vec4  a, vec4  b) { return all(lessThan(abs(a - b), vec4(0.01f))); }

void main (void)
{
	bool allOk = true;
	highp uint firstFailedInputIndex = 0u;
	{
		highp float v = 1.3;

		// Check values in input in_te_s
		for (int i0 = 0; i0 < 5; ++i0)
		{
			allOk = allOk && compare_int(in_te_s[i0].x, int(v));
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
			allOk = allOk && compare_vec4(in_te_s[i0].y, vec4(v, v+0.8, v+1.6, v+2.4));
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
		}

		// Check values in input in_te_f
		for (int i0 = 0; i0 < 5; ++i0)
		{
			allOk = allOk && compare_float(in_te_f[i0], v);
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
		}
	}

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
    in_f_color  = allOk ? vec4(0.0, 1.0, 0.0, 1.0)
                        : vec4(1.0, 0.0, 0.0, 1.0);

    int index = atomicAdd(sb_out.numInvocations, 1);
    sb_out.firstFailedInputIndex[index] = firstFailedInputIndex;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

struct S
{
	highp int x;
	highp vec4 y;
};

layout(location = 2) in S in_te_s[32];
layout(location = 4) in highp float in_te_f[32];

layout(location = 0) out highp vec4 in_f_color;

// Will contain the index of the first incorrect input,
// or the number of inputs if all are correct
layout (set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
    uint firstFailedInputIndex[];
} sb_out;

bool compare_int   (int   a, int   b) { return a == b; }
bool compare_float (float a, float b) { return abs(a - b) < 0.01f; }
bool compare_vec4  (vec4  a, vec4  b) { return all(lessThan(abs(a - b), vec4(0.01f))); }

void main (void)
{
	bool allOk = true;
	highp uint firstFailedInputIndex = 0u;
	{
		highp float v = 1.3;

		// Check values in input in_te_s
		for (int i0 = 0; i0 < 5; ++i0)
		{
			allOk = allOk && compare_int(in_te_s[i0].x, int(v));
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
			allOk = allOk && compare_vec4(in_te_s[i0].y, vec4(v, v+0.8, v+1.6, v+2.4));
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
		}

		// Check values in input in_te_f
		for (int i0 = 0; i0 < 5; ++i0)
		{
			allOk = allOk && compare_float(in_te_f[i0], v);
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
		}
	}

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
    in_f_color  = allOk ? vec4(0.0, 1.0, 0.0, 1.0)
                        : vec4(1.0, 0.0, 0.0, 1.0);

    int index = atomicAdd(sb_out.numInvocations, 1);
    sb_out.firstFailedInputIndex[index] = firstFailedInputIndex;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(isolines) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

struct S
{
	highp int x;
	highp vec4 y;
};

layout(location = 2) in S in_te_s[32];
layout(location = 4) in highp float in_te_f[32];

layout(location = 0) out highp vec4 in_f_color;

// Will contain the index of the first incorrect input,
// or the number of inputs if all are correct
layout (set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
    uint firstFailedInputIndex[];
} sb_out;

bool compare_int   (int   a, int   b) { return a == b; }
bool compare_float (float a, float b) { return abs(a - b) < 0.01f; }
bool compare_vec4  (vec4  a, vec4  b) { return all(lessThan(abs(a - b), vec4(0.01f))); }

void main (void)
{
	bool allOk = true;
	highp uint firstFailedInputIndex = 0u;
	{
		highp float v = 1.3;

		// Check values in input in_te_s
		for (int i0 = 0; i0 < 5; ++i0)
		{
			allOk = allOk && compare_int(in_te_s[i0].x, int(v));
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
			allOk = allOk && compare_vec4(in_te_s[i0].y, vec4(v, v+0.8, v+1.6, v+2.4));
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
		}

		// Check values in input in_te_f
		for (int i0 = 0; i0 < 5; ++i0)
		{
			allOk = allOk && compare_float(in_te_f[i0], v);
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
		}
	}

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
    in_f_color  = allOk ? vec4(0.0, 1.0, 0.0, 1.0)
                        : vec4(1.0, 0.0, 0.0, 1.0);

    int index = atomicAdd(sb_out.numInvocations, 1);
    sb_out.firstFailedInputIndex[index] = firstFailedInputIndex;
}
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

layout(location = 0) in highp float in_tc_attr[];

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

struct S
{
	highp int x;
	highp vec4 y;
	highp float z[2];
};

layout(location = 2) in TheBlock
{
	S blockS;
	highp float blockFa[3];
	S blockSa[2];
	highp float blockF;
} teBlock[];

layout(location = 0) out highp vec4 in_f_color;

// Will contain the index of the first incorrect input,
// or the number of inputs if all are correct
layout (set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
    uint firstFailedInputIndex[];
} sb_out;

bool compare_int   (int   a, int   b) { return a == b; }
bool compare_float (float a, float b) { return abs(a - b) < 0.01f; }
bool compare_vec4  (vec4  a, vec4  b) { return all(lessThan(abs(a - b), vec4(0.01f))); }

void main (void)
{
	bool allOk = true;
	highp uint firstFailedInputIndex = 0u;
	{
		highp float v = 1.3;

		// Check values in input teBlock
		for (int i0 = 0; i0 < 5; ++i0)
		{
			allOk = allOk && compare_int(teBlock[i0].blockS.x, int(v));
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
			allOk = allOk && compare_vec4(teBlock[i0].blockS.y, vec4(v, v+0.8, v+1.6, v+2.4));
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
			for (int i1 = 0; i1 < 2; ++i1)
			{
				allOk = allOk && compare_float(teBlock[i0].blockS.z[i1], v);
				v += 0.4;
				if (allOk) ++firstFailedInputIndex;
			}
			for (int i1 = 0; i1 < 3; ++i1)
			{
				allOk = allOk && compare_float(teBlock[i0].blockFa[i1], v);
				v += 0.4;
				if (allOk) ++firstFailedInputIndex;
			}
			for (int i1 = 0; i1 < 2; ++i1)
			{
				allOk = allOk && compare_int(teBlock[i0].blockSa[i1].x, int(v));
				v += 0.4;
				if (allOk) ++firstFailedInputIndex;
				allOk = allOk && compare_vec4(teBlock[i0].blockSa[i1].y, vec4(v, v+0.8, v+1.6, v+2.4));
				v += 0.4;
				if (allOk) ++firstFailedInputIndex;
				for (int i2 = 0; i2 < 2; ++i2)
				{
					allOk = allOk && compare_float(teBlock[i0].blockSa[i1].z[i2], v);
					v += 0.4;
					if (allOk) ++firstFailedInputIndex;
				}
			}
			allOk = allOk && compare_float(teBlock[i0].blockF, v);
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
		}
	}

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
    in_f_color  = allOk ? vec4(0.0, 1.0, 0.0, 1.0)
                        : vec4(1.0, 0.0, 0.0, 1.0);

    int index = atomicAdd(sb_out.numInvocations, 1);
    sb_out.firstFailedInputIndex[index] = firstFailedInputIndex;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

struct S
{
	highp int x;
	highp vec4 y;
	highp float z[2];
};

layout(location = 2) in TheBlock
{
	S blockS;
	highp float blockFa[3];
	S blockSa[2];
	highp float blockF;
} teBlock[];

layout(location = 0) out highp vec4 in_f_color;

// Will contain the index of the first incorrect input,
// or the number of inputs if all are correct
layout (set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
    uint firstFailedInputIndex[];
} sb_out;

bool compare_int   (int   a, int   b) { return a == b; }
bool compare_float (float a, float b) { return abs(a - b) < 0.01f; }
bool compare_vec4  (vec4  a, vec4  b) { return all(lessThan(abs(a - b), vec4(0.01f))); }

void main (void)
{
	bool allOk = true;
	highp uint firstFailedInputIndex = 0u;
	{
		highp float v = 1.3;

		// Check values in input teBlock
		for (int i0 = 0; i0 < 5; ++i0)
		{
			allOk = allOk && compare_int(teBlock[i0].blockS.x, int(v));
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
			allOk = allOk && compare_vec4(teBlock[i0].blockS.y, vec4(v, v+0.8, v+1.6, v+2.4));
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
			for (int i1 = 0; i1 < 2; ++i1)
			{
				allOk = allOk && compare_float(teBlock[i0].blockS.z[i1], v);
				v += 0.4;
				if (allOk) ++firstFailedInputIndex;
			}
			for (int i1 = 0; i1 < 3; ++i1)
			{
				allOk = allOk && compare_float(teBlock[i0].blockFa[i1], v);
				v += 0.4;
				if (allOk) ++firstFailedInputIndex;
			}
			for (int i1 = 0; i1 < 2; ++i1)
			{
				allOk = allOk && compare_int(teBlock[i0].blockSa[i1].x, int(v));
				v += 0.4;
				if (allOk) ++firstFailedInputIndex;
				allOk = allOk && compare_vec4(teBlock[i0].blockSa[i1].y, vec4(v, v+0.8, v+1.6, v+2.4));
				v += 0.4;
				if (allOk) ++firstFailedInputIndex;
				for (int i2 = 0; i2 < 2; ++i2)
				{
					allOk = allOk && compare_float(teBlock[i0].blockSa[i1].z[i2], v);
					v += 0.4;
					if (allOk) ++firstFailedInputIndex;
				}
			}
			allOk = allOk && compare_float(teBlock[i0].blockF, v);
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
		}
	}

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
    in_f_color  = allOk ? vec4(0.0, 1.0, 0.0, 1.0)
                        : vec4(1.0, 0.0, 0.0, 1.0);

    int index = atomicAdd(sb_out.numInvocations, 1);
    sb_out.firstFailedInputIndex[index] = firstFailedInputIndex;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(isolines) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

struct S
{
	highp int x;
	highp vec4 y;
	highp float z[2];
};

layout(location = 2) in TheBlock
{
	S blockS;
	highp float blockFa[3];
	S blockSa[2];
	highp float blockF;
} teBlock[];

layout(location = 0) out highp vec4 in_f_color;

// Will contain the index of the first incorrect input,
// or the number of inputs if all are correct
layout (set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
    uint firstFailedInputIndex[];
} sb_out;

bool compare_int   (int   a, int   b) { return a == b; }
bool compare_float (float a, float b) { return abs(a - b) < 0.01f; }
bool compare_vec4  (vec4  a, vec4  b) { return all(lessThan(abs(a - b), vec4(0.01f))); }

void main (void)
{
	bool allOk = true;
	highp uint firstFailedInputIndex = 0u;
	{
		highp float v = 1.3;

		// Check values in input teBlock
		for (int i0 = 0; i0 < 5; ++i0)
		{
			allOk = allOk && compare_int(teBlock[i0].blockS.x, int(v));
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
			allOk = allOk && compare_vec4(teBlock[i0].blockS.y, vec4(v, v+0.8, v+1.6, v+2.4));
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
			for (int i1 = 0; i1 < 2; ++i1)
			{
				allOk = allOk && compare_float(teBlock[i0].blockS.z[i1], v);
				v += 0.4;
				if (allOk) ++firstFailedInputIndex;
			}
			for (int i1 = 0; i1 < 3; ++i1)
			{
				allOk = allOk && compare_float(teBlock[i0].blockFa[i1], v);
				v += 0.4;
				if (allOk) ++firstFailedInputIndex;
			}
			for (int i1 = 0; i1 < 2; ++i1)
			{
				allOk = allOk && compare_int(teBlock[i0].blockSa[i1].x, int(v));
				v += 0.4;
				if (allOk) ++firstFailedInputIndex;
				allOk = allOk && compare_vec4(teBlock[i0].blockSa[i1].y, vec4(v, v+0.8, v+1.6, v+2.4));
				v += 0.4;
				if (allOk) ++firstFailedInputIndex;
				for (int i2 = 0; i2 < 2; ++i2)
				{
					allOk = allOk && compare_float(teBlock[i0].blockSa[i1].z[i2], v);
					v += 0.4;
					if (allOk) ++firstFailedInputIndex;
				}
			}
			allOk = allOk && compare_float(teBlock[i0].blockF, v);
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
		}
	}

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
    in_f_color  = allOk ? vec4(0.0, 1.0, 0.0, 1.0)
                        : vec4(1.0, 0.0, 0.0, 1.0);

    int index = atomicAdd(sb_out.numInvocations, 1);
    sb_out.firstFailedInputIndex[index] = firstFailedInputIndex;
}
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

layout(location = 0) in highp float in_tc_attr[gl_MaxPatchVertices];

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

struct S
{
	highp int x;
	highp vec4 y;
	highp float z[2];
};

layout(location = 2) in TheBlock
{
	S blockS;
	highp float blockFa[3];
	S blockSa[2];
	highp float blockF;
} teBlock[gl_MaxPatchVertices];

layout(location = 0) out highp vec4 in_f_color;

// Will contain the index of the first incorrect input,
// or the number of inputs if all are correct
layout (set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
    uint firstFailedInputIndex[];
} sb_out;

bool compare_int   (int   a, int   b) { return a == b; }
bool compare_float (float a, float b) { return abs(a - b) < 0.01f; }
bool compare_vec4  (vec4  a, vec4  b) { return all(lessThan(abs(a - b), vec4(0.01f))); }

void main (void)
{
	bool allOk = true;
	highp uint firstFailedInputIndex = 0u;
	{
		highp float v = 1.3;

		// Check values in input teBlock
		for (int i0 = 0; i0 < 5; ++i0)
		{
			allOk = allOk && compare_int(teBlock[i0].blockS.x, int(v));
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
			allOk = allOk && compare_vec4(teBlock[i0].blockS.y, vec4(v, v+0.8, v+1.6, v+2.4));
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
			for (int i1 = 0; i1 < 2; ++i1)
			{
				allOk = allOk && compare_float(teBlock[i0].blockS.z[i1], v);
				v += 0.4;
				if (allOk) ++firstFailedInputIndex;
			}
			for (int i1 = 0; i1 < 3; ++i1)
			{
				allOk = allOk && compare_float(teBlock[i0].blockFa[i1], v);
				v += 0.4;
				if (allOk) ++firstFailedInputIndex;
			}
			for (int i1 = 0; i1 < 2; ++i1)
			{
				allOk = allOk && compare_int(teBlock[i0].blockSa[i1].x, int(v));
				v += 0.4;
				if (allOk) ++firstFailedInputIndex;
				allOk = allOk && compare_vec4(teBlock[i0].blockSa[i1].y, vec4(v, v+0.8, v+1.6, v+2.4));
				v += 0.4;
				if (allOk) ++firstFailedInputIndex;
				for (int i2 = 0; i2 < 2; ++i2)
				{
					allOk = allOk && compare_float(teBlock[i0].blockSa[i1].z[i2], v);
					v += 0.4;
					if (allOk) ++firstFailedInputIndex;
				}
			}
			allOk = allOk && compare_float(teBlock[i0].blockF, v);
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
		}
	}

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
    in_f_color  = allOk ? vec4(0.0, 1.0, 0.0, 1.0)
                        : vec4(1.0, 0.0, 0.0, 1.0);

    int index = atomicAdd(sb_out.numInvocations, 1);
    sb_out.firstFailedInputIndex[index] = firstFailedInputIndex;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

struct S
{
	highp int x;
	highp vec4 y;
	highp float z[2];
};

layout(location = 2) in TheBlock
{
	S blockS;
	highp float blockFa[3];
	S blockSa[2];
	highp float blockF;
} teBlock[gl_MaxPatchVertices];

layout(location = 0) out highp vec4 in_f_color;

// Will contain the index of the first incorrect input,
// or the number of inputs if all are correct
layout (set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
    uint firstFailedInputIndex[];
} sb_out;

bool compare_int   (int   a, int   b) { return a == b; }
bool compare_float (float a, float b) { return abs(a - b) < 0.01f; }
bool compare_vec4  (vec4  a, vec4  b) { return all(lessThan(abs(a - b), vec4(0.01f))); }

void main (void)
{
	bool allOk = true;
	highp uint firstFailedInputIndex = 0u;
	{
		highp float v = 1.3;

		// Check values in input teBlock
		for (int i0 = 0; i0 < 5; ++i0)
		{
			allOk = allOk && compare_int(teBlock[i0].blockS.x, int(v));
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
			allOk = allOk && compare_vec4(teBlock[i0].blockS.y, vec4(v, v+0.8, v+1.6, v+2.4));
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
			for (int i1 = 0; i1 < 2; ++i1)
			{
				allOk = allOk && compare_float(teBlock[i0].blockS.z[i1], v);
				v += 0.4;
				if (allOk) ++firstFailedInputIndex;
			}
			for (int i1 = 0; i1 < 3; ++i1)
			{
				allOk = allOk && compare_float(teBlock[i0].blockFa[i1], v);
				v += 0.4;
				if (allOk) ++firstFailedInputIndex;
			}
			for (int i1 = 0; i1 < 2; ++i1)
			{
				allOk = allOk && compare_int(teBlock[i0].blockSa[i1].x, int(v));
				v += 0.4;
				if (allOk) ++firstFailedInputIndex;
				allOk = allOk && compare_vec4(teBlock[i0].blockSa[i1].y, vec4(v, v+0.8, v+1.6, v+2.4));
				v += 0.4;
				if (allOk) ++firstFailedInputIndex;
				for (int i2 = 0; i2 < 2; ++i2)
				{
					allOk = allOk && compare_float(teBlock[i0].blockSa[i1].z[i2], v);
					v += 0.4;
					if (allOk) ++firstFailedInputIndex;
				}
			}
			allOk = allOk && compare_float(teBlock[i0].blockF, v);
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
		}
	}

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
    in_f_color  = allOk ? vec4(0.0, 1.0, 0.0, 1.0)
                        : vec4(1.0, 0.0, 0.0, 1.0);

    int index = atomicAdd(sb_out.numInvocations, 1);
    sb_out.firstFailedInputIndex[index] = firstFailedInputIndex;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(isolines) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

struct S
{
	highp int x;
	highp vec4 y;
	highp float z[2];
};

layout(location = 2) in TheBlock
{
	S blockS;
	highp float blockFa[3];
	S blockSa[2];
	highp float blockF;
} teBlock[gl_MaxPatchVertices];

layout(location = 0) out highp vec4 in_f_color;

// Will contain the index of the first incorrect input,
// or the number of inputs if all are correct
layout (set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
    uint firstFailedInputIndex[];
} sb_out;

bool compare_int   (int   a, int   b) { return a == b; }
bool compare_float (float a, float b) { return abs(a - b) < 0.01f; }
bool compare_vec4  (vec4  a, vec4  b) { return all(lessThan(abs(a - b), vec4(0.01f))); }

void main (void)
{
	bool allOk = true;
	highp uint firstFailedInputIndex = 0u;
	{
		highp float v = 1.3;

		// Check values in input teBlock
		for (int i0 = 0; i0 < 5; ++i0)
		{
			allOk = allOk && compare_int(teBlock[i0].blockS.x, int(v));
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
			allOk = allOk && compare_vec4(teBlock[i0].blockS.y, vec4(v, v+0.8, v+1.6, v+2.4));
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
			for (int i1 = 0; i1 < 2; ++i1)
			{
				allOk = allOk && compare_float(teBlock[i0].blockS.z[i1], v);
				v += 0.4;
				if (allOk) ++firstFailedInputIndex;
			}
			for (int i1 = 0; i1 < 3; ++i1)
			{
				allOk = allOk && compare_float(teBlock[i0].blockFa[i1], v);
				v += 0.4;
				if (allOk) ++firstFailedInputIndex;
			}
			for (int i1 = 0; i1 < 2; ++i1)
			{
				allOk = allOk && compare_int(teBlock[i0].blockSa[i1].x, int(v));
				v += 0.4;
				if (allOk) ++firstFailedInputIndex;
				allOk = allOk && compare_vec4(teBlock[i0].blockSa[i1].y, vec4(v, v+0.8, v+1.6, v+2.4));
				v += 0.4;
				if (allOk) ++firstFailedInputIndex;
				for (int i2 = 0; i2 < 2; ++i2)
				{
					allOk = allOk && compare_float(teBlock[i0].blockSa[i1].z[i2], v);
					v += 0.4;
					if (allOk) ++firstFailedInputIndex;
				}
			}
			allOk = allOk && compare_float(teBlock[i0].blockF, v);
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
		}
	}

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
    in_f_color  = allOk ? vec4(0.0, 1.0, 0.0, 1.0)
                        : vec4(1.0, 0.0, 0.0, 1.0);

    int index = atomicAdd(sb_out.numInvocations, 1);
    sb_out.firstFailedInputIndex[index] = firstFailedInputIndex;
}
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

layout(location = 0) in highp float in_tc_attr[32];

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(triangles) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

struct S
{
	highp int x;
	highp vec4 y;
	highp float z[2];
};

layout(location = 2) in TheBlock
{
	S blockS;
	highp float blockFa[3];
	S blockSa[2];
	highp float blockF;
} teBlock[32];

layout(location = 0) out highp vec4 in_f_color;

// Will contain the index of the first incorrect input,
// or the number of inputs if all are correct
layout (set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
    uint firstFailedInputIndex[];
} sb_out;

bool compare_int   (int   a, int   b) { return a == b; }
bool compare_float (float a, float b) { return abs(a - b) < 0.01f; }
bool compare_vec4  (vec4  a, vec4  b) { return all(lessThan(abs(a - b), vec4(0.01f))); }

void main (void)
{
	bool allOk = true;
	highp uint firstFailedInputIndex = 0u;
	{
		highp float v = 1.3;

		// Check values in input teBlock
		for (int i0 = 0; i0 < 5; ++i0)
		{
			allOk = allOk && compare_int(teBlock[i0].blockS.x, int(v));
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
			allOk = allOk && compare_vec4(teBlock[i0].blockS.y, vec4(v, v+0.8, v+1.6, v+2.4));
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
			for (int i1 = 0; i1 < 2; ++i1)
			{
				allOk = allOk && compare_float(teBlock[i0].blockS.z[i1], v);
				v += 0.4;
				if (allOk) ++firstFailedInputIndex;
			}
			for (int i1 = 0; i1 < 3; ++i1)
			{
				allOk = allOk && compare_float(teBlock[i0].blockFa[i1], v);
				v += 0.4;
				if (allOk) ++firstFailedInputIndex;
			}
			for (int i1 = 0; i1 < 2; ++i1)
			{
				allOk = allOk && compare_int(teBlock[i0].blockSa[i1].x, int(v));
				v += 0.4;
				if (allOk) ++firstFailedInputIndex;
				allOk = allOk && compare_vec4(teBlock[i0].blockSa[i1].y, vec4(v, v+0.8, v+1.6, v+2.4));
				v += 0.4;
				if (allOk) ++firstFailedInputIndex;
				for (int i2 = 0; i2 < 2; ++i2)
				{
					allOk = allOk && compare_float(teBlock[i0].blockSa[i1].z[i2], v);
					v += 0.4;
					if (allOk) ++firstFailedInputIndex;
				}
			}
			allOk = allOk && compare_float(teBlock[i0].blockF, v);
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
		}
	}

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
    in_f_color  = allOk ? vec4(0.0, 1.0, 0.0, 1.0)
                        : vec4(1.0, 0.0, 0.0, 1.0);

    int index = atomicAdd(sb_out.numInvocations, 1);
    sb_out.firstFailedInputIndex[index] = firstFailedInputIndex;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

struct S
{
	highp int x;
	highp vec4 y;
	highp float z[2];
};

layout(location = 2) in TheBlock
{
	S blockS;
	highp float blockFa[3];
	S blockSa[2];
	highp float blockF;
} teBlock[32];

layout(location = 0) out highp vec4 in_f_color;

// Will contain the index of the first incorrect input,
// or the number of inputs if all are correct
layout (set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
    uint firstFailedInputIndex[];
} sb_out;

bool compare_int   (int   a, int   b) { return a == b; }
bool compare_float (float a, float b) { return abs(a - b) < 0.01f; }
bool compare_vec4  (vec4  a, vec4  b) { return all(lessThan(abs(a - b), vec4(0.01f))); }

void main (void)
{
	bool allOk = true;
	highp uint firstFailedInputIndex = 0u;
	{
		highp float v = 1.3;

		// Check values in input teBlock
		for (int i0 = 0; i0 < 5; ++i0)
		{
			allOk = allOk && compare_int(teBlock[i0].blockS.x, int(v));
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
			allOk = allOk && compare_vec4(teBlock[i0].blockS.y, vec4(v, v+0.8, v+1.6, v+2.4));
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
			for (int i1 = 0; i1 < 2; ++i1)
			{
				allOk = allOk && compare_float(teBlock[i0].blockS.z[i1], v);
				v += 0.4;
				if (allOk) ++firstFailedInputIndex;
			}
			for (int i1 = 0; i1 < 3; ++i1)
			{
				allOk = allOk && compare_float(teBlock[i0].blockFa[i1], v);
				v += 0.4;
				if (allOk) ++firstFailedInputIndex;
			}
			for (int i1 = 0; i1 < 2; ++i1)
			{
				allOk = allOk && compare_int(teBlock[i0].blockSa[i1].x, int(v));
				v += 0.4;
				if (allOk) ++firstFailedInputIndex;
				allOk = allOk && compare_vec4(teBlock[i0].blockSa[i1].y, vec4(v, v+0.8, v+1.6, v+2.4));
				v += 0.4;
				if (allOk) ++firstFailedInputIndex;
				for (int i2 = 0; i2 < 2; ++i2)
				{
					allOk = allOk && compare_float(teBlock[i0].blockSa[i1].z[i2], v);
					v += 0.4;
					if (allOk) ++firstFailedInputIndex;
				}
			}
			allOk = allOk && compare_float(teBlock[i0].blockF, v);
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
		}
	}

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
    in_f_color  = allOk ? vec4(0.0, 1.0, 0.0, 1.0)
                        : vec4(1.0, 0.0, 0.0, 1.0);

    int index = atomicAdd(sb_out.numInvocations, 1);
    sb_out.firstFailedInputIndex[index] = firstFailedInputIndex;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(isolines) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

struct S
{
	highp int x;
	highp vec4 y;
	highp float z[2];
};

layout(location = 2) in TheBlock
{
	S blockS;
	highp float blockFa[3];
	S blockSa[2];
	highp float blockF;
} teBlock[32];

layout(location = 0) out highp vec4 in_f_color;

// Will contain the index of the first incorrect input,
// or the number of inputs if all are correct
layout (set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
    uint firstFailedInputIndex[];
} sb_out;

bool compare_int   (int   a, int   b) { return a == b; }
bool compare_float (float a, float b) { return abs(a - b) < 0.01f; }
bool compare_vec4  (vec4  a, vec4  b) { return all(lessThan(abs(a - b), vec4(0.01f))); }

void main (void)
{
	bool allOk = true;
	highp uint firstFailedInputIndex = 0u;
	{
		highp float v = 1.3;

		// Check values in input teBlock
		for (int i0 = 0; i0 < 5; ++i0)
		{
			allOk = allOk && compare_int(teBlock[i0].blockS.x, int(v));
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
			allOk = allOk && compare_vec4(teBlock[i0].blockS.y, vec4(v, v+0.8, v+1.6, v+2.4));
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
			for (int i1 = 0; i1 < 2; ++i1)
			{
				allOk = allOk && compare_float(teBlock[i0].blockS.z[i1], v);
				v += 0.4;
				if (allOk) ++firstFailedInputIndex;
			}
			for (int i1 = 0; i1 < 3; ++i1)
			{
				allOk = allOk && compare_float(teBlock[i0].blockFa[i1], v);
				v += 0.4;
				if (allOk) ++firstFailedInputIndex;
			}
			for (int i1 = 0; i1 < 2; ++i1)
			{
				allOk = allOk && compare_int(teBlock[i0].blockSa[i1].x, int(v));
				v += 0.4;
				if (allOk) ++firstFailedInputIndex;
				allOk = allOk && compare_vec4(teBlock[i0].blockSa[i1].y, vec4(v, v+0.8, v+1.6, v+2.4));
				v += 0.4;
				if (allOk) ++firstFailedInputIndex;
				for (int i2 = 0; i2 < 2; ++i2)
				{
					allOk = allOk && compare_float(teBlock[i0].blockSa[i1].z[i2], v);
					v += 0.4;
					if (allOk) ++firstFailedInputIndex;
				}
			}
			allOk = allOk && compare_float(teBlock[i0].blockF, v);
			v += 0.4;
			if (allOk) ++firstFailedInputIndex;
		}
	}

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
    in_f_color  = allOk ? vec4(0.0, 1.0, 0.0, 1.0)
                        : vec4(1.0, 0.0, 0.0, 1.0);

    int index = atomicAdd(sb_out.numInvocations, 1);
    sb_out.firstFailedInputIndex[index] = firstFailedInputIndex;
}
