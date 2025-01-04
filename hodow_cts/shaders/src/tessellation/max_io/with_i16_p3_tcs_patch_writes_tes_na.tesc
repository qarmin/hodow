#version 450
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_shader_explicit_arithmetic_types : enable

layout (vertices = 4) out;

layout (location=0) out patch f32vec2 patch_f32d2_inter_5;
layout (location=1) out patch f32vec4 patch_f32d4_inter_1;
layout (location=2) out patch f32vec3 patch_f32d3_inter_8;
layout (location=3) out patch float32_t patch_f32d1_inter_9;
layout (location=4) out patch float32_t patch_f32d1_inter_1;
layout (location=5) out patch f32vec4 patch_f32d4_inter_3;
layout (location=6) out patch f32vec3 patch_f32d3_inter_6;
layout (location=7) out patch f32vec4 patch_f32d4_inter_2;
layout (location=8) out patch f32vec4 patch_f32d4_inter_0;
layout (location=9) out patch f32vec4 patch_f32d4_inter_8;
layout (location=10) out patch f32vec2 patch_f32d2_inter_1;
layout (location=11) out patch f32vec2 patch_f32d2_inter_8;
layout (location=12) out patch float32_t patch_f32d1_inter_0;
layout (location=13) out patch float32_t patch_f32d1_inter_6;
layout (location=14) out patch float32_t patch_f32d1_inter_7;
layout (location=15) out patch f32vec3 patch_f32d3_inter_1;
layout (location=16) out patch f32vec4 patch_f32d4_inter_9;
layout (location=17) out patch f32vec2 patch_f32d2_inter_6;
layout (location=18) out patch float32_t patch_f32d1_inter_2;
layout (location=19) out patch float32_t patch_f32d1_inter_4;
layout (location=20) out patch f32vec2 patch_f32d2_inter_7;
layout (location=21) out patch float32_t patch_f32d1_inter_5;
layout (location=22) out patch f32vec3 patch_f32d3_inter_3;
layout (location=23) out patch f32vec2 patch_f32d2_inter_3;
layout (location=24) out patch float32_t patch_f32d1_inter_8;
layout (location=25) out patch f32vec3 patch_f32d3_inter_0;

layout(set=0, binding=0, std430) readonly buffer PerPatchBlock {
    vec2 patch_f32d2_inter_5[2];
    vec4 patch_f32d4_inter_1[2];
    vec3 patch_f32d3_inter_8[2];
    float patch_f32d1_inter_9[2];
    float patch_f32d1_inter_1[2];
    vec4 patch_f32d4_inter_3[2];
    vec3 patch_f32d3_inter_6[2];
    vec4 patch_f32d4_inter_2[2];
    vec4 patch_f32d4_inter_0[2];
    vec4 patch_f32d4_inter_8[2];
    vec2 patch_f32d2_inter_1[2];
    vec2 patch_f32d2_inter_8[2];
    float patch_f32d1_inter_0[2];
    float patch_f32d1_inter_6[2];
    float patch_f32d1_inter_7[2];
    vec3 patch_f32d3_inter_1[2];
    vec4 patch_f32d4_inter_9[2];
    vec2 patch_f32d2_inter_6[2];
    float patch_f32d1_inter_2[2];
    float patch_f32d1_inter_4[2];
    vec2 patch_f32d2_inter_7[2];
    float patch_f32d1_inter_5[2];
    vec3 patch_f32d3_inter_3[2];
    vec2 patch_f32d2_inter_3[2];
    float patch_f32d1_inter_8[2];
    vec3 patch_f32d3_inter_0[2];
 } ppd;

in gl_PerVertex {
    vec4  gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
} gl_out[];

void main ()
{
    patch_f32d2_inter_5 = f32vec2(ppd.patch_f32d2_inter_5[gl_PrimitiveID]);
    patch_f32d4_inter_1 = f32vec4(ppd.patch_f32d4_inter_1[gl_PrimitiveID]);
    patch_f32d3_inter_8 = f32vec3(ppd.patch_f32d3_inter_8[gl_PrimitiveID]);
    patch_f32d1_inter_9 = float32_t(ppd.patch_f32d1_inter_9[gl_PrimitiveID]);
    patch_f32d1_inter_1 = float32_t(ppd.patch_f32d1_inter_1[gl_PrimitiveID]);
    patch_f32d4_inter_3 = f32vec4(ppd.patch_f32d4_inter_3[gl_PrimitiveID]);
    patch_f32d3_inter_6 = f32vec3(ppd.patch_f32d3_inter_6[gl_PrimitiveID]);
    patch_f32d4_inter_2 = f32vec4(ppd.patch_f32d4_inter_2[gl_PrimitiveID]);
    patch_f32d4_inter_0 = f32vec4(ppd.patch_f32d4_inter_0[gl_PrimitiveID]);
    patch_f32d4_inter_8 = f32vec4(ppd.patch_f32d4_inter_8[gl_PrimitiveID]);
    patch_f32d2_inter_1 = f32vec2(ppd.patch_f32d2_inter_1[gl_PrimitiveID]);
    patch_f32d2_inter_8 = f32vec2(ppd.patch_f32d2_inter_8[gl_PrimitiveID]);
    patch_f32d1_inter_0 = float32_t(ppd.patch_f32d1_inter_0[gl_PrimitiveID]);
    patch_f32d1_inter_6 = float32_t(ppd.patch_f32d1_inter_6[gl_PrimitiveID]);
    patch_f32d1_inter_7 = float32_t(ppd.patch_f32d1_inter_7[gl_PrimitiveID]);
    patch_f32d3_inter_1 = f32vec3(ppd.patch_f32d3_inter_1[gl_PrimitiveID]);
    patch_f32d4_inter_9 = f32vec4(ppd.patch_f32d4_inter_9[gl_PrimitiveID]);
    patch_f32d2_inter_6 = f32vec2(ppd.patch_f32d2_inter_6[gl_PrimitiveID]);
    patch_f32d1_inter_2 = float32_t(ppd.patch_f32d1_inter_2[gl_PrimitiveID]);
    patch_f32d1_inter_4 = float32_t(ppd.patch_f32d1_inter_4[gl_PrimitiveID]);
    patch_f32d2_inter_7 = f32vec2(ppd.patch_f32d2_inter_7[gl_PrimitiveID]);
    patch_f32d1_inter_5 = float32_t(ppd.patch_f32d1_inter_5[gl_PrimitiveID]);
    patch_f32d3_inter_3 = f32vec3(ppd.patch_f32d3_inter_3[gl_PrimitiveID]);
    patch_f32d2_inter_3 = f32vec2(ppd.patch_f32d2_inter_3[gl_PrimitiveID]);
    patch_f32d1_inter_8 = float32_t(ppd.patch_f32d1_inter_8[gl_PrimitiveID]);
    patch_f32d3_inter_0 = f32vec3(ppd.patch_f32d3_inter_0[gl_PrimitiveID]);
   gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
   gl_TessLevelOuter = float[4](1.0, 1.0, 1.0, 1.0);
   gl_TessLevelInner = float[2](1.0, 1.0);

}
