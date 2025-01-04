#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(${primitive}) in;

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
