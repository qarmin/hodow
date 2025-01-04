#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 0) flat out vec3 out0;


void main()
{
    
    float[3] x;
    x = float[3] (in0.z, in0.x, in0.y);
    out0 = vec3(x[0], x[1], x[2]);
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
    
    float[3] x;
    x = float[3] (in0.z, in0.x, in0.y);
    out0 = vec3(x[0], x[1], x[2]);
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
    
    float[3] x;
    x = float[3] (in0.z, in0.x, in0.y);
    out0 = vec3(x[0], x[1], x[2]);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec4 in0;
layout(location = 0) flat out vec4 out0;


void main()
{
    
    float[4] x;
    x = float[4] (in0.z, in0.x, in0.w, in0.y);
    out0 = vec4(x[0], x[1], x[2], x[3]);
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
    
    float[4] x;
    x = float[4] (in0.z, in0.x, in0.w, in0.y);
    out0 = vec4(x[0], x[1], x[2], x[3]);
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


void main()
{
    
    float[4] x;
    x = float[4] (in0.z, in0.x, in0.w, in0.y);
    out0 = vec4(x[0], x[1], x[2], x[3]);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp int;
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec3 in0;
layout(location = 0) flat out ivec3 out0;


void main()
{
    
    int[3] x;
    x = int[3] (in0.z, in0.x, in0.y);
    out0 = ivec3(x[0], x[1], x[2]);
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

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec3 a_in0;
layout(location = 0) flat out ivec3 in0;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
}
#version 310 es
precision highp int;
precision highp float;
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
    
    int[3] x;
    x = int[3] (in0.z, in0.x, in0.y);
    out0 = ivec3(x[0], x[1], x[2]);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp int;
precision highp float;
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
    
    int[3] x;
    x = int[3] (in0.z, in0.x, in0.y);
    out0 = ivec3(x[0], x[1], x[2]);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp int;
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec4 in0;
layout(location = 0) flat out ivec4 out0;


void main()
{
    
    int[4] x;
    x = int[4] (in0.z, in0.x, in0.w, in0.y);
    out0 = ivec4(x[0], x[1], x[2], x[3]);
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

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec4 a_in0;
layout(location = 0) flat out ivec4 in0;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
}
#version 310 es
precision highp int;
precision highp float;
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
    
    int[4] x;
    x = int[4] (in0.z, in0.x, in0.w, in0.y);
    out0 = ivec4(x[0], x[1], x[2], x[3]);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp int;
precision highp float;
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
    
    int[4] x;
    x = int[4] (in0.z, in0.x, in0.w, in0.y);
    out0 = ivec4(x[0], x[1], x[2], x[3]);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp int;
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 a_in0;
layout(location = 0) flat out uvec3 v_out0;
bvec3 out0;


void main()
{
    bvec3 in0 = bvec3(a_in0);

    bool[3] x;
    x = bool[3] (in0.z, in0.x, in0.y);
    out0 = bvec3(x[0], x[1], x[2]);
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

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 a_in0;
layout(location = 0) flat out uvec3 v_in0;

void main()
{
    gl_Position = dEQP_Position;
    v_in0 = a_in0;
}
#version 310 es
precision highp int;
precision highp float;
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

    bool[3] x;
    x = bool[3] (in0.z, in0.x, in0.y);
    out0 = bvec3(x[0], x[1], x[2]);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp int;
precision highp float;
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
    
    bool[3] x;
    x = bool[3] (in0.z, in0.x, in0.y);
    out0 = bvec3(x[0], x[1], x[2]);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp int;
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec4 a_in0;
layout(location = 0) flat out uvec4 v_out0;
bvec4 out0;


void main()
{
    bvec4 in0 = bvec4(a_in0);

    bool[4] x;
    x = bool[4] (in0.z, in0.x, in0.y, in0.w);
    out0 = bvec4(x[0], x[1], x[2], x[3]);
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

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec4 a_in0;
layout(location = 0) flat out uvec4 v_in0;

void main()
{
    gl_Position = dEQP_Position;
    v_in0 = a_in0;
}
#version 310 es
precision highp int;
precision highp float;
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

    bool[4] x;
    x = bool[4] (in0.z, in0.x, in0.y, in0.w);
    out0 = bvec4(x[0], x[1], x[2], x[3]);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp int;
precision highp float;
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
    
    bool[4] x;
    x = bool[4] (in0.z, in0.x, in0.y, in0.w);
    out0 = bvec4(x[0], x[1], x[2], x[3]);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 0) flat out vec3 out0;




void main()
{
    

    struct test
    {
        float f;
        vec3 v;
    };

    test a = test(in0.z, vec3(in0.x, in0.y, in0.z));
    test b = test(in0.y, vec3(-in0.z, -in0.x, -in0.y));
    test c = test(in0.x, vec3(-in0.y, in0.z, -in0.x));

    test[3] x = test[3] (a, b, c);

    out0 = vec3(x[0].f, x[1].v.y, x[2].v.x);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
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
    

    struct test
    {
        float f;
        vec3 v;
    };

    test a = test(in0.z, vec3(in0.x, in0.y, in0.z));
    test b = test(in0.y, vec3(-in0.z, -in0.x, -in0.y));
    test c = test(in0.x, vec3(-in0.y, in0.z, -in0.x));

    test[3] x = test[3] (a, b, c);

    out0 = vec3(x[0].f, x[1].v.y, x[2].v.x);
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
    

    struct test
    {
        float f;
        vec3 v;
    };

    test a = test(in0.z, vec3(in0.x, in0.y, in0.z));
    test b = test(in0.y, vec3(-in0.z, -in0.x, -in0.y));
    test c = test(in0.x, vec3(-in0.y, in0.z, -in0.x));

    test[3] x = test[3] (a, b, c);

    out0 = vec3(x[0].f, x[1].v.y, x[2].v.x);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec4 in0;
layout(location = 0) flat out vec4 out0;



void main()
{
    


    struct test
    {
        float f;
        vec3 v;
    };

    test a = test(in0.z, vec3(in0.x, in0.y, in0.z));
    test b = test(in0.y, vec3(-in0.z, -in0.x, -in0.y));
    test c = test(in0.x, vec3(-in0.y, in0.z, -in0.x));
    test d = test(-in0.w, vec3(-in0.w, -in0.x, -in0.z));

    test[4] x = test[4] (a, b, c, d);

    out0 = vec4(x[0].f, x[1].v.y, x[2].v.x, x[3].v.x);
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



void main()
{
    


    struct test
    {
        float f;
        vec3 v;
    };

    test a = test(in0.z, vec3(in0.x, in0.y, in0.z));
    test b = test(in0.y, vec3(-in0.z, -in0.x, -in0.y));
    test c = test(in0.x, vec3(-in0.y, in0.z, -in0.x));
    test d = test(-in0.w, vec3(-in0.w, -in0.x, -in0.z));

    test[4] x = test[4] (a, b, c, d);

    out0 = vec4(x[0].f, x[1].v.y, x[2].v.x, x[3].v.x);
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



void main()
{
    


    struct test
    {
        float f;
        vec3 v;
    };

    test a = test(in0.z, vec3(in0.x, in0.y, in0.z));
    test b = test(in0.y, vec3(-in0.z, -in0.x, -in0.y));
    test c = test(in0.x, vec3(-in0.y, in0.z, -in0.x));
    test d = test(-in0.w, vec3(-in0.w, -in0.x, -in0.z));

    test[4] x = test[4] (a, b, c, d);

    out0 = vec4(x[0].f, x[1].v.y, x[2].v.x, x[3].v.x);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 0) flat out vec3 out0;


void main()
{
    

    vec3[3] x;
    x = vec3[3] (    vec3(in0.x, in0.y, in0.z)    ,
                    vec3(-in0.y, -in0.z, -in0.x),
                    vec3(in0.z, in0.x, in0.y)    );
    out0 = vec3(x[0].x, x[1].y, x[2].z);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
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
    

    vec3[3] x;
    x = vec3[3] (    vec3(in0.x, in0.y, in0.z)    ,
                    vec3(-in0.y, -in0.z, -in0.x),
                    vec3(in0.z, in0.x, in0.y)    );
    out0 = vec3(x[0].x, x[1].y, x[2].z);
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
    

    vec3[3] x;
    x = vec3[3] (    vec3(in0.x, in0.y, in0.z)    ,
                    vec3(-in0.y, -in0.z, -in0.x),
                    vec3(in0.z, in0.x, in0.y)    );
    out0 = vec3(x[0].x, x[1].y, x[2].z);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp int;
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec3 in0;
layout(location = 0) flat out ivec3 out0;


void main()
{
    

    ivec3[3] x;
    x = ivec3[3] (    ivec3(in0.x, in0.y, in0.z)    ,
                    ivec3(-in0.y, -in0.z, -in0.x),
                    ivec3(in0.z, in0.x, in0.y)    );
    out0 = ivec3(x[0].x, x[1].y, x[2].z);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp int;
precision highp float;
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
    

    ivec3[3] x;
    x = ivec3[3] (    ivec3(in0.x, in0.y, in0.z)    ,
                    ivec3(-in0.y, -in0.z, -in0.x),
                    ivec3(in0.z, in0.x, in0.y)    );
    out0 = ivec3(x[0].x, x[1].y, x[2].z);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp int;
precision highp float;
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
    

    ivec3[3] x;
    x = ivec3[3] (    ivec3(in0.x, in0.y, in0.z)    ,
                    ivec3(-in0.y, -in0.z, -in0.x),
                    ivec3(in0.z, in0.x, in0.y)    );
    out0 = ivec3(x[0].x, x[1].y, x[2].z);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp int;
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 a_in0;
layout(location = 0) flat out uvec3 v_out0;
bvec3 out0;


void main()
{
    bvec3 in0 = bvec3(a_in0);


    bvec3[3] x;
    x = bvec3[3] (    bvec3(in0.x, in0.y, in0.z)    ,
                    bvec3(in0.y, in0.z, in0.x),
                    bvec3(in0.z, in0.x, in0.y)    );
    out0 = bvec3(x[0].x, x[1].y, x[2].z);
    gl_Position = dEQP_Position;
v_out0 = uvec3(out0);

}
#version 310 es
precision highp int;
precision highp float;
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


    bvec3[3] x;
    x = bvec3[3] (    bvec3(in0.x, in0.y, in0.z)    ,
                    bvec3(in0.y, in0.z, in0.x),
                    bvec3(in0.z, in0.x, in0.y)    );
    out0 = bvec3(x[0].x, x[1].y, x[2].z);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp int;
precision highp float;
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
    

    bvec3[3] x;
    x = bvec3[3] (    bvec3(in0.x, in0.y, in0.z)    ,
                    bvec3(in0.y, in0.z, in0.x),
                    bvec3(in0.z, in0.x, in0.y)    );
    out0 = bvec3(x[0].x, x[1].y, x[2].z);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 0) flat out vec3 out0;


void main()
{
    
    mat3[3] a = mat3[3] (    mat3(    in0.x, in0.y, in0.z,
                                    in0.x, in0.y, in0.z,
                                    in0.x, in0.y, in0.z)    ,
                            mat3(    in0.z, in0.x, -in0.y,
                                    in0.z, in0.x, -in0.y,
                                    in0.z, in0.x, -in0.y)    ,
                            mat3(    -in0.z, -in0.z, in0.z,
                                    -in0.y, -in0.y, in0.y,
                                    -in0.x, -in0.x, in0.x)    );

    mat3 a0 = a[0];
    mat3 a1 = a[1];
    mat3 a2 = a[2];

    float ret0 = a0[2][0];
    float ret1 = a1[0][2];
    float ret2 = a2[1][2];

    out0 = vec3(ret0, ret1, ret2);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
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
    
    mat3[3] a = mat3[3] (    mat3(    in0.x, in0.y, in0.z,
                                    in0.x, in0.y, in0.z,
                                    in0.x, in0.y, in0.z)    ,
                            mat3(    in0.z, in0.x, -in0.y,
                                    in0.z, in0.x, -in0.y,
                                    in0.z, in0.x, -in0.y)    ,
                            mat3(    -in0.z, -in0.z, in0.z,
                                    -in0.y, -in0.y, in0.y,
                                    -in0.x, -in0.x, in0.x)    );

    mat3 a0 = a[0];
    mat3 a1 = a[1];
    mat3 a2 = a[2];

    float ret0 = a0[2][0];
    float ret1 = a1[0][2];
    float ret2 = a2[1][2];

    out0 = vec3(ret0, ret1, ret2);
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
    
    mat3[3] a = mat3[3] (    mat3(    in0.x, in0.y, in0.z,
                                    in0.x, in0.y, in0.z,
                                    in0.x, in0.y, in0.z)    ,
                            mat3(    in0.z, in0.x, -in0.y,
                                    in0.z, in0.x, -in0.y,
                                    in0.z, in0.x, -in0.y)    ,
                            mat3(    -in0.z, -in0.z, in0.z,
                                    -in0.y, -in0.y, in0.y,
                                    -in0.x, -in0.x, in0.x)    );

    mat3 a0 = a[0];
    mat3 a1 = a[1];
    mat3 a2 = a[2];

    float ret0 = a0[2][0];
    float ret1 = a1[0][2];
    float ret2 = a2[1][2];

    out0 = vec3(ret0, ret1, ret2);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp int;
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec3 in0;
layout(location = 0) flat out ivec3 out0;


void main()
{
    
    mat3[3] a = mat3[3] (    mat3(    in0.x, in0.y, in0.z,
                                    in0.x, in0.y, in0.z,
                                    in0.x, in0.y, in0.z)    ,
                            mat3(    in0.z, in0.x, -in0.y,
                                    in0.z, in0.x, -in0.y,
                                    in0.z, in0.x, -in0.y)    ,
                            mat3(    -in0.z, -in0.z, in0.z,
                                    -in0.y, -in0.y, in0.y,
                                    -in0.x, -in0.x, in0.x)    );

    mat3 a0 = a[0];
    mat3 a1 = a[1];
    mat3 a2 = a[2];

    float ret0 = a0[2][0];
    float ret1 = a1[0][2];
    float ret2 = a2[1][2];

    out0 = ivec3(ret0, ret1, ret2);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp int;
precision highp float;
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
    
    mat3[3] a = mat3[3] (    mat3(    in0.x, in0.y, in0.z,
                                    in0.x, in0.y, in0.z,
                                    in0.x, in0.y, in0.z)    ,
                            mat3(    in0.z, in0.x, -in0.y,
                                    in0.z, in0.x, -in0.y,
                                    in0.z, in0.x, -in0.y)    ,
                            mat3(    -in0.z, -in0.z, in0.z,
                                    -in0.y, -in0.y, in0.y,
                                    -in0.x, -in0.x, in0.x)    );

    mat3 a0 = a[0];
    mat3 a1 = a[1];
    mat3 a2 = a[2];

    float ret0 = a0[2][0];
    float ret1 = a1[0][2];
    float ret2 = a2[1][2];

    out0 = ivec3(ret0, ret1, ret2);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp int;
precision highp float;
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
    
    mat3[3] a = mat3[3] (    mat3(    in0.x, in0.y, in0.z,
                                    in0.x, in0.y, in0.z,
                                    in0.x, in0.y, in0.z)    ,
                            mat3(    in0.z, in0.x, -in0.y,
                                    in0.z, in0.x, -in0.y,
                                    in0.z, in0.x, -in0.y)    ,
                            mat3(    -in0.z, -in0.z, in0.z,
                                    -in0.y, -in0.y, in0.y,
                                    -in0.x, -in0.x, in0.x)    );

    mat3 a0 = a[0];
    mat3 a1 = a[1];
    mat3 a2 = a[2];

    float ret0 = a0[2][0];
    float ret1 = a1[0][2];
    float ret2 = a2[1][2];

    out0 = ivec3(ret0, ret1, ret2);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp int;
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 a_in0;
layout(location = 0) flat out uvec3 v_out0;
bvec3 out0;


void main()
{
    bvec3 in0 = bvec3(a_in0);

    mat3[3] a = mat3[3] (    mat3(    in0.x, in0.y, in0.z,
                                    in0.x, in0.y, in0.z,
                                    in0.x, in0.y, in0.z)    ,
                            mat3(    in0.z, in0.x, in0.y,
                                    in0.z, in0.x, in0.y,
                                    in0.z, in0.x, in0.y)    ,
                            mat3(    in0.z, in0.z, in0.z,
                                    in0.y, in0.y, in0.y,
                                    in0.x, in0.x, in0.x)    );

    mat3 a0 = a[0];
    mat3 a1 = a[1];
    mat3 a2 = a[2];

    float ret0 = a0[2][0];
    float ret1 = a1[0][2];
    float ret2 = a2[1][2];

    out0 = bvec3(ret0, ret1, ret2);
    gl_Position = dEQP_Position;
v_out0 = uvec3(out0);

}
#version 310 es
precision highp int;
precision highp float;
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

    mat3[3] a = mat3[3] (    mat3(    in0.x, in0.y, in0.z,
                                    in0.x, in0.y, in0.z,
                                    in0.x, in0.y, in0.z)    ,
                            mat3(    in0.z, in0.x, in0.y,
                                    in0.z, in0.x, in0.y,
                                    in0.z, in0.x, in0.y)    ,
                            mat3(    in0.z, in0.z, in0.z,
                                    in0.y, in0.y, in0.y,
                                    in0.x, in0.x, in0.x)    );

    mat3 a0 = a[0];
    mat3 a1 = a[1];
    mat3 a2 = a[2];

    float ret0 = a0[2][0];
    float ret1 = a1[0][2];
    float ret2 = a2[1][2];

    out0 = bvec3(ret0, ret1, ret2);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp int;
precision highp float;
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
    
    mat3[3] a = mat3[3] (    mat3(    in0.x, in0.y, in0.z,
                                    in0.x, in0.y, in0.z,
                                    in0.x, in0.y, in0.z)    ,
                            mat3(    in0.z, in0.x, in0.y,
                                    in0.z, in0.x, in0.y,
                                    in0.z, in0.x, in0.y)    ,
                            mat3(    in0.z, in0.z, in0.z,
                                    in0.y, in0.y, in0.y,
                                    in0.x, in0.x, in0.x)    );

    mat3 a0 = a[0];
    mat3 a1 = a[1];
    mat3 a2 = a[2];

    float ret0 = a0[2][0];
    float ret1 = a1[0][2];
    float ret2 = a2[1][2];

    out0 = bvec3(ret0, ret1, ret2);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 0) flat out vec3 out0;


float[3] func(vec3 a)
{
    return float[3] (a.z, -a.x, a.y);
}

void main()
{
    
    float[3] x = func(in0);
    out0 = vec3(x[0], x[1], x[2]);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec3 in0;
layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
vec3 out0;


float[3] func(vec3 a)
{
    return float[3] (a.z, -a.x, a.y);
}

void main()
{
    
    float[3] x = func(in0);
    out0 = vec3(x[0], x[1], x[2]);
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
	vec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec3 out0;
highp vec4 dEQP_Position;


float[3] func(vec3 a)
{
    return float[3] (a.z, -a.x, a.y);
}

void main()
{
    
    float[3] x = func(in0);
    out0 = vec3(x[0], x[1], x[2]);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp int;
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec3 in0;
layout(location = 0) flat out ivec3 out0;


int[3] func(ivec3 a)
{
    return int[3] (a.z, -a.x, a.y);
}

void main()
{
    
    int[3] x = func(in0);
    out0 = ivec3(x[0], x[1], x[2]);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp int;
precision highp float;
bool isOk (ivec3 a, ivec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec3 in0;
layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;
ivec3 out0;


int[3] func(ivec3 a)
{
    return int[3] (a.z, -a.x, a.y);
}

void main()
{
    
    int[3] x = func(in0);
    out0 = ivec3(x[0], x[1], x[2]);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp int;
precision highp float;
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


int[3] func(ivec3 a)
{
    return int[3] (a.z, -a.x, a.y);
}

void main()
{
    
    int[3] x = func(in0);
    out0 = ivec3(x[0], x[1], x[2]);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp int;
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 a_in0;
layout(location = 0) flat out uvec3 v_out0;
bvec3 out0;


bool[3] func(bvec3 a)
{
    return bool[3] (a.z, a.x, a.y);
}

void main()
{
    bvec3 in0 = bvec3(a_in0);

    bool[3] x = func(in0);
    out0 = bvec3(x[0], x[1], x[2]);
    gl_Position = dEQP_Position;
v_out0 = uvec3(out0);

}
#version 310 es
precision highp int;
precision highp float;
bool isOk (bvec3 a, bvec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec3 v_in0;
layout(binding = 0, std140) uniform Reference
{
	bvec3 out0;
} ref;
bvec3 out0;


bool[3] func(bvec3 a)
{
    return bool[3] (a.z, a.x, a.y);
}

void main()
{
    bvec3 in0 = bvec3(v_in0);

    bool[3] x = func(in0);
    out0 = bvec3(x[0], x[1], x[2]);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp int;
precision highp float;
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


bool[3] func(bvec3 a)
{
    return bool[3] (a.z, a.x, a.y);
}

void main()
{
    
    bool[3] x = func(in0);
    out0 = bvec3(x[0], x[1], x[2]);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 0) flat out vec3 out0;


vec3[3] func(vec3[3] a)
{
    return vec3[3] (a[1], a[2], a[0]);
}

void main()
{
    
    vec3[3] x = vec3[3](vec3(in0.x, in0.y, -in0.z)    ,
                        vec3(in0.y, -in0.z, in0.x)    ,
                        vec3(-in0.z, in0.x, in0.y)    );
    x = func(x);
    out0 = vec3(x[0].x, x[1].y, x[2].z);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec3 in0;
layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
vec3 out0;


vec3[3] func(vec3[3] a)
{
    return vec3[3] (a[1], a[2], a[0]);
}

void main()
{
    
    vec3[3] x = vec3[3](vec3(in0.x, in0.y, -in0.z)    ,
                        vec3(in0.y, -in0.z, in0.x)    ,
                        vec3(-in0.z, in0.x, in0.y)    );
    x = func(x);
    out0 = vec3(x[0].x, x[1].y, x[2].z);
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
	vec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec3 out0;
highp vec4 dEQP_Position;


vec3[3] func(vec3[3] a)
{
    return vec3[3] (a[1], a[2], a[0]);
}

void main()
{
    
    vec3[3] x = vec3[3](vec3(in0.x, in0.y, -in0.z)    ,
                        vec3(in0.y, -in0.z, in0.x)    ,
                        vec3(-in0.z, in0.x, in0.y)    );
    x = func(x);
    out0 = vec3(x[0].x, x[1].y, x[2].z);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 0) flat out vec3 out0;


struct test
{
    float f;
    vec3 v;
};

test[3] func(test[3] a)
{
    return test[3] (a[1], a[2], a[0]);
}

void main()
{
    

    test a = test(in0.z, vec3(in0.x, in0.y, in0.z));
    test b = test(in0.y, vec3(-in0.z, -in0.x, -in0.y));
    test c = test(in0.x, vec3(-in0.y, in0.z, -in0.x));

    test[3] t = test[3] (a, b, c);
    test[3] x = func(t);

    out0 = vec3(x[0].v.z, x[1].v.y, x[2].v.x);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec3 in0;
layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
vec3 out0;


struct test
{
    float f;
    vec3 v;
};

test[3] func(test[3] a)
{
    return test[3] (a[1], a[2], a[0]);
}

void main()
{
    

    test a = test(in0.z, vec3(in0.x, in0.y, in0.z));
    test b = test(in0.y, vec3(-in0.z, -in0.x, -in0.y));
    test c = test(in0.x, vec3(-in0.y, in0.z, -in0.x));

    test[3] t = test[3] (a, b, c);
    test[3] x = func(t);

    out0 = vec3(x[0].v.z, x[1].v.y, x[2].v.x);
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
	vec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec3 out0;
highp vec4 dEQP_Position;


struct test
{
    float f;
    vec3 v;
};

test[3] func(test[3] a)
{
    return test[3] (a[1], a[2], a[0]);
}

void main()
{
    

    test a = test(in0.z, vec3(in0.x, in0.y, in0.z));
    test b = test(in0.y, vec3(-in0.z, -in0.x, -in0.y));
    test c = test(in0.x, vec3(-in0.y, in0.z, -in0.x));

    test[3] t = test[3] (a, b, c);
    test[3] x = func(t);

    out0 = vec3(x[0].v.z, x[1].v.y, x[2].v.x);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp int;
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec3 in0;
layout(location = 0) flat out ivec3 out0;


ivec3[3] func(ivec3[3] a)
{
    return ivec3[3] (a[1], a[2], a[0]);
}

void main()
{
    
    ivec3[3] x = ivec3[3](    ivec3(in0.x, in0.y, -in0.z)    ,
                            ivec3(in0.y, -in0.z, in0.x)    ,
                            ivec3(-in0.z, in0.x, in0.y)    );
    x = func(x);
    out0 = ivec3(x[0].x, x[1].y, x[2].z);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp int;
precision highp float;
bool isOk (ivec3 a, ivec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec3 in0;
layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;
ivec3 out0;


ivec3[3] func(ivec3[3] a)
{
    return ivec3[3] (a[1], a[2], a[0]);
}

void main()
{
    
    ivec3[3] x = ivec3[3](    ivec3(in0.x, in0.y, -in0.z)    ,
                            ivec3(in0.y, -in0.z, in0.x)    ,
                            ivec3(-in0.z, in0.x, in0.y)    );
    x = func(x);
    out0 = ivec3(x[0].x, x[1].y, x[2].z);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp int;
precision highp float;
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


ivec3[3] func(ivec3[3] a)
{
    return ivec3[3] (a[1], a[2], a[0]);
}

void main()
{
    
    ivec3[3] x = ivec3[3](    ivec3(in0.x, in0.y, -in0.z)    ,
                            ivec3(in0.y, -in0.z, in0.x)    ,
                            ivec3(-in0.z, in0.x, in0.y)    );
    x = func(x);
    out0 = ivec3(x[0].x, x[1].y, x[2].z);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp int;
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 a_in0;
layout(location = 0) flat out uvec3 v_out0;
bvec3 out0;


bvec3[3] func(bvec3[3] a)
{
    return bvec3[3] (a[1], a[2], a[0]);
}

void main()
{
    bvec3 in0 = bvec3(a_in0);

    bvec3[3] x = bvec3[3](    bvec3(in0.x, in0.y, in0.z)    ,
                            bvec3(in0.y, in0.z, in0.x)    ,
                            bvec3(in0.z, in0.x, in0.y)    );
    x = func(x);
    out0 = bvec3(x[0].x, x[1].y, x[2].z);
    gl_Position = dEQP_Position;
v_out0 = uvec3(out0);

}
#version 310 es
precision highp int;
precision highp float;
bool isOk (bvec3 a, bvec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec3 v_in0;
layout(binding = 0, std140) uniform Reference
{
	bvec3 out0;
} ref;
bvec3 out0;


bvec3[3] func(bvec3[3] a)
{
    return bvec3[3] (a[1], a[2], a[0]);
}

void main()
{
    bvec3 in0 = bvec3(v_in0);

    bvec3[3] x = bvec3[3](    bvec3(in0.x, in0.y, in0.z)    ,
                            bvec3(in0.y, in0.z, in0.x)    ,
                            bvec3(in0.z, in0.x, in0.y)    );
    x = func(x);
    out0 = bvec3(x[0].x, x[1].y, x[2].z);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp int;
precision highp float;
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


bvec3[3] func(bvec3[3] a)
{
    return bvec3[3] (a[1], a[2], a[0]);
}

void main()
{
    
    bvec3[3] x = bvec3[3](    bvec3(in0.x, in0.y, in0.z)    ,
                            bvec3(in0.y, in0.z, in0.x)    ,
                            bvec3(in0.z, in0.x, in0.y)    );
    x = func(x);
    out0 = bvec3(x[0].x, x[1].y, x[2].z);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 0) flat out vec3 out0;


mat3[3] func(mat3[3] x)
{
    mat3[3] r;
    r[0] = x[1];
    r[1] = x[2];
    r[2] = x[0];
    return r;
}

void main()
{
    
    mat3[3] a, b;
    a[0] = mat3(in0.x, in0.y, in0.z,
                in0.x, in0.y, in0.z,
                in0.x, in0.y, in0.z);
    a[1] = mat3(in0.z, in0.x, -in0.y,
                in0.z, in0.x, -in0.y,
                in0.z, in0.x, -in0.y);
    a[2] = mat3(-in0.z, -in0.z, in0.z,
                -in0.y, -in0.y, in0.y,
                -in0.x, -in0.x, in0.x);

    b = func(a);

    mat3 b0 = b[0];
    mat3 b1 = b[1];
    mat3 b2 = b[2];

    float ret0 = b0[0][0];
    float ret1 = b1[1][1];
    float ret2 = b2[2][2];

    out0 = vec3(ret0, ret1, ret2);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec3 in0;
layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
vec3 out0;


mat3[3] func(mat3[3] x)
{
    mat3[3] r;
    r[0] = x[1];
    r[1] = x[2];
    r[2] = x[0];
    return r;
}

void main()
{
    
    mat3[3] a, b;
    a[0] = mat3(in0.x, in0.y, in0.z,
                in0.x, in0.y, in0.z,
                in0.x, in0.y, in0.z);
    a[1] = mat3(in0.z, in0.x, -in0.y,
                in0.z, in0.x, -in0.y,
                in0.z, in0.x, -in0.y);
    a[2] = mat3(-in0.z, -in0.z, in0.z,
                -in0.y, -in0.y, in0.y,
                -in0.x, -in0.x, in0.x);

    b = func(a);

    mat3 b0 = b[0];
    mat3 b1 = b[1];
    mat3 b2 = b[2];

    float ret0 = b0[0][0];
    float ret1 = b1[1][1];
    float ret2 = b2[2][2];

    out0 = vec3(ret0, ret1, ret2);
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
	vec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec3 out0;
highp vec4 dEQP_Position;


mat3[3] func(mat3[3] x)
{
    mat3[3] r;
    r[0] = x[1];
    r[1] = x[2];
    r[2] = x[0];
    return r;
}

void main()
{
    
    mat3[3] a, b;
    a[0] = mat3(in0.x, in0.y, in0.z,
                in0.x, in0.y, in0.z,
                in0.x, in0.y, in0.z);
    a[1] = mat3(in0.z, in0.x, -in0.y,
                in0.z, in0.x, -in0.y,
                in0.z, in0.x, -in0.y);
    a[2] = mat3(-in0.z, -in0.z, in0.z,
                -in0.y, -in0.y, in0.y,
                -in0.x, -in0.x, in0.x);

    b = func(a);

    mat3 b0 = b[0];
    mat3 b1 = b[1];
    mat3 b2 = b[2];

    float ret0 = b0[0][0];
    float ret1 = b1[1][1];
    float ret2 = b2[2][2];

    out0 = vec3(ret0, ret1, ret2);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp int;
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec3 in0;
layout(location = 0) flat out ivec3 out0;


mat3[3] func(mat3[3] x)
{
    mat3[3] r;
    r[0] = x[1];
    r[1] = x[2];
    r[2] = x[0];
    return r;
}

void main()
{
    
    mat3[3] a, b;
    a[0] = mat3(in0.x, in0.y, in0.z,
                in0.x, in0.y, in0.z,
                in0.x, in0.y, in0.z);
    a[1] = mat3(in0.z, in0.x, -in0.y,
                in0.z, in0.x, -in0.y,
                in0.z, in0.x, -in0.y);
    a[2] = mat3(-in0.z, -in0.z, in0.z,
                -in0.y, -in0.y, in0.y,
                -in0.x, -in0.x, in0.x);

    b = func(a);

    mat3 b0 = b[0];
    mat3 b1 = b[1];
    mat3 b2 = b[2];

    float ret0 = b0[0][0];
    float ret1 = b1[1][1];
    float ret2 = b2[2][2];

    out0 = ivec3(ret0, ret1, ret2);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp int;
precision highp float;
bool isOk (ivec3 a, ivec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec3 in0;
layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;
ivec3 out0;


mat3[3] func(mat3[3] x)
{
    mat3[3] r;
    r[0] = x[1];
    r[1] = x[2];
    r[2] = x[0];
    return r;
}

void main()
{
    
    mat3[3] a, b;
    a[0] = mat3(in0.x, in0.y, in0.z,
                in0.x, in0.y, in0.z,
                in0.x, in0.y, in0.z);
    a[1] = mat3(in0.z, in0.x, -in0.y,
                in0.z, in0.x, -in0.y,
                in0.z, in0.x, -in0.y);
    a[2] = mat3(-in0.z, -in0.z, in0.z,
                -in0.y, -in0.y, in0.y,
                -in0.x, -in0.x, in0.x);

    b = func(a);

    mat3 b0 = b[0];
    mat3 b1 = b[1];
    mat3 b2 = b[2];

    float ret0 = b0[0][0];
    float ret1 = b1[1][1];
    float ret2 = b2[2][2];

    out0 = ivec3(ret0, ret1, ret2);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp int;
precision highp float;
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


mat3[3] func(mat3[3] x)
{
    mat3[3] r;
    r[0] = x[1];
    r[1] = x[2];
    r[2] = x[0];
    return r;
}

void main()
{
    
    mat3[3] a, b;
    a[0] = mat3(in0.x, in0.y, in0.z,
                in0.x, in0.y, in0.z,
                in0.x, in0.y, in0.z);
    a[1] = mat3(in0.z, in0.x, -in0.y,
                in0.z, in0.x, -in0.y,
                in0.z, in0.x, -in0.y);
    a[2] = mat3(-in0.z, -in0.z, in0.z,
                -in0.y, -in0.y, in0.y,
                -in0.x, -in0.x, in0.x);

    b = func(a);

    mat3 b0 = b[0];
    mat3 b1 = b[1];
    mat3 b2 = b[2];

    float ret0 = b0[0][0];
    float ret1 = b1[1][1];
    float ret2 = b2[2][2];

    out0 = ivec3(ret0, ret1, ret2);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp int;
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 a_in0;
layout(location = 0) flat out uvec3 v_out0;
bvec3 out0;


mat3[3] func(mat3[3] x)
{
    mat3[3] r;
    r[0] = x[1];
    r[1] = x[2];
    r[2] = x[0];
    return r;
}

void main()
{
    bvec3 in0 = bvec3(a_in0);

    mat3[3] a, b;
    a[0] = mat3(in0.x, in0.y, in0.z,
                in0.x, in0.y, in0.z,
                in0.x, in0.y, in0.z);
    a[1] = mat3(in0.z, in0.x, in0.y,
                in0.z, in0.x, in0.y,
                in0.z, in0.x, in0.y);
    a[2] = mat3(in0.z, in0.z, in0.z,
                in0.y, in0.y, in0.y,
                in0.x, in0.x, in0.x);

    b = func(a);

    mat3 b0 = b[0];
    mat3 b1 = b[1];
    mat3 b2 = b[2];

    float ret0 = b0[0][0];
    float ret1 = b1[1][1];
    float ret2 = b2[2][2];

    out0 = bvec3(ret0, ret1, ret2);
    gl_Position = dEQP_Position;
v_out0 = uvec3(out0);

}
#version 310 es
precision highp int;
precision highp float;
bool isOk (bvec3 a, bvec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec3 v_in0;
layout(binding = 0, std140) uniform Reference
{
	bvec3 out0;
} ref;
bvec3 out0;


mat3[3] func(mat3[3] x)
{
    mat3[3] r;
    r[0] = x[1];
    r[1] = x[2];
    r[2] = x[0];
    return r;
}

void main()
{
    bvec3 in0 = bvec3(v_in0);

    mat3[3] a, b;
    a[0] = mat3(in0.x, in0.y, in0.z,
                in0.x, in0.y, in0.z,
                in0.x, in0.y, in0.z);
    a[1] = mat3(in0.z, in0.x, in0.y,
                in0.z, in0.x, in0.y,
                in0.z, in0.x, in0.y);
    a[2] = mat3(in0.z, in0.z, in0.z,
                in0.y, in0.y, in0.y,
                in0.x, in0.x, in0.x);

    b = func(a);

    mat3 b0 = b[0];
    mat3 b1 = b[1];
    mat3 b2 = b[2];

    float ret0 = b0[0][0];
    float ret1 = b1[1][1];
    float ret2 = b2[2][2];

    out0 = bvec3(ret0, ret1, ret2);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp int;
precision highp float;
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


mat3[3] func(mat3[3] x)
{
    mat3[3] r;
    r[0] = x[1];
    r[1] = x[2];
    r[2] = x[0];
    return r;
}

void main()
{
    
    mat3[3] a, b;
    a[0] = mat3(in0.x, in0.y, in0.z,
                in0.x, in0.y, in0.z,
                in0.x, in0.y, in0.z);
    a[1] = mat3(in0.z, in0.x, in0.y,
                in0.z, in0.x, in0.y,
                in0.z, in0.x, in0.y);
    a[2] = mat3(in0.z, in0.z, in0.z,
                in0.y, in0.y, in0.y,
                in0.x, in0.x, in0.x);

    b = func(a);

    mat3 b0 = b[0];
    mat3 b1 = b[1];
    mat3 b2 = b[2];

    float ret0 = b0[0][0];
    float ret1 = b1[1][1];
    float ret2 = b2[2][2];

    out0 = bvec3(ret0, ret1, ret2);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 0) flat out vec3 out0;


float[3] func(float[3]);

void main()
{
    
    float[3] a = float[3] (in0.x, in0.y, in0.z);
    float[3] b = func(a);
    out0 = vec3(b[0], b[1], b[2]);
    gl_Position = dEQP_Position;

}

float[3] func(float[3] a)
{
    return float[3] (a[2], a[0], a[1]);
}

#version 310 es
precision highp float;
bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec3 in0;
layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
vec3 out0;


float[3] func(float[3]);

void main()
{
    
    float[3] a = float[3] (in0.x, in0.y, in0.z);
    float[3] b = func(a);
    out0 = vec3(b[0], b[1], b[2]);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}

float[3] func(float[3] a)
{
    return float[3] (a[2], a[0], a[1]);
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
	vec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec3 out0;
highp vec4 dEQP_Position;


float[3] func(float[3]);

void main()
{
    
    float[3] a = float[3] (in0.x, in0.y, in0.z);
    float[3] b = func(a);
    out0 = vec3(b[0], b[1], b[2]);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}

float[3] func(float[3] a)
{
    return float[3] (a[2], a[0], a[1]);
}

#version 310 es
precision highp int;
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec3 in0;
layout(location = 0) flat out ivec3 out0;


int[3] func(int[3]);

void main()
{
    
    int[3] a = int[3] (in0.x, in0.y, in0.z);
    int[3] b = func(a);
    out0 = ivec3(b[0], b[1], b[2]);
    gl_Position = dEQP_Position;

}

int[3] func(int[3] a)
{
    return int[3] (a[2], a[0], a[1]);
}

#version 310 es
precision highp int;
precision highp float;
bool isOk (ivec3 a, ivec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec3 in0;
layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;
ivec3 out0;


int[3] func(int[3]);

void main()
{
    
    int[3] a = int[3] (in0.x, in0.y, in0.z);
    int[3] b = func(a);
    out0 = ivec3(b[0], b[1], b[2]);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}

int[3] func(int[3] a)
{
    return int[3] (a[2], a[0], a[1]);
}

#version 310 es
precision highp int;
precision highp float;
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


int[3] func(int[3]);

void main()
{
    
    int[3] a = int[3] (in0.x, in0.y, in0.z);
    int[3] b = func(a);
    out0 = ivec3(b[0], b[1], b[2]);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}

int[3] func(int[3] a)
{
    return int[3] (a[2], a[0], a[1]);
}

#version 310 es
precision highp int;
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 a_in0;
layout(location = 0) flat out uvec3 v_out0;
bvec3 out0;


bool[3] func(bool[3]);

void main()
{
    bvec3 in0 = bvec3(a_in0);

    bool[3] a = bool[3] (in0.x, in0.y, in0.z);
    bool[3] b = func(a);
    out0 = bvec3(b[0], b[1], b[2]);
    gl_Position = dEQP_Position;
v_out0 = uvec3(out0);

}

bool[3] func(bool[3] a)
{
    return bool[3] (a[2], a[0], a[1]);
}

#version 310 es
precision highp int;
precision highp float;
bool isOk (bvec3 a, bvec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec3 v_in0;
layout(binding = 0, std140) uniform Reference
{
	bvec3 out0;
} ref;
bvec3 out0;


bool[3] func(bool[3]);

void main()
{
    bvec3 in0 = bvec3(v_in0);

    bool[3] a = bool[3] (in0.x, in0.y, in0.z);
    bool[3] b = func(a);
    out0 = bvec3(b[0], b[1], b[2]);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}

bool[3] func(bool[3] a)
{
    return bool[3] (a[2], a[0], a[1]);
}

#version 310 es
precision highp int;
precision highp float;
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


bool[3] func(bool[3]);

void main()
{
    
    bool[3] a = bool[3] (in0.x, in0.y, in0.z);
    bool[3] b = func(a);
    out0 = bvec3(b[0], b[1], b[2]);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}

bool[3] func(bool[3] a)
{
    return bool[3] (a[2], a[0], a[1]);
}

#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 0) flat out vec3 out0;


struct test
{
    float f;
    vec3 v;
};

test[3] func(test[3]);

void main()
{
    

    test a = test(in0.z, vec3(in0.x, in0.y, in0.z));
    test b = test(in0.y, vec3(-in0.z, -in0.x, -in0.y));
    test c = test(in0.x, vec3(-in0.y, in0.z, -in0.x));

    test[3] t = test[3] (a, b, c);
    test[3] x = func(t);
    out0 = vec3(x[0].v.z, x[1].v.y, x[2].v.x);
    gl_Position = dEQP_Position;

}

test[3] func(test[3] a)
{
    return test[3] (a[1], a[2], a[0]);
}

#version 310 es
precision highp float;
bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec3 in0;
layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
vec3 out0;


struct test
{
    float f;
    vec3 v;
};

test[3] func(test[3]);

void main()
{
    

    test a = test(in0.z, vec3(in0.x, in0.y, in0.z));
    test b = test(in0.y, vec3(-in0.z, -in0.x, -in0.y));
    test c = test(in0.x, vec3(-in0.y, in0.z, -in0.x));

    test[3] t = test[3] (a, b, c);
    test[3] x = func(t);
    out0 = vec3(x[0].v.z, x[1].v.y, x[2].v.x);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}

test[3] func(test[3] a)
{
    return test[3] (a[1], a[2], a[0]);
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
	vec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec3 out0;
highp vec4 dEQP_Position;


struct test
{
    float f;
    vec3 v;
};

test[3] func(test[3]);

void main()
{
    

    test a = test(in0.z, vec3(in0.x, in0.y, in0.z));
    test b = test(in0.y, vec3(-in0.z, -in0.x, -in0.y));
    test c = test(in0.x, vec3(-in0.y, in0.z, -in0.x));

    test[3] t = test[3] (a, b, c);
    test[3] x = func(t);
    out0 = vec3(x[0].v.z, x[1].v.y, x[2].v.x);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}

test[3] func(test[3] a)
{
    return test[3] (a[1], a[2], a[0]);
}

#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 0) flat out vec3 out0;


vec3[3] func(vec3[3]);

void main()
{
    
    vec3[3] x = vec3[3](vec3(in0.x, in0.y, -in0.z)    ,
                        vec3(in0.y, -in0.z, in0.x)    ,
                        vec3(-in0.z, in0.x, in0.y)    );
    x = func(x);
    out0 = vec3(x[0].x, x[1].y, x[2].z);
    gl_Position = dEQP_Position;

}

vec3[3] func(vec3[3] a)
{
    return vec3[3] (a[1], a[2], a[0]);
}
#version 310 es
precision highp float;
bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec3 in0;
layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
vec3 out0;


vec3[3] func(vec3[3]);

void main()
{
    
    vec3[3] x = vec3[3](vec3(in0.x, in0.y, -in0.z)    ,
                        vec3(in0.y, -in0.z, in0.x)    ,
                        vec3(-in0.z, in0.x, in0.y)    );
    x = func(x);
    out0 = vec3(x[0].x, x[1].y, x[2].z);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}

vec3[3] func(vec3[3] a)
{
    return vec3[3] (a[1], a[2], a[0]);
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
	vec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec3 out0;
highp vec4 dEQP_Position;


vec3[3] func(vec3[3]);

void main()
{
    
    vec3[3] x = vec3[3](vec3(in0.x, in0.y, -in0.z)    ,
                        vec3(in0.y, -in0.z, in0.x)    ,
                        vec3(-in0.z, in0.x, in0.y)    );
    x = func(x);
    out0 = vec3(x[0].x, x[1].y, x[2].z);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}

vec3[3] func(vec3[3] a)
{
    return vec3[3] (a[1], a[2], a[0]);
}
#version 310 es
precision highp int;
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec3 in0;
layout(location = 0) flat out ivec3 out0;


ivec3[3] func(ivec3[3]);

void main()
{
    
    ivec3[3] x = ivec3[3](    ivec3(in0.x, in0.y, -in0.z)    ,
                            ivec3(in0.y, -in0.z, in0.x)    ,
                            ivec3(-in0.z, in0.x, in0.y)    );
    x = func(x);
    out0 = ivec3(x[0].x, x[1].y, x[2].z);
    gl_Position = dEQP_Position;

}

ivec3[3] func(ivec3[3] a)
{
    return ivec3[3] (a[1], a[2], a[0]);
}
#version 310 es
precision highp int;
precision highp float;
bool isOk (ivec3 a, ivec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec3 in0;
layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;
ivec3 out0;


ivec3[3] func(ivec3[3]);

void main()
{
    
    ivec3[3] x = ivec3[3](    ivec3(in0.x, in0.y, -in0.z)    ,
                            ivec3(in0.y, -in0.z, in0.x)    ,
                            ivec3(-in0.z, in0.x, in0.y)    );
    x = func(x);
    out0 = ivec3(x[0].x, x[1].y, x[2].z);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}

ivec3[3] func(ivec3[3] a)
{
    return ivec3[3] (a[1], a[2], a[0]);
}
#version 310 es
precision highp int;
precision highp float;
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


ivec3[3] func(ivec3[3]);

void main()
{
    
    ivec3[3] x = ivec3[3](    ivec3(in0.x, in0.y, -in0.z)    ,
                            ivec3(in0.y, -in0.z, in0.x)    ,
                            ivec3(-in0.z, in0.x, in0.y)    );
    x = func(x);
    out0 = ivec3(x[0].x, x[1].y, x[2].z);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}

ivec3[3] func(ivec3[3] a)
{
    return ivec3[3] (a[1], a[2], a[0]);
}
#version 310 es
precision highp int;
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 a_in0;
layout(location = 0) flat out uvec3 v_out0;
bvec3 out0;


bvec3[3] func(bvec3[3]);

void main()
{
    bvec3 in0 = bvec3(a_in0);

    bvec3[3] x = bvec3[3](    bvec3(in0.x, in0.y, in0.z)    ,
                            bvec3(in0.y, in0.z, in0.x)    ,
                            bvec3(in0.z, in0.x, in0.y)    );
    x = func(x);
    out0 = bvec3(x[0].x, x[1].y, x[2].z);
    gl_Position = dEQP_Position;
v_out0 = uvec3(out0);

}

bvec3[3] func(bvec3[3] a)
{
    return bvec3[3] (a[1], a[2], a[0]);
}

#version 310 es
precision highp int;
precision highp float;
bool isOk (bvec3 a, bvec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec3 v_in0;
layout(binding = 0, std140) uniform Reference
{
	bvec3 out0;
} ref;
bvec3 out0;


bvec3[3] func(bvec3[3]);

void main()
{
    bvec3 in0 = bvec3(v_in0);

    bvec3[3] x = bvec3[3](    bvec3(in0.x, in0.y, in0.z)    ,
                            bvec3(in0.y, in0.z, in0.x)    ,
                            bvec3(in0.z, in0.x, in0.y)    );
    x = func(x);
    out0 = bvec3(x[0].x, x[1].y, x[2].z);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}

bvec3[3] func(bvec3[3] a)
{
    return bvec3[3] (a[1], a[2], a[0]);
}

#version 310 es
precision highp int;
precision highp float;
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


bvec3[3] func(bvec3[3]);

void main()
{
    
    bvec3[3] x = bvec3[3](    bvec3(in0.x, in0.y, in0.z)    ,
                            bvec3(in0.y, in0.z, in0.x)    ,
                            bvec3(in0.z, in0.x, in0.y)    );
    x = func(x);
    out0 = bvec3(x[0].x, x[1].y, x[2].z);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}

bvec3[3] func(bvec3[3] a)
{
    return bvec3[3] (a[1], a[2], a[0]);
}

#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 0) flat out vec3 out0;


mat3[3] func(mat3[3]);

void main()
{
    
    mat3[3] a, b;
    a[0] = mat3(in0.x, in0.y, in0.z,
                in0.x, in0.y, in0.z,
                in0.x, in0.y, in0.z);
    a[1] = mat3(in0.z, in0.x, -in0.y,
                in0.z, in0.x, -in0.y,
                in0.z, in0.x, -in0.y);
    a[2] = mat3(-in0.z, -in0.z, in0.z,
                -in0.y, -in0.y, in0.y,
                -in0.x, -in0.x, in0.x);

    b = func(a);

    mat3 b0 = b[0];
    mat3 b1 = b[1];
    mat3 b2 = b[2];

    float ret0 = b0[0][0];
    float ret1 = b1[1][1];
    float ret2 = b2[2][2];

    out0 = vec3(ret0, ret1, ret2);
    gl_Position = dEQP_Position;

}

mat3[3] func(mat3[3] x)
{
    mat3[3] r;
    r[0] = x[1];
    r[1] = x[2];
    r[2] = x[0];
    return r;
}
#version 310 es
precision highp float;
bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec3 in0;
layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
vec3 out0;


mat3[3] func(mat3[3]);

void main()
{
    
    mat3[3] a, b;
    a[0] = mat3(in0.x, in0.y, in0.z,
                in0.x, in0.y, in0.z,
                in0.x, in0.y, in0.z);
    a[1] = mat3(in0.z, in0.x, -in0.y,
                in0.z, in0.x, -in0.y,
                in0.z, in0.x, -in0.y);
    a[2] = mat3(-in0.z, -in0.z, in0.z,
                -in0.y, -in0.y, in0.y,
                -in0.x, -in0.x, in0.x);

    b = func(a);

    mat3 b0 = b[0];
    mat3 b1 = b[1];
    mat3 b2 = b[2];

    float ret0 = b0[0][0];
    float ret1 = b1[1][1];
    float ret2 = b2[2][2];

    out0 = vec3(ret0, ret1, ret2);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}

mat3[3] func(mat3[3] x)
{
    mat3[3] r;
    r[0] = x[1];
    r[1] = x[2];
    r[2] = x[0];
    return r;
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
	vec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec3 out0;
highp vec4 dEQP_Position;


mat3[3] func(mat3[3]);

void main()
{
    
    mat3[3] a, b;
    a[0] = mat3(in0.x, in0.y, in0.z,
                in0.x, in0.y, in0.z,
                in0.x, in0.y, in0.z);
    a[1] = mat3(in0.z, in0.x, -in0.y,
                in0.z, in0.x, -in0.y,
                in0.z, in0.x, -in0.y);
    a[2] = mat3(-in0.z, -in0.z, in0.z,
                -in0.y, -in0.y, in0.y,
                -in0.x, -in0.x, in0.x);

    b = func(a);

    mat3 b0 = b[0];
    mat3 b1 = b[1];
    mat3 b2 = b[2];

    float ret0 = b0[0][0];
    float ret1 = b1[1][1];
    float ret2 = b2[2][2];

    out0 = vec3(ret0, ret1, ret2);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}

mat3[3] func(mat3[3] x)
{
    mat3[3] r;
    r[0] = x[1];
    r[1] = x[2];
    r[2] = x[0];
    return r;
}
#version 310 es
precision highp int;
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec3 in0;
layout(location = 0) flat out ivec3 out0;


mat3[3] func(mat3[3]);

void main()
{
    
    mat3[3] a, b;
    a[0] = mat3(in0.x, in0.y, in0.z,
                in0.x, in0.y, in0.z,
                in0.x, in0.y, in0.z);
    a[1] = mat3(in0.z, in0.x, -in0.y,
                in0.z, in0.x, -in0.y,
                in0.z, in0.x, -in0.y);
    a[2] = mat3(-in0.z, -in0.z, in0.z,
                -in0.y, -in0.y, in0.y,
                -in0.x, -in0.x, in0.x);

    b = func(a);

    mat3 b0 = b[0];
    mat3 b1 = b[1];
    mat3 b2 = b[2];

    float ret0 = b0[0][0];
    float ret1 = b1[1][1];
    float ret2 = b2[2][2];

    out0 = ivec3(ret0, ret1, ret2);
    gl_Position = dEQP_Position;

}

mat3[3] func(mat3[3] x)
{
    mat3[3] r;
    r[0] = x[1];
    r[1] = x[2];
    r[2] = x[0];
    return r;
}
#version 310 es
precision highp int;
precision highp float;
bool isOk (ivec3 a, ivec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec3 in0;
layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;
ivec3 out0;


mat3[3] func(mat3[3]);

void main()
{
    
    mat3[3] a, b;
    a[0] = mat3(in0.x, in0.y, in0.z,
                in0.x, in0.y, in0.z,
                in0.x, in0.y, in0.z);
    a[1] = mat3(in0.z, in0.x, -in0.y,
                in0.z, in0.x, -in0.y,
                in0.z, in0.x, -in0.y);
    a[2] = mat3(-in0.z, -in0.z, in0.z,
                -in0.y, -in0.y, in0.y,
                -in0.x, -in0.x, in0.x);

    b = func(a);

    mat3 b0 = b[0];
    mat3 b1 = b[1];
    mat3 b2 = b[2];

    float ret0 = b0[0][0];
    float ret1 = b1[1][1];
    float ret2 = b2[2][2];

    out0 = ivec3(ret0, ret1, ret2);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}

mat3[3] func(mat3[3] x)
{
    mat3[3] r;
    r[0] = x[1];
    r[1] = x[2];
    r[2] = x[0];
    return r;
}
#version 310 es
precision highp int;
precision highp float;
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


mat3[3] func(mat3[3]);

void main()
{
    
    mat3[3] a, b;
    a[0] = mat3(in0.x, in0.y, in0.z,
                in0.x, in0.y, in0.z,
                in0.x, in0.y, in0.z);
    a[1] = mat3(in0.z, in0.x, -in0.y,
                in0.z, in0.x, -in0.y,
                in0.z, in0.x, -in0.y);
    a[2] = mat3(-in0.z, -in0.z, in0.z,
                -in0.y, -in0.y, in0.y,
                -in0.x, -in0.x, in0.x);

    b = func(a);

    mat3 b0 = b[0];
    mat3 b1 = b[1];
    mat3 b2 = b[2];

    float ret0 = b0[0][0];
    float ret1 = b1[1][1];
    float ret2 = b2[2][2];

    out0 = ivec3(ret0, ret1, ret2);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}

mat3[3] func(mat3[3] x)
{
    mat3[3] r;
    r[0] = x[1];
    r[1] = x[2];
    r[2] = x[0];
    return r;
}
#version 310 es
precision highp int;
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 a_in0;
layout(location = 0) flat out uvec3 v_out0;
bvec3 out0;


mat3[3] func(mat3[3]);
void main()
{
    bvec3 in0 = bvec3(a_in0);

    mat3[3] a, b;
    a[0] = mat3(in0.x, in0.y, in0.z,
                in0.x, in0.y, in0.z,
                in0.x, in0.y, in0.z);
    a[1] = mat3(in0.z, in0.x, in0.y,
                in0.z, in0.x, in0.y,
                in0.z, in0.x, in0.y);
    a[2] = mat3(in0.z, in0.z, in0.z,
                in0.y, in0.y, in0.y,
                in0.x, in0.x, in0.x);

    b = func(a);

    mat3 b0 = b[0];
    mat3 b1 = b[1];
    mat3 b2 = b[2];

    float ret0 = b0[0][0];
    float ret1 = b1[1][1];
    float ret2 = b2[2][2];

    out0 = bvec3(ret0, ret1, ret2);
    gl_Position = dEQP_Position;
v_out0 = uvec3(out0);

}

mat3[3] func(mat3[3] x)
{
    mat3[3] r;
    r[0] = x[1];
    r[1] = x[2];
    r[2] = x[0];
    return r;
}
#version 310 es
precision highp int;
precision highp float;
bool isOk (bvec3 a, bvec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uvec3 v_in0;
layout(binding = 0, std140) uniform Reference
{
	bvec3 out0;
} ref;
bvec3 out0;


mat3[3] func(mat3[3]);
void main()
{
    bvec3 in0 = bvec3(v_in0);

    mat3[3] a, b;
    a[0] = mat3(in0.x, in0.y, in0.z,
                in0.x, in0.y, in0.z,
                in0.x, in0.y, in0.z);
    a[1] = mat3(in0.z, in0.x, in0.y,
                in0.z, in0.x, in0.y,
                in0.z, in0.x, in0.y);
    a[2] = mat3(in0.z, in0.z, in0.z,
                in0.y, in0.y, in0.y,
                in0.x, in0.x, in0.x);

    b = func(a);

    mat3 b0 = b[0];
    mat3 b1 = b[1];
    mat3 b2 = b[2];

    float ret0 = b0[0][0];
    float ret1 = b1[1][1];
    float ret2 = b2[2][2];

    out0 = bvec3(ret0, ret1, ret2);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}

mat3[3] func(mat3[3] x)
{
    mat3[3] r;
    r[0] = x[1];
    r[1] = x[2];
    r[2] = x[0];
    return r;
}
#version 310 es
precision highp int;
precision highp float;
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


mat3[3] func(mat3[3]);
void main()
{
    
    mat3[3] a, b;
    a[0] = mat3(in0.x, in0.y, in0.z,
                in0.x, in0.y, in0.z,
                in0.x, in0.y, in0.z);
    a[1] = mat3(in0.z, in0.x, in0.y,
                in0.z, in0.x, in0.y,
                in0.z, in0.x, in0.y);
    a[2] = mat3(in0.z, in0.z, in0.z,
                in0.y, in0.y, in0.y,
                in0.x, in0.x, in0.x);

    b = func(a);

    mat3 b0 = b[0];
    mat3 b1 = b[1];
    mat3 b2 = b[2];

    float ret0 = b0[0][0];
    float ret1 = b1[1][1];
    float ret2 = b2[2][2];

    out0 = bvec3(ret0, ret1, ret2);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}

mat3[3] func(mat3[3] x)
{
    mat3[3] r;
    r[0] = x[1];
    r[1] = x[2];
    r[2] = x[0];
    return r;
}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 0) flat out vec3 out0;


void main()
{
    
    float[] x = float[] (in0.z, in0.x, in0.y);
    float[] y = x;

    out0 = vec3(y[0], y[1], y[2]);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
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
    
    float[] x = float[] (in0.z, in0.x, in0.y);
    float[] y = x;

    out0 = vec3(y[0], y[1], y[2]);
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
    
    float[] x = float[] (in0.z, in0.x, in0.y);
    float[] y = x;

    out0 = vec3(y[0], y[1], y[2]);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp int;
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec3 in0;
layout(location = 0) flat out ivec3 out0;


void main()
{
    
    int[] x = int[] (in0.z, in0.x, in0.y);
    int[] y = x;

    out0 = ivec3(y[0], y[1], y[2]);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp int;
precision highp float;
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
    
    int[] x = int[] (in0.z, in0.x, in0.y);
    int[] y = x;

    out0 = ivec3(y[0], y[1], y[2]);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp int;
precision highp float;
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
    
    int[] x = int[] (in0.z, in0.x, in0.y);
    int[] y = x;

    out0 = ivec3(y[0], y[1], y[2]);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp int;
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 a_in0;
layout(location = 0) flat out uvec3 v_out0;
bvec3 out0;


void main()
{
    bvec3 in0 = bvec3(a_in0);

    bool[] x = bool[] (in0.z, in0.x, in0.y);
    bool[] y = x;

    out0 = bvec3(y[0], y[1], y[2]);
    gl_Position = dEQP_Position;
v_out0 = uvec3(out0);

}
#version 310 es
precision highp int;
precision highp float;
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

    bool[] x = bool[] (in0.z, in0.x, in0.y);
    bool[] y = x;

    out0 = bvec3(y[0], y[1], y[2]);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp int;
precision highp float;
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
    
    bool[] x = bool[] (in0.z, in0.x, in0.y);
    bool[] y = x;

    out0 = bvec3(y[0], y[1], y[2]);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 0) flat out vec3 out0;


struct test
{
    float f;
    vec3 v;
};

void main()
{
    

    test a = test(in0.z, vec3(in0.x, in0.y, in0.z));
    test b = test(in0.y, vec3(-in0.z, -in0.x, -in0.y));
    test c = test(in0.x, vec3(-in0.y, in0.z, -in0.x));

    test[] x = test[] (c, b, a);
    test[] y = x;

    out0 = vec3(y[0].v.x, y[1].v.y, y[2].v.z);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec3 in0;
layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
vec3 out0;


struct test
{
    float f;
    vec3 v;
};

void main()
{
    

    test a = test(in0.z, vec3(in0.x, in0.y, in0.z));
    test b = test(in0.y, vec3(-in0.z, -in0.x, -in0.y));
    test c = test(in0.x, vec3(-in0.y, in0.z, -in0.x));

    test[] x = test[] (c, b, a);
    test[] y = x;

    out0 = vec3(y[0].v.x, y[1].v.y, y[2].v.z);
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
	vec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec3 out0;
highp vec4 dEQP_Position;


struct test
{
    float f;
    vec3 v;
};

void main()
{
    

    test a = test(in0.z, vec3(in0.x, in0.y, in0.z));
    test b = test(in0.y, vec3(-in0.z, -in0.x, -in0.y));
    test c = test(in0.x, vec3(-in0.y, in0.z, -in0.x));

    test[] x = test[] (c, b, a);
    test[] y = x;

    out0 = vec3(y[0].v.x, y[1].v.y, y[2].v.z);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 0) flat out vec3 out0;


void main()
{
    
    vec3[] x = vec3[] (    vec3(in0.x, in0.y, -in0.z)    ,
                        vec3(in0.y, -in0.z, in0.x)    ,
                        vec3(-in0.z, in0.x, in0.y)    );
    vec3[] y = x;
    out0 = vec3(y[0].x, y[1].y, y[2].z);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
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
    
    vec3[] x = vec3[] (    vec3(in0.x, in0.y, -in0.z)    ,
                        vec3(in0.y, -in0.z, in0.x)    ,
                        vec3(-in0.z, in0.x, in0.y)    );
    vec3[] y = x;
    out0 = vec3(y[0].x, y[1].y, y[2].z);
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
    
    vec3[] x = vec3[] (    vec3(in0.x, in0.y, -in0.z)    ,
                        vec3(in0.y, -in0.z, in0.x)    ,
                        vec3(-in0.z, in0.x, in0.y)    );
    vec3[] y = x;
    out0 = vec3(y[0].x, y[1].y, y[2].z);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp int;
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec3 in0;
layout(location = 0) flat out ivec3 out0;


void main()
{
    
    ivec3[] x = ivec3[] (    ivec3(in0.x, in0.y, -in0.z)    ,
                            ivec3(in0.y, -in0.z, in0.x)    ,
                            ivec3(-in0.z, in0.x, in0.y)    );
    ivec3[] y = x;
    out0 = ivec3(y[0].x, y[1].y, y[2].z);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp int;
precision highp float;
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
    
    ivec3[] x = ivec3[] (    ivec3(in0.x, in0.y, -in0.z)    ,
                            ivec3(in0.y, -in0.z, in0.x)    ,
                            ivec3(-in0.z, in0.x, in0.y)    );
    ivec3[] y = x;
    out0 = ivec3(y[0].x, y[1].y, y[2].z);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp int;
precision highp float;
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
    
    ivec3[] x = ivec3[] (    ivec3(in0.x, in0.y, -in0.z)    ,
                            ivec3(in0.y, -in0.z, in0.x)    ,
                            ivec3(-in0.z, in0.x, in0.y)    );
    ivec3[] y = x;
    out0 = ivec3(y[0].x, y[1].y, y[2].z);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp int;
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 a_in0;
layout(location = 0) flat out uvec3 v_out0;
bvec3 out0;


void main()
{
    bvec3 in0 = bvec3(a_in0);

    bvec3[] x = bvec3[] (    bvec3(in0.x, in0.y, in0.z)    ,
                            bvec3(in0.y, in0.z, in0.x)    ,
                            bvec3(in0.z, in0.x, in0.y)    );
    bvec3[] y = x;
    out0 = bvec3(y[0].x, y[1].y, y[2].z);
    gl_Position = dEQP_Position;
v_out0 = uvec3(out0);

}
#version 310 es
precision highp int;
precision highp float;
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

    bvec3[] x = bvec3[] (    bvec3(in0.x, in0.y, in0.z)    ,
                            bvec3(in0.y, in0.z, in0.x)    ,
                            bvec3(in0.z, in0.x, in0.y)    );
    bvec3[] y = x;
    out0 = bvec3(y[0].x, y[1].y, y[2].z);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp int;
precision highp float;
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
    
    bvec3[] x = bvec3[] (    bvec3(in0.x, in0.y, in0.z)    ,
                            bvec3(in0.y, in0.z, in0.x)    ,
                            bvec3(in0.z, in0.x, in0.y)    );
    bvec3[] y = x;
    out0 = bvec3(y[0].x, y[1].y, y[2].z);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 0) flat out vec3 out0;


void main()
{
    
    mat3[] a = mat3[] (    mat3(    in0.x, in0.y, in0.z,
                                in0.x, in0.y, in0.z,
                                in0.x, in0.y, in0.z)    ,
                        mat3(    in0.z, in0.x, -in0.y,
                                in0.z, in0.x, -in0.y,
                                in0.z, in0.x, -in0.y)    ,
                        mat3(    -in0.z, -in0.z, in0.z,
                                -in0.y, -in0.y, in0.y,
                                -in0.x, -in0.x, in0.x)    );

    mat3 a0 = a[0];
    mat3 a1 = a[1];
    mat3 a2 = a[2];

    float ret0 = a0[2][0];
    float ret1 = a1[0][2];
    float ret2 = a2[1][2];

    out0 = vec3(ret0, ret1, ret2);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
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
    
    mat3[] a = mat3[] (    mat3(    in0.x, in0.y, in0.z,
                                in0.x, in0.y, in0.z,
                                in0.x, in0.y, in0.z)    ,
                        mat3(    in0.z, in0.x, -in0.y,
                                in0.z, in0.x, -in0.y,
                                in0.z, in0.x, -in0.y)    ,
                        mat3(    -in0.z, -in0.z, in0.z,
                                -in0.y, -in0.y, in0.y,
                                -in0.x, -in0.x, in0.x)    );

    mat3 a0 = a[0];
    mat3 a1 = a[1];
    mat3 a2 = a[2];

    float ret0 = a0[2][0];
    float ret1 = a1[0][2];
    float ret2 = a2[1][2];

    out0 = vec3(ret0, ret1, ret2);
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
    
    mat3[] a = mat3[] (    mat3(    in0.x, in0.y, in0.z,
                                in0.x, in0.y, in0.z,
                                in0.x, in0.y, in0.z)    ,
                        mat3(    in0.z, in0.x, -in0.y,
                                in0.z, in0.x, -in0.y,
                                in0.z, in0.x, -in0.y)    ,
                        mat3(    -in0.z, -in0.z, in0.z,
                                -in0.y, -in0.y, in0.y,
                                -in0.x, -in0.x, in0.x)    );

    mat3 a0 = a[0];
    mat3 a1 = a[1];
    mat3 a2 = a[2];

    float ret0 = a0[2][0];
    float ret1 = a1[0][2];
    float ret2 = a2[1][2];

    out0 = vec3(ret0, ret1, ret2);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp int;
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec3 in0;
layout(location = 0) flat out ivec3 out0;


void main()
{
    
    mat3[] a = mat3[] (    mat3(    in0.x, in0.y, in0.z,
                                in0.x, in0.y, in0.z,
                                in0.x, in0.y, in0.z)    ,
                        mat3(    in0.z, in0.x, -in0.y,
                                in0.z, in0.x, -in0.y,
                                in0.z, in0.x, -in0.y)    ,
                        mat3(    -in0.z, -in0.z, in0.z,
                                -in0.y, -in0.y, in0.y,
                                -in0.x, -in0.x, in0.x)    );

    mat3 a0 = a[0];
    mat3 a1 = a[1];
    mat3 a2 = a[2];

    float ret0 = a0[2][0];
    float ret1 = a1[0][2];
    float ret2 = a2[1][2];

    out0 = ivec3(ret0, ret1, ret2);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp int;
precision highp float;
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
    
    mat3[] a = mat3[] (    mat3(    in0.x, in0.y, in0.z,
                                in0.x, in0.y, in0.z,
                                in0.x, in0.y, in0.z)    ,
                        mat3(    in0.z, in0.x, -in0.y,
                                in0.z, in0.x, -in0.y,
                                in0.z, in0.x, -in0.y)    ,
                        mat3(    -in0.z, -in0.z, in0.z,
                                -in0.y, -in0.y, in0.y,
                                -in0.x, -in0.x, in0.x)    );

    mat3 a0 = a[0];
    mat3 a1 = a[1];
    mat3 a2 = a[2];

    float ret0 = a0[2][0];
    float ret1 = a1[0][2];
    float ret2 = a2[1][2];

    out0 = ivec3(ret0, ret1, ret2);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp int;
precision highp float;
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
    
    mat3[] a = mat3[] (    mat3(    in0.x, in0.y, in0.z,
                                in0.x, in0.y, in0.z,
                                in0.x, in0.y, in0.z)    ,
                        mat3(    in0.z, in0.x, -in0.y,
                                in0.z, in0.x, -in0.y,
                                in0.z, in0.x, -in0.y)    ,
                        mat3(    -in0.z, -in0.z, in0.z,
                                -in0.y, -in0.y, in0.y,
                                -in0.x, -in0.x, in0.x)    );

    mat3 a0 = a[0];
    mat3 a1 = a[1];
    mat3 a2 = a[2];

    float ret0 = a0[2][0];
    float ret1 = a1[0][2];
    float ret2 = a2[1][2];

    out0 = ivec3(ret0, ret1, ret2);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp int;
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 a_in0;
layout(location = 0) flat out uvec3 v_out0;
bvec3 out0;


void main()
{
    bvec3 in0 = bvec3(a_in0);

    mat3[] a = mat3[] (    mat3(    in0.x, in0.y, in0.z,
                                in0.x, in0.y, in0.z,
                                in0.x, in0.y, in0.z)    ,
                        mat3(    in0.z, in0.x, in0.y,
                                in0.z, in0.x, in0.y,
                                in0.z, in0.x, in0.y)    ,
                        mat3(    in0.z, in0.z, in0.z,
                                in0.y, in0.y, in0.y,
                                in0.x, in0.x, in0.x)    );

    mat3 a0 = a[0];
    mat3 a1 = a[1];
    mat3 a2 = a[2];

    float ret0 = a0[2][0];
    float ret1 = a1[0][2];
    float ret2 = a2[1][2];

    out0 = bvec3(ret0, ret1, ret2);
    gl_Position = dEQP_Position;
v_out0 = uvec3(out0);

}
#version 310 es
precision highp int;
precision highp float;
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

    mat3[] a = mat3[] (    mat3(    in0.x, in0.y, in0.z,
                                in0.x, in0.y, in0.z,
                                in0.x, in0.y, in0.z)    ,
                        mat3(    in0.z, in0.x, in0.y,
                                in0.z, in0.x, in0.y,
                                in0.z, in0.x, in0.y)    ,
                        mat3(    in0.z, in0.z, in0.z,
                                in0.y, in0.y, in0.y,
                                in0.x, in0.x, in0.x)    );

    mat3 a0 = a[0];
    mat3 a1 = a[1];
    mat3 a2 = a[2];

    float ret0 = a0[2][0];
    float ret1 = a1[0][2];
    float ret2 = a2[1][2];

    out0 = bvec3(ret0, ret1, ret2);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp int;
precision highp float;
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
    
    mat3[] a = mat3[] (    mat3(    in0.x, in0.y, in0.z,
                                in0.x, in0.y, in0.z,
                                in0.x, in0.y, in0.z)    ,
                        mat3(    in0.z, in0.x, in0.y,
                                in0.z, in0.x, in0.y,
                                in0.z, in0.x, in0.y)    ,
                        mat3(    in0.z, in0.z, in0.z,
                                in0.y, in0.y, in0.y,
                                in0.x, in0.x, in0.x)    );

    mat3 a0 = a[0];
    mat3 a1 = a[1];
    mat3 a2 = a[2];

    float ret0 = a0[2][0];
    float ret1 = a1[0][2];
    float ret2 = a2[1][2];

    out0 = bvec3(ret0, ret1, ret2);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;


const int a = 4;

void main ()
{
    const int b = 5;
    float[a] array1;
    float[b] array2;
    float[array1.length()] array3;
    float[a+b] array4;
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) out mediump vec4 dEQP_FragColor;



void main()
{
    dEQP_FragColor = vec4(1.0);
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
layout(location = 0) out mediump vec4 dEQP_FragColor;


const int a = 4;

void main ()
{
    const int b = 5;
    float[a] array1;
    float[b] array2;
    float[array1.length()] array3;
    float[a+b] array4;
    dEQP_FragColor = vec4(1.0);

}
#version 310 es
precision highp float;
layout(local_size_x = 1) in;

layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

highp vec4 dEQP_Position;


const int a = 4;

void main ()
{
    const int b = 5;
    float[a] array1;
    float[b] array2;
    float[array1.length()] array3;
    float[a+b] array4;
    res.result = 1u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 0) flat out vec3 out0;


const int a = 3;

void main ()
{
    
    const int b = 2;
    float x = float[] (in0.x, in0.y, in0.z, -in0.z, -in0.y, -in0.x) [a];
    float y = float[] (in0.x, in0.y, in0.z, -in0.z, -in0.y, -in0.x) [b+2];
    float z = float[] (in0.x, in0.y, in0.z, -in0.z, -in0.y, -in0.x) [5];
    out0 = vec3(x, y, z);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec3 in0;
layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
vec3 out0;


const int a = 3;

void main ()
{
    
    const int b = 2;
    float x = float[] (in0.x, in0.y, in0.z, -in0.z, -in0.y, -in0.x) [a];
    float y = float[] (in0.x, in0.y, in0.z, -in0.z, -in0.y, -in0.x) [b+2];
    float z = float[] (in0.x, in0.y, in0.z, -in0.z, -in0.y, -in0.x) [5];
    out0 = vec3(x, y, z);
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
	vec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec3 out0;
highp vec4 dEQP_Position;


const int a = 3;

void main ()
{
    
    const int b = 2;
    float x = float[] (in0.x, in0.y, in0.z, -in0.z, -in0.y, -in0.x) [a];
    float y = float[] (in0.x, in0.y, in0.z, -in0.z, -in0.y, -in0.x) [b+2];
    float z = float[] (in0.x, in0.y, in0.z, -in0.z, -in0.y, -in0.x) [5];
    out0 = vec3(x, y, z);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp int;
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 2) in ivec2 in1;
layout(location = 0) flat out vec3 out0;


void main ()
{
    
    float x = float[] (in0.x, in0.y, in0.z, -in0.z, -in0.y, -in0.x) [in1.x];
    float y = float[] (in0.x, in0.y, in0.z, -in0.z, -in0.y, -in0.x) [in1.y+2];
    float z = float[] (in0.x, in0.y, in0.z, -in0.z, -in0.y, -in0.x) [in1.x+in1.y];
    out0 = vec3(x, y, z);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 a_in0;
layout(location = 0) flat out vec3 in0;
layout(location = 2) in ivec2 a_in1;
layout(location = 1) flat out ivec2 in1;

void main()
{
    gl_Position = dEQP_Position;
    in0 = a_in0;
    in1 = a_in1;
}
#version 310 es
precision highp int;
precision highp float;
bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec3 in0;
layout(location = 1) flat in ivec2 in1;
layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
vec3 out0;


void main ()
{
    
    float x = float[] (in0.x, in0.y, in0.z, -in0.z, -in0.y, -in0.x) [in1.x];
    float y = float[] (in0.x, in0.y, in0.z, -in0.z, -in0.y, -in0.x) [in1.y+2];
    float z = float[] (in0.x, in0.y, in0.z, -in0.z, -in0.y, -in0.x) [in1.x+in1.y];
    out0 = vec3(x, y, z);
    bool RES = isOk(out0, ref.out0, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp int;
precision highp float;
layout(local_size_x = 1) in;

layout(set = 0, binding = 2, std430) readonly buffer InputBlock
{
	vec3 in0;
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


void main ()
{
    
    float x = float[] (in0.x, in0.y, in0.z, -in0.z, -in0.y, -in0.x) [in1.x];
    float y = float[] (in0.x, in0.y, in0.z, -in0.z, -in0.y, -in0.x) [in1.y+2];
    float z = float[] (in0.x, in0.y, in0.z, -in0.z, -in0.y, -in0.x) [in1.x+in1.y];
    out0 = vec3(x, y, z);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 0) flat out vec3 out0;


void main ()
{
    
    float[] x = float[6] (in0.x, in0.y, in0.z, -in0.z, -in0.y, -in0.x),
            y = float[2] (in0.x, -in0.y);
    out0 = vec3(x[2], y[1], x[0]);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec3 in0;
layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
vec3 out0;


void main ()
{
    
    float[] x = float[6] (in0.x, in0.y, in0.z, -in0.z, -in0.y, -in0.x),
            y = float[2] (in0.x, -in0.y);
    out0 = vec3(x[2], y[1], x[0]);
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
	vec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
vec3 out0;
highp vec4 dEQP_Position;


void main ()
{
    
    float[] x = float[6] (in0.x, in0.y, in0.z, -in0.z, -in0.y, -in0.x),
            y = float[2] (in0.x, -in0.y);
    out0 = vec3(x[2], y[1], x[0]);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp int;
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec3 in0;
layout(location = 0) flat out ivec3 out0;


void main ()
{
    
    int[] x = int[] (in0.x, in0.y, in0.z, -in0.z, -in0.y, -in0.x),
          y = int[] (in0.x, -in0.y);
    out0 = ivec3(x[2], y[1], x[0]);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp int;
precision highp float;
bool isOk (ivec3 a, ivec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in ivec3 in0;
layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;
ivec3 out0;


void main ()
{
    
    int[] x = int[] (in0.x, in0.y, in0.z, -in0.z, -in0.y, -in0.x),
          y = int[] (in0.x, -in0.y);
    out0 = ivec3(x[2], y[1], x[0]);
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp int;
precision highp float;
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


void main ()
{
    
    int[] x = int[] (in0.x, in0.y, in0.z, -in0.z, -in0.y, -in0.x),
          y = int[] (in0.x, -in0.y);
    out0 = ivec3(x[2], y[1], x[0]);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 0) flat out ivec3 out0;


void main()
{
    
    float[] x = float[3] (in0.z, in0.x, in0.y);
    float[] y = float[] (in0.z, in0.x, in0.y, in0.x, in0.y);
    float[13] z;

    out0 = ivec3(x.length(), y.length(), z.length());
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
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
    
    float[] x = float[3] (in0.z, in0.x, in0.y);
    float[] y = float[] (in0.z, in0.x, in0.y, in0.x, in0.y);
    float[13] z;

    out0 = ivec3(x.length(), y.length(), z.length());
    bool RES = isOk(out0, ref.out0);
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
    
    float[] x = float[3] (in0.z, in0.x, in0.y);
    float[] y = float[] (in0.z, in0.x, in0.y, in0.x, in0.y);
    float[13] z;

    out0 = ivec3(x.length(), y.length(), z.length());
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp int;
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in ivec3 in0;
layout(location = 0) flat out ivec3 out0;


void main()
{
    
    int[] x = int[3] (in0.z, in0.x, in0.y);
    int[] y = int[] (in0.z, in0.x, in0.y, in0.x, in0.y);
    int[13] z;

    out0 = ivec3(x.length(), y.length(), z.length());
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp int;
precision highp float;
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
    
    int[] x = int[3] (in0.z, in0.x, in0.y);
    int[] y = int[] (in0.z, in0.x, in0.y, in0.x, in0.y);
    int[13] z;

    out0 = ivec3(x.length(), y.length(), z.length());
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp int;
precision highp float;
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
    
    int[] x = int[3] (in0.z, in0.x, in0.y);
    int[] y = int[] (in0.z, in0.x, in0.y, in0.x, in0.y);
    int[13] z;

    out0 = ivec3(x.length(), y.length(), z.length());
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp int;
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in uvec3 a_in0;
layout(location = 0) flat out ivec3 out0;


void main()
{
    bvec3 in0 = bvec3(a_in0);

    bool[] x = bool[3] (in0.z, in0.x, in0.y);
    bool[] y = bool[] (in0.z, in0.x, in0.y, in0.x, in0.y);
    bool[13] z;

    out0 = ivec3(x.length(), y.length(), z.length());
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp int;
precision highp float;
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

    bool[] x = bool[3] (in0.z, in0.x, in0.y);
    bool[] y = bool[] (in0.z, in0.x, in0.y, in0.x, in0.y);
    bool[13] z;

    out0 = ivec3(x.length(), y.length(), z.length());
    bool RES = isOk(out0, ref.out0);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);

}
#version 310 es
precision highp int;
precision highp float;
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
    
    bool[] x = bool[3] (in0.z, in0.x, in0.y);
    bool[] y = bool[] (in0.z, in0.x, in0.y, in0.x, in0.y);
    bool[13] z;

    out0 = ivec3(x.length(), y.length(), z.length());
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 0) flat out ivec3 out0;


struct test
{
    float f;
    vec3 v;
};

void main()
{
    

    test a = test(in0.z, vec3(in0.x, in0.y, in0.z));
    test b = test(in0.y, vec3(-in0.z, -in0.x, -in0.y));
    test c = test(in0.x, vec3(-in0.y, in0.z, -in0.x));

    test[] x = test[3] (a, b, c);
    test[] y = test[] (c, a, b, b, a);
    test[13] z;

    out0 = ivec3(x.length(), y.length(), z.length());
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
bool isOk (ivec3 a, ivec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in vec3 in0;
layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;
ivec3 out0;


struct test
{
    float f;
    vec3 v;
};

void main()
{
    

    test a = test(in0.z, vec3(in0.x, in0.y, in0.z));
    test b = test(in0.y, vec3(-in0.z, -in0.x, -in0.y));
    test c = test(in0.x, vec3(-in0.y, in0.z, -in0.x));

    test[] x = test[3] (a, b, c);
    test[] y = test[] (c, a, b, b, a);
    test[13] z;

    out0 = ivec3(x.length(), y.length(), z.length());
    bool RES = isOk(out0, ref.out0);
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
	ivec3 out0;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (ivec3 a, ivec3 b) { return (a == b); }
ivec3 out0;
highp vec4 dEQP_Position;


struct test
{
    float f;
    vec3 v;
};

void main()
{
    

    test a = test(in0.z, vec3(in0.x, in0.y, in0.z));
    test b = test(in0.y, vec3(-in0.z, -in0.x, -in0.y));
    test c = test(in0.x, vec3(-in0.y, in0.z, -in0.x));

    test[] x = test[3] (a, b, c);
    test[] y = test[] (c, a, b, b, a);
    test[13] z;

    out0 = ivec3(x.length(), y.length(), z.length());
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
