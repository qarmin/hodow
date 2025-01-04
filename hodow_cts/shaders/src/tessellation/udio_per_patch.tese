#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(${primitive}) in;

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
