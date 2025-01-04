#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable

layout(set=0, binding=0, std430) readonly buffer PerVertexBlock {
    vec4   vert_f64d4_inter_0[4];
    vec4   vert_f64d4_inter_1[4];
    vec3   vert_f64d3_inter_0[4];
    vec3   vert_f64d3_inter_1[4];
    vec2   vert_f64d2_inter_0[4];
    vec2   vert_f64d2_inter_1[4];
    float  vert_f64d1_inter_0[4];
    float  vert_f64d1_inter_1[4];
    vec4   vert_f32d4_inter_0[4];
    vec4   vert_f32d4_inter_1[4];
    vec3   vert_f32d3_inter_0[4];
    vec3   vert_f32d3_inter_1[4];
    vec2   vert_f32d2_inter_0[4];
    vec2   vert_f32d2_inter_1[4];
    float  vert_f32d1_inter_0[4];
    float  vert_f32d1_inter_1[4];
    vec4   vert_f16d4_inter_0[4];
    vec4   vert_f16d4_inter_1[4];
    vec3   vert_f16d3_inter_0[4];
    vec3   vert_f16d3_inter_1[4];
    vec2   vert_f16d2_inter_0[4];
    vec2   vert_f16d2_inter_1[4];
    float  vert_f16d1_inter_0[4];
    float  vert_f16d1_inter_1[4];
    vec4   vert_f64d4_flat_0[4];
    vec4   vert_f64d4_flat_1[4];
    vec3   vert_f64d3_flat_0[4];
    vec3   vert_f64d3_flat_1[4];
    vec2   vert_f64d2_flat_0[4];
    vec2   vert_f64d2_flat_1[4];
    float  vert_f64d1_flat_0[4];
    float  vert_f64d1_flat_1[4];
    vec4   vert_f32d4_flat_0[4];
    vec4   vert_f32d4_flat_1[4];
    vec3   vert_f32d3_flat_0[4];
    vec3   vert_f32d3_flat_1[4];
    vec2   vert_f32d2_flat_0[4];
    vec2   vert_f32d2_flat_1[4];
    float  vert_f32d1_flat_0[4];
    float  vert_f32d1_flat_1[4];
    vec4   vert_f16d4_flat_0[4];
    vec4   vert_f16d4_flat_1[4];
    vec3   vert_f16d3_flat_0[4];
    vec3   vert_f16d3_flat_1[4];
    vec2   vert_f16d2_flat_0[4];
    vec2   vert_f16d2_flat_1[4];
    float  vert_f16d1_flat_0[4];
    float  vert_f16d1_flat_1[4];
    ivec4  vert_i64d4_flat_0[4];
    ivec4  vert_i64d4_flat_1[4];
    ivec3  vert_i64d3_flat_0[4];
    ivec3  vert_i64d3_flat_1[4];
    ivec2  vert_i64d2_flat_0[4];
    ivec2  vert_i64d2_flat_1[4];
    int    vert_i64d1_flat_0[4];
    int    vert_i64d1_flat_1[4];
    ivec4  vert_i32d4_flat_0[4];
    ivec4  vert_i32d4_flat_1[4];
    ivec3  vert_i32d3_flat_0[4];
    ivec3  vert_i32d3_flat_1[4];
    ivec2  vert_i32d2_flat_0[4];
    ivec2  vert_i32d2_flat_1[4];
    int    vert_i32d1_flat_0[4];
    int    vert_i32d1_flat_1[4];
    ivec4  vert_i16d4_flat_0[4];
    ivec4  vert_i16d4_flat_1[4];
    ivec3  vert_i16d3_flat_0[4];
    ivec3  vert_i16d3_flat_1[4];
    ivec2  vert_i16d2_flat_0[4];
    ivec2  vert_i16d2_flat_1[4];
    int    vert_i16d1_flat_0[4];
    int    vert_i16d1_flat_1[4];
 } pvd;

layout(set=0, binding=1, std430) readonly buffer PerPrimitiveBlock {
    vec4   prim_f64d4_flat_0[2];
    vec4   prim_f64d4_flat_1[2];
    vec3   prim_f64d3_flat_0[2];
    vec3   prim_f64d3_flat_1[2];
    vec2   prim_f64d2_flat_0[2];
    vec2   prim_f64d2_flat_1[2];
    float  prim_f64d1_flat_0[2];
    float  prim_f64d1_flat_1[2];
    vec4   prim_f32d4_flat_0[2];
    vec4   prim_f32d4_flat_1[2];
    vec3   prim_f32d3_flat_0[2];
    vec3   prim_f32d3_flat_1[2];
    vec2   prim_f32d2_flat_0[2];
    vec2   prim_f32d2_flat_1[2];
    float  prim_f32d1_flat_0[2];
    float  prim_f32d1_flat_1[2];
    vec4   prim_f16d4_flat_0[2];
    vec4   prim_f16d4_flat_1[2];
    vec3   prim_f16d3_flat_0[2];
    vec3   prim_f16d3_flat_1[2];
    vec2   prim_f16d2_flat_0[2];
    vec2   prim_f16d2_flat_1[2];
    float  prim_f16d1_flat_0[2];
    float  prim_f16d1_flat_1[2];
    ivec4  prim_i64d4_flat_0[2];
    ivec4  prim_i64d4_flat_1[2];
    ivec3  prim_i64d3_flat_0[2];
    ivec3  prim_i64d3_flat_1[2];
    ivec2  prim_i64d2_flat_0[2];
    ivec2  prim_i64d2_flat_1[2];
    int    prim_i64d1_flat_0[2];
    int    prim_i64d1_flat_1[2];
    ivec4  prim_i32d4_flat_0[2];
    ivec4  prim_i32d4_flat_1[2];
    ivec3  prim_i32d3_flat_0[2];
    ivec3  prim_i32d3_flat_1[2];
    ivec2  prim_i32d2_flat_0[2];
    ivec2  prim_i32d2_flat_1[2];
    int    prim_i32d1_flat_0[2];
    int    prim_i32d1_flat_1[2];
    ivec4  prim_i16d4_flat_0[2];
    ivec4  prim_i16d4_flat_1[2];
    ivec3  prim_i16d3_flat_0[2];
    ivec3  prim_i16d3_flat_1[2];
    ivec2  prim_i16d2_flat_0[2];
    ivec2  prim_i16d2_flat_1[2];
    int    prim_i16d1_flat_0[2];
    int    prim_i16d1_flat_1[2];
 } ppd;

layout (location=0) in perprimitiveEXT flat f32vec3 prim_f32d3_flat_1;
layout (location=1) in flat f64vec4 vert_f64d4_flat_0;
layout (location=3) in flat f32vec2 vert_f32d2_flat_0;
layout (location=4) in perprimitiveEXT flat i32vec3 prim_i32d3_flat_0;
layout (location=5) in flat f64vec2 vert_f64d2_flat_1;
layout (location=6) in flat f32vec2 vert_f32d2_flat_1;
layout (location=7) in perprimitiveEXT flat float32_t prim_f32d1_flat_1;
layout (location=8) in flat f64vec2 vert_f64d2_flat_0;
layout (location=9) in perprimitiveEXT flat f32vec3 prim_f32d3_flat_0;
layout (location=10) in perprimitiveEXT flat f32vec4 prim_f32d4_flat_0;
layout (location=11) in perprimitiveEXT flat f64vec4 prim_f64d4_flat_0;
layout (location=13) in flat i32vec3 vert_i32d3_flat_1;
layout (location=14) in flat int32_t vert_i32d1_flat_1;
layout (location=15) in flat i32vec4 vert_i32d4_flat_0;

layout (location=0) out vec4 outColor;

void main ()
{
    bool good_prim_f32d3_flat_1 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && prim_f32d3_flat_1 == ppd.prim_f32d3_flat_1[0]) || (gl_PrimitiveID == 1 && prim_f32d3_flat_1 == ppd.prim_f32d3_flat_1[1])));
    bool good_vert_f64d4_flat_0 = all(lessThanEqual(vert_f64d4_flat_0, f64vec4(max(max(max(pvd.vert_f64d4_flat_0[0], pvd.vert_f64d4_flat_0[1]), pvd.vert_f64d4_flat_0[2]), pvd.vert_f64d4_flat_0[3])))) && all(greaterThanEqual(vert_f64d4_flat_0, f64vec4(min(min(min(pvd.vert_f64d4_flat_0[0], pvd.vert_f64d4_flat_0[1]), pvd.vert_f64d4_flat_0[2]), pvd.vert_f64d4_flat_0[3]))));
    bool good_vert_f32d2_flat_0 = all(lessThanEqual(vert_f32d2_flat_0, f32vec2(max(max(max(pvd.vert_f32d2_flat_0[0], pvd.vert_f32d2_flat_0[1]), pvd.vert_f32d2_flat_0[2]), pvd.vert_f32d2_flat_0[3])))) && all(greaterThanEqual(vert_f32d2_flat_0, f32vec2(min(min(min(pvd.vert_f32d2_flat_0[0], pvd.vert_f32d2_flat_0[1]), pvd.vert_f32d2_flat_0[2]), pvd.vert_f32d2_flat_0[3]))));
    bool good_prim_i32d3_flat_0 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && prim_i32d3_flat_0 == ppd.prim_i32d3_flat_0[0]) || (gl_PrimitiveID == 1 && prim_i32d3_flat_0 == ppd.prim_i32d3_flat_0[1])));
    bool good_vert_f64d2_flat_1 = all(lessThanEqual(vert_f64d2_flat_1, f64vec2(max(max(max(pvd.vert_f64d2_flat_1[0], pvd.vert_f64d2_flat_1[1]), pvd.vert_f64d2_flat_1[2]), pvd.vert_f64d2_flat_1[3])))) && all(greaterThanEqual(vert_f64d2_flat_1, f64vec2(min(min(min(pvd.vert_f64d2_flat_1[0], pvd.vert_f64d2_flat_1[1]), pvd.vert_f64d2_flat_1[2]), pvd.vert_f64d2_flat_1[3]))));
    bool good_vert_f32d2_flat_1 = all(lessThanEqual(vert_f32d2_flat_1, f32vec2(max(max(max(pvd.vert_f32d2_flat_1[0], pvd.vert_f32d2_flat_1[1]), pvd.vert_f32d2_flat_1[2]), pvd.vert_f32d2_flat_1[3])))) && all(greaterThanEqual(vert_f32d2_flat_1, f32vec2(min(min(min(pvd.vert_f32d2_flat_1[0], pvd.vert_f32d2_flat_1[1]), pvd.vert_f32d2_flat_1[2]), pvd.vert_f32d2_flat_1[3]))));
    bool good_prim_f32d1_flat_1 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && prim_f32d1_flat_1 == ppd.prim_f32d1_flat_1[0]) || (gl_PrimitiveID == 1 && prim_f32d1_flat_1 == ppd.prim_f32d1_flat_1[1])));
    bool good_vert_f64d2_flat_0 = all(lessThanEqual(vert_f64d2_flat_0, f64vec2(max(max(max(pvd.vert_f64d2_flat_0[0], pvd.vert_f64d2_flat_0[1]), pvd.vert_f64d2_flat_0[2]), pvd.vert_f64d2_flat_0[3])))) && all(greaterThanEqual(vert_f64d2_flat_0, f64vec2(min(min(min(pvd.vert_f64d2_flat_0[0], pvd.vert_f64d2_flat_0[1]), pvd.vert_f64d2_flat_0[2]), pvd.vert_f64d2_flat_0[3]))));
    bool good_prim_f32d3_flat_0 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && prim_f32d3_flat_0 == ppd.prim_f32d3_flat_0[0]) || (gl_PrimitiveID == 1 && prim_f32d3_flat_0 == ppd.prim_f32d3_flat_0[1])));
    bool good_prim_f32d4_flat_0 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && prim_f32d4_flat_0 == ppd.prim_f32d4_flat_0[0]) || (gl_PrimitiveID == 1 && prim_f32d4_flat_0 == ppd.prim_f32d4_flat_0[1])));
    bool good_prim_f64d4_flat_0 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && prim_f64d4_flat_0 == ppd.prim_f64d4_flat_0[0]) || (gl_PrimitiveID == 1 && prim_f64d4_flat_0 == ppd.prim_f64d4_flat_0[1])));
    bool good_vert_i32d3_flat_1 = all(lessThanEqual(vert_i32d3_flat_1, i32vec3(max(max(max(pvd.vert_i32d3_flat_1[0], pvd.vert_i32d3_flat_1[1]), pvd.vert_i32d3_flat_1[2]), pvd.vert_i32d3_flat_1[3])))) && all(greaterThanEqual(vert_i32d3_flat_1, i32vec3(min(min(min(pvd.vert_i32d3_flat_1[0], pvd.vert_i32d3_flat_1[1]), pvd.vert_i32d3_flat_1[2]), pvd.vert_i32d3_flat_1[3]))));
    bool good_vert_i32d1_flat_1 = (vert_i32d1_flat_1 <= int32_t(max(max(max(pvd.vert_i32d1_flat_1[0], pvd.vert_i32d1_flat_1[1]), pvd.vert_i32d1_flat_1[2]), pvd.vert_i32d1_flat_1[3]))) && (vert_i32d1_flat_1 >= int32_t(min(min(min(pvd.vert_i32d1_flat_1[0], pvd.vert_i32d1_flat_1[1]), pvd.vert_i32d1_flat_1[2]), pvd.vert_i32d1_flat_1[3])));
    bool good_vert_i32d4_flat_0 = all(lessThanEqual(vert_i32d4_flat_0, i32vec4(max(max(max(pvd.vert_i32d4_flat_0[0], pvd.vert_i32d4_flat_0[1]), pvd.vert_i32d4_flat_0[2]), pvd.vert_i32d4_flat_0[3])))) && all(greaterThanEqual(vert_i32d4_flat_0, i32vec4(min(min(min(pvd.vert_i32d4_flat_0[0], pvd.vert_i32d4_flat_0[1]), pvd.vert_i32d4_flat_0[2]), pvd.vert_i32d4_flat_0[3]))));
    if (good_prim_f32d3_flat_1 && good_vert_f64d4_flat_0 && good_vert_f32d2_flat_0 && good_prim_i32d3_flat_0 && good_vert_f64d2_flat_1 && good_vert_f32d2_flat_1 && good_prim_f32d1_flat_1 && good_vert_f64d2_flat_0 && good_prim_f32d3_flat_0 && good_prim_f32d4_flat_0 && good_prim_f64d4_flat_0 && good_vert_i32d3_flat_1 && good_vert_i32d1_flat_1 && good_vert_i32d4_flat_0) {
        outColor = vec4(0.0, 0.0, 1.0, 1.0);
    } else {
        outColor = vec4(0.0, 0.0, 0.0, 1.0);
    }
}
