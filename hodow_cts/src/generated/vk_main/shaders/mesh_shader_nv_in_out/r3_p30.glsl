#version 450
#extension GL_NV_mesh_shader : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable

layout (local_size_x=1) in;
layout (max_primitives=2, max_vertices=4) out;
layout (triangles) out;

layout (location=0) out perprimitiveNV flat int64_t prim_i64d1_flat_1[];
layout (location=1) out perprimitiveNV flat float64_t prim_f64d1_flat_0[];
layout (location=2) out perprimitiveNV flat i32vec2 prim_i32d2_flat_0[];
layout (location=3) out flat f64vec4 vert_f64d4_flat_0[];
layout (location=5) out flat int32_t vert_i32d1_flat_0[];
layout (location=6) out flat i32vec3 vert_i32d3_flat_1[];
layout (location=7) out perprimitiveNV flat int32_t prim_i32d1_flat_0[];
layout (location=8) out perprimitiveNV flat f32vec3 prim_f32d3_flat_1[];
layout (location=9) out float32_t vert_f32d1_inter_1[];
layout (location=10) out perprimitiveNV flat f64vec4 prim_f64d4_flat_1[];
layout (location=12) out perprimitiveNV flat int64_t prim_i64d1_flat_0[];
layout (location=13) out perprimitiveNV flat float32_t prim_f32d1_flat_0[];
layout (location=14) out flat i64vec3 vert_i64d3_flat_0[];
out gl_MeshPerVertexNV {
   vec4  gl_Position;
} gl_MeshVerticesNV[];
out perprimitiveNV gl_MeshPerPrimitiveNV {
  int gl_PrimitiveID;
} gl_MeshPrimitivesNV[];

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

vec4 positions[4] = vec4[](
    vec4(-1.0, -1.0, 0.0, 1.0),
    vec4( 1.0, -1.0, 0.0, 1.0),
    vec4(-1.0,  1.0, 0.0, 1.0),
    vec4( 1.0,  1.0, 0.0, 1.0)
);

int indices[6] = int[](
    0, 1, 2, 2, 3, 1
);

void main ()
{
    gl_PrimitiveCountNV = 2;

    gl_MeshVerticesNV[0].gl_Position = positions[0];
    gl_MeshVerticesNV[1].gl_Position = positions[1];
    gl_MeshVerticesNV[2].gl_Position = positions[2];
    gl_MeshVerticesNV[3].gl_Position = positions[3];

    gl_PrimitiveIndicesNV[0] = indices[0];
    gl_PrimitiveIndicesNV[1] = indices[1];
    gl_PrimitiveIndicesNV[2] = indices[2];
    gl_PrimitiveIndicesNV[3] = indices[3];
    gl_PrimitiveIndicesNV[4] = indices[4];
    gl_PrimitiveIndicesNV[5] = indices[5];

    gl_MeshPrimitivesNV[0].gl_PrimitiveID = 0;
    gl_MeshPrimitivesNV[1].gl_PrimitiveID = 1;

    prim_i64d1_flat_1[0] = int64_t(ppd.prim_i64d1_flat_1[0]);
    prim_i64d1_flat_1[1] = int64_t(ppd.prim_i64d1_flat_1[1]);
    prim_f64d1_flat_0[0] = float64_t(ppd.prim_f64d1_flat_0[0]);
    prim_f64d1_flat_0[1] = float64_t(ppd.prim_f64d1_flat_0[1]);
    prim_i32d2_flat_0[0] = i32vec2(ppd.prim_i32d2_flat_0[0]);
    prim_i32d2_flat_0[1] = i32vec2(ppd.prim_i32d2_flat_0[1]);
    vert_f64d4_flat_0[0] = f64vec4(pvd.vert_f64d4_flat_0[0]);
    vert_f64d4_flat_0[1] = f64vec4(pvd.vert_f64d4_flat_0[1]);
    vert_f64d4_flat_0[2] = f64vec4(pvd.vert_f64d4_flat_0[2]);
    vert_f64d4_flat_0[3] = f64vec4(pvd.vert_f64d4_flat_0[3]);
    vert_i32d1_flat_0[0] = int32_t(pvd.vert_i32d1_flat_0[0]);
    vert_i32d1_flat_0[1] = int32_t(pvd.vert_i32d1_flat_0[1]);
    vert_i32d1_flat_0[2] = int32_t(pvd.vert_i32d1_flat_0[2]);
    vert_i32d1_flat_0[3] = int32_t(pvd.vert_i32d1_flat_0[3]);
    vert_i32d3_flat_1[0] = i32vec3(pvd.vert_i32d3_flat_1[0]);
    vert_i32d3_flat_1[1] = i32vec3(pvd.vert_i32d3_flat_1[1]);
    vert_i32d3_flat_1[2] = i32vec3(pvd.vert_i32d3_flat_1[2]);
    vert_i32d3_flat_1[3] = i32vec3(pvd.vert_i32d3_flat_1[3]);
    prim_i32d1_flat_0[0] = int32_t(ppd.prim_i32d1_flat_0[0]);
    prim_i32d1_flat_0[1] = int32_t(ppd.prim_i32d1_flat_0[1]);
    prim_f32d3_flat_1[0] = f32vec3(ppd.prim_f32d3_flat_1[0]);
    prim_f32d3_flat_1[1] = f32vec3(ppd.prim_f32d3_flat_1[1]);
    vert_f32d1_inter_1[0] = float32_t(pvd.vert_f32d1_inter_1[0]);
    vert_f32d1_inter_1[1] = float32_t(pvd.vert_f32d1_inter_1[1]);
    vert_f32d1_inter_1[2] = float32_t(pvd.vert_f32d1_inter_1[2]);
    vert_f32d1_inter_1[3] = float32_t(pvd.vert_f32d1_inter_1[3]);
    prim_f64d4_flat_1[0] = f64vec4(ppd.prim_f64d4_flat_1[0]);
    prim_f64d4_flat_1[1] = f64vec4(ppd.prim_f64d4_flat_1[1]);
    prim_i64d1_flat_0[0] = int64_t(ppd.prim_i64d1_flat_0[0]);
    prim_i64d1_flat_0[1] = int64_t(ppd.prim_i64d1_flat_0[1]);
    prim_f32d1_flat_0[0] = float32_t(ppd.prim_f32d1_flat_0[0]);
    prim_f32d1_flat_0[1] = float32_t(ppd.prim_f32d1_flat_0[1]);
    vert_i64d3_flat_0[0] = i64vec3(pvd.vert_i64d3_flat_0[0]);
    vert_i64d3_flat_0[1] = i64vec3(pvd.vert_i64d3_flat_0[1]);
    vert_i64d3_flat_0[2] = i64vec3(pvd.vert_i64d3_flat_0[2]);
    vert_i64d3_flat_0[3] = i64vec3(pvd.vert_i64d3_flat_0[3]);

}
#version 450
#extension GL_NV_mesh_shader : enable
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

layout (location=0) in perprimitiveNV flat int64_t prim_i64d1_flat_1;
layout (location=1) in perprimitiveNV flat float64_t prim_f64d1_flat_0;
layout (location=2) in perprimitiveNV flat i32vec2 prim_i32d2_flat_0;
layout (location=3) in flat f64vec4 vert_f64d4_flat_0;
layout (location=5) in flat int32_t vert_i32d1_flat_0;
layout (location=6) in flat i32vec3 vert_i32d3_flat_1;
layout (location=7) in perprimitiveNV flat int32_t prim_i32d1_flat_0;
layout (location=8) in perprimitiveNV flat f32vec3 prim_f32d3_flat_1;
layout (location=9) in float32_t vert_f32d1_inter_1;
layout (location=10) in perprimitiveNV flat f64vec4 prim_f64d4_flat_1;
layout (location=12) in perprimitiveNV flat int64_t prim_i64d1_flat_0;
layout (location=13) in perprimitiveNV flat float32_t prim_f32d1_flat_0;
layout (location=14) in flat i64vec3 vert_i64d3_flat_0;

layout (location=0) out vec4 outColor;

void main ()
{
    bool good_prim_i64d1_flat_1 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && prim_i64d1_flat_1 == ppd.prim_i64d1_flat_1[0]) || (gl_PrimitiveID == 1 && prim_i64d1_flat_1 == ppd.prim_i64d1_flat_1[1])));
    bool good_prim_f64d1_flat_0 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && prim_f64d1_flat_0 == ppd.prim_f64d1_flat_0[0]) || (gl_PrimitiveID == 1 && prim_f64d1_flat_0 == ppd.prim_f64d1_flat_0[1])));
    bool good_prim_i32d2_flat_0 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && prim_i32d2_flat_0 == ppd.prim_i32d2_flat_0[0]) || (gl_PrimitiveID == 1 && prim_i32d2_flat_0 == ppd.prim_i32d2_flat_0[1])));
    bool good_vert_f64d4_flat_0 = all(lessThanEqual(vert_f64d4_flat_0, f64vec4(max(max(max(pvd.vert_f64d4_flat_0[0], pvd.vert_f64d4_flat_0[1]), pvd.vert_f64d4_flat_0[2]), pvd.vert_f64d4_flat_0[3])))) && all(greaterThanEqual(vert_f64d4_flat_0, f64vec4(min(min(min(pvd.vert_f64d4_flat_0[0], pvd.vert_f64d4_flat_0[1]), pvd.vert_f64d4_flat_0[2]), pvd.vert_f64d4_flat_0[3]))));
    bool good_vert_i32d1_flat_0 = (vert_i32d1_flat_0 <= int32_t(max(max(max(pvd.vert_i32d1_flat_0[0], pvd.vert_i32d1_flat_0[1]), pvd.vert_i32d1_flat_0[2]), pvd.vert_i32d1_flat_0[3]))) && (vert_i32d1_flat_0 >= int32_t(min(min(min(pvd.vert_i32d1_flat_0[0], pvd.vert_i32d1_flat_0[1]), pvd.vert_i32d1_flat_0[2]), pvd.vert_i32d1_flat_0[3])));
    bool good_vert_i32d3_flat_1 = all(lessThanEqual(vert_i32d3_flat_1, i32vec3(max(max(max(pvd.vert_i32d3_flat_1[0], pvd.vert_i32d3_flat_1[1]), pvd.vert_i32d3_flat_1[2]), pvd.vert_i32d3_flat_1[3])))) && all(greaterThanEqual(vert_i32d3_flat_1, i32vec3(min(min(min(pvd.vert_i32d3_flat_1[0], pvd.vert_i32d3_flat_1[1]), pvd.vert_i32d3_flat_1[2]), pvd.vert_i32d3_flat_1[3]))));
    bool good_prim_i32d1_flat_0 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && prim_i32d1_flat_0 == ppd.prim_i32d1_flat_0[0]) || (gl_PrimitiveID == 1 && prim_i32d1_flat_0 == ppd.prim_i32d1_flat_0[1])));
    bool good_prim_f32d3_flat_1 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && prim_f32d3_flat_1 == ppd.prim_f32d3_flat_1[0]) || (gl_PrimitiveID == 1 && prim_f32d3_flat_1 == ppd.prim_f32d3_flat_1[1])));
    bool good_vert_f32d1_inter_1 = (vert_f32d1_inter_1 <= float32_t(max(max(max(pvd.vert_f32d1_inter_1[0], pvd.vert_f32d1_inter_1[1]), pvd.vert_f32d1_inter_1[2]), pvd.vert_f32d1_inter_1[3]))) && (vert_f32d1_inter_1 >= float32_t(min(min(min(pvd.vert_f32d1_inter_1[0], pvd.vert_f32d1_inter_1[1]), pvd.vert_f32d1_inter_1[2]), pvd.vert_f32d1_inter_1[3])));
    bool good_prim_f64d4_flat_1 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && prim_f64d4_flat_1 == ppd.prim_f64d4_flat_1[0]) || (gl_PrimitiveID == 1 && prim_f64d4_flat_1 == ppd.prim_f64d4_flat_1[1])));
    bool good_prim_i64d1_flat_0 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && prim_i64d1_flat_0 == ppd.prim_i64d1_flat_0[0]) || (gl_PrimitiveID == 1 && prim_i64d1_flat_0 == ppd.prim_i64d1_flat_0[1])));
    bool good_prim_f32d1_flat_0 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && prim_f32d1_flat_0 == ppd.prim_f32d1_flat_0[0]) || (gl_PrimitiveID == 1 && prim_f32d1_flat_0 == ppd.prim_f32d1_flat_0[1])));
    bool good_vert_i64d3_flat_0 = all(lessThanEqual(vert_i64d3_flat_0, i64vec3(max(max(max(pvd.vert_i64d3_flat_0[0], pvd.vert_i64d3_flat_0[1]), pvd.vert_i64d3_flat_0[2]), pvd.vert_i64d3_flat_0[3])))) && all(greaterThanEqual(vert_i64d3_flat_0, i64vec3(min(min(min(pvd.vert_i64d3_flat_0[0], pvd.vert_i64d3_flat_0[1]), pvd.vert_i64d3_flat_0[2]), pvd.vert_i64d3_flat_0[3]))));
    if (good_prim_i64d1_flat_1 && good_prim_f64d1_flat_0 && good_prim_i32d2_flat_0 && good_vert_f64d4_flat_0 && good_vert_i32d1_flat_0 && good_vert_i32d3_flat_1 && good_prim_i32d1_flat_0 && good_prim_f32d3_flat_1 && good_vert_f32d1_inter_1 && good_prim_f64d4_flat_1 && good_prim_i64d1_flat_0 && good_prim_f32d1_flat_0 && good_vert_i64d3_flat_0) {
        outColor = vec4(0.0, 0.0, 1.0, 1.0);
    } else {
        outColor = vec4(0.0, 0.0, 0.0, 1.0);
    }
}
#version 450
#extension GL_NV_mesh_shader : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable

out taskNV TaskData {
    int64_t prim_i64d1_flat_1[2];
    float64_t prim_f64d1_flat_0[2];
    i32vec2 prim_i32d2_flat_0[2];
    f64vec4 vert_f64d4_flat_0[4];
    int32_t vert_i32d1_flat_0[4];
    i32vec3 vert_i32d3_flat_1[4];
    int32_t prim_i32d1_flat_0[2];
    f32vec3 prim_f32d3_flat_1[2];
    float32_t vert_f32d1_inter_1[4];
    f64vec4 prim_f64d4_flat_1[2];
    int64_t prim_i64d1_flat_0[2];
    float32_t prim_f32d1_flat_0[2];
    i64vec3 vert_i64d3_flat_0[4];
} td;

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

void main ()
{
    gl_TaskCountNV = 1;

    td.prim_i64d1_flat_1[0] = int64_t(ppd.prim_i64d1_flat_1[0]);
    td.prim_i64d1_flat_1[1] = int64_t(ppd.prim_i64d1_flat_1[1]);
    td.prim_f64d1_flat_0[0] = float64_t(ppd.prim_f64d1_flat_0[0]);
    td.prim_f64d1_flat_0[1] = float64_t(ppd.prim_f64d1_flat_0[1]);
    td.prim_i32d2_flat_0[0] = i32vec2(ppd.prim_i32d2_flat_0[0]);
    td.prim_i32d2_flat_0[1] = i32vec2(ppd.prim_i32d2_flat_0[1]);
    td.vert_f64d4_flat_0[0] = f64vec4(pvd.vert_f64d4_flat_0[0]);
    td.vert_f64d4_flat_0[1] = f64vec4(pvd.vert_f64d4_flat_0[1]);
    td.vert_f64d4_flat_0[2] = f64vec4(pvd.vert_f64d4_flat_0[2]);
    td.vert_f64d4_flat_0[3] = f64vec4(pvd.vert_f64d4_flat_0[3]);
    td.vert_i32d1_flat_0[0] = int32_t(pvd.vert_i32d1_flat_0[0]);
    td.vert_i32d1_flat_0[1] = int32_t(pvd.vert_i32d1_flat_0[1]);
    td.vert_i32d1_flat_0[2] = int32_t(pvd.vert_i32d1_flat_0[2]);
    td.vert_i32d1_flat_0[3] = int32_t(pvd.vert_i32d1_flat_0[3]);
    td.vert_i32d3_flat_1[0] = i32vec3(pvd.vert_i32d3_flat_1[0]);
    td.vert_i32d3_flat_1[1] = i32vec3(pvd.vert_i32d3_flat_1[1]);
    td.vert_i32d3_flat_1[2] = i32vec3(pvd.vert_i32d3_flat_1[2]);
    td.vert_i32d3_flat_1[3] = i32vec3(pvd.vert_i32d3_flat_1[3]);
    td.prim_i32d1_flat_0[0] = int32_t(ppd.prim_i32d1_flat_0[0]);
    td.prim_i32d1_flat_0[1] = int32_t(ppd.prim_i32d1_flat_0[1]);
    td.prim_f32d3_flat_1[0] = f32vec3(ppd.prim_f32d3_flat_1[0]);
    td.prim_f32d3_flat_1[1] = f32vec3(ppd.prim_f32d3_flat_1[1]);
    td.vert_f32d1_inter_1[0] = float32_t(pvd.vert_f32d1_inter_1[0]);
    td.vert_f32d1_inter_1[1] = float32_t(pvd.vert_f32d1_inter_1[1]);
    td.vert_f32d1_inter_1[2] = float32_t(pvd.vert_f32d1_inter_1[2]);
    td.vert_f32d1_inter_1[3] = float32_t(pvd.vert_f32d1_inter_1[3]);
    td.prim_f64d4_flat_1[0] = f64vec4(ppd.prim_f64d4_flat_1[0]);
    td.prim_f64d4_flat_1[1] = f64vec4(ppd.prim_f64d4_flat_1[1]);
    td.prim_i64d1_flat_0[0] = int64_t(ppd.prim_i64d1_flat_0[0]);
    td.prim_i64d1_flat_0[1] = int64_t(ppd.prim_i64d1_flat_0[1]);
    td.prim_f32d1_flat_0[0] = float32_t(ppd.prim_f32d1_flat_0[0]);
    td.prim_f32d1_flat_0[1] = float32_t(ppd.prim_f32d1_flat_0[1]);
    td.vert_i64d3_flat_0[0] = i64vec3(pvd.vert_i64d3_flat_0[0]);
    td.vert_i64d3_flat_0[1] = i64vec3(pvd.vert_i64d3_flat_0[1]);
    td.vert_i64d3_flat_0[2] = i64vec3(pvd.vert_i64d3_flat_0[2]);
    td.vert_i64d3_flat_0[3] = i64vec3(pvd.vert_i64d3_flat_0[3]);

}
#version 450
#extension GL_NV_mesh_shader : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable

layout (local_size_x=1) in;
layout (max_primitives=2, max_vertices=4) out;
layout (triangles) out;

layout (location=0) out perprimitiveNV flat int64_t prim_i64d1_flat_1[];
layout (location=1) out perprimitiveNV flat float64_t prim_f64d1_flat_0[];
layout (location=2) out perprimitiveNV flat i32vec2 prim_i32d2_flat_0[];
layout (location=3) out flat f64vec4 vert_f64d4_flat_0[];
layout (location=5) out flat int32_t vert_i32d1_flat_0[];
layout (location=6) out flat i32vec3 vert_i32d3_flat_1[];
layout (location=7) out perprimitiveNV flat int32_t prim_i32d1_flat_0[];
layout (location=8) out perprimitiveNV flat f32vec3 prim_f32d3_flat_1[];
layout (location=9) out float32_t vert_f32d1_inter_1[];
layout (location=10) out perprimitiveNV flat f64vec4 prim_f64d4_flat_1[];
layout (location=12) out perprimitiveNV flat int64_t prim_i64d1_flat_0[];
layout (location=13) out perprimitiveNV flat float32_t prim_f32d1_flat_0[];
layout (location=14) out flat i64vec3 vert_i64d3_flat_0[];
out gl_MeshPerVertexNV {
   vec4  gl_Position;
} gl_MeshVerticesNV[];
out perprimitiveNV gl_MeshPerPrimitiveNV {
  int gl_PrimitiveID;
} gl_MeshPrimitivesNV[];

in taskNV TaskData {
    int64_t prim_i64d1_flat_1[2];
    float64_t prim_f64d1_flat_0[2];
    i32vec2 prim_i32d2_flat_0[2];
    f64vec4 vert_f64d4_flat_0[4];
    int32_t vert_i32d1_flat_0[4];
    i32vec3 vert_i32d3_flat_1[4];
    int32_t prim_i32d1_flat_0[2];
    f32vec3 prim_f32d3_flat_1[2];
    float32_t vert_f32d1_inter_1[4];
    f64vec4 prim_f64d4_flat_1[2];
    int64_t prim_i64d1_flat_0[2];
    float32_t prim_f32d1_flat_0[2];
    i64vec3 vert_i64d3_flat_0[4];
} td;
vec4 positions[4] = vec4[](
    vec4(-1.0, -1.0, 0.0, 1.0),
    vec4( 1.0, -1.0, 0.0, 1.0),
    vec4(-1.0,  1.0, 0.0, 1.0),
    vec4( 1.0,  1.0, 0.0, 1.0)
);

int indices[6] = int[](
    0, 1, 2, 2, 3, 1
);

void main ()
{
    gl_PrimitiveCountNV = 2;

    gl_MeshVerticesNV[0].gl_Position = positions[0];
    gl_MeshVerticesNV[1].gl_Position = positions[1];
    gl_MeshVerticesNV[2].gl_Position = positions[2];
    gl_MeshVerticesNV[3].gl_Position = positions[3];

    gl_PrimitiveIndicesNV[0] = indices[0];
    gl_PrimitiveIndicesNV[1] = indices[1];
    gl_PrimitiveIndicesNV[2] = indices[2];
    gl_PrimitiveIndicesNV[3] = indices[3];
    gl_PrimitiveIndicesNV[4] = indices[4];
    gl_PrimitiveIndicesNV[5] = indices[5];

    gl_MeshPrimitivesNV[0].gl_PrimitiveID = 0;
    gl_MeshPrimitivesNV[1].gl_PrimitiveID = 1;

    prim_i64d1_flat_1[0] = int64_t(td.prim_i64d1_flat_1[0]);
    prim_i64d1_flat_1[1] = int64_t(td.prim_i64d1_flat_1[1]);
    prim_f64d1_flat_0[0] = float64_t(td.prim_f64d1_flat_0[0]);
    prim_f64d1_flat_0[1] = float64_t(td.prim_f64d1_flat_0[1]);
    prim_i32d2_flat_0[0] = i32vec2(td.prim_i32d2_flat_0[0]);
    prim_i32d2_flat_0[1] = i32vec2(td.prim_i32d2_flat_0[1]);
    vert_f64d4_flat_0[0] = f64vec4(td.vert_f64d4_flat_0[0]);
    vert_f64d4_flat_0[1] = f64vec4(td.vert_f64d4_flat_0[1]);
    vert_f64d4_flat_0[2] = f64vec4(td.vert_f64d4_flat_0[2]);
    vert_f64d4_flat_0[3] = f64vec4(td.vert_f64d4_flat_0[3]);
    vert_i32d1_flat_0[0] = int32_t(td.vert_i32d1_flat_0[0]);
    vert_i32d1_flat_0[1] = int32_t(td.vert_i32d1_flat_0[1]);
    vert_i32d1_flat_0[2] = int32_t(td.vert_i32d1_flat_0[2]);
    vert_i32d1_flat_0[3] = int32_t(td.vert_i32d1_flat_0[3]);
    vert_i32d3_flat_1[0] = i32vec3(td.vert_i32d3_flat_1[0]);
    vert_i32d3_flat_1[1] = i32vec3(td.vert_i32d3_flat_1[1]);
    vert_i32d3_flat_1[2] = i32vec3(td.vert_i32d3_flat_1[2]);
    vert_i32d3_flat_1[3] = i32vec3(td.vert_i32d3_flat_1[3]);
    prim_i32d1_flat_0[0] = int32_t(td.prim_i32d1_flat_0[0]);
    prim_i32d1_flat_0[1] = int32_t(td.prim_i32d1_flat_0[1]);
    prim_f32d3_flat_1[0] = f32vec3(td.prim_f32d3_flat_1[0]);
    prim_f32d3_flat_1[1] = f32vec3(td.prim_f32d3_flat_1[1]);
    vert_f32d1_inter_1[0] = float32_t(td.vert_f32d1_inter_1[0]);
    vert_f32d1_inter_1[1] = float32_t(td.vert_f32d1_inter_1[1]);
    vert_f32d1_inter_1[2] = float32_t(td.vert_f32d1_inter_1[2]);
    vert_f32d1_inter_1[3] = float32_t(td.vert_f32d1_inter_1[3]);
    prim_f64d4_flat_1[0] = f64vec4(td.prim_f64d4_flat_1[0]);
    prim_f64d4_flat_1[1] = f64vec4(td.prim_f64d4_flat_1[1]);
    prim_i64d1_flat_0[0] = int64_t(td.prim_i64d1_flat_0[0]);
    prim_i64d1_flat_0[1] = int64_t(td.prim_i64d1_flat_0[1]);
    prim_f32d1_flat_0[0] = float32_t(td.prim_f32d1_flat_0[0]);
    prim_f32d1_flat_0[1] = float32_t(td.prim_f32d1_flat_0[1]);
    vert_i64d3_flat_0[0] = i64vec3(td.vert_i64d3_flat_0[0]);
    vert_i64d3_flat_0[1] = i64vec3(td.vert_i64d3_flat_0[1]);
    vert_i64d3_flat_0[2] = i64vec3(td.vert_i64d3_flat_0[2]);
    vert_i64d3_flat_0[3] = i64vec3(td.vert_i64d3_flat_0[3]);

}
