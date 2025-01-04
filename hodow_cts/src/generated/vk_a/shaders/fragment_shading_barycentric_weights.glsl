#version 450

layout(location = 0) in  vec4 in_position;
layout(location = 1) in  vec4 in_color;
layout(location = 0) out vec3 color;
layout(push_constant) uniform PushConstant { mat4 mvp; } pc;

void main()
{
    color        = in_color.xyz;
    gl_Position  = transpose(pc.mvp) * in_position;
    gl_PointSize = 1.0;
}
#version 450

layout(location = 0) smooth in vec3 in_color;
layout(location = 0) out vec4 out_color;

void main()
{
    out_color = vec4(in_color, 1.0f);
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

layout(location = 0) pervertexEXT in vec3 in_color[];
layout(location = 0) out vec4 out_color;

void main()
{
    vec3 bc = gl_BaryCoordEXT;
    out_color = vec4(in_color[0] * bc.x + in_color[1] * bc.y + in_color[2] * bc.z, 1.0f);
}
#version 450

layout(location = 0) smooth centroid in vec3 in_color;
layout(location = 0) out vec4 out_color;

void main()
{
    out_color = vec4(in_color, 1.0f);
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

layout(location = 0) pervertexEXT in vec3 in_color[];
layout(location = 0) out vec4 out_color;

void main()
{
    vec3 bc = interpolateAtCentroid(gl_BaryCoordEXT);
    out_color = vec4(in_color[0] * bc.x + in_color[1] * bc.y + in_color[2] * bc.z, 1.0f);
}
#version 450

layout(location = 0) smooth sample in vec3 in_color;
layout(location = 0) out vec4 out_color;

void main()
{
    out_color = vec4(in_color, 1.0f);
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

layout(location = 0) pervertexEXT in vec3 in_color[];
layout(location = 0) out vec4 out_color;

void main()
{
    vec3 bc = interpolateAtSample(gl_BaryCoordEXT, gl_SampleID);
    out_color = vec4(in_color[0] * bc.x + in_color[1] * bc.y + in_color[2] * bc.z, 1.0f);
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

layout(location = 0) pervertexEXT in vec3 in_color[];
layout(location = 0) out vec4 out_color;

void main()
{
    vec3 bc = interpolateAtOffset(gl_BaryCoordEXT, vec2(gl_SamplePosition - vec2(0.5)));
    out_color = vec4(in_color[0] * bc.x + in_color[1] * bc.y + in_color[2] * bc.z, 1.0f);
}
#version 450

layout(location = 0) noperspective in vec3 in_color;
layout(location = 0) out vec4 out_color;

void main()
{
    out_color = vec4(in_color, 1.0f);
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

layout(location = 0) pervertexEXT in vec3 in_color[];
layout(location = 0) out vec4 out_color;

void main()
{
    vec3 bc = gl_BaryCoordNoPerspEXT;
    out_color = vec4(in_color[0] * bc.x + in_color[1] * bc.y + in_color[2] * bc.z, 1.0f);
}
#version 450

layout(location = 0) noperspective centroid in vec3 in_color;
layout(location = 0) out vec4 out_color;

void main()
{
    out_color = vec4(in_color, 1.0f);
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

layout(location = 0) pervertexEXT in vec3 in_color[];
layout(location = 0) out vec4 out_color;

void main()
{
    vec3 bc = interpolateAtCentroid(gl_BaryCoordNoPerspEXT);
    out_color = vec4(in_color[0] * bc.x + in_color[1] * bc.y + in_color[2] * bc.z, 1.0f);
}
#version 450

layout(location = 0) noperspective sample in vec3 in_color;
layout(location = 0) out vec4 out_color;

void main()
{
    out_color = vec4(in_color, 1.0f);
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

layout(location = 0) pervertexEXT in vec3 in_color[];
layout(location = 0) out vec4 out_color;

void main()
{
    vec3 bc = interpolateAtSample(gl_BaryCoordNoPerspEXT, gl_SampleID);
    out_color = vec4(in_color[0] * bc.x + in_color[1] * bc.y + in_color[2] * bc.z, 1.0f);
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

layout(location = 0) pervertexEXT in vec3 in_color[];
layout(location = 0) out vec4 out_color;

void main()
{
    vec3 bc = interpolateAtOffset(gl_BaryCoordNoPerspEXT, vec2(gl_SamplePosition - vec2(0.5)));
    out_color = vec4(in_color[0] * bc.x + in_color[1] * bc.y + in_color[2] * bc.z, 1.0f);
}
OpCapability Shader
OpCapability FragmentBarycentricKHR
OpExtension "SPV_KHR_fragment_shader_barycentric"
%1 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %4 "main" %var_BaryCoord %15 %20
OpExecutionMode %4 OriginUpperLeft
OpDecorate %var_BaryCoord BuiltIn BaryCoordKHR
OpDecorate %var_BaryCoord Centroid
OpDecorate %15 Location 0
OpDecorate %20 Location 0
OpDecorate %20 PerVertexKHR
%2 = OpTypeVoid
%3 = OpTypeFunction %2
%6 = OpTypeFloat 32
%7 = OpTypeVector %6 3
%8 = OpTypePointer Function %7
%10 = OpTypePointer Input %7
%var_BaryCoord = OpVariable %10 Input
%13 = OpTypeVector %6 4
%14 = OpTypePointer Output %13
%15 = OpVariable %14 Output
%16 = OpTypeInt 32 0
%17 = OpConstant %16 3
%18 = OpTypeArray %7 %17
%19 = OpTypePointer Input %18
%20 = OpVariable %19 Input
%21 = OpTypeInt 32 1
%22 = OpConstant %21 0
%25 = OpConstant %16 0
%26 = OpTypePointer Function %6
%30 = OpConstant %21 1
%33 = OpConstant %16 1
%38 = OpConstant %21 2
%41 = OpConstant %16 2
%46 = OpConstant %6 1
%4 = OpFunction %2 None %3
%5 = OpLabel
%9 = OpVariable %8 Function
%12 = OpLoad %7 %var_BaryCoord
OpStore %9 %12
%23 = OpAccessChain %10 %20 %22
%24 = OpLoad %7 %23
%27 = OpAccessChain %26 %9 %25
%28 = OpLoad %6 %27
%29 = OpVectorTimesScalar %7 %24 %28
%31 = OpAccessChain %10 %20 %30
%32 = OpLoad %7 %31
%34 = OpAccessChain %26 %9 %33
%35 = OpLoad %6 %34
%36 = OpVectorTimesScalar %7 %32 %35
%37 = OpFAdd %7 %29 %36
%39 = OpAccessChain %10 %20 %38
%40 = OpLoad %7 %39
%42 = OpAccessChain %26 %9 %41
%43 = OpLoad %6 %42
%44 = OpVectorTimesScalar %7 %40 %43
%45 = OpFAdd %7 %37 %44
%47 = OpCompositeExtract %6 %45 0
%48 = OpCompositeExtract %6 %45 1
%49 = OpCompositeExtract %6 %45 2
%50 = OpCompositeConstruct %13 %47 %48 %49 %46
OpStore %15 %50
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability FragmentBarycentricKHR
OpCapability SampleRateShading
OpExtension "SPV_KHR_fragment_shader_barycentric"
%1 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %4 "main" %var_BaryCoord %15 %20
OpExecutionMode %4 OriginUpperLeft
OpDecorate %var_BaryCoord BuiltIn BaryCoordKHR
OpDecorate %var_BaryCoord Sample
OpDecorate %15 Location 0
OpDecorate %20 Location 0
OpDecorate %20 PerVertexKHR
%2 = OpTypeVoid
%3 = OpTypeFunction %2
%6 = OpTypeFloat 32
%7 = OpTypeVector %6 3
%8 = OpTypePointer Function %7
%10 = OpTypePointer Input %7
%var_BaryCoord = OpVariable %10 Input
%13 = OpTypeVector %6 4
%14 = OpTypePointer Output %13
%15 = OpVariable %14 Output
%16 = OpTypeInt 32 0
%17 = OpConstant %16 3
%18 = OpTypeArray %7 %17
%19 = OpTypePointer Input %18
%20 = OpVariable %19 Input
%21 = OpTypeInt 32 1
%22 = OpConstant %21 0
%25 = OpConstant %16 0
%26 = OpTypePointer Function %6
%30 = OpConstant %21 1
%33 = OpConstant %16 1
%38 = OpConstant %21 2
%41 = OpConstant %16 2
%46 = OpConstant %6 1
%4 = OpFunction %2 None %3
%5 = OpLabel
%9 = OpVariable %8 Function
%12 = OpLoad %7 %var_BaryCoord
OpStore %9 %12
%23 = OpAccessChain %10 %20 %22
%24 = OpLoad %7 %23
%27 = OpAccessChain %26 %9 %25
%28 = OpLoad %6 %27
%29 = OpVectorTimesScalar %7 %24 %28
%31 = OpAccessChain %10 %20 %30
%32 = OpLoad %7 %31
%34 = OpAccessChain %26 %9 %33
%35 = OpLoad %6 %34
%36 = OpVectorTimesScalar %7 %32 %35
%37 = OpFAdd %7 %29 %36
%39 = OpAccessChain %10 %20 %38
%40 = OpLoad %7 %39
%42 = OpAccessChain %26 %9 %41
%43 = OpLoad %6 %42
%44 = OpVectorTimesScalar %7 %40 %43
%45 = OpFAdd %7 %37 %44
%47 = OpCompositeExtract %6 %45 0
%48 = OpCompositeExtract %6 %45 1
%49 = OpCompositeExtract %6 %45 2
%50 = OpCompositeConstruct %13 %47 %48 %49 %46
OpStore %15 %50
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability FragmentBarycentricKHR
OpExtension "SPV_KHR_fragment_shader_barycentric"
%1 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %4 "main" %var_BaryCoord %15 %20
OpExecutionMode %4 OriginUpperLeft
OpDecorate %var_BaryCoord BuiltIn BaryCoordNoPerspKHR
OpDecorate %var_BaryCoord Centroid
OpDecorate %15 Location 0
OpDecorate %20 Location 0
OpDecorate %20 PerVertexKHR
%2 = OpTypeVoid
%3 = OpTypeFunction %2
%6 = OpTypeFloat 32
%7 = OpTypeVector %6 3
%8 = OpTypePointer Function %7
%10 = OpTypePointer Input %7
%var_BaryCoord = OpVariable %10 Input
%13 = OpTypeVector %6 4
%14 = OpTypePointer Output %13
%15 = OpVariable %14 Output
%16 = OpTypeInt 32 0
%17 = OpConstant %16 3
%18 = OpTypeArray %7 %17
%19 = OpTypePointer Input %18
%20 = OpVariable %19 Input
%21 = OpTypeInt 32 1
%22 = OpConstant %21 0
%25 = OpConstant %16 0
%26 = OpTypePointer Function %6
%30 = OpConstant %21 1
%33 = OpConstant %16 1
%38 = OpConstant %21 2
%41 = OpConstant %16 2
%46 = OpConstant %6 1
%4 = OpFunction %2 None %3
%5 = OpLabel
%9 = OpVariable %8 Function
%12 = OpLoad %7 %var_BaryCoord
OpStore %9 %12
%23 = OpAccessChain %10 %20 %22
%24 = OpLoad %7 %23
%27 = OpAccessChain %26 %9 %25
%28 = OpLoad %6 %27
%29 = OpVectorTimesScalar %7 %24 %28
%31 = OpAccessChain %10 %20 %30
%32 = OpLoad %7 %31
%34 = OpAccessChain %26 %9 %33
%35 = OpLoad %6 %34
%36 = OpVectorTimesScalar %7 %32 %35
%37 = OpFAdd %7 %29 %36
%39 = OpAccessChain %10 %20 %38
%40 = OpLoad %7 %39
%42 = OpAccessChain %26 %9 %41
%43 = OpLoad %6 %42
%44 = OpVectorTimesScalar %7 %40 %43
%45 = OpFAdd %7 %37 %44
%47 = OpCompositeExtract %6 %45 0
%48 = OpCompositeExtract %6 %45 1
%49 = OpCompositeExtract %6 %45 2
%50 = OpCompositeConstruct %13 %47 %48 %49 %46
OpStore %15 %50
OpReturn
OpFunctionEnd
OpCapability Shader
OpCapability FragmentBarycentricKHR
OpCapability SampleRateShading
OpExtension "SPV_KHR_fragment_shader_barycentric"
%1 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %4 "main" %var_BaryCoord %15 %20
OpExecutionMode %4 OriginUpperLeft
OpDecorate %var_BaryCoord BuiltIn BaryCoordNoPerspKHR
OpDecorate %var_BaryCoord Sample
OpDecorate %15 Location 0
OpDecorate %20 Location 0
OpDecorate %20 PerVertexKHR
%2 = OpTypeVoid
%3 = OpTypeFunction %2
%6 = OpTypeFloat 32
%7 = OpTypeVector %6 3
%8 = OpTypePointer Function %7
%10 = OpTypePointer Input %7
%var_BaryCoord = OpVariable %10 Input
%13 = OpTypeVector %6 4
%14 = OpTypePointer Output %13
%15 = OpVariable %14 Output
%16 = OpTypeInt 32 0
%17 = OpConstant %16 3
%18 = OpTypeArray %7 %17
%19 = OpTypePointer Input %18
%20 = OpVariable %19 Input
%21 = OpTypeInt 32 1
%22 = OpConstant %21 0
%25 = OpConstant %16 0
%26 = OpTypePointer Function %6
%30 = OpConstant %21 1
%33 = OpConstant %16 1
%38 = OpConstant %21 2
%41 = OpConstant %16 2
%46 = OpConstant %6 1
%4 = OpFunction %2 None %3
%5 = OpLabel
%9 = OpVariable %8 Function
%12 = OpLoad %7 %var_BaryCoord
OpStore %9 %12
%23 = OpAccessChain %10 %20 %22
%24 = OpLoad %7 %23
%27 = OpAccessChain %26 %9 %25
%28 = OpLoad %6 %27
%29 = OpVectorTimesScalar %7 %24 %28
%31 = OpAccessChain %10 %20 %30
%32 = OpLoad %7 %31
%34 = OpAccessChain %26 %9 %33
%35 = OpLoad %6 %34
%36 = OpVectorTimesScalar %7 %32 %35
%37 = OpFAdd %7 %29 %36
%39 = OpAccessChain %10 %20 %38
%40 = OpLoad %7 %39
%42 = OpAccessChain %26 %9 %41
%43 = OpLoad %6 %42
%44 = OpVectorTimesScalar %7 %40 %43
%45 = OpFAdd %7 %37 %44
%47 = OpCompositeExtract %6 %45 0
%48 = OpCompositeExtract %6 %45 1
%49 = OpCompositeExtract %6 %45 2
%50 = OpCompositeConstruct %13 %47 %48 %49 %46
OpStore %15 %50
OpReturn
OpFunctionEnd
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(points) out;
layout(max_vertices=1, max_primitives = 1) out;
layout(push_constant) uniform PushConstant { mat4 mvp; } pc;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[32768];
} pvd;
layout (location=0) out vec3 outColor[];

void main ()
{
    uint maxVertex = 1;
    uint maxPrimitive = 1;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z + gl_NumWorkGroups.x * gl_WorkGroupID.y + gl_WorkGroupID.x;
    uint jobId = workGroupIndex + gl_LocalInvocationIndex;
    gl_MeshVerticesEXT[vertex].gl_Position = transpose(pc.mvp) * pvd.vertexBuffer[jobId*2];
    outColor[vertex] = pvd.vertexBuffer[jobId*2+1].xyz;
    gl_PrimitivePointIndicesEXT[primitive] = primitive;
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(lines) out;
layout(max_vertices=256, max_primitives=256) out;
layout(push_constant) uniform PushConstant { mat4 mvp; } pc;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[512];
} pvd;
layout (location=0) out vec3 outColor[];

void main ()
{
    uint maxVertex = 256;
    uint maxPrimitive = 128;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    uint iterations = max(maxVertex, maxPrimitive) / (8 * 4 * 1);
    for (int  iteration = 0; iteration < iterations; ++iteration)
    {
        const uint vertex = gl_LocalInvocationIndex * iterations + iteration;
        const uint primitive = gl_LocalInvocationIndex * iterations + iteration;
        if (vertex < maxVertex)
        {
             gl_MeshVerticesEXT[vertex].gl_Position = transpose(pc.mvp) * pvd.vertexBuffer[vertex*2];
             outColor[vertex] = pvd.vertexBuffer[vertex*2+1].xyz;
        }
        if(primitive < maxPrimitive){
             gl_PrimitiveLineIndicesEXT[primitive] = uvec2(primitive*2, primitive*2+1);
        }
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(triangles) out;
layout(max_vertices=256, max_primitives=256) out;
layout(push_constant) uniform PushConstant { mat4 mvp; } pc;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[12];
} pvd;
layout (location=0) out vec3 outColor[];

void main ()
{
    uint maxVertex = 6;
    uint maxPrimitive = 2;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    const uvec3 indices[2] = uvec3[](
        uvec3(0, 1, 2),
        uvec3(3, 4, 5)
    );
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = transpose(pc.mvp) * pvd.vertexBuffer[vertex*2];
        outColor[vertex] = pvd.vertexBuffer[vertex*2+1].xyz;
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveTriangleIndicesEXT[primitive] = indices[primitive];
    }
}
