#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 0) flat out float out0;

void main()
{
    out0 = 0.0;
    if (in0 >= 1.0)
        out0 = 1.0;
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
    out0 = 0.0;
    if (in0 >= 1.0)
        out0 = 1.0;
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
    out0 = 0.0;
    if (in0 >= 1.0)
        out0 = 1.0;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 0) flat out float out0;
layout(location = 1) flat out float out1;

void main()
{
    out0 = 0.0;
    out1 = 1.0;
    if (in0 >= 1.0)
    {
        out0 = 1.0;
        out1 = 0.0;
    }
    gl_Position = dEQP_Position;

}
#version 310 es
precision highp float;
precision highp int;

layout(location = 0) out mediump vec4 dEQP_FragColor;

bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }

layout(location = 0) flat in float out0;
layout(location = 1) flat in float out1;
layout(binding = 0, std140) uniform Reference
{
	float out0;
	float out1;
} ref;

void main()
{
    bool RES = isOk(out0, ref.out0, 0.05);
RES = RES && isOk(out1, ref.out1, 0.05);
dEQP_FragColor = vec4(RES, RES, RES, 1.0);
}
#version 310 es
precision highp float;
bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 0) flat in float in0;
layout(binding = 0, std140) uniform Reference
{
	float out0;
	float out1;
} ref;
float out0;
float out1;

void main()
{
    out0 = 0.0;
    out1 = 1.0;
    if (in0 >= 1.0)
    {
        out0 = 1.0;
        out1 = 0.0;
    }
    bool RES = isOk(out0, ref.out0, 0.05);
RES = RES && isOk(out1, ref.out1, 0.05);
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
	float out1;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
float out0;
float out1;
highp vec4 dEQP_Position;

void main()
{
    out0 = 0.0;
    out1 = 1.0;
    if (in0 >= 1.0)
    {
        out0 = 1.0;
        out1 = 0.0;
    }
    bool RES = isOk(out0, ref.out0, 0.05);
RES = RES && isOk(out1, ref.out1, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 0) flat out float out0;
layout(location = 1) flat out float out1;

void main()
{
    out0 = 0.0;
    out1 = 1.0;
    if (in0 >= 1.0)
        out0 = 1.0, out1 = 0.0;
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
	float out1;
} ref;
float out0;
float out1;

void main()
{
    out0 = 0.0;
    out1 = 1.0;
    if (in0 >= 1.0)
        out0 = 1.0, out1 = 0.0;
    bool RES = isOk(out0, ref.out0, 0.05);
RES = RES && isOk(out1, ref.out1, 0.05);
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
	float out1;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
float out0;
float out1;
highp vec4 dEQP_Position;

void main()
{
    out0 = 0.0;
    out1 = 1.0;
    if (in0 >= 1.0)
        out0 = 1.0, out1 = 0.0;
    bool RES = isOk(out0, ref.out0, 0.05);
RES = RES && isOk(out1, ref.out1, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 0) flat out float out0;
layout(location = 1) flat out float out1;

void main()
{
    out0 = 0.0;
    out1 = 1.0;
    if (false, in0 >= 1.0)
        out0 = 1.0, out1 = 0.0;
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
	float out1;
} ref;
float out0;
float out1;

void main()
{
    out0 = 0.0;
    out1 = 1.0;
    if (false, in0 >= 1.0)
        out0 = 1.0, out1 = 0.0;
    bool RES = isOk(out0, ref.out0, 0.05);
RES = RES && isOk(out1, ref.out1, 0.05);
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
	float out1;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
float out0;
float out1;
highp vec4 dEQP_Position;

void main()
{
    out0 = 0.0;
    out1 = 1.0;
    if (false, in0 >= 1.0)
        out0 = 1.0, out1 = 0.0;
    bool RES = isOk(out0, ref.out0, 0.05);
RES = RES && isOk(out1, ref.out1, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 0) flat out float out0;
layout(location = 1) flat out float out1;

void main()
{
    out0 = 0.0;
    out1 = 1.0;
    if (false || (in0 >= 1.0) && (in0 - 2.0*in0 < 0.0))
        out0 = 1.0, out1 = 0.0;
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
	float out1;
} ref;
float out0;
float out1;

void main()
{
    out0 = 0.0;
    out1 = 1.0;
    if (false || (in0 >= 1.0) && (in0 - 2.0*in0 < 0.0))
        out0 = 1.0, out1 = 0.0;
    bool RES = isOk(out0, ref.out0, 0.05);
RES = RES && isOk(out1, ref.out1, 0.05);
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
	float out1;
} ref;
layout(set = 0, binding = 3, std430) writeonly buffer ResultBlock
{
	uint result;
} res;

bool isOk (float a, float b, float eps) { return (abs(a-b) <= (eps*abs(b) + eps)); }
float out0;
float out1;
highp vec4 dEQP_Position;

void main()
{
    out0 = 0.0;
    out1 = 1.0;
    if (false || (in0 >= 1.0) && (in0 - 2.0*in0 < 0.0))
        out0 = 1.0, out1 = 0.0;
    bool RES = isOk(out0, ref.out0, 0.05);
RES = RES && isOk(out1, ref.out1, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 0) flat out float out0;

void main()
{
    if (in0 >= 1.0)
        out0 = 1.0;
    else
        out0 = 0.0;
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

void main()
{
    if (in0 >= 1.0)
        out0 = 1.0;
    else
        out0 = 0.0;
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
    if (in0 >= 1.0)
        out0 = 1.0;
    else
        out0 = 0.0;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 0) flat out float out0;

void main()
{
    out0 = 0.0;
    if (in0 >= 2.0)
        out0 = 2.0;
    else if (in0 >= 1.0)
        out0 = 1.0;
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

void main()
{
    out0 = 0.0;
    if (in0 >= 2.0)
        out0 = 2.0;
    else if (in0 >= 1.0)
        out0 = 1.0;
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
    out0 = 0.0;
    if (in0 >= 2.0)
        out0 = 2.0;
    else if (in0 >= 1.0)
        out0 = 1.0;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 0) flat out float out0;

void main()
{
    if (in0 >= 2.0)
        out0 = 2.0;
    else if (in0 >= 1.0)
        out0 = 1.0;
    else
        out0 = 0.0;
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

void main()
{
    if (in0 >= 2.0)
        out0 = 2.0;
    else if (in0 >= 1.0)
        out0 = 1.0;
    else
        out0 = 0.0;
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
    if (in0 >= 2.0)
        out0 = 2.0;
    else if (in0 >= 1.0)
        out0 = 1.0;
    else
        out0 = 0.0;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
#version 310 es
precision highp float;
layout(location = 0) in highp vec4 dEQP_Position;
layout(location = 1) in float in0;
layout(location = 0) flat out float out0;

void main()
{
    if (in0 >= 2.0)
    {
        out0 = 2.0;
    }
    else if (in0 >= 1.0)
        out0 = 2.0, out0 = 1.0;
    else
        out0 = 0.0;
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

void main()
{
    if (in0 >= 2.0)
    {
        out0 = 2.0;
    }
    else if (in0 >= 1.0)
        out0 = 2.0, out0 = 1.0;
    else
        out0 = 0.0;
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
    if (in0 >= 2.0)
    {
        out0 = 2.0;
    }
    else if (in0 >= 1.0)
        out0 = 2.0, out0 = 1.0;
    else
        out0 = 0.0;
    bool RES = isOk(out0, ref.out0, 0.05);
res.result = RES ? 1u : 0u;

}
