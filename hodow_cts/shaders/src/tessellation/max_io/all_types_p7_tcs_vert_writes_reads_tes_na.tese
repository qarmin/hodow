#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(quads, equal_spacing) in;

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
 } pvd;

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
