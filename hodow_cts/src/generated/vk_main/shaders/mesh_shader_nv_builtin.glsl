#version 460
#extension GL_NV_mesh_shader : enable

layout (local_size_x=1) in;
layout (triangles) out;
layout (max_vertices=3, max_primitives=1) out;

void main ()
{
    gl_PrimitiveCountNV = 1u;

    gl_PrimitiveIndicesNV[0] = 0;
    gl_PrimitiveIndicesNV[1] = 1;
    gl_PrimitiveIndicesNV[2] = 2;

    gl_MeshVerticesNV[0].gl_Position = vec4(-1, -0.75, 0.0, 1.0);
    gl_MeshVerticesNV[1].gl_Position = vec4(-0.75, -0.75, 0.0, 1.0);
    gl_MeshVerticesNV[2].gl_Position = vec4(-0.875, -1, 0.0, 1.0);
}
#version 460
#extension GL_NV_mesh_shader : enable

layout (location=0) out vec4 outColor;

void main ()
{
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
}
#version 460
#extension GL_NV_mesh_shader : enable

layout (local_size_x=1) in;
layout (points) out;
layout (max_vertices=1, max_primitives=1) out;

void main ()
{
    gl_PrimitiveCountNV = 1u;
    gl_PrimitiveIndicesNV[0] = 0;
    gl_MeshVerticesNV[0].gl_Position = vec4(-0.5, -0.5, 0.0, 1.0);
    gl_MeshVerticesNV[0].gl_PointSize = 4;
}
#version 460
#extension GL_NV_mesh_shader : enable

layout (local_size_x=1) in;
layout (triangles) out;
layout (max_vertices=4, max_primitives=2) out;

out gl_MeshPerVertexNV {
    vec4  gl_Position;
    float gl_ClipDistance[2];
} gl_MeshVerticesNV[];

void main ()
{
    gl_PrimitiveCountNV = 2u;

    gl_PrimitiveIndicesNV[0] = 0;
    gl_PrimitiveIndicesNV[1] = 1;
    gl_PrimitiveIndicesNV[2] = 2;
    gl_PrimitiveIndicesNV[3] = 1;
    gl_PrimitiveIndicesNV[4] = 3;
    gl_PrimitiveIndicesNV[5] = 2;

    gl_MeshVerticesNV[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesNV[1].gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
    gl_MeshVerticesNV[2].gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesNV[3].gl_Position = vec4( 1.0,  1.0, 0.0, 1.0);

    gl_MeshVerticesNV[0].gl_ClipDistance[0] =  1.0;
    gl_MeshVerticesNV[1].gl_ClipDistance[0] =  1.0;
    gl_MeshVerticesNV[2].gl_ClipDistance[0] = -1.0;
    gl_MeshVerticesNV[3].gl_ClipDistance[0] = -1.0;

    gl_MeshVerticesNV[0].gl_ClipDistance[1] =  1.0;
    gl_MeshVerticesNV[1].gl_ClipDistance[1] = -1.0;
    gl_MeshVerticesNV[2].gl_ClipDistance[1] =  1.0;
    gl_MeshVerticesNV[3].gl_ClipDistance[1] = -1.0;
}
#version 460
#extension GL_NV_mesh_shader : enable

layout (location=0) out vec4 outColor;

void main ()
{
    outColor = ((gl_ClipDistance[0] >= 0.0 && gl_ClipDistance[1] >= 0.0) ? vec4(0.0, 0.0, 1.0, 1.0) : vec4(1.0, 1.0, 1.0, 1.0));
}
#version 460
#extension GL_NV_mesh_shader : enable

layout (local_size_x=1) in;
layout (triangles) out;
layout (max_vertices=6, max_primitives=4) out;

out gl_MeshPerVertexNV {
    vec4  gl_Position;
    float gl_CullDistance[2];
} gl_MeshVerticesNV[];

void main ()
{
    gl_PrimitiveCountNV = 4u;

    gl_PrimitiveIndicesNV[0]  = 0;
    gl_PrimitiveIndicesNV[1]  = 1;
    gl_PrimitiveIndicesNV[2]  = 3;
    gl_PrimitiveIndicesNV[3]  = 1;
    gl_PrimitiveIndicesNV[4]  = 4;
    gl_PrimitiveIndicesNV[5]  = 3;
    gl_PrimitiveIndicesNV[6]  = 1;
    gl_PrimitiveIndicesNV[7]  = 2;
    gl_PrimitiveIndicesNV[8]  = 4;
    gl_PrimitiveIndicesNV[9]  = 2;
    gl_PrimitiveIndicesNV[10] = 5;
    gl_PrimitiveIndicesNV[11] = 4;

    gl_MeshVerticesNV[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesNV[1].gl_Position = vec4(-1.0,  0.0, 0.0, 1.0);
    gl_MeshVerticesNV[2].gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
    gl_MeshVerticesNV[3].gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesNV[4].gl_Position = vec4( 1.0,  0.0, 0.0, 1.0);
    gl_MeshVerticesNV[5].gl_Position = vec4( 1.0,  1.0, 0.0, 1.0);

    gl_MeshVerticesNV[0].gl_CullDistance[0] =  1.0;
    gl_MeshVerticesNV[1].gl_CullDistance[0] = -1.0;
    gl_MeshVerticesNV[2].gl_CullDistance[0] = -2.0;
    gl_MeshVerticesNV[3].gl_CullDistance[0] =  1.0;
    gl_MeshVerticesNV[4].gl_CullDistance[0] = -1.0;
    gl_MeshVerticesNV[5].gl_CullDistance[0] = -2.0;

    gl_MeshVerticesNV[0].gl_CullDistance[1] =  1.0;
    gl_MeshVerticesNV[1].gl_CullDistance[1] =  1.0;
    gl_MeshVerticesNV[2].gl_CullDistance[1] =  1.0;
    gl_MeshVerticesNV[3].gl_CullDistance[1] = -1.0;
    gl_MeshVerticesNV[4].gl_CullDistance[1] = -1.0;
    gl_MeshVerticesNV[5].gl_CullDistance[1] = -1.0;
}
#version 460
#extension GL_NV_mesh_shader : enable

layout (location=0) out vec4 outColor;

void main ()
{
    outColor = ((gl_CullDistance[1] >= 0.0) ? vec4(0.0, 0.0, 1.0, 1.0) : vec4(1.0, 1.0, 1.0, 1.0));
}
#version 460
#extension GL_NV_mesh_shader : enable

layout (local_size_x=1) in;
layout (triangles) out;
layout (max_vertices=3, max_primitives=1) out;

perprimitiveNV out gl_MeshPerPrimitiveNV {
   int gl_PrimitiveID;
} gl_MeshPrimitivesNV[];

void main ()
{
    gl_PrimitiveCountNV = 1u;

    gl_PrimitiveIndicesNV[0] = 0;
    gl_PrimitiveIndicesNV[1] = 1;
    gl_PrimitiveIndicesNV[2] = 2;

    gl_MeshVerticesNV[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesNV[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
    gl_MeshVerticesNV[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);

    gl_MeshPrimitivesNV[0].gl_PrimitiveID = 1629198956;
}
#version 460
#extension GL_NV_mesh_shader : enable

layout (location=0) out vec4 outColor;

void main ()
{
    outColor = ((gl_PrimitiveID == 1629198956) ? vec4(0.0, 0.0, 1.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0));
}
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 24
; Schema: 0
      OpCapability Shader
      OpCapability MeshShadingNV
      OpExtension "SPV_NV_mesh_shader"
 %1 = OpExtInstImport "GLSL.std.450"
      OpMemoryModel Logical GLSL450
      OpEntryPoint Fragment %4 "main" %9 %12
      OpExecutionMode %4 OriginUpperLeft
      OpDecorate %9 Location 0
      OpDecorate %12 Flat
      OpDecorate %12 BuiltIn PrimitiveId
 %2 = OpTypeVoid
 %3 = OpTypeFunction %2
 %6 = OpTypeFloat 32
 %7 = OpTypeVector %6 4
 %8 = OpTypePointer Output %7
 %9 = OpVariable %8 Output
%10 = OpTypeInt 32 1
%11 = OpTypePointer Input %10
%12 = OpVariable %11 Input
%14 = OpConstant %10 1629198956
%15 = OpTypeBool
%17 = OpConstant %6 0
%18 = OpConstant %6 1
%19 = OpConstantComposite %7 %17 %17 %18 %18
%20 = OpConstantComposite %7 %17 %17 %17 %18
%21 = OpTypeVector %15 4
 %4 = OpFunction %2 None %3
 %5 = OpLabel
%13 = OpLoad %10 %12
%16 = OpIEqual %15 %13 %14
%22 = OpCompositeConstruct %21 %16 %16 %16 %16
%23 = OpSelect %7 %22 %19 %20
      OpStore %9 %23
      OpReturn
      OpFunctionEnd
#version 460
#extension GL_NV_mesh_shader : enable

layout (local_size_x=1) in;
layout (triangles) out;
layout (max_vertices=3, max_primitives=1) out;

perprimitiveNV out gl_MeshPerPrimitiveNV {
   int gl_Layer;
} gl_MeshPrimitivesNV[];

void main ()
{
    gl_PrimitiveCountNV = 1;

    if (gl_LocalInvocationIndex == 0u)
    {
        gl_MeshVerticesNV[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        gl_MeshVerticesNV[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
        gl_MeshVerticesNV[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    }

    const uint baseIndex = gl_LocalInvocationIndex * 3u;
    gl_PrimitiveIndicesNV[baseIndex + 0] = 0;
    gl_PrimitiveIndicesNV[baseIndex + 1] = 1;
    gl_PrimitiveIndicesNV[baseIndex + 2] = 2;

    gl_MeshPrimitivesNV[gl_LocalInvocationIndex].gl_Layer = int(gl_WorkGroupID.x);
}
#version 460
#extension GL_NV_mesh_shader : enable

layout (location=0) out vec4 outColor;

vec4 colors[4] = vec4[](
    vec4(0.0, 0.0, 1.0, 1.0),
    vec4(1.0, 0.0, 1.0, 1.0),
    vec4(0.0, 1.0, 1.0, 1.0),
    vec4(1.0, 1.0, 0.0, 1.0)
);

void main ()
{
    outColor = colors[gl_Layer];
}
#version 460
#extension GL_NV_mesh_shader : enable

layout (local_size_x=4) in;
layout (triangles) out;
layout (max_vertices=3, max_primitives=4) out;

perprimitiveNV out gl_MeshPerPrimitiveNV {
   int gl_Layer;
} gl_MeshPrimitivesNV[];

void main ()
{
    gl_PrimitiveCountNV = 4;

    if (gl_LocalInvocationIndex == 0u)
    {
        gl_MeshVerticesNV[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        gl_MeshVerticesNV[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
        gl_MeshVerticesNV[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    }

    const uint baseIndex = gl_LocalInvocationIndex * 3u;
    gl_PrimitiveIndicesNV[baseIndex + 0] = 0;
    gl_PrimitiveIndicesNV[baseIndex + 1] = 1;
    gl_PrimitiveIndicesNV[baseIndex + 2] = 2;

    gl_MeshPrimitivesNV[gl_LocalInvocationIndex].gl_Layer = int(gl_LocalInvocationIndex);
}
#version 460
#extension GL_NV_mesh_shader : enable

layout (local_size_x=1) in;
layout (triangles) out;
layout (max_vertices=3, max_primitives=1) out;

perprimitiveNV out gl_MeshPerPrimitiveNV {
   int gl_ViewportIndex;
} gl_MeshPrimitivesNV[];

void main ()
{
    gl_PrimitiveCountNV = 1;

    if (gl_LocalInvocationIndex == 0u)
    {
        gl_MeshVerticesNV[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        gl_MeshVerticesNV[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
        gl_MeshVerticesNV[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    }

    const uint baseIndex = gl_LocalInvocationIndex * 3u;
    gl_PrimitiveIndicesNV[baseIndex + 0] = 0;
    gl_PrimitiveIndicesNV[baseIndex + 1] = 1;
    gl_PrimitiveIndicesNV[baseIndex + 2] = 2;

    gl_MeshPrimitivesNV[gl_LocalInvocationIndex].gl_ViewportIndex = int(gl_WorkGroupID.x);
}
#version 460
#extension GL_NV_mesh_shader : enable

layout (location=0) out vec4 outColor;

vec4 colors[4] = vec4[](
    vec4(0.0, 0.0, 1.0, 1.0),
    vec4(1.0, 0.0, 1.0, 1.0),
    vec4(0.0, 1.0, 1.0, 1.0),
    vec4(1.0, 1.0, 0.0, 1.0)
);

void main ()
{
    outColor = colors[gl_ViewportIndex];
}
#version 460
#extension GL_NV_mesh_shader : enable

layout (local_size_x=4) in;
layout (triangles) out;
layout (max_vertices=3, max_primitives=4) out;

perprimitiveNV out gl_MeshPerPrimitiveNV {
   int gl_ViewportIndex;
} gl_MeshPrimitivesNV[];

void main ()
{
    gl_PrimitiveCountNV = 4;

    if (gl_LocalInvocationIndex == 0u)
    {
        gl_MeshVerticesNV[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        gl_MeshVerticesNV[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
        gl_MeshVerticesNV[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    }

    const uint baseIndex = gl_LocalInvocationIndex * 3u;
    gl_PrimitiveIndicesNV[baseIndex + 0] = 0;
    gl_PrimitiveIndicesNV[baseIndex + 1] = 1;
    gl_PrimitiveIndicesNV[baseIndex + 2] = 2;

    gl_MeshPrimitivesNV[gl_LocalInvocationIndex].gl_ViewportIndex = int(gl_LocalInvocationIndex);
}
#version 460
#extension GL_NV_mesh_shader : enable

layout (local_size_x=1) in;
layout (triangles) out;
layout (max_vertices=3, max_primitives=1) out;


void main ()
{
    gl_PrimitiveCountNV = 1u;

    const float imgWidth = float(8);
    const float pixWidth = (2.0 / imgWidth);
    const float halfPix  = (pixWidth / 2.0);
    const float xCenter  = (((float(gl_WorkGroupID.x) + 0.5) / imgWidth) * 2.0 - 1.0);
    const float xLeft    = (xCenter - halfPix);
    const float xRight   = (xCenter + halfPix);
    const uvec3 indices  = uvec3(0 + 0, 0 + 1, 0 + 2);

    gl_PrimitiveIndicesNV[indices.x] = indices.x;
    gl_PrimitiveIndicesNV[indices.y] = indices.y;
    gl_PrimitiveIndicesNV[indices.z] = indices.z;

    gl_MeshVerticesNV[indices.x].gl_Position = vec4(xLeft,    0.5, 0.0, 1.0);
    gl_MeshVerticesNV[indices.y].gl_Position = vec4(xRight,   0.5, 0.0, 1.0);
    gl_MeshVerticesNV[indices.z].gl_Position = vec4(xCenter, -0.5, 0.0, 1.0);
}
#version 460
#extension GL_NV_mesh_shader : enable

layout (local_size_x=1) in;
layout (triangles) out;
layout (max_vertices=3, max_primitives=1) out;

in taskNV TaskData {
    uint id;
    uint size;
} td;

void main ()
{
    gl_PrimitiveCountNV = 1u;

    const float imgWidth = float(td.size);
    const float pixWidth = (2.0 / imgWidth);
    const float halfPix  = (pixWidth / 2.0);
    const float xCenter  = (((float(td.id) + 0.5) / imgWidth) * 2.0 - 1.0);
    const float xLeft    = (xCenter - halfPix);
    const float xRight   = (xCenter + halfPix);
    const uvec3 indices  = uvec3(0 + 0, 0 + 1, 0 + 2);

    gl_PrimitiveIndicesNV[indices.x] = indices.x;
    gl_PrimitiveIndicesNV[indices.y] = indices.y;
    gl_PrimitiveIndicesNV[indices.z] = indices.z;

    gl_MeshVerticesNV[indices.x].gl_Position = vec4(xLeft,    0.5, 0.0, 1.0);
    gl_MeshVerticesNV[indices.y].gl_Position = vec4(xRight,   0.5, 0.0, 1.0);
    gl_MeshVerticesNV[indices.z].gl_Position = vec4(xCenter, -0.5, 0.0, 1.0);
}
#version 460
#extension GL_NV_mesh_shader : enable

layout (local_size_x=1) in;

out taskNV TaskData {
    uint id;
    uint size;
} td;

void main ()
{
    gl_TaskCountNV = 1u;
    td.id          = gl_WorkGroupID.x;
    td.size        = 8;
}
#version 460
#extension GL_NV_mesh_shader : enable

layout (local_size_x=8) in;
layout (triangles) out;
layout (max_vertices=24, max_primitives=8) out;


void main ()
{
    gl_PrimitiveCountNV = 8;

    const float imgWidth = float(gl_WorkGroupSize.x);
    const float pixWidth = (2.0 / imgWidth);
    const float halfPix  = (pixWidth / 2.0);
    const float xCenter  = (((float(gl_LocalInvocationID.x) + 0.5) / imgWidth) * 2.0 - 1.0);
    const float xLeft    = (xCenter - halfPix);
    const float xRight   = (xCenter + halfPix);
    const uvec3 indices  = uvec3((gl_LocalInvocationID.x * 3u) + 0, (gl_LocalInvocationID.x * 3u) + 1, (gl_LocalInvocationID.x * 3u) + 2);

    gl_PrimitiveIndicesNV[indices.x] = indices.x;
    gl_PrimitiveIndicesNV[indices.y] = indices.y;
    gl_PrimitiveIndicesNV[indices.z] = indices.z;

    gl_MeshVerticesNV[indices.x].gl_Position = vec4(xLeft,    0.5, 0.0, 1.0);
    gl_MeshVerticesNV[indices.y].gl_Position = vec4(xRight,   0.5, 0.0, 1.0);
    gl_MeshVerticesNV[indices.z].gl_Position = vec4(xCenter, -0.5, 0.0, 1.0);
}
#version 460
#extension GL_NV_mesh_shader : enable

layout (local_size_x=1) in;
layout (triangles) out;
layout (max_vertices=3, max_primitives=1) out;

in taskNV TaskData {
    uint indexNumber[8];
    uint size;
} td;

void main ()
{
    gl_PrimitiveCountNV = 1;

    const float imgWidth = float(td.size);
    const float pixWidth = (2.0 / imgWidth);
    const float halfPix  = (pixWidth / 2.0);
    const float xCenter  = (((float(td.indexNumber[gl_WorkGroupID.x]) + 0.5) / imgWidth) * 2.0 - 1.0);
    const float xLeft    = (xCenter - halfPix);
    const float xRight   = (xCenter + halfPix);
    const uvec3 indices  = uvec3(0 + 0, 0 + 1, 0 + 2);

    gl_PrimitiveIndicesNV[indices.x] = indices.x;
    gl_PrimitiveIndicesNV[indices.y] = indices.y;
    gl_PrimitiveIndicesNV[indices.z] = indices.z;

    gl_MeshVerticesNV[indices.x].gl_Position = vec4(xLeft,    0.5, 0.0, 1.0);
    gl_MeshVerticesNV[indices.y].gl_Position = vec4(xRight,   0.5, 0.0, 1.0);
    gl_MeshVerticesNV[indices.z].gl_Position = vec4(xCenter, -0.5, 0.0, 1.0);
}
#version 460
#extension GL_NV_mesh_shader : enable

layout (local_size_x=8) in;

out taskNV TaskData {
    uint indexNumber[8];
    uint size;
} td;

void main ()
{
    gl_TaskCountNV = 8;
    td.indexNumber[gl_LocalInvocationID.x] = gl_LocalInvocationID.x;
    td.size = gl_WorkGroupSize.x;
}
#version 460
#extension GL_NV_mesh_shader : enable

layout (local_size_x=8) in;
layout (triangles) out;
layout (max_vertices=24, max_primitives=8) out;


void main ()
{
    gl_PrimitiveCountNV = 8;

    const float imgWidth = float(gl_WorkGroupSize.x);
    const float pixWidth = (2.0 / imgWidth);
    const float halfPix  = (pixWidth / 2.0);
    const float xCenter  = (((float(gl_LocalInvocationIndex) + 0.5) / imgWidth) * 2.0 - 1.0);
    const float xLeft    = (xCenter - halfPix);
    const float xRight   = (xCenter + halfPix);
    const uvec3 indices  = uvec3((gl_LocalInvocationIndex * 3u) + 0, (gl_LocalInvocationIndex * 3u) + 1, (gl_LocalInvocationIndex * 3u) + 2);

    gl_PrimitiveIndicesNV[indices.x] = indices.x;
    gl_PrimitiveIndicesNV[indices.y] = indices.y;
    gl_PrimitiveIndicesNV[indices.z] = indices.z;

    gl_MeshVerticesNV[indices.x].gl_Position = vec4(xLeft,    0.5, 0.0, 1.0);
    gl_MeshVerticesNV[indices.y].gl_Position = vec4(xRight,   0.5, 0.0, 1.0);
    gl_MeshVerticesNV[indices.z].gl_Position = vec4(xCenter, -0.5, 0.0, 1.0);
}
#version 460
#extension GL_NV_mesh_shader : enable

layout (local_size_x=8) in;

out taskNV TaskData {
    uint indexNumber[8];
    uint size;
} td;

void main ()
{
    gl_TaskCountNV = 8;
    td.indexNumber[gl_LocalInvocationIndex] = gl_LocalInvocationIndex;
    td.size = gl_WorkGroupSize.x;
}
#version 460
#extension GL_NV_mesh_shader : enable

layout (local_size_x=8) in;
layout (triangles) out;
layout (max_vertices=24, max_primitives=8) out;


void main ()
{
    gl_PrimitiveCountNV = 8;

    const float imgWidth = float(64);
    const float pixWidth = (2.0 / imgWidth);
    const float halfPix  = (pixWidth / 2.0);
    const float xCenter  = (((float(gl_GlobalInvocationID.x) + 0.5) / imgWidth) * 2.0 - 1.0);
    const float xLeft    = (xCenter - halfPix);
    const float xRight   = (xCenter + halfPix);
    const uvec3 indices  = uvec3((gl_LocalInvocationIndex * 3u) + 0, (gl_LocalInvocationIndex * 3u) + 1, (gl_LocalInvocationIndex * 3u) + 2);

    gl_PrimitiveIndicesNV[indices.x] = indices.x;
    gl_PrimitiveIndicesNV[indices.y] = indices.y;
    gl_PrimitiveIndicesNV[indices.z] = indices.z;

    gl_MeshVerticesNV[indices.x].gl_Position = vec4(xLeft,    0.5, 0.0, 1.0);
    gl_MeshVerticesNV[indices.y].gl_Position = vec4(xRight,   0.5, 0.0, 1.0);
    gl_MeshVerticesNV[indices.z].gl_Position = vec4(xCenter, -0.5, 0.0, 1.0);
}
#version 460
#extension GL_NV_mesh_shader : enable

layout (local_size_x=8) in;
layout (triangles) out;
layout (max_vertices=24, max_primitives=8) out;

in taskNV TaskData {
    uint pixelId[8];
    uint size;
} td;

void main ()
{
    gl_PrimitiveCountNV = 8;

    const float imgWidth = float(td.size);
    const float pixWidth = (2.0 / imgWidth);
    const float halfPix  = (pixWidth / 2.0);
    const float xCenter  = (((float(td.pixelId[gl_LocalInvocationIndex]) + 0.5) / imgWidth) * 2.0 - 1.0);
    const float xLeft    = (xCenter - halfPix);
    const float xRight   = (xCenter + halfPix);
    const uvec3 indices  = uvec3((gl_LocalInvocationIndex * 3u) + 0, (gl_LocalInvocationIndex * 3u) + 1, (gl_LocalInvocationIndex * 3u) + 2);

    gl_PrimitiveIndicesNV[indices.x] = indices.x;
    gl_PrimitiveIndicesNV[indices.y] = indices.y;
    gl_PrimitiveIndicesNV[indices.z] = indices.z;

    gl_MeshVerticesNV[indices.x].gl_Position = vec4(xLeft,    0.5, 0.0, 1.0);
    gl_MeshVerticesNV[indices.y].gl_Position = vec4(xRight,   0.5, 0.0, 1.0);
    gl_MeshVerticesNV[indices.z].gl_Position = vec4(xCenter, -0.5, 0.0, 1.0);
}
#version 460
#extension GL_NV_mesh_shader : enable

layout (local_size_x=8) in;

out taskNV TaskData {
    uint pixelId[8];
    uint size;
} td;

void main ()
{
    gl_TaskCountNV = 1;
    td.pixelId[gl_LocalInvocationIndex] = gl_GlobalInvocationID.x;
    td.size = 64;
}
#version 460
#extension GL_NV_mesh_shader : enable

layout (local_size_x=1) in;
layout (triangles) out;
layout (max_vertices=3, max_primitives=1) out;


void main ()
{
    gl_PrimitiveCountNV = 1u;

    const float imgWidth = float(8);
    const float pixWidth = (2.0 / imgWidth);
    const float halfPix  = (pixWidth / 2.0);
    const float xCenter  = (((float(uint(gl_DrawID)) + 0.5) / imgWidth) * 2.0 - 1.0);
    const float xLeft    = (xCenter - halfPix);
    const float xRight   = (xCenter + halfPix);
    const uvec3 indices  = uvec3(0 + 0, 0 + 1, 0 + 2);

    gl_PrimitiveIndicesNV[indices.x] = indices.x;
    gl_PrimitiveIndicesNV[indices.y] = indices.y;
    gl_PrimitiveIndicesNV[indices.z] = indices.z;

    gl_MeshVerticesNV[indices.x].gl_Position = vec4(xLeft,    0.5, 0.0, 1.0);
    gl_MeshVerticesNV[indices.y].gl_Position = vec4(xRight,   0.5, 0.0, 1.0);
    gl_MeshVerticesNV[indices.z].gl_Position = vec4(xCenter, -0.5, 0.0, 1.0);
}
#version 460
#extension GL_NV_mesh_shader : enable

layout (local_size_x=1) in;

out taskNV TaskData {
    uint id;
    uint size;
} td;

void main ()
{
    gl_TaskCountNV = 1u;
    td.id          = uint(gl_DrawID);
    td.size        = 8;
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 81
; Schema: 0
      OpCapability MeshShadingNV
      OpCapability FragmentShadingRateKHR
      OpExtension "SPV_NV_mesh_shader"
      OpExtension "SPV_KHR_fragment_shading_rate"
 %1 = OpExtInstImport "GLSL.std.450"
      OpMemoryModel Logical GLSL450
      OpEntryPoint MeshNV %4 "main" %8 %20 %47 %73
      OpExecutionMode %4 LocalSize 1 1 1
      OpExecutionMode %4 OutputVertices 6
      OpExecutionMode %4 OutputPrimitivesNV 4
      OpExecutionMode %4 OutputTrianglesNV
      OpDecorate %8 BuiltIn PrimitiveCountNV
      OpMemberDecorate %16 0 BuiltIn Position
      OpMemberDecorate %16 1 BuiltIn PointSize
      OpMemberDecorate %16 2 BuiltIn ClipDistance
      OpMemberDecorate %16 3 BuiltIn CullDistance
      OpMemberDecorate %16 4 PerViewNV
      OpMemberDecorate %16 4 BuiltIn PositionPerViewNV
      OpMemberDecorate %16 5 PerViewNV
      OpMemberDecorate %16 5 BuiltIn ClipDistancePerViewNV
      OpMemberDecorate %16 6 PerViewNV
      OpMemberDecorate %16 6 BuiltIn CullDistancePerViewNV
      OpDecorate %16 Block
      OpDecorate %47 BuiltIn PrimitiveIndicesNV
      OpMemberDecorate %70 0 PerPrimitiveNV
      OpMemberDecorate %70 0 BuiltIn PrimitiveShadingRateKHR
      OpDecorate %70 Block
      OpDecorate %80 BuiltIn WorkgroupSize
 %2 = OpTypeVoid
 %3 = OpTypeFunction %2
 %6 = OpTypeInt 32 0
 %7 = OpTypePointer Output %6
 %8 = OpVariable %7 Output
 %9 = OpConstant %6 4
%10 = OpTypeFloat 32
%11 = OpTypeVector %10 4
%12 = OpConstant %6 1
%13 = OpTypeArray %10 %12
%14 = OpTypeArray %11 %9
%15 = OpTypeArray %13 %9
%16 = OpTypeStruct %11 %10 %13 %13 %14 %15 %15
%17 = OpConstant %6 6
%18 = OpTypeArray %16 %17
%19 = OpTypePointer Output %18
%20 = OpVariable %19 Output
%21 = OpTypeInt 32 1
%tm = OpConstant %21 5
%bm = OpConstant %21 5
%22 = OpConstant %21 0
%23 = OpConstant %10 -1
%24 = OpConstant %10 0
%25 = OpConstant %10 1
%26 = OpConstantComposite %11 %23 %23 %24 %25
%27 = OpTypePointer Output %11
%29 = OpConstant %21 1
%30 = OpConstantComposite %11 %23 %24 %24 %25
%32 = OpConstant %21 2
%33 = OpConstantComposite %11 %23 %25 %24 %25
%35 = OpConstant %21 3
%36 = OpConstantComposite %11 %25 %23 %24 %25
%38 = OpConstant %21 4
%39 = OpConstantComposite %11 %25 %24 %24 %25
%41 = OpConstant %21 5
%42 = OpConstantComposite %11 %25 %25 %24 %25
%44 = OpConstant %6 12
%45 = OpTypeArray %6 %44
%46 = OpTypePointer Output %45
%47 = OpVariable %46 Output
%48 = OpConstant %6 0
%51 = OpConstant %6 3
%56 = OpConstant %21 6
%58 = OpConstant %21 7
%59 = OpConstant %6 2
%61 = OpConstant %21 8
%63 = OpConstant %21 9
%65 = OpConstant %21 10
%66 = OpConstant %6 5
%68 = OpConstant %21 11
%70 = OpTypeStruct %21
%71 = OpTypeArray %70 %9
%72 = OpTypePointer Output %71
%73 = OpVariable %72 Output
%74 = OpTypePointer Output %21
%79 = OpTypeVector %6 3
%80 = OpConstantComposite %79 %12 %12 %12
 %4 = OpFunction %2 None %3
 %5 = OpLabel
      OpStore %8 %9
%28 = OpAccessChain %27 %20 %22 %22
      OpStore %28 %26
%31 = OpAccessChain %27 %20 %29 %22
      OpStore %31 %30
%34 = OpAccessChain %27 %20 %32 %22
      OpStore %34 %33
%37 = OpAccessChain %27 %20 %35 %22
      OpStore %37 %36
%40 = OpAccessChain %27 %20 %38 %22
      OpStore %40 %39
%43 = OpAccessChain %27 %20 %41 %22
      OpStore %43 %42
%49 = OpAccessChain %7 %47 %22
      OpStore %49 %48
%50 = OpAccessChain %7 %47 %29
      OpStore %50 %12
%52 = OpAccessChain %7 %47 %32
      OpStore %52 %51
%53 = OpAccessChain %7 %47 %35
      OpStore %53 %12
%54 = OpAccessChain %7 %47 %38
      OpStore %54 %9
%55 = OpAccessChain %7 %47 %41
      OpStore %55 %51
%57 = OpAccessChain %7 %47 %56
      OpStore %57 %12
%60 = OpAccessChain %7 %47 %58
      OpStore %60 %59
%62 = OpAccessChain %7 %47 %61
      OpStore %62 %9
%64 = OpAccessChain %7 %47 %63
      OpStore %64 %59
%67 = OpAccessChain %7 %47 %65
      OpStore %67 %66
%69 = OpAccessChain %7 %47 %68
      OpStore %69 %9
%75 = OpAccessChain %74 %73 %22 %22
      OpStore %75 %tm
%76 = OpAccessChain %74 %73 %29 %22
      OpStore %76 %tm
%77 = OpAccessChain %74 %73 %32 %22
      OpStore %77 %bm
%78 = OpAccessChain %74 %73 %35 %22
      OpStore %78 %bm
      OpReturn
      OpFunctionEnd
#version 460
#extension GL_NV_mesh_shader : enable

#extension GL_EXT_fragment_shading_rate : enable

layout (location=0) out vec4 outColor;

void main ()
{
    const int expectedRate = ((gl_FragCoord.y < 4)? (gl_ShadingRateFlag2HorizontalPixelsEXT|gl_ShadingRateFlag2VerticalPixelsEXT) : (gl_ShadingRateFlag2HorizontalPixelsEXT|gl_ShadingRateFlag2VerticalPixelsEXT));
    outColor = ((gl_ShadingRateEXT == expectedRate) ? vec4(0.0, 0.0, 1.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0));
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 81
; Schema: 0
      OpCapability MeshShadingNV
      OpCapability FragmentShadingRateKHR
      OpExtension "SPV_NV_mesh_shader"
      OpExtension "SPV_KHR_fragment_shading_rate"
 %1 = OpExtInstImport "GLSL.std.450"
      OpMemoryModel Logical GLSL450
      OpEntryPoint MeshNV %4 "main" %8 %20 %47 %73
      OpExecutionMode %4 LocalSize 1 1 1
      OpExecutionMode %4 OutputVertices 6
      OpExecutionMode %4 OutputPrimitivesNV 4
      OpExecutionMode %4 OutputTrianglesNV
      OpDecorate %8 BuiltIn PrimitiveCountNV
      OpMemberDecorate %16 0 BuiltIn Position
      OpMemberDecorate %16 1 BuiltIn PointSize
      OpMemberDecorate %16 2 BuiltIn ClipDistance
      OpMemberDecorate %16 3 BuiltIn CullDistance
      OpMemberDecorate %16 4 PerViewNV
      OpMemberDecorate %16 4 BuiltIn PositionPerViewNV
      OpMemberDecorate %16 5 PerViewNV
      OpMemberDecorate %16 5 BuiltIn ClipDistancePerViewNV
      OpMemberDecorate %16 6 PerViewNV
      OpMemberDecorate %16 6 BuiltIn CullDistancePerViewNV
      OpDecorate %16 Block
      OpDecorate %47 BuiltIn PrimitiveIndicesNV
      OpMemberDecorate %70 0 PerPrimitiveNV
      OpMemberDecorate %70 0 BuiltIn PrimitiveShadingRateKHR
      OpDecorate %70 Block
      OpDecorate %80 BuiltIn WorkgroupSize
 %2 = OpTypeVoid
 %3 = OpTypeFunction %2
 %6 = OpTypeInt 32 0
 %7 = OpTypePointer Output %6
 %8 = OpVariable %7 Output
 %9 = OpConstant %6 4
%10 = OpTypeFloat 32
%11 = OpTypeVector %10 4
%12 = OpConstant %6 1
%13 = OpTypeArray %10 %12
%14 = OpTypeArray %11 %9
%15 = OpTypeArray %13 %9
%16 = OpTypeStruct %11 %10 %13 %13 %14 %15 %15
%17 = OpConstant %6 6
%18 = OpTypeArray %16 %17
%19 = OpTypePointer Output %18
%20 = OpVariable %19 Output
%21 = OpTypeInt 32 1
%tm = OpConstant %21 5
%bm = OpConstant %21 4
%22 = OpConstant %21 0
%23 = OpConstant %10 -1
%24 = OpConstant %10 0
%25 = OpConstant %10 1
%26 = OpConstantComposite %11 %23 %23 %24 %25
%27 = OpTypePointer Output %11
%29 = OpConstant %21 1
%30 = OpConstantComposite %11 %23 %24 %24 %25
%32 = OpConstant %21 2
%33 = OpConstantComposite %11 %23 %25 %24 %25
%35 = OpConstant %21 3
%36 = OpConstantComposite %11 %25 %23 %24 %25
%38 = OpConstant %21 4
%39 = OpConstantComposite %11 %25 %24 %24 %25
%41 = OpConstant %21 5
%42 = OpConstantComposite %11 %25 %25 %24 %25
%44 = OpConstant %6 12
%45 = OpTypeArray %6 %44
%46 = OpTypePointer Output %45
%47 = OpVariable %46 Output
%48 = OpConstant %6 0
%51 = OpConstant %6 3
%56 = OpConstant %21 6
%58 = OpConstant %21 7
%59 = OpConstant %6 2
%61 = OpConstant %21 8
%63 = OpConstant %21 9
%65 = OpConstant %21 10
%66 = OpConstant %6 5
%68 = OpConstant %21 11
%70 = OpTypeStruct %21
%71 = OpTypeArray %70 %9
%72 = OpTypePointer Output %71
%73 = OpVariable %72 Output
%74 = OpTypePointer Output %21
%79 = OpTypeVector %6 3
%80 = OpConstantComposite %79 %12 %12 %12
 %4 = OpFunction %2 None %3
 %5 = OpLabel
      OpStore %8 %9
%28 = OpAccessChain %27 %20 %22 %22
      OpStore %28 %26
%31 = OpAccessChain %27 %20 %29 %22
      OpStore %31 %30
%34 = OpAccessChain %27 %20 %32 %22
      OpStore %34 %33
%37 = OpAccessChain %27 %20 %35 %22
      OpStore %37 %36
%40 = OpAccessChain %27 %20 %38 %22
      OpStore %40 %39
%43 = OpAccessChain %27 %20 %41 %22
      OpStore %43 %42
%49 = OpAccessChain %7 %47 %22
      OpStore %49 %48
%50 = OpAccessChain %7 %47 %29
      OpStore %50 %12
%52 = OpAccessChain %7 %47 %32
      OpStore %52 %51
%53 = OpAccessChain %7 %47 %35
      OpStore %53 %12
%54 = OpAccessChain %7 %47 %38
      OpStore %54 %9
%55 = OpAccessChain %7 %47 %41
      OpStore %55 %51
%57 = OpAccessChain %7 %47 %56
      OpStore %57 %12
%60 = OpAccessChain %7 %47 %58
      OpStore %60 %59
%62 = OpAccessChain %7 %47 %61
      OpStore %62 %9
%64 = OpAccessChain %7 %47 %63
      OpStore %64 %59
%67 = OpAccessChain %7 %47 %65
      OpStore %67 %66
%69 = OpAccessChain %7 %47 %68
      OpStore %69 %9
%75 = OpAccessChain %74 %73 %22 %22
      OpStore %75 %tm
%76 = OpAccessChain %74 %73 %29 %22
      OpStore %76 %tm
%77 = OpAccessChain %74 %73 %32 %22
      OpStore %77 %bm
%78 = OpAccessChain %74 %73 %35 %22
      OpStore %78 %bm
      OpReturn
      OpFunctionEnd
#version 460
#extension GL_NV_mesh_shader : enable

#extension GL_EXT_fragment_shading_rate : enable

layout (location=0) out vec4 outColor;

void main ()
{
    const int expectedRate = ((gl_FragCoord.y < 4)? (gl_ShadingRateFlag2HorizontalPixelsEXT|gl_ShadingRateFlag2VerticalPixelsEXT) : gl_ShadingRateFlag2HorizontalPixelsEXT);
    outColor = ((gl_ShadingRateEXT == expectedRate) ? vec4(0.0, 0.0, 1.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0));
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 81
; Schema: 0
      OpCapability MeshShadingNV
      OpCapability FragmentShadingRateKHR
      OpExtension "SPV_NV_mesh_shader"
      OpExtension "SPV_KHR_fragment_shading_rate"
 %1 = OpExtInstImport "GLSL.std.450"
      OpMemoryModel Logical GLSL450
      OpEntryPoint MeshNV %4 "main" %8 %20 %47 %73
      OpExecutionMode %4 LocalSize 1 1 1
      OpExecutionMode %4 OutputVertices 6
      OpExecutionMode %4 OutputPrimitivesNV 4
      OpExecutionMode %4 OutputTrianglesNV
      OpDecorate %8 BuiltIn PrimitiveCountNV
      OpMemberDecorate %16 0 BuiltIn Position
      OpMemberDecorate %16 1 BuiltIn PointSize
      OpMemberDecorate %16 2 BuiltIn ClipDistance
      OpMemberDecorate %16 3 BuiltIn CullDistance
      OpMemberDecorate %16 4 PerViewNV
      OpMemberDecorate %16 4 BuiltIn PositionPerViewNV
      OpMemberDecorate %16 5 PerViewNV
      OpMemberDecorate %16 5 BuiltIn ClipDistancePerViewNV
      OpMemberDecorate %16 6 PerViewNV
      OpMemberDecorate %16 6 BuiltIn CullDistancePerViewNV
      OpDecorate %16 Block
      OpDecorate %47 BuiltIn PrimitiveIndicesNV
      OpMemberDecorate %70 0 PerPrimitiveNV
      OpMemberDecorate %70 0 BuiltIn PrimitiveShadingRateKHR
      OpDecorate %70 Block
      OpDecorate %80 BuiltIn WorkgroupSize
 %2 = OpTypeVoid
 %3 = OpTypeFunction %2
 %6 = OpTypeInt 32 0
 %7 = OpTypePointer Output %6
 %8 = OpVariable %7 Output
 %9 = OpConstant %6 4
%10 = OpTypeFloat 32
%11 = OpTypeVector %10 4
%12 = OpConstant %6 1
%13 = OpTypeArray %10 %12
%14 = OpTypeArray %11 %9
%15 = OpTypeArray %13 %9
%16 = OpTypeStruct %11 %10 %13 %13 %14 %15 %15
%17 = OpConstant %6 6
%18 = OpTypeArray %16 %17
%19 = OpTypePointer Output %18
%20 = OpVariable %19 Output
%21 = OpTypeInt 32 1
%tm = OpConstant %21 5
%bm = OpConstant %21 0
%22 = OpConstant %21 0
%23 = OpConstant %10 -1
%24 = OpConstant %10 0
%25 = OpConstant %10 1
%26 = OpConstantComposite %11 %23 %23 %24 %25
%27 = OpTypePointer Output %11
%29 = OpConstant %21 1
%30 = OpConstantComposite %11 %23 %24 %24 %25
%32 = OpConstant %21 2
%33 = OpConstantComposite %11 %23 %25 %24 %25
%35 = OpConstant %21 3
%36 = OpConstantComposite %11 %25 %23 %24 %25
%38 = OpConstant %21 4
%39 = OpConstantComposite %11 %25 %24 %24 %25
%41 = OpConstant %21 5
%42 = OpConstantComposite %11 %25 %25 %24 %25
%44 = OpConstant %6 12
%45 = OpTypeArray %6 %44
%46 = OpTypePointer Output %45
%47 = OpVariable %46 Output
%48 = OpConstant %6 0
%51 = OpConstant %6 3
%56 = OpConstant %21 6
%58 = OpConstant %21 7
%59 = OpConstant %6 2
%61 = OpConstant %21 8
%63 = OpConstant %21 9
%65 = OpConstant %21 10
%66 = OpConstant %6 5
%68 = OpConstant %21 11
%70 = OpTypeStruct %21
%71 = OpTypeArray %70 %9
%72 = OpTypePointer Output %71
%73 = OpVariable %72 Output
%74 = OpTypePointer Output %21
%79 = OpTypeVector %6 3
%80 = OpConstantComposite %79 %12 %12 %12
 %4 = OpFunction %2 None %3
 %5 = OpLabel
      OpStore %8 %9
%28 = OpAccessChain %27 %20 %22 %22
      OpStore %28 %26
%31 = OpAccessChain %27 %20 %29 %22
      OpStore %31 %30
%34 = OpAccessChain %27 %20 %32 %22
      OpStore %34 %33
%37 = OpAccessChain %27 %20 %35 %22
      OpStore %37 %36
%40 = OpAccessChain %27 %20 %38 %22
      OpStore %40 %39
%43 = OpAccessChain %27 %20 %41 %22
      OpStore %43 %42
%49 = OpAccessChain %7 %47 %22
      OpStore %49 %48
%50 = OpAccessChain %7 %47 %29
      OpStore %50 %12
%52 = OpAccessChain %7 %47 %32
      OpStore %52 %51
%53 = OpAccessChain %7 %47 %35
      OpStore %53 %12
%54 = OpAccessChain %7 %47 %38
      OpStore %54 %9
%55 = OpAccessChain %7 %47 %41
      OpStore %55 %51
%57 = OpAccessChain %7 %47 %56
      OpStore %57 %12
%60 = OpAccessChain %7 %47 %58
      OpStore %60 %59
%62 = OpAccessChain %7 %47 %61
      OpStore %62 %9
%64 = OpAccessChain %7 %47 %63
      OpStore %64 %59
%67 = OpAccessChain %7 %47 %65
      OpStore %67 %66
%69 = OpAccessChain %7 %47 %68
      OpStore %69 %9
%75 = OpAccessChain %74 %73 %22 %22
      OpStore %75 %tm
%76 = OpAccessChain %74 %73 %29 %22
      OpStore %76 %tm
%77 = OpAccessChain %74 %73 %32 %22
      OpStore %77 %bm
%78 = OpAccessChain %74 %73 %35 %22
      OpStore %78 %bm
      OpReturn
      OpFunctionEnd
#version 460
#extension GL_NV_mesh_shader : enable

#extension GL_EXT_fragment_shading_rate : enable

layout (location=0) out vec4 outColor;

void main ()
{
    const int expectedRate = ((gl_FragCoord.y < 4)? (gl_ShadingRateFlag2HorizontalPixelsEXT|gl_ShadingRateFlag2VerticalPixelsEXT) : 0);
    outColor = ((gl_ShadingRateEXT == expectedRate) ? vec4(0.0, 0.0, 1.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0));
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 81
; Schema: 0
      OpCapability MeshShadingNV
      OpCapability FragmentShadingRateKHR
      OpExtension "SPV_NV_mesh_shader"
      OpExtension "SPV_KHR_fragment_shading_rate"
 %1 = OpExtInstImport "GLSL.std.450"
      OpMemoryModel Logical GLSL450
      OpEntryPoint MeshNV %4 "main" %8 %20 %47 %73
      OpExecutionMode %4 LocalSize 1 1 1
      OpExecutionMode %4 OutputVertices 6
      OpExecutionMode %4 OutputPrimitivesNV 4
      OpExecutionMode %4 OutputTrianglesNV
      OpDecorate %8 BuiltIn PrimitiveCountNV
      OpMemberDecorate %16 0 BuiltIn Position
      OpMemberDecorate %16 1 BuiltIn PointSize
      OpMemberDecorate %16 2 BuiltIn ClipDistance
      OpMemberDecorate %16 3 BuiltIn CullDistance
      OpMemberDecorate %16 4 PerViewNV
      OpMemberDecorate %16 4 BuiltIn PositionPerViewNV
      OpMemberDecorate %16 5 PerViewNV
      OpMemberDecorate %16 5 BuiltIn ClipDistancePerViewNV
      OpMemberDecorate %16 6 PerViewNV
      OpMemberDecorate %16 6 BuiltIn CullDistancePerViewNV
      OpDecorate %16 Block
      OpDecorate %47 BuiltIn PrimitiveIndicesNV
      OpMemberDecorate %70 0 PerPrimitiveNV
      OpMemberDecorate %70 0 BuiltIn PrimitiveShadingRateKHR
      OpDecorate %70 Block
      OpDecorate %80 BuiltIn WorkgroupSize
 %2 = OpTypeVoid
 %3 = OpTypeFunction %2
 %6 = OpTypeInt 32 0
 %7 = OpTypePointer Output %6
 %8 = OpVariable %7 Output
 %9 = OpConstant %6 4
%10 = OpTypeFloat 32
%11 = OpTypeVector %10 4
%12 = OpConstant %6 1
%13 = OpTypeArray %10 %12
%14 = OpTypeArray %11 %9
%15 = OpTypeArray %13 %9
%16 = OpTypeStruct %11 %10 %13 %13 %14 %15 %15
%17 = OpConstant %6 6
%18 = OpTypeArray %16 %17
%19 = OpTypePointer Output %18
%20 = OpVariable %19 Output
%21 = OpTypeInt 32 1
%tm = OpConstant %21 4
%bm = OpConstant %21 5
%22 = OpConstant %21 0
%23 = OpConstant %10 -1
%24 = OpConstant %10 0
%25 = OpConstant %10 1
%26 = OpConstantComposite %11 %23 %23 %24 %25
%27 = OpTypePointer Output %11
%29 = OpConstant %21 1
%30 = OpConstantComposite %11 %23 %24 %24 %25
%32 = OpConstant %21 2
%33 = OpConstantComposite %11 %23 %25 %24 %25
%35 = OpConstant %21 3
%36 = OpConstantComposite %11 %25 %23 %24 %25
%38 = OpConstant %21 4
%39 = OpConstantComposite %11 %25 %24 %24 %25
%41 = OpConstant %21 5
%42 = OpConstantComposite %11 %25 %25 %24 %25
%44 = OpConstant %6 12
%45 = OpTypeArray %6 %44
%46 = OpTypePointer Output %45
%47 = OpVariable %46 Output
%48 = OpConstant %6 0
%51 = OpConstant %6 3
%56 = OpConstant %21 6
%58 = OpConstant %21 7
%59 = OpConstant %6 2
%61 = OpConstant %21 8
%63 = OpConstant %21 9
%65 = OpConstant %21 10
%66 = OpConstant %6 5
%68 = OpConstant %21 11
%70 = OpTypeStruct %21
%71 = OpTypeArray %70 %9
%72 = OpTypePointer Output %71
%73 = OpVariable %72 Output
%74 = OpTypePointer Output %21
%79 = OpTypeVector %6 3
%80 = OpConstantComposite %79 %12 %12 %12
 %4 = OpFunction %2 None %3
 %5 = OpLabel
      OpStore %8 %9
%28 = OpAccessChain %27 %20 %22 %22
      OpStore %28 %26
%31 = OpAccessChain %27 %20 %29 %22
      OpStore %31 %30
%34 = OpAccessChain %27 %20 %32 %22
      OpStore %34 %33
%37 = OpAccessChain %27 %20 %35 %22
      OpStore %37 %36
%40 = OpAccessChain %27 %20 %38 %22
      OpStore %40 %39
%43 = OpAccessChain %27 %20 %41 %22
      OpStore %43 %42
%49 = OpAccessChain %7 %47 %22
      OpStore %49 %48
%50 = OpAccessChain %7 %47 %29
      OpStore %50 %12
%52 = OpAccessChain %7 %47 %32
      OpStore %52 %51
%53 = OpAccessChain %7 %47 %35
      OpStore %53 %12
%54 = OpAccessChain %7 %47 %38
      OpStore %54 %9
%55 = OpAccessChain %7 %47 %41
      OpStore %55 %51
%57 = OpAccessChain %7 %47 %56
      OpStore %57 %12
%60 = OpAccessChain %7 %47 %58
      OpStore %60 %59
%62 = OpAccessChain %7 %47 %61
      OpStore %62 %9
%64 = OpAccessChain %7 %47 %63
      OpStore %64 %59
%67 = OpAccessChain %7 %47 %65
      OpStore %67 %66
%69 = OpAccessChain %7 %47 %68
      OpStore %69 %9
%75 = OpAccessChain %74 %73 %22 %22
      OpStore %75 %tm
%76 = OpAccessChain %74 %73 %29 %22
      OpStore %76 %tm
%77 = OpAccessChain %74 %73 %32 %22
      OpStore %77 %bm
%78 = OpAccessChain %74 %73 %35 %22
      OpStore %78 %bm
      OpReturn
      OpFunctionEnd
#version 460
#extension GL_NV_mesh_shader : enable

#extension GL_EXT_fragment_shading_rate : enable

layout (location=0) out vec4 outColor;

void main ()
{
    const int expectedRate = ((gl_FragCoord.y < 4)? gl_ShadingRateFlag2HorizontalPixelsEXT : (gl_ShadingRateFlag2HorizontalPixelsEXT|gl_ShadingRateFlag2VerticalPixelsEXT));
    outColor = ((gl_ShadingRateEXT == expectedRate) ? vec4(0.0, 0.0, 1.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0));
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 81
; Schema: 0
      OpCapability MeshShadingNV
      OpCapability FragmentShadingRateKHR
      OpExtension "SPV_NV_mesh_shader"
      OpExtension "SPV_KHR_fragment_shading_rate"
 %1 = OpExtInstImport "GLSL.std.450"
      OpMemoryModel Logical GLSL450
      OpEntryPoint MeshNV %4 "main" %8 %20 %47 %73
      OpExecutionMode %4 LocalSize 1 1 1
      OpExecutionMode %4 OutputVertices 6
      OpExecutionMode %4 OutputPrimitivesNV 4
      OpExecutionMode %4 OutputTrianglesNV
      OpDecorate %8 BuiltIn PrimitiveCountNV
      OpMemberDecorate %16 0 BuiltIn Position
      OpMemberDecorate %16 1 BuiltIn PointSize
      OpMemberDecorate %16 2 BuiltIn ClipDistance
      OpMemberDecorate %16 3 BuiltIn CullDistance
      OpMemberDecorate %16 4 PerViewNV
      OpMemberDecorate %16 4 BuiltIn PositionPerViewNV
      OpMemberDecorate %16 5 PerViewNV
      OpMemberDecorate %16 5 BuiltIn ClipDistancePerViewNV
      OpMemberDecorate %16 6 PerViewNV
      OpMemberDecorate %16 6 BuiltIn CullDistancePerViewNV
      OpDecorate %16 Block
      OpDecorate %47 BuiltIn PrimitiveIndicesNV
      OpMemberDecorate %70 0 PerPrimitiveNV
      OpMemberDecorate %70 0 BuiltIn PrimitiveShadingRateKHR
      OpDecorate %70 Block
      OpDecorate %80 BuiltIn WorkgroupSize
 %2 = OpTypeVoid
 %3 = OpTypeFunction %2
 %6 = OpTypeInt 32 0
 %7 = OpTypePointer Output %6
 %8 = OpVariable %7 Output
 %9 = OpConstant %6 4
%10 = OpTypeFloat 32
%11 = OpTypeVector %10 4
%12 = OpConstant %6 1
%13 = OpTypeArray %10 %12
%14 = OpTypeArray %11 %9
%15 = OpTypeArray %13 %9
%16 = OpTypeStruct %11 %10 %13 %13 %14 %15 %15
%17 = OpConstant %6 6
%18 = OpTypeArray %16 %17
%19 = OpTypePointer Output %18
%20 = OpVariable %19 Output
%21 = OpTypeInt 32 1
%tm = OpConstant %21 4
%bm = OpConstant %21 4
%22 = OpConstant %21 0
%23 = OpConstant %10 -1
%24 = OpConstant %10 0
%25 = OpConstant %10 1
%26 = OpConstantComposite %11 %23 %23 %24 %25
%27 = OpTypePointer Output %11
%29 = OpConstant %21 1
%30 = OpConstantComposite %11 %23 %24 %24 %25
%32 = OpConstant %21 2
%33 = OpConstantComposite %11 %23 %25 %24 %25
%35 = OpConstant %21 3
%36 = OpConstantComposite %11 %25 %23 %24 %25
%38 = OpConstant %21 4
%39 = OpConstantComposite %11 %25 %24 %24 %25
%41 = OpConstant %21 5
%42 = OpConstantComposite %11 %25 %25 %24 %25
%44 = OpConstant %6 12
%45 = OpTypeArray %6 %44
%46 = OpTypePointer Output %45
%47 = OpVariable %46 Output
%48 = OpConstant %6 0
%51 = OpConstant %6 3
%56 = OpConstant %21 6
%58 = OpConstant %21 7
%59 = OpConstant %6 2
%61 = OpConstant %21 8
%63 = OpConstant %21 9
%65 = OpConstant %21 10
%66 = OpConstant %6 5
%68 = OpConstant %21 11
%70 = OpTypeStruct %21
%71 = OpTypeArray %70 %9
%72 = OpTypePointer Output %71
%73 = OpVariable %72 Output
%74 = OpTypePointer Output %21
%79 = OpTypeVector %6 3
%80 = OpConstantComposite %79 %12 %12 %12
 %4 = OpFunction %2 None %3
 %5 = OpLabel
      OpStore %8 %9
%28 = OpAccessChain %27 %20 %22 %22
      OpStore %28 %26
%31 = OpAccessChain %27 %20 %29 %22
      OpStore %31 %30
%34 = OpAccessChain %27 %20 %32 %22
      OpStore %34 %33
%37 = OpAccessChain %27 %20 %35 %22
      OpStore %37 %36
%40 = OpAccessChain %27 %20 %38 %22
      OpStore %40 %39
%43 = OpAccessChain %27 %20 %41 %22
      OpStore %43 %42
%49 = OpAccessChain %7 %47 %22
      OpStore %49 %48
%50 = OpAccessChain %7 %47 %29
      OpStore %50 %12
%52 = OpAccessChain %7 %47 %32
      OpStore %52 %51
%53 = OpAccessChain %7 %47 %35
      OpStore %53 %12
%54 = OpAccessChain %7 %47 %38
      OpStore %54 %9
%55 = OpAccessChain %7 %47 %41
      OpStore %55 %51
%57 = OpAccessChain %7 %47 %56
      OpStore %57 %12
%60 = OpAccessChain %7 %47 %58
      OpStore %60 %59
%62 = OpAccessChain %7 %47 %61
      OpStore %62 %9
%64 = OpAccessChain %7 %47 %63
      OpStore %64 %59
%67 = OpAccessChain %7 %47 %65
      OpStore %67 %66
%69 = OpAccessChain %7 %47 %68
      OpStore %69 %9
%75 = OpAccessChain %74 %73 %22 %22
      OpStore %75 %tm
%76 = OpAccessChain %74 %73 %29 %22
      OpStore %76 %tm
%77 = OpAccessChain %74 %73 %32 %22
      OpStore %77 %bm
%78 = OpAccessChain %74 %73 %35 %22
      OpStore %78 %bm
      OpReturn
      OpFunctionEnd
#version 460
#extension GL_NV_mesh_shader : enable

#extension GL_EXT_fragment_shading_rate : enable

layout (location=0) out vec4 outColor;

void main ()
{
    const int expectedRate = ((gl_FragCoord.y < 4)? gl_ShadingRateFlag2HorizontalPixelsEXT : gl_ShadingRateFlag2HorizontalPixelsEXT);
    outColor = ((gl_ShadingRateEXT == expectedRate) ? vec4(0.0, 0.0, 1.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0));
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 81
; Schema: 0
      OpCapability MeshShadingNV
      OpCapability FragmentShadingRateKHR
      OpExtension "SPV_NV_mesh_shader"
      OpExtension "SPV_KHR_fragment_shading_rate"
 %1 = OpExtInstImport "GLSL.std.450"
      OpMemoryModel Logical GLSL450
      OpEntryPoint MeshNV %4 "main" %8 %20 %47 %73
      OpExecutionMode %4 LocalSize 1 1 1
      OpExecutionMode %4 OutputVertices 6
      OpExecutionMode %4 OutputPrimitivesNV 4
      OpExecutionMode %4 OutputTrianglesNV
      OpDecorate %8 BuiltIn PrimitiveCountNV
      OpMemberDecorate %16 0 BuiltIn Position
      OpMemberDecorate %16 1 BuiltIn PointSize
      OpMemberDecorate %16 2 BuiltIn ClipDistance
      OpMemberDecorate %16 3 BuiltIn CullDistance
      OpMemberDecorate %16 4 PerViewNV
      OpMemberDecorate %16 4 BuiltIn PositionPerViewNV
      OpMemberDecorate %16 5 PerViewNV
      OpMemberDecorate %16 5 BuiltIn ClipDistancePerViewNV
      OpMemberDecorate %16 6 PerViewNV
      OpMemberDecorate %16 6 BuiltIn CullDistancePerViewNV
      OpDecorate %16 Block
      OpDecorate %47 BuiltIn PrimitiveIndicesNV
      OpMemberDecorate %70 0 PerPrimitiveNV
      OpMemberDecorate %70 0 BuiltIn PrimitiveShadingRateKHR
      OpDecorate %70 Block
      OpDecorate %80 BuiltIn WorkgroupSize
 %2 = OpTypeVoid
 %3 = OpTypeFunction %2
 %6 = OpTypeInt 32 0
 %7 = OpTypePointer Output %6
 %8 = OpVariable %7 Output
 %9 = OpConstant %6 4
%10 = OpTypeFloat 32
%11 = OpTypeVector %10 4
%12 = OpConstant %6 1
%13 = OpTypeArray %10 %12
%14 = OpTypeArray %11 %9
%15 = OpTypeArray %13 %9
%16 = OpTypeStruct %11 %10 %13 %13 %14 %15 %15
%17 = OpConstant %6 6
%18 = OpTypeArray %16 %17
%19 = OpTypePointer Output %18
%20 = OpVariable %19 Output
%21 = OpTypeInt 32 1
%tm = OpConstant %21 4
%bm = OpConstant %21 0
%22 = OpConstant %21 0
%23 = OpConstant %10 -1
%24 = OpConstant %10 0
%25 = OpConstant %10 1
%26 = OpConstantComposite %11 %23 %23 %24 %25
%27 = OpTypePointer Output %11
%29 = OpConstant %21 1
%30 = OpConstantComposite %11 %23 %24 %24 %25
%32 = OpConstant %21 2
%33 = OpConstantComposite %11 %23 %25 %24 %25
%35 = OpConstant %21 3
%36 = OpConstantComposite %11 %25 %23 %24 %25
%38 = OpConstant %21 4
%39 = OpConstantComposite %11 %25 %24 %24 %25
%41 = OpConstant %21 5
%42 = OpConstantComposite %11 %25 %25 %24 %25
%44 = OpConstant %6 12
%45 = OpTypeArray %6 %44
%46 = OpTypePointer Output %45
%47 = OpVariable %46 Output
%48 = OpConstant %6 0
%51 = OpConstant %6 3
%56 = OpConstant %21 6
%58 = OpConstant %21 7
%59 = OpConstant %6 2
%61 = OpConstant %21 8
%63 = OpConstant %21 9
%65 = OpConstant %21 10
%66 = OpConstant %6 5
%68 = OpConstant %21 11
%70 = OpTypeStruct %21
%71 = OpTypeArray %70 %9
%72 = OpTypePointer Output %71
%73 = OpVariable %72 Output
%74 = OpTypePointer Output %21
%79 = OpTypeVector %6 3
%80 = OpConstantComposite %79 %12 %12 %12
 %4 = OpFunction %2 None %3
 %5 = OpLabel
      OpStore %8 %9
%28 = OpAccessChain %27 %20 %22 %22
      OpStore %28 %26
%31 = OpAccessChain %27 %20 %29 %22
      OpStore %31 %30
%34 = OpAccessChain %27 %20 %32 %22
      OpStore %34 %33
%37 = OpAccessChain %27 %20 %35 %22
      OpStore %37 %36
%40 = OpAccessChain %27 %20 %38 %22
      OpStore %40 %39
%43 = OpAccessChain %27 %20 %41 %22
      OpStore %43 %42
%49 = OpAccessChain %7 %47 %22
      OpStore %49 %48
%50 = OpAccessChain %7 %47 %29
      OpStore %50 %12
%52 = OpAccessChain %7 %47 %32
      OpStore %52 %51
%53 = OpAccessChain %7 %47 %35
      OpStore %53 %12
%54 = OpAccessChain %7 %47 %38
      OpStore %54 %9
%55 = OpAccessChain %7 %47 %41
      OpStore %55 %51
%57 = OpAccessChain %7 %47 %56
      OpStore %57 %12
%60 = OpAccessChain %7 %47 %58
      OpStore %60 %59
%62 = OpAccessChain %7 %47 %61
      OpStore %62 %9
%64 = OpAccessChain %7 %47 %63
      OpStore %64 %59
%67 = OpAccessChain %7 %47 %65
      OpStore %67 %66
%69 = OpAccessChain %7 %47 %68
      OpStore %69 %9
%75 = OpAccessChain %74 %73 %22 %22
      OpStore %75 %tm
%76 = OpAccessChain %74 %73 %29 %22
      OpStore %76 %tm
%77 = OpAccessChain %74 %73 %32 %22
      OpStore %77 %bm
%78 = OpAccessChain %74 %73 %35 %22
      OpStore %78 %bm
      OpReturn
      OpFunctionEnd
#version 460
#extension GL_NV_mesh_shader : enable

#extension GL_EXT_fragment_shading_rate : enable

layout (location=0) out vec4 outColor;

void main ()
{
    const int expectedRate = ((gl_FragCoord.y < 4)? gl_ShadingRateFlag2HorizontalPixelsEXT : 0);
    outColor = ((gl_ShadingRateEXT == expectedRate) ? vec4(0.0, 0.0, 1.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0));
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 81
; Schema: 0
      OpCapability MeshShadingNV
      OpCapability FragmentShadingRateKHR
      OpExtension "SPV_NV_mesh_shader"
      OpExtension "SPV_KHR_fragment_shading_rate"
 %1 = OpExtInstImport "GLSL.std.450"
      OpMemoryModel Logical GLSL450
      OpEntryPoint MeshNV %4 "main" %8 %20 %47 %73
      OpExecutionMode %4 LocalSize 1 1 1
      OpExecutionMode %4 OutputVertices 6
      OpExecutionMode %4 OutputPrimitivesNV 4
      OpExecutionMode %4 OutputTrianglesNV
      OpDecorate %8 BuiltIn PrimitiveCountNV
      OpMemberDecorate %16 0 BuiltIn Position
      OpMemberDecorate %16 1 BuiltIn PointSize
      OpMemberDecorate %16 2 BuiltIn ClipDistance
      OpMemberDecorate %16 3 BuiltIn CullDistance
      OpMemberDecorate %16 4 PerViewNV
      OpMemberDecorate %16 4 BuiltIn PositionPerViewNV
      OpMemberDecorate %16 5 PerViewNV
      OpMemberDecorate %16 5 BuiltIn ClipDistancePerViewNV
      OpMemberDecorate %16 6 PerViewNV
      OpMemberDecorate %16 6 BuiltIn CullDistancePerViewNV
      OpDecorate %16 Block
      OpDecorate %47 BuiltIn PrimitiveIndicesNV
      OpMemberDecorate %70 0 PerPrimitiveNV
      OpMemberDecorate %70 0 BuiltIn PrimitiveShadingRateKHR
      OpDecorate %70 Block
      OpDecorate %80 BuiltIn WorkgroupSize
 %2 = OpTypeVoid
 %3 = OpTypeFunction %2
 %6 = OpTypeInt 32 0
 %7 = OpTypePointer Output %6
 %8 = OpVariable %7 Output
 %9 = OpConstant %6 4
%10 = OpTypeFloat 32
%11 = OpTypeVector %10 4
%12 = OpConstant %6 1
%13 = OpTypeArray %10 %12
%14 = OpTypeArray %11 %9
%15 = OpTypeArray %13 %9
%16 = OpTypeStruct %11 %10 %13 %13 %14 %15 %15
%17 = OpConstant %6 6
%18 = OpTypeArray %16 %17
%19 = OpTypePointer Output %18
%20 = OpVariable %19 Output
%21 = OpTypeInt 32 1
%tm = OpConstant %21 0
%bm = OpConstant %21 5
%22 = OpConstant %21 0
%23 = OpConstant %10 -1
%24 = OpConstant %10 0
%25 = OpConstant %10 1
%26 = OpConstantComposite %11 %23 %23 %24 %25
%27 = OpTypePointer Output %11
%29 = OpConstant %21 1
%30 = OpConstantComposite %11 %23 %24 %24 %25
%32 = OpConstant %21 2
%33 = OpConstantComposite %11 %23 %25 %24 %25
%35 = OpConstant %21 3
%36 = OpConstantComposite %11 %25 %23 %24 %25
%38 = OpConstant %21 4
%39 = OpConstantComposite %11 %25 %24 %24 %25
%41 = OpConstant %21 5
%42 = OpConstantComposite %11 %25 %25 %24 %25
%44 = OpConstant %6 12
%45 = OpTypeArray %6 %44
%46 = OpTypePointer Output %45
%47 = OpVariable %46 Output
%48 = OpConstant %6 0
%51 = OpConstant %6 3
%56 = OpConstant %21 6
%58 = OpConstant %21 7
%59 = OpConstant %6 2
%61 = OpConstant %21 8
%63 = OpConstant %21 9
%65 = OpConstant %21 10
%66 = OpConstant %6 5
%68 = OpConstant %21 11
%70 = OpTypeStruct %21
%71 = OpTypeArray %70 %9
%72 = OpTypePointer Output %71
%73 = OpVariable %72 Output
%74 = OpTypePointer Output %21
%79 = OpTypeVector %6 3
%80 = OpConstantComposite %79 %12 %12 %12
 %4 = OpFunction %2 None %3
 %5 = OpLabel
      OpStore %8 %9
%28 = OpAccessChain %27 %20 %22 %22
      OpStore %28 %26
%31 = OpAccessChain %27 %20 %29 %22
      OpStore %31 %30
%34 = OpAccessChain %27 %20 %32 %22
      OpStore %34 %33
%37 = OpAccessChain %27 %20 %35 %22
      OpStore %37 %36
%40 = OpAccessChain %27 %20 %38 %22
      OpStore %40 %39
%43 = OpAccessChain %27 %20 %41 %22
      OpStore %43 %42
%49 = OpAccessChain %7 %47 %22
      OpStore %49 %48
%50 = OpAccessChain %7 %47 %29
      OpStore %50 %12
%52 = OpAccessChain %7 %47 %32
      OpStore %52 %51
%53 = OpAccessChain %7 %47 %35
      OpStore %53 %12
%54 = OpAccessChain %7 %47 %38
      OpStore %54 %9
%55 = OpAccessChain %7 %47 %41
      OpStore %55 %51
%57 = OpAccessChain %7 %47 %56
      OpStore %57 %12
%60 = OpAccessChain %7 %47 %58
      OpStore %60 %59
%62 = OpAccessChain %7 %47 %61
      OpStore %62 %9
%64 = OpAccessChain %7 %47 %63
      OpStore %64 %59
%67 = OpAccessChain %7 %47 %65
      OpStore %67 %66
%69 = OpAccessChain %7 %47 %68
      OpStore %69 %9
%75 = OpAccessChain %74 %73 %22 %22
      OpStore %75 %tm
%76 = OpAccessChain %74 %73 %29 %22
      OpStore %76 %tm
%77 = OpAccessChain %74 %73 %32 %22
      OpStore %77 %bm
%78 = OpAccessChain %74 %73 %35 %22
      OpStore %78 %bm
      OpReturn
      OpFunctionEnd
#version 460
#extension GL_NV_mesh_shader : enable

#extension GL_EXT_fragment_shading_rate : enable

layout (location=0) out vec4 outColor;

void main ()
{
    const int expectedRate = ((gl_FragCoord.y < 4)? 0 : (gl_ShadingRateFlag2HorizontalPixelsEXT|gl_ShadingRateFlag2VerticalPixelsEXT));
    outColor = ((gl_ShadingRateEXT == expectedRate) ? vec4(0.0, 0.0, 1.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0));
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 81
; Schema: 0
      OpCapability MeshShadingNV
      OpCapability FragmentShadingRateKHR
      OpExtension "SPV_NV_mesh_shader"
      OpExtension "SPV_KHR_fragment_shading_rate"
 %1 = OpExtInstImport "GLSL.std.450"
      OpMemoryModel Logical GLSL450
      OpEntryPoint MeshNV %4 "main" %8 %20 %47 %73
      OpExecutionMode %4 LocalSize 1 1 1
      OpExecutionMode %4 OutputVertices 6
      OpExecutionMode %4 OutputPrimitivesNV 4
      OpExecutionMode %4 OutputTrianglesNV
      OpDecorate %8 BuiltIn PrimitiveCountNV
      OpMemberDecorate %16 0 BuiltIn Position
      OpMemberDecorate %16 1 BuiltIn PointSize
      OpMemberDecorate %16 2 BuiltIn ClipDistance
      OpMemberDecorate %16 3 BuiltIn CullDistance
      OpMemberDecorate %16 4 PerViewNV
      OpMemberDecorate %16 4 BuiltIn PositionPerViewNV
      OpMemberDecorate %16 5 PerViewNV
      OpMemberDecorate %16 5 BuiltIn ClipDistancePerViewNV
      OpMemberDecorate %16 6 PerViewNV
      OpMemberDecorate %16 6 BuiltIn CullDistancePerViewNV
      OpDecorate %16 Block
      OpDecorate %47 BuiltIn PrimitiveIndicesNV
      OpMemberDecorate %70 0 PerPrimitiveNV
      OpMemberDecorate %70 0 BuiltIn PrimitiveShadingRateKHR
      OpDecorate %70 Block
      OpDecorate %80 BuiltIn WorkgroupSize
 %2 = OpTypeVoid
 %3 = OpTypeFunction %2
 %6 = OpTypeInt 32 0
 %7 = OpTypePointer Output %6
 %8 = OpVariable %7 Output
 %9 = OpConstant %6 4
%10 = OpTypeFloat 32
%11 = OpTypeVector %10 4
%12 = OpConstant %6 1
%13 = OpTypeArray %10 %12
%14 = OpTypeArray %11 %9
%15 = OpTypeArray %13 %9
%16 = OpTypeStruct %11 %10 %13 %13 %14 %15 %15
%17 = OpConstant %6 6
%18 = OpTypeArray %16 %17
%19 = OpTypePointer Output %18
%20 = OpVariable %19 Output
%21 = OpTypeInt 32 1
%tm = OpConstant %21 0
%bm = OpConstant %21 4
%22 = OpConstant %21 0
%23 = OpConstant %10 -1
%24 = OpConstant %10 0
%25 = OpConstant %10 1
%26 = OpConstantComposite %11 %23 %23 %24 %25
%27 = OpTypePointer Output %11
%29 = OpConstant %21 1
%30 = OpConstantComposite %11 %23 %24 %24 %25
%32 = OpConstant %21 2
%33 = OpConstantComposite %11 %23 %25 %24 %25
%35 = OpConstant %21 3
%36 = OpConstantComposite %11 %25 %23 %24 %25
%38 = OpConstant %21 4
%39 = OpConstantComposite %11 %25 %24 %24 %25
%41 = OpConstant %21 5
%42 = OpConstantComposite %11 %25 %25 %24 %25
%44 = OpConstant %6 12
%45 = OpTypeArray %6 %44
%46 = OpTypePointer Output %45
%47 = OpVariable %46 Output
%48 = OpConstant %6 0
%51 = OpConstant %6 3
%56 = OpConstant %21 6
%58 = OpConstant %21 7
%59 = OpConstant %6 2
%61 = OpConstant %21 8
%63 = OpConstant %21 9
%65 = OpConstant %21 10
%66 = OpConstant %6 5
%68 = OpConstant %21 11
%70 = OpTypeStruct %21
%71 = OpTypeArray %70 %9
%72 = OpTypePointer Output %71
%73 = OpVariable %72 Output
%74 = OpTypePointer Output %21
%79 = OpTypeVector %6 3
%80 = OpConstantComposite %79 %12 %12 %12
 %4 = OpFunction %2 None %3
 %5 = OpLabel
      OpStore %8 %9
%28 = OpAccessChain %27 %20 %22 %22
      OpStore %28 %26
%31 = OpAccessChain %27 %20 %29 %22
      OpStore %31 %30
%34 = OpAccessChain %27 %20 %32 %22
      OpStore %34 %33
%37 = OpAccessChain %27 %20 %35 %22
      OpStore %37 %36
%40 = OpAccessChain %27 %20 %38 %22
      OpStore %40 %39
%43 = OpAccessChain %27 %20 %41 %22
      OpStore %43 %42
%49 = OpAccessChain %7 %47 %22
      OpStore %49 %48
%50 = OpAccessChain %7 %47 %29
      OpStore %50 %12
%52 = OpAccessChain %7 %47 %32
      OpStore %52 %51
%53 = OpAccessChain %7 %47 %35
      OpStore %53 %12
%54 = OpAccessChain %7 %47 %38
      OpStore %54 %9
%55 = OpAccessChain %7 %47 %41
      OpStore %55 %51
%57 = OpAccessChain %7 %47 %56
      OpStore %57 %12
%60 = OpAccessChain %7 %47 %58
      OpStore %60 %59
%62 = OpAccessChain %7 %47 %61
      OpStore %62 %9
%64 = OpAccessChain %7 %47 %63
      OpStore %64 %59
%67 = OpAccessChain %7 %47 %65
      OpStore %67 %66
%69 = OpAccessChain %7 %47 %68
      OpStore %69 %9
%75 = OpAccessChain %74 %73 %22 %22
      OpStore %75 %tm
%76 = OpAccessChain %74 %73 %29 %22
      OpStore %76 %tm
%77 = OpAccessChain %74 %73 %32 %22
      OpStore %77 %bm
%78 = OpAccessChain %74 %73 %35 %22
      OpStore %78 %bm
      OpReturn
      OpFunctionEnd
#version 460
#extension GL_NV_mesh_shader : enable

#extension GL_EXT_fragment_shading_rate : enable

layout (location=0) out vec4 outColor;

void main ()
{
    const int expectedRate = ((gl_FragCoord.y < 4)? 0 : gl_ShadingRateFlag2HorizontalPixelsEXT);
    outColor = ((gl_ShadingRateEXT == expectedRate) ? vec4(0.0, 0.0, 1.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0));
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 81
; Schema: 0
      OpCapability MeshShadingNV
      OpCapability FragmentShadingRateKHR
      OpExtension "SPV_NV_mesh_shader"
      OpExtension "SPV_KHR_fragment_shading_rate"
 %1 = OpExtInstImport "GLSL.std.450"
      OpMemoryModel Logical GLSL450
      OpEntryPoint MeshNV %4 "main" %8 %20 %47 %73
      OpExecutionMode %4 LocalSize 1 1 1
      OpExecutionMode %4 OutputVertices 6
      OpExecutionMode %4 OutputPrimitivesNV 4
      OpExecutionMode %4 OutputTrianglesNV
      OpDecorate %8 BuiltIn PrimitiveCountNV
      OpMemberDecorate %16 0 BuiltIn Position
      OpMemberDecorate %16 1 BuiltIn PointSize
      OpMemberDecorate %16 2 BuiltIn ClipDistance
      OpMemberDecorate %16 3 BuiltIn CullDistance
      OpMemberDecorate %16 4 PerViewNV
      OpMemberDecorate %16 4 BuiltIn PositionPerViewNV
      OpMemberDecorate %16 5 PerViewNV
      OpMemberDecorate %16 5 BuiltIn ClipDistancePerViewNV
      OpMemberDecorate %16 6 PerViewNV
      OpMemberDecorate %16 6 BuiltIn CullDistancePerViewNV
      OpDecorate %16 Block
      OpDecorate %47 BuiltIn PrimitiveIndicesNV
      OpMemberDecorate %70 0 PerPrimitiveNV
      OpMemberDecorate %70 0 BuiltIn PrimitiveShadingRateKHR
      OpDecorate %70 Block
      OpDecorate %80 BuiltIn WorkgroupSize
 %2 = OpTypeVoid
 %3 = OpTypeFunction %2
 %6 = OpTypeInt 32 0
 %7 = OpTypePointer Output %6
 %8 = OpVariable %7 Output
 %9 = OpConstant %6 4
%10 = OpTypeFloat 32
%11 = OpTypeVector %10 4
%12 = OpConstant %6 1
%13 = OpTypeArray %10 %12
%14 = OpTypeArray %11 %9
%15 = OpTypeArray %13 %9
%16 = OpTypeStruct %11 %10 %13 %13 %14 %15 %15
%17 = OpConstant %6 6
%18 = OpTypeArray %16 %17
%19 = OpTypePointer Output %18
%20 = OpVariable %19 Output
%21 = OpTypeInt 32 1
%tm = OpConstant %21 0
%bm = OpConstant %21 0
%22 = OpConstant %21 0
%23 = OpConstant %10 -1
%24 = OpConstant %10 0
%25 = OpConstant %10 1
%26 = OpConstantComposite %11 %23 %23 %24 %25
%27 = OpTypePointer Output %11
%29 = OpConstant %21 1
%30 = OpConstantComposite %11 %23 %24 %24 %25
%32 = OpConstant %21 2
%33 = OpConstantComposite %11 %23 %25 %24 %25
%35 = OpConstant %21 3
%36 = OpConstantComposite %11 %25 %23 %24 %25
%38 = OpConstant %21 4
%39 = OpConstantComposite %11 %25 %24 %24 %25
%41 = OpConstant %21 5
%42 = OpConstantComposite %11 %25 %25 %24 %25
%44 = OpConstant %6 12
%45 = OpTypeArray %6 %44
%46 = OpTypePointer Output %45
%47 = OpVariable %46 Output
%48 = OpConstant %6 0
%51 = OpConstant %6 3
%56 = OpConstant %21 6
%58 = OpConstant %21 7
%59 = OpConstant %6 2
%61 = OpConstant %21 8
%63 = OpConstant %21 9
%65 = OpConstant %21 10
%66 = OpConstant %6 5
%68 = OpConstant %21 11
%70 = OpTypeStruct %21
%71 = OpTypeArray %70 %9
%72 = OpTypePointer Output %71
%73 = OpVariable %72 Output
%74 = OpTypePointer Output %21
%79 = OpTypeVector %6 3
%80 = OpConstantComposite %79 %12 %12 %12
 %4 = OpFunction %2 None %3
 %5 = OpLabel
      OpStore %8 %9
%28 = OpAccessChain %27 %20 %22 %22
      OpStore %28 %26
%31 = OpAccessChain %27 %20 %29 %22
      OpStore %31 %30
%34 = OpAccessChain %27 %20 %32 %22
      OpStore %34 %33
%37 = OpAccessChain %27 %20 %35 %22
      OpStore %37 %36
%40 = OpAccessChain %27 %20 %38 %22
      OpStore %40 %39
%43 = OpAccessChain %27 %20 %41 %22
      OpStore %43 %42
%49 = OpAccessChain %7 %47 %22
      OpStore %49 %48
%50 = OpAccessChain %7 %47 %29
      OpStore %50 %12
%52 = OpAccessChain %7 %47 %32
      OpStore %52 %51
%53 = OpAccessChain %7 %47 %35
      OpStore %53 %12
%54 = OpAccessChain %7 %47 %38
      OpStore %54 %9
%55 = OpAccessChain %7 %47 %41
      OpStore %55 %51
%57 = OpAccessChain %7 %47 %56
      OpStore %57 %12
%60 = OpAccessChain %7 %47 %58
      OpStore %60 %59
%62 = OpAccessChain %7 %47 %61
      OpStore %62 %9
%64 = OpAccessChain %7 %47 %63
      OpStore %64 %59
%67 = OpAccessChain %7 %47 %65
      OpStore %67 %66
%69 = OpAccessChain %7 %47 %68
      OpStore %69 %9
%75 = OpAccessChain %74 %73 %22 %22
      OpStore %75 %tm
%76 = OpAccessChain %74 %73 %29 %22
      OpStore %76 %tm
%77 = OpAccessChain %74 %73 %32 %22
      OpStore %77 %bm
%78 = OpAccessChain %74 %73 %35 %22
      OpStore %78 %bm
      OpReturn
      OpFunctionEnd
#version 460
#extension GL_NV_mesh_shader : enable

#extension GL_EXT_fragment_shading_rate : enable

layout (location=0) out vec4 outColor;

void main ()
{
    const int expectedRate = ((gl_FragCoord.y < 4)? 0 : 0);
    outColor = ((gl_ShadingRateEXT == expectedRate) ? vec4(0.0, 0.0, 1.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0));
}
