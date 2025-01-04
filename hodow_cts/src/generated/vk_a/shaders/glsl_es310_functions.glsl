#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 0) flat out float out0;


float func (float a)
{
    return -a;
}

void main()
{
    out0 = func(in0);
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


float func (float a)
{
    return -a;
}

void main()
{
    out0 = func(in0);
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


float func (float a)
{
    return -a;
}

void main()
{
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 in0;
layout(location = 0) flat out float out0;


float func (vec2 a)
{
    return -(a.x + a.y);
}

void main()
{
    out0 = func(in0);
    gl_Position = dEQP_Position;

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
bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec2 in0;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;


float func (vec2 a)
{
    return -(a.x + a.y);
}

void main()
{
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
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


float func (vec2 a)
{
    return -(a.x + a.y);
}

void main()
{
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 0) flat out float out0;


float func (vec3 a)
{
    return -(a.x + a.y + a.z);
}

void main()
{
    out0 = func(in0);
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
bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec3 in0;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;


float func (vec3 a)
{
    return -(a.x + a.y + a.z);
}

void main()
{
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
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


float func (vec3 a)
{
    return -(a.x + a.y + a.z);
}

void main()
{
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec4 in0;
layout(location = 0) flat out float out0;


float func (vec4 a)
{
    return -(a.x + a.y + a.z + a.w);
}

void main()
{
    out0 = func(in0);
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
bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec4 in0;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;


float func (vec4 a)
{
    return -(a.x + a.y + a.z + a.w);
}

void main()
{
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
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


float func (vec4 a)
{
    return -(a.x + a.y + a.z + a.w);
}

void main()
{
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat2 in0;
layout(location = 0) flat out float out0;


float func (mat2 a)
{
    return -(a[0][0] + a[0][1] + a[1][0] + a[1][1]);
}

void main()
{
    out0 = func(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat2 a_in0;
layout(location = 0) flat out mat2 in0;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
}
#version 310 es
precision highp float;
bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat2 in0;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;


float func (mat2 a)
{
    return -(a[0][0] + a[0][1] + a[1][0] + a[1][1]);
}

void main()
{
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat2 in0;
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


float func (mat2 a)
{
    return -(a[0][0] + a[0][1] + a[1][0] + a[1][1]);
}

void main()
{
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat3 in0;
layout(location = 0) flat out float out0;


float func (mat3 a)
{
    return -(a[0][0] + a[0][1] + a[0][2] + a[1][0] + a[1][1] + a[1][2] + a[2][0] + a[2][1] + a[2][2]);
}

void main()
{
    out0 = func(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat3 a_in0;
layout(location = 0) flat out mat3 in0;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
}
#version 310 es
precision highp float;
bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat3 in0;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;


float func (mat3 a)
{
    return -(a[0][0] + a[0][1] + a[0][2] + a[1][0] + a[1][1] + a[1][2] + a[2][0] + a[2][1] + a[2][2]);
}

void main()
{
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat3 in0;
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


float func (mat3 a)
{
    return -(a[0][0] + a[0][1] + a[0][2] + a[1][0] + a[1][1] + a[1][2] + a[2][0] + a[2][1] + a[2][2]);
}

void main()
{
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat4 in0;
layout(location = 0) flat out float out0;


float func (mat4 a)
{
    return -(a[0][0] + a[0][1] + a[0][2] + a[0][3] + a[1][0] + a[1][1] + a[1][2] + a[1][3] + a[2][0] + a[2][1] + a[2][2] + a[2][3] + a[3][0] + a[3][1] + a[3][2] + a[3][3]);
}

void main()
{
    out0 = func(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat4 a_in0;
layout(location = 0) flat out mat4 in0;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
}
#version 310 es
precision highp float;
bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat4 in0;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;


float func (mat4 a)
{
    return -(a[0][0] + a[0][1] + a[0][2] + a[0][3] + a[1][0] + a[1][1] + a[1][2] + a[1][3] + a[2][0] + a[2][1] + a[2][2] + a[2][3] + a[3][0] + a[3][1] + a[3][2] + a[3][3]);
}

void main()
{
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat4 in0;
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


float func (mat4 a)
{
    return -(a[0][0] + a[0][1] + a[0][2] + a[0][3] + a[1][0] + a[1][1] + a[1][2] + a[1][3] + a[2][0] + a[2][1] + a[2][2] + a[2][3] + a[3][0] + a[3][1] + a[3][2] + a[3][3]);
}

void main()
{
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 0) flat out int out0;


int func (int a)
{
    return -a;
}

void main()
{
    
    out0 = func(in0);
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

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int a_in0;
layout(location = 0) flat out int in0;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
}
#version 310 es
precision highp float;
precision highp int;
bool isOk (int a, int b)     { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in int in0;
layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
int out0;


int func (int a)
{
    return -a;
}

void main()
{
    
    out0 = func(in0);
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


int func (int a)
{
    return -a;
}

void main()
{
    
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec2 in0;
layout(location = 0) flat out int out0;


int func (ivec2 a)
{
    return -(a.x + a.y);
}

void main()
{
    
    out0 = func(in0);
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
bool isOk (int a, int b)     { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec2 in0;
layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
int out0;


int func (ivec2 a)
{
    return -(a.x + a.y);
}

void main()
{
    
    out0 = func(in0);
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


int func (ivec2 a)
{
    return -(a.x + a.y);
}

void main()
{
    
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec3 in0;
layout(location = 0) flat out int out0;


int func (ivec3 a)
{
    return -(a.x + a.y + a.z);
}

void main()
{
    
    out0 = func(in0);
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
bool isOk (int a, int b)     { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec3 in0;
layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
int out0;


int func (ivec3 a)
{
    return -(a.x + a.y + a.z);
}

void main()
{
    
    out0 = func(in0);
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


int func (ivec3 a)
{
    return -(a.x + a.y + a.z);
}

void main()
{
    
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec4 in0;
layout(location = 0) flat out int out0;


int func (ivec4 a)
{
    return -(a.x + a.y + a.z + a.w);
}

void main()
{
    
    out0 = func(in0);
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
bool isOk (int a, int b)     { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec4 in0;
layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
int out0;


int func (ivec4 a)
{
    return -(a.x + a.y + a.z + a.w);
}

void main()
{
    
    out0 = func(in0);
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


int func (ivec4 a)
{
    return -(a.x + a.y + a.z + a.w);
}

void main()
{
    
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint in0;
layout(location = 0) flat out uint out0;


uint func (uint a)
{
    return a*a;
}

void main()
{
    
    out0 = func(in0);
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

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 0) flat out uint in0;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
}
#version 310 es
precision highp float;
precision highp int;
bool isOk (uint a, uint b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint in0;
layout(binding = 0, std140) uniform Reference
{
	uint out0;
} ref;
uint out0;


uint func (uint a)
{
    return a*a;
}

void main()
{
    
    out0 = func(in0);
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


uint func (uint a)
{
    return a*a;
}

void main()
{
    
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec2 in0;
layout(location = 0) flat out uint out0;


uint func (uvec2 a)
{
    return (a.x + a.y);
}

void main()
{
    
    out0 = func(in0);
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
bool isOk (uint a, uint b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec2 in0;
layout(binding = 0, std140) uniform Reference
{
	uint out0;
} ref;
uint out0;


uint func (uvec2 a)
{
    return (a.x + a.y);
}

void main()
{
    
    out0 = func(in0);
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


uint func (uvec2 a)
{
    return (a.x + a.y);
}

void main()
{
    
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 in0;
layout(location = 0) flat out uint out0;


uint func (uvec3 a)
{
    return (a.x + a.y + a.z);
}

void main()
{
    
    out0 = func(in0);
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
bool isOk (uint a, uint b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec3 in0;
layout(binding = 0, std140) uniform Reference
{
	uint out0;
} ref;
uint out0;


uint func (uvec3 a)
{
    return (a.x + a.y + a.z);
}

void main()
{
    
    out0 = func(in0);
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


uint func (uvec3 a)
{
    return (a.x + a.y + a.z);
}

void main()
{
    
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec4 in0;
layout(location = 0) flat out uint out0;


uint func (uvec4 a)
{
    return (a.x + a.y + a.z + a.w);
}

void main()
{
    
    out0 = func(in0);
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
bool isOk (uint a, uint b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec4 in0;
layout(binding = 0, std140) uniform Reference
{
	uint out0;
} ref;
uint out0;


uint func (uvec4 a)
{
    return (a.x + a.y + a.z + a.w);
}

void main()
{
    
    out0 = func(in0);
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


uint func (uvec4 a)
{
    return (a.x + a.y + a.z + a.w);
}

void main()
{
    
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 0) flat out uint v_out0;
bool out0;


bool func (bool a)
{
    return !a;
}

void main()
{
    bool in0 = bool(a_in0);

    out0 = func(in0);
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

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 0) flat out uint v_in0;

void main()
{
    gl_Position = dEQP_Position;
    v_in0 = a_in0;
}
#version 310 es
precision highp float;
precision highp int;
bool isOk (bool a, bool b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(binding = 0, std140) uniform Reference
{
	bool out0;
} ref;
bool out0;


bool func (bool a)
{
    return !a;
}

void main()
{
    bool in0 = bool(v_in0);

    out0 = func(in0);
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


bool func (bool a)
{
    return !a;
}

void main()
{
    
    out0 = func(in0);
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


bool func (bvec2 a)
{
    return !(a.x == a.y);
}

void main()
{
    bvec2 in0 = bvec2(a_in0);

    out0 = func(in0);
    gl_Position = dEQP_Position;
v_out0 = uint(out0);

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
bool isOk (bool a, bool b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec2 v_in0;
layout(binding = 0, std140) uniform Reference
{
	bool out0;
} ref;
bool out0;


bool func (bvec2 a)
{
    return !(a.x == a.y);
}

void main()
{
    bvec2 in0 = bvec2(v_in0);

    out0 = func(in0);
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


bool func (bvec2 a)
{
    return !(a.x == a.y);
}

void main()
{
    
    out0 = func(in0);
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


bool func (bvec3 a)
{
    return (a.x == a.y) == a.z;
}

void main()
{
    bvec3 in0 = bvec3(a_in0);

    out0 = func(in0);
    gl_Position = dEQP_Position;
v_out0 = uint(out0);

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
bool isOk (bool a, bool b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec3 v_in0;
layout(binding = 0, std140) uniform Reference
{
	bool out0;
} ref;
bool out0;


bool func (bvec3 a)
{
    return (a.x == a.y) == a.z;
}

void main()
{
    bvec3 in0 = bvec3(v_in0);

    out0 = func(in0);
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


bool func (bvec3 a)
{
    return (a.x == a.y) == a.z;
}

void main()
{
    
    out0 = func(in0);
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


bool func (bvec4 a)
{
    return ((a.x == a.y) == (a.z == a.w));
}

void main()
{
    bvec4 in0 = bvec4(a_in0);

    out0 = func(in0);
    gl_Position = dEQP_Position;
v_out0 = uint(out0);

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
bool isOk (bool a, bool b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec4 v_in0;
layout(binding = 0, std140) uniform Reference
{
	bool out0;
} ref;
bool out0;


bool func (bvec4 a)
{
    return ((a.x == a.y) == (a.z == a.w));
}

void main()
{
    bvec4 in0 = bvec4(v_in0);

    out0 = func(in0);
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


bool func (bvec4 a)
{
    return ((a.x == a.y) == (a.z == a.w));
}

void main()
{
    
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat2 in0;
layout(location = 0) flat out mat2 out0;


mat2 func (mat2 a)
{
    return -2.0*a;
}

void main()
{
    
    out0 = func(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) out mediump vec4 dEQP_FragColor;

bool isOk (mat2 a, mat2 b, float eps) { vec2 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec2(eps))); }

layout(location = 0) flat in mat2 out0;
layout(binding = 0, std140) uniform Reference
{
	mat2 out0;
} ref;

void main()
{
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);
}
#version 310 es
precision highp float;
bool isOk (mat2 a, mat2 b, float eps) { vec2 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat2 in0;
layout(binding = 0, std140) uniform Reference
{
	mat2 out0;
} ref;
mat2 out0;


mat2 func (mat2 a)
{
    return -2.0*a;
}

void main()
{
    
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat2 in0;
};

layout(binding = 0, std140) uniform Reference
{
	mat2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (mat2 a, mat2 b, float eps) { vec2 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec2(eps))); }
mat2 out0;
highp vec4 dEQP_Position;


mat2 func (mat2 a)
{
    return -2.0*a;
}

void main()
{
    
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat2x3 in0;
layout(location = 0) flat out mat2x3 out0;


mat2x3 func (mat2x3 a)
{
    return -2.0*a;
}

void main()
{
    
    out0 = func(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) out mediump vec4 dEQP_FragColor;

bool isOk (mat2x3 a, mat2x3 b, float eps) { vec3 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec3(eps))); }

layout(location = 0) flat in mat2x3 out0;
layout(binding = 0, std140) uniform Reference
{
	mat2x3 out0;
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
layout(location = 1) in mat2x3 a_in0;
layout(location = 0) flat out mat2x3 in0;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
}
#version 310 es
precision highp float;
bool isOk (mat2x3 a, mat2x3 b, float eps) { vec3 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat2x3 in0;
layout(binding = 0, std140) uniform Reference
{
	mat2x3 out0;
} ref;
mat2x3 out0;


mat2x3 func (mat2x3 a)
{
    return -2.0*a;
}

void main()
{
    
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat2x3 in0;
};

layout(binding = 0, std140) uniform Reference
{
	mat2x3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (mat2x3 a, mat2x3 b, float eps) { vec3 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec3(eps))); }
mat2x3 out0;
highp vec4 dEQP_Position;


mat2x3 func (mat2x3 a)
{
    return -2.0*a;
}

void main()
{
    
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat2x4 in0;
layout(location = 0) flat out mat2x4 out0;


mat2x4 func (mat2x4 a)
{
    return -2.0*a;
}

void main()
{
    
    out0 = func(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) out mediump vec4 dEQP_FragColor;

bool isOk (mat2x4 a, mat2x4 b, float eps) { vec4 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec4(eps))); }

layout(location = 0) flat in mat2x4 out0;
layout(binding = 0, std140) uniform Reference
{
	mat2x4 out0;
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
layout(location = 1) in mat2x4 a_in0;
layout(location = 0) flat out mat2x4 in0;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
}
#version 310 es
precision highp float;
bool isOk (mat2x4 a, mat2x4 b, float eps) { vec4 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat2x4 in0;
layout(binding = 0, std140) uniform Reference
{
	mat2x4 out0;
} ref;
mat2x4 out0;


mat2x4 func (mat2x4 a)
{
    return -2.0*a;
}

void main()
{
    
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat2x4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	mat2x4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (mat2x4 a, mat2x4 b, float eps) { vec4 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec4(eps))); }
mat2x4 out0;
highp vec4 dEQP_Position;


mat2x4 func (mat2x4 a)
{
    return -2.0*a;
}

void main()
{
    
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat3x2 in0;
layout(location = 0) flat out mat3x2 out0;


mat3x2 func (mat3x2 a)
{
    return -2.0*a;
}

void main()
{
    
    out0 = func(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) out mediump vec4 dEQP_FragColor;

bool isOk (mat3x2 a, mat3x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec2(eps))); }

layout(location = 0) flat in mat3x2 out0;
layout(binding = 0, std140) uniform Reference
{
	mat3x2 out0;
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
layout(location = 1) in mat3x2 a_in0;
layout(location = 0) flat out mat3x2 in0;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
}
#version 310 es
precision highp float;
bool isOk (mat3x2 a, mat3x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat3x2 in0;
layout(binding = 0, std140) uniform Reference
{
	mat3x2 out0;
} ref;
mat3x2 out0;


mat3x2 func (mat3x2 a)
{
    return -2.0*a;
}

void main()
{
    
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat3x2 in0;
};

layout(binding = 0, std140) uniform Reference
{
	mat3x2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (mat3x2 a, mat3x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec2(eps))); }
mat3x2 out0;
highp vec4 dEQP_Position;


mat3x2 func (mat3x2 a)
{
    return -2.0*a;
}

void main()
{
    
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat3 in0;
layout(location = 0) flat out mat3 out0;


mat3 func (mat3 a)
{
    return -2.0*a;
}

void main()
{
    
    out0 = func(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) out mediump vec4 dEQP_FragColor;

bool isOk (mat3 a, mat3 b, float eps) { vec3 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec3(eps))); }

layout(location = 0) flat in mat3 out0;
layout(binding = 0, std140) uniform Reference
{
	mat3 out0;
} ref;

void main()
{
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);
}
#version 310 es
precision highp float;
bool isOk (mat3 a, mat3 b, float eps) { vec3 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat3 in0;
layout(binding = 0, std140) uniform Reference
{
	mat3 out0;
} ref;
mat3 out0;


mat3 func (mat3 a)
{
    return -2.0*a;
}

void main()
{
    
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat3 in0;
};

layout(binding = 0, std140) uniform Reference
{
	mat3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (mat3 a, mat3 b, float eps) { vec3 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec3(eps))); }
mat3 out0;
highp vec4 dEQP_Position;


mat3 func (mat3 a)
{
    return -2.0*a;
}

void main()
{
    
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat3x4 in0;
layout(location = 0) flat out mat3x4 out0;


mat3x4 func (mat3x4 a)
{
    return -2.0*a;
}

void main()
{
    
    out0 = func(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) out mediump vec4 dEQP_FragColor;

bool isOk (mat3x4 a, mat3x4 b, float eps) { vec4 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec4(eps))); }

layout(location = 0) flat in mat3x4 out0;
layout(binding = 0, std140) uniform Reference
{
	mat3x4 out0;
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
layout(location = 1) in mat3x4 a_in0;
layout(location = 0) flat out mat3x4 in0;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
}
#version 310 es
precision highp float;
bool isOk (mat3x4 a, mat3x4 b, float eps) { vec4 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat3x4 in0;
layout(binding = 0, std140) uniform Reference
{
	mat3x4 out0;
} ref;
mat3x4 out0;


mat3x4 func (mat3x4 a)
{
    return -2.0*a;
}

void main()
{
    
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat3x4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	mat3x4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (mat3x4 a, mat3x4 b, float eps) { vec4 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec4(eps))); }
mat3x4 out0;
highp vec4 dEQP_Position;


mat3x4 func (mat3x4 a)
{
    return -2.0*a;
}

void main()
{
    
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat4x2 in0;
layout(location = 0) flat out mat4x2 out0;


mat4x2 func (mat4x2 a)
{
    return -2.0*a;
}

void main()
{
    
    out0 = func(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) out mediump vec4 dEQP_FragColor;

bool isOk (mat4x2 a, mat4x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec2(eps))); }

layout(location = 0) flat in mat4x2 out0;
layout(binding = 0, std140) uniform Reference
{
	mat4x2 out0;
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
layout(location = 1) in mat4x2 a_in0;
layout(location = 0) flat out mat4x2 in0;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
}
#version 310 es
precision highp float;
bool isOk (mat4x2 a, mat4x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat4x2 in0;
layout(binding = 0, std140) uniform Reference
{
	mat4x2 out0;
} ref;
mat4x2 out0;


mat4x2 func (mat4x2 a)
{
    return -2.0*a;
}

void main()
{
    
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat4x2 in0;
};

layout(binding = 0, std140) uniform Reference
{
	mat4x2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (mat4x2 a, mat4x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec2(eps))); }
mat4x2 out0;
highp vec4 dEQP_Position;


mat4x2 func (mat4x2 a)
{
    return -2.0*a;
}

void main()
{
    
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat4x3 in0;
layout(location = 0) flat out mat4x3 out0;


mat4x3 func (mat4x3 a)
{
    return -2.0*a;
}

void main()
{
    
    out0 = func(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) out mediump vec4 dEQP_FragColor;

bool isOk (mat4x3 a, mat4x3 b, float eps) { vec3 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec3(eps))); }

layout(location = 0) flat in mat4x3 out0;
layout(binding = 0, std140) uniform Reference
{
	mat4x3 out0;
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
layout(location = 1) in mat4x3 a_in0;
layout(location = 0) flat out mat4x3 in0;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
}
#version 310 es
precision highp float;
bool isOk (mat4x3 a, mat4x3 b, float eps) { vec3 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat4x3 in0;
layout(binding = 0, std140) uniform Reference
{
	mat4x3 out0;
} ref;
mat4x3 out0;


mat4x3 func (mat4x3 a)
{
    return -2.0*a;
}

void main()
{
    
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat4x3 in0;
};

layout(binding = 0, std140) uniform Reference
{
	mat4x3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (mat4x3 a, mat4x3 b, float eps) { vec3 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec3(eps))); }
mat4x3 out0;
highp vec4 dEQP_Position;


mat4x3 func (mat4x3 a)
{
    return -2.0*a;
}

void main()
{
    
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat4 in0;
layout(location = 0) flat out mat4 out0;


mat4 func (mat4 a)
{
    return -2.0*a;
}

void main()
{
    
    out0 = func(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) out mediump vec4 dEQP_FragColor;

bool isOk (mat4 a, mat4 b, float eps) { vec4 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec4(eps))); }

layout(location = 0) flat in mat4 out0;
layout(binding = 0, std140) uniform Reference
{
	mat4 out0;
} ref;

void main()
{
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);
}
#version 310 es
precision highp float;
bool isOk (mat4 a, mat4 b, float eps) { vec4 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat4 in0;
layout(binding = 0, std140) uniform Reference
{
	mat4 out0;
} ref;
mat4 out0;


mat4 func (mat4 a)
{
    return -2.0*a;
}

void main()
{
    
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat4 in0;
};

layout(binding = 0, std140) uniform Reference
{
	mat4 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (mat4 a, mat4 b, float eps) { vec4 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec4(eps))); }
mat4 out0;
highp vec4 dEQP_Position;


mat4 func (mat4 a)
{
    return -2.0*a;
}

void main()
{
    
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 0) flat out float out0;


struct Pos { float a, b, c; };

float func (Pos p)
{
    return -(p.a + p.b + p.c);
}

void main()
{
    Pos p = Pos(in0.x, in0.y, in0.z);
    out0 = func(p);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec3 in0;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;


struct Pos { float a, b, c; };

float func (Pos p)
{
    return -(p.a + p.b + p.c);
}

void main()
{
    Pos p = Pos(in0.x, in0.y, in0.z);
    out0 = func(p);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
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


struct Pos { float a, b, c; };

float func (Pos p)
{
    return -(p.a + p.b + p.c);
}

void main()
{
    Pos p = Pos(in0.x, in0.y, in0.z);
    out0 = func(p);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 0) flat out float out0;


struct Pos { float a, b, c; };

Pos func (Pos p)
{
    return Pos(-p.a, -p.b, -p.c);
}

void main()
{
    Pos p = Pos(in0.x, in0.y, in0.z);
    p = func(p);
    out0 = p.a + p.b + p.c;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec3 in0;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;


struct Pos { float a, b, c; };

Pos func (Pos p)
{
    return Pos(-p.a, -p.b, -p.c);
}

void main()
{
    Pos p = Pos(in0.x, in0.y, in0.z);
    p = func(p);
    out0 = p.a + p.b + p.c;
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
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


struct Pos { float a, b, c; };

Pos func (Pos p)
{
    return Pos(-p.a, -p.b, -p.c);
}

void main()
{
    Pos p = Pos(in0.x, in0.y, in0.z);
    p = func(p);
    out0 = p.a + p.b + p.c;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 0) flat out float out0;


struct Pos { float a, b, c; };
struct Line { Pos start, end; };

Line func (Pos p)
{
    return Line(p, Pos(-p.a, -p.b, -p.c));
}

float sum (Pos p)
{
    return (p.a + p.b + p.c);
}

void main()
{
    Pos p = Pos(in0.x, in0.y, in0.z);
    Line line = func(p);
    out0 = sum(line.start) + (2.0 * sum(line.end));
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec3 in0;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;


struct Pos { float a, b, c; };
struct Line { Pos start, end; };

Line func (Pos p)
{
    return Line(p, Pos(-p.a, -p.b, -p.c));
}

float sum (Pos p)
{
    return (p.a + p.b + p.c);
}

void main()
{
    Pos p = Pos(in0.x, in0.y, in0.z);
    Line line = func(p);
    out0 = sum(line.start) + (2.0 * sum(line.end));
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
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


struct Pos { float a, b, c; };
struct Line { Pos start, end; };

Line func (Pos p)
{
    return Line(p, Pos(-p.a, -p.b, -p.c));
}

float sum (Pos p)
{
    return (p.a + p.b + p.c);
}

void main()
{
    Pos p = Pos(in0.x, in0.y, in0.z);
    Line line = func(p);
    out0 = sum(line.start) + (2.0 * sum(line.end));
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 0) flat out float out0;


float func (in float a)
{
    a = -a;
    return 2.0 * a;
}

void main()
{
    
    float f = in0;
    float g = func(f);
    out0 = f + g;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;
bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;


float func (in float a)
{
    a = -a;
    return 2.0 * a;
}

void main()
{
    
    float f = in0;
    float g = func(f);
    out0 = f + g;
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


float func (in float a)
{
    a = -a;
    return 2.0 * a;
}

void main()
{
    
    float f = in0;
    float g = func(f);
    out0 = f + g;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 0) flat out float out0;


void func (out float a)
{
    a = -1.0;
}

void main()
{
    
    float f = 1.0;
    func(f);
    out0 = f * in0;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;
bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;


void func (out float a)
{
    a = -1.0;
}

void main()
{
    
    float f = 1.0;
    func(f);
    out0 = f * in0;
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


void func (out float a)
{
    a = -1.0;
}

void main()
{
    
    float f = 1.0;
    func(f);
    out0 = f * in0;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 0) flat out float out0;


void func (inout float a)
{
    a = -a;
}

void main()
{
    
    float f = 1.0;
    func(f);
    out0 = f * in0;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;
bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;


void func (inout float a)
{
    a = -a;
}

void main()
{
    
    float f = 1.0;
    func(f);
    out0 = f * in0;
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


void func (inout float a)
{
    a = -a;
}

void main()
{
    
    float f = 1.0;
    func(f);
    out0 = f * in0;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 0) flat out float out0;


float func (in lowp float a)
{
    a = -a;
    return 2.0 * a;
}

void main()
{
    
    float f = in0;
    float g = func(f);
    out0 = f + g;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;
bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;


float func (in lowp float a)
{
    a = -a;
    return 2.0 * a;
}

void main()
{
    
    float f = in0;
    float g = func(f);
    out0 = f + g;
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


float func (in lowp float a)
{
    a = -a;
    return 2.0 * a;
}

void main()
{
    
    float f = in0;
    float g = func(f);
    out0 = f + g;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 0) flat out float out0;


void func (out lowp float a)
{
    a = -1.0;
}

void main()
{
    
    float f = 1.0;
    func(f);
    out0 = f * in0;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;
bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;


void func (out lowp float a)
{
    a = -1.0;
}

void main()
{
    
    float f = 1.0;
    func(f);
    out0 = f * in0;
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


void func (out lowp float a)
{
    a = -1.0;
}

void main()
{
    
    float f = 1.0;
    func(f);
    out0 = f * in0;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 0) flat out float out0;


void func (inout lowp float a)
{
    a = -a;
}

void main()
{
    
    float f = 1.0;
    func(f);
    out0 = f * in0;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;
bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;


void func (inout lowp float a)
{
    a = -a;
}

void main()
{
    
    float f = 1.0;
    func(f);
    out0 = f * in0;
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


void func (inout lowp float a)
{
    a = -a;
}

void main()
{
    
    float f = 1.0;
    func(f);
    out0 = f * in0;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 0) flat out float out0;


float func (in highp float a)
{
    a = -a;
    return 2.0 * a;
}

void main()
{
    
    float f = in0;
    float g = func(f);
    out0 = f + g;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;
bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;


float func (in highp float a)
{
    a = -a;
    return 2.0 * a;
}

void main()
{
    
    float f = in0;
    float g = func(f);
    out0 = f + g;
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


float func (in highp float a)
{
    a = -a;
    return 2.0 * a;
}

void main()
{
    
    float f = in0;
    float g = func(f);
    out0 = f + g;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 0) flat out float out0;


void func (out highp float a)
{
    a = -1.0;
}

void main()
{
    
    float f = 1.0;
    func(f);
    out0 = f * in0;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;
bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;


void func (out highp float a)
{
    a = -1.0;
}

void main()
{
    
    float f = 1.0;
    func(f);
    out0 = f * in0;
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


void func (out highp float a)
{
    a = -1.0;
}

void main()
{
    
    float f = 1.0;
    func(f);
    out0 = f * in0;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 0) flat out float out0;


void func (inout highp float a)
{
    a = -a;
}

void main()
{
    
    float f = 1.0;
    func(f);
    out0 = f * in0;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;
bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;


void func (inout highp float a)
{
    a = -a;
}

void main()
{
    
    float f = 1.0;
    func(f);
    out0 = f * in0;
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


void func (inout highp float a)
{
    a = -a;
}

void main()
{
    
    float f = 1.0;
    func(f);
    out0 = f * in0;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 0) flat out float out0;


float func (const float a)
{
    float b = -a;
    return 2.0 * b;
}

void main()
{
    
    float f = in0;
    float g = func(f);
    out0 = f + g;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;
bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;


float func (const float a)
{
    float b = -a;
    return 2.0 * b;
}

void main()
{
    
    float f = in0;
    float g = func(f);
    out0 = f + g;
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


float func (const float a)
{
    float b = -a;
    return 2.0 * b;
}

void main()
{
    
    float f = in0;
    float g = func(f);
    out0 = f + g;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 0) flat out float out0;


float func (const in float a)
{
    float b = -a;
    return 2.0 * b;
}

void main()
{
    
    float f = in0;
    float g = func(f);
    out0 = f + g;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;
bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;


float func (const in float a)
{
    float b = -a;
    return 2.0 * b;
}

void main()
{
    
    float f = in0;
    float g = func(f);
    out0 = f + g;
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


float func (const in float a)
{
    float b = -a;
    return 2.0 * b;
}

void main()
{
    
    float f = in0;
    float g = func(f);
    out0 = f + g;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 0) flat out int out0;


int func (in int a)
{
    a = -a;
    return 2 * a;
}

void main()
{
    
    int f = in0;
    int g = func(f);
    out0 = f + g;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;
bool isOk (int a, int b)     { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in int in0;
layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
int out0;


int func (in int a)
{
    a = -a;
    return 2 * a;
}

void main()
{
    
    int f = in0;
    int g = func(f);
    out0 = f + g;
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


int func (in int a)
{
    a = -a;
    return 2 * a;
}

void main()
{
    
    int f = in0;
    int g = func(f);
    out0 = f + g;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 0) flat out int out0;


void func (out int a)
{
    a = -1;
}

void main()
{
    
    int f = 1;
    func(f);
    out0 = f * in0;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;
bool isOk (int a, int b)     { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in int in0;
layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
int out0;


void func (out int a)
{
    a = -1;
}

void main()
{
    
    int f = 1;
    func(f);
    out0 = f * in0;
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


void func (out int a)
{
    a = -1;
}

void main()
{
    
    int f = 1;
    func(f);
    out0 = f * in0;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 0) flat out int out0;


void func (inout int a)
{
    a = -a;
}

void main()
{
    
    int f = 1;
    func(f);
    out0 = f * in0;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;
bool isOk (int a, int b)     { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in int in0;
layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
int out0;


void func (inout int a)
{
    a = -a;
}

void main()
{
    
    int f = 1;
    func(f);
    out0 = f * in0;
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


void func (inout int a)
{
    a = -a;
}

void main()
{
    
    int f = 1;
    func(f);
    out0 = f * in0;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 0) flat out int out0;


int func (in lowp int a)
{
    a = -a;
    return 2 * a;
}

void main()
{
    
    int f = in0;
    int g = func(f);
    out0 = f + g;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;
bool isOk (int a, int b)     { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in int in0;
layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
int out0;


int func (in lowp int a)
{
    a = -a;
    return 2 * a;
}

void main()
{
    
    int f = in0;
    int g = func(f);
    out0 = f + g;
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


int func (in lowp int a)
{
    a = -a;
    return 2 * a;
}

void main()
{
    
    int f = in0;
    int g = func(f);
    out0 = f + g;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 0) flat out int out0;


void func (out lowp int a)
{
    a = -1;
}

void main()
{
    
    int f = 1;
    func(f);
    out0 = f * in0;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;
bool isOk (int a, int b)     { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in int in0;
layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
int out0;


void func (out lowp int a)
{
    a = -1;
}

void main()
{
    
    int f = 1;
    func(f);
    out0 = f * in0;
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


void func (out lowp int a)
{
    a = -1;
}

void main()
{
    
    int f = 1;
    func(f);
    out0 = f * in0;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 0) flat out int out0;


void func (inout lowp int a)
{
    a = -a;
}

void main()
{
    
    int f = 1;
    func(f);
    out0 = f * in0;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;
bool isOk (int a, int b)     { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in int in0;
layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
int out0;


void func (inout lowp int a)
{
    a = -a;
}

void main()
{
    
    int f = 1;
    func(f);
    out0 = f * in0;
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


void func (inout lowp int a)
{
    a = -a;
}

void main()
{
    
    int f = 1;
    func(f);
    out0 = f * in0;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 0) flat out int out0;


int func (in highp int a)
{
    a = -a;
    return 2 * a;
}

void main()
{
    
    int f = in0;
    int g = func(f);
    out0 = f + g;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;
bool isOk (int a, int b)     { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in int in0;
layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
int out0;


int func (in highp int a)
{
    a = -a;
    return 2 * a;
}

void main()
{
    
    int f = in0;
    int g = func(f);
    out0 = f + g;
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


int func (in highp int a)
{
    a = -a;
    return 2 * a;
}

void main()
{
    
    int f = in0;
    int g = func(f);
    out0 = f + g;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 0) flat out int out0;


void func (out highp int a)
{
    a = -1;
}

void main()
{
    
    int f = 1;
    func(f);
    out0 = f * in0;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;
bool isOk (int a, int b)     { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in int in0;
layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
int out0;


void func (out highp int a)
{
    a = -1;
}

void main()
{
    
    int f = 1;
    func(f);
    out0 = f * in0;
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


void func (out highp int a)
{
    a = -1;
}

void main()
{
    
    int f = 1;
    func(f);
    out0 = f * in0;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 0) flat out int out0;


void func (inout highp int a)
{
    a = -a;
}

void main()
{
    
    int f = 1;
    func(f);
    out0 = f * in0;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;
bool isOk (int a, int b)     { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in int in0;
layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
int out0;


void func (inout highp int a)
{
    a = -a;
}

void main()
{
    
    int f = 1;
    func(f);
    out0 = f * in0;
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


void func (inout highp int a)
{
    a = -a;
}

void main()
{
    
    int f = 1;
    func(f);
    out0 = f * in0;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 0) flat out int out0;


int func (const int a)
{
    int b = -a;
    return 2 * b;
}

void main()
{
    
    int f = in0;
    int g = func(f);
    out0 = f + g;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;
bool isOk (int a, int b)     { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in int in0;
layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
int out0;


int func (const int a)
{
    int b = -a;
    return 2 * b;
}

void main()
{
    
    int f = in0;
    int g = func(f);
    out0 = f + g;
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


int func (const int a)
{
    int b = -a;
    return 2 * b;
}

void main()
{
    
    int f = in0;
    int g = func(f);
    out0 = f + g;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 0) flat out int out0;


int func (const in int a)
{
    int b = -a;
    return 2 * b;
}

void main()
{
    
    int f = in0;
    int g = func(f);
    out0 = f + g;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;
bool isOk (int a, int b)     { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in int in0;
layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
int out0;


int func (const in int a)
{
    int b = -a;
    return 2 * b;
}

void main()
{
    
    int f = in0;
    int g = func(f);
    out0 = f + g;
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


int func (const in int a)
{
    int b = -a;
    return 2 * b;
}

void main()
{
    
    int f = in0;
    int g = func(f);
    out0 = f + g;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 0) flat out uint v_out0;
bool out0;


bool func (in bool a)
{
    a = !a;
    return a;
}

void main()
{
    bool in0 = bool(a_in0);

    bool f = in0;
    bool g = func(f);
    out0 = (f != g);
    gl_Position = dEQP_Position;
v_out0 = uint(out0);

}
#version 310 es
precision highp float;
precision highp int;
bool isOk (bool a, bool b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(binding = 0, std140) uniform Reference
{
	bool out0;
} ref;
bool out0;


bool func (in bool a)
{
    a = !a;
    return a;
}

void main()
{
    bool in0 = bool(v_in0);

    bool f = in0;
    bool g = func(f);
    out0 = (f != g);
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


bool func (in bool a)
{
    a = !a;
    return a;
}

void main()
{
    
    bool f = in0;
    bool g = func(f);
    out0 = (f != g);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 0) flat out uint v_out0;
bool out0;


void func (out bool a)
{
    a = false;
}

void main()
{
    bool in0 = bool(a_in0);

    bool f = true;
    func(f);
    out0 = (in0 == f);
    gl_Position = dEQP_Position;
v_out0 = uint(out0);

}
#version 310 es
precision highp float;
precision highp int;
bool isOk (bool a, bool b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(binding = 0, std140) uniform Reference
{
	bool out0;
} ref;
bool out0;


void func (out bool a)
{
    a = false;
}

void main()
{
    bool in0 = bool(v_in0);

    bool f = true;
    func(f);
    out0 = (in0 == f);
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


void func (out bool a)
{
    a = false;
}

void main()
{
    
    bool f = true;
    func(f);
    out0 = (in0 == f);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 0) flat out uint v_out0;
bool out0;


void func (inout bool a)
{
    a = !a;
}

void main()
{
    bool in0 = bool(a_in0);

    bool f = true;
    func(f);
    out0 = (in0 == f);
    gl_Position = dEQP_Position;
v_out0 = uint(out0);

}
#version 310 es
precision highp float;
precision highp int;
bool isOk (bool a, bool b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(binding = 0, std140) uniform Reference
{
	bool out0;
} ref;
bool out0;


void func (inout bool a)
{
    a = !a;
}

void main()
{
    bool in0 = bool(v_in0);

    bool f = true;
    func(f);
    out0 = (in0 == f);
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


void func (inout bool a)
{
    a = !a;
}

void main()
{
    
    bool f = true;
    func(f);
    out0 = (in0 == f);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 0) flat out uint v_out0;
bool out0;


bool func (const bool a)
{
    bool b = !a;
    return b;
}

void main()
{
    bool in0 = bool(a_in0);

    bool f = in0;
    bool g = func(f);
    out0 = (f != g);
    gl_Position = dEQP_Position;
v_out0 = uint(out0);

}
#version 310 es
precision highp float;
precision highp int;
bool isOk (bool a, bool b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(binding = 0, std140) uniform Reference
{
	bool out0;
} ref;
bool out0;


bool func (const bool a)
{
    bool b = !a;
    return b;
}

void main()
{
    bool in0 = bool(v_in0);

    bool f = in0;
    bool g = func(f);
    out0 = (f != g);
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


bool func (const bool a)
{
    bool b = !a;
    return b;
}

void main()
{
    
    bool f = in0;
    bool g = func(f);
    out0 = (f != g);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 0) flat out float out0;


float func (void);

float func (void)
{
    return -1.0;
}

void main()
{
    out0 = func() * in0;
    gl_Position = dEQP_Position;

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


float func (void);

float func (void)
{
    return -1.0;
}

void main()
{
    out0 = func() * in0;
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


float func (void);

float func (void)
{
    return -1.0;
}

void main()
{
    out0 = func() * in0;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 0) flat out float out0;


float func (float f);

float func (float f)
{
    return -f;
}

void main()
{
    out0 = func(in0);
    gl_Position = dEQP_Position;

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


float func (float f);

float func (float f)
{
    return -f;
}

void main()
{
    out0 = func(in0);
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


float func (float f);

float func (float f)
{
    return -f;
}

void main()
{
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 0) flat out float out0;


float func (void);

void main()
{
    out0 = func() * in0;
    gl_Position = dEQP_Position;

}

float func (void)
{
    return -1.0;
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


float func (void);

void main()
{
    out0 = func() * in0;
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}

float func (void)
{
    return -1.0;
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


float func (void);

void main()
{
    out0 = func() * in0;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}

float func (void)
{
    return -1.0;
}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 0) flat out float out0;


float func (void);

float func (void);

float func (void)
{
    return -1.0;
}

void main()
{
    out0 = func() * in0;
    gl_Position = dEQP_Position;

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


float func (void);

float func (void);

float func (void)
{
    return -1.0;
}

void main()
{
    out0 = func() * in0;
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


float func (void);

float func (void);

float func (void)
{
    return -1.0;
}

void main()
{
    out0 = func() * in0;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 0) flat out float out0;


float func (void)
{
    return -1.0;
}

float func (void);

void main()
{
    out0 = func() * in0;
    gl_Position = dEQP_Position;

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


float func (void)
{
    return -1.0;
}

float func (void);

void main()
{
    out0 = func() * in0;
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


float func (void)
{
    return -1.0;
}

float func (void);

void main()
{
    out0 = func() * in0;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 0) flat out float out0;


float func ();

void main()
{
    out0 = func() * in0;
    gl_Position = dEQP_Position;

}

float func (void)
{
    return -1.0;
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


float func ();

void main()
{
    out0 = func() * in0;
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}

float func (void)
{
    return -1.0;
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


float func ();

void main()
{
    out0 = func() * in0;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}

float func (void)
{
    return -1.0;
}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 0) flat out float out0;


float func (float f);

void main()
{
    out0 = func(in0);
    gl_Position = dEQP_Position;

}

float func (in float f)
{
    return -f;
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


float func (float f);

void main()
{
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}

float func (in float f)
{
    return -f;
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


float func (float f);

void main()
{
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}

float func (in float f)
{
    return -f;
}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 0) flat out float out0;


precision mediump float;

float func (float f);

precision highp float;

void main()
{
    out0 = func(in0);
    gl_Position = dEQP_Position;

}

float func (mediump float f)
{
    return -f;
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


precision mediump float;

float func (float f);

precision highp float;

void main()
{
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}

float func (mediump float f)
{
    return -f;
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


precision mediump float;

float func (float f);

precision highp float;

void main()
{
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}

float func (mediump float f)
{
    return -f;
}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 0) flat out float out0;


float func (float a)
{
    return -a;
}

int func (int a)
{
    return -a;
}

void main()
{
    out0 = func(in0) * float(func(-1));
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;
bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;


float func (float a)
{
    return -a;
}

int func (int a)
{
    return -a;
}

void main()
{
    out0 = func(in0) * float(func(-1));
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


float func (float a)
{
    return -a;
}

int func (int a)
{
    return -a;
}

void main()
{
    out0 = func(in0) * float(func(-1));
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 0) flat out float out0;


float func (float a) { return -a; }
vec2 func (vec2 a) { return a.yx; }
vec3 func (vec3 a) { return a.xxx; }
vec4 func (vec4 a) { return a.wwww; }

void main()
{
    out0 = func(func(func(func(vec4(in0)).xyz).xy).x);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;
bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;


float func (float a) { return -a; }
vec2 func (vec2 a) { return a.yx; }
vec3 func (vec3 a) { return a.xxx; }
vec4 func (vec4 a) { return a.wwww; }

void main()
{
    out0 = func(func(func(func(vec4(in0)).xyz).xy).x);
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


float func (float a) { return -a; }
vec2 func (vec2 a) { return a.yx; }
vec3 func (vec3 a) { return a.xxx; }
vec4 func (vec4 a) { return a.wwww; }

void main()
{
    out0 = func(func(func(func(vec4(in0)).xyz).xy).x);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 0) flat out int out0;


int func (int a) { return -a; }
ivec2 func (ivec2 a) { return a.yx; }
ivec3 func (ivec3 a) { return a.xxx; }
ivec4 func (ivec4 a) { return a.wwww; }

void main()
{
    
    out0 = func(func(func(func(ivec4(in0)).xyz).xy).x);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;
bool isOk (int a, int b)     { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in int in0;
layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
int out0;


int func (int a) { return -a; }
ivec2 func (ivec2 a) { return a.yx; }
ivec3 func (ivec3 a) { return a.xxx; }
ivec4 func (ivec4 a) { return a.wwww; }

void main()
{
    
    out0 = func(func(func(func(ivec4(in0)).xyz).xy).x);
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


int func (int a) { return -a; }
ivec2 func (ivec2 a) { return a.yx; }
ivec3 func (ivec3 a) { return a.xxx; }
ivec4 func (ivec4 a) { return a.wwww; }

void main()
{
    
    out0 = func(func(func(func(ivec4(in0)).xyz).xy).x);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 0) flat out uint v_out0;
bool out0;


bool func (bool a) { return !a; }
bvec2 func (bvec2 a) { return a.yx; }
bvec3 func (bvec3 a) { return a.xxx; }
bvec4 func (bvec4 a) { return a.wwww; }

void main()
{
    bool in0 = bool(a_in0);

    out0 = func(func(func(func(bvec4(in0)).xyz).xy).x);
    gl_Position = dEQP_Position;
v_out0 = uint(out0);

}
#version 310 es
precision highp float;
precision highp int;
bool isOk (bool a, bool b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(binding = 0, std140) uniform Reference
{
	bool out0;
} ref;
bool out0;


bool func (bool a) { return !a; }
bvec2 func (bvec2 a) { return a.yx; }
bvec3 func (bvec3 a) { return a.xxx; }
bvec4 func (bvec4 a) { return a.wwww; }

void main()
{
    bool in0 = bool(v_in0);

    out0 = func(func(func(func(bvec4(in0)).xyz).xy).x);
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


bool func (bool a) { return !a; }
bvec2 func (bvec2 a) { return a.yx; }
bvec3 func (bvec3 a) { return a.xxx; }
bvec4 func (bvec4 a) { return a.wwww; }

void main()
{
    
    out0 = func(func(func(func(bvec4(in0)).xyz).xy).x);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 0) flat out float out0;


float func (float a) { return -a; }
vec2 func (vec2 a) { return a.yx; }
vec3 func (vec3 a) { return a.xxx; }
vec4 func (vec4 a) { return a.wwww; }
int func (int a) { return -a; }
ivec2 func (ivec2 a) { return a.yx; }
ivec3 func (ivec3 a) { return a.xxx; }
ivec4 func (ivec4 a) { return a.wwww; }
bool func (bool a) { return !a; }
bvec2 func (bvec2 a) { return a.yx; }
bvec3 func (bvec3 a) { return a.xxx; }
bvec4 func (bvec4 a) { return a.wwww; }

void main()
{
    
    if (func(func(bvec4(false)).x))
        out0 = func(in0) * float(func(-1));
    else
        out0 = float(func(func(ivec4(func(func(func(vec4(0.5)).xyz).xy).xxxx)).xy).x);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;
bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;


float func (float a) { return -a; }
vec2 func (vec2 a) { return a.yx; }
vec3 func (vec3 a) { return a.xxx; }
vec4 func (vec4 a) { return a.wwww; }
int func (int a) { return -a; }
ivec2 func (ivec2 a) { return a.yx; }
ivec3 func (ivec3 a) { return a.xxx; }
ivec4 func (ivec4 a) { return a.wwww; }
bool func (bool a) { return !a; }
bvec2 func (bvec2 a) { return a.yx; }
bvec3 func (bvec3 a) { return a.xxx; }
bvec4 func (bvec4 a) { return a.wwww; }

void main()
{
    
    if (func(func(bvec4(false)).x))
        out0 = func(in0) * float(func(-1));
    else
        out0 = float(func(func(ivec4(func(func(func(vec4(0.5)).xyz).xy).xxxx)).xy).x);
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


float func (float a) { return -a; }
vec2 func (vec2 a) { return a.yx; }
vec3 func (vec3 a) { return a.xxx; }
vec4 func (vec4 a) { return a.wwww; }
int func (int a) { return -a; }
ivec2 func (ivec2 a) { return a.yx; }
ivec3 func (ivec3 a) { return a.xxx; }
ivec4 func (ivec4 a) { return a.wwww; }
bool func (bool a) { return !a; }
bvec2 func (bvec2 a) { return a.yx; }
bvec3 func (bvec3 a) { return a.xxx; }
bvec4 func (bvec4 a) { return a.wwww; }

void main()
{
    
    if (func(func(bvec4(false)).x))
        out0 = func(in0) * float(func(-1));
    else
        out0 = float(func(func(ivec4(func(func(func(vec4(0.5)).xyz).xy).xxxx)).xy).x);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 0) flat out float out0;


struct Pos { float a, b, c; };
struct Line { Pos start, end; };

float func (float a) { return -a; }
float func (float a[4]) { return a[0] + a[3]; }
vec2 func (vec2 a) { return a.yx; }
vec3 func (vec3 a) { return a.xxx; }
vec4 func (vec4 a) { return a.wwww; }
vec4 func (vec4 a[4]) { return a[1] + a[2]; }
int func (int a) { return -a; }
ivec2 func (ivec2 a) { return a.yx; }
ivec3 func (ivec3 a) { return a.xxx; }
ivec4 func (ivec4 a) { return a.wwww; }
bool func (bool a) { return !a; }
bvec2 func (bvec2 a) { return a.yx; }
bvec3 func (bvec3 a) { return a.xxx; }
bvec4 func (bvec4 a) { return a.wwww; }
Pos func (Pos a) { return a; }
Line func (Line a) { return Line(a.end, a.start); }

void main()
{
    
    float arr[4];
    vec4 arr2[4];
    out0 = func(arr) + func(arr2).x;
    if (func(func(bvec4(false)).x))
        out0 = func(in0) * float(func(-1));
    else
        out0 = float(func(func(ivec4(func(func(func(vec4(0.5)).xyz).xy).xxxx)).xy).x);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;
bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;


struct Pos { float a, b, c; };
struct Line { Pos start, end; };

float func (float a) { return -a; }
float func (float a[4]) { return a[0] + a[3]; }
vec2 func (vec2 a) { return a.yx; }
vec3 func (vec3 a) { return a.xxx; }
vec4 func (vec4 a) { return a.wwww; }
vec4 func (vec4 a[4]) { return a[1] + a[2]; }
int func (int a) { return -a; }
ivec2 func (ivec2 a) { return a.yx; }
ivec3 func (ivec3 a) { return a.xxx; }
ivec4 func (ivec4 a) { return a.wwww; }
bool func (bool a) { return !a; }
bvec2 func (bvec2 a) { return a.yx; }
bvec3 func (bvec3 a) { return a.xxx; }
bvec4 func (bvec4 a) { return a.wwww; }
Pos func (Pos a) { return a; }
Line func (Line a) { return Line(a.end, a.start); }

void main()
{
    
    float arr[4];
    vec4 arr2[4];
    out0 = func(arr) + func(arr2).x;
    if (func(func(bvec4(false)).x))
        out0 = func(in0) * float(func(-1));
    else
        out0 = float(func(func(ivec4(func(func(func(vec4(0.5)).xyz).xy).xxxx)).xy).x);
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


struct Pos { float a, b, c; };
struct Line { Pos start, end; };

float func (float a) { return -a; }
float func (float a[4]) { return a[0] + a[3]; }
vec2 func (vec2 a) { return a.yx; }
vec3 func (vec3 a) { return a.xxx; }
vec4 func (vec4 a) { return a.wwww; }
vec4 func (vec4 a[4]) { return a[1] + a[2]; }
int func (int a) { return -a; }
ivec2 func (ivec2 a) { return a.yx; }
ivec3 func (ivec3 a) { return a.xxx; }
ivec4 func (ivec4 a) { return a.wwww; }
bool func (bool a) { return !a; }
bvec2 func (bvec2 a) { return a.yx; }
bvec3 func (bvec3 a) { return a.xxx; }
bvec4 func (bvec4 a) { return a.wwww; }
Pos func (Pos a) { return a; }
Line func (Line a) { return Line(a.end, a.start); }

void main()
{
    
    float arr[4];
    vec4 arr2[4];
    out0 = func(arr) + func(arr2).x;
    if (func(func(bvec4(false)).x))
        out0 = func(in0) * float(func(-1));
    else
        out0 = float(func(func(ivec4(func(func(func(vec4(0.5)).xyz).xy).xxxx)).xy).x);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 0) flat out float out0;


float func (float a)
{
    return -a;
}

float func (float a, float b)
{
    return a * b;
}

void main()
{
    out0 = func(in0) * func(-0.5, -2.0);
    gl_Position = dEQP_Position;

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


float func (float a)
{
    return -a;
}

float func (float a, float b)
{
    return a * b;
}

void main()
{
    out0 = func(in0) * func(-0.5, -2.0);
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


float func (float a)
{
    return -a;
}

float func (float a, float b)
{
    return a * b;
}

void main()
{
    out0 = func(in0) * func(-0.5, -2.0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 0) flat out float out0;


float func (float f[3])
{
    return f[0];
}

float func (float f[4])
{
    return f[1];
}

void main ()
{
    
    float[4] x = float[4] (-1.0, 1.0, 0.0, 0.0);
    out0 = func(x);
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
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;


float func (float f[3])
{
    return f[0];
}

float func (float f[4])
{
    return f[1];
}

void main ()
{
    
    float[4] x = float[4] (-1.0, 1.0, 0.0, 0.0);
    out0 = func(x);
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


float func (float f[3])
{
    return f[0];
}

float func (float f[4])
{
    return f[1];
}

void main ()
{
    
    float[4] x = float[4] (-1.0, 1.0, 0.0, 0.0);
    out0 = func(x);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec4 in0;
layout(location = 0) flat out vec4 out0;


float func (in float a[4])
{
    a[0] = -1.0;
    a[2] = -4.0;
    a[3] = -3.0 * a[1];
    return a[0];
}

void main()
{
    float arr[4];
    arr[0] = in0.x;
    arr[1] = in0.y;
    arr[2] = in0.z;
    arr[3] = in0.w;
    float f = func(arr);
    out0 = f * vec4(arr[0], arr[1], arr[2], arr[3]);
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
bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec4 in0;
layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
vec4 out0;


float func (in float a[4])
{
    a[0] = -1.0;
    a[2] = -4.0;
    a[3] = -3.0 * a[1];
    return a[0];
}

void main()
{
    float arr[4];
    arr[0] = in0.x;
    arr[1] = in0.y;
    arr[2] = in0.z;
    arr[3] = in0.w;
    float f = func(arr);
    out0 = f * vec4(arr[0], arr[1], arr[2], arr[3]);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
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


float func (in float a[4])
{
    a[0] = -1.0;
    a[2] = -4.0;
    a[3] = -3.0 * a[1];
    return a[0];
}

void main()
{
    float arr[4];
    arr[0] = in0.x;
    arr[1] = in0.y;
    arr[2] = in0.z;
    arr[3] = in0.w;
    float f = func(arr);
    out0 = f * vec4(arr[0], arr[1], arr[2], arr[3]);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec4 in0;
layout(location = 0) flat out vec4 out0;


float func (in float a[4])
{
    a[0] = -1.0;
    a[2] = -4.0;
    a[3] = -3.0 * a[1];
    return a[0];
}

float arr[4];

void main()
{
    arr[0] = in0.x;
    arr[1] = in0.y;
    arr[2] = in0.z;
    arr[3] = in0.w;
    float f = func(arr);
    out0 = f * vec4(arr[0], arr[1], arr[2], arr[3]);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec4 in0;
layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
vec4 out0;


float func (in float a[4])
{
    a[0] = -1.0;
    a[2] = -4.0;
    a[3] = -3.0 * a[1];
    return a[0];
}

float arr[4];

void main()
{
    arr[0] = in0.x;
    arr[1] = in0.y;
    arr[2] = in0.z;
    arr[3] = in0.w;
    float f = func(arr);
    out0 = f * vec4(arr[0], arr[1], arr[2], arr[3]);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
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


float func (in float a[4])
{
    a[0] = -1.0;
    a[2] = -4.0;
    a[3] = -3.0 * a[1];
    return a[0];
}

float arr[4];

void main()
{
    arr[0] = in0.x;
    arr[1] = in0.y;
    arr[2] = in0.z;
    arr[3] = in0.w;
    float f = func(arr);
    out0 = f * vec4(arr[0], arr[1], arr[2], arr[3]);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec4 in0;
layout(location = 0) flat out ivec4 out0;


int func (in int a[4])
{
    a[0] = -1;
    a[2] = -4;
    a[3] = -3 * a[1];
    return a[0];
}

void main()
{
    
    int arr[4];
    arr[0] = in0.x;
    arr[1] = in0.y;
    arr[2] = in0.z;
    arr[3] = in0.w;
    int f = func(arr);
    out0 = f * ivec4(arr[0], arr[1], arr[2], arr[3]);
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
layout(location = 0) flat in ivec4 in0;
layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
ivec4 out0;


int func (in int a[4])
{
    a[0] = -1;
    a[2] = -4;
    a[3] = -3 * a[1];
    return a[0];
}

void main()
{
    
    int arr[4];
    arr[0] = in0.x;
    arr[1] = in0.y;
    arr[2] = in0.z;
    arr[3] = in0.w;
    int f = func(arr);
    out0 = f * ivec4(arr[0], arr[1], arr[2], arr[3]);
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


int func (in int a[4])
{
    a[0] = -1;
    a[2] = -4;
    a[3] = -3 * a[1];
    return a[0];
}

void main()
{
    
    int arr[4];
    arr[0] = in0.x;
    arr[1] = in0.y;
    arr[2] = in0.z;
    arr[3] = in0.w;
    int f = func(arr);
    out0 = f * ivec4(arr[0], arr[1], arr[2], arr[3]);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec4 in0;
layout(location = 0) flat out ivec4 out0;


int func (in int a[4])
{
    a[0] = -1;
    a[2] = -4;
    a[3] = -3 * a[1];
    return a[0];
}

int arr[4];

void main()
{
    
    arr[0] = in0.x;
    arr[1] = in0.y;
    arr[2] = in0.z;
    arr[3] = in0.w;
    int f = func(arr);
    out0 = f * ivec4(arr[0], arr[1], arr[2], arr[3]);
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


int func (in int a[4])
{
    a[0] = -1;
    a[2] = -4;
    a[3] = -3 * a[1];
    return a[0];
}

int arr[4];

void main()
{
    
    arr[0] = in0.x;
    arr[1] = in0.y;
    arr[2] = in0.z;
    arr[3] = in0.w;
    int f = func(arr);
    out0 = f * ivec4(arr[0], arr[1], arr[2], arr[3]);
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


int func (in int a[4])
{
    a[0] = -1;
    a[2] = -4;
    a[3] = -3 * a[1];
    return a[0];
}

int arr[4];

void main()
{
    
    arr[0] = in0.x;
    arr[1] = in0.y;
    arr[2] = in0.z;
    arr[3] = in0.w;
    int f = func(arr);
    out0 = f * ivec4(arr[0], arr[1], arr[2], arr[3]);
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


bool func (in bool a[4])
{
    a[0] = false;
    a[2] = true;
    a[3] = !a[1];
    return a[0];
}

void main()
{
    bvec4 in0 = bvec4(a_in0);

    bool arr[4];
    arr[0] = !in0.x;
    arr[1] = !in0.y;
    arr[2] = !in0.z;
    arr[3] = !in0.w;
    func(arr);
    out0 = bvec4(arr[0], arr[1], arr[2], arr[3]);
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
layout(location = 0) flat in uvec4 v_in0;
layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
bvec4 out0;


bool func (in bool a[4])
{
    a[0] = false;
    a[2] = true;
    a[3] = !a[1];
    return a[0];
}

void main()
{
    bvec4 in0 = bvec4(v_in0);

    bool arr[4];
    arr[0] = !in0.x;
    arr[1] = !in0.y;
    arr[2] = !in0.z;
    arr[3] = !in0.w;
    func(arr);
    out0 = bvec4(arr[0], arr[1], arr[2], arr[3]);
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


bool func (in bool a[4])
{
    a[0] = false;
    a[2] = true;
    a[3] = !a[1];
    return a[0];
}

void main()
{
    
    bool arr[4];
    arr[0] = !in0.x;
    arr[1] = !in0.y;
    arr[2] = !in0.z;
    arr[3] = !in0.w;
    func(arr);
    out0 = bvec4(arr[0], arr[1], arr[2], arr[3]);
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


bool func (in bool a[4])
{
    a[0] = false;
    a[2] = true;
    a[3] = !a[1];
    return a[0];
}

bool arr[4];

void main()
{
    bvec4 in0 = bvec4(a_in0);

    arr[0] = !in0.x;
    arr[1] = !in0.y;
    arr[2] = !in0.z;
    arr[3] = !in0.w;
    func(arr);
    out0 = bvec4(arr[0], arr[1], arr[2], arr[3]);
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


bool func (in bool a[4])
{
    a[0] = false;
    a[2] = true;
    a[3] = !a[1];
    return a[0];
}

bool arr[4];

void main()
{
    bvec4 in0 = bvec4(v_in0);

    arr[0] = !in0.x;
    arr[1] = !in0.y;
    arr[2] = !in0.z;
    arr[3] = !in0.w;
    func(arr);
    out0 = bvec4(arr[0], arr[1], arr[2], arr[3]);
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


bool func (in bool a[4])
{
    a[0] = false;
    a[2] = true;
    a[3] = !a[1];
    return a[0];
}

bool arr[4];

void main()
{
    
    arr[0] = !in0.x;
    arr[1] = !in0.y;
    arr[2] = !in0.z;
    arr[3] = !in0.w;
    func(arr);
    out0 = bvec4(arr[0], arr[1], arr[2], arr[3]);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec4 in0;
layout(location = 0) flat out float out0;


vec4 get (in float arr[4]);
void set (out float arr[4], vec4 val);
void negate (inout float arr[4]);
bool test (in float arr[4], vec4 ref);
bool isEqual (in float a[4], in float b[4]);

void main()
{
    float arr[4];
    set(arr, in0);
    negate(arr);
    out0 = float(test(arr, -in0));
    gl_Position = dEQP_Position;

}

float absDiff (vec4 a, vec4 b) { vec4 d = abs(a - b); return max(max(d.x, d.y), max(d.z, d.w)); }
vec4 get (in float arr[4]) { return vec4(arr[0], arr[1], arr[2], arr[3]); }
void set (out float arr[4], vec4 val) { arr[0] = val.x; arr[1] = val.y; arr[2] = val.z; arr[3] = val.w; }
void negate (inout float arr[4]) { set(arr, -get(arr)); }
bool test (in float arr[4], vec4 ref) { return (absDiff(get(arr), ref) < 0.1); }
bool isEqual (in float a[4], in float b[4]) { return (absDiff(get(a), get(b)) < 0.1); }
#version 310 es
precision highp float;
bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec4 in0;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;


vec4 get (in float arr[4]);
void set (out float arr[4], vec4 val);
void negate (inout float arr[4]);
bool test (in float arr[4], vec4 ref);
bool isEqual (in float a[4], in float b[4]);

void main()
{
    float arr[4];
    set(arr, in0);
    negate(arr);
    out0 = float(test(arr, -in0));
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}

float absDiff (vec4 a, vec4 b) { vec4 d = abs(a - b); return max(max(d.x, d.y), max(d.z, d.w)); }
vec4 get (in float arr[4]) { return vec4(arr[0], arr[1], arr[2], arr[3]); }
void set (out float arr[4], vec4 val) { arr[0] = val.x; arr[1] = val.y; arr[2] = val.z; arr[3] = val.w; }
void negate (inout float arr[4]) { set(arr, -get(arr)); }
bool test (in float arr[4], vec4 ref) { return (absDiff(get(arr), ref) < 0.1); }
bool isEqual (in float a[4], in float b[4]) { return (absDiff(get(a), get(b)) < 0.1); }
#version 310 es
precision highp float;
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


vec4 get (in float arr[4]);
void set (out float arr[4], vec4 val);
void negate (inout float arr[4]);
bool test (in float arr[4], vec4 ref);
bool isEqual (in float a[4], in float b[4]);

void main()
{
    float arr[4];
    set(arr, in0);
    negate(arr);
    out0 = float(test(arr, -in0));
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}

float absDiff (vec4 a, vec4 b) { vec4 d = abs(a - b); return max(max(d.x, d.y), max(d.z, d.w)); }
vec4 get (in float arr[4]) { return vec4(arr[0], arr[1], arr[2], arr[3]); }
void set (out float arr[4], vec4 val) { arr[0] = val.x; arr[1] = val.y; arr[2] = val.z; arr[3] = val.w; }
void negate (inout float arr[4]) { set(arr, -get(arr)); }
bool test (in float arr[4], vec4 ref) { return (absDiff(get(arr), ref) < 0.1); }
bool isEqual (in float a[4], in float b[4]) { return (absDiff(get(a), get(b)) < 0.1); }
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec4 in0;
layout(location = 0) flat out vec4 out0;


vec4 get (in float arr[4]);
void set (out float arr[4], vec4 val);
void negate (inout float arr[4]);
bool test (in float arr[4], vec4 ref);
bool isEqual (in float a[4], in float b[4]);

float func (in float a[4], in float b[4])
{
    a[0] = 2.123;
    a[2] = -4.123;
    return isEqual(a, b) ? 1.0 : -1.0;
}

void main()
{
    float arr[4];
    set(arr, in0);
    out0 = in0 * func(arr, arr);
    gl_Position = dEQP_Position;

}

float absDiff (vec4 a, vec4 b) { vec4 d = abs(a - b); return max(max(d.x, d.y), max(d.z, d.w)); }
vec4 get (in float arr[4]) { return vec4(arr[0], arr[1], arr[2], arr[3]); }
void set (out float arr[4], vec4 val) { arr[0] = val.x; arr[1] = val.y; arr[2] = val.z; arr[3] = val.w; }
void negate (inout float arr[4]) { set(arr, -get(arr)); }
bool test (in float arr[4], vec4 ref) { return (absDiff(get(arr), ref) < 0.1); }
bool isEqual (in float a[4], in float b[4]) { return (absDiff(get(a), get(b)) < 0.1); }
#version 310 es
precision highp float;
bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec4 in0;
layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
vec4 out0;


vec4 get (in float arr[4]);
void set (out float arr[4], vec4 val);
void negate (inout float arr[4]);
bool test (in float arr[4], vec4 ref);
bool isEqual (in float a[4], in float b[4]);

float func (in float a[4], in float b[4])
{
    a[0] = 2.123;
    a[2] = -4.123;
    return isEqual(a, b) ? 1.0 : -1.0;
}

void main()
{
    float arr[4];
    set(arr, in0);
    out0 = in0 * func(arr, arr);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}

float absDiff (vec4 a, vec4 b) { vec4 d = abs(a - b); return max(max(d.x, d.y), max(d.z, d.w)); }
vec4 get (in float arr[4]) { return vec4(arr[0], arr[1], arr[2], arr[3]); }
void set (out float arr[4], vec4 val) { arr[0] = val.x; arr[1] = val.y; arr[2] = val.z; arr[3] = val.w; }
void negate (inout float arr[4]) { set(arr, -get(arr)); }
bool test (in float arr[4], vec4 ref) { return (absDiff(get(arr), ref) < 0.1); }
bool isEqual (in float a[4], in float b[4]) { return (absDiff(get(a), get(b)) < 0.1); }
#version 310 es
precision highp float;
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


vec4 get (in float arr[4]);
void set (out float arr[4], vec4 val);
void negate (inout float arr[4]);
bool test (in float arr[4], vec4 ref);
bool isEqual (in float a[4], in float b[4]);

float func (in float a[4], in float b[4])
{
    a[0] = 2.123;
    a[2] = -4.123;
    return isEqual(a, b) ? 1.0 : -1.0;
}

void main()
{
    float arr[4];
    set(arr, in0);
    out0 = in0 * func(arr, arr);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}

float absDiff (vec4 a, vec4 b) { vec4 d = abs(a - b); return max(max(d.x, d.y), max(d.z, d.w)); }
vec4 get (in float arr[4]) { return vec4(arr[0], arr[1], arr[2], arr[3]); }
void set (out float arr[4], vec4 val) { arr[0] = val.x; arr[1] = val.y; arr[2] = val.z; arr[3] = val.w; }
void negate (inout float arr[4]) { set(arr, -get(arr)); }
bool test (in float arr[4], vec4 ref) { return (absDiff(get(arr), ref) < 0.1); }
bool isEqual (in float a[4], in float b[4]) { return (absDiff(get(a), get(b)) < 0.1); }
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec4 in0;
layout(location = 0) flat out vec4 out0;


vec4 get (in float arr[4]);
void set (out float arr[4], vec4 val);
void negate (inout float arr[4]);
bool test (in float arr[4], vec4 ref);
bool isEqual (in float a[4], in float b[4]);

float func (in float a[4], in float b[4])
{
    a[0] = 2.123;
    a[2] = -4.123;
    return isEqual(a, b) ? 1.0 : -1.0;
}

float arr[4];

void main()
{
    set(arr, in0);
    out0 = in0 * func(arr, arr);
    gl_Position = dEQP_Position;

}

float absDiff (vec4 a, vec4 b) { vec4 d = abs(a - b); return max(max(d.x, d.y), max(d.z, d.w)); }
vec4 get (in float arr[4]) { return vec4(arr[0], arr[1], arr[2], arr[3]); }
void set (out float arr[4], vec4 val) { arr[0] = val.x; arr[1] = val.y; arr[2] = val.z; arr[3] = val.w; }
void negate (inout float arr[4]) { set(arr, -get(arr)); }
bool test (in float arr[4], vec4 ref) { return (absDiff(get(arr), ref) < 0.1); }
bool isEqual (in float a[4], in float b[4]) { return (absDiff(get(a), get(b)) < 0.1); }
#version 310 es
precision highp float;
bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec4 in0;
layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
vec4 out0;


vec4 get (in float arr[4]);
void set (out float arr[4], vec4 val);
void negate (inout float arr[4]);
bool test (in float arr[4], vec4 ref);
bool isEqual (in float a[4], in float b[4]);

float func (in float a[4], in float b[4])
{
    a[0] = 2.123;
    a[2] = -4.123;
    return isEqual(a, b) ? 1.0 : -1.0;
}

float arr[4];

void main()
{
    set(arr, in0);
    out0 = in0 * func(arr, arr);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}

float absDiff (vec4 a, vec4 b) { vec4 d = abs(a - b); return max(max(d.x, d.y), max(d.z, d.w)); }
vec4 get (in float arr[4]) { return vec4(arr[0], arr[1], arr[2], arr[3]); }
void set (out float arr[4], vec4 val) { arr[0] = val.x; arr[1] = val.y; arr[2] = val.z; arr[3] = val.w; }
void negate (inout float arr[4]) { set(arr, -get(arr)); }
bool test (in float arr[4], vec4 ref) { return (absDiff(get(arr), ref) < 0.1); }
bool isEqual (in float a[4], in float b[4]) { return (absDiff(get(a), get(b)) < 0.1); }
#version 310 es
precision highp float;
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


vec4 get (in float arr[4]);
void set (out float arr[4], vec4 val);
void negate (inout float arr[4]);
bool test (in float arr[4], vec4 ref);
bool isEqual (in float a[4], in float b[4]);

float func (in float a[4], in float b[4])
{
    a[0] = 2.123;
    a[2] = -4.123;
    return isEqual(a, b) ? 1.0 : -1.0;
}

float arr[4];

void main()
{
    set(arr, in0);
    out0 = in0 * func(arr, arr);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}

float absDiff (vec4 a, vec4 b) { vec4 d = abs(a - b); return max(max(d.x, d.y), max(d.z, d.w)); }
vec4 get (in float arr[4]) { return vec4(arr[0], arr[1], arr[2], arr[3]); }
void set (out float arr[4], vec4 val) { arr[0] = val.x; arr[1] = val.y; arr[2] = val.z; arr[3] = val.w; }
void negate (inout float arr[4]) { set(arr, -get(arr)); }
bool test (in float arr[4], vec4 ref) { return (absDiff(get(arr), ref) < 0.1); }
bool isEqual (in float a[4], in float b[4]) { return (absDiff(get(a), get(b)) < 0.1); }
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec4 in0;
layout(location = 0) flat out vec4 out0;


vec4 get (in float arr[4]);
void set (out float arr[4], vec4 val);
void negate (inout float arr[4]);
bool test (in float arr[4], vec4 ref);
bool isEqual (in float a[4], in float b[4]);

float func (inout float a[4], inout float b[4])
{
    negate(a);
    return isEqual(a, b) ? 1.0 : -1.0;
}

void main()
{
    float arr[4];
    set(arr, in0);
    float m = func(arr, arr); // returns -1.0
    float n = float(test(arr, in0) || test(arr, -in0));
    out0 = in0 * m * n;
    gl_Position = dEQP_Position;

}

float absDiff (vec4 a, vec4 b) { vec4 d = abs(a - b); return max(max(d.x, d.y), max(d.z, d.w)); }
vec4 get (in float arr[4]) { return vec4(arr[0], arr[1], arr[2], arr[3]); }
void set (out float arr[4], vec4 val) { arr[0] = val.x; arr[1] = val.y; arr[2] = val.z; arr[3] = val.w; }
void negate (inout float arr[4]) { set(arr, -get(arr)); }
bool test (in float arr[4], vec4 ref) { return (absDiff(get(arr), ref) < 0.1); }
bool isEqual (in float a[4], in float b[4]) { return (absDiff(get(a), get(b)) < 0.1); }
#version 310 es
precision highp float;
bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec4 in0;
layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
vec4 out0;


vec4 get (in float arr[4]);
void set (out float arr[4], vec4 val);
void negate (inout float arr[4]);
bool test (in float arr[4], vec4 ref);
bool isEqual (in float a[4], in float b[4]);

float func (inout float a[4], inout float b[4])
{
    negate(a);
    return isEqual(a, b) ? 1.0 : -1.0;
}

void main()
{
    float arr[4];
    set(arr, in0);
    float m = func(arr, arr); // returns -1.0
    float n = float(test(arr, in0) || test(arr, -in0));
    out0 = in0 * m * n;
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}

float absDiff (vec4 a, vec4 b) { vec4 d = abs(a - b); return max(max(d.x, d.y), max(d.z, d.w)); }
vec4 get (in float arr[4]) { return vec4(arr[0], arr[1], arr[2], arr[3]); }
void set (out float arr[4], vec4 val) { arr[0] = val.x; arr[1] = val.y; arr[2] = val.z; arr[3] = val.w; }
void negate (inout float arr[4]) { set(arr, -get(arr)); }
bool test (in float arr[4], vec4 ref) { return (absDiff(get(arr), ref) < 0.1); }
bool isEqual (in float a[4], in float b[4]) { return (absDiff(get(a), get(b)) < 0.1); }
#version 310 es
precision highp float;
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


vec4 get (in float arr[4]);
void set (out float arr[4], vec4 val);
void negate (inout float arr[4]);
bool test (in float arr[4], vec4 ref);
bool isEqual (in float a[4], in float b[4]);

float func (inout float a[4], inout float b[4])
{
    negate(a);
    return isEqual(a, b) ? 1.0 : -1.0;
}

void main()
{
    float arr[4];
    set(arr, in0);
    float m = func(arr, arr); // returns -1.0
    float n = float(test(arr, in0) || test(arr, -in0));
    out0 = in0 * m * n;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}

float absDiff (vec4 a, vec4 b) { vec4 d = abs(a - b); return max(max(d.x, d.y), max(d.z, d.w)); }
vec4 get (in float arr[4]) { return vec4(arr[0], arr[1], arr[2], arr[3]); }
void set (out float arr[4], vec4 val) { arr[0] = val.x; arr[1] = val.y; arr[2] = val.z; arr[3] = val.w; }
void negate (inout float arr[4]) { set(arr, -get(arr)); }
bool test (in float arr[4], vec4 ref) { return (absDiff(get(arr), ref) < 0.1); }
bool isEqual (in float a[4], in float b[4]) { return (absDiff(get(a), get(b)) < 0.1); }
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec4 in0;
layout(location = 0) flat out vec4 out0;


vec4 get (in float arr[4]);
void set (out float arr[4], vec4 val);
void negate (inout float arr[4]);
bool test (in float arr[4], vec4 ref);
bool isEqual (in float a[4], in float b[4]);

float func (in float a[4], in float b[4])
{
    negate(a);
    return isEqual(a, b) ? 1.0 : -1.0;
}

float arr[4];

void main()
{
    set(arr, in0);
    float m = func(arr, arr); // returns -1.0
    float n = float(test(arr, in0) || test(arr, -in0));
    out0 = in0 * m * n;
    gl_Position = dEQP_Position;

}

float absDiff (vec4 a, vec4 b) { vec4 d = abs(a - b); return max(max(d.x, d.y), max(d.z, d.w)); }
vec4 get (in float arr[4]) { return vec4(arr[0], arr[1], arr[2], arr[3]); }
void set (out float arr[4], vec4 val) { arr[0] = val.x; arr[1] = val.y; arr[2] = val.z; arr[3] = val.w; }
void negate (inout float arr[4]) { set(arr, -get(arr)); }
bool test (in float arr[4], vec4 ref) { return (absDiff(get(arr), ref) < 0.1); }
bool isEqual (in float a[4], in float b[4]) { return (absDiff(get(a), get(b)) < 0.1); }
#version 310 es
precision highp float;
bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec4 in0;
layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
vec4 out0;


vec4 get (in float arr[4]);
void set (out float arr[4], vec4 val);
void negate (inout float arr[4]);
bool test (in float arr[4], vec4 ref);
bool isEqual (in float a[4], in float b[4]);

float func (in float a[4], in float b[4])
{
    negate(a);
    return isEqual(a, b) ? 1.0 : -1.0;
}

float arr[4];

void main()
{
    set(arr, in0);
    float m = func(arr, arr); // returns -1.0
    float n = float(test(arr, in0) || test(arr, -in0));
    out0 = in0 * m * n;
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}

float absDiff (vec4 a, vec4 b) { vec4 d = abs(a - b); return max(max(d.x, d.y), max(d.z, d.w)); }
vec4 get (in float arr[4]) { return vec4(arr[0], arr[1], arr[2], arr[3]); }
void set (out float arr[4], vec4 val) { arr[0] = val.x; arr[1] = val.y; arr[2] = val.z; arr[3] = val.w; }
void negate (inout float arr[4]) { set(arr, -get(arr)); }
bool test (in float arr[4], vec4 ref) { return (absDiff(get(arr), ref) < 0.1); }
bool isEqual (in float a[4], in float b[4]) { return (absDiff(get(a), get(b)) < 0.1); }
#version 310 es
precision highp float;
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


vec4 get (in float arr[4]);
void set (out float arr[4], vec4 val);
void negate (inout float arr[4]);
bool test (in float arr[4], vec4 ref);
bool isEqual (in float a[4], in float b[4]);

float func (in float a[4], in float b[4])
{
    negate(a);
    return isEqual(a, b) ? 1.0 : -1.0;
}

float arr[4];

void main()
{
    set(arr, in0);
    float m = func(arr, arr); // returns -1.0
    float n = float(test(arr, in0) || test(arr, -in0));
    out0 = in0 * m * n;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}

float absDiff (vec4 a, vec4 b) { vec4 d = abs(a - b); return max(max(d.x, d.y), max(d.z, d.w)); }
vec4 get (in float arr[4]) { return vec4(arr[0], arr[1], arr[2], arr[3]); }
void set (out float arr[4], vec4 val) { arr[0] = val.x; arr[1] = val.y; arr[2] = val.z; arr[3] = val.w; }
void negate (inout float arr[4]) { set(arr, -get(arr)); }
bool test (in float arr[4], vec4 ref) { return (absDiff(get(arr), ref) < 0.1); }
bool isEqual (in float a[4], in float b[4]) { return (absDiff(get(a), get(b)) < 0.1); }
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 0) flat out float out0;


float func (float a)
{
    return -a;
    a = a * -1.0;
    return 1.0;
}

void main()
{
    
    out0 = func(in0);
    gl_Position = dEQP_Position;

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


float func (float a)
{
    return -a;
    a = a * -1.0;
    return 1.0;
}

void main()
{
    
    out0 = func(in0);
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


float func (float a)
{
    return -a;
    a = a * -1.0;
    return 1.0;
}

void main()
{
    
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 0) flat out float out0;


float func (float a)
{
    if (a != 0.0)
        return -a;
    return 1.0;
}

void main()
{
    
    out0 = func(in0);
    gl_Position = dEQP_Position;

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


float func (float a)
{
    if (a != 0.0)
        return -a;
    return 1.0;
}

void main()
{
    
    out0 = func(in0);
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


float func (float a)
{
    if (a != 0.0)
        return -a;
    return 1.0;
}

void main()
{
    
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 0) flat out float out0;


float func (float a)
{
    if (a == 0.0)
        return 1.0;
    else
        return -a;
    return 1.0;
}

void main()
{
    
    out0 = func(in0);
    gl_Position = dEQP_Position;

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


float func (float a)
{
    if (a == 0.0)
        return 1.0;
    else
        return -a;
    return 1.0;
}

void main()
{
    
    out0 = func(in0);
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


float func (float a)
{
    if (a == 0.0)
        return 1.0;
    else
        return -a;
    return 1.0;
}

void main()
{
    
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 0) flat out float out0;


float func (float a)
{
    while (a < 100.0)
        return -a;
    return 1.0;
}

void main()
{
    
    out0 = func(in0);
    gl_Position = dEQP_Position;

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


float func (float a)
{
    while (a < 100.0)
        return -a;
    return 1.0;
}

void main()
{
    
    out0 = func(in0);
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


float func (float a)
{
    while (a < 100.0)
        return -a;
    return 1.0;
}

void main()
{
    
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 0) flat out float out0;


float func (float a)
{
    while (a < 100.0)
    {
        a = -a;
        if (a != 0.0)
            return a;
        else
            return -1.0;
    }
    return 1.0;
}

void main()
{
    
    out0 = func(in0);
    gl_Position = dEQP_Position;

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


float func (float a)
{
    while (a < 100.0)
    {
        a = -a;
        if (a != 0.0)
            return a;
        else
            return -1.0;
    }
    return 1.0;
}

void main()
{
    
    out0 = func(in0);
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


float func (float a)
{
    while (a < 100.0)
    {
        a = -a;
        if (a != 0.0)
            return a;
        else
            return -1.0;
    }
    return 1.0;
}

void main()
{
    
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 0) flat out float out0;


float func (float a)
{
    for (int i = 0; i < 5; i++)
        a = -a;
    return a;
}

void main()
{
    
    out0 = func(in0);
    gl_Position = dEQP_Position;

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


float func (float a)
{
    for (int i = 0; i < 5; i++)
        a = -a;
    return a;
}

void main()
{
    
    out0 = func(in0);
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


float func (float a)
{
    for (int i = 0; i < 5; i++)
        a = -a;
    return a;
}

void main()
{
    
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 0) flat out float out0;


float func (float a)
{
    for (int i = 0; i < 6; i++)
    {
        a = -a;
        if (i == 4)
            break;
    }
    return a;
}

void main()
{
    
    out0 = func(in0);
    gl_Position = dEQP_Position;

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


float func (float a)
{
    for (int i = 0; i < 6; i++)
    {
        a = -a;
        if (i == 4)
            break;
    }
    return a;
}

void main()
{
    
    out0 = func(in0);
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


float func (float a)
{
    for (int i = 0; i < 6; i++)
    {
        a = -a;
        if (i == 4)
            break;
    }
    return a;
}

void main()
{
    
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 0) flat out float out0;


float func (float a)
{
    for (int i = 0; i < 6; i++)
    {
        if (i == 4)
            continue;
        a = -a;
    }
    return a;
}

void main()
{
    
    out0 = func(in0);
    gl_Position = dEQP_Position;

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


float func (float a)
{
    for (int i = 0; i < 6; i++)
    {
        if (i == 4)
            continue;
        a = -a;
    }
    return a;
}

void main()
{
    
    out0 = func(in0);
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


float func (float a)
{
    for (int i = 0; i < 6; i++)
    {
        if (i == 4)
            continue;
        a = -a;
    }
    return a;
}

void main()
{
    
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 0) flat out float out0;


float func (float a)
{
    for (int i = 0; i < 6; i++)
    {
        a = -a;
        for (int j = 0; j < 4; j++)
        {
            a = -a;
            if (i == 1)
                return a;
        }
        if (i == 4)
            return 1.0;
    }
    return 1.0;
}

void main()
{
    
    out0 = func(in0);
    gl_Position = dEQP_Position;

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


float func (float a)
{
    for (int i = 0; i < 6; i++)
    {
        a = -a;
        for (int j = 0; j < 4; j++)
        {
            a = -a;
            if (i == 1)
                return a;
        }
        if (i == 4)
            return 1.0;
    }
    return 1.0;
}

void main()
{
    
    out0 = func(in0);
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


float func (float a)
{
    for (int i = 0; i < 6; i++)
    {
        a = -a;
        for (int j = 0; j < 4; j++)
        {
            a = -a;
            if (i == 1)
                return a;
        }
        if (i == 4)
            return 1.0;
    }
    return 1.0;
}

void main()
{
    
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 0) flat out float out0;


float func (float a)
{
    int i;
    for (i = 0; i < 6; i++) // negate a
    {
        a = -a;
        if (i == 4)
            a = -a;
    }

    for (; i < 10; i++) // keep a
    {
        if (i == 8)
            continue;
        else if (i == 9)
            break;
        a = -a;
    }

    return a;
}

void main()
{
    
    out0 = func(in0);
    gl_Position = dEQP_Position;

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


float func (float a)
{
    int i;
    for (i = 0; i < 6; i++) // negate a
    {
        a = -a;
        if (i == 4)
            a = -a;
    }

    for (; i < 10; i++) // keep a
    {
        if (i == 8)
            continue;
        else if (i == 9)
            break;
        a = -a;
    }

    return a;
}

void main()
{
    
    out0 = func(in0);
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


float func (float a)
{
    int i;
    for (i = 0; i < 6; i++) // negate a
    {
        a = -a;
        if (i == 4)
            a = -a;
    }

    for (; i < 10; i++) // keep a
    {
        if (i == 8)
            continue;
        else if (i == 9)
            break;
        a = -a;
    }

    return a;
}

void main()
{
    
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 0) flat out float out0;


float func (float a)
{
    int i;
    for (i = 0; i < 6; i++)
    {
        if (i == 0)
            continue;
        else if (i == 1)
        {
        }
        else if (i == 3)
            break;
        else
            return a;
        a = -a;
    }

    return 1.0;
}

void main()
{
    
    out0 = func(in0);
    gl_Position = dEQP_Position;

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


float func (float a)
{
    int i;
    for (i = 0; i < 6; i++)
    {
        if (i == 0)
            continue;
        else if (i == 1)
        {
        }
        else if (i == 3)
            break;
        else
            return a;
        a = -a;
    }

    return 1.0;
}

void main()
{
    
    out0 = func(in0);
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


float func (float a)
{
    int i;
    for (i = 0; i < 6; i++)
    {
        if (i == 0)
            continue;
        else if (i == 1)
        {
        }
        else if (i == 3)
            break;
        else
            return a;
        a = -a;
    }

    return 1.0;
}

void main()
{
    
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec4 in0;
layout(location = 0) flat out float out0;


float sum(vec4 v) { return (v.x + v.y + v.z + v.w); }

float func (float a, vec3 b, vec2 c, vec2 d, vec4 e)
{
    return -sum(vec4(a, b) + vec4(c, d)) + sum(e);
}

void main()
{
    
    out0 = func(in0.y, in0.xzw, in0.wz, in0.yx, in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec4 in0;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;


float sum(vec4 v) { return (v.x + v.y + v.z + v.w); }

float func (float a, vec3 b, vec2 c, vec2 d, vec4 e)
{
    return -sum(vec4(a, b) + vec4(c, d)) + sum(e);
}

void main()
{
    
    out0 = func(in0.y, in0.xzw, in0.wz, in0.yx, in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
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


float sum(vec4 v) { return (v.x + v.y + v.z + v.w); }

float func (float a, vec3 b, vec2 c, vec2 d, vec4 e)
{
    return -sum(vec4(a, b) + vec4(c, d)) + sum(e);
}

void main()
{
    
    out0 = func(in0.y, in0.xzw, in0.wz, in0.yx, in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec4 in0;
layout(location = 0) flat out int out0;


int sum(ivec4 v) { return (v.x + v.y + v.z + v.w); }

int func (int a, ivec3 b, ivec2 c, ivec2 d, ivec4 e)
{
    return -sum(ivec4(a, b) + ivec4(c, d)) + sum(e);
}

void main()
{
    
    out0 = func(in0.y, in0.xzw, in0.wz, in0.yx, in0);
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


int sum(ivec4 v) { return (v.x + v.y + v.z + v.w); }

int func (int a, ivec3 b, ivec2 c, ivec2 d, ivec4 e)
{
    return -sum(ivec4(a, b) + ivec4(c, d)) + sum(e);
}

void main()
{
    
    out0 = func(in0.y, in0.xzw, in0.wz, in0.yx, in0);
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


int sum(ivec4 v) { return (v.x + v.y + v.z + v.w); }

int func (int a, ivec3 b, ivec2 c, ivec2 d, ivec4 e)
{
    return -sum(ivec4(a, b) + ivec4(c, d)) + sum(e);
}

void main()
{
    
    out0 = func(in0.y, in0.xzw, in0.wz, in0.yx, in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 0) flat out int out0;


int func (float a, int b, bool c, int d)
{
    if (c)
        return b + int(a) + d;
    else
        return -1;
}

void main ()
{
    
    float v0 = float(in0);
    int v1 = in0;
    out0 = func((v0 += 1.0), v1++, (v0 > 1.5), v1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;
bool isOk (int a, int b)     { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in int in0;
layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
int out0;


int func (float a, int b, bool c, int d)
{
    if (c)
        return b + int(a) + d;
    else
        return -1;
}

void main ()
{
    
    float v0 = float(in0);
    int v1 = in0;
    out0 = func((v0 += 1.0), v1++, (v0 > 1.5), v1);
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


int func (float a, int b, bool c, int d)
{
    if (c)
        return b + int(a) + d;
    else
        return -1;
}

void main ()
{
    
    float v0 = float(in0);
    int v1 = in0;
    out0 = func((v0 += 1.0), v1++, (v0 > 1.5), v1);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 0) flat out int out0;


int g;

int modG (int v)
{
    g += v;
    return v;
}

int func (float a, int b, bool c, int d)
{
    if (c)
        return b + int(a) + d;
    else
        return -1;
}

void main ()
{
    
    out0 = func(float(g = in0), modG(2), --g > 0, g);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;
bool isOk (int a, int b)     { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in int in0;
layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
int out0;


int g;

int modG (int v)
{
    g += v;
    return v;
}

int func (float a, int b, bool c, int d)
{
    if (c)
        return b + int(a) + d;
    else
        return -1;
}

void main ()
{
    
    out0 = func(float(g = in0), modG(2), --g > 0, g);
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


int g;

int modG (int v)
{
    g += v;
    return v;
}

int func (float a, int b, bool c, int d)
{
    if (c)
        return b + int(a) + d;
    else
        return -1;
}

void main ()
{
    
    out0 = func(float(g = in0), modG(2), --g > 0, g);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
