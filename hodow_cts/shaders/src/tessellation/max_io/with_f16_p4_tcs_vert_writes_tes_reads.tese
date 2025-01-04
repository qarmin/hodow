#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(quads, equal_spacing) in;

layout(set=0, binding=0, std430) readonly buffer PerVertexBlock {
    int vert_i32d1_flat_7[4];
    int vert_i32d1_flat_1[4];
    vec2 vert_f16d2_inter_9[4];
    float vert_f32d1_inter_4[4];
    vec4 vert_f16d4_inter_3[4];
    vec4 vert_f32d4_flat_2[4];
    ivec2 vert_i32d2_flat_4[4];
    vec2 vert_f16d2_flat_0[4];
    vec2 vert_f16d2_inter_7[4];
    vec2 vert_f32d2_inter_3[4];
    vec3 vert_f32d3_flat_3[4];
    float vert_f16d1_flat_6[4];
    float vert_f16d1_inter_3[4];
    ivec4 vert_i32d4_flat_6[4];
    vec4 vert_f32d4_flat_5[4];
    ivec4 vert_i32d4_flat_8[4];
    ivec3 vert_i32d3_flat_2[4];
    vec3 vert_f32d3_flat_6[4];
    vec2 vert_f16d2_flat_9[4];
    vec2 vert_f32d2_flat_7[4];
    float vert_f16d1_inter_2[4];
    float vert_f32d1_inter_6[4];
    vec2 vert_f32d2_inter_9[4];
    vec3 vert_f16d3_inter_0[4];
    vec3 vert_f32d3_flat_4[4];
    vec3 vert_f32d3_inter_2[4];
    float vert_f16d1_flat_9[4];
    vec3 vert_f32d3_flat_2[4];
    vec3 vert_f16d3_inter_7[4];
 } pvd;

layout (location=0) in flat int32_t vert_i32d1_flat_7[];
layout (location=1) in flat int32_t vert_i32d1_flat_1[];
layout (location=2) in f16vec2 vert_f16d2_inter_9[];
layout (location=3) in float32_t vert_f32d1_inter_4[];
layout (location=4) in f16vec4 vert_f16d4_inter_3[];
layout (location=5) in flat f32vec4 vert_f32d4_flat_2[];
layout (location=6) in flat i32vec2 vert_i32d2_flat_4[];
layout (location=7) in flat f16vec2 vert_f16d2_flat_0[];
layout (location=8) in f16vec2 vert_f16d2_inter_7[];
layout (location=9) in f32vec2 vert_f32d2_inter_3[];
layout (location=10) in flat f32vec3 vert_f32d3_flat_3[];
layout (location=11) in flat float16_t vert_f16d1_flat_6[];
layout (location=12) in float16_t vert_f16d1_inter_3[];
layout (location=13) in flat i32vec4 vert_i32d4_flat_6[];
layout (location=14) in flat f32vec4 vert_f32d4_flat_5[];
layout (location=15) in flat i32vec4 vert_i32d4_flat_8[];
layout (location=16) in flat i32vec3 vert_i32d3_flat_2[];
layout (location=17) in flat f32vec3 vert_f32d3_flat_6[];
layout (location=18) in flat f16vec2 vert_f16d2_flat_9[];
layout (location=19) in flat f32vec2 vert_f32d2_flat_7[];
layout (location=20) in float16_t vert_f16d1_inter_2[];
layout (location=21) in float32_t vert_f32d1_inter_6[];
layout (location=22) in f32vec2 vert_f32d2_inter_9[];
layout (location=23) in f16vec3 vert_f16d3_inter_0[];
layout (location=24) in flat f32vec3 vert_f32d3_flat_4[];
layout (location=25) in f32vec3 vert_f32d3_inter_2[];
layout (location=26) in flat float16_t vert_f16d1_flat_9[];
layout (location=27) in flat f32vec3 vert_f32d3_flat_2[];
layout (location=28) in f16vec3 vert_f16d3_inter_7[];

layout (location=0) out vec4 outColor;

in gl_PerVertex {
    vec4  gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};
#define INTERP_QUAD_VAR(TYPE, VAR, INi, OUT) do { \
    TYPE VAR[4]; \
    for (int i = 0; i < 4; i++) VAR[i] = INi; \
    { \
        TYPE temp1 = TYPE(VAR[0] * TYPE(1 - gl_TessCoord[0]) + VAR[1] * TYPE(gl_TessCoord[0])); \
        TYPE temp2 = TYPE(VAR[2] * TYPE(1 - gl_TessCoord[0]) + VAR[3] * TYPE(gl_TessCoord[0])); \
        OUT = TYPE(temp1 * TYPE(1 - gl_TessCoord[1]) + temp2 * TYPE(gl_TessCoord[1])); \
    } \
} while(false)

void main ()
{
int32_t temp_vert_i32d1_flat_7;
INTERP_QUAD_VAR(int32_t, var_vert_i32d1_flat_7 ,vert_i32d1_flat_7[i], temp_vert_i32d1_flat_7);
    bool good_vert_i32d1_flat_7 = (temp_vert_i32d1_flat_7 <= int32_t(max(max(max(pvd.vert_i32d1_flat_7[0], pvd.vert_i32d1_flat_7[1]), pvd.vert_i32d1_flat_7[2]), pvd.vert_i32d1_flat_7[3]))) && (temp_vert_i32d1_flat_7 >= int32_t(min(min(min(pvd.vert_i32d1_flat_7[0], pvd.vert_i32d1_flat_7[1]), pvd.vert_i32d1_flat_7[2]), pvd.vert_i32d1_flat_7[3])));
int32_t temp_vert_i32d1_flat_1;
INTERP_QUAD_VAR(int32_t, var_vert_i32d1_flat_1 ,vert_i32d1_flat_1[i], temp_vert_i32d1_flat_1);
    bool good_vert_i32d1_flat_1 = (temp_vert_i32d1_flat_1 <= int32_t(max(max(max(pvd.vert_i32d1_flat_1[0], pvd.vert_i32d1_flat_1[1]), pvd.vert_i32d1_flat_1[2]), pvd.vert_i32d1_flat_1[3]))) && (temp_vert_i32d1_flat_1 >= int32_t(min(min(min(pvd.vert_i32d1_flat_1[0], pvd.vert_i32d1_flat_1[1]), pvd.vert_i32d1_flat_1[2]), pvd.vert_i32d1_flat_1[3])));
f16vec2 temp_vert_f16d2_inter_9;
INTERP_QUAD_VAR(f16vec2, var_vert_f16d2_inter_9 ,vert_f16d2_inter_9[i], temp_vert_f16d2_inter_9);
    bool good_vert_f16d2_inter_9 = all(lessThanEqual(temp_vert_f16d2_inter_9, f16vec2(max(max(max(pvd.vert_f16d2_inter_9[0], pvd.vert_f16d2_inter_9[1]), pvd.vert_f16d2_inter_9[2]), pvd.vert_f16d2_inter_9[3])))) && all(greaterThanEqual(temp_vert_f16d2_inter_9, f16vec2(min(min(min(pvd.vert_f16d2_inter_9[0], pvd.vert_f16d2_inter_9[1]), pvd.vert_f16d2_inter_9[2]), pvd.vert_f16d2_inter_9[3]))));
float32_t temp_vert_f32d1_inter_4;
INTERP_QUAD_VAR(float32_t, var_vert_f32d1_inter_4 ,vert_f32d1_inter_4[i], temp_vert_f32d1_inter_4);
    bool good_vert_f32d1_inter_4 = (temp_vert_f32d1_inter_4 <= float32_t(max(max(max(pvd.vert_f32d1_inter_4[0], pvd.vert_f32d1_inter_4[1]), pvd.vert_f32d1_inter_4[2]), pvd.vert_f32d1_inter_4[3]))) && (temp_vert_f32d1_inter_4 >= float32_t(min(min(min(pvd.vert_f32d1_inter_4[0], pvd.vert_f32d1_inter_4[1]), pvd.vert_f32d1_inter_4[2]), pvd.vert_f32d1_inter_4[3])));
f16vec4 temp_vert_f16d4_inter_3;
INTERP_QUAD_VAR(f16vec4, var_vert_f16d4_inter_3 ,vert_f16d4_inter_3[i], temp_vert_f16d4_inter_3);
    bool good_vert_f16d4_inter_3 = all(lessThanEqual(temp_vert_f16d4_inter_3, f16vec4(max(max(max(pvd.vert_f16d4_inter_3[0], pvd.vert_f16d4_inter_3[1]), pvd.vert_f16d4_inter_3[2]), pvd.vert_f16d4_inter_3[3])))) && all(greaterThanEqual(temp_vert_f16d4_inter_3, f16vec4(min(min(min(pvd.vert_f16d4_inter_3[0], pvd.vert_f16d4_inter_3[1]), pvd.vert_f16d4_inter_3[2]), pvd.vert_f16d4_inter_3[3]))));
f32vec4 temp_vert_f32d4_flat_2;
INTERP_QUAD_VAR(f32vec4, var_vert_f32d4_flat_2 ,vert_f32d4_flat_2[i], temp_vert_f32d4_flat_2);
    bool good_vert_f32d4_flat_2 = all(lessThanEqual(temp_vert_f32d4_flat_2, f32vec4(max(max(max(pvd.vert_f32d4_flat_2[0], pvd.vert_f32d4_flat_2[1]), pvd.vert_f32d4_flat_2[2]), pvd.vert_f32d4_flat_2[3])))) && all(greaterThanEqual(temp_vert_f32d4_flat_2, f32vec4(min(min(min(pvd.vert_f32d4_flat_2[0], pvd.vert_f32d4_flat_2[1]), pvd.vert_f32d4_flat_2[2]), pvd.vert_f32d4_flat_2[3]))));
i32vec2 temp_vert_i32d2_flat_4;
INTERP_QUAD_VAR(i32vec2, var_vert_i32d2_flat_4 ,vert_i32d2_flat_4[i], temp_vert_i32d2_flat_4);
    bool good_vert_i32d2_flat_4 = all(lessThanEqual(temp_vert_i32d2_flat_4, i32vec2(max(max(max(pvd.vert_i32d2_flat_4[0], pvd.vert_i32d2_flat_4[1]), pvd.vert_i32d2_flat_4[2]), pvd.vert_i32d2_flat_4[3])))) && all(greaterThanEqual(temp_vert_i32d2_flat_4, i32vec2(min(min(min(pvd.vert_i32d2_flat_4[0], pvd.vert_i32d2_flat_4[1]), pvd.vert_i32d2_flat_4[2]), pvd.vert_i32d2_flat_4[3]))));
f16vec2 temp_vert_f16d2_flat_0;
INTERP_QUAD_VAR(f16vec2, var_vert_f16d2_flat_0 ,vert_f16d2_flat_0[i], temp_vert_f16d2_flat_0);
    bool good_vert_f16d2_flat_0 = all(lessThanEqual(temp_vert_f16d2_flat_0, f16vec2(max(max(max(pvd.vert_f16d2_flat_0[0], pvd.vert_f16d2_flat_0[1]), pvd.vert_f16d2_flat_0[2]), pvd.vert_f16d2_flat_0[3])))) && all(greaterThanEqual(temp_vert_f16d2_flat_0, f16vec2(min(min(min(pvd.vert_f16d2_flat_0[0], pvd.vert_f16d2_flat_0[1]), pvd.vert_f16d2_flat_0[2]), pvd.vert_f16d2_flat_0[3]))));
f16vec2 temp_vert_f16d2_inter_7;
INTERP_QUAD_VAR(f16vec2, var_vert_f16d2_inter_7 ,vert_f16d2_inter_7[i], temp_vert_f16d2_inter_7);
    bool good_vert_f16d2_inter_7 = all(lessThanEqual(temp_vert_f16d2_inter_7, f16vec2(max(max(max(pvd.vert_f16d2_inter_7[0], pvd.vert_f16d2_inter_7[1]), pvd.vert_f16d2_inter_7[2]), pvd.vert_f16d2_inter_7[3])))) && all(greaterThanEqual(temp_vert_f16d2_inter_7, f16vec2(min(min(min(pvd.vert_f16d2_inter_7[0], pvd.vert_f16d2_inter_7[1]), pvd.vert_f16d2_inter_7[2]), pvd.vert_f16d2_inter_7[3]))));
f32vec2 temp_vert_f32d2_inter_3;
INTERP_QUAD_VAR(f32vec2, var_vert_f32d2_inter_3 ,vert_f32d2_inter_3[i], temp_vert_f32d2_inter_3);
    bool good_vert_f32d2_inter_3 = all(lessThanEqual(temp_vert_f32d2_inter_3, f32vec2(max(max(max(pvd.vert_f32d2_inter_3[0], pvd.vert_f32d2_inter_3[1]), pvd.vert_f32d2_inter_3[2]), pvd.vert_f32d2_inter_3[3])))) && all(greaterThanEqual(temp_vert_f32d2_inter_3, f32vec2(min(min(min(pvd.vert_f32d2_inter_3[0], pvd.vert_f32d2_inter_3[1]), pvd.vert_f32d2_inter_3[2]), pvd.vert_f32d2_inter_3[3]))));
f32vec3 temp_vert_f32d3_flat_3;
INTERP_QUAD_VAR(f32vec3, var_vert_f32d3_flat_3 ,vert_f32d3_flat_3[i], temp_vert_f32d3_flat_3);
    bool good_vert_f32d3_flat_3 = all(lessThanEqual(temp_vert_f32d3_flat_3, f32vec3(max(max(max(pvd.vert_f32d3_flat_3[0], pvd.vert_f32d3_flat_3[1]), pvd.vert_f32d3_flat_3[2]), pvd.vert_f32d3_flat_3[3])))) && all(greaterThanEqual(temp_vert_f32d3_flat_3, f32vec3(min(min(min(pvd.vert_f32d3_flat_3[0], pvd.vert_f32d3_flat_3[1]), pvd.vert_f32d3_flat_3[2]), pvd.vert_f32d3_flat_3[3]))));
float16_t temp_vert_f16d1_flat_6;
INTERP_QUAD_VAR(float16_t, var_vert_f16d1_flat_6 ,vert_f16d1_flat_6[i], temp_vert_f16d1_flat_6);
    bool good_vert_f16d1_flat_6 = (temp_vert_f16d1_flat_6 <= float16_t(max(max(max(pvd.vert_f16d1_flat_6[0], pvd.vert_f16d1_flat_6[1]), pvd.vert_f16d1_flat_6[2]), pvd.vert_f16d1_flat_6[3]))) && (temp_vert_f16d1_flat_6 >= float16_t(min(min(min(pvd.vert_f16d1_flat_6[0], pvd.vert_f16d1_flat_6[1]), pvd.vert_f16d1_flat_6[2]), pvd.vert_f16d1_flat_6[3])));
float16_t temp_vert_f16d1_inter_3;
INTERP_QUAD_VAR(float16_t, var_vert_f16d1_inter_3 ,vert_f16d1_inter_3[i], temp_vert_f16d1_inter_3);
    bool good_vert_f16d1_inter_3 = (temp_vert_f16d1_inter_3 <= float16_t(max(max(max(pvd.vert_f16d1_inter_3[0], pvd.vert_f16d1_inter_3[1]), pvd.vert_f16d1_inter_3[2]), pvd.vert_f16d1_inter_3[3]))) && (temp_vert_f16d1_inter_3 >= float16_t(min(min(min(pvd.vert_f16d1_inter_3[0], pvd.vert_f16d1_inter_3[1]), pvd.vert_f16d1_inter_3[2]), pvd.vert_f16d1_inter_3[3])));
i32vec4 temp_vert_i32d4_flat_6;
INTERP_QUAD_VAR(i32vec4, var_vert_i32d4_flat_6 ,vert_i32d4_flat_6[i], temp_vert_i32d4_flat_6);
    bool good_vert_i32d4_flat_6 = all(lessThanEqual(temp_vert_i32d4_flat_6, i32vec4(max(max(max(pvd.vert_i32d4_flat_6[0], pvd.vert_i32d4_flat_6[1]), pvd.vert_i32d4_flat_6[2]), pvd.vert_i32d4_flat_6[3])))) && all(greaterThanEqual(temp_vert_i32d4_flat_6, i32vec4(min(min(min(pvd.vert_i32d4_flat_6[0], pvd.vert_i32d4_flat_6[1]), pvd.vert_i32d4_flat_6[2]), pvd.vert_i32d4_flat_6[3]))));
f32vec4 temp_vert_f32d4_flat_5;
INTERP_QUAD_VAR(f32vec4, var_vert_f32d4_flat_5 ,vert_f32d4_flat_5[i], temp_vert_f32d4_flat_5);
    bool good_vert_f32d4_flat_5 = all(lessThanEqual(temp_vert_f32d4_flat_5, f32vec4(max(max(max(pvd.vert_f32d4_flat_5[0], pvd.vert_f32d4_flat_5[1]), pvd.vert_f32d4_flat_5[2]), pvd.vert_f32d4_flat_5[3])))) && all(greaterThanEqual(temp_vert_f32d4_flat_5, f32vec4(min(min(min(pvd.vert_f32d4_flat_5[0], pvd.vert_f32d4_flat_5[1]), pvd.vert_f32d4_flat_5[2]), pvd.vert_f32d4_flat_5[3]))));
i32vec4 temp_vert_i32d4_flat_8;
INTERP_QUAD_VAR(i32vec4, var_vert_i32d4_flat_8 ,vert_i32d4_flat_8[i], temp_vert_i32d4_flat_8);
    bool good_vert_i32d4_flat_8 = all(lessThanEqual(temp_vert_i32d4_flat_8, i32vec4(max(max(max(pvd.vert_i32d4_flat_8[0], pvd.vert_i32d4_flat_8[1]), pvd.vert_i32d4_flat_8[2]), pvd.vert_i32d4_flat_8[3])))) && all(greaterThanEqual(temp_vert_i32d4_flat_8, i32vec4(min(min(min(pvd.vert_i32d4_flat_8[0], pvd.vert_i32d4_flat_8[1]), pvd.vert_i32d4_flat_8[2]), pvd.vert_i32d4_flat_8[3]))));
i32vec3 temp_vert_i32d3_flat_2;
INTERP_QUAD_VAR(i32vec3, var_vert_i32d3_flat_2 ,vert_i32d3_flat_2[i], temp_vert_i32d3_flat_2);
    bool good_vert_i32d3_flat_2 = all(lessThanEqual(temp_vert_i32d3_flat_2, i32vec3(max(max(max(pvd.vert_i32d3_flat_2[0], pvd.vert_i32d3_flat_2[1]), pvd.vert_i32d3_flat_2[2]), pvd.vert_i32d3_flat_2[3])))) && all(greaterThanEqual(temp_vert_i32d3_flat_2, i32vec3(min(min(min(pvd.vert_i32d3_flat_2[0], pvd.vert_i32d3_flat_2[1]), pvd.vert_i32d3_flat_2[2]), pvd.vert_i32d3_flat_2[3]))));
f32vec3 temp_vert_f32d3_flat_6;
INTERP_QUAD_VAR(f32vec3, var_vert_f32d3_flat_6 ,vert_f32d3_flat_6[i], temp_vert_f32d3_flat_6);
    bool good_vert_f32d3_flat_6 = all(lessThanEqual(temp_vert_f32d3_flat_6, f32vec3(max(max(max(pvd.vert_f32d3_flat_6[0], pvd.vert_f32d3_flat_6[1]), pvd.vert_f32d3_flat_6[2]), pvd.vert_f32d3_flat_6[3])))) && all(greaterThanEqual(temp_vert_f32d3_flat_6, f32vec3(min(min(min(pvd.vert_f32d3_flat_6[0], pvd.vert_f32d3_flat_6[1]), pvd.vert_f32d3_flat_6[2]), pvd.vert_f32d3_flat_6[3]))));
f16vec2 temp_vert_f16d2_flat_9;
INTERP_QUAD_VAR(f16vec2, var_vert_f16d2_flat_9 ,vert_f16d2_flat_9[i], temp_vert_f16d2_flat_9);
    bool good_vert_f16d2_flat_9 = all(lessThanEqual(temp_vert_f16d2_flat_9, f16vec2(max(max(max(pvd.vert_f16d2_flat_9[0], pvd.vert_f16d2_flat_9[1]), pvd.vert_f16d2_flat_9[2]), pvd.vert_f16d2_flat_9[3])))) && all(greaterThanEqual(temp_vert_f16d2_flat_9, f16vec2(min(min(min(pvd.vert_f16d2_flat_9[0], pvd.vert_f16d2_flat_9[1]), pvd.vert_f16d2_flat_9[2]), pvd.vert_f16d2_flat_9[3]))));
f32vec2 temp_vert_f32d2_flat_7;
INTERP_QUAD_VAR(f32vec2, var_vert_f32d2_flat_7 ,vert_f32d2_flat_7[i], temp_vert_f32d2_flat_7);
    bool good_vert_f32d2_flat_7 = all(lessThanEqual(temp_vert_f32d2_flat_7, f32vec2(max(max(max(pvd.vert_f32d2_flat_7[0], pvd.vert_f32d2_flat_7[1]), pvd.vert_f32d2_flat_7[2]), pvd.vert_f32d2_flat_7[3])))) && all(greaterThanEqual(temp_vert_f32d2_flat_7, f32vec2(min(min(min(pvd.vert_f32d2_flat_7[0], pvd.vert_f32d2_flat_7[1]), pvd.vert_f32d2_flat_7[2]), pvd.vert_f32d2_flat_7[3]))));
float16_t temp_vert_f16d1_inter_2;
INTERP_QUAD_VAR(float16_t, var_vert_f16d1_inter_2 ,vert_f16d1_inter_2[i], temp_vert_f16d1_inter_2);
    bool good_vert_f16d1_inter_2 = (temp_vert_f16d1_inter_2 <= float16_t(max(max(max(pvd.vert_f16d1_inter_2[0], pvd.vert_f16d1_inter_2[1]), pvd.vert_f16d1_inter_2[2]), pvd.vert_f16d1_inter_2[3]))) && (temp_vert_f16d1_inter_2 >= float16_t(min(min(min(pvd.vert_f16d1_inter_2[0], pvd.vert_f16d1_inter_2[1]), pvd.vert_f16d1_inter_2[2]), pvd.vert_f16d1_inter_2[3])));
float32_t temp_vert_f32d1_inter_6;
INTERP_QUAD_VAR(float32_t, var_vert_f32d1_inter_6 ,vert_f32d1_inter_6[i], temp_vert_f32d1_inter_6);
    bool good_vert_f32d1_inter_6 = (temp_vert_f32d1_inter_6 <= float32_t(max(max(max(pvd.vert_f32d1_inter_6[0], pvd.vert_f32d1_inter_6[1]), pvd.vert_f32d1_inter_6[2]), pvd.vert_f32d1_inter_6[3]))) && (temp_vert_f32d1_inter_6 >= float32_t(min(min(min(pvd.vert_f32d1_inter_6[0], pvd.vert_f32d1_inter_6[1]), pvd.vert_f32d1_inter_6[2]), pvd.vert_f32d1_inter_6[3])));
f32vec2 temp_vert_f32d2_inter_9;
INTERP_QUAD_VAR(f32vec2, var_vert_f32d2_inter_9 ,vert_f32d2_inter_9[i], temp_vert_f32d2_inter_9);
    bool good_vert_f32d2_inter_9 = all(lessThanEqual(temp_vert_f32d2_inter_9, f32vec2(max(max(max(pvd.vert_f32d2_inter_9[0], pvd.vert_f32d2_inter_9[1]), pvd.vert_f32d2_inter_9[2]), pvd.vert_f32d2_inter_9[3])))) && all(greaterThanEqual(temp_vert_f32d2_inter_9, f32vec2(min(min(min(pvd.vert_f32d2_inter_9[0], pvd.vert_f32d2_inter_9[1]), pvd.vert_f32d2_inter_9[2]), pvd.vert_f32d2_inter_9[3]))));
f16vec3 temp_vert_f16d3_inter_0;
INTERP_QUAD_VAR(f16vec3, var_vert_f16d3_inter_0 ,vert_f16d3_inter_0[i], temp_vert_f16d3_inter_0);
    bool good_vert_f16d3_inter_0 = all(lessThanEqual(temp_vert_f16d3_inter_0, f16vec3(max(max(max(pvd.vert_f16d3_inter_0[0], pvd.vert_f16d3_inter_0[1]), pvd.vert_f16d3_inter_0[2]), pvd.vert_f16d3_inter_0[3])))) && all(greaterThanEqual(temp_vert_f16d3_inter_0, f16vec3(min(min(min(pvd.vert_f16d3_inter_0[0], pvd.vert_f16d3_inter_0[1]), pvd.vert_f16d3_inter_0[2]), pvd.vert_f16d3_inter_0[3]))));
f32vec3 temp_vert_f32d3_flat_4;
INTERP_QUAD_VAR(f32vec3, var_vert_f32d3_flat_4 ,vert_f32d3_flat_4[i], temp_vert_f32d3_flat_4);
    bool good_vert_f32d3_flat_4 = all(lessThanEqual(temp_vert_f32d3_flat_4, f32vec3(max(max(max(pvd.vert_f32d3_flat_4[0], pvd.vert_f32d3_flat_4[1]), pvd.vert_f32d3_flat_4[2]), pvd.vert_f32d3_flat_4[3])))) && all(greaterThanEqual(temp_vert_f32d3_flat_4, f32vec3(min(min(min(pvd.vert_f32d3_flat_4[0], pvd.vert_f32d3_flat_4[1]), pvd.vert_f32d3_flat_4[2]), pvd.vert_f32d3_flat_4[3]))));
f32vec3 temp_vert_f32d3_inter_2;
INTERP_QUAD_VAR(f32vec3, var_vert_f32d3_inter_2 ,vert_f32d3_inter_2[i], temp_vert_f32d3_inter_2);
    bool good_vert_f32d3_inter_2 = all(lessThanEqual(temp_vert_f32d3_inter_2, f32vec3(max(max(max(pvd.vert_f32d3_inter_2[0], pvd.vert_f32d3_inter_2[1]), pvd.vert_f32d3_inter_2[2]), pvd.vert_f32d3_inter_2[3])))) && all(greaterThanEqual(temp_vert_f32d3_inter_2, f32vec3(min(min(min(pvd.vert_f32d3_inter_2[0], pvd.vert_f32d3_inter_2[1]), pvd.vert_f32d3_inter_2[2]), pvd.vert_f32d3_inter_2[3]))));
float16_t temp_vert_f16d1_flat_9;
INTERP_QUAD_VAR(float16_t, var_vert_f16d1_flat_9 ,vert_f16d1_flat_9[i], temp_vert_f16d1_flat_9);
    bool good_vert_f16d1_flat_9 = (temp_vert_f16d1_flat_9 <= float16_t(max(max(max(pvd.vert_f16d1_flat_9[0], pvd.vert_f16d1_flat_9[1]), pvd.vert_f16d1_flat_9[2]), pvd.vert_f16d1_flat_9[3]))) && (temp_vert_f16d1_flat_9 >= float16_t(min(min(min(pvd.vert_f16d1_flat_9[0], pvd.vert_f16d1_flat_9[1]), pvd.vert_f16d1_flat_9[2]), pvd.vert_f16d1_flat_9[3])));
f32vec3 temp_vert_f32d3_flat_2;
INTERP_QUAD_VAR(f32vec3, var_vert_f32d3_flat_2 ,vert_f32d3_flat_2[i], temp_vert_f32d3_flat_2);
    bool good_vert_f32d3_flat_2 = all(lessThanEqual(temp_vert_f32d3_flat_2, f32vec3(max(max(max(pvd.vert_f32d3_flat_2[0], pvd.vert_f32d3_flat_2[1]), pvd.vert_f32d3_flat_2[2]), pvd.vert_f32d3_flat_2[3])))) && all(greaterThanEqual(temp_vert_f32d3_flat_2, f32vec3(min(min(min(pvd.vert_f32d3_flat_2[0], pvd.vert_f32d3_flat_2[1]), pvd.vert_f32d3_flat_2[2]), pvd.vert_f32d3_flat_2[3]))));
f16vec3 temp_vert_f16d3_inter_7;
INTERP_QUAD_VAR(f16vec3, var_vert_f16d3_inter_7 ,vert_f16d3_inter_7[i], temp_vert_f16d3_inter_7);
    bool good_vert_f16d3_inter_7 = all(lessThanEqual(temp_vert_f16d3_inter_7, f16vec3(max(max(max(pvd.vert_f16d3_inter_7[0], pvd.vert_f16d3_inter_7[1]), pvd.vert_f16d3_inter_7[2]), pvd.vert_f16d3_inter_7[3])))) && all(greaterThanEqual(temp_vert_f16d3_inter_7, f16vec3(min(min(min(pvd.vert_f16d3_inter_7[0], pvd.vert_f16d3_inter_7[1]), pvd.vert_f16d3_inter_7[2]), pvd.vert_f16d3_inter_7[3]))));
    if (good_vert_i32d1_flat_7 && good_vert_i32d1_flat_1 && good_vert_f16d2_inter_9 && good_vert_f32d1_inter_4 && good_vert_f16d4_inter_3 && good_vert_f32d4_flat_2 && good_vert_i32d2_flat_4 && good_vert_f16d2_flat_0 && good_vert_f16d2_inter_7 && good_vert_f32d2_inter_3 && good_vert_f32d3_flat_3 && good_vert_f16d1_flat_6 && good_vert_f16d1_inter_3 && good_vert_i32d4_flat_6 && good_vert_f32d4_flat_5 && good_vert_i32d4_flat_8 && good_vert_i32d3_flat_2 && good_vert_f32d3_flat_6 && good_vert_f16d2_flat_9 && good_vert_f32d2_flat_7 && good_vert_f16d1_inter_2 && good_vert_f32d1_inter_6 && good_vert_f32d2_inter_9 && good_vert_f16d3_inter_0 && good_vert_f32d3_flat_4 && good_vert_f32d3_inter_2 && good_vert_f16d1_flat_9 && good_vert_f32d3_flat_2 && good_vert_f16d3_inter_7) {
        outColor = (gl_PrimitiveID == 0) ? vec4(0.0, 0.0, 1.0, 1.0) : vec4(1.0, 1.0, 0.0, 1.0);
    } else {
        outColor = vec4(0.0, 0.0, 0.0, 1.0);
    }
    INTERP_QUAD_VAR(vec4, var_gl_pos, gl_in[i].gl_Position, gl_Position);
}
