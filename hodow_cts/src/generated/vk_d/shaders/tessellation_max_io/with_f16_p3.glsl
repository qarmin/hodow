#version 450
vec4 positions[8] = vec4[](
    vec4(-1.0, -1.0, 0.0, 1.0),
    vec4( 1.0, -1.0, 0.0, 1.0),
    vec4(-1.0,  1.0, 0.0, 1.0),
    vec4( 1.0,  1.0, 0.0, 1.0),
    vec4(-0.5, -0.5, 0.0, 1.0),
    vec4( 0.5, -0.5, 0.0, 1.0),
    vec4(-0.5,  0.5, 0.0, 1.0),
    vec4( 0.5,  0.5, 0.0, 1.0)
);
out gl_PerVertex {
    vec4 gl_Position;
};
void main (void)
{
    gl_Position = positions[gl_VertexIndex];
}
#version 450
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_shader_explicit_arithmetic_types : enable

layout (vertices = 4) out;

layout (location=0) out flat f32vec4 vert_f32d4_flat_2[];
layout (location=1) out flat i32vec4 vert_i32d4_flat_6[];
layout (location=2) out flat f16vec2 vert_f16d2_flat_2[];
layout (location=3) out float16_t vert_f16d1_inter_1[];
layout (location=4) out flat float16_t vert_f16d1_flat_0[];
layout (location=5) out flat float16_t vert_f16d1_flat_5[];
layout (location=6) out flat f32vec4 vert_f32d4_flat_1[];
layout (location=7) out f32vec3 vert_f32d3_inter_8[];
layout (location=8) out float32_t vert_f32d1_inter_1[];
layout (location=9) out flat f16vec4 vert_f16d4_flat_0[];
layout (location=10) out f32vec3 vert_f32d3_inter_0[];
layout (location=11) out flat i32vec2 vert_i32d2_flat_0[];
layout (location=12) out flat i32vec2 vert_i32d2_flat_3[];
layout (location=13) out f16vec2 vert_f16d2_inter_5[];
layout (location=14) out float16_t vert_f16d1_inter_6[];
layout (location=15) out flat int32_t vert_i32d1_flat_0[];
layout (location=16) out float16_t vert_f16d1_inter_2[];
layout (location=17) out flat float16_t vert_f16d1_flat_9[];
layout (location=18) out flat float16_t vert_f16d1_flat_8[];
layout (location=19) out f32vec2 vert_f32d2_inter_4[];
layout (location=20) out flat i32vec3 vert_i32d3_flat_7[];
layout (location=21) out flat f32vec2 vert_f32d2_flat_0[];
layout (location=22) out f32vec3 vert_f32d3_inter_1[];
layout (location=23) out flat i32vec3 vert_i32d3_flat_0[];
layout (location=24) out flat f32vec3 vert_f32d3_flat_4[];
layout (location=25) out flat f16vec4 vert_f16d4_flat_4[];
layout (location=26) out flat int32_t vert_i32d1_flat_3[];
layout (location=27) out f16vec2 vert_f16d2_inter_8[];
layout (location=28) out flat f16vec2 vert_f16d2_flat_8[];

layout(set=0, binding=0, std430) readonly buffer PerVertexBlock {
    vec4 vert_f32d4_flat_2[4];
    ivec4 vert_i32d4_flat_6[4];
    vec2 vert_f16d2_flat_2[4];
    float vert_f16d1_inter_1[4];
    float vert_f16d1_flat_0[4];
    float vert_f16d1_flat_5[4];
    vec4 vert_f32d4_flat_1[4];
    vec3 vert_f32d3_inter_8[4];
    float vert_f32d1_inter_1[4];
    vec4 vert_f16d4_flat_0[4];
    vec3 vert_f32d3_inter_0[4];
    ivec2 vert_i32d2_flat_0[4];
    ivec2 vert_i32d2_flat_3[4];
    vec2 vert_f16d2_inter_5[4];
    float vert_f16d1_inter_6[4];
    int vert_i32d1_flat_0[4];
    float vert_f16d1_inter_2[4];
    float vert_f16d1_flat_9[4];
    float vert_f16d1_flat_8[4];
    vec2 vert_f32d2_inter_4[4];
    ivec3 vert_i32d3_flat_7[4];
    vec2 vert_f32d2_flat_0[4];
    vec3 vert_f32d3_inter_1[4];
    ivec3 vert_i32d3_flat_0[4];
    vec3 vert_f32d3_flat_4[4];
    vec4 vert_f16d4_flat_4[4];
    int vert_i32d1_flat_3[4];
    vec2 vert_f16d2_inter_8[4];
    vec2 vert_f16d2_flat_8[4];
 } pvd;

in gl_PerVertex {
    vec4  gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
} gl_out[];

void main ()
{
    vert_f32d4_flat_2[gl_InvocationID] = f32vec4(pvd.vert_f32d4_flat_2[gl_InvocationID]);
    vert_i32d4_flat_6[gl_InvocationID] = i32vec4(pvd.vert_i32d4_flat_6[gl_InvocationID]);
    vert_f16d2_flat_2[gl_InvocationID] = f16vec2(pvd.vert_f16d2_flat_2[gl_InvocationID]);
    vert_f16d1_inter_1[gl_InvocationID] = float16_t(pvd.vert_f16d1_inter_1[gl_InvocationID]);
    vert_f16d1_flat_0[gl_InvocationID] = float16_t(pvd.vert_f16d1_flat_0[gl_InvocationID]);
    vert_f16d1_flat_5[gl_InvocationID] = float16_t(pvd.vert_f16d1_flat_5[gl_InvocationID]);
    vert_f32d4_flat_1[gl_InvocationID] = f32vec4(pvd.vert_f32d4_flat_1[gl_InvocationID]);
    vert_f32d3_inter_8[gl_InvocationID] = f32vec3(pvd.vert_f32d3_inter_8[gl_InvocationID]);
    vert_f32d1_inter_1[gl_InvocationID] = float32_t(pvd.vert_f32d1_inter_1[gl_InvocationID]);
    vert_f16d4_flat_0[gl_InvocationID] = f16vec4(pvd.vert_f16d4_flat_0[gl_InvocationID]);
    vert_f32d3_inter_0[gl_InvocationID] = f32vec3(pvd.vert_f32d3_inter_0[gl_InvocationID]);
    vert_i32d2_flat_0[gl_InvocationID] = i32vec2(pvd.vert_i32d2_flat_0[gl_InvocationID]);
    vert_i32d2_flat_3[gl_InvocationID] = i32vec2(pvd.vert_i32d2_flat_3[gl_InvocationID]);
    vert_f16d2_inter_5[gl_InvocationID] = f16vec2(pvd.vert_f16d2_inter_5[gl_InvocationID]);
    vert_f16d1_inter_6[gl_InvocationID] = float16_t(pvd.vert_f16d1_inter_6[gl_InvocationID]);
    vert_i32d1_flat_0[gl_InvocationID] = int32_t(pvd.vert_i32d1_flat_0[gl_InvocationID]);
    vert_f16d1_inter_2[gl_InvocationID] = float16_t(pvd.vert_f16d1_inter_2[gl_InvocationID]);
    vert_f16d1_flat_9[gl_InvocationID] = float16_t(pvd.vert_f16d1_flat_9[gl_InvocationID]);
    vert_f16d1_flat_8[gl_InvocationID] = float16_t(pvd.vert_f16d1_flat_8[gl_InvocationID]);
    vert_f32d2_inter_4[gl_InvocationID] = f32vec2(pvd.vert_f32d2_inter_4[gl_InvocationID]);
    vert_i32d3_flat_7[gl_InvocationID] = i32vec3(pvd.vert_i32d3_flat_7[gl_InvocationID]);
    vert_f32d2_flat_0[gl_InvocationID] = f32vec2(pvd.vert_f32d2_flat_0[gl_InvocationID]);
    vert_f32d3_inter_1[gl_InvocationID] = f32vec3(pvd.vert_f32d3_inter_1[gl_InvocationID]);
    vert_i32d3_flat_0[gl_InvocationID] = i32vec3(pvd.vert_i32d3_flat_0[gl_InvocationID]);
    vert_f32d3_flat_4[gl_InvocationID] = f32vec3(pvd.vert_f32d3_flat_4[gl_InvocationID]);
    vert_f16d4_flat_4[gl_InvocationID] = f16vec4(pvd.vert_f16d4_flat_4[gl_InvocationID]);
    vert_i32d1_flat_3[gl_InvocationID] = int32_t(pvd.vert_i32d1_flat_3[gl_InvocationID]);
    vert_f16d2_inter_8[gl_InvocationID] = f16vec2(pvd.vert_f16d2_inter_8[gl_InvocationID]);
    vert_f16d2_flat_8[gl_InvocationID] = f16vec2(pvd.vert_f16d2_flat_8[gl_InvocationID]);
   gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
   gl_TessLevelOuter = float[4](1.0, 1.0, 1.0, 1.0);
   gl_TessLevelInner = float[2](1.0, 1.0);

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(quads, equal_spacing) in;

layout(set=0, binding=0, std430) readonly buffer PerVertexBlock {
    vec4 vert_f32d4_flat_2[4];
    ivec4 vert_i32d4_flat_6[4];
    vec2 vert_f16d2_flat_2[4];
    float vert_f16d1_inter_1[4];
    float vert_f16d1_flat_0[4];
    float vert_f16d1_flat_5[4];
    vec4 vert_f32d4_flat_1[4];
    vec3 vert_f32d3_inter_8[4];
    float vert_f32d1_inter_1[4];
    vec4 vert_f16d4_flat_0[4];
    vec3 vert_f32d3_inter_0[4];
    ivec2 vert_i32d2_flat_0[4];
    ivec2 vert_i32d2_flat_3[4];
    vec2 vert_f16d2_inter_5[4];
    float vert_f16d1_inter_6[4];
    int vert_i32d1_flat_0[4];
    float vert_f16d1_inter_2[4];
    float vert_f16d1_flat_9[4];
    float vert_f16d1_flat_8[4];
    vec2 vert_f32d2_inter_4[4];
    ivec3 vert_i32d3_flat_7[4];
    vec2 vert_f32d2_flat_0[4];
    vec3 vert_f32d3_inter_1[4];
    ivec3 vert_i32d3_flat_0[4];
    vec3 vert_f32d3_flat_4[4];
    vec4 vert_f16d4_flat_4[4];
    int vert_i32d1_flat_3[4];
    vec2 vert_f16d2_inter_8[4];
    vec2 vert_f16d2_flat_8[4];
 } pvd;

layout (location=0) in flat f32vec4 vert_f32d4_flat_2[];
layout (location=1) in flat i32vec4 vert_i32d4_flat_6[];
layout (location=2) in flat f16vec2 vert_f16d2_flat_2[];
layout (location=3) in float16_t vert_f16d1_inter_1[];
layout (location=4) in flat float16_t vert_f16d1_flat_0[];
layout (location=5) in flat float16_t vert_f16d1_flat_5[];
layout (location=6) in flat f32vec4 vert_f32d4_flat_1[];
layout (location=7) in f32vec3 vert_f32d3_inter_8[];
layout (location=8) in float32_t vert_f32d1_inter_1[];
layout (location=9) in flat f16vec4 vert_f16d4_flat_0[];
layout (location=10) in f32vec3 vert_f32d3_inter_0[];
layout (location=11) in flat i32vec2 vert_i32d2_flat_0[];
layout (location=12) in flat i32vec2 vert_i32d2_flat_3[];
layout (location=13) in f16vec2 vert_f16d2_inter_5[];
layout (location=14) in float16_t vert_f16d1_inter_6[];
layout (location=15) in flat int32_t vert_i32d1_flat_0[];
layout (location=16) in float16_t vert_f16d1_inter_2[];
layout (location=17) in flat float16_t vert_f16d1_flat_9[];
layout (location=18) in flat float16_t vert_f16d1_flat_8[];
layout (location=19) in f32vec2 vert_f32d2_inter_4[];
layout (location=20) in flat i32vec3 vert_i32d3_flat_7[];
layout (location=21) in flat f32vec2 vert_f32d2_flat_0[];
layout (location=22) in f32vec3 vert_f32d3_inter_1[];
layout (location=23) in flat i32vec3 vert_i32d3_flat_0[];
layout (location=24) in flat f32vec3 vert_f32d3_flat_4[];
layout (location=25) in flat f16vec4 vert_f16d4_flat_4[];
layout (location=26) in flat int32_t vert_i32d1_flat_3[];
layout (location=27) in f16vec2 vert_f16d2_inter_8[];
layout (location=28) in flat f16vec2 vert_f16d2_flat_8[];

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
f32vec4 temp_vert_f32d4_flat_2;
INTERP_QUAD_VAR(f32vec4, var_vert_f32d4_flat_2 ,vert_f32d4_flat_2[i], temp_vert_f32d4_flat_2);
    bool good_vert_f32d4_flat_2 = all(lessThanEqual(temp_vert_f32d4_flat_2, f32vec4(max(max(max(pvd.vert_f32d4_flat_2[0], pvd.vert_f32d4_flat_2[1]), pvd.vert_f32d4_flat_2[2]), pvd.vert_f32d4_flat_2[3])))) && all(greaterThanEqual(temp_vert_f32d4_flat_2, f32vec4(min(min(min(pvd.vert_f32d4_flat_2[0], pvd.vert_f32d4_flat_2[1]), pvd.vert_f32d4_flat_2[2]), pvd.vert_f32d4_flat_2[3]))));
i32vec4 temp_vert_i32d4_flat_6;
INTERP_QUAD_VAR(i32vec4, var_vert_i32d4_flat_6 ,vert_i32d4_flat_6[i], temp_vert_i32d4_flat_6);
    bool good_vert_i32d4_flat_6 = all(lessThanEqual(temp_vert_i32d4_flat_6, i32vec4(max(max(max(pvd.vert_i32d4_flat_6[0], pvd.vert_i32d4_flat_6[1]), pvd.vert_i32d4_flat_6[2]), pvd.vert_i32d4_flat_6[3])))) && all(greaterThanEqual(temp_vert_i32d4_flat_6, i32vec4(min(min(min(pvd.vert_i32d4_flat_6[0], pvd.vert_i32d4_flat_6[1]), pvd.vert_i32d4_flat_6[2]), pvd.vert_i32d4_flat_6[3]))));
f16vec2 temp_vert_f16d2_flat_2;
INTERP_QUAD_VAR(f16vec2, var_vert_f16d2_flat_2 ,vert_f16d2_flat_2[i], temp_vert_f16d2_flat_2);
    bool good_vert_f16d2_flat_2 = all(lessThanEqual(temp_vert_f16d2_flat_2, f16vec2(max(max(max(pvd.vert_f16d2_flat_2[0], pvd.vert_f16d2_flat_2[1]), pvd.vert_f16d2_flat_2[2]), pvd.vert_f16d2_flat_2[3])))) && all(greaterThanEqual(temp_vert_f16d2_flat_2, f16vec2(min(min(min(pvd.vert_f16d2_flat_2[0], pvd.vert_f16d2_flat_2[1]), pvd.vert_f16d2_flat_2[2]), pvd.vert_f16d2_flat_2[3]))));
float16_t temp_vert_f16d1_inter_1;
INTERP_QUAD_VAR(float16_t, var_vert_f16d1_inter_1 ,vert_f16d1_inter_1[i], temp_vert_f16d1_inter_1);
    bool good_vert_f16d1_inter_1 = (temp_vert_f16d1_inter_1 <= float16_t(max(max(max(pvd.vert_f16d1_inter_1[0], pvd.vert_f16d1_inter_1[1]), pvd.vert_f16d1_inter_1[2]), pvd.vert_f16d1_inter_1[3]))) && (temp_vert_f16d1_inter_1 >= float16_t(min(min(min(pvd.vert_f16d1_inter_1[0], pvd.vert_f16d1_inter_1[1]), pvd.vert_f16d1_inter_1[2]), pvd.vert_f16d1_inter_1[3])));
float16_t temp_vert_f16d1_flat_0;
INTERP_QUAD_VAR(float16_t, var_vert_f16d1_flat_0 ,vert_f16d1_flat_0[i], temp_vert_f16d1_flat_0);
    bool good_vert_f16d1_flat_0 = (temp_vert_f16d1_flat_0 <= float16_t(max(max(max(pvd.vert_f16d1_flat_0[0], pvd.vert_f16d1_flat_0[1]), pvd.vert_f16d1_flat_0[2]), pvd.vert_f16d1_flat_0[3]))) && (temp_vert_f16d1_flat_0 >= float16_t(min(min(min(pvd.vert_f16d1_flat_0[0], pvd.vert_f16d1_flat_0[1]), pvd.vert_f16d1_flat_0[2]), pvd.vert_f16d1_flat_0[3])));
float16_t temp_vert_f16d1_flat_5;
INTERP_QUAD_VAR(float16_t, var_vert_f16d1_flat_5 ,vert_f16d1_flat_5[i], temp_vert_f16d1_flat_5);
    bool good_vert_f16d1_flat_5 = (temp_vert_f16d1_flat_5 <= float16_t(max(max(max(pvd.vert_f16d1_flat_5[0], pvd.vert_f16d1_flat_5[1]), pvd.vert_f16d1_flat_5[2]), pvd.vert_f16d1_flat_5[3]))) && (temp_vert_f16d1_flat_5 >= float16_t(min(min(min(pvd.vert_f16d1_flat_5[0], pvd.vert_f16d1_flat_5[1]), pvd.vert_f16d1_flat_5[2]), pvd.vert_f16d1_flat_5[3])));
f32vec4 temp_vert_f32d4_flat_1;
INTERP_QUAD_VAR(f32vec4, var_vert_f32d4_flat_1 ,vert_f32d4_flat_1[i], temp_vert_f32d4_flat_1);
    bool good_vert_f32d4_flat_1 = all(lessThanEqual(temp_vert_f32d4_flat_1, f32vec4(max(max(max(pvd.vert_f32d4_flat_1[0], pvd.vert_f32d4_flat_1[1]), pvd.vert_f32d4_flat_1[2]), pvd.vert_f32d4_flat_1[3])))) && all(greaterThanEqual(temp_vert_f32d4_flat_1, f32vec4(min(min(min(pvd.vert_f32d4_flat_1[0], pvd.vert_f32d4_flat_1[1]), pvd.vert_f32d4_flat_1[2]), pvd.vert_f32d4_flat_1[3]))));
f32vec3 temp_vert_f32d3_inter_8;
INTERP_QUAD_VAR(f32vec3, var_vert_f32d3_inter_8 ,vert_f32d3_inter_8[i], temp_vert_f32d3_inter_8);
    bool good_vert_f32d3_inter_8 = all(lessThanEqual(temp_vert_f32d3_inter_8, f32vec3(max(max(max(pvd.vert_f32d3_inter_8[0], pvd.vert_f32d3_inter_8[1]), pvd.vert_f32d3_inter_8[2]), pvd.vert_f32d3_inter_8[3])))) && all(greaterThanEqual(temp_vert_f32d3_inter_8, f32vec3(min(min(min(pvd.vert_f32d3_inter_8[0], pvd.vert_f32d3_inter_8[1]), pvd.vert_f32d3_inter_8[2]), pvd.vert_f32d3_inter_8[3]))));
float32_t temp_vert_f32d1_inter_1;
INTERP_QUAD_VAR(float32_t, var_vert_f32d1_inter_1 ,vert_f32d1_inter_1[i], temp_vert_f32d1_inter_1);
    bool good_vert_f32d1_inter_1 = (temp_vert_f32d1_inter_1 <= float32_t(max(max(max(pvd.vert_f32d1_inter_1[0], pvd.vert_f32d1_inter_1[1]), pvd.vert_f32d1_inter_1[2]), pvd.vert_f32d1_inter_1[3]))) && (temp_vert_f32d1_inter_1 >= float32_t(min(min(min(pvd.vert_f32d1_inter_1[0], pvd.vert_f32d1_inter_1[1]), pvd.vert_f32d1_inter_1[2]), pvd.vert_f32d1_inter_1[3])));
f16vec4 temp_vert_f16d4_flat_0;
INTERP_QUAD_VAR(f16vec4, var_vert_f16d4_flat_0 ,vert_f16d4_flat_0[i], temp_vert_f16d4_flat_0);
    bool good_vert_f16d4_flat_0 = all(lessThanEqual(temp_vert_f16d4_flat_0, f16vec4(max(max(max(pvd.vert_f16d4_flat_0[0], pvd.vert_f16d4_flat_0[1]), pvd.vert_f16d4_flat_0[2]), pvd.vert_f16d4_flat_0[3])))) && all(greaterThanEqual(temp_vert_f16d4_flat_0, f16vec4(min(min(min(pvd.vert_f16d4_flat_0[0], pvd.vert_f16d4_flat_0[1]), pvd.vert_f16d4_flat_0[2]), pvd.vert_f16d4_flat_0[3]))));
f32vec3 temp_vert_f32d3_inter_0;
INTERP_QUAD_VAR(f32vec3, var_vert_f32d3_inter_0 ,vert_f32d3_inter_0[i], temp_vert_f32d3_inter_0);
    bool good_vert_f32d3_inter_0 = all(lessThanEqual(temp_vert_f32d3_inter_0, f32vec3(max(max(max(pvd.vert_f32d3_inter_0[0], pvd.vert_f32d3_inter_0[1]), pvd.vert_f32d3_inter_0[2]), pvd.vert_f32d3_inter_0[3])))) && all(greaterThanEqual(temp_vert_f32d3_inter_0, f32vec3(min(min(min(pvd.vert_f32d3_inter_0[0], pvd.vert_f32d3_inter_0[1]), pvd.vert_f32d3_inter_0[2]), pvd.vert_f32d3_inter_0[3]))));
i32vec2 temp_vert_i32d2_flat_0;
INTERP_QUAD_VAR(i32vec2, var_vert_i32d2_flat_0 ,vert_i32d2_flat_0[i], temp_vert_i32d2_flat_0);
    bool good_vert_i32d2_flat_0 = all(lessThanEqual(temp_vert_i32d2_flat_0, i32vec2(max(max(max(pvd.vert_i32d2_flat_0[0], pvd.vert_i32d2_flat_0[1]), pvd.vert_i32d2_flat_0[2]), pvd.vert_i32d2_flat_0[3])))) && all(greaterThanEqual(temp_vert_i32d2_flat_0, i32vec2(min(min(min(pvd.vert_i32d2_flat_0[0], pvd.vert_i32d2_flat_0[1]), pvd.vert_i32d2_flat_0[2]), pvd.vert_i32d2_flat_0[3]))));
i32vec2 temp_vert_i32d2_flat_3;
INTERP_QUAD_VAR(i32vec2, var_vert_i32d2_flat_3 ,vert_i32d2_flat_3[i], temp_vert_i32d2_flat_3);
    bool good_vert_i32d2_flat_3 = all(lessThanEqual(temp_vert_i32d2_flat_3, i32vec2(max(max(max(pvd.vert_i32d2_flat_3[0], pvd.vert_i32d2_flat_3[1]), pvd.vert_i32d2_flat_3[2]), pvd.vert_i32d2_flat_3[3])))) && all(greaterThanEqual(temp_vert_i32d2_flat_3, i32vec2(min(min(min(pvd.vert_i32d2_flat_3[0], pvd.vert_i32d2_flat_3[1]), pvd.vert_i32d2_flat_3[2]), pvd.vert_i32d2_flat_3[3]))));
f16vec2 temp_vert_f16d2_inter_5;
INTERP_QUAD_VAR(f16vec2, var_vert_f16d2_inter_5 ,vert_f16d2_inter_5[i], temp_vert_f16d2_inter_5);
    bool good_vert_f16d2_inter_5 = all(lessThanEqual(temp_vert_f16d2_inter_5, f16vec2(max(max(max(pvd.vert_f16d2_inter_5[0], pvd.vert_f16d2_inter_5[1]), pvd.vert_f16d2_inter_5[2]), pvd.vert_f16d2_inter_5[3])))) && all(greaterThanEqual(temp_vert_f16d2_inter_5, f16vec2(min(min(min(pvd.vert_f16d2_inter_5[0], pvd.vert_f16d2_inter_5[1]), pvd.vert_f16d2_inter_5[2]), pvd.vert_f16d2_inter_5[3]))));
float16_t temp_vert_f16d1_inter_6;
INTERP_QUAD_VAR(float16_t, var_vert_f16d1_inter_6 ,vert_f16d1_inter_6[i], temp_vert_f16d1_inter_6);
    bool good_vert_f16d1_inter_6 = (temp_vert_f16d1_inter_6 <= float16_t(max(max(max(pvd.vert_f16d1_inter_6[0], pvd.vert_f16d1_inter_6[1]), pvd.vert_f16d1_inter_6[2]), pvd.vert_f16d1_inter_6[3]))) && (temp_vert_f16d1_inter_6 >= float16_t(min(min(min(pvd.vert_f16d1_inter_6[0], pvd.vert_f16d1_inter_6[1]), pvd.vert_f16d1_inter_6[2]), pvd.vert_f16d1_inter_6[3])));
int32_t temp_vert_i32d1_flat_0;
INTERP_QUAD_VAR(int32_t, var_vert_i32d1_flat_0 ,vert_i32d1_flat_0[i], temp_vert_i32d1_flat_0);
    bool good_vert_i32d1_flat_0 = (temp_vert_i32d1_flat_0 <= int32_t(max(max(max(pvd.vert_i32d1_flat_0[0], pvd.vert_i32d1_flat_0[1]), pvd.vert_i32d1_flat_0[2]), pvd.vert_i32d1_flat_0[3]))) && (temp_vert_i32d1_flat_0 >= int32_t(min(min(min(pvd.vert_i32d1_flat_0[0], pvd.vert_i32d1_flat_0[1]), pvd.vert_i32d1_flat_0[2]), pvd.vert_i32d1_flat_0[3])));
float16_t temp_vert_f16d1_inter_2;
INTERP_QUAD_VAR(float16_t, var_vert_f16d1_inter_2 ,vert_f16d1_inter_2[i], temp_vert_f16d1_inter_2);
    bool good_vert_f16d1_inter_2 = (temp_vert_f16d1_inter_2 <= float16_t(max(max(max(pvd.vert_f16d1_inter_2[0], pvd.vert_f16d1_inter_2[1]), pvd.vert_f16d1_inter_2[2]), pvd.vert_f16d1_inter_2[3]))) && (temp_vert_f16d1_inter_2 >= float16_t(min(min(min(pvd.vert_f16d1_inter_2[0], pvd.vert_f16d1_inter_2[1]), pvd.vert_f16d1_inter_2[2]), pvd.vert_f16d1_inter_2[3])));
float16_t temp_vert_f16d1_flat_9;
INTERP_QUAD_VAR(float16_t, var_vert_f16d1_flat_9 ,vert_f16d1_flat_9[i], temp_vert_f16d1_flat_9);
    bool good_vert_f16d1_flat_9 = (temp_vert_f16d1_flat_9 <= float16_t(max(max(max(pvd.vert_f16d1_flat_9[0], pvd.vert_f16d1_flat_9[1]), pvd.vert_f16d1_flat_9[2]), pvd.vert_f16d1_flat_9[3]))) && (temp_vert_f16d1_flat_9 >= float16_t(min(min(min(pvd.vert_f16d1_flat_9[0], pvd.vert_f16d1_flat_9[1]), pvd.vert_f16d1_flat_9[2]), pvd.vert_f16d1_flat_9[3])));
float16_t temp_vert_f16d1_flat_8;
INTERP_QUAD_VAR(float16_t, var_vert_f16d1_flat_8 ,vert_f16d1_flat_8[i], temp_vert_f16d1_flat_8);
    bool good_vert_f16d1_flat_8 = (temp_vert_f16d1_flat_8 <= float16_t(max(max(max(pvd.vert_f16d1_flat_8[0], pvd.vert_f16d1_flat_8[1]), pvd.vert_f16d1_flat_8[2]), pvd.vert_f16d1_flat_8[3]))) && (temp_vert_f16d1_flat_8 >= float16_t(min(min(min(pvd.vert_f16d1_flat_8[0], pvd.vert_f16d1_flat_8[1]), pvd.vert_f16d1_flat_8[2]), pvd.vert_f16d1_flat_8[3])));
f32vec2 temp_vert_f32d2_inter_4;
INTERP_QUAD_VAR(f32vec2, var_vert_f32d2_inter_4 ,vert_f32d2_inter_4[i], temp_vert_f32d2_inter_4);
    bool good_vert_f32d2_inter_4 = all(lessThanEqual(temp_vert_f32d2_inter_4, f32vec2(max(max(max(pvd.vert_f32d2_inter_4[0], pvd.vert_f32d2_inter_4[1]), pvd.vert_f32d2_inter_4[2]), pvd.vert_f32d2_inter_4[3])))) && all(greaterThanEqual(temp_vert_f32d2_inter_4, f32vec2(min(min(min(pvd.vert_f32d2_inter_4[0], pvd.vert_f32d2_inter_4[1]), pvd.vert_f32d2_inter_4[2]), pvd.vert_f32d2_inter_4[3]))));
i32vec3 temp_vert_i32d3_flat_7;
INTERP_QUAD_VAR(i32vec3, var_vert_i32d3_flat_7 ,vert_i32d3_flat_7[i], temp_vert_i32d3_flat_7);
    bool good_vert_i32d3_flat_7 = all(lessThanEqual(temp_vert_i32d3_flat_7, i32vec3(max(max(max(pvd.vert_i32d3_flat_7[0], pvd.vert_i32d3_flat_7[1]), pvd.vert_i32d3_flat_7[2]), pvd.vert_i32d3_flat_7[3])))) && all(greaterThanEqual(temp_vert_i32d3_flat_7, i32vec3(min(min(min(pvd.vert_i32d3_flat_7[0], pvd.vert_i32d3_flat_7[1]), pvd.vert_i32d3_flat_7[2]), pvd.vert_i32d3_flat_7[3]))));
f32vec2 temp_vert_f32d2_flat_0;
INTERP_QUAD_VAR(f32vec2, var_vert_f32d2_flat_0 ,vert_f32d2_flat_0[i], temp_vert_f32d2_flat_0);
    bool good_vert_f32d2_flat_0 = all(lessThanEqual(temp_vert_f32d2_flat_0, f32vec2(max(max(max(pvd.vert_f32d2_flat_0[0], pvd.vert_f32d2_flat_0[1]), pvd.vert_f32d2_flat_0[2]), pvd.vert_f32d2_flat_0[3])))) && all(greaterThanEqual(temp_vert_f32d2_flat_0, f32vec2(min(min(min(pvd.vert_f32d2_flat_0[0], pvd.vert_f32d2_flat_0[1]), pvd.vert_f32d2_flat_0[2]), pvd.vert_f32d2_flat_0[3]))));
f32vec3 temp_vert_f32d3_inter_1;
INTERP_QUAD_VAR(f32vec3, var_vert_f32d3_inter_1 ,vert_f32d3_inter_1[i], temp_vert_f32d3_inter_1);
    bool good_vert_f32d3_inter_1 = all(lessThanEqual(temp_vert_f32d3_inter_1, f32vec3(max(max(max(pvd.vert_f32d3_inter_1[0], pvd.vert_f32d3_inter_1[1]), pvd.vert_f32d3_inter_1[2]), pvd.vert_f32d3_inter_1[3])))) && all(greaterThanEqual(temp_vert_f32d3_inter_1, f32vec3(min(min(min(pvd.vert_f32d3_inter_1[0], pvd.vert_f32d3_inter_1[1]), pvd.vert_f32d3_inter_1[2]), pvd.vert_f32d3_inter_1[3]))));
i32vec3 temp_vert_i32d3_flat_0;
INTERP_QUAD_VAR(i32vec3, var_vert_i32d3_flat_0 ,vert_i32d3_flat_0[i], temp_vert_i32d3_flat_0);
    bool good_vert_i32d3_flat_0 = all(lessThanEqual(temp_vert_i32d3_flat_0, i32vec3(max(max(max(pvd.vert_i32d3_flat_0[0], pvd.vert_i32d3_flat_0[1]), pvd.vert_i32d3_flat_0[2]), pvd.vert_i32d3_flat_0[3])))) && all(greaterThanEqual(temp_vert_i32d3_flat_0, i32vec3(min(min(min(pvd.vert_i32d3_flat_0[0], pvd.vert_i32d3_flat_0[1]), pvd.vert_i32d3_flat_0[2]), pvd.vert_i32d3_flat_0[3]))));
f32vec3 temp_vert_f32d3_flat_4;
INTERP_QUAD_VAR(f32vec3, var_vert_f32d3_flat_4 ,vert_f32d3_flat_4[i], temp_vert_f32d3_flat_4);
    bool good_vert_f32d3_flat_4 = all(lessThanEqual(temp_vert_f32d3_flat_4, f32vec3(max(max(max(pvd.vert_f32d3_flat_4[0], pvd.vert_f32d3_flat_4[1]), pvd.vert_f32d3_flat_4[2]), pvd.vert_f32d3_flat_4[3])))) && all(greaterThanEqual(temp_vert_f32d3_flat_4, f32vec3(min(min(min(pvd.vert_f32d3_flat_4[0], pvd.vert_f32d3_flat_4[1]), pvd.vert_f32d3_flat_4[2]), pvd.vert_f32d3_flat_4[3]))));
f16vec4 temp_vert_f16d4_flat_4;
INTERP_QUAD_VAR(f16vec4, var_vert_f16d4_flat_4 ,vert_f16d4_flat_4[i], temp_vert_f16d4_flat_4);
    bool good_vert_f16d4_flat_4 = all(lessThanEqual(temp_vert_f16d4_flat_4, f16vec4(max(max(max(pvd.vert_f16d4_flat_4[0], pvd.vert_f16d4_flat_4[1]), pvd.vert_f16d4_flat_4[2]), pvd.vert_f16d4_flat_4[3])))) && all(greaterThanEqual(temp_vert_f16d4_flat_4, f16vec4(min(min(min(pvd.vert_f16d4_flat_4[0], pvd.vert_f16d4_flat_4[1]), pvd.vert_f16d4_flat_4[2]), pvd.vert_f16d4_flat_4[3]))));
int32_t temp_vert_i32d1_flat_3;
INTERP_QUAD_VAR(int32_t, var_vert_i32d1_flat_3 ,vert_i32d1_flat_3[i], temp_vert_i32d1_flat_3);
    bool good_vert_i32d1_flat_3 = (temp_vert_i32d1_flat_3 <= int32_t(max(max(max(pvd.vert_i32d1_flat_3[0], pvd.vert_i32d1_flat_3[1]), pvd.vert_i32d1_flat_3[2]), pvd.vert_i32d1_flat_3[3]))) && (temp_vert_i32d1_flat_3 >= int32_t(min(min(min(pvd.vert_i32d1_flat_3[0], pvd.vert_i32d1_flat_3[1]), pvd.vert_i32d1_flat_3[2]), pvd.vert_i32d1_flat_3[3])));
f16vec2 temp_vert_f16d2_inter_8;
INTERP_QUAD_VAR(f16vec2, var_vert_f16d2_inter_8 ,vert_f16d2_inter_8[i], temp_vert_f16d2_inter_8);
    bool good_vert_f16d2_inter_8 = all(lessThanEqual(temp_vert_f16d2_inter_8, f16vec2(max(max(max(pvd.vert_f16d2_inter_8[0], pvd.vert_f16d2_inter_8[1]), pvd.vert_f16d2_inter_8[2]), pvd.vert_f16d2_inter_8[3])))) && all(greaterThanEqual(temp_vert_f16d2_inter_8, f16vec2(min(min(min(pvd.vert_f16d2_inter_8[0], pvd.vert_f16d2_inter_8[1]), pvd.vert_f16d2_inter_8[2]), pvd.vert_f16d2_inter_8[3]))));
f16vec2 temp_vert_f16d2_flat_8;
INTERP_QUAD_VAR(f16vec2, var_vert_f16d2_flat_8 ,vert_f16d2_flat_8[i], temp_vert_f16d2_flat_8);
    bool good_vert_f16d2_flat_8 = all(lessThanEqual(temp_vert_f16d2_flat_8, f16vec2(max(max(max(pvd.vert_f16d2_flat_8[0], pvd.vert_f16d2_flat_8[1]), pvd.vert_f16d2_flat_8[2]), pvd.vert_f16d2_flat_8[3])))) && all(greaterThanEqual(temp_vert_f16d2_flat_8, f16vec2(min(min(min(pvd.vert_f16d2_flat_8[0], pvd.vert_f16d2_flat_8[1]), pvd.vert_f16d2_flat_8[2]), pvd.vert_f16d2_flat_8[3]))));
    if (good_vert_f32d4_flat_2 && good_vert_i32d4_flat_6 && good_vert_f16d2_flat_2 && good_vert_f16d1_inter_1 && good_vert_f16d1_flat_0 && good_vert_f16d1_flat_5 && good_vert_f32d4_flat_1 && good_vert_f32d3_inter_8 && good_vert_f32d1_inter_1 && good_vert_f16d4_flat_0 && good_vert_f32d3_inter_0 && good_vert_i32d2_flat_0 && good_vert_i32d2_flat_3 && good_vert_f16d2_inter_5 && good_vert_f16d1_inter_6 && good_vert_i32d1_flat_0 && good_vert_f16d1_inter_2 && good_vert_f16d1_flat_9 && good_vert_f16d1_flat_8 && good_vert_f32d2_inter_4 && good_vert_i32d3_flat_7 && good_vert_f32d2_flat_0 && good_vert_f32d3_inter_1 && good_vert_i32d3_flat_0 && good_vert_f32d3_flat_4 && good_vert_f16d4_flat_4 && good_vert_i32d1_flat_3 && good_vert_f16d2_inter_8 && good_vert_f16d2_flat_8) {
        outColor = (gl_PrimitiveID == 0) ? vec4(0.0, 0.0, 1.0, 1.0) : vec4(1.0, 1.0, 0.0, 1.0);
    } else {
        outColor = vec4(0.0, 0.0, 0.0, 1.0);
    }
    INTERP_QUAD_VAR(vec4, var_gl_pos, gl_in[i].gl_Position, gl_Position);
}
#version 450
layout (location=0) in vec4 inColor;
layout (location=0) out vec4 outColor;
void main()
{
    outColor = inColor;
}
#version 450
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_shader_explicit_arithmetic_types : enable

layout (vertices = 4) out;


layout (location=0) out vec4 outColor[];

layout (location=1) out flat f32vec4 vert_f32d4_flat_2[];
layout (location=2) out flat i32vec4 vert_i32d4_flat_6[];
layout (location=3) out flat f16vec2 vert_f16d2_flat_2[];
layout (location=4) out float16_t vert_f16d1_inter_1[];
layout (location=5) out flat float16_t vert_f16d1_flat_0[];
layout (location=6) out flat float16_t vert_f16d1_flat_5[];
layout (location=7) out flat f32vec4 vert_f32d4_flat_1[];
layout (location=8) out f32vec3 vert_f32d3_inter_8[];
layout (location=9) out float32_t vert_f32d1_inter_1[];
layout (location=10) out flat f16vec4 vert_f16d4_flat_0[];
layout (location=11) out f32vec3 vert_f32d3_inter_0[];
layout (location=12) out flat i32vec2 vert_i32d2_flat_0[];
layout (location=13) out flat i32vec2 vert_i32d2_flat_3[];
layout (location=14) out f16vec2 vert_f16d2_inter_5[];
layout (location=15) out float16_t vert_f16d1_inter_6[];
layout (location=16) out flat int32_t vert_i32d1_flat_0[];
layout (location=17) out float16_t vert_f16d1_inter_2[];
layout (location=18) out flat float16_t vert_f16d1_flat_9[];
layout (location=19) out flat float16_t vert_f16d1_flat_8[];
layout (location=20) out f32vec2 vert_f32d2_inter_4[];
layout (location=21) out flat i32vec3 vert_i32d3_flat_7[];
layout (location=22) out flat f32vec2 vert_f32d2_flat_0[];
layout (location=23) out f32vec3 vert_f32d3_inter_1[];
layout (location=24) out flat i32vec3 vert_i32d3_flat_0[];
layout (location=25) out flat f32vec3 vert_f32d3_flat_4[];
layout (location=26) out flat f16vec4 vert_f16d4_flat_4[];
layout (location=27) out flat int32_t vert_i32d1_flat_3[];
layout (location=28) out f16vec2 vert_f16d2_inter_8[];

layout(set=0, binding=0, std430) readonly buffer PerVertexBlock {
    vec4 vert_f32d4_flat_2[4];
    ivec4 vert_i32d4_flat_6[4];
    vec2 vert_f16d2_flat_2[4];
    float vert_f16d1_inter_1[4];
    float vert_f16d1_flat_0[4];
    float vert_f16d1_flat_5[4];
    vec4 vert_f32d4_flat_1[4];
    vec3 vert_f32d3_inter_8[4];
    float vert_f32d1_inter_1[4];
    vec4 vert_f16d4_flat_0[4];
    vec3 vert_f32d3_inter_0[4];
    ivec2 vert_i32d2_flat_0[4];
    ivec2 vert_i32d2_flat_3[4];
    vec2 vert_f16d2_inter_5[4];
    float vert_f16d1_inter_6[4];
    int vert_i32d1_flat_0[4];
    float vert_f16d1_inter_2[4];
    float vert_f16d1_flat_9[4];
    float vert_f16d1_flat_8[4];
    vec2 vert_f32d2_inter_4[4];
    ivec3 vert_i32d3_flat_7[4];
    vec2 vert_f32d2_flat_0[4];
    vec3 vert_f32d3_inter_1[4];
    ivec3 vert_i32d3_flat_0[4];
    vec3 vert_f32d3_flat_4[4];
    vec4 vert_f16d4_flat_4[4];
    int vert_i32d1_flat_3[4];
    vec2 vert_f16d2_inter_8[4];
 } pvd;

in gl_PerVertex {
    vec4  gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
} gl_out[];

void main ()
{
    vert_f32d4_flat_2[gl_InvocationID] = f32vec4(pvd.vert_f32d4_flat_2[gl_InvocationID]);
    vert_i32d4_flat_6[gl_InvocationID] = i32vec4(pvd.vert_i32d4_flat_6[gl_InvocationID]);
    vert_f16d2_flat_2[gl_InvocationID] = f16vec2(pvd.vert_f16d2_flat_2[gl_InvocationID]);
    vert_f16d1_inter_1[gl_InvocationID] = float16_t(pvd.vert_f16d1_inter_1[gl_InvocationID]);
    vert_f16d1_flat_0[gl_InvocationID] = float16_t(pvd.vert_f16d1_flat_0[gl_InvocationID]);
    vert_f16d1_flat_5[gl_InvocationID] = float16_t(pvd.vert_f16d1_flat_5[gl_InvocationID]);
    vert_f32d4_flat_1[gl_InvocationID] = f32vec4(pvd.vert_f32d4_flat_1[gl_InvocationID]);
    vert_f32d3_inter_8[gl_InvocationID] = f32vec3(pvd.vert_f32d3_inter_8[gl_InvocationID]);
    vert_f32d1_inter_1[gl_InvocationID] = float32_t(pvd.vert_f32d1_inter_1[gl_InvocationID]);
    vert_f16d4_flat_0[gl_InvocationID] = f16vec4(pvd.vert_f16d4_flat_0[gl_InvocationID]);
    vert_f32d3_inter_0[gl_InvocationID] = f32vec3(pvd.vert_f32d3_inter_0[gl_InvocationID]);
    vert_i32d2_flat_0[gl_InvocationID] = i32vec2(pvd.vert_i32d2_flat_0[gl_InvocationID]);
    vert_i32d2_flat_3[gl_InvocationID] = i32vec2(pvd.vert_i32d2_flat_3[gl_InvocationID]);
    vert_f16d2_inter_5[gl_InvocationID] = f16vec2(pvd.vert_f16d2_inter_5[gl_InvocationID]);
    vert_f16d1_inter_6[gl_InvocationID] = float16_t(pvd.vert_f16d1_inter_6[gl_InvocationID]);
    vert_i32d1_flat_0[gl_InvocationID] = int32_t(pvd.vert_i32d1_flat_0[gl_InvocationID]);
    vert_f16d1_inter_2[gl_InvocationID] = float16_t(pvd.vert_f16d1_inter_2[gl_InvocationID]);
    vert_f16d1_flat_9[gl_InvocationID] = float16_t(pvd.vert_f16d1_flat_9[gl_InvocationID]);
    vert_f16d1_flat_8[gl_InvocationID] = float16_t(pvd.vert_f16d1_flat_8[gl_InvocationID]);
    vert_f32d2_inter_4[gl_InvocationID] = f32vec2(pvd.vert_f32d2_inter_4[gl_InvocationID]);
    vert_i32d3_flat_7[gl_InvocationID] = i32vec3(pvd.vert_i32d3_flat_7[gl_InvocationID]);
    vert_f32d2_flat_0[gl_InvocationID] = f32vec2(pvd.vert_f32d2_flat_0[gl_InvocationID]);
    vert_f32d3_inter_1[gl_InvocationID] = f32vec3(pvd.vert_f32d3_inter_1[gl_InvocationID]);
    vert_i32d3_flat_0[gl_InvocationID] = i32vec3(pvd.vert_i32d3_flat_0[gl_InvocationID]);
    vert_f32d3_flat_4[gl_InvocationID] = f32vec3(pvd.vert_f32d3_flat_4[gl_InvocationID]);
    vert_f16d4_flat_4[gl_InvocationID] = f16vec4(pvd.vert_f16d4_flat_4[gl_InvocationID]);
    vert_i32d1_flat_3[gl_InvocationID] = int32_t(pvd.vert_i32d1_flat_3[gl_InvocationID]);
    vert_f16d2_inter_8[gl_InvocationID] = f16vec2(pvd.vert_f16d2_inter_8[gl_InvocationID]);
    bool good_vert_f32d4_flat_2 = all(lessThanEqual(vert_f32d4_flat_2[gl_InvocationID], f32vec4(max(max(max(pvd.vert_f32d4_flat_2[0], pvd.vert_f32d4_flat_2[1]), pvd.vert_f32d4_flat_2[2]), pvd.vert_f32d4_flat_2[3])))) && all(greaterThanEqual(vert_f32d4_flat_2[gl_InvocationID], f32vec4(min(min(min(pvd.vert_f32d4_flat_2[0], pvd.vert_f32d4_flat_2[1]), pvd.vert_f32d4_flat_2[2]), pvd.vert_f32d4_flat_2[3]))));
    bool good_vert_i32d4_flat_6 = all(lessThanEqual(vert_i32d4_flat_6[gl_InvocationID], i32vec4(max(max(max(pvd.vert_i32d4_flat_6[0], pvd.vert_i32d4_flat_6[1]), pvd.vert_i32d4_flat_6[2]), pvd.vert_i32d4_flat_6[3])))) && all(greaterThanEqual(vert_i32d4_flat_6[gl_InvocationID], i32vec4(min(min(min(pvd.vert_i32d4_flat_6[0], pvd.vert_i32d4_flat_6[1]), pvd.vert_i32d4_flat_6[2]), pvd.vert_i32d4_flat_6[3]))));
    bool good_vert_f16d2_flat_2 = all(lessThanEqual(vert_f16d2_flat_2[gl_InvocationID], f16vec2(max(max(max(pvd.vert_f16d2_flat_2[0], pvd.vert_f16d2_flat_2[1]), pvd.vert_f16d2_flat_2[2]), pvd.vert_f16d2_flat_2[3])))) && all(greaterThanEqual(vert_f16d2_flat_2[gl_InvocationID], f16vec2(min(min(min(pvd.vert_f16d2_flat_2[0], pvd.vert_f16d2_flat_2[1]), pvd.vert_f16d2_flat_2[2]), pvd.vert_f16d2_flat_2[3]))));
    bool good_vert_f16d1_inter_1 = (vert_f16d1_inter_1[gl_InvocationID] <= float16_t(max(max(max(pvd.vert_f16d1_inter_1[0], pvd.vert_f16d1_inter_1[1]), pvd.vert_f16d1_inter_1[2]), pvd.vert_f16d1_inter_1[3]))) && (vert_f16d1_inter_1[gl_InvocationID] >= float16_t(min(min(min(pvd.vert_f16d1_inter_1[0], pvd.vert_f16d1_inter_1[1]), pvd.vert_f16d1_inter_1[2]), pvd.vert_f16d1_inter_1[3])));
    bool good_vert_f16d1_flat_0 = (vert_f16d1_flat_0[gl_InvocationID] <= float16_t(max(max(max(pvd.vert_f16d1_flat_0[0], pvd.vert_f16d1_flat_0[1]), pvd.vert_f16d1_flat_0[2]), pvd.vert_f16d1_flat_0[3]))) && (vert_f16d1_flat_0[gl_InvocationID] >= float16_t(min(min(min(pvd.vert_f16d1_flat_0[0], pvd.vert_f16d1_flat_0[1]), pvd.vert_f16d1_flat_0[2]), pvd.vert_f16d1_flat_0[3])));
    bool good_vert_f16d1_flat_5 = (vert_f16d1_flat_5[gl_InvocationID] <= float16_t(max(max(max(pvd.vert_f16d1_flat_5[0], pvd.vert_f16d1_flat_5[1]), pvd.vert_f16d1_flat_5[2]), pvd.vert_f16d1_flat_5[3]))) && (vert_f16d1_flat_5[gl_InvocationID] >= float16_t(min(min(min(pvd.vert_f16d1_flat_5[0], pvd.vert_f16d1_flat_5[1]), pvd.vert_f16d1_flat_5[2]), pvd.vert_f16d1_flat_5[3])));
    bool good_vert_f32d4_flat_1 = all(lessThanEqual(vert_f32d4_flat_1[gl_InvocationID], f32vec4(max(max(max(pvd.vert_f32d4_flat_1[0], pvd.vert_f32d4_flat_1[1]), pvd.vert_f32d4_flat_1[2]), pvd.vert_f32d4_flat_1[3])))) && all(greaterThanEqual(vert_f32d4_flat_1[gl_InvocationID], f32vec4(min(min(min(pvd.vert_f32d4_flat_1[0], pvd.vert_f32d4_flat_1[1]), pvd.vert_f32d4_flat_1[2]), pvd.vert_f32d4_flat_1[3]))));
    bool good_vert_f32d3_inter_8 = all(lessThanEqual(vert_f32d3_inter_8[gl_InvocationID], f32vec3(max(max(max(pvd.vert_f32d3_inter_8[0], pvd.vert_f32d3_inter_8[1]), pvd.vert_f32d3_inter_8[2]), pvd.vert_f32d3_inter_8[3])))) && all(greaterThanEqual(vert_f32d3_inter_8[gl_InvocationID], f32vec3(min(min(min(pvd.vert_f32d3_inter_8[0], pvd.vert_f32d3_inter_8[1]), pvd.vert_f32d3_inter_8[2]), pvd.vert_f32d3_inter_8[3]))));
    bool good_vert_f32d1_inter_1 = (vert_f32d1_inter_1[gl_InvocationID] <= float32_t(max(max(max(pvd.vert_f32d1_inter_1[0], pvd.vert_f32d1_inter_1[1]), pvd.vert_f32d1_inter_1[2]), pvd.vert_f32d1_inter_1[3]))) && (vert_f32d1_inter_1[gl_InvocationID] >= float32_t(min(min(min(pvd.vert_f32d1_inter_1[0], pvd.vert_f32d1_inter_1[1]), pvd.vert_f32d1_inter_1[2]), pvd.vert_f32d1_inter_1[3])));
    bool good_vert_f16d4_flat_0 = all(lessThanEqual(vert_f16d4_flat_0[gl_InvocationID], f16vec4(max(max(max(pvd.vert_f16d4_flat_0[0], pvd.vert_f16d4_flat_0[1]), pvd.vert_f16d4_flat_0[2]), pvd.vert_f16d4_flat_0[3])))) && all(greaterThanEqual(vert_f16d4_flat_0[gl_InvocationID], f16vec4(min(min(min(pvd.vert_f16d4_flat_0[0], pvd.vert_f16d4_flat_0[1]), pvd.vert_f16d4_flat_0[2]), pvd.vert_f16d4_flat_0[3]))));
    bool good_vert_f32d3_inter_0 = all(lessThanEqual(vert_f32d3_inter_0[gl_InvocationID], f32vec3(max(max(max(pvd.vert_f32d3_inter_0[0], pvd.vert_f32d3_inter_0[1]), pvd.vert_f32d3_inter_0[2]), pvd.vert_f32d3_inter_0[3])))) && all(greaterThanEqual(vert_f32d3_inter_0[gl_InvocationID], f32vec3(min(min(min(pvd.vert_f32d3_inter_0[0], pvd.vert_f32d3_inter_0[1]), pvd.vert_f32d3_inter_0[2]), pvd.vert_f32d3_inter_0[3]))));
    bool good_vert_i32d2_flat_0 = all(lessThanEqual(vert_i32d2_flat_0[gl_InvocationID], i32vec2(max(max(max(pvd.vert_i32d2_flat_0[0], pvd.vert_i32d2_flat_0[1]), pvd.vert_i32d2_flat_0[2]), pvd.vert_i32d2_flat_0[3])))) && all(greaterThanEqual(vert_i32d2_flat_0[gl_InvocationID], i32vec2(min(min(min(pvd.vert_i32d2_flat_0[0], pvd.vert_i32d2_flat_0[1]), pvd.vert_i32d2_flat_0[2]), pvd.vert_i32d2_flat_0[3]))));
    bool good_vert_i32d2_flat_3 = all(lessThanEqual(vert_i32d2_flat_3[gl_InvocationID], i32vec2(max(max(max(pvd.vert_i32d2_flat_3[0], pvd.vert_i32d2_flat_3[1]), pvd.vert_i32d2_flat_3[2]), pvd.vert_i32d2_flat_3[3])))) && all(greaterThanEqual(vert_i32d2_flat_3[gl_InvocationID], i32vec2(min(min(min(pvd.vert_i32d2_flat_3[0], pvd.vert_i32d2_flat_3[1]), pvd.vert_i32d2_flat_3[2]), pvd.vert_i32d2_flat_3[3]))));
    bool good_vert_f16d2_inter_5 = all(lessThanEqual(vert_f16d2_inter_5[gl_InvocationID], f16vec2(max(max(max(pvd.vert_f16d2_inter_5[0], pvd.vert_f16d2_inter_5[1]), pvd.vert_f16d2_inter_5[2]), pvd.vert_f16d2_inter_5[3])))) && all(greaterThanEqual(vert_f16d2_inter_5[gl_InvocationID], f16vec2(min(min(min(pvd.vert_f16d2_inter_5[0], pvd.vert_f16d2_inter_5[1]), pvd.vert_f16d2_inter_5[2]), pvd.vert_f16d2_inter_5[3]))));
    bool good_vert_f16d1_inter_6 = (vert_f16d1_inter_6[gl_InvocationID] <= float16_t(max(max(max(pvd.vert_f16d1_inter_6[0], pvd.vert_f16d1_inter_6[1]), pvd.vert_f16d1_inter_6[2]), pvd.vert_f16d1_inter_6[3]))) && (vert_f16d1_inter_6[gl_InvocationID] >= float16_t(min(min(min(pvd.vert_f16d1_inter_6[0], pvd.vert_f16d1_inter_6[1]), pvd.vert_f16d1_inter_6[2]), pvd.vert_f16d1_inter_6[3])));
    bool good_vert_i32d1_flat_0 = (vert_i32d1_flat_0[gl_InvocationID] <= int32_t(max(max(max(pvd.vert_i32d1_flat_0[0], pvd.vert_i32d1_flat_0[1]), pvd.vert_i32d1_flat_0[2]), pvd.vert_i32d1_flat_0[3]))) && (vert_i32d1_flat_0[gl_InvocationID] >= int32_t(min(min(min(pvd.vert_i32d1_flat_0[0], pvd.vert_i32d1_flat_0[1]), pvd.vert_i32d1_flat_0[2]), pvd.vert_i32d1_flat_0[3])));
    bool good_vert_f16d1_inter_2 = (vert_f16d1_inter_2[gl_InvocationID] <= float16_t(max(max(max(pvd.vert_f16d1_inter_2[0], pvd.vert_f16d1_inter_2[1]), pvd.vert_f16d1_inter_2[2]), pvd.vert_f16d1_inter_2[3]))) && (vert_f16d1_inter_2[gl_InvocationID] >= float16_t(min(min(min(pvd.vert_f16d1_inter_2[0], pvd.vert_f16d1_inter_2[1]), pvd.vert_f16d1_inter_2[2]), pvd.vert_f16d1_inter_2[3])));
    bool good_vert_f16d1_flat_9 = (vert_f16d1_flat_9[gl_InvocationID] <= float16_t(max(max(max(pvd.vert_f16d1_flat_9[0], pvd.vert_f16d1_flat_9[1]), pvd.vert_f16d1_flat_9[2]), pvd.vert_f16d1_flat_9[3]))) && (vert_f16d1_flat_9[gl_InvocationID] >= float16_t(min(min(min(pvd.vert_f16d1_flat_9[0], pvd.vert_f16d1_flat_9[1]), pvd.vert_f16d1_flat_9[2]), pvd.vert_f16d1_flat_9[3])));
    bool good_vert_f16d1_flat_8 = (vert_f16d1_flat_8[gl_InvocationID] <= float16_t(max(max(max(pvd.vert_f16d1_flat_8[0], pvd.vert_f16d1_flat_8[1]), pvd.vert_f16d1_flat_8[2]), pvd.vert_f16d1_flat_8[3]))) && (vert_f16d1_flat_8[gl_InvocationID] >= float16_t(min(min(min(pvd.vert_f16d1_flat_8[0], pvd.vert_f16d1_flat_8[1]), pvd.vert_f16d1_flat_8[2]), pvd.vert_f16d1_flat_8[3])));
    bool good_vert_f32d2_inter_4 = all(lessThanEqual(vert_f32d2_inter_4[gl_InvocationID], f32vec2(max(max(max(pvd.vert_f32d2_inter_4[0], pvd.vert_f32d2_inter_4[1]), pvd.vert_f32d2_inter_4[2]), pvd.vert_f32d2_inter_4[3])))) && all(greaterThanEqual(vert_f32d2_inter_4[gl_InvocationID], f32vec2(min(min(min(pvd.vert_f32d2_inter_4[0], pvd.vert_f32d2_inter_4[1]), pvd.vert_f32d2_inter_4[2]), pvd.vert_f32d2_inter_4[3]))));
    bool good_vert_i32d3_flat_7 = all(lessThanEqual(vert_i32d3_flat_7[gl_InvocationID], i32vec3(max(max(max(pvd.vert_i32d3_flat_7[0], pvd.vert_i32d3_flat_7[1]), pvd.vert_i32d3_flat_7[2]), pvd.vert_i32d3_flat_7[3])))) && all(greaterThanEqual(vert_i32d3_flat_7[gl_InvocationID], i32vec3(min(min(min(pvd.vert_i32d3_flat_7[0], pvd.vert_i32d3_flat_7[1]), pvd.vert_i32d3_flat_7[2]), pvd.vert_i32d3_flat_7[3]))));
    bool good_vert_f32d2_flat_0 = all(lessThanEqual(vert_f32d2_flat_0[gl_InvocationID], f32vec2(max(max(max(pvd.vert_f32d2_flat_0[0], pvd.vert_f32d2_flat_0[1]), pvd.vert_f32d2_flat_0[2]), pvd.vert_f32d2_flat_0[3])))) && all(greaterThanEqual(vert_f32d2_flat_0[gl_InvocationID], f32vec2(min(min(min(pvd.vert_f32d2_flat_0[0], pvd.vert_f32d2_flat_0[1]), pvd.vert_f32d2_flat_0[2]), pvd.vert_f32d2_flat_0[3]))));
    bool good_vert_f32d3_inter_1 = all(lessThanEqual(vert_f32d3_inter_1[gl_InvocationID], f32vec3(max(max(max(pvd.vert_f32d3_inter_1[0], pvd.vert_f32d3_inter_1[1]), pvd.vert_f32d3_inter_1[2]), pvd.vert_f32d3_inter_1[3])))) && all(greaterThanEqual(vert_f32d3_inter_1[gl_InvocationID], f32vec3(min(min(min(pvd.vert_f32d3_inter_1[0], pvd.vert_f32d3_inter_1[1]), pvd.vert_f32d3_inter_1[2]), pvd.vert_f32d3_inter_1[3]))));
    bool good_vert_i32d3_flat_0 = all(lessThanEqual(vert_i32d3_flat_0[gl_InvocationID], i32vec3(max(max(max(pvd.vert_i32d3_flat_0[0], pvd.vert_i32d3_flat_0[1]), pvd.vert_i32d3_flat_0[2]), pvd.vert_i32d3_flat_0[3])))) && all(greaterThanEqual(vert_i32d3_flat_0[gl_InvocationID], i32vec3(min(min(min(pvd.vert_i32d3_flat_0[0], pvd.vert_i32d3_flat_0[1]), pvd.vert_i32d3_flat_0[2]), pvd.vert_i32d3_flat_0[3]))));
    bool good_vert_f32d3_flat_4 = all(lessThanEqual(vert_f32d3_flat_4[gl_InvocationID], f32vec3(max(max(max(pvd.vert_f32d3_flat_4[0], pvd.vert_f32d3_flat_4[1]), pvd.vert_f32d3_flat_4[2]), pvd.vert_f32d3_flat_4[3])))) && all(greaterThanEqual(vert_f32d3_flat_4[gl_InvocationID], f32vec3(min(min(min(pvd.vert_f32d3_flat_4[0], pvd.vert_f32d3_flat_4[1]), pvd.vert_f32d3_flat_4[2]), pvd.vert_f32d3_flat_4[3]))));
    bool good_vert_f16d4_flat_4 = all(lessThanEqual(vert_f16d4_flat_4[gl_InvocationID], f16vec4(max(max(max(pvd.vert_f16d4_flat_4[0], pvd.vert_f16d4_flat_4[1]), pvd.vert_f16d4_flat_4[2]), pvd.vert_f16d4_flat_4[3])))) && all(greaterThanEqual(vert_f16d4_flat_4[gl_InvocationID], f16vec4(min(min(min(pvd.vert_f16d4_flat_4[0], pvd.vert_f16d4_flat_4[1]), pvd.vert_f16d4_flat_4[2]), pvd.vert_f16d4_flat_4[3]))));
    bool good_vert_i32d1_flat_3 = (vert_i32d1_flat_3[gl_InvocationID] <= int32_t(max(max(max(pvd.vert_i32d1_flat_3[0], pvd.vert_i32d1_flat_3[1]), pvd.vert_i32d1_flat_3[2]), pvd.vert_i32d1_flat_3[3]))) && (vert_i32d1_flat_3[gl_InvocationID] >= int32_t(min(min(min(pvd.vert_i32d1_flat_3[0], pvd.vert_i32d1_flat_3[1]), pvd.vert_i32d1_flat_3[2]), pvd.vert_i32d1_flat_3[3])));
    bool good_vert_f16d2_inter_8 = all(lessThanEqual(vert_f16d2_inter_8[gl_InvocationID], f16vec2(max(max(max(pvd.vert_f16d2_inter_8[0], pvd.vert_f16d2_inter_8[1]), pvd.vert_f16d2_inter_8[2]), pvd.vert_f16d2_inter_8[3])))) && all(greaterThanEqual(vert_f16d2_inter_8[gl_InvocationID], f16vec2(min(min(min(pvd.vert_f16d2_inter_8[0], pvd.vert_f16d2_inter_8[1]), pvd.vert_f16d2_inter_8[2]), pvd.vert_f16d2_inter_8[3]))));
    if (good_vert_f32d4_flat_2 && good_vert_i32d4_flat_6 && good_vert_f16d2_flat_2 && good_vert_f16d1_inter_1 && good_vert_f16d1_flat_0 && good_vert_f16d1_flat_5 && good_vert_f32d4_flat_1 && good_vert_f32d3_inter_8 && good_vert_f32d1_inter_1 && good_vert_f16d4_flat_0 && good_vert_f32d3_inter_0 && good_vert_i32d2_flat_0 && good_vert_i32d2_flat_3 && good_vert_f16d2_inter_5 && good_vert_f16d1_inter_6 && good_vert_i32d1_flat_0 && good_vert_f16d1_inter_2 && good_vert_f16d1_flat_9 && good_vert_f16d1_flat_8 && good_vert_f32d2_inter_4 && good_vert_i32d3_flat_7 && good_vert_f32d2_flat_0 && good_vert_f32d3_inter_1 && good_vert_i32d3_flat_0 && good_vert_f32d3_flat_4 && good_vert_f16d4_flat_4 && good_vert_i32d1_flat_3 && good_vert_f16d2_inter_8) {
        outColor[gl_InvocationID] = (gl_PrimitiveID == 0) ? vec4(0.0, 0.0, 1.0, 1.0) : vec4(1.0, 1.0, 0.0, 1.0);
    } else {
        outColor[gl_InvocationID] = vec4(0.0, 0.0, 0.0, 1.0);
    }
   gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
   gl_TessLevelOuter = float[4](1.0, 1.0, 1.0, 1.0);
   gl_TessLevelInner = float[2](1.0, 1.0);

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(quads, equal_spacing) in;

layout(set=0, binding=0, std430) readonly buffer PerVertexBlock {
    vec4 vert_f32d4_flat_2[4];
    ivec4 vert_i32d4_flat_6[4];
    vec2 vert_f16d2_flat_2[4];
    float vert_f16d1_inter_1[4];
    float vert_f16d1_flat_0[4];
    float vert_f16d1_flat_5[4];
    vec4 vert_f32d4_flat_1[4];
    vec3 vert_f32d3_inter_8[4];
    float vert_f32d1_inter_1[4];
    vec4 vert_f16d4_flat_0[4];
    vec3 vert_f32d3_inter_0[4];
    ivec2 vert_i32d2_flat_0[4];
    ivec2 vert_i32d2_flat_3[4];
    vec2 vert_f16d2_inter_5[4];
    float vert_f16d1_inter_6[4];
    int vert_i32d1_flat_0[4];
    float vert_f16d1_inter_2[4];
    float vert_f16d1_flat_9[4];
    float vert_f16d1_flat_8[4];
    vec2 vert_f32d2_inter_4[4];
    ivec3 vert_i32d3_flat_7[4];
    vec2 vert_f32d2_flat_0[4];
    vec3 vert_f32d3_inter_1[4];
    ivec3 vert_i32d3_flat_0[4];
    vec3 vert_f32d3_flat_4[4];
    vec4 vert_f16d4_flat_4[4];
    int vert_i32d1_flat_3[4];
    vec2 vert_f16d2_inter_8[4];
 } pvd;

layout (location=0) in vec4 inColor[];

layout (location=1) in flat f32vec4 vert_f32d4_flat_2[];
layout (location=2) in flat i32vec4 vert_i32d4_flat_6[];
layout (location=3) in flat f16vec2 vert_f16d2_flat_2[];
layout (location=4) in float16_t vert_f16d1_inter_1[];
layout (location=5) in flat float16_t vert_f16d1_flat_0[];
layout (location=6) in flat float16_t vert_f16d1_flat_5[];
layout (location=7) in flat f32vec4 vert_f32d4_flat_1[];
layout (location=8) in f32vec3 vert_f32d3_inter_8[];
layout (location=9) in float32_t vert_f32d1_inter_1[];
layout (location=10) in flat f16vec4 vert_f16d4_flat_0[];
layout (location=11) in f32vec3 vert_f32d3_inter_0[];
layout (location=12) in flat i32vec2 vert_i32d2_flat_0[];
layout (location=13) in flat i32vec2 vert_i32d2_flat_3[];
layout (location=14) in f16vec2 vert_f16d2_inter_5[];
layout (location=15) in float16_t vert_f16d1_inter_6[];
layout (location=16) in flat int32_t vert_i32d1_flat_0[];
layout (location=17) in float16_t vert_f16d1_inter_2[];
layout (location=18) in flat float16_t vert_f16d1_flat_9[];
layout (location=19) in flat float16_t vert_f16d1_flat_8[];
layout (location=20) in f32vec2 vert_f32d2_inter_4[];
layout (location=21) in flat i32vec3 vert_i32d3_flat_7[];
layout (location=22) in flat f32vec2 vert_f32d2_flat_0[];
layout (location=23) in f32vec3 vert_f32d3_inter_1[];
layout (location=24) in flat i32vec3 vert_i32d3_flat_0[];
layout (location=25) in flat f32vec3 vert_f32d3_flat_4[];
layout (location=26) in flat f16vec4 vert_f16d4_flat_4[];
layout (location=27) in flat int32_t vert_i32d1_flat_3[];
layout (location=28) in f16vec2 vert_f16d2_inter_8[];

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
f32vec4 temp_vert_f32d4_flat_2;
INTERP_QUAD_VAR(f32vec4, var_vert_f32d4_flat_2 ,vert_f32d4_flat_2[i], temp_vert_f32d4_flat_2);
    bool good_vert_f32d4_flat_2 = all(lessThanEqual(temp_vert_f32d4_flat_2, f32vec4(max(max(max(pvd.vert_f32d4_flat_2[0], pvd.vert_f32d4_flat_2[1]), pvd.vert_f32d4_flat_2[2]), pvd.vert_f32d4_flat_2[3])))) && all(greaterThanEqual(temp_vert_f32d4_flat_2, f32vec4(min(min(min(pvd.vert_f32d4_flat_2[0], pvd.vert_f32d4_flat_2[1]), pvd.vert_f32d4_flat_2[2]), pvd.vert_f32d4_flat_2[3]))));
i32vec4 temp_vert_i32d4_flat_6;
INTERP_QUAD_VAR(i32vec4, var_vert_i32d4_flat_6 ,vert_i32d4_flat_6[i], temp_vert_i32d4_flat_6);
    bool good_vert_i32d4_flat_6 = all(lessThanEqual(temp_vert_i32d4_flat_6, i32vec4(max(max(max(pvd.vert_i32d4_flat_6[0], pvd.vert_i32d4_flat_6[1]), pvd.vert_i32d4_flat_6[2]), pvd.vert_i32d4_flat_6[3])))) && all(greaterThanEqual(temp_vert_i32d4_flat_6, i32vec4(min(min(min(pvd.vert_i32d4_flat_6[0], pvd.vert_i32d4_flat_6[1]), pvd.vert_i32d4_flat_6[2]), pvd.vert_i32d4_flat_6[3]))));
f16vec2 temp_vert_f16d2_flat_2;
INTERP_QUAD_VAR(f16vec2, var_vert_f16d2_flat_2 ,vert_f16d2_flat_2[i], temp_vert_f16d2_flat_2);
    bool good_vert_f16d2_flat_2 = all(lessThanEqual(temp_vert_f16d2_flat_2, f16vec2(max(max(max(pvd.vert_f16d2_flat_2[0], pvd.vert_f16d2_flat_2[1]), pvd.vert_f16d2_flat_2[2]), pvd.vert_f16d2_flat_2[3])))) && all(greaterThanEqual(temp_vert_f16d2_flat_2, f16vec2(min(min(min(pvd.vert_f16d2_flat_2[0], pvd.vert_f16d2_flat_2[1]), pvd.vert_f16d2_flat_2[2]), pvd.vert_f16d2_flat_2[3]))));
float16_t temp_vert_f16d1_inter_1;
INTERP_QUAD_VAR(float16_t, var_vert_f16d1_inter_1 ,vert_f16d1_inter_1[i], temp_vert_f16d1_inter_1);
    bool good_vert_f16d1_inter_1 = (temp_vert_f16d1_inter_1 <= float16_t(max(max(max(pvd.vert_f16d1_inter_1[0], pvd.vert_f16d1_inter_1[1]), pvd.vert_f16d1_inter_1[2]), pvd.vert_f16d1_inter_1[3]))) && (temp_vert_f16d1_inter_1 >= float16_t(min(min(min(pvd.vert_f16d1_inter_1[0], pvd.vert_f16d1_inter_1[1]), pvd.vert_f16d1_inter_1[2]), pvd.vert_f16d1_inter_1[3])));
float16_t temp_vert_f16d1_flat_0;
INTERP_QUAD_VAR(float16_t, var_vert_f16d1_flat_0 ,vert_f16d1_flat_0[i], temp_vert_f16d1_flat_0);
    bool good_vert_f16d1_flat_0 = (temp_vert_f16d1_flat_0 <= float16_t(max(max(max(pvd.vert_f16d1_flat_0[0], pvd.vert_f16d1_flat_0[1]), pvd.vert_f16d1_flat_0[2]), pvd.vert_f16d1_flat_0[3]))) && (temp_vert_f16d1_flat_0 >= float16_t(min(min(min(pvd.vert_f16d1_flat_0[0], pvd.vert_f16d1_flat_0[1]), pvd.vert_f16d1_flat_0[2]), pvd.vert_f16d1_flat_0[3])));
float16_t temp_vert_f16d1_flat_5;
INTERP_QUAD_VAR(float16_t, var_vert_f16d1_flat_5 ,vert_f16d1_flat_5[i], temp_vert_f16d1_flat_5);
    bool good_vert_f16d1_flat_5 = (temp_vert_f16d1_flat_5 <= float16_t(max(max(max(pvd.vert_f16d1_flat_5[0], pvd.vert_f16d1_flat_5[1]), pvd.vert_f16d1_flat_5[2]), pvd.vert_f16d1_flat_5[3]))) && (temp_vert_f16d1_flat_5 >= float16_t(min(min(min(pvd.vert_f16d1_flat_5[0], pvd.vert_f16d1_flat_5[1]), pvd.vert_f16d1_flat_5[2]), pvd.vert_f16d1_flat_5[3])));
f32vec4 temp_vert_f32d4_flat_1;
INTERP_QUAD_VAR(f32vec4, var_vert_f32d4_flat_1 ,vert_f32d4_flat_1[i], temp_vert_f32d4_flat_1);
    bool good_vert_f32d4_flat_1 = all(lessThanEqual(temp_vert_f32d4_flat_1, f32vec4(max(max(max(pvd.vert_f32d4_flat_1[0], pvd.vert_f32d4_flat_1[1]), pvd.vert_f32d4_flat_1[2]), pvd.vert_f32d4_flat_1[3])))) && all(greaterThanEqual(temp_vert_f32d4_flat_1, f32vec4(min(min(min(pvd.vert_f32d4_flat_1[0], pvd.vert_f32d4_flat_1[1]), pvd.vert_f32d4_flat_1[2]), pvd.vert_f32d4_flat_1[3]))));
f32vec3 temp_vert_f32d3_inter_8;
INTERP_QUAD_VAR(f32vec3, var_vert_f32d3_inter_8 ,vert_f32d3_inter_8[i], temp_vert_f32d3_inter_8);
    bool good_vert_f32d3_inter_8 = all(lessThanEqual(temp_vert_f32d3_inter_8, f32vec3(max(max(max(pvd.vert_f32d3_inter_8[0], pvd.vert_f32d3_inter_8[1]), pvd.vert_f32d3_inter_8[2]), pvd.vert_f32d3_inter_8[3])))) && all(greaterThanEqual(temp_vert_f32d3_inter_8, f32vec3(min(min(min(pvd.vert_f32d3_inter_8[0], pvd.vert_f32d3_inter_8[1]), pvd.vert_f32d3_inter_8[2]), pvd.vert_f32d3_inter_8[3]))));
float32_t temp_vert_f32d1_inter_1;
INTERP_QUAD_VAR(float32_t, var_vert_f32d1_inter_1 ,vert_f32d1_inter_1[i], temp_vert_f32d1_inter_1);
    bool good_vert_f32d1_inter_1 = (temp_vert_f32d1_inter_1 <= float32_t(max(max(max(pvd.vert_f32d1_inter_1[0], pvd.vert_f32d1_inter_1[1]), pvd.vert_f32d1_inter_1[2]), pvd.vert_f32d1_inter_1[3]))) && (temp_vert_f32d1_inter_1 >= float32_t(min(min(min(pvd.vert_f32d1_inter_1[0], pvd.vert_f32d1_inter_1[1]), pvd.vert_f32d1_inter_1[2]), pvd.vert_f32d1_inter_1[3])));
f16vec4 temp_vert_f16d4_flat_0;
INTERP_QUAD_VAR(f16vec4, var_vert_f16d4_flat_0 ,vert_f16d4_flat_0[i], temp_vert_f16d4_flat_0);
    bool good_vert_f16d4_flat_0 = all(lessThanEqual(temp_vert_f16d4_flat_0, f16vec4(max(max(max(pvd.vert_f16d4_flat_0[0], pvd.vert_f16d4_flat_0[1]), pvd.vert_f16d4_flat_0[2]), pvd.vert_f16d4_flat_0[3])))) && all(greaterThanEqual(temp_vert_f16d4_flat_0, f16vec4(min(min(min(pvd.vert_f16d4_flat_0[0], pvd.vert_f16d4_flat_0[1]), pvd.vert_f16d4_flat_0[2]), pvd.vert_f16d4_flat_0[3]))));
f32vec3 temp_vert_f32d3_inter_0;
INTERP_QUAD_VAR(f32vec3, var_vert_f32d3_inter_0 ,vert_f32d3_inter_0[i], temp_vert_f32d3_inter_0);
    bool good_vert_f32d3_inter_0 = all(lessThanEqual(temp_vert_f32d3_inter_0, f32vec3(max(max(max(pvd.vert_f32d3_inter_0[0], pvd.vert_f32d3_inter_0[1]), pvd.vert_f32d3_inter_0[2]), pvd.vert_f32d3_inter_0[3])))) && all(greaterThanEqual(temp_vert_f32d3_inter_0, f32vec3(min(min(min(pvd.vert_f32d3_inter_0[0], pvd.vert_f32d3_inter_0[1]), pvd.vert_f32d3_inter_0[2]), pvd.vert_f32d3_inter_0[3]))));
i32vec2 temp_vert_i32d2_flat_0;
INTERP_QUAD_VAR(i32vec2, var_vert_i32d2_flat_0 ,vert_i32d2_flat_0[i], temp_vert_i32d2_flat_0);
    bool good_vert_i32d2_flat_0 = all(lessThanEqual(temp_vert_i32d2_flat_0, i32vec2(max(max(max(pvd.vert_i32d2_flat_0[0], pvd.vert_i32d2_flat_0[1]), pvd.vert_i32d2_flat_0[2]), pvd.vert_i32d2_flat_0[3])))) && all(greaterThanEqual(temp_vert_i32d2_flat_0, i32vec2(min(min(min(pvd.vert_i32d2_flat_0[0], pvd.vert_i32d2_flat_0[1]), pvd.vert_i32d2_flat_0[2]), pvd.vert_i32d2_flat_0[3]))));
i32vec2 temp_vert_i32d2_flat_3;
INTERP_QUAD_VAR(i32vec2, var_vert_i32d2_flat_3 ,vert_i32d2_flat_3[i], temp_vert_i32d2_flat_3);
    bool good_vert_i32d2_flat_3 = all(lessThanEqual(temp_vert_i32d2_flat_3, i32vec2(max(max(max(pvd.vert_i32d2_flat_3[0], pvd.vert_i32d2_flat_3[1]), pvd.vert_i32d2_flat_3[2]), pvd.vert_i32d2_flat_3[3])))) && all(greaterThanEqual(temp_vert_i32d2_flat_3, i32vec2(min(min(min(pvd.vert_i32d2_flat_3[0], pvd.vert_i32d2_flat_3[1]), pvd.vert_i32d2_flat_3[2]), pvd.vert_i32d2_flat_3[3]))));
f16vec2 temp_vert_f16d2_inter_5;
INTERP_QUAD_VAR(f16vec2, var_vert_f16d2_inter_5 ,vert_f16d2_inter_5[i], temp_vert_f16d2_inter_5);
    bool good_vert_f16d2_inter_5 = all(lessThanEqual(temp_vert_f16d2_inter_5, f16vec2(max(max(max(pvd.vert_f16d2_inter_5[0], pvd.vert_f16d2_inter_5[1]), pvd.vert_f16d2_inter_5[2]), pvd.vert_f16d2_inter_5[3])))) && all(greaterThanEqual(temp_vert_f16d2_inter_5, f16vec2(min(min(min(pvd.vert_f16d2_inter_5[0], pvd.vert_f16d2_inter_5[1]), pvd.vert_f16d2_inter_5[2]), pvd.vert_f16d2_inter_5[3]))));
float16_t temp_vert_f16d1_inter_6;
INTERP_QUAD_VAR(float16_t, var_vert_f16d1_inter_6 ,vert_f16d1_inter_6[i], temp_vert_f16d1_inter_6);
    bool good_vert_f16d1_inter_6 = (temp_vert_f16d1_inter_6 <= float16_t(max(max(max(pvd.vert_f16d1_inter_6[0], pvd.vert_f16d1_inter_6[1]), pvd.vert_f16d1_inter_6[2]), pvd.vert_f16d1_inter_6[3]))) && (temp_vert_f16d1_inter_6 >= float16_t(min(min(min(pvd.vert_f16d1_inter_6[0], pvd.vert_f16d1_inter_6[1]), pvd.vert_f16d1_inter_6[2]), pvd.vert_f16d1_inter_6[3])));
int32_t temp_vert_i32d1_flat_0;
INTERP_QUAD_VAR(int32_t, var_vert_i32d1_flat_0 ,vert_i32d1_flat_0[i], temp_vert_i32d1_flat_0);
    bool good_vert_i32d1_flat_0 = (temp_vert_i32d1_flat_0 <= int32_t(max(max(max(pvd.vert_i32d1_flat_0[0], pvd.vert_i32d1_flat_0[1]), pvd.vert_i32d1_flat_0[2]), pvd.vert_i32d1_flat_0[3]))) && (temp_vert_i32d1_flat_0 >= int32_t(min(min(min(pvd.vert_i32d1_flat_0[0], pvd.vert_i32d1_flat_0[1]), pvd.vert_i32d1_flat_0[2]), pvd.vert_i32d1_flat_0[3])));
float16_t temp_vert_f16d1_inter_2;
INTERP_QUAD_VAR(float16_t, var_vert_f16d1_inter_2 ,vert_f16d1_inter_2[i], temp_vert_f16d1_inter_2);
    bool good_vert_f16d1_inter_2 = (temp_vert_f16d1_inter_2 <= float16_t(max(max(max(pvd.vert_f16d1_inter_2[0], pvd.vert_f16d1_inter_2[1]), pvd.vert_f16d1_inter_2[2]), pvd.vert_f16d1_inter_2[3]))) && (temp_vert_f16d1_inter_2 >= float16_t(min(min(min(pvd.vert_f16d1_inter_2[0], pvd.vert_f16d1_inter_2[1]), pvd.vert_f16d1_inter_2[2]), pvd.vert_f16d1_inter_2[3])));
float16_t temp_vert_f16d1_flat_9;
INTERP_QUAD_VAR(float16_t, var_vert_f16d1_flat_9 ,vert_f16d1_flat_9[i], temp_vert_f16d1_flat_9);
    bool good_vert_f16d1_flat_9 = (temp_vert_f16d1_flat_9 <= float16_t(max(max(max(pvd.vert_f16d1_flat_9[0], pvd.vert_f16d1_flat_9[1]), pvd.vert_f16d1_flat_9[2]), pvd.vert_f16d1_flat_9[3]))) && (temp_vert_f16d1_flat_9 >= float16_t(min(min(min(pvd.vert_f16d1_flat_9[0], pvd.vert_f16d1_flat_9[1]), pvd.vert_f16d1_flat_9[2]), pvd.vert_f16d1_flat_9[3])));
float16_t temp_vert_f16d1_flat_8;
INTERP_QUAD_VAR(float16_t, var_vert_f16d1_flat_8 ,vert_f16d1_flat_8[i], temp_vert_f16d1_flat_8);
    bool good_vert_f16d1_flat_8 = (temp_vert_f16d1_flat_8 <= float16_t(max(max(max(pvd.vert_f16d1_flat_8[0], pvd.vert_f16d1_flat_8[1]), pvd.vert_f16d1_flat_8[2]), pvd.vert_f16d1_flat_8[3]))) && (temp_vert_f16d1_flat_8 >= float16_t(min(min(min(pvd.vert_f16d1_flat_8[0], pvd.vert_f16d1_flat_8[1]), pvd.vert_f16d1_flat_8[2]), pvd.vert_f16d1_flat_8[3])));
f32vec2 temp_vert_f32d2_inter_4;
INTERP_QUAD_VAR(f32vec2, var_vert_f32d2_inter_4 ,vert_f32d2_inter_4[i], temp_vert_f32d2_inter_4);
    bool good_vert_f32d2_inter_4 = all(lessThanEqual(temp_vert_f32d2_inter_4, f32vec2(max(max(max(pvd.vert_f32d2_inter_4[0], pvd.vert_f32d2_inter_4[1]), pvd.vert_f32d2_inter_4[2]), pvd.vert_f32d2_inter_4[3])))) && all(greaterThanEqual(temp_vert_f32d2_inter_4, f32vec2(min(min(min(pvd.vert_f32d2_inter_4[0], pvd.vert_f32d2_inter_4[1]), pvd.vert_f32d2_inter_4[2]), pvd.vert_f32d2_inter_4[3]))));
i32vec3 temp_vert_i32d3_flat_7;
INTERP_QUAD_VAR(i32vec3, var_vert_i32d3_flat_7 ,vert_i32d3_flat_7[i], temp_vert_i32d3_flat_7);
    bool good_vert_i32d3_flat_7 = all(lessThanEqual(temp_vert_i32d3_flat_7, i32vec3(max(max(max(pvd.vert_i32d3_flat_7[0], pvd.vert_i32d3_flat_7[1]), pvd.vert_i32d3_flat_7[2]), pvd.vert_i32d3_flat_7[3])))) && all(greaterThanEqual(temp_vert_i32d3_flat_7, i32vec3(min(min(min(pvd.vert_i32d3_flat_7[0], pvd.vert_i32d3_flat_7[1]), pvd.vert_i32d3_flat_7[2]), pvd.vert_i32d3_flat_7[3]))));
f32vec2 temp_vert_f32d2_flat_0;
INTERP_QUAD_VAR(f32vec2, var_vert_f32d2_flat_0 ,vert_f32d2_flat_0[i], temp_vert_f32d2_flat_0);
    bool good_vert_f32d2_flat_0 = all(lessThanEqual(temp_vert_f32d2_flat_0, f32vec2(max(max(max(pvd.vert_f32d2_flat_0[0], pvd.vert_f32d2_flat_0[1]), pvd.vert_f32d2_flat_0[2]), pvd.vert_f32d2_flat_0[3])))) && all(greaterThanEqual(temp_vert_f32d2_flat_0, f32vec2(min(min(min(pvd.vert_f32d2_flat_0[0], pvd.vert_f32d2_flat_0[1]), pvd.vert_f32d2_flat_0[2]), pvd.vert_f32d2_flat_0[3]))));
f32vec3 temp_vert_f32d3_inter_1;
INTERP_QUAD_VAR(f32vec3, var_vert_f32d3_inter_1 ,vert_f32d3_inter_1[i], temp_vert_f32d3_inter_1);
    bool good_vert_f32d3_inter_1 = all(lessThanEqual(temp_vert_f32d3_inter_1, f32vec3(max(max(max(pvd.vert_f32d3_inter_1[0], pvd.vert_f32d3_inter_1[1]), pvd.vert_f32d3_inter_1[2]), pvd.vert_f32d3_inter_1[3])))) && all(greaterThanEqual(temp_vert_f32d3_inter_1, f32vec3(min(min(min(pvd.vert_f32d3_inter_1[0], pvd.vert_f32d3_inter_1[1]), pvd.vert_f32d3_inter_1[2]), pvd.vert_f32d3_inter_1[3]))));
i32vec3 temp_vert_i32d3_flat_0;
INTERP_QUAD_VAR(i32vec3, var_vert_i32d3_flat_0 ,vert_i32d3_flat_0[i], temp_vert_i32d3_flat_0);
    bool good_vert_i32d3_flat_0 = all(lessThanEqual(temp_vert_i32d3_flat_0, i32vec3(max(max(max(pvd.vert_i32d3_flat_0[0], pvd.vert_i32d3_flat_0[1]), pvd.vert_i32d3_flat_0[2]), pvd.vert_i32d3_flat_0[3])))) && all(greaterThanEqual(temp_vert_i32d3_flat_0, i32vec3(min(min(min(pvd.vert_i32d3_flat_0[0], pvd.vert_i32d3_flat_0[1]), pvd.vert_i32d3_flat_0[2]), pvd.vert_i32d3_flat_0[3]))));
f32vec3 temp_vert_f32d3_flat_4;
INTERP_QUAD_VAR(f32vec3, var_vert_f32d3_flat_4 ,vert_f32d3_flat_4[i], temp_vert_f32d3_flat_4);
    bool good_vert_f32d3_flat_4 = all(lessThanEqual(temp_vert_f32d3_flat_4, f32vec3(max(max(max(pvd.vert_f32d3_flat_4[0], pvd.vert_f32d3_flat_4[1]), pvd.vert_f32d3_flat_4[2]), pvd.vert_f32d3_flat_4[3])))) && all(greaterThanEqual(temp_vert_f32d3_flat_4, f32vec3(min(min(min(pvd.vert_f32d3_flat_4[0], pvd.vert_f32d3_flat_4[1]), pvd.vert_f32d3_flat_4[2]), pvd.vert_f32d3_flat_4[3]))));
f16vec4 temp_vert_f16d4_flat_4;
INTERP_QUAD_VAR(f16vec4, var_vert_f16d4_flat_4 ,vert_f16d4_flat_4[i], temp_vert_f16d4_flat_4);
    bool good_vert_f16d4_flat_4 = all(lessThanEqual(temp_vert_f16d4_flat_4, f16vec4(max(max(max(pvd.vert_f16d4_flat_4[0], pvd.vert_f16d4_flat_4[1]), pvd.vert_f16d4_flat_4[2]), pvd.vert_f16d4_flat_4[3])))) && all(greaterThanEqual(temp_vert_f16d4_flat_4, f16vec4(min(min(min(pvd.vert_f16d4_flat_4[0], pvd.vert_f16d4_flat_4[1]), pvd.vert_f16d4_flat_4[2]), pvd.vert_f16d4_flat_4[3]))));
int32_t temp_vert_i32d1_flat_3;
INTERP_QUAD_VAR(int32_t, var_vert_i32d1_flat_3 ,vert_i32d1_flat_3[i], temp_vert_i32d1_flat_3);
    bool good_vert_i32d1_flat_3 = (temp_vert_i32d1_flat_3 <= int32_t(max(max(max(pvd.vert_i32d1_flat_3[0], pvd.vert_i32d1_flat_3[1]), pvd.vert_i32d1_flat_3[2]), pvd.vert_i32d1_flat_3[3]))) && (temp_vert_i32d1_flat_3 >= int32_t(min(min(min(pvd.vert_i32d1_flat_3[0], pvd.vert_i32d1_flat_3[1]), pvd.vert_i32d1_flat_3[2]), pvd.vert_i32d1_flat_3[3])));
f16vec2 temp_vert_f16d2_inter_8;
INTERP_QUAD_VAR(f16vec2, var_vert_f16d2_inter_8 ,vert_f16d2_inter_8[i], temp_vert_f16d2_inter_8);
    bool good_vert_f16d2_inter_8 = all(lessThanEqual(temp_vert_f16d2_inter_8, f16vec2(max(max(max(pvd.vert_f16d2_inter_8[0], pvd.vert_f16d2_inter_8[1]), pvd.vert_f16d2_inter_8[2]), pvd.vert_f16d2_inter_8[3])))) && all(greaterThanEqual(temp_vert_f16d2_inter_8, f16vec2(min(min(min(pvd.vert_f16d2_inter_8[0], pvd.vert_f16d2_inter_8[1]), pvd.vert_f16d2_inter_8[2]), pvd.vert_f16d2_inter_8[3]))));
    if (good_vert_f32d4_flat_2 && good_vert_i32d4_flat_6 && good_vert_f16d2_flat_2 && good_vert_f16d1_inter_1 && good_vert_f16d1_flat_0 && good_vert_f16d1_flat_5 && good_vert_f32d4_flat_1 && good_vert_f32d3_inter_8 && good_vert_f32d1_inter_1 && good_vert_f16d4_flat_0 && good_vert_f32d3_inter_0 && good_vert_i32d2_flat_0 && good_vert_i32d2_flat_3 && good_vert_f16d2_inter_5 && good_vert_f16d1_inter_6 && good_vert_i32d1_flat_0 && good_vert_f16d1_inter_2 && good_vert_f16d1_flat_9 && good_vert_f16d1_flat_8 && good_vert_f32d2_inter_4 && good_vert_i32d3_flat_7 && good_vert_f32d2_flat_0 && good_vert_f32d3_inter_1 && good_vert_i32d3_flat_0 && good_vert_f32d3_flat_4 && good_vert_f16d4_flat_4 && good_vert_i32d1_flat_3 && good_vert_f16d2_inter_8) {
        INTERP_QUAD_VAR(vec4, var_color, inColor[i], outColor);
    } else {
        outColor = vec4(0.0, 0.0, 0.0, 1.0);
    }
    INTERP_QUAD_VAR(vec4, var_gl_pos, gl_in[i].gl_Position, gl_Position);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(quads, equal_spacing) in;

layout(set=0, binding=0, std430) readonly buffer PerVertexBlock {
    vec4 vert_f32d4_flat_2[4];
    ivec4 vert_i32d4_flat_6[4];
    vec2 vert_f16d2_flat_2[4];
    float vert_f16d1_inter_1[4];
    float vert_f16d1_flat_0[4];
    float vert_f16d1_flat_5[4];
    vec4 vert_f32d4_flat_1[4];
    vec3 vert_f32d3_inter_8[4];
    float vert_f32d1_inter_1[4];
    vec4 vert_f16d4_flat_0[4];
    vec3 vert_f32d3_inter_0[4];
    ivec2 vert_i32d2_flat_0[4];
    ivec2 vert_i32d2_flat_3[4];
    vec2 vert_f16d2_inter_5[4];
    float vert_f16d1_inter_6[4];
    int vert_i32d1_flat_0[4];
    float vert_f16d1_inter_2[4];
    float vert_f16d1_flat_9[4];
    float vert_f16d1_flat_8[4];
    vec2 vert_f32d2_inter_4[4];
    ivec3 vert_i32d3_flat_7[4];
    vec2 vert_f32d2_flat_0[4];
    vec3 vert_f32d3_inter_1[4];
    ivec3 vert_i32d3_flat_0[4];
    vec3 vert_f32d3_flat_4[4];
    vec4 vert_f16d4_flat_4[4];
    int vert_i32d1_flat_3[4];
    vec2 vert_f16d2_inter_8[4];
    vec2 vert_f16d2_flat_8[4];
 } pvd;


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
    outColor = (gl_PrimitiveID == 0) ? vec4(0.0, 0.0, 1.0, 1.0) : vec4(1.0, 1.0, 0.0, 1.0);
    INTERP_QUAD_VAR(vec4, var_gl_pos, gl_in[i].gl_Position, gl_Position);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(quads, equal_spacing) in;

layout(set=0, binding=0, std430) readonly buffer PerVertexBlock {
    vec4 vert_f32d4_flat_2[4];
    ivec4 vert_i32d4_flat_6[4];
    vec2 vert_f16d2_flat_2[4];
    float vert_f16d1_inter_1[4];
    float vert_f16d1_flat_0[4];
    float vert_f16d1_flat_5[4];
    vec4 vert_f32d4_flat_1[4];
    vec3 vert_f32d3_inter_8[4];
    float vert_f32d1_inter_1[4];
    vec4 vert_f16d4_flat_0[4];
    vec3 vert_f32d3_inter_0[4];
    ivec2 vert_i32d2_flat_0[4];
    ivec2 vert_i32d2_flat_3[4];
    vec2 vert_f16d2_inter_5[4];
    float vert_f16d1_inter_6[4];
    int vert_i32d1_flat_0[4];
    float vert_f16d1_inter_2[4];
    float vert_f16d1_flat_9[4];
    float vert_f16d1_flat_8[4];
    vec2 vert_f32d2_inter_4[4];
    ivec3 vert_i32d3_flat_7[4];
    vec2 vert_f32d2_flat_0[4];
    vec3 vert_f32d3_inter_1[4];
    ivec3 vert_i32d3_flat_0[4];
    vec3 vert_f32d3_flat_4[4];
    vec4 vert_f16d4_flat_4[4];
    int vert_i32d1_flat_3[4];
    vec2 vert_f16d2_inter_8[4];
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
#version 450
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_shader_explicit_arithmetic_types : enable

layout (vertices = 4) out;

layout (location=0) out patch f16vec3 patch_f16d3_inter_1;
layout (location=1) out patch f32vec4 patch_f32d4_inter_7;
layout (location=2) out patch float32_t patch_f32d1_inter_3;
layout (location=3) out patch f16vec3 patch_f16d3_inter_8;
layout (location=4) out patch f16vec3 patch_f16d3_inter_5;
layout (location=5) out patch f32vec4 patch_f32d4_inter_9;
layout (location=6) out patch f16vec4 patch_f16d4_inter_6;
layout (location=7) out patch f32vec2 patch_f32d2_inter_4;
layout (location=8) out patch f16vec2 patch_f16d2_inter_9;
layout (location=9) out patch f32vec3 patch_f32d3_inter_3;
layout (location=10) out patch float16_t patch_f16d1_inter_0;
layout (location=11) out patch float16_t patch_f16d1_inter_6;
layout (location=12) out patch f16vec2 patch_f16d2_inter_0;
layout (location=13) out patch f32vec3 patch_f32d3_inter_2;
layout (location=14) out patch f32vec2 patch_f32d2_inter_6;
layout (location=15) out patch f32vec3 patch_f32d3_inter_7;
layout (location=16) out patch f32vec2 patch_f32d2_inter_3;
layout (location=17) out patch float16_t patch_f16d1_inter_1;
layout (location=18) out patch f32vec2 patch_f32d2_inter_0;
layout (location=19) out patch f32vec3 patch_f32d3_inter_0;
layout (location=20) out patch f16vec4 patch_f16d4_inter_3;
layout (location=21) out patch f32vec2 patch_f32d2_inter_8;
layout (location=22) out patch f16vec4 patch_f16d4_inter_2;
layout (location=23) out patch f32vec4 patch_f32d4_inter_0;
layout (location=24) out patch f32vec4 patch_f32d4_inter_2;
layout (location=25) out patch f32vec4 patch_f32d4_inter_6;

layout(set=0, binding=0, std430) readonly buffer PerPatchBlock {
    vec3 patch_f16d3_inter_1[2];
    vec4 patch_f32d4_inter_7[2];
    float patch_f32d1_inter_3[2];
    vec3 patch_f16d3_inter_8[2];
    vec3 patch_f16d3_inter_5[2];
    vec4 patch_f32d4_inter_9[2];
    vec4 patch_f16d4_inter_6[2];
    vec2 patch_f32d2_inter_4[2];
    vec2 patch_f16d2_inter_9[2];
    vec3 patch_f32d3_inter_3[2];
    float patch_f16d1_inter_0[2];
    float patch_f16d1_inter_6[2];
    vec2 patch_f16d2_inter_0[2];
    vec3 patch_f32d3_inter_2[2];
    vec2 patch_f32d2_inter_6[2];
    vec3 patch_f32d3_inter_7[2];
    vec2 patch_f32d2_inter_3[2];
    float patch_f16d1_inter_1[2];
    vec2 patch_f32d2_inter_0[2];
    vec3 patch_f32d3_inter_0[2];
    vec4 patch_f16d4_inter_3[2];
    vec2 patch_f32d2_inter_8[2];
    vec4 patch_f16d4_inter_2[2];
    vec4 patch_f32d4_inter_0[2];
    vec4 patch_f32d4_inter_2[2];
    vec4 patch_f32d4_inter_6[2];
 } ppd;

in gl_PerVertex {
    vec4  gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
} gl_out[];

void main ()
{
    patch_f16d3_inter_1 = f16vec3(ppd.patch_f16d3_inter_1[gl_PrimitiveID]);
    patch_f32d4_inter_7 = f32vec4(ppd.patch_f32d4_inter_7[gl_PrimitiveID]);
    patch_f32d1_inter_3 = float32_t(ppd.patch_f32d1_inter_3[gl_PrimitiveID]);
    patch_f16d3_inter_8 = f16vec3(ppd.patch_f16d3_inter_8[gl_PrimitiveID]);
    patch_f16d3_inter_5 = f16vec3(ppd.patch_f16d3_inter_5[gl_PrimitiveID]);
    patch_f32d4_inter_9 = f32vec4(ppd.patch_f32d4_inter_9[gl_PrimitiveID]);
    patch_f16d4_inter_6 = f16vec4(ppd.patch_f16d4_inter_6[gl_PrimitiveID]);
    patch_f32d2_inter_4 = f32vec2(ppd.patch_f32d2_inter_4[gl_PrimitiveID]);
    patch_f16d2_inter_9 = f16vec2(ppd.patch_f16d2_inter_9[gl_PrimitiveID]);
    patch_f32d3_inter_3 = f32vec3(ppd.patch_f32d3_inter_3[gl_PrimitiveID]);
    patch_f16d1_inter_0 = float16_t(ppd.patch_f16d1_inter_0[gl_PrimitiveID]);
    patch_f16d1_inter_6 = float16_t(ppd.patch_f16d1_inter_6[gl_PrimitiveID]);
    patch_f16d2_inter_0 = f16vec2(ppd.patch_f16d2_inter_0[gl_PrimitiveID]);
    patch_f32d3_inter_2 = f32vec3(ppd.patch_f32d3_inter_2[gl_PrimitiveID]);
    patch_f32d2_inter_6 = f32vec2(ppd.patch_f32d2_inter_6[gl_PrimitiveID]);
    patch_f32d3_inter_7 = f32vec3(ppd.patch_f32d3_inter_7[gl_PrimitiveID]);
    patch_f32d2_inter_3 = f32vec2(ppd.patch_f32d2_inter_3[gl_PrimitiveID]);
    patch_f16d1_inter_1 = float16_t(ppd.patch_f16d1_inter_1[gl_PrimitiveID]);
    patch_f32d2_inter_0 = f32vec2(ppd.patch_f32d2_inter_0[gl_PrimitiveID]);
    patch_f32d3_inter_0 = f32vec3(ppd.patch_f32d3_inter_0[gl_PrimitiveID]);
    patch_f16d4_inter_3 = f16vec4(ppd.patch_f16d4_inter_3[gl_PrimitiveID]);
    patch_f32d2_inter_8 = f32vec2(ppd.patch_f32d2_inter_8[gl_PrimitiveID]);
    patch_f16d4_inter_2 = f16vec4(ppd.patch_f16d4_inter_2[gl_PrimitiveID]);
    patch_f32d4_inter_0 = f32vec4(ppd.patch_f32d4_inter_0[gl_PrimitiveID]);
    patch_f32d4_inter_2 = f32vec4(ppd.patch_f32d4_inter_2[gl_PrimitiveID]);
    patch_f32d4_inter_6 = f32vec4(ppd.patch_f32d4_inter_6[gl_PrimitiveID]);
   gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
   gl_TessLevelOuter = float[4](1.0, 1.0, 1.0, 1.0);
   gl_TessLevelInner = float[2](1.0, 1.0);

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(quads, equal_spacing) in;

layout(set=0, binding=0, std430) readonly buffer PerPatchBlock {
    vec3 patch_f16d3_inter_1[2];
    vec4 patch_f32d4_inter_7[2];
    float patch_f32d1_inter_3[2];
    vec3 patch_f16d3_inter_8[2];
    vec3 patch_f16d3_inter_5[2];
    vec4 patch_f32d4_inter_9[2];
    vec4 patch_f16d4_inter_6[2];
    vec2 patch_f32d2_inter_4[2];
    vec2 patch_f16d2_inter_9[2];
    vec3 patch_f32d3_inter_3[2];
    float patch_f16d1_inter_0[2];
    float patch_f16d1_inter_6[2];
    vec2 patch_f16d2_inter_0[2];
    vec3 patch_f32d3_inter_2[2];
    vec2 patch_f32d2_inter_6[2];
    vec3 patch_f32d3_inter_7[2];
    vec2 patch_f32d2_inter_3[2];
    float patch_f16d1_inter_1[2];
    vec2 patch_f32d2_inter_0[2];
    vec3 patch_f32d3_inter_0[2];
    vec4 patch_f16d4_inter_3[2];
    vec2 patch_f32d2_inter_8[2];
    vec4 patch_f16d4_inter_2[2];
    vec4 patch_f32d4_inter_0[2];
    vec4 patch_f32d4_inter_2[2];
    vec4 patch_f32d4_inter_6[2];
 } ppd;

layout (location=0) in patch f16vec3 patch_f16d3_inter_1;
layout (location=1) in patch f32vec4 patch_f32d4_inter_7;
layout (location=2) in patch float32_t patch_f32d1_inter_3;
layout (location=3) in patch f16vec3 patch_f16d3_inter_8;
layout (location=4) in patch f16vec3 patch_f16d3_inter_5;
layout (location=5) in patch f32vec4 patch_f32d4_inter_9;
layout (location=6) in patch f16vec4 patch_f16d4_inter_6;
layout (location=7) in patch f32vec2 patch_f32d2_inter_4;
layout (location=8) in patch f16vec2 patch_f16d2_inter_9;
layout (location=9) in patch f32vec3 patch_f32d3_inter_3;
layout (location=10) in patch float16_t patch_f16d1_inter_0;
layout (location=11) in patch float16_t patch_f16d1_inter_6;
layout (location=12) in patch f16vec2 patch_f16d2_inter_0;
layout (location=13) in patch f32vec3 patch_f32d3_inter_2;
layout (location=14) in patch f32vec2 patch_f32d2_inter_6;
layout (location=15) in patch f32vec3 patch_f32d3_inter_7;
layout (location=16) in patch f32vec2 patch_f32d2_inter_3;
layout (location=17) in patch float16_t patch_f16d1_inter_1;
layout (location=18) in patch f32vec2 patch_f32d2_inter_0;
layout (location=19) in patch f32vec3 patch_f32d3_inter_0;
layout (location=20) in patch f16vec4 patch_f16d4_inter_3;
layout (location=21) in patch f32vec2 patch_f32d2_inter_8;
layout (location=22) in patch f16vec4 patch_f16d4_inter_2;
layout (location=23) in patch f32vec4 patch_f32d4_inter_0;
layout (location=24) in patch f32vec4 patch_f32d4_inter_2;
layout (location=25) in patch f32vec4 patch_f32d4_inter_6;

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
    bool good_patch_f16d3_inter_1 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d3_inter_1 == ppd.patch_f16d3_inter_1[0]) || (gl_PrimitiveID == 1 && patch_f16d3_inter_1 == ppd.patch_f16d3_inter_1[1])));
    bool good_patch_f32d4_inter_7 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d4_inter_7 == ppd.patch_f32d4_inter_7[0]) || (gl_PrimitiveID == 1 && patch_f32d4_inter_7 == ppd.patch_f32d4_inter_7[1])));
    bool good_patch_f32d1_inter_3 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d1_inter_3 == ppd.patch_f32d1_inter_3[0]) || (gl_PrimitiveID == 1 && patch_f32d1_inter_3 == ppd.patch_f32d1_inter_3[1])));
    bool good_patch_f16d3_inter_8 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d3_inter_8 == ppd.patch_f16d3_inter_8[0]) || (gl_PrimitiveID == 1 && patch_f16d3_inter_8 == ppd.patch_f16d3_inter_8[1])));
    bool good_patch_f16d3_inter_5 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d3_inter_5 == ppd.patch_f16d3_inter_5[0]) || (gl_PrimitiveID == 1 && patch_f16d3_inter_5 == ppd.patch_f16d3_inter_5[1])));
    bool good_patch_f32d4_inter_9 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d4_inter_9 == ppd.patch_f32d4_inter_9[0]) || (gl_PrimitiveID == 1 && patch_f32d4_inter_9 == ppd.patch_f32d4_inter_9[1])));
    bool good_patch_f16d4_inter_6 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d4_inter_6 == ppd.patch_f16d4_inter_6[0]) || (gl_PrimitiveID == 1 && patch_f16d4_inter_6 == ppd.patch_f16d4_inter_6[1])));
    bool good_patch_f32d2_inter_4 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d2_inter_4 == ppd.patch_f32d2_inter_4[0]) || (gl_PrimitiveID == 1 && patch_f32d2_inter_4 == ppd.patch_f32d2_inter_4[1])));
    bool good_patch_f16d2_inter_9 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d2_inter_9 == ppd.patch_f16d2_inter_9[0]) || (gl_PrimitiveID == 1 && patch_f16d2_inter_9 == ppd.patch_f16d2_inter_9[1])));
    bool good_patch_f32d3_inter_3 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d3_inter_3 == ppd.patch_f32d3_inter_3[0]) || (gl_PrimitiveID == 1 && patch_f32d3_inter_3 == ppd.patch_f32d3_inter_3[1])));
    bool good_patch_f16d1_inter_0 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d1_inter_0 == ppd.patch_f16d1_inter_0[0]) || (gl_PrimitiveID == 1 && patch_f16d1_inter_0 == ppd.patch_f16d1_inter_0[1])));
    bool good_patch_f16d1_inter_6 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d1_inter_6 == ppd.patch_f16d1_inter_6[0]) || (gl_PrimitiveID == 1 && patch_f16d1_inter_6 == ppd.patch_f16d1_inter_6[1])));
    bool good_patch_f16d2_inter_0 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d2_inter_0 == ppd.patch_f16d2_inter_0[0]) || (gl_PrimitiveID == 1 && patch_f16d2_inter_0 == ppd.patch_f16d2_inter_0[1])));
    bool good_patch_f32d3_inter_2 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d3_inter_2 == ppd.patch_f32d3_inter_2[0]) || (gl_PrimitiveID == 1 && patch_f32d3_inter_2 == ppd.patch_f32d3_inter_2[1])));
    bool good_patch_f32d2_inter_6 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d2_inter_6 == ppd.patch_f32d2_inter_6[0]) || (gl_PrimitiveID == 1 && patch_f32d2_inter_6 == ppd.patch_f32d2_inter_6[1])));
    bool good_patch_f32d3_inter_7 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d3_inter_7 == ppd.patch_f32d3_inter_7[0]) || (gl_PrimitiveID == 1 && patch_f32d3_inter_7 == ppd.patch_f32d3_inter_7[1])));
    bool good_patch_f32d2_inter_3 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d2_inter_3 == ppd.patch_f32d2_inter_3[0]) || (gl_PrimitiveID == 1 && patch_f32d2_inter_3 == ppd.patch_f32d2_inter_3[1])));
    bool good_patch_f16d1_inter_1 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d1_inter_1 == ppd.patch_f16d1_inter_1[0]) || (gl_PrimitiveID == 1 && patch_f16d1_inter_1 == ppd.patch_f16d1_inter_1[1])));
    bool good_patch_f32d2_inter_0 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d2_inter_0 == ppd.patch_f32d2_inter_0[0]) || (gl_PrimitiveID == 1 && patch_f32d2_inter_0 == ppd.patch_f32d2_inter_0[1])));
    bool good_patch_f32d3_inter_0 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d3_inter_0 == ppd.patch_f32d3_inter_0[0]) || (gl_PrimitiveID == 1 && patch_f32d3_inter_0 == ppd.patch_f32d3_inter_0[1])));
    bool good_patch_f16d4_inter_3 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d4_inter_3 == ppd.patch_f16d4_inter_3[0]) || (gl_PrimitiveID == 1 && patch_f16d4_inter_3 == ppd.patch_f16d4_inter_3[1])));
    bool good_patch_f32d2_inter_8 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d2_inter_8 == ppd.patch_f32d2_inter_8[0]) || (gl_PrimitiveID == 1 && patch_f32d2_inter_8 == ppd.patch_f32d2_inter_8[1])));
    bool good_patch_f16d4_inter_2 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d4_inter_2 == ppd.patch_f16d4_inter_2[0]) || (gl_PrimitiveID == 1 && patch_f16d4_inter_2 == ppd.patch_f16d4_inter_2[1])));
    bool good_patch_f32d4_inter_0 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d4_inter_0 == ppd.patch_f32d4_inter_0[0]) || (gl_PrimitiveID == 1 && patch_f32d4_inter_0 == ppd.patch_f32d4_inter_0[1])));
    bool good_patch_f32d4_inter_2 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d4_inter_2 == ppd.patch_f32d4_inter_2[0]) || (gl_PrimitiveID == 1 && patch_f32d4_inter_2 == ppd.patch_f32d4_inter_2[1])));
    bool good_patch_f32d4_inter_6 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d4_inter_6 == ppd.patch_f32d4_inter_6[0]) || (gl_PrimitiveID == 1 && patch_f32d4_inter_6 == ppd.patch_f32d4_inter_6[1])));
    if (good_patch_f16d3_inter_1 && good_patch_f32d4_inter_7 && good_patch_f32d1_inter_3 && good_patch_f16d3_inter_8 && good_patch_f16d3_inter_5 && good_patch_f32d4_inter_9 && good_patch_f16d4_inter_6 && good_patch_f32d2_inter_4 && good_patch_f16d2_inter_9 && good_patch_f32d3_inter_3 && good_patch_f16d1_inter_0 && good_patch_f16d1_inter_6 && good_patch_f16d2_inter_0 && good_patch_f32d3_inter_2 && good_patch_f32d2_inter_6 && good_patch_f32d3_inter_7 && good_patch_f32d2_inter_3 && good_patch_f16d1_inter_1 && good_patch_f32d2_inter_0 && good_patch_f32d3_inter_0 && good_patch_f16d4_inter_3 && good_patch_f32d2_inter_8 && good_patch_f16d4_inter_2 && good_patch_f32d4_inter_0 && good_patch_f32d4_inter_2 && good_patch_f32d4_inter_6) {
        outColor = (gl_PrimitiveID == 0) ? vec4(0.0, 0.0, 1.0, 1.0) : vec4(1.0, 1.0, 0.0, 1.0);
    } else {
        outColor = vec4(0.0, 0.0, 0.0, 1.0);
    }
    INTERP_QUAD_VAR(vec4, var_gl_pos, gl_in[i].gl_Position, gl_Position);
}
#version 450
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_shader_explicit_arithmetic_types : enable

layout (vertices = 4) out;


layout (location=0) out vec4 outColor[];

layout (location=1) out patch f16vec3 patch_f16d3_inter_1;
layout (location=2) out patch f32vec4 patch_f32d4_inter_7;
layout (location=3) out patch float32_t patch_f32d1_inter_3;
layout (location=4) out patch f16vec3 patch_f16d3_inter_8;
layout (location=5) out patch f16vec3 patch_f16d3_inter_5;
layout (location=6) out patch f32vec4 patch_f32d4_inter_9;
layout (location=7) out patch f16vec4 patch_f16d4_inter_6;
layout (location=8) out patch f32vec2 patch_f32d2_inter_4;
layout (location=9) out patch f16vec2 patch_f16d2_inter_9;
layout (location=10) out patch f32vec3 patch_f32d3_inter_3;
layout (location=11) out patch float16_t patch_f16d1_inter_0;
layout (location=12) out patch float16_t patch_f16d1_inter_6;
layout (location=13) out patch f16vec2 patch_f16d2_inter_0;
layout (location=14) out patch f32vec3 patch_f32d3_inter_2;
layout (location=15) out patch f32vec2 patch_f32d2_inter_6;
layout (location=16) out patch f32vec3 patch_f32d3_inter_7;
layout (location=17) out patch f32vec2 patch_f32d2_inter_3;
layout (location=18) out patch float16_t patch_f16d1_inter_1;
layout (location=19) out patch f32vec2 patch_f32d2_inter_0;
layout (location=20) out patch f32vec3 patch_f32d3_inter_0;
layout (location=21) out patch f16vec4 patch_f16d4_inter_3;
layout (location=22) out patch f32vec2 patch_f32d2_inter_8;
layout (location=23) out patch f16vec4 patch_f16d4_inter_2;
layout (location=24) out patch f32vec4 patch_f32d4_inter_0;
layout (location=25) out patch f32vec4 patch_f32d4_inter_2;
layout (location=26) out patch f32vec4 patch_f32d4_inter_6;

layout(set=0, binding=0, std430) readonly buffer PerPatchBlock {
    vec3 patch_f16d3_inter_1[2];
    vec4 patch_f32d4_inter_7[2];
    float patch_f32d1_inter_3[2];
    vec3 patch_f16d3_inter_8[2];
    vec3 patch_f16d3_inter_5[2];
    vec4 patch_f32d4_inter_9[2];
    vec4 patch_f16d4_inter_6[2];
    vec2 patch_f32d2_inter_4[2];
    vec2 patch_f16d2_inter_9[2];
    vec3 patch_f32d3_inter_3[2];
    float patch_f16d1_inter_0[2];
    float patch_f16d1_inter_6[2];
    vec2 patch_f16d2_inter_0[2];
    vec3 patch_f32d3_inter_2[2];
    vec2 patch_f32d2_inter_6[2];
    vec3 patch_f32d3_inter_7[2];
    vec2 patch_f32d2_inter_3[2];
    float patch_f16d1_inter_1[2];
    vec2 patch_f32d2_inter_0[2];
    vec3 patch_f32d3_inter_0[2];
    vec4 patch_f16d4_inter_3[2];
    vec2 patch_f32d2_inter_8[2];
    vec4 patch_f16d4_inter_2[2];
    vec4 patch_f32d4_inter_0[2];
    vec4 patch_f32d4_inter_2[2];
    vec4 patch_f32d4_inter_6[2];
 } ppd;

in gl_PerVertex {
    vec4  gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
} gl_out[];

void main ()
{
    patch_f16d3_inter_1 = f16vec3(ppd.patch_f16d3_inter_1[gl_PrimitiveID]);
    patch_f32d4_inter_7 = f32vec4(ppd.patch_f32d4_inter_7[gl_PrimitiveID]);
    patch_f32d1_inter_3 = float32_t(ppd.patch_f32d1_inter_3[gl_PrimitiveID]);
    patch_f16d3_inter_8 = f16vec3(ppd.patch_f16d3_inter_8[gl_PrimitiveID]);
    patch_f16d3_inter_5 = f16vec3(ppd.patch_f16d3_inter_5[gl_PrimitiveID]);
    patch_f32d4_inter_9 = f32vec4(ppd.patch_f32d4_inter_9[gl_PrimitiveID]);
    patch_f16d4_inter_6 = f16vec4(ppd.patch_f16d4_inter_6[gl_PrimitiveID]);
    patch_f32d2_inter_4 = f32vec2(ppd.patch_f32d2_inter_4[gl_PrimitiveID]);
    patch_f16d2_inter_9 = f16vec2(ppd.patch_f16d2_inter_9[gl_PrimitiveID]);
    patch_f32d3_inter_3 = f32vec3(ppd.patch_f32d3_inter_3[gl_PrimitiveID]);
    patch_f16d1_inter_0 = float16_t(ppd.patch_f16d1_inter_0[gl_PrimitiveID]);
    patch_f16d1_inter_6 = float16_t(ppd.patch_f16d1_inter_6[gl_PrimitiveID]);
    patch_f16d2_inter_0 = f16vec2(ppd.patch_f16d2_inter_0[gl_PrimitiveID]);
    patch_f32d3_inter_2 = f32vec3(ppd.patch_f32d3_inter_2[gl_PrimitiveID]);
    patch_f32d2_inter_6 = f32vec2(ppd.patch_f32d2_inter_6[gl_PrimitiveID]);
    patch_f32d3_inter_7 = f32vec3(ppd.patch_f32d3_inter_7[gl_PrimitiveID]);
    patch_f32d2_inter_3 = f32vec2(ppd.patch_f32d2_inter_3[gl_PrimitiveID]);
    patch_f16d1_inter_1 = float16_t(ppd.patch_f16d1_inter_1[gl_PrimitiveID]);
    patch_f32d2_inter_0 = f32vec2(ppd.patch_f32d2_inter_0[gl_PrimitiveID]);
    patch_f32d3_inter_0 = f32vec3(ppd.patch_f32d3_inter_0[gl_PrimitiveID]);
    patch_f16d4_inter_3 = f16vec4(ppd.patch_f16d4_inter_3[gl_PrimitiveID]);
    patch_f32d2_inter_8 = f32vec2(ppd.patch_f32d2_inter_8[gl_PrimitiveID]);
    patch_f16d4_inter_2 = f16vec4(ppd.patch_f16d4_inter_2[gl_PrimitiveID]);
    patch_f32d4_inter_0 = f32vec4(ppd.patch_f32d4_inter_0[gl_PrimitiveID]);
    patch_f32d4_inter_2 = f32vec4(ppd.patch_f32d4_inter_2[gl_PrimitiveID]);
    patch_f32d4_inter_6 = f32vec4(ppd.patch_f32d4_inter_6[gl_PrimitiveID]);
    bool good_patch_f16d3_inter_1 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d3_inter_1 == ppd.patch_f16d3_inter_1[0]) || (gl_PrimitiveID == 1 && patch_f16d3_inter_1 == ppd.patch_f16d3_inter_1[1])));
    bool good_patch_f32d4_inter_7 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d4_inter_7 == ppd.patch_f32d4_inter_7[0]) || (gl_PrimitiveID == 1 && patch_f32d4_inter_7 == ppd.patch_f32d4_inter_7[1])));
    bool good_patch_f32d1_inter_3 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d1_inter_3 == ppd.patch_f32d1_inter_3[0]) || (gl_PrimitiveID == 1 && patch_f32d1_inter_3 == ppd.patch_f32d1_inter_3[1])));
    bool good_patch_f16d3_inter_8 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d3_inter_8 == ppd.patch_f16d3_inter_8[0]) || (gl_PrimitiveID == 1 && patch_f16d3_inter_8 == ppd.patch_f16d3_inter_8[1])));
    bool good_patch_f16d3_inter_5 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d3_inter_5 == ppd.patch_f16d3_inter_5[0]) || (gl_PrimitiveID == 1 && patch_f16d3_inter_5 == ppd.patch_f16d3_inter_5[1])));
    bool good_patch_f32d4_inter_9 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d4_inter_9 == ppd.patch_f32d4_inter_9[0]) || (gl_PrimitiveID == 1 && patch_f32d4_inter_9 == ppd.patch_f32d4_inter_9[1])));
    bool good_patch_f16d4_inter_6 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d4_inter_6 == ppd.patch_f16d4_inter_6[0]) || (gl_PrimitiveID == 1 && patch_f16d4_inter_6 == ppd.patch_f16d4_inter_6[1])));
    bool good_patch_f32d2_inter_4 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d2_inter_4 == ppd.patch_f32d2_inter_4[0]) || (gl_PrimitiveID == 1 && patch_f32d2_inter_4 == ppd.patch_f32d2_inter_4[1])));
    bool good_patch_f16d2_inter_9 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d2_inter_9 == ppd.patch_f16d2_inter_9[0]) || (gl_PrimitiveID == 1 && patch_f16d2_inter_9 == ppd.patch_f16d2_inter_9[1])));
    bool good_patch_f32d3_inter_3 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d3_inter_3 == ppd.patch_f32d3_inter_3[0]) || (gl_PrimitiveID == 1 && patch_f32d3_inter_3 == ppd.patch_f32d3_inter_3[1])));
    bool good_patch_f16d1_inter_0 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d1_inter_0 == ppd.patch_f16d1_inter_0[0]) || (gl_PrimitiveID == 1 && patch_f16d1_inter_0 == ppd.patch_f16d1_inter_0[1])));
    bool good_patch_f16d1_inter_6 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d1_inter_6 == ppd.patch_f16d1_inter_6[0]) || (gl_PrimitiveID == 1 && patch_f16d1_inter_6 == ppd.patch_f16d1_inter_6[1])));
    bool good_patch_f16d2_inter_0 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d2_inter_0 == ppd.patch_f16d2_inter_0[0]) || (gl_PrimitiveID == 1 && patch_f16d2_inter_0 == ppd.patch_f16d2_inter_0[1])));
    bool good_patch_f32d3_inter_2 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d3_inter_2 == ppd.patch_f32d3_inter_2[0]) || (gl_PrimitiveID == 1 && patch_f32d3_inter_2 == ppd.patch_f32d3_inter_2[1])));
    bool good_patch_f32d2_inter_6 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d2_inter_6 == ppd.patch_f32d2_inter_6[0]) || (gl_PrimitiveID == 1 && patch_f32d2_inter_6 == ppd.patch_f32d2_inter_6[1])));
    bool good_patch_f32d3_inter_7 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d3_inter_7 == ppd.patch_f32d3_inter_7[0]) || (gl_PrimitiveID == 1 && patch_f32d3_inter_7 == ppd.patch_f32d3_inter_7[1])));
    bool good_patch_f32d2_inter_3 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d2_inter_3 == ppd.patch_f32d2_inter_3[0]) || (gl_PrimitiveID == 1 && patch_f32d2_inter_3 == ppd.patch_f32d2_inter_3[1])));
    bool good_patch_f16d1_inter_1 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d1_inter_1 == ppd.patch_f16d1_inter_1[0]) || (gl_PrimitiveID == 1 && patch_f16d1_inter_1 == ppd.patch_f16d1_inter_1[1])));
    bool good_patch_f32d2_inter_0 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d2_inter_0 == ppd.patch_f32d2_inter_0[0]) || (gl_PrimitiveID == 1 && patch_f32d2_inter_0 == ppd.patch_f32d2_inter_0[1])));
    bool good_patch_f32d3_inter_0 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d3_inter_0 == ppd.patch_f32d3_inter_0[0]) || (gl_PrimitiveID == 1 && patch_f32d3_inter_0 == ppd.patch_f32d3_inter_0[1])));
    bool good_patch_f16d4_inter_3 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d4_inter_3 == ppd.patch_f16d4_inter_3[0]) || (gl_PrimitiveID == 1 && patch_f16d4_inter_3 == ppd.patch_f16d4_inter_3[1])));
    bool good_patch_f32d2_inter_8 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d2_inter_8 == ppd.patch_f32d2_inter_8[0]) || (gl_PrimitiveID == 1 && patch_f32d2_inter_8 == ppd.patch_f32d2_inter_8[1])));
    bool good_patch_f16d4_inter_2 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d4_inter_2 == ppd.patch_f16d4_inter_2[0]) || (gl_PrimitiveID == 1 && patch_f16d4_inter_2 == ppd.patch_f16d4_inter_2[1])));
    bool good_patch_f32d4_inter_0 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d4_inter_0 == ppd.patch_f32d4_inter_0[0]) || (gl_PrimitiveID == 1 && patch_f32d4_inter_0 == ppd.patch_f32d4_inter_0[1])));
    bool good_patch_f32d4_inter_2 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d4_inter_2 == ppd.patch_f32d4_inter_2[0]) || (gl_PrimitiveID == 1 && patch_f32d4_inter_2 == ppd.patch_f32d4_inter_2[1])));
    bool good_patch_f32d4_inter_6 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d4_inter_6 == ppd.patch_f32d4_inter_6[0]) || (gl_PrimitiveID == 1 && patch_f32d4_inter_6 == ppd.patch_f32d4_inter_6[1])));
    if (good_patch_f16d3_inter_1 && good_patch_f32d4_inter_7 && good_patch_f32d1_inter_3 && good_patch_f16d3_inter_8 && good_patch_f16d3_inter_5 && good_patch_f32d4_inter_9 && good_patch_f16d4_inter_6 && good_patch_f32d2_inter_4 && good_patch_f16d2_inter_9 && good_patch_f32d3_inter_3 && good_patch_f16d1_inter_0 && good_patch_f16d1_inter_6 && good_patch_f16d2_inter_0 && good_patch_f32d3_inter_2 && good_patch_f32d2_inter_6 && good_patch_f32d3_inter_7 && good_patch_f32d2_inter_3 && good_patch_f16d1_inter_1 && good_patch_f32d2_inter_0 && good_patch_f32d3_inter_0 && good_patch_f16d4_inter_3 && good_patch_f32d2_inter_8 && good_patch_f16d4_inter_2 && good_patch_f32d4_inter_0 && good_patch_f32d4_inter_2 && good_patch_f32d4_inter_6) {
        outColor[gl_InvocationID] = (gl_PrimitiveID == 0) ? vec4(0.0, 0.0, 1.0, 1.0) : vec4(1.0, 1.0, 0.0, 1.0);
    } else {
        outColor[gl_InvocationID] = vec4(0.0, 0.0, 0.0, 1.0);
    }
   gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
   gl_TessLevelOuter = float[4](1.0, 1.0, 1.0, 1.0);
   gl_TessLevelInner = float[2](1.0, 1.0);

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(quads, equal_spacing) in;

layout(set=0, binding=0, std430) readonly buffer PerPatchBlock {
    vec3 patch_f16d3_inter_1[2];
    vec4 patch_f32d4_inter_7[2];
    float patch_f32d1_inter_3[2];
    vec3 patch_f16d3_inter_8[2];
    vec3 patch_f16d3_inter_5[2];
    vec4 patch_f32d4_inter_9[2];
    vec4 patch_f16d4_inter_6[2];
    vec2 patch_f32d2_inter_4[2];
    vec2 patch_f16d2_inter_9[2];
    vec3 patch_f32d3_inter_3[2];
    float patch_f16d1_inter_0[2];
    float patch_f16d1_inter_6[2];
    vec2 patch_f16d2_inter_0[2];
    vec3 patch_f32d3_inter_2[2];
    vec2 patch_f32d2_inter_6[2];
    vec3 patch_f32d3_inter_7[2];
    vec2 patch_f32d2_inter_3[2];
    float patch_f16d1_inter_1[2];
    vec2 patch_f32d2_inter_0[2];
    vec3 patch_f32d3_inter_0[2];
    vec4 patch_f16d4_inter_3[2];
    vec2 patch_f32d2_inter_8[2];
    vec4 patch_f16d4_inter_2[2];
    vec4 patch_f32d4_inter_0[2];
    vec4 patch_f32d4_inter_2[2];
    vec4 patch_f32d4_inter_6[2];
 } ppd;

layout (location=0) in vec4 inColor[];

layout (location=1) in patch f16vec3 patch_f16d3_inter_1;
layout (location=2) in patch f32vec4 patch_f32d4_inter_7;
layout (location=3) in patch float32_t patch_f32d1_inter_3;
layout (location=4) in patch f16vec3 patch_f16d3_inter_8;
layout (location=5) in patch f16vec3 patch_f16d3_inter_5;
layout (location=6) in patch f32vec4 patch_f32d4_inter_9;
layout (location=7) in patch f16vec4 patch_f16d4_inter_6;
layout (location=8) in patch f32vec2 patch_f32d2_inter_4;
layout (location=9) in patch f16vec2 patch_f16d2_inter_9;
layout (location=10) in patch f32vec3 patch_f32d3_inter_3;
layout (location=11) in patch float16_t patch_f16d1_inter_0;
layout (location=12) in patch float16_t patch_f16d1_inter_6;
layout (location=13) in patch f16vec2 patch_f16d2_inter_0;
layout (location=14) in patch f32vec3 patch_f32d3_inter_2;
layout (location=15) in patch f32vec2 patch_f32d2_inter_6;
layout (location=16) in patch f32vec3 patch_f32d3_inter_7;
layout (location=17) in patch f32vec2 patch_f32d2_inter_3;
layout (location=18) in patch float16_t patch_f16d1_inter_1;
layout (location=19) in patch f32vec2 patch_f32d2_inter_0;
layout (location=20) in patch f32vec3 patch_f32d3_inter_0;
layout (location=21) in patch f16vec4 patch_f16d4_inter_3;
layout (location=22) in patch f32vec2 patch_f32d2_inter_8;
layout (location=23) in patch f16vec4 patch_f16d4_inter_2;
layout (location=24) in patch f32vec4 patch_f32d4_inter_0;
layout (location=25) in patch f32vec4 patch_f32d4_inter_2;
layout (location=26) in patch f32vec4 patch_f32d4_inter_6;

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
    bool good_patch_f16d3_inter_1 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d3_inter_1 == ppd.patch_f16d3_inter_1[0]) || (gl_PrimitiveID == 1 && patch_f16d3_inter_1 == ppd.patch_f16d3_inter_1[1])));
    bool good_patch_f32d4_inter_7 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d4_inter_7 == ppd.patch_f32d4_inter_7[0]) || (gl_PrimitiveID == 1 && patch_f32d4_inter_7 == ppd.patch_f32d4_inter_7[1])));
    bool good_patch_f32d1_inter_3 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d1_inter_3 == ppd.patch_f32d1_inter_3[0]) || (gl_PrimitiveID == 1 && patch_f32d1_inter_3 == ppd.patch_f32d1_inter_3[1])));
    bool good_patch_f16d3_inter_8 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d3_inter_8 == ppd.patch_f16d3_inter_8[0]) || (gl_PrimitiveID == 1 && patch_f16d3_inter_8 == ppd.patch_f16d3_inter_8[1])));
    bool good_patch_f16d3_inter_5 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d3_inter_5 == ppd.patch_f16d3_inter_5[0]) || (gl_PrimitiveID == 1 && patch_f16d3_inter_5 == ppd.patch_f16d3_inter_5[1])));
    bool good_patch_f32d4_inter_9 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d4_inter_9 == ppd.patch_f32d4_inter_9[0]) || (gl_PrimitiveID == 1 && patch_f32d4_inter_9 == ppd.patch_f32d4_inter_9[1])));
    bool good_patch_f16d4_inter_6 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d4_inter_6 == ppd.patch_f16d4_inter_6[0]) || (gl_PrimitiveID == 1 && patch_f16d4_inter_6 == ppd.patch_f16d4_inter_6[1])));
    bool good_patch_f32d2_inter_4 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d2_inter_4 == ppd.patch_f32d2_inter_4[0]) || (gl_PrimitiveID == 1 && patch_f32d2_inter_4 == ppd.patch_f32d2_inter_4[1])));
    bool good_patch_f16d2_inter_9 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d2_inter_9 == ppd.patch_f16d2_inter_9[0]) || (gl_PrimitiveID == 1 && patch_f16d2_inter_9 == ppd.patch_f16d2_inter_9[1])));
    bool good_patch_f32d3_inter_3 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d3_inter_3 == ppd.patch_f32d3_inter_3[0]) || (gl_PrimitiveID == 1 && patch_f32d3_inter_3 == ppd.patch_f32d3_inter_3[1])));
    bool good_patch_f16d1_inter_0 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d1_inter_0 == ppd.patch_f16d1_inter_0[0]) || (gl_PrimitiveID == 1 && patch_f16d1_inter_0 == ppd.patch_f16d1_inter_0[1])));
    bool good_patch_f16d1_inter_6 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d1_inter_6 == ppd.patch_f16d1_inter_6[0]) || (gl_PrimitiveID == 1 && patch_f16d1_inter_6 == ppd.patch_f16d1_inter_6[1])));
    bool good_patch_f16d2_inter_0 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d2_inter_0 == ppd.patch_f16d2_inter_0[0]) || (gl_PrimitiveID == 1 && patch_f16d2_inter_0 == ppd.patch_f16d2_inter_0[1])));
    bool good_patch_f32d3_inter_2 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d3_inter_2 == ppd.patch_f32d3_inter_2[0]) || (gl_PrimitiveID == 1 && patch_f32d3_inter_2 == ppd.patch_f32d3_inter_2[1])));
    bool good_patch_f32d2_inter_6 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d2_inter_6 == ppd.patch_f32d2_inter_6[0]) || (gl_PrimitiveID == 1 && patch_f32d2_inter_6 == ppd.patch_f32d2_inter_6[1])));
    bool good_patch_f32d3_inter_7 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d3_inter_7 == ppd.patch_f32d3_inter_7[0]) || (gl_PrimitiveID == 1 && patch_f32d3_inter_7 == ppd.patch_f32d3_inter_7[1])));
    bool good_patch_f32d2_inter_3 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d2_inter_3 == ppd.patch_f32d2_inter_3[0]) || (gl_PrimitiveID == 1 && patch_f32d2_inter_3 == ppd.patch_f32d2_inter_3[1])));
    bool good_patch_f16d1_inter_1 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d1_inter_1 == ppd.patch_f16d1_inter_1[0]) || (gl_PrimitiveID == 1 && patch_f16d1_inter_1 == ppd.patch_f16d1_inter_1[1])));
    bool good_patch_f32d2_inter_0 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d2_inter_0 == ppd.patch_f32d2_inter_0[0]) || (gl_PrimitiveID == 1 && patch_f32d2_inter_0 == ppd.patch_f32d2_inter_0[1])));
    bool good_patch_f32d3_inter_0 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d3_inter_0 == ppd.patch_f32d3_inter_0[0]) || (gl_PrimitiveID == 1 && patch_f32d3_inter_0 == ppd.patch_f32d3_inter_0[1])));
    bool good_patch_f16d4_inter_3 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d4_inter_3 == ppd.patch_f16d4_inter_3[0]) || (gl_PrimitiveID == 1 && patch_f16d4_inter_3 == ppd.patch_f16d4_inter_3[1])));
    bool good_patch_f32d2_inter_8 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d2_inter_8 == ppd.patch_f32d2_inter_8[0]) || (gl_PrimitiveID == 1 && patch_f32d2_inter_8 == ppd.patch_f32d2_inter_8[1])));
    bool good_patch_f16d4_inter_2 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d4_inter_2 == ppd.patch_f16d4_inter_2[0]) || (gl_PrimitiveID == 1 && patch_f16d4_inter_2 == ppd.patch_f16d4_inter_2[1])));
    bool good_patch_f32d4_inter_0 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d4_inter_0 == ppd.patch_f32d4_inter_0[0]) || (gl_PrimitiveID == 1 && patch_f32d4_inter_0 == ppd.patch_f32d4_inter_0[1])));
    bool good_patch_f32d4_inter_2 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d4_inter_2 == ppd.patch_f32d4_inter_2[0]) || (gl_PrimitiveID == 1 && patch_f32d4_inter_2 == ppd.patch_f32d4_inter_2[1])));
    bool good_patch_f32d4_inter_6 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d4_inter_6 == ppd.patch_f32d4_inter_6[0]) || (gl_PrimitiveID == 1 && patch_f32d4_inter_6 == ppd.patch_f32d4_inter_6[1])));
    if (good_patch_f16d3_inter_1 && good_patch_f32d4_inter_7 && good_patch_f32d1_inter_3 && good_patch_f16d3_inter_8 && good_patch_f16d3_inter_5 && good_patch_f32d4_inter_9 && good_patch_f16d4_inter_6 && good_patch_f32d2_inter_4 && good_patch_f16d2_inter_9 && good_patch_f32d3_inter_3 && good_patch_f16d1_inter_0 && good_patch_f16d1_inter_6 && good_patch_f16d2_inter_0 && good_patch_f32d3_inter_2 && good_patch_f32d2_inter_6 && good_patch_f32d3_inter_7 && good_patch_f32d2_inter_3 && good_patch_f16d1_inter_1 && good_patch_f32d2_inter_0 && good_patch_f32d3_inter_0 && good_patch_f16d4_inter_3 && good_patch_f32d2_inter_8 && good_patch_f16d4_inter_2 && good_patch_f32d4_inter_0 && good_patch_f32d4_inter_2 && good_patch_f32d4_inter_6) {
        INTERP_QUAD_VAR(vec4, var_color, inColor[i], outColor);
    } else {
        outColor = vec4(0.0, 0.0, 0.0, 1.0);
    }
    INTERP_QUAD_VAR(vec4, var_gl_pos, gl_in[i].gl_Position, gl_Position);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(quads, equal_spacing) in;

layout(set=0, binding=0, std430) readonly buffer PerPatchBlock {
    vec3 patch_f16d3_inter_1[2];
    vec4 patch_f32d4_inter_7[2];
    float patch_f32d1_inter_3[2];
    vec3 patch_f16d3_inter_8[2];
    vec3 patch_f16d3_inter_5[2];
    vec4 patch_f32d4_inter_9[2];
    vec4 patch_f16d4_inter_6[2];
    vec2 patch_f32d2_inter_4[2];
    vec2 patch_f16d2_inter_9[2];
    vec3 patch_f32d3_inter_3[2];
    float patch_f16d1_inter_0[2];
    float patch_f16d1_inter_6[2];
    vec2 patch_f16d2_inter_0[2];
    vec3 patch_f32d3_inter_2[2];
    vec2 patch_f32d2_inter_6[2];
    vec3 patch_f32d3_inter_7[2];
    vec2 patch_f32d2_inter_3[2];
    float patch_f16d1_inter_1[2];
    vec2 patch_f32d2_inter_0[2];
    vec3 patch_f32d3_inter_0[2];
    vec4 patch_f16d4_inter_3[2];
    vec2 patch_f32d2_inter_8[2];
    vec4 patch_f16d4_inter_2[2];
    vec4 patch_f32d4_inter_0[2];
    vec4 patch_f32d4_inter_2[2];
    vec4 patch_f32d4_inter_6[2];
 } ppd;


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
    outColor = (gl_PrimitiveID == 0) ? vec4(0.0, 0.0, 1.0, 1.0) : vec4(1.0, 1.0, 0.0, 1.0);
    INTERP_QUAD_VAR(vec4, var_gl_pos, gl_in[i].gl_Position, gl_Position);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(quads, equal_spacing) in;

layout(set=0, binding=0, std430) readonly buffer PerPatchBlock {
    vec3 patch_f16d3_inter_1[2];
    vec4 patch_f32d4_inter_7[2];
    float patch_f32d1_inter_3[2];
    vec3 patch_f16d3_inter_8[2];
    vec3 patch_f16d3_inter_5[2];
    vec4 patch_f32d4_inter_9[2];
    vec4 patch_f16d4_inter_6[2];
    vec2 patch_f32d2_inter_4[2];
    vec2 patch_f16d2_inter_9[2];
    vec3 patch_f32d3_inter_3[2];
    float patch_f16d1_inter_0[2];
    float patch_f16d1_inter_6[2];
    vec2 patch_f16d2_inter_0[2];
    vec3 patch_f32d3_inter_2[2];
    vec2 patch_f32d2_inter_6[2];
    vec3 patch_f32d3_inter_7[2];
    vec2 patch_f32d2_inter_3[2];
    float patch_f16d1_inter_1[2];
    vec2 patch_f32d2_inter_0[2];
    vec3 patch_f32d3_inter_0[2];
    vec4 patch_f16d4_inter_3[2];
    vec2 patch_f32d2_inter_8[2];
    vec4 patch_f16d4_inter_2[2];
    vec4 patch_f32d4_inter_0[2];
    vec4 patch_f32d4_inter_2[2];
    vec4 patch_f32d4_inter_6[2];
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
