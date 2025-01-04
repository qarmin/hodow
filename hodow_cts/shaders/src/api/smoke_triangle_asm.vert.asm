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
