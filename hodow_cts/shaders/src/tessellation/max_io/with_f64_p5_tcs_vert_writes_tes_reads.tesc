#version 450
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_shader_explicit_arithmetic_types : enable

layout (vertices = 4) out;

layout (location=0) out flat f64vec2 vert_f64d2_flat_7[];
layout (location=1) out flat f32vec4 vert_f32d4_flat_4[];
layout (location=2) out float32_t vert_f32d1_inter_4[];
layout (location=3) out flat i32vec2 vert_i32d2_flat_5[];
layout (location=4) out flat float32_t vert_f32d1_flat_3[];
layout (location=5) out flat i32vec2 vert_i32d2_flat_4[];
layout (location=6) out f32vec2 vert_f32d2_inter_7[];
layout (location=7) out flat float64_t vert_f64d1_flat_7[];
layout (location=8) out flat f32vec3 vert_f32d3_flat_0[];
layout (location=9) out flat f32vec3 vert_f32d3_flat_1[];
layout (location=10) out flat f64vec3 vert_f64d3_flat_2[];
layout (location=12) out f32vec4 vert_f32d4_inter_4[];
layout (location=13) out flat i32vec2 vert_i32d2_flat_3[];
layout (location=14) out flat f64vec3 vert_f64d3_flat_9[];
layout (location=16) out f32vec4 vert_f32d4_inter_7[];
layout (location=17) out flat f64vec2 vert_f64d2_flat_1[];
layout (location=18) out flat i32vec2 vert_i32d2_flat_6[];
layout (location=19) out flat f64vec2 vert_f64d2_flat_0[];
layout (location=20) out flat i32vec3 vert_i32d3_flat_7[];
layout (location=21) out flat i32vec3 vert_i32d3_flat_4[];
layout (location=22) out flat float64_t vert_f64d1_flat_5[];
layout (location=23) out flat i32vec2 vert_i32d2_flat_2[];
layout (location=24) out f32vec3 vert_f32d3_inter_3[];
layout (location=25) out flat f32vec3 vert_f32d3_flat_6[];
layout (location=26) out f32vec3 vert_f32d3_inter_1[];
layout (location=27) out flat f32vec2 vert_f32d2_flat_1[];
layout (location=28) out flat i32vec4 vert_i32d4_flat_4[];

layout(set=0, binding=0, std430) readonly buffer PerVertexBlock {
    vec2 vert_f64d2_flat_7[4];
    vec4 vert_f32d4_flat_4[4];
    float vert_f32d1_inter_4[4];
    ivec2 vert_i32d2_flat_5[4];
    float vert_f32d1_flat_3[4];
    ivec2 vert_i32d2_flat_4[4];
    vec2 vert_f32d2_inter_7[4];
    float vert_f64d1_flat_7[4];
    vec3 vert_f32d3_flat_0[4];
    vec3 vert_f32d3_flat_1[4];
    vec3 vert_f64d3_flat_2[4];
    vec4 vert_f32d4_inter_4[4];
    ivec2 vert_i32d2_flat_3[4];
    vec3 vert_f64d3_flat_9[4];
    vec4 vert_f32d4_inter_7[4];
    vec2 vert_f64d2_flat_1[4];
    ivec2 vert_i32d2_flat_6[4];
    vec2 vert_f64d2_flat_0[4];
    ivec3 vert_i32d3_flat_7[4];
    ivec3 vert_i32d3_flat_4[4];
    float vert_f64d1_flat_5[4];
    ivec2 vert_i32d2_flat_2[4];
    vec3 vert_f32d3_inter_3[4];
    vec3 vert_f32d3_flat_6[4];
    vec3 vert_f32d3_inter_1[4];
    vec2 vert_f32d2_flat_1[4];
    ivec4 vert_i32d4_flat_4[4];
 } pvd;

in gl_PerVertex {
    vec4  gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
} gl_out[];

void main ()
{
    vert_f64d2_flat_7[gl_InvocationID] = f64vec2(pvd.vert_f64d2_flat_7[gl_InvocationID]);
    vert_f32d4_flat_4[gl_InvocationID] = f32vec4(pvd.vert_f32d4_flat_4[gl_InvocationID]);
    vert_f32d1_inter_4[gl_InvocationID] = float32_t(pvd.vert_f32d1_inter_4[gl_InvocationID]);
    vert_i32d2_flat_5[gl_InvocationID] = i32vec2(pvd.vert_i32d2_flat_5[gl_InvocationID]);
    vert_f32d1_flat_3[gl_InvocationID] = float32_t(pvd.vert_f32d1_flat_3[gl_InvocationID]);
    vert_i32d2_flat_4[gl_InvocationID] = i32vec2(pvd.vert_i32d2_flat_4[gl_InvocationID]);
    vert_f32d2_inter_7[gl_InvocationID] = f32vec2(pvd.vert_f32d2_inter_7[gl_InvocationID]);
    vert_f64d1_flat_7[gl_InvocationID] = float64_t(pvd.vert_f64d1_flat_7[gl_InvocationID]);
    vert_f32d3_flat_0[gl_InvocationID] = f32vec3(pvd.vert_f32d3_flat_0[gl_InvocationID]);
    vert_f32d3_flat_1[gl_InvocationID] = f32vec3(pvd.vert_f32d3_flat_1[gl_InvocationID]);
    vert_f64d3_flat_2[gl_InvocationID] = f64vec3(pvd.vert_f64d3_flat_2[gl_InvocationID]);
    vert_f32d4_inter_4[gl_InvocationID] = f32vec4(pvd.vert_f32d4_inter_4[gl_InvocationID]);
    vert_i32d2_flat_3[gl_InvocationID] = i32vec2(pvd.vert_i32d2_flat_3[gl_InvocationID]);
    vert_f64d3_flat_9[gl_InvocationID] = f64vec3(pvd.vert_f64d3_flat_9[gl_InvocationID]);
    vert_f32d4_inter_7[gl_InvocationID] = f32vec4(pvd.vert_f32d4_inter_7[gl_InvocationID]);
    vert_f64d2_flat_1[gl_InvocationID] = f64vec2(pvd.vert_f64d2_flat_1[gl_InvocationID]);
    vert_i32d2_flat_6[gl_InvocationID] = i32vec2(pvd.vert_i32d2_flat_6[gl_InvocationID]);
    vert_f64d2_flat_0[gl_InvocationID] = f64vec2(pvd.vert_f64d2_flat_0[gl_InvocationID]);
    vert_i32d3_flat_7[gl_InvocationID] = i32vec3(pvd.vert_i32d3_flat_7[gl_InvocationID]);
    vert_i32d3_flat_4[gl_InvocationID] = i32vec3(pvd.vert_i32d3_flat_4[gl_InvocationID]);
    vert_f64d1_flat_5[gl_InvocationID] = float64_t(pvd.vert_f64d1_flat_5[gl_InvocationID]);
    vert_i32d2_flat_2[gl_InvocationID] = i32vec2(pvd.vert_i32d2_flat_2[gl_InvocationID]);
    vert_f32d3_inter_3[gl_InvocationID] = f32vec3(pvd.vert_f32d3_inter_3[gl_InvocationID]);
    vert_f32d3_flat_6[gl_InvocationID] = f32vec3(pvd.vert_f32d3_flat_6[gl_InvocationID]);
    vert_f32d3_inter_1[gl_InvocationID] = f32vec3(pvd.vert_f32d3_inter_1[gl_InvocationID]);
    vert_f32d2_flat_1[gl_InvocationID] = f32vec2(pvd.vert_f32d2_flat_1[gl_InvocationID]);
    vert_i32d4_flat_4[gl_InvocationID] = i32vec4(pvd.vert_i32d4_flat_4[gl_InvocationID]);
   gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
   gl_TessLevelOuter = float[4](1.0, 1.0, 1.0, 1.0);
   gl_TessLevelInner = float[2](1.0, 1.0);

}
