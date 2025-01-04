#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 in0;
layout(location = 0) flat out float out0;


void main()
{
    
    out0 = in0.x;
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
    
    out0 = in0.x;
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
    
    out0 = in0.x;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.xx;
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
layout(location = 0) flat in vec2 in0;
layout(binding = 0, std140) uniform Reference
{
	vec2 out0;
} ref;
vec2 out0;


void main()
{
    
    out0 = in0.xx;
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
    
    out0 = in0.xx;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.xy;
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
    
    out0 = in0.xy;
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
    
    out0 = in0.xy;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.yx;
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
    
    out0 = in0.yx;
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
    
    out0 = in0.yx;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 in0;
layout(location = 0) flat out vec3 out0;


void main()
{
    
    out0 = in0.yxy;
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
layout(location = 0) flat in vec2 in0;
layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
vec3 out0;


void main()
{
    
    out0 = in0.yxy;
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
    
    out0 = in0.yxy;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 in0;
layout(location = 0) flat out vec4 out0;


void main()
{
    
    out0 = in0.xyxx;
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
layout(location = 0) flat in vec2 in0;
layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
vec4 out0;


void main()
{
    
    out0 = in0.xyxx;
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
    
    out0 = in0.xyxx;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 in0;
layout(location = 0) flat out vec4 out0;


void main()
{
    
    out0 = in0.yyyy;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec2 in0;
layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
vec4 out0;


void main()
{
    
    out0 = in0.yyyy;
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
    
    out0 = in0.yyyy;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 in0;
layout(location = 0) flat out float out0;


void main()
{
    
    out0 = in0.s;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.s;
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
    
    out0 = in0.s;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.ss;
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
    
    out0 = in0.ss;
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
    
    out0 = in0.ss;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.st;
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
    
    out0 = in0.st;
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
    
    out0 = in0.st;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.ts;
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
    
    out0 = in0.ts;
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
    
    out0 = in0.ts;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 in0;
layout(location = 0) flat out vec3 out0;


void main()
{
    
    out0 = in0.tst;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec2 in0;
layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
vec3 out0;


void main()
{
    
    out0 = in0.tst;
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
    
    out0 = in0.tst;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 in0;
layout(location = 0) flat out vec4 out0;


void main()
{
    
    out0 = in0.stss;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec2 in0;
layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
vec4 out0;


void main()
{
    
    out0 = in0.stss;
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
    
    out0 = in0.stss;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 in0;
layout(location = 0) flat out vec4 out0;


void main()
{
    
    out0 = in0.tttt;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec2 in0;
layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
vec4 out0;


void main()
{
    
    out0 = in0.tttt;
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
    
    out0 = in0.tttt;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 in0;
layout(location = 0) flat out float out0;


void main()
{
    
    out0 = in0.r;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.r;
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
    
    out0 = in0.r;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.rr;
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
    
    out0 = in0.rr;
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
    
    out0 = in0.rr;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.rg;
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
    
    out0 = in0.rg;
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
    
    out0 = in0.rg;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.gr;
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
    
    out0 = in0.gr;
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
    
    out0 = in0.gr;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 in0;
layout(location = 0) flat out vec3 out0;


void main()
{
    
    out0 = in0.grg;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec2 in0;
layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
vec3 out0;


void main()
{
    
    out0 = in0.grg;
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
    
    out0 = in0.grg;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 in0;
layout(location = 0) flat out vec4 out0;


void main()
{
    
    out0 = in0.rgrr;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec2 in0;
layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
vec4 out0;


void main()
{
    
    out0 = in0.rgrr;
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
    
    out0 = in0.rgrr;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 in0;
layout(location = 0) flat out vec4 out0;


void main()
{
    
    out0 = in0.gggg;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec2 in0;
layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
vec4 out0;


void main()
{
    
    out0 = in0.gggg;
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
    
    out0 = in0.gggg;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.x;
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
    
    out0 = in0.x;
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
    
    out0 = in0.x;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.z;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.z;
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
    
    out0 = in0.z;
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
    
    out0 = in0.xz;
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
    
    out0 = in0.xz;
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
    
    out0 = in0.xz;
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
    
    out0 = in0.zz;
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
    
    out0 = in0.zz;
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
    
    out0 = in0.zz;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.xyz;
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
    
    out0 = in0.xyz;
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
    
    out0 = in0.xyz;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.zyx;
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
    
    out0 = in0.zyx;
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
    
    out0 = in0.zyx;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.xxx;
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
    
    out0 = in0.xxx;
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
    
    out0 = in0.xxx;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.zzz;
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
    
    out0 = in0.zzz;
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
    
    out0 = in0.zzz;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.zzy;
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
    
    out0 = in0.zzy;
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
    
    out0 = in0.zzy;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.yxy;
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
    
    out0 = in0.yxy;
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
    
    out0 = in0.yxy;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.xzx;
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
    
    out0 = in0.xzx;
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
    
    out0 = in0.xzx;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 0) flat out vec4 out0;


void main()
{
    
    out0 = in0.xyyx;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec3 in0;
layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
vec4 out0;


void main()
{
    
    out0 = in0.xyyx;
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
    
    out0 = in0.xyyx;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 0) flat out vec4 out0;


void main()
{
    
    out0 = in0.zzzz;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec3 in0;
layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
vec4 out0;


void main()
{
    
    out0 = in0.zzzz;
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
    
    out0 = in0.zzzz;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.s;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.s;
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
    
    out0 = in0.s;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.p;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.p;
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
    
    out0 = in0.p;
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
    
    out0 = in0.sp;
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
    
    out0 = in0.sp;
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
    
    out0 = in0.sp;
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
    
    out0 = in0.pp;
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
    
    out0 = in0.pp;
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
    
    out0 = in0.pp;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.stp;
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
    
    out0 = in0.stp;
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
    
    out0 = in0.stp;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.pts;
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
    
    out0 = in0.pts;
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
    
    out0 = in0.pts;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.sss;
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
    
    out0 = in0.sss;
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
    
    out0 = in0.sss;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.ppp;
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
    
    out0 = in0.ppp;
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
    
    out0 = in0.ppp;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.ppt;
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
    
    out0 = in0.ppt;
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
    
    out0 = in0.ppt;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.tst;
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
    
    out0 = in0.tst;
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
    
    out0 = in0.tst;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.sps;
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
    
    out0 = in0.sps;
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
    
    out0 = in0.sps;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 0) flat out vec4 out0;


void main()
{
    
    out0 = in0.stts;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec3 in0;
layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
vec4 out0;


void main()
{
    
    out0 = in0.stts;
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
    
    out0 = in0.stts;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 0) flat out vec4 out0;


void main()
{
    
    out0 = in0.pppp;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec3 in0;
layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
vec4 out0;


void main()
{
    
    out0 = in0.pppp;
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
    
    out0 = in0.pppp;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.r;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.r;
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
    
    out0 = in0.r;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.b;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.b;
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
    
    out0 = in0.b;
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
    
    out0 = in0.rb;
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
    
    out0 = in0.rb;
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
    
    out0 = in0.rb;
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
    
    out0 = in0.bb;
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
    
    out0 = in0.bb;
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
    
    out0 = in0.bb;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.rgb;
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
    
    out0 = in0.rgb;
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
    
    out0 = in0.rgb;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.bgr;
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
    
    out0 = in0.bgr;
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
    
    out0 = in0.bgr;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.rrr;
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
    
    out0 = in0.rrr;
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
    
    out0 = in0.rrr;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.bbb;
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
    
    out0 = in0.bbb;
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
    
    out0 = in0.bbb;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.bbg;
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
    
    out0 = in0.bbg;
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
    
    out0 = in0.bbg;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.grg;
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
    
    out0 = in0.grg;
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
    
    out0 = in0.grg;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.rbr;
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
    
    out0 = in0.rbr;
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
    
    out0 = in0.rbr;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 0) flat out vec4 out0;


void main()
{
    
    out0 = in0.rggr;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec3 in0;
layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
vec4 out0;


void main()
{
    
    out0 = in0.rggr;
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
    
    out0 = in0.rggr;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 0) flat out vec4 out0;


void main()
{
    
    out0 = in0.bbbb;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec3 in0;
layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
vec4 out0;


void main()
{
    
    out0 = in0.bbbb;
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
    
    out0 = in0.bbbb;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.x;
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
    
    out0 = in0.x;
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
    
    out0 = in0.x;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.w;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.w;
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
    
    out0 = in0.w;
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
    
    out0 = in0.wx;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.wx;
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
    
    out0 = in0.wx;
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
    
    out0 = in0.wz;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.wz;
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
    
    out0 = in0.wz;
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
    
    out0 = in0.www;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.www;
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
    
    out0 = in0.www;
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
    
    out0 = in0.yyw;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.yyw;
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
    
    out0 = in0.yyw;
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
    
    out0 = in0.wzy;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.wzy;
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
    
    out0 = in0.wzy;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.xyzw;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.xyzw;
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
    
    out0 = in0.xyzw;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.wzyx;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.wzyx;
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
    
    out0 = in0.wzyx;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.xxxx;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.xxxx;
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
    
    out0 = in0.xxxx;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.yyyy;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.yyyy;
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
    
    out0 = in0.yyyy;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.wwww;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.wwww;
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
    
    out0 = in0.wwww;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.wzzw;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.wzzw;
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
    
    out0 = in0.wzzw;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.wwwy;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.wwwy;
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
    
    out0 = in0.wwwy;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.xyxx;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.xyxx;
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
    
    out0 = in0.xyxx;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.zzwz;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.zzwz;
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
    
    out0 = in0.zzwz;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.s;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.s;
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
    
    out0 = in0.s;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.q;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.q;
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
    
    out0 = in0.q;
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
    
    out0 = in0.qs;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.qs;
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
    
    out0 = in0.qs;
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
    
    out0 = in0.qp;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.qp;
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
    
    out0 = in0.qp;
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
    
    out0 = in0.qqq;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.qqq;
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
    
    out0 = in0.qqq;
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
    
    out0 = in0.ttq;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.ttq;
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
    
    out0 = in0.ttq;
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
    
    out0 = in0.qpt;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.qpt;
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
    
    out0 = in0.qpt;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.stpq;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.stpq;
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
    
    out0 = in0.stpq;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.qpts;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.qpts;
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
    
    out0 = in0.qpts;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.ssss;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.ssss;
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
    
    out0 = in0.ssss;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.tttt;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.tttt;
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
    
    out0 = in0.tttt;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.qqqq;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.qqqq;
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
    
    out0 = in0.qqqq;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.qppq;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.qppq;
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
    
    out0 = in0.qppq;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.qqqt;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.qqqt;
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
    
    out0 = in0.qqqt;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.stss;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.stss;
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
    
    out0 = in0.stss;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.ppqp;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.ppqp;
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
    
    out0 = in0.ppqp;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.r;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.r;
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
    
    out0 = in0.r;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.a;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.a;
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
    
    out0 = in0.a;
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
    
    out0 = in0.ar;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.ar;
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
    
    out0 = in0.ar;
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
    
    out0 = in0.ab;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.ab;
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
    
    out0 = in0.ab;
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
    
    out0 = in0.aaa;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.aaa;
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
    
    out0 = in0.aaa;
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
    
    out0 = in0.gga;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.gga;
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
    
    out0 = in0.gga;
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
    
    out0 = in0.abg;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.abg;
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
    
    out0 = in0.abg;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.rgba;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.rgba;
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
    
    out0 = in0.rgba;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.abgr;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.abgr;
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
    
    out0 = in0.abgr;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.rrrr;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.rrrr;
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
    
    out0 = in0.rrrr;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.gggg;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.gggg;
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
    
    out0 = in0.gggg;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.aaaa;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.aaaa;
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
    
    out0 = in0.aaaa;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.abba;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.abba;
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
    
    out0 = in0.abba;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.aaag;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.aaag;
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
    
    out0 = in0.aaag;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.rgrr;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.rgrr;
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
    
    out0 = in0.rgrr;
    bool RES = isOk(out0, ref.out0, 0.05);
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
    
    out0 = in0.bbab;
    gl_Position = dEQP_Position;

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
    
    out0 = in0.bbab;
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
    
    out0 = in0.bbab;
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
    
    out0 = in0.x;
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


void main()
{
    
    out0 = in0.x;
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
    
    out0 = in0.x;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.xx;
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
layout(location = 0) flat in ivec2 in0;
layout(binding = 0, std140) uniform Reference
{
	ivec2 out0;
} ref;
ivec2 out0;


void main()
{
    
    out0 = in0.xx;
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
    
    out0 = in0.xx;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.xy;
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
    
    out0 = in0.xy;
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
    
    out0 = in0.xy;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.yx;
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
    
    out0 = in0.yx;
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
    
    out0 = in0.yx;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec2 in0;
layout(location = 0) flat out ivec3 out0;


void main()
{
    
    out0 = in0.yxy;
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
layout(location = 0) flat in ivec2 in0;
layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;
ivec3 out0;


void main()
{
    
    out0 = in0.yxy;
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
    
    out0 = in0.yxy;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec2 in0;
layout(location = 0) flat out ivec4 out0;


void main()
{
    
    out0 = in0.xyxx;
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
layout(location = 0) flat in ivec2 in0;
layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
ivec4 out0;


void main()
{
    
    out0 = in0.xyxx;
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
    
    out0 = in0.xyxx;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec2 in0;
layout(location = 0) flat out ivec4 out0;


void main()
{
    
    out0 = in0.yyyy;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec2 in0;
layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
ivec4 out0;


void main()
{
    
    out0 = in0.yyyy;
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
    
    out0 = in0.yyyy;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.s;
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
    
    out0 = in0.s;
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
    
    out0 = in0.s;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.ss;
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
    
    out0 = in0.ss;
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
    
    out0 = in0.ss;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.st;
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
    
    out0 = in0.st;
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
    
    out0 = in0.st;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.ts;
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
    
    out0 = in0.ts;
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
    
    out0 = in0.ts;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec2 in0;
layout(location = 0) flat out ivec3 out0;


void main()
{
    
    out0 = in0.tst;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec3 a, ivec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec2 in0;
layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;
ivec3 out0;


void main()
{
    
    out0 = in0.tst;
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
    
    out0 = in0.tst;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec2 in0;
layout(location = 0) flat out ivec4 out0;


void main()
{
    
    out0 = in0.stss;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec2 in0;
layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
ivec4 out0;


void main()
{
    
    out0 = in0.stss;
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
    
    out0 = in0.stss;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec2 in0;
layout(location = 0) flat out ivec4 out0;


void main()
{
    
    out0 = in0.tttt;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec2 in0;
layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
ivec4 out0;


void main()
{
    
    out0 = in0.tttt;
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
    
    out0 = in0.tttt;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.r;
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
    
    out0 = in0.r;
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
    
    out0 = in0.r;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.rr;
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
    
    out0 = in0.rr;
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
    
    out0 = in0.rr;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.rg;
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
    
    out0 = in0.rg;
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
    
    out0 = in0.rg;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.gr;
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
    
    out0 = in0.gr;
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
    
    out0 = in0.gr;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec2 in0;
layout(location = 0) flat out ivec3 out0;


void main()
{
    
    out0 = in0.grg;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec3 a, ivec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec2 in0;
layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;
ivec3 out0;


void main()
{
    
    out0 = in0.grg;
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
    
    out0 = in0.grg;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec2 in0;
layout(location = 0) flat out ivec4 out0;


void main()
{
    
    out0 = in0.rgrr;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec2 in0;
layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
ivec4 out0;


void main()
{
    
    out0 = in0.rgrr;
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
    
    out0 = in0.rgrr;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec2 in0;
layout(location = 0) flat out ivec4 out0;


void main()
{
    
    out0 = in0.gggg;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec2 in0;
layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
ivec4 out0;


void main()
{
    
    out0 = in0.gggg;
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
    
    out0 = in0.gggg;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.x;
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


void main()
{
    
    out0 = in0.x;
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
    
    out0 = in0.x;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.z;
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
    
    out0 = in0.z;
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
    
    out0 = in0.z;
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
    
    out0 = in0.xz;
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
    
    out0 = in0.xz;
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
    
    out0 = in0.xz;
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
    
    out0 = in0.zz;
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
    
    out0 = in0.zz;
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
    
    out0 = in0.zz;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.xyz;
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
    
    out0 = in0.xyz;
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
    
    out0 = in0.xyz;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.zyx;
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
    
    out0 = in0.zyx;
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
    
    out0 = in0.zyx;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.xxx;
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
    
    out0 = in0.xxx;
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
    
    out0 = in0.xxx;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.zzz;
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
    
    out0 = in0.zzz;
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
    
    out0 = in0.zzz;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.zzy;
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
    
    out0 = in0.zzy;
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
    
    out0 = in0.zzy;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.yxy;
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
    
    out0 = in0.yxy;
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
    
    out0 = in0.yxy;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.xzx;
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
    
    out0 = in0.xzx;
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
    
    out0 = in0.xzx;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec3 in0;
layout(location = 0) flat out ivec4 out0;


void main()
{
    
    out0 = in0.xyyx;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec3 in0;
layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
ivec4 out0;


void main()
{
    
    out0 = in0.xyyx;
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
    
    out0 = in0.xyyx;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec3 in0;
layout(location = 0) flat out ivec4 out0;


void main()
{
    
    out0 = in0.zzzz;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec3 in0;
layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
ivec4 out0;


void main()
{
    
    out0 = in0.zzzz;
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
    
    out0 = in0.zzzz;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.s;
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
    
    out0 = in0.s;
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
    
    out0 = in0.s;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.p;
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
    
    out0 = in0.p;
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
    
    out0 = in0.p;
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
    
    out0 = in0.sp;
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
    
    out0 = in0.sp;
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
    
    out0 = in0.sp;
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
    
    out0 = in0.pp;
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
    
    out0 = in0.pp;
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
    
    out0 = in0.pp;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.stp;
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
    
    out0 = in0.stp;
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
    
    out0 = in0.stp;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.pts;
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
    
    out0 = in0.pts;
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
    
    out0 = in0.pts;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.sss;
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
    
    out0 = in0.sss;
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
    
    out0 = in0.sss;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.ppp;
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
    
    out0 = in0.ppp;
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
    
    out0 = in0.ppp;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.ppt;
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
    
    out0 = in0.ppt;
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
    
    out0 = in0.ppt;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.tst;
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
    
    out0 = in0.tst;
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
    
    out0 = in0.tst;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.sps;
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
    
    out0 = in0.sps;
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
    
    out0 = in0.sps;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec3 in0;
layout(location = 0) flat out ivec4 out0;


void main()
{
    
    out0 = in0.stts;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec3 in0;
layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
ivec4 out0;


void main()
{
    
    out0 = in0.stts;
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
    
    out0 = in0.stts;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec3 in0;
layout(location = 0) flat out ivec4 out0;


void main()
{
    
    out0 = in0.pppp;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec3 in0;
layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
ivec4 out0;


void main()
{
    
    out0 = in0.pppp;
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
    
    out0 = in0.pppp;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.r;
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
    
    out0 = in0.r;
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
    
    out0 = in0.r;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.b;
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
    
    out0 = in0.b;
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
    
    out0 = in0.b;
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
    
    out0 = in0.rb;
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
    
    out0 = in0.rb;
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
    
    out0 = in0.rb;
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
    
    out0 = in0.bb;
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
    
    out0 = in0.bb;
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
    
    out0 = in0.bb;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.rgb;
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
    
    out0 = in0.rgb;
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
    
    out0 = in0.rgb;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.bgr;
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
    
    out0 = in0.bgr;
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
    
    out0 = in0.bgr;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.rrr;
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
    
    out0 = in0.rrr;
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
    
    out0 = in0.rrr;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.bbb;
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
    
    out0 = in0.bbb;
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
    
    out0 = in0.bbb;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.bbg;
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
    
    out0 = in0.bbg;
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
    
    out0 = in0.bbg;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.grg;
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
    
    out0 = in0.grg;
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
    
    out0 = in0.grg;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.rbr;
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
    
    out0 = in0.rbr;
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
    
    out0 = in0.rbr;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec3 in0;
layout(location = 0) flat out ivec4 out0;


void main()
{
    
    out0 = in0.rggr;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec3 in0;
layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
ivec4 out0;


void main()
{
    
    out0 = in0.rggr;
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
    
    out0 = in0.rggr;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec3 in0;
layout(location = 0) flat out ivec4 out0;


void main()
{
    
    out0 = in0.bbbb;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec3 in0;
layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
ivec4 out0;


void main()
{
    
    out0 = in0.bbbb;
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
    
    out0 = in0.bbbb;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.x;
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


void main()
{
    
    out0 = in0.x;
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
    
    out0 = in0.x;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.w;
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
    
    out0 = in0.w;
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
    
    out0 = in0.w;
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
    
    out0 = in0.wx;
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
    
    out0 = in0.wx;
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
    
    out0 = in0.wx;
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
    
    out0 = in0.wz;
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
    
    out0 = in0.wz;
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
    
    out0 = in0.wz;
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
    
    out0 = in0.www;
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
    
    out0 = in0.www;
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
    
    out0 = in0.www;
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
    
    out0 = in0.yyw;
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
    
    out0 = in0.yyw;
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
    
    out0 = in0.yyw;
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
    
    out0 = in0.wzy;
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
    
    out0 = in0.wzy;
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
    
    out0 = in0.wzy;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.xyzw;
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
    
    out0 = in0.xyzw;
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
    
    out0 = in0.xyzw;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.wzyx;
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
    
    out0 = in0.wzyx;
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
    
    out0 = in0.wzyx;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.xxxx;
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
    
    out0 = in0.xxxx;
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
    
    out0 = in0.xxxx;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.yyyy;
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
    
    out0 = in0.yyyy;
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
    
    out0 = in0.yyyy;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.wwww;
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
    
    out0 = in0.wwww;
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
    
    out0 = in0.wwww;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.wzzw;
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
    
    out0 = in0.wzzw;
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
    
    out0 = in0.wzzw;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.wwwy;
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
    
    out0 = in0.wwwy;
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
    
    out0 = in0.wwwy;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.xyxx;
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
    
    out0 = in0.xyxx;
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
    
    out0 = in0.xyxx;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.zzwz;
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
    
    out0 = in0.zzwz;
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
    
    out0 = in0.zzwz;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.s;
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
    
    out0 = in0.s;
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
    
    out0 = in0.s;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.q;
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
    
    out0 = in0.q;
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
    
    out0 = in0.q;
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
    
    out0 = in0.qs;
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
    
    out0 = in0.qs;
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
    
    out0 = in0.qs;
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
    
    out0 = in0.qp;
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
    
    out0 = in0.qp;
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
    
    out0 = in0.qp;
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
    
    out0 = in0.qqq;
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
    
    out0 = in0.qqq;
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
    
    out0 = in0.qqq;
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
    
    out0 = in0.ttq;
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
    
    out0 = in0.ttq;
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
    
    out0 = in0.ttq;
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
    
    out0 = in0.qpt;
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
    
    out0 = in0.qpt;
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
    
    out0 = in0.qpt;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.stpq;
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
    
    out0 = in0.stpq;
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
    
    out0 = in0.stpq;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.qpts;
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
    
    out0 = in0.qpts;
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
    
    out0 = in0.qpts;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.ssss;
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
    
    out0 = in0.ssss;
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
    
    out0 = in0.ssss;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.tttt;
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
    
    out0 = in0.tttt;
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
    
    out0 = in0.tttt;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.qqqq;
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
    
    out0 = in0.qqqq;
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
    
    out0 = in0.qqqq;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.qppq;
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
    
    out0 = in0.qppq;
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
    
    out0 = in0.qppq;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.qqqt;
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
    
    out0 = in0.qqqt;
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
    
    out0 = in0.qqqt;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.stss;
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
    
    out0 = in0.stss;
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
    
    out0 = in0.stss;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.ppqp;
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
    
    out0 = in0.ppqp;
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
    
    out0 = in0.ppqp;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.r;
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
    
    out0 = in0.r;
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
    
    out0 = in0.r;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.a;
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
    
    out0 = in0.a;
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
    
    out0 = in0.a;
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
    
    out0 = in0.ar;
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
    
    out0 = in0.ar;
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
    
    out0 = in0.ar;
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
    
    out0 = in0.ab;
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
    
    out0 = in0.ab;
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
    
    out0 = in0.ab;
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
    
    out0 = in0.aaa;
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
    
    out0 = in0.aaa;
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
    
    out0 = in0.aaa;
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
    
    out0 = in0.gga;
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
    
    out0 = in0.gga;
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
    
    out0 = in0.gga;
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
    
    out0 = in0.abg;
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
    
    out0 = in0.abg;
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
    
    out0 = in0.abg;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.rgba;
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
    
    out0 = in0.rgba;
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
    
    out0 = in0.rgba;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.abgr;
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
    
    out0 = in0.abgr;
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
    
    out0 = in0.abgr;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.rrrr;
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
    
    out0 = in0.rrrr;
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
    
    out0 = in0.rrrr;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.gggg;
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
    
    out0 = in0.gggg;
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
    
    out0 = in0.gggg;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.aaaa;
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
    
    out0 = in0.aaaa;
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
    
    out0 = in0.aaaa;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.abba;
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
    
    out0 = in0.abba;
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
    
    out0 = in0.abba;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.aaag;
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
    
    out0 = in0.aaag;
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
    
    out0 = in0.aaag;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.rgrr;
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
    
    out0 = in0.rgrr;
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
    
    out0 = in0.rgrr;
    bool RES = isOk(out0, ref.out0);
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
    
    out0 = in0.bbab;
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
    
    out0 = in0.bbab;
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
    
    out0 = in0.bbab;
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

    out0 = in0.x;
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


void main()
{
    bvec2 in0 = bvec2(v_in0);

    out0 = in0.x;
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
    
    out0 = in0.x;
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

    out0 = in0.xx;
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
layout(location = 0) flat in uvec2 v_in0;
layout(binding = 0, std140) uniform Reference
{
	bvec2 out0;
} ref;
bvec2 out0;


void main()
{
    bvec2 in0 = bvec2(v_in0);

    out0 = in0.xx;
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
    
    out0 = in0.xx;
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

    out0 = in0.xy;
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

    out0 = in0.xy;
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
    
    out0 = in0.xy;
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

    out0 = in0.yx;
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

    out0 = in0.yx;
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
    
    out0 = in0.yx;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec2 a_in0;
layout(location = 0) flat out uvec3 v_out0;
bvec3 out0;


void main()
{
    bvec2 in0 = bvec2(a_in0);

    out0 = in0.yxy;
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
layout(location = 0) flat in uvec2 v_in0;
layout(binding = 0, std140) uniform Reference
{
	bvec3 out0;
} ref;
bvec3 out0;


void main()
{
    bvec2 in0 = bvec2(v_in0);

    out0 = in0.yxy;
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
    
    out0 = in0.yxy;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec2 a_in0;
layout(location = 0) flat out uvec4 v_out0;
bvec4 out0;


void main()
{
    bvec2 in0 = bvec2(a_in0);

    out0 = in0.xyxx;
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
layout(location = 0) flat in uvec2 v_in0;
layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
bvec4 out0;


void main()
{
    bvec2 in0 = bvec2(v_in0);

    out0 = in0.xyxx;
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
    
    out0 = in0.xyxx;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec2 a_in0;
layout(location = 0) flat out uvec4 v_out0;
bvec4 out0;


void main()
{
    bvec2 in0 = bvec2(a_in0);

    out0 = in0.yyyy;
    gl_Position = dEQP_Position;
v_out0 = uvec4(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec2 v_in0;
layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
bvec4 out0;


void main()
{
    bvec2 in0 = bvec2(v_in0);

    out0 = in0.yyyy;
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
    
    out0 = in0.yyyy;
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

    out0 = in0.s;
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

    out0 = in0.s;
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
    
    out0 = in0.s;
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

    out0 = in0.ss;
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

    out0 = in0.ss;
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
    
    out0 = in0.ss;
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

    out0 = in0.st;
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

    out0 = in0.st;
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
    
    out0 = in0.st;
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

    out0 = in0.ts;
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

    out0 = in0.ts;
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
    
    out0 = in0.ts;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec2 a_in0;
layout(location = 0) flat out uvec3 v_out0;
bvec3 out0;


void main()
{
    bvec2 in0 = bvec2(a_in0);

    out0 = in0.tst;
    gl_Position = dEQP_Position;
v_out0 = uvec3(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec3 a, bvec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec2 v_in0;
layout(binding = 0, std140) uniform Reference
{
	bvec3 out0;
} ref;
bvec3 out0;


void main()
{
    bvec2 in0 = bvec2(v_in0);

    out0 = in0.tst;
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
    
    out0 = in0.tst;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec2 a_in0;
layout(location = 0) flat out uvec4 v_out0;
bvec4 out0;


void main()
{
    bvec2 in0 = bvec2(a_in0);

    out0 = in0.stss;
    gl_Position = dEQP_Position;
v_out0 = uvec4(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec2 v_in0;
layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
bvec4 out0;


void main()
{
    bvec2 in0 = bvec2(v_in0);

    out0 = in0.stss;
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
    
    out0 = in0.stss;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec2 a_in0;
layout(location = 0) flat out uvec4 v_out0;
bvec4 out0;


void main()
{
    bvec2 in0 = bvec2(a_in0);

    out0 = in0.tttt;
    gl_Position = dEQP_Position;
v_out0 = uvec4(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec2 v_in0;
layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
bvec4 out0;


void main()
{
    bvec2 in0 = bvec2(v_in0);

    out0 = in0.tttt;
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
    
    out0 = in0.tttt;
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

    out0 = in0.r;
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

    out0 = in0.r;
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
    
    out0 = in0.r;
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

    out0 = in0.rr;
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

    out0 = in0.rr;
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
    
    out0 = in0.rr;
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

    out0 = in0.rg;
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

    out0 = in0.rg;
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
    
    out0 = in0.rg;
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

    out0 = in0.gr;
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

    out0 = in0.gr;
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
    
    out0 = in0.gr;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec2 a_in0;
layout(location = 0) flat out uvec3 v_out0;
bvec3 out0;


void main()
{
    bvec2 in0 = bvec2(a_in0);

    out0 = in0.grg;
    gl_Position = dEQP_Position;
v_out0 = uvec3(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec3 a, bvec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec2 v_in0;
layout(binding = 0, std140) uniform Reference
{
	bvec3 out0;
} ref;
bvec3 out0;


void main()
{
    bvec2 in0 = bvec2(v_in0);

    out0 = in0.grg;
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
    
    out0 = in0.grg;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec2 a_in0;
layout(location = 0) flat out uvec4 v_out0;
bvec4 out0;


void main()
{
    bvec2 in0 = bvec2(a_in0);

    out0 = in0.rgrr;
    gl_Position = dEQP_Position;
v_out0 = uvec4(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec2 v_in0;
layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
bvec4 out0;


void main()
{
    bvec2 in0 = bvec2(v_in0);

    out0 = in0.rgrr;
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
    
    out0 = in0.rgrr;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec2 a_in0;
layout(location = 0) flat out uvec4 v_out0;
bvec4 out0;


void main()
{
    bvec2 in0 = bvec2(a_in0);

    out0 = in0.gggg;
    gl_Position = dEQP_Position;
v_out0 = uvec4(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec2 v_in0;
layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
bvec4 out0;


void main()
{
    bvec2 in0 = bvec2(v_in0);

    out0 = in0.gggg;
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
    
    out0 = in0.gggg;
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

    out0 = in0.x;
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


void main()
{
    bvec3 in0 = bvec3(v_in0);

    out0 = in0.x;
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
    
    out0 = in0.x;
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

    out0 = in0.z;
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

    out0 = in0.z;
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
    
    out0 = in0.z;
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

    out0 = in0.xz;
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

    out0 = in0.xz;
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
    
    out0 = in0.xz;
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

    out0 = in0.zz;
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

    out0 = in0.zz;
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
    
    out0 = in0.zz;
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

    out0 = in0.xyz;
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

    out0 = in0.xyz;
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
    
    out0 = in0.xyz;
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

    out0 = in0.zyx;
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

    out0 = in0.zyx;
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
    
    out0 = in0.zyx;
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

    out0 = in0.xxx;
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

    out0 = in0.xxx;
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
    
    out0 = in0.xxx;
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

    out0 = in0.zzz;
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

    out0 = in0.zzz;
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
    
    out0 = in0.zzz;
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

    out0 = in0.zzy;
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

    out0 = in0.zzy;
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
    
    out0 = in0.zzy;
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

    out0 = in0.yxy;
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

    out0 = in0.yxy;
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
    
    out0 = in0.yxy;
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

    out0 = in0.xzx;
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

    out0 = in0.xzx;
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
    
    out0 = in0.xzx;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 a_in0;
layout(location = 0) flat out uvec4 v_out0;
bvec4 out0;


void main()
{
    bvec3 in0 = bvec3(a_in0);

    out0 = in0.xyyx;
    gl_Position = dEQP_Position;
v_out0 = uvec4(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec3 v_in0;
layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
bvec4 out0;


void main()
{
    bvec3 in0 = bvec3(v_in0);

    out0 = in0.xyyx;
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
    
    out0 = in0.xyyx;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 a_in0;
layout(location = 0) flat out uvec4 v_out0;
bvec4 out0;


void main()
{
    bvec3 in0 = bvec3(a_in0);

    out0 = in0.zzzz;
    gl_Position = dEQP_Position;
v_out0 = uvec4(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec3 v_in0;
layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
bvec4 out0;


void main()
{
    bvec3 in0 = bvec3(v_in0);

    out0 = in0.zzzz;
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
    
    out0 = in0.zzzz;
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

    out0 = in0.s;
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

    out0 = in0.s;
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
    
    out0 = in0.s;
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

    out0 = in0.p;
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

    out0 = in0.p;
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
    
    out0 = in0.p;
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

    out0 = in0.sp;
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

    out0 = in0.sp;
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
    
    out0 = in0.sp;
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

    out0 = in0.pp;
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

    out0 = in0.pp;
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
    
    out0 = in0.pp;
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

    out0 = in0.stp;
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

    out0 = in0.stp;
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
    
    out0 = in0.stp;
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

    out0 = in0.pts;
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

    out0 = in0.pts;
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
    
    out0 = in0.pts;
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

    out0 = in0.sss;
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

    out0 = in0.sss;
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
    
    out0 = in0.sss;
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

    out0 = in0.ppp;
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

    out0 = in0.ppp;
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
    
    out0 = in0.ppp;
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

    out0 = in0.ppt;
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

    out0 = in0.ppt;
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
    
    out0 = in0.ppt;
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

    out0 = in0.tst;
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

    out0 = in0.tst;
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
    
    out0 = in0.tst;
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

    out0 = in0.sps;
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

    out0 = in0.sps;
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
    
    out0 = in0.sps;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 a_in0;
layout(location = 0) flat out uvec4 v_out0;
bvec4 out0;


void main()
{
    bvec3 in0 = bvec3(a_in0);

    out0 = in0.stts;
    gl_Position = dEQP_Position;
v_out0 = uvec4(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec3 v_in0;
layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
bvec4 out0;


void main()
{
    bvec3 in0 = bvec3(v_in0);

    out0 = in0.stts;
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
    
    out0 = in0.stts;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 a_in0;
layout(location = 0) flat out uvec4 v_out0;
bvec4 out0;


void main()
{
    bvec3 in0 = bvec3(a_in0);

    out0 = in0.pppp;
    gl_Position = dEQP_Position;
v_out0 = uvec4(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec3 v_in0;
layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
bvec4 out0;


void main()
{
    bvec3 in0 = bvec3(v_in0);

    out0 = in0.pppp;
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
    
    out0 = in0.pppp;
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

    out0 = in0.r;
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

    out0 = in0.r;
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
    
    out0 = in0.r;
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

    out0 = in0.b;
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

    out0 = in0.b;
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
    
    out0 = in0.b;
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

    out0 = in0.rb;
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

    out0 = in0.rb;
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
    
    out0 = in0.rb;
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

    out0 = in0.bb;
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

    out0 = in0.bb;
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
    
    out0 = in0.bb;
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

    out0 = in0.rgb;
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

    out0 = in0.rgb;
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
    
    out0 = in0.rgb;
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

    out0 = in0.bgr;
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

    out0 = in0.bgr;
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
    
    out0 = in0.bgr;
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

    out0 = in0.rrr;
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

    out0 = in0.rrr;
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
    
    out0 = in0.rrr;
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

    out0 = in0.bbb;
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

    out0 = in0.bbb;
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
    
    out0 = in0.bbb;
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

    out0 = in0.bbg;
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

    out0 = in0.bbg;
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
    
    out0 = in0.bbg;
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

    out0 = in0.grg;
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

    out0 = in0.grg;
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
    
    out0 = in0.grg;
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

    out0 = in0.rbr;
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

    out0 = in0.rbr;
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
    
    out0 = in0.rbr;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 a_in0;
layout(location = 0) flat out uvec4 v_out0;
bvec4 out0;


void main()
{
    bvec3 in0 = bvec3(a_in0);

    out0 = in0.rggr;
    gl_Position = dEQP_Position;
v_out0 = uvec4(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec3 v_in0;
layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
bvec4 out0;


void main()
{
    bvec3 in0 = bvec3(v_in0);

    out0 = in0.rggr;
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
    
    out0 = in0.rggr;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 a_in0;
layout(location = 0) flat out uvec4 v_out0;
bvec4 out0;


void main()
{
    bvec3 in0 = bvec3(a_in0);

    out0 = in0.bbbb;
    gl_Position = dEQP_Position;
v_out0 = uvec4(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec3 v_in0;
layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
bvec4 out0;


void main()
{
    bvec3 in0 = bvec3(v_in0);

    out0 = in0.bbbb;
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
    
    out0 = in0.bbbb;
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

    out0 = in0.x;
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


void main()
{
    bvec4 in0 = bvec4(v_in0);

    out0 = in0.x;
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
    
    out0 = in0.x;
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

    out0 = in0.w;
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

    out0 = in0.w;
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
    
    out0 = in0.w;
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

    out0 = in0.wx;
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

    out0 = in0.wx;
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
    
    out0 = in0.wx;
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

    out0 = in0.wz;
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

    out0 = in0.wz;
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
    
    out0 = in0.wz;
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

    out0 = in0.www;
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

    out0 = in0.www;
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
    
    out0 = in0.www;
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

    out0 = in0.yyw;
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

    out0 = in0.yyw;
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
    
    out0 = in0.yyw;
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

    out0 = in0.wzy;
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

    out0 = in0.wzy;
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
    
    out0 = in0.wzy;
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

    out0 = in0.xyzw;
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

    out0 = in0.xyzw;
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
    
    out0 = in0.xyzw;
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

    out0 = in0.wzyx;
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

    out0 = in0.wzyx;
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
    
    out0 = in0.wzyx;
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

    out0 = in0.xxxx;
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

    out0 = in0.xxxx;
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
    
    out0 = in0.xxxx;
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

    out0 = in0.yyyy;
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

    out0 = in0.yyyy;
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
    
    out0 = in0.yyyy;
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

    out0 = in0.wwww;
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

    out0 = in0.wwww;
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
    
    out0 = in0.wwww;
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

    out0 = in0.wzzw;
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

    out0 = in0.wzzw;
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
    
    out0 = in0.wzzw;
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

    out0 = in0.wwwy;
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

    out0 = in0.wwwy;
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
    
    out0 = in0.wwwy;
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

    out0 = in0.xyxx;
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

    out0 = in0.xyxx;
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
    
    out0 = in0.xyxx;
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

    out0 = in0.zzwz;
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

    out0 = in0.zzwz;
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
    
    out0 = in0.zzwz;
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

    out0 = in0.s;
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

    out0 = in0.s;
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
    
    out0 = in0.s;
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

    out0 = in0.q;
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

    out0 = in0.q;
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
    
    out0 = in0.q;
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

    out0 = in0.qs;
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

    out0 = in0.qs;
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
    
    out0 = in0.qs;
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

    out0 = in0.qp;
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

    out0 = in0.qp;
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
    
    out0 = in0.qp;
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

    out0 = in0.qqq;
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

    out0 = in0.qqq;
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
    
    out0 = in0.qqq;
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

    out0 = in0.ttq;
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

    out0 = in0.ttq;
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
    
    out0 = in0.ttq;
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

    out0 = in0.qpt;
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

    out0 = in0.qpt;
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
    
    out0 = in0.qpt;
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

    out0 = in0.stpq;
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

    out0 = in0.stpq;
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
    
    out0 = in0.stpq;
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

    out0 = in0.qpts;
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

    out0 = in0.qpts;
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
    
    out0 = in0.qpts;
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

    out0 = in0.ssss;
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

    out0 = in0.ssss;
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
    
    out0 = in0.ssss;
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

    out0 = in0.tttt;
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

    out0 = in0.tttt;
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
    
    out0 = in0.tttt;
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

    out0 = in0.qqqq;
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

    out0 = in0.qqqq;
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
    
    out0 = in0.qqqq;
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

    out0 = in0.qppq;
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

    out0 = in0.qppq;
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
    
    out0 = in0.qppq;
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

    out0 = in0.qqqt;
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

    out0 = in0.qqqt;
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
    
    out0 = in0.qqqt;
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

    out0 = in0.stss;
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

    out0 = in0.stss;
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
    
    out0 = in0.stss;
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

    out0 = in0.ppqp;
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

    out0 = in0.ppqp;
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
    
    out0 = in0.ppqp;
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

    out0 = in0.r;
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

    out0 = in0.r;
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
    
    out0 = in0.r;
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

    out0 = in0.a;
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

    out0 = in0.a;
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
    
    out0 = in0.a;
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

    out0 = in0.ar;
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

    out0 = in0.ar;
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
    
    out0 = in0.ar;
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

    out0 = in0.ab;
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

    out0 = in0.ab;
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
    
    out0 = in0.ab;
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

    out0 = in0.aaa;
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

    out0 = in0.aaa;
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
    
    out0 = in0.aaa;
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

    out0 = in0.gga;
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

    out0 = in0.gga;
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
    
    out0 = in0.gga;
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

    out0 = in0.abg;
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

    out0 = in0.abg;
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
    
    out0 = in0.abg;
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

    out0 = in0.rgba;
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

    out0 = in0.rgba;
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
    
    out0 = in0.rgba;
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

    out0 = in0.abgr;
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

    out0 = in0.abgr;
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
    
    out0 = in0.abgr;
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

    out0 = in0.rrrr;
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

    out0 = in0.rrrr;
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
    
    out0 = in0.rrrr;
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

    out0 = in0.gggg;
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

    out0 = in0.gggg;
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
    
    out0 = in0.gggg;
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

    out0 = in0.aaaa;
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

    out0 = in0.aaaa;
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
    
    out0 = in0.aaaa;
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

    out0 = in0.abba;
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

    out0 = in0.abba;
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
    
    out0 = in0.abba;
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

    out0 = in0.aaag;
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

    out0 = in0.aaag;
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
    
    out0 = in0.aaag;
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

    out0 = in0.rgrr;
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

    out0 = in0.rgrr;
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
    
    out0 = in0.rgrr;
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

    out0 = in0.bbab;
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

    out0 = in0.bbab;
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
    
    out0 = in0.bbab;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
