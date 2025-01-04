#version 450
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_shader_explicit_arithmetic_types : enable

layout (vertices = 4) out;


layout (location=0) out vec4 outColor[];

layout (location=1) out flat f32vec4 vert_f32d4_flat_0[];
layout (location=2) out flat f32vec3 vert_f32d3_flat_7[];
layout (location=3) out flat i32vec2 vert_i32d2_flat_1[];
layout (location=4) out float32_t vert_f32d1_inter_0[];
layout (location=5) out flat float32_t vert_f32d1_flat_2[];
layout (location=6) out float32_t vert_f32d1_inter_8[];
layout (location=7) out flat int32_t vert_i32d1_flat_8[];
layout (location=8) out f32vec4 vert_f32d4_inter_8[];
layout (location=9) out flat f32vec3 vert_f32d3_flat_0[];
layout (location=10) out f32vec3 vert_f32d3_inter_1[];
layout (location=11) out float32_t vert_f32d1_inter_6[];
layout (location=12) out f32vec3 vert_f32d3_inter_3[];
layout (location=13) out flat f32vec2 vert_f32d2_flat_3[];
layout (location=14) out flat i32vec4 vert_i32d4_flat_1[];
layout (location=15) out f32vec4 vert_f32d4_inter_7[];
layout (location=16) out flat i32vec4 vert_i32d4_flat_4[];
layout (location=17) out f32vec3 vert_f32d3_inter_7[];
layout (location=18) out float32_t vert_f32d1_inter_7[];
layout (location=19) out flat int32_t vert_i32d1_flat_7[];
layout (location=20) out float32_t vert_f32d1_inter_4[];
layout (location=21) out f32vec3 vert_f32d3_inter_9[];
layout (location=22) out flat float32_t vert_f32d1_flat_7[];
layout (location=23) out f32vec2 vert_f32d2_inter_7[];
layout (location=24) out f32vec2 vert_f32d2_inter_4[];
layout (location=25) out f32vec3 vert_f32d3_inter_5[];
layout (location=26) out flat i32vec2 vert_i32d2_flat_3[];
layout (location=27) out flat f32vec4 vert_f32d4_flat_5[];
layout (location=28) out flat f32vec3 vert_f32d3_flat_1[];

layout(set=0, binding=0, std430) readonly buffer PerVertexBlock {
    vec4 vert_f32d4_flat_0[4];
    vec3 vert_f32d3_flat_7[4];
    ivec2 vert_i32d2_flat_1[4];
    float vert_f32d1_inter_0[4];
    float vert_f32d1_flat_2[4];
    float vert_f32d1_inter_8[4];
    int vert_i32d1_flat_8[4];
    vec4 vert_f32d4_inter_8[4];
    vec3 vert_f32d3_flat_0[4];
    vec3 vert_f32d3_inter_1[4];
    float vert_f32d1_inter_6[4];
    vec3 vert_f32d3_inter_3[4];
    vec2 vert_f32d2_flat_3[4];
    ivec4 vert_i32d4_flat_1[4];
    vec4 vert_f32d4_inter_7[4];
    ivec4 vert_i32d4_flat_4[4];
    vec3 vert_f32d3_inter_7[4];
    float vert_f32d1_inter_7[4];
    int vert_i32d1_flat_7[4];
    float vert_f32d1_inter_4[4];
    vec3 vert_f32d3_inter_9[4];
    float vert_f32d1_flat_7[4];
    vec2 vert_f32d2_inter_7[4];
    vec2 vert_f32d2_inter_4[4];
    vec3 vert_f32d3_inter_5[4];
    ivec2 vert_i32d2_flat_3[4];
    vec4 vert_f32d4_flat_5[4];
    vec3 vert_f32d3_flat_1[4];
 } pvd;

in gl_PerVertex {
    vec4  gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
} gl_out[];

void main ()
{
    vert_f32d4_flat_0[gl_InvocationID] = f32vec4(pvd.vert_f32d4_flat_0[gl_InvocationID]);
    vert_f32d3_flat_7[gl_InvocationID] = f32vec3(pvd.vert_f32d3_flat_7[gl_InvocationID]);
    vert_i32d2_flat_1[gl_InvocationID] = i32vec2(pvd.vert_i32d2_flat_1[gl_InvocationID]);
    vert_f32d1_inter_0[gl_InvocationID] = float32_t(pvd.vert_f32d1_inter_0[gl_InvocationID]);
    vert_f32d1_flat_2[gl_InvocationID] = float32_t(pvd.vert_f32d1_flat_2[gl_InvocationID]);
    vert_f32d1_inter_8[gl_InvocationID] = float32_t(pvd.vert_f32d1_inter_8[gl_InvocationID]);
    vert_i32d1_flat_8[gl_InvocationID] = int32_t(pvd.vert_i32d1_flat_8[gl_InvocationID]);
    vert_f32d4_inter_8[gl_InvocationID] = f32vec4(pvd.vert_f32d4_inter_8[gl_InvocationID]);
    vert_f32d3_flat_0[gl_InvocationID] = f32vec3(pvd.vert_f32d3_flat_0[gl_InvocationID]);
    vert_f32d3_inter_1[gl_InvocationID] = f32vec3(pvd.vert_f32d3_inter_1[gl_InvocationID]);
    vert_f32d1_inter_6[gl_InvocationID] = float32_t(pvd.vert_f32d1_inter_6[gl_InvocationID]);
    vert_f32d3_inter_3[gl_InvocationID] = f32vec3(pvd.vert_f32d3_inter_3[gl_InvocationID]);
    vert_f32d2_flat_3[gl_InvocationID] = f32vec2(pvd.vert_f32d2_flat_3[gl_InvocationID]);
    vert_i32d4_flat_1[gl_InvocationID] = i32vec4(pvd.vert_i32d4_flat_1[gl_InvocationID]);
    vert_f32d4_inter_7[gl_InvocationID] = f32vec4(pvd.vert_f32d4_inter_7[gl_InvocationID]);
    vert_i32d4_flat_4[gl_InvocationID] = i32vec4(pvd.vert_i32d4_flat_4[gl_InvocationID]);
    vert_f32d3_inter_7[gl_InvocationID] = f32vec3(pvd.vert_f32d3_inter_7[gl_InvocationID]);
    vert_f32d1_inter_7[gl_InvocationID] = float32_t(pvd.vert_f32d1_inter_7[gl_InvocationID]);
    vert_i32d1_flat_7[gl_InvocationID] = int32_t(pvd.vert_i32d1_flat_7[gl_InvocationID]);
    vert_f32d1_inter_4[gl_InvocationID] = float32_t(pvd.vert_f32d1_inter_4[gl_InvocationID]);
    vert_f32d3_inter_9[gl_InvocationID] = f32vec3(pvd.vert_f32d3_inter_9[gl_InvocationID]);
    vert_f32d1_flat_7[gl_InvocationID] = float32_t(pvd.vert_f32d1_flat_7[gl_InvocationID]);
    vert_f32d2_inter_7[gl_InvocationID] = f32vec2(pvd.vert_f32d2_inter_7[gl_InvocationID]);
    vert_f32d2_inter_4[gl_InvocationID] = f32vec2(pvd.vert_f32d2_inter_4[gl_InvocationID]);
    vert_f32d3_inter_5[gl_InvocationID] = f32vec3(pvd.vert_f32d3_inter_5[gl_InvocationID]);
    vert_i32d2_flat_3[gl_InvocationID] = i32vec2(pvd.vert_i32d2_flat_3[gl_InvocationID]);
    vert_f32d4_flat_5[gl_InvocationID] = f32vec4(pvd.vert_f32d4_flat_5[gl_InvocationID]);
    vert_f32d3_flat_1[gl_InvocationID] = f32vec3(pvd.vert_f32d3_flat_1[gl_InvocationID]);
    bool good_vert_f32d4_flat_0 = all(lessThanEqual(vert_f32d4_flat_0[gl_InvocationID], f32vec4(max(max(max(pvd.vert_f32d4_flat_0[0], pvd.vert_f32d4_flat_0[1]), pvd.vert_f32d4_flat_0[2]), pvd.vert_f32d4_flat_0[3])))) && all(greaterThanEqual(vert_f32d4_flat_0[gl_InvocationID], f32vec4(min(min(min(pvd.vert_f32d4_flat_0[0], pvd.vert_f32d4_flat_0[1]), pvd.vert_f32d4_flat_0[2]), pvd.vert_f32d4_flat_0[3]))));
    bool good_vert_f32d3_flat_7 = all(lessThanEqual(vert_f32d3_flat_7[gl_InvocationID], f32vec3(max(max(max(pvd.vert_f32d3_flat_7[0], pvd.vert_f32d3_flat_7[1]), pvd.vert_f32d3_flat_7[2]), pvd.vert_f32d3_flat_7[3])))) && all(greaterThanEqual(vert_f32d3_flat_7[gl_InvocationID], f32vec3(min(min(min(pvd.vert_f32d3_flat_7[0], pvd.vert_f32d3_flat_7[1]), pvd.vert_f32d3_flat_7[2]), pvd.vert_f32d3_flat_7[3]))));
    bool good_vert_i32d2_flat_1 = all(lessThanEqual(vert_i32d2_flat_1[gl_InvocationID], i32vec2(max(max(max(pvd.vert_i32d2_flat_1[0], pvd.vert_i32d2_flat_1[1]), pvd.vert_i32d2_flat_1[2]), pvd.vert_i32d2_flat_1[3])))) && all(greaterThanEqual(vert_i32d2_flat_1[gl_InvocationID], i32vec2(min(min(min(pvd.vert_i32d2_flat_1[0], pvd.vert_i32d2_flat_1[1]), pvd.vert_i32d2_flat_1[2]), pvd.vert_i32d2_flat_1[3]))));
    bool good_vert_f32d1_inter_0 = (vert_f32d1_inter_0[gl_InvocationID] <= float32_t(max(max(max(pvd.vert_f32d1_inter_0[0], pvd.vert_f32d1_inter_0[1]), pvd.vert_f32d1_inter_0[2]), pvd.vert_f32d1_inter_0[3]))) && (vert_f32d1_inter_0[gl_InvocationID] >= float32_t(min(min(min(pvd.vert_f32d1_inter_0[0], pvd.vert_f32d1_inter_0[1]), pvd.vert_f32d1_inter_0[2]), pvd.vert_f32d1_inter_0[3])));
    bool good_vert_f32d1_flat_2 = (vert_f32d1_flat_2[gl_InvocationID] <= float32_t(max(max(max(pvd.vert_f32d1_flat_2[0], pvd.vert_f32d1_flat_2[1]), pvd.vert_f32d1_flat_2[2]), pvd.vert_f32d1_flat_2[3]))) && (vert_f32d1_flat_2[gl_InvocationID] >= float32_t(min(min(min(pvd.vert_f32d1_flat_2[0], pvd.vert_f32d1_flat_2[1]), pvd.vert_f32d1_flat_2[2]), pvd.vert_f32d1_flat_2[3])));
    bool good_vert_f32d1_inter_8 = (vert_f32d1_inter_8[gl_InvocationID] <= float32_t(max(max(max(pvd.vert_f32d1_inter_8[0], pvd.vert_f32d1_inter_8[1]), pvd.vert_f32d1_inter_8[2]), pvd.vert_f32d1_inter_8[3]))) && (vert_f32d1_inter_8[gl_InvocationID] >= float32_t(min(min(min(pvd.vert_f32d1_inter_8[0], pvd.vert_f32d1_inter_8[1]), pvd.vert_f32d1_inter_8[2]), pvd.vert_f32d1_inter_8[3])));
    bool good_vert_i32d1_flat_8 = (vert_i32d1_flat_8[gl_InvocationID] <= int32_t(max(max(max(pvd.vert_i32d1_flat_8[0], pvd.vert_i32d1_flat_8[1]), pvd.vert_i32d1_flat_8[2]), pvd.vert_i32d1_flat_8[3]))) && (vert_i32d1_flat_8[gl_InvocationID] >= int32_t(min(min(min(pvd.vert_i32d1_flat_8[0], pvd.vert_i32d1_flat_8[1]), pvd.vert_i32d1_flat_8[2]), pvd.vert_i32d1_flat_8[3])));
    bool good_vert_f32d4_inter_8 = all(lessThanEqual(vert_f32d4_inter_8[gl_InvocationID], f32vec4(max(max(max(pvd.vert_f32d4_inter_8[0], pvd.vert_f32d4_inter_8[1]), pvd.vert_f32d4_inter_8[2]), pvd.vert_f32d4_inter_8[3])))) && all(greaterThanEqual(vert_f32d4_inter_8[gl_InvocationID], f32vec4(min(min(min(pvd.vert_f32d4_inter_8[0], pvd.vert_f32d4_inter_8[1]), pvd.vert_f32d4_inter_8[2]), pvd.vert_f32d4_inter_8[3]))));
    bool good_vert_f32d3_flat_0 = all(lessThanEqual(vert_f32d3_flat_0[gl_InvocationID], f32vec3(max(max(max(pvd.vert_f32d3_flat_0[0], pvd.vert_f32d3_flat_0[1]), pvd.vert_f32d3_flat_0[2]), pvd.vert_f32d3_flat_0[3])))) && all(greaterThanEqual(vert_f32d3_flat_0[gl_InvocationID], f32vec3(min(min(min(pvd.vert_f32d3_flat_0[0], pvd.vert_f32d3_flat_0[1]), pvd.vert_f32d3_flat_0[2]), pvd.vert_f32d3_flat_0[3]))));
    bool good_vert_f32d3_inter_1 = all(lessThanEqual(vert_f32d3_inter_1[gl_InvocationID], f32vec3(max(max(max(pvd.vert_f32d3_inter_1[0], pvd.vert_f32d3_inter_1[1]), pvd.vert_f32d3_inter_1[2]), pvd.vert_f32d3_inter_1[3])))) && all(greaterThanEqual(vert_f32d3_inter_1[gl_InvocationID], f32vec3(min(min(min(pvd.vert_f32d3_inter_1[0], pvd.vert_f32d3_inter_1[1]), pvd.vert_f32d3_inter_1[2]), pvd.vert_f32d3_inter_1[3]))));
    bool good_vert_f32d1_inter_6 = (vert_f32d1_inter_6[gl_InvocationID] <= float32_t(max(max(max(pvd.vert_f32d1_inter_6[0], pvd.vert_f32d1_inter_6[1]), pvd.vert_f32d1_inter_6[2]), pvd.vert_f32d1_inter_6[3]))) && (vert_f32d1_inter_6[gl_InvocationID] >= float32_t(min(min(min(pvd.vert_f32d1_inter_6[0], pvd.vert_f32d1_inter_6[1]), pvd.vert_f32d1_inter_6[2]), pvd.vert_f32d1_inter_6[3])));
    bool good_vert_f32d3_inter_3 = all(lessThanEqual(vert_f32d3_inter_3[gl_InvocationID], f32vec3(max(max(max(pvd.vert_f32d3_inter_3[0], pvd.vert_f32d3_inter_3[1]), pvd.vert_f32d3_inter_3[2]), pvd.vert_f32d3_inter_3[3])))) && all(greaterThanEqual(vert_f32d3_inter_3[gl_InvocationID], f32vec3(min(min(min(pvd.vert_f32d3_inter_3[0], pvd.vert_f32d3_inter_3[1]), pvd.vert_f32d3_inter_3[2]), pvd.vert_f32d3_inter_3[3]))));
    bool good_vert_f32d2_flat_3 = all(lessThanEqual(vert_f32d2_flat_3[gl_InvocationID], f32vec2(max(max(max(pvd.vert_f32d2_flat_3[0], pvd.vert_f32d2_flat_3[1]), pvd.vert_f32d2_flat_3[2]), pvd.vert_f32d2_flat_3[3])))) && all(greaterThanEqual(vert_f32d2_flat_3[gl_InvocationID], f32vec2(min(min(min(pvd.vert_f32d2_flat_3[0], pvd.vert_f32d2_flat_3[1]), pvd.vert_f32d2_flat_3[2]), pvd.vert_f32d2_flat_3[3]))));
    bool good_vert_i32d4_flat_1 = all(lessThanEqual(vert_i32d4_flat_1[gl_InvocationID], i32vec4(max(max(max(pvd.vert_i32d4_flat_1[0], pvd.vert_i32d4_flat_1[1]), pvd.vert_i32d4_flat_1[2]), pvd.vert_i32d4_flat_1[3])))) && all(greaterThanEqual(vert_i32d4_flat_1[gl_InvocationID], i32vec4(min(min(min(pvd.vert_i32d4_flat_1[0], pvd.vert_i32d4_flat_1[1]), pvd.vert_i32d4_flat_1[2]), pvd.vert_i32d4_flat_1[3]))));
    bool good_vert_f32d4_inter_7 = all(lessThanEqual(vert_f32d4_inter_7[gl_InvocationID], f32vec4(max(max(max(pvd.vert_f32d4_inter_7[0], pvd.vert_f32d4_inter_7[1]), pvd.vert_f32d4_inter_7[2]), pvd.vert_f32d4_inter_7[3])))) && all(greaterThanEqual(vert_f32d4_inter_7[gl_InvocationID], f32vec4(min(min(min(pvd.vert_f32d4_inter_7[0], pvd.vert_f32d4_inter_7[1]), pvd.vert_f32d4_inter_7[2]), pvd.vert_f32d4_inter_7[3]))));
    bool good_vert_i32d4_flat_4 = all(lessThanEqual(vert_i32d4_flat_4[gl_InvocationID], i32vec4(max(max(max(pvd.vert_i32d4_flat_4[0], pvd.vert_i32d4_flat_4[1]), pvd.vert_i32d4_flat_4[2]), pvd.vert_i32d4_flat_4[3])))) && all(greaterThanEqual(vert_i32d4_flat_4[gl_InvocationID], i32vec4(min(min(min(pvd.vert_i32d4_flat_4[0], pvd.vert_i32d4_flat_4[1]), pvd.vert_i32d4_flat_4[2]), pvd.vert_i32d4_flat_4[3]))));
    bool good_vert_f32d3_inter_7 = all(lessThanEqual(vert_f32d3_inter_7[gl_InvocationID], f32vec3(max(max(max(pvd.vert_f32d3_inter_7[0], pvd.vert_f32d3_inter_7[1]), pvd.vert_f32d3_inter_7[2]), pvd.vert_f32d3_inter_7[3])))) && all(greaterThanEqual(vert_f32d3_inter_7[gl_InvocationID], f32vec3(min(min(min(pvd.vert_f32d3_inter_7[0], pvd.vert_f32d3_inter_7[1]), pvd.vert_f32d3_inter_7[2]), pvd.vert_f32d3_inter_7[3]))));
    bool good_vert_f32d1_inter_7 = (vert_f32d1_inter_7[gl_InvocationID] <= float32_t(max(max(max(pvd.vert_f32d1_inter_7[0], pvd.vert_f32d1_inter_7[1]), pvd.vert_f32d1_inter_7[2]), pvd.vert_f32d1_inter_7[3]))) && (vert_f32d1_inter_7[gl_InvocationID] >= float32_t(min(min(min(pvd.vert_f32d1_inter_7[0], pvd.vert_f32d1_inter_7[1]), pvd.vert_f32d1_inter_7[2]), pvd.vert_f32d1_inter_7[3])));
    bool good_vert_i32d1_flat_7 = (vert_i32d1_flat_7[gl_InvocationID] <= int32_t(max(max(max(pvd.vert_i32d1_flat_7[0], pvd.vert_i32d1_flat_7[1]), pvd.vert_i32d1_flat_7[2]), pvd.vert_i32d1_flat_7[3]))) && (vert_i32d1_flat_7[gl_InvocationID] >= int32_t(min(min(min(pvd.vert_i32d1_flat_7[0], pvd.vert_i32d1_flat_7[1]), pvd.vert_i32d1_flat_7[2]), pvd.vert_i32d1_flat_7[3])));
    bool good_vert_f32d1_inter_4 = (vert_f32d1_inter_4[gl_InvocationID] <= float32_t(max(max(max(pvd.vert_f32d1_inter_4[0], pvd.vert_f32d1_inter_4[1]), pvd.vert_f32d1_inter_4[2]), pvd.vert_f32d1_inter_4[3]))) && (vert_f32d1_inter_4[gl_InvocationID] >= float32_t(min(min(min(pvd.vert_f32d1_inter_4[0], pvd.vert_f32d1_inter_4[1]), pvd.vert_f32d1_inter_4[2]), pvd.vert_f32d1_inter_4[3])));
    bool good_vert_f32d3_inter_9 = all(lessThanEqual(vert_f32d3_inter_9[gl_InvocationID], f32vec3(max(max(max(pvd.vert_f32d3_inter_9[0], pvd.vert_f32d3_inter_9[1]), pvd.vert_f32d3_inter_9[2]), pvd.vert_f32d3_inter_9[3])))) && all(greaterThanEqual(vert_f32d3_inter_9[gl_InvocationID], f32vec3(min(min(min(pvd.vert_f32d3_inter_9[0], pvd.vert_f32d3_inter_9[1]), pvd.vert_f32d3_inter_9[2]), pvd.vert_f32d3_inter_9[3]))));
    bool good_vert_f32d1_flat_7 = (vert_f32d1_flat_7[gl_InvocationID] <= float32_t(max(max(max(pvd.vert_f32d1_flat_7[0], pvd.vert_f32d1_flat_7[1]), pvd.vert_f32d1_flat_7[2]), pvd.vert_f32d1_flat_7[3]))) && (vert_f32d1_flat_7[gl_InvocationID] >= float32_t(min(min(min(pvd.vert_f32d1_flat_7[0], pvd.vert_f32d1_flat_7[1]), pvd.vert_f32d1_flat_7[2]), pvd.vert_f32d1_flat_7[3])));
    bool good_vert_f32d2_inter_7 = all(lessThanEqual(vert_f32d2_inter_7[gl_InvocationID], f32vec2(max(max(max(pvd.vert_f32d2_inter_7[0], pvd.vert_f32d2_inter_7[1]), pvd.vert_f32d2_inter_7[2]), pvd.vert_f32d2_inter_7[3])))) && all(greaterThanEqual(vert_f32d2_inter_7[gl_InvocationID], f32vec2(min(min(min(pvd.vert_f32d2_inter_7[0], pvd.vert_f32d2_inter_7[1]), pvd.vert_f32d2_inter_7[2]), pvd.vert_f32d2_inter_7[3]))));
    bool good_vert_f32d2_inter_4 = all(lessThanEqual(vert_f32d2_inter_4[gl_InvocationID], f32vec2(max(max(max(pvd.vert_f32d2_inter_4[0], pvd.vert_f32d2_inter_4[1]), pvd.vert_f32d2_inter_4[2]), pvd.vert_f32d2_inter_4[3])))) && all(greaterThanEqual(vert_f32d2_inter_4[gl_InvocationID], f32vec2(min(min(min(pvd.vert_f32d2_inter_4[0], pvd.vert_f32d2_inter_4[1]), pvd.vert_f32d2_inter_4[2]), pvd.vert_f32d2_inter_4[3]))));
    bool good_vert_f32d3_inter_5 = all(lessThanEqual(vert_f32d3_inter_5[gl_InvocationID], f32vec3(max(max(max(pvd.vert_f32d3_inter_5[0], pvd.vert_f32d3_inter_5[1]), pvd.vert_f32d3_inter_5[2]), pvd.vert_f32d3_inter_5[3])))) && all(greaterThanEqual(vert_f32d3_inter_5[gl_InvocationID], f32vec3(min(min(min(pvd.vert_f32d3_inter_5[0], pvd.vert_f32d3_inter_5[1]), pvd.vert_f32d3_inter_5[2]), pvd.vert_f32d3_inter_5[3]))));
    bool good_vert_i32d2_flat_3 = all(lessThanEqual(vert_i32d2_flat_3[gl_InvocationID], i32vec2(max(max(max(pvd.vert_i32d2_flat_3[0], pvd.vert_i32d2_flat_3[1]), pvd.vert_i32d2_flat_3[2]), pvd.vert_i32d2_flat_3[3])))) && all(greaterThanEqual(vert_i32d2_flat_3[gl_InvocationID], i32vec2(min(min(min(pvd.vert_i32d2_flat_3[0], pvd.vert_i32d2_flat_3[1]), pvd.vert_i32d2_flat_3[2]), pvd.vert_i32d2_flat_3[3]))));
    bool good_vert_f32d4_flat_5 = all(lessThanEqual(vert_f32d4_flat_5[gl_InvocationID], f32vec4(max(max(max(pvd.vert_f32d4_flat_5[0], pvd.vert_f32d4_flat_5[1]), pvd.vert_f32d4_flat_5[2]), pvd.vert_f32d4_flat_5[3])))) && all(greaterThanEqual(vert_f32d4_flat_5[gl_InvocationID], f32vec4(min(min(min(pvd.vert_f32d4_flat_5[0], pvd.vert_f32d4_flat_5[1]), pvd.vert_f32d4_flat_5[2]), pvd.vert_f32d4_flat_5[3]))));
    bool good_vert_f32d3_flat_1 = all(lessThanEqual(vert_f32d3_flat_1[gl_InvocationID], f32vec3(max(max(max(pvd.vert_f32d3_flat_1[0], pvd.vert_f32d3_flat_1[1]), pvd.vert_f32d3_flat_1[2]), pvd.vert_f32d3_flat_1[3])))) && all(greaterThanEqual(vert_f32d3_flat_1[gl_InvocationID], f32vec3(min(min(min(pvd.vert_f32d3_flat_1[0], pvd.vert_f32d3_flat_1[1]), pvd.vert_f32d3_flat_1[2]), pvd.vert_f32d3_flat_1[3]))));
    if (good_vert_f32d4_flat_0 && good_vert_f32d3_flat_7 && good_vert_i32d2_flat_1 && good_vert_f32d1_inter_0 && good_vert_f32d1_flat_2 && good_vert_f32d1_inter_8 && good_vert_i32d1_flat_8 && good_vert_f32d4_inter_8 && good_vert_f32d3_flat_0 && good_vert_f32d3_inter_1 && good_vert_f32d1_inter_6 && good_vert_f32d3_inter_3 && good_vert_f32d2_flat_3 && good_vert_i32d4_flat_1 && good_vert_f32d4_inter_7 && good_vert_i32d4_flat_4 && good_vert_f32d3_inter_7 && good_vert_f32d1_inter_7 && good_vert_i32d1_flat_7 && good_vert_f32d1_inter_4 && good_vert_f32d3_inter_9 && good_vert_f32d1_flat_7 && good_vert_f32d2_inter_7 && good_vert_f32d2_inter_4 && good_vert_f32d3_inter_5 && good_vert_i32d2_flat_3 && good_vert_f32d4_flat_5 && good_vert_f32d3_flat_1) {
        outColor[gl_InvocationID] = (gl_PrimitiveID == 0) ? vec4(0.0, 0.0, 1.0, 1.0) : vec4(1.0, 1.0, 0.0, 1.0);
    } else {
        outColor[gl_InvocationID] = vec4(0.0, 0.0, 0.0, 1.0);
    }
   gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
   gl_TessLevelOuter = float[4](1.0, 1.0, 1.0, 1.0);
   gl_TessLevelInner = float[2](1.0, 1.0);

}
