#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(quads, equal_spacing) in;

layout(set=0, binding=0, std430) readonly buffer PerVertexBlock {
    ivec2 vert_i32d2_flat_8[4];
    ivec3 vert_i64d3_flat_3[4];
    int vert_i64d1_flat_4[4];
    float vert_f32d1_flat_6[4];
    vec3 vert_f32d3_flat_1[4];
    ivec4 vert_i64d4_flat_8[4];
    ivec2 vert_i64d2_flat_8[4];
    ivec4 vert_i32d4_flat_4[4];
    vec2 vert_f32d2_flat_5[4];
    ivec3 vert_i64d3_flat_1[4];
    ivec3 vert_i32d3_flat_4[4];
    vec3 vert_f32d3_flat_5[4];
    ivec2 vert_i32d2_flat_4[4];
    vec3 vert_f32d3_inter_6[4];
    ivec4 vert_i32d4_flat_3[4];
    float vert_f32d1_flat_0[4];
    int vert_i64d1_flat_2[4];
    ivec4 vert_i32d4_flat_9[4];
    float vert_f32d1_flat_7[4];
    ivec3 vert_i32d3_flat_6[4];
    float vert_f32d1_inter_4[4];
    vec4 vert_f32d4_inter_1[4];
    ivec2 vert_i32d2_flat_0[4];
    ivec3 vert_i32d3_flat_0[4];
    ivec4 vert_i32d4_flat_8[4];
 } pvd;

layout (location=0) in vec4 inColor[];

layout (location=1) in flat i32vec2 vert_i32d2_flat_8[];
layout (location=2) in flat i64vec3 vert_i64d3_flat_3[];
layout (location=4) in flat int64_t vert_i64d1_flat_4[];
layout (location=5) in flat float32_t vert_f32d1_flat_6[];
layout (location=6) in flat f32vec3 vert_f32d3_flat_1[];
layout (location=7) in flat i64vec4 vert_i64d4_flat_8[];
layout (location=9) in flat i64vec2 vert_i64d2_flat_8[];
layout (location=10) in flat i32vec4 vert_i32d4_flat_4[];
layout (location=11) in flat f32vec2 vert_f32d2_flat_5[];
layout (location=12) in flat i64vec3 vert_i64d3_flat_1[];
layout (location=14) in flat i32vec3 vert_i32d3_flat_4[];
layout (location=15) in flat f32vec3 vert_f32d3_flat_5[];
layout (location=16) in flat i32vec2 vert_i32d2_flat_4[];
layout (location=17) in f32vec3 vert_f32d3_inter_6[];
layout (location=18) in flat i32vec4 vert_i32d4_flat_3[];
layout (location=19) in flat float32_t vert_f32d1_flat_0[];
layout (location=20) in flat int64_t vert_i64d1_flat_2[];
layout (location=21) in flat i32vec4 vert_i32d4_flat_9[];
layout (location=22) in flat float32_t vert_f32d1_flat_7[];
layout (location=23) in flat i32vec3 vert_i32d3_flat_6[];
layout (location=24) in float32_t vert_f32d1_inter_4[];
layout (location=25) in f32vec4 vert_f32d4_inter_1[];
layout (location=26) in flat i32vec2 vert_i32d2_flat_0[];
layout (location=27) in flat i32vec3 vert_i32d3_flat_0[];
layout (location=28) in flat i32vec4 vert_i32d4_flat_8[];

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
i32vec2 temp_vert_i32d2_flat_8;
INTERP_QUAD_VAR(i32vec2, var_vert_i32d2_flat_8 ,vert_i32d2_flat_8[i], temp_vert_i32d2_flat_8);
    bool good_vert_i32d2_flat_8 = all(lessThanEqual(temp_vert_i32d2_flat_8, i32vec2(max(max(max(pvd.vert_i32d2_flat_8[0], pvd.vert_i32d2_flat_8[1]), pvd.vert_i32d2_flat_8[2]), pvd.vert_i32d2_flat_8[3])))) && all(greaterThanEqual(temp_vert_i32d2_flat_8, i32vec2(min(min(min(pvd.vert_i32d2_flat_8[0], pvd.vert_i32d2_flat_8[1]), pvd.vert_i32d2_flat_8[2]), pvd.vert_i32d2_flat_8[3]))));
i64vec3 temp_vert_i64d3_flat_3;
INTERP_QUAD_VAR(i64vec3, var_vert_i64d3_flat_3 ,vert_i64d3_flat_3[i], temp_vert_i64d3_flat_3);
    bool good_vert_i64d3_flat_3 = all(lessThanEqual(temp_vert_i64d3_flat_3, i64vec3(max(max(max(pvd.vert_i64d3_flat_3[0], pvd.vert_i64d3_flat_3[1]), pvd.vert_i64d3_flat_3[2]), pvd.vert_i64d3_flat_3[3])))) && all(greaterThanEqual(temp_vert_i64d3_flat_3, i64vec3(min(min(min(pvd.vert_i64d3_flat_3[0], pvd.vert_i64d3_flat_3[1]), pvd.vert_i64d3_flat_3[2]), pvd.vert_i64d3_flat_3[3]))));
int64_t temp_vert_i64d1_flat_4;
INTERP_QUAD_VAR(int64_t, var_vert_i64d1_flat_4 ,vert_i64d1_flat_4[i], temp_vert_i64d1_flat_4);
    bool good_vert_i64d1_flat_4 = (temp_vert_i64d1_flat_4 <= int64_t(max(max(max(pvd.vert_i64d1_flat_4[0], pvd.vert_i64d1_flat_4[1]), pvd.vert_i64d1_flat_4[2]), pvd.vert_i64d1_flat_4[3]))) && (temp_vert_i64d1_flat_4 >= int64_t(min(min(min(pvd.vert_i64d1_flat_4[0], pvd.vert_i64d1_flat_4[1]), pvd.vert_i64d1_flat_4[2]), pvd.vert_i64d1_flat_4[3])));
float32_t temp_vert_f32d1_flat_6;
INTERP_QUAD_VAR(float32_t, var_vert_f32d1_flat_6 ,vert_f32d1_flat_6[i], temp_vert_f32d1_flat_6);
    bool good_vert_f32d1_flat_6 = (temp_vert_f32d1_flat_6 <= float32_t(max(max(max(pvd.vert_f32d1_flat_6[0], pvd.vert_f32d1_flat_6[1]), pvd.vert_f32d1_flat_6[2]), pvd.vert_f32d1_flat_6[3]))) && (temp_vert_f32d1_flat_6 >= float32_t(min(min(min(pvd.vert_f32d1_flat_6[0], pvd.vert_f32d1_flat_6[1]), pvd.vert_f32d1_flat_6[2]), pvd.vert_f32d1_flat_6[3])));
f32vec3 temp_vert_f32d3_flat_1;
INTERP_QUAD_VAR(f32vec3, var_vert_f32d3_flat_1 ,vert_f32d3_flat_1[i], temp_vert_f32d3_flat_1);
    bool good_vert_f32d3_flat_1 = all(lessThanEqual(temp_vert_f32d3_flat_1, f32vec3(max(max(max(pvd.vert_f32d3_flat_1[0], pvd.vert_f32d3_flat_1[1]), pvd.vert_f32d3_flat_1[2]), pvd.vert_f32d3_flat_1[3])))) && all(greaterThanEqual(temp_vert_f32d3_flat_1, f32vec3(min(min(min(pvd.vert_f32d3_flat_1[0], pvd.vert_f32d3_flat_1[1]), pvd.vert_f32d3_flat_1[2]), pvd.vert_f32d3_flat_1[3]))));
i64vec4 temp_vert_i64d4_flat_8;
INTERP_QUAD_VAR(i64vec4, var_vert_i64d4_flat_8 ,vert_i64d4_flat_8[i], temp_vert_i64d4_flat_8);
    bool good_vert_i64d4_flat_8 = all(lessThanEqual(temp_vert_i64d4_flat_8, i64vec4(max(max(max(pvd.vert_i64d4_flat_8[0], pvd.vert_i64d4_flat_8[1]), pvd.vert_i64d4_flat_8[2]), pvd.vert_i64d4_flat_8[3])))) && all(greaterThanEqual(temp_vert_i64d4_flat_8, i64vec4(min(min(min(pvd.vert_i64d4_flat_8[0], pvd.vert_i64d4_flat_8[1]), pvd.vert_i64d4_flat_8[2]), pvd.vert_i64d4_flat_8[3]))));
i64vec2 temp_vert_i64d2_flat_8;
INTERP_QUAD_VAR(i64vec2, var_vert_i64d2_flat_8 ,vert_i64d2_flat_8[i], temp_vert_i64d2_flat_8);
    bool good_vert_i64d2_flat_8 = all(lessThanEqual(temp_vert_i64d2_flat_8, i64vec2(max(max(max(pvd.vert_i64d2_flat_8[0], pvd.vert_i64d2_flat_8[1]), pvd.vert_i64d2_flat_8[2]), pvd.vert_i64d2_flat_8[3])))) && all(greaterThanEqual(temp_vert_i64d2_flat_8, i64vec2(min(min(min(pvd.vert_i64d2_flat_8[0], pvd.vert_i64d2_flat_8[1]), pvd.vert_i64d2_flat_8[2]), pvd.vert_i64d2_flat_8[3]))));
i32vec4 temp_vert_i32d4_flat_4;
INTERP_QUAD_VAR(i32vec4, var_vert_i32d4_flat_4 ,vert_i32d4_flat_4[i], temp_vert_i32d4_flat_4);
    bool good_vert_i32d4_flat_4 = all(lessThanEqual(temp_vert_i32d4_flat_4, i32vec4(max(max(max(pvd.vert_i32d4_flat_4[0], pvd.vert_i32d4_flat_4[1]), pvd.vert_i32d4_flat_4[2]), pvd.vert_i32d4_flat_4[3])))) && all(greaterThanEqual(temp_vert_i32d4_flat_4, i32vec4(min(min(min(pvd.vert_i32d4_flat_4[0], pvd.vert_i32d4_flat_4[1]), pvd.vert_i32d4_flat_4[2]), pvd.vert_i32d4_flat_4[3]))));
f32vec2 temp_vert_f32d2_flat_5;
INTERP_QUAD_VAR(f32vec2, var_vert_f32d2_flat_5 ,vert_f32d2_flat_5[i], temp_vert_f32d2_flat_5);
    bool good_vert_f32d2_flat_5 = all(lessThanEqual(temp_vert_f32d2_flat_5, f32vec2(max(max(max(pvd.vert_f32d2_flat_5[0], pvd.vert_f32d2_flat_5[1]), pvd.vert_f32d2_flat_5[2]), pvd.vert_f32d2_flat_5[3])))) && all(greaterThanEqual(temp_vert_f32d2_flat_5, f32vec2(min(min(min(pvd.vert_f32d2_flat_5[0], pvd.vert_f32d2_flat_5[1]), pvd.vert_f32d2_flat_5[2]), pvd.vert_f32d2_flat_5[3]))));
i64vec3 temp_vert_i64d3_flat_1;
INTERP_QUAD_VAR(i64vec3, var_vert_i64d3_flat_1 ,vert_i64d3_flat_1[i], temp_vert_i64d3_flat_1);
    bool good_vert_i64d3_flat_1 = all(lessThanEqual(temp_vert_i64d3_flat_1, i64vec3(max(max(max(pvd.vert_i64d3_flat_1[0], pvd.vert_i64d3_flat_1[1]), pvd.vert_i64d3_flat_1[2]), pvd.vert_i64d3_flat_1[3])))) && all(greaterThanEqual(temp_vert_i64d3_flat_1, i64vec3(min(min(min(pvd.vert_i64d3_flat_1[0], pvd.vert_i64d3_flat_1[1]), pvd.vert_i64d3_flat_1[2]), pvd.vert_i64d3_flat_1[3]))));
i32vec3 temp_vert_i32d3_flat_4;
INTERP_QUAD_VAR(i32vec3, var_vert_i32d3_flat_4 ,vert_i32d3_flat_4[i], temp_vert_i32d3_flat_4);
    bool good_vert_i32d3_flat_4 = all(lessThanEqual(temp_vert_i32d3_flat_4, i32vec3(max(max(max(pvd.vert_i32d3_flat_4[0], pvd.vert_i32d3_flat_4[1]), pvd.vert_i32d3_flat_4[2]), pvd.vert_i32d3_flat_4[3])))) && all(greaterThanEqual(temp_vert_i32d3_flat_4, i32vec3(min(min(min(pvd.vert_i32d3_flat_4[0], pvd.vert_i32d3_flat_4[1]), pvd.vert_i32d3_flat_4[2]), pvd.vert_i32d3_flat_4[3]))));
f32vec3 temp_vert_f32d3_flat_5;
INTERP_QUAD_VAR(f32vec3, var_vert_f32d3_flat_5 ,vert_f32d3_flat_5[i], temp_vert_f32d3_flat_5);
    bool good_vert_f32d3_flat_5 = all(lessThanEqual(temp_vert_f32d3_flat_5, f32vec3(max(max(max(pvd.vert_f32d3_flat_5[0], pvd.vert_f32d3_flat_5[1]), pvd.vert_f32d3_flat_5[2]), pvd.vert_f32d3_flat_5[3])))) && all(greaterThanEqual(temp_vert_f32d3_flat_5, f32vec3(min(min(min(pvd.vert_f32d3_flat_5[0], pvd.vert_f32d3_flat_5[1]), pvd.vert_f32d3_flat_5[2]), pvd.vert_f32d3_flat_5[3]))));
i32vec2 temp_vert_i32d2_flat_4;
INTERP_QUAD_VAR(i32vec2, var_vert_i32d2_flat_4 ,vert_i32d2_flat_4[i], temp_vert_i32d2_flat_4);
    bool good_vert_i32d2_flat_4 = all(lessThanEqual(temp_vert_i32d2_flat_4, i32vec2(max(max(max(pvd.vert_i32d2_flat_4[0], pvd.vert_i32d2_flat_4[1]), pvd.vert_i32d2_flat_4[2]), pvd.vert_i32d2_flat_4[3])))) && all(greaterThanEqual(temp_vert_i32d2_flat_4, i32vec2(min(min(min(pvd.vert_i32d2_flat_4[0], pvd.vert_i32d2_flat_4[1]), pvd.vert_i32d2_flat_4[2]), pvd.vert_i32d2_flat_4[3]))));
f32vec3 temp_vert_f32d3_inter_6;
INTERP_QUAD_VAR(f32vec3, var_vert_f32d3_inter_6 ,vert_f32d3_inter_6[i], temp_vert_f32d3_inter_6);
    bool good_vert_f32d3_inter_6 = all(lessThanEqual(temp_vert_f32d3_inter_6, f32vec3(max(max(max(pvd.vert_f32d3_inter_6[0], pvd.vert_f32d3_inter_6[1]), pvd.vert_f32d3_inter_6[2]), pvd.vert_f32d3_inter_6[3])))) && all(greaterThanEqual(temp_vert_f32d3_inter_6, f32vec3(min(min(min(pvd.vert_f32d3_inter_6[0], pvd.vert_f32d3_inter_6[1]), pvd.vert_f32d3_inter_6[2]), pvd.vert_f32d3_inter_6[3]))));
i32vec4 temp_vert_i32d4_flat_3;
INTERP_QUAD_VAR(i32vec4, var_vert_i32d4_flat_3 ,vert_i32d4_flat_3[i], temp_vert_i32d4_flat_3);
    bool good_vert_i32d4_flat_3 = all(lessThanEqual(temp_vert_i32d4_flat_3, i32vec4(max(max(max(pvd.vert_i32d4_flat_3[0], pvd.vert_i32d4_flat_3[1]), pvd.vert_i32d4_flat_3[2]), pvd.vert_i32d4_flat_3[3])))) && all(greaterThanEqual(temp_vert_i32d4_flat_3, i32vec4(min(min(min(pvd.vert_i32d4_flat_3[0], pvd.vert_i32d4_flat_3[1]), pvd.vert_i32d4_flat_3[2]), pvd.vert_i32d4_flat_3[3]))));
float32_t temp_vert_f32d1_flat_0;
INTERP_QUAD_VAR(float32_t, var_vert_f32d1_flat_0 ,vert_f32d1_flat_0[i], temp_vert_f32d1_flat_0);
    bool good_vert_f32d1_flat_0 = (temp_vert_f32d1_flat_0 <= float32_t(max(max(max(pvd.vert_f32d1_flat_0[0], pvd.vert_f32d1_flat_0[1]), pvd.vert_f32d1_flat_0[2]), pvd.vert_f32d1_flat_0[3]))) && (temp_vert_f32d1_flat_0 >= float32_t(min(min(min(pvd.vert_f32d1_flat_0[0], pvd.vert_f32d1_flat_0[1]), pvd.vert_f32d1_flat_0[2]), pvd.vert_f32d1_flat_0[3])));
int64_t temp_vert_i64d1_flat_2;
INTERP_QUAD_VAR(int64_t, var_vert_i64d1_flat_2 ,vert_i64d1_flat_2[i], temp_vert_i64d1_flat_2);
    bool good_vert_i64d1_flat_2 = (temp_vert_i64d1_flat_2 <= int64_t(max(max(max(pvd.vert_i64d1_flat_2[0], pvd.vert_i64d1_flat_2[1]), pvd.vert_i64d1_flat_2[2]), pvd.vert_i64d1_flat_2[3]))) && (temp_vert_i64d1_flat_2 >= int64_t(min(min(min(pvd.vert_i64d1_flat_2[0], pvd.vert_i64d1_flat_2[1]), pvd.vert_i64d1_flat_2[2]), pvd.vert_i64d1_flat_2[3])));
i32vec4 temp_vert_i32d4_flat_9;
INTERP_QUAD_VAR(i32vec4, var_vert_i32d4_flat_9 ,vert_i32d4_flat_9[i], temp_vert_i32d4_flat_9);
    bool good_vert_i32d4_flat_9 = all(lessThanEqual(temp_vert_i32d4_flat_9, i32vec4(max(max(max(pvd.vert_i32d4_flat_9[0], pvd.vert_i32d4_flat_9[1]), pvd.vert_i32d4_flat_9[2]), pvd.vert_i32d4_flat_9[3])))) && all(greaterThanEqual(temp_vert_i32d4_flat_9, i32vec4(min(min(min(pvd.vert_i32d4_flat_9[0], pvd.vert_i32d4_flat_9[1]), pvd.vert_i32d4_flat_9[2]), pvd.vert_i32d4_flat_9[3]))));
float32_t temp_vert_f32d1_flat_7;
INTERP_QUAD_VAR(float32_t, var_vert_f32d1_flat_7 ,vert_f32d1_flat_7[i], temp_vert_f32d1_flat_7);
    bool good_vert_f32d1_flat_7 = (temp_vert_f32d1_flat_7 <= float32_t(max(max(max(pvd.vert_f32d1_flat_7[0], pvd.vert_f32d1_flat_7[1]), pvd.vert_f32d1_flat_7[2]), pvd.vert_f32d1_flat_7[3]))) && (temp_vert_f32d1_flat_7 >= float32_t(min(min(min(pvd.vert_f32d1_flat_7[0], pvd.vert_f32d1_flat_7[1]), pvd.vert_f32d1_flat_7[2]), pvd.vert_f32d1_flat_7[3])));
i32vec3 temp_vert_i32d3_flat_6;
INTERP_QUAD_VAR(i32vec3, var_vert_i32d3_flat_6 ,vert_i32d3_flat_6[i], temp_vert_i32d3_flat_6);
    bool good_vert_i32d3_flat_6 = all(lessThanEqual(temp_vert_i32d3_flat_6, i32vec3(max(max(max(pvd.vert_i32d3_flat_6[0], pvd.vert_i32d3_flat_6[1]), pvd.vert_i32d3_flat_6[2]), pvd.vert_i32d3_flat_6[3])))) && all(greaterThanEqual(temp_vert_i32d3_flat_6, i32vec3(min(min(min(pvd.vert_i32d3_flat_6[0], pvd.vert_i32d3_flat_6[1]), pvd.vert_i32d3_flat_6[2]), pvd.vert_i32d3_flat_6[3]))));
float32_t temp_vert_f32d1_inter_4;
INTERP_QUAD_VAR(float32_t, var_vert_f32d1_inter_4 ,vert_f32d1_inter_4[i], temp_vert_f32d1_inter_4);
    bool good_vert_f32d1_inter_4 = (temp_vert_f32d1_inter_4 <= float32_t(max(max(max(pvd.vert_f32d1_inter_4[0], pvd.vert_f32d1_inter_4[1]), pvd.vert_f32d1_inter_4[2]), pvd.vert_f32d1_inter_4[3]))) && (temp_vert_f32d1_inter_4 >= float32_t(min(min(min(pvd.vert_f32d1_inter_4[0], pvd.vert_f32d1_inter_4[1]), pvd.vert_f32d1_inter_4[2]), pvd.vert_f32d1_inter_4[3])));
f32vec4 temp_vert_f32d4_inter_1;
INTERP_QUAD_VAR(f32vec4, var_vert_f32d4_inter_1 ,vert_f32d4_inter_1[i], temp_vert_f32d4_inter_1);
    bool good_vert_f32d4_inter_1 = all(lessThanEqual(temp_vert_f32d4_inter_1, f32vec4(max(max(max(pvd.vert_f32d4_inter_1[0], pvd.vert_f32d4_inter_1[1]), pvd.vert_f32d4_inter_1[2]), pvd.vert_f32d4_inter_1[3])))) && all(greaterThanEqual(temp_vert_f32d4_inter_1, f32vec4(min(min(min(pvd.vert_f32d4_inter_1[0], pvd.vert_f32d4_inter_1[1]), pvd.vert_f32d4_inter_1[2]), pvd.vert_f32d4_inter_1[3]))));
i32vec2 temp_vert_i32d2_flat_0;
INTERP_QUAD_VAR(i32vec2, var_vert_i32d2_flat_0 ,vert_i32d2_flat_0[i], temp_vert_i32d2_flat_0);
    bool good_vert_i32d2_flat_0 = all(lessThanEqual(temp_vert_i32d2_flat_0, i32vec2(max(max(max(pvd.vert_i32d2_flat_0[0], pvd.vert_i32d2_flat_0[1]), pvd.vert_i32d2_flat_0[2]), pvd.vert_i32d2_flat_0[3])))) && all(greaterThanEqual(temp_vert_i32d2_flat_0, i32vec2(min(min(min(pvd.vert_i32d2_flat_0[0], pvd.vert_i32d2_flat_0[1]), pvd.vert_i32d2_flat_0[2]), pvd.vert_i32d2_flat_0[3]))));
i32vec3 temp_vert_i32d3_flat_0;
INTERP_QUAD_VAR(i32vec3, var_vert_i32d3_flat_0 ,vert_i32d3_flat_0[i], temp_vert_i32d3_flat_0);
    bool good_vert_i32d3_flat_0 = all(lessThanEqual(temp_vert_i32d3_flat_0, i32vec3(max(max(max(pvd.vert_i32d3_flat_0[0], pvd.vert_i32d3_flat_0[1]), pvd.vert_i32d3_flat_0[2]), pvd.vert_i32d3_flat_0[3])))) && all(greaterThanEqual(temp_vert_i32d3_flat_0, i32vec3(min(min(min(pvd.vert_i32d3_flat_0[0], pvd.vert_i32d3_flat_0[1]), pvd.vert_i32d3_flat_0[2]), pvd.vert_i32d3_flat_0[3]))));
i32vec4 temp_vert_i32d4_flat_8;
INTERP_QUAD_VAR(i32vec4, var_vert_i32d4_flat_8 ,vert_i32d4_flat_8[i], temp_vert_i32d4_flat_8);
    bool good_vert_i32d4_flat_8 = all(lessThanEqual(temp_vert_i32d4_flat_8, i32vec4(max(max(max(pvd.vert_i32d4_flat_8[0], pvd.vert_i32d4_flat_8[1]), pvd.vert_i32d4_flat_8[2]), pvd.vert_i32d4_flat_8[3])))) && all(greaterThanEqual(temp_vert_i32d4_flat_8, i32vec4(min(min(min(pvd.vert_i32d4_flat_8[0], pvd.vert_i32d4_flat_8[1]), pvd.vert_i32d4_flat_8[2]), pvd.vert_i32d4_flat_8[3]))));
    if (good_vert_i32d2_flat_8 && good_vert_i64d3_flat_3 && good_vert_i64d1_flat_4 && good_vert_f32d1_flat_6 && good_vert_f32d3_flat_1 && good_vert_i64d4_flat_8 && good_vert_i64d2_flat_8 && good_vert_i32d4_flat_4 && good_vert_f32d2_flat_5 && good_vert_i64d3_flat_1 && good_vert_i32d3_flat_4 && good_vert_f32d3_flat_5 && good_vert_i32d2_flat_4 && good_vert_f32d3_inter_6 && good_vert_i32d4_flat_3 && good_vert_f32d1_flat_0 && good_vert_i64d1_flat_2 && good_vert_i32d4_flat_9 && good_vert_f32d1_flat_7 && good_vert_i32d3_flat_6 && good_vert_f32d1_inter_4 && good_vert_f32d4_inter_1 && good_vert_i32d2_flat_0 && good_vert_i32d3_flat_0 && good_vert_i32d4_flat_8) {
        INTERP_QUAD_VAR(vec4, var_color, inColor[i], outColor);
    } else {
        outColor = vec4(0.0, 0.0, 0.0, 1.0);
    }
    INTERP_QUAD_VAR(vec4, var_gl_pos, gl_in[i].gl_Position, gl_Position);
}
