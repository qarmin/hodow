#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out float out0;


void main()
{
    const float a = 5.0;
    out0 = a;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) out mediump vec4 dEQP_FragColor;

bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }

layout(location = 0) flat in float out0;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;

void main()
{
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);
}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;

void main()
{
    gl_Position = dEQP_Position;
}
#version 310 es
precision highp float;
bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;


void main()
{
    const float a = 5.0;
    out0 = a;
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
layout(local_size_x = 1) in;

layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
float out0;
highp vec4 dEQP_Position;


void main()
{
    const float a = 5.0;
    out0 = a;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out int out0;


void main()
{
    const int a = 5;
    out0 = a;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) out mediump vec4 dEQP_FragColor;

bool isOk (int a, int b)     { return (a == b); }

layout(location = 0) flat in int out0;
layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;

void main()
{
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);
}
#version 310 es
precision highp float;
bool isOk (int a, int b)     { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
int out0;


void main()
{
    const int a = 5;
    out0 = a;
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
layout(local_size_x = 1) in;

layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (int a, int b)     { return (a == b); }
int out0;
highp vec4 dEQP_Position;


void main()
{
    const int a = 5;
    out0 = a;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out uint v_out0;
bool out0;


void main()
{
    const bool a = true;
    out0 = a;
    gl_Position = dEQP_Position;
v_out0 = uint(out0);

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) out mediump vec4 dEQP_FragColor;

bool isOk (bool a, bool b)   { return (a == b); }

layout(location = 0) flat in uint v_out0;
layout(binding = 0, std140) uniform Reference
{
	bool out0;
} ref;

void main()
{
    bool out0 = bool(v_out0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);
}
#version 310 es
precision highp float;
bool isOk (bool a, bool b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(binding = 0, std140) uniform Reference
{
	bool out0;
} ref;
bool out0;


void main()
{
    const bool a = true;
    out0 = a;
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
layout(local_size_x = 1) in;

layout(binding = 0, std140) uniform Reference
{
	bool out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bool a, bool b)   { return (a == b); }
bool out0;
highp vec4 dEQP_Position;


void main()
{
    const bool a = true;
    out0 = a;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out float out0;


void main()
{
    const float a = float(int(bool(true)));
    out0 = a;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;


void main()
{
    const float a = float(int(bool(true)));
    out0 = a;
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
layout(local_size_x = 1) in;

layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
float out0;
highp vec4 dEQP_Position;


void main()
{
    const float a = float(int(bool(true)));
    out0 = a;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out float out0;


void main()
{
    const float a = 6.0/3.5 + 1.8*2.6 - 4.2;
    out0 = a;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;


void main()
{
    const float a = 6.0/3.5 + 1.8*2.6 - 4.2;
    out0 = a;
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
layout(local_size_x = 1) in;

layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
float out0;
highp vec4 dEQP_Position;


void main()
{
    const float a = 6.0/3.5 + 1.8*2.6 - 4.2;
    out0 = a;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out float out0;


void main()
{
    const vec3 a = (vec4(1.0, 2.0, 3.0, 4.0).zyx * vec3(1.0, 1.5, 3.0).xyz).xzy + (vec2(5.0)/vec2(2.5)).xxy;
    out0 = a.x + a.y + a.z;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;


void main()
{
    const vec3 a = (vec4(1.0, 2.0, 3.0, 4.0).zyx * vec3(1.0, 1.5, 3.0).xyz).xzy + (vec2(5.0)/vec2(2.5)).xxy;
    out0 = a.x + a.y + a.z;
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
layout(local_size_x = 1) in;

layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
float out0;
highp vec4 dEQP_Position;


void main()
{
    const vec3 a = (vec4(1.0, 2.0, 3.0, 4.0).zyx * vec3(1.0, 1.5, 3.0).xyz).xzy + (vec2(5.0)/vec2(2.5)).xxy;
    out0 = a.x + a.y + a.z;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out int out0;


void main()
{
    const int a = 25%7 + 2*3 - 9/3;
    out0 = a;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp int;
bool isOk (int a, int b)     { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
int out0;


void main()
{
    const int a = 25%7 + 2*3 - 9/3;
    out0 = a;
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp int;
layout(local_size_x = 1) in;

layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (int a, int b)     { return (a == b); }
int out0;
highp vec4 dEQP_Position;


void main()
{
    const int a = 25%7 + 2*3 - 9/3;
    out0 = a;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out int out0;


void main()
{
    const ivec3 a = ivec2(25%7, 4).xxy + ivec4(1*3, 9/3, 1+2, 8/4).xyz;
    out0 = a.x + a.y + a.z;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp int;
bool isOk (int a, int b)     { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
int out0;


void main()
{
    const ivec3 a = ivec2(25%7, 4).xxy + ivec4(1*3, 9/3, 1+2, 8/4).xyz;
    out0 = a.x + a.y + a.z;
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp int;
layout(local_size_x = 1) in;

layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (int a, int b)     { return (a == b); }
int out0;
highp vec4 dEQP_Position;


void main()
{
    const ivec3 a = ivec2(25%7, 4).xxy + ivec4(1*3, 9/3, 1+2, 8/4).xyz;
    out0 = a.x + a.y + a.z;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out float out0;


void main()
{
    const mat3 a = mat3(3.0) * mat3(4.0);
    const mat4 b = mat4(a[1][1])*2.0;
    const mat2 c = mat2(b[0][0]) / 3.0;
    out0 = c[0][0]+c[1][0];
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;


void main()
{
    const mat3 a = mat3(3.0) * mat3(4.0);
    const mat4 b = mat4(a[1][1])*2.0;
    const mat2 c = mat2(b[0][0]) / 3.0;
    out0 = c[0][0]+c[1][0];
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
layout(local_size_x = 1) in;

layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
float out0;
highp vec4 dEQP_Position;


void main()
{
    const mat3 a = mat3(3.0) * mat3(4.0);
    const mat4 b = mat4(a[1][1])*2.0;
    const mat2 c = mat2(b[0][0]) / 3.0;
    out0 = c[0][0]+c[1][0];
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out int out0;


void main()
{
    const int a = (((0xABBA<<4) ^ 0xCAFE) | (0xDCBA & (0xABCD>>2))) ^ (~0xDEAD & 0xBEEF);
    out0 = a;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp int;
bool isOk (int a, int b)     { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
int out0;


void main()
{
    const int a = (((0xABBA<<4) ^ 0xCAFE) | (0xDCBA & (0xABCD>>2))) ^ (~0xDEAD & 0xBEEF);
    out0 = a;
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp int;
layout(local_size_x = 1) in;

layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (int a, int b)     { return (a == b); }
int out0;
highp vec4 dEQP_Position;


void main()
{
    const int a = (((0xABBA<<4) ^ 0xCAFE) | (0xDCBA & (0xABCD>>2))) ^ (~0xDEAD & 0xBEEF);
    out0 = a;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out uint v_out0;
bool out0;


void main()
{
    const bool a = (!false || false) && (true ^^ false);
    out0 = a;
    gl_Position = dEQP_Position;
v_out0 = uint(out0);

}
#version 310 es
precision highp int;
bool isOk (bool a, bool b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(binding = 0, std140) uniform Reference
{
	bool out0;
} ref;
bool out0;


void main()
{
    const bool a = (!false || false) && (true ^^ false);
    out0 = a;
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp int;
layout(local_size_x = 1) in;

layout(binding = 0, std140) uniform Reference
{
	bool out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bool a, bool b)   { return (a == b); }
bool out0;
highp vec4 dEQP_Position;


void main()
{
    const bool a = (!false || false) && (true ^^ false);
    out0 = a;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out uint v_out0;
bool out0;


void main()
{
    const bool a = (false == false) && (true != false) && (1 < 2) && (3 <= 3) && ((1 > 1) != (1 >= 1));
    out0 = a;
    gl_Position = dEQP_Position;
v_out0 = uint(out0);

}
#version 310 es
precision highp int;
bool isOk (bool a, bool b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(binding = 0, std140) uniform Reference
{
	bool out0;
} ref;
bool out0;


void main()
{
    const bool a = (false == false) && (true != false) && (1 < 2) && (3 <= 3) && ((1 > 1) != (1 >= 1));
    out0 = a;
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp int;
layout(local_size_x = 1) in;

layout(binding = 0, std140) uniform Reference
{
	bool out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bool a, bool b)   { return (a == b); }
bool out0;
highp vec4 dEQP_Position;


void main()
{
    const bool a = (false == false) && (true != false) && (1 < 2) && (3 <= 3) && ((1 > 1) != (1 >= 1));
    out0 = a;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out float out0;


void main()
{
    const float a = false ? 0.0 : (true ? 5.3 : 1.0);
    out0 = a;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;


void main()
{
    const float a = false ? 0.0 : (true ? 5.3 : 1.0);
    out0 = a;
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
layout(local_size_x = 1) in;

layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
float out0;
highp vec4 dEQP_Position;


void main()
{
    const float a = false ? 0.0 : (true ? 5.3 : 1.0);
    out0 = a;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out float out0;


struct S
{
    vec4 a;
    int  b;
};

void main()
{
    const S s = S(vec4(1.5), 123);
    out0 = length(s.a.xy)*float(s.b);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;


struct S
{
    vec4 a;
    int  b;
};

void main()
{
    const S s = S(vec4(1.5), 123);
    out0 = length(s.a.xy)*float(s.b);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
layout(local_size_x = 1) in;

layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
float out0;
highp vec4 dEQP_Position;


struct S
{
    vec4 a;
    int  b;
};

void main()
{
    const S s = S(vec4(1.5), 123);
    out0 = length(s.a.xy)*float(s.b);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out float out0;


struct S
{
    vec4 v;
    int  i;
};

struct T
{
    S s;
    bool b;
    int i;
};

struct U
{
    S s;
    T t;
};

void main()
{
    const S s = S(vec4(1.5), 123);
    const T t = T(s, false, 3);
    const U u = U(s, t);
    const U v = U(S(vec4(1.3), 4), T(S(vec4(2.0), 5), true, 6));
    out0 = float(u.s.i*v.t.i + v.t.s.i)*v.s.v.x; // float(123*6 + 5)*1.3
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;


struct S
{
    vec4 v;
    int  i;
};

struct T
{
    S s;
    bool b;
    int i;
};

struct U
{
    S s;
    T t;
};

void main()
{
    const S s = S(vec4(1.5), 123);
    const T t = T(s, false, 3);
    const U u = U(s, t);
    const U v = U(S(vec4(1.3), 4), T(S(vec4(2.0), 5), true, 6));
    out0 = float(u.s.i*v.t.i + v.t.s.i)*v.s.v.x; // float(123*6 + 5)*1.3
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
layout(local_size_x = 1) in;

layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
float out0;
highp vec4 dEQP_Position;


struct S
{
    vec4 v;
    int  i;
};

struct T
{
    S s;
    bool b;
    int i;
};

struct U
{
    S s;
    T t;
};

void main()
{
    const S s = S(vec4(1.5), 123);
    const T t = T(s, false, 3);
    const U u = U(s, t);
    const U v = U(S(vec4(1.3), 4), T(S(vec4(2.0), 5), true, 6));
    out0 = float(u.s.i*v.t.i + v.t.s.i)*v.s.v.x; // float(123*6 + 5)*1.3
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out int out0;


void main()
{
    const int a[max(-1, 1)] = int[1](1);
    out0 = a[0];
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (int a, int b)     { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
int out0;


void main()
{
    const int a[max(-1, 1)] = int[1](1);
    out0 = a[0];
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
layout(local_size_x = 1) in;

layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (int a, int b)     { return (a == b); }
int out0;
highp vec4 dEQP_Position;


void main()
{
    const int a[max(-1, 1)] = int[1](1);
    out0 = a[0];
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out int out0;


void main()
{
    const int a[1] = int[1](1);
    out0 = a.length() + a[0];
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (int a, int b)     { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
int out0;


void main()
{
    const int a[1] = int[1](1);
    out0 = a.length() + a[0];
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
layout(local_size_x = 1) in;

layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (int a, int b)     { return (a == b); }
int out0;
highp vec4 dEQP_Position;


void main()
{
    const int a[1] = int[1](1);
    out0 = a.length() + a[0];
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out float out0;


void main()
{
    const float a[1+2+5] = float[8](0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0);
    const float f = a[1+2+4];
    out0 = f + float(a.length()-8);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;


void main()
{
    const float a[1+2+5] = float[8](0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0);
    const float f = a[1+2+4];
    out0 = f + float(a.length()-8);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
layout(local_size_x = 1) in;

layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
float out0;
highp vec4 dEQP_Position;


void main()
{
    const float a[1+2+5] = float[8](0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0);
    const float f = a[1+2+4];
    out0 = f + float(a.length()-8);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 0) flat out int out0;


void main()
{
    const int _0 = 0;
    const int _1 = 1;
    const int _2 = 2;
    const int _3 = 3;
    const int _4 = 4;

    switch(int(in0))
    {
        case _0:
            out0 = 0;
            break;
        case _1:
            out0 = 1;
            break;
        case _2:
            out0 = 2;
            break;
        case _3:
            out0 = 3;
            break;
        case _4:
            out0 = 4;
            break;
        case 5:
            out0 = 10;
            break;
        default:
            out0 = 100;

    }
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float a_in0;
layout(location = 0) flat out float in0;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
}
#version 310 es
precision highp float;
bool isOk (int a, int b)     { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
int out0;


void main()
{
    const int _0 = 0;
    const int _1 = 1;
    const int _2 = 2;
    const int _3 = 3;
    const int _4 = 4;

    switch(int(in0))
    {
        case _0:
            out0 = 0;
            break;
        case _1:
            out0 = 1;
            break;
        case _2:
            out0 = 2;
            break;
        case _3:
            out0 = 3;
            break;
        case _4:
            out0 = 4;
            break;
        case 5:
            out0 = 10;
            break;
        default:
            out0 = 100;

    }
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	float in0;
};

layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (int a, int b)     { return (a == b); }
int out0;
highp vec4 dEQP_Position;


void main()
{
    const int _0 = 0;
    const int _1 = 1;
    const int _2 = 2;
    const int _3 = 3;
    const int _4 = 4;

    switch(int(in0))
    {
        case _0:
            out0 = 0;
            break;
        case _1:
            out0 = 1;
            break;
        case _2:
            out0 = 2;
            break;
        case _3:
            out0 = 3;
            break;
        case _4:
            out0 = 4;
            break;
        case 5:
            out0 = 10;
            break;
        default:
            out0 = 100;

    }
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out float out0;


void main()
{
    const float a = sqrt( atan(sin(1.5)/cos(1.5)) /*1.5*/ * log2(exp2(log(exp(6.2) + 0.1)) + 0.1) /*~6.2*/);
    out0 = a;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;


void main()
{
    const float a = sqrt( atan(sin(1.5)/cos(1.5)) /*1.5*/ * log2(exp2(log(exp(6.2) + 0.1)) + 0.1) /*~6.2*/);
    out0 = a;
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
layout(local_size_x = 1) in;

layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
float out0;
highp vec4 dEQP_Position;


void main()
{
    const float a = sqrt( atan(sin(1.5)/cos(1.5)) /*1.5*/ * log2(exp2(log(exp(6.2) + 0.1)) + 0.1) /*~6.2*/);
    out0 = a;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 0) flat out int out0;


struct T
{
    vec4 v;
};

struct S
{
    T t;
    int i;
    bool b;
};

void main()
{
    const T   t  = T(vec4(1.0));
    const S   s  = S(t, 42, true);
    const int _0 = int(sin(0.0));
    const int _1 = int(1.0);
    const int _2 = 2 + int(float(_0>_1));
    const int _3 = min(gl_MaxVertexAttribs, 16)/4 - 1;
    const int _4 = min(gl_MaxDrawBuffers, 4);
    const ivec4 nums = ivec4(0, 1, 2, 3);

    switch(int(in0))
    {
        case int(float(_0)):
            out0 = ((true!=false) && (!false)) ? 0 : 25;
            break;
        case ivec3(_1).x:
            out0 = 3*18/9-5;
            break;
        case nums[_2]:
            out0 = int(length(vec4(1.0))+0.001);
            break;
        case _3:
            out0 = 3;
            break;
        case clamp(_4, 1, 6):
            out0 = (s.i-2)/10;
            break;
        case max(3, 5):
            out0 = 10;
            break;
        default:
            out0 = 100;

    }
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (int a, int b)     { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
int out0;


struct T
{
    vec4 v;
};

struct S
{
    T t;
    int i;
    bool b;
};

void main()
{
    const T   t  = T(vec4(1.0));
    const S   s  = S(t, 42, true);
    const int _0 = int(sin(0.0));
    const int _1 = int(1.0);
    const int _2 = 2 + int(float(_0>_1));
    const int _3 = min(gl_MaxVertexAttribs, 16)/4 - 1;
    const int _4 = min(gl_MaxDrawBuffers, 4);
    const ivec4 nums = ivec4(0, 1, 2, 3);

    switch(int(in0))
    {
        case int(float(_0)):
            out0 = ((true!=false) && (!false)) ? 0 : 25;
            break;
        case ivec3(_1).x:
            out0 = 3*18/9-5;
            break;
        case nums[_2]:
            out0 = int(length(vec4(1.0))+0.001);
            break;
        case _3:
            out0 = 3;
            break;
        case clamp(_4, 1, 6):
            out0 = (s.i-2)/10;
            break;
        case max(3, 5):
            out0 = 10;
            break;
        default:
            out0 = 100;

    }
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	float in0;
};

layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (int a, int b)     { return (a == b); }
int out0;
highp vec4 dEQP_Position;


struct T
{
    vec4 v;
};

struct S
{
    T t;
    int i;
    bool b;
};

void main()
{
    const T   t  = T(vec4(1.0));
    const S   s  = S(t, 42, true);
    const int _0 = int(sin(0.0));
    const int _1 = int(1.0);
    const int _2 = 2 + int(float(_0>_1));
    const int _3 = min(gl_MaxVertexAttribs, 16)/4 - 1;
    const int _4 = min(gl_MaxDrawBuffers, 4);
    const ivec4 nums = ivec4(0, 1, 2, 3);

    switch(int(in0))
    {
        case int(float(_0)):
            out0 = ((true!=false) && (!false)) ? 0 : 25;
            break;
        case ivec3(_1).x:
            out0 = 3*18/9-5;
            break;
        case nums[_2]:
            out0 = int(length(vec4(1.0))+0.001);
            break;
        case _3:
            out0 = 3;
            break;
        case clamp(_4, 1, 6):
            out0 = (s.i-2)/10;
            break;
        case max(3, 5):
            out0 = 10;
            break;
        default:
            out0 = 100;

    }
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
