#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 in0;
layout(location = 0) flat out float out0;


void main()
{
    
    out0 = float(in0);
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
layout(location = 1) in vec2 a_in0;
layout(location = 0) flat out vec2 in0;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec2 in0;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;


void main()
{
    
    out0 = float(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec2 in0;
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
    
    out0 = float(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 in0;
layout(location = 0) flat out int out0;


void main()
{
    
    out0 = int(in0);
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
precision highp int;

bool isOk (int a, int b)     { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec2 in0;
layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
int out0;


void main()
{
    
    out0 = int(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec2 in0;
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
    
    out0 = int(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 in0;
layout(location = 0) flat out uint v_out0;
bool out0;


void main()
{
    
    out0 = bool(in0);
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
precision highp int;

bool isOk (bool a, bool b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec2 in0;
layout(binding = 0, std140) uniform Reference
{
	bool out0;
} ref;
bool out0;


void main()
{
    
    out0 = bool(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec2 in0;
};

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
    
    out0 = bool(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 0) flat out float out0;


void main()
{
    
    out0 = float(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 a_in0;
layout(location = 0) flat out vec3 in0;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec3 in0;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;


void main()
{
    
    out0 = float(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec3 in0;
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
    
    out0 = float(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 0) flat out int out0;


void main()
{
    
    out0 = int(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (int a, int b)     { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec3 in0;
layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
int out0;


void main()
{
    
    out0 = int(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec3 in0;
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
    
    out0 = int(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 0) flat out uint v_out0;
bool out0;


void main()
{
    
    out0 = bool(in0);
    gl_Position = dEQP_Position;
v_out0 = uint(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bool a, bool b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec3 in0;
layout(binding = 0, std140) uniform Reference
{
	bool out0;
} ref;
bool out0;


void main()
{
    
    out0 = bool(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec3 in0;
};

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
    
    out0 = bool(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec4 in0;
layout(location = 0) flat out float out0;


void main()
{
    
    out0 = float(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec4 a_in0;
layout(location = 0) flat out vec4 in0;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec4 in0;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;


void main()
{
    
    out0 = float(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec4 in0;
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
    
    out0 = float(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec4 in0;
layout(location = 0) flat out int out0;


void main()
{
    
    out0 = int(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (int a, int b)     { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec4 in0;
layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
int out0;


void main()
{
    
    out0 = int(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec4 in0;
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
    
    out0 = int(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec4 in0;
layout(location = 0) flat out uint v_out0;
bool out0;


void main()
{
    
    out0 = bool(in0);
    gl_Position = dEQP_Position;
v_out0 = uint(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bool a, bool b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec4 in0;
layout(binding = 0, std140) uniform Reference
{
	bool out0;
} ref;
bool out0;


void main()
{
    
    out0 = bool(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec4 in0;
};

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
    
    out0 = bool(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec2 in0;
layout(location = 0) flat out float out0;


void main()
{
    
    out0 = float(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec2 a_in0;
layout(location = 0) flat out ivec2 in0;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec2 in0;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;


void main()
{
    
    out0 = float(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	ivec2 in0;
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
    
    out0 = float(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec2 in0;
layout(location = 0) flat out int out0;


void main()
{
    
    out0 = int(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (int a, int b)     { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec2 in0;
layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
int out0;


void main()
{
    
    out0 = int(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	ivec2 in0;
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
    
    out0 = int(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec2 in0;
layout(location = 0) flat out uint v_out0;
bool out0;


void main()
{
    
    out0 = bool(in0);
    gl_Position = dEQP_Position;
v_out0 = uint(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bool a, bool b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec2 in0;
layout(binding = 0, std140) uniform Reference
{
	bool out0;
} ref;
bool out0;


void main()
{
    
    out0 = bool(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	ivec2 in0;
};

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
    
    out0 = bool(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec3 in0;
layout(location = 0) flat out float out0;


void main()
{
    
    out0 = float(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec3 a_in0;
layout(location = 0) flat out ivec3 in0;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec3 in0;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;


void main()
{
    
    out0 = float(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	ivec3 in0;
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
    
    out0 = float(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec3 in0;
layout(location = 0) flat out int out0;


void main()
{
    
    out0 = int(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (int a, int b)     { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec3 in0;
layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
int out0;


void main()
{
    
    out0 = int(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	ivec3 in0;
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
    
    out0 = int(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec3 in0;
layout(location = 0) flat out uint v_out0;
bool out0;


void main()
{
    
    out0 = bool(in0);
    gl_Position = dEQP_Position;
v_out0 = uint(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bool a, bool b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec3 in0;
layout(binding = 0, std140) uniform Reference
{
	bool out0;
} ref;
bool out0;


void main()
{
    
    out0 = bool(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	ivec3 in0;
};

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
    
    out0 = bool(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec4 in0;
layout(location = 0) flat out float out0;


void main()
{
    
    out0 = float(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec4 a_in0;
layout(location = 0) flat out ivec4 in0;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec4 in0;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;


void main()
{
    
    out0 = float(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	ivec4 in0;
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
    
    out0 = float(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec4 in0;
layout(location = 0) flat out int out0;


void main()
{
    
    out0 = int(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (int a, int b)     { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec4 in0;
layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
int out0;


void main()
{
    
    out0 = int(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	ivec4 in0;
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
    
    out0 = int(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec4 in0;
layout(location = 0) flat out uint v_out0;
bool out0;


void main()
{
    
    out0 = bool(in0);
    gl_Position = dEQP_Position;
v_out0 = uint(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bool a, bool b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec4 in0;
layout(binding = 0, std140) uniform Reference
{
	bool out0;
} ref;
bool out0;


void main()
{
    
    out0 = bool(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	ivec4 in0;
};

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
    
    out0 = bool(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec2 in0;
layout(location = 0) flat out float out0;


void main()
{
    
    out0 = float(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec2 a_in0;
layout(location = 0) flat out uvec2 in0;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec2 in0;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;


void main()
{
    
    out0 = float(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uvec2 in0;
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
    
    out0 = float(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec2 in0;
layout(location = 0) flat out int out0;


void main()
{
    
    out0 = int(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (int a, int b)     { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec2 in0;
layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
int out0;


void main()
{
    
    out0 = int(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uvec2 in0;
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
    
    out0 = int(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec2 in0;
layout(location = 0) flat out uint v_out0;
bool out0;


void main()
{
    
    out0 = bool(in0);
    gl_Position = dEQP_Position;
v_out0 = uint(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bool a, bool b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec2 in0;
layout(binding = 0, std140) uniform Reference
{
	bool out0;
} ref;
bool out0;


void main()
{
    
    out0 = bool(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uvec2 in0;
};

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
    
    out0 = bool(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 in0;
layout(location = 0) flat out float out0;


void main()
{
    
    out0 = float(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 a_in0;
layout(location = 0) flat out uvec3 in0;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec3 in0;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;


void main()
{
    
    out0 = float(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uvec3 in0;
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
    
    out0 = float(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 in0;
layout(location = 0) flat out int out0;


void main()
{
    
    out0 = int(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (int a, int b)     { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec3 in0;
layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
int out0;


void main()
{
    
    out0 = int(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uvec3 in0;
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
    
    out0 = int(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 in0;
layout(location = 0) flat out uint v_out0;
bool out0;


void main()
{
    
    out0 = bool(in0);
    gl_Position = dEQP_Position;
v_out0 = uint(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bool a, bool b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec3 in0;
layout(binding = 0, std140) uniform Reference
{
	bool out0;
} ref;
bool out0;


void main()
{
    
    out0 = bool(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uvec3 in0;
};

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
    
    out0 = bool(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec4 in0;
layout(location = 0) flat out float out0;


void main()
{
    
    out0 = float(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec4 a_in0;
layout(location = 0) flat out uvec4 in0;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec4 in0;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;


void main()
{
    
    out0 = float(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uvec4 in0;
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
    
    out0 = float(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec4 in0;
layout(location = 0) flat out int out0;


void main()
{
    
    out0 = int(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (int a, int b)     { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec4 in0;
layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
int out0;


void main()
{
    
    out0 = int(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uvec4 in0;
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
    
    out0 = int(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec4 in0;
layout(location = 0) flat out uint v_out0;
bool out0;


void main()
{
    
    out0 = bool(in0);
    gl_Position = dEQP_Position;
v_out0 = uint(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bool a, bool b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec4 in0;
layout(binding = 0, std140) uniform Reference
{
	bool out0;
} ref;
bool out0;


void main()
{
    
    out0 = bool(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uvec4 in0;
};

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
    
    out0 = bool(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec2 a_in0;
layout(location = 0) flat out float out0;


void main()
{
    bvec2 in0 = bvec2(a_in0);

    out0 = float(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec2 a_in0;
layout(location = 0) flat out uvec2 v_in0;

void main()
{
    gl_Position = dEQP_Position;
    v_in0 = a_in0;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec2 v_in0;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;


void main()
{
    bvec2 in0 = bvec2(v_in0);

    out0 = float(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec2 in0;
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
    
    out0 = float(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec2 a_in0;
layout(location = 0) flat out int out0;


void main()
{
    bvec2 in0 = bvec2(a_in0);

    out0 = int(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (int a, int b)     { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec2 v_in0;
layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
int out0;


void main()
{
    bvec2 in0 = bvec2(v_in0);

    out0 = int(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec2 in0;
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
    
    out0 = int(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec2 a_in0;
layout(location = 0) flat out uint v_out0;
bool out0;


void main()
{
    bvec2 in0 = bvec2(a_in0);

    out0 = bool(in0);
    gl_Position = dEQP_Position;
v_out0 = uint(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bool a, bool b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec2 v_in0;
layout(binding = 0, std140) uniform Reference
{
	bool out0;
} ref;
bool out0;


void main()
{
    bvec2 in0 = bvec2(v_in0);

    out0 = bool(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec2 in0;
};

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
    
    out0 = bool(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 a_in0;
layout(location = 0) flat out float out0;


void main()
{
    bvec3 in0 = bvec3(a_in0);

    out0 = float(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 a_in0;
layout(location = 0) flat out uvec3 v_in0;

void main()
{
    gl_Position = dEQP_Position;
    v_in0 = a_in0;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec3 v_in0;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;


void main()
{
    bvec3 in0 = bvec3(v_in0);

    out0 = float(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec3 in0;
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
    
    out0 = float(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 a_in0;
layout(location = 0) flat out int out0;


void main()
{
    bvec3 in0 = bvec3(a_in0);

    out0 = int(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (int a, int b)     { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec3 v_in0;
layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
int out0;


void main()
{
    bvec3 in0 = bvec3(v_in0);

    out0 = int(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec3 in0;
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
    
    out0 = int(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 a_in0;
layout(location = 0) flat out uint v_out0;
bool out0;


void main()
{
    bvec3 in0 = bvec3(a_in0);

    out0 = bool(in0);
    gl_Position = dEQP_Position;
v_out0 = uint(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bool a, bool b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec3 v_in0;
layout(binding = 0, std140) uniform Reference
{
	bool out0;
} ref;
bool out0;


void main()
{
    bvec3 in0 = bvec3(v_in0);

    out0 = bool(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec3 in0;
};

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
    
    out0 = bool(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec4 a_in0;
layout(location = 0) flat out float out0;


void main()
{
    bvec4 in0 = bvec4(a_in0);

    out0 = float(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec4 a_in0;
layout(location = 0) flat out uvec4 v_in0;

void main()
{
    gl_Position = dEQP_Position;
    v_in0 = a_in0;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec4 v_in0;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;


void main()
{
    bvec4 in0 = bvec4(v_in0);

    out0 = float(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec4 in0;
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
    
    out0 = float(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec4 a_in0;
layout(location = 0) flat out int out0;


void main()
{
    bvec4 in0 = bvec4(a_in0);

    out0 = int(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (int a, int b)     { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec4 v_in0;
layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
int out0;


void main()
{
    bvec4 in0 = bvec4(v_in0);

    out0 = int(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec4 in0;
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
    
    out0 = int(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec4 a_in0;
layout(location = 0) flat out uint v_out0;
bool out0;


void main()
{
    bvec4 in0 = bvec4(a_in0);

    out0 = bool(in0);
    gl_Position = dEQP_Position;
v_out0 = uint(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bool a, bool b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec4 v_in0;
layout(binding = 0, std140) uniform Reference
{
	bool out0;
} ref;
bool out0;


void main()
{
    bvec4 in0 = bvec4(v_in0);

    out0 = bool(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec4 in0;
};

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
    
    out0 = bool(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 in0;
layout(location = 0) flat out uint out0;


void main()
{
    
    out0 = uint(in0);
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
precision highp float;
precision highp int;

bool isOk (uint a, uint b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec2 in0;
layout(binding = 0, std140) uniform Reference
{
	uint out0;
} ref;
uint out0;


void main()
{
    
    out0 = uint(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec2 in0;
};

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


void main()
{
    
    out0 = uint(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 0) flat out uint out0;


void main()
{
    
    out0 = uint(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uint a, uint b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec3 in0;
layout(binding = 0, std140) uniform Reference
{
	uint out0;
} ref;
uint out0;


void main()
{
    
    out0 = uint(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec3 in0;
};

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


void main()
{
    
    out0 = uint(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec4 in0;
layout(location = 0) flat out uint out0;


void main()
{
    
    out0 = uint(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uint a, uint b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec4 in0;
layout(binding = 0, std140) uniform Reference
{
	uint out0;
} ref;
uint out0;


void main()
{
    
    out0 = uint(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec4 in0;
};

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


void main()
{
    
    out0 = uint(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec2 in0;
layout(location = 0) flat out uint out0;


void main()
{
    
    out0 = uint(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uint a, uint b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec2 in0;
layout(binding = 0, std140) uniform Reference
{
	uint out0;
} ref;
uint out0;


void main()
{
    
    out0 = uint(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	ivec2 in0;
};

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


void main()
{
    
    out0 = uint(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec3 in0;
layout(location = 0) flat out uint out0;


void main()
{
    
    out0 = uint(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uint a, uint b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec3 in0;
layout(binding = 0, std140) uniform Reference
{
	uint out0;
} ref;
uint out0;


void main()
{
    
    out0 = uint(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	ivec3 in0;
};

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


void main()
{
    
    out0 = uint(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec4 in0;
layout(location = 0) flat out uint out0;


void main()
{
    
    out0 = uint(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uint a, uint b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec4 in0;
layout(binding = 0, std140) uniform Reference
{
	uint out0;
} ref;
uint out0;


void main()
{
    
    out0 = uint(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	ivec4 in0;
};

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


void main()
{
    
    out0 = uint(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec2 in0;
layout(location = 0) flat out uint out0;


void main()
{
    
    out0 = uint(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uint a, uint b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec2 in0;
layout(binding = 0, std140) uniform Reference
{
	uint out0;
} ref;
uint out0;


void main()
{
    
    out0 = uint(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uvec2 in0;
};

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


void main()
{
    
    out0 = uint(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 in0;
layout(location = 0) flat out uint out0;


void main()
{
    
    out0 = uint(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uint a, uint b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec3 in0;
layout(binding = 0, std140) uniform Reference
{
	uint out0;
} ref;
uint out0;


void main()
{
    
    out0 = uint(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uvec3 in0;
};

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


void main()
{
    
    out0 = uint(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec4 in0;
layout(location = 0) flat out uint out0;


void main()
{
    
    out0 = uint(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uint a, uint b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec4 in0;
layout(binding = 0, std140) uniform Reference
{
	uint out0;
} ref;
uint out0;


void main()
{
    
    out0 = uint(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uvec4 in0;
};

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


void main()
{
    
    out0 = uint(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec2 a_in0;
layout(location = 0) flat out uint out0;


void main()
{
    bvec2 in0 = bvec2(a_in0);

    out0 = uint(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uint a, uint b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec2 v_in0;
layout(binding = 0, std140) uniform Reference
{
	uint out0;
} ref;
uint out0;


void main()
{
    bvec2 in0 = bvec2(v_in0);

    out0 = uint(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec2 in0;
};

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


void main()
{
    
    out0 = uint(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 a_in0;
layout(location = 0) flat out uint out0;


void main()
{
    bvec3 in0 = bvec3(a_in0);

    out0 = uint(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uint a, uint b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec3 v_in0;
layout(binding = 0, std140) uniform Reference
{
	uint out0;
} ref;
uint out0;


void main()
{
    bvec3 in0 = bvec3(v_in0);

    out0 = uint(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec3 in0;
};

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


void main()
{
    
    out0 = uint(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec4 a_in0;
layout(location = 0) flat out uint out0;


void main()
{
    bvec4 in0 = bvec4(a_in0);

    out0 = uint(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uint a, uint b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec4 v_in0;
layout(binding = 0, std140) uniform Reference
{
	uint out0;
} ref;
uint out0;


void main()
{
    bvec4 in0 = bvec4(v_in0);

    out0 = uint(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec4 in0;
};

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


void main()
{
    
    out0 = uint(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec4 in0;
layout(location = 0) flat out vec4 out0;


void main()
{
    
    out0 = vec4(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) out mediump vec4 dEQP_FragColor;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }

layout(location = 0) flat in vec4 out0;
layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;

void main()
{
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec4 in0;
layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
vec4 out0;


void main()
{
    
    out0 = vec4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec4 in0;
layout(location = 0) flat out vec3 out0;


void main()
{
    
    out0 = vec3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) out mediump vec4 dEQP_FragColor;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }

layout(location = 0) flat in vec3 out0;
layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;

void main()
{
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec4 in0;
layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
vec3 out0;


void main()
{
    
    out0 = vec3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec4 in0;
layout(location = 0) flat out vec2 out0;


void main()
{
    
    out0 = vec2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) out mediump vec4 dEQP_FragColor;

bool isOk (vec2 a, vec2 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }

layout(location = 0) flat in vec2 out0;
layout(binding = 0, std140) uniform Reference
{
	vec2 out0;
} ref;

void main()
{
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec2 a, vec2 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec4 in0;
layout(binding = 0, std140) uniform Reference
{
	vec2 out0;
} ref;
vec2 out0;


void main()
{
    
    out0 = vec2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	vec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec2 a, vec2 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec4 in0;
layout(location = 0) flat out ivec4 out0;


void main()
{
    
    out0 = ivec4(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) out mediump vec4 dEQP_FragColor;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }

layout(location = 0) flat in ivec4 out0;
layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;

void main()
{
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec4 in0;
layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
ivec4 out0;


void main()
{
    
    out0 = ivec4(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }
ivec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec4(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec4 in0;
layout(location = 0) flat out ivec3 out0;


void main()
{
    
    out0 = ivec3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) out mediump vec4 dEQP_FragColor;

bool isOk (ivec3 a, ivec3 b) { return (a == b); }

layout(location = 0) flat in ivec3 out0;
layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;

void main()
{
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec3 a, ivec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec4 in0;
layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;
ivec3 out0;


void main()
{
    
    out0 = ivec3(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec3 a, ivec3 b) { return (a == b); }
ivec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec3(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec4 in0;
layout(location = 0) flat out ivec2 out0;


void main()
{
    
    out0 = ivec2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) out mediump vec4 dEQP_FragColor;

bool isOk (ivec2 a, ivec2 b) { return (a == b); }

layout(location = 0) flat in ivec2 out0;
layout(binding = 0, std140) uniform Reference
{
	ivec2 out0;
} ref;

void main()
{
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec2 a, ivec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec4 in0;
layout(binding = 0, std140) uniform Reference
{
	ivec2 out0;
} ref;
ivec2 out0;


void main()
{
    
    out0 = ivec2(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	ivec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec2 a, ivec2 b) { return (a == b); }
ivec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec2(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec4 in0;
layout(location = 0) flat out uvec4 v_out0;
bvec4 out0;


void main()
{
    
    out0 = bvec4(in0);
    gl_Position = dEQP_Position;
v_out0 = uvec4(out0);

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) out mediump vec4 dEQP_FragColor;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }

layout(location = 0) flat in uvec4 v_out0;
layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;

void main()
{
    bvec4 out0 = bvec4(v_out0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec4 in0;
layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
bvec4 out0;


void main()
{
    
    out0 = bvec4(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }
bvec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec4(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec4 in0;
layout(location = 0) flat out uvec3 v_out0;
bvec3 out0;


void main()
{
    
    out0 = bvec3(in0);
    gl_Position = dEQP_Position;
v_out0 = uvec3(out0);

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) out mediump vec4 dEQP_FragColor;

bool isOk (bvec3 a, bvec3 b) { return (a == b); }

layout(location = 0) flat in uvec3 v_out0;
layout(binding = 0, std140) uniform Reference
{
	bvec3 out0;
} ref;

void main()
{
    bvec3 out0 = bvec3(v_out0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec3 a, bvec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec4 in0;
layout(binding = 0, std140) uniform Reference
{
	bvec3 out0;
} ref;
bvec3 out0;


void main()
{
    
    out0 = bvec3(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	bvec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec3 a, bvec3 b) { return (a == b); }
bvec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec3(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec4 in0;
layout(location = 0) flat out uvec2 v_out0;
bvec2 out0;


void main()
{
    
    out0 = bvec2(in0);
    gl_Position = dEQP_Position;
v_out0 = uvec2(out0);

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) out mediump vec4 dEQP_FragColor;

bool isOk (bvec2 a, bvec2 b) { return (a == b); }

layout(location = 0) flat in uvec2 v_out0;
layout(binding = 0, std140) uniform Reference
{
	bvec2 out0;
} ref;

void main()
{
    bvec2 out0 = bvec2(v_out0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec2 a, bvec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec4 in0;
layout(binding = 0, std140) uniform Reference
{
	bvec2 out0;
} ref;
bvec2 out0;


void main()
{
    
    out0 = bvec2(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	bvec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec2 a, bvec2 b) { return (a == b); }
bvec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec2(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec4 in0;
layout(location = 0) flat out vec4 out0;


void main()
{
    
    out0 = vec4(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec4 in0;
layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
vec4 out0;


void main()
{
    
    out0 = vec4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	ivec4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec4 in0;
layout(location = 0) flat out vec3 out0;


void main()
{
    
    out0 = vec3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec4 in0;
layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
vec3 out0;


void main()
{
    
    out0 = vec3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	ivec4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec4 in0;
layout(location = 0) flat out vec2 out0;


void main()
{
    
    out0 = vec2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec2 a, vec2 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec4 in0;
layout(binding = 0, std140) uniform Reference
{
	vec2 out0;
} ref;
vec2 out0;


void main()
{
    
    out0 = vec2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	ivec4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	vec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec2 a, vec2 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec4 in0;
layout(location = 0) flat out ivec4 out0;


void main()
{
    
    out0 = ivec4(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec4 in0;
layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
ivec4 out0;


void main()
{
    
    out0 = ivec4(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	ivec4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }
ivec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec4(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec4 in0;
layout(location = 0) flat out ivec3 out0;


void main()
{
    
    out0 = ivec3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec3 a, ivec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec4 in0;
layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;
ivec3 out0;


void main()
{
    
    out0 = ivec3(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	ivec4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec3 a, ivec3 b) { return (a == b); }
ivec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec3(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec4 in0;
layout(location = 0) flat out ivec2 out0;


void main()
{
    
    out0 = ivec2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec2 a, ivec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec4 in0;
layout(binding = 0, std140) uniform Reference
{
	ivec2 out0;
} ref;
ivec2 out0;


void main()
{
    
    out0 = ivec2(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	ivec4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	ivec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec2 a, ivec2 b) { return (a == b); }
ivec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec2(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec4 in0;
layout(location = 0) flat out uvec4 v_out0;
bvec4 out0;


void main()
{
    
    out0 = bvec4(in0);
    gl_Position = dEQP_Position;
v_out0 = uvec4(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec4 in0;
layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
bvec4 out0;


void main()
{
    
    out0 = bvec4(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	ivec4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }
bvec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec4(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec4 in0;
layout(location = 0) flat out uvec3 v_out0;
bvec3 out0;


void main()
{
    
    out0 = bvec3(in0);
    gl_Position = dEQP_Position;
v_out0 = uvec3(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec3 a, bvec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec4 in0;
layout(binding = 0, std140) uniform Reference
{
	bvec3 out0;
} ref;
bvec3 out0;


void main()
{
    
    out0 = bvec3(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	ivec4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	bvec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec3 a, bvec3 b) { return (a == b); }
bvec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec3(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec4 in0;
layout(location = 0) flat out uvec2 v_out0;
bvec2 out0;


void main()
{
    
    out0 = bvec2(in0);
    gl_Position = dEQP_Position;
v_out0 = uvec2(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec2 a, bvec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec4 in0;
layout(binding = 0, std140) uniform Reference
{
	bvec2 out0;
} ref;
bvec2 out0;


void main()
{
    
    out0 = bvec2(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	ivec4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	bvec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec2 a, bvec2 b) { return (a == b); }
bvec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec2(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec4 in0;
layout(location = 0) flat out vec4 out0;


void main()
{
    
    out0 = vec4(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec4 in0;
layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
vec4 out0;


void main()
{
    
    out0 = vec4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uvec4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec4 in0;
layout(location = 0) flat out vec3 out0;


void main()
{
    
    out0 = vec3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec4 in0;
layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
vec3 out0;


void main()
{
    
    out0 = vec3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uvec4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec4 in0;
layout(location = 0) flat out vec2 out0;


void main()
{
    
    out0 = vec2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec2 a, vec2 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec4 in0;
layout(binding = 0, std140) uniform Reference
{
	vec2 out0;
} ref;
vec2 out0;


void main()
{
    
    out0 = vec2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uvec4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	vec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec2 a, vec2 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec4 in0;
layout(location = 0) flat out ivec4 out0;


void main()
{
    
    out0 = ivec4(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec4 in0;
layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
ivec4 out0;


void main()
{
    
    out0 = ivec4(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uvec4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }
ivec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec4(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec4 in0;
layout(location = 0) flat out ivec3 out0;


void main()
{
    
    out0 = ivec3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec3 a, ivec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec4 in0;
layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;
ivec3 out0;


void main()
{
    
    out0 = ivec3(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uvec4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec3 a, ivec3 b) { return (a == b); }
ivec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec3(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec4 in0;
layout(location = 0) flat out ivec2 out0;


void main()
{
    
    out0 = ivec2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec2 a, ivec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec4 in0;
layout(binding = 0, std140) uniform Reference
{
	ivec2 out0;
} ref;
ivec2 out0;


void main()
{
    
    out0 = ivec2(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uvec4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	ivec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec2 a, ivec2 b) { return (a == b); }
ivec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec2(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec4 in0;
layout(location = 0) flat out uvec4 v_out0;
bvec4 out0;


void main()
{
    
    out0 = bvec4(in0);
    gl_Position = dEQP_Position;
v_out0 = uvec4(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec4 in0;
layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
bvec4 out0;


void main()
{
    
    out0 = bvec4(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uvec4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }
bvec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec4(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec4 in0;
layout(location = 0) flat out uvec3 v_out0;
bvec3 out0;


void main()
{
    
    out0 = bvec3(in0);
    gl_Position = dEQP_Position;
v_out0 = uvec3(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec3 a, bvec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec4 in0;
layout(binding = 0, std140) uniform Reference
{
	bvec3 out0;
} ref;
bvec3 out0;


void main()
{
    
    out0 = bvec3(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uvec4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	bvec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec3 a, bvec3 b) { return (a == b); }
bvec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec3(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec4 in0;
layout(location = 0) flat out uvec2 v_out0;
bvec2 out0;


void main()
{
    
    out0 = bvec2(in0);
    gl_Position = dEQP_Position;
v_out0 = uvec2(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec2 a, bvec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec4 in0;
layout(binding = 0, std140) uniform Reference
{
	bvec2 out0;
} ref;
bvec2 out0;


void main()
{
    
    out0 = bvec2(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uvec4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	bvec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec2 a, bvec2 b) { return (a == b); }
bvec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec2(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec4 a_in0;
layout(location = 0) flat out vec4 out0;


void main()
{
    bvec4 in0 = bvec4(a_in0);

    out0 = vec4(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec4 v_in0;
layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
vec4 out0;


void main()
{
    bvec4 in0 = bvec4(v_in0);

    out0 = vec4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec4 a_in0;
layout(location = 0) flat out vec3 out0;


void main()
{
    bvec4 in0 = bvec4(a_in0);

    out0 = vec3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec4 v_in0;
layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
vec3 out0;


void main()
{
    bvec4 in0 = bvec4(v_in0);

    out0 = vec3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec4 a_in0;
layout(location = 0) flat out vec2 out0;


void main()
{
    bvec4 in0 = bvec4(a_in0);

    out0 = vec2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec2 a, vec2 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec4 v_in0;
layout(binding = 0, std140) uniform Reference
{
	vec2 out0;
} ref;
vec2 out0;


void main()
{
    bvec4 in0 = bvec4(v_in0);

    out0 = vec2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	vec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec2 a, vec2 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec4 a_in0;
layout(location = 0) flat out ivec4 out0;


void main()
{
    bvec4 in0 = bvec4(a_in0);

    out0 = ivec4(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec4 v_in0;
layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
ivec4 out0;


void main()
{
    bvec4 in0 = bvec4(v_in0);

    out0 = ivec4(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }
ivec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec4(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec4 a_in0;
layout(location = 0) flat out ivec3 out0;


void main()
{
    bvec4 in0 = bvec4(a_in0);

    out0 = ivec3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec3 a, ivec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec4 v_in0;
layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;
ivec3 out0;


void main()
{
    bvec4 in0 = bvec4(v_in0);

    out0 = ivec3(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec3 a, ivec3 b) { return (a == b); }
ivec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec3(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec4 a_in0;
layout(location = 0) flat out ivec2 out0;


void main()
{
    bvec4 in0 = bvec4(a_in0);

    out0 = ivec2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec2 a, ivec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec4 v_in0;
layout(binding = 0, std140) uniform Reference
{
	ivec2 out0;
} ref;
ivec2 out0;


void main()
{
    bvec4 in0 = bvec4(v_in0);

    out0 = ivec2(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	ivec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec2 a, ivec2 b) { return (a == b); }
ivec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec2(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec4 a_in0;
layout(location = 0) flat out uvec4 v_out0;
bvec4 out0;


void main()
{
    bvec4 in0 = bvec4(a_in0);

    out0 = bvec4(in0);
    gl_Position = dEQP_Position;
v_out0 = uvec4(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec4 v_in0;
layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
bvec4 out0;


void main()
{
    bvec4 in0 = bvec4(v_in0);

    out0 = bvec4(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }
bvec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec4(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec4 a_in0;
layout(location = 0) flat out uvec3 v_out0;
bvec3 out0;


void main()
{
    bvec4 in0 = bvec4(a_in0);

    out0 = bvec3(in0);
    gl_Position = dEQP_Position;
v_out0 = uvec3(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec3 a, bvec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec4 v_in0;
layout(binding = 0, std140) uniform Reference
{
	bvec3 out0;
} ref;
bvec3 out0;


void main()
{
    bvec4 in0 = bvec4(v_in0);

    out0 = bvec3(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	bvec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec3 a, bvec3 b) { return (a == b); }
bvec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec3(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec4 a_in0;
layout(location = 0) flat out uvec2 v_out0;
bvec2 out0;


void main()
{
    bvec4 in0 = bvec4(a_in0);

    out0 = bvec2(in0);
    gl_Position = dEQP_Position;
v_out0 = uvec2(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec2 a, bvec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec4 v_in0;
layout(binding = 0, std140) uniform Reference
{
	bvec2 out0;
} ref;
bvec2 out0;


void main()
{
    bvec4 in0 = bvec4(v_in0);

    out0 = bvec2(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	bvec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec2 a, bvec2 b) { return (a == b); }
bvec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec2(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec4 in0;
layout(location = 0) flat out uvec4 out0;


void main()
{
    
    out0 = uvec4(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) out mediump vec4 dEQP_FragColor;

bool isOk (uvec4 a, uvec4 b) { return (a == b); }

layout(location = 0) flat in uvec4 out0;
layout(binding = 0, std140) uniform Reference
{
	uvec4 out0;
} ref;

void main()
{
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec4 a, uvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec4 in0;
layout(binding = 0, std140) uniform Reference
{
	uvec4 out0;
} ref;
uvec4 out0;


void main()
{
    
    out0 = uvec4(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	uvec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec4 a, uvec4 b) { return (a == b); }
uvec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec4(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec4 in0;
layout(location = 0) flat out uvec3 out0;


void main()
{
    
    out0 = uvec3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) out mediump vec4 dEQP_FragColor;

bool isOk (uvec3 a, uvec3 b) { return (a == b); }

layout(location = 0) flat in uvec3 out0;
layout(binding = 0, std140) uniform Reference
{
	uvec3 out0;
} ref;

void main()
{
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec3 a, uvec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec4 in0;
layout(binding = 0, std140) uniform Reference
{
	uvec3 out0;
} ref;
uvec3 out0;


void main()
{
    
    out0 = uvec3(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	uvec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec3 a, uvec3 b) { return (a == b); }
uvec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec3(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec4 in0;
layout(location = 0) flat out uvec2 out0;


void main()
{
    
    out0 = uvec2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) out mediump vec4 dEQP_FragColor;

bool isOk (uvec2 a, uvec2 b) { return (a == b); }

layout(location = 0) flat in uvec2 out0;
layout(binding = 0, std140) uniform Reference
{
	uvec2 out0;
} ref;

void main()
{
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec2 a, uvec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec4 in0;
layout(binding = 0, std140) uniform Reference
{
	uvec2 out0;
} ref;
uvec2 out0;


void main()
{
    
    out0 = uvec2(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	uvec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec2 a, uvec2 b) { return (a == b); }
uvec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec2(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec4 in0;
layout(location = 0) flat out uvec4 out0;


void main()
{
    
    out0 = uvec4(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec4 a, uvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec4 in0;
layout(binding = 0, std140) uniform Reference
{
	uvec4 out0;
} ref;
uvec4 out0;


void main()
{
    
    out0 = uvec4(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	ivec4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	uvec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec4 a, uvec4 b) { return (a == b); }
uvec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec4(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec4 in0;
layout(location = 0) flat out uvec3 out0;


void main()
{
    
    out0 = uvec3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec3 a, uvec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec4 in0;
layout(binding = 0, std140) uniform Reference
{
	uvec3 out0;
} ref;
uvec3 out0;


void main()
{
    
    out0 = uvec3(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	ivec4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	uvec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec3 a, uvec3 b) { return (a == b); }
uvec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec3(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec4 in0;
layout(location = 0) flat out uvec2 out0;


void main()
{
    
    out0 = uvec2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec2 a, uvec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec4 in0;
layout(binding = 0, std140) uniform Reference
{
	uvec2 out0;
} ref;
uvec2 out0;


void main()
{
    
    out0 = uvec2(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	ivec4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	uvec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec2 a, uvec2 b) { return (a == b); }
uvec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec2(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec4 in0;
layout(location = 0) flat out uvec4 out0;


void main()
{
    
    out0 = uvec4(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec4 a, uvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec4 in0;
layout(binding = 0, std140) uniform Reference
{
	uvec4 out0;
} ref;
uvec4 out0;


void main()
{
    
    out0 = uvec4(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uvec4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	uvec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec4 a, uvec4 b) { return (a == b); }
uvec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec4(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec4 in0;
layout(location = 0) flat out uvec3 out0;


void main()
{
    
    out0 = uvec3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec3 a, uvec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec4 in0;
layout(binding = 0, std140) uniform Reference
{
	uvec3 out0;
} ref;
uvec3 out0;


void main()
{
    
    out0 = uvec3(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uvec4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	uvec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec3 a, uvec3 b) { return (a == b); }
uvec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec3(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec4 in0;
layout(location = 0) flat out uvec2 out0;


void main()
{
    
    out0 = uvec2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec2 a, uvec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec4 in0;
layout(binding = 0, std140) uniform Reference
{
	uvec2 out0;
} ref;
uvec2 out0;


void main()
{
    
    out0 = uvec2(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uvec4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	uvec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec2 a, uvec2 b) { return (a == b); }
uvec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec2(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec4 a_in0;
layout(location = 0) flat out uvec4 out0;


void main()
{
    bvec4 in0 = bvec4(a_in0);

    out0 = uvec4(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec4 a, uvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec4 v_in0;
layout(binding = 0, std140) uniform Reference
{
	uvec4 out0;
} ref;
uvec4 out0;


void main()
{
    bvec4 in0 = bvec4(v_in0);

    out0 = uvec4(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	uvec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec4 a, uvec4 b) { return (a == b); }
uvec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec4(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec4 a_in0;
layout(location = 0) flat out uvec3 out0;


void main()
{
    bvec4 in0 = bvec4(a_in0);

    out0 = uvec3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec3 a, uvec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec4 v_in0;
layout(binding = 0, std140) uniform Reference
{
	uvec3 out0;
} ref;
uvec3 out0;


void main()
{
    bvec4 in0 = bvec4(v_in0);

    out0 = uvec3(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	uvec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec3 a, uvec3 b) { return (a == b); }
uvec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec3(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec4 a_in0;
layout(location = 0) flat out uvec2 out0;


void main()
{
    bvec4 in0 = bvec4(a_in0);

    out0 = uvec2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec2 a, uvec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec4 v_in0;
layout(binding = 0, std140) uniform Reference
{
	uvec2 out0;
} ref;
uvec2 out0;


void main()
{
    bvec4 in0 = bvec4(v_in0);

    out0 = uvec2(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	uvec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec2 a, uvec2 b) { return (a == b); }
uvec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec2(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 0) flat out vec3 out0;


void main()
{
    
    out0 = vec3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec3 in0;
layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
vec3 out0;


void main()
{
    
    out0 = vec3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec3 in0;
};

layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 0) flat out vec2 out0;


void main()
{
    
    out0 = vec2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec2 a, vec2 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec3 in0;
layout(binding = 0, std140) uniform Reference
{
	vec2 out0;
} ref;
vec2 out0;


void main()
{
    
    out0 = vec2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec3 in0;
};

layout(binding = 0, std140) uniform Reference
{
	vec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec2 a, vec2 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 0) flat out ivec3 out0;


void main()
{
    
    out0 = ivec3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec3 a, ivec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec3 in0;
layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;
ivec3 out0;


void main()
{
    
    out0 = ivec3(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec3 in0;
};

layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec3 a, ivec3 b) { return (a == b); }
ivec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec3(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 0) flat out ivec2 out0;


void main()
{
    
    out0 = ivec2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec2 a, ivec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec3 in0;
layout(binding = 0, std140) uniform Reference
{
	ivec2 out0;
} ref;
ivec2 out0;


void main()
{
    
    out0 = ivec2(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec3 in0;
};

layout(binding = 0, std140) uniform Reference
{
	ivec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec2 a, ivec2 b) { return (a == b); }
ivec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec2(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 0) flat out uvec3 v_out0;
bvec3 out0;


void main()
{
    
    out0 = bvec3(in0);
    gl_Position = dEQP_Position;
v_out0 = uvec3(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec3 a, bvec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec3 in0;
layout(binding = 0, std140) uniform Reference
{
	bvec3 out0;
} ref;
bvec3 out0;


void main()
{
    
    out0 = bvec3(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec3 in0;
};

layout(binding = 0, std140) uniform Reference
{
	bvec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec3 a, bvec3 b) { return (a == b); }
bvec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec3(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 0) flat out uvec2 v_out0;
bvec2 out0;


void main()
{
    
    out0 = bvec2(in0);
    gl_Position = dEQP_Position;
v_out0 = uvec2(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec2 a, bvec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec3 in0;
layout(binding = 0, std140) uniform Reference
{
	bvec2 out0;
} ref;
bvec2 out0;


void main()
{
    
    out0 = bvec2(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec3 in0;
};

layout(binding = 0, std140) uniform Reference
{
	bvec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec2 a, bvec2 b) { return (a == b); }
bvec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec2(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec3 in0;
layout(location = 0) flat out vec3 out0;


void main()
{
    
    out0 = vec3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec3 in0;
layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
vec3 out0;


void main()
{
    
    out0 = vec3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	ivec3 in0;
};

layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec3 in0;
layout(location = 0) flat out vec2 out0;


void main()
{
    
    out0 = vec2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec2 a, vec2 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec3 in0;
layout(binding = 0, std140) uniform Reference
{
	vec2 out0;
} ref;
vec2 out0;


void main()
{
    
    out0 = vec2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	ivec3 in0;
};

layout(binding = 0, std140) uniform Reference
{
	vec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec2 a, vec2 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec3 in0;
layout(location = 0) flat out ivec3 out0;


void main()
{
    
    out0 = ivec3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec3 a, ivec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec3 in0;
layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;
ivec3 out0;


void main()
{
    
    out0 = ivec3(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	ivec3 in0;
};

layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec3 a, ivec3 b) { return (a == b); }
ivec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec3(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec3 in0;
layout(location = 0) flat out ivec2 out0;


void main()
{
    
    out0 = ivec2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec2 a, ivec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec3 in0;
layout(binding = 0, std140) uniform Reference
{
	ivec2 out0;
} ref;
ivec2 out0;


void main()
{
    
    out0 = ivec2(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	ivec3 in0;
};

layout(binding = 0, std140) uniform Reference
{
	ivec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec2 a, ivec2 b) { return (a == b); }
ivec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec2(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec3 in0;
layout(location = 0) flat out uvec3 v_out0;
bvec3 out0;


void main()
{
    
    out0 = bvec3(in0);
    gl_Position = dEQP_Position;
v_out0 = uvec3(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec3 a, bvec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec3 in0;
layout(binding = 0, std140) uniform Reference
{
	bvec3 out0;
} ref;
bvec3 out0;


void main()
{
    
    out0 = bvec3(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	ivec3 in0;
};

layout(binding = 0, std140) uniform Reference
{
	bvec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec3 a, bvec3 b) { return (a == b); }
bvec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec3(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec3 in0;
layout(location = 0) flat out uvec2 v_out0;
bvec2 out0;


void main()
{
    
    out0 = bvec2(in0);
    gl_Position = dEQP_Position;
v_out0 = uvec2(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec2 a, bvec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec3 in0;
layout(binding = 0, std140) uniform Reference
{
	bvec2 out0;
} ref;
bvec2 out0;


void main()
{
    
    out0 = bvec2(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	ivec3 in0;
};

layout(binding = 0, std140) uniform Reference
{
	bvec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec2 a, bvec2 b) { return (a == b); }
bvec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec2(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 in0;
layout(location = 0) flat out vec3 out0;


void main()
{
    
    out0 = vec3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec3 in0;
layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
vec3 out0;


void main()
{
    
    out0 = vec3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uvec3 in0;
};

layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 in0;
layout(location = 0) flat out vec2 out0;


void main()
{
    
    out0 = vec2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec2 a, vec2 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec3 in0;
layout(binding = 0, std140) uniform Reference
{
	vec2 out0;
} ref;
vec2 out0;


void main()
{
    
    out0 = vec2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uvec3 in0;
};

layout(binding = 0, std140) uniform Reference
{
	vec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec2 a, vec2 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 in0;
layout(location = 0) flat out ivec3 out0;


void main()
{
    
    out0 = ivec3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec3 a, ivec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec3 in0;
layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;
ivec3 out0;


void main()
{
    
    out0 = ivec3(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uvec3 in0;
};

layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec3 a, ivec3 b) { return (a == b); }
ivec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec3(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 in0;
layout(location = 0) flat out ivec2 out0;


void main()
{
    
    out0 = ivec2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec2 a, ivec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec3 in0;
layout(binding = 0, std140) uniform Reference
{
	ivec2 out0;
} ref;
ivec2 out0;


void main()
{
    
    out0 = ivec2(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uvec3 in0;
};

layout(binding = 0, std140) uniform Reference
{
	ivec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec2 a, ivec2 b) { return (a == b); }
ivec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec2(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 in0;
layout(location = 0) flat out uvec3 v_out0;
bvec3 out0;


void main()
{
    
    out0 = bvec3(in0);
    gl_Position = dEQP_Position;
v_out0 = uvec3(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec3 a, bvec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec3 in0;
layout(binding = 0, std140) uniform Reference
{
	bvec3 out0;
} ref;
bvec3 out0;


void main()
{
    
    out0 = bvec3(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uvec3 in0;
};

layout(binding = 0, std140) uniform Reference
{
	bvec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec3 a, bvec3 b) { return (a == b); }
bvec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec3(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 in0;
layout(location = 0) flat out uvec2 v_out0;
bvec2 out0;


void main()
{
    
    out0 = bvec2(in0);
    gl_Position = dEQP_Position;
v_out0 = uvec2(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec2 a, bvec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec3 in0;
layout(binding = 0, std140) uniform Reference
{
	bvec2 out0;
} ref;
bvec2 out0;


void main()
{
    
    out0 = bvec2(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uvec3 in0;
};

layout(binding = 0, std140) uniform Reference
{
	bvec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec2 a, bvec2 b) { return (a == b); }
bvec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec2(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 a_in0;
layout(location = 0) flat out vec3 out0;


void main()
{
    bvec3 in0 = bvec3(a_in0);

    out0 = vec3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec3 v_in0;
layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
vec3 out0;


void main()
{
    bvec3 in0 = bvec3(v_in0);

    out0 = vec3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec3 in0;
};

layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 a_in0;
layout(location = 0) flat out vec2 out0;


void main()
{
    bvec3 in0 = bvec3(a_in0);

    out0 = vec2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec2 a, vec2 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec3 v_in0;
layout(binding = 0, std140) uniform Reference
{
	vec2 out0;
} ref;
vec2 out0;


void main()
{
    bvec3 in0 = bvec3(v_in0);

    out0 = vec2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec3 in0;
};

layout(binding = 0, std140) uniform Reference
{
	vec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec2 a, vec2 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 a_in0;
layout(location = 0) flat out ivec3 out0;


void main()
{
    bvec3 in0 = bvec3(a_in0);

    out0 = ivec3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec3 a, ivec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec3 v_in0;
layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;
ivec3 out0;


void main()
{
    bvec3 in0 = bvec3(v_in0);

    out0 = ivec3(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec3 in0;
};

layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec3 a, ivec3 b) { return (a == b); }
ivec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec3(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 a_in0;
layout(location = 0) flat out ivec2 out0;


void main()
{
    bvec3 in0 = bvec3(a_in0);

    out0 = ivec2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec2 a, ivec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec3 v_in0;
layout(binding = 0, std140) uniform Reference
{
	ivec2 out0;
} ref;
ivec2 out0;


void main()
{
    bvec3 in0 = bvec3(v_in0);

    out0 = ivec2(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec3 in0;
};

layout(binding = 0, std140) uniform Reference
{
	ivec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec2 a, ivec2 b) { return (a == b); }
ivec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec2(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 a_in0;
layout(location = 0) flat out uvec3 v_out0;
bvec3 out0;


void main()
{
    bvec3 in0 = bvec3(a_in0);

    out0 = bvec3(in0);
    gl_Position = dEQP_Position;
v_out0 = uvec3(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec3 a, bvec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec3 v_in0;
layout(binding = 0, std140) uniform Reference
{
	bvec3 out0;
} ref;
bvec3 out0;


void main()
{
    bvec3 in0 = bvec3(v_in0);

    out0 = bvec3(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec3 in0;
};

layout(binding = 0, std140) uniform Reference
{
	bvec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec3 a, bvec3 b) { return (a == b); }
bvec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec3(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 a_in0;
layout(location = 0) flat out uvec2 v_out0;
bvec2 out0;


void main()
{
    bvec3 in0 = bvec3(a_in0);

    out0 = bvec2(in0);
    gl_Position = dEQP_Position;
v_out0 = uvec2(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec2 a, bvec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec3 v_in0;
layout(binding = 0, std140) uniform Reference
{
	bvec2 out0;
} ref;
bvec2 out0;


void main()
{
    bvec3 in0 = bvec3(v_in0);

    out0 = bvec2(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec3 in0;
};

layout(binding = 0, std140) uniform Reference
{
	bvec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec2 a, bvec2 b) { return (a == b); }
bvec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec2(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 0) flat out uvec3 out0;


void main()
{
    
    out0 = uvec3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec3 a, uvec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec3 in0;
layout(binding = 0, std140) uniform Reference
{
	uvec3 out0;
} ref;
uvec3 out0;


void main()
{
    
    out0 = uvec3(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec3 in0;
};

layout(binding = 0, std140) uniform Reference
{
	uvec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec3 a, uvec3 b) { return (a == b); }
uvec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec3(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 0) flat out uvec2 out0;


void main()
{
    
    out0 = uvec2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec2 a, uvec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec3 in0;
layout(binding = 0, std140) uniform Reference
{
	uvec2 out0;
} ref;
uvec2 out0;


void main()
{
    
    out0 = uvec2(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec3 in0;
};

layout(binding = 0, std140) uniform Reference
{
	uvec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec2 a, uvec2 b) { return (a == b); }
uvec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec2(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec3 in0;
layout(location = 0) flat out uvec3 out0;


void main()
{
    
    out0 = uvec3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec3 a, uvec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec3 in0;
layout(binding = 0, std140) uniform Reference
{
	uvec3 out0;
} ref;
uvec3 out0;


void main()
{
    
    out0 = uvec3(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	ivec3 in0;
};

layout(binding = 0, std140) uniform Reference
{
	uvec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec3 a, uvec3 b) { return (a == b); }
uvec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec3(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec3 in0;
layout(location = 0) flat out uvec2 out0;


void main()
{
    
    out0 = uvec2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec2 a, uvec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec3 in0;
layout(binding = 0, std140) uniform Reference
{
	uvec2 out0;
} ref;
uvec2 out0;


void main()
{
    
    out0 = uvec2(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	ivec3 in0;
};

layout(binding = 0, std140) uniform Reference
{
	uvec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec2 a, uvec2 b) { return (a == b); }
uvec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec2(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 in0;
layout(location = 0) flat out uvec3 out0;


void main()
{
    
    out0 = uvec3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec3 a, uvec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec3 in0;
layout(binding = 0, std140) uniform Reference
{
	uvec3 out0;
} ref;
uvec3 out0;


void main()
{
    
    out0 = uvec3(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uvec3 in0;
};

layout(binding = 0, std140) uniform Reference
{
	uvec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec3 a, uvec3 b) { return (a == b); }
uvec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec3(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 in0;
layout(location = 0) flat out uvec2 out0;


void main()
{
    
    out0 = uvec2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec2 a, uvec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec3 in0;
layout(binding = 0, std140) uniform Reference
{
	uvec2 out0;
} ref;
uvec2 out0;


void main()
{
    
    out0 = uvec2(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uvec3 in0;
};

layout(binding = 0, std140) uniform Reference
{
	uvec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec2 a, uvec2 b) { return (a == b); }
uvec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec2(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 a_in0;
layout(location = 0) flat out uvec3 out0;


void main()
{
    bvec3 in0 = bvec3(a_in0);

    out0 = uvec3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec3 a, uvec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec3 v_in0;
layout(binding = 0, std140) uniform Reference
{
	uvec3 out0;
} ref;
uvec3 out0;


void main()
{
    bvec3 in0 = bvec3(v_in0);

    out0 = uvec3(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec3 in0;
};

layout(binding = 0, std140) uniform Reference
{
	uvec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec3 a, uvec3 b) { return (a == b); }
uvec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec3(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 a_in0;
layout(location = 0) flat out uvec2 out0;


void main()
{
    bvec3 in0 = bvec3(a_in0);

    out0 = uvec2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec2 a, uvec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec3 v_in0;
layout(binding = 0, std140) uniform Reference
{
	uvec2 out0;
} ref;
uvec2 out0;


void main()
{
    bvec3 in0 = bvec3(v_in0);

    out0 = uvec2(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec3 in0;
};

layout(binding = 0, std140) uniform Reference
{
	uvec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec2 a, uvec2 b) { return (a == b); }
uvec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec2(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 in0;
layout(location = 0) flat out vec2 out0;


void main()
{
    
    out0 = vec2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec2 a, vec2 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec2 in0;
layout(binding = 0, std140) uniform Reference
{
	vec2 out0;
} ref;
vec2 out0;


void main()
{
    
    out0 = vec2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec2 in0;
};

layout(binding = 0, std140) uniform Reference
{
	vec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec2 a, vec2 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 in0;
layout(location = 0) flat out ivec2 out0;


void main()
{
    
    out0 = ivec2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec2 a, ivec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec2 in0;
layout(binding = 0, std140) uniform Reference
{
	ivec2 out0;
} ref;
ivec2 out0;


void main()
{
    
    out0 = ivec2(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec2 in0;
};

layout(binding = 0, std140) uniform Reference
{
	ivec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec2 a, ivec2 b) { return (a == b); }
ivec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec2(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 in0;
layout(location = 0) flat out uvec2 v_out0;
bvec2 out0;


void main()
{
    
    out0 = bvec2(in0);
    gl_Position = dEQP_Position;
v_out0 = uvec2(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec2 a, bvec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec2 in0;
layout(binding = 0, std140) uniform Reference
{
	bvec2 out0;
} ref;
bvec2 out0;


void main()
{
    
    out0 = bvec2(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec2 in0;
};

layout(binding = 0, std140) uniform Reference
{
	bvec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec2 a, bvec2 b) { return (a == b); }
bvec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec2(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec2 in0;
layout(location = 0) flat out vec2 out0;


void main()
{
    
    out0 = vec2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec2 a, vec2 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec2 in0;
layout(binding = 0, std140) uniform Reference
{
	vec2 out0;
} ref;
vec2 out0;


void main()
{
    
    out0 = vec2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	ivec2 in0;
};

layout(binding = 0, std140) uniform Reference
{
	vec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec2 a, vec2 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec2 in0;
layout(location = 0) flat out ivec2 out0;


void main()
{
    
    out0 = ivec2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec2 a, ivec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec2 in0;
layout(binding = 0, std140) uniform Reference
{
	ivec2 out0;
} ref;
ivec2 out0;


void main()
{
    
    out0 = ivec2(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	ivec2 in0;
};

layout(binding = 0, std140) uniform Reference
{
	ivec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec2 a, ivec2 b) { return (a == b); }
ivec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec2(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec2 in0;
layout(location = 0) flat out uvec2 v_out0;
bvec2 out0;


void main()
{
    
    out0 = bvec2(in0);
    gl_Position = dEQP_Position;
v_out0 = uvec2(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec2 a, bvec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec2 in0;
layout(binding = 0, std140) uniform Reference
{
	bvec2 out0;
} ref;
bvec2 out0;


void main()
{
    
    out0 = bvec2(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	ivec2 in0;
};

layout(binding = 0, std140) uniform Reference
{
	bvec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec2 a, bvec2 b) { return (a == b); }
bvec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec2(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec2 in0;
layout(location = 0) flat out vec2 out0;


void main()
{
    
    out0 = vec2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec2 a, vec2 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec2 in0;
layout(binding = 0, std140) uniform Reference
{
	vec2 out0;
} ref;
vec2 out0;


void main()
{
    
    out0 = vec2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uvec2 in0;
};

layout(binding = 0, std140) uniform Reference
{
	vec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec2 a, vec2 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec2 in0;
layout(location = 0) flat out ivec2 out0;


void main()
{
    
    out0 = ivec2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec2 a, ivec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec2 in0;
layout(binding = 0, std140) uniform Reference
{
	ivec2 out0;
} ref;
ivec2 out0;


void main()
{
    
    out0 = ivec2(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uvec2 in0;
};

layout(binding = 0, std140) uniform Reference
{
	ivec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec2 a, ivec2 b) { return (a == b); }
ivec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec2(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec2 in0;
layout(location = 0) flat out uvec2 v_out0;
bvec2 out0;


void main()
{
    
    out0 = bvec2(in0);
    gl_Position = dEQP_Position;
v_out0 = uvec2(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec2 a, bvec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec2 in0;
layout(binding = 0, std140) uniform Reference
{
	bvec2 out0;
} ref;
bvec2 out0;


void main()
{
    
    out0 = bvec2(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uvec2 in0;
};

layout(binding = 0, std140) uniform Reference
{
	bvec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec2 a, bvec2 b) { return (a == b); }
bvec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec2(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec2 a_in0;
layout(location = 0) flat out vec2 out0;


void main()
{
    bvec2 in0 = bvec2(a_in0);

    out0 = vec2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec2 a, vec2 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec2 v_in0;
layout(binding = 0, std140) uniform Reference
{
	vec2 out0;
} ref;
vec2 out0;


void main()
{
    bvec2 in0 = bvec2(v_in0);

    out0 = vec2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec2 in0;
};

layout(binding = 0, std140) uniform Reference
{
	vec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec2 a, vec2 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec2 a_in0;
layout(location = 0) flat out ivec2 out0;


void main()
{
    bvec2 in0 = bvec2(a_in0);

    out0 = ivec2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec2 a, ivec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec2 v_in0;
layout(binding = 0, std140) uniform Reference
{
	ivec2 out0;
} ref;
ivec2 out0;


void main()
{
    bvec2 in0 = bvec2(v_in0);

    out0 = ivec2(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec2 in0;
};

layout(binding = 0, std140) uniform Reference
{
	ivec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec2 a, ivec2 b) { return (a == b); }
ivec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec2(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec2 a_in0;
layout(location = 0) flat out uvec2 v_out0;
bvec2 out0;


void main()
{
    bvec2 in0 = bvec2(a_in0);

    out0 = bvec2(in0);
    gl_Position = dEQP_Position;
v_out0 = uvec2(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec2 a, bvec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec2 v_in0;
layout(binding = 0, std140) uniform Reference
{
	bvec2 out0;
} ref;
bvec2 out0;


void main()
{
    bvec2 in0 = bvec2(v_in0);

    out0 = bvec2(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec2 in0;
};

layout(binding = 0, std140) uniform Reference
{
	bvec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec2 a, bvec2 b) { return (a == b); }
bvec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec2(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 in0;
layout(location = 0) flat out uvec2 out0;


void main()
{
    
    out0 = uvec2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec2 a, uvec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec2 in0;
layout(binding = 0, std140) uniform Reference
{
	uvec2 out0;
} ref;
uvec2 out0;


void main()
{
    
    out0 = uvec2(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec2 in0;
};

layout(binding = 0, std140) uniform Reference
{
	uvec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec2 a, uvec2 b) { return (a == b); }
uvec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec2(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec2 in0;
layout(location = 0) flat out uvec2 out0;


void main()
{
    
    out0 = uvec2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec2 a, uvec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec2 in0;
layout(binding = 0, std140) uniform Reference
{
	uvec2 out0;
} ref;
uvec2 out0;


void main()
{
    
    out0 = uvec2(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	ivec2 in0;
};

layout(binding = 0, std140) uniform Reference
{
	uvec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec2 a, uvec2 b) { return (a == b); }
uvec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec2(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec2 in0;
layout(location = 0) flat out uvec2 out0;


void main()
{
    
    out0 = uvec2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec2 a, uvec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec2 in0;
layout(binding = 0, std140) uniform Reference
{
	uvec2 out0;
} ref;
uvec2 out0;


void main()
{
    
    out0 = uvec2(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uvec2 in0;
};

layout(binding = 0, std140) uniform Reference
{
	uvec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec2 a, uvec2 b) { return (a == b); }
uvec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec2(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec2 a_in0;
layout(location = 0) flat out uvec2 out0;


void main()
{
    bvec2 in0 = bvec2(a_in0);

    out0 = uvec2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec2 a, uvec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec2 v_in0;
layout(binding = 0, std140) uniform Reference
{
	uvec2 out0;
} ref;
uvec2 out0;


void main()
{
    bvec2 in0 = bvec2(v_in0);

    out0 = uvec2(in0);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec2 in0;
};

layout(binding = 0, std140) uniform Reference
{
	uvec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec2 a, uvec2 b) { return (a == b); }
uvec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec2(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 in0;
layout(location = 2) in vec2 in1;
layout(location = 0) flat out vec4 out0;


void main()
{
    
    out0 = vec4(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 a_in0;
layout(location = 0) flat out vec2 in0;
layout(location = 2) in vec2 a_in1;
layout(location = 1) flat out vec2 in1;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
    in1 = a_in1;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec2 in0;
layout(location = 1) flat in vec2 in1;
layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
vec4 out0;


void main()
{
    
    out0 = vec4(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec2 in0;
	vec2 in1;
};

layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec4(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 in0;
layout(location = 2) in vec2 in1;
layout(location = 0) flat out ivec4 out0;


void main()
{
    
    out0 = ivec4(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec2 in0;
layout(location = 1) flat in vec2 in1;
layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
ivec4 out0;


void main()
{
    
    out0 = ivec4(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec2 in0;
	vec2 in1;
};

layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }
ivec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec4(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 in0;
layout(location = 2) in vec2 in1;
layout(location = 0) flat out uvec4 v_out0;
bvec4 out0;


void main()
{
    
    out0 = bvec4(in0, in1);
    gl_Position = dEQP_Position;
v_out0 = uvec4(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec2 in0;
layout(location = 1) flat in vec2 in1;
layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
bvec4 out0;


void main()
{
    
    out0 = bvec4(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec2 in0;
	vec2 in1;
};

layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }
bvec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec4(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec2 a_in0;
layout(location = 2) in uvec2 a_in1;
layout(location = 0) flat out vec4 out0;


void main()
{
    bvec2 in0 = bvec2(a_in0);
bvec2 in1 = bvec2(a_in1);

    out0 = vec4(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec2 a_in0;
layout(location = 0) flat out uvec2 v_in0;
layout(location = 2) in uvec2 a_in1;
layout(location = 1) flat out uvec2 v_in1;

void main()
{
    gl_Position = dEQP_Position;
    v_in0 = a_in0;
    v_in1 = a_in1;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec2 v_in0;
layout(location = 1) flat in uvec2 v_in1;
layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
vec4 out0;


void main()
{
    bvec2 in0 = bvec2(v_in0);
bvec2 in1 = bvec2(v_in1);

    out0 = vec4(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec2 in0;
	bvec2 in1;
};

layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec4(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec2 a_in0;
layout(location = 2) in uvec2 a_in1;
layout(location = 0) flat out ivec4 out0;


void main()
{
    bvec2 in0 = bvec2(a_in0);
bvec2 in1 = bvec2(a_in1);

    out0 = ivec4(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec2 v_in0;
layout(location = 1) flat in uvec2 v_in1;
layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
ivec4 out0;


void main()
{
    bvec2 in0 = bvec2(v_in0);
bvec2 in1 = bvec2(v_in1);

    out0 = ivec4(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec2 in0;
	bvec2 in1;
};

layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }
ivec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec4(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec2 a_in0;
layout(location = 2) in uvec2 a_in1;
layout(location = 0) flat out uvec4 v_out0;
bvec4 out0;


void main()
{
    bvec2 in0 = bvec2(a_in0);
bvec2 in1 = bvec2(a_in1);

    out0 = bvec4(in0, in1);
    gl_Position = dEQP_Position;
v_out0 = uvec4(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec2 v_in0;
layout(location = 1) flat in uvec2 v_in1;
layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
bvec4 out0;


void main()
{
    bvec2 in0 = bvec2(v_in0);
bvec2 in1 = bvec2(v_in1);

    out0 = bvec4(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec2 in0;
	bvec2 in1;
};

layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }
bvec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec4(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 2) in float in1;
layout(location = 3) in float in2;
layout(location = 4) in float in3;
layout(location = 0) flat out vec4 out0;


void main()
{
    
    out0 = vec4(in0, in1, in2, in3);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float a_in0;
layout(location = 0) flat out float in0;
layout(location = 2) in float a_in1;
layout(location = 1) flat out float in1;
layout(location = 3) in float a_in2;
layout(location = 2) flat out float in2;
layout(location = 4) in float a_in3;
layout(location = 3) flat out float in3;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
    in1 = a_in1;
    in2 = a_in2;
    in3 = a_in3;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(location = 1) flat in float in1;
layout(location = 2) flat in float in2;
layout(location = 3) flat in float in3;
layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
vec4 out0;


void main()
{
    
    out0 = vec4(in0, in1, in2, in3);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	float in0;
	float in1;
	float in2;
	float in3;
};

layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec4(in0, in1, in2, in3);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 2) in float in1;
layout(location = 3) in float in2;
layout(location = 4) in float in3;
layout(location = 0) flat out ivec4 out0;


void main()
{
    
    out0 = ivec4(in0, in1, in2, in3);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(location = 1) flat in float in1;
layout(location = 2) flat in float in2;
layout(location = 3) flat in float in3;
layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
ivec4 out0;


void main()
{
    
    out0 = ivec4(in0, in1, in2, in3);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	float in0;
	float in1;
	float in2;
	float in3;
};

layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }
ivec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec4(in0, in1, in2, in3);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 2) in float in1;
layout(location = 3) in float in2;
layout(location = 4) in float in3;
layout(location = 0) flat out uvec4 v_out0;
bvec4 out0;


void main()
{
    
    out0 = bvec4(in0, in1, in2, in3);
    gl_Position = dEQP_Position;
v_out0 = uvec4(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(location = 1) flat in float in1;
layout(location = 2) flat in float in2;
layout(location = 3) flat in float in3;
layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
bvec4 out0;


void main()
{
    
    out0 = bvec4(in0, in1, in2, in3);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	float in0;
	float in1;
	float in2;
	float in3;
};

layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }
bvec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec4(in0, in1, in2, in3);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 2) in int in1;
layout(location = 3) in int in2;
layout(location = 4) in int in3;
layout(location = 0) flat out vec4 out0;


void main()
{
    
    out0 = vec4(in0, in1, in2, in3);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int a_in0;
layout(location = 0) flat out int in0;
layout(location = 2) in int a_in1;
layout(location = 1) flat out int in1;
layout(location = 3) in int a_in2;
layout(location = 2) flat out int in2;
layout(location = 4) in int a_in3;
layout(location = 3) flat out int in3;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
    in1 = a_in1;
    in2 = a_in2;
    in3 = a_in3;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in int in0;
layout(location = 1) flat in int in1;
layout(location = 2) flat in int in2;
layout(location = 3) flat in int in3;
layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
vec4 out0;


void main()
{
    
    out0 = vec4(in0, in1, in2, in3);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	int in0;
	int in1;
	int in2;
	int in3;
};

layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec4(in0, in1, in2, in3);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 2) in int in1;
layout(location = 3) in int in2;
layout(location = 4) in int in3;
layout(location = 0) flat out ivec4 out0;


void main()
{
    
    out0 = ivec4(in0, in1, in2, in3);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in int in0;
layout(location = 1) flat in int in1;
layout(location = 2) flat in int in2;
layout(location = 3) flat in int in3;
layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
ivec4 out0;


void main()
{
    
    out0 = ivec4(in0, in1, in2, in3);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	int in0;
	int in1;
	int in2;
	int in3;
};

layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }
ivec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec4(in0, in1, in2, in3);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 2) in int in1;
layout(location = 3) in int in2;
layout(location = 4) in int in3;
layout(location = 0) flat out uvec4 v_out0;
bvec4 out0;


void main()
{
    
    out0 = bvec4(in0, in1, in2, in3);
    gl_Position = dEQP_Position;
v_out0 = uvec4(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in int in0;
layout(location = 1) flat in int in1;
layout(location = 2) flat in int in2;
layout(location = 3) flat in int in3;
layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
bvec4 out0;


void main()
{
    
    out0 = bvec4(in0, in1, in2, in3);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	int in0;
	int in1;
	int in2;
	int in3;
};

layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }
bvec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec4(in0, in1, in2, in3);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint in0;
layout(location = 2) in uint in1;
layout(location = 3) in uint in2;
layout(location = 4) in uint in3;
layout(location = 0) flat out vec4 out0;


void main()
{
    
    out0 = vec4(in0, in1, in2, in3);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 0) flat out uint in0;
layout(location = 2) in uint a_in1;
layout(location = 1) flat out uint in1;
layout(location = 3) in uint a_in2;
layout(location = 2) flat out uint in2;
layout(location = 4) in uint a_in3;
layout(location = 3) flat out uint in3;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
    in1 = a_in1;
    in2 = a_in2;
    in3 = a_in3;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint in0;
layout(location = 1) flat in uint in1;
layout(location = 2) flat in uint in2;
layout(location = 3) flat in uint in3;
layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
vec4 out0;


void main()
{
    
    out0 = vec4(in0, in1, in2, in3);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uint in0;
	uint in1;
	uint in2;
	uint in3;
};

layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec4(in0, in1, in2, in3);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint in0;
layout(location = 2) in uint in1;
layout(location = 3) in uint in2;
layout(location = 4) in uint in3;
layout(location = 0) flat out ivec4 out0;


void main()
{
    
    out0 = ivec4(in0, in1, in2, in3);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint in0;
layout(location = 1) flat in uint in1;
layout(location = 2) flat in uint in2;
layout(location = 3) flat in uint in3;
layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
ivec4 out0;


void main()
{
    
    out0 = ivec4(in0, in1, in2, in3);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uint in0;
	uint in1;
	uint in2;
	uint in3;
};

layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }
ivec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec4(in0, in1, in2, in3);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint in0;
layout(location = 2) in uint in1;
layout(location = 3) in uint in2;
layout(location = 4) in uint in3;
layout(location = 0) flat out uvec4 v_out0;
bvec4 out0;


void main()
{
    
    out0 = bvec4(in0, in1, in2, in3);
    gl_Position = dEQP_Position;
v_out0 = uvec4(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint in0;
layout(location = 1) flat in uint in1;
layout(location = 2) flat in uint in2;
layout(location = 3) flat in uint in3;
layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
bvec4 out0;


void main()
{
    
    out0 = bvec4(in0, in1, in2, in3);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uint in0;
	uint in1;
	uint in2;
	uint in3;
};

layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }
bvec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec4(in0, in1, in2, in3);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 2) in uint a_in1;
layout(location = 3) in uint a_in2;
layout(location = 4) in uint a_in3;
layout(location = 0) flat out vec4 out0;


void main()
{
    bool in0 = bool(a_in0);
bool in1 = bool(a_in1);
bool in2 = bool(a_in2);
bool in3 = bool(a_in3);

    out0 = vec4(in0, in1, in2, in3);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 0) flat out uint v_in0;
layout(location = 2) in uint a_in1;
layout(location = 1) flat out uint v_in1;
layout(location = 3) in uint a_in2;
layout(location = 2) flat out uint v_in2;
layout(location = 4) in uint a_in3;
layout(location = 3) flat out uint v_in3;

void main()
{
    gl_Position = dEQP_Position;
    v_in0 = a_in0;
    v_in1 = a_in1;
    v_in2 = a_in2;
    v_in3 = a_in3;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(location = 1) flat in uint v_in1;
layout(location = 2) flat in uint v_in2;
layout(location = 3) flat in uint v_in3;
layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
vec4 out0;


void main()
{
    bool in0 = bool(v_in0);
bool in1 = bool(v_in1);
bool in2 = bool(v_in2);
bool in3 = bool(v_in3);

    out0 = vec4(in0, in1, in2, in3);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bool in0;
	bool in1;
	bool in2;
	bool in3;
};

layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec4(in0, in1, in2, in3);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 2) in uint a_in1;
layout(location = 3) in uint a_in2;
layout(location = 4) in uint a_in3;
layout(location = 0) flat out ivec4 out0;


void main()
{
    bool in0 = bool(a_in0);
bool in1 = bool(a_in1);
bool in2 = bool(a_in2);
bool in3 = bool(a_in3);

    out0 = ivec4(in0, in1, in2, in3);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(location = 1) flat in uint v_in1;
layout(location = 2) flat in uint v_in2;
layout(location = 3) flat in uint v_in3;
layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
ivec4 out0;


void main()
{
    bool in0 = bool(v_in0);
bool in1 = bool(v_in1);
bool in2 = bool(v_in2);
bool in3 = bool(v_in3);

    out0 = ivec4(in0, in1, in2, in3);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bool in0;
	bool in1;
	bool in2;
	bool in3;
};

layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }
ivec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec4(in0, in1, in2, in3);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 2) in uint a_in1;
layout(location = 3) in uint a_in2;
layout(location = 4) in uint a_in3;
layout(location = 0) flat out uvec4 v_out0;
bvec4 out0;


void main()
{
    bool in0 = bool(a_in0);
bool in1 = bool(a_in1);
bool in2 = bool(a_in2);
bool in3 = bool(a_in3);

    out0 = bvec4(in0, in1, in2, in3);
    gl_Position = dEQP_Position;
v_out0 = uvec4(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(location = 1) flat in uint v_in1;
layout(location = 2) flat in uint v_in2;
layout(location = 3) flat in uint v_in3;
layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
bvec4 out0;


void main()
{
    bool in0 = bool(v_in0);
bool in1 = bool(v_in1);
bool in2 = bool(v_in2);
bool in3 = bool(v_in3);

    out0 = bvec4(in0, in1, in2, in3);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bool in0;
	bool in1;
	bool in2;
	bool in3;
};

layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }
bvec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec4(in0, in1, in2, in3);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 2) in float in1;
layout(location = 3) in int in2;
layout(location = 4) in uint a_in3;
layout(location = 0) flat out vec4 out0;


void main()
{
    bool in0 = bool(a_in0);
bool in3 = bool(a_in3);

    out0 = vec4(in0, in1, in2, in3);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 0) flat out uint v_in0;
layout(location = 2) in float a_in1;
layout(location = 1) flat out float in1;
layout(location = 3) in int a_in2;
layout(location = 2) flat out int in2;
layout(location = 4) in uint a_in3;
layout(location = 3) flat out uint v_in3;

void main()
{
    gl_Position = dEQP_Position;
    v_in0 = a_in0;
    in1 = a_in1;
    in2 = a_in2;
    v_in3 = a_in3;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(location = 1) flat in float in1;
layout(location = 2) flat in int in2;
layout(location = 3) flat in uint v_in3;
layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
vec4 out0;


void main()
{
    bool in0 = bool(v_in0);
bool in3 = bool(v_in3);

    out0 = vec4(in0, in1, in2, in3);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bool in0;
	float in1;
	int in2;
	bool in3;
};

layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec4(in0, in1, in2, in3);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 2) in float in1;
layout(location = 3) in int in2;
layout(location = 4) in uint a_in3;
layout(location = 0) flat out ivec4 out0;


void main()
{
    bool in0 = bool(a_in0);
bool in3 = bool(a_in3);

    out0 = ivec4(in0, in1, in2, in3);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(location = 1) flat in float in1;
layout(location = 2) flat in int in2;
layout(location = 3) flat in uint v_in3;
layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
ivec4 out0;


void main()
{
    bool in0 = bool(v_in0);
bool in3 = bool(v_in3);

    out0 = ivec4(in0, in1, in2, in3);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bool in0;
	float in1;
	int in2;
	bool in3;
};

layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }
ivec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec4(in0, in1, in2, in3);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 2) in float in1;
layout(location = 3) in int in2;
layout(location = 4) in uint a_in3;
layout(location = 0) flat out uvec4 v_out0;
bvec4 out0;


void main()
{
    bool in0 = bool(a_in0);
bool in3 = bool(a_in3);

    out0 = bvec4(in0, in1, in2, in3);
    gl_Position = dEQP_Position;
v_out0 = uvec4(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(location = 1) flat in float in1;
layout(location = 2) flat in int in2;
layout(location = 3) flat in uint v_in3;
layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
bvec4 out0;


void main()
{
    bool in0 = bool(v_in0);
bool in3 = bool(v_in3);

    out0 = bvec4(in0, in1, in2, in3);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bool in0;
	float in1;
	int in2;
	bool in3;
};

layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }
bvec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec4(in0, in1, in2, in3);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 in0;
layout(location = 2) in ivec2 in1;
layout(location = 0) flat out vec4 out0;


void main()
{
    
    out0 = vec4(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 a_in0;
layout(location = 0) flat out vec2 in0;
layout(location = 2) in ivec2 a_in1;
layout(location = 1) flat out ivec2 in1;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
    in1 = a_in1;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec2 in0;
layout(location = 1) flat in ivec2 in1;
layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
vec4 out0;


void main()
{
    
    out0 = vec4(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec2 in0;
	ivec2 in1;
};

layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec4(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 in0;
layout(location = 2) in ivec2 in1;
layout(location = 0) flat out ivec4 out0;


void main()
{
    
    out0 = ivec4(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec2 in0;
layout(location = 1) flat in ivec2 in1;
layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
ivec4 out0;


void main()
{
    
    out0 = ivec4(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec2 in0;
	ivec2 in1;
};

layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }
ivec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec4(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 in0;
layout(location = 2) in ivec2 in1;
layout(location = 0) flat out uvec4 v_out0;
bvec4 out0;


void main()
{
    
    out0 = bvec4(in0, in1);
    gl_Position = dEQP_Position;
v_out0 = uvec4(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec2 in0;
layout(location = 1) flat in ivec2 in1;
layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
bvec4 out0;


void main()
{
    
    out0 = bvec4(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec2 in0;
	ivec2 in1;
};

layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }
bvec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec4(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 in0;
layout(location = 2) in uvec2 a_in1;
layout(location = 0) flat out vec4 out0;


void main()
{
    bvec2 in1 = bvec2(a_in1);

    out0 = vec4(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 a_in0;
layout(location = 0) flat out vec2 in0;
layout(location = 2) in uvec2 a_in1;
layout(location = 1) flat out uvec2 v_in1;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
    v_in1 = a_in1;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec2 in0;
layout(location = 1) flat in uvec2 v_in1;
layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
vec4 out0;


void main()
{
    bvec2 in1 = bvec2(v_in1);

    out0 = vec4(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec2 in0;
	bvec2 in1;
};

layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec4(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 in0;
layout(location = 2) in uvec2 a_in1;
layout(location = 0) flat out ivec4 out0;


void main()
{
    bvec2 in1 = bvec2(a_in1);

    out0 = ivec4(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec2 in0;
layout(location = 1) flat in uvec2 v_in1;
layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
ivec4 out0;


void main()
{
    bvec2 in1 = bvec2(v_in1);

    out0 = ivec4(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec2 in0;
	bvec2 in1;
};

layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }
ivec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec4(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 in0;
layout(location = 2) in uvec2 a_in1;
layout(location = 0) flat out uvec4 v_out0;
bvec4 out0;


void main()
{
    bvec2 in1 = bvec2(a_in1);

    out0 = bvec4(in0, in1);
    gl_Position = dEQP_Position;
v_out0 = uvec4(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec2 in0;
layout(location = 1) flat in uvec2 v_in1;
layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
bvec4 out0;


void main()
{
    bvec2 in1 = bvec2(v_in1);

    out0 = bvec4(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec2 in0;
	bvec2 in1;
};

layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }
bvec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec4(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 a_in0;
layout(location = 2) in float in1;
layout(location = 0) flat out vec4 out0;


void main()
{
    bvec3 in0 = bvec3(a_in0);

    out0 = vec4(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 a_in0;
layout(location = 0) flat out uvec3 v_in0;
layout(location = 2) in float a_in1;
layout(location = 1) flat out float in1;

void main()
{
    gl_Position = dEQP_Position;
    v_in0 = a_in0;
    in1 = a_in1;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec3 v_in0;
layout(location = 1) flat in float in1;
layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
vec4 out0;


void main()
{
    bvec3 in0 = bvec3(v_in0);

    out0 = vec4(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec3 in0;
	float in1;
};

layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec4(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 a_in0;
layout(location = 2) in float in1;
layout(location = 0) flat out ivec4 out0;


void main()
{
    bvec3 in0 = bvec3(a_in0);

    out0 = ivec4(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec3 v_in0;
layout(location = 1) flat in float in1;
layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
ivec4 out0;


void main()
{
    bvec3 in0 = bvec3(v_in0);

    out0 = ivec4(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec3 in0;
	float in1;
};

layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }
ivec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec4(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 a_in0;
layout(location = 2) in float in1;
layout(location = 0) flat out uvec4 v_out0;
bvec4 out0;


void main()
{
    bvec3 in0 = bvec3(a_in0);

    out0 = bvec4(in0, in1);
    gl_Position = dEQP_Position;
v_out0 = uvec4(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec3 v_in0;
layout(location = 1) flat in float in1;
layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
bvec4 out0;


void main()
{
    bvec3 in0 = bvec3(v_in0);

    out0 = bvec4(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec3 in0;
	float in1;
};

layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }
bvec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec4(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 2) in float in1;
layout(location = 0) flat out vec4 out0;


void main()
{
    
    out0 = vec4(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 a_in0;
layout(location = 0) flat out vec3 in0;
layout(location = 2) in float a_in1;
layout(location = 1) flat out float in1;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
    in1 = a_in1;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec3 in0;
layout(location = 1) flat in float in1;
layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
vec4 out0;


void main()
{
    
    out0 = vec4(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec3 in0;
	float in1;
};

layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec4(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 2) in float in1;
layout(location = 0) flat out ivec4 out0;


void main()
{
    
    out0 = ivec4(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec3 in0;
layout(location = 1) flat in float in1;
layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
ivec4 out0;


void main()
{
    
    out0 = ivec4(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec3 in0;
	float in1;
};

layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }
ivec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec4(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 2) in float in1;
layout(location = 0) flat out uvec4 v_out0;
bvec4 out0;


void main()
{
    
    out0 = bvec4(in0, in1);
    gl_Position = dEQP_Position;
v_out0 = uvec4(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec3 in0;
layout(location = 1) flat in float in1;
layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
bvec4 out0;


void main()
{
    
    out0 = bvec4(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec3 in0;
	float in1;
};

layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }
bvec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec4(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 2) in ivec2 in1;
layout(location = 3) in int in2;
layout(location = 0) flat out vec4 out0;


void main()
{
    
    out0 = vec4(in0, in1, in2);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int a_in0;
layout(location = 0) flat out int in0;
layout(location = 2) in ivec2 a_in1;
layout(location = 1) flat out ivec2 in1;
layout(location = 3) in int a_in2;
layout(location = 2) flat out int in2;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
    in1 = a_in1;
    in2 = a_in2;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in int in0;
layout(location = 1) flat in ivec2 in1;
layout(location = 2) flat in int in2;
layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
vec4 out0;


void main()
{
    
    out0 = vec4(in0, in1, in2);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	int in0;
	ivec2 in1;
	int in2;
};

layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec4(in0, in1, in2);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 2) in ivec2 in1;
layout(location = 3) in int in2;
layout(location = 0) flat out ivec4 out0;


void main()
{
    
    out0 = ivec4(in0, in1, in2);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in int in0;
layout(location = 1) flat in ivec2 in1;
layout(location = 2) flat in int in2;
layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
ivec4 out0;


void main()
{
    
    out0 = ivec4(in0, in1, in2);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	int in0;
	ivec2 in1;
	int in2;
};

layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }
ivec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec4(in0, in1, in2);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 2) in ivec2 in1;
layout(location = 3) in int in2;
layout(location = 0) flat out uvec4 v_out0;
bvec4 out0;


void main()
{
    
    out0 = bvec4(in0, in1, in2);
    gl_Position = dEQP_Position;
v_out0 = uvec4(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in int in0;
layout(location = 1) flat in ivec2 in1;
layout(location = 2) flat in int in2;
layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
bvec4 out0;


void main()
{
    
    out0 = bvec4(in0, in1, in2);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	int in0;
	ivec2 in1;
	int in2;
};

layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }
bvec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec4(in0, in1, in2);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 2) in float in1;
layout(location = 3) in ivec2 in2;
layout(location = 0) flat out vec4 out0;


void main()
{
    bool in0 = bool(a_in0);

    out0 = vec4(in0, in1, in2);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 0) flat out uint v_in0;
layout(location = 2) in float a_in1;
layout(location = 1) flat out float in1;
layout(location = 3) in ivec2 a_in2;
layout(location = 2) flat out ivec2 in2;

void main()
{
    gl_Position = dEQP_Position;
    v_in0 = a_in0;
    in1 = a_in1;
    in2 = a_in2;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(location = 1) flat in float in1;
layout(location = 2) flat in ivec2 in2;
layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
vec4 out0;


void main()
{
    bool in0 = bool(v_in0);

    out0 = vec4(in0, in1, in2);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bool in0;
	float in1;
	ivec2 in2;
};

layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec4(in0, in1, in2);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 2) in float in1;
layout(location = 3) in ivec2 in2;
layout(location = 0) flat out ivec4 out0;


void main()
{
    bool in0 = bool(a_in0);

    out0 = ivec4(in0, in1, in2);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(location = 1) flat in float in1;
layout(location = 2) flat in ivec2 in2;
layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
ivec4 out0;


void main()
{
    bool in0 = bool(v_in0);

    out0 = ivec4(in0, in1, in2);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bool in0;
	float in1;
	ivec2 in2;
};

layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }
ivec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec4(in0, in1, in2);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 2) in float in1;
layout(location = 3) in ivec2 in2;
layout(location = 0) flat out uvec4 v_out0;
bvec4 out0;


void main()
{
    bool in0 = bool(a_in0);

    out0 = bvec4(in0, in1, in2);
    gl_Position = dEQP_Position;
v_out0 = uvec4(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(location = 1) flat in float in1;
layout(location = 2) flat in ivec2 in2;
layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
bvec4 out0;


void main()
{
    bool in0 = bool(v_in0);

    out0 = bvec4(in0, in1, in2);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bool in0;
	float in1;
	ivec2 in2;
};

layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }
bvec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec4(in0, in1, in2);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 2) in uvec3 in1;
layout(location = 0) flat out vec4 out0;


void main()
{
    
    out0 = vec4(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float a_in0;
layout(location = 0) flat out float in0;
layout(location = 2) in uvec3 a_in1;
layout(location = 1) flat out uvec3 in1;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
    in1 = a_in1;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(location = 1) flat in uvec3 in1;
layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
vec4 out0;


void main()
{
    
    out0 = vec4(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	float in0;
	uvec3 in1;
};

layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec4(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 2) in uvec3 in1;
layout(location = 0) flat out ivec4 out0;


void main()
{
    
    out0 = ivec4(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(location = 1) flat in uvec3 in1;
layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
ivec4 out0;


void main()
{
    
    out0 = ivec4(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	float in0;
	uvec3 in1;
};

layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }
ivec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec4(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 2) in uvec3 in1;
layout(location = 0) flat out uvec4 v_out0;
bvec4 out0;


void main()
{
    
    out0 = bvec4(in0, in1);
    gl_Position = dEQP_Position;
v_out0 = uvec4(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(location = 1) flat in uvec3 in1;
layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
bvec4 out0;


void main()
{
    
    out0 = bvec4(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	float in0;
	uvec3 in1;
};

layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }
bvec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec4(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 2) in uvec2 in1;
layout(location = 3) in uint a_in2;
layout(location = 0) flat out vec4 out0;


void main()
{
    bool in2 = bool(a_in2);

    out0 = vec4(in0, in1, in2);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int a_in0;
layout(location = 0) flat out int in0;
layout(location = 2) in uvec2 a_in1;
layout(location = 1) flat out uvec2 in1;
layout(location = 3) in uint a_in2;
layout(location = 2) flat out uint v_in2;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
    in1 = a_in1;
    v_in2 = a_in2;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in int in0;
layout(location = 1) flat in uvec2 in1;
layout(location = 2) flat in uint v_in2;
layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
vec4 out0;


void main()
{
    bool in2 = bool(v_in2);

    out0 = vec4(in0, in1, in2);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	int in0;
	uvec2 in1;
	bool in2;
};

layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec4(in0, in1, in2);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 2) in uvec2 in1;
layout(location = 3) in uint a_in2;
layout(location = 0) flat out ivec4 out0;


void main()
{
    bool in2 = bool(a_in2);

    out0 = ivec4(in0, in1, in2);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in int in0;
layout(location = 1) flat in uvec2 in1;
layout(location = 2) flat in uint v_in2;
layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
ivec4 out0;


void main()
{
    bool in2 = bool(v_in2);

    out0 = ivec4(in0, in1, in2);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	int in0;
	uvec2 in1;
	bool in2;
};

layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }
ivec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec4(in0, in1, in2);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 2) in uvec2 in1;
layout(location = 3) in uint a_in2;
layout(location = 0) flat out uvec4 v_out0;
bvec4 out0;


void main()
{
    bool in2 = bool(a_in2);

    out0 = bvec4(in0, in1, in2);
    gl_Position = dEQP_Position;
v_out0 = uvec4(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in int in0;
layout(location = 1) flat in uvec2 in1;
layout(location = 2) flat in uint v_in2;
layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
bvec4 out0;


void main()
{
    bool in2 = bool(v_in2);

    out0 = bvec4(in0, in1, in2);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	int in0;
	uvec2 in1;
	bool in2;
};

layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }
bvec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec4(in0, in1, in2);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 in0;
layout(location = 2) in vec2 in1;
layout(location = 0) flat out uvec4 out0;


void main()
{
    
    out0 = uvec4(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec4 a, uvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec2 in0;
layout(location = 1) flat in vec2 in1;
layout(binding = 0, std140) uniform Reference
{
	uvec4 out0;
} ref;
uvec4 out0;


void main()
{
    
    out0 = uvec4(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec2 in0;
	vec2 in1;
};

layout(binding = 0, std140) uniform Reference
{
	uvec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec4 a, uvec4 b) { return (a == b); }
uvec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec4(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec2 a_in0;
layout(location = 2) in uvec2 a_in1;
layout(location = 0) flat out uvec4 out0;


void main()
{
    bvec2 in0 = bvec2(a_in0);
bvec2 in1 = bvec2(a_in1);

    out0 = uvec4(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec4 a, uvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec2 v_in0;
layout(location = 1) flat in uvec2 v_in1;
layout(binding = 0, std140) uniform Reference
{
	uvec4 out0;
} ref;
uvec4 out0;


void main()
{
    bvec2 in0 = bvec2(v_in0);
bvec2 in1 = bvec2(v_in1);

    out0 = uvec4(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec2 in0;
	bvec2 in1;
};

layout(binding = 0, std140) uniform Reference
{
	uvec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec4 a, uvec4 b) { return (a == b); }
uvec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec4(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 2) in float in1;
layout(location = 3) in float in2;
layout(location = 4) in float in3;
layout(location = 0) flat out uvec4 out0;


void main()
{
    
    out0 = uvec4(in0, in1, in2, in3);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec4 a, uvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(location = 1) flat in float in1;
layout(location = 2) flat in float in2;
layout(location = 3) flat in float in3;
layout(binding = 0, std140) uniform Reference
{
	uvec4 out0;
} ref;
uvec4 out0;


void main()
{
    
    out0 = uvec4(in0, in1, in2, in3);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	float in0;
	float in1;
	float in2;
	float in3;
};

layout(binding = 0, std140) uniform Reference
{
	uvec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec4 a, uvec4 b) { return (a == b); }
uvec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec4(in0, in1, in2, in3);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 2) in int in1;
layout(location = 3) in int in2;
layout(location = 4) in int in3;
layout(location = 0) flat out uvec4 out0;


void main()
{
    
    out0 = uvec4(in0, in1, in2, in3);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec4 a, uvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in int in0;
layout(location = 1) flat in int in1;
layout(location = 2) flat in int in2;
layout(location = 3) flat in int in3;
layout(binding = 0, std140) uniform Reference
{
	uvec4 out0;
} ref;
uvec4 out0;


void main()
{
    
    out0 = uvec4(in0, in1, in2, in3);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	int in0;
	int in1;
	int in2;
	int in3;
};

layout(binding = 0, std140) uniform Reference
{
	uvec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec4 a, uvec4 b) { return (a == b); }
uvec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec4(in0, in1, in2, in3);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint in0;
layout(location = 2) in uint in1;
layout(location = 3) in uint in2;
layout(location = 4) in uint in3;
layout(location = 0) flat out uvec4 out0;


void main()
{
    
    out0 = uvec4(in0, in1, in2, in3);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec4 a, uvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint in0;
layout(location = 1) flat in uint in1;
layout(location = 2) flat in uint in2;
layout(location = 3) flat in uint in3;
layout(binding = 0, std140) uniform Reference
{
	uvec4 out0;
} ref;
uvec4 out0;


void main()
{
    
    out0 = uvec4(in0, in1, in2, in3);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uint in0;
	uint in1;
	uint in2;
	uint in3;
};

layout(binding = 0, std140) uniform Reference
{
	uvec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec4 a, uvec4 b) { return (a == b); }
uvec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec4(in0, in1, in2, in3);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 2) in uint a_in1;
layout(location = 3) in uint a_in2;
layout(location = 4) in uint a_in3;
layout(location = 0) flat out uvec4 out0;


void main()
{
    bool in0 = bool(a_in0);
bool in1 = bool(a_in1);
bool in2 = bool(a_in2);
bool in3 = bool(a_in3);

    out0 = uvec4(in0, in1, in2, in3);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec4 a, uvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(location = 1) flat in uint v_in1;
layout(location = 2) flat in uint v_in2;
layout(location = 3) flat in uint v_in3;
layout(binding = 0, std140) uniform Reference
{
	uvec4 out0;
} ref;
uvec4 out0;


void main()
{
    bool in0 = bool(v_in0);
bool in1 = bool(v_in1);
bool in2 = bool(v_in2);
bool in3 = bool(v_in3);

    out0 = uvec4(in0, in1, in2, in3);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bool in0;
	bool in1;
	bool in2;
	bool in3;
};

layout(binding = 0, std140) uniform Reference
{
	uvec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec4 a, uvec4 b) { return (a == b); }
uvec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec4(in0, in1, in2, in3);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 2) in float in1;
layout(location = 3) in int in2;
layout(location = 4) in uint a_in3;
layout(location = 0) flat out uvec4 out0;


void main()
{
    bool in0 = bool(a_in0);
bool in3 = bool(a_in3);

    out0 = uvec4(in0, in1, in2, in3);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec4 a, uvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(location = 1) flat in float in1;
layout(location = 2) flat in int in2;
layout(location = 3) flat in uint v_in3;
layout(binding = 0, std140) uniform Reference
{
	uvec4 out0;
} ref;
uvec4 out0;


void main()
{
    bool in0 = bool(v_in0);
bool in3 = bool(v_in3);

    out0 = uvec4(in0, in1, in2, in3);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bool in0;
	float in1;
	int in2;
	bool in3;
};

layout(binding = 0, std140) uniform Reference
{
	uvec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec4 a, uvec4 b) { return (a == b); }
uvec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec4(in0, in1, in2, in3);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 in0;
layout(location = 2) in ivec2 in1;
layout(location = 0) flat out uvec4 out0;


void main()
{
    
    out0 = uvec4(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec4 a, uvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec2 in0;
layout(location = 1) flat in ivec2 in1;
layout(binding = 0, std140) uniform Reference
{
	uvec4 out0;
} ref;
uvec4 out0;


void main()
{
    
    out0 = uvec4(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec2 in0;
	ivec2 in1;
};

layout(binding = 0, std140) uniform Reference
{
	uvec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec4 a, uvec4 b) { return (a == b); }
uvec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec4(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 in0;
layout(location = 2) in uvec2 a_in1;
layout(location = 0) flat out uvec4 out0;


void main()
{
    bvec2 in1 = bvec2(a_in1);

    out0 = uvec4(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec4 a, uvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec2 in0;
layout(location = 1) flat in uvec2 v_in1;
layout(binding = 0, std140) uniform Reference
{
	uvec4 out0;
} ref;
uvec4 out0;


void main()
{
    bvec2 in1 = bvec2(v_in1);

    out0 = uvec4(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec2 in0;
	bvec2 in1;
};

layout(binding = 0, std140) uniform Reference
{
	uvec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec4 a, uvec4 b) { return (a == b); }
uvec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec4(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 a_in0;
layout(location = 2) in float in1;
layout(location = 0) flat out uvec4 out0;


void main()
{
    bvec3 in0 = bvec3(a_in0);

    out0 = uvec4(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec4 a, uvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec3 v_in0;
layout(location = 1) flat in float in1;
layout(binding = 0, std140) uniform Reference
{
	uvec4 out0;
} ref;
uvec4 out0;


void main()
{
    bvec3 in0 = bvec3(v_in0);

    out0 = uvec4(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec3 in0;
	float in1;
};

layout(binding = 0, std140) uniform Reference
{
	uvec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec4 a, uvec4 b) { return (a == b); }
uvec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec4(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 2) in float in1;
layout(location = 0) flat out uvec4 out0;


void main()
{
    
    out0 = uvec4(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec4 a, uvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec3 in0;
layout(location = 1) flat in float in1;
layout(binding = 0, std140) uniform Reference
{
	uvec4 out0;
} ref;
uvec4 out0;


void main()
{
    
    out0 = uvec4(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec3 in0;
	float in1;
};

layout(binding = 0, std140) uniform Reference
{
	uvec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec4 a, uvec4 b) { return (a == b); }
uvec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec4(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 2) in ivec2 in1;
layout(location = 3) in int in2;
layout(location = 0) flat out uvec4 out0;


void main()
{
    
    out0 = uvec4(in0, in1, in2);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec4 a, uvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in int in0;
layout(location = 1) flat in ivec2 in1;
layout(location = 2) flat in int in2;
layout(binding = 0, std140) uniform Reference
{
	uvec4 out0;
} ref;
uvec4 out0;


void main()
{
    
    out0 = uvec4(in0, in1, in2);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	int in0;
	ivec2 in1;
	int in2;
};

layout(binding = 0, std140) uniform Reference
{
	uvec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec4 a, uvec4 b) { return (a == b); }
uvec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec4(in0, in1, in2);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 2) in float in1;
layout(location = 3) in ivec2 in2;
layout(location = 0) flat out uvec4 out0;


void main()
{
    bool in0 = bool(a_in0);

    out0 = uvec4(in0, in1, in2);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec4 a, uvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(location = 1) flat in float in1;
layout(location = 2) flat in ivec2 in2;
layout(binding = 0, std140) uniform Reference
{
	uvec4 out0;
} ref;
uvec4 out0;


void main()
{
    bool in0 = bool(v_in0);

    out0 = uvec4(in0, in1, in2);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bool in0;
	float in1;
	ivec2 in2;
};

layout(binding = 0, std140) uniform Reference
{
	uvec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec4 a, uvec4 b) { return (a == b); }
uvec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec4(in0, in1, in2);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 2) in uvec3 in1;
layout(location = 0) flat out uvec4 out0;


void main()
{
    
    out0 = uvec4(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec4 a, uvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(location = 1) flat in uvec3 in1;
layout(binding = 0, std140) uniform Reference
{
	uvec4 out0;
} ref;
uvec4 out0;


void main()
{
    
    out0 = uvec4(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	float in0;
	uvec3 in1;
};

layout(binding = 0, std140) uniform Reference
{
	uvec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec4 a, uvec4 b) { return (a == b); }
uvec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec4(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 2) in uvec2 in1;
layout(location = 3) in uint a_in2;
layout(location = 0) flat out uvec4 out0;


void main()
{
    bool in2 = bool(a_in2);

    out0 = uvec4(in0, in1, in2);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec4 a, uvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in int in0;
layout(location = 1) flat in uvec2 in1;
layout(location = 2) flat in uint v_in2;
layout(binding = 0, std140) uniform Reference
{
	uvec4 out0;
} ref;
uvec4 out0;


void main()
{
    bool in2 = bool(v_in2);

    out0 = uvec4(in0, in1, in2);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	int in0;
	uvec2 in1;
	bool in2;
};

layout(binding = 0, std140) uniform Reference
{
	uvec4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec4 a, uvec4 b) { return (a == b); }
uvec4 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec4(in0, in1, in2);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 2) in float in1;
layout(location = 3) in float in2;
layout(location = 0) flat out vec3 out0;


void main()
{
    
    out0 = vec3(in0, in1, in2);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float a_in0;
layout(location = 0) flat out float in0;
layout(location = 2) in float a_in1;
layout(location = 1) flat out float in1;
layout(location = 3) in float a_in2;
layout(location = 2) flat out float in2;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
    in1 = a_in1;
    in2 = a_in2;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(location = 1) flat in float in1;
layout(location = 2) flat in float in2;
layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
vec3 out0;


void main()
{
    
    out0 = vec3(in0, in1, in2);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	float in0;
	float in1;
	float in2;
};

layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec3(in0, in1, in2);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 2) in float in1;
layout(location = 3) in float in2;
layout(location = 0) flat out ivec3 out0;


void main()
{
    
    out0 = ivec3(in0, in1, in2);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec3 a, ivec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(location = 1) flat in float in1;
layout(location = 2) flat in float in2;
layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;
ivec3 out0;


void main()
{
    
    out0 = ivec3(in0, in1, in2);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	float in0;
	float in1;
	float in2;
};

layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec3 a, ivec3 b) { return (a == b); }
ivec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec3(in0, in1, in2);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 2) in float in1;
layout(location = 3) in float in2;
layout(location = 0) flat out uvec3 v_out0;
bvec3 out0;


void main()
{
    
    out0 = bvec3(in0, in1, in2);
    gl_Position = dEQP_Position;
v_out0 = uvec3(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec3 a, bvec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(location = 1) flat in float in1;
layout(location = 2) flat in float in2;
layout(binding = 0, std140) uniform Reference
{
	bvec3 out0;
} ref;
bvec3 out0;


void main()
{
    
    out0 = bvec3(in0, in1, in2);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	float in0;
	float in1;
	float in2;
};

layout(binding = 0, std140) uniform Reference
{
	bvec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec3 a, bvec3 b) { return (a == b); }
bvec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec3(in0, in1, in2);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 2) in int in1;
layout(location = 3) in int in2;
layout(location = 0) flat out vec3 out0;


void main()
{
    
    out0 = vec3(in0, in1, in2);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int a_in0;
layout(location = 0) flat out int in0;
layout(location = 2) in int a_in1;
layout(location = 1) flat out int in1;
layout(location = 3) in int a_in2;
layout(location = 2) flat out int in2;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
    in1 = a_in1;
    in2 = a_in2;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in int in0;
layout(location = 1) flat in int in1;
layout(location = 2) flat in int in2;
layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
vec3 out0;


void main()
{
    
    out0 = vec3(in0, in1, in2);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	int in0;
	int in1;
	int in2;
};

layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec3(in0, in1, in2);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 2) in int in1;
layout(location = 3) in int in2;
layout(location = 0) flat out ivec3 out0;


void main()
{
    
    out0 = ivec3(in0, in1, in2);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec3 a, ivec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in int in0;
layout(location = 1) flat in int in1;
layout(location = 2) flat in int in2;
layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;
ivec3 out0;


void main()
{
    
    out0 = ivec3(in0, in1, in2);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	int in0;
	int in1;
	int in2;
};

layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec3 a, ivec3 b) { return (a == b); }
ivec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec3(in0, in1, in2);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 2) in int in1;
layout(location = 3) in int in2;
layout(location = 0) flat out uvec3 v_out0;
bvec3 out0;


void main()
{
    
    out0 = bvec3(in0, in1, in2);
    gl_Position = dEQP_Position;
v_out0 = uvec3(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec3 a, bvec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in int in0;
layout(location = 1) flat in int in1;
layout(location = 2) flat in int in2;
layout(binding = 0, std140) uniform Reference
{
	bvec3 out0;
} ref;
bvec3 out0;


void main()
{
    
    out0 = bvec3(in0, in1, in2);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	int in0;
	int in1;
	int in2;
};

layout(binding = 0, std140) uniform Reference
{
	bvec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec3 a, bvec3 b) { return (a == b); }
bvec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec3(in0, in1, in2);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint in0;
layout(location = 2) in uint in1;
layout(location = 3) in uint in2;
layout(location = 0) flat out vec3 out0;


void main()
{
    
    out0 = vec3(in0, in1, in2);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 0) flat out uint in0;
layout(location = 2) in uint a_in1;
layout(location = 1) flat out uint in1;
layout(location = 3) in uint a_in2;
layout(location = 2) flat out uint in2;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
    in1 = a_in1;
    in2 = a_in2;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint in0;
layout(location = 1) flat in uint in1;
layout(location = 2) flat in uint in2;
layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
vec3 out0;


void main()
{
    
    out0 = vec3(in0, in1, in2);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uint in0;
	uint in1;
	uint in2;
};

layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec3(in0, in1, in2);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint in0;
layout(location = 2) in uint in1;
layout(location = 3) in uint in2;
layout(location = 0) flat out ivec3 out0;


void main()
{
    
    out0 = ivec3(in0, in1, in2);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec3 a, ivec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint in0;
layout(location = 1) flat in uint in1;
layout(location = 2) flat in uint in2;
layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;
ivec3 out0;


void main()
{
    
    out0 = ivec3(in0, in1, in2);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uint in0;
	uint in1;
	uint in2;
};

layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec3 a, ivec3 b) { return (a == b); }
ivec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec3(in0, in1, in2);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint in0;
layout(location = 2) in uint in1;
layout(location = 3) in uint in2;
layout(location = 0) flat out uvec3 v_out0;
bvec3 out0;


void main()
{
    
    out0 = bvec3(in0, in1, in2);
    gl_Position = dEQP_Position;
v_out0 = uvec3(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec3 a, bvec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint in0;
layout(location = 1) flat in uint in1;
layout(location = 2) flat in uint in2;
layout(binding = 0, std140) uniform Reference
{
	bvec3 out0;
} ref;
bvec3 out0;


void main()
{
    
    out0 = bvec3(in0, in1, in2);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uint in0;
	uint in1;
	uint in2;
};

layout(binding = 0, std140) uniform Reference
{
	bvec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec3 a, bvec3 b) { return (a == b); }
bvec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec3(in0, in1, in2);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 2) in uint a_in1;
layout(location = 3) in uint a_in2;
layout(location = 0) flat out vec3 out0;


void main()
{
    bool in0 = bool(a_in0);
bool in1 = bool(a_in1);
bool in2 = bool(a_in2);

    out0 = vec3(in0, in1, in2);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 0) flat out uint v_in0;
layout(location = 2) in uint a_in1;
layout(location = 1) flat out uint v_in1;
layout(location = 3) in uint a_in2;
layout(location = 2) flat out uint v_in2;

void main()
{
    gl_Position = dEQP_Position;
    v_in0 = a_in0;
    v_in1 = a_in1;
    v_in2 = a_in2;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(location = 1) flat in uint v_in1;
layout(location = 2) flat in uint v_in2;
layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
vec3 out0;


void main()
{
    bool in0 = bool(v_in0);
bool in1 = bool(v_in1);
bool in2 = bool(v_in2);

    out0 = vec3(in0, in1, in2);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bool in0;
	bool in1;
	bool in2;
};

layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec3(in0, in1, in2);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 2) in uint a_in1;
layout(location = 3) in uint a_in2;
layout(location = 0) flat out ivec3 out0;


void main()
{
    bool in0 = bool(a_in0);
bool in1 = bool(a_in1);
bool in2 = bool(a_in2);

    out0 = ivec3(in0, in1, in2);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec3 a, ivec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(location = 1) flat in uint v_in1;
layout(location = 2) flat in uint v_in2;
layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;
ivec3 out0;


void main()
{
    bool in0 = bool(v_in0);
bool in1 = bool(v_in1);
bool in2 = bool(v_in2);

    out0 = ivec3(in0, in1, in2);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bool in0;
	bool in1;
	bool in2;
};

layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec3 a, ivec3 b) { return (a == b); }
ivec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec3(in0, in1, in2);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 2) in uint a_in1;
layout(location = 3) in uint a_in2;
layout(location = 0) flat out uvec3 v_out0;
bvec3 out0;


void main()
{
    bool in0 = bool(a_in0);
bool in1 = bool(a_in1);
bool in2 = bool(a_in2);

    out0 = bvec3(in0, in1, in2);
    gl_Position = dEQP_Position;
v_out0 = uvec3(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec3 a, bvec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(location = 1) flat in uint v_in1;
layout(location = 2) flat in uint v_in2;
layout(binding = 0, std140) uniform Reference
{
	bvec3 out0;
} ref;
bvec3 out0;


void main()
{
    bool in0 = bool(v_in0);
bool in1 = bool(v_in1);
bool in2 = bool(v_in2);

    out0 = bvec3(in0, in1, in2);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bool in0;
	bool in1;
	bool in2;
};

layout(binding = 0, std140) uniform Reference
{
	bvec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec3 a, bvec3 b) { return (a == b); }
bvec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec3(in0, in1, in2);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 2) in float in1;
layout(location = 3) in int in2;
layout(location = 0) flat out vec3 out0;


void main()
{
    bool in0 = bool(a_in0);

    out0 = vec3(in0, in1, in2);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 0) flat out uint v_in0;
layout(location = 2) in float a_in1;
layout(location = 1) flat out float in1;
layout(location = 3) in int a_in2;
layout(location = 2) flat out int in2;

void main()
{
    gl_Position = dEQP_Position;
    v_in0 = a_in0;
    in1 = a_in1;
    in2 = a_in2;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(location = 1) flat in float in1;
layout(location = 2) flat in int in2;
layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
vec3 out0;


void main()
{
    bool in0 = bool(v_in0);

    out0 = vec3(in0, in1, in2);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bool in0;
	float in1;
	int in2;
};

layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec3(in0, in1, in2);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 2) in float in1;
layout(location = 3) in int in2;
layout(location = 0) flat out ivec3 out0;


void main()
{
    bool in0 = bool(a_in0);

    out0 = ivec3(in0, in1, in2);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec3 a, ivec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(location = 1) flat in float in1;
layout(location = 2) flat in int in2;
layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;
ivec3 out0;


void main()
{
    bool in0 = bool(v_in0);

    out0 = ivec3(in0, in1, in2);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bool in0;
	float in1;
	int in2;
};

layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec3 a, ivec3 b) { return (a == b); }
ivec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec3(in0, in1, in2);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 2) in float in1;
layout(location = 3) in int in2;
layout(location = 0) flat out uvec3 v_out0;
bvec3 out0;


void main()
{
    bool in0 = bool(a_in0);

    out0 = bvec3(in0, in1, in2);
    gl_Position = dEQP_Position;
v_out0 = uvec3(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec3 a, bvec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(location = 1) flat in float in1;
layout(location = 2) flat in int in2;
layout(binding = 0, std140) uniform Reference
{
	bvec3 out0;
} ref;
bvec3 out0;


void main()
{
    bool in0 = bool(v_in0);

    out0 = bvec3(in0, in1, in2);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bool in0;
	float in1;
	int in2;
};

layout(binding = 0, std140) uniform Reference
{
	bvec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec3 a, bvec3 b) { return (a == b); }
bvec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec3(in0, in1, in2);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 in0;
layout(location = 2) in uint a_in1;
layout(location = 0) flat out vec3 out0;


void main()
{
    bool in1 = bool(a_in1);

    out0 = vec3(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 a_in0;
layout(location = 0) flat out vec2 in0;
layout(location = 2) in uint a_in1;
layout(location = 1) flat out uint v_in1;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
    v_in1 = a_in1;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec2 in0;
layout(location = 1) flat in uint v_in1;
layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
vec3 out0;


void main()
{
    bool in1 = bool(v_in1);

    out0 = vec3(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec2 in0;
	bool in1;
};

layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec3(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 in0;
layout(location = 2) in uint a_in1;
layout(location = 0) flat out ivec3 out0;


void main()
{
    bool in1 = bool(a_in1);

    out0 = ivec3(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec3 a, ivec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec2 in0;
layout(location = 1) flat in uint v_in1;
layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;
ivec3 out0;


void main()
{
    bool in1 = bool(v_in1);

    out0 = ivec3(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec2 in0;
	bool in1;
};

layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec3 a, ivec3 b) { return (a == b); }
ivec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec3(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 in0;
layout(location = 2) in uint a_in1;
layout(location = 0) flat out uvec3 v_out0;
bvec3 out0;


void main()
{
    bool in1 = bool(a_in1);

    out0 = bvec3(in0, in1);
    gl_Position = dEQP_Position;
v_out0 = uvec3(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec3 a, bvec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec2 in0;
layout(location = 1) flat in uint v_in1;
layout(binding = 0, std140) uniform Reference
{
	bvec3 out0;
} ref;
bvec3 out0;


void main()
{
    bool in1 = bool(v_in1);

    out0 = bvec3(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec2 in0;
	bool in1;
};

layout(binding = 0, std140) uniform Reference
{
	bvec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec3 a, bvec3 b) { return (a == b); }
bvec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec3(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec2 a_in0;
layout(location = 2) in float in1;
layout(location = 0) flat out vec3 out0;


void main()
{
    bvec2 in0 = bvec2(a_in0);

    out0 = vec3(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec2 a_in0;
layout(location = 0) flat out uvec2 v_in0;
layout(location = 2) in float a_in1;
layout(location = 1) flat out float in1;

void main()
{
    gl_Position = dEQP_Position;
    v_in0 = a_in0;
    in1 = a_in1;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec2 v_in0;
layout(location = 1) flat in float in1;
layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
vec3 out0;


void main()
{
    bvec2 in0 = bvec2(v_in0);

    out0 = vec3(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec2 in0;
	float in1;
};

layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec3(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec2 a_in0;
layout(location = 2) in float in1;
layout(location = 0) flat out ivec3 out0;


void main()
{
    bvec2 in0 = bvec2(a_in0);

    out0 = ivec3(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec3 a, ivec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec2 v_in0;
layout(location = 1) flat in float in1;
layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;
ivec3 out0;


void main()
{
    bvec2 in0 = bvec2(v_in0);

    out0 = ivec3(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec2 in0;
	float in1;
};

layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec3 a, ivec3 b) { return (a == b); }
ivec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec3(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec2 a_in0;
layout(location = 2) in float in1;
layout(location = 0) flat out uvec3 v_out0;
bvec3 out0;


void main()
{
    bvec2 in0 = bvec2(a_in0);

    out0 = bvec3(in0, in1);
    gl_Position = dEQP_Position;
v_out0 = uvec3(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec3 a, bvec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec2 v_in0;
layout(location = 1) flat in float in1;
layout(binding = 0, std140) uniform Reference
{
	bvec3 out0;
} ref;
bvec3 out0;


void main()
{
    bvec2 in0 = bvec2(v_in0);

    out0 = bvec3(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec2 in0;
	float in1;
};

layout(binding = 0, std140) uniform Reference
{
	bvec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec3 a, bvec3 b) { return (a == b); }
bvec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec3(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec2 a_in0;
layout(location = 2) in int in1;
layout(location = 0) flat out vec3 out0;


void main()
{
    bvec2 in0 = bvec2(a_in0);

    out0 = vec3(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec2 a_in0;
layout(location = 0) flat out uvec2 v_in0;
layout(location = 2) in int a_in1;
layout(location = 1) flat out int in1;

void main()
{
    gl_Position = dEQP_Position;
    v_in0 = a_in0;
    in1 = a_in1;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec2 v_in0;
layout(location = 1) flat in int in1;
layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
vec3 out0;


void main()
{
    bvec2 in0 = bvec2(v_in0);

    out0 = vec3(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec2 in0;
	int in1;
};

layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec3(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec2 a_in0;
layout(location = 2) in int in1;
layout(location = 0) flat out ivec3 out0;


void main()
{
    bvec2 in0 = bvec2(a_in0);

    out0 = ivec3(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec3 a, ivec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec2 v_in0;
layout(location = 1) flat in int in1;
layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;
ivec3 out0;


void main()
{
    bvec2 in0 = bvec2(v_in0);

    out0 = ivec3(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec2 in0;
	int in1;
};

layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec3 a, ivec3 b) { return (a == b); }
ivec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec3(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec2 a_in0;
layout(location = 2) in int in1;
layout(location = 0) flat out uvec3 v_out0;
bvec3 out0;


void main()
{
    bvec2 in0 = bvec2(a_in0);

    out0 = bvec3(in0, in1);
    gl_Position = dEQP_Position;
v_out0 = uvec3(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec3 a, bvec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec2 v_in0;
layout(location = 1) flat in int in1;
layout(binding = 0, std140) uniform Reference
{
	bvec3 out0;
} ref;
bvec3 out0;


void main()
{
    bvec2 in0 = bvec2(v_in0);

    out0 = bvec3(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec2 in0;
	int in1;
};

layout(binding = 0, std140) uniform Reference
{
	bvec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec3 a, bvec3 b) { return (a == b); }
bvec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec3(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 2) in ivec2 in1;
layout(location = 0) flat out vec3 out0;


void main()
{
    bool in0 = bool(a_in0);

    out0 = vec3(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 0) flat out uint v_in0;
layout(location = 2) in ivec2 a_in1;
layout(location = 1) flat out ivec2 in1;

void main()
{
    gl_Position = dEQP_Position;
    v_in0 = a_in0;
    in1 = a_in1;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(location = 1) flat in ivec2 in1;
layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
vec3 out0;


void main()
{
    bool in0 = bool(v_in0);

    out0 = vec3(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bool in0;
	ivec2 in1;
};

layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec3(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 2) in ivec2 in1;
layout(location = 0) flat out ivec3 out0;


void main()
{
    bool in0 = bool(a_in0);

    out0 = ivec3(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec3 a, ivec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(location = 1) flat in ivec2 in1;
layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;
ivec3 out0;


void main()
{
    bool in0 = bool(v_in0);

    out0 = ivec3(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bool in0;
	ivec2 in1;
};

layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec3 a, ivec3 b) { return (a == b); }
ivec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec3(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 2) in ivec2 in1;
layout(location = 0) flat out uvec3 v_out0;
bvec3 out0;


void main()
{
    bool in0 = bool(a_in0);

    out0 = bvec3(in0, in1);
    gl_Position = dEQP_Position;
v_out0 = uvec3(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec3 a, bvec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(location = 1) flat in ivec2 in1;
layout(binding = 0, std140) uniform Reference
{
	bvec3 out0;
} ref;
bvec3 out0;


void main()
{
    bool in0 = bool(v_in0);

    out0 = bvec3(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bool in0;
	ivec2 in1;
};

layout(binding = 0, std140) uniform Reference
{
	bvec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec3 a, bvec3 b) { return (a == b); }
bvec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec3(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 2) in uvec2 in1;
layout(location = 0) flat out vec3 out0;


void main()
{
    
    out0 = vec3(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float a_in0;
layout(location = 0) flat out float in0;
layout(location = 2) in uvec2 a_in1;
layout(location = 1) flat out uvec2 in1;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
    in1 = a_in1;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(location = 1) flat in uvec2 in1;
layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
vec3 out0;


void main()
{
    
    out0 = vec3(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	float in0;
	uvec2 in1;
};

layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec3(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 2) in uvec2 in1;
layout(location = 0) flat out ivec3 out0;


void main()
{
    
    out0 = ivec3(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec3 a, ivec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(location = 1) flat in uvec2 in1;
layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;
ivec3 out0;


void main()
{
    
    out0 = ivec3(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	float in0;
	uvec2 in1;
};

layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec3 a, ivec3 b) { return (a == b); }
ivec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec3(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 2) in uvec2 in1;
layout(location = 0) flat out uvec3 v_out0;
bvec3 out0;


void main()
{
    
    out0 = bvec3(in0, in1);
    gl_Position = dEQP_Position;
v_out0 = uvec3(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec3 a, bvec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(location = 1) flat in uvec2 in1;
layout(binding = 0, std140) uniform Reference
{
	bvec3 out0;
} ref;
bvec3 out0;


void main()
{
    
    out0 = bvec3(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	float in0;
	uvec2 in1;
};

layout(binding = 0, std140) uniform Reference
{
	bvec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec3 a, bvec3 b) { return (a == b); }
bvec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec3(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 2) in float in1;
layout(location = 3) in float in2;
layout(location = 0) flat out uvec3 out0;


void main()
{
    
    out0 = uvec3(in0, in1, in2);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec3 a, uvec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(location = 1) flat in float in1;
layout(location = 2) flat in float in2;
layout(binding = 0, std140) uniform Reference
{
	uvec3 out0;
} ref;
uvec3 out0;


void main()
{
    
    out0 = uvec3(in0, in1, in2);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	float in0;
	float in1;
	float in2;
};

layout(binding = 0, std140) uniform Reference
{
	uvec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec3 a, uvec3 b) { return (a == b); }
uvec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec3(in0, in1, in2);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 2) in int in1;
layout(location = 3) in int in2;
layout(location = 0) flat out uvec3 out0;


void main()
{
    
    out0 = uvec3(in0, in1, in2);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec3 a, uvec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in int in0;
layout(location = 1) flat in int in1;
layout(location = 2) flat in int in2;
layout(binding = 0, std140) uniform Reference
{
	uvec3 out0;
} ref;
uvec3 out0;


void main()
{
    
    out0 = uvec3(in0, in1, in2);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	int in0;
	int in1;
	int in2;
};

layout(binding = 0, std140) uniform Reference
{
	uvec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec3 a, uvec3 b) { return (a == b); }
uvec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec3(in0, in1, in2);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint in0;
layout(location = 2) in uint in1;
layout(location = 3) in uint in2;
layout(location = 0) flat out uvec3 out0;


void main()
{
    
    out0 = uvec3(in0, in1, in2);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec3 a, uvec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint in0;
layout(location = 1) flat in uint in1;
layout(location = 2) flat in uint in2;
layout(binding = 0, std140) uniform Reference
{
	uvec3 out0;
} ref;
uvec3 out0;


void main()
{
    
    out0 = uvec3(in0, in1, in2);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uint in0;
	uint in1;
	uint in2;
};

layout(binding = 0, std140) uniform Reference
{
	uvec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec3 a, uvec3 b) { return (a == b); }
uvec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec3(in0, in1, in2);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 2) in uint a_in1;
layout(location = 3) in uint a_in2;
layout(location = 0) flat out uvec3 out0;


void main()
{
    bool in0 = bool(a_in0);
bool in1 = bool(a_in1);
bool in2 = bool(a_in2);

    out0 = uvec3(in0, in1, in2);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec3 a, uvec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(location = 1) flat in uint v_in1;
layout(location = 2) flat in uint v_in2;
layout(binding = 0, std140) uniform Reference
{
	uvec3 out0;
} ref;
uvec3 out0;


void main()
{
    bool in0 = bool(v_in0);
bool in1 = bool(v_in1);
bool in2 = bool(v_in2);

    out0 = uvec3(in0, in1, in2);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bool in0;
	bool in1;
	bool in2;
};

layout(binding = 0, std140) uniform Reference
{
	uvec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec3 a, uvec3 b) { return (a == b); }
uvec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec3(in0, in1, in2);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 2) in float in1;
layout(location = 3) in int in2;
layout(location = 0) flat out uvec3 out0;


void main()
{
    bool in0 = bool(a_in0);

    out0 = uvec3(in0, in1, in2);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec3 a, uvec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(location = 1) flat in float in1;
layout(location = 2) flat in int in2;
layout(binding = 0, std140) uniform Reference
{
	uvec3 out0;
} ref;
uvec3 out0;


void main()
{
    bool in0 = bool(v_in0);

    out0 = uvec3(in0, in1, in2);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bool in0;
	float in1;
	int in2;
};

layout(binding = 0, std140) uniform Reference
{
	uvec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec3 a, uvec3 b) { return (a == b); }
uvec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec3(in0, in1, in2);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 in0;
layout(location = 2) in uint a_in1;
layout(location = 0) flat out uvec3 out0;


void main()
{
    bool in1 = bool(a_in1);

    out0 = uvec3(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec3 a, uvec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec2 in0;
layout(location = 1) flat in uint v_in1;
layout(binding = 0, std140) uniform Reference
{
	uvec3 out0;
} ref;
uvec3 out0;


void main()
{
    bool in1 = bool(v_in1);

    out0 = uvec3(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec2 in0;
	bool in1;
};

layout(binding = 0, std140) uniform Reference
{
	uvec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec3 a, uvec3 b) { return (a == b); }
uvec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec3(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec2 a_in0;
layout(location = 2) in float in1;
layout(location = 0) flat out uvec3 out0;


void main()
{
    bvec2 in0 = bvec2(a_in0);

    out0 = uvec3(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec3 a, uvec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec2 v_in0;
layout(location = 1) flat in float in1;
layout(binding = 0, std140) uniform Reference
{
	uvec3 out0;
} ref;
uvec3 out0;


void main()
{
    bvec2 in0 = bvec2(v_in0);

    out0 = uvec3(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec2 in0;
	float in1;
};

layout(binding = 0, std140) uniform Reference
{
	uvec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec3 a, uvec3 b) { return (a == b); }
uvec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec3(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec2 a_in0;
layout(location = 2) in int in1;
layout(location = 0) flat out uvec3 out0;


void main()
{
    bvec2 in0 = bvec2(a_in0);

    out0 = uvec3(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec3 a, uvec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec2 v_in0;
layout(location = 1) flat in int in1;
layout(binding = 0, std140) uniform Reference
{
	uvec3 out0;
} ref;
uvec3 out0;


void main()
{
    bvec2 in0 = bvec2(v_in0);

    out0 = uvec3(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bvec2 in0;
	int in1;
};

layout(binding = 0, std140) uniform Reference
{
	uvec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec3 a, uvec3 b) { return (a == b); }
uvec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec3(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 2) in ivec2 in1;
layout(location = 0) flat out uvec3 out0;


void main()
{
    bool in0 = bool(a_in0);

    out0 = uvec3(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec3 a, uvec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(location = 1) flat in ivec2 in1;
layout(binding = 0, std140) uniform Reference
{
	uvec3 out0;
} ref;
uvec3 out0;


void main()
{
    bool in0 = bool(v_in0);

    out0 = uvec3(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bool in0;
	ivec2 in1;
};

layout(binding = 0, std140) uniform Reference
{
	uvec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec3 a, uvec3 b) { return (a == b); }
uvec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec3(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 2) in uvec2 in1;
layout(location = 0) flat out uvec3 out0;


void main()
{
    
    out0 = uvec3(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec3 a, uvec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(location = 1) flat in uvec2 in1;
layout(binding = 0, std140) uniform Reference
{
	uvec3 out0;
} ref;
uvec3 out0;


void main()
{
    
    out0 = uvec3(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	float in0;
	uvec2 in1;
};

layout(binding = 0, std140) uniform Reference
{
	uvec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec3 a, uvec3 b) { return (a == b); }
uvec3 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec3(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 2) in float in1;
layout(location = 0) flat out vec2 out0;


void main()
{
    
    out0 = vec2(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float a_in0;
layout(location = 0) flat out float in0;
layout(location = 2) in float a_in1;
layout(location = 1) flat out float in1;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
    in1 = a_in1;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec2 a, vec2 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(location = 1) flat in float in1;
layout(binding = 0, std140) uniform Reference
{
	vec2 out0;
} ref;
vec2 out0;


void main()
{
    
    out0 = vec2(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	float in0;
	float in1;
};

layout(binding = 0, std140) uniform Reference
{
	vec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec2 a, vec2 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec2(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 2) in float in1;
layout(location = 0) flat out ivec2 out0;


void main()
{
    
    out0 = ivec2(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec2 a, ivec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(location = 1) flat in float in1;
layout(binding = 0, std140) uniform Reference
{
	ivec2 out0;
} ref;
ivec2 out0;


void main()
{
    
    out0 = ivec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	float in0;
	float in1;
};

layout(binding = 0, std140) uniform Reference
{
	ivec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec2 a, ivec2 b) { return (a == b); }
ivec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 2) in float in1;
layout(location = 0) flat out uvec2 v_out0;
bvec2 out0;


void main()
{
    
    out0 = bvec2(in0, in1);
    gl_Position = dEQP_Position;
v_out0 = uvec2(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec2 a, bvec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(location = 1) flat in float in1;
layout(binding = 0, std140) uniform Reference
{
	bvec2 out0;
} ref;
bvec2 out0;


void main()
{
    
    out0 = bvec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	float in0;
	float in1;
};

layout(binding = 0, std140) uniform Reference
{
	bvec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec2 a, bvec2 b) { return (a == b); }
bvec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 2) in int in1;
layout(location = 0) flat out vec2 out0;


void main()
{
    
    out0 = vec2(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int a_in0;
layout(location = 0) flat out int in0;
layout(location = 2) in int a_in1;
layout(location = 1) flat out int in1;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
    in1 = a_in1;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec2 a, vec2 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in int in0;
layout(location = 1) flat in int in1;
layout(binding = 0, std140) uniform Reference
{
	vec2 out0;
} ref;
vec2 out0;


void main()
{
    
    out0 = vec2(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	int in0;
	int in1;
};

layout(binding = 0, std140) uniform Reference
{
	vec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec2 a, vec2 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec2(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 2) in int in1;
layout(location = 0) flat out ivec2 out0;


void main()
{
    
    out0 = ivec2(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec2 a, ivec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in int in0;
layout(location = 1) flat in int in1;
layout(binding = 0, std140) uniform Reference
{
	ivec2 out0;
} ref;
ivec2 out0;


void main()
{
    
    out0 = ivec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	int in0;
	int in1;
};

layout(binding = 0, std140) uniform Reference
{
	ivec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec2 a, ivec2 b) { return (a == b); }
ivec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 2) in int in1;
layout(location = 0) flat out uvec2 v_out0;
bvec2 out0;


void main()
{
    
    out0 = bvec2(in0, in1);
    gl_Position = dEQP_Position;
v_out0 = uvec2(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec2 a, bvec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in int in0;
layout(location = 1) flat in int in1;
layout(binding = 0, std140) uniform Reference
{
	bvec2 out0;
} ref;
bvec2 out0;


void main()
{
    
    out0 = bvec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	int in0;
	int in1;
};

layout(binding = 0, std140) uniform Reference
{
	bvec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec2 a, bvec2 b) { return (a == b); }
bvec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint in0;
layout(location = 2) in uint in1;
layout(location = 0) flat out vec2 out0;


void main()
{
    
    out0 = vec2(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 0) flat out uint in0;
layout(location = 2) in uint a_in1;
layout(location = 1) flat out uint in1;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
    in1 = a_in1;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec2 a, vec2 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint in0;
layout(location = 1) flat in uint in1;
layout(binding = 0, std140) uniform Reference
{
	vec2 out0;
} ref;
vec2 out0;


void main()
{
    
    out0 = vec2(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uint in0;
	uint in1;
};

layout(binding = 0, std140) uniform Reference
{
	vec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec2 a, vec2 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec2(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint in0;
layout(location = 2) in uint in1;
layout(location = 0) flat out ivec2 out0;


void main()
{
    
    out0 = ivec2(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec2 a, ivec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint in0;
layout(location = 1) flat in uint in1;
layout(binding = 0, std140) uniform Reference
{
	ivec2 out0;
} ref;
ivec2 out0;


void main()
{
    
    out0 = ivec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uint in0;
	uint in1;
};

layout(binding = 0, std140) uniform Reference
{
	ivec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec2 a, ivec2 b) { return (a == b); }
ivec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint in0;
layout(location = 2) in uint in1;
layout(location = 0) flat out uvec2 v_out0;
bvec2 out0;


void main()
{
    
    out0 = bvec2(in0, in1);
    gl_Position = dEQP_Position;
v_out0 = uvec2(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec2 a, bvec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint in0;
layout(location = 1) flat in uint in1;
layout(binding = 0, std140) uniform Reference
{
	bvec2 out0;
} ref;
bvec2 out0;


void main()
{
    
    out0 = bvec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uint in0;
	uint in1;
};

layout(binding = 0, std140) uniform Reference
{
	bvec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec2 a, bvec2 b) { return (a == b); }
bvec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 2) in uint a_in1;
layout(location = 0) flat out vec2 out0;


void main()
{
    bool in0 = bool(a_in0);
bool in1 = bool(a_in1);

    out0 = vec2(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 0) flat out uint v_in0;
layout(location = 2) in uint a_in1;
layout(location = 1) flat out uint v_in1;

void main()
{
    gl_Position = dEQP_Position;
    v_in0 = a_in0;
    v_in1 = a_in1;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec2 a, vec2 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(location = 1) flat in uint v_in1;
layout(binding = 0, std140) uniform Reference
{
	vec2 out0;
} ref;
vec2 out0;


void main()
{
    bool in0 = bool(v_in0);
bool in1 = bool(v_in1);

    out0 = vec2(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bool in0;
	bool in1;
};

layout(binding = 0, std140) uniform Reference
{
	vec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec2 a, vec2 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec2(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 2) in uint a_in1;
layout(location = 0) flat out ivec2 out0;


void main()
{
    bool in0 = bool(a_in0);
bool in1 = bool(a_in1);

    out0 = ivec2(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec2 a, ivec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(location = 1) flat in uint v_in1;
layout(binding = 0, std140) uniform Reference
{
	ivec2 out0;
} ref;
ivec2 out0;


void main()
{
    bool in0 = bool(v_in0);
bool in1 = bool(v_in1);

    out0 = ivec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bool in0;
	bool in1;
};

layout(binding = 0, std140) uniform Reference
{
	ivec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec2 a, ivec2 b) { return (a == b); }
ivec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 2) in uint a_in1;
layout(location = 0) flat out uvec2 v_out0;
bvec2 out0;


void main()
{
    bool in0 = bool(a_in0);
bool in1 = bool(a_in1);

    out0 = bvec2(in0, in1);
    gl_Position = dEQP_Position;
v_out0 = uvec2(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec2 a, bvec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(location = 1) flat in uint v_in1;
layout(binding = 0, std140) uniform Reference
{
	bvec2 out0;
} ref;
bvec2 out0;


void main()
{
    bool in0 = bool(v_in0);
bool in1 = bool(v_in1);

    out0 = bvec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bool in0;
	bool in1;
};

layout(binding = 0, std140) uniform Reference
{
	bvec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec2 a, bvec2 b) { return (a == b); }
bvec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 2) in int in1;
layout(location = 0) flat out vec2 out0;


void main()
{
    
    out0 = vec2(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float a_in0;
layout(location = 0) flat out float in0;
layout(location = 2) in int a_in1;
layout(location = 1) flat out int in1;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
    in1 = a_in1;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec2 a, vec2 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(location = 1) flat in int in1;
layout(binding = 0, std140) uniform Reference
{
	vec2 out0;
} ref;
vec2 out0;


void main()
{
    
    out0 = vec2(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	float in0;
	int in1;
};

layout(binding = 0, std140) uniform Reference
{
	vec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec2 a, vec2 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec2(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 2) in int in1;
layout(location = 0) flat out ivec2 out0;


void main()
{
    
    out0 = ivec2(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec2 a, ivec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(location = 1) flat in int in1;
layout(binding = 0, std140) uniform Reference
{
	ivec2 out0;
} ref;
ivec2 out0;


void main()
{
    
    out0 = ivec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	float in0;
	int in1;
};

layout(binding = 0, std140) uniform Reference
{
	ivec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec2 a, ivec2 b) { return (a == b); }
ivec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 2) in int in1;
layout(location = 0) flat out uvec2 v_out0;
bvec2 out0;


void main()
{
    
    out0 = bvec2(in0, in1);
    gl_Position = dEQP_Position;
v_out0 = uvec2(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec2 a, bvec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(location = 1) flat in int in1;
layout(binding = 0, std140) uniform Reference
{
	bvec2 out0;
} ref;
bvec2 out0;


void main()
{
    
    out0 = bvec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	float in0;
	int in1;
};

layout(binding = 0, std140) uniform Reference
{
	bvec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec2 a, bvec2 b) { return (a == b); }
bvec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 2) in uint a_in1;
layout(location = 0) flat out vec2 out0;


void main()
{
    bool in1 = bool(a_in1);

    out0 = vec2(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float a_in0;
layout(location = 0) flat out float in0;
layout(location = 2) in uint a_in1;
layout(location = 1) flat out uint v_in1;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
    v_in1 = a_in1;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec2 a, vec2 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(location = 1) flat in uint v_in1;
layout(binding = 0, std140) uniform Reference
{
	vec2 out0;
} ref;
vec2 out0;


void main()
{
    bool in1 = bool(v_in1);

    out0 = vec2(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	float in0;
	bool in1;
};

layout(binding = 0, std140) uniform Reference
{
	vec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec2 a, vec2 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec2(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 2) in uint a_in1;
layout(location = 0) flat out ivec2 out0;


void main()
{
    bool in1 = bool(a_in1);

    out0 = ivec2(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec2 a, ivec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(location = 1) flat in uint v_in1;
layout(binding = 0, std140) uniform Reference
{
	ivec2 out0;
} ref;
ivec2 out0;


void main()
{
    bool in1 = bool(v_in1);

    out0 = ivec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	float in0;
	bool in1;
};

layout(binding = 0, std140) uniform Reference
{
	ivec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec2 a, ivec2 b) { return (a == b); }
ivec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 2) in uint a_in1;
layout(location = 0) flat out uvec2 v_out0;
bvec2 out0;


void main()
{
    bool in1 = bool(a_in1);

    out0 = bvec2(in0, in1);
    gl_Position = dEQP_Position;
v_out0 = uvec2(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec2 a, bvec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(location = 1) flat in uint v_in1;
layout(binding = 0, std140) uniform Reference
{
	bvec2 out0;
} ref;
bvec2 out0;


void main()
{
    bool in1 = bool(v_in1);

    out0 = bvec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	float in0;
	bool in1;
};

layout(binding = 0, std140) uniform Reference
{
	bvec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec2 a, bvec2 b) { return (a == b); }
bvec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 2) in uint a_in1;
layout(location = 0) flat out vec2 out0;


void main()
{
    bool in1 = bool(a_in1);

    out0 = vec2(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int a_in0;
layout(location = 0) flat out int in0;
layout(location = 2) in uint a_in1;
layout(location = 1) flat out uint v_in1;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
    v_in1 = a_in1;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec2 a, vec2 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in int in0;
layout(location = 1) flat in uint v_in1;
layout(binding = 0, std140) uniform Reference
{
	vec2 out0;
} ref;
vec2 out0;


void main()
{
    bool in1 = bool(v_in1);

    out0 = vec2(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	int in0;
	bool in1;
};

layout(binding = 0, std140) uniform Reference
{
	vec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec2 a, vec2 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec2(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 2) in uint a_in1;
layout(location = 0) flat out ivec2 out0;


void main()
{
    bool in1 = bool(a_in1);

    out0 = ivec2(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec2 a, ivec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in int in0;
layout(location = 1) flat in uint v_in1;
layout(binding = 0, std140) uniform Reference
{
	ivec2 out0;
} ref;
ivec2 out0;


void main()
{
    bool in1 = bool(v_in1);

    out0 = ivec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	int in0;
	bool in1;
};

layout(binding = 0, std140) uniform Reference
{
	ivec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec2 a, ivec2 b) { return (a == b); }
ivec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 2) in uint a_in1;
layout(location = 0) flat out uvec2 v_out0;
bvec2 out0;


void main()
{
    bool in1 = bool(a_in1);

    out0 = bvec2(in0, in1);
    gl_Position = dEQP_Position;
v_out0 = uvec2(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec2 a, bvec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in int in0;
layout(location = 1) flat in uint v_in1;
layout(binding = 0, std140) uniform Reference
{
	bvec2 out0;
} ref;
bvec2 out0;


void main()
{
    bool in1 = bool(v_in1);

    out0 = bvec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	int in0;
	bool in1;
};

layout(binding = 0, std140) uniform Reference
{
	bvec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec2 a, bvec2 b) { return (a == b); }
bvec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 2) in uint in1;
layout(location = 0) flat out vec2 out0;


void main()
{
    
    out0 = vec2(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int a_in0;
layout(location = 0) flat out int in0;
layout(location = 2) in uint a_in1;
layout(location = 1) flat out uint in1;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
    in1 = a_in1;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec2 a, vec2 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in int in0;
layout(location = 1) flat in uint in1;
layout(binding = 0, std140) uniform Reference
{
	vec2 out0;
} ref;
vec2 out0;


void main()
{
    
    out0 = vec2(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	int in0;
	uint in1;
};

layout(binding = 0, std140) uniform Reference
{
	vec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec2 a, vec2 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec2(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 2) in uint in1;
layout(location = 0) flat out ivec2 out0;


void main()
{
    
    out0 = ivec2(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec2 a, ivec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in int in0;
layout(location = 1) flat in uint in1;
layout(binding = 0, std140) uniform Reference
{
	ivec2 out0;
} ref;
ivec2 out0;


void main()
{
    
    out0 = ivec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	int in0;
	uint in1;
};

layout(binding = 0, std140) uniform Reference
{
	ivec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec2 a, ivec2 b) { return (a == b); }
ivec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 2) in uint in1;
layout(location = 0) flat out uvec2 v_out0;
bvec2 out0;


void main()
{
    
    out0 = bvec2(in0, in1);
    gl_Position = dEQP_Position;
v_out0 = uvec2(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec2 a, bvec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in int in0;
layout(location = 1) flat in uint in1;
layout(binding = 0, std140) uniform Reference
{
	bvec2 out0;
} ref;
bvec2 out0;


void main()
{
    
    out0 = bvec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	int in0;
	uint in1;
};

layout(binding = 0, std140) uniform Reference
{
	bvec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec2 a, bvec2 b) { return (a == b); }
bvec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint in0;
layout(location = 2) in float in1;
layout(location = 0) flat out vec2 out0;


void main()
{
    
    out0 = vec2(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 0) flat out uint in0;
layout(location = 2) in float a_in1;
layout(location = 1) flat out float in1;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
    in1 = a_in1;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec2 a, vec2 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint in0;
layout(location = 1) flat in float in1;
layout(binding = 0, std140) uniform Reference
{
	vec2 out0;
} ref;
vec2 out0;


void main()
{
    
    out0 = vec2(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uint in0;
	float in1;
};

layout(binding = 0, std140) uniform Reference
{
	vec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec2 a, vec2 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = vec2(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint in0;
layout(location = 2) in float in1;
layout(location = 0) flat out ivec2 out0;


void main()
{
    
    out0 = ivec2(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec2 a, ivec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint in0;
layout(location = 1) flat in float in1;
layout(binding = 0, std140) uniform Reference
{
	ivec2 out0;
} ref;
ivec2 out0;


void main()
{
    
    out0 = ivec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uint in0;
	float in1;
};

layout(binding = 0, std140) uniform Reference
{
	ivec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec2 a, ivec2 b) { return (a == b); }
ivec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = ivec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint in0;
layout(location = 2) in float in1;
layout(location = 0) flat out uvec2 v_out0;
bvec2 out0;


void main()
{
    
    out0 = bvec2(in0, in1);
    gl_Position = dEQP_Position;
v_out0 = uvec2(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec2 a, bvec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint in0;
layout(location = 1) flat in float in1;
layout(binding = 0, std140) uniform Reference
{
	bvec2 out0;
} ref;
bvec2 out0;


void main()
{
    
    out0 = bvec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uint in0;
	float in1;
};

layout(binding = 0, std140) uniform Reference
{
	bvec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (bvec2 a, bvec2 b) { return (a == b); }
bvec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = bvec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 2) in float in1;
layout(location = 0) flat out uvec2 out0;


void main()
{
    
    out0 = uvec2(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec2 a, uvec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(location = 1) flat in float in1;
layout(binding = 0, std140) uniform Reference
{
	uvec2 out0;
} ref;
uvec2 out0;


void main()
{
    
    out0 = uvec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	float in0;
	float in1;
};

layout(binding = 0, std140) uniform Reference
{
	uvec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec2 a, uvec2 b) { return (a == b); }
uvec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 2) in int in1;
layout(location = 0) flat out uvec2 out0;


void main()
{
    
    out0 = uvec2(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec2 a, uvec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in int in0;
layout(location = 1) flat in int in1;
layout(binding = 0, std140) uniform Reference
{
	uvec2 out0;
} ref;
uvec2 out0;


void main()
{
    
    out0 = uvec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	int in0;
	int in1;
};

layout(binding = 0, std140) uniform Reference
{
	uvec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec2 a, uvec2 b) { return (a == b); }
uvec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint in0;
layout(location = 2) in uint in1;
layout(location = 0) flat out uvec2 out0;


void main()
{
    
    out0 = uvec2(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec2 a, uvec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint in0;
layout(location = 1) flat in uint in1;
layout(binding = 0, std140) uniform Reference
{
	uvec2 out0;
} ref;
uvec2 out0;


void main()
{
    
    out0 = uvec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uint in0;
	uint in1;
};

layout(binding = 0, std140) uniform Reference
{
	uvec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec2 a, uvec2 b) { return (a == b); }
uvec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 2) in uint a_in1;
layout(location = 0) flat out uvec2 out0;


void main()
{
    bool in0 = bool(a_in0);
bool in1 = bool(a_in1);

    out0 = uvec2(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec2 a, uvec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(location = 1) flat in uint v_in1;
layout(binding = 0, std140) uniform Reference
{
	uvec2 out0;
} ref;
uvec2 out0;


void main()
{
    bool in0 = bool(v_in0);
bool in1 = bool(v_in1);

    out0 = uvec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	bool in0;
	bool in1;
};

layout(binding = 0, std140) uniform Reference
{
	uvec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec2 a, uvec2 b) { return (a == b); }
uvec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 2) in int in1;
layout(location = 0) flat out uvec2 out0;


void main()
{
    
    out0 = uvec2(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec2 a, uvec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(location = 1) flat in int in1;
layout(binding = 0, std140) uniform Reference
{
	uvec2 out0;
} ref;
uvec2 out0;


void main()
{
    
    out0 = uvec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	float in0;
	int in1;
};

layout(binding = 0, std140) uniform Reference
{
	uvec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec2 a, uvec2 b) { return (a == b); }
uvec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 2) in uint a_in1;
layout(location = 0) flat out uvec2 out0;


void main()
{
    bool in1 = bool(a_in1);

    out0 = uvec2(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec2 a, uvec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(location = 1) flat in uint v_in1;
layout(binding = 0, std140) uniform Reference
{
	uvec2 out0;
} ref;
uvec2 out0;


void main()
{
    bool in1 = bool(v_in1);

    out0 = uvec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	float in0;
	bool in1;
};

layout(binding = 0, std140) uniform Reference
{
	uvec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec2 a, uvec2 b) { return (a == b); }
uvec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 2) in uint a_in1;
layout(location = 0) flat out uvec2 out0;


void main()
{
    bool in1 = bool(a_in1);

    out0 = uvec2(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec2 a, uvec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in int in0;
layout(location = 1) flat in uint v_in1;
layout(binding = 0, std140) uniform Reference
{
	uvec2 out0;
} ref;
uvec2 out0;


void main()
{
    bool in1 = bool(v_in1);

    out0 = uvec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	int in0;
	bool in1;
};

layout(binding = 0, std140) uniform Reference
{
	uvec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec2 a, uvec2 b) { return (a == b); }
uvec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 2) in uint in1;
layout(location = 0) flat out uvec2 out0;


void main()
{
    
    out0 = uvec2(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec2 a, uvec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in int in0;
layout(location = 1) flat in uint in1;
layout(binding = 0, std140) uniform Reference
{
	uvec2 out0;
} ref;
uvec2 out0;


void main()
{
    
    out0 = uvec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	int in0;
	uint in1;
};

layout(binding = 0, std140) uniform Reference
{
	uvec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec2 a, uvec2 b) { return (a == b); }
uvec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint in0;
layout(location = 2) in float in1;
layout(location = 0) flat out uvec2 out0;


void main()
{
    
    out0 = uvec2(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec2 a, uvec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint in0;
layout(location = 1) flat in float in1;
layout(binding = 0, std140) uniform Reference
{
	uvec2 out0;
} ref;
uvec2 out0;


void main()
{
    
    out0 = uvec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	uint in0;
	float in1;
};

layout(binding = 0, std140) uniform Reference
{
	uvec2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (uvec2 a, uvec2 b) { return (a == b); }
uvec2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = uvec2(in0, in1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
