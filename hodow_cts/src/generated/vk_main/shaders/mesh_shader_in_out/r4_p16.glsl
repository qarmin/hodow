#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable

layout (local_size_x=1) in;
layout (max_primitives=2, max_vertices=4) out;
layout (triangles) out;

layout (location=0) out flat i16vec3 vert_i16d3_flat_0[];
layout (location=1) out flat float32_t vert_f32d1_flat_0[];
layout (location=2) out flat f32vec3 vert_f32d3_flat_0[];
layout (location=3) out f32vec3 vert_f32d3_inter_0[];
layout (location=4) out flat f32vec4 vert_f32d4_flat_0[];
layout (location=5) out perprimitiveEXT flat i32vec2 prim_i32d2_flat_0[];
layout (location=6) out f32vec2 vert_f32d2_inter_1[];
layout (location=7) out flat int32_t vert_i32d1_flat_1[];
layout (location=8) out flat i32vec2 vert_i32d2_flat_0[];
layout (location=9) out perprimitiveEXT flat i32vec4 prim_i32d4_flat_1[];
layout (location=10) out f32vec2 vert_f32d2_inter_0[];
layout (location=11) out perprimitiveEXT flat i32vec2 prim_i32d2_flat_1[];
layout (location=12) out perprimitiveEXT flat float32_t prim_f32d1_flat_1[];
layout (location=13) out perprimitiveEXT flat f32vec3 prim_f32d3_flat_1[];
layout (location=14) out perprimitiveEXT flat i16vec4 prim_i16d4_flat_1[];
layout (location=15) out perprimitiveEXT flat int16_t prim_i16d1_flat_1[];
out gl_MeshPerVertexEXT {
   vec4  gl_Position;
} gl_MeshVerticesEXT[];
out perprimitiveEXT gl_MeshPerPrimitiveEXT {
  int gl_PrimitiveID;
} gl_MeshPrimitivesEXT[];

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

uvec3 indices[2] = uvec3[](
    uvec3(0, 1, 2),
    uvec3(2, 3, 1)
);

void main ()
{
    SetMeshOutputsEXT(4, 2);

    gl_MeshVerticesEXT[0].gl_Position = positions[0];
    gl_MeshVerticesEXT[1].gl_Position = positions[1];
    gl_MeshVerticesEXT[2].gl_Position = positions[2];
    gl_MeshVerticesEXT[3].gl_Position = positions[3];

    gl_PrimitiveTriangleIndicesEXT[0] = indices[0];
    gl_PrimitiveTriangleIndicesEXT[1] = indices[1];

    gl_MeshPrimitivesEXT[0].gl_PrimitiveID = 0;
    gl_MeshPrimitivesEXT[1].gl_PrimitiveID = 1;

    vert_i16d3_flat_0[0] = i16vec3(pvd.vert_i16d3_flat_0[0]);
    vert_i16d3_flat_0[1] = i16vec3(pvd.vert_i16d3_flat_0[1]);
    vert_i16d3_flat_0[2] = i16vec3(pvd.vert_i16d3_flat_0[2]);
    vert_i16d3_flat_0[3] = i16vec3(pvd.vert_i16d3_flat_0[3]);
    vert_f32d1_flat_0[0] = float32_t(pvd.vert_f32d1_flat_0[0]);
    vert_f32d1_flat_0[1] = float32_t(pvd.vert_f32d1_flat_0[1]);
    vert_f32d1_flat_0[2] = float32_t(pvd.vert_f32d1_flat_0[2]);
    vert_f32d1_flat_0[3] = float32_t(pvd.vert_f32d1_flat_0[3]);
    vert_f32d3_flat_0[0] = f32vec3(pvd.vert_f32d3_flat_0[0]);
    vert_f32d3_flat_0[1] = f32vec3(pvd.vert_f32d3_flat_0[1]);
    vert_f32d3_flat_0[2] = f32vec3(pvd.vert_f32d3_flat_0[2]);
    vert_f32d3_flat_0[3] = f32vec3(pvd.vert_f32d3_flat_0[3]);
    vert_f32d3_inter_0[0] = f32vec3(pvd.vert_f32d3_inter_0[0]);
    vert_f32d3_inter_0[1] = f32vec3(pvd.vert_f32d3_inter_0[1]);
    vert_f32d3_inter_0[2] = f32vec3(pvd.vert_f32d3_inter_0[2]);
    vert_f32d3_inter_0[3] = f32vec3(pvd.vert_f32d3_inter_0[3]);
    vert_f32d4_flat_0[0] = f32vec4(pvd.vert_f32d4_flat_0[0]);
    vert_f32d4_flat_0[1] = f32vec4(pvd.vert_f32d4_flat_0[1]);
    vert_f32d4_flat_0[2] = f32vec4(pvd.vert_f32d4_flat_0[2]);
    vert_f32d4_flat_0[3] = f32vec4(pvd.vert_f32d4_flat_0[3]);
    prim_i32d2_flat_0[0] = i32vec2(ppd.prim_i32d2_flat_0[0]);
    prim_i32d2_flat_0[1] = i32vec2(ppd.prim_i32d2_flat_0[1]);
    vert_f32d2_inter_1[0] = f32vec2(pvd.vert_f32d2_inter_1[0]);
    vert_f32d2_inter_1[1] = f32vec2(pvd.vert_f32d2_inter_1[1]);
    vert_f32d2_inter_1[2] = f32vec2(pvd.vert_f32d2_inter_1[2]);
    vert_f32d2_inter_1[3] = f32vec2(pvd.vert_f32d2_inter_1[3]);
    vert_i32d1_flat_1[0] = int32_t(pvd.vert_i32d1_flat_1[0]);
    vert_i32d1_flat_1[1] = int32_t(pvd.vert_i32d1_flat_1[1]);
    vert_i32d1_flat_1[2] = int32_t(pvd.vert_i32d1_flat_1[2]);
    vert_i32d1_flat_1[3] = int32_t(pvd.vert_i32d1_flat_1[3]);
    vert_i32d2_flat_0[0] = i32vec2(pvd.vert_i32d2_flat_0[0]);
    vert_i32d2_flat_0[1] = i32vec2(pvd.vert_i32d2_flat_0[1]);
    vert_i32d2_flat_0[2] = i32vec2(pvd.vert_i32d2_flat_0[2]);
    vert_i32d2_flat_0[3] = i32vec2(pvd.vert_i32d2_flat_0[3]);
    prim_i32d4_flat_1[0] = i32vec4(ppd.prim_i32d4_flat_1[0]);
    prim_i32d4_flat_1[1] = i32vec4(ppd.prim_i32d4_flat_1[1]);
    vert_f32d2_inter_0[0] = f32vec2(pvd.vert_f32d2_inter_0[0]);
    vert_f32d2_inter_0[1] = f32vec2(pvd.vert_f32d2_inter_0[1]);
    vert_f32d2_inter_0[2] = f32vec2(pvd.vert_f32d2_inter_0[2]);
    vert_f32d2_inter_0[3] = f32vec2(pvd.vert_f32d2_inter_0[3]);
    prim_i32d2_flat_1[0] = i32vec2(ppd.prim_i32d2_flat_1[0]);
    prim_i32d2_flat_1[1] = i32vec2(ppd.prim_i32d2_flat_1[1]);
    prim_f32d1_flat_1[0] = float32_t(ppd.prim_f32d1_flat_1[0]);
    prim_f32d1_flat_1[1] = float32_t(ppd.prim_f32d1_flat_1[1]);
    prim_f32d3_flat_1[0] = f32vec3(ppd.prim_f32d3_flat_1[0]);
    prim_f32d3_flat_1[1] = f32vec3(ppd.prim_f32d3_flat_1[1]);
    prim_i16d4_flat_1[0] = i16vec4(ppd.prim_i16d4_flat_1[0]);
    prim_i16d4_flat_1[1] = i16vec4(ppd.prim_i16d4_flat_1[1]);
    prim_i16d1_flat_1[0] = int16_t(ppd.prim_i16d1_flat_1[0]);
    prim_i16d1_flat_1[1] = int16_t(ppd.prim_i16d1_flat_1[1]);

}
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

layout (location=0) in flat i16vec3 vert_i16d3_flat_0;
layout (location=1) in flat float32_t vert_f32d1_flat_0;
layout (location=2) in flat f32vec3 vert_f32d3_flat_0;
layout (location=3) in f32vec3 vert_f32d3_inter_0;
layout (location=4) in flat f32vec4 vert_f32d4_flat_0;
layout (location=5) in perprimitiveEXT flat i32vec2 prim_i32d2_flat_0;
layout (location=6) in f32vec2 vert_f32d2_inter_1;
layout (location=7) in flat int32_t vert_i32d1_flat_1;
layout (location=8) in flat i32vec2 vert_i32d2_flat_0;
layout (location=9) in perprimitiveEXT flat i32vec4 prim_i32d4_flat_1;
layout (location=10) in f32vec2 vert_f32d2_inter_0;
layout (location=11) in perprimitiveEXT flat i32vec2 prim_i32d2_flat_1;
layout (location=12) in perprimitiveEXT flat float32_t prim_f32d1_flat_1;
layout (location=13) in perprimitiveEXT flat f32vec3 prim_f32d3_flat_1;
layout (location=14) in perprimitiveEXT flat i16vec4 prim_i16d4_flat_1;
layout (location=15) in perprimitiveEXT flat int16_t prim_i16d1_flat_1;

layout (location=0) out vec4 outColor;

void main ()
{
    bool good_vert_i16d3_flat_0 = all(lessThanEqual(vert_i16d3_flat_0, i16vec3(max(max(max(pvd.vert_i16d3_flat_0[0], pvd.vert_i16d3_flat_0[1]), pvd.vert_i16d3_flat_0[2]), pvd.vert_i16d3_flat_0[3])))) && all(greaterThanEqual(vert_i16d3_flat_0, i16vec3(min(min(min(pvd.vert_i16d3_flat_0[0], pvd.vert_i16d3_flat_0[1]), pvd.vert_i16d3_flat_0[2]), pvd.vert_i16d3_flat_0[3]))));
    bool good_vert_f32d1_flat_0 = (vert_f32d1_flat_0 <= float32_t(max(max(max(pvd.vert_f32d1_flat_0[0], pvd.vert_f32d1_flat_0[1]), pvd.vert_f32d1_flat_0[2]), pvd.vert_f32d1_flat_0[3]))) && (vert_f32d1_flat_0 >= float32_t(min(min(min(pvd.vert_f32d1_flat_0[0], pvd.vert_f32d1_flat_0[1]), pvd.vert_f32d1_flat_0[2]), pvd.vert_f32d1_flat_0[3])));
    bool good_vert_f32d3_flat_0 = all(lessThanEqual(vert_f32d3_flat_0, f32vec3(max(max(max(pvd.vert_f32d3_flat_0[0], pvd.vert_f32d3_flat_0[1]), pvd.vert_f32d3_flat_0[2]), pvd.vert_f32d3_flat_0[3])))) && all(greaterThanEqual(vert_f32d3_flat_0, f32vec3(min(min(min(pvd.vert_f32d3_flat_0[0], pvd.vert_f32d3_flat_0[1]), pvd.vert_f32d3_flat_0[2]), pvd.vert_f32d3_flat_0[3]))));
    bool good_vert_f32d3_inter_0 = all(lessThanEqual(vert_f32d3_inter_0, f32vec3(max(max(max(pvd.vert_f32d3_inter_0[0], pvd.vert_f32d3_inter_0[1]), pvd.vert_f32d3_inter_0[2]), pvd.vert_f32d3_inter_0[3])))) && all(greaterThanEqual(vert_f32d3_inter_0, f32vec3(min(min(min(pvd.vert_f32d3_inter_0[0], pvd.vert_f32d3_inter_0[1]), pvd.vert_f32d3_inter_0[2]), pvd.vert_f32d3_inter_0[3]))));
    bool good_vert_f32d4_flat_0 = all(lessThanEqual(vert_f32d4_flat_0, f32vec4(max(max(max(pvd.vert_f32d4_flat_0[0], pvd.vert_f32d4_flat_0[1]), pvd.vert_f32d4_flat_0[2]), pvd.vert_f32d4_flat_0[3])))) && all(greaterThanEqual(vert_f32d4_flat_0, f32vec4(min(min(min(pvd.vert_f32d4_flat_0[0], pvd.vert_f32d4_flat_0[1]), pvd.vert_f32d4_flat_0[2]), pvd.vert_f32d4_flat_0[3]))));
    bool good_prim_i32d2_flat_0 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && prim_i32d2_flat_0 == ppd.prim_i32d2_flat_0[0]) || (gl_PrimitiveID == 1 && prim_i32d2_flat_0 == ppd.prim_i32d2_flat_0[1])));
    bool good_vert_f32d2_inter_1 = all(lessThanEqual(vert_f32d2_inter_1, f32vec2(max(max(max(pvd.vert_f32d2_inter_1[0], pvd.vert_f32d2_inter_1[1]), pvd.vert_f32d2_inter_1[2]), pvd.vert_f32d2_inter_1[3])))) && all(greaterThanEqual(vert_f32d2_inter_1, f32vec2(min(min(min(pvd.vert_f32d2_inter_1[0], pvd.vert_f32d2_inter_1[1]), pvd.vert_f32d2_inter_1[2]), pvd.vert_f32d2_inter_1[3]))));
    bool good_vert_i32d1_flat_1 = (vert_i32d1_flat_1 <= int32_t(max(max(max(pvd.vert_i32d1_flat_1[0], pvd.vert_i32d1_flat_1[1]), pvd.vert_i32d1_flat_1[2]), pvd.vert_i32d1_flat_1[3]))) && (vert_i32d1_flat_1 >= int32_t(min(min(min(pvd.vert_i32d1_flat_1[0], pvd.vert_i32d1_flat_1[1]), pvd.vert_i32d1_flat_1[2]), pvd.vert_i32d1_flat_1[3])));
    bool good_vert_i32d2_flat_0 = all(lessThanEqual(vert_i32d2_flat_0, i32vec2(max(max(max(pvd.vert_i32d2_flat_0[0], pvd.vert_i32d2_flat_0[1]), pvd.vert_i32d2_flat_0[2]), pvd.vert_i32d2_flat_0[3])))) && all(greaterThanEqual(vert_i32d2_flat_0, i32vec2(min(min(min(pvd.vert_i32d2_flat_0[0], pvd.vert_i32d2_flat_0[1]), pvd.vert_i32d2_flat_0[2]), pvd.vert_i32d2_flat_0[3]))));
    bool good_prim_i32d4_flat_1 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && prim_i32d4_flat_1 == ppd.prim_i32d4_flat_1[0]) || (gl_PrimitiveID == 1 && prim_i32d4_flat_1 == ppd.prim_i32d4_flat_1[1])));
    bool good_vert_f32d2_inter_0 = all(lessThanEqual(vert_f32d2_inter_0, f32vec2(max(max(max(pvd.vert_f32d2_inter_0[0], pvd.vert_f32d2_inter_0[1]), pvd.vert_f32d2_inter_0[2]), pvd.vert_f32d2_inter_0[3])))) && all(greaterThanEqual(vert_f32d2_inter_0, f32vec2(min(min(min(pvd.vert_f32d2_inter_0[0], pvd.vert_f32d2_inter_0[1]), pvd.vert_f32d2_inter_0[2]), pvd.vert_f32d2_inter_0[3]))));
    bool good_prim_i32d2_flat_1 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && prim_i32d2_flat_1 == ppd.prim_i32d2_flat_1[0]) || (gl_PrimitiveID == 1 && prim_i32d2_flat_1 == ppd.prim_i32d2_flat_1[1])));
    bool good_prim_f32d1_flat_1 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && prim_f32d1_flat_1 == ppd.prim_f32d1_flat_1[0]) || (gl_PrimitiveID == 1 && prim_f32d1_flat_1 == ppd.prim_f32d1_flat_1[1])));
    bool good_prim_f32d3_flat_1 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && prim_f32d3_flat_1 == ppd.prim_f32d3_flat_1[0]) || (gl_PrimitiveID == 1 && prim_f32d3_flat_1 == ppd.prim_f32d3_flat_1[1])));
    bool good_prim_i16d4_flat_1 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && prim_i16d4_flat_1 == ppd.prim_i16d4_flat_1[0]) || (gl_PrimitiveID == 1 && prim_i16d4_flat_1 == ppd.prim_i16d4_flat_1[1])));
    bool good_prim_i16d1_flat_1 = ((gl_PrimitiveID == 0 || gl_PrimitiveID == 1) && ((gl_PrimitiveID == 0 && prim_i16d1_flat_1 == ppd.prim_i16d1_flat_1[0]) || (gl_PrimitiveID == 1 && prim_i16d1_flat_1 == ppd.prim_i16d1_flat_1[1])));
    if (good_vert_i16d3_flat_0 && good_vert_f32d1_flat_0 && good_vert_f32d3_flat_0 && good_vert_f32d3_inter_0 && good_vert_f32d4_flat_0 && good_prim_i32d2_flat_0 && good_vert_f32d2_inter_1 && good_vert_i32d1_flat_1 && good_vert_i32d2_flat_0 && good_prim_i32d4_flat_1 && good_vert_f32d2_inter_0 && good_prim_i32d2_flat_1 && good_prim_f32d1_flat_1 && good_prim_f32d3_flat_1 && good_prim_i16d4_flat_1 && good_prim_i16d1_flat_1) {
        outColor = vec4(0.0, 0.0, 1.0, 1.0);
    } else {
        outColor = vec4(0.0, 0.0, 0.0, 1.0);
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable

struct TaskData {
    i16vec3 vert_i16d3_flat_0[4];
    float32_t vert_f32d1_flat_0[4];
    f32vec3 vert_f32d3_flat_0[4];
    f32vec3 vert_f32d3_inter_0[4];
    f32vec4 vert_f32d4_flat_0[4];
    i32vec2 prim_i32d2_flat_0[2];
    f32vec2 vert_f32d2_inter_1[4];
    int32_t vert_i32d1_flat_1[4];
    i32vec2 vert_i32d2_flat_0[4];
    i32vec4 prim_i32d4_flat_1[2];
    f32vec2 vert_f32d2_inter_0[4];
    i32vec2 prim_i32d2_flat_1[2];
    float32_t prim_f32d1_flat_1[2];
    f32vec3 prim_f32d3_flat_1[2];
    i16vec4 prim_i16d4_flat_1[2];
    int16_t prim_i16d1_flat_1[2];
};

taskPayloadSharedEXT TaskData td;

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
    td.vert_i16d3_flat_0[0] = i16vec3(pvd.vert_i16d3_flat_0[0]);
    td.vert_i16d3_flat_0[1] = i16vec3(pvd.vert_i16d3_flat_0[1]);
    td.vert_i16d3_flat_0[2] = i16vec3(pvd.vert_i16d3_flat_0[2]);
    td.vert_i16d3_flat_0[3] = i16vec3(pvd.vert_i16d3_flat_0[3]);
    td.vert_f32d1_flat_0[0] = float32_t(pvd.vert_f32d1_flat_0[0]);
    td.vert_f32d1_flat_0[1] = float32_t(pvd.vert_f32d1_flat_0[1]);
    td.vert_f32d1_flat_0[2] = float32_t(pvd.vert_f32d1_flat_0[2]);
    td.vert_f32d1_flat_0[3] = float32_t(pvd.vert_f32d1_flat_0[3]);
    td.vert_f32d3_flat_0[0] = f32vec3(pvd.vert_f32d3_flat_0[0]);
    td.vert_f32d3_flat_0[1] = f32vec3(pvd.vert_f32d3_flat_0[1]);
    td.vert_f32d3_flat_0[2] = f32vec3(pvd.vert_f32d3_flat_0[2]);
    td.vert_f32d3_flat_0[3] = f32vec3(pvd.vert_f32d3_flat_0[3]);
    td.vert_f32d3_inter_0[0] = f32vec3(pvd.vert_f32d3_inter_0[0]);
    td.vert_f32d3_inter_0[1] = f32vec3(pvd.vert_f32d3_inter_0[1]);
    td.vert_f32d3_inter_0[2] = f32vec3(pvd.vert_f32d3_inter_0[2]);
    td.vert_f32d3_inter_0[3] = f32vec3(pvd.vert_f32d3_inter_0[3]);
    td.vert_f32d4_flat_0[0] = f32vec4(pvd.vert_f32d4_flat_0[0]);
    td.vert_f32d4_flat_0[1] = f32vec4(pvd.vert_f32d4_flat_0[1]);
    td.vert_f32d4_flat_0[2] = f32vec4(pvd.vert_f32d4_flat_0[2]);
    td.vert_f32d4_flat_0[3] = f32vec4(pvd.vert_f32d4_flat_0[3]);
    td.prim_i32d2_flat_0[0] = i32vec2(ppd.prim_i32d2_flat_0[0]);
    td.prim_i32d2_flat_0[1] = i32vec2(ppd.prim_i32d2_flat_0[1]);
    td.vert_f32d2_inter_1[0] = f32vec2(pvd.vert_f32d2_inter_1[0]);
    td.vert_f32d2_inter_1[1] = f32vec2(pvd.vert_f32d2_inter_1[1]);
    td.vert_f32d2_inter_1[2] = f32vec2(pvd.vert_f32d2_inter_1[2]);
    td.vert_f32d2_inter_1[3] = f32vec2(pvd.vert_f32d2_inter_1[3]);
    td.vert_i32d1_flat_1[0] = int32_t(pvd.vert_i32d1_flat_1[0]);
    td.vert_i32d1_flat_1[1] = int32_t(pvd.vert_i32d1_flat_1[1]);
    td.vert_i32d1_flat_1[2] = int32_t(pvd.vert_i32d1_flat_1[2]);
    td.vert_i32d1_flat_1[3] = int32_t(pvd.vert_i32d1_flat_1[3]);
    td.vert_i32d2_flat_0[0] = i32vec2(pvd.vert_i32d2_flat_0[0]);
    td.vert_i32d2_flat_0[1] = i32vec2(pvd.vert_i32d2_flat_0[1]);
    td.vert_i32d2_flat_0[2] = i32vec2(pvd.vert_i32d2_flat_0[2]);
    td.vert_i32d2_flat_0[3] = i32vec2(pvd.vert_i32d2_flat_0[3]);
    td.prim_i32d4_flat_1[0] = i32vec4(ppd.prim_i32d4_flat_1[0]);
    td.prim_i32d4_flat_1[1] = i32vec4(ppd.prim_i32d4_flat_1[1]);
    td.vert_f32d2_inter_0[0] = f32vec2(pvd.vert_f32d2_inter_0[0]);
    td.vert_f32d2_inter_0[1] = f32vec2(pvd.vert_f32d2_inter_0[1]);
    td.vert_f32d2_inter_0[2] = f32vec2(pvd.vert_f32d2_inter_0[2]);
    td.vert_f32d2_inter_0[3] = f32vec2(pvd.vert_f32d2_inter_0[3]);
    td.prim_i32d2_flat_1[0] = i32vec2(ppd.prim_i32d2_flat_1[0]);
    td.prim_i32d2_flat_1[1] = i32vec2(ppd.prim_i32d2_flat_1[1]);
    td.prim_f32d1_flat_1[0] = float32_t(ppd.prim_f32d1_flat_1[0]);
    td.prim_f32d1_flat_1[1] = float32_t(ppd.prim_f32d1_flat_1[1]);
    td.prim_f32d3_flat_1[0] = f32vec3(ppd.prim_f32d3_flat_1[0]);
    td.prim_f32d3_flat_1[1] = f32vec3(ppd.prim_f32d3_flat_1[1]);
    td.prim_i16d4_flat_1[0] = i16vec4(ppd.prim_i16d4_flat_1[0]);
    td.prim_i16d4_flat_1[1] = i16vec4(ppd.prim_i16d4_flat_1[1]);
    td.prim_i16d1_flat_1[0] = int16_t(ppd.prim_i16d1_flat_1[0]);
    td.prim_i16d1_flat_1[1] = int16_t(ppd.prim_i16d1_flat_1[1]);

    EmitMeshTasksEXT(1, 1, 1);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable

layout (local_size_x=1) in;
layout (max_primitives=2, max_vertices=4) out;
layout (triangles) out;

layout (location=0) out flat i16vec3 vert_i16d3_flat_0[];
layout (location=1) out flat float32_t vert_f32d1_flat_0[];
layout (location=2) out flat f32vec3 vert_f32d3_flat_0[];
layout (location=3) out f32vec3 vert_f32d3_inter_0[];
layout (location=4) out flat f32vec4 vert_f32d4_flat_0[];
layout (location=5) out perprimitiveEXT flat i32vec2 prim_i32d2_flat_0[];
layout (location=6) out f32vec2 vert_f32d2_inter_1[];
layout (location=7) out flat int32_t vert_i32d1_flat_1[];
layout (location=8) out flat i32vec2 vert_i32d2_flat_0[];
layout (location=9) out perprimitiveEXT flat i32vec4 prim_i32d4_flat_1[];
layout (location=10) out f32vec2 vert_f32d2_inter_0[];
layout (location=11) out perprimitiveEXT flat i32vec2 prim_i32d2_flat_1[];
layout (location=12) out perprimitiveEXT flat float32_t prim_f32d1_flat_1[];
layout (location=13) out perprimitiveEXT flat f32vec3 prim_f32d3_flat_1[];
layout (location=14) out perprimitiveEXT flat i16vec4 prim_i16d4_flat_1[];
layout (location=15) out perprimitiveEXT flat int16_t prim_i16d1_flat_1[];
out gl_MeshPerVertexEXT {
   vec4  gl_Position;
} gl_MeshVerticesEXT[];
out perprimitiveEXT gl_MeshPerPrimitiveEXT {
  int gl_PrimitiveID;
} gl_MeshPrimitivesEXT[];

struct TaskData {
    i16vec3 vert_i16d3_flat_0[4];
    float32_t vert_f32d1_flat_0[4];
    f32vec3 vert_f32d3_flat_0[4];
    f32vec3 vert_f32d3_inter_0[4];
    f32vec4 vert_f32d4_flat_0[4];
    i32vec2 prim_i32d2_flat_0[2];
    f32vec2 vert_f32d2_inter_1[4];
    int32_t vert_i32d1_flat_1[4];
    i32vec2 vert_i32d2_flat_0[4];
    i32vec4 prim_i32d4_flat_1[2];
    f32vec2 vert_f32d2_inter_0[4];
    i32vec2 prim_i32d2_flat_1[2];
    float32_t prim_f32d1_flat_1[2];
    f32vec3 prim_f32d3_flat_1[2];
    i16vec4 prim_i16d4_flat_1[2];
    int16_t prim_i16d1_flat_1[2];
};

taskPayloadSharedEXT TaskData td;
vec4 positions[4] = vec4[](
    vec4(-1.0, -1.0, 0.0, 1.0),
    vec4( 1.0, -1.0, 0.0, 1.0),
    vec4(-1.0,  1.0, 0.0, 1.0),
    vec4( 1.0,  1.0, 0.0, 1.0)
);

uvec3 indices[2] = uvec3[](
    uvec3(0, 1, 2),
    uvec3(2, 3, 1)
);

void main ()
{
    SetMeshOutputsEXT(4, 2);

    gl_MeshVerticesEXT[0].gl_Position = positions[0];
    gl_MeshVerticesEXT[1].gl_Position = positions[1];
    gl_MeshVerticesEXT[2].gl_Position = positions[2];
    gl_MeshVerticesEXT[3].gl_Position = positions[3];

    gl_PrimitiveTriangleIndicesEXT[0] = indices[0];
    gl_PrimitiveTriangleIndicesEXT[1] = indices[1];

    gl_MeshPrimitivesEXT[0].gl_PrimitiveID = 0;
    gl_MeshPrimitivesEXT[1].gl_PrimitiveID = 1;

    vert_i16d3_flat_0[0] = i16vec3(td.vert_i16d3_flat_0[0]);
    vert_i16d3_flat_0[1] = i16vec3(td.vert_i16d3_flat_0[1]);
    vert_i16d3_flat_0[2] = i16vec3(td.vert_i16d3_flat_0[2]);
    vert_i16d3_flat_0[3] = i16vec3(td.vert_i16d3_flat_0[3]);
    vert_f32d1_flat_0[0] = float32_t(td.vert_f32d1_flat_0[0]);
    vert_f32d1_flat_0[1] = float32_t(td.vert_f32d1_flat_0[1]);
    vert_f32d1_flat_0[2] = float32_t(td.vert_f32d1_flat_0[2]);
    vert_f32d1_flat_0[3] = float32_t(td.vert_f32d1_flat_0[3]);
    vert_f32d3_flat_0[0] = f32vec3(td.vert_f32d3_flat_0[0]);
    vert_f32d3_flat_0[1] = f32vec3(td.vert_f32d3_flat_0[1]);
    vert_f32d3_flat_0[2] = f32vec3(td.vert_f32d3_flat_0[2]);
    vert_f32d3_flat_0[3] = f32vec3(td.vert_f32d3_flat_0[3]);
    vert_f32d3_inter_0[0] = f32vec3(td.vert_f32d3_inter_0[0]);
    vert_f32d3_inter_0[1] = f32vec3(td.vert_f32d3_inter_0[1]);
    vert_f32d3_inter_0[2] = f32vec3(td.vert_f32d3_inter_0[2]);
    vert_f32d3_inter_0[3] = f32vec3(td.vert_f32d3_inter_0[3]);
    vert_f32d4_flat_0[0] = f32vec4(td.vert_f32d4_flat_0[0]);
    vert_f32d4_flat_0[1] = f32vec4(td.vert_f32d4_flat_0[1]);
    vert_f32d4_flat_0[2] = f32vec4(td.vert_f32d4_flat_0[2]);
    vert_f32d4_flat_0[3] = f32vec4(td.vert_f32d4_flat_0[3]);
    prim_i32d2_flat_0[0] = i32vec2(td.prim_i32d2_flat_0[0]);
    prim_i32d2_flat_0[1] = i32vec2(td.prim_i32d2_flat_0[1]);
    vert_f32d2_inter_1[0] = f32vec2(td.vert_f32d2_inter_1[0]);
    vert_f32d2_inter_1[1] = f32vec2(td.vert_f32d2_inter_1[1]);
    vert_f32d2_inter_1[2] = f32vec2(td.vert_f32d2_inter_1[2]);
    vert_f32d2_inter_1[3] = f32vec2(td.vert_f32d2_inter_1[3]);
    vert_i32d1_flat_1[0] = int32_t(td.vert_i32d1_flat_1[0]);
    vert_i32d1_flat_1[1] = int32_t(td.vert_i32d1_flat_1[1]);
    vert_i32d1_flat_1[2] = int32_t(td.vert_i32d1_flat_1[2]);
    vert_i32d1_flat_1[3] = int32_t(td.vert_i32d1_flat_1[3]);
    vert_i32d2_flat_0[0] = i32vec2(td.vert_i32d2_flat_0[0]);
    vert_i32d2_flat_0[1] = i32vec2(td.vert_i32d2_flat_0[1]);
    vert_i32d2_flat_0[2] = i32vec2(td.vert_i32d2_flat_0[2]);
    vert_i32d2_flat_0[3] = i32vec2(td.vert_i32d2_flat_0[3]);
    prim_i32d4_flat_1[0] = i32vec4(td.prim_i32d4_flat_1[0]);
    prim_i32d4_flat_1[1] = i32vec4(td.prim_i32d4_flat_1[1]);
    vert_f32d2_inter_0[0] = f32vec2(td.vert_f32d2_inter_0[0]);
    vert_f32d2_inter_0[1] = f32vec2(td.vert_f32d2_inter_0[1]);
    vert_f32d2_inter_0[2] = f32vec2(td.vert_f32d2_inter_0[2]);
    vert_f32d2_inter_0[3] = f32vec2(td.vert_f32d2_inter_0[3]);
    prim_i32d2_flat_1[0] = i32vec2(td.prim_i32d2_flat_1[0]);
    prim_i32d2_flat_1[1] = i32vec2(td.prim_i32d2_flat_1[1]);
    prim_f32d1_flat_1[0] = float32_t(td.prim_f32d1_flat_1[0]);
    prim_f32d1_flat_1[1] = float32_t(td.prim_f32d1_flat_1[1]);
    prim_f32d3_flat_1[0] = f32vec3(td.prim_f32d3_flat_1[0]);
    prim_f32d3_flat_1[1] = f32vec3(td.prim_f32d3_flat_1[1]);
    prim_i16d4_flat_1[0] = i16vec4(td.prim_i16d4_flat_1[0]);
    prim_i16d4_flat_1[1] = i16vec4(td.prim_i16d4_flat_1[1]);
    prim_i16d1_flat_1[0] = int16_t(td.prim_i16d1_flat_1[0]);
    prim_i16d1_flat_1[1] = int16_t(td.prim_i16d1_flat_1[1]);

}
