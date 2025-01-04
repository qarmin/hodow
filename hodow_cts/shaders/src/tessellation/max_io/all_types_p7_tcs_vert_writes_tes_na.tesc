#version 450
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_shader_explicit_arithmetic_types : enable

layout (vertices = 4) out;

layout (location=0) out flat i64vec3 vert_i64d3_flat_3[];
layout (location=2) out flat f16vec2 vert_f16d2_flat_1[];
layout (location=3) out flat int32_t vert_i32d1_flat_6[];
layout (location=4) out flat f16vec3 vert_f16d3_flat_0[];
layout (location=5) out flat f32vec3 vert_f32d3_flat_2[];
layout (location=6) out flat f16vec3 vert_f16d3_flat_3[];
layout (location=7) out float32_t vert_f32d1_inter_3[];
layout (location=8) out f32vec4 vert_f32d4_inter_3[];
layout (location=9) out flat int32_t vert_i32d1_flat_0[];
layout (location=10) out flat i64vec3 vert_i64d3_flat_4[];
layout (location=12) out flat i64vec2 vert_i64d2_flat_3[];
layout (location=13) out flat f16vec3 vert_f16d3_flat_7[];
layout (location=14) out flat f32vec3 vert_f32d3_flat_8[];
layout (location=15) out flat i16vec2 vert_i16d2_flat_0[];
layout (location=16) out flat f64vec2 vert_f64d2_flat_9[];
layout (location=17) out flat float64_t vert_f64d1_flat_2[];
layout (location=18) out flat float64_t vert_f64d1_flat_4[];
layout (location=19) out flat int32_t vert_i32d1_flat_3[];
layout (location=20) out flat i32vec2 vert_i32d2_flat_1[];
layout (location=21) out flat f64vec2 vert_f64d2_flat_1[];
layout (location=22) out f16vec4 vert_f16d4_inter_2[];
layout (location=23) out f32vec3 vert_f32d3_inter_4[];
layout (location=24) out float16_t vert_f16d1_inter_5[];
layout (location=25) out flat i64vec2 vert_i64d2_flat_9[];
layout (location=26) out f16vec4 vert_f16d4_inter_8[];
layout (location=27) out f32vec4 vert_f32d4_inter_2[];
layout (location=28) out f16vec3 vert_f16d3_inter_3[];

layout(set=0, binding=0, std430) readonly buffer PerVertexBlock {
    ivec3 vert_i64d3_flat_3[4];
    vec2 vert_f16d2_flat_1[4];
    int vert_i32d1_flat_6[4];
    vec3 vert_f16d3_flat_0[4];
    vec3 vert_f32d3_flat_2[4];
    vec3 vert_f16d3_flat_3[4];
    float vert_f32d1_inter_3[4];
    vec4 vert_f32d4_inter_3[4];
    int vert_i32d1_flat_0[4];
    ivec3 vert_i64d3_flat_4[4];
    ivec2 vert_i64d2_flat_3[4];
    vec3 vert_f16d3_flat_7[4];
    vec3 vert_f32d3_flat_8[4];
    ivec2 vert_i16d2_flat_0[4];
    vec2 vert_f64d2_flat_9[4];
    float vert_f64d1_flat_2[4];
    float vert_f64d1_flat_4[4];
    int vert_i32d1_flat_3[4];
    ivec2 vert_i32d2_flat_1[4];
    vec2 vert_f64d2_flat_1[4];
    vec4 vert_f16d4_inter_2[4];
    vec3 vert_f32d3_inter_4[4];
    float vert_f16d1_inter_5[4];
    ivec2 vert_i64d2_flat_9[4];
    vec4 vert_f16d4_inter_8[4];
    vec4 vert_f32d4_inter_2[4];
    vec3 vert_f16d3_inter_3[4];
 } pvd;

in gl_PerVertex {
    vec4  gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
} gl_out[];

void main ()
{
    vert_i64d3_flat_3[gl_InvocationID] = i64vec3(pvd.vert_i64d3_flat_3[gl_InvocationID]);
    vert_f16d2_flat_1[gl_InvocationID] = f16vec2(pvd.vert_f16d2_flat_1[gl_InvocationID]);
    vert_i32d1_flat_6[gl_InvocationID] = int32_t(pvd.vert_i32d1_flat_6[gl_InvocationID]);
    vert_f16d3_flat_0[gl_InvocationID] = f16vec3(pvd.vert_f16d3_flat_0[gl_InvocationID]);
    vert_f32d3_flat_2[gl_InvocationID] = f32vec3(pvd.vert_f32d3_flat_2[gl_InvocationID]);
    vert_f16d3_flat_3[gl_InvocationID] = f16vec3(pvd.vert_f16d3_flat_3[gl_InvocationID]);
    vert_f32d1_inter_3[gl_InvocationID] = float32_t(pvd.vert_f32d1_inter_3[gl_InvocationID]);
    vert_f32d4_inter_3[gl_InvocationID] = f32vec4(pvd.vert_f32d4_inter_3[gl_InvocationID]);
    vert_i32d1_flat_0[gl_InvocationID] = int32_t(pvd.vert_i32d1_flat_0[gl_InvocationID]);
    vert_i64d3_flat_4[gl_InvocationID] = i64vec3(pvd.vert_i64d3_flat_4[gl_InvocationID]);
    vert_i64d2_flat_3[gl_InvocationID] = i64vec2(pvd.vert_i64d2_flat_3[gl_InvocationID]);
    vert_f16d3_flat_7[gl_InvocationID] = f16vec3(pvd.vert_f16d3_flat_7[gl_InvocationID]);
    vert_f32d3_flat_8[gl_InvocationID] = f32vec3(pvd.vert_f32d3_flat_8[gl_InvocationID]);
    vert_i16d2_flat_0[gl_InvocationID] = i16vec2(pvd.vert_i16d2_flat_0[gl_InvocationID]);
    vert_f64d2_flat_9[gl_InvocationID] = f64vec2(pvd.vert_f64d2_flat_9[gl_InvocationID]);
    vert_f64d1_flat_2[gl_InvocationID] = float64_t(pvd.vert_f64d1_flat_2[gl_InvocationID]);
    vert_f64d1_flat_4[gl_InvocationID] = float64_t(pvd.vert_f64d1_flat_4[gl_InvocationID]);
    vert_i32d1_flat_3[gl_InvocationID] = int32_t(pvd.vert_i32d1_flat_3[gl_InvocationID]);
    vert_i32d2_flat_1[gl_InvocationID] = i32vec2(pvd.vert_i32d2_flat_1[gl_InvocationID]);
    vert_f64d2_flat_1[gl_InvocationID] = f64vec2(pvd.vert_f64d2_flat_1[gl_InvocationID]);
    vert_f16d4_inter_2[gl_InvocationID] = f16vec4(pvd.vert_f16d4_inter_2[gl_InvocationID]);
    vert_f32d3_inter_4[gl_InvocationID] = f32vec3(pvd.vert_f32d3_inter_4[gl_InvocationID]);
    vert_f16d1_inter_5[gl_InvocationID] = float16_t(pvd.vert_f16d1_inter_5[gl_InvocationID]);
    vert_i64d2_flat_9[gl_InvocationID] = i64vec2(pvd.vert_i64d2_flat_9[gl_InvocationID]);
    vert_f16d4_inter_8[gl_InvocationID] = f16vec4(pvd.vert_f16d4_inter_8[gl_InvocationID]);
    vert_f32d4_inter_2[gl_InvocationID] = f32vec4(pvd.vert_f32d4_inter_2[gl_InvocationID]);
    vert_f16d3_inter_3[gl_InvocationID] = f16vec3(pvd.vert_f16d3_inter_3[gl_InvocationID]);
   gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
   gl_TessLevelOuter = float[4](1.0, 1.0, 1.0, 1.0);
   gl_TessLevelInner = float[2](1.0, 1.0);

}
