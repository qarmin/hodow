#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1) in;
layout (triangles) out;
layout (max_vertices=3, max_primitives=1) out;

void main ()
{
    SetMeshOutputsEXT(3u, 1u);

    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0u, 1u, 2u);

    gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0, -0.75, 0.0, 1.0);
    gl_MeshVerticesEXT[1].gl_Position = vec4(-0.75, -0.75, 0.0, 1.0);
    gl_MeshVerticesEXT[2].gl_Position = vec4(-0.875, -1.0, 0.0, 1.0);
}
#version 460
layout (location=0) out vec4 outColor;
void main ()
{
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1) in;
layout (points) out;
layout (max_vertices=1, max_primitives=1) out;

void main ()
{
    SetMeshOutputsEXT(1u, 1u);

    gl_PrimitivePointIndicesEXT[0] = 0u;

    gl_MeshVerticesEXT[0].gl_Position = vec4(-0.5, -0.5, 0.0, 1.0);
    gl_MeshVerticesEXT[0].gl_PointSize = 4.0;
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1) in;
layout (triangles) out;
layout (max_vertices=4, max_primitives=2) out;

out gl_MeshPerVertexEXT {
    vec4  gl_Position;
    float gl_ClipDistance[2];
} gl_MeshVerticesEXT[];

void main ()
{
    SetMeshOutputsEXT(4u, 2u);

    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0u, 1u, 2u);
    gl_PrimitiveTriangleIndicesEXT[1] = uvec3(1u, 3u, 2u);

    gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[1].gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[2].gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[3].gl_Position = vec4( 1.0,  1.0, 0.0, 1.0);

    gl_MeshVerticesEXT[0].gl_ClipDistance[0] =  1.0;
    gl_MeshVerticesEXT[1].gl_ClipDistance[0] =  1.0;
    gl_MeshVerticesEXT[2].gl_ClipDistance[0] = -1.0;
    gl_MeshVerticesEXT[3].gl_ClipDistance[0] = -1.0;

    gl_MeshVerticesEXT[0].gl_ClipDistance[1] =  1.0;
    gl_MeshVerticesEXT[1].gl_ClipDistance[1] = -1.0;
    gl_MeshVerticesEXT[2].gl_ClipDistance[1] =  1.0;
    gl_MeshVerticesEXT[3].gl_ClipDistance[1] = -1.0;
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (location=0) out vec4 outColor;

void main ()
{
    outColor = ((gl_ClipDistance[0] >= 0.0 && gl_ClipDistance[1] >= 0.0) ? vec4(0.0, 0.0, 1.0, 1.0) : vec4(1.0, 1.0, 1.0, 1.0));
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1) in;
layout (triangles) out;
layout (max_vertices=6, max_primitives=4) out;

out gl_MeshPerVertexEXT {
    vec4  gl_Position;
    float gl_CullDistance[2];
} gl_MeshVerticesEXT[];

void main ()
{
    SetMeshOutputsEXT(6u, 4u);

    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0u, 1u, 3u);
    gl_PrimitiveTriangleIndicesEXT[1] = uvec3(1u, 4u, 3u);
    gl_PrimitiveTriangleIndicesEXT[2] = uvec3(1u, 2u, 4u);
    gl_PrimitiveTriangleIndicesEXT[3] = uvec3(2u, 5u, 4u);

    gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[1].gl_Position = vec4(-1.0,  0.0, 0.0, 1.0);
    gl_MeshVerticesEXT[2].gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[3].gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[4].gl_Position = vec4( 1.0,  0.0, 0.0, 1.0);
    gl_MeshVerticesEXT[5].gl_Position = vec4( 1.0,  1.0, 0.0, 1.0);

    gl_MeshVerticesEXT[0].gl_CullDistance[0] =  1.0;
    gl_MeshVerticesEXT[1].gl_CullDistance[0] = -1.0;
    gl_MeshVerticesEXT[2].gl_CullDistance[0] = -2.0;
    gl_MeshVerticesEXT[3].gl_CullDistance[0] =  1.0;
    gl_MeshVerticesEXT[4].gl_CullDistance[0] = -1.0;
    gl_MeshVerticesEXT[5].gl_CullDistance[0] = -2.0;

    gl_MeshVerticesEXT[0].gl_CullDistance[1] =  1.0;
    gl_MeshVerticesEXT[1].gl_CullDistance[1] =  1.0;
    gl_MeshVerticesEXT[2].gl_CullDistance[1] =  1.0;
    gl_MeshVerticesEXT[3].gl_CullDistance[1] = -1.0;
    gl_MeshVerticesEXT[4].gl_CullDistance[1] = -1.0;
    gl_MeshVerticesEXT[5].gl_CullDistance[1] = -1.0;
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (location=0) out vec4 outColor;

void main ()
{
    outColor = ((gl_CullDistance[1] >= 0.0) ? vec4(0.0, 0.0, 1.0, 1.0) : vec4(1.0, 1.0, 1.0, 1.0));
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1) in;
layout (triangles) out;
layout (max_vertices=4, max_primitives=2) out;

out gl_MeshPerVertexEXT {
    vec4  gl_Position;
    float gl_ClipDistance[2];
} gl_MeshVerticesEXT[];

layout (location=0) out perprimitiveEXT vec4 triangleColor[];

void main ()
{
    SetMeshOutputsEXT(4u, 2u);

    triangleColor[0] = vec4(0.0, 0.0, 1.0, 1.0);
    triangleColor[1] = vec4(0.0, 0.0, 1.0, 1.0);
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0u, 1u, 2u);
    gl_PrimitiveTriangleIndicesEXT[1] = uvec3(1u, 3u, 2u);

    gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[1].gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[2].gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[3].gl_Position = vec4( 1.0,  1.0, 0.0, 1.0);

    gl_MeshVerticesEXT[0].gl_ClipDistance[0] =  1.0;
    gl_MeshVerticesEXT[1].gl_ClipDistance[0] =  1.0;
    gl_MeshVerticesEXT[2].gl_ClipDistance[0] = -1.0;
    gl_MeshVerticesEXT[3].gl_ClipDistance[0] = -1.0;

    gl_MeshVerticesEXT[0].gl_ClipDistance[1] =  1.0;
    gl_MeshVerticesEXT[1].gl_ClipDistance[1] = -1.0;
    gl_MeshVerticesEXT[2].gl_ClipDistance[1] =  1.0;
    gl_MeshVerticesEXT[3].gl_ClipDistance[1] = -1.0;
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (location=0) out vec4 outColor;
layout (location=0) in perprimitiveEXT vec4 triangleColor;

void main ()
{
    outColor = ((gl_ClipDistance[0] >= 0.0 && gl_ClipDistance[1] >= 0.0) ? triangleColor : vec4(1.0, 1.0, 1.0, 1.0));
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1) in;
layout (triangles) out;
layout (max_vertices=6, max_primitives=4) out;

out gl_MeshPerVertexEXT {
    vec4  gl_Position;
    float gl_CullDistance[2];
} gl_MeshVerticesEXT[];

layout (location=0) out perprimitiveEXT vec4 triangleColor[];

void main ()
{
    SetMeshOutputsEXT(6u, 4u);

    triangleColor[0] = vec4(0.0, 0.0, 1.0, 1.0);
    triangleColor[1] = vec4(0.0, 0.0, 1.0, 1.0);
    triangleColor[2] = vec4(0.0, 0.0, 1.0, 1.0);
    triangleColor[3] = vec4(0.0, 0.0, 1.0, 1.0);
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0u, 1u, 3u);
    gl_PrimitiveTriangleIndicesEXT[1] = uvec3(1u, 4u, 3u);
    gl_PrimitiveTriangleIndicesEXT[2] = uvec3(1u, 2u, 4u);
    gl_PrimitiveTriangleIndicesEXT[3] = uvec3(2u, 5u, 4u);

    gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[1].gl_Position = vec4(-1.0,  0.0, 0.0, 1.0);
    gl_MeshVerticesEXT[2].gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[3].gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[4].gl_Position = vec4( 1.0,  0.0, 0.0, 1.0);
    gl_MeshVerticesEXT[5].gl_Position = vec4( 1.0,  1.0, 0.0, 1.0);

    gl_MeshVerticesEXT[0].gl_CullDistance[0] =  1.0;
    gl_MeshVerticesEXT[1].gl_CullDistance[0] = -1.0;
    gl_MeshVerticesEXT[2].gl_CullDistance[0] = -2.0;
    gl_MeshVerticesEXT[3].gl_CullDistance[0] =  1.0;
    gl_MeshVerticesEXT[4].gl_CullDistance[0] = -1.0;
    gl_MeshVerticesEXT[5].gl_CullDistance[0] = -2.0;

    gl_MeshVerticesEXT[0].gl_CullDistance[1] =  1.0;
    gl_MeshVerticesEXT[1].gl_CullDistance[1] =  1.0;
    gl_MeshVerticesEXT[2].gl_CullDistance[1] =  1.0;
    gl_MeshVerticesEXT[3].gl_CullDistance[1] = -1.0;
    gl_MeshVerticesEXT[4].gl_CullDistance[1] = -1.0;
    gl_MeshVerticesEXT[5].gl_CullDistance[1] = -1.0;
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (location=0) out vec4 outColor;
layout (location=0) in perprimitiveEXT vec4 triangleColor;

void main ()
{
    outColor = ((gl_CullDistance[1] >= 0.0) ? triangleColor : vec4(1.0, 1.0, 1.0, 1.0));
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1) in;
layout (triangles) out;
layout (max_vertices=3, max_primitives=1) out;

perprimitiveEXT out gl_MeshPerPrimitiveEXT {
   int gl_PrimitiveID;
} gl_MeshPrimitivesEXT[];

void main ()
{
    SetMeshOutputsEXT(3u, 1u);

    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0u, 1u, 2u);

    gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
    gl_MeshVerticesEXT[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);

    gl_MeshPrimitivesEXT[0].gl_PrimitiveID = 1629198956;
}
#version 460
#extension GL_EXT_mesh_shader : enable

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
      OpCapability MeshShadingEXT
      OpExtension "SPV_EXT_mesh_shader"
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
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1) in;
layout (triangles) out;
layout (max_vertices=3, max_primitives=1) out;

perprimitiveEXT out gl_MeshPerPrimitiveEXT {
   int gl_Layer;
} gl_MeshPrimitivesEXT[];

void main ()
{
    SetMeshOutputsEXT(3u, 1);

    if (gl_LocalInvocationIndex == 0u)
    {
        gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        gl_MeshVerticesEXT[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
        gl_MeshVerticesEXT[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    }

    gl_PrimitiveTriangleIndicesEXT[gl_LocalInvocationIndex] = uvec3(0, 1, 2);
    gl_MeshPrimitivesEXT[gl_LocalInvocationIndex].gl_Layer = int(gl_WorkGroupID.x);
}
#version 460
#extension GL_EXT_mesh_shader : enable

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
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=4) in;
layout (triangles) out;
layout (max_vertices=3, max_primitives=4) out;

perprimitiveEXT out gl_MeshPerPrimitiveEXT {
   int gl_Layer;
} gl_MeshPrimitivesEXT[];

void main ()
{
    SetMeshOutputsEXT(3u, 4);

    if (gl_LocalInvocationIndex == 0u)
    {
        gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        gl_MeshVerticesEXT[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
        gl_MeshVerticesEXT[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    }

    gl_PrimitiveTriangleIndicesEXT[gl_LocalInvocationIndex] = uvec3(0, 1, 2);
    gl_MeshPrimitivesEXT[gl_LocalInvocationIndex].gl_Layer = int(gl_LocalInvocationIndex);
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1) in;
layout (triangles) out;
layout (max_vertices=3, max_primitives=1) out;

perprimitiveEXT out gl_MeshPerPrimitiveEXT {
   int gl_Layer;
} gl_MeshPrimitivesEXT[];

void main ()
{
    SetMeshOutputsEXT(3u, 1);

    if (gl_LocalInvocationIndex == 0u)
    {
        gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        gl_MeshVerticesEXT[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
        gl_MeshVerticesEXT[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    }

    gl_PrimitiveTriangleIndicesEXT[gl_LocalInvocationIndex] = uvec3(0, 1, 2);
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1) in;
layout (triangles) out;
layout (max_vertices=3, max_primitives=1) out;

perprimitiveEXT out gl_MeshPerPrimitiveEXT {
   int gl_ViewportIndex;
} gl_MeshPrimitivesEXT[];

void main ()
{
    SetMeshOutputsEXT(3u, 1);

    if (gl_LocalInvocationIndex == 0u)
    {
        gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        gl_MeshVerticesEXT[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
        gl_MeshVerticesEXT[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    }

    gl_PrimitiveTriangleIndicesEXT[gl_LocalInvocationIndex] = uvec3(0, 1, 2);
    gl_MeshPrimitivesEXT[gl_LocalInvocationIndex].gl_ViewportIndex = int(gl_WorkGroupID.x);
}
#version 460
#extension GL_EXT_mesh_shader : enable

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
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=4) in;
layout (triangles) out;
layout (max_vertices=3, max_primitives=4) out;

perprimitiveEXT out gl_MeshPerPrimitiveEXT {
   int gl_ViewportIndex;
} gl_MeshPrimitivesEXT[];

void main ()
{
    SetMeshOutputsEXT(3u, 4);

    if (gl_LocalInvocationIndex == 0u)
    {
        gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        gl_MeshVerticesEXT[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
        gl_MeshVerticesEXT[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    }

    gl_PrimitiveTriangleIndicesEXT[gl_LocalInvocationIndex] = uvec3(0, 1, 2);
    gl_MeshPrimitivesEXT[gl_LocalInvocationIndex].gl_ViewportIndex = int(gl_LocalInvocationIndex);
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1) in;
layout (triangles) out;
layout (max_vertices=3, max_primitives=1) out;

perprimitiveEXT out gl_MeshPerPrimitiveEXT {
   int gl_ViewportIndex;
} gl_MeshPrimitivesEXT[];

void main ()
{
    SetMeshOutputsEXT(3u, 1);

    if (gl_LocalInvocationIndex == 0u)
    {
        gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
        gl_MeshVerticesEXT[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
        gl_MeshVerticesEXT[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    }

    gl_PrimitiveTriangleIndicesEXT[gl_LocalInvocationIndex] = uvec3(0, 1, 2);
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1) in;
layout (triangles) out;
layout (max_vertices=3, max_primitives=1) out;


void main ()
{
    SetMeshOutputsEXT(3u, 1u);

    const float imgWidth = float(8);
    const float pixWidth = (2.0 / imgWidth);
    const float halfPix  = (pixWidth / 2.0);
    const float xCenter  = (((float(gl_WorkGroupID.x) + 0.5) / imgWidth) * 2.0 - 1.0);
    const float xLeft    = (xCenter - halfPix);
    const float xRight   = (xCenter + halfPix);
    const uint  vindex   = (0 * 3u);
    const uvec3 indices  = uvec3(vindex + 0, vindex + 1, vindex + 2);

    gl_PrimitiveTriangleIndicesEXT[0] = indices;

    gl_MeshVerticesEXT[indices.x].gl_Position = vec4(xLeft,    0.5, 0.0, 1.0);
    gl_MeshVerticesEXT[indices.y].gl_Position = vec4(xRight,   0.5, 0.0, 1.0);
    gl_MeshVerticesEXT[indices.z].gl_Position = vec4(xCenter, -0.5, 0.0, 1.0);
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1) in;

struct TaskData {
    uint id;
    uint size;
};
taskPayloadSharedEXT TaskData td;

void main ()
{
    td.id          = gl_WorkGroupID.x;
    td.size        = 8;
    EmitMeshTasksEXT(1u, 1u, 1u);
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1) in;
layout (triangles) out;
layout (max_vertices=3, max_primitives=1) out;

struct TaskData {
    uint id;
    uint size;
};
taskPayloadSharedEXT TaskData td;

void main ()
{
    SetMeshOutputsEXT(3u, 1u);

    const float imgWidth = float(td.size);
    const float pixWidth = (2.0 / imgWidth);
    const float halfPix  = (pixWidth / 2.0);
    const float xCenter  = (((float(td.id) + 0.5) / imgWidth) * 2.0 - 1.0);
    const float xLeft    = (xCenter - halfPix);
    const float xRight   = (xCenter + halfPix);
    const uint  vindex   = (0 * 3u);
    const uvec3 indices  = uvec3(vindex + 0, vindex + 1, vindex + 2);

    gl_PrimitiveTriangleIndicesEXT[0] = indices;

    gl_MeshVerticesEXT[indices.x].gl_Position = vec4(xLeft,    0.5, 0.0, 1.0);
    gl_MeshVerticesEXT[indices.y].gl_Position = vec4(xRight,   0.5, 0.0, 1.0);
    gl_MeshVerticesEXT[indices.z].gl_Position = vec4(xCenter, -0.5, 0.0, 1.0);
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=8) in;
layout (triangles) out;
layout (max_vertices=24, max_primitives=8) out;


void main ()
{
    SetMeshOutputsEXT(24, 8);

    const float imgWidth = float(gl_WorkGroupSize.x);
    const float pixWidth = (2.0 / imgWidth);
    const float halfPix  = (pixWidth / 2.0);
    const float xCenter  = (((float(gl_LocalInvocationID.x) + 0.5) / imgWidth) * 2.0 - 1.0);
    const float xLeft    = (xCenter - halfPix);
    const float xRight   = (xCenter + halfPix);
    const uint  vindex   = (gl_LocalInvocationID.x * 3u);
    const uvec3 indices  = uvec3(vindex + 0, vindex + 1, vindex + 2);

    gl_PrimitiveTriangleIndicesEXT[gl_LocalInvocationID.x] = indices;

    gl_MeshVerticesEXT[indices.x].gl_Position = vec4(xLeft,    0.5, 0.0, 1.0);
    gl_MeshVerticesEXT[indices.y].gl_Position = vec4(xRight,   0.5, 0.0, 1.0);
    gl_MeshVerticesEXT[indices.z].gl_Position = vec4(xCenter, -0.5, 0.0, 1.0);
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=8) in;
layout (triangles) out;
layout (max_vertices=24, max_primitives=8) out;


void main ()
{
    SetMeshOutputsEXT(24, 8);

    const float imgWidth = float(gl_WorkGroupSize.x);
    const float pixWidth = (2.0 / imgWidth);
    const float halfPix  = (pixWidth / 2.0);
    const float xCenter  = (((float(gl_LocalInvocationIndex) + 0.5) / imgWidth) * 2.0 - 1.0);
    const float xLeft    = (xCenter - halfPix);
    const float xRight   = (xCenter + halfPix);
    const uint  vindex   = (gl_LocalInvocationIndex * 3u);
    const uvec3 indices  = uvec3(vindex + 0, vindex + 1, vindex + 2);

    gl_PrimitiveTriangleIndicesEXT[gl_LocalInvocationIndex] = indices;

    gl_MeshVerticesEXT[indices.x].gl_Position = vec4(xLeft,    0.5, 0.0, 1.0);
    gl_MeshVerticesEXT[indices.y].gl_Position = vec4(xRight,   0.5, 0.0, 1.0);
    gl_MeshVerticesEXT[indices.z].gl_Position = vec4(xCenter, -0.5, 0.0, 1.0);
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=8) in;

struct TaskData {
    uint indexNumber[8];
    uint size;
};
taskPayloadSharedEXT TaskData td;

void main ()
{
    td.indexNumber[gl_LocalInvocationID.x] = gl_LocalInvocationID.x;
    td.size = gl_WorkGroupSize.x;
    EmitMeshTasksEXT(8, 1u, 1u);
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1) in;
layout (triangles) out;
layout (max_vertices=3, max_primitives=1) out;

struct TaskData {
    uint indexNumber[8];
    uint size;
};
taskPayloadSharedEXT TaskData td;

void main ()
{
    SetMeshOutputsEXT(3, 1);

    const float imgWidth = float(td.size);
    const float pixWidth = (2.0 / imgWidth);
    const float halfPix  = (pixWidth / 2.0);
    const float xCenter  = (((float(td.indexNumber[gl_WorkGroupID.x]) + 0.5) / imgWidth) * 2.0 - 1.0);
    const float xLeft    = (xCenter - halfPix);
    const float xRight   = (xCenter + halfPix);
    const uint  vindex   = (0 * 3u);
    const uvec3 indices  = uvec3(vindex + 0, vindex + 1, vindex + 2);

    gl_PrimitiveTriangleIndicesEXT[0] = indices;

    gl_MeshVerticesEXT[indices.x].gl_Position = vec4(xLeft,    0.5, 0.0, 1.0);
    gl_MeshVerticesEXT[indices.y].gl_Position = vec4(xRight,   0.5, 0.0, 1.0);
    gl_MeshVerticesEXT[indices.z].gl_Position = vec4(xCenter, -0.5, 0.0, 1.0);
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=8) in;

struct TaskData {
    uint indexNumber[8];
    uint size;
};
taskPayloadSharedEXT TaskData td;

void main ()
{
    td.indexNumber[gl_LocalInvocationIndex] = gl_LocalInvocationIndex;
    td.size = gl_WorkGroupSize.x;
    EmitMeshTasksEXT(8, 1u, 1u);
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1) in;
layout (triangles) out;
layout (max_vertices=3, max_primitives=1) out;


void main ()
{
    uint numVertices = 3u;
    uint numPrimitives = 1u;
    if (gl_NumWorkGroups != uvec3(5, 6, 7)) {
        numVertices = 0u;
        numPrimitives = 0u;
    }
    SetMeshOutputsEXT(numVertices, numPrimitives);
    if (numPrimitives == 0u) {
        return;
    }

    const float imgWidth = float(210);
    const float pixWidth = (2.0 / imgWidth);
    const float halfPix  = (pixWidth / 2.0);
    const float xCenter  = (((float((((uvec3(1, 1, 1).x * uvec3(1, 1, 1).y * uvec3(0, 0, 0).z + uvec3(0, 0, 0).y * uvec3(1, 1, 1).x + uvec3(0, 0, 0).x) * 210) + (gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z + gl_WorkGroupID.y * gl_NumWorkGroups.x + gl_WorkGroupID.x))) + 0.5) / imgWidth) * 2.0 - 1.0);
    const float xLeft    = (xCenter - halfPix);
    const float xRight   = (xCenter + halfPix);
    const uint  vindex   = (0 * 3u);
    const uvec3 indices  = uvec3(vindex + 0, vindex + 1, vindex + 2);

    gl_PrimitiveTriangleIndicesEXT[0] = indices;

    gl_MeshVerticesEXT[indices.x].gl_Position = vec4(xLeft,    0.5, 0.0, 1.0);
    gl_MeshVerticesEXT[indices.y].gl_Position = vec4(xRight,   0.5, 0.0, 1.0);
    gl_MeshVerticesEXT[indices.z].gl_Position = vec4(xCenter, -0.5, 0.0, 1.0);
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1) in;

struct TaskData {
    uvec3 parentId;
    uvec3 parentSize;
};
taskPayloadSharedEXT TaskData td;

void main ()
{
    uvec3 meshGroups = uvec3(3, 4, 2);
    if (gl_NumWorkGroups != uvec3(2, 3, 4)) {
        meshGroups = uvec3(0, 0, 0);
    }
    td.parentSize = gl_NumWorkGroups;
    td.parentId   = gl_WorkGroupID;
    EmitMeshTasksEXT(meshGroups.x, meshGroups.y, meshGroups.z);
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1) in;
layout (triangles) out;
layout (max_vertices=3, max_primitives=1) out;

struct TaskData {
    uvec3 parentId;
    uvec3 parentSize;
};
taskPayloadSharedEXT TaskData td;

void main ()
{
    uint numVertices = 3u;
    uint numPrimitives = 1u;
    if (gl_NumWorkGroups != uvec3(3, 4, 2)) {
        numVertices = 0u;
        numPrimitives = 0u;
    }
    SetMeshOutputsEXT(numVertices, numPrimitives);
    if (numPrimitives == 0u) {
        return;
    }

    const float imgWidth = float(576);
    const float pixWidth = (2.0 / imgWidth);
    const float halfPix  = (pixWidth / 2.0);
    const float xCenter  = (((float((((td.parentSize.x * td.parentSize.y * td.parentId.z + td.parentId.y * td.parentSize.x + td.parentId.x) * 24) + (gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z + gl_WorkGroupID.y * gl_NumWorkGroups.x + gl_WorkGroupID.x))) + 0.5) / imgWidth) * 2.0 - 1.0);
    const float xLeft    = (xCenter - halfPix);
    const float xRight   = (xCenter + halfPix);
    const uint  vindex   = (0 * 3u);
    const uvec3 indices  = uvec3(vindex + 0, vindex + 1, vindex + 2);

    gl_PrimitiveTriangleIndicesEXT[0] = indices;

    gl_MeshVerticesEXT[indices.x].gl_Position = vec4(xLeft,    0.5, 0.0, 1.0);
    gl_MeshVerticesEXT[indices.y].gl_Position = vec4(xRight,   0.5, 0.0, 1.0);
    gl_MeshVerticesEXT[indices.z].gl_Position = vec4(xCenter, -0.5, 0.0, 1.0);
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=8) in;
layout (triangles) out;
layout (max_vertices=24, max_primitives=8) out;


void main ()
{
    SetMeshOutputsEXT(24, 8);

    const float imgWidth = float(64);
    const float pixWidth = (2.0 / imgWidth);
    const float halfPix  = (pixWidth / 2.0);
    const float xCenter  = (((float(gl_GlobalInvocationID.x) + 0.5) / imgWidth) * 2.0 - 1.0);
    const float xLeft    = (xCenter - halfPix);
    const float xRight   = (xCenter + halfPix);
    const uint  vindex   = (gl_LocalInvocationIndex * 3u);
    const uvec3 indices  = uvec3(vindex + 0, vindex + 1, vindex + 2);

    gl_PrimitiveTriangleIndicesEXT[gl_LocalInvocationIndex] = indices;

    gl_MeshVerticesEXT[indices.x].gl_Position = vec4(xLeft,    0.5, 0.0, 1.0);
    gl_MeshVerticesEXT[indices.y].gl_Position = vec4(xRight,   0.5, 0.0, 1.0);
    gl_MeshVerticesEXT[indices.z].gl_Position = vec4(xCenter, -0.5, 0.0, 1.0);
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=8) in;

struct TaskData {
    uint pixelId[8];
    uint size;
};
taskPayloadSharedEXT TaskData td;

void main ()
{
    td.pixelId[gl_LocalInvocationIndex] = gl_GlobalInvocationID.x;
    td.size = 64;
    EmitMeshTasksEXT(1u, 1u, 1u);
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=8) in;
layout (triangles) out;
layout (max_vertices=24, max_primitives=8) out;

struct TaskData {
    uint pixelId[8];
    uint size;
};
taskPayloadSharedEXT TaskData td;

void main ()
{
    SetMeshOutputsEXT(24, 8);

    const float imgWidth = float(td.size);
    const float pixWidth = (2.0 / imgWidth);
    const float halfPix  = (pixWidth / 2.0);
    const float xCenter  = (((float(td.pixelId[gl_LocalInvocationIndex]) + 0.5) / imgWidth) * 2.0 - 1.0);
    const float xLeft    = (xCenter - halfPix);
    const float xRight   = (xCenter + halfPix);
    const uint  vindex   = (gl_LocalInvocationIndex * 3u);
    const uvec3 indices  = uvec3(vindex + 0, vindex + 1, vindex + 2);

    gl_PrimitiveTriangleIndicesEXT[gl_LocalInvocationIndex] = indices;

    gl_MeshVerticesEXT[indices.x].gl_Position = vec4(xLeft,    0.5, 0.0, 1.0);
    gl_MeshVerticesEXT[indices.y].gl_Position = vec4(xRight,   0.5, 0.0, 1.0);
    gl_MeshVerticesEXT[indices.z].gl_Position = vec4(xCenter, -0.5, 0.0, 1.0);
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1) in;
layout (triangles) out;
layout (max_vertices=3, max_primitives=1) out;


void main ()
{
    SetMeshOutputsEXT(3u, 1u);

    const float imgWidth = float(8);
    const float pixWidth = (2.0 / imgWidth);
    const float halfPix  = (pixWidth / 2.0);
    const float xCenter  = (((float(uint(gl_DrawID)) + 0.5) / imgWidth) * 2.0 - 1.0);
    const float xLeft    = (xCenter - halfPix);
    const float xRight   = (xCenter + halfPix);
    const uint  vindex   = (0 * 3u);
    const uvec3 indices  = uvec3(vindex + 0, vindex + 1, vindex + 2);

    gl_PrimitiveTriangleIndicesEXT[0] = indices;

    gl_MeshVerticesEXT[indices.x].gl_Position = vec4(xLeft,    0.5, 0.0, 1.0);
    gl_MeshVerticesEXT[indices.y].gl_Position = vec4(xRight,   0.5, 0.0, 1.0);
    gl_MeshVerticesEXT[indices.z].gl_Position = vec4(xCenter, -0.5, 0.0, 1.0);
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1) in;

struct TaskData {
    uint id;
    uint size;
};
taskPayloadSharedEXT TaskData td;

void main ()
{
    td.id          = uint(gl_DrawID);
    td.size        = 8;
    EmitMeshTasksEXT(1u, 1u, 1u);
}
#version 460
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_multiview : enable

layout (local_size_x=1) in;
layout (triangles) out;
layout (max_vertices=3, max_primitives=1) out;

vec4 colors[4] = vec4[](
    vec4(0.0, 0.0, 1.0, 1.0),
    vec4(1.0, 0.0, 1.0, 1.0),
    vec4(0.0, 1.0, 1.0, 1.0),
    vec4(1.0, 1.0, 0.0, 1.0)
);

layout (location=0) perprimitiveEXT out vec4 primitiveColor[];

void main ()
{
    SetMeshOutputsEXT(3u, 1u);

    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0u, 1u, 2u);
    primitiveColor[0] = colors[gl_ViewIndex];

    gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
    gl_MeshVerticesEXT[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
}
#version 460
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_multiview : enable

layout (location=0) perprimitiveEXT in vec4 primitiveColor;
layout (location=0) out vec4 outColor;

void main ()
{
    outColor = primitiveColor;
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1) in;
layout (triangles) out;
layout (max_vertices=6, max_primitives=4) out;

perprimitiveEXT out gl_MeshPerPrimitiveEXT {
   bool gl_CullPrimitiveEXT;
} gl_MeshPrimitivesEXT[];

void main ()
{
    SetMeshOutputsEXT(6u, 4u);

    const vec4 topLeft  = vec4(-1.0, -1.0, 0.0, 1.0);
    const vec4 midLeft  = vec4(-1.0,  0.0, 0.0, 1.0);
    const vec4 botLeft  = vec4(-1.0,  1.0, 0.0, 1.0);

    const vec4 topRight = vec4( 1.0, -1.0, 0.0, 1.0);
    const vec4 midRight = vec4( 1.0,  0.0, 0.0, 1.0);
    const vec4 botRight = vec4( 1.0,  1.0, 0.0, 1.0);

    gl_MeshVerticesEXT[0].gl_Position = topLeft;
    gl_MeshVerticesEXT[1].gl_Position = midLeft;
    gl_MeshVerticesEXT[2].gl_Position = botLeft;

    gl_MeshVerticesEXT[3].gl_Position = topRight;
    gl_MeshVerticesEXT[4].gl_Position = midRight;
    gl_MeshVerticesEXT[5].gl_Position = botRight;

    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0u, 1u, 3u);
    gl_PrimitiveTriangleIndicesEXT[1] = uvec3(1u, 4u, 3u);
    gl_PrimitiveTriangleIndicesEXT[2] = uvec3(1u, 2u, 4u);
    gl_PrimitiveTriangleIndicesEXT[3] = uvec3(2u, 5u, 4u);

    gl_MeshPrimitivesEXT[0].gl_CullPrimitiveEXT = false;
    gl_MeshPrimitivesEXT[1].gl_CullPrimitiveEXT = false;
    gl_MeshPrimitivesEXT[2].gl_CullPrimitiveEXT = true;
    gl_MeshPrimitivesEXT[3].gl_CullPrimitiveEXT = true;
}
#version 460
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_fragment_shading_rate : enable

layout (local_size_x=1) in;
layout (triangles) out;
layout (max_vertices=6, max_primitives=4) out;

perprimitiveEXT out gl_MeshPerPrimitiveEXT {
   int gl_PrimitiveShadingRateEXT;
} gl_MeshPrimitivesEXT[];

void main ()
{
    SetMeshOutputsEXT(6u, 4u);

    const vec4 topLeft  = vec4(-1.0, -1.0, 0.0, 1.0);
    const vec4 midLeft  = vec4(-1.0,  0.0, 0.0, 1.0);
    const vec4 botLeft  = vec4(-1.0,  1.0, 0.0, 1.0);

    const vec4 topRight = vec4( 1.0, -1.0, 0.0, 1.0);
    const vec4 midRight = vec4( 1.0,  0.0, 0.0, 1.0);
    const vec4 botRight = vec4( 1.0,  1.0, 0.0, 1.0);

    gl_MeshVerticesEXT[0].gl_Position = topLeft;
    gl_MeshVerticesEXT[1].gl_Position = midLeft;
    gl_MeshVerticesEXT[2].gl_Position = botLeft;

    gl_MeshVerticesEXT[3].gl_Position = topRight;
    gl_MeshVerticesEXT[4].gl_Position = midRight;
    gl_MeshVerticesEXT[5].gl_Position = botRight;

    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0u, 1u, 3u);
    gl_PrimitiveTriangleIndicesEXT[1] = uvec3(1u, 4u, 3u);
    gl_PrimitiveTriangleIndicesEXT[2] = uvec3(1u, 2u, 4u);
    gl_PrimitiveTriangleIndicesEXT[3] = uvec3(2u, 5u, 4u);

    gl_MeshPrimitivesEXT[0].gl_PrimitiveShadingRateEXT = (gl_ShadingRateFlag2HorizontalPixelsEXT|gl_ShadingRateFlag2VerticalPixelsEXT);
    gl_MeshPrimitivesEXT[1].gl_PrimitiveShadingRateEXT = (gl_ShadingRateFlag2HorizontalPixelsEXT|gl_ShadingRateFlag2VerticalPixelsEXT);
    gl_MeshPrimitivesEXT[2].gl_PrimitiveShadingRateEXT = (gl_ShadingRateFlag2HorizontalPixelsEXT|gl_ShadingRateFlag2VerticalPixelsEXT);
    gl_MeshPrimitivesEXT[3].gl_PrimitiveShadingRateEXT = (gl_ShadingRateFlag2HorizontalPixelsEXT|gl_ShadingRateFlag2VerticalPixelsEXT);
}
#version 460
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_fragment_shading_rate : enable

layout (location=0) out vec4 outColor;

void main ()
{
    const int expectedRate = ((gl_FragCoord.y < 4.0)? (gl_ShadingRateFlag2HorizontalPixelsEXT|gl_ShadingRateFlag2VerticalPixelsEXT) : (gl_ShadingRateFlag2HorizontalPixelsEXT|gl_ShadingRateFlag2VerticalPixelsEXT));
    outColor = ((gl_ShadingRateEXT == expectedRate) ? vec4(0.0, 0.0, 1.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0));
}
#version 460
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_fragment_shading_rate : enable

layout (local_size_x=1) in;
layout (triangles) out;
layout (max_vertices=6, max_primitives=4) out;

perprimitiveEXT out gl_MeshPerPrimitiveEXT {
   int gl_PrimitiveShadingRateEXT;
} gl_MeshPrimitivesEXT[];

void main ()
{
    SetMeshOutputsEXT(6u, 4u);

    const vec4 topLeft  = vec4(-1.0, -1.0, 0.0, 1.0);
    const vec4 midLeft  = vec4(-1.0,  0.0, 0.0, 1.0);
    const vec4 botLeft  = vec4(-1.0,  1.0, 0.0, 1.0);

    const vec4 topRight = vec4( 1.0, -1.0, 0.0, 1.0);
    const vec4 midRight = vec4( 1.0,  0.0, 0.0, 1.0);
    const vec4 botRight = vec4( 1.0,  1.0, 0.0, 1.0);

    gl_MeshVerticesEXT[0].gl_Position = topLeft;
    gl_MeshVerticesEXT[1].gl_Position = midLeft;
    gl_MeshVerticesEXT[2].gl_Position = botLeft;

    gl_MeshVerticesEXT[3].gl_Position = topRight;
    gl_MeshVerticesEXT[4].gl_Position = midRight;
    gl_MeshVerticesEXT[5].gl_Position = botRight;

    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0u, 1u, 3u);
    gl_PrimitiveTriangleIndicesEXT[1] = uvec3(1u, 4u, 3u);
    gl_PrimitiveTriangleIndicesEXT[2] = uvec3(1u, 2u, 4u);
    gl_PrimitiveTriangleIndicesEXT[3] = uvec3(2u, 5u, 4u);

    gl_MeshPrimitivesEXT[0].gl_PrimitiveShadingRateEXT = (gl_ShadingRateFlag2HorizontalPixelsEXT|gl_ShadingRateFlag2VerticalPixelsEXT);
    gl_MeshPrimitivesEXT[1].gl_PrimitiveShadingRateEXT = (gl_ShadingRateFlag2HorizontalPixelsEXT|gl_ShadingRateFlag2VerticalPixelsEXT);
    gl_MeshPrimitivesEXT[2].gl_PrimitiveShadingRateEXT = gl_ShadingRateFlag2HorizontalPixelsEXT;
    gl_MeshPrimitivesEXT[3].gl_PrimitiveShadingRateEXT = gl_ShadingRateFlag2HorizontalPixelsEXT;
}
#version 460
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_fragment_shading_rate : enable

layout (location=0) out vec4 outColor;

void main ()
{
    const int expectedRate = ((gl_FragCoord.y < 4.0)? (gl_ShadingRateFlag2HorizontalPixelsEXT|gl_ShadingRateFlag2VerticalPixelsEXT) : gl_ShadingRateFlag2HorizontalPixelsEXT);
    outColor = ((gl_ShadingRateEXT == expectedRate) ? vec4(0.0, 0.0, 1.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0));
}
#version 460
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_fragment_shading_rate : enable

layout (local_size_x=1) in;
layout (triangles) out;
layout (max_vertices=6, max_primitives=4) out;

perprimitiveEXT out gl_MeshPerPrimitiveEXT {
   int gl_PrimitiveShadingRateEXT;
} gl_MeshPrimitivesEXT[];

void main ()
{
    SetMeshOutputsEXT(6u, 4u);

    const vec4 topLeft  = vec4(-1.0, -1.0, 0.0, 1.0);
    const vec4 midLeft  = vec4(-1.0,  0.0, 0.0, 1.0);
    const vec4 botLeft  = vec4(-1.0,  1.0, 0.0, 1.0);

    const vec4 topRight = vec4( 1.0, -1.0, 0.0, 1.0);
    const vec4 midRight = vec4( 1.0,  0.0, 0.0, 1.0);
    const vec4 botRight = vec4( 1.0,  1.0, 0.0, 1.0);

    gl_MeshVerticesEXT[0].gl_Position = topLeft;
    gl_MeshVerticesEXT[1].gl_Position = midLeft;
    gl_MeshVerticesEXT[2].gl_Position = botLeft;

    gl_MeshVerticesEXT[3].gl_Position = topRight;
    gl_MeshVerticesEXT[4].gl_Position = midRight;
    gl_MeshVerticesEXT[5].gl_Position = botRight;

    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0u, 1u, 3u);
    gl_PrimitiveTriangleIndicesEXT[1] = uvec3(1u, 4u, 3u);
    gl_PrimitiveTriangleIndicesEXT[2] = uvec3(1u, 2u, 4u);
    gl_PrimitiveTriangleIndicesEXT[3] = uvec3(2u, 5u, 4u);

    gl_MeshPrimitivesEXT[0].gl_PrimitiveShadingRateEXT = (gl_ShadingRateFlag2HorizontalPixelsEXT|gl_ShadingRateFlag2VerticalPixelsEXT);
    gl_MeshPrimitivesEXT[1].gl_PrimitiveShadingRateEXT = (gl_ShadingRateFlag2HorizontalPixelsEXT|gl_ShadingRateFlag2VerticalPixelsEXT);
    gl_MeshPrimitivesEXT[2].gl_PrimitiveShadingRateEXT = 0;
    gl_MeshPrimitivesEXT[3].gl_PrimitiveShadingRateEXT = 0;
}
#version 460
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_fragment_shading_rate : enable

layout (location=0) out vec4 outColor;

void main ()
{
    const int expectedRate = ((gl_FragCoord.y < 4.0)? (gl_ShadingRateFlag2HorizontalPixelsEXT|gl_ShadingRateFlag2VerticalPixelsEXT) : 0);
    outColor = ((gl_ShadingRateEXT == expectedRate) ? vec4(0.0, 0.0, 1.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0));
}
#version 460
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_fragment_shading_rate : enable

layout (local_size_x=1) in;
layout (triangles) out;
layout (max_vertices=6, max_primitives=4) out;

perprimitiveEXT out gl_MeshPerPrimitiveEXT {
   int gl_PrimitiveShadingRateEXT;
} gl_MeshPrimitivesEXT[];

void main ()
{
    SetMeshOutputsEXT(6u, 4u);

    const vec4 topLeft  = vec4(-1.0, -1.0, 0.0, 1.0);
    const vec4 midLeft  = vec4(-1.0,  0.0, 0.0, 1.0);
    const vec4 botLeft  = vec4(-1.0,  1.0, 0.0, 1.0);

    const vec4 topRight = vec4( 1.0, -1.0, 0.0, 1.0);
    const vec4 midRight = vec4( 1.0,  0.0, 0.0, 1.0);
    const vec4 botRight = vec4( 1.0,  1.0, 0.0, 1.0);

    gl_MeshVerticesEXT[0].gl_Position = topLeft;
    gl_MeshVerticesEXT[1].gl_Position = midLeft;
    gl_MeshVerticesEXT[2].gl_Position = botLeft;

    gl_MeshVerticesEXT[3].gl_Position = topRight;
    gl_MeshVerticesEXT[4].gl_Position = midRight;
    gl_MeshVerticesEXT[5].gl_Position = botRight;

    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0u, 1u, 3u);
    gl_PrimitiveTriangleIndicesEXT[1] = uvec3(1u, 4u, 3u);
    gl_PrimitiveTriangleIndicesEXT[2] = uvec3(1u, 2u, 4u);
    gl_PrimitiveTriangleIndicesEXT[3] = uvec3(2u, 5u, 4u);

    gl_MeshPrimitivesEXT[0].gl_PrimitiveShadingRateEXT = gl_ShadingRateFlag2HorizontalPixelsEXT;
    gl_MeshPrimitivesEXT[1].gl_PrimitiveShadingRateEXT = gl_ShadingRateFlag2HorizontalPixelsEXT;
    gl_MeshPrimitivesEXT[2].gl_PrimitiveShadingRateEXT = (gl_ShadingRateFlag2HorizontalPixelsEXT|gl_ShadingRateFlag2VerticalPixelsEXT);
    gl_MeshPrimitivesEXT[3].gl_PrimitiveShadingRateEXT = (gl_ShadingRateFlag2HorizontalPixelsEXT|gl_ShadingRateFlag2VerticalPixelsEXT);
}
#version 460
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_fragment_shading_rate : enable

layout (location=0) out vec4 outColor;

void main ()
{
    const int expectedRate = ((gl_FragCoord.y < 4.0)? gl_ShadingRateFlag2HorizontalPixelsEXT : (gl_ShadingRateFlag2HorizontalPixelsEXT|gl_ShadingRateFlag2VerticalPixelsEXT));
    outColor = ((gl_ShadingRateEXT == expectedRate) ? vec4(0.0, 0.0, 1.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0));
}
#version 460
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_fragment_shading_rate : enable

layout (local_size_x=1) in;
layout (triangles) out;
layout (max_vertices=6, max_primitives=4) out;

perprimitiveEXT out gl_MeshPerPrimitiveEXT {
   int gl_PrimitiveShadingRateEXT;
} gl_MeshPrimitivesEXT[];

void main ()
{
    SetMeshOutputsEXT(6u, 4u);

    const vec4 topLeft  = vec4(-1.0, -1.0, 0.0, 1.0);
    const vec4 midLeft  = vec4(-1.0,  0.0, 0.0, 1.0);
    const vec4 botLeft  = vec4(-1.0,  1.0, 0.0, 1.0);

    const vec4 topRight = vec4( 1.0, -1.0, 0.0, 1.0);
    const vec4 midRight = vec4( 1.0,  0.0, 0.0, 1.0);
    const vec4 botRight = vec4( 1.0,  1.0, 0.0, 1.0);

    gl_MeshVerticesEXT[0].gl_Position = topLeft;
    gl_MeshVerticesEXT[1].gl_Position = midLeft;
    gl_MeshVerticesEXT[2].gl_Position = botLeft;

    gl_MeshVerticesEXT[3].gl_Position = topRight;
    gl_MeshVerticesEXT[4].gl_Position = midRight;
    gl_MeshVerticesEXT[5].gl_Position = botRight;

    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0u, 1u, 3u);
    gl_PrimitiveTriangleIndicesEXT[1] = uvec3(1u, 4u, 3u);
    gl_PrimitiveTriangleIndicesEXT[2] = uvec3(1u, 2u, 4u);
    gl_PrimitiveTriangleIndicesEXT[3] = uvec3(2u, 5u, 4u);

    gl_MeshPrimitivesEXT[0].gl_PrimitiveShadingRateEXT = gl_ShadingRateFlag2HorizontalPixelsEXT;
    gl_MeshPrimitivesEXT[1].gl_PrimitiveShadingRateEXT = gl_ShadingRateFlag2HorizontalPixelsEXT;
    gl_MeshPrimitivesEXT[2].gl_PrimitiveShadingRateEXT = gl_ShadingRateFlag2HorizontalPixelsEXT;
    gl_MeshPrimitivesEXT[3].gl_PrimitiveShadingRateEXT = gl_ShadingRateFlag2HorizontalPixelsEXT;
}
#version 460
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_fragment_shading_rate : enable

layout (location=0) out vec4 outColor;

void main ()
{
    const int expectedRate = ((gl_FragCoord.y < 4.0)? gl_ShadingRateFlag2HorizontalPixelsEXT : gl_ShadingRateFlag2HorizontalPixelsEXT);
    outColor = ((gl_ShadingRateEXT == expectedRate) ? vec4(0.0, 0.0, 1.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0));
}
#version 460
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_fragment_shading_rate : enable

layout (local_size_x=1) in;
layout (triangles) out;
layout (max_vertices=6, max_primitives=4) out;

perprimitiveEXT out gl_MeshPerPrimitiveEXT {
   int gl_PrimitiveShadingRateEXT;
} gl_MeshPrimitivesEXT[];

void main ()
{
    SetMeshOutputsEXT(6u, 4u);

    const vec4 topLeft  = vec4(-1.0, -1.0, 0.0, 1.0);
    const vec4 midLeft  = vec4(-1.0,  0.0, 0.0, 1.0);
    const vec4 botLeft  = vec4(-1.0,  1.0, 0.0, 1.0);

    const vec4 topRight = vec4( 1.0, -1.0, 0.0, 1.0);
    const vec4 midRight = vec4( 1.0,  0.0, 0.0, 1.0);
    const vec4 botRight = vec4( 1.0,  1.0, 0.0, 1.0);

    gl_MeshVerticesEXT[0].gl_Position = topLeft;
    gl_MeshVerticesEXT[1].gl_Position = midLeft;
    gl_MeshVerticesEXT[2].gl_Position = botLeft;

    gl_MeshVerticesEXT[3].gl_Position = topRight;
    gl_MeshVerticesEXT[4].gl_Position = midRight;
    gl_MeshVerticesEXT[5].gl_Position = botRight;

    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0u, 1u, 3u);
    gl_PrimitiveTriangleIndicesEXT[1] = uvec3(1u, 4u, 3u);
    gl_PrimitiveTriangleIndicesEXT[2] = uvec3(1u, 2u, 4u);
    gl_PrimitiveTriangleIndicesEXT[3] = uvec3(2u, 5u, 4u);

    gl_MeshPrimitivesEXT[0].gl_PrimitiveShadingRateEXT = gl_ShadingRateFlag2HorizontalPixelsEXT;
    gl_MeshPrimitivesEXT[1].gl_PrimitiveShadingRateEXT = gl_ShadingRateFlag2HorizontalPixelsEXT;
    gl_MeshPrimitivesEXT[2].gl_PrimitiveShadingRateEXT = 0;
    gl_MeshPrimitivesEXT[3].gl_PrimitiveShadingRateEXT = 0;
}
#version 460
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_fragment_shading_rate : enable

layout (location=0) out vec4 outColor;

void main ()
{
    const int expectedRate = ((gl_FragCoord.y < 4.0)? gl_ShadingRateFlag2HorizontalPixelsEXT : 0);
    outColor = ((gl_ShadingRateEXT == expectedRate) ? vec4(0.0, 0.0, 1.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0));
}
#version 460
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_fragment_shading_rate : enable

layout (local_size_x=1) in;
layout (triangles) out;
layout (max_vertices=6, max_primitives=4) out;

perprimitiveEXT out gl_MeshPerPrimitiveEXT {
   int gl_PrimitiveShadingRateEXT;
} gl_MeshPrimitivesEXT[];

void main ()
{
    SetMeshOutputsEXT(6u, 4u);

    const vec4 topLeft  = vec4(-1.0, -1.0, 0.0, 1.0);
    const vec4 midLeft  = vec4(-1.0,  0.0, 0.0, 1.0);
    const vec4 botLeft  = vec4(-1.0,  1.0, 0.0, 1.0);

    const vec4 topRight = vec4( 1.0, -1.0, 0.0, 1.0);
    const vec4 midRight = vec4( 1.0,  0.0, 0.0, 1.0);
    const vec4 botRight = vec4( 1.0,  1.0, 0.0, 1.0);

    gl_MeshVerticesEXT[0].gl_Position = topLeft;
    gl_MeshVerticesEXT[1].gl_Position = midLeft;
    gl_MeshVerticesEXT[2].gl_Position = botLeft;

    gl_MeshVerticesEXT[3].gl_Position = topRight;
    gl_MeshVerticesEXT[4].gl_Position = midRight;
    gl_MeshVerticesEXT[5].gl_Position = botRight;

    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0u, 1u, 3u);
    gl_PrimitiveTriangleIndicesEXT[1] = uvec3(1u, 4u, 3u);
    gl_PrimitiveTriangleIndicesEXT[2] = uvec3(1u, 2u, 4u);
    gl_PrimitiveTriangleIndicesEXT[3] = uvec3(2u, 5u, 4u);

    gl_MeshPrimitivesEXT[0].gl_PrimitiveShadingRateEXT = 0;
    gl_MeshPrimitivesEXT[1].gl_PrimitiveShadingRateEXT = 0;
    gl_MeshPrimitivesEXT[2].gl_PrimitiveShadingRateEXT = (gl_ShadingRateFlag2HorizontalPixelsEXT|gl_ShadingRateFlag2VerticalPixelsEXT);
    gl_MeshPrimitivesEXT[3].gl_PrimitiveShadingRateEXT = (gl_ShadingRateFlag2HorizontalPixelsEXT|gl_ShadingRateFlag2VerticalPixelsEXT);
}
#version 460
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_fragment_shading_rate : enable

layout (location=0) out vec4 outColor;

void main ()
{
    const int expectedRate = ((gl_FragCoord.y < 4.0)? 0 : (gl_ShadingRateFlag2HorizontalPixelsEXT|gl_ShadingRateFlag2VerticalPixelsEXT));
    outColor = ((gl_ShadingRateEXT == expectedRate) ? vec4(0.0, 0.0, 1.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0));
}
#version 460
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_fragment_shading_rate : enable

layout (local_size_x=1) in;
layout (triangles) out;
layout (max_vertices=6, max_primitives=4) out;

perprimitiveEXT out gl_MeshPerPrimitiveEXT {
   int gl_PrimitiveShadingRateEXT;
} gl_MeshPrimitivesEXT[];

void main ()
{
    SetMeshOutputsEXT(6u, 4u);

    const vec4 topLeft  = vec4(-1.0, -1.0, 0.0, 1.0);
    const vec4 midLeft  = vec4(-1.0,  0.0, 0.0, 1.0);
    const vec4 botLeft  = vec4(-1.0,  1.0, 0.0, 1.0);

    const vec4 topRight = vec4( 1.0, -1.0, 0.0, 1.0);
    const vec4 midRight = vec4( 1.0,  0.0, 0.0, 1.0);
    const vec4 botRight = vec4( 1.0,  1.0, 0.0, 1.0);

    gl_MeshVerticesEXT[0].gl_Position = topLeft;
    gl_MeshVerticesEXT[1].gl_Position = midLeft;
    gl_MeshVerticesEXT[2].gl_Position = botLeft;

    gl_MeshVerticesEXT[3].gl_Position = topRight;
    gl_MeshVerticesEXT[4].gl_Position = midRight;
    gl_MeshVerticesEXT[5].gl_Position = botRight;

    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0u, 1u, 3u);
    gl_PrimitiveTriangleIndicesEXT[1] = uvec3(1u, 4u, 3u);
    gl_PrimitiveTriangleIndicesEXT[2] = uvec3(1u, 2u, 4u);
    gl_PrimitiveTriangleIndicesEXT[3] = uvec3(2u, 5u, 4u);

    gl_MeshPrimitivesEXT[0].gl_PrimitiveShadingRateEXT = 0;
    gl_MeshPrimitivesEXT[1].gl_PrimitiveShadingRateEXT = 0;
    gl_MeshPrimitivesEXT[2].gl_PrimitiveShadingRateEXT = gl_ShadingRateFlag2HorizontalPixelsEXT;
    gl_MeshPrimitivesEXT[3].gl_PrimitiveShadingRateEXT = gl_ShadingRateFlag2HorizontalPixelsEXT;
}
#version 460
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_fragment_shading_rate : enable

layout (location=0) out vec4 outColor;

void main ()
{
    const int expectedRate = ((gl_FragCoord.y < 4.0)? 0 : gl_ShadingRateFlag2HorizontalPixelsEXT);
    outColor = ((gl_ShadingRateEXT == expectedRate) ? vec4(0.0, 0.0, 1.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0));
}
#version 460
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_fragment_shading_rate : enable

layout (local_size_x=1) in;
layout (triangles) out;
layout (max_vertices=6, max_primitives=4) out;

perprimitiveEXT out gl_MeshPerPrimitiveEXT {
   int gl_PrimitiveShadingRateEXT;
} gl_MeshPrimitivesEXT[];

void main ()
{
    SetMeshOutputsEXT(6u, 4u);

    const vec4 topLeft  = vec4(-1.0, -1.0, 0.0, 1.0);
    const vec4 midLeft  = vec4(-1.0,  0.0, 0.0, 1.0);
    const vec4 botLeft  = vec4(-1.0,  1.0, 0.0, 1.0);

    const vec4 topRight = vec4( 1.0, -1.0, 0.0, 1.0);
    const vec4 midRight = vec4( 1.0,  0.0, 0.0, 1.0);
    const vec4 botRight = vec4( 1.0,  1.0, 0.0, 1.0);

    gl_MeshVerticesEXT[0].gl_Position = topLeft;
    gl_MeshVerticesEXT[1].gl_Position = midLeft;
    gl_MeshVerticesEXT[2].gl_Position = botLeft;

    gl_MeshVerticesEXT[3].gl_Position = topRight;
    gl_MeshVerticesEXT[4].gl_Position = midRight;
    gl_MeshVerticesEXT[5].gl_Position = botRight;

    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0u, 1u, 3u);
    gl_PrimitiveTriangleIndicesEXT[1] = uvec3(1u, 4u, 3u);
    gl_PrimitiveTriangleIndicesEXT[2] = uvec3(1u, 2u, 4u);
    gl_PrimitiveTriangleIndicesEXT[3] = uvec3(2u, 5u, 4u);

    gl_MeshPrimitivesEXT[0].gl_PrimitiveShadingRateEXT = 0;
    gl_MeshPrimitivesEXT[1].gl_PrimitiveShadingRateEXT = 0;
    gl_MeshPrimitivesEXT[2].gl_PrimitiveShadingRateEXT = 0;
    gl_MeshPrimitivesEXT[3].gl_PrimitiveShadingRateEXT = 0;
}
#version 460
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_fragment_shading_rate : enable

layout (location=0) out vec4 outColor;

void main ()
{
    const int expectedRate = ((gl_FragCoord.y < 4.0)? 0 : 0);
    outColor = ((gl_ShadingRateEXT == expectedRate) ? vec4(0.0, 0.0, 1.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0));
}
