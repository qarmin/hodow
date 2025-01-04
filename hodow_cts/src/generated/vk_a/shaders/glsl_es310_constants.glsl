#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 0) flat out float out0;

void main()
{
    out0 = in0;
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
layout(location = 1) in float a_in0;
layout(location = 0) flat out float in0;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
}
#version 310 es
precision highp float;
bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;

void main()
{
    out0 = in0;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    out0 = in0;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(binding = 1, std140) uniform Uniforms
{
	float uni0;
};
layout(location = 0) flat out float out0;

void main()
{
    out0 = uni0;
    gl_Position = dEQP_Position;

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
layout(binding = 1, std140) uniform Uniforms
{
	float uni0;
};
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;

void main()
{
    out0 = uni0;
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
layout(binding = 1, std140) uniform Uniforms
{
	float uni0;
};
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
float out0;
highp vec4 dEQP_Position;

void main()
{
    out0 = uni0;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out float out0;

void main()
{
    out0 = +1.123;
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
    out0 = +1.123;
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
    out0 = +1.123;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out float out0;

void main()
{
    out0 = -1.123;
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
    out0 = -1.123;
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
    out0 = -1.123;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out float out0;

void main()
{
    out0 = 123.;
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
    out0 = 123.;
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
    out0 = 123.;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out float out0;

void main()
{
    out0 = .123;
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
    out0 = .123;
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
    out0 = .123;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out float out0;

void main()
{
    out0 = 1.23e+2;
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
    out0 = 1.23e+2;
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
    out0 = 1.23e+2;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out float out0;

void main()
{
    out0 = -1.23E+2;
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
    out0 = -1.23E+2;
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
    out0 = -1.23E+2;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out float out0;

void main()
{
    out0 = -1.23e2;
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
    out0 = -1.23e2;
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
    out0 = -1.23e2;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out float out0;

void main()
{
    out0 = 1.23e-1;
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
    out0 = 1.23e-1;
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
    out0 = 1.23e-1;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out float out0;

void main()
{
    out0 = 1e3;
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
    out0 = 1e3;
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
    out0 = 1e3;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out float out0;

void main ()
{
    
    float value = 1.0f;
    out0 = value;
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

void main ()
{
    
    float value = 1.0f;
    out0 = value;
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

void main ()
{
    
    float value = 1.0f;
    out0 = value;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out float out0;

void main ()
{
    
    float value = 1.0F;
    out0 = value;
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

void main ()
{
    
    float value = 1.0F;
    out0 = value;
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

void main ()
{
    
    float value = 1.0F;
    out0 = value;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out int out0;

void main()
{
    out0 = 123;
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
    out0 = 123;
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
    out0 = 123;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out int out0;

void main()
{
    out0 = -321;
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
    out0 = -321;
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
    out0 = -321;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out int out0;

void main()
{
    out0 = 0x7B;
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
    out0 = 0x7B;
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
    out0 = 0x7B;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out int out0;

void main()
{
    out0 = 0X7b;
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
    out0 = 0X7b;
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
    out0 = 0X7b;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out int out0;

void main()
{
    out0 = 0173;
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
    out0 = 0173;
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
    out0 = 0173;
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
    out0 = true;
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
    out0 = true;
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
    out0 = true;
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
    out0 = false;
    gl_Position = dEQP_Position;
v_out0 = uint(out0);

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
    out0 = false;
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
    out0 = false;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out float out0;

const float theConstant = 1000.0;
void main()
{
    out0 = theConstant;
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

const float theConstant = 1000.0;
void main()
{
    out0 = theConstant;
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

const float theConstant = 1000.0;
void main()
{
    out0 = theConstant;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out float out0;

void main()
{
        const float theConstant = -1000.0;
    out0 = theConstant;
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
        const float theConstant = -1000.0;
    out0 = theConstant;
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
        const float theConstant = -1000.0;
    out0 = theConstant;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out float out0;

float func()
{
        const float theConstant = -0.012;
    return theConstant;
}
void main()
{
    out0 = func();
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

float func()
{
        const float theConstant = -0.012;
    return theConstant;
}
void main()
{
    out0 = func();
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

float func()
{
        const float theConstant = -0.012;
    return theConstant;
}
void main()
{
    out0 = func();
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out float out0;

void main()
{
    {
         const float theConstant = 1.0;
         out0 = theConstant;
    }
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
    {
         const float theConstant = 1.0;
         out0 = theConstant;
    }
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
    {
         const float theConstant = 1.0;
         out0 = theConstant;
    }
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out float out0;

void main()
{
    const float theConstant = 100.0;
    {
         const float theConstant = 1.0;
         out0 = theConstant;
    }
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
    const float theConstant = 100.0;
    {
         const float theConstant = 1.0;
         out0 = theConstant;
    }
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
    const float theConstant = 100.0;
    {
         const float theConstant = 1.0;
         out0 = theConstant;
    }
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out float out0;

const float theConstant = 100.0;
void main()
{
    {
         const float theConstant = 1.0;
         out0 = theConstant;
    }
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

const float theConstant = 100.0;
void main()
{
    {
         const float theConstant = 1.0;
         out0 = theConstant;
    }
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

const float theConstant = 100.0;
void main()
{
    {
         const float theConstant = 1.0;
         out0 = theConstant;
    }
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out float out0;

const float theConstant = 100.0;
void main()
{
    const float theConstant = -100.0;
    {
         const float theConstant = 1.0;
         out0 = theConstant;
    }
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

const float theConstant = 100.0;
void main()
{
    const float theConstant = -100.0;
    {
         const float theConstant = 1.0;
         out0 = theConstant;
    }
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

const float theConstant = 100.0;
void main()
{
    const float theConstant = -100.0;
    {
         const float theConstant = 1.0;
         out0 = theConstant;
    }
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out float out0;

const float theConstant = 100.0;
float func()
{
    const float theConstant = 2.0;
    return theConstant;
}
void main()
{
    const float theConstant = -100.0;
    {
         const float theConstant = 1.0;
         out0 = func();
    }
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

const float theConstant = 100.0;
float func()
{
    const float theConstant = 2.0;
    return theConstant;
}
void main()
{
    const float theConstant = -100.0;
    {
         const float theConstant = 1.0;
         out0 = func();
    }
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

const float theConstant = 100.0;
float func()
{
    const float theConstant = 2.0;
    return theConstant;
}
void main()
{
    const float theConstant = -100.0;
    {
         const float theConstant = 1.0;
         out0 = func();
    }
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out float out0;

const float theGlobalConstant = 10.0;
float func()
{
    const float theConstant = 2.0;
    return theConstant;
}
void main()
{
    const float theConstant = -100.0;
    {
         const float theConstant = 1.0;
         out0 = func() * theGlobalConstant + theConstant;
    }
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

const float theGlobalConstant = 10.0;
float func()
{
    const float theConstant = 2.0;
    return theConstant;
}
void main()
{
    const float theConstant = -100.0;
    {
         const float theConstant = 1.0;
         out0 = func() * theGlobalConstant + theConstant;
    }
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

const float theGlobalConstant = 10.0;
float func()
{
    const float theConstant = 2.0;
    return theConstant;
}
void main()
{
    const float theConstant = -100.0;
    {
         const float theConstant = 1.0;
         out0 = func() * theGlobalConstant + theConstant;
    }
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out float out0;

void main()
{
    const float theConstant1 = 10.0;
    const float theConstant2 = theConstant1;
    out0 = theConstant2;
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
    const float theConstant1 = 10.0;
    const float theConstant2 = theConstant1;
    out0 = theConstant2;
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
    const float theConstant1 = 10.0;
    const float theConstant2 = theConstant1;
    out0 = theConstant2;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out float out0;

void main()
{
    const float theConstant1 = 10.0;
    {
        const float theConstant2 = theConstant1;
        out0 = theConstant2;
    }
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
    const float theConstant1 = 10.0;
    {
        const float theConstant2 = theConstant1;
        out0 = theConstant2;
    }
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
    const float theConstant1 = 10.0;
    {
        const float theConstant2 = theConstant1;
        out0 = theConstant2;
    }
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out float out0;

const float theConstant1 = 10.0;
void main()
{
    const float theConstant2 = theConstant1;
    out0 = theConstant2;
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

const float theConstant1 = 10.0;
void main()
{
    const float theConstant2 = theConstant1;
    out0 = theConstant2;
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

const float theConstant1 = 10.0;
void main()
{
    const float theConstant2 = theConstant1;
    out0 = theConstant2;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out float out0;

const float theConstant1 = 10.0;
float func()
{
    const float theConstant2 = theConstant1;
    return theConstant2;
}
void main()
{
    out0 = func();
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

const float theConstant1 = 10.0;
float func()
{
    const float theConstant2 = theConstant1;
    return theConstant2;
}
void main()
{
    out0 = func();
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

const float theConstant1 = 10.0;
float func()
{
    const float theConstant2 = theConstant1;
    return theConstant2;
}
void main()
{
    out0 = func();
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out float out0;

const float theConstant = float(10);
void main()
{
    out0 = theConstant;
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

const float theConstant = float(10);
void main()
{
    out0 = theConstant;
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

const float theConstant = float(10);
void main()
{
    out0 = theConstant;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out float out0;

const float theConstant = vec2(1.0, 10.0).y;
void main()
{
    out0 = theConstant;
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

const float theConstant = vec2(1.0, 10.0).y;
void main()
{
    out0 = theConstant;
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

const float theConstant = vec2(1.0, 10.0).y;
void main()
{
    out0 = theConstant;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out float out0;

const float theConstant = vec3(1.0, 10.0, 20.0).y;
void main()
{
    out0 = theConstant;
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

const float theConstant = vec3(1.0, 10.0, 20.0).y;
void main()
{
    out0 = theConstant;
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

const float theConstant = vec3(1.0, 10.0, 20.0).y;
void main()
{
    out0 = theConstant;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out float out0;

const float theConstant = vec4(1.0, 10.0, 20.0, -10.0).y;
void main()
{
    out0 = theConstant;
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

const float theConstant = vec4(1.0, 10.0, 20.0, -10.0).y;
void main()
{
    out0 = theConstant;
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

const float theConstant = vec4(1.0, 10.0, 20.0, -10.0).y;
void main()
{
    out0 = theConstant;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out int out0;

void main ()
{
    
    int value = 7;
    out0 = value;
    gl_Position = dEQP_Position;

}
#version 310 es
bool isOk (int a, int b)     { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
int out0;

void main ()
{
    
    int value = 7;
    out0 = value;
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
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

void main ()
{
    
    int value = 7;
    out0 = value;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out int out0;

void main ()
{
    
    int value = 017;
    out0 = value;
    gl_Position = dEQP_Position;

}
#version 310 es
bool isOk (int a, int b)     { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
int out0;

void main ()
{
    
    int value = 017;
    out0 = value;
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
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

void main ()
{
    
    int value = 017;
    out0 = value;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out int out0;

void main ()
{
    
    int value = 0x2f;
    out0 = value;
    gl_Position = dEQP_Position;

}
#version 310 es
bool isOk (int a, int b)     { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
int out0;

void main ()
{
    
    int value = 0x2f;
    out0 = value;
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
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

void main ()
{
    
    int value = 0x2f;
    out0 = value;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out int out0;

void main ()
{
    
    int value = 0X2f;
    out0 = value;
    gl_Position = dEQP_Position;

}
#version 310 es
bool isOk (int a, int b)     { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
int out0;

void main ()
{
    
    int value = 0X2f;
    out0 = value;
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
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

void main ()
{
    
    int value = 0X2f;
    out0 = value;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out uint out0;

void main ()
{
    
    uint value = 7u;
    out0 = value;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) out mediump vec4 dEQP_FragColor;

bool isOk (uint a, uint b)   { return (a == b); }

layout(location = 0) flat in uint out0;
layout(binding = 0, std140) uniform Reference
{
	uint out0;
} ref;

void main()
{
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);
}
#version 310 es
bool isOk (uint a, uint b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(binding = 0, std140) uniform Reference
{
	uint out0;
} ref;
uint out0;

void main ()
{
    
    uint value = 7u;
    out0 = value;
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(local_size_x = 1) in;

layout(binding = 0, std140) uniform Reference
{
	uint out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uint a, uint b)   { return (a == b); }
uint out0;
highp vec4 dEQP_Position;

void main ()
{
    
    uint value = 7u;
    out0 = value;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out uint out0;

void main ()
{
    
    uint value = 7U;
    out0 = value;
    gl_Position = dEQP_Position;

}
#version 310 es
bool isOk (uint a, uint b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(binding = 0, std140) uniform Reference
{
	uint out0;
} ref;
uint out0;

void main ()
{
    
    uint value = 7U;
    out0 = value;
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(local_size_x = 1) in;

layout(binding = 0, std140) uniform Reference
{
	uint out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uint a, uint b)   { return (a == b); }
uint out0;
highp vec4 dEQP_Position;

void main ()
{
    
    uint value = 7U;
    out0 = value;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out uint out0;

void main ()
{
    
    uint value = 0u;
    out0 = value;
    gl_Position = dEQP_Position;

}
#version 310 es
bool isOk (uint a, uint b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(binding = 0, std140) uniform Reference
{
	uint out0;
} ref;
uint out0;

void main ()
{
    
    uint value = 0u;
    out0 = value;
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(local_size_x = 1) in;

layout(binding = 0, std140) uniform Reference
{
	uint out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uint a, uint b)   { return (a == b); }
uint out0;
highp vec4 dEQP_Position;

void main ()
{
    
    uint value = 0u;
    out0 = value;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out uint out0;

void main ()
{
    
    uint value = 0U;
    out0 = value;
    gl_Position = dEQP_Position;

}
#version 310 es
bool isOk (uint a, uint b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(binding = 0, std140) uniform Reference
{
	uint out0;
} ref;
uint out0;

void main ()
{
    
    uint value = 0U;
    out0 = value;
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(local_size_x = 1) in;

layout(binding = 0, std140) uniform Reference
{
	uint out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uint a, uint b)   { return (a == b); }
uint out0;
highp vec4 dEQP_Position;

void main ()
{
    
    uint value = 0U;
    out0 = value;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out uint out0;

void main ()
{
    
    uint value = 017u;
    out0 = value;
    gl_Position = dEQP_Position;

}
#version 310 es
bool isOk (uint a, uint b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(binding = 0, std140) uniform Reference
{
	uint out0;
} ref;
uint out0;

void main ()
{
    
    uint value = 017u;
    out0 = value;
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(local_size_x = 1) in;

layout(binding = 0, std140) uniform Reference
{
	uint out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uint a, uint b)   { return (a == b); }
uint out0;
highp vec4 dEQP_Position;

void main ()
{
    
    uint value = 017u;
    out0 = value;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out uint out0;

void main ()
{
    
    uint value = 017U;
    out0 = value;
    gl_Position = dEQP_Position;

}
#version 310 es
bool isOk (uint a, uint b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(binding = 0, std140) uniform Reference
{
	uint out0;
} ref;
uint out0;

void main ()
{
    
    uint value = 017U;
    out0 = value;
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(local_size_x = 1) in;

layout(binding = 0, std140) uniform Reference
{
	uint out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uint a, uint b)   { return (a == b); }
uint out0;
highp vec4 dEQP_Position;

void main ()
{
    
    uint value = 017U;
    out0 = value;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out uint out0;

void main ()
{
    
    uint value = 0x2fU;
    out0 = value;
    gl_Position = dEQP_Position;

}
#version 310 es
bool isOk (uint a, uint b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(binding = 0, std140) uniform Reference
{
	uint out0;
} ref;
uint out0;

void main ()
{
    
    uint value = 0x2fU;
    out0 = value;
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(local_size_x = 1) in;

layout(binding = 0, std140) uniform Reference
{
	uint out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uint a, uint b)   { return (a == b); }
uint out0;
highp vec4 dEQP_Position;

void main ()
{
    
    uint value = 0x2fU;
    out0 = value;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out uint out0;

void main ()
{
    
    uint value = 0X2fu;
    out0 = value;
    gl_Position = dEQP_Position;

}
#version 310 es
bool isOk (uint a, uint b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(binding = 0, std140) uniform Reference
{
	uint out0;
} ref;
uint out0;

void main ()
{
    
    uint value = 0X2fu;
    out0 = value;
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(local_size_x = 1) in;

layout(binding = 0, std140) uniform Reference
{
	uint out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uint a, uint b)   { return (a == b); }
uint out0;
highp vec4 dEQP_Position;

void main ()
{
    
    uint value = 0X2fu;
    out0 = value;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
