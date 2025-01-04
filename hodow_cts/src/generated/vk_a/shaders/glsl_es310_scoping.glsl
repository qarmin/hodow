#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 0) flat out int out0;


int a = -1;

void main()
{
    
    int a = in0;

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


int a = -1;

void main()
{
    
    int a = in0;

    out0 = a;
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


int a = -1;

void main()
{
    
    int a = in0;

    out0 = a;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 0) flat out int out0;

void main()
{
    
    int a = in0;
    {
        int a = -1;
    }
    out0 = a;
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

void main()
{
    
    int a = in0;
    {
        int a = -1;
    }
    out0 = a;
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

void main()
{
    
    int a = in0;
    {
        int a = -1;
    }
    out0 = a;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 0) flat out int out0;


int a = -1;

void main()
{
    
    {
        int a = in0;

        out0 = a;
    }
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


int a = -1;

void main()
{
    
    {
        int a = in0;

        out0 = a;
    }
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


int a = -1;

void main()
{
    
    {
        int a = in0;

        out0 = a;
    }
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 0) flat out int out0;

void main()
{
    
    int a = in0;
    for (int a = 0; a < 10; a++)
    {
    }
    out0 = a;
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

void main()
{
    
    int a = in0;
    for (int a = 0; a < 10; a++)
    {
    }
    out0 = a;
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

void main()
{
    
    int a = in0;
    for (int a = 0; a < 10; a++)
    {
    }
    out0 = a;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 0) flat out int out0;

void main()
{
    
    int a = in0;
    int i = 0;
    while (bool a = (i < 1))
    {
        i++;
    }
    out0 = a;
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

void main()
{
    
    int a = in0;
    int i = 0;
    while (bool a = (i < 1))
    {
        i++;
    }
    out0 = a;
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

void main()
{
    
    int a = in0;
    int i = 0;
    while (bool a = (i < 1))
    {
        i++;
    }
    out0 = a;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 0) flat out int out0;


int a = 5;

void main()
{
    
    for (int a = 0; a < 10; a++)
    {
    }
    out0 = in0 + a - 5;
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


int a = 5;

void main()
{
    
    for (int a = 0; a < 10; a++)
    {
    }
    out0 = in0 + a - 5;
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


int a = 5;

void main()
{
    
    for (int a = 0; a < 10; a++)
    {
    }
    out0 = in0 + a - 5;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 0) flat out int out0;


int a = 5;

void main()
{
    
    int i = 0;
    while (bool a = (i < 1))
    {
        i++;
    }
    out0 = in0 + a - 5;
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


int a = 5;

void main()
{
    
    int i = 0;
    while (bool a = (i < 1))
    {
        i++;
    }
    out0 = in0 + a - 5;
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


int a = 5;

void main()
{
    
    int i = 0;
    while (bool a = (i < 1))
    {
        i++;
    }
    out0 = in0 + a - 5;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 0) flat out int out0;


int a = 1;

void main()
{
    
    if (true)
        int a = 42;
    out0 = a*in0;
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


int a = 1;

void main()
{
    
    if (true)
        int a = 42;
    out0 = a*in0;
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


int a = 1;

void main()
{
    
    if (true)
        int a = 42;
    out0 = a*in0;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 0) flat out int out0;

void main()
{
    
    int a = in0;
    {
        int a = a+5, b = a-5;
        out0 = b;
        a = 42;
    }
    out0 = out0 + a - in0;
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

void main()
{
    
    int a = in0;
    {
        int a = a+5, b = a-5;
        out0 = b;
        a = 42;
    }
    out0 = out0 + a - in0;
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

void main()
{
    
    int a = in0;
    {
        int a = a+5, b = a-5;
        out0 = b;
        a = 42;
    }
    out0 = out0 + a - in0;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 0) flat out int out0;


struct S { int val; };

void main()
{
    
    int S = S(in0).val;
    out0 = S;
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


struct S { int val; };

void main()
{
    
    int S = S(in0).val;
    out0 = S;
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


struct S { int val; };

void main()
{
    
    int S = S(in0).val;
    out0 = S;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 0) flat out int out0;


struct S { int val; };

void main()
{
    
    S S = S(in0);
    out0 = S.val;
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


struct S { int val; };

void main()
{
    
    S S = S(in0);
    out0 = S.val;
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


struct S { int val; };

void main()
{
    
    S S = S(in0);
    out0 = S.val;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 0) flat out int out0;


int foo (int x) { return x; }

void main()
{
    
    int foo = in0;
    out0 = foo;
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


int foo (int x) { return x; }

void main()
{
    
    int foo = in0;
    out0 = foo;
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


int foo (int x) { return x; }

void main()
{
    
    int foo = in0;
    out0 = foo;
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 0) flat out int out0;


int a = -1;

int func (int a) { return a; }

void main()
{
    
    out0 = func(in0);
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


int a = -1;

int func (int a) { return a; }

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


int a = -1;

int func (int a) { return a; }

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
layout(location = 1) in int in0;
layout(location = 0) flat out int out0;


struct S { int x; };

int func (int S) { return S; }

void main()
{
    
    out0 = func(in0);
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


struct S { int x; };

int func (int S) { return S; }

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


struct S { int x; };

int func (int S) { return S; }

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
layout(location = 1) in int in0;
layout(location = 0) flat out int out0;


int func (int func) { return func; }

void main()
{
    
    out0 = func(in0);
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


int func (int func) { return func; }

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


int func (int func) { return func; }

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
layout(location = 1) in int in0;
layout(location = 0) flat out int out0;

int func (int inp, int x) { { int x = 5; return inp + x - 5; } }

void main()
{
    
    out0 = func(in0, 42);
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

int func (int inp, int x) { { int x = 5; return inp + x - 5; } }

void main()
{
    
    out0 = func(in0, 42);
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

int func (int inp, int x) { { int x = 5; return inp + x - 5; } }

void main()
{
    
    out0 = func(in0, 42);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
layout(location = 0) flat out int out0;


int func (int x);
int func (int);
int func (int inp) { return inp; }

void main()
{
    
    out0 = func(in0);
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


int func (int x);
int func (int);
int func (int inp) { return inp; }

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


int func (int x);
int func (int);
int func (int inp) { return inp; }

void main()
{
    
    out0 = func(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
