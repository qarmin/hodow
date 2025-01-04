#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;

layout(location = 0) out mediump float var;
void main()
{
    gl_Position = dEQP_Position;

}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;

void main()
{
    dEQP_FragColor = vec4(1.0);
}
#version 310 es
layout(location = 0) in mediump float var;
layout(location = 0) out mediump vec4 dEQP_FragColor;

void main()
{
    dEQP_FragColor = vec4(1.0);
}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;

layout(location = 0) out mediump vec4 var;
void main()
{
    var.x = 0.0;
    var.y = 0.0;
    var.z = 0.0;
    var.w = 0.0;
    gl_Position = dEQP_Position;

}
#version 310 es
layout(location = 0) in mediump vec3 var;
layout(location = 0) out mediump vec4 dEQP_FragColor;

void main()
{
    dEQP_FragColor = vec4(1.0 + var.x + var.y + var.z);
}
#version 310 es
layout(location = 0) in mediump vec2 var;
layout(location = 0) out mediump vec4 dEQP_FragColor;

void main()
{
    dEQP_FragColor = vec4(1.0 + var.x + var.y);
}
#version 310 es
layout(location = 0) in mediump float var;
layout(location = 0) out mediump vec4 dEQP_FragColor;

void main()
{
    dEQP_FragColor = vec4(1.0 + var);
}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;

layout(location = 0) out mediump vec3 var;
void main()
{
    var.x = 0.0;
    var.y = 0.0;
    var.z = 0.0;
    gl_Position = dEQP_Position;

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;

layout(location = 0) out mediump vec2 var;
void main()
{
    var.x = 0.0;
    var.y = 0.0;
    gl_Position = dEQP_Position;

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;

layout(location = 0) out mediump ivec4 var;
void main()
{
    var.x = 0;
    var.y = 0;
    var.z = 0;
    var.w = 0;
    gl_Position = dEQP_Position;

}
#version 310 es
layout(location = 0) in mediump flat ivec3 var;
layout(location = 0) out mediump vec4 dEQP_FragColor;

void main()
{
    if (var.x + var.y + var.z == 0)
        dEQP_FragColor = vec4(1.0);
    else
        dEQP_FragColor = vec4(0.0);
}
#version 310 es
layout(location = 0) in mediump flat ivec2 var;
layout(location = 0) out mediump vec4 dEQP_FragColor;

void main()
{
    if (var.x + var.y == 0)
        dEQP_FragColor = vec4(1.0);
    else
        dEQP_FragColor = vec4(0.0);
}
#version 310 es
layout(location = 0) in mediump flat int var;
layout(location = 0) out mediump vec4 dEQP_FragColor;

void main()
{
    if (var == 0)
        dEQP_FragColor = vec4(1.0);
    else
        dEQP_FragColor = vec4(0.0);
}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;

layout(location = 0) out mediump ivec3 var;
void main()
{
    var.x = 0;
    var.y = 0;
    var.z = 0;
    gl_Position = dEQP_Position;

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;

layout(location = 0) out mediump ivec2 var;
void main()
{
    var.x = 0;
    var.y = 0;
    gl_Position = dEQP_Position;

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(binding = 1, std140) uniform Uniforms
{
	bool u_false;
};

layout(location = 0) out mediump float var;
void main()
{
    gl_Position = dEQP_Position;

}
#version 310 es
layout(location = 0) in mediump float var;
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(binding = 1, std140) uniform Uniforms
{
	bool u_false;
};

void main()
{
    if (u_false)
        dEQP_FragColor = vec4(var);
    else
        dEQP_FragColor = vec4(1.0);
}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(binding = 1, std140) uniform Uniforms
{
	bool u_false;
};

layout(location = 0) out mediump float var;
void main()
{
    if (u_false)
        var = 1.0;
    gl_Position = dEQP_Position;

}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(binding = 1, std140) uniform Uniforms
{
	bool u_false;
};

void main()
{
    dEQP_FragColor = vec4(1.0);
}
#version 310 es
layout(location = 0) in mediump float var;
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(binding = 1, std140) uniform Uniforms
{
	bool u_false;
};

void main()
{
    dEQP_FragColor = vec4(1.0);
}
#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(binding = 1, std140) uniform Uniforms
{
	bool u_false;
};

layout(location = 0) in mediump float var;
void main()
{
    if (u_false)
        dEQP_FragColor = vec4(var);
    else
        dEQP_FragColor = vec4(1.0);
}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;

layout(location = 0) smooth out mediump float var;
void main()
{
    var = in0;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
float out0;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;

layout(location = 0) centroid in mediump float var;
void main()
{
    out0 = var;
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 2) in float in1;

layout(location = 0) out highp float vtxVarB;
layout(location = 2) out highp float vtxVarA;
void main()
{
    vtxVarA = in0;
    vtxVarB = in1;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
float out0;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;

layout(location = 2) in highp float fragVarA;
layout(location = 0) in highp float fragVarB;
void main()
{
    out0 = fragVarA - fragVarB;
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 2) in float in1;

layout(location = 0) out highp float varA;
layout(location = 2) out highp float varB;
void main()
{
    varA = in0;
    varB = in1;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
float out0;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;

layout(location = 2) in highp float varA;
layout(location = 0) in highp float varB;
void main()
{
    out0 = varB - varA;
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;

layout(location = 0) out float var;
void main()
{
    var = in0;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
float out0;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;

layout(location = 0) in float var;
void main()
{
    out0 = var;
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 in0;

layout(location = 0) out vec2 var;
void main()
{
    var = in0;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (vec2 a, vec2 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
vec2 out0;
layout(binding = 0, std140) uniform Reference
{
	vec2 out0;
} ref;

layout(location = 0) in vec2 var;
void main()
{
    out0 = var;
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;

layout(location = 0) out vec3 var;
void main()
{
    var = in0;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
vec3 out0;
layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;

layout(location = 0) in vec3 var;
void main()
{
    out0 = var;
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec4 in0;

layout(location = 0) out vec4 var;
void main()
{
    var = in0;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
vec4 out0;
layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;

layout(location = 0) in vec4 var;
void main()
{
    out0 = var;
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat2 in0;

layout(location = 0) out mat2 var;
void main()
{
    var = in0;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (mat2 a, mat2 b, float eps) { vec2 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
mat2 out0;
layout(binding = 0, std140) uniform Reference
{
	mat2 out0;
} ref;

layout(location = 0) in mat2 var;
void main()
{
    out0 = var;
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat2x3 in0;

layout(location = 0) out mat2x3 var;
void main()
{
    var = in0;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (mat2x3 a, mat2x3 b, float eps) { vec3 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
mat2x3 out0;
layout(binding = 0, std140) uniform Reference
{
	mat2x3 out0;
} ref;

layout(location = 0) in mat2x3 var;
void main()
{
    out0 = var;
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat2x4 in0;

layout(location = 0) out mat2x4 var;
void main()
{
    var = in0;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (mat2x4 a, mat2x4 b, float eps) { vec4 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
mat2x4 out0;
layout(binding = 0, std140) uniform Reference
{
	mat2x4 out0;
} ref;

layout(location = 0) in mat2x4 var;
void main()
{
    out0 = var;
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat3x2 in0;

layout(location = 0) out mat3x2 var;
void main()
{
    var = in0;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (mat3x2 a, mat3x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
mat3x2 out0;
layout(binding = 0, std140) uniform Reference
{
	mat3x2 out0;
} ref;

layout(location = 0) in mat3x2 var;
void main()
{
    out0 = var;
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat3 in0;

layout(location = 0) out mat3 var;
void main()
{
    var = in0;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (mat3 a, mat3 b, float eps) { vec3 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
mat3 out0;
layout(binding = 0, std140) uniform Reference
{
	mat3 out0;
} ref;

layout(location = 0) in mat3 var;
void main()
{
    out0 = var;
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat3x4 in0;

layout(location = 0) out mat3x4 var;
void main()
{
    var = in0;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (mat3x4 a, mat3x4 b, float eps) { vec4 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
mat3x4 out0;
layout(binding = 0, std140) uniform Reference
{
	mat3x4 out0;
} ref;

layout(location = 0) in mat3x4 var;
void main()
{
    out0 = var;
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat4x2 in0;

layout(location = 0) out mat4x2 var;
void main()
{
    var = in0;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (mat4x2 a, mat4x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
mat4x2 out0;
layout(binding = 0, std140) uniform Reference
{
	mat4x2 out0;
} ref;

layout(location = 0) in mat4x2 var;
void main()
{
    out0 = var;
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat4x3 in0;

layout(location = 0) out mat4x3 var;
void main()
{
    var = in0;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (mat4x3 a, mat4x3 b, float eps) { vec3 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
mat4x3 out0;
layout(binding = 0, std140) uniform Reference
{
	mat4x3 out0;
} ref;

layout(location = 0) in mat4x3 var;
void main()
{
    out0 = var;
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat4 in0;

layout(location = 0) out mat4 var;
void main()
{
    var = in0;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (mat4 a, mat4 b, float eps) { vec4 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
mat4 out0;
layout(binding = 0, std140) uniform Reference
{
	mat4 out0;
} ref;

layout(location = 0) in mat4 var;
void main()
{
    out0 = var;
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;

layout(location = 0) flat out mediump int var;
void main()
{
    
    var = in0;
    gl_Position = dEQP_Position;

}
#version 310 es
bool isOk (int a, int b)     { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
int out0;
layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;

layout(location = 0) flat in int var;
void main()
{
    out0 = var;
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec2 in0;

layout(location = 0) flat out mediump ivec2 var;
void main()
{
    
    var = in0;
    gl_Position = dEQP_Position;

}
#version 310 es
bool isOk (ivec2 a, ivec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
ivec2 out0;
layout(binding = 0, std140) uniform Reference
{
	ivec2 out0;
} ref;

layout(location = 0) flat in ivec2 var;
void main()
{
    out0 = var;
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec3 in0;

layout(location = 0) flat out mediump ivec3 var;
void main()
{
    
    var = in0;
    gl_Position = dEQP_Position;

}
#version 310 es
bool isOk (ivec3 a, ivec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
ivec3 out0;
layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;

layout(location = 0) flat in ivec3 var;
void main()
{
    out0 = var;
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec4 in0;

layout(location = 0) flat out mediump ivec4 var;
void main()
{
    
    var = in0;
    gl_Position = dEQP_Position;

}
#version 310 es
bool isOk (ivec4 a, ivec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
ivec4 out0;
layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;

layout(location = 0) flat in ivec4 var;
void main()
{
    out0 = var;
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint in0;

layout(location = 0) flat out mediump uint var;
void main()
{
    
    var = in0;
    gl_Position = dEQP_Position;

}
#version 310 es
bool isOk (uint a, uint b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
uint out0;
layout(binding = 0, std140) uniform Reference
{
	uint out0;
} ref;

layout(location = 0) flat in uint var;
void main()
{
    out0 = var;
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec2 in0;

layout(location = 0) flat out mediump uvec2 var;
void main()
{
    
    var = in0;
    gl_Position = dEQP_Position;

}
#version 310 es
bool isOk (uvec2 a, uvec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
uvec2 out0;
layout(binding = 0, std140) uniform Reference
{
	uvec2 out0;
} ref;

layout(location = 0) flat in uvec2 var;
void main()
{
    out0 = var;
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 in0;

layout(location = 0) flat out mediump uvec3 var;
void main()
{
    
    var = in0;
    gl_Position = dEQP_Position;

}
#version 310 es
bool isOk (uvec3 a, uvec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
uvec3 out0;
layout(binding = 0, std140) uniform Reference
{
	uvec3 out0;
} ref;

layout(location = 0) flat in uvec3 var;
void main()
{
    out0 = var;
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec4 in0;

layout(location = 0) flat out mediump uvec4 var;
void main()
{
    
    var = in0;
    gl_Position = dEQP_Position;

}
#version 310 es
bool isOk (uvec4 a, uvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
uvec4 out0;
layout(binding = 0, std140) uniform Reference
{
	uvec4 out0;
} ref;

layout(location = 0) flat in uvec4 var;
void main()
{
    out0 = var;
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;

struct S { mediump float a; };
layout(location = 0) out S var;
void main()
{
    var.a = in0;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
float out0;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;

struct S { mediump float a; };
layout(location = 0) in S var;
void main()
{
    out0 = var.a;
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 in0;

struct S { mediump vec2 a; };
layout(location = 0) out S var;
void main()
{
    var.a = in0;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (vec2 a, vec2 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
vec2 out0;
layout(binding = 0, std140) uniform Reference
{
	vec2 out0;
} ref;

struct S { mediump vec2 a; };
layout(location = 0) in S var;
void main()
{
    out0 = var.a;
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;

struct S { mediump vec3 a; };
layout(location = 0) out S var;
void main()
{
    var.a = in0;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
vec3 out0;
layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;

struct S { mediump vec3 a; };
layout(location = 0) in S var;
void main()
{
    out0 = var.a;
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec4 in0;

struct S { mediump vec4 a; };
layout(location = 0) out S var;
void main()
{
    var.a = in0;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
vec4 out0;
layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;

struct S { mediump vec4 a; };
layout(location = 0) in S var;
void main()
{
    out0 = var.a;
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat2 in0;

struct S { mediump mat2 a; };
layout(location = 0) out S var;
void main()
{
    var.a = in0;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (mat2 a, mat2 b, float eps) { vec2 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
mat2 out0;
layout(binding = 0, std140) uniform Reference
{
	mat2 out0;
} ref;

struct S { mediump mat2 a; };
layout(location = 0) in S var;
void main()
{
    out0 = var.a;
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat2x3 in0;

struct S { mediump mat2x3 a; };
layout(location = 0) out S var;
void main()
{
    var.a = in0;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (mat2x3 a, mat2x3 b, float eps) { vec3 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
mat2x3 out0;
layout(binding = 0, std140) uniform Reference
{
	mat2x3 out0;
} ref;

struct S { mediump mat2x3 a; };
layout(location = 0) in S var;
void main()
{
    out0 = var.a;
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat2x4 in0;

struct S { mediump mat2x4 a; };
layout(location = 0) out S var;
void main()
{
    var.a = in0;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (mat2x4 a, mat2x4 b, float eps) { vec4 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
mat2x4 out0;
layout(binding = 0, std140) uniform Reference
{
	mat2x4 out0;
} ref;

struct S { mediump mat2x4 a; };
layout(location = 0) in S var;
void main()
{
    out0 = var.a;
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat3x2 in0;

struct S { mediump mat3x2 a; };
layout(location = 0) out S var;
void main()
{
    var.a = in0;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (mat3x2 a, mat3x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
mat3x2 out0;
layout(binding = 0, std140) uniform Reference
{
	mat3x2 out0;
} ref;

struct S { mediump mat3x2 a; };
layout(location = 0) in S var;
void main()
{
    out0 = var.a;
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat3 in0;

struct S { mediump mat3 a; };
layout(location = 0) out S var;
void main()
{
    var.a = in0;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (mat3 a, mat3 b, float eps) { vec3 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
mat3 out0;
layout(binding = 0, std140) uniform Reference
{
	mat3 out0;
} ref;

struct S { mediump mat3 a; };
layout(location = 0) in S var;
void main()
{
    out0 = var.a;
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat3x4 in0;

struct S { mediump mat3x4 a; };
layout(location = 0) out S var;
void main()
{
    var.a = in0;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (mat3x4 a, mat3x4 b, float eps) { vec4 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
mat3x4 out0;
layout(binding = 0, std140) uniform Reference
{
	mat3x4 out0;
} ref;

struct S { mediump mat3x4 a; };
layout(location = 0) in S var;
void main()
{
    out0 = var.a;
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat4x2 in0;

struct S { mediump mat4x2 a; };
layout(location = 0) out S var;
void main()
{
    var.a = in0;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (mat4x2 a, mat4x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
mat4x2 out0;
layout(binding = 0, std140) uniform Reference
{
	mat4x2 out0;
} ref;

struct S { mediump mat4x2 a; };
layout(location = 0) in S var;
void main()
{
    out0 = var.a;
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat4x3 in0;

struct S { mediump mat4x3 a; };
layout(location = 0) out S var;
void main()
{
    var.a = in0;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (mat4x3 a, mat4x3 b, float eps) { vec3 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
mat4x3 out0;
layout(binding = 0, std140) uniform Reference
{
	mat4x3 out0;
} ref;

struct S { mediump mat4x3 a; };
layout(location = 0) in S var;
void main()
{
    out0 = var.a;
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat4 in0;

struct S { mediump mat4 a; };
layout(location = 0) out S var;
void main()
{
    var.a = in0;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (mat4 a, mat4 b, float eps) { vec4 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
mat4 out0;
layout(binding = 0, std140) uniform Reference
{
	mat4 out0;
} ref;

struct S { mediump mat4 a; };
layout(location = 0) in S var;
void main()
{
    out0 = var.a;
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;

struct S { mediump int a; };
layout(location = 0) flat out S var;
void main()
{
    
    var.a = in0;
    gl_Position = dEQP_Position;

}
#version 310 es
bool isOk (int a, int b)     { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
int out0;
layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;

struct S { mediump int a; };
layout(location = 0) flat in S var;
void main()
{
    out0 = var.a;
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec2 in0;

struct S { mediump ivec2 a; };
layout(location = 0) flat out S var;
void main()
{
    
    var.a = in0;
    gl_Position = dEQP_Position;

}
#version 310 es
bool isOk (ivec2 a, ivec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
ivec2 out0;
layout(binding = 0, std140) uniform Reference
{
	ivec2 out0;
} ref;

struct S { mediump ivec2 a; };
layout(location = 0) flat in S var;
void main()
{
    out0 = var.a;
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec3 in0;

struct S { mediump ivec3 a; };
layout(location = 0) flat out S var;
void main()
{
    
    var.a = in0;
    gl_Position = dEQP_Position;

}
#version 310 es
bool isOk (ivec3 a, ivec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
ivec3 out0;
layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;

struct S { mediump ivec3 a; };
layout(location = 0) flat in S var;
void main()
{
    out0 = var.a;
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec4 in0;

struct S { mediump ivec4 a; };
layout(location = 0) flat out S var;
void main()
{
    
    var.a = in0;
    gl_Position = dEQP_Position;

}
#version 310 es
bool isOk (ivec4 a, ivec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
ivec4 out0;
layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;

struct S { mediump ivec4 a; };
layout(location = 0) flat in S var;
void main()
{
    out0 = var.a;
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint in0;

struct S { mediump uint a; };
layout(location = 0) flat out S var;
void main()
{
    
    var.a = in0;
    gl_Position = dEQP_Position;

}
#version 310 es
bool isOk (uint a, uint b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
uint out0;
layout(binding = 0, std140) uniform Reference
{
	uint out0;
} ref;

struct S { mediump uint a; };
layout(location = 0) flat in S var;
void main()
{
    out0 = var.a;
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec2 in0;

struct S { mediump uvec2 a; };
layout(location = 0) flat out S var;
void main()
{
    
    var.a = in0;
    gl_Position = dEQP_Position;

}
#version 310 es
bool isOk (uvec2 a, uvec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
uvec2 out0;
layout(binding = 0, std140) uniform Reference
{
	uvec2 out0;
} ref;

struct S { mediump uvec2 a; };
layout(location = 0) flat in S var;
void main()
{
    out0 = var.a;
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 in0;

struct S { mediump uvec3 a; };
layout(location = 0) flat out S var;
void main()
{
    
    var.a = in0;
    gl_Position = dEQP_Position;

}
#version 310 es
bool isOk (uvec3 a, uvec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
uvec3 out0;
layout(binding = 0, std140) uniform Reference
{
	uvec3 out0;
} ref;

struct S { mediump uvec3 a; };
layout(location = 0) flat in S var;
void main()
{
    out0 = var.a;
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec4 in0;

struct S { mediump uvec4 a; };
layout(location = 0) flat out S var;
void main()
{
    
    var.a = in0;
    gl_Position = dEQP_Position;

}
#version 310 es
bool isOk (uvec4 a, uvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
uvec4 out0;
layout(binding = 0, std140) uniform Reference
{
	uvec4 out0;
} ref;

struct S { mediump uvec4 a; };
layout(location = 0) flat in S var;
void main()
{
    out0 = var.a;
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 2) in vec3 in1;

struct S { mediump float a; highp vec3 b; };
layout(location = 0) out S var;
void main()
{
    var.a = in0;
    var.b = in1;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
float out0;
vec3 out1;
layout(binding = 0, std140) uniform Reference
{
	float out0;
	vec3 out1;
} ref;

struct S { mediump float a; highp vec3 b; };
layout(location = 0) in S var;
void main()
{
    out0 = var.a;
    out1 = var.b;
    bool RES = isOk(out0, ref.out0, 0.05);
RES = RES && isOk(out1, ref.out1, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 2) in uvec2 in1;
layout(location = 3) in vec3 in2;

struct S { mediump float a; highp uvec2 b; highp vec3 c; };
layout(location = 0) flat out S var;
void main()
{
    
    var.a = in0;
    var.b = in1;
    var.c = in2;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (uvec2 a, uvec2 b) { return (a == b); }
bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
float out0;
uvec2 out1;
vec3 out2;
layout(binding = 0, std140) uniform Reference
{
	float out0;
	uvec2 out1;
	vec3 out2;
} ref;

struct S { mediump float a; highp uvec2 b; highp vec3 c; };
layout(location = 0) flat in S var;
void main()
{
    out0 = var.a;
    out1 = var.b;
    out2 = var.c;
    bool RES = isOk(out0, ref.out0, 0.05);
RES = RES && isOk(out1, ref.out1);
RES = RES && isOk(out2, ref.out2, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec4 in0;

layout(location = 0) smooth out vec4 var;
void main()
{
    var = in0;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
vec4 out0;
layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;

layout(location = 0) smooth in vec4 var;
void main()
{
    out0 = var;
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec4 in0;

layout(location = 0) centroid out vec4 var;
void main()
{
    var = in0;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
vec4 out0;
layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;

layout(location = 0) centroid in vec4 var;
void main()
{
    out0 = var;
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec4 in0;

layout(location = 0) flat out vec4 var;
void main()
{
    var = in0;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
vec4 out0;
layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;

layout(location = 0) flat in vec4 var;
void main()
{
    out0 = var;
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;

layout(location = 0) out float var1;
layout(location = 1) out float var2;

void main()
{
    var1 = in0;
    var2 = var1 + in0;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
float out0;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;

layout(location = 0) in float var1;
layout(location = 1) in float var2;

void main()
{
    out0 = var1 + var2;
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
