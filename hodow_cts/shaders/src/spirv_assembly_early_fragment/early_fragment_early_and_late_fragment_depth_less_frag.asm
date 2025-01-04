               OpCapability Shader
			   OpExtension "SPV_AMD_shader_early_and_late_fragment_tests"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %main "main" %color_out %gl_FragDepth
               OpExecutionMode %main OriginUpperLeft
               OpExecutionMode %main EarlyAndLateFragmentTestsAMD
               OpExecutionMode %main DepthReplacing
               OpExecutionMode %main DepthLess
               OpSource GLSL 430
               OpName %main "main"
               OpName %color_out "color_out"
               OpName %gl_FragDepth "gl_FragDepth"
               OpDecorate %color_out Location 0
               OpDecorate %gl_FragDepth BuiltIn FragDepth
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
%_ptr_Output_v4float = OpTypePointer Output %v4float
  %color_out = OpVariable %_ptr_Output_v4float Output
    %float_1 = OpConstant %float 1
    %float_0 = OpConstant %float 0
         %12 = OpConstantComposite %v4float %float_1 %float_0 %float_0 %float_1
%_ptr_Output_float = OpTypePointer Output %float
%gl_FragDepth = OpVariable %_ptr_Output_float Output
%float_0_4 = OpConstant %float 0.4
       %main = OpFunction %void None %3
          %5 = OpLabel
               OpStore %color_out %12
               OpStore %gl_FragDepth %float_0_4
               OpReturn
               OpFunctionEnd
