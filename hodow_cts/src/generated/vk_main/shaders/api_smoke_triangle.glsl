#version 310 es
layout(location = 0) in highp vec4 a_position;
void main (void) { gl_Position = a_position; }
#version 310 es
layout(location = 0) out lowp vec4 o_color;
void main (void) { o_color = vec4(1.0, 0.0, 1.0, 1.0); }
         OpCapability Shader
%1 =     OpExtInstImport "GLSL.std.450"
         OpMemoryModel Logical GLSL450
         OpEntryPoint Vertex %4 "main" %10 %12 %16 %17
         OpSource ESSL 300
         OpName %4 "main"
         OpName %10 "gl_Position"
         OpName %12 "a_position"
         OpName %16 "gl_VertexIndex"
         OpName %17 "gl_InstanceIndex"
         OpDecorate %10 BuiltIn Position
         OpDecorate %12 Location 0
         OpDecorate %16 BuiltIn VertexIndex
         OpDecorate %17 BuiltIn InstanceIndex
%2 =     OpTypeVoid
%3 =     OpTypeFunction %2
%7 =     OpTypeFloat 32
%8 =     OpTypeVector %7 4
%9 =     OpTypePointer Output %8
%10 =     OpVariable %9 Output
%11 =     OpTypePointer Input %8
%12 =     OpVariable %11 Input
%14 =     OpTypeInt 32 1
%15 =     OpTypePointer Input %14
%16 =     OpVariable %15 Input
%17 =     OpVariable %15 Input
%4 =     OpFunction %2 None %3
%5 =     OpLabel
%13 =     OpLoad %8 %12
         OpStore %10 %13
         OpBranch %6
%6 =     OpLabel
         OpReturn
         OpFunctionEnd
        OpCapability Shader
%1 =    OpExtInstImport "GLSL.std.450"
        OpMemoryModel Logical GLSL450
        OpEntryPoint Fragment %4 "main" %10
        OpExecutionMode %4 OriginUpperLeft
        OpSource ESSL 300
        OpName %4 "main"
        OpName %10 "o_color"
        OpDecorate %10 RelaxedPrecision
        OpDecorate %10 Location 0
%2 =    OpTypeVoid
%3 =    OpTypeFunction %2
%7 =    OpTypeFloat 32
%8 =    OpTypeVector %7 4
%9 =    OpTypePointer Output %8
%10 =    OpVariable %9 Output
%11 =    OpConstant %7 1065353216
%12 =    OpConstant %7 0
%13 =    OpConstantComposite %8 %11 %12 %11 %11
%4 =    OpFunction %2 None %3
%5 =    OpLabel
        OpStore %10 %13
        OpBranch %6
%6 =    OpLabel
        OpReturn
        OpFunctionEnd
OpCapability Shader
%1 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Vertex %4 "main" %20 %22 %26
OpSource ESSL 310
OpMemberDecorate %18 0 BuiltIn Position
OpMemberDecorate %18 1 BuiltIn PointSize
OpDecorate %18 Block
OpDecorate %22 Location 0
OpDecorate %26 Location 2
%2 = OpTypeVoid
%3 = OpTypeFunction %2
%6 = OpTypeFloat 32
%7 = OpTypeVector %6 4
%8 = OpTypeStruct %7
%9 = OpTypePointer Function %8
%11 = OpTypeInt 32 1
%12 = OpConstant %11 0
%13 = OpConstant %6 1
%14 = OpConstant %6 0
%15 = OpConstantComposite %7 %13 %14 %13 %13
%16 = OpTypePointer Function %7
%18 = OpTypeStruct %7 %6
%19 = OpTypePointer Output %18
%20 = OpVariable %19 Output
%21 = OpTypePointer Input %7
%22 = OpVariable %21 Input
%24 = OpTypePointer Output %7
%26 = OpVariable %24 Output
%4 = OpFunction %2 None %3
%5 = OpLabel
%10 = OpVariable %9 Function
%17 = OpAccessChain %16 %10 %12
OpStore %17 %15
%23 = OpLoad %7 %22
%25 = OpAccessChain %24 %20 %12
OpStore %25 %23
%27 = OpAccessChain %16 %10 %12
%28 = OpLoad %7 %27
OpStore %26 %28
OpReturn
OpFunctionEnd
OpCapability Shader
%1 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint Fragment %4 "main" %9 %11
OpExecutionMode %4 OriginUpperLeft
OpSource ESSL 310
OpDecorate %9 RelaxedPrecision
OpDecorate %9 Location 0
OpDecorate %11 Location 2
%2 = OpTypeVoid
%3 = OpTypeFunction %2
%6 = OpTypeFloat 32
%7 = OpTypeVector %6 4
%8 = OpTypePointer Output %7
%9 = OpVariable %8 Output
%10 = OpTypePointer Input %7
%11 = OpVariable %10 Input
%4 = OpFunction %2 None %3
%5 = OpLabel
%12 = OpLoad %7 %11
OpStore %9 %12
OpReturn
OpFunctionEnd
