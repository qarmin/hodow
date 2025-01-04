#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	lowp float a;
	highp int b;
};
struct S2 {
	highp float a;
	highp float b;
	lowp int c;
	highp uint d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a = 6.0;
	s1.b = 8;
	s2.a = 8.0;
	s2.b = 0.0;
	s2.c = -4;
	s2.d = 0u;

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_float(6.0, s1.a) && allOk;
	allOk = compare_int(8, s1.b) && allOk;
	allOk = compare_float(8.0, s2.a) && allOk;
	allOk = compare_float(0.0, s2.b) && allOk;
	allOk = compare_int(-4, s2.c) && allOk;
	allOk = compare_uint(0u, s2.d) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	bool a;
	lowp uint b;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

shared S1 s1;

void main (void) {
	s1.a = true;
	s1.b = 0u;

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_bool(true, s1.a) && allOk;
	allOk = compare_uint(0u, s1.b) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	lowp float a;
	lowp float b;
};
struct S2 {
	highp float a;
	lowp float b;
	bool c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_bool     (bool a, bool b)                { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a = 0.0;
	s1.b = 2.0;
	s2.a = -8.0;
	s2.b = 6.0;
	s2.c = false;

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_float(0.0, s1.a) && allOk;
	allOk = compare_float(2.0, s1.b) && allOk;
	allOk = compare_float(-8.0, s2.a) && allOk;
	allOk = compare_float(6.0, s2.b) && allOk;
	allOk = compare_bool(false, s2.c) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	lowp float a;
	mediump int b;
	lowp float c;
};
struct S2 {
	highp float a;
	lowp float b;
	lowp uint c;
	bool d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a = 1.0;
	s1.b = -5;
	s1.c = -9.0;
	s2.a = -5.0;
	s2.b = 1.0;
	s2.c = 6u;
	s2.d = false;

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_float(1.0, s1.a) && allOk;
	allOk = compare_int(-5, s1.b) && allOk;
	allOk = compare_float(-9.0, s1.c) && allOk;
	allOk = compare_float(-5.0, s2.a) && allOk;
	allOk = compare_float(1.0, s2.b) && allOk;
	allOk = compare_uint(6u, s2.c) && allOk;
	allOk = compare_bool(false, s2.d) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	lowp int a;
	bool b;
	mediump int c;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

shared S1 s1;

void main (void) {
	s1.a = 2;
	s1.b = true;
	s1.c = -9;

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_int(2, s1.a) && allOk;
	allOk = compare_bool(true, s1.b) && allOk;
	allOk = compare_int(-9, s1.c) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	highp uint a;
	lowp float b;
	lowp int c;
};
struct S2 {
	mediump int a;
	bool b;
	highp uint c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a = 7u;
	s1.b = -3.0;
	s1.c = 2;
	s2.a = -4;
	s2.b = true;
	s2.c = 4u;

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_uint(7u, s1.a) && allOk;
	allOk = compare_float(-3.0, s1.b) && allOk;
	allOk = compare_int(2, s1.c) && allOk;
	allOk = compare_int(-4, s2.a) && allOk;
	allOk = compare_bool(true, s2.b) && allOk;
	allOk = compare_uint(4u, s2.c) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	bool a;
	lowp int b;
	lowp int c;
};
struct S2 {
	mediump float a;
	lowp uint b;
	mediump float c;
	mediump int d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a = true;
	s1.b = 6;
	s1.c = 6;
	s2.a = -7.0;
	s2.b = 3u;
	s2.c = 5.0;
	s2.d = -4;

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_bool(true, s1.a) && allOk;
	allOk = compare_int(6, s1.b) && allOk;
	allOk = compare_int(6, s1.c) && allOk;
	allOk = compare_float(-7.0, s2.a) && allOk;
	allOk = compare_uint(3u, s2.b) && allOk;
	allOk = compare_float(5.0, s2.c) && allOk;
	allOk = compare_int(-4, s2.d) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	mediump float a;
	lowp float b;
	lowp int c;
	bool d;
};
struct S2 {
	lowp float a;
	highp int b;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a = -5.0;
	s1.b = 5.0;
	s1.c = -6;
	s1.d = true;
	s2.a = 9.0;
	s2.b = -5;

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_float(-5.0, s1.a) && allOk;
	allOk = compare_float(5.0, s1.b) && allOk;
	allOk = compare_int(-6, s1.c) && allOk;
	allOk = compare_bool(true, s1.d) && allOk;
	allOk = compare_float(9.0, s2.a) && allOk;
	allOk = compare_int(-5, s2.b) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	lowp int a;
	mediump uint b;
	lowp float c;
	highp int d;
};
struct S2 {
	highp uint a;
	lowp int b;
	lowp float c;
	bool d;
};
struct S3 {
	lowp uint a;
	bool b;
	lowp float c;
	highp int d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

shared S1 s1;
shared S2 s2;
shared S3 s3;

void main (void) {
	s1.a = 1;
	s1.b = 5u;
	s1.c = -5.0;
	s1.d = 7;
	s2.a = 5u;
	s2.b = -1;
	s2.c = 4.0;
	s2.d = true;
	s3.a = 0u;
	s3.b = false;
	s3.c = 4.0;
	s3.d = -7;

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_int(1, s1.a) && allOk;
	allOk = compare_uint(5u, s1.b) && allOk;
	allOk = compare_float(-5.0, s1.c) && allOk;
	allOk = compare_int(7, s1.d) && allOk;
	allOk = compare_uint(5u, s2.a) && allOk;
	allOk = compare_int(-1, s2.b) && allOk;
	allOk = compare_float(4.0, s2.c) && allOk;
	allOk = compare_bool(true, s2.d) && allOk;
	allOk = compare_uint(0u, s3.a) && allOk;
	allOk = compare_bool(false, s3.b) && allOk;
	allOk = compare_float(4.0, s3.c) && allOk;
	allOk = compare_int(-7, s3.d) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	mediump float a;
	highp float b;
	highp int c;
	mediump uint d;
};
struct S2 {
	highp uint a;
	highp uint b;
	mediump float c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a = 1.0;
	s1.b = -3.0;
	s1.c = 9;
	s1.d = 7u;
	s2.a = 3u;
	s2.b = 3u;
	s2.c = -1.0;

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_float(1.0, s1.a) && allOk;
	allOk = compare_float(-3.0, s1.b) && allOk;
	allOk = compare_int(9, s1.c) && allOk;
	allOk = compare_uint(7u, s1.d) && allOk;
	allOk = compare_uint(3u, s2.a) && allOk;
	allOk = compare_uint(3u, s2.b) && allOk;
	allOk = compare_float(-1.0, s2.c) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	mediump ivec3 a;
	highp uvec2 b;
	bvec4 c;
	mediump uint d;
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

shared S1 s1;

void main (void) {
	s1.a = ivec3(6, 8, 8);
	s1.b = uvec2(4u, 4u);
	s1.c = bvec4(false, false, false, true);
	s1.d = 6u;

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_ivec3(ivec3(6, 8, 8), s1.a) && allOk;
	allOk = compare_uvec2(uvec2(4u, 4u), s1.b) && allOk;
	allOk = compare_bvec4(bvec4(false, false, false, true), s1.c) && allOk;
	allOk = compare_uint(6u, s1.d) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	mediump uvec4 a;
	highp ivec2 b;
};
struct S2 {
	bvec2 a;
	bool b;
	bool c;
	mediump vec4 d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a = uvec4(3u, 0u, 3u, 0u);
	s1.b = ivec2(-1, -9);
	s2.a = bvec2(false, true);
	s2.b = false;
	s2.c = true;
	s2.d = vec4(-4.0, -8.0, 8.0, -8.0);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_uvec4(uvec4(3u, 0u, 3u, 0u), s1.a) && allOk;
	allOk = compare_ivec2(ivec2(-1, -9), s1.b) && allOk;
	allOk = compare_bvec2(bvec2(false, true), s2.a) && allOk;
	allOk = compare_bool(false, s2.b) && allOk;
	allOk = compare_bool(true, s2.c) && allOk;
	allOk = compare_vec4(vec4(-4.0, -8.0, 8.0, -8.0), s2.d) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	bvec4 a;
	bool b;
	lowp vec3 c;
};
struct S2 {
	bool a;
	bvec3 b;
	mediump uvec3 c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a = bvec4(true, false, false, false);
	s1.b = false;
	s1.c = vec3(5.0, -6.0, 1.0);
	s2.a = false;
	s2.b = bvec3(true, true, false);
	s2.c = uvec3(0u, 0u, 3u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_bvec4(bvec4(true, false, false, false), s1.a) && allOk;
	allOk = compare_bool(false, s1.b) && allOk;
	allOk = compare_vec3(vec3(5.0, -6.0, 1.0), s1.c) && allOk;
	allOk = compare_bool(false, s2.a) && allOk;
	allOk = compare_bvec3(bvec3(true, true, false), s2.b) && allOk;
	allOk = compare_uvec3(uvec3(0u, 0u, 3u), s2.c) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	lowp vec2 a;
	mediump ivec4 b;
	lowp vec4 c;
	highp ivec4 d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

shared S1 s1;

void main (void) {
	s1.a = vec2(1.0, -5.0);
	s1.b = ivec4(-9, -5, 1, -7);
	s1.c = vec4(1.0, 2.0, 8.0, 7.0);
	s1.d = ivec4(9, -8, 2, 9);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_vec2(vec2(1.0, -5.0), s1.a) && allOk;
	allOk = compare_ivec4(ivec4(-9, -5, 1, -7), s1.b) && allOk;
	allOk = compare_vec4(vec4(1.0, 2.0, 8.0, 7.0), s1.c) && allOk;
	allOk = compare_ivec4(ivec4(9, -8, 2, 9), s1.d) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	highp uvec2 a;
	mediump ivec4 b;
	mediump float c;
	lowp ivec4 d;
};
struct S2 {
	highp ivec2 a;
	mediump ivec2 b;
	highp ivec2 c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a = uvec2(4u, 3u);
	s1.b = ivec4(-9, 3, 0, -7);
	s1.c = 7.0;
	s1.d = ivec4(-2, 3, 9, 1);
	s2.a = ivec2(-5, -2);
	s2.b = ivec2(0, 9);
	s2.c = ivec2(-1, -9);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_uvec2(uvec2(4u, 3u), s1.a) && allOk;
	allOk = compare_ivec4(ivec4(-9, 3, 0, -7), s1.b) && allOk;
	allOk = compare_float(7.0, s1.c) && allOk;
	allOk = compare_ivec4(ivec4(-2, 3, 9, 1), s1.d) && allOk;
	allOk = compare_ivec2(ivec2(-5, -2), s2.a) && allOk;
	allOk = compare_ivec2(ivec2(0, 9), s2.b) && allOk;
	allOk = compare_ivec2(ivec2(-1, -9), s2.c) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	bvec2 a;
	bvec4 b;
	highp ivec3 c;
};
struct S2 {
	lowp uvec2 a;
	lowp uint b;
	mediump vec2 c;
	lowp uint d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a = bvec2(true, false);
	s1.b = bvec4(false, false, true, true);
	s1.c = ivec3(-2, -5, -3);
	s2.a = uvec2(5u, 9u);
	s2.b = 6u;
	s2.c = vec2(8.0, 7.0);
	s2.d = 8u;

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_bvec2(bvec2(true, false), s1.a) && allOk;
	allOk = compare_bvec4(bvec4(false, false, true, true), s1.b) && allOk;
	allOk = compare_ivec3(ivec3(-2, -5, -3), s1.c) && allOk;
	allOk = compare_uvec2(uvec2(5u, 9u), s2.a) && allOk;
	allOk = compare_uint(6u, s2.b) && allOk;
	allOk = compare_vec2(vec2(8.0, 7.0), s2.c) && allOk;
	allOk = compare_uint(8u, s2.d) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	lowp float a;
	bvec3 b;
	mediump uint c;
	highp int d;
};
struct S2 {
	lowp vec2 a;
	bvec2 b;
	mediump vec4 c;
	mediump float d;
};
struct S3 {
	highp vec3 a;
	bvec4 b;
	mediump ivec3 c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

shared S1 s1;
shared S2 s2;
shared S3 s3;

void main (void) {
	s1.a = -4.0;
	s1.b = bvec3(false, false, false);
	s1.c = 3u;
	s1.d = 5;
	s2.a = vec2(-4.0, -9.0);
	s2.b = bvec2(false, true);
	s2.c = vec4(-2.0, -6.0, 4.0, -6.0);
	s2.d = -3.0;
	s3.a = vec3(2.0, -9.0, -7.0);
	s3.b = bvec4(false, false, true, false);
	s3.c = ivec3(2, -9, 0);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_float(-4.0, s1.a) && allOk;
	allOk = compare_bvec3(bvec3(false, false, false), s1.b) && allOk;
	allOk = compare_uint(3u, s1.c) && allOk;
	allOk = compare_int(5, s1.d) && allOk;
	allOk = compare_vec2(vec2(-4.0, -9.0), s2.a) && allOk;
	allOk = compare_bvec2(bvec2(false, true), s2.b) && allOk;
	allOk = compare_vec4(vec4(-2.0, -6.0, 4.0, -6.0), s2.c) && allOk;
	allOk = compare_float(-3.0, s2.d) && allOk;
	allOk = compare_vec3(vec3(2.0, -9.0, -7.0), s3.a) && allOk;
	allOk = compare_bvec4(bvec4(false, false, true, false), s3.b) && allOk;
	allOk = compare_ivec3(ivec3(2, -9, 0), s3.c) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	bvec4 a;
	lowp ivec4 b;
	mediump int c;
	bool d;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

shared S1 s1;

void main (void) {
	s1.a = bvec4(true, true, true, true);
	s1.b = ivec4(9, -5, 7, 7);
	s1.c = 0;
	s1.d = false;

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_bvec4(bvec4(true, true, true, true), s1.a) && allOk;
	allOk = compare_ivec4(ivec4(9, -5, 7, 7), s1.b) && allOk;
	allOk = compare_int(0, s1.c) && allOk;
	allOk = compare_bool(false, s1.d) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	mediump float a;
	highp ivec2 b;
	lowp ivec4 c;
	lowp float d;
};
struct S2 {
	highp ivec3 a;
	bvec4 b;
	lowp uvec4 c;
	highp uvec3 d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a = 1.0;
	s1.b = ivec2(-6, -5);
	s1.c = ivec4(7, 2, -1, 4);
	s1.d = 1.0;
	s2.a = ivec3(-8, -1, 4);
	s2.b = bvec4(true, false, false, false);
	s2.c = uvec4(2u, 8u, 6u, 3u);
	s2.d = uvec3(1u, 5u, 8u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_float(1.0, s1.a) && allOk;
	allOk = compare_ivec2(ivec2(-6, -5), s1.b) && allOk;
	allOk = compare_ivec4(ivec4(7, 2, -1, 4), s1.c) && allOk;
	allOk = compare_float(1.0, s1.d) && allOk;
	allOk = compare_ivec3(ivec3(-8, -1, 4), s2.a) && allOk;
	allOk = compare_bvec4(bvec4(true, false, false, false), s2.b) && allOk;
	allOk = compare_uvec4(uvec4(2u, 8u, 6u, 3u), s2.c) && allOk;
	allOk = compare_uvec3(uvec3(1u, 5u, 8u), s2.d) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	mediump int a;
	highp vec2 b;
	bvec3 c;
	lowp uvec2 d;
};
struct S2 {
	highp uvec2 a;
	highp ivec3 b;
	lowp vec4 c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a = 1;
	s1.b = vec2(-3.0, 9.0);
	s1.c = bvec3(true, false, false);
	s1.d = uvec2(5u, 0u);
	s2.a = uvec2(3u, 8u);
	s2.b = ivec3(5, -7, 2);
	s2.c = vec4(8.0, 8.0, 6.0, -8.0);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_int(1, s1.a) && allOk;
	allOk = compare_vec2(vec2(-3.0, 9.0), s1.b) && allOk;
	allOk = compare_bvec3(bvec3(true, false, false), s1.c) && allOk;
	allOk = compare_uvec2(uvec2(5u, 0u), s1.d) && allOk;
	allOk = compare_uvec2(uvec2(3u, 8u), s2.a) && allOk;
	allOk = compare_ivec3(ivec3(5, -7, 2), s2.b) && allOk;
	allOk = compare_vec4(vec4(8.0, 8.0, 6.0, -8.0), s2.c) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	highp uvec3 a;
	mediump int b;
	highp ivec4 c;
	highp uvec4 d;
};
struct S2 {
	highp vec2 a;
	bvec3 b;
	lowp ivec2 c;
	highp ivec4 d;
};
struct S3 {
	mediump ivec3 a;
	mediump uvec2 b;
	highp uvec4 c;
	highp vec3 d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

shared S1 s1;
shared S2 s2;
shared S3 s3;

void main (void) {
	s1.a = uvec3(0u, 2u, 0u);
	s1.b = 0;
	s1.c = ivec4(-4, -5, 9, -4);
	s1.d = uvec4(5u, 6u, 7u, 4u);
	s2.a = vec2(1.0, 6.0);
	s2.b = bvec3(true, false, false);
	s2.c = ivec2(-4, -9);
	s2.d = ivec4(8, 3, 0, 2);
	s3.a = ivec3(1, 8, 0);
	s3.b = uvec2(0u, 9u);
	s3.c = uvec4(4u, 9u, 1u, 8u);
	s3.d = vec3(-3.0, 1.0, -4.0);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_uvec3(uvec3(0u, 2u, 0u), s1.a) && allOk;
	allOk = compare_int(0, s1.b) && allOk;
	allOk = compare_ivec4(ivec4(-4, -5, 9, -4), s1.c) && allOk;
	allOk = compare_uvec4(uvec4(5u, 6u, 7u, 4u), s1.d) && allOk;
	allOk = compare_vec2(vec2(1.0, 6.0), s2.a) && allOk;
	allOk = compare_bvec3(bvec3(true, false, false), s2.b) && allOk;
	allOk = compare_ivec2(ivec2(-4, -9), s2.c) && allOk;
	allOk = compare_ivec4(ivec4(8, 3, 0, 2), s2.d) && allOk;
	allOk = compare_ivec3(ivec3(1, 8, 0), s3.a) && allOk;
	allOk = compare_uvec2(uvec2(0u, 9u), s3.b) && allOk;
	allOk = compare_uvec4(uvec4(4u, 9u, 1u, 8u), s3.c) && allOk;
	allOk = compare_vec3(vec3(-3.0, 1.0, -4.0), s3.d) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	mediump uvec4 a;
	highp float b;
};
struct S2 {
	mediump uvec4 a;
	bvec3 b;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a = uvec4(3u, 0u, 3u, 0u);
	s1.b = -1.0;
	s2.a = uvec4(5u, 4u, 3u, 2u);
	s2.b = bvec3(true, true, false);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_uvec4(uvec4(3u, 0u, 3u, 0u), s1.a) && allOk;
	allOk = compare_float(-1.0, s1.b) && allOk;
	allOk = compare_uvec4(uvec4(5u, 4u, 3u, 2u), s2.a) && allOk;
	allOk = compare_bvec3(bvec3(true, true, false), s2.b) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	mediump uvec3 a;
	lowp uint b;
	bvec3 c;
	bvec3 d;
};
struct S2 {
	mediump uvec4 a;
	mediump uvec2 b;
};
struct S3 {
	lowp uvec4 a;
	mediump ivec2 b;
	lowp uint c;
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

shared S1 s1;
shared S2 s2;
shared S3 s3;

void main (void) {
	s1.a = uvec3(8u, 0u, 0u);
	s1.b = 0u;
	s1.c = bvec3(false, false, true);
	s1.d = bvec3(true, false, true);
	s2.a = uvec4(5u, 2u, 0u, 0u);
	s2.b = uvec2(3u, 0u);
	s3.a = uvec4(7u, 4u, 8u, 9u);
	s3.b = ivec2(-4, 7);
	s3.c = 7u;

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_uvec3(uvec3(8u, 0u, 0u), s1.a) && allOk;
	allOk = compare_uint(0u, s1.b) && allOk;
	allOk = compare_bvec3(bvec3(false, false, true), s1.c) && allOk;
	allOk = compare_bvec3(bvec3(true, false, true), s1.d) && allOk;
	allOk = compare_uvec4(uvec4(5u, 2u, 0u, 0u), s2.a) && allOk;
	allOk = compare_uvec2(uvec2(3u, 0u), s2.b) && allOk;
	allOk = compare_uvec4(uvec4(7u, 4u, 8u, 9u), s3.a) && allOk;
	allOk = compare_ivec2(ivec2(-4, 7), s3.b) && allOk;
	allOk = compare_uint(7u, s3.c) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	mediump vec4 a;
	highp mat3x2 b;
	bvec4 c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

shared S1 s1;

void main (void) {
	s1.a = vec4(1.0, -5.0, -9.0, -5.0);
	s1.b = mat3x2(1.0, -7.0, 1.0, 2.0, 8.0, 7.0);
	s1.c = bvec4(false, true, false, false);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_vec4(vec4(1.0, -5.0, -9.0, -5.0), s1.a) && allOk;
	allOk = compare_mat3x2(mat3x2(1.0, -7.0, 1.0, 2.0, 8.0, 7.0), s1.b) && allOk;
	allOk = compare_bvec4(bvec4(false, true, false, false), s1.c) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	highp vec4 a;
	bool b;
};
struct S2 {
	mediump uvec2 a;
	lowp ivec2 b;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a = vec4(2.0, 7.0, -9.0, 3.0);
	s1.b = false;
	s2.a = uvec2(9u, 6u);
	s2.b = ivec2(-2, 3);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_vec4(vec4(2.0, 7.0, -9.0, 3.0), s1.a) && allOk;
	allOk = compare_bool(false, s1.b) && allOk;
	allOk = compare_uvec2(uvec2(9u, 6u), s2.a) && allOk;
	allOk = compare_ivec2(ivec2(-2, 3), s2.b) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	highp uint a;
	lowp uvec3 b;
	bool c;
	mediump ivec2 d;
};
struct S2 {
	bvec4 a;
	bvec2 b;
	mediump ivec4 c;
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a = 7u;
	s1.b = uvec3(1u, 2u, 9u);
	s1.c = true;
	s1.d = ivec2(6, -2);
	s2.a = bvec4(false, false, false, true);
	s2.b = bvec2(false, false);
	s2.c = ivec4(7, 3, 3, -4);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_uint(7u, s1.a) && allOk;
	allOk = compare_uvec3(uvec3(1u, 2u, 9u), s1.b) && allOk;
	allOk = compare_bool(true, s1.c) && allOk;
	allOk = compare_ivec2(ivec2(6, -2), s1.d) && allOk;
	allOk = compare_bvec4(bvec4(false, false, false, true), s2.a) && allOk;
	allOk = compare_bvec2(bvec2(false, false), s2.b) && allOk;
	allOk = compare_ivec4(ivec4(7, 3, 3, -4), s2.c) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	bvec2 a;
	bvec2 b;
	mediump vec2 c;
	lowp int d;
};
struct S2 {
	bvec4 a;
	mediump ivec2 b;
	lowp uvec3 c;
};
struct S3 {
	mediump vec4 a;
	bvec4 b;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

shared S1 s1;
shared S2 s2;
shared S3 s3;

void main (void) {
	s1.a = bvec2(true, false);
	s1.b = bvec2(false, false);
	s1.c = vec2(-9.0, 5.0);
	s1.d = -4;
	s2.a = bvec4(true, false, true, true);
	s2.b = ivec2(-6, 4);
	s2.c = uvec3(6u, 4u, 2u);
	s3.a = vec4(-9.0, -7.0, -5.0, -7.0);
	s3.b = bvec4(true, false, false, false);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_bvec2(bvec2(true, false), s1.a) && allOk;
	allOk = compare_bvec2(bvec2(false, false), s1.b) && allOk;
	allOk = compare_vec2(vec2(-9.0, 5.0), s1.c) && allOk;
	allOk = compare_int(-4, s1.d) && allOk;
	allOk = compare_bvec4(bvec4(true, false, true, true), s2.a) && allOk;
	allOk = compare_ivec2(ivec2(-6, 4), s2.b) && allOk;
	allOk = compare_uvec3(uvec3(6u, 4u, 2u), s2.c) && allOk;
	allOk = compare_vec4(vec4(-9.0, -7.0, -5.0, -7.0), s3.a) && allOk;
	allOk = compare_bvec4(bvec4(true, false, false, false), s3.b) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	lowp ivec2 a;
	highp uvec3 b;
	mediump ivec2 c;
};
struct S2 {
	bool a;
	bvec3 b;
};
struct S3 {
	highp vec4 a;
	bvec3 b;
	lowp vec3 c;
	highp float d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

shared S1 s1;
shared S2 s2;
shared S3 s3;

void main (void) {
	s1.a = ivec2(-5, 5);
	s1.b = uvec3(3u, 1u, 4u);
	s1.c = ivec2(-5, 7);
	s2.a = true;
	s2.b = bvec3(true, false, false);
	s3.a = vec4(-5.0, -2.0, -1.0, 5.0);
	s3.b = bvec3(false, true, false);
	s3.c = vec3(7.0, -1.0, 3.0);
	s3.d = -2.0;

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_ivec2(ivec2(-5, 5), s1.a) && allOk;
	allOk = compare_uvec3(uvec3(3u, 1u, 4u), s1.b) && allOk;
	allOk = compare_ivec2(ivec2(-5, 7), s1.c) && allOk;
	allOk = compare_bool(true, s2.a) && allOk;
	allOk = compare_bvec3(bvec3(true, false, false), s2.b) && allOk;
	allOk = compare_vec4(vec4(-5.0, -2.0, -1.0, 5.0), s3.a) && allOk;
	allOk = compare_bvec3(bvec3(false, true, false), s3.b) && allOk;
	allOk = compare_vec3(vec3(7.0, -1.0, 3.0), s3.c) && allOk;
	allOk = compare_float(-2.0, s3.d) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	bvec3 a;
	bool b;
	bvec4 c;
	highp int d;
};
struct S2 {
	lowp uvec2 a;
	bvec3 b;
	highp vec4 c;
	highp float d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a = bvec3(true, false, false);
	s1.b = false;
	s1.c = bvec4(true, true, true, true);
	s1.d = -8;
	s2.a = uvec2(4u, 5u);
	s2.b = bvec3(true, false, false);
	s2.c = vec4(1.0, 9.0, 5.0, -4.0);
	s2.d = 1.0;

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_bvec3(bvec3(true, false, false), s1.a) && allOk;
	allOk = compare_bool(false, s1.b) && allOk;
	allOk = compare_bvec4(bvec4(true, true, true, true), s1.c) && allOk;
	allOk = compare_int(-8, s1.d) && allOk;
	allOk = compare_uvec2(uvec2(4u, 5u), s2.a) && allOk;
	allOk = compare_bvec3(bvec3(true, false, false), s2.b) && allOk;
	allOk = compare_vec4(vec4(1.0, 9.0, 5.0, -4.0), s2.c) && allOk;
	allOk = compare_float(1.0, s2.d) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	lowp ivec3 a;
	highp mat4x3 b;
	mediump vec4 c;
};
struct S2 {
	lowp vec2 a;
	highp ivec3 b;
	highp ivec2 c;
	lowp uvec2 d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a = ivec3(1, -3, 9);
	s1.b = mat4x3(7.0, -5.0, 2.0, -1.0, -8.0, 2.0, -6.0, 5.0, -7.0, 2.0, 8.0, 8.0);
	s1.c = vec4(6.0, -8.0, 7.0, -1.0);
	s2.a = vec2(2.0, 2.0);
	s2.b = ivec3(6, 1, 1);
	s2.c = ivec2(1, 6);
	s2.d = uvec2(8u, 4u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_ivec3(ivec3(1, -3, 9), s1.a) && allOk;
	allOk = compare_mat4x3(mat4x3(7.0, -5.0, 2.0, -1.0, -8.0, 2.0, -6.0, 5.0, -7.0, 2.0, 8.0, 8.0), s1.b) && allOk;
	allOk = compare_vec4(vec4(6.0, -8.0, 7.0, -1.0), s1.c) && allOk;
	allOk = compare_vec2(vec2(2.0, 2.0), s2.a) && allOk;
	allOk = compare_ivec3(ivec3(6, 1, 1), s2.b) && allOk;
	allOk = compare_ivec2(ivec2(1, 6), s2.c) && allOk;
	allOk = compare_uvec2(uvec2(8u, 4u), s2.d) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	mediump vec2 a[3];
	bvec3 b[2];
	mediump ivec4 c[1];
	bool d[3];
};
struct S2 {
	lowp ivec2 a[1];
	highp uvec4 b[1];
	highp uvec4 c[1];
	lowp ivec2 d[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a[0] = vec2(6.0, 8.0);
	s1.a[1] = vec2(8.0, 0.0);
	s1.a[2] = vec2(-4.0, -5.0);
	s1.b[0] = bvec3(false, false, true);
	s1.b[1] = bvec3(true, false, true);
	s1.c[0] = ivec4(1, 6, 5, 7);
	s1.d[0] = false;
	s1.d[1] = true;
	s1.d[2] = true;
	s2.a[0] = ivec2(8, 3);
	s2.b[0] = uvec4(3u, 0u, 2u, 4u);
	s2.c[0] = uvec4(8u, 0u, 9u, 4u);
	s2.d[0] = ivec2(-7, 7);
	s2.d[1] = ivec2(-4, -3);
	s2.d[2] = ivec2(1, -4);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_vec2(vec2(6.0, 8.0), s1.a[0]) && allOk;
	allOk = compare_vec2(vec2(8.0, 0.0), s1.a[1]) && allOk;
	allOk = compare_vec2(vec2(-4.0, -5.0), s1.a[2]) && allOk;
	allOk = compare_bvec3(bvec3(false, false, true), s1.b[0]) && allOk;
	allOk = compare_bvec3(bvec3(true, false, true), s1.b[1]) && allOk;
	allOk = compare_ivec4(ivec4(1, 6, 5, 7), s1.c[0]) && allOk;
	allOk = compare_bool(false, s1.d[0]) && allOk;
	allOk = compare_bool(true, s1.d[1]) && allOk;
	allOk = compare_bool(true, s1.d[2]) && allOk;
	allOk = compare_ivec2(ivec2(8, 3), s2.a[0]) && allOk;
	allOk = compare_uvec4(uvec4(3u, 0u, 2u, 4u), s2.b[0]) && allOk;
	allOk = compare_uvec4(uvec4(8u, 0u, 9u, 4u), s2.c[0]) && allOk;
	allOk = compare_ivec2(ivec2(-7, 7), s2.d[0]) && allOk;
	allOk = compare_ivec2(ivec2(-4, -3), s2.d[1]) && allOk;
	allOk = compare_ivec2(ivec2(1, -4), s2.d[2]) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	lowp vec2 a[1];
	mediump uvec2 b[3];
};
struct S2 {
	mediump uvec2 a[3];
	bvec3 b[2];
	lowp uvec2 c[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a[0] = vec2(6.0, 6.0);
	s1.b[0] = uvec2(3u, 0u);
	s1.b[1] = uvec2(4u, 5u);
	s1.b[2] = uvec2(4u, 3u);
	s2.a[0] = uvec2(2u, 6u);
	s2.a[1] = uvec2(9u, 1u);
	s2.a[2] = uvec2(4u, 1u);
	s2.b[0] = bvec3(false, true, false);
	s2.b[1] = bvec3(false, true, false);
	s2.c[0] = uvec2(1u, 6u);
	s2.c[1] = uvec2(2u, 2u);
	s2.c[2] = uvec2(6u, 5u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_vec2(vec2(6.0, 6.0), s1.a[0]) && allOk;
	allOk = compare_uvec2(uvec2(3u, 0u), s1.b[0]) && allOk;
	allOk = compare_uvec2(uvec2(4u, 5u), s1.b[1]) && allOk;
	allOk = compare_uvec2(uvec2(4u, 3u), s1.b[2]) && allOk;
	allOk = compare_uvec2(uvec2(2u, 6u), s2.a[0]) && allOk;
	allOk = compare_uvec2(uvec2(9u, 1u), s2.a[1]) && allOk;
	allOk = compare_uvec2(uvec2(4u, 1u), s2.a[2]) && allOk;
	allOk = compare_bvec3(bvec3(false, true, false), s2.b[0]) && allOk;
	allOk = compare_bvec3(bvec3(false, true, false), s2.b[1]) && allOk;
	allOk = compare_uvec2(uvec2(1u, 6u), s2.c[0]) && allOk;
	allOk = compare_uvec2(uvec2(2u, 2u), s2.c[1]) && allOk;
	allOk = compare_uvec2(uvec2(6u, 5u), s2.c[2]) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	lowp ivec4 a[2];
	mediump vec2 b[3];
	highp uvec4 c[2];
	lowp int d[3];
};
struct S2 {
	highp float a;
	lowp ivec4 b[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a[0] = ivec4(0, 2, -8, 6);
	s1.a[1] = ivec4(7, 5, -6, 1);
	s1.b[0] = vec2(9.0, -4.0);
	s1.b[1] = vec2(-3.0, 4.0);
	s1.b[2] = vec2(4.0, 9.0);
	s1.c[0] = uvec4(3u, 0u, 7u, 4u);
	s1.c[1] = uvec4(8u, 9u, 8u, 9u);
	s1.d[0] = 2;
	s1.d[1] = -1;
	s1.d[2] = 7;
	s2.a = -5.0;
	s2.b[0] = ivec4(-4, 3, -5, -3);
	s2.b[1] = ivec4(-1, 1, 0, -3);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_ivec4(ivec4(0, 2, -8, 6), s1.a[0]) && allOk;
	allOk = compare_ivec4(ivec4(7, 5, -6, 1), s1.a[1]) && allOk;
	allOk = compare_vec2(vec2(9.0, -4.0), s1.b[0]) && allOk;
	allOk = compare_vec2(vec2(-3.0, 4.0), s1.b[1]) && allOk;
	allOk = compare_vec2(vec2(4.0, 9.0), s1.b[2]) && allOk;
	allOk = compare_uvec4(uvec4(3u, 0u, 7u, 4u), s1.c[0]) && allOk;
	allOk = compare_uvec4(uvec4(8u, 9u, 8u, 9u), s1.c[1]) && allOk;
	allOk = compare_int(2, s1.d[0]) && allOk;
	allOk = compare_int(-1, s1.d[1]) && allOk;
	allOk = compare_int(7, s1.d[2]) && allOk;
	allOk = compare_float(-5.0, s2.a) && allOk;
	allOk = compare_ivec4(ivec4(-4, 3, -5, -3), s2.b[0]) && allOk;
	allOk = compare_ivec4(ivec4(-1, 1, 0, -3), s2.b[1]) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	mediump vec3 a[1];
	bool b[3];
	mediump uint c[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

shared S1 s1;

void main (void) {
	s1.a[0] = vec3(1.0, -5.0, -9.0);
	s1.b[0] = false;
	s1.b[1] = false;
	s1.b[2] = true;
	s1.c[0] = 8u;
	s1.c[1] = 6u;

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_vec3(vec3(1.0, -5.0, -9.0), s1.a[0]) && allOk;
	allOk = compare_bool(false, s1.b[0]) && allOk;
	allOk = compare_bool(false, s1.b[1]) && allOk;
	allOk = compare_bool(true, s1.b[2]) && allOk;
	allOk = compare_uint(8u, s1.c[0]) && allOk;
	allOk = compare_uint(6u, s1.c[1]) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	highp uvec2 a[1];
	highp mat4 b[3];
};
struct S2 {
	highp vec2 a[3];
	bool b[2];
	bvec4 c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a[0] = uvec2(4u, 3u);
	s1.b[0] = mat4(-9.0, 3.0, 0.0, -7.0, 7.0, -2.0, 3.0, 9.0, 1.0, -5.0, -2.0, 0.0, 9.0, -1.0, -9.0, -6.0);
	s1.b[1] = mat4(-9.0, 6.0, 1.0, -6.0, 0.0, 2.0, 5.0, 6.0, 4.0, 1.0, -7.0, -5.0, 1.0, 2.0, -7.0, 5.0);
	s1.b[2] = mat4(-6.0, -9.0, -8.0, 8.0, -5.0, 9.0, -9.0, -2.0, 6.0, -7.0, 8.0, 3.0, 9.0, 7.0, 9.0, 7.0);
	s2.a[0] = vec2(3.0, -3.0);
	s2.a[1] = vec2(8.0, 1.0);
	s2.a[2] = vec2(-8.0, -3.0);
	s2.b[0] = false;
	s2.b[1] = false;
	s2.c = bvec4(true, true, true, false);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_uvec2(uvec2(4u, 3u), s1.a[0]) && allOk;
	allOk = compare_mat4(mat4(-9.0, 3.0, 0.0, -7.0, 7.0, -2.0, 3.0, 9.0, 1.0, -5.0, -2.0, 0.0, 9.0, -1.0, -9.0, -6.0), s1.b[0]) && allOk;
	allOk = compare_mat4(mat4(-9.0, 6.0, 1.0, -6.0, 0.0, 2.0, 5.0, 6.0, 4.0, 1.0, -7.0, -5.0, 1.0, 2.0, -7.0, 5.0), s1.b[1]) && allOk;
	allOk = compare_mat4(mat4(-6.0, -9.0, -8.0, 8.0, -5.0, 9.0, -9.0, -2.0, 6.0, -7.0, 8.0, 3.0, 9.0, 7.0, 9.0, 7.0), s1.b[2]) && allOk;
	allOk = compare_vec2(vec2(3.0, -3.0), s2.a[0]) && allOk;
	allOk = compare_vec2(vec2(8.0, 1.0), s2.a[1]) && allOk;
	allOk = compare_vec2(vec2(-8.0, -3.0), s2.a[2]) && allOk;
	allOk = compare_bool(false, s2.b[0]) && allOk;
	allOk = compare_bool(false, s2.b[1]) && allOk;
	allOk = compare_bvec4(bvec4(true, true, true, false), s2.c) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	bvec4 a[2];
	mediump uvec3 b[3];
	highp ivec2 c[3];
	mediump ivec2 d[3];
};
struct S2 {
	mediump vec2 a[2];
	lowp vec2 b[3];
	lowp float c[3];
};
struct S3 {
	mediump int a[2];
	highp vec4 b[3];
	mediump vec2 c[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

shared S1 s1;
shared S2 s2;
shared S3 s3;

void main (void) {
	s1.a[0] = bvec4(true, false, false, false);
	s1.a[1] = bvec4(true, true, false, false);
	s1.b[0] = uvec3(9u, 5u, 9u);
	s1.b[1] = uvec3(6u, 8u, 9u);
	s1.b[2] = uvec3(8u, 8u, 9u);
	s1.c[0] = ivec2(8, -7);
	s1.c[1] = ivec2(-9, -3);
	s1.c[2] = ivec2(4, -3);
	s1.d[0] = ivec2(-7, -7);
	s1.d[1] = ivec2(-1, 9);
	s1.d[2] = ivec2(-6, 8);
	s2.a[0] = vec2(-4.0, 4.0);
	s2.a[1] = vec2(1.0, -6.0);
	s2.b[0] = vec2(-2.0, -3.0);
	s2.b[1] = vec2(-5.0, 4.0);
	s2.b[2] = vec2(3.0, 0.0);
	s2.c[0] = 6.0;
	s2.c[1] = -1.0;
	s2.c[2] = -8.0;
	s3.a[0] = -3;
	s3.a[1] = -6;
	s3.b[0] = vec4(1.0, 7.0, 6.0, -5.0);
	s3.b[1] = vec4(-9.0, 2.0, 9.0, 7.0);
	s3.b[2] = vec4(3.0, 6.0, 2.0, 0.0);
	s3.c[0] = vec2(-1.0, 1.0);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_bvec4(bvec4(true, false, false, false), s1.a[0]) && allOk;
	allOk = compare_bvec4(bvec4(true, true, false, false), s1.a[1]) && allOk;
	allOk = compare_uvec3(uvec3(9u, 5u, 9u), s1.b[0]) && allOk;
	allOk = compare_uvec3(uvec3(6u, 8u, 9u), s1.b[1]) && allOk;
	allOk = compare_uvec3(uvec3(8u, 8u, 9u), s1.b[2]) && allOk;
	allOk = compare_ivec2(ivec2(8, -7), s1.c[0]) && allOk;
	allOk = compare_ivec2(ivec2(-9, -3), s1.c[1]) && allOk;
	allOk = compare_ivec2(ivec2(4, -3), s1.c[2]) && allOk;
	allOk = compare_ivec2(ivec2(-7, -7), s1.d[0]) && allOk;
	allOk = compare_ivec2(ivec2(-1, 9), s1.d[1]) && allOk;
	allOk = compare_ivec2(ivec2(-6, 8), s1.d[2]) && allOk;
	allOk = compare_vec2(vec2(-4.0, 4.0), s2.a[0]) && allOk;
	allOk = compare_vec2(vec2(1.0, -6.0), s2.a[1]) && allOk;
	allOk = compare_vec2(vec2(-2.0, -3.0), s2.b[0]) && allOk;
	allOk = compare_vec2(vec2(-5.0, 4.0), s2.b[1]) && allOk;
	allOk = compare_vec2(vec2(3.0, 0.0), s2.b[2]) && allOk;
	allOk = compare_float(6.0, s2.c[0]) && allOk;
	allOk = compare_float(-1.0, s2.c[1]) && allOk;
	allOk = compare_float(-8.0, s2.c[2]) && allOk;
	allOk = compare_int(-3, s3.a[0]) && allOk;
	allOk = compare_int(-6, s3.a[1]) && allOk;
	allOk = compare_vec4(vec4(1.0, 7.0, 6.0, -5.0), s3.b[0]) && allOk;
	allOk = compare_vec4(vec4(-9.0, 2.0, 9.0, 7.0), s3.b[1]) && allOk;
	allOk = compare_vec4(vec4(3.0, 6.0, 2.0, 0.0), s3.b[2]) && allOk;
	allOk = compare_vec2(vec2(-1.0, 1.0), s3.c[0]) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	highp mat2 a[1];
	highp uvec4 b[2];
	highp vec3 c;
	mediump uvec2 d;
};
struct S2 {
	lowp uvec3 a[1];
	bool b[1];
	bvec4 c[3];
	lowp ivec4 d[3];
};
struct S3 {
	highp uvec2 a[3];
	highp ivec2 b[1];
	highp uvec4 c[2];
	highp uint d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

shared S1 s1;
shared S2 s2;
shared S3 s3;

void main (void) {
	s1.a[0] = mat2(-4.0, 6.0, 6.0, -7.0);
	s1.b[0] = uvec4(3u, 2u, 4u, 7u);
	s1.b[1] = uvec4(0u, 3u, 2u, 0u);
	s1.c = vec3(4.0, -6.0, -3.0);
	s1.d = uvec2(2u, 2u);
	s2.a[0] = uvec3(3u, 1u, 4u);
	s2.b[0] = true;
	s2.c[0] = bvec4(false, false, false, true);
	s2.c[1] = bvec4(true, false, true, false);
	s2.c[2] = bvec4(false, true, false, true);
	s2.d[0] = ivec4(-7, 1, -8, 2);
	s2.d[1] = ivec4(0, 1, 8, -3);
	s2.d[2] = ivec4(7, -6, -9, -5);
	s3.a[0] = uvec2(2u, 2u);
	s3.a[1] = uvec2(3u, 4u);
	s3.a[2] = uvec2(6u, 2u);
	s3.b[0] = ivec2(4, -1);
	s3.c[0] = uvec4(6u, 1u, 4u, 6u);
	s3.c[1] = uvec4(0u, 3u, 2u, 3u);
	s3.d = 3u;

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_mat2(mat2(-4.0, 6.0, 6.0, -7.0), s1.a[0]) && allOk;
	allOk = compare_uvec4(uvec4(3u, 2u, 4u, 7u), s1.b[0]) && allOk;
	allOk = compare_uvec4(uvec4(0u, 3u, 2u, 0u), s1.b[1]) && allOk;
	allOk = compare_vec3(vec3(4.0, -6.0, -3.0), s1.c) && allOk;
	allOk = compare_uvec2(uvec2(2u, 2u), s1.d) && allOk;
	allOk = compare_uvec3(uvec3(3u, 1u, 4u), s2.a[0]) && allOk;
	allOk = compare_bool(true, s2.b[0]) && allOk;
	allOk = compare_bvec4(bvec4(false, false, false, true), s2.c[0]) && allOk;
	allOk = compare_bvec4(bvec4(true, false, true, false), s2.c[1]) && allOk;
	allOk = compare_bvec4(bvec4(false, true, false, true), s2.c[2]) && allOk;
	allOk = compare_ivec4(ivec4(-7, 1, -8, 2), s2.d[0]) && allOk;
	allOk = compare_ivec4(ivec4(0, 1, 8, -3), s2.d[1]) && allOk;
	allOk = compare_ivec4(ivec4(7, -6, -9, -5), s2.d[2]) && allOk;
	allOk = compare_uvec2(uvec2(2u, 2u), s3.a[0]) && allOk;
	allOk = compare_uvec2(uvec2(3u, 4u), s3.a[1]) && allOk;
	allOk = compare_uvec2(uvec2(6u, 2u), s3.a[2]) && allOk;
	allOk = compare_ivec2(ivec2(4, -1), s3.b[0]) && allOk;
	allOk = compare_uvec4(uvec4(6u, 1u, 4u, 6u), s3.c[0]) && allOk;
	allOk = compare_uvec4(uvec4(0u, 3u, 2u, 3u), s3.c[1]) && allOk;
	allOk = compare_uint(3u, s3.d) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	lowp vec4 a[2];
	highp ivec3 b[2];
	lowp mat4 c[1];
};
struct S2 {
	mediump int a[2];
	lowp vec3 b[1];
	lowp uvec3 c[2];
	mediump vec2 d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a[0] = vec4(-5.0, 5.0, -6.0, -9.0);
	s1.a[1] = vec4(9.0, -5.0, 7.0, 7.0);
	s1.b[0] = ivec3(0, 5, -7);
	s1.b[1] = ivec3(-5, -2, -1);
	s1.c[0] = mat4(5.0, 2.0, -4.0, 7.0, 7.0, -1.0, 3.0, -2.0, -1.0, -5.0, 5.0, 3.0, 9.0, -5.0, 1.0, 8.0);
	s2.a[0] = -8;
	s2.a[1] = 4;
	s2.b[0] = vec3(-8.0, -3.0, -1.0);
	s2.c[0] = uvec3(9u, 9u, 6u);
	s2.c[1] = uvec3(9u, 1u, 5u);
	s2.d = vec2(-6.0, 0.0);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_vec4(vec4(-5.0, 5.0, -6.0, -9.0), s1.a[0]) && allOk;
	allOk = compare_vec4(vec4(9.0, -5.0, 7.0, 7.0), s1.a[1]) && allOk;
	allOk = compare_ivec3(ivec3(0, 5, -7), s1.b[0]) && allOk;
	allOk = compare_ivec3(ivec3(-5, -2, -1), s1.b[1]) && allOk;
	allOk = compare_mat4(mat4(5.0, 2.0, -4.0, 7.0, 7.0, -1.0, 3.0, -2.0, -1.0, -5.0, 5.0, 3.0, 9.0, -5.0, 1.0, 8.0), s1.c[0]) && allOk;
	allOk = compare_int(-8, s2.a[0]) && allOk;
	allOk = compare_int(4, s2.a[1]) && allOk;
	allOk = compare_vec3(vec3(-8.0, -3.0, -1.0), s2.b[0]) && allOk;
	allOk = compare_uvec3(uvec3(9u, 9u, 6u), s2.c[0]) && allOk;
	allOk = compare_uvec3(uvec3(9u, 1u, 5u), s2.c[1]) && allOk;
	allOk = compare_vec2(vec2(-6.0, 0.0), s2.d) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	mediump ivec2 a[3];
	lowp float b[1];
	bvec3 c[3];
	lowp float d[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

shared S1 s1;

void main (void) {
	s1.a[0] = ivec2(1, -6);
	s1.a[1] = ivec2(-5, 7);
	s1.a[2] = ivec2(2, -1);
	s1.b[0] = 4.0;
	s1.c[0] = bvec3(true, false, false);
	s1.c[1] = bvec3(true, true, false);
	s1.c[2] = bvec3(false, false, false);
	s1.d[0] = 5.0;

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_ivec2(ivec2(1, -6), s1.a[0]) && allOk;
	allOk = compare_ivec2(ivec2(-5, 7), s1.a[1]) && allOk;
	allOk = compare_ivec2(ivec2(2, -1), s1.a[2]) && allOk;
	allOk = compare_float(4.0, s1.b[0]) && allOk;
	allOk = compare_bvec3(bvec3(true, false, false), s1.c[0]) && allOk;
	allOk = compare_bvec3(bvec3(true, true, false), s1.c[1]) && allOk;
	allOk = compare_bvec3(bvec3(false, false, false), s1.c[2]) && allOk;
	allOk = compare_float(5.0, s1.d[0]) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	mediump ivec3 a[3];
	bvec3 b[1];
	highp vec4 c;
};
struct S2 {
	lowp ivec2 a[2];
	highp mat3 b[3];
	lowp uvec2 c[1];
};
struct S3 {
	lowp ivec3 a[1];
	lowp vec2 b[1];
	mediump ivec2 c[2];
	highp ivec2 d[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

shared S1 s1;
shared S2 s2;
shared S3 s3;

void main (void) {
	s1.a[0] = ivec3(1, -3, 9);
	s1.a[1] = ivec3(7, -5, 2);
	s1.a[2] = ivec3(-1, -8, 2);
	s1.b[0] = bvec3(true, false, true);
	s1.c = vec4(2.0, 8.0, 8.0, 6.0);
	s2.a[0] = ivec2(-8, 7);
	s2.a[1] = ivec2(-1, 2);
	s2.b[0] = mat3(2.0, 6.0, 1.0, 1.0, 1.0, 6.0, -8.0, -9.0, 0.0);
	s2.b[1] = mat3(-1.0, -1.0, 5.0, 4.0, 0.0, -1.0, -2.0, -9.0, 1.0);
	s2.b[2] = mat3(0.0, 8.0, 0.0, 5.0, -7.0, 6.0, 6.0, 7.0, -7.0);
	s2.c[0] = uvec2(9u, 3u);
	s3.a[0] = ivec3(5, 1, -4);
	s3.b[0] = vec2(0.0, 4.0);
	s3.c[0] = ivec2(-4, 0);
	s3.c[1] = ivec2(0, 8);
	s3.d[0] = ivec2(-5, -1);
	s3.d[1] = ivec2(-9, -9);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_ivec3(ivec3(1, -3, 9), s1.a[0]) && allOk;
	allOk = compare_ivec3(ivec3(7, -5, 2), s1.a[1]) && allOk;
	allOk = compare_ivec3(ivec3(-1, -8, 2), s1.a[2]) && allOk;
	allOk = compare_bvec3(bvec3(true, false, true), s1.b[0]) && allOk;
	allOk = compare_vec4(vec4(2.0, 8.0, 8.0, 6.0), s1.c) && allOk;
	allOk = compare_ivec2(ivec2(-8, 7), s2.a[0]) && allOk;
	allOk = compare_ivec2(ivec2(-1, 2), s2.a[1]) && allOk;
	allOk = compare_mat3(mat3(2.0, 6.0, 1.0, 1.0, 1.0, 6.0, -8.0, -9.0, 0.0), s2.b[0]) && allOk;
	allOk = compare_mat3(mat3(-1.0, -1.0, 5.0, 4.0, 0.0, -1.0, -2.0, -9.0, 1.0), s2.b[1]) && allOk;
	allOk = compare_mat3(mat3(0.0, 8.0, 0.0, 5.0, -7.0, 6.0, 6.0, 7.0, -7.0), s2.b[2]) && allOk;
	allOk = compare_uvec2(uvec2(9u, 3u), s2.c[0]) && allOk;
	allOk = compare_ivec3(ivec3(5, 1, -4), s3.a[0]) && allOk;
	allOk = compare_vec2(vec2(0.0, 4.0), s3.b[0]) && allOk;
	allOk = compare_ivec2(ivec2(-4, 0), s3.c[0]) && allOk;
	allOk = compare_ivec2(ivec2(0, 8), s3.c[1]) && allOk;
	allOk = compare_ivec2(ivec2(-5, -1), s3.d[0]) && allOk;
	allOk = compare_ivec2(ivec2(-9, -9), s3.d[1]) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	mediump uvec4 a[2];
	mediump vec3 b[2];
	bool c[2][2][1];
	lowp ivec4 d[2][2][3];
};
struct S2 {
	lowp uvec2 a[2][2][1];
	bvec4 b[3][3][3];
	bvec2 c[1][1][1];
};
struct S3 {
	lowp float a[1][2][2];
	lowp mat4 b;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

shared S1 s1;
shared S2 s2;
shared S3 s3;

void main (void) {
	s1.a[0] = uvec4(0u, 2u, 0u, 4u);
	s1.a[1] = uvec4(4u, 0u, 9u, 3u);
	s1.b[0] = vec3(-6.0, -1.0, -1.0);
	s1.b[1] = vec3(-2.0, 1.0, 6.0);
	s1.c[0][0][0] = true;
	s1.c[0][1][0] = false;
	s1.c[1][0][0] = false;
	s1.c[1][1][0] = true;
	s1.d[0][0][0] = ivec4(-9, 8, 3, 0);
	s1.d[0][0][1] = ivec4(2, 1, 8, 0);
	s1.d[0][0][2] = ivec4(9, -1, -1, -7);
	s1.d[0][1][0] = ivec4(7, -4, -3, 1);
	s1.d[0][1][1] = ivec4(-4, -9, 1, -4);
	s1.d[0][1][2] = ivec4(0, 2, 0, 6);
	s1.d[1][0][0] = ivec4(2, 3, -5, -1);
	s1.d[1][0][1] = ivec4(-5, -1, -9, -6);
	s1.d[1][0][2] = ivec4(-9, -8, 6, -2);
	s1.d[1][1][0] = ivec4(3, 7, 2, -7);
	s1.d[1][1][1] = ivec4(-2, -5, 4, 8);
	s1.d[1][1][2] = ivec4(-9, -8, -2, -8);
	s2.a[0][0][0] = uvec2(0u, 8u);
	s2.a[0][1][0] = uvec2(8u, 1u);
	s2.a[1][0][0] = uvec2(5u, 7u);
	s2.a[1][1][0] = uvec2(0u, 2u);
	s2.b[0][0][0] = bvec4(true, false, false, true);
	s2.b[0][0][1] = bvec4(false, false, false, true);
	s2.b[0][0][2] = bvec4(true, false, false, false);
	s2.b[0][1][0] = bvec4(true, true, false, true);
	s2.b[0][1][1] = bvec4(true, true, true, true);
	s2.b[0][1][2] = bvec4(false, true, true, true);
	s2.b[0][2][0] = bvec4(true, true, true, true);
	s2.b[0][2][1] = bvec4(true, true, true, false);
	s2.b[0][2][2] = bvec4(false, true, true, true);
	s2.b[1][0][0] = bvec4(true, false, false, false);
	s2.b[1][0][1] = bvec4(true, false, true, false);
	s2.b[1][0][2] = bvec4(true, false, false, false);
	s2.b[1][1][0] = bvec4(false, true, false, true);
	s2.b[1][1][1] = bvec4(true, true, false, false);
	s2.b[1][1][2] = bvec4(false, false, false, false);
	s2.b[1][2][0] = bvec4(false, false, true, false);
	s2.b[1][2][1] = bvec4(true, false, true, false);
	s2.b[1][2][2] = bvec4(true, false, false, true);
	s2.b[2][0][0] = bvec4(false, true, true, true);
	s2.b[2][0][1] = bvec4(true, true, false, true);
	s2.b[2][0][2] = bvec4(true, false, false, true);
	s2.b[2][1][0] = bvec4(true, false, true, false);
	s2.b[2][1][1] = bvec4(false, false, false, true);
	s2.b[2][1][2] = bvec4(false, true, true, true);
	s2.b[2][2][0] = bvec4(false, true, true, true);
	s2.b[2][2][1] = bvec4(false, true, true, true);
	s2.b[2][2][2] = bvec4(true, false, true, true);
	s2.c[0][0][0] = bvec2(true, false);
	s3.a[0][0][0] = -3.0;
	s3.a[0][0][1] = -8.0;
	s3.a[0][1][0] = 8.0;
	s3.a[0][1][1] = 9.0;
	s3.b = mat4(-1.0, 1.0, 6.0, 5.0, 9.0, -9.0, 5.0, 1.0, 7.0, -6.0, 7.0, -2.0, 6.0, -9.0, -5.0, -4.0);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_uvec4(uvec4(0u, 2u, 0u, 4u), s1.a[0]) && allOk;
	allOk = compare_uvec4(uvec4(4u, 0u, 9u, 3u), s1.a[1]) && allOk;
	allOk = compare_vec3(vec3(-6.0, -1.0, -1.0), s1.b[0]) && allOk;
	allOk = compare_vec3(vec3(-2.0, 1.0, 6.0), s1.b[1]) && allOk;
	allOk = compare_bool(true, s1.c[0][0][0]) && allOk;
	allOk = compare_bool(false, s1.c[0][1][0]) && allOk;
	allOk = compare_bool(false, s1.c[1][0][0]) && allOk;
	allOk = compare_bool(true, s1.c[1][1][0]) && allOk;
	allOk = compare_ivec4(ivec4(-9, 8, 3, 0), s1.d[0][0][0]) && allOk;
	allOk = compare_ivec4(ivec4(2, 1, 8, 0), s1.d[0][0][1]) && allOk;
	allOk = compare_ivec4(ivec4(9, -1, -1, -7), s1.d[0][0][2]) && allOk;
	allOk = compare_ivec4(ivec4(7, -4, -3, 1), s1.d[0][1][0]) && allOk;
	allOk = compare_ivec4(ivec4(-4, -9, 1, -4), s1.d[0][1][1]) && allOk;
	allOk = compare_ivec4(ivec4(0, 2, 0, 6), s1.d[0][1][2]) && allOk;
	allOk = compare_ivec4(ivec4(2, 3, -5, -1), s1.d[1][0][0]) && allOk;
	allOk = compare_ivec4(ivec4(-5, -1, -9, -6), s1.d[1][0][1]) && allOk;
	allOk = compare_ivec4(ivec4(-9, -8, 6, -2), s1.d[1][0][2]) && allOk;
	allOk = compare_ivec4(ivec4(3, 7, 2, -7), s1.d[1][1][0]) && allOk;
	allOk = compare_ivec4(ivec4(-2, -5, 4, 8), s1.d[1][1][1]) && allOk;
	allOk = compare_ivec4(ivec4(-9, -8, -2, -8), s1.d[1][1][2]) && allOk;
	allOk = compare_uvec2(uvec2(0u, 8u), s2.a[0][0][0]) && allOk;
	allOk = compare_uvec2(uvec2(8u, 1u), s2.a[0][1][0]) && allOk;
	allOk = compare_uvec2(uvec2(5u, 7u), s2.a[1][0][0]) && allOk;
	allOk = compare_uvec2(uvec2(0u, 2u), s2.a[1][1][0]) && allOk;
	allOk = compare_bvec4(bvec4(true, false, false, true), s2.b[0][0][0]) && allOk;
	allOk = compare_bvec4(bvec4(false, false, false, true), s2.b[0][0][1]) && allOk;
	allOk = compare_bvec4(bvec4(true, false, false, false), s2.b[0][0][2]) && allOk;
	allOk = compare_bvec4(bvec4(true, true, false, true), s2.b[0][1][0]) && allOk;
	allOk = compare_bvec4(bvec4(true, true, true, true), s2.b[0][1][1]) && allOk;
	allOk = compare_bvec4(bvec4(false, true, true, true), s2.b[0][1][2]) && allOk;
	allOk = compare_bvec4(bvec4(true, true, true, true), s2.b[0][2][0]) && allOk;
	allOk = compare_bvec4(bvec4(true, true, true, false), s2.b[0][2][1]) && allOk;
	allOk = compare_bvec4(bvec4(false, true, true, true), s2.b[0][2][2]) && allOk;
	allOk = compare_bvec4(bvec4(true, false, false, false), s2.b[1][0][0]) && allOk;
	allOk = compare_bvec4(bvec4(true, false, true, false), s2.b[1][0][1]) && allOk;
	allOk = compare_bvec4(bvec4(true, false, false, false), s2.b[1][0][2]) && allOk;
	allOk = compare_bvec4(bvec4(false, true, false, true), s2.b[1][1][0]) && allOk;
	allOk = compare_bvec4(bvec4(true, true, false, false), s2.b[1][1][1]) && allOk;
	allOk = compare_bvec4(bvec4(false, false, false, false), s2.b[1][1][2]) && allOk;
	allOk = compare_bvec4(bvec4(false, false, true, false), s2.b[1][2][0]) && allOk;
	allOk = compare_bvec4(bvec4(true, false, true, false), s2.b[1][2][1]) && allOk;
	allOk = compare_bvec4(bvec4(true, false, false, true), s2.b[1][2][2]) && allOk;
	allOk = compare_bvec4(bvec4(false, true, true, true), s2.b[2][0][0]) && allOk;
	allOk = compare_bvec4(bvec4(true, true, false, true), s2.b[2][0][1]) && allOk;
	allOk = compare_bvec4(bvec4(true, false, false, true), s2.b[2][0][2]) && allOk;
	allOk = compare_bvec4(bvec4(true, false, true, false), s2.b[2][1][0]) && allOk;
	allOk = compare_bvec4(bvec4(false, false, false, true), s2.b[2][1][1]) && allOk;
	allOk = compare_bvec4(bvec4(false, true, true, true), s2.b[2][1][2]) && allOk;
	allOk = compare_bvec4(bvec4(false, true, true, true), s2.b[2][2][0]) && allOk;
	allOk = compare_bvec4(bvec4(false, true, true, true), s2.b[2][2][1]) && allOk;
	allOk = compare_bvec4(bvec4(true, false, true, true), s2.b[2][2][2]) && allOk;
	allOk = compare_bvec2(bvec2(true, false), s2.c[0][0][0]) && allOk;
	allOk = compare_float(-3.0, s3.a[0][0][0]) && allOk;
	allOk = compare_float(-8.0, s3.a[0][0][1]) && allOk;
	allOk = compare_float(8.0, s3.a[0][1][0]) && allOk;
	allOk = compare_float(9.0, s3.a[0][1][1]) && allOk;
	allOk = compare_mat4(mat4(-1.0, 1.0, 6.0, 5.0, 9.0, -9.0, 5.0, 1.0, 7.0, -6.0, 7.0, -2.0, 6.0, -9.0, -5.0, -4.0), s3.b) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	bvec2 a[1][2][1];
	bvec4 b[1];
	lowp uvec4 c[2];
};
struct S2 {
	highp ivec4 a[2];
	mediump vec3 b[3][2][3];
	bvec4 c[2][3][3];
};
struct S3 {
	highp uvec3 a[1][2][2];
	mediump uvec2 b[2][3];
	mediump int c[3][3][2];
	mediump vec3 d[2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

shared S1 s1;
shared S2 s2;
shared S3 s3;

void main (void) {
	s1.a[0][0][0] = bvec2(true, false);
	s1.a[0][1][0] = bvec2(false, false);
	s1.b[0] = bvec4(true, false, false, true);
	s1.c[0] = uvec4(2u, 6u, 9u, 1u);
	s1.c[1] = uvec4(4u, 1u, 4u, 9u);
	s2.a[0] = ivec4(9, -2, -2, 1);
	s2.a[1] = ivec4(1, 7, -1, 9);
	s2.b[0][0][0] = vec3(-5.0, 8.0, 4.0);
	s2.b[0][0][1] = vec3(-9.0, 8.0, -6.0);
	s2.b[0][0][2] = vec3(8.0, 2.0, -5.0);
	s2.b[0][1][0] = vec3(9.0, 3.0, -5.0);
	s2.b[0][1][1] = vec3(-3.0, 0.0, -2.0);
	s2.b[0][1][2] = vec3(-4.0, 4.0, -6.0);
	s2.b[1][0][0] = vec3(-3.0, 5.0, -2.0);
	s2.b[1][0][1] = vec3(4.0, -4.0, 8.0);
	s2.b[1][0][2] = vec3(-5.0, -4.0, -6.0);
	s2.b[1][1][0] = vec3(-3.0, 0.0, -9.0);
	s2.b[1][1][1] = vec3(9.0, 8.0, -5.0);
	s2.b[1][1][2] = vec3(8.0, -4.0, -9.0);
	s2.b[2][0][0] = vec3(6.0, 6.0, 8.0);
	s2.b[2][0][1] = vec3(-1.0, 2.0, 7.0);
	s2.b[2][0][2] = vec3(8.0, 6.0, 7.0);
	s2.b[2][1][0] = vec3(-7.0, 0.0, -3.0);
	s2.b[2][1][1] = vec3(7.0, 5.0, -5.0);
	s2.b[2][1][2] = vec3(4.0, -8.0, -1.0);
	s2.c[0][0][0] = bvec4(false, false, true, false);
	s2.c[0][0][1] = bvec4(false, true, true, false);
	s2.c[0][0][2] = bvec4(false, false, false, false);
	s2.c[0][1][0] = bvec4(false, true, false, true);
	s2.c[0][1][1] = bvec4(false, true, true, true);
	s2.c[0][1][2] = bvec4(true, true, false, true);
	s2.c[0][2][0] = bvec4(true, false, true, false);
	s2.c[0][2][1] = bvec4(true, true, true, false);
	s2.c[0][2][2] = bvec4(true, true, false, true);
	s2.c[1][0][0] = bvec4(true, true, false, true);
	s2.c[1][0][1] = bvec4(false, true, false, true);
	s2.c[1][0][2] = bvec4(false, false, true, false);
	s2.c[1][1][0] = bvec4(false, true, false, false);
	s2.c[1][1][1] = bvec4(true, true, false, false);
	s2.c[1][1][2] = bvec4(false, true, false, true);
	s2.c[1][2][0] = bvec4(true, true, true, false);
	s2.c[1][2][1] = bvec4(false, true, true, false);
	s2.c[1][2][2] = bvec4(false, false, false, true);
	s3.a[0][0][0] = uvec3(3u, 6u, 6u);
	s3.a[0][0][1] = uvec3(7u, 3u, 5u);
	s3.a[0][1][0] = uvec3(8u, 5u, 5u);
	s3.a[0][1][1] = uvec3(2u, 4u, 5u);
	s3.b[0][0] = uvec2(2u, 4u);
	s3.b[0][1] = uvec2(0u, 1u);
	s3.b[0][2] = uvec2(2u, 0u);
	s3.b[1][0] = uvec2(0u, 0u);
	s3.b[1][1] = uvec2(5u, 8u);
	s3.b[1][2] = uvec2(3u, 4u);
	s3.c[0][0][0] = 5;
	s3.c[0][0][1] = -7;
	s3.c[0][1][0] = 5;
	s3.c[0][1][1] = 2;
	s3.c[0][2][0] = -5;
	s3.c[0][2][1] = 8;
	s3.c[1][0][0] = -9;
	s3.c[1][0][1] = 8;
	s3.c[1][1][0] = 0;
	s3.c[1][1][1] = -5;
	s3.c[1][2][0] = 7;
	s3.c[1][2][1] = 6;
	s3.c[2][0][0] = -2;
	s3.c[2][0][1] = 4;
	s3.c[2][1][0] = 8;
	s3.c[2][1][1] = 9;
	s3.c[2][2][0] = -2;
	s3.c[2][2][1] = -3;
	s3.d[0][0] = vec3(-7.0, -9.0, 9.0);
	s3.d[0][1] = vec3(0.0, 9.0, 0.0);
	s3.d[0][2] = vec3(-1.0, 7.0, 8.0);
	s3.d[1][0] = vec3(-2.0, -6.0, 4.0);
	s3.d[1][1] = vec3(2.0, -4.0, 1.0);
	s3.d[1][2] = vec3(2.0, 6.0, -7.0);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_bvec2(bvec2(true, false), s1.a[0][0][0]) && allOk;
	allOk = compare_bvec2(bvec2(false, false), s1.a[0][1][0]) && allOk;
	allOk = compare_bvec4(bvec4(true, false, false, true), s1.b[0]) && allOk;
	allOk = compare_uvec4(uvec4(2u, 6u, 9u, 1u), s1.c[0]) && allOk;
	allOk = compare_uvec4(uvec4(4u, 1u, 4u, 9u), s1.c[1]) && allOk;
	allOk = compare_ivec4(ivec4(9, -2, -2, 1), s2.a[0]) && allOk;
	allOk = compare_ivec4(ivec4(1, 7, -1, 9), s2.a[1]) && allOk;
	allOk = compare_vec3(vec3(-5.0, 8.0, 4.0), s2.b[0][0][0]) && allOk;
	allOk = compare_vec3(vec3(-9.0, 8.0, -6.0), s2.b[0][0][1]) && allOk;
	allOk = compare_vec3(vec3(8.0, 2.0, -5.0), s2.b[0][0][2]) && allOk;
	allOk = compare_vec3(vec3(9.0, 3.0, -5.0), s2.b[0][1][0]) && allOk;
	allOk = compare_vec3(vec3(-3.0, 0.0, -2.0), s2.b[0][1][1]) && allOk;
	allOk = compare_vec3(vec3(-4.0, 4.0, -6.0), s2.b[0][1][2]) && allOk;
	allOk = compare_vec3(vec3(-3.0, 5.0, -2.0), s2.b[1][0][0]) && allOk;
	allOk = compare_vec3(vec3(4.0, -4.0, 8.0), s2.b[1][0][1]) && allOk;
	allOk = compare_vec3(vec3(-5.0, -4.0, -6.0), s2.b[1][0][2]) && allOk;
	allOk = compare_vec3(vec3(-3.0, 0.0, -9.0), s2.b[1][1][0]) && allOk;
	allOk = compare_vec3(vec3(9.0, 8.0, -5.0), s2.b[1][1][1]) && allOk;
	allOk = compare_vec3(vec3(8.0, -4.0, -9.0), s2.b[1][1][2]) && allOk;
	allOk = compare_vec3(vec3(6.0, 6.0, 8.0), s2.b[2][0][0]) && allOk;
	allOk = compare_vec3(vec3(-1.0, 2.0, 7.0), s2.b[2][0][1]) && allOk;
	allOk = compare_vec3(vec3(8.0, 6.0, 7.0), s2.b[2][0][2]) && allOk;
	allOk = compare_vec3(vec3(-7.0, 0.0, -3.0), s2.b[2][1][0]) && allOk;
	allOk = compare_vec3(vec3(7.0, 5.0, -5.0), s2.b[2][1][1]) && allOk;
	allOk = compare_vec3(vec3(4.0, -8.0, -1.0), s2.b[2][1][2]) && allOk;
	allOk = compare_bvec4(bvec4(false, false, true, false), s2.c[0][0][0]) && allOk;
	allOk = compare_bvec4(bvec4(false, true, true, false), s2.c[0][0][1]) && allOk;
	allOk = compare_bvec4(bvec4(false, false, false, false), s2.c[0][0][2]) && allOk;
	allOk = compare_bvec4(bvec4(false, true, false, true), s2.c[0][1][0]) && allOk;
	allOk = compare_bvec4(bvec4(false, true, true, true), s2.c[0][1][1]) && allOk;
	allOk = compare_bvec4(bvec4(true, true, false, true), s2.c[0][1][2]) && allOk;
	allOk = compare_bvec4(bvec4(true, false, true, false), s2.c[0][2][0]) && allOk;
	allOk = compare_bvec4(bvec4(true, true, true, false), s2.c[0][2][1]) && allOk;
	allOk = compare_bvec4(bvec4(true, true, false, true), s2.c[0][2][2]) && allOk;
	allOk = compare_bvec4(bvec4(true, true, false, true), s2.c[1][0][0]) && allOk;
	allOk = compare_bvec4(bvec4(false, true, false, true), s2.c[1][0][1]) && allOk;
	allOk = compare_bvec4(bvec4(false, false, true, false), s2.c[1][0][2]) && allOk;
	allOk = compare_bvec4(bvec4(false, true, false, false), s2.c[1][1][0]) && allOk;
	allOk = compare_bvec4(bvec4(true, true, false, false), s2.c[1][1][1]) && allOk;
	allOk = compare_bvec4(bvec4(false, true, false, true), s2.c[1][1][2]) && allOk;
	allOk = compare_bvec4(bvec4(true, true, true, false), s2.c[1][2][0]) && allOk;
	allOk = compare_bvec4(bvec4(false, true, true, false), s2.c[1][2][1]) && allOk;
	allOk = compare_bvec4(bvec4(false, false, false, true), s2.c[1][2][2]) && allOk;
	allOk = compare_uvec3(uvec3(3u, 6u, 6u), s3.a[0][0][0]) && allOk;
	allOk = compare_uvec3(uvec3(7u, 3u, 5u), s3.a[0][0][1]) && allOk;
	allOk = compare_uvec3(uvec3(8u, 5u, 5u), s3.a[0][1][0]) && allOk;
	allOk = compare_uvec3(uvec3(2u, 4u, 5u), s3.a[0][1][1]) && allOk;
	allOk = compare_uvec2(uvec2(2u, 4u), s3.b[0][0]) && allOk;
	allOk = compare_uvec2(uvec2(0u, 1u), s3.b[0][1]) && allOk;
	allOk = compare_uvec2(uvec2(2u, 0u), s3.b[0][2]) && allOk;
	allOk = compare_uvec2(uvec2(0u, 0u), s3.b[1][0]) && allOk;
	allOk = compare_uvec2(uvec2(5u, 8u), s3.b[1][1]) && allOk;
	allOk = compare_uvec2(uvec2(3u, 4u), s3.b[1][2]) && allOk;
	allOk = compare_int(5, s3.c[0][0][0]) && allOk;
	allOk = compare_int(-7, s3.c[0][0][1]) && allOk;
	allOk = compare_int(5, s3.c[0][1][0]) && allOk;
	allOk = compare_int(2, s3.c[0][1][1]) && allOk;
	allOk = compare_int(-5, s3.c[0][2][0]) && allOk;
	allOk = compare_int(8, s3.c[0][2][1]) && allOk;
	allOk = compare_int(-9, s3.c[1][0][0]) && allOk;
	allOk = compare_int(8, s3.c[1][0][1]) && allOk;
	allOk = compare_int(0, s3.c[1][1][0]) && allOk;
	allOk = compare_int(-5, s3.c[1][1][1]) && allOk;
	allOk = compare_int(7, s3.c[1][2][0]) && allOk;
	allOk = compare_int(6, s3.c[1][2][1]) && allOk;
	allOk = compare_int(-2, s3.c[2][0][0]) && allOk;
	allOk = compare_int(4, s3.c[2][0][1]) && allOk;
	allOk = compare_int(8, s3.c[2][1][0]) && allOk;
	allOk = compare_int(9, s3.c[2][1][1]) && allOk;
	allOk = compare_int(-2, s3.c[2][2][0]) && allOk;
	allOk = compare_int(-3, s3.c[2][2][1]) && allOk;
	allOk = compare_vec3(vec3(-7.0, -9.0, 9.0), s3.d[0][0]) && allOk;
	allOk = compare_vec3(vec3(0.0, 9.0, 0.0), s3.d[0][1]) && allOk;
	allOk = compare_vec3(vec3(-1.0, 7.0, 8.0), s3.d[0][2]) && allOk;
	allOk = compare_vec3(vec3(-2.0, -6.0, 4.0), s3.d[1][0]) && allOk;
	allOk = compare_vec3(vec3(2.0, -4.0, 1.0), s3.d[1][1]) && allOk;
	allOk = compare_vec3(vec3(2.0, 6.0, -7.0), s3.d[1][2]) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	mediump mat4x3 a[2];
	lowp float b;
	lowp vec2 c[3];
};
struct S2 {
	highp ivec4 a;
	bool b[3][1][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a[0] = mat4x3(0.0, 2.0, -8.0, 6.0, 7.0, 5.0, -6.0, 1.0, 9.0, -4.0, -3.0, 4.0);
	s1.a[1] = mat4x3(4.0, 9.0, -9.0, -8.0, -9.0, 8.0, 0.0, 4.0, -4.0, 7.0, 2.0, -1.0);
	s1.b = 7.0;
	s1.c[0] = vec2(-5.0, -4.0);
	s1.c[1] = vec2(3.0, -5.0);
	s1.c[2] = vec2(-3.0, -1.0);
	s2.a = ivec4(1, 0, -3, 1);
	s2.b[0][0][0] = true;
	s2.b[0][0][1] = false;
	s2.b[0][0][2] = false;
	s2.b[1][0][0] = true;
	s2.b[1][0][1] = false;
	s2.b[1][0][2] = true;
	s2.b[2][0][0] = false;
	s2.b[2][0][1] = true;
	s2.b[2][0][2] = true;

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_mat4x3(mat4x3(0.0, 2.0, -8.0, 6.0, 7.0, 5.0, -6.0, 1.0, 9.0, -4.0, -3.0, 4.0), s1.a[0]) && allOk;
	allOk = compare_mat4x3(mat4x3(4.0, 9.0, -9.0, -8.0, -9.0, 8.0, 0.0, 4.0, -4.0, 7.0, 2.0, -1.0), s1.a[1]) && allOk;
	allOk = compare_float(7.0, s1.b) && allOk;
	allOk = compare_vec2(vec2(-5.0, -4.0), s1.c[0]) && allOk;
	allOk = compare_vec2(vec2(3.0, -5.0), s1.c[1]) && allOk;
	allOk = compare_vec2(vec2(-3.0, -1.0), s1.c[2]) && allOk;
	allOk = compare_ivec4(ivec4(1, 0, -3, 1), s2.a) && allOk;
	allOk = compare_bool(true, s2.b[0][0][0]) && allOk;
	allOk = compare_bool(false, s2.b[0][0][1]) && allOk;
	allOk = compare_bool(false, s2.b[0][0][2]) && allOk;
	allOk = compare_bool(true, s2.b[1][0][0]) && allOk;
	allOk = compare_bool(false, s2.b[1][0][1]) && allOk;
	allOk = compare_bool(true, s2.b[1][0][2]) && allOk;
	allOk = compare_bool(false, s2.b[2][0][0]) && allOk;
	allOk = compare_bool(true, s2.b[2][0][1]) && allOk;
	allOk = compare_bool(true, s2.b[2][0][2]) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	highp vec2 a[1][1][3];
	mediump uvec3 b[2][2][1];
	lowp uvec4 c[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

shared S1 s1;

void main (void) {
	s1.a[0][0][0] = vec2(1.0, -5.0);
	s1.a[0][0][1] = vec2(-9.0, -5.0);
	s1.a[0][0][2] = vec2(1.0, -7.0);
	s1.b[0][0][0] = uvec3(8u, 6u, 2u);
	s1.b[0][1][0] = uvec3(7u, 6u, 0u);
	s1.b[1][0][0] = uvec3(7u, 2u, 5u);
	s1.b[1][1][0] = uvec3(6u, 4u, 1u);
	s1.c[0] = uvec4(2u, 0u, 8u, 8u);
	s1.c[1] = uvec4(7u, 2u, 4u, 0u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_vec2(vec2(1.0, -5.0), s1.a[0][0][0]) && allOk;
	allOk = compare_vec2(vec2(-9.0, -5.0), s1.a[0][0][1]) && allOk;
	allOk = compare_vec2(vec2(1.0, -7.0), s1.a[0][0][2]) && allOk;
	allOk = compare_uvec3(uvec3(8u, 6u, 2u), s1.b[0][0][0]) && allOk;
	allOk = compare_uvec3(uvec3(7u, 6u, 0u), s1.b[0][1][0]) && allOk;
	allOk = compare_uvec3(uvec3(7u, 2u, 5u), s1.b[1][0][0]) && allOk;
	allOk = compare_uvec3(uvec3(6u, 4u, 1u), s1.b[1][1][0]) && allOk;
	allOk = compare_uvec4(uvec4(2u, 0u, 8u, 8u), s1.c[0]) && allOk;
	allOk = compare_uvec4(uvec4(7u, 2u, 4u, 0u), s1.c[1]) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	mediump mat4 a;
	highp int b[3][1][1];
	highp ivec2 c;
	highp mat4 d[1][2][3];
};
struct S2 {
	highp uvec4 a[3][1][1];
	bool b[3][1][1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a = mat4(2.0, 7.0, -9.0, 3.0, 0.0, -7.0, 7.0, -2.0, 3.0, 9.0, 1.0, -5.0, -2.0, 0.0, 9.0, -1.0);
	s1.b[0][0][0] = -9;
	s1.b[1][0][0] = -6;
	s1.b[2][0][0] = -9;
	s1.c = ivec2(6, 1);
	s1.d[0][0][0] = mat4(-6.0, 0.0, 2.0, 5.0, 6.0, 4.0, 1.0, -7.0, -5.0, 1.0, 2.0, -7.0, 5.0, -6.0, -9.0, -8.0);
	s1.d[0][0][1] = mat4(8.0, -5.0, 9.0, -9.0, -2.0, 6.0, -7.0, 8.0, 3.0, 9.0, 7.0, 9.0, 7.0, 3.0, -3.0, 8.0);
	s1.d[0][0][2] = mat4(1.0, -8.0, -3.0, -3.0, -3.0, 3.0, 3.0, 2.0, 3.0, 1.0, 9.0, -4.0, 4.0, 8.0, 2.0, 3.0);
	s1.d[0][1][0] = mat4(0.0, -1.0, -9.0, -8.0, -2.0, 1.0, 1.0, -7.0, -9.0, -6.0, 4.0, 0.0, -3.0, -3.0, 9.0, -1.0);
	s1.d[0][1][1] = mat4(-8.0, -9.0, -7.0, -2.0, -6.0, 0.0, 5.0, 8.0, 5.0, 5.0, 3.0, 2.0, -8.0, 5.0, -7.0, 6.0);
	s1.d[0][1][2] = mat4(-9.0, -3.0, 7.0, 0.0, 9.0, 1.0, -9.0, -5.0, -9.0, 4.0, 7.0, 7.0, -1.0, -7.0, -5.0, 4.0);
	s2.a[0][0][0] = uvec4(0u, 4u, 3u, 2u);
	s2.a[1][0][0] = uvec4(2u, 1u, 7u, 8u);
	s2.a[2][0][0] = uvec4(7u, 1u, 4u, 6u);
	s2.b[0][0][0] = false;
	s2.b[1][0][0] = false;
	s2.b[2][0][0] = false;

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_mat4(mat4(2.0, 7.0, -9.0, 3.0, 0.0, -7.0, 7.0, -2.0, 3.0, 9.0, 1.0, -5.0, -2.0, 0.0, 9.0, -1.0), s1.a) && allOk;
	allOk = compare_int(-9, s1.b[0][0][0]) && allOk;
	allOk = compare_int(-6, s1.b[1][0][0]) && allOk;
	allOk = compare_int(-9, s1.b[2][0][0]) && allOk;
	allOk = compare_ivec2(ivec2(6, 1), s1.c) && allOk;
	allOk = compare_mat4(mat4(-6.0, 0.0, 2.0, 5.0, 6.0, 4.0, 1.0, -7.0, -5.0, 1.0, 2.0, -7.0, 5.0, -6.0, -9.0, -8.0), s1.d[0][0][0]) && allOk;
	allOk = compare_mat4(mat4(8.0, -5.0, 9.0, -9.0, -2.0, 6.0, -7.0, 8.0, 3.0, 9.0, 7.0, 9.0, 7.0, 3.0, -3.0, 8.0), s1.d[0][0][1]) && allOk;
	allOk = compare_mat4(mat4(1.0, -8.0, -3.0, -3.0, -3.0, 3.0, 3.0, 2.0, 3.0, 1.0, 9.0, -4.0, 4.0, 8.0, 2.0, 3.0), s1.d[0][0][2]) && allOk;
	allOk = compare_mat4(mat4(0.0, -1.0, -9.0, -8.0, -2.0, 1.0, 1.0, -7.0, -9.0, -6.0, 4.0, 0.0, -3.0, -3.0, 9.0, -1.0), s1.d[0][1][0]) && allOk;
	allOk = compare_mat4(mat4(-8.0, -9.0, -7.0, -2.0, -6.0, 0.0, 5.0, 8.0, 5.0, 5.0, 3.0, 2.0, -8.0, 5.0, -7.0, 6.0), s1.d[0][1][1]) && allOk;
	allOk = compare_mat4(mat4(-9.0, -3.0, 7.0, 0.0, 9.0, 1.0, -9.0, -5.0, -9.0, 4.0, 7.0, 7.0, -1.0, -7.0, -5.0, 4.0), s1.d[0][1][2]) && allOk;
	allOk = compare_uvec4(uvec4(0u, 4u, 3u, 2u), s2.a[0][0][0]) && allOk;
	allOk = compare_uvec4(uvec4(2u, 1u, 7u, 8u), s2.a[1][0][0]) && allOk;
	allOk = compare_uvec4(uvec4(7u, 1u, 4u, 6u), s2.a[2][0][0]) && allOk;
	allOk = compare_bool(false, s2.b[0][0][0]) && allOk;
	allOk = compare_bool(false, s2.b[1][0][0]) && allOk;
	allOk = compare_bool(false, s2.b[2][0][0]) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	highp uvec2 a[2][3];
	mediump mat4 b[3][2][1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

shared S1 s1;

void main (void) {
	s1.a[0][0] = uvec2(7u, 1u);
	s1.a[0][1] = uvec2(2u, 9u);
	s1.a[0][2] = uvec2(1u, 4u);
	s1.a[1][0] = uvec2(3u, 1u);
	s1.a[1][1] = uvec2(9u, 5u);
	s1.a[1][2] = uvec2(9u, 6u);
	s1.b[0][0][0] = mat4(8.0, 7.0, 3.0, 3.0, -4.0, 8.0, -7.0, -9.0, -3.0, 4.0, -3.0, -7.0, -7.0, -1.0, 9.0, -6.0);
	s1.b[0][1][0] = mat4(8.0, -4.0, 4.0, 1.0, -6.0, -2.0, -3.0, -5.0, 4.0, 3.0, 0.0, 6.0, -1.0, -8.0, -3.0, -6.0);
	s1.b[1][0][0] = mat4(1.0, 7.0, 6.0, -5.0, -9.0, 2.0, 9.0, 7.0, 3.0, 6.0, 2.0, 0.0, -1.0, 1.0, 1.0, 0.0);
	s1.b[1][1][0] = mat4(9.0, -2.0, -1.0, -4.0, -8.0, 0.0, 6.0, -5.0, -2.0, -7.0, -1.0, 7.0, -2.0, -9.0, -7.0, -2.0);
	s1.b[2][0][0] = mat4(-3.0, -3.0, -9.0, 6.0, 9.0, -7.0, 9.0, -7.0, 9.0, -3.0, -4.0, -8.0, -7.0, -2.0, 6.0, -3.0);
	s1.b[2][1][0] = mat4(7.0, 7.0, 8.0, -8.0, -9.0, 3.0, -2.0, 0.0, 5.0, -6.0, -6.0, -2.0, 8.0, -9.0, -6.0, -2.0);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_uvec2(uvec2(7u, 1u), s1.a[0][0]) && allOk;
	allOk = compare_uvec2(uvec2(2u, 9u), s1.a[0][1]) && allOk;
	allOk = compare_uvec2(uvec2(1u, 4u), s1.a[0][2]) && allOk;
	allOk = compare_uvec2(uvec2(3u, 1u), s1.a[1][0]) && allOk;
	allOk = compare_uvec2(uvec2(9u, 5u), s1.a[1][1]) && allOk;
	allOk = compare_uvec2(uvec2(9u, 6u), s1.a[1][2]) && allOk;
	allOk = compare_mat4(mat4(8.0, 7.0, 3.0, 3.0, -4.0, 8.0, -7.0, -9.0, -3.0, 4.0, -3.0, -7.0, -7.0, -1.0, 9.0, -6.0), s1.b[0][0][0]) && allOk;
	allOk = compare_mat4(mat4(8.0, -4.0, 4.0, 1.0, -6.0, -2.0, -3.0, -5.0, 4.0, 3.0, 0.0, 6.0, -1.0, -8.0, -3.0, -6.0), s1.b[0][1][0]) && allOk;
	allOk = compare_mat4(mat4(1.0, 7.0, 6.0, -5.0, -9.0, 2.0, 9.0, 7.0, 3.0, 6.0, 2.0, 0.0, -1.0, 1.0, 1.0, 0.0), s1.b[1][0][0]) && allOk;
	allOk = compare_mat4(mat4(9.0, -2.0, -1.0, -4.0, -8.0, 0.0, 6.0, -5.0, -2.0, -7.0, -1.0, 7.0, -2.0, -9.0, -7.0, -2.0), s1.b[1][1][0]) && allOk;
	allOk = compare_mat4(mat4(-3.0, -3.0, -9.0, 6.0, 9.0, -7.0, 9.0, -7.0, 9.0, -3.0, -4.0, -8.0, -7.0, -2.0, 6.0, -3.0), s1.b[2][0][0]) && allOk;
	allOk = compare_mat4(mat4(7.0, 7.0, 8.0, -8.0, -9.0, 3.0, -2.0, 0.0, 5.0, -6.0, -6.0, -2.0, 8.0, -9.0, -6.0, -2.0), s1.b[2][1][0]) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	highp uint a[2][1][3];
	bvec3 b[3][2][1];
	lowp int c[1];
};
struct S2 {
	highp uvec4 a[1][2][2];
	lowp uint b[2];
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a[0][0][0] = 2u;
	s1.a[0][0][1] = 3u;
	s1.a[0][0][2] = 7u;
	s1.a[1][0][0] = 5u;
	s1.a[1][0][1] = 3u;
	s1.a[1][0][2] = 2u;
	s1.b[0][0][0] = bvec3(true, true, false);
	s1.b[0][1][0] = bvec3(true, true, true);
	s1.b[1][0][0] = bvec3(false, true, false);
	s1.b[1][1][0] = bvec3(false, false, true);
	s1.b[2][0][0] = bvec3(false, false, true);
	s1.b[2][1][0] = bvec3(false, false, false);
	s1.c[0] = 0;
	s2.a[0][0][0] = uvec4(0u, 1u, 1u, 7u);
	s2.a[0][0][1] = uvec4(1u, 5u, 3u, 6u);
	s2.a[0][1][0] = uvec4(0u, 6u, 1u, 8u);
	s2.a[0][1][1] = uvec4(8u, 0u, 3u, 4u);
	s2.b[0] = 9u;
	s2.b[1] = 9u;

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_uint(2u, s1.a[0][0][0]) && allOk;
	allOk = compare_uint(3u, s1.a[0][0][1]) && allOk;
	allOk = compare_uint(7u, s1.a[0][0][2]) && allOk;
	allOk = compare_uint(5u, s1.a[1][0][0]) && allOk;
	allOk = compare_uint(3u, s1.a[1][0][1]) && allOk;
	allOk = compare_uint(2u, s1.a[1][0][2]) && allOk;
	allOk = compare_bvec3(bvec3(true, true, false), s1.b[0][0][0]) && allOk;
	allOk = compare_bvec3(bvec3(true, true, true), s1.b[0][1][0]) && allOk;
	allOk = compare_bvec3(bvec3(false, true, false), s1.b[1][0][0]) && allOk;
	allOk = compare_bvec3(bvec3(false, false, true), s1.b[1][1][0]) && allOk;
	allOk = compare_bvec3(bvec3(false, false, true), s1.b[2][0][0]) && allOk;
	allOk = compare_bvec3(bvec3(false, false, false), s1.b[2][1][0]) && allOk;
	allOk = compare_int(0, s1.c[0]) && allOk;
	allOk = compare_uvec4(uvec4(0u, 1u, 1u, 7u), s2.a[0][0][0]) && allOk;
	allOk = compare_uvec4(uvec4(1u, 5u, 3u, 6u), s2.a[0][0][1]) && allOk;
	allOk = compare_uvec4(uvec4(0u, 6u, 1u, 8u), s2.a[0][1][0]) && allOk;
	allOk = compare_uvec4(uvec4(8u, 0u, 3u, 4u), s2.a[0][1][1]) && allOk;
	allOk = compare_uint(9u, s2.b[0]) && allOk;
	allOk = compare_uint(9u, s2.b[1]) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	highp float a[2][2][1];
	lowp vec2 b[2][1][3];
	highp uvec2 c[3][3][1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

shared S1 s1;

void main (void) {
	s1.a[0][0][0] = -5.0;
	s1.a[0][1][0] = 5.0;
	s1.a[1][0][0] = -6.0;
	s1.a[1][1][0] = -9.0;
	s1.b[0][0][0] = vec2(9.0, -5.0);
	s1.b[0][0][1] = vec2(7.0, 7.0);
	s1.b[0][0][2] = vec2(0.0, 5.0);
	s1.b[1][0][0] = vec2(-7.0, -5.0);
	s1.b[1][0][1] = vec2(-2.0, -1.0);
	s1.b[1][0][2] = vec2(5.0, 2.0);
	s1.c[0][0][0] = uvec2(5u, 0u);
	s1.c[0][1][0] = uvec2(8u, 1u);
	s1.c[0][2][0] = uvec2(4u, 8u);
	s1.c[1][0][0] = uvec2(1u, 0u);
	s1.c[1][1][0] = uvec2(4u, 5u);
	s1.c[1][2][0] = uvec2(5u, 1u);
	s1.c[2][0][0] = uvec2(3u, 3u);
	s1.c[2][1][0] = uvec2(2u, 4u);
	s1.c[2][2][0] = uvec2(9u, 5u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_float(-5.0, s1.a[0][0][0]) && allOk;
	allOk = compare_float(5.0, s1.a[0][1][0]) && allOk;
	allOk = compare_float(-6.0, s1.a[1][0][0]) && allOk;
	allOk = compare_float(-9.0, s1.a[1][1][0]) && allOk;
	allOk = compare_vec2(vec2(9.0, -5.0), s1.b[0][0][0]) && allOk;
	allOk = compare_vec2(vec2(7.0, 7.0), s1.b[0][0][1]) && allOk;
	allOk = compare_vec2(vec2(0.0, 5.0), s1.b[0][0][2]) && allOk;
	allOk = compare_vec2(vec2(-7.0, -5.0), s1.b[1][0][0]) && allOk;
	allOk = compare_vec2(vec2(-2.0, -1.0), s1.b[1][0][1]) && allOk;
	allOk = compare_vec2(vec2(5.0, 2.0), s1.b[1][0][2]) && allOk;
	allOk = compare_uvec2(uvec2(5u, 0u), s1.c[0][0][0]) && allOk;
	allOk = compare_uvec2(uvec2(8u, 1u), s1.c[0][1][0]) && allOk;
	allOk = compare_uvec2(uvec2(4u, 8u), s1.c[0][2][0]) && allOk;
	allOk = compare_uvec2(uvec2(1u, 0u), s1.c[1][0][0]) && allOk;
	allOk = compare_uvec2(uvec2(4u, 5u), s1.c[1][1][0]) && allOk;
	allOk = compare_uvec2(uvec2(5u, 1u), s1.c[1][2][0]) && allOk;
	allOk = compare_uvec2(uvec2(3u, 3u), s1.c[2][0][0]) && allOk;
	allOk = compare_uvec2(uvec2(2u, 4u), s1.c[2][1][0]) && allOk;
	allOk = compare_uvec2(uvec2(9u, 5u), s1.c[2][2][0]) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	lowp vec3 a[2];
	lowp vec3 b;
	highp mat4x3 c[3][2][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

shared S1 s1;

void main (void) {
	s1.a[0] = vec3(1.0, -6.0, -5.0);
	s1.a[1] = vec3(7.0, 2.0, -1.0);
	s1.b = vec3(4.0, 1.0, -8.0);
	s1.c[0][0][0] = mat4x3(-1.0, 4.0, -7.0, 3.0, 8.0, 1.0, 9.0, 5.0, -4.0, 1.0, -4.0, -4.0);
	s1.c[0][0][1] = mat4x3(-3.0, 1.0, 5.0, 6.0, 9.0, 0.0, 1.0, -3.0, 1.0, 6.0, 6.0, 6.0);
	s1.c[0][1][0] = mat4x3(-8.0, 6.0, 6.0, 5.0, 1.0, 4.0, 6.0, -4.0, 0.0, 1.0, 2.0, -1.0);
	s1.c[0][1][1] = mat4x3(9.0, -9.0, 9.0, 3.0, -9.0, 3.0, 5.0, 2.0, 3.0, 1.0, -6.0, -5.0);
	s1.c[1][0][0] = mat4x3(9.0, 1.0, 5.0, -7.0, 6.0, -1.0, -9.0, -5.0, 8.0, 5.0, -4.0, -1.0);
	s1.c[1][0][1] = mat4x3(-8.0, 4.0, -7.0, 1.0, 4.0, -2.0, 0.0, -1.0, -3.0, -7.0, 2.0, 3.0);
	s1.c[1][1][0] = mat4x3(2.0, 6.0, -6.0, 8.0, 2.0, -5.0, 9.0, -2.0, 9.0, 9.0, 2.0, 1.0);
	s1.c[1][1][1] = mat4x3(-5.0, 8.0, -5.0, 3.0, 9.0, 6.0, -8.0, 6.0, 4.0, 4.0, -7.0, -3.0);
	s1.c[2][0][0] = mat4x3(7.0, -3.0, 9.0, -7.0, -5.0, -7.0, 0.0, -2.0, 3.0, 2.0, -6.0, -2.0);
	s1.c[2][0][1] = mat4x3(1.0, 6.0, -3.0, 1.0, -6.0, 5.0, -1.0, -2.0, -6.0, -9.0, 1.0, 9.0);
	s1.c[2][1][0] = mat4x3(4.0, 1.0, 6.0, 1.0, 6.0, -8.0, 5.0, -6.0, 2.0, -9.0, 3.0, 9.0);
	s1.c[2][1][1] = mat4x3(-2.0, 2.0, -7.0, 1.0, -1.0, 6.0, -6.0, 4.0, 6.0, 2.0, -3.0, -4.0);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_vec3(vec3(1.0, -6.0, -5.0), s1.a[0]) && allOk;
	allOk = compare_vec3(vec3(7.0, 2.0, -1.0), s1.a[1]) && allOk;
	allOk = compare_vec3(vec3(4.0, 1.0, -8.0), s1.b) && allOk;
	allOk = compare_mat4x3(mat4x3(-1.0, 4.0, -7.0, 3.0, 8.0, 1.0, 9.0, 5.0, -4.0, 1.0, -4.0, -4.0), s1.c[0][0][0]) && allOk;
	allOk = compare_mat4x3(mat4x3(-3.0, 1.0, 5.0, 6.0, 9.0, 0.0, 1.0, -3.0, 1.0, 6.0, 6.0, 6.0), s1.c[0][0][1]) && allOk;
	allOk = compare_mat4x3(mat4x3(-8.0, 6.0, 6.0, 5.0, 1.0, 4.0, 6.0, -4.0, 0.0, 1.0, 2.0, -1.0), s1.c[0][1][0]) && allOk;
	allOk = compare_mat4x3(mat4x3(9.0, -9.0, 9.0, 3.0, -9.0, 3.0, 5.0, 2.0, 3.0, 1.0, -6.0, -5.0), s1.c[0][1][1]) && allOk;
	allOk = compare_mat4x3(mat4x3(9.0, 1.0, 5.0, -7.0, 6.0, -1.0, -9.0, -5.0, 8.0, 5.0, -4.0, -1.0), s1.c[1][0][0]) && allOk;
	allOk = compare_mat4x3(mat4x3(-8.0, 4.0, -7.0, 1.0, 4.0, -2.0, 0.0, -1.0, -3.0, -7.0, 2.0, 3.0), s1.c[1][0][1]) && allOk;
	allOk = compare_mat4x3(mat4x3(2.0, 6.0, -6.0, 8.0, 2.0, -5.0, 9.0, -2.0, 9.0, 9.0, 2.0, 1.0), s1.c[1][1][0]) && allOk;
	allOk = compare_mat4x3(mat4x3(-5.0, 8.0, -5.0, 3.0, 9.0, 6.0, -8.0, 6.0, 4.0, 4.0, -7.0, -3.0), s1.c[1][1][1]) && allOk;
	allOk = compare_mat4x3(mat4x3(7.0, -3.0, 9.0, -7.0, -5.0, -7.0, 0.0, -2.0, 3.0, 2.0, -6.0, -2.0), s1.c[2][0][0]) && allOk;
	allOk = compare_mat4x3(mat4x3(1.0, 6.0, -3.0, 1.0, -6.0, 5.0, -1.0, -2.0, -6.0, -9.0, 1.0, 9.0), s1.c[2][0][1]) && allOk;
	allOk = compare_mat4x3(mat4x3(4.0, 1.0, 6.0, 1.0, 6.0, -8.0, 5.0, -6.0, 2.0, -9.0, 3.0, 9.0), s1.c[2][1][0]) && allOk;
	allOk = compare_mat4x3(mat4x3(-2.0, 2.0, -7.0, 1.0, -1.0, 6.0, -6.0, 4.0, 6.0, 2.0, -3.0, -4.0), s1.c[2][1][1]) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	lowp vec4 a[1][3][1];
	highp uvec4 b[3];
	lowp ivec3 c[1][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

shared S1 s1;

void main (void) {
	s1.a[0][0][0] = vec4(1.0, -3.0, 9.0, 7.0);
	s1.a[0][1][0] = vec4(-5.0, 2.0, -1.0, -8.0);
	s1.a[0][2][0] = vec4(2.0, -6.0, 5.0, -7.0);
	s1.b[0] = uvec4(1u, 7u, 1u, 2u);
	s1.b[1] = uvec4(9u, 2u, 1u, 5u);
	s1.b[2] = uvec4(9u, 6u, 1u, 3u);
	s1.c[0][0] = ivec3(1, 6, -8);
	s1.c[0][1] = ivec3(-9, 0, -1);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_vec4(vec4(1.0, -3.0, 9.0, 7.0), s1.a[0][0][0]) && allOk;
	allOk = compare_vec4(vec4(-5.0, 2.0, -1.0, -8.0), s1.a[0][1][0]) && allOk;
	allOk = compare_vec4(vec4(2.0, -6.0, 5.0, -7.0), s1.a[0][2][0]) && allOk;
	allOk = compare_uvec4(uvec4(1u, 7u, 1u, 2u), s1.b[0]) && allOk;
	allOk = compare_uvec4(uvec4(9u, 2u, 1u, 5u), s1.b[1]) && allOk;
	allOk = compare_uvec4(uvec4(9u, 6u, 1u, 3u), s1.b[2]) && allOk;
	allOk = compare_ivec3(ivec3(1, 6, -8), s1.c[0][0]) && allOk;
	allOk = compare_ivec3(ivec3(-9, 0, -1), s1.c[0][1]) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	highp mat4 mA;
	bvec3 mB;
	bvec4 mC;
};
struct sB
{
	bvec2 mA;
};
struct sC
{
	highp float mA;
	mediump uvec4 mB;
	mediump float mC;
};
struct sD
{
	sA mA;
	sB mB;
	sC mC;
};
struct sE
{
	sD mA;
};
struct sF
{
	lowp uvec3 mA;
	bool mB;
};
struct sG
{
	sF mA;
	highp mat3x2 mB;
};
struct sH
{
	sG mA;
	mediump vec2 mB;
};
struct sI
{
	mediump mat2 mA;
	bvec3 mB;
	bvec4 mC;
};
struct sJ
{
	sI mA;
	bvec3 mB;
};
struct sK
{
	bvec2 mA;
	sJ mB;
	mediump ivec2 mC;
};
struct S1 {
	lowp uint a;
	mediump vec4 b;
};
struct S2 {
	sE a;
	highp ivec3 b;
	sH c;
	sK d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a = 0u;
	s1.b = vec4(8.0, 8.0, 0.0, -4.0);
	s2.a.mA.mA.mA = mat4(-5.0, 9.0, -4.0, -6.0, -1.0, -1.0, -2.0, 1.0, 6.0, 5.0, 7.0, -2.0, -4.0, -9.0, 8.0, 3.0);
	s2.a.mA.mA.mB = bvec3(true, false, false);
	s2.a.mA.mA.mC = bvec4(true, true, true, false);
	s2.a.mA.mB.mA = bvec2(true, true);
	s2.a.mA.mC.mA = 7.0;
	s2.a.mA.mC.mB = uvec4(8u, 6u, 2u, 0u);
	s2.a.mA.mC.mC = -9.0;
	s2.b = ivec3(1, -4, 0);
	s2.c.mA.mA.mA = uvec3(4u, 9u, 1u);
	s2.c.mA.mA.mB = false;
	s2.c.mA.mB = mat3x2(3.0, -5.0, -1.0, -5.0, -1.0, -9.0);
	s2.c.mB = vec2(-6.0, -9.0);
	s2.d.mA = bvec2(true, false);
	s2.d.mB.mA.mA = mat2(-2.0, 3.0, 7.0, 2.0);
	s2.d.mB.mA.mB = bvec3(false, false, false);
	s2.d.mB.mA.mC = bvec4(false, false, false, true);
	s2.d.mB.mB = bvec3(true, false, false);
	s2.d.mC = ivec2(-9, 0);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_uint(0u, s1.a) && allOk;
	allOk = compare_vec4(vec4(8.0, 8.0, 0.0, -4.0), s1.b) && allOk;
	allOk = compare_mat4(mat4(-5.0, 9.0, -4.0, -6.0, -1.0, -1.0, -2.0, 1.0, 6.0, 5.0, 7.0, -2.0, -4.0, -9.0, 8.0, 3.0), s2.a.mA.mA.mA) && allOk;
	allOk = compare_bvec3(bvec3(true, false, false), s2.a.mA.mA.mB) && allOk;
	allOk = compare_bvec4(bvec4(true, true, true, false), s2.a.mA.mA.mC) && allOk;
	allOk = compare_bvec2(bvec2(true, true), s2.a.mA.mB.mA) && allOk;
	allOk = compare_float(7.0, s2.a.mA.mC.mA) && allOk;
	allOk = compare_uvec4(uvec4(8u, 6u, 2u, 0u), s2.a.mA.mC.mB) && allOk;
	allOk = compare_float(-9.0, s2.a.mA.mC.mC) && allOk;
	allOk = compare_ivec3(ivec3(1, -4, 0), s2.b) && allOk;
	allOk = compare_uvec3(uvec3(4u, 9u, 1u), s2.c.mA.mA.mA) && allOk;
	allOk = compare_bool(false, s2.c.mA.mA.mB) && allOk;
	allOk = compare_mat3x2(mat3x2(3.0, -5.0, -1.0, -5.0, -1.0, -9.0), s2.c.mA.mB) && allOk;
	allOk = compare_vec2(vec2(-6.0, -9.0), s2.c.mB) && allOk;
	allOk = compare_bvec2(bvec2(true, false), s2.d.mA) && allOk;
	allOk = compare_mat2(mat2(-2.0, 3.0, 7.0, 2.0), s2.d.mB.mA.mA) && allOk;
	allOk = compare_bvec3(bvec3(false, false, false), s2.d.mB.mA.mB) && allOk;
	allOk = compare_bvec4(bvec4(false, false, false, true), s2.d.mB.mA.mC) && allOk;
	allOk = compare_bvec3(bvec3(true, false, false), s2.d.mB.mB) && allOk;
	allOk = compare_ivec2(ivec2(-9, 0), s2.d.mC) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	bvec3 mA;
};
struct sB
{
	sA mA;
	mediump ivec2 mB;
};
struct sC
{
	bool mA;
	mediump int mB;
};
struct sD
{
	sC mA;
	mediump vec4 mB;
};
struct sE
{
	sD mA;
	lowp mat4x2 mB;
};
struct sF
{
	bvec4 mA;
	lowp int mB;
	mediump uvec4 mC;
};
struct sG
{
	lowp uint mA;
	mediump ivec2 mB;
	mediump vec4 mC;
};
struct sH
{
	sF mA;
	sG mB;
};
struct sI
{
	lowp uint mA;
	bvec2 mB;
};
struct sJ
{
	highp float mA;
	lowp uvec3 mB;
};
struct sK
{
	sI mA;
	sJ mB;
};
struct sL
{
	lowp vec2 mA;
	bool mB;
};
struct sM
{
	bvec2 mA;
	highp ivec4 mB;
	mediump vec4 mC;
};
struct sN
{
	mediump vec4 mA;
	sL mB;
	sM mC;
};
struct sO
{
	sH mA;
	sK mB;
	sN mC;
};
struct sP
{
	mediump ivec4 mA;
};
struct sQ
{
	mediump ivec3 mA;
};
struct sR
{
	lowp mat3 mA;
};
struct sS
{
	sQ mA;
	sR mB;
};
struct sT
{
	bvec4 mA;
	sS mB;
};
struct sU
{
	highp vec2 mA;
	highp vec3 mB;
	bvec3 mC;
};
struct sV
{
	mediump ivec3 mA;
	highp vec3 mB;
};
struct sW
{
	sU mA;
	lowp uvec2 mB;
	sV mC;
};
struct sX
{
	mediump ivec4 mA;
};
struct sY
{
	mediump uvec4 mA;
};
struct sZ
{
	sX mA;
	sY mB;
};
struct sAA
{
	sW mA;
	sZ mB;
};
struct S1 {
	sB a;
	sE b;
};
struct S2 {
	sO a;
	mediump vec4 b;
	sP c;
};
struct S3 {
	sT a;
	sAA b;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

shared S1 s1;
shared S2 s2;
shared S3 s3;

void main (void) {
	s1.a.mA.mA = bvec3(true, false, false);
	s1.a.mB = ivec2(-3, -1);
	s1.b.mA.mA.mA = false;
	s1.b.mA.mA.mB = 5;
	s1.b.mA.mB = vec4(-7.0, -9.0, 8.0, -4.0);
	s1.b.mB = mat4x2(-8.0, 8.0, -8.0, -6.0, -2.0, 9.0, -2.0, -2.0);
	s2.a.mA.mA.mA = bvec4(false, true, true, false);
	s2.a.mA.mA.mB = 9;
	s2.a.mA.mA.mC = uvec4(6u, 5u, 5u, 7u);
	s2.a.mA.mB.mA = 8u;
	s2.a.mA.mB.mB = ivec2(-6, 8);
	s2.a.mA.mB.mC = vec4(2.0, -5.0, 9.0, 3.0);
	s2.a.mB.mA.mA = 1u;
	s2.a.mB.mA.mB = bvec2(false, true);
	s2.a.mB.mB.mA = -2.0;
	s2.a.mB.mB.mB = uvec3(2u, 1u, 4u);
	s2.a.mC.mA = vec4(-3.0, 5.0, -2.0, 4.0);
	s2.a.mC.mB.mA = vec2(-4.0, 8.0);
	s2.a.mC.mB.mB = true;
	s2.a.mC.mC.mA = bvec2(false, false);
	s2.a.mC.mC.mB = ivec4(-3, 0, -9, 9);
	s2.a.mC.mC.mC = vec4(8.0, -5.0, 8.0, -4.0);
	s2.b = vec4(-9.0, 6.0, 6.0, 8.0);
	s2.c.mA = ivec4(-1, 2, 7, 8);
	s3.a.mA = bvec4(false, false, false, false);
	s3.a.mB.mA.mA = ivec3(-3, 7, 5);
	s3.a.mB.mB.mA = mat3(-5.0, 4.0, -8.0, -1.0, 2.0, -5.0, 6.0, 2.0, -7.0);
	s3.b.mA.mA.mA = vec2(-6.0, 2.0);
	s3.b.mA.mA.mB = vec3(7.0, -8.0, -4.0);
	s3.b.mA.mA.mC = bvec3(false, false, false);
	s3.b.mA.mB = uvec2(5u, 2u);
	s3.b.mA.mC.mA = ivec3(2, -3, -6);
	s3.b.mA.mC.mB = vec3(1.0, 4.0, 9.0);
	s3.b.mB.mA.mA = ivec4(-7, 4, 6, 5);
	s3.b.mB.mB.mA = uvec4(7u, 7u, 0u, 2u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_bvec3(bvec3(true, false, false), s1.a.mA.mA) && allOk;
	allOk = compare_ivec2(ivec2(-3, -1), s1.a.mB) && allOk;
	allOk = compare_bool(false, s1.b.mA.mA.mA) && allOk;
	allOk = compare_int(5, s1.b.mA.mA.mB) && allOk;
	allOk = compare_vec4(vec4(-7.0, -9.0, 8.0, -4.0), s1.b.mA.mB) && allOk;
	allOk = compare_mat4x2(mat4x2(-8.0, 8.0, -8.0, -6.0, -2.0, 9.0, -2.0, -2.0), s1.b.mB) && allOk;
	allOk = compare_bvec4(bvec4(false, true, true, false), s2.a.mA.mA.mA) && allOk;
	allOk = compare_int(9, s2.a.mA.mA.mB) && allOk;
	allOk = compare_uvec4(uvec4(6u, 5u, 5u, 7u), s2.a.mA.mA.mC) && allOk;
	allOk = compare_uint(8u, s2.a.mA.mB.mA) && allOk;
	allOk = compare_ivec2(ivec2(-6, 8), s2.a.mA.mB.mB) && allOk;
	allOk = compare_vec4(vec4(2.0, -5.0, 9.0, 3.0), s2.a.mA.mB.mC) && allOk;
	allOk = compare_uint(1u, s2.a.mB.mA.mA) && allOk;
	allOk = compare_bvec2(bvec2(false, true), s2.a.mB.mA.mB) && allOk;
	allOk = compare_float(-2.0, s2.a.mB.mB.mA) && allOk;
	allOk = compare_uvec3(uvec3(2u, 1u, 4u), s2.a.mB.mB.mB) && allOk;
	allOk = compare_vec4(vec4(-3.0, 5.0, -2.0, 4.0), s2.a.mC.mA) && allOk;
	allOk = compare_vec2(vec2(-4.0, 8.0), s2.a.mC.mB.mA) && allOk;
	allOk = compare_bool(true, s2.a.mC.mB.mB) && allOk;
	allOk = compare_bvec2(bvec2(false, false), s2.a.mC.mC.mA) && allOk;
	allOk = compare_ivec4(ivec4(-3, 0, -9, 9), s2.a.mC.mC.mB) && allOk;
	allOk = compare_vec4(vec4(8.0, -5.0, 8.0, -4.0), s2.a.mC.mC.mC) && allOk;
	allOk = compare_vec4(vec4(-9.0, 6.0, 6.0, 8.0), s2.b) && allOk;
	allOk = compare_ivec4(ivec4(-1, 2, 7, 8), s2.c.mA) && allOk;
	allOk = compare_bvec4(bvec4(false, false, false, false), s3.a.mA) && allOk;
	allOk = compare_ivec3(ivec3(-3, 7, 5), s3.a.mB.mA.mA) && allOk;
	allOk = compare_mat3(mat3(-5.0, 4.0, -8.0, -1.0, 2.0, -5.0, 6.0, 2.0, -7.0), s3.a.mB.mB.mA) && allOk;
	allOk = compare_vec2(vec2(-6.0, 2.0), s3.b.mA.mA.mA) && allOk;
	allOk = compare_vec3(vec3(7.0, -8.0, -4.0), s3.b.mA.mA.mB) && allOk;
	allOk = compare_bvec3(bvec3(false, false, false), s3.b.mA.mA.mC) && allOk;
	allOk = compare_uvec2(uvec2(5u, 2u), s3.b.mA.mB) && allOk;
	allOk = compare_ivec3(ivec3(2, -3, -6), s3.b.mA.mC.mA) && allOk;
	allOk = compare_vec3(vec3(1.0, 4.0, 9.0), s3.b.mA.mC.mB) && allOk;
	allOk = compare_ivec4(ivec4(-7, 4, 6, 5), s3.b.mB.mA.mA) && allOk;
	allOk = compare_uvec4(uvec4(7u, 7u, 0u, 2u), s3.b.mB.mB.mA) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	mediump uint mA;
	lowp int mB;
};
struct sB
{
	lowp ivec2 mA;
	bvec2 mB;
	bool mC;
};
struct sC
{
	bvec4 mA;
	sA mB;
	sB mC;
};
struct sD
{
	mediump int mA;
	lowp vec3 mB;
	bvec4 mC;
};
struct sE
{
	mediump ivec3 mA;
};
struct sF
{
	highp uint mA;
	highp float mB;
	highp ivec2 mC;
};
struct sG
{
	sD mA;
	sE mB;
	sF mC;
};
struct sH
{
	sC mA;
	sG mB;
	bvec4 mC;
};
struct sI
{
	mediump vec3 mA;
	lowp uvec4 mB;
	bvec2 mC;
};
struct sJ
{
	highp uvec2 mA;
	lowp uvec3 mB;
};
struct sK
{
	lowp ivec3 mA;
};
struct sL
{
	sI mA;
	sJ mB;
	sK mC;
};
struct sM
{
	highp vec2 mA;
};
struct sN
{
	sL mA;
	sM mB;
};
struct sO
{
	highp mat4x2 mA;
};
struct sP
{
	sO mA;
};
struct sQ
{
	sP mA;
	lowp uvec3 mB;
};
struct sR
{
	lowp int mA;
	highp vec4 mB;
	highp float mC;
};
struct sS
{
	sR mA;
};
struct sT
{
	sS mA;
};
struct S1 {
	sH a;
	sN b;
	sQ c;
};
struct S2 {
	highp uvec4 a;
	highp vec4 b;
	sT c;
	mediump ivec3 d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a.mA.mA = bvec4(true, false, false, false);
	s1.a.mA.mB.mA = 2u;
	s1.a.mA.mB.mB = 5;
	s1.a.mA.mC.mA = ivec2(-6, 1);
	s1.a.mA.mC.mB = bvec2(false, true);
	s1.a.mA.mC.mC = true;
	s1.a.mB.mA.mA = 4;
	s1.a.mB.mA.mB = vec3(4.0, 9.0, -9.0);
	s1.a.mB.mA.mC = bvec4(true, true, false, true);
	s1.a.mB.mB.mA = ivec3(4, -4, 7);
	s1.a.mB.mC.mA = 7u;
	s1.a.mB.mC.mB = -1.0;
	s1.a.mB.mC.mC = ivec2(7, -5);
	s1.a.mC = bvec4(true, false, false, true);
	s1.b.mA.mA.mA = vec3(-1.0, 1.0, 0.0);
	s1.b.mA.mA.mB = uvec4(4u, 5u, 7u, 7u);
	s1.b.mA.mA.mC = bvec2(false, true);
	s1.b.mA.mB.mA = uvec2(2u, 8u);
	s1.b.mA.mB.mB = uvec3(0u, 6u, 7u);
	s1.b.mA.mC.mA = ivec3(9, -7, -8);
	s1.b.mB.mA = vec2(1.0, 6.0);
	s1.c.mA.mA.mA = mat4x2(0.0, -3.0, 4.0, -7.0, -1.0, 5.0, -3.0, 0.0);
	s1.c.mB = uvec3(8u, 7u, 2u);
	s2.a = uvec4(8u, 3u, 0u, 7u);
	s2.b = vec4(-2.0, 2.0, -4.0, 4.0);
	s2.c.mA.mA.mA = -8;
	s2.c.mA.mA.mB = vec4(4.0, 8.0, 5.0, -7.0);
	s2.c.mA.mA.mC = -8.0;
	s2.d = ivec3(-5, 0, 1);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_bvec4(bvec4(true, false, false, false), s1.a.mA.mA) && allOk;
	allOk = compare_uint(2u, s1.a.mA.mB.mA) && allOk;
	allOk = compare_int(5, s1.a.mA.mB.mB) && allOk;
	allOk = compare_ivec2(ivec2(-6, 1), s1.a.mA.mC.mA) && allOk;
	allOk = compare_bvec2(bvec2(false, true), s1.a.mA.mC.mB) && allOk;
	allOk = compare_bool(true, s1.a.mA.mC.mC) && allOk;
	allOk = compare_int(4, s1.a.mB.mA.mA) && allOk;
	allOk = compare_vec3(vec3(4.0, 9.0, -9.0), s1.a.mB.mA.mB) && allOk;
	allOk = compare_bvec4(bvec4(true, true, false, true), s1.a.mB.mA.mC) && allOk;
	allOk = compare_ivec3(ivec3(4, -4, 7), s1.a.mB.mB.mA) && allOk;
	allOk = compare_uint(7u, s1.a.mB.mC.mA) && allOk;
	allOk = compare_float(-1.0, s1.a.mB.mC.mB) && allOk;
	allOk = compare_ivec2(ivec2(7, -5), s1.a.mB.mC.mC) && allOk;
	allOk = compare_bvec4(bvec4(true, false, false, true), s1.a.mC) && allOk;
	allOk = compare_vec3(vec3(-1.0, 1.0, 0.0), s1.b.mA.mA.mA) && allOk;
	allOk = compare_uvec4(uvec4(4u, 5u, 7u, 7u), s1.b.mA.mA.mB) && allOk;
	allOk = compare_bvec2(bvec2(false, true), s1.b.mA.mA.mC) && allOk;
	allOk = compare_uvec2(uvec2(2u, 8u), s1.b.mA.mB.mA) && allOk;
	allOk = compare_uvec3(uvec3(0u, 6u, 7u), s1.b.mA.mB.mB) && allOk;
	allOk = compare_ivec3(ivec3(9, -7, -8), s1.b.mA.mC.mA) && allOk;
	allOk = compare_vec2(vec2(1.0, 6.0), s1.b.mB.mA) && allOk;
	allOk = compare_mat4x2(mat4x2(0.0, -3.0, 4.0, -7.0, -1.0, 5.0, -3.0, 0.0), s1.c.mA.mA.mA) && allOk;
	allOk = compare_uvec3(uvec3(8u, 7u, 2u), s1.c.mB) && allOk;
	allOk = compare_uvec4(uvec4(8u, 3u, 0u, 7u), s2.a) && allOk;
	allOk = compare_vec4(vec4(-2.0, 2.0, -4.0, 4.0), s2.b) && allOk;
	allOk = compare_int(-8, s2.c.mA.mA.mA) && allOk;
	allOk = compare_vec4(vec4(4.0, 8.0, 5.0, -7.0), s2.c.mA.mA.mB) && allOk;
	allOk = compare_float(-8.0, s2.c.mA.mA.mC) && allOk;
	allOk = compare_ivec3(ivec3(-5, 0, 1), s2.d) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	mediump uvec3 mA;
	bvec3 mB;
};
struct sB
{
	bvec3 mA;
};
struct sC
{
	sA mA;
	bvec4 mB;
	sB mC;
};
struct sD
{
	sC mA;
};
struct sE
{
	bvec4 mA;
};
struct sF
{
	highp mat3x4 mA;
	lowp uint mB;
	bool mC;
};
struct sG
{
	mediump uint mA;
	lowp vec3 mB;
};
struct sH
{
	sF mA;
	sG mB;
};
struct sI
{
	lowp uint mA;
	lowp int mB;
};
struct sJ
{
	mediump ivec4 mA;
	mediump int mB;
	highp vec2 mC;
};
struct sK
{
	sI mA;
	sJ mB;
};
struct sL
{
	sH mA;
	sK mB;
};
struct sM
{
	highp ivec3 mA;
};
struct sN
{
	mediump vec4 mA;
	bvec3 mB;
};
struct sO
{
	sM mA;
	sN mB;
};
struct sP
{
	sO mA;
	lowp ivec3 mB;
};
struct S1 {
	sD a;
	sE b;
};
struct S2 {
	sL a;
	lowp vec2 b;
};
struct S3 {
	sP a;
	highp ivec4 b;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

shared S1 s1;
shared S2 s2;
shared S3 s3;

void main (void) {
	s1.a.mA.mA.mA = uvec3(1u, 9u, 8u);
	s1.a.mA.mA.mB = bvec3(false, false, true);
	s1.a.mA.mB = bvec4(false, true, false, true);
	s1.a.mA.mC.mA = bvec3(false, true, false);
	s1.b.mA = bvec4(false, false, true, false);
	s2.a.mA.mA.mA = mat3x4(3.0, -3.0, 7.0, 4.0, -2.0, 9.0, 2.0, -5.0, 1.0, -6.0, 8.0, 5.0);
	s2.a.mA.mA.mB = 2u;
	s2.a.mA.mA.mC = true;
	s2.a.mA.mB.mA = 4u;
	s2.a.mA.mB.mB = vec3(1.0, -9.0, 7.0);
	s2.a.mB.mA.mA = 8u;
	s2.a.mB.mA.mB = 2;
	s2.a.mB.mB.mA = ivec4(9, -3, 3, 1);
	s2.a.mB.mB.mB = 1;
	s2.a.mB.mB.mC = vec2(-9.0, -3.0);
	s2.b = vec2(-9.0, -7.0);
	s3.a.mA.mA.mA = ivec3(-4, -4, -6);
	s3.a.mA.mB.mA = vec4(1.0, 3.0, -4.0, -4.0);
	s3.a.mA.mB.mB = bvec3(true, true, true);
	s3.a.mB = ivec3(-9, -6, 6);
	s3.b = ivec4(5, -5, 2, 4);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_uvec3(uvec3(1u, 9u, 8u), s1.a.mA.mA.mA) && allOk;
	allOk = compare_bvec3(bvec3(false, false, true), s1.a.mA.mA.mB) && allOk;
	allOk = compare_bvec4(bvec4(false, true, false, true), s1.a.mA.mB) && allOk;
	allOk = compare_bvec3(bvec3(false, true, false), s1.a.mA.mC.mA) && allOk;
	allOk = compare_bvec4(bvec4(false, false, true, false), s1.b.mA) && allOk;
	allOk = compare_mat3x4(mat3x4(3.0, -3.0, 7.0, 4.0, -2.0, 9.0, 2.0, -5.0, 1.0, -6.0, 8.0, 5.0), s2.a.mA.mA.mA) && allOk;
	allOk = compare_uint(2u, s2.a.mA.mA.mB) && allOk;
	allOk = compare_bool(true, s2.a.mA.mA.mC) && allOk;
	allOk = compare_uint(4u, s2.a.mA.mB.mA) && allOk;
	allOk = compare_vec3(vec3(1.0, -9.0, 7.0), s2.a.mA.mB.mB) && allOk;
	allOk = compare_uint(8u, s2.a.mB.mA.mA) && allOk;
	allOk = compare_int(2, s2.a.mB.mA.mB) && allOk;
	allOk = compare_ivec4(ivec4(9, -3, 3, 1), s2.a.mB.mB.mA) && allOk;
	allOk = compare_int(1, s2.a.mB.mB.mB) && allOk;
	allOk = compare_vec2(vec2(-9.0, -3.0), s2.a.mB.mB.mC) && allOk;
	allOk = compare_vec2(vec2(-9.0, -7.0), s2.b) && allOk;
	allOk = compare_ivec3(ivec3(-4, -4, -6), s3.a.mA.mA.mA) && allOk;
	allOk = compare_vec4(vec4(1.0, 3.0, -4.0, -4.0), s3.a.mA.mB.mA) && allOk;
	allOk = compare_bvec3(bvec3(true, true, true), s3.a.mA.mB.mB) && allOk;
	allOk = compare_ivec3(ivec3(-9, -6, 6), s3.a.mB) && allOk;
	allOk = compare_ivec4(ivec4(5, -5, 2, 4), s3.b) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	mediump ivec2 mA;
	highp ivec2 mB;
	mediump float mC;
};
struct sB
{
	sA mA;
	highp vec2 mB;
};
struct sC
{
	bvec3 mA;
};
struct sD
{
	mediump uvec3 mA;
	lowp ivec3 mB;
	bool mC;
};
struct sE
{
	sC mA;
	sD mB;
};
struct sF
{
	sB mA;
	sE mB;
	bvec4 mC;
};
struct sG
{
	lowp vec2 mA;
	mediump float mB;
};
struct sH
{
	sG mA;
};
struct sI
{
	sH mA;
};
struct S1 {
	sF a;
	lowp float b;
	sI c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

shared S1 s1;

void main (void) {
	s1.a.mA.mA.mA = ivec2(2, 7);
	s1.a.mA.mA.mB = ivec2(-9, 3);
	s1.a.mA.mA.mC = 0.0;
	s1.a.mA.mB = vec2(-7.0, 7.0);
	s1.a.mB.mA.mA = bvec3(false, true, true);
	s1.a.mB.mB.mA = uvec3(5u, 1u, 1u);
	s1.a.mB.mB.mB = ivec3(0, 9, -1);
	s1.a.mB.mB.mC = false;
	s1.a.mC = bvec4(true, false, false, true);
	s1.b = -6.0;
	s1.c.mA.mA.mA = vec2(0.0, 2.0);
	s1.c.mA.mA.mB = 5.0;

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_ivec2(ivec2(2, 7), s1.a.mA.mA.mA) && allOk;
	allOk = compare_ivec2(ivec2(-9, 3), s1.a.mA.mA.mB) && allOk;
	allOk = compare_float(0.0, s1.a.mA.mA.mC) && allOk;
	allOk = compare_vec2(vec2(-7.0, 7.0), s1.a.mA.mB) && allOk;
	allOk = compare_bvec3(bvec3(false, true, true), s1.a.mB.mA.mA) && allOk;
	allOk = compare_uvec3(uvec3(5u, 1u, 1u), s1.a.mB.mB.mA) && allOk;
	allOk = compare_ivec3(ivec3(0, 9, -1), s1.a.mB.mB.mB) && allOk;
	allOk = compare_bool(false, s1.a.mB.mB.mC) && allOk;
	allOk = compare_bvec4(bvec4(true, false, false, true), s1.a.mC) && allOk;
	allOk = compare_float(-6.0, s1.b) && allOk;
	allOk = compare_vec2(vec2(0.0, 2.0), s1.c.mA.mA.mA) && allOk;
	allOk = compare_float(5.0, s1.c.mA.mA.mB) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	highp uint mA;
	bvec2 mB;
	lowp ivec2 mC;
};
struct sB
{
	highp uint mA;
	lowp ivec3 mB;
	lowp uvec2 mC;
};
struct sC
{
	sA mA;
	mediump int mB;
	sB mC;
};
struct sD
{
	sC mA;
};
struct sE
{
	lowp int mA;
	lowp uvec3 mB;
};
struct sF
{
	lowp mat3x4 mA;
	sE mB;
	bool mC;
};
struct sG
{
	highp uint mA;
	bvec3 mB;
	bvec4 mC;
};
struct sH
{
	sG mA;
};
struct sI
{
	sF mA;
	sH mB;
};
struct sJ
{
	mediump ivec3 mA;
	highp ivec3 mB;
	mediump mat2x3 mC;
};
struct sK
{
	highp mat3x4 mA;
};
struct sL
{
	mediump ivec3 mA;
	mediump uvec2 mB;
	lowp ivec3 mC;
};
struct sM
{
	sJ mA;
	sK mB;
	sL mC;
};
struct sN
{
	lowp ivec4 mA;
	mediump uvec4 mB;
	mediump mat4x3 mC;
};
struct sO
{
	highp ivec3 mA;
	lowp ivec2 mB;
	sN mC;
};
struct sP
{
	sM mA;
	bool mB;
	sO mC;
};
struct S1 {
	sD a;
	mediump ivec2 b;
};
struct S2 {
	highp vec3 a;
	sI b;
	sP c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a.mA.mA.mA = 7u;
	s1.a.mA.mA.mB = bvec2(false, false);
	s1.a.mA.mA.mC = ivec2(-4, 4);
	s1.a.mA.mB = 6;
	s1.a.mA.mC.mA = 3u;
	s1.a.mA.mC.mB = ivec3(-5, -3, -3);
	s1.a.mA.mC.mC = uvec2(9u, 6u);
	s1.b = ivec2(8, 7);
	s2.a = vec3(3.0, 3.0, -4.0);
	s2.b.mA.mA = mat3x4(8.0, -7.0, -9.0, -3.0, 4.0, -3.0, -7.0, -7.0, -1.0, 9.0, -6.0, 8.0);
	s2.b.mA.mB.mA = -4;
	s2.b.mA.mB.mB = uvec3(7u, 4u, 7u);
	s2.b.mA.mC = false;
	s2.b.mB.mA.mA = 3u;
	s2.b.mB.mA.mB = bvec3(false, true, false);
	s2.b.mB.mA.mC = bvec4(false, true, true, true);
	s2.c.mA.mA.mA = ivec3(-3, -6, 1);
	s2.c.mA.mA.mB = ivec3(7, 6, -5);
	s2.c.mA.mA.mC = mat2x3(-9.0, 2.0, 9.0, 7.0, 3.0, 6.0);
	s2.c.mA.mB.mA = mat3x4(2.0, 0.0, -1.0, 1.0, 1.0, 0.0, 9.0, -2.0, -1.0, -4.0, -8.0, 0.0);
	s2.c.mA.mC.mA = ivec3(6, -5, -2);
	s2.c.mA.mC.mB = uvec2(5u, 1u);
	s2.c.mA.mC.mC = ivec3(7, -2, -9);
	s2.c.mB = true;
	s2.c.mC.mA = ivec3(-2, -3, -3);
	s2.c.mC.mB = ivec2(-9, 6);
	s2.c.mC.mC.mA = ivec4(9, -7, 9, -7);
	s2.c.mC.mC.mB = uvec4(7u, 4u, 2u, 3u);
	s2.c.mC.mC.mC = mat4x3(-7.0, -2.0, 6.0, -3.0, 7.0, 7.0, 8.0, -8.0, -9.0, 3.0, -2.0, 0.0);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_uint(7u, s1.a.mA.mA.mA) && allOk;
	allOk = compare_bvec2(bvec2(false, false), s1.a.mA.mA.mB) && allOk;
	allOk = compare_ivec2(ivec2(-4, 4), s1.a.mA.mA.mC) && allOk;
	allOk = compare_int(6, s1.a.mA.mB) && allOk;
	allOk = compare_uint(3u, s1.a.mA.mC.mA) && allOk;
	allOk = compare_ivec3(ivec3(-5, -3, -3), s1.a.mA.mC.mB) && allOk;
	allOk = compare_uvec2(uvec2(9u, 6u), s1.a.mA.mC.mC) && allOk;
	allOk = compare_ivec2(ivec2(8, 7), s1.b) && allOk;
	allOk = compare_vec3(vec3(3.0, 3.0, -4.0), s2.a) && allOk;
	allOk = compare_mat3x4(mat3x4(8.0, -7.0, -9.0, -3.0, 4.0, -3.0, -7.0, -7.0, -1.0, 9.0, -6.0, 8.0), s2.b.mA.mA) && allOk;
	allOk = compare_int(-4, s2.b.mA.mB.mA) && allOk;
	allOk = compare_uvec3(uvec3(7u, 4u, 7u), s2.b.mA.mB.mB) && allOk;
	allOk = compare_bool(false, s2.b.mA.mC) && allOk;
	allOk = compare_uint(3u, s2.b.mB.mA.mA) && allOk;
	allOk = compare_bvec3(bvec3(false, true, false), s2.b.mB.mA.mB) && allOk;
	allOk = compare_bvec4(bvec4(false, true, true, true), s2.b.mB.mA.mC) && allOk;
	allOk = compare_ivec3(ivec3(-3, -6, 1), s2.c.mA.mA.mA) && allOk;
	allOk = compare_ivec3(ivec3(7, 6, -5), s2.c.mA.mA.mB) && allOk;
	allOk = compare_mat2x3(mat2x3(-9.0, 2.0, 9.0, 7.0, 3.0, 6.0), s2.c.mA.mA.mC) && allOk;
	allOk = compare_mat3x4(mat3x4(2.0, 0.0, -1.0, 1.0, 1.0, 0.0, 9.0, -2.0, -1.0, -4.0, -8.0, 0.0), s2.c.mA.mB.mA) && allOk;
	allOk = compare_ivec3(ivec3(6, -5, -2), s2.c.mA.mC.mA) && allOk;
	allOk = compare_uvec2(uvec2(5u, 1u), s2.c.mA.mC.mB) && allOk;
	allOk = compare_ivec3(ivec3(7, -2, -9), s2.c.mA.mC.mC) && allOk;
	allOk = compare_bool(true, s2.c.mB) && allOk;
	allOk = compare_ivec3(ivec3(-2, -3, -3), s2.c.mC.mA) && allOk;
	allOk = compare_ivec2(ivec2(-9, 6), s2.c.mC.mB) && allOk;
	allOk = compare_ivec4(ivec4(9, -7, 9, -7), s2.c.mC.mC.mA) && allOk;
	allOk = compare_uvec4(uvec4(7u, 4u, 2u, 3u), s2.c.mC.mC.mB) && allOk;
	allOk = compare_mat4x3(mat4x3(-7.0, -2.0, 6.0, -3.0, 7.0, 7.0, 8.0, -8.0, -9.0, 3.0, -2.0, 0.0), s2.c.mC.mC.mC) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	highp mat4x2 mA;
};
struct sB
{
	sA mA;
};
struct sC
{
	sB mA;
	bvec4 mB;
};
struct sD
{
	mediump float mA;
};
struct sE
{
	sD mA;
	lowp uint mB;
};
struct sF
{
	lowp vec4 mA;
	mediump mat4x2 mB;
};
struct sG
{
	highp ivec4 mA;
	highp vec4 mB;
};
struct sH
{
	sF mA;
	sG mB;
	lowp mat3x2 mC;
};
struct sI
{
	lowp float mA;
	lowp mat4x2 mB;
	highp ivec2 mC;
};
struct sJ
{
	sI mA;
};
struct sK
{
	sE mA;
	sH mB;
	sJ mC;
};
struct sL
{
	lowp mat4x2 mA;
};
struct sM
{
	lowp mat3x2 mA;
};
struct S1 {
	mediump ivec2 a;
	sC b;
	lowp ivec3 c;
};
struct S2 {
	sK a;
	sL b;
	mediump ivec4 c;
	sM d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a = ivec2(-4, 6);
	s1.b.mA.mA.mA = mat4x2(6.0, -7.0, -9.0, 5.0, -4.0, -9.0, 8.0, 6.0);
	s1.b.mB = bvec4(true, true, false, true);
	s1.c = ivec3(-3, 2, -9);
	s2.a.mA.mA.mA = -7.0;
	s2.a.mA.mB = 1u;
	s2.a.mB.mA.mA = vec4(-7.0, 3.0, 5.0, 2.0);
	s2.a.mB.mA.mB = mat4x2(-9.0, 0.0, -5.0, 0.0, 1.0, -8.0, 0.0, 3.0);
	s2.a.mB.mB.mA = ivec4(-5, 5, -7, 1);
	s2.a.mB.mB.mB = vec4(-8.0, 2.0, 0.0, 1.0);
	s2.a.mB.mC = mat3x2(8.0, -3.0, 7.0, -6.0, -9.0, -5.0);
	s2.a.mC.mA.mA = 6.0;
	s2.a.mC.mA.mB = mat4x2(-8.0, -8.0, 3.0, 3.0, 8.0, 4.0, -1.0, 3.0);
	s2.a.mC.mA.mC = ivec2(-6, 8);
	s2.b.mA = mat4x2(-6.0, 2.0, -4.0, 9.0, 9.0, 5.0, -2.0, 4.0);
	s2.c = ivec4(0, -7, -8, 2);
	s2.d.mA = mat3x2(4.0, 7.0, -9.0, -3.0, 0.0, 4.0);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_ivec2(ivec2(-4, 6), s1.a) && allOk;
	allOk = compare_mat4x2(mat4x2(6.0, -7.0, -9.0, 5.0, -4.0, -9.0, 8.0, 6.0), s1.b.mA.mA.mA) && allOk;
	allOk = compare_bvec4(bvec4(true, true, false, true), s1.b.mB) && allOk;
	allOk = compare_ivec3(ivec3(-3, 2, -9), s1.c) && allOk;
	allOk = compare_float(-7.0, s2.a.mA.mA.mA) && allOk;
	allOk = compare_uint(1u, s2.a.mA.mB) && allOk;
	allOk = compare_vec4(vec4(-7.0, 3.0, 5.0, 2.0), s2.a.mB.mA.mA) && allOk;
	allOk = compare_mat4x2(mat4x2(-9.0, 0.0, -5.0, 0.0, 1.0, -8.0, 0.0, 3.0), s2.a.mB.mA.mB) && allOk;
	allOk = compare_ivec4(ivec4(-5, 5, -7, 1), s2.a.mB.mB.mA) && allOk;
	allOk = compare_vec4(vec4(-8.0, 2.0, 0.0, 1.0), s2.a.mB.mB.mB) && allOk;
	allOk = compare_mat3x2(mat3x2(8.0, -3.0, 7.0, -6.0, -9.0, -5.0), s2.a.mB.mC) && allOk;
	allOk = compare_float(6.0, s2.a.mC.mA.mA) && allOk;
	allOk = compare_mat4x2(mat4x2(-8.0, -8.0, 3.0, 3.0, 8.0, 4.0, -1.0, 3.0), s2.a.mC.mA.mB) && allOk;
	allOk = compare_ivec2(ivec2(-6, 8), s2.a.mC.mA.mC) && allOk;
	allOk = compare_mat4x2(mat4x2(-6.0, 2.0, -4.0, 9.0, 9.0, 5.0, -2.0, 4.0), s2.b.mA) && allOk;
	allOk = compare_ivec4(ivec4(0, -7, -8, 2), s2.c) && allOk;
	allOk = compare_mat3x2(mat3x2(4.0, 7.0, -9.0, -3.0, 0.0, 4.0), s2.d.mA) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	lowp uint mA;
};
struct sB
{
	lowp uvec3 mA;
	lowp ivec2 mB;
	lowp vec3 mC;
};
struct sC
{
	sB mA;
};
struct sD
{
	mediump int mA;
};
struct sE
{
	lowp uvec2 mA;
	lowp ivec3 mB;
	mediump ivec3 mC;
};
struct sF
{
	sD mA;
	sE mB;
};
struct sG
{
	sC mA;
	sF mB;
};
struct S1 {
	sA a;
	sG b;
};
struct S2 {
	bvec4 a;
	bvec2 b;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a.mA = 5u;
	s1.b.mA.mA.mA = uvec3(7u, 3u, 1u);
	s1.b.mA.mA.mB = ivec2(9, -5);
	s1.b.mA.mA.mC = vec3(7.0, 7.0, 0.0);
	s1.b.mB.mA.mA = 5;
	s1.b.mB.mB.mA = uvec2(0u, 9u);
	s1.b.mB.mB.mB = ivec3(-2, -1, 5);
	s1.b.mB.mB.mC = ivec3(2, -4, 7);
	s2.a = bvec4(false, false, false, false);
	s2.b = bvec2(false, false);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_uint(5u, s1.a.mA) && allOk;
	allOk = compare_uvec3(uvec3(7u, 3u, 1u), s1.b.mA.mA.mA) && allOk;
	allOk = compare_ivec2(ivec2(9, -5), s1.b.mA.mA.mB) && allOk;
	allOk = compare_vec3(vec3(7.0, 7.0, 0.0), s1.b.mA.mA.mC) && allOk;
	allOk = compare_int(5, s1.b.mB.mA.mA) && allOk;
	allOk = compare_uvec2(uvec2(0u, 9u), s1.b.mB.mB.mA) && allOk;
	allOk = compare_ivec3(ivec3(-2, -1, 5), s1.b.mB.mB.mB) && allOk;
	allOk = compare_ivec3(ivec3(2, -4, 7), s1.b.mB.mB.mC) && allOk;
	allOk = compare_bvec4(bvec4(false, false, false, false), s2.a) && allOk;
	allOk = compare_bvec2(bvec2(false, false), s2.b) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	highp uvec2 mA;
	mediump int mB;
	bvec2 mC;
};
struct sB
{
	mediump ivec2 mA;
	mediump float mB;
};
struct sC
{
	lowp mat3x2 mA;
};
struct sD
{
	sA mA;
	sB mB;
	sC mC;
};
struct sE
{
	bvec4 mA;
	highp uvec3 mB;
	sD mC;
};
struct sF
{
	mediump mat4x2 mA;
};
struct sG
{
	sF mA;
};
struct sH
{
	highp mat4x2 mA;
	bvec2 mB;
	lowp uvec2 mC;
};
struct sI
{
	bvec4 mA;
	highp uvec3 mB;
};
struct sJ
{
	sH mA;
	sI mB;
	mediump mat4x2 mC;
};
struct sK
{
	highp uvec3 mA;
	mediump int mB;
};
struct sL
{
	mediump uvec4 mA;
	bvec2 mB;
	highp vec4 mC;
};
struct sM
{
	bvec2 mA;
	highp ivec4 mB;
};
struct sN
{
	sK mA;
	sL mB;
	sM mC;
};
struct sO
{
	sJ mA;
	sN mB;
};
struct sP
{
	highp uvec2 mA;
};
struct sQ
{
	bvec2 mA;
};
struct sR
{
	bvec2 mA;
	sQ mB;
};
struct S1 {
	highp vec2 a;
	sE b;
	sG c;
};
struct S2 {
	sO a;
	mediump ivec2 b;
	sP c;
};
struct S3 {
	sR a;
	highp mat4x2 b;
	mediump ivec4 c;
	highp mat2 d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

shared S1 s1;
shared S2 s2;
shared S3 s3;

void main (void) {
	s1.a = vec2(1.0, -6.0);
	s1.b.mA = bvec4(false, false, true, true);
	s1.b.mB = uvec3(9u, 2u, 0u);
	s1.b.mC.mA.mA = uvec2(4u, 5u);
	s1.b.mC.mA.mB = -7;
	s1.b.mC.mA.mC = bvec2(false, false);
	s1.b.mC.mB.mA = ivec2(1, 9);
	s1.b.mC.mB.mB = 5.0;
	s1.b.mC.mC.mA = mat3x2(-4.0, 1.0, -4.0, -4.0, -3.0, 1.0);
	s1.c.mA.mA = mat4x2(5.0, 6.0, 9.0, 0.0, 1.0, -3.0, 1.0, 6.0);
	s2.a.mA.mA.mA = mat4x2(6.0, 6.0, -8.0, 6.0, 6.0, 5.0, 1.0, 4.0);
	s2.a.mA.mA.mB = bvec2(false, true);
	s2.a.mA.mA.mC = uvec2(2u, 2u);
	s2.a.mA.mB.mA = bvec4(false, false, false, true);
	s2.a.mA.mB.mB = uvec3(8u, 2u, 5u);
	s2.a.mA.mC = mat4x2(3.0, 5.0, 2.0, 3.0, 1.0, -6.0, -5.0, 9.0);
	s2.a.mB.mA.mA = uvec3(4u, 3u, 5u);
	s2.a.mB.mA.mB = 6;
	s2.a.mB.mB.mA = uvec4(6u, 3u, 7u, 6u);
	s2.a.mB.mB.mB = bvec2(false, false);
	s2.a.mB.mB.mC = vec4(-1.0, -8.0, 4.0, -7.0);
	s2.a.mB.mC.mA = bvec2(true, false);
	s2.a.mB.mC.mB = ivec4(-2, 0, -1, -3);
	s2.b = ivec2(-7, 2);
	s2.c.mA = uvec2(7u, 9u);
	s3.a.mA = bvec2(true, false);
	s3.a.mB.mA = bvec2(true, false);
	s3.b = mat4x2(-5.0, 9.0, -2.0, 9.0, 9.0, 2.0, 1.0, -5.0);
	s3.c = ivec4(8, -5, 3, 9);
	s3.d = mat2(6.0, -8.0, 6.0, 4.0);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_vec2(vec2(1.0, -6.0), s1.a) && allOk;
	allOk = compare_bvec4(bvec4(false, false, true, true), s1.b.mA) && allOk;
	allOk = compare_uvec3(uvec3(9u, 2u, 0u), s1.b.mB) && allOk;
	allOk = compare_uvec2(uvec2(4u, 5u), s1.b.mC.mA.mA) && allOk;
	allOk = compare_int(-7, s1.b.mC.mA.mB) && allOk;
	allOk = compare_bvec2(bvec2(false, false), s1.b.mC.mA.mC) && allOk;
	allOk = compare_ivec2(ivec2(1, 9), s1.b.mC.mB.mA) && allOk;
	allOk = compare_float(5.0, s1.b.mC.mB.mB) && allOk;
	allOk = compare_mat3x2(mat3x2(-4.0, 1.0, -4.0, -4.0, -3.0, 1.0), s1.b.mC.mC.mA) && allOk;
	allOk = compare_mat4x2(mat4x2(5.0, 6.0, 9.0, 0.0, 1.0, -3.0, 1.0, 6.0), s1.c.mA.mA) && allOk;
	allOk = compare_mat4x2(mat4x2(6.0, 6.0, -8.0, 6.0, 6.0, 5.0, 1.0, 4.0), s2.a.mA.mA.mA) && allOk;
	allOk = compare_bvec2(bvec2(false, true), s2.a.mA.mA.mB) && allOk;
	allOk = compare_uvec2(uvec2(2u, 2u), s2.a.mA.mA.mC) && allOk;
	allOk = compare_bvec4(bvec4(false, false, false, true), s2.a.mA.mB.mA) && allOk;
	allOk = compare_uvec3(uvec3(8u, 2u, 5u), s2.a.mA.mB.mB) && allOk;
	allOk = compare_mat4x2(mat4x2(3.0, 5.0, 2.0, 3.0, 1.0, -6.0, -5.0, 9.0), s2.a.mA.mC) && allOk;
	allOk = compare_uvec3(uvec3(4u, 3u, 5u), s2.a.mB.mA.mA) && allOk;
	allOk = compare_int(6, s2.a.mB.mA.mB) && allOk;
	allOk = compare_uvec4(uvec4(6u, 3u, 7u, 6u), s2.a.mB.mB.mA) && allOk;
	allOk = compare_bvec2(bvec2(false, false), s2.a.mB.mB.mB) && allOk;
	allOk = compare_vec4(vec4(-1.0, -8.0, 4.0, -7.0), s2.a.mB.mB.mC) && allOk;
	allOk = compare_bvec2(bvec2(true, false), s2.a.mB.mC.mA) && allOk;
	allOk = compare_ivec4(ivec4(-2, 0, -1, -3), s2.a.mB.mC.mB) && allOk;
	allOk = compare_ivec2(ivec2(-7, 2), s2.b) && allOk;
	allOk = compare_uvec2(uvec2(7u, 9u), s2.c.mA) && allOk;
	allOk = compare_bvec2(bvec2(true, false), s3.a.mA) && allOk;
	allOk = compare_bvec2(bvec2(true, false), s3.a.mB.mA) && allOk;
	allOk = compare_mat4x2(mat4x2(-5.0, 9.0, -2.0, 9.0, 9.0, 2.0, 1.0, -5.0), s3.b) && allOk;
	allOk = compare_ivec4(ivec4(8, -5, 3, 9), s3.c) && allOk;
	allOk = compare_mat2(mat2(6.0, -8.0, 6.0, 4.0), s3.d) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	mediump vec3 mA;
	highp uint mB;
	bvec4 mC;
};
struct sB
{
	sA mA;
};
struct sC
{
	sB mA;
};
struct sD
{
	mediump mat2x3 mA;
	mediump uvec2 mB;
};
struct sE
{
	sD mA;
};
struct sF
{
	lowp ivec4 mA;
	lowp ivec3 mB;
	lowp float mC;
};
struct sG
{
	sF mA;
	mediump ivec3 mB;
};
struct sH
{
	bool mA;
	lowp mat4x3 mB;
};
struct sI
{
	sH mA;
	highp ivec3 mB;
};
struct sJ
{
	sE mA;
	sG mB;
	sI mC;
};
struct sK
{
	bvec4 mA;
};
struct sL
{
	highp int mA;
	mediump uvec3 mB;
	mediump mat2x3 mC;
};
struct sM
{
	sL mA;
};
struct sN
{
	sM mA;
};
struct sO
{
	lowp mat3x2 mA;
};
struct sP
{
	bool mA;
};
struct sQ
{
	sO mA;
	lowp ivec4 mB;
	sP mC;
};
struct sR
{
	mediump vec2 mA;
	sQ mB;
};
struct sS
{
	highp ivec2 mA;
	bool mB;
	mediump mat3x4 mC;
};
struct sT
{
	bvec4 mA;
};
struct sU
{
	sS mA;
	sT mB;
};
struct sV
{
	highp vec2 mA;
};
struct sW
{
	mediump uint mA;
	sV mB;
};
struct sX
{
	sU mA;
	sW mB;
};
struct S1 {
	sC a;
	sJ b;
	sK c;
};
struct S2 {
	sN a;
	sR b;
	sX c;
	lowp mat4x3 d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a.mA.mA.mA = vec3(1.0, -3.0, 9.0);
	s1.a.mA.mA.mB = 7u;
	s1.a.mA.mA.mC = bvec4(false, false, true, true);
	s1.b.mA.mA.mA = mat2x3(2.0, -6.0, 5.0, -7.0, 2.0, 8.0);
	s1.b.mA.mA.mB = uvec2(1u, 2u);
	s1.b.mB.mA.mA = ivec4(-8, 7, -1, 2);
	s1.b.mB.mA.mB = ivec3(2, 6, 1);
	s1.b.mB.mA.mC = 1.0;
	s1.b.mB.mB = ivec3(1, 6, -8);
	s1.b.mC.mA.mA = true;
	s1.b.mC.mA.mB = mat4x3(0.0, -1.0, -1.0, 5.0, 4.0, 0.0, -1.0, -2.0, -9.0, 1.0, 0.0, 8.0);
	s1.b.mC.mB = ivec3(0, 5, -7);
	s1.c.mA = bvec4(false, true, false, false);
	s2.a.mA.mA.mA = 6;
	s2.a.mA.mA.mB = uvec3(3u, 6u, 3u);
	s2.a.mA.mA.mC = mat2x3(-4.0, 0.0, 4.0, -4.0, 0.0, 0.0);
	s2.b.mA = vec2(8.0, -5.0);
	s2.b.mB.mA.mA = mat3x2(-1.0, -9.0, -9.0, -1.0, -4.0, 5.0);
	s2.b.mB.mB = ivec4(1, -9, 8, 9);
	s2.b.mB.mC.mA = true;
	s2.c.mA.mA.mA = ivec2(-3, -4);
	s2.c.mA.mA.mB = false;
	s2.c.mA.mA.mC = mat3x4(9.0, 1.0, 5.0, 9.0, 5.0, -7.0, -3.0, -9.0, 5.0, 4.0, 2.0, 3.0);
	s2.c.mA.mB.mA = bvec4(false, true, true, true);
	s2.c.mB.mA = 5u;
	s2.c.mB.mB.mA = vec2(3.0, 2.0);
	s2.d = mat4x3(2.0, 3.0, -8.0, -6.0, 3.0, -4.0, -6.0, 3.0, -5.0, 8.0, 3.0, 5.0);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_vec3(vec3(1.0, -3.0, 9.0), s1.a.mA.mA.mA) && allOk;
	allOk = compare_uint(7u, s1.a.mA.mA.mB) && allOk;
	allOk = compare_bvec4(bvec4(false, false, true, true), s1.a.mA.mA.mC) && allOk;
	allOk = compare_mat2x3(mat2x3(2.0, -6.0, 5.0, -7.0, 2.0, 8.0), s1.b.mA.mA.mA) && allOk;
	allOk = compare_uvec2(uvec2(1u, 2u), s1.b.mA.mA.mB) && allOk;
	allOk = compare_ivec4(ivec4(-8, 7, -1, 2), s1.b.mB.mA.mA) && allOk;
	allOk = compare_ivec3(ivec3(2, 6, 1), s1.b.mB.mA.mB) && allOk;
	allOk = compare_float(1.0, s1.b.mB.mA.mC) && allOk;
	allOk = compare_ivec3(ivec3(1, 6, -8), s1.b.mB.mB) && allOk;
	allOk = compare_bool(true, s1.b.mC.mA.mA) && allOk;
	allOk = compare_mat4x3(mat4x3(0.0, -1.0, -1.0, 5.0, 4.0, 0.0, -1.0, -2.0, -9.0, 1.0, 0.0, 8.0), s1.b.mC.mA.mB) && allOk;
	allOk = compare_ivec3(ivec3(0, 5, -7), s1.b.mC.mB) && allOk;
	allOk = compare_bvec4(bvec4(false, true, false, false), s1.c.mA) && allOk;
	allOk = compare_int(6, s2.a.mA.mA.mA) && allOk;
	allOk = compare_uvec3(uvec3(3u, 6u, 3u), s2.a.mA.mA.mB) && allOk;
	allOk = compare_mat2x3(mat2x3(-4.0, 0.0, 4.0, -4.0, 0.0, 0.0), s2.a.mA.mA.mC) && allOk;
	allOk = compare_vec2(vec2(8.0, -5.0), s2.b.mA) && allOk;
	allOk = compare_mat3x2(mat3x2(-1.0, -9.0, -9.0, -1.0, -4.0, 5.0), s2.b.mB.mA.mA) && allOk;
	allOk = compare_ivec4(ivec4(1, -9, 8, 9), s2.b.mB.mB) && allOk;
	allOk = compare_bool(true, s2.b.mB.mC.mA) && allOk;
	allOk = compare_ivec2(ivec2(-3, -4), s2.c.mA.mA.mA) && allOk;
	allOk = compare_bool(false, s2.c.mA.mA.mB) && allOk;
	allOk = compare_mat3x4(mat3x4(9.0, 1.0, 5.0, 9.0, 5.0, -7.0, -3.0, -9.0, 5.0, 4.0, 2.0, 3.0), s2.c.mA.mA.mC) && allOk;
	allOk = compare_bvec4(bvec4(false, true, true, true), s2.c.mA.mB.mA) && allOk;
	allOk = compare_uint(5u, s2.c.mB.mA) && allOk;
	allOk = compare_vec2(vec2(3.0, 2.0), s2.c.mB.mB.mA) && allOk;
	allOk = compare_mat4x3(mat4x3(2.0, 3.0, -8.0, -6.0, 3.0, -4.0, -6.0, 3.0, -5.0, 8.0, 3.0, 5.0), s2.d) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	mediump mat2x3 mA;
};
struct sB
{
	mediump mat2 mA;
	mediump mat3x2 mB;
	highp uvec3 mC;
};
struct sC
{
	sA mA;
	sB mB;
};
struct sD
{
	sC mA;
};
struct sE
{
	lowp mat3x2 mA;
	lowp mat4x3 mB;
};
struct sF
{
	sE mA;
};
struct sG
{
	sF mA;
};
struct sH
{
	bvec3 mA[2];
};
struct S1 {
	sD a;
	sG b;
	sH c[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

shared S1 s1;

void main (void) {
	s1.a.mA.mA.mA = mat2x3(6.0, 8.0, 8.0, 0.0, -4.0, -5.0);
	s1.a.mA.mB.mA = mat2(9.0, -4.0, -6.0, -1.0);
	s1.a.mA.mB.mB = mat3x2(-1.0, -2.0, 1.0, 6.0, 5.0, 7.0);
	s1.a.mA.mB.mC = uvec3(3u, 1u, 5u);
	s1.b.mA.mA.mA = mat3x2(8.0, 3.0, 0.0, 2.0, 1.0, 8.0);
	s1.b.mA.mA.mB = mat4x3(0.0, 9.0, -1.0, -1.0, -7.0, 7.0, -4.0, -3.0, 1.0, -4.0, -9.0, 1.0);
	s1.c[0].mA[0] = bvec3(true, false, false);
	s1.c[0].mA[1] = bvec3(true, false, false);
	s1.c[1].mA[0] = bvec3(false, false, false);
	s1.c[1].mA[1] = bvec3(false, false, false);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_mat2x3(mat2x3(6.0, 8.0, 8.0, 0.0, -4.0, -5.0), s1.a.mA.mA.mA) && allOk;
	allOk = compare_mat2(mat2(9.0, -4.0, -6.0, -1.0), s1.a.mA.mB.mA) && allOk;
	allOk = compare_mat3x2(mat3x2(-1.0, -2.0, 1.0, 6.0, 5.0, 7.0), s1.a.mA.mB.mB) && allOk;
	allOk = compare_uvec3(uvec3(3u, 1u, 5u), s1.a.mA.mB.mC) && allOk;
	allOk = compare_mat3x2(mat3x2(8.0, 3.0, 0.0, 2.0, 1.0, 8.0), s1.b.mA.mA.mA) && allOk;
	allOk = compare_mat4x3(mat4x3(0.0, 9.0, -1.0, -1.0, -7.0, 7.0, -4.0, -3.0, 1.0, -4.0, -9.0, 1.0), s1.b.mA.mA.mB) && allOk;
	allOk = compare_bvec3(bvec3(true, false, false), s1.c[0].mA[0]) && allOk;
	allOk = compare_bvec3(bvec3(true, false, false), s1.c[0].mA[1]) && allOk;
	allOk = compare_bvec3(bvec3(false, false, false), s1.c[1].mA[0]) && allOk;
	allOk = compare_bvec3(bvec3(false, false, false), s1.c[1].mA[1]) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	bvec3 mA;
};
struct sB
{
	highp ivec4 mA;
};
struct sC
{
	highp vec2 mA;
};
struct sD
{
	sA mA;
	sB mB;
	sC mC;
};
struct sE
{
	highp ivec3 mA;
	lowp int mB;
	highp vec4 mC;
};
struct sF
{
	highp ivec4 mA;
	bvec2 mB;
	lowp ivec4 mC;
};
struct sG
{
	bool mA;
	highp uvec3 mB;
};
struct sH
{
	sE mA;
	sF mB;
	sG mC;
};
struct sI
{
	sD mA;
	sH mB;
};
struct sJ
{
	lowp float mA;
};
struct sK
{
	sJ mA;
};
struct sL
{
	sK mA;
};
struct sM
{
	highp ivec4 mA;
};
struct sN
{
	mediump ivec3 mA[2];
	sM mB[1];
};
struct sO
{
	mediump int mA;
	bvec2 mB;
	mediump uint mC;
};
struct sP
{
	bvec2 mA;
};
struct sQ
{
	mediump mat4 mA[2];
	sO mB;
	sP mC;
};
struct sR
{
	mediump uvec4 mA;
	highp mat2x3 mB;
};
struct sS
{
	bvec4 mA;
	bool mB;
	mediump int mC;
};
struct sT
{
	sR mA;
	sS mB;
};
struct sU
{
	sQ mA;
	lowp ivec3 mB[1];
	sT mC;
};
struct sV
{
	mediump ivec2 mA;
};
struct sW
{
	highp uvec4 mA;
};
struct sX
{
	mediump ivec2 mA;
};
struct sY
{
	sV mA;
	sW mB;
	sX mC;
};
struct sZ
{
	sY mA;
};
struct sAA
{
	lowp ivec2 mA;
	highp uvec4 mB;
};
struct sAB
{
	sAA mA[3];
};
struct S1 {
	sI a;
	sL b;
};
struct S2 {
	sN a;
	sU b;
	sZ c;
	sAB d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a.mA.mA.mA = bvec3(true, false, false);
	s1.a.mA.mB.mA = ivec4(-3, -1, -9, 5);
	s1.a.mA.mC.mA = vec2(-7.0, -9.0);
	s1.a.mB.mA.mA = ivec3(8, -4, -8);
	s1.a.mB.mA.mB = 8;
	s1.a.mB.mA.mC = vec4(-8.0, -6.0, -2.0, 9.0);
	s1.a.mB.mB.mA = ivec4(-2, -2, 1, 1);
	s1.a.mB.mB.mB = bvec2(true, false);
	s1.a.mB.mB.mC = ivec4(9, -5, 8, 4);
	s1.a.mB.mC.mA = true;
	s1.a.mB.mC.mB = uvec3(8u, 9u, 3u);
	s1.b.mA.mA.mA = 2.0;
	s2.a.mA[0] = ivec3(-5, 9, 3);
	s2.a.mA[1] = ivec3(-5, -3, 0);
	s2.a.mB[0].mA = ivec4(-2, -4, 4, -6);
	s2.b.mA.mA[0] = mat4(-3.0, 5.0, -2.0, 4.0, -4.0, 8.0, -5.0, -4.0, -6.0, -3.0, 0.0, -9.0, 9.0, 8.0, -5.0, 8.0);
	s2.b.mA.mA[1] = mat4(-4.0, -9.0, 6.0, 6.0, 8.0, -1.0, 2.0, 7.0, 8.0, 6.0, 7.0, -7.0, 0.0, -3.0, 7.0, 5.0);
	s2.b.mA.mB.mA = -5;
	s2.b.mA.mB.mB = bvec2(true, false);
	s2.b.mA.mB.mC = 5u;
	s2.b.mA.mC.mA = bvec2(false, false);
	s2.b.mB[0] = ivec3(6, 2, -7);
	s2.b.mC.mA.mA = uvec4(9u, 9u, 0u, 1u);
	s2.b.mC.mA.mB = mat2x3(-4.0, -7.0, -3.0, 0.0, -3.0, 2.0);
	s2.b.mC.mB.mA = bvec4(true, false, true, true);
	s2.b.mC.mB.mB = true;
	s2.b.mC.mB.mC = 9;
	s2.c.mA.mA.mA = ivec2(-7, 4);
	s2.c.mA.mB.mA = uvec4(3u, 0u, 7u, 7u);
	s2.c.mA.mC.mA = ivec2(9, -3);
	s2.d.mA[0].mA = ivec2(-4, -3);
	s2.d.mA[0].mB = uvec4(7u, 5u, 3u, 6u);
	s2.d.mA[1].mA = ivec2(7, -6);
	s2.d.mA[1].mB = uvec4(4u, 8u, 7u, 5u);
	s2.d.mA[2].mA = ivec2(-9, -4);
	s2.d.mA[2].mB = uvec4(1u, 8u, 7u, 1u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_bvec3(bvec3(true, false, false), s1.a.mA.mA.mA) && allOk;
	allOk = compare_ivec4(ivec4(-3, -1, -9, 5), s1.a.mA.mB.mA) && allOk;
	allOk = compare_vec2(vec2(-7.0, -9.0), s1.a.mA.mC.mA) && allOk;
	allOk = compare_ivec3(ivec3(8, -4, -8), s1.a.mB.mA.mA) && allOk;
	allOk = compare_int(8, s1.a.mB.mA.mB) && allOk;
	allOk = compare_vec4(vec4(-8.0, -6.0, -2.0, 9.0), s1.a.mB.mA.mC) && allOk;
	allOk = compare_ivec4(ivec4(-2, -2, 1, 1), s1.a.mB.mB.mA) && allOk;
	allOk = compare_bvec2(bvec2(true, false), s1.a.mB.mB.mB) && allOk;
	allOk = compare_ivec4(ivec4(9, -5, 8, 4), s1.a.mB.mB.mC) && allOk;
	allOk = compare_bool(true, s1.a.mB.mC.mA) && allOk;
	allOk = compare_uvec3(uvec3(8u, 9u, 3u), s1.a.mB.mC.mB) && allOk;
	allOk = compare_float(2.0, s1.b.mA.mA.mA) && allOk;
	allOk = compare_ivec3(ivec3(-5, 9, 3), s2.a.mA[0]) && allOk;
	allOk = compare_ivec3(ivec3(-5, -3, 0), s2.a.mA[1]) && allOk;
	allOk = compare_ivec4(ivec4(-2, -4, 4, -6), s2.a.mB[0].mA) && allOk;
	allOk = compare_mat4(mat4(-3.0, 5.0, -2.0, 4.0, -4.0, 8.0, -5.0, -4.0, -6.0, -3.0, 0.0, -9.0, 9.0, 8.0, -5.0, 8.0), s2.b.mA.mA[0]) && allOk;
	allOk = compare_mat4(mat4(-4.0, -9.0, 6.0, 6.0, 8.0, -1.0, 2.0, 7.0, 8.0, 6.0, 7.0, -7.0, 0.0, -3.0, 7.0, 5.0), s2.b.mA.mA[1]) && allOk;
	allOk = compare_int(-5, s2.b.mA.mB.mA) && allOk;
	allOk = compare_bvec2(bvec2(true, false), s2.b.mA.mB.mB) && allOk;
	allOk = compare_uint(5u, s2.b.mA.mB.mC) && allOk;
	allOk = compare_bvec2(bvec2(false, false), s2.b.mA.mC.mA) && allOk;
	allOk = compare_ivec3(ivec3(6, 2, -7), s2.b.mB[0]) && allOk;
	allOk = compare_uvec4(uvec4(9u, 9u, 0u, 1u), s2.b.mC.mA.mA) && allOk;
	allOk = compare_mat2x3(mat2x3(-4.0, -7.0, -3.0, 0.0, -3.0, 2.0), s2.b.mC.mA.mB) && allOk;
	allOk = compare_bvec4(bvec4(true, false, true, true), s2.b.mC.mB.mA) && allOk;
	allOk = compare_bool(true, s2.b.mC.mB.mB) && allOk;
	allOk = compare_int(9, s2.b.mC.mB.mC) && allOk;
	allOk = compare_ivec2(ivec2(-7, 4), s2.c.mA.mA.mA) && allOk;
	allOk = compare_uvec4(uvec4(3u, 0u, 7u, 7u), s2.c.mA.mB.mA) && allOk;
	allOk = compare_ivec2(ivec2(9, -3), s2.c.mA.mC.mA) && allOk;
	allOk = compare_ivec2(ivec2(-4, -3), s2.d.mA[0].mA) && allOk;
	allOk = compare_uvec4(uvec4(7u, 5u, 3u, 6u), s2.d.mA[0].mB) && allOk;
	allOk = compare_ivec2(ivec2(7, -6), s2.d.mA[1].mA) && allOk;
	allOk = compare_uvec4(uvec4(4u, 8u, 7u, 5u), s2.d.mA[1].mB) && allOk;
	allOk = compare_ivec2(ivec2(-9, -4), s2.d.mA[2].mA) && allOk;
	allOk = compare_uvec4(uvec4(1u, 8u, 7u, 1u), s2.d.mA[2].mB) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	bvec2 mA;
	lowp mat2 mB;
};
struct sB
{
	highp ivec3 mA[3];
	sA mB;
	bool mC[1];
};
struct sC
{
	mediump mat2x3 mA;
	lowp uint mB;
	mediump ivec4 mC;
};
struct sD
{
	sC mA;
	highp uvec2 mB[1];
	bool mC[3];
};
struct sE
{
	sB mA;
	highp mat4x3 mB[2][3];
	sD mC;
};
struct sF
{
	lowp uvec3 mA;
};
struct sG
{
	highp float mA;
	highp uint mB;
	lowp int mC;
};
struct sH
{
	sG mA;
};
struct sI
{
	sF mA;
	sH mB;
	mediump int mC[1][3];
};
struct sJ
{
	lowp mat3x2 mA;
	mediump mat2 mB;
	lowp ivec4 mC;
};
struct sK
{
	sJ mA[3];
};
struct S1 {
	sE a;
	sI b;
	sK c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

shared S1 s1;

void main (void) {
	s1.a.mA.mA[0] = ivec3(0, 2, -8);
	s1.a.mA.mA[1] = ivec3(6, 7, 5);
	s1.a.mA.mA[2] = ivec3(-6, 1, 9);
	s1.a.mA.mB.mA = bvec2(true, true);
	s1.a.mA.mB.mB = mat2(4.0, 4.0, 9.0, -9.0);
	s1.a.mA.mC[0] = true;
	s1.a.mB[0][0] = mat4x3(-9.0, 8.0, 0.0, 4.0, -4.0, 7.0, 2.0, -1.0, 7.0, -5.0, -4.0, 3.0);
	s1.a.mB[0][1] = mat4x3(-5.0, -3.0, -1.0, 1.0, 0.0, -3.0, 1.0, 3.0, -9.0, -4.0, 3.0, 9.0);
	s1.a.mB[0][2] = mat4x3(1.0, 3.0, -9.0, -5.0, 9.0, -7.0, -8.0, 1.0, 6.0, 0.0, -3.0, 4.0);
	s1.a.mB[1][0] = mat4x3(-7.0, -1.0, 5.0, -3.0, 0.0, -8.0, 1.0, -9.0, -9.0, -9.0, -7.0, 7.0);
	s1.a.mB[1][1] = mat4x3(-2.0, 2.0, -4.0, 4.0, -8.0, 4.0, 8.0, 5.0, -7.0, -8.0, -5.0, 0.0);
	s1.a.mB[1][2] = mat4x3(1.0, -4.0, -9.0, 2.0, -4.0, -5.0, 1.0, 5.0, 4.0, -7.0, 6.0, 8.0);
	s1.a.mC.mA.mA = mat2x3(0.0, -7.0, -8.0, -7.0, -3.0, 3.0);
	s1.a.mC.mA.mB = 3u;
	s1.a.mC.mA.mC = ivec4(-8, -1, -7, 0);
	s1.a.mC.mB[0] = uvec2(3u, 2u);
	s1.a.mC.mC[0] = true;
	s1.a.mC.mC[1] = true;
	s1.a.mC.mC[2] = true;
	s1.b.mA.mA = uvec3(0u, 4u, 7u);
	s1.b.mB.mA.mA = 0.0;
	s1.b.mB.mA.mB = 4u;
	s1.b.mB.mA.mC = -8;
	s1.b.mC[0][0] = 6;
	s1.b.mC[0][1] = -2;
	s1.b.mC[0][2] = 5;
	s1.c.mA[0].mA = mat3x2(8.0, 8.0, -5.0, 4.0, 9.0, -1.0);
	s1.c.mA[0].mB = mat2(-4.0, 2.0, 4.0, 4.0);
	s1.c.mA[0].mC = ivec4(0, 7, 4, 8);
	s1.c.mA[1].mA = mat3x2(-9.0, -8.0, 6.0, -4.0, -4.0, -2.0);
	s1.c.mA[1].mB = mat2(5.0, 0.0, 4.0, 9.0);
	s1.c.mA[1].mC = ivec4(5, 4, 0, 9);
	s1.c.mA[2].mA = mat3x2(-4.0, 5.0, 2.0, -1.0, 5.0, 1.0);
	s1.c.mA[2].mB = mat2(3.0, 0.0, -7.0, 9.0);
	s1.c.mA[2].mC = ivec4(6, -5, 1, -8);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_ivec3(ivec3(0, 2, -8), s1.a.mA.mA[0]) && allOk;
	allOk = compare_ivec3(ivec3(6, 7, 5), s1.a.mA.mA[1]) && allOk;
	allOk = compare_ivec3(ivec3(-6, 1, 9), s1.a.mA.mA[2]) && allOk;
	allOk = compare_bvec2(bvec2(true, true), s1.a.mA.mB.mA) && allOk;
	allOk = compare_mat2(mat2(4.0, 4.0, 9.0, -9.0), s1.a.mA.mB.mB) && allOk;
	allOk = compare_bool(true, s1.a.mA.mC[0]) && allOk;
	allOk = compare_mat4x3(mat4x3(-9.0, 8.0, 0.0, 4.0, -4.0, 7.0, 2.0, -1.0, 7.0, -5.0, -4.0, 3.0), s1.a.mB[0][0]) && allOk;
	allOk = compare_mat4x3(mat4x3(-5.0, -3.0, -1.0, 1.0, 0.0, -3.0, 1.0, 3.0, -9.0, -4.0, 3.0, 9.0), s1.a.mB[0][1]) && allOk;
	allOk = compare_mat4x3(mat4x3(1.0, 3.0, -9.0, -5.0, 9.0, -7.0, -8.0, 1.0, 6.0, 0.0, -3.0, 4.0), s1.a.mB[0][2]) && allOk;
	allOk = compare_mat4x3(mat4x3(-7.0, -1.0, 5.0, -3.0, 0.0, -8.0, 1.0, -9.0, -9.0, -9.0, -7.0, 7.0), s1.a.mB[1][0]) && allOk;
	allOk = compare_mat4x3(mat4x3(-2.0, 2.0, -4.0, 4.0, -8.0, 4.0, 8.0, 5.0, -7.0, -8.0, -5.0, 0.0), s1.a.mB[1][1]) && allOk;
	allOk = compare_mat4x3(mat4x3(1.0, -4.0, -9.0, 2.0, -4.0, -5.0, 1.0, 5.0, 4.0, -7.0, 6.0, 8.0), s1.a.mB[1][2]) && allOk;
	allOk = compare_mat2x3(mat2x3(0.0, -7.0, -8.0, -7.0, -3.0, 3.0), s1.a.mC.mA.mA) && allOk;
	allOk = compare_uint(3u, s1.a.mC.mA.mB) && allOk;
	allOk = compare_ivec4(ivec4(-8, -1, -7, 0), s1.a.mC.mA.mC) && allOk;
	allOk = compare_uvec2(uvec2(3u, 2u), s1.a.mC.mB[0]) && allOk;
	allOk = compare_bool(true, s1.a.mC.mC[0]) && allOk;
	allOk = compare_bool(true, s1.a.mC.mC[1]) && allOk;
	allOk = compare_bool(true, s1.a.mC.mC[2]) && allOk;
	allOk = compare_uvec3(uvec3(0u, 4u, 7u), s1.b.mA.mA) && allOk;
	allOk = compare_float(0.0, s1.b.mB.mA.mA) && allOk;
	allOk = compare_uint(4u, s1.b.mB.mA.mB) && allOk;
	allOk = compare_int(-8, s1.b.mB.mA.mC) && allOk;
	allOk = compare_int(6, s1.b.mC[0][0]) && allOk;
	allOk = compare_int(-2, s1.b.mC[0][1]) && allOk;
	allOk = compare_int(5, s1.b.mC[0][2]) && allOk;
	allOk = compare_mat3x2(mat3x2(8.0, 8.0, -5.0, 4.0, 9.0, -1.0), s1.c.mA[0].mA) && allOk;
	allOk = compare_mat2(mat2(-4.0, 2.0, 4.0, 4.0), s1.c.mA[0].mB) && allOk;
	allOk = compare_ivec4(ivec4(0, 7, 4, 8), s1.c.mA[0].mC) && allOk;
	allOk = compare_mat3x2(mat3x2(-9.0, -8.0, 6.0, -4.0, -4.0, -2.0), s1.c.mA[1].mA) && allOk;
	allOk = compare_mat2(mat2(5.0, 0.0, 4.0, 9.0), s1.c.mA[1].mB) && allOk;
	allOk = compare_ivec4(ivec4(5, 4, 0, 9), s1.c.mA[1].mC) && allOk;
	allOk = compare_mat3x2(mat3x2(-4.0, 5.0, 2.0, -1.0, 5.0, 1.0), s1.c.mA[2].mA) && allOk;
	allOk = compare_mat2(mat2(3.0, 0.0, -7.0, 9.0), s1.c.mA[2].mB) && allOk;
	allOk = compare_ivec4(ivec4(6, -5, 1, -8), s1.c.mA[2].mC) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	lowp vec3 mA;
	highp uvec2 mB;
	mediump vec3 mC;
};
struct sB
{
	mediump ivec3 mA;
	mediump uint mB;
};
struct sC
{
	sA mA;
	sB mB;
};
struct sD
{
	highp ivec4 mA;
	sC mB;
};
struct sE
{
	mediump mat4 mA[2];
};
struct sF
{
	sE mA;
	mediump float mB[3];
};
struct sG
{
	bvec4 mA[1];
};
struct sH
{
	highp vec3 mA;
};
struct sI
{
	sH mA;
};
struct sJ
{
	lowp uint mA;
};
struct sK
{
	sJ mA;
};
struct sL
{
	bvec2 mA;
	mediump uvec3 mB;
};
struct sM
{
	sL mA;
};
struct sN
{
	sI mA;
	sK mB;
	sM mC;
};
struct sO
{
	bvec4 mA;
	mediump uvec2 mB;
	mediump vec3 mC;
};
struct sP
{
	bvec2 mA;
};
struct sQ
{
	mediump vec4 mA[2];
	sO mB;
	sP mC;
};
struct sR
{
	highp int mA;
};
struct sS
{
	bool mA;
	lowp uint mB;
	bvec4 mC;
};
struct sT
{
	bvec4 mA;
	sR mB;
	sS mC;
};
struct sU
{
	sQ mA;
	sT mB;
};
struct sV
{
	highp ivec3 mA;
	mediump mat3x2 mB;
	bvec2 mC;
};
struct sW
{
	bvec3 mA;
	highp uvec2 mB;
	mediump vec4 mC;
};
struct sX
{
	sV mA;
	sW mB;
	highp vec2 mC;
};
struct sY
{
	mediump ivec3 mA[1][1];
	sX mB;
};
struct S1 {
	sD a;
	sF b;
};
struct S2 {
	sG a[2];
	sN b;
	sU c;
	sY d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a.mA = ivec4(1, -5, -9, -5);
	s1.a.mB.mA.mA = vec3(1.0, -7.0, 1.0);
	s1.a.mB.mA.mB = uvec2(6u, 2u);
	s1.a.mB.mA.mC = vec3(7.0, 9.0, -8.0);
	s1.a.mB.mB.mA = ivec3(2, 9, 6);
	s1.a.mB.mB.mB = 6u;
	s1.b.mA.mA[0] = mat4(7.0, 3.0, -3.0, 7.0, 4.0, -2.0, 9.0, 2.0, -5.0, 1.0, -6.0, 8.0, 5.0, 5.0, -3.0, 3.0);
	s1.b.mA.mA[1] = mat4(1.0, -9.0, 7.0, -2.0, 2.0, 9.0, -3.0, 3.0, 1.0, 1.0, -9.0, -3.0, -9.0, -7.0, -4.0, -4.0);
	s1.b.mB[0] = -6.0;
	s1.b.mB[1] = 1.0;
	s1.b.mB[2] = 3.0;
	s2.a[0].mA[0] = bvec4(false, false, true, true);
	s2.a[1].mA[0] = bvec4(true, true, false, false);
	s2.b.mA.mA.mA = vec3(5.0, -5.0, 2.0);
	s2.b.mB.mA.mA = 5u;
	s2.b.mC.mA.mA = bvec2(true, true);
	s2.b.mC.mA.mB = uvec3(6u, 5u, 4u);
	s2.c.mA.mA[0] = vec4(7.0, 1.0, -8.0, -9.0);
	s2.c.mA.mA[1] = vec4(5.0, 1.0, -5.0, 5.0);
	s2.c.mA.mB.mA = bvec4(true, true, true, true);
	s2.c.mA.mB.mB = uvec2(0u, 4u);
	s2.c.mA.mB.mC = vec3(-3.0, 3.0, 8.0);
	s2.c.mA.mC.mA = bvec2(false, true);
	s2.c.mB.mA = bvec4(true, true, true, true);
	s2.c.mB.mB.mA = -9;
	s2.c.mB.mC.mA = false;
	s2.c.mB.mC.mB = 0u;
	s2.c.mB.mC.mC = bvec4(true, true, true, false);
	s2.d.mA[0][0] = ivec3(-9, 6, 2);
	s2.d.mB.mA.mA = ivec3(-2, -6, 4);
	s2.d.mB.mA.mB = mat3x2(-8.0, 7.0, 1.0, -6.0, 8.0, 4.0);
	s2.d.mB.mA.mC = bvec2(true, false);
	s2.d.mB.mB.mA = bvec3(false, true, true);
	s2.d.mB.mB.mB = uvec2(9u, 5u);
	s2.d.mB.mB.mC = vec4(1.0, -2.0, 4.0, -3.0);
	s2.d.mB.mC = vec2(6.0, 1.0);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_ivec4(ivec4(1, -5, -9, -5), s1.a.mA) && allOk;
	allOk = compare_vec3(vec3(1.0, -7.0, 1.0), s1.a.mB.mA.mA) && allOk;
	allOk = compare_uvec2(uvec2(6u, 2u), s1.a.mB.mA.mB) && allOk;
	allOk = compare_vec3(vec3(7.0, 9.0, -8.0), s1.a.mB.mA.mC) && allOk;
	allOk = compare_ivec3(ivec3(2, 9, 6), s1.a.mB.mB.mA) && allOk;
	allOk = compare_uint(6u, s1.a.mB.mB.mB) && allOk;
	allOk = compare_mat4(mat4(7.0, 3.0, -3.0, 7.0, 4.0, -2.0, 9.0, 2.0, -5.0, 1.0, -6.0, 8.0, 5.0, 5.0, -3.0, 3.0), s1.b.mA.mA[0]) && allOk;
	allOk = compare_mat4(mat4(1.0, -9.0, 7.0, -2.0, 2.0, 9.0, -3.0, 3.0, 1.0, 1.0, -9.0, -3.0, -9.0, -7.0, -4.0, -4.0), s1.b.mA.mA[1]) && allOk;
	allOk = compare_float(-6.0, s1.b.mB[0]) && allOk;
	allOk = compare_float(1.0, s1.b.mB[1]) && allOk;
	allOk = compare_float(3.0, s1.b.mB[2]) && allOk;
	allOk = compare_bvec4(bvec4(false, false, true, true), s2.a[0].mA[0]) && allOk;
	allOk = compare_bvec4(bvec4(true, true, false, false), s2.a[1].mA[0]) && allOk;
	allOk = compare_vec3(vec3(5.0, -5.0, 2.0), s2.b.mA.mA.mA) && allOk;
	allOk = compare_uint(5u, s2.b.mB.mA.mA) && allOk;
	allOk = compare_bvec2(bvec2(true, true), s2.b.mC.mA.mA) && allOk;
	allOk = compare_uvec3(uvec3(6u, 5u, 4u), s2.b.mC.mA.mB) && allOk;
	allOk = compare_vec4(vec4(7.0, 1.0, -8.0, -9.0), s2.c.mA.mA[0]) && allOk;
	allOk = compare_vec4(vec4(5.0, 1.0, -5.0, 5.0), s2.c.mA.mA[1]) && allOk;
	allOk = compare_bvec4(bvec4(true, true, true, true), s2.c.mA.mB.mA) && allOk;
	allOk = compare_uvec2(uvec2(0u, 4u), s2.c.mA.mB.mB) && allOk;
	allOk = compare_vec3(vec3(-3.0, 3.0, 8.0), s2.c.mA.mB.mC) && allOk;
	allOk = compare_bvec2(bvec2(false, true), s2.c.mA.mC.mA) && allOk;
	allOk = compare_bvec4(bvec4(true, true, true, true), s2.c.mB.mA) && allOk;
	allOk = compare_int(-9, s2.c.mB.mB.mA) && allOk;
	allOk = compare_bool(false, s2.c.mB.mC.mA) && allOk;
	allOk = compare_uint(0u, s2.c.mB.mC.mB) && allOk;
	allOk = compare_bvec4(bvec4(true, true, true, false), s2.c.mB.mC.mC) && allOk;
	allOk = compare_ivec3(ivec3(-9, 6, 2), s2.d.mA[0][0]) && allOk;
	allOk = compare_ivec3(ivec3(-2, -6, 4), s2.d.mB.mA.mA) && allOk;
	allOk = compare_mat3x2(mat3x2(-8.0, 7.0, 1.0, -6.0, 8.0, 4.0), s2.d.mB.mA.mB) && allOk;
	allOk = compare_bvec2(bvec2(true, false), s2.d.mB.mA.mC) && allOk;
	allOk = compare_bvec3(bvec3(false, true, true), s2.d.mB.mB.mA) && allOk;
	allOk = compare_uvec2(uvec2(9u, 5u), s2.d.mB.mB.mB) && allOk;
	allOk = compare_vec4(vec4(1.0, -2.0, 4.0, -3.0), s2.d.mB.mB.mC) && allOk;
	allOk = compare_vec2(vec2(6.0, 1.0), s2.d.mB.mC) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	lowp ivec4 mA;
	lowp uvec2 mB;
};
struct sB
{
	lowp vec3 mA;
	mediump vec3 mB;
};
struct sC
{
	highp vec2 mA;
	lowp vec2 mB;
};
struct sD
{
	sB mA;
	sC mB;
	highp vec2 mC[1];
};
struct sE
{
	sD mA;
};
struct sF
{
	mediump vec3 mA;
};
struct sG
{
	sF mA[2];
};
struct sH
{
	mediump uvec4 mA;
	lowp ivec3 mB;
};
struct sI
{
	highp int mA;
	highp ivec4 mB;
};
struct sJ
{
	bvec3 mA;
	sH mB;
	sI mC;
};
struct sK
{
	mediump uint mA;
	bvec2 mB;
	bvec3 mC;
};
struct sL
{
	bvec2 mA;
};
struct sM
{
	sK mA;
	mediump ivec4 mB[1];
	sL mC;
};
struct sN
{
	lowp uvec4 mA;
	bvec3 mB;
};
struct sO
{
	sN mA;
};
struct sP
{
	sJ mA;
	sM mB;
	sO mC;
};
struct sQ
{
	lowp mat4x3 mA;
};
struct sR
{
	bvec4 mA;
	lowp uvec4 mB;
	highp ivec3 mC;
};
struct sS
{
	lowp vec2 mA;
	mediump float mB;
};
struct sT
{
	sQ mA;
	sR mB;
	sS mC;
};
struct sU
{
	mediump int mA;
};
struct sV
{
	mediump ivec4 mA;
	highp uvec4 mB;
	bool mC;
};
struct sW
{
	sU mA;
	sV mB;
};
struct sX
{
	sT mA;
	sW mB;
};
struct sY
{
	mediump vec4 mA;
	highp uvec3 mB;
};
struct sZ
{
	mediump ivec4 mA;
};
struct sAA
{
	highp uvec2 mA[1];
	sY mB;
	sZ mC;
};
struct sAB
{
	highp uvec2 mA;
	lowp vec3 mB;
	bvec4 mC;
};
struct sAC
{
	sAA mA;
	sAB mB[2];
};
struct sAD
{
	mediump ivec3 mA;
	mediump vec4 mB;
};
struct sAE
{
	mediump mat3x4 mA;
	lowp mat3x4 mB;
};
struct sAF
{
	bool mA;
	mediump uint mB;
};
struct sAG
{
	sAD mA;
	sAE mB;
	sAF mC;
};
struct sAH
{
	highp vec2 mA[2][3];
	sAG mB;
};
struct sAI
{
	bool mA;
};
struct sAJ
{
	mediump mat2x3 mA;
	sAI mB;
	mediump vec3 mC[3];
};
struct S1 {
	sA a;
	sE b;
	sG c;
	sP d;
};
struct S2 {
	sX a;
	sAC b;
	sAH c;
	sAJ d[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a.mA = ivec4(2, 7, -9, 3);
	s1.a.mB = uvec2(3u, 9u);
	s1.b.mA.mA.mA = vec3(7.0, -2.0, 3.0);
	s1.b.mA.mA.mB = vec3(9.0, 1.0, -5.0);
	s1.b.mA.mB.mA = vec2(-2.0, 0.0);
	s1.b.mA.mB.mB = vec2(9.0, -1.0);
	s1.b.mA.mC[0] = vec2(-9.0, -6.0);
	s1.c.mA[0].mA = vec3(-9.0, 6.0, 1.0);
	s1.c.mA[1].mA = vec3(-6.0, 0.0, 2.0);
	s1.d.mA.mA = bvec3(false, true, false);
	s1.d.mA.mB.mA = uvec4(8u, 4u, 9u, 4u);
	s1.d.mA.mB.mB = ivec3(2, -7, 5);
	s1.d.mA.mC.mA = -6;
	s1.d.mA.mC.mB = ivec4(-9, -8, 8, -5);
	s1.d.mB.mA.mA = 1u;
	s1.d.mB.mA.mB = bvec2(true, true);
	s1.d.mB.mA.mC = bvec3(true, true, true);
	s1.d.mB.mB[0] = ivec4(3, 9, 7, 9);
	s1.d.mB.mC.mA = bvec2(false, false);
	s1.d.mC.mA.mA = uvec4(6u, 5u, 8u, 5u);
	s1.d.mC.mA.mB = bvec3(true, false, false);
	s2.a.mA.mA.mA = mat4x3(3.0, 3.0, 2.0, 3.0, 1.0, 9.0, -4.0, 4.0, 8.0, 2.0, 3.0, 0.0);
	s2.a.mA.mB.mA = bvec4(true, false, false, true);
	s2.a.mA.mB.mB = uvec4(7u, 6u, 2u, 6u);
	s2.a.mA.mB.mC = ivec3(-6, 4, 0);
	s2.a.mA.mC.mA = vec2(-3.0, -3.0);
	s2.a.mA.mC.mB = 9.0;
	s2.a.mB.mA.mA = -1;
	s2.a.mB.mB.mA = ivec4(-8, -9, -7, -2);
	s2.a.mB.mB.mB = uvec4(3u, 6u, 1u, 0u);
	s2.a.mB.mB.mC = false;
	s2.b.mA.mA[0] = uvec2(0u, 8u);
	s2.b.mA.mB.mA = vec4(2.0, -8.0, 5.0, -7.0);
	s2.b.mA.mB.mB = uvec3(7u, 3u, 6u);
	s2.b.mA.mC.mA = ivec4(7, 0, 9, 1);
	s2.b.mB[0].mA = uvec2(4u, 8u);
	s2.b.mB[0].mB = vec3(-9.0, 4.0, 7.0);
	s2.b.mB[0].mC = bvec4(false, false, true, false);
	s2.b.mB[1].mA = uvec2(2u, 0u);
	s2.b.mB[1].mB = vec3(-9.0, 7.0, 4.0);
	s2.b.mB[1].mC = bvec4(true, true, false, true);
	s2.c.mA[0][0] = vec2(9.0, 0.0);
	s2.c.mA[0][1] = vec2(8.0, 1.0);
	s2.c.mA[0][2] = vec2(9.0, -2.0);
	s2.c.mA[1][0] = vec2(-2.0, 5.0);
	s2.c.mA[1][1] = vec2(6.0, 1.0);
	s2.c.mA[1][2] = vec2(4.0, -3.0);
	s2.c.mB.mA.mA = ivec3(-2, 9, -5);
	s2.c.mB.mA.mB = vec4(-3.0, -7.0, -4.0, 0.0);
	s2.c.mB.mB.mA = mat3x4(-3.0, -1.0, -7.0, -4.0, -1.0, 8.0, -6.0, 9.0, 8.0, 2.0, -7.0, 3.0);
	s2.c.mB.mB.mB = mat3x4(5.0, 3.0, 3.0, 2.0, 0.0, 5.0, 8.0, -2.0, 1.0, -7.0, 7.0, -7.0);
	s2.c.mB.mC.mA = false;
	s2.c.mB.mC.mB = 0u;
	s2.d[0].mA = mat2x3(1.0, -3.0, -3.0, 5.0, -7.0, -2.0);
	s2.d[0].mB.mA = false;
	s2.d[0].mC[0] = vec3(8.0, -9.0, 4.0);
	s2.d[0].mC[1] = vec3(-6.0, -1.0, 2.0);
	s2.d[0].mC[2] = vec3(0.0, -8.0, -5.0);
	s2.d[1].mA = mat2x3(0.0, -9.0, 0.0, 9.0, 2.0, -5.0);
	s2.d[1].mB.mA = false;
	s2.d[1].mC[0] = vec3(-9.0, -5.0, 0.0);
	s2.d[1].mC[1] = vec3(1.0, 3.0, -2.0);
	s2.d[1].mC[2] = vec3(3.0, 9.0, 7.0);
	s2.d[2].mA = mat2x3(4.0, 8.0, 4.0, 2.0, 5.0, -8.0);
	s2.d[2].mB.mA = true;
	s2.d[2].mC[0] = vec3(-7.0, 8.0, -6.0);
	s2.d[2].mC[1] = vec3(4.0, -2.0, 8.0);
	s2.d[2].mC[2] = vec3(0.0, -2.0, -3.0);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_ivec4(ivec4(2, 7, -9, 3), s1.a.mA) && allOk;
	allOk = compare_uvec2(uvec2(3u, 9u), s1.a.mB) && allOk;
	allOk = compare_vec3(vec3(7.0, -2.0, 3.0), s1.b.mA.mA.mA) && allOk;
	allOk = compare_vec3(vec3(9.0, 1.0, -5.0), s1.b.mA.mA.mB) && allOk;
	allOk = compare_vec2(vec2(-2.0, 0.0), s1.b.mA.mB.mA) && allOk;
	allOk = compare_vec2(vec2(9.0, -1.0), s1.b.mA.mB.mB) && allOk;
	allOk = compare_vec2(vec2(-9.0, -6.0), s1.b.mA.mC[0]) && allOk;
	allOk = compare_vec3(vec3(-9.0, 6.0, 1.0), s1.c.mA[0].mA) && allOk;
	allOk = compare_vec3(vec3(-6.0, 0.0, 2.0), s1.c.mA[1].mA) && allOk;
	allOk = compare_bvec3(bvec3(false, true, false), s1.d.mA.mA) && allOk;
	allOk = compare_uvec4(uvec4(8u, 4u, 9u, 4u), s1.d.mA.mB.mA) && allOk;
	allOk = compare_ivec3(ivec3(2, -7, 5), s1.d.mA.mB.mB) && allOk;
	allOk = compare_int(-6, s1.d.mA.mC.mA) && allOk;
	allOk = compare_ivec4(ivec4(-9, -8, 8, -5), s1.d.mA.mC.mB) && allOk;
	allOk = compare_uint(1u, s1.d.mB.mA.mA) && allOk;
	allOk = compare_bvec2(bvec2(true, true), s1.d.mB.mA.mB) && allOk;
	allOk = compare_bvec3(bvec3(true, true, true), s1.d.mB.mA.mC) && allOk;
	allOk = compare_ivec4(ivec4(3, 9, 7, 9), s1.d.mB.mB[0]) && allOk;
	allOk = compare_bvec2(bvec2(false, false), s1.d.mB.mC.mA) && allOk;
	allOk = compare_uvec4(uvec4(6u, 5u, 8u, 5u), s1.d.mC.mA.mA) && allOk;
	allOk = compare_bvec3(bvec3(true, false, false), s1.d.mC.mA.mB) && allOk;
	allOk = compare_mat4x3(mat4x3(3.0, 3.0, 2.0, 3.0, 1.0, 9.0, -4.0, 4.0, 8.0, 2.0, 3.0, 0.0), s2.a.mA.mA.mA) && allOk;
	allOk = compare_bvec4(bvec4(true, false, false, true), s2.a.mA.mB.mA) && allOk;
	allOk = compare_uvec4(uvec4(7u, 6u, 2u, 6u), s2.a.mA.mB.mB) && allOk;
	allOk = compare_ivec3(ivec3(-6, 4, 0), s2.a.mA.mB.mC) && allOk;
	allOk = compare_vec2(vec2(-3.0, -3.0), s2.a.mA.mC.mA) && allOk;
	allOk = compare_float(9.0, s2.a.mA.mC.mB) && allOk;
	allOk = compare_int(-1, s2.a.mB.mA.mA) && allOk;
	allOk = compare_ivec4(ivec4(-8, -9, -7, -2), s2.a.mB.mB.mA) && allOk;
	allOk = compare_uvec4(uvec4(3u, 6u, 1u, 0u), s2.a.mB.mB.mB) && allOk;
	allOk = compare_bool(false, s2.a.mB.mB.mC) && allOk;
	allOk = compare_uvec2(uvec2(0u, 8u), s2.b.mA.mA[0]) && allOk;
	allOk = compare_vec4(vec4(2.0, -8.0, 5.0, -7.0), s2.b.mA.mB.mA) && allOk;
	allOk = compare_uvec3(uvec3(7u, 3u, 6u), s2.b.mA.mB.mB) && allOk;
	allOk = compare_ivec4(ivec4(7, 0, 9, 1), s2.b.mA.mC.mA) && allOk;
	allOk = compare_uvec2(uvec2(4u, 8u), s2.b.mB[0].mA) && allOk;
	allOk = compare_vec3(vec3(-9.0, 4.0, 7.0), s2.b.mB[0].mB) && allOk;
	allOk = compare_bvec4(bvec4(false, false, true, false), s2.b.mB[0].mC) && allOk;
	allOk = compare_uvec2(uvec2(2u, 0u), s2.b.mB[1].mA) && allOk;
	allOk = compare_vec3(vec3(-9.0, 7.0, 4.0), s2.b.mB[1].mB) && allOk;
	allOk = compare_bvec4(bvec4(true, true, false, true), s2.b.mB[1].mC) && allOk;
	allOk = compare_vec2(vec2(9.0, 0.0), s2.c.mA[0][0]) && allOk;
	allOk = compare_vec2(vec2(8.0, 1.0), s2.c.mA[0][1]) && allOk;
	allOk = compare_vec2(vec2(9.0, -2.0), s2.c.mA[0][2]) && allOk;
	allOk = compare_vec2(vec2(-2.0, 5.0), s2.c.mA[1][0]) && allOk;
	allOk = compare_vec2(vec2(6.0, 1.0), s2.c.mA[1][1]) && allOk;
	allOk = compare_vec2(vec2(4.0, -3.0), s2.c.mA[1][2]) && allOk;
	allOk = compare_ivec3(ivec3(-2, 9, -5), s2.c.mB.mA.mA) && allOk;
	allOk = compare_vec4(vec4(-3.0, -7.0, -4.0, 0.0), s2.c.mB.mA.mB) && allOk;
	allOk = compare_mat3x4(mat3x4(-3.0, -1.0, -7.0, -4.0, -1.0, 8.0, -6.0, 9.0, 8.0, 2.0, -7.0, 3.0), s2.c.mB.mB.mA) && allOk;
	allOk = compare_mat3x4(mat3x4(5.0, 3.0, 3.0, 2.0, 0.0, 5.0, 8.0, -2.0, 1.0, -7.0, 7.0, -7.0), s2.c.mB.mB.mB) && allOk;
	allOk = compare_bool(false, s2.c.mB.mC.mA) && allOk;
	allOk = compare_uint(0u, s2.c.mB.mC.mB) && allOk;
	allOk = compare_mat2x3(mat2x3(1.0, -3.0, -3.0, 5.0, -7.0, -2.0), s2.d[0].mA) && allOk;
	allOk = compare_bool(false, s2.d[0].mB.mA) && allOk;
	allOk = compare_vec3(vec3(8.0, -9.0, 4.0), s2.d[0].mC[0]) && allOk;
	allOk = compare_vec3(vec3(-6.0, -1.0, 2.0), s2.d[0].mC[1]) && allOk;
	allOk = compare_vec3(vec3(0.0, -8.0, -5.0), s2.d[0].mC[2]) && allOk;
	allOk = compare_mat2x3(mat2x3(0.0, -9.0, 0.0, 9.0, 2.0, -5.0), s2.d[1].mA) && allOk;
	allOk = compare_bool(false, s2.d[1].mB.mA) && allOk;
	allOk = compare_vec3(vec3(-9.0, -5.0, 0.0), s2.d[1].mC[0]) && allOk;
	allOk = compare_vec3(vec3(1.0, 3.0, -2.0), s2.d[1].mC[1]) && allOk;
	allOk = compare_vec3(vec3(3.0, 9.0, 7.0), s2.d[1].mC[2]) && allOk;
	allOk = compare_mat2x3(mat2x3(4.0, 8.0, 4.0, 2.0, 5.0, -8.0), s2.d[2].mA) && allOk;
	allOk = compare_bool(true, s2.d[2].mB.mA) && allOk;
	allOk = compare_vec3(vec3(-7.0, 8.0, -6.0), s2.d[2].mC[0]) && allOk;
	allOk = compare_vec3(vec3(4.0, -2.0, 8.0), s2.d[2].mC[1]) && allOk;
	allOk = compare_vec3(vec3(0.0, -2.0, -3.0), s2.d[2].mC[2]) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	lowp ivec3 mA;
};
struct sB
{
	sA mA[2];
};
struct sC
{
	lowp int mA;
};
struct sD
{
	sC mA;
	highp uvec3 mB;
};
struct sE
{
	mediump uvec3 mA;
};
struct sF
{
	sE mA;
};
struct sG
{
	sD mA;
	sF mB;
};
struct sH
{
	lowp vec2 mA[1];
};
struct sI
{
	mediump ivec2 mA;
	highp uvec2 mB;
};
struct sJ
{
	mediump float mA[3];
	sI mB;
};
struct sK
{
	sH mA;
	sJ mB;
};
struct S1 {
	sB a;
	sG b;
};
struct S2 {
	sK a;
	bvec4 b[1][2][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a.mA[0].mA = ivec3(2, -3, 2);
	s1.a.mA[1].mA = ivec3(-4, 4, 6);
	s1.b.mA.mA.mA = -2;
	s1.b.mA.mB = uvec3(1u, 9u, 5u);
	s1.b.mB.mA.mA = uvec3(9u, 6u, 8u);
	s2.a.mA.mA[0] = vec2(7.0, 3.0);
	s2.a.mB.mA[0] = 3.0;
	s2.a.mB.mA[1] = -4.0;
	s2.a.mB.mA[2] = 8.0;
	s2.a.mB.mB.mA = ivec2(-7, -9);
	s2.a.mB.mB.mB = uvec2(8u, 5u);
	s2.b[0][0][0] = bvec4(false, false, false, false);
	s2.b[0][0][1] = bvec4(false, true, true, true);
	s2.b[0][1][0] = bvec4(true, false, false, false);
	s2.b[0][1][1] = bvec4(true, false, true, false);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_ivec3(ivec3(2, -3, 2), s1.a.mA[0].mA) && allOk;
	allOk = compare_ivec3(ivec3(-4, 4, 6), s1.a.mA[1].mA) && allOk;
	allOk = compare_int(-2, s1.b.mA.mA.mA) && allOk;
	allOk = compare_uvec3(uvec3(1u, 9u, 5u), s1.b.mA.mB) && allOk;
	allOk = compare_uvec3(uvec3(9u, 6u, 8u), s1.b.mB.mA.mA) && allOk;
	allOk = compare_vec2(vec2(7.0, 3.0), s2.a.mA.mA[0]) && allOk;
	allOk = compare_float(3.0, s2.a.mB.mA[0]) && allOk;
	allOk = compare_float(-4.0, s2.a.mB.mA[1]) && allOk;
	allOk = compare_float(8.0, s2.a.mB.mA[2]) && allOk;
	allOk = compare_ivec2(ivec2(-7, -9), s2.a.mB.mB.mA) && allOk;
	allOk = compare_uvec2(uvec2(8u, 5u), s2.a.mB.mB.mB) && allOk;
	allOk = compare_bvec4(bvec4(false, false, false, false), s2.b[0][0][0]) && allOk;
	allOk = compare_bvec4(bvec4(false, true, true, true), s2.b[0][0][1]) && allOk;
	allOk = compare_bvec4(bvec4(true, false, false, false), s2.b[0][1][0]) && allOk;
	allOk = compare_bvec4(bvec4(true, false, true, false), s2.b[0][1][1]) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	lowp vec3 mA;
};
struct sB
{
	sA mA;
};
struct sC
{
	highp uvec3 mA;
	lowp int mB;
};
struct sD
{
	mediump int mA;
	bvec2 mB;
	bvec3 mC;
};
struct sE
{
	lowp uvec3 mA;
};
struct sF
{
	sC mA;
	sD mB;
	sE mC;
};
struct sG
{
	highp uint mA;
	mediump ivec2 mB;
	bvec4 mC;
};
struct sH
{
	highp ivec4 mA;
};
struct sI
{
	sG mA;
	highp uint mB;
	sH mC;
};
struct sJ
{
	sB mA;
	sF mB;
	sI mC;
};
struct sK
{
	lowp ivec4 mA;
	highp vec2 mB;
};
struct sL
{
	lowp vec3 mA;
	lowp ivec4 mB;
	highp uvec2 mC;
};
struct sM
{
	lowp float mA;
	highp vec2 mB;
	bool mC;
};
struct sN
{
	sL mA;
	sM mB;
};
struct sO
{
	sK mA[3];
	sN mB;
};
struct sP
{
	mediump int mA[1][2];
};
struct sQ
{
	bvec2 mA;
	highp mat4x3 mB;
};
struct sR
{
	highp uvec2 mA;
	highp int mB;
};
struct sS
{
	lowp mat2x3 mA;
};
struct sT
{
	sR mA;
	sS mB;
};
struct sU
{
	bvec2 mA;
};
struct sV
{
	mediump uvec3 mA[1];
	sU mB;
};
struct sW
{
	bool mA;
};
struct sX
{
	highp ivec2 mA;
	mediump int mB;
	bvec3 mC;
};
struct sY
{
	highp mat2 mA;
};
struct sZ
{
	sW mA;
	sX mB;
	sY mC;
};
struct sAA
{
	sT mA;
	sV mB;
	sZ mC;
};
struct sAB
{
	mediump int mA;
};
struct sAC
{
	lowp uvec2 mA;
	lowp uvec2 mB;
	mediump vec3 mC;
};
struct sAD
{
	highp uvec4 mA[2];
	sAC mB;
};
struct sAE
{
	sAD mA;
	mediump vec2 mB[3][2];
};
struct sAF
{
	lowp vec2 mA;
	lowp mat3x4 mB;
};
struct sAG
{
	highp vec4 mA;
	sAF mB;
};
struct sAH
{
	highp ivec3 mA;
};
struct sAI
{
	highp uvec4 mA;
};
struct sAJ
{
	sAI mA;
	lowp mat2x3 mB[2];
};
struct sAK
{
	sAG mA;
	sAH mB[3];
	sAJ mC;
};
struct sAL
{
	highp ivec2 mA;
};
struct sAM
{
	sAL mA;
	mediump vec4 mB[1];
};
struct sAN
{
	sAM mA;
};
struct S1 {
	sJ a;
	sO b;
	sP c;
	sQ d;
};
struct S2 {
	sAA a;
	sAB b[2][3];
};
struct S3 {
	sAE a;
	sAK b;
	sAN c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

shared S1 s1;
shared S2 s2;
shared S3 s3;

void main (void) {
	s1.a.mA.mA.mA = vec3(-4.0, 6.0, 6.0);
	s1.a.mB.mA.mA = uvec3(5u, 3u, 2u);
	s1.a.mB.mA.mB = -4;
	s1.a.mB.mB.mA = -9;
	s1.a.mB.mB.mB = bvec2(false, true);
	s1.a.mB.mB.mC = bvec3(true, true, false);
	s1.a.mB.mC.mA = uvec3(6u, 4u, 2u);
	s1.a.mC.mA.mA = 2u;
	s1.a.mC.mA.mB = ivec2(-7, -5);
	s1.a.mC.mA.mC = bvec4(false, true, false, false);
	s1.a.mC.mB = 9u;
	s1.a.mC.mC.mA = ivec4(0, -5, 0, 1);
	s1.b.mA[0].mA = ivec4(-8, 0, 3, -5);
	s1.b.mA[0].mB = vec2(5.0, -7.0);
	s1.b.mA[1].mA = ivec4(1, -8, 2, 0);
	s1.b.mA[1].mB = vec2(1.0, 8.0);
	s1.b.mA[2].mA = ivec4(-3, 7, -6, -9);
	s1.b.mA[2].mB = vec2(-5.0, 6.0);
	s1.b.mB.mA.mA = vec3(-8.0, -8.0, 3.0);
	s1.b.mB.mA.mB = ivec4(3, 8, 4, -1);
	s1.b.mB.mA.mC = uvec2(6u, 1u);
	s1.b.mB.mB.mA = 8.0;
	s1.b.mB.mB.mB = vec2(-6.0, 2.0);
	s1.b.mB.mB.mC = false;
	s1.c.mA[0][0] = 9;
	s1.c.mA[0][1] = 9;
	s1.d.mA = bvec2(true, false);
	s1.d.mB = mat4x3(4.0, 0.0, -7.0, -8.0, 2.0, 4.0, 7.0, -9.0, -3.0, 0.0, 4.0, -7.0);
	s2.a.mA.mA.mA = uvec2(2u, 9u);
	s2.a.mA.mA.mB = 1;
	s2.a.mA.mB.mA = mat2x3(-7.0, 1.0, -5.0, 6.0, -8.0, -5.0);
	s2.a.mB.mA[0] = uvec3(4u, 4u, 1u);
	s2.a.mB.mB.mA = bvec2(true, false);
	s2.a.mC.mA.mA = true;
	s2.a.mC.mB.mA = ivec2(-1, -6);
	s2.a.mC.mB.mB = 2;
	s2.a.mC.mB.mC = bvec3(true, true, true);
	s2.a.mC.mC.mA = mat2(3.0, -7.0, -1.0, 0.0);
	s2.b[0][0].mA = -2;
	s2.b[0][1].mA = -9;
	s2.b[0][2].mA = 1;
	s2.b[1][0].mA = 1;
	s2.b[1][1].mA = -3;
	s2.b[1][2].mA = -4;
	s3.a.mA.mA[0] = uvec4(4u, 6u, 0u, 3u);
	s3.a.mA.mA[1] = uvec4(3u, 8u, 2u, 6u);
	s3.a.mA.mB.mA = uvec2(1u, 7u);
	s3.a.mA.mB.mB = uvec2(0u, 5u);
	s3.a.mA.mB.mC = vec3(-3.0, 2.0, 4.0);
	s3.a.mB[0][0] = vec2(-4.0, -8.0);
	s3.a.mB[0][1] = vec2(4.0, 1.0);
	s3.a.mB[1][0] = vec2(-6.0, 3.0);
	s3.a.mB[1][1] = vec2(-5.0, 2.0);
	s3.a.mB[2][0] = vec2(-4.0, 2.0);
	s3.a.mB[2][1] = vec2(-4.0, 7.0);
	s3.b.mA.mA = vec4(-7.0, 4.0, -1.0, -2.0);
	s3.b.mA.mB.mA = vec2(-9.0, -9.0);
	s3.b.mA.mB.mB = mat3x4(4.0, -2.0, 2.0, 5.0, -9.0, -4.0, 0.0, -5.0, 3.0, 9.0, -5.0, -4.0);
	s3.b.mB[0].mA = ivec3(-7, 9, -5);
	s3.b.mB[1].mA = ivec3(-9, 3, -9);
	s3.b.mB[2].mA = ivec3(7, -8, 9);
	s3.b.mC.mA.mA = uvec4(7u, 2u, 2u, 3u);
	s3.b.mC.mB[0] = mat2x3(4.0, 7.0, -3.0, -3.0, 8.0, -5.0);
	s3.b.mC.mB[1] = mat2x3(9.0, -2.0, 3.0, -7.0, -6.0, -5.0);
	s3.c.mA.mA.mA = ivec2(6, 2);
	s3.c.mA.mB[0] = vec4(-7.0, 7.0, -2.0, -8.0);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_vec3(vec3(-4.0, 6.0, 6.0), s1.a.mA.mA.mA) && allOk;
	allOk = compare_uvec3(uvec3(5u, 3u, 2u), s1.a.mB.mA.mA) && allOk;
	allOk = compare_int(-4, s1.a.mB.mA.mB) && allOk;
	allOk = compare_int(-9, s1.a.mB.mB.mA) && allOk;
	allOk = compare_bvec2(bvec2(false, true), s1.a.mB.mB.mB) && allOk;
	allOk = compare_bvec3(bvec3(true, true, false), s1.a.mB.mB.mC) && allOk;
	allOk = compare_uvec3(uvec3(6u, 4u, 2u), s1.a.mB.mC.mA) && allOk;
	allOk = compare_uint(2u, s1.a.mC.mA.mA) && allOk;
	allOk = compare_ivec2(ivec2(-7, -5), s1.a.mC.mA.mB) && allOk;
	allOk = compare_bvec4(bvec4(false, true, false, false), s1.a.mC.mA.mC) && allOk;
	allOk = compare_uint(9u, s1.a.mC.mB) && allOk;
	allOk = compare_ivec4(ivec4(0, -5, 0, 1), s1.a.mC.mC.mA) && allOk;
	allOk = compare_ivec4(ivec4(-8, 0, 3, -5), s1.b.mA[0].mA) && allOk;
	allOk = compare_vec2(vec2(5.0, -7.0), s1.b.mA[0].mB) && allOk;
	allOk = compare_ivec4(ivec4(1, -8, 2, 0), s1.b.mA[1].mA) && allOk;
	allOk = compare_vec2(vec2(1.0, 8.0), s1.b.mA[1].mB) && allOk;
	allOk = compare_ivec4(ivec4(-3, 7, -6, -9), s1.b.mA[2].mA) && allOk;
	allOk = compare_vec2(vec2(-5.0, 6.0), s1.b.mA[2].mB) && allOk;
	allOk = compare_vec3(vec3(-8.0, -8.0, 3.0), s1.b.mB.mA.mA) && allOk;
	allOk = compare_ivec4(ivec4(3, 8, 4, -1), s1.b.mB.mA.mB) && allOk;
	allOk = compare_uvec2(uvec2(6u, 1u), s1.b.mB.mA.mC) && allOk;
	allOk = compare_float(8.0, s1.b.mB.mB.mA) && allOk;
	allOk = compare_vec2(vec2(-6.0, 2.0), s1.b.mB.mB.mB) && allOk;
	allOk = compare_bool(false, s1.b.mB.mB.mC) && allOk;
	allOk = compare_int(9, s1.c.mA[0][0]) && allOk;
	allOk = compare_int(9, s1.c.mA[0][1]) && allOk;
	allOk = compare_bvec2(bvec2(true, false), s1.d.mA) && allOk;
	allOk = compare_mat4x3(mat4x3(4.0, 0.0, -7.0, -8.0, 2.0, 4.0, 7.0, -9.0, -3.0, 0.0, 4.0, -7.0), s1.d.mB) && allOk;
	allOk = compare_uvec2(uvec2(2u, 9u), s2.a.mA.mA.mA) && allOk;
	allOk = compare_int(1, s2.a.mA.mA.mB) && allOk;
	allOk = compare_mat2x3(mat2x3(-7.0, 1.0, -5.0, 6.0, -8.0, -5.0), s2.a.mA.mB.mA) && allOk;
	allOk = compare_uvec3(uvec3(4u, 4u, 1u), s2.a.mB.mA[0]) && allOk;
	allOk = compare_bvec2(bvec2(true, false), s2.a.mB.mB.mA) && allOk;
	allOk = compare_bool(true, s2.a.mC.mA.mA) && allOk;
	allOk = compare_ivec2(ivec2(-1, -6), s2.a.mC.mB.mA) && allOk;
	allOk = compare_int(2, s2.a.mC.mB.mB) && allOk;
	allOk = compare_bvec3(bvec3(true, true, true), s2.a.mC.mB.mC) && allOk;
	allOk = compare_mat2(mat2(3.0, -7.0, -1.0, 0.0), s2.a.mC.mC.mA) && allOk;
	allOk = compare_int(-2, s2.b[0][0].mA) && allOk;
	allOk = compare_int(-9, s2.b[0][1].mA) && allOk;
	allOk = compare_int(1, s2.b[0][2].mA) && allOk;
	allOk = compare_int(1, s2.b[1][0].mA) && allOk;
	allOk = compare_int(-3, s2.b[1][1].mA) && allOk;
	allOk = compare_int(-4, s2.b[1][2].mA) && allOk;
	allOk = compare_uvec4(uvec4(4u, 6u, 0u, 3u), s3.a.mA.mA[0]) && allOk;
	allOk = compare_uvec4(uvec4(3u, 8u, 2u, 6u), s3.a.mA.mA[1]) && allOk;
	allOk = compare_uvec2(uvec2(1u, 7u), s3.a.mA.mB.mA) && allOk;
	allOk = compare_uvec2(uvec2(0u, 5u), s3.a.mA.mB.mB) && allOk;
	allOk = compare_vec3(vec3(-3.0, 2.0, 4.0), s3.a.mA.mB.mC) && allOk;
	allOk = compare_vec2(vec2(-4.0, -8.0), s3.a.mB[0][0]) && allOk;
	allOk = compare_vec2(vec2(4.0, 1.0), s3.a.mB[0][1]) && allOk;
	allOk = compare_vec2(vec2(-6.0, 3.0), s3.a.mB[1][0]) && allOk;
	allOk = compare_vec2(vec2(-5.0, 2.0), s3.a.mB[1][1]) && allOk;
	allOk = compare_vec2(vec2(-4.0, 2.0), s3.a.mB[2][0]) && allOk;
	allOk = compare_vec2(vec2(-4.0, 7.0), s3.a.mB[2][1]) && allOk;
	allOk = compare_vec4(vec4(-7.0, 4.0, -1.0, -2.0), s3.b.mA.mA) && allOk;
	allOk = compare_vec2(vec2(-9.0, -9.0), s3.b.mA.mB.mA) && allOk;
	allOk = compare_mat3x4(mat3x4(4.0, -2.0, 2.0, 5.0, -9.0, -4.0, 0.0, -5.0, 3.0, 9.0, -5.0, -4.0), s3.b.mA.mB.mB) && allOk;
	allOk = compare_ivec3(ivec3(-7, 9, -5), s3.b.mB[0].mA) && allOk;
	allOk = compare_ivec3(ivec3(-9, 3, -9), s3.b.mB[1].mA) && allOk;
	allOk = compare_ivec3(ivec3(7, -8, 9), s3.b.mB[2].mA) && allOk;
	allOk = compare_uvec4(uvec4(7u, 2u, 2u, 3u), s3.b.mC.mA.mA) && allOk;
	allOk = compare_mat2x3(mat2x3(4.0, 7.0, -3.0, -3.0, 8.0, -5.0), s3.b.mC.mB[0]) && allOk;
	allOk = compare_mat2x3(mat2x3(9.0, -2.0, 3.0, -7.0, -6.0, -5.0), s3.b.mC.mB[1]) && allOk;
	allOk = compare_ivec2(ivec2(6, 2), s3.c.mA.mA.mA) && allOk;
	allOk = compare_vec4(vec4(-7.0, 7.0, -2.0, -8.0), s3.c.mA.mB[0]) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	bvec3 mA;
	bvec2 mB;
};
struct sB
{
	highp vec4 mA;
	mediump float mB;
};
struct sC
{
	sA mA;
	sB mB;
	bvec4 mC[1];
};
struct sD
{
	bvec3 mA[2];
	lowp mat4x3 mB[2];
};
struct sE
{
	mediump uvec3 mA;
	lowp mat3x2 mB;
	mediump vec4 mC;
};
struct sF
{
	mediump ivec4 mA;
	bvec2 mB;
};
struct sG
{
	sE mA;
	sF mB;
};
struct sH
{
	sC mA;
	sD mB;
	sG mC;
};
struct sI
{
	mediump uvec4 mA;
	mediump uvec2 mB;
};
struct sJ
{
	highp uvec4 mA;
	lowp uvec3 mB;
	bvec3 mC;
};
struct sK
{
	sI mA;
	sJ mB;
};
struct sL
{
	highp ivec4 mA;
	mediump uvec2 mB;
};
struct sM
{
	highp vec3 mA;
};
struct sN
{
	sL mA;
	mediump uvec3 mB;
	sM mC;
};
struct sO
{
	highp ivec4 mA;
	highp vec3 mB;
};
struct sP
{
	mediump vec4 mA[3];
	mediump uvec3 mB[3];
	sO mC;
};
struct sQ
{
	sN mA;
	sP mB;
};
struct sR
{
	highp uvec3 mA;
	bvec2 mB;
};
struct sS
{
	mediump ivec3 mA[2];
	sR mB;
};
struct sT
{
	lowp ivec3 mA;
	lowp vec3 mB;
	lowp ivec4 mC;
};
struct sU
{
	sT mA;
};
struct sV
{
	sS mA;
	sU mB;
};
struct sW
{
	highp uvec4 mA;
	lowp vec3 mB;
	mediump ivec2 mC;
};
struct sX
{
	mediump ivec2 mA;
	highp vec3 mB;
};
struct sY
{
	sW mA;
	sX mB;
};
struct sZ
{
	lowp vec2 mA;
	highp ivec3 mB;
	bvec4 mC;
};
struct sAA
{
	sY mA;
	sZ mB[3];
};
struct sAB
{
	mediump float mA;
};
struct sAC
{
	highp ivec4 mA;
	highp uvec3 mB;
};
struct sAD
{
	sAB mA;
	sAC mB;
	lowp vec3 mC[1];
};
struct sAE
{
	lowp ivec3 mA;
	lowp uint mB;
	lowp mat4x3 mC;
};
struct sAF
{
	mediump mat4 mA;
};
struct sAG
{
	sAE mA;
	sAF mB;
};
struct S1 {
	sH a;
	sK b[3];
	sQ c;
	sV d;
};
struct S2 {
	sAA a;
	sAD b[1];
	sAG c[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a.mA.mA.mA = bvec3(true, true, true);
	s1.a.mA.mA.mB = bvec2(true, true);
	s1.a.mA.mB.mA = vec4(-5.0, 7.0, 7.0, 0.0);
	s1.a.mA.mB.mB = 5.0;
	s1.a.mA.mC[0] = bvec4(false, true, true, true);
	s1.a.mB.mA[0] = bvec3(true, false, true);
	s1.a.mB.mA[1] = bvec3(false, false, false);
	s1.a.mB.mB[0] = mat4x3(3.0, -2.0, -1.0, -5.0, 5.0, 3.0, 9.0, -5.0, 1.0, 8.0, -8.0, 4.0);
	s1.a.mB.mB[1] = mat4x3(-8.0, -3.0, -1.0, 4.0, -9.0, 7.0, 1.0, -4.0, 7.0, -6.0, 0.0, 6.0);
	s1.a.mC.mA.mA = uvec3(4u, 1u, 6u);
	s1.a.mC.mA.mB = mat3x2(-3.0, 2.0, 2.0, 3.0, 3.0, -7.0);
	s1.a.mC.mA.mC = vec4(7.0, -3.0, -3.0, 8.0);
	s1.a.mC.mB.mA = ivec4(3, -1, 0, -6);
	s1.a.mC.mB.mB = bvec2(false, false);
	s1.b[0].mA.mA = uvec4(4u, 0u, 9u, 0u);
	s1.b[0].mA.mB = uvec2(4u, 9u);
	s1.b[0].mB.mA = uvec4(4u, 1u, 6u, 8u);
	s1.b[0].mB.mB = uvec3(8u, 6u, 2u);
	s1.b[0].mB.mC = bvec3(true, true, false);
	s1.b[1].mA.mA = uvec4(6u, 4u, 6u, 2u);
	s1.b[1].mA.mB = uvec2(3u, 3u);
	s1.b[1].mB.mA = uvec4(1u, 9u, 8u, 6u);
	s1.b[1].mB.mB = uvec3(2u, 2u, 2u);
	s1.b[1].mB.mC = bvec3(false, false, false);
	s1.b[2].mA.mA = uvec4(2u, 9u, 0u, 6u);
	s1.b[2].mA.mB = uvec2(2u, 7u);
	s1.b[2].mB.mA = uvec4(2u, 2u, 9u, 0u);
	s1.b[2].mB.mB = uvec3(6u, 9u, 4u);
	s1.b[2].mB.mC = bvec3(false, false, true);
	s1.c.mA.mA.mA = ivec4(4, -4, 6, -9);
	s1.c.mA.mA.mB = uvec2(9u, 4u);
	s1.c.mA.mB = uvec3(1u, 1u, 0u);
	s1.c.mA.mC.mA = vec3(5.0, -7.0, -7.0);
	s1.c.mB.mA[0] = vec4(-4.0, 4.0, 3.0, -7.0);
	s1.c.mB.mA[1] = vec4(-6.0, 0.0, -6.0, 8.0);
	s1.c.mB.mA[2] = vec4(-9.0, 1.0, -7.0, 6.0);
	s1.c.mB.mB[0] = uvec3(6u, 5u, 5u);
	s1.c.mB.mB[1] = uvec3(0u, 8u, 0u);
	s1.c.mB.mB[2] = uvec3(0u, 3u, 4u);
	s1.c.mB.mC.mA = ivec4(9, 9, -5, 8);
	s1.c.mB.mC.mB = vec3(-7.0, -5.0, -3.0);
	s1.d.mA.mA[0] = ivec3(0, -9, -8);
	s1.d.mA.mA[1] = ivec3(-3, -5, 5);
	s1.d.mA.mB.mA = uvec3(5u, 4u, 1u);
	s1.d.mA.mB.mB = bvec2(true, false);
	s1.d.mB.mA.mA = ivec3(6, 1, 6);
	s1.d.mB.mA.mB = vec3(3.0, 9.0, -5.0);
	s1.d.mB.mA.mC = ivec4(2, 7, -8, -6);
	s2.a.mA.mA.mA = uvec4(1u, 8u, 8u, 9u);
	s2.a.mA.mA.mB = vec3(-4.0, -8.0, -3.0);
	s2.a.mA.mA.mC = ivec2(-4, -7);
	s2.a.mA.mB.mA = ivec2(-3, -5);
	s2.a.mA.mB.mB = vec3(-7.0, -3.0, -6.0);
	s2.a.mB[0].mA = vec2(1.0, -8.0);
	s2.a.mB[0].mB = ivec3(2, -4, 8);
	s2.a.mB[0].mC = bvec4(true, false, false, false);
	s2.a.mB[1].mA = vec2(7.0, -1.0);
	s2.a.mB[1].mB = ivec3(9, -2, 4);
	s2.a.mB[1].mC = bvec4(true, true, false, false);
	s2.a.mB[2].mA = vec2(-5.0, -3.0);
	s2.a.mB[2].mB = ivec3(-5, -5, -9);
	s2.a.mB[2].mC = bvec4(false, false, true, false);
	s2.b[0].mA.mA = -6.0;
	s2.b[0].mB.mA = ivec4(9, -4, 5, -7);
	s2.b[0].mB.mB = uvec3(5u, 8u, 9u);
	s2.b[0].mC[0] = vec3(-1.0, -2.0, 9.0);
	s2.c[0].mA.mA = ivec3(-6, -5, 1);
	s2.c[0].mA.mB = 2u;
	s2.c[0].mA.mC = mat4x3(-8.0, 6.0, -3.0, 8.0, -6.0, 6.0, 2.0, -3.0, 0.0, -7.0, -7.0, 8.0);
	s2.c[0].mB.mA = mat4(6.0, -5.0, -2.0, -4.0, 1.0, 3.0, -5.0, 8.0, 6.0, 1.0, 5.0, 1.0, -9.0, 2.0, 2.0, 9.0);
	s2.c[1].mA.mA = ivec3(5, -4, -4);
	s2.c[1].mA.mB = 0u;
	s2.c[1].mA.mC = mat4x3(1.0, 6.0, 8.0, -9.0, -3.0, -6.0, 8.0, -5.0, 2.0, -1.0, 3.0, -2.0);
	s2.c[1].mB.mA = mat4(1.0, -4.0, -5.0, -5.0, 0.0, 4.0, 7.0, 9.0, -2.0, -5.0, -3.0, 1.0, -9.0, -4.0, 5.0, -7.0);
	s2.c[2].mA.mA = ivec3(-4, -6, -2);
	s2.c[2].mA.mB = 5u;
	s2.c[2].mA.mC = mat4x3(-4.0, 9.0, -4.0, 5.0, -2.0, -5.0, -5.0, -7.0, -8.0, 4.0, -4.0, -1.0);
	s2.c[2].mB.mA = mat4(-9.0, 9.0, 4.0, -2.0, -3.0, -6.0, -3.0, 1.0, -2.0, -2.0, -4.0, -3.0, 5.0, -4.0, -2.0, 5.0);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_bvec3(bvec3(true, true, true), s1.a.mA.mA.mA) && allOk;
	allOk = compare_bvec2(bvec2(true, true), s1.a.mA.mA.mB) && allOk;
	allOk = compare_vec4(vec4(-5.0, 7.0, 7.0, 0.0), s1.a.mA.mB.mA) && allOk;
	allOk = compare_float(5.0, s1.a.mA.mB.mB) && allOk;
	allOk = compare_bvec4(bvec4(false, true, true, true), s1.a.mA.mC[0]) && allOk;
	allOk = compare_bvec3(bvec3(true, false, true), s1.a.mB.mA[0]) && allOk;
	allOk = compare_bvec3(bvec3(false, false, false), s1.a.mB.mA[1]) && allOk;
	allOk = compare_mat4x3(mat4x3(3.0, -2.0, -1.0, -5.0, 5.0, 3.0, 9.0, -5.0, 1.0, 8.0, -8.0, 4.0), s1.a.mB.mB[0]) && allOk;
	allOk = compare_mat4x3(mat4x3(-8.0, -3.0, -1.0, 4.0, -9.0, 7.0, 1.0, -4.0, 7.0, -6.0, 0.0, 6.0), s1.a.mB.mB[1]) && allOk;
	allOk = compare_uvec3(uvec3(4u, 1u, 6u), s1.a.mC.mA.mA) && allOk;
	allOk = compare_mat3x2(mat3x2(-3.0, 2.0, 2.0, 3.0, 3.0, -7.0), s1.a.mC.mA.mB) && allOk;
	allOk = compare_vec4(vec4(7.0, -3.0, -3.0, 8.0), s1.a.mC.mA.mC) && allOk;
	allOk = compare_ivec4(ivec4(3, -1, 0, -6), s1.a.mC.mB.mA) && allOk;
	allOk = compare_bvec2(bvec2(false, false), s1.a.mC.mB.mB) && allOk;
	allOk = compare_uvec4(uvec4(4u, 0u, 9u, 0u), s1.b[0].mA.mA) && allOk;
	allOk = compare_uvec2(uvec2(4u, 9u), s1.b[0].mA.mB) && allOk;
	allOk = compare_uvec4(uvec4(4u, 1u, 6u, 8u), s1.b[0].mB.mA) && allOk;
	allOk = compare_uvec3(uvec3(8u, 6u, 2u), s1.b[0].mB.mB) && allOk;
	allOk = compare_bvec3(bvec3(true, true, false), s1.b[0].mB.mC) && allOk;
	allOk = compare_uvec4(uvec4(6u, 4u, 6u, 2u), s1.b[1].mA.mA) && allOk;
	allOk = compare_uvec2(uvec2(3u, 3u), s1.b[1].mA.mB) && allOk;
	allOk = compare_uvec4(uvec4(1u, 9u, 8u, 6u), s1.b[1].mB.mA) && allOk;
	allOk = compare_uvec3(uvec3(2u, 2u, 2u), s1.b[1].mB.mB) && allOk;
	allOk = compare_bvec3(bvec3(false, false, false), s1.b[1].mB.mC) && allOk;
	allOk = compare_uvec4(uvec4(2u, 9u, 0u, 6u), s1.b[2].mA.mA) && allOk;
	allOk = compare_uvec2(uvec2(2u, 7u), s1.b[2].mA.mB) && allOk;
	allOk = compare_uvec4(uvec4(2u, 2u, 9u, 0u), s1.b[2].mB.mA) && allOk;
	allOk = compare_uvec3(uvec3(6u, 9u, 4u), s1.b[2].mB.mB) && allOk;
	allOk = compare_bvec3(bvec3(false, false, true), s1.b[2].mB.mC) && allOk;
	allOk = compare_ivec4(ivec4(4, -4, 6, -9), s1.c.mA.mA.mA) && allOk;
	allOk = compare_uvec2(uvec2(9u, 4u), s1.c.mA.mA.mB) && allOk;
	allOk = compare_uvec3(uvec3(1u, 1u, 0u), s1.c.mA.mB) && allOk;
	allOk = compare_vec3(vec3(5.0, -7.0, -7.0), s1.c.mA.mC.mA) && allOk;
	allOk = compare_vec4(vec4(-4.0, 4.0, 3.0, -7.0), s1.c.mB.mA[0]) && allOk;
	allOk = compare_vec4(vec4(-6.0, 0.0, -6.0, 8.0), s1.c.mB.mA[1]) && allOk;
	allOk = compare_vec4(vec4(-9.0, 1.0, -7.0, 6.0), s1.c.mB.mA[2]) && allOk;
	allOk = compare_uvec3(uvec3(6u, 5u, 5u), s1.c.mB.mB[0]) && allOk;
	allOk = compare_uvec3(uvec3(0u, 8u, 0u), s1.c.mB.mB[1]) && allOk;
	allOk = compare_uvec3(uvec3(0u, 3u, 4u), s1.c.mB.mB[2]) && allOk;
	allOk = compare_ivec4(ivec4(9, 9, -5, 8), s1.c.mB.mC.mA) && allOk;
	allOk = compare_vec3(vec3(-7.0, -5.0, -3.0), s1.c.mB.mC.mB) && allOk;
	allOk = compare_ivec3(ivec3(0, -9, -8), s1.d.mA.mA[0]) && allOk;
	allOk = compare_ivec3(ivec3(-3, -5, 5), s1.d.mA.mA[1]) && allOk;
	allOk = compare_uvec3(uvec3(5u, 4u, 1u), s1.d.mA.mB.mA) && allOk;
	allOk = compare_bvec2(bvec2(true, false), s1.d.mA.mB.mB) && allOk;
	allOk = compare_ivec3(ivec3(6, 1, 6), s1.d.mB.mA.mA) && allOk;
	allOk = compare_vec3(vec3(3.0, 9.0, -5.0), s1.d.mB.mA.mB) && allOk;
	allOk = compare_ivec4(ivec4(2, 7, -8, -6), s1.d.mB.mA.mC) && allOk;
	allOk = compare_uvec4(uvec4(1u, 8u, 8u, 9u), s2.a.mA.mA.mA) && allOk;
	allOk = compare_vec3(vec3(-4.0, -8.0, -3.0), s2.a.mA.mA.mB) && allOk;
	allOk = compare_ivec2(ivec2(-4, -7), s2.a.mA.mA.mC) && allOk;
	allOk = compare_ivec2(ivec2(-3, -5), s2.a.mA.mB.mA) && allOk;
	allOk = compare_vec3(vec3(-7.0, -3.0, -6.0), s2.a.mA.mB.mB) && allOk;
	allOk = compare_vec2(vec2(1.0, -8.0), s2.a.mB[0].mA) && allOk;
	allOk = compare_ivec3(ivec3(2, -4, 8), s2.a.mB[0].mB) && allOk;
	allOk = compare_bvec4(bvec4(true, false, false, false), s2.a.mB[0].mC) && allOk;
	allOk = compare_vec2(vec2(7.0, -1.0), s2.a.mB[1].mA) && allOk;
	allOk = compare_ivec3(ivec3(9, -2, 4), s2.a.mB[1].mB) && allOk;
	allOk = compare_bvec4(bvec4(true, true, false, false), s2.a.mB[1].mC) && allOk;
	allOk = compare_vec2(vec2(-5.0, -3.0), s2.a.mB[2].mA) && allOk;
	allOk = compare_ivec3(ivec3(-5, -5, -9), s2.a.mB[2].mB) && allOk;
	allOk = compare_bvec4(bvec4(false, false, true, false), s2.a.mB[2].mC) && allOk;
	allOk = compare_float(-6.0, s2.b[0].mA.mA) && allOk;
	allOk = compare_ivec4(ivec4(9, -4, 5, -7), s2.b[0].mB.mA) && allOk;
	allOk = compare_uvec3(uvec3(5u, 8u, 9u), s2.b[0].mB.mB) && allOk;
	allOk = compare_vec3(vec3(-1.0, -2.0, 9.0), s2.b[0].mC[0]) && allOk;
	allOk = compare_ivec3(ivec3(-6, -5, 1), s2.c[0].mA.mA) && allOk;
	allOk = compare_uint(2u, s2.c[0].mA.mB) && allOk;
	allOk = compare_mat4x3(mat4x3(-8.0, 6.0, -3.0, 8.0, -6.0, 6.0, 2.0, -3.0, 0.0, -7.0, -7.0, 8.0), s2.c[0].mA.mC) && allOk;
	allOk = compare_mat4(mat4(6.0, -5.0, -2.0, -4.0, 1.0, 3.0, -5.0, 8.0, 6.0, 1.0, 5.0, 1.0, -9.0, 2.0, 2.0, 9.0), s2.c[0].mB.mA) && allOk;
	allOk = compare_ivec3(ivec3(5, -4, -4), s2.c[1].mA.mA) && allOk;
	allOk = compare_uint(0u, s2.c[1].mA.mB) && allOk;
	allOk = compare_mat4x3(mat4x3(1.0, 6.0, 8.0, -9.0, -3.0, -6.0, 8.0, -5.0, 2.0, -1.0, 3.0, -2.0), s2.c[1].mA.mC) && allOk;
	allOk = compare_mat4(mat4(1.0, -4.0, -5.0, -5.0, 0.0, 4.0, 7.0, 9.0, -2.0, -5.0, -3.0, 1.0, -9.0, -4.0, 5.0, -7.0), s2.c[1].mB.mA) && allOk;
	allOk = compare_ivec3(ivec3(-4, -6, -2), s2.c[2].mA.mA) && allOk;
	allOk = compare_uint(5u, s2.c[2].mA.mB) && allOk;
	allOk = compare_mat4x3(mat4x3(-4.0, 9.0, -4.0, 5.0, -2.0, -5.0, -5.0, -7.0, -8.0, 4.0, -4.0, -1.0), s2.c[2].mA.mC) && allOk;
	allOk = compare_mat4(mat4(-9.0, 9.0, 4.0, -2.0, -3.0, -6.0, -3.0, 1.0, -2.0, -2.0, -4.0, -3.0, 5.0, -4.0, -2.0, 5.0), s2.c[2].mB.mA) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	highp uvec3 mA;
};
struct sB
{
	bvec4 mA;
};
struct sC
{
	sA mA;
	sB mB;
};
struct sD
{
	mediump float mA[2];
	mediump ivec4 mB;
};
struct sE
{
	sD mA;
};
struct S1 {
	sC a[3];
	sE b;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

shared S1 s1;

void main (void) {
	s1.a[0].mA.mA = uvec3(2u, 5u, 1u);
	s1.a[0].mB.mA = bvec4(false, true, true, true);
	s1.a[1].mA.mA = uvec3(2u, 0u, 4u);
	s1.a[1].mB.mA = bvec4(true, true, false, false);
	s1.a[2].mA.mA = uvec3(4u, 2u, 8u);
	s1.a[2].mB.mA = bvec4(false, false, false, false);
	s1.b.mA.mA[0] = -3.0;
	s1.b.mA.mA[1] = 1.0;
	s1.b.mA.mB = ivec4(5, 6, 9, 0);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_uvec3(uvec3(2u, 5u, 1u), s1.a[0].mA.mA) && allOk;
	allOk = compare_bvec4(bvec4(false, true, true, true), s1.a[0].mB.mA) && allOk;
	allOk = compare_uvec3(uvec3(2u, 0u, 4u), s1.a[1].mA.mA) && allOk;
	allOk = compare_bvec4(bvec4(true, true, false, false), s1.a[1].mB.mA) && allOk;
	allOk = compare_uvec3(uvec3(4u, 2u, 8u), s1.a[2].mA.mA) && allOk;
	allOk = compare_bvec4(bvec4(false, false, false, false), s1.a[2].mB.mA) && allOk;
	allOk = compare_float(-3.0, s1.b.mA.mA[0]) && allOk;
	allOk = compare_float(1.0, s1.b.mA.mA[1]) && allOk;
	allOk = compare_ivec4(ivec4(5, 6, 9, 0), s1.b.mA.mB) && allOk;
	if (allOk)
		passed++;

}
#version 450
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	highp vec2 mA;
};
struct sB
{
	lowp vec3 mA;
	lowp float mB;
	highp vec2 mC;
};
struct sC
{
	sA mA[1];
	sB mB[2];
};
struct sD
{
	mediump mat4x3 mA;
};
struct sE
{
	sD mA;
};
struct sF
{
	bvec3 mA[3];
};
struct sG
{
	highp vec4 mA;
	highp ivec4 mB;
	highp mat2x3 mC;
};
struct sH
{
	mediump uvec4 mA[1];
	sG mB;
};
struct sI
{
	sE mA;
	sF mB;
	sH mC;
};
struct sJ
{
	highp uvec3 mA;
};
struct sK
{
	sJ mA;
};
struct sL
{
	bvec2 mA;
	lowp mat3 mB;
};
struct sM
{
	highp vec4 mA[3];
	sL mB;
	lowp uvec2 mC[3];
};
struct sN
{
	sM mA;
};
struct sO
{
	highp ivec2 mA;
	highp ivec2 mB;
};
struct sP
{
	sO mA;
	lowp mat4x2 mB[2];
	bvec4 mC;
};
struct sQ
{
	bvec3 mA;
	highp uint mB;
	highp vec4 mC;
};
struct sR
{
	sQ mA[1];
};
struct S1 {
	sC a;
	sI b;
	sK c[3];
	sN d;
};
struct S2 {
	sP a[3];
	sR b;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a.mA[0].mA = vec2(1.0, -3.0);
	s1.a.mB[0].mA = vec3(9.0, 7.0, -5.0);
	s1.a.mB[0].mB = 2.0;
	s1.a.mB[0].mC = vec2(-1.0, -8.0);
	s1.a.mB[1].mA = vec3(2.0, -6.0, 5.0);
	s1.a.mB[1].mB = -7.0;
	s1.a.mB[1].mC = vec2(2.0, 8.0);
	s1.b.mA.mA.mA = mat4x3(8.0, 6.0, -8.0, 7.0, -1.0, 2.0, 2.0, 6.0, 1.0, 1.0, 1.0, 6.0);
	s1.b.mB.mA[0] = bvec3(true, true, false);
	s1.b.mB.mA[1] = bvec3(true, true, true);
	s1.b.mB.mA[2] = bvec3(true, true, true);
	s1.b.mC.mA[0] = uvec4(6u, 9u, 2u, 3u);
	s1.b.mC.mB.mA = vec4(8.0, 0.0, 5.0, -7.0);
	s1.b.mC.mB.mB = ivec4(6, 6, 7, -7);
	s1.b.mC.mB.mC = mat2x3(6.0, -8.0, 5.0, 1.0, -4.0, 0.0);
	s1.c[0].mA.mA = uvec3(8u, 5u, 9u);
	s1.c[1].mA.mA = uvec3(5u, 8u, 1u);
	s1.c[2].mA.mA = uvec3(6u, 3u, 8u);
	s1.d.mA.mA[0] = vec4(-1.0, -4.0, 5.0, 1.0);
	s1.d.mA.mA[1] = vec4(-9.0, 8.0, 9.0, -6.0);
	s1.d.mA.mA[2] = vec4(-3.0, -4.0, 9.0, 9.0);
	s1.d.mA.mB.mA = bvec2(false, true);
	s1.d.mA.mB.mB = mat3(9.0, 5.0, -7.0, -3.0, -9.0, 5.0, 4.0, 2.0, 3.0);
	s1.d.mA.mC[0] = uvec2(2u, 9u);
	s1.d.mA.mC[1] = uvec2(3u, 1u);
	s1.d.mA.mC[2] = uvec2(5u, 0u);
	s2.a[0].mA.mA = ivec2(2, 2);
	s2.a[0].mA.mB = ivec2(3, -8);
	s2.a[0].mB[0] = mat4x2(-6.0, 3.0, -4.0, -6.0, 3.0, -5.0, 8.0, 3.0);
	s2.a[0].mB[1] = mat4x2(5.0, -6.0, 6.0, -1.0, -7.0, -8.0, 8.0, -2.0);
	s2.a[0].mC = bvec4(true, false, true, true);
	s2.a[1].mA.mA = ivec2(-1, -8);
	s2.a[1].mA.mB = ivec2(-1, -4);
	s2.a[1].mB[0] = mat4x2(-6.0, -9.0, -9.0, -1.0, -4.0, -7.0, -8.0, -4.0);
	s2.a[1].mB[1] = mat4x2(1.0, -3.0, -6.0, -6.0, 6.0, -5.0, 2.0, -1.0);
	s2.a[1].mC = bvec4(false, false, true, true);
	s2.a[2].mA.mA = ivec2(-6, -8);
	s2.a[2].mA.mB = ivec2(8, 1);
	s2.a[2].mB[0] = mat4x2(-4.0, 1.0, -9.0, -7.0, 2.0, -5.0, 0.0, -8.0);
	s2.a[2].mB[1] = mat4x2(1.0, -1.0, 5.0, 5.0, -1.0, 3.0, 0.0, -7.0);
	s2.a[2].mC = bvec4(false, true, false, false);
	s2.b.mA[0].mA = bvec3(true, false, false);
	s2.b.mA[0].mB = 4u;
	s2.b.mA[0].mC = vec4(0.0, -8.0, 1.0, -3.0);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_vec2(vec2(1.0, -3.0), s1.a.mA[0].mA) && allOk;
	allOk = compare_vec3(vec3(9.0, 7.0, -5.0), s1.a.mB[0].mA) && allOk;
	allOk = compare_float(2.0, s1.a.mB[0].mB) && allOk;
	allOk = compare_vec2(vec2(-1.0, -8.0), s1.a.mB[0].mC) && allOk;
	allOk = compare_vec3(vec3(2.0, -6.0, 5.0), s1.a.mB[1].mA) && allOk;
	allOk = compare_float(-7.0, s1.a.mB[1].mB) && allOk;
	allOk = compare_vec2(vec2(2.0, 8.0), s1.a.mB[1].mC) && allOk;
	allOk = compare_mat4x3(mat4x3(8.0, 6.0, -8.0, 7.0, -1.0, 2.0, 2.0, 6.0, 1.0, 1.0, 1.0, 6.0), s1.b.mA.mA.mA) && allOk;
	allOk = compare_bvec3(bvec3(true, true, false), s1.b.mB.mA[0]) && allOk;
	allOk = compare_bvec3(bvec3(true, true, true), s1.b.mB.mA[1]) && allOk;
	allOk = compare_bvec3(bvec3(true, true, true), s1.b.mB.mA[2]) && allOk;
	allOk = compare_uvec4(uvec4(6u, 9u, 2u, 3u), s1.b.mC.mA[0]) && allOk;
	allOk = compare_vec4(vec4(8.0, 0.0, 5.0, -7.0), s1.b.mC.mB.mA) && allOk;
	allOk = compare_ivec4(ivec4(6, 6, 7, -7), s1.b.mC.mB.mB) && allOk;
	allOk = compare_mat2x3(mat2x3(6.0, -8.0, 5.0, 1.0, -4.0, 0.0), s1.b.mC.mB.mC) && allOk;
	allOk = compare_uvec3(uvec3(8u, 5u, 9u), s1.c[0].mA.mA) && allOk;
	allOk = compare_uvec3(uvec3(5u, 8u, 1u), s1.c[1].mA.mA) && allOk;
	allOk = compare_uvec3(uvec3(6u, 3u, 8u), s1.c[2].mA.mA) && allOk;
	allOk = compare_vec4(vec4(-1.0, -4.0, 5.0, 1.0), s1.d.mA.mA[0]) && allOk;
	allOk = compare_vec4(vec4(-9.0, 8.0, 9.0, -6.0), s1.d.mA.mA[1]) && allOk;
	allOk = compare_vec4(vec4(-3.0, -4.0, 9.0, 9.0), s1.d.mA.mA[2]) && allOk;
	allOk = compare_bvec2(bvec2(false, true), s1.d.mA.mB.mA) && allOk;
	allOk = compare_mat3(mat3(9.0, 5.0, -7.0, -3.0, -9.0, 5.0, 4.0, 2.0, 3.0), s1.d.mA.mB.mB) && allOk;
	allOk = compare_uvec2(uvec2(2u, 9u), s1.d.mA.mC[0]) && allOk;
	allOk = compare_uvec2(uvec2(3u, 1u), s1.d.mA.mC[1]) && allOk;
	allOk = compare_uvec2(uvec2(5u, 0u), s1.d.mA.mC[2]) && allOk;
	allOk = compare_ivec2(ivec2(2, 2), s2.a[0].mA.mA) && allOk;
	allOk = compare_ivec2(ivec2(3, -8), s2.a[0].mA.mB) && allOk;
	allOk = compare_mat4x2(mat4x2(-6.0, 3.0, -4.0, -6.0, 3.0, -5.0, 8.0, 3.0), s2.a[0].mB[0]) && allOk;
	allOk = compare_mat4x2(mat4x2(5.0, -6.0, 6.0, -1.0, -7.0, -8.0, 8.0, -2.0), s2.a[0].mB[1]) && allOk;
	allOk = compare_bvec4(bvec4(true, false, true, true), s2.a[0].mC) && allOk;
	allOk = compare_ivec2(ivec2(-1, -8), s2.a[1].mA.mA) && allOk;
	allOk = compare_ivec2(ivec2(-1, -4), s2.a[1].mA.mB) && allOk;
	allOk = compare_mat4x2(mat4x2(-6.0, -9.0, -9.0, -1.0, -4.0, -7.0, -8.0, -4.0), s2.a[1].mB[0]) && allOk;
	allOk = compare_mat4x2(mat4x2(1.0, -3.0, -6.0, -6.0, 6.0, -5.0, 2.0, -1.0), s2.a[1].mB[1]) && allOk;
	allOk = compare_bvec4(bvec4(false, false, true, true), s2.a[1].mC) && allOk;
	allOk = compare_ivec2(ivec2(-6, -8), s2.a[2].mA.mA) && allOk;
	allOk = compare_ivec2(ivec2(8, 1), s2.a[2].mA.mB) && allOk;
	allOk = compare_mat4x2(mat4x2(-4.0, 1.0, -9.0, -7.0, 2.0, -5.0, 0.0, -8.0), s2.a[2].mB[0]) && allOk;
	allOk = compare_mat4x2(mat4x2(1.0, -1.0, 5.0, 5.0, -1.0, 3.0, 0.0, -7.0), s2.a[2].mB[1]) && allOk;
	allOk = compare_bvec4(bvec4(false, true, false, false), s2.a[2].mC) && allOk;
	allOk = compare_bvec3(bvec3(true, false, false), s2.b.mA[0].mA) && allOk;
	allOk = compare_uint(4u, s2.b.mA[0].mB) && allOk;
	allOk = compare_vec4(vec4(0.0, -8.0, 1.0, -3.0), s2.b.mA[0].mC) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	lowp float a;
	float16_t b;
};
struct S2 {
	int16_t a;
	mediump int b;
	uint16_t c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a = 6.0;
	s1.b = float16_t(8.0);
	s2.a = int16_t(8);
	s2.b = 0;
	s2.c = uint16_t(4u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_float(6.0, s1.a) && allOk;
	allOk = compare_float16_t(float(8.0), float(s1.b)) && allOk;
	allOk = compare_int16_t(int(8), int(s2.a)) && allOk;
	allOk = compare_int(0, s2.b) && allOk;
	allOk = compare_uint16_t(uint(4u), uint(s2.c)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	uint16_t a;
	int16_t b;
};
struct S2 {
	float16_t a;
	float16_t b;
	highp float c;
};
struct S3 {
	int16_t a;
	int16_t b;
	bool c;
	lowp float d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

shared S1 s1;
shared S2 s2;
shared S3 s3;

void main (void) {
	s1.a = uint16_t(3u);
	s1.b = int16_t(6);
	s2.a = float16_t(-6.0);
	s2.b = float16_t(-3.0);
	s2.c = -1.0;
	s3.a = int16_t(-9);
	s3.b = int16_t(5);
	s3.c = true;
	s3.d = -9.0;

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_uint16_t(uint(3u), uint(s1.a)) && allOk;
	allOk = compare_int16_t(int(6), int(s1.b)) && allOk;
	allOk = compare_float16_t(float(-6.0), float(s2.a)) && allOk;
	allOk = compare_float16_t(float(-3.0), float(s2.b)) && allOk;
	allOk = compare_float(-1.0, s2.c) && allOk;
	allOk = compare_int16_t(int(-9), int(s3.a)) && allOk;
	allOk = compare_int16_t(int(5), int(s3.b)) && allOk;
	allOk = compare_bool(true, s3.c) && allOk;
	allOk = compare_float(-9.0, s3.d) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	uint16_t a;
	uint16_t b;
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

shared S1 s1;

void main (void) {
	s1.a = uint16_t(8u);
	s1.b = uint16_t(0u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_uint16_t(uint(8u), uint(s1.a)) && allOk;
	allOk = compare_uint16_t(uint(0u), uint(s1.b)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	int16_t a;
	mediump uint b;
	highp uint c;
};
struct S2 {
	int16_t a;
	uint16_t b;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a = int16_t(1);
	s1.b = 9u;
	s1.c = 8u;
	s2.a = int16_t(-5);
	s2.b = uint16_t(3u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_int16_t(int(1), int(s1.a)) && allOk;
	allOk = compare_uint(9u, s1.b) && allOk;
	allOk = compare_uint(8u, s1.c) && allOk;
	allOk = compare_int16_t(int(-5), int(s2.a)) && allOk;
	allOk = compare_uint16_t(uint(3u), uint(s2.b)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	int16_t a;
	int16_t b;
	float16_t c;
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

shared S1 s1;

void main (void) {
	s1.a = int16_t(2);
	s1.b = int16_t(7);
	s1.c = float16_t(-9.0);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_int16_t(int(2), int(s1.a)) && allOk;
	allOk = compare_int16_t(int(7), int(s1.b)) && allOk;
	allOk = compare_float16_t(float(-9.0), float(s1.c)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	highp uint a;
	int16_t b;
	mediump int c;
};
struct S2 {
	int16_t a;
	int16_t b;
	float16_t c;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a = 7u;
	s1.b = int16_t(-3);
	s1.c = 2;
	s2.a = int16_t(-4);
	s2.b = int16_t(4);
	s2.c = float16_t(6.0);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_uint(7u, s1.a) && allOk;
	allOk = compare_int16_t(int(-3), int(s1.b)) && allOk;
	allOk = compare_int(2, s1.c) && allOk;
	allOk = compare_int16_t(int(-4), int(s2.a)) && allOk;
	allOk = compare_int16_t(int(4), int(s2.b)) && allOk;
	allOk = compare_float16_t(float(6.0), float(s2.c)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	bool a;
	lowp int b;
	int16_t c;
};
struct S2 {
	int16_t a;
	uint16_t b;
	int16_t c;
	uint16_t d;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a = true;
	s1.b = 6;
	s1.c = int16_t(6);
	s2.a = int16_t(-7);
	s2.b = uint16_t(3u);
	s2.c = int16_t(5);
	s2.d = uint16_t(4u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_bool(true, s1.a) && allOk;
	allOk = compare_int(6, s1.b) && allOk;
	allOk = compare_int16_t(int(6), int(s1.c)) && allOk;
	allOk = compare_int16_t(int(-7), int(s2.a)) && allOk;
	allOk = compare_uint16_t(uint(3u), uint(s2.b)) && allOk;
	allOk = compare_int16_t(int(5), int(s2.c)) && allOk;
	allOk = compare_uint16_t(uint(4u), uint(s2.d)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	int16_t a;
	bool b;
	uint16_t c;
	mediump uint d;
};
struct S2 {
	uint16_t a;
	lowp float b;
	float16_t c;
	uint16_t d;
};
struct S3 {
	float16_t a;
	int16_t b;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

shared S1 s1;
shared S2 s2;
shared S3 s3;

void main (void) {
	s1.a = int16_t(-5);
	s1.b = true;
	s1.c = uint16_t(3u);
	s1.d = 1u;
	s2.a = uint16_t(4u);
	s2.b = -5.0;
	s2.c = float16_t(7.0);
	s2.d = uint16_t(0u);
	s3.a = float16_t(0.0);
	s3.b = int16_t(5);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_int16_t(int(-5), int(s1.a)) && allOk;
	allOk = compare_bool(true, s1.b) && allOk;
	allOk = compare_uint16_t(uint(3u), uint(s1.c)) && allOk;
	allOk = compare_uint(1u, s1.d) && allOk;
	allOk = compare_uint16_t(uint(4u), uint(s2.a)) && allOk;
	allOk = compare_float(-5.0, s2.b) && allOk;
	allOk = compare_float16_t(float(7.0), float(s2.c)) && allOk;
	allOk = compare_uint16_t(uint(0u), uint(s2.d)) && allOk;
	allOk = compare_float16_t(float(0.0), float(s3.a)) && allOk;
	allOk = compare_int16_t(int(5), int(s3.b)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	int16_t a;
	float16_t b;
	float16_t c;
	lowp int d;
};
struct S2 {
	highp uint a;
	uint16_t b;
	float16_t c;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a = int16_t(1);
	s1.b = float16_t(-6.0);
	s1.c = float16_t(-5.0);
	s1.d = 7;
	s2.a = 5u;
	s2.b = uint16_t(7u);
	s2.c = float16_t(4.0);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_int16_t(int(1), int(s1.a)) && allOk;
	allOk = compare_float16_t(float(-6.0), float(s1.b)) && allOk;
	allOk = compare_float16_t(float(-5.0), float(s1.c)) && allOk;
	allOk = compare_int(7, s1.d) && allOk;
	allOk = compare_uint(5u, s2.a) && allOk;
	allOk = compare_uint16_t(uint(7u), uint(s2.b)) && allOk;
	allOk = compare_float16_t(float(4.0), float(s2.c)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	uint16_t a;
	int16_t b;
	uint16_t c;
	int16_t d;
};
struct S2 {
	float16_t a;
	uint16_t b;
	uint16_t c;
	uint16_t d;
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a = uint16_t(5u);
	s1.b = int16_t(-3);
	s1.c = uint16_t(4u);
	s1.d = int16_t(7);
	s2.a = float16_t(-5.0);
	s2.b = uint16_t(3u);
	s2.c = uint16_t(5u);
	s2.d = uint16_t(0u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_uint16_t(uint(5u), uint(s1.a)) && allOk;
	allOk = compare_int16_t(int(-3), int(s1.b)) && allOk;
	allOk = compare_uint16_t(uint(4u), uint(s1.c)) && allOk;
	allOk = compare_int16_t(int(7), int(s1.d)) && allOk;
	allOk = compare_float16_t(float(-5.0), float(s2.a)) && allOk;
	allOk = compare_uint16_t(uint(3u), uint(s2.b)) && allOk;
	allOk = compare_uint16_t(uint(5u), uint(s2.c)) && allOk;
	allOk = compare_uint16_t(uint(0u), uint(s2.d)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	i16vec3 a;
	lowp vec3 b;
	lowp vec4 c;
	i16vec3 d;
};
struct S2 {
	highp uvec2 a;
	i16vec3 b;
	f16vec3 c;
	bvec3 d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a = i16vec3(6, 8, 8);
	s1.b = vec3(0.0, -4.0, -5.0);
	s1.c = vec4(9.0, -4.0, -6.0, -1.0);
	s1.d = i16vec3(-1, -2, 1);
	s2.a = uvec2(3u, 8u);
	s2.b = i16vec3(7, -2, -4);
	s2.c = f16vec3(-9.0, 8.0, 3.0);
	s2.d = bvec3(true, false, false);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_i16vec3(ivec3(6, 8, 8), ivec3(s1.a)) && allOk;
	allOk = compare_vec3(vec3(0.0, -4.0, -5.0), s1.b) && allOk;
	allOk = compare_vec4(vec4(9.0, -4.0, -6.0, -1.0), s1.c) && allOk;
	allOk = compare_i16vec3(ivec3(-1, -2, 1), ivec3(s1.d)) && allOk;
	allOk = compare_uvec2(uvec2(3u, 8u), s2.a) && allOk;
	allOk = compare_i16vec3(ivec3(7, -2, -4), ivec3(s2.b)) && allOk;
	allOk = compare_f16vec3(vec3(-9.0, 8.0, 3.0), vec3(s2.c)) && allOk;
	allOk = compare_bvec3(bvec3(true, false, false), s2.d) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	mediump uvec4 a;
	float16_t b;
};
struct S2 {
	float16_t a;
	i16vec3 b;
	lowp uvec2 c;
	i16vec3 d;
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a = uvec4(3u, 0u, 3u, 0u);
	s1.b = float16_t(-1.0);
	s2.a = float16_t(-9.0);
	s2.b = i16vec3(5, -7, -9);
	s2.c = uvec2(6u, 9u);
	s2.d = i16vec3(-8, 8, -8);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_uvec4(uvec4(3u, 0u, 3u, 0u), s1.a) && allOk;
	allOk = compare_float16_t(float(-1.0), float(s1.b)) && allOk;
	allOk = compare_float16_t(float(-9.0), float(s2.a)) && allOk;
	allOk = compare_i16vec3(ivec3(5, -7, -9), ivec3(s2.b)) && allOk;
	allOk = compare_uvec2(uvec2(6u, 9u), s2.c) && allOk;
	allOk = compare_i16vec3(ivec3(-8, 8, -8), ivec3(s2.d)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	i16vec3 a;
	i16vec4 b;
	f16vec2 c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

shared S1 s1;

void main (void) {
	s1.a = i16vec3(0, 2, -8);
	s1.b = i16vec4(6, 7, 5, -6);
	s1.c = f16vec2(1.0, 9.0);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_i16vec3(ivec3(0, 2, -8), ivec3(s1.a)) && allOk;
	allOk = compare_i16vec4(ivec4(6, 7, 5, -6), ivec4(s1.b)) && allOk;
	allOk = compare_f16vec2(vec2(1.0, 9.0), vec2(s1.c)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	float16_t a;
	u16vec3 b;
	f16vec2 c;
	u16vec4 d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

shared S1 s1;

void main (void) {
	s1.a = float16_t(1.0);
	s1.b = u16vec3(9u, 8u, 5u);
	s1.c = f16vec2(1.0, -7.0);
	s1.d = u16vec4(8u, 6u, 2u, 7u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_float16_t(float(1.0), float(s1.a)) && allOk;
	allOk = compare_u16vec3(uvec3(9u, 8u, 5u), uvec3(s1.b)) && allOk;
	allOk = compare_f16vec2(vec2(1.0, -7.0), vec2(s1.c)) && allOk;
	allOk = compare_u16vec4(uvec4(8u, 6u, 2u, 7u), uvec4(s1.d)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	i16vec2 a;
	f16vec4 b;
	uint16_t c;
	f16vec3 d;
};
struct S2 {
	int16_t a;
	i16vec4 b;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a = i16vec2(2, 7);
	s1.b = f16vec4(-9.0, 3.0, 0.0, -7.0);
	s1.c = uint16_t(6u);
	s1.d = f16vec3(-2.0, 3.0, 9.0);
	s2.a = int16_t(1);
	s2.b = i16vec4(-5, -2, 0, 9);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_i16vec2(ivec2(2, 7), ivec2(s1.a)) && allOk;
	allOk = compare_f16vec4(vec4(-9.0, 3.0, 0.0, -7.0), vec4(s1.b)) && allOk;
	allOk = compare_uint16_t(uint(6u), uint(s1.c)) && allOk;
	allOk = compare_f16vec3(vec3(-2.0, 3.0, 9.0), vec3(s1.d)) && allOk;
	allOk = compare_int16_t(int(1), int(s2.a)) && allOk;
	allOk = compare_i16vec4(ivec4(-5, -2, 0, 9), ivec4(s2.b)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	u16vec2 a;
	i16vec4 b;
	i16vec4 c;
};
struct S2 {
	f16vec4 a;
	lowp uint b;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a = u16vec2(7u, 1u);
	s1.b = i16vec4(2, -4, 4, 6);
	s1.c = i16vec4(-2, -5, -3, -3);
	s2.a = f16vec4(1.0, -3.0, 8.0, 7.0);
	s2.b = 8u;

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_u16vec2(uvec2(7u, 1u), uvec2(s1.a)) && allOk;
	allOk = compare_i16vec4(ivec4(2, -4, 4, 6), ivec4(s1.b)) && allOk;
	allOk = compare_i16vec4(ivec4(-2, -5, -3, -3), ivec4(s1.c)) && allOk;
	allOk = compare_f16vec4(vec4(1.0, -3.0, 8.0, 7.0), vec4(s2.a)) && allOk;
	allOk = compare_uint(8u, s2.b) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	i16vec2 a;
	int16_t b;
	f16vec3 c;
	i16vec3 d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

shared S1 s1;

void main (void) {
	s1.a = i16vec2(-4, 6);
	s1.b = int16_t(6);
	s1.c = f16vec3(-7.0, -9.0, 5.0);
	s1.d = i16vec3(-4, -9, 8);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_i16vec2(ivec2(-4, 6), ivec2(s1.a)) && allOk;
	allOk = compare_int16_t(int(6), int(s1.b)) && allOk;
	allOk = compare_f16vec3(vec3(-7.0, -9.0, 5.0), vec3(s1.c)) && allOk;
	allOk = compare_i16vec3(ivec3(-4, -9, 8), ivec3(s1.d)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	u16vec3 a;
	f16vec4 b;
	int16_t c;
	u16vec3 d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

shared S1 s1;

void main (void) {
	s1.a = u16vec3(5u, 7u, 3u);
	s1.b = f16vec4(-9.0, 9.0, -5.0, 7.0);
	s1.c = int16_t(7);
	s1.d = u16vec3(5u, 9u, 0u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_u16vec3(uvec3(5u, 7u, 3u), uvec3(s1.a)) && allOk;
	allOk = compare_f16vec4(vec4(-9.0, 9.0, -5.0, 7.0), vec4(s1.b)) && allOk;
	allOk = compare_int16_t(int(7), int(s1.c)) && allOk;
	allOk = compare_u16vec3(uvec3(5u, 9u, 0u), uvec3(s1.d)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	mediump float a;
	int16_t b;
	u16vec4 c;
	mediump uint d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

shared S1 s1;

void main (void) {
	s1.a = 1.0;
	s1.b = int16_t(-6);
	s1.c = u16vec4(1u, 9u, 5u, 7u);
	s1.d = 9u;

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_float(1.0, s1.a) && allOk;
	allOk = compare_int16_t(int(-6), int(s1.b)) && allOk;
	allOk = compare_u16vec4(uvec4(1u, 9u, 5u, 7u), uvec4(s1.c)) && allOk;
	allOk = compare_uint(9u, s1.d) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	u16vec4 a;
	int16_t b;
	bool c;
	int16_t d;
};

bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

shared S1 s1;

void main (void) {
	s1.a = u16vec4(5u, 7u, 4u, 7u);
	s1.b = int16_t(-5);
	s1.c = false;
	s1.d = int16_t(-1);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_u16vec4(uvec4(5u, 7u, 4u, 7u), uvec4(s1.a)) && allOk;
	allOk = compare_int16_t(int(-5), int(s1.b)) && allOk;
	allOk = compare_bool(false, s1.c) && allOk;
	allOk = compare_int16_t(int(-1), int(s1.d)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	f16vec4 a;
	highp mat2 b;
	u16vec4 c;
	u16vec3 d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

shared S1 s1;

void main (void) {
	s1.a = f16vec4(6.0, 8.0, 8.0, 0.0);
	s1.b = mat2(-4.0, -5.0, 9.0, -4.0);
	s1.c = u16vec4(5u, 6u, 7u, 4u);
	s1.d = u16vec3(1u, 3u, 8u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_f16vec4(vec4(6.0, 8.0, 8.0, 0.0), vec4(s1.a)) && allOk;
	allOk = compare_mat2(mat2(-4.0, -5.0, 9.0, -4.0), s1.b) && allOk;
	allOk = compare_u16vec4(uvec4(5u, 6u, 7u, 4u), uvec4(s1.c)) && allOk;
	allOk = compare_u16vec3(uvec3(1u, 3u, 8u), uvec3(s1.d)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	f16vec4 a;
	uint16_t b;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

shared S1 s1;

void main (void) {
	s1.a = f16vec4(6.0, 6.0, -6.0, -3.0);
	s1.b = uint16_t(4u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_f16vec4(vec4(6.0, 6.0, -6.0, -3.0), vec4(s1.a)) && allOk;
	allOk = compare_uint16_t(uint(4u), uint(s1.b)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	i16vec4 a;
	f16vec2 b;
	u16vec4 c;
	f16vec2 d;
};
struct S2 {
	int16_t a;
	f16vec2 b;
	mediump ivec2 c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a = i16vec4(0, 2, -8, 6);
	s1.b = f16vec2(7.0, 5.0);
	s1.c = u16vec4(5u, 2u, 5u, 1u);
	s1.d = f16vec2(-3.0, 4.0);
	s2.a = int16_t(4);
	s2.b = f16vec2(9.0, -9.0);
	s2.c = ivec2(-8, -9);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_i16vec4(ivec4(0, 2, -8, 6), ivec4(s1.a)) && allOk;
	allOk = compare_f16vec2(vec2(7.0, 5.0), vec2(s1.b)) && allOk;
	allOk = compare_u16vec4(uvec4(5u, 2u, 5u, 1u), uvec4(s1.c)) && allOk;
	allOk = compare_f16vec2(vec2(-3.0, 4.0), vec2(s1.d)) && allOk;
	allOk = compare_int16_t(int(4), int(s2.a)) && allOk;
	allOk = compare_f16vec2(vec2(9.0, -9.0), vec2(s2.b)) && allOk;
	allOk = compare_ivec2(ivec2(-8, -9), s2.c) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	mediump mat3x4 a;
	f16vec4 b;
	lowp float c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

shared S1 s1;

void main (void) {
	s1.a = mat3x4(1.0, -5.0, -9.0, -5.0, 1.0, -7.0, 1.0, 2.0, 8.0, 7.0, 9.0, -8.0);
	s1.b = f16vec4(2.0, 9.0, 6.0, -5.0);
	s1.c = 7.0;

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_mat3x4(mat3x4(1.0, -5.0, -9.0, -5.0, 1.0, -7.0, 1.0, 2.0, 8.0, 7.0, 9.0, -8.0), s1.a) && allOk;
	allOk = compare_f16vec4(vec4(2.0, 9.0, 6.0, -5.0), vec4(s1.b)) && allOk;
	allOk = compare_float(7.0, s1.c) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	u16vec4 a;
	float16_t b;
};
struct S2 {
	mediump mat3x4 a;
	f16vec3 b;
	f16vec4 c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a = u16vec4(4u, 3u, 5u, 9u);
	s1.b = float16_t(0.0);
	s2.a = mat3x4(-7.0, 7.0, -2.0, 3.0, 9.0, 1.0, -5.0, -2.0, 0.0, 9.0, -1.0, -9.0);
	s2.b = f16vec3(-6.0, -9.0, 6.0);
	s2.c = f16vec4(1.0, -6.0, 0.0, 2.0);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_u16vec4(uvec4(4u, 3u, 5u, 9u), uvec4(s1.a)) && allOk;
	allOk = compare_float16_t(float(0.0), float(s1.b)) && allOk;
	allOk = compare_mat3x4(mat3x4(-7.0, 7.0, -2.0, 3.0, 9.0, 1.0, -5.0, -2.0, 0.0, 9.0, -1.0, -9.0), s2.a) && allOk;
	allOk = compare_f16vec3(vec3(-6.0, -9.0, 6.0), vec3(s2.b)) && allOk;
	allOk = compare_f16vec4(vec4(1.0, -6.0, 0.0, 2.0), vec4(s2.c)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	lowp mat3x4 a;
	bvec3 b;
	mediump vec3 c;
	mediump vec2 d;
};
struct S2 {
	uint16_t a;
	i16vec4 b;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a = mat3x4(2.0, -3.0, 2.0, -4.0, 4.0, 6.0, -2.0, -5.0, -3.0, -3.0, 1.0, -3.0);
	s1.b = bvec3(false, true, false);
	s1.c = vec3(3.0, -4.0, 8.0);
	s1.d = vec2(-7.0, -9.0);
	s2.a = uint16_t(8u);
	s2.b = i16vec4(4, -3, -7, -7);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_mat3x4(mat3x4(2.0, -3.0, 2.0, -4.0, 4.0, 6.0, -2.0, -5.0, -3.0, -3.0, 1.0, -3.0), s1.a) && allOk;
	allOk = compare_bvec3(bvec3(false, true, false), s1.b) && allOk;
	allOk = compare_vec3(vec3(3.0, -4.0, 8.0), s1.c) && allOk;
	allOk = compare_vec2(vec2(-7.0, -9.0), s1.d) && allOk;
	allOk = compare_uint16_t(uint(8u), uint(s2.a)) && allOk;
	allOk = compare_i16vec4(ivec4(4, -3, -7, -7), ivec4(s2.b)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	i16vec3 a;
	u16vec3 b;
	mediump uvec4 c;
	bvec4 d;
};

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

shared S1 s1;

void main (void) {
	s1.a = i16vec3(-4, 6, 6);
	s1.b = u16vec3(5u, 3u, 2u);
	s1.c = uvec4(4u, 7u, 0u, 3u);
	s1.d = bvec4(true, true, false, true);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_i16vec3(ivec3(-4, 6, 6), ivec3(s1.a)) && allOk;
	allOk = compare_u16vec3(uvec3(5u, 3u, 2u), uvec3(s1.b)) && allOk;
	allOk = compare_uvec4(uvec4(4u, 7u, 0u, 3u), s1.c) && allOk;
	allOk = compare_bvec4(bvec4(true, true, false, true), s1.d) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	f16vec2 a;
	highp uint b;
	bool c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

shared S1 s1;

void main (void) {
	s1.a = f16vec2(-5.0, 5.0);
	s1.b = 3u;
	s1.c = true;

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_f16vec2(vec2(-5.0, 5.0), vec2(s1.a)) && allOk;
	allOk = compare_uint(3u, s1.b) && allOk;
	allOk = compare_bool(true, s1.c) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	f16vec3 a;
	f16vec4 b;
	mediump uvec3 c;
	uint16_t d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

shared S1 s1;

void main (void) {
	s1.a = f16vec3(1.0, -6.0, -5.0);
	s1.b = f16vec4(7.0, 2.0, -1.0, 4.0);
	s1.c = uvec3(2u, 0u, 4u);
	s1.d = uint16_t(5u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_f16vec3(vec3(1.0, -6.0, -5.0), vec3(s1.a)) && allOk;
	allOk = compare_f16vec4(vec4(7.0, 2.0, -1.0, 4.0), vec4(s1.b)) && allOk;
	allOk = compare_uvec3(uvec3(2u, 0u, 4u), s1.c) && allOk;
	allOk = compare_uint16_t(uint(5u), uint(s1.d)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	lowp ivec3 a;
	f16vec4 b;
	float16_t c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

shared S1 s1;

void main (void) {
	s1.a = ivec3(1, -3, 9);
	s1.b = f16vec4(7.0, -5.0, 2.0, -1.0);
	s1.c = float16_t(-8.0);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_ivec3(ivec3(1, -3, 9), s1.a) && allOk;
	allOk = compare_f16vec4(vec4(7.0, -5.0, 2.0, -1.0), vec4(s1.b)) && allOk;
	allOk = compare_float16_t(float(-8.0), float(s1.c)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	f16vec4 a[3];
	u16vec3 b[1];
	uint16_t c[3];
	mediump mat3x2 d[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

shared S1 s1;

void main (void) {
	s1.a[0] = f16vec4(6.0, 8.0, 8.0, 0.0);
	s1.a[1] = f16vec4(-4.0, -5.0, 9.0, -4.0);
	s1.a[2] = f16vec4(-6.0, -1.0, -1.0, -2.0);
	s1.b[0] = u16vec3(1u, 3u, 8u);
	s1.c[0] = uint16_t(2u);
	s1.c[1] = uint16_t(3u);
	s1.c[2] = uint16_t(1u);
	s1.d[0] = mat3x2(-9.0, 8.0, 3.0, 0.0, 2.0, 1.0);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_f16vec4(vec4(6.0, 8.0, 8.0, 0.0), vec4(s1.a[0])) && allOk;
	allOk = compare_f16vec4(vec4(-4.0, -5.0, 9.0, -4.0), vec4(s1.a[1])) && allOk;
	allOk = compare_f16vec4(vec4(-6.0, -1.0, -1.0, -2.0), vec4(s1.a[2])) && allOk;
	allOk = compare_u16vec3(uvec3(1u, 3u, 8u), uvec3(s1.b[0])) && allOk;
	allOk = compare_uint16_t(uint(2u), uint(s1.c[0])) && allOk;
	allOk = compare_uint16_t(uint(3u), uint(s1.c[1])) && allOk;
	allOk = compare_uint16_t(uint(1u), uint(s1.c[2])) && allOk;
	allOk = compare_mat3x2(mat3x2(-9.0, 8.0, 3.0, 0.0, 2.0, 1.0), s1.d[0]) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	lowp mat2x3 a[1];
	highp float b[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

shared S1 s1;

void main (void) {
	s1.a[0] = mat2x3(6.0, 6.0, -6.0, -3.0, -1.0, -9.0);
	s1.b[0] = 5.0;
	s1.b[1] = -7.0;

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_mat2x3(mat2x3(6.0, 6.0, -6.0, -3.0, -1.0, -9.0), s1.a[0]) && allOk;
	allOk = compare_float(5.0, s1.b[0]) && allOk;
	allOk = compare_float(-7.0, s1.b[1]) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	i16vec2 a[2];
	uint16_t b[2];
	mediump int c[1];
	mediump uint d[2];
};
struct S2 {
	f16vec4 a;
	uint16_t b;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a[0] = i16vec2(0, 2);
	s1.a[1] = i16vec2(-8, 6);
	s1.b[0] = uint16_t(2u);
	s1.b[1] = uint16_t(5u);
	s1.c[0] = -6;
	s1.d[0] = 2u;
	s1.d[1] = 5u;
	s2.a = f16vec4(-4.0, -3.0, 4.0, 4.0);
	s2.b = uint16_t(0u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_i16vec2(ivec2(0, 2), ivec2(s1.a[0])) && allOk;
	allOk = compare_i16vec2(ivec2(-8, 6), ivec2(s1.a[1])) && allOk;
	allOk = compare_uint16_t(uint(2u), uint(s1.b[0])) && allOk;
	allOk = compare_uint16_t(uint(5u), uint(s1.b[1])) && allOk;
	allOk = compare_int(-6, s1.c[0]) && allOk;
	allOk = compare_uint(2u, s1.d[0]) && allOk;
	allOk = compare_uint(5u, s1.d[1]) && allOk;
	allOk = compare_f16vec4(vec4(-4.0, -3.0, 4.0, 4.0), vec4(s2.a)) && allOk;
	allOk = compare_uint16_t(uint(0u), uint(s2.b)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	mediump vec3 a[1];
	int16_t b[3];
	highp int c[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

shared S1 s1;

void main (void) {
	s1.a[0] = vec3(1.0, -5.0, -9.0);
	s1.b[0] = int16_t(-5);
	s1.b[1] = int16_t(1);
	s1.b[2] = int16_t(-7);
	s1.c[0] = 1;
	s1.c[1] = 2;
	s1.c[2] = 8;

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_vec3(vec3(1.0, -5.0, -9.0), s1.a[0]) && allOk;
	allOk = compare_int16_t(int(-5), int(s1.b[0])) && allOk;
	allOk = compare_int16_t(int(1), int(s1.b[1])) && allOk;
	allOk = compare_int16_t(int(-7), int(s1.b[2])) && allOk;
	allOk = compare_int(1, s1.c[0]) && allOk;
	allOk = compare_int(2, s1.c[1]) && allOk;
	allOk = compare_int(8, s1.c[2]) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	highp uvec2 a[1];
	i16vec2 b[3];
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

shared S1 s1;

void main (void) {
	s1.a[0] = uvec2(4u, 3u);
	s1.b[0] = i16vec2(-9, 3);
	s1.b[1] = i16vec2(0, -7);
	s1.b[2] = i16vec2(7, -2);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_uvec2(uvec2(4u, 3u), s1.a[0]) && allOk;
	allOk = compare_i16vec2(ivec2(-9, 3), ivec2(s1.b[0])) && allOk;
	allOk = compare_i16vec2(ivec2(0, -7), ivec2(s1.b[1])) && allOk;
	allOk = compare_i16vec2(ivec2(7, -2), ivec2(s1.b[2])) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	bvec4 a[2];
	f16vec2 b[3];
	f16vec2 c[1];
	i16vec4 d[3];
};
struct S2 {
	lowp mat4 a[3];
	uint16_t b;
};
struct S3 {
	i16vec2 a;
	uint16_t b[2];
	i16vec4 c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

shared S1 s1;
shared S2 s2;
shared S3 s3;

void main (void) {
	s1.a[0] = bvec4(true, false, false, false);
	s1.a[1] = bvec4(true, true, false, false);
	s1.b[0] = f16vec2(-3.0, -3.0);
	s1.b[1] = f16vec2(1.0, -3.0);
	s1.b[2] = f16vec2(8.0, 7.0);
	s1.c[0] = f16vec2(3.0, 3.0);
	s1.d[0] = i16vec4(-4, 8, -7, -9);
	s1.d[1] = i16vec4(-3, 4, -3, -7);
	s1.d[2] = i16vec4(-7, -1, 9, -6);
	s2.a[0] = mat4(8.0, -4.0, 4.0, 1.0, -6.0, -2.0, -3.0, -5.0, 4.0, 3.0, 0.0, 6.0, -1.0, -8.0, -3.0, -6.0);
	s2.a[1] = mat4(1.0, 7.0, 6.0, -5.0, -9.0, 2.0, 9.0, 7.0, 3.0, 6.0, 2.0, 0.0, -1.0, 1.0, 1.0, 0.0);
	s2.a[2] = mat4(9.0, -2.0, -1.0, -4.0, -8.0, 0.0, 6.0, -5.0, -2.0, -7.0, -1.0, 7.0, -2.0, -9.0, -7.0, -2.0);
	s2.b = uint16_t(7u);
	s3.a = i16vec2(-3, -9);
	s3.b[0] = uint16_t(1u);
	s3.b[1] = uint16_t(4u);
	s3.c = i16vec4(-7, 9, -7, 9);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_bvec4(bvec4(true, false, false, false), s1.a[0]) && allOk;
	allOk = compare_bvec4(bvec4(true, true, false, false), s1.a[1]) && allOk;
	allOk = compare_f16vec2(vec2(-3.0, -3.0), vec2(s1.b[0])) && allOk;
	allOk = compare_f16vec2(vec2(1.0, -3.0), vec2(s1.b[1])) && allOk;
	allOk = compare_f16vec2(vec2(8.0, 7.0), vec2(s1.b[2])) && allOk;
	allOk = compare_f16vec2(vec2(3.0, 3.0), vec2(s1.c[0])) && allOk;
	allOk = compare_i16vec4(ivec4(-4, 8, -7, -9), ivec4(s1.d[0])) && allOk;
	allOk = compare_i16vec4(ivec4(-3, 4, -3, -7), ivec4(s1.d[1])) && allOk;
	allOk = compare_i16vec4(ivec4(-7, -1, 9, -6), ivec4(s1.d[2])) && allOk;
	allOk = compare_mat4(mat4(8.0, -4.0, 4.0, 1.0, -6.0, -2.0, -3.0, -5.0, 4.0, 3.0, 0.0, 6.0, -1.0, -8.0, -3.0, -6.0), s2.a[0]) && allOk;
	allOk = compare_mat4(mat4(1.0, 7.0, 6.0, -5.0, -9.0, 2.0, 9.0, 7.0, 3.0, 6.0, 2.0, 0.0, -1.0, 1.0, 1.0, 0.0), s2.a[1]) && allOk;
	allOk = compare_mat4(mat4(9.0, -2.0, -1.0, -4.0, -8.0, 0.0, 6.0, -5.0, -2.0, -7.0, -1.0, 7.0, -2.0, -9.0, -7.0, -2.0), s2.a[2]) && allOk;
	allOk = compare_uint16_t(uint(7u), uint(s2.b)) && allOk;
	allOk = compare_i16vec2(ivec2(-3, -9), ivec2(s3.a)) && allOk;
	allOk = compare_uint16_t(uint(1u), uint(s3.b[0])) && allOk;
	allOk = compare_uint16_t(uint(4u), uint(s3.b[1])) && allOk;
	allOk = compare_i16vec4(ivec4(-7, 9, -7, 9), ivec4(s3.c)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	u16vec4 a[1];
	highp int b[3];
	highp mat3 c[2];
	lowp int d[1];
};
struct S2 {
	mediump ivec3 a[2];
	f16vec4 b[2];
	lowp mat2x3 c[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a[0] = u16vec4(2u, 3u, 7u, 5u);
	s1.b[0] = -9;
	s1.b[1] = 5;
	s1.b[2] = -4;
	s1.c[0] = mat3(-9.0, 8.0, 6.0, -2.0, -6.0, 4.0, -6.0, -3.0, 2.0);
	s1.c[1] = mat3(-9.0, -7.0, -5.0, -7.0, 3.0, 5.0, 2.0, -9.0, 0.0);
	s1.d[0] = -5;
	s2.a[0] = ivec3(0, 1, -8);
	s2.a[1] = ivec3(0, 3, -5);
	s2.b[0] = f16vec4(5.0, -7.0, 1.0, -8.0);
	s2.b[1] = f16vec4(2.0, 0.0, 1.0, 8.0);
	s2.c[0] = mat2x3(-3.0, 7.0, -6.0, -9.0, -5.0, 6.0);
	s2.c[1] = mat2x3(-8.0, -8.0, 3.0, 3.0, 8.0, 4.0);
	s2.c[2] = mat2x3(-1.0, 3.0, -6.0, 8.0, -6.0, 2.0);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_u16vec4(uvec4(2u, 3u, 7u, 5u), uvec4(s1.a[0])) && allOk;
	allOk = compare_int(-9, s1.b[0]) && allOk;
	allOk = compare_int(5, s1.b[1]) && allOk;
	allOk = compare_int(-4, s1.b[2]) && allOk;
	allOk = compare_mat3(mat3(-9.0, 8.0, 6.0, -2.0, -6.0, 4.0, -6.0, -3.0, 2.0), s1.c[0]) && allOk;
	allOk = compare_mat3(mat3(-9.0, -7.0, -5.0, -7.0, 3.0, 5.0, 2.0, -9.0, 0.0), s1.c[1]) && allOk;
	allOk = compare_int(-5, s1.d[0]) && allOk;
	allOk = compare_ivec3(ivec3(0, 1, -8), s2.a[0]) && allOk;
	allOk = compare_ivec3(ivec3(0, 3, -5), s2.a[1]) && allOk;
	allOk = compare_f16vec4(vec4(5.0, -7.0, 1.0, -8.0), vec4(s2.b[0])) && allOk;
	allOk = compare_f16vec4(vec4(2.0, 0.0, 1.0, 8.0), vec4(s2.b[1])) && allOk;
	allOk = compare_mat2x3(mat2x3(-3.0, 7.0, -6.0, -9.0, -5.0, 6.0), s2.c[0]) && allOk;
	allOk = compare_mat2x3(mat2x3(-8.0, -8.0, 3.0, 3.0, 8.0, 4.0), s2.c[1]) && allOk;
	allOk = compare_mat2x3(mat2x3(-1.0, 3.0, -6.0, 8.0, -6.0, 2.0), s2.c[2]) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	mediump mat4x2 a[2];
	u16vec4 b[3];
	uint16_t c[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

shared S1 s1;

void main (void) {
	s1.a[0] = mat4x2(-5.0, 5.0, -6.0, -9.0, 9.0, -5.0, 7.0, 7.0);
	s1.a[1] = mat4x2(0.0, 5.0, -7.0, -5.0, -2.0, -1.0, 5.0, 2.0);
	s1.b[0] = u16vec4(5u, 0u, 8u, 1u);
	s1.b[1] = u16vec4(4u, 8u, 1u, 0u);
	s1.b[2] = u16vec4(4u, 5u, 5u, 1u);
	s1.c[0] = uint16_t(3u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_mat4x2(mat4x2(-5.0, 5.0, -6.0, -9.0, 9.0, -5.0, 7.0, 7.0), s1.a[0]) && allOk;
	allOk = compare_mat4x2(mat4x2(0.0, 5.0, -7.0, -5.0, -2.0, -1.0, 5.0, 2.0), s1.a[1]) && allOk;
	allOk = compare_u16vec4(uvec4(5u, 0u, 8u, 1u), uvec4(s1.b[0])) && allOk;
	allOk = compare_u16vec4(uvec4(4u, 8u, 1u, 0u), uvec4(s1.b[1])) && allOk;
	allOk = compare_u16vec4(uvec4(4u, 5u, 5u, 1u), uvec4(s1.b[2])) && allOk;
	allOk = compare_uint16_t(uint(3u), uint(s1.c[0])) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	i16vec2 a[3];
	f16vec4 b[3];
	f16vec2 c[1];
	uint16_t d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

shared S1 s1;

void main (void) {
	s1.a[0] = i16vec2(1, -6);
	s1.a[1] = i16vec2(-5, 7);
	s1.a[2] = i16vec2(2, -1);
	s1.b[0] = f16vec4(4.0, 1.0, -8.0, -1.0);
	s1.b[1] = f16vec4(4.0, -7.0, 3.0, 8.0);
	s1.b[2] = f16vec4(1.0, 9.0, 5.0, -4.0);
	s1.c[0] = f16vec2(1.0, -4.0);
	s1.d = uint16_t(5u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_i16vec2(ivec2(1, -6), ivec2(s1.a[0])) && allOk;
	allOk = compare_i16vec2(ivec2(-5, 7), ivec2(s1.a[1])) && allOk;
	allOk = compare_i16vec2(ivec2(2, -1), ivec2(s1.a[2])) && allOk;
	allOk = compare_f16vec4(vec4(4.0, 1.0, -8.0, -1.0), vec4(s1.b[0])) && allOk;
	allOk = compare_f16vec4(vec4(4.0, -7.0, 3.0, 8.0), vec4(s1.b[1])) && allOk;
	allOk = compare_f16vec4(vec4(1.0, 9.0, 5.0, -4.0), vec4(s1.b[2])) && allOk;
	allOk = compare_f16vec2(vec2(1.0, -4.0), vec2(s1.c[0])) && allOk;
	allOk = compare_uint16_t(uint(5u), uint(s1.d)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	f16vec4 a[3];
	mediump mat2x3 b[2];
	f16vec4 c;
};
struct S2 {
	float16_t a;
	u16vec3 b[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a[0] = f16vec4(1.0, -3.0, 9.0, 7.0);
	s1.a[1] = f16vec4(-5.0, 2.0, -1.0, -8.0);
	s1.a[2] = f16vec4(2.0, -6.0, 5.0, -7.0);
	s1.b[0] = mat2x3(2.0, 8.0, 8.0, 6.0, -8.0, 7.0);
	s1.b[1] = mat2x3(-1.0, 2.0, 2.0, 6.0, 1.0, 1.0);
	s1.c = f16vec4(1.0, 6.0, -8.0, -9.0);
	s2.a = float16_t(0.0);
	s2.b[0] = u16vec3(4u, 6u, 7u);
	s2.b[1] = u16vec3(3u, 8u, 9u);
	s2.b[2] = u16vec3(6u, 9u, 2u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_f16vec4(vec4(1.0, -3.0, 9.0, 7.0), vec4(s1.a[0])) && allOk;
	allOk = compare_f16vec4(vec4(-5.0, 2.0, -1.0, -8.0), vec4(s1.a[1])) && allOk;
	allOk = compare_f16vec4(vec4(2.0, -6.0, 5.0, -7.0), vec4(s1.a[2])) && allOk;
	allOk = compare_mat2x3(mat2x3(2.0, 8.0, 8.0, 6.0, -8.0, 7.0), s1.b[0]) && allOk;
	allOk = compare_mat2x3(mat2x3(-1.0, 2.0, 2.0, 6.0, 1.0, 1.0), s1.b[1]) && allOk;
	allOk = compare_f16vec4(vec4(1.0, 6.0, -8.0, -9.0), vec4(s1.c)) && allOk;
	allOk = compare_float16_t(float(0.0), float(s2.a)) && allOk;
	allOk = compare_u16vec3(uvec3(4u, 6u, 7u), uvec3(s2.b[0])) && allOk;
	allOk = compare_u16vec3(uvec3(3u, 8u, 9u), uvec3(s2.b[1])) && allOk;
	allOk = compare_u16vec3(uvec3(6u, 9u, 2u), uvec3(s2.b[2])) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	mediump uvec4 a[2];
	uint16_t b[2];
	highp mat4x2 c;
	i16vec4 d[1][2][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

shared S1 s1;

void main (void) {
	s1.a[0] = uvec4(0u, 2u, 0u, 4u);
	s1.a[1] = uvec4(4u, 0u, 9u, 3u);
	s1.b[0] = uint16_t(5u);
	s1.b[1] = uint16_t(6u);
	s1.c = mat4x2(-1.0, -2.0, 1.0, 6.0, 5.0, 7.0, -2.0, -4.0);
	s1.d[0][0][0] = i16vec4(-9, 8, 3, 0);
	s1.d[0][0][1] = i16vec4(2, 1, 8, 0);
	s1.d[0][1][0] = i16vec4(9, -1, -1, -7);
	s1.d[0][1][1] = i16vec4(7, -4, -3, 1);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_uvec4(uvec4(0u, 2u, 0u, 4u), s1.a[0]) && allOk;
	allOk = compare_uvec4(uvec4(4u, 0u, 9u, 3u), s1.a[1]) && allOk;
	allOk = compare_uint16_t(uint(5u), uint(s1.b[0])) && allOk;
	allOk = compare_uint16_t(uint(6u), uint(s1.b[1])) && allOk;
	allOk = compare_mat4x2(mat4x2(-1.0, -2.0, 1.0, 6.0, 5.0, 7.0, -2.0, -4.0), s1.c) && allOk;
	allOk = compare_i16vec4(ivec4(-9, 8, 3, 0), ivec4(s1.d[0][0][0])) && allOk;
	allOk = compare_i16vec4(ivec4(2, 1, 8, 0), ivec4(s1.d[0][0][1])) && allOk;
	allOk = compare_i16vec4(ivec4(9, -1, -1, -7), ivec4(s1.d[0][1][0])) && allOk;
	allOk = compare_i16vec4(ivec4(7, -4, -3, 1), ivec4(s1.d[0][1][1])) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	bvec2 a[1][2][1];
	bvec4 b[1];
	lowp mat4 c[2];
};
struct S2 {
	i16vec2 a;
	int16_t b;
	int16_t c[3][1][1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a[0][0][0] = bvec2(true, false);
	s1.a[0][1][0] = bvec2(false, false);
	s1.b[0] = bvec4(true, false, false, true);
	s1.c[0] = mat4(-9.0, 8.0, -4.0, -8.0, 8.0, -8.0, -6.0, -2.0, 9.0, -2.0, -2.0, 1.0, 1.0, 7.0, -1.0, 9.0);
	s1.c[1] = mat4(-5.0, 8.0, 4.0, -9.0, 8.0, -6.0, 8.0, 2.0, -5.0, 9.0, 3.0, -5.0, -3.0, 0.0, -2.0, -4.0);
	s2.a = i16vec2(4, -6);
	s2.b = int16_t(-3);
	s2.c[0][0][0] = int16_t(5);
	s2.c[1][0][0] = int16_t(-2);
	s2.c[2][0][0] = int16_t(4);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_bvec2(bvec2(true, false), s1.a[0][0][0]) && allOk;
	allOk = compare_bvec2(bvec2(false, false), s1.a[0][1][0]) && allOk;
	allOk = compare_bvec4(bvec4(true, false, false, true), s1.b[0]) && allOk;
	allOk = compare_mat4(mat4(-9.0, 8.0, -4.0, -8.0, 8.0, -8.0, -6.0, -2.0, 9.0, -2.0, -2.0, 1.0, 1.0, 7.0, -1.0, 9.0), s1.c[0]) && allOk;
	allOk = compare_mat4(mat4(-5.0, 8.0, 4.0, -9.0, 8.0, -6.0, 8.0, 2.0, -5.0, 9.0, 3.0, -5.0, -3.0, 0.0, -2.0, -4.0), s1.c[1]) && allOk;
	allOk = compare_i16vec2(ivec2(4, -6), ivec2(s2.a)) && allOk;
	allOk = compare_int16_t(int(-3), int(s2.b)) && allOk;
	allOk = compare_int16_t(int(5), int(s2.c[0][0][0])) && allOk;
	allOk = compare_int16_t(int(-2), int(s2.c[1][0][0])) && allOk;
	allOk = compare_int16_t(int(4), int(s2.c[2][0][0])) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	f16vec2 a[2];
	highp int b[3];
	mediump ivec2 c[3][1][1];
};
struct S2 {
	bvec4 a[2][3][1];
	i16vec3 b[1][3][1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a[0] = f16vec2(0.0, 2.0);
	s1.a[1] = f16vec2(-8.0, 6.0);
	s1.b[0] = 7;
	s1.b[1] = 5;
	s1.b[2] = -6;
	s1.c[0][0][0] = ivec2(1, 9);
	s1.c[1][0][0] = ivec2(-4, -3);
	s1.c[2][0][0] = ivec2(4, 4);
	s2.a[0][0][0] = bvec4(false, false, true, true);
	s2.a[0][1][0] = bvec4(false, true, false, true);
	s2.a[0][2][0] = bvec4(false, false, true, true);
	s2.a[1][0][0] = bvec4(false, true, false, false);
	s2.a[1][1][0] = bvec4(true, false, true, false);
	s2.a[1][2][0] = bvec4(false, true, true, false);
	s2.b[0][0][0] = i16vec3(-4, 3, 9);
	s2.b[0][1][0] = i16vec3(1, 3, -9);
	s2.b[0][2][0] = i16vec3(-5, 9, -7);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_f16vec2(vec2(0.0, 2.0), vec2(s1.a[0])) && allOk;
	allOk = compare_f16vec2(vec2(-8.0, 6.0), vec2(s1.a[1])) && allOk;
	allOk = compare_int(7, s1.b[0]) && allOk;
	allOk = compare_int(5, s1.b[1]) && allOk;
	allOk = compare_int(-6, s1.b[2]) && allOk;
	allOk = compare_ivec2(ivec2(1, 9), s1.c[0][0][0]) && allOk;
	allOk = compare_ivec2(ivec2(-4, -3), s1.c[1][0][0]) && allOk;
	allOk = compare_ivec2(ivec2(4, 4), s1.c[2][0][0]) && allOk;
	allOk = compare_bvec4(bvec4(false, false, true, true), s2.a[0][0][0]) && allOk;
	allOk = compare_bvec4(bvec4(false, true, false, true), s2.a[0][1][0]) && allOk;
	allOk = compare_bvec4(bvec4(false, false, true, true), s2.a[0][2][0]) && allOk;
	allOk = compare_bvec4(bvec4(false, true, false, false), s2.a[1][0][0]) && allOk;
	allOk = compare_bvec4(bvec4(true, false, true, false), s2.a[1][1][0]) && allOk;
	allOk = compare_bvec4(bvec4(false, true, true, false), s2.a[1][2][0]) && allOk;
	allOk = compare_i16vec3(ivec3(-4, 3, 9), ivec3(s2.b[0][0][0])) && allOk;
	allOk = compare_i16vec3(ivec3(1, 3, -9), ivec3(s2.b[0][1][0])) && allOk;
	allOk = compare_i16vec3(ivec3(-5, 9, -7), ivec3(s2.b[0][2][0])) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	i16vec4 a[1][1][3];
	u16vec4 b[3][3][1];
	highp mat4x3 c[2][3][1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

shared S1 s1;

void main (void) {
	s1.a[0][0][0] = i16vec4(1, -5, -9, -5);
	s1.a[0][0][1] = i16vec4(1, -7, 1, 2);
	s1.a[0][0][2] = i16vec4(8, 7, 9, -8);
	s1.b[0][0][0] = u16vec4(7u, 2u, 5u, 6u);
	s1.b[0][1][0] = u16vec4(4u, 1u, 2u, 0u);
	s1.b[0][2][0] = u16vec4(8u, 8u, 7u, 2u);
	s1.b[1][0][0] = u16vec4(4u, 0u, 6u, 8u);
	s1.b[1][1][0] = u16vec4(8u, 2u, 3u, 4u);
	s1.b[1][2][0] = u16vec4(2u, 4u, 8u, 8u);
	s1.b[2][0][0] = u16vec4(8u, 8u, 1u, 5u);
	s1.b[2][1][0] = u16vec4(9u, 1u, 0u, 0u);
	s1.b[2][2][0] = u16vec4(6u, 6u, 1u, 6u);
	s1.c[0][0][0] = mat4x3(-6.0, 1.0, 3.0, -4.0, -4.0, 0.0, 1.0, -3.0, -9.0, -6.0, 6.0, 5.0);
	s1.c[0][1][0] = mat4x3(-5.0, 2.0, 4.0, 9.0, 2.0, 5.0, -2.0, -4.0, 7.0, 1.0, -8.0, -9.0);
	s1.c[0][2][0] = mat4x3(5.0, 1.0, -5.0, 5.0, -3.0, 6.0, 6.0, 2.0, 4.0, 4.0, -3.0, 3.0);
	s1.c[1][0][0] = mat4x3(8.0, 6.0, -3.0, 4.0, -7.0, 1.0, -5.0, -9.0, 7.0, -6.0, 6.0, -3.0);
	s1.c[1][1][0] = mat4x3(-4.0, 5.0, -9.0, 6.0, 2.0, -2.0, -6.0, 4.0, -8.0, 7.0, 1.0, -6.0);
	s1.c[1][2][0] = mat4x3(8.0, 4.0, -4.0, 6.0, -7.0, 7.0, -2.0, -7.0, 4.0, 1.0, -2.0, 4.0);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_i16vec4(ivec4(1, -5, -9, -5), ivec4(s1.a[0][0][0])) && allOk;
	allOk = compare_i16vec4(ivec4(1, -7, 1, 2), ivec4(s1.a[0][0][1])) && allOk;
	allOk = compare_i16vec4(ivec4(8, 7, 9, -8), ivec4(s1.a[0][0][2])) && allOk;
	allOk = compare_u16vec4(uvec4(7u, 2u, 5u, 6u), uvec4(s1.b[0][0][0])) && allOk;
	allOk = compare_u16vec4(uvec4(4u, 1u, 2u, 0u), uvec4(s1.b[0][1][0])) && allOk;
	allOk = compare_u16vec4(uvec4(8u, 8u, 7u, 2u), uvec4(s1.b[0][2][0])) && allOk;
	allOk = compare_u16vec4(uvec4(4u, 0u, 6u, 8u), uvec4(s1.b[1][0][0])) && allOk;
	allOk = compare_u16vec4(uvec4(8u, 2u, 3u, 4u), uvec4(s1.b[1][1][0])) && allOk;
	allOk = compare_u16vec4(uvec4(2u, 4u, 8u, 8u), uvec4(s1.b[1][2][0])) && allOk;
	allOk = compare_u16vec4(uvec4(8u, 8u, 1u, 5u), uvec4(s1.b[2][0][0])) && allOk;
	allOk = compare_u16vec4(uvec4(9u, 1u, 0u, 0u), uvec4(s1.b[2][1][0])) && allOk;
	allOk = compare_u16vec4(uvec4(6u, 6u, 1u, 6u), uvec4(s1.b[2][2][0])) && allOk;
	allOk = compare_mat4x3(mat4x3(-6.0, 1.0, 3.0, -4.0, -4.0, 0.0, 1.0, -3.0, -9.0, -6.0, 6.0, 5.0), s1.c[0][0][0]) && allOk;
	allOk = compare_mat4x3(mat4x3(-5.0, 2.0, 4.0, 9.0, 2.0, 5.0, -2.0, -4.0, 7.0, 1.0, -8.0, -9.0), s1.c[0][1][0]) && allOk;
	allOk = compare_mat4x3(mat4x3(5.0, 1.0, -5.0, 5.0, -3.0, 6.0, 6.0, 2.0, 4.0, 4.0, -3.0, 3.0), s1.c[0][2][0]) && allOk;
	allOk = compare_mat4x3(mat4x3(8.0, 6.0, -3.0, 4.0, -7.0, 1.0, -5.0, -9.0, 7.0, -6.0, 6.0, -3.0), s1.c[1][0][0]) && allOk;
	allOk = compare_mat4x3(mat4x3(-4.0, 5.0, -9.0, 6.0, 2.0, -2.0, -6.0, 4.0, -8.0, 7.0, 1.0, -6.0), s1.c[1][1][0]) && allOk;
	allOk = compare_mat4x3(mat4x3(8.0, 4.0, -4.0, 6.0, -7.0, 7.0, -2.0, -7.0, 4.0, 1.0, -2.0, 4.0), s1.c[1][2][0]) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	u16vec3 a;
	u16vec4 b[3][3][1];
	i16vec4 c[3][1][3];
	f16vec3 d;
};
struct S2 {
	float16_t a[3][2][1];
	i16vec3 b[1][3][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a = u16vec3(4u, 3u, 5u);
	s1.b[0][0][0] = u16vec4(9u, 3u, 9u, 6u);
	s1.b[0][1][0] = u16vec4(5u, 8u, 8u, 5u);
	s1.b[0][2][0] = u16vec4(1u, 1u, 7u, 0u);
	s1.b[1][0][0] = u16vec4(5u, 2u, 3u, 8u);
	s1.b[1][1][0] = u16vec4(6u, 1u, 6u, 4u);
	s1.b[1][2][0] = u16vec4(4u, 3u, 6u, 5u);
	s1.b[2][0][0] = u16vec4(8u, 4u, 9u, 4u);
	s1.b[2][1][0] = u16vec4(9u, 9u, 3u, 4u);
	s1.b[2][2][0] = u16vec4(3u, 5u, 0u, 2u);
	s1.c[0][0][0] = i16vec4(9, -9, -2, 6);
	s1.c[0][0][1] = i16vec4(-7, 8, 3, 9);
	s1.c[0][0][2] = i16vec4(7, 9, 7, 3);
	s1.c[1][0][0] = i16vec4(-3, 8, 1, -8);
	s1.c[1][0][1] = i16vec4(-3, -3, -3, 3);
	s1.c[1][0][2] = i16vec4(3, 2, 3, 1);
	s1.c[2][0][0] = i16vec4(9, -4, 4, 8);
	s1.c[2][0][1] = i16vec4(2, 3, 0, -1);
	s1.c[2][0][2] = i16vec4(-9, -8, -2, 1);
	s1.d = f16vec3(1.0, -7.0, -9.0);
	s2.a[0][0][0] = float16_t(-6.0);
	s2.a[0][1][0] = float16_t(4.0);
	s2.a[1][0][0] = float16_t(0.0);
	s2.a[1][1][0] = float16_t(-3.0);
	s2.a[2][0][0] = float16_t(-3.0);
	s2.a[2][1][0] = float16_t(9.0);
	s2.b[0][0][0] = i16vec3(-1, -8, -9);
	s2.b[0][0][1] = i16vec3(-7, -2, -6);
	s2.b[0][0][2] = i16vec3(0, 5, 8);
	s2.b[0][1][0] = i16vec3(5, 5, 3);
	s2.b[0][1][1] = i16vec3(2, -8, 5);
	s2.b[0][1][2] = i16vec3(-7, 6, -9);
	s2.b[0][2][0] = i16vec3(-3, 7, 0);
	s2.b[0][2][1] = i16vec3(9, 1, -9);
	s2.b[0][2][2] = i16vec3(-5, -9, 4);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_u16vec3(uvec3(4u, 3u, 5u), uvec3(s1.a)) && allOk;
	allOk = compare_u16vec4(uvec4(9u, 3u, 9u, 6u), uvec4(s1.b[0][0][0])) && allOk;
	allOk = compare_u16vec4(uvec4(5u, 8u, 8u, 5u), uvec4(s1.b[0][1][0])) && allOk;
	allOk = compare_u16vec4(uvec4(1u, 1u, 7u, 0u), uvec4(s1.b[0][2][0])) && allOk;
	allOk = compare_u16vec4(uvec4(5u, 2u, 3u, 8u), uvec4(s1.b[1][0][0])) && allOk;
	allOk = compare_u16vec4(uvec4(6u, 1u, 6u, 4u), uvec4(s1.b[1][1][0])) && allOk;
	allOk = compare_u16vec4(uvec4(4u, 3u, 6u, 5u), uvec4(s1.b[1][2][0])) && allOk;
	allOk = compare_u16vec4(uvec4(8u, 4u, 9u, 4u), uvec4(s1.b[2][0][0])) && allOk;
	allOk = compare_u16vec4(uvec4(9u, 9u, 3u, 4u), uvec4(s1.b[2][1][0])) && allOk;
	allOk = compare_u16vec4(uvec4(3u, 5u, 0u, 2u), uvec4(s1.b[2][2][0])) && allOk;
	allOk = compare_i16vec4(ivec4(9, -9, -2, 6), ivec4(s1.c[0][0][0])) && allOk;
	allOk = compare_i16vec4(ivec4(-7, 8, 3, 9), ivec4(s1.c[0][0][1])) && allOk;
	allOk = compare_i16vec4(ivec4(7, 9, 7, 3), ivec4(s1.c[0][0][2])) && allOk;
	allOk = compare_i16vec4(ivec4(-3, 8, 1, -8), ivec4(s1.c[1][0][0])) && allOk;
	allOk = compare_i16vec4(ivec4(-3, -3, -3, 3), ivec4(s1.c[1][0][1])) && allOk;
	allOk = compare_i16vec4(ivec4(3, 2, 3, 1), ivec4(s1.c[1][0][2])) && allOk;
	allOk = compare_i16vec4(ivec4(9, -4, 4, 8), ivec4(s1.c[2][0][0])) && allOk;
	allOk = compare_i16vec4(ivec4(2, 3, 0, -1), ivec4(s1.c[2][0][1])) && allOk;
	allOk = compare_i16vec4(ivec4(-9, -8, -2, 1), ivec4(s1.c[2][0][2])) && allOk;
	allOk = compare_f16vec3(vec3(1.0, -7.0, -9.0), vec3(s1.d)) && allOk;
	allOk = compare_float16_t(float(-6.0), float(s2.a[0][0][0])) && allOk;
	allOk = compare_float16_t(float(4.0), float(s2.a[0][1][0])) && allOk;
	allOk = compare_float16_t(float(0.0), float(s2.a[1][0][0])) && allOk;
	allOk = compare_float16_t(float(-3.0), float(s2.a[1][1][0])) && allOk;
	allOk = compare_float16_t(float(-3.0), float(s2.a[2][0][0])) && allOk;
	allOk = compare_float16_t(float(9.0), float(s2.a[2][1][0])) && allOk;
	allOk = compare_i16vec3(ivec3(-1, -8, -9), ivec3(s2.b[0][0][0])) && allOk;
	allOk = compare_i16vec3(ivec3(-7, -2, -6), ivec3(s2.b[0][0][1])) && allOk;
	allOk = compare_i16vec3(ivec3(0, 5, 8), ivec3(s2.b[0][0][2])) && allOk;
	allOk = compare_i16vec3(ivec3(5, 5, 3), ivec3(s2.b[0][1][0])) && allOk;
	allOk = compare_i16vec3(ivec3(2, -8, 5), ivec3(s2.b[0][1][1])) && allOk;
	allOk = compare_i16vec3(ivec3(-7, 6, -9), ivec3(s2.b[0][1][2])) && allOk;
	allOk = compare_i16vec3(ivec3(-3, 7, 0), ivec3(s2.b[0][2][0])) && allOk;
	allOk = compare_i16vec3(ivec3(9, 1, -9), ivec3(s2.b[0][2][1])) && allOk;
	allOk = compare_i16vec3(ivec3(-5, -9, 4), ivec3(s2.b[0][2][2])) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	mediump mat4 a[2][3];
	mediump mat2x3 b[2][1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

shared S1 s1;

void main (void) {
	s1.a[0][0] = mat4(2.0, -3.0, 2.0, -4.0, 4.0, 6.0, -2.0, -5.0, -3.0, -3.0, 1.0, -3.0, 8.0, 7.0, 3.0, 3.0);
	s1.a[0][1] = mat4(-4.0, 8.0, -7.0, -9.0, -3.0, 4.0, -3.0, -7.0, -7.0, -1.0, 9.0, -6.0, 8.0, -4.0, 4.0, 1.0);
	s1.a[0][2] = mat4(-6.0, -2.0, -3.0, -5.0, 4.0, 3.0, 0.0, 6.0, -1.0, -8.0, -3.0, -6.0, 1.0, 7.0, 6.0, -5.0);
	s1.a[1][0] = mat4(-9.0, 2.0, 9.0, 7.0, 3.0, 6.0, 2.0, 0.0, -1.0, 1.0, 1.0, 0.0, 9.0, -2.0, -1.0, -4.0);
	s1.a[1][1] = mat4(-8.0, 0.0, 6.0, -5.0, -2.0, -7.0, -1.0, 7.0, -2.0, -9.0, -7.0, -2.0, -3.0, -3.0, -9.0, 6.0);
	s1.a[1][2] = mat4(9.0, -7.0, 9.0, -7.0, 9.0, -3.0, -4.0, -8.0, -7.0, -2.0, 6.0, -3.0, 7.0, 7.0, 8.0, -8.0);
	s1.b[0][0] = mat2x3(-9.0, 3.0, -2.0, 0.0, 5.0, -6.0);
	s1.b[1][0] = mat2x3(-6.0, -2.0, 8.0, -9.0, -6.0, -2.0);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_mat4(mat4(2.0, -3.0, 2.0, -4.0, 4.0, 6.0, -2.0, -5.0, -3.0, -3.0, 1.0, -3.0, 8.0, 7.0, 3.0, 3.0), s1.a[0][0]) && allOk;
	allOk = compare_mat4(mat4(-4.0, 8.0, -7.0, -9.0, -3.0, 4.0, -3.0, -7.0, -7.0, -1.0, 9.0, -6.0, 8.0, -4.0, 4.0, 1.0), s1.a[0][1]) && allOk;
	allOk = compare_mat4(mat4(-6.0, -2.0, -3.0, -5.0, 4.0, 3.0, 0.0, 6.0, -1.0, -8.0, -3.0, -6.0, 1.0, 7.0, 6.0, -5.0), s1.a[0][2]) && allOk;
	allOk = compare_mat4(mat4(-9.0, 2.0, 9.0, 7.0, 3.0, 6.0, 2.0, 0.0, -1.0, 1.0, 1.0, 0.0, 9.0, -2.0, -1.0, -4.0), s1.a[1][0]) && allOk;
	allOk = compare_mat4(mat4(-8.0, 0.0, 6.0, -5.0, -2.0, -7.0, -1.0, 7.0, -2.0, -9.0, -7.0, -2.0, -3.0, -3.0, -9.0, 6.0), s1.a[1][1]) && allOk;
	allOk = compare_mat4(mat4(9.0, -7.0, 9.0, -7.0, 9.0, -3.0, -4.0, -8.0, -7.0, -2.0, 6.0, -3.0, 7.0, 7.0, 8.0, -8.0), s1.a[1][2]) && allOk;
	allOk = compare_mat2x3(mat2x3(-9.0, 3.0, -2.0, 0.0, 5.0, -6.0), s1.b[0][0]) && allOk;
	allOk = compare_mat2x3(mat2x3(-6.0, -2.0, 8.0, -9.0, -6.0, -2.0), s1.b[1][0]) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	uint16_t a[2][1][3];
	f16vec2 b[1][3];
	i16vec4 c[3][1][2];
};
struct S2 {
	float16_t a[3][2];
	u16vec4 b[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a[0][0][0] = uint16_t(2u);
	s1.a[0][0][1] = uint16_t(3u);
	s1.a[0][0][2] = uint16_t(7u);
	s1.a[1][0][0] = uint16_t(5u);
	s1.a[1][0][1] = uint16_t(3u);
	s1.a[1][0][2] = uint16_t(2u);
	s1.b[0][0] = f16vec2(-4.0, -9.0);
	s1.b[0][1] = f16vec2(8.0, 6.0);
	s1.b[0][2] = f16vec2(-2.0, -6.0);
	s1.c[0][0][0] = i16vec4(4, -6, -3, 2);
	s1.c[0][0][1] = i16vec4(-9, -7, -5, -7);
	s1.c[1][0][0] = i16vec4(3, 5, 2, -9);
	s1.c[1][0][1] = i16vec4(0, -5, 0, 1);
	s1.c[2][0][0] = i16vec4(-8, 0, 3, -5);
	s1.c[2][0][1] = i16vec4(5, -7, 1, -8);
	s2.a[0][0] = float16_t(2.0);
	s2.a[0][1] = float16_t(0.0);
	s2.a[1][0] = float16_t(1.0);
	s2.a[1][1] = float16_t(8.0);
	s2.a[2][0] = float16_t(-3.0);
	s2.a[2][1] = float16_t(7.0);
	s2.b[0] = u16vec4(9u, 1u, 6u, 2u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_uint16_t(uint(2u), uint(s1.a[0][0][0])) && allOk;
	allOk = compare_uint16_t(uint(3u), uint(s1.a[0][0][1])) && allOk;
	allOk = compare_uint16_t(uint(7u), uint(s1.a[0][0][2])) && allOk;
	allOk = compare_uint16_t(uint(5u), uint(s1.a[1][0][0])) && allOk;
	allOk = compare_uint16_t(uint(3u), uint(s1.a[1][0][1])) && allOk;
	allOk = compare_uint16_t(uint(2u), uint(s1.a[1][0][2])) && allOk;
	allOk = compare_f16vec2(vec2(-4.0, -9.0), vec2(s1.b[0][0])) && allOk;
	allOk = compare_f16vec2(vec2(8.0, 6.0), vec2(s1.b[0][1])) && allOk;
	allOk = compare_f16vec2(vec2(-2.0, -6.0), vec2(s1.b[0][2])) && allOk;
	allOk = compare_i16vec4(ivec4(4, -6, -3, 2), ivec4(s1.c[0][0][0])) && allOk;
	allOk = compare_i16vec4(ivec4(-9, -7, -5, -7), ivec4(s1.c[0][0][1])) && allOk;
	allOk = compare_i16vec4(ivec4(3, 5, 2, -9), ivec4(s1.c[1][0][0])) && allOk;
	allOk = compare_i16vec4(ivec4(0, -5, 0, 1), ivec4(s1.c[1][0][1])) && allOk;
	allOk = compare_i16vec4(ivec4(-8, 0, 3, -5), ivec4(s1.c[2][0][0])) && allOk;
	allOk = compare_i16vec4(ivec4(5, -7, 1, -8), ivec4(s1.c[2][0][1])) && allOk;
	allOk = compare_float16_t(float(2.0), float(s2.a[0][0])) && allOk;
	allOk = compare_float16_t(float(0.0), float(s2.a[0][1])) && allOk;
	allOk = compare_float16_t(float(1.0), float(s2.a[1][0])) && allOk;
	allOk = compare_float16_t(float(8.0), float(s2.a[1][1])) && allOk;
	allOk = compare_float16_t(float(-3.0), float(s2.a[2][0])) && allOk;
	allOk = compare_float16_t(float(7.0), float(s2.a[2][1])) && allOk;
	allOk = compare_u16vec4(uvec4(9u, 1u, 6u, 2u), uvec4(s2.b[0])) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	u16vec4 a[2][2][1];
	f16vec3 b[1][1][3];
	i16vec4 c[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

shared S1 s1;

void main (void) {
	s1.a[0][0][0] = u16vec4(5u, 7u, 3u, 1u);
	s1.a[0][1][0] = u16vec4(4u, 1u, 3u, 0u);
	s1.a[1][0][0] = u16vec4(5u, 9u, 0u, 9u);
	s1.a[1][1][0] = u16vec4(9u, 1u, 8u, 4u);
	s1.b[0][0][0] = f16vec3(-4.0, 7.0, 7.0);
	s1.b[0][0][1] = f16vec3(-1.0, 3.0, -2.0);
	s1.b[0][0][2] = f16vec3(-1.0, -5.0, 5.0);
	s1.c[0] = i16vec4(3, 9, -5, 1);
	s1.c[1] = i16vec4(8, -8, 4, -8);
	s1.c[2] = i16vec4(-3, -1, 4, -9);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_u16vec4(uvec4(5u, 7u, 3u, 1u), uvec4(s1.a[0][0][0])) && allOk;
	allOk = compare_u16vec4(uvec4(4u, 1u, 3u, 0u), uvec4(s1.a[0][1][0])) && allOk;
	allOk = compare_u16vec4(uvec4(5u, 9u, 0u, 9u), uvec4(s1.a[1][0][0])) && allOk;
	allOk = compare_u16vec4(uvec4(9u, 1u, 8u, 4u), uvec4(s1.a[1][1][0])) && allOk;
	allOk = compare_f16vec3(vec3(-4.0, 7.0, 7.0), vec3(s1.b[0][0][0])) && allOk;
	allOk = compare_f16vec3(vec3(-1.0, 3.0, -2.0), vec3(s1.b[0][0][1])) && allOk;
	allOk = compare_f16vec3(vec3(-1.0, -5.0, 5.0), vec3(s1.b[0][0][2])) && allOk;
	allOk = compare_i16vec4(ivec4(3, 9, -5, 1), ivec4(s1.c[0])) && allOk;
	allOk = compare_i16vec4(ivec4(8, -8, 4, -8), ivec4(s1.c[1])) && allOk;
	allOk = compare_i16vec4(ivec4(-3, -1, 4, -9), ivec4(s1.c[2])) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	u16vec3 a[2];
	lowp vec3 b[1][2][1];
	highp mat4x3 c[3][2][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

shared S1 s1;

void main (void) {
	s1.a[0] = u16vec3(2u, 5u, 1u);
	s1.a[1] = u16vec3(9u, 5u, 7u);
	s1.b[0][0][0] = vec3(4.0, 1.0, -8.0);
	s1.b[0][1][0] = vec3(-1.0, 4.0, -7.0);
	s1.c[0][0][0] = mat4x3(3.0, 8.0, 1.0, 9.0, 5.0, -4.0, 1.0, -4.0, -4.0, -3.0, 1.0, 5.0);
	s1.c[0][0][1] = mat4x3(6.0, 9.0, 0.0, 1.0, -3.0, 1.0, 6.0, 6.0, 6.0, -8.0, 6.0, 6.0);
	s1.c[0][1][0] = mat4x3(5.0, 1.0, 4.0, 6.0, -4.0, 0.0, 1.0, 2.0, -1.0, 9.0, -9.0, 9.0);
	s1.c[0][1][1] = mat4x3(3.0, -9.0, 3.0, 5.0, 2.0, 3.0, 1.0, -6.0, -5.0, 9.0, 1.0, 5.0);
	s1.c[1][0][0] = mat4x3(-7.0, 6.0, -1.0, -9.0, -5.0, 8.0, 5.0, -4.0, -1.0, -8.0, 4.0, -7.0);
	s1.c[1][0][1] = mat4x3(1.0, 4.0, -2.0, 0.0, -1.0, -3.0, -7.0, 2.0, 3.0, 2.0, 6.0, -6.0);
	s1.c[1][1][0] = mat4x3(8.0, 2.0, -5.0, 9.0, -2.0, 9.0, 9.0, 2.0, 1.0, -5.0, 8.0, -5.0);
	s1.c[1][1][1] = mat4x3(3.0, 9.0, 6.0, -8.0, 6.0, 4.0, 4.0, -7.0, -3.0, 7.0, -3.0, 9.0);
	s1.c[2][0][0] = mat4x3(-7.0, -5.0, -7.0, 0.0, -2.0, 3.0, 2.0, -6.0, -2.0, 1.0, 6.0, -3.0);
	s1.c[2][0][1] = mat4x3(1.0, -6.0, 5.0, -1.0, -2.0, -6.0, -9.0, 1.0, 9.0, 4.0, 1.0, 6.0);
	s1.c[2][1][0] = mat4x3(1.0, 6.0, -8.0, 5.0, -6.0, 2.0, -9.0, 3.0, 9.0, -2.0, 2.0, -7.0);
	s1.c[2][1][1] = mat4x3(1.0, -1.0, 6.0, -6.0, 4.0, 6.0, 2.0, -3.0, -4.0, 4.0, 9.0, 0.0);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_u16vec3(uvec3(2u, 5u, 1u), uvec3(s1.a[0])) && allOk;
	allOk = compare_u16vec3(uvec3(9u, 5u, 7u), uvec3(s1.a[1])) && allOk;
	allOk = compare_vec3(vec3(4.0, 1.0, -8.0), s1.b[0][0][0]) && allOk;
	allOk = compare_vec3(vec3(-1.0, 4.0, -7.0), s1.b[0][1][0]) && allOk;
	allOk = compare_mat4x3(mat4x3(3.0, 8.0, 1.0, 9.0, 5.0, -4.0, 1.0, -4.0, -4.0, -3.0, 1.0, 5.0), s1.c[0][0][0]) && allOk;
	allOk = compare_mat4x3(mat4x3(6.0, 9.0, 0.0, 1.0, -3.0, 1.0, 6.0, 6.0, 6.0, -8.0, 6.0, 6.0), s1.c[0][0][1]) && allOk;
	allOk = compare_mat4x3(mat4x3(5.0, 1.0, 4.0, 6.0, -4.0, 0.0, 1.0, 2.0, -1.0, 9.0, -9.0, 9.0), s1.c[0][1][0]) && allOk;
	allOk = compare_mat4x3(mat4x3(3.0, -9.0, 3.0, 5.0, 2.0, 3.0, 1.0, -6.0, -5.0, 9.0, 1.0, 5.0), s1.c[0][1][1]) && allOk;
	allOk = compare_mat4x3(mat4x3(-7.0, 6.0, -1.0, -9.0, -5.0, 8.0, 5.0, -4.0, -1.0, -8.0, 4.0, -7.0), s1.c[1][0][0]) && allOk;
	allOk = compare_mat4x3(mat4x3(1.0, 4.0, -2.0, 0.0, -1.0, -3.0, -7.0, 2.0, 3.0, 2.0, 6.0, -6.0), s1.c[1][0][1]) && allOk;
	allOk = compare_mat4x3(mat4x3(8.0, 2.0, -5.0, 9.0, -2.0, 9.0, 9.0, 2.0, 1.0, -5.0, 8.0, -5.0), s1.c[1][1][0]) && allOk;
	allOk = compare_mat4x3(mat4x3(3.0, 9.0, 6.0, -8.0, 6.0, 4.0, 4.0, -7.0, -3.0, 7.0, -3.0, 9.0), s1.c[1][1][1]) && allOk;
	allOk = compare_mat4x3(mat4x3(-7.0, -5.0, -7.0, 0.0, -2.0, 3.0, 2.0, -6.0, -2.0, 1.0, 6.0, -3.0), s1.c[2][0][0]) && allOk;
	allOk = compare_mat4x3(mat4x3(1.0, -6.0, 5.0, -1.0, -2.0, -6.0, -9.0, 1.0, 9.0, 4.0, 1.0, 6.0), s1.c[2][0][1]) && allOk;
	allOk = compare_mat4x3(mat4x3(1.0, 6.0, -8.0, 5.0, -6.0, 2.0, -9.0, 3.0, 9.0, -2.0, 2.0, -7.0), s1.c[2][1][0]) && allOk;
	allOk = compare_mat4x3(mat4x3(1.0, -1.0, 6.0, -6.0, 4.0, 6.0, 2.0, -3.0, -4.0, 4.0, 9.0, 0.0), s1.c[2][1][1]) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	lowp vec4 a[1][3][1];
	highp uvec4 b[3];
	i16vec4 c[1][2];
};
struct S2 {
	f16vec2 a[2][1][3];
	int16_t b;
	mediump uvec4 c[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a[0][0][0] = vec4(1.0, -3.0, 9.0, 7.0);
	s1.a[0][1][0] = vec4(-5.0, 2.0, -1.0, -8.0);
	s1.a[0][2][0] = vec4(2.0, -6.0, 5.0, -7.0);
	s1.b[0] = uvec4(1u, 7u, 1u, 2u);
	s1.b[1] = uvec4(9u, 2u, 1u, 5u);
	s1.b[2] = uvec4(9u, 6u, 1u, 3u);
	s1.c[0][0] = i16vec4(1, 6, -8, -9);
	s1.c[0][1] = i16vec4(0, -1, -1, 5);
	s2.a[0][0][0] = f16vec2(4.0, 0.0);
	s2.a[0][0][1] = f16vec2(-1.0, -2.0);
	s2.a[0][0][2] = f16vec2(-9.0, 1.0);
	s2.a[1][0][0] = f16vec2(0.0, 8.0);
	s2.a[1][0][1] = f16vec2(0.0, 5.0);
	s2.a[1][0][2] = f16vec2(-7.0, 6.0);
	s2.b = int16_t(6);
	s2.c[0] = uvec4(6u, 9u, 9u, 3u);
	s2.c[1] = uvec4(6u, 3u, 0u, 2u);
	s2.c[2] = uvec4(8u, 5u, 9u, 5u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_vec4(vec4(1.0, -3.0, 9.0, 7.0), s1.a[0][0][0]) && allOk;
	allOk = compare_vec4(vec4(-5.0, 2.0, -1.0, -8.0), s1.a[0][1][0]) && allOk;
	allOk = compare_vec4(vec4(2.0, -6.0, 5.0, -7.0), s1.a[0][2][0]) && allOk;
	allOk = compare_uvec4(uvec4(1u, 7u, 1u, 2u), s1.b[0]) && allOk;
	allOk = compare_uvec4(uvec4(9u, 2u, 1u, 5u), s1.b[1]) && allOk;
	allOk = compare_uvec4(uvec4(9u, 6u, 1u, 3u), s1.b[2]) && allOk;
	allOk = compare_i16vec4(ivec4(1, 6, -8, -9), ivec4(s1.c[0][0])) && allOk;
	allOk = compare_i16vec4(ivec4(0, -1, -1, 5), ivec4(s1.c[0][1])) && allOk;
	allOk = compare_f16vec2(vec2(4.0, 0.0), vec2(s2.a[0][0][0])) && allOk;
	allOk = compare_f16vec2(vec2(-1.0, -2.0), vec2(s2.a[0][0][1])) && allOk;
	allOk = compare_f16vec2(vec2(-9.0, 1.0), vec2(s2.a[0][0][2])) && allOk;
	allOk = compare_f16vec2(vec2(0.0, 8.0), vec2(s2.a[1][0][0])) && allOk;
	allOk = compare_f16vec2(vec2(0.0, 5.0), vec2(s2.a[1][0][1])) && allOk;
	allOk = compare_f16vec2(vec2(-7.0, 6.0), vec2(s2.a[1][0][2])) && allOk;
	allOk = compare_int16_t(int(6), int(s2.b)) && allOk;
	allOk = compare_uvec4(uvec4(6u, 9u, 9u, 3u), s2.c[0]) && allOk;
	allOk = compare_uvec4(uvec4(6u, 3u, 0u, 2u), s2.c[1]) && allOk;
	allOk = compare_uvec4(uvec4(8u, 5u, 9u, 5u), s2.c[2]) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	mediump ivec2 mA;
	int16_t mB;
	f16vec4 mC;
};
struct sB
{
	i16vec4 mA;
	sA mB;
};
struct sC
{
	sB mA;
	i16vec3 mB;
};
struct sD
{
	u16vec4 mA;
	f16vec2 mB;
};
struct sE
{
	sD mA;
	f16vec3 mB;
	i16vec3 mC;
};
struct sF
{
	sE mA;
	bvec2 mB;
};
struct sG
{
	u16vec3 mA;
};
struct sH
{
	f16vec4 mA;
	highp uvec3 mB;
	i16vec3 mC;
};
struct sI
{
	sG mA;
	sH mB;
};
struct sJ
{
	bvec2 mA;
	float16_t mB;
	u16vec4 mC;
};
struct sK
{
	bvec3 mA;
};
struct sL
{
	sJ mA;
	sK mB;
	lowp vec2 mC;
};
struct sM
{
	sI mA;
	sL mB;
};
struct sN
{
	mediump vec3 mA;
	bvec3 mB;
	f16vec2 mC;
};
struct sO
{
	sN mA;
};
struct sP
{
	sO mA;
};
struct S1 {
	u16vec2 a;
	sC b;
};
struct S2 {
	sF a;
	u16vec3 b;
};
struct S3 {
	mediump ivec3 a;
	uint16_t b;
	sM c;
	sP d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

shared S1 s1;
shared S2 s2;
shared S3 s3;

void main (void) {
	s1.a = u16vec2(0u, 2u);
	s1.b.mA.mA = i16vec4(8, 0, -4, -5);
	s1.b.mA.mB.mA = ivec2(9, -4);
	s1.b.mA.mB.mB = int16_t(-6);
	s1.b.mA.mB.mC = f16vec4(-1.0, -1.0, -2.0, 1.0);
	s1.b.mB = i16vec3(6, 5, 7);
	s2.a.mA.mA.mA = u16vec4(3u, 1u, 5u, 6u);
	s2.a.mA.mA.mB = f16vec2(3.0, 0.0);
	s2.a.mA.mB = f16vec3(2.0, 1.0, 8.0);
	s2.a.mA.mC = i16vec3(0, 9, -1);
	s2.a.mB = bvec2(true, true);
	s2.b = u16vec3(1u, 8u, 6u);
	s3.a = ivec3(1, -4, -9);
	s3.b = uint16_t(1u);
	s3.c.mA.mA.mA = u16vec3(3u, 5u, 4u);
	s3.c.mA.mB.mA = f16vec4(0.0, 6.0, 2.0, 3.0);
	s3.c.mA.mB.mB = uvec3(2u, 5u, 4u);
	s3.c.mA.mB.mC = i16vec3(-1, -9, -6);
	s3.c.mB.mA.mA = bvec2(false, true);
	s3.c.mB.mA.mB = float16_t(6.0);
	s3.c.mB.mA.mC = u16vec4(0u, 0u, 8u, 7u);
	s3.c.mB.mB.mA = bvec3(false, false, false);
	s3.c.mB.mC = vec2(4.0, 8.0);
	s3.d.mA.mA.mA = vec3(-9.0, -8.0, -2.0);
	s3.d.mA.mA.mB = bvec3(false, false, true);
	s3.d.mA.mA.mC = f16vec2(0.0, -8.0);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_u16vec2(uvec2(0u, 2u), uvec2(s1.a)) && allOk;
	allOk = compare_i16vec4(ivec4(8, 0, -4, -5), ivec4(s1.b.mA.mA)) && allOk;
	allOk = compare_ivec2(ivec2(9, -4), s1.b.mA.mB.mA) && allOk;
	allOk = compare_int16_t(int(-6), int(s1.b.mA.mB.mB)) && allOk;
	allOk = compare_f16vec4(vec4(-1.0, -1.0, -2.0, 1.0), vec4(s1.b.mA.mB.mC)) && allOk;
	allOk = compare_i16vec3(ivec3(6, 5, 7), ivec3(s1.b.mB)) && allOk;
	allOk = compare_u16vec4(uvec4(3u, 1u, 5u, 6u), uvec4(s2.a.mA.mA.mA)) && allOk;
	allOk = compare_f16vec2(vec2(3.0, 0.0), vec2(s2.a.mA.mA.mB)) && allOk;
	allOk = compare_f16vec3(vec3(2.0, 1.0, 8.0), vec3(s2.a.mA.mB)) && allOk;
	allOk = compare_i16vec3(ivec3(0, 9, -1), ivec3(s2.a.mA.mC)) && allOk;
	allOk = compare_bvec2(bvec2(true, true), s2.a.mB) && allOk;
	allOk = compare_u16vec3(uvec3(1u, 8u, 6u), uvec3(s2.b)) && allOk;
	allOk = compare_ivec3(ivec3(1, -4, -9), s3.a) && allOk;
	allOk = compare_uint16_t(uint(1u), uint(s3.b)) && allOk;
	allOk = compare_u16vec3(uvec3(3u, 5u, 4u), uvec3(s3.c.mA.mA.mA)) && allOk;
	allOk = compare_f16vec4(vec4(0.0, 6.0, 2.0, 3.0), vec4(s3.c.mA.mB.mA)) && allOk;
	allOk = compare_uvec3(uvec3(2u, 5u, 4u), s3.c.mA.mB.mB) && allOk;
	allOk = compare_i16vec3(ivec3(-1, -9, -6), ivec3(s3.c.mA.mB.mC)) && allOk;
	allOk = compare_bvec2(bvec2(false, true), s3.c.mB.mA.mA) && allOk;
	allOk = compare_float16_t(float(6.0), float(s3.c.mB.mA.mB)) && allOk;
	allOk = compare_u16vec4(uvec4(0u, 0u, 8u, 7u), uvec4(s3.c.mB.mA.mC)) && allOk;
	allOk = compare_bvec3(bvec3(false, false, false), s3.c.mB.mB.mA) && allOk;
	allOk = compare_vec2(vec2(4.0, 8.0), s3.c.mB.mC) && allOk;
	allOk = compare_vec3(vec3(-9.0, -8.0, -2.0), s3.d.mA.mA.mA) && allOk;
	allOk = compare_bvec3(bvec3(false, false, true), s3.d.mA.mA.mB) && allOk;
	allOk = compare_f16vec2(vec2(0.0, -8.0), vec2(s3.d.mA.mA.mC)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	bvec3 mA;
};
struct sB
{
	sA mA;
	mediump ivec2 mB;
};
struct sC
{
	bool mA;
	u16vec2 mB;
};
struct sD
{
	uint16_t mA;
	mediump mat4x2 mB;
};
struct sE
{
	sC mA;
	sD mB;
};
struct sF
{
	bool mA;
};
struct sG
{
	sF mA;
	f16vec4 mB;
};
struct sH
{
	sE mA;
	sG mB;
};
struct S1 {
	sB a;
	sH b;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

shared S1 s1;

void main (void) {
	s1.a.mA.mA = bvec3(true, false, false);
	s1.a.mB = ivec2(-3, -1);
	s1.b.mA.mA.mA = false;
	s1.b.mA.mA.mB = u16vec2(4u, 3u);
	s1.b.mA.mB.mA = uint16_t(2u);
	s1.b.mA.mB.mB = mat4x2(8.0, -4.0, -8.0, 8.0, -8.0, -6.0, -2.0, 9.0);
	s1.b.mB.mA.mA = false;
	s1.b.mB.mB = f16vec4(-2.0, 1.0, 1.0, 7.0);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_bvec3(bvec3(true, false, false), s1.a.mA.mA) && allOk;
	allOk = compare_ivec2(ivec2(-3, -1), s1.a.mB) && allOk;
	allOk = compare_bool(false, s1.b.mA.mA.mA) && allOk;
	allOk = compare_u16vec2(uvec2(4u, 3u), uvec2(s1.b.mA.mA.mB)) && allOk;
	allOk = compare_uint16_t(uint(2u), uint(s1.b.mA.mB.mA)) && allOk;
	allOk = compare_mat4x2(mat4x2(8.0, -4.0, -8.0, 8.0, -8.0, -6.0, -2.0, 9.0), s1.b.mA.mB.mB) && allOk;
	allOk = compare_bool(false, s1.b.mB.mA.mA) && allOk;
	allOk = compare_f16vec4(vec4(-2.0, 1.0, 1.0, 7.0), vec4(s1.b.mB.mB)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	lowp mat4 mA;
	lowp int mB;
};
struct sB
{
	i16vec3 mA;
	float16_t mB;
	highp vec4 mC;
};
struct sC
{
	bvec4 mA;
	sA mB;
	sB mC;
};
struct sD
{
	i16vec4 mA;
	i16vec2 mB;
	lowp vec3 mC;
};
struct sE
{
	sC mA;
	sD mB;
	highp uvec3 mC;
};
struct sF
{
	f16vec2 mA;
};
struct sG
{
	sF mA;
};
struct sH
{
	lowp mat4x2 mA;
	f16vec3 mB;
	lowp mat3x2 mC;
};
struct sI
{
	uint16_t mA;
};
struct sJ
{
	sH mA;
	sI mB;
	lowp vec2 mC;
};
struct sK
{
	mediump mat3 mA;
};
struct sL
{
	sK mA;
};
struct sM
{
	sG mA;
	sJ mB;
	sL mC;
};
struct sN
{
	float16_t mA;
	lowp mat3x2 mB;
};
struct sO
{
	sN mA;
	uint16_t mB;
	u16vec2 mC;
};
struct sP
{
	i16vec2 mA;
	lowp mat4x3 mB;
	float16_t mC;
};
struct sQ
{
	highp mat3x4 mA;
	i16vec2 mB;
	highp ivec2 mC;
};
struct sR
{
	sP mA;
	sQ mB;
};
struct sS
{
	sO mA;
	sR mB;
	float16_t mC;
};
struct sT
{
	lowp vec2 mA;
	int16_t mB;
	mediump uvec4 mC;
};
struct sU
{
	i16vec3 mA;
};
struct sV
{
	sT mA;
	sU mB;
};
struct sW
{
	sV mA;
};
struct sX
{
	highp mat3x2 mA;
};
struct sY
{
	sX mA;
};
struct sZ
{
	f16vec2 mA;
	u16vec3 mB;
};
struct sAA
{
	highp uvec2 mA;
	i16vec2 mB;
	lowp ivec4 mC;
};
struct sAB
{
	f16vec4 mA;
	sZ mB;
	sAA mC;
};
struct sAC
{
	sY mA;
	f16vec2 mB;
	sAB mC;
};
struct sAD
{
	lowp mat4x3 mA;
	u16vec2 mB;
};
struct sAE
{
	int16_t mA;
	sAD mB;
};
struct sAF
{
	f16vec3 mA;
	sAE mB;
};
struct sAG
{
	float16_t mA;
	f16vec2 mB;
	mediump mat4 mC;
};
struct sAH
{
	sAG mA;
	bvec2 mB;
};
struct sAI
{
	sAH mA;
};
struct sAJ
{
	i16vec3 mA;
	mediump mat4 mB;
};
struct sAK
{
	f16vec2 mA;
	bvec3 mB;
	lowp vec3 mC;
};
struct sAL
{
	sAJ mA;
	sAK mB;
};
struct sAM
{
	lowp uint mA;
	i16vec3 mB;
};
struct sAN
{
	u16vec2 mA;
	lowp ivec4 mB;
};
struct sAO
{
	u16vec4 mA;
	highp vec2 mB;
};
struct sAP
{
	sAM mA;
	sAN mB;
	sAO mC;
};
struct sAQ
{
	f16vec4 mA;
	i16vec3 mB;
};
struct sAR
{
	sAQ mA;
};
struct sAS
{
	sAL mA;
	sAP mB;
	sAR mC;
};
struct S1 {
	sE a;
	sM b;
	sS c;
};
struct S2 {
	sW a;
	sAC b;
};
struct S3 {
	lowp vec3 a;
	sAF b;
	sAI c;
	sAS d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

shared S1 s1;
shared S2 s2;
shared S3 s3;

void main (void) {
	s1.a.mA.mA = bvec4(true, false, false, false);
	s1.a.mA.mB.mA = mat4(7.0, 5.0, -6.0, 1.0, 9.0, -4.0, -3.0, 4.0, 4.0, 9.0, -9.0, -8.0, -9.0, 8.0, 0.0, 4.0);
	s1.a.mA.mB.mB = -4;
	s1.a.mA.mC.mA = i16vec3(7, 2, -1);
	s1.a.mA.mC.mB = float16_t(7.0);
	s1.a.mA.mC.mC = vec4(-5.0, -4.0, 3.0, -5.0);
	s1.a.mB.mA = i16vec4(-3, -1, 1, 0);
	s1.a.mB.mB = i16vec2(-3, 1);
	s1.a.mB.mC = vec3(3.0, -9.0, -4.0);
	s1.a.mC = uvec3(2u, 2u, 8u);
	s1.b.mA.mA.mA = f16vec2(3.0, -9.0);
	s1.b.mB.mA.mA = mat4x2(-5.0, 9.0, -7.0, -8.0, 1.0, 6.0, 0.0, -3.0);
	s1.b.mB.mA.mB = f16vec3(4.0, -7.0, -1.0);
	s1.b.mB.mA.mC = mat3x2(5.0, -3.0, 0.0, -8.0, 1.0, -9.0);
	s1.b.mB.mB.mA = uint16_t(8u);
	s1.b.mB.mC = vec2(-9.0, -7.0);
	s1.b.mC.mA.mA = mat3(7.0, -2.0, 2.0, -4.0, 4.0, -8.0, 4.0, 8.0, 5.0);
	s1.c.mA.mA.mA = float16_t(-7.0);
	s1.c.mA.mA.mB = mat3x2(-8.0, -5.0, 0.0, 1.0, -4.0, -9.0);
	s1.c.mA.mB = uint16_t(7u);
	s1.c.mA.mC = u16vec2(3u, 4u);
	s1.c.mB.mA.mA = i16vec2(1, 5);
	s1.c.mB.mA.mB = mat4x3(4.0, -7.0, 6.0, 8.0, 0.0, -7.0, -8.0, -7.0, -3.0, 3.0, 2.0, -8.0);
	s1.c.mB.mA.mC = float16_t(-1.0);
	s1.c.mB.mB.mA = mat3x4(-7.0, 0.0, 6.0, -5.0, 4.0, -3.0, 7.0, -5.0, 1.0, 8.0, 0.0, -3.0);
	s1.c.mB.mB.mB = i16vec2(-8, 6);
	s1.c.mB.mB.mC = ivec2(-2, 5);
	s1.c.mC = float16_t(8.0);
	s2.a.mA.mA.mA = vec2(8.0, -5.0);
	s2.a.mA.mA.mB = int16_t(4);
	s2.a.mA.mA.mC = uvec4(3u, 7u, 8u, 3u);
	s2.a.mA.mB.mA = i16vec3(4, 4, 0);
	s2.b.mA.mA.mA = mat3x2(7.0, 4.0, 8.0, -9.0, -8.0, 6.0);
	s2.b.mB = f16vec2(-4.0, -4.0);
	s2.b.mC.mA = f16vec4(-2.0, 5.0, 0.0, 4.0);
	s2.b.mC.mB.mA = f16vec2(9.0, 5.0);
	s2.b.mC.mB.mB = u16vec3(9u, 2u, 0u);
	s2.b.mC.mC.mA = uvec2(1u, 8u);
	s2.b.mC.mC.mB = i16vec2(2, -1);
	s2.b.mC.mC.mC = ivec4(5, 1, 3, 0);
	s3.a = vec3(-7.0, 9.0, 6.0);
	s3.b.mA = f16vec3(-5.0, 1.0, -8.0);
	s3.b.mB.mA = int16_t(-2);
	s3.b.mB.mB.mA = mat4x3(-5.0, -1.0, -2.0, 9.0, 6.0, 9.0, -6.0, 5.0, 2.0, -5.0, 9.0, 2.0);
	s3.b.mB.mB.mB = u16vec2(2u, 7u);
	s3.c.mA.mA.mA = float16_t(6.0);
	s3.c.mA.mA.mB = f16vec2(9.0, -4.0);
	s3.c.mA.mA.mC = mat4(6.0, -1.0, -1.0, 6.0, 3.0, -6.0, -3.0, 8.0, -1.0, 5.0, 6.0, 5.0, -4.0, 5.0, 8.0, -9.0);
	s3.c.mA.mB = bvec2(false, false);
	s3.d.mA.mA.mA = i16vec3(3, 1, 5);
	s3.d.mA.mA.mB = mat4(-3.0, -7.0, 8.0, -4.0, 0.0, 7.0, 2.0, -8.0, 7.0, -6.0, -9.0, 7.0, 7.0, -4.0, 5.0, 9.0);
	s3.d.mA.mB.mA = f16vec2(7.0, -1.0);
	s3.d.mA.mB.mB = bvec3(true, true, true);
	s3.d.mA.mB.mC = vec3(8.0, 1.0, -2.0);
	s3.d.mB.mA.mA = 7u;
	s3.d.mB.mA.mB = i16vec3(0, 5, 6);
	s3.d.mB.mB.mA = u16vec2(7u, 4u);
	s3.d.mB.mB.mB = ivec4(-6, 1, -8, 5);
	s3.d.mB.mC.mA = u16vec4(8u, 5u, 1u, 4u);
	s3.d.mB.mC.mB = vec2(-8.0, 2.0);
	s3.d.mC.mA.mA = f16vec4(8.0, -4.0, -4.0, 8.0);
	s3.d.mC.mA.mB = i16vec3(8, -7, -5);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_bvec4(bvec4(true, false, false, false), s1.a.mA.mA) && allOk;
	allOk = compare_mat4(mat4(7.0, 5.0, -6.0, 1.0, 9.0, -4.0, -3.0, 4.0, 4.0, 9.0, -9.0, -8.0, -9.0, 8.0, 0.0, 4.0), s1.a.mA.mB.mA) && allOk;
	allOk = compare_int(-4, s1.a.mA.mB.mB) && allOk;
	allOk = compare_i16vec3(ivec3(7, 2, -1), ivec3(s1.a.mA.mC.mA)) && allOk;
	allOk = compare_float16_t(float(7.0), float(s1.a.mA.mC.mB)) && allOk;
	allOk = compare_vec4(vec4(-5.0, -4.0, 3.0, -5.0), s1.a.mA.mC.mC) && allOk;
	allOk = compare_i16vec4(ivec4(-3, -1, 1, 0), ivec4(s1.a.mB.mA)) && allOk;
	allOk = compare_i16vec2(ivec2(-3, 1), ivec2(s1.a.mB.mB)) && allOk;
	allOk = compare_vec3(vec3(3.0, -9.0, -4.0), s1.a.mB.mC) && allOk;
	allOk = compare_uvec3(uvec3(2u, 2u, 8u), s1.a.mC) && allOk;
	allOk = compare_f16vec2(vec2(3.0, -9.0), vec2(s1.b.mA.mA.mA)) && allOk;
	allOk = compare_mat4x2(mat4x2(-5.0, 9.0, -7.0, -8.0, 1.0, 6.0, 0.0, -3.0), s1.b.mB.mA.mA) && allOk;
	allOk = compare_f16vec3(vec3(4.0, -7.0, -1.0), vec3(s1.b.mB.mA.mB)) && allOk;
	allOk = compare_mat3x2(mat3x2(5.0, -3.0, 0.0, -8.0, 1.0, -9.0), s1.b.mB.mA.mC) && allOk;
	allOk = compare_uint16_t(uint(8u), uint(s1.b.mB.mB.mA)) && allOk;
	allOk = compare_vec2(vec2(-9.0, -7.0), s1.b.mB.mC) && allOk;
	allOk = compare_mat3(mat3(7.0, -2.0, 2.0, -4.0, 4.0, -8.0, 4.0, 8.0, 5.0), s1.b.mC.mA.mA) && allOk;
	allOk = compare_float16_t(float(-7.0), float(s1.c.mA.mA.mA)) && allOk;
	allOk = compare_mat3x2(mat3x2(-8.0, -5.0, 0.0, 1.0, -4.0, -9.0), s1.c.mA.mA.mB) && allOk;
	allOk = compare_uint16_t(uint(7u), uint(s1.c.mA.mB)) && allOk;
	allOk = compare_u16vec2(uvec2(3u, 4u), uvec2(s1.c.mA.mC)) && allOk;
	allOk = compare_i16vec2(ivec2(1, 5), ivec2(s1.c.mB.mA.mA)) && allOk;
	allOk = compare_mat4x3(mat4x3(4.0, -7.0, 6.0, 8.0, 0.0, -7.0, -8.0, -7.0, -3.0, 3.0, 2.0, -8.0), s1.c.mB.mA.mB) && allOk;
	allOk = compare_float16_t(float(-1.0), float(s1.c.mB.mA.mC)) && allOk;
	allOk = compare_mat3x4(mat3x4(-7.0, 0.0, 6.0, -5.0, 4.0, -3.0, 7.0, -5.0, 1.0, 8.0, 0.0, -3.0), s1.c.mB.mB.mA) && allOk;
	allOk = compare_i16vec2(ivec2(-8, 6), ivec2(s1.c.mB.mB.mB)) && allOk;
	allOk = compare_ivec2(ivec2(-2, 5), s1.c.mB.mB.mC) && allOk;
	allOk = compare_float16_t(float(8.0), float(s1.c.mC)) && allOk;
	allOk = compare_vec2(vec2(8.0, -5.0), s2.a.mA.mA.mA) && allOk;
	allOk = compare_int16_t(int(4), int(s2.a.mA.mA.mB)) && allOk;
	allOk = compare_uvec4(uvec4(3u, 7u, 8u, 3u), s2.a.mA.mA.mC) && allOk;
	allOk = compare_i16vec3(ivec3(4, 4, 0), ivec3(s2.a.mA.mB.mA)) && allOk;
	allOk = compare_mat3x2(mat3x2(7.0, 4.0, 8.0, -9.0, -8.0, 6.0), s2.b.mA.mA.mA) && allOk;
	allOk = compare_f16vec2(vec2(-4.0, -4.0), vec2(s2.b.mB)) && allOk;
	allOk = compare_f16vec4(vec4(-2.0, 5.0, 0.0, 4.0), vec4(s2.b.mC.mA)) && allOk;
	allOk = compare_f16vec2(vec2(9.0, 5.0), vec2(s2.b.mC.mB.mA)) && allOk;
	allOk = compare_u16vec3(uvec3(9u, 2u, 0u), uvec3(s2.b.mC.mB.mB)) && allOk;
	allOk = compare_uvec2(uvec2(1u, 8u), s2.b.mC.mC.mA) && allOk;
	allOk = compare_i16vec2(ivec2(2, -1), ivec2(s2.b.mC.mC.mB)) && allOk;
	allOk = compare_ivec4(ivec4(5, 1, 3, 0), s2.b.mC.mC.mC) && allOk;
	allOk = compare_vec3(vec3(-7.0, 9.0, 6.0), s3.a) && allOk;
	allOk = compare_f16vec3(vec3(-5.0, 1.0, -8.0), vec3(s3.b.mA)) && allOk;
	allOk = compare_int16_t(int(-2), int(s3.b.mB.mA)) && allOk;
	allOk = compare_mat4x3(mat4x3(-5.0, -1.0, -2.0, 9.0, 6.0, 9.0, -6.0, 5.0, 2.0, -5.0, 9.0, 2.0), s3.b.mB.mB.mA) && allOk;
	allOk = compare_u16vec2(uvec2(2u, 7u), uvec2(s3.b.mB.mB.mB)) && allOk;
	allOk = compare_float16_t(float(6.0), float(s3.c.mA.mA.mA)) && allOk;
	allOk = compare_f16vec2(vec2(9.0, -4.0), vec2(s3.c.mA.mA.mB)) && allOk;
	allOk = compare_mat4(mat4(6.0, -1.0, -1.0, 6.0, 3.0, -6.0, -3.0, 8.0, -1.0, 5.0, 6.0, 5.0, -4.0, 5.0, 8.0, -9.0), s3.c.mA.mA.mC) && allOk;
	allOk = compare_bvec2(bvec2(false, false), s3.c.mA.mB) && allOk;
	allOk = compare_i16vec3(ivec3(3, 1, 5), ivec3(s3.d.mA.mA.mA)) && allOk;
	allOk = compare_mat4(mat4(-3.0, -7.0, 8.0, -4.0, 0.0, 7.0, 2.0, -8.0, 7.0, -6.0, -9.0, 7.0, 7.0, -4.0, 5.0, 9.0), s3.d.mA.mA.mB) && allOk;
	allOk = compare_f16vec2(vec2(7.0, -1.0), vec2(s3.d.mA.mB.mA)) && allOk;
	allOk = compare_bvec3(bvec3(true, true, true), s3.d.mA.mB.mB) && allOk;
	allOk = compare_vec3(vec3(8.0, 1.0, -2.0), s3.d.mA.mB.mC) && allOk;
	allOk = compare_uint(7u, s3.d.mB.mA.mA) && allOk;
	allOk = compare_i16vec3(ivec3(0, 5, 6), ivec3(s3.d.mB.mA.mB)) && allOk;
	allOk = compare_u16vec2(uvec2(7u, 4u), uvec2(s3.d.mB.mB.mA)) && allOk;
	allOk = compare_ivec4(ivec4(-6, 1, -8, 5), s3.d.mB.mB.mB) && allOk;
	allOk = compare_u16vec4(uvec4(8u, 5u, 1u, 4u), uvec4(s3.d.mB.mC.mA)) && allOk;
	allOk = compare_vec2(vec2(-8.0, 2.0), s3.d.mB.mC.mB) && allOk;
	allOk = compare_f16vec4(vec4(8.0, -4.0, -4.0, 8.0), vec4(s3.d.mC.mA.mA)) && allOk;
	allOk = compare_i16vec3(ivec3(8, -7, -5), ivec3(s3.d.mC.mA.mB)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	u16vec2 mA;
	f16vec3 mB;
};
struct sB
{
	i16vec4 mA;
};
struct sC
{
	sA mA;
	sB mB;
	u16vec4 mC;
};
struct sD
{
	sC mA;
};
struct sE
{
	u16vec2 mA;
	mediump mat2 mB;
};
struct sF
{
	i16vec4 mA;
};
struct sG
{
	sE mA;
	sF mB;
};
struct sH
{
	u16vec4 mA;
	mediump uint mB;
};
struct sI
{
	i16vec4 mA;
	lowp uvec4 mB;
};
struct sJ
{
	i16vec2 mA;
	sH mB;
	sI mC;
};
struct sK
{
	u16vec4 mA;
	sG mB;
	sJ mC;
};
struct sL
{
	lowp uvec2 mA;
};
struct sM
{
	f16vec4 mA;
	u16vec3 mB;
	mediump ivec3 mC;
};
struct sN
{
	highp mat3 mA;
};
struct sO
{
	sM mA;
	f16vec3 mB;
	sN mC;
};
struct sP
{
	sL mA;
	highp uvec4 mB;
	sO mC;
};
struct sQ
{
	u16vec2 mA;
	uint16_t mB;
};
struct sR
{
	sQ mA;
	mediump ivec4 mB;
};
struct sS
{
	mediump mat4 mA;
	bvec4 mB;
	i16vec2 mC;
};
struct sT
{
	float16_t mA;
	lowp float mB;
};
struct sU
{
	sS mA;
	sT mB;
};
struct sV
{
	i16vec4 mA;
};
struct sW
{
	sV mA;
	f16vec3 mB;
};
struct sX
{
	highp vec4 mA;
};
struct sY
{
	u16vec2 mA;
	lowp uint mB;
	float16_t mC;
};
struct sZ
{
	f16vec3 mA;
	sX mB;
	sY mC;
};
struct sAA
{
	sU mA;
	sW mB;
	sZ mC;
};
struct S1 {
	sD a;
	i16vec3 b;
};
struct S2 {
	sK a;
	sP b;
	sR c;
	sAA d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a.mA.mA.mA = u16vec2(1u, 9u);
	s1.a.mA.mA.mB = f16vec3(-9.0, -5.0, 1.0);
	s1.a.mA.mB.mA = i16vec4(-7, 1, 2, 8);
	s1.a.mA.mC = u16vec4(7u, 6u, 0u, 7u);
	s1.b = i16vec3(9, 6, -5);
	s2.a.mA = u16vec4(4u, 1u, 2u, 0u);
	s2.a.mB.mA.mA = u16vec2(8u, 8u);
	s2.a.mB.mA.mB = mat2(9.0, 2.0, -5.0, 1.0);
	s2.a.mB.mB.mA = i16vec4(-6, 8, 5, 5);
	s2.a.mC.mA = i16vec2(-3, 3);
	s2.a.mC.mB.mA = u16vec4(2u, 4u, 8u, 8u);
	s2.a.mC.mB.mB = 8u;
	s2.a.mC.mC.mA = i16vec4(9, -3, 3, 1);
	s2.a.mC.mC.mB = uvec4(1u, 0u, 0u, 6u);
	s2.b.mA.mA = uvec2(6u, 1u);
	s2.b.mB = uvec4(6u, 7u, 9u, 8u);
	s2.b.mC.mA.mA = f16vec4(-4.0, -4.0, 0.0, 1.0);
	s2.b.mC.mA.mB = u16vec3(6u, 7u, 2u);
	s2.b.mC.mA.mC = ivec3(6, 5, -5);
	s2.b.mC.mB = f16vec3(2.0, 4.0, 9.0);
	s2.b.mC.mC.mA = mat3(2.0, 5.0, -2.0, -4.0, 7.0, 1.0, -8.0, -9.0, 5.0);
	s2.c.mA.mA = u16vec2(8u, 4u);
	s2.c.mA.mB = uint16_t(8u);
	s2.c.mB = ivec4(-3, 6, 6, 2);
	s2.d.mA.mA.mA = mat4(4.0, 4.0, -3.0, 3.0, 8.0, 6.0, -3.0, 4.0, -7.0, 1.0, -5.0, -9.0, 7.0, -6.0, 6.0, -3.0);
	s2.d.mA.mA.mB = bvec4(true, false, false, false);
	s2.d.mA.mA.mC = i16vec2(2, -2);
	s2.d.mA.mB.mA = float16_t(-6.0);
	s2.d.mA.mB.mB = 4.0;
	s2.d.mB.mA.mA = i16vec4(-8, 7, 1, -6);
	s2.d.mB.mB = f16vec3(8.0, 4.0, -4.0);
	s2.d.mC.mA = f16vec3(6.0, -7.0, 7.0);
	s2.d.mC.mB.mA = vec4(-2.0, -7.0, 4.0, 1.0);
	s2.d.mC.mC.mA = u16vec2(1u, 3u);
	s2.d.mC.mC.mB = 7u;
	s2.d.mC.mC.mC = float16_t(6.0);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_u16vec2(uvec2(1u, 9u), uvec2(s1.a.mA.mA.mA)) && allOk;
	allOk = compare_f16vec3(vec3(-9.0, -5.0, 1.0), vec3(s1.a.mA.mA.mB)) && allOk;
	allOk = compare_i16vec4(ivec4(-7, 1, 2, 8), ivec4(s1.a.mA.mB.mA)) && allOk;
	allOk = compare_u16vec4(uvec4(7u, 6u, 0u, 7u), uvec4(s1.a.mA.mC)) && allOk;
	allOk = compare_i16vec3(ivec3(9, 6, -5), ivec3(s1.b)) && allOk;
	allOk = compare_u16vec4(uvec4(4u, 1u, 2u, 0u), uvec4(s2.a.mA)) && allOk;
	allOk = compare_u16vec2(uvec2(8u, 8u), uvec2(s2.a.mB.mA.mA)) && allOk;
	allOk = compare_mat2(mat2(9.0, 2.0, -5.0, 1.0), s2.a.mB.mA.mB) && allOk;
	allOk = compare_i16vec4(ivec4(-6, 8, 5, 5), ivec4(s2.a.mB.mB.mA)) && allOk;
	allOk = compare_i16vec2(ivec2(-3, 3), ivec2(s2.a.mC.mA)) && allOk;
	allOk = compare_u16vec4(uvec4(2u, 4u, 8u, 8u), uvec4(s2.a.mC.mB.mA)) && allOk;
	allOk = compare_uint(8u, s2.a.mC.mB.mB) && allOk;
	allOk = compare_i16vec4(ivec4(9, -3, 3, 1), ivec4(s2.a.mC.mC.mA)) && allOk;
	allOk = compare_uvec4(uvec4(1u, 0u, 0u, 6u), s2.a.mC.mC.mB) && allOk;
	allOk = compare_uvec2(uvec2(6u, 1u), s2.b.mA.mA) && allOk;
	allOk = compare_uvec4(uvec4(6u, 7u, 9u, 8u), s2.b.mB) && allOk;
	allOk = compare_f16vec4(vec4(-4.0, -4.0, 0.0, 1.0), vec4(s2.b.mC.mA.mA)) && allOk;
	allOk = compare_u16vec3(uvec3(6u, 7u, 2u), uvec3(s2.b.mC.mA.mB)) && allOk;
	allOk = compare_ivec3(ivec3(6, 5, -5), s2.b.mC.mA.mC) && allOk;
	allOk = compare_f16vec3(vec3(2.0, 4.0, 9.0), vec3(s2.b.mC.mB)) && allOk;
	allOk = compare_mat3(mat3(2.0, 5.0, -2.0, -4.0, 7.0, 1.0, -8.0, -9.0, 5.0), s2.b.mC.mC.mA) && allOk;
	allOk = compare_u16vec2(uvec2(8u, 4u), uvec2(s2.c.mA.mA)) && allOk;
	allOk = compare_uint16_t(uint(8u), uint(s2.c.mA.mB)) && allOk;
	allOk = compare_ivec4(ivec4(-3, 6, 6, 2), s2.c.mB) && allOk;
	allOk = compare_mat4(mat4(4.0, 4.0, -3.0, 3.0, 8.0, 6.0, -3.0, 4.0, -7.0, 1.0, -5.0, -9.0, 7.0, -6.0, 6.0, -3.0), s2.d.mA.mA.mA) && allOk;
	allOk = compare_bvec4(bvec4(true, false, false, false), s2.d.mA.mA.mB) && allOk;
	allOk = compare_i16vec2(ivec2(2, -2), ivec2(s2.d.mA.mA.mC)) && allOk;
	allOk = compare_float16_t(float(-6.0), float(s2.d.mA.mB.mA)) && allOk;
	allOk = compare_float(4.0, s2.d.mA.mB.mB) && allOk;
	allOk = compare_i16vec4(ivec4(-8, 7, 1, -6), ivec4(s2.d.mB.mA.mA)) && allOk;
	allOk = compare_f16vec3(vec3(8.0, 4.0, -4.0), vec3(s2.d.mB.mB)) && allOk;
	allOk = compare_f16vec3(vec3(6.0, -7.0, 7.0), vec3(s2.d.mC.mA)) && allOk;
	allOk = compare_vec4(vec4(-2.0, -7.0, 4.0, 1.0), s2.d.mC.mB.mA) && allOk;
	allOk = compare_u16vec2(uvec2(1u, 3u), uvec2(s2.d.mC.mC.mA)) && allOk;
	allOk = compare_uint(7u, s2.d.mC.mC.mB) && allOk;
	allOk = compare_float16_t(float(6.0), float(s2.d.mC.mC.mC)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	f16vec3 mA;
	u16vec4 mB;
	u16vec3 mC;
};
struct sB
{
	sA mA;
	mediump mat2x3 mB;
};
struct sC
{
	float16_t mA;
	f16vec3 mB;
	uint16_t mC;
};
struct sD
{
	highp uint mA;
};
struct sE
{
	sC mA;
	i16vec3 mB;
	sD mC;
};
struct sF
{
	sB mA;
	u16vec3 mB;
	sE mC;
};
struct sG
{
	f16vec2 mA;
};
struct sH
{
	sG mA;
	highp float mB;
};
struct sI
{
	u16vec3 mA;
	highp ivec4 mB;
	f16vec4 mC;
};
struct sJ
{
	sI mA;
};
struct sK
{
	sH mA;
	sJ mB;
};
struct sL
{
	i16vec3 mA;
	bvec4 mB;
	mediump vec2 mC;
};
struct sM
{
	u16vec3 mA;
	uint16_t mB;
};
struct sN
{
	sL mA;
	sM mB;
};
struct sO
{
	lowp ivec3 mA;
	highp ivec3 mB;
};
struct sP
{
	f16vec3 mA;
	highp mat3 mB;
	u16vec3 mC;
};
struct sQ
{
	sO mA;
	sP mB;
	f16vec2 mC;
};
struct sR
{
	sN mA;
	sQ mB;
};
struct S1 {
	sF a;
	i16vec2 b;
	i16vec2 c;
};
struct S2 {
	sK a;
	sR b;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a.mA.mA.mA = f16vec3(2.0, 7.0, -9.0);
	s1.a.mA.mA.mB = u16vec4(9u, 3u, 9u, 6u);
	s1.a.mA.mA.mC = u16vec3(5u, 8u, 8u);
	s1.a.mA.mB = mat2x3(1.0, -5.0, -2.0, 0.0, 9.0, -1.0);
	s1.a.mB = u16vec3(2u, 3u, 8u);
	s1.a.mC.mA.mA = float16_t(6.0);
	s1.a.mC.mA.mB = f16vec3(1.0, -6.0, 0.0);
	s1.a.mC.mA.mC = uint16_t(4u);
	s1.a.mC.mB = i16vec3(5, 6, 4);
	s1.a.mC.mC.mA = 8u;
	s1.b = i16vec2(-7, -5);
	s1.c = i16vec2(1, 2);
	s2.a.mA.mA.mA = f16vec2(-7.0, 5.0);
	s2.a.mA.mB = -6.0;
	s2.a.mB.mA.mA = u16vec3(3u, 5u, 0u);
	s2.a.mB.mA.mB = ivec4(-5, 9, -9, -2);
	s2.a.mB.mA.mC = f16vec4(6.0, -7.0, 8.0, 3.0);
	s2.b.mA.mA.mA = i16vec3(9, 7, 9);
	s2.b.mA.mA.mB = bvec4(false, false, false, false);
	s2.b.mA.mA.mC = vec2(1.0, -8.0);
	s2.b.mA.mB.mA = u16vec3(6u, 7u, 7u);
	s2.b.mA.mB.mB = uint16_t(5u);
	s2.b.mB.mA.mA = ivec3(3, 2, 3);
	s2.b.mB.mA.mB = ivec3(1, 9, -4);
	s2.b.mB.mB.mA = f16vec3(4.0, 8.0, 2.0);
	s2.b.mB.mB.mB = mat3(3.0, 0.0, -1.0, -9.0, -8.0, -2.0, 1.0, 1.0, -7.0);
	s2.b.mB.mB.mC = u16vec3(6u, 9u, 5u);
	s2.b.mB.mC = f16vec2(0.0, -3.0);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_f16vec3(vec3(2.0, 7.0, -9.0), vec3(s1.a.mA.mA.mA)) && allOk;
	allOk = compare_u16vec4(uvec4(9u, 3u, 9u, 6u), uvec4(s1.a.mA.mA.mB)) && allOk;
	allOk = compare_u16vec3(uvec3(5u, 8u, 8u), uvec3(s1.a.mA.mA.mC)) && allOk;
	allOk = compare_mat2x3(mat2x3(1.0, -5.0, -2.0, 0.0, 9.0, -1.0), s1.a.mA.mB) && allOk;
	allOk = compare_u16vec3(uvec3(2u, 3u, 8u), uvec3(s1.a.mB)) && allOk;
	allOk = compare_float16_t(float(6.0), float(s1.a.mC.mA.mA)) && allOk;
	allOk = compare_f16vec3(vec3(1.0, -6.0, 0.0), vec3(s1.a.mC.mA.mB)) && allOk;
	allOk = compare_uint16_t(uint(4u), uint(s1.a.mC.mA.mC)) && allOk;
	allOk = compare_i16vec3(ivec3(5, 6, 4), ivec3(s1.a.mC.mB)) && allOk;
	allOk = compare_uint(8u, s1.a.mC.mC.mA) && allOk;
	allOk = compare_i16vec2(ivec2(-7, -5), ivec2(s1.b)) && allOk;
	allOk = compare_i16vec2(ivec2(1, 2), ivec2(s1.c)) && allOk;
	allOk = compare_f16vec2(vec2(-7.0, 5.0), vec2(s2.a.mA.mA.mA)) && allOk;
	allOk = compare_float(-6.0, s2.a.mA.mB) && allOk;
	allOk = compare_u16vec3(uvec3(3u, 5u, 0u), uvec3(s2.a.mB.mA.mA)) && allOk;
	allOk = compare_ivec4(ivec4(-5, 9, -9, -2), s2.a.mB.mA.mB) && allOk;
	allOk = compare_f16vec4(vec4(6.0, -7.0, 8.0, 3.0), vec4(s2.a.mB.mA.mC)) && allOk;
	allOk = compare_i16vec3(ivec3(9, 7, 9), ivec3(s2.b.mA.mA.mA)) && allOk;
	allOk = compare_bvec4(bvec4(false, false, false, false), s2.b.mA.mA.mB) && allOk;
	allOk = compare_vec2(vec2(1.0, -8.0), s2.b.mA.mA.mC) && allOk;
	allOk = compare_u16vec3(uvec3(6u, 7u, 7u), uvec3(s2.b.mA.mB.mA)) && allOk;
	allOk = compare_uint16_t(uint(5u), uint(s2.b.mA.mB.mB)) && allOk;
	allOk = compare_ivec3(ivec3(3, 2, 3), s2.b.mB.mA.mA) && allOk;
	allOk = compare_ivec3(ivec3(1, 9, -4), s2.b.mB.mA.mB) && allOk;
	allOk = compare_f16vec3(vec3(4.0, 8.0, 2.0), vec3(s2.b.mB.mB.mA)) && allOk;
	allOk = compare_mat3(mat3(3.0, 0.0, -1.0, -9.0, -8.0, -2.0, 1.0, 1.0, -7.0), s2.b.mB.mB.mB) && allOk;
	allOk = compare_u16vec3(uvec3(6u, 9u, 5u), uvec3(s2.b.mB.mB.mC)) && allOk;
	allOk = compare_f16vec2(vec2(0.0, -3.0), vec2(s2.b.mB.mC)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	highp mat4x2 mA;
	uint16_t mB;
	uint16_t mC;
};
struct sB
{
	highp mat3x4 mA;
	f16vec2 mB;
};
struct sC
{
	sA mA;
	f16vec3 mB;
	sB mC;
};
struct sD
{
	sC mA;
};
struct S1 {
	sD a;
	mediump mat3x4 b;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

shared S1 s1;

void main (void) {
	s1.a.mA.mA.mA = mat4x2(2.0, -3.0, 2.0, -4.0, 4.0, 6.0, -2.0, -5.0);
	s1.a.mA.mA.mB = uint16_t(9u);
	s1.a.mA.mA.mC = uint16_t(5u);
	s1.a.mA.mB = f16vec3(1.0, -3.0, 8.0);
	s1.a.mA.mC.mA = mat3x4(7.0, 3.0, 3.0, -4.0, 8.0, -7.0, -9.0, -3.0, 4.0, -3.0, -7.0, -7.0);
	s1.a.mA.mC.mB = f16vec2(-1.0, 9.0);
	s1.b = mat3x4(-6.0, 8.0, -4.0, 4.0, 1.0, -6.0, -2.0, -3.0, -5.0, 4.0, 3.0, 0.0);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_mat4x2(mat4x2(2.0, -3.0, 2.0, -4.0, 4.0, 6.0, -2.0, -5.0), s1.a.mA.mA.mA) && allOk;
	allOk = compare_uint16_t(uint(9u), uint(s1.a.mA.mA.mB)) && allOk;
	allOk = compare_uint16_t(uint(5u), uint(s1.a.mA.mA.mC)) && allOk;
	allOk = compare_f16vec3(vec3(1.0, -3.0, 8.0), vec3(s1.a.mA.mB)) && allOk;
	allOk = compare_mat3x4(mat3x4(7.0, 3.0, 3.0, -4.0, 8.0, -7.0, -9.0, -3.0, 4.0, -3.0, -7.0, -7.0), s1.a.mA.mC.mA) && allOk;
	allOk = compare_f16vec2(vec2(-1.0, 9.0), vec2(s1.a.mA.mC.mB)) && allOk;
	allOk = compare_mat3x4(mat3x4(-6.0, 8.0, -4.0, 4.0, 1.0, -6.0, -2.0, -3.0, -5.0, 4.0, 3.0, 0.0), s1.b) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	bvec4 mA;
	highp mat3x2 mB;
};
struct sB
{
	sA mA;
};
struct sC
{
	highp int mA;
	sB mB;
	lowp ivec3 mC;
};
struct sD
{
	i16vec3 mA;
	uint16_t mB;
};
struct sE
{
	sD mA;
	u16vec4 mB;
	mediump ivec2 mC;
};
struct sF
{
	lowp uvec4 mA;
	bvec2 mB;
};
struct sG
{
	mediump mat2x3 mA;
	sF mB;
	mediump ivec2 mC;
};
struct sH
{
	u16vec2 mA;
};
struct sI
{
	sH mA;
	float16_t mB;
};
struct sJ
{
	sE mA;
	sG mB;
	sI mC;
};
struct S1 {
	u16vec3 a;
	sC b;
	sJ c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

shared S1 s1;

void main (void) {
	s1.a = u16vec3(2u, 3u, 7u);
	s1.b.mA = -7;
	s1.b.mB.mA.mA = bvec4(false, false, true, true);
	s1.b.mB.mA.mB = mat3x2(8.0, 6.0, -2.0, -6.0, 4.0, -6.0);
	s1.b.mC = ivec3(-3, 2, -9);
	s1.c.mA.mA.mA = i16vec3(-7, -5, -7);
	s1.c.mA.mA.mB = uint16_t(1u);
	s1.c.mA.mB = u16vec4(1u, 7u, 9u, 6u);
	s1.c.mA.mC = ivec2(-5, 0);
	s1.c.mB.mA = mat2x3(1.0, -8.0, 0.0, 3.0, -5.0, 5.0);
	s1.c.mB.mB.mA = uvec4(0u, 6u, 1u, 8u);
	s1.c.mB.mB.mB = bvec2(false, false);
	s1.c.mB.mC = ivec2(8, -3);
	s1.c.mC.mA.mA = u16vec2(9u, 9u);
	s1.c.mC.mB = float16_t(-9.0);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_u16vec3(uvec3(2u, 3u, 7u), uvec3(s1.a)) && allOk;
	allOk = compare_int(-7, s1.b.mA) && allOk;
	allOk = compare_bvec4(bvec4(false, false, true, true), s1.b.mB.mA.mA) && allOk;
	allOk = compare_mat3x2(mat3x2(8.0, 6.0, -2.0, -6.0, 4.0, -6.0), s1.b.mB.mA.mB) && allOk;
	allOk = compare_ivec3(ivec3(-3, 2, -9), s1.b.mC) && allOk;
	allOk = compare_i16vec3(ivec3(-7, -5, -7), ivec3(s1.c.mA.mA.mA)) && allOk;
	allOk = compare_uint16_t(uint(1u), uint(s1.c.mA.mA.mB)) && allOk;
	allOk = compare_u16vec4(uvec4(1u, 7u, 9u, 6u), uvec4(s1.c.mA.mB)) && allOk;
	allOk = compare_ivec2(ivec2(-5, 0), s1.c.mA.mC) && allOk;
	allOk = compare_mat2x3(mat2x3(1.0, -8.0, 0.0, 3.0, -5.0, 5.0), s1.c.mB.mA) && allOk;
	allOk = compare_uvec4(uvec4(0u, 6u, 1u, 8u), s1.c.mB.mB.mA) && allOk;
	allOk = compare_bvec2(bvec2(false, false), s1.c.mB.mB.mB) && allOk;
	allOk = compare_ivec2(ivec2(8, -3), s1.c.mB.mC) && allOk;
	allOk = compare_u16vec2(uvec2(9u, 9u), uvec2(s1.c.mC.mA.mA)) && allOk;
	allOk = compare_float16_t(float(-9.0), float(s1.c.mC.mB)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	i16vec4 mA;
};
struct sB
{
	lowp uint mA;
	bool mB;
};
struct sC
{
	float16_t mA;
};
struct sD
{
	sB mA;
	sC mB;
};
struct sE
{
	bvec2 mA;
	sD mB;
};
struct sF
{
	int16_t mA;
};
struct sG
{
	i16vec3 mA;
	bvec4 mB;
	int16_t mC;
};
struct sH
{
	sF mA;
	sG mB;
	bvec3 mC;
};
struct sI
{
	lowp mat2x3 mA;
	lowp vec3 mB;
};
struct sJ
{
	sI mA;
	uint16_t mB;
};
struct sK
{
	sH mA;
	sJ mB;
};
struct sL
{
	i16vec3 mA;
};
struct sM
{
	mediump mat4x2 mA;
	lowp mat4x3 mB;
	mediump mat3x2 mC;
};
struct sN
{
	sL mA;
	sM mB;
};
struct sO
{
	f16vec4 mA;
	int16_t mB;
};
struct sP
{
	sO mA;
	i16vec4 mB;
};
struct sQ
{
	lowp mat4 mA;
	highp uint mB;
	i16vec2 mC;
};
struct sR
{
	sQ mA;
};
struct sS
{
	sN mA;
	sP mB;
	sR mC;
};
struct sT
{
	uint16_t mA;
};
struct sU
{
	f16vec2 mA;
	sT mB;
	bool mC;
};
struct sV
{
	uint16_t mA;
	int16_t mB;
};
struct sW
{
	sV mA;
	highp mat2x3 mB;
};
struct sX
{
	sW mA;
};
struct sY
{
	mediump float mA;
	highp vec3 mB;
	uint16_t mC;
};
struct sZ
{
	mediump float mA;
	highp int mB;
};
struct sAA
{
	sY mA;
	sZ mB;
};
struct sAB
{
	sAA mA;
};
struct sAC
{
	mediump ivec2 mA;
};
struct sAD
{
	sAC mA;
};
struct sAE
{
	f16vec3 mA;
	sAD mB;
};
struct S1 {
	sA a;
	sE b;
};
struct S2 {
	sK a;
	sS b;
	sU c;
	sX d;
};
struct S3 {
	i16vec2 a;
	sAB b;
	bool c;
	sAE d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

shared S1 s1;
shared S2 s2;
shared S3 s3;

void main (void) {
	s1.a.mA = i16vec4(-5, 5, -6, -9);
	s1.b.mA = bvec2(true, true);
	s1.b.mB.mA.mA = 3u;
	s1.b.mB.mA.mB = true;
	s1.b.mB.mB.mA = float16_t(0.0);
	s2.a.mA.mA.mA = int16_t(5);
	s2.a.mA.mB.mA = i16vec3(-7, -5, -2);
	s2.a.mA.mB.mB = bvec4(true, true, false, true);
	s2.a.mA.mB.mC = int16_t(7);
	s2.a.mA.mC = bvec3(false, false, false);
	s2.a.mB.mA.mA = mat2x3(-2.0, -1.0, -5.0, 5.0, 3.0, 9.0);
	s2.a.mB.mA.mB = vec3(-5.0, 1.0, 8.0);
	s2.a.mB.mB = uint16_t(2u);
	s2.b.mA.mA.mA = i16vec3(4, -8, -3);
	s2.b.mA.mB.mA = mat4x2(-1.0, 4.0, -9.0, 7.0, 1.0, -4.0, 7.0, -6.0);
	s2.b.mA.mB.mB = mat4x3(0.0, 6.0, 8.0, 5.0, 9.0, -3.0, 2.0, 2.0, 3.0, 3.0, -7.0, 7.0);
	s2.b.mA.mB.mC = mat3x2(-3.0, -3.0, 8.0, 3.0, -1.0, 0.0);
	s2.b.mB.mA.mA = f16vec4(-6.0, -5.0, -3.0, -5.0);
	s2.b.mB.mA.mB = int16_t(2);
	s2.b.mB.mB = i16vec4(-9, 0, 5, -4);
	s2.b.mC.mA.mA = mat4(4.0, -4.0, -1.0, -4.0, -1.0, -1.0, -1.0, 9.0, -4.0, -4.0, -8.0, 9.0, -5.0, 7.0, -8.0, -2.0);
	s2.b.mC.mA.mB = 1u;
	s2.b.mC.mA.mC = i16vec2(4, 5);
	s2.c.mA = f16vec2(7.0, -9.0);
	s2.c.mB.mA = uint16_t(2u);
	s2.c.mC = false;
	s2.d.mA.mA.mA = uint16_t(5u);
	s2.d.mA.mA.mB = int16_t(-3);
	s2.d.mA.mB = mat2x3(8.0, 2.0, 7.0, -5.0, -3.0, 3.0);
	s3.a = i16vec2(4, -7);
	s3.b.mA.mA.mA = 0.0;
	s3.b.mA.mA.mB = vec3(2.0, -2.0, 2.0);
	s3.b.mA.mA.mC = uint16_t(9u);
	s3.b.mA.mB.mA = 2.0;
	s3.b.mA.mB.mB = 0;
	s3.c = false;
	s3.d.mA = f16vec3(3.0, 4.0, -4.0);
	s3.d.mB.mA.mA = ivec2(6, -9);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_i16vec4(ivec4(-5, 5, -6, -9), ivec4(s1.a.mA)) && allOk;
	allOk = compare_bvec2(bvec2(true, true), s1.b.mA) && allOk;
	allOk = compare_uint(3u, s1.b.mB.mA.mA) && allOk;
	allOk = compare_bool(true, s1.b.mB.mA.mB) && allOk;
	allOk = compare_float16_t(float(0.0), float(s1.b.mB.mB.mA)) && allOk;
	allOk = compare_int16_t(int(5), int(s2.a.mA.mA.mA)) && allOk;
	allOk = compare_i16vec3(ivec3(-7, -5, -2), ivec3(s2.a.mA.mB.mA)) && allOk;
	allOk = compare_bvec4(bvec4(true, true, false, true), s2.a.mA.mB.mB) && allOk;
	allOk = compare_int16_t(int(7), int(s2.a.mA.mB.mC)) && allOk;
	allOk = compare_bvec3(bvec3(false, false, false), s2.a.mA.mC) && allOk;
	allOk = compare_mat2x3(mat2x3(-2.0, -1.0, -5.0, 5.0, 3.0, 9.0), s2.a.mB.mA.mA) && allOk;
	allOk = compare_vec3(vec3(-5.0, 1.0, 8.0), s2.a.mB.mA.mB) && allOk;
	allOk = compare_uint16_t(uint(2u), uint(s2.a.mB.mB)) && allOk;
	allOk = compare_i16vec3(ivec3(4, -8, -3), ivec3(s2.b.mA.mA.mA)) && allOk;
	allOk = compare_mat4x2(mat4x2(-1.0, 4.0, -9.0, 7.0, 1.0, -4.0, 7.0, -6.0), s2.b.mA.mB.mA) && allOk;
	allOk = compare_mat4x3(mat4x3(0.0, 6.0, 8.0, 5.0, 9.0, -3.0, 2.0, 2.0, 3.0, 3.0, -7.0, 7.0), s2.b.mA.mB.mB) && allOk;
	allOk = compare_mat3x2(mat3x2(-3.0, -3.0, 8.0, 3.0, -1.0, 0.0), s2.b.mA.mB.mC) && allOk;
	allOk = compare_f16vec4(vec4(-6.0, -5.0, -3.0, -5.0), vec4(s2.b.mB.mA.mA)) && allOk;
	allOk = compare_int16_t(int(2), int(s2.b.mB.mA.mB)) && allOk;
	allOk = compare_i16vec4(ivec4(-9, 0, 5, -4), ivec4(s2.b.mB.mB)) && allOk;
	allOk = compare_mat4(mat4(4.0, -4.0, -1.0, -4.0, -1.0, -1.0, -1.0, 9.0, -4.0, -4.0, -8.0, 9.0, -5.0, 7.0, -8.0, -2.0), s2.b.mC.mA.mA) && allOk;
	allOk = compare_uint(1u, s2.b.mC.mA.mB) && allOk;
	allOk = compare_i16vec2(ivec2(4, 5), ivec2(s2.b.mC.mA.mC)) && allOk;
	allOk = compare_f16vec2(vec2(7.0, -9.0), vec2(s2.c.mA)) && allOk;
	allOk = compare_uint16_t(uint(2u), uint(s2.c.mB.mA)) && allOk;
	allOk = compare_bool(false, s2.c.mC) && allOk;
	allOk = compare_uint16_t(uint(5u), uint(s2.d.mA.mA.mA)) && allOk;
	allOk = compare_int16_t(int(-3), int(s2.d.mA.mA.mB)) && allOk;
	allOk = compare_mat2x3(mat2x3(8.0, 2.0, 7.0, -5.0, -3.0, 3.0), s2.d.mA.mB) && allOk;
	allOk = compare_i16vec2(ivec2(4, -7), ivec2(s3.a)) && allOk;
	allOk = compare_float(0.0, s3.b.mA.mA.mA) && allOk;
	allOk = compare_vec3(vec3(2.0, -2.0, 2.0), s3.b.mA.mA.mB) && allOk;
	allOk = compare_uint16_t(uint(9u), uint(s3.b.mA.mA.mC)) && allOk;
	allOk = compare_float(2.0, s3.b.mA.mB.mA) && allOk;
	allOk = compare_int(0, s3.b.mA.mB.mB) && allOk;
	allOk = compare_bool(false, s3.c) && allOk;
	allOk = compare_f16vec3(vec3(3.0, 4.0, -4.0), vec3(s3.d.mA)) && allOk;
	allOk = compare_ivec2(ivec2(6, -9), s3.d.mB.mA.mA) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	bvec4 mA;
	f16vec3 mB;
	f16vec4 mC;
};
struct sB
{
	sA mA;
};
struct sC
{
	sB mA;
};
struct sD
{
	f16vec4 mA;
};
struct sE
{
	f16vec3 mA;
	bvec4 mB;
};
struct sF
{
	f16vec4 mA;
	highp mat2x3 mB;
};
struct sG
{
	sE mA;
	f16vec2 mB;
	sF mC;
};
struct sH
{
	sG mA;
};
struct sI
{
	u16vec3 mA;
	f16vec2 mB;
	int16_t mC;
};
struct sJ
{
	float16_t mA;
	u16vec4 mB;
};
struct sK
{
	f16vec3 mA;
	f16vec4 mB;
	u16vec3 mC;
};
struct sL
{
	sI mA;
	sJ mB;
	sK mC;
};
struct sM
{
	f16vec3 mA;
};
struct sN
{
	sM mA;
};
struct sO
{
	sL mA;
	sN mB;
	lowp mat4x2 mC;
};
struct S1 {
	u16vec3 a;
	sC b;
	sD c;
};
struct S2 {
	lowp mat3x2 a;
	sH b;
	sO c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a = u16vec3(2u, 5u, 1u);
	s1.b.mA.mA.mA = bvec4(false, true, true, true);
	s1.b.mA.mA.mB = f16vec3(1.0, -8.0, -1.0);
	s1.b.mA.mA.mC = f16vec4(4.0, -7.0, 3.0, 8.0);
	s1.c.mA = f16vec4(1.0, 9.0, 5.0, -4.0);
	s2.a = mat3x2(1.0, -4.0, -4.0, -3.0, 1.0, 5.0);
	s2.b.mA.mA.mA = f16vec3(6.0, 9.0, 0.0);
	s2.b.mA.mA.mB = bvec4(true, false, false, false);
	s2.b.mA.mB = f16vec2(6.0, 6.0);
	s2.b.mA.mC.mA = f16vec4(-8.0, 6.0, 6.0, 5.0);
	s2.b.mA.mC.mB = mat2x3(1.0, 4.0, 6.0, -4.0, 0.0, 1.0);
	s2.c.mA.mA.mA = u16vec3(5u, 0u, 1u);
	s2.c.mA.mA.mB = f16vec2(-9.0, 9.0);
	s2.c.mA.mA.mC = int16_t(3);
	s2.c.mA.mB.mA = float16_t(-9.0);
	s2.c.mA.mB.mB = u16vec4(8u, 9u, 9u, 6u);
	s2.c.mA.mC.mA = f16vec3(1.0, -6.0, -5.0);
	s2.c.mA.mC.mB = f16vec4(9.0, 1.0, 5.0, -7.0);
	s2.c.mA.mC.mC = u16vec3(1u, 6u, 3u);
	s2.c.mB.mA.mA = f16vec3(-5.0, 8.0, 5.0);
	s2.c.mC = mat4x2(-4.0, -1.0, -8.0, 4.0, -7.0, 1.0, 4.0, -2.0);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_u16vec3(uvec3(2u, 5u, 1u), uvec3(s1.a)) && allOk;
	allOk = compare_bvec4(bvec4(false, true, true, true), s1.b.mA.mA.mA) && allOk;
	allOk = compare_f16vec3(vec3(1.0, -8.0, -1.0), vec3(s1.b.mA.mA.mB)) && allOk;
	allOk = compare_f16vec4(vec4(4.0, -7.0, 3.0, 8.0), vec4(s1.b.mA.mA.mC)) && allOk;
	allOk = compare_f16vec4(vec4(1.0, 9.0, 5.0, -4.0), vec4(s1.c.mA)) && allOk;
	allOk = compare_mat3x2(mat3x2(1.0, -4.0, -4.0, -3.0, 1.0, 5.0), s2.a) && allOk;
	allOk = compare_f16vec3(vec3(6.0, 9.0, 0.0), vec3(s2.b.mA.mA.mA)) && allOk;
	allOk = compare_bvec4(bvec4(true, false, false, false), s2.b.mA.mA.mB) && allOk;
	allOk = compare_f16vec2(vec2(6.0, 6.0), vec2(s2.b.mA.mB)) && allOk;
	allOk = compare_f16vec4(vec4(-8.0, 6.0, 6.0, 5.0), vec4(s2.b.mA.mC.mA)) && allOk;
	allOk = compare_mat2x3(mat2x3(1.0, 4.0, 6.0, -4.0, 0.0, 1.0), s2.b.mA.mC.mB) && allOk;
	allOk = compare_u16vec3(uvec3(5u, 0u, 1u), uvec3(s2.c.mA.mA.mA)) && allOk;
	allOk = compare_f16vec2(vec2(-9.0, 9.0), vec2(s2.c.mA.mA.mB)) && allOk;
	allOk = compare_int16_t(int(3), int(s2.c.mA.mA.mC)) && allOk;
	allOk = compare_float16_t(float(-9.0), float(s2.c.mA.mB.mA)) && allOk;
	allOk = compare_u16vec4(uvec4(8u, 9u, 9u, 6u), uvec4(s2.c.mA.mB.mB)) && allOk;
	allOk = compare_f16vec3(vec3(1.0, -6.0, -5.0), vec3(s2.c.mA.mC.mA)) && allOk;
	allOk = compare_f16vec4(vec4(9.0, 1.0, 5.0, -7.0), vec4(s2.c.mA.mC.mB)) && allOk;
	allOk = compare_u16vec3(uvec3(1u, 6u, 3u), uvec3(s2.c.mA.mC.mC)) && allOk;
	allOk = compare_f16vec3(vec3(-5.0, 8.0, 5.0), vec3(s2.c.mB.mA.mA)) && allOk;
	allOk = compare_mat4x2(mat4x2(-4.0, -1.0, -8.0, 4.0, -7.0, 1.0, 4.0, -2.0), s2.c.mC) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	mediump vec3 mA;
	i16vec2 mB;
	u16vec2 mC;
};
struct sB
{
	sA mA;
};
struct sC
{
	sB mA;
};
struct sD
{
	i16vec3 mA;
};
struct sE
{
	i16vec2 mA;
	mediump mat3x4 mB;
};
struct sF
{
	sD mA;
	sE mB;
};
struct sG
{
	sF mA;
};
struct sH
{
	int16_t mA;
};
struct sI
{
	lowp ivec2 mA;
	i16vec4 mB;
};
struct sJ
{
	f16vec3 mA;
};
struct sK
{
	sH mA;
	sI mB;
	sJ mC;
};
struct sL
{
	sK mA;
};
struct sM
{
	u16vec4 mA;
};
struct sN
{
	sM mA;
	i16vec2 mB;
};
struct sO
{
	int16_t mA;
};
struct sP
{
	f16vec2 mA;
	bvec4 mB;
};
struct sQ
{
	lowp mat2x3 mA;
};
struct sR
{
	sQ mA;
};
struct sS
{
	i16vec4 mA;
};
struct sT
{
	bvec3 mA;
	highp mat4x3 mB;
	f16vec2 mC;
};
struct sU
{
	highp uvec4 mA;
	sS mB;
	sT mC;
};
struct sV
{
	i16vec3 mA;
	f16vec3 mB;
};
struct sW
{
	mediump float mA;
	f16vec4 mB;
};
struct sX
{
	sV mA;
	sW mB;
};
struct sY
{
	sR mA;
	sU mB;
	sX mC;
};
struct S1 {
	sC a;
	float16_t b;
	sG c;
};
struct S2 {
	sL a;
	sN b;
	sO c;
};
struct S3 {
	sP a;
	sY b;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

shared S1 s1;
shared S2 s2;
shared S3 s3;

void main (void) {
	s1.a.mA.mA.mA = vec3(1.0, -3.0, 9.0);
	s1.a.mA.mA.mB = i16vec2(7, -5);
	s1.a.mA.mA.mC = u16vec2(3u, 5u);
	s1.b = float16_t(-8.0);
	s1.c.mA.mA.mA = i16vec3(2, -6, 5);
	s1.c.mA.mB.mA = i16vec2(-7, 2);
	s1.c.mA.mB.mB = mat3x4(8.0, 8.0, 6.0, -8.0, 7.0, -1.0, 2.0, 2.0, 6.0, 1.0, 1.0, 1.0);
	s2.a.mA.mA.mA = int16_t(6);
	s2.a.mA.mB.mA = ivec2(-8, -9);
	s2.a.mA.mB.mB = i16vec4(0, -1, -1, 5);
	s2.a.mA.mC.mA = f16vec3(4.0, 0.0, -1.0);
	s2.b.mA.mA = u16vec4(6u, 9u, 2u, 3u);
	s2.b.mB = i16vec2(8, 0);
	s2.c.mA = int16_t(5);
	s3.a.mA = f16vec2(-7.0, 6.0);
	s3.a.mB = bvec4(true, false, false, false);
	s3.b.mA.mA.mA = mat2x3(-8.0, 5.0, 1.0, -4.0, 0.0, 4.0);
	s3.b.mB.mA = uvec4(5u, 9u, 5u, 8u);
	s3.b.mB.mB.mA = i16vec4(-5, -1, -9, -9);
	s3.b.mB.mC.mA = bvec3(false, false, true);
	s3.b.mB.mC.mB = mat4x3(1.0, -9.0, 8.0, 9.0, -6.0, -3.0, -4.0, 9.0, 9.0, 1.0, 5.0, 9.0);
	s3.b.mB.mC.mC = f16vec2(5.0, -7.0);
	s3.b.mC.mA.mA = i16vec3(-3, -9, 5);
	s3.b.mC.mA.mB = f16vec3(4.0, 2.0, 3.0);
	s3.b.mC.mB.mA = 3.0;
	s3.b.mC.mB.mB = f16vec4(2.0, -8.0, 1.0, 7.0);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_vec3(vec3(1.0, -3.0, 9.0), s1.a.mA.mA.mA) && allOk;
	allOk = compare_i16vec2(ivec2(7, -5), ivec2(s1.a.mA.mA.mB)) && allOk;
	allOk = compare_u16vec2(uvec2(3u, 5u), uvec2(s1.a.mA.mA.mC)) && allOk;
	allOk = compare_float16_t(float(-8.0), float(s1.b)) && allOk;
	allOk = compare_i16vec3(ivec3(2, -6, 5), ivec3(s1.c.mA.mA.mA)) && allOk;
	allOk = compare_i16vec2(ivec2(-7, 2), ivec2(s1.c.mA.mB.mA)) && allOk;
	allOk = compare_mat3x4(mat3x4(8.0, 8.0, 6.0, -8.0, 7.0, -1.0, 2.0, 2.0, 6.0, 1.0, 1.0, 1.0), s1.c.mA.mB.mB) && allOk;
	allOk = compare_int16_t(int(6), int(s2.a.mA.mA.mA)) && allOk;
	allOk = compare_ivec2(ivec2(-8, -9), s2.a.mA.mB.mA) && allOk;
	allOk = compare_i16vec4(ivec4(0, -1, -1, 5), ivec4(s2.a.mA.mB.mB)) && allOk;
	allOk = compare_f16vec3(vec3(4.0, 0.0, -1.0), vec3(s2.a.mA.mC.mA)) && allOk;
	allOk = compare_u16vec4(uvec4(6u, 9u, 2u, 3u), uvec4(s2.b.mA.mA)) && allOk;
	allOk = compare_i16vec2(ivec2(8, 0), ivec2(s2.b.mB)) && allOk;
	allOk = compare_int16_t(int(5), int(s2.c.mA)) && allOk;
	allOk = compare_f16vec2(vec2(-7.0, 6.0), vec2(s3.a.mA)) && allOk;
	allOk = compare_bvec4(bvec4(true, false, false, false), s3.a.mB) && allOk;
	allOk = compare_mat2x3(mat2x3(-8.0, 5.0, 1.0, -4.0, 0.0, 4.0), s3.b.mA.mA.mA) && allOk;
	allOk = compare_uvec4(uvec4(5u, 9u, 5u, 8u), s3.b.mB.mA) && allOk;
	allOk = compare_i16vec4(ivec4(-5, -1, -9, -9), ivec4(s3.b.mB.mB.mA)) && allOk;
	allOk = compare_bvec3(bvec3(false, false, true), s3.b.mB.mC.mA) && allOk;
	allOk = compare_mat4x3(mat4x3(1.0, -9.0, 8.0, 9.0, -6.0, -3.0, -4.0, 9.0, 9.0, 1.0, 5.0, 9.0), s3.b.mB.mC.mB) && allOk;
	allOk = compare_f16vec2(vec2(5.0, -7.0), vec2(s3.b.mB.mC.mC)) && allOk;
	allOk = compare_i16vec3(ivec3(-3, -9, 5), ivec3(s3.b.mC.mA.mA)) && allOk;
	allOk = compare_f16vec3(vec3(4.0, 2.0, 3.0), vec3(s3.b.mC.mA.mB)) && allOk;
	allOk = compare_float(3.0, s3.b.mC.mB.mA) && allOk;
	allOk = compare_f16vec4(vec4(2.0, -8.0, 1.0, 7.0), vec4(s3.b.mC.mB.mB)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	float16_t mA;
};
struct sB
{
	lowp uint mA;
	u16vec2 mB;
};
struct sC
{
	sA mA;
	sB mB;
};
struct sD
{
	sC mA;
};
struct sE
{
	f16vec2 mA;
	float16_t mB;
};
struct sF
{
	i16vec3 mA;
};
struct sG
{
	sE mA;
	sF mB;
};
struct sH
{
	i16vec3 mA;
	highp uvec4 mB;
};
struct sI
{
	lowp mat4x3 mA;
	lowp uvec3 mB;
	highp mat2 mC;
};
struct sJ
{
	int16_t mA;
	highp mat3x2 mB;
};
struct sK
{
	i16vec4 mA;
};
struct sL
{
	sI mA;
	sJ mB;
	sK mC;
};
struct sM
{
	sH mA[1];
	sL mB;
};
struct sN
{
	uint16_t mA[1][3];
};
struct sO
{
	int16_t mA;
	float16_t mB;
	f16vec4 mC;
};
struct sP
{
	lowp mat3x2 mA;
	uint16_t mB[3];
	sO mC;
};
struct sQ
{
	sP mA;
};
struct sR
{
	u16vec2 mA;
	u16vec4 mB;
	highp mat3 mC;
};
struct sS
{
	sR mA;
};
struct sT
{
	f16vec4 mA;
	i16vec3 mB;
};
struct sU
{
	sS mA;
	sT mB[3];
};
struct sV
{
	bool mA;
};
struct sW
{
	f16vec4 mA;
	lowp ivec2 mB;
};
struct sX
{
	sV mA;
	sW mB;
	f16vec3 mC[1];
};
struct sY
{
	lowp int mA;
	mediump mat3 mB;
	u16vec2 mC;
};
struct sZ
{
	sY mA;
};
struct sAA
{
	bvec4 mA[2];
};
struct sAB
{
	sZ mA;
	sAA mB;
	bvec3 mC[2];
};
struct sAC
{
	u16vec4 mA;
	f16vec2 mB;
	float16_t mC;
};
struct sAD
{
	u16vec4 mA;
	bvec2 mB;
};
struct sAE
{
	sAC mA;
	sAD mB;
	u16vec2 mC[2];
};
struct sAF
{
	highp ivec4 mA[3];
	float16_t mB[1];
};
struct sAG
{
	u16vec4 mA;
};
struct sAH
{
	sAG mA;
};
struct sAI
{
	sAE mA;
	sAF mB;
	sAH mC;
};
struct S1 {
	sD a;
	sG b[1];
	sM c;
};
struct S2 {
	sN a;
	sQ b;
	sU c;
	sX d[3];
};
struct S3 {
	sAB a;
	sAI b;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

shared S1 s1;
shared S2 s2;
shared S3 s3;

void main (void) {
	s1.a.mA.mA.mA = float16_t(6.0);
	s1.a.mA.mB.mA = 2u;
	s1.a.mA.mB.mB = u16vec2(0u, 4u);
	s1.b[0].mA.mA = f16vec2(-4.0, -5.0);
	s1.b[0].mA.mB = float16_t(9.0);
	s1.b[0].mB.mA = i16vec3(-4, -6, -1);
	s1.c.mA[0].mA = i16vec3(-1, -2, 1);
	s1.c.mA[0].mB = uvec4(3u, 8u, 2u, 3u);
	s1.c.mB.mA.mA = mat4x3(-4.0, -9.0, 8.0, 3.0, 0.0, 2.0, 1.0, 8.0, 0.0, 9.0, -1.0, -1.0);
	s1.c.mB.mA.mB = uvec3(9u, 1u, 8u);
	s1.c.mB.mA.mC = mat2(-3.0, 1.0, -4.0, -9.0);
	s1.c.mB.mB.mA = int16_t(1);
	s1.c.mB.mB.mB = mat3x2(-4.0, 0.0, 2.0, 0.0, 6.0, 2.0);
	s1.c.mB.mC.mA = i16vec4(3, -5, -1, -5);
	s2.a.mA[0][0] = uint16_t(5u);
	s2.a.mA[0][1] = uint16_t(2u);
	s2.a.mA[0][2] = uint16_t(4u);
	s2.b.mA.mA = mat3x2(-9.0, -8.0, 6.0, -2.0, 3.0, 7.0);
	s2.b.mA.mB[0] = uint16_t(7u);
	s2.b.mA.mB[1] = uint16_t(1u);
	s2.b.mA.mB[2] = uint16_t(1u);
	s2.b.mA.mC.mA = int16_t(-5);
	s2.b.mA.mC.mB = float16_t(4.0);
	s2.b.mA.mC.mC = f16vec4(8.0, -9.0, -8.0, -2.0);
	s2.c.mA.mA.mA = u16vec2(7u, 0u);
	s2.c.mA.mA.mB = u16vec4(8u, 8u, 1u, 5u);
	s2.c.mA.mA.mC = mat3(8.0, -7.0, 9.0, -9.0, 2.0, 4.0, 7.0, 4.0, -6.0);
	s2.c.mB[0].mA = f16vec4(-8.0, 5.0, -7.0, 8.0);
	s2.c.mB[0].mB = i16vec3(-2, 6, 2);
	s2.c.mB[1].mA = f16vec4(-9.0, -5.0, 4.0, 4.0);
	s2.c.mB[1].mB = i16vec3(-7, -4, -9);
	s2.c.mB[2].mA = f16vec4(7.0, 6.0, 9.0, 8.0);
	s2.c.mB[2].mB = i16vec3(-8, 8, 4);
	s2.d[0].mA.mA = true;
	s2.d[0].mB.mA = f16vec4(9.0, -9.0, -6.0, 7.0);
	s2.d[0].mB.mB = ivec2(6, -4);
	s2.d[0].mC[0] = f16vec3(7.0, -1.0, 3.0);
	s2.d[1].mA.mA = false;
	s2.d[1].mB.mA = f16vec4(3.0, 0.0, 6.0, -7.0);
	s2.d[1].mB.mB = ivec2(7, 6);
	s2.d[1].mC[0] = f16vec3(5.0, -5.0, -9.0);
	s2.d[2].mA.mA = false;
	s2.d[2].mB.mA = f16vec4(-3.0, 7.0, -9.0, -8.0);
	s2.d[2].mB.mB = ivec2(6, 3);
	s2.d[2].mC[0] = f16vec3(6.0, 2.0, -3.0);
	s3.a.mA.mA.mA = -1;
	s3.a.mA.mA.mB = mat3(4.0, -6.0, 3.0, 0.0, -1.0, -6.0, 5.0, 0.0, 6.0);
	s3.a.mA.mA.mC = u16vec2(3u, 1u);
	s3.a.mB.mA[0] = bvec4(false, false, true, false);
	s3.a.mB.mA[1] = bvec4(true, true, true, true);
	s3.a.mC[0] = bvec3(true, false, true);
	s3.a.mC[1] = bvec3(true, false, false);
	s3.b.mA.mA.mA = u16vec4(7u, 0u, 9u, 1u);
	s3.b.mA.mA.mB = f16vec2(-5.0, -7.0);
	s3.b.mA.mA.mC = float16_t(2.0);
	s3.b.mA.mB.mA = u16vec4(7u, 3u, 6u, 6u);
	s3.b.mA.mB.mB = bvec2(true, true);
	s3.b.mA.mC[0] = u16vec2(2u, 4u);
	s3.b.mA.mC[1] = u16vec2(9u, 0u);
	s3.b.mB.mA[0] = ivec4(-4, 7, -5, 0);
	s3.b.mB.mA[1] = ivec4(-2, 3, -2, -7);
	s3.b.mB.mA[2] = ivec4(-6, -7, -3, -8);
	s3.b.mB.mB[0] = float16_t(8.0);
	s3.b.mC.mA.mA = u16vec4(1u, 9u, 0u, 8u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_float16_t(float(6.0), float(s1.a.mA.mA.mA)) && allOk;
	allOk = compare_uint(2u, s1.a.mA.mB.mA) && allOk;
	allOk = compare_u16vec2(uvec2(0u, 4u), uvec2(s1.a.mA.mB.mB)) && allOk;
	allOk = compare_f16vec2(vec2(-4.0, -5.0), vec2(s1.b[0].mA.mA)) && allOk;
	allOk = compare_float16_t(float(9.0), float(s1.b[0].mA.mB)) && allOk;
	allOk = compare_i16vec3(ivec3(-4, -6, -1), ivec3(s1.b[0].mB.mA)) && allOk;
	allOk = compare_i16vec3(ivec3(-1, -2, 1), ivec3(s1.c.mA[0].mA)) && allOk;
	allOk = compare_uvec4(uvec4(3u, 8u, 2u, 3u), s1.c.mA[0].mB) && allOk;
	allOk = compare_mat4x3(mat4x3(-4.0, -9.0, 8.0, 3.0, 0.0, 2.0, 1.0, 8.0, 0.0, 9.0, -1.0, -1.0), s1.c.mB.mA.mA) && allOk;
	allOk = compare_uvec3(uvec3(9u, 1u, 8u), s1.c.mB.mA.mB) && allOk;
	allOk = compare_mat2(mat2(-3.0, 1.0, -4.0, -9.0), s1.c.mB.mA.mC) && allOk;
	allOk = compare_int16_t(int(1), int(s1.c.mB.mB.mA)) && allOk;
	allOk = compare_mat3x2(mat3x2(-4.0, 0.0, 2.0, 0.0, 6.0, 2.0), s1.c.mB.mB.mB) && allOk;
	allOk = compare_i16vec4(ivec4(3, -5, -1, -5), ivec4(s1.c.mB.mC.mA)) && allOk;
	allOk = compare_uint16_t(uint(5u), uint(s2.a.mA[0][0])) && allOk;
	allOk = compare_uint16_t(uint(2u), uint(s2.a.mA[0][1])) && allOk;
	allOk = compare_uint16_t(uint(4u), uint(s2.a.mA[0][2])) && allOk;
	allOk = compare_mat3x2(mat3x2(-9.0, -8.0, 6.0, -2.0, 3.0, 7.0), s2.b.mA.mA) && allOk;
	allOk = compare_uint16_t(uint(7u), uint(s2.b.mA.mB[0])) && allOk;
	allOk = compare_uint16_t(uint(1u), uint(s2.b.mA.mB[1])) && allOk;
	allOk = compare_uint16_t(uint(1u), uint(s2.b.mA.mB[2])) && allOk;
	allOk = compare_int16_t(int(-5), int(s2.b.mA.mC.mA)) && allOk;
	allOk = compare_float16_t(float(4.0), float(s2.b.mA.mC.mB)) && allOk;
	allOk = compare_f16vec4(vec4(8.0, -9.0, -8.0, -2.0), vec4(s2.b.mA.mC.mC)) && allOk;
	allOk = compare_u16vec2(uvec2(7u, 0u), uvec2(s2.c.mA.mA.mA)) && allOk;
	allOk = compare_u16vec4(uvec4(8u, 8u, 1u, 5u), uvec4(s2.c.mA.mA.mB)) && allOk;
	allOk = compare_mat3(mat3(8.0, -7.0, 9.0, -9.0, 2.0, 4.0, 7.0, 4.0, -6.0), s2.c.mA.mA.mC) && allOk;
	allOk = compare_f16vec4(vec4(-8.0, 5.0, -7.0, 8.0), vec4(s2.c.mB[0].mA)) && allOk;
	allOk = compare_i16vec3(ivec3(-2, 6, 2), ivec3(s2.c.mB[0].mB)) && allOk;
	allOk = compare_f16vec4(vec4(-9.0, -5.0, 4.0, 4.0), vec4(s2.c.mB[1].mA)) && allOk;
	allOk = compare_i16vec3(ivec3(-7, -4, -9), ivec3(s2.c.mB[1].mB)) && allOk;
	allOk = compare_f16vec4(vec4(7.0, 6.0, 9.0, 8.0), vec4(s2.c.mB[2].mA)) && allOk;
	allOk = compare_i16vec3(ivec3(-8, 8, 4), ivec3(s2.c.mB[2].mB)) && allOk;
	allOk = compare_bool(true, s2.d[0].mA.mA) && allOk;
	allOk = compare_f16vec4(vec4(9.0, -9.0, -6.0, 7.0), vec4(s2.d[0].mB.mA)) && allOk;
	allOk = compare_ivec2(ivec2(6, -4), s2.d[0].mB.mB) && allOk;
	allOk = compare_f16vec3(vec3(7.0, -1.0, 3.0), vec3(s2.d[0].mC[0])) && allOk;
	allOk = compare_bool(false, s2.d[1].mA.mA) && allOk;
	allOk = compare_f16vec4(vec4(3.0, 0.0, 6.0, -7.0), vec4(s2.d[1].mB.mA)) && allOk;
	allOk = compare_ivec2(ivec2(7, 6), s2.d[1].mB.mB) && allOk;
	allOk = compare_f16vec3(vec3(5.0, -5.0, -9.0), vec3(s2.d[1].mC[0])) && allOk;
	allOk = compare_bool(false, s2.d[2].mA.mA) && allOk;
	allOk = compare_f16vec4(vec4(-3.0, 7.0, -9.0, -8.0), vec4(s2.d[2].mB.mA)) && allOk;
	allOk = compare_ivec2(ivec2(6, 3), s2.d[2].mB.mB) && allOk;
	allOk = compare_f16vec3(vec3(6.0, 2.0, -3.0), vec3(s2.d[2].mC[0])) && allOk;
	allOk = compare_int(-1, s3.a.mA.mA.mA) && allOk;
	allOk = compare_mat3(mat3(4.0, -6.0, 3.0, 0.0, -1.0, -6.0, 5.0, 0.0, 6.0), s3.a.mA.mA.mB) && allOk;
	allOk = compare_u16vec2(uvec2(3u, 1u), uvec2(s3.a.mA.mA.mC)) && allOk;
	allOk = compare_bvec4(bvec4(false, false, true, false), s3.a.mB.mA[0]) && allOk;
	allOk = compare_bvec4(bvec4(true, true, true, true), s3.a.mB.mA[1]) && allOk;
	allOk = compare_bvec3(bvec3(true, false, true), s3.a.mC[0]) && allOk;
	allOk = compare_bvec3(bvec3(true, false, false), s3.a.mC[1]) && allOk;
	allOk = compare_u16vec4(uvec4(7u, 0u, 9u, 1u), uvec4(s3.b.mA.mA.mA)) && allOk;
	allOk = compare_f16vec2(vec2(-5.0, -7.0), vec2(s3.b.mA.mA.mB)) && allOk;
	allOk = compare_float16_t(float(2.0), float(s3.b.mA.mA.mC)) && allOk;
	allOk = compare_u16vec4(uvec4(7u, 3u, 6u, 6u), uvec4(s3.b.mA.mB.mA)) && allOk;
	allOk = compare_bvec2(bvec2(true, true), s3.b.mA.mB.mB) && allOk;
	allOk = compare_u16vec2(uvec2(2u, 4u), uvec2(s3.b.mA.mC[0])) && allOk;
	allOk = compare_u16vec2(uvec2(9u, 0u), uvec2(s3.b.mA.mC[1])) && allOk;
	allOk = compare_ivec4(ivec4(-4, 7, -5, 0), s3.b.mB.mA[0]) && allOk;
	allOk = compare_ivec4(ivec4(-2, 3, -2, -7), s3.b.mB.mA[1]) && allOk;
	allOk = compare_ivec4(ivec4(-6, -7, -3, -8), s3.b.mB.mA[2]) && allOk;
	allOk = compare_float16_t(float(8.0), float(s3.b.mB.mB[0])) && allOk;
	allOk = compare_u16vec4(uvec4(1u, 9u, 0u, 8u), uvec4(s3.b.mC.mA.mA)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	i16vec4 mA;
};
struct sB
{
	bvec4 mA;
	lowp int mB;
	mediump mat3 mC;
};
struct sC
{
	bvec4 mA;
	int16_t mB;
};
struct sD
{
	sA mA;
	sB mB;
	sC mC;
};
struct sE
{
	f16vec3 mA;
};
struct sF
{
	sD mA;
	sE mB[1];
};
struct sG
{
	float16_t mA;
};
struct sH
{
	sG mA;
};
struct sI
{
	u16vec4 mA;
	uint16_t mB;
	bvec4 mC;
};
struct sJ
{
	highp uvec4 mA;
	f16vec2 mB;
	u16vec2 mC;
};
struct sK
{
	sI mA;
	float16_t mB[1];
	sJ mC;
};
struct sL
{
	sH mA;
	float16_t mB[1][2];
	sK mC;
};
struct sM
{
	i16vec4 mA;
	i16vec2 mB;
};
struct sN
{
	sM mA;
};
struct sO
{
	sN mA;
	f16vec2 mB;
};
struct sP
{
	bool mA;
};
struct sQ
{
	lowp int mA;
	f16vec4 mB;
};
struct sR
{
	lowp uint mA;
	highp vec4 mB;
};
struct sS
{
	bvec4 mA;
};
struct sT
{
	sQ mA;
	sR mB;
	sS mC;
};
struct sU
{
	sP mA;
	sT mB;
};
struct S1 {
	sF a;
	sL b;
};
struct S2 {
	sO a;
	sU b;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a.mA.mA.mA = i16vec4(6, 6, -6, -3);
	s1.a.mA.mB.mA = bvec4(true, false, false, true);
	s1.a.mA.mB.mB = -9;
	s1.a.mA.mB.mC = mat3(8.0, -4.0, -8.0, 8.0, -8.0, -6.0, -2.0, 9.0, -2.0);
	s1.a.mA.mC.mA = bvec4(true, false, true, true);
	s1.a.mA.mC.mB = int16_t(-1);
	s1.a.mB[0].mA = f16vec3(9.0, -5.0, 8.0);
	s1.b.mA.mA.mA = float16_t(4.0);
	s1.b.mB[0][0] = float16_t(-9.0);
	s1.b.mB[0][1] = float16_t(8.0);
	s1.b.mC.mA.mA = u16vec4(9u, 3u, 7u, 3u);
	s1.b.mC.mA.mB = uint16_t(0u);
	s1.b.mC.mA.mC = bvec4(false, true, false, true);
	s1.b.mC.mB[0] = float16_t(-2.0);
	s1.b.mC.mC.mA = uvec4(2u, 1u, 4u, 6u);
	s1.b.mC.mC.mB = f16vec2(5.0, -2.0);
	s1.b.mC.mC.mC = u16vec2(5u, 8u);
	s2.a.mA.mA.mA = i16vec4(8, -5, -4, -6);
	s2.a.mA.mA.mB = i16vec2(-3, 0);
	s2.a.mB = f16vec2(-9.0, 9.0);
	s2.b.mA.mA = true;
	s2.b.mB.mA.mA = -5;
	s2.b.mB.mA.mB = f16vec4(8.0, -4.0, -9.0, 6.0);
	s2.b.mB.mB.mA = 4u;
	s2.b.mB.mB.mB = vec4(8.0, -1.0, 2.0, 7.0);
	s2.b.mB.mC.mA = bvec4(false, false, false, false);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_i16vec4(ivec4(6, 6, -6, -3), ivec4(s1.a.mA.mA.mA)) && allOk;
	allOk = compare_bvec4(bvec4(true, false, false, true), s1.a.mA.mB.mA) && allOk;
	allOk = compare_int(-9, s1.a.mA.mB.mB) && allOk;
	allOk = compare_mat3(mat3(8.0, -4.0, -8.0, 8.0, -8.0, -6.0, -2.0, 9.0, -2.0), s1.a.mA.mB.mC) && allOk;
	allOk = compare_bvec4(bvec4(true, false, true, true), s1.a.mA.mC.mA) && allOk;
	allOk = compare_int16_t(int(-1), int(s1.a.mA.mC.mB)) && allOk;
	allOk = compare_f16vec3(vec3(9.0, -5.0, 8.0), vec3(s1.a.mB[0].mA)) && allOk;
	allOk = compare_float16_t(float(4.0), float(s1.b.mA.mA.mA)) && allOk;
	allOk = compare_float16_t(float(-9.0), float(s1.b.mB[0][0])) && allOk;
	allOk = compare_float16_t(float(8.0), float(s1.b.mB[0][1])) && allOk;
	allOk = compare_u16vec4(uvec4(9u, 3u, 7u, 3u), uvec4(s1.b.mC.mA.mA)) && allOk;
	allOk = compare_uint16_t(uint(0u), uint(s1.b.mC.mA.mB)) && allOk;
	allOk = compare_bvec4(bvec4(false, true, false, true), s1.b.mC.mA.mC) && allOk;
	allOk = compare_float16_t(float(-2.0), float(s1.b.mC.mB[0])) && allOk;
	allOk = compare_uvec4(uvec4(2u, 1u, 4u, 6u), s1.b.mC.mC.mA) && allOk;
	allOk = compare_f16vec2(vec2(5.0, -2.0), vec2(s1.b.mC.mC.mB)) && allOk;
	allOk = compare_u16vec2(uvec2(5u, 8u), uvec2(s1.b.mC.mC.mC)) && allOk;
	allOk = compare_i16vec4(ivec4(8, -5, -4, -6), ivec4(s2.a.mA.mA.mA)) && allOk;
	allOk = compare_i16vec2(ivec2(-3, 0), ivec2(s2.a.mA.mA.mB)) && allOk;
	allOk = compare_f16vec2(vec2(-9.0, 9.0), vec2(s2.a.mB)) && allOk;
	allOk = compare_bool(true, s2.b.mA.mA) && allOk;
	allOk = compare_int(-5, s2.b.mB.mA.mA) && allOk;
	allOk = compare_f16vec4(vec4(8.0, -4.0, -9.0, 6.0), vec4(s2.b.mB.mA.mB)) && allOk;
	allOk = compare_uint(4u, s2.b.mB.mB.mA) && allOk;
	allOk = compare_vec4(vec4(8.0, -1.0, 2.0, 7.0), s2.b.mB.mB.mB) && allOk;
	allOk = compare_bvec4(bvec4(false, false, false, false), s2.b.mB.mC.mA) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	u16vec2 mA;
};
struct sB
{
	i16vec3 mA[3];
	mediump mat3x2 mB[1];
	sA mC;
};
struct sC
{
	highp mat4x3 mA;
};
struct sD
{
	mediump uvec3 mA;
};
struct sE
{
	mediump int mA;
};
struct sF
{
	sC mA;
	sD mB;
	sE mC;
};
struct sG
{
	u16vec3 mA;
	i16vec3 mB;
	highp uvec2 mC;
};
struct sH
{
	sB mA;
	sF mB;
	sG mC[3];
};
struct sI
{
	bvec3 mA;
	bool mB;
	u16vec3 mC;
};
struct sJ
{
	sI mA;
	f16vec2 mB[3];
};
struct sK
{
	lowp mat4x3 mA;
	f16vec3 mB;
};
struct sL
{
	u16vec4 mA[2];
	sK mB;
};
struct sM
{
	f16vec4 mA[3];
};
struct sN
{
	sJ mA;
	sL mB;
	sM mC;
};
struct sO
{
	mediump mat2 mA;
	f16vec3 mB;
};
struct sP
{
	i16vec4 mA;
	u16vec3 mB;
};
struct sQ
{
	mediump mat3 mA[1];
	sO mB;
	sP mC;
};
struct sR
{
	mediump vec3 mA;
	highp ivec4 mB;
};
struct sS
{
	i16vec4 mA;
	uint16_t mB;
	u16vec4 mC;
};
struct sT
{
	sQ mA;
	sR mB[1];
	sS mC[2];
};
struct sU
{
	u16vec3 mA[2][2];
};
struct sV
{
	u16vec2 mA;
};
struct sW
{
	bvec4 mA;
	i16vec2 mB;
	i16vec4 mC;
};
struct sX
{
	sV mA;
	sW mB;
	uint16_t mC[3];
};
struct sY
{
	highp float mA;
	lowp ivec2 mB;
	u16vec4 mC;
};
struct sZ
{
	highp mat4 mA;
};
struct sAA
{
	sY mA;
	sZ mB;
	f16vec3 mC[2];
};
struct sAB
{
	u16vec2 mA;
	u16vec4 mB;
	mediump uint mC;
};
struct sAC
{
	highp uint mA;
	f16vec4 mB;
	int16_t mC;
};
struct sAD
{
	sAB mA;
	sAC mB;
};
struct sAE
{
	sX mA;
	sAA mB;
	sAD mC;
};
struct sAF
{
	f16vec2 mA;
};
struct sAG
{
	sAF mA;
};
struct S1 {
	sH a;
	sN b;
	sT c;
};
struct S2 {
	sU a;
	highp int b;
	sAE c;
	sAG d[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a.mA.mA[0] = i16vec3(0, 2, -8);
	s1.a.mA.mA[1] = i16vec3(6, 7, 5);
	s1.a.mA.mA[2] = i16vec3(-6, 1, 9);
	s1.a.mA.mB[0] = mat3x2(-4.0, -3.0, 4.0, 4.0, 9.0, -9.0);
	s1.a.mA.mC.mA = u16vec2(0u, 7u);
	s1.a.mB.mA.mA = mat4x3(8.0, 0.0, 4.0, -4.0, 7.0, 2.0, -1.0, 7.0, -5.0, -4.0, 3.0, -5.0);
	s1.a.mB.mB.mA = uvec3(5u, 6u, 5u);
	s1.a.mB.mC.mA = 0;
	s1.a.mC[0].mA = u16vec3(4u, 5u, 7u);
	s1.a.mC[0].mB = i16vec3(-9, -4, 3);
	s1.a.mC[0].mC = uvec2(2u, 8u);
	s1.a.mC[1].mA = u16vec3(0u, 6u, 7u);
	s1.a.mC[1].mB = i16vec3(9, -7, -8);
	s1.a.mC[1].mC = uvec2(3u, 3u);
	s1.a.mC[2].mA = u16vec3(6u, 7u, 0u);
	s1.a.mC[2].mB = i16vec3(-7, -1, 5);
	s1.a.mC[2].mC = uvec2(5u, 0u);
	s1.b.mA.mA.mA = bvec3(true, false, false);
	s1.b.mA.mA.mB = false;
	s1.b.mA.mA.mC = u16vec3(3u, 0u, 7u);
	s1.b.mA.mB[0] = f16vec2(-2.0, 2.0);
	s1.b.mA.mB[1] = f16vec2(-4.0, 4.0);
	s1.b.mA.mB[2] = f16vec2(-8.0, 4.0);
	s1.b.mB.mA[0] = u16vec4(6u, 9u, 3u, 5u);
	s1.b.mB.mA[1] = u16vec4(6u, 4u, 6u, 9u);
	s1.b.mB.mB.mA = mat4x3(-9.0, 2.0, -4.0, -5.0, 1.0, 5.0, 4.0, -7.0, 6.0, 8.0, 0.0, -7.0);
	s1.b.mB.mB.mB = f16vec3(-8.0, -7.0, -3.0);
	s1.b.mC.mA[0] = f16vec4(3.0, 2.0, -8.0, -1.0);
	s1.b.mC.mA[1] = f16vec4(-7.0, 0.0, 6.0, -5.0);
	s1.b.mC.mA[2] = f16vec4(4.0, -3.0, 7.0, -5.0);
	s1.c.mA.mA[0] = mat3(1.0, 8.0, 0.0, -3.0, -8.0, 6.0, -2.0, 5.0, 8.0);
	s1.c.mA.mB.mA = mat2(8.0, -5.0, 4.0, 9.0);
	s1.c.mA.mB.mB = f16vec3(-1.0, -4.0, 2.0);
	s1.c.mA.mC.mA = i16vec4(4, 4, 0, 7);
	s1.c.mA.mC.mB = u16vec3(6u, 9u, 6u);
	s1.c.mB[0].mA = vec3(-8.0, 6.0, -4.0);
	s1.c.mB[0].mB = ivec4(-4, -2, 5, 0);
	s1.c.mC[0].mA = i16vec4(4, 9, 5, 4);
	s1.c.mC[0].mB = uint16_t(2u);
	s1.c.mC[0].mC = u16vec4(0u, 1u, 8u, 4u);
	s1.c.mC[1].mA = i16vec4(-1, 5, 1, 3);
	s1.c.mC[1].mB = uint16_t(0u);
	s1.c.mC[1].mC = u16vec4(9u, 2u, 7u, 6u);
	s2.a.mA[0][0] = u16vec3(6u, 5u, 7u);
	s2.a.mA[0][1] = u16vec3(7u, 2u, 3u);
	s2.a.mA[1][0] = u16vec3(8u, 4u, 9u);
	s2.a.mA[1][1] = u16vec3(4u, 8u, 6u);
	s2.b = -5;
	s2.c.mA.mA.mA = u16vec2(0u, 5u);
	s2.c.mA.mB.mA = bvec4(true, true, true, true);
	s2.c.mA.mB.mB = i16vec2(-4, 6);
	s2.c.mA.mB.mC = i16vec4(-1, -1, 6, 3);
	s2.c.mA.mC[0] = uint16_t(4u);
	s2.c.mA.mC[1] = uint16_t(9u);
	s2.c.mA.mC[2] = uint16_t(9u);
	s2.c.mB.mA.mA = -1.0;
	s2.c.mB.mA.mB = ivec2(5, 6);
	s2.c.mB.mA.mC = u16vec4(4u, 0u, 9u, 9u);
	s2.c.mB.mB.mA = mat4(-9.0, 7.0, 7.0, 3.0, 1.0, 5.0, -3.0, -7.0, 8.0, -4.0, 0.0, 7.0, 2.0, -8.0, 7.0, -6.0);
	s2.c.mB.mC[0] = f16vec3(-9.0, 7.0, 7.0);
	s2.c.mB.mC[1] = f16vec3(-4.0, 5.0, 9.0);
	s2.c.mC.mA.mA = u16vec2(9u, 5u);
	s2.c.mC.mA.mB = u16vec4(9u, 9u, 8u, 9u);
	s2.c.mC.mA.mC = 2u;
	s2.c.mC.mB.mA = 0u;
	s2.c.mC.mB.mB = f16vec4(5.0, 0.0, 5.0, 6.0);
	s2.c.mC.mB.mC = int16_t(6);
	s2.d[0].mA.mA = f16vec2(5.0, -6.0);
	s2.d[1].mA.mA = f16vec2(1.0, -8.0);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_i16vec3(ivec3(0, 2, -8), ivec3(s1.a.mA.mA[0])) && allOk;
	allOk = compare_i16vec3(ivec3(6, 7, 5), ivec3(s1.a.mA.mA[1])) && allOk;
	allOk = compare_i16vec3(ivec3(-6, 1, 9), ivec3(s1.a.mA.mA[2])) && allOk;
	allOk = compare_mat3x2(mat3x2(-4.0, -3.0, 4.0, 4.0, 9.0, -9.0), s1.a.mA.mB[0]) && allOk;
	allOk = compare_u16vec2(uvec2(0u, 7u), uvec2(s1.a.mA.mC.mA)) && allOk;
	allOk = compare_mat4x3(mat4x3(8.0, 0.0, 4.0, -4.0, 7.0, 2.0, -1.0, 7.0, -5.0, -4.0, 3.0, -5.0), s1.a.mB.mA.mA) && allOk;
	allOk = compare_uvec3(uvec3(5u, 6u, 5u), s1.a.mB.mB.mA) && allOk;
	allOk = compare_int(0, s1.a.mB.mC.mA) && allOk;
	allOk = compare_u16vec3(uvec3(4u, 5u, 7u), uvec3(s1.a.mC[0].mA)) && allOk;
	allOk = compare_i16vec3(ivec3(-9, -4, 3), ivec3(s1.a.mC[0].mB)) && allOk;
	allOk = compare_uvec2(uvec2(2u, 8u), s1.a.mC[0].mC) && allOk;
	allOk = compare_u16vec3(uvec3(0u, 6u, 7u), uvec3(s1.a.mC[1].mA)) && allOk;
	allOk = compare_i16vec3(ivec3(9, -7, -8), ivec3(s1.a.mC[1].mB)) && allOk;
	allOk = compare_uvec2(uvec2(3u, 3u), s1.a.mC[1].mC) && allOk;
	allOk = compare_u16vec3(uvec3(6u, 7u, 0u), uvec3(s1.a.mC[2].mA)) && allOk;
	allOk = compare_i16vec3(ivec3(-7, -1, 5), ivec3(s1.a.mC[2].mB)) && allOk;
	allOk = compare_uvec2(uvec2(5u, 0u), s1.a.mC[2].mC) && allOk;
	allOk = compare_bvec3(bvec3(true, false, false), s1.b.mA.mA.mA) && allOk;
	allOk = compare_bool(false, s1.b.mA.mA.mB) && allOk;
	allOk = compare_u16vec3(uvec3(3u, 0u, 7u), uvec3(s1.b.mA.mA.mC)) && allOk;
	allOk = compare_f16vec2(vec2(-2.0, 2.0), vec2(s1.b.mA.mB[0])) && allOk;
	allOk = compare_f16vec2(vec2(-4.0, 4.0), vec2(s1.b.mA.mB[1])) && allOk;
	allOk = compare_f16vec2(vec2(-8.0, 4.0), vec2(s1.b.mA.mB[2])) && allOk;
	allOk = compare_u16vec4(uvec4(6u, 9u, 3u, 5u), uvec4(s1.b.mB.mA[0])) && allOk;
	allOk = compare_u16vec4(uvec4(6u, 4u, 6u, 9u), uvec4(s1.b.mB.mA[1])) && allOk;
	allOk = compare_mat4x3(mat4x3(-9.0, 2.0, -4.0, -5.0, 1.0, 5.0, 4.0, -7.0, 6.0, 8.0, 0.0, -7.0), s1.b.mB.mB.mA) && allOk;
	allOk = compare_f16vec3(vec3(-8.0, -7.0, -3.0), vec3(s1.b.mB.mB.mB)) && allOk;
	allOk = compare_f16vec4(vec4(3.0, 2.0, -8.0, -1.0), vec4(s1.b.mC.mA[0])) && allOk;
	allOk = compare_f16vec4(vec4(-7.0, 0.0, 6.0, -5.0), vec4(s1.b.mC.mA[1])) && allOk;
	allOk = compare_f16vec4(vec4(4.0, -3.0, 7.0, -5.0), vec4(s1.b.mC.mA[2])) && allOk;
	allOk = compare_mat3(mat3(1.0, 8.0, 0.0, -3.0, -8.0, 6.0, -2.0, 5.0, 8.0), s1.c.mA.mA[0]) && allOk;
	allOk = compare_mat2(mat2(8.0, -5.0, 4.0, 9.0), s1.c.mA.mB.mA) && allOk;
	allOk = compare_f16vec3(vec3(-1.0, -4.0, 2.0), vec3(s1.c.mA.mB.mB)) && allOk;
	allOk = compare_i16vec4(ivec4(4, 4, 0, 7), ivec4(s1.c.mA.mC.mA)) && allOk;
	allOk = compare_u16vec3(uvec3(6u, 9u, 6u), uvec3(s1.c.mA.mC.mB)) && allOk;
	allOk = compare_vec3(vec3(-8.0, 6.0, -4.0), s1.c.mB[0].mA) && allOk;
	allOk = compare_ivec4(ivec4(-4, -2, 5, 0), s1.c.mB[0].mB) && allOk;
	allOk = compare_i16vec4(ivec4(4, 9, 5, 4), ivec4(s1.c.mC[0].mA)) && allOk;
	allOk = compare_uint16_t(uint(2u), uint(s1.c.mC[0].mB)) && allOk;
	allOk = compare_u16vec4(uvec4(0u, 1u, 8u, 4u), uvec4(s1.c.mC[0].mC)) && allOk;
	allOk = compare_i16vec4(ivec4(-1, 5, 1, 3), ivec4(s1.c.mC[1].mA)) && allOk;
	allOk = compare_uint16_t(uint(0u), uint(s1.c.mC[1].mB)) && allOk;
	allOk = compare_u16vec4(uvec4(9u, 2u, 7u, 6u), uvec4(s1.c.mC[1].mC)) && allOk;
	allOk = compare_u16vec3(uvec3(6u, 5u, 7u), uvec3(s2.a.mA[0][0])) && allOk;
	allOk = compare_u16vec3(uvec3(7u, 2u, 3u), uvec3(s2.a.mA[0][1])) && allOk;
	allOk = compare_u16vec3(uvec3(8u, 4u, 9u), uvec3(s2.a.mA[1][0])) && allOk;
	allOk = compare_u16vec3(uvec3(4u, 8u, 6u), uvec3(s2.a.mA[1][1])) && allOk;
	allOk = compare_int(-5, s2.b) && allOk;
	allOk = compare_u16vec2(uvec2(0u, 5u), uvec2(s2.c.mA.mA.mA)) && allOk;
	allOk = compare_bvec4(bvec4(true, true, true, true), s2.c.mA.mB.mA) && allOk;
	allOk = compare_i16vec2(ivec2(-4, 6), ivec2(s2.c.mA.mB.mB)) && allOk;
	allOk = compare_i16vec4(ivec4(-1, -1, 6, 3), ivec4(s2.c.mA.mB.mC)) && allOk;
	allOk = compare_uint16_t(uint(4u), uint(s2.c.mA.mC[0])) && allOk;
	allOk = compare_uint16_t(uint(9u), uint(s2.c.mA.mC[1])) && allOk;
	allOk = compare_uint16_t(uint(9u), uint(s2.c.mA.mC[2])) && allOk;
	allOk = compare_float(-1.0, s2.c.mB.mA.mA) && allOk;
	allOk = compare_ivec2(ivec2(5, 6), s2.c.mB.mA.mB) && allOk;
	allOk = compare_u16vec4(uvec4(4u, 0u, 9u, 9u), uvec4(s2.c.mB.mA.mC)) && allOk;
	allOk = compare_mat4(mat4(-9.0, 7.0, 7.0, 3.0, 1.0, 5.0, -3.0, -7.0, 8.0, -4.0, 0.0, 7.0, 2.0, -8.0, 7.0, -6.0), s2.c.mB.mB.mA) && allOk;
	allOk = compare_f16vec3(vec3(-9.0, 7.0, 7.0), vec3(s2.c.mB.mC[0])) && allOk;
	allOk = compare_f16vec3(vec3(-4.0, 5.0, 9.0), vec3(s2.c.mB.mC[1])) && allOk;
	allOk = compare_u16vec2(uvec2(9u, 5u), uvec2(s2.c.mC.mA.mA)) && allOk;
	allOk = compare_u16vec4(uvec4(9u, 9u, 8u, 9u), uvec4(s2.c.mC.mA.mB)) && allOk;
	allOk = compare_uint(2u, s2.c.mC.mA.mC) && allOk;
	allOk = compare_uint(0u, s2.c.mC.mB.mA) && allOk;
	allOk = compare_f16vec4(vec4(5.0, 0.0, 5.0, 6.0), vec4(s2.c.mC.mB.mB)) && allOk;
	allOk = compare_int16_t(int(6), int(s2.c.mC.mB.mC)) && allOk;
	allOk = compare_f16vec2(vec2(5.0, -6.0), vec2(s2.d[0].mA.mA)) && allOk;
	allOk = compare_f16vec2(vec2(1.0, -8.0), vec2(s2.d[1].mA.mA)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	highp ivec3 mA;
	lowp float mB;
	highp mat3 mC;
};
struct sB
{
	u16vec4 mA;
	sA mB[3];
};
struct sC
{
	highp int mA;
	uint16_t mB;
	uint16_t mC;
};
struct sD
{
	u16vec4 mA;
	f16vec3 mB;
	f16vec4 mC;
};
struct sE
{
	sD mA;
};
struct sF
{
	i16vec2 mA;
	mediump mat4x3 mB;
	i16vec2 mC;
};
struct sG
{
	float16_t mA;
};
struct sH
{
	sF mA;
	sG mB;
	f16vec3 mC;
};
struct sI
{
	sC mA[2];
	sE mB;
	sH mC;
};
struct sJ
{
	f16vec4 mA;
};
struct sK
{
	u16vec4 mA;
};
struct sL
{
	sK mA;
};
struct sM
{
	mediump vec2 mA;
	highp ivec3 mB;
};
struct sN
{
	sM mA;
};
struct sO
{
	sL mA;
	sN mB;
};
struct S1 {
	sB a;
	sI b;
};
struct S2 {
	sJ a[3][1];
	sO b;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a.mA = u16vec4(1u, 9u, 8u, 5u);
	s1.a.mB[0].mA = ivec3(1, -7, 1);
	s1.a.mB[0].mB = 2.0;
	s1.a.mB[0].mC = mat3(8.0, 7.0, 9.0, -8.0, 2.0, 9.0, 6.0, -5.0, 7.0);
	s1.a.mB[1].mA = ivec3(3, -3, 7);
	s1.a.mB[1].mB = 4.0;
	s1.a.mB[1].mC = mat3(-2.0, 9.0, 2.0, -5.0, 1.0, -6.0, 8.0, 5.0, 5.0);
	s1.a.mB[2].mA = ivec3(-3, 3, 1);
	s1.a.mB[2].mB = -9.0;
	s1.a.mB[2].mC = mat3(7.0, -2.0, 2.0, 9.0, -3.0, 3.0, 1.0, 1.0, -9.0);
	s1.b.mA[0].mA = -3;
	s1.b.mA[0].mB = uint16_t(6u);
	s1.b.mA[0].mC = uint16_t(6u);
	s1.b.mA[1].mA = -4;
	s1.b.mA[1].mB = uint16_t(6u);
	s1.b.mA[1].mC = uint16_t(7u);
	s1.b.mB.mA.mA = u16vec4(9u, 8u, 7u, 3u);
	s1.b.mB.mA.mB = f16vec3(0.0, 1.0, -3.0);
	s1.b.mB.mA.mC = f16vec4(-9.0, -6.0, 6.0, 5.0);
	s1.b.mC.mA.mA = i16vec2(-5, 2);
	s1.b.mC.mA.mB = mat4x3(4.0, 9.0, 2.0, 5.0, -2.0, -4.0, 7.0, 1.0, -8.0, -9.0, 5.0, 1.0);
	s1.b.mC.mA.mC = i16vec2(-5, 5);
	s1.b.mC.mB.mA = float16_t(-3.0);
	s1.b.mC.mC = f16vec3(6.0, 6.0, 2.0);
	s2.a[0][0].mA = f16vec4(4.0, 4.0, -3.0, 3.0);
	s2.a[1][0].mA = f16vec4(8.0, 6.0, -3.0, 4.0);
	s2.a[2][0].mA = f16vec4(-7.0, 1.0, -5.0, -9.0);
	s2.b.mA.mA.mA = u16vec4(2u, 0u, 9u, 1u);
	s2.b.mB.mA.mA = vec2(-4.0, 5.0);
	s2.b.mB.mA.mB = ivec3(-9, 6, 2);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_u16vec4(uvec4(1u, 9u, 8u, 5u), uvec4(s1.a.mA)) && allOk;
	allOk = compare_ivec3(ivec3(1, -7, 1), s1.a.mB[0].mA) && allOk;
	allOk = compare_float(2.0, s1.a.mB[0].mB) && allOk;
	allOk = compare_mat3(mat3(8.0, 7.0, 9.0, -8.0, 2.0, 9.0, 6.0, -5.0, 7.0), s1.a.mB[0].mC) && allOk;
	allOk = compare_ivec3(ivec3(3, -3, 7), s1.a.mB[1].mA) && allOk;
	allOk = compare_float(4.0, s1.a.mB[1].mB) && allOk;
	allOk = compare_mat3(mat3(-2.0, 9.0, 2.0, -5.0, 1.0, -6.0, 8.0, 5.0, 5.0), s1.a.mB[1].mC) && allOk;
	allOk = compare_ivec3(ivec3(-3, 3, 1), s1.a.mB[2].mA) && allOk;
	allOk = compare_float(-9.0, s1.a.mB[2].mB) && allOk;
	allOk = compare_mat3(mat3(7.0, -2.0, 2.0, 9.0, -3.0, 3.0, 1.0, 1.0, -9.0), s1.a.mB[2].mC) && allOk;
	allOk = compare_int(-3, s1.b.mA[0].mA) && allOk;
	allOk = compare_uint16_t(uint(6u), uint(s1.b.mA[0].mB)) && allOk;
	allOk = compare_uint16_t(uint(6u), uint(s1.b.mA[0].mC)) && allOk;
	allOk = compare_int(-4, s1.b.mA[1].mA) && allOk;
	allOk = compare_uint16_t(uint(6u), uint(s1.b.mA[1].mB)) && allOk;
	allOk = compare_uint16_t(uint(7u), uint(s1.b.mA[1].mC)) && allOk;
	allOk = compare_u16vec4(uvec4(9u, 8u, 7u, 3u), uvec4(s1.b.mB.mA.mA)) && allOk;
	allOk = compare_f16vec3(vec3(0.0, 1.0, -3.0), vec3(s1.b.mB.mA.mB)) && allOk;
	allOk = compare_f16vec4(vec4(-9.0, -6.0, 6.0, 5.0), vec4(s1.b.mB.mA.mC)) && allOk;
	allOk = compare_i16vec2(ivec2(-5, 2), ivec2(s1.b.mC.mA.mA)) && allOk;
	allOk = compare_mat4x3(mat4x3(4.0, 9.0, 2.0, 5.0, -2.0, -4.0, 7.0, 1.0, -8.0, -9.0, 5.0, 1.0), s1.b.mC.mA.mB) && allOk;
	allOk = compare_i16vec2(ivec2(-5, 5), ivec2(s1.b.mC.mA.mC)) && allOk;
	allOk = compare_float16_t(float(-3.0), float(s1.b.mC.mB.mA)) && allOk;
	allOk = compare_f16vec3(vec3(6.0, 6.0, 2.0), vec3(s1.b.mC.mC)) && allOk;
	allOk = compare_f16vec4(vec4(4.0, 4.0, -3.0, 3.0), vec4(s2.a[0][0].mA)) && allOk;
	allOk = compare_f16vec4(vec4(8.0, 6.0, -3.0, 4.0), vec4(s2.a[1][0].mA)) && allOk;
	allOk = compare_f16vec4(vec4(-7.0, 1.0, -5.0, -9.0), vec4(s2.a[2][0].mA)) && allOk;
	allOk = compare_u16vec4(uvec4(2u, 0u, 9u, 1u), uvec4(s2.b.mA.mA.mA)) && allOk;
	allOk = compare_vec2(vec2(-4.0, 5.0), s2.b.mB.mA.mA) && allOk;
	allOk = compare_ivec3(ivec3(-9, 6, 2), s2.b.mB.mA.mB) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	uint16_t mA;
	f16vec3 mB[2][3];
};
struct sB
{
	mediump vec2 mA;
	bvec4 mB;
};
struct sC
{
	float16_t mA;
	u16vec3 mB;
	float16_t mC;
};
struct sD
{
	sB mA;
	sC mB;
};
struct sE
{
	f16vec2 mA;
};
struct sF
{
	lowp ivec4 mA[3];
	sE mB;
};
struct sG
{
	lowp mat4x2 mA[2];
};
struct sH
{
	sD mA;
	sF mB;
	sG mC;
};
struct sI
{
	i16vec4 mA;
	lowp uint mB;
	i16vec3 mC;
};
struct sJ
{
	mediump mat3x2 mA[2];
	sI mB;
	f16vec3 mC[3];
};
struct sK
{
	sJ mA;
};
struct sL
{
	mediump uvec4 mA;
	highp uvec2 mB;
};
struct sM
{
	float16_t mA;
};
struct sN
{
	sL mA[3];
	sM mB[3];
};
struct sO
{
	i16vec4 mA;
	bvec3 mB;
};
struct sP
{
	highp uvec2 mA;
	u16vec3 mB;
	u16vec4 mC;
};
struct sQ
{
	f16vec2 mA[3];
	sP mB;
};
struct sR
{
	mediump uint mA;
	highp mat4x3 mB;
};
struct sS
{
	float16_t mA;
	bool mB;
};
struct sT
{
	sR mA;
	sS mB;
	lowp vec2 mC[2];
};
struct sU
{
	sO mA[1];
	sQ mB;
	sT mC;
};
struct sV
{
	i16vec3 mA;
};
struct sW
{
	uint16_t mA[3];
	sV mB;
};
struct sX
{
	sW mA;
};
struct sY
{
	f16vec3 mA[3][3];
};
struct S1 {
	sA a;
	sH b;
	sK c;
	sN d;
};
struct S2 {
	sU a;
	sX b;
	sY c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a.mA = uint16_t(4u);
	s1.a.mB[0][0] = f16vec3(7.0, -9.0, 3.0);
	s1.a.mB[0][1] = f16vec3(0.0, -7.0, 7.0);
	s1.a.mB[0][2] = f16vec3(-2.0, 3.0, 9.0);
	s1.a.mB[1][0] = f16vec3(1.0, -5.0, -2.0);
	s1.a.mB[1][1] = f16vec3(0.0, 9.0, -1.0);
	s1.a.mB[1][2] = f16vec3(-9.0, -6.0, -9.0);
	s1.b.mA.mA.mA = vec2(6.0, 1.0);
	s1.b.mA.mA.mB = bvec4(true, true, false, false);
	s1.b.mA.mB.mA = float16_t(6.0);
	s1.b.mA.mB.mB = u16vec3(5u, 8u, 4u);
	s1.b.mA.mB.mC = float16_t(-5.0);
	s1.b.mB.mA[0] = ivec4(1, 2, -7, 5);
	s1.b.mB.mA[1] = ivec4(-6, -9, -8, 8);
	s1.b.mB.mA[2] = ivec4(-5, 9, -9, -2);
	s1.b.mB.mB.mA = f16vec2(6.0, -7.0);
	s1.b.mC.mA[0] = mat4x2(8.0, 3.0, 9.0, 7.0, 9.0, 7.0, 3.0, -3.0);
	s1.b.mC.mA[1] = mat4x2(8.0, 1.0, -8.0, -3.0, -3.0, -3.0, 3.0, 3.0);
	s1.c.mA.mA[0] = mat3x2(2.0, 3.0, 1.0, 9.0, -4.0, 4.0);
	s1.c.mA.mA[1] = mat3x2(8.0, 2.0, 3.0, 0.0, -1.0, -9.0);
	s1.c.mA.mB.mA = i16vec4(-8, -2, 1, 1);
	s1.c.mA.mB.mB = 2u;
	s1.c.mA.mB.mC = i16vec3(-9, -6, 4);
	s1.c.mA.mC[0] = f16vec3(0.0, -3.0, -3.0);
	s1.c.mA.mC[1] = f16vec3(9.0, -1.0, -8.0);
	s1.c.mA.mC[2] = f16vec3(-9.0, -7.0, -2.0);
	s1.d.mA[0].mA = uvec4(3u, 6u, 1u, 0u);
	s1.d.mA[0].mB = uvec2(4u, 0u);
	s1.d.mA[1].mA = uvec4(8u, 3u, 5u, 6u);
	s1.d.mA[1].mB = uvec2(0u, 7u);
	s1.d.mA[2].mA = uvec4(3u, 6u, 8u, 4u);
	s1.d.mA[2].mB = uvec2(4u, 2u);
	s1.d.mB[0].mA = float16_t(-9.0);
	s1.d.mB[1].mA = float16_t(-5.0);
	s1.d.mB[2].mA = float16_t(-9.0);
	s2.a.mA[0].mA = i16vec4(4, 7, 7, -1);
	s2.a.mA[0].mB = bvec3(true, false, false);
	s2.a.mB.mA[0] = f16vec2(-5.0, -9.0);
	s2.a.mB.mA[1] = f16vec2(7.0, 4.0);
	s2.a.mB.mA[2] = f16vec2(-7.0, -6.0);
	s2.a.mB.mB.mA = uvec2(7u, 8u);
	s2.a.mB.mB.mB = u16vec3(7u, 1u, 4u);
	s2.a.mB.mB.mC = u16vec4(6u, 2u, 5u, 0u);
	s2.a.mC.mA.mA = 7u;
	s2.a.mC.mA.mB = mat4x3(6.0, 1.0, 4.0, -3.0, -2.0, 9.0, -5.0, -3.0, -7.0, -4.0, 0.0, -3.0);
	s2.a.mC.mB.mA = float16_t(-1.0);
	s2.a.mC.mB.mB = true;
	s2.a.mC.mC[0] = vec2(-4.0, -1.0);
	s2.a.mC.mC[1] = vec2(8.0, -6.0);
	s2.b.mA.mA[0] = uint16_t(8u);
	s2.b.mA.mA[1] = uint16_t(5u);
	s2.b.mA.mA[2] = uint16_t(3u);
	s2.b.mA.mB.mA = i16vec3(-7, 3, 5);
	s2.c.mA[0][0] = f16vec3(3.0, 3.0, 2.0);
	s2.c.mA[0][1] = f16vec3(0.0, 5.0, 8.0);
	s2.c.mA[0][2] = f16vec3(-2.0, 1.0, -7.0);
	s2.c.mA[1][0] = f16vec3(7.0, -7.0, -3.0);
	s2.c.mA[1][1] = f16vec3(2.0, 1.0, -3.0);
	s2.c.mA[1][2] = f16vec3(-3.0, 5.0, -7.0);
	s2.c.mA[2][0] = f16vec3(-2.0, 2.0, 8.0);
	s2.c.mA[2][1] = f16vec3(-9.0, 4.0, -6.0);
	s2.c.mA[2][2] = f16vec3(-1.0, 2.0, 0.0);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_uint16_t(uint(4u), uint(s1.a.mA)) && allOk;
	allOk = compare_f16vec3(vec3(7.0, -9.0, 3.0), vec3(s1.a.mB[0][0])) && allOk;
	allOk = compare_f16vec3(vec3(0.0, -7.0, 7.0), vec3(s1.a.mB[0][1])) && allOk;
	allOk = compare_f16vec3(vec3(-2.0, 3.0, 9.0), vec3(s1.a.mB[0][2])) && allOk;
	allOk = compare_f16vec3(vec3(1.0, -5.0, -2.0), vec3(s1.a.mB[1][0])) && allOk;
	allOk = compare_f16vec3(vec3(0.0, 9.0, -1.0), vec3(s1.a.mB[1][1])) && allOk;
	allOk = compare_f16vec3(vec3(-9.0, -6.0, -9.0), vec3(s1.a.mB[1][2])) && allOk;
	allOk = compare_vec2(vec2(6.0, 1.0), s1.b.mA.mA.mA) && allOk;
	allOk = compare_bvec4(bvec4(true, true, false, false), s1.b.mA.mA.mB) && allOk;
	allOk = compare_float16_t(float(6.0), float(s1.b.mA.mB.mA)) && allOk;
	allOk = compare_u16vec3(uvec3(5u, 8u, 4u), uvec3(s1.b.mA.mB.mB)) && allOk;
	allOk = compare_float16_t(float(-5.0), float(s1.b.mA.mB.mC)) && allOk;
	allOk = compare_ivec4(ivec4(1, 2, -7, 5), s1.b.mB.mA[0]) && allOk;
	allOk = compare_ivec4(ivec4(-6, -9, -8, 8), s1.b.mB.mA[1]) && allOk;
	allOk = compare_ivec4(ivec4(-5, 9, -9, -2), s1.b.mB.mA[2]) && allOk;
	allOk = compare_f16vec2(vec2(6.0, -7.0), vec2(s1.b.mB.mB.mA)) && allOk;
	allOk = compare_mat4x2(mat4x2(8.0, 3.0, 9.0, 7.0, 9.0, 7.0, 3.0, -3.0), s1.b.mC.mA[0]) && allOk;
	allOk = compare_mat4x2(mat4x2(8.0, 1.0, -8.0, -3.0, -3.0, -3.0, 3.0, 3.0), s1.b.mC.mA[1]) && allOk;
	allOk = compare_mat3x2(mat3x2(2.0, 3.0, 1.0, 9.0, -4.0, 4.0), s1.c.mA.mA[0]) && allOk;
	allOk = compare_mat3x2(mat3x2(8.0, 2.0, 3.0, 0.0, -1.0, -9.0), s1.c.mA.mA[1]) && allOk;
	allOk = compare_i16vec4(ivec4(-8, -2, 1, 1), ivec4(s1.c.mA.mB.mA)) && allOk;
	allOk = compare_uint(2u, s1.c.mA.mB.mB) && allOk;
	allOk = compare_i16vec3(ivec3(-9, -6, 4), ivec3(s1.c.mA.mB.mC)) && allOk;
	allOk = compare_f16vec3(vec3(0.0, -3.0, -3.0), vec3(s1.c.mA.mC[0])) && allOk;
	allOk = compare_f16vec3(vec3(9.0, -1.0, -8.0), vec3(s1.c.mA.mC[1])) && allOk;
	allOk = compare_f16vec3(vec3(-9.0, -7.0, -2.0), vec3(s1.c.mA.mC[2])) && allOk;
	allOk = compare_uvec4(uvec4(3u, 6u, 1u, 0u), s1.d.mA[0].mA) && allOk;
	allOk = compare_uvec2(uvec2(4u, 0u), s1.d.mA[0].mB) && allOk;
	allOk = compare_uvec4(uvec4(8u, 3u, 5u, 6u), s1.d.mA[1].mA) && allOk;
	allOk = compare_uvec2(uvec2(0u, 7u), s1.d.mA[1].mB) && allOk;
	allOk = compare_uvec4(uvec4(3u, 6u, 8u, 4u), s1.d.mA[2].mA) && allOk;
	allOk = compare_uvec2(uvec2(4u, 2u), s1.d.mA[2].mB) && allOk;
	allOk = compare_float16_t(float(-9.0), float(s1.d.mB[0].mA)) && allOk;
	allOk = compare_float16_t(float(-5.0), float(s1.d.mB[1].mA)) && allOk;
	allOk = compare_float16_t(float(-9.0), float(s1.d.mB[2].mA)) && allOk;
	allOk = compare_i16vec4(ivec4(4, 7, 7, -1), ivec4(s2.a.mA[0].mA)) && allOk;
	allOk = compare_bvec3(bvec3(true, false, false), s2.a.mA[0].mB) && allOk;
	allOk = compare_f16vec2(vec2(-5.0, -9.0), vec2(s2.a.mB.mA[0])) && allOk;
	allOk = compare_f16vec2(vec2(7.0, 4.0), vec2(s2.a.mB.mA[1])) && allOk;
	allOk = compare_f16vec2(vec2(-7.0, -6.0), vec2(s2.a.mB.mA[2])) && allOk;
	allOk = compare_uvec2(uvec2(7u, 8u), s2.a.mB.mB.mA) && allOk;
	allOk = compare_u16vec3(uvec3(7u, 1u, 4u), uvec3(s2.a.mB.mB.mB)) && allOk;
	allOk = compare_u16vec4(uvec4(6u, 2u, 5u, 0u), uvec4(s2.a.mB.mB.mC)) && allOk;
	allOk = compare_uint(7u, s2.a.mC.mA.mA) && allOk;
	allOk = compare_mat4x3(mat4x3(6.0, 1.0, 4.0, -3.0, -2.0, 9.0, -5.0, -3.0, -7.0, -4.0, 0.0, -3.0), s2.a.mC.mA.mB) && allOk;
	allOk = compare_float16_t(float(-1.0), float(s2.a.mC.mB.mA)) && allOk;
	allOk = compare_bool(true, s2.a.mC.mB.mB) && allOk;
	allOk = compare_vec2(vec2(-4.0, -1.0), s2.a.mC.mC[0]) && allOk;
	allOk = compare_vec2(vec2(8.0, -6.0), s2.a.mC.mC[1]) && allOk;
	allOk = compare_uint16_t(uint(8u), uint(s2.b.mA.mA[0])) && allOk;
	allOk = compare_uint16_t(uint(5u), uint(s2.b.mA.mA[1])) && allOk;
	allOk = compare_uint16_t(uint(3u), uint(s2.b.mA.mA[2])) && allOk;
	allOk = compare_i16vec3(ivec3(-7, 3, 5), ivec3(s2.b.mA.mB.mA)) && allOk;
	allOk = compare_f16vec3(vec3(3.0, 3.0, 2.0), vec3(s2.c.mA[0][0])) && allOk;
	allOk = compare_f16vec3(vec3(0.0, 5.0, 8.0), vec3(s2.c.mA[0][1])) && allOk;
	allOk = compare_f16vec3(vec3(-2.0, 1.0, -7.0), vec3(s2.c.mA[0][2])) && allOk;
	allOk = compare_f16vec3(vec3(7.0, -7.0, -3.0), vec3(s2.c.mA[1][0])) && allOk;
	allOk = compare_f16vec3(vec3(2.0, 1.0, -3.0), vec3(s2.c.mA[1][1])) && allOk;
	allOk = compare_f16vec3(vec3(-3.0, 5.0, -7.0), vec3(s2.c.mA[1][2])) && allOk;
	allOk = compare_f16vec3(vec3(-2.0, 2.0, 8.0), vec3(s2.c.mA[2][0])) && allOk;
	allOk = compare_f16vec3(vec3(-9.0, 4.0, -6.0), vec3(s2.c.mA[2][1])) && allOk;
	allOk = compare_f16vec3(vec3(-1.0, 2.0, 0.0), vec3(s2.c.mA[2][2])) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	lowp ivec3 mA;
};
struct sB
{
	sA mA[2];
};
struct sC
{
	mediump mat3x2 mA;
};
struct sD
{
	highp uvec4 mA;
};
struct sE
{
	sC mA;
	sD mB;
};
struct sF
{
	bvec4 mA;
	f16vec3 mB;
};
struct sG
{
	lowp mat4 mA;
	uint16_t mB;
};
struct sH
{
	sF mA;
	sG mB;
};
struct sI
{
	sE mA;
	sH mB;
};
struct S1 {
	sB a;
	sI b;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

shared S1 s1;

void main (void) {
	s1.a.mA[0].mA = ivec3(2, -3, 2);
	s1.a.mA[1].mA = ivec3(-4, 4, 6);
	s1.b.mA.mA.mA = mat3x2(-2.0, -5.0, -3.0, -3.0, 1.0, -3.0);
	s1.b.mA.mB.mA = uvec4(8u, 9u, 8u, 8u);
	s1.b.mB.mA.mA = bvec4(true, false, true, true);
	s1.b.mB.mA.mB = f16vec3(-3.0, 4.0, -3.0);
	s1.b.mB.mB.mA = mat4(-7.0, -7.0, -1.0, 9.0, -6.0, 8.0, -4.0, 4.0, 1.0, -6.0, -2.0, -3.0, -5.0, 4.0, 3.0, 0.0);
	s1.b.mB.mB.mB = uint16_t(4u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_ivec3(ivec3(2, -3, 2), s1.a.mA[0].mA) && allOk;
	allOk = compare_ivec3(ivec3(-4, 4, 6), s1.a.mA[1].mA) && allOk;
	allOk = compare_mat3x2(mat3x2(-2.0, -5.0, -3.0, -3.0, 1.0, -3.0), s1.b.mA.mA.mA) && allOk;
	allOk = compare_uvec4(uvec4(8u, 9u, 8u, 8u), s1.b.mA.mB.mA) && allOk;
	allOk = compare_bvec4(bvec4(true, false, true, true), s1.b.mB.mA.mA) && allOk;
	allOk = compare_f16vec3(vec3(-3.0, 4.0, -3.0), vec3(s1.b.mB.mA.mB)) && allOk;
	allOk = compare_mat4(mat4(-7.0, -7.0, -1.0, 9.0, -6.0, 8.0, -4.0, 4.0, 1.0, -6.0, -2.0, -3.0, -5.0, 4.0, 3.0, 0.0), s1.b.mB.mB.mA) && allOk;
	allOk = compare_uint16_t(uint(4u), uint(s1.b.mB.mB.mB)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	i16vec2 mA;
};
struct sB
{
	sA mA;
};
struct sC
{
	mediump int mA;
	mediump mat3x2 mB;
	uint16_t mC;
};
struct sD
{
	float16_t mA[3];
	i16vec4 mB[2];
	sC mC;
};
struct sE
{
	sB mA;
	lowp mat4x2 mB;
	sD mC;
};
struct sF
{
	i16vec3 mA;
};
struct sG
{
	sF mA[3];
};
struct sH
{
	float16_t mA;
	bool mB;
	lowp uint mC;
};
struct sI
{
	mediump ivec2 mA;
	highp mat4x3 mB;
};
struct sJ
{
	lowp ivec2 mA;
	u16vec4 mB;
};
struct sK
{
	sH mA;
	sI mB;
	sJ mC;
};
struct sL
{
	float16_t mA;
	highp vec3 mB;
	u16vec4 mC;
};
struct sM
{
	f16vec4 mA;
	sL mB;
	f16vec4 mC[1];
};
struct sN
{
	sM mA;
};
struct sO
{
	lowp mat3x2 mA;
	int16_t mB;
	lowp uvec4 mC;
};
struct sP
{
	u16vec4 mA;
	i16vec4 mB;
};
struct sQ
{
	sP mA;
};
struct sR
{
	f16vec3 mA[1][2];
	sO mB[3];
	sQ mC;
};
struct sS
{
	uint16_t mA;
	i16vec3 mB;
	uint16_t mC;
};
struct sT
{
	i16vec4 mA;
};
struct sU
{
	sS mA;
	sT mB;
	float16_t mC[3];
};
struct sV
{
	f16vec2 mA;
	float16_t mB;
	i16vec4 mC;
};
struct sW
{
	sV mA;
	f16vec3 mB;
};
struct sX
{
	u16vec4 mA;
	uint16_t mB;
};
struct sY
{
	sX mA;
	f16vec3 mB[2];
	float16_t mC;
};
struct sZ
{
	sW mA;
	sY mB;
};
struct sAA
{
	u16vec2 mA;
};
struct sAB
{
	mediump mat4 mA;
	i16vec4 mB;
};
struct sAC
{
	i16vec2 mA;
};
struct sAD
{
	sAA mA;
	sAB mB;
	sAC mC;
};
struct sAE
{
	highp mat2 mA;
};
struct sAF
{
	sAE mA;
	bool mB[3];
	i16vec4 mC[3];
};
struct sAG
{
	i16vec2 mA[2];
};
struct sAH
{
	sAD mA;
	sAF mB;
	sAG mC;
};
struct sAI
{
	f16vec2 mA;
	f16vec2 mB;
	f16vec4 mC;
};
struct sAJ
{
	sAI mA[3];
};
struct sAK
{
	f16vec3 mA;
};
struct S1 {
	sE a;
	sG b;
	sK c[3];
	sN d;
};
struct S2 {
	sR a;
	sU b[2];
	sZ c;
	sAH d;
};
struct S3 {
	sAJ a;
	sAK b;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

shared S1 s1;
shared S2 s2;
shared S3 s3;

void main (void) {
	s1.a.mA.mA.mA = i16vec2(-4, 6);
	s1.a.mB = mat4x2(6.0, -7.0, -9.0, 5.0, -4.0, -9.0, 8.0, 6.0);
	s1.a.mC.mA[0] = float16_t(-2.0);
	s1.a.mC.mA[1] = float16_t(-6.0);
	s1.a.mC.mA[2] = float16_t(4.0);
	s1.a.mC.mB[0] = i16vec4(-6, -3, 2, -9);
	s1.a.mC.mB[1] = i16vec4(-7, -5, -7, 3);
	s1.a.mC.mC.mA = 5;
	s1.a.mC.mC.mB = mat3x2(2.0, -9.0, 0.0, -5.0, 0.0, 1.0);
	s1.a.mC.mC.mC = uint16_t(7u);
	s1.b.mA[0].mA = i16vec3(0, 3, -5);
	s1.b.mA[1].mA = i16vec3(5, -7, 1);
	s1.b.mA[2].mA = i16vec3(-8, 2, 0);
	s1.c[0].mA.mA = float16_t(1.0);
	s1.c[0].mA.mB = true;
	s1.c[0].mA.mC = 4u;
	s1.c[0].mB.mA = ivec2(7, -6);
	s1.c[0].mB.mB = mat4x3(-9.0, -5.0, 6.0, -8.0, -8.0, 3.0, 3.0, 8.0, 4.0, -1.0, 3.0, -6.0);
	s1.c[0].mC.mA = ivec2(8, -6);
	s1.c[0].mC.mB = u16vec4(0u, 3u, 2u, 3u);
	s1.c[1].mA.mA = float16_t(5.0);
	s1.c[1].mA.mB = false;
	s1.c[1].mA.mC = 9u;
	s1.c[1].mB.mA = ivec2(0, -7);
	s1.c[1].mB.mB = mat4x3(-8.0, 2.0, 4.0, 7.0, -9.0, -3.0, 0.0, 4.0, -7.0, -1.0, 1.0, 1.0);
	s1.c[1].mC.mA = ivec2(-7, 1);
	s1.c[1].mC.mB = u16vec4(8u, 1u, 6u, 6u);
	s1.c[2].mA.mA = float16_t(5.0);
	s1.c[2].mA.mB = false;
	s1.c[2].mA.mC = 1u;
	s1.c[2].mB.mA = ivec2(9, 4);
	s1.c[2].mB.mB = mat4x3(7.0, -1.0, -6.0, 2.0, 0.0, -9.0, 8.0, 3.0, -7.0, -1.0, 0.0, -2.0);
	s1.c[2].mC.mA = ivec2(-9, 1);
	s1.c[2].mC.mB = u16vec4(0u, 0u, 5u, 4u);
	s1.d.mA.mA = f16vec4(-9.0, -3.0, 9.0, 8.0);
	s1.d.mA.mB.mA = float16_t(6.0);
	s1.d.mA.mB.mB = vec3(-3.0, -7.0, 7.0);
	s1.d.mA.mB.mC = u16vec4(7u, 0u, 5u, 6u);
	s1.d.mA.mC[0] = f16vec4(2.0, 4.0, -4.0, -8.0);
	s2.a.mA[0][0] = f16vec3(4.0, 1.0, -6.0);
	s2.a.mA[0][1] = f16vec3(3.0, -5.0, 2.0);
	s2.a.mB[0].mA = mat3x2(-4.0, 2.0, -4.0, 7.0, -7.0, 4.0);
	s2.a.mB[0].mB = int16_t(-1);
	s2.a.mB[0].mC = uvec4(1u, 8u, 3u, 1u);
	s2.a.mB[1].mA = mat3x2(-2.0, 2.0, 5.0, -9.0, -4.0, 0.0);
	s2.a.mB[1].mB = int16_t(-5);
	s2.a.mB[1].mC = uvec4(3u, 0u, 5u, 7u);
	s2.a.mB[2].mA = mat3x2(-7.0, 9.0, -5.0, -9.0, 3.0, -9.0);
	s2.a.mB[2].mB = int16_t(7);
	s2.a.mB[2].mC = uvec4(8u, 4u, 7u, 2u);
	s2.a.mC.mA.mA = u16vec4(2u, 3u, 5u, 4u);
	s2.a.mC.mA.mB = i16vec4(-3, -3, 8, -5);
	s2.b[0].mA.mA = uint16_t(7u);
	s2.b[0].mA.mB = i16vec3(-2, 3, -7);
	s2.b[0].mA.mC = uint16_t(4u);
	s2.b[0].mB.mA = i16vec4(-5, 6, 2, -7);
	s2.b[0].mC[0] = float16_t(7.0);
	s2.b[0].mC[1] = float16_t(-2.0);
	s2.b[0].mC[2] = float16_t(-8.0);
	s2.b[1].mA.mA = uint16_t(0u);
	s2.b[1].mA.mB = i16vec3(-4, -8, -6);
	s2.b[1].mA.mC = uint16_t(7u);
	s2.b[1].mB.mA = i16vec4(3, 0, 6, 7);
	s2.b[1].mC[0] = float16_t(9.0);
	s2.b[1].mC[1] = float16_t(7.0);
	s2.b[1].mC[2] = float16_t(5.0);
	s2.c.mA.mA.mA = f16vec2(-4.0, -5.0);
	s2.c.mA.mA.mB = float16_t(9.0);
	s2.c.mA.mA.mC = i16vec4(-8, -2, -2, 7);
	s2.c.mA.mB = f16vec3(8.0, 9.0, -3.0);
	s2.c.mB.mA.mA = u16vec4(8u, 5u, 0u, 2u);
	s2.c.mB.mA.mB = uint16_t(5u);
	s2.c.mB.mB[0] = f16vec3(9.0, 8.0, 9.0);
	s2.c.mB.mB[1] = f16vec3(9.0, 1.0, -4.0);
	s2.c.mB.mC = float16_t(-5.0);
	s2.d.mA.mA.mA = u16vec2(7u, 5u);
	s2.d.mA.mB.mA = mat4(8.0, 7.0, 5.0, -9.0, -9.0, -5.0, 3.0, -2.0, -2.0, -2.0, -4.0, 7.0, 1.0, -5.0, -6.0, 1.0);
	s2.d.mA.mB.mB = i16vec4(-3, 8, -4, -2);
	s2.d.mA.mC.mA = i16vec2(0, 9);
	s2.d.mB.mA.mA = mat2(3.0, 8.0, -2.0, -7.0);
	s2.d.mB.mB[0] = false;
	s2.d.mB.mB[1] = true;
	s2.d.mB.mB[2] = false;
	s2.d.mB.mC[0] = i16vec4(3, 5, -2, 5);
	s2.d.mB.mC[1] = i16vec4(-2, 7, -6, 4);
	s2.d.mB.mC[2] = i16vec4(-3, 1, -9, -1);
	s2.d.mC.mA[0] = i16vec2(-3, 0);
	s2.d.mC.mA[1] = i16vec2(-1, 9);
	s3.a.mA[0].mA = f16vec2(0.0, -8.0);
	s3.a.mA[0].mB = f16vec2(0.0, -1.0);
	s3.a.mA[0].mC = f16vec4(-7.0, 5.0, -6.0, -2.0);
	s3.a.mA[1].mA = f16vec2(-3.0, 2.0);
	s3.a.mA[1].mB = f16vec2(-7.0, 2.0);
	s3.a.mA[1].mC = f16vec4(8.0, 0.0, 9.0, -2.0);
	s3.a.mA[2].mA = f16vec2(-5.0, 0.0);
	s3.a.mA[2].mB = f16vec2(0.0, -5.0);
	s3.a.mA[2].mC = f16vec4(8.0, 4.0, 3.0, -6.0);
	s3.b.mA = f16vec3(-4.0, 1.0, 7.0);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_i16vec2(ivec2(-4, 6), ivec2(s1.a.mA.mA.mA)) && allOk;
	allOk = compare_mat4x2(mat4x2(6.0, -7.0, -9.0, 5.0, -4.0, -9.0, 8.0, 6.0), s1.a.mB) && allOk;
	allOk = compare_float16_t(float(-2.0), float(s1.a.mC.mA[0])) && allOk;
	allOk = compare_float16_t(float(-6.0), float(s1.a.mC.mA[1])) && allOk;
	allOk = compare_float16_t(float(4.0), float(s1.a.mC.mA[2])) && allOk;
	allOk = compare_i16vec4(ivec4(-6, -3, 2, -9), ivec4(s1.a.mC.mB[0])) && allOk;
	allOk = compare_i16vec4(ivec4(-7, -5, -7, 3), ivec4(s1.a.mC.mB[1])) && allOk;
	allOk = compare_int(5, s1.a.mC.mC.mA) && allOk;
	allOk = compare_mat3x2(mat3x2(2.0, -9.0, 0.0, -5.0, 0.0, 1.0), s1.a.mC.mC.mB) && allOk;
	allOk = compare_uint16_t(uint(7u), uint(s1.a.mC.mC.mC)) && allOk;
	allOk = compare_i16vec3(ivec3(0, 3, -5), ivec3(s1.b.mA[0].mA)) && allOk;
	allOk = compare_i16vec3(ivec3(5, -7, 1), ivec3(s1.b.mA[1].mA)) && allOk;
	allOk = compare_i16vec3(ivec3(-8, 2, 0), ivec3(s1.b.mA[2].mA)) && allOk;
	allOk = compare_float16_t(float(1.0), float(s1.c[0].mA.mA)) && allOk;
	allOk = compare_bool(true, s1.c[0].mA.mB) && allOk;
	allOk = compare_uint(4u, s1.c[0].mA.mC) && allOk;
	allOk = compare_ivec2(ivec2(7, -6), s1.c[0].mB.mA) && allOk;
	allOk = compare_mat4x3(mat4x3(-9.0, -5.0, 6.0, -8.0, -8.0, 3.0, 3.0, 8.0, 4.0, -1.0, 3.0, -6.0), s1.c[0].mB.mB) && allOk;
	allOk = compare_ivec2(ivec2(8, -6), s1.c[0].mC.mA) && allOk;
	allOk = compare_u16vec4(uvec4(0u, 3u, 2u, 3u), uvec4(s1.c[0].mC.mB)) && allOk;
	allOk = compare_float16_t(float(5.0), float(s1.c[1].mA.mA)) && allOk;
	allOk = compare_bool(false, s1.c[1].mA.mB) && allOk;
	allOk = compare_uint(9u, s1.c[1].mA.mC) && allOk;
	allOk = compare_ivec2(ivec2(0, -7), s1.c[1].mB.mA) && allOk;
	allOk = compare_mat4x3(mat4x3(-8.0, 2.0, 4.0, 7.0, -9.0, -3.0, 0.0, 4.0, -7.0, -1.0, 1.0, 1.0), s1.c[1].mB.mB) && allOk;
	allOk = compare_ivec2(ivec2(-7, 1), s1.c[1].mC.mA) && allOk;
	allOk = compare_u16vec4(uvec4(8u, 1u, 6u, 6u), uvec4(s1.c[1].mC.mB)) && allOk;
	allOk = compare_float16_t(float(5.0), float(s1.c[2].mA.mA)) && allOk;
	allOk = compare_bool(false, s1.c[2].mA.mB) && allOk;
	allOk = compare_uint(1u, s1.c[2].mA.mC) && allOk;
	allOk = compare_ivec2(ivec2(9, 4), s1.c[2].mB.mA) && allOk;
	allOk = compare_mat4x3(mat4x3(7.0, -1.0, -6.0, 2.0, 0.0, -9.0, 8.0, 3.0, -7.0, -1.0, 0.0, -2.0), s1.c[2].mB.mB) && allOk;
	allOk = compare_ivec2(ivec2(-9, 1), s1.c[2].mC.mA) && allOk;
	allOk = compare_u16vec4(uvec4(0u, 0u, 5u, 4u), uvec4(s1.c[2].mC.mB)) && allOk;
	allOk = compare_f16vec4(vec4(-9.0, -3.0, 9.0, 8.0), vec4(s1.d.mA.mA)) && allOk;
	allOk = compare_float16_t(float(6.0), float(s1.d.mA.mB.mA)) && allOk;
	allOk = compare_vec3(vec3(-3.0, -7.0, 7.0), s1.d.mA.mB.mB) && allOk;
	allOk = compare_u16vec4(uvec4(7u, 0u, 5u, 6u), uvec4(s1.d.mA.mB.mC)) && allOk;
	allOk = compare_f16vec4(vec4(2.0, 4.0, -4.0, -8.0), vec4(s1.d.mA.mC[0])) && allOk;
	allOk = compare_f16vec3(vec3(4.0, 1.0, -6.0), vec3(s2.a.mA[0][0])) && allOk;
	allOk = compare_f16vec3(vec3(3.0, -5.0, 2.0), vec3(s2.a.mA[0][1])) && allOk;
	allOk = compare_mat3x2(mat3x2(-4.0, 2.0, -4.0, 7.0, -7.0, 4.0), s2.a.mB[0].mA) && allOk;
	allOk = compare_int16_t(int(-1), int(s2.a.mB[0].mB)) && allOk;
	allOk = compare_uvec4(uvec4(1u, 8u, 3u, 1u), s2.a.mB[0].mC) && allOk;
	allOk = compare_mat3x2(mat3x2(-2.0, 2.0, 5.0, -9.0, -4.0, 0.0), s2.a.mB[1].mA) && allOk;
	allOk = compare_int16_t(int(-5), int(s2.a.mB[1].mB)) && allOk;
	allOk = compare_uvec4(uvec4(3u, 0u, 5u, 7u), s2.a.mB[1].mC) && allOk;
	allOk = compare_mat3x2(mat3x2(-7.0, 9.0, -5.0, -9.0, 3.0, -9.0), s2.a.mB[2].mA) && allOk;
	allOk = compare_int16_t(int(7), int(s2.a.mB[2].mB)) && allOk;
	allOk = compare_uvec4(uvec4(8u, 4u, 7u, 2u), s2.a.mB[2].mC) && allOk;
	allOk = compare_u16vec4(uvec4(2u, 3u, 5u, 4u), uvec4(s2.a.mC.mA.mA)) && allOk;
	allOk = compare_i16vec4(ivec4(-3, -3, 8, -5), ivec4(s2.a.mC.mA.mB)) && allOk;
	allOk = compare_uint16_t(uint(7u), uint(s2.b[0].mA.mA)) && allOk;
	allOk = compare_i16vec3(ivec3(-2, 3, -7), ivec3(s2.b[0].mA.mB)) && allOk;
	allOk = compare_uint16_t(uint(4u), uint(s2.b[0].mA.mC)) && allOk;
	allOk = compare_i16vec4(ivec4(-5, 6, 2, -7), ivec4(s2.b[0].mB.mA)) && allOk;
	allOk = compare_float16_t(float(7.0), float(s2.b[0].mC[0])) && allOk;
	allOk = compare_float16_t(float(-2.0), float(s2.b[0].mC[1])) && allOk;
	allOk = compare_float16_t(float(-8.0), float(s2.b[0].mC[2])) && allOk;
	allOk = compare_uint16_t(uint(0u), uint(s2.b[1].mA.mA)) && allOk;
	allOk = compare_i16vec3(ivec3(-4, -8, -6), ivec3(s2.b[1].mA.mB)) && allOk;
	allOk = compare_uint16_t(uint(7u), uint(s2.b[1].mA.mC)) && allOk;
	allOk = compare_i16vec4(ivec4(3, 0, 6, 7), ivec4(s2.b[1].mB.mA)) && allOk;
	allOk = compare_float16_t(float(9.0), float(s2.b[1].mC[0])) && allOk;
	allOk = compare_float16_t(float(7.0), float(s2.b[1].mC[1])) && allOk;
	allOk = compare_float16_t(float(5.0), float(s2.b[1].mC[2])) && allOk;
	allOk = compare_f16vec2(vec2(-4.0, -5.0), vec2(s2.c.mA.mA.mA)) && allOk;
	allOk = compare_float16_t(float(9.0), float(s2.c.mA.mA.mB)) && allOk;
	allOk = compare_i16vec4(ivec4(-8, -2, -2, 7), ivec4(s2.c.mA.mA.mC)) && allOk;
	allOk = compare_f16vec3(vec3(8.0, 9.0, -3.0), vec3(s2.c.mA.mB)) && allOk;
	allOk = compare_u16vec4(uvec4(8u, 5u, 0u, 2u), uvec4(s2.c.mB.mA.mA)) && allOk;
	allOk = compare_uint16_t(uint(5u), uint(s2.c.mB.mA.mB)) && allOk;
	allOk = compare_f16vec3(vec3(9.0, 8.0, 9.0), vec3(s2.c.mB.mB[0])) && allOk;
	allOk = compare_f16vec3(vec3(9.0, 1.0, -4.0), vec3(s2.c.mB.mB[1])) && allOk;
	allOk = compare_float16_t(float(-5.0), float(s2.c.mB.mC)) && allOk;
	allOk = compare_u16vec2(uvec2(7u, 5u), uvec2(s2.d.mA.mA.mA)) && allOk;
	allOk = compare_mat4(mat4(8.0, 7.0, 5.0, -9.0, -9.0, -5.0, 3.0, -2.0, -2.0, -2.0, -4.0, 7.0, 1.0, -5.0, -6.0, 1.0), s2.d.mA.mB.mA) && allOk;
	allOk = compare_i16vec4(ivec4(-3, 8, -4, -2), ivec4(s2.d.mA.mB.mB)) && allOk;
	allOk = compare_i16vec2(ivec2(0, 9), ivec2(s2.d.mA.mC.mA)) && allOk;
	allOk = compare_mat2(mat2(3.0, 8.0, -2.0, -7.0), s2.d.mB.mA.mA) && allOk;
	allOk = compare_bool(false, s2.d.mB.mB[0]) && allOk;
	allOk = compare_bool(true, s2.d.mB.mB[1]) && allOk;
	allOk = compare_bool(false, s2.d.mB.mB[2]) && allOk;
	allOk = compare_i16vec4(ivec4(3, 5, -2, 5), ivec4(s2.d.mB.mC[0])) && allOk;
	allOk = compare_i16vec4(ivec4(-2, 7, -6, 4), ivec4(s2.d.mB.mC[1])) && allOk;
	allOk = compare_i16vec4(ivec4(-3, 1, -9, -1), ivec4(s2.d.mB.mC[2])) && allOk;
	allOk = compare_i16vec2(ivec2(-3, 0), ivec2(s2.d.mC.mA[0])) && allOk;
	allOk = compare_i16vec2(ivec2(-1, 9), ivec2(s2.d.mC.mA[1])) && allOk;
	allOk = compare_f16vec2(vec2(0.0, -8.0), vec2(s3.a.mA[0].mA)) && allOk;
	allOk = compare_f16vec2(vec2(0.0, -1.0), vec2(s3.a.mA[0].mB)) && allOk;
	allOk = compare_f16vec4(vec4(-7.0, 5.0, -6.0, -2.0), vec4(s3.a.mA[0].mC)) && allOk;
	allOk = compare_f16vec2(vec2(-3.0, 2.0), vec2(s3.a.mA[1].mA)) && allOk;
	allOk = compare_f16vec2(vec2(-7.0, 2.0), vec2(s3.a.mA[1].mB)) && allOk;
	allOk = compare_f16vec4(vec4(8.0, 0.0, 9.0, -2.0), vec4(s3.a.mA[1].mC)) && allOk;
	allOk = compare_f16vec2(vec2(-5.0, 0.0), vec2(s3.a.mA[2].mA)) && allOk;
	allOk = compare_f16vec2(vec2(0.0, -5.0), vec2(s3.a.mA[2].mB)) && allOk;
	allOk = compare_f16vec4(vec4(8.0, 4.0, 3.0, -6.0), vec4(s3.a.mA[2].mC)) && allOk;
	allOk = compare_f16vec3(vec3(-4.0, 1.0, 7.0), vec3(s3.b.mA)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	f16vec3 mA;
	bool mB;
};
struct sB
{
	highp float mA;
	bool mB;
	i16vec4 mC;
};
struct sC
{
	highp vec2 mA;
	i16vec2 mB;
	f16vec4 mC;
};
struct sD
{
	sA mA;
	sB mB;
	sC mC;
};
struct sE
{
	u16vec2 mA;
};
struct sF
{
	sE mA;
};
struct sG
{
	bool mA[2];
};
struct sH
{
	sD mA;
	sF mB;
	sG mC;
};
struct sI
{
	u16vec4 mA;
	i16vec4 mB;
};
struct sJ
{
	sI mA;
};
struct sK
{
	sJ mA;
};
struct sL
{
	i16vec3 mA;
	u16vec4 mB;
	u16vec4 mC;
};
struct S1 {
	sH a;
	sK b;
	uint16_t c;
	sL d[1][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

shared S1 s1;

void main (void) {
	s1.a.mA.mA.mA = f16vec3(-5.0, 5.0, -6.0);
	s1.a.mA.mA.mB = true;
	s1.a.mA.mB.mA = 9.0;
	s1.a.mA.mB.mB = true;
	s1.a.mA.mB.mC = i16vec4(7, 7, 0, 5);
	s1.a.mA.mC.mA = vec2(-7.0, -5.0);
	s1.a.mA.mC.mB = i16vec2(-2, -1);
	s1.a.mA.mC.mC = f16vec4(5.0, 2.0, -4.0, 7.0);
	s1.a.mB.mA.mA = u16vec2(8u, 1u);
	s1.a.mC.mA[0] = false;
	s1.a.mC.mA[1] = false;
	s1.b.mA.mA.mA = u16vec4(1u, 0u, 4u, 5u);
	s1.b.mA.mA.mB = i16vec4(9, -5, 1, 8);
	s1.c = uint16_t(2u);
	s1.d[0][0].mA = i16vec3(4, -8, -3);
	s1.d[0][0].mB = u16vec4(4u, 9u, 9u, 6u);
	s1.d[0][0].mC = u16vec4(9u, 1u, 5u, 1u);
	s1.d[0][1].mA = i16vec3(0, 6, 8);
	s1.d[0][1].mB = u16vec4(1u, 6u, 3u, 8u);
	s1.d[0][1].mC = u16vec4(3u, 9u, 5u, 9u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_f16vec3(vec3(-5.0, 5.0, -6.0), vec3(s1.a.mA.mA.mA)) && allOk;
	allOk = compare_bool(true, s1.a.mA.mA.mB) && allOk;
	allOk = compare_float(9.0, s1.a.mA.mB.mA) && allOk;
	allOk = compare_bool(true, s1.a.mA.mB.mB) && allOk;
	allOk = compare_i16vec4(ivec4(7, 7, 0, 5), ivec4(s1.a.mA.mB.mC)) && allOk;
	allOk = compare_vec2(vec2(-7.0, -5.0), s1.a.mA.mC.mA) && allOk;
	allOk = compare_i16vec2(ivec2(-2, -1), ivec2(s1.a.mA.mC.mB)) && allOk;
	allOk = compare_f16vec4(vec4(5.0, 2.0, -4.0, 7.0), vec4(s1.a.mA.mC.mC)) && allOk;
	allOk = compare_u16vec2(uvec2(8u, 1u), uvec2(s1.a.mB.mA.mA)) && allOk;
	allOk = compare_bool(false, s1.a.mC.mA[0]) && allOk;
	allOk = compare_bool(false, s1.a.mC.mA[1]) && allOk;
	allOk = compare_u16vec4(uvec4(1u, 0u, 4u, 5u), uvec4(s1.b.mA.mA.mA)) && allOk;
	allOk = compare_i16vec4(ivec4(9, -5, 1, 8), ivec4(s1.b.mA.mA.mB)) && allOk;
	allOk = compare_uint16_t(uint(2u), uint(s1.c)) && allOk;
	allOk = compare_i16vec3(ivec3(4, -8, -3), ivec3(s1.d[0][0].mA)) && allOk;
	allOk = compare_u16vec4(uvec4(4u, 9u, 9u, 6u), uvec4(s1.d[0][0].mB)) && allOk;
	allOk = compare_u16vec4(uvec4(9u, 1u, 5u, 1u), uvec4(s1.d[0][0].mC)) && allOk;
	allOk = compare_i16vec3(ivec3(0, 6, 8), ivec3(s1.d[0][1].mA)) && allOk;
	allOk = compare_u16vec4(uvec4(1u, 6u, 3u, 8u), uvec4(s1.d[0][1].mB)) && allOk;
	allOk = compare_u16vec4(uvec4(3u, 9u, 5u, 9u), uvec4(s1.d[0][1].mC)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	i16vec3 mA;
};
struct sB
{
	sA mA;
	f16vec4 mB[3];
};
struct sC
{
	lowp mat4 mA;
	u16vec4 mB;
};
struct sD
{
	f16vec3 mA;
	int16_t mB;
	mediump vec2 mC;
};
struct sE
{
	bvec3 mA[2];
	sC mB;
	sD mC;
};
struct sF
{
	sE mA;
};
struct sG
{
	int16_t mA;
};
struct sH
{
	uint16_t mA;
	u16vec2 mB[3];
	sG mC;
};
struct sI
{
	i16vec3 mA;
	u16vec3 mB;
};
struct sJ
{
	highp mat4x3 mA[3];
	sI mB;
};
struct sK
{
	u16vec4 mA;
};
struct sL
{
	i16vec4 mA[1];
	sK mB;
};
struct sM
{
	f16vec3 mA[1];
};
struct sN
{
	sL mA;
	sM mB;
};
struct S1 {
	sB a[3];
	sF b;
};
struct S2 {
	sH a[3];
	sJ b[1];
	sN c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a[0].mA.mA = i16vec3(1, -6, -5);
	s1.a[0].mB[0] = f16vec4(7.0, 2.0, -1.0, 4.0);
	s1.a[0].mB[1] = f16vec4(1.0, -8.0, -1.0, 4.0);
	s1.a[0].mB[2] = f16vec4(-7.0, 3.0, 8.0, 1.0);
	s1.a[1].mA.mA = i16vec3(9, 5, -4);
	s1.a[1].mB[0] = f16vec4(1.0, -4.0, -4.0, -3.0);
	s1.a[1].mB[1] = f16vec4(1.0, 5.0, 6.0, 9.0);
	s1.a[1].mB[2] = f16vec4(0.0, 1.0, -3.0, 1.0);
	s1.a[2].mA.mA = i16vec3(6, 6, 6);
	s1.a[2].mB[0] = f16vec4(-8.0, 6.0, 6.0, 5.0);
	s1.a[2].mB[1] = f16vec4(1.0, 4.0, 6.0, -4.0);
	s1.a[2].mB[2] = f16vec4(0.0, 1.0, 2.0, -1.0);
	s1.b.mA.mA[0] = bvec3(false, true, false);
	s1.b.mA.mA[1] = bvec3(false, true, false);
	s1.b.mA.mB.mA = mat4(5.0, 2.0, 3.0, 1.0, -6.0, -5.0, 9.0, 1.0, 5.0, -7.0, 6.0, -1.0, -9.0, -5.0, 8.0, 5.0);
	s1.b.mA.mB.mB = u16vec4(7u, 4u, 2u, 6u);
	s1.b.mA.mC.mA = f16vec3(-7.0, 1.0, 4.0);
	s1.b.mA.mC.mB = int16_t(-2);
	s1.b.mA.mC.mC = vec2(0.0, -1.0);
	s2.a[0].mA = uint16_t(7u);
	s2.a[0].mB[0] = u16vec2(2u, 3u);
	s2.a[0].mB[1] = u16vec2(7u, 9u);
	s2.a[0].mB[2] = u16vec2(9u, 3u);
	s2.a[0].mC.mA = int16_t(8);
	s2.a[1].mA = uint16_t(4u);
	s2.a[1].mB[0] = u16vec2(7u, 4u);
	s2.a[1].mB[1] = u16vec2(5u, 7u);
	s2.a[1].mB[2] = u16vec2(9u, 9u);
	s2.a[1].mC.mA = int16_t(1);
	s2.a[2].mA = uint16_t(0u);
	s2.a[2].mB[0] = u16vec2(6u, 9u);
	s2.a[2].mB[1] = u16vec2(3u, 7u);
	s2.a[2].mB[2] = u16vec2(4u, 3u);
	s2.a[2].mC.mA = int16_t(6);
	s2.b[0].mA[0] = mat4x3(4.0, 4.0, -7.0, -3.0, 7.0, -3.0, 9.0, -7.0, -5.0, -7.0, 0.0, -2.0);
	s2.b[0].mA[1] = mat4x3(3.0, 2.0, -6.0, -2.0, 1.0, 6.0, -3.0, 1.0, -6.0, 5.0, -1.0, -2.0);
	s2.b[0].mA[2] = mat4x3(-6.0, -9.0, 1.0, 9.0, 4.0, 1.0, 6.0, 1.0, 6.0, -8.0, 5.0, -6.0);
	s2.b[0].mB.mA = i16vec3(2, -9, 3);
	s2.b[0].mB.mB = u16vec3(4u, 5u, 5u);
	s2.c.mA.mA[0] = i16vec4(-7, 1, -1, 6);
	s2.c.mA.mB.mA = u16vec4(3u, 4u, 6u, 4u);
	s2.c.mB.mA[0] = f16vec3(-3.0, -4.0, 4.0);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_i16vec3(ivec3(1, -6, -5), ivec3(s1.a[0].mA.mA)) && allOk;
	allOk = compare_f16vec4(vec4(7.0, 2.0, -1.0, 4.0), vec4(s1.a[0].mB[0])) && allOk;
	allOk = compare_f16vec4(vec4(1.0, -8.0, -1.0, 4.0), vec4(s1.a[0].mB[1])) && allOk;
	allOk = compare_f16vec4(vec4(-7.0, 3.0, 8.0, 1.0), vec4(s1.a[0].mB[2])) && allOk;
	allOk = compare_i16vec3(ivec3(9, 5, -4), ivec3(s1.a[1].mA.mA)) && allOk;
	allOk = compare_f16vec4(vec4(1.0, -4.0, -4.0, -3.0), vec4(s1.a[1].mB[0])) && allOk;
	allOk = compare_f16vec4(vec4(1.0, 5.0, 6.0, 9.0), vec4(s1.a[1].mB[1])) && allOk;
	allOk = compare_f16vec4(vec4(0.0, 1.0, -3.0, 1.0), vec4(s1.a[1].mB[2])) && allOk;
	allOk = compare_i16vec3(ivec3(6, 6, 6), ivec3(s1.a[2].mA.mA)) && allOk;
	allOk = compare_f16vec4(vec4(-8.0, 6.0, 6.0, 5.0), vec4(s1.a[2].mB[0])) && allOk;
	allOk = compare_f16vec4(vec4(1.0, 4.0, 6.0, -4.0), vec4(s1.a[2].mB[1])) && allOk;
	allOk = compare_f16vec4(vec4(0.0, 1.0, 2.0, -1.0), vec4(s1.a[2].mB[2])) && allOk;
	allOk = compare_bvec3(bvec3(false, true, false), s1.b.mA.mA[0]) && allOk;
	allOk = compare_bvec3(bvec3(false, true, false), s1.b.mA.mA[1]) && allOk;
	allOk = compare_mat4(mat4(5.0, 2.0, 3.0, 1.0, -6.0, -5.0, 9.0, 1.0, 5.0, -7.0, 6.0, -1.0, -9.0, -5.0, 8.0, 5.0), s1.b.mA.mB.mA) && allOk;
	allOk = compare_u16vec4(uvec4(7u, 4u, 2u, 6u), uvec4(s1.b.mA.mB.mB)) && allOk;
	allOk = compare_f16vec3(vec3(-7.0, 1.0, 4.0), vec3(s1.b.mA.mC.mA)) && allOk;
	allOk = compare_int16_t(int(-2), int(s1.b.mA.mC.mB)) && allOk;
	allOk = compare_vec2(vec2(0.0, -1.0), s1.b.mA.mC.mC) && allOk;
	allOk = compare_uint16_t(uint(7u), uint(s2.a[0].mA)) && allOk;
	allOk = compare_u16vec2(uvec2(2u, 3u), uvec2(s2.a[0].mB[0])) && allOk;
	allOk = compare_u16vec2(uvec2(7u, 9u), uvec2(s2.a[0].mB[1])) && allOk;
	allOk = compare_u16vec2(uvec2(9u, 3u), uvec2(s2.a[0].mB[2])) && allOk;
	allOk = compare_int16_t(int(8), int(s2.a[0].mC.mA)) && allOk;
	allOk = compare_uint16_t(uint(4u), uint(s2.a[1].mA)) && allOk;
	allOk = compare_u16vec2(uvec2(7u, 4u), uvec2(s2.a[1].mB[0])) && allOk;
	allOk = compare_u16vec2(uvec2(5u, 7u), uvec2(s2.a[1].mB[1])) && allOk;
	allOk = compare_u16vec2(uvec2(9u, 9u), uvec2(s2.a[1].mB[2])) && allOk;
	allOk = compare_int16_t(int(1), int(s2.a[1].mC.mA)) && allOk;
	allOk = compare_uint16_t(uint(0u), uint(s2.a[2].mA)) && allOk;
	allOk = compare_u16vec2(uvec2(6u, 9u), uvec2(s2.a[2].mB[0])) && allOk;
	allOk = compare_u16vec2(uvec2(3u, 7u), uvec2(s2.a[2].mB[1])) && allOk;
	allOk = compare_u16vec2(uvec2(4u, 3u), uvec2(s2.a[2].mB[2])) && allOk;
	allOk = compare_int16_t(int(6), int(s2.a[2].mC.mA)) && allOk;
	allOk = compare_mat4x3(mat4x3(4.0, 4.0, -7.0, -3.0, 7.0, -3.0, 9.0, -7.0, -5.0, -7.0, 0.0, -2.0), s2.b[0].mA[0]) && allOk;
	allOk = compare_mat4x3(mat4x3(3.0, 2.0, -6.0, -2.0, 1.0, 6.0, -3.0, 1.0, -6.0, 5.0, -1.0, -2.0), s2.b[0].mA[1]) && allOk;
	allOk = compare_mat4x3(mat4x3(-6.0, -9.0, 1.0, 9.0, 4.0, 1.0, 6.0, 1.0, 6.0, -8.0, 5.0, -6.0), s2.b[0].mA[2]) && allOk;
	allOk = compare_i16vec3(ivec3(2, -9, 3), ivec3(s2.b[0].mB.mA)) && allOk;
	allOk = compare_u16vec3(uvec3(4u, 5u, 5u), uvec3(s2.b[0].mB.mB)) && allOk;
	allOk = compare_i16vec4(ivec4(-7, 1, -1, 6), ivec4(s2.c.mA.mA[0])) && allOk;
	allOk = compare_u16vec4(uvec4(3u, 4u, 6u, 4u), uvec4(s2.c.mA.mB.mA)) && allOk;
	allOk = compare_f16vec3(vec3(-3.0, -4.0, 4.0), vec3(s2.c.mB.mA[0])) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	highp vec2 mA;
};
struct sB
{
	f16vec4 mA;
	u16vec3 mB;
	i16vec4 mC;
};
struct sC
{
	sA mA[1];
	sB mB[2];
};
struct sD
{
	lowp vec4 mA;
	float16_t mB[1][3];
};
struct sE
{
	highp mat2x3 mA;
};
struct sF
{
	highp ivec3 mA;
};
struct sG
{
	sE mA;
	sF mB;
	f16vec3 mC[3];
};
struct sH
{
	u16vec2 mA;
	int16_t mB;
};
struct sI
{
	sH mA;
};
struct sJ
{
	sG mA;
	sI mB;
};
struct sK
{
	f16vec4 mA;
	f16vec4 mB;
};
struct sL
{
	u16vec3 mA;
	bool mB;
};
struct sM
{
	sL mA;
};
struct sN
{
	f16vec3 mA;
	mediump uvec2 mB;
};
struct sO
{
	sN mA;
};
struct sP
{
	sO mA;
};
struct sQ
{
	u16vec3 mA[3];
};
struct sR
{
	sQ mA;
};
struct S1 {
	sC a;
	sD b;
	sJ c;
	sK d[3][2];
};
struct S2 {
	sM a[2];
	sP b;
	sR c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a.mA[0].mA = vec2(1.0, -3.0);
	s1.a.mB[0].mA = f16vec4(9.0, 7.0, -5.0, 2.0);
	s1.a.mB[0].mB = u16vec3(5u, 0u, 3u);
	s1.a.mB[0].mC = i16vec4(-6, 5, -7, 2);
	s1.a.mB[1].mA = f16vec4(8.0, 8.0, 6.0, -8.0);
	s1.a.mB[1].mB = u16vec3(2u, 1u, 5u);
	s1.a.mB[1].mC = i16vec4(2, 6, 1, 1);
	s1.b.mA = vec4(1.0, 6.0, -8.0, -9.0);
	s1.b.mB[0][0] = float16_t(0.0);
	s1.b.mB[0][1] = float16_t(-1.0);
	s1.b.mB[0][2] = float16_t(-1.0);
	s1.c.mA.mA.mA = mat2x3(5.0, 4.0, 0.0, -1.0, -2.0, -9.0);
	s1.c.mA.mB.mA = ivec3(1, 0, 8);
	s1.c.mA.mC[0] = f16vec3(0.0, 5.0, -7.0);
	s1.c.mA.mC[1] = f16vec3(6.0, 6.0, 7.0);
	s1.c.mA.mC[2] = f16vec3(-7.0, 6.0, -8.0);
	s1.c.mB.mA.mA = u16vec2(6u, 3u);
	s1.c.mB.mA.mB = int16_t(-4);
	s1.d[0][0].mA = f16vec4(0.0, 4.0, -4.0, 0.0);
	s1.d[0][0].mB = f16vec4(0.0, 8.0, -5.0, -1.0);
	s1.d[0][1].mA = f16vec4(-9.0, -9.0, -1.0, -4.0);
	s1.d[0][1].mB = f16vec4(5.0, 1.0, -9.0, 8.0);
	s1.d[1][0].mA = f16vec4(9.0, -6.0, -3.0, -4.0);
	s1.d[1][0].mB = f16vec4(9.0, 9.0, 1.0, 5.0);
	s1.d[1][1].mA = f16vec4(9.0, 5.0, -7.0, -3.0);
	s1.d[1][1].mB = f16vec4(-9.0, 5.0, 4.0, 2.0);
	s1.d[2][0].mA = f16vec4(3.0, 3.0, 2.0, -8.0);
	s1.d[2][0].mB = f16vec4(1.0, 7.0, 3.0, 2.0);
	s1.d[2][1].mA = f16vec4(2.0, 3.0, -8.0, -6.0);
	s1.d[2][1].mB = f16vec4(3.0, -4.0, -6.0, 3.0);
	s2.a[0].mA.mA = u16vec3(8u, 2u, 6u);
	s2.a[0].mA.mB = false;
	s2.a[1].mA.mA = u16vec3(9u, 1u, 2u);
	s2.a[1].mA.mB = false;
	s2.b.mA.mA.mA = f16vec3(-8.0, 8.0, -2.0);
	s2.b.mA.mA.mB = uvec2(4u, 5u);
	s2.c.mA.mA[0] = u16vec3(1u, 4u, 7u);
	s2.c.mA.mA[1] = u16vec3(1u, 3u, 0u);
	s2.c.mA.mA[2] = u16vec3(7u, 6u, 7u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_vec2(vec2(1.0, -3.0), s1.a.mA[0].mA) && allOk;
	allOk = compare_f16vec4(vec4(9.0, 7.0, -5.0, 2.0), vec4(s1.a.mB[0].mA)) && allOk;
	allOk = compare_u16vec3(uvec3(5u, 0u, 3u), uvec3(s1.a.mB[0].mB)) && allOk;
	allOk = compare_i16vec4(ivec4(-6, 5, -7, 2), ivec4(s1.a.mB[0].mC)) && allOk;
	allOk = compare_f16vec4(vec4(8.0, 8.0, 6.0, -8.0), vec4(s1.a.mB[1].mA)) && allOk;
	allOk = compare_u16vec3(uvec3(2u, 1u, 5u), uvec3(s1.a.mB[1].mB)) && allOk;
	allOk = compare_i16vec4(ivec4(2, 6, 1, 1), ivec4(s1.a.mB[1].mC)) && allOk;
	allOk = compare_vec4(vec4(1.0, 6.0, -8.0, -9.0), s1.b.mA) && allOk;
	allOk = compare_float16_t(float(0.0), float(s1.b.mB[0][0])) && allOk;
	allOk = compare_float16_t(float(-1.0), float(s1.b.mB[0][1])) && allOk;
	allOk = compare_float16_t(float(-1.0), float(s1.b.mB[0][2])) && allOk;
	allOk = compare_mat2x3(mat2x3(5.0, 4.0, 0.0, -1.0, -2.0, -9.0), s1.c.mA.mA.mA) && allOk;
	allOk = compare_ivec3(ivec3(1, 0, 8), s1.c.mA.mB.mA) && allOk;
	allOk = compare_f16vec3(vec3(0.0, 5.0, -7.0), vec3(s1.c.mA.mC[0])) && allOk;
	allOk = compare_f16vec3(vec3(6.0, 6.0, 7.0), vec3(s1.c.mA.mC[1])) && allOk;
	allOk = compare_f16vec3(vec3(-7.0, 6.0, -8.0), vec3(s1.c.mA.mC[2])) && allOk;
	allOk = compare_u16vec2(uvec2(6u, 3u), uvec2(s1.c.mB.mA.mA)) && allOk;
	allOk = compare_int16_t(int(-4), int(s1.c.mB.mA.mB)) && allOk;
	allOk = compare_f16vec4(vec4(0.0, 4.0, -4.0, 0.0), vec4(s1.d[0][0].mA)) && allOk;
	allOk = compare_f16vec4(vec4(0.0, 8.0, -5.0, -1.0), vec4(s1.d[0][0].mB)) && allOk;
	allOk = compare_f16vec4(vec4(-9.0, -9.0, -1.0, -4.0), vec4(s1.d[0][1].mA)) && allOk;
	allOk = compare_f16vec4(vec4(5.0, 1.0, -9.0, 8.0), vec4(s1.d[0][1].mB)) && allOk;
	allOk = compare_f16vec4(vec4(9.0, -6.0, -3.0, -4.0), vec4(s1.d[1][0].mA)) && allOk;
	allOk = compare_f16vec4(vec4(9.0, 9.0, 1.0, 5.0), vec4(s1.d[1][0].mB)) && allOk;
	allOk = compare_f16vec4(vec4(9.0, 5.0, -7.0, -3.0), vec4(s1.d[1][1].mA)) && allOk;
	allOk = compare_f16vec4(vec4(-9.0, 5.0, 4.0, 2.0), vec4(s1.d[1][1].mB)) && allOk;
	allOk = compare_f16vec4(vec4(3.0, 3.0, 2.0, -8.0), vec4(s1.d[2][0].mA)) && allOk;
	allOk = compare_f16vec4(vec4(1.0, 7.0, 3.0, 2.0), vec4(s1.d[2][0].mB)) && allOk;
	allOk = compare_f16vec4(vec4(2.0, 3.0, -8.0, -6.0), vec4(s1.d[2][1].mA)) && allOk;
	allOk = compare_f16vec4(vec4(3.0, -4.0, -6.0, 3.0), vec4(s1.d[2][1].mB)) && allOk;
	allOk = compare_u16vec3(uvec3(8u, 2u, 6u), uvec3(s2.a[0].mA.mA)) && allOk;
	allOk = compare_bool(false, s2.a[0].mA.mB) && allOk;
	allOk = compare_u16vec3(uvec3(9u, 1u, 2u), uvec3(s2.a[1].mA.mA)) && allOk;
	allOk = compare_bool(false, s2.a[1].mA.mB) && allOk;
	allOk = compare_f16vec3(vec3(-8.0, 8.0, -2.0), vec3(s2.b.mA.mA.mA)) && allOk;
	allOk = compare_uvec2(uvec2(4u, 5u), s2.b.mA.mA.mB) && allOk;
	allOk = compare_u16vec3(uvec3(1u, 4u, 7u), uvec3(s2.c.mA.mA[0])) && allOk;
	allOk = compare_u16vec3(uvec3(1u, 3u, 0u), uvec3(s2.c.mA.mA[1])) && allOk;
	allOk = compare_u16vec3(uvec3(7u, 6u, 7u), uvec3(s2.c.mA.mA[2])) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	uint8_t a;
	uint8_t b;
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

shared S1 s1;

void main (void) {
	s1.a = uint8_t(0u);
	s1.b = uint8_t(2u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_uint8_t(uint(0u), uint(s1.a)) && allOk;
	allOk = compare_uint8_t(uint(2u), uint(s1.b)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	bool a;
	int8_t b;
};

bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

shared S1 s1;

void main (void) {
	s1.a = true;
	s1.b = int8_t(6);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_bool(true, s1.a) && allOk;
	allOk = compare_int8_t(int(6), int(s1.b)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	uint8_t a;
	uint8_t b;
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

shared S1 s1;

void main (void) {
	s1.a = uint8_t(8u);
	s1.b = uint8_t(0u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_uint8_t(uint(8u), uint(s1.a)) && allOk;
	allOk = compare_uint8_t(uint(0u), uint(s1.b)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	uint8_t a;
	int8_t b;
	uint8_t c;
};
struct S2 {
	uint8_t a;
	uint8_t b;
	highp uint c;
};
struct S3 {
	uint8_t a;
	int8_t b;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

shared S1 s1;
shared S2 s2;
shared S3 s3;

void main (void) {
	s1.a = uint8_t(1u);
	s1.b = int8_t(-5);
	s1.c = uint8_t(8u);
	s2.a = uint8_t(5u);
	s2.b = uint8_t(3u);
	s2.c = 6u;
	s3.a = uint8_t(8u);
	s3.b = int8_t(2);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_uint8_t(uint(1u), uint(s1.a)) && allOk;
	allOk = compare_int8_t(int(-5), int(s1.b)) && allOk;
	allOk = compare_uint8_t(uint(8u), uint(s1.c)) && allOk;
	allOk = compare_uint8_t(uint(5u), uint(s2.a)) && allOk;
	allOk = compare_uint8_t(uint(3u), uint(s2.b)) && allOk;
	allOk = compare_uint(6u, s2.c) && allOk;
	allOk = compare_uint8_t(uint(8u), uint(s3.a)) && allOk;
	allOk = compare_int8_t(int(2), int(s3.b)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	int8_t a;
	int8_t b;
	uint8_t c;
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

shared S1 s1;

void main (void) {
	s1.a = int8_t(2);
	s1.b = int8_t(7);
	s1.c = uint8_t(5u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_int8_t(int(2), int(s1.a)) && allOk;
	allOk = compare_int8_t(int(7), int(s1.b)) && allOk;
	allOk = compare_uint8_t(uint(5u), uint(s1.c)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	int8_t a;
	int8_t b;
	mediump int c;
};
struct S2 {
	uint8_t a;
	uint8_t b;
};
struct S3 {
	lowp uint a;
	int8_t b;
	highp float c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

shared S1 s1;
shared S2 s2;
shared S3 s3;

void main (void) {
	s1.a = int8_t(2);
	s1.b = int8_t(-3);
	s1.c = 2;
	s2.a = uint8_t(9u);
	s2.b = uint8_t(1u);
	s3.a = 4u;
	s3.b = int8_t(-2);
	s3.c = -5.0;

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_int8_t(int(2), int(s1.a)) && allOk;
	allOk = compare_int8_t(int(-3), int(s1.b)) && allOk;
	allOk = compare_int(2, s1.c) && allOk;
	allOk = compare_uint8_t(uint(9u), uint(s2.a)) && allOk;
	allOk = compare_uint8_t(uint(1u), uint(s2.b)) && allOk;
	allOk = compare_uint(4u, s3.a) && allOk;
	allOk = compare_int8_t(int(-2), int(s3.b)) && allOk;
	allOk = compare_float(-5.0, s3.c) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	int8_t a;
	uint8_t b;
	uint8_t c;
};
struct S2 {
	int8_t a;
	int8_t b;
};
struct S3 {
	uint8_t a;
	uint8_t b;
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

shared S1 s1;
shared S2 s2;
shared S3 s3;

void main (void) {
	s1.a = int8_t(-4);
	s1.b = uint8_t(3u);
	s1.c = uint8_t(7u);
	s2.a = int8_t(-7);
	s2.b = int8_t(-9);
	s3.a = uint8_t(2u);
	s3.b = uint8_t(4u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_int8_t(int(-4), int(s1.a)) && allOk;
	allOk = compare_uint8_t(uint(3u), uint(s1.b)) && allOk;
	allOk = compare_uint8_t(uint(7u), uint(s1.c)) && allOk;
	allOk = compare_int8_t(int(-7), int(s2.a)) && allOk;
	allOk = compare_int8_t(int(-9), int(s2.b)) && allOk;
	allOk = compare_uint8_t(uint(2u), uint(s3.a)) && allOk;
	allOk = compare_uint8_t(uint(4u), uint(s3.b)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	mediump float a;
	uint8_t b;
	int8_t c;
	mediump uint d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

shared S1 s1;

void main (void) {
	s1.a = -5.0;
	s1.b = uint8_t(7u);
	s1.c = int8_t(-6);
	s1.d = 1u;

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_float(-5.0, s1.a) && allOk;
	allOk = compare_uint8_t(uint(7u), uint(s1.b)) && allOk;
	allOk = compare_int8_t(int(-6), int(s1.c)) && allOk;
	allOk = compare_uint(1u, s1.d) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	int8_t a;
	uint8_t b;
	mediump float c;
	int8_t d;
};
struct S2 {
	uint8_t a;
	uint8_t b;
	highp float c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a = int8_t(1);
	s1.b = uint8_t(5u);
	s1.c = -5.0;
	s1.d = int8_t(7);
	s2.a = uint8_t(5u);
	s2.b = uint8_t(7u);
	s2.c = 4.0;

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_int8_t(int(1), int(s1.a)) && allOk;
	allOk = compare_uint8_t(uint(5u), uint(s1.b)) && allOk;
	allOk = compare_float(-5.0, s1.c) && allOk;
	allOk = compare_int8_t(int(7), int(s1.d)) && allOk;
	allOk = compare_uint8_t(uint(5u), uint(s2.a)) && allOk;
	allOk = compare_uint8_t(uint(7u), uint(s2.b)) && allOk;
	allOk = compare_float(4.0, s2.c) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	uint8_t a;
	int8_t b;
	highp float c;
	uint8_t d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

shared S1 s1;

void main (void) {
	s1.a = uint8_t(5u);
	s1.b = int8_t(-3);
	s1.c = 9.0;
	s1.d = uint8_t(7u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_uint8_t(uint(5u), uint(s1.a)) && allOk;
	allOk = compare_int8_t(int(-3), int(s1.b)) && allOk;
	allOk = compare_float(9.0, s1.c) && allOk;
	allOk = compare_uint8_t(uint(7u), uint(s1.d)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	u8vec3 a;
	i8vec3 b;
	mediump uvec4 c;
	bvec3 d;
};

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

shared S1 s1;

void main (void) {
	s1.a = u8vec3(0u, 2u, 0u);
	s1.b = i8vec3(0, -4, -5);
	s1.c = uvec4(9u, 3u, 5u, 6u);
	s1.d = bvec3(false, true, true);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_u8vec3(uvec3(0u, 2u, 0u), uvec3(s1.a)) && allOk;
	allOk = compare_i8vec3(ivec3(0, -4, -5), ivec3(s1.b)) && allOk;
	allOk = compare_uvec4(uvec4(9u, 3u, 5u, 6u), s1.c) && allOk;
	allOk = compare_bvec3(bvec3(false, true, true), s1.d) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	mediump uvec4 a;
	u8vec4 b;
};
struct S2 {
	int8_t a;
	int8_t b;
	mediump vec2 c;
};
struct S3 {
	bvec3 a;
	u8vec4 b;
	bvec2 c;
	uint8_t d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

shared S1 s1;
shared S2 s2;
shared S3 s3;

void main (void) {
	s1.a = uvec4(3u, 0u, 3u, 0u);
	s1.b = u8vec4(4u, 5u, 4u, 3u);
	s2.a = int8_t(-9);
	s2.b = int8_t(8);
	s2.c = vec2(-4.0, -8.0);
	s3.a = bvec3(false, true, false);
	s3.b = u8vec4(9u, 4u, 9u, 6u);
	s3.c = bvec2(false, true);
	s3.d = uint8_t(6u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_uvec4(uvec4(3u, 0u, 3u, 0u), s1.a) && allOk;
	allOk = compare_u8vec4(uvec4(4u, 5u, 4u, 3u), uvec4(s1.b)) && allOk;
	allOk = compare_int8_t(int(-9), int(s2.a)) && allOk;
	allOk = compare_int8_t(int(8), int(s2.b)) && allOk;
	allOk = compare_vec2(vec2(-4.0, -8.0), s2.c) && allOk;
	allOk = compare_bvec3(bvec3(false, true, false), s3.a) && allOk;
	allOk = compare_u8vec4(uvec4(9u, 4u, 9u, 6u), uvec4(s3.b)) && allOk;
	allOk = compare_bvec2(bvec2(false, true), s3.c) && allOk;
	allOk = compare_uint8_t(uint(6u), uint(s3.d)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	i8vec3 a;
	bool b;
	u8vec4 c;
};
struct S2 {
	u8vec3 a;
	int8_t b;
};

bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a = i8vec3(0, 2, -8);
	s1.b = false;
	s1.c = u8vec4(2u, 5u, 5u, 2u);
	s2.a = u8vec3(5u, 1u, 5u);
	s2.b = int8_t(4);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_i8vec3(ivec3(0, 2, -8), ivec3(s1.a)) && allOk;
	allOk = compare_bool(false, s1.b) && allOk;
	allOk = compare_u8vec4(uvec4(2u, 5u, 5u, 2u), uvec4(s1.c)) && allOk;
	allOk = compare_u8vec3(uvec3(5u, 1u, 5u), uvec3(s2.a)) && allOk;
	allOk = compare_int8_t(int(4), int(s2.b)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	i8vec4 a;
	i8vec2 b;
	i8vec2 c;
	lowp ivec3 d;
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

shared S1 s1;

void main (void) {
	s1.a = i8vec4(1, -5, -9, -5);
	s1.b = i8vec2(1, -7);
	s1.c = i8vec2(1, 2);
	s1.d = ivec3(8, 7, 9);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_i8vec4(ivec4(1, -5, -9, -5), ivec4(s1.a)) && allOk;
	allOk = compare_i8vec2(ivec2(1, -7), ivec2(s1.b)) && allOk;
	allOk = compare_i8vec2(ivec2(1, 2), ivec2(s1.c)) && allOk;
	allOk = compare_ivec3(ivec3(8, 7, 9), s1.d) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	u8vec2 a;
	i8vec4 b;
	int8_t c;
	mediump float d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

shared S1 s1;

void main (void) {
	s1.a = u8vec2(4u, 3u);
	s1.b = i8vec4(-9, 3, 0, -7);
	s1.c = int8_t(7);
	s1.d = -2.0;

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_u8vec2(uvec2(4u, 3u), uvec2(s1.a)) && allOk;
	allOk = compare_i8vec4(ivec4(-9, 3, 0, -7), ivec4(s1.b)) && allOk;
	allOk = compare_int8_t(int(7), int(s1.c)) && allOk;
	allOk = compare_float(-2.0, s1.d) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	u8vec4 a;
	u8vec3 b;
	lowp ivec3 c;
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

shared S1 s1;

void main (void) {
	s1.a = u8vec4(7u, 1u, 2u, 9u);
	s1.b = u8vec3(1u, 4u, 3u);
	s1.c = ivec3(-5, -3, -3);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_u8vec4(uvec4(7u, 1u, 2u, 9u), uvec4(s1.a)) && allOk;
	allOk = compare_u8vec3(uvec3(1u, 4u, 3u), uvec3(s1.b)) && allOk;
	allOk = compare_ivec3(ivec3(-5, -3, -3), s1.c) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	uint8_t a;
	i8vec3 b;
	lowp ivec4 c;
	i8vec3 d;
};
struct S2 {
	i8vec3 a;
	int8_t b;
	i8vec3 c;
	lowp uint d;
};
struct S3 {
	u8vec4 a;
	u8vec3 b;
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

shared S1 s1;
shared S2 s2;
shared S3 s3;

void main (void) {
	s1.a = uint8_t(2u);
	s1.b = i8vec3(6, 6, -7);
	s1.c = ivec4(-9, 5, -4, -9);
	s1.d = i8vec3(8, 6, -2);
	s2.a = i8vec3(-6, 4, -6);
	s2.b = int8_t(-3);
	s2.c = i8vec3(2, -9, -7);
	s2.d = 1u;
	s3.a = u8vec4(4u, 1u, 1u, 7u);
	s3.b = u8vec3(9u, 6u, 0u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_uint8_t(uint(2u), uint(s1.a)) && allOk;
	allOk = compare_i8vec3(ivec3(6, 6, -7), ivec3(s1.b)) && allOk;
	allOk = compare_ivec4(ivec4(-9, 5, -4, -9), s1.c) && allOk;
	allOk = compare_i8vec3(ivec3(8, 6, -2), ivec3(s1.d)) && allOk;
	allOk = compare_i8vec3(ivec3(-6, 4, -6), ivec3(s2.a)) && allOk;
	allOk = compare_int8_t(int(-3), int(s2.b)) && allOk;
	allOk = compare_i8vec3(ivec3(2, -9, -7), ivec3(s2.c)) && allOk;
	allOk = compare_uint(1u, s2.d) && allOk;
	allOk = compare_u8vec4(uvec4(4u, 1u, 1u, 7u), uvec4(s3.a)) && allOk;
	allOk = compare_u8vec3(uvec3(9u, 6u, 0u), uvec3(s3.b)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	u8vec3 a;
	i8vec2 b;
	i8vec3 c;
	i8vec3 d;
};

bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

shared S1 s1;

void main (void) {
	s1.a = u8vec3(5u, 7u, 3u);
	s1.b = i8vec2(-9, 9);
	s1.c = i8vec3(-5, 7, 7);
	s1.d = i8vec3(0, 5, -7);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_u8vec3(uvec3(5u, 7u, 3u), uvec3(s1.a)) && allOk;
	allOk = compare_i8vec2(ivec2(-9, 9), ivec2(s1.b)) && allOk;
	allOk = compare_i8vec3(ivec3(-5, 7, 7), ivec3(s1.c)) && allOk;
	allOk = compare_i8vec3(ivec3(0, 5, -7), ivec3(s1.d)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	uint8_t a;
	u8vec4 b;
	bvec2 c;
	u8vec4 d;
};
struct S2 {
	bvec4 a;
	u8vec2 b;
	i8vec3 c;
};

bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a = uint8_t(2u);
	s1.b = u8vec4(5u, 1u, 9u, 5u);
	s1.c = bvec2(true, true);
	s1.d = u8vec4(2u, 0u, 4u, 5u);
	s2.a = bvec4(true, false, false, false);
	s2.b = u8vec2(2u, 8u);
	s2.c = i8vec3(-4, 1, -4);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_uint8_t(uint(2u), uint(s1.a)) && allOk;
	allOk = compare_u8vec4(uvec4(5u, 1u, 9u, 5u), uvec4(s1.b)) && allOk;
	allOk = compare_bvec2(bvec2(true, true), s1.c) && allOk;
	allOk = compare_u8vec4(uvec4(2u, 0u, 4u, 5u), uvec4(s1.d)) && allOk;
	allOk = compare_bvec4(bvec4(true, false, false, false), s2.a) && allOk;
	allOk = compare_u8vec2(uvec2(2u, 8u), uvec2(s2.b)) && allOk;
	allOk = compare_i8vec3(ivec3(-4, 1, -4), ivec3(s2.c)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	int8_t a;
	u8vec2 b;
	i8vec3 c;
	bvec3 d;
};
struct S2 {
	highp ivec4 a;
	uint8_t b;
	u8vec2 c;
	int8_t d;
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a = int8_t(1);
	s1.b = u8vec2(7u, 4u);
	s1.c = i8vec3(7, -5, 2);
	s1.d = bvec3(true, true, true);
	s2.a = ivec4(-6, 5, -7, 2);
	s2.b = uint8_t(7u);
	s2.c = u8vec2(1u, 2u);
	s2.d = int8_t(-8);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_int8_t(int(1), int(s1.a)) && allOk;
	allOk = compare_u8vec2(uvec2(7u, 4u), uvec2(s1.b)) && allOk;
	allOk = compare_i8vec3(ivec3(7, -5, 2), ivec3(s1.c)) && allOk;
	allOk = compare_bvec3(bvec3(true, true, true), s1.d) && allOk;
	allOk = compare_ivec4(ivec4(-6, 5, -7, 2), s2.a) && allOk;
	allOk = compare_uint8_t(uint(7u), uint(s2.b)) && allOk;
	allOk = compare_u8vec2(uvec2(1u, 2u), uvec2(s2.c)) && allOk;
	allOk = compare_int8_t(int(-8), int(s2.d)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	highp uvec3 a;
	mediump int b;
	u8vec2 c;
	mediump ivec4 d;
};
struct S2 {
	lowp int a;
	highp mat4x3 b;
};
struct S3 {
	u8vec4 a;
	highp ivec4 b;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

shared S1 s1;
shared S2 s2;
shared S3 s3;

void main (void) {
	s1.a = uvec3(0u, 2u, 0u);
	s1.b = 0;
	s1.c = u8vec2(4u, 0u);
	s1.d = ivec4(9, -4, -6, -1);
	s2.a = -1;
	s2.b = mat4x3(-2.0, 1.0, 6.0, 5.0, 7.0, -2.0, -4.0, -9.0, 8.0, 3.0, 0.0, 2.0);
	s3.a = u8vec4(2u, 4u, 8u, 0u);
	s3.b = ivec4(-1, -1, -7, 7);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_uvec3(uvec3(0u, 2u, 0u), s1.a) && allOk;
	allOk = compare_int(0, s1.b) && allOk;
	allOk = compare_u8vec2(uvec2(4u, 0u), uvec2(s1.c)) && allOk;
	allOk = compare_ivec4(ivec4(9, -4, -6, -1), s1.d) && allOk;
	allOk = compare_int(-1, s2.a) && allOk;
	allOk = compare_mat4x3(mat4x3(-2.0, 1.0, 6.0, 5.0, 7.0, -2.0, -4.0, -9.0, 8.0, 3.0, 0.0, 2.0), s2.b) && allOk;
	allOk = compare_u8vec4(uvec4(2u, 4u, 8u, 0u), uvec4(s3.a)) && allOk;
	allOk = compare_ivec4(ivec4(-1, -1, -7, 7), s3.b) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	u8vec2 a;
	uint8_t b;
};
struct S2 {
	highp vec2 a;
	i8vec3 b;
};
struct S3 {
	mediump mat2 a;
	uint8_t b;
	bvec2 c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

shared S1 s1;
shared S2 s2;
shared S3 s3;

void main (void) {
	s1.a = u8vec2(3u, 0u);
	s1.b = uint8_t(3u);
	s2.a = vec2(-3.0, -1.0);
	s2.b = i8vec3(-9, 5, -7);
	s3.a = mat2(-9.0, 8.0, -4.0, -8.0);
	s3.b = uint8_t(4u);
	s3.c = bvec2(true, false);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_u8vec2(uvec2(3u, 0u), uvec2(s1.a)) && allOk;
	allOk = compare_uint8_t(uint(3u), uint(s1.b)) && allOk;
	allOk = compare_vec2(vec2(-3.0, -1.0), s2.a) && allOk;
	allOk = compare_i8vec3(ivec3(-9, 5, -7), ivec3(s2.b)) && allOk;
	allOk = compare_mat2(mat2(-9.0, 8.0, -4.0, -8.0), s3.a) && allOk;
	allOk = compare_uint8_t(uint(4u), uint(s3.b)) && allOk;
	allOk = compare_bvec2(bvec2(true, false), s3.c) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	mediump uvec3 a;
	i8vec2 b;
	highp ivec4 c;
	i8vec3 d;
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

shared S1 s1;

void main (void) {
	s1.a = uvec3(8u, 0u, 0u);
	s1.b = i8vec2(6, 7);
	s1.c = ivec4(5, -6, 1, 9);
	s1.d = i8vec3(-4, -3, 4);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_uvec3(uvec3(8u, 0u, 0u), s1.a) && allOk;
	allOk = compare_i8vec2(ivec2(6, 7), ivec2(s1.b)) && allOk;
	allOk = compare_ivec4(ivec4(5, -6, 1, 9), s1.c) && allOk;
	allOk = compare_i8vec3(ivec3(-4, -3, 4), ivec3(s1.d)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	u8vec3 a;
	highp mat4x3 b;
	int8_t c;
};
struct S2 {
	u8vec2 a;
	u8vec3 b;
	int8_t c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a = u8vec3(1u, 9u, 8u);
	s1.b = mat4x3(-5.0, 1.0, -7.0, 1.0, 2.0, 8.0, 7.0, 9.0, -8.0, 2.0, 9.0, 6.0);
	s1.c = int8_t(-5);
	s2.a = u8vec2(4u, 1u);
	s2.b = u8vec3(2u, 0u, 8u);
	s2.c = int8_t(-2);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_u8vec3(uvec3(1u, 9u, 8u), uvec3(s1.a)) && allOk;
	allOk = compare_mat4x3(mat4x3(-5.0, 1.0, -7.0, 1.0, 2.0, 8.0, 7.0, 9.0, -8.0, 2.0, 9.0, 6.0), s1.b) && allOk;
	allOk = compare_int8_t(int(-5), int(s1.c)) && allOk;
	allOk = compare_u8vec2(uvec2(4u, 1u), uvec2(s2.a)) && allOk;
	allOk = compare_u8vec3(uvec3(2u, 0u, 8u), uvec3(s2.b)) && allOk;
	allOk = compare_int8_t(int(-2), int(s2.c)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	u8vec3 a;
	highp float b;
};
struct S2 {
	u8vec3 a;
	u8vec2 b;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a = u8vec3(4u, 3u, 5u);
	s1.b = 3.0;
	s2.a = u8vec3(3u, 9u, 6u);
	s2.b = u8vec2(5u, 8u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_u8vec3(uvec3(4u, 3u, 5u), uvec3(s1.a)) && allOk;
	allOk = compare_float(3.0, s1.b) && allOk;
	allOk = compare_u8vec3(uvec3(3u, 9u, 6u), uvec3(s2.a)) && allOk;
	allOk = compare_u8vec2(uvec2(5u, 8u), uvec2(s2.b)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	i8vec2 a;
	u8vec4 b;
	i8vec3 c;
	u8vec4 d;
};

bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

shared S1 s1;

void main (void) {
	s1.a = i8vec2(2, -3);
	s1.b = u8vec4(2u, 9u, 1u, 4u);
	s1.c = i8vec3(-2, -5, -3);
	s1.d = u8vec4(5u, 9u, 6u, 8u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_i8vec2(ivec2(2, -3), ivec2(s1.a)) && allOk;
	allOk = compare_u8vec4(uvec4(2u, 9u, 1u, 4u), uvec4(s1.b)) && allOk;
	allOk = compare_i8vec3(ivec3(-2, -5, -3), ivec3(s1.c)) && allOk;
	allOk = compare_u8vec4(uvec4(5u, 9u, 6u, 8u), uvec4(s1.d)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	bvec2 a;
	bvec2 b;
	i8vec4 c;
	lowp ivec4 d;
};
struct S2 {
	highp mat4 a;
	i8vec4 b;
	lowp mat3x2 c;
	u8vec2 d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a = bvec2(true, false);
	s1.b = bvec2(false, false);
	s1.c = i8vec4(-9, 5, -4, -9);
	s1.d = ivec4(8, 6, -2, -6);
	s2.a = mat4(4.0, -6.0, -3.0, 2.0, -9.0, -7.0, -5.0, -7.0, 3.0, 5.0, 2.0, -9.0, 0.0, -5.0, 0.0, 1.0);
	s2.b = i8vec4(-8, 0, 3, -5);
	s2.c = mat3x2(5.0, -7.0, 1.0, -8.0, 2.0, 0.0);
	s2.d = u8vec2(0u, 3u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_bvec2(bvec2(true, false), s1.a) && allOk;
	allOk = compare_bvec2(bvec2(false, false), s1.b) && allOk;
	allOk = compare_i8vec4(ivec4(-9, 5, -4, -9), ivec4(s1.c)) && allOk;
	allOk = compare_ivec4(ivec4(8, 6, -2, -6), s1.d) && allOk;
	allOk = compare_mat4(mat4(4.0, -6.0, -3.0, 2.0, -9.0, -7.0, -5.0, -7.0, 3.0, 5.0, 2.0, -9.0, 0.0, -5.0, 0.0, 1.0), s2.a) && allOk;
	allOk = compare_i8vec4(ivec4(-8, 0, 3, -5), ivec4(s2.b)) && allOk;
	allOk = compare_mat3x2(mat3x2(5.0, -7.0, 1.0, -8.0, 2.0, 0.0), s2.c) && allOk;
	allOk = compare_u8vec2(uvec2(0u, 3u), uvec2(s2.d)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	u8vec4 a;
	highp ivec4 b;
	lowp mat2 c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

shared S1 s1;

void main (void) {
	s1.a = u8vec4(5u, 7u, 3u, 1u);
	s1.b = ivec4(9, -5, 7, 7);
	s1.c = mat2(0.0, 5.0, -7.0, -5.0);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_u8vec4(uvec4(5u, 7u, 3u, 1u), uvec4(s1.a)) && allOk;
	allOk = compare_ivec4(ivec4(9, -5, 7, 7), s1.b) && allOk;
	allOk = compare_mat2(mat2(0.0, 5.0, -7.0, -5.0), s1.c) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	uint8_t a;
	highp uvec3 b;
	u8vec4 c;
	int8_t d;
};

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

shared S1 s1;

void main (void) {
	s1.a = uint8_t(2u);
	s1.b = uvec3(5u, 1u, 9u);
	s1.c = u8vec4(5u, 7u, 9u, 2u);
	s1.d = int8_t(-8);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_uint8_t(uint(2u), uint(s1.a)) && allOk;
	allOk = compare_uvec3(uvec3(5u, 1u, 9u), s1.b) && allOk;
	allOk = compare_u8vec4(uvec4(5u, 7u, 9u, 2u), uvec4(s1.c)) && allOk;
	allOk = compare_int8_t(int(-8), int(s1.d)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	i8vec2 a;
	highp mat4x2 b;
	uint8_t c;
};
struct S2 {
	u8vec3 a;
	u8vec4 b;
	int8_t c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a = i8vec2(1, -3);
	s1.b = mat4x2(9.0, 7.0, -5.0, 2.0, -1.0, -8.0, 2.0, -6.0);
	s1.c = uint8_t(7u);
	s2.a = u8vec3(6u, 1u, 7u);
	s2.b = u8vec4(1u, 2u, 9u, 2u);
	s2.c = int8_t(-1);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_i8vec2(ivec2(1, -3), ivec2(s1.a)) && allOk;
	allOk = compare_mat4x2(mat4x2(9.0, 7.0, -5.0, 2.0, -1.0, -8.0, 2.0, -6.0), s1.b) && allOk;
	allOk = compare_uint8_t(uint(7u), uint(s1.c)) && allOk;
	allOk = compare_u8vec3(uvec3(6u, 1u, 7u), uvec3(s2.a)) && allOk;
	allOk = compare_u8vec4(uvec4(1u, 2u, 9u, 2u), uvec4(s2.b)) && allOk;
	allOk = compare_int8_t(int(-1), int(s2.c)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	mediump vec2 a[3];
	uint8_t b[2];
	highp vec3 c[1];
	i8vec3 d[3];
};
struct S2 {
	lowp int a[3];
	mediump mat4x3 b;
	highp mat3 c[3];
	i8vec4 d[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a[0] = vec2(6.0, 8.0);
	s1.a[1] = vec2(8.0, 0.0);
	s1.a[2] = vec2(-4.0, -5.0);
	s1.b[0] = uint8_t(9u);
	s1.b[1] = uint8_t(3u);
	s1.c[0] = vec3(-6.0, -1.0, -1.0);
	s1.d[0] = i8vec3(-2, 1, 6);
	s1.d[1] = i8vec3(5, 7, -2);
	s1.d[2] = i8vec3(-4, -9, 8);
	s2.a[0] = 3;
	s2.a[1] = 0;
	s2.a[2] = 2;
	s2.b = mat4x3(1.0, 8.0, 0.0, 9.0, -1.0, -1.0, -7.0, 7.0, -4.0, -3.0, 1.0, -4.0);
	s2.c[0] = mat3(-9.0, 1.0, -4.0, 0.0, 2.0, 0.0, 6.0, 2.0, 3.0);
	s2.c[1] = mat3(-5.0, -1.0, -5.0, -1.0, -9.0, -6.0, -9.0, -8.0, 6.0);
	s2.c[2] = mat3(-2.0, 3.0, 7.0, 2.0, -7.0, -2.0, -5.0, 4.0, 8.0);
	s2.d[0] = i8vec4(-9, -8, -2, -8);
	s2.d[1] = i8vec4(-2, -9, 0, -8);
	s2.d[2] = i8vec4(-3, 8, -7, 9);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_vec2(vec2(6.0, 8.0), s1.a[0]) && allOk;
	allOk = compare_vec2(vec2(8.0, 0.0), s1.a[1]) && allOk;
	allOk = compare_vec2(vec2(-4.0, -5.0), s1.a[2]) && allOk;
	allOk = compare_uint8_t(uint(9u), uint(s1.b[0])) && allOk;
	allOk = compare_uint8_t(uint(3u), uint(s1.b[1])) && allOk;
	allOk = compare_vec3(vec3(-6.0, -1.0, -1.0), s1.c[0]) && allOk;
	allOk = compare_i8vec3(ivec3(-2, 1, 6), ivec3(s1.d[0])) && allOk;
	allOk = compare_i8vec3(ivec3(5, 7, -2), ivec3(s1.d[1])) && allOk;
	allOk = compare_i8vec3(ivec3(-4, -9, 8), ivec3(s1.d[2])) && allOk;
	allOk = compare_int(3, s2.a[0]) && allOk;
	allOk = compare_int(0, s2.a[1]) && allOk;
	allOk = compare_int(2, s2.a[2]) && allOk;
	allOk = compare_mat4x3(mat4x3(1.0, 8.0, 0.0, 9.0, -1.0, -1.0, -7.0, 7.0, -4.0, -3.0, 1.0, -4.0), s2.b) && allOk;
	allOk = compare_mat3(mat3(-9.0, 1.0, -4.0, 0.0, 2.0, 0.0, 6.0, 2.0, 3.0), s2.c[0]) && allOk;
	allOk = compare_mat3(mat3(-5.0, -1.0, -5.0, -1.0, -9.0, -6.0, -9.0, -8.0, 6.0), s2.c[1]) && allOk;
	allOk = compare_mat3(mat3(-2.0, 3.0, 7.0, 2.0, -7.0, -2.0, -5.0, 4.0, 8.0), s2.c[2]) && allOk;
	allOk = compare_i8vec4(ivec4(-9, -8, -2, -8), ivec4(s2.d[0])) && allOk;
	allOk = compare_i8vec4(ivec4(-2, -9, 0, -8), ivec4(s2.d[1])) && allOk;
	allOk = compare_i8vec4(ivec4(-3, 8, -7, 9), ivec4(s2.d[2])) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	i8vec4 a[1];
	bvec4 b[2];
};

bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

shared S1 s1;

void main (void) {
	s1.a[0] = i8vec4(6, 6, -6, -3);
	s1.b[0] = bvec4(true, false, false, true);
	s1.b[1] = bvec4(false, true, true, false);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_i8vec4(ivec4(6, 6, -6, -3), ivec4(s1.a[0])) && allOk;
	allOk = compare_bvec4(bvec4(true, false, false, true), s1.b[0]) && allOk;
	allOk = compare_bvec4(bvec4(false, true, true, false), s1.b[1]) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	u8vec2 a[2];
	int8_t b[2];
	lowp mat3 c;
	u8vec2 d[1];
};
struct S2 {
	int8_t a[2];
	u8vec4 b[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a[0] = u8vec2(8u, 0u);
	s1.a[1] = u8vec2(0u, 0u);
	s1.b[0] = int8_t(7);
	s1.b[1] = int8_t(5);
	s1.c = mat3(-6.0, 1.0, 9.0, -4.0, -3.0, 4.0, 4.0, 9.0, -9.0);
	s1.d[0] = u8vec2(0u, 7u);
	s2.a[0] = int8_t(8);
	s2.a[1] = int8_t(0);
	s2.b[0] = u8vec4(9u, 8u, 9u, 7u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_u8vec2(uvec2(8u, 0u), uvec2(s1.a[0])) && allOk;
	allOk = compare_u8vec2(uvec2(0u, 0u), uvec2(s1.a[1])) && allOk;
	allOk = compare_int8_t(int(7), int(s1.b[0])) && allOk;
	allOk = compare_int8_t(int(5), int(s1.b[1])) && allOk;
	allOk = compare_mat3(mat3(-6.0, 1.0, 9.0, -4.0, -3.0, 4.0, 4.0, 9.0, -9.0), s1.c) && allOk;
	allOk = compare_u8vec2(uvec2(0u, 7u), uvec2(s1.d[0])) && allOk;
	allOk = compare_int8_t(int(8), int(s2.a[0])) && allOk;
	allOk = compare_int8_t(int(0), int(s2.a[1])) && allOk;
	allOk = compare_u8vec4(uvec4(9u, 8u, 9u, 7u), uvec4(s2.b[0])) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	u8vec2 a[1];
	u8vec2 b[2];
	u8vec3 c[3];
};

bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

shared S1 s1;

void main (void) {
	s1.a[0] = u8vec2(1u, 9u);
	s1.b[0] = u8vec2(8u, 5u);
	s1.b[1] = u8vec2(3u, 6u);
	s1.c[0] = u8vec3(8u, 6u, 2u);
	s1.c[1] = u8vec3(7u, 6u, 0u);
	s1.c[2] = u8vec3(7u, 2u, 5u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_u8vec2(uvec2(1u, 9u), uvec2(s1.a[0])) && allOk;
	allOk = compare_u8vec2(uvec2(8u, 5u), uvec2(s1.b[0])) && allOk;
	allOk = compare_u8vec2(uvec2(3u, 6u), uvec2(s1.b[1])) && allOk;
	allOk = compare_u8vec3(uvec3(8u, 6u, 2u), uvec3(s1.c[0])) && allOk;
	allOk = compare_u8vec3(uvec3(7u, 6u, 0u), uvec3(s1.c[1])) && allOk;
	allOk = compare_u8vec3(uvec3(7u, 2u, 5u), uvec3(s1.c[2])) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	highp uvec2 a[1];
	highp mat4 b[3];
};
struct S2 {
	highp vec2 a[3];
	i8vec3 b[2];
	uint8_t c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a[0] = uvec2(4u, 3u);
	s1.b[0] = mat4(-9.0, 3.0, 0.0, -7.0, 7.0, -2.0, 3.0, 9.0, 1.0, -5.0, -2.0, 0.0, 9.0, -1.0, -9.0, -6.0);
	s1.b[1] = mat4(-9.0, 6.0, 1.0, -6.0, 0.0, 2.0, 5.0, 6.0, 4.0, 1.0, -7.0, -5.0, 1.0, 2.0, -7.0, 5.0);
	s1.b[2] = mat4(-6.0, -9.0, -8.0, 8.0, -5.0, 9.0, -9.0, -2.0, 6.0, -7.0, 8.0, 3.0, 9.0, 7.0, 9.0, 7.0);
	s2.a[0] = vec2(3.0, -3.0);
	s2.a[1] = vec2(8.0, 1.0);
	s2.a[2] = vec2(-8.0, -3.0);
	s2.b[0] = i8vec3(-3, -3, 3);
	s2.b[1] = i8vec3(3, 2, 3);
	s2.c = uint8_t(5u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_uvec2(uvec2(4u, 3u), s1.a[0]) && allOk;
	allOk = compare_mat4(mat4(-9.0, 3.0, 0.0, -7.0, 7.0, -2.0, 3.0, 9.0, 1.0, -5.0, -2.0, 0.0, 9.0, -1.0, -9.0, -6.0), s1.b[0]) && allOk;
	allOk = compare_mat4(mat4(-9.0, 6.0, 1.0, -6.0, 0.0, 2.0, 5.0, 6.0, 4.0, 1.0, -7.0, -5.0, 1.0, 2.0, -7.0, 5.0), s1.b[1]) && allOk;
	allOk = compare_mat4(mat4(-6.0, -9.0, -8.0, 8.0, -5.0, 9.0, -9.0, -2.0, 6.0, -7.0, 8.0, 3.0, 9.0, 7.0, 9.0, 7.0), s1.b[2]) && allOk;
	allOk = compare_vec2(vec2(3.0, -3.0), s2.a[0]) && allOk;
	allOk = compare_vec2(vec2(8.0, 1.0), s2.a[1]) && allOk;
	allOk = compare_vec2(vec2(-8.0, -3.0), s2.a[2]) && allOk;
	allOk = compare_i8vec3(ivec3(-3, -3, 3), ivec3(s2.b[0])) && allOk;
	allOk = compare_i8vec3(ivec3(3, 2, 3), ivec3(s2.b[1])) && allOk;
	allOk = compare_uint8_t(uint(5u), uint(s2.c)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	uint8_t a[2];
	i8vec3 b[2];
	u8vec2 c[3];
	uint8_t d[2];
};
struct S2 {
	mediump mat3x4 a[1];
	i8vec4 b[2];
	i8vec2 c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a[0] = uint8_t(7u);
	s1.a[1] = uint8_t(1u);
	s1.b[0] = i8vec3(2, -4, 4);
	s1.b[1] = i8vec3(6, -2, -5);
	s1.c[0] = u8vec2(9u, 5u);
	s1.c[1] = u8vec2(9u, 6u);
	s1.c[2] = u8vec2(8u, 9u);
	s1.d[0] = uint8_t(8u);
	s1.d[1] = uint8_t(8u);
	s2.a[0] = mat3x4(-4.0, 8.0, -7.0, -9.0, -3.0, 4.0, -3.0, -7.0, -7.0, -1.0, 9.0, -6.0);
	s2.b[0] = i8vec4(8, -4, 4, 1);
	s2.b[1] = i8vec4(-6, -2, -3, -5);
	s2.c = i8vec2(4, 3);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_uint8_t(uint(7u), uint(s1.a[0])) && allOk;
	allOk = compare_uint8_t(uint(1u), uint(s1.a[1])) && allOk;
	allOk = compare_i8vec3(ivec3(2, -4, 4), ivec3(s1.b[0])) && allOk;
	allOk = compare_i8vec3(ivec3(6, -2, -5), ivec3(s1.b[1])) && allOk;
	allOk = compare_u8vec2(uvec2(9u, 5u), uvec2(s1.c[0])) && allOk;
	allOk = compare_u8vec2(uvec2(9u, 6u), uvec2(s1.c[1])) && allOk;
	allOk = compare_u8vec2(uvec2(8u, 9u), uvec2(s1.c[2])) && allOk;
	allOk = compare_uint8_t(uint(8u), uint(s1.d[0])) && allOk;
	allOk = compare_uint8_t(uint(8u), uint(s1.d[1])) && allOk;
	allOk = compare_mat3x4(mat3x4(-4.0, 8.0, -7.0, -9.0, -3.0, 4.0, -3.0, -7.0, -7.0, -1.0, 9.0, -6.0), s2.a[0]) && allOk;
	allOk = compare_i8vec4(ivec4(8, -4, 4, 1), ivec4(s2.b[0])) && allOk;
	allOk = compare_i8vec4(ivec4(-6, -2, -3, -5), ivec4(s2.b[1])) && allOk;
	allOk = compare_i8vec2(ivec2(4, 3), ivec2(s2.c)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	highp mat2 a[1];
	highp mat3x4 b[2];
	u8vec4 c[2];
	int8_t d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

shared S1 s1;

void main (void) {
	s1.a[0] = mat2(-4.0, 6.0, 6.0, -7.0);
	s1.b[0] = mat3x4(-9.0, 5.0, -4.0, -9.0, 8.0, 6.0, -2.0, -6.0, 4.0, -6.0, -3.0, 2.0);
	s1.b[1] = mat3x4(-9.0, -7.0, -5.0, -7.0, 3.0, 5.0, 2.0, -9.0, 0.0, -5.0, 0.0, 1.0);
	s1.c[0] = u8vec4(7u, 1u, 5u, 3u);
	s1.c[1] = u8vec4(6u, 0u, 6u, 1u);
	s1.d = int8_t(2);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_mat2(mat2(-4.0, 6.0, 6.0, -7.0), s1.a[0]) && allOk;
	allOk = compare_mat3x4(mat3x4(-9.0, 5.0, -4.0, -9.0, 8.0, 6.0, -2.0, -6.0, 4.0, -6.0, -3.0, 2.0), s1.b[0]) && allOk;
	allOk = compare_mat3x4(mat3x4(-9.0, -7.0, -5.0, -7.0, 3.0, 5.0, 2.0, -9.0, 0.0, -5.0, 0.0, 1.0), s1.b[1]) && allOk;
	allOk = compare_u8vec4(uvec4(7u, 1u, 5u, 3u), uvec4(s1.c[0])) && allOk;
	allOk = compare_u8vec4(uvec4(6u, 0u, 6u, 1u), uvec4(s1.c[1])) && allOk;
	allOk = compare_int8_t(int(2), int(s1.d)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	u8vec3 a[2];
	i8vec4 b[3];
	i8vec4 c[3];
};
struct S2 {
	bool a[3];
	int8_t b;
	int8_t c[3];
};
struct S3 {
	u8vec3 a[3];
	bvec2 b;
	int8_t c;
	lowp float d[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

shared S1 s1;
shared S2 s2;
shared S3 s3;

void main (void) {
	s1.a[0] = u8vec3(5u, 7u, 3u);
	s1.a[1] = u8vec3(1u, 4u, 1u);
	s1.b[0] = i8vec4(7, 7, 0, 5);
	s1.b[1] = i8vec4(-7, -5, -2, -1);
	s1.b[2] = i8vec4(5, 2, -4, 7);
	s1.c[0] = i8vec4(7, -1, 3, -2);
	s1.c[1] = i8vec4(-1, -5, 5, 3);
	s1.c[2] = i8vec4(9, -5, 1, 8);
	s2.a[0] = true;
	s2.a[1] = false;
	s2.a[2] = true;
	s2.b = int8_t(-3);
	s2.c[0] = int8_t(-1);
	s2.c[1] = int8_t(4);
	s2.c[2] = int8_t(-9);
	s3.a[0] = u8vec3(6u, 9u, 1u);
	s3.a[1] = u8vec3(5u, 1u, 8u);
	s3.a[2] = u8vec3(4u, 4u, 1u);
	s3.b = bvec2(false, true);
	s3.c = int8_t(2);
	s3.d[0] = 2.0;
	s3.d[1] = 3.0;
	s3.d[2] = 3.0;

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_u8vec3(uvec3(5u, 7u, 3u), uvec3(s1.a[0])) && allOk;
	allOk = compare_u8vec3(uvec3(1u, 4u, 1u), uvec3(s1.a[1])) && allOk;
	allOk = compare_i8vec4(ivec4(7, 7, 0, 5), ivec4(s1.b[0])) && allOk;
	allOk = compare_i8vec4(ivec4(-7, -5, -2, -1), ivec4(s1.b[1])) && allOk;
	allOk = compare_i8vec4(ivec4(5, 2, -4, 7), ivec4(s1.b[2])) && allOk;
	allOk = compare_i8vec4(ivec4(7, -1, 3, -2), ivec4(s1.c[0])) && allOk;
	allOk = compare_i8vec4(ivec4(-1, -5, 5, 3), ivec4(s1.c[1])) && allOk;
	allOk = compare_i8vec4(ivec4(9, -5, 1, 8), ivec4(s1.c[2])) && allOk;
	allOk = compare_bool(true, s2.a[0]) && allOk;
	allOk = compare_bool(false, s2.a[1]) && allOk;
	allOk = compare_bool(true, s2.a[2]) && allOk;
	allOk = compare_int8_t(int(-3), int(s2.b)) && allOk;
	allOk = compare_int8_t(int(-1), int(s2.c[0])) && allOk;
	allOk = compare_int8_t(int(4), int(s2.c[1])) && allOk;
	allOk = compare_int8_t(int(-9), int(s2.c[2])) && allOk;
	allOk = compare_u8vec3(uvec3(6u, 9u, 1u), uvec3(s3.a[0])) && allOk;
	allOk = compare_u8vec3(uvec3(5u, 1u, 8u), uvec3(s3.a[1])) && allOk;
	allOk = compare_u8vec3(uvec3(4u, 4u, 1u), uvec3(s3.a[2])) && allOk;
	allOk = compare_bvec2(bvec2(false, true), s3.b) && allOk;
	allOk = compare_int8_t(int(2), int(s3.c)) && allOk;
	allOk = compare_float(2.0, s3.d[0]) && allOk;
	allOk = compare_float(3.0, s3.d[1]) && allOk;
	allOk = compare_float(3.0, s3.d[2]) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	mediump ivec2 a[3];
	uint8_t b[1];
	mediump mat3x4 c[1];
	u8vec2 d[1];
};
struct S2 {
	u8vec3 a[1];
	int8_t b[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a[0] = ivec2(1, -6);
	s1.a[1] = ivec2(-5, 7);
	s1.a[2] = ivec2(2, -1);
	s1.b[0] = uint8_t(9u);
	s1.c[0] = mat3x4(1.0, -8.0, -1.0, 4.0, -7.0, 3.0, 8.0, 1.0, 9.0, 5.0, -4.0, 1.0);
	s1.d[0] = u8vec2(1u, 5u);
	s2.a[0] = u8vec3(8u, 8u, 1u);
	s2.b[0] = int8_t(6);
	s2.b[1] = int8_t(9);
	s2.b[2] = int8_t(0);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_ivec2(ivec2(1, -6), s1.a[0]) && allOk;
	allOk = compare_ivec2(ivec2(-5, 7), s1.a[1]) && allOk;
	allOk = compare_ivec2(ivec2(2, -1), s1.a[2]) && allOk;
	allOk = compare_uint8_t(uint(9u), uint(s1.b[0])) && allOk;
	allOk = compare_mat3x4(mat3x4(1.0, -8.0, -1.0, 4.0, -7.0, 3.0, 8.0, 1.0, 9.0, 5.0, -4.0, 1.0), s1.c[0]) && allOk;
	allOk = compare_u8vec2(uvec2(1u, 5u), uvec2(s1.d[0])) && allOk;
	allOk = compare_u8vec3(uvec3(8u, 8u, 1u), uvec3(s2.a[0])) && allOk;
	allOk = compare_int8_t(int(6), int(s2.b[0])) && allOk;
	allOk = compare_int8_t(int(9), int(s2.b[1])) && allOk;
	allOk = compare_int8_t(int(0), int(s2.b[2])) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	int8_t a[3];
	u8vec3 b[2];
	highp float c[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

shared S1 s1;

void main (void) {
	s1.a[0] = int8_t(1);
	s1.a[1] = int8_t(-3);
	s1.a[2] = int8_t(9);
	s1.b[0] = u8vec3(7u, 3u, 3u);
	s1.b[1] = u8vec3(5u, 0u, 3u);
	s1.c[0] = -6.0;

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_int8_t(int(1), int(s1.a[0])) && allOk;
	allOk = compare_int8_t(int(-3), int(s1.a[1])) && allOk;
	allOk = compare_int8_t(int(9), int(s1.a[2])) && allOk;
	allOk = compare_u8vec3(uvec3(7u, 3u, 3u), uvec3(s1.b[0])) && allOk;
	allOk = compare_u8vec3(uvec3(5u, 0u, 3u), uvec3(s1.b[1])) && allOk;
	allOk = compare_float(-6.0, s1.c[0]) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	lowp mat3x4 a[2];
	mediump uvec2 b[2][1][3];
	i8vec2 c[2][3][3];
	uint8_t d[1][1][2];
};
struct S2 {
	uint8_t a[2];
	u8vec2 b[2];
	int8_t c[3][1][3];
};
struct S3 {
	i8vec3 a;
	i8vec3 b;
	bvec2 c[1][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

shared S1 s1;
shared S2 s2;
shared S3 s3;

void main (void) {
	s1.a[0] = mat3x4(6.0, 8.0, 8.0, 0.0, -4.0, -5.0, 9.0, -4.0, -6.0, -1.0, -1.0, -2.0);
	s1.a[1] = mat3x4(1.0, 6.0, 5.0, 7.0, -2.0, -4.0, -9.0, 8.0, 3.0, 0.0, 2.0, 1.0);
	s1.b[0][0][0] = uvec2(4u, 8u);
	s1.b[0][0][1] = uvec2(0u, 9u);
	s1.b[0][0][2] = uvec2(4u, 9u);
	s1.b[1][0][0] = uvec2(1u, 8u);
	s1.b[1][0][1] = uvec2(6u, 2u);
	s1.b[1][0][2] = uvec2(0u, 8u);
	s1.c[0][0][0] = i8vec2(1, -4);
	s1.c[0][0][1] = i8vec2(0, 2);
	s1.c[0][0][2] = i8vec2(0, 6);
	s1.c[0][1][0] = i8vec2(2, 3);
	s1.c[0][1][1] = i8vec2(-5, -1);
	s1.c[0][1][2] = i8vec2(-5, -1);
	s1.c[0][2][0] = i8vec2(-9, -6);
	s1.c[0][2][1] = i8vec2(-9, -8);
	s1.c[0][2][2] = i8vec2(6, -2);
	s1.c[1][0][0] = i8vec2(3, 7);
	s1.c[1][0][1] = i8vec2(2, -7);
	s1.c[1][0][2] = i8vec2(-2, -5);
	s1.c[1][1][0] = i8vec2(4, 8);
	s1.c[1][1][1] = i8vec2(-9, -8);
	s1.c[1][1][2] = i8vec2(-2, -8);
	s1.c[1][2][0] = i8vec2(-2, -9);
	s1.c[1][2][1] = i8vec2(0, -8);
	s1.c[1][2][2] = i8vec2(-3, 8);
	s1.d[0][0][0] = uint8_t(0u);
	s1.d[0][0][1] = uint8_t(2u);
	s2.a[0] = uint8_t(5u);
	s2.a[1] = uint8_t(8u);
	s2.b[0] = u8vec2(7u, 5u);
	s2.b[1] = u8vec2(6u, 7u);
	s2.c[0][0][0] = int8_t(-8);
	s2.c[0][0][1] = int8_t(5);
	s2.c[0][0][2] = int8_t(-7);
	s2.c[1][0][0] = int8_t(8);
	s2.c[1][0][1] = int8_t(-2);
	s2.c[1][0][2] = int8_t(6);
	s2.c[2][0][0] = int8_t(2);
	s2.c[2][0][1] = int8_t(-9);
	s2.c[2][0][2] = int8_t(-5);
	s3.a = i8vec3(4, 4, -7);
	s3.b = i8vec3(-4, -9, 7);
	s3.c[0][0] = bvec2(true, true);
	s3.c[0][1] = bvec2(true, true);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_mat3x4(mat3x4(6.0, 8.0, 8.0, 0.0, -4.0, -5.0, 9.0, -4.0, -6.0, -1.0, -1.0, -2.0), s1.a[0]) && allOk;
	allOk = compare_mat3x4(mat3x4(1.0, 6.0, 5.0, 7.0, -2.0, -4.0, -9.0, 8.0, 3.0, 0.0, 2.0, 1.0), s1.a[1]) && allOk;
	allOk = compare_uvec2(uvec2(4u, 8u), s1.b[0][0][0]) && allOk;
	allOk = compare_uvec2(uvec2(0u, 9u), s1.b[0][0][1]) && allOk;
	allOk = compare_uvec2(uvec2(4u, 9u), s1.b[0][0][2]) && allOk;
	allOk = compare_uvec2(uvec2(1u, 8u), s1.b[1][0][0]) && allOk;
	allOk = compare_uvec2(uvec2(6u, 2u), s1.b[1][0][1]) && allOk;
	allOk = compare_uvec2(uvec2(0u, 8u), s1.b[1][0][2]) && allOk;
	allOk = compare_i8vec2(ivec2(1, -4), ivec2(s1.c[0][0][0])) && allOk;
	allOk = compare_i8vec2(ivec2(0, 2), ivec2(s1.c[0][0][1])) && allOk;
	allOk = compare_i8vec2(ivec2(0, 6), ivec2(s1.c[0][0][2])) && allOk;
	allOk = compare_i8vec2(ivec2(2, 3), ivec2(s1.c[0][1][0])) && allOk;
	allOk = compare_i8vec2(ivec2(-5, -1), ivec2(s1.c[0][1][1])) && allOk;
	allOk = compare_i8vec2(ivec2(-5, -1), ivec2(s1.c[0][1][2])) && allOk;
	allOk = compare_i8vec2(ivec2(-9, -6), ivec2(s1.c[0][2][0])) && allOk;
	allOk = compare_i8vec2(ivec2(-9, -8), ivec2(s1.c[0][2][1])) && allOk;
	allOk = compare_i8vec2(ivec2(6, -2), ivec2(s1.c[0][2][2])) && allOk;
	allOk = compare_i8vec2(ivec2(3, 7), ivec2(s1.c[1][0][0])) && allOk;
	allOk = compare_i8vec2(ivec2(2, -7), ivec2(s1.c[1][0][1])) && allOk;
	allOk = compare_i8vec2(ivec2(-2, -5), ivec2(s1.c[1][0][2])) && allOk;
	allOk = compare_i8vec2(ivec2(4, 8), ivec2(s1.c[1][1][0])) && allOk;
	allOk = compare_i8vec2(ivec2(-9, -8), ivec2(s1.c[1][1][1])) && allOk;
	allOk = compare_i8vec2(ivec2(-2, -8), ivec2(s1.c[1][1][2])) && allOk;
	allOk = compare_i8vec2(ivec2(-2, -9), ivec2(s1.c[1][2][0])) && allOk;
	allOk = compare_i8vec2(ivec2(0, -8), ivec2(s1.c[1][2][1])) && allOk;
	allOk = compare_i8vec2(ivec2(-3, 8), ivec2(s1.c[1][2][2])) && allOk;
	allOk = compare_uint8_t(uint(0u), uint(s1.d[0][0][0])) && allOk;
	allOk = compare_uint8_t(uint(2u), uint(s1.d[0][0][1])) && allOk;
	allOk = compare_uint8_t(uint(5u), uint(s2.a[0])) && allOk;
	allOk = compare_uint8_t(uint(8u), uint(s2.a[1])) && allOk;
	allOk = compare_u8vec2(uvec2(7u, 5u), uvec2(s2.b[0])) && allOk;
	allOk = compare_u8vec2(uvec2(6u, 7u), uvec2(s2.b[1])) && allOk;
	allOk = compare_int8_t(int(-8), int(s2.c[0][0][0])) && allOk;
	allOk = compare_int8_t(int(5), int(s2.c[0][0][1])) && allOk;
	allOk = compare_int8_t(int(-7), int(s2.c[0][0][2])) && allOk;
	allOk = compare_int8_t(int(8), int(s2.c[1][0][0])) && allOk;
	allOk = compare_int8_t(int(-2), int(s2.c[1][0][1])) && allOk;
	allOk = compare_int8_t(int(6), int(s2.c[1][0][2])) && allOk;
	allOk = compare_int8_t(int(2), int(s2.c[2][0][0])) && allOk;
	allOk = compare_int8_t(int(-9), int(s2.c[2][0][1])) && allOk;
	allOk = compare_int8_t(int(-5), int(s2.c[2][0][2])) && allOk;
	allOk = compare_i8vec3(ivec3(4, 4, -7), ivec3(s3.a)) && allOk;
	allOk = compare_i8vec3(ivec3(-4, -9, 7), ivec3(s3.b)) && allOk;
	allOk = compare_bvec2(bvec2(true, true), s3.c[0][0]) && allOk;
	allOk = compare_bvec2(bvec2(true, true), s3.c[0][1]) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	u8vec2 a[1][2][1];
	u8vec3 b;
	mediump uvec3 c;
};
struct S2 {
	uint8_t a[2][2];
	highp uint b[3][1][1];
	u8vec2 c[3][2][3];
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a[0][0][0] = u8vec2(3u, 0u);
	s1.a[0][1][0] = u8vec2(3u, 0u);
	s1.b = u8vec3(4u, 5u, 4u);
	s1.c = uvec3(3u, 2u, 6u);
	s2.a[0][0] = uint8_t(9u);
	s2.a[0][1] = uint8_t(1u);
	s2.a[1][0] = uint8_t(4u);
	s2.a[1][1] = uint8_t(1u);
	s2.b[0][0][0] = 4u;
	s2.b[1][0][0] = 9u;
	s2.b[2][0][0] = 4u;
	s2.c[0][0][0] = u8vec2(9u, 6u);
	s2.c[0][0][1] = u8vec2(8u, 1u);
	s2.c[0][0][2] = u8vec2(6u, 2u);
	s2.c[0][1][0] = u8vec2(2u, 6u);
	s2.c[0][1][1] = u8vec2(5u, 5u);
	s2.c[0][1][2] = u8vec2(7u, 8u);
	s2.c[1][0][0] = u8vec2(9u, 3u);
	s2.c[1][0][1] = u8vec2(7u, 3u);
	s2.c[1][0][2] = u8vec2(0u, 2u);
	s2.c[1][1][0] = u8vec2(1u, 7u);
	s2.c[1][1][1] = u8vec2(4u, 6u);
	s2.c[1][1][2] = u8vec2(2u, 1u);
	s2.c[2][0][0] = u8vec2(4u, 6u);
	s2.c[2][0][1] = u8vec2(0u, 3u);
	s2.c[2][0][2] = u8vec2(5u, 8u);
	s2.c[2][1][0] = u8vec2(5u, 1u);
	s2.c[2][1][1] = u8vec2(3u, 3u);
	s2.c[2][1][2] = u8vec2(8u, 7u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_u8vec2(uvec2(3u, 0u), uvec2(s1.a[0][0][0])) && allOk;
	allOk = compare_u8vec2(uvec2(3u, 0u), uvec2(s1.a[0][1][0])) && allOk;
	allOk = compare_u8vec3(uvec3(4u, 5u, 4u), uvec3(s1.b)) && allOk;
	allOk = compare_uvec3(uvec3(3u, 2u, 6u), s1.c) && allOk;
	allOk = compare_uint8_t(uint(9u), uint(s2.a[0][0])) && allOk;
	allOk = compare_uint8_t(uint(1u), uint(s2.a[0][1])) && allOk;
	allOk = compare_uint8_t(uint(4u), uint(s2.a[1][0])) && allOk;
	allOk = compare_uint8_t(uint(1u), uint(s2.a[1][1])) && allOk;
	allOk = compare_uint(4u, s2.b[0][0][0]) && allOk;
	allOk = compare_uint(9u, s2.b[1][0][0]) && allOk;
	allOk = compare_uint(4u, s2.b[2][0][0]) && allOk;
	allOk = compare_u8vec2(uvec2(9u, 6u), uvec2(s2.c[0][0][0])) && allOk;
	allOk = compare_u8vec2(uvec2(8u, 1u), uvec2(s2.c[0][0][1])) && allOk;
	allOk = compare_u8vec2(uvec2(6u, 2u), uvec2(s2.c[0][0][2])) && allOk;
	allOk = compare_u8vec2(uvec2(2u, 6u), uvec2(s2.c[0][1][0])) && allOk;
	allOk = compare_u8vec2(uvec2(5u, 5u), uvec2(s2.c[0][1][1])) && allOk;
	allOk = compare_u8vec2(uvec2(7u, 8u), uvec2(s2.c[0][1][2])) && allOk;
	allOk = compare_u8vec2(uvec2(9u, 3u), uvec2(s2.c[1][0][0])) && allOk;
	allOk = compare_u8vec2(uvec2(7u, 3u), uvec2(s2.c[1][0][1])) && allOk;
	allOk = compare_u8vec2(uvec2(0u, 2u), uvec2(s2.c[1][0][2])) && allOk;
	allOk = compare_u8vec2(uvec2(1u, 7u), uvec2(s2.c[1][1][0])) && allOk;
	allOk = compare_u8vec2(uvec2(4u, 6u), uvec2(s2.c[1][1][1])) && allOk;
	allOk = compare_u8vec2(uvec2(2u, 1u), uvec2(s2.c[1][1][2])) && allOk;
	allOk = compare_u8vec2(uvec2(4u, 6u), uvec2(s2.c[2][0][0])) && allOk;
	allOk = compare_u8vec2(uvec2(0u, 3u), uvec2(s2.c[2][0][1])) && allOk;
	allOk = compare_u8vec2(uvec2(5u, 8u), uvec2(s2.c[2][0][2])) && allOk;
	allOk = compare_u8vec2(uvec2(5u, 1u), uvec2(s2.c[2][1][0])) && allOk;
	allOk = compare_u8vec2(uvec2(3u, 3u), uvec2(s2.c[2][1][1])) && allOk;
	allOk = compare_u8vec2(uvec2(8u, 7u), uvec2(s2.c[2][1][2])) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	mediump mat4x3 a[2];
	uint8_t b;
	mediump ivec2 c[1][1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

shared S1 s1;

void main (void) {
	s1.a[0] = mat4x3(0.0, 2.0, -8.0, 6.0, 7.0, 5.0, -6.0, 1.0, 9.0, -4.0, -3.0, 4.0);
	s1.a[1] = mat4x3(4.0, 9.0, -9.0, -8.0, -9.0, 8.0, 0.0, 4.0, -4.0, 7.0, 2.0, -1.0);
	s1.b = uint8_t(2u);
	s1.c[0][0] = ivec2(-5, -4);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_mat4x3(mat4x3(0.0, 2.0, -8.0, 6.0, 7.0, 5.0, -6.0, 1.0, 9.0, -4.0, -3.0, 4.0), s1.a[0]) && allOk;
	allOk = compare_mat4x3(mat4x3(4.0, 9.0, -9.0, -8.0, -9.0, 8.0, 0.0, 4.0, -4.0, 7.0, 2.0, -1.0), s1.a[1]) && allOk;
	allOk = compare_uint8_t(uint(2u), uint(s1.b)) && allOk;
	allOk = compare_ivec2(ivec2(-5, -4), s1.c[0][0]) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	i8vec4 a[1][1][3];
	u8vec3 b[1][3][3];
	i8vec2 c;
};
struct S2 {
	u8vec3 a[2][2][3];
	i8vec4 b[1][1][1];
	i8vec2 c[3][2][2];
	u8vec2 d[3][3];
};
struct S3 {
	i8vec3 a[1][3][3];
	u8vec2 b[2][2][2];
	u8vec2 c[3][3][1];
};

bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

shared S1 s1;
shared S2 s2;
shared S3 s3;

void main (void) {
	s1.a[0][0][0] = i8vec4(1, -5, -9, -5);
	s1.a[0][0][1] = i8vec4(1, -7, 1, 2);
	s1.a[0][0][2] = i8vec4(8, 7, 9, -8);
	s1.b[0][0][0] = u8vec3(7u, 2u, 5u);
	s1.b[0][0][1] = u8vec3(6u, 4u, 1u);
	s1.b[0][0][2] = u8vec3(2u, 0u, 8u);
	s1.b[0][1][0] = u8vec3(8u, 7u, 2u);
	s1.b[0][1][1] = u8vec3(4u, 0u, 6u);
	s1.b[0][1][2] = u8vec3(8u, 8u, 2u);
	s1.b[0][2][0] = u8vec3(3u, 4u, 2u);
	s1.b[0][2][1] = u8vec3(4u, 8u, 8u);
	s1.b[0][2][2] = u8vec3(8u, 8u, 1u);
	s1.c = i8vec2(3, 1);
	s2.a[0][0][0] = u8vec3(1u, 0u, 0u);
	s2.a[0][0][1] = u8vec3(6u, 6u, 1u);
	s2.a[0][0][2] = u8vec3(6u, 7u, 9u);
	s2.a[0][1][0] = u8vec3(8u, 7u, 3u);
	s2.a[0][1][1] = u8vec3(0u, 4u, 6u);
	s2.a[0][1][2] = u8vec3(7u, 2u, 6u);
	s2.a[1][0][0] = u8vec3(1u, 8u, 3u);
	s2.a[1][0][1] = u8vec3(5u, 9u, 0u);
	s2.a[1][0][2] = u8vec3(6u, 5u, 4u);
	s2.a[1][1][0] = u8vec3(8u, 0u, 5u);
	s2.a[1][1][1] = u8vec3(0u, 0u, 8u);
	s2.a[1][1][2] = u8vec3(4u, 8u, 2u);
	s2.b[0][0][0] = i8vec4(6, 6, 2, 4);
	s2.c[0][0][0] = i8vec2(4, -3);
	s2.c[0][0][1] = i8vec2(3, 8);
	s2.c[0][1][0] = i8vec2(6, -3);
	s2.c[0][1][1] = i8vec2(4, -7);
	s2.c[1][0][0] = i8vec2(1, -5);
	s2.c[1][0][1] = i8vec2(-9, 7);
	s2.c[1][1][0] = i8vec2(-6, 6);
	s2.c[1][1][1] = i8vec2(-3, -4);
	s2.c[2][0][0] = i8vec2(5, -9);
	s2.c[2][0][1] = i8vec2(6, 2);
	s2.c[2][1][0] = i8vec2(-2, -6);
	s2.c[2][1][1] = i8vec2(4, -8);
	s2.d[0][0] = u8vec2(3u, 7u);
	s2.d[0][1] = u8vec2(5u, 4u);
	s2.d[0][2] = u8vec2(3u, 5u);
	s2.d[1][0] = u8vec2(7u, 8u);
	s2.d[1][1] = u8vec2(6u, 9u);
	s2.d[1][2] = u8vec2(9u, 5u);
	s2.d[2][0] = u8vec2(9u, 1u);
	s2.d[2][1] = u8vec2(3u, 7u);
	s2.d[2][2] = u8vec2(2u, 5u);
	s3.a[0][0][0] = i8vec3(-2, 5, 2);
	s3.a[0][0][1] = i8vec3(-8, -6, -5);
	s3.a[0][0][2] = i8vec3(7, 5, -6);
	s3.a[0][1][0] = i8vec3(5, -5, 3);
	s3.a[0][1][1] = i8vec3(-8, 6, 5);
	s3.a[0][1][2] = i8vec3(-9, 7, 5);
	s3.a[0][2][0] = i8vec3(-8, 9, -8);
	s3.a[0][2][1] = i8vec3(-7, 9, -9);
	s3.a[0][2][2] = i8vec3(2, 8, -1);
	s3.b[0][0][0] = u8vec2(1u, 0u);
	s3.b[0][0][1] = u8vec2(7u, 8u);
	s3.b[0][1][0] = u8vec2(7u, 8u);
	s3.b[0][1][1] = u8vec2(6u, 6u);
	s3.b[1][0][0] = u8vec2(9u, 8u);
	s3.b[1][0][1] = u8vec2(3u, 6u);
	s3.b[1][1][0] = u8vec2(5u, 3u);
	s3.b[1][1][1] = u8vec2(4u, 7u);
	s3.c[0][0][0] = u8vec2(1u, 5u);
	s3.c[0][1][0] = u8vec2(9u, 8u);
	s3.c[0][2][0] = u8vec2(5u, 5u);
	s3.c[1][0][0] = u8vec2(6u, 6u);
	s3.c[1][1][0] = u8vec2(3u, 6u);
	s3.c[1][2][0] = u8vec2(3u, 7u);
	s3.c[2][0][0] = u8vec2(2u, 5u);
	s3.c[2][1][0] = u8vec2(4u, 6u);
	s3.c[2][2][0] = u8vec2(3u, 2u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_i8vec4(ivec4(1, -5, -9, -5), ivec4(s1.a[0][0][0])) && allOk;
	allOk = compare_i8vec4(ivec4(1, -7, 1, 2), ivec4(s1.a[0][0][1])) && allOk;
	allOk = compare_i8vec4(ivec4(8, 7, 9, -8), ivec4(s1.a[0][0][2])) && allOk;
	allOk = compare_u8vec3(uvec3(7u, 2u, 5u), uvec3(s1.b[0][0][0])) && allOk;
	allOk = compare_u8vec3(uvec3(6u, 4u, 1u), uvec3(s1.b[0][0][1])) && allOk;
	allOk = compare_u8vec3(uvec3(2u, 0u, 8u), uvec3(s1.b[0][0][2])) && allOk;
	allOk = compare_u8vec3(uvec3(8u, 7u, 2u), uvec3(s1.b[0][1][0])) && allOk;
	allOk = compare_u8vec3(uvec3(4u, 0u, 6u), uvec3(s1.b[0][1][1])) && allOk;
	allOk = compare_u8vec3(uvec3(8u, 8u, 2u), uvec3(s1.b[0][1][2])) && allOk;
	allOk = compare_u8vec3(uvec3(3u, 4u, 2u), uvec3(s1.b[0][2][0])) && allOk;
	allOk = compare_u8vec3(uvec3(4u, 8u, 8u), uvec3(s1.b[0][2][1])) && allOk;
	allOk = compare_u8vec3(uvec3(8u, 8u, 1u), uvec3(s1.b[0][2][2])) && allOk;
	allOk = compare_i8vec2(ivec2(3, 1), ivec2(s1.c)) && allOk;
	allOk = compare_u8vec3(uvec3(1u, 0u, 0u), uvec3(s2.a[0][0][0])) && allOk;
	allOk = compare_u8vec3(uvec3(6u, 6u, 1u), uvec3(s2.a[0][0][1])) && allOk;
	allOk = compare_u8vec3(uvec3(6u, 7u, 9u), uvec3(s2.a[0][0][2])) && allOk;
	allOk = compare_u8vec3(uvec3(8u, 7u, 3u), uvec3(s2.a[0][1][0])) && allOk;
	allOk = compare_u8vec3(uvec3(0u, 4u, 6u), uvec3(s2.a[0][1][1])) && allOk;
	allOk = compare_u8vec3(uvec3(7u, 2u, 6u), uvec3(s2.a[0][1][2])) && allOk;
	allOk = compare_u8vec3(uvec3(1u, 8u, 3u), uvec3(s2.a[1][0][0])) && allOk;
	allOk = compare_u8vec3(uvec3(5u, 9u, 0u), uvec3(s2.a[1][0][1])) && allOk;
	allOk = compare_u8vec3(uvec3(6u, 5u, 4u), uvec3(s2.a[1][0][2])) && allOk;
	allOk = compare_u8vec3(uvec3(8u, 0u, 5u), uvec3(s2.a[1][1][0])) && allOk;
	allOk = compare_u8vec3(uvec3(0u, 0u, 8u), uvec3(s2.a[1][1][1])) && allOk;
	allOk = compare_u8vec3(uvec3(4u, 8u, 2u), uvec3(s2.a[1][1][2])) && allOk;
	allOk = compare_i8vec4(ivec4(6, 6, 2, 4), ivec4(s2.b[0][0][0])) && allOk;
	allOk = compare_i8vec2(ivec2(4, -3), ivec2(s2.c[0][0][0])) && allOk;
	allOk = compare_i8vec2(ivec2(3, 8), ivec2(s2.c[0][0][1])) && allOk;
	allOk = compare_i8vec2(ivec2(6, -3), ivec2(s2.c[0][1][0])) && allOk;
	allOk = compare_i8vec2(ivec2(4, -7), ivec2(s2.c[0][1][1])) && allOk;
	allOk = compare_i8vec2(ivec2(1, -5), ivec2(s2.c[1][0][0])) && allOk;
	allOk = compare_i8vec2(ivec2(-9, 7), ivec2(s2.c[1][0][1])) && allOk;
	allOk = compare_i8vec2(ivec2(-6, 6), ivec2(s2.c[1][1][0])) && allOk;
	allOk = compare_i8vec2(ivec2(-3, -4), ivec2(s2.c[1][1][1])) && allOk;
	allOk = compare_i8vec2(ivec2(5, -9), ivec2(s2.c[2][0][0])) && allOk;
	allOk = compare_i8vec2(ivec2(6, 2), ivec2(s2.c[2][0][1])) && allOk;
	allOk = compare_i8vec2(ivec2(-2, -6), ivec2(s2.c[2][1][0])) && allOk;
	allOk = compare_i8vec2(ivec2(4, -8), ivec2(s2.c[2][1][1])) && allOk;
	allOk = compare_u8vec2(uvec2(3u, 7u), uvec2(s2.d[0][0])) && allOk;
	allOk = compare_u8vec2(uvec2(5u, 4u), uvec2(s2.d[0][1])) && allOk;
	allOk = compare_u8vec2(uvec2(3u, 5u), uvec2(s2.d[0][2])) && allOk;
	allOk = compare_u8vec2(uvec2(7u, 8u), uvec2(s2.d[1][0])) && allOk;
	allOk = compare_u8vec2(uvec2(6u, 9u), uvec2(s2.d[1][1])) && allOk;
	allOk = compare_u8vec2(uvec2(9u, 5u), uvec2(s2.d[1][2])) && allOk;
	allOk = compare_u8vec2(uvec2(9u, 1u), uvec2(s2.d[2][0])) && allOk;
	allOk = compare_u8vec2(uvec2(3u, 7u), uvec2(s2.d[2][1])) && allOk;
	allOk = compare_u8vec2(uvec2(2u, 5u), uvec2(s2.d[2][2])) && allOk;
	allOk = compare_i8vec3(ivec3(-2, 5, 2), ivec3(s3.a[0][0][0])) && allOk;
	allOk = compare_i8vec3(ivec3(-8, -6, -5), ivec3(s3.a[0][0][1])) && allOk;
	allOk = compare_i8vec3(ivec3(7, 5, -6), ivec3(s3.a[0][0][2])) && allOk;
	allOk = compare_i8vec3(ivec3(5, -5, 3), ivec3(s3.a[0][1][0])) && allOk;
	allOk = compare_i8vec3(ivec3(-8, 6, 5), ivec3(s3.a[0][1][1])) && allOk;
	allOk = compare_i8vec3(ivec3(-9, 7, 5), ivec3(s3.a[0][1][2])) && allOk;
	allOk = compare_i8vec3(ivec3(-8, 9, -8), ivec3(s3.a[0][2][0])) && allOk;
	allOk = compare_i8vec3(ivec3(-7, 9, -9), ivec3(s3.a[0][2][1])) && allOk;
	allOk = compare_i8vec3(ivec3(2, 8, -1), ivec3(s3.a[0][2][2])) && allOk;
	allOk = compare_u8vec2(uvec2(1u, 0u), uvec2(s3.b[0][0][0])) && allOk;
	allOk = compare_u8vec2(uvec2(7u, 8u), uvec2(s3.b[0][0][1])) && allOk;
	allOk = compare_u8vec2(uvec2(7u, 8u), uvec2(s3.b[0][1][0])) && allOk;
	allOk = compare_u8vec2(uvec2(6u, 6u), uvec2(s3.b[0][1][1])) && allOk;
	allOk = compare_u8vec2(uvec2(9u, 8u), uvec2(s3.b[1][0][0])) && allOk;
	allOk = compare_u8vec2(uvec2(3u, 6u), uvec2(s3.b[1][0][1])) && allOk;
	allOk = compare_u8vec2(uvec2(5u, 3u), uvec2(s3.b[1][1][0])) && allOk;
	allOk = compare_u8vec2(uvec2(4u, 7u), uvec2(s3.b[1][1][1])) && allOk;
	allOk = compare_u8vec2(uvec2(1u, 5u), uvec2(s3.c[0][0][0])) && allOk;
	allOk = compare_u8vec2(uvec2(9u, 8u), uvec2(s3.c[0][1][0])) && allOk;
	allOk = compare_u8vec2(uvec2(5u, 5u), uvec2(s3.c[0][2][0])) && allOk;
	allOk = compare_u8vec2(uvec2(6u, 6u), uvec2(s3.c[1][0][0])) && allOk;
	allOk = compare_u8vec2(uvec2(3u, 6u), uvec2(s3.c[1][1][0])) && allOk;
	allOk = compare_u8vec2(uvec2(3u, 7u), uvec2(s3.c[1][2][0])) && allOk;
	allOk = compare_u8vec2(uvec2(2u, 5u), uvec2(s3.c[2][0][0])) && allOk;
	allOk = compare_u8vec2(uvec2(4u, 6u), uvec2(s3.c[2][1][0])) && allOk;
	allOk = compare_u8vec2(uvec2(3u, 2u), uvec2(s3.c[2][2][0])) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	mediump mat4 a;
	highp int b[3][1][1];
	highp ivec2 c;
	mediump mat2 d[1][2][3];
};
struct S2 {
	bvec2 a[2];
	u8vec4 b[1][1][3];
	highp uvec4 c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a = mat4(2.0, 7.0, -9.0, 3.0, 0.0, -7.0, 7.0, -2.0, 3.0, 9.0, 1.0, -5.0, -2.0, 0.0, 9.0, -1.0);
	s1.b[0][0][0] = -9;
	s1.b[1][0][0] = -6;
	s1.b[2][0][0] = -9;
	s1.c = ivec2(6, 1);
	s1.d[0][0][0] = mat2(-6.0, 0.0, 2.0, 5.0);
	s1.d[0][0][1] = mat2(6.0, 4.0, 1.0, -7.0);
	s1.d[0][0][2] = mat2(-5.0, 1.0, 2.0, -7.0);
	s1.d[0][1][0] = mat2(5.0, -6.0, -9.0, -8.0);
	s1.d[0][1][1] = mat2(8.0, -5.0, 9.0, -9.0);
	s1.d[0][1][2] = mat2(-2.0, 6.0, -7.0, 8.0);
	s2.a[0] = bvec2(true, true);
	s2.a[1] = bvec2(false, false);
	s2.b[0][0][0] = u8vec4(0u, 5u, 6u, 5u);
	s2.b[0][0][1] = u8vec4(8u, 5u, 6u, 7u);
	s2.b[0][0][2] = u8vec4(7u, 5u, 7u, 1u);
	s2.c = uvec4(1u, 5u, 4u, 5u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_mat4(mat4(2.0, 7.0, -9.0, 3.0, 0.0, -7.0, 7.0, -2.0, 3.0, 9.0, 1.0, -5.0, -2.0, 0.0, 9.0, -1.0), s1.a) && allOk;
	allOk = compare_int(-9, s1.b[0][0][0]) && allOk;
	allOk = compare_int(-6, s1.b[1][0][0]) && allOk;
	allOk = compare_int(-9, s1.b[2][0][0]) && allOk;
	allOk = compare_ivec2(ivec2(6, 1), s1.c) && allOk;
	allOk = compare_mat2(mat2(-6.0, 0.0, 2.0, 5.0), s1.d[0][0][0]) && allOk;
	allOk = compare_mat2(mat2(6.0, 4.0, 1.0, -7.0), s1.d[0][0][1]) && allOk;
	allOk = compare_mat2(mat2(-5.0, 1.0, 2.0, -7.0), s1.d[0][0][2]) && allOk;
	allOk = compare_mat2(mat2(5.0, -6.0, -9.0, -8.0), s1.d[0][1][0]) && allOk;
	allOk = compare_mat2(mat2(8.0, -5.0, 9.0, -9.0), s1.d[0][1][1]) && allOk;
	allOk = compare_mat2(mat2(-2.0, 6.0, -7.0, 8.0), s1.d[0][1][2]) && allOk;
	allOk = compare_bvec2(bvec2(true, true), s2.a[0]) && allOk;
	allOk = compare_bvec2(bvec2(false, false), s2.a[1]) && allOk;
	allOk = compare_u8vec4(uvec4(0u, 5u, 6u, 5u), uvec4(s2.b[0][0][0])) && allOk;
	allOk = compare_u8vec4(uvec4(8u, 5u, 6u, 7u), uvec4(s2.b[0][0][1])) && allOk;
	allOk = compare_u8vec4(uvec4(7u, 5u, 7u, 1u), uvec4(s2.b[0][0][2])) && allOk;
	allOk = compare_uvec4(uvec4(1u, 5u, 4u, 5u), s2.c) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	u8vec4 a[2][3];
	int8_t b[2][3];
};

bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

shared S1 s1;

void main (void) {
	s1.a[0][0] = u8vec4(7u, 1u, 2u, 9u);
	s1.a[0][1] = u8vec4(1u, 4u, 3u, 1u);
	s1.a[0][2] = u8vec4(9u, 5u, 9u, 6u);
	s1.a[1][0] = u8vec4(8u, 9u, 8u, 8u);
	s1.a[1][1] = u8vec4(9u, 9u, 1u, 2u);
	s1.a[1][2] = u8vec4(8u, 5u, 0u, 1u);
	s1.b[0][0] = int8_t(-7);
	s1.b[0][1] = int8_t(-1);
	s1.b[0][2] = int8_t(9);
	s1.b[1][0] = int8_t(-6);
	s1.b[1][1] = int8_t(8);
	s1.b[1][2] = int8_t(-4);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_u8vec4(uvec4(7u, 1u, 2u, 9u), uvec4(s1.a[0][0])) && allOk;
	allOk = compare_u8vec4(uvec4(1u, 4u, 3u, 1u), uvec4(s1.a[0][1])) && allOk;
	allOk = compare_u8vec4(uvec4(9u, 5u, 9u, 6u), uvec4(s1.a[0][2])) && allOk;
	allOk = compare_u8vec4(uvec4(8u, 9u, 8u, 8u), uvec4(s1.a[1][0])) && allOk;
	allOk = compare_u8vec4(uvec4(9u, 9u, 1u, 2u), uvec4(s1.a[1][1])) && allOk;
	allOk = compare_u8vec4(uvec4(8u, 5u, 0u, 1u), uvec4(s1.a[1][2])) && allOk;
	allOk = compare_int8_t(int(-7), int(s1.b[0][0])) && allOk;
	allOk = compare_int8_t(int(-1), int(s1.b[0][1])) && allOk;
	allOk = compare_int8_t(int(9), int(s1.b[0][2])) && allOk;
	allOk = compare_int8_t(int(-6), int(s1.b[1][0])) && allOk;
	allOk = compare_int8_t(int(8), int(s1.b[1][1])) && allOk;
	allOk = compare_int8_t(int(-4), int(s1.b[1][2])) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	i8vec2 a[2][1][3];
	highp uvec4 b[1][1][3];
	int8_t c[1];
};
struct S2 {
	u8vec4 a;
	i8vec4 b[2][1];
	highp int c;
};
struct S3 {
	u8vec4 a[3][1][2];
	u8vec4 b[3];
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

shared S1 s1;
shared S2 s2;
shared S3 s3;

void main (void) {
	s1.a[0][0][0] = i8vec2(-4, 6);
	s1.a[0][0][1] = i8vec2(6, -7);
	s1.a[0][0][2] = i8vec2(-9, 5);
	s1.a[1][0][0] = i8vec2(-4, -9);
	s1.a[1][0][1] = i8vec2(8, 6);
	s1.a[1][0][2] = i8vec2(-2, -6);
	s1.b[0][0][0] = uvec4(4u, 6u, 4u, 2u);
	s1.b[0][0][1] = uvec4(2u, 3u, 1u, 4u);
	s1.b[0][0][2] = uvec4(1u, 1u, 7u, 9u);
	s1.c[0] = int8_t(0);
	s2.a = u8vec4(0u, 1u, 1u, 7u);
	s2.b[0][0] = i8vec4(0, 3, -5, 5);
	s2.b[1][0] = i8vec4(-7, 1, -8, 2);
	s2.c = 0;
	s3.a[0][0][0] = u8vec4(0u, 3u, 4u, 9u);
	s3.a[0][0][1] = u8vec4(9u, 1u, 6u, 2u);
	s3.a[1][0][0] = u8vec4(2u, 3u, 4u, 6u);
	s3.a[1][0][1] = u8vec4(2u, 9u, 2u, 6u);
	s3.a[2][0][0] = u8vec4(1u, 4u, 6u, 0u);
	s3.a[2][0][1] = u8vec4(3u, 2u, 3u, 3u);
	s3.b[0] = u8vec4(8u, 9u, 7u, 2u);
	s3.b[1] = u8vec4(6u, 6u, 7u, 9u);
	s3.b[2] = u8vec4(4u, 7u, 0u, 2u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_i8vec2(ivec2(-4, 6), ivec2(s1.a[0][0][0])) && allOk;
	allOk = compare_i8vec2(ivec2(6, -7), ivec2(s1.a[0][0][1])) && allOk;
	allOk = compare_i8vec2(ivec2(-9, 5), ivec2(s1.a[0][0][2])) && allOk;
	allOk = compare_i8vec2(ivec2(-4, -9), ivec2(s1.a[1][0][0])) && allOk;
	allOk = compare_i8vec2(ivec2(8, 6), ivec2(s1.a[1][0][1])) && allOk;
	allOk = compare_i8vec2(ivec2(-2, -6), ivec2(s1.a[1][0][2])) && allOk;
	allOk = compare_uvec4(uvec4(4u, 6u, 4u, 2u), s1.b[0][0][0]) && allOk;
	allOk = compare_uvec4(uvec4(2u, 3u, 1u, 4u), s1.b[0][0][1]) && allOk;
	allOk = compare_uvec4(uvec4(1u, 1u, 7u, 9u), s1.b[0][0][2]) && allOk;
	allOk = compare_int8_t(int(0), int(s1.c[0])) && allOk;
	allOk = compare_u8vec4(uvec4(0u, 1u, 1u, 7u), uvec4(s2.a)) && allOk;
	allOk = compare_i8vec4(ivec4(0, 3, -5, 5), ivec4(s2.b[0][0])) && allOk;
	allOk = compare_i8vec4(ivec4(-7, 1, -8, 2), ivec4(s2.b[1][0])) && allOk;
	allOk = compare_int(0, s2.c) && allOk;
	allOk = compare_u8vec4(uvec4(0u, 3u, 4u, 9u), uvec4(s3.a[0][0][0])) && allOk;
	allOk = compare_u8vec4(uvec4(9u, 1u, 6u, 2u), uvec4(s3.a[0][0][1])) && allOk;
	allOk = compare_u8vec4(uvec4(2u, 3u, 4u, 6u), uvec4(s3.a[1][0][0])) && allOk;
	allOk = compare_u8vec4(uvec4(2u, 9u, 2u, 6u), uvec4(s3.a[1][0][1])) && allOk;
	allOk = compare_u8vec4(uvec4(1u, 4u, 6u, 0u), uvec4(s3.a[2][0][0])) && allOk;
	allOk = compare_u8vec4(uvec4(3u, 2u, 3u, 3u), uvec4(s3.a[2][0][1])) && allOk;
	allOk = compare_u8vec4(uvec4(8u, 9u, 7u, 2u), uvec4(s3.b[0])) && allOk;
	allOk = compare_u8vec4(uvec4(6u, 6u, 7u, 9u), uvec4(s3.b[1])) && allOk;
	allOk = compare_u8vec4(uvec4(4u, 7u, 0u, 2u), uvec4(s3.b[2])) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	uint8_t a[2][2][1];
	u8vec2 b[1][1][1];
	u8vec3 c[1][2][1];
};
struct S2 {
	highp uvec4 a[2][1][3];
	u8vec4 b[3][1];
	int8_t c[1][1][3];
	u8vec2 d[3][3][1];
};

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a[0][0][0] = uint8_t(5u);
	s1.a[0][1][0] = uint8_t(7u);
	s1.a[1][0][0] = uint8_t(3u);
	s1.a[1][1][0] = uint8_t(1u);
	s1.b[0][0][0] = u8vec2(4u, 1u);
	s1.c[0][0][0] = u8vec3(3u, 0u, 5u);
	s1.c[0][1][0] = u8vec3(9u, 0u, 9u);
	s2.a[0][0][0] = uvec4(9u, 1u, 8u, 4u);
	s2.a[0][0][1] = uvec4(5u, 0u, 8u, 1u);
	s2.a[0][0][2] = uvec4(4u, 8u, 1u, 0u);
	s2.a[1][0][0] = uvec4(4u, 5u, 5u, 1u);
	s2.a[1][0][1] = uvec4(3u, 3u, 2u, 4u);
	s2.a[1][0][2] = uvec4(9u, 5u, 4u, 9u);
	s2.b[0][0] = u8vec4(9u, 6u, 9u, 1u);
	s2.b[1][0] = u8vec4(5u, 1u, 8u, 4u);
	s2.b[2][0] = u8vec4(4u, 1u, 6u, 3u);
	s2.c[0][0][0] = int8_t(2);
	s2.c[0][0][1] = int8_t(2);
	s2.c[0][0][2] = int8_t(3);
	s2.d[0][0][0] = u8vec2(5u, 9u);
	s2.d[0][1][0] = u8vec2(8u, 9u);
	s2.d[0][2][0] = u8vec2(9u, 6u);
	s2.d[1][0][0] = u8vec2(3u, 5u);
	s2.d[1][1][0] = u8vec2(0u, 9u);
	s2.d[1][2][0] = u8vec2(1u, 4u);
	s2.d[2][0][0] = u8vec2(4u, 0u);
	s2.d[2][1][0] = u8vec2(9u, 0u);
	s2.d[2][2][0] = u8vec2(4u, 9u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_uint8_t(uint(5u), uint(s1.a[0][0][0])) && allOk;
	allOk = compare_uint8_t(uint(7u), uint(s1.a[0][1][0])) && allOk;
	allOk = compare_uint8_t(uint(3u), uint(s1.a[1][0][0])) && allOk;
	allOk = compare_uint8_t(uint(1u), uint(s1.a[1][1][0])) && allOk;
	allOk = compare_u8vec2(uvec2(4u, 1u), uvec2(s1.b[0][0][0])) && allOk;
	allOk = compare_u8vec3(uvec3(3u, 0u, 5u), uvec3(s1.c[0][0][0])) && allOk;
	allOk = compare_u8vec3(uvec3(9u, 0u, 9u), uvec3(s1.c[0][1][0])) && allOk;
	allOk = compare_uvec4(uvec4(9u, 1u, 8u, 4u), s2.a[0][0][0]) && allOk;
	allOk = compare_uvec4(uvec4(5u, 0u, 8u, 1u), s2.a[0][0][1]) && allOk;
	allOk = compare_uvec4(uvec4(4u, 8u, 1u, 0u), s2.a[0][0][2]) && allOk;
	allOk = compare_uvec4(uvec4(4u, 5u, 5u, 1u), s2.a[1][0][0]) && allOk;
	allOk = compare_uvec4(uvec4(3u, 3u, 2u, 4u), s2.a[1][0][1]) && allOk;
	allOk = compare_uvec4(uvec4(9u, 5u, 4u, 9u), s2.a[1][0][2]) && allOk;
	allOk = compare_u8vec4(uvec4(9u, 6u, 9u, 1u), uvec4(s2.b[0][0])) && allOk;
	allOk = compare_u8vec4(uvec4(5u, 1u, 8u, 4u), uvec4(s2.b[1][0])) && allOk;
	allOk = compare_u8vec4(uvec4(4u, 1u, 6u, 3u), uvec4(s2.b[2][0])) && allOk;
	allOk = compare_int8_t(int(2), int(s2.c[0][0][0])) && allOk;
	allOk = compare_int8_t(int(2), int(s2.c[0][0][1])) && allOk;
	allOk = compare_int8_t(int(3), int(s2.c[0][0][2])) && allOk;
	allOk = compare_u8vec2(uvec2(5u, 9u), uvec2(s2.d[0][0][0])) && allOk;
	allOk = compare_u8vec2(uvec2(8u, 9u), uvec2(s2.d[0][1][0])) && allOk;
	allOk = compare_u8vec2(uvec2(9u, 6u), uvec2(s2.d[0][2][0])) && allOk;
	allOk = compare_u8vec2(uvec2(3u, 5u), uvec2(s2.d[1][0][0])) && allOk;
	allOk = compare_u8vec2(uvec2(0u, 9u), uvec2(s2.d[1][1][0])) && allOk;
	allOk = compare_u8vec2(uvec2(1u, 4u), uvec2(s2.d[1][2][0])) && allOk;
	allOk = compare_u8vec2(uvec2(4u, 0u), uvec2(s2.d[2][0][0])) && allOk;
	allOk = compare_u8vec2(uvec2(9u, 0u), uvec2(s2.d[2][1][0])) && allOk;
	allOk = compare_u8vec2(uvec2(4u, 9u), uvec2(s2.d[2][2][0])) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	u8vec2 a[2];
	lowp int b;
	u8vec3 c;
};
struct S2 {
	i8vec3 a;
	lowp uvec3 b[1][1];
	i8vec4 c[3][2][3];
};
struct S3 {
	uint8_t a[1][2];
	bvec3 b;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

shared S1 s1;
shared S2 s2;
shared S3 s3;

void main (void) {
	s1.a[0] = u8vec2(2u, 5u);
	s1.a[1] = u8vec2(1u, 9u);
	s1.b = 2;
	s1.c = u8vec3(7u, 9u, 2u);
	s2.a = i8vec3(-8, -1, 4);
	s2.b[0][0] = uvec3(9u, 0u, 2u);
	s2.c[0][0][0] = i8vec4(1, 9, 5, -4);
	s2.c[0][0][1] = i8vec4(1, -4, -4, -3);
	s2.c[0][0][2] = i8vec4(1, 5, 6, 9);
	s2.c[0][1][0] = i8vec4(0, 1, -3, 1);
	s2.c[0][1][1] = i8vec4(6, 6, 6, -8);
	s2.c[0][1][2] = i8vec4(6, 6, 5, 1);
	s2.c[1][0][0] = i8vec4(4, 6, -4, 0);
	s2.c[1][0][1] = i8vec4(1, 2, -1, 9);
	s2.c[1][0][2] = i8vec4(-9, 9, 3, -9);
	s2.c[1][1][0] = i8vec4(3, 5, 2, 3);
	s2.c[1][1][1] = i8vec4(1, -6, -5, 9);
	s2.c[1][1][2] = i8vec4(1, 5, -7, 6);
	s2.c[2][0][0] = i8vec4(-1, -9, -5, 8);
	s2.c[2][0][1] = i8vec4(5, -4, -1, -8);
	s2.c[2][0][2] = i8vec4(4, -7, 1, 4);
	s2.c[2][1][0] = i8vec4(-2, 0, -1, -3);
	s2.c[2][1][1] = i8vec4(-7, 2, 3, 2);
	s2.c[2][1][2] = i8vec4(6, -6, 8, 2);
	s3.a[0][0] = uint8_t(7u);
	s3.a[0][1] = uint8_t(4u);
	s3.b = bvec3(false, true, true);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_u8vec2(uvec2(2u, 5u), uvec2(s1.a[0])) && allOk;
	allOk = compare_u8vec2(uvec2(1u, 9u), uvec2(s1.a[1])) && allOk;
	allOk = compare_int(2, s1.b) && allOk;
	allOk = compare_u8vec3(uvec3(7u, 9u, 2u), uvec3(s1.c)) && allOk;
	allOk = compare_i8vec3(ivec3(-8, -1, 4), ivec3(s2.a)) && allOk;
	allOk = compare_uvec3(uvec3(9u, 0u, 2u), s2.b[0][0]) && allOk;
	allOk = compare_i8vec4(ivec4(1, 9, 5, -4), ivec4(s2.c[0][0][0])) && allOk;
	allOk = compare_i8vec4(ivec4(1, -4, -4, -3), ivec4(s2.c[0][0][1])) && allOk;
	allOk = compare_i8vec4(ivec4(1, 5, 6, 9), ivec4(s2.c[0][0][2])) && allOk;
	allOk = compare_i8vec4(ivec4(0, 1, -3, 1), ivec4(s2.c[0][1][0])) && allOk;
	allOk = compare_i8vec4(ivec4(6, 6, 6, -8), ivec4(s2.c[0][1][1])) && allOk;
	allOk = compare_i8vec4(ivec4(6, 6, 5, 1), ivec4(s2.c[0][1][2])) && allOk;
	allOk = compare_i8vec4(ivec4(4, 6, -4, 0), ivec4(s2.c[1][0][0])) && allOk;
	allOk = compare_i8vec4(ivec4(1, 2, -1, 9), ivec4(s2.c[1][0][1])) && allOk;
	allOk = compare_i8vec4(ivec4(-9, 9, 3, -9), ivec4(s2.c[1][0][2])) && allOk;
	allOk = compare_i8vec4(ivec4(3, 5, 2, 3), ivec4(s2.c[1][1][0])) && allOk;
	allOk = compare_i8vec4(ivec4(1, -6, -5, 9), ivec4(s2.c[1][1][1])) && allOk;
	allOk = compare_i8vec4(ivec4(1, 5, -7, 6), ivec4(s2.c[1][1][2])) && allOk;
	allOk = compare_i8vec4(ivec4(-1, -9, -5, 8), ivec4(s2.c[2][0][0])) && allOk;
	allOk = compare_i8vec4(ivec4(5, -4, -1, -8), ivec4(s2.c[2][0][1])) && allOk;
	allOk = compare_i8vec4(ivec4(4, -7, 1, 4), ivec4(s2.c[2][0][2])) && allOk;
	allOk = compare_i8vec4(ivec4(-2, 0, -1, -3), ivec4(s2.c[2][1][0])) && allOk;
	allOk = compare_i8vec4(ivec4(-7, 2, 3, 2), ivec4(s2.c[2][1][1])) && allOk;
	allOk = compare_i8vec4(ivec4(6, -6, 8, 2), ivec4(s2.c[2][1][2])) && allOk;
	allOk = compare_uint8_t(uint(7u), uint(s3.a[0][0])) && allOk;
	allOk = compare_uint8_t(uint(4u), uint(s3.a[0][1])) && allOk;
	allOk = compare_bvec3(bvec3(false, true, true), s3.b) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct S1 {
	u8vec3 a[1][3][1];
	i8vec4 b[3][2][3];
	highp mat2 c[2][1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

shared S1 s1;

void main (void) {
	s1.a[0][0][0] = u8vec3(5u, 7u, 4u);
	s1.a[0][1][0] = u8vec3(7u, 3u, 3u);
	s1.a[0][2][0] = u8vec3(5u, 0u, 3u);
	s1.b[0][0][0] = i8vec4(-6, 5, -7, 2);
	s1.b[0][0][1] = i8vec4(8, 8, 6, -8);
	s1.b[0][0][2] = i8vec4(7, -1, 2, 2);
	s1.b[0][1][0] = i8vec4(6, 1, 1, 1);
	s1.b[0][1][1] = i8vec4(6, -8, -9, 0);
	s1.b[0][1][2] = i8vec4(-1, -1, 5, 4);
	s1.b[1][0][0] = i8vec4(0, -1, -2, -9);
	s1.b[1][0][1] = i8vec4(1, 0, 8, 0);
	s1.b[1][0][2] = i8vec4(5, -7, 6, 6);
	s1.b[1][1][0] = i8vec4(7, -7, 6, -8);
	s1.b[1][1][1] = i8vec4(5, 1, -4, 0);
	s1.b[1][1][2] = i8vec4(4, -4, 0, 0);
	s1.b[2][0][0] = i8vec4(8, -5, -1, -9);
	s1.b[2][0][1] = i8vec4(-9, -1, -4, 5);
	s1.b[2][0][2] = i8vec4(1, -9, 8, 9);
	s1.b[2][1][0] = i8vec4(-6, -3, -4, 9);
	s1.b[2][1][1] = i8vec4(9, 1, 5, 9);
	s1.b[2][1][2] = i8vec4(5, -7, -3, -9);
	s1.c[0][0] = mat2(5.0, 4.0, 2.0, 3.0);
	s1.c[1][0] = mat2(3.0, 2.0, -8.0, 1.0);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_u8vec3(uvec3(5u, 7u, 4u), uvec3(s1.a[0][0][0])) && allOk;
	allOk = compare_u8vec3(uvec3(7u, 3u, 3u), uvec3(s1.a[0][1][0])) && allOk;
	allOk = compare_u8vec3(uvec3(5u, 0u, 3u), uvec3(s1.a[0][2][0])) && allOk;
	allOk = compare_i8vec4(ivec4(-6, 5, -7, 2), ivec4(s1.b[0][0][0])) && allOk;
	allOk = compare_i8vec4(ivec4(8, 8, 6, -8), ivec4(s1.b[0][0][1])) && allOk;
	allOk = compare_i8vec4(ivec4(7, -1, 2, 2), ivec4(s1.b[0][0][2])) && allOk;
	allOk = compare_i8vec4(ivec4(6, 1, 1, 1), ivec4(s1.b[0][1][0])) && allOk;
	allOk = compare_i8vec4(ivec4(6, -8, -9, 0), ivec4(s1.b[0][1][1])) && allOk;
	allOk = compare_i8vec4(ivec4(-1, -1, 5, 4), ivec4(s1.b[0][1][2])) && allOk;
	allOk = compare_i8vec4(ivec4(0, -1, -2, -9), ivec4(s1.b[1][0][0])) && allOk;
	allOk = compare_i8vec4(ivec4(1, 0, 8, 0), ivec4(s1.b[1][0][1])) && allOk;
	allOk = compare_i8vec4(ivec4(5, -7, 6, 6), ivec4(s1.b[1][0][2])) && allOk;
	allOk = compare_i8vec4(ivec4(7, -7, 6, -8), ivec4(s1.b[1][1][0])) && allOk;
	allOk = compare_i8vec4(ivec4(5, 1, -4, 0), ivec4(s1.b[1][1][1])) && allOk;
	allOk = compare_i8vec4(ivec4(4, -4, 0, 0), ivec4(s1.b[1][1][2])) && allOk;
	allOk = compare_i8vec4(ivec4(8, -5, -1, -9), ivec4(s1.b[2][0][0])) && allOk;
	allOk = compare_i8vec4(ivec4(-9, -1, -4, 5), ivec4(s1.b[2][0][1])) && allOk;
	allOk = compare_i8vec4(ivec4(1, -9, 8, 9), ivec4(s1.b[2][0][2])) && allOk;
	allOk = compare_i8vec4(ivec4(-6, -3, -4, 9), ivec4(s1.b[2][1][0])) && allOk;
	allOk = compare_i8vec4(ivec4(9, 1, 5, 9), ivec4(s1.b[2][1][1])) && allOk;
	allOk = compare_i8vec4(ivec4(5, -7, -3, -9), ivec4(s1.b[2][1][2])) && allOk;
	allOk = compare_mat2(mat2(5.0, 4.0, 2.0, 3.0), s1.c[0][0]) && allOk;
	allOk = compare_mat2(mat2(3.0, 2.0, -8.0, 1.0), s1.c[1][0]) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	int8_t mA;
	highp mat3x2 mB;
	i8vec4 mC;
};
struct sB
{
	i8vec2 mA;
	int8_t mB;
	u8vec4 mC;
};
struct sC
{
	sA mA;
	sB mB;
	u8vec2 mC;
};
struct sD
{
	sC mA;
};
struct sE
{
	i8vec4 mA;
};
struct sF
{
	bvec3 mA;
};
struct sG
{
	i8vec4 mA;
	mediump vec3 mB;
	i8vec3 mC;
};
struct S1 {
	lowp uint a;
	mediump vec4 b;
};
struct S2 {
	sD a;
	sE b;
	sF c;
	sG d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a = 0u;
	s1.b = vec4(8.0, 8.0, 0.0, -4.0);
	s2.a.mA.mA.mA = int8_t(-5);
	s2.a.mA.mA.mB = mat3x2(9.0, -4.0, -6.0, -1.0, -1.0, -2.0);
	s2.a.mA.mA.mC = i8vec4(1, 6, 5, 7);
	s2.a.mA.mB.mA = i8vec2(-2, -4);
	s2.a.mA.mB.mB = int8_t(-9);
	s2.a.mA.mB.mC = u8vec4(6u, 5u, 3u, 0u);
	s2.a.mA.mC = u8vec2(2u, 4u);
	s2.b.mA = i8vec4(0, 9, -1, -1);
	s2.c.mA = bvec3(true, true, true);
	s2.d.mA = i8vec4(-3, 1, -4, -9);
	s2.d.mB = vec3(1.0, -4.0, 0.0);
	s2.d.mC = i8vec3(2, 0, 6);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_uint(0u, s1.a) && allOk;
	allOk = compare_vec4(vec4(8.0, 8.0, 0.0, -4.0), s1.b) && allOk;
	allOk = compare_int8_t(int(-5), int(s2.a.mA.mA.mA)) && allOk;
	allOk = compare_mat3x2(mat3x2(9.0, -4.0, -6.0, -1.0, -1.0, -2.0), s2.a.mA.mA.mB) && allOk;
	allOk = compare_i8vec4(ivec4(1, 6, 5, 7), ivec4(s2.a.mA.mA.mC)) && allOk;
	allOk = compare_i8vec2(ivec2(-2, -4), ivec2(s2.a.mA.mB.mA)) && allOk;
	allOk = compare_int8_t(int(-9), int(s2.a.mA.mB.mB)) && allOk;
	allOk = compare_u8vec4(uvec4(6u, 5u, 3u, 0u), uvec4(s2.a.mA.mB.mC)) && allOk;
	allOk = compare_u8vec2(uvec2(2u, 4u), uvec2(s2.a.mA.mC)) && allOk;
	allOk = compare_i8vec4(ivec4(0, 9, -1, -1), ivec4(s2.b.mA)) && allOk;
	allOk = compare_bvec3(bvec3(true, true, true), s2.c.mA) && allOk;
	allOk = compare_i8vec4(ivec4(-3, 1, -4, -9), ivec4(s2.d.mA)) && allOk;
	allOk = compare_vec3(vec3(1.0, -4.0, 0.0), s2.d.mB) && allOk;
	allOk = compare_i8vec3(ivec3(2, 0, 6), ivec3(s2.d.mC)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	lowp mat4x3 mA;
};
struct sB
{
	uint8_t mA;
	int8_t mB;
};
struct sC
{
	sB mA;
};
struct sD
{
	sA mA;
	sC mB;
};
struct S1 {
	sD a;
	uint8_t b;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

shared S1 s1;

void main (void) {
	s1.a.mA.mA = mat4x3(6.0, 6.0, -6.0, -3.0, -1.0, -9.0, 5.0, -7.0, -9.0, 8.0, -4.0, -8.0);
	s1.a.mB.mA.mA = uint8_t(4u);
	s1.a.mB.mA.mB = int8_t(-8);
	s1.b = uint8_t(4u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_mat4x3(mat4x3(6.0, 6.0, -6.0, -3.0, -1.0, -9.0, 5.0, -7.0, -9.0, 8.0, -4.0, -8.0), s1.a.mA.mA) && allOk;
	allOk = compare_uint8_t(uint(4u), uint(s1.a.mB.mA.mA)) && allOk;
	allOk = compare_int8_t(int(-8), int(s1.a.mB.mA.mB)) && allOk;
	allOk = compare_uint8_t(uint(4u), uint(s1.b)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	int8_t mA;
};
struct sB
{
	i8vec4 mA;
	u8vec2 mB;
	sA mC;
};
struct sC
{
	int8_t mA;
	highp float mB;
	i8vec2 mC;
};
struct sD
{
	mediump vec4 mA;
	u8vec3 mB;
	highp uvec3 mC;
};
struct sE
{
	mediump vec3 mA;
};
struct sF
{
	sC mA;
	sD mB;
	sE mC;
};
struct sG
{
	sB mA;
	sF mB;
	bvec3 mC;
};
struct sH
{
	i8vec2 mA;
};
struct sI
{
	u8vec4 mA;
	mediump mat2x3 mB;
};
struct sJ
{
	i8vec4 mA;
	highp mat4x3 mB;
};
struct sK
{
	sH mA;
	sI mB;
	sJ mC;
};
struct sL
{
	i8vec2 mA;
	sK mB;
};
struct sM
{
	int8_t mA;
	u8vec4 mB;
};
struct sN
{
	lowp uvec3 mA;
	sM mB;
};
struct sO
{
	u8vec4 mA;
	int8_t mB;
	uint8_t mC;
};
struct sP
{
	highp vec3 mA;
	u8vec4 mB;
	mediump ivec3 mC;
};
struct sQ
{
	bvec3 mA;
	mediump vec2 mB;
	mediump vec3 mC;
};
struct sR
{
	sO mA;
	sP mB;
	sQ mC;
};
struct sS
{
	u8vec3 mA;
	u8vec3 mB;
	u8vec4 mC;
};
struct sT
{
	sS mA;
	i8vec3 mB;
	u8vec3 mC;
};
struct sU
{
	sN mA;
	sR mB;
	sT mC;
};
struct sV
{
	int8_t mA;
	u8vec2 mB;
};
struct sW
{
	u8vec3 mA;
};
struct sX
{
	mediump uvec4 mA;
	lowp mat4 mB;
};
struct sY
{
	sV mA;
	sW mB;
	sX mC;
};
struct sZ
{
	sY mA;
};
struct S1 {
	sG a;
	sL b;
	u8vec3 c;
};
struct S2 {
	sU a;
	mediump mat2 b;
	sZ c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a.mA.mA = i8vec4(0, 2, -8, 6);
	s1.a.mA.mB = u8vec2(2u, 5u);
	s1.a.mA.mC.mA = int8_t(-6);
	s1.a.mB.mA.mA = int8_t(1);
	s1.a.mB.mA.mB = 9.0;
	s1.a.mB.mA.mC = i8vec2(-4, -3);
	s1.a.mB.mB.mA = vec4(4.0, 4.0, 9.0, -9.0);
	s1.a.mB.mB.mB = u8vec3(0u, 7u, 4u);
	s1.a.mB.mB.mC = uvec3(8u, 9u, 8u);
	s1.a.mB.mC.mA = vec3(7.0, 2.0, -1.0);
	s1.a.mC = bvec3(true, false, true);
	s1.b.mA = i8vec2(3, -5);
	s1.b.mB.mA.mA = i8vec2(-3, -1);
	s1.b.mB.mB.mA = u8vec4(5u, 7u, 4u, 5u);
	s1.b.mB.mB.mB = mat2x3(3.0, -9.0, -4.0, 3.0, 9.0, 1.0);
	s1.b.mB.mC.mA = i8vec4(3, -9, -5, 9);
	s1.b.mB.mC.mB = mat4x3(-7.0, -8.0, 1.0, 6.0, 0.0, -3.0, 4.0, -7.0, -1.0, 5.0, -3.0, 0.0);
	s1.c = u8vec3(8u, 7u, 2u);
	s2.a.mA.mA = uvec3(8u, 3u, 0u);
	s2.a.mA.mB.mA = int8_t(7);
	s2.a.mA.mB.mB = u8vec4(8u, 0u, 9u, 2u);
	s2.a.mB.mA.mA = u8vec4(3u, 3u, 6u, 9u);
	s2.a.mB.mA.mB = int8_t(-7);
	s2.a.mB.mA.mC = uint8_t(5u);
	s2.a.mB.mB.mA = vec3(-5.0, 0.0, 1.0);
	s2.a.mB.mB.mB = u8vec4(9u, 5u, 7u, 3u);
	s2.a.mB.mB.mC = ivec3(-5, 1, 5);
	s2.a.mB.mC.mA = bvec3(false, true, false);
	s2.a.mB.mC.mB = vec2(8.0, 0.0);
	s2.a.mB.mC.mC = vec3(-7.0, -8.0, -7.0);
	s2.a.mC.mA.mA = u8vec3(4u, 5u, 3u);
	s2.a.mC.mA.mB = u8vec3(0u, 3u, 9u);
	s2.a.mC.mA.mC = u8vec4(3u, 3u, 2u, 0u);
	s2.a.mC.mB = i8vec3(-3, 7, -5);
	s2.a.mC.mC = u8vec3(4u, 7u, 9u);
	s2.b = mat2(-3.0, -8.0, 6.0, -2.0);
	s2.c.mA.mA.mA = int8_t(5);
	s2.c.mA.mA.mB = u8vec2(7u, 2u);
	s2.c.mA.mB.mA = u8vec3(6u, 9u, 3u);
	s2.c.mA.mC.mA = uvec4(7u, 8u, 3u, 7u);
	s2.c.mA.mC.mB = mat4(4.0, 0.0, 7.0, 4.0, 8.0, -9.0, -8.0, 6.0, -4.0, -4.0, -2.0, 5.0, 0.0, 4.0, 9.0, 5.0);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_i8vec4(ivec4(0, 2, -8, 6), ivec4(s1.a.mA.mA)) && allOk;
	allOk = compare_u8vec2(uvec2(2u, 5u), uvec2(s1.a.mA.mB)) && allOk;
	allOk = compare_int8_t(int(-6), int(s1.a.mA.mC.mA)) && allOk;
	allOk = compare_int8_t(int(1), int(s1.a.mB.mA.mA)) && allOk;
	allOk = compare_float(9.0, s1.a.mB.mA.mB) && allOk;
	allOk = compare_i8vec2(ivec2(-4, -3), ivec2(s1.a.mB.mA.mC)) && allOk;
	allOk = compare_vec4(vec4(4.0, 4.0, 9.0, -9.0), s1.a.mB.mB.mA) && allOk;
	allOk = compare_u8vec3(uvec3(0u, 7u, 4u), uvec3(s1.a.mB.mB.mB)) && allOk;
	allOk = compare_uvec3(uvec3(8u, 9u, 8u), s1.a.mB.mB.mC) && allOk;
	allOk = compare_vec3(vec3(7.0, 2.0, -1.0), s1.a.mB.mC.mA) && allOk;
	allOk = compare_bvec3(bvec3(true, false, true), s1.a.mC) && allOk;
	allOk = compare_i8vec2(ivec2(3, -5), ivec2(s1.b.mA)) && allOk;
	allOk = compare_i8vec2(ivec2(-3, -1), ivec2(s1.b.mB.mA.mA)) && allOk;
	allOk = compare_u8vec4(uvec4(5u, 7u, 4u, 5u), uvec4(s1.b.mB.mB.mA)) && allOk;
	allOk = compare_mat2x3(mat2x3(3.0, -9.0, -4.0, 3.0, 9.0, 1.0), s1.b.mB.mB.mB) && allOk;
	allOk = compare_i8vec4(ivec4(3, -9, -5, 9), ivec4(s1.b.mB.mC.mA)) && allOk;
	allOk = compare_mat4x3(mat4x3(-7.0, -8.0, 1.0, 6.0, 0.0, -3.0, 4.0, -7.0, -1.0, 5.0, -3.0, 0.0), s1.b.mB.mC.mB) && allOk;
	allOk = compare_u8vec3(uvec3(8u, 7u, 2u), uvec3(s1.c)) && allOk;
	allOk = compare_uvec3(uvec3(8u, 3u, 0u), s2.a.mA.mA) && allOk;
	allOk = compare_int8_t(int(7), int(s2.a.mA.mB.mA)) && allOk;
	allOk = compare_u8vec4(uvec4(8u, 0u, 9u, 2u), uvec4(s2.a.mA.mB.mB)) && allOk;
	allOk = compare_u8vec4(uvec4(3u, 3u, 6u, 9u), uvec4(s2.a.mB.mA.mA)) && allOk;
	allOk = compare_int8_t(int(-7), int(s2.a.mB.mA.mB)) && allOk;
	allOk = compare_uint8_t(uint(5u), uint(s2.a.mB.mA.mC)) && allOk;
	allOk = compare_vec3(vec3(-5.0, 0.0, 1.0), s2.a.mB.mB.mA) && allOk;
	allOk = compare_u8vec4(uvec4(9u, 5u, 7u, 3u), uvec4(s2.a.mB.mB.mB)) && allOk;
	allOk = compare_ivec3(ivec3(-5, 1, 5), s2.a.mB.mB.mC) && allOk;
	allOk = compare_bvec3(bvec3(false, true, false), s2.a.mB.mC.mA) && allOk;
	allOk = compare_vec2(vec2(8.0, 0.0), s2.a.mB.mC.mB) && allOk;
	allOk = compare_vec3(vec3(-7.0, -8.0, -7.0), s2.a.mB.mC.mC) && allOk;
	allOk = compare_u8vec3(uvec3(4u, 5u, 3u), uvec3(s2.a.mC.mA.mA)) && allOk;
	allOk = compare_u8vec3(uvec3(0u, 3u, 9u), uvec3(s2.a.mC.mA.mB)) && allOk;
	allOk = compare_u8vec4(uvec4(3u, 3u, 2u, 0u), uvec4(s2.a.mC.mA.mC)) && allOk;
	allOk = compare_i8vec3(ivec3(-3, 7, -5), ivec3(s2.a.mC.mB)) && allOk;
	allOk = compare_u8vec3(uvec3(4u, 7u, 9u), uvec3(s2.a.mC.mC)) && allOk;
	allOk = compare_mat2(mat2(-3.0, -8.0, 6.0, -2.0), s2.b) && allOk;
	allOk = compare_int8_t(int(5), int(s2.c.mA.mA.mA)) && allOk;
	allOk = compare_u8vec2(uvec2(7u, 2u), uvec2(s2.c.mA.mA.mB)) && allOk;
	allOk = compare_u8vec3(uvec3(6u, 9u, 3u), uvec3(s2.c.mA.mB.mA)) && allOk;
	allOk = compare_uvec4(uvec4(7u, 8u, 3u, 7u), s2.c.mA.mC.mA) && allOk;
	allOk = compare_mat4(mat4(4.0, 0.0, 7.0, 4.0, 8.0, -9.0, -8.0, 6.0, -4.0, -4.0, -2.0, 5.0, 0.0, 4.0, 9.0, 5.0), s2.c.mA.mC.mB) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	u8vec4 mA;
	i8vec2 mB;
};
struct sB
{
	u8vec3 mA;
	mediump uvec3 mB;
	int8_t mC;
};
struct sC
{
	sA mA;
	sB mB;
	u8vec3 mC;
};
struct sD
{
	sC mA;
};
struct sE
{
	i8vec3 mA;
};
struct sF
{
	int8_t mA;
	sE mB;
	u8vec2 mC;
};
struct sG
{
	sF mA;
};
struct sH
{
	mediump ivec4 mA;
	u8vec2 mB;
	u8vec4 mC;
};
struct sI
{
	mediump int mA;
	uint8_t mB;
};
struct sJ
{
	sH mA;
	sI mB;
};
struct sK
{
	sJ mA;
};
struct sL
{
	int8_t mA;
	int8_t mB;
};
struct sM
{
	lowp int mA;
	i8vec3 mB;
	highp mat4x2 mC;
};
struct sN
{
	sL mA;
	sM mB;
};
struct sO
{
	highp mat2x3 mA;
	u8vec3 mB;
	i8vec2 mC;
};
struct sP
{
	int8_t mA;
	sO mB;
};
struct sQ
{
	sN mA;
	sP mB;
};
struct S1 {
	sD a;
	i8vec2 b;
};
struct S2 {
	sG a;
	sK b;
	sQ c;
	uint8_t d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a.mA.mA.mA = u8vec4(1u, 9u, 8u, 5u);
	s1.a.mA.mA.mB = i8vec2(1, -7);
	s1.a.mA.mB.mA = u8vec3(8u, 6u, 2u);
	s1.a.mA.mB.mB = uvec3(7u, 6u, 0u);
	s1.a.mA.mB.mC = int8_t(2);
	s1.a.mA.mC = u8vec3(2u, 5u, 6u);
	s1.b = i8vec2(7, 3);
	s2.a.mA.mA = int8_t(-3);
	s2.a.mA.mB.mA = i8vec3(7, 4, -2);
	s2.a.mA.mC = u8vec2(7u, 2u);
	s2.b.mA.mA.mA = ivec4(-5, 1, -6, 8);
	s2.b.mA.mA.mB = u8vec2(8u, 2u);
	s2.b.mA.mA.mC = u8vec4(3u, 4u, 2u, 4u);
	s2.b.mA.mB.mA = 7;
	s2.b.mA.mB.mB = uint8_t(8u);
	s2.c.mA.mA.mA = int8_t(2);
	s2.c.mA.mA.mB = int8_t(9);
	s2.c.mA.mB.mA = -3;
	s2.c.mA.mB.mB = i8vec3(3, 1, 1);
	s2.c.mA.mB.mC = mat4x2(-9.0, -3.0, -9.0, -7.0, -4.0, -4.0, -6.0, 1.0);
	s2.c.mB.mA = int8_t(3);
	s2.c.mB.mB.mA = mat2x3(-4.0, -4.0, 0.0, 1.0, -3.0, -9.0);
	s2.c.mB.mB.mB = u8vec3(2u, 6u, 1u);
	s2.c.mB.mB.mC = i8vec2(-5, 2);
	s2.d = uint8_t(5u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_u8vec4(uvec4(1u, 9u, 8u, 5u), uvec4(s1.a.mA.mA.mA)) && allOk;
	allOk = compare_i8vec2(ivec2(1, -7), ivec2(s1.a.mA.mA.mB)) && allOk;
	allOk = compare_u8vec3(uvec3(8u, 6u, 2u), uvec3(s1.a.mA.mB.mA)) && allOk;
	allOk = compare_uvec3(uvec3(7u, 6u, 0u), s1.a.mA.mB.mB) && allOk;
	allOk = compare_int8_t(int(2), int(s1.a.mA.mB.mC)) && allOk;
	allOk = compare_u8vec3(uvec3(2u, 5u, 6u), uvec3(s1.a.mA.mC)) && allOk;
	allOk = compare_i8vec2(ivec2(7, 3), ivec2(s1.b)) && allOk;
	allOk = compare_int8_t(int(-3), int(s2.a.mA.mA)) && allOk;
	allOk = compare_i8vec3(ivec3(7, 4, -2), ivec3(s2.a.mA.mB.mA)) && allOk;
	allOk = compare_u8vec2(uvec2(7u, 2u), uvec2(s2.a.mA.mC)) && allOk;
	allOk = compare_ivec4(ivec4(-5, 1, -6, 8), s2.b.mA.mA.mA) && allOk;
	allOk = compare_u8vec2(uvec2(8u, 2u), uvec2(s2.b.mA.mA.mB)) && allOk;
	allOk = compare_u8vec4(uvec4(3u, 4u, 2u, 4u), uvec4(s2.b.mA.mA.mC)) && allOk;
	allOk = compare_int(7, s2.b.mA.mB.mA) && allOk;
	allOk = compare_uint8_t(uint(8u), uint(s2.b.mA.mB.mB)) && allOk;
	allOk = compare_int8_t(int(2), int(s2.c.mA.mA.mA)) && allOk;
	allOk = compare_int8_t(int(9), int(s2.c.mA.mA.mB)) && allOk;
	allOk = compare_int(-3, s2.c.mA.mB.mA) && allOk;
	allOk = compare_i8vec3(ivec3(3, 1, 1), ivec3(s2.c.mA.mB.mB)) && allOk;
	allOk = compare_mat4x2(mat4x2(-9.0, -3.0, -9.0, -7.0, -4.0, -4.0, -6.0, 1.0), s2.c.mA.mB.mC) && allOk;
	allOk = compare_int8_t(int(3), int(s2.c.mB.mA)) && allOk;
	allOk = compare_mat2x3(mat2x3(-4.0, -4.0, 0.0, 1.0, -3.0, -9.0), s2.c.mB.mB.mA) && allOk;
	allOk = compare_u8vec3(uvec3(2u, 6u, 1u), uvec3(s2.c.mB.mB.mB)) && allOk;
	allOk = compare_i8vec2(ivec2(-5, 2), ivec2(s2.c.mB.mB.mC)) && allOk;
	allOk = compare_uint8_t(uint(5u), uint(s2.d)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	mediump ivec2 mA;
	u8vec4 mB;
	highp uvec4 mC;
};
struct sB
{
	sA mA;
	u8vec2 mB;
};
struct sC
{
	mediump mat2x3 mA;
	u8vec4 mB;
	highp mat4x3 mC;
};
struct sD
{
	sC mA;
	int8_t mB;
	lowp ivec2 mC;
};
struct sE
{
	sB mA;
	sD mB;
	i8vec3 mC;
};
struct sF
{
	int8_t mA;
	uint8_t mB;
};
struct sG
{
	u8vec4 mA;
};
struct sH
{
	sF mA;
	highp mat4 mB;
	sG mC;
};
struct sI
{
	mediump vec4 mA;
	u8vec2 mB;
	u8vec3 mC;
};
struct sJ
{
	lowp mat4x3 mA;
	mediump mat4x3 mB;
	lowp uvec4 mC;
};
struct sK
{
	sI mA;
	highp ivec4 mB;
	sJ mC;
};
struct sL
{
	sH mA;
	sK mB;
};
struct sM
{
	highp int mA;
	mediump int mB;
	i8vec3 mC;
};
struct sN
{
	sM mA;
	i8vec2 mB;
};
struct sO
{
	int8_t mA;
};
struct sP
{
	i8vec2 mA;
	highp vec2 mB;
	lowp mat2 mC;
};
struct sQ
{
	i8vec4 mA;
	u8vec4 mB;
};
struct sR
{
	sO mA;
	sP mB;
	sQ mC;
};
struct sS
{
	sN mA;
	sR mB;
};
struct sT
{
	i8vec4 mA;
	i8vec3 mB;
};
struct sU
{
	sT mA;
};
struct sV
{
	mediump uint mA;
	sU mB;
};
struct sW
{
	uint8_t mA;
};
struct sX
{
	u8vec2 mA;
	u8vec4 mB;
};
struct sY
{
	u8vec3 mA;
	sW mB;
	sX mC;
};
struct sZ
{
	highp uvec4 mA;
	sY mB;
};
struct sAA
{
	mediump vec3 mA;
};
struct S1 {
	sE a;
	i8vec2 b;
	sL c;
};
struct S2 {
	highp uvec4 a;
	sS b;
	sV c;
	sZ d;
};
struct S3 {
	i8vec4 a;
	sAA b;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

shared S1 s1;
shared S2 s2;
shared S3 s3;

void main (void) {
	s1.a.mA.mA.mA = ivec2(2, 7);
	s1.a.mA.mA.mB = u8vec4(5u, 9u, 3u, 9u);
	s1.a.mA.mA.mC = uvec4(6u, 5u, 8u, 8u);
	s1.a.mA.mB = u8vec2(5u, 1u);
	s1.a.mB.mA.mA = mat2x3(-2.0, 0.0, 9.0, -1.0, -9.0, -6.0);
	s1.a.mB.mA.mB = u8vec4(8u, 6u, 1u, 6u);
	s1.a.mB.mA.mC = mat4x3(0.0, 2.0, 5.0, 6.0, 4.0, 1.0, -7.0, -5.0, 1.0, 2.0, -7.0, 5.0);
	s1.a.mB.mB = int8_t(-6);
	s1.a.mB.mC = ivec2(-9, -8);
	s1.a.mC = i8vec3(8, -5, 9);
	s1.b = i8vec2(-9, -2);
	s1.c.mA.mA.mA = int8_t(6);
	s1.c.mA.mA.mB = uint8_t(2u);
	s1.c.mA.mB = mat4(8.0, 3.0, 9.0, 7.0, 9.0, 7.0, 3.0, -3.0, 8.0, 1.0, -8.0, -3.0, -3.0, -3.0, 3.0, 3.0);
	s1.c.mA.mC.mA = u8vec4(1u, 1u, 5u, 4u);
	s1.c.mB.mA.mA = vec4(-4.0, 4.0, 8.0, 2.0);
	s1.c.mB.mA.mB = u8vec2(7u, 0u);
	s1.c.mB.mA.mC = u8vec3(1u, 0u, 9u);
	s1.c.mB.mB = ivec4(-2, 1, 1, -7);
	s1.c.mB.mC.mA = mat4x3(-9.0, -6.0, 4.0, 0.0, -3.0, -3.0, 9.0, -1.0, -8.0, -9.0, -7.0, -2.0);
	s1.c.mB.mC.mB = mat4x3(-6.0, 0.0, 5.0, 8.0, 5.0, 5.0, 3.0, 2.0, -8.0, 5.0, -7.0, 6.0);
	s1.c.mB.mC.mC = uvec4(3u, 6u, 8u, 4u);
	s2.a = uvec4(4u, 2u, 4u, 8u);
	s2.b.mA.mA.mA = -9;
	s2.b.mA.mA.mB = 4;
	s2.b.mA.mA.mC = i8vec3(7, 7, -1);
	s2.b.mA.mB = i8vec2(-7, -5);
	s2.b.mB.mA.mA = int8_t(4);
	s2.b.mB.mB.mA = i8vec2(-5, -9);
	s2.b.mB.mB.mB = vec2(7.0, 4.0);
	s2.b.mB.mB.mC = mat2(-7.0, -6.0, -3.0, 7.0);
	s2.b.mB.mC.mA = i8vec4(9, 0, 8, 1);
	s2.b.mB.mC.mB = u8vec4(2u, 5u, 0u, 7u);
	s2.c.mA = 2u;
	s2.c.mB.mA.mA = i8vec4(1, 4, -3, -2);
	s2.c.mB.mA.mB = i8vec3(9, -5, -3);
	s2.d.mA = uvec4(6u, 8u, 4u, 2u);
	s2.d.mB.mA = u8vec3(2u, 5u, 3u);
	s2.d.mB.mB.mA = uint8_t(6u);
	s2.d.mB.mC.mA = u8vec2(3u, 7u);
	s2.d.mB.mC.mB = u8vec4(8u, 5u, 3u, 1u);
	s3.a = i8vec4(3, 5, 3, 3);
	s3.b.mA = vec3(2.0, 0.0, 5.0);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_ivec2(ivec2(2, 7), s1.a.mA.mA.mA) && allOk;
	allOk = compare_u8vec4(uvec4(5u, 9u, 3u, 9u), uvec4(s1.a.mA.mA.mB)) && allOk;
	allOk = compare_uvec4(uvec4(6u, 5u, 8u, 8u), s1.a.mA.mA.mC) && allOk;
	allOk = compare_u8vec2(uvec2(5u, 1u), uvec2(s1.a.mA.mB)) && allOk;
	allOk = compare_mat2x3(mat2x3(-2.0, 0.0, 9.0, -1.0, -9.0, -6.0), s1.a.mB.mA.mA) && allOk;
	allOk = compare_u8vec4(uvec4(8u, 6u, 1u, 6u), uvec4(s1.a.mB.mA.mB)) && allOk;
	allOk = compare_mat4x3(mat4x3(0.0, 2.0, 5.0, 6.0, 4.0, 1.0, -7.0, -5.0, 1.0, 2.0, -7.0, 5.0), s1.a.mB.mA.mC) && allOk;
	allOk = compare_int8_t(int(-6), int(s1.a.mB.mB)) && allOk;
	allOk = compare_ivec2(ivec2(-9, -8), s1.a.mB.mC) && allOk;
	allOk = compare_i8vec3(ivec3(8, -5, 9), ivec3(s1.a.mC)) && allOk;
	allOk = compare_i8vec2(ivec2(-9, -2), ivec2(s1.b)) && allOk;
	allOk = compare_int8_t(int(6), int(s1.c.mA.mA.mA)) && allOk;
	allOk = compare_uint8_t(uint(2u), uint(s1.c.mA.mA.mB)) && allOk;
	allOk = compare_mat4(mat4(8.0, 3.0, 9.0, 7.0, 9.0, 7.0, 3.0, -3.0, 8.0, 1.0, -8.0, -3.0, -3.0, -3.0, 3.0, 3.0), s1.c.mA.mB) && allOk;
	allOk = compare_u8vec4(uvec4(1u, 1u, 5u, 4u), uvec4(s1.c.mA.mC.mA)) && allOk;
	allOk = compare_vec4(vec4(-4.0, 4.0, 8.0, 2.0), s1.c.mB.mA.mA) && allOk;
	allOk = compare_u8vec2(uvec2(7u, 0u), uvec2(s1.c.mB.mA.mB)) && allOk;
	allOk = compare_u8vec3(uvec3(1u, 0u, 9u), uvec3(s1.c.mB.mA.mC)) && allOk;
	allOk = compare_ivec4(ivec4(-2, 1, 1, -7), s1.c.mB.mB) && allOk;
	allOk = compare_mat4x3(mat4x3(-9.0, -6.0, 4.0, 0.0, -3.0, -3.0, 9.0, -1.0, -8.0, -9.0, -7.0, -2.0), s1.c.mB.mC.mA) && allOk;
	allOk = compare_mat4x3(mat4x3(-6.0, 0.0, 5.0, 8.0, 5.0, 5.0, 3.0, 2.0, -8.0, 5.0, -7.0, 6.0), s1.c.mB.mC.mB) && allOk;
	allOk = compare_uvec4(uvec4(3u, 6u, 8u, 4u), s1.c.mB.mC.mC) && allOk;
	allOk = compare_uvec4(uvec4(4u, 2u, 4u, 8u), s2.a) && allOk;
	allOk = compare_int(-9, s2.b.mA.mA.mA) && allOk;
	allOk = compare_int(4, s2.b.mA.mA.mB) && allOk;
	allOk = compare_i8vec3(ivec3(7, 7, -1), ivec3(s2.b.mA.mA.mC)) && allOk;
	allOk = compare_i8vec2(ivec2(-7, -5), ivec2(s2.b.mA.mB)) && allOk;
	allOk = compare_int8_t(int(4), int(s2.b.mB.mA.mA)) && allOk;
	allOk = compare_i8vec2(ivec2(-5, -9), ivec2(s2.b.mB.mB.mA)) && allOk;
	allOk = compare_vec2(vec2(7.0, 4.0), s2.b.mB.mB.mB) && allOk;
	allOk = compare_mat2(mat2(-7.0, -6.0, -3.0, 7.0), s2.b.mB.mB.mC) && allOk;
	allOk = compare_i8vec4(ivec4(9, 0, 8, 1), ivec4(s2.b.mB.mC.mA)) && allOk;
	allOk = compare_u8vec4(uvec4(2u, 5u, 0u, 7u), uvec4(s2.b.mB.mC.mB)) && allOk;
	allOk = compare_uint(2u, s2.c.mA) && allOk;
	allOk = compare_i8vec4(ivec4(1, 4, -3, -2), ivec4(s2.c.mB.mA.mA)) && allOk;
	allOk = compare_i8vec3(ivec3(9, -5, -3), ivec3(s2.c.mB.mA.mB)) && allOk;
	allOk = compare_uvec4(uvec4(6u, 8u, 4u, 2u), s2.d.mA) && allOk;
	allOk = compare_u8vec3(uvec3(2u, 5u, 3u), uvec3(s2.d.mB.mA)) && allOk;
	allOk = compare_uint8_t(uint(6u), uint(s2.d.mB.mB.mA)) && allOk;
	allOk = compare_u8vec2(uvec2(3u, 7u), uvec2(s2.d.mB.mC.mA)) && allOk;
	allOk = compare_u8vec4(uvec4(8u, 5u, 3u, 1u), uvec4(s2.d.mB.mC.mB)) && allOk;
	allOk = compare_i8vec4(ivec4(3, 5, 3, 3), ivec4(s3.a)) && allOk;
	allOk = compare_vec3(vec3(2.0, 0.0, 5.0), s3.b.mA) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	i8vec2 mA;
	u8vec4 mB;
	i8vec4 mC;
};
struct sB
{
	lowp uvec4 mA;
	i8vec4 mB;
};
struct sC
{
	lowp vec4 mA;
	i8vec3 mB;
};
struct sD
{
	sA mA;
	sB mB;
	sC mC;
};
struct sE
{
	sD mA;
};
struct sF
{
	lowp uvec2 mA;
	int8_t mB;
	bvec2 mC;
};
struct sG
{
	sF mA;
};
struct sH
{
	u8vec4 mA;
	int8_t mB;
	bvec3 mC;
};
struct sI
{
	u8vec2 mA;
	highp ivec4 mB;
	sH mC;
};
struct sJ
{
	highp mat3 mA;
};
struct sK
{
	u8vec4 mA;
	i8vec2 mB;
};
struct sL
{
	sJ mA;
	sK mB;
};
struct sM
{
	sG mA;
	sI mB;
	sL mC;
};
struct sN
{
	i8vec4 mA;
	uint8_t mB;
};
struct sO
{
	sN mA;
};
struct sP
{
	sO mA;
};
struct sQ
{
	i8vec2 mA;
	int8_t mB;
};
struct S1 {
	sE a;
	i8vec2 b;
};
struct S2 {
	sM a;
	mediump ivec3 b;
	sP c;
};
struct S3 {
	int8_t a;
	sQ b;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

shared S1 s1;
shared S2 s2;
shared S3 s3;

void main (void) {
	s1.a.mA.mA.mA = i8vec2(2, -3);
	s1.a.mA.mA.mB = u8vec4(2u, 9u, 1u, 4u);
	s1.a.mA.mA.mC = i8vec4(-2, -5, -3, -3);
	s1.a.mA.mB.mA = uvec4(9u, 6u, 8u, 9u);
	s1.a.mA.mB.mB = i8vec4(3, 3, -4, 8);
	s1.a.mA.mC.mA = vec4(-7.0, -9.0, -3.0, 4.0);
	s1.a.mA.mC.mB = i8vec3(-3, -7, -7);
	s1.b = i8vec2(-1, 9);
	s2.a.mA.mA.mA = uvec2(7u, 8u);
	s2.a.mA.mA.mB = int8_t(-4);
	s2.a.mA.mA.mC = bvec2(true, false);
	s2.a.mB.mA = u8vec2(7u, 3u);
	s2.a.mB.mB = ivec4(-3, -5, 4, 3);
	s2.a.mB.mC.mA = u8vec4(5u, 4u, 7u, 8u);
	s2.a.mB.mC.mB = int8_t(-3);
	s2.a.mB.mC.mC = bvec3(true, false, true);
	s2.a.mC.mA.mA = mat3(6.0, -5.0, -9.0, 2.0, 9.0, 7.0, 3.0, 6.0, 2.0);
	s2.a.mC.mB.mA = u8vec4(3u, 0u, 9u, 8u);
	s2.a.mC.mB.mB = i8vec2(0, 9);
	s2.b = ivec3(-2, -1, -4);
	s2.c.mA.mA.mA = i8vec4(-8, 0, 6, -5);
	s2.c.mA.mA.mB = uint8_t(9u);
	s3.a = int8_t(-7);
	s3.b.mA = i8vec2(-1, 7);
	s3.b.mB = int8_t(-2);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_i8vec2(ivec2(2, -3), ivec2(s1.a.mA.mA.mA)) && allOk;
	allOk = compare_u8vec4(uvec4(2u, 9u, 1u, 4u), uvec4(s1.a.mA.mA.mB)) && allOk;
	allOk = compare_i8vec4(ivec4(-2, -5, -3, -3), ivec4(s1.a.mA.mA.mC)) && allOk;
	allOk = compare_uvec4(uvec4(9u, 6u, 8u, 9u), s1.a.mA.mB.mA) && allOk;
	allOk = compare_i8vec4(ivec4(3, 3, -4, 8), ivec4(s1.a.mA.mB.mB)) && allOk;
	allOk = compare_vec4(vec4(-7.0, -9.0, -3.0, 4.0), s1.a.mA.mC.mA) && allOk;
	allOk = compare_i8vec3(ivec3(-3, -7, -7), ivec3(s1.a.mA.mC.mB)) && allOk;
	allOk = compare_i8vec2(ivec2(-1, 9), ivec2(s1.b)) && allOk;
	allOk = compare_uvec2(uvec2(7u, 8u), s2.a.mA.mA.mA) && allOk;
	allOk = compare_int8_t(int(-4), int(s2.a.mA.mA.mB)) && allOk;
	allOk = compare_bvec2(bvec2(true, false), s2.a.mA.mA.mC) && allOk;
	allOk = compare_u8vec2(uvec2(7u, 3u), uvec2(s2.a.mB.mA)) && allOk;
	allOk = compare_ivec4(ivec4(-3, -5, 4, 3), s2.a.mB.mB) && allOk;
	allOk = compare_u8vec4(uvec4(5u, 4u, 7u, 8u), uvec4(s2.a.mB.mC.mA)) && allOk;
	allOk = compare_int8_t(int(-3), int(s2.a.mB.mC.mB)) && allOk;
	allOk = compare_bvec3(bvec3(true, false, true), s2.a.mB.mC.mC) && allOk;
	allOk = compare_mat3(mat3(6.0, -5.0, -9.0, 2.0, 9.0, 7.0, 3.0, 6.0, 2.0), s2.a.mC.mA.mA) && allOk;
	allOk = compare_u8vec4(uvec4(3u, 0u, 9u, 8u), uvec4(s2.a.mC.mB.mA)) && allOk;
	allOk = compare_i8vec2(ivec2(0, 9), ivec2(s2.a.mC.mB.mB)) && allOk;
	allOk = compare_ivec3(ivec3(-2, -1, -4), s2.b) && allOk;
	allOk = compare_i8vec4(ivec4(-8, 0, 6, -5), ivec4(s2.c.mA.mA.mA)) && allOk;
	allOk = compare_uint8_t(uint(9u), uint(s2.c.mA.mA.mB)) && allOk;
	allOk = compare_int8_t(int(-7), int(s3.a)) && allOk;
	allOk = compare_i8vec2(ivec2(-1, 7), ivec2(s3.b.mA)) && allOk;
	allOk = compare_int8_t(int(-2), int(s3.b.mB)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	highp mat4x2 mA;
};
struct sB
{
	sA mA;
};
struct sC
{
	sB mA;
	bvec4 mB;
};
struct S1 {
	mediump ivec2 a;
	sC b;
	i8vec4 c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

shared S1 s1;

void main (void) {
	s1.a = ivec2(-4, 6);
	s1.b.mA.mA.mA = mat4x2(6.0, -7.0, -9.0, 5.0, -4.0, -9.0, 8.0, 6.0);
	s1.b.mB = bvec4(true, true, false, true);
	s1.c = i8vec4(-3, 2, -9, -7);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_ivec2(ivec2(-4, 6), s1.a) && allOk;
	allOk = compare_mat4x2(mat4x2(6.0, -7.0, -9.0, 5.0, -4.0, -9.0, 8.0, 6.0), s1.b.mA.mA.mA) && allOk;
	allOk = compare_bvec4(bvec4(true, true, false, true), s1.b.mB) && allOk;
	allOk = compare_i8vec4(ivec4(-3, 2, -9, -7), ivec4(s1.c)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	lowp uint mA;
};
struct sB
{
	mediump mat3 mA;
	i8vec3 mB;
	i8vec2 mC;
};
struct sC
{
	sB mA;
};
struct sD
{
	lowp mat2x3 mA;
	lowp ivec4 mB;
};
struct sE
{
	uint8_t mA;
};
struct sF
{
	sD mA;
	sE mB;
};
struct sG
{
	sC mA;
	sF mB;
};
struct S1 {
	sA a;
	sG b;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

shared S1 s1;

void main (void) {
	s1.a.mA = 5u;
	s1.b.mA.mA.mA = mat3(5.0, -6.0, -9.0, 9.0, -5.0, 7.0, 7.0, 0.0, 5.0);
	s1.b.mA.mA.mB = i8vec3(-7, -5, -2);
	s1.b.mA.mA.mC = i8vec2(-1, 5);
	s1.b.mB.mA.mA = mat2x3(2.0, -4.0, 7.0, 7.0, -1.0, 3.0);
	s1.b.mB.mA.mB = ivec4(-2, -1, -5, 5);
	s1.b.mB.mB.mA = uint8_t(5u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_uint(5u, s1.a.mA) && allOk;
	allOk = compare_mat3(mat3(5.0, -6.0, -9.0, 9.0, -5.0, 7.0, 7.0, 0.0, 5.0), s1.b.mA.mA.mA) && allOk;
	allOk = compare_i8vec3(ivec3(-7, -5, -2), ivec3(s1.b.mA.mA.mB)) && allOk;
	allOk = compare_i8vec2(ivec2(-1, 5), ivec2(s1.b.mA.mA.mC)) && allOk;
	allOk = compare_mat2x3(mat2x3(2.0, -4.0, 7.0, 7.0, -1.0, 3.0), s1.b.mB.mA.mA) && allOk;
	allOk = compare_ivec4(ivec4(-2, -1, -5, 5), s1.b.mB.mA.mB) && allOk;
	allOk = compare_uint8_t(uint(5u), uint(s1.b.mB.mB.mA)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	highp mat3 mA;
	mediump uint mB;
};
struct sB
{
	i8vec4 mA;
	sA mB;
};
struct sC
{
	uint8_t mA;
	sB mB;
	u8vec3 mC;
};
struct sD
{
	int8_t mA;
};
struct sE
{
	sD mA;
};
struct sF
{
	highp ivec4 mA;
};
struct sG
{
	i8vec3 mA;
};
struct sH
{
	sG mA;
	i8vec4 mB;
};
struct sI
{
	sE mA;
	sF mB;
	sH mC;
};
struct S1 {
	highp vec2 a;
	sC b;
	sI c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

shared S1 s1;

void main (void) {
	s1.a = vec2(1.0, -6.0);
	s1.b.mA = uint8_t(1u);
	s1.b.mB.mA = i8vec4(7, 2, -1, 4);
	s1.b.mB.mB.mA = mat3(1.0, -8.0, -1.0, 4.0, -7.0, 3.0, 8.0, 1.0, 9.0);
	s1.b.mB.mB.mB = 8u;
	s1.b.mC = u8vec3(6u, 3u, 1u);
	s1.c.mA.mA.mA = int8_t(-4);
	s1.c.mB.mA = ivec4(-3, 1, 5, 6);
	s1.c.mC.mA.mA = i8vec3(9, 0, 1);
	s1.c.mC.mB = i8vec4(-3, 1, 6, 6);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_vec2(vec2(1.0, -6.0), s1.a) && allOk;
	allOk = compare_uint8_t(uint(1u), uint(s1.b.mA)) && allOk;
	allOk = compare_i8vec4(ivec4(7, 2, -1, 4), ivec4(s1.b.mB.mA)) && allOk;
	allOk = compare_mat3(mat3(1.0, -8.0, -1.0, 4.0, -7.0, 3.0, 8.0, 1.0, 9.0), s1.b.mB.mB.mA) && allOk;
	allOk = compare_uint(8u, s1.b.mB.mB.mB) && allOk;
	allOk = compare_u8vec3(uvec3(6u, 3u, 1u), uvec3(s1.b.mC)) && allOk;
	allOk = compare_int8_t(int(-4), int(s1.c.mA.mA.mA)) && allOk;
	allOk = compare_ivec4(ivec4(-3, 1, 5, 6), s1.c.mB.mA) && allOk;
	allOk = compare_i8vec3(ivec3(9, 0, 1), ivec3(s1.c.mC.mA.mA)) && allOk;
	allOk = compare_i8vec4(ivec4(-3, 1, 6, 6), ivec4(s1.c.mC.mB)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	u8vec2 mA;
	int8_t mB;
	i8vec2 mC;
};
struct sB
{
	sA mA;
};
struct sC
{
	sB mA;
};
struct S1 {
	sC a;
	u8vec4 b;
	lowp int c;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

shared S1 s1;

void main (void) {
	s1.a.mA.mA.mA = u8vec2(5u, 7u);
	s1.a.mA.mA.mB = int8_t(9);
	s1.a.mA.mA.mC = i8vec2(7, -5);
	s1.b = u8vec4(3u, 5u, 0u, 3u);
	s1.c = -6;

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_u8vec2(uvec2(5u, 7u), uvec2(s1.a.mA.mA.mA)) && allOk;
	allOk = compare_int8_t(int(9), int(s1.a.mA.mA.mB)) && allOk;
	allOk = compare_i8vec2(ivec2(7, -5), ivec2(s1.a.mA.mA.mC)) && allOk;
	allOk = compare_u8vec4(uvec4(3u, 5u, 0u, 3u), uvec4(s1.b)) && allOk;
	allOk = compare_int(-6, s1.c) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	mediump mat2x3 mA;
};
struct sB
{
	lowp mat2 mA;
	bvec3 mB;
	u8vec3 mC;
};
struct sC
{
	sA mA;
	sB mB;
};
struct sD
{
	sC mA;
};
struct sE
{
	i8vec3 mA;
	bool mB;
	u8vec4 mC;
};
struct sF
{
	uint8_t mA[1];
	sE mB;
};
struct sG
{
	mediump mat4 mA;
	u8vec3 mB;
	u8vec4 mC;
};
struct sH
{
	i8vec2 mA;
	uint8_t mB;
};
struct sI
{
	sH mA;
	highp mat3x4 mB[2];
};
struct sJ
{
	sF mA;
	sG mB[2];
	sI mC;
};
struct sK
{
	highp uvec4 mA;
};
struct sL
{
	sK mA;
	mediump vec4 mB[1];
};
struct sM
{
	u8vec2 mA;
	mediump mat3x4 mB;
	bool mC;
};
struct sN
{
	sM mA;
};
struct sO
{
	sL mA;
	mediump ivec2 mB;
	sN mC;
};
struct S1 {
	sD a;
	sJ b;
	sO c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

shared S1 s1;

void main (void) {
	s1.a.mA.mA.mA = mat2x3(6.0, 8.0, 8.0, 0.0, -4.0, -5.0);
	s1.a.mA.mB.mA = mat2(9.0, -4.0, -6.0, -1.0);
	s1.a.mA.mB.mB = bvec3(false, true, true);
	s1.a.mA.mB.mC = u8vec3(3u, 8u, 2u);
	s1.b.mA.mA[0] = uint8_t(3u);
	s1.b.mA.mB.mA = i8vec3(-4, -9, 8);
	s1.b.mA.mB.mB = false;
	s1.b.mA.mB.mC = u8vec4(3u, 0u, 2u, 4u);
	s1.b.mB[0].mA = mat4(0.0, 9.0, -1.0, -1.0, -7.0, 7.0, -4.0, -3.0, 1.0, -4.0, -9.0, 1.0, -4.0, 0.0, 2.0, 0.0);
	s1.b.mB[0].mB = u8vec3(1u, 0u, 7u);
	s1.b.mB[0].mC = u8vec4(2u, 5u, 4u, 5u);
	s1.b.mB[1].mA = mat4(-9.0, -6.0, -9.0, -8.0, 6.0, -2.0, 3.0, 7.0, 2.0, -7.0, -2.0, -5.0, 4.0, 8.0, -9.0, -8.0);
	s1.b.mB[1].mB = u8vec3(0u, 7u, 0u);
	s1.b.mB[1].mC = u8vec4(8u, 8u, 1u, 5u);
	s1.b.mC.mA.mA = i8vec2(8, -7);
	s1.b.mC.mA.mB = uint8_t(2u);
	s1.b.mC.mB[0] = mat3x4(-9.0, 2.0, 4.0, 7.0, 4.0, -6.0, -8.0, 5.0, -7.0, 8.0, -2.0, 6.0);
	s1.b.mC.mB[1] = mat3x4(2.0, -9.0, -5.0, 4.0, 4.0, -7.0, -4.0, -9.0, 7.0, 6.0, 9.0, 8.0);
	s1.c.mA.mA.mA = uvec4(7u, 8u, 6u, 9u);
	s1.c.mA.mB[0] = vec4(9.0, -9.0, -6.0, 7.0);
	s1.c.mB = ivec2(6, -4);
	s1.c.mC.mA.mA = u8vec2(6u, 4u);
	s1.c.mC.mA.mB = mat3x4(3.0, 3.0, 3.0, 0.0, 6.0, -7.0, 7.0, 6.0, 5.0, -5.0, -9.0, -7.0);
	s1.c.mC.mA.mC = false;

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_mat2x3(mat2x3(6.0, 8.0, 8.0, 0.0, -4.0, -5.0), s1.a.mA.mA.mA) && allOk;
	allOk = compare_mat2(mat2(9.0, -4.0, -6.0, -1.0), s1.a.mA.mB.mA) && allOk;
	allOk = compare_bvec3(bvec3(false, true, true), s1.a.mA.mB.mB) && allOk;
	allOk = compare_u8vec3(uvec3(3u, 8u, 2u), uvec3(s1.a.mA.mB.mC)) && allOk;
	allOk = compare_uint8_t(uint(3u), uint(s1.b.mA.mA[0])) && allOk;
	allOk = compare_i8vec3(ivec3(-4, -9, 8), ivec3(s1.b.mA.mB.mA)) && allOk;
	allOk = compare_bool(false, s1.b.mA.mB.mB) && allOk;
	allOk = compare_u8vec4(uvec4(3u, 0u, 2u, 4u), uvec4(s1.b.mA.mB.mC)) && allOk;
	allOk = compare_mat4(mat4(0.0, 9.0, -1.0, -1.0, -7.0, 7.0, -4.0, -3.0, 1.0, -4.0, -9.0, 1.0, -4.0, 0.0, 2.0, 0.0), s1.b.mB[0].mA) && allOk;
	allOk = compare_u8vec3(uvec3(1u, 0u, 7u), uvec3(s1.b.mB[0].mB)) && allOk;
	allOk = compare_u8vec4(uvec4(2u, 5u, 4u, 5u), uvec4(s1.b.mB[0].mC)) && allOk;
	allOk = compare_mat4(mat4(-9.0, -6.0, -9.0, -8.0, 6.0, -2.0, 3.0, 7.0, 2.0, -7.0, -2.0, -5.0, 4.0, 8.0, -9.0, -8.0), s1.b.mB[1].mA) && allOk;
	allOk = compare_u8vec3(uvec3(0u, 7u, 0u), uvec3(s1.b.mB[1].mB)) && allOk;
	allOk = compare_u8vec4(uvec4(8u, 8u, 1u, 5u), uvec4(s1.b.mB[1].mC)) && allOk;
	allOk = compare_i8vec2(ivec2(8, -7), ivec2(s1.b.mC.mA.mA)) && allOk;
	allOk = compare_uint8_t(uint(2u), uint(s1.b.mC.mA.mB)) && allOk;
	allOk = compare_mat3x4(mat3x4(-9.0, 2.0, 4.0, 7.0, 4.0, -6.0, -8.0, 5.0, -7.0, 8.0, -2.0, 6.0), s1.b.mC.mB[0]) && allOk;
	allOk = compare_mat3x4(mat3x4(2.0, -9.0, -5.0, 4.0, 4.0, -7.0, -4.0, -9.0, 7.0, 6.0, 9.0, 8.0), s1.b.mC.mB[1]) && allOk;
	allOk = compare_uvec4(uvec4(7u, 8u, 6u, 9u), s1.c.mA.mA.mA) && allOk;
	allOk = compare_vec4(vec4(9.0, -9.0, -6.0, 7.0), s1.c.mA.mB[0]) && allOk;
	allOk = compare_ivec2(ivec2(6, -4), s1.c.mB) && allOk;
	allOk = compare_u8vec2(uvec2(6u, 4u), uvec2(s1.c.mC.mA.mA)) && allOk;
	allOk = compare_mat3x4(mat3x4(3.0, 3.0, 3.0, 0.0, 6.0, -7.0, 7.0, 6.0, 5.0, -5.0, -9.0, -7.0), s1.c.mC.mA.mB) && allOk;
	allOk = compare_bool(false, s1.c.mC.mA.mC) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	bvec3 mA;
};
struct sB
{
	i8vec3 mA;
};
struct sC
{
	lowp float mA;
	mediump mat4 mB;
};
struct sD
{
	sA mA;
	sB mB;
	sC mC;
};
struct sE
{
	u8vec2 mA;
	u8vec4 mB;
};
struct sF
{
	uint8_t mA;
	bool mB;
	u8vec3 mC;
};
struct sG
{
	sE mA;
	u8vec3 mB;
	sF mC;
};
struct sH
{
	sD mA;
	sG mB;
};
struct sI
{
	lowp uvec4 mA;
};
struct sJ
{
	sI mA;
};
struct sK
{
	i8vec2 mA;
	u8vec3 mB;
};
struct sL
{
	sK mA;
};
struct sM
{
	sL mA;
};
struct sN
{
	u8vec2 mA[1];
};
struct sO
{
	i8vec4 mA;
	uint8_t mB;
};
struct sP
{
	sO mA[1];
};
struct sQ
{
	i8vec2 mA[2];
	highp mat3x2 mB[3][1];
};
struct S1 {
	sH a;
	sJ b[3];
};
struct S2 {
	sM a;
	uint8_t b;
};
struct S3 {
	sN a[1];
	sP b;
	sQ c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

shared S1 s1;
shared S2 s2;
shared S3 s3;

void main (void) {
	s1.a.mA.mA.mA = bvec3(true, false, false);
	s1.a.mA.mB.mA = i8vec3(-3, -1, -9);
	s1.a.mA.mC.mA = 5.0;
	s1.a.mA.mC.mB = mat4(-7.0, -9.0, 8.0, -4.0, -8.0, 8.0, -8.0, -6.0, -2.0, 9.0, -2.0, -2.0, 1.0, 1.0, 7.0, -1.0);
	s1.a.mB.mA.mA = u8vec2(2u, 6u);
	s1.a.mB.mA.mB = u8vec4(5u, 5u, 7u, 8u);
	s1.a.mB.mB = u8vec3(9u, 3u, 7u);
	s1.a.mB.mC.mA = uint8_t(3u);
	s1.a.mB.mC.mB = true;
	s1.a.mB.mC.mC = u8vec3(2u, 1u, 7u);
	s1.b[0].mA.mA = uvec4(4u, 6u, 2u, 1u);
	s1.b[1].mA.mA = uvec4(4u, 6u, 0u, 3u);
	s1.b[2].mA.mA = uvec4(5u, 8u, 5u, 1u);
	s2.a.mA.mA.mA = i8vec2(-4, -6);
	s2.a.mA.mA.mB = u8vec3(8u, 7u, 0u);
	s2.b = uint8_t(8u);
	s3.a[0].mA[0] = u8vec2(7u, 2u);
	s3.b.mA[0].mA = i8vec4(8, -4, -9, 6);
	s3.b.mA[0].mB = uint8_t(4u);
	s3.c.mA[0] = i8vec2(8, -1);
	s3.c.mA[1] = i8vec2(2, 7);
	s3.c.mB[0][0] = mat3x2(8.0, 6.0, 7.0, -7.0, 0.0, -3.0);
	s3.c.mB[1][0] = mat3x2(7.0, 5.0, -5.0, 4.0, -8.0, -1.0);
	s3.c.mB[2][0] = mat3x2(2.0, -5.0, 6.0, 2.0, -7.0, -6.0);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_bvec3(bvec3(true, false, false), s1.a.mA.mA.mA) && allOk;
	allOk = compare_i8vec3(ivec3(-3, -1, -9), ivec3(s1.a.mA.mB.mA)) && allOk;
	allOk = compare_float(5.0, s1.a.mA.mC.mA) && allOk;
	allOk = compare_mat4(mat4(-7.0, -9.0, 8.0, -4.0, -8.0, 8.0, -8.0, -6.0, -2.0, 9.0, -2.0, -2.0, 1.0, 1.0, 7.0, -1.0), s1.a.mA.mC.mB) && allOk;
	allOk = compare_u8vec2(uvec2(2u, 6u), uvec2(s1.a.mB.mA.mA)) && allOk;
	allOk = compare_u8vec4(uvec4(5u, 5u, 7u, 8u), uvec4(s1.a.mB.mA.mB)) && allOk;
	allOk = compare_u8vec3(uvec3(9u, 3u, 7u), uvec3(s1.a.mB.mB)) && allOk;
	allOk = compare_uint8_t(uint(3u), uint(s1.a.mB.mC.mA)) && allOk;
	allOk = compare_bool(true, s1.a.mB.mC.mB) && allOk;
	allOk = compare_u8vec3(uvec3(2u, 1u, 7u), uvec3(s1.a.mB.mC.mC)) && allOk;
	allOk = compare_uvec4(uvec4(4u, 6u, 2u, 1u), s1.b[0].mA.mA) && allOk;
	allOk = compare_uvec4(uvec4(4u, 6u, 0u, 3u), s1.b[1].mA.mA) && allOk;
	allOk = compare_uvec4(uvec4(5u, 8u, 5u, 1u), s1.b[2].mA.mA) && allOk;
	allOk = compare_i8vec2(ivec2(-4, -6), ivec2(s2.a.mA.mA.mA)) && allOk;
	allOk = compare_u8vec3(uvec3(8u, 7u, 0u), uvec3(s2.a.mA.mA.mB)) && allOk;
	allOk = compare_uint8_t(uint(8u), uint(s2.b)) && allOk;
	allOk = compare_u8vec2(uvec2(7u, 2u), uvec2(s3.a[0].mA[0])) && allOk;
	allOk = compare_i8vec4(ivec4(8, -4, -9, 6), ivec4(s3.b.mA[0].mA)) && allOk;
	allOk = compare_uint8_t(uint(4u), uint(s3.b.mA[0].mB)) && allOk;
	allOk = compare_i8vec2(ivec2(8, -1), ivec2(s3.c.mA[0])) && allOk;
	allOk = compare_i8vec2(ivec2(2, 7), ivec2(s3.c.mA[1])) && allOk;
	allOk = compare_mat3x2(mat3x2(8.0, 6.0, 7.0, -7.0, 0.0, -3.0), s3.c.mB[0][0]) && allOk;
	allOk = compare_mat3x2(mat3x2(7.0, 5.0, -5.0, 4.0, -8.0, -1.0), s3.c.mB[1][0]) && allOk;
	allOk = compare_mat3x2(mat3x2(2.0, -5.0, 6.0, 2.0, -7.0, -6.0), s3.c.mB[2][0]) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	lowp mat2x3 mA;
	uint8_t mB;
	i8vec2 mC;
};
struct sB
{
	u8vec4 mA[3];
	sA mB;
	i8vec2 mC;
};
struct sC
{
	i8vec4 mA;
	i8vec4 mB;
	u8vec2 mC;
};
struct sD
{
	highp uint mA;
	lowp vec3 mB;
};
struct sE
{
	sB mA;
	sC mB[3];
	sD mC[2];
};
struct sF
{
	u8vec3 mA;
	mediump float mB;
};
struct sG
{
	mediump ivec4 mA[2];
	u8vec3 mB[1];
	sF mC;
};
struct sH
{
	bool mA[3];
	i8vec4 mB[3];
};
struct sI
{
	sG mA;
	sH mB;
};
struct sJ
{
	uint8_t mA;
};
struct sK
{
	uint8_t mA;
};
struct sL
{
	sJ mA;
	sK mB;
};
struct sM
{
	sL mA;
};
struct S1 {
	sE a;
	sI b;
	sM c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

shared S1 s1;

void main (void) {
	s1.a.mA.mA[0] = u8vec4(8u, 0u, 0u, 0u);
	s1.a.mA.mA[1] = u8vec4(2u, 5u, 5u, 2u);
	s1.a.mA.mA[2] = u8vec4(5u, 1u, 5u, 2u);
	s1.a.mA.mB.mA = mat2x3(4.0, 9.0, -9.0, -8.0, -9.0, 8.0);
	s1.a.mA.mB.mB = uint8_t(8u);
	s1.a.mA.mB.mC = i8vec2(4, -4);
	s1.a.mA.mC = i8vec2(7, 2);
	s1.a.mB[0].mA = i8vec4(-1, 7, -5, -4);
	s1.a.mB[0].mB = i8vec4(3, -5, -3, -1);
	s1.a.mB[0].mC = u8vec2(5u, 7u);
	s1.a.mB[1].mA = i8vec4(-3, 1, 3, -9);
	s1.a.mB[1].mB = i8vec4(-4, 3, 9, 1);
	s1.a.mB[1].mC = u8vec2(0u, 6u);
	s1.a.mB[2].mA = i8vec4(-5, 9, -7, -8);
	s1.a.mB[2].mB = i8vec4(1, 6, 0, -3);
	s1.a.mB[2].mC = u8vec2(0u, 8u);
	s1.a.mC[0].mA = 7u;
	s1.a.mC[0].mB = vec3(5.0, -3.0, 0.0);
	s1.a.mC[1].mA = 8u;
	s1.a.mC[1].mB = vec3(1.0, -9.0, -9.0);
	s1.b.mA.mA[0] = ivec4(-9, -7, 7, -2);
	s1.b.mA.mA[1] = ivec4(2, -4, 4, -8);
	s1.b.mA.mB[0] = u8vec3(3u, 6u, 9u);
	s1.b.mA.mC.mA = u8vec3(3u, 5u, 6u);
	s1.b.mA.mC.mB = 0.0;
	s1.b.mB.mA[0] = false;
	s1.b.mB.mA[1] = true;
	s1.b.mB.mA[2] = false;
	s1.b.mB.mB[0] = i8vec4(2, -4, -5, 1);
	s1.b.mB.mB[1] = i8vec4(5, 4, -7, 6);
	s1.b.mB.mB[2] = i8vec4(8, 0, -7, -8);
	s1.c.mA.mA.mA = uint8_t(5u);
	s1.c.mA.mB.mA = uint8_t(4u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_u8vec4(uvec4(8u, 0u, 0u, 0u), uvec4(s1.a.mA.mA[0])) && allOk;
	allOk = compare_u8vec4(uvec4(2u, 5u, 5u, 2u), uvec4(s1.a.mA.mA[1])) && allOk;
	allOk = compare_u8vec4(uvec4(5u, 1u, 5u, 2u), uvec4(s1.a.mA.mA[2])) && allOk;
	allOk = compare_mat2x3(mat2x3(4.0, 9.0, -9.0, -8.0, -9.0, 8.0), s1.a.mA.mB.mA) && allOk;
	allOk = compare_uint8_t(uint(8u), uint(s1.a.mA.mB.mB)) && allOk;
	allOk = compare_i8vec2(ivec2(4, -4), ivec2(s1.a.mA.mB.mC)) && allOk;
	allOk = compare_i8vec2(ivec2(7, 2), ivec2(s1.a.mA.mC)) && allOk;
	allOk = compare_i8vec4(ivec4(-1, 7, -5, -4), ivec4(s1.a.mB[0].mA)) && allOk;
	allOk = compare_i8vec4(ivec4(3, -5, -3, -1), ivec4(s1.a.mB[0].mB)) && allOk;
	allOk = compare_u8vec2(uvec2(5u, 7u), uvec2(s1.a.mB[0].mC)) && allOk;
	allOk = compare_i8vec4(ivec4(-3, 1, 3, -9), ivec4(s1.a.mB[1].mA)) && allOk;
	allOk = compare_i8vec4(ivec4(-4, 3, 9, 1), ivec4(s1.a.mB[1].mB)) && allOk;
	allOk = compare_u8vec2(uvec2(0u, 6u), uvec2(s1.a.mB[1].mC)) && allOk;
	allOk = compare_i8vec4(ivec4(-5, 9, -7, -8), ivec4(s1.a.mB[2].mA)) && allOk;
	allOk = compare_i8vec4(ivec4(1, 6, 0, -3), ivec4(s1.a.mB[2].mB)) && allOk;
	allOk = compare_u8vec2(uvec2(0u, 8u), uvec2(s1.a.mB[2].mC)) && allOk;
	allOk = compare_uint(7u, s1.a.mC[0].mA) && allOk;
	allOk = compare_vec3(vec3(5.0, -3.0, 0.0), s1.a.mC[0].mB) && allOk;
	allOk = compare_uint(8u, s1.a.mC[1].mA) && allOk;
	allOk = compare_vec3(vec3(1.0, -9.0, -9.0), s1.a.mC[1].mB) && allOk;
	allOk = compare_ivec4(ivec4(-9, -7, 7, -2), s1.b.mA.mA[0]) && allOk;
	allOk = compare_ivec4(ivec4(2, -4, 4, -8), s1.b.mA.mA[1]) && allOk;
	allOk = compare_u8vec3(uvec3(3u, 6u, 9u), uvec3(s1.b.mA.mB[0])) && allOk;
	allOk = compare_u8vec3(uvec3(3u, 5u, 6u), uvec3(s1.b.mA.mC.mA)) && allOk;
	allOk = compare_float(0.0, s1.b.mA.mC.mB) && allOk;
	allOk = compare_bool(false, s1.b.mB.mA[0]) && allOk;
	allOk = compare_bool(true, s1.b.mB.mA[1]) && allOk;
	allOk = compare_bool(false, s1.b.mB.mA[2]) && allOk;
	allOk = compare_i8vec4(ivec4(2, -4, -5, 1), ivec4(s1.b.mB.mB[0])) && allOk;
	allOk = compare_i8vec4(ivec4(5, 4, -7, 6), ivec4(s1.b.mB.mB[1])) && allOk;
	allOk = compare_i8vec4(ivec4(8, 0, -7, -8), ivec4(s1.b.mB.mB[2])) && allOk;
	allOk = compare_uint8_t(uint(5u), uint(s1.c.mA.mA.mA)) && allOk;
	allOk = compare_uint8_t(uint(4u), uint(s1.c.mA.mB.mA)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	lowp mat2 mA;
	u8vec4 mB;
	uint8_t mC;
};
struct sB
{
	int8_t mA;
};
struct sC
{
	bvec4 mA;
	highp mat3 mB;
};
struct sD
{
	sA mA;
	sB mB;
	sC mC;
};
struct sE
{
	mediump mat2x3 mA;
	sD mB;
};
struct sF
{
	i8vec4 mA;
	lowp int mB;
};
struct sG
{
	highp int mA[3];
	sF mB;
};
struct sH
{
	int8_t mA;
	highp ivec2 mB;
};
struct sI
{
	lowp mat4x3 mA;
};
struct sJ
{
	u8vec2 mA;
	i8vec4 mB;
	uint8_t mC;
};
struct sK
{
	sH mA;
	sI mB;
	sJ mC;
};
struct sL
{
	sG mA;
	sK mB;
};
struct sM
{
	i8vec2 mA;
};
struct sN
{
	i8vec3 mA[2];
	sM mB;
};
struct sO
{
	sN mA;
};
struct sP
{
	highp vec3 mA;
	i8vec2 mB;
};
struct sQ
{
	sP mA;
	i8vec3 mB[2];
	u8vec3 mC[1];
};
struct sR
{
	sQ mA;
};
struct S1 {
	sE a;
	sL b;
};
struct S2 {
	sO a;
	sR b;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a.mA = mat2x3(1.0, -5.0, -9.0, -5.0, 1.0, -7.0);
	s1.a.mB.mA.mA = mat2(1.0, 2.0, 8.0, 7.0);
	s1.a.mB.mA.mB = u8vec4(6u, 0u, 7u, 2u);
	s1.a.mB.mA.mC = uint8_t(5u);
	s1.a.mB.mB.mA = int8_t(-5);
	s1.a.mB.mC.mA = bvec4(false, false, true, false);
	s1.a.mB.mC.mB = mat3(4.0, -2.0, 9.0, 2.0, -5.0, 1.0, -6.0, 8.0, 5.0);
	s1.b.mA.mA[0] = 5;
	s1.b.mA.mA[1] = -3;
	s1.b.mA.mA[2] = 3;
	s1.b.mA.mB.mA = i8vec4(1, -9, 7, -2);
	s1.b.mA.mB.mB = 2;
	s1.b.mB.mA.mA = int8_t(9);
	s1.b.mB.mA.mB = ivec2(-3, 3);
	s1.b.mB.mB.mA = mat4x3(1.0, 1.0, -9.0, -3.0, -9.0, -7.0, -4.0, -4.0, -6.0, 1.0, 3.0, -4.0);
	s1.b.mB.mC.mA = u8vec2(3u, 0u);
	s1.b.mB.mC.mB = i8vec4(1, -3, -9, -6);
	s1.b.mB.mC.mC = uint8_t(6u);
	s2.a.mA.mA[0] = i8vec3(5, -5, 2);
	s2.a.mA.mA[1] = i8vec3(4, 9, 2);
	s2.a.mA.mB.mA = i8vec2(5, -2);
	s2.b.mA.mA.mA = vec3(-4.0, 7.0, 1.0);
	s2.b.mA.mA.mB = i8vec2(-8, -9);
	s2.b.mA.mB[0] = i8vec3(5, 1, -5);
	s2.b.mA.mB[1] = i8vec3(5, -3, 6);
	s2.b.mA.mC[0] = u8vec3(7u, 3u, 0u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_mat2x3(mat2x3(1.0, -5.0, -9.0, -5.0, 1.0, -7.0), s1.a.mA) && allOk;
	allOk = compare_mat2(mat2(1.0, 2.0, 8.0, 7.0), s1.a.mB.mA.mA) && allOk;
	allOk = compare_u8vec4(uvec4(6u, 0u, 7u, 2u), uvec4(s1.a.mB.mA.mB)) && allOk;
	allOk = compare_uint8_t(uint(5u), uint(s1.a.mB.mA.mC)) && allOk;
	allOk = compare_int8_t(int(-5), int(s1.a.mB.mB.mA)) && allOk;
	allOk = compare_bvec4(bvec4(false, false, true, false), s1.a.mB.mC.mA) && allOk;
	allOk = compare_mat3(mat3(4.0, -2.0, 9.0, 2.0, -5.0, 1.0, -6.0, 8.0, 5.0), s1.a.mB.mC.mB) && allOk;
	allOk = compare_int(5, s1.b.mA.mA[0]) && allOk;
	allOk = compare_int(-3, s1.b.mA.mA[1]) && allOk;
	allOk = compare_int(3, s1.b.mA.mA[2]) && allOk;
	allOk = compare_i8vec4(ivec4(1, -9, 7, -2), ivec4(s1.b.mA.mB.mA)) && allOk;
	allOk = compare_int(2, s1.b.mA.mB.mB) && allOk;
	allOk = compare_int8_t(int(9), int(s1.b.mB.mA.mA)) && allOk;
	allOk = compare_ivec2(ivec2(-3, 3), s1.b.mB.mA.mB) && allOk;
	allOk = compare_mat4x3(mat4x3(1.0, 1.0, -9.0, -3.0, -9.0, -7.0, -4.0, -4.0, -6.0, 1.0, 3.0, -4.0), s1.b.mB.mB.mA) && allOk;
	allOk = compare_u8vec2(uvec2(3u, 0u), uvec2(s1.b.mB.mC.mA)) && allOk;
	allOk = compare_i8vec4(ivec4(1, -3, -9, -6), ivec4(s1.b.mB.mC.mB)) && allOk;
	allOk = compare_uint8_t(uint(6u), uint(s1.b.mB.mC.mC)) && allOk;
	allOk = compare_i8vec3(ivec3(5, -5, 2), ivec3(s2.a.mA.mA[0])) && allOk;
	allOk = compare_i8vec3(ivec3(4, 9, 2), ivec3(s2.a.mA.mA[1])) && allOk;
	allOk = compare_i8vec2(ivec2(5, -2), ivec2(s2.a.mA.mB.mA)) && allOk;
	allOk = compare_vec3(vec3(-4.0, 7.0, 1.0), s2.b.mA.mA.mA) && allOk;
	allOk = compare_i8vec2(ivec2(-8, -9), ivec2(s2.b.mA.mA.mB)) && allOk;
	allOk = compare_i8vec3(ivec3(5, 1, -5), ivec3(s2.b.mA.mB[0])) && allOk;
	allOk = compare_i8vec3(ivec3(5, -3, 6), ivec3(s2.b.mA.mB[1])) && allOk;
	allOk = compare_u8vec3(uvec3(7u, 3u, 0u), uvec3(s2.b.mA.mC[0])) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	lowp ivec4 mA;
	u8vec4 mB;
};
struct sB
{
	mediump vec2 mA;
	i8vec3 mB;
};
struct sC
{
	sB mA;
	lowp vec4 mB;
};
struct sD
{
	bvec3 mA;
	i8vec3 mB;
	uint8_t mC;
};
struct sE
{
	u8vec3 mA;
};
struct sF
{
	sD mA;
	sE mB;
	u8vec2 mC[1];
};
struct sG
{
	highp mat4 mA[2];
};
struct sH
{
	sC mA;
	sF mB;
	sG mC;
};
struct sI
{
	highp mat2x3 mA;
	int8_t mB;
};
struct sJ
{
	sI mA;
};
struct sK
{
	lowp uint mA;
	highp mat2 mB;
};
struct sL
{
	sK mA;
};
struct sM
{
	sJ mA;
	sL mB;
};
struct sN
{
	bool mA;
	int8_t mB;
	highp mat2 mC;
};
struct sO
{
	highp vec4 mA;
};
struct sP
{
	i8vec3 mA;
};
struct sQ
{
	i8vec3 mA;
	i8vec3 mB;
	int8_t mC;
};
struct sR
{
	sP mA;
	sQ mB;
};
struct sS
{
	sN mA[1];
	sO mB;
	sR mC;
};
struct S1 {
	sA a;
	sH b;
	sM c;
	sS d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

shared S1 s1;

void main (void) {
	s1.a.mA = ivec4(2, 7, -9, 3);
	s1.a.mB = u8vec4(3u, 9u, 6u, 5u);
	s1.b.mA.mA.mA = vec2(3.0, 9.0);
	s1.b.mA.mA.mB = i8vec3(1, -5, -2);
	s1.b.mA.mB = vec4(0.0, 9.0, -1.0, -9.0);
	s1.b.mB.mA.mA = bvec3(true, false, false);
	s1.b.mB.mA.mB = i8vec3(1, -6, 0);
	s1.b.mB.mA.mC = uint8_t(4u);
	s1.b.mB.mB.mA = u8vec3(3u, 6u, 5u);
	s1.b.mB.mC[0] = u8vec2(8u, 4u);
	s1.b.mC.mA[0] = mat4(-5.0, 1.0, 2.0, -7.0, 5.0, -6.0, -9.0, -8.0, 8.0, -5.0, 9.0, -9.0, -2.0, 6.0, -7.0, 8.0);
	s1.b.mC.mA[1] = mat4(3.0, 9.0, 7.0, 9.0, 7.0, 3.0, -3.0, 8.0, 1.0, -8.0, -3.0, -3.0, -3.0, 3.0, 3.0, 2.0);
	s1.c.mA.mA.mA = mat2x3(3.0, 1.0, 9.0, -4.0, 4.0, 8.0);
	s1.c.mA.mA.mB = int8_t(2);
	s1.c.mB.mA.mA = 7u;
	s1.c.mB.mA.mB = mat2(0.0, -1.0, -9.0, -8.0);
	s1.d.mA[0].mA = true;
	s1.d.mA[0].mB = int8_t(1);
	s1.d.mA[0].mC = mat2(1.0, -7.0, -9.0, -6.0);
	s1.d.mB.mA = vec4(4.0, 0.0, -3.0, -3.0);
	s1.d.mC.mA.mA = i8vec3(9, -1, -8);
	s1.d.mC.mB.mA = i8vec3(-9, -7, -2);
	s1.d.mC.mB.mB = i8vec3(-6, 0, 5);
	s1.d.mC.mB.mC = int8_t(8);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_ivec4(ivec4(2, 7, -9, 3), s1.a.mA) && allOk;
	allOk = compare_u8vec4(uvec4(3u, 9u, 6u, 5u), uvec4(s1.a.mB)) && allOk;
	allOk = compare_vec2(vec2(3.0, 9.0), s1.b.mA.mA.mA) && allOk;
	allOk = compare_i8vec3(ivec3(1, -5, -2), ivec3(s1.b.mA.mA.mB)) && allOk;
	allOk = compare_vec4(vec4(0.0, 9.0, -1.0, -9.0), s1.b.mA.mB) && allOk;
	allOk = compare_bvec3(bvec3(true, false, false), s1.b.mB.mA.mA) && allOk;
	allOk = compare_i8vec3(ivec3(1, -6, 0), ivec3(s1.b.mB.mA.mB)) && allOk;
	allOk = compare_uint8_t(uint(4u), uint(s1.b.mB.mA.mC)) && allOk;
	allOk = compare_u8vec3(uvec3(3u, 6u, 5u), uvec3(s1.b.mB.mB.mA)) && allOk;
	allOk = compare_u8vec2(uvec2(8u, 4u), uvec2(s1.b.mB.mC[0])) && allOk;
	allOk = compare_mat4(mat4(-5.0, 1.0, 2.0, -7.0, 5.0, -6.0, -9.0, -8.0, 8.0, -5.0, 9.0, -9.0, -2.0, 6.0, -7.0, 8.0), s1.b.mC.mA[0]) && allOk;
	allOk = compare_mat4(mat4(3.0, 9.0, 7.0, 9.0, 7.0, 3.0, -3.0, 8.0, 1.0, -8.0, -3.0, -3.0, -3.0, 3.0, 3.0, 2.0), s1.b.mC.mA[1]) && allOk;
	allOk = compare_mat2x3(mat2x3(3.0, 1.0, 9.0, -4.0, 4.0, 8.0), s1.c.mA.mA.mA) && allOk;
	allOk = compare_int8_t(int(2), int(s1.c.mA.mA.mB)) && allOk;
	allOk = compare_uint(7u, s1.c.mB.mA.mA) && allOk;
	allOk = compare_mat2(mat2(0.0, -1.0, -9.0, -8.0), s1.c.mB.mA.mB) && allOk;
	allOk = compare_bool(true, s1.d.mA[0].mA) && allOk;
	allOk = compare_int8_t(int(1), int(s1.d.mA[0].mB)) && allOk;
	allOk = compare_mat2(mat2(1.0, -7.0, -9.0, -6.0), s1.d.mA[0].mC) && allOk;
	allOk = compare_vec4(vec4(4.0, 0.0, -3.0, -3.0), s1.d.mB.mA) && allOk;
	allOk = compare_i8vec3(ivec3(9, -1, -8), ivec3(s1.d.mC.mA.mA)) && allOk;
	allOk = compare_i8vec3(ivec3(-9, -7, -2), ivec3(s1.d.mC.mB.mA)) && allOk;
	allOk = compare_i8vec3(ivec3(-6, 0, 5), ivec3(s1.d.mC.mB.mB)) && allOk;
	allOk = compare_int8_t(int(8), int(s1.d.mC.mB.mC)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	lowp ivec3 mA;
};
struct sB
{
	sA mA[2];
};
struct sC
{
	int8_t mA;
};
struct sD
{
	uint8_t mA;
	uint8_t mB;
	mediump mat3 mC;
};
struct sE
{
	sC mA;
	sD mB;
};
struct sF
{
	sE mA;
	mediump mat2 mB[1][3];
};
struct sG
{
	i8vec4 mA[2];
	mediump float mB[3];
};
struct sH
{
	u8vec3 mA;
};
struct sI
{
	highp ivec4 mA;
	i8vec2 mB;
	u8vec3 mC;
};
struct sJ
{
	sH mA;
	sI mB;
};
struct sK
{
	sG mA;
	sJ mB;
};
struct sL
{
	int8_t mA;
};
struct sM
{
	sL mA;
	i8vec2 mB[2];
	bvec4 mC;
};
struct S1 {
	sB a;
	sF b;
};
struct S2 {
	sK a;
	sM b[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a.mA[0].mA = ivec3(2, -3, 2);
	s1.a.mA[1].mA = ivec3(-4, 4, 6);
	s1.b.mA.mA.mA = int8_t(-2);
	s1.b.mA.mB.mA = uint8_t(1u);
	s1.b.mA.mB.mB = uint8_t(9u);
	s1.b.mA.mB.mC = mat3(-3.0, 1.0, -3.0, 8.0, 7.0, 3.0, 3.0, -4.0, 8.0);
	s1.b.mB[0][0] = mat2(-7.0, -9.0, -3.0, 4.0);
	s1.b.mB[0][1] = mat2(-3.0, -7.0, -7.0, -1.0);
	s1.b.mB[0][2] = mat2(9.0, -6.0, 8.0, -4.0);
	s2.a.mA.mA[0] = i8vec4(4, 1, -6, -2);
	s2.a.mA.mA[1] = i8vec4(-3, -5, 4, 3);
	s2.a.mA.mB[0] = 0.0;
	s2.a.mA.mB[1] = 6.0;
	s2.a.mA.mB[2] = -1.0;
	s2.a.mB.mA.mA = u8vec3(8u, 3u, 4u);
	s2.a.mB.mB.mA = ivec4(1, 7, 6, -5);
	s2.a.mB.mB.mB = i8vec2(-9, 2);
	s2.a.mB.mB.mC = u8vec3(0u, 4u, 8u);
	s2.b[0].mA.mA = int8_t(6);
	s2.b[0].mB[0] = i8vec2(2, 0);
	s2.b[0].mB[1] = i8vec2(-1, 1);
	s2.b[0].mC = bvec4(false, false, false, true);
	s2.b[1].mA.mA = int8_t(-1);
	s2.b[1].mB[0] = i8vec2(-4, -8);
	s2.b[1].mB[1] = i8vec2(0, 6);
	s2.b[1].mC = bvec4(false, true, false, false);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_ivec3(ivec3(2, -3, 2), s1.a.mA[0].mA) && allOk;
	allOk = compare_ivec3(ivec3(-4, 4, 6), s1.a.mA[1].mA) && allOk;
	allOk = compare_int8_t(int(-2), int(s1.b.mA.mA.mA)) && allOk;
	allOk = compare_uint8_t(uint(1u), uint(s1.b.mA.mB.mA)) && allOk;
	allOk = compare_uint8_t(uint(9u), uint(s1.b.mA.mB.mB)) && allOk;
	allOk = compare_mat3(mat3(-3.0, 1.0, -3.0, 8.0, 7.0, 3.0, 3.0, -4.0, 8.0), s1.b.mA.mB.mC) && allOk;
	allOk = compare_mat2(mat2(-7.0, -9.0, -3.0, 4.0), s1.b.mB[0][0]) && allOk;
	allOk = compare_mat2(mat2(-3.0, -7.0, -7.0, -1.0), s1.b.mB[0][1]) && allOk;
	allOk = compare_mat2(mat2(9.0, -6.0, 8.0, -4.0), s1.b.mB[0][2]) && allOk;
	allOk = compare_i8vec4(ivec4(4, 1, -6, -2), ivec4(s2.a.mA.mA[0])) && allOk;
	allOk = compare_i8vec4(ivec4(-3, -5, 4, 3), ivec4(s2.a.mA.mA[1])) && allOk;
	allOk = compare_float(0.0, s2.a.mA.mB[0]) && allOk;
	allOk = compare_float(6.0, s2.a.mA.mB[1]) && allOk;
	allOk = compare_float(-1.0, s2.a.mA.mB[2]) && allOk;
	allOk = compare_u8vec3(uvec3(8u, 3u, 4u), uvec3(s2.a.mB.mA.mA)) && allOk;
	allOk = compare_ivec4(ivec4(1, 7, 6, -5), s2.a.mB.mB.mA) && allOk;
	allOk = compare_i8vec2(ivec2(-9, 2), ivec2(s2.a.mB.mB.mB)) && allOk;
	allOk = compare_u8vec3(uvec3(0u, 4u, 8u), uvec3(s2.a.mB.mB.mC)) && allOk;
	allOk = compare_int8_t(int(6), int(s2.b[0].mA.mA)) && allOk;
	allOk = compare_i8vec2(ivec2(2, 0), ivec2(s2.b[0].mB[0])) && allOk;
	allOk = compare_i8vec2(ivec2(-1, 1), ivec2(s2.b[0].mB[1])) && allOk;
	allOk = compare_bvec4(bvec4(false, false, false, true), s2.b[0].mC) && allOk;
	allOk = compare_int8_t(int(-1), int(s2.b[1].mA.mA)) && allOk;
	allOk = compare_i8vec2(ivec2(-4, -8), ivec2(s2.b[1].mB[0])) && allOk;
	allOk = compare_i8vec2(ivec2(0, 6), ivec2(s2.b[1].mB[1])) && allOk;
	allOk = compare_bvec4(bvec4(false, true, false, false), s2.b[1].mC) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	u8vec2 mA;
};
struct sB
{
	sA mA;
};
struct sC
{
	lowp ivec4 mA;
};
struct sD
{
	sC mA;
};
struct sE
{
	bool mA;
	mediump int mB;
	u8vec3 mC;
};
struct sF
{
	sB mA;
	sD mB;
	sE mC[2];
};
struct sG
{
	lowp mat2x3 mA[3];
};
struct sH
{
	i8vec3 mA[3];
};
struct sI
{
	u8vec2 mA;
	u8vec2 mB;
	lowp ivec2 mC;
};
struct sJ
{
	bool mA;
	i8vec3 mB;
};
struct sK
{
	sI mA;
	mediump uvec3 mB[2];
	sJ mC;
};
struct sL
{
	sG mA;
	sH mB;
	sK mC;
};
struct sM
{
	i8vec2 mA;
};
struct sN
{
	u8vec3 mA;
	u8vec4 mB;
};
struct sO
{
	bool mA;
};
struct sP
{
	sM mA;
	sN mB;
	sO mC;
};
struct sQ
{
	sP mA;
};
struct sR
{
	lowp mat2 mA;
};
struct sS
{
	sR mA;
};
struct sT
{
	lowp ivec4 mA;
};
struct sU
{
	u8vec4 mA;
};
struct sV
{
	sT mA;
	sU mB;
};
struct sW
{
	sS mA;
	sV mB;
};
struct sX
{
	i8vec2 mA;
};
struct sY
{
	sX mA;
	i8vec4 mB[3];
	highp mat3x2 mC[2];
};
struct sZ
{
	sY mA;
};
struct sAA
{
	u8vec2 mA[2][3];
};
struct sAB
{
	u8vec3 mA;
	bvec4 mB;
};
struct sAC
{
	bvec4 mA;
};
struct sAD
{
	sAB mA;
	sAC mB;
};
struct sAE
{
	sAD mA;
};
struct S1 {
	sF a;
	sL b;
	sQ c;
	sW d;
};
struct S2 {
	sZ a;
	sAA b;
	int8_t c;
	sAE d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a.mA.mA.mA = u8vec2(2u, 3u);
	s1.a.mB.mA.mA = ivec4(6, -7, -9, 5);
	s1.a.mC[0].mA = true;
	s1.a.mC[0].mB = -9;
	s1.a.mC[0].mC = u8vec3(0u, 3u, 2u);
	s1.a.mC[1].mA = true;
	s1.a.mC[1].mB = 4;
	s1.a.mC[1].mC = u8vec3(6u, 4u, 2u);
	s1.b.mA.mA[0] = mat2x3(-9.0, -7.0, -5.0, -7.0, 3.0, 5.0);
	s1.b.mA.mA[1] = mat2x3(2.0, -9.0, 0.0, -5.0, 0.0, 1.0);
	s1.b.mA.mA[2] = mat2x3(-8.0, 0.0, 3.0, -5.0, 5.0, -7.0);
	s1.b.mB.mA[0] = i8vec3(1, -8, 2);
	s1.b.mB.mA[1] = i8vec3(0, 1, 8);
	s1.b.mB.mA[2] = i8vec3(-3, 7, -6);
	s1.b.mC.mA.mA = u8vec2(1u, 6u);
	s1.b.mC.mA.mB = u8vec2(2u, 2u);
	s1.b.mC.mA.mC = ivec2(-8, 3);
	s1.b.mC.mB[0] = uvec3(6u, 2u, 9u);
	s1.b.mC.mB[1] = uvec3(2u, 6u, 1u);
	s1.b.mC.mC.mA = true;
	s1.b.mC.mC.mB = i8vec3(-6, 2, -4);
	s1.c.mA.mA.mA = i8vec2(9, 9);
	s1.c.mA.mB.mA = u8vec3(3u, 8u, 9u);
	s1.c.mA.mB.mB = u8vec4(7u, 2u, 6u, 6u);
	s1.c.mA.mC.mA = false;
	s1.d.mA.mA.mA = mat2(7.0, -9.0, -3.0, 0.0);
	s1.d.mB.mA.mA = ivec4(4, -7, -1, 1);
	s1.d.mB.mB.mA = u8vec4(1u, 2u, 2u, 8u);
	s2.a.mA.mA.mA = i8vec2(6, -8);
	s2.a.mA.mB[0] = i8vec4(-5, 5, -2, -5);
	s2.a.mA.mB[1] = i8vec4(9, 4, 7, -1);
	s2.a.mA.mB[2] = i8vec4(-6, 2, 0, -9);
	s2.a.mA.mC[0] = mat3x2(8.0, 3.0, -7.0, -1.0, 0.0, -2.0);
	s2.a.mA.mC[1] = mat3x2(-9.0, 1.0, 1.0, -3.0, -4.0, 0.0);
	s2.b.mA[0][0] = u8vec2(6u, 0u);
	s2.b.mA[0][1] = u8vec2(3u, 3u);
	s2.b.mA[0][2] = u8vec2(8u, 2u);
	s2.b.mA[1][0] = u8vec2(6u, 1u);
	s2.b.mA[1][1] = u8vec2(7u, 0u);
	s2.b.mA[1][2] = u8vec2(5u, 6u);
	s2.c = int8_t(2);
	s2.d.mA.mA.mA = u8vec3(4u, 9u, 3u);
	s2.d.mA.mA.mB = bvec4(false, true, true, false);
	s2.d.mA.mB.mA = bvec4(false, true, false, true);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_u8vec2(uvec2(2u, 3u), uvec2(s1.a.mA.mA.mA)) && allOk;
	allOk = compare_ivec4(ivec4(6, -7, -9, 5), s1.a.mB.mA.mA) && allOk;
	allOk = compare_bool(true, s1.a.mC[0].mA) && allOk;
	allOk = compare_int(-9, s1.a.mC[0].mB) && allOk;
	allOk = compare_u8vec3(uvec3(0u, 3u, 2u), uvec3(s1.a.mC[0].mC)) && allOk;
	allOk = compare_bool(true, s1.a.mC[1].mA) && allOk;
	allOk = compare_int(4, s1.a.mC[1].mB) && allOk;
	allOk = compare_u8vec3(uvec3(6u, 4u, 2u), uvec3(s1.a.mC[1].mC)) && allOk;
	allOk = compare_mat2x3(mat2x3(-9.0, -7.0, -5.0, -7.0, 3.0, 5.0), s1.b.mA.mA[0]) && allOk;
	allOk = compare_mat2x3(mat2x3(2.0, -9.0, 0.0, -5.0, 0.0, 1.0), s1.b.mA.mA[1]) && allOk;
	allOk = compare_mat2x3(mat2x3(-8.0, 0.0, 3.0, -5.0, 5.0, -7.0), s1.b.mA.mA[2]) && allOk;
	allOk = compare_i8vec3(ivec3(1, -8, 2), ivec3(s1.b.mB.mA[0])) && allOk;
	allOk = compare_i8vec3(ivec3(0, 1, 8), ivec3(s1.b.mB.mA[1])) && allOk;
	allOk = compare_i8vec3(ivec3(-3, 7, -6), ivec3(s1.b.mB.mA[2])) && allOk;
	allOk = compare_u8vec2(uvec2(1u, 6u), uvec2(s1.b.mC.mA.mA)) && allOk;
	allOk = compare_u8vec2(uvec2(2u, 2u), uvec2(s1.b.mC.mA.mB)) && allOk;
	allOk = compare_ivec2(ivec2(-8, 3), s1.b.mC.mA.mC) && allOk;
	allOk = compare_uvec3(uvec3(6u, 2u, 9u), s1.b.mC.mB[0]) && allOk;
	allOk = compare_uvec3(uvec3(2u, 6u, 1u), s1.b.mC.mB[1]) && allOk;
	allOk = compare_bool(true, s1.b.mC.mC.mA) && allOk;
	allOk = compare_i8vec3(ivec3(-6, 2, -4), ivec3(s1.b.mC.mC.mB)) && allOk;
	allOk = compare_i8vec2(ivec2(9, 9), ivec2(s1.c.mA.mA.mA)) && allOk;
	allOk = compare_u8vec3(uvec3(3u, 8u, 9u), uvec3(s1.c.mA.mB.mA)) && allOk;
	allOk = compare_u8vec4(uvec4(7u, 2u, 6u, 6u), uvec4(s1.c.mA.mB.mB)) && allOk;
	allOk = compare_bool(false, s1.c.mA.mC.mA) && allOk;
	allOk = compare_mat2(mat2(7.0, -9.0, -3.0, 0.0), s1.d.mA.mA.mA) && allOk;
	allOk = compare_ivec4(ivec4(4, -7, -1, 1), s1.d.mB.mA.mA) && allOk;
	allOk = compare_u8vec4(uvec4(1u, 2u, 2u, 8u), uvec4(s1.d.mB.mB.mA)) && allOk;
	allOk = compare_i8vec2(ivec2(6, -8), ivec2(s2.a.mA.mA.mA)) && allOk;
	allOk = compare_i8vec4(ivec4(-5, 5, -2, -5), ivec4(s2.a.mA.mB[0])) && allOk;
	allOk = compare_i8vec4(ivec4(9, 4, 7, -1), ivec4(s2.a.mA.mB[1])) && allOk;
	allOk = compare_i8vec4(ivec4(-6, 2, 0, -9), ivec4(s2.a.mA.mB[2])) && allOk;
	allOk = compare_mat3x2(mat3x2(8.0, 3.0, -7.0, -1.0, 0.0, -2.0), s2.a.mA.mC[0]) && allOk;
	allOk = compare_mat3x2(mat3x2(-9.0, 1.0, 1.0, -3.0, -4.0, 0.0), s2.a.mA.mC[1]) && allOk;
	allOk = compare_u8vec2(uvec2(6u, 0u), uvec2(s2.b.mA[0][0])) && allOk;
	allOk = compare_u8vec2(uvec2(3u, 3u), uvec2(s2.b.mA[0][1])) && allOk;
	allOk = compare_u8vec2(uvec2(8u, 2u), uvec2(s2.b.mA[0][2])) && allOk;
	allOk = compare_u8vec2(uvec2(6u, 1u), uvec2(s2.b.mA[1][0])) && allOk;
	allOk = compare_u8vec2(uvec2(7u, 0u), uvec2(s2.b.mA[1][1])) && allOk;
	allOk = compare_u8vec2(uvec2(5u, 6u), uvec2(s2.b.mA[1][2])) && allOk;
	allOk = compare_int8_t(int(2), int(s2.c)) && allOk;
	allOk = compare_u8vec3(uvec3(4u, 9u, 3u), uvec3(s2.d.mA.mA.mA)) && allOk;
	allOk = compare_bvec4(bvec4(false, true, true, false), s2.d.mA.mA.mB) && allOk;
	allOk = compare_bvec4(bvec4(false, true, false, true), s2.d.mA.mB.mA) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	bvec3 mA;
	bvec2 mB;
};
struct sB
{
	u8vec3 mA;
	mediump uvec4 mB;
};
struct sC
{
	lowp mat2x3 mA;
	int8_t mB;
};
struct sD
{
	sA mA;
	sB mB;
	sC mC;
};
struct sE
{
	int8_t mA[1];
};
struct sF
{
	bool mA;
	highp float mB;
};
struct sG
{
	u8vec4 mA;
	u8vec3 mB;
};
struct sH
{
	sF mA;
	u8vec2 mB[1];
	sG mC;
};
struct sI
{
	sD mA;
	sE mB;
	sH mC;
};
struct sJ
{
	i8vec2 mA[2];
	uint8_t mB;
};
struct sK
{
	u8vec4 mA;
	mediump mat4 mB;
};
struct sL
{
	i8vec4 mA;
	sK mB;
};
struct sM
{
	lowp ivec2 mA;
	highp mat4x3 mB;
};
struct sN
{
	lowp vec4 mA;
	u8vec3 mB;
};
struct sO
{
	sM mA;
	sN mB;
};
struct sP
{
	i8vec2 mA;
	sL mB;
	sO mC;
};
struct sQ
{
	uint8_t mA;
	u8vec3 mB;
};
struct sR
{
	sQ mA;
};
struct sS
{
	i8vec2 mA[1];
};
struct sT
{
	int8_t mA;
	mediump mat4x2 mB;
	highp float mC;
};
struct sU
{
	uint8_t mA;
	lowp int mB;
	bvec2 mC;
};
struct sV
{
	lowp int mA;
	u8vec2 mB;
	lowp vec3 mC;
};
struct sW
{
	sT mA;
	sU mB;
	sV mC;
};
struct sX
{
	sR mA;
	sS mB;
	sW mC;
};
struct sY
{
	i8vec3 mA;
	u8vec3 mB;
};
struct sZ
{
	sY mA;
	u8vec2 mB[2];
};
struct sAA
{
	i8vec3 mA;
};
struct sAB
{
	sAA mA;
};
struct sAC
{
	sAB mA;
};
struct sAD
{
	i8vec4 mA;
	i8vec4 mB;
};
struct sAE
{
	sAD mA;
};
struct sAF
{
	i8vec3 mA;
	u8vec3 mB;
};
struct sAG
{
	sAF mA;
};
struct sAH
{
	sAG mA;
};
struct S1 {
	sI a;
	sJ b[3];
	sP c;
	sX d;
};
struct S2 {
	sZ a[1];
	sAC b;
	sAE c[3];
	sAH d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a.mA.mA.mA = bvec3(true, true, true);
	s1.a.mA.mA.mB = bvec2(true, true);
	s1.a.mA.mB.mA = u8vec3(1u, 3u, 0u);
	s1.a.mA.mB.mB = uvec4(5u, 9u, 0u, 9u);
	s1.a.mA.mC.mA = mat2x3(-2.0, -1.0, 5.0, 2.0, -4.0, 7.0);
	s1.a.mA.mC.mB = int8_t(7);
	s1.a.mB.mA[0] = int8_t(-1);
	s1.a.mC.mA.mA = false;
	s1.a.mC.mA.mB = -2.0;
	s1.a.mC.mB[0] = u8vec2(1u, 0u);
	s1.a.mC.mC.mA = u8vec4(4u, 5u, 5u, 1u);
	s1.a.mC.mC.mB = u8vec3(3u, 3u, 2u);
	s1.b[0].mA[0] = i8vec2(4, -8);
	s1.b[0].mA[1] = i8vec2(-3, -1);
	s1.b[0].mB = uint8_t(9u);
	s1.b[1].mA[0] = i8vec2(-9, 7);
	s1.b[1].mA[1] = i8vec2(1, -4);
	s1.b[1].mB = uint8_t(5u);
	s1.b[2].mA[0] = i8vec2(-6, 0);
	s1.b[2].mA[1] = i8vec2(6, 8);
	s1.b[2].mB = uint8_t(1u);
	s1.c.mA = i8vec2(9, -3);
	s1.c.mB.mA = i8vec4(2, 2, 3, 3);
	s1.c.mB.mB.mA = u8vec4(9u, 8u, 9u, 9u);
	s1.c.mB.mB.mB = mat4(8.0, 3.0, -1.0, 0.0, -6.0, -5.0, -3.0, -5.0, 2.0, -9.0, 0.0, 5.0, -4.0, 4.0, -4.0, -1.0);
	s1.c.mC.mA.mA = ivec2(-4, -1);
	s1.c.mC.mA.mB = mat4x3(-1.0, -1.0, 9.0, -4.0, -4.0, -8.0, 9.0, -5.0, 7.0, -8.0, -2.0, -1.0);
	s1.c.mC.mB.mA = vec4(4.0, 5.0, 7.0, -9.0);
	s1.c.mC.mB.mB = u8vec3(2u, 2u, 5u);
	s1.d.mA.mA.mA = uint8_t(1u);
	s1.d.mA.mA.mB = u8vec3(6u, 2u, 9u);
	s1.d.mB.mA[0] = i8vec2(-5, -3);
	s1.d.mC.mA.mA = int8_t(3);
	s1.d.mC.mA.mB = mat4x2(4.0, -7.0, 0.0, 2.0, -2.0, 2.0, 3.0, 2.0);
	s1.d.mC.mA.mC = 0.0;
	s1.d.mC.mB.mA = uint8_t(7u);
	s1.d.mC.mB.mB = 3;
	s1.d.mC.mB.mC = bvec2(false, false);
	s1.d.mC.mC.mA = 6;
	s1.d.mC.mC.mB = u8vec2(6u, 9u);
	s1.d.mC.mC.mC = vec3(1.0, -3.0, 4.0);
	s2.a[0].mA.mA = i8vec3(-2, 5, -7);
	s2.a[0].mA.mB = u8vec3(6u, 3u, 6u);
	s2.a[0].mB[0] = u8vec2(1u, 1u);
	s2.a[0].mB[1] = u8vec2(8u, 4u);
	s2.b.mA.mA.mA = i8vec3(-6, 8, -9);
	s2.c[0].mA.mA = i8vec4(1, -7, 6, -9);
	s2.c[0].mA.mB = i8vec4(8, -6, 4, 1);
	s2.c[1].mA.mA = i8vec4(-3, 0, 9, -2);
	s2.c[1].mA.mB = i8vec4(9, 9, -5, 8);
	s2.c[2].mA.mA = i8vec4(-7, -5, -3, 0);
	s2.c[2].mA.mB = i8vec4(-9, -8, -3, -5);
	s2.d.mA.mA.mA = i8vec3(5, 6, 1);
	s2.d.mA.mA.mB = u8vec3(1u, 2u, 3u);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_bvec3(bvec3(true, true, true), s1.a.mA.mA.mA) && allOk;
	allOk = compare_bvec2(bvec2(true, true), s1.a.mA.mA.mB) && allOk;
	allOk = compare_u8vec3(uvec3(1u, 3u, 0u), uvec3(s1.a.mA.mB.mA)) && allOk;
	allOk = compare_uvec4(uvec4(5u, 9u, 0u, 9u), s1.a.mA.mB.mB) && allOk;
	allOk = compare_mat2x3(mat2x3(-2.0, -1.0, 5.0, 2.0, -4.0, 7.0), s1.a.mA.mC.mA) && allOk;
	allOk = compare_int8_t(int(7), int(s1.a.mA.mC.mB)) && allOk;
	allOk = compare_int8_t(int(-1), int(s1.a.mB.mA[0])) && allOk;
	allOk = compare_bool(false, s1.a.mC.mA.mA) && allOk;
	allOk = compare_float(-2.0, s1.a.mC.mA.mB) && allOk;
	allOk = compare_u8vec2(uvec2(1u, 0u), uvec2(s1.a.mC.mB[0])) && allOk;
	allOk = compare_u8vec4(uvec4(4u, 5u, 5u, 1u), uvec4(s1.a.mC.mC.mA)) && allOk;
	allOk = compare_u8vec3(uvec3(3u, 3u, 2u), uvec3(s1.a.mC.mC.mB)) && allOk;
	allOk = compare_i8vec2(ivec2(4, -8), ivec2(s1.b[0].mA[0])) && allOk;
	allOk = compare_i8vec2(ivec2(-3, -1), ivec2(s1.b[0].mA[1])) && allOk;
	allOk = compare_uint8_t(uint(9u), uint(s1.b[0].mB)) && allOk;
	allOk = compare_i8vec2(ivec2(-9, 7), ivec2(s1.b[1].mA[0])) && allOk;
	allOk = compare_i8vec2(ivec2(1, -4), ivec2(s1.b[1].mA[1])) && allOk;
	allOk = compare_uint8_t(uint(5u), uint(s1.b[1].mB)) && allOk;
	allOk = compare_i8vec2(ivec2(-6, 0), ivec2(s1.b[2].mA[0])) && allOk;
	allOk = compare_i8vec2(ivec2(6, 8), ivec2(s1.b[2].mA[1])) && allOk;
	allOk = compare_uint8_t(uint(1u), uint(s1.b[2].mB)) && allOk;
	allOk = compare_i8vec2(ivec2(9, -3), ivec2(s1.c.mA)) && allOk;
	allOk = compare_i8vec4(ivec4(2, 2, 3, 3), ivec4(s1.c.mB.mA)) && allOk;
	allOk = compare_u8vec4(uvec4(9u, 8u, 9u, 9u), uvec4(s1.c.mB.mB.mA)) && allOk;
	allOk = compare_mat4(mat4(8.0, 3.0, -1.0, 0.0, -6.0, -5.0, -3.0, -5.0, 2.0, -9.0, 0.0, 5.0, -4.0, 4.0, -4.0, -1.0), s1.c.mB.mB.mB) && allOk;
	allOk = compare_ivec2(ivec2(-4, -1), s1.c.mC.mA.mA) && allOk;
	allOk = compare_mat4x3(mat4x3(-1.0, -1.0, 9.0, -4.0, -4.0, -8.0, 9.0, -5.0, 7.0, -8.0, -2.0, -1.0), s1.c.mC.mA.mB) && allOk;
	allOk = compare_vec4(vec4(4.0, 5.0, 7.0, -9.0), s1.c.mC.mB.mA) && allOk;
	allOk = compare_u8vec3(uvec3(2u, 2u, 5u), uvec3(s1.c.mC.mB.mB)) && allOk;
	allOk = compare_uint8_t(uint(1u), uint(s1.d.mA.mA.mA)) && allOk;
	allOk = compare_u8vec3(uvec3(6u, 2u, 9u), uvec3(s1.d.mA.mA.mB)) && allOk;
	allOk = compare_i8vec2(ivec2(-5, -3), ivec2(s1.d.mB.mA[0])) && allOk;
	allOk = compare_int8_t(int(3), int(s1.d.mC.mA.mA)) && allOk;
	allOk = compare_mat4x2(mat4x2(4.0, -7.0, 0.0, 2.0, -2.0, 2.0, 3.0, 2.0), s1.d.mC.mA.mB) && allOk;
	allOk = compare_float(0.0, s1.d.mC.mA.mC) && allOk;
	allOk = compare_uint8_t(uint(7u), uint(s1.d.mC.mB.mA)) && allOk;
	allOk = compare_int(3, s1.d.mC.mB.mB) && allOk;
	allOk = compare_bvec2(bvec2(false, false), s1.d.mC.mB.mC) && allOk;
	allOk = compare_int(6, s1.d.mC.mC.mA) && allOk;
	allOk = compare_u8vec2(uvec2(6u, 9u), uvec2(s1.d.mC.mC.mB)) && allOk;
	allOk = compare_vec3(vec3(1.0, -3.0, 4.0), s1.d.mC.mC.mC) && allOk;
	allOk = compare_i8vec3(ivec3(-2, 5, -7), ivec3(s2.a[0].mA.mA)) && allOk;
	allOk = compare_u8vec3(uvec3(6u, 3u, 6u), uvec3(s2.a[0].mA.mB)) && allOk;
	allOk = compare_u8vec2(uvec2(1u, 1u), uvec2(s2.a[0].mB[0])) && allOk;
	allOk = compare_u8vec2(uvec2(8u, 4u), uvec2(s2.a[0].mB[1])) && allOk;
	allOk = compare_i8vec3(ivec3(-6, 8, -9), ivec3(s2.b.mA.mA.mA)) && allOk;
	allOk = compare_i8vec4(ivec4(1, -7, 6, -9), ivec4(s2.c[0].mA.mA)) && allOk;
	allOk = compare_i8vec4(ivec4(8, -6, 4, 1), ivec4(s2.c[0].mA.mB)) && allOk;
	allOk = compare_i8vec4(ivec4(-3, 0, 9, -2), ivec4(s2.c[1].mA.mA)) && allOk;
	allOk = compare_i8vec4(ivec4(9, 9, -5, 8), ivec4(s2.c[1].mA.mB)) && allOk;
	allOk = compare_i8vec4(ivec4(-7, -5, -3, 0), ivec4(s2.c[2].mA.mA)) && allOk;
	allOk = compare_i8vec4(ivec4(-9, -8, -3, -5), ivec4(s2.c[2].mA.mB)) && allOk;
	allOk = compare_i8vec3(ivec3(5, 6, 1), ivec3(s2.d.mA.mA.mA)) && allOk;
	allOk = compare_u8vec3(uvec3(1u, 2u, 3u), uvec3(s2.d.mA.mA.mB)) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	uint8_t mA;
};
struct sB
{
	sA mA;
	mediump uvec2 mB[1];
};
struct sC
{
	lowp mat2x3 mA;
};
struct sD
{
	sC mA;
};
struct sE
{
	i8vec4 mA;
	lowp mat4x3 mB;
	i8vec4 mC;
};
struct sF
{
	i8vec4 mA;
	mediump mat3x2 mB;
};
struct sG
{
	sE mA[2];
	sF mB[1];
};
struct sH
{
	lowp mat3 mA[1];
	int8_t mB[3];
	mediump mat4x2 mC[1];
};
struct sI
{
	uint8_t mA;
	mediump mat3x4 mB;
};
struct sJ
{
	sI mA;
};
struct sK
{
	sH mA;
	sJ mB;
};
struct sL
{
	int8_t mA;
	u8vec2 mB;
	highp vec2 mC;
};
struct sM
{
	i8vec4 mA;
};
struct sN
{
	sL mA;
	sM mB;
};
struct sO
{
	sN mA;
	u8vec4 mB[1][1];
	i8vec3 mC[2];
};
struct S1 {
	sB a[3];
	sD b[3];
};
struct S2 {
	sG a;
	sK b;
	sO c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

shared S1 s1;
shared S2 s2;

void main (void) {
	s1.a[0].mA.mA = uint8_t(2u);
	s1.a[0].mB[0] = uvec2(5u, 1u);
	s1.a[1].mA.mA = uint8_t(9u);
	s1.a[1].mB[0] = uvec2(5u, 7u);
	s1.a[2].mA.mA = uint8_t(9u);
	s1.a[2].mB[0] = uvec2(2u, 0u);
	s1.b[0].mA.mA = mat2x3(-1.0, 4.0, -7.0, 3.0, 8.0, 1.0);
	s1.b[1].mA.mA = mat2x3(9.0, 5.0, -4.0, 1.0, -4.0, -4.0);
	s1.b[2].mA.mA = mat2x3(-3.0, 1.0, 5.0, 6.0, 9.0, 0.0);
	s2.a.mA[0].mA = i8vec4(1, -3, 1, 6);
	s2.a.mA[0].mB = mat4x3(6.0, 6.0, -8.0, 6.0, 6.0, 5.0, 1.0, 4.0, 6.0, -4.0, 0.0, 1.0);
	s2.a.mA[0].mC = i8vec4(2, -1, 9, -9);
	s2.a.mA[1].mA = i8vec4(9, 3, -9, 3);
	s2.a.mA[1].mB = mat4x3(5.0, 2.0, 3.0, 1.0, -6.0, -5.0, 9.0, 1.0, 5.0, -7.0, 6.0, -1.0);
	s2.a.mA[1].mC = i8vec4(-9, -5, 8, 5);
	s2.a.mB[0].mA = i8vec4(-4, -1, -8, 4);
	s2.a.mB[0].mB = mat3x2(-7.0, 1.0, 4.0, -2.0, 0.0, -1.0);
	s2.b.mA.mA[0] = mat3(-3.0, -7.0, 2.0, 3.0, 2.0, 6.0, -6.0, 8.0, 2.0);
	s2.b.mA.mB[0] = int8_t(-5);
	s2.b.mA.mB[1] = int8_t(9);
	s2.b.mA.mB[2] = int8_t(-2);
	s2.b.mA.mC[0] = mat4x2(9.0, 9.0, 2.0, 1.0, -5.0, 8.0, -5.0, 3.0);
	s2.b.mB.mA.mA = uint8_t(7u);
	s2.b.mB.mA.mB = mat3x4(6.0, -8.0, 6.0, 4.0, 4.0, -7.0, -3.0, 7.0, -3.0, 9.0, -7.0, -5.0);
	s2.c.mA.mA.mA = int8_t(-7);
	s2.c.mA.mA.mB = u8vec2(3u, 4u);
	s2.c.mA.mA.mC = vec2(3.0, 2.0);
	s2.c.mA.mB.mA = i8vec4(-6, -2, 1, 6);
	s2.c.mB[0][0] = u8vec4(3u, 9u, 2u, 3u);
	s2.c.mC[0] = i8vec3(-1, -2, -6);
	s2.c.mC[1] = i8vec3(-9, 1, 9);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_uint8_t(uint(2u), uint(s1.a[0].mA.mA)) && allOk;
	allOk = compare_uvec2(uvec2(5u, 1u), s1.a[0].mB[0]) && allOk;
	allOk = compare_uint8_t(uint(9u), uint(s1.a[1].mA.mA)) && allOk;
	allOk = compare_uvec2(uvec2(5u, 7u), s1.a[1].mB[0]) && allOk;
	allOk = compare_uint8_t(uint(9u), uint(s1.a[2].mA.mA)) && allOk;
	allOk = compare_uvec2(uvec2(2u, 0u), s1.a[2].mB[0]) && allOk;
	allOk = compare_mat2x3(mat2x3(-1.0, 4.0, -7.0, 3.0, 8.0, 1.0), s1.b[0].mA.mA) && allOk;
	allOk = compare_mat2x3(mat2x3(9.0, 5.0, -4.0, 1.0, -4.0, -4.0), s1.b[1].mA.mA) && allOk;
	allOk = compare_mat2x3(mat2x3(-3.0, 1.0, 5.0, 6.0, 9.0, 0.0), s1.b[2].mA.mA) && allOk;
	allOk = compare_i8vec4(ivec4(1, -3, 1, 6), ivec4(s2.a.mA[0].mA)) && allOk;
	allOk = compare_mat4x3(mat4x3(6.0, 6.0, -8.0, 6.0, 6.0, 5.0, 1.0, 4.0, 6.0, -4.0, 0.0, 1.0), s2.a.mA[0].mB) && allOk;
	allOk = compare_i8vec4(ivec4(2, -1, 9, -9), ivec4(s2.a.mA[0].mC)) && allOk;
	allOk = compare_i8vec4(ivec4(9, 3, -9, 3), ivec4(s2.a.mA[1].mA)) && allOk;
	allOk = compare_mat4x3(mat4x3(5.0, 2.0, 3.0, 1.0, -6.0, -5.0, 9.0, 1.0, 5.0, -7.0, 6.0, -1.0), s2.a.mA[1].mB) && allOk;
	allOk = compare_i8vec4(ivec4(-9, -5, 8, 5), ivec4(s2.a.mA[1].mC)) && allOk;
	allOk = compare_i8vec4(ivec4(-4, -1, -8, 4), ivec4(s2.a.mB[0].mA)) && allOk;
	allOk = compare_mat3x2(mat3x2(-7.0, 1.0, 4.0, -2.0, 0.0, -1.0), s2.a.mB[0].mB) && allOk;
	allOk = compare_mat3(mat3(-3.0, -7.0, 2.0, 3.0, 2.0, 6.0, -6.0, 8.0, 2.0), s2.b.mA.mA[0]) && allOk;
	allOk = compare_int8_t(int(-5), int(s2.b.mA.mB[0])) && allOk;
	allOk = compare_int8_t(int(9), int(s2.b.mA.mB[1])) && allOk;
	allOk = compare_int8_t(int(-2), int(s2.b.mA.mB[2])) && allOk;
	allOk = compare_mat4x2(mat4x2(9.0, 9.0, 2.0, 1.0, -5.0, 8.0, -5.0, 3.0), s2.b.mA.mC[0]) && allOk;
	allOk = compare_uint8_t(uint(7u), uint(s2.b.mB.mA.mA)) && allOk;
	allOk = compare_mat3x4(mat3x4(6.0, -8.0, 6.0, 4.0, 4.0, -7.0, -3.0, 7.0, -3.0, 9.0, -7.0, -5.0), s2.b.mB.mA.mB) && allOk;
	allOk = compare_int8_t(int(-7), int(s2.c.mA.mA.mA)) && allOk;
	allOk = compare_u8vec2(uvec2(3u, 4u), uvec2(s2.c.mA.mA.mB)) && allOk;
	allOk = compare_vec2(vec2(3.0, 2.0), s2.c.mA.mA.mC) && allOk;
	allOk = compare_i8vec4(ivec4(-6, -2, 1, 6), ivec4(s2.c.mA.mB.mA)) && allOk;
	allOk = compare_u8vec4(uvec4(3u, 9u, 2u, 3u), uvec4(s2.c.mB[0][0])) && allOk;
	allOk = compare_i8vec3(ivec3(-1, -2, -6), ivec3(s2.c.mC[0])) && allOk;
	allOk = compare_i8vec3(ivec3(-9, 1, 9), ivec3(s2.c.mC[1])) && allOk;
	if (allOk)
		passed++;

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer block { highp uint passed; };
struct sA
{
	i8vec4 mA;
};
struct sB
{
	sA mA[1];
	u8vec2 mB;
};
struct sC
{
	lowp vec2 mA[3][3];
};
struct sD
{
	i8vec3 mA;
	lowp ivec3 mB;
};
struct sE
{
	int8_t mA;
	lowp mat3x4 mB;
	mediump uvec4 mC;
};
struct sF
{
	int8_t mA;
};
struct sG
{
	sD mA;
	sE mB;
	sF mC;
};
struct sH
{
	i8vec2 mA;
};
struct sI
{
	highp mat4x3 mA;
	u8vec4 mB;
	i8vec3 mC;
};
struct sJ
{
	sH mA;
	sI mB;
};
struct sK
{
	highp uvec3 mA;
	highp uint mB;
};
struct sL
{
	u8vec3 mA;
	lowp mat2 mB;
};
struct sM
{
	i8vec3 mA;
};
struct sN
{
	sK mA;
	sL mB;
	sM mC;
};
struct sO
{
	sG mA;
	sJ mB;
	sN mC;
};
struct S1 {
	sB a;
	sC b;
	sO c;
	bvec3 d[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

shared S1 s1;

void main (void) {
	s1.a.mA[0].mA = i8vec4(1, -3, 9, 7);
	s1.a.mB = u8vec2(3u, 3u);
	s1.b.mA[0][0] = vec2(-1.0, -8.0);
	s1.b.mA[0][1] = vec2(2.0, -6.0);
	s1.b.mA[0][2] = vec2(5.0, -7.0);
	s1.b.mA[1][0] = vec2(2.0, 8.0);
	s1.b.mA[1][1] = vec2(8.0, 6.0);
	s1.b.mA[1][2] = vec2(-8.0, 7.0);
	s1.b.mA[2][0] = vec2(-1.0, 2.0);
	s1.b.mA[2][1] = vec2(2.0, 6.0);
	s1.b.mA[2][2] = vec2(1.0, 1.0);
	s1.c.mA.mA.mA = i8vec3(1, 6, -8);
	s1.c.mA.mA.mB = ivec3(-9, 0, -1);
	s1.c.mA.mB.mA = int8_t(-1);
	s1.c.mA.mB.mB = mat3x4(5.0, 4.0, 0.0, -1.0, -2.0, -9.0, 1.0, 0.0, 8.0, 0.0, 5.0, -7.0);
	s1.c.mA.mB.mC = uvec4(2u, 6u, 6u, 9u);
	s1.c.mA.mC.mA = int8_t(6);
	s1.c.mB.mA.mA = i8vec2(-8, 5);
	s1.c.mB.mB.mA = mat4x3(1.0, -4.0, 0.0, 4.0, -4.0, 0.0, 0.0, 8.0, -5.0, -1.0, -9.0, -9.0);
	s1.c.mB.mB.mB = u8vec4(0u, 8u, 9u, 9u);
	s1.c.mB.mB.mC = i8vec3(-9, 8, 9);
	s1.c.mC.mA.mA = uvec3(4u, 7u, 8u);
	s1.c.mC.mA.mB = 3u;
	s1.c.mC.mB.mA = u8vec3(3u, 5u, 9u);
	s1.c.mC.mB.mB = mat2(9.0, 5.0, -7.0, -3.0);
	s1.c.mC.mC.mA = i8vec3(-9, 5, 4);
	s1.d[0] = bvec3(true, true, false);
	s1.d[1] = bvec3(true, true, true);
	s1.d[2] = bvec3(false, true, true);

	barrier();
	memoryBarrier();
	bool allOk = true;
	allOk = compare_i8vec4(ivec4(1, -3, 9, 7), ivec4(s1.a.mA[0].mA)) && allOk;
	allOk = compare_u8vec2(uvec2(3u, 3u), uvec2(s1.a.mB)) && allOk;
	allOk = compare_vec2(vec2(-1.0, -8.0), s1.b.mA[0][0]) && allOk;
	allOk = compare_vec2(vec2(2.0, -6.0), s1.b.mA[0][1]) && allOk;
	allOk = compare_vec2(vec2(5.0, -7.0), s1.b.mA[0][2]) && allOk;
	allOk = compare_vec2(vec2(2.0, 8.0), s1.b.mA[1][0]) && allOk;
	allOk = compare_vec2(vec2(8.0, 6.0), s1.b.mA[1][1]) && allOk;
	allOk = compare_vec2(vec2(-8.0, 7.0), s1.b.mA[1][2]) && allOk;
	allOk = compare_vec2(vec2(-1.0, 2.0), s1.b.mA[2][0]) && allOk;
	allOk = compare_vec2(vec2(2.0, 6.0), s1.b.mA[2][1]) && allOk;
	allOk = compare_vec2(vec2(1.0, 1.0), s1.b.mA[2][2]) && allOk;
	allOk = compare_i8vec3(ivec3(1, 6, -8), ivec3(s1.c.mA.mA.mA)) && allOk;
	allOk = compare_ivec3(ivec3(-9, 0, -1), s1.c.mA.mA.mB) && allOk;
	allOk = compare_int8_t(int(-1), int(s1.c.mA.mB.mA)) && allOk;
	allOk = compare_mat3x4(mat3x4(5.0, 4.0, 0.0, -1.0, -2.0, -9.0, 1.0, 0.0, 8.0, 0.0, 5.0, -7.0), s1.c.mA.mB.mB) && allOk;
	allOk = compare_uvec4(uvec4(2u, 6u, 6u, 9u), s1.c.mA.mB.mC) && allOk;
	allOk = compare_int8_t(int(6), int(s1.c.mA.mC.mA)) && allOk;
	allOk = compare_i8vec2(ivec2(-8, 5), ivec2(s1.c.mB.mA.mA)) && allOk;
	allOk = compare_mat4x3(mat4x3(1.0, -4.0, 0.0, 4.0, -4.0, 0.0, 0.0, 8.0, -5.0, -1.0, -9.0, -9.0), s1.c.mB.mB.mA) && allOk;
	allOk = compare_u8vec4(uvec4(0u, 8u, 9u, 9u), uvec4(s1.c.mB.mB.mB)) && allOk;
	allOk = compare_i8vec3(ivec3(-9, 8, 9), ivec3(s1.c.mB.mB.mC)) && allOk;
	allOk = compare_uvec3(uvec3(4u, 7u, 8u), s1.c.mC.mA.mA) && allOk;
	allOk = compare_uint(3u, s1.c.mC.mA.mB) && allOk;
	allOk = compare_u8vec3(uvec3(3u, 5u, 9u), uvec3(s1.c.mC.mB.mA)) && allOk;
	allOk = compare_mat2(mat2(9.0, 5.0, -7.0, -3.0), s1.c.mC.mB.mB) && allOk;
	allOk = compare_i8vec3(ivec3(-9, 5, 4), ivec3(s1.c.mC.mC.mA)) && allOk;
	allOk = compare_bvec3(bvec3(true, true, false), s1.d[0]) && allOk;
	allOk = compare_bvec3(bvec3(true, true, true), s1.d[1]) && allOk;
	allOk = compare_bvec3(bvec3(false, true, true), s1.d[2]) && allOk;
	if (allOk)
		passed++;

}
