#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat4 in0;
layout(location = 0) flat out mat4 out0;


void main()
{
    
    out0 = mat4(in0);
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
precision highp int;

bool isOk (mat4 a, mat4 b, float eps) { vec4 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat4 in0;
layout(binding = 0, std140) uniform Reference
{
	mat4 out0;
} ref;
mat4 out0;


void main()
{
    
    out0 = mat4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

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


void main()
{
    
    out0 = mat4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat4 in0;
layout(location = 0) flat out mat4x3 out0;


void main()
{
    
    out0 = mat4x3(in0);
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

bool isOk (mat4x3 a, mat4x3 b, float eps) { vec3 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat4 in0;
layout(binding = 0, std140) uniform Reference
{
	mat4x3 out0;
} ref;
mat4x3 out0;


void main()
{
    
    out0 = mat4x3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat4 in0;
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


void main()
{
    
    out0 = mat4x3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat4 in0;
layout(location = 0) flat out mat4x2 out0;


void main()
{
    
    out0 = mat4x2(in0);
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

bool isOk (mat4x2 a, mat4x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat4 in0;
layout(binding = 0, std140) uniform Reference
{
	mat4x2 out0;
} ref;
mat4x2 out0;


void main()
{
    
    out0 = mat4x2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat4 in0;
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


void main()
{
    
    out0 = mat4x2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat4 in0;
layout(location = 0) flat out mat3x4 out0;


void main()
{
    
    out0 = mat3x4(in0);
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

bool isOk (mat3x4 a, mat3x4 b, float eps) { vec4 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat4 in0;
layout(binding = 0, std140) uniform Reference
{
	mat3x4 out0;
} ref;
mat3x4 out0;


void main()
{
    
    out0 = mat3x4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat4 in0;
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


void main()
{
    
    out0 = mat3x4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat4 in0;
layout(location = 0) flat out mat3 out0;


void main()
{
    
    out0 = mat3(in0);
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
precision highp int;

bool isOk (mat3 a, mat3 b, float eps) { vec3 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat4 in0;
layout(binding = 0, std140) uniform Reference
{
	mat3 out0;
} ref;
mat3 out0;


void main()
{
    
    out0 = mat3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat4 in0;
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


void main()
{
    
    out0 = mat3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat4 in0;
layout(location = 0) flat out mat3x2 out0;


void main()
{
    
    out0 = mat3x2(in0);
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

bool isOk (mat3x2 a, mat3x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat4 in0;
layout(binding = 0, std140) uniform Reference
{
	mat3x2 out0;
} ref;
mat3x2 out0;


void main()
{
    
    out0 = mat3x2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat4 in0;
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


void main()
{
    
    out0 = mat3x2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat4 in0;
layout(location = 0) flat out mat2x4 out0;


void main()
{
    
    out0 = mat2x4(in0);
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

bool isOk (mat2x4 a, mat2x4 b, float eps) { vec4 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat4 in0;
layout(binding = 0, std140) uniform Reference
{
	mat2x4 out0;
} ref;
mat2x4 out0;


void main()
{
    
    out0 = mat2x4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat4 in0;
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


void main()
{
    
    out0 = mat2x4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat4 in0;
layout(location = 0) flat out mat2x3 out0;


void main()
{
    
    out0 = mat2x3(in0);
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

bool isOk (mat2x3 a, mat2x3 b, float eps) { vec3 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat4 in0;
layout(binding = 0, std140) uniform Reference
{
	mat2x3 out0;
} ref;
mat2x3 out0;


void main()
{
    
    out0 = mat2x3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat4 in0;
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


void main()
{
    
    out0 = mat2x3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat4 in0;
layout(location = 0) flat out mat2 out0;


void main()
{
    
    out0 = mat2(in0);
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
precision highp int;

bool isOk (mat2 a, mat2 b, float eps) { vec2 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat4 in0;
layout(binding = 0, std140) uniform Reference
{
	mat2 out0;
} ref;
mat2 out0;


void main()
{
    
    out0 = mat2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat4 in0;
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


void main()
{
    
    out0 = mat2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat4x3 in0;
layout(location = 0) flat out mat4 out0;


void main()
{
    
    out0 = mat4(in0);
    gl_Position = dEQP_Position;

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
precision highp int;

bool isOk (mat4 a, mat4 b, float eps) { vec4 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat4x3 in0;
layout(binding = 0, std140) uniform Reference
{
	mat4 out0;
} ref;
mat4 out0;


void main()
{
    
    out0 = mat4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat4x3 in0;
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


void main()
{
    
    out0 = mat4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat4x3 in0;
layout(location = 0) flat out mat4x3 out0;


void main()
{
    
    out0 = mat4x3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat4x3 a, mat4x3 b, float eps) { vec3 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat4x3 in0;
layout(binding = 0, std140) uniform Reference
{
	mat4x3 out0;
} ref;
mat4x3 out0;


void main()
{
    
    out0 = mat4x3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

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


void main()
{
    
    out0 = mat4x3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat4x3 in0;
layout(location = 0) flat out mat4x2 out0;


void main()
{
    
    out0 = mat4x2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat4x2 a, mat4x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat4x3 in0;
layout(binding = 0, std140) uniform Reference
{
	mat4x2 out0;
} ref;
mat4x2 out0;


void main()
{
    
    out0 = mat4x2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat4x3 in0;
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


void main()
{
    
    out0 = mat4x2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat4x3 in0;
layout(location = 0) flat out mat3x4 out0;


void main()
{
    
    out0 = mat3x4(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat3x4 a, mat3x4 b, float eps) { vec4 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat4x3 in0;
layout(binding = 0, std140) uniform Reference
{
	mat3x4 out0;
} ref;
mat3x4 out0;


void main()
{
    
    out0 = mat3x4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat4x3 in0;
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


void main()
{
    
    out0 = mat3x4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat4x3 in0;
layout(location = 0) flat out mat3 out0;


void main()
{
    
    out0 = mat3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat3 a, mat3 b, float eps) { vec3 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat4x3 in0;
layout(binding = 0, std140) uniform Reference
{
	mat3 out0;
} ref;
mat3 out0;


void main()
{
    
    out0 = mat3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat4x3 in0;
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


void main()
{
    
    out0 = mat3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat4x3 in0;
layout(location = 0) flat out mat3x2 out0;


void main()
{
    
    out0 = mat3x2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat3x2 a, mat3x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat4x3 in0;
layout(binding = 0, std140) uniform Reference
{
	mat3x2 out0;
} ref;
mat3x2 out0;


void main()
{
    
    out0 = mat3x2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat4x3 in0;
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


void main()
{
    
    out0 = mat3x2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat4x3 in0;
layout(location = 0) flat out mat2x4 out0;


void main()
{
    
    out0 = mat2x4(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat2x4 a, mat2x4 b, float eps) { vec4 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat4x3 in0;
layout(binding = 0, std140) uniform Reference
{
	mat2x4 out0;
} ref;
mat2x4 out0;


void main()
{
    
    out0 = mat2x4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat4x3 in0;
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


void main()
{
    
    out0 = mat2x4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat4x3 in0;
layout(location = 0) flat out mat2x3 out0;


void main()
{
    
    out0 = mat2x3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat2x3 a, mat2x3 b, float eps) { vec3 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat4x3 in0;
layout(binding = 0, std140) uniform Reference
{
	mat2x3 out0;
} ref;
mat2x3 out0;


void main()
{
    
    out0 = mat2x3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat4x3 in0;
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


void main()
{
    
    out0 = mat2x3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat4x3 in0;
layout(location = 0) flat out mat2 out0;


void main()
{
    
    out0 = mat2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat2 a, mat2 b, float eps) { vec2 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat4x3 in0;
layout(binding = 0, std140) uniform Reference
{
	mat2 out0;
} ref;
mat2 out0;


void main()
{
    
    out0 = mat2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat4x3 in0;
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


void main()
{
    
    out0 = mat2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat4x2 in0;
layout(location = 0) flat out mat4 out0;


void main()
{
    
    out0 = mat4(in0);
    gl_Position = dEQP_Position;

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
precision highp int;

bool isOk (mat4 a, mat4 b, float eps) { vec4 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat4x2 in0;
layout(binding = 0, std140) uniform Reference
{
	mat4 out0;
} ref;
mat4 out0;


void main()
{
    
    out0 = mat4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat4x2 in0;
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


void main()
{
    
    out0 = mat4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat4x2 in0;
layout(location = 0) flat out mat4x3 out0;


void main()
{
    
    out0 = mat4x3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat4x3 a, mat4x3 b, float eps) { vec3 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat4x2 in0;
layout(binding = 0, std140) uniform Reference
{
	mat4x3 out0;
} ref;
mat4x3 out0;


void main()
{
    
    out0 = mat4x3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat4x2 in0;
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


void main()
{
    
    out0 = mat4x3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat4x2 in0;
layout(location = 0) flat out mat4x2 out0;


void main()
{
    
    out0 = mat4x2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat4x2 a, mat4x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat4x2 in0;
layout(binding = 0, std140) uniform Reference
{
	mat4x2 out0;
} ref;
mat4x2 out0;


void main()
{
    
    out0 = mat4x2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

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


void main()
{
    
    out0 = mat4x2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat4x2 in0;
layout(location = 0) flat out mat3x4 out0;


void main()
{
    
    out0 = mat3x4(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat3x4 a, mat3x4 b, float eps) { vec4 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat4x2 in0;
layout(binding = 0, std140) uniform Reference
{
	mat3x4 out0;
} ref;
mat3x4 out0;


void main()
{
    
    out0 = mat3x4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat4x2 in0;
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


void main()
{
    
    out0 = mat3x4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat4x2 in0;
layout(location = 0) flat out mat3 out0;


void main()
{
    
    out0 = mat3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat3 a, mat3 b, float eps) { vec3 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat4x2 in0;
layout(binding = 0, std140) uniform Reference
{
	mat3 out0;
} ref;
mat3 out0;


void main()
{
    
    out0 = mat3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat4x2 in0;
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


void main()
{
    
    out0 = mat3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat4x2 in0;
layout(location = 0) flat out mat3x2 out0;


void main()
{
    
    out0 = mat3x2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat3x2 a, mat3x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat4x2 in0;
layout(binding = 0, std140) uniform Reference
{
	mat3x2 out0;
} ref;
mat3x2 out0;


void main()
{
    
    out0 = mat3x2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat4x2 in0;
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


void main()
{
    
    out0 = mat3x2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat4x2 in0;
layout(location = 0) flat out mat2x4 out0;


void main()
{
    
    out0 = mat2x4(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat2x4 a, mat2x4 b, float eps) { vec4 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat4x2 in0;
layout(binding = 0, std140) uniform Reference
{
	mat2x4 out0;
} ref;
mat2x4 out0;


void main()
{
    
    out0 = mat2x4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat4x2 in0;
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


void main()
{
    
    out0 = mat2x4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat4x2 in0;
layout(location = 0) flat out mat2x3 out0;


void main()
{
    
    out0 = mat2x3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat2x3 a, mat2x3 b, float eps) { vec3 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat4x2 in0;
layout(binding = 0, std140) uniform Reference
{
	mat2x3 out0;
} ref;
mat2x3 out0;


void main()
{
    
    out0 = mat2x3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat4x2 in0;
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


void main()
{
    
    out0 = mat2x3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat4x2 in0;
layout(location = 0) flat out mat2 out0;


void main()
{
    
    out0 = mat2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat2 a, mat2 b, float eps) { vec2 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat4x2 in0;
layout(binding = 0, std140) uniform Reference
{
	mat2 out0;
} ref;
mat2 out0;


void main()
{
    
    out0 = mat2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat4x2 in0;
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


void main()
{
    
    out0 = mat2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat3x4 in0;
layout(location = 0) flat out mat4 out0;


void main()
{
    
    out0 = mat4(in0);
    gl_Position = dEQP_Position;

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
precision highp int;

bool isOk (mat4 a, mat4 b, float eps) { vec4 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat3x4 in0;
layout(binding = 0, std140) uniform Reference
{
	mat4 out0;
} ref;
mat4 out0;


void main()
{
    
    out0 = mat4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat3x4 in0;
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


void main()
{
    
    out0 = mat4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat3x4 in0;
layout(location = 0) flat out mat4x3 out0;


void main()
{
    
    out0 = mat4x3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat4x3 a, mat4x3 b, float eps) { vec3 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat3x4 in0;
layout(binding = 0, std140) uniform Reference
{
	mat4x3 out0;
} ref;
mat4x3 out0;


void main()
{
    
    out0 = mat4x3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat3x4 in0;
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


void main()
{
    
    out0 = mat4x3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat3x4 in0;
layout(location = 0) flat out mat4x2 out0;


void main()
{
    
    out0 = mat4x2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat4x2 a, mat4x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat3x4 in0;
layout(binding = 0, std140) uniform Reference
{
	mat4x2 out0;
} ref;
mat4x2 out0;


void main()
{
    
    out0 = mat4x2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat3x4 in0;
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


void main()
{
    
    out0 = mat4x2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat3x4 in0;
layout(location = 0) flat out mat3x4 out0;


void main()
{
    
    out0 = mat3x4(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat3x4 a, mat3x4 b, float eps) { vec4 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat3x4 in0;
layout(binding = 0, std140) uniform Reference
{
	mat3x4 out0;
} ref;
mat3x4 out0;


void main()
{
    
    out0 = mat3x4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

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


void main()
{
    
    out0 = mat3x4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat3x4 in0;
layout(location = 0) flat out mat3 out0;


void main()
{
    
    out0 = mat3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat3 a, mat3 b, float eps) { vec3 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat3x4 in0;
layout(binding = 0, std140) uniform Reference
{
	mat3 out0;
} ref;
mat3 out0;


void main()
{
    
    out0 = mat3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat3x4 in0;
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


void main()
{
    
    out0 = mat3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat3x4 in0;
layout(location = 0) flat out mat3x2 out0;


void main()
{
    
    out0 = mat3x2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat3x2 a, mat3x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat3x4 in0;
layout(binding = 0, std140) uniform Reference
{
	mat3x2 out0;
} ref;
mat3x2 out0;


void main()
{
    
    out0 = mat3x2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat3x4 in0;
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


void main()
{
    
    out0 = mat3x2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat3x4 in0;
layout(location = 0) flat out mat2x4 out0;


void main()
{
    
    out0 = mat2x4(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat2x4 a, mat2x4 b, float eps) { vec4 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat3x4 in0;
layout(binding = 0, std140) uniform Reference
{
	mat2x4 out0;
} ref;
mat2x4 out0;


void main()
{
    
    out0 = mat2x4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat3x4 in0;
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


void main()
{
    
    out0 = mat2x4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat3x4 in0;
layout(location = 0) flat out mat2x3 out0;


void main()
{
    
    out0 = mat2x3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat2x3 a, mat2x3 b, float eps) { vec3 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat3x4 in0;
layout(binding = 0, std140) uniform Reference
{
	mat2x3 out0;
} ref;
mat2x3 out0;


void main()
{
    
    out0 = mat2x3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat3x4 in0;
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


void main()
{
    
    out0 = mat2x3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat3x4 in0;
layout(location = 0) flat out mat2 out0;


void main()
{
    
    out0 = mat2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat2 a, mat2 b, float eps) { vec2 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat3x4 in0;
layout(binding = 0, std140) uniform Reference
{
	mat2 out0;
} ref;
mat2 out0;


void main()
{
    
    out0 = mat2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat3x4 in0;
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


void main()
{
    
    out0 = mat2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat3 in0;
layout(location = 0) flat out mat4 out0;


void main()
{
    
    out0 = mat4(in0);
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
precision highp int;

bool isOk (mat4 a, mat4 b, float eps) { vec4 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat3 in0;
layout(binding = 0, std140) uniform Reference
{
	mat4 out0;
} ref;
mat4 out0;


void main()
{
    
    out0 = mat4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat3 in0;
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


void main()
{
    
    out0 = mat4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat3 in0;
layout(location = 0) flat out mat4x3 out0;


void main()
{
    
    out0 = mat4x3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat4x3 a, mat4x3 b, float eps) { vec3 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat3 in0;
layout(binding = 0, std140) uniform Reference
{
	mat4x3 out0;
} ref;
mat4x3 out0;


void main()
{
    
    out0 = mat4x3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat3 in0;
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


void main()
{
    
    out0 = mat4x3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat3 in0;
layout(location = 0) flat out mat4x2 out0;


void main()
{
    
    out0 = mat4x2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat4x2 a, mat4x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat3 in0;
layout(binding = 0, std140) uniform Reference
{
	mat4x2 out0;
} ref;
mat4x2 out0;


void main()
{
    
    out0 = mat4x2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat3 in0;
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


void main()
{
    
    out0 = mat4x2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat3 in0;
layout(location = 0) flat out mat3x4 out0;


void main()
{
    
    out0 = mat3x4(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat3x4 a, mat3x4 b, float eps) { vec4 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat3 in0;
layout(binding = 0, std140) uniform Reference
{
	mat3x4 out0;
} ref;
mat3x4 out0;


void main()
{
    
    out0 = mat3x4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat3 in0;
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


void main()
{
    
    out0 = mat3x4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat3 in0;
layout(location = 0) flat out mat3 out0;


void main()
{
    
    out0 = mat3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat3 a, mat3 b, float eps) { vec3 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat3 in0;
layout(binding = 0, std140) uniform Reference
{
	mat3 out0;
} ref;
mat3 out0;


void main()
{
    
    out0 = mat3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

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


void main()
{
    
    out0 = mat3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat3 in0;
layout(location = 0) flat out mat3x2 out0;


void main()
{
    
    out0 = mat3x2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat3x2 a, mat3x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat3 in0;
layout(binding = 0, std140) uniform Reference
{
	mat3x2 out0;
} ref;
mat3x2 out0;


void main()
{
    
    out0 = mat3x2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat3 in0;
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


void main()
{
    
    out0 = mat3x2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat3 in0;
layout(location = 0) flat out mat2x4 out0;


void main()
{
    
    out0 = mat2x4(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat2x4 a, mat2x4 b, float eps) { vec4 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat3 in0;
layout(binding = 0, std140) uniform Reference
{
	mat2x4 out0;
} ref;
mat2x4 out0;


void main()
{
    
    out0 = mat2x4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat3 in0;
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


void main()
{
    
    out0 = mat2x4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat3 in0;
layout(location = 0) flat out mat2x3 out0;


void main()
{
    
    out0 = mat2x3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat2x3 a, mat2x3 b, float eps) { vec3 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat3 in0;
layout(binding = 0, std140) uniform Reference
{
	mat2x3 out0;
} ref;
mat2x3 out0;


void main()
{
    
    out0 = mat2x3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat3 in0;
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


void main()
{
    
    out0 = mat2x3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat3 in0;
layout(location = 0) flat out mat2 out0;


void main()
{
    
    out0 = mat2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat2 a, mat2 b, float eps) { vec2 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat3 in0;
layout(binding = 0, std140) uniform Reference
{
	mat2 out0;
} ref;
mat2 out0;


void main()
{
    
    out0 = mat2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat3 in0;
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


void main()
{
    
    out0 = mat2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat3x2 in0;
layout(location = 0) flat out mat4 out0;


void main()
{
    
    out0 = mat4(in0);
    gl_Position = dEQP_Position;

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
precision highp int;

bool isOk (mat4 a, mat4 b, float eps) { vec4 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat3x2 in0;
layout(binding = 0, std140) uniform Reference
{
	mat4 out0;
} ref;
mat4 out0;


void main()
{
    
    out0 = mat4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat3x2 in0;
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


void main()
{
    
    out0 = mat4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat3x2 in0;
layout(location = 0) flat out mat4x3 out0;


void main()
{
    
    out0 = mat4x3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat4x3 a, mat4x3 b, float eps) { vec3 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat3x2 in0;
layout(binding = 0, std140) uniform Reference
{
	mat4x3 out0;
} ref;
mat4x3 out0;


void main()
{
    
    out0 = mat4x3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat3x2 in0;
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


void main()
{
    
    out0 = mat4x3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat3x2 in0;
layout(location = 0) flat out mat4x2 out0;


void main()
{
    
    out0 = mat4x2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat4x2 a, mat4x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat3x2 in0;
layout(binding = 0, std140) uniform Reference
{
	mat4x2 out0;
} ref;
mat4x2 out0;


void main()
{
    
    out0 = mat4x2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat3x2 in0;
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


void main()
{
    
    out0 = mat4x2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat3x2 in0;
layout(location = 0) flat out mat3x4 out0;


void main()
{
    
    out0 = mat3x4(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat3x4 a, mat3x4 b, float eps) { vec4 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat3x2 in0;
layout(binding = 0, std140) uniform Reference
{
	mat3x4 out0;
} ref;
mat3x4 out0;


void main()
{
    
    out0 = mat3x4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat3x2 in0;
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


void main()
{
    
    out0 = mat3x4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat3x2 in0;
layout(location = 0) flat out mat3 out0;


void main()
{
    
    out0 = mat3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat3 a, mat3 b, float eps) { vec3 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat3x2 in0;
layout(binding = 0, std140) uniform Reference
{
	mat3 out0;
} ref;
mat3 out0;


void main()
{
    
    out0 = mat3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat3x2 in0;
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


void main()
{
    
    out0 = mat3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat3x2 in0;
layout(location = 0) flat out mat3x2 out0;


void main()
{
    
    out0 = mat3x2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat3x2 a, mat3x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat3x2 in0;
layout(binding = 0, std140) uniform Reference
{
	mat3x2 out0;
} ref;
mat3x2 out0;


void main()
{
    
    out0 = mat3x2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

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


void main()
{
    
    out0 = mat3x2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat3x2 in0;
layout(location = 0) flat out mat2x4 out0;


void main()
{
    
    out0 = mat2x4(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat2x4 a, mat2x4 b, float eps) { vec4 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat3x2 in0;
layout(binding = 0, std140) uniform Reference
{
	mat2x4 out0;
} ref;
mat2x4 out0;


void main()
{
    
    out0 = mat2x4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat3x2 in0;
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


void main()
{
    
    out0 = mat2x4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat3x2 in0;
layout(location = 0) flat out mat2x3 out0;


void main()
{
    
    out0 = mat2x3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat2x3 a, mat2x3 b, float eps) { vec3 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat3x2 in0;
layout(binding = 0, std140) uniform Reference
{
	mat2x3 out0;
} ref;
mat2x3 out0;


void main()
{
    
    out0 = mat2x3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat3x2 in0;
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


void main()
{
    
    out0 = mat2x3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat3x2 in0;
layout(location = 0) flat out mat2 out0;


void main()
{
    
    out0 = mat2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat2 a, mat2 b, float eps) { vec2 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat3x2 in0;
layout(binding = 0, std140) uniform Reference
{
	mat2 out0;
} ref;
mat2 out0;


void main()
{
    
    out0 = mat2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat3x2 in0;
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


void main()
{
    
    out0 = mat2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat2x4 in0;
layout(location = 0) flat out mat4 out0;


void main()
{
    
    out0 = mat4(in0);
    gl_Position = dEQP_Position;

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
precision highp int;

bool isOk (mat4 a, mat4 b, float eps) { vec4 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat2x4 in0;
layout(binding = 0, std140) uniform Reference
{
	mat4 out0;
} ref;
mat4 out0;


void main()
{
    
    out0 = mat4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat2x4 in0;
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


void main()
{
    
    out0 = mat4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat2x4 in0;
layout(location = 0) flat out mat4x3 out0;


void main()
{
    
    out0 = mat4x3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat4x3 a, mat4x3 b, float eps) { vec3 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat2x4 in0;
layout(binding = 0, std140) uniform Reference
{
	mat4x3 out0;
} ref;
mat4x3 out0;


void main()
{
    
    out0 = mat4x3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat2x4 in0;
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


void main()
{
    
    out0 = mat4x3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat2x4 in0;
layout(location = 0) flat out mat4x2 out0;


void main()
{
    
    out0 = mat4x2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat4x2 a, mat4x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat2x4 in0;
layout(binding = 0, std140) uniform Reference
{
	mat4x2 out0;
} ref;
mat4x2 out0;


void main()
{
    
    out0 = mat4x2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat2x4 in0;
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


void main()
{
    
    out0 = mat4x2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat2x4 in0;
layout(location = 0) flat out mat3x4 out0;


void main()
{
    
    out0 = mat3x4(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat3x4 a, mat3x4 b, float eps) { vec4 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat2x4 in0;
layout(binding = 0, std140) uniform Reference
{
	mat3x4 out0;
} ref;
mat3x4 out0;


void main()
{
    
    out0 = mat3x4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat2x4 in0;
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


void main()
{
    
    out0 = mat3x4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat2x4 in0;
layout(location = 0) flat out mat3 out0;


void main()
{
    
    out0 = mat3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat3 a, mat3 b, float eps) { vec3 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat2x4 in0;
layout(binding = 0, std140) uniform Reference
{
	mat3 out0;
} ref;
mat3 out0;


void main()
{
    
    out0 = mat3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat2x4 in0;
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


void main()
{
    
    out0 = mat3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat2x4 in0;
layout(location = 0) flat out mat3x2 out0;


void main()
{
    
    out0 = mat3x2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat3x2 a, mat3x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat2x4 in0;
layout(binding = 0, std140) uniform Reference
{
	mat3x2 out0;
} ref;
mat3x2 out0;


void main()
{
    
    out0 = mat3x2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat2x4 in0;
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


void main()
{
    
    out0 = mat3x2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat2x4 in0;
layout(location = 0) flat out mat2x4 out0;


void main()
{
    
    out0 = mat2x4(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat2x4 a, mat2x4 b, float eps) { vec4 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat2x4 in0;
layout(binding = 0, std140) uniform Reference
{
	mat2x4 out0;
} ref;
mat2x4 out0;


void main()
{
    
    out0 = mat2x4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

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


void main()
{
    
    out0 = mat2x4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat2x4 in0;
layout(location = 0) flat out mat2x3 out0;


void main()
{
    
    out0 = mat2x3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat2x3 a, mat2x3 b, float eps) { vec3 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat2x4 in0;
layout(binding = 0, std140) uniform Reference
{
	mat2x3 out0;
} ref;
mat2x3 out0;


void main()
{
    
    out0 = mat2x3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat2x4 in0;
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


void main()
{
    
    out0 = mat2x3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat2x4 in0;
layout(location = 0) flat out mat2 out0;


void main()
{
    
    out0 = mat2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat2 a, mat2 b, float eps) { vec2 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat2x4 in0;
layout(binding = 0, std140) uniform Reference
{
	mat2 out0;
} ref;
mat2 out0;


void main()
{
    
    out0 = mat2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat2x4 in0;
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


void main()
{
    
    out0 = mat2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat2x3 in0;
layout(location = 0) flat out mat4 out0;


void main()
{
    
    out0 = mat4(in0);
    gl_Position = dEQP_Position;

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
precision highp int;

bool isOk (mat4 a, mat4 b, float eps) { vec4 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat2x3 in0;
layout(binding = 0, std140) uniform Reference
{
	mat4 out0;
} ref;
mat4 out0;


void main()
{
    
    out0 = mat4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat2x3 in0;
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


void main()
{
    
    out0 = mat4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat2x3 in0;
layout(location = 0) flat out mat4x3 out0;


void main()
{
    
    out0 = mat4x3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat4x3 a, mat4x3 b, float eps) { vec3 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat2x3 in0;
layout(binding = 0, std140) uniform Reference
{
	mat4x3 out0;
} ref;
mat4x3 out0;


void main()
{
    
    out0 = mat4x3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat2x3 in0;
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


void main()
{
    
    out0 = mat4x3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat2x3 in0;
layout(location = 0) flat out mat4x2 out0;


void main()
{
    
    out0 = mat4x2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat4x2 a, mat4x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat2x3 in0;
layout(binding = 0, std140) uniform Reference
{
	mat4x2 out0;
} ref;
mat4x2 out0;


void main()
{
    
    out0 = mat4x2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat2x3 in0;
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


void main()
{
    
    out0 = mat4x2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat2x3 in0;
layout(location = 0) flat out mat3x4 out0;


void main()
{
    
    out0 = mat3x4(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat3x4 a, mat3x4 b, float eps) { vec4 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat2x3 in0;
layout(binding = 0, std140) uniform Reference
{
	mat3x4 out0;
} ref;
mat3x4 out0;


void main()
{
    
    out0 = mat3x4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat2x3 in0;
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


void main()
{
    
    out0 = mat3x4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat2x3 in0;
layout(location = 0) flat out mat3 out0;


void main()
{
    
    out0 = mat3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat3 a, mat3 b, float eps) { vec3 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat2x3 in0;
layout(binding = 0, std140) uniform Reference
{
	mat3 out0;
} ref;
mat3 out0;


void main()
{
    
    out0 = mat3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat2x3 in0;
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


void main()
{
    
    out0 = mat3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat2x3 in0;
layout(location = 0) flat out mat3x2 out0;


void main()
{
    
    out0 = mat3x2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat3x2 a, mat3x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat2x3 in0;
layout(binding = 0, std140) uniform Reference
{
	mat3x2 out0;
} ref;
mat3x2 out0;


void main()
{
    
    out0 = mat3x2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat2x3 in0;
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


void main()
{
    
    out0 = mat3x2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat2x3 in0;
layout(location = 0) flat out mat2x4 out0;


void main()
{
    
    out0 = mat2x4(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat2x4 a, mat2x4 b, float eps) { vec4 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat2x3 in0;
layout(binding = 0, std140) uniform Reference
{
	mat2x4 out0;
} ref;
mat2x4 out0;


void main()
{
    
    out0 = mat2x4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat2x3 in0;
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


void main()
{
    
    out0 = mat2x4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat2x3 in0;
layout(location = 0) flat out mat2x3 out0;


void main()
{
    
    out0 = mat2x3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat2x3 a, mat2x3 b, float eps) { vec3 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat2x3 in0;
layout(binding = 0, std140) uniform Reference
{
	mat2x3 out0;
} ref;
mat2x3 out0;


void main()
{
    
    out0 = mat2x3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

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


void main()
{
    
    out0 = mat2x3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat2x3 in0;
layout(location = 0) flat out mat2 out0;


void main()
{
    
    out0 = mat2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat2 a, mat2 b, float eps) { vec2 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat2x3 in0;
layout(binding = 0, std140) uniform Reference
{
	mat2 out0;
} ref;
mat2 out0;


void main()
{
    
    out0 = mat2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat2x3 in0;
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


void main()
{
    
    out0 = mat2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat2 in0;
layout(location = 0) flat out mat4 out0;


void main()
{
    
    out0 = mat4(in0);
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
precision highp int;

bool isOk (mat4 a, mat4 b, float eps) { vec4 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat2 in0;
layout(binding = 0, std140) uniform Reference
{
	mat4 out0;
} ref;
mat4 out0;


void main()
{
    
    out0 = mat4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat2 in0;
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


void main()
{
    
    out0 = mat4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat2 in0;
layout(location = 0) flat out mat4x3 out0;


void main()
{
    
    out0 = mat4x3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat4x3 a, mat4x3 b, float eps) { vec3 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat2 in0;
layout(binding = 0, std140) uniform Reference
{
	mat4x3 out0;
} ref;
mat4x3 out0;


void main()
{
    
    out0 = mat4x3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat2 in0;
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


void main()
{
    
    out0 = mat4x3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat2 in0;
layout(location = 0) flat out mat4x2 out0;


void main()
{
    
    out0 = mat4x2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat4x2 a, mat4x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat2 in0;
layout(binding = 0, std140) uniform Reference
{
	mat4x2 out0;
} ref;
mat4x2 out0;


void main()
{
    
    out0 = mat4x2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat2 in0;
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


void main()
{
    
    out0 = mat4x2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat2 in0;
layout(location = 0) flat out mat3x4 out0;


void main()
{
    
    out0 = mat3x4(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat3x4 a, mat3x4 b, float eps) { vec4 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat2 in0;
layout(binding = 0, std140) uniform Reference
{
	mat3x4 out0;
} ref;
mat3x4 out0;


void main()
{
    
    out0 = mat3x4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat2 in0;
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


void main()
{
    
    out0 = mat3x4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat2 in0;
layout(location = 0) flat out mat3 out0;


void main()
{
    
    out0 = mat3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat3 a, mat3 b, float eps) { vec3 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat2 in0;
layout(binding = 0, std140) uniform Reference
{
	mat3 out0;
} ref;
mat3 out0;


void main()
{
    
    out0 = mat3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat2 in0;
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


void main()
{
    
    out0 = mat3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat2 in0;
layout(location = 0) flat out mat3x2 out0;


void main()
{
    
    out0 = mat3x2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat3x2 a, mat3x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat2 in0;
layout(binding = 0, std140) uniform Reference
{
	mat3x2 out0;
} ref;
mat3x2 out0;


void main()
{
    
    out0 = mat3x2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat2 in0;
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


void main()
{
    
    out0 = mat3x2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat2 in0;
layout(location = 0) flat out mat2x4 out0;


void main()
{
    
    out0 = mat2x4(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat2x4 a, mat2x4 b, float eps) { vec4 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat2 in0;
layout(binding = 0, std140) uniform Reference
{
	mat2x4 out0;
} ref;
mat2x4 out0;


void main()
{
    
    out0 = mat2x4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat2 in0;
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


void main()
{
    
    out0 = mat2x4(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat2 in0;
layout(location = 0) flat out mat2x3 out0;


void main()
{
    
    out0 = mat2x3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat2x3 a, mat2x3 b, float eps) { vec3 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat2 in0;
layout(binding = 0, std140) uniform Reference
{
	mat2x3 out0;
} ref;
mat2x3 out0;


void main()
{
    
    out0 = mat2x3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	mat2 in0;
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


void main()
{
    
    out0 = mat2x3(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in mat2 in0;
layout(location = 0) flat out mat2 out0;


void main()
{
    
    out0 = mat2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat2 a, mat2 b, float eps) { vec2 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in mat2 in0;
layout(binding = 0, std140) uniform Reference
{
	mat2 out0;
} ref;
mat2 out0;


void main()
{
    
    out0 = mat2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp float;
precision highp int;

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


void main()
{
    
    out0 = mat2(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 in0;
layout(location = 2) in vec2 in1;
layout(location = 0) flat out mat2 out0;


void main()
{
    
    out0 = mat2(in0, in1);
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

bool isOk (mat2 a, mat2 b, float eps) { vec2 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec2 in0;
layout(location = 1) flat in vec2 in1;
layout(binding = 0, std140) uniform Reference
{
	mat2 out0;
} ref;
mat2 out0;


void main()
{
    
    out0 = mat2(in0, in1);
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
	mat2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (mat2 a, mat2 b, float eps) { vec2 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec2(eps))); }
mat2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = mat2(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec2 a_in0;
layout(location = 2) in uvec2 a_in1;
layout(location = 0) flat out mat2 out0;


void main()
{
    bvec2 in0 = bvec2(a_in0);
bvec2 in1 = bvec2(a_in1);

    out0 = mat2(in0, in1);
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

bool isOk (mat2 a, mat2 b, float eps) { vec2 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec2 v_in0;
layout(location = 1) flat in uvec2 v_in1;
layout(binding = 0, std140) uniform Reference
{
	mat2 out0;
} ref;
mat2 out0;


void main()
{
    bvec2 in0 = bvec2(v_in0);
bvec2 in1 = bvec2(v_in1);

    out0 = mat2(in0, in1);
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
	mat2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (mat2 a, mat2 b, float eps) { vec2 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec2(eps))); }
mat2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = mat2(in0, in1);
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
layout(location = 0) flat out mat2 out0;


void main()
{
    
    out0 = mat2(in0, in1, in2, in3);
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

bool isOk (mat2 a, mat2 b, float eps) { vec2 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(location = 1) flat in float in1;
layout(location = 2) flat in float in2;
layout(location = 3) flat in float in3;
layout(binding = 0, std140) uniform Reference
{
	mat2 out0;
} ref;
mat2 out0;


void main()
{
    
    out0 = mat2(in0, in1, in2, in3);
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
	mat2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (mat2 a, mat2 b, float eps) { vec2 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec2(eps))); }
mat2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = mat2(in0, in1, in2, in3);
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
layout(location = 0) flat out mat2 out0;


void main()
{
    
    out0 = mat2(in0, in1, in2, in3);
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

bool isOk (mat2 a, mat2 b, float eps) { vec2 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in int in0;
layout(location = 1) flat in int in1;
layout(location = 2) flat in int in2;
layout(location = 3) flat in int in3;
layout(binding = 0, std140) uniform Reference
{
	mat2 out0;
} ref;
mat2 out0;


void main()
{
    
    out0 = mat2(in0, in1, in2, in3);
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
	mat2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (mat2 a, mat2 b, float eps) { vec2 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec2(eps))); }
mat2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = mat2(in0, in1, in2, in3);
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
layout(location = 0) flat out mat2 out0;


void main()
{
    
    out0 = mat2(in0, in1, in2, in3);
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

bool isOk (mat2 a, mat2 b, float eps) { vec2 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint in0;
layout(location = 1) flat in uint in1;
layout(location = 2) flat in uint in2;
layout(location = 3) flat in uint in3;
layout(binding = 0, std140) uniform Reference
{
	mat2 out0;
} ref;
mat2 out0;


void main()
{
    
    out0 = mat2(in0, in1, in2, in3);
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
	mat2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (mat2 a, mat2 b, float eps) { vec2 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec2(eps))); }
mat2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = mat2(in0, in1, in2, in3);
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
layout(location = 0) flat out mat2 out0;


void main()
{
    bool in0 = bool(a_in0);
bool in1 = bool(a_in1);
bool in2 = bool(a_in2);
bool in3 = bool(a_in3);

    out0 = mat2(in0, in1, in2, in3);
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

bool isOk (mat2 a, mat2 b, float eps) { vec2 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(location = 1) flat in uint v_in1;
layout(location = 2) flat in uint v_in2;
layout(location = 3) flat in uint v_in3;
layout(binding = 0, std140) uniform Reference
{
	mat2 out0;
} ref;
mat2 out0;


void main()
{
    bool in0 = bool(v_in0);
bool in1 = bool(v_in1);
bool in2 = bool(v_in2);
bool in3 = bool(v_in3);

    out0 = mat2(in0, in1, in2, in3);
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
	mat2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (mat2 a, mat2 b, float eps) { vec2 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec2(eps))); }
mat2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = mat2(in0, in1, in2, in3);
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
layout(location = 0) flat out mat2 out0;


void main()
{
    bool in0 = bool(a_in0);
bool in3 = bool(a_in3);

    out0 = mat2(in0, in1, in2, in3);
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

bool isOk (mat2 a, mat2 b, float eps) { vec2 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(location = 1) flat in float in1;
layout(location = 2) flat in int in2;
layout(location = 3) flat in uint v_in3;
layout(binding = 0, std140) uniform Reference
{
	mat2 out0;
} ref;
mat2 out0;


void main()
{
    bool in0 = bool(v_in0);
bool in3 = bool(v_in3);

    out0 = mat2(in0, in1, in2, in3);
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
	mat2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (mat2 a, mat2 b, float eps) { vec2 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec2(eps))); }
mat2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = mat2(in0, in1, in2, in3);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 in0;
layout(location = 2) in ivec2 in1;
layout(location = 0) flat out mat2 out0;


void main()
{
    
    out0 = mat2(in0, in1);
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

bool isOk (mat2 a, mat2 b, float eps) { vec2 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec2 in0;
layout(location = 1) flat in ivec2 in1;
layout(binding = 0, std140) uniform Reference
{
	mat2 out0;
} ref;
mat2 out0;


void main()
{
    
    out0 = mat2(in0, in1);
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
	mat2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (mat2 a, mat2 b, float eps) { vec2 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec2(eps))); }
mat2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = mat2(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 in0;
layout(location = 2) in uvec2 a_in1;
layout(location = 0) flat out mat2 out0;


void main()
{
    bvec2 in1 = bvec2(a_in1);

    out0 = mat2(in0, in1);
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

bool isOk (mat2 a, mat2 b, float eps) { vec2 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec2 in0;
layout(location = 1) flat in uvec2 v_in1;
layout(binding = 0, std140) uniform Reference
{
	mat2 out0;
} ref;
mat2 out0;


void main()
{
    bvec2 in1 = bvec2(v_in1);

    out0 = mat2(in0, in1);
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
	mat2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (mat2 a, mat2 b, float eps) { vec2 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec2(eps))); }
mat2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = mat2(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 a_in0;
layout(location = 2) in float in1;
layout(location = 0) flat out mat2 out0;


void main()
{
    bvec3 in0 = bvec3(a_in0);

    out0 = mat2(in0, in1);
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

bool isOk (mat2 a, mat2 b, float eps) { vec2 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec3 v_in0;
layout(location = 1) flat in float in1;
layout(binding = 0, std140) uniform Reference
{
	mat2 out0;
} ref;
mat2 out0;


void main()
{
    bvec3 in0 = bvec3(v_in0);

    out0 = mat2(in0, in1);
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
	mat2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (mat2 a, mat2 b, float eps) { vec2 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec2(eps))); }
mat2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = mat2(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 2) in float in1;
layout(location = 0) flat out mat2 out0;


void main()
{
    
    out0 = mat2(in0, in1);
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

bool isOk (mat2 a, mat2 b, float eps) { vec2 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec3 in0;
layout(location = 1) flat in float in1;
layout(binding = 0, std140) uniform Reference
{
	mat2 out0;
} ref;
mat2 out0;


void main()
{
    
    out0 = mat2(in0, in1);
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
	mat2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (mat2 a, mat2 b, float eps) { vec2 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec2(eps))); }
mat2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = mat2(in0, in1);
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
layout(location = 0) flat out mat2 out0;


void main()
{
    
    out0 = mat2(in0, in1, in2);
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

bool isOk (mat2 a, mat2 b, float eps) { vec2 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in int in0;
layout(location = 1) flat in ivec2 in1;
layout(location = 2) flat in int in2;
layout(binding = 0, std140) uniform Reference
{
	mat2 out0;
} ref;
mat2 out0;


void main()
{
    
    out0 = mat2(in0, in1, in2);
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
	mat2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (mat2 a, mat2 b, float eps) { vec2 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec2(eps))); }
mat2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = mat2(in0, in1, in2);
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
layout(location = 0) flat out mat2 out0;


void main()
{
    bool in0 = bool(a_in0);

    out0 = mat2(in0, in1, in2);
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

bool isOk (mat2 a, mat2 b, float eps) { vec2 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(location = 1) flat in float in1;
layout(location = 2) flat in ivec2 in2;
layout(binding = 0, std140) uniform Reference
{
	mat2 out0;
} ref;
mat2 out0;


void main()
{
    bool in0 = bool(v_in0);

    out0 = mat2(in0, in1, in2);
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
	mat2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (mat2 a, mat2 b, float eps) { vec2 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec2(eps))); }
mat2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = mat2(in0, in1, in2);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 2) in uvec3 in1;
layout(location = 0) flat out mat2 out0;


void main()
{
    
    out0 = mat2(in0, in1);
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

bool isOk (mat2 a, mat2 b, float eps) { vec2 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(location = 1) flat in uvec3 in1;
layout(binding = 0, std140) uniform Reference
{
	mat2 out0;
} ref;
mat2 out0;


void main()
{
    
    out0 = mat2(in0, in1);
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
	mat2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (mat2 a, mat2 b, float eps) { vec2 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec2(eps))); }
mat2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = mat2(in0, in1);
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
layout(location = 0) flat out mat2 out0;


void main()
{
    bool in2 = bool(a_in2);

    out0 = mat2(in0, in1, in2);
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

bool isOk (mat2 a, mat2 b, float eps) { vec2 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in int in0;
layout(location = 1) flat in uvec2 in1;
layout(location = 2) flat in uint v_in2;
layout(binding = 0, std140) uniform Reference
{
	mat2 out0;
} ref;
mat2 out0;


void main()
{
    bool in2 = bool(v_in2);

    out0 = mat2(in0, in1, in2);
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
	mat2 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (mat2 a, mat2 b, float eps) { vec2 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec2(eps))); }
mat2 out0;
highp vec4 dEQP_Position;


void main()
{
    
    out0 = mat2(in0, in1, in2);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 2) in vec3 in1;
layout(location = 0) flat out mat2x3 out0;


void main()
{
    
    out0 = mat2x3(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 a_in0;
layout(location = 0) flat out vec3 in0;
layout(location = 2) in vec3 a_in1;
layout(location = 1) flat out vec3 in1;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
    in1 = a_in1;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat2x3 a, mat2x3 b, float eps) { vec3 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec3 in0;
layout(location = 1) flat in vec3 in1;
layout(binding = 0, std140) uniform Reference
{
	mat2x3 out0;
} ref;
mat2x3 out0;


void main()
{
    
    out0 = mat2x3(in0, in1);
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
	vec3 in1;
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


void main()
{
    
    out0 = mat2x3(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 a_in0;
layout(location = 2) in uvec3 a_in1;
layout(location = 0) flat out mat2x3 out0;


void main()
{
    bvec3 in0 = bvec3(a_in0);
bvec3 in1 = bvec3(a_in1);

    out0 = mat2x3(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 a_in0;
layout(location = 0) flat out uvec3 v_in0;
layout(location = 2) in uvec3 a_in1;
layout(location = 1) flat out uvec3 v_in1;

void main()
{
    gl_Position = dEQP_Position;
    v_in0 = a_in0;
    v_in1 = a_in1;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat2x3 a, mat2x3 b, float eps) { vec3 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec3 v_in0;
layout(location = 1) flat in uvec3 v_in1;
layout(binding = 0, std140) uniform Reference
{
	mat2x3 out0;
} ref;
mat2x3 out0;


void main()
{
    bvec3 in0 = bvec3(v_in0);
bvec3 in1 = bvec3(v_in1);

    out0 = mat2x3(in0, in1);
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
	bvec3 in1;
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


void main()
{
    
    out0 = mat2x3(in0, in1);
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
layout(location = 5) in float in4;
layout(location = 6) in float in5;
layout(location = 0) flat out mat2x3 out0;


void main()
{
    
    out0 = mat2x3(in0, in1, in2, in3, in4, in5);
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
layout(location = 5) in float a_in4;
layout(location = 4) flat out float in4;
layout(location = 6) in float a_in5;
layout(location = 5) flat out float in5;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
    in1 = a_in1;
    in2 = a_in2;
    in3 = a_in3;
    in4 = a_in4;
    in5 = a_in5;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat2x3 a, mat2x3 b, float eps) { vec3 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(location = 1) flat in float in1;
layout(location = 2) flat in float in2;
layout(location = 3) flat in float in3;
layout(location = 4) flat in float in4;
layout(location = 5) flat in float in5;
layout(binding = 0, std140) uniform Reference
{
	mat2x3 out0;
} ref;
mat2x3 out0;


void main()
{
    
    out0 = mat2x3(in0, in1, in2, in3, in4, in5);
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
	float in4;
	float in5;
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


void main()
{
    
    out0 = mat2x3(in0, in1, in2, in3, in4, in5);
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
layout(location = 5) in int in4;
layout(location = 6) in int in5;
layout(location = 0) flat out mat2x3 out0;


void main()
{
    
    out0 = mat2x3(in0, in1, in2, in3, in4, in5);
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
layout(location = 5) in int a_in4;
layout(location = 4) flat out int in4;
layout(location = 6) in int a_in5;
layout(location = 5) flat out int in5;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
    in1 = a_in1;
    in2 = a_in2;
    in3 = a_in3;
    in4 = a_in4;
    in5 = a_in5;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat2x3 a, mat2x3 b, float eps) { vec3 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in int in0;
layout(location = 1) flat in int in1;
layout(location = 2) flat in int in2;
layout(location = 3) flat in int in3;
layout(location = 4) flat in int in4;
layout(location = 5) flat in int in5;
layout(binding = 0, std140) uniform Reference
{
	mat2x3 out0;
} ref;
mat2x3 out0;


void main()
{
    
    out0 = mat2x3(in0, in1, in2, in3, in4, in5);
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
	int in4;
	int in5;
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


void main()
{
    
    out0 = mat2x3(in0, in1, in2, in3, in4, in5);
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
layout(location = 5) in uint a_in4;
layout(location = 6) in uint a_in5;
layout(location = 0) flat out mat2x3 out0;


void main()
{
    bool in0 = bool(a_in0);
bool in1 = bool(a_in1);
bool in2 = bool(a_in2);
bool in3 = bool(a_in3);
bool in4 = bool(a_in4);
bool in5 = bool(a_in5);

    out0 = mat2x3(in0, in1, in2, in3, in4, in5);
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
layout(location = 5) in uint a_in4;
layout(location = 4) flat out uint v_in4;
layout(location = 6) in uint a_in5;
layout(location = 5) flat out uint v_in5;

void main()
{
    gl_Position = dEQP_Position;
    v_in0 = a_in0;
    v_in1 = a_in1;
    v_in2 = a_in2;
    v_in3 = a_in3;
    v_in4 = a_in4;
    v_in5 = a_in5;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat2x3 a, mat2x3 b, float eps) { vec3 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(location = 1) flat in uint v_in1;
layout(location = 2) flat in uint v_in2;
layout(location = 3) flat in uint v_in3;
layout(location = 4) flat in uint v_in4;
layout(location = 5) flat in uint v_in5;
layout(binding = 0, std140) uniform Reference
{
	mat2x3 out0;
} ref;
mat2x3 out0;


void main()
{
    bool in0 = bool(v_in0);
bool in1 = bool(v_in1);
bool in2 = bool(v_in2);
bool in3 = bool(v_in3);
bool in4 = bool(v_in4);
bool in5 = bool(v_in5);

    out0 = mat2x3(in0, in1, in2, in3, in4, in5);
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
	bool in4;
	bool in5;
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


void main()
{
    
    out0 = mat2x3(in0, in1, in2, in3, in4, in5);
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
layout(location = 5) in float in4;
layout(location = 6) in int in5;
layout(location = 0) flat out mat2x3 out0;


void main()
{
    bool in0 = bool(a_in0);
bool in3 = bool(a_in3);

    out0 = mat2x3(in0, in1, in2, in3, in4, in5);
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
layout(location = 5) in float a_in4;
layout(location = 4) flat out float in4;
layout(location = 6) in int a_in5;
layout(location = 5) flat out int in5;

void main()
{
    gl_Position = dEQP_Position;
    v_in0 = a_in0;
    in1 = a_in1;
    in2 = a_in2;
    v_in3 = a_in3;
    in4 = a_in4;
    in5 = a_in5;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat2x3 a, mat2x3 b, float eps) { vec3 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(location = 1) flat in float in1;
layout(location = 2) flat in int in2;
layout(location = 3) flat in uint v_in3;
layout(location = 4) flat in float in4;
layout(location = 5) flat in int in5;
layout(binding = 0, std140) uniform Reference
{
	mat2x3 out0;
} ref;
mat2x3 out0;


void main()
{
    bool in0 = bool(v_in0);
bool in3 = bool(v_in3);

    out0 = mat2x3(in0, in1, in2, in3, in4, in5);
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
	float in4;
	int in5;
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


void main()
{
    
    out0 = mat2x3(in0, in1, in2, in3, in4, in5);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 2) in ivec3 in1;
layout(location = 0) flat out mat2x3 out0;


void main()
{
    
    out0 = mat2x3(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 a_in0;
layout(location = 0) flat out vec3 in0;
layout(location = 2) in ivec3 a_in1;
layout(location = 1) flat out ivec3 in1;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
    in1 = a_in1;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat2x3 a, mat2x3 b, float eps) { vec3 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec3 in0;
layout(location = 1) flat in ivec3 in1;
layout(binding = 0, std140) uniform Reference
{
	mat2x3 out0;
} ref;
mat2x3 out0;


void main()
{
    
    out0 = mat2x3(in0, in1);
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
	ivec3 in1;
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


void main()
{
    
    out0 = mat2x3(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 in0;
layout(location = 2) in uvec4 a_in1;
layout(location = 0) flat out mat2x3 out0;


void main()
{
    bvec4 in1 = bvec4(a_in1);

    out0 = mat2x3(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 a_in0;
layout(location = 0) flat out vec2 in0;
layout(location = 2) in uvec4 a_in1;
layout(location = 1) flat out uvec4 v_in1;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
    v_in1 = a_in1;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat2x3 a, mat2x3 b, float eps) { vec3 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec2 in0;
layout(location = 1) flat in uvec4 v_in1;
layout(binding = 0, std140) uniform Reference
{
	mat2x3 out0;
} ref;
mat2x3 out0;


void main()
{
    bvec4 in1 = bvec4(v_in1);

    out0 = mat2x3(in0, in1);
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
	bvec4 in1;
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


void main()
{
    
    out0 = mat2x3(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 a_in0;
layout(location = 2) in float in1;
layout(location = 3) in ivec2 in2;
layout(location = 0) flat out mat2x3 out0;


void main()
{
    bvec3 in0 = bvec3(a_in0);

    out0 = mat2x3(in0, in1, in2);
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

bool isOk (mat2x3 a, mat2x3 b, float eps) { vec3 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec3 v_in0;
layout(location = 1) flat in float in1;
layout(location = 2) flat in ivec2 in2;
layout(binding = 0, std140) uniform Reference
{
	mat2x3 out0;
} ref;
mat2x3 out0;


void main()
{
    bvec3 in0 = bvec3(v_in0);

    out0 = mat2x3(in0, in1, in2);
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
	ivec2 in2;
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


void main()
{
    
    out0 = mat2x3(in0, in1, in2);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 2) in float in1;
layout(location = 3) in uvec2 a_in2;
layout(location = 0) flat out mat2x3 out0;


void main()
{
    bvec2 in2 = bvec2(a_in2);

    out0 = mat2x3(in0, in1, in2);
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
layout(location = 3) in uvec2 a_in2;
layout(location = 2) flat out uvec2 v_in2;

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

bool isOk (mat2x3 a, mat2x3 b, float eps) { vec3 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec3 in0;
layout(location = 1) flat in float in1;
layout(location = 2) flat in uvec2 v_in2;
layout(binding = 0, std140) uniform Reference
{
	mat2x3 out0;
} ref;
mat2x3 out0;


void main()
{
    bvec2 in2 = bvec2(v_in2);

    out0 = mat2x3(in0, in1, in2);
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
	bvec2 in2;
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


void main()
{
    
    out0 = mat2x3(in0, in1, in2);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 2) in vec3 in1;
layout(location = 3) in vec2 in2;
layout(location = 0) flat out mat2x4 out0;


void main()
{
    
    out0 = mat2x4(in0, in1, in2);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 a_in0;
layout(location = 0) flat out vec3 in0;
layout(location = 2) in vec3 a_in1;
layout(location = 1) flat out vec3 in1;
layout(location = 3) in vec2 a_in2;
layout(location = 2) flat out vec2 in2;

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

bool isOk (mat2x4 a, mat2x4 b, float eps) { vec4 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec3 in0;
layout(location = 1) flat in vec3 in1;
layout(location = 2) flat in vec2 in2;
layout(binding = 0, std140) uniform Reference
{
	mat2x4 out0;
} ref;
mat2x4 out0;


void main()
{
    
    out0 = mat2x4(in0, in1, in2);
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
	vec3 in1;
	vec2 in2;
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


void main()
{
    
    out0 = mat2x4(in0, in1, in2);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec3 in0;
layout(location = 2) in ivec3 in1;
layout(location = 3) in ivec2 in2;
layout(location = 0) flat out mat2x4 out0;


void main()
{
    
    out0 = mat2x4(in0, in1, in2);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec3 a_in0;
layout(location = 0) flat out ivec3 in0;
layout(location = 2) in ivec3 a_in1;
layout(location = 1) flat out ivec3 in1;
layout(location = 3) in ivec2 a_in2;
layout(location = 2) flat out ivec2 in2;

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

bool isOk (mat2x4 a, mat2x4 b, float eps) { vec4 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec3 in0;
layout(location = 1) flat in ivec3 in1;
layout(location = 2) flat in ivec2 in2;
layout(binding = 0, std140) uniform Reference
{
	mat2x4 out0;
} ref;
mat2x4 out0;


void main()
{
    
    out0 = mat2x4(in0, in1, in2);
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
	ivec3 in1;
	ivec2 in2;
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


void main()
{
    
    out0 = mat2x4(in0, in1, in2);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 in0;
layout(location = 2) in ivec2 in1;
layout(location = 3) in float in2;
layout(location = 4) in float in3;
layout(location = 5) in int in4;
layout(location = 6) in uint a_in5;
layout(location = 0) flat out mat2x4 out0;


void main()
{
    bool in5 = bool(a_in5);

    out0 = mat2x4(in0, in1, in2, in3, in4, in5);
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
layout(location = 3) in float a_in2;
layout(location = 2) flat out float in2;
layout(location = 4) in float a_in3;
layout(location = 3) flat out float in3;
layout(location = 5) in int a_in4;
layout(location = 4) flat out int in4;
layout(location = 6) in uint a_in5;
layout(location = 5) flat out uint v_in5;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
    in1 = a_in1;
    in2 = a_in2;
    in3 = a_in3;
    in4 = a_in4;
    v_in5 = a_in5;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat2x4 a, mat2x4 b, float eps) { vec4 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec2 in0;
layout(location = 1) flat in ivec2 in1;
layout(location = 2) flat in float in2;
layout(location = 3) flat in float in3;
layout(location = 4) flat in int in4;
layout(location = 5) flat in uint v_in5;
layout(binding = 0, std140) uniform Reference
{
	mat2x4 out0;
} ref;
mat2x4 out0;


void main()
{
    bool in5 = bool(v_in5);

    out0 = mat2x4(in0, in1, in2, in3, in4, in5);
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
	float in2;
	float in3;
	int in4;
	bool in5;
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


void main()
{
    
    out0 = mat2x4(in0, in1, in2, in3, in4, in5);
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
layout(location = 4) in vec2 in3;
layout(location = 5) in uint a_in4;
layout(location = 6) in uvec2 a_in5;
layout(location = 0) flat out mat2x4 out0;


void main()
{
    bool in0 = bool(a_in0);
bool in4 = bool(a_in4);
bvec2 in5 = bvec2(a_in5);

    out0 = mat2x4(in0, in1, in2, in3, in4, in5);
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
layout(location = 4) in vec2 a_in3;
layout(location = 3) flat out vec2 in3;
layout(location = 5) in uint a_in4;
layout(location = 4) flat out uint v_in4;
layout(location = 6) in uvec2 a_in5;
layout(location = 5) flat out uvec2 v_in5;

void main()
{
    gl_Position = dEQP_Position;
    v_in0 = a_in0;
    in1 = a_in1;
    in2 = a_in2;
    in3 = a_in3;
    v_in4 = a_in4;
    v_in5 = a_in5;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat2x4 a, mat2x4 b, float eps) { vec4 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(location = 1) flat in float in1;
layout(location = 2) flat in int in2;
layout(location = 3) flat in vec2 in3;
layout(location = 4) flat in uint v_in4;
layout(location = 5) flat in uvec2 v_in5;
layout(binding = 0, std140) uniform Reference
{
	mat2x4 out0;
} ref;
mat2x4 out0;


void main()
{
    bool in0 = bool(v_in0);
bool in4 = bool(v_in4);
bvec2 in5 = bvec2(v_in5);

    out0 = mat2x4(in0, in1, in2, in3, in4, in5);
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
	vec2 in3;
	bool in4;
	bvec2 in5;
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


void main()
{
    
    out0 = mat2x4(in0, in1, in2, in3, in4, in5);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 2) in uvec2 a_in1;
layout(location = 3) in int in2;
layout(location = 4) in vec4 in3;
layout(location = 0) flat out mat2x4 out0;


void main()
{
    bool in0 = bool(a_in0);
bvec2 in1 = bvec2(a_in1);

    out0 = mat2x4(in0, in1, in2, in3);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 0) flat out uint v_in0;
layout(location = 2) in uvec2 a_in1;
layout(location = 1) flat out uvec2 v_in1;
layout(location = 3) in int a_in2;
layout(location = 2) flat out int in2;
layout(location = 4) in vec4 a_in3;
layout(location = 3) flat out vec4 in3;

void main()
{
    gl_Position = dEQP_Position;
    v_in0 = a_in0;
    v_in1 = a_in1;
    in2 = a_in2;
    in3 = a_in3;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat2x4 a, mat2x4 b, float eps) { vec4 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(location = 1) flat in uvec2 v_in1;
layout(location = 2) flat in int in2;
layout(location = 3) flat in vec4 in3;
layout(binding = 0, std140) uniform Reference
{
	mat2x4 out0;
} ref;
mat2x4 out0;


void main()
{
    bool in0 = bool(v_in0);
bvec2 in1 = bvec2(v_in1);

    out0 = mat2x4(in0, in1, in2, in3);
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
	bvec2 in1;
	int in2;
	vec4 in3;
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


void main()
{
    
    out0 = mat2x4(in0, in1, in2, in3);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 2) in uvec4 a_in1;
layout(location = 3) in ivec2 in2;
layout(location = 4) in uint a_in3;
layout(location = 0) flat out mat2x4 out0;


void main()
{
    bvec4 in1 = bvec4(a_in1);
bool in3 = bool(a_in3);

    out0 = mat2x4(in0, in1, in2, in3);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float a_in0;
layout(location = 0) flat out float in0;
layout(location = 2) in uvec4 a_in1;
layout(location = 1) flat out uvec4 v_in1;
layout(location = 3) in ivec2 a_in2;
layout(location = 2) flat out ivec2 in2;
layout(location = 4) in uint a_in3;
layout(location = 3) flat out uint v_in3;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
    v_in1 = a_in1;
    in2 = a_in2;
    v_in3 = a_in3;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat2x4 a, mat2x4 b, float eps) { vec4 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(location = 1) flat in uvec4 v_in1;
layout(location = 2) flat in ivec2 in2;
layout(location = 3) flat in uint v_in3;
layout(binding = 0, std140) uniform Reference
{
	mat2x4 out0;
} ref;
mat2x4 out0;


void main()
{
    bvec4 in1 = bvec4(v_in1);
bool in3 = bool(v_in3);

    out0 = mat2x4(in0, in1, in2, in3);
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
	bvec4 in1;
	ivec2 in2;
	bool in3;
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


void main()
{
    
    out0 = mat2x4(in0, in1, in2, in3);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 2) in vec3 in1;
layout(location = 0) flat out mat3x2 out0;


void main()
{
    
    out0 = mat3x2(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat3x2 a, mat3x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec3 in0;
layout(location = 1) flat in vec3 in1;
layout(binding = 0, std140) uniform Reference
{
	mat3x2 out0;
} ref;
mat3x2 out0;


void main()
{
    
    out0 = mat3x2(in0, in1);
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
	vec3 in1;
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


void main()
{
    
    out0 = mat3x2(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 a_in0;
layout(location = 2) in uvec3 a_in1;
layout(location = 0) flat out mat3x2 out0;


void main()
{
    bvec3 in0 = bvec3(a_in0);
bvec3 in1 = bvec3(a_in1);

    out0 = mat3x2(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat3x2 a, mat3x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec3 v_in0;
layout(location = 1) flat in uvec3 v_in1;
layout(binding = 0, std140) uniform Reference
{
	mat3x2 out0;
} ref;
mat3x2 out0;


void main()
{
    bvec3 in0 = bvec3(v_in0);
bvec3 in1 = bvec3(v_in1);

    out0 = mat3x2(in0, in1);
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
	bvec3 in1;
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


void main()
{
    
    out0 = mat3x2(in0, in1);
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
layout(location = 5) in float in4;
layout(location = 6) in float in5;
layout(location = 0) flat out mat3x2 out0;


void main()
{
    
    out0 = mat3x2(in0, in1, in2, in3, in4, in5);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat3x2 a, mat3x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(location = 1) flat in float in1;
layout(location = 2) flat in float in2;
layout(location = 3) flat in float in3;
layout(location = 4) flat in float in4;
layout(location = 5) flat in float in5;
layout(binding = 0, std140) uniform Reference
{
	mat3x2 out0;
} ref;
mat3x2 out0;


void main()
{
    
    out0 = mat3x2(in0, in1, in2, in3, in4, in5);
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
	float in4;
	float in5;
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


void main()
{
    
    out0 = mat3x2(in0, in1, in2, in3, in4, in5);
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
layout(location = 5) in int in4;
layout(location = 6) in int in5;
layout(location = 0) flat out mat3x2 out0;


void main()
{
    
    out0 = mat3x2(in0, in1, in2, in3, in4, in5);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat3x2 a, mat3x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in int in0;
layout(location = 1) flat in int in1;
layout(location = 2) flat in int in2;
layout(location = 3) flat in int in3;
layout(location = 4) flat in int in4;
layout(location = 5) flat in int in5;
layout(binding = 0, std140) uniform Reference
{
	mat3x2 out0;
} ref;
mat3x2 out0;


void main()
{
    
    out0 = mat3x2(in0, in1, in2, in3, in4, in5);
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
	int in4;
	int in5;
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


void main()
{
    
    out0 = mat3x2(in0, in1, in2, in3, in4, in5);
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
layout(location = 5) in uint a_in4;
layout(location = 6) in uint a_in5;
layout(location = 0) flat out mat3x2 out0;


void main()
{
    bool in0 = bool(a_in0);
bool in1 = bool(a_in1);
bool in2 = bool(a_in2);
bool in3 = bool(a_in3);
bool in4 = bool(a_in4);
bool in5 = bool(a_in5);

    out0 = mat3x2(in0, in1, in2, in3, in4, in5);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat3x2 a, mat3x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(location = 1) flat in uint v_in1;
layout(location = 2) flat in uint v_in2;
layout(location = 3) flat in uint v_in3;
layout(location = 4) flat in uint v_in4;
layout(location = 5) flat in uint v_in5;
layout(binding = 0, std140) uniform Reference
{
	mat3x2 out0;
} ref;
mat3x2 out0;


void main()
{
    bool in0 = bool(v_in0);
bool in1 = bool(v_in1);
bool in2 = bool(v_in2);
bool in3 = bool(v_in3);
bool in4 = bool(v_in4);
bool in5 = bool(v_in5);

    out0 = mat3x2(in0, in1, in2, in3, in4, in5);
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
	bool in4;
	bool in5;
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


void main()
{
    
    out0 = mat3x2(in0, in1, in2, in3, in4, in5);
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
layout(location = 5) in float in4;
layout(location = 6) in int in5;
layout(location = 0) flat out mat3x2 out0;


void main()
{
    bool in0 = bool(a_in0);
bool in3 = bool(a_in3);

    out0 = mat3x2(in0, in1, in2, in3, in4, in5);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat3x2 a, mat3x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(location = 1) flat in float in1;
layout(location = 2) flat in int in2;
layout(location = 3) flat in uint v_in3;
layout(location = 4) flat in float in4;
layout(location = 5) flat in int in5;
layout(binding = 0, std140) uniform Reference
{
	mat3x2 out0;
} ref;
mat3x2 out0;


void main()
{
    bool in0 = bool(v_in0);
bool in3 = bool(v_in3);

    out0 = mat3x2(in0, in1, in2, in3, in4, in5);
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
	float in4;
	int in5;
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


void main()
{
    
    out0 = mat3x2(in0, in1, in2, in3, in4, in5);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 2) in ivec3 in1;
layout(location = 0) flat out mat3x2 out0;


void main()
{
    
    out0 = mat3x2(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat3x2 a, mat3x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec3 in0;
layout(location = 1) flat in ivec3 in1;
layout(binding = 0, std140) uniform Reference
{
	mat3x2 out0;
} ref;
mat3x2 out0;


void main()
{
    
    out0 = mat3x2(in0, in1);
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
	ivec3 in1;
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


void main()
{
    
    out0 = mat3x2(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 in0;
layout(location = 2) in uvec4 a_in1;
layout(location = 0) flat out mat3x2 out0;


void main()
{
    bvec4 in1 = bvec4(a_in1);

    out0 = mat3x2(in0, in1);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat3x2 a, mat3x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec2 in0;
layout(location = 1) flat in uvec4 v_in1;
layout(binding = 0, std140) uniform Reference
{
	mat3x2 out0;
} ref;
mat3x2 out0;


void main()
{
    bvec4 in1 = bvec4(v_in1);

    out0 = mat3x2(in0, in1);
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
	bvec4 in1;
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


void main()
{
    
    out0 = mat3x2(in0, in1);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 a_in0;
layout(location = 2) in float in1;
layout(location = 3) in ivec2 in2;
layout(location = 0) flat out mat3x2 out0;


void main()
{
    bvec3 in0 = bvec3(a_in0);

    out0 = mat3x2(in0, in1, in2);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat3x2 a, mat3x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec3 v_in0;
layout(location = 1) flat in float in1;
layout(location = 2) flat in ivec2 in2;
layout(binding = 0, std140) uniform Reference
{
	mat3x2 out0;
} ref;
mat3x2 out0;


void main()
{
    bvec3 in0 = bvec3(v_in0);

    out0 = mat3x2(in0, in1, in2);
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
	ivec2 in2;
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


void main()
{
    
    out0 = mat3x2(in0, in1, in2);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 2) in float in1;
layout(location = 3) in uvec2 a_in2;
layout(location = 0) flat out mat3x2 out0;


void main()
{
    bvec2 in2 = bvec2(a_in2);

    out0 = mat3x2(in0, in1, in2);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat3x2 a, mat3x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec3 in0;
layout(location = 1) flat in float in1;
layout(location = 2) flat in uvec2 v_in2;
layout(binding = 0, std140) uniform Reference
{
	mat3x2 out0;
} ref;
mat3x2 out0;


void main()
{
    bvec2 in2 = bvec2(v_in2);

    out0 = mat3x2(in0, in1, in2);
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
	bvec2 in2;
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


void main()
{
    
    out0 = mat3x2(in0, in1, in2);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 2) in vec3 in1;
layout(location = 3) in vec3 in2;
layout(location = 0) flat out mat3 out0;


void main()
{
    
    out0 = mat3(in0, in1, in2);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 a_in0;
layout(location = 0) flat out vec3 in0;
layout(location = 2) in vec3 a_in1;
layout(location = 1) flat out vec3 in1;
layout(location = 3) in vec3 a_in2;
layout(location = 2) flat out vec3 in2;

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

bool isOk (mat3 a, mat3 b, float eps) { vec3 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec3 in0;
layout(location = 1) flat in vec3 in1;
layout(location = 2) flat in vec3 in2;
layout(binding = 0, std140) uniform Reference
{
	mat3 out0;
} ref;
mat3 out0;


void main()
{
    
    out0 = mat3(in0, in1, in2);
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
	vec3 in1;
	vec3 in2;
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


void main()
{
    
    out0 = mat3(in0, in1, in2);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec3 in0;
layout(location = 2) in ivec3 in1;
layout(location = 3) in ivec3 in2;
layout(location = 0) flat out mat3 out0;


void main()
{
    
    out0 = mat3(in0, in1, in2);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec3 a_in0;
layout(location = 0) flat out ivec3 in0;
layout(location = 2) in ivec3 a_in1;
layout(location = 1) flat out ivec3 in1;
layout(location = 3) in ivec3 a_in2;
layout(location = 2) flat out ivec3 in2;

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

bool isOk (mat3 a, mat3 b, float eps) { vec3 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec3 in0;
layout(location = 1) flat in ivec3 in1;
layout(location = 2) flat in ivec3 in2;
layout(binding = 0, std140) uniform Reference
{
	mat3 out0;
} ref;
mat3 out0;


void main()
{
    
    out0 = mat3(in0, in1, in2);
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
	ivec3 in1;
	ivec3 in2;
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


void main()
{
    
    out0 = mat3(in0, in1, in2);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 in0;
layout(location = 2) in ivec2 in1;
layout(location = 3) in float in2;
layout(location = 4) in float in3;
layout(location = 5) in int in4;
layout(location = 6) in uint a_in5;
layout(location = 7) in uint a_in6;
layout(location = 0) flat out mat3 out0;


void main()
{
    bool in5 = bool(a_in5);
bool in6 = bool(a_in6);

    out0 = mat3(in0, in1, in2, in3, in4, in5, in6);
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
layout(location = 3) in float a_in2;
layout(location = 2) flat out float in2;
layout(location = 4) in float a_in3;
layout(location = 3) flat out float in3;
layout(location = 5) in int a_in4;
layout(location = 4) flat out int in4;
layout(location = 6) in uint a_in5;
layout(location = 5) flat out uint v_in5;
layout(location = 7) in uint a_in6;
layout(location = 6) flat out uint v_in6;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
    in1 = a_in1;
    in2 = a_in2;
    in3 = a_in3;
    in4 = a_in4;
    v_in5 = a_in5;
    v_in6 = a_in6;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat3 a, mat3 b, float eps) { vec3 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec2 in0;
layout(location = 1) flat in ivec2 in1;
layout(location = 2) flat in float in2;
layout(location = 3) flat in float in3;
layout(location = 4) flat in int in4;
layout(location = 5) flat in uint v_in5;
layout(location = 6) flat in uint v_in6;
layout(binding = 0, std140) uniform Reference
{
	mat3 out0;
} ref;
mat3 out0;


void main()
{
    bool in5 = bool(v_in5);
bool in6 = bool(v_in6);

    out0 = mat3(in0, in1, in2, in3, in4, in5, in6);
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
	float in2;
	float in3;
	int in4;
	bool in5;
	bool in6;
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


void main()
{
    
    out0 = mat3(in0, in1, in2, in3, in4, in5, in6);
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
layout(location = 4) in vec2 in3;
layout(location = 5) in uint a_in4;
layout(location = 6) in uvec2 a_in5;
layout(location = 7) in float in6;
layout(location = 0) flat out mat3 out0;


void main()
{
    bool in0 = bool(a_in0);
bool in4 = bool(a_in4);
bvec2 in5 = bvec2(a_in5);

    out0 = mat3(in0, in1, in2, in3, in4, in5, in6);
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
layout(location = 4) in vec2 a_in3;
layout(location = 3) flat out vec2 in3;
layout(location = 5) in uint a_in4;
layout(location = 4) flat out uint v_in4;
layout(location = 6) in uvec2 a_in5;
layout(location = 5) flat out uvec2 v_in5;
layout(location = 7) in float a_in6;
layout(location = 6) flat out float in6;

void main()
{
    gl_Position = dEQP_Position;
    v_in0 = a_in0;
    in1 = a_in1;
    in2 = a_in2;
    in3 = a_in3;
    v_in4 = a_in4;
    v_in5 = a_in5;
    in6 = a_in6;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat3 a, mat3 b, float eps) { vec3 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(location = 1) flat in float in1;
layout(location = 2) flat in int in2;
layout(location = 3) flat in vec2 in3;
layout(location = 4) flat in uint v_in4;
layout(location = 5) flat in uvec2 v_in5;
layout(location = 6) flat in float in6;
layout(binding = 0, std140) uniform Reference
{
	mat3 out0;
} ref;
mat3 out0;


void main()
{
    bool in0 = bool(v_in0);
bool in4 = bool(v_in4);
bvec2 in5 = bvec2(v_in5);

    out0 = mat3(in0, in1, in2, in3, in4, in5, in6);
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
	vec2 in3;
	bool in4;
	bvec2 in5;
	float in6;
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


void main()
{
    
    out0 = mat3(in0, in1, in2, in3, in4, in5, in6);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 2) in uvec2 a_in1;
layout(location = 3) in int in2;
layout(location = 4) in vec4 in3;
layout(location = 5) in uint a_in4;
layout(location = 0) flat out mat3 out0;


void main()
{
    bool in0 = bool(a_in0);
bvec2 in1 = bvec2(a_in1);
bool in4 = bool(a_in4);

    out0 = mat3(in0, in1, in2, in3, in4);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 0) flat out uint v_in0;
layout(location = 2) in uvec2 a_in1;
layout(location = 1) flat out uvec2 v_in1;
layout(location = 3) in int a_in2;
layout(location = 2) flat out int in2;
layout(location = 4) in vec4 a_in3;
layout(location = 3) flat out vec4 in3;
layout(location = 5) in uint a_in4;
layout(location = 4) flat out uint v_in4;

void main()
{
    gl_Position = dEQP_Position;
    v_in0 = a_in0;
    v_in1 = a_in1;
    in2 = a_in2;
    in3 = a_in3;
    v_in4 = a_in4;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat3 a, mat3 b, float eps) { vec3 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(location = 1) flat in uvec2 v_in1;
layout(location = 2) flat in int in2;
layout(location = 3) flat in vec4 in3;
layout(location = 4) flat in uint v_in4;
layout(binding = 0, std140) uniform Reference
{
	mat3 out0;
} ref;
mat3 out0;


void main()
{
    bool in0 = bool(v_in0);
bvec2 in1 = bvec2(v_in1);
bool in4 = bool(v_in4);

    out0 = mat3(in0, in1, in2, in3, in4);
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
	bvec2 in1;
	int in2;
	vec4 in3;
	bool in4;
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


void main()
{
    
    out0 = mat3(in0, in1, in2, in3, in4);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 2) in uvec4 a_in1;
layout(location = 3) in ivec2 in2;
layout(location = 4) in uint a_in3;
layout(location = 5) in uint a_in4;
layout(location = 0) flat out mat3 out0;


void main()
{
    bvec4 in1 = bvec4(a_in1);
bool in3 = bool(a_in3);
bool in4 = bool(a_in4);

    out0 = mat3(in0, in1, in2, in3, in4);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float a_in0;
layout(location = 0) flat out float in0;
layout(location = 2) in uvec4 a_in1;
layout(location = 1) flat out uvec4 v_in1;
layout(location = 3) in ivec2 a_in2;
layout(location = 2) flat out ivec2 in2;
layout(location = 4) in uint a_in3;
layout(location = 3) flat out uint v_in3;
layout(location = 5) in uint a_in4;
layout(location = 4) flat out uint v_in4;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
    v_in1 = a_in1;
    in2 = a_in2;
    v_in3 = a_in3;
    v_in4 = a_in4;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat3 a, mat3 b, float eps) { vec3 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(location = 1) flat in uvec4 v_in1;
layout(location = 2) flat in ivec2 in2;
layout(location = 3) flat in uint v_in3;
layout(location = 4) flat in uint v_in4;
layout(binding = 0, std140) uniform Reference
{
	mat3 out0;
} ref;
mat3 out0;


void main()
{
    bvec4 in1 = bvec4(v_in1);
bool in3 = bool(v_in3);
bool in4 = bool(v_in4);

    out0 = mat3(in0, in1, in2, in3, in4);
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
	bvec4 in1;
	ivec2 in2;
	bool in3;
	bool in4;
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


void main()
{
    
    out0 = mat3(in0, in1, in2, in3, in4);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec4 in0;
layout(location = 2) in vec4 in1;
layout(location = 3) in vec4 in2;
layout(location = 0) flat out mat3x4 out0;


void main()
{
    
    out0 = mat3x4(in0, in1, in2);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec4 a_in0;
layout(location = 0) flat out vec4 in0;
layout(location = 2) in vec4 a_in1;
layout(location = 1) flat out vec4 in1;
layout(location = 3) in vec4 a_in2;
layout(location = 2) flat out vec4 in2;

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

bool isOk (mat3x4 a, mat3x4 b, float eps) { vec4 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec4 in0;
layout(location = 1) flat in vec4 in1;
layout(location = 2) flat in vec4 in2;
layout(binding = 0, std140) uniform Reference
{
	mat3x4 out0;
} ref;
mat3x4 out0;


void main()
{
    
    out0 = mat3x4(in0, in1, in2);
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
	vec4 in1;
	vec4 in2;
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


void main()
{
    
    out0 = mat3x4(in0, in1, in2);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec4 in0;
layout(location = 2) in ivec4 in1;
layout(location = 3) in ivec4 in2;
layout(location = 0) flat out mat3x4 out0;


void main()
{
    
    out0 = mat3x4(in0, in1, in2);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec4 a_in0;
layout(location = 0) flat out ivec4 in0;
layout(location = 2) in ivec4 a_in1;
layout(location = 1) flat out ivec4 in1;
layout(location = 3) in ivec4 a_in2;
layout(location = 2) flat out ivec4 in2;

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

bool isOk (mat3x4 a, mat3x4 b, float eps) { vec4 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec4 in0;
layout(location = 1) flat in ivec4 in1;
layout(location = 2) flat in ivec4 in2;
layout(binding = 0, std140) uniform Reference
{
	mat3x4 out0;
} ref;
mat3x4 out0;


void main()
{
    
    out0 = mat3x4(in0, in1, in2);
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
	ivec4 in1;
	ivec4 in2;
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


void main()
{
    
    out0 = mat3x4(in0, in1, in2);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 in0;
layout(location = 2) in ivec2 in1;
layout(location = 3) in float in2;
layout(location = 4) in float in3;
layout(location = 5) in float in4;
layout(location = 6) in int in5;
layout(location = 7) in int in6;
layout(location = 8) in uint a_in7;
layout(location = 9) in uint a_in8;
layout(location = 10) in uint a_in9;
layout(location = 0) flat out mat3x4 out0;


void main()
{
    bool in7 = bool(a_in7);
bool in8 = bool(a_in8);
bool in9 = bool(a_in9);

    out0 = mat3x4(in0, in1, in2, in3, in4, in5, in6, in7, in8, in9);
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
layout(location = 3) in float a_in2;
layout(location = 2) flat out float in2;
layout(location = 4) in float a_in3;
layout(location = 3) flat out float in3;
layout(location = 5) in float a_in4;
layout(location = 4) flat out float in4;
layout(location = 6) in int a_in5;
layout(location = 5) flat out int in5;
layout(location = 7) in int a_in6;
layout(location = 6) flat out int in6;
layout(location = 8) in uint a_in7;
layout(location = 7) flat out uint v_in7;
layout(location = 9) in uint a_in8;
layout(location = 8) flat out uint v_in8;
layout(location = 10) in uint a_in9;
layout(location = 9) flat out uint v_in9;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
    in1 = a_in1;
    in2 = a_in2;
    in3 = a_in3;
    in4 = a_in4;
    in5 = a_in5;
    in6 = a_in6;
    v_in7 = a_in7;
    v_in8 = a_in8;
    v_in9 = a_in9;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat3x4 a, mat3x4 b, float eps) { vec4 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec2 in0;
layout(location = 1) flat in ivec2 in1;
layout(location = 2) flat in float in2;
layout(location = 3) flat in float in3;
layout(location = 4) flat in float in4;
layout(location = 5) flat in int in5;
layout(location = 6) flat in int in6;
layout(location = 7) flat in uint v_in7;
layout(location = 8) flat in uint v_in8;
layout(location = 9) flat in uint v_in9;
layout(binding = 0, std140) uniform Reference
{
	mat3x4 out0;
} ref;
mat3x4 out0;


void main()
{
    bool in7 = bool(v_in7);
bool in8 = bool(v_in8);
bool in9 = bool(v_in9);

    out0 = mat3x4(in0, in1, in2, in3, in4, in5, in6, in7, in8, in9);
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
	float in2;
	float in3;
	float in4;
	int in5;
	int in6;
	bool in7;
	bool in8;
	bool in9;
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


void main()
{
    
    out0 = mat3x4(in0, in1, in2, in3, in4, in5, in6, in7, in8, in9);
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
layout(location = 4) in vec3 in3;
layout(location = 5) in uint a_in4;
layout(location = 6) in uvec3 a_in5;
layout(location = 7) in float in6;
layout(location = 8) in uint a_in7;
layout(location = 0) flat out mat3x4 out0;


void main()
{
    bool in0 = bool(a_in0);
bool in4 = bool(a_in4);
bvec3 in5 = bvec3(a_in5);
bool in7 = bool(a_in7);

    out0 = mat3x4(in0, in1, in2, in3, in4, in5, in6, in7);
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
layout(location = 4) in vec3 a_in3;
layout(location = 3) flat out vec3 in3;
layout(location = 5) in uint a_in4;
layout(location = 4) flat out uint v_in4;
layout(location = 6) in uvec3 a_in5;
layout(location = 5) flat out uvec3 v_in5;
layout(location = 7) in float a_in6;
layout(location = 6) flat out float in6;
layout(location = 8) in uint a_in7;
layout(location = 7) flat out uint v_in7;

void main()
{
    gl_Position = dEQP_Position;
    v_in0 = a_in0;
    in1 = a_in1;
    in2 = a_in2;
    in3 = a_in3;
    v_in4 = a_in4;
    v_in5 = a_in5;
    in6 = a_in6;
    v_in7 = a_in7;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat3x4 a, mat3x4 b, float eps) { vec4 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(location = 1) flat in float in1;
layout(location = 2) flat in int in2;
layout(location = 3) flat in vec3 in3;
layout(location = 4) flat in uint v_in4;
layout(location = 5) flat in uvec3 v_in5;
layout(location = 6) flat in float in6;
layout(location = 7) flat in uint v_in7;
layout(binding = 0, std140) uniform Reference
{
	mat3x4 out0;
} ref;
mat3x4 out0;


void main()
{
    bool in0 = bool(v_in0);
bool in4 = bool(v_in4);
bvec3 in5 = bvec3(v_in5);
bool in7 = bool(v_in7);

    out0 = mat3x4(in0, in1, in2, in3, in4, in5, in6, in7);
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
	vec3 in3;
	bool in4;
	bvec3 in5;
	float in6;
	bool in7;
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


void main()
{
    
    out0 = mat3x4(in0, in1, in2, in3, in4, in5, in6, in7);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 2) in uvec4 a_in1;
layout(location = 3) in int in2;
layout(location = 4) in vec4 in3;
layout(location = 5) in uint a_in4;
layout(location = 6) in float in5;
layout(location = 0) flat out mat3x4 out0;


void main()
{
    bool in0 = bool(a_in0);
bvec4 in1 = bvec4(a_in1);
bool in4 = bool(a_in4);

    out0 = mat3x4(in0, in1, in2, in3, in4, in5);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 0) flat out uint v_in0;
layout(location = 2) in uvec4 a_in1;
layout(location = 1) flat out uvec4 v_in1;
layout(location = 3) in int a_in2;
layout(location = 2) flat out int in2;
layout(location = 4) in vec4 a_in3;
layout(location = 3) flat out vec4 in3;
layout(location = 5) in uint a_in4;
layout(location = 4) flat out uint v_in4;
layout(location = 6) in float a_in5;
layout(location = 5) flat out float in5;

void main()
{
    gl_Position = dEQP_Position;
    v_in0 = a_in0;
    v_in1 = a_in1;
    in2 = a_in2;
    in3 = a_in3;
    v_in4 = a_in4;
    in5 = a_in5;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat3x4 a, mat3x4 b, float eps) { vec4 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(location = 1) flat in uvec4 v_in1;
layout(location = 2) flat in int in2;
layout(location = 3) flat in vec4 in3;
layout(location = 4) flat in uint v_in4;
layout(location = 5) flat in float in5;
layout(binding = 0, std140) uniform Reference
{
	mat3x4 out0;
} ref;
mat3x4 out0;


void main()
{
    bool in0 = bool(v_in0);
bvec4 in1 = bvec4(v_in1);
bool in4 = bool(v_in4);

    out0 = mat3x4(in0, in1, in2, in3, in4, in5);
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
	bvec4 in1;
	int in2;
	vec4 in3;
	bool in4;
	float in5;
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


void main()
{
    
    out0 = mat3x4(in0, in1, in2, in3, in4, in5);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 2) in uvec4 a_in1;
layout(location = 3) in ivec4 in2;
layout(location = 4) in uint a_in3;
layout(location = 5) in uint a_in4;
layout(location = 6) in int in5;
layout(location = 0) flat out mat3x4 out0;


void main()
{
    bvec4 in1 = bvec4(a_in1);
bool in3 = bool(a_in3);
bool in4 = bool(a_in4);

    out0 = mat3x4(in0, in1, in2, in3, in4, in5);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float a_in0;
layout(location = 0) flat out float in0;
layout(location = 2) in uvec4 a_in1;
layout(location = 1) flat out uvec4 v_in1;
layout(location = 3) in ivec4 a_in2;
layout(location = 2) flat out ivec4 in2;
layout(location = 4) in uint a_in3;
layout(location = 3) flat out uint v_in3;
layout(location = 5) in uint a_in4;
layout(location = 4) flat out uint v_in4;
layout(location = 6) in int a_in5;
layout(location = 5) flat out int in5;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
    v_in1 = a_in1;
    in2 = a_in2;
    v_in3 = a_in3;
    v_in4 = a_in4;
    in5 = a_in5;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat3x4 a, mat3x4 b, float eps) { vec4 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(location = 1) flat in uvec4 v_in1;
layout(location = 2) flat in ivec4 in2;
layout(location = 3) flat in uint v_in3;
layout(location = 4) flat in uint v_in4;
layout(location = 5) flat in int in5;
layout(binding = 0, std140) uniform Reference
{
	mat3x4 out0;
} ref;
mat3x4 out0;


void main()
{
    bvec4 in1 = bvec4(v_in1);
bool in3 = bool(v_in3);
bool in4 = bool(v_in4);

    out0 = mat3x4(in0, in1, in2, in3, in4, in5);
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
	bvec4 in1;
	ivec4 in2;
	bool in3;
	bool in4;
	int in5;
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


void main()
{
    
    out0 = mat3x4(in0, in1, in2, in3, in4, in5);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 2) in vec3 in1;
layout(location = 3) in vec2 in2;
layout(location = 0) flat out mat4x2 out0;


void main()
{
    
    out0 = mat4x2(in0, in1, in2);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat4x2 a, mat4x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec3 in0;
layout(location = 1) flat in vec3 in1;
layout(location = 2) flat in vec2 in2;
layout(binding = 0, std140) uniform Reference
{
	mat4x2 out0;
} ref;
mat4x2 out0;


void main()
{
    
    out0 = mat4x2(in0, in1, in2);
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
	vec3 in1;
	vec2 in2;
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


void main()
{
    
    out0 = mat4x2(in0, in1, in2);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec3 in0;
layout(location = 2) in ivec3 in1;
layout(location = 3) in ivec2 in2;
layout(location = 0) flat out mat4x2 out0;


void main()
{
    
    out0 = mat4x2(in0, in1, in2);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat4x2 a, mat4x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec3 in0;
layout(location = 1) flat in ivec3 in1;
layout(location = 2) flat in ivec2 in2;
layout(binding = 0, std140) uniform Reference
{
	mat4x2 out0;
} ref;
mat4x2 out0;


void main()
{
    
    out0 = mat4x2(in0, in1, in2);
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
	ivec3 in1;
	ivec2 in2;
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


void main()
{
    
    out0 = mat4x2(in0, in1, in2);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 in0;
layout(location = 2) in ivec2 in1;
layout(location = 3) in float in2;
layout(location = 4) in float in3;
layout(location = 5) in int in4;
layout(location = 6) in uint a_in5;
layout(location = 0) flat out mat4x2 out0;


void main()
{
    bool in5 = bool(a_in5);

    out0 = mat4x2(in0, in1, in2, in3, in4, in5);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat4x2 a, mat4x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec2 in0;
layout(location = 1) flat in ivec2 in1;
layout(location = 2) flat in float in2;
layout(location = 3) flat in float in3;
layout(location = 4) flat in int in4;
layout(location = 5) flat in uint v_in5;
layout(binding = 0, std140) uniform Reference
{
	mat4x2 out0;
} ref;
mat4x2 out0;


void main()
{
    bool in5 = bool(v_in5);

    out0 = mat4x2(in0, in1, in2, in3, in4, in5);
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
	float in2;
	float in3;
	int in4;
	bool in5;
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


void main()
{
    
    out0 = mat4x2(in0, in1, in2, in3, in4, in5);
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
layout(location = 4) in vec2 in3;
layout(location = 5) in uint a_in4;
layout(location = 6) in uvec2 a_in5;
layout(location = 0) flat out mat4x2 out0;


void main()
{
    bool in0 = bool(a_in0);
bool in4 = bool(a_in4);
bvec2 in5 = bvec2(a_in5);

    out0 = mat4x2(in0, in1, in2, in3, in4, in5);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat4x2 a, mat4x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(location = 1) flat in float in1;
layout(location = 2) flat in int in2;
layout(location = 3) flat in vec2 in3;
layout(location = 4) flat in uint v_in4;
layout(location = 5) flat in uvec2 v_in5;
layout(binding = 0, std140) uniform Reference
{
	mat4x2 out0;
} ref;
mat4x2 out0;


void main()
{
    bool in0 = bool(v_in0);
bool in4 = bool(v_in4);
bvec2 in5 = bvec2(v_in5);

    out0 = mat4x2(in0, in1, in2, in3, in4, in5);
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
	vec2 in3;
	bool in4;
	bvec2 in5;
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


void main()
{
    
    out0 = mat4x2(in0, in1, in2, in3, in4, in5);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 2) in uvec2 a_in1;
layout(location = 3) in int in2;
layout(location = 4) in vec4 in3;
layout(location = 0) flat out mat4x2 out0;


void main()
{
    bool in0 = bool(a_in0);
bvec2 in1 = bvec2(a_in1);

    out0 = mat4x2(in0, in1, in2, in3);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat4x2 a, mat4x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(location = 1) flat in uvec2 v_in1;
layout(location = 2) flat in int in2;
layout(location = 3) flat in vec4 in3;
layout(binding = 0, std140) uniform Reference
{
	mat4x2 out0;
} ref;
mat4x2 out0;


void main()
{
    bool in0 = bool(v_in0);
bvec2 in1 = bvec2(v_in1);

    out0 = mat4x2(in0, in1, in2, in3);
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
	bvec2 in1;
	int in2;
	vec4 in3;
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


void main()
{
    
    out0 = mat4x2(in0, in1, in2, in3);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 2) in uvec4 a_in1;
layout(location = 3) in ivec2 in2;
layout(location = 4) in uint a_in3;
layout(location = 0) flat out mat4x2 out0;


void main()
{
    bvec4 in1 = bvec4(a_in1);
bool in3 = bool(a_in3);

    out0 = mat4x2(in0, in1, in2, in3);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat4x2 a, mat4x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(location = 1) flat in uvec4 v_in1;
layout(location = 2) flat in ivec2 in2;
layout(location = 3) flat in uint v_in3;
layout(binding = 0, std140) uniform Reference
{
	mat4x2 out0;
} ref;
mat4x2 out0;


void main()
{
    bvec4 in1 = bvec4(v_in1);
bool in3 = bool(v_in3);

    out0 = mat4x2(in0, in1, in2, in3);
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
	bvec4 in1;
	ivec2 in2;
	bool in3;
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


void main()
{
    
    out0 = mat4x2(in0, in1, in2, in3);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec4 in0;
layout(location = 2) in vec4 in1;
layout(location = 3) in vec4 in2;
layout(location = 0) flat out mat4x3 out0;


void main()
{
    
    out0 = mat4x3(in0, in1, in2);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat4x3 a, mat4x3 b, float eps) { vec3 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec4 in0;
layout(location = 1) flat in vec4 in1;
layout(location = 2) flat in vec4 in2;
layout(binding = 0, std140) uniform Reference
{
	mat4x3 out0;
} ref;
mat4x3 out0;


void main()
{
    
    out0 = mat4x3(in0, in1, in2);
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
	vec4 in1;
	vec4 in2;
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


void main()
{
    
    out0 = mat4x3(in0, in1, in2);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec4 in0;
layout(location = 2) in ivec4 in1;
layout(location = 3) in ivec4 in2;
layout(location = 0) flat out mat4x3 out0;


void main()
{
    
    out0 = mat4x3(in0, in1, in2);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat4x3 a, mat4x3 b, float eps) { vec3 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec4 in0;
layout(location = 1) flat in ivec4 in1;
layout(location = 2) flat in ivec4 in2;
layout(binding = 0, std140) uniform Reference
{
	mat4x3 out0;
} ref;
mat4x3 out0;


void main()
{
    
    out0 = mat4x3(in0, in1, in2);
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
	ivec4 in1;
	ivec4 in2;
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


void main()
{
    
    out0 = mat4x3(in0, in1, in2);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec2 in0;
layout(location = 2) in ivec2 in1;
layout(location = 3) in float in2;
layout(location = 4) in float in3;
layout(location = 5) in float in4;
layout(location = 6) in int in5;
layout(location = 7) in int in6;
layout(location = 8) in uint a_in7;
layout(location = 9) in uint a_in8;
layout(location = 10) in uint a_in9;
layout(location = 0) flat out mat4x3 out0;


void main()
{
    bool in7 = bool(a_in7);
bool in8 = bool(a_in8);
bool in9 = bool(a_in9);

    out0 = mat4x3(in0, in1, in2, in3, in4, in5, in6, in7, in8, in9);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat4x3 a, mat4x3 b, float eps) { vec3 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec2 in0;
layout(location = 1) flat in ivec2 in1;
layout(location = 2) flat in float in2;
layout(location = 3) flat in float in3;
layout(location = 4) flat in float in4;
layout(location = 5) flat in int in5;
layout(location = 6) flat in int in6;
layout(location = 7) flat in uint v_in7;
layout(location = 8) flat in uint v_in8;
layout(location = 9) flat in uint v_in9;
layout(binding = 0, std140) uniform Reference
{
	mat4x3 out0;
} ref;
mat4x3 out0;


void main()
{
    bool in7 = bool(v_in7);
bool in8 = bool(v_in8);
bool in9 = bool(v_in9);

    out0 = mat4x3(in0, in1, in2, in3, in4, in5, in6, in7, in8, in9);
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
	float in2;
	float in3;
	float in4;
	int in5;
	int in6;
	bool in7;
	bool in8;
	bool in9;
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


void main()
{
    
    out0 = mat4x3(in0, in1, in2, in3, in4, in5, in6, in7, in8, in9);
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
layout(location = 4) in vec3 in3;
layout(location = 5) in uint a_in4;
layout(location = 6) in uvec3 a_in5;
layout(location = 7) in float in6;
layout(location = 8) in uint a_in7;
layout(location = 0) flat out mat4x3 out0;


void main()
{
    bool in0 = bool(a_in0);
bool in4 = bool(a_in4);
bvec3 in5 = bvec3(a_in5);
bool in7 = bool(a_in7);

    out0 = mat4x3(in0, in1, in2, in3, in4, in5, in6, in7);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat4x3 a, mat4x3 b, float eps) { vec3 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(location = 1) flat in float in1;
layout(location = 2) flat in int in2;
layout(location = 3) flat in vec3 in3;
layout(location = 4) flat in uint v_in4;
layout(location = 5) flat in uvec3 v_in5;
layout(location = 6) flat in float in6;
layout(location = 7) flat in uint v_in7;
layout(binding = 0, std140) uniform Reference
{
	mat4x3 out0;
} ref;
mat4x3 out0;


void main()
{
    bool in0 = bool(v_in0);
bool in4 = bool(v_in4);
bvec3 in5 = bvec3(v_in5);
bool in7 = bool(v_in7);

    out0 = mat4x3(in0, in1, in2, in3, in4, in5, in6, in7);
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
	vec3 in3;
	bool in4;
	bvec3 in5;
	float in6;
	bool in7;
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


void main()
{
    
    out0 = mat4x3(in0, in1, in2, in3, in4, in5, in6, in7);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uint a_in0;
layout(location = 2) in uvec4 a_in1;
layout(location = 3) in int in2;
layout(location = 4) in vec4 in3;
layout(location = 5) in uint a_in4;
layout(location = 6) in float in5;
layout(location = 0) flat out mat4x3 out0;


void main()
{
    bool in0 = bool(a_in0);
bvec4 in1 = bvec4(a_in1);
bool in4 = bool(a_in4);

    out0 = mat4x3(in0, in1, in2, in3, in4, in5);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat4x3 a, mat4x3 b, float eps) { vec3 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(location = 1) flat in uvec4 v_in1;
layout(location = 2) flat in int in2;
layout(location = 3) flat in vec4 in3;
layout(location = 4) flat in uint v_in4;
layout(location = 5) flat in float in5;
layout(binding = 0, std140) uniform Reference
{
	mat4x3 out0;
} ref;
mat4x3 out0;


void main()
{
    bool in0 = bool(v_in0);
bvec4 in1 = bvec4(v_in1);
bool in4 = bool(v_in4);

    out0 = mat4x3(in0, in1, in2, in3, in4, in5);
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
	bvec4 in1;
	int in2;
	vec4 in3;
	bool in4;
	float in5;
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


void main()
{
    
    out0 = mat4x3(in0, in1, in2, in3, in4, in5);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 2) in uvec4 a_in1;
layout(location = 3) in ivec4 in2;
layout(location = 4) in uint a_in3;
layout(location = 5) in uint a_in4;
layout(location = 6) in int in5;
layout(location = 0) flat out mat4x3 out0;


void main()
{
    bvec4 in1 = bvec4(a_in1);
bool in3 = bool(a_in3);
bool in4 = bool(a_in4);

    out0 = mat4x3(in0, in1, in2, in3, in4, in5);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat4x3 a, mat4x3 b, float eps) { vec3 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(location = 1) flat in uvec4 v_in1;
layout(location = 2) flat in ivec4 in2;
layout(location = 3) flat in uint v_in3;
layout(location = 4) flat in uint v_in4;
layout(location = 5) flat in int in5;
layout(binding = 0, std140) uniform Reference
{
	mat4x3 out0;
} ref;
mat4x3 out0;


void main()
{
    bvec4 in1 = bvec4(v_in1);
bool in3 = bool(v_in3);
bool in4 = bool(v_in4);

    out0 = mat4x3(in0, in1, in2, in3, in4, in5);
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
	bvec4 in1;
	ivec4 in2;
	bool in3;
	bool in4;
	int in5;
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


void main()
{
    
    out0 = mat4x3(in0, in1, in2, in3, in4, in5);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec4 in0;
layout(location = 2) in vec4 in1;
layout(location = 3) in vec4 in2;
layout(location = 4) in vec4 in3;
layout(location = 0) flat out mat4 out0;


void main()
{
    
    out0 = mat4(in0, in1, in2, in3);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec4 a_in0;
layout(location = 0) flat out vec4 in0;
layout(location = 2) in vec4 a_in1;
layout(location = 1) flat out vec4 in1;
layout(location = 3) in vec4 a_in2;
layout(location = 2) flat out vec4 in2;
layout(location = 4) in vec4 a_in3;
layout(location = 3) flat out vec4 in3;

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

bool isOk (mat4 a, mat4 b, float eps) { vec4 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec4 in0;
layout(location = 1) flat in vec4 in1;
layout(location = 2) flat in vec4 in2;
layout(location = 3) flat in vec4 in3;
layout(binding = 0, std140) uniform Reference
{
	mat4 out0;
} ref;
mat4 out0;


void main()
{
    
    out0 = mat4(in0, in1, in2, in3);
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
	vec4 in1;
	vec4 in2;
	vec4 in3;
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


void main()
{
    
    out0 = mat4(in0, in1, in2, in3);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec4 in0;
layout(location = 2) in ivec4 in1;
layout(location = 3) in ivec4 in2;
layout(location = 4) in ivec4 in3;
layout(location = 0) flat out mat4 out0;


void main()
{
    
    out0 = mat4(in0, in1, in2, in3);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec4 a_in0;
layout(location = 0) flat out ivec4 in0;
layout(location = 2) in ivec4 a_in1;
layout(location = 1) flat out ivec4 in1;
layout(location = 3) in ivec4 a_in2;
layout(location = 2) flat out ivec4 in2;
layout(location = 4) in ivec4 a_in3;
layout(location = 3) flat out ivec4 in3;

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

bool isOk (mat4 a, mat4 b, float eps) { vec4 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec4 in0;
layout(location = 1) flat in ivec4 in1;
layout(location = 2) flat in ivec4 in2;
layout(location = 3) flat in ivec4 in3;
layout(binding = 0, std140) uniform Reference
{
	mat4 out0;
} ref;
mat4 out0;


void main()
{
    
    out0 = mat4(in0, in1, in2, in3);
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
	ivec4 in1;
	ivec4 in2;
	ivec4 in3;
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


void main()
{
    
    out0 = mat4(in0, in1, in2, in3);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec4 a_in0;
layout(location = 2) in uvec4 a_in1;
layout(location = 3) in uvec4 a_in2;
layout(location = 4) in uvec4 a_in3;
layout(location = 0) flat out mat4 out0;


void main()
{
    bvec4 in0 = bvec4(a_in0);
bvec4 in1 = bvec4(a_in1);
bvec4 in2 = bvec4(a_in2);
bvec4 in3 = bvec4(a_in3);

    out0 = mat4(in0, in1, in2, in3);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec4 a_in0;
layout(location = 0) flat out uvec4 v_in0;
layout(location = 2) in uvec4 a_in1;
layout(location = 1) flat out uvec4 v_in1;
layout(location = 3) in uvec4 a_in2;
layout(location = 2) flat out uvec4 v_in2;
layout(location = 4) in uvec4 a_in3;
layout(location = 3) flat out uvec4 v_in3;

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

bool isOk (mat4 a, mat4 b, float eps) { vec4 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec4 v_in0;
layout(location = 1) flat in uvec4 v_in1;
layout(location = 2) flat in uvec4 v_in2;
layout(location = 3) flat in uvec4 v_in3;
layout(binding = 0, std140) uniform Reference
{
	mat4 out0;
} ref;
mat4 out0;


void main()
{
    bvec4 in0 = bvec4(v_in0);
bvec4 in1 = bvec4(v_in1);
bvec4 in2 = bvec4(v_in2);
bvec4 in3 = bvec4(v_in3);

    out0 = mat4(in0, in1, in2, in3);
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
	bvec4 in1;
	bvec4 in2;
	bvec4 in3;
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


void main()
{
    
    out0 = mat4(in0, in1, in2, in3);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 2) in ivec3 in1;
layout(location = 3) in uvec3 a_in2;
layout(location = 4) in vec4 in3;
layout(location = 5) in ivec2 in4;
layout(location = 6) in float in5;
layout(location = 7) in vec2 in6;
layout(location = 0) flat out mat4 out0;


void main()
{
    bvec3 in2 = bvec3(a_in2);

    out0 = mat4(in0, in1, in2, in3, in4, in5, in6);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float a_in0;
layout(location = 0) flat out float in0;
layout(location = 2) in ivec3 a_in1;
layout(location = 1) flat out ivec3 in1;
layout(location = 3) in uvec3 a_in2;
layout(location = 2) flat out uvec3 v_in2;
layout(location = 4) in vec4 a_in3;
layout(location = 3) flat out vec4 in3;
layout(location = 5) in ivec2 a_in4;
layout(location = 4) flat out ivec2 in4;
layout(location = 6) in float a_in5;
layout(location = 5) flat out float in5;
layout(location = 7) in vec2 a_in6;
layout(location = 6) flat out vec2 in6;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
    in1 = a_in1;
    v_in2 = a_in2;
    in3 = a_in3;
    in4 = a_in4;
    in5 = a_in5;
    in6 = a_in6;
}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat4 a, mat4 b, float eps) { vec4 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(location = 1) flat in ivec3 in1;
layout(location = 2) flat in uvec3 v_in2;
layout(location = 3) flat in vec4 in3;
layout(location = 4) flat in ivec2 in4;
layout(location = 5) flat in float in5;
layout(location = 6) flat in vec2 in6;
layout(binding = 0, std140) uniform Reference
{
	mat4 out0;
} ref;
mat4 out0;


void main()
{
    bvec3 in2 = bvec3(v_in2);

    out0 = mat4(in0, in1, in2, in3, in4, in5, in6);
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
	ivec3 in1;
	bvec3 in2;
	vec4 in3;
	ivec2 in4;
	float in5;
	vec2 in6;
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


void main()
{
    
    out0 = mat4(in0, in1, in2, in3, in4, in5, in6);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
