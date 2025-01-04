#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(quads, equal_spacing) in;

layout(set=0, binding=0, std430) readonly buffer PerPatchBlock {
    vec4 patch_f32d4_inter_8[2];
    vec4 patch_f32d4_inter_2[2];
    vec3 patch_f32d3_inter_3[2];
    vec3 patch_f32d3_inter_6[2];
    vec3 patch_f32d3_inter_0[2];
    vec2 patch_f32d2_inter_4[2];
    float patch_f32d1_inter_3[2];
    vec3 patch_f32d3_inter_7[2];
    vec3 patch_f32d3_inter_9[2];
    vec3 patch_f32d3_inter_1[2];
    vec4 patch_f32d4_inter_4[2];
    vec4 patch_f32d4_inter_9[2];
    float patch_f32d1_inter_7[2];
    vec2 patch_f32d2_inter_3[2];
    vec3 patch_f32d3_inter_2[2];
    vec2 patch_f32d2_inter_8[2];
    vec2 patch_f32d2_inter_6[2];
    vec4 patch_f32d4_inter_3[2];
    vec2 patch_f32d2_inter_1[2];
    float patch_f32d1_inter_2[2];
    vec2 patch_f32d2_inter_5[2];
    float patch_f32d1_inter_4[2];
    float patch_f32d1_inter_6[2];
    vec4 patch_f32d4_inter_6[2];
    vec2 patch_f32d2_inter_2[2];
    float patch_f32d1_inter_5[2];
 } ppd;

layout (location=0) in vec4 inColor[];


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
    INTERP_QUAD_VAR(vec4, var_color, inColor[i], outColor);
    INTERP_QUAD_VAR(vec4, var_gl_pos, gl_in[i].gl_Position, gl_Position);
}
