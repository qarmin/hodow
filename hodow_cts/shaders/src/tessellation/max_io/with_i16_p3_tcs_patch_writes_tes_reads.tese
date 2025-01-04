#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(quads, equal_spacing) in;

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

layout (location=0) in patch f32vec2 patch_f32d2_inter_5;
layout (location=1) in patch f32vec4 patch_f32d4_inter_1;
layout (location=2) in patch f32vec3 patch_f32d3_inter_8;
layout (location=3) in patch float32_t patch_f32d1_inter_9;
layout (location=4) in patch float32_t patch_f32d1_inter_1;
layout (location=5) in patch f32vec4 patch_f32d4_inter_3;
layout (location=6) in patch f32vec3 patch_f32d3_inter_6;
layout (location=7) in patch f32vec4 patch_f32d4_inter_2;
layout (location=8) in patch f32vec4 patch_f32d4_inter_0;
layout (location=9) in patch f32vec4 patch_f32d4_inter_8;
layout (location=10) in patch f32vec2 patch_f32d2_inter_1;
layout (location=11) in patch f32vec2 patch_f32d2_inter_8;
layout (location=12) in patch float32_t patch_f32d1_inter_0;
layout (location=13) in patch float32_t patch_f32d1_inter_6;
layout (location=14) in patch float32_t patch_f32d1_inter_7;
layout (location=15) in patch f32vec3 patch_f32d3_inter_1;
layout (location=16) in patch f32vec4 patch_f32d4_inter_9;
layout (location=17) in patch f32vec2 patch_f32d2_inter_6;
layout (location=18) in patch float32_t patch_f32d1_inter_2;
layout (location=19) in patch float32_t patch_f32d1_inter_4;
layout (location=20) in patch f32vec2 patch_f32d2_inter_7;
layout (location=21) in patch float32_t patch_f32d1_inter_5;
layout (location=22) in patch f32vec3 patch_f32d3_inter_3;
layout (location=23) in patch f32vec2 patch_f32d2_inter_3;
layout (location=24) in patch float32_t patch_f32d1_inter_8;
layout (location=25) in patch f32vec3 patch_f32d3_inter_0;

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
    bool good_patch_f32d2_inter_5 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d2_inter_5 == ppd.patch_f32d2_inter_5[0]) || (gl_PrimitiveID == 1 && patch_f32d2_inter_5 == ppd.patch_f32d2_inter_5[1])));
    bool good_patch_f32d4_inter_1 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d4_inter_1 == ppd.patch_f32d4_inter_1[0]) || (gl_PrimitiveID == 1 && patch_f32d4_inter_1 == ppd.patch_f32d4_inter_1[1])));
    bool good_patch_f32d3_inter_8 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d3_inter_8 == ppd.patch_f32d3_inter_8[0]) || (gl_PrimitiveID == 1 && patch_f32d3_inter_8 == ppd.patch_f32d3_inter_8[1])));
    bool good_patch_f32d1_inter_9 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d1_inter_9 == ppd.patch_f32d1_inter_9[0]) || (gl_PrimitiveID == 1 && patch_f32d1_inter_9 == ppd.patch_f32d1_inter_9[1])));
    bool good_patch_f32d1_inter_1 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d1_inter_1 == ppd.patch_f32d1_inter_1[0]) || (gl_PrimitiveID == 1 && patch_f32d1_inter_1 == ppd.patch_f32d1_inter_1[1])));
    bool good_patch_f32d4_inter_3 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d4_inter_3 == ppd.patch_f32d4_inter_3[0]) || (gl_PrimitiveID == 1 && patch_f32d4_inter_3 == ppd.patch_f32d4_inter_3[1])));
    bool good_patch_f32d3_inter_6 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d3_inter_6 == ppd.patch_f32d3_inter_6[0]) || (gl_PrimitiveID == 1 && patch_f32d3_inter_6 == ppd.patch_f32d3_inter_6[1])));
    bool good_patch_f32d4_inter_2 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d4_inter_2 == ppd.patch_f32d4_inter_2[0]) || (gl_PrimitiveID == 1 && patch_f32d4_inter_2 == ppd.patch_f32d4_inter_2[1])));
    bool good_patch_f32d4_inter_0 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d4_inter_0 == ppd.patch_f32d4_inter_0[0]) || (gl_PrimitiveID == 1 && patch_f32d4_inter_0 == ppd.patch_f32d4_inter_0[1])));
    bool good_patch_f32d4_inter_8 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d4_inter_8 == ppd.patch_f32d4_inter_8[0]) || (gl_PrimitiveID == 1 && patch_f32d4_inter_8 == ppd.patch_f32d4_inter_8[1])));
    bool good_patch_f32d2_inter_1 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d2_inter_1 == ppd.patch_f32d2_inter_1[0]) || (gl_PrimitiveID == 1 && patch_f32d2_inter_1 == ppd.patch_f32d2_inter_1[1])));
    bool good_patch_f32d2_inter_8 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d2_inter_8 == ppd.patch_f32d2_inter_8[0]) || (gl_PrimitiveID == 1 && patch_f32d2_inter_8 == ppd.patch_f32d2_inter_8[1])));
    bool good_patch_f32d1_inter_0 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d1_inter_0 == ppd.patch_f32d1_inter_0[0]) || (gl_PrimitiveID == 1 && patch_f32d1_inter_0 == ppd.patch_f32d1_inter_0[1])));
    bool good_patch_f32d1_inter_6 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d1_inter_6 == ppd.patch_f32d1_inter_6[0]) || (gl_PrimitiveID == 1 && patch_f32d1_inter_6 == ppd.patch_f32d1_inter_6[1])));
    bool good_patch_f32d1_inter_7 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d1_inter_7 == ppd.patch_f32d1_inter_7[0]) || (gl_PrimitiveID == 1 && patch_f32d1_inter_7 == ppd.patch_f32d1_inter_7[1])));
    bool good_patch_f32d3_inter_1 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d3_inter_1 == ppd.patch_f32d3_inter_1[0]) || (gl_PrimitiveID == 1 && patch_f32d3_inter_1 == ppd.patch_f32d3_inter_1[1])));
    bool good_patch_f32d4_inter_9 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d4_inter_9 == ppd.patch_f32d4_inter_9[0]) || (gl_PrimitiveID == 1 && patch_f32d4_inter_9 == ppd.patch_f32d4_inter_9[1])));
    bool good_patch_f32d2_inter_6 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d2_inter_6 == ppd.patch_f32d2_inter_6[0]) || (gl_PrimitiveID == 1 && patch_f32d2_inter_6 == ppd.patch_f32d2_inter_6[1])));
    bool good_patch_f32d1_inter_2 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d1_inter_2 == ppd.patch_f32d1_inter_2[0]) || (gl_PrimitiveID == 1 && patch_f32d1_inter_2 == ppd.patch_f32d1_inter_2[1])));
    bool good_patch_f32d1_inter_4 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d1_inter_4 == ppd.patch_f32d1_inter_4[0]) || (gl_PrimitiveID == 1 && patch_f32d1_inter_4 == ppd.patch_f32d1_inter_4[1])));
    bool good_patch_f32d2_inter_7 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d2_inter_7 == ppd.patch_f32d2_inter_7[0]) || (gl_PrimitiveID == 1 && patch_f32d2_inter_7 == ppd.patch_f32d2_inter_7[1])));
    bool good_patch_f32d1_inter_5 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d1_inter_5 == ppd.patch_f32d1_inter_5[0]) || (gl_PrimitiveID == 1 && patch_f32d1_inter_5 == ppd.patch_f32d1_inter_5[1])));
    bool good_patch_f32d3_inter_3 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d3_inter_3 == ppd.patch_f32d3_inter_3[0]) || (gl_PrimitiveID == 1 && patch_f32d3_inter_3 == ppd.patch_f32d3_inter_3[1])));
    bool good_patch_f32d2_inter_3 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d2_inter_3 == ppd.patch_f32d2_inter_3[0]) || (gl_PrimitiveID == 1 && patch_f32d2_inter_3 == ppd.patch_f32d2_inter_3[1])));
    bool good_patch_f32d1_inter_8 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d1_inter_8 == ppd.patch_f32d1_inter_8[0]) || (gl_PrimitiveID == 1 && patch_f32d1_inter_8 == ppd.patch_f32d1_inter_8[1])));
    bool good_patch_f32d3_inter_0 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d3_inter_0 == ppd.patch_f32d3_inter_0[0]) || (gl_PrimitiveID == 1 && patch_f32d3_inter_0 == ppd.patch_f32d3_inter_0[1])));
    if (good_patch_f32d2_inter_5 && good_patch_f32d4_inter_1 && good_patch_f32d3_inter_8 && good_patch_f32d1_inter_9 && good_patch_f32d1_inter_1 && good_patch_f32d4_inter_3 && good_patch_f32d3_inter_6 && good_patch_f32d4_inter_2 && good_patch_f32d4_inter_0 && good_patch_f32d4_inter_8 && good_patch_f32d2_inter_1 && good_patch_f32d2_inter_8 && good_patch_f32d1_inter_0 && good_patch_f32d1_inter_6 && good_patch_f32d1_inter_7 && good_patch_f32d3_inter_1 && good_patch_f32d4_inter_9 && good_patch_f32d2_inter_6 && good_patch_f32d1_inter_2 && good_patch_f32d1_inter_4 && good_patch_f32d2_inter_7 && good_patch_f32d1_inter_5 && good_patch_f32d3_inter_3 && good_patch_f32d2_inter_3 && good_patch_f32d1_inter_8 && good_patch_f32d3_inter_0) {
        outColor = (gl_PrimitiveID == 0) ? vec4(0.0, 0.0, 1.0, 1.0) : vec4(1.0, 1.0, 0.0, 1.0);
    } else {
        outColor = vec4(0.0, 0.0, 0.0, 1.0);
    }
    INTERP_QUAD_VAR(vec4, var_gl_pos, gl_in[i].gl_Position, gl_Position);
}
