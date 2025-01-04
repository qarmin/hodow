#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : require

// Don't define work group size, use the default or specialization constants

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
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : require

// Don't define work group size, use the default or specialization constants

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
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int16 : require

// Don't define work group size, use the default or specialization constants

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
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int16 : require

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const uint sc0 = 42u;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint r0;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require

// Don't define work group size, use the default or specialization constants

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
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require

// Don't define work group size, use the default or specialization constants

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
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const float sc0 = 7.5;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float r0;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const double sc0 = 2.75LF;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double r0;
} sb_out;



void main (void)
{
    sb_out.r0 = sc0;
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : require

// Don't define work group size, use the default or specialization constants

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
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : require

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_explicit_arithmetic_types_int16 : require
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : require

// Don't define work group size, use the default or specialization constants

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
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_explicit_arithmetic_types_int16 : require
#extension GL_EXT_shader_explicit_arithmetic_types_int8 : require

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants



layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r0;
} sb_out;



void main (void)
{
    sb_out.r0 = 77;
}
#version 450

// Don't define work group size, use the default or specialization constants


layout(constant_id = 1) const int sc1 = 0;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int r1;
} sb_out;



void main (void)
{
    sb_out.r1 = sc1;
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) gl_MaxImageUnits;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    bool ok;
} sb_out;



void main (void)
{
    sb_out.ok = (gl_MaxImageUnits >= 8);
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) gl_MaxImageUnits;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int maxImageUnits;
} sb_out;



void main (void)
{
    sb_out.maxImageUnits = gl_MaxImageUnits;
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[2];
} sb_out;

vec2 v0 = vec2(sc0, 2);
vec2 v1 = vec2(1, sc0);


void main (void)
{
    float sum_v0 = float(0);
    float sum_v1 = float(0);

    for (int i = 0; i < 2; ++i)
    {
        sum_v0 += float(v0[i]);
        sum_v1 += float(v1[i]);
    }

    sb_out.result[0] = sum_v0;
    sb_out.result[1] = sum_v1;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[3];
} sb_out;

vec3 v0 = vec3(sc0, 2, 3);
vec3 v1 = vec3(1, sc0, 3);
vec3 v2 = vec3(1, 2, sc0);


void main (void)
{
    float sum_v0 = float(0);
    float sum_v1 = float(0);
    float sum_v2 = float(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_v0 += float(v0[i]);
        sum_v1 += float(v1[i]);
        sum_v2 += float(v2[i]);
    }

    sb_out.result[0] = sum_v0;
    sb_out.result[1] = sum_v1;
    sb_out.result[2] = sum_v2;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[4];
} sb_out;

vec4 v0 = vec4(sc0, 2, 3, 4);
vec4 v1 = vec4(1, sc0, 3, 4);
vec4 v2 = vec4(1, 2, sc0, 4);
vec4 v3 = vec4(1, 2, 3, sc0);


void main (void)
{
    float sum_v0 = float(0);
    float sum_v1 = float(0);
    float sum_v2 = float(0);
    float sum_v3 = float(0);

    for (int i = 0; i < 4; ++i)
    {
        sum_v0 += float(v0[i]);
        sum_v1 += float(v1[i]);
        sum_v2 += float(v2[i]);
        sum_v3 += float(v3[i]);
    }

    sb_out.result[0] = sum_v0;
    sb_out.result[1] = sum_v1;
    sb_out.result[2] = sum_v2;
    sb_out.result[3] = sum_v3;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[2];
} sb_out;

dvec2 v0 = dvec2(sc0, 2);
dvec2 v1 = dvec2(1, sc0);


void main (void)
{
    double sum_v0 = double(0);
    double sum_v1 = double(0);

    for (int i = 0; i < 2; ++i)
    {
        sum_v0 += double(v0[i]);
        sum_v1 += double(v1[i]);
    }

    sb_out.result[0] = sum_v0;
    sb_out.result[1] = sum_v1;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[3];
} sb_out;

dvec3 v0 = dvec3(sc0, 2, 3);
dvec3 v1 = dvec3(1, sc0, 3);
dvec3 v2 = dvec3(1, 2, sc0);


void main (void)
{
    double sum_v0 = double(0);
    double sum_v1 = double(0);
    double sum_v2 = double(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_v0 += double(v0[i]);
        sum_v1 += double(v1[i]);
        sum_v2 += double(v2[i]);
    }

    sb_out.result[0] = sum_v0;
    sb_out.result[1] = sum_v1;
    sb_out.result[2] = sum_v2;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[4];
} sb_out;

dvec4 v0 = dvec4(sc0, 2, 3, 4);
dvec4 v1 = dvec4(1, sc0, 3, 4);
dvec4 v2 = dvec4(1, 2, sc0, 4);
dvec4 v3 = dvec4(1, 2, 3, sc0);


void main (void)
{
    double sum_v0 = double(0);
    double sum_v1 = double(0);
    double sum_v2 = double(0);
    double sum_v3 = double(0);

    for (int i = 0; i < 4; ++i)
    {
        sum_v0 += double(v0[i]);
        sum_v1 += double(v1[i]);
        sum_v2 += double(v2[i]);
        sum_v3 += double(v3[i]);
    }

    sb_out.result[0] = sum_v0;
    sb_out.result[1] = sum_v1;
    sb_out.result[2] = sum_v2;
    sb_out.result[3] = sum_v3;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const bool sc0 = bool(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result[2];
} sb_out;

const bvec2 v0 = bvec2(sc0, true);
const bvec2 v1 = bvec2(true, sc0);


void main (void)
{
    int sum_v0 = int(0);
    int sum_v1 = int(0);

    for (int i = 0; i < 2; ++i)
    {
        sum_v0 += int(v0[i]);
        sum_v1 += int(v1[i]);
    }

    sb_out.result[0] = sum_v0;
    sb_out.result[1] = sum_v1;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const bool sc0 = bool(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result[3];
} sb_out;

const bvec3 v0 = bvec3(sc0, true, true);
const bvec3 v1 = bvec3(true, sc0, true);
const bvec3 v2 = bvec3(true, true, sc0);


void main (void)
{
    int sum_v0 = int(0);
    int sum_v1 = int(0);
    int sum_v2 = int(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_v0 += int(v0[i]);
        sum_v1 += int(v1[i]);
        sum_v2 += int(v2[i]);
    }

    sb_out.result[0] = sum_v0;
    sb_out.result[1] = sum_v1;
    sb_out.result[2] = sum_v2;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const bool sc0 = bool(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result[4];
} sb_out;

const bvec4 v0 = bvec4(sc0, true, true, true);
const bvec4 v1 = bvec4(true, sc0, true, true);
const bvec4 v2 = bvec4(true, true, sc0, true);
const bvec4 v3 = bvec4(true, true, true, sc0);


void main (void)
{
    int sum_v0 = int(0);
    int sum_v1 = int(0);
    int sum_v2 = int(0);
    int sum_v3 = int(0);

    for (int i = 0; i < 4; ++i)
    {
        sum_v0 += int(v0[i]);
        sum_v1 += int(v1[i]);
        sum_v2 += int(v2[i]);
        sum_v3 += int(v3[i]);
    }

    sb_out.result[0] = sum_v0;
    sb_out.result[1] = sum_v1;
    sb_out.result[2] = sum_v2;
    sb_out.result[3] = sum_v3;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const int sc0 = int(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result[2];
} sb_out;

const ivec2 v0 = ivec2(sc0, 2);
const ivec2 v1 = ivec2(1, sc0);


void main (void)
{
    int sum_v0 = int(0);
    int sum_v1 = int(0);

    for (int i = 0; i < 2; ++i)
    {
        sum_v0 += int(v0[i]);
        sum_v1 += int(v1[i]);
    }

    sb_out.result[0] = sum_v0;
    sb_out.result[1] = sum_v1;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const int sc0 = int(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result[3];
} sb_out;

const ivec3 v0 = ivec3(sc0, 2, 3);
const ivec3 v1 = ivec3(1, sc0, 3);
const ivec3 v2 = ivec3(1, 2, sc0);


void main (void)
{
    int sum_v0 = int(0);
    int sum_v1 = int(0);
    int sum_v2 = int(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_v0 += int(v0[i]);
        sum_v1 += int(v1[i]);
        sum_v2 += int(v2[i]);
    }

    sb_out.result[0] = sum_v0;
    sb_out.result[1] = sum_v1;
    sb_out.result[2] = sum_v2;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const int sc0 = int(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result[4];
} sb_out;

const ivec4 v0 = ivec4(sc0, 2, 3, 4);
const ivec4 v1 = ivec4(1, sc0, 3, 4);
const ivec4 v2 = ivec4(1, 2, sc0, 4);
const ivec4 v3 = ivec4(1, 2, 3, sc0);


void main (void)
{
    int sum_v0 = int(0);
    int sum_v1 = int(0);
    int sum_v2 = int(0);
    int sum_v3 = int(0);

    for (int i = 0; i < 4; ++i)
    {
        sum_v0 += int(v0[i]);
        sum_v1 += int(v1[i]);
        sum_v2 += int(v2[i]);
        sum_v3 += int(v3[i]);
    }

    sb_out.result[0] = sum_v0;
    sb_out.result[1] = sum_v1;
    sb_out.result[2] = sum_v2;
    sb_out.result[3] = sum_v3;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const uint sc0 = uint(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint result[2];
} sb_out;

const uvec2 v0 = uvec2(sc0, 2);
const uvec2 v1 = uvec2(1, sc0);


void main (void)
{
    uint sum_v0 = uint(0);
    uint sum_v1 = uint(0);

    for (int i = 0; i < 2; ++i)
    {
        sum_v0 += uint(v0[i]);
        sum_v1 += uint(v1[i]);
    }

    sb_out.result[0] = sum_v0;
    sb_out.result[1] = sum_v1;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const uint sc0 = uint(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint result[3];
} sb_out;

const uvec3 v0 = uvec3(sc0, 2, 3);
const uvec3 v1 = uvec3(1, sc0, 3);
const uvec3 v2 = uvec3(1, 2, sc0);


void main (void)
{
    uint sum_v0 = uint(0);
    uint sum_v1 = uint(0);
    uint sum_v2 = uint(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_v0 += uint(v0[i]);
        sum_v1 += uint(v1[i]);
        sum_v2 += uint(v2[i]);
    }

    sb_out.result[0] = sum_v0;
    sb_out.result[1] = sum_v1;
    sb_out.result[2] = sum_v2;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const uint sc0 = uint(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint result[4];
} sb_out;

const uvec4 v0 = uvec4(sc0, 2, 3, 4);
const uvec4 v1 = uvec4(1, sc0, 3, 4);
const uvec4 v2 = uvec4(1, 2, sc0, 4);
const uvec4 v3 = uvec4(1, 2, 3, sc0);


void main (void)
{
    uint sum_v0 = uint(0);
    uint sum_v1 = uint(0);
    uint sum_v2 = uint(0);
    uint sum_v3 = uint(0);

    for (int i = 0; i < 4; ++i)
    {
        sum_v0 += uint(v0[i]);
        sum_v1 += uint(v1[i]);
        sum_v2 += uint(v2[i]);
        sum_v3 += uint(v3[i]);
    }

    sb_out.result[0] = sum_v0;
    sb_out.result[1] = sum_v1;
    sb_out.result[2] = sum_v2;
    sb_out.result[3] = sum_v3;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[4];
} sb_out;

mat2 m0 = mat2(sc0, 2, 3, 4);
mat2 m1 = mat2(1, sc0, 3, 4);
mat2 m2 = mat2(1, 2, sc0, 4);
mat2 m3 = mat2(1, 2, 3, sc0);


void main (void)
{
    float sum_m0 = float(0);
    float sum_m1 = float(0);
    float sum_m2 = float(0);
    float sum_m3 = float(0);

    for (int i = 0; i < 2; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_m0 += float(m0[i][j]);
        sum_m1 += float(m1[i][j]);
        sum_m2 += float(m2[i][j]);
        sum_m3 += float(m3[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[9];
} sb_out;

mat3 m0 = mat3(sc0, 2, 3, 4, 5, 6, 7, 8, 9);
mat3 m1 = mat3(1, sc0, 3, 4, 5, 6, 7, 8, 9);
mat3 m2 = mat3(1, 2, sc0, 4, 5, 6, 7, 8, 9);
mat3 m3 = mat3(1, 2, 3, sc0, 5, 6, 7, 8, 9);
mat3 m4 = mat3(1, 2, 3, 4, sc0, 6, 7, 8, 9);
mat3 m5 = mat3(1, 2, 3, 4, 5, sc0, 7, 8, 9);
mat3 m6 = mat3(1, 2, 3, 4, 5, 6, sc0, 8, 9);
mat3 m7 = mat3(1, 2, 3, 4, 5, 6, 7, sc0, 9);
mat3 m8 = mat3(1, 2, 3, 4, 5, 6, 7, 8, sc0);


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

    for (int i = 0; i < 3; ++i)
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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[16];
} sb_out;

mat4 m0 = mat4(sc0, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);
mat4 m1 = mat4(1, sc0, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);
mat4 m2 = mat4(1, 2, sc0, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);
mat4 m3 = mat4(1, 2, 3, sc0, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);
mat4 m4 = mat4(1, 2, 3, 4, sc0, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);
mat4 m5 = mat4(1, 2, 3, 4, 5, sc0, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);
mat4 m6 = mat4(1, 2, 3, 4, 5, 6, sc0, 8, 9, 10, 11, 12, 13, 14, 15, 16);
mat4 m7 = mat4(1, 2, 3, 4, 5, 6, 7, sc0, 9, 10, 11, 12, 13, 14, 15, 16);
mat4 m8 = mat4(1, 2, 3, 4, 5, 6, 7, 8, sc0, 10, 11, 12, 13, 14, 15, 16);
mat4 m9 = mat4(1, 2, 3, 4, 5, 6, 7, 8, 9, sc0, 11, 12, 13, 14, 15, 16);
mat4 m10 = mat4(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, sc0, 12, 13, 14, 15, 16);
mat4 m11 = mat4(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, sc0, 13, 14, 15, 16);
mat4 m12 = mat4(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, sc0, 14, 15, 16);
mat4 m13 = mat4(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, sc0, 15, 16);
mat4 m14 = mat4(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, sc0, 16);
mat4 m15 = mat4(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, sc0);


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
    float sum_m12 = float(0);
    float sum_m13 = float(0);
    float sum_m14 = float(0);
    float sum_m15 = float(0);

    for (int i = 0; i < 4; ++i)
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
        sum_m12 += float(m12[i][j]);
        sum_m13 += float(m13[i][j]);
        sum_m14 += float(m14[i][j]);
        sum_m15 += float(m15[i][j]);
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
    sb_out.result[12] = sum_m12;
    sb_out.result[13] = sum_m13;
    sb_out.result[14] = sum_m14;
    sb_out.result[15] = sum_m15;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[4];
} sb_out;

dmat2 m0 = dmat2(sc0, 2, 3, 4);
dmat2 m1 = dmat2(1, sc0, 3, 4);
dmat2 m2 = dmat2(1, 2, sc0, 4);
dmat2 m3 = dmat2(1, 2, 3, sc0);


void main (void)
{
    double sum_m0 = double(0);
    double sum_m1 = double(0);
    double sum_m2 = double(0);
    double sum_m3 = double(0);

    for (int i = 0; i < 2; ++i)
    for (int j = 0; j < 2; ++j)
    {
        sum_m0 += double(m0[i][j]);
        sum_m1 += double(m1[i][j]);
        sum_m2 += double(m2[i][j]);
        sum_m3 += double(m3[i][j]);
    }

    sb_out.result[0] = sum_m0;
    sb_out.result[1] = sum_m1;
    sb_out.result[2] = sum_m2;
    sb_out.result[3] = sum_m3;
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[9];
} sb_out;

dmat3 m0 = dmat3(sc0, 2, 3, 4, 5, 6, 7, 8, 9);
dmat3 m1 = dmat3(1, sc0, 3, 4, 5, 6, 7, 8, 9);
dmat3 m2 = dmat3(1, 2, sc0, 4, 5, 6, 7, 8, 9);
dmat3 m3 = dmat3(1, 2, 3, sc0, 5, 6, 7, 8, 9);
dmat3 m4 = dmat3(1, 2, 3, 4, sc0, 6, 7, 8, 9);
dmat3 m5 = dmat3(1, 2, 3, 4, 5, sc0, 7, 8, 9);
dmat3 m6 = dmat3(1, 2, 3, 4, 5, 6, sc0, 8, 9);
dmat3 m7 = dmat3(1, 2, 3, 4, 5, 6, 7, sc0, 9);
dmat3 m8 = dmat3(1, 2, 3, 4, 5, 6, 7, 8, sc0);


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

    for (int i = 0; i < 3; ++i)
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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[16];
} sb_out;

dmat4 m0 = dmat4(sc0, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);
dmat4 m1 = dmat4(1, sc0, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);
dmat4 m2 = dmat4(1, 2, sc0, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);
dmat4 m3 = dmat4(1, 2, 3, sc0, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);
dmat4 m4 = dmat4(1, 2, 3, 4, sc0, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);
dmat4 m5 = dmat4(1, 2, 3, 4, 5, sc0, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);
dmat4 m6 = dmat4(1, 2, 3, 4, 5, 6, sc0, 8, 9, 10, 11, 12, 13, 14, 15, 16);
dmat4 m7 = dmat4(1, 2, 3, 4, 5, 6, 7, sc0, 9, 10, 11, 12, 13, 14, 15, 16);
dmat4 m8 = dmat4(1, 2, 3, 4, 5, 6, 7, 8, sc0, 10, 11, 12, 13, 14, 15, 16);
dmat4 m9 = dmat4(1, 2, 3, 4, 5, 6, 7, 8, 9, sc0, 11, 12, 13, 14, 15, 16);
dmat4 m10 = dmat4(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, sc0, 12, 13, 14, 15, 16);
dmat4 m11 = dmat4(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, sc0, 13, 14, 15, 16);
dmat4 m12 = dmat4(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, sc0, 14, 15, 16);
dmat4 m13 = dmat4(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, sc0, 15, 16);
dmat4 m14 = dmat4(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, sc0, 16);
dmat4 m15 = dmat4(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, sc0);


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
    double sum_m12 = double(0);
    double sum_m13 = double(0);
    double sum_m14 = double(0);
    double sum_m15 = double(0);

    for (int i = 0; i < 4; ++i)
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
        sum_m12 += double(m12[i][j]);
        sum_m13 += double(m13[i][j]);
        sum_m14 += double(m14[i][j]);
        sum_m15 += double(m15[i][j]);
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
    sb_out.result[12] = sum_m12;
    sb_out.result[13] = sum_m13;
    sb_out.result[14] = sum_m14;
    sb_out.result[15] = sum_m15;
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[3];
} sb_out;

vec2 a0[3] = vec2[3](vec2(sc0), vec2(2), vec2(3));
vec2 a1[3] = vec2[3](vec2(1), vec2(sc0), vec2(3));
vec2 a2[3] = vec2[3](vec2(1), vec2(2), vec2(sc0));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += float(a0[i][0]);
        sum_a1 += float(a1[i][0]);
        sum_a2 += float(a2[i][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[3];
} sb_out;

vec3 a0[3] = vec3[3](vec3(sc0), vec3(2), vec3(3));
vec3 a1[3] = vec3[3](vec3(1), vec3(sc0), vec3(3));
vec3 a2[3] = vec3[3](vec3(1), vec3(2), vec3(sc0));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += float(a0[i][0]);
        sum_a1 += float(a1[i][0]);
        sum_a2 += float(a2[i][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[3];
} sb_out;

vec4 a0[3] = vec4[3](vec4(sc0), vec4(2), vec4(3));
vec4 a1[3] = vec4[3](vec4(1), vec4(sc0), vec4(3));
vec4 a2[3] = vec4[3](vec4(1), vec4(2), vec4(sc0));


void main (void)
{
    float sum_a0 = float(0);
    float sum_a1 = float(0);
    float sum_a2 = float(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += float(a0[i][0]);
        sum_a1 += float(a1[i][0]);
        sum_a2 += float(a2[i][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[3];
} sb_out;

mat2 a0[3] = mat2[3](mat2(sc0), mat2(2), mat2(3));
mat2 a1[3] = mat2[3](mat2(1), mat2(sc0), mat2(3));
mat2 a2[3] = mat2[3](mat2(1), mat2(2), mat2(sc0));


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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[3];
} sb_out;

mat3 a0[3] = mat3[3](mat3(sc0), mat3(2), mat3(3));
mat3 a1[3] = mat3[3](mat3(1), mat3(sc0), mat3(3));
mat3 a2[3] = mat3[3](mat3(1), mat3(2), mat3(sc0));


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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[3];
} sb_out;

mat4 a0[3] = mat4[3](mat4(sc0), mat4(2), mat4(3));
mat4 a1[3] = mat4[3](mat4(1), mat4(sc0), mat4(3));
mat4 a2[3] = mat4[3](mat4(1), mat4(2), mat4(sc0));


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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[3];
} sb_out;

dvec2 a0[3] = dvec2[3](dvec2(sc0), dvec2(2), dvec2(3));
dvec2 a1[3] = dvec2[3](dvec2(1), dvec2(sc0), dvec2(3));
dvec2 a2[3] = dvec2[3](dvec2(1), dvec2(2), dvec2(sc0));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += double(a0[i][0]);
        sum_a1 += double(a1[i][0]);
        sum_a2 += double(a2[i][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[3];
} sb_out;

dvec3 a0[3] = dvec3[3](dvec3(sc0), dvec3(2), dvec3(3));
dvec3 a1[3] = dvec3[3](dvec3(1), dvec3(sc0), dvec3(3));
dvec3 a2[3] = dvec3[3](dvec3(1), dvec3(2), dvec3(sc0));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += double(a0[i][0]);
        sum_a1 += double(a1[i][0]);
        sum_a2 += double(a2[i][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[3];
} sb_out;

dvec4 a0[3] = dvec4[3](dvec4(sc0), dvec4(2), dvec4(3));
dvec4 a1[3] = dvec4[3](dvec4(1), dvec4(sc0), dvec4(3));
dvec4 a2[3] = dvec4[3](dvec4(1), dvec4(2), dvec4(sc0));


void main (void)
{
    double sum_a0 = double(0);
    double sum_a1 = double(0);
    double sum_a2 = double(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += double(a0[i][0]);
        sum_a1 += double(a1[i][0]);
        sum_a2 += double(a2[i][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[3];
} sb_out;

dmat2 a0[3] = dmat2[3](dmat2(sc0), dmat2(2), dmat2(3));
dmat2 a1[3] = dmat2[3](dmat2(1), dmat2(sc0), dmat2(3));
dmat2 a2[3] = dmat2[3](dmat2(1), dmat2(2), dmat2(sc0));


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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[3];
} sb_out;

dmat3 a0[3] = dmat3[3](dmat3(sc0), dmat3(2), dmat3(3));
dmat3 a1[3] = dmat3[3](dmat3(1), dmat3(sc0), dmat3(3));
dmat3 a2[3] = dmat3[3](dmat3(1), dmat3(2), dmat3(sc0));


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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[3];
} sb_out;

dmat4 a0[3] = dmat4[3](dmat4(sc0), dmat4(2), dmat4(3));
dmat4 a1[3] = dmat4[3](dmat4(1), dmat4(sc0), dmat4(3));
dmat4 a2[3] = dmat4[3](dmat4(1), dmat4(2), dmat4(sc0));


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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const int sc0 = int(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result[3];
} sb_out;

ivec2 a0[3] = ivec2[3](ivec2(sc0), ivec2(2), ivec2(3));
ivec2 a1[3] = ivec2[3](ivec2(1), ivec2(sc0), ivec2(3));
ivec2 a2[3] = ivec2[3](ivec2(1), ivec2(2), ivec2(sc0));


void main (void)
{
    int sum_a0 = int(0);
    int sum_a1 = int(0);
    int sum_a2 = int(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += int(a0[i][0]);
        sum_a1 += int(a1[i][0]);
        sum_a2 += int(a2[i][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const int sc0 = int(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result[3];
} sb_out;

ivec3 a0[3] = ivec3[3](ivec3(sc0), ivec3(2), ivec3(3));
ivec3 a1[3] = ivec3[3](ivec3(1), ivec3(sc0), ivec3(3));
ivec3 a2[3] = ivec3[3](ivec3(1), ivec3(2), ivec3(sc0));


void main (void)
{
    int sum_a0 = int(0);
    int sum_a1 = int(0);
    int sum_a2 = int(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += int(a0[i][0]);
        sum_a1 += int(a1[i][0]);
        sum_a2 += int(a2[i][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const int sc0 = int(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result[3];
} sb_out;

ivec4 a0[3] = ivec4[3](ivec4(sc0), ivec4(2), ivec4(3));
ivec4 a1[3] = ivec4[3](ivec4(1), ivec4(sc0), ivec4(3));
ivec4 a2[3] = ivec4[3](ivec4(1), ivec4(2), ivec4(sc0));


void main (void)
{
    int sum_a0 = int(0);
    int sum_a1 = int(0);
    int sum_a2 = int(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += int(a0[i][0]);
        sum_a1 += int(a1[i][0]);
        sum_a2 += int(a2[i][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const uint sc0 = uint(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint result[3];
} sb_out;

uvec2 a0[3] = uvec2[3](uvec2(sc0), uvec2(2), uvec2(3));
uvec2 a1[3] = uvec2[3](uvec2(1), uvec2(sc0), uvec2(3));
uvec2 a2[3] = uvec2[3](uvec2(1), uvec2(2), uvec2(sc0));


void main (void)
{
    uint sum_a0 = uint(0);
    uint sum_a1 = uint(0);
    uint sum_a2 = uint(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += uint(a0[i][0]);
        sum_a1 += uint(a1[i][0]);
        sum_a2 += uint(a2[i][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const uint sc0 = uint(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint result[3];
} sb_out;

uvec3 a0[3] = uvec3[3](uvec3(sc0), uvec3(2), uvec3(3));
uvec3 a1[3] = uvec3[3](uvec3(1), uvec3(sc0), uvec3(3));
uvec3 a2[3] = uvec3[3](uvec3(1), uvec3(2), uvec3(sc0));


void main (void)
{
    uint sum_a0 = uint(0);
    uint sum_a1 = uint(0);
    uint sum_a2 = uint(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += uint(a0[i][0]);
        sum_a1 += uint(a1[i][0]);
        sum_a2 += uint(a2[i][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const uint sc0 = uint(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint result[3];
} sb_out;

uvec4 a0[3] = uvec4[3](uvec4(sc0), uvec4(2), uvec4(3));
uvec4 a1[3] = uvec4[3](uvec4(1), uvec4(sc0), uvec4(3));
uvec4 a2[3] = uvec4[3](uvec4(1), uvec4(2), uvec4(sc0));


void main (void)
{
    uint sum_a0 = uint(0);
    uint sum_a1 = uint(0);
    uint sum_a2 = uint(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += uint(a0[i][0]);
        sum_a1 += uint(a1[i][0]);
        sum_a2 += uint(a2[i][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const bool sc0 = bool(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result[3];
} sb_out;

bvec2 a0[3] = bvec2[3](bvec2(sc0), bvec2(true), bvec2(true));
bvec2 a1[3] = bvec2[3](bvec2(true), bvec2(sc0), bvec2(true));
bvec2 a2[3] = bvec2[3](bvec2(true), bvec2(true), bvec2(sc0));


void main (void)
{
    int sum_a0 = int(0);
    int sum_a1 = int(0);
    int sum_a2 = int(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += int(a0[i][0]);
        sum_a1 += int(a1[i][0]);
        sum_a2 += int(a2[i][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const bool sc0 = bool(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result[3];
} sb_out;

bvec3 a0[3] = bvec3[3](bvec3(sc0), bvec3(true), bvec3(true));
bvec3 a1[3] = bvec3[3](bvec3(true), bvec3(sc0), bvec3(true));
bvec3 a2[3] = bvec3[3](bvec3(true), bvec3(true), bvec3(sc0));


void main (void)
{
    int sum_a0 = int(0);
    int sum_a1 = int(0);
    int sum_a2 = int(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += int(a0[i][0]);
        sum_a1 += int(a1[i][0]);
        sum_a2 += int(a2[i][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const bool sc0 = bool(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result[3];
} sb_out;

bvec4 a0[3] = bvec4[3](bvec4(sc0), bvec4(true), bvec4(true));
bvec4 a1[3] = bvec4[3](bvec4(true), bvec4(sc0), bvec4(true));
bvec4 a2[3] = bvec4[3](bvec4(true), bvec4(true), bvec4(sc0));


void main (void)
{
    int sum_a0 = int(0);
    int sum_a1 = int(0);
    int sum_a2 = int(0);

    for (int i = 0; i < 3; ++i)
    {
        sum_a0 += int(a0[i][0]);
        sum_a1 += int(a1[i][0]);
        sum_a2 += int(a2[i][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

vec2 a0[3][2] = vec2[3][2](vec2[2](vec2(sc0), vec2(2)),
                                    vec2[2](vec2(3), vec2(4)),
                                    vec2[2](vec2(5), vec2(6)));
vec2 a1[3][2] = vec2[3][2](vec2[2](vec2(1), vec2(sc0)),
                                    vec2[2](vec2(3), vec2(4)),
                                    vec2[2](vec2(5), vec2(6)));
vec2 a2[3][2] = vec2[3][2](vec2[2](vec2(1), vec2(2)),
                                    vec2[2](vec2(sc0), vec2(4)),
                                    vec2[2](vec2(5), vec2(6)));
vec2 a3[3][2] = vec2[3][2](vec2[2](vec2(1), vec2(2)),
                                    vec2[2](vec2(3), vec2(sc0)),
                                    vec2[2](vec2(5), vec2(6)));
vec2 a4[3][2] = vec2[3][2](vec2[2](vec2(1), vec2(2)),
                                    vec2[2](vec2(3), vec2(4)),
                                    vec2[2](vec2(sc0), vec2(6)));
vec2 a5[3][2] = vec2[3][2](vec2[2](vec2(1), vec2(2)),
                                    vec2[2](vec2(3), vec2(4)),
                                    vec2[2](vec2(5), vec2(sc0)));


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
        sum_a0 += float(a0[i][j][0]);
        sum_a1 += float(a1[i][j][0]);
        sum_a2 += float(a2[i][j][0]);
        sum_a3 += float(a3[i][j][0]);
        sum_a4 += float(a4[i][j][0]);
        sum_a5 += float(a5[i][j][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

vec3 a0[3][2] = vec3[3][2](vec3[2](vec3(sc0), vec3(2)),
                                    vec3[2](vec3(3), vec3(4)),
                                    vec3[2](vec3(5), vec3(6)));
vec3 a1[3][2] = vec3[3][2](vec3[2](vec3(1), vec3(sc0)),
                                    vec3[2](vec3(3), vec3(4)),
                                    vec3[2](vec3(5), vec3(6)));
vec3 a2[3][2] = vec3[3][2](vec3[2](vec3(1), vec3(2)),
                                    vec3[2](vec3(sc0), vec3(4)),
                                    vec3[2](vec3(5), vec3(6)));
vec3 a3[3][2] = vec3[3][2](vec3[2](vec3(1), vec3(2)),
                                    vec3[2](vec3(3), vec3(sc0)),
                                    vec3[2](vec3(5), vec3(6)));
vec3 a4[3][2] = vec3[3][2](vec3[2](vec3(1), vec3(2)),
                                    vec3[2](vec3(3), vec3(4)),
                                    vec3[2](vec3(sc0), vec3(6)));
vec3 a5[3][2] = vec3[3][2](vec3[2](vec3(1), vec3(2)),
                                    vec3[2](vec3(3), vec3(4)),
                                    vec3[2](vec3(5), vec3(sc0)));


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
        sum_a0 += float(a0[i][j][0]);
        sum_a1 += float(a1[i][j][0]);
        sum_a2 += float(a2[i][j][0]);
        sum_a3 += float(a3[i][j][0]);
        sum_a4 += float(a4[i][j][0]);
        sum_a5 += float(a5[i][j][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

vec4 a0[3][2] = vec4[3][2](vec4[2](vec4(sc0), vec4(2)),
                                    vec4[2](vec4(3), vec4(4)),
                                    vec4[2](vec4(5), vec4(6)));
vec4 a1[3][2] = vec4[3][2](vec4[2](vec4(1), vec4(sc0)),
                                    vec4[2](vec4(3), vec4(4)),
                                    vec4[2](vec4(5), vec4(6)));
vec4 a2[3][2] = vec4[3][2](vec4[2](vec4(1), vec4(2)),
                                    vec4[2](vec4(sc0), vec4(4)),
                                    vec4[2](vec4(5), vec4(6)));
vec4 a3[3][2] = vec4[3][2](vec4[2](vec4(1), vec4(2)),
                                    vec4[2](vec4(3), vec4(sc0)),
                                    vec4[2](vec4(5), vec4(6)));
vec4 a4[3][2] = vec4[3][2](vec4[2](vec4(1), vec4(2)),
                                    vec4[2](vec4(3), vec4(4)),
                                    vec4[2](vec4(sc0), vec4(6)));
vec4 a5[3][2] = vec4[3][2](vec4[2](vec4(1), vec4(2)),
                                    vec4[2](vec4(3), vec4(4)),
                                    vec4[2](vec4(5), vec4(sc0)));


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
        sum_a0 += float(a0[i][j][0]);
        sum_a1 += float(a1[i][j][0]);
        sum_a2 += float(a2[i][j][0]);
        sum_a3 += float(a3[i][j][0]);
        sum_a4 += float(a4[i][j][0]);
        sum_a5 += float(a5[i][j][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

mat2 a0[3][2] = mat2[3][2](mat2[2](mat2(sc0), mat2(2)),
                                    mat2[2](mat2(3), mat2(4)),
                                    mat2[2](mat2(5), mat2(6)));
mat2 a1[3][2] = mat2[3][2](mat2[2](mat2(1), mat2(sc0)),
                                    mat2[2](mat2(3), mat2(4)),
                                    mat2[2](mat2(5), mat2(6)));
mat2 a2[3][2] = mat2[3][2](mat2[2](mat2(1), mat2(2)),
                                    mat2[2](mat2(sc0), mat2(4)),
                                    mat2[2](mat2(5), mat2(6)));
mat2 a3[3][2] = mat2[3][2](mat2[2](mat2(1), mat2(2)),
                                    mat2[2](mat2(3), mat2(sc0)),
                                    mat2[2](mat2(5), mat2(6)));
mat2 a4[3][2] = mat2[3][2](mat2[2](mat2(1), mat2(2)),
                                    mat2[2](mat2(3), mat2(4)),
                                    mat2[2](mat2(sc0), mat2(6)));
mat2 a5[3][2] = mat2[3][2](mat2[2](mat2(1), mat2(2)),
                                    mat2[2](mat2(3), mat2(4)),
                                    mat2[2](mat2(5), mat2(sc0)));


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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

mat3 a0[3][2] = mat3[3][2](mat3[2](mat3(sc0), mat3(2)),
                                    mat3[2](mat3(3), mat3(4)),
                                    mat3[2](mat3(5), mat3(6)));
mat3 a1[3][2] = mat3[3][2](mat3[2](mat3(1), mat3(sc0)),
                                    mat3[2](mat3(3), mat3(4)),
                                    mat3[2](mat3(5), mat3(6)));
mat3 a2[3][2] = mat3[3][2](mat3[2](mat3(1), mat3(2)),
                                    mat3[2](mat3(sc0), mat3(4)),
                                    mat3[2](mat3(5), mat3(6)));
mat3 a3[3][2] = mat3[3][2](mat3[2](mat3(1), mat3(2)),
                                    mat3[2](mat3(3), mat3(sc0)),
                                    mat3[2](mat3(5), mat3(6)));
mat3 a4[3][2] = mat3[3][2](mat3[2](mat3(1), mat3(2)),
                                    mat3[2](mat3(3), mat3(4)),
                                    mat3[2](mat3(sc0), mat3(6)));
mat3 a5[3][2] = mat3[3][2](mat3[2](mat3(1), mat3(2)),
                                    mat3[2](mat3(3), mat3(4)),
                                    mat3[2](mat3(5), mat3(sc0)));


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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result[6];
} sb_out;

mat4 a0[3][2] = mat4[3][2](mat4[2](mat4(sc0), mat4(2)),
                                    mat4[2](mat4(3), mat4(4)),
                                    mat4[2](mat4(5), mat4(6)));
mat4 a1[3][2] = mat4[3][2](mat4[2](mat4(1), mat4(sc0)),
                                    mat4[2](mat4(3), mat4(4)),
                                    mat4[2](mat4(5), mat4(6)));
mat4 a2[3][2] = mat4[3][2](mat4[2](mat4(1), mat4(2)),
                                    mat4[2](mat4(sc0), mat4(4)),
                                    mat4[2](mat4(5), mat4(6)));
mat4 a3[3][2] = mat4[3][2](mat4[2](mat4(1), mat4(2)),
                                    mat4[2](mat4(3), mat4(sc0)),
                                    mat4[2](mat4(5), mat4(6)));
mat4 a4[3][2] = mat4[3][2](mat4[2](mat4(1), mat4(2)),
                                    mat4[2](mat4(3), mat4(4)),
                                    mat4[2](mat4(sc0), mat4(6)));
mat4 a5[3][2] = mat4[3][2](mat4[2](mat4(1), mat4(2)),
                                    mat4[2](mat4(3), mat4(4)),
                                    mat4[2](mat4(5), mat4(sc0)));


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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

dvec2 a0[3][2] = dvec2[3][2](dvec2[2](dvec2(sc0), dvec2(2)),
                                    dvec2[2](dvec2(3), dvec2(4)),
                                    dvec2[2](dvec2(5), dvec2(6)));
dvec2 a1[3][2] = dvec2[3][2](dvec2[2](dvec2(1), dvec2(sc0)),
                                    dvec2[2](dvec2(3), dvec2(4)),
                                    dvec2[2](dvec2(5), dvec2(6)));
dvec2 a2[3][2] = dvec2[3][2](dvec2[2](dvec2(1), dvec2(2)),
                                    dvec2[2](dvec2(sc0), dvec2(4)),
                                    dvec2[2](dvec2(5), dvec2(6)));
dvec2 a3[3][2] = dvec2[3][2](dvec2[2](dvec2(1), dvec2(2)),
                                    dvec2[2](dvec2(3), dvec2(sc0)),
                                    dvec2[2](dvec2(5), dvec2(6)));
dvec2 a4[3][2] = dvec2[3][2](dvec2[2](dvec2(1), dvec2(2)),
                                    dvec2[2](dvec2(3), dvec2(4)),
                                    dvec2[2](dvec2(sc0), dvec2(6)));
dvec2 a5[3][2] = dvec2[3][2](dvec2[2](dvec2(1), dvec2(2)),
                                    dvec2[2](dvec2(3), dvec2(4)),
                                    dvec2[2](dvec2(5), dvec2(sc0)));


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
        sum_a0 += double(a0[i][j][0]);
        sum_a1 += double(a1[i][j][0]);
        sum_a2 += double(a2[i][j][0]);
        sum_a3 += double(a3[i][j][0]);
        sum_a4 += double(a4[i][j][0]);
        sum_a5 += double(a5[i][j][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

dvec3 a0[3][2] = dvec3[3][2](dvec3[2](dvec3(sc0), dvec3(2)),
                                    dvec3[2](dvec3(3), dvec3(4)),
                                    dvec3[2](dvec3(5), dvec3(6)));
dvec3 a1[3][2] = dvec3[3][2](dvec3[2](dvec3(1), dvec3(sc0)),
                                    dvec3[2](dvec3(3), dvec3(4)),
                                    dvec3[2](dvec3(5), dvec3(6)));
dvec3 a2[3][2] = dvec3[3][2](dvec3[2](dvec3(1), dvec3(2)),
                                    dvec3[2](dvec3(sc0), dvec3(4)),
                                    dvec3[2](dvec3(5), dvec3(6)));
dvec3 a3[3][2] = dvec3[3][2](dvec3[2](dvec3(1), dvec3(2)),
                                    dvec3[2](dvec3(3), dvec3(sc0)),
                                    dvec3[2](dvec3(5), dvec3(6)));
dvec3 a4[3][2] = dvec3[3][2](dvec3[2](dvec3(1), dvec3(2)),
                                    dvec3[2](dvec3(3), dvec3(4)),
                                    dvec3[2](dvec3(sc0), dvec3(6)));
dvec3 a5[3][2] = dvec3[3][2](dvec3[2](dvec3(1), dvec3(2)),
                                    dvec3[2](dvec3(3), dvec3(4)),
                                    dvec3[2](dvec3(5), dvec3(sc0)));


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
        sum_a0 += double(a0[i][j][0]);
        sum_a1 += double(a1[i][j][0]);
        sum_a2 += double(a2[i][j][0]);
        sum_a3 += double(a3[i][j][0]);
        sum_a4 += double(a4[i][j][0]);
        sum_a5 += double(a5[i][j][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

dvec4 a0[3][2] = dvec4[3][2](dvec4[2](dvec4(sc0), dvec4(2)),
                                    dvec4[2](dvec4(3), dvec4(4)),
                                    dvec4[2](dvec4(5), dvec4(6)));
dvec4 a1[3][2] = dvec4[3][2](dvec4[2](dvec4(1), dvec4(sc0)),
                                    dvec4[2](dvec4(3), dvec4(4)),
                                    dvec4[2](dvec4(5), dvec4(6)));
dvec4 a2[3][2] = dvec4[3][2](dvec4[2](dvec4(1), dvec4(2)),
                                    dvec4[2](dvec4(sc0), dvec4(4)),
                                    dvec4[2](dvec4(5), dvec4(6)));
dvec4 a3[3][2] = dvec4[3][2](dvec4[2](dvec4(1), dvec4(2)),
                                    dvec4[2](dvec4(3), dvec4(sc0)),
                                    dvec4[2](dvec4(5), dvec4(6)));
dvec4 a4[3][2] = dvec4[3][2](dvec4[2](dvec4(1), dvec4(2)),
                                    dvec4[2](dvec4(3), dvec4(4)),
                                    dvec4[2](dvec4(sc0), dvec4(6)));
dvec4 a5[3][2] = dvec4[3][2](dvec4[2](dvec4(1), dvec4(2)),
                                    dvec4[2](dvec4(3), dvec4(4)),
                                    dvec4[2](dvec4(5), dvec4(sc0)));


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
        sum_a0 += double(a0[i][j][0]);
        sum_a1 += double(a1[i][j][0]);
        sum_a2 += double(a2[i][j][0]);
        sum_a3 += double(a3[i][j][0]);
        sum_a4 += double(a4[i][j][0]);
        sum_a5 += double(a5[i][j][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

dmat2 a0[3][2] = dmat2[3][2](dmat2[2](dmat2(sc0), dmat2(2)),
                                    dmat2[2](dmat2(3), dmat2(4)),
                                    dmat2[2](dmat2(5), dmat2(6)));
dmat2 a1[3][2] = dmat2[3][2](dmat2[2](dmat2(1), dmat2(sc0)),
                                    dmat2[2](dmat2(3), dmat2(4)),
                                    dmat2[2](dmat2(5), dmat2(6)));
dmat2 a2[3][2] = dmat2[3][2](dmat2[2](dmat2(1), dmat2(2)),
                                    dmat2[2](dmat2(sc0), dmat2(4)),
                                    dmat2[2](dmat2(5), dmat2(6)));
dmat2 a3[3][2] = dmat2[3][2](dmat2[2](dmat2(1), dmat2(2)),
                                    dmat2[2](dmat2(3), dmat2(sc0)),
                                    dmat2[2](dmat2(5), dmat2(6)));
dmat2 a4[3][2] = dmat2[3][2](dmat2[2](dmat2(1), dmat2(2)),
                                    dmat2[2](dmat2(3), dmat2(4)),
                                    dmat2[2](dmat2(sc0), dmat2(6)));
dmat2 a5[3][2] = dmat2[3][2](dmat2[2](dmat2(1), dmat2(2)),
                                    dmat2[2](dmat2(3), dmat2(4)),
                                    dmat2[2](dmat2(5), dmat2(sc0)));


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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

dmat3 a0[3][2] = dmat3[3][2](dmat3[2](dmat3(sc0), dmat3(2)),
                                    dmat3[2](dmat3(3), dmat3(4)),
                                    dmat3[2](dmat3(5), dmat3(6)));
dmat3 a1[3][2] = dmat3[3][2](dmat3[2](dmat3(1), dmat3(sc0)),
                                    dmat3[2](dmat3(3), dmat3(4)),
                                    dmat3[2](dmat3(5), dmat3(6)));
dmat3 a2[3][2] = dmat3[3][2](dmat3[2](dmat3(1), dmat3(2)),
                                    dmat3[2](dmat3(sc0), dmat3(4)),
                                    dmat3[2](dmat3(5), dmat3(6)));
dmat3 a3[3][2] = dmat3[3][2](dmat3[2](dmat3(1), dmat3(2)),
                                    dmat3[2](dmat3(3), dmat3(sc0)),
                                    dmat3[2](dmat3(5), dmat3(6)));
dmat3 a4[3][2] = dmat3[3][2](dmat3[2](dmat3(1), dmat3(2)),
                                    dmat3[2](dmat3(3), dmat3(4)),
                                    dmat3[2](dmat3(sc0), dmat3(6)));
dmat3 a5[3][2] = dmat3[3][2](dmat3[2](dmat3(1), dmat3(2)),
                                    dmat3[2](dmat3(3), dmat3(4)),
                                    dmat3[2](dmat3(5), dmat3(sc0)));


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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result[6];
} sb_out;

dmat4 a0[3][2] = dmat4[3][2](dmat4[2](dmat4(sc0), dmat4(2)),
                                    dmat4[2](dmat4(3), dmat4(4)),
                                    dmat4[2](dmat4(5), dmat4(6)));
dmat4 a1[3][2] = dmat4[3][2](dmat4[2](dmat4(1), dmat4(sc0)),
                                    dmat4[2](dmat4(3), dmat4(4)),
                                    dmat4[2](dmat4(5), dmat4(6)));
dmat4 a2[3][2] = dmat4[3][2](dmat4[2](dmat4(1), dmat4(2)),
                                    dmat4[2](dmat4(sc0), dmat4(4)),
                                    dmat4[2](dmat4(5), dmat4(6)));
dmat4 a3[3][2] = dmat4[3][2](dmat4[2](dmat4(1), dmat4(2)),
                                    dmat4[2](dmat4(3), dmat4(sc0)),
                                    dmat4[2](dmat4(5), dmat4(6)));
dmat4 a4[3][2] = dmat4[3][2](dmat4[2](dmat4(1), dmat4(2)),
                                    dmat4[2](dmat4(3), dmat4(4)),
                                    dmat4[2](dmat4(sc0), dmat4(6)));
dmat4 a5[3][2] = dmat4[3][2](dmat4[2](dmat4(1), dmat4(2)),
                                    dmat4[2](dmat4(3), dmat4(4)),
                                    dmat4[2](dmat4(5), dmat4(sc0)));


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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const int sc0 = int(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result[6];
} sb_out;

ivec2 a0[3][2] = ivec2[3][2](ivec2[2](ivec2(sc0), ivec2(2)),
                                    ivec2[2](ivec2(3), ivec2(4)),
                                    ivec2[2](ivec2(5), ivec2(6)));
ivec2 a1[3][2] = ivec2[3][2](ivec2[2](ivec2(1), ivec2(sc0)),
                                    ivec2[2](ivec2(3), ivec2(4)),
                                    ivec2[2](ivec2(5), ivec2(6)));
ivec2 a2[3][2] = ivec2[3][2](ivec2[2](ivec2(1), ivec2(2)),
                                    ivec2[2](ivec2(sc0), ivec2(4)),
                                    ivec2[2](ivec2(5), ivec2(6)));
ivec2 a3[3][2] = ivec2[3][2](ivec2[2](ivec2(1), ivec2(2)),
                                    ivec2[2](ivec2(3), ivec2(sc0)),
                                    ivec2[2](ivec2(5), ivec2(6)));
ivec2 a4[3][2] = ivec2[3][2](ivec2[2](ivec2(1), ivec2(2)),
                                    ivec2[2](ivec2(3), ivec2(4)),
                                    ivec2[2](ivec2(sc0), ivec2(6)));
ivec2 a5[3][2] = ivec2[3][2](ivec2[2](ivec2(1), ivec2(2)),
                                    ivec2[2](ivec2(3), ivec2(4)),
                                    ivec2[2](ivec2(5), ivec2(sc0)));


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
        sum_a0 += int(a0[i][j][0]);
        sum_a1 += int(a1[i][j][0]);
        sum_a2 += int(a2[i][j][0]);
        sum_a3 += int(a3[i][j][0]);
        sum_a4 += int(a4[i][j][0]);
        sum_a5 += int(a5[i][j][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const int sc0 = int(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result[6];
} sb_out;

ivec3 a0[3][2] = ivec3[3][2](ivec3[2](ivec3(sc0), ivec3(2)),
                                    ivec3[2](ivec3(3), ivec3(4)),
                                    ivec3[2](ivec3(5), ivec3(6)));
ivec3 a1[3][2] = ivec3[3][2](ivec3[2](ivec3(1), ivec3(sc0)),
                                    ivec3[2](ivec3(3), ivec3(4)),
                                    ivec3[2](ivec3(5), ivec3(6)));
ivec3 a2[3][2] = ivec3[3][2](ivec3[2](ivec3(1), ivec3(2)),
                                    ivec3[2](ivec3(sc0), ivec3(4)),
                                    ivec3[2](ivec3(5), ivec3(6)));
ivec3 a3[3][2] = ivec3[3][2](ivec3[2](ivec3(1), ivec3(2)),
                                    ivec3[2](ivec3(3), ivec3(sc0)),
                                    ivec3[2](ivec3(5), ivec3(6)));
ivec3 a4[3][2] = ivec3[3][2](ivec3[2](ivec3(1), ivec3(2)),
                                    ivec3[2](ivec3(3), ivec3(4)),
                                    ivec3[2](ivec3(sc0), ivec3(6)));
ivec3 a5[3][2] = ivec3[3][2](ivec3[2](ivec3(1), ivec3(2)),
                                    ivec3[2](ivec3(3), ivec3(4)),
                                    ivec3[2](ivec3(5), ivec3(sc0)));


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
        sum_a0 += int(a0[i][j][0]);
        sum_a1 += int(a1[i][j][0]);
        sum_a2 += int(a2[i][j][0]);
        sum_a3 += int(a3[i][j][0]);
        sum_a4 += int(a4[i][j][0]);
        sum_a5 += int(a5[i][j][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const int sc0 = int(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result[6];
} sb_out;

ivec4 a0[3][2] = ivec4[3][2](ivec4[2](ivec4(sc0), ivec4(2)),
                                    ivec4[2](ivec4(3), ivec4(4)),
                                    ivec4[2](ivec4(5), ivec4(6)));
ivec4 a1[3][2] = ivec4[3][2](ivec4[2](ivec4(1), ivec4(sc0)),
                                    ivec4[2](ivec4(3), ivec4(4)),
                                    ivec4[2](ivec4(5), ivec4(6)));
ivec4 a2[3][2] = ivec4[3][2](ivec4[2](ivec4(1), ivec4(2)),
                                    ivec4[2](ivec4(sc0), ivec4(4)),
                                    ivec4[2](ivec4(5), ivec4(6)));
ivec4 a3[3][2] = ivec4[3][2](ivec4[2](ivec4(1), ivec4(2)),
                                    ivec4[2](ivec4(3), ivec4(sc0)),
                                    ivec4[2](ivec4(5), ivec4(6)));
ivec4 a4[3][2] = ivec4[3][2](ivec4[2](ivec4(1), ivec4(2)),
                                    ivec4[2](ivec4(3), ivec4(4)),
                                    ivec4[2](ivec4(sc0), ivec4(6)));
ivec4 a5[3][2] = ivec4[3][2](ivec4[2](ivec4(1), ivec4(2)),
                                    ivec4[2](ivec4(3), ivec4(4)),
                                    ivec4[2](ivec4(5), ivec4(sc0)));


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
        sum_a0 += int(a0[i][j][0]);
        sum_a1 += int(a1[i][j][0]);
        sum_a2 += int(a2[i][j][0]);
        sum_a3 += int(a3[i][j][0]);
        sum_a4 += int(a4[i][j][0]);
        sum_a5 += int(a5[i][j][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const uint sc0 = uint(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint result[6];
} sb_out;

uvec2 a0[3][2] = uvec2[3][2](uvec2[2](uvec2(sc0), uvec2(2)),
                                    uvec2[2](uvec2(3), uvec2(4)),
                                    uvec2[2](uvec2(5), uvec2(6)));
uvec2 a1[3][2] = uvec2[3][2](uvec2[2](uvec2(1), uvec2(sc0)),
                                    uvec2[2](uvec2(3), uvec2(4)),
                                    uvec2[2](uvec2(5), uvec2(6)));
uvec2 a2[3][2] = uvec2[3][2](uvec2[2](uvec2(1), uvec2(2)),
                                    uvec2[2](uvec2(sc0), uvec2(4)),
                                    uvec2[2](uvec2(5), uvec2(6)));
uvec2 a3[3][2] = uvec2[3][2](uvec2[2](uvec2(1), uvec2(2)),
                                    uvec2[2](uvec2(3), uvec2(sc0)),
                                    uvec2[2](uvec2(5), uvec2(6)));
uvec2 a4[3][2] = uvec2[3][2](uvec2[2](uvec2(1), uvec2(2)),
                                    uvec2[2](uvec2(3), uvec2(4)),
                                    uvec2[2](uvec2(sc0), uvec2(6)));
uvec2 a5[3][2] = uvec2[3][2](uvec2[2](uvec2(1), uvec2(2)),
                                    uvec2[2](uvec2(3), uvec2(4)),
                                    uvec2[2](uvec2(5), uvec2(sc0)));


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
        sum_a0 += uint(a0[i][j][0]);
        sum_a1 += uint(a1[i][j][0]);
        sum_a2 += uint(a2[i][j][0]);
        sum_a3 += uint(a3[i][j][0]);
        sum_a4 += uint(a4[i][j][0]);
        sum_a5 += uint(a5[i][j][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const uint sc0 = uint(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint result[6];
} sb_out;

uvec3 a0[3][2] = uvec3[3][2](uvec3[2](uvec3(sc0), uvec3(2)),
                                    uvec3[2](uvec3(3), uvec3(4)),
                                    uvec3[2](uvec3(5), uvec3(6)));
uvec3 a1[3][2] = uvec3[3][2](uvec3[2](uvec3(1), uvec3(sc0)),
                                    uvec3[2](uvec3(3), uvec3(4)),
                                    uvec3[2](uvec3(5), uvec3(6)));
uvec3 a2[3][2] = uvec3[3][2](uvec3[2](uvec3(1), uvec3(2)),
                                    uvec3[2](uvec3(sc0), uvec3(4)),
                                    uvec3[2](uvec3(5), uvec3(6)));
uvec3 a3[3][2] = uvec3[3][2](uvec3[2](uvec3(1), uvec3(2)),
                                    uvec3[2](uvec3(3), uvec3(sc0)),
                                    uvec3[2](uvec3(5), uvec3(6)));
uvec3 a4[3][2] = uvec3[3][2](uvec3[2](uvec3(1), uvec3(2)),
                                    uvec3[2](uvec3(3), uvec3(4)),
                                    uvec3[2](uvec3(sc0), uvec3(6)));
uvec3 a5[3][2] = uvec3[3][2](uvec3[2](uvec3(1), uvec3(2)),
                                    uvec3[2](uvec3(3), uvec3(4)),
                                    uvec3[2](uvec3(5), uvec3(sc0)));


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
        sum_a0 += uint(a0[i][j][0]);
        sum_a1 += uint(a1[i][j][0]);
        sum_a2 += uint(a2[i][j][0]);
        sum_a3 += uint(a3[i][j][0]);
        sum_a4 += uint(a4[i][j][0]);
        sum_a5 += uint(a5[i][j][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const uint sc0 = uint(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint result[6];
} sb_out;

uvec4 a0[3][2] = uvec4[3][2](uvec4[2](uvec4(sc0), uvec4(2)),
                                    uvec4[2](uvec4(3), uvec4(4)),
                                    uvec4[2](uvec4(5), uvec4(6)));
uvec4 a1[3][2] = uvec4[3][2](uvec4[2](uvec4(1), uvec4(sc0)),
                                    uvec4[2](uvec4(3), uvec4(4)),
                                    uvec4[2](uvec4(5), uvec4(6)));
uvec4 a2[3][2] = uvec4[3][2](uvec4[2](uvec4(1), uvec4(2)),
                                    uvec4[2](uvec4(sc0), uvec4(4)),
                                    uvec4[2](uvec4(5), uvec4(6)));
uvec4 a3[3][2] = uvec4[3][2](uvec4[2](uvec4(1), uvec4(2)),
                                    uvec4[2](uvec4(3), uvec4(sc0)),
                                    uvec4[2](uvec4(5), uvec4(6)));
uvec4 a4[3][2] = uvec4[3][2](uvec4[2](uvec4(1), uvec4(2)),
                                    uvec4[2](uvec4(3), uvec4(4)),
                                    uvec4[2](uvec4(sc0), uvec4(6)));
uvec4 a5[3][2] = uvec4[3][2](uvec4[2](uvec4(1), uvec4(2)),
                                    uvec4[2](uvec4(3), uvec4(4)),
                                    uvec4[2](uvec4(5), uvec4(sc0)));


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
        sum_a0 += uint(a0[i][j][0]);
        sum_a1 += uint(a1[i][j][0]);
        sum_a2 += uint(a2[i][j][0]);
        sum_a3 += uint(a3[i][j][0]);
        sum_a4 += uint(a4[i][j][0]);
        sum_a5 += uint(a5[i][j][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const bool sc0 = bool(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result[6];
} sb_out;

bvec2 a0[3][2] = bvec2[3][2](bvec2[2](bvec2(sc0), bvec2(true)),
                                    bvec2[2](bvec2(true), bvec2(true)),
                                    bvec2[2](bvec2(true), bvec2(true)));
bvec2 a1[3][2] = bvec2[3][2](bvec2[2](bvec2(true), bvec2(sc0)),
                                    bvec2[2](bvec2(true), bvec2(true)),
                                    bvec2[2](bvec2(true), bvec2(true)));
bvec2 a2[3][2] = bvec2[3][2](bvec2[2](bvec2(true), bvec2(true)),
                                    bvec2[2](bvec2(sc0), bvec2(true)),
                                    bvec2[2](bvec2(true), bvec2(true)));
bvec2 a3[3][2] = bvec2[3][2](bvec2[2](bvec2(true), bvec2(true)),
                                    bvec2[2](bvec2(true), bvec2(sc0)),
                                    bvec2[2](bvec2(true), bvec2(true)));
bvec2 a4[3][2] = bvec2[3][2](bvec2[2](bvec2(true), bvec2(true)),
                                    bvec2[2](bvec2(true), bvec2(true)),
                                    bvec2[2](bvec2(sc0), bvec2(true)));
bvec2 a5[3][2] = bvec2[3][2](bvec2[2](bvec2(true), bvec2(true)),
                                    bvec2[2](bvec2(true), bvec2(true)),
                                    bvec2[2](bvec2(true), bvec2(sc0)));


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
        sum_a0 += int(a0[i][j][0]);
        sum_a1 += int(a1[i][j][0]);
        sum_a2 += int(a2[i][j][0]);
        sum_a3 += int(a3[i][j][0]);
        sum_a4 += int(a4[i][j][0]);
        sum_a5 += int(a5[i][j][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const bool sc0 = bool(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result[6];
} sb_out;

bvec3 a0[3][2] = bvec3[3][2](bvec3[2](bvec3(sc0), bvec3(true)),
                                    bvec3[2](bvec3(true), bvec3(true)),
                                    bvec3[2](bvec3(true), bvec3(true)));
bvec3 a1[3][2] = bvec3[3][2](bvec3[2](bvec3(true), bvec3(sc0)),
                                    bvec3[2](bvec3(true), bvec3(true)),
                                    bvec3[2](bvec3(true), bvec3(true)));
bvec3 a2[3][2] = bvec3[3][2](bvec3[2](bvec3(true), bvec3(true)),
                                    bvec3[2](bvec3(sc0), bvec3(true)),
                                    bvec3[2](bvec3(true), bvec3(true)));
bvec3 a3[3][2] = bvec3[3][2](bvec3[2](bvec3(true), bvec3(true)),
                                    bvec3[2](bvec3(true), bvec3(sc0)),
                                    bvec3[2](bvec3(true), bvec3(true)));
bvec3 a4[3][2] = bvec3[3][2](bvec3[2](bvec3(true), bvec3(true)),
                                    bvec3[2](bvec3(true), bvec3(true)),
                                    bvec3[2](bvec3(sc0), bvec3(true)));
bvec3 a5[3][2] = bvec3[3][2](bvec3[2](bvec3(true), bvec3(true)),
                                    bvec3[2](bvec3(true), bvec3(true)),
                                    bvec3[2](bvec3(true), bvec3(sc0)));


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
        sum_a0 += int(a0[i][j][0]);
        sum_a1 += int(a1[i][j][0]);
        sum_a2 += int(a2[i][j][0]);
        sum_a3 += int(a3[i][j][0]);
        sum_a4 += int(a4[i][j][0]);
        sum_a5 += int(a5[i][j][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const bool sc0 = bool(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result[6];
} sb_out;

bvec4 a0[3][2] = bvec4[3][2](bvec4[2](bvec4(sc0), bvec4(true)),
                                    bvec4[2](bvec4(true), bvec4(true)),
                                    bvec4[2](bvec4(true), bvec4(true)));
bvec4 a1[3][2] = bvec4[3][2](bvec4[2](bvec4(true), bvec4(sc0)),
                                    bvec4[2](bvec4(true), bvec4(true)),
                                    bvec4[2](bvec4(true), bvec4(true)));
bvec4 a2[3][2] = bvec4[3][2](bvec4[2](bvec4(true), bvec4(true)),
                                    bvec4[2](bvec4(sc0), bvec4(true)),
                                    bvec4[2](bvec4(true), bvec4(true)));
bvec4 a3[3][2] = bvec4[3][2](bvec4[2](bvec4(true), bvec4(true)),
                                    bvec4[2](bvec4(true), bvec4(sc0)),
                                    bvec4[2](bvec4(true), bvec4(true)));
bvec4 a4[3][2] = bvec4[3][2](bvec4[2](bvec4(true), bvec4(true)),
                                    bvec4[2](bvec4(true), bvec4(true)),
                                    bvec4[2](bvec4(sc0), bvec4(true)));
bvec4 a5[3][2] = bvec4[3][2](bvec4[2](bvec4(true), bvec4(true)),
                                    bvec4[2](bvec4(true), bvec4(true)),
                                    bvec4[2](bvec4(true), bvec4(sc0)));


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
        sum_a0 += int(a0[i][j][0]);
        sum_a1 += int(a1[i][j][0]);
        sum_a2 += int(a2[i][j][0]);
        sum_a3 += int(a3[i][j][0]);
        sum_a4 += int(a4[i][j][0]);
        sum_a5 += int(a5[i][j][0]);
    }

    sb_out.result[0] = sum_a0;
    sb_out.result[1] = sum_a1;
    sb_out.result[2] = sum_a2;
    sb_out.result[3] = sum_a3;
    sb_out.result[4] = sum_a4;
    sb_out.result[5] = sum_a5;
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    vec2 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, vec2(sc0), 8u);


void main (void)
{
    float sum_s0 = float(0);

    sum_s0 += float(s0.i);
    sum_s0 += float(s0.f);
    sum_s0 += float(s0.b);
    sum_s0 += float(s0.sc[0]);
    sum_s0 += float(s0.ui);

    sb_out.result = sum_s0;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    vec3 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, vec3(sc0), 8u);


void main (void)
{
    float sum_s0 = float(0);

    sum_s0 += float(s0.i);
    sum_s0 += float(s0.f);
    sum_s0 += float(s0.b);
    sum_s0 += float(s0.sc[0]);
    sum_s0 += float(s0.ui);

    sb_out.result = sum_s0;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    vec4 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, vec4(sc0), 8u);


void main (void)
{
    float sum_s0 = float(0);

    sum_s0 += float(s0.i);
    sum_s0 += float(s0.f);
    sum_s0 += float(s0.b);
    sum_s0 += float(s0.sc[0]);
    sum_s0 += float(s0.ui);

    sb_out.result = sum_s0;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    mat2 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, mat2(sc0), 8u);


void main (void)
{
    float sum_s0 = float(0);

    sum_s0 += float(s0.i);
    sum_s0 += float(s0.f);
    sum_s0 += float(s0.b);
    sum_s0 += float(s0.sc[0][0]);
    sum_s0 += float(s0.ui);

    sb_out.result = sum_s0;
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    mat3 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, mat3(sc0), 8u);


void main (void)
{
    float sum_s0 = float(0);

    sum_s0 += float(s0.i);
    sum_s0 += float(s0.f);
    sum_s0 += float(s0.b);
    sum_s0 += float(s0.sc[0][0]);
    sum_s0 += float(s0.ui);

    sb_out.result = sum_s0;
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const float sc0 = float(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    float result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    mat4 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, mat4(sc0), 8u);


void main (void)
{
    float sum_s0 = float(0);

    sum_s0 += float(s0.i);
    sum_s0 += float(s0.f);
    sum_s0 += float(s0.b);
    sum_s0 += float(s0.sc[0][0]);
    sum_s0 += float(s0.ui);

    sb_out.result = sum_s0;
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    dvec2 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, dvec2(sc0), 8u);


void main (void)
{
    double sum_s0 = double(0);

    sum_s0 += double(s0.i);
    sum_s0 += double(s0.f);
    sum_s0 += double(s0.b);
    sum_s0 += double(s0.sc[0]);
    sum_s0 += double(s0.ui);

    sb_out.result = sum_s0;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    dvec3 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, dvec3(sc0), 8u);


void main (void)
{
    double sum_s0 = double(0);

    sum_s0 += double(s0.i);
    sum_s0 += double(s0.f);
    sum_s0 += double(s0.b);
    sum_s0 += double(s0.sc[0]);
    sum_s0 += double(s0.ui);

    sb_out.result = sum_s0;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    dvec4 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, dvec4(sc0), 8u);


void main (void)
{
    double sum_s0 = double(0);

    sum_s0 += double(s0.i);
    sum_s0 += double(s0.f);
    sum_s0 += double(s0.b);
    sum_s0 += double(s0.sc[0]);
    sum_s0 += double(s0.ui);

    sb_out.result = sum_s0;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    dmat2 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, dmat2(sc0), 8u);


void main (void)
{
    double sum_s0 = double(0);

    sum_s0 += double(s0.i);
    sum_s0 += double(s0.f);
    sum_s0 += double(s0.b);
    sum_s0 += double(s0.sc[0][0]);
    sum_s0 += double(s0.ui);

    sb_out.result = sum_s0;
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    dmat3 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, dmat3(sc0), 8u);


void main (void)
{
    double sum_s0 = double(0);

    sum_s0 += double(s0.i);
    sum_s0 += double(s0.f);
    sum_s0 += double(s0.b);
    sum_s0 += double(s0.sc[0][0]);
    sum_s0 += double(s0.ui);

    sb_out.result = sum_s0;
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const double sc0 = double(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    double result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    dmat4 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, dmat4(sc0), 8u);


void main (void)
{
    double sum_s0 = double(0);

    sum_s0 += double(s0.i);
    sum_s0 += double(s0.f);
    sum_s0 += double(s0.b);
    sum_s0 += double(s0.sc[0][0]);
    sum_s0 += double(s0.ui);

    sb_out.result = sum_s0;
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const int sc0 = int(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    ivec2 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, ivec2(sc0), 8u);


void main (void)
{
    int sum_s0 = int(0);

    sum_s0 += int(s0.i);
    sum_s0 += int(s0.f);
    sum_s0 += int(s0.b);
    sum_s0 += int(s0.sc[0]);
    sum_s0 += int(s0.ui);

    sb_out.result = sum_s0;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const int sc0 = int(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    ivec3 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, ivec3(sc0), 8u);


void main (void)
{
    int sum_s0 = int(0);

    sum_s0 += int(s0.i);
    sum_s0 += int(s0.f);
    sum_s0 += int(s0.b);
    sum_s0 += int(s0.sc[0]);
    sum_s0 += int(s0.ui);

    sb_out.result = sum_s0;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const int sc0 = int(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    ivec4 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, ivec4(sc0), 8u);


void main (void)
{
    int sum_s0 = int(0);

    sum_s0 += int(s0.i);
    sum_s0 += int(s0.f);
    sum_s0 += int(s0.b);
    sum_s0 += int(s0.sc[0]);
    sum_s0 += int(s0.ui);

    sb_out.result = sum_s0;
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const uint sc0 = uint(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    uvec2 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, uvec2(sc0), 8u);


void main (void)
{
    uint sum_s0 = uint(0);

    sum_s0 += uint(s0.i);
    sum_s0 += uint(s0.f);
    sum_s0 += uint(s0.b);
    sum_s0 += uint(s0.sc[0]);
    sum_s0 += uint(s0.ui);

    sb_out.result = sum_s0;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const uint sc0 = uint(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    uvec3 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, uvec3(sc0), 8u);


void main (void)
{
    uint sum_s0 = uint(0);

    sum_s0 += uint(s0.i);
    sum_s0 += uint(s0.f);
    sum_s0 += uint(s0.b);
    sum_s0 += uint(s0.sc[0]);
    sum_s0 += uint(s0.ui);

    sb_out.result = sum_s0;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const uint sc0 = uint(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uint result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    uvec4 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, uvec4(sc0), 8u);


void main (void)
{
    uint sum_s0 = uint(0);

    sum_s0 += uint(s0.i);
    sum_s0 += uint(s0.f);
    sum_s0 += uint(s0.b);
    sum_s0 += uint(s0.sc[0]);
    sum_s0 += uint(s0.ui);

    sb_out.result = sum_s0;
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const bool sc0 = bool(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    bvec2 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, bvec2(sc0), 8u);


void main (void)
{
    int sum_s0 = int(0);

    sum_s0 += int(s0.i);
    sum_s0 += int(s0.f);
    sum_s0 += int(s0.b);
    sum_s0 += int(s0.sc[0]);
    sum_s0 += int(s0.ui);

    sb_out.result = sum_s0;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const bool sc0 = bool(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    bvec3 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, bvec3(sc0), 8u);


void main (void)
{
    int sum_s0 = int(0);

    sum_s0 += int(s0.i);
    sum_s0 += int(s0.f);
    sum_s0 += int(s0.b);
    sum_s0 += int(s0.sc[0]);
    sum_s0 += int(s0.ui);

    sb_out.result = sum_s0;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(constant_id = 1) const bool sc0 = bool(1);

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    int result;
} sb_out;

struct Data {
    int   i;
    float f;
    bool  b;
    bvec4 sc;
    uint  ui;
};

Data s0 = Data(3, 2.0, true, bvec4(sc0), 8u);


void main (void)
{
    int sum_s0 = int(0);

    sum_s0 += int(s0.i);
    sum_s0 += int(s0.f);
    sum_s0 += int(s0.b);
    sum_s0 += int(s0.sc[0]);
    sum_s0 += int(s0.ui);

    sb_out.result = sum_s0;
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

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
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(local_size_x_id = 1) in;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uvec3 workGroupSize;
    uint  checksum;
} sb_out;

shared uint count;


void main (void)
{
    count = 0u;

    groupMemoryBarrier();
    barrier();

    atomicAdd(count, 1u);

    groupMemoryBarrier();
    barrier();

    sb_out.workGroupSize = gl_WorkGroupSize;
    sb_out.checksum      = count;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(local_size_y_id = 1) in;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uvec3 workGroupSize;
    uint  checksum;
} sb_out;

shared uint count;


void main (void)
{
    count = 0u;

    groupMemoryBarrier();
    barrier();

    atomicAdd(count, 1u);

    groupMemoryBarrier();
    barrier();

    sb_out.workGroupSize = gl_WorkGroupSize;
    sb_out.checksum      = count;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(local_size_z_id = 1) in;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uvec3 workGroupSize;
    uint  checksum;
} sb_out;

shared uint count;


void main (void)
{
    count = 0u;

    groupMemoryBarrier();
    barrier();

    atomicAdd(count, 1u);

    groupMemoryBarrier();
    barrier();

    sb_out.workGroupSize = gl_WorkGroupSize;
    sb_out.checksum      = count;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(local_size_x_id = 1) in;
layout(local_size_y_id = 2) in;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uvec3 workGroupSize;
    uint  checksum;
} sb_out;

shared uint count;


void main (void)
{
    count = 0u;

    groupMemoryBarrier();
    barrier();

    atomicAdd(count, 1u);

    groupMemoryBarrier();
    barrier();

    sb_out.workGroupSize = gl_WorkGroupSize;
    sb_out.checksum      = count;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(local_size_x_id = 1) in;
layout(local_size_z_id = 2) in;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uvec3 workGroupSize;
    uint  checksum;
} sb_out;

shared uint count;


void main (void)
{
    count = 0u;

    groupMemoryBarrier();
    barrier();

    atomicAdd(count, 1u);

    groupMemoryBarrier();
    barrier();

    sb_out.workGroupSize = gl_WorkGroupSize;
    sb_out.checksum      = count;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(local_size_y_id = 1) in;
layout(local_size_z_id = 2) in;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uvec3 workGroupSize;
    uint  checksum;
} sb_out;

shared uint count;


void main (void)
{
    count = 0u;

    groupMemoryBarrier();
    barrier();

    atomicAdd(count, 1u);

    groupMemoryBarrier();
    barrier();

    sb_out.workGroupSize = gl_WorkGroupSize;
    sb_out.checksum      = count;
}
#version 450

// Don't define work group size, use the default or specialization constants

layout(local_size_x_id = 1) in;
layout(local_size_y_id = 2) in;
layout(local_size_z_id = 3) in;

layout (set = 0, binding = 0, std430) writeonly buffer Output {
    uvec3 workGroupSize;
    uint  checksum;
} sb_out;

shared uint count;


void main (void)
{
    count = 0u;

    groupMemoryBarrier();
    barrier();

    atomicAdd(count, 1u);

    groupMemoryBarrier();
    barrier();

    sb_out.workGroupSize = gl_WorkGroupSize;
    sb_out.checksum      = count;
}
