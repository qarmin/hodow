#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
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
layout(location = 1) in float a_in0;
layout(location = 0) flat out float in0;

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
layout(location = 0) flat in float in0;
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
    
    out0 = float(in0);
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
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
layout(location = 0) flat in float in0;
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
    
    out0 = int(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
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
layout(location = 0) flat in float in0;
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
	float in0;
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
layout(location = 1) in int in0;
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

bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in int in0;
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
	int in0;
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
layout(location = 1) in int in0;
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
layout(location = 0) flat in int in0;
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
    
    out0 = int(in0);
    bool RES = isOk(out0, ref.out0);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in int in0;
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
layout(location = 0) flat in int in0;
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
	int in0;
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
layout(location = 1) in uint in0;
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

bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint in0;
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
	uint in0;
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
layout(location = 1) in uint in0;
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
layout(location = 0) flat in uint in0;
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
	uint in0;
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
layout(location = 1) in uint in0;
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
layout(location = 0) flat in uint in0;
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
	uint in0;
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
layout(location = 1) in uint a_in0;
layout(location = 0) flat out float out0;


void main()
{
    bool in0 = bool(a_in0);

    out0 = float(in0);
    gl_Position = dEQP_Position;

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

bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(binding = 0, std140) uniform Reference
{
	float out0;
} ref;
float out0;


void main()
{
    bool in0 = bool(v_in0);

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
	bool in0;
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
layout(location = 1) in uint a_in0;
layout(location = 0) flat out int out0;


void main()
{
    bool in0 = bool(a_in0);

    out0 = int(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (int a, int b)     { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(binding = 0, std140) uniform Reference
{
	int out0;
} ref;
int out0;


void main()
{
    bool in0 = bool(v_in0);

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
	bool in0;
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
layout(location = 1) in uint a_in0;
layout(location = 0) flat out uint v_out0;
bool out0;


void main()
{
    bool in0 = bool(a_in0);

    out0 = bool(in0);
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


void main()
{
    bool in0 = bool(v_in0);

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
layout(location = 1) in float in0;
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
layout(location = 0) flat in float in0;
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
	float in0;
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
layout(location = 1) in int in0;
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
layout(location = 0) flat in int in0;
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
	int in0;
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
layout(location = 1) in uint in0;
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
layout(location = 0) flat in uint in0;
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
layout(location = 1) in uint a_in0;
layout(location = 0) flat out uint out0;


void main()
{
    bool in0 = bool(a_in0);

    out0 = uint(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uint a, uint b)   { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(binding = 0, std140) uniform Reference
{
	uint out0;
} ref;
uint out0;


void main()
{
    bool in0 = bool(v_in0);

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
	bool in0;
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
layout(location = 1) in float in0;
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
layout(location = 0) flat in float in0;
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
	float in0;
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
layout(location = 1) in float in0;
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
layout(location = 0) flat in float in0;
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
	float in0;
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
layout(location = 1) in float in0;
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
layout(location = 0) flat in float in0;
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
	float in0;
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
layout(location = 1) in float in0;
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
layout(location = 0) flat in float in0;
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
	float in0;
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
layout(location = 1) in float in0;
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
layout(location = 0) flat in float in0;
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
	float in0;
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
layout(location = 1) in float in0;
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
layout(location = 0) flat in float in0;
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
	float in0;
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
layout(location = 1) in float in0;
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
layout(location = 0) flat in float in0;
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
	float in0;
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
layout(location = 1) in float in0;
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
layout(location = 0) flat in float in0;
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
	float in0;
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
layout(location = 1) in float in0;
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
layout(location = 0) flat in float in0;
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
	float in0;
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
layout(location = 1) in int in0;
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
layout(location = 0) flat in int in0;
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
	int in0;
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
layout(location = 1) in int in0;
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
layout(location = 0) flat in int in0;
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
	int in0;
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
layout(location = 1) in int in0;
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
layout(location = 0) flat in int in0;
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
	int in0;
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
layout(location = 1) in int in0;
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
layout(location = 0) flat in int in0;
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
	int in0;
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
layout(location = 1) in int in0;
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
layout(location = 0) flat in int in0;
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
	int in0;
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
layout(location = 1) in int in0;
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
layout(location = 0) flat in int in0;
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
	int in0;
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
layout(location = 1) in int in0;
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
layout(location = 0) flat in int in0;
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
	int in0;
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
layout(location = 1) in int in0;
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
layout(location = 0) flat in int in0;
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
	int in0;
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
layout(location = 1) in int in0;
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
layout(location = 0) flat in int in0;
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
	int in0;
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
layout(location = 1) in uint in0;
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
layout(location = 0) flat in uint in0;
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
	uint in0;
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
layout(location = 1) in uint in0;
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
layout(location = 0) flat in uint in0;
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
	uint in0;
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
layout(location = 1) in uint in0;
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
layout(location = 0) flat in uint in0;
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
	uint in0;
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
layout(location = 1) in uint in0;
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
layout(location = 0) flat in uint in0;
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
	uint in0;
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
layout(location = 1) in uint in0;
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
layout(location = 0) flat in uint in0;
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
	uint in0;
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
layout(location = 1) in uint in0;
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
layout(location = 0) flat in uint in0;
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
	uint in0;
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
layout(location = 1) in uint in0;
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
layout(location = 0) flat in uint in0;
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
	uint in0;
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
layout(location = 1) in uint in0;
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
layout(location = 0) flat in uint in0;
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
	uint in0;
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
layout(location = 1) in uint in0;
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
layout(location = 0) flat in uint in0;
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
	uint in0;
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
layout(location = 1) in uint a_in0;
layout(location = 0) flat out vec2 out0;


void main()
{
    bool in0 = bool(a_in0);

    out0 = vec2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec2 a, vec2 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(binding = 0, std140) uniform Reference
{
	vec2 out0;
} ref;
vec2 out0;


void main()
{
    bool in0 = bool(v_in0);

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
	bool in0;
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
layout(location = 1) in uint a_in0;
layout(location = 0) flat out vec3 out0;


void main()
{
    bool in0 = bool(a_in0);

    out0 = vec3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec3 a, vec3 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(binding = 0, std140) uniform Reference
{
	vec3 out0;
} ref;
vec3 out0;


void main()
{
    bool in0 = bool(v_in0);

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
	bool in0;
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
layout(location = 1) in uint a_in0;
layout(location = 0) flat out vec4 out0;


void main()
{
    bool in0 = bool(a_in0);

    out0 = vec4(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (vec4 a, vec4 b, float eps) { return all(lessThanEqual(abs(a-b), (eps*abs(b) + eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(binding = 0, std140) uniform Reference
{
	vec4 out0;
} ref;
vec4 out0;


void main()
{
    bool in0 = bool(v_in0);

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
	bool in0;
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
layout(location = 1) in uint a_in0;
layout(location = 0) flat out ivec2 out0;


void main()
{
    bool in0 = bool(a_in0);

    out0 = ivec2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec2 a, ivec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(binding = 0, std140) uniform Reference
{
	ivec2 out0;
} ref;
ivec2 out0;


void main()
{
    bool in0 = bool(v_in0);

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
	bool in0;
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
layout(location = 1) in uint a_in0;
layout(location = 0) flat out ivec3 out0;


void main()
{
    bool in0 = bool(a_in0);

    out0 = ivec3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec3 a, ivec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(binding = 0, std140) uniform Reference
{
	ivec3 out0;
} ref;
ivec3 out0;


void main()
{
    bool in0 = bool(v_in0);

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
	bool in0;
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
layout(location = 1) in uint a_in0;
layout(location = 0) flat out ivec4 out0;


void main()
{
    bool in0 = bool(a_in0);

    out0 = ivec4(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (ivec4 a, ivec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(binding = 0, std140) uniform Reference
{
	ivec4 out0;
} ref;
ivec4 out0;


void main()
{
    bool in0 = bool(v_in0);

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
	bool in0;
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
layout(location = 1) in uint a_in0;
layout(location = 0) flat out uvec2 v_out0;
bvec2 out0;


void main()
{
    bool in0 = bool(a_in0);

    out0 = bvec2(in0);
    gl_Position = dEQP_Position;
v_out0 = uvec2(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec2 a, bvec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(binding = 0, std140) uniform Reference
{
	bvec2 out0;
} ref;
bvec2 out0;


void main()
{
    bool in0 = bool(v_in0);

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
	bool in0;
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
layout(location = 1) in uint a_in0;
layout(location = 0) flat out uvec3 v_out0;
bvec3 out0;


void main()
{
    bool in0 = bool(a_in0);

    out0 = bvec3(in0);
    gl_Position = dEQP_Position;
v_out0 = uvec3(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec3 a, bvec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(binding = 0, std140) uniform Reference
{
	bvec3 out0;
} ref;
bvec3 out0;


void main()
{
    bool in0 = bool(v_in0);

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
	bool in0;
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
layout(location = 1) in uint a_in0;
layout(location = 0) flat out uvec4 v_out0;
bvec4 out0;


void main()
{
    bool in0 = bool(a_in0);

    out0 = bvec4(in0);
    gl_Position = dEQP_Position;
v_out0 = uvec4(out0);

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (bvec4 a, bvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(binding = 0, std140) uniform Reference
{
	bvec4 out0;
} ref;
bvec4 out0;


void main()
{
    bool in0 = bool(v_in0);

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
	bool in0;
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
layout(location = 1) in float in0;
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
layout(location = 0) flat in float in0;
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
	float in0;
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
layout(location = 1) in float in0;
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
layout(location = 0) flat in float in0;
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
	float in0;
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
layout(location = 1) in float in0;
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
layout(location = 0) flat in float in0;
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
	float in0;
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
layout(location = 1) in int in0;
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
layout(location = 0) flat in int in0;
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
	int in0;
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
layout(location = 1) in int in0;
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
layout(location = 0) flat in int in0;
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
	int in0;
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
layout(location = 1) in int in0;
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
layout(location = 0) flat in int in0;
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
	int in0;
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
layout(location = 1) in uint in0;
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
layout(location = 0) flat in uint in0;
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
	uint in0;
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
layout(location = 1) in uint in0;
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
layout(location = 0) flat in uint in0;
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
	uint in0;
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
layout(location = 1) in uint in0;
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
layout(location = 0) flat in uint in0;
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
	uint in0;
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
layout(location = 1) in uint a_in0;
layout(location = 0) flat out uvec2 out0;


void main()
{
    bool in0 = bool(a_in0);

    out0 = uvec2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec2 a, uvec2 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(binding = 0, std140) uniform Reference
{
	uvec2 out0;
} ref;
uvec2 out0;


void main()
{
    bool in0 = bool(v_in0);

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
	bool in0;
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
layout(location = 1) in uint a_in0;
layout(location = 0) flat out uvec3 out0;


void main()
{
    bool in0 = bool(a_in0);

    out0 = uvec3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec3 a, uvec3 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(binding = 0, std140) uniform Reference
{
	uvec3 out0;
} ref;
uvec3 out0;


void main()
{
    bool in0 = bool(v_in0);

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
	bool in0;
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
layout(location = 1) in uint a_in0;
layout(location = 0) flat out uvec4 out0;


void main()
{
    bool in0 = bool(a_in0);

    out0 = uvec4(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (uvec4 a, uvec4 b) { return (a == b); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(binding = 0, std140) uniform Reference
{
	uvec4 out0;
} ref;
uvec4 out0;


void main()
{
    bool in0 = bool(v_in0);

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
	bool in0;
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
layout(location = 1) in float in0;
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

bool isOk (mat4 a, mat4 b, float eps) { vec4 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
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
	float in0;
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
layout(location = 1) in float in0;
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
layout(location = 0) flat in float in0;
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
	float in0;
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
layout(location = 1) in float in0;
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
layout(location = 0) flat in float in0;
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
	float in0;
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
layout(location = 1) in float in0;
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
layout(location = 0) flat in float in0;
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
	float in0;
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
layout(location = 1) in float in0;
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
layout(location = 0) flat in float in0;
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
	float in0;
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
layout(location = 1) in float in0;
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
layout(location = 0) flat in float in0;
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
	float in0;
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
layout(location = 1) in float in0;
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
layout(location = 0) flat in float in0;
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
	float in0;
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
layout(location = 1) in float in0;
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
layout(location = 0) flat in float in0;
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
	float in0;
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
layout(location = 1) in float in0;
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
layout(location = 0) flat in float in0;
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
	float in0;
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
layout(location = 1) in int in0;
layout(location = 0) flat out mat4 out0;


void main()
{
    
    out0 = mat4(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat4 a, mat4 b, float eps) { vec4 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in int in0;
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
	int in0;
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
layout(location = 1) in int in0;
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
layout(location = 0) flat in int in0;
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
	int in0;
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
layout(location = 1) in int in0;
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
layout(location = 0) flat in int in0;
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
	int in0;
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
layout(location = 1) in int in0;
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
layout(location = 0) flat in int in0;
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
	int in0;
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
layout(location = 1) in int in0;
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
layout(location = 0) flat in int in0;
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
	int in0;
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
layout(location = 1) in int in0;
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
layout(location = 0) flat in int in0;
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
	int in0;
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
layout(location = 1) in int in0;
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
layout(location = 0) flat in int in0;
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
	int in0;
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
layout(location = 1) in int in0;
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
layout(location = 0) flat in int in0;
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
	int in0;
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
layout(location = 1) in int in0;
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
layout(location = 0) flat in int in0;
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
	int in0;
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
layout(location = 1) in uint in0;
layout(location = 0) flat out mat4 out0;


void main()
{
    
    out0 = mat4(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat4 a, mat4 b, float eps) { vec4 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint in0;
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
	uint in0;
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
layout(location = 1) in uint in0;
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
layout(location = 0) flat in uint in0;
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
	uint in0;
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
layout(location = 1) in uint in0;
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
layout(location = 0) flat in uint in0;
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
	uint in0;
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
layout(location = 1) in uint in0;
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
layout(location = 0) flat in uint in0;
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
	uint in0;
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
layout(location = 1) in uint in0;
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
layout(location = 0) flat in uint in0;
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
	uint in0;
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
layout(location = 1) in uint in0;
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
layout(location = 0) flat in uint in0;
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
	uint in0;
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
layout(location = 1) in uint in0;
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
layout(location = 0) flat in uint in0;
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
	uint in0;
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
layout(location = 1) in uint in0;
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
layout(location = 0) flat in uint in0;
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
	uint in0;
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
layout(location = 1) in uint in0;
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
layout(location = 0) flat in uint in0;
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
	uint in0;
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
layout(location = 1) in uint a_in0;
layout(location = 0) flat out mat4 out0;


void main()
{
    bool in0 = bool(a_in0);

    out0 = mat4(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat4 a, mat4 b, float eps) { vec4 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(binding = 0, std140) uniform Reference
{
	mat4 out0;
} ref;
mat4 out0;


void main()
{
    bool in0 = bool(v_in0);

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
	bool in0;
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
layout(location = 1) in uint a_in0;
layout(location = 0) flat out mat4x3 out0;


void main()
{
    bool in0 = bool(a_in0);

    out0 = mat4x3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat4x3 a, mat4x3 b, float eps) { vec3 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(binding = 0, std140) uniform Reference
{
	mat4x3 out0;
} ref;
mat4x3 out0;


void main()
{
    bool in0 = bool(v_in0);

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
	bool in0;
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
layout(location = 1) in uint a_in0;
layout(location = 0) flat out mat4x2 out0;


void main()
{
    bool in0 = bool(a_in0);

    out0 = mat4x2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat4x2 a, mat4x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), max(abs(a[2]-b[2]), abs(a[3]-b[3]))); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(binding = 0, std140) uniform Reference
{
	mat4x2 out0;
} ref;
mat4x2 out0;


void main()
{
    bool in0 = bool(v_in0);

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
	bool in0;
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
layout(location = 1) in uint a_in0;
layout(location = 0) flat out mat3x4 out0;


void main()
{
    bool in0 = bool(a_in0);

    out0 = mat3x4(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat3x4 a, mat3x4 b, float eps) { vec4 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(binding = 0, std140) uniform Reference
{
	mat3x4 out0;
} ref;
mat3x4 out0;


void main()
{
    bool in0 = bool(v_in0);

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
	bool in0;
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
layout(location = 1) in uint a_in0;
layout(location = 0) flat out mat3 out0;


void main()
{
    bool in0 = bool(a_in0);

    out0 = mat3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat3 a, mat3 b, float eps) { vec3 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(binding = 0, std140) uniform Reference
{
	mat3 out0;
} ref;
mat3 out0;


void main()
{
    bool in0 = bool(v_in0);

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
	bool in0;
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
layout(location = 1) in uint a_in0;
layout(location = 0) flat out mat3x2 out0;


void main()
{
    bool in0 = bool(a_in0);

    out0 = mat3x2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat3x2 a, mat3x2 b, float eps) { vec2 diff = max(max(abs(a[0]-b[0]), abs(a[1]-b[1])), abs(a[2]-b[2])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(binding = 0, std140) uniform Reference
{
	mat3x2 out0;
} ref;
mat3x2 out0;


void main()
{
    bool in0 = bool(v_in0);

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
	bool in0;
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
layout(location = 1) in uint a_in0;
layout(location = 0) flat out mat2x4 out0;


void main()
{
    bool in0 = bool(a_in0);

    out0 = mat2x4(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat2x4 a, mat2x4 b, float eps) { vec4 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec4(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(binding = 0, std140) uniform Reference
{
	mat2x4 out0;
} ref;
mat2x4 out0;


void main()
{
    bool in0 = bool(v_in0);

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
	bool in0;
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
layout(location = 1) in uint a_in0;
layout(location = 0) flat out mat2x3 out0;


void main()
{
    bool in0 = bool(a_in0);

    out0 = mat2x3(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat2x3 a, mat2x3 b, float eps) { vec3 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec3(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(binding = 0, std140) uniform Reference
{
	mat2x3 out0;
} ref;
mat2x3 out0;


void main()
{
    bool in0 = bool(v_in0);

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
	bool in0;
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
layout(location = 1) in uint a_in0;
layout(location = 0) flat out mat2 out0;


void main()
{
    bool in0 = bool(a_in0);

    out0 = mat2(in0);
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

bool isOk (mat2 a, mat2 b, float eps) { vec2 diff = max(abs(a[0]-b[0]), abs(a[1]-b[1])); return all(lessThanEqual(diff, vec2(eps))); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in uint v_in0;
layout(binding = 0, std140) uniform Reference
{
	mat2 out0;
} ref;
mat2 out0;


void main()
{
    bool in0 = bool(v_in0);

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
	bool in0;
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
