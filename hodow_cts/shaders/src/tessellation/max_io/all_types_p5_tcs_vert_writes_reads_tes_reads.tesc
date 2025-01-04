#version 450
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_shader_explicit_arithmetic_types : enable

layout (vertices = 4) out;


layout (location=0) out vec4 outColor[];

layout (location=1) out flat f32vec2 vert_f32d2_flat_0[];
layout (location=2) out float16_t vert_f16d1_inter_6[];
layout (location=3) out f32vec4 vert_f32d4_inter_1[];
layout (location=4) out flat float16_t vert_f16d1_flat_3[];
layout (location=5) out flat float16_t vert_f16d1_flat_6[];
layout (location=6) out flat i64vec3 vert_i64d3_flat_5[];
layout (location=8) out f16vec3 vert_f16d3_inter_5[];
layout (location=9) out flat float64_t vert_f64d1_flat_2[];
layout (location=10) out f32vec3 vert_f32d3_inter_1[];
layout (location=11) out f16vec3 vert_f16d3_inter_1[];
layout (location=12) out flat i16vec4 vert_i16d4_flat_0[];
layout (location=13) out flat f32vec3 vert_f32d3_flat_3[];
layout (location=14) out f32vec3 vert_f32d3_inter_2[];
layout (location=15) out flat int32_t vert_i32d1_flat_9[];
layout (location=16) out flat i32vec3 vert_i32d3_flat_9[];
layout (location=17) out flat f64vec2 vert_f64d2_flat_7[];
layout (location=18) out f16vec2 vert_f16d2_inter_9[];
layout (location=19) out flat f16vec2 vert_f16d2_flat_1[];
layout (location=20) out flat f64vec2 vert_f64d2_flat_9[];
layout (location=21) out flat i32vec2 vert_i32d2_flat_0[];
layout (location=22) out f16vec2 vert_f16d2_inter_5[];
layout (location=23) out flat f64vec3 vert_f64d3_flat_6[];
layout (location=25) out flat i64vec2 vert_i64d2_flat_1[];
layout (location=26) out flat f64vec4 vert_f64d4_flat_0[];
layout (location=28) out flat float64_t vert_f64d1_flat_9[];

layout(set=0, binding=0, std430) readonly buffer PerVertexBlock {
    vec2 vert_f32d2_flat_0[4];
    float vert_f16d1_inter_6[4];
    vec4 vert_f32d4_inter_1[4];
    float vert_f16d1_flat_3[4];
    float vert_f16d1_flat_6[4];
    ivec3 vert_i64d3_flat_5[4];
    vec3 vert_f16d3_inter_5[4];
    float vert_f64d1_flat_2[4];
    vec3 vert_f32d3_inter_1[4];
    vec3 vert_f16d3_inter_1[4];
    ivec4 vert_i16d4_flat_0[4];
    vec3 vert_f32d3_flat_3[4];
    vec3 vert_f32d3_inter_2[4];
    int vert_i32d1_flat_9[4];
    ivec3 vert_i32d3_flat_9[4];
    vec2 vert_f64d2_flat_7[4];
    vec2 vert_f16d2_inter_9[4];
    vec2 vert_f16d2_flat_1[4];
    vec2 vert_f64d2_flat_9[4];
    ivec2 vert_i32d2_flat_0[4];
    vec2 vert_f16d2_inter_5[4];
    vec3 vert_f64d3_flat_6[4];
    ivec2 vert_i64d2_flat_1[4];
    vec4 vert_f64d4_flat_0[4];
    float vert_f64d1_flat_9[4];
 } pvd;

in gl_PerVertex {
    vec4  gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
} gl_out[];

void main ()
{
    vert_f32d2_flat_0[gl_InvocationID] = f32vec2(pvd.vert_f32d2_flat_0[gl_InvocationID]);
    vert_f16d1_inter_6[gl_InvocationID] = float16_t(pvd.vert_f16d1_inter_6[gl_InvocationID]);
    vert_f32d4_inter_1[gl_InvocationID] = f32vec4(pvd.vert_f32d4_inter_1[gl_InvocationID]);
    vert_f16d1_flat_3[gl_InvocationID] = float16_t(pvd.vert_f16d1_flat_3[gl_InvocationID]);
    vert_f16d1_flat_6[gl_InvocationID] = float16_t(pvd.vert_f16d1_flat_6[gl_InvocationID]);
    vert_i64d3_flat_5[gl_InvocationID] = i64vec3(pvd.vert_i64d3_flat_5[gl_InvocationID]);
    vert_f16d3_inter_5[gl_InvocationID] = f16vec3(pvd.vert_f16d3_inter_5[gl_InvocationID]);
    vert_f64d1_flat_2[gl_InvocationID] = float64_t(pvd.vert_f64d1_flat_2[gl_InvocationID]);
    vert_f32d3_inter_1[gl_InvocationID] = f32vec3(pvd.vert_f32d3_inter_1[gl_InvocationID]);
    vert_f16d3_inter_1[gl_InvocationID] = f16vec3(pvd.vert_f16d3_inter_1[gl_InvocationID]);
    vert_i16d4_flat_0[gl_InvocationID] = i16vec4(pvd.vert_i16d4_flat_0[gl_InvocationID]);
    vert_f32d3_flat_3[gl_InvocationID] = f32vec3(pvd.vert_f32d3_flat_3[gl_InvocationID]);
    vert_f32d3_inter_2[gl_InvocationID] = f32vec3(pvd.vert_f32d3_inter_2[gl_InvocationID]);
    vert_i32d1_flat_9[gl_InvocationID] = int32_t(pvd.vert_i32d1_flat_9[gl_InvocationID]);
    vert_i32d3_flat_9[gl_InvocationID] = i32vec3(pvd.vert_i32d3_flat_9[gl_InvocationID]);
    vert_f64d2_flat_7[gl_InvocationID] = f64vec2(pvd.vert_f64d2_flat_7[gl_InvocationID]);
    vert_f16d2_inter_9[gl_InvocationID] = f16vec2(pvd.vert_f16d2_inter_9[gl_InvocationID]);
    vert_f16d2_flat_1[gl_InvocationID] = f16vec2(pvd.vert_f16d2_flat_1[gl_InvocationID]);
    vert_f64d2_flat_9[gl_InvocationID] = f64vec2(pvd.vert_f64d2_flat_9[gl_InvocationID]);
    vert_i32d2_flat_0[gl_InvocationID] = i32vec2(pvd.vert_i32d2_flat_0[gl_InvocationID]);
    vert_f16d2_inter_5[gl_InvocationID] = f16vec2(pvd.vert_f16d2_inter_5[gl_InvocationID]);
    vert_f64d3_flat_6[gl_InvocationID] = f64vec3(pvd.vert_f64d3_flat_6[gl_InvocationID]);
    vert_i64d2_flat_1[gl_InvocationID] = i64vec2(pvd.vert_i64d2_flat_1[gl_InvocationID]);
    vert_f64d4_flat_0[gl_InvocationID] = f64vec4(pvd.vert_f64d4_flat_0[gl_InvocationID]);
    vert_f64d1_flat_9[gl_InvocationID] = float64_t(pvd.vert_f64d1_flat_9[gl_InvocationID]);
    bool good_vert_f32d2_flat_0 = all(lessThanEqual(vert_f32d2_flat_0[gl_InvocationID], f32vec2(max(max(max(pvd.vert_f32d2_flat_0[0], pvd.vert_f32d2_flat_0[1]), pvd.vert_f32d2_flat_0[2]), pvd.vert_f32d2_flat_0[3])))) && all(greaterThanEqual(vert_f32d2_flat_0[gl_InvocationID], f32vec2(min(min(min(pvd.vert_f32d2_flat_0[0], pvd.vert_f32d2_flat_0[1]), pvd.vert_f32d2_flat_0[2]), pvd.vert_f32d2_flat_0[3]))));
    bool good_vert_f16d1_inter_6 = (vert_f16d1_inter_6[gl_InvocationID] <= float16_t(max(max(max(pvd.vert_f16d1_inter_6[0], pvd.vert_f16d1_inter_6[1]), pvd.vert_f16d1_inter_6[2]), pvd.vert_f16d1_inter_6[3]))) && (vert_f16d1_inter_6[gl_InvocationID] >= float16_t(min(min(min(pvd.vert_f16d1_inter_6[0], pvd.vert_f16d1_inter_6[1]), pvd.vert_f16d1_inter_6[2]), pvd.vert_f16d1_inter_6[3])));
    bool good_vert_f32d4_inter_1 = all(lessThanEqual(vert_f32d4_inter_1[gl_InvocationID], f32vec4(max(max(max(pvd.vert_f32d4_inter_1[0], pvd.vert_f32d4_inter_1[1]), pvd.vert_f32d4_inter_1[2]), pvd.vert_f32d4_inter_1[3])))) && all(greaterThanEqual(vert_f32d4_inter_1[gl_InvocationID], f32vec4(min(min(min(pvd.vert_f32d4_inter_1[0], pvd.vert_f32d4_inter_1[1]), pvd.vert_f32d4_inter_1[2]), pvd.vert_f32d4_inter_1[3]))));
    bool good_vert_f16d1_flat_3 = (vert_f16d1_flat_3[gl_InvocationID] <= float16_t(max(max(max(pvd.vert_f16d1_flat_3[0], pvd.vert_f16d1_flat_3[1]), pvd.vert_f16d1_flat_3[2]), pvd.vert_f16d1_flat_3[3]))) && (vert_f16d1_flat_3[gl_InvocationID] >= float16_t(min(min(min(pvd.vert_f16d1_flat_3[0], pvd.vert_f16d1_flat_3[1]), pvd.vert_f16d1_flat_3[2]), pvd.vert_f16d1_flat_3[3])));
    bool good_vert_f16d1_flat_6 = (vert_f16d1_flat_6[gl_InvocationID] <= float16_t(max(max(max(pvd.vert_f16d1_flat_6[0], pvd.vert_f16d1_flat_6[1]), pvd.vert_f16d1_flat_6[2]), pvd.vert_f16d1_flat_6[3]))) && (vert_f16d1_flat_6[gl_InvocationID] >= float16_t(min(min(min(pvd.vert_f16d1_flat_6[0], pvd.vert_f16d1_flat_6[1]), pvd.vert_f16d1_flat_6[2]), pvd.vert_f16d1_flat_6[3])));
    bool good_vert_i64d3_flat_5 = all(lessThanEqual(vert_i64d3_flat_5[gl_InvocationID], i64vec3(max(max(max(pvd.vert_i64d3_flat_5[0], pvd.vert_i64d3_flat_5[1]), pvd.vert_i64d3_flat_5[2]), pvd.vert_i64d3_flat_5[3])))) && all(greaterThanEqual(vert_i64d3_flat_5[gl_InvocationID], i64vec3(min(min(min(pvd.vert_i64d3_flat_5[0], pvd.vert_i64d3_flat_5[1]), pvd.vert_i64d3_flat_5[2]), pvd.vert_i64d3_flat_5[3]))));
    bool good_vert_f16d3_inter_5 = all(lessThanEqual(vert_f16d3_inter_5[gl_InvocationID], f16vec3(max(max(max(pvd.vert_f16d3_inter_5[0], pvd.vert_f16d3_inter_5[1]), pvd.vert_f16d3_inter_5[2]), pvd.vert_f16d3_inter_5[3])))) && all(greaterThanEqual(vert_f16d3_inter_5[gl_InvocationID], f16vec3(min(min(min(pvd.vert_f16d3_inter_5[0], pvd.vert_f16d3_inter_5[1]), pvd.vert_f16d3_inter_5[2]), pvd.vert_f16d3_inter_5[3]))));
    bool good_vert_f64d1_flat_2 = (vert_f64d1_flat_2[gl_InvocationID] <= float64_t(max(max(max(pvd.vert_f64d1_flat_2[0], pvd.vert_f64d1_flat_2[1]), pvd.vert_f64d1_flat_2[2]), pvd.vert_f64d1_flat_2[3]))) && (vert_f64d1_flat_2[gl_InvocationID] >= float64_t(min(min(min(pvd.vert_f64d1_flat_2[0], pvd.vert_f64d1_flat_2[1]), pvd.vert_f64d1_flat_2[2]), pvd.vert_f64d1_flat_2[3])));
    bool good_vert_f32d3_inter_1 = all(lessThanEqual(vert_f32d3_inter_1[gl_InvocationID], f32vec3(max(max(max(pvd.vert_f32d3_inter_1[0], pvd.vert_f32d3_inter_1[1]), pvd.vert_f32d3_inter_1[2]), pvd.vert_f32d3_inter_1[3])))) && all(greaterThanEqual(vert_f32d3_inter_1[gl_InvocationID], f32vec3(min(min(min(pvd.vert_f32d3_inter_1[0], pvd.vert_f32d3_inter_1[1]), pvd.vert_f32d3_inter_1[2]), pvd.vert_f32d3_inter_1[3]))));
    bool good_vert_f16d3_inter_1 = all(lessThanEqual(vert_f16d3_inter_1[gl_InvocationID], f16vec3(max(max(max(pvd.vert_f16d3_inter_1[0], pvd.vert_f16d3_inter_1[1]), pvd.vert_f16d3_inter_1[2]), pvd.vert_f16d3_inter_1[3])))) && all(greaterThanEqual(vert_f16d3_inter_1[gl_InvocationID], f16vec3(min(min(min(pvd.vert_f16d3_inter_1[0], pvd.vert_f16d3_inter_1[1]), pvd.vert_f16d3_inter_1[2]), pvd.vert_f16d3_inter_1[3]))));
    bool good_vert_i16d4_flat_0 = all(lessThanEqual(vert_i16d4_flat_0[gl_InvocationID], i16vec4(max(max(max(pvd.vert_i16d4_flat_0[0], pvd.vert_i16d4_flat_0[1]), pvd.vert_i16d4_flat_0[2]), pvd.vert_i16d4_flat_0[3])))) && all(greaterThanEqual(vert_i16d4_flat_0[gl_InvocationID], i16vec4(min(min(min(pvd.vert_i16d4_flat_0[0], pvd.vert_i16d4_flat_0[1]), pvd.vert_i16d4_flat_0[2]), pvd.vert_i16d4_flat_0[3]))));
    bool good_vert_f32d3_flat_3 = all(lessThanEqual(vert_f32d3_flat_3[gl_InvocationID], f32vec3(max(max(max(pvd.vert_f32d3_flat_3[0], pvd.vert_f32d3_flat_3[1]), pvd.vert_f32d3_flat_3[2]), pvd.vert_f32d3_flat_3[3])))) && all(greaterThanEqual(vert_f32d3_flat_3[gl_InvocationID], f32vec3(min(min(min(pvd.vert_f32d3_flat_3[0], pvd.vert_f32d3_flat_3[1]), pvd.vert_f32d3_flat_3[2]), pvd.vert_f32d3_flat_3[3]))));
    bool good_vert_f32d3_inter_2 = all(lessThanEqual(vert_f32d3_inter_2[gl_InvocationID], f32vec3(max(max(max(pvd.vert_f32d3_inter_2[0], pvd.vert_f32d3_inter_2[1]), pvd.vert_f32d3_inter_2[2]), pvd.vert_f32d3_inter_2[3])))) && all(greaterThanEqual(vert_f32d3_inter_2[gl_InvocationID], f32vec3(min(min(min(pvd.vert_f32d3_inter_2[0], pvd.vert_f32d3_inter_2[1]), pvd.vert_f32d3_inter_2[2]), pvd.vert_f32d3_inter_2[3]))));
    bool good_vert_i32d1_flat_9 = (vert_i32d1_flat_9[gl_InvocationID] <= int32_t(max(max(max(pvd.vert_i32d1_flat_9[0], pvd.vert_i32d1_flat_9[1]), pvd.vert_i32d1_flat_9[2]), pvd.vert_i32d1_flat_9[3]))) && (vert_i32d1_flat_9[gl_InvocationID] >= int32_t(min(min(min(pvd.vert_i32d1_flat_9[0], pvd.vert_i32d1_flat_9[1]), pvd.vert_i32d1_flat_9[2]), pvd.vert_i32d1_flat_9[3])));
    bool good_vert_i32d3_flat_9 = all(lessThanEqual(vert_i32d3_flat_9[gl_InvocationID], i32vec3(max(max(max(pvd.vert_i32d3_flat_9[0], pvd.vert_i32d3_flat_9[1]), pvd.vert_i32d3_flat_9[2]), pvd.vert_i32d3_flat_9[3])))) && all(greaterThanEqual(vert_i32d3_flat_9[gl_InvocationID], i32vec3(min(min(min(pvd.vert_i32d3_flat_9[0], pvd.vert_i32d3_flat_9[1]), pvd.vert_i32d3_flat_9[2]), pvd.vert_i32d3_flat_9[3]))));
    bool good_vert_f64d2_flat_7 = all(lessThanEqual(vert_f64d2_flat_7[gl_InvocationID], f64vec2(max(max(max(pvd.vert_f64d2_flat_7[0], pvd.vert_f64d2_flat_7[1]), pvd.vert_f64d2_flat_7[2]), pvd.vert_f64d2_flat_7[3])))) && all(greaterThanEqual(vert_f64d2_flat_7[gl_InvocationID], f64vec2(min(min(min(pvd.vert_f64d2_flat_7[0], pvd.vert_f64d2_flat_7[1]), pvd.vert_f64d2_flat_7[2]), pvd.vert_f64d2_flat_7[3]))));
    bool good_vert_f16d2_inter_9 = all(lessThanEqual(vert_f16d2_inter_9[gl_InvocationID], f16vec2(max(max(max(pvd.vert_f16d2_inter_9[0], pvd.vert_f16d2_inter_9[1]), pvd.vert_f16d2_inter_9[2]), pvd.vert_f16d2_inter_9[3])))) && all(greaterThanEqual(vert_f16d2_inter_9[gl_InvocationID], f16vec2(min(min(min(pvd.vert_f16d2_inter_9[0], pvd.vert_f16d2_inter_9[1]), pvd.vert_f16d2_inter_9[2]), pvd.vert_f16d2_inter_9[3]))));
    bool good_vert_f16d2_flat_1 = all(lessThanEqual(vert_f16d2_flat_1[gl_InvocationID], f16vec2(max(max(max(pvd.vert_f16d2_flat_1[0], pvd.vert_f16d2_flat_1[1]), pvd.vert_f16d2_flat_1[2]), pvd.vert_f16d2_flat_1[3])))) && all(greaterThanEqual(vert_f16d2_flat_1[gl_InvocationID], f16vec2(min(min(min(pvd.vert_f16d2_flat_1[0], pvd.vert_f16d2_flat_1[1]), pvd.vert_f16d2_flat_1[2]), pvd.vert_f16d2_flat_1[3]))));
    bool good_vert_f64d2_flat_9 = all(lessThanEqual(vert_f64d2_flat_9[gl_InvocationID], f64vec2(max(max(max(pvd.vert_f64d2_flat_9[0], pvd.vert_f64d2_flat_9[1]), pvd.vert_f64d2_flat_9[2]), pvd.vert_f64d2_flat_9[3])))) && all(greaterThanEqual(vert_f64d2_flat_9[gl_InvocationID], f64vec2(min(min(min(pvd.vert_f64d2_flat_9[0], pvd.vert_f64d2_flat_9[1]), pvd.vert_f64d2_flat_9[2]), pvd.vert_f64d2_flat_9[3]))));
    bool good_vert_i32d2_flat_0 = all(lessThanEqual(vert_i32d2_flat_0[gl_InvocationID], i32vec2(max(max(max(pvd.vert_i32d2_flat_0[0], pvd.vert_i32d2_flat_0[1]), pvd.vert_i32d2_flat_0[2]), pvd.vert_i32d2_flat_0[3])))) && all(greaterThanEqual(vert_i32d2_flat_0[gl_InvocationID], i32vec2(min(min(min(pvd.vert_i32d2_flat_0[0], pvd.vert_i32d2_flat_0[1]), pvd.vert_i32d2_flat_0[2]), pvd.vert_i32d2_flat_0[3]))));
    bool good_vert_f16d2_inter_5 = all(lessThanEqual(vert_f16d2_inter_5[gl_InvocationID], f16vec2(max(max(max(pvd.vert_f16d2_inter_5[0], pvd.vert_f16d2_inter_5[1]), pvd.vert_f16d2_inter_5[2]), pvd.vert_f16d2_inter_5[3])))) && all(greaterThanEqual(vert_f16d2_inter_5[gl_InvocationID], f16vec2(min(min(min(pvd.vert_f16d2_inter_5[0], pvd.vert_f16d2_inter_5[1]), pvd.vert_f16d2_inter_5[2]), pvd.vert_f16d2_inter_5[3]))));
    bool good_vert_f64d3_flat_6 = all(lessThanEqual(vert_f64d3_flat_6[gl_InvocationID], f64vec3(max(max(max(pvd.vert_f64d3_flat_6[0], pvd.vert_f64d3_flat_6[1]), pvd.vert_f64d3_flat_6[2]), pvd.vert_f64d3_flat_6[3])))) && all(greaterThanEqual(vert_f64d3_flat_6[gl_InvocationID], f64vec3(min(min(min(pvd.vert_f64d3_flat_6[0], pvd.vert_f64d3_flat_6[1]), pvd.vert_f64d3_flat_6[2]), pvd.vert_f64d3_flat_6[3]))));
    bool good_vert_i64d2_flat_1 = all(lessThanEqual(vert_i64d2_flat_1[gl_InvocationID], i64vec2(max(max(max(pvd.vert_i64d2_flat_1[0], pvd.vert_i64d2_flat_1[1]), pvd.vert_i64d2_flat_1[2]), pvd.vert_i64d2_flat_1[3])))) && all(greaterThanEqual(vert_i64d2_flat_1[gl_InvocationID], i64vec2(min(min(min(pvd.vert_i64d2_flat_1[0], pvd.vert_i64d2_flat_1[1]), pvd.vert_i64d2_flat_1[2]), pvd.vert_i64d2_flat_1[3]))));
    bool good_vert_f64d4_flat_0 = all(lessThanEqual(vert_f64d4_flat_0[gl_InvocationID], f64vec4(max(max(max(pvd.vert_f64d4_flat_0[0], pvd.vert_f64d4_flat_0[1]), pvd.vert_f64d4_flat_0[2]), pvd.vert_f64d4_flat_0[3])))) && all(greaterThanEqual(vert_f64d4_flat_0[gl_InvocationID], f64vec4(min(min(min(pvd.vert_f64d4_flat_0[0], pvd.vert_f64d4_flat_0[1]), pvd.vert_f64d4_flat_0[2]), pvd.vert_f64d4_flat_0[3]))));
    bool good_vert_f64d1_flat_9 = (vert_f64d1_flat_9[gl_InvocationID] <= float64_t(max(max(max(pvd.vert_f64d1_flat_9[0], pvd.vert_f64d1_flat_9[1]), pvd.vert_f64d1_flat_9[2]), pvd.vert_f64d1_flat_9[3]))) && (vert_f64d1_flat_9[gl_InvocationID] >= float64_t(min(min(min(pvd.vert_f64d1_flat_9[0], pvd.vert_f64d1_flat_9[1]), pvd.vert_f64d1_flat_9[2]), pvd.vert_f64d1_flat_9[3])));
    if (good_vert_f32d2_flat_0 && good_vert_f16d1_inter_6 && good_vert_f32d4_inter_1 && good_vert_f16d1_flat_3 && good_vert_f16d1_flat_6 && good_vert_i64d3_flat_5 && good_vert_f16d3_inter_5 && good_vert_f64d1_flat_2 && good_vert_f32d3_inter_1 && good_vert_f16d3_inter_1 && good_vert_i16d4_flat_0 && good_vert_f32d3_flat_3 && good_vert_f32d3_inter_2 && good_vert_i32d1_flat_9 && good_vert_i32d3_flat_9 && good_vert_f64d2_flat_7 && good_vert_f16d2_inter_9 && good_vert_f16d2_flat_1 && good_vert_f64d2_flat_9 && good_vert_i32d2_flat_0 && good_vert_f16d2_inter_5 && good_vert_f64d3_flat_6 && good_vert_i64d2_flat_1 && good_vert_f64d4_flat_0 && good_vert_f64d1_flat_9) {
        outColor[gl_InvocationID] = (gl_PrimitiveID == 0) ? vec4(0.0, 0.0, 1.0, 1.0) : vec4(1.0, 1.0, 0.0, 1.0);
    } else {
        outColor[gl_InvocationID] = vec4(0.0, 0.0, 0.0, 1.0);
    }
   gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
   gl_TessLevelOuter = float[4](1.0, 1.0, 1.0, 1.0);
   gl_TessLevelInner = float[2](1.0, 1.0);

}
