#version 450
out gl_PerVertex {
	vec4 gl_Position;
};
highp float;
void main (void) {
	gl_Position = vec4(((gl_VertexIndex + 2) / 3) % 2 == 0 ? -3.0 : 1.0,
	                   ((gl_VertexIndex + 1) / 3) % 2 == 0 ? -1.0 : 3.0, 0.0, 1.0);
}
#version 450
layout(push_constant) uniform PushConstant {
	highp uint sampleIndex;
} pushConstants;
void main (void)
{
	highp uint sampleIndex = pushConstants.sampleIndex;
	gl_SampleMask[0] = int((~0x0u) << sampleIndex);
	highp float depth;
	highp uint x = sampleIndex ^ uint(gl_FragCoord.x);
	highp uint y = sampleIndex ^ uint(gl_FragCoord.y);
	depth = 0;
	depth += 0.5 * float(bitfieldExtract(x, 0, 1));
	depth += 0.25 * float(bitfieldExtract(y, 0, 1));
	depth += 0.125 * float(bitfieldExtract(x, 1, 1));
	depth += 0.0625 * float(bitfieldExtract(y, 1, 1));
	depth += 0.03125 * float(bitfieldExtract(x, 2, 1));
	depth += 0.015625 * float(bitfieldExtract(y, 2, 1));
	depth += 0.0078125 * float(bitfieldExtract(x, 3, 1));
	depth += 0.00390625 * float(bitfieldExtract(y, 3, 1));
	depth += 0.00195312 * float(bitfieldExtract(x, 4, 1));
	depth += 0.000976562 * float(bitfieldExtract(y, 4, 1));
	gl_FragDepth = depth;
}
#version 450
layout(push_constant) uniform PushConstant {
	highp uint sampleIndex;
} pushConstants;
void main (void)
{
	highp uint sampleIndex = pushConstants.sampleIndex;
	gl_SampleMask[0] = int((~0x0u) << sampleIndex);
}
#version 450
layout(location = 0) out highp vec4 o_color;
layout(push_constant) uniform PushConstant {
	highp uint sampleIndex;
} pushConstants;
void main (void)
{
	highp uint sampleIndex = pushConstants.sampleIndex;
	gl_SampleMask[0] = int(0x1u << sampleIndex);
	highp float color[4];
	highp uint x = sampleIndex ^ uint(gl_FragCoord.x);
	highp uint y = sampleIndex ^ uint(gl_FragCoord.y);
	color[0] = 0;
	color[1] = 0;
	color[2] = 0;
	color[3] = 0;
	color[0] += 0.5 * float(bitfieldExtract(x, 0, 1));
	color[1] += 0.5 * float(bitfieldExtract(y, 0, 1));
	color[2] += 0.5 * float(bitfieldExtract(x, 1, 1));
	color[0] += 0.25 * float(bitfieldExtract(y, 1, 1));
	color[1] += 0.25 * float(bitfieldExtract(x, 2, 1));
	color[2] += 0.25 * float(bitfieldExtract(y, 2, 1));
	color[0] += 0.125 * float(bitfieldExtract(x, 3, 1));
	color[1] += 0.125 * float(bitfieldExtract(y, 3, 1));
	color[2] += 0.125 * float(bitfieldExtract(x, 4, 1));
	color[0] += 0.0625 * float(bitfieldExtract(y, 4, 1));
	color[1] += 0.0625 * float(bitfieldExtract(x, 5, 1));
	color[2] += 0.0625 * float(bitfieldExtract(y, 5, 1));
	o_color = vec4(color[0], color[1], color[2], color[3]);
}
#version 450
layout(location = 0) out highp vec4 o_color;
layout(push_constant) uniform PushConstant {
	highp uint sampleIndex;
} pushConstants;
void main (void)
{
	highp uint sampleIndex = pushConstants.sampleIndex;
	gl_SampleMask[0] = int(0x1u << sampleIndex);
	highp float color[4];
	highp uint x = sampleIndex ^ uint(gl_FragCoord.x);
	highp uint y = sampleIndex ^ uint(gl_FragCoord.y);
	color[0] = 0;
	color[1] = 0;
	color[2] = 0;
	color[3] = 0;
	color[0] += 0.5 * float(bitfieldExtract(x, 0, 1));
	color[0] += 0.25 * float(bitfieldExtract(y, 0, 1));
	color[0] += 0.125 * float(bitfieldExtract(x, 1, 1));
	color[0] += 0.0625 * float(bitfieldExtract(y, 1, 1));
	color[0] += 0.03125 * float(bitfieldExtract(x, 2, 1));
	color[0] += 0.015625 * float(bitfieldExtract(y, 2, 1));
	color[0] += 0.0078125 * float(bitfieldExtract(x, 3, 1));
	color[0] += 0.00390625 * float(bitfieldExtract(y, 3, 1));
	o_color = vec4(color[0], color[1], color[2], color[3]);
}
#version 450
layout(location = 0) out highp vec4 o_color;
layout(push_constant) uniform PushConstant {
	highp uint sampleIndex;
} pushConstants;
void main (void)
{
	highp uint sampleIndex = pushConstants.sampleIndex;
	gl_SampleMask[0] = int(0x1u << sampleIndex);
	highp float color[4];
	highp uint x = sampleIndex ^ uint(gl_FragCoord.x);
	highp uint y = sampleIndex ^ uint(gl_FragCoord.y);
	color[0] = -1;
	color[1] = 0;
	color[2] = 0;
	color[3] = 0;
	color[0] += 1 * float(bitfieldExtract(x, 0, 1));
	color[0] += 0.5 * float(bitfieldExtract(y, 0, 1));
	color[0] += 0.25 * float(bitfieldExtract(x, 1, 1));
	color[0] += 0.125 * float(bitfieldExtract(y, 1, 1));
	color[0] += 0.0625 * float(bitfieldExtract(x, 2, 1));
	color[0] += 0.03125 * float(bitfieldExtract(y, 2, 1));
	color[0] += 0.015625 * float(bitfieldExtract(x, 3, 1));
	color[0] += 0.0078125 * float(bitfieldExtract(y, 3, 1));
	o_color = vec4(color[0], color[1], color[2], color[3]);
}
#version 450
layout(location = 0) out highp uvec4 o_color;
layout(push_constant) uniform PushConstant {
	highp uint sampleIndex;
} pushConstants;
void main (void)
{
	highp uint sampleIndex = pushConstants.sampleIndex;
	gl_SampleMask[0] = int(0x1u << sampleIndex);
	highp uint color[4];
	highp uint x = sampleIndex ^ uint(gl_FragCoord.x);
	highp uint y = sampleIndex ^ uint(gl_FragCoord.y);
	color[0] = 0;
	color[1] = 0;
	color[2] = 0;
	color[3] = 0;
	color[0] += 128 * bitfieldExtract(x, 0, 1);
	color[0] += 64 * bitfieldExtract(y, 0, 1);
	color[0] += 32 * bitfieldExtract(x, 1, 1);
	color[0] += 16 * bitfieldExtract(y, 1, 1);
	color[0] += 8 * bitfieldExtract(x, 2, 1);
	color[0] += 4 * bitfieldExtract(y, 2, 1);
	color[0] += 2 * bitfieldExtract(x, 3, 1);
	color[0] += 1 * bitfieldExtract(y, 3, 1);
	o_color = uvec4(color[0], color[1], color[2], color[3]);
}
#version 450
layout(location = 0) out highp ivec4 o_color;
layout(push_constant) uniform PushConstant {
	highp uint sampleIndex;
} pushConstants;
void main (void)
{
	highp uint sampleIndex = pushConstants.sampleIndex;
	gl_SampleMask[0] = int(0x1u << sampleIndex);
	highp int color[4];
	highp uint x = sampleIndex ^ uint(gl_FragCoord.x);
	highp uint y = sampleIndex ^ uint(gl_FragCoord.y);
	color[0] = 0;
	color[1] = 0;
	color[2] = 0;
	color[3] = 0;
	color[0] += 128 * int(bitfieldExtract(x, 0, 1));
	color[0] += 64 * int(bitfieldExtract(y, 0, 1));
	color[0] += 32 * int(bitfieldExtract(x, 1, 1));
	color[0] += 16 * int(bitfieldExtract(y, 1, 1));
	color[0] += 8 * int(bitfieldExtract(x, 2, 1));
	color[0] += 4 * int(bitfieldExtract(y, 2, 1));
	color[0] += 2 * int(bitfieldExtract(x, 3, 1));
	color[0] += 1 * int(bitfieldExtract(y, 3, 1));
	o_color = clamp(ivec4(color[0], color[1], color[2], color[3]), ivec4(-128, -2147483648, -2147483648, -2147483648), ivec4(127, 2147483647, 2147483647, 2147483647));
}
#version 450
layout(location = 0) out highp vec4 o_color;
layout(push_constant) uniform PushConstant {
	highp uint sampleIndex;
} pushConstants;
void main (void)
{
	highp uint sampleIndex = pushConstants.sampleIndex;
	gl_SampleMask[0] = int(0x1u << sampleIndex);
	highp float color[4];
	highp uint x = sampleIndex ^ uint(gl_FragCoord.x);
	highp uint y = sampleIndex ^ uint(gl_FragCoord.y);
	color[0] = 0;
	color[1] = 0;
	color[2] = 0;
	color[3] = 0;
	color[0] += 0.5 * float(bitfieldExtract(x, 0, 1));
	color[1] += 0.5 * float(bitfieldExtract(y, 0, 1));
	color[0] += 0.25 * float(bitfieldExtract(x, 1, 1));
	color[1] += 0.25 * float(bitfieldExtract(y, 1, 1));
	color[0] += 0.125 * float(bitfieldExtract(x, 2, 1));
	color[1] += 0.125 * float(bitfieldExtract(y, 2, 1));
	color[0] += 0.0625 * float(bitfieldExtract(x, 3, 1));
	color[1] += 0.0625 * float(bitfieldExtract(y, 3, 1));
	color[0] += 0.03125 * float(bitfieldExtract(x, 4, 1));
	color[1] += 0.03125 * float(bitfieldExtract(y, 4, 1));
	o_color = vec4(color[0], color[1], color[2], color[3]);
}
#version 450
layout(location = 0) out highp vec4 o_color;
layout(push_constant) uniform PushConstant {
	highp uint sampleIndex;
} pushConstants;
void main (void)
{
	highp uint sampleIndex = pushConstants.sampleIndex;
	gl_SampleMask[0] = int(0x1u << sampleIndex);
	highp float color[4];
	highp uint x = sampleIndex ^ uint(gl_FragCoord.x);
	highp uint y = sampleIndex ^ uint(gl_FragCoord.y);
	color[0] = -1;
	color[1] = -1;
	color[2] = 0;
	color[3] = 0;
	color[0] += 1 * float(bitfieldExtract(x, 0, 1));
	color[1] += 1 * float(bitfieldExtract(y, 0, 1));
	color[0] += 0.5 * float(bitfieldExtract(x, 1, 1));
	color[1] += 0.5 * float(bitfieldExtract(y, 1, 1));
	color[0] += 0.25 * float(bitfieldExtract(x, 2, 1));
	color[1] += 0.25 * float(bitfieldExtract(y, 2, 1));
	color[0] += 0.125 * float(bitfieldExtract(x, 3, 1));
	color[1] += 0.125 * float(bitfieldExtract(y, 3, 1));
	color[0] += 0.0625 * float(bitfieldExtract(x, 4, 1));
	color[1] += 0.0625 * float(bitfieldExtract(y, 4, 1));
	o_color = vec4(color[0], color[1], color[2], color[3]);
}
#version 450
layout(location = 0) out highp uvec4 o_color;
layout(push_constant) uniform PushConstant {
	highp uint sampleIndex;
} pushConstants;
void main (void)
{
	highp uint sampleIndex = pushConstants.sampleIndex;
	gl_SampleMask[0] = int(0x1u << sampleIndex);
	highp uint color[4];
	highp uint x = sampleIndex ^ uint(gl_FragCoord.x);
	highp uint y = sampleIndex ^ uint(gl_FragCoord.y);
	color[0] = 0;
	color[1] = 0;
	color[2] = 0;
	color[3] = 0;
	color[0] += 128 * bitfieldExtract(x, 0, 1);
	color[1] += 128 * bitfieldExtract(y, 0, 1);
	color[0] += 64 * bitfieldExtract(x, 1, 1);
	color[1] += 64 * bitfieldExtract(y, 1, 1);
	color[0] += 32 * bitfieldExtract(x, 2, 1);
	color[1] += 32 * bitfieldExtract(y, 2, 1);
	color[0] += 16 * bitfieldExtract(x, 3, 1);
	color[1] += 16 * bitfieldExtract(y, 3, 1);
	color[0] += 8 * bitfieldExtract(x, 4, 1);
	color[1] += 8 * bitfieldExtract(y, 4, 1);
	o_color = uvec4(color[0], color[1], color[2], color[3]);
}
#version 450
layout(location = 0) out highp ivec4 o_color;
layout(push_constant) uniform PushConstant {
	highp uint sampleIndex;
} pushConstants;
void main (void)
{
	highp uint sampleIndex = pushConstants.sampleIndex;
	gl_SampleMask[0] = int(0x1u << sampleIndex);
	highp int color[4];
	highp uint x = sampleIndex ^ uint(gl_FragCoord.x);
	highp uint y = sampleIndex ^ uint(gl_FragCoord.y);
	color[0] = 0;
	color[1] = 0;
	color[2] = 0;
	color[3] = 0;
	color[0] += 128 * int(bitfieldExtract(x, 0, 1));
	color[1] += 128 * int(bitfieldExtract(y, 0, 1));
	color[0] += 64 * int(bitfieldExtract(x, 1, 1));
	color[1] += 64 * int(bitfieldExtract(y, 1, 1));
	color[0] += 32 * int(bitfieldExtract(x, 2, 1));
	color[1] += 32 * int(bitfieldExtract(y, 2, 1));
	color[0] += 16 * int(bitfieldExtract(x, 3, 1));
	color[1] += 16 * int(bitfieldExtract(y, 3, 1));
	color[0] += 8 * int(bitfieldExtract(x, 4, 1));
	color[1] += 8 * int(bitfieldExtract(y, 4, 1));
	o_color = clamp(ivec4(color[0], color[1], color[2], color[3]), ivec4(-128, -128, -2147483648, -2147483648), ivec4(127, 127, 2147483647, 2147483647));
}
#version 450
layout(location = 0) out highp vec4 o_color;
layout(push_constant) uniform PushConstant {
	highp uint sampleIndex;
} pushConstants;
void main (void)
{
	highp uint sampleIndex = pushConstants.sampleIndex;
	gl_SampleMask[0] = int(0x1u << sampleIndex);
	highp float color[4];
	highp uint x = sampleIndex ^ uint(gl_FragCoord.x);
	highp uint y = sampleIndex ^ uint(gl_FragCoord.y);
	color[0] = 0;
	color[1] = 0;
	color[2] = 0;
	color[3] = 0;
	color[0] += 0 * float(bitfieldExtract(x, 0, 1));
	color[1] += 0 * float(bitfieldExtract(y, 0, 1));
	color[2] += 0 * float(bitfieldExtract(x, 1, 1));
	color[3] += 0.5 * float(bitfieldExtract(y, 1, 1));
	color[3] += 0.25 * float(bitfieldExtract(x, 2, 1));
	color[3] += 0.125 * float(bitfieldExtract(y, 2, 1));
	color[3] += 0.0625 * float(bitfieldExtract(x, 3, 1));
	color[3] += 0.03125 * float(bitfieldExtract(y, 3, 1));
	o_color = vec4(color[0], color[1], color[2], color[3]);
}
#version 450
layout(location = 0) out highp vec4 o_color;
layout(push_constant) uniform PushConstant {
	highp uint sampleIndex;
} pushConstants;
void main (void)
{
	highp uint sampleIndex = pushConstants.sampleIndex;
	gl_SampleMask[0] = int(0x1u << sampleIndex);
	highp float color[4];
	highp uint x = sampleIndex ^ uint(gl_FragCoord.x);
	highp uint y = sampleIndex ^ uint(gl_FragCoord.y);
	color[0] = 0;
	color[1] = 0;
	color[2] = 0;
	color[3] = 0;
	color[0] += 0.5 * float(bitfieldExtract(x, 0, 1));
	color[1] += 0.5 * float(bitfieldExtract(y, 0, 1));
	color[2] += 0.5 * float(bitfieldExtract(x, 1, 1));
	color[3] += 0.5 * float(bitfieldExtract(y, 1, 1));
	color[0] += 0.25 * float(bitfieldExtract(x, 2, 1));
	color[1] += 0.25 * float(bitfieldExtract(y, 2, 1));
	color[2] += 0.25 * float(bitfieldExtract(x, 3, 1));
	color[3] += 0.25 * float(bitfieldExtract(y, 3, 1));
	color[0] += 0.125 * float(bitfieldExtract(x, 4, 1));
	color[1] += 0.125 * float(bitfieldExtract(y, 4, 1));
	color[2] += 0.125 * float(bitfieldExtract(x, 5, 1));
	color[3] += 0.125 * float(bitfieldExtract(y, 5, 1));
	o_color = vec4(color[0], color[1], color[2], color[3]);
}
#version 450
layout(location = 0) out highp vec4 o_color;
layout(push_constant) uniform PushConstant {
	highp uint sampleIndex;
} pushConstants;
void main (void)
{
	highp uint sampleIndex = pushConstants.sampleIndex;
	gl_SampleMask[0] = int(0x1u << sampleIndex);
	highp float color[4];
	highp uint x = sampleIndex ^ uint(gl_FragCoord.x);
	highp uint y = sampleIndex ^ uint(gl_FragCoord.y);
	color[0] = -1;
	color[1] = -1;
	color[2] = -1;
	color[3] = -1;
	color[0] += 1 * float(bitfieldExtract(x, 0, 1));
	color[1] += 1 * float(bitfieldExtract(y, 0, 1));
	color[2] += 1 * float(bitfieldExtract(x, 1, 1));
	color[3] += 1 * float(bitfieldExtract(y, 1, 1));
	color[0] += 0.5 * float(bitfieldExtract(x, 2, 1));
	color[1] += 0.5 * float(bitfieldExtract(y, 2, 1));
	color[2] += 0.5 * float(bitfieldExtract(x, 3, 1));
	color[3] += 0.5 * float(bitfieldExtract(y, 3, 1));
	color[0] += 0.25 * float(bitfieldExtract(x, 4, 1));
	color[1] += 0.25 * float(bitfieldExtract(y, 4, 1));
	color[2] += 0.25 * float(bitfieldExtract(x, 5, 1));
	color[3] += 0.25 * float(bitfieldExtract(y, 5, 1));
	o_color = vec4(color[0], color[1], color[2], color[3]);
}
#version 450
layout(location = 0) out highp uvec4 o_color;
layout(push_constant) uniform PushConstant {
	highp uint sampleIndex;
} pushConstants;
void main (void)
{
	highp uint sampleIndex = pushConstants.sampleIndex;
	gl_SampleMask[0] = int(0x1u << sampleIndex);
	highp uint color[4];
	highp uint x = sampleIndex ^ uint(gl_FragCoord.x);
	highp uint y = sampleIndex ^ uint(gl_FragCoord.y);
	color[0] = 0;
	color[1] = 0;
	color[2] = 0;
	color[3] = 0;
	color[0] += 128 * bitfieldExtract(x, 0, 1);
	color[1] += 128 * bitfieldExtract(y, 0, 1);
	color[2] += 128 * bitfieldExtract(x, 1, 1);
	color[3] += 128 * bitfieldExtract(y, 1, 1);
	color[0] += 64 * bitfieldExtract(x, 2, 1);
	color[1] += 64 * bitfieldExtract(y, 2, 1);
	color[2] += 64 * bitfieldExtract(x, 3, 1);
	color[3] += 64 * bitfieldExtract(y, 3, 1);
	color[0] += 32 * bitfieldExtract(x, 4, 1);
	color[1] += 32 * bitfieldExtract(y, 4, 1);
	color[2] += 32 * bitfieldExtract(x, 5, 1);
	color[3] += 32 * bitfieldExtract(y, 5, 1);
	o_color = uvec4(color[0], color[1], color[2], color[3]);
}
#version 450
layout(location = 0) out highp ivec4 o_color;
layout(push_constant) uniform PushConstant {
	highp uint sampleIndex;
} pushConstants;
void main (void)
{
	highp uint sampleIndex = pushConstants.sampleIndex;
	gl_SampleMask[0] = int(0x1u << sampleIndex);
	highp int color[4];
	highp uint x = sampleIndex ^ uint(gl_FragCoord.x);
	highp uint y = sampleIndex ^ uint(gl_FragCoord.y);
	color[0] = 0;
	color[1] = 0;
	color[2] = 0;
	color[3] = 0;
	color[0] += 128 * int(bitfieldExtract(x, 0, 1));
	color[1] += 128 * int(bitfieldExtract(y, 0, 1));
	color[2] += 128 * int(bitfieldExtract(x, 1, 1));
	color[3] += 128 * int(bitfieldExtract(y, 1, 1));
	color[0] += 64 * int(bitfieldExtract(x, 2, 1));
	color[1] += 64 * int(bitfieldExtract(y, 2, 1));
	color[2] += 64 * int(bitfieldExtract(x, 3, 1));
	color[3] += 64 * int(bitfieldExtract(y, 3, 1));
	color[0] += 32 * int(bitfieldExtract(x, 4, 1));
	color[1] += 32 * int(bitfieldExtract(y, 4, 1));
	color[2] += 32 * int(bitfieldExtract(x, 5, 1));
	color[3] += 32 * int(bitfieldExtract(y, 5, 1));
	o_color = clamp(ivec4(color[0], color[1], color[2], color[3]), ivec4(-128, -128, -128, -128), ivec4(127, 127, 127, 127));
}
#version 450
layout(location = 0) out highp uvec4 o_color;
layout(push_constant) uniform PushConstant {
	highp uint sampleIndex;
} pushConstants;
void main (void)
{
	highp uint sampleIndex = pushConstants.sampleIndex;
	gl_SampleMask[0] = int(0x1u << sampleIndex);
	highp uint color[4];
	highp uint x = sampleIndex ^ uint(gl_FragCoord.x);
	highp uint y = sampleIndex ^ uint(gl_FragCoord.y);
	color[0] = 0;
	color[1] = 0;
	color[2] = 0;
	color[3] = 0;
	color[0] += 512 * bitfieldExtract(x, 0, 1);
	color[1] += 512 * bitfieldExtract(y, 0, 1);
	color[2] += 512 * bitfieldExtract(x, 1, 1);
	color[3] += 2 * bitfieldExtract(y, 1, 1);
	color[0] += 256 * bitfieldExtract(x, 2, 1);
	color[1] += 256 * bitfieldExtract(y, 2, 1);
	color[2] += 256 * bitfieldExtract(x, 3, 1);
	color[3] += 1 * bitfieldExtract(y, 3, 1);
	color[0] += 128 * bitfieldExtract(x, 4, 1);
	color[1] += 128 * bitfieldExtract(y, 4, 1);
	color[2] += 128 * bitfieldExtract(x, 5, 1);
	color[3] += 0 * bitfieldExtract(y, 5, 1);
	o_color = uvec4(color[0], color[1], color[2], color[3]);
}
#version 450
layout(location = 0) out highp vec4 o_color;
layout(push_constant) uniform PushConstant {
	highp uint sampleIndex;
} pushConstants;
void main (void)
{
	highp uint sampleIndex = pushConstants.sampleIndex;
	gl_SampleMask[0] = int(0x1u << sampleIndex);
	highp float color[4];
	highp uint x = sampleIndex ^ uint(gl_FragCoord.x);
	highp uint y = sampleIndex ^ uint(gl_FragCoord.y);
	color[0] = 0;
	color[1] = 0;
	color[2] = 0;
	color[3] = 0;
	color[0] += 0.5 * float(bitfieldExtract(x, 0, 1));
	color[0] += 0.25 * float(bitfieldExtract(y, 0, 1));
	color[0] += 0.125 * float(bitfieldExtract(x, 1, 1));
	color[0] += 0.0625 * float(bitfieldExtract(y, 1, 1));
	color[0] += 0.03125 * float(bitfieldExtract(x, 2, 1));
	color[0] += 0.015625 * float(bitfieldExtract(y, 2, 1));
	color[0] += 0.0078125 * float(bitfieldExtract(x, 3, 1));
	color[0] += 0.00390625 * float(bitfieldExtract(y, 3, 1));
	color[0] += 0.00195312 * float(bitfieldExtract(x, 4, 1));
	color[0] += 0.000976562 * float(bitfieldExtract(y, 4, 1));
	o_color = vec4(color[0], color[1], color[2], color[3]);
}
#version 450
layout(location = 0) out highp vec4 o_color;
layout(push_constant) uniform PushConstant {
	highp uint sampleIndex;
} pushConstants;
void main (void)
{
	highp uint sampleIndex = pushConstants.sampleIndex;
	gl_SampleMask[0] = int(0x1u << sampleIndex);
	highp float color[4];
	highp uint x = sampleIndex ^ uint(gl_FragCoord.x);
	highp uint y = sampleIndex ^ uint(gl_FragCoord.y);
	color[0] = -1;
	color[1] = 0;
	color[2] = 0;
	color[3] = 0;
	color[0] += 1 * float(bitfieldExtract(x, 0, 1));
	color[0] += 0.5 * float(bitfieldExtract(y, 0, 1));
	color[0] += 0.25 * float(bitfieldExtract(x, 1, 1));
	color[0] += 0.125 * float(bitfieldExtract(y, 1, 1));
	color[0] += 0.0625 * float(bitfieldExtract(x, 2, 1));
	color[0] += 0.03125 * float(bitfieldExtract(y, 2, 1));
	color[0] += 0.015625 * float(bitfieldExtract(x, 3, 1));
	color[0] += 0.0078125 * float(bitfieldExtract(y, 3, 1));
	color[0] += 0.00390625 * float(bitfieldExtract(x, 4, 1));
	color[0] += 0.00195312 * float(bitfieldExtract(y, 4, 1));
	o_color = vec4(color[0], color[1], color[2], color[3]);
}
#version 450
layout(location = 0) out highp uvec4 o_color;
layout(push_constant) uniform PushConstant {
	highp uint sampleIndex;
} pushConstants;
void main (void)
{
	highp uint sampleIndex = pushConstants.sampleIndex;
	gl_SampleMask[0] = int(0x1u << sampleIndex);
	highp uint color[4];
	highp uint x = sampleIndex ^ uint(gl_FragCoord.x);
	highp uint y = sampleIndex ^ uint(gl_FragCoord.y);
	color[0] = 0;
	color[1] = 0;
	color[2] = 0;
	color[3] = 0;
	color[0] += 32768 * bitfieldExtract(x, 0, 1);
	color[0] += 16384 * bitfieldExtract(y, 0, 1);
	color[0] += 8192 * bitfieldExtract(x, 1, 1);
	color[0] += 4096 * bitfieldExtract(y, 1, 1);
	color[0] += 2048 * bitfieldExtract(x, 2, 1);
	color[0] += 1024 * bitfieldExtract(y, 2, 1);
	color[0] += 512 * bitfieldExtract(x, 3, 1);
	color[0] += 256 * bitfieldExtract(y, 3, 1);
	color[0] += 128 * bitfieldExtract(x, 4, 1);
	color[0] += 64 * bitfieldExtract(y, 4, 1);
	o_color = uvec4(color[0], color[1], color[2], color[3]);
}
#version 450
layout(location = 0) out highp ivec4 o_color;
layout(push_constant) uniform PushConstant {
	highp uint sampleIndex;
} pushConstants;
void main (void)
{
	highp uint sampleIndex = pushConstants.sampleIndex;
	gl_SampleMask[0] = int(0x1u << sampleIndex);
	highp int color[4];
	highp uint x = sampleIndex ^ uint(gl_FragCoord.x);
	highp uint y = sampleIndex ^ uint(gl_FragCoord.y);
	color[0] = 0;
	color[1] = 0;
	color[2] = 0;
	color[3] = 0;
	color[0] += 32768 * int(bitfieldExtract(x, 0, 1));
	color[0] += 16384 * int(bitfieldExtract(y, 0, 1));
	color[0] += 8192 * int(bitfieldExtract(x, 1, 1));
	color[0] += 4096 * int(bitfieldExtract(y, 1, 1));
	color[0] += 2048 * int(bitfieldExtract(x, 2, 1));
	color[0] += 1024 * int(bitfieldExtract(y, 2, 1));
	color[0] += 512 * int(bitfieldExtract(x, 3, 1));
	color[0] += 256 * int(bitfieldExtract(y, 3, 1));
	color[0] += 128 * int(bitfieldExtract(x, 4, 1));
	color[0] += 64 * int(bitfieldExtract(y, 4, 1));
	o_color = clamp(ivec4(color[0], color[1], color[2], color[3]), ivec4(-32768, -2147483648, -2147483648, -2147483648), ivec4(32767, 2147483647, 2147483647, 2147483647));
}
#version 450
layout(location = 0) out highp vec4 o_color;
layout(push_constant) uniform PushConstant {
	highp uint sampleIndex;
} pushConstants;
void main (void)
{
	highp uint sampleIndex = pushConstants.sampleIndex;
	gl_SampleMask[0] = int(0x1u << sampleIndex);
	highp float color[4];
	highp uint x = sampleIndex ^ uint(gl_FragCoord.x);
	highp uint y = sampleIndex ^ uint(gl_FragCoord.y);
	color[0] = -1000;
	color[1] = 0;
	color[2] = 0;
	color[3] = 0;
	color[0] += 1000 * float(bitfieldExtract(x, 0, 1));
	color[0] += 500 * float(bitfieldExtract(y, 0, 1));
	color[0] += 250 * float(bitfieldExtract(x, 1, 1));
	color[0] += 125 * float(bitfieldExtract(y, 1, 1));
	color[0] += 62.5 * float(bitfieldExtract(x, 2, 1));
	color[0] += 31.25 * float(bitfieldExtract(y, 2, 1));
	color[0] += 15.625 * float(bitfieldExtract(x, 3, 1));
	color[0] += 7.8125 * float(bitfieldExtract(y, 3, 1));
	color[0] += 3.90625 * float(bitfieldExtract(x, 4, 1));
	color[0] += 1.95312 * float(bitfieldExtract(y, 4, 1));
	o_color = vec4(color[0], color[1], color[2], color[3]);
}
#version 450
layout(location = 0) out highp uvec4 o_color;
layout(push_constant) uniform PushConstant {
	highp uint sampleIndex;
} pushConstants;
void main (void)
{
	highp uint sampleIndex = pushConstants.sampleIndex;
	gl_SampleMask[0] = int(0x1u << sampleIndex);
	highp uint color[4];
	highp uint x = sampleIndex ^ uint(gl_FragCoord.x);
	highp uint y = sampleIndex ^ uint(gl_FragCoord.y);
	color[0] = 0;
	color[1] = 0;
	color[2] = 0;
	color[3] = 0;
	color[0] += 32768 * bitfieldExtract(x, 0, 1);
	color[1] += 32768 * bitfieldExtract(y, 0, 1);
	color[0] += 16384 * bitfieldExtract(x, 1, 1);
	color[1] += 16384 * bitfieldExtract(y, 1, 1);
	color[0] += 8192 * bitfieldExtract(x, 2, 1);
	color[1] += 8192 * bitfieldExtract(y, 2, 1);
	color[0] += 4096 * bitfieldExtract(x, 3, 1);
	color[1] += 4096 * bitfieldExtract(y, 3, 1);
	color[0] += 2048 * bitfieldExtract(x, 4, 1);
	color[1] += 2048 * bitfieldExtract(y, 4, 1);
	o_color = uvec4(color[0], color[1], color[2], color[3]);
}
#version 450
layout(location = 0) out highp ivec4 o_color;
layout(push_constant) uniform PushConstant {
	highp uint sampleIndex;
} pushConstants;
void main (void)
{
	highp uint sampleIndex = pushConstants.sampleIndex;
	gl_SampleMask[0] = int(0x1u << sampleIndex);
	highp int color[4];
	highp uint x = sampleIndex ^ uint(gl_FragCoord.x);
	highp uint y = sampleIndex ^ uint(gl_FragCoord.y);
	color[0] = 0;
	color[1] = 0;
	color[2] = 0;
	color[3] = 0;
	color[0] += 32768 * int(bitfieldExtract(x, 0, 1));
	color[1] += 32768 * int(bitfieldExtract(y, 0, 1));
	color[0] += 16384 * int(bitfieldExtract(x, 1, 1));
	color[1] += 16384 * int(bitfieldExtract(y, 1, 1));
	color[0] += 8192 * int(bitfieldExtract(x, 2, 1));
	color[1] += 8192 * int(bitfieldExtract(y, 2, 1));
	color[0] += 4096 * int(bitfieldExtract(x, 3, 1));
	color[1] += 4096 * int(bitfieldExtract(y, 3, 1));
	color[0] += 2048 * int(bitfieldExtract(x, 4, 1));
	color[1] += 2048 * int(bitfieldExtract(y, 4, 1));
	o_color = clamp(ivec4(color[0], color[1], color[2], color[3]), ivec4(-32768, -32768, -2147483648, -2147483648), ivec4(32767, 32767, 2147483647, 2147483647));
}
#version 450
layout(location = 0) out highp vec4 o_color;
layout(push_constant) uniform PushConstant {
	highp uint sampleIndex;
} pushConstants;
void main (void)
{
	highp uint sampleIndex = pushConstants.sampleIndex;
	gl_SampleMask[0] = int(0x1u << sampleIndex);
	highp float color[4];
	highp uint x = sampleIndex ^ uint(gl_FragCoord.x);
	highp uint y = sampleIndex ^ uint(gl_FragCoord.y);
	color[0] = -1000;
	color[1] = -1000;
	color[2] = 0;
	color[3] = 0;
	color[0] += 1000 * float(bitfieldExtract(x, 0, 1));
	color[1] += 1000 * float(bitfieldExtract(y, 0, 1));
	color[0] += 500 * float(bitfieldExtract(x, 1, 1));
	color[1] += 500 * float(bitfieldExtract(y, 1, 1));
	color[0] += 250 * float(bitfieldExtract(x, 2, 1));
	color[1] += 250 * float(bitfieldExtract(y, 2, 1));
	color[0] += 125 * float(bitfieldExtract(x, 3, 1));
	color[1] += 125 * float(bitfieldExtract(y, 3, 1));
	color[0] += 62.5 * float(bitfieldExtract(x, 4, 1));
	color[1] += 62.5 * float(bitfieldExtract(y, 4, 1));
	o_color = vec4(color[0], color[1], color[2], color[3]);
}
#version 450
layout(location = 0) out highp uvec4 o_color;
layout(push_constant) uniform PushConstant {
	highp uint sampleIndex;
} pushConstants;
void main (void)
{
	highp uint sampleIndex = pushConstants.sampleIndex;
	gl_SampleMask[0] = int(0x1u << sampleIndex);
	highp uint color[4];
	highp uint x = sampleIndex ^ uint(gl_FragCoord.x);
	highp uint y = sampleIndex ^ uint(gl_FragCoord.y);
	color[0] = 0;
	color[1] = 0;
	color[2] = 0;
	color[3] = 0;
	color[0] += 32768 * bitfieldExtract(x, 0, 1);
	color[1] += 32768 * bitfieldExtract(y, 0, 1);
	color[2] += 32768 * bitfieldExtract(x, 1, 1);
	color[3] += 32768 * bitfieldExtract(y, 1, 1);
	color[0] += 16384 * bitfieldExtract(x, 2, 1);
	color[1] += 16384 * bitfieldExtract(y, 2, 1);
	color[2] += 16384 * bitfieldExtract(x, 3, 1);
	color[3] += 16384 * bitfieldExtract(y, 3, 1);
	color[0] += 8192 * bitfieldExtract(x, 4, 1);
	color[1] += 8192 * bitfieldExtract(y, 4, 1);
	color[2] += 8192 * bitfieldExtract(x, 5, 1);
	color[3] += 8192 * bitfieldExtract(y, 5, 1);
	o_color = uvec4(color[0], color[1], color[2], color[3]);
}
#version 450
layout(location = 0) out highp ivec4 o_color;
layout(push_constant) uniform PushConstant {
	highp uint sampleIndex;
} pushConstants;
void main (void)
{
	highp uint sampleIndex = pushConstants.sampleIndex;
	gl_SampleMask[0] = int(0x1u << sampleIndex);
	highp int color[4];
	highp uint x = sampleIndex ^ uint(gl_FragCoord.x);
	highp uint y = sampleIndex ^ uint(gl_FragCoord.y);
	color[0] = 0;
	color[1] = 0;
	color[2] = 0;
	color[3] = 0;
	color[0] += 32768 * int(bitfieldExtract(x, 0, 1));
	color[1] += 32768 * int(bitfieldExtract(y, 0, 1));
	color[2] += 32768 * int(bitfieldExtract(x, 1, 1));
	color[3] += 32768 * int(bitfieldExtract(y, 1, 1));
	color[0] += 16384 * int(bitfieldExtract(x, 2, 1));
	color[1] += 16384 * int(bitfieldExtract(y, 2, 1));
	color[2] += 16384 * int(bitfieldExtract(x, 3, 1));
	color[3] += 16384 * int(bitfieldExtract(y, 3, 1));
	color[0] += 8192 * int(bitfieldExtract(x, 4, 1));
	color[1] += 8192 * int(bitfieldExtract(y, 4, 1));
	color[2] += 8192 * int(bitfieldExtract(x, 5, 1));
	color[3] += 8192 * int(bitfieldExtract(y, 5, 1));
	o_color = clamp(ivec4(color[0], color[1], color[2], color[3]), ivec4(-32768, -32768, -32768, -32768), ivec4(32767, 32767, 32767, 32767));
}
#version 450
layout(location = 0) out highp vec4 o_color;
layout(push_constant) uniform PushConstant {
	highp uint sampleIndex;
} pushConstants;
void main (void)
{
	highp uint sampleIndex = pushConstants.sampleIndex;
	gl_SampleMask[0] = int(0x1u << sampleIndex);
	highp float color[4];
	highp uint x = sampleIndex ^ uint(gl_FragCoord.x);
	highp uint y = sampleIndex ^ uint(gl_FragCoord.y);
	color[0] = -1000;
	color[1] = -1000;
	color[2] = -1000;
	color[3] = -1000;
	color[0] += 1000 * float(bitfieldExtract(x, 0, 1));
	color[1] += 1000 * float(bitfieldExtract(y, 0, 1));
	color[2] += 1000 * float(bitfieldExtract(x, 1, 1));
	color[3] += 1000 * float(bitfieldExtract(y, 1, 1));
	color[0] += 500 * float(bitfieldExtract(x, 2, 1));
	color[1] += 500 * float(bitfieldExtract(y, 2, 1));
	color[2] += 500 * float(bitfieldExtract(x, 3, 1));
	color[3] += 500 * float(bitfieldExtract(y, 3, 1));
	color[0] += 250 * float(bitfieldExtract(x, 4, 1));
	color[1] += 250 * float(bitfieldExtract(y, 4, 1));
	color[2] += 250 * float(bitfieldExtract(x, 5, 1));
	color[3] += 250 * float(bitfieldExtract(y, 5, 1));
	o_color = vec4(color[0], color[1], color[2], color[3]);
}
#version 450
layout(location = 0) out highp uvec4 o_color;
layout(push_constant) uniform PushConstant {
	highp uint sampleIndex;
} pushConstants;
void main (void)
{
	highp uint sampleIndex = pushConstants.sampleIndex;
	gl_SampleMask[0] = int(0x1u << sampleIndex);
	highp uint color[4];
	highp uint x = sampleIndex ^ uint(gl_FragCoord.x);
	highp uint y = sampleIndex ^ uint(gl_FragCoord.y);
	color[0] = 0;
	color[1] = 0;
	color[2] = 0;
	color[3] = 0;
	color[0] += 1073741824 * bitfieldExtract(x, 0, 1);
	color[0] += 536870912 * bitfieldExtract(y, 0, 1);
	color[0] += 268435456 * bitfieldExtract(x, 1, 1);
	color[0] += 134217728 * bitfieldExtract(y, 1, 1);
	color[0] += 67108864 * bitfieldExtract(x, 2, 1);
	color[0] += 33554432 * bitfieldExtract(y, 2, 1);
	color[0] += 16777216 * bitfieldExtract(x, 3, 1);
	color[0] += 8388608 * bitfieldExtract(y, 3, 1);
	color[0] += 4194304 * bitfieldExtract(x, 4, 1);
	color[0] += 2097152 * bitfieldExtract(y, 4, 1);
	o_color = uvec4(color[0], color[1], color[2], color[3]);
}
#version 450
layout(location = 0) out highp ivec4 o_color;
layout(push_constant) uniform PushConstant {
	highp uint sampleIndex;
} pushConstants;
void main (void)
{
	highp uint sampleIndex = pushConstants.sampleIndex;
	gl_SampleMask[0] = int(0x1u << sampleIndex);
	highp int color[4];
	highp uint x = sampleIndex ^ uint(gl_FragCoord.x);
	highp uint y = sampleIndex ^ uint(gl_FragCoord.y);
	color[0] = 0;
	color[1] = 0;
	color[2] = 0;
	color[3] = 0;
	color[0] += 536870912 * int(bitfieldExtract(x, 0, 1));
	color[0] += 268435456 * int(bitfieldExtract(y, 0, 1));
	color[0] += 134217728 * int(bitfieldExtract(x, 1, 1));
	color[0] += 67108864 * int(bitfieldExtract(y, 1, 1));
	color[0] += 33554432 * int(bitfieldExtract(x, 2, 1));
	color[0] += 16777216 * int(bitfieldExtract(y, 2, 1));
	color[0] += 8388608 * int(bitfieldExtract(x, 3, 1));
	color[0] += 4194304 * int(bitfieldExtract(y, 3, 1));
	color[0] += 2097152 * int(bitfieldExtract(x, 4, 1));
	color[0] += 1048576 * int(bitfieldExtract(y, 4, 1));
	o_color = clamp(ivec4(color[0], color[1], color[2], color[3]), ivec4(-2147483648, -2147483648, -2147483648, -2147483648), ivec4(2147483647, 2147483647, 2147483647, 2147483647));
}
#version 450
layout(location = 0) out highp vec4 o_color;
layout(push_constant) uniform PushConstant {
	highp uint sampleIndex;
} pushConstants;
void main (void)
{
	highp uint sampleIndex = pushConstants.sampleIndex;
	gl_SampleMask[0] = int(0x1u << sampleIndex);
	highp float color[4];
	highp uint x = sampleIndex ^ uint(gl_FragCoord.x);
	highp uint y = sampleIndex ^ uint(gl_FragCoord.y);
	color[0] = -65536;
	color[1] = 0;
	color[2] = 0;
	color[3] = 0;
	color[0] += 65536 * float(bitfieldExtract(x, 0, 1));
	color[0] += 32768 * float(bitfieldExtract(y, 0, 1));
	color[0] += 16384 * float(bitfieldExtract(x, 1, 1));
	color[0] += 8192 * float(bitfieldExtract(y, 1, 1));
	color[0] += 4096 * float(bitfieldExtract(x, 2, 1));
	color[0] += 2048 * float(bitfieldExtract(y, 2, 1));
	color[0] += 1024 * float(bitfieldExtract(x, 3, 1));
	color[0] += 512 * float(bitfieldExtract(y, 3, 1));
	color[0] += 256 * float(bitfieldExtract(x, 4, 1));
	color[0] += 128 * float(bitfieldExtract(y, 4, 1));
	o_color = vec4(color[0], color[1], color[2], color[3]);
}
#version 450
layout(location = 0) out highp uvec4 o_color;
layout(push_constant) uniform PushConstant {
	highp uint sampleIndex;
} pushConstants;
void main (void)
{
	highp uint sampleIndex = pushConstants.sampleIndex;
	gl_SampleMask[0] = int(0x1u << sampleIndex);
	highp uint color[4];
	highp uint x = sampleIndex ^ uint(gl_FragCoord.x);
	highp uint y = sampleIndex ^ uint(gl_FragCoord.y);
	color[0] = 0;
	color[1] = 0;
	color[2] = 0;
	color[3] = 0;
	color[0] += 1073741824 * bitfieldExtract(x, 0, 1);
	color[1] += 1073741824 * bitfieldExtract(y, 0, 1);
	color[0] += 536870912 * bitfieldExtract(x, 1, 1);
	color[1] += 536870912 * bitfieldExtract(y, 1, 1);
	color[0] += 268435456 * bitfieldExtract(x, 2, 1);
	color[1] += 268435456 * bitfieldExtract(y, 2, 1);
	color[0] += 134217728 * bitfieldExtract(x, 3, 1);
	color[1] += 134217728 * bitfieldExtract(y, 3, 1);
	color[0] += 67108864 * bitfieldExtract(x, 4, 1);
	color[1] += 67108864 * bitfieldExtract(y, 4, 1);
	o_color = uvec4(color[0], color[1], color[2], color[3]);
}
#version 450
layout(location = 0) out highp ivec4 o_color;
layout(push_constant) uniform PushConstant {
	highp uint sampleIndex;
} pushConstants;
void main (void)
{
	highp uint sampleIndex = pushConstants.sampleIndex;
	gl_SampleMask[0] = int(0x1u << sampleIndex);
	highp int color[4];
	highp uint x = sampleIndex ^ uint(gl_FragCoord.x);
	highp uint y = sampleIndex ^ uint(gl_FragCoord.y);
	color[0] = 0;
	color[1] = 0;
	color[2] = 0;
	color[3] = 0;
	color[0] += 536870912 * int(bitfieldExtract(x, 0, 1));
	color[1] += 536870912 * int(bitfieldExtract(y, 0, 1));
	color[0] += 268435456 * int(bitfieldExtract(x, 1, 1));
	color[1] += 268435456 * int(bitfieldExtract(y, 1, 1));
	color[0] += 134217728 * int(bitfieldExtract(x, 2, 1));
	color[1] += 134217728 * int(bitfieldExtract(y, 2, 1));
	color[0] += 67108864 * int(bitfieldExtract(x, 3, 1));
	color[1] += 67108864 * int(bitfieldExtract(y, 3, 1));
	color[0] += 33554432 * int(bitfieldExtract(x, 4, 1));
	color[1] += 33554432 * int(bitfieldExtract(y, 4, 1));
	o_color = clamp(ivec4(color[0], color[1], color[2], color[3]), ivec4(-2147483648, -2147483648, -2147483648, -2147483648), ivec4(2147483647, 2147483647, 2147483647, 2147483647));
}
#version 450
layout(location = 0) out highp vec4 o_color;
layout(push_constant) uniform PushConstant {
	highp uint sampleIndex;
} pushConstants;
void main (void)
{
	highp uint sampleIndex = pushConstants.sampleIndex;
	gl_SampleMask[0] = int(0x1u << sampleIndex);
	highp float color[4];
	highp uint x = sampleIndex ^ uint(gl_FragCoord.x);
	highp uint y = sampleIndex ^ uint(gl_FragCoord.y);
	color[0] = -65536;
	color[1] = -65536;
	color[2] = 0;
	color[3] = 0;
	color[0] += 65536 * float(bitfieldExtract(x, 0, 1));
	color[1] += 65536 * float(bitfieldExtract(y, 0, 1));
	color[0] += 32768 * float(bitfieldExtract(x, 1, 1));
	color[1] += 32768 * float(bitfieldExtract(y, 1, 1));
	color[0] += 16384 * float(bitfieldExtract(x, 2, 1));
	color[1] += 16384 * float(bitfieldExtract(y, 2, 1));
	color[0] += 8192 * float(bitfieldExtract(x, 3, 1));
	color[1] += 8192 * float(bitfieldExtract(y, 3, 1));
	color[0] += 4096 * float(bitfieldExtract(x, 4, 1));
	color[1] += 4096 * float(bitfieldExtract(y, 4, 1));
	o_color = vec4(color[0], color[1], color[2], color[3]);
}
#version 450
layout(location = 0) out highp uvec4 o_color;
layout(push_constant) uniform PushConstant {
	highp uint sampleIndex;
} pushConstants;
void main (void)
{
	highp uint sampleIndex = pushConstants.sampleIndex;
	gl_SampleMask[0] = int(0x1u << sampleIndex);
	highp uint color[4];
	highp uint x = sampleIndex ^ uint(gl_FragCoord.x);
	highp uint y = sampleIndex ^ uint(gl_FragCoord.y);
	color[0] = 0;
	color[1] = 0;
	color[2] = 0;
	color[3] = 0;
	color[0] += 1073741824 * bitfieldExtract(x, 0, 1);
	color[1] += 1073741824 * bitfieldExtract(y, 0, 1);
	color[2] += 1073741824 * bitfieldExtract(x, 1, 1);
	color[3] += 1073741824 * bitfieldExtract(y, 1, 1);
	color[0] += 536870912 * bitfieldExtract(x, 2, 1);
	color[1] += 536870912 * bitfieldExtract(y, 2, 1);
	color[2] += 536870912 * bitfieldExtract(x, 3, 1);
	color[3] += 536870912 * bitfieldExtract(y, 3, 1);
	color[0] += 268435456 * bitfieldExtract(x, 4, 1);
	color[1] += 268435456 * bitfieldExtract(y, 4, 1);
	color[2] += 268435456 * bitfieldExtract(x, 5, 1);
	color[3] += 268435456 * bitfieldExtract(y, 5, 1);
	o_color = uvec4(color[0], color[1], color[2], color[3]);
}
#version 450
layout(location = 0) out highp ivec4 o_color;
layout(push_constant) uniform PushConstant {
	highp uint sampleIndex;
} pushConstants;
void main (void)
{
	highp uint sampleIndex = pushConstants.sampleIndex;
	gl_SampleMask[0] = int(0x1u << sampleIndex);
	highp int color[4];
	highp uint x = sampleIndex ^ uint(gl_FragCoord.x);
	highp uint y = sampleIndex ^ uint(gl_FragCoord.y);
	color[0] = 0;
	color[1] = 0;
	color[2] = 0;
	color[3] = 0;
	color[0] += 536870912 * int(bitfieldExtract(x, 0, 1));
	color[1] += 536870912 * int(bitfieldExtract(y, 0, 1));
	color[2] += 536870912 * int(bitfieldExtract(x, 1, 1));
	color[3] += 536870912 * int(bitfieldExtract(y, 1, 1));
	color[0] += 268435456 * int(bitfieldExtract(x, 2, 1));
	color[1] += 268435456 * int(bitfieldExtract(y, 2, 1));
	color[2] += 268435456 * int(bitfieldExtract(x, 3, 1));
	color[3] += 268435456 * int(bitfieldExtract(y, 3, 1));
	color[0] += 134217728 * int(bitfieldExtract(x, 4, 1));
	color[1] += 134217728 * int(bitfieldExtract(y, 4, 1));
	color[2] += 134217728 * int(bitfieldExtract(x, 5, 1));
	color[3] += 134217728 * int(bitfieldExtract(y, 5, 1));
	o_color = clamp(ivec4(color[0], color[1], color[2], color[3]), ivec4(-2147483648, -2147483648, -2147483648, -2147483648), ivec4(2147483647, 2147483647, 2147483647, 2147483647));
}
#version 450
layout(location = 0) out highp vec4 o_color;
layout(push_constant) uniform PushConstant {
	highp uint sampleIndex;
} pushConstants;
void main (void)
{
	highp uint sampleIndex = pushConstants.sampleIndex;
	gl_SampleMask[0] = int(0x1u << sampleIndex);
	highp float color[4];
	highp uint x = sampleIndex ^ uint(gl_FragCoord.x);
	highp uint y = sampleIndex ^ uint(gl_FragCoord.y);
	color[0] = -65536;
	color[1] = -65536;
	color[2] = -65536;
	color[3] = -65536;
	color[0] += 65536 * float(bitfieldExtract(x, 0, 1));
	color[1] += 65536 * float(bitfieldExtract(y, 0, 1));
	color[2] += 65536 * float(bitfieldExtract(x, 1, 1));
	color[3] += 65536 * float(bitfieldExtract(y, 1, 1));
	color[0] += 32768 * float(bitfieldExtract(x, 2, 1));
	color[1] += 32768 * float(bitfieldExtract(y, 2, 1));
	color[2] += 32768 * float(bitfieldExtract(x, 3, 1));
	color[3] += 32768 * float(bitfieldExtract(y, 3, 1));
	color[0] += 16384 * float(bitfieldExtract(x, 4, 1));
	color[1] += 16384 * float(bitfieldExtract(y, 4, 1));
	color[2] += 16384 * float(bitfieldExtract(x, 5, 1));
	color[3] += 16384 * float(bitfieldExtract(y, 5, 1));
	o_color = vec4(color[0], color[1], color[2], color[3]);
}
#version 450
layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp subpassInputMS i_depth;
layout(push_constant) uniform PushConstant {
	highp uint splitSubpassIndex;
} pushConstants;
layout(location = 0) out highp float o_color0;
layout(location = 1) out highp float o_color1;
void main (void)
{
	highp float depth0 = subpassLoad(i_depth, int(4 * pushConstants.splitSubpassIndex + 0u)).x;
	o_color0 = float(depth0);
	highp float depth1 = subpassLoad(i_depth, int(4 * pushConstants.splitSubpassIndex + 1u)).x;
	o_color1 = float(depth1);
}
#version 450
layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp usubpassInputMS i_stencil;
layout(push_constant) uniform PushConstant {
	highp uint splitSubpassIndex;
} pushConstants;
layout(location = 0) out highp float o_color0;
layout(location = 1) out highp float o_color1;
void main (void)
{
	highp uint stencil0 = subpassLoad(i_stencil, int(4 * pushConstants.splitSubpassIndex + 0u)).x;
	o_color0 = float(stencil0);
	highp uint stencil1 = subpassLoad(i_stencil, int(4 * pushConstants.splitSubpassIndex + 1u)).x;
	o_color1 = float(stencil1);
}
#version 450
layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp subpassInputMS i_depth;
layout(input_attachment_index = 0, set = 0, binding = 1) uniform highp usubpassInputMS i_stencil;
layout(push_constant) uniform PushConstant {
	highp uint splitSubpassIndex;
} pushConstants;
layout(location = 0) out highp vec2 o_color0;
layout(location = 1) out highp vec2 o_color1;
void main (void)
{
	highp float depth0 = subpassLoad(i_depth, int(4 * pushConstants.splitSubpassIndex + 0u)).x;
	highp uint stencil0 = subpassLoad(i_stencil, int(4 * pushConstants.splitSubpassIndex + 0u)).x;
	o_color0 = vec2(depth0, float(stencil0));
	highp float depth1 = subpassLoad(i_depth, int(4 * pushConstants.splitSubpassIndex + 1u)).x;
	highp uint stencil1 = subpassLoad(i_stencil, int(4 * pushConstants.splitSubpassIndex + 1u)).x;
	o_color1 = vec2(depth1, float(stencil1));
}
#version 450
layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp subpassInputMS i_color;
layout(push_constant) uniform PushConstant {
	highp uint splitSubpassIndex;
} pushConstants;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
void main (void)
{
	o_color0 = subpassLoad(i_color, int(4 * pushConstants.splitSubpassIndex + 0u));
	o_color1 = subpassLoad(i_color, int(4 * pushConstants.splitSubpassIndex + 1u));
}
#version 450
layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp usubpassInputMS i_color;
layout(push_constant) uniform PushConstant {
	highp uint splitSubpassIndex;
} pushConstants;
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp uvec4 o_color1;
void main (void)
{
	o_color0 = subpassLoad(i_color, int(4 * pushConstants.splitSubpassIndex + 0u));
	o_color1 = subpassLoad(i_color, int(4 * pushConstants.splitSubpassIndex + 1u));
}
#version 450
layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp isubpassInputMS i_color;
layout(push_constant) uniform PushConstant {
	highp uint splitSubpassIndex;
} pushConstants;
layout(location = 0) out highp ivec4 o_color0;
layout(location = 1) out highp ivec4 o_color1;
void main (void)
{
	o_color0 = subpassLoad(i_color, int(4 * pushConstants.splitSubpassIndex + 0u));
	o_color1 = subpassLoad(i_color, int(4 * pushConstants.splitSubpassIndex + 1u));
}
#version 450
layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp subpassInputMS i_depth;
layout(push_constant) uniform PushConstant {
	highp uint splitSubpassIndex;
} pushConstants;
layout(location = 0) out highp float o_color0;
layout(location = 1) out highp float o_color1;
layout(location = 2) out highp float o_color2;
layout(location = 3) out highp float o_color3;
void main (void)
{
	highp float depth0 = subpassLoad(i_depth, int(4 * pushConstants.splitSubpassIndex + 0u)).x;
	o_color0 = float(depth0);
	highp float depth1 = subpassLoad(i_depth, int(4 * pushConstants.splitSubpassIndex + 1u)).x;
	o_color1 = float(depth1);
	highp float depth2 = subpassLoad(i_depth, int(4 * pushConstants.splitSubpassIndex + 2u)).x;
	o_color2 = float(depth2);
	highp float depth3 = subpassLoad(i_depth, int(4 * pushConstants.splitSubpassIndex + 3u)).x;
	o_color3 = float(depth3);
}
#version 450
layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp usubpassInputMS i_stencil;
layout(push_constant) uniform PushConstant {
	highp uint splitSubpassIndex;
} pushConstants;
layout(location = 0) out highp float o_color0;
layout(location = 1) out highp float o_color1;
layout(location = 2) out highp float o_color2;
layout(location = 3) out highp float o_color3;
void main (void)
{
	highp uint stencil0 = subpassLoad(i_stencil, int(4 * pushConstants.splitSubpassIndex + 0u)).x;
	o_color0 = float(stencil0);
	highp uint stencil1 = subpassLoad(i_stencil, int(4 * pushConstants.splitSubpassIndex + 1u)).x;
	o_color1 = float(stencil1);
	highp uint stencil2 = subpassLoad(i_stencil, int(4 * pushConstants.splitSubpassIndex + 2u)).x;
	o_color2 = float(stencil2);
	highp uint stencil3 = subpassLoad(i_stencil, int(4 * pushConstants.splitSubpassIndex + 3u)).x;
	o_color3 = float(stencil3);
}
#version 450
layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp subpassInputMS i_depth;
layout(input_attachment_index = 0, set = 0, binding = 1) uniform highp usubpassInputMS i_stencil;
layout(push_constant) uniform PushConstant {
	highp uint splitSubpassIndex;
} pushConstants;
layout(location = 0) out highp vec2 o_color0;
layout(location = 1) out highp vec2 o_color1;
layout(location = 2) out highp vec2 o_color2;
layout(location = 3) out highp vec2 o_color3;
void main (void)
{
	highp float depth0 = subpassLoad(i_depth, int(4 * pushConstants.splitSubpassIndex + 0u)).x;
	highp uint stencil0 = subpassLoad(i_stencil, int(4 * pushConstants.splitSubpassIndex + 0u)).x;
	o_color0 = vec2(depth0, float(stencil0));
	highp float depth1 = subpassLoad(i_depth, int(4 * pushConstants.splitSubpassIndex + 1u)).x;
	highp uint stencil1 = subpassLoad(i_stencil, int(4 * pushConstants.splitSubpassIndex + 1u)).x;
	o_color1 = vec2(depth1, float(stencil1));
	highp float depth2 = subpassLoad(i_depth, int(4 * pushConstants.splitSubpassIndex + 2u)).x;
	highp uint stencil2 = subpassLoad(i_stencil, int(4 * pushConstants.splitSubpassIndex + 2u)).x;
	o_color2 = vec2(depth2, float(stencil2));
	highp float depth3 = subpassLoad(i_depth, int(4 * pushConstants.splitSubpassIndex + 3u)).x;
	highp uint stencil3 = subpassLoad(i_stencil, int(4 * pushConstants.splitSubpassIndex + 3u)).x;
	o_color3 = vec2(depth3, float(stencil3));
}
#version 450
layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp subpassInputMS i_color;
layout(push_constant) uniform PushConstant {
	highp uint splitSubpassIndex;
} pushConstants;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void)
{
	o_color0 = subpassLoad(i_color, int(4 * pushConstants.splitSubpassIndex + 0u));
	o_color1 = subpassLoad(i_color, int(4 * pushConstants.splitSubpassIndex + 1u));
	o_color2 = subpassLoad(i_color, int(4 * pushConstants.splitSubpassIndex + 2u));
	o_color3 = subpassLoad(i_color, int(4 * pushConstants.splitSubpassIndex + 3u));
}
#version 450
layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp usubpassInputMS i_color;
layout(push_constant) uniform PushConstant {
	highp uint splitSubpassIndex;
} pushConstants;
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp uvec4 o_color1;
layout(location = 2) out highp uvec4 o_color2;
layout(location = 3) out highp uvec4 o_color3;
void main (void)
{
	o_color0 = subpassLoad(i_color, int(4 * pushConstants.splitSubpassIndex + 0u));
	o_color1 = subpassLoad(i_color, int(4 * pushConstants.splitSubpassIndex + 1u));
	o_color2 = subpassLoad(i_color, int(4 * pushConstants.splitSubpassIndex + 2u));
	o_color3 = subpassLoad(i_color, int(4 * pushConstants.splitSubpassIndex + 3u));
}
#version 450
layout(input_attachment_index = 0, set = 0, binding = 0) uniform highp isubpassInputMS i_color;
layout(push_constant) uniform PushConstant {
	highp uint splitSubpassIndex;
} pushConstants;
layout(location = 0) out highp ivec4 o_color0;
layout(location = 1) out highp ivec4 o_color1;
layout(location = 2) out highp ivec4 o_color2;
layout(location = 3) out highp ivec4 o_color3;
void main (void)
{
	o_color0 = subpassLoad(i_color, int(4 * pushConstants.splitSubpassIndex + 0u));
	o_color1 = subpassLoad(i_color, int(4 * pushConstants.splitSubpassIndex + 1u));
	o_color2 = subpassLoad(i_color, int(4 * pushConstants.splitSubpassIndex + 2u));
	o_color3 = subpassLoad(i_color, int(4 * pushConstants.splitSubpassIndex + 3u));
}
