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

layout (location=0) out flat i64vec4 vert_i64d4_flat_7[];
layout (location=2) out flat float64_t vert_f64d1_flat_8[];
layout (location=3) out flat f64vec2 vert_f64d2_flat_0[];
layout (location=4) out flat i16vec4 vert_i16d4_flat_6[];
layout (location=5) out flat f16vec3 vert_f16d3_flat_7[];
layout (location=6) out flat f32vec3 vert_f32d3_flat_7[];
layout (location=7) out f16vec3 vert_f16d3_inter_0[];
layout (location=8) out flat f32vec2 vert_f32d2_flat_6[];
layout (location=9) out f32vec2 vert_f32d2_inter_6[];
layout (location=10) out flat f16vec4 vert_f16d4_flat_6[];
layout (location=11) out f32vec3 vert_f32d3_inter_7[];
layout (location=12) out flat int64_t vert_i64d1_flat_3[];
layout (location=13) out flat i64vec2 vert_i64d2_flat_8[];
layout (location=14) out f16vec2 vert_f16d2_inter_7[];
layout (location=15) out flat f16vec2 vert_f16d2_flat_7[];
layout (location=16) out flat f64vec3 vert_f64d3_flat_6[];
layout (location=18) out flat i32vec4 vert_i32d4_flat_6[];
layout (location=19) out flat f32vec4 vert_f32d4_flat_0[];
layout (location=20) out f16vec3 vert_f16d3_inter_3[];
layout (location=21) out flat i16vec4 vert_i16d4_flat_3[];
layout (location=22) out flat f32vec4 vert_f32d4_flat_2[];
layout (location=23) out flat f16vec3 vert_f16d3_flat_6[];
layout (location=24) out flat float16_t vert_f16d1_flat_7[];
layout (location=25) out flat f32vec2 vert_f32d2_flat_0[];
layout (location=26) out flat f32vec4 vert_f32d4_flat_7[];
layout (location=27) out flat i16vec2 vert_i16d2_flat_0[];
layout (location=28) out flat int64_t vert_i64d1_flat_1[];

layout(set=0, binding=0, std430) readonly buffer PerVertexBlock {
    ivec4 vert_i64d4_flat_7[4];
    float vert_f64d1_flat_8[4];
    vec2 vert_f64d2_flat_0[4];
    ivec4 vert_i16d4_flat_6[4];
    vec3 vert_f16d3_flat_7[4];
    vec3 vert_f32d3_flat_7[4];
    vec3 vert_f16d3_inter_0[4];
    vec2 vert_f32d2_flat_6[4];
    vec2 vert_f32d2_inter_6[4];
    vec4 vert_f16d4_flat_6[4];
    vec3 vert_f32d3_inter_7[4];
    int vert_i64d1_flat_3[4];
    ivec2 vert_i64d2_flat_8[4];
    vec2 vert_f16d2_inter_7[4];
    vec2 vert_f16d2_flat_7[4];
    vec3 vert_f64d3_flat_6[4];
    ivec4 vert_i32d4_flat_6[4];
    vec4 vert_f32d4_flat_0[4];
    vec3 vert_f16d3_inter_3[4];
    ivec4 vert_i16d4_flat_3[4];
    vec4 vert_f32d4_flat_2[4];
    vec3 vert_f16d3_flat_6[4];
    float vert_f16d1_flat_7[4];
    vec2 vert_f32d2_flat_0[4];
    vec4 vert_f32d4_flat_7[4];
    ivec2 vert_i16d2_flat_0[4];
    int vert_i64d1_flat_1[4];
 } pvd;

in gl_PerVertex {
    vec4  gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
} gl_out[];

void main ()
{
    vert_i64d4_flat_7[gl_InvocationID] = i64vec4(pvd.vert_i64d4_flat_7[gl_InvocationID]);
    vert_f64d1_flat_8[gl_InvocationID] = float64_t(pvd.vert_f64d1_flat_8[gl_InvocationID]);
    vert_f64d2_flat_0[gl_InvocationID] = f64vec2(pvd.vert_f64d2_flat_0[gl_InvocationID]);
    vert_i16d4_flat_6[gl_InvocationID] = i16vec4(pvd.vert_i16d4_flat_6[gl_InvocationID]);
    vert_f16d3_flat_7[gl_InvocationID] = f16vec3(pvd.vert_f16d3_flat_7[gl_InvocationID]);
    vert_f32d3_flat_7[gl_InvocationID] = f32vec3(pvd.vert_f32d3_flat_7[gl_InvocationID]);
    vert_f16d3_inter_0[gl_InvocationID] = f16vec3(pvd.vert_f16d3_inter_0[gl_InvocationID]);
    vert_f32d2_flat_6[gl_InvocationID] = f32vec2(pvd.vert_f32d2_flat_6[gl_InvocationID]);
    vert_f32d2_inter_6[gl_InvocationID] = f32vec2(pvd.vert_f32d2_inter_6[gl_InvocationID]);
    vert_f16d4_flat_6[gl_InvocationID] = f16vec4(pvd.vert_f16d4_flat_6[gl_InvocationID]);
    vert_f32d3_inter_7[gl_InvocationID] = f32vec3(pvd.vert_f32d3_inter_7[gl_InvocationID]);
    vert_i64d1_flat_3[gl_InvocationID] = int64_t(pvd.vert_i64d1_flat_3[gl_InvocationID]);
    vert_i64d2_flat_8[gl_InvocationID] = i64vec2(pvd.vert_i64d2_flat_8[gl_InvocationID]);
    vert_f16d2_inter_7[gl_InvocationID] = f16vec2(pvd.vert_f16d2_inter_7[gl_InvocationID]);
    vert_f16d2_flat_7[gl_InvocationID] = f16vec2(pvd.vert_f16d2_flat_7[gl_InvocationID]);
    vert_f64d3_flat_6[gl_InvocationID] = f64vec3(pvd.vert_f64d3_flat_6[gl_InvocationID]);
    vert_i32d4_flat_6[gl_InvocationID] = i32vec4(pvd.vert_i32d4_flat_6[gl_InvocationID]);
    vert_f32d4_flat_0[gl_InvocationID] = f32vec4(pvd.vert_f32d4_flat_0[gl_InvocationID]);
    vert_f16d3_inter_3[gl_InvocationID] = f16vec3(pvd.vert_f16d3_inter_3[gl_InvocationID]);
    vert_i16d4_flat_3[gl_InvocationID] = i16vec4(pvd.vert_i16d4_flat_3[gl_InvocationID]);
    vert_f32d4_flat_2[gl_InvocationID] = f32vec4(pvd.vert_f32d4_flat_2[gl_InvocationID]);
    vert_f16d3_flat_6[gl_InvocationID] = f16vec3(pvd.vert_f16d3_flat_6[gl_InvocationID]);
    vert_f16d1_flat_7[gl_InvocationID] = float16_t(pvd.vert_f16d1_flat_7[gl_InvocationID]);
    vert_f32d2_flat_0[gl_InvocationID] = f32vec2(pvd.vert_f32d2_flat_0[gl_InvocationID]);
    vert_f32d4_flat_7[gl_InvocationID] = f32vec4(pvd.vert_f32d4_flat_7[gl_InvocationID]);
    vert_i16d2_flat_0[gl_InvocationID] = i16vec2(pvd.vert_i16d2_flat_0[gl_InvocationID]);
    vert_i64d1_flat_1[gl_InvocationID] = int64_t(pvd.vert_i64d1_flat_1[gl_InvocationID]);
   gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
   gl_TessLevelOuter = float[4](1.0, 1.0, 1.0, 1.0);
   gl_TessLevelInner = float[2](1.0, 1.0);

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(quads, equal_spacing) in;

layout(set=0, binding=0, std430) readonly buffer PerVertexBlock {
    ivec4 vert_i64d4_flat_7[4];
    float vert_f64d1_flat_8[4];
    vec2 vert_f64d2_flat_0[4];
    ivec4 vert_i16d4_flat_6[4];
    vec3 vert_f16d3_flat_7[4];
    vec3 vert_f32d3_flat_7[4];
    vec3 vert_f16d3_inter_0[4];
    vec2 vert_f32d2_flat_6[4];
    vec2 vert_f32d2_inter_6[4];
    vec4 vert_f16d4_flat_6[4];
    vec3 vert_f32d3_inter_7[4];
    int vert_i64d1_flat_3[4];
    ivec2 vert_i64d2_flat_8[4];
    vec2 vert_f16d2_inter_7[4];
    vec2 vert_f16d2_flat_7[4];
    vec3 vert_f64d3_flat_6[4];
    ivec4 vert_i32d4_flat_6[4];
    vec4 vert_f32d4_flat_0[4];
    vec3 vert_f16d3_inter_3[4];
    ivec4 vert_i16d4_flat_3[4];
    vec4 vert_f32d4_flat_2[4];
    vec3 vert_f16d3_flat_6[4];
    float vert_f16d1_flat_7[4];
    vec2 vert_f32d2_flat_0[4];
    vec4 vert_f32d4_flat_7[4];
    ivec2 vert_i16d2_flat_0[4];
    int vert_i64d1_flat_1[4];
 } pvd;

layout (location=0) in flat i64vec4 vert_i64d4_flat_7[];
layout (location=2) in flat float64_t vert_f64d1_flat_8[];
layout (location=3) in flat f64vec2 vert_f64d2_flat_0[];
layout (location=4) in flat i16vec4 vert_i16d4_flat_6[];
layout (location=5) in flat f16vec3 vert_f16d3_flat_7[];
layout (location=6) in flat f32vec3 vert_f32d3_flat_7[];
layout (location=7) in f16vec3 vert_f16d3_inter_0[];
layout (location=8) in flat f32vec2 vert_f32d2_flat_6[];
layout (location=9) in f32vec2 vert_f32d2_inter_6[];
layout (location=10) in flat f16vec4 vert_f16d4_flat_6[];
layout (location=11) in f32vec3 vert_f32d3_inter_7[];
layout (location=12) in flat int64_t vert_i64d1_flat_3[];
layout (location=13) in flat i64vec2 vert_i64d2_flat_8[];
layout (location=14) in f16vec2 vert_f16d2_inter_7[];
layout (location=15) in flat f16vec2 vert_f16d2_flat_7[];
layout (location=16) in flat f64vec3 vert_f64d3_flat_6[];
layout (location=18) in flat i32vec4 vert_i32d4_flat_6[];
layout (location=19) in flat f32vec4 vert_f32d4_flat_0[];
layout (location=20) in f16vec3 vert_f16d3_inter_3[];
layout (location=21) in flat i16vec4 vert_i16d4_flat_3[];
layout (location=22) in flat f32vec4 vert_f32d4_flat_2[];
layout (location=23) in flat f16vec3 vert_f16d3_flat_6[];
layout (location=24) in flat float16_t vert_f16d1_flat_7[];
layout (location=25) in flat f32vec2 vert_f32d2_flat_0[];
layout (location=26) in flat f32vec4 vert_f32d4_flat_7[];
layout (location=27) in flat i16vec2 vert_i16d2_flat_0[];
layout (location=28) in flat int64_t vert_i64d1_flat_1[];

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
i64vec4 temp_vert_i64d4_flat_7;
INTERP_QUAD_VAR(i64vec4, var_vert_i64d4_flat_7 ,vert_i64d4_flat_7[i], temp_vert_i64d4_flat_7);
    bool good_vert_i64d4_flat_7 = all(lessThanEqual(temp_vert_i64d4_flat_7, i64vec4(max(max(max(pvd.vert_i64d4_flat_7[0], pvd.vert_i64d4_flat_7[1]), pvd.vert_i64d4_flat_7[2]), pvd.vert_i64d4_flat_7[3])))) && all(greaterThanEqual(temp_vert_i64d4_flat_7, i64vec4(min(min(min(pvd.vert_i64d4_flat_7[0], pvd.vert_i64d4_flat_7[1]), pvd.vert_i64d4_flat_7[2]), pvd.vert_i64d4_flat_7[3]))));
float64_t temp_vert_f64d1_flat_8;
INTERP_QUAD_VAR(float64_t, var_vert_f64d1_flat_8 ,vert_f64d1_flat_8[i], temp_vert_f64d1_flat_8);
    bool good_vert_f64d1_flat_8 = (temp_vert_f64d1_flat_8 <= float64_t(max(max(max(pvd.vert_f64d1_flat_8[0], pvd.vert_f64d1_flat_8[1]), pvd.vert_f64d1_flat_8[2]), pvd.vert_f64d1_flat_8[3]))) && (temp_vert_f64d1_flat_8 >= float64_t(min(min(min(pvd.vert_f64d1_flat_8[0], pvd.vert_f64d1_flat_8[1]), pvd.vert_f64d1_flat_8[2]), pvd.vert_f64d1_flat_8[3])));
f64vec2 temp_vert_f64d2_flat_0;
INTERP_QUAD_VAR(f64vec2, var_vert_f64d2_flat_0 ,vert_f64d2_flat_0[i], temp_vert_f64d2_flat_0);
    bool good_vert_f64d2_flat_0 = all(lessThanEqual(temp_vert_f64d2_flat_0, f64vec2(max(max(max(pvd.vert_f64d2_flat_0[0], pvd.vert_f64d2_flat_0[1]), pvd.vert_f64d2_flat_0[2]), pvd.vert_f64d2_flat_0[3])))) && all(greaterThanEqual(temp_vert_f64d2_flat_0, f64vec2(min(min(min(pvd.vert_f64d2_flat_0[0], pvd.vert_f64d2_flat_0[1]), pvd.vert_f64d2_flat_0[2]), pvd.vert_f64d2_flat_0[3]))));
i16vec4 temp_vert_i16d4_flat_6;
INTERP_QUAD_VAR(i16vec4, var_vert_i16d4_flat_6 ,vert_i16d4_flat_6[i], temp_vert_i16d4_flat_6);
    bool good_vert_i16d4_flat_6 = all(lessThanEqual(temp_vert_i16d4_flat_6, i16vec4(max(max(max(pvd.vert_i16d4_flat_6[0], pvd.vert_i16d4_flat_6[1]), pvd.vert_i16d4_flat_6[2]), pvd.vert_i16d4_flat_6[3])))) && all(greaterThanEqual(temp_vert_i16d4_flat_6, i16vec4(min(min(min(pvd.vert_i16d4_flat_6[0], pvd.vert_i16d4_flat_6[1]), pvd.vert_i16d4_flat_6[2]), pvd.vert_i16d4_flat_6[3]))));
f16vec3 temp_vert_f16d3_flat_7;
INTERP_QUAD_VAR(f16vec3, var_vert_f16d3_flat_7 ,vert_f16d3_flat_7[i], temp_vert_f16d3_flat_7);
    bool good_vert_f16d3_flat_7 = all(lessThanEqual(temp_vert_f16d3_flat_7, f16vec3(max(max(max(pvd.vert_f16d3_flat_7[0], pvd.vert_f16d3_flat_7[1]), pvd.vert_f16d3_flat_7[2]), pvd.vert_f16d3_flat_7[3])))) && all(greaterThanEqual(temp_vert_f16d3_flat_7, f16vec3(min(min(min(pvd.vert_f16d3_flat_7[0], pvd.vert_f16d3_flat_7[1]), pvd.vert_f16d3_flat_7[2]), pvd.vert_f16d3_flat_7[3]))));
f32vec3 temp_vert_f32d3_flat_7;
INTERP_QUAD_VAR(f32vec3, var_vert_f32d3_flat_7 ,vert_f32d3_flat_7[i], temp_vert_f32d3_flat_7);
    bool good_vert_f32d3_flat_7 = all(lessThanEqual(temp_vert_f32d3_flat_7, f32vec3(max(max(max(pvd.vert_f32d3_flat_7[0], pvd.vert_f32d3_flat_7[1]), pvd.vert_f32d3_flat_7[2]), pvd.vert_f32d3_flat_7[3])))) && all(greaterThanEqual(temp_vert_f32d3_flat_7, f32vec3(min(min(min(pvd.vert_f32d3_flat_7[0], pvd.vert_f32d3_flat_7[1]), pvd.vert_f32d3_flat_7[2]), pvd.vert_f32d3_flat_7[3]))));
f16vec3 temp_vert_f16d3_inter_0;
INTERP_QUAD_VAR(f16vec3, var_vert_f16d3_inter_0 ,vert_f16d3_inter_0[i], temp_vert_f16d3_inter_0);
    bool good_vert_f16d3_inter_0 = all(lessThanEqual(temp_vert_f16d3_inter_0, f16vec3(max(max(max(pvd.vert_f16d3_inter_0[0], pvd.vert_f16d3_inter_0[1]), pvd.vert_f16d3_inter_0[2]), pvd.vert_f16d3_inter_0[3])))) && all(greaterThanEqual(temp_vert_f16d3_inter_0, f16vec3(min(min(min(pvd.vert_f16d3_inter_0[0], pvd.vert_f16d3_inter_0[1]), pvd.vert_f16d3_inter_0[2]), pvd.vert_f16d3_inter_0[3]))));
f32vec2 temp_vert_f32d2_flat_6;
INTERP_QUAD_VAR(f32vec2, var_vert_f32d2_flat_6 ,vert_f32d2_flat_6[i], temp_vert_f32d2_flat_6);
    bool good_vert_f32d2_flat_6 = all(lessThanEqual(temp_vert_f32d2_flat_6, f32vec2(max(max(max(pvd.vert_f32d2_flat_6[0], pvd.vert_f32d2_flat_6[1]), pvd.vert_f32d2_flat_6[2]), pvd.vert_f32d2_flat_6[3])))) && all(greaterThanEqual(temp_vert_f32d2_flat_6, f32vec2(min(min(min(pvd.vert_f32d2_flat_6[0], pvd.vert_f32d2_flat_6[1]), pvd.vert_f32d2_flat_6[2]), pvd.vert_f32d2_flat_6[3]))));
f32vec2 temp_vert_f32d2_inter_6;
INTERP_QUAD_VAR(f32vec2, var_vert_f32d2_inter_6 ,vert_f32d2_inter_6[i], temp_vert_f32d2_inter_6);
    bool good_vert_f32d2_inter_6 = all(lessThanEqual(temp_vert_f32d2_inter_6, f32vec2(max(max(max(pvd.vert_f32d2_inter_6[0], pvd.vert_f32d2_inter_6[1]), pvd.vert_f32d2_inter_6[2]), pvd.vert_f32d2_inter_6[3])))) && all(greaterThanEqual(temp_vert_f32d2_inter_6, f32vec2(min(min(min(pvd.vert_f32d2_inter_6[0], pvd.vert_f32d2_inter_6[1]), pvd.vert_f32d2_inter_6[2]), pvd.vert_f32d2_inter_6[3]))));
f16vec4 temp_vert_f16d4_flat_6;
INTERP_QUAD_VAR(f16vec4, var_vert_f16d4_flat_6 ,vert_f16d4_flat_6[i], temp_vert_f16d4_flat_6);
    bool good_vert_f16d4_flat_6 = all(lessThanEqual(temp_vert_f16d4_flat_6, f16vec4(max(max(max(pvd.vert_f16d4_flat_6[0], pvd.vert_f16d4_flat_6[1]), pvd.vert_f16d4_flat_6[2]), pvd.vert_f16d4_flat_6[3])))) && all(greaterThanEqual(temp_vert_f16d4_flat_6, f16vec4(min(min(min(pvd.vert_f16d4_flat_6[0], pvd.vert_f16d4_flat_6[1]), pvd.vert_f16d4_flat_6[2]), pvd.vert_f16d4_flat_6[3]))));
f32vec3 temp_vert_f32d3_inter_7;
INTERP_QUAD_VAR(f32vec3, var_vert_f32d3_inter_7 ,vert_f32d3_inter_7[i], temp_vert_f32d3_inter_7);
    bool good_vert_f32d3_inter_7 = all(lessThanEqual(temp_vert_f32d3_inter_7, f32vec3(max(max(max(pvd.vert_f32d3_inter_7[0], pvd.vert_f32d3_inter_7[1]), pvd.vert_f32d3_inter_7[2]), pvd.vert_f32d3_inter_7[3])))) && all(greaterThanEqual(temp_vert_f32d3_inter_7, f32vec3(min(min(min(pvd.vert_f32d3_inter_7[0], pvd.vert_f32d3_inter_7[1]), pvd.vert_f32d3_inter_7[2]), pvd.vert_f32d3_inter_7[3]))));
int64_t temp_vert_i64d1_flat_3;
INTERP_QUAD_VAR(int64_t, var_vert_i64d1_flat_3 ,vert_i64d1_flat_3[i], temp_vert_i64d1_flat_3);
    bool good_vert_i64d1_flat_3 = (temp_vert_i64d1_flat_3 <= int64_t(max(max(max(pvd.vert_i64d1_flat_3[0], pvd.vert_i64d1_flat_3[1]), pvd.vert_i64d1_flat_3[2]), pvd.vert_i64d1_flat_3[3]))) && (temp_vert_i64d1_flat_3 >= int64_t(min(min(min(pvd.vert_i64d1_flat_3[0], pvd.vert_i64d1_flat_3[1]), pvd.vert_i64d1_flat_3[2]), pvd.vert_i64d1_flat_3[3])));
i64vec2 temp_vert_i64d2_flat_8;
INTERP_QUAD_VAR(i64vec2, var_vert_i64d2_flat_8 ,vert_i64d2_flat_8[i], temp_vert_i64d2_flat_8);
    bool good_vert_i64d2_flat_8 = all(lessThanEqual(temp_vert_i64d2_flat_8, i64vec2(max(max(max(pvd.vert_i64d2_flat_8[0], pvd.vert_i64d2_flat_8[1]), pvd.vert_i64d2_flat_8[2]), pvd.vert_i64d2_flat_8[3])))) && all(greaterThanEqual(temp_vert_i64d2_flat_8, i64vec2(min(min(min(pvd.vert_i64d2_flat_8[0], pvd.vert_i64d2_flat_8[1]), pvd.vert_i64d2_flat_8[2]), pvd.vert_i64d2_flat_8[3]))));
f16vec2 temp_vert_f16d2_inter_7;
INTERP_QUAD_VAR(f16vec2, var_vert_f16d2_inter_7 ,vert_f16d2_inter_7[i], temp_vert_f16d2_inter_7);
    bool good_vert_f16d2_inter_7 = all(lessThanEqual(temp_vert_f16d2_inter_7, f16vec2(max(max(max(pvd.vert_f16d2_inter_7[0], pvd.vert_f16d2_inter_7[1]), pvd.vert_f16d2_inter_7[2]), pvd.vert_f16d2_inter_7[3])))) && all(greaterThanEqual(temp_vert_f16d2_inter_7, f16vec2(min(min(min(pvd.vert_f16d2_inter_7[0], pvd.vert_f16d2_inter_7[1]), pvd.vert_f16d2_inter_7[2]), pvd.vert_f16d2_inter_7[3]))));
f16vec2 temp_vert_f16d2_flat_7;
INTERP_QUAD_VAR(f16vec2, var_vert_f16d2_flat_7 ,vert_f16d2_flat_7[i], temp_vert_f16d2_flat_7);
    bool good_vert_f16d2_flat_7 = all(lessThanEqual(temp_vert_f16d2_flat_7, f16vec2(max(max(max(pvd.vert_f16d2_flat_7[0], pvd.vert_f16d2_flat_7[1]), pvd.vert_f16d2_flat_7[2]), pvd.vert_f16d2_flat_7[3])))) && all(greaterThanEqual(temp_vert_f16d2_flat_7, f16vec2(min(min(min(pvd.vert_f16d2_flat_7[0], pvd.vert_f16d2_flat_7[1]), pvd.vert_f16d2_flat_7[2]), pvd.vert_f16d2_flat_7[3]))));
f64vec3 temp_vert_f64d3_flat_6;
INTERP_QUAD_VAR(f64vec3, var_vert_f64d3_flat_6 ,vert_f64d3_flat_6[i], temp_vert_f64d3_flat_6);
    bool good_vert_f64d3_flat_6 = all(lessThanEqual(temp_vert_f64d3_flat_6, f64vec3(max(max(max(pvd.vert_f64d3_flat_6[0], pvd.vert_f64d3_flat_6[1]), pvd.vert_f64d3_flat_6[2]), pvd.vert_f64d3_flat_6[3])))) && all(greaterThanEqual(temp_vert_f64d3_flat_6, f64vec3(min(min(min(pvd.vert_f64d3_flat_6[0], pvd.vert_f64d3_flat_6[1]), pvd.vert_f64d3_flat_6[2]), pvd.vert_f64d3_flat_6[3]))));
i32vec4 temp_vert_i32d4_flat_6;
INTERP_QUAD_VAR(i32vec4, var_vert_i32d4_flat_6 ,vert_i32d4_flat_6[i], temp_vert_i32d4_flat_6);
    bool good_vert_i32d4_flat_6 = all(lessThanEqual(temp_vert_i32d4_flat_6, i32vec4(max(max(max(pvd.vert_i32d4_flat_6[0], pvd.vert_i32d4_flat_6[1]), pvd.vert_i32d4_flat_6[2]), pvd.vert_i32d4_flat_6[3])))) && all(greaterThanEqual(temp_vert_i32d4_flat_6, i32vec4(min(min(min(pvd.vert_i32d4_flat_6[0], pvd.vert_i32d4_flat_6[1]), pvd.vert_i32d4_flat_6[2]), pvd.vert_i32d4_flat_6[3]))));
f32vec4 temp_vert_f32d4_flat_0;
INTERP_QUAD_VAR(f32vec4, var_vert_f32d4_flat_0 ,vert_f32d4_flat_0[i], temp_vert_f32d4_flat_0);
    bool good_vert_f32d4_flat_0 = all(lessThanEqual(temp_vert_f32d4_flat_0, f32vec4(max(max(max(pvd.vert_f32d4_flat_0[0], pvd.vert_f32d4_flat_0[1]), pvd.vert_f32d4_flat_0[2]), pvd.vert_f32d4_flat_0[3])))) && all(greaterThanEqual(temp_vert_f32d4_flat_0, f32vec4(min(min(min(pvd.vert_f32d4_flat_0[0], pvd.vert_f32d4_flat_0[1]), pvd.vert_f32d4_flat_0[2]), pvd.vert_f32d4_flat_0[3]))));
f16vec3 temp_vert_f16d3_inter_3;
INTERP_QUAD_VAR(f16vec3, var_vert_f16d3_inter_3 ,vert_f16d3_inter_3[i], temp_vert_f16d3_inter_3);
    bool good_vert_f16d3_inter_3 = all(lessThanEqual(temp_vert_f16d3_inter_3, f16vec3(max(max(max(pvd.vert_f16d3_inter_3[0], pvd.vert_f16d3_inter_3[1]), pvd.vert_f16d3_inter_3[2]), pvd.vert_f16d3_inter_3[3])))) && all(greaterThanEqual(temp_vert_f16d3_inter_3, f16vec3(min(min(min(pvd.vert_f16d3_inter_3[0], pvd.vert_f16d3_inter_3[1]), pvd.vert_f16d3_inter_3[2]), pvd.vert_f16d3_inter_3[3]))));
i16vec4 temp_vert_i16d4_flat_3;
INTERP_QUAD_VAR(i16vec4, var_vert_i16d4_flat_3 ,vert_i16d4_flat_3[i], temp_vert_i16d4_flat_3);
    bool good_vert_i16d4_flat_3 = all(lessThanEqual(temp_vert_i16d4_flat_3, i16vec4(max(max(max(pvd.vert_i16d4_flat_3[0], pvd.vert_i16d4_flat_3[1]), pvd.vert_i16d4_flat_3[2]), pvd.vert_i16d4_flat_3[3])))) && all(greaterThanEqual(temp_vert_i16d4_flat_3, i16vec4(min(min(min(pvd.vert_i16d4_flat_3[0], pvd.vert_i16d4_flat_3[1]), pvd.vert_i16d4_flat_3[2]), pvd.vert_i16d4_flat_3[3]))));
f32vec4 temp_vert_f32d4_flat_2;
INTERP_QUAD_VAR(f32vec4, var_vert_f32d4_flat_2 ,vert_f32d4_flat_2[i], temp_vert_f32d4_flat_2);
    bool good_vert_f32d4_flat_2 = all(lessThanEqual(temp_vert_f32d4_flat_2, f32vec4(max(max(max(pvd.vert_f32d4_flat_2[0], pvd.vert_f32d4_flat_2[1]), pvd.vert_f32d4_flat_2[2]), pvd.vert_f32d4_flat_2[3])))) && all(greaterThanEqual(temp_vert_f32d4_flat_2, f32vec4(min(min(min(pvd.vert_f32d4_flat_2[0], pvd.vert_f32d4_flat_2[1]), pvd.vert_f32d4_flat_2[2]), pvd.vert_f32d4_flat_2[3]))));
f16vec3 temp_vert_f16d3_flat_6;
INTERP_QUAD_VAR(f16vec3, var_vert_f16d3_flat_6 ,vert_f16d3_flat_6[i], temp_vert_f16d3_flat_6);
    bool good_vert_f16d3_flat_6 = all(lessThanEqual(temp_vert_f16d3_flat_6, f16vec3(max(max(max(pvd.vert_f16d3_flat_6[0], pvd.vert_f16d3_flat_6[1]), pvd.vert_f16d3_flat_6[2]), pvd.vert_f16d3_flat_6[3])))) && all(greaterThanEqual(temp_vert_f16d3_flat_6, f16vec3(min(min(min(pvd.vert_f16d3_flat_6[0], pvd.vert_f16d3_flat_6[1]), pvd.vert_f16d3_flat_6[2]), pvd.vert_f16d3_flat_6[3]))));
float16_t temp_vert_f16d1_flat_7;
INTERP_QUAD_VAR(float16_t, var_vert_f16d1_flat_7 ,vert_f16d1_flat_7[i], temp_vert_f16d1_flat_7);
    bool good_vert_f16d1_flat_7 = (temp_vert_f16d1_flat_7 <= float16_t(max(max(max(pvd.vert_f16d1_flat_7[0], pvd.vert_f16d1_flat_7[1]), pvd.vert_f16d1_flat_7[2]), pvd.vert_f16d1_flat_7[3]))) && (temp_vert_f16d1_flat_7 >= float16_t(min(min(min(pvd.vert_f16d1_flat_7[0], pvd.vert_f16d1_flat_7[1]), pvd.vert_f16d1_flat_7[2]), pvd.vert_f16d1_flat_7[3])));
f32vec2 temp_vert_f32d2_flat_0;
INTERP_QUAD_VAR(f32vec2, var_vert_f32d2_flat_0 ,vert_f32d2_flat_0[i], temp_vert_f32d2_flat_0);
    bool good_vert_f32d2_flat_0 = all(lessThanEqual(temp_vert_f32d2_flat_0, f32vec2(max(max(max(pvd.vert_f32d2_flat_0[0], pvd.vert_f32d2_flat_0[1]), pvd.vert_f32d2_flat_0[2]), pvd.vert_f32d2_flat_0[3])))) && all(greaterThanEqual(temp_vert_f32d2_flat_0, f32vec2(min(min(min(pvd.vert_f32d2_flat_0[0], pvd.vert_f32d2_flat_0[1]), pvd.vert_f32d2_flat_0[2]), pvd.vert_f32d2_flat_0[3]))));
f32vec4 temp_vert_f32d4_flat_7;
INTERP_QUAD_VAR(f32vec4, var_vert_f32d4_flat_7 ,vert_f32d4_flat_7[i], temp_vert_f32d4_flat_7);
    bool good_vert_f32d4_flat_7 = all(lessThanEqual(temp_vert_f32d4_flat_7, f32vec4(max(max(max(pvd.vert_f32d4_flat_7[0], pvd.vert_f32d4_flat_7[1]), pvd.vert_f32d4_flat_7[2]), pvd.vert_f32d4_flat_7[3])))) && all(greaterThanEqual(temp_vert_f32d4_flat_7, f32vec4(min(min(min(pvd.vert_f32d4_flat_7[0], pvd.vert_f32d4_flat_7[1]), pvd.vert_f32d4_flat_7[2]), pvd.vert_f32d4_flat_7[3]))));
i16vec2 temp_vert_i16d2_flat_0;
INTERP_QUAD_VAR(i16vec2, var_vert_i16d2_flat_0 ,vert_i16d2_flat_0[i], temp_vert_i16d2_flat_0);
    bool good_vert_i16d2_flat_0 = all(lessThanEqual(temp_vert_i16d2_flat_0, i16vec2(max(max(max(pvd.vert_i16d2_flat_0[0], pvd.vert_i16d2_flat_0[1]), pvd.vert_i16d2_flat_0[2]), pvd.vert_i16d2_flat_0[3])))) && all(greaterThanEqual(temp_vert_i16d2_flat_0, i16vec2(min(min(min(pvd.vert_i16d2_flat_0[0], pvd.vert_i16d2_flat_0[1]), pvd.vert_i16d2_flat_0[2]), pvd.vert_i16d2_flat_0[3]))));
int64_t temp_vert_i64d1_flat_1;
INTERP_QUAD_VAR(int64_t, var_vert_i64d1_flat_1 ,vert_i64d1_flat_1[i], temp_vert_i64d1_flat_1);
    bool good_vert_i64d1_flat_1 = (temp_vert_i64d1_flat_1 <= int64_t(max(max(max(pvd.vert_i64d1_flat_1[0], pvd.vert_i64d1_flat_1[1]), pvd.vert_i64d1_flat_1[2]), pvd.vert_i64d1_flat_1[3]))) && (temp_vert_i64d1_flat_1 >= int64_t(min(min(min(pvd.vert_i64d1_flat_1[0], pvd.vert_i64d1_flat_1[1]), pvd.vert_i64d1_flat_1[2]), pvd.vert_i64d1_flat_1[3])));
    if (good_vert_i64d4_flat_7 && good_vert_f64d1_flat_8 && good_vert_f64d2_flat_0 && good_vert_i16d4_flat_6 && good_vert_f16d3_flat_7 && good_vert_f32d3_flat_7 && good_vert_f16d3_inter_0 && good_vert_f32d2_flat_6 && good_vert_f32d2_inter_6 && good_vert_f16d4_flat_6 && good_vert_f32d3_inter_7 && good_vert_i64d1_flat_3 && good_vert_i64d2_flat_8 && good_vert_f16d2_inter_7 && good_vert_f16d2_flat_7 && good_vert_f64d3_flat_6 && good_vert_i32d4_flat_6 && good_vert_f32d4_flat_0 && good_vert_f16d3_inter_3 && good_vert_i16d4_flat_3 && good_vert_f32d4_flat_2 && good_vert_f16d3_flat_6 && good_vert_f16d1_flat_7 && good_vert_f32d2_flat_0 && good_vert_f32d4_flat_7 && good_vert_i16d2_flat_0 && good_vert_i64d1_flat_1) {
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

layout (location=1) out flat i64vec4 vert_i64d4_flat_7[];
layout (location=3) out flat float64_t vert_f64d1_flat_8[];
layout (location=4) out flat f64vec2 vert_f64d2_flat_0[];
layout (location=5) out flat i16vec4 vert_i16d4_flat_6[];
layout (location=6) out flat f16vec3 vert_f16d3_flat_7[];
layout (location=7) out flat f32vec3 vert_f32d3_flat_7[];
layout (location=8) out f16vec3 vert_f16d3_inter_0[];
layout (location=9) out flat f32vec2 vert_f32d2_flat_6[];
layout (location=10) out f32vec2 vert_f32d2_inter_6[];
layout (location=11) out flat f16vec4 vert_f16d4_flat_6[];
layout (location=12) out f32vec3 vert_f32d3_inter_7[];
layout (location=13) out flat int64_t vert_i64d1_flat_3[];
layout (location=14) out flat i64vec2 vert_i64d2_flat_8[];
layout (location=15) out f16vec2 vert_f16d2_inter_7[];
layout (location=16) out flat f16vec2 vert_f16d2_flat_7[];
layout (location=17) out flat f64vec3 vert_f64d3_flat_6[];
layout (location=19) out flat i32vec4 vert_i32d4_flat_6[];
layout (location=20) out flat f32vec4 vert_f32d4_flat_0[];
layout (location=21) out f16vec3 vert_f16d3_inter_3[];
layout (location=22) out flat i16vec4 vert_i16d4_flat_3[];
layout (location=23) out flat f32vec4 vert_f32d4_flat_2[];
layout (location=24) out flat f16vec3 vert_f16d3_flat_6[];
layout (location=25) out flat float16_t vert_f16d1_flat_7[];
layout (location=26) out flat f32vec2 vert_f32d2_flat_0[];
layout (location=27) out flat f32vec4 vert_f32d4_flat_7[];
layout (location=28) out flat i16vec2 vert_i16d2_flat_0[];

layout(set=0, binding=0, std430) readonly buffer PerVertexBlock {
    ivec4 vert_i64d4_flat_7[4];
    float vert_f64d1_flat_8[4];
    vec2 vert_f64d2_flat_0[4];
    ivec4 vert_i16d4_flat_6[4];
    vec3 vert_f16d3_flat_7[4];
    vec3 vert_f32d3_flat_7[4];
    vec3 vert_f16d3_inter_0[4];
    vec2 vert_f32d2_flat_6[4];
    vec2 vert_f32d2_inter_6[4];
    vec4 vert_f16d4_flat_6[4];
    vec3 vert_f32d3_inter_7[4];
    int vert_i64d1_flat_3[4];
    ivec2 vert_i64d2_flat_8[4];
    vec2 vert_f16d2_inter_7[4];
    vec2 vert_f16d2_flat_7[4];
    vec3 vert_f64d3_flat_6[4];
    ivec4 vert_i32d4_flat_6[4];
    vec4 vert_f32d4_flat_0[4];
    vec3 vert_f16d3_inter_3[4];
    ivec4 vert_i16d4_flat_3[4];
    vec4 vert_f32d4_flat_2[4];
    vec3 vert_f16d3_flat_6[4];
    float vert_f16d1_flat_7[4];
    vec2 vert_f32d2_flat_0[4];
    vec4 vert_f32d4_flat_7[4];
    ivec2 vert_i16d2_flat_0[4];
 } pvd;

in gl_PerVertex {
    vec4  gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
} gl_out[];

void main ()
{
    vert_i64d4_flat_7[gl_InvocationID] = i64vec4(pvd.vert_i64d4_flat_7[gl_InvocationID]);
    vert_f64d1_flat_8[gl_InvocationID] = float64_t(pvd.vert_f64d1_flat_8[gl_InvocationID]);
    vert_f64d2_flat_0[gl_InvocationID] = f64vec2(pvd.vert_f64d2_flat_0[gl_InvocationID]);
    vert_i16d4_flat_6[gl_InvocationID] = i16vec4(pvd.vert_i16d4_flat_6[gl_InvocationID]);
    vert_f16d3_flat_7[gl_InvocationID] = f16vec3(pvd.vert_f16d3_flat_7[gl_InvocationID]);
    vert_f32d3_flat_7[gl_InvocationID] = f32vec3(pvd.vert_f32d3_flat_7[gl_InvocationID]);
    vert_f16d3_inter_0[gl_InvocationID] = f16vec3(pvd.vert_f16d3_inter_0[gl_InvocationID]);
    vert_f32d2_flat_6[gl_InvocationID] = f32vec2(pvd.vert_f32d2_flat_6[gl_InvocationID]);
    vert_f32d2_inter_6[gl_InvocationID] = f32vec2(pvd.vert_f32d2_inter_6[gl_InvocationID]);
    vert_f16d4_flat_6[gl_InvocationID] = f16vec4(pvd.vert_f16d4_flat_6[gl_InvocationID]);
    vert_f32d3_inter_7[gl_InvocationID] = f32vec3(pvd.vert_f32d3_inter_7[gl_InvocationID]);
    vert_i64d1_flat_3[gl_InvocationID] = int64_t(pvd.vert_i64d1_flat_3[gl_InvocationID]);
    vert_i64d2_flat_8[gl_InvocationID] = i64vec2(pvd.vert_i64d2_flat_8[gl_InvocationID]);
    vert_f16d2_inter_7[gl_InvocationID] = f16vec2(pvd.vert_f16d2_inter_7[gl_InvocationID]);
    vert_f16d2_flat_7[gl_InvocationID] = f16vec2(pvd.vert_f16d2_flat_7[gl_InvocationID]);
    vert_f64d3_flat_6[gl_InvocationID] = f64vec3(pvd.vert_f64d3_flat_6[gl_InvocationID]);
    vert_i32d4_flat_6[gl_InvocationID] = i32vec4(pvd.vert_i32d4_flat_6[gl_InvocationID]);
    vert_f32d4_flat_0[gl_InvocationID] = f32vec4(pvd.vert_f32d4_flat_0[gl_InvocationID]);
    vert_f16d3_inter_3[gl_InvocationID] = f16vec3(pvd.vert_f16d3_inter_3[gl_InvocationID]);
    vert_i16d4_flat_3[gl_InvocationID] = i16vec4(pvd.vert_i16d4_flat_3[gl_InvocationID]);
    vert_f32d4_flat_2[gl_InvocationID] = f32vec4(pvd.vert_f32d4_flat_2[gl_InvocationID]);
    vert_f16d3_flat_6[gl_InvocationID] = f16vec3(pvd.vert_f16d3_flat_6[gl_InvocationID]);
    vert_f16d1_flat_7[gl_InvocationID] = float16_t(pvd.vert_f16d1_flat_7[gl_InvocationID]);
    vert_f32d2_flat_0[gl_InvocationID] = f32vec2(pvd.vert_f32d2_flat_0[gl_InvocationID]);
    vert_f32d4_flat_7[gl_InvocationID] = f32vec4(pvd.vert_f32d4_flat_7[gl_InvocationID]);
    vert_i16d2_flat_0[gl_InvocationID] = i16vec2(pvd.vert_i16d2_flat_0[gl_InvocationID]);
    bool good_vert_i64d4_flat_7 = all(lessThanEqual(vert_i64d4_flat_7[gl_InvocationID], i64vec4(max(max(max(pvd.vert_i64d4_flat_7[0], pvd.vert_i64d4_flat_7[1]), pvd.vert_i64d4_flat_7[2]), pvd.vert_i64d4_flat_7[3])))) && all(greaterThanEqual(vert_i64d4_flat_7[gl_InvocationID], i64vec4(min(min(min(pvd.vert_i64d4_flat_7[0], pvd.vert_i64d4_flat_7[1]), pvd.vert_i64d4_flat_7[2]), pvd.vert_i64d4_flat_7[3]))));
    bool good_vert_f64d1_flat_8 = (vert_f64d1_flat_8[gl_InvocationID] <= float64_t(max(max(max(pvd.vert_f64d1_flat_8[0], pvd.vert_f64d1_flat_8[1]), pvd.vert_f64d1_flat_8[2]), pvd.vert_f64d1_flat_8[3]))) && (vert_f64d1_flat_8[gl_InvocationID] >= float64_t(min(min(min(pvd.vert_f64d1_flat_8[0], pvd.vert_f64d1_flat_8[1]), pvd.vert_f64d1_flat_8[2]), pvd.vert_f64d1_flat_8[3])));
    bool good_vert_f64d2_flat_0 = all(lessThanEqual(vert_f64d2_flat_0[gl_InvocationID], f64vec2(max(max(max(pvd.vert_f64d2_flat_0[0], pvd.vert_f64d2_flat_0[1]), pvd.vert_f64d2_flat_0[2]), pvd.vert_f64d2_flat_0[3])))) && all(greaterThanEqual(vert_f64d2_flat_0[gl_InvocationID], f64vec2(min(min(min(pvd.vert_f64d2_flat_0[0], pvd.vert_f64d2_flat_0[1]), pvd.vert_f64d2_flat_0[2]), pvd.vert_f64d2_flat_0[3]))));
    bool good_vert_i16d4_flat_6 = all(lessThanEqual(vert_i16d4_flat_6[gl_InvocationID], i16vec4(max(max(max(pvd.vert_i16d4_flat_6[0], pvd.vert_i16d4_flat_6[1]), pvd.vert_i16d4_flat_6[2]), pvd.vert_i16d4_flat_6[3])))) && all(greaterThanEqual(vert_i16d4_flat_6[gl_InvocationID], i16vec4(min(min(min(pvd.vert_i16d4_flat_6[0], pvd.vert_i16d4_flat_6[1]), pvd.vert_i16d4_flat_6[2]), pvd.vert_i16d4_flat_6[3]))));
    bool good_vert_f16d3_flat_7 = all(lessThanEqual(vert_f16d3_flat_7[gl_InvocationID], f16vec3(max(max(max(pvd.vert_f16d3_flat_7[0], pvd.vert_f16d3_flat_7[1]), pvd.vert_f16d3_flat_7[2]), pvd.vert_f16d3_flat_7[3])))) && all(greaterThanEqual(vert_f16d3_flat_7[gl_InvocationID], f16vec3(min(min(min(pvd.vert_f16d3_flat_7[0], pvd.vert_f16d3_flat_7[1]), pvd.vert_f16d3_flat_7[2]), pvd.vert_f16d3_flat_7[3]))));
    bool good_vert_f32d3_flat_7 = all(lessThanEqual(vert_f32d3_flat_7[gl_InvocationID], f32vec3(max(max(max(pvd.vert_f32d3_flat_7[0], pvd.vert_f32d3_flat_7[1]), pvd.vert_f32d3_flat_7[2]), pvd.vert_f32d3_flat_7[3])))) && all(greaterThanEqual(vert_f32d3_flat_7[gl_InvocationID], f32vec3(min(min(min(pvd.vert_f32d3_flat_7[0], pvd.vert_f32d3_flat_7[1]), pvd.vert_f32d3_flat_7[2]), pvd.vert_f32d3_flat_7[3]))));
    bool good_vert_f16d3_inter_0 = all(lessThanEqual(vert_f16d3_inter_0[gl_InvocationID], f16vec3(max(max(max(pvd.vert_f16d3_inter_0[0], pvd.vert_f16d3_inter_0[1]), pvd.vert_f16d3_inter_0[2]), pvd.vert_f16d3_inter_0[3])))) && all(greaterThanEqual(vert_f16d3_inter_0[gl_InvocationID], f16vec3(min(min(min(pvd.vert_f16d3_inter_0[0], pvd.vert_f16d3_inter_0[1]), pvd.vert_f16d3_inter_0[2]), pvd.vert_f16d3_inter_0[3]))));
    bool good_vert_f32d2_flat_6 = all(lessThanEqual(vert_f32d2_flat_6[gl_InvocationID], f32vec2(max(max(max(pvd.vert_f32d2_flat_6[0], pvd.vert_f32d2_flat_6[1]), pvd.vert_f32d2_flat_6[2]), pvd.vert_f32d2_flat_6[3])))) && all(greaterThanEqual(vert_f32d2_flat_6[gl_InvocationID], f32vec2(min(min(min(pvd.vert_f32d2_flat_6[0], pvd.vert_f32d2_flat_6[1]), pvd.vert_f32d2_flat_6[2]), pvd.vert_f32d2_flat_6[3]))));
    bool good_vert_f32d2_inter_6 = all(lessThanEqual(vert_f32d2_inter_6[gl_InvocationID], f32vec2(max(max(max(pvd.vert_f32d2_inter_6[0], pvd.vert_f32d2_inter_6[1]), pvd.vert_f32d2_inter_6[2]), pvd.vert_f32d2_inter_6[3])))) && all(greaterThanEqual(vert_f32d2_inter_6[gl_InvocationID], f32vec2(min(min(min(pvd.vert_f32d2_inter_6[0], pvd.vert_f32d2_inter_6[1]), pvd.vert_f32d2_inter_6[2]), pvd.vert_f32d2_inter_6[3]))));
    bool good_vert_f16d4_flat_6 = all(lessThanEqual(vert_f16d4_flat_6[gl_InvocationID], f16vec4(max(max(max(pvd.vert_f16d4_flat_6[0], pvd.vert_f16d4_flat_6[1]), pvd.vert_f16d4_flat_6[2]), pvd.vert_f16d4_flat_6[3])))) && all(greaterThanEqual(vert_f16d4_flat_6[gl_InvocationID], f16vec4(min(min(min(pvd.vert_f16d4_flat_6[0], pvd.vert_f16d4_flat_6[1]), pvd.vert_f16d4_flat_6[2]), pvd.vert_f16d4_flat_6[3]))));
    bool good_vert_f32d3_inter_7 = all(lessThanEqual(vert_f32d3_inter_7[gl_InvocationID], f32vec3(max(max(max(pvd.vert_f32d3_inter_7[0], pvd.vert_f32d3_inter_7[1]), pvd.vert_f32d3_inter_7[2]), pvd.vert_f32d3_inter_7[3])))) && all(greaterThanEqual(vert_f32d3_inter_7[gl_InvocationID], f32vec3(min(min(min(pvd.vert_f32d3_inter_7[0], pvd.vert_f32d3_inter_7[1]), pvd.vert_f32d3_inter_7[2]), pvd.vert_f32d3_inter_7[3]))));
    bool good_vert_i64d1_flat_3 = (vert_i64d1_flat_3[gl_InvocationID] <= int64_t(max(max(max(pvd.vert_i64d1_flat_3[0], pvd.vert_i64d1_flat_3[1]), pvd.vert_i64d1_flat_3[2]), pvd.vert_i64d1_flat_3[3]))) && (vert_i64d1_flat_3[gl_InvocationID] >= int64_t(min(min(min(pvd.vert_i64d1_flat_3[0], pvd.vert_i64d1_flat_3[1]), pvd.vert_i64d1_flat_3[2]), pvd.vert_i64d1_flat_3[3])));
    bool good_vert_i64d2_flat_8 = all(lessThanEqual(vert_i64d2_flat_8[gl_InvocationID], i64vec2(max(max(max(pvd.vert_i64d2_flat_8[0], pvd.vert_i64d2_flat_8[1]), pvd.vert_i64d2_flat_8[2]), pvd.vert_i64d2_flat_8[3])))) && all(greaterThanEqual(vert_i64d2_flat_8[gl_InvocationID], i64vec2(min(min(min(pvd.vert_i64d2_flat_8[0], pvd.vert_i64d2_flat_8[1]), pvd.vert_i64d2_flat_8[2]), pvd.vert_i64d2_flat_8[3]))));
    bool good_vert_f16d2_inter_7 = all(lessThanEqual(vert_f16d2_inter_7[gl_InvocationID], f16vec2(max(max(max(pvd.vert_f16d2_inter_7[0], pvd.vert_f16d2_inter_7[1]), pvd.vert_f16d2_inter_7[2]), pvd.vert_f16d2_inter_7[3])))) && all(greaterThanEqual(vert_f16d2_inter_7[gl_InvocationID], f16vec2(min(min(min(pvd.vert_f16d2_inter_7[0], pvd.vert_f16d2_inter_7[1]), pvd.vert_f16d2_inter_7[2]), pvd.vert_f16d2_inter_7[3]))));
    bool good_vert_f16d2_flat_7 = all(lessThanEqual(vert_f16d2_flat_7[gl_InvocationID], f16vec2(max(max(max(pvd.vert_f16d2_flat_7[0], pvd.vert_f16d2_flat_7[1]), pvd.vert_f16d2_flat_7[2]), pvd.vert_f16d2_flat_7[3])))) && all(greaterThanEqual(vert_f16d2_flat_7[gl_InvocationID], f16vec2(min(min(min(pvd.vert_f16d2_flat_7[0], pvd.vert_f16d2_flat_7[1]), pvd.vert_f16d2_flat_7[2]), pvd.vert_f16d2_flat_7[3]))));
    bool good_vert_f64d3_flat_6 = all(lessThanEqual(vert_f64d3_flat_6[gl_InvocationID], f64vec3(max(max(max(pvd.vert_f64d3_flat_6[0], pvd.vert_f64d3_flat_6[1]), pvd.vert_f64d3_flat_6[2]), pvd.vert_f64d3_flat_6[3])))) && all(greaterThanEqual(vert_f64d3_flat_6[gl_InvocationID], f64vec3(min(min(min(pvd.vert_f64d3_flat_6[0], pvd.vert_f64d3_flat_6[1]), pvd.vert_f64d3_flat_6[2]), pvd.vert_f64d3_flat_6[3]))));
    bool good_vert_i32d4_flat_6 = all(lessThanEqual(vert_i32d4_flat_6[gl_InvocationID], i32vec4(max(max(max(pvd.vert_i32d4_flat_6[0], pvd.vert_i32d4_flat_6[1]), pvd.vert_i32d4_flat_6[2]), pvd.vert_i32d4_flat_6[3])))) && all(greaterThanEqual(vert_i32d4_flat_6[gl_InvocationID], i32vec4(min(min(min(pvd.vert_i32d4_flat_6[0], pvd.vert_i32d4_flat_6[1]), pvd.vert_i32d4_flat_6[2]), pvd.vert_i32d4_flat_6[3]))));
    bool good_vert_f32d4_flat_0 = all(lessThanEqual(vert_f32d4_flat_0[gl_InvocationID], f32vec4(max(max(max(pvd.vert_f32d4_flat_0[0], pvd.vert_f32d4_flat_0[1]), pvd.vert_f32d4_flat_0[2]), pvd.vert_f32d4_flat_0[3])))) && all(greaterThanEqual(vert_f32d4_flat_0[gl_InvocationID], f32vec4(min(min(min(pvd.vert_f32d4_flat_0[0], pvd.vert_f32d4_flat_0[1]), pvd.vert_f32d4_flat_0[2]), pvd.vert_f32d4_flat_0[3]))));
    bool good_vert_f16d3_inter_3 = all(lessThanEqual(vert_f16d3_inter_3[gl_InvocationID], f16vec3(max(max(max(pvd.vert_f16d3_inter_3[0], pvd.vert_f16d3_inter_3[1]), pvd.vert_f16d3_inter_3[2]), pvd.vert_f16d3_inter_3[3])))) && all(greaterThanEqual(vert_f16d3_inter_3[gl_InvocationID], f16vec3(min(min(min(pvd.vert_f16d3_inter_3[0], pvd.vert_f16d3_inter_3[1]), pvd.vert_f16d3_inter_3[2]), pvd.vert_f16d3_inter_3[3]))));
    bool good_vert_i16d4_flat_3 = all(lessThanEqual(vert_i16d4_flat_3[gl_InvocationID], i16vec4(max(max(max(pvd.vert_i16d4_flat_3[0], pvd.vert_i16d4_flat_3[1]), pvd.vert_i16d4_flat_3[2]), pvd.vert_i16d4_flat_3[3])))) && all(greaterThanEqual(vert_i16d4_flat_3[gl_InvocationID], i16vec4(min(min(min(pvd.vert_i16d4_flat_3[0], pvd.vert_i16d4_flat_3[1]), pvd.vert_i16d4_flat_3[2]), pvd.vert_i16d4_flat_3[3]))));
    bool good_vert_f32d4_flat_2 = all(lessThanEqual(vert_f32d4_flat_2[gl_InvocationID], f32vec4(max(max(max(pvd.vert_f32d4_flat_2[0], pvd.vert_f32d4_flat_2[1]), pvd.vert_f32d4_flat_2[2]), pvd.vert_f32d4_flat_2[3])))) && all(greaterThanEqual(vert_f32d4_flat_2[gl_InvocationID], f32vec4(min(min(min(pvd.vert_f32d4_flat_2[0], pvd.vert_f32d4_flat_2[1]), pvd.vert_f32d4_flat_2[2]), pvd.vert_f32d4_flat_2[3]))));
    bool good_vert_f16d3_flat_6 = all(lessThanEqual(vert_f16d3_flat_6[gl_InvocationID], f16vec3(max(max(max(pvd.vert_f16d3_flat_6[0], pvd.vert_f16d3_flat_6[1]), pvd.vert_f16d3_flat_6[2]), pvd.vert_f16d3_flat_6[3])))) && all(greaterThanEqual(vert_f16d3_flat_6[gl_InvocationID], f16vec3(min(min(min(pvd.vert_f16d3_flat_6[0], pvd.vert_f16d3_flat_6[1]), pvd.vert_f16d3_flat_6[2]), pvd.vert_f16d3_flat_6[3]))));
    bool good_vert_f16d1_flat_7 = (vert_f16d1_flat_7[gl_InvocationID] <= float16_t(max(max(max(pvd.vert_f16d1_flat_7[0], pvd.vert_f16d1_flat_7[1]), pvd.vert_f16d1_flat_7[2]), pvd.vert_f16d1_flat_7[3]))) && (vert_f16d1_flat_7[gl_InvocationID] >= float16_t(min(min(min(pvd.vert_f16d1_flat_7[0], pvd.vert_f16d1_flat_7[1]), pvd.vert_f16d1_flat_7[2]), pvd.vert_f16d1_flat_7[3])));
    bool good_vert_f32d2_flat_0 = all(lessThanEqual(vert_f32d2_flat_0[gl_InvocationID], f32vec2(max(max(max(pvd.vert_f32d2_flat_0[0], pvd.vert_f32d2_flat_0[1]), pvd.vert_f32d2_flat_0[2]), pvd.vert_f32d2_flat_0[3])))) && all(greaterThanEqual(vert_f32d2_flat_0[gl_InvocationID], f32vec2(min(min(min(pvd.vert_f32d2_flat_0[0], pvd.vert_f32d2_flat_0[1]), pvd.vert_f32d2_flat_0[2]), pvd.vert_f32d2_flat_0[3]))));
    bool good_vert_f32d4_flat_7 = all(lessThanEqual(vert_f32d4_flat_7[gl_InvocationID], f32vec4(max(max(max(pvd.vert_f32d4_flat_7[0], pvd.vert_f32d4_flat_7[1]), pvd.vert_f32d4_flat_7[2]), pvd.vert_f32d4_flat_7[3])))) && all(greaterThanEqual(vert_f32d4_flat_7[gl_InvocationID], f32vec4(min(min(min(pvd.vert_f32d4_flat_7[0], pvd.vert_f32d4_flat_7[1]), pvd.vert_f32d4_flat_7[2]), pvd.vert_f32d4_flat_7[3]))));
    bool good_vert_i16d2_flat_0 = all(lessThanEqual(vert_i16d2_flat_0[gl_InvocationID], i16vec2(max(max(max(pvd.vert_i16d2_flat_0[0], pvd.vert_i16d2_flat_0[1]), pvd.vert_i16d2_flat_0[2]), pvd.vert_i16d2_flat_0[3])))) && all(greaterThanEqual(vert_i16d2_flat_0[gl_InvocationID], i16vec2(min(min(min(pvd.vert_i16d2_flat_0[0], pvd.vert_i16d2_flat_0[1]), pvd.vert_i16d2_flat_0[2]), pvd.vert_i16d2_flat_0[3]))));
    if (good_vert_i64d4_flat_7 && good_vert_f64d1_flat_8 && good_vert_f64d2_flat_0 && good_vert_i16d4_flat_6 && good_vert_f16d3_flat_7 && good_vert_f32d3_flat_7 && good_vert_f16d3_inter_0 && good_vert_f32d2_flat_6 && good_vert_f32d2_inter_6 && good_vert_f16d4_flat_6 && good_vert_f32d3_inter_7 && good_vert_i64d1_flat_3 && good_vert_i64d2_flat_8 && good_vert_f16d2_inter_7 && good_vert_f16d2_flat_7 && good_vert_f64d3_flat_6 && good_vert_i32d4_flat_6 && good_vert_f32d4_flat_0 && good_vert_f16d3_inter_3 && good_vert_i16d4_flat_3 && good_vert_f32d4_flat_2 && good_vert_f16d3_flat_6 && good_vert_f16d1_flat_7 && good_vert_f32d2_flat_0 && good_vert_f32d4_flat_7 && good_vert_i16d2_flat_0) {
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
    ivec4 vert_i64d4_flat_7[4];
    float vert_f64d1_flat_8[4];
    vec2 vert_f64d2_flat_0[4];
    ivec4 vert_i16d4_flat_6[4];
    vec3 vert_f16d3_flat_7[4];
    vec3 vert_f32d3_flat_7[4];
    vec3 vert_f16d3_inter_0[4];
    vec2 vert_f32d2_flat_6[4];
    vec2 vert_f32d2_inter_6[4];
    vec4 vert_f16d4_flat_6[4];
    vec3 vert_f32d3_inter_7[4];
    int vert_i64d1_flat_3[4];
    ivec2 vert_i64d2_flat_8[4];
    vec2 vert_f16d2_inter_7[4];
    vec2 vert_f16d2_flat_7[4];
    vec3 vert_f64d3_flat_6[4];
    ivec4 vert_i32d4_flat_6[4];
    vec4 vert_f32d4_flat_0[4];
    vec3 vert_f16d3_inter_3[4];
    ivec4 vert_i16d4_flat_3[4];
    vec4 vert_f32d4_flat_2[4];
    vec3 vert_f16d3_flat_6[4];
    float vert_f16d1_flat_7[4];
    vec2 vert_f32d2_flat_0[4];
    vec4 vert_f32d4_flat_7[4];
    ivec2 vert_i16d2_flat_0[4];
 } pvd;

layout (location=0) in vec4 inColor[];

layout (location=1) in flat i64vec4 vert_i64d4_flat_7[];
layout (location=3) in flat float64_t vert_f64d1_flat_8[];
layout (location=4) in flat f64vec2 vert_f64d2_flat_0[];
layout (location=5) in flat i16vec4 vert_i16d4_flat_6[];
layout (location=6) in flat f16vec3 vert_f16d3_flat_7[];
layout (location=7) in flat f32vec3 vert_f32d3_flat_7[];
layout (location=8) in f16vec3 vert_f16d3_inter_0[];
layout (location=9) in flat f32vec2 vert_f32d2_flat_6[];
layout (location=10) in f32vec2 vert_f32d2_inter_6[];
layout (location=11) in flat f16vec4 vert_f16d4_flat_6[];
layout (location=12) in f32vec3 vert_f32d3_inter_7[];
layout (location=13) in flat int64_t vert_i64d1_flat_3[];
layout (location=14) in flat i64vec2 vert_i64d2_flat_8[];
layout (location=15) in f16vec2 vert_f16d2_inter_7[];
layout (location=16) in flat f16vec2 vert_f16d2_flat_7[];
layout (location=17) in flat f64vec3 vert_f64d3_flat_6[];
layout (location=19) in flat i32vec4 vert_i32d4_flat_6[];
layout (location=20) in flat f32vec4 vert_f32d4_flat_0[];
layout (location=21) in f16vec3 vert_f16d3_inter_3[];
layout (location=22) in flat i16vec4 vert_i16d4_flat_3[];
layout (location=23) in flat f32vec4 vert_f32d4_flat_2[];
layout (location=24) in flat f16vec3 vert_f16d3_flat_6[];
layout (location=25) in flat float16_t vert_f16d1_flat_7[];
layout (location=26) in flat f32vec2 vert_f32d2_flat_0[];
layout (location=27) in flat f32vec4 vert_f32d4_flat_7[];
layout (location=28) in flat i16vec2 vert_i16d2_flat_0[];

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
i64vec4 temp_vert_i64d4_flat_7;
INTERP_QUAD_VAR(i64vec4, var_vert_i64d4_flat_7 ,vert_i64d4_flat_7[i], temp_vert_i64d4_flat_7);
    bool good_vert_i64d4_flat_7 = all(lessThanEqual(temp_vert_i64d4_flat_7, i64vec4(max(max(max(pvd.vert_i64d4_flat_7[0], pvd.vert_i64d4_flat_7[1]), pvd.vert_i64d4_flat_7[2]), pvd.vert_i64d4_flat_7[3])))) && all(greaterThanEqual(temp_vert_i64d4_flat_7, i64vec4(min(min(min(pvd.vert_i64d4_flat_7[0], pvd.vert_i64d4_flat_7[1]), pvd.vert_i64d4_flat_7[2]), pvd.vert_i64d4_flat_7[3]))));
float64_t temp_vert_f64d1_flat_8;
INTERP_QUAD_VAR(float64_t, var_vert_f64d1_flat_8 ,vert_f64d1_flat_8[i], temp_vert_f64d1_flat_8);
    bool good_vert_f64d1_flat_8 = (temp_vert_f64d1_flat_8 <= float64_t(max(max(max(pvd.vert_f64d1_flat_8[0], pvd.vert_f64d1_flat_8[1]), pvd.vert_f64d1_flat_8[2]), pvd.vert_f64d1_flat_8[3]))) && (temp_vert_f64d1_flat_8 >= float64_t(min(min(min(pvd.vert_f64d1_flat_8[0], pvd.vert_f64d1_flat_8[1]), pvd.vert_f64d1_flat_8[2]), pvd.vert_f64d1_flat_8[3])));
f64vec2 temp_vert_f64d2_flat_0;
INTERP_QUAD_VAR(f64vec2, var_vert_f64d2_flat_0 ,vert_f64d2_flat_0[i], temp_vert_f64d2_flat_0);
    bool good_vert_f64d2_flat_0 = all(lessThanEqual(temp_vert_f64d2_flat_0, f64vec2(max(max(max(pvd.vert_f64d2_flat_0[0], pvd.vert_f64d2_flat_0[1]), pvd.vert_f64d2_flat_0[2]), pvd.vert_f64d2_flat_0[3])))) && all(greaterThanEqual(temp_vert_f64d2_flat_0, f64vec2(min(min(min(pvd.vert_f64d2_flat_0[0], pvd.vert_f64d2_flat_0[1]), pvd.vert_f64d2_flat_0[2]), pvd.vert_f64d2_flat_0[3]))));
i16vec4 temp_vert_i16d4_flat_6;
INTERP_QUAD_VAR(i16vec4, var_vert_i16d4_flat_6 ,vert_i16d4_flat_6[i], temp_vert_i16d4_flat_6);
    bool good_vert_i16d4_flat_6 = all(lessThanEqual(temp_vert_i16d4_flat_6, i16vec4(max(max(max(pvd.vert_i16d4_flat_6[0], pvd.vert_i16d4_flat_6[1]), pvd.vert_i16d4_flat_6[2]), pvd.vert_i16d4_flat_6[3])))) && all(greaterThanEqual(temp_vert_i16d4_flat_6, i16vec4(min(min(min(pvd.vert_i16d4_flat_6[0], pvd.vert_i16d4_flat_6[1]), pvd.vert_i16d4_flat_6[2]), pvd.vert_i16d4_flat_6[3]))));
f16vec3 temp_vert_f16d3_flat_7;
INTERP_QUAD_VAR(f16vec3, var_vert_f16d3_flat_7 ,vert_f16d3_flat_7[i], temp_vert_f16d3_flat_7);
    bool good_vert_f16d3_flat_7 = all(lessThanEqual(temp_vert_f16d3_flat_7, f16vec3(max(max(max(pvd.vert_f16d3_flat_7[0], pvd.vert_f16d3_flat_7[1]), pvd.vert_f16d3_flat_7[2]), pvd.vert_f16d3_flat_7[3])))) && all(greaterThanEqual(temp_vert_f16d3_flat_7, f16vec3(min(min(min(pvd.vert_f16d3_flat_7[0], pvd.vert_f16d3_flat_7[1]), pvd.vert_f16d3_flat_7[2]), pvd.vert_f16d3_flat_7[3]))));
f32vec3 temp_vert_f32d3_flat_7;
INTERP_QUAD_VAR(f32vec3, var_vert_f32d3_flat_7 ,vert_f32d3_flat_7[i], temp_vert_f32d3_flat_7);
    bool good_vert_f32d3_flat_7 = all(lessThanEqual(temp_vert_f32d3_flat_7, f32vec3(max(max(max(pvd.vert_f32d3_flat_7[0], pvd.vert_f32d3_flat_7[1]), pvd.vert_f32d3_flat_7[2]), pvd.vert_f32d3_flat_7[3])))) && all(greaterThanEqual(temp_vert_f32d3_flat_7, f32vec3(min(min(min(pvd.vert_f32d3_flat_7[0], pvd.vert_f32d3_flat_7[1]), pvd.vert_f32d3_flat_7[2]), pvd.vert_f32d3_flat_7[3]))));
f16vec3 temp_vert_f16d3_inter_0;
INTERP_QUAD_VAR(f16vec3, var_vert_f16d3_inter_0 ,vert_f16d3_inter_0[i], temp_vert_f16d3_inter_0);
    bool good_vert_f16d3_inter_0 = all(lessThanEqual(temp_vert_f16d3_inter_0, f16vec3(max(max(max(pvd.vert_f16d3_inter_0[0], pvd.vert_f16d3_inter_0[1]), pvd.vert_f16d3_inter_0[2]), pvd.vert_f16d3_inter_0[3])))) && all(greaterThanEqual(temp_vert_f16d3_inter_0, f16vec3(min(min(min(pvd.vert_f16d3_inter_0[0], pvd.vert_f16d3_inter_0[1]), pvd.vert_f16d3_inter_0[2]), pvd.vert_f16d3_inter_0[3]))));
f32vec2 temp_vert_f32d2_flat_6;
INTERP_QUAD_VAR(f32vec2, var_vert_f32d2_flat_6 ,vert_f32d2_flat_6[i], temp_vert_f32d2_flat_6);
    bool good_vert_f32d2_flat_6 = all(lessThanEqual(temp_vert_f32d2_flat_6, f32vec2(max(max(max(pvd.vert_f32d2_flat_6[0], pvd.vert_f32d2_flat_6[1]), pvd.vert_f32d2_flat_6[2]), pvd.vert_f32d2_flat_6[3])))) && all(greaterThanEqual(temp_vert_f32d2_flat_6, f32vec2(min(min(min(pvd.vert_f32d2_flat_6[0], pvd.vert_f32d2_flat_6[1]), pvd.vert_f32d2_flat_6[2]), pvd.vert_f32d2_flat_6[3]))));
f32vec2 temp_vert_f32d2_inter_6;
INTERP_QUAD_VAR(f32vec2, var_vert_f32d2_inter_6 ,vert_f32d2_inter_6[i], temp_vert_f32d2_inter_6);
    bool good_vert_f32d2_inter_6 = all(lessThanEqual(temp_vert_f32d2_inter_6, f32vec2(max(max(max(pvd.vert_f32d2_inter_6[0], pvd.vert_f32d2_inter_6[1]), pvd.vert_f32d2_inter_6[2]), pvd.vert_f32d2_inter_6[3])))) && all(greaterThanEqual(temp_vert_f32d2_inter_6, f32vec2(min(min(min(pvd.vert_f32d2_inter_6[0], pvd.vert_f32d2_inter_6[1]), pvd.vert_f32d2_inter_6[2]), pvd.vert_f32d2_inter_6[3]))));
f16vec4 temp_vert_f16d4_flat_6;
INTERP_QUAD_VAR(f16vec4, var_vert_f16d4_flat_6 ,vert_f16d4_flat_6[i], temp_vert_f16d4_flat_6);
    bool good_vert_f16d4_flat_6 = all(lessThanEqual(temp_vert_f16d4_flat_6, f16vec4(max(max(max(pvd.vert_f16d4_flat_6[0], pvd.vert_f16d4_flat_6[1]), pvd.vert_f16d4_flat_6[2]), pvd.vert_f16d4_flat_6[3])))) && all(greaterThanEqual(temp_vert_f16d4_flat_6, f16vec4(min(min(min(pvd.vert_f16d4_flat_6[0], pvd.vert_f16d4_flat_6[1]), pvd.vert_f16d4_flat_6[2]), pvd.vert_f16d4_flat_6[3]))));
f32vec3 temp_vert_f32d3_inter_7;
INTERP_QUAD_VAR(f32vec3, var_vert_f32d3_inter_7 ,vert_f32d3_inter_7[i], temp_vert_f32d3_inter_7);
    bool good_vert_f32d3_inter_7 = all(lessThanEqual(temp_vert_f32d3_inter_7, f32vec3(max(max(max(pvd.vert_f32d3_inter_7[0], pvd.vert_f32d3_inter_7[1]), pvd.vert_f32d3_inter_7[2]), pvd.vert_f32d3_inter_7[3])))) && all(greaterThanEqual(temp_vert_f32d3_inter_7, f32vec3(min(min(min(pvd.vert_f32d3_inter_7[0], pvd.vert_f32d3_inter_7[1]), pvd.vert_f32d3_inter_7[2]), pvd.vert_f32d3_inter_7[3]))));
int64_t temp_vert_i64d1_flat_3;
INTERP_QUAD_VAR(int64_t, var_vert_i64d1_flat_3 ,vert_i64d1_flat_3[i], temp_vert_i64d1_flat_3);
    bool good_vert_i64d1_flat_3 = (temp_vert_i64d1_flat_3 <= int64_t(max(max(max(pvd.vert_i64d1_flat_3[0], pvd.vert_i64d1_flat_3[1]), pvd.vert_i64d1_flat_3[2]), pvd.vert_i64d1_flat_3[3]))) && (temp_vert_i64d1_flat_3 >= int64_t(min(min(min(pvd.vert_i64d1_flat_3[0], pvd.vert_i64d1_flat_3[1]), pvd.vert_i64d1_flat_3[2]), pvd.vert_i64d1_flat_3[3])));
i64vec2 temp_vert_i64d2_flat_8;
INTERP_QUAD_VAR(i64vec2, var_vert_i64d2_flat_8 ,vert_i64d2_flat_8[i], temp_vert_i64d2_flat_8);
    bool good_vert_i64d2_flat_8 = all(lessThanEqual(temp_vert_i64d2_flat_8, i64vec2(max(max(max(pvd.vert_i64d2_flat_8[0], pvd.vert_i64d2_flat_8[1]), pvd.vert_i64d2_flat_8[2]), pvd.vert_i64d2_flat_8[3])))) && all(greaterThanEqual(temp_vert_i64d2_flat_8, i64vec2(min(min(min(pvd.vert_i64d2_flat_8[0], pvd.vert_i64d2_flat_8[1]), pvd.vert_i64d2_flat_8[2]), pvd.vert_i64d2_flat_8[3]))));
f16vec2 temp_vert_f16d2_inter_7;
INTERP_QUAD_VAR(f16vec2, var_vert_f16d2_inter_7 ,vert_f16d2_inter_7[i], temp_vert_f16d2_inter_7);
    bool good_vert_f16d2_inter_7 = all(lessThanEqual(temp_vert_f16d2_inter_7, f16vec2(max(max(max(pvd.vert_f16d2_inter_7[0], pvd.vert_f16d2_inter_7[1]), pvd.vert_f16d2_inter_7[2]), pvd.vert_f16d2_inter_7[3])))) && all(greaterThanEqual(temp_vert_f16d2_inter_7, f16vec2(min(min(min(pvd.vert_f16d2_inter_7[0], pvd.vert_f16d2_inter_7[1]), pvd.vert_f16d2_inter_7[2]), pvd.vert_f16d2_inter_7[3]))));
f16vec2 temp_vert_f16d2_flat_7;
INTERP_QUAD_VAR(f16vec2, var_vert_f16d2_flat_7 ,vert_f16d2_flat_7[i], temp_vert_f16d2_flat_7);
    bool good_vert_f16d2_flat_7 = all(lessThanEqual(temp_vert_f16d2_flat_7, f16vec2(max(max(max(pvd.vert_f16d2_flat_7[0], pvd.vert_f16d2_flat_7[1]), pvd.vert_f16d2_flat_7[2]), pvd.vert_f16d2_flat_7[3])))) && all(greaterThanEqual(temp_vert_f16d2_flat_7, f16vec2(min(min(min(pvd.vert_f16d2_flat_7[0], pvd.vert_f16d2_flat_7[1]), pvd.vert_f16d2_flat_7[2]), pvd.vert_f16d2_flat_7[3]))));
f64vec3 temp_vert_f64d3_flat_6;
INTERP_QUAD_VAR(f64vec3, var_vert_f64d3_flat_6 ,vert_f64d3_flat_6[i], temp_vert_f64d3_flat_6);
    bool good_vert_f64d3_flat_6 = all(lessThanEqual(temp_vert_f64d3_flat_6, f64vec3(max(max(max(pvd.vert_f64d3_flat_6[0], pvd.vert_f64d3_flat_6[1]), pvd.vert_f64d3_flat_6[2]), pvd.vert_f64d3_flat_6[3])))) && all(greaterThanEqual(temp_vert_f64d3_flat_6, f64vec3(min(min(min(pvd.vert_f64d3_flat_6[0], pvd.vert_f64d3_flat_6[1]), pvd.vert_f64d3_flat_6[2]), pvd.vert_f64d3_flat_6[3]))));
i32vec4 temp_vert_i32d4_flat_6;
INTERP_QUAD_VAR(i32vec4, var_vert_i32d4_flat_6 ,vert_i32d4_flat_6[i], temp_vert_i32d4_flat_6);
    bool good_vert_i32d4_flat_6 = all(lessThanEqual(temp_vert_i32d4_flat_6, i32vec4(max(max(max(pvd.vert_i32d4_flat_6[0], pvd.vert_i32d4_flat_6[1]), pvd.vert_i32d4_flat_6[2]), pvd.vert_i32d4_flat_6[3])))) && all(greaterThanEqual(temp_vert_i32d4_flat_6, i32vec4(min(min(min(pvd.vert_i32d4_flat_6[0], pvd.vert_i32d4_flat_6[1]), pvd.vert_i32d4_flat_6[2]), pvd.vert_i32d4_flat_6[3]))));
f32vec4 temp_vert_f32d4_flat_0;
INTERP_QUAD_VAR(f32vec4, var_vert_f32d4_flat_0 ,vert_f32d4_flat_0[i], temp_vert_f32d4_flat_0);
    bool good_vert_f32d4_flat_0 = all(lessThanEqual(temp_vert_f32d4_flat_0, f32vec4(max(max(max(pvd.vert_f32d4_flat_0[0], pvd.vert_f32d4_flat_0[1]), pvd.vert_f32d4_flat_0[2]), pvd.vert_f32d4_flat_0[3])))) && all(greaterThanEqual(temp_vert_f32d4_flat_0, f32vec4(min(min(min(pvd.vert_f32d4_flat_0[0], pvd.vert_f32d4_flat_0[1]), pvd.vert_f32d4_flat_0[2]), pvd.vert_f32d4_flat_0[3]))));
f16vec3 temp_vert_f16d3_inter_3;
INTERP_QUAD_VAR(f16vec3, var_vert_f16d3_inter_3 ,vert_f16d3_inter_3[i], temp_vert_f16d3_inter_3);
    bool good_vert_f16d3_inter_3 = all(lessThanEqual(temp_vert_f16d3_inter_3, f16vec3(max(max(max(pvd.vert_f16d3_inter_3[0], pvd.vert_f16d3_inter_3[1]), pvd.vert_f16d3_inter_3[2]), pvd.vert_f16d3_inter_3[3])))) && all(greaterThanEqual(temp_vert_f16d3_inter_3, f16vec3(min(min(min(pvd.vert_f16d3_inter_3[0], pvd.vert_f16d3_inter_3[1]), pvd.vert_f16d3_inter_3[2]), pvd.vert_f16d3_inter_3[3]))));
i16vec4 temp_vert_i16d4_flat_3;
INTERP_QUAD_VAR(i16vec4, var_vert_i16d4_flat_3 ,vert_i16d4_flat_3[i], temp_vert_i16d4_flat_3);
    bool good_vert_i16d4_flat_3 = all(lessThanEqual(temp_vert_i16d4_flat_3, i16vec4(max(max(max(pvd.vert_i16d4_flat_3[0], pvd.vert_i16d4_flat_3[1]), pvd.vert_i16d4_flat_3[2]), pvd.vert_i16d4_flat_3[3])))) && all(greaterThanEqual(temp_vert_i16d4_flat_3, i16vec4(min(min(min(pvd.vert_i16d4_flat_3[0], pvd.vert_i16d4_flat_3[1]), pvd.vert_i16d4_flat_3[2]), pvd.vert_i16d4_flat_3[3]))));
f32vec4 temp_vert_f32d4_flat_2;
INTERP_QUAD_VAR(f32vec4, var_vert_f32d4_flat_2 ,vert_f32d4_flat_2[i], temp_vert_f32d4_flat_2);
    bool good_vert_f32d4_flat_2 = all(lessThanEqual(temp_vert_f32d4_flat_2, f32vec4(max(max(max(pvd.vert_f32d4_flat_2[0], pvd.vert_f32d4_flat_2[1]), pvd.vert_f32d4_flat_2[2]), pvd.vert_f32d4_flat_2[3])))) && all(greaterThanEqual(temp_vert_f32d4_flat_2, f32vec4(min(min(min(pvd.vert_f32d4_flat_2[0], pvd.vert_f32d4_flat_2[1]), pvd.vert_f32d4_flat_2[2]), pvd.vert_f32d4_flat_2[3]))));
f16vec3 temp_vert_f16d3_flat_6;
INTERP_QUAD_VAR(f16vec3, var_vert_f16d3_flat_6 ,vert_f16d3_flat_6[i], temp_vert_f16d3_flat_6);
    bool good_vert_f16d3_flat_6 = all(lessThanEqual(temp_vert_f16d3_flat_6, f16vec3(max(max(max(pvd.vert_f16d3_flat_6[0], pvd.vert_f16d3_flat_6[1]), pvd.vert_f16d3_flat_6[2]), pvd.vert_f16d3_flat_6[3])))) && all(greaterThanEqual(temp_vert_f16d3_flat_6, f16vec3(min(min(min(pvd.vert_f16d3_flat_6[0], pvd.vert_f16d3_flat_6[1]), pvd.vert_f16d3_flat_6[2]), pvd.vert_f16d3_flat_6[3]))));
float16_t temp_vert_f16d1_flat_7;
INTERP_QUAD_VAR(float16_t, var_vert_f16d1_flat_7 ,vert_f16d1_flat_7[i], temp_vert_f16d1_flat_7);
    bool good_vert_f16d1_flat_7 = (temp_vert_f16d1_flat_7 <= float16_t(max(max(max(pvd.vert_f16d1_flat_7[0], pvd.vert_f16d1_flat_7[1]), pvd.vert_f16d1_flat_7[2]), pvd.vert_f16d1_flat_7[3]))) && (temp_vert_f16d1_flat_7 >= float16_t(min(min(min(pvd.vert_f16d1_flat_7[0], pvd.vert_f16d1_flat_7[1]), pvd.vert_f16d1_flat_7[2]), pvd.vert_f16d1_flat_7[3])));
f32vec2 temp_vert_f32d2_flat_0;
INTERP_QUAD_VAR(f32vec2, var_vert_f32d2_flat_0 ,vert_f32d2_flat_0[i], temp_vert_f32d2_flat_0);
    bool good_vert_f32d2_flat_0 = all(lessThanEqual(temp_vert_f32d2_flat_0, f32vec2(max(max(max(pvd.vert_f32d2_flat_0[0], pvd.vert_f32d2_flat_0[1]), pvd.vert_f32d2_flat_0[2]), pvd.vert_f32d2_flat_0[3])))) && all(greaterThanEqual(temp_vert_f32d2_flat_0, f32vec2(min(min(min(pvd.vert_f32d2_flat_0[0], pvd.vert_f32d2_flat_0[1]), pvd.vert_f32d2_flat_0[2]), pvd.vert_f32d2_flat_0[3]))));
f32vec4 temp_vert_f32d4_flat_7;
INTERP_QUAD_VAR(f32vec4, var_vert_f32d4_flat_7 ,vert_f32d4_flat_7[i], temp_vert_f32d4_flat_7);
    bool good_vert_f32d4_flat_7 = all(lessThanEqual(temp_vert_f32d4_flat_7, f32vec4(max(max(max(pvd.vert_f32d4_flat_7[0], pvd.vert_f32d4_flat_7[1]), pvd.vert_f32d4_flat_7[2]), pvd.vert_f32d4_flat_7[3])))) && all(greaterThanEqual(temp_vert_f32d4_flat_7, f32vec4(min(min(min(pvd.vert_f32d4_flat_7[0], pvd.vert_f32d4_flat_7[1]), pvd.vert_f32d4_flat_7[2]), pvd.vert_f32d4_flat_7[3]))));
i16vec2 temp_vert_i16d2_flat_0;
INTERP_QUAD_VAR(i16vec2, var_vert_i16d2_flat_0 ,vert_i16d2_flat_0[i], temp_vert_i16d2_flat_0);
    bool good_vert_i16d2_flat_0 = all(lessThanEqual(temp_vert_i16d2_flat_0, i16vec2(max(max(max(pvd.vert_i16d2_flat_0[0], pvd.vert_i16d2_flat_0[1]), pvd.vert_i16d2_flat_0[2]), pvd.vert_i16d2_flat_0[3])))) && all(greaterThanEqual(temp_vert_i16d2_flat_0, i16vec2(min(min(min(pvd.vert_i16d2_flat_0[0], pvd.vert_i16d2_flat_0[1]), pvd.vert_i16d2_flat_0[2]), pvd.vert_i16d2_flat_0[3]))));
    if (good_vert_i64d4_flat_7 && good_vert_f64d1_flat_8 && good_vert_f64d2_flat_0 && good_vert_i16d4_flat_6 && good_vert_f16d3_flat_7 && good_vert_f32d3_flat_7 && good_vert_f16d3_inter_0 && good_vert_f32d2_flat_6 && good_vert_f32d2_inter_6 && good_vert_f16d4_flat_6 && good_vert_f32d3_inter_7 && good_vert_i64d1_flat_3 && good_vert_i64d2_flat_8 && good_vert_f16d2_inter_7 && good_vert_f16d2_flat_7 && good_vert_f64d3_flat_6 && good_vert_i32d4_flat_6 && good_vert_f32d4_flat_0 && good_vert_f16d3_inter_3 && good_vert_i16d4_flat_3 && good_vert_f32d4_flat_2 && good_vert_f16d3_flat_6 && good_vert_f16d1_flat_7 && good_vert_f32d2_flat_0 && good_vert_f32d4_flat_7 && good_vert_i16d2_flat_0) {
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
    ivec4 vert_i64d4_flat_7[4];
    float vert_f64d1_flat_8[4];
    vec2 vert_f64d2_flat_0[4];
    ivec4 vert_i16d4_flat_6[4];
    vec3 vert_f16d3_flat_7[4];
    vec3 vert_f32d3_flat_7[4];
    vec3 vert_f16d3_inter_0[4];
    vec2 vert_f32d2_flat_6[4];
    vec2 vert_f32d2_inter_6[4];
    vec4 vert_f16d4_flat_6[4];
    vec3 vert_f32d3_inter_7[4];
    int vert_i64d1_flat_3[4];
    ivec2 vert_i64d2_flat_8[4];
    vec2 vert_f16d2_inter_7[4];
    vec2 vert_f16d2_flat_7[4];
    vec3 vert_f64d3_flat_6[4];
    ivec4 vert_i32d4_flat_6[4];
    vec4 vert_f32d4_flat_0[4];
    vec3 vert_f16d3_inter_3[4];
    ivec4 vert_i16d4_flat_3[4];
    vec4 vert_f32d4_flat_2[4];
    vec3 vert_f16d3_flat_6[4];
    float vert_f16d1_flat_7[4];
    vec2 vert_f32d2_flat_0[4];
    vec4 vert_f32d4_flat_7[4];
    ivec2 vert_i16d2_flat_0[4];
    int vert_i64d1_flat_1[4];
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
    ivec4 vert_i64d4_flat_7[4];
    float vert_f64d1_flat_8[4];
    vec2 vert_f64d2_flat_0[4];
    ivec4 vert_i16d4_flat_6[4];
    vec3 vert_f16d3_flat_7[4];
    vec3 vert_f32d3_flat_7[4];
    vec3 vert_f16d3_inter_0[4];
    vec2 vert_f32d2_flat_6[4];
    vec2 vert_f32d2_inter_6[4];
    vec4 vert_f16d4_flat_6[4];
    vec3 vert_f32d3_inter_7[4];
    int vert_i64d1_flat_3[4];
    ivec2 vert_i64d2_flat_8[4];
    vec2 vert_f16d2_inter_7[4];
    vec2 vert_f16d2_flat_7[4];
    vec3 vert_f64d3_flat_6[4];
    ivec4 vert_i32d4_flat_6[4];
    vec4 vert_f32d4_flat_0[4];
    vec3 vert_f16d3_inter_3[4];
    ivec4 vert_i16d4_flat_3[4];
    vec4 vert_f32d4_flat_2[4];
    vec3 vert_f16d3_flat_6[4];
    float vert_f16d1_flat_7[4];
    vec2 vert_f32d2_flat_0[4];
    vec4 vert_f32d4_flat_7[4];
    ivec2 vert_i16d2_flat_0[4];
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

layout (location=0) out patch float16_t patch_f16d1_inter_6;
layout (location=1) out patch f32vec3 patch_f32d3_inter_9;
layout (location=2) out patch f32vec4 patch_f32d4_inter_4;
layout (location=3) out patch f32vec2 patch_f32d2_inter_4;
layout (location=4) out patch f16vec2 patch_f16d2_inter_7;
layout (location=5) out patch f16vec3 patch_f16d3_inter_0;
layout (location=6) out patch f16vec2 patch_f16d2_inter_8;
layout (location=7) out patch f32vec4 patch_f32d4_inter_2;
layout (location=8) out patch f32vec2 patch_f32d2_inter_9;
layout (location=9) out patch float32_t patch_f32d1_inter_6;
layout (location=10) out patch float32_t patch_f32d1_inter_2;
layout (location=11) out patch float16_t patch_f16d1_inter_1;
layout (location=12) out patch f16vec3 patch_f16d3_inter_2;
layout (location=13) out patch f32vec3 patch_f32d3_inter_4;
layout (location=14) out patch f32vec2 patch_f32d2_inter_1;
layout (location=15) out patch f16vec4 patch_f16d4_inter_8;
layout (location=16) out patch f16vec2 patch_f16d2_inter_6;
layout (location=17) out patch f32vec2 patch_f32d2_inter_2;
layout (location=18) out patch float16_t patch_f16d1_inter_0;
layout (location=19) out patch float32_t patch_f32d1_inter_4;
layout (location=20) out patch f32vec3 patch_f32d3_inter_3;
layout (location=21) out patch f16vec3 patch_f16d3_inter_5;
layout (location=22) out patch f32vec4 patch_f32d4_inter_3;
layout (location=23) out patch f16vec3 patch_f16d3_inter_3;
layout (location=24) out patch f32vec2 patch_f32d2_inter_3;
layout (location=25) out patch f16vec2 patch_f16d2_inter_1;

layout(set=0, binding=0, std430) readonly buffer PerPatchBlock {
    float patch_f16d1_inter_6[2];
    vec3 patch_f32d3_inter_9[2];
    vec4 patch_f32d4_inter_4[2];
    vec2 patch_f32d2_inter_4[2];
    vec2 patch_f16d2_inter_7[2];
    vec3 patch_f16d3_inter_0[2];
    vec2 patch_f16d2_inter_8[2];
    vec4 patch_f32d4_inter_2[2];
    vec2 patch_f32d2_inter_9[2];
    float patch_f32d1_inter_6[2];
    float patch_f32d1_inter_2[2];
    float patch_f16d1_inter_1[2];
    vec3 patch_f16d3_inter_2[2];
    vec3 patch_f32d3_inter_4[2];
    vec2 patch_f32d2_inter_1[2];
    vec4 patch_f16d4_inter_8[2];
    vec2 patch_f16d2_inter_6[2];
    vec2 patch_f32d2_inter_2[2];
    float patch_f16d1_inter_0[2];
    float patch_f32d1_inter_4[2];
    vec3 patch_f32d3_inter_3[2];
    vec3 patch_f16d3_inter_5[2];
    vec4 patch_f32d4_inter_3[2];
    vec3 patch_f16d3_inter_3[2];
    vec2 patch_f32d2_inter_3[2];
    vec2 patch_f16d2_inter_1[2];
 } ppd;

in gl_PerVertex {
    vec4  gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
} gl_out[];

void main ()
{
    patch_f16d1_inter_6 = float16_t(ppd.patch_f16d1_inter_6[gl_PrimitiveID]);
    patch_f32d3_inter_9 = f32vec3(ppd.patch_f32d3_inter_9[gl_PrimitiveID]);
    patch_f32d4_inter_4 = f32vec4(ppd.patch_f32d4_inter_4[gl_PrimitiveID]);
    patch_f32d2_inter_4 = f32vec2(ppd.patch_f32d2_inter_4[gl_PrimitiveID]);
    patch_f16d2_inter_7 = f16vec2(ppd.patch_f16d2_inter_7[gl_PrimitiveID]);
    patch_f16d3_inter_0 = f16vec3(ppd.patch_f16d3_inter_0[gl_PrimitiveID]);
    patch_f16d2_inter_8 = f16vec2(ppd.patch_f16d2_inter_8[gl_PrimitiveID]);
    patch_f32d4_inter_2 = f32vec4(ppd.patch_f32d4_inter_2[gl_PrimitiveID]);
    patch_f32d2_inter_9 = f32vec2(ppd.patch_f32d2_inter_9[gl_PrimitiveID]);
    patch_f32d1_inter_6 = float32_t(ppd.patch_f32d1_inter_6[gl_PrimitiveID]);
    patch_f32d1_inter_2 = float32_t(ppd.patch_f32d1_inter_2[gl_PrimitiveID]);
    patch_f16d1_inter_1 = float16_t(ppd.patch_f16d1_inter_1[gl_PrimitiveID]);
    patch_f16d3_inter_2 = f16vec3(ppd.patch_f16d3_inter_2[gl_PrimitiveID]);
    patch_f32d3_inter_4 = f32vec3(ppd.patch_f32d3_inter_4[gl_PrimitiveID]);
    patch_f32d2_inter_1 = f32vec2(ppd.patch_f32d2_inter_1[gl_PrimitiveID]);
    patch_f16d4_inter_8 = f16vec4(ppd.patch_f16d4_inter_8[gl_PrimitiveID]);
    patch_f16d2_inter_6 = f16vec2(ppd.patch_f16d2_inter_6[gl_PrimitiveID]);
    patch_f32d2_inter_2 = f32vec2(ppd.patch_f32d2_inter_2[gl_PrimitiveID]);
    patch_f16d1_inter_0 = float16_t(ppd.patch_f16d1_inter_0[gl_PrimitiveID]);
    patch_f32d1_inter_4 = float32_t(ppd.patch_f32d1_inter_4[gl_PrimitiveID]);
    patch_f32d3_inter_3 = f32vec3(ppd.patch_f32d3_inter_3[gl_PrimitiveID]);
    patch_f16d3_inter_5 = f16vec3(ppd.patch_f16d3_inter_5[gl_PrimitiveID]);
    patch_f32d4_inter_3 = f32vec4(ppd.patch_f32d4_inter_3[gl_PrimitiveID]);
    patch_f16d3_inter_3 = f16vec3(ppd.patch_f16d3_inter_3[gl_PrimitiveID]);
    patch_f32d2_inter_3 = f32vec2(ppd.patch_f32d2_inter_3[gl_PrimitiveID]);
    patch_f16d2_inter_1 = f16vec2(ppd.patch_f16d2_inter_1[gl_PrimitiveID]);
   gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
   gl_TessLevelOuter = float[4](1.0, 1.0, 1.0, 1.0);
   gl_TessLevelInner = float[2](1.0, 1.0);

}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(quads, equal_spacing) in;

layout(set=0, binding=0, std430) readonly buffer PerPatchBlock {
    float patch_f16d1_inter_6[2];
    vec3 patch_f32d3_inter_9[2];
    vec4 patch_f32d4_inter_4[2];
    vec2 patch_f32d2_inter_4[2];
    vec2 patch_f16d2_inter_7[2];
    vec3 patch_f16d3_inter_0[2];
    vec2 patch_f16d2_inter_8[2];
    vec4 patch_f32d4_inter_2[2];
    vec2 patch_f32d2_inter_9[2];
    float patch_f32d1_inter_6[2];
    float patch_f32d1_inter_2[2];
    float patch_f16d1_inter_1[2];
    vec3 patch_f16d3_inter_2[2];
    vec3 patch_f32d3_inter_4[2];
    vec2 patch_f32d2_inter_1[2];
    vec4 patch_f16d4_inter_8[2];
    vec2 patch_f16d2_inter_6[2];
    vec2 patch_f32d2_inter_2[2];
    float patch_f16d1_inter_0[2];
    float patch_f32d1_inter_4[2];
    vec3 patch_f32d3_inter_3[2];
    vec3 patch_f16d3_inter_5[2];
    vec4 patch_f32d4_inter_3[2];
    vec3 patch_f16d3_inter_3[2];
    vec2 patch_f32d2_inter_3[2];
    vec2 patch_f16d2_inter_1[2];
 } ppd;

layout (location=0) in patch float16_t patch_f16d1_inter_6;
layout (location=1) in patch f32vec3 patch_f32d3_inter_9;
layout (location=2) in patch f32vec4 patch_f32d4_inter_4;
layout (location=3) in patch f32vec2 patch_f32d2_inter_4;
layout (location=4) in patch f16vec2 patch_f16d2_inter_7;
layout (location=5) in patch f16vec3 patch_f16d3_inter_0;
layout (location=6) in patch f16vec2 patch_f16d2_inter_8;
layout (location=7) in patch f32vec4 patch_f32d4_inter_2;
layout (location=8) in patch f32vec2 patch_f32d2_inter_9;
layout (location=9) in patch float32_t patch_f32d1_inter_6;
layout (location=10) in patch float32_t patch_f32d1_inter_2;
layout (location=11) in patch float16_t patch_f16d1_inter_1;
layout (location=12) in patch f16vec3 patch_f16d3_inter_2;
layout (location=13) in patch f32vec3 patch_f32d3_inter_4;
layout (location=14) in patch f32vec2 patch_f32d2_inter_1;
layout (location=15) in patch f16vec4 patch_f16d4_inter_8;
layout (location=16) in patch f16vec2 patch_f16d2_inter_6;
layout (location=17) in patch f32vec2 patch_f32d2_inter_2;
layout (location=18) in patch float16_t patch_f16d1_inter_0;
layout (location=19) in patch float32_t patch_f32d1_inter_4;
layout (location=20) in patch f32vec3 patch_f32d3_inter_3;
layout (location=21) in patch f16vec3 patch_f16d3_inter_5;
layout (location=22) in patch f32vec4 patch_f32d4_inter_3;
layout (location=23) in patch f16vec3 patch_f16d3_inter_3;
layout (location=24) in patch f32vec2 patch_f32d2_inter_3;
layout (location=25) in patch f16vec2 patch_f16d2_inter_1;

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
    bool good_patch_f16d1_inter_6 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d1_inter_6 == ppd.patch_f16d1_inter_6[0]) || (gl_PrimitiveID == 1 && patch_f16d1_inter_6 == ppd.patch_f16d1_inter_6[1])));
    bool good_patch_f32d3_inter_9 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d3_inter_9 == ppd.patch_f32d3_inter_9[0]) || (gl_PrimitiveID == 1 && patch_f32d3_inter_9 == ppd.patch_f32d3_inter_9[1])));
    bool good_patch_f32d4_inter_4 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d4_inter_4 == ppd.patch_f32d4_inter_4[0]) || (gl_PrimitiveID == 1 && patch_f32d4_inter_4 == ppd.patch_f32d4_inter_4[1])));
    bool good_patch_f32d2_inter_4 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d2_inter_4 == ppd.patch_f32d2_inter_4[0]) || (gl_PrimitiveID == 1 && patch_f32d2_inter_4 == ppd.patch_f32d2_inter_4[1])));
    bool good_patch_f16d2_inter_7 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d2_inter_7 == ppd.patch_f16d2_inter_7[0]) || (gl_PrimitiveID == 1 && patch_f16d2_inter_7 == ppd.patch_f16d2_inter_7[1])));
    bool good_patch_f16d3_inter_0 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d3_inter_0 == ppd.patch_f16d3_inter_0[0]) || (gl_PrimitiveID == 1 && patch_f16d3_inter_0 == ppd.patch_f16d3_inter_0[1])));
    bool good_patch_f16d2_inter_8 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d2_inter_8 == ppd.patch_f16d2_inter_8[0]) || (gl_PrimitiveID == 1 && patch_f16d2_inter_8 == ppd.patch_f16d2_inter_8[1])));
    bool good_patch_f32d4_inter_2 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d4_inter_2 == ppd.patch_f32d4_inter_2[0]) || (gl_PrimitiveID == 1 && patch_f32d4_inter_2 == ppd.patch_f32d4_inter_2[1])));
    bool good_patch_f32d2_inter_9 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d2_inter_9 == ppd.patch_f32d2_inter_9[0]) || (gl_PrimitiveID == 1 && patch_f32d2_inter_9 == ppd.patch_f32d2_inter_9[1])));
    bool good_patch_f32d1_inter_6 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d1_inter_6 == ppd.patch_f32d1_inter_6[0]) || (gl_PrimitiveID == 1 && patch_f32d1_inter_6 == ppd.patch_f32d1_inter_6[1])));
    bool good_patch_f32d1_inter_2 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d1_inter_2 == ppd.patch_f32d1_inter_2[0]) || (gl_PrimitiveID == 1 && patch_f32d1_inter_2 == ppd.patch_f32d1_inter_2[1])));
    bool good_patch_f16d1_inter_1 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d1_inter_1 == ppd.patch_f16d1_inter_1[0]) || (gl_PrimitiveID == 1 && patch_f16d1_inter_1 == ppd.patch_f16d1_inter_1[1])));
    bool good_patch_f16d3_inter_2 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d3_inter_2 == ppd.patch_f16d3_inter_2[0]) || (gl_PrimitiveID == 1 && patch_f16d3_inter_2 == ppd.patch_f16d3_inter_2[1])));
    bool good_patch_f32d3_inter_4 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d3_inter_4 == ppd.patch_f32d3_inter_4[0]) || (gl_PrimitiveID == 1 && patch_f32d3_inter_4 == ppd.patch_f32d3_inter_4[1])));
    bool good_patch_f32d2_inter_1 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d2_inter_1 == ppd.patch_f32d2_inter_1[0]) || (gl_PrimitiveID == 1 && patch_f32d2_inter_1 == ppd.patch_f32d2_inter_1[1])));
    bool good_patch_f16d4_inter_8 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d4_inter_8 == ppd.patch_f16d4_inter_8[0]) || (gl_PrimitiveID == 1 && patch_f16d4_inter_8 == ppd.patch_f16d4_inter_8[1])));
    bool good_patch_f16d2_inter_6 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d2_inter_6 == ppd.patch_f16d2_inter_6[0]) || (gl_PrimitiveID == 1 && patch_f16d2_inter_6 == ppd.patch_f16d2_inter_6[1])));
    bool good_patch_f32d2_inter_2 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d2_inter_2 == ppd.patch_f32d2_inter_2[0]) || (gl_PrimitiveID == 1 && patch_f32d2_inter_2 == ppd.patch_f32d2_inter_2[1])));
    bool good_patch_f16d1_inter_0 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d1_inter_0 == ppd.patch_f16d1_inter_0[0]) || (gl_PrimitiveID == 1 && patch_f16d1_inter_0 == ppd.patch_f16d1_inter_0[1])));
    bool good_patch_f32d1_inter_4 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d1_inter_4 == ppd.patch_f32d1_inter_4[0]) || (gl_PrimitiveID == 1 && patch_f32d1_inter_4 == ppd.patch_f32d1_inter_4[1])));
    bool good_patch_f32d3_inter_3 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d3_inter_3 == ppd.patch_f32d3_inter_3[0]) || (gl_PrimitiveID == 1 && patch_f32d3_inter_3 == ppd.patch_f32d3_inter_3[1])));
    bool good_patch_f16d3_inter_5 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d3_inter_5 == ppd.patch_f16d3_inter_5[0]) || (gl_PrimitiveID == 1 && patch_f16d3_inter_5 == ppd.patch_f16d3_inter_5[1])));
    bool good_patch_f32d4_inter_3 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d4_inter_3 == ppd.patch_f32d4_inter_3[0]) || (gl_PrimitiveID == 1 && patch_f32d4_inter_3 == ppd.patch_f32d4_inter_3[1])));
    bool good_patch_f16d3_inter_3 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d3_inter_3 == ppd.patch_f16d3_inter_3[0]) || (gl_PrimitiveID == 1 && patch_f16d3_inter_3 == ppd.patch_f16d3_inter_3[1])));
    bool good_patch_f32d2_inter_3 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d2_inter_3 == ppd.patch_f32d2_inter_3[0]) || (gl_PrimitiveID == 1 && patch_f32d2_inter_3 == ppd.patch_f32d2_inter_3[1])));
    bool good_patch_f16d2_inter_1 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d2_inter_1 == ppd.patch_f16d2_inter_1[0]) || (gl_PrimitiveID == 1 && patch_f16d2_inter_1 == ppd.patch_f16d2_inter_1[1])));
    if (good_patch_f16d1_inter_6 && good_patch_f32d3_inter_9 && good_patch_f32d4_inter_4 && good_patch_f32d2_inter_4 && good_patch_f16d2_inter_7 && good_patch_f16d3_inter_0 && good_patch_f16d2_inter_8 && good_patch_f32d4_inter_2 && good_patch_f32d2_inter_9 && good_patch_f32d1_inter_6 && good_patch_f32d1_inter_2 && good_patch_f16d1_inter_1 && good_patch_f16d3_inter_2 && good_patch_f32d3_inter_4 && good_patch_f32d2_inter_1 && good_patch_f16d4_inter_8 && good_patch_f16d2_inter_6 && good_patch_f32d2_inter_2 && good_patch_f16d1_inter_0 && good_patch_f32d1_inter_4 && good_patch_f32d3_inter_3 && good_patch_f16d3_inter_5 && good_patch_f32d4_inter_3 && good_patch_f16d3_inter_3 && good_patch_f32d2_inter_3 && good_patch_f16d2_inter_1) {
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

layout (location=1) out patch float16_t patch_f16d1_inter_6;
layout (location=2) out patch f32vec3 patch_f32d3_inter_9;
layout (location=3) out patch f32vec4 patch_f32d4_inter_4;
layout (location=4) out patch f32vec2 patch_f32d2_inter_4;
layout (location=5) out patch f16vec2 patch_f16d2_inter_7;
layout (location=6) out patch f16vec3 patch_f16d3_inter_0;
layout (location=7) out patch f16vec2 patch_f16d2_inter_8;
layout (location=8) out patch f32vec4 patch_f32d4_inter_2;
layout (location=9) out patch f32vec2 patch_f32d2_inter_9;
layout (location=10) out patch float32_t patch_f32d1_inter_6;
layout (location=11) out patch float32_t patch_f32d1_inter_2;
layout (location=12) out patch float16_t patch_f16d1_inter_1;
layout (location=13) out patch f16vec3 patch_f16d3_inter_2;
layout (location=14) out patch f32vec3 patch_f32d3_inter_4;
layout (location=15) out patch f32vec2 patch_f32d2_inter_1;
layout (location=16) out patch f16vec4 patch_f16d4_inter_8;
layout (location=17) out patch f16vec2 patch_f16d2_inter_6;
layout (location=18) out patch f32vec2 patch_f32d2_inter_2;
layout (location=19) out patch float16_t patch_f16d1_inter_0;
layout (location=20) out patch float32_t patch_f32d1_inter_4;
layout (location=21) out patch f32vec3 patch_f32d3_inter_3;
layout (location=22) out patch f16vec3 patch_f16d3_inter_5;
layout (location=23) out patch f32vec4 patch_f32d4_inter_3;
layout (location=24) out patch f16vec3 patch_f16d3_inter_3;
layout (location=25) out patch f32vec2 patch_f32d2_inter_3;
layout (location=26) out patch f16vec2 patch_f16d2_inter_1;

layout(set=0, binding=0, std430) readonly buffer PerPatchBlock {
    float patch_f16d1_inter_6[2];
    vec3 patch_f32d3_inter_9[2];
    vec4 patch_f32d4_inter_4[2];
    vec2 patch_f32d2_inter_4[2];
    vec2 patch_f16d2_inter_7[2];
    vec3 patch_f16d3_inter_0[2];
    vec2 patch_f16d2_inter_8[2];
    vec4 patch_f32d4_inter_2[2];
    vec2 patch_f32d2_inter_9[2];
    float patch_f32d1_inter_6[2];
    float patch_f32d1_inter_2[2];
    float patch_f16d1_inter_1[2];
    vec3 patch_f16d3_inter_2[2];
    vec3 patch_f32d3_inter_4[2];
    vec2 patch_f32d2_inter_1[2];
    vec4 patch_f16d4_inter_8[2];
    vec2 patch_f16d2_inter_6[2];
    vec2 patch_f32d2_inter_2[2];
    float patch_f16d1_inter_0[2];
    float patch_f32d1_inter_4[2];
    vec3 patch_f32d3_inter_3[2];
    vec3 patch_f16d3_inter_5[2];
    vec4 patch_f32d4_inter_3[2];
    vec3 patch_f16d3_inter_3[2];
    vec2 patch_f32d2_inter_3[2];
    vec2 patch_f16d2_inter_1[2];
 } ppd;

in gl_PerVertex {
    vec4  gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
} gl_out[];

void main ()
{
    patch_f16d1_inter_6 = float16_t(ppd.patch_f16d1_inter_6[gl_PrimitiveID]);
    patch_f32d3_inter_9 = f32vec3(ppd.patch_f32d3_inter_9[gl_PrimitiveID]);
    patch_f32d4_inter_4 = f32vec4(ppd.patch_f32d4_inter_4[gl_PrimitiveID]);
    patch_f32d2_inter_4 = f32vec2(ppd.patch_f32d2_inter_4[gl_PrimitiveID]);
    patch_f16d2_inter_7 = f16vec2(ppd.patch_f16d2_inter_7[gl_PrimitiveID]);
    patch_f16d3_inter_0 = f16vec3(ppd.patch_f16d3_inter_0[gl_PrimitiveID]);
    patch_f16d2_inter_8 = f16vec2(ppd.patch_f16d2_inter_8[gl_PrimitiveID]);
    patch_f32d4_inter_2 = f32vec4(ppd.patch_f32d4_inter_2[gl_PrimitiveID]);
    patch_f32d2_inter_9 = f32vec2(ppd.patch_f32d2_inter_9[gl_PrimitiveID]);
    patch_f32d1_inter_6 = float32_t(ppd.patch_f32d1_inter_6[gl_PrimitiveID]);
    patch_f32d1_inter_2 = float32_t(ppd.patch_f32d1_inter_2[gl_PrimitiveID]);
    patch_f16d1_inter_1 = float16_t(ppd.patch_f16d1_inter_1[gl_PrimitiveID]);
    patch_f16d3_inter_2 = f16vec3(ppd.patch_f16d3_inter_2[gl_PrimitiveID]);
    patch_f32d3_inter_4 = f32vec3(ppd.patch_f32d3_inter_4[gl_PrimitiveID]);
    patch_f32d2_inter_1 = f32vec2(ppd.patch_f32d2_inter_1[gl_PrimitiveID]);
    patch_f16d4_inter_8 = f16vec4(ppd.patch_f16d4_inter_8[gl_PrimitiveID]);
    patch_f16d2_inter_6 = f16vec2(ppd.patch_f16d2_inter_6[gl_PrimitiveID]);
    patch_f32d2_inter_2 = f32vec2(ppd.patch_f32d2_inter_2[gl_PrimitiveID]);
    patch_f16d1_inter_0 = float16_t(ppd.patch_f16d1_inter_0[gl_PrimitiveID]);
    patch_f32d1_inter_4 = float32_t(ppd.patch_f32d1_inter_4[gl_PrimitiveID]);
    patch_f32d3_inter_3 = f32vec3(ppd.patch_f32d3_inter_3[gl_PrimitiveID]);
    patch_f16d3_inter_5 = f16vec3(ppd.patch_f16d3_inter_5[gl_PrimitiveID]);
    patch_f32d4_inter_3 = f32vec4(ppd.patch_f32d4_inter_3[gl_PrimitiveID]);
    patch_f16d3_inter_3 = f16vec3(ppd.patch_f16d3_inter_3[gl_PrimitiveID]);
    patch_f32d2_inter_3 = f32vec2(ppd.patch_f32d2_inter_3[gl_PrimitiveID]);
    patch_f16d2_inter_1 = f16vec2(ppd.patch_f16d2_inter_1[gl_PrimitiveID]);
    bool good_patch_f16d1_inter_6 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d1_inter_6 == ppd.patch_f16d1_inter_6[0]) || (gl_PrimitiveID == 1 && patch_f16d1_inter_6 == ppd.patch_f16d1_inter_6[1])));
    bool good_patch_f32d3_inter_9 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d3_inter_9 == ppd.patch_f32d3_inter_9[0]) || (gl_PrimitiveID == 1 && patch_f32d3_inter_9 == ppd.patch_f32d3_inter_9[1])));
    bool good_patch_f32d4_inter_4 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d4_inter_4 == ppd.patch_f32d4_inter_4[0]) || (gl_PrimitiveID == 1 && patch_f32d4_inter_4 == ppd.patch_f32d4_inter_4[1])));
    bool good_patch_f32d2_inter_4 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d2_inter_4 == ppd.patch_f32d2_inter_4[0]) || (gl_PrimitiveID == 1 && patch_f32d2_inter_4 == ppd.patch_f32d2_inter_4[1])));
    bool good_patch_f16d2_inter_7 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d2_inter_7 == ppd.patch_f16d2_inter_7[0]) || (gl_PrimitiveID == 1 && patch_f16d2_inter_7 == ppd.patch_f16d2_inter_7[1])));
    bool good_patch_f16d3_inter_0 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d3_inter_0 == ppd.patch_f16d3_inter_0[0]) || (gl_PrimitiveID == 1 && patch_f16d3_inter_0 == ppd.patch_f16d3_inter_0[1])));
    bool good_patch_f16d2_inter_8 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d2_inter_8 == ppd.patch_f16d2_inter_8[0]) || (gl_PrimitiveID == 1 && patch_f16d2_inter_8 == ppd.patch_f16d2_inter_8[1])));
    bool good_patch_f32d4_inter_2 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d4_inter_2 == ppd.patch_f32d4_inter_2[0]) || (gl_PrimitiveID == 1 && patch_f32d4_inter_2 == ppd.patch_f32d4_inter_2[1])));
    bool good_patch_f32d2_inter_9 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d2_inter_9 == ppd.patch_f32d2_inter_9[0]) || (gl_PrimitiveID == 1 && patch_f32d2_inter_9 == ppd.patch_f32d2_inter_9[1])));
    bool good_patch_f32d1_inter_6 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d1_inter_6 == ppd.patch_f32d1_inter_6[0]) || (gl_PrimitiveID == 1 && patch_f32d1_inter_6 == ppd.patch_f32d1_inter_6[1])));
    bool good_patch_f32d1_inter_2 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d1_inter_2 == ppd.patch_f32d1_inter_2[0]) || (gl_PrimitiveID == 1 && patch_f32d1_inter_2 == ppd.patch_f32d1_inter_2[1])));
    bool good_patch_f16d1_inter_1 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d1_inter_1 == ppd.patch_f16d1_inter_1[0]) || (gl_PrimitiveID == 1 && patch_f16d1_inter_1 == ppd.patch_f16d1_inter_1[1])));
    bool good_patch_f16d3_inter_2 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d3_inter_2 == ppd.patch_f16d3_inter_2[0]) || (gl_PrimitiveID == 1 && patch_f16d3_inter_2 == ppd.patch_f16d3_inter_2[1])));
    bool good_patch_f32d3_inter_4 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d3_inter_4 == ppd.patch_f32d3_inter_4[0]) || (gl_PrimitiveID == 1 && patch_f32d3_inter_4 == ppd.patch_f32d3_inter_4[1])));
    bool good_patch_f32d2_inter_1 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d2_inter_1 == ppd.patch_f32d2_inter_1[0]) || (gl_PrimitiveID == 1 && patch_f32d2_inter_1 == ppd.patch_f32d2_inter_1[1])));
    bool good_patch_f16d4_inter_8 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d4_inter_8 == ppd.patch_f16d4_inter_8[0]) || (gl_PrimitiveID == 1 && patch_f16d4_inter_8 == ppd.patch_f16d4_inter_8[1])));
    bool good_patch_f16d2_inter_6 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d2_inter_6 == ppd.patch_f16d2_inter_6[0]) || (gl_PrimitiveID == 1 && patch_f16d2_inter_6 == ppd.patch_f16d2_inter_6[1])));
    bool good_patch_f32d2_inter_2 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d2_inter_2 == ppd.patch_f32d2_inter_2[0]) || (gl_PrimitiveID == 1 && patch_f32d2_inter_2 == ppd.patch_f32d2_inter_2[1])));
    bool good_patch_f16d1_inter_0 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d1_inter_0 == ppd.patch_f16d1_inter_0[0]) || (gl_PrimitiveID == 1 && patch_f16d1_inter_0 == ppd.patch_f16d1_inter_0[1])));
    bool good_patch_f32d1_inter_4 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d1_inter_4 == ppd.patch_f32d1_inter_4[0]) || (gl_PrimitiveID == 1 && patch_f32d1_inter_4 == ppd.patch_f32d1_inter_4[1])));
    bool good_patch_f32d3_inter_3 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d3_inter_3 == ppd.patch_f32d3_inter_3[0]) || (gl_PrimitiveID == 1 && patch_f32d3_inter_3 == ppd.patch_f32d3_inter_3[1])));
    bool good_patch_f16d3_inter_5 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d3_inter_5 == ppd.patch_f16d3_inter_5[0]) || (gl_PrimitiveID == 1 && patch_f16d3_inter_5 == ppd.patch_f16d3_inter_5[1])));
    bool good_patch_f32d4_inter_3 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d4_inter_3 == ppd.patch_f32d4_inter_3[0]) || (gl_PrimitiveID == 1 && patch_f32d4_inter_3 == ppd.patch_f32d4_inter_3[1])));
    bool good_patch_f16d3_inter_3 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d3_inter_3 == ppd.patch_f16d3_inter_3[0]) || (gl_PrimitiveID == 1 && patch_f16d3_inter_3 == ppd.patch_f16d3_inter_3[1])));
    bool good_patch_f32d2_inter_3 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d2_inter_3 == ppd.patch_f32d2_inter_3[0]) || (gl_PrimitiveID == 1 && patch_f32d2_inter_3 == ppd.patch_f32d2_inter_3[1])));
    bool good_patch_f16d2_inter_1 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d2_inter_1 == ppd.patch_f16d2_inter_1[0]) || (gl_PrimitiveID == 1 && patch_f16d2_inter_1 == ppd.patch_f16d2_inter_1[1])));
    if (good_patch_f16d1_inter_6 && good_patch_f32d3_inter_9 && good_patch_f32d4_inter_4 && good_patch_f32d2_inter_4 && good_patch_f16d2_inter_7 && good_patch_f16d3_inter_0 && good_patch_f16d2_inter_8 && good_patch_f32d4_inter_2 && good_patch_f32d2_inter_9 && good_patch_f32d1_inter_6 && good_patch_f32d1_inter_2 && good_patch_f16d1_inter_1 && good_patch_f16d3_inter_2 && good_patch_f32d3_inter_4 && good_patch_f32d2_inter_1 && good_patch_f16d4_inter_8 && good_patch_f16d2_inter_6 && good_patch_f32d2_inter_2 && good_patch_f16d1_inter_0 && good_patch_f32d1_inter_4 && good_patch_f32d3_inter_3 && good_patch_f16d3_inter_5 && good_patch_f32d4_inter_3 && good_patch_f16d3_inter_3 && good_patch_f32d2_inter_3 && good_patch_f16d2_inter_1) {
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
    float patch_f16d1_inter_6[2];
    vec3 patch_f32d3_inter_9[2];
    vec4 patch_f32d4_inter_4[2];
    vec2 patch_f32d2_inter_4[2];
    vec2 patch_f16d2_inter_7[2];
    vec3 patch_f16d3_inter_0[2];
    vec2 patch_f16d2_inter_8[2];
    vec4 patch_f32d4_inter_2[2];
    vec2 patch_f32d2_inter_9[2];
    float patch_f32d1_inter_6[2];
    float patch_f32d1_inter_2[2];
    float patch_f16d1_inter_1[2];
    vec3 patch_f16d3_inter_2[2];
    vec3 patch_f32d3_inter_4[2];
    vec2 patch_f32d2_inter_1[2];
    vec4 patch_f16d4_inter_8[2];
    vec2 patch_f16d2_inter_6[2];
    vec2 patch_f32d2_inter_2[2];
    float patch_f16d1_inter_0[2];
    float patch_f32d1_inter_4[2];
    vec3 patch_f32d3_inter_3[2];
    vec3 patch_f16d3_inter_5[2];
    vec4 patch_f32d4_inter_3[2];
    vec3 patch_f16d3_inter_3[2];
    vec2 patch_f32d2_inter_3[2];
    vec2 patch_f16d2_inter_1[2];
 } ppd;

layout (location=0) in vec4 inColor[];

layout (location=1) in patch float16_t patch_f16d1_inter_6;
layout (location=2) in patch f32vec3 patch_f32d3_inter_9;
layout (location=3) in patch f32vec4 patch_f32d4_inter_4;
layout (location=4) in patch f32vec2 patch_f32d2_inter_4;
layout (location=5) in patch f16vec2 patch_f16d2_inter_7;
layout (location=6) in patch f16vec3 patch_f16d3_inter_0;
layout (location=7) in patch f16vec2 patch_f16d2_inter_8;
layout (location=8) in patch f32vec4 patch_f32d4_inter_2;
layout (location=9) in patch f32vec2 patch_f32d2_inter_9;
layout (location=10) in patch float32_t patch_f32d1_inter_6;
layout (location=11) in patch float32_t patch_f32d1_inter_2;
layout (location=12) in patch float16_t patch_f16d1_inter_1;
layout (location=13) in patch f16vec3 patch_f16d3_inter_2;
layout (location=14) in patch f32vec3 patch_f32d3_inter_4;
layout (location=15) in patch f32vec2 patch_f32d2_inter_1;
layout (location=16) in patch f16vec4 patch_f16d4_inter_8;
layout (location=17) in patch f16vec2 patch_f16d2_inter_6;
layout (location=18) in patch f32vec2 patch_f32d2_inter_2;
layout (location=19) in patch float16_t patch_f16d1_inter_0;
layout (location=20) in patch float32_t patch_f32d1_inter_4;
layout (location=21) in patch f32vec3 patch_f32d3_inter_3;
layout (location=22) in patch f16vec3 patch_f16d3_inter_5;
layout (location=23) in patch f32vec4 patch_f32d4_inter_3;
layout (location=24) in patch f16vec3 patch_f16d3_inter_3;
layout (location=25) in patch f32vec2 patch_f32d2_inter_3;
layout (location=26) in patch f16vec2 patch_f16d2_inter_1;

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
    bool good_patch_f16d1_inter_6 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d1_inter_6 == ppd.patch_f16d1_inter_6[0]) || (gl_PrimitiveID == 1 && patch_f16d1_inter_6 == ppd.patch_f16d1_inter_6[1])));
    bool good_patch_f32d3_inter_9 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d3_inter_9 == ppd.patch_f32d3_inter_9[0]) || (gl_PrimitiveID == 1 && patch_f32d3_inter_9 == ppd.patch_f32d3_inter_9[1])));
    bool good_patch_f32d4_inter_4 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d4_inter_4 == ppd.patch_f32d4_inter_4[0]) || (gl_PrimitiveID == 1 && patch_f32d4_inter_4 == ppd.patch_f32d4_inter_4[1])));
    bool good_patch_f32d2_inter_4 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d2_inter_4 == ppd.patch_f32d2_inter_4[0]) || (gl_PrimitiveID == 1 && patch_f32d2_inter_4 == ppd.patch_f32d2_inter_4[1])));
    bool good_patch_f16d2_inter_7 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d2_inter_7 == ppd.patch_f16d2_inter_7[0]) || (gl_PrimitiveID == 1 && patch_f16d2_inter_7 == ppd.patch_f16d2_inter_7[1])));
    bool good_patch_f16d3_inter_0 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d3_inter_0 == ppd.patch_f16d3_inter_0[0]) || (gl_PrimitiveID == 1 && patch_f16d3_inter_0 == ppd.patch_f16d3_inter_0[1])));
    bool good_patch_f16d2_inter_8 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d2_inter_8 == ppd.patch_f16d2_inter_8[0]) || (gl_PrimitiveID == 1 && patch_f16d2_inter_8 == ppd.patch_f16d2_inter_8[1])));
    bool good_patch_f32d4_inter_2 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d4_inter_2 == ppd.patch_f32d4_inter_2[0]) || (gl_PrimitiveID == 1 && patch_f32d4_inter_2 == ppd.patch_f32d4_inter_2[1])));
    bool good_patch_f32d2_inter_9 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d2_inter_9 == ppd.patch_f32d2_inter_9[0]) || (gl_PrimitiveID == 1 && patch_f32d2_inter_9 == ppd.patch_f32d2_inter_9[1])));
    bool good_patch_f32d1_inter_6 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d1_inter_6 == ppd.patch_f32d1_inter_6[0]) || (gl_PrimitiveID == 1 && patch_f32d1_inter_6 == ppd.patch_f32d1_inter_6[1])));
    bool good_patch_f32d1_inter_2 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d1_inter_2 == ppd.patch_f32d1_inter_2[0]) || (gl_PrimitiveID == 1 && patch_f32d1_inter_2 == ppd.patch_f32d1_inter_2[1])));
    bool good_patch_f16d1_inter_1 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d1_inter_1 == ppd.patch_f16d1_inter_1[0]) || (gl_PrimitiveID == 1 && patch_f16d1_inter_1 == ppd.patch_f16d1_inter_1[1])));
    bool good_patch_f16d3_inter_2 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d3_inter_2 == ppd.patch_f16d3_inter_2[0]) || (gl_PrimitiveID == 1 && patch_f16d3_inter_2 == ppd.patch_f16d3_inter_2[1])));
    bool good_patch_f32d3_inter_4 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d3_inter_4 == ppd.patch_f32d3_inter_4[0]) || (gl_PrimitiveID == 1 && patch_f32d3_inter_4 == ppd.patch_f32d3_inter_4[1])));
    bool good_patch_f32d2_inter_1 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d2_inter_1 == ppd.patch_f32d2_inter_1[0]) || (gl_PrimitiveID == 1 && patch_f32d2_inter_1 == ppd.patch_f32d2_inter_1[1])));
    bool good_patch_f16d4_inter_8 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d4_inter_8 == ppd.patch_f16d4_inter_8[0]) || (gl_PrimitiveID == 1 && patch_f16d4_inter_8 == ppd.patch_f16d4_inter_8[1])));
    bool good_patch_f16d2_inter_6 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d2_inter_6 == ppd.patch_f16d2_inter_6[0]) || (gl_PrimitiveID == 1 && patch_f16d2_inter_6 == ppd.patch_f16d2_inter_6[1])));
    bool good_patch_f32d2_inter_2 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d2_inter_2 == ppd.patch_f32d2_inter_2[0]) || (gl_PrimitiveID == 1 && patch_f32d2_inter_2 == ppd.patch_f32d2_inter_2[1])));
    bool good_patch_f16d1_inter_0 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d1_inter_0 == ppd.patch_f16d1_inter_0[0]) || (gl_PrimitiveID == 1 && patch_f16d1_inter_0 == ppd.patch_f16d1_inter_0[1])));
    bool good_patch_f32d1_inter_4 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d1_inter_4 == ppd.patch_f32d1_inter_4[0]) || (gl_PrimitiveID == 1 && patch_f32d1_inter_4 == ppd.patch_f32d1_inter_4[1])));
    bool good_patch_f32d3_inter_3 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d3_inter_3 == ppd.patch_f32d3_inter_3[0]) || (gl_PrimitiveID == 1 && patch_f32d3_inter_3 == ppd.patch_f32d3_inter_3[1])));
    bool good_patch_f16d3_inter_5 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d3_inter_5 == ppd.patch_f16d3_inter_5[0]) || (gl_PrimitiveID == 1 && patch_f16d3_inter_5 == ppd.patch_f16d3_inter_5[1])));
    bool good_patch_f32d4_inter_3 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d4_inter_3 == ppd.patch_f32d4_inter_3[0]) || (gl_PrimitiveID == 1 && patch_f32d4_inter_3 == ppd.patch_f32d4_inter_3[1])));
    bool good_patch_f16d3_inter_3 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d3_inter_3 == ppd.patch_f16d3_inter_3[0]) || (gl_PrimitiveID == 1 && patch_f16d3_inter_3 == ppd.patch_f16d3_inter_3[1])));
    bool good_patch_f32d2_inter_3 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f32d2_inter_3 == ppd.patch_f32d2_inter_3[0]) || (gl_PrimitiveID == 1 && patch_f32d2_inter_3 == ppd.patch_f32d2_inter_3[1])));
    bool good_patch_f16d2_inter_1 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && patch_f16d2_inter_1 == ppd.patch_f16d2_inter_1[0]) || (gl_PrimitiveID == 1 && patch_f16d2_inter_1 == ppd.patch_f16d2_inter_1[1])));
    if (good_patch_f16d1_inter_6 && good_patch_f32d3_inter_9 && good_patch_f32d4_inter_4 && good_patch_f32d2_inter_4 && good_patch_f16d2_inter_7 && good_patch_f16d3_inter_0 && good_patch_f16d2_inter_8 && good_patch_f32d4_inter_2 && good_patch_f32d2_inter_9 && good_patch_f32d1_inter_6 && good_patch_f32d1_inter_2 && good_patch_f16d1_inter_1 && good_patch_f16d3_inter_2 && good_patch_f32d3_inter_4 && good_patch_f32d2_inter_1 && good_patch_f16d4_inter_8 && good_patch_f16d2_inter_6 && good_patch_f32d2_inter_2 && good_patch_f16d1_inter_0 && good_patch_f32d1_inter_4 && good_patch_f32d3_inter_3 && good_patch_f16d3_inter_5 && good_patch_f32d4_inter_3 && good_patch_f16d3_inter_3 && good_patch_f32d2_inter_3 && good_patch_f16d2_inter_1) {
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
    float patch_f16d1_inter_6[2];
    vec3 patch_f32d3_inter_9[2];
    vec4 patch_f32d4_inter_4[2];
    vec2 patch_f32d2_inter_4[2];
    vec2 patch_f16d2_inter_7[2];
    vec3 patch_f16d3_inter_0[2];
    vec2 patch_f16d2_inter_8[2];
    vec4 patch_f32d4_inter_2[2];
    vec2 patch_f32d2_inter_9[2];
    float patch_f32d1_inter_6[2];
    float patch_f32d1_inter_2[2];
    float patch_f16d1_inter_1[2];
    vec3 patch_f16d3_inter_2[2];
    vec3 patch_f32d3_inter_4[2];
    vec2 patch_f32d2_inter_1[2];
    vec4 patch_f16d4_inter_8[2];
    vec2 patch_f16d2_inter_6[2];
    vec2 patch_f32d2_inter_2[2];
    float patch_f16d1_inter_0[2];
    float patch_f32d1_inter_4[2];
    vec3 patch_f32d3_inter_3[2];
    vec3 patch_f16d3_inter_5[2];
    vec4 patch_f32d4_inter_3[2];
    vec3 patch_f16d3_inter_3[2];
    vec2 patch_f32d2_inter_3[2];
    vec2 patch_f16d2_inter_1[2];
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
    float patch_f16d1_inter_6[2];
    vec3 patch_f32d3_inter_9[2];
    vec4 patch_f32d4_inter_4[2];
    vec2 patch_f32d2_inter_4[2];
    vec2 patch_f16d2_inter_7[2];
    vec3 patch_f16d3_inter_0[2];
    vec2 patch_f16d2_inter_8[2];
    vec4 patch_f32d4_inter_2[2];
    vec2 patch_f32d2_inter_9[2];
    float patch_f32d1_inter_6[2];
    float patch_f32d1_inter_2[2];
    float patch_f16d1_inter_1[2];
    vec3 patch_f16d3_inter_2[2];
    vec3 patch_f32d3_inter_4[2];
    vec2 patch_f32d2_inter_1[2];
    vec4 patch_f16d4_inter_8[2];
    vec2 patch_f16d2_inter_6[2];
    vec2 patch_f32d2_inter_2[2];
    float patch_f16d1_inter_0[2];
    float patch_f32d1_inter_4[2];
    vec3 patch_f32d3_inter_3[2];
    vec3 patch_f16d3_inter_5[2];
    vec4 patch_f32d4_inter_3[2];
    vec3 patch_f16d3_inter_3[2];
    vec2 patch_f32d2_inter_3[2];
    vec2 patch_f16d2_inter_1[2];
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
