#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const bool sc0 = true;
layout(constant_id = 2) const bool sc1 = false;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    bool r0;
    bool r1;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    gl_Position = position;
}
#version 450
layout(location = 0) out highp vec4 fragColor;

void main (void)
{
    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int sc0 = -3;
layout(constant_id = 2) const int sc1 = 17;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r0;
    int r1;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const uint sc0 = 42u;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint r0;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = 7.5;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float r0;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = 2.75LF;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double r0;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;

    gl_Position = position;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : require
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int8_t sc0 = int8_t(1);
layout(constant_id = 2) const int8_t sc1 = int8_t(-2);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int8_t r0;
    int8_t r1;
} sb_out;



void main (void)
{
    int8_t aux = sc0 + sc1;
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    gl_Position = position;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : require
layout(location = 0) out highp vec4 fragColor;

void main (void)
{
    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : require
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const uint8_t sc0 = int8_t(15);
layout(constant_id = 2) const uint8_t sc1 = int8_t(43);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint8_t r0;
    uint8_t r1;
} sb_out;



void main (void)
{
    uint8_t aux = sc0 + sc1;
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    gl_Position = position;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int16 : require
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int16_t sc0 = 20000s;
layout(constant_id = 2) const int16_t sc1 = -20000s;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int16_t r0;
    int16_t r1;
} sb_out;



void main (void)
{
    int16_t aux = sc0 + sc1;
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    gl_Position = position;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int16 : require
layout(location = 0) out highp vec4 fragColor;

void main (void)
{
    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int16 : require
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const uint16_t sc0 = 64000us;
layout(constant_id = 2) const uint16_t sc1 = 51829us;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint16_t r0;
    uint16_t r1;
} sb_out;



void main (void)
{
    uint16_t aux = sc0 + sc1;
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    gl_Position = position;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int64_t sc0 = 9141386509785772560l;
layout(constant_id = 2) const int64_t sc1 = -9141386509785772560l;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int64_t r0;
    int64_t r1;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    gl_Position = position;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
layout(location = 0) out highp vec4 fragColor;

void main (void)
{
    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const uint64_t sc0 = 18364758544493064720ul;
layout(constant_id = 2) const uint64_t sc1 = 17298946664678735070ul;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint64_t r0;
    uint64_t r1;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    gl_Position = position;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float16_t sc0 = 7.5hf;
layout(constant_id = 2) const float16_t sc1 = 1.125hf;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float16_t r0;
    float16_t r1;
} sb_out;



void main (void)
{
    float16_t aux = sc0 + sc1;
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    gl_Position = position;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) out highp vec4 fragColor;

void main (void)
{
    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const bool sc0 = true;
layout(constant_id = 2) const bool sc1 = false;
layout(constant_id = 3) const bool sc2 = true;
layout(constant_id = 4) const bool sc3 = false;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    bool r0;
    bool r1;
    bool r2;
    bool r3;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;
    sb_out.r2 = sc2;
    sb_out.r3 = sc3;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int sc0 = -3;
layout(constant_id = 2) const int sc1 = 91;
layout(constant_id = 3) const int sc2 = 17;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r0;
    int r1;
    int r2;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;
    sb_out.r2 = sc2;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const uint sc0 = 42u;
layout(constant_id = 2) const uint sc1 = 7u;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint r0;
    uint r1;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = 7.5;
layout(constant_id = 2) const float sc1 = 1.125;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float r0;
    float r1;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = 2.75LF;
layout(constant_id = 2) const double sc1 = 9.25LF;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double r0;
    double r1;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    gl_Position = position;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_explicit_arithmetic_types_int16 : require
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : require
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const uint8_t  sc0 = uint8_t  (0);
layout(constant_id = 2) const uint16_t sc1 = uint16_t (0);
layout(constant_id = 3) const uint     sc2 = uint     (0);
layout(constant_id = 4) const uint64_t sc3 = uint64_t (0);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint64_t r0;
    uint     r1;
    uint16_t r2;
    uint8_t  r3;
} sb_out;



void main (void)
{
    uint64_t i0 = sc3;
    uint     i1 = sc2;
    uint16_t i2 = sc1;
    uint8_t  i3 = sc0;
    sb_out.r0 = i0;
    sb_out.r1 = i1;
    sb_out.r2 = i2;
    sb_out.r3 = i3;

    gl_Position = position;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_explicit_arithmetic_types_int16 : require
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : require
layout(location = 0) out highp vec4 fragColor;

void main (void)
{
    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_explicit_arithmetic_types_int16 : require
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : require
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const uint64_t sc3 = uint64_t (0);
layout(constant_id = 2) const uint     sc2 = uint     (0);
layout(constant_id = 3) const uint16_t sc1 = uint16_t (0);
layout(constant_id = 4) const uint8_t  sc0 = uint8_t  (0);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint64_t r0;
    uint     r1;
    uint16_t r2;
    uint8_t  r3;
} sb_out;



void main (void)
{
    uint64_t i0 = sc3;
    uint     i1 = sc2;
    uint16_t i2 = sc1;
    uint8_t  i3 = sc0;
    sb_out.r0 = i0;
    sb_out.r1 = i1;
    sb_out.r2 = i2;
    sb_out.r3 = i3;

    gl_Position = position;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : require
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int8_t sc0 = int8_t(123);
layout(constant_id = 2) const int8_t sc1 = int8_t(-33);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int8_t r0;
    int8_t r1;
} sb_out;



void main (void)
{
    int8_t aux = sc0 + sc1;
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    gl_Position = position;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : require
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const uint8_t sc0 = int8_t(99);
layout(constant_id = 2) const uint8_t sc1 = int8_t(81);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint8_t r0;
    uint8_t r1;
} sb_out;



void main (void)
{
    uint8_t aux = sc0 + sc1;
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const uint sc0 = 305419896u;
layout(constant_id = 2) const uint sc1 = 591751049u;
layout(constant_id = 3) const uint sc2 = 878082202u;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint r0;
    uint r1;
    uint r2;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;
    sb_out.r2 = sc2;

    gl_Position = position;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float16_t sc0 = 7.5hf;
layout(constant_id = 2) const float16_t sc1 = 1.125hf;
layout(constant_id = 3) const float16_t sc2 = 1.125hf;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float16_t r0;
    float16_t r1;
    float16_t r2;
} sb_out;



void main (void)
{
    float16_t aux = sc0 + sc1;
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;
    sb_out.r2 = sc2;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = 7.5;
layout(constant_id = 2) const float sc1 = 1.125;
layout(constant_id = 3) const float sc2 = 1.125;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float r0;
    float r1;
    float r2;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;
    sb_out.r2 = sc2;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};



layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r0;
} sb_out;



void main (void)
{
    sb_out.r0 = 77;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};


layout(constant_id = 1) const int sc1 = 0;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r1;
} sb_out;



void main (void)
{
    sb_out.r1 = sc1;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 7) const int sc0 = 0;

layout(constant_id = 17) const int sc1 = 0;


layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r0;
    int r1;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 7) const int sc0 = 0;


layout(constant_id = 17) const int sc1 = 0;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r0;
    int r1;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) gl_MaxImageUnits;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    bool ok;
} sb_out;



void main (void)
{
    sb_out.ok = (gl_MaxImageUnits >= 8);

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) gl_MaxImageUnits;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int maxImageUnits;
} sb_out;



void main (void)
{
    sb_out.maxImageUnits = gl_MaxImageUnits;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int sc0 = 2;
layout(constant_id = 2) const int sc1 = 3;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result;
} sb_out;

const int expr0 = sc0 + 1;
const int expr1 = sc0 + sc1;


void main (void)
{
    sb_out.result = expr0 + expr1;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int sc0 = 1;
layout(constant_id = 2) const int sc1 = 2;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r0;
    int r1[3];
} sb_out;



void main (void)
{
    int a0[sc0];
    int a1[sc1];

    for (int i = 0; i < sc0; ++i)
        a0[i] = sc0 - i;
    for (int i = 0; i < sc1; ++i)
        a1[i] = sc1 - i;

    sb_out.r0 = a0[0];
    for (int i = 0; i < sc1; ++i)
         sb_out.r1[i] = a1[i];

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int sc0 = 3;
layout(constant_id = 2) const int sc1 = 5;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r0;
    int r1;
} sb_out;



void main (void)
{
    int a0[sc0 + 3];
    int a1[sc0 + sc1];

    const int size0 = sc0 + 3;
    const int size1 = sc0 + sc1;

    for (int i = 0; i < size0; ++i)
        a0[i] = 3 - i;
    for (int i = 0; i < size1; ++i)
        a1[i] = 5 - i;

    sb_out.r0 = a0[size0 - 1];
    sb_out.r1 = a1[size1 - 1];

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int sc0 = 3;
layout(constant_id = 2) const int sc1 = 5;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r0;
    int r1;
} sb_out;



void main (void)
{
    const int size0 = sc0 + 3;
    const int size1 = sc0 + sc1;

    int a0[size0];
    int a1[size1];

    for (int i = 0; i < size0; ++i)
        a0[i] = 3 - i;
    for (int i = 0; i < size1; ++i)
        a1[i] = 5 - i;

    sb_out.r0 = a0[size0 - 1];
    sb_out.r1 = a1[size1 - 1];

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int sc0 = 1;
layout(constant_id = 2) const int sc1 = 2;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r0;
    int r1;
} sb_out;



void main (void)
{
    int a0[sc0];
    int a1[sc1];

    sb_out.r0 = a0.length();
    sb_out.r1 = a1.length();

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int sc0 = 3;
layout(constant_id = 2) const int sc1 = 1;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result;
} sb_out;

int sumArrays (int a0[sc0], int a1[sc1])
{
    int sum = 0;
    for (int i = 0; (i < sc0) && (i < sc1); ++i)
        sum += a0[i] + a1[i];
    return sum;
}


void main (void)
{
    int a0[sc0];
    int a1[sc1];

    for (int i = 0; i < sc0; ++i)
        a0[i] = i + 1;
    for (int i = 0; i < sc1; ++i)
        a1[i] = i + 2;

    sb_out.result = sumArrays(a0, a1);

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

mat2x3 m0 = mat2x3(sc0, 2, 3, 4, 5, 6);
mat2x3 m1 = mat2x3(1, sc0, 3, 4, 5, 6);
mat2x3 m2 = mat2x3(1, 2, sc0, 4, 5, 6);
mat2x3 m3 = mat2x3(1, 2, 3, sc0, 5, 6);
mat2x3 m4 = mat2x3(1, 2, 3, 4, sc0, 6);
mat2x3 m5 = mat2x3(1, 2, 3, 4, 5, sc0);


void main (void)
{
    float sum_m0 = float(0);
    float sum_m1 = float(0);
    float sum_m2 = float(0);
    float sum_m3 = float(0);
    float sum_m4 = float(0);
    float sum_m5 = float(0);

    for (int i = 0; i < 2; ++i)
    for (int j = 0; j < 3; ++j)
    {
        sum_m0 += float(m0[i][j]);
        sum_m1 += float(m1[i][j]);
        sum_m2 += float(m2[i][j]);
        sum_m3 += float(m3[i][j]);
        sum_m4 += float(m4[i][j]);
        sum_m5 += float(m5[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[8];
} sb_out;

mat2x4 m0 = mat2x4(sc0, 2, 3, 4, 5, 6, 7, 8);
mat2x4 m1 = mat2x4(1, sc0, 3, 4, 5, 6, 7, 8);
mat2x4 m2 = mat2x4(1, 2, sc0, 4, 5, 6, 7, 8);
mat2x4 m3 = mat2x4(1, 2, 3, sc0, 5, 6, 7, 8);
mat2x4 m4 = mat2x4(1, 2, 3, 4, sc0, 6, 7, 8);
mat2x4 m5 = mat2x4(1, 2, 3, 4, 5, sc0, 7, 8);
mat2x4 m6 = mat2x4(1, 2, 3, 4, 5, 6, sc0, 8);
mat2x4 m7 = mat2x4(1, 2, 3, 4, 5, 6, 7, sc0);


void main (void)
{
    float sum_m0 = float(0);
    float sum_m1 = float(0);
    float sum_m2 = float(0);
    float sum_m3 = float(0);
    float sum_m4 = float(0);
    float sum_m5 = float(0);
    float sum_m6 = float(0);
    float sum_m7 = float(0);

    for (int i = 0; i < 2; ++i)
    for (int j = 0; j < 4; ++j)
    {
        sum_m0 += float(m0[i][j]);
        sum_m1 += float(m1[i][j]);
        sum_m2 += float(m2[i][j]);
        sum_m3 += float(m3[i][j]);
        sum_m4 += float(m4[i][j]);
        sum_m5 += float(m5[i][j]);
        sum_m6 += float(m6[i][j]);
        sum_m7 += float(m7[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;
    sb_out.result[6] = sum_m6;
    sb_out.result[7] = sum_m7;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

mat3x2 m0 = mat3x2(sc0, 2, 3, 4, 5, 6);
mat3x2 m1 = mat3x2(1, sc0, 3, 4, 5, 6);
mat3x2 m2 = mat3x2(1, 2, sc0, 4, 5, 6);
mat3x2 m3 = mat3x2(1, 2, 3, sc0, 5, 6);
mat3x2 m4 = mat3x2(1, 2, 3, 4, sc0, 6);
mat3x2 m5 = mat3x2(1, 2, 3, 4, 5, sc0);


void main (void)
{
    float sum_m0 = float(0);
    float sum_m1 = float(0);
    float sum_m2 = float(0);
    float sum_m3 = float(0);
    float sum_m4 = float(0);
    float sum_m5 = float(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_m0 += float(m0[i][j]);
        sum_m1 += float(m1[i][j]);
        sum_m2 += float(m2[i][j]);
        sum_m3 += float(m3[i][j]);
        sum_m4 += float(m4[i][j]);
        sum_m5 += float(m5[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[12];
} sb_out;

mat3x4 m0 = mat3x4(sc0, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);
mat3x4 m1 = mat3x4(1, sc0, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);
mat3x4 m2 = mat3x4(1, 2, sc0, 4, 5, 6, 7, 8, 9, 10, 11, 12);
mat3x4 m3 = mat3x4(1, 2, 3, sc0, 5, 6, 7, 8, 9, 10, 11, 12);
mat3x4 m4 = mat3x4(1, 2, 3, 4, sc0, 6, 7, 8, 9, 10, 11, 12);
mat3x4 m5 = mat3x4(1, 2, 3, 4, 5, sc0, 7, 8, 9, 10, 11, 12);
mat3x4 m6 = mat3x4(1, 2, 3, 4, 5, 6, sc0, 8, 9, 10, 11, 12);
mat3x4 m7 = mat3x4(1, 2, 3, 4, 5, 6, 7, sc0, 9, 10, 11, 12);
mat3x4 m8 = mat3x4(1, 2, 3, 4, 5, 6, 7, 8, sc0, 10, 11, 12);
mat3x4 m9 = mat3x4(1, 2, 3, 4, 5, 6, 7, 8, 9, sc0, 11, 12);
mat3x4 m10 = mat3x4(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, sc0, 12);
mat3x4 m11 = mat3x4(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, sc0);


void main (void)
{
    float sum_m0 = float(0);
    float sum_m1 = float(0);
    float sum_m2 = float(0);
    float sum_m3 = float(0);
    float sum_m4 = float(0);
    float sum_m5 = float(0);
    float sum_m6 = float(0);
    float sum_m7 = float(0);
    float sum_m8 = float(0);
    float sum_m9 = float(0);
    float sum_m10 = float(0);
    float sum_m11 = float(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 4; ++j)
    {
        sum_m0 += float(m0[i][j]);
        sum_m1 += float(m1[i][j]);
        sum_m2 += float(m2[i][j]);
        sum_m3 += float(m3[i][j]);
        sum_m4 += float(m4[i][j]);
        sum_m5 += float(m5[i][j]);
        sum_m6 += float(m6[i][j]);
        sum_m7 += float(m7[i][j]);
        sum_m8 += float(m8[i][j]);
        sum_m9 += float(m9[i][j]);
        sum_m10 += float(m10[i][j]);
        sum_m11 += float(m11[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;
    sb_out.result[6] = sum_m6;
    sb_out.result[7] = sum_m7;
    sb_out.result[8] = sum_m8;
    sb_out.result[9] = sum_m9;
    sb_out.result[10] = sum_m10;
    sb_out.result[11] = sum_m11;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[8];
} sb_out;

mat4x2 m0 = mat4x2(sc0, 2, 3, 4, 5, 6, 7, 8);
mat4x2 m1 = mat4x2(1, sc0, 3, 4, 5, 6, 7, 8);
mat4x2 m2 = mat4x2(1, 2, sc0, 4, 5, 6, 7, 8);
mat4x2 m3 = mat4x2(1, 2, 3, sc0, 5, 6, 7, 8);
mat4x2 m4 = mat4x2(1, 2, 3, 4, sc0, 6, 7, 8);
mat4x2 m5 = mat4x2(1, 2, 3, 4, 5, sc0, 7, 8);
mat4x2 m6 = mat4x2(1, 2, 3, 4, 5, 6, sc0, 8);
mat4x2 m7 = mat4x2(1, 2, 3, 4, 5, 6, 7, sc0);


void main (void)
{
    float sum_m0 = float(0);
    float sum_m1 = float(0);
    float sum_m2 = float(0);
    float sum_m3 = float(0);
    float sum_m4 = float(0);
    float sum_m5 = float(0);
    float sum_m6 = float(0);
    float sum_m7 = float(0);

    for (int i = 0; i < 4; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_m0 += float(m0[i][j]);
        sum_m1 += float(m1[i][j]);
        sum_m2 += float(m2[i][j]);
        sum_m3 += float(m3[i][j]);
        sum_m4 += float(m4[i][j]);
        sum_m5 += float(m5[i][j]);
        sum_m6 += float(m6[i][j]);
        sum_m7 += float(m7[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;
    sb_out.result[6] = sum_m6;
    sb_out.result[7] = sum_m7;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[12];
} sb_out;

mat4x3 m0 = mat4x3(sc0, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);
mat4x3 m1 = mat4x3(1, sc0, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);
mat4x3 m2 = mat4x3(1, 2, sc0, 4, 5, 6, 7, 8, 9, 10, 11, 12);
mat4x3 m3 = mat4x3(1, 2, 3, sc0, 5, 6, 7, 8, 9, 10, 11, 12);
mat4x3 m4 = mat4x3(1, 2, 3, 4, sc0, 6, 7, 8, 9, 10, 11, 12);
mat4x3 m5 = mat4x3(1, 2, 3, 4, 5, sc0, 7, 8, 9, 10, 11, 12);
mat4x3 m6 = mat4x3(1, 2, 3, 4, 5, 6, sc0, 8, 9, 10, 11, 12);
mat4x3 m7 = mat4x3(1, 2, 3, 4, 5, 6, 7, sc0, 9, 10, 11, 12);
mat4x3 m8 = mat4x3(1, 2, 3, 4, 5, 6, 7, 8, sc0, 10, 11, 12);
mat4x3 m9 = mat4x3(1, 2, 3, 4, 5, 6, 7, 8, 9, sc0, 11, 12);
mat4x3 m10 = mat4x3(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, sc0, 12);
mat4x3 m11 = mat4x3(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, sc0);


void main (void)
{
    float sum_m0 = float(0);
    float sum_m1 = float(0);
    float sum_m2 = float(0);
    float sum_m3 = float(0);
    float sum_m4 = float(0);
    float sum_m5 = float(0);
    float sum_m6 = float(0);
    float sum_m7 = float(0);
    float sum_m8 = float(0);
    float sum_m9 = float(0);
    float sum_m10 = float(0);
    float sum_m11 = float(0);

    for (int i = 0; i < 4; ++i)
    for (int j = 0; j < 3; ++j)
    {
        sum_m0 += float(m0[i][j]);
        sum_m1 += float(m1[i][j]);
        sum_m2 += float(m2[i][j]);
        sum_m3 += float(m3[i][j]);
        sum_m4 += float(m4[i][j]);
        sum_m5 += float(m5[i][j]);
        sum_m6 += float(m6[i][j]);
        sum_m7 += float(m7[i][j]);
        sum_m8 += float(m8[i][j]);
        sum_m9 += float(m9[i][j]);
        sum_m10 += float(m10[i][j]);
        sum_m11 += float(m11[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;
    sb_out.result[6] = sum_m6;
    sb_out.result[7] = sum_m7;
    sb_out.result[8] = sum_m8;
    sb_out.result[9] = sum_m9;
    sb_out.result[10] = sum_m10;
    sb_out.result[11] = sum_m11;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

dmat2x3 m0 = dmat2x3(sc0, 2, 3, 4, 5, 6);
dmat2x3 m1 = dmat2x3(1, sc0, 3, 4, 5, 6);
dmat2x3 m2 = dmat2x3(1, 2, sc0, 4, 5, 6);
dmat2x3 m3 = dmat2x3(1, 2, 3, sc0, 5, 6);
dmat2x3 m4 = dmat2x3(1, 2, 3, 4, sc0, 6);
dmat2x3 m5 = dmat2x3(1, 2, 3, 4, 5, sc0);


void main (void)
{
    double sum_m0 = double(0);
    double sum_m1 = double(0);
    double sum_m2 = double(0);
    double sum_m3 = double(0);
    double sum_m4 = double(0);
    double sum_m5 = double(0);

    for (int i = 0; i < 2; ++i)
    for (int j = 0; j < 3; ++j)
    {
        sum_m0 += double(m0[i][j]);
        sum_m1 += double(m1[i][j]);
        sum_m2 += double(m2[i][j]);
        sum_m3 += double(m3[i][j]);
        sum_m4 += double(m4[i][j]);
        sum_m5 += double(m5[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[8];
} sb_out;

dmat2x4 m0 = dmat2x4(sc0, 2, 3, 4, 5, 6, 7, 8);
dmat2x4 m1 = dmat2x4(1, sc0, 3, 4, 5, 6, 7, 8);
dmat2x4 m2 = dmat2x4(1, 2, sc0, 4, 5, 6, 7, 8);
dmat2x4 m3 = dmat2x4(1, 2, 3, sc0, 5, 6, 7, 8);
dmat2x4 m4 = dmat2x4(1, 2, 3, 4, sc0, 6, 7, 8);
dmat2x4 m5 = dmat2x4(1, 2, 3, 4, 5, sc0, 7, 8);
dmat2x4 m6 = dmat2x4(1, 2, 3, 4, 5, 6, sc0, 8);
dmat2x4 m7 = dmat2x4(1, 2, 3, 4, 5, 6, 7, sc0);


void main (void)
{
    double sum_m0 = double(0);
    double sum_m1 = double(0);
    double sum_m2 = double(0);
    double sum_m3 = double(0);
    double sum_m4 = double(0);
    double sum_m5 = double(0);
    double sum_m6 = double(0);
    double sum_m7 = double(0);

    for (int i = 0; i < 2; ++i)
    for (int j = 0; j < 4; ++j)
    {
        sum_m0 += double(m0[i][j]);
        sum_m1 += double(m1[i][j]);
        sum_m2 += double(m2[i][j]);
        sum_m3 += double(m3[i][j]);
        sum_m4 += double(m4[i][j]);
        sum_m5 += double(m5[i][j]);
        sum_m6 += double(m6[i][j]);
        sum_m7 += double(m7[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;
    sb_out.result[6] = sum_m6;
    sb_out.result[7] = sum_m7;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

dmat3x2 m0 = dmat3x2(sc0, 2, 3, 4, 5, 6);
dmat3x2 m1 = dmat3x2(1, sc0, 3, 4, 5, 6);
dmat3x2 m2 = dmat3x2(1, 2, sc0, 4, 5, 6);
dmat3x2 m3 = dmat3x2(1, 2, 3, sc0, 5, 6);
dmat3x2 m4 = dmat3x2(1, 2, 3, 4, sc0, 6);
dmat3x2 m5 = dmat3x2(1, 2, 3, 4, 5, sc0);


void main (void)
{
    double sum_m0 = double(0);
    double sum_m1 = double(0);
    double sum_m2 = double(0);
    double sum_m3 = double(0);
    double sum_m4 = double(0);
    double sum_m5 = double(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_m0 += double(m0[i][j]);
        sum_m1 += double(m1[i][j]);
        sum_m2 += double(m2[i][j]);
        sum_m3 += double(m3[i][j]);
        sum_m4 += double(m4[i][j]);
        sum_m5 += double(m5[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[12];
} sb_out;

dmat3x4 m0 = dmat3x4(sc0, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);
dmat3x4 m1 = dmat3x4(1, sc0, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);
dmat3x4 m2 = dmat3x4(1, 2, sc0, 4, 5, 6, 7, 8, 9, 10, 11, 12);
dmat3x4 m3 = dmat3x4(1, 2, 3, sc0, 5, 6, 7, 8, 9, 10, 11, 12);
dmat3x4 m4 = dmat3x4(1, 2, 3, 4, sc0, 6, 7, 8, 9, 10, 11, 12);
dmat3x4 m5 = dmat3x4(1, 2, 3, 4, 5, sc0, 7, 8, 9, 10, 11, 12);
dmat3x4 m6 = dmat3x4(1, 2, 3, 4, 5, 6, sc0, 8, 9, 10, 11, 12);
dmat3x4 m7 = dmat3x4(1, 2, 3, 4, 5, 6, 7, sc0, 9, 10, 11, 12);
dmat3x4 m8 = dmat3x4(1, 2, 3, 4, 5, 6, 7, 8, sc0, 10, 11, 12);
dmat3x4 m9 = dmat3x4(1, 2, 3, 4, 5, 6, 7, 8, 9, sc0, 11, 12);
dmat3x4 m10 = dmat3x4(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, sc0, 12);
dmat3x4 m11 = dmat3x4(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, sc0);


void main (void)
{
    double sum_m0 = double(0);
    double sum_m1 = double(0);
    double sum_m2 = double(0);
    double sum_m3 = double(0);
    double sum_m4 = double(0);
    double sum_m5 = double(0);
    double sum_m6 = double(0);
    double sum_m7 = double(0);
    double sum_m8 = double(0);
    double sum_m9 = double(0);
    double sum_m10 = double(0);
    double sum_m11 = double(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 4; ++j)
    {
        sum_m0 += double(m0[i][j]);
        sum_m1 += double(m1[i][j]);
        sum_m2 += double(m2[i][j]);
        sum_m3 += double(m3[i][j]);
        sum_m4 += double(m4[i][j]);
        sum_m5 += double(m5[i][j]);
        sum_m6 += double(m6[i][j]);
        sum_m7 += double(m7[i][j]);
        sum_m8 += double(m8[i][j]);
        sum_m9 += double(m9[i][j]);
        sum_m10 += double(m10[i][j]);
        sum_m11 += double(m11[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;
    sb_out.result[6] = sum_m6;
    sb_out.result[7] = sum_m7;
    sb_out.result[8] = sum_m8;
    sb_out.result[9] = sum_m9;
    sb_out.result[10] = sum_m10;
    sb_out.result[11] = sum_m11;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[8];
} sb_out;

dmat4x2 m0 = dmat4x2(sc0, 2, 3, 4, 5, 6, 7, 8);
dmat4x2 m1 = dmat4x2(1, sc0, 3, 4, 5, 6, 7, 8);
dmat4x2 m2 = dmat4x2(1, 2, sc0, 4, 5, 6, 7, 8);
dmat4x2 m3 = dmat4x2(1, 2, 3, sc0, 5, 6, 7, 8);
dmat4x2 m4 = dmat4x2(1, 2, 3, 4, sc0, 6, 7, 8);
dmat4x2 m5 = dmat4x2(1, 2, 3, 4, 5, sc0, 7, 8);
dmat4x2 m6 = dmat4x2(1, 2, 3, 4, 5, 6, sc0, 8);
dmat4x2 m7 = dmat4x2(1, 2, 3, 4, 5, 6, 7, sc0);


void main (void)
{
    double sum_m0 = double(0);
    double sum_m1 = double(0);
    double sum_m2 = double(0);
    double sum_m3 = double(0);
    double sum_m4 = double(0);
    double sum_m5 = double(0);
    double sum_m6 = double(0);
    double sum_m7 = double(0);

    for (int i = 0; i < 4; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_m0 += double(m0[i][j]);
        sum_m1 += double(m1[i][j]);
        sum_m2 += double(m2[i][j]);
        sum_m3 += double(m3[i][j]);
        sum_m4 += double(m4[i][j]);
        sum_m5 += double(m5[i][j]);
        sum_m6 += double(m6[i][j]);
        sum_m7 += double(m7[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;
    sb_out.result[6] = sum_m6;
    sb_out.result[7] = sum_m7;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[12];
} sb_out;

dmat4x3 m0 = dmat4x3(sc0, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);
dmat4x3 m1 = dmat4x3(1, sc0, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);
dmat4x3 m2 = dmat4x3(1, 2, sc0, 4, 5, 6, 7, 8, 9, 10, 11, 12);
dmat4x3 m3 = dmat4x3(1, 2, 3, sc0, 5, 6, 7, 8, 9, 10, 11, 12);
dmat4x3 m4 = dmat4x3(1, 2, 3, 4, sc0, 6, 7, 8, 9, 10, 11, 12);
dmat4x3 m5 = dmat4x3(1, 2, 3, 4, 5, sc0, 7, 8, 9, 10, 11, 12);
dmat4x3 m6 = dmat4x3(1, 2, 3, 4, 5, 6, sc0, 8, 9, 10, 11, 12);
dmat4x3 m7 = dmat4x3(1, 2, 3, 4, 5, 6, 7, sc0, 9, 10, 11, 12);
dmat4x3 m8 = dmat4x3(1, 2, 3, 4, 5, 6, 7, 8, sc0, 10, 11, 12);
dmat4x3 m9 = dmat4x3(1, 2, 3, 4, 5, 6, 7, 8, 9, sc0, 11, 12);
dmat4x3 m10 = dmat4x3(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, sc0, 12);
dmat4x3 m11 = dmat4x3(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, sc0);


void main (void)
{
    double sum_m0 = double(0);
    double sum_m1 = double(0);
    double sum_m2 = double(0);
    double sum_m3 = double(0);
    double sum_m4 = double(0);
    double sum_m5 = double(0);
    double sum_m6 = double(0);
    double sum_m7 = double(0);
    double sum_m8 = double(0);
    double sum_m9 = double(0);
    double sum_m10 = double(0);
    double sum_m11 = double(0);

    for (int i = 0; i < 4; ++i)
    for (int j = 0; j < 3; ++j)
    {
        sum_m0 += double(m0[i][j]);
        sum_m1 += double(m1[i][j]);
        sum_m2 += double(m2[i][j]);
        sum_m3 += double(m3[i][j]);
        sum_m4 += double(m4[i][j]);
        sum_m5 += double(m5[i][j]);
        sum_m6 += double(m6[i][j]);
        sum_m7 += double(m7[i][j]);
        sum_m8 += double(m8[i][j]);
        sum_m9 += double(m9[i][j]);
        sum_m10 += double(m10[i][j]);
        sum_m11 += double(m11[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;
    sb_out.result[6] = sum_m6;
    sb_out.result[7] = sum_m7;
    sb_out.result[8] = sum_m8;
    sb_out.result[9] = sum_m9;
    sb_out.result[10] = sum_m10;
    sb_out.result[11] = sum_m11;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[3];
} sb_out;

float a0[3] = float[3](sc0, 2, 3);
float a1[3] = float[3](1, sc0, 3);
float a2[3] = float[3](1, 2, sc0);


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += float(a0[i]);
        sum_a1 += float(a1[i]);
        sum_a2 += float(a2[i]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[3];
} sb_out;

mat2x3 a0[3] = mat2x3[3](mat2x3(sc0), mat2x3(2), mat2x3(3));
mat2x3 a1[3] = mat2x3[3](mat2x3(1), mat2x3(sc0), mat2x3(3));
mat2x3 a2[3] = mat2x3[3](mat2x3(1), mat2x3(2), mat2x3(sc0));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += float(a0[i][0][0]);
        sum_a1 += float(a1[i][0][0]);
        sum_a2 += float(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[3];
} sb_out;

mat2x4 a0[3] = mat2x4[3](mat2x4(sc0), mat2x4(2), mat2x4(3));
mat2x4 a1[3] = mat2x4[3](mat2x4(1), mat2x4(sc0), mat2x4(3));
mat2x4 a2[3] = mat2x4[3](mat2x4(1), mat2x4(2), mat2x4(sc0));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += float(a0[i][0][0]);
        sum_a1 += float(a1[i][0][0]);
        sum_a2 += float(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[3];
} sb_out;

mat3x2 a0[3] = mat3x2[3](mat3x2(sc0), mat3x2(2), mat3x2(3));
mat3x2 a1[3] = mat3x2[3](mat3x2(1), mat3x2(sc0), mat3x2(3));
mat3x2 a2[3] = mat3x2[3](mat3x2(1), mat3x2(2), mat3x2(sc0));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += float(a0[i][0][0]);
        sum_a1 += float(a1[i][0][0]);
        sum_a2 += float(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[3];
} sb_out;

mat3x4 a0[3] = mat3x4[3](mat3x4(sc0), mat3x4(2), mat3x4(3));
mat3x4 a1[3] = mat3x4[3](mat3x4(1), mat3x4(sc0), mat3x4(3));
mat3x4 a2[3] = mat3x4[3](mat3x4(1), mat3x4(2), mat3x4(sc0));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += float(a0[i][0][0]);
        sum_a1 += float(a1[i][0][0]);
        sum_a2 += float(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[3];
} sb_out;

mat4x2 a0[3] = mat4x2[3](mat4x2(sc0), mat4x2(2), mat4x2(3));
mat4x2 a1[3] = mat4x2[3](mat4x2(1), mat4x2(sc0), mat4x2(3));
mat4x2 a2[3] = mat4x2[3](mat4x2(1), mat4x2(2), mat4x2(sc0));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += float(a0[i][0][0]);
        sum_a1 += float(a1[i][0][0]);
        sum_a2 += float(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[3];
} sb_out;

mat4x3 a0[3] = mat4x3[3](mat4x3(sc0), mat4x3(2), mat4x3(3));
mat4x3 a1[3] = mat4x3[3](mat4x3(1), mat4x3(sc0), mat4x3(3));
mat4x3 a2[3] = mat4x3[3](mat4x3(1), mat4x3(2), mat4x3(sc0));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += float(a0[i][0][0]);
        sum_a1 += float(a1[i][0][0]);
        sum_a2 += float(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[3];
} sb_out;

double a0[3] = double[3](sc0, 2, 3);
double a1[3] = double[3](1, sc0, 3);
double a2[3] = double[3](1, 2, sc0);


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += double(a0[i]);
        sum_a1 += double(a1[i]);
        sum_a2 += double(a2[i]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[3];
} sb_out;

dmat2x3 a0[3] = dmat2x3[3](dmat2x3(sc0), dmat2x3(2), dmat2x3(3));
dmat2x3 a1[3] = dmat2x3[3](dmat2x3(1), dmat2x3(sc0), dmat2x3(3));
dmat2x3 a2[3] = dmat2x3[3](dmat2x3(1), dmat2x3(2), dmat2x3(sc0));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += double(a0[i][0][0]);
        sum_a1 += double(a1[i][0][0]);
        sum_a2 += double(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[3];
} sb_out;

dmat2x4 a0[3] = dmat2x4[3](dmat2x4(sc0), dmat2x4(2), dmat2x4(3));
dmat2x4 a1[3] = dmat2x4[3](dmat2x4(1), dmat2x4(sc0), dmat2x4(3));
dmat2x4 a2[3] = dmat2x4[3](dmat2x4(1), dmat2x4(2), dmat2x4(sc0));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += double(a0[i][0][0]);
        sum_a1 += double(a1[i][0][0]);
        sum_a2 += double(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[3];
} sb_out;

dmat3x2 a0[3] = dmat3x2[3](dmat3x2(sc0), dmat3x2(2), dmat3x2(3));
dmat3x2 a1[3] = dmat3x2[3](dmat3x2(1), dmat3x2(sc0), dmat3x2(3));
dmat3x2 a2[3] = dmat3x2[3](dmat3x2(1), dmat3x2(2), dmat3x2(sc0));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += double(a0[i][0][0]);
        sum_a1 += double(a1[i][0][0]);
        sum_a2 += double(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[3];
} sb_out;

dmat3x4 a0[3] = dmat3x4[3](dmat3x4(sc0), dmat3x4(2), dmat3x4(3));
dmat3x4 a1[3] = dmat3x4[3](dmat3x4(1), dmat3x4(sc0), dmat3x4(3));
dmat3x4 a2[3] = dmat3x4[3](dmat3x4(1), dmat3x4(2), dmat3x4(sc0));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += double(a0[i][0][0]);
        sum_a1 += double(a1[i][0][0]);
        sum_a2 += double(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[3];
} sb_out;

dmat4x2 a0[3] = dmat4x2[3](dmat4x2(sc0), dmat4x2(2), dmat4x2(3));
dmat4x2 a1[3] = dmat4x2[3](dmat4x2(1), dmat4x2(sc0), dmat4x2(3));
dmat4x2 a2[3] = dmat4x2[3](dmat4x2(1), dmat4x2(2), dmat4x2(sc0));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += double(a0[i][0][0]);
        sum_a1 += double(a1[i][0][0]);
        sum_a2 += double(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[3];
} sb_out;

dmat4x3 a0[3] = dmat4x3[3](dmat4x3(sc0), dmat4x3(2), dmat4x3(3));
dmat4x3 a1[3] = dmat4x3[3](dmat4x3(1), dmat4x3(sc0), dmat4x3(3));
dmat4x3 a2[3] = dmat4x3[3](dmat4x3(1), dmat4x3(2), dmat4x3(sc0));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += double(a0[i][0][0]);
        sum_a1 += double(a1[i][0][0]);
        sum_a2 += double(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int sc0 = int(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result[3];
} sb_out;

int a0[3] = int[3](sc0, 2, 3);
int a1[3] = int[3](1, sc0, 3);
int a2[3] = int[3](1, 2, sc0);


void main (void)
{
    int sum_a0 = int(0);
    int sum_a1 = int(0);
    int sum_a2 = int(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += int(a0[i]);
        sum_a1 += int(a1[i]);
        sum_a2 += int(a2[i]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const uint sc0 = uint(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint result[3];
} sb_out;

uint a0[3] = uint[3](sc0, 2, 3);
uint a1[3] = uint[3](1, sc0, 3);
uint a2[3] = uint[3](1, 2, sc0);


void main (void)
{
    uint sum_a0 = uint(0);
    uint sum_a1 = uint(0);
    uint sum_a2 = uint(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += uint(a0[i]);
        sum_a1 += uint(a1[i]);
        sum_a2 += uint(a2[i]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const bool sc0 = bool(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result[3];
} sb_out;

bool a0[3] = bool[3](sc0, true, true);
bool a1[3] = bool[3](true, sc0, true);
bool a2[3] = bool[3](true, true, sc0);


void main (void)
{
    int sum_a0 = int(0);
    int sum_a1 = int(0);
    int sum_a2 = int(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += int(a0[i]);
        sum_a1 += int(a1[i]);
        sum_a2 += int(a2[i]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

float a0[3][2] = float[3][2](float[2](sc0, 2),
                                    float[2](3, 4),
                                    float[2](5, 6));
float a1[3][2] = float[3][2](float[2](1, sc0),
                                    float[2](3, 4),
                                    float[2](5, 6));
float a2[3][2] = float[3][2](float[2](1, 2),
                                    float[2](sc0, 4),
                                    float[2](5, 6));
float a3[3][2] = float[3][2](float[2](1, 2),
                                    float[2](3, sc0),
                                    float[2](5, 6));
float a4[3][2] = float[3][2](float[2](1, 2),
                                    float[2](3, 4),
                                    float[2](sc0, 6));
float a5[3][2] = float[3][2](float[2](1, 2),
                                    float[2](3, 4),
                                    float[2](5, sc0));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);
    float sum_a3 = float(0);
    float sum_a4 = float(0);
    float sum_a5 = float(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += float(a0[i][j]);
        sum_a1 += float(a1[i][j]);
        sum_a2 += float(a2[i][j]);
        sum_a3 += float(a3[i][j]);
        sum_a4 += float(a4[i][j]);
        sum_a5 += float(a5[i][j]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

mat2x3 a0[3][2] = mat2x3[3][2](mat2x3[2](mat2x3(sc0), mat2x3(2)),
                                    mat2x3[2](mat2x3(3), mat2x3(4)),
                                    mat2x3[2](mat2x3(5), mat2x3(6)));
mat2x3 a1[3][2] = mat2x3[3][2](mat2x3[2](mat2x3(1), mat2x3(sc0)),
                                    mat2x3[2](mat2x3(3), mat2x3(4)),
                                    mat2x3[2](mat2x3(5), mat2x3(6)));
mat2x3 a2[3][2] = mat2x3[3][2](mat2x3[2](mat2x3(1), mat2x3(2)),
                                    mat2x3[2](mat2x3(sc0), mat2x3(4)),
                                    mat2x3[2](mat2x3(5), mat2x3(6)));
mat2x3 a3[3][2] = mat2x3[3][2](mat2x3[2](mat2x3(1), mat2x3(2)),
                                    mat2x3[2](mat2x3(3), mat2x3(sc0)),
                                    mat2x3[2](mat2x3(5), mat2x3(6)));
mat2x3 a4[3][2] = mat2x3[3][2](mat2x3[2](mat2x3(1), mat2x3(2)),
                                    mat2x3[2](mat2x3(3), mat2x3(4)),
                                    mat2x3[2](mat2x3(sc0), mat2x3(6)));
mat2x3 a5[3][2] = mat2x3[3][2](mat2x3[2](mat2x3(1), mat2x3(2)),
                                    mat2x3[2](mat2x3(3), mat2x3(4)),
                                    mat2x3[2](mat2x3(5), mat2x3(sc0)));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);
    float sum_a3 = float(0);
    float sum_a4 = float(0);
    float sum_a5 = float(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += float(a0[i][j][0][0]);
        sum_a1 += float(a1[i][j][0][0]);
        sum_a2 += float(a2[i][j][0][0]);
        sum_a3 += float(a3[i][j][0][0]);
        sum_a4 += float(a4[i][j][0][0]);
        sum_a5 += float(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

mat2x4 a0[3][2] = mat2x4[3][2](mat2x4[2](mat2x4(sc0), mat2x4(2)),
                                    mat2x4[2](mat2x4(3), mat2x4(4)),
                                    mat2x4[2](mat2x4(5), mat2x4(6)));
mat2x4 a1[3][2] = mat2x4[3][2](mat2x4[2](mat2x4(1), mat2x4(sc0)),
                                    mat2x4[2](mat2x4(3), mat2x4(4)),
                                    mat2x4[2](mat2x4(5), mat2x4(6)));
mat2x4 a2[3][2] = mat2x4[3][2](mat2x4[2](mat2x4(1), mat2x4(2)),
                                    mat2x4[2](mat2x4(sc0), mat2x4(4)),
                                    mat2x4[2](mat2x4(5), mat2x4(6)));
mat2x4 a3[3][2] = mat2x4[3][2](mat2x4[2](mat2x4(1), mat2x4(2)),
                                    mat2x4[2](mat2x4(3), mat2x4(sc0)),
                                    mat2x4[2](mat2x4(5), mat2x4(6)));
mat2x4 a4[3][2] = mat2x4[3][2](mat2x4[2](mat2x4(1), mat2x4(2)),
                                    mat2x4[2](mat2x4(3), mat2x4(4)),
                                    mat2x4[2](mat2x4(sc0), mat2x4(6)));
mat2x4 a5[3][2] = mat2x4[3][2](mat2x4[2](mat2x4(1), mat2x4(2)),
                                    mat2x4[2](mat2x4(3), mat2x4(4)),
                                    mat2x4[2](mat2x4(5), mat2x4(sc0)));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);
    float sum_a3 = float(0);
    float sum_a4 = float(0);
    float sum_a5 = float(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += float(a0[i][j][0][0]);
        sum_a1 += float(a1[i][j][0][0]);
        sum_a2 += float(a2[i][j][0][0]);
        sum_a3 += float(a3[i][j][0][0]);
        sum_a4 += float(a4[i][j][0][0]);
        sum_a5 += float(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

mat3x2 a0[3][2] = mat3x2[3][2](mat3x2[2](mat3x2(sc0), mat3x2(2)),
                                    mat3x2[2](mat3x2(3), mat3x2(4)),
                                    mat3x2[2](mat3x2(5), mat3x2(6)));
mat3x2 a1[3][2] = mat3x2[3][2](mat3x2[2](mat3x2(1), mat3x2(sc0)),
                                    mat3x2[2](mat3x2(3), mat3x2(4)),
                                    mat3x2[2](mat3x2(5), mat3x2(6)));
mat3x2 a2[3][2] = mat3x2[3][2](mat3x2[2](mat3x2(1), mat3x2(2)),
                                    mat3x2[2](mat3x2(sc0), mat3x2(4)),
                                    mat3x2[2](mat3x2(5), mat3x2(6)));
mat3x2 a3[3][2] = mat3x2[3][2](mat3x2[2](mat3x2(1), mat3x2(2)),
                                    mat3x2[2](mat3x2(3), mat3x2(sc0)),
                                    mat3x2[2](mat3x2(5), mat3x2(6)));
mat3x2 a4[3][2] = mat3x2[3][2](mat3x2[2](mat3x2(1), mat3x2(2)),
                                    mat3x2[2](mat3x2(3), mat3x2(4)),
                                    mat3x2[2](mat3x2(sc0), mat3x2(6)));
mat3x2 a5[3][2] = mat3x2[3][2](mat3x2[2](mat3x2(1), mat3x2(2)),
                                    mat3x2[2](mat3x2(3), mat3x2(4)),
                                    mat3x2[2](mat3x2(5), mat3x2(sc0)));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);
    float sum_a3 = float(0);
    float sum_a4 = float(0);
    float sum_a5 = float(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += float(a0[i][j][0][0]);
        sum_a1 += float(a1[i][j][0][0]);
        sum_a2 += float(a2[i][j][0][0]);
        sum_a3 += float(a3[i][j][0][0]);
        sum_a4 += float(a4[i][j][0][0]);
        sum_a5 += float(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

mat3x4 a0[3][2] = mat3x4[3][2](mat3x4[2](mat3x4(sc0), mat3x4(2)),
                                    mat3x4[2](mat3x4(3), mat3x4(4)),
                                    mat3x4[2](mat3x4(5), mat3x4(6)));
mat3x4 a1[3][2] = mat3x4[3][2](mat3x4[2](mat3x4(1), mat3x4(sc0)),
                                    mat3x4[2](mat3x4(3), mat3x4(4)),
                                    mat3x4[2](mat3x4(5), mat3x4(6)));
mat3x4 a2[3][2] = mat3x4[3][2](mat3x4[2](mat3x4(1), mat3x4(2)),
                                    mat3x4[2](mat3x4(sc0), mat3x4(4)),
                                    mat3x4[2](mat3x4(5), mat3x4(6)));
mat3x4 a3[3][2] = mat3x4[3][2](mat3x4[2](mat3x4(1), mat3x4(2)),
                                    mat3x4[2](mat3x4(3), mat3x4(sc0)),
                                    mat3x4[2](mat3x4(5), mat3x4(6)));
mat3x4 a4[3][2] = mat3x4[3][2](mat3x4[2](mat3x4(1), mat3x4(2)),
                                    mat3x4[2](mat3x4(3), mat3x4(4)),
                                    mat3x4[2](mat3x4(sc0), mat3x4(6)));
mat3x4 a5[3][2] = mat3x4[3][2](mat3x4[2](mat3x4(1), mat3x4(2)),
                                    mat3x4[2](mat3x4(3), mat3x4(4)),
                                    mat3x4[2](mat3x4(5), mat3x4(sc0)));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);
    float sum_a3 = float(0);
    float sum_a4 = float(0);
    float sum_a5 = float(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += float(a0[i][j][0][0]);
        sum_a1 += float(a1[i][j][0][0]);
        sum_a2 += float(a2[i][j][0][0]);
        sum_a3 += float(a3[i][j][0][0]);
        sum_a4 += float(a4[i][j][0][0]);
        sum_a5 += float(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

mat4x2 a0[3][2] = mat4x2[3][2](mat4x2[2](mat4x2(sc0), mat4x2(2)),
                                    mat4x2[2](mat4x2(3), mat4x2(4)),
                                    mat4x2[2](mat4x2(5), mat4x2(6)));
mat4x2 a1[3][2] = mat4x2[3][2](mat4x2[2](mat4x2(1), mat4x2(sc0)),
                                    mat4x2[2](mat4x2(3), mat4x2(4)),
                                    mat4x2[2](mat4x2(5), mat4x2(6)));
mat4x2 a2[3][2] = mat4x2[3][2](mat4x2[2](mat4x2(1), mat4x2(2)),
                                    mat4x2[2](mat4x2(sc0), mat4x2(4)),
                                    mat4x2[2](mat4x2(5), mat4x2(6)));
mat4x2 a3[3][2] = mat4x2[3][2](mat4x2[2](mat4x2(1), mat4x2(2)),
                                    mat4x2[2](mat4x2(3), mat4x2(sc0)),
                                    mat4x2[2](mat4x2(5), mat4x2(6)));
mat4x2 a4[3][2] = mat4x2[3][2](mat4x2[2](mat4x2(1), mat4x2(2)),
                                    mat4x2[2](mat4x2(3), mat4x2(4)),
                                    mat4x2[2](mat4x2(sc0), mat4x2(6)));
mat4x2 a5[3][2] = mat4x2[3][2](mat4x2[2](mat4x2(1), mat4x2(2)),
                                    mat4x2[2](mat4x2(3), mat4x2(4)),
                                    mat4x2[2](mat4x2(5), mat4x2(sc0)));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);
    float sum_a3 = float(0);
    float sum_a4 = float(0);
    float sum_a5 = float(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += float(a0[i][j][0][0]);
        sum_a1 += float(a1[i][j][0][0]);
        sum_a2 += float(a2[i][j][0][0]);
        sum_a3 += float(a3[i][j][0][0]);
        sum_a4 += float(a4[i][j][0][0]);
        sum_a5 += float(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

mat4x3 a0[3][2] = mat4x3[3][2](mat4x3[2](mat4x3(sc0), mat4x3(2)),
                                    mat4x3[2](mat4x3(3), mat4x3(4)),
                                    mat4x3[2](mat4x3(5), mat4x3(6)));
mat4x3 a1[3][2] = mat4x3[3][2](mat4x3[2](mat4x3(1), mat4x3(sc0)),
                                    mat4x3[2](mat4x3(3), mat4x3(4)),
                                    mat4x3[2](mat4x3(5), mat4x3(6)));
mat4x3 a2[3][2] = mat4x3[3][2](mat4x3[2](mat4x3(1), mat4x3(2)),
                                    mat4x3[2](mat4x3(sc0), mat4x3(4)),
                                    mat4x3[2](mat4x3(5), mat4x3(6)));
mat4x3 a3[3][2] = mat4x3[3][2](mat4x3[2](mat4x3(1), mat4x3(2)),
                                    mat4x3[2](mat4x3(3), mat4x3(sc0)),
                                    mat4x3[2](mat4x3(5), mat4x3(6)));
mat4x3 a4[3][2] = mat4x3[3][2](mat4x3[2](mat4x3(1), mat4x3(2)),
                                    mat4x3[2](mat4x3(3), mat4x3(4)),
                                    mat4x3[2](mat4x3(sc0), mat4x3(6)));
mat4x3 a5[3][2] = mat4x3[3][2](mat4x3[2](mat4x3(1), mat4x3(2)),
                                    mat4x3[2](mat4x3(3), mat4x3(4)),
                                    mat4x3[2](mat4x3(5), mat4x3(sc0)));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);
    float sum_a3 = float(0);
    float sum_a4 = float(0);
    float sum_a5 = float(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += float(a0[i][j][0][0]);
        sum_a1 += float(a1[i][j][0][0]);
        sum_a2 += float(a2[i][j][0][0]);
        sum_a3 += float(a3[i][j][0][0]);
        sum_a4 += float(a4[i][j][0][0]);
        sum_a5 += float(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

double a0[3][2] = double[3][2](double[2](sc0, 2),
                                    double[2](3, 4),
                                    double[2](5, 6));
double a1[3][2] = double[3][2](double[2](1, sc0),
                                    double[2](3, 4),
                                    double[2](5, 6));
double a2[3][2] = double[3][2](double[2](1, 2),
                                    double[2](sc0, 4),
                                    double[2](5, 6));
double a3[3][2] = double[3][2](double[2](1, 2),
                                    double[2](3, sc0),
                                    double[2](5, 6));
double a4[3][2] = double[3][2](double[2](1, 2),
                                    double[2](3, 4),
                                    double[2](sc0, 6));
double a5[3][2] = double[3][2](double[2](1, 2),
                                    double[2](3, 4),
                                    double[2](5, sc0));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);
    double sum_a3 = double(0);
    double sum_a4 = double(0);
    double sum_a5 = double(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += double(a0[i][j]);
        sum_a1 += double(a1[i][j]);
        sum_a2 += double(a2[i][j]);
        sum_a3 += double(a3[i][j]);
        sum_a4 += double(a4[i][j]);
        sum_a5 += double(a5[i][j]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

dmat2x3 a0[3][2] = dmat2x3[3][2](dmat2x3[2](dmat2x3(sc0), dmat2x3(2)),
                                    dmat2x3[2](dmat2x3(3), dmat2x3(4)),
                                    dmat2x3[2](dmat2x3(5), dmat2x3(6)));
dmat2x3 a1[3][2] = dmat2x3[3][2](dmat2x3[2](dmat2x3(1), dmat2x3(sc0)),
                                    dmat2x3[2](dmat2x3(3), dmat2x3(4)),
                                    dmat2x3[2](dmat2x3(5), dmat2x3(6)));
dmat2x3 a2[3][2] = dmat2x3[3][2](dmat2x3[2](dmat2x3(1), dmat2x3(2)),
                                    dmat2x3[2](dmat2x3(sc0), dmat2x3(4)),
                                    dmat2x3[2](dmat2x3(5), dmat2x3(6)));
dmat2x3 a3[3][2] = dmat2x3[3][2](dmat2x3[2](dmat2x3(1), dmat2x3(2)),
                                    dmat2x3[2](dmat2x3(3), dmat2x3(sc0)),
                                    dmat2x3[2](dmat2x3(5), dmat2x3(6)));
dmat2x3 a4[3][2] = dmat2x3[3][2](dmat2x3[2](dmat2x3(1), dmat2x3(2)),
                                    dmat2x3[2](dmat2x3(3), dmat2x3(4)),
                                    dmat2x3[2](dmat2x3(sc0), dmat2x3(6)));
dmat2x3 a5[3][2] = dmat2x3[3][2](dmat2x3[2](dmat2x3(1), dmat2x3(2)),
                                    dmat2x3[2](dmat2x3(3), dmat2x3(4)),
                                    dmat2x3[2](dmat2x3(5), dmat2x3(sc0)));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);
    double sum_a3 = double(0);
    double sum_a4 = double(0);
    double sum_a5 = double(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += double(a0[i][j][0][0]);
        sum_a1 += double(a1[i][j][0][0]);
        sum_a2 += double(a2[i][j][0][0]);
        sum_a3 += double(a3[i][j][0][0]);
        sum_a4 += double(a4[i][j][0][0]);
        sum_a5 += double(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

dmat2x4 a0[3][2] = dmat2x4[3][2](dmat2x4[2](dmat2x4(sc0), dmat2x4(2)),
                                    dmat2x4[2](dmat2x4(3), dmat2x4(4)),
                                    dmat2x4[2](dmat2x4(5), dmat2x4(6)));
dmat2x4 a1[3][2] = dmat2x4[3][2](dmat2x4[2](dmat2x4(1), dmat2x4(sc0)),
                                    dmat2x4[2](dmat2x4(3), dmat2x4(4)),
                                    dmat2x4[2](dmat2x4(5), dmat2x4(6)));
dmat2x4 a2[3][2] = dmat2x4[3][2](dmat2x4[2](dmat2x4(1), dmat2x4(2)),
                                    dmat2x4[2](dmat2x4(sc0), dmat2x4(4)),
                                    dmat2x4[2](dmat2x4(5), dmat2x4(6)));
dmat2x4 a3[3][2] = dmat2x4[3][2](dmat2x4[2](dmat2x4(1), dmat2x4(2)),
                                    dmat2x4[2](dmat2x4(3), dmat2x4(sc0)),
                                    dmat2x4[2](dmat2x4(5), dmat2x4(6)));
dmat2x4 a4[3][2] = dmat2x4[3][2](dmat2x4[2](dmat2x4(1), dmat2x4(2)),
                                    dmat2x4[2](dmat2x4(3), dmat2x4(4)),
                                    dmat2x4[2](dmat2x4(sc0), dmat2x4(6)));
dmat2x4 a5[3][2] = dmat2x4[3][2](dmat2x4[2](dmat2x4(1), dmat2x4(2)),
                                    dmat2x4[2](dmat2x4(3), dmat2x4(4)),
                                    dmat2x4[2](dmat2x4(5), dmat2x4(sc0)));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);
    double sum_a3 = double(0);
    double sum_a4 = double(0);
    double sum_a5 = double(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += double(a0[i][j][0][0]);
        sum_a1 += double(a1[i][j][0][0]);
        sum_a2 += double(a2[i][j][0][0]);
        sum_a3 += double(a3[i][j][0][0]);
        sum_a4 += double(a4[i][j][0][0]);
        sum_a5 += double(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

dmat3x2 a0[3][2] = dmat3x2[3][2](dmat3x2[2](dmat3x2(sc0), dmat3x2(2)),
                                    dmat3x2[2](dmat3x2(3), dmat3x2(4)),
                                    dmat3x2[2](dmat3x2(5), dmat3x2(6)));
dmat3x2 a1[3][2] = dmat3x2[3][2](dmat3x2[2](dmat3x2(1), dmat3x2(sc0)),
                                    dmat3x2[2](dmat3x2(3), dmat3x2(4)),
                                    dmat3x2[2](dmat3x2(5), dmat3x2(6)));
dmat3x2 a2[3][2] = dmat3x2[3][2](dmat3x2[2](dmat3x2(1), dmat3x2(2)),
                                    dmat3x2[2](dmat3x2(sc0), dmat3x2(4)),
                                    dmat3x2[2](dmat3x2(5), dmat3x2(6)));
dmat3x2 a3[3][2] = dmat3x2[3][2](dmat3x2[2](dmat3x2(1), dmat3x2(2)),
                                    dmat3x2[2](dmat3x2(3), dmat3x2(sc0)),
                                    dmat3x2[2](dmat3x2(5), dmat3x2(6)));
dmat3x2 a4[3][2] = dmat3x2[3][2](dmat3x2[2](dmat3x2(1), dmat3x2(2)),
                                    dmat3x2[2](dmat3x2(3), dmat3x2(4)),
                                    dmat3x2[2](dmat3x2(sc0), dmat3x2(6)));
dmat3x2 a5[3][2] = dmat3x2[3][2](dmat3x2[2](dmat3x2(1), dmat3x2(2)),
                                    dmat3x2[2](dmat3x2(3), dmat3x2(4)),
                                    dmat3x2[2](dmat3x2(5), dmat3x2(sc0)));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);
    double sum_a3 = double(0);
    double sum_a4 = double(0);
    double sum_a5 = double(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += double(a0[i][j][0][0]);
        sum_a1 += double(a1[i][j][0][0]);
        sum_a2 += double(a2[i][j][0][0]);
        sum_a3 += double(a3[i][j][0][0]);
        sum_a4 += double(a4[i][j][0][0]);
        sum_a5 += double(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

dmat3x4 a0[3][2] = dmat3x4[3][2](dmat3x4[2](dmat3x4(sc0), dmat3x4(2)),
                                    dmat3x4[2](dmat3x4(3), dmat3x4(4)),
                                    dmat3x4[2](dmat3x4(5), dmat3x4(6)));
dmat3x4 a1[3][2] = dmat3x4[3][2](dmat3x4[2](dmat3x4(1), dmat3x4(sc0)),
                                    dmat3x4[2](dmat3x4(3), dmat3x4(4)),
                                    dmat3x4[2](dmat3x4(5), dmat3x4(6)));
dmat3x4 a2[3][2] = dmat3x4[3][2](dmat3x4[2](dmat3x4(1), dmat3x4(2)),
                                    dmat3x4[2](dmat3x4(sc0), dmat3x4(4)),
                                    dmat3x4[2](dmat3x4(5), dmat3x4(6)));
dmat3x4 a3[3][2] = dmat3x4[3][2](dmat3x4[2](dmat3x4(1), dmat3x4(2)),
                                    dmat3x4[2](dmat3x4(3), dmat3x4(sc0)),
                                    dmat3x4[2](dmat3x4(5), dmat3x4(6)));
dmat3x4 a4[3][2] = dmat3x4[3][2](dmat3x4[2](dmat3x4(1), dmat3x4(2)),
                                    dmat3x4[2](dmat3x4(3), dmat3x4(4)),
                                    dmat3x4[2](dmat3x4(sc0), dmat3x4(6)));
dmat3x4 a5[3][2] = dmat3x4[3][2](dmat3x4[2](dmat3x4(1), dmat3x4(2)),
                                    dmat3x4[2](dmat3x4(3), dmat3x4(4)),
                                    dmat3x4[2](dmat3x4(5), dmat3x4(sc0)));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);
    double sum_a3 = double(0);
    double sum_a4 = double(0);
    double sum_a5 = double(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += double(a0[i][j][0][0]);
        sum_a1 += double(a1[i][j][0][0]);
        sum_a2 += double(a2[i][j][0][0]);
        sum_a3 += double(a3[i][j][0][0]);
        sum_a4 += double(a4[i][j][0][0]);
        sum_a5 += double(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

dmat4x2 a0[3][2] = dmat4x2[3][2](dmat4x2[2](dmat4x2(sc0), dmat4x2(2)),
                                    dmat4x2[2](dmat4x2(3), dmat4x2(4)),
                                    dmat4x2[2](dmat4x2(5), dmat4x2(6)));
dmat4x2 a1[3][2] = dmat4x2[3][2](dmat4x2[2](dmat4x2(1), dmat4x2(sc0)),
                                    dmat4x2[2](dmat4x2(3), dmat4x2(4)),
                                    dmat4x2[2](dmat4x2(5), dmat4x2(6)));
dmat4x2 a2[3][2] = dmat4x2[3][2](dmat4x2[2](dmat4x2(1), dmat4x2(2)),
                                    dmat4x2[2](dmat4x2(sc0), dmat4x2(4)),
                                    dmat4x2[2](dmat4x2(5), dmat4x2(6)));
dmat4x2 a3[3][2] = dmat4x2[3][2](dmat4x2[2](dmat4x2(1), dmat4x2(2)),
                                    dmat4x2[2](dmat4x2(3), dmat4x2(sc0)),
                                    dmat4x2[2](dmat4x2(5), dmat4x2(6)));
dmat4x2 a4[3][2] = dmat4x2[3][2](dmat4x2[2](dmat4x2(1), dmat4x2(2)),
                                    dmat4x2[2](dmat4x2(3), dmat4x2(4)),
                                    dmat4x2[2](dmat4x2(sc0), dmat4x2(6)));
dmat4x2 a5[3][2] = dmat4x2[3][2](dmat4x2[2](dmat4x2(1), dmat4x2(2)),
                                    dmat4x2[2](dmat4x2(3), dmat4x2(4)),
                                    dmat4x2[2](dmat4x2(5), dmat4x2(sc0)));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);
    double sum_a3 = double(0);
    double sum_a4 = double(0);
    double sum_a5 = double(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += double(a0[i][j][0][0]);
        sum_a1 += double(a1[i][j][0][0]);
        sum_a2 += double(a2[i][j][0][0]);
        sum_a3 += double(a3[i][j][0][0]);
        sum_a4 += double(a4[i][j][0][0]);
        sum_a5 += double(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

dmat4x3 a0[3][2] = dmat4x3[3][2](dmat4x3[2](dmat4x3(sc0), dmat4x3(2)),
                                    dmat4x3[2](dmat4x3(3), dmat4x3(4)),
                                    dmat4x3[2](dmat4x3(5), dmat4x3(6)));
dmat4x3 a1[3][2] = dmat4x3[3][2](dmat4x3[2](dmat4x3(1), dmat4x3(sc0)),
                                    dmat4x3[2](dmat4x3(3), dmat4x3(4)),
                                    dmat4x3[2](dmat4x3(5), dmat4x3(6)));
dmat4x3 a2[3][2] = dmat4x3[3][2](dmat4x3[2](dmat4x3(1), dmat4x3(2)),
                                    dmat4x3[2](dmat4x3(sc0), dmat4x3(4)),
                                    dmat4x3[2](dmat4x3(5), dmat4x3(6)));
dmat4x3 a3[3][2] = dmat4x3[3][2](dmat4x3[2](dmat4x3(1), dmat4x3(2)),
                                    dmat4x3[2](dmat4x3(3), dmat4x3(sc0)),
                                    dmat4x3[2](dmat4x3(5), dmat4x3(6)));
dmat4x3 a4[3][2] = dmat4x3[3][2](dmat4x3[2](dmat4x3(1), dmat4x3(2)),
                                    dmat4x3[2](dmat4x3(3), dmat4x3(4)),
                                    dmat4x3[2](dmat4x3(sc0), dmat4x3(6)));
dmat4x3 a5[3][2] = dmat4x3[3][2](dmat4x3[2](dmat4x3(1), dmat4x3(2)),
                                    dmat4x3[2](dmat4x3(3), dmat4x3(4)),
                                    dmat4x3[2](dmat4x3(5), dmat4x3(sc0)));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);
    double sum_a3 = double(0);
    double sum_a4 = double(0);
    double sum_a5 = double(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += double(a0[i][j][0][0]);
        sum_a1 += double(a1[i][j][0][0]);
        sum_a2 += double(a2[i][j][0][0]);
        sum_a3 += double(a3[i][j][0][0]);
        sum_a4 += double(a4[i][j][0][0]);
        sum_a5 += double(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int sc0 = int(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result[6];
} sb_out;

int a0[3][2] = int[3][2](int[2](sc0, 2),
                                    int[2](3, 4),
                                    int[2](5, 6));
int a1[3][2] = int[3][2](int[2](1, sc0),
                                    int[2](3, 4),
                                    int[2](5, 6));
int a2[3][2] = int[3][2](int[2](1, 2),
                                    int[2](sc0, 4),
                                    int[2](5, 6));
int a3[3][2] = int[3][2](int[2](1, 2),
                                    int[2](3, sc0),
                                    int[2](5, 6));
int a4[3][2] = int[3][2](int[2](1, 2),
                                    int[2](3, 4),
                                    int[2](sc0, 6));
int a5[3][2] = int[3][2](int[2](1, 2),
                                    int[2](3, 4),
                                    int[2](5, sc0));


void main (void)
{
    int sum_a0 = int(0);
    int sum_a1 = int(0);
    int sum_a2 = int(0);
    int sum_a3 = int(0);
    int sum_a4 = int(0);
    int sum_a5 = int(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += int(a0[i][j]);
        sum_a1 += int(a1[i][j]);
        sum_a2 += int(a2[i][j]);
        sum_a3 += int(a3[i][j]);
        sum_a4 += int(a4[i][j]);
        sum_a5 += int(a5[i][j]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const uint sc0 = uint(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint result[6];
} sb_out;

uint a0[3][2] = uint[3][2](uint[2](sc0, 2),
                                    uint[2](3, 4),
                                    uint[2](5, 6));
uint a1[3][2] = uint[3][2](uint[2](1, sc0),
                                    uint[2](3, 4),
                                    uint[2](5, 6));
uint a2[3][2] = uint[3][2](uint[2](1, 2),
                                    uint[2](sc0, 4),
                                    uint[2](5, 6));
uint a3[3][2] = uint[3][2](uint[2](1, 2),
                                    uint[2](3, sc0),
                                    uint[2](5, 6));
uint a4[3][2] = uint[3][2](uint[2](1, 2),
                                    uint[2](3, 4),
                                    uint[2](sc0, 6));
uint a5[3][2] = uint[3][2](uint[2](1, 2),
                                    uint[2](3, 4),
                                    uint[2](5, sc0));


void main (void)
{
    uint sum_a0 = uint(0);
    uint sum_a1 = uint(0);
    uint sum_a2 = uint(0);
    uint sum_a3 = uint(0);
    uint sum_a4 = uint(0);
    uint sum_a5 = uint(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += uint(a0[i][j]);
        sum_a1 += uint(a1[i][j]);
        sum_a2 += uint(a2[i][j]);
        sum_a3 += uint(a3[i][j]);
        sum_a4 += uint(a4[i][j]);
        sum_a5 += uint(a5[i][j]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const bool sc0 = bool(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result[6];
} sb_out;

bool a0[3][2] = bool[3][2](bool[2](sc0, true),
                                    bool[2](true, true),
                                    bool[2](true, true));
bool a1[3][2] = bool[3][2](bool[2](true, sc0),
                                    bool[2](true, true),
                                    bool[2](true, true));
bool a2[3][2] = bool[3][2](bool[2](true, true),
                                    bool[2](sc0, true),
                                    bool[2](true, true));
bool a3[3][2] = bool[3][2](bool[2](true, true),
                                    bool[2](true, sc0),
                                    bool[2](true, true));
bool a4[3][2] = bool[3][2](bool[2](true, true),
                                    bool[2](true, true),
                                    bool[2](sc0, true));
bool a5[3][2] = bool[3][2](bool[2](true, true),
                                    bool[2](true, true),
                                    bool[2](true, sc0));


void main (void)
{
    int sum_a0 = int(0);
    int sum_a1 = int(0);
    int sum_a2 = int(0);
    int sum_a3 = int(0);
    int sum_a4 = int(0);
    int sum_a5 = int(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += int(a0[i][j]);
        sum_a1 += int(a1[i][j]);
        sum_a2 += int(a2[i][j]);
        sum_a3 += int(a3[i][j]);
        sum_a4 += int(a4[i][j]);
        sum_a5 += int(a5[i][j]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int   sc0 = 1;
layout(constant_id = 2) const float sc1 = 1.0;
layout(constant_id = 3) const bool  sc2 = true;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result;
} sb_out;

struct Data {
    int   x;
    float y;
    bool  z;
};

Data a0[3] = Data[3](Data(sc0, 2.0, true), Data(1, sc1, true), Data(1, 2.0, sc2));


void main (void)
{
    int sum_a0 = 0;

    for (int i = 0; i < 3; ++i)
        sum_a0 += int(a0[i].x) + int(a0[i].y) + int(a0[i].z);

    sb_out.result = sum_a0;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    float sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, float(sc0), 8u);


void main (void)
{
    float sum_s0 = float(0);

    sum_s0 += float(s0.i);
    sum_s0 += float(s0.f);
    sum_s0 += float(s0.b);
    sum_s0 += float(s0.sc);
    sum_s0 += float(s0.ui);

    sb_out.result = sum_s0;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    mat2x3 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, mat2x3(sc0), 8u);


void main (void)
{
    float sum_s0 = float(0);

    sum_s0 += float(s0.i);
    sum_s0 += float(s0.f);
    sum_s0 += float(s0.b);
    sum_s0 += float(s0.sc[0][0]);
    sum_s0 += float(s0.ui);

    sb_out.result = sum_s0;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    mat2x4 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, mat2x4(sc0), 8u);


void main (void)
{
    float sum_s0 = float(0);

    sum_s0 += float(s0.i);
    sum_s0 += float(s0.f);
    sum_s0 += float(s0.b);
    sum_s0 += float(s0.sc[0][0]);
    sum_s0 += float(s0.ui);

    sb_out.result = sum_s0;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    mat3x2 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, mat3x2(sc0), 8u);


void main (void)
{
    float sum_s0 = float(0);

    sum_s0 += float(s0.i);
    sum_s0 += float(s0.f);
    sum_s0 += float(s0.b);
    sum_s0 += float(s0.sc[0][0]);
    sum_s0 += float(s0.ui);

    sb_out.result = sum_s0;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    mat3x4 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, mat3x4(sc0), 8u);


void main (void)
{
    float sum_s0 = float(0);

    sum_s0 += float(s0.i);
    sum_s0 += float(s0.f);
    sum_s0 += float(s0.b);
    sum_s0 += float(s0.sc[0][0]);
    sum_s0 += float(s0.ui);

    sb_out.result = sum_s0;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    mat4x2 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, mat4x2(sc0), 8u);


void main (void)
{
    float sum_s0 = float(0);

    sum_s0 += float(s0.i);
    sum_s0 += float(s0.f);
    sum_s0 += float(s0.b);
    sum_s0 += float(s0.sc[0][0]);
    sum_s0 += float(s0.ui);

    sb_out.result = sum_s0;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    mat4x3 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, mat4x3(sc0), 8u);


void main (void)
{
    float sum_s0 = float(0);

    sum_s0 += float(s0.i);
    sum_s0 += float(s0.f);
    sum_s0 += float(s0.b);
    sum_s0 += float(s0.sc[0][0]);
    sum_s0 += float(s0.ui);

    sb_out.result = sum_s0;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    double sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, double(sc0), 8u);


void main (void)
{
    double sum_s0 = double(0);

    sum_s0 += double(s0.i);
    sum_s0 += double(s0.f);
    sum_s0 += double(s0.b);
    sum_s0 += double(s0.sc);
    sum_s0 += double(s0.ui);

    sb_out.result = sum_s0;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    dmat2x3 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, dmat2x3(sc0), 8u);


void main (void)
{
    double sum_s0 = double(0);

    sum_s0 += double(s0.i);
    sum_s0 += double(s0.f);
    sum_s0 += double(s0.b);
    sum_s0 += double(s0.sc[0][0]);
    sum_s0 += double(s0.ui);

    sb_out.result = sum_s0;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    dmat2x4 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, dmat2x4(sc0), 8u);


void main (void)
{
    double sum_s0 = double(0);

    sum_s0 += double(s0.i);
    sum_s0 += double(s0.f);
    sum_s0 += double(s0.b);
    sum_s0 += double(s0.sc[0][0]);
    sum_s0 += double(s0.ui);

    sb_out.result = sum_s0;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    dmat3x2 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, dmat3x2(sc0), 8u);


void main (void)
{
    double sum_s0 = double(0);

    sum_s0 += double(s0.i);
    sum_s0 += double(s0.f);
    sum_s0 += double(s0.b);
    sum_s0 += double(s0.sc[0][0]);
    sum_s0 += double(s0.ui);

    sb_out.result = sum_s0;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    dmat3x4 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, dmat3x4(sc0), 8u);


void main (void)
{
    double sum_s0 = double(0);

    sum_s0 += double(s0.i);
    sum_s0 += double(s0.f);
    sum_s0 += double(s0.b);
    sum_s0 += double(s0.sc[0][0]);
    sum_s0 += double(s0.ui);

    sb_out.result = sum_s0;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    dmat4x2 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, dmat4x2(sc0), 8u);


void main (void)
{
    double sum_s0 = double(0);

    sum_s0 += double(s0.i);
    sum_s0 += double(s0.f);
    sum_s0 += double(s0.b);
    sum_s0 += double(s0.sc[0][0]);
    sum_s0 += double(s0.ui);

    sb_out.result = sum_s0;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    dmat4x3 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, dmat4x3(sc0), 8u);


void main (void)
{
    double sum_s0 = double(0);

    sum_s0 += double(s0.i);
    sum_s0 += double(s0.f);
    sum_s0 += double(s0.b);
    sum_s0 += double(s0.sc[0][0]);
    sum_s0 += double(s0.ui);

    sb_out.result = sum_s0;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int sc0 = int(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    int sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, int(sc0), 8u);


void main (void)
{
    int sum_s0 = int(0);

    sum_s0 += int(s0.i);
    sum_s0 += int(s0.f);
    sum_s0 += int(s0.b);
    sum_s0 += int(s0.sc);
    sum_s0 += int(s0.ui);

    sb_out.result = sum_s0;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const uint sc0 = uint(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    uint sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, uint(sc0), 8u);


void main (void)
{
    uint sum_s0 = uint(0);

    sum_s0 += uint(s0.i);
    sum_s0 += uint(s0.f);
    sum_s0 += uint(s0.b);
    sum_s0 += uint(s0.sc);
    sum_s0 += uint(s0.ui);

    sb_out.result = sum_s0;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const bool sc0 = bool(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    bool sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, bool(sc0), 8u);


void main (void)
{
    int sum_s0 = int(0);

    sum_s0 += int(s0.i);
    sum_s0 += int(s0.f);
    sum_s0 += int(s0.b);
    sum_s0 += int(s0.sc);
    sum_s0 += int(s0.ui);

    sb_out.result = sum_s0;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = 1.0;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result;
} sb_out;

struct Data {
    int  i;
    vec3 sc[3];
    bool b;
};

Data s0 = Data(1, vec3[3](vec3(2.0), vec3(sc0), vec3(4.0)), false);


void main (void)
{
    float sum_s0 = 0;

    sum_s0 += float(s0.i);
    sum_s0 += float(s0.sc[0][0]);
    sum_s0 += float(s0.sc[1][0]);
    sum_s0 += float(s0.sc[2][0]);
    sum_s0 += float(s0.b);

    sb_out.result = sum_s0;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int sc0 = 1;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result;
} sb_out;

struct Nested {
    vec2  v;
    int   sc;
    float f;
};

struct Data {
    uint   ui;
    Nested s;
    bool   b;
};

Data s0 = Data(1u, Nested(vec2(2.0), sc0, 4.0), true);


void main (void)
{
    int sum_s0 = 0;

    sum_s0 += int(s0.ui);
    sum_s0 += int(s0.s.v[0]);
    sum_s0 += int(s0.s.sc);
    sum_s0 += int(s0.s.f);
    sum_s0 += int(s0.b);

    sb_out.result = sum_s0;

    gl_Position = position;
}
#version 450
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    gl_Position = position;
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const bool sc0 = true;
layout(constant_id = 2) const bool sc1 = false;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    bool r0;
    bool r1;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const int sc0 = -3;
layout(constant_id = 2) const int sc1 = 17;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r0;
    int r1;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const uint sc0 = 42u;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint r0;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const float sc0 = 7.5;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float r0;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const double sc0 = 2.75LF;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double r0;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : require
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    gl_Position = position;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : require
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const int8_t sc0 = int8_t(1);
layout(constant_id = 2) const int8_t sc1 = int8_t(-2);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int8_t r0;
    int8_t r1;
} sb_out;



void main (void)
{
    int8_t aux = sc0 + sc1;
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : require
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const uint8_t sc0 = int8_t(15);
layout(constant_id = 2) const uint8_t sc1 = int8_t(43);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint8_t r0;
    uint8_t r1;
} sb_out;



void main (void)
{
    uint8_t aux = sc0 + sc1;
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int16 : require
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    gl_Position = position;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int16 : require
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const int16_t sc0 = 20000s;
layout(constant_id = 2) const int16_t sc1 = -20000s;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int16_t r0;
    int16_t r1;
} sb_out;



void main (void)
{
    int16_t aux = sc0 + sc1;
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int16 : require
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const uint16_t sc0 = 64000us;
layout(constant_id = 2) const uint16_t sc1 = 51829us;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint16_t r0;
    uint16_t r1;
} sb_out;



void main (void)
{
    uint16_t aux = sc0 + sc1;
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    gl_Position = position;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const int64_t sc0 = 9141386509785772560l;
layout(constant_id = 2) const int64_t sc1 = -9141386509785772560l;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int64_t r0;
    int64_t r1;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const uint64_t sc0 = 18364758544493064720ul;
layout(constant_id = 2) const uint64_t sc1 = 17298946664678735070ul;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint64_t r0;
    uint64_t r1;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    gl_Position = position;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const float16_t sc0 = 7.5hf;
layout(constant_id = 2) const float16_t sc1 = 1.125hf;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float16_t r0;
    float16_t r1;
} sb_out;



void main (void)
{
    float16_t aux = sc0 + sc1;
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const bool sc0 = true;
layout(constant_id = 2) const bool sc1 = false;
layout(constant_id = 3) const bool sc2 = true;
layout(constant_id = 4) const bool sc3 = false;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    bool r0;
    bool r1;
    bool r2;
    bool r3;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;
    sb_out.r2 = sc2;
    sb_out.r3 = sc3;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const int sc0 = -3;
layout(constant_id = 2) const int sc1 = 91;
layout(constant_id = 3) const int sc2 = 17;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r0;
    int r1;
    int r2;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;
    sb_out.r2 = sc2;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const uint sc0 = 42u;
layout(constant_id = 2) const uint sc1 = 7u;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint r0;
    uint r1;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const float sc0 = 7.5;
layout(constant_id = 2) const float sc1 = 1.125;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float r0;
    float r1;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const double sc0 = 2.75LF;
layout(constant_id = 2) const double sc1 = 9.25LF;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double r0;
    double r1;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_explicit_arithmetic_types_int16 : require
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : require
layout(location = 0) in highp vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    gl_Position = position;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_explicit_arithmetic_types_int16 : require
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : require
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const uint8_t  sc0 = uint8_t  (0);
layout(constant_id = 2) const uint16_t sc1 = uint16_t (0);
layout(constant_id = 3) const uint     sc2 = uint     (0);
layout(constant_id = 4) const uint64_t sc3 = uint64_t (0);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint64_t r0;
    uint     r1;
    uint16_t r2;
    uint8_t  r3;
} sb_out;



void main (void)
{
    uint64_t i0 = sc3;
    uint     i1 = sc2;
    uint16_t i2 = sc1;
    uint8_t  i3 = sc0;
    sb_out.r0 = i0;
    sb_out.r1 = i1;
    sb_out.r2 = i2;
    sb_out.r3 = i3;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_explicit_arithmetic_types_int16 : require
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : require
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const uint64_t sc3 = uint64_t (0);
layout(constant_id = 2) const uint     sc2 = uint     (0);
layout(constant_id = 3) const uint16_t sc1 = uint16_t (0);
layout(constant_id = 4) const uint8_t  sc0 = uint8_t  (0);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint64_t r0;
    uint     r1;
    uint16_t r2;
    uint8_t  r3;
} sb_out;



void main (void)
{
    uint64_t i0 = sc3;
    uint     i1 = sc2;
    uint16_t i2 = sc1;
    uint8_t  i3 = sc0;
    sb_out.r0 = i0;
    sb_out.r1 = i1;
    sb_out.r2 = i2;
    sb_out.r3 = i3;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : require
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const int8_t sc0 = int8_t(123);
layout(constant_id = 2) const int8_t sc1 = int8_t(-33);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int8_t r0;
    int8_t r1;
} sb_out;



void main (void)
{
    int8_t aux = sc0 + sc1;
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : require
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const uint8_t sc0 = int8_t(99);
layout(constant_id = 2) const uint8_t sc1 = int8_t(81);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint8_t r0;
    uint8_t r1;
} sb_out;



void main (void)
{
    uint8_t aux = sc0 + sc1;
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const uint sc0 = 305419896u;
layout(constant_id = 2) const uint sc1 = 591751049u;
layout(constant_id = 3) const uint sc2 = 878082202u;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint r0;
    uint r1;
    uint r2;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;
    sb_out.r2 = sc2;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const float16_t sc0 = 7.5hf;
layout(constant_id = 2) const float16_t sc1 = 1.125hf;
layout(constant_id = 3) const float16_t sc2 = 1.125hf;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float16_t r0;
    float16_t r1;
    float16_t r2;
} sb_out;



void main (void)
{
    float16_t aux = sc0 + sc1;
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;
    sb_out.r2 = sc2;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const float sc0 = 7.5;
layout(constant_id = 2) const float sc1 = 1.125;
layout(constant_id = 3) const float sc2 = 1.125;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float r0;
    float r1;
    float r2;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;
    sb_out.r2 = sc2;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;



layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r0;
} sb_out;



void main (void)
{
    sb_out.r0 = 77;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;


layout(constant_id = 1) const int sc1 = 0;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r1;
} sb_out;



void main (void)
{
    sb_out.r1 = sc1;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 7) const int sc0 = 0;

layout(constant_id = 17) const int sc1 = 0;


layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r0;
    int r1;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 7) const int sc0 = 0;


layout(constant_id = 17) const int sc1 = 0;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r0;
    int r1;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) gl_MaxImageUnits;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    bool ok;
} sb_out;



void main (void)
{
    sb_out.ok = (gl_MaxImageUnits >= 8);

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) gl_MaxImageUnits;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int maxImageUnits;
} sb_out;



void main (void)
{
    sb_out.maxImageUnits = gl_MaxImageUnits;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const int sc0 = 2;
layout(constant_id = 2) const int sc1 = 3;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result;
} sb_out;

const int expr0 = sc0 + 1;
const int expr1 = sc0 + sc1;


void main (void)
{
    sb_out.result = expr0 + expr1;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const int sc0 = 1;
layout(constant_id = 2) const int sc1 = 2;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r0;
    int r1[3];
} sb_out;



void main (void)
{
    int a0[sc0];
    int a1[sc1];

    for (int i = 0; i < sc0; ++i)
        a0[i] = sc0 - i;
    for (int i = 0; i < sc1; ++i)
        a1[i] = sc1 - i;

    sb_out.r0 = a0[0];
    for (int i = 0; i < sc1; ++i)
         sb_out.r1[i] = a1[i];

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const int sc0 = 3;
layout(constant_id = 2) const int sc1 = 5;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r0;
    int r1;
} sb_out;



void main (void)
{
    int a0[sc0 + 3];
    int a1[sc0 + sc1];

    const int size0 = sc0 + 3;
    const int size1 = sc0 + sc1;

    for (int i = 0; i < size0; ++i)
        a0[i] = 3 - i;
    for (int i = 0; i < size1; ++i)
        a1[i] = 5 - i;

    sb_out.r0 = a0[size0 - 1];
    sb_out.r1 = a1[size1 - 1];

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const int sc0 = 3;
layout(constant_id = 2) const int sc1 = 5;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r0;
    int r1;
} sb_out;



void main (void)
{
    const int size0 = sc0 + 3;
    const int size1 = sc0 + sc1;

    int a0[size0];
    int a1[size1];

    for (int i = 0; i < size0; ++i)
        a0[i] = 3 - i;
    for (int i = 0; i < size1; ++i)
        a1[i] = 5 - i;

    sb_out.r0 = a0[size0 - 1];
    sb_out.r1 = a1[size1 - 1];

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const int sc0 = 1;
layout(constant_id = 2) const int sc1 = 2;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r0;
    int r1;
} sb_out;



void main (void)
{
    int a0[sc0];
    int a1[sc1];

    sb_out.r0 = a0.length();
    sb_out.r1 = a1.length();

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const int sc0 = 3;
layout(constant_id = 2) const int sc1 = 1;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result;
} sb_out;

int sumArrays (int a0[sc0], int a1[sc1])
{
    int sum = 0;
    for (int i = 0; (i < sc0) && (i < sc1); ++i)
        sum += a0[i] + a1[i];
    return sum;
}


void main (void)
{
    int a0[sc0];
    int a1[sc1];

    for (int i = 0; i < sc0; ++i)
        a0[i] = i + 1;
    for (int i = 0; i < sc1; ++i)
        a1[i] = i + 2;

    sb_out.result = sumArrays(a0, a1);

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

mat2x3 m0 = mat2x3(sc0, 2, 3, 4, 5, 6);
mat2x3 m1 = mat2x3(1, sc0, 3, 4, 5, 6);
mat2x3 m2 = mat2x3(1, 2, sc0, 4, 5, 6);
mat2x3 m3 = mat2x3(1, 2, 3, sc0, 5, 6);
mat2x3 m4 = mat2x3(1, 2, 3, 4, sc0, 6);
mat2x3 m5 = mat2x3(1, 2, 3, 4, 5, sc0);


void main (void)
{
    float sum_m0 = float(0);
    float sum_m1 = float(0);
    float sum_m2 = float(0);
    float sum_m3 = float(0);
    float sum_m4 = float(0);
    float sum_m5 = float(0);

    for (int i = 0; i < 2; ++i)
    for (int j = 0; j < 3; ++j)
    {
        sum_m0 += float(m0[i][j]);
        sum_m1 += float(m1[i][j]);
        sum_m2 += float(m2[i][j]);
        sum_m3 += float(m3[i][j]);
        sum_m4 += float(m4[i][j]);
        sum_m5 += float(m5[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[8];
} sb_out;

mat2x4 m0 = mat2x4(sc0, 2, 3, 4, 5, 6, 7, 8);
mat2x4 m1 = mat2x4(1, sc0, 3, 4, 5, 6, 7, 8);
mat2x4 m2 = mat2x4(1, 2, sc0, 4, 5, 6, 7, 8);
mat2x4 m3 = mat2x4(1, 2, 3, sc0, 5, 6, 7, 8);
mat2x4 m4 = mat2x4(1, 2, 3, 4, sc0, 6, 7, 8);
mat2x4 m5 = mat2x4(1, 2, 3, 4, 5, sc0, 7, 8);
mat2x4 m6 = mat2x4(1, 2, 3, 4, 5, 6, sc0, 8);
mat2x4 m7 = mat2x4(1, 2, 3, 4, 5, 6, 7, sc0);


void main (void)
{
    float sum_m0 = float(0);
    float sum_m1 = float(0);
    float sum_m2 = float(0);
    float sum_m3 = float(0);
    float sum_m4 = float(0);
    float sum_m5 = float(0);
    float sum_m6 = float(0);
    float sum_m7 = float(0);

    for (int i = 0; i < 2; ++i)
    for (int j = 0; j < 4; ++j)
    {
        sum_m0 += float(m0[i][j]);
        sum_m1 += float(m1[i][j]);
        sum_m2 += float(m2[i][j]);
        sum_m3 += float(m3[i][j]);
        sum_m4 += float(m4[i][j]);
        sum_m5 += float(m5[i][j]);
        sum_m6 += float(m6[i][j]);
        sum_m7 += float(m7[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;
    sb_out.result[6] = sum_m6;
    sb_out.result[7] = sum_m7;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

mat3x2 m0 = mat3x2(sc0, 2, 3, 4, 5, 6);
mat3x2 m1 = mat3x2(1, sc0, 3, 4, 5, 6);
mat3x2 m2 = mat3x2(1, 2, sc0, 4, 5, 6);
mat3x2 m3 = mat3x2(1, 2, 3, sc0, 5, 6);
mat3x2 m4 = mat3x2(1, 2, 3, 4, sc0, 6);
mat3x2 m5 = mat3x2(1, 2, 3, 4, 5, sc0);


void main (void)
{
    float sum_m0 = float(0);
    float sum_m1 = float(0);
    float sum_m2 = float(0);
    float sum_m3 = float(0);
    float sum_m4 = float(0);
    float sum_m5 = float(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_m0 += float(m0[i][j]);
        sum_m1 += float(m1[i][j]);
        sum_m2 += float(m2[i][j]);
        sum_m3 += float(m3[i][j]);
        sum_m4 += float(m4[i][j]);
        sum_m5 += float(m5[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[12];
} sb_out;

mat3x4 m0 = mat3x4(sc0, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);
mat3x4 m1 = mat3x4(1, sc0, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);
mat3x4 m2 = mat3x4(1, 2, sc0, 4, 5, 6, 7, 8, 9, 10, 11, 12);
mat3x4 m3 = mat3x4(1, 2, 3, sc0, 5, 6, 7, 8, 9, 10, 11, 12);
mat3x4 m4 = mat3x4(1, 2, 3, 4, sc0, 6, 7, 8, 9, 10, 11, 12);
mat3x4 m5 = mat3x4(1, 2, 3, 4, 5, sc0, 7, 8, 9, 10, 11, 12);
mat3x4 m6 = mat3x4(1, 2, 3, 4, 5, 6, sc0, 8, 9, 10, 11, 12);
mat3x4 m7 = mat3x4(1, 2, 3, 4, 5, 6, 7, sc0, 9, 10, 11, 12);
mat3x4 m8 = mat3x4(1, 2, 3, 4, 5, 6, 7, 8, sc0, 10, 11, 12);
mat3x4 m9 = mat3x4(1, 2, 3, 4, 5, 6, 7, 8, 9, sc0, 11, 12);
mat3x4 m10 = mat3x4(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, sc0, 12);
mat3x4 m11 = mat3x4(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, sc0);


void main (void)
{
    float sum_m0 = float(0);
    float sum_m1 = float(0);
    float sum_m2 = float(0);
    float sum_m3 = float(0);
    float sum_m4 = float(0);
    float sum_m5 = float(0);
    float sum_m6 = float(0);
    float sum_m7 = float(0);
    float sum_m8 = float(0);
    float sum_m9 = float(0);
    float sum_m10 = float(0);
    float sum_m11 = float(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 4; ++j)
    {
        sum_m0 += float(m0[i][j]);
        sum_m1 += float(m1[i][j]);
        sum_m2 += float(m2[i][j]);
        sum_m3 += float(m3[i][j]);
        sum_m4 += float(m4[i][j]);
        sum_m5 += float(m5[i][j]);
        sum_m6 += float(m6[i][j]);
        sum_m7 += float(m7[i][j]);
        sum_m8 += float(m8[i][j]);
        sum_m9 += float(m9[i][j]);
        sum_m10 += float(m10[i][j]);
        sum_m11 += float(m11[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;
    sb_out.result[6] = sum_m6;
    sb_out.result[7] = sum_m7;
    sb_out.result[8] = sum_m8;
    sb_out.result[9] = sum_m9;
    sb_out.result[10] = sum_m10;
    sb_out.result[11] = sum_m11;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[8];
} sb_out;

mat4x2 m0 = mat4x2(sc0, 2, 3, 4, 5, 6, 7, 8);
mat4x2 m1 = mat4x2(1, sc0, 3, 4, 5, 6, 7, 8);
mat4x2 m2 = mat4x2(1, 2, sc0, 4, 5, 6, 7, 8);
mat4x2 m3 = mat4x2(1, 2, 3, sc0, 5, 6, 7, 8);
mat4x2 m4 = mat4x2(1, 2, 3, 4, sc0, 6, 7, 8);
mat4x2 m5 = mat4x2(1, 2, 3, 4, 5, sc0, 7, 8);
mat4x2 m6 = mat4x2(1, 2, 3, 4, 5, 6, sc0, 8);
mat4x2 m7 = mat4x2(1, 2, 3, 4, 5, 6, 7, sc0);


void main (void)
{
    float sum_m0 = float(0);
    float sum_m1 = float(0);
    float sum_m2 = float(0);
    float sum_m3 = float(0);
    float sum_m4 = float(0);
    float sum_m5 = float(0);
    float sum_m6 = float(0);
    float sum_m7 = float(0);

    for (int i = 0; i < 4; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_m0 += float(m0[i][j]);
        sum_m1 += float(m1[i][j]);
        sum_m2 += float(m2[i][j]);
        sum_m3 += float(m3[i][j]);
        sum_m4 += float(m4[i][j]);
        sum_m5 += float(m5[i][j]);
        sum_m6 += float(m6[i][j]);
        sum_m7 += float(m7[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;
    sb_out.result[6] = sum_m6;
    sb_out.result[7] = sum_m7;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[12];
} sb_out;

mat4x3 m0 = mat4x3(sc0, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);
mat4x3 m1 = mat4x3(1, sc0, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);
mat4x3 m2 = mat4x3(1, 2, sc0, 4, 5, 6, 7, 8, 9, 10, 11, 12);
mat4x3 m3 = mat4x3(1, 2, 3, sc0, 5, 6, 7, 8, 9, 10, 11, 12);
mat4x3 m4 = mat4x3(1, 2, 3, 4, sc0, 6, 7, 8, 9, 10, 11, 12);
mat4x3 m5 = mat4x3(1, 2, 3, 4, 5, sc0, 7, 8, 9, 10, 11, 12);
mat4x3 m6 = mat4x3(1, 2, 3, 4, 5, 6, sc0, 8, 9, 10, 11, 12);
mat4x3 m7 = mat4x3(1, 2, 3, 4, 5, 6, 7, sc0, 9, 10, 11, 12);
mat4x3 m8 = mat4x3(1, 2, 3, 4, 5, 6, 7, 8, sc0, 10, 11, 12);
mat4x3 m9 = mat4x3(1, 2, 3, 4, 5, 6, 7, 8, 9, sc0, 11, 12);
mat4x3 m10 = mat4x3(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, sc0, 12);
mat4x3 m11 = mat4x3(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, sc0);


void main (void)
{
    float sum_m0 = float(0);
    float sum_m1 = float(0);
    float sum_m2 = float(0);
    float sum_m3 = float(0);
    float sum_m4 = float(0);
    float sum_m5 = float(0);
    float sum_m6 = float(0);
    float sum_m7 = float(0);
    float sum_m8 = float(0);
    float sum_m9 = float(0);
    float sum_m10 = float(0);
    float sum_m11 = float(0);

    for (int i = 0; i < 4; ++i)
    for (int j = 0; j < 3; ++j)
    {
        sum_m0 += float(m0[i][j]);
        sum_m1 += float(m1[i][j]);
        sum_m2 += float(m2[i][j]);
        sum_m3 += float(m3[i][j]);
        sum_m4 += float(m4[i][j]);
        sum_m5 += float(m5[i][j]);
        sum_m6 += float(m6[i][j]);
        sum_m7 += float(m7[i][j]);
        sum_m8 += float(m8[i][j]);
        sum_m9 += float(m9[i][j]);
        sum_m10 += float(m10[i][j]);
        sum_m11 += float(m11[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;
    sb_out.result[6] = sum_m6;
    sb_out.result[7] = sum_m7;
    sb_out.result[8] = sum_m8;
    sb_out.result[9] = sum_m9;
    sb_out.result[10] = sum_m10;
    sb_out.result[11] = sum_m11;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

dmat2x3 m0 = dmat2x3(sc0, 2, 3, 4, 5, 6);
dmat2x3 m1 = dmat2x3(1, sc0, 3, 4, 5, 6);
dmat2x3 m2 = dmat2x3(1, 2, sc0, 4, 5, 6);
dmat2x3 m3 = dmat2x3(1, 2, 3, sc0, 5, 6);
dmat2x3 m4 = dmat2x3(1, 2, 3, 4, sc0, 6);
dmat2x3 m5 = dmat2x3(1, 2, 3, 4, 5, sc0);


void main (void)
{
    double sum_m0 = double(0);
    double sum_m1 = double(0);
    double sum_m2 = double(0);
    double sum_m3 = double(0);
    double sum_m4 = double(0);
    double sum_m5 = double(0);

    for (int i = 0; i < 2; ++i)
    for (int j = 0; j < 3; ++j)
    {
        sum_m0 += double(m0[i][j]);
        sum_m1 += double(m1[i][j]);
        sum_m2 += double(m2[i][j]);
        sum_m3 += double(m3[i][j]);
        sum_m4 += double(m4[i][j]);
        sum_m5 += double(m5[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[8];
} sb_out;

dmat2x4 m0 = dmat2x4(sc0, 2, 3, 4, 5, 6, 7, 8);
dmat2x4 m1 = dmat2x4(1, sc0, 3, 4, 5, 6, 7, 8);
dmat2x4 m2 = dmat2x4(1, 2, sc0, 4, 5, 6, 7, 8);
dmat2x4 m3 = dmat2x4(1, 2, 3, sc0, 5, 6, 7, 8);
dmat2x4 m4 = dmat2x4(1, 2, 3, 4, sc0, 6, 7, 8);
dmat2x4 m5 = dmat2x4(1, 2, 3, 4, 5, sc0, 7, 8);
dmat2x4 m6 = dmat2x4(1, 2, 3, 4, 5, 6, sc0, 8);
dmat2x4 m7 = dmat2x4(1, 2, 3, 4, 5, 6, 7, sc0);


void main (void)
{
    double sum_m0 = double(0);
    double sum_m1 = double(0);
    double sum_m2 = double(0);
    double sum_m3 = double(0);
    double sum_m4 = double(0);
    double sum_m5 = double(0);
    double sum_m6 = double(0);
    double sum_m7 = double(0);

    for (int i = 0; i < 2; ++i)
    for (int j = 0; j < 4; ++j)
    {
        sum_m0 += double(m0[i][j]);
        sum_m1 += double(m1[i][j]);
        sum_m2 += double(m2[i][j]);
        sum_m3 += double(m3[i][j]);
        sum_m4 += double(m4[i][j]);
        sum_m5 += double(m5[i][j]);
        sum_m6 += double(m6[i][j]);
        sum_m7 += double(m7[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;
    sb_out.result[6] = sum_m6;
    sb_out.result[7] = sum_m7;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

dmat3x2 m0 = dmat3x2(sc0, 2, 3, 4, 5, 6);
dmat3x2 m1 = dmat3x2(1, sc0, 3, 4, 5, 6);
dmat3x2 m2 = dmat3x2(1, 2, sc0, 4, 5, 6);
dmat3x2 m3 = dmat3x2(1, 2, 3, sc0, 5, 6);
dmat3x2 m4 = dmat3x2(1, 2, 3, 4, sc0, 6);
dmat3x2 m5 = dmat3x2(1, 2, 3, 4, 5, sc0);


void main (void)
{
    double sum_m0 = double(0);
    double sum_m1 = double(0);
    double sum_m2 = double(0);
    double sum_m3 = double(0);
    double sum_m4 = double(0);
    double sum_m5 = double(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_m0 += double(m0[i][j]);
        sum_m1 += double(m1[i][j]);
        sum_m2 += double(m2[i][j]);
        sum_m3 += double(m3[i][j]);
        sum_m4 += double(m4[i][j]);
        sum_m5 += double(m5[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[12];
} sb_out;

dmat3x4 m0 = dmat3x4(sc0, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);
dmat3x4 m1 = dmat3x4(1, sc0, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);
dmat3x4 m2 = dmat3x4(1, 2, sc0, 4, 5, 6, 7, 8, 9, 10, 11, 12);
dmat3x4 m3 = dmat3x4(1, 2, 3, sc0, 5, 6, 7, 8, 9, 10, 11, 12);
dmat3x4 m4 = dmat3x4(1, 2, 3, 4, sc0, 6, 7, 8, 9, 10, 11, 12);
dmat3x4 m5 = dmat3x4(1, 2, 3, 4, 5, sc0, 7, 8, 9, 10, 11, 12);
dmat3x4 m6 = dmat3x4(1, 2, 3, 4, 5, 6, sc0, 8, 9, 10, 11, 12);
dmat3x4 m7 = dmat3x4(1, 2, 3, 4, 5, 6, 7, sc0, 9, 10, 11, 12);
dmat3x4 m8 = dmat3x4(1, 2, 3, 4, 5, 6, 7, 8, sc0, 10, 11, 12);
dmat3x4 m9 = dmat3x4(1, 2, 3, 4, 5, 6, 7, 8, 9, sc0, 11, 12);
dmat3x4 m10 = dmat3x4(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, sc0, 12);
dmat3x4 m11 = dmat3x4(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, sc0);


void main (void)
{
    double sum_m0 = double(0);
    double sum_m1 = double(0);
    double sum_m2 = double(0);
    double sum_m3 = double(0);
    double sum_m4 = double(0);
    double sum_m5 = double(0);
    double sum_m6 = double(0);
    double sum_m7 = double(0);
    double sum_m8 = double(0);
    double sum_m9 = double(0);
    double sum_m10 = double(0);
    double sum_m11 = double(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 4; ++j)
    {
        sum_m0 += double(m0[i][j]);
        sum_m1 += double(m1[i][j]);
        sum_m2 += double(m2[i][j]);
        sum_m3 += double(m3[i][j]);
        sum_m4 += double(m4[i][j]);
        sum_m5 += double(m5[i][j]);
        sum_m6 += double(m6[i][j]);
        sum_m7 += double(m7[i][j]);
        sum_m8 += double(m8[i][j]);
        sum_m9 += double(m9[i][j]);
        sum_m10 += double(m10[i][j]);
        sum_m11 += double(m11[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;
    sb_out.result[6] = sum_m6;
    sb_out.result[7] = sum_m7;
    sb_out.result[8] = sum_m8;
    sb_out.result[9] = sum_m9;
    sb_out.result[10] = sum_m10;
    sb_out.result[11] = sum_m11;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[8];
} sb_out;

dmat4x2 m0 = dmat4x2(sc0, 2, 3, 4, 5, 6, 7, 8);
dmat4x2 m1 = dmat4x2(1, sc0, 3, 4, 5, 6, 7, 8);
dmat4x2 m2 = dmat4x2(1, 2, sc0, 4, 5, 6, 7, 8);
dmat4x2 m3 = dmat4x2(1, 2, 3, sc0, 5, 6, 7, 8);
dmat4x2 m4 = dmat4x2(1, 2, 3, 4, sc0, 6, 7, 8);
dmat4x2 m5 = dmat4x2(1, 2, 3, 4, 5, sc0, 7, 8);
dmat4x2 m6 = dmat4x2(1, 2, 3, 4, 5, 6, sc0, 8);
dmat4x2 m7 = dmat4x2(1, 2, 3, 4, 5, 6, 7, sc0);


void main (void)
{
    double sum_m0 = double(0);
    double sum_m1 = double(0);
    double sum_m2 = double(0);
    double sum_m3 = double(0);
    double sum_m4 = double(0);
    double sum_m5 = double(0);
    double sum_m6 = double(0);
    double sum_m7 = double(0);

    for (int i = 0; i < 4; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_m0 += double(m0[i][j]);
        sum_m1 += double(m1[i][j]);
        sum_m2 += double(m2[i][j]);
        sum_m3 += double(m3[i][j]);
        sum_m4 += double(m4[i][j]);
        sum_m5 += double(m5[i][j]);
        sum_m6 += double(m6[i][j]);
        sum_m7 += double(m7[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;
    sb_out.result[6] = sum_m6;
    sb_out.result[7] = sum_m7;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[12];
} sb_out;

dmat4x3 m0 = dmat4x3(sc0, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);
dmat4x3 m1 = dmat4x3(1, sc0, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);
dmat4x3 m2 = dmat4x3(1, 2, sc0, 4, 5, 6, 7, 8, 9, 10, 11, 12);
dmat4x3 m3 = dmat4x3(1, 2, 3, sc0, 5, 6, 7, 8, 9, 10, 11, 12);
dmat4x3 m4 = dmat4x3(1, 2, 3, 4, sc0, 6, 7, 8, 9, 10, 11, 12);
dmat4x3 m5 = dmat4x3(1, 2, 3, 4, 5, sc0, 7, 8, 9, 10, 11, 12);
dmat4x3 m6 = dmat4x3(1, 2, 3, 4, 5, 6, sc0, 8, 9, 10, 11, 12);
dmat4x3 m7 = dmat4x3(1, 2, 3, 4, 5, 6, 7, sc0, 9, 10, 11, 12);
dmat4x3 m8 = dmat4x3(1, 2, 3, 4, 5, 6, 7, 8, sc0, 10, 11, 12);
dmat4x3 m9 = dmat4x3(1, 2, 3, 4, 5, 6, 7, 8, 9, sc0, 11, 12);
dmat4x3 m10 = dmat4x3(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, sc0, 12);
dmat4x3 m11 = dmat4x3(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, sc0);


void main (void)
{
    double sum_m0 = double(0);
    double sum_m1 = double(0);
    double sum_m2 = double(0);
    double sum_m3 = double(0);
    double sum_m4 = double(0);
    double sum_m5 = double(0);
    double sum_m6 = double(0);
    double sum_m7 = double(0);
    double sum_m8 = double(0);
    double sum_m9 = double(0);
    double sum_m10 = double(0);
    double sum_m11 = double(0);

    for (int i = 0; i < 4; ++i)
    for (int j = 0; j < 3; ++j)
    {
        sum_m0 += double(m0[i][j]);
        sum_m1 += double(m1[i][j]);
        sum_m2 += double(m2[i][j]);
        sum_m3 += double(m3[i][j]);
        sum_m4 += double(m4[i][j]);
        sum_m5 += double(m5[i][j]);
        sum_m6 += double(m6[i][j]);
        sum_m7 += double(m7[i][j]);
        sum_m8 += double(m8[i][j]);
        sum_m9 += double(m9[i][j]);
        sum_m10 += double(m10[i][j]);
        sum_m11 += double(m11[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;
    sb_out.result[6] = sum_m6;
    sb_out.result[7] = sum_m7;
    sb_out.result[8] = sum_m8;
    sb_out.result[9] = sum_m9;
    sb_out.result[10] = sum_m10;
    sb_out.result[11] = sum_m11;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[3];
} sb_out;

float a0[3] = float[3](sc0, 2, 3);
float a1[3] = float[3](1, sc0, 3);
float a2[3] = float[3](1, 2, sc0);


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += float(a0[i]);
        sum_a1 += float(a1[i]);
        sum_a2 += float(a2[i]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[3];
} sb_out;

mat2x3 a0[3] = mat2x3[3](mat2x3(sc0), mat2x3(2), mat2x3(3));
mat2x3 a1[3] = mat2x3[3](mat2x3(1), mat2x3(sc0), mat2x3(3));
mat2x3 a2[3] = mat2x3[3](mat2x3(1), mat2x3(2), mat2x3(sc0));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += float(a0[i][0][0]);
        sum_a1 += float(a1[i][0][0]);
        sum_a2 += float(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[3];
} sb_out;

mat2x4 a0[3] = mat2x4[3](mat2x4(sc0), mat2x4(2), mat2x4(3));
mat2x4 a1[3] = mat2x4[3](mat2x4(1), mat2x4(sc0), mat2x4(3));
mat2x4 a2[3] = mat2x4[3](mat2x4(1), mat2x4(2), mat2x4(sc0));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += float(a0[i][0][0]);
        sum_a1 += float(a1[i][0][0]);
        sum_a2 += float(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[3];
} sb_out;

mat3x2 a0[3] = mat3x2[3](mat3x2(sc0), mat3x2(2), mat3x2(3));
mat3x2 a1[3] = mat3x2[3](mat3x2(1), mat3x2(sc0), mat3x2(3));
mat3x2 a2[3] = mat3x2[3](mat3x2(1), mat3x2(2), mat3x2(sc0));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += float(a0[i][0][0]);
        sum_a1 += float(a1[i][0][0]);
        sum_a2 += float(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[3];
} sb_out;

mat3x4 a0[3] = mat3x4[3](mat3x4(sc0), mat3x4(2), mat3x4(3));
mat3x4 a1[3] = mat3x4[3](mat3x4(1), mat3x4(sc0), mat3x4(3));
mat3x4 a2[3] = mat3x4[3](mat3x4(1), mat3x4(2), mat3x4(sc0));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += float(a0[i][0][0]);
        sum_a1 += float(a1[i][0][0]);
        sum_a2 += float(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[3];
} sb_out;

mat4x2 a0[3] = mat4x2[3](mat4x2(sc0), mat4x2(2), mat4x2(3));
mat4x2 a1[3] = mat4x2[3](mat4x2(1), mat4x2(sc0), mat4x2(3));
mat4x2 a2[3] = mat4x2[3](mat4x2(1), mat4x2(2), mat4x2(sc0));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += float(a0[i][0][0]);
        sum_a1 += float(a1[i][0][0]);
        sum_a2 += float(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[3];
} sb_out;

mat4x3 a0[3] = mat4x3[3](mat4x3(sc0), mat4x3(2), mat4x3(3));
mat4x3 a1[3] = mat4x3[3](mat4x3(1), mat4x3(sc0), mat4x3(3));
mat4x3 a2[3] = mat4x3[3](mat4x3(1), mat4x3(2), mat4x3(sc0));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += float(a0[i][0][0]);
        sum_a1 += float(a1[i][0][0]);
        sum_a2 += float(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[3];
} sb_out;

double a0[3] = double[3](sc0, 2, 3);
double a1[3] = double[3](1, sc0, 3);
double a2[3] = double[3](1, 2, sc0);


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += double(a0[i]);
        sum_a1 += double(a1[i]);
        sum_a2 += double(a2[i]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[3];
} sb_out;

dmat2x3 a0[3] = dmat2x3[3](dmat2x3(sc0), dmat2x3(2), dmat2x3(3));
dmat2x3 a1[3] = dmat2x3[3](dmat2x3(1), dmat2x3(sc0), dmat2x3(3));
dmat2x3 a2[3] = dmat2x3[3](dmat2x3(1), dmat2x3(2), dmat2x3(sc0));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += double(a0[i][0][0]);
        sum_a1 += double(a1[i][0][0]);
        sum_a2 += double(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[3];
} sb_out;

dmat2x4 a0[3] = dmat2x4[3](dmat2x4(sc0), dmat2x4(2), dmat2x4(3));
dmat2x4 a1[3] = dmat2x4[3](dmat2x4(1), dmat2x4(sc0), dmat2x4(3));
dmat2x4 a2[3] = dmat2x4[3](dmat2x4(1), dmat2x4(2), dmat2x4(sc0));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += double(a0[i][0][0]);
        sum_a1 += double(a1[i][0][0]);
        sum_a2 += double(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[3];
} sb_out;

dmat3x2 a0[3] = dmat3x2[3](dmat3x2(sc0), dmat3x2(2), dmat3x2(3));
dmat3x2 a1[3] = dmat3x2[3](dmat3x2(1), dmat3x2(sc0), dmat3x2(3));
dmat3x2 a2[3] = dmat3x2[3](dmat3x2(1), dmat3x2(2), dmat3x2(sc0));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += double(a0[i][0][0]);
        sum_a1 += double(a1[i][0][0]);
        sum_a2 += double(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[3];
} sb_out;

dmat3x4 a0[3] = dmat3x4[3](dmat3x4(sc0), dmat3x4(2), dmat3x4(3));
dmat3x4 a1[3] = dmat3x4[3](dmat3x4(1), dmat3x4(sc0), dmat3x4(3));
dmat3x4 a2[3] = dmat3x4[3](dmat3x4(1), dmat3x4(2), dmat3x4(sc0));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += double(a0[i][0][0]);
        sum_a1 += double(a1[i][0][0]);
        sum_a2 += double(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[3];
} sb_out;

dmat4x2 a0[3] = dmat4x2[3](dmat4x2(sc0), dmat4x2(2), dmat4x2(3));
dmat4x2 a1[3] = dmat4x2[3](dmat4x2(1), dmat4x2(sc0), dmat4x2(3));
dmat4x2 a2[3] = dmat4x2[3](dmat4x2(1), dmat4x2(2), dmat4x2(sc0));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += double(a0[i][0][0]);
        sum_a1 += double(a1[i][0][0]);
        sum_a2 += double(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[3];
} sb_out;

dmat4x3 a0[3] = dmat4x3[3](dmat4x3(sc0), dmat4x3(2), dmat4x3(3));
dmat4x3 a1[3] = dmat4x3[3](dmat4x3(1), dmat4x3(sc0), dmat4x3(3));
dmat4x3 a2[3] = dmat4x3[3](dmat4x3(1), dmat4x3(2), dmat4x3(sc0));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += double(a0[i][0][0]);
        sum_a1 += double(a1[i][0][0]);
        sum_a2 += double(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const int sc0 = int(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result[3];
} sb_out;

int a0[3] = int[3](sc0, 2, 3);
int a1[3] = int[3](1, sc0, 3);
int a2[3] = int[3](1, 2, sc0);


void main (void)
{
    int sum_a0 = int(0);
    int sum_a1 = int(0);
    int sum_a2 = int(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += int(a0[i]);
        sum_a1 += int(a1[i]);
        sum_a2 += int(a2[i]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const uint sc0 = uint(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint result[3];
} sb_out;

uint a0[3] = uint[3](sc0, 2, 3);
uint a1[3] = uint[3](1, sc0, 3);
uint a2[3] = uint[3](1, 2, sc0);


void main (void)
{
    uint sum_a0 = uint(0);
    uint sum_a1 = uint(0);
    uint sum_a2 = uint(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += uint(a0[i]);
        sum_a1 += uint(a1[i]);
        sum_a2 += uint(a2[i]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const bool sc0 = bool(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result[3];
} sb_out;

bool a0[3] = bool[3](sc0, true, true);
bool a1[3] = bool[3](true, sc0, true);
bool a2[3] = bool[3](true, true, sc0);


void main (void)
{
    int sum_a0 = int(0);
    int sum_a1 = int(0);
    int sum_a2 = int(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += int(a0[i]);
        sum_a1 += int(a1[i]);
        sum_a2 += int(a2[i]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

float a0[3][2] = float[3][2](float[2](sc0, 2),
                                    float[2](3, 4),
                                    float[2](5, 6));
float a1[3][2] = float[3][2](float[2](1, sc0),
                                    float[2](3, 4),
                                    float[2](5, 6));
float a2[3][2] = float[3][2](float[2](1, 2),
                                    float[2](sc0, 4),
                                    float[2](5, 6));
float a3[3][2] = float[3][2](float[2](1, 2),
                                    float[2](3, sc0),
                                    float[2](5, 6));
float a4[3][2] = float[3][2](float[2](1, 2),
                                    float[2](3, 4),
                                    float[2](sc0, 6));
float a5[3][2] = float[3][2](float[2](1, 2),
                                    float[2](3, 4),
                                    float[2](5, sc0));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);
    float sum_a3 = float(0);
    float sum_a4 = float(0);
    float sum_a5 = float(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += float(a0[i][j]);
        sum_a1 += float(a1[i][j]);
        sum_a2 += float(a2[i][j]);
        sum_a3 += float(a3[i][j]);
        sum_a4 += float(a4[i][j]);
        sum_a5 += float(a5[i][j]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

mat2x3 a0[3][2] = mat2x3[3][2](mat2x3[2](mat2x3(sc0), mat2x3(2)),
                                    mat2x3[2](mat2x3(3), mat2x3(4)),
                                    mat2x3[2](mat2x3(5), mat2x3(6)));
mat2x3 a1[3][2] = mat2x3[3][2](mat2x3[2](mat2x3(1), mat2x3(sc0)),
                                    mat2x3[2](mat2x3(3), mat2x3(4)),
                                    mat2x3[2](mat2x3(5), mat2x3(6)));
mat2x3 a2[3][2] = mat2x3[3][2](mat2x3[2](mat2x3(1), mat2x3(2)),
                                    mat2x3[2](mat2x3(sc0), mat2x3(4)),
                                    mat2x3[2](mat2x3(5), mat2x3(6)));
mat2x3 a3[3][2] = mat2x3[3][2](mat2x3[2](mat2x3(1), mat2x3(2)),
                                    mat2x3[2](mat2x3(3), mat2x3(sc0)),
                                    mat2x3[2](mat2x3(5), mat2x3(6)));
mat2x3 a4[3][2] = mat2x3[3][2](mat2x3[2](mat2x3(1), mat2x3(2)),
                                    mat2x3[2](mat2x3(3), mat2x3(4)),
                                    mat2x3[2](mat2x3(sc0), mat2x3(6)));
mat2x3 a5[3][2] = mat2x3[3][2](mat2x3[2](mat2x3(1), mat2x3(2)),
                                    mat2x3[2](mat2x3(3), mat2x3(4)),
                                    mat2x3[2](mat2x3(5), mat2x3(sc0)));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);
    float sum_a3 = float(0);
    float sum_a4 = float(0);
    float sum_a5 = float(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += float(a0[i][j][0][0]);
        sum_a1 += float(a1[i][j][0][0]);
        sum_a2 += float(a2[i][j][0][0]);
        sum_a3 += float(a3[i][j][0][0]);
        sum_a4 += float(a4[i][j][0][0]);
        sum_a5 += float(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

mat2x4 a0[3][2] = mat2x4[3][2](mat2x4[2](mat2x4(sc0), mat2x4(2)),
                                    mat2x4[2](mat2x4(3), mat2x4(4)),
                                    mat2x4[2](mat2x4(5), mat2x4(6)));
mat2x4 a1[3][2] = mat2x4[3][2](mat2x4[2](mat2x4(1), mat2x4(sc0)),
                                    mat2x4[2](mat2x4(3), mat2x4(4)),
                                    mat2x4[2](mat2x4(5), mat2x4(6)));
mat2x4 a2[3][2] = mat2x4[3][2](mat2x4[2](mat2x4(1), mat2x4(2)),
                                    mat2x4[2](mat2x4(sc0), mat2x4(4)),
                                    mat2x4[2](mat2x4(5), mat2x4(6)));
mat2x4 a3[3][2] = mat2x4[3][2](mat2x4[2](mat2x4(1), mat2x4(2)),
                                    mat2x4[2](mat2x4(3), mat2x4(sc0)),
                                    mat2x4[2](mat2x4(5), mat2x4(6)));
mat2x4 a4[3][2] = mat2x4[3][2](mat2x4[2](mat2x4(1), mat2x4(2)),
                                    mat2x4[2](mat2x4(3), mat2x4(4)),
                                    mat2x4[2](mat2x4(sc0), mat2x4(6)));
mat2x4 a5[3][2] = mat2x4[3][2](mat2x4[2](mat2x4(1), mat2x4(2)),
                                    mat2x4[2](mat2x4(3), mat2x4(4)),
                                    mat2x4[2](mat2x4(5), mat2x4(sc0)));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);
    float sum_a3 = float(0);
    float sum_a4 = float(0);
    float sum_a5 = float(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += float(a0[i][j][0][0]);
        sum_a1 += float(a1[i][j][0][0]);
        sum_a2 += float(a2[i][j][0][0]);
        sum_a3 += float(a3[i][j][0][0]);
        sum_a4 += float(a4[i][j][0][0]);
        sum_a5 += float(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

mat3x2 a0[3][2] = mat3x2[3][2](mat3x2[2](mat3x2(sc0), mat3x2(2)),
                                    mat3x2[2](mat3x2(3), mat3x2(4)),
                                    mat3x2[2](mat3x2(5), mat3x2(6)));
mat3x2 a1[3][2] = mat3x2[3][2](mat3x2[2](mat3x2(1), mat3x2(sc0)),
                                    mat3x2[2](mat3x2(3), mat3x2(4)),
                                    mat3x2[2](mat3x2(5), mat3x2(6)));
mat3x2 a2[3][2] = mat3x2[3][2](mat3x2[2](mat3x2(1), mat3x2(2)),
                                    mat3x2[2](mat3x2(sc0), mat3x2(4)),
                                    mat3x2[2](mat3x2(5), mat3x2(6)));
mat3x2 a3[3][2] = mat3x2[3][2](mat3x2[2](mat3x2(1), mat3x2(2)),
                                    mat3x2[2](mat3x2(3), mat3x2(sc0)),
                                    mat3x2[2](mat3x2(5), mat3x2(6)));
mat3x2 a4[3][2] = mat3x2[3][2](mat3x2[2](mat3x2(1), mat3x2(2)),
                                    mat3x2[2](mat3x2(3), mat3x2(4)),
                                    mat3x2[2](mat3x2(sc0), mat3x2(6)));
mat3x2 a5[3][2] = mat3x2[3][2](mat3x2[2](mat3x2(1), mat3x2(2)),
                                    mat3x2[2](mat3x2(3), mat3x2(4)),
                                    mat3x2[2](mat3x2(5), mat3x2(sc0)));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);
    float sum_a3 = float(0);
    float sum_a4 = float(0);
    float sum_a5 = float(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += float(a0[i][j][0][0]);
        sum_a1 += float(a1[i][j][0][0]);
        sum_a2 += float(a2[i][j][0][0]);
        sum_a3 += float(a3[i][j][0][0]);
        sum_a4 += float(a4[i][j][0][0]);
        sum_a5 += float(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

mat3x4 a0[3][2] = mat3x4[3][2](mat3x4[2](mat3x4(sc0), mat3x4(2)),
                                    mat3x4[2](mat3x4(3), mat3x4(4)),
                                    mat3x4[2](mat3x4(5), mat3x4(6)));
mat3x4 a1[3][2] = mat3x4[3][2](mat3x4[2](mat3x4(1), mat3x4(sc0)),
                                    mat3x4[2](mat3x4(3), mat3x4(4)),
                                    mat3x4[2](mat3x4(5), mat3x4(6)));
mat3x4 a2[3][2] = mat3x4[3][2](mat3x4[2](mat3x4(1), mat3x4(2)),
                                    mat3x4[2](mat3x4(sc0), mat3x4(4)),
                                    mat3x4[2](mat3x4(5), mat3x4(6)));
mat3x4 a3[3][2] = mat3x4[3][2](mat3x4[2](mat3x4(1), mat3x4(2)),
                                    mat3x4[2](mat3x4(3), mat3x4(sc0)),
                                    mat3x4[2](mat3x4(5), mat3x4(6)));
mat3x4 a4[3][2] = mat3x4[3][2](mat3x4[2](mat3x4(1), mat3x4(2)),
                                    mat3x4[2](mat3x4(3), mat3x4(4)),
                                    mat3x4[2](mat3x4(sc0), mat3x4(6)));
mat3x4 a5[3][2] = mat3x4[3][2](mat3x4[2](mat3x4(1), mat3x4(2)),
                                    mat3x4[2](mat3x4(3), mat3x4(4)),
                                    mat3x4[2](mat3x4(5), mat3x4(sc0)));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);
    float sum_a3 = float(0);
    float sum_a4 = float(0);
    float sum_a5 = float(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += float(a0[i][j][0][0]);
        sum_a1 += float(a1[i][j][0][0]);
        sum_a2 += float(a2[i][j][0][0]);
        sum_a3 += float(a3[i][j][0][0]);
        sum_a4 += float(a4[i][j][0][0]);
        sum_a5 += float(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

mat4x2 a0[3][2] = mat4x2[3][2](mat4x2[2](mat4x2(sc0), mat4x2(2)),
                                    mat4x2[2](mat4x2(3), mat4x2(4)),
                                    mat4x2[2](mat4x2(5), mat4x2(6)));
mat4x2 a1[3][2] = mat4x2[3][2](mat4x2[2](mat4x2(1), mat4x2(sc0)),
                                    mat4x2[2](mat4x2(3), mat4x2(4)),
                                    mat4x2[2](mat4x2(5), mat4x2(6)));
mat4x2 a2[3][2] = mat4x2[3][2](mat4x2[2](mat4x2(1), mat4x2(2)),
                                    mat4x2[2](mat4x2(sc0), mat4x2(4)),
                                    mat4x2[2](mat4x2(5), mat4x2(6)));
mat4x2 a3[3][2] = mat4x2[3][2](mat4x2[2](mat4x2(1), mat4x2(2)),
                                    mat4x2[2](mat4x2(3), mat4x2(sc0)),
                                    mat4x2[2](mat4x2(5), mat4x2(6)));
mat4x2 a4[3][2] = mat4x2[3][2](mat4x2[2](mat4x2(1), mat4x2(2)),
                                    mat4x2[2](mat4x2(3), mat4x2(4)),
                                    mat4x2[2](mat4x2(sc0), mat4x2(6)));
mat4x2 a5[3][2] = mat4x2[3][2](mat4x2[2](mat4x2(1), mat4x2(2)),
                                    mat4x2[2](mat4x2(3), mat4x2(4)),
                                    mat4x2[2](mat4x2(5), mat4x2(sc0)));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);
    float sum_a3 = float(0);
    float sum_a4 = float(0);
    float sum_a5 = float(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += float(a0[i][j][0][0]);
        sum_a1 += float(a1[i][j][0][0]);
        sum_a2 += float(a2[i][j][0][0]);
        sum_a3 += float(a3[i][j][0][0]);
        sum_a4 += float(a4[i][j][0][0]);
        sum_a5 += float(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

mat4x3 a0[3][2] = mat4x3[3][2](mat4x3[2](mat4x3(sc0), mat4x3(2)),
                                    mat4x3[2](mat4x3(3), mat4x3(4)),
                                    mat4x3[2](mat4x3(5), mat4x3(6)));
mat4x3 a1[3][2] = mat4x3[3][2](mat4x3[2](mat4x3(1), mat4x3(sc0)),
                                    mat4x3[2](mat4x3(3), mat4x3(4)),
                                    mat4x3[2](mat4x3(5), mat4x3(6)));
mat4x3 a2[3][2] = mat4x3[3][2](mat4x3[2](mat4x3(1), mat4x3(2)),
                                    mat4x3[2](mat4x3(sc0), mat4x3(4)),
                                    mat4x3[2](mat4x3(5), mat4x3(6)));
mat4x3 a3[3][2] = mat4x3[3][2](mat4x3[2](mat4x3(1), mat4x3(2)),
                                    mat4x3[2](mat4x3(3), mat4x3(sc0)),
                                    mat4x3[2](mat4x3(5), mat4x3(6)));
mat4x3 a4[3][2] = mat4x3[3][2](mat4x3[2](mat4x3(1), mat4x3(2)),
                                    mat4x3[2](mat4x3(3), mat4x3(4)),
                                    mat4x3[2](mat4x3(sc0), mat4x3(6)));
mat4x3 a5[3][2] = mat4x3[3][2](mat4x3[2](mat4x3(1), mat4x3(2)),
                                    mat4x3[2](mat4x3(3), mat4x3(4)),
                                    mat4x3[2](mat4x3(5), mat4x3(sc0)));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);
    float sum_a3 = float(0);
    float sum_a4 = float(0);
    float sum_a5 = float(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += float(a0[i][j][0][0]);
        sum_a1 += float(a1[i][j][0][0]);
        sum_a2 += float(a2[i][j][0][0]);
        sum_a3 += float(a3[i][j][0][0]);
        sum_a4 += float(a4[i][j][0][0]);
        sum_a5 += float(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

double a0[3][2] = double[3][2](double[2](sc0, 2),
                                    double[2](3, 4),
                                    double[2](5, 6));
double a1[3][2] = double[3][2](double[2](1, sc0),
                                    double[2](3, 4),
                                    double[2](5, 6));
double a2[3][2] = double[3][2](double[2](1, 2),
                                    double[2](sc0, 4),
                                    double[2](5, 6));
double a3[3][2] = double[3][2](double[2](1, 2),
                                    double[2](3, sc0),
                                    double[2](5, 6));
double a4[3][2] = double[3][2](double[2](1, 2),
                                    double[2](3, 4),
                                    double[2](sc0, 6));
double a5[3][2] = double[3][2](double[2](1, 2),
                                    double[2](3, 4),
                                    double[2](5, sc0));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);
    double sum_a3 = double(0);
    double sum_a4 = double(0);
    double sum_a5 = double(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += double(a0[i][j]);
        sum_a1 += double(a1[i][j]);
        sum_a2 += double(a2[i][j]);
        sum_a3 += double(a3[i][j]);
        sum_a4 += double(a4[i][j]);
        sum_a5 += double(a5[i][j]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

dmat2x3 a0[3][2] = dmat2x3[3][2](dmat2x3[2](dmat2x3(sc0), dmat2x3(2)),
                                    dmat2x3[2](dmat2x3(3), dmat2x3(4)),
                                    dmat2x3[2](dmat2x3(5), dmat2x3(6)));
dmat2x3 a1[3][2] = dmat2x3[3][2](dmat2x3[2](dmat2x3(1), dmat2x3(sc0)),
                                    dmat2x3[2](dmat2x3(3), dmat2x3(4)),
                                    dmat2x3[2](dmat2x3(5), dmat2x3(6)));
dmat2x3 a2[3][2] = dmat2x3[3][2](dmat2x3[2](dmat2x3(1), dmat2x3(2)),
                                    dmat2x3[2](dmat2x3(sc0), dmat2x3(4)),
                                    dmat2x3[2](dmat2x3(5), dmat2x3(6)));
dmat2x3 a3[3][2] = dmat2x3[3][2](dmat2x3[2](dmat2x3(1), dmat2x3(2)),
                                    dmat2x3[2](dmat2x3(3), dmat2x3(sc0)),
                                    dmat2x3[2](dmat2x3(5), dmat2x3(6)));
dmat2x3 a4[3][2] = dmat2x3[3][2](dmat2x3[2](dmat2x3(1), dmat2x3(2)),
                                    dmat2x3[2](dmat2x3(3), dmat2x3(4)),
                                    dmat2x3[2](dmat2x3(sc0), dmat2x3(6)));
dmat2x3 a5[3][2] = dmat2x3[3][2](dmat2x3[2](dmat2x3(1), dmat2x3(2)),
                                    dmat2x3[2](dmat2x3(3), dmat2x3(4)),
                                    dmat2x3[2](dmat2x3(5), dmat2x3(sc0)));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);
    double sum_a3 = double(0);
    double sum_a4 = double(0);
    double sum_a5 = double(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += double(a0[i][j][0][0]);
        sum_a1 += double(a1[i][j][0][0]);
        sum_a2 += double(a2[i][j][0][0]);
        sum_a3 += double(a3[i][j][0][0]);
        sum_a4 += double(a4[i][j][0][0]);
        sum_a5 += double(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

dmat2x4 a0[3][2] = dmat2x4[3][2](dmat2x4[2](dmat2x4(sc0), dmat2x4(2)),
                                    dmat2x4[2](dmat2x4(3), dmat2x4(4)),
                                    dmat2x4[2](dmat2x4(5), dmat2x4(6)));
dmat2x4 a1[3][2] = dmat2x4[3][2](dmat2x4[2](dmat2x4(1), dmat2x4(sc0)),
                                    dmat2x4[2](dmat2x4(3), dmat2x4(4)),
                                    dmat2x4[2](dmat2x4(5), dmat2x4(6)));
dmat2x4 a2[3][2] = dmat2x4[3][2](dmat2x4[2](dmat2x4(1), dmat2x4(2)),
                                    dmat2x4[2](dmat2x4(sc0), dmat2x4(4)),
                                    dmat2x4[2](dmat2x4(5), dmat2x4(6)));
dmat2x4 a3[3][2] = dmat2x4[3][2](dmat2x4[2](dmat2x4(1), dmat2x4(2)),
                                    dmat2x4[2](dmat2x4(3), dmat2x4(sc0)),
                                    dmat2x4[2](dmat2x4(5), dmat2x4(6)));
dmat2x4 a4[3][2] = dmat2x4[3][2](dmat2x4[2](dmat2x4(1), dmat2x4(2)),
                                    dmat2x4[2](dmat2x4(3), dmat2x4(4)),
                                    dmat2x4[2](dmat2x4(sc0), dmat2x4(6)));
dmat2x4 a5[3][2] = dmat2x4[3][2](dmat2x4[2](dmat2x4(1), dmat2x4(2)),
                                    dmat2x4[2](dmat2x4(3), dmat2x4(4)),
                                    dmat2x4[2](dmat2x4(5), dmat2x4(sc0)));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);
    double sum_a3 = double(0);
    double sum_a4 = double(0);
    double sum_a5 = double(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += double(a0[i][j][0][0]);
        sum_a1 += double(a1[i][j][0][0]);
        sum_a2 += double(a2[i][j][0][0]);
        sum_a3 += double(a3[i][j][0][0]);
        sum_a4 += double(a4[i][j][0][0]);
        sum_a5 += double(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

dmat3x2 a0[3][2] = dmat3x2[3][2](dmat3x2[2](dmat3x2(sc0), dmat3x2(2)),
                                    dmat3x2[2](dmat3x2(3), dmat3x2(4)),
                                    dmat3x2[2](dmat3x2(5), dmat3x2(6)));
dmat3x2 a1[3][2] = dmat3x2[3][2](dmat3x2[2](dmat3x2(1), dmat3x2(sc0)),
                                    dmat3x2[2](dmat3x2(3), dmat3x2(4)),
                                    dmat3x2[2](dmat3x2(5), dmat3x2(6)));
dmat3x2 a2[3][2] = dmat3x2[3][2](dmat3x2[2](dmat3x2(1), dmat3x2(2)),
                                    dmat3x2[2](dmat3x2(sc0), dmat3x2(4)),
                                    dmat3x2[2](dmat3x2(5), dmat3x2(6)));
dmat3x2 a3[3][2] = dmat3x2[3][2](dmat3x2[2](dmat3x2(1), dmat3x2(2)),
                                    dmat3x2[2](dmat3x2(3), dmat3x2(sc0)),
                                    dmat3x2[2](dmat3x2(5), dmat3x2(6)));
dmat3x2 a4[3][2] = dmat3x2[3][2](dmat3x2[2](dmat3x2(1), dmat3x2(2)),
                                    dmat3x2[2](dmat3x2(3), dmat3x2(4)),
                                    dmat3x2[2](dmat3x2(sc0), dmat3x2(6)));
dmat3x2 a5[3][2] = dmat3x2[3][2](dmat3x2[2](dmat3x2(1), dmat3x2(2)),
                                    dmat3x2[2](dmat3x2(3), dmat3x2(4)),
                                    dmat3x2[2](dmat3x2(5), dmat3x2(sc0)));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);
    double sum_a3 = double(0);
    double sum_a4 = double(0);
    double sum_a5 = double(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += double(a0[i][j][0][0]);
        sum_a1 += double(a1[i][j][0][0]);
        sum_a2 += double(a2[i][j][0][0]);
        sum_a3 += double(a3[i][j][0][0]);
        sum_a4 += double(a4[i][j][0][0]);
        sum_a5 += double(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

dmat3x4 a0[3][2] = dmat3x4[3][2](dmat3x4[2](dmat3x4(sc0), dmat3x4(2)),
                                    dmat3x4[2](dmat3x4(3), dmat3x4(4)),
                                    dmat3x4[2](dmat3x4(5), dmat3x4(6)));
dmat3x4 a1[3][2] = dmat3x4[3][2](dmat3x4[2](dmat3x4(1), dmat3x4(sc0)),
                                    dmat3x4[2](dmat3x4(3), dmat3x4(4)),
                                    dmat3x4[2](dmat3x4(5), dmat3x4(6)));
dmat3x4 a2[3][2] = dmat3x4[3][2](dmat3x4[2](dmat3x4(1), dmat3x4(2)),
                                    dmat3x4[2](dmat3x4(sc0), dmat3x4(4)),
                                    dmat3x4[2](dmat3x4(5), dmat3x4(6)));
dmat3x4 a3[3][2] = dmat3x4[3][2](dmat3x4[2](dmat3x4(1), dmat3x4(2)),
                                    dmat3x4[2](dmat3x4(3), dmat3x4(sc0)),
                                    dmat3x4[2](dmat3x4(5), dmat3x4(6)));
dmat3x4 a4[3][2] = dmat3x4[3][2](dmat3x4[2](dmat3x4(1), dmat3x4(2)),
                                    dmat3x4[2](dmat3x4(3), dmat3x4(4)),
                                    dmat3x4[2](dmat3x4(sc0), dmat3x4(6)));
dmat3x4 a5[3][2] = dmat3x4[3][2](dmat3x4[2](dmat3x4(1), dmat3x4(2)),
                                    dmat3x4[2](dmat3x4(3), dmat3x4(4)),
                                    dmat3x4[2](dmat3x4(5), dmat3x4(sc0)));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);
    double sum_a3 = double(0);
    double sum_a4 = double(0);
    double sum_a5 = double(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += double(a0[i][j][0][0]);
        sum_a1 += double(a1[i][j][0][0]);
        sum_a2 += double(a2[i][j][0][0]);
        sum_a3 += double(a3[i][j][0][0]);
        sum_a4 += double(a4[i][j][0][0]);
        sum_a5 += double(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

dmat4x2 a0[3][2] = dmat4x2[3][2](dmat4x2[2](dmat4x2(sc0), dmat4x2(2)),
                                    dmat4x2[2](dmat4x2(3), dmat4x2(4)),
                                    dmat4x2[2](dmat4x2(5), dmat4x2(6)));
dmat4x2 a1[3][2] = dmat4x2[3][2](dmat4x2[2](dmat4x2(1), dmat4x2(sc0)),
                                    dmat4x2[2](dmat4x2(3), dmat4x2(4)),
                                    dmat4x2[2](dmat4x2(5), dmat4x2(6)));
dmat4x2 a2[3][2] = dmat4x2[3][2](dmat4x2[2](dmat4x2(1), dmat4x2(2)),
                                    dmat4x2[2](dmat4x2(sc0), dmat4x2(4)),
                                    dmat4x2[2](dmat4x2(5), dmat4x2(6)));
dmat4x2 a3[3][2] = dmat4x2[3][2](dmat4x2[2](dmat4x2(1), dmat4x2(2)),
                                    dmat4x2[2](dmat4x2(3), dmat4x2(sc0)),
                                    dmat4x2[2](dmat4x2(5), dmat4x2(6)));
dmat4x2 a4[3][2] = dmat4x2[3][2](dmat4x2[2](dmat4x2(1), dmat4x2(2)),
                                    dmat4x2[2](dmat4x2(3), dmat4x2(4)),
                                    dmat4x2[2](dmat4x2(sc0), dmat4x2(6)));
dmat4x2 a5[3][2] = dmat4x2[3][2](dmat4x2[2](dmat4x2(1), dmat4x2(2)),
                                    dmat4x2[2](dmat4x2(3), dmat4x2(4)),
                                    dmat4x2[2](dmat4x2(5), dmat4x2(sc0)));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);
    double sum_a3 = double(0);
    double sum_a4 = double(0);
    double sum_a5 = double(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += double(a0[i][j][0][0]);
        sum_a1 += double(a1[i][j][0][0]);
        sum_a2 += double(a2[i][j][0][0]);
        sum_a3 += double(a3[i][j][0][0]);
        sum_a4 += double(a4[i][j][0][0]);
        sum_a5 += double(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

dmat4x3 a0[3][2] = dmat4x3[3][2](dmat4x3[2](dmat4x3(sc0), dmat4x3(2)),
                                    dmat4x3[2](dmat4x3(3), dmat4x3(4)),
                                    dmat4x3[2](dmat4x3(5), dmat4x3(6)));
dmat4x3 a1[3][2] = dmat4x3[3][2](dmat4x3[2](dmat4x3(1), dmat4x3(sc0)),
                                    dmat4x3[2](dmat4x3(3), dmat4x3(4)),
                                    dmat4x3[2](dmat4x3(5), dmat4x3(6)));
dmat4x3 a2[3][2] = dmat4x3[3][2](dmat4x3[2](dmat4x3(1), dmat4x3(2)),
                                    dmat4x3[2](dmat4x3(sc0), dmat4x3(4)),
                                    dmat4x3[2](dmat4x3(5), dmat4x3(6)));
dmat4x3 a3[3][2] = dmat4x3[3][2](dmat4x3[2](dmat4x3(1), dmat4x3(2)),
                                    dmat4x3[2](dmat4x3(3), dmat4x3(sc0)),
                                    dmat4x3[2](dmat4x3(5), dmat4x3(6)));
dmat4x3 a4[3][2] = dmat4x3[3][2](dmat4x3[2](dmat4x3(1), dmat4x3(2)),
                                    dmat4x3[2](dmat4x3(3), dmat4x3(4)),
                                    dmat4x3[2](dmat4x3(sc0), dmat4x3(6)));
dmat4x3 a5[3][2] = dmat4x3[3][2](dmat4x3[2](dmat4x3(1), dmat4x3(2)),
                                    dmat4x3[2](dmat4x3(3), dmat4x3(4)),
                                    dmat4x3[2](dmat4x3(5), dmat4x3(sc0)));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);
    double sum_a3 = double(0);
    double sum_a4 = double(0);
    double sum_a5 = double(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += double(a0[i][j][0][0]);
        sum_a1 += double(a1[i][j][0][0]);
        sum_a2 += double(a2[i][j][0][0]);
        sum_a3 += double(a3[i][j][0][0]);
        sum_a4 += double(a4[i][j][0][0]);
        sum_a5 += double(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const int sc0 = int(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result[6];
} sb_out;

int a0[3][2] = int[3][2](int[2](sc0, 2),
                                    int[2](3, 4),
                                    int[2](5, 6));
int a1[3][2] = int[3][2](int[2](1, sc0),
                                    int[2](3, 4),
                                    int[2](5, 6));
int a2[3][2] = int[3][2](int[2](1, 2),
                                    int[2](sc0, 4),
                                    int[2](5, 6));
int a3[3][2] = int[3][2](int[2](1, 2),
                                    int[2](3, sc0),
                                    int[2](5, 6));
int a4[3][2] = int[3][2](int[2](1, 2),
                                    int[2](3, 4),
                                    int[2](sc0, 6));
int a5[3][2] = int[3][2](int[2](1, 2),
                                    int[2](3, 4),
                                    int[2](5, sc0));


void main (void)
{
    int sum_a0 = int(0);
    int sum_a1 = int(0);
    int sum_a2 = int(0);
    int sum_a3 = int(0);
    int sum_a4 = int(0);
    int sum_a5 = int(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += int(a0[i][j]);
        sum_a1 += int(a1[i][j]);
        sum_a2 += int(a2[i][j]);
        sum_a3 += int(a3[i][j]);
        sum_a4 += int(a4[i][j]);
        sum_a5 += int(a5[i][j]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const uint sc0 = uint(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint result[6];
} sb_out;

uint a0[3][2] = uint[3][2](uint[2](sc0, 2),
                                    uint[2](3, 4),
                                    uint[2](5, 6));
uint a1[3][2] = uint[3][2](uint[2](1, sc0),
                                    uint[2](3, 4),
                                    uint[2](5, 6));
uint a2[3][2] = uint[3][2](uint[2](1, 2),
                                    uint[2](sc0, 4),
                                    uint[2](5, 6));
uint a3[3][2] = uint[3][2](uint[2](1, 2),
                                    uint[2](3, sc0),
                                    uint[2](5, 6));
uint a4[3][2] = uint[3][2](uint[2](1, 2),
                                    uint[2](3, 4),
                                    uint[2](sc0, 6));
uint a5[3][2] = uint[3][2](uint[2](1, 2),
                                    uint[2](3, 4),
                                    uint[2](5, sc0));


void main (void)
{
    uint sum_a0 = uint(0);
    uint sum_a1 = uint(0);
    uint sum_a2 = uint(0);
    uint sum_a3 = uint(0);
    uint sum_a4 = uint(0);
    uint sum_a5 = uint(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += uint(a0[i][j]);
        sum_a1 += uint(a1[i][j]);
        sum_a2 += uint(a2[i][j]);
        sum_a3 += uint(a3[i][j]);
        sum_a4 += uint(a4[i][j]);
        sum_a5 += uint(a5[i][j]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const bool sc0 = bool(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result[6];
} sb_out;

bool a0[3][2] = bool[3][2](bool[2](sc0, true),
                                    bool[2](true, true),
                                    bool[2](true, true));
bool a1[3][2] = bool[3][2](bool[2](true, sc0),
                                    bool[2](true, true),
                                    bool[2](true, true));
bool a2[3][2] = bool[3][2](bool[2](true, true),
                                    bool[2](sc0, true),
                                    bool[2](true, true));
bool a3[3][2] = bool[3][2](bool[2](true, true),
                                    bool[2](true, sc0),
                                    bool[2](true, true));
bool a4[3][2] = bool[3][2](bool[2](true, true),
                                    bool[2](true, true),
                                    bool[2](sc0, true));
bool a5[3][2] = bool[3][2](bool[2](true, true),
                                    bool[2](true, true),
                                    bool[2](true, sc0));


void main (void)
{
    int sum_a0 = int(0);
    int sum_a1 = int(0);
    int sum_a2 = int(0);
    int sum_a3 = int(0);
    int sum_a4 = int(0);
    int sum_a5 = int(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += int(a0[i][j]);
        sum_a1 += int(a1[i][j]);
        sum_a2 += int(a2[i][j]);
        sum_a3 += int(a3[i][j]);
        sum_a4 += int(a4[i][j]);
        sum_a5 += int(a5[i][j]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const int   sc0 = 1;
layout(constant_id = 2) const float sc1 = 1.0;
layout(constant_id = 3) const bool  sc2 = true;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result;
} sb_out;

struct Data {
    int   x;
    float y;
    bool  z;
};

Data a0[3] = Data[3](Data(sc0, 2.0, true), Data(1, sc1, true), Data(1, 2.0, sc2));


void main (void)
{
    int sum_a0 = 0;

    for (int i = 0; i < 3; ++i)
        sum_a0 += int(a0[i].x) + int(a0[i].y) + int(a0[i].z);

    sb_out.result = sum_a0;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    float sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, float(sc0), 8u);


void main (void)
{
    float sum_s0 = float(0);

    sum_s0 += float(s0.i);
    sum_s0 += float(s0.f);
    sum_s0 += float(s0.b);
    sum_s0 += float(s0.sc);
    sum_s0 += float(s0.ui);

    sb_out.result = sum_s0;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    mat2x3 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, mat2x3(sc0), 8u);


void main (void)
{
    float sum_s0 = float(0);

    sum_s0 += float(s0.i);
    sum_s0 += float(s0.f);
    sum_s0 += float(s0.b);
    sum_s0 += float(s0.sc[0][0]);
    sum_s0 += float(s0.ui);

    sb_out.result = sum_s0;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    mat2x4 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, mat2x4(sc0), 8u);


void main (void)
{
    float sum_s0 = float(0);

    sum_s0 += float(s0.i);
    sum_s0 += float(s0.f);
    sum_s0 += float(s0.b);
    sum_s0 += float(s0.sc[0][0]);
    sum_s0 += float(s0.ui);

    sb_out.result = sum_s0;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    mat3x2 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, mat3x2(sc0), 8u);


void main (void)
{
    float sum_s0 = float(0);

    sum_s0 += float(s0.i);
    sum_s0 += float(s0.f);
    sum_s0 += float(s0.b);
    sum_s0 += float(s0.sc[0][0]);
    sum_s0 += float(s0.ui);

    sb_out.result = sum_s0;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    mat3x4 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, mat3x4(sc0), 8u);


void main (void)
{
    float sum_s0 = float(0);

    sum_s0 += float(s0.i);
    sum_s0 += float(s0.f);
    sum_s0 += float(s0.b);
    sum_s0 += float(s0.sc[0][0]);
    sum_s0 += float(s0.ui);

    sb_out.result = sum_s0;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    mat4x2 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, mat4x2(sc0), 8u);


void main (void)
{
    float sum_s0 = float(0);

    sum_s0 += float(s0.i);
    sum_s0 += float(s0.f);
    sum_s0 += float(s0.b);
    sum_s0 += float(s0.sc[0][0]);
    sum_s0 += float(s0.ui);

    sb_out.result = sum_s0;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    mat4x3 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, mat4x3(sc0), 8u);


void main (void)
{
    float sum_s0 = float(0);

    sum_s0 += float(s0.i);
    sum_s0 += float(s0.f);
    sum_s0 += float(s0.b);
    sum_s0 += float(s0.sc[0][0]);
    sum_s0 += float(s0.ui);

    sb_out.result = sum_s0;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    double sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, double(sc0), 8u);


void main (void)
{
    double sum_s0 = double(0);

    sum_s0 += double(s0.i);
    sum_s0 += double(s0.f);
    sum_s0 += double(s0.b);
    sum_s0 += double(s0.sc);
    sum_s0 += double(s0.ui);

    sb_out.result = sum_s0;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    dmat2x3 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, dmat2x3(sc0), 8u);


void main (void)
{
    double sum_s0 = double(0);

    sum_s0 += double(s0.i);
    sum_s0 += double(s0.f);
    sum_s0 += double(s0.b);
    sum_s0 += double(s0.sc[0][0]);
    sum_s0 += double(s0.ui);

    sb_out.result = sum_s0;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    dmat2x4 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, dmat2x4(sc0), 8u);


void main (void)
{
    double sum_s0 = double(0);

    sum_s0 += double(s0.i);
    sum_s0 += double(s0.f);
    sum_s0 += double(s0.b);
    sum_s0 += double(s0.sc[0][0]);
    sum_s0 += double(s0.ui);

    sb_out.result = sum_s0;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    dmat3x2 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, dmat3x2(sc0), 8u);


void main (void)
{
    double sum_s0 = double(0);

    sum_s0 += double(s0.i);
    sum_s0 += double(s0.f);
    sum_s0 += double(s0.b);
    sum_s0 += double(s0.sc[0][0]);
    sum_s0 += double(s0.ui);

    sb_out.result = sum_s0;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    dmat3x4 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, dmat3x4(sc0), 8u);


void main (void)
{
    double sum_s0 = double(0);

    sum_s0 += double(s0.i);
    sum_s0 += double(s0.f);
    sum_s0 += double(s0.b);
    sum_s0 += double(s0.sc[0][0]);
    sum_s0 += double(s0.ui);

    sb_out.result = sum_s0;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    dmat4x2 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, dmat4x2(sc0), 8u);


void main (void)
{
    double sum_s0 = double(0);

    sum_s0 += double(s0.i);
    sum_s0 += double(s0.f);
    sum_s0 += double(s0.b);
    sum_s0 += double(s0.sc[0][0]);
    sum_s0 += double(s0.ui);

    sb_out.result = sum_s0;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    dmat4x3 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, dmat4x3(sc0), 8u);


void main (void)
{
    double sum_s0 = double(0);

    sum_s0 += double(s0.i);
    sum_s0 += double(s0.f);
    sum_s0 += double(s0.b);
    sum_s0 += double(s0.sc[0][0]);
    sum_s0 += double(s0.ui);

    sb_out.result = sum_s0;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const int sc0 = int(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    int sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, int(sc0), 8u);


void main (void)
{
    int sum_s0 = int(0);

    sum_s0 += int(s0.i);
    sum_s0 += int(s0.f);
    sum_s0 += int(s0.b);
    sum_s0 += int(s0.sc);
    sum_s0 += int(s0.ui);

    sb_out.result = sum_s0;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const uint sc0 = uint(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    uint sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, uint(sc0), 8u);


void main (void)
{
    uint sum_s0 = uint(0);

    sum_s0 += uint(s0.i);
    sum_s0 += uint(s0.f);
    sum_s0 += uint(s0.b);
    sum_s0 += uint(s0.sc);
    sum_s0 += uint(s0.ui);

    sb_out.result = sum_s0;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const bool sc0 = bool(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    bool sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, bool(sc0), 8u);


void main (void)
{
    int sum_s0 = int(0);

    sum_s0 += int(s0.i);
    sum_s0 += int(s0.f);
    sum_s0 += int(s0.b);
    sum_s0 += int(s0.sc);
    sum_s0 += int(s0.ui);

    sb_out.result = sum_s0;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const float sc0 = 1.0;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result;
} sb_out;

struct Data {
    int  i;
    vec3 sc[3];
    bool b;
};

Data s0 = Data(1, vec3[3](vec3(2.0), vec3(sc0), vec3(4.0)), false);


void main (void)
{
    float sum_s0 = 0;

    sum_s0 += float(s0.i);
    sum_s0 += float(s0.sc[0][0]);
    sum_s0 += float(s0.sc[1][0]);
    sum_s0 += float(s0.sc[2][0]);
    sum_s0 += float(s0.b);

    sb_out.result = sum_s0;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 fragColor;

layout(constant_id = 1) const int sc0 = 1;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result;
} sb_out;

struct Nested {
    vec2  v;
    int   sc;
    float f;
};

struct Data {
    uint   ui;
    Nested s;
    bool   b;
};

Data s0 = Data(1u, Nested(vec2(2.0), sc0, 4.0), true);


void main (void)
{
    int sum_s0 = 0;

    sum_s0 += int(s0.ui);
    sum_s0 += int(s0.s.v[0]);
    sum_s0 += int(s0.s.sc);
    sum_s0 += int(s0.s.f);
    sum_s0 += int(s0.b);

    sb_out.result = sum_s0;

    fragColor = vec4(1.0, 1.0, 0.0, 1.0);
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const bool sc0 = true;
layout(constant_id = 2) const bool sc1 = false;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    bool r0;
    bool r1;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const int sc0 = -3;
layout(constant_id = 2) const int sc1 = 17;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r0;
    int r1;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const uint sc0 = 42u;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint r0;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const float sc0 = 7.5;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float r0;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const double sc0 = 2.75LF;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double r0;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : require
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const int8_t sc0 = int8_t(1);
layout(constant_id = 2) const int8_t sc1 = int8_t(-2);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int8_t r0;
    int8_t r1;
} sb_out;



void main (void)
{
    int8_t aux = sc0 + sc1;
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : require
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : require
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const uint8_t sc0 = int8_t(15);
layout(constant_id = 2) const uint8_t sc1 = int8_t(43);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint8_t r0;
    uint8_t r1;
} sb_out;



void main (void)
{
    uint8_t aux = sc0 + sc1;
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int16 : require
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const int16_t sc0 = 20000s;
layout(constant_id = 2) const int16_t sc1 = -20000s;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int16_t r0;
    int16_t r1;
} sb_out;



void main (void)
{
    int16_t aux = sc0 + sc1;
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int16 : require
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int16 : require
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const uint16_t sc0 = 64000us;
layout(constant_id = 2) const uint16_t sc1 = 51829us;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint16_t r0;
    uint16_t r1;
} sb_out;



void main (void)
{
    uint16_t aux = sc0 + sc1;
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const int64_t sc0 = 9141386509785772560l;
layout(constant_id = 2) const int64_t sc1 = -9141386509785772560l;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int64_t r0;
    int64_t r1;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const uint64_t sc0 = 18364758544493064720ul;
layout(constant_id = 2) const uint64_t sc1 = 17298946664678735070ul;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint64_t r0;
    uint64_t r1;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const float16_t sc0 = 7.5hf;
layout(constant_id = 2) const float16_t sc1 = 1.125hf;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float16_t r0;
    float16_t r1;
} sb_out;



void main (void)
{
    float16_t aux = sc0 + sc1;
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const bool sc0 = true;
layout(constant_id = 2) const bool sc1 = false;
layout(constant_id = 3) const bool sc2 = true;
layout(constant_id = 4) const bool sc3 = false;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    bool r0;
    bool r1;
    bool r2;
    bool r3;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;
    sb_out.r2 = sc2;
    sb_out.r3 = sc3;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const int sc0 = -3;
layout(constant_id = 2) const int sc1 = 91;
layout(constant_id = 3) const int sc2 = 17;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r0;
    int r1;
    int r2;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;
    sb_out.r2 = sc2;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const uint sc0 = 42u;
layout(constant_id = 2) const uint sc1 = 7u;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint r0;
    uint r1;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const float sc0 = 7.5;
layout(constant_id = 2) const float sc1 = 1.125;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float r0;
    float r1;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const double sc0 = 2.75LF;
layout(constant_id = 2) const double sc1 = 9.25LF;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double r0;
    double r1;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_explicit_arithmetic_types_int16 : require
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : require
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const uint8_t  sc0 = uint8_t  (0);
layout(constant_id = 2) const uint16_t sc1 = uint16_t (0);
layout(constant_id = 3) const uint     sc2 = uint     (0);
layout(constant_id = 4) const uint64_t sc3 = uint64_t (0);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint64_t r0;
    uint     r1;
    uint16_t r2;
    uint8_t  r3;
} sb_out;



void main (void)
{
    uint64_t i0 = sc3;
    uint     i1 = sc2;
    uint16_t i2 = sc1;
    uint8_t  i3 = sc0;
    sb_out.r0 = i0;
    sb_out.r1 = i1;
    sb_out.r2 = i2;
    sb_out.r3 = i3;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_explicit_arithmetic_types_int16 : require
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : require
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_explicit_arithmetic_types_int16 : require
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : require
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const uint64_t sc3 = uint64_t (0);
layout(constant_id = 2) const uint     sc2 = uint     (0);
layout(constant_id = 3) const uint16_t sc1 = uint16_t (0);
layout(constant_id = 4) const uint8_t  sc0 = uint8_t  (0);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint64_t r0;
    uint     r1;
    uint16_t r2;
    uint8_t  r3;
} sb_out;



void main (void)
{
    uint64_t i0 = sc3;
    uint     i1 = sc2;
    uint16_t i2 = sc1;
    uint8_t  i3 = sc0;
    sb_out.r0 = i0;
    sb_out.r1 = i1;
    sb_out.r2 = i2;
    sb_out.r3 = i3;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : require
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const int8_t sc0 = int8_t(123);
layout(constant_id = 2) const int8_t sc1 = int8_t(-33);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int8_t r0;
    int8_t r1;
} sb_out;



void main (void)
{
    int8_t aux = sc0 + sc1;
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : require
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const uint8_t sc0 = int8_t(99);
layout(constant_id = 2) const uint8_t sc1 = int8_t(81);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint8_t r0;
    uint8_t r1;
} sb_out;



void main (void)
{
    uint8_t aux = sc0 + sc1;
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const uint sc0 = 305419896u;
layout(constant_id = 2) const uint sc1 = 591751049u;
layout(constant_id = 3) const uint sc2 = 878082202u;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint r0;
    uint r1;
    uint r2;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;
    sb_out.r2 = sc2;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const float16_t sc0 = 7.5hf;
layout(constant_id = 2) const float16_t sc1 = 1.125hf;
layout(constant_id = 3) const float16_t sc2 = 1.125hf;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float16_t r0;
    float16_t r1;
    float16_t r2;
} sb_out;



void main (void)
{
    float16_t aux = sc0 + sc1;
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;
    sb_out.r2 = sc2;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const float sc0 = 7.5;
layout(constant_id = 2) const float sc1 = 1.125;
layout(constant_id = 3) const float sc2 = 1.125;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float r0;
    float r1;
    float r2;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;
    sb_out.r2 = sc2;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];



layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r0;
} sb_out;



void main (void)
{
    sb_out.r0 = 77;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];


layout(constant_id = 1) const int sc1 = 0;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r1;
} sb_out;



void main (void)
{
    sb_out.r1 = sc1;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 7) const int sc0 = 0;

layout(constant_id = 17) const int sc1 = 0;


layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r0;
    int r1;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 7) const int sc0 = 0;


layout(constant_id = 17) const int sc1 = 0;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r0;
    int r1;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) gl_MaxImageUnits;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    bool ok;
} sb_out;



void main (void)
{
    sb_out.ok = (gl_MaxImageUnits >= 8);

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) gl_MaxImageUnits;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int maxImageUnits;
} sb_out;



void main (void)
{
    sb_out.maxImageUnits = gl_MaxImageUnits;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const int sc0 = 2;
layout(constant_id = 2) const int sc1 = 3;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result;
} sb_out;

const int expr0 = sc0 + 1;
const int expr1 = sc0 + sc1;


void main (void)
{
    sb_out.result = expr0 + expr1;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const int sc0 = 1;
layout(constant_id = 2) const int sc1 = 2;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r0;
    int r1[3];
} sb_out;



void main (void)
{
    int a0[sc0];
    int a1[sc1];

    for (int i = 0; i < sc0; ++i)
        a0[i] = sc0 - i;
    for (int i = 0; i < sc1; ++i)
        a1[i] = sc1 - i;

    sb_out.r0 = a0[0];
    for (int i = 0; i < sc1; ++i)
         sb_out.r1[i] = a1[i];

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const int sc0 = 3;
layout(constant_id = 2) const int sc1 = 5;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r0;
    int r1;
} sb_out;



void main (void)
{
    int a0[sc0 + 3];
    int a1[sc0 + sc1];

    const int size0 = sc0 + 3;
    const int size1 = sc0 + sc1;

    for (int i = 0; i < size0; ++i)
        a0[i] = 3 - i;
    for (int i = 0; i < size1; ++i)
        a1[i] = 5 - i;

    sb_out.r0 = a0[size0 - 1];
    sb_out.r1 = a1[size1 - 1];

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const int sc0 = 3;
layout(constant_id = 2) const int sc1 = 5;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r0;
    int r1;
} sb_out;



void main (void)
{
    const int size0 = sc0 + 3;
    const int size1 = sc0 + sc1;

    int a0[size0];
    int a1[size1];

    for (int i = 0; i < size0; ++i)
        a0[i] = 3 - i;
    for (int i = 0; i < size1; ++i)
        a1[i] = 5 - i;

    sb_out.r0 = a0[size0 - 1];
    sb_out.r1 = a1[size1 - 1];

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const int sc0 = 1;
layout(constant_id = 2) const int sc1 = 2;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r0;
    int r1;
} sb_out;



void main (void)
{
    int a0[sc0];
    int a1[sc1];

    sb_out.r0 = a0.length();
    sb_out.r1 = a1.length();

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const int sc0 = 3;
layout(constant_id = 2) const int sc1 = 1;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result;
} sb_out;

int sumArrays (int a0[sc0], int a1[sc1])
{
    int sum = 0;
    for (int i = 0; (i < sc0) && (i < sc1); ++i)
        sum += a0[i] + a1[i];
    return sum;
}


void main (void)
{
    int a0[sc0];
    int a1[sc1];

    for (int i = 0; i < sc0; ++i)
        a0[i] = i + 1;
    for (int i = 0; i < sc1; ++i)
        a1[i] = i + 2;

    sb_out.result = sumArrays(a0, a1);

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

mat2x3 m0 = mat2x3(sc0, 2, 3, 4, 5, 6);
mat2x3 m1 = mat2x3(1, sc0, 3, 4, 5, 6);
mat2x3 m2 = mat2x3(1, 2, sc0, 4, 5, 6);
mat2x3 m3 = mat2x3(1, 2, 3, sc0, 5, 6);
mat2x3 m4 = mat2x3(1, 2, 3, 4, sc0, 6);
mat2x3 m5 = mat2x3(1, 2, 3, 4, 5, sc0);


void main (void)
{
    float sum_m0 = float(0);
    float sum_m1 = float(0);
    float sum_m2 = float(0);
    float sum_m3 = float(0);
    float sum_m4 = float(0);
    float sum_m5 = float(0);

    for (int i = 0; i < 2; ++i)
    for (int j = 0; j < 3; ++j)
    {
        sum_m0 += float(m0[i][j]);
        sum_m1 += float(m1[i][j]);
        sum_m2 += float(m2[i][j]);
        sum_m3 += float(m3[i][j]);
        sum_m4 += float(m4[i][j]);
        sum_m5 += float(m5[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[8];
} sb_out;

mat2x4 m0 = mat2x4(sc0, 2, 3, 4, 5, 6, 7, 8);
mat2x4 m1 = mat2x4(1, sc0, 3, 4, 5, 6, 7, 8);
mat2x4 m2 = mat2x4(1, 2, sc0, 4, 5, 6, 7, 8);
mat2x4 m3 = mat2x4(1, 2, 3, sc0, 5, 6, 7, 8);
mat2x4 m4 = mat2x4(1, 2, 3, 4, sc0, 6, 7, 8);
mat2x4 m5 = mat2x4(1, 2, 3, 4, 5, sc0, 7, 8);
mat2x4 m6 = mat2x4(1, 2, 3, 4, 5, 6, sc0, 8);
mat2x4 m7 = mat2x4(1, 2, 3, 4, 5, 6, 7, sc0);


void main (void)
{
    float sum_m0 = float(0);
    float sum_m1 = float(0);
    float sum_m2 = float(0);
    float sum_m3 = float(0);
    float sum_m4 = float(0);
    float sum_m5 = float(0);
    float sum_m6 = float(0);
    float sum_m7 = float(0);

    for (int i = 0; i < 2; ++i)
    for (int j = 0; j < 4; ++j)
    {
        sum_m0 += float(m0[i][j]);
        sum_m1 += float(m1[i][j]);
        sum_m2 += float(m2[i][j]);
        sum_m3 += float(m3[i][j]);
        sum_m4 += float(m4[i][j]);
        sum_m5 += float(m5[i][j]);
        sum_m6 += float(m6[i][j]);
        sum_m7 += float(m7[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;
    sb_out.result[6] = sum_m6;
    sb_out.result[7] = sum_m7;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

mat3x2 m0 = mat3x2(sc0, 2, 3, 4, 5, 6);
mat3x2 m1 = mat3x2(1, sc0, 3, 4, 5, 6);
mat3x2 m2 = mat3x2(1, 2, sc0, 4, 5, 6);
mat3x2 m3 = mat3x2(1, 2, 3, sc0, 5, 6);
mat3x2 m4 = mat3x2(1, 2, 3, 4, sc0, 6);
mat3x2 m5 = mat3x2(1, 2, 3, 4, 5, sc0);


void main (void)
{
    float sum_m0 = float(0);
    float sum_m1 = float(0);
    float sum_m2 = float(0);
    float sum_m3 = float(0);
    float sum_m4 = float(0);
    float sum_m5 = float(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_m0 += float(m0[i][j]);
        sum_m1 += float(m1[i][j]);
        sum_m2 += float(m2[i][j]);
        sum_m3 += float(m3[i][j]);
        sum_m4 += float(m4[i][j]);
        sum_m5 += float(m5[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[12];
} sb_out;

mat3x4 m0 = mat3x4(sc0, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);
mat3x4 m1 = mat3x4(1, sc0, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);
mat3x4 m2 = mat3x4(1, 2, sc0, 4, 5, 6, 7, 8, 9, 10, 11, 12);
mat3x4 m3 = mat3x4(1, 2, 3, sc0, 5, 6, 7, 8, 9, 10, 11, 12);
mat3x4 m4 = mat3x4(1, 2, 3, 4, sc0, 6, 7, 8, 9, 10, 11, 12);
mat3x4 m5 = mat3x4(1, 2, 3, 4, 5, sc0, 7, 8, 9, 10, 11, 12);
mat3x4 m6 = mat3x4(1, 2, 3, 4, 5, 6, sc0, 8, 9, 10, 11, 12);
mat3x4 m7 = mat3x4(1, 2, 3, 4, 5, 6, 7, sc0, 9, 10, 11, 12);
mat3x4 m8 = mat3x4(1, 2, 3, 4, 5, 6, 7, 8, sc0, 10, 11, 12);
mat3x4 m9 = mat3x4(1, 2, 3, 4, 5, 6, 7, 8, 9, sc0, 11, 12);
mat3x4 m10 = mat3x4(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, sc0, 12);
mat3x4 m11 = mat3x4(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, sc0);


void main (void)
{
    float sum_m0 = float(0);
    float sum_m1 = float(0);
    float sum_m2 = float(0);
    float sum_m3 = float(0);
    float sum_m4 = float(0);
    float sum_m5 = float(0);
    float sum_m6 = float(0);
    float sum_m7 = float(0);
    float sum_m8 = float(0);
    float sum_m9 = float(0);
    float sum_m10 = float(0);
    float sum_m11 = float(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 4; ++j)
    {
        sum_m0 += float(m0[i][j]);
        sum_m1 += float(m1[i][j]);
        sum_m2 += float(m2[i][j]);
        sum_m3 += float(m3[i][j]);
        sum_m4 += float(m4[i][j]);
        sum_m5 += float(m5[i][j]);
        sum_m6 += float(m6[i][j]);
        sum_m7 += float(m7[i][j]);
        sum_m8 += float(m8[i][j]);
        sum_m9 += float(m9[i][j]);
        sum_m10 += float(m10[i][j]);
        sum_m11 += float(m11[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;
    sb_out.result[6] = sum_m6;
    sb_out.result[7] = sum_m7;
    sb_out.result[8] = sum_m8;
    sb_out.result[9] = sum_m9;
    sb_out.result[10] = sum_m10;
    sb_out.result[11] = sum_m11;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[8];
} sb_out;

mat4x2 m0 = mat4x2(sc0, 2, 3, 4, 5, 6, 7, 8);
mat4x2 m1 = mat4x2(1, sc0, 3, 4, 5, 6, 7, 8);
mat4x2 m2 = mat4x2(1, 2, sc0, 4, 5, 6, 7, 8);
mat4x2 m3 = mat4x2(1, 2, 3, sc0, 5, 6, 7, 8);
mat4x2 m4 = mat4x2(1, 2, 3, 4, sc0, 6, 7, 8);
mat4x2 m5 = mat4x2(1, 2, 3, 4, 5, sc0, 7, 8);
mat4x2 m6 = mat4x2(1, 2, 3, 4, 5, 6, sc0, 8);
mat4x2 m7 = mat4x2(1, 2, 3, 4, 5, 6, 7, sc0);


void main (void)
{
    float sum_m0 = float(0);
    float sum_m1 = float(0);
    float sum_m2 = float(0);
    float sum_m3 = float(0);
    float sum_m4 = float(0);
    float sum_m5 = float(0);
    float sum_m6 = float(0);
    float sum_m7 = float(0);

    for (int i = 0; i < 4; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_m0 += float(m0[i][j]);
        sum_m1 += float(m1[i][j]);
        sum_m2 += float(m2[i][j]);
        sum_m3 += float(m3[i][j]);
        sum_m4 += float(m4[i][j]);
        sum_m5 += float(m5[i][j]);
        sum_m6 += float(m6[i][j]);
        sum_m7 += float(m7[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;
    sb_out.result[6] = sum_m6;
    sb_out.result[7] = sum_m7;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[12];
} sb_out;

mat4x3 m0 = mat4x3(sc0, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);
mat4x3 m1 = mat4x3(1, sc0, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);
mat4x3 m2 = mat4x3(1, 2, sc0, 4, 5, 6, 7, 8, 9, 10, 11, 12);
mat4x3 m3 = mat4x3(1, 2, 3, sc0, 5, 6, 7, 8, 9, 10, 11, 12);
mat4x3 m4 = mat4x3(1, 2, 3, 4, sc0, 6, 7, 8, 9, 10, 11, 12);
mat4x3 m5 = mat4x3(1, 2, 3, 4, 5, sc0, 7, 8, 9, 10, 11, 12);
mat4x3 m6 = mat4x3(1, 2, 3, 4, 5, 6, sc0, 8, 9, 10, 11, 12);
mat4x3 m7 = mat4x3(1, 2, 3, 4, 5, 6, 7, sc0, 9, 10, 11, 12);
mat4x3 m8 = mat4x3(1, 2, 3, 4, 5, 6, 7, 8, sc0, 10, 11, 12);
mat4x3 m9 = mat4x3(1, 2, 3, 4, 5, 6, 7, 8, 9, sc0, 11, 12);
mat4x3 m10 = mat4x3(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, sc0, 12);
mat4x3 m11 = mat4x3(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, sc0);


void main (void)
{
    float sum_m0 = float(0);
    float sum_m1 = float(0);
    float sum_m2 = float(0);
    float sum_m3 = float(0);
    float sum_m4 = float(0);
    float sum_m5 = float(0);
    float sum_m6 = float(0);
    float sum_m7 = float(0);
    float sum_m8 = float(0);
    float sum_m9 = float(0);
    float sum_m10 = float(0);
    float sum_m11 = float(0);

    for (int i = 0; i < 4; ++i)
    for (int j = 0; j < 3; ++j)
    {
        sum_m0 += float(m0[i][j]);
        sum_m1 += float(m1[i][j]);
        sum_m2 += float(m2[i][j]);
        sum_m3 += float(m3[i][j]);
        sum_m4 += float(m4[i][j]);
        sum_m5 += float(m5[i][j]);
        sum_m6 += float(m6[i][j]);
        sum_m7 += float(m7[i][j]);
        sum_m8 += float(m8[i][j]);
        sum_m9 += float(m9[i][j]);
        sum_m10 += float(m10[i][j]);
        sum_m11 += float(m11[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;
    sb_out.result[6] = sum_m6;
    sb_out.result[7] = sum_m7;
    sb_out.result[8] = sum_m8;
    sb_out.result[9] = sum_m9;
    sb_out.result[10] = sum_m10;
    sb_out.result[11] = sum_m11;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

dmat2x3 m0 = dmat2x3(sc0, 2, 3, 4, 5, 6);
dmat2x3 m1 = dmat2x3(1, sc0, 3, 4, 5, 6);
dmat2x3 m2 = dmat2x3(1, 2, sc0, 4, 5, 6);
dmat2x3 m3 = dmat2x3(1, 2, 3, sc0, 5, 6);
dmat2x3 m4 = dmat2x3(1, 2, 3, 4, sc0, 6);
dmat2x3 m5 = dmat2x3(1, 2, 3, 4, 5, sc0);


void main (void)
{
    double sum_m0 = double(0);
    double sum_m1 = double(0);
    double sum_m2 = double(0);
    double sum_m3 = double(0);
    double sum_m4 = double(0);
    double sum_m5 = double(0);

    for (int i = 0; i < 2; ++i)
    for (int j = 0; j < 3; ++j)
    {
        sum_m0 += double(m0[i][j]);
        sum_m1 += double(m1[i][j]);
        sum_m2 += double(m2[i][j]);
        sum_m3 += double(m3[i][j]);
        sum_m4 += double(m4[i][j]);
        sum_m5 += double(m5[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[8];
} sb_out;

dmat2x4 m0 = dmat2x4(sc0, 2, 3, 4, 5, 6, 7, 8);
dmat2x4 m1 = dmat2x4(1, sc0, 3, 4, 5, 6, 7, 8);
dmat2x4 m2 = dmat2x4(1, 2, sc0, 4, 5, 6, 7, 8);
dmat2x4 m3 = dmat2x4(1, 2, 3, sc0, 5, 6, 7, 8);
dmat2x4 m4 = dmat2x4(1, 2, 3, 4, sc0, 6, 7, 8);
dmat2x4 m5 = dmat2x4(1, 2, 3, 4, 5, sc0, 7, 8);
dmat2x4 m6 = dmat2x4(1, 2, 3, 4, 5, 6, sc0, 8);
dmat2x4 m7 = dmat2x4(1, 2, 3, 4, 5, 6, 7, sc0);


void main (void)
{
    double sum_m0 = double(0);
    double sum_m1 = double(0);
    double sum_m2 = double(0);
    double sum_m3 = double(0);
    double sum_m4 = double(0);
    double sum_m5 = double(0);
    double sum_m6 = double(0);
    double sum_m7 = double(0);

    for (int i = 0; i < 2; ++i)
    for (int j = 0; j < 4; ++j)
    {
        sum_m0 += double(m0[i][j]);
        sum_m1 += double(m1[i][j]);
        sum_m2 += double(m2[i][j]);
        sum_m3 += double(m3[i][j]);
        sum_m4 += double(m4[i][j]);
        sum_m5 += double(m5[i][j]);
        sum_m6 += double(m6[i][j]);
        sum_m7 += double(m7[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;
    sb_out.result[6] = sum_m6;
    sb_out.result[7] = sum_m7;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

dmat3x2 m0 = dmat3x2(sc0, 2, 3, 4, 5, 6);
dmat3x2 m1 = dmat3x2(1, sc0, 3, 4, 5, 6);
dmat3x2 m2 = dmat3x2(1, 2, sc0, 4, 5, 6);
dmat3x2 m3 = dmat3x2(1, 2, 3, sc0, 5, 6);
dmat3x2 m4 = dmat3x2(1, 2, 3, 4, sc0, 6);
dmat3x2 m5 = dmat3x2(1, 2, 3, 4, 5, sc0);


void main (void)
{
    double sum_m0 = double(0);
    double sum_m1 = double(0);
    double sum_m2 = double(0);
    double sum_m3 = double(0);
    double sum_m4 = double(0);
    double sum_m5 = double(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_m0 += double(m0[i][j]);
        sum_m1 += double(m1[i][j]);
        sum_m2 += double(m2[i][j]);
        sum_m3 += double(m3[i][j]);
        sum_m4 += double(m4[i][j]);
        sum_m5 += double(m5[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[12];
} sb_out;

dmat3x4 m0 = dmat3x4(sc0, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);
dmat3x4 m1 = dmat3x4(1, sc0, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);
dmat3x4 m2 = dmat3x4(1, 2, sc0, 4, 5, 6, 7, 8, 9, 10, 11, 12);
dmat3x4 m3 = dmat3x4(1, 2, 3, sc0, 5, 6, 7, 8, 9, 10, 11, 12);
dmat3x4 m4 = dmat3x4(1, 2, 3, 4, sc0, 6, 7, 8, 9, 10, 11, 12);
dmat3x4 m5 = dmat3x4(1, 2, 3, 4, 5, sc0, 7, 8, 9, 10, 11, 12);
dmat3x4 m6 = dmat3x4(1, 2, 3, 4, 5, 6, sc0, 8, 9, 10, 11, 12);
dmat3x4 m7 = dmat3x4(1, 2, 3, 4, 5, 6, 7, sc0, 9, 10, 11, 12);
dmat3x4 m8 = dmat3x4(1, 2, 3, 4, 5, 6, 7, 8, sc0, 10, 11, 12);
dmat3x4 m9 = dmat3x4(1, 2, 3, 4, 5, 6, 7, 8, 9, sc0, 11, 12);
dmat3x4 m10 = dmat3x4(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, sc0, 12);
dmat3x4 m11 = dmat3x4(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, sc0);


void main (void)
{
    double sum_m0 = double(0);
    double sum_m1 = double(0);
    double sum_m2 = double(0);
    double sum_m3 = double(0);
    double sum_m4 = double(0);
    double sum_m5 = double(0);
    double sum_m6 = double(0);
    double sum_m7 = double(0);
    double sum_m8 = double(0);
    double sum_m9 = double(0);
    double sum_m10 = double(0);
    double sum_m11 = double(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 4; ++j)
    {
        sum_m0 += double(m0[i][j]);
        sum_m1 += double(m1[i][j]);
        sum_m2 += double(m2[i][j]);
        sum_m3 += double(m3[i][j]);
        sum_m4 += double(m4[i][j]);
        sum_m5 += double(m5[i][j]);
        sum_m6 += double(m6[i][j]);
        sum_m7 += double(m7[i][j]);
        sum_m8 += double(m8[i][j]);
        sum_m9 += double(m9[i][j]);
        sum_m10 += double(m10[i][j]);
        sum_m11 += double(m11[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;
    sb_out.result[6] = sum_m6;
    sb_out.result[7] = sum_m7;
    sb_out.result[8] = sum_m8;
    sb_out.result[9] = sum_m9;
    sb_out.result[10] = sum_m10;
    sb_out.result[11] = sum_m11;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[8];
} sb_out;

dmat4x2 m0 = dmat4x2(sc0, 2, 3, 4, 5, 6, 7, 8);
dmat4x2 m1 = dmat4x2(1, sc0, 3, 4, 5, 6, 7, 8);
dmat4x2 m2 = dmat4x2(1, 2, sc0, 4, 5, 6, 7, 8);
dmat4x2 m3 = dmat4x2(1, 2, 3, sc0, 5, 6, 7, 8);
dmat4x2 m4 = dmat4x2(1, 2, 3, 4, sc0, 6, 7, 8);
dmat4x2 m5 = dmat4x2(1, 2, 3, 4, 5, sc0, 7, 8);
dmat4x2 m6 = dmat4x2(1, 2, 3, 4, 5, 6, sc0, 8);
dmat4x2 m7 = dmat4x2(1, 2, 3, 4, 5, 6, 7, sc0);


void main (void)
{
    double sum_m0 = double(0);
    double sum_m1 = double(0);
    double sum_m2 = double(0);
    double sum_m3 = double(0);
    double sum_m4 = double(0);
    double sum_m5 = double(0);
    double sum_m6 = double(0);
    double sum_m7 = double(0);

    for (int i = 0; i < 4; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_m0 += double(m0[i][j]);
        sum_m1 += double(m1[i][j]);
        sum_m2 += double(m2[i][j]);
        sum_m3 += double(m3[i][j]);
        sum_m4 += double(m4[i][j]);
        sum_m5 += double(m5[i][j]);
        sum_m6 += double(m6[i][j]);
        sum_m7 += double(m7[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;
    sb_out.result[6] = sum_m6;
    sb_out.result[7] = sum_m7;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[12];
} sb_out;

dmat4x3 m0 = dmat4x3(sc0, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);
dmat4x3 m1 = dmat4x3(1, sc0, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);
dmat4x3 m2 = dmat4x3(1, 2, sc0, 4, 5, 6, 7, 8, 9, 10, 11, 12);
dmat4x3 m3 = dmat4x3(1, 2, 3, sc0, 5, 6, 7, 8, 9, 10, 11, 12);
dmat4x3 m4 = dmat4x3(1, 2, 3, 4, sc0, 6, 7, 8, 9, 10, 11, 12);
dmat4x3 m5 = dmat4x3(1, 2, 3, 4, 5, sc0, 7, 8, 9, 10, 11, 12);
dmat4x3 m6 = dmat4x3(1, 2, 3, 4, 5, 6, sc0, 8, 9, 10, 11, 12);
dmat4x3 m7 = dmat4x3(1, 2, 3, 4, 5, 6, 7, sc0, 9, 10, 11, 12);
dmat4x3 m8 = dmat4x3(1, 2, 3, 4, 5, 6, 7, 8, sc0, 10, 11, 12);
dmat4x3 m9 = dmat4x3(1, 2, 3, 4, 5, 6, 7, 8, 9, sc0, 11, 12);
dmat4x3 m10 = dmat4x3(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, sc0, 12);
dmat4x3 m11 = dmat4x3(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, sc0);


void main (void)
{
    double sum_m0 = double(0);
    double sum_m1 = double(0);
    double sum_m2 = double(0);
    double sum_m3 = double(0);
    double sum_m4 = double(0);
    double sum_m5 = double(0);
    double sum_m6 = double(0);
    double sum_m7 = double(0);
    double sum_m8 = double(0);
    double sum_m9 = double(0);
    double sum_m10 = double(0);
    double sum_m11 = double(0);

    for (int i = 0; i < 4; ++i)
    for (int j = 0; j < 3; ++j)
    {
        sum_m0 += double(m0[i][j]);
        sum_m1 += double(m1[i][j]);
        sum_m2 += double(m2[i][j]);
        sum_m3 += double(m3[i][j]);
        sum_m4 += double(m4[i][j]);
        sum_m5 += double(m5[i][j]);
        sum_m6 += double(m6[i][j]);
        sum_m7 += double(m7[i][j]);
        sum_m8 += double(m8[i][j]);
        sum_m9 += double(m9[i][j]);
        sum_m10 += double(m10[i][j]);
        sum_m11 += double(m11[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;
    sb_out.result[6] = sum_m6;
    sb_out.result[7] = sum_m7;
    sb_out.result[8] = sum_m8;
    sb_out.result[9] = sum_m9;
    sb_out.result[10] = sum_m10;
    sb_out.result[11] = sum_m11;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[3];
} sb_out;

float a0[3] = float[3](sc0, 2, 3);
float a1[3] = float[3](1, sc0, 3);
float a2[3] = float[3](1, 2, sc0);


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += float(a0[i]);
        sum_a1 += float(a1[i]);
        sum_a2 += float(a2[i]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[3];
} sb_out;

mat2x3 a0[3] = mat2x3[3](mat2x3(sc0), mat2x3(2), mat2x3(3));
mat2x3 a1[3] = mat2x3[3](mat2x3(1), mat2x3(sc0), mat2x3(3));
mat2x3 a2[3] = mat2x3[3](mat2x3(1), mat2x3(2), mat2x3(sc0));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += float(a0[i][0][0]);
        sum_a1 += float(a1[i][0][0]);
        sum_a2 += float(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[3];
} sb_out;

mat2x4 a0[3] = mat2x4[3](mat2x4(sc0), mat2x4(2), mat2x4(3));
mat2x4 a1[3] = mat2x4[3](mat2x4(1), mat2x4(sc0), mat2x4(3));
mat2x4 a2[3] = mat2x4[3](mat2x4(1), mat2x4(2), mat2x4(sc0));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += float(a0[i][0][0]);
        sum_a1 += float(a1[i][0][0]);
        sum_a2 += float(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[3];
} sb_out;

mat3x2 a0[3] = mat3x2[3](mat3x2(sc0), mat3x2(2), mat3x2(3));
mat3x2 a1[3] = mat3x2[3](mat3x2(1), mat3x2(sc0), mat3x2(3));
mat3x2 a2[3] = mat3x2[3](mat3x2(1), mat3x2(2), mat3x2(sc0));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += float(a0[i][0][0]);
        sum_a1 += float(a1[i][0][0]);
        sum_a2 += float(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[3];
} sb_out;

mat3x4 a0[3] = mat3x4[3](mat3x4(sc0), mat3x4(2), mat3x4(3));
mat3x4 a1[3] = mat3x4[3](mat3x4(1), mat3x4(sc0), mat3x4(3));
mat3x4 a2[3] = mat3x4[3](mat3x4(1), mat3x4(2), mat3x4(sc0));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += float(a0[i][0][0]);
        sum_a1 += float(a1[i][0][0]);
        sum_a2 += float(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[3];
} sb_out;

mat4x2 a0[3] = mat4x2[3](mat4x2(sc0), mat4x2(2), mat4x2(3));
mat4x2 a1[3] = mat4x2[3](mat4x2(1), mat4x2(sc0), mat4x2(3));
mat4x2 a2[3] = mat4x2[3](mat4x2(1), mat4x2(2), mat4x2(sc0));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += float(a0[i][0][0]);
        sum_a1 += float(a1[i][0][0]);
        sum_a2 += float(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[3];
} sb_out;

mat4x3 a0[3] = mat4x3[3](mat4x3(sc0), mat4x3(2), mat4x3(3));
mat4x3 a1[3] = mat4x3[3](mat4x3(1), mat4x3(sc0), mat4x3(3));
mat4x3 a2[3] = mat4x3[3](mat4x3(1), mat4x3(2), mat4x3(sc0));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += float(a0[i][0][0]);
        sum_a1 += float(a1[i][0][0]);
        sum_a2 += float(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[3];
} sb_out;

double a0[3] = double[3](sc0, 2, 3);
double a1[3] = double[3](1, sc0, 3);
double a2[3] = double[3](1, 2, sc0);


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += double(a0[i]);
        sum_a1 += double(a1[i]);
        sum_a2 += double(a2[i]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[3];
} sb_out;

dmat2x3 a0[3] = dmat2x3[3](dmat2x3(sc0), dmat2x3(2), dmat2x3(3));
dmat2x3 a1[3] = dmat2x3[3](dmat2x3(1), dmat2x3(sc0), dmat2x3(3));
dmat2x3 a2[3] = dmat2x3[3](dmat2x3(1), dmat2x3(2), dmat2x3(sc0));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += double(a0[i][0][0]);
        sum_a1 += double(a1[i][0][0]);
        sum_a2 += double(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[3];
} sb_out;

dmat2x4 a0[3] = dmat2x4[3](dmat2x4(sc0), dmat2x4(2), dmat2x4(3));
dmat2x4 a1[3] = dmat2x4[3](dmat2x4(1), dmat2x4(sc0), dmat2x4(3));
dmat2x4 a2[3] = dmat2x4[3](dmat2x4(1), dmat2x4(2), dmat2x4(sc0));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += double(a0[i][0][0]);
        sum_a1 += double(a1[i][0][0]);
        sum_a2 += double(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[3];
} sb_out;

dmat3x2 a0[3] = dmat3x2[3](dmat3x2(sc0), dmat3x2(2), dmat3x2(3));
dmat3x2 a1[3] = dmat3x2[3](dmat3x2(1), dmat3x2(sc0), dmat3x2(3));
dmat3x2 a2[3] = dmat3x2[3](dmat3x2(1), dmat3x2(2), dmat3x2(sc0));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += double(a0[i][0][0]);
        sum_a1 += double(a1[i][0][0]);
        sum_a2 += double(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[3];
} sb_out;

dmat3x4 a0[3] = dmat3x4[3](dmat3x4(sc0), dmat3x4(2), dmat3x4(3));
dmat3x4 a1[3] = dmat3x4[3](dmat3x4(1), dmat3x4(sc0), dmat3x4(3));
dmat3x4 a2[3] = dmat3x4[3](dmat3x4(1), dmat3x4(2), dmat3x4(sc0));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += double(a0[i][0][0]);
        sum_a1 += double(a1[i][0][0]);
        sum_a2 += double(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[3];
} sb_out;

dmat4x2 a0[3] = dmat4x2[3](dmat4x2(sc0), dmat4x2(2), dmat4x2(3));
dmat4x2 a1[3] = dmat4x2[3](dmat4x2(1), dmat4x2(sc0), dmat4x2(3));
dmat4x2 a2[3] = dmat4x2[3](dmat4x2(1), dmat4x2(2), dmat4x2(sc0));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += double(a0[i][0][0]);
        sum_a1 += double(a1[i][0][0]);
        sum_a2 += double(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[3];
} sb_out;

dmat4x3 a0[3] = dmat4x3[3](dmat4x3(sc0), dmat4x3(2), dmat4x3(3));
dmat4x3 a1[3] = dmat4x3[3](dmat4x3(1), dmat4x3(sc0), dmat4x3(3));
dmat4x3 a2[3] = dmat4x3[3](dmat4x3(1), dmat4x3(2), dmat4x3(sc0));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += double(a0[i][0][0]);
        sum_a1 += double(a1[i][0][0]);
        sum_a2 += double(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const int sc0 = int(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result[3];
} sb_out;

int a0[3] = int[3](sc0, 2, 3);
int a1[3] = int[3](1, sc0, 3);
int a2[3] = int[3](1, 2, sc0);


void main (void)
{
    int sum_a0 = int(0);
    int sum_a1 = int(0);
    int sum_a2 = int(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += int(a0[i]);
        sum_a1 += int(a1[i]);
        sum_a2 += int(a2[i]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const uint sc0 = uint(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint result[3];
} sb_out;

uint a0[3] = uint[3](sc0, 2, 3);
uint a1[3] = uint[3](1, sc0, 3);
uint a2[3] = uint[3](1, 2, sc0);


void main (void)
{
    uint sum_a0 = uint(0);
    uint sum_a1 = uint(0);
    uint sum_a2 = uint(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += uint(a0[i]);
        sum_a1 += uint(a1[i]);
        sum_a2 += uint(a2[i]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const bool sc0 = bool(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result[3];
} sb_out;

bool a0[3] = bool[3](sc0, true, true);
bool a1[3] = bool[3](true, sc0, true);
bool a2[3] = bool[3](true, true, sc0);


void main (void)
{
    int sum_a0 = int(0);
    int sum_a1 = int(0);
    int sum_a2 = int(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += int(a0[i]);
        sum_a1 += int(a1[i]);
        sum_a2 += int(a2[i]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

float a0[3][2] = float[3][2](float[2](sc0, 2),
                                    float[2](3, 4),
                                    float[2](5, 6));
float a1[3][2] = float[3][2](float[2](1, sc0),
                                    float[2](3, 4),
                                    float[2](5, 6));
float a2[3][2] = float[3][2](float[2](1, 2),
                                    float[2](sc0, 4),
                                    float[2](5, 6));
float a3[3][2] = float[3][2](float[2](1, 2),
                                    float[2](3, sc0),
                                    float[2](5, 6));
float a4[3][2] = float[3][2](float[2](1, 2),
                                    float[2](3, 4),
                                    float[2](sc0, 6));
float a5[3][2] = float[3][2](float[2](1, 2),
                                    float[2](3, 4),
                                    float[2](5, sc0));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);
    float sum_a3 = float(0);
    float sum_a4 = float(0);
    float sum_a5 = float(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += float(a0[i][j]);
        sum_a1 += float(a1[i][j]);
        sum_a2 += float(a2[i][j]);
        sum_a3 += float(a3[i][j]);
        sum_a4 += float(a4[i][j]);
        sum_a5 += float(a5[i][j]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

mat2x3 a0[3][2] = mat2x3[3][2](mat2x3[2](mat2x3(sc0), mat2x3(2)),
                                    mat2x3[2](mat2x3(3), mat2x3(4)),
                                    mat2x3[2](mat2x3(5), mat2x3(6)));
mat2x3 a1[3][2] = mat2x3[3][2](mat2x3[2](mat2x3(1), mat2x3(sc0)),
                                    mat2x3[2](mat2x3(3), mat2x3(4)),
                                    mat2x3[2](mat2x3(5), mat2x3(6)));
mat2x3 a2[3][2] = mat2x3[3][2](mat2x3[2](mat2x3(1), mat2x3(2)),
                                    mat2x3[2](mat2x3(sc0), mat2x3(4)),
                                    mat2x3[2](mat2x3(5), mat2x3(6)));
mat2x3 a3[3][2] = mat2x3[3][2](mat2x3[2](mat2x3(1), mat2x3(2)),
                                    mat2x3[2](mat2x3(3), mat2x3(sc0)),
                                    mat2x3[2](mat2x3(5), mat2x3(6)));
mat2x3 a4[3][2] = mat2x3[3][2](mat2x3[2](mat2x3(1), mat2x3(2)),
                                    mat2x3[2](mat2x3(3), mat2x3(4)),
                                    mat2x3[2](mat2x3(sc0), mat2x3(6)));
mat2x3 a5[3][2] = mat2x3[3][2](mat2x3[2](mat2x3(1), mat2x3(2)),
                                    mat2x3[2](mat2x3(3), mat2x3(4)),
                                    mat2x3[2](mat2x3(5), mat2x3(sc0)));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);
    float sum_a3 = float(0);
    float sum_a4 = float(0);
    float sum_a5 = float(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += float(a0[i][j][0][0]);
        sum_a1 += float(a1[i][j][0][0]);
        sum_a2 += float(a2[i][j][0][0]);
        sum_a3 += float(a3[i][j][0][0]);
        sum_a4 += float(a4[i][j][0][0]);
        sum_a5 += float(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

mat2x4 a0[3][2] = mat2x4[3][2](mat2x4[2](mat2x4(sc0), mat2x4(2)),
                                    mat2x4[2](mat2x4(3), mat2x4(4)),
                                    mat2x4[2](mat2x4(5), mat2x4(6)));
mat2x4 a1[3][2] = mat2x4[3][2](mat2x4[2](mat2x4(1), mat2x4(sc0)),
                                    mat2x4[2](mat2x4(3), mat2x4(4)),
                                    mat2x4[2](mat2x4(5), mat2x4(6)));
mat2x4 a2[3][2] = mat2x4[3][2](mat2x4[2](mat2x4(1), mat2x4(2)),
                                    mat2x4[2](mat2x4(sc0), mat2x4(4)),
                                    mat2x4[2](mat2x4(5), mat2x4(6)));
mat2x4 a3[3][2] = mat2x4[3][2](mat2x4[2](mat2x4(1), mat2x4(2)),
                                    mat2x4[2](mat2x4(3), mat2x4(sc0)),
                                    mat2x4[2](mat2x4(5), mat2x4(6)));
mat2x4 a4[3][2] = mat2x4[3][2](mat2x4[2](mat2x4(1), mat2x4(2)),
                                    mat2x4[2](mat2x4(3), mat2x4(4)),
                                    mat2x4[2](mat2x4(sc0), mat2x4(6)));
mat2x4 a5[3][2] = mat2x4[3][2](mat2x4[2](mat2x4(1), mat2x4(2)),
                                    mat2x4[2](mat2x4(3), mat2x4(4)),
                                    mat2x4[2](mat2x4(5), mat2x4(sc0)));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);
    float sum_a3 = float(0);
    float sum_a4 = float(0);
    float sum_a5 = float(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += float(a0[i][j][0][0]);
        sum_a1 += float(a1[i][j][0][0]);
        sum_a2 += float(a2[i][j][0][0]);
        sum_a3 += float(a3[i][j][0][0]);
        sum_a4 += float(a4[i][j][0][0]);
        sum_a5 += float(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

mat3x2 a0[3][2] = mat3x2[3][2](mat3x2[2](mat3x2(sc0), mat3x2(2)),
                                    mat3x2[2](mat3x2(3), mat3x2(4)),
                                    mat3x2[2](mat3x2(5), mat3x2(6)));
mat3x2 a1[3][2] = mat3x2[3][2](mat3x2[2](mat3x2(1), mat3x2(sc0)),
                                    mat3x2[2](mat3x2(3), mat3x2(4)),
                                    mat3x2[2](mat3x2(5), mat3x2(6)));
mat3x2 a2[3][2] = mat3x2[3][2](mat3x2[2](mat3x2(1), mat3x2(2)),
                                    mat3x2[2](mat3x2(sc0), mat3x2(4)),
                                    mat3x2[2](mat3x2(5), mat3x2(6)));
mat3x2 a3[3][2] = mat3x2[3][2](mat3x2[2](mat3x2(1), mat3x2(2)),
                                    mat3x2[2](mat3x2(3), mat3x2(sc0)),
                                    mat3x2[2](mat3x2(5), mat3x2(6)));
mat3x2 a4[3][2] = mat3x2[3][2](mat3x2[2](mat3x2(1), mat3x2(2)),
                                    mat3x2[2](mat3x2(3), mat3x2(4)),
                                    mat3x2[2](mat3x2(sc0), mat3x2(6)));
mat3x2 a5[3][2] = mat3x2[3][2](mat3x2[2](mat3x2(1), mat3x2(2)),
                                    mat3x2[2](mat3x2(3), mat3x2(4)),
                                    mat3x2[2](mat3x2(5), mat3x2(sc0)));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);
    float sum_a3 = float(0);
    float sum_a4 = float(0);
    float sum_a5 = float(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += float(a0[i][j][0][0]);
        sum_a1 += float(a1[i][j][0][0]);
        sum_a2 += float(a2[i][j][0][0]);
        sum_a3 += float(a3[i][j][0][0]);
        sum_a4 += float(a4[i][j][0][0]);
        sum_a5 += float(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

mat3x4 a0[3][2] = mat3x4[3][2](mat3x4[2](mat3x4(sc0), mat3x4(2)),
                                    mat3x4[2](mat3x4(3), mat3x4(4)),
                                    mat3x4[2](mat3x4(5), mat3x4(6)));
mat3x4 a1[3][2] = mat3x4[3][2](mat3x4[2](mat3x4(1), mat3x4(sc0)),
                                    mat3x4[2](mat3x4(3), mat3x4(4)),
                                    mat3x4[2](mat3x4(5), mat3x4(6)));
mat3x4 a2[3][2] = mat3x4[3][2](mat3x4[2](mat3x4(1), mat3x4(2)),
                                    mat3x4[2](mat3x4(sc0), mat3x4(4)),
                                    mat3x4[2](mat3x4(5), mat3x4(6)));
mat3x4 a3[3][2] = mat3x4[3][2](mat3x4[2](mat3x4(1), mat3x4(2)),
                                    mat3x4[2](mat3x4(3), mat3x4(sc0)),
                                    mat3x4[2](mat3x4(5), mat3x4(6)));
mat3x4 a4[3][2] = mat3x4[3][2](mat3x4[2](mat3x4(1), mat3x4(2)),
                                    mat3x4[2](mat3x4(3), mat3x4(4)),
                                    mat3x4[2](mat3x4(sc0), mat3x4(6)));
mat3x4 a5[3][2] = mat3x4[3][2](mat3x4[2](mat3x4(1), mat3x4(2)),
                                    mat3x4[2](mat3x4(3), mat3x4(4)),
                                    mat3x4[2](mat3x4(5), mat3x4(sc0)));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);
    float sum_a3 = float(0);
    float sum_a4 = float(0);
    float sum_a5 = float(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += float(a0[i][j][0][0]);
        sum_a1 += float(a1[i][j][0][0]);
        sum_a2 += float(a2[i][j][0][0]);
        sum_a3 += float(a3[i][j][0][0]);
        sum_a4 += float(a4[i][j][0][0]);
        sum_a5 += float(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

mat4x2 a0[3][2] = mat4x2[3][2](mat4x2[2](mat4x2(sc0), mat4x2(2)),
                                    mat4x2[2](mat4x2(3), mat4x2(4)),
                                    mat4x2[2](mat4x2(5), mat4x2(6)));
mat4x2 a1[3][2] = mat4x2[3][2](mat4x2[2](mat4x2(1), mat4x2(sc0)),
                                    mat4x2[2](mat4x2(3), mat4x2(4)),
                                    mat4x2[2](mat4x2(5), mat4x2(6)));
mat4x2 a2[3][2] = mat4x2[3][2](mat4x2[2](mat4x2(1), mat4x2(2)),
                                    mat4x2[2](mat4x2(sc0), mat4x2(4)),
                                    mat4x2[2](mat4x2(5), mat4x2(6)));
mat4x2 a3[3][2] = mat4x2[3][2](mat4x2[2](mat4x2(1), mat4x2(2)),
                                    mat4x2[2](mat4x2(3), mat4x2(sc0)),
                                    mat4x2[2](mat4x2(5), mat4x2(6)));
mat4x2 a4[3][2] = mat4x2[3][2](mat4x2[2](mat4x2(1), mat4x2(2)),
                                    mat4x2[2](mat4x2(3), mat4x2(4)),
                                    mat4x2[2](mat4x2(sc0), mat4x2(6)));
mat4x2 a5[3][2] = mat4x2[3][2](mat4x2[2](mat4x2(1), mat4x2(2)),
                                    mat4x2[2](mat4x2(3), mat4x2(4)),
                                    mat4x2[2](mat4x2(5), mat4x2(sc0)));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);
    float sum_a3 = float(0);
    float sum_a4 = float(0);
    float sum_a5 = float(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += float(a0[i][j][0][0]);
        sum_a1 += float(a1[i][j][0][0]);
        sum_a2 += float(a2[i][j][0][0]);
        sum_a3 += float(a3[i][j][0][0]);
        sum_a4 += float(a4[i][j][0][0]);
        sum_a5 += float(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

mat4x3 a0[3][2] = mat4x3[3][2](mat4x3[2](mat4x3(sc0), mat4x3(2)),
                                    mat4x3[2](mat4x3(3), mat4x3(4)),
                                    mat4x3[2](mat4x3(5), mat4x3(6)));
mat4x3 a1[3][2] = mat4x3[3][2](mat4x3[2](mat4x3(1), mat4x3(sc0)),
                                    mat4x3[2](mat4x3(3), mat4x3(4)),
                                    mat4x3[2](mat4x3(5), mat4x3(6)));
mat4x3 a2[3][2] = mat4x3[3][2](mat4x3[2](mat4x3(1), mat4x3(2)),
                                    mat4x3[2](mat4x3(sc0), mat4x3(4)),
                                    mat4x3[2](mat4x3(5), mat4x3(6)));
mat4x3 a3[3][2] = mat4x3[3][2](mat4x3[2](mat4x3(1), mat4x3(2)),
                                    mat4x3[2](mat4x3(3), mat4x3(sc0)),
                                    mat4x3[2](mat4x3(5), mat4x3(6)));
mat4x3 a4[3][2] = mat4x3[3][2](mat4x3[2](mat4x3(1), mat4x3(2)),
                                    mat4x3[2](mat4x3(3), mat4x3(4)),
                                    mat4x3[2](mat4x3(sc0), mat4x3(6)));
mat4x3 a5[3][2] = mat4x3[3][2](mat4x3[2](mat4x3(1), mat4x3(2)),
                                    mat4x3[2](mat4x3(3), mat4x3(4)),
                                    mat4x3[2](mat4x3(5), mat4x3(sc0)));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);
    float sum_a3 = float(0);
    float sum_a4 = float(0);
    float sum_a5 = float(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += float(a0[i][j][0][0]);
        sum_a1 += float(a1[i][j][0][0]);
        sum_a2 += float(a2[i][j][0][0]);
        sum_a3 += float(a3[i][j][0][0]);
        sum_a4 += float(a4[i][j][0][0]);
        sum_a5 += float(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

double a0[3][2] = double[3][2](double[2](sc0, 2),
                                    double[2](3, 4),
                                    double[2](5, 6));
double a1[3][2] = double[3][2](double[2](1, sc0),
                                    double[2](3, 4),
                                    double[2](5, 6));
double a2[3][2] = double[3][2](double[2](1, 2),
                                    double[2](sc0, 4),
                                    double[2](5, 6));
double a3[3][2] = double[3][2](double[2](1, 2),
                                    double[2](3, sc0),
                                    double[2](5, 6));
double a4[3][2] = double[3][2](double[2](1, 2),
                                    double[2](3, 4),
                                    double[2](sc0, 6));
double a5[3][2] = double[3][2](double[2](1, 2),
                                    double[2](3, 4),
                                    double[2](5, sc0));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);
    double sum_a3 = double(0);
    double sum_a4 = double(0);
    double sum_a5 = double(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += double(a0[i][j]);
        sum_a1 += double(a1[i][j]);
        sum_a2 += double(a2[i][j]);
        sum_a3 += double(a3[i][j]);
        sum_a4 += double(a4[i][j]);
        sum_a5 += double(a5[i][j]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

dmat2x3 a0[3][2] = dmat2x3[3][2](dmat2x3[2](dmat2x3(sc0), dmat2x3(2)),
                                    dmat2x3[2](dmat2x3(3), dmat2x3(4)),
                                    dmat2x3[2](dmat2x3(5), dmat2x3(6)));
dmat2x3 a1[3][2] = dmat2x3[3][2](dmat2x3[2](dmat2x3(1), dmat2x3(sc0)),
                                    dmat2x3[2](dmat2x3(3), dmat2x3(4)),
                                    dmat2x3[2](dmat2x3(5), dmat2x3(6)));
dmat2x3 a2[3][2] = dmat2x3[3][2](dmat2x3[2](dmat2x3(1), dmat2x3(2)),
                                    dmat2x3[2](dmat2x3(sc0), dmat2x3(4)),
                                    dmat2x3[2](dmat2x3(5), dmat2x3(6)));
dmat2x3 a3[3][2] = dmat2x3[3][2](dmat2x3[2](dmat2x3(1), dmat2x3(2)),
                                    dmat2x3[2](dmat2x3(3), dmat2x3(sc0)),
                                    dmat2x3[2](dmat2x3(5), dmat2x3(6)));
dmat2x3 a4[3][2] = dmat2x3[3][2](dmat2x3[2](dmat2x3(1), dmat2x3(2)),
                                    dmat2x3[2](dmat2x3(3), dmat2x3(4)),
                                    dmat2x3[2](dmat2x3(sc0), dmat2x3(6)));
dmat2x3 a5[3][2] = dmat2x3[3][2](dmat2x3[2](dmat2x3(1), dmat2x3(2)),
                                    dmat2x3[2](dmat2x3(3), dmat2x3(4)),
                                    dmat2x3[2](dmat2x3(5), dmat2x3(sc0)));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);
    double sum_a3 = double(0);
    double sum_a4 = double(0);
    double sum_a5 = double(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += double(a0[i][j][0][0]);
        sum_a1 += double(a1[i][j][0][0]);
        sum_a2 += double(a2[i][j][0][0]);
        sum_a3 += double(a3[i][j][0][0]);
        sum_a4 += double(a4[i][j][0][0]);
        sum_a5 += double(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

dmat2x4 a0[3][2] = dmat2x4[3][2](dmat2x4[2](dmat2x4(sc0), dmat2x4(2)),
                                    dmat2x4[2](dmat2x4(3), dmat2x4(4)),
                                    dmat2x4[2](dmat2x4(5), dmat2x4(6)));
dmat2x4 a1[3][2] = dmat2x4[3][2](dmat2x4[2](dmat2x4(1), dmat2x4(sc0)),
                                    dmat2x4[2](dmat2x4(3), dmat2x4(4)),
                                    dmat2x4[2](dmat2x4(5), dmat2x4(6)));
dmat2x4 a2[3][2] = dmat2x4[3][2](dmat2x4[2](dmat2x4(1), dmat2x4(2)),
                                    dmat2x4[2](dmat2x4(sc0), dmat2x4(4)),
                                    dmat2x4[2](dmat2x4(5), dmat2x4(6)));
dmat2x4 a3[3][2] = dmat2x4[3][2](dmat2x4[2](dmat2x4(1), dmat2x4(2)),
                                    dmat2x4[2](dmat2x4(3), dmat2x4(sc0)),
                                    dmat2x4[2](dmat2x4(5), dmat2x4(6)));
dmat2x4 a4[3][2] = dmat2x4[3][2](dmat2x4[2](dmat2x4(1), dmat2x4(2)),
                                    dmat2x4[2](dmat2x4(3), dmat2x4(4)),
                                    dmat2x4[2](dmat2x4(sc0), dmat2x4(6)));
dmat2x4 a5[3][2] = dmat2x4[3][2](dmat2x4[2](dmat2x4(1), dmat2x4(2)),
                                    dmat2x4[2](dmat2x4(3), dmat2x4(4)),
                                    dmat2x4[2](dmat2x4(5), dmat2x4(sc0)));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);
    double sum_a3 = double(0);
    double sum_a4 = double(0);
    double sum_a5 = double(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += double(a0[i][j][0][0]);
        sum_a1 += double(a1[i][j][0][0]);
        sum_a2 += double(a2[i][j][0][0]);
        sum_a3 += double(a3[i][j][0][0]);
        sum_a4 += double(a4[i][j][0][0]);
        sum_a5 += double(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

dmat3x2 a0[3][2] = dmat3x2[3][2](dmat3x2[2](dmat3x2(sc0), dmat3x2(2)),
                                    dmat3x2[2](dmat3x2(3), dmat3x2(4)),
                                    dmat3x2[2](dmat3x2(5), dmat3x2(6)));
dmat3x2 a1[3][2] = dmat3x2[3][2](dmat3x2[2](dmat3x2(1), dmat3x2(sc0)),
                                    dmat3x2[2](dmat3x2(3), dmat3x2(4)),
                                    dmat3x2[2](dmat3x2(5), dmat3x2(6)));
dmat3x2 a2[3][2] = dmat3x2[3][2](dmat3x2[2](dmat3x2(1), dmat3x2(2)),
                                    dmat3x2[2](dmat3x2(sc0), dmat3x2(4)),
                                    dmat3x2[2](dmat3x2(5), dmat3x2(6)));
dmat3x2 a3[3][2] = dmat3x2[3][2](dmat3x2[2](dmat3x2(1), dmat3x2(2)),
                                    dmat3x2[2](dmat3x2(3), dmat3x2(sc0)),
                                    dmat3x2[2](dmat3x2(5), dmat3x2(6)));
dmat3x2 a4[3][2] = dmat3x2[3][2](dmat3x2[2](dmat3x2(1), dmat3x2(2)),
                                    dmat3x2[2](dmat3x2(3), dmat3x2(4)),
                                    dmat3x2[2](dmat3x2(sc0), dmat3x2(6)));
dmat3x2 a5[3][2] = dmat3x2[3][2](dmat3x2[2](dmat3x2(1), dmat3x2(2)),
                                    dmat3x2[2](dmat3x2(3), dmat3x2(4)),
                                    dmat3x2[2](dmat3x2(5), dmat3x2(sc0)));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);
    double sum_a3 = double(0);
    double sum_a4 = double(0);
    double sum_a5 = double(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += double(a0[i][j][0][0]);
        sum_a1 += double(a1[i][j][0][0]);
        sum_a2 += double(a2[i][j][0][0]);
        sum_a3 += double(a3[i][j][0][0]);
        sum_a4 += double(a4[i][j][0][0]);
        sum_a5 += double(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

dmat3x4 a0[3][2] = dmat3x4[3][2](dmat3x4[2](dmat3x4(sc0), dmat3x4(2)),
                                    dmat3x4[2](dmat3x4(3), dmat3x4(4)),
                                    dmat3x4[2](dmat3x4(5), dmat3x4(6)));
dmat3x4 a1[3][2] = dmat3x4[3][2](dmat3x4[2](dmat3x4(1), dmat3x4(sc0)),
                                    dmat3x4[2](dmat3x4(3), dmat3x4(4)),
                                    dmat3x4[2](dmat3x4(5), dmat3x4(6)));
dmat3x4 a2[3][2] = dmat3x4[3][2](dmat3x4[2](dmat3x4(1), dmat3x4(2)),
                                    dmat3x4[2](dmat3x4(sc0), dmat3x4(4)),
                                    dmat3x4[2](dmat3x4(5), dmat3x4(6)));
dmat3x4 a3[3][2] = dmat3x4[3][2](dmat3x4[2](dmat3x4(1), dmat3x4(2)),
                                    dmat3x4[2](dmat3x4(3), dmat3x4(sc0)),
                                    dmat3x4[2](dmat3x4(5), dmat3x4(6)));
dmat3x4 a4[3][2] = dmat3x4[3][2](dmat3x4[2](dmat3x4(1), dmat3x4(2)),
                                    dmat3x4[2](dmat3x4(3), dmat3x4(4)),
                                    dmat3x4[2](dmat3x4(sc0), dmat3x4(6)));
dmat3x4 a5[3][2] = dmat3x4[3][2](dmat3x4[2](dmat3x4(1), dmat3x4(2)),
                                    dmat3x4[2](dmat3x4(3), dmat3x4(4)),
                                    dmat3x4[2](dmat3x4(5), dmat3x4(sc0)));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);
    double sum_a3 = double(0);
    double sum_a4 = double(0);
    double sum_a5 = double(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += double(a0[i][j][0][0]);
        sum_a1 += double(a1[i][j][0][0]);
        sum_a2 += double(a2[i][j][0][0]);
        sum_a3 += double(a3[i][j][0][0]);
        sum_a4 += double(a4[i][j][0][0]);
        sum_a5 += double(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

dmat4x2 a0[3][2] = dmat4x2[3][2](dmat4x2[2](dmat4x2(sc0), dmat4x2(2)),
                                    dmat4x2[2](dmat4x2(3), dmat4x2(4)),
                                    dmat4x2[2](dmat4x2(5), dmat4x2(6)));
dmat4x2 a1[3][2] = dmat4x2[3][2](dmat4x2[2](dmat4x2(1), dmat4x2(sc0)),
                                    dmat4x2[2](dmat4x2(3), dmat4x2(4)),
                                    dmat4x2[2](dmat4x2(5), dmat4x2(6)));
dmat4x2 a2[3][2] = dmat4x2[3][2](dmat4x2[2](dmat4x2(1), dmat4x2(2)),
                                    dmat4x2[2](dmat4x2(sc0), dmat4x2(4)),
                                    dmat4x2[2](dmat4x2(5), dmat4x2(6)));
dmat4x2 a3[3][2] = dmat4x2[3][2](dmat4x2[2](dmat4x2(1), dmat4x2(2)),
                                    dmat4x2[2](dmat4x2(3), dmat4x2(sc0)),
                                    dmat4x2[2](dmat4x2(5), dmat4x2(6)));
dmat4x2 a4[3][2] = dmat4x2[3][2](dmat4x2[2](dmat4x2(1), dmat4x2(2)),
                                    dmat4x2[2](dmat4x2(3), dmat4x2(4)),
                                    dmat4x2[2](dmat4x2(sc0), dmat4x2(6)));
dmat4x2 a5[3][2] = dmat4x2[3][2](dmat4x2[2](dmat4x2(1), dmat4x2(2)),
                                    dmat4x2[2](dmat4x2(3), dmat4x2(4)),
                                    dmat4x2[2](dmat4x2(5), dmat4x2(sc0)));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);
    double sum_a3 = double(0);
    double sum_a4 = double(0);
    double sum_a5 = double(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += double(a0[i][j][0][0]);
        sum_a1 += double(a1[i][j][0][0]);
        sum_a2 += double(a2[i][j][0][0]);
        sum_a3 += double(a3[i][j][0][0]);
        sum_a4 += double(a4[i][j][0][0]);
        sum_a5 += double(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

dmat4x3 a0[3][2] = dmat4x3[3][2](dmat4x3[2](dmat4x3(sc0), dmat4x3(2)),
                                    dmat4x3[2](dmat4x3(3), dmat4x3(4)),
                                    dmat4x3[2](dmat4x3(5), dmat4x3(6)));
dmat4x3 a1[3][2] = dmat4x3[3][2](dmat4x3[2](dmat4x3(1), dmat4x3(sc0)),
                                    dmat4x3[2](dmat4x3(3), dmat4x3(4)),
                                    dmat4x3[2](dmat4x3(5), dmat4x3(6)));
dmat4x3 a2[3][2] = dmat4x3[3][2](dmat4x3[2](dmat4x3(1), dmat4x3(2)),
                                    dmat4x3[2](dmat4x3(sc0), dmat4x3(4)),
                                    dmat4x3[2](dmat4x3(5), dmat4x3(6)));
dmat4x3 a3[3][2] = dmat4x3[3][2](dmat4x3[2](dmat4x3(1), dmat4x3(2)),
                                    dmat4x3[2](dmat4x3(3), dmat4x3(sc0)),
                                    dmat4x3[2](dmat4x3(5), dmat4x3(6)));
dmat4x3 a4[3][2] = dmat4x3[3][2](dmat4x3[2](dmat4x3(1), dmat4x3(2)),
                                    dmat4x3[2](dmat4x3(3), dmat4x3(4)),
                                    dmat4x3[2](dmat4x3(sc0), dmat4x3(6)));
dmat4x3 a5[3][2] = dmat4x3[3][2](dmat4x3[2](dmat4x3(1), dmat4x3(2)),
                                    dmat4x3[2](dmat4x3(3), dmat4x3(4)),
                                    dmat4x3[2](dmat4x3(5), dmat4x3(sc0)));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);
    double sum_a3 = double(0);
    double sum_a4 = double(0);
    double sum_a5 = double(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += double(a0[i][j][0][0]);
        sum_a1 += double(a1[i][j][0][0]);
        sum_a2 += double(a2[i][j][0][0]);
        sum_a3 += double(a3[i][j][0][0]);
        sum_a4 += double(a4[i][j][0][0]);
        sum_a5 += double(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const int sc0 = int(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result[6];
} sb_out;

int a0[3][2] = int[3][2](int[2](sc0, 2),
                                    int[2](3, 4),
                                    int[2](5, 6));
int a1[3][2] = int[3][2](int[2](1, sc0),
                                    int[2](3, 4),
                                    int[2](5, 6));
int a2[3][2] = int[3][2](int[2](1, 2),
                                    int[2](sc0, 4),
                                    int[2](5, 6));
int a3[3][2] = int[3][2](int[2](1, 2),
                                    int[2](3, sc0),
                                    int[2](5, 6));
int a4[3][2] = int[3][2](int[2](1, 2),
                                    int[2](3, 4),
                                    int[2](sc0, 6));
int a5[3][2] = int[3][2](int[2](1, 2),
                                    int[2](3, 4),
                                    int[2](5, sc0));


void main (void)
{
    int sum_a0 = int(0);
    int sum_a1 = int(0);
    int sum_a2 = int(0);
    int sum_a3 = int(0);
    int sum_a4 = int(0);
    int sum_a5 = int(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += int(a0[i][j]);
        sum_a1 += int(a1[i][j]);
        sum_a2 += int(a2[i][j]);
        sum_a3 += int(a3[i][j]);
        sum_a4 += int(a4[i][j]);
        sum_a5 += int(a5[i][j]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const uint sc0 = uint(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint result[6];
} sb_out;

uint a0[3][2] = uint[3][2](uint[2](sc0, 2),
                                    uint[2](3, 4),
                                    uint[2](5, 6));
uint a1[3][2] = uint[3][2](uint[2](1, sc0),
                                    uint[2](3, 4),
                                    uint[2](5, 6));
uint a2[3][2] = uint[3][2](uint[2](1, 2),
                                    uint[2](sc0, 4),
                                    uint[2](5, 6));
uint a3[3][2] = uint[3][2](uint[2](1, 2),
                                    uint[2](3, sc0),
                                    uint[2](5, 6));
uint a4[3][2] = uint[3][2](uint[2](1, 2),
                                    uint[2](3, 4),
                                    uint[2](sc0, 6));
uint a5[3][2] = uint[3][2](uint[2](1, 2),
                                    uint[2](3, 4),
                                    uint[2](5, sc0));


void main (void)
{
    uint sum_a0 = uint(0);
    uint sum_a1 = uint(0);
    uint sum_a2 = uint(0);
    uint sum_a3 = uint(0);
    uint sum_a4 = uint(0);
    uint sum_a5 = uint(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += uint(a0[i][j]);
        sum_a1 += uint(a1[i][j]);
        sum_a2 += uint(a2[i][j]);
        sum_a3 += uint(a3[i][j]);
        sum_a4 += uint(a4[i][j]);
        sum_a5 += uint(a5[i][j]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const bool sc0 = bool(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result[6];
} sb_out;

bool a0[3][2] = bool[3][2](bool[2](sc0, true),
                                    bool[2](true, true),
                                    bool[2](true, true));
bool a1[3][2] = bool[3][2](bool[2](true, sc0),
                                    bool[2](true, true),
                                    bool[2](true, true));
bool a2[3][2] = bool[3][2](bool[2](true, true),
                                    bool[2](sc0, true),
                                    bool[2](true, true));
bool a3[3][2] = bool[3][2](bool[2](true, true),
                                    bool[2](true, sc0),
                                    bool[2](true, true));
bool a4[3][2] = bool[3][2](bool[2](true, true),
                                    bool[2](true, true),
                                    bool[2](sc0, true));
bool a5[3][2] = bool[3][2](bool[2](true, true),
                                    bool[2](true, true),
                                    bool[2](true, sc0));


void main (void)
{
    int sum_a0 = int(0);
    int sum_a1 = int(0);
    int sum_a2 = int(0);
    int sum_a3 = int(0);
    int sum_a4 = int(0);
    int sum_a5 = int(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += int(a0[i][j]);
        sum_a1 += int(a1[i][j]);
        sum_a2 += int(a2[i][j]);
        sum_a3 += int(a3[i][j]);
        sum_a4 += int(a4[i][j]);
        sum_a5 += int(a5[i][j]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const int   sc0 = 1;
layout(constant_id = 2) const float sc1 = 1.0;
layout(constant_id = 3) const bool  sc2 = true;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result;
} sb_out;

struct Data {
    int   x;
    float y;
    bool  z;
};

Data a0[3] = Data[3](Data(sc0, 2.0, true), Data(1, sc1, true), Data(1, 2.0, sc2));


void main (void)
{
    int sum_a0 = 0;

    for (int i = 0; i < 3; ++i)
        sum_a0 += int(a0[i].x) + int(a0[i].y) + int(a0[i].z);

    sb_out.result = sum_a0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    float sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, float(sc0), 8u);


void main (void)
{
    float sum_s0 = float(0);

    sum_s0 += float(s0.i);
    sum_s0 += float(s0.f);
    sum_s0 += float(s0.b);
    sum_s0 += float(s0.sc);
    sum_s0 += float(s0.ui);

    sb_out.result = sum_s0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    mat2x3 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, mat2x3(sc0), 8u);


void main (void)
{
    float sum_s0 = float(0);

    sum_s0 += float(s0.i);
    sum_s0 += float(s0.f);
    sum_s0 += float(s0.b);
    sum_s0 += float(s0.sc[0][0]);
    sum_s0 += float(s0.ui);

    sb_out.result = sum_s0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    mat2x4 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, mat2x4(sc0), 8u);


void main (void)
{
    float sum_s0 = float(0);

    sum_s0 += float(s0.i);
    sum_s0 += float(s0.f);
    sum_s0 += float(s0.b);
    sum_s0 += float(s0.sc[0][0]);
    sum_s0 += float(s0.ui);

    sb_out.result = sum_s0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    mat3x2 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, mat3x2(sc0), 8u);


void main (void)
{
    float sum_s0 = float(0);

    sum_s0 += float(s0.i);
    sum_s0 += float(s0.f);
    sum_s0 += float(s0.b);
    sum_s0 += float(s0.sc[0][0]);
    sum_s0 += float(s0.ui);

    sb_out.result = sum_s0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    mat3x4 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, mat3x4(sc0), 8u);


void main (void)
{
    float sum_s0 = float(0);

    sum_s0 += float(s0.i);
    sum_s0 += float(s0.f);
    sum_s0 += float(s0.b);
    sum_s0 += float(s0.sc[0][0]);
    sum_s0 += float(s0.ui);

    sb_out.result = sum_s0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    mat4x2 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, mat4x2(sc0), 8u);


void main (void)
{
    float sum_s0 = float(0);

    sum_s0 += float(s0.i);
    sum_s0 += float(s0.f);
    sum_s0 += float(s0.b);
    sum_s0 += float(s0.sc[0][0]);
    sum_s0 += float(s0.ui);

    sb_out.result = sum_s0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    mat4x3 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, mat4x3(sc0), 8u);


void main (void)
{
    float sum_s0 = float(0);

    sum_s0 += float(s0.i);
    sum_s0 += float(s0.f);
    sum_s0 += float(s0.b);
    sum_s0 += float(s0.sc[0][0]);
    sum_s0 += float(s0.ui);

    sb_out.result = sum_s0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    double sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, double(sc0), 8u);


void main (void)
{
    double sum_s0 = double(0);

    sum_s0 += double(s0.i);
    sum_s0 += double(s0.f);
    sum_s0 += double(s0.b);
    sum_s0 += double(s0.sc);
    sum_s0 += double(s0.ui);

    sb_out.result = sum_s0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    dmat2x3 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, dmat2x3(sc0), 8u);


void main (void)
{
    double sum_s0 = double(0);

    sum_s0 += double(s0.i);
    sum_s0 += double(s0.f);
    sum_s0 += double(s0.b);
    sum_s0 += double(s0.sc[0][0]);
    sum_s0 += double(s0.ui);

    sb_out.result = sum_s0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    dmat2x4 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, dmat2x4(sc0), 8u);


void main (void)
{
    double sum_s0 = double(0);

    sum_s0 += double(s0.i);
    sum_s0 += double(s0.f);
    sum_s0 += double(s0.b);
    sum_s0 += double(s0.sc[0][0]);
    sum_s0 += double(s0.ui);

    sb_out.result = sum_s0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    dmat3x2 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, dmat3x2(sc0), 8u);


void main (void)
{
    double sum_s0 = double(0);

    sum_s0 += double(s0.i);
    sum_s0 += double(s0.f);
    sum_s0 += double(s0.b);
    sum_s0 += double(s0.sc[0][0]);
    sum_s0 += double(s0.ui);

    sb_out.result = sum_s0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    dmat3x4 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, dmat3x4(sc0), 8u);


void main (void)
{
    double sum_s0 = double(0);

    sum_s0 += double(s0.i);
    sum_s0 += double(s0.f);
    sum_s0 += double(s0.b);
    sum_s0 += double(s0.sc[0][0]);
    sum_s0 += double(s0.ui);

    sb_out.result = sum_s0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    dmat4x2 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, dmat4x2(sc0), 8u);


void main (void)
{
    double sum_s0 = double(0);

    sum_s0 += double(s0.i);
    sum_s0 += double(s0.f);
    sum_s0 += double(s0.b);
    sum_s0 += double(s0.sc[0][0]);
    sum_s0 += double(s0.ui);

    sb_out.result = sum_s0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    dmat4x3 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, dmat4x3(sc0), 8u);


void main (void)
{
    double sum_s0 = double(0);

    sum_s0 += double(s0.i);
    sum_s0 += double(s0.f);
    sum_s0 += double(s0.b);
    sum_s0 += double(s0.sc[0][0]);
    sum_s0 += double(s0.ui);

    sb_out.result = sum_s0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const int sc0 = int(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    int sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, int(sc0), 8u);


void main (void)
{
    int sum_s0 = int(0);

    sum_s0 += int(s0.i);
    sum_s0 += int(s0.f);
    sum_s0 += int(s0.b);
    sum_s0 += int(s0.sc);
    sum_s0 += int(s0.ui);

    sb_out.result = sum_s0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const uint sc0 = uint(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    uint sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, uint(sc0), 8u);


void main (void)
{
    uint sum_s0 = uint(0);

    sum_s0 += uint(s0.i);
    sum_s0 += uint(s0.f);
    sum_s0 += uint(s0.b);
    sum_s0 += uint(s0.sc);
    sum_s0 += uint(s0.ui);

    sb_out.result = sum_s0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const bool sc0 = bool(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    bool sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, bool(sc0), 8u);


void main (void)
{
    int sum_s0 = int(0);

    sum_s0 += int(s0.i);
    sum_s0 += int(s0.f);
    sum_s0 += int(s0.b);
    sum_s0 += int(s0.sc);
    sum_s0 += int(s0.ui);

    sb_out.result = sum_s0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const float sc0 = 1.0;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result;
} sb_out;

struct Data {
    int  i;
    vec3 sc[3];
    bool b;
};

Data s0 = Data(1, vec3[3](vec3(2.0), vec3(sc0), vec3(4.0)), false);


void main (void)
{
    float sum_s0 = 0;

    sum_s0 += float(s0.i);
    sum_s0 += float(s0.sc[0][0]);
    sum_s0 += float(s0.sc[1][0]);
    sum_s0 += float(s0.sc[2][0]);
    sum_s0 += float(s0.b);

    sb_out.result = sum_s0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(constant_id = 1) const int sc0 = 1;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result;
} sb_out;

struct Nested {
    vec2  v;
    int   sc;
    float f;
};

struct Data {
    uint   ui;
    Nested s;
    bool   b;
};

Data s0 = Data(1u, Nested(vec2(2.0), sc0, 4.0), true);


void main (void)
{
    int sum_s0 = 0;

    sum_s0 += int(s0.ui);
    sum_s0 += int(s0.s.v[0]);
    sum_s0 += int(s0.s.sc);
    sum_s0 += int(s0.s.f);
    sum_s0 += int(s0.b);

    sb_out.result = sum_s0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

void main (void)
{
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const bool sc0 = true;
layout(constant_id = 2) const bool sc1 = false;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    bool r0;
    bool r1;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int sc0 = -3;
layout(constant_id = 2) const int sc1 = 17;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r0;
    int r1;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const uint sc0 = 42u;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint r0;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = 7.5;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float r0;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = 2.75LF;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double r0;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : require
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

void main (void)
{
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : require
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int8_t sc0 = int8_t(1);
layout(constant_id = 2) const int8_t sc1 = int8_t(-2);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int8_t r0;
    int8_t r1;
} sb_out;



void main (void)
{
    int8_t aux = sc0 + sc1;
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : require
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const uint8_t sc0 = int8_t(15);
layout(constant_id = 2) const uint8_t sc1 = int8_t(43);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint8_t r0;
    uint8_t r1;
} sb_out;



void main (void)
{
    uint8_t aux = sc0 + sc1;
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int16 : require
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

void main (void)
{
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int16 : require
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int16_t sc0 = 20000s;
layout(constant_id = 2) const int16_t sc1 = -20000s;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int16_t r0;
    int16_t r1;
} sb_out;



void main (void)
{
    int16_t aux = sc0 + sc1;
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int16 : require
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const uint16_t sc0 = 64000us;
layout(constant_id = 2) const uint16_t sc1 = 51829us;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint16_t r0;
    uint16_t r1;
} sb_out;



void main (void)
{
    uint16_t aux = sc0 + sc1;
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

void main (void)
{
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int64_t sc0 = 9141386509785772560l;
layout(constant_id = 2) const int64_t sc1 = -9141386509785772560l;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int64_t r0;
    int64_t r1;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const uint64_t sc0 = 18364758544493064720ul;
layout(constant_id = 2) const uint64_t sc1 = 17298946664678735070ul;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint64_t r0;
    uint64_t r1;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

void main (void)
{
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float16_t sc0 = 7.5hf;
layout(constant_id = 2) const float16_t sc1 = 1.125hf;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float16_t r0;
    float16_t r1;
} sb_out;



void main (void)
{
    float16_t aux = sc0 + sc1;
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const bool sc0 = true;
layout(constant_id = 2) const bool sc1 = false;
layout(constant_id = 3) const bool sc2 = true;
layout(constant_id = 4) const bool sc3 = false;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    bool r0;
    bool r1;
    bool r2;
    bool r3;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;
    sb_out.r2 = sc2;
    sb_out.r3 = sc3;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int sc0 = -3;
layout(constant_id = 2) const int sc1 = 91;
layout(constant_id = 3) const int sc2 = 17;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r0;
    int r1;
    int r2;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;
    sb_out.r2 = sc2;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const uint sc0 = 42u;
layout(constant_id = 2) const uint sc1 = 7u;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint r0;
    uint r1;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = 7.5;
layout(constant_id = 2) const float sc1 = 1.125;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float r0;
    float r1;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = 2.75LF;
layout(constant_id = 2) const double sc1 = 9.25LF;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double r0;
    double r1;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_explicit_arithmetic_types_int16 : require
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : require
layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

void main (void)
{
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelOuter[0] = 2;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 2;
    }
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_explicit_arithmetic_types_int16 : require
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : require
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const uint8_t  sc0 = uint8_t  (0);
layout(constant_id = 2) const uint16_t sc1 = uint16_t (0);
layout(constant_id = 3) const uint     sc2 = uint     (0);
layout(constant_id = 4) const uint64_t sc3 = uint64_t (0);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint64_t r0;
    uint     r1;
    uint16_t r2;
    uint8_t  r3;
} sb_out;



void main (void)
{
    uint64_t i0 = sc3;
    uint     i1 = sc2;
    uint16_t i2 = sc1;
    uint8_t  i3 = sc0;
    sb_out.r0 = i0;
    sb_out.r1 = i1;
    sb_out.r2 = i2;
    sb_out.r3 = i3;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_explicit_arithmetic_types_int16 : require
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : require
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const uint64_t sc3 = uint64_t (0);
layout(constant_id = 2) const uint     sc2 = uint     (0);
layout(constant_id = 3) const uint16_t sc1 = uint16_t (0);
layout(constant_id = 4) const uint8_t  sc0 = uint8_t  (0);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint64_t r0;
    uint     r1;
    uint16_t r2;
    uint8_t  r3;
} sb_out;



void main (void)
{
    uint64_t i0 = sc3;
    uint     i1 = sc2;
    uint16_t i2 = sc1;
    uint8_t  i3 = sc0;
    sb_out.r0 = i0;
    sb_out.r1 = i1;
    sb_out.r2 = i2;
    sb_out.r3 = i3;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : require
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int8_t sc0 = int8_t(123);
layout(constant_id = 2) const int8_t sc1 = int8_t(-33);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int8_t r0;
    int8_t r1;
} sb_out;



void main (void)
{
    int8_t aux = sc0 + sc1;
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : require
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const uint8_t sc0 = int8_t(99);
layout(constant_id = 2) const uint8_t sc1 = int8_t(81);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint8_t r0;
    uint8_t r1;
} sb_out;



void main (void)
{
    uint8_t aux = sc0 + sc1;
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const uint sc0 = 305419896u;
layout(constant_id = 2) const uint sc1 = 591751049u;
layout(constant_id = 3) const uint sc2 = 878082202u;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint r0;
    uint r1;
    uint r2;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;
    sb_out.r2 = sc2;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float16_t sc0 = 7.5hf;
layout(constant_id = 2) const float16_t sc1 = 1.125hf;
layout(constant_id = 3) const float16_t sc2 = 1.125hf;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float16_t r0;
    float16_t r1;
    float16_t r2;
} sb_out;



void main (void)
{
    float16_t aux = sc0 + sc1;
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;
    sb_out.r2 = sc2;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = 7.5;
layout(constant_id = 2) const float sc1 = 1.125;
layout(constant_id = 3) const float sc2 = 1.125;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float r0;
    float r1;
    float r2;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;
    sb_out.r2 = sc2;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};



layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r0;
} sb_out;



void main (void)
{
    sb_out.r0 = 77;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};


layout(constant_id = 1) const int sc1 = 0;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r1;
} sb_out;



void main (void)
{
    sb_out.r1 = sc1;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 7) const int sc0 = 0;

layout(constant_id = 17) const int sc1 = 0;


layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r0;
    int r1;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 7) const int sc0 = 0;


layout(constant_id = 17) const int sc1 = 0;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r0;
    int r1;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) gl_MaxImageUnits;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    bool ok;
} sb_out;



void main (void)
{
    sb_out.ok = (gl_MaxImageUnits >= 8);

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) gl_MaxImageUnits;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int maxImageUnits;
} sb_out;



void main (void)
{
    sb_out.maxImageUnits = gl_MaxImageUnits;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int sc0 = 2;
layout(constant_id = 2) const int sc1 = 3;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result;
} sb_out;

const int expr0 = sc0 + 1;
const int expr1 = sc0 + sc1;


void main (void)
{
    sb_out.result = expr0 + expr1;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int sc0 = 1;
layout(constant_id = 2) const int sc1 = 2;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r0;
    int r1[3];
} sb_out;



void main (void)
{
    int a0[sc0];
    int a1[sc1];

    for (int i = 0; i < sc0; ++i)
        a0[i] = sc0 - i;
    for (int i = 0; i < sc1; ++i)
        a1[i] = sc1 - i;

    sb_out.r0 = a0[0];
    for (int i = 0; i < sc1; ++i)
         sb_out.r1[i] = a1[i];

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int sc0 = 3;
layout(constant_id = 2) const int sc1 = 5;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r0;
    int r1;
} sb_out;



void main (void)
{
    int a0[sc0 + 3];
    int a1[sc0 + sc1];

    const int size0 = sc0 + 3;
    const int size1 = sc0 + sc1;

    for (int i = 0; i < size0; ++i)
        a0[i] = 3 - i;
    for (int i = 0; i < size1; ++i)
        a1[i] = 5 - i;

    sb_out.r0 = a0[size0 - 1];
    sb_out.r1 = a1[size1 - 1];

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int sc0 = 3;
layout(constant_id = 2) const int sc1 = 5;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r0;
    int r1;
} sb_out;



void main (void)
{
    const int size0 = sc0 + 3;
    const int size1 = sc0 + sc1;

    int a0[size0];
    int a1[size1];

    for (int i = 0; i < size0; ++i)
        a0[i] = 3 - i;
    for (int i = 0; i < size1; ++i)
        a1[i] = 5 - i;

    sb_out.r0 = a0[size0 - 1];
    sb_out.r1 = a1[size1 - 1];

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int sc0 = 1;
layout(constant_id = 2) const int sc1 = 2;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r0;
    int r1;
} sb_out;



void main (void)
{
    int a0[sc0];
    int a1[sc1];

    sb_out.r0 = a0.length();
    sb_out.r1 = a1.length();

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int sc0 = 3;
layout(constant_id = 2) const int sc1 = 1;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result;
} sb_out;

int sumArrays (int a0[sc0], int a1[sc1])
{
    int sum = 0;
    for (int i = 0; (i < sc0) && (i < sc1); ++i)
        sum += a0[i] + a1[i];
    return sum;
}


void main (void)
{
    int a0[sc0];
    int a1[sc1];

    for (int i = 0; i < sc0; ++i)
        a0[i] = i + 1;
    for (int i = 0; i < sc1; ++i)
        a1[i] = i + 2;

    sb_out.result = sumArrays(a0, a1);

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

mat2x3 m0 = mat2x3(sc0, 2, 3, 4, 5, 6);
mat2x3 m1 = mat2x3(1, sc0, 3, 4, 5, 6);
mat2x3 m2 = mat2x3(1, 2, sc0, 4, 5, 6);
mat2x3 m3 = mat2x3(1, 2, 3, sc0, 5, 6);
mat2x3 m4 = mat2x3(1, 2, 3, 4, sc0, 6);
mat2x3 m5 = mat2x3(1, 2, 3, 4, 5, sc0);


void main (void)
{
    float sum_m0 = float(0);
    float sum_m1 = float(0);
    float sum_m2 = float(0);
    float sum_m3 = float(0);
    float sum_m4 = float(0);
    float sum_m5 = float(0);

    for (int i = 0; i < 2; ++i)
    for (int j = 0; j < 3; ++j)
    {
        sum_m0 += float(m0[i][j]);
        sum_m1 += float(m1[i][j]);
        sum_m2 += float(m2[i][j]);
        sum_m3 += float(m3[i][j]);
        sum_m4 += float(m4[i][j]);
        sum_m5 += float(m5[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[8];
} sb_out;

mat2x4 m0 = mat2x4(sc0, 2, 3, 4, 5, 6, 7, 8);
mat2x4 m1 = mat2x4(1, sc0, 3, 4, 5, 6, 7, 8);
mat2x4 m2 = mat2x4(1, 2, sc0, 4, 5, 6, 7, 8);
mat2x4 m3 = mat2x4(1, 2, 3, sc0, 5, 6, 7, 8);
mat2x4 m4 = mat2x4(1, 2, 3, 4, sc0, 6, 7, 8);
mat2x4 m5 = mat2x4(1, 2, 3, 4, 5, sc0, 7, 8);
mat2x4 m6 = mat2x4(1, 2, 3, 4, 5, 6, sc0, 8);
mat2x4 m7 = mat2x4(1, 2, 3, 4, 5, 6, 7, sc0);


void main (void)
{
    float sum_m0 = float(0);
    float sum_m1 = float(0);
    float sum_m2 = float(0);
    float sum_m3 = float(0);
    float sum_m4 = float(0);
    float sum_m5 = float(0);
    float sum_m6 = float(0);
    float sum_m7 = float(0);

    for (int i = 0; i < 2; ++i)
    for (int j = 0; j < 4; ++j)
    {
        sum_m0 += float(m0[i][j]);
        sum_m1 += float(m1[i][j]);
        sum_m2 += float(m2[i][j]);
        sum_m3 += float(m3[i][j]);
        sum_m4 += float(m4[i][j]);
        sum_m5 += float(m5[i][j]);
        sum_m6 += float(m6[i][j]);
        sum_m7 += float(m7[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;
    sb_out.result[6] = sum_m6;
    sb_out.result[7] = sum_m7;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

mat3x2 m0 = mat3x2(sc0, 2, 3, 4, 5, 6);
mat3x2 m1 = mat3x2(1, sc0, 3, 4, 5, 6);
mat3x2 m2 = mat3x2(1, 2, sc0, 4, 5, 6);
mat3x2 m3 = mat3x2(1, 2, 3, sc0, 5, 6);
mat3x2 m4 = mat3x2(1, 2, 3, 4, sc0, 6);
mat3x2 m5 = mat3x2(1, 2, 3, 4, 5, sc0);


void main (void)
{
    float sum_m0 = float(0);
    float sum_m1 = float(0);
    float sum_m2 = float(0);
    float sum_m3 = float(0);
    float sum_m4 = float(0);
    float sum_m5 = float(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_m0 += float(m0[i][j]);
        sum_m1 += float(m1[i][j]);
        sum_m2 += float(m2[i][j]);
        sum_m3 += float(m3[i][j]);
        sum_m4 += float(m4[i][j]);
        sum_m5 += float(m5[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[12];
} sb_out;

mat3x4 m0 = mat3x4(sc0, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);
mat3x4 m1 = mat3x4(1, sc0, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);
mat3x4 m2 = mat3x4(1, 2, sc0, 4, 5, 6, 7, 8, 9, 10, 11, 12);
mat3x4 m3 = mat3x4(1, 2, 3, sc0, 5, 6, 7, 8, 9, 10, 11, 12);
mat3x4 m4 = mat3x4(1, 2, 3, 4, sc0, 6, 7, 8, 9, 10, 11, 12);
mat3x4 m5 = mat3x4(1, 2, 3, 4, 5, sc0, 7, 8, 9, 10, 11, 12);
mat3x4 m6 = mat3x4(1, 2, 3, 4, 5, 6, sc0, 8, 9, 10, 11, 12);
mat3x4 m7 = mat3x4(1, 2, 3, 4, 5, 6, 7, sc0, 9, 10, 11, 12);
mat3x4 m8 = mat3x4(1, 2, 3, 4, 5, 6, 7, 8, sc0, 10, 11, 12);
mat3x4 m9 = mat3x4(1, 2, 3, 4, 5, 6, 7, 8, 9, sc0, 11, 12);
mat3x4 m10 = mat3x4(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, sc0, 12);
mat3x4 m11 = mat3x4(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, sc0);


void main (void)
{
    float sum_m0 = float(0);
    float sum_m1 = float(0);
    float sum_m2 = float(0);
    float sum_m3 = float(0);
    float sum_m4 = float(0);
    float sum_m5 = float(0);
    float sum_m6 = float(0);
    float sum_m7 = float(0);
    float sum_m8 = float(0);
    float sum_m9 = float(0);
    float sum_m10 = float(0);
    float sum_m11 = float(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 4; ++j)
    {
        sum_m0 += float(m0[i][j]);
        sum_m1 += float(m1[i][j]);
        sum_m2 += float(m2[i][j]);
        sum_m3 += float(m3[i][j]);
        sum_m4 += float(m4[i][j]);
        sum_m5 += float(m5[i][j]);
        sum_m6 += float(m6[i][j]);
        sum_m7 += float(m7[i][j]);
        sum_m8 += float(m8[i][j]);
        sum_m9 += float(m9[i][j]);
        sum_m10 += float(m10[i][j]);
        sum_m11 += float(m11[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;
    sb_out.result[6] = sum_m6;
    sb_out.result[7] = sum_m7;
    sb_out.result[8] = sum_m8;
    sb_out.result[9] = sum_m9;
    sb_out.result[10] = sum_m10;
    sb_out.result[11] = sum_m11;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[8];
} sb_out;

mat4x2 m0 = mat4x2(sc0, 2, 3, 4, 5, 6, 7, 8);
mat4x2 m1 = mat4x2(1, sc0, 3, 4, 5, 6, 7, 8);
mat4x2 m2 = mat4x2(1, 2, sc0, 4, 5, 6, 7, 8);
mat4x2 m3 = mat4x2(1, 2, 3, sc0, 5, 6, 7, 8);
mat4x2 m4 = mat4x2(1, 2, 3, 4, sc0, 6, 7, 8);
mat4x2 m5 = mat4x2(1, 2, 3, 4, 5, sc0, 7, 8);
mat4x2 m6 = mat4x2(1, 2, 3, 4, 5, 6, sc0, 8);
mat4x2 m7 = mat4x2(1, 2, 3, 4, 5, 6, 7, sc0);


void main (void)
{
    float sum_m0 = float(0);
    float sum_m1 = float(0);
    float sum_m2 = float(0);
    float sum_m3 = float(0);
    float sum_m4 = float(0);
    float sum_m5 = float(0);
    float sum_m6 = float(0);
    float sum_m7 = float(0);

    for (int i = 0; i < 4; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_m0 += float(m0[i][j]);
        sum_m1 += float(m1[i][j]);
        sum_m2 += float(m2[i][j]);
        sum_m3 += float(m3[i][j]);
        sum_m4 += float(m4[i][j]);
        sum_m5 += float(m5[i][j]);
        sum_m6 += float(m6[i][j]);
        sum_m7 += float(m7[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;
    sb_out.result[6] = sum_m6;
    sb_out.result[7] = sum_m7;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[12];
} sb_out;

mat4x3 m0 = mat4x3(sc0, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);
mat4x3 m1 = mat4x3(1, sc0, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);
mat4x3 m2 = mat4x3(1, 2, sc0, 4, 5, 6, 7, 8, 9, 10, 11, 12);
mat4x3 m3 = mat4x3(1, 2, 3, sc0, 5, 6, 7, 8, 9, 10, 11, 12);
mat4x3 m4 = mat4x3(1, 2, 3, 4, sc0, 6, 7, 8, 9, 10, 11, 12);
mat4x3 m5 = mat4x3(1, 2, 3, 4, 5, sc0, 7, 8, 9, 10, 11, 12);
mat4x3 m6 = mat4x3(1, 2, 3, 4, 5, 6, sc0, 8, 9, 10, 11, 12);
mat4x3 m7 = mat4x3(1, 2, 3, 4, 5, 6, 7, sc0, 9, 10, 11, 12);
mat4x3 m8 = mat4x3(1, 2, 3, 4, 5, 6, 7, 8, sc0, 10, 11, 12);
mat4x3 m9 = mat4x3(1, 2, 3, 4, 5, 6, 7, 8, 9, sc0, 11, 12);
mat4x3 m10 = mat4x3(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, sc0, 12);
mat4x3 m11 = mat4x3(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, sc0);


void main (void)
{
    float sum_m0 = float(0);
    float sum_m1 = float(0);
    float sum_m2 = float(0);
    float sum_m3 = float(0);
    float sum_m4 = float(0);
    float sum_m5 = float(0);
    float sum_m6 = float(0);
    float sum_m7 = float(0);
    float sum_m8 = float(0);
    float sum_m9 = float(0);
    float sum_m10 = float(0);
    float sum_m11 = float(0);

    for (int i = 0; i < 4; ++i)
    for (int j = 0; j < 3; ++j)
    {
        sum_m0 += float(m0[i][j]);
        sum_m1 += float(m1[i][j]);
        sum_m2 += float(m2[i][j]);
        sum_m3 += float(m3[i][j]);
        sum_m4 += float(m4[i][j]);
        sum_m5 += float(m5[i][j]);
        sum_m6 += float(m6[i][j]);
        sum_m7 += float(m7[i][j]);
        sum_m8 += float(m8[i][j]);
        sum_m9 += float(m9[i][j]);
        sum_m10 += float(m10[i][j]);
        sum_m11 += float(m11[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;
    sb_out.result[6] = sum_m6;
    sb_out.result[7] = sum_m7;
    sb_out.result[8] = sum_m8;
    sb_out.result[9] = sum_m9;
    sb_out.result[10] = sum_m10;
    sb_out.result[11] = sum_m11;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

dmat2x3 m0 = dmat2x3(sc0, 2, 3, 4, 5, 6);
dmat2x3 m1 = dmat2x3(1, sc0, 3, 4, 5, 6);
dmat2x3 m2 = dmat2x3(1, 2, sc0, 4, 5, 6);
dmat2x3 m3 = dmat2x3(1, 2, 3, sc0, 5, 6);
dmat2x3 m4 = dmat2x3(1, 2, 3, 4, sc0, 6);
dmat2x3 m5 = dmat2x3(1, 2, 3, 4, 5, sc0);


void main (void)
{
    double sum_m0 = double(0);
    double sum_m1 = double(0);
    double sum_m2 = double(0);
    double sum_m3 = double(0);
    double sum_m4 = double(0);
    double sum_m5 = double(0);

    for (int i = 0; i < 2; ++i)
    for (int j = 0; j < 3; ++j)
    {
        sum_m0 += double(m0[i][j]);
        sum_m1 += double(m1[i][j]);
        sum_m2 += double(m2[i][j]);
        sum_m3 += double(m3[i][j]);
        sum_m4 += double(m4[i][j]);
        sum_m5 += double(m5[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[8];
} sb_out;

dmat2x4 m0 = dmat2x4(sc0, 2, 3, 4, 5, 6, 7, 8);
dmat2x4 m1 = dmat2x4(1, sc0, 3, 4, 5, 6, 7, 8);
dmat2x4 m2 = dmat2x4(1, 2, sc0, 4, 5, 6, 7, 8);
dmat2x4 m3 = dmat2x4(1, 2, 3, sc0, 5, 6, 7, 8);
dmat2x4 m4 = dmat2x4(1, 2, 3, 4, sc0, 6, 7, 8);
dmat2x4 m5 = dmat2x4(1, 2, 3, 4, 5, sc0, 7, 8);
dmat2x4 m6 = dmat2x4(1, 2, 3, 4, 5, 6, sc0, 8);
dmat2x4 m7 = dmat2x4(1, 2, 3, 4, 5, 6, 7, sc0);


void main (void)
{
    double sum_m0 = double(0);
    double sum_m1 = double(0);
    double sum_m2 = double(0);
    double sum_m3 = double(0);
    double sum_m4 = double(0);
    double sum_m5 = double(0);
    double sum_m6 = double(0);
    double sum_m7 = double(0);

    for (int i = 0; i < 2; ++i)
    for (int j = 0; j < 4; ++j)
    {
        sum_m0 += double(m0[i][j]);
        sum_m1 += double(m1[i][j]);
        sum_m2 += double(m2[i][j]);
        sum_m3 += double(m3[i][j]);
        sum_m4 += double(m4[i][j]);
        sum_m5 += double(m5[i][j]);
        sum_m6 += double(m6[i][j]);
        sum_m7 += double(m7[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;
    sb_out.result[6] = sum_m6;
    sb_out.result[7] = sum_m7;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

dmat3x2 m0 = dmat3x2(sc0, 2, 3, 4, 5, 6);
dmat3x2 m1 = dmat3x2(1, sc0, 3, 4, 5, 6);
dmat3x2 m2 = dmat3x2(1, 2, sc0, 4, 5, 6);
dmat3x2 m3 = dmat3x2(1, 2, 3, sc0, 5, 6);
dmat3x2 m4 = dmat3x2(1, 2, 3, 4, sc0, 6);
dmat3x2 m5 = dmat3x2(1, 2, 3, 4, 5, sc0);


void main (void)
{
    double sum_m0 = double(0);
    double sum_m1 = double(0);
    double sum_m2 = double(0);
    double sum_m3 = double(0);
    double sum_m4 = double(0);
    double sum_m5 = double(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_m0 += double(m0[i][j]);
        sum_m1 += double(m1[i][j]);
        sum_m2 += double(m2[i][j]);
        sum_m3 += double(m3[i][j]);
        sum_m4 += double(m4[i][j]);
        sum_m5 += double(m5[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[12];
} sb_out;

dmat3x4 m0 = dmat3x4(sc0, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);
dmat3x4 m1 = dmat3x4(1, sc0, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);
dmat3x4 m2 = dmat3x4(1, 2, sc0, 4, 5, 6, 7, 8, 9, 10, 11, 12);
dmat3x4 m3 = dmat3x4(1, 2, 3, sc0, 5, 6, 7, 8, 9, 10, 11, 12);
dmat3x4 m4 = dmat3x4(1, 2, 3, 4, sc0, 6, 7, 8, 9, 10, 11, 12);
dmat3x4 m5 = dmat3x4(1, 2, 3, 4, 5, sc0, 7, 8, 9, 10, 11, 12);
dmat3x4 m6 = dmat3x4(1, 2, 3, 4, 5, 6, sc0, 8, 9, 10, 11, 12);
dmat3x4 m7 = dmat3x4(1, 2, 3, 4, 5, 6, 7, sc0, 9, 10, 11, 12);
dmat3x4 m8 = dmat3x4(1, 2, 3, 4, 5, 6, 7, 8, sc0, 10, 11, 12);
dmat3x4 m9 = dmat3x4(1, 2, 3, 4, 5, 6, 7, 8, 9, sc0, 11, 12);
dmat3x4 m10 = dmat3x4(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, sc0, 12);
dmat3x4 m11 = dmat3x4(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, sc0);


void main (void)
{
    double sum_m0 = double(0);
    double sum_m1 = double(0);
    double sum_m2 = double(0);
    double sum_m3 = double(0);
    double sum_m4 = double(0);
    double sum_m5 = double(0);
    double sum_m6 = double(0);
    double sum_m7 = double(0);
    double sum_m8 = double(0);
    double sum_m9 = double(0);
    double sum_m10 = double(0);
    double sum_m11 = double(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 4; ++j)
    {
        sum_m0 += double(m0[i][j]);
        sum_m1 += double(m1[i][j]);
        sum_m2 += double(m2[i][j]);
        sum_m3 += double(m3[i][j]);
        sum_m4 += double(m4[i][j]);
        sum_m5 += double(m5[i][j]);
        sum_m6 += double(m6[i][j]);
        sum_m7 += double(m7[i][j]);
        sum_m8 += double(m8[i][j]);
        sum_m9 += double(m9[i][j]);
        sum_m10 += double(m10[i][j]);
        sum_m11 += double(m11[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;
    sb_out.result[6] = sum_m6;
    sb_out.result[7] = sum_m7;
    sb_out.result[8] = sum_m8;
    sb_out.result[9] = sum_m9;
    sb_out.result[10] = sum_m10;
    sb_out.result[11] = sum_m11;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[8];
} sb_out;

dmat4x2 m0 = dmat4x2(sc0, 2, 3, 4, 5, 6, 7, 8);
dmat4x2 m1 = dmat4x2(1, sc0, 3, 4, 5, 6, 7, 8);
dmat4x2 m2 = dmat4x2(1, 2, sc0, 4, 5, 6, 7, 8);
dmat4x2 m3 = dmat4x2(1, 2, 3, sc0, 5, 6, 7, 8);
dmat4x2 m4 = dmat4x2(1, 2, 3, 4, sc0, 6, 7, 8);
dmat4x2 m5 = dmat4x2(1, 2, 3, 4, 5, sc0, 7, 8);
dmat4x2 m6 = dmat4x2(1, 2, 3, 4, 5, 6, sc0, 8);
dmat4x2 m7 = dmat4x2(1, 2, 3, 4, 5, 6, 7, sc0);


void main (void)
{
    double sum_m0 = double(0);
    double sum_m1 = double(0);
    double sum_m2 = double(0);
    double sum_m3 = double(0);
    double sum_m4 = double(0);
    double sum_m5 = double(0);
    double sum_m6 = double(0);
    double sum_m7 = double(0);

    for (int i = 0; i < 4; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_m0 += double(m0[i][j]);
        sum_m1 += double(m1[i][j]);
        sum_m2 += double(m2[i][j]);
        sum_m3 += double(m3[i][j]);
        sum_m4 += double(m4[i][j]);
        sum_m5 += double(m5[i][j]);
        sum_m6 += double(m6[i][j]);
        sum_m7 += double(m7[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;
    sb_out.result[6] = sum_m6;
    sb_out.result[7] = sum_m7;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[12];
} sb_out;

dmat4x3 m0 = dmat4x3(sc0, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);
dmat4x3 m1 = dmat4x3(1, sc0, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);
dmat4x3 m2 = dmat4x3(1, 2, sc0, 4, 5, 6, 7, 8, 9, 10, 11, 12);
dmat4x3 m3 = dmat4x3(1, 2, 3, sc0, 5, 6, 7, 8, 9, 10, 11, 12);
dmat4x3 m4 = dmat4x3(1, 2, 3, 4, sc0, 6, 7, 8, 9, 10, 11, 12);
dmat4x3 m5 = dmat4x3(1, 2, 3, 4, 5, sc0, 7, 8, 9, 10, 11, 12);
dmat4x3 m6 = dmat4x3(1, 2, 3, 4, 5, 6, sc0, 8, 9, 10, 11, 12);
dmat4x3 m7 = dmat4x3(1, 2, 3, 4, 5, 6, 7, sc0, 9, 10, 11, 12);
dmat4x3 m8 = dmat4x3(1, 2, 3, 4, 5, 6, 7, 8, sc0, 10, 11, 12);
dmat4x3 m9 = dmat4x3(1, 2, 3, 4, 5, 6, 7, 8, 9, sc0, 11, 12);
dmat4x3 m10 = dmat4x3(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, sc0, 12);
dmat4x3 m11 = dmat4x3(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, sc0);


void main (void)
{
    double sum_m0 = double(0);
    double sum_m1 = double(0);
    double sum_m2 = double(0);
    double sum_m3 = double(0);
    double sum_m4 = double(0);
    double sum_m5 = double(0);
    double sum_m6 = double(0);
    double sum_m7 = double(0);
    double sum_m8 = double(0);
    double sum_m9 = double(0);
    double sum_m10 = double(0);
    double sum_m11 = double(0);

    for (int i = 0; i < 4; ++i)
    for (int j = 0; j < 3; ++j)
    {
        sum_m0 += double(m0[i][j]);
        sum_m1 += double(m1[i][j]);
        sum_m2 += double(m2[i][j]);
        sum_m3 += double(m3[i][j]);
        sum_m4 += double(m4[i][j]);
        sum_m5 += double(m5[i][j]);
        sum_m6 += double(m6[i][j]);
        sum_m7 += double(m7[i][j]);
        sum_m8 += double(m8[i][j]);
        sum_m9 += double(m9[i][j]);
        sum_m10 += double(m10[i][j]);
        sum_m11 += double(m11[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;
    sb_out.result[6] = sum_m6;
    sb_out.result[7] = sum_m7;
    sb_out.result[8] = sum_m8;
    sb_out.result[9] = sum_m9;
    sb_out.result[10] = sum_m10;
    sb_out.result[11] = sum_m11;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[3];
} sb_out;

float a0[3] = float[3](sc0, 2, 3);
float a1[3] = float[3](1, sc0, 3);
float a2[3] = float[3](1, 2, sc0);


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += float(a0[i]);
        sum_a1 += float(a1[i]);
        sum_a2 += float(a2[i]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[3];
} sb_out;

mat2x3 a0[3] = mat2x3[3](mat2x3(sc0), mat2x3(2), mat2x3(3));
mat2x3 a1[3] = mat2x3[3](mat2x3(1), mat2x3(sc0), mat2x3(3));
mat2x3 a2[3] = mat2x3[3](mat2x3(1), mat2x3(2), mat2x3(sc0));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += float(a0[i][0][0]);
        sum_a1 += float(a1[i][0][0]);
        sum_a2 += float(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[3];
} sb_out;

mat2x4 a0[3] = mat2x4[3](mat2x4(sc0), mat2x4(2), mat2x4(3));
mat2x4 a1[3] = mat2x4[3](mat2x4(1), mat2x4(sc0), mat2x4(3));
mat2x4 a2[3] = mat2x4[3](mat2x4(1), mat2x4(2), mat2x4(sc0));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += float(a0[i][0][0]);
        sum_a1 += float(a1[i][0][0]);
        sum_a2 += float(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[3];
} sb_out;

mat3x2 a0[3] = mat3x2[3](mat3x2(sc0), mat3x2(2), mat3x2(3));
mat3x2 a1[3] = mat3x2[3](mat3x2(1), mat3x2(sc0), mat3x2(3));
mat3x2 a2[3] = mat3x2[3](mat3x2(1), mat3x2(2), mat3x2(sc0));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += float(a0[i][0][0]);
        sum_a1 += float(a1[i][0][0]);
        sum_a2 += float(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[3];
} sb_out;

mat3x4 a0[3] = mat3x4[3](mat3x4(sc0), mat3x4(2), mat3x4(3));
mat3x4 a1[3] = mat3x4[3](mat3x4(1), mat3x4(sc0), mat3x4(3));
mat3x4 a2[3] = mat3x4[3](mat3x4(1), mat3x4(2), mat3x4(sc0));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += float(a0[i][0][0]);
        sum_a1 += float(a1[i][0][0]);
        sum_a2 += float(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[3];
} sb_out;

mat4x2 a0[3] = mat4x2[3](mat4x2(sc0), mat4x2(2), mat4x2(3));
mat4x2 a1[3] = mat4x2[3](mat4x2(1), mat4x2(sc0), mat4x2(3));
mat4x2 a2[3] = mat4x2[3](mat4x2(1), mat4x2(2), mat4x2(sc0));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += float(a0[i][0][0]);
        sum_a1 += float(a1[i][0][0]);
        sum_a2 += float(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[3];
} sb_out;

mat4x3 a0[3] = mat4x3[3](mat4x3(sc0), mat4x3(2), mat4x3(3));
mat4x3 a1[3] = mat4x3[3](mat4x3(1), mat4x3(sc0), mat4x3(3));
mat4x3 a2[3] = mat4x3[3](mat4x3(1), mat4x3(2), mat4x3(sc0));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += float(a0[i][0][0]);
        sum_a1 += float(a1[i][0][0]);
        sum_a2 += float(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[3];
} sb_out;

double a0[3] = double[3](sc0, 2, 3);
double a1[3] = double[3](1, sc0, 3);
double a2[3] = double[3](1, 2, sc0);


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += double(a0[i]);
        sum_a1 += double(a1[i]);
        sum_a2 += double(a2[i]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[3];
} sb_out;

dmat2x3 a0[3] = dmat2x3[3](dmat2x3(sc0), dmat2x3(2), dmat2x3(3));
dmat2x3 a1[3] = dmat2x3[3](dmat2x3(1), dmat2x3(sc0), dmat2x3(3));
dmat2x3 a2[3] = dmat2x3[3](dmat2x3(1), dmat2x3(2), dmat2x3(sc0));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += double(a0[i][0][0]);
        sum_a1 += double(a1[i][0][0]);
        sum_a2 += double(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[3];
} sb_out;

dmat2x4 a0[3] = dmat2x4[3](dmat2x4(sc0), dmat2x4(2), dmat2x4(3));
dmat2x4 a1[3] = dmat2x4[3](dmat2x4(1), dmat2x4(sc0), dmat2x4(3));
dmat2x4 a2[3] = dmat2x4[3](dmat2x4(1), dmat2x4(2), dmat2x4(sc0));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += double(a0[i][0][0]);
        sum_a1 += double(a1[i][0][0]);
        sum_a2 += double(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[3];
} sb_out;

dmat3x2 a0[3] = dmat3x2[3](dmat3x2(sc0), dmat3x2(2), dmat3x2(3));
dmat3x2 a1[3] = dmat3x2[3](dmat3x2(1), dmat3x2(sc0), dmat3x2(3));
dmat3x2 a2[3] = dmat3x2[3](dmat3x2(1), dmat3x2(2), dmat3x2(sc0));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += double(a0[i][0][0]);
        sum_a1 += double(a1[i][0][0]);
        sum_a2 += double(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[3];
} sb_out;

dmat3x4 a0[3] = dmat3x4[3](dmat3x4(sc0), dmat3x4(2), dmat3x4(3));
dmat3x4 a1[3] = dmat3x4[3](dmat3x4(1), dmat3x4(sc0), dmat3x4(3));
dmat3x4 a2[3] = dmat3x4[3](dmat3x4(1), dmat3x4(2), dmat3x4(sc0));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += double(a0[i][0][0]);
        sum_a1 += double(a1[i][0][0]);
        sum_a2 += double(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[3];
} sb_out;

dmat4x2 a0[3] = dmat4x2[3](dmat4x2(sc0), dmat4x2(2), dmat4x2(3));
dmat4x2 a1[3] = dmat4x2[3](dmat4x2(1), dmat4x2(sc0), dmat4x2(3));
dmat4x2 a2[3] = dmat4x2[3](dmat4x2(1), dmat4x2(2), dmat4x2(sc0));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += double(a0[i][0][0]);
        sum_a1 += double(a1[i][0][0]);
        sum_a2 += double(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[3];
} sb_out;

dmat4x3 a0[3] = dmat4x3[3](dmat4x3(sc0), dmat4x3(2), dmat4x3(3));
dmat4x3 a1[3] = dmat4x3[3](dmat4x3(1), dmat4x3(sc0), dmat4x3(3));
dmat4x3 a2[3] = dmat4x3[3](dmat4x3(1), dmat4x3(2), dmat4x3(sc0));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += double(a0[i][0][0]);
        sum_a1 += double(a1[i][0][0]);
        sum_a2 += double(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int sc0 = int(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result[3];
} sb_out;

int a0[3] = int[3](sc0, 2, 3);
int a1[3] = int[3](1, sc0, 3);
int a2[3] = int[3](1, 2, sc0);


void main (void)
{
    int sum_a0 = int(0);
    int sum_a1 = int(0);
    int sum_a2 = int(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += int(a0[i]);
        sum_a1 += int(a1[i]);
        sum_a2 += int(a2[i]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const uint sc0 = uint(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint result[3];
} sb_out;

uint a0[3] = uint[3](sc0, 2, 3);
uint a1[3] = uint[3](1, sc0, 3);
uint a2[3] = uint[3](1, 2, sc0);


void main (void)
{
    uint sum_a0 = uint(0);
    uint sum_a1 = uint(0);
    uint sum_a2 = uint(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += uint(a0[i]);
        sum_a1 += uint(a1[i]);
        sum_a2 += uint(a2[i]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const bool sc0 = bool(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result[3];
} sb_out;

bool a0[3] = bool[3](sc0, true, true);
bool a1[3] = bool[3](true, sc0, true);
bool a2[3] = bool[3](true, true, sc0);


void main (void)
{
    int sum_a0 = int(0);
    int sum_a1 = int(0);
    int sum_a2 = int(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += int(a0[i]);
        sum_a1 += int(a1[i]);
        sum_a2 += int(a2[i]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

float a0[3][2] = float[3][2](float[2](sc0, 2),
                                    float[2](3, 4),
                                    float[2](5, 6));
float a1[3][2] = float[3][2](float[2](1, sc0),
                                    float[2](3, 4),
                                    float[2](5, 6));
float a2[3][2] = float[3][2](float[2](1, 2),
                                    float[2](sc0, 4),
                                    float[2](5, 6));
float a3[3][2] = float[3][2](float[2](1, 2),
                                    float[2](3, sc0),
                                    float[2](5, 6));
float a4[3][2] = float[3][2](float[2](1, 2),
                                    float[2](3, 4),
                                    float[2](sc0, 6));
float a5[3][2] = float[3][2](float[2](1, 2),
                                    float[2](3, 4),
                                    float[2](5, sc0));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);
    float sum_a3 = float(0);
    float sum_a4 = float(0);
    float sum_a5 = float(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += float(a0[i][j]);
        sum_a1 += float(a1[i][j]);
        sum_a2 += float(a2[i][j]);
        sum_a3 += float(a3[i][j]);
        sum_a4 += float(a4[i][j]);
        sum_a5 += float(a5[i][j]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

mat2x3 a0[3][2] = mat2x3[3][2](mat2x3[2](mat2x3(sc0), mat2x3(2)),
                                    mat2x3[2](mat2x3(3), mat2x3(4)),
                                    mat2x3[2](mat2x3(5), mat2x3(6)));
mat2x3 a1[3][2] = mat2x3[3][2](mat2x3[2](mat2x3(1), mat2x3(sc0)),
                                    mat2x3[2](mat2x3(3), mat2x3(4)),
                                    mat2x3[2](mat2x3(5), mat2x3(6)));
mat2x3 a2[3][2] = mat2x3[3][2](mat2x3[2](mat2x3(1), mat2x3(2)),
                                    mat2x3[2](mat2x3(sc0), mat2x3(4)),
                                    mat2x3[2](mat2x3(5), mat2x3(6)));
mat2x3 a3[3][2] = mat2x3[3][2](mat2x3[2](mat2x3(1), mat2x3(2)),
                                    mat2x3[2](mat2x3(3), mat2x3(sc0)),
                                    mat2x3[2](mat2x3(5), mat2x3(6)));
mat2x3 a4[3][2] = mat2x3[3][2](mat2x3[2](mat2x3(1), mat2x3(2)),
                                    mat2x3[2](mat2x3(3), mat2x3(4)),
                                    mat2x3[2](mat2x3(sc0), mat2x3(6)));
mat2x3 a5[3][2] = mat2x3[3][2](mat2x3[2](mat2x3(1), mat2x3(2)),
                                    mat2x3[2](mat2x3(3), mat2x3(4)),
                                    mat2x3[2](mat2x3(5), mat2x3(sc0)));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);
    float sum_a3 = float(0);
    float sum_a4 = float(0);
    float sum_a5 = float(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += float(a0[i][j][0][0]);
        sum_a1 += float(a1[i][j][0][0]);
        sum_a2 += float(a2[i][j][0][0]);
        sum_a3 += float(a3[i][j][0][0]);
        sum_a4 += float(a4[i][j][0][0]);
        sum_a5 += float(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

mat2x4 a0[3][2] = mat2x4[3][2](mat2x4[2](mat2x4(sc0), mat2x4(2)),
                                    mat2x4[2](mat2x4(3), mat2x4(4)),
                                    mat2x4[2](mat2x4(5), mat2x4(6)));
mat2x4 a1[3][2] = mat2x4[3][2](mat2x4[2](mat2x4(1), mat2x4(sc0)),
                                    mat2x4[2](mat2x4(3), mat2x4(4)),
                                    mat2x4[2](mat2x4(5), mat2x4(6)));
mat2x4 a2[3][2] = mat2x4[3][2](mat2x4[2](mat2x4(1), mat2x4(2)),
                                    mat2x4[2](mat2x4(sc0), mat2x4(4)),
                                    mat2x4[2](mat2x4(5), mat2x4(6)));
mat2x4 a3[3][2] = mat2x4[3][2](mat2x4[2](mat2x4(1), mat2x4(2)),
                                    mat2x4[2](mat2x4(3), mat2x4(sc0)),
                                    mat2x4[2](mat2x4(5), mat2x4(6)));
mat2x4 a4[3][2] = mat2x4[3][2](mat2x4[2](mat2x4(1), mat2x4(2)),
                                    mat2x4[2](mat2x4(3), mat2x4(4)),
                                    mat2x4[2](mat2x4(sc0), mat2x4(6)));
mat2x4 a5[3][2] = mat2x4[3][2](mat2x4[2](mat2x4(1), mat2x4(2)),
                                    mat2x4[2](mat2x4(3), mat2x4(4)),
                                    mat2x4[2](mat2x4(5), mat2x4(sc0)));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);
    float sum_a3 = float(0);
    float sum_a4 = float(0);
    float sum_a5 = float(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += float(a0[i][j][0][0]);
        sum_a1 += float(a1[i][j][0][0]);
        sum_a2 += float(a2[i][j][0][0]);
        sum_a3 += float(a3[i][j][0][0]);
        sum_a4 += float(a4[i][j][0][0]);
        sum_a5 += float(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

mat3x2 a0[3][2] = mat3x2[3][2](mat3x2[2](mat3x2(sc0), mat3x2(2)),
                                    mat3x2[2](mat3x2(3), mat3x2(4)),
                                    mat3x2[2](mat3x2(5), mat3x2(6)));
mat3x2 a1[3][2] = mat3x2[3][2](mat3x2[2](mat3x2(1), mat3x2(sc0)),
                                    mat3x2[2](mat3x2(3), mat3x2(4)),
                                    mat3x2[2](mat3x2(5), mat3x2(6)));
mat3x2 a2[3][2] = mat3x2[3][2](mat3x2[2](mat3x2(1), mat3x2(2)),
                                    mat3x2[2](mat3x2(sc0), mat3x2(4)),
                                    mat3x2[2](mat3x2(5), mat3x2(6)));
mat3x2 a3[3][2] = mat3x2[3][2](mat3x2[2](mat3x2(1), mat3x2(2)),
                                    mat3x2[2](mat3x2(3), mat3x2(sc0)),
                                    mat3x2[2](mat3x2(5), mat3x2(6)));
mat3x2 a4[3][2] = mat3x2[3][2](mat3x2[2](mat3x2(1), mat3x2(2)),
                                    mat3x2[2](mat3x2(3), mat3x2(4)),
                                    mat3x2[2](mat3x2(sc0), mat3x2(6)));
mat3x2 a5[3][2] = mat3x2[3][2](mat3x2[2](mat3x2(1), mat3x2(2)),
                                    mat3x2[2](mat3x2(3), mat3x2(4)),
                                    mat3x2[2](mat3x2(5), mat3x2(sc0)));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);
    float sum_a3 = float(0);
    float sum_a4 = float(0);
    float sum_a5 = float(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += float(a0[i][j][0][0]);
        sum_a1 += float(a1[i][j][0][0]);
        sum_a2 += float(a2[i][j][0][0]);
        sum_a3 += float(a3[i][j][0][0]);
        sum_a4 += float(a4[i][j][0][0]);
        sum_a5 += float(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

mat3x4 a0[3][2] = mat3x4[3][2](mat3x4[2](mat3x4(sc0), mat3x4(2)),
                                    mat3x4[2](mat3x4(3), mat3x4(4)),
                                    mat3x4[2](mat3x4(5), mat3x4(6)));
mat3x4 a1[3][2] = mat3x4[3][2](mat3x4[2](mat3x4(1), mat3x4(sc0)),
                                    mat3x4[2](mat3x4(3), mat3x4(4)),
                                    mat3x4[2](mat3x4(5), mat3x4(6)));
mat3x4 a2[3][2] = mat3x4[3][2](mat3x4[2](mat3x4(1), mat3x4(2)),
                                    mat3x4[2](mat3x4(sc0), mat3x4(4)),
                                    mat3x4[2](mat3x4(5), mat3x4(6)));
mat3x4 a3[3][2] = mat3x4[3][2](mat3x4[2](mat3x4(1), mat3x4(2)),
                                    mat3x4[2](mat3x4(3), mat3x4(sc0)),
                                    mat3x4[2](mat3x4(5), mat3x4(6)));
mat3x4 a4[3][2] = mat3x4[3][2](mat3x4[2](mat3x4(1), mat3x4(2)),
                                    mat3x4[2](mat3x4(3), mat3x4(4)),
                                    mat3x4[2](mat3x4(sc0), mat3x4(6)));
mat3x4 a5[3][2] = mat3x4[3][2](mat3x4[2](mat3x4(1), mat3x4(2)),
                                    mat3x4[2](mat3x4(3), mat3x4(4)),
                                    mat3x4[2](mat3x4(5), mat3x4(sc0)));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);
    float sum_a3 = float(0);
    float sum_a4 = float(0);
    float sum_a5 = float(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += float(a0[i][j][0][0]);
        sum_a1 += float(a1[i][j][0][0]);
        sum_a2 += float(a2[i][j][0][0]);
        sum_a3 += float(a3[i][j][0][0]);
        sum_a4 += float(a4[i][j][0][0]);
        sum_a5 += float(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

mat4x2 a0[3][2] = mat4x2[3][2](mat4x2[2](mat4x2(sc0), mat4x2(2)),
                                    mat4x2[2](mat4x2(3), mat4x2(4)),
                                    mat4x2[2](mat4x2(5), mat4x2(6)));
mat4x2 a1[3][2] = mat4x2[3][2](mat4x2[2](mat4x2(1), mat4x2(sc0)),
                                    mat4x2[2](mat4x2(3), mat4x2(4)),
                                    mat4x2[2](mat4x2(5), mat4x2(6)));
mat4x2 a2[3][2] = mat4x2[3][2](mat4x2[2](mat4x2(1), mat4x2(2)),
                                    mat4x2[2](mat4x2(sc0), mat4x2(4)),
                                    mat4x2[2](mat4x2(5), mat4x2(6)));
mat4x2 a3[3][2] = mat4x2[3][2](mat4x2[2](mat4x2(1), mat4x2(2)),
                                    mat4x2[2](mat4x2(3), mat4x2(sc0)),
                                    mat4x2[2](mat4x2(5), mat4x2(6)));
mat4x2 a4[3][2] = mat4x2[3][2](mat4x2[2](mat4x2(1), mat4x2(2)),
                                    mat4x2[2](mat4x2(3), mat4x2(4)),
                                    mat4x2[2](mat4x2(sc0), mat4x2(6)));
mat4x2 a5[3][2] = mat4x2[3][2](mat4x2[2](mat4x2(1), mat4x2(2)),
                                    mat4x2[2](mat4x2(3), mat4x2(4)),
                                    mat4x2[2](mat4x2(5), mat4x2(sc0)));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);
    float sum_a3 = float(0);
    float sum_a4 = float(0);
    float sum_a5 = float(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += float(a0[i][j][0][0]);
        sum_a1 += float(a1[i][j][0][0]);
        sum_a2 += float(a2[i][j][0][0]);
        sum_a3 += float(a3[i][j][0][0]);
        sum_a4 += float(a4[i][j][0][0]);
        sum_a5 += float(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

mat4x3 a0[3][2] = mat4x3[3][2](mat4x3[2](mat4x3(sc0), mat4x3(2)),
                                    mat4x3[2](mat4x3(3), mat4x3(4)),
                                    mat4x3[2](mat4x3(5), mat4x3(6)));
mat4x3 a1[3][2] = mat4x3[3][2](mat4x3[2](mat4x3(1), mat4x3(sc0)),
                                    mat4x3[2](mat4x3(3), mat4x3(4)),
                                    mat4x3[2](mat4x3(5), mat4x3(6)));
mat4x3 a2[3][2] = mat4x3[3][2](mat4x3[2](mat4x3(1), mat4x3(2)),
                                    mat4x3[2](mat4x3(sc0), mat4x3(4)),
                                    mat4x3[2](mat4x3(5), mat4x3(6)));
mat4x3 a3[3][2] = mat4x3[3][2](mat4x3[2](mat4x3(1), mat4x3(2)),
                                    mat4x3[2](mat4x3(3), mat4x3(sc0)),
                                    mat4x3[2](mat4x3(5), mat4x3(6)));
mat4x3 a4[3][2] = mat4x3[3][2](mat4x3[2](mat4x3(1), mat4x3(2)),
                                    mat4x3[2](mat4x3(3), mat4x3(4)),
                                    mat4x3[2](mat4x3(sc0), mat4x3(6)));
mat4x3 a5[3][2] = mat4x3[3][2](mat4x3[2](mat4x3(1), mat4x3(2)),
                                    mat4x3[2](mat4x3(3), mat4x3(4)),
                                    mat4x3[2](mat4x3(5), mat4x3(sc0)));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);
    float sum_a3 = float(0);
    float sum_a4 = float(0);
    float sum_a5 = float(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += float(a0[i][j][0][0]);
        sum_a1 += float(a1[i][j][0][0]);
        sum_a2 += float(a2[i][j][0][0]);
        sum_a3 += float(a3[i][j][0][0]);
        sum_a4 += float(a4[i][j][0][0]);
        sum_a5 += float(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

double a0[3][2] = double[3][2](double[2](sc0, 2),
                                    double[2](3, 4),
                                    double[2](5, 6));
double a1[3][2] = double[3][2](double[2](1, sc0),
                                    double[2](3, 4),
                                    double[2](5, 6));
double a2[3][2] = double[3][2](double[2](1, 2),
                                    double[2](sc0, 4),
                                    double[2](5, 6));
double a3[3][2] = double[3][2](double[2](1, 2),
                                    double[2](3, sc0),
                                    double[2](5, 6));
double a4[3][2] = double[3][2](double[2](1, 2),
                                    double[2](3, 4),
                                    double[2](sc0, 6));
double a5[3][2] = double[3][2](double[2](1, 2),
                                    double[2](3, 4),
                                    double[2](5, sc0));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);
    double sum_a3 = double(0);
    double sum_a4 = double(0);
    double sum_a5 = double(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += double(a0[i][j]);
        sum_a1 += double(a1[i][j]);
        sum_a2 += double(a2[i][j]);
        sum_a3 += double(a3[i][j]);
        sum_a4 += double(a4[i][j]);
        sum_a5 += double(a5[i][j]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

dmat2x3 a0[3][2] = dmat2x3[3][2](dmat2x3[2](dmat2x3(sc0), dmat2x3(2)),
                                    dmat2x3[2](dmat2x3(3), dmat2x3(4)),
                                    dmat2x3[2](dmat2x3(5), dmat2x3(6)));
dmat2x3 a1[3][2] = dmat2x3[3][2](dmat2x3[2](dmat2x3(1), dmat2x3(sc0)),
                                    dmat2x3[2](dmat2x3(3), dmat2x3(4)),
                                    dmat2x3[2](dmat2x3(5), dmat2x3(6)));
dmat2x3 a2[3][2] = dmat2x3[3][2](dmat2x3[2](dmat2x3(1), dmat2x3(2)),
                                    dmat2x3[2](dmat2x3(sc0), dmat2x3(4)),
                                    dmat2x3[2](dmat2x3(5), dmat2x3(6)));
dmat2x3 a3[3][2] = dmat2x3[3][2](dmat2x3[2](dmat2x3(1), dmat2x3(2)),
                                    dmat2x3[2](dmat2x3(3), dmat2x3(sc0)),
                                    dmat2x3[2](dmat2x3(5), dmat2x3(6)));
dmat2x3 a4[3][2] = dmat2x3[3][2](dmat2x3[2](dmat2x3(1), dmat2x3(2)),
                                    dmat2x3[2](dmat2x3(3), dmat2x3(4)),
                                    dmat2x3[2](dmat2x3(sc0), dmat2x3(6)));
dmat2x3 a5[3][2] = dmat2x3[3][2](dmat2x3[2](dmat2x3(1), dmat2x3(2)),
                                    dmat2x3[2](dmat2x3(3), dmat2x3(4)),
                                    dmat2x3[2](dmat2x3(5), dmat2x3(sc0)));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);
    double sum_a3 = double(0);
    double sum_a4 = double(0);
    double sum_a5 = double(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += double(a0[i][j][0][0]);
        sum_a1 += double(a1[i][j][0][0]);
        sum_a2 += double(a2[i][j][0][0]);
        sum_a3 += double(a3[i][j][0][0]);
        sum_a4 += double(a4[i][j][0][0]);
        sum_a5 += double(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

dmat2x4 a0[3][2] = dmat2x4[3][2](dmat2x4[2](dmat2x4(sc0), dmat2x4(2)),
                                    dmat2x4[2](dmat2x4(3), dmat2x4(4)),
                                    dmat2x4[2](dmat2x4(5), dmat2x4(6)));
dmat2x4 a1[3][2] = dmat2x4[3][2](dmat2x4[2](dmat2x4(1), dmat2x4(sc0)),
                                    dmat2x4[2](dmat2x4(3), dmat2x4(4)),
                                    dmat2x4[2](dmat2x4(5), dmat2x4(6)));
dmat2x4 a2[3][2] = dmat2x4[3][2](dmat2x4[2](dmat2x4(1), dmat2x4(2)),
                                    dmat2x4[2](dmat2x4(sc0), dmat2x4(4)),
                                    dmat2x4[2](dmat2x4(5), dmat2x4(6)));
dmat2x4 a3[3][2] = dmat2x4[3][2](dmat2x4[2](dmat2x4(1), dmat2x4(2)),
                                    dmat2x4[2](dmat2x4(3), dmat2x4(sc0)),
                                    dmat2x4[2](dmat2x4(5), dmat2x4(6)));
dmat2x4 a4[3][2] = dmat2x4[3][2](dmat2x4[2](dmat2x4(1), dmat2x4(2)),
                                    dmat2x4[2](dmat2x4(3), dmat2x4(4)),
                                    dmat2x4[2](dmat2x4(sc0), dmat2x4(6)));
dmat2x4 a5[3][2] = dmat2x4[3][2](dmat2x4[2](dmat2x4(1), dmat2x4(2)),
                                    dmat2x4[2](dmat2x4(3), dmat2x4(4)),
                                    dmat2x4[2](dmat2x4(5), dmat2x4(sc0)));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);
    double sum_a3 = double(0);
    double sum_a4 = double(0);
    double sum_a5 = double(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += double(a0[i][j][0][0]);
        sum_a1 += double(a1[i][j][0][0]);
        sum_a2 += double(a2[i][j][0][0]);
        sum_a3 += double(a3[i][j][0][0]);
        sum_a4 += double(a4[i][j][0][0]);
        sum_a5 += double(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

dmat3x2 a0[3][2] = dmat3x2[3][2](dmat3x2[2](dmat3x2(sc0), dmat3x2(2)),
                                    dmat3x2[2](dmat3x2(3), dmat3x2(4)),
                                    dmat3x2[2](dmat3x2(5), dmat3x2(6)));
dmat3x2 a1[3][2] = dmat3x2[3][2](dmat3x2[2](dmat3x2(1), dmat3x2(sc0)),
                                    dmat3x2[2](dmat3x2(3), dmat3x2(4)),
                                    dmat3x2[2](dmat3x2(5), dmat3x2(6)));
dmat3x2 a2[3][2] = dmat3x2[3][2](dmat3x2[2](dmat3x2(1), dmat3x2(2)),
                                    dmat3x2[2](dmat3x2(sc0), dmat3x2(4)),
                                    dmat3x2[2](dmat3x2(5), dmat3x2(6)));
dmat3x2 a3[3][2] = dmat3x2[3][2](dmat3x2[2](dmat3x2(1), dmat3x2(2)),
                                    dmat3x2[2](dmat3x2(3), dmat3x2(sc0)),
                                    dmat3x2[2](dmat3x2(5), dmat3x2(6)));
dmat3x2 a4[3][2] = dmat3x2[3][2](dmat3x2[2](dmat3x2(1), dmat3x2(2)),
                                    dmat3x2[2](dmat3x2(3), dmat3x2(4)),
                                    dmat3x2[2](dmat3x2(sc0), dmat3x2(6)));
dmat3x2 a5[3][2] = dmat3x2[3][2](dmat3x2[2](dmat3x2(1), dmat3x2(2)),
                                    dmat3x2[2](dmat3x2(3), dmat3x2(4)),
                                    dmat3x2[2](dmat3x2(5), dmat3x2(sc0)));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);
    double sum_a3 = double(0);
    double sum_a4 = double(0);
    double sum_a5 = double(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += double(a0[i][j][0][0]);
        sum_a1 += double(a1[i][j][0][0]);
        sum_a2 += double(a2[i][j][0][0]);
        sum_a3 += double(a3[i][j][0][0]);
        sum_a4 += double(a4[i][j][0][0]);
        sum_a5 += double(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

dmat3x4 a0[3][2] = dmat3x4[3][2](dmat3x4[2](dmat3x4(sc0), dmat3x4(2)),
                                    dmat3x4[2](dmat3x4(3), dmat3x4(4)),
                                    dmat3x4[2](dmat3x4(5), dmat3x4(6)));
dmat3x4 a1[3][2] = dmat3x4[3][2](dmat3x4[2](dmat3x4(1), dmat3x4(sc0)),
                                    dmat3x4[2](dmat3x4(3), dmat3x4(4)),
                                    dmat3x4[2](dmat3x4(5), dmat3x4(6)));
dmat3x4 a2[3][2] = dmat3x4[3][2](dmat3x4[2](dmat3x4(1), dmat3x4(2)),
                                    dmat3x4[2](dmat3x4(sc0), dmat3x4(4)),
                                    dmat3x4[2](dmat3x4(5), dmat3x4(6)));
dmat3x4 a3[3][2] = dmat3x4[3][2](dmat3x4[2](dmat3x4(1), dmat3x4(2)),
                                    dmat3x4[2](dmat3x4(3), dmat3x4(sc0)),
                                    dmat3x4[2](dmat3x4(5), dmat3x4(6)));
dmat3x4 a4[3][2] = dmat3x4[3][2](dmat3x4[2](dmat3x4(1), dmat3x4(2)),
                                    dmat3x4[2](dmat3x4(3), dmat3x4(4)),
                                    dmat3x4[2](dmat3x4(sc0), dmat3x4(6)));
dmat3x4 a5[3][2] = dmat3x4[3][2](dmat3x4[2](dmat3x4(1), dmat3x4(2)),
                                    dmat3x4[2](dmat3x4(3), dmat3x4(4)),
                                    dmat3x4[2](dmat3x4(5), dmat3x4(sc0)));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);
    double sum_a3 = double(0);
    double sum_a4 = double(0);
    double sum_a5 = double(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += double(a0[i][j][0][0]);
        sum_a1 += double(a1[i][j][0][0]);
        sum_a2 += double(a2[i][j][0][0]);
        sum_a3 += double(a3[i][j][0][0]);
        sum_a4 += double(a4[i][j][0][0]);
        sum_a5 += double(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

dmat4x2 a0[3][2] = dmat4x2[3][2](dmat4x2[2](dmat4x2(sc0), dmat4x2(2)),
                                    dmat4x2[2](dmat4x2(3), dmat4x2(4)),
                                    dmat4x2[2](dmat4x2(5), dmat4x2(6)));
dmat4x2 a1[3][2] = dmat4x2[3][2](dmat4x2[2](dmat4x2(1), dmat4x2(sc0)),
                                    dmat4x2[2](dmat4x2(3), dmat4x2(4)),
                                    dmat4x2[2](dmat4x2(5), dmat4x2(6)));
dmat4x2 a2[3][2] = dmat4x2[3][2](dmat4x2[2](dmat4x2(1), dmat4x2(2)),
                                    dmat4x2[2](dmat4x2(sc0), dmat4x2(4)),
                                    dmat4x2[2](dmat4x2(5), dmat4x2(6)));
dmat4x2 a3[3][2] = dmat4x2[3][2](dmat4x2[2](dmat4x2(1), dmat4x2(2)),
                                    dmat4x2[2](dmat4x2(3), dmat4x2(sc0)),
                                    dmat4x2[2](dmat4x2(5), dmat4x2(6)));
dmat4x2 a4[3][2] = dmat4x2[3][2](dmat4x2[2](dmat4x2(1), dmat4x2(2)),
                                    dmat4x2[2](dmat4x2(3), dmat4x2(4)),
                                    dmat4x2[2](dmat4x2(sc0), dmat4x2(6)));
dmat4x2 a5[3][2] = dmat4x2[3][2](dmat4x2[2](dmat4x2(1), dmat4x2(2)),
                                    dmat4x2[2](dmat4x2(3), dmat4x2(4)),
                                    dmat4x2[2](dmat4x2(5), dmat4x2(sc0)));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);
    double sum_a3 = double(0);
    double sum_a4 = double(0);
    double sum_a5 = double(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += double(a0[i][j][0][0]);
        sum_a1 += double(a1[i][j][0][0]);
        sum_a2 += double(a2[i][j][0][0]);
        sum_a3 += double(a3[i][j][0][0]);
        sum_a4 += double(a4[i][j][0][0]);
        sum_a5 += double(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

dmat4x3 a0[3][2] = dmat4x3[3][2](dmat4x3[2](dmat4x3(sc0), dmat4x3(2)),
                                    dmat4x3[2](dmat4x3(3), dmat4x3(4)),
                                    dmat4x3[2](dmat4x3(5), dmat4x3(6)));
dmat4x3 a1[3][2] = dmat4x3[3][2](dmat4x3[2](dmat4x3(1), dmat4x3(sc0)),
                                    dmat4x3[2](dmat4x3(3), dmat4x3(4)),
                                    dmat4x3[2](dmat4x3(5), dmat4x3(6)));
dmat4x3 a2[3][2] = dmat4x3[3][2](dmat4x3[2](dmat4x3(1), dmat4x3(2)),
                                    dmat4x3[2](dmat4x3(sc0), dmat4x3(4)),
                                    dmat4x3[2](dmat4x3(5), dmat4x3(6)));
dmat4x3 a3[3][2] = dmat4x3[3][2](dmat4x3[2](dmat4x3(1), dmat4x3(2)),
                                    dmat4x3[2](dmat4x3(3), dmat4x3(sc0)),
                                    dmat4x3[2](dmat4x3(5), dmat4x3(6)));
dmat4x3 a4[3][2] = dmat4x3[3][2](dmat4x3[2](dmat4x3(1), dmat4x3(2)),
                                    dmat4x3[2](dmat4x3(3), dmat4x3(4)),
                                    dmat4x3[2](dmat4x3(sc0), dmat4x3(6)));
dmat4x3 a5[3][2] = dmat4x3[3][2](dmat4x3[2](dmat4x3(1), dmat4x3(2)),
                                    dmat4x3[2](dmat4x3(3), dmat4x3(4)),
                                    dmat4x3[2](dmat4x3(5), dmat4x3(sc0)));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);
    double sum_a3 = double(0);
    double sum_a4 = double(0);
    double sum_a5 = double(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += double(a0[i][j][0][0]);
        sum_a1 += double(a1[i][j][0][0]);
        sum_a2 += double(a2[i][j][0][0]);
        sum_a3 += double(a3[i][j][0][0]);
        sum_a4 += double(a4[i][j][0][0]);
        sum_a5 += double(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int sc0 = int(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result[6];
} sb_out;

int a0[3][2] = int[3][2](int[2](sc0, 2),
                                    int[2](3, 4),
                                    int[2](5, 6));
int a1[3][2] = int[3][2](int[2](1, sc0),
                                    int[2](3, 4),
                                    int[2](5, 6));
int a2[3][2] = int[3][2](int[2](1, 2),
                                    int[2](sc0, 4),
                                    int[2](5, 6));
int a3[3][2] = int[3][2](int[2](1, 2),
                                    int[2](3, sc0),
                                    int[2](5, 6));
int a4[3][2] = int[3][2](int[2](1, 2),
                                    int[2](3, 4),
                                    int[2](sc0, 6));
int a5[3][2] = int[3][2](int[2](1, 2),
                                    int[2](3, 4),
                                    int[2](5, sc0));


void main (void)
{
    int sum_a0 = int(0);
    int sum_a1 = int(0);
    int sum_a2 = int(0);
    int sum_a3 = int(0);
    int sum_a4 = int(0);
    int sum_a5 = int(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += int(a0[i][j]);
        sum_a1 += int(a1[i][j]);
        sum_a2 += int(a2[i][j]);
        sum_a3 += int(a3[i][j]);
        sum_a4 += int(a4[i][j]);
        sum_a5 += int(a5[i][j]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const uint sc0 = uint(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint result[6];
} sb_out;

uint a0[3][2] = uint[3][2](uint[2](sc0, 2),
                                    uint[2](3, 4),
                                    uint[2](5, 6));
uint a1[3][2] = uint[3][2](uint[2](1, sc0),
                                    uint[2](3, 4),
                                    uint[2](5, 6));
uint a2[3][2] = uint[3][2](uint[2](1, 2),
                                    uint[2](sc0, 4),
                                    uint[2](5, 6));
uint a3[3][2] = uint[3][2](uint[2](1, 2),
                                    uint[2](3, sc0),
                                    uint[2](5, 6));
uint a4[3][2] = uint[3][2](uint[2](1, 2),
                                    uint[2](3, 4),
                                    uint[2](sc0, 6));
uint a5[3][2] = uint[3][2](uint[2](1, 2),
                                    uint[2](3, 4),
                                    uint[2](5, sc0));


void main (void)
{
    uint sum_a0 = uint(0);
    uint sum_a1 = uint(0);
    uint sum_a2 = uint(0);
    uint sum_a3 = uint(0);
    uint sum_a4 = uint(0);
    uint sum_a5 = uint(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += uint(a0[i][j]);
        sum_a1 += uint(a1[i][j]);
        sum_a2 += uint(a2[i][j]);
        sum_a3 += uint(a3[i][j]);
        sum_a4 += uint(a4[i][j]);
        sum_a5 += uint(a5[i][j]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const bool sc0 = bool(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result[6];
} sb_out;

bool a0[3][2] = bool[3][2](bool[2](sc0, true),
                                    bool[2](true, true),
                                    bool[2](true, true));
bool a1[3][2] = bool[3][2](bool[2](true, sc0),
                                    bool[2](true, true),
                                    bool[2](true, true));
bool a2[3][2] = bool[3][2](bool[2](true, true),
                                    bool[2](sc0, true),
                                    bool[2](true, true));
bool a3[3][2] = bool[3][2](bool[2](true, true),
                                    bool[2](true, sc0),
                                    bool[2](true, true));
bool a4[3][2] = bool[3][2](bool[2](true, true),
                                    bool[2](true, true),
                                    bool[2](sc0, true));
bool a5[3][2] = bool[3][2](bool[2](true, true),
                                    bool[2](true, true),
                                    bool[2](true, sc0));


void main (void)
{
    int sum_a0 = int(0);
    int sum_a1 = int(0);
    int sum_a2 = int(0);
    int sum_a3 = int(0);
    int sum_a4 = int(0);
    int sum_a5 = int(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += int(a0[i][j]);
        sum_a1 += int(a1[i][j]);
        sum_a2 += int(a2[i][j]);
        sum_a3 += int(a3[i][j]);
        sum_a4 += int(a4[i][j]);
        sum_a5 += int(a5[i][j]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int   sc0 = 1;
layout(constant_id = 2) const float sc1 = 1.0;
layout(constant_id = 3) const bool  sc2 = true;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result;
} sb_out;

struct Data {
    int   x;
    float y;
    bool  z;
};

Data a0[3] = Data[3](Data(sc0, 2.0, true), Data(1, sc1, true), Data(1, 2.0, sc2));


void main (void)
{
    int sum_a0 = 0;

    for (int i = 0; i < 3; ++i)
        sum_a0 += int(a0[i].x) + int(a0[i].y) + int(a0[i].z);

    sb_out.result = sum_a0;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    float sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, float(sc0), 8u);


void main (void)
{
    float sum_s0 = float(0);

    sum_s0 += float(s0.i);
    sum_s0 += float(s0.f);
    sum_s0 += float(s0.b);
    sum_s0 += float(s0.sc);
    sum_s0 += float(s0.ui);

    sb_out.result = sum_s0;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    mat2x3 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, mat2x3(sc0), 8u);


void main (void)
{
    float sum_s0 = float(0);

    sum_s0 += float(s0.i);
    sum_s0 += float(s0.f);
    sum_s0 += float(s0.b);
    sum_s0 += float(s0.sc[0][0]);
    sum_s0 += float(s0.ui);

    sb_out.result = sum_s0;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    mat2x4 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, mat2x4(sc0), 8u);


void main (void)
{
    float sum_s0 = float(0);

    sum_s0 += float(s0.i);
    sum_s0 += float(s0.f);
    sum_s0 += float(s0.b);
    sum_s0 += float(s0.sc[0][0]);
    sum_s0 += float(s0.ui);

    sb_out.result = sum_s0;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    mat3x2 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, mat3x2(sc0), 8u);


void main (void)
{
    float sum_s0 = float(0);

    sum_s0 += float(s0.i);
    sum_s0 += float(s0.f);
    sum_s0 += float(s0.b);
    sum_s0 += float(s0.sc[0][0]);
    sum_s0 += float(s0.ui);

    sb_out.result = sum_s0;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    mat3x4 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, mat3x4(sc0), 8u);


void main (void)
{
    float sum_s0 = float(0);

    sum_s0 += float(s0.i);
    sum_s0 += float(s0.f);
    sum_s0 += float(s0.b);
    sum_s0 += float(s0.sc[0][0]);
    sum_s0 += float(s0.ui);

    sb_out.result = sum_s0;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    mat4x2 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, mat4x2(sc0), 8u);


void main (void)
{
    float sum_s0 = float(0);

    sum_s0 += float(s0.i);
    sum_s0 += float(s0.f);
    sum_s0 += float(s0.b);
    sum_s0 += float(s0.sc[0][0]);
    sum_s0 += float(s0.ui);

    sb_out.result = sum_s0;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    mat4x3 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, mat4x3(sc0), 8u);


void main (void)
{
    float sum_s0 = float(0);

    sum_s0 += float(s0.i);
    sum_s0 += float(s0.f);
    sum_s0 += float(s0.b);
    sum_s0 += float(s0.sc[0][0]);
    sum_s0 += float(s0.ui);

    sb_out.result = sum_s0;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    double sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, double(sc0), 8u);


void main (void)
{
    double sum_s0 = double(0);

    sum_s0 += double(s0.i);
    sum_s0 += double(s0.f);
    sum_s0 += double(s0.b);
    sum_s0 += double(s0.sc);
    sum_s0 += double(s0.ui);

    sb_out.result = sum_s0;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    dmat2x3 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, dmat2x3(sc0), 8u);


void main (void)
{
    double sum_s0 = double(0);

    sum_s0 += double(s0.i);
    sum_s0 += double(s0.f);
    sum_s0 += double(s0.b);
    sum_s0 += double(s0.sc[0][0]);
    sum_s0 += double(s0.ui);

    sb_out.result = sum_s0;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    dmat2x4 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, dmat2x4(sc0), 8u);


void main (void)
{
    double sum_s0 = double(0);

    sum_s0 += double(s0.i);
    sum_s0 += double(s0.f);
    sum_s0 += double(s0.b);
    sum_s0 += double(s0.sc[0][0]);
    sum_s0 += double(s0.ui);

    sb_out.result = sum_s0;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    dmat3x2 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, dmat3x2(sc0), 8u);


void main (void)
{
    double sum_s0 = double(0);

    sum_s0 += double(s0.i);
    sum_s0 += double(s0.f);
    sum_s0 += double(s0.b);
    sum_s0 += double(s0.sc[0][0]);
    sum_s0 += double(s0.ui);

    sb_out.result = sum_s0;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    dmat3x4 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, dmat3x4(sc0), 8u);


void main (void)
{
    double sum_s0 = double(0);

    sum_s0 += double(s0.i);
    sum_s0 += double(s0.f);
    sum_s0 += double(s0.b);
    sum_s0 += double(s0.sc[0][0]);
    sum_s0 += double(s0.ui);

    sb_out.result = sum_s0;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    dmat4x2 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, dmat4x2(sc0), 8u);


void main (void)
{
    double sum_s0 = double(0);

    sum_s0 += double(s0.i);
    sum_s0 += double(s0.f);
    sum_s0 += double(s0.b);
    sum_s0 += double(s0.sc[0][0]);
    sum_s0 += double(s0.ui);

    sb_out.result = sum_s0;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    dmat4x3 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, dmat4x3(sc0), 8u);


void main (void)
{
    double sum_s0 = double(0);

    sum_s0 += double(s0.i);
    sum_s0 += double(s0.f);
    sum_s0 += double(s0.b);
    sum_s0 += double(s0.sc[0][0]);
    sum_s0 += double(s0.ui);

    sb_out.result = sum_s0;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int sc0 = int(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    int sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, int(sc0), 8u);


void main (void)
{
    int sum_s0 = int(0);

    sum_s0 += int(s0.i);
    sum_s0 += int(s0.f);
    sum_s0 += int(s0.b);
    sum_s0 += int(s0.sc);
    sum_s0 += int(s0.ui);

    sb_out.result = sum_s0;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const uint sc0 = uint(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    uint sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, uint(sc0), 8u);


void main (void)
{
    uint sum_s0 = uint(0);

    sum_s0 += uint(s0.i);
    sum_s0 += uint(s0.f);
    sum_s0 += uint(s0.b);
    sum_s0 += uint(s0.sc);
    sum_s0 += uint(s0.ui);

    sb_out.result = sum_s0;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const bool sc0 = bool(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    bool sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, bool(sc0), 8u);


void main (void)
{
    int sum_s0 = int(0);

    sum_s0 += int(s0.i);
    sum_s0 += int(s0.f);
    sum_s0 += int(s0.b);
    sum_s0 += int(s0.sc);
    sum_s0 += int(s0.ui);

    sb_out.result = sum_s0;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = 1.0;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result;
} sb_out;

struct Data {
    int  i;
    vec3 sc[3];
    bool b;
};

Data s0 = Data(1, vec3[3](vec3(2.0), vec3(sc0), vec3(4.0)), false);


void main (void)
{
    float sum_s0 = 0;

    sum_s0 += float(s0.i);
    sum_s0 += float(s0.sc[0][0]);
    sum_s0 += float(s0.sc[1][0]);
    sum_s0 += float(s0.sc[2][0]);
    sum_s0 += float(s0.b);

    sb_out.result = sum_s0;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int sc0 = 1;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result;
} sb_out;

struct Nested {
    vec2  v;
    int   sc;
    float f;
};

struct Data {
    uint   ui;
    Nested s;
    bool   b;
};

Data s0 = Data(1u, Nested(vec2(2.0), sc0, 4.0), true);


void main (void)
{
    int sum_s0 = 0;

    sum_s0 += int(s0.ui);
    sum_s0 += int(s0.s.v[0]);
    sum_s0 += int(s0.s.sc);
    sum_s0 += int(s0.s.f);
    sum_s0 += int(s0.b);

    sb_out.result = sum_s0;

    vec3 p0 = gl_TessCoord.x * gl_in[0].gl_Position.xyz;
    vec3 p1 = gl_TessCoord.y * gl_in[1].gl_Position.xyz;
    vec3 p2 = gl_TessCoord.z * gl_in[2].gl_Position.xyz;
    gl_Position = vec4(p0 + p1 + p2, 1.0);
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const bool sc0 = true;
layout(constant_id = 2) const bool sc1 = false;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    bool r0;
    bool r1;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int sc0 = -3;
layout(constant_id = 2) const int sc1 = 17;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r0;
    int r1;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const uint sc0 = 42u;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint r0;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = 7.5;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float r0;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = 2.75LF;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double r0;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : require
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int8_t sc0 = int8_t(1);
layout(constant_id = 2) const int8_t sc1 = int8_t(-2);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int8_t r0;
    int8_t r1;
} sb_out;



void main (void)
{
    int8_t aux = sc0 + sc1;
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : require
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const uint8_t sc0 = int8_t(15);
layout(constant_id = 2) const uint8_t sc1 = int8_t(43);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint8_t r0;
    uint8_t r1;
} sb_out;



void main (void)
{
    uint8_t aux = sc0 + sc1;
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int16 : require
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int16_t sc0 = 20000s;
layout(constant_id = 2) const int16_t sc1 = -20000s;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int16_t r0;
    int16_t r1;
} sb_out;



void main (void)
{
    int16_t aux = sc0 + sc1;
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int16 : require
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const uint16_t sc0 = 64000us;
layout(constant_id = 2) const uint16_t sc1 = 51829us;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint16_t r0;
    uint16_t r1;
} sb_out;



void main (void)
{
    uint16_t aux = sc0 + sc1;
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int64_t sc0 = 9141386509785772560l;
layout(constant_id = 2) const int64_t sc1 = -9141386509785772560l;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int64_t r0;
    int64_t r1;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const uint64_t sc0 = 18364758544493064720ul;
layout(constant_id = 2) const uint64_t sc1 = 17298946664678735070ul;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint64_t r0;
    uint64_t r1;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float16_t sc0 = 7.5hf;
layout(constant_id = 2) const float16_t sc1 = 1.125hf;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float16_t r0;
    float16_t r1;
} sb_out;



void main (void)
{
    float16_t aux = sc0 + sc1;
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const bool sc0 = true;
layout(constant_id = 2) const bool sc1 = false;
layout(constant_id = 3) const bool sc2 = true;
layout(constant_id = 4) const bool sc3 = false;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    bool r0;
    bool r1;
    bool r2;
    bool r3;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;
    sb_out.r2 = sc2;
    sb_out.r3 = sc3;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int sc0 = -3;
layout(constant_id = 2) const int sc1 = 91;
layout(constant_id = 3) const int sc2 = 17;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r0;
    int r1;
    int r2;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;
    sb_out.r2 = sc2;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const uint sc0 = 42u;
layout(constant_id = 2) const uint sc1 = 7u;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint r0;
    uint r1;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = 7.5;
layout(constant_id = 2) const float sc1 = 1.125;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float r0;
    float r1;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = 2.75LF;
layout(constant_id = 2) const double sc1 = 9.25LF;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double r0;
    double r1;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_explicit_arithmetic_types_int16 : require
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : require
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const uint8_t  sc0 = uint8_t  (0);
layout(constant_id = 2) const uint16_t sc1 = uint16_t (0);
layout(constant_id = 3) const uint     sc2 = uint     (0);
layout(constant_id = 4) const uint64_t sc3 = uint64_t (0);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint64_t r0;
    uint     r1;
    uint16_t r2;
    uint8_t  r3;
} sb_out;



void main (void)
{
    uint64_t i0 = sc3;
    uint     i1 = sc2;
    uint16_t i2 = sc1;
    uint8_t  i3 = sc0;
    sb_out.r0 = i0;
    sb_out.r1 = i1;
    sb_out.r2 = i2;
    sb_out.r3 = i3;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_explicit_arithmetic_types_int16 : require
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : require
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const uint64_t sc3 = uint64_t (0);
layout(constant_id = 2) const uint     sc2 = uint     (0);
layout(constant_id = 3) const uint16_t sc1 = uint16_t (0);
layout(constant_id = 4) const uint8_t  sc0 = uint8_t  (0);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint64_t r0;
    uint     r1;
    uint16_t r2;
    uint8_t  r3;
} sb_out;



void main (void)
{
    uint64_t i0 = sc3;
    uint     i1 = sc2;
    uint16_t i2 = sc1;
    uint8_t  i3 = sc0;
    sb_out.r0 = i0;
    sb_out.r1 = i1;
    sb_out.r2 = i2;
    sb_out.r3 = i3;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : require
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int8_t sc0 = int8_t(123);
layout(constant_id = 2) const int8_t sc1 = int8_t(-33);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int8_t r0;
    int8_t r1;
} sb_out;



void main (void)
{
    int8_t aux = sc0 + sc1;
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : require
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const uint8_t sc0 = int8_t(99);
layout(constant_id = 2) const uint8_t sc1 = int8_t(81);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint8_t r0;
    uint8_t r1;
} sb_out;



void main (void)
{
    uint8_t aux = sc0 + sc1;
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const uint sc0 = 305419896u;
layout(constant_id = 2) const uint sc1 = 591751049u;
layout(constant_id = 3) const uint sc2 = 878082202u;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint r0;
    uint r1;
    uint r2;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;
    sb_out.r2 = sc2;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float16_t sc0 = 7.5hf;
layout(constant_id = 2) const float16_t sc1 = 1.125hf;
layout(constant_id = 3) const float16_t sc2 = 1.125hf;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float16_t r0;
    float16_t r1;
    float16_t r2;
} sb_out;



void main (void)
{
    float16_t aux = sc0 + sc1;
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;
    sb_out.r2 = sc2;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = 7.5;
layout(constant_id = 2) const float sc1 = 1.125;
layout(constant_id = 3) const float sc2 = 1.125;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float r0;
    float r1;
    float r2;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;
    sb_out.r2 = sc2;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};



layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r0;
} sb_out;



void main (void)
{
    sb_out.r0 = 77;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};


layout(constant_id = 1) const int sc1 = 0;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r1;
} sb_out;



void main (void)
{
    sb_out.r1 = sc1;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 7) const int sc0 = 0;

layout(constant_id = 17) const int sc1 = 0;


layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r0;
    int r1;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 7) const int sc0 = 0;


layout(constant_id = 17) const int sc1 = 0;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r0;
    int r1;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
    sb_out.r1 = sc1;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) gl_MaxImageUnits;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    bool ok;
} sb_out;



void main (void)
{
    sb_out.ok = (gl_MaxImageUnits >= 8);

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) gl_MaxImageUnits;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int maxImageUnits;
} sb_out;



void main (void)
{
    sb_out.maxImageUnits = gl_MaxImageUnits;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int sc0 = 2;
layout(constant_id = 2) const int sc1 = 3;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result;
} sb_out;

const int expr0 = sc0 + 1;
const int expr1 = sc0 + sc1;


void main (void)
{
    sb_out.result = expr0 + expr1;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int sc0 = 1;
layout(constant_id = 2) const int sc1 = 2;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r0;
    int r1[3];
} sb_out;



void main (void)
{
    int a0[sc0];
    int a1[sc1];

    for (int i = 0; i < sc0; ++i)
        a0[i] = sc0 - i;
    for (int i = 0; i < sc1; ++i)
        a1[i] = sc1 - i;

    sb_out.r0 = a0[0];
    for (int i = 0; i < sc1; ++i)
         sb_out.r1[i] = a1[i];

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int sc0 = 3;
layout(constant_id = 2) const int sc1 = 5;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r0;
    int r1;
} sb_out;



void main (void)
{
    int a0[sc0 + 3];
    int a1[sc0 + sc1];

    const int size0 = sc0 + 3;
    const int size1 = sc0 + sc1;

    for (int i = 0; i < size0; ++i)
        a0[i] = 3 - i;
    for (int i = 0; i < size1; ++i)
        a1[i] = 5 - i;

    sb_out.r0 = a0[size0 - 1];
    sb_out.r1 = a1[size1 - 1];

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int sc0 = 3;
layout(constant_id = 2) const int sc1 = 5;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r0;
    int r1;
} sb_out;



void main (void)
{
    const int size0 = sc0 + 3;
    const int size1 = sc0 + sc1;

    int a0[size0];
    int a1[size1];

    for (int i = 0; i < size0; ++i)
        a0[i] = 3 - i;
    for (int i = 0; i < size1; ++i)
        a1[i] = 5 - i;

    sb_out.r0 = a0[size0 - 1];
    sb_out.r1 = a1[size1 - 1];

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int sc0 = 1;
layout(constant_id = 2) const int sc1 = 2;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r0;
    int r1;
} sb_out;



void main (void)
{
    int a0[sc0];
    int a1[sc1];

    sb_out.r0 = a0.length();
    sb_out.r1 = a1.length();

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int sc0 = 3;
layout(constant_id = 2) const int sc1 = 1;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result;
} sb_out;

int sumArrays (int a0[sc0], int a1[sc1])
{
    int sum = 0;
    for (int i = 0; (i < sc0) && (i < sc1); ++i)
        sum += a0[i] + a1[i];
    return sum;
}


void main (void)
{
    int a0[sc0];
    int a1[sc1];

    for (int i = 0; i < sc0; ++i)
        a0[i] = i + 1;
    for (int i = 0; i < sc1; ++i)
        a1[i] = i + 2;

    sb_out.result = sumArrays(a0, a1);

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

mat2x3 m0 = mat2x3(sc0, 2, 3, 4, 5, 6);
mat2x3 m1 = mat2x3(1, sc0, 3, 4, 5, 6);
mat2x3 m2 = mat2x3(1, 2, sc0, 4, 5, 6);
mat2x3 m3 = mat2x3(1, 2, 3, sc0, 5, 6);
mat2x3 m4 = mat2x3(1, 2, 3, 4, sc0, 6);
mat2x3 m5 = mat2x3(1, 2, 3, 4, 5, sc0);


void main (void)
{
    float sum_m0 = float(0);
    float sum_m1 = float(0);
    float sum_m2 = float(0);
    float sum_m3 = float(0);
    float sum_m4 = float(0);
    float sum_m5 = float(0);

    for (int i = 0; i < 2; ++i)
    for (int j = 0; j < 3; ++j)
    {
        sum_m0 += float(m0[i][j]);
        sum_m1 += float(m1[i][j]);
        sum_m2 += float(m2[i][j]);
        sum_m3 += float(m3[i][j]);
        sum_m4 += float(m4[i][j]);
        sum_m5 += float(m5[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[8];
} sb_out;

mat2x4 m0 = mat2x4(sc0, 2, 3, 4, 5, 6, 7, 8);
mat2x4 m1 = mat2x4(1, sc0, 3, 4, 5, 6, 7, 8);
mat2x4 m2 = mat2x4(1, 2, sc0, 4, 5, 6, 7, 8);
mat2x4 m3 = mat2x4(1, 2, 3, sc0, 5, 6, 7, 8);
mat2x4 m4 = mat2x4(1, 2, 3, 4, sc0, 6, 7, 8);
mat2x4 m5 = mat2x4(1, 2, 3, 4, 5, sc0, 7, 8);
mat2x4 m6 = mat2x4(1, 2, 3, 4, 5, 6, sc0, 8);
mat2x4 m7 = mat2x4(1, 2, 3, 4, 5, 6, 7, sc0);


void main (void)
{
    float sum_m0 = float(0);
    float sum_m1 = float(0);
    float sum_m2 = float(0);
    float sum_m3 = float(0);
    float sum_m4 = float(0);
    float sum_m5 = float(0);
    float sum_m6 = float(0);
    float sum_m7 = float(0);

    for (int i = 0; i < 2; ++i)
    for (int j = 0; j < 4; ++j)
    {
        sum_m0 += float(m0[i][j]);
        sum_m1 += float(m1[i][j]);
        sum_m2 += float(m2[i][j]);
        sum_m3 += float(m3[i][j]);
        sum_m4 += float(m4[i][j]);
        sum_m5 += float(m5[i][j]);
        sum_m6 += float(m6[i][j]);
        sum_m7 += float(m7[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;
    sb_out.result[6] = sum_m6;
    sb_out.result[7] = sum_m7;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

mat3x2 m0 = mat3x2(sc0, 2, 3, 4, 5, 6);
mat3x2 m1 = mat3x2(1, sc0, 3, 4, 5, 6);
mat3x2 m2 = mat3x2(1, 2, sc0, 4, 5, 6);
mat3x2 m3 = mat3x2(1, 2, 3, sc0, 5, 6);
mat3x2 m4 = mat3x2(1, 2, 3, 4, sc0, 6);
mat3x2 m5 = mat3x2(1, 2, 3, 4, 5, sc0);


void main (void)
{
    float sum_m0 = float(0);
    float sum_m1 = float(0);
    float sum_m2 = float(0);
    float sum_m3 = float(0);
    float sum_m4 = float(0);
    float sum_m5 = float(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_m0 += float(m0[i][j]);
        sum_m1 += float(m1[i][j]);
        sum_m2 += float(m2[i][j]);
        sum_m3 += float(m3[i][j]);
        sum_m4 += float(m4[i][j]);
        sum_m5 += float(m5[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[12];
} sb_out;

mat3x4 m0 = mat3x4(sc0, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);
mat3x4 m1 = mat3x4(1, sc0, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);
mat3x4 m2 = mat3x4(1, 2, sc0, 4, 5, 6, 7, 8, 9, 10, 11, 12);
mat3x4 m3 = mat3x4(1, 2, 3, sc0, 5, 6, 7, 8, 9, 10, 11, 12);
mat3x4 m4 = mat3x4(1, 2, 3, 4, sc0, 6, 7, 8, 9, 10, 11, 12);
mat3x4 m5 = mat3x4(1, 2, 3, 4, 5, sc0, 7, 8, 9, 10, 11, 12);
mat3x4 m6 = mat3x4(1, 2, 3, 4, 5, 6, sc0, 8, 9, 10, 11, 12);
mat3x4 m7 = mat3x4(1, 2, 3, 4, 5, 6, 7, sc0, 9, 10, 11, 12);
mat3x4 m8 = mat3x4(1, 2, 3, 4, 5, 6, 7, 8, sc0, 10, 11, 12);
mat3x4 m9 = mat3x4(1, 2, 3, 4, 5, 6, 7, 8, 9, sc0, 11, 12);
mat3x4 m10 = mat3x4(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, sc0, 12);
mat3x4 m11 = mat3x4(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, sc0);


void main (void)
{
    float sum_m0 = float(0);
    float sum_m1 = float(0);
    float sum_m2 = float(0);
    float sum_m3 = float(0);
    float sum_m4 = float(0);
    float sum_m5 = float(0);
    float sum_m6 = float(0);
    float sum_m7 = float(0);
    float sum_m8 = float(0);
    float sum_m9 = float(0);
    float sum_m10 = float(0);
    float sum_m11 = float(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 4; ++j)
    {
        sum_m0 += float(m0[i][j]);
        sum_m1 += float(m1[i][j]);
        sum_m2 += float(m2[i][j]);
        sum_m3 += float(m3[i][j]);
        sum_m4 += float(m4[i][j]);
        sum_m5 += float(m5[i][j]);
        sum_m6 += float(m6[i][j]);
        sum_m7 += float(m7[i][j]);
        sum_m8 += float(m8[i][j]);
        sum_m9 += float(m9[i][j]);
        sum_m10 += float(m10[i][j]);
        sum_m11 += float(m11[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;
    sb_out.result[6] = sum_m6;
    sb_out.result[7] = sum_m7;
    sb_out.result[8] = sum_m8;
    sb_out.result[9] = sum_m9;
    sb_out.result[10] = sum_m10;
    sb_out.result[11] = sum_m11;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[8];
} sb_out;

mat4x2 m0 = mat4x2(sc0, 2, 3, 4, 5, 6, 7, 8);
mat4x2 m1 = mat4x2(1, sc0, 3, 4, 5, 6, 7, 8);
mat4x2 m2 = mat4x2(1, 2, sc0, 4, 5, 6, 7, 8);
mat4x2 m3 = mat4x2(1, 2, 3, sc0, 5, 6, 7, 8);
mat4x2 m4 = mat4x2(1, 2, 3, 4, sc0, 6, 7, 8);
mat4x2 m5 = mat4x2(1, 2, 3, 4, 5, sc0, 7, 8);
mat4x2 m6 = mat4x2(1, 2, 3, 4, 5, 6, sc0, 8);
mat4x2 m7 = mat4x2(1, 2, 3, 4, 5, 6, 7, sc0);


void main (void)
{
    float sum_m0 = float(0);
    float sum_m1 = float(0);
    float sum_m2 = float(0);
    float sum_m3 = float(0);
    float sum_m4 = float(0);
    float sum_m5 = float(0);
    float sum_m6 = float(0);
    float sum_m7 = float(0);

    for (int i = 0; i < 4; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_m0 += float(m0[i][j]);
        sum_m1 += float(m1[i][j]);
        sum_m2 += float(m2[i][j]);
        sum_m3 += float(m3[i][j]);
        sum_m4 += float(m4[i][j]);
        sum_m5 += float(m5[i][j]);
        sum_m6 += float(m6[i][j]);
        sum_m7 += float(m7[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;
    sb_out.result[6] = sum_m6;
    sb_out.result[7] = sum_m7;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[12];
} sb_out;

mat4x3 m0 = mat4x3(sc0, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);
mat4x3 m1 = mat4x3(1, sc0, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);
mat4x3 m2 = mat4x3(1, 2, sc0, 4, 5, 6, 7, 8, 9, 10, 11, 12);
mat4x3 m3 = mat4x3(1, 2, 3, sc0, 5, 6, 7, 8, 9, 10, 11, 12);
mat4x3 m4 = mat4x3(1, 2, 3, 4, sc0, 6, 7, 8, 9, 10, 11, 12);
mat4x3 m5 = mat4x3(1, 2, 3, 4, 5, sc0, 7, 8, 9, 10, 11, 12);
mat4x3 m6 = mat4x3(1, 2, 3, 4, 5, 6, sc0, 8, 9, 10, 11, 12);
mat4x3 m7 = mat4x3(1, 2, 3, 4, 5, 6, 7, sc0, 9, 10, 11, 12);
mat4x3 m8 = mat4x3(1, 2, 3, 4, 5, 6, 7, 8, sc0, 10, 11, 12);
mat4x3 m9 = mat4x3(1, 2, 3, 4, 5, 6, 7, 8, 9, sc0, 11, 12);
mat4x3 m10 = mat4x3(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, sc0, 12);
mat4x3 m11 = mat4x3(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, sc0);


void main (void)
{
    float sum_m0 = float(0);
    float sum_m1 = float(0);
    float sum_m2 = float(0);
    float sum_m3 = float(0);
    float sum_m4 = float(0);
    float sum_m5 = float(0);
    float sum_m6 = float(0);
    float sum_m7 = float(0);
    float sum_m8 = float(0);
    float sum_m9 = float(0);
    float sum_m10 = float(0);
    float sum_m11 = float(0);

    for (int i = 0; i < 4; ++i)
    for (int j = 0; j < 3; ++j)
    {
        sum_m0 += float(m0[i][j]);
        sum_m1 += float(m1[i][j]);
        sum_m2 += float(m2[i][j]);
        sum_m3 += float(m3[i][j]);
        sum_m4 += float(m4[i][j]);
        sum_m5 += float(m5[i][j]);
        sum_m6 += float(m6[i][j]);
        sum_m7 += float(m7[i][j]);
        sum_m8 += float(m8[i][j]);
        sum_m9 += float(m9[i][j]);
        sum_m10 += float(m10[i][j]);
        sum_m11 += float(m11[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;
    sb_out.result[6] = sum_m6;
    sb_out.result[7] = sum_m7;
    sb_out.result[8] = sum_m8;
    sb_out.result[9] = sum_m9;
    sb_out.result[10] = sum_m10;
    sb_out.result[11] = sum_m11;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

dmat2x3 m0 = dmat2x3(sc0, 2, 3, 4, 5, 6);
dmat2x3 m1 = dmat2x3(1, sc0, 3, 4, 5, 6);
dmat2x3 m2 = dmat2x3(1, 2, sc0, 4, 5, 6);
dmat2x3 m3 = dmat2x3(1, 2, 3, sc0, 5, 6);
dmat2x3 m4 = dmat2x3(1, 2, 3, 4, sc0, 6);
dmat2x3 m5 = dmat2x3(1, 2, 3, 4, 5, sc0);


void main (void)
{
    double sum_m0 = double(0);
    double sum_m1 = double(0);
    double sum_m2 = double(0);
    double sum_m3 = double(0);
    double sum_m4 = double(0);
    double sum_m5 = double(0);

    for (int i = 0; i < 2; ++i)
    for (int j = 0; j < 3; ++j)
    {
        sum_m0 += double(m0[i][j]);
        sum_m1 += double(m1[i][j]);
        sum_m2 += double(m2[i][j]);
        sum_m3 += double(m3[i][j]);
        sum_m4 += double(m4[i][j]);
        sum_m5 += double(m5[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[8];
} sb_out;

dmat2x4 m0 = dmat2x4(sc0, 2, 3, 4, 5, 6, 7, 8);
dmat2x4 m1 = dmat2x4(1, sc0, 3, 4, 5, 6, 7, 8);
dmat2x4 m2 = dmat2x4(1, 2, sc0, 4, 5, 6, 7, 8);
dmat2x4 m3 = dmat2x4(1, 2, 3, sc0, 5, 6, 7, 8);
dmat2x4 m4 = dmat2x4(1, 2, 3, 4, sc0, 6, 7, 8);
dmat2x4 m5 = dmat2x4(1, 2, 3, 4, 5, sc0, 7, 8);
dmat2x4 m6 = dmat2x4(1, 2, 3, 4, 5, 6, sc0, 8);
dmat2x4 m7 = dmat2x4(1, 2, 3, 4, 5, 6, 7, sc0);


void main (void)
{
    double sum_m0 = double(0);
    double sum_m1 = double(0);
    double sum_m2 = double(0);
    double sum_m3 = double(0);
    double sum_m4 = double(0);
    double sum_m5 = double(0);
    double sum_m6 = double(0);
    double sum_m7 = double(0);

    for (int i = 0; i < 2; ++i)
    for (int j = 0; j < 4; ++j)
    {
        sum_m0 += double(m0[i][j]);
        sum_m1 += double(m1[i][j]);
        sum_m2 += double(m2[i][j]);
        sum_m3 += double(m3[i][j]);
        sum_m4 += double(m4[i][j]);
        sum_m5 += double(m5[i][j]);
        sum_m6 += double(m6[i][j]);
        sum_m7 += double(m7[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;
    sb_out.result[6] = sum_m6;
    sb_out.result[7] = sum_m7;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

dmat3x2 m0 = dmat3x2(sc0, 2, 3, 4, 5, 6);
dmat3x2 m1 = dmat3x2(1, sc0, 3, 4, 5, 6);
dmat3x2 m2 = dmat3x2(1, 2, sc0, 4, 5, 6);
dmat3x2 m3 = dmat3x2(1, 2, 3, sc0, 5, 6);
dmat3x2 m4 = dmat3x2(1, 2, 3, 4, sc0, 6);
dmat3x2 m5 = dmat3x2(1, 2, 3, 4, 5, sc0);


void main (void)
{
    double sum_m0 = double(0);
    double sum_m1 = double(0);
    double sum_m2 = double(0);
    double sum_m3 = double(0);
    double sum_m4 = double(0);
    double sum_m5 = double(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_m0 += double(m0[i][j]);
        sum_m1 += double(m1[i][j]);
        sum_m2 += double(m2[i][j]);
        sum_m3 += double(m3[i][j]);
        sum_m4 += double(m4[i][j]);
        sum_m5 += double(m5[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[12];
} sb_out;

dmat3x4 m0 = dmat3x4(sc0, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);
dmat3x4 m1 = dmat3x4(1, sc0, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);
dmat3x4 m2 = dmat3x4(1, 2, sc0, 4, 5, 6, 7, 8, 9, 10, 11, 12);
dmat3x4 m3 = dmat3x4(1, 2, 3, sc0, 5, 6, 7, 8, 9, 10, 11, 12);
dmat3x4 m4 = dmat3x4(1, 2, 3, 4, sc0, 6, 7, 8, 9, 10, 11, 12);
dmat3x4 m5 = dmat3x4(1, 2, 3, 4, 5, sc0, 7, 8, 9, 10, 11, 12);
dmat3x4 m6 = dmat3x4(1, 2, 3, 4, 5, 6, sc0, 8, 9, 10, 11, 12);
dmat3x4 m7 = dmat3x4(1, 2, 3, 4, 5, 6, 7, sc0, 9, 10, 11, 12);
dmat3x4 m8 = dmat3x4(1, 2, 3, 4, 5, 6, 7, 8, sc0, 10, 11, 12);
dmat3x4 m9 = dmat3x4(1, 2, 3, 4, 5, 6, 7, 8, 9, sc0, 11, 12);
dmat3x4 m10 = dmat3x4(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, sc0, 12);
dmat3x4 m11 = dmat3x4(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, sc0);


void main (void)
{
    double sum_m0 = double(0);
    double sum_m1 = double(0);
    double sum_m2 = double(0);
    double sum_m3 = double(0);
    double sum_m4 = double(0);
    double sum_m5 = double(0);
    double sum_m6 = double(0);
    double sum_m7 = double(0);
    double sum_m8 = double(0);
    double sum_m9 = double(0);
    double sum_m10 = double(0);
    double sum_m11 = double(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 4; ++j)
    {
        sum_m0 += double(m0[i][j]);
        sum_m1 += double(m1[i][j]);
        sum_m2 += double(m2[i][j]);
        sum_m3 += double(m3[i][j]);
        sum_m4 += double(m4[i][j]);
        sum_m5 += double(m5[i][j]);
        sum_m6 += double(m6[i][j]);
        sum_m7 += double(m7[i][j]);
        sum_m8 += double(m8[i][j]);
        sum_m9 += double(m9[i][j]);
        sum_m10 += double(m10[i][j]);
        sum_m11 += double(m11[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;
    sb_out.result[6] = sum_m6;
    sb_out.result[7] = sum_m7;
    sb_out.result[8] = sum_m8;
    sb_out.result[9] = sum_m9;
    sb_out.result[10] = sum_m10;
    sb_out.result[11] = sum_m11;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[8];
} sb_out;

dmat4x2 m0 = dmat4x2(sc0, 2, 3, 4, 5, 6, 7, 8);
dmat4x2 m1 = dmat4x2(1, sc0, 3, 4, 5, 6, 7, 8);
dmat4x2 m2 = dmat4x2(1, 2, sc0, 4, 5, 6, 7, 8);
dmat4x2 m3 = dmat4x2(1, 2, 3, sc0, 5, 6, 7, 8);
dmat4x2 m4 = dmat4x2(1, 2, 3, 4, sc0, 6, 7, 8);
dmat4x2 m5 = dmat4x2(1, 2, 3, 4, 5, sc0, 7, 8);
dmat4x2 m6 = dmat4x2(1, 2, 3, 4, 5, 6, sc0, 8);
dmat4x2 m7 = dmat4x2(1, 2, 3, 4, 5, 6, 7, sc0);


void main (void)
{
    double sum_m0 = double(0);
    double sum_m1 = double(0);
    double sum_m2 = double(0);
    double sum_m3 = double(0);
    double sum_m4 = double(0);
    double sum_m5 = double(0);
    double sum_m6 = double(0);
    double sum_m7 = double(0);

    for (int i = 0; i < 4; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_m0 += double(m0[i][j]);
        sum_m1 += double(m1[i][j]);
        sum_m2 += double(m2[i][j]);
        sum_m3 += double(m3[i][j]);
        sum_m4 += double(m4[i][j]);
        sum_m5 += double(m5[i][j]);
        sum_m6 += double(m6[i][j]);
        sum_m7 += double(m7[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;
    sb_out.result[6] = sum_m6;
    sb_out.result[7] = sum_m7;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[12];
} sb_out;

dmat4x3 m0 = dmat4x3(sc0, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);
dmat4x3 m1 = dmat4x3(1, sc0, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);
dmat4x3 m2 = dmat4x3(1, 2, sc0, 4, 5, 6, 7, 8, 9, 10, 11, 12);
dmat4x3 m3 = dmat4x3(1, 2, 3, sc0, 5, 6, 7, 8, 9, 10, 11, 12);
dmat4x3 m4 = dmat4x3(1, 2, 3, 4, sc0, 6, 7, 8, 9, 10, 11, 12);
dmat4x3 m5 = dmat4x3(1, 2, 3, 4, 5, sc0, 7, 8, 9, 10, 11, 12);
dmat4x3 m6 = dmat4x3(1, 2, 3, 4, 5, 6, sc0, 8, 9, 10, 11, 12);
dmat4x3 m7 = dmat4x3(1, 2, 3, 4, 5, 6, 7, sc0, 9, 10, 11, 12);
dmat4x3 m8 = dmat4x3(1, 2, 3, 4, 5, 6, 7, 8, sc0, 10, 11, 12);
dmat4x3 m9 = dmat4x3(1, 2, 3, 4, 5, 6, 7, 8, 9, sc0, 11, 12);
dmat4x3 m10 = dmat4x3(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, sc0, 12);
dmat4x3 m11 = dmat4x3(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, sc0);


void main (void)
{
    double sum_m0 = double(0);
    double sum_m1 = double(0);
    double sum_m2 = double(0);
    double sum_m3 = double(0);
    double sum_m4 = double(0);
    double sum_m5 = double(0);
    double sum_m6 = double(0);
    double sum_m7 = double(0);
    double sum_m8 = double(0);
    double sum_m9 = double(0);
    double sum_m10 = double(0);
    double sum_m11 = double(0);

    for (int i = 0; i < 4; ++i)
    for (int j = 0; j < 3; ++j)
    {
        sum_m0 += double(m0[i][j]);
        sum_m1 += double(m1[i][j]);
        sum_m2 += double(m2[i][j]);
        sum_m3 += double(m3[i][j]);
        sum_m4 += double(m4[i][j]);
        sum_m5 += double(m5[i][j]);
        sum_m6 += double(m6[i][j]);
        sum_m7 += double(m7[i][j]);
        sum_m8 += double(m8[i][j]);
        sum_m9 += double(m9[i][j]);
        sum_m10 += double(m10[i][j]);
        sum_m11 += double(m11[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
    sb_out.result[4] = sum_m4;
    sb_out.result[5] = sum_m5;
    sb_out.result[6] = sum_m6;
    sb_out.result[7] = sum_m7;
    sb_out.result[8] = sum_m8;
    sb_out.result[9] = sum_m9;
    sb_out.result[10] = sum_m10;
    sb_out.result[11] = sum_m11;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[3];
} sb_out;

float a0[3] = float[3](sc0, 2, 3);
float a1[3] = float[3](1, sc0, 3);
float a2[3] = float[3](1, 2, sc0);


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += float(a0[i]);
        sum_a1 += float(a1[i]);
        sum_a2 += float(a2[i]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[3];
} sb_out;

mat2x3 a0[3] = mat2x3[3](mat2x3(sc0), mat2x3(2), mat2x3(3));
mat2x3 a1[3] = mat2x3[3](mat2x3(1), mat2x3(sc0), mat2x3(3));
mat2x3 a2[3] = mat2x3[3](mat2x3(1), mat2x3(2), mat2x3(sc0));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += float(a0[i][0][0]);
        sum_a1 += float(a1[i][0][0]);
        sum_a2 += float(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[3];
} sb_out;

mat2x4 a0[3] = mat2x4[3](mat2x4(sc0), mat2x4(2), mat2x4(3));
mat2x4 a1[3] = mat2x4[3](mat2x4(1), mat2x4(sc0), mat2x4(3));
mat2x4 a2[3] = mat2x4[3](mat2x4(1), mat2x4(2), mat2x4(sc0));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += float(a0[i][0][0]);
        sum_a1 += float(a1[i][0][0]);
        sum_a2 += float(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[3];
} sb_out;

mat3x2 a0[3] = mat3x2[3](mat3x2(sc0), mat3x2(2), mat3x2(3));
mat3x2 a1[3] = mat3x2[3](mat3x2(1), mat3x2(sc0), mat3x2(3));
mat3x2 a2[3] = mat3x2[3](mat3x2(1), mat3x2(2), mat3x2(sc0));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += float(a0[i][0][0]);
        sum_a1 += float(a1[i][0][0]);
        sum_a2 += float(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[3];
} sb_out;

mat3x4 a0[3] = mat3x4[3](mat3x4(sc0), mat3x4(2), mat3x4(3));
mat3x4 a1[3] = mat3x4[3](mat3x4(1), mat3x4(sc0), mat3x4(3));
mat3x4 a2[3] = mat3x4[3](mat3x4(1), mat3x4(2), mat3x4(sc0));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += float(a0[i][0][0]);
        sum_a1 += float(a1[i][0][0]);
        sum_a2 += float(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[3];
} sb_out;

mat4x2 a0[3] = mat4x2[3](mat4x2(sc0), mat4x2(2), mat4x2(3));
mat4x2 a1[3] = mat4x2[3](mat4x2(1), mat4x2(sc0), mat4x2(3));
mat4x2 a2[3] = mat4x2[3](mat4x2(1), mat4x2(2), mat4x2(sc0));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += float(a0[i][0][0]);
        sum_a1 += float(a1[i][0][0]);
        sum_a2 += float(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[3];
} sb_out;

mat4x3 a0[3] = mat4x3[3](mat4x3(sc0), mat4x3(2), mat4x3(3));
mat4x3 a1[3] = mat4x3[3](mat4x3(1), mat4x3(sc0), mat4x3(3));
mat4x3 a2[3] = mat4x3[3](mat4x3(1), mat4x3(2), mat4x3(sc0));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += float(a0[i][0][0]);
        sum_a1 += float(a1[i][0][0]);
        sum_a2 += float(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[3];
} sb_out;

double a0[3] = double[3](sc0, 2, 3);
double a1[3] = double[3](1, sc0, 3);
double a2[3] = double[3](1, 2, sc0);


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += double(a0[i]);
        sum_a1 += double(a1[i]);
        sum_a2 += double(a2[i]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[3];
} sb_out;

dmat2x3 a0[3] = dmat2x3[3](dmat2x3(sc0), dmat2x3(2), dmat2x3(3));
dmat2x3 a1[3] = dmat2x3[3](dmat2x3(1), dmat2x3(sc0), dmat2x3(3));
dmat2x3 a2[3] = dmat2x3[3](dmat2x3(1), dmat2x3(2), dmat2x3(sc0));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += double(a0[i][0][0]);
        sum_a1 += double(a1[i][0][0]);
        sum_a2 += double(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[3];
} sb_out;

dmat2x4 a0[3] = dmat2x4[3](dmat2x4(sc0), dmat2x4(2), dmat2x4(3));
dmat2x4 a1[3] = dmat2x4[3](dmat2x4(1), dmat2x4(sc0), dmat2x4(3));
dmat2x4 a2[3] = dmat2x4[3](dmat2x4(1), dmat2x4(2), dmat2x4(sc0));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += double(a0[i][0][0]);
        sum_a1 += double(a1[i][0][0]);
        sum_a2 += double(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[3];
} sb_out;

dmat3x2 a0[3] = dmat3x2[3](dmat3x2(sc0), dmat3x2(2), dmat3x2(3));
dmat3x2 a1[3] = dmat3x2[3](dmat3x2(1), dmat3x2(sc0), dmat3x2(3));
dmat3x2 a2[3] = dmat3x2[3](dmat3x2(1), dmat3x2(2), dmat3x2(sc0));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += double(a0[i][0][0]);
        sum_a1 += double(a1[i][0][0]);
        sum_a2 += double(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[3];
} sb_out;

dmat3x4 a0[3] = dmat3x4[3](dmat3x4(sc0), dmat3x4(2), dmat3x4(3));
dmat3x4 a1[3] = dmat3x4[3](dmat3x4(1), dmat3x4(sc0), dmat3x4(3));
dmat3x4 a2[3] = dmat3x4[3](dmat3x4(1), dmat3x4(2), dmat3x4(sc0));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += double(a0[i][0][0]);
        sum_a1 += double(a1[i][0][0]);
        sum_a2 += double(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[3];
} sb_out;

dmat4x2 a0[3] = dmat4x2[3](dmat4x2(sc0), dmat4x2(2), dmat4x2(3));
dmat4x2 a1[3] = dmat4x2[3](dmat4x2(1), dmat4x2(sc0), dmat4x2(3));
dmat4x2 a2[3] = dmat4x2[3](dmat4x2(1), dmat4x2(2), dmat4x2(sc0));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += double(a0[i][0][0]);
        sum_a1 += double(a1[i][0][0]);
        sum_a2 += double(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[3];
} sb_out;

dmat4x3 a0[3] = dmat4x3[3](dmat4x3(sc0), dmat4x3(2), dmat4x3(3));
dmat4x3 a1[3] = dmat4x3[3](dmat4x3(1), dmat4x3(sc0), dmat4x3(3));
dmat4x3 a2[3] = dmat4x3[3](dmat4x3(1), dmat4x3(2), dmat4x3(sc0));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += double(a0[i][0][0]);
        sum_a1 += double(a1[i][0][0]);
        sum_a2 += double(a2[i][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int sc0 = int(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result[3];
} sb_out;

int a0[3] = int[3](sc0, 2, 3);
int a1[3] = int[3](1, sc0, 3);
int a2[3] = int[3](1, 2, sc0);


void main (void)
{
    int sum_a0 = int(0);
    int sum_a1 = int(0);
    int sum_a2 = int(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += int(a0[i]);
        sum_a1 += int(a1[i]);
        sum_a2 += int(a2[i]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const uint sc0 = uint(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint result[3];
} sb_out;

uint a0[3] = uint[3](sc0, 2, 3);
uint a1[3] = uint[3](1, sc0, 3);
uint a2[3] = uint[3](1, 2, sc0);


void main (void)
{
    uint sum_a0 = uint(0);
    uint sum_a1 = uint(0);
    uint sum_a2 = uint(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += uint(a0[i]);
        sum_a1 += uint(a1[i]);
        sum_a2 += uint(a2[i]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const bool sc0 = bool(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result[3];
} sb_out;

bool a0[3] = bool[3](sc0, true, true);
bool a1[3] = bool[3](true, sc0, true);
bool a2[3] = bool[3](true, true, sc0);


void main (void)
{
    int sum_a0 = int(0);
    int sum_a1 = int(0);
    int sum_a2 = int(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += int(a0[i]);
        sum_a1 += int(a1[i]);
        sum_a2 += int(a2[i]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

float a0[3][2] = float[3][2](float[2](sc0, 2),
                                    float[2](3, 4),
                                    float[2](5, 6));
float a1[3][2] = float[3][2](float[2](1, sc0),
                                    float[2](3, 4),
                                    float[2](5, 6));
float a2[3][2] = float[3][2](float[2](1, 2),
                                    float[2](sc0, 4),
                                    float[2](5, 6));
float a3[3][2] = float[3][2](float[2](1, 2),
                                    float[2](3, sc0),
                                    float[2](5, 6));
float a4[3][2] = float[3][2](float[2](1, 2),
                                    float[2](3, 4),
                                    float[2](sc0, 6));
float a5[3][2] = float[3][2](float[2](1, 2),
                                    float[2](3, 4),
                                    float[2](5, sc0));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);
    float sum_a3 = float(0);
    float sum_a4 = float(0);
    float sum_a5 = float(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += float(a0[i][j]);
        sum_a1 += float(a1[i][j]);
        sum_a2 += float(a2[i][j]);
        sum_a3 += float(a3[i][j]);
        sum_a4 += float(a4[i][j]);
        sum_a5 += float(a5[i][j]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

mat2x3 a0[3][2] = mat2x3[3][2](mat2x3[2](mat2x3(sc0), mat2x3(2)),
                                    mat2x3[2](mat2x3(3), mat2x3(4)),
                                    mat2x3[2](mat2x3(5), mat2x3(6)));
mat2x3 a1[3][2] = mat2x3[3][2](mat2x3[2](mat2x3(1), mat2x3(sc0)),
                                    mat2x3[2](mat2x3(3), mat2x3(4)),
                                    mat2x3[2](mat2x3(5), mat2x3(6)));
mat2x3 a2[3][2] = mat2x3[3][2](mat2x3[2](mat2x3(1), mat2x3(2)),
                                    mat2x3[2](mat2x3(sc0), mat2x3(4)),
                                    mat2x3[2](mat2x3(5), mat2x3(6)));
mat2x3 a3[3][2] = mat2x3[3][2](mat2x3[2](mat2x3(1), mat2x3(2)),
                                    mat2x3[2](mat2x3(3), mat2x3(sc0)),
                                    mat2x3[2](mat2x3(5), mat2x3(6)));
mat2x3 a4[3][2] = mat2x3[3][2](mat2x3[2](mat2x3(1), mat2x3(2)),
                                    mat2x3[2](mat2x3(3), mat2x3(4)),
                                    mat2x3[2](mat2x3(sc0), mat2x3(6)));
mat2x3 a5[3][2] = mat2x3[3][2](mat2x3[2](mat2x3(1), mat2x3(2)),
                                    mat2x3[2](mat2x3(3), mat2x3(4)),
                                    mat2x3[2](mat2x3(5), mat2x3(sc0)));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);
    float sum_a3 = float(0);
    float sum_a4 = float(0);
    float sum_a5 = float(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += float(a0[i][j][0][0]);
        sum_a1 += float(a1[i][j][0][0]);
        sum_a2 += float(a2[i][j][0][0]);
        sum_a3 += float(a3[i][j][0][0]);
        sum_a4 += float(a4[i][j][0][0]);
        sum_a5 += float(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

mat2x4 a0[3][2] = mat2x4[3][2](mat2x4[2](mat2x4(sc0), mat2x4(2)),
                                    mat2x4[2](mat2x4(3), mat2x4(4)),
                                    mat2x4[2](mat2x4(5), mat2x4(6)));
mat2x4 a1[3][2] = mat2x4[3][2](mat2x4[2](mat2x4(1), mat2x4(sc0)),
                                    mat2x4[2](mat2x4(3), mat2x4(4)),
                                    mat2x4[2](mat2x4(5), mat2x4(6)));
mat2x4 a2[3][2] = mat2x4[3][2](mat2x4[2](mat2x4(1), mat2x4(2)),
                                    mat2x4[2](mat2x4(sc0), mat2x4(4)),
                                    mat2x4[2](mat2x4(5), mat2x4(6)));
mat2x4 a3[3][2] = mat2x4[3][2](mat2x4[2](mat2x4(1), mat2x4(2)),
                                    mat2x4[2](mat2x4(3), mat2x4(sc0)),
                                    mat2x4[2](mat2x4(5), mat2x4(6)));
mat2x4 a4[3][2] = mat2x4[3][2](mat2x4[2](mat2x4(1), mat2x4(2)),
                                    mat2x4[2](mat2x4(3), mat2x4(4)),
                                    mat2x4[2](mat2x4(sc0), mat2x4(6)));
mat2x4 a5[3][2] = mat2x4[3][2](mat2x4[2](mat2x4(1), mat2x4(2)),
                                    mat2x4[2](mat2x4(3), mat2x4(4)),
                                    mat2x4[2](mat2x4(5), mat2x4(sc0)));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);
    float sum_a3 = float(0);
    float sum_a4 = float(0);
    float sum_a5 = float(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += float(a0[i][j][0][0]);
        sum_a1 += float(a1[i][j][0][0]);
        sum_a2 += float(a2[i][j][0][0]);
        sum_a3 += float(a3[i][j][0][0]);
        sum_a4 += float(a4[i][j][0][0]);
        sum_a5 += float(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

mat3x2 a0[3][2] = mat3x2[3][2](mat3x2[2](mat3x2(sc0), mat3x2(2)),
                                    mat3x2[2](mat3x2(3), mat3x2(4)),
                                    mat3x2[2](mat3x2(5), mat3x2(6)));
mat3x2 a1[3][2] = mat3x2[3][2](mat3x2[2](mat3x2(1), mat3x2(sc0)),
                                    mat3x2[2](mat3x2(3), mat3x2(4)),
                                    mat3x2[2](mat3x2(5), mat3x2(6)));
mat3x2 a2[3][2] = mat3x2[3][2](mat3x2[2](mat3x2(1), mat3x2(2)),
                                    mat3x2[2](mat3x2(sc0), mat3x2(4)),
                                    mat3x2[2](mat3x2(5), mat3x2(6)));
mat3x2 a3[3][2] = mat3x2[3][2](mat3x2[2](mat3x2(1), mat3x2(2)),
                                    mat3x2[2](mat3x2(3), mat3x2(sc0)),
                                    mat3x2[2](mat3x2(5), mat3x2(6)));
mat3x2 a4[3][2] = mat3x2[3][2](mat3x2[2](mat3x2(1), mat3x2(2)),
                                    mat3x2[2](mat3x2(3), mat3x2(4)),
                                    mat3x2[2](mat3x2(sc0), mat3x2(6)));
mat3x2 a5[3][2] = mat3x2[3][2](mat3x2[2](mat3x2(1), mat3x2(2)),
                                    mat3x2[2](mat3x2(3), mat3x2(4)),
                                    mat3x2[2](mat3x2(5), mat3x2(sc0)));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);
    float sum_a3 = float(0);
    float sum_a4 = float(0);
    float sum_a5 = float(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += float(a0[i][j][0][0]);
        sum_a1 += float(a1[i][j][0][0]);
        sum_a2 += float(a2[i][j][0][0]);
        sum_a3 += float(a3[i][j][0][0]);
        sum_a4 += float(a4[i][j][0][0]);
        sum_a5 += float(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

mat3x4 a0[3][2] = mat3x4[3][2](mat3x4[2](mat3x4(sc0), mat3x4(2)),
                                    mat3x4[2](mat3x4(3), mat3x4(4)),
                                    mat3x4[2](mat3x4(5), mat3x4(6)));
mat3x4 a1[3][2] = mat3x4[3][2](mat3x4[2](mat3x4(1), mat3x4(sc0)),
                                    mat3x4[2](mat3x4(3), mat3x4(4)),
                                    mat3x4[2](mat3x4(5), mat3x4(6)));
mat3x4 a2[3][2] = mat3x4[3][2](mat3x4[2](mat3x4(1), mat3x4(2)),
                                    mat3x4[2](mat3x4(sc0), mat3x4(4)),
                                    mat3x4[2](mat3x4(5), mat3x4(6)));
mat3x4 a3[3][2] = mat3x4[3][2](mat3x4[2](mat3x4(1), mat3x4(2)),
                                    mat3x4[2](mat3x4(3), mat3x4(sc0)),
                                    mat3x4[2](mat3x4(5), mat3x4(6)));
mat3x4 a4[3][2] = mat3x4[3][2](mat3x4[2](mat3x4(1), mat3x4(2)),
                                    mat3x4[2](mat3x4(3), mat3x4(4)),
                                    mat3x4[2](mat3x4(sc0), mat3x4(6)));
mat3x4 a5[3][2] = mat3x4[3][2](mat3x4[2](mat3x4(1), mat3x4(2)),
                                    mat3x4[2](mat3x4(3), mat3x4(4)),
                                    mat3x4[2](mat3x4(5), mat3x4(sc0)));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);
    float sum_a3 = float(0);
    float sum_a4 = float(0);
    float sum_a5 = float(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += float(a0[i][j][0][0]);
        sum_a1 += float(a1[i][j][0][0]);
        sum_a2 += float(a2[i][j][0][0]);
        sum_a3 += float(a3[i][j][0][0]);
        sum_a4 += float(a4[i][j][0][0]);
        sum_a5 += float(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

mat4x2 a0[3][2] = mat4x2[3][2](mat4x2[2](mat4x2(sc0), mat4x2(2)),
                                    mat4x2[2](mat4x2(3), mat4x2(4)),
                                    mat4x2[2](mat4x2(5), mat4x2(6)));
mat4x2 a1[3][2] = mat4x2[3][2](mat4x2[2](mat4x2(1), mat4x2(sc0)),
                                    mat4x2[2](mat4x2(3), mat4x2(4)),
                                    mat4x2[2](mat4x2(5), mat4x2(6)));
mat4x2 a2[3][2] = mat4x2[3][2](mat4x2[2](mat4x2(1), mat4x2(2)),
                                    mat4x2[2](mat4x2(sc0), mat4x2(4)),
                                    mat4x2[2](mat4x2(5), mat4x2(6)));
mat4x2 a3[3][2] = mat4x2[3][2](mat4x2[2](mat4x2(1), mat4x2(2)),
                                    mat4x2[2](mat4x2(3), mat4x2(sc0)),
                                    mat4x2[2](mat4x2(5), mat4x2(6)));
mat4x2 a4[3][2] = mat4x2[3][2](mat4x2[2](mat4x2(1), mat4x2(2)),
                                    mat4x2[2](mat4x2(3), mat4x2(4)),
                                    mat4x2[2](mat4x2(sc0), mat4x2(6)));
mat4x2 a5[3][2] = mat4x2[3][2](mat4x2[2](mat4x2(1), mat4x2(2)),
                                    mat4x2[2](mat4x2(3), mat4x2(4)),
                                    mat4x2[2](mat4x2(5), mat4x2(sc0)));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);
    float sum_a3 = float(0);
    float sum_a4 = float(0);
    float sum_a5 = float(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += float(a0[i][j][0][0]);
        sum_a1 += float(a1[i][j][0][0]);
        sum_a2 += float(a2[i][j][0][0]);
        sum_a3 += float(a3[i][j][0][0]);
        sum_a4 += float(a4[i][j][0][0]);
        sum_a5 += float(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

mat4x3 a0[3][2] = mat4x3[3][2](mat4x3[2](mat4x3(sc0), mat4x3(2)),
                                    mat4x3[2](mat4x3(3), mat4x3(4)),
                                    mat4x3[2](mat4x3(5), mat4x3(6)));
mat4x3 a1[3][2] = mat4x3[3][2](mat4x3[2](mat4x3(1), mat4x3(sc0)),
                                    mat4x3[2](mat4x3(3), mat4x3(4)),
                                    mat4x3[2](mat4x3(5), mat4x3(6)));
mat4x3 a2[3][2] = mat4x3[3][2](mat4x3[2](mat4x3(1), mat4x3(2)),
                                    mat4x3[2](mat4x3(sc0), mat4x3(4)),
                                    mat4x3[2](mat4x3(5), mat4x3(6)));
mat4x3 a3[3][2] = mat4x3[3][2](mat4x3[2](mat4x3(1), mat4x3(2)),
                                    mat4x3[2](mat4x3(3), mat4x3(sc0)),
                                    mat4x3[2](mat4x3(5), mat4x3(6)));
mat4x3 a4[3][2] = mat4x3[3][2](mat4x3[2](mat4x3(1), mat4x3(2)),
                                    mat4x3[2](mat4x3(3), mat4x3(4)),
                                    mat4x3[2](mat4x3(sc0), mat4x3(6)));
mat4x3 a5[3][2] = mat4x3[3][2](mat4x3[2](mat4x3(1), mat4x3(2)),
                                    mat4x3[2](mat4x3(3), mat4x3(4)),
                                    mat4x3[2](mat4x3(5), mat4x3(sc0)));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);
    float sum_a3 = float(0);
    float sum_a4 = float(0);
    float sum_a5 = float(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += float(a0[i][j][0][0]);
        sum_a1 += float(a1[i][j][0][0]);
        sum_a2 += float(a2[i][j][0][0]);
        sum_a3 += float(a3[i][j][0][0]);
        sum_a4 += float(a4[i][j][0][0]);
        sum_a5 += float(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

double a0[3][2] = double[3][2](double[2](sc0, 2),
                                    double[2](3, 4),
                                    double[2](5, 6));
double a1[3][2] = double[3][2](double[2](1, sc0),
                                    double[2](3, 4),
                                    double[2](5, 6));
double a2[3][2] = double[3][2](double[2](1, 2),
                                    double[2](sc0, 4),
                                    double[2](5, 6));
double a3[3][2] = double[3][2](double[2](1, 2),
                                    double[2](3, sc0),
                                    double[2](5, 6));
double a4[3][2] = double[3][2](double[2](1, 2),
                                    double[2](3, 4),
                                    double[2](sc0, 6));
double a5[3][2] = double[3][2](double[2](1, 2),
                                    double[2](3, 4),
                                    double[2](5, sc0));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);
    double sum_a3 = double(0);
    double sum_a4 = double(0);
    double sum_a5 = double(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += double(a0[i][j]);
        sum_a1 += double(a1[i][j]);
        sum_a2 += double(a2[i][j]);
        sum_a3 += double(a3[i][j]);
        sum_a4 += double(a4[i][j]);
        sum_a5 += double(a5[i][j]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

dmat2x3 a0[3][2] = dmat2x3[3][2](dmat2x3[2](dmat2x3(sc0), dmat2x3(2)),
                                    dmat2x3[2](dmat2x3(3), dmat2x3(4)),
                                    dmat2x3[2](dmat2x3(5), dmat2x3(6)));
dmat2x3 a1[3][2] = dmat2x3[3][2](dmat2x3[2](dmat2x3(1), dmat2x3(sc0)),
                                    dmat2x3[2](dmat2x3(3), dmat2x3(4)),
                                    dmat2x3[2](dmat2x3(5), dmat2x3(6)));
dmat2x3 a2[3][2] = dmat2x3[3][2](dmat2x3[2](dmat2x3(1), dmat2x3(2)),
                                    dmat2x3[2](dmat2x3(sc0), dmat2x3(4)),
                                    dmat2x3[2](dmat2x3(5), dmat2x3(6)));
dmat2x3 a3[3][2] = dmat2x3[3][2](dmat2x3[2](dmat2x3(1), dmat2x3(2)),
                                    dmat2x3[2](dmat2x3(3), dmat2x3(sc0)),
                                    dmat2x3[2](dmat2x3(5), dmat2x3(6)));
dmat2x3 a4[3][2] = dmat2x3[3][2](dmat2x3[2](dmat2x3(1), dmat2x3(2)),
                                    dmat2x3[2](dmat2x3(3), dmat2x3(4)),
                                    dmat2x3[2](dmat2x3(sc0), dmat2x3(6)));
dmat2x3 a5[3][2] = dmat2x3[3][2](dmat2x3[2](dmat2x3(1), dmat2x3(2)),
                                    dmat2x3[2](dmat2x3(3), dmat2x3(4)),
                                    dmat2x3[2](dmat2x3(5), dmat2x3(sc0)));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);
    double sum_a3 = double(0);
    double sum_a4 = double(0);
    double sum_a5 = double(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += double(a0[i][j][0][0]);
        sum_a1 += double(a1[i][j][0][0]);
        sum_a2 += double(a2[i][j][0][0]);
        sum_a3 += double(a3[i][j][0][0]);
        sum_a4 += double(a4[i][j][0][0]);
        sum_a5 += double(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

dmat2x4 a0[3][2] = dmat2x4[3][2](dmat2x4[2](dmat2x4(sc0), dmat2x4(2)),
                                    dmat2x4[2](dmat2x4(3), dmat2x4(4)),
                                    dmat2x4[2](dmat2x4(5), dmat2x4(6)));
dmat2x4 a1[3][2] = dmat2x4[3][2](dmat2x4[2](dmat2x4(1), dmat2x4(sc0)),
                                    dmat2x4[2](dmat2x4(3), dmat2x4(4)),
                                    dmat2x4[2](dmat2x4(5), dmat2x4(6)));
dmat2x4 a2[3][2] = dmat2x4[3][2](dmat2x4[2](dmat2x4(1), dmat2x4(2)),
                                    dmat2x4[2](dmat2x4(sc0), dmat2x4(4)),
                                    dmat2x4[2](dmat2x4(5), dmat2x4(6)));
dmat2x4 a3[3][2] = dmat2x4[3][2](dmat2x4[2](dmat2x4(1), dmat2x4(2)),
                                    dmat2x4[2](dmat2x4(3), dmat2x4(sc0)),
                                    dmat2x4[2](dmat2x4(5), dmat2x4(6)));
dmat2x4 a4[3][2] = dmat2x4[3][2](dmat2x4[2](dmat2x4(1), dmat2x4(2)),
                                    dmat2x4[2](dmat2x4(3), dmat2x4(4)),
                                    dmat2x4[2](dmat2x4(sc0), dmat2x4(6)));
dmat2x4 a5[3][2] = dmat2x4[3][2](dmat2x4[2](dmat2x4(1), dmat2x4(2)),
                                    dmat2x4[2](dmat2x4(3), dmat2x4(4)),
                                    dmat2x4[2](dmat2x4(5), dmat2x4(sc0)));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);
    double sum_a3 = double(0);
    double sum_a4 = double(0);
    double sum_a5 = double(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += double(a0[i][j][0][0]);
        sum_a1 += double(a1[i][j][0][0]);
        sum_a2 += double(a2[i][j][0][0]);
        sum_a3 += double(a3[i][j][0][0]);
        sum_a4 += double(a4[i][j][0][0]);
        sum_a5 += double(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

dmat3x2 a0[3][2] = dmat3x2[3][2](dmat3x2[2](dmat3x2(sc0), dmat3x2(2)),
                                    dmat3x2[2](dmat3x2(3), dmat3x2(4)),
                                    dmat3x2[2](dmat3x2(5), dmat3x2(6)));
dmat3x2 a1[3][2] = dmat3x2[3][2](dmat3x2[2](dmat3x2(1), dmat3x2(sc0)),
                                    dmat3x2[2](dmat3x2(3), dmat3x2(4)),
                                    dmat3x2[2](dmat3x2(5), dmat3x2(6)));
dmat3x2 a2[3][2] = dmat3x2[3][2](dmat3x2[2](dmat3x2(1), dmat3x2(2)),
                                    dmat3x2[2](dmat3x2(sc0), dmat3x2(4)),
                                    dmat3x2[2](dmat3x2(5), dmat3x2(6)));
dmat3x2 a3[3][2] = dmat3x2[3][2](dmat3x2[2](dmat3x2(1), dmat3x2(2)),
                                    dmat3x2[2](dmat3x2(3), dmat3x2(sc0)),
                                    dmat3x2[2](dmat3x2(5), dmat3x2(6)));
dmat3x2 a4[3][2] = dmat3x2[3][2](dmat3x2[2](dmat3x2(1), dmat3x2(2)),
                                    dmat3x2[2](dmat3x2(3), dmat3x2(4)),
                                    dmat3x2[2](dmat3x2(sc0), dmat3x2(6)));
dmat3x2 a5[3][2] = dmat3x2[3][2](dmat3x2[2](dmat3x2(1), dmat3x2(2)),
                                    dmat3x2[2](dmat3x2(3), dmat3x2(4)),
                                    dmat3x2[2](dmat3x2(5), dmat3x2(sc0)));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);
    double sum_a3 = double(0);
    double sum_a4 = double(0);
    double sum_a5 = double(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += double(a0[i][j][0][0]);
        sum_a1 += double(a1[i][j][0][0]);
        sum_a2 += double(a2[i][j][0][0]);
        sum_a3 += double(a3[i][j][0][0]);
        sum_a4 += double(a4[i][j][0][0]);
        sum_a5 += double(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

dmat3x4 a0[3][2] = dmat3x4[3][2](dmat3x4[2](dmat3x4(sc0), dmat3x4(2)),
                                    dmat3x4[2](dmat3x4(3), dmat3x4(4)),
                                    dmat3x4[2](dmat3x4(5), dmat3x4(6)));
dmat3x4 a1[3][2] = dmat3x4[3][2](dmat3x4[2](dmat3x4(1), dmat3x4(sc0)),
                                    dmat3x4[2](dmat3x4(3), dmat3x4(4)),
                                    dmat3x4[2](dmat3x4(5), dmat3x4(6)));
dmat3x4 a2[3][2] = dmat3x4[3][2](dmat3x4[2](dmat3x4(1), dmat3x4(2)),
                                    dmat3x4[2](dmat3x4(sc0), dmat3x4(4)),
                                    dmat3x4[2](dmat3x4(5), dmat3x4(6)));
dmat3x4 a3[3][2] = dmat3x4[3][2](dmat3x4[2](dmat3x4(1), dmat3x4(2)),
                                    dmat3x4[2](dmat3x4(3), dmat3x4(sc0)),
                                    dmat3x4[2](dmat3x4(5), dmat3x4(6)));
dmat3x4 a4[3][2] = dmat3x4[3][2](dmat3x4[2](dmat3x4(1), dmat3x4(2)),
                                    dmat3x4[2](dmat3x4(3), dmat3x4(4)),
                                    dmat3x4[2](dmat3x4(sc0), dmat3x4(6)));
dmat3x4 a5[3][2] = dmat3x4[3][2](dmat3x4[2](dmat3x4(1), dmat3x4(2)),
                                    dmat3x4[2](dmat3x4(3), dmat3x4(4)),
                                    dmat3x4[2](dmat3x4(5), dmat3x4(sc0)));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);
    double sum_a3 = double(0);
    double sum_a4 = double(0);
    double sum_a5 = double(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += double(a0[i][j][0][0]);
        sum_a1 += double(a1[i][j][0][0]);
        sum_a2 += double(a2[i][j][0][0]);
        sum_a3 += double(a3[i][j][0][0]);
        sum_a4 += double(a4[i][j][0][0]);
        sum_a5 += double(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

dmat4x2 a0[3][2] = dmat4x2[3][2](dmat4x2[2](dmat4x2(sc0), dmat4x2(2)),
                                    dmat4x2[2](dmat4x2(3), dmat4x2(4)),
                                    dmat4x2[2](dmat4x2(5), dmat4x2(6)));
dmat4x2 a1[3][2] = dmat4x2[3][2](dmat4x2[2](dmat4x2(1), dmat4x2(sc0)),
                                    dmat4x2[2](dmat4x2(3), dmat4x2(4)),
                                    dmat4x2[2](dmat4x2(5), dmat4x2(6)));
dmat4x2 a2[3][2] = dmat4x2[3][2](dmat4x2[2](dmat4x2(1), dmat4x2(2)),
                                    dmat4x2[2](dmat4x2(sc0), dmat4x2(4)),
                                    dmat4x2[2](dmat4x2(5), dmat4x2(6)));
dmat4x2 a3[3][2] = dmat4x2[3][2](dmat4x2[2](dmat4x2(1), dmat4x2(2)),
                                    dmat4x2[2](dmat4x2(3), dmat4x2(sc0)),
                                    dmat4x2[2](dmat4x2(5), dmat4x2(6)));
dmat4x2 a4[3][2] = dmat4x2[3][2](dmat4x2[2](dmat4x2(1), dmat4x2(2)),
                                    dmat4x2[2](dmat4x2(3), dmat4x2(4)),
                                    dmat4x2[2](dmat4x2(sc0), dmat4x2(6)));
dmat4x2 a5[3][2] = dmat4x2[3][2](dmat4x2[2](dmat4x2(1), dmat4x2(2)),
                                    dmat4x2[2](dmat4x2(3), dmat4x2(4)),
                                    dmat4x2[2](dmat4x2(5), dmat4x2(sc0)));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);
    double sum_a3 = double(0);
    double sum_a4 = double(0);
    double sum_a5 = double(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += double(a0[i][j][0][0]);
        sum_a1 += double(a1[i][j][0][0]);
        sum_a2 += double(a2[i][j][0][0]);
        sum_a3 += double(a3[i][j][0][0]);
        sum_a4 += double(a4[i][j][0][0]);
        sum_a5 += double(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

dmat4x3 a0[3][2] = dmat4x3[3][2](dmat4x3[2](dmat4x3(sc0), dmat4x3(2)),
                                    dmat4x3[2](dmat4x3(3), dmat4x3(4)),
                                    dmat4x3[2](dmat4x3(5), dmat4x3(6)));
dmat4x3 a1[3][2] = dmat4x3[3][2](dmat4x3[2](dmat4x3(1), dmat4x3(sc0)),
                                    dmat4x3[2](dmat4x3(3), dmat4x3(4)),
                                    dmat4x3[2](dmat4x3(5), dmat4x3(6)));
dmat4x3 a2[3][2] = dmat4x3[3][2](dmat4x3[2](dmat4x3(1), dmat4x3(2)),
                                    dmat4x3[2](dmat4x3(sc0), dmat4x3(4)),
                                    dmat4x3[2](dmat4x3(5), dmat4x3(6)));
dmat4x3 a3[3][2] = dmat4x3[3][2](dmat4x3[2](dmat4x3(1), dmat4x3(2)),
                                    dmat4x3[2](dmat4x3(3), dmat4x3(sc0)),
                                    dmat4x3[2](dmat4x3(5), dmat4x3(6)));
dmat4x3 a4[3][2] = dmat4x3[3][2](dmat4x3[2](dmat4x3(1), dmat4x3(2)),
                                    dmat4x3[2](dmat4x3(3), dmat4x3(4)),
                                    dmat4x3[2](dmat4x3(sc0), dmat4x3(6)));
dmat4x3 a5[3][2] = dmat4x3[3][2](dmat4x3[2](dmat4x3(1), dmat4x3(2)),
                                    dmat4x3[2](dmat4x3(3), dmat4x3(4)),
                                    dmat4x3[2](dmat4x3(5), dmat4x3(sc0)));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);
    double sum_a3 = double(0);
    double sum_a4 = double(0);
    double sum_a5 = double(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += double(a0[i][j][0][0]);
        sum_a1 += double(a1[i][j][0][0]);
        sum_a2 += double(a2[i][j][0][0]);
        sum_a3 += double(a3[i][j][0][0]);
        sum_a4 += double(a4[i][j][0][0]);
        sum_a5 += double(a5[i][j][0][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int sc0 = int(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result[6];
} sb_out;

int a0[3][2] = int[3][2](int[2](sc0, 2),
                                    int[2](3, 4),
                                    int[2](5, 6));
int a1[3][2] = int[3][2](int[2](1, sc0),
                                    int[2](3, 4),
                                    int[2](5, 6));
int a2[3][2] = int[3][2](int[2](1, 2),
                                    int[2](sc0, 4),
                                    int[2](5, 6));
int a3[3][2] = int[3][2](int[2](1, 2),
                                    int[2](3, sc0),
                                    int[2](5, 6));
int a4[3][2] = int[3][2](int[2](1, 2),
                                    int[2](3, 4),
                                    int[2](sc0, 6));
int a5[3][2] = int[3][2](int[2](1, 2),
                                    int[2](3, 4),
                                    int[2](5, sc0));


void main (void)
{
    int sum_a0 = int(0);
    int sum_a1 = int(0);
    int sum_a2 = int(0);
    int sum_a3 = int(0);
    int sum_a4 = int(0);
    int sum_a5 = int(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += int(a0[i][j]);
        sum_a1 += int(a1[i][j]);
        sum_a2 += int(a2[i][j]);
        sum_a3 += int(a3[i][j]);
        sum_a4 += int(a4[i][j]);
        sum_a5 += int(a5[i][j]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const uint sc0 = uint(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint result[6];
} sb_out;

uint a0[3][2] = uint[3][2](uint[2](sc0, 2),
                                    uint[2](3, 4),
                                    uint[2](5, 6));
uint a1[3][2] = uint[3][2](uint[2](1, sc0),
                                    uint[2](3, 4),
                                    uint[2](5, 6));
uint a2[3][2] = uint[3][2](uint[2](1, 2),
                                    uint[2](sc0, 4),
                                    uint[2](5, 6));
uint a3[3][2] = uint[3][2](uint[2](1, 2),
                                    uint[2](3, sc0),
                                    uint[2](5, 6));
uint a4[3][2] = uint[3][2](uint[2](1, 2),
                                    uint[2](3, 4),
                                    uint[2](sc0, 6));
uint a5[3][2] = uint[3][2](uint[2](1, 2),
                                    uint[2](3, 4),
                                    uint[2](5, sc0));


void main (void)
{
    uint sum_a0 = uint(0);
    uint sum_a1 = uint(0);
    uint sum_a2 = uint(0);
    uint sum_a3 = uint(0);
    uint sum_a4 = uint(0);
    uint sum_a5 = uint(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += uint(a0[i][j]);
        sum_a1 += uint(a1[i][j]);
        sum_a2 += uint(a2[i][j]);
        sum_a3 += uint(a3[i][j]);
        sum_a4 += uint(a4[i][j]);
        sum_a5 += uint(a5[i][j]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const bool sc0 = bool(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result[6];
} sb_out;

bool a0[3][2] = bool[3][2](bool[2](sc0, true),
                                    bool[2](true, true),
                                    bool[2](true, true));
bool a1[3][2] = bool[3][2](bool[2](true, sc0),
                                    bool[2](true, true),
                                    bool[2](true, true));
bool a2[3][2] = bool[3][2](bool[2](true, true),
                                    bool[2](sc0, true),
                                    bool[2](true, true));
bool a3[3][2] = bool[3][2](bool[2](true, true),
                                    bool[2](true, sc0),
                                    bool[2](true, true));
bool a4[3][2] = bool[3][2](bool[2](true, true),
                                    bool[2](true, true),
                                    bool[2](sc0, true));
bool a5[3][2] = bool[3][2](bool[2](true, true),
                                    bool[2](true, true),
                                    bool[2](true, sc0));


void main (void)
{
    int sum_a0 = int(0);
    int sum_a1 = int(0);
    int sum_a2 = int(0);
    int sum_a3 = int(0);
    int sum_a4 = int(0);
    int sum_a5 = int(0);

    for (int i = 0; i < 3; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_a0 += int(a0[i][j]);
        sum_a1 += int(a1[i][j]);
        sum_a2 += int(a2[i][j]);
        sum_a3 += int(a3[i][j]);
        sum_a4 += int(a4[i][j]);
        sum_a5 += int(a5[i][j]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int   sc0 = 1;
layout(constant_id = 2) const float sc1 = 1.0;
layout(constant_id = 3) const bool  sc2 = true;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result;
} sb_out;

struct Data {
    int   x;
    float y;
    bool  z;
};

Data a0[3] = Data[3](Data(sc0, 2.0, true), Data(1, sc1, true), Data(1, 2.0, sc2));


void main (void)
{
    int sum_a0 = 0;

    for (int i = 0; i < 3; ++i)
        sum_a0 += int(a0[i].x) + int(a0[i].y) + int(a0[i].z);

    sb_out.result = sum_a0;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    float sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, float(sc0), 8u);


void main (void)
{
    float sum_s0 = float(0);

    sum_s0 += float(s0.i);
    sum_s0 += float(s0.f);
    sum_s0 += float(s0.b);
    sum_s0 += float(s0.sc);
    sum_s0 += float(s0.ui);

    sb_out.result = sum_s0;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    mat2x3 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, mat2x3(sc0), 8u);


void main (void)
{
    float sum_s0 = float(0);

    sum_s0 += float(s0.i);
    sum_s0 += float(s0.f);
    sum_s0 += float(s0.b);
    sum_s0 += float(s0.sc[0][0]);
    sum_s0 += float(s0.ui);

    sb_out.result = sum_s0;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    mat2x4 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, mat2x4(sc0), 8u);


void main (void)
{
    float sum_s0 = float(0);

    sum_s0 += float(s0.i);
    sum_s0 += float(s0.f);
    sum_s0 += float(s0.b);
    sum_s0 += float(s0.sc[0][0]);
    sum_s0 += float(s0.ui);

    sb_out.result = sum_s0;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    mat3x2 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, mat3x2(sc0), 8u);


void main (void)
{
    float sum_s0 = float(0);

    sum_s0 += float(s0.i);
    sum_s0 += float(s0.f);
    sum_s0 += float(s0.b);
    sum_s0 += float(s0.sc[0][0]);
    sum_s0 += float(s0.ui);

    sb_out.result = sum_s0;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    mat3x4 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, mat3x4(sc0), 8u);


void main (void)
{
    float sum_s0 = float(0);

    sum_s0 += float(s0.i);
    sum_s0 += float(s0.f);
    sum_s0 += float(s0.b);
    sum_s0 += float(s0.sc[0][0]);
    sum_s0 += float(s0.ui);

    sb_out.result = sum_s0;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    mat4x2 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, mat4x2(sc0), 8u);


void main (void)
{
    float sum_s0 = float(0);

    sum_s0 += float(s0.i);
    sum_s0 += float(s0.f);
    sum_s0 += float(s0.b);
    sum_s0 += float(s0.sc[0][0]);
    sum_s0 += float(s0.ui);

    sb_out.result = sum_s0;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    mat4x3 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, mat4x3(sc0), 8u);


void main (void)
{
    float sum_s0 = float(0);

    sum_s0 += float(s0.i);
    sum_s0 += float(s0.f);
    sum_s0 += float(s0.b);
    sum_s0 += float(s0.sc[0][0]);
    sum_s0 += float(s0.ui);

    sb_out.result = sum_s0;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    double sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, double(sc0), 8u);


void main (void)
{
    double sum_s0 = double(0);

    sum_s0 += double(s0.i);
    sum_s0 += double(s0.f);
    sum_s0 += double(s0.b);
    sum_s0 += double(s0.sc);
    sum_s0 += double(s0.ui);

    sb_out.result = sum_s0;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    dmat2x3 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, dmat2x3(sc0), 8u);


void main (void)
{
    double sum_s0 = double(0);

    sum_s0 += double(s0.i);
    sum_s0 += double(s0.f);
    sum_s0 += double(s0.b);
    sum_s0 += double(s0.sc[0][0]);
    sum_s0 += double(s0.ui);

    sb_out.result = sum_s0;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    dmat2x4 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, dmat2x4(sc0), 8u);


void main (void)
{
    double sum_s0 = double(0);

    sum_s0 += double(s0.i);
    sum_s0 += double(s0.f);
    sum_s0 += double(s0.b);
    sum_s0 += double(s0.sc[0][0]);
    sum_s0 += double(s0.ui);

    sb_out.result = sum_s0;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    dmat3x2 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, dmat3x2(sc0), 8u);


void main (void)
{
    double sum_s0 = double(0);

    sum_s0 += double(s0.i);
    sum_s0 += double(s0.f);
    sum_s0 += double(s0.b);
    sum_s0 += double(s0.sc[0][0]);
    sum_s0 += double(s0.ui);

    sb_out.result = sum_s0;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    dmat3x4 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, dmat3x4(sc0), 8u);


void main (void)
{
    double sum_s0 = double(0);

    sum_s0 += double(s0.i);
    sum_s0 += double(s0.f);
    sum_s0 += double(s0.b);
    sum_s0 += double(s0.sc[0][0]);
    sum_s0 += double(s0.ui);

    sb_out.result = sum_s0;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    dmat4x2 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, dmat4x2(sc0), 8u);


void main (void)
{
    double sum_s0 = double(0);

    sum_s0 += double(s0.i);
    sum_s0 += double(s0.f);
    sum_s0 += double(s0.b);
    sum_s0 += double(s0.sc[0][0]);
    sum_s0 += double(s0.ui);

    sb_out.result = sum_s0;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    dmat4x3 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, dmat4x3(sc0), 8u);


void main (void)
{
    double sum_s0 = double(0);

    sum_s0 += double(s0.i);
    sum_s0 += double(s0.f);
    sum_s0 += double(s0.b);
    sum_s0 += double(s0.sc[0][0]);
    sum_s0 += double(s0.ui);

    sb_out.result = sum_s0;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int sc0 = int(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    int sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, int(sc0), 8u);


void main (void)
{
    int sum_s0 = int(0);

    sum_s0 += int(s0.i);
    sum_s0 += int(s0.f);
    sum_s0 += int(s0.b);
    sum_s0 += int(s0.sc);
    sum_s0 += int(s0.ui);

    sb_out.result = sum_s0;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const uint sc0 = uint(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    uint sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, uint(sc0), 8u);


void main (void)
{
    uint sum_s0 = uint(0);

    sum_s0 += uint(s0.i);
    sum_s0 += uint(s0.f);
    sum_s0 += uint(s0.b);
    sum_s0 += uint(s0.sc);
    sum_s0 += uint(s0.ui);

    sb_out.result = sum_s0;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const bool sc0 = bool(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    bool sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, bool(sc0), 8u);


void main (void)
{
    int sum_s0 = int(0);

    sum_s0 += int(s0.i);
    sum_s0 += int(s0.f);
    sum_s0 += int(s0.b);
    sum_s0 += int(s0.sc);
    sum_s0 += int(s0.ui);

    sb_out.result = sum_s0;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const float sc0 = 1.0;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result;
} sb_out;

struct Data {
    int  i;
    vec3 sc[3];
    bool b;
};

Data s0 = Data(1, vec3[3](vec3(2.0), vec3(sc0), vec3(4.0)), false);


void main (void)
{
    float sum_s0 = 0;

    sum_s0 += float(s0.i);
    sum_s0 += float(s0.sc[0][0]);
    sum_s0 += float(s0.sc[1][0]);
    sum_s0 += float(s0.sc[2][0]);
    sum_s0 += float(s0.b);

    sb_out.result = sum_s0;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
#version 450
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(constant_id = 1) const int sc0 = 1;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result;
} sb_out;

struct Nested {
    vec2  v;
    int   sc;
    float f;
};

struct Data {
    uint   ui;
    Nested s;
    bool   b;
};

Data s0 = Data(1u, Nested(vec2(2.0), sc0, 4.0), true);


void main (void)
{
    int sum_s0 = 0;

    sum_s0 += int(s0.ui);
    sum_s0 += int(s0.s.v[0]);
    sum_s0 += int(s0.s.sc);
    sum_s0 += int(s0.s.f);
    sum_s0 += int(s0.b);

    sb_out.result = sum_s0;

    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    EndPrimitive();
}
