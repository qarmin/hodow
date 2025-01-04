                         OpCapability Shader
                 %glsl = OpExtInstImport "GLSL.std.450"

                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationId
                         OpExecutionMode %main LocalSize 1 1 1

                         OpDecorate %gl_GlobalInvocationId BuiltIn GlobalInvocationId
                         OpDecorate %ra_int ArrayStride 4
                         OpDecorate %struct_int2 BufferBlock
                         OpMemberDecorate %struct_int2 0 Offset 0
                         OpDecorate %input DescriptorSet 0
                         OpDecorate %input Binding 0
                         OpDecorate %output DescriptorSet 0
                         OpDecorate %output Binding 1

                 %uint = OpTypeInt 32 0
             %ptr_uint = OpTypePointer Uniform %uint
       %ptr_input_uint = OpTypePointer Input %uint
                %uint3 = OpTypeVector %uint 3
      %ptr_input_uint3 = OpTypePointer Input %uint3
                 %void = OpTypeVoid
               %voidFn = OpTypeFunction %void

               %uint_0 = OpConstant %uint 0
               %uint_1 = OpConstant %uint 1
                  %int = OpTypeInt 32 1
               %ra_int = OpTypeRuntimeArray %int
                 %int2 = OpTypeVector %int 2
              %ptr_int = OpTypePointer Uniform %int
          %struct_int2 = OpTypeStruct %ra_int
      %ptr_struct_int2 = OpTypePointer Uniform %struct_int2

%gl_GlobalInvocationId = OpVariable %ptr_input_uint3 Input
                %input = OpVariable %ptr_struct_int2 Uniform

               %output = OpVariable %ptr_struct_int2 Uniform
                 %main = OpFunction %void None %voidFn
            %mainStart = OpLabel
            %index_ptr = OpAccessChain %ptr_input_uint %gl_GlobalInvocationId %uint_0
                %index = OpLoad %uint %index_ptr
               %in_ptr = OpAccessChain %ptr_int %input %uint_0 %index
              %invalue = OpLoad %int %in_ptr

             %outvalue = OpExtInst %int %glsl FindUMsb %invalue
              %out_ptr = OpAccessChain %ptr_int %output %uint_0 %index
                         OpStore %out_ptr %outvalue

                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader
                 %glsl = OpExtInstImport "GLSL.std.450"

                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationId
                         OpExecutionMode %main LocalSize 1 1 1

                         OpDecorate %gl_GlobalInvocationId BuiltIn GlobalInvocationId
                         OpDecorate %ra_int ArrayStride 4
                         OpDecorate %struct_int4 BufferBlock
                         OpMemberDecorate %struct_int4 0 Offset 0
                         OpDecorate %input0 DescriptorSet 0
                         OpDecorate %input0 Binding 0
                         OpDecorate %input1 DescriptorSet 0
                         OpDecorate %input1 Binding 1
                         OpDecorate %input2 DescriptorSet 0
                         OpDecorate %input2 Binding 2
                         OpDecorate %output DescriptorSet 0
                         OpDecorate %output Binding 3

                 %uint = OpTypeInt 32 0
             %ptr_uint = OpTypePointer Uniform %uint
       %ptr_input_uint = OpTypePointer Input %uint
                %uint3 = OpTypeVector %uint 3
      %ptr_input_uint3 = OpTypePointer Input %uint3
                 %void = OpTypeVoid
               %voidFn = OpTypeFunction %void

               %uint_0 = OpConstant %uint 0
               %uint_1 = OpConstant %uint 1
                  %int = OpTypeInt 32 1
               %ra_int = OpTypeRuntimeArray %int
                 %int4 = OpTypeVector %int 4
        %ptr_input_int = OpTypePointer Input %int
              %ptr_int = OpTypePointer Uniform %int
          %struct_int4 = OpTypeStruct %ra_int
      %ptr_struct_int4 = OpTypePointer Uniform %struct_int4

%gl_GlobalInvocationId = OpVariable %ptr_input_uint3 Input
               %input0 = OpVariable %ptr_struct_int4 Uniform
               %input1 = OpVariable %ptr_struct_int4 Uniform
               %input2 = OpVariable %ptr_struct_int4 Uniform

               %output = OpVariable %ptr_struct_int4 Uniform
                 %main = OpFunction %void None %voidFn
            %mainStart = OpLabel
            %index_ptr = OpAccessChain %ptr_input_uint %gl_GlobalInvocationId %uint_0
                %index = OpLoad %uint %index_ptr
              %in_ptr0 = OpAccessChain %ptr_int %input0 %uint_0 %index
             %invalue0 = OpLoad %int %in_ptr0
              %in_ptr1 = OpAccessChain %ptr_int %input1 %uint_0 %index
             %invalue1 = OpLoad %int %in_ptr1
              %in_ptr2 = OpAccessChain %ptr_int %input2 %uint_0 %index
             %invalue2 = OpLoad %int %in_ptr2

             %outvalue = OpExtInst %int %glsl UClamp %invalue0 %invalue1 %invalue2
              %out_ptr = OpAccessChain %ptr_int %output %uint_0 %index
                         OpStore %out_ptr %outvalue

                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader
                 %glsl = OpExtInstImport "GLSL.std.450"

                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationId
                         OpExecutionMode %main LocalSize 1 1 1

                         OpDecorate %gl_GlobalInvocationId BuiltIn GlobalInvocationId
                         OpDecorate %ra_int ArrayStride 4
                         OpDecorate %struct_uint3 BufferBlock
                         OpMemberDecorate %struct_uint3 0 Offset 0
                         OpDecorate %struct_int3 BufferBlock
                         OpMemberDecorate %struct_int3 0 Offset 0
                         OpDecorate %input0 DescriptorSet 0
                         OpDecorate %input0 Binding 0
                         OpDecorate %input1 DescriptorSet 0
                         OpDecorate %input1 Binding 1
                         OpDecorate %output DescriptorSet 0
                         OpDecorate %output Binding 2

                 %uint = OpTypeInt 32 0
             %ptr_uint = OpTypePointer Uniform %uint
       %ptr_input_uint = OpTypePointer Input %uint
                %uint3 = OpTypeVector %uint 3
      %ptr_input_uint3 = OpTypePointer Input %uint3
                 %void = OpTypeVoid
               %voidFn = OpTypeFunction %void

               %uint_0 = OpConstant %uint 0
               %uint_1 = OpConstant %uint 1
                  %int = OpTypeInt 32 1
               %ra_int = OpTypeRuntimeArray %int
              %ra_uint = OpTypeRuntimeArray %uint
         %struct_uint3 = OpTypeStruct %ra_uint
     %ptr_struct_uint3 = OpTypePointer Uniform %struct_uint3
                 %int3 = OpTypeVector %int 3
              %ptr_int = OpTypePointer Uniform %int
          %struct_int3 = OpTypeStruct %ra_int
      %ptr_struct_int3 = OpTypePointer Uniform %struct_int3

%gl_GlobalInvocationId = OpVariable %ptr_input_uint3 Input
               %input0 = OpVariable %ptr_struct_int3 Uniform
               %input1 = OpVariable %ptr_struct_int3 Uniform

               %output = OpVariable %ptr_struct_int3 Uniform
                 %main = OpFunction %void None %voidFn
            %mainStart = OpLabel
            %index_ptr = OpAccessChain %ptr_input_uint %gl_GlobalInvocationId %uint_0
                %index = OpLoad %uint %index_ptr
              %in_ptr0 = OpAccessChain %ptr_int %input0 %uint_0 %index
             %invalue0 = OpLoad %int %in_ptr0
              %in_ptr1 = OpAccessChain %ptr_int %input1 %uint_0 %index
             %invalue1 = OpLoad %int %in_ptr1

             %outvalue = OpExtInst %int %glsl UMax %invalue0 %invalue1
              %out_ptr = OpAccessChain %ptr_int %output %uint_0 %index
                         OpStore %out_ptr %outvalue

                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader
                 %glsl = OpExtInstImport "GLSL.std.450"

                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationId
                         OpExecutionMode %main LocalSize 1 1 1

                         OpDecorate %gl_GlobalInvocationId BuiltIn GlobalInvocationId
                         OpDecorate %ra_int ArrayStride 4
                         OpDecorate %struct_uint3 BufferBlock
                         OpMemberDecorate %struct_uint3 0 Offset 0
                         OpDecorate %struct_int3 BufferBlock
                         OpMemberDecorate %struct_int3 0 Offset 0
                         OpDecorate %input0 DescriptorSet 0
                         OpDecorate %input0 Binding 0
                         OpDecorate %input1 DescriptorSet 0
                         OpDecorate %input1 Binding 1
                         OpDecorate %output DescriptorSet 0
                         OpDecorate %output Binding 2

                 %uint = OpTypeInt 32 0
             %ptr_uint = OpTypePointer Uniform %uint
       %ptr_input_uint = OpTypePointer Input %uint
                %uint3 = OpTypeVector %uint 3
      %ptr_input_uint3 = OpTypePointer Input %uint3
                 %void = OpTypeVoid
               %voidFn = OpTypeFunction %void

               %uint_0 = OpConstant %uint 0
               %uint_1 = OpConstant %uint 1
                  %int = OpTypeInt 32 1
               %ra_int = OpTypeRuntimeArray %int
              %ra_uint = OpTypeRuntimeArray %uint
         %struct_uint3 = OpTypeStruct %ra_uint
     %ptr_struct_uint3 = OpTypePointer Uniform %struct_uint3
                 %int3 = OpTypeVector %int 3
              %ptr_int = OpTypePointer Uniform %int
          %struct_int3 = OpTypeStruct %ra_int
      %ptr_struct_int3 = OpTypePointer Uniform %struct_int3

%gl_GlobalInvocationId = OpVariable %ptr_input_uint3 Input
               %input0 = OpVariable %ptr_struct_int3 Uniform
               %input1 = OpVariable %ptr_struct_int3 Uniform

               %output = OpVariable %ptr_struct_int3 Uniform
                 %main = OpFunction %void None %voidFn
            %mainStart = OpLabel
            %index_ptr = OpAccessChain %ptr_input_uint %gl_GlobalInvocationId %uint_0
                %index = OpLoad %uint %index_ptr
              %in_ptr0 = OpAccessChain %ptr_int %input0 %uint_0 %index
             %invalue0 = OpLoad %int %in_ptr0
              %in_ptr1 = OpAccessChain %ptr_int %input1 %uint_0 %index
             %invalue1 = OpLoad %int %in_ptr1

             %outvalue = OpExtInst %int %glsl UMin %invalue0 %invalue1
              %out_ptr = OpAccessChain %ptr_int %output %uint_0 %index
                         OpStore %out_ptr %outvalue

                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader
                 %glsl = OpExtInstImport "GLSL.std.450"

                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationId
                         OpExecutionMode %main LocalSize 1 1 1

                         OpDecorate %gl_GlobalInvocationId BuiltIn GlobalInvocationId
                         OpDecorate %ra_uint ArrayStride 4
                         OpDecorate %struct_uint2 BufferBlock
                         OpMemberDecorate %struct_uint2 0 Offset 0
                         OpDecorate %input DescriptorSet 0
                         OpDecorate %input Binding 0
                         OpDecorate %output DescriptorSet 0
                         OpDecorate %output Binding 1

                 %uint = OpTypeInt 32 0
             %ptr_uint = OpTypePointer Uniform %uint
       %ptr_input_uint = OpTypePointer Input %uint
                %uint3 = OpTypeVector %uint 3
      %ptr_input_uint3 = OpTypePointer Input %uint3
                 %void = OpTypeVoid
               %voidFn = OpTypeFunction %void

               %uint_0 = OpConstant %uint 0
               %uint_1 = OpConstant %uint 1
              %ra_uint = OpTypeRuntimeArray %uint
                %uint2 = OpTypeVector %uint 2
         %struct_uint2 = OpTypeStruct %ra_uint
     %ptr_struct_uint2 = OpTypePointer Uniform %struct_uint2

%gl_GlobalInvocationId = OpVariable %ptr_input_uint3 Input
                %input = OpVariable %ptr_struct_uint2 Uniform

               %output = OpVariable %ptr_struct_uint2 Uniform
                 %main = OpFunction %void None %voidFn
            %mainStart = OpLabel
            %index_ptr = OpAccessChain %ptr_input_uint %gl_GlobalInvocationId %uint_0
                %index = OpLoad %uint %index_ptr
               %in_ptr = OpAccessChain %ptr_uint %input %uint_0 %index
              %invalue = OpLoad %uint %in_ptr

             %outvalue = OpExtInst %uint %glsl FindSMsb %invalue
              %out_ptr = OpAccessChain %ptr_uint %output %uint_0 %index
                         OpStore %out_ptr %outvalue

                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader
                 %glsl = OpExtInstImport "GLSL.std.450"

                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationId
                         OpExecutionMode %main LocalSize 1 1 1

                         OpDecorate %gl_GlobalInvocationId BuiltIn GlobalInvocationId
                         OpDecorate %ra_uint ArrayStride 4
                         OpDecorate %struct_uint2 BufferBlock
                         OpMemberDecorate %struct_uint2 0 Offset 0
                         OpDecorate %input DescriptorSet 0
                         OpDecorate %input Binding 0
                         OpDecorate %output DescriptorSet 0
                         OpDecorate %output Binding 1

                 %uint = OpTypeInt 32 0
             %ptr_uint = OpTypePointer Uniform %uint
       %ptr_input_uint = OpTypePointer Input %uint
                %uint3 = OpTypeVector %uint 3
      %ptr_input_uint3 = OpTypePointer Input %uint3
                 %void = OpTypeVoid
               %voidFn = OpTypeFunction %void

               %uint_0 = OpConstant %uint 0
               %uint_1 = OpConstant %uint 1
              %ra_uint = OpTypeRuntimeArray %uint
                %uint2 = OpTypeVector %uint 2
         %struct_uint2 = OpTypeStruct %ra_uint
     %ptr_struct_uint2 = OpTypePointer Uniform %struct_uint2

%gl_GlobalInvocationId = OpVariable %ptr_input_uint3 Input
                %input = OpVariable %ptr_struct_uint2 Uniform

               %output = OpVariable %ptr_struct_uint2 Uniform
                 %main = OpFunction %void None %voidFn
            %mainStart = OpLabel
            %index_ptr = OpAccessChain %ptr_input_uint %gl_GlobalInvocationId %uint_0
                %index = OpLoad %uint %index_ptr
               %in_ptr = OpAccessChain %ptr_uint %input %uint_0 %index
              %invalue = OpLoad %uint %in_ptr

             %outvalue = OpExtInst %uint %glsl SAbs %invalue
              %out_ptr = OpAccessChain %ptr_uint %output %uint_0 %index
                         OpStore %out_ptr %outvalue

                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader
                 %glsl = OpExtInstImport "GLSL.std.450"

                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationId
                         OpExecutionMode %main LocalSize 1 1 1

                         OpDecorate %gl_GlobalInvocationId BuiltIn GlobalInvocationId
                         OpDecorate %ra_uint ArrayStride 4
                         OpDecorate %struct_uint4 BufferBlock
                         OpMemberDecorate %struct_uint4 0 Offset 0
                         OpDecorate %input0 DescriptorSet 0
                         OpDecorate %input0 Binding 0
                         OpDecorate %input1 DescriptorSet 0
                         OpDecorate %input1 Binding 1
                         OpDecorate %input2 DescriptorSet 0
                         OpDecorate %input2 Binding 2
                         OpDecorate %output DescriptorSet 0
                         OpDecorate %output Binding 3

                 %uint = OpTypeInt 32 0
             %ptr_uint = OpTypePointer Uniform %uint
       %ptr_input_uint = OpTypePointer Input %uint
                %uint3 = OpTypeVector %uint 3
      %ptr_input_uint3 = OpTypePointer Input %uint3
                 %void = OpTypeVoid
               %voidFn = OpTypeFunction %void

               %uint_0 = OpConstant %uint 0
               %uint_1 = OpConstant %uint 1
              %ra_uint = OpTypeRuntimeArray %uint
                %uint4 = OpTypeVector %uint 4
         %struct_uint4 = OpTypeStruct %ra_uint
     %ptr_struct_uint4 = OpTypePointer Uniform %struct_uint4

%gl_GlobalInvocationId = OpVariable %ptr_input_uint3 Input
               %input0 = OpVariable %ptr_struct_uint4 Uniform
               %input1 = OpVariable %ptr_struct_uint4 Uniform
               %input2 = OpVariable %ptr_struct_uint4 Uniform

               %output = OpVariable %ptr_struct_uint4 Uniform
                 %main = OpFunction %void None %voidFn
            %mainStart = OpLabel
            %index_ptr = OpAccessChain %ptr_input_uint %gl_GlobalInvocationId %uint_0
                %index = OpLoad %uint %index_ptr
              %in_ptr0 = OpAccessChain %ptr_uint %input0 %uint_0 %index
             %invalue0 = OpLoad %uint %in_ptr0
              %in_ptr1 = OpAccessChain %ptr_uint %input1 %uint_0 %index
             %invalue1 = OpLoad %uint %in_ptr1
              %in_ptr2 = OpAccessChain %ptr_uint %input2 %uint_0 %index
             %invalue2 = OpLoad %uint %in_ptr2

             %outvalue = OpExtInst %uint %glsl SClamp %invalue0 %invalue1 %invalue2
              %out_ptr = OpAccessChain %ptr_uint %output %uint_0 %index
                         OpStore %out_ptr %outvalue

                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader
                 %glsl = OpExtInstImport "GLSL.std.450"

                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationId
                         OpExecutionMode %main LocalSize 1 1 1

                         OpDecorate %gl_GlobalInvocationId BuiltIn GlobalInvocationId
                         OpDecorate %ra_uint ArrayStride 4
                         OpDecorate %struct_uint3 BufferBlock
                         OpMemberDecorate %struct_uint3 0 Offset 0
                         OpDecorate %input0 DescriptorSet 0
                         OpDecorate %input0 Binding 0
                         OpDecorate %input1 DescriptorSet 0
                         OpDecorate %input1 Binding 1
                         OpDecorate %output DescriptorSet 0
                         OpDecorate %output Binding 2

                 %uint = OpTypeInt 32 0
             %ptr_uint = OpTypePointer Uniform %uint
       %ptr_input_uint = OpTypePointer Input %uint
                %uint3 = OpTypeVector %uint 3
      %ptr_input_uint3 = OpTypePointer Input %uint3
                 %void = OpTypeVoid
               %voidFn = OpTypeFunction %void

               %uint_0 = OpConstant %uint 0
               %uint_1 = OpConstant %uint 1
              %ra_uint = OpTypeRuntimeArray %uint
         %struct_uint3 = OpTypeStruct %ra_uint
     %ptr_struct_uint3 = OpTypePointer Uniform %struct_uint3

%gl_GlobalInvocationId = OpVariable %ptr_input_uint3 Input
               %input0 = OpVariable %ptr_struct_uint3 Uniform
               %input1 = OpVariable %ptr_struct_uint3 Uniform

               %output = OpVariable %ptr_struct_uint3 Uniform
                 %main = OpFunction %void None %voidFn
            %mainStart = OpLabel
            %index_ptr = OpAccessChain %ptr_input_uint %gl_GlobalInvocationId %uint_0
                %index = OpLoad %uint %index_ptr
              %in_ptr0 = OpAccessChain %ptr_uint %input0 %uint_0 %index
             %invalue0 = OpLoad %uint %in_ptr0
              %in_ptr1 = OpAccessChain %ptr_uint %input1 %uint_0 %index
             %invalue1 = OpLoad %uint %in_ptr1

             %outvalue = OpExtInst %uint %glsl SMax %invalue0 %invalue1
              %out_ptr = OpAccessChain %ptr_uint %output %uint_0 %index
                         OpStore %out_ptr %outvalue

                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader
                 %glsl = OpExtInstImport "GLSL.std.450"

                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationId
                         OpExecutionMode %main LocalSize 1 1 1

                         OpDecorate %gl_GlobalInvocationId BuiltIn GlobalInvocationId
                         OpDecorate %ra_uint ArrayStride 4
                         OpDecorate %struct_uint3 BufferBlock
                         OpMemberDecorate %struct_uint3 0 Offset 0
                         OpDecorate %input0 DescriptorSet 0
                         OpDecorate %input0 Binding 0
                         OpDecorate %input1 DescriptorSet 0
                         OpDecorate %input1 Binding 1
                         OpDecorate %output DescriptorSet 0
                         OpDecorate %output Binding 2

                 %uint = OpTypeInt 32 0
             %ptr_uint = OpTypePointer Uniform %uint
       %ptr_input_uint = OpTypePointer Input %uint
                %uint3 = OpTypeVector %uint 3
      %ptr_input_uint3 = OpTypePointer Input %uint3
                 %void = OpTypeVoid
               %voidFn = OpTypeFunction %void

               %uint_0 = OpConstant %uint 0
               %uint_1 = OpConstant %uint 1
              %ra_uint = OpTypeRuntimeArray %uint
         %struct_uint3 = OpTypeStruct %ra_uint
     %ptr_struct_uint3 = OpTypePointer Uniform %struct_uint3

%gl_GlobalInvocationId = OpVariable %ptr_input_uint3 Input
               %input0 = OpVariable %ptr_struct_uint3 Uniform
               %input1 = OpVariable %ptr_struct_uint3 Uniform

               %output = OpVariable %ptr_struct_uint3 Uniform
                 %main = OpFunction %void None %voidFn
            %mainStart = OpLabel
            %index_ptr = OpAccessChain %ptr_input_uint %gl_GlobalInvocationId %uint_0
                %index = OpLoad %uint %index_ptr
              %in_ptr0 = OpAccessChain %ptr_uint %input0 %uint_0 %index
             %invalue0 = OpLoad %uint %in_ptr0
              %in_ptr1 = OpAccessChain %ptr_uint %input1 %uint_0 %index
             %invalue1 = OpLoad %uint %in_ptr1

             %outvalue = OpExtInst %uint %glsl SMin %invalue0 %invalue1
              %out_ptr = OpAccessChain %ptr_uint %output %uint_0 %index
                         OpStore %out_ptr %outvalue

                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader
                 %glsl = OpExtInstImport "GLSL.std.450"

                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationId
                         OpExecutionMode %main LocalSize 1 1 1

                         OpDecorate %gl_GlobalInvocationId BuiltIn GlobalInvocationId
                         OpDecorate %ra_uint ArrayStride 4
                         OpDecorate %struct_uint2 BufferBlock
                         OpMemberDecorate %struct_uint2 0 Offset 0
                         OpDecorate %input DescriptorSet 0
                         OpDecorate %input Binding 0
                         OpDecorate %output DescriptorSet 0
                         OpDecorate %output Binding 1

                 %uint = OpTypeInt 32 0
             %ptr_uint = OpTypePointer Uniform %uint
       %ptr_input_uint = OpTypePointer Input %uint
                %uint3 = OpTypeVector %uint 3
      %ptr_input_uint3 = OpTypePointer Input %uint3
                 %void = OpTypeVoid
               %voidFn = OpTypeFunction %void

               %uint_0 = OpConstant %uint 0
               %uint_1 = OpConstant %uint 1
              %ra_uint = OpTypeRuntimeArray %uint
                %uint2 = OpTypeVector %uint 2
         %struct_uint2 = OpTypeStruct %ra_uint
     %ptr_struct_uint2 = OpTypePointer Uniform %struct_uint2

%gl_GlobalInvocationId = OpVariable %ptr_input_uint3 Input
                %input = OpVariable %ptr_struct_uint2 Uniform

               %output = OpVariable %ptr_struct_uint2 Uniform
                 %main = OpFunction %void None %voidFn
            %mainStart = OpLabel
            %index_ptr = OpAccessChain %ptr_input_uint %gl_GlobalInvocationId %uint_0
                %index = OpLoad %uint %index_ptr
               %in_ptr = OpAccessChain %ptr_uint %input %uint_0 %index
              %invalue = OpLoad %uint %in_ptr

             %outvalue = OpExtInst %uint %glsl SSign %invalue
              %out_ptr = OpAccessChain %ptr_uint %output %uint_0 %index
                         OpStore %out_ptr %outvalue

                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader
                 %glsl = OpExtInstImport "GLSL.std.450"

                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationId
                         OpExecutionMode %main LocalSize 1 1 1

                         OpDecorate %gl_GlobalInvocationId BuiltIn GlobalInvocationId
                         OpDecorate %ra_int ArrayStride 4
                         OpDecorate %struct_int2 BufferBlock
                         OpMemberDecorate %struct_int2 0 Offset 0
                         OpDecorate %input DescriptorSet 0
                         OpDecorate %input Binding 0
                         OpDecorate %output DescriptorSet 0
                         OpDecorate %output Binding 1

                 %uint = OpTypeInt 32 0
             %ptr_uint = OpTypePointer Uniform %uint
       %ptr_input_uint = OpTypePointer Input %uint
                %uint3 = OpTypeVector %uint 3
      %ptr_input_uint3 = OpTypePointer Input %uint3
                 %void = OpTypeVoid
               %voidFn = OpTypeFunction %void

               %uint_0 = OpConstant %uint 0
               %uint_1 = OpConstant %uint 1
                  %int = OpTypeInt 32 1
               %ra_int = OpTypeRuntimeArray %int
                 %int2 = OpTypeVector %int 2
              %ptr_int = OpTypePointer Uniform %int
          %struct_int2 = OpTypeStruct %ra_int
      %ptr_struct_int2 = OpTypePointer Uniform %struct_int2

%gl_GlobalInvocationId = OpVariable %ptr_input_uint3 Input
                %input = OpVariable %ptr_struct_int2 Uniform

               %output = OpVariable %ptr_struct_int2 Uniform
                 %main = OpFunction %void None %voidFn
            %mainStart = OpLabel
            %index_ptr = OpAccessChain %ptr_input_uint %gl_GlobalInvocationId %uint_0
                %index = OpLoad %uint %index_ptr
               %in_ptr = OpAccessChain %ptr_int %input %uint_0 %index
              %invalue = OpLoad %int %in_ptr

              %out_ptr = OpAccessChain %ptr_int %output %uint_0 %index
               %result = OpAtomicUMax %int %out_ptr %uint_1 %uint_0 %invalue


                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader
                 %glsl = OpExtInstImport "GLSL.std.450"

                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationId
                         OpExecutionMode %main LocalSize 1 1 1

                         OpDecorate %gl_GlobalInvocationId BuiltIn GlobalInvocationId
                         OpDecorate %ra_int ArrayStride 4
                         OpDecorate %struct_int2 BufferBlock
                         OpMemberDecorate %struct_int2 0 Offset 0
                         OpDecorate %input DescriptorSet 0
                         OpDecorate %input Binding 0
                         OpDecorate %output DescriptorSet 0
                         OpDecorate %output Binding 1

                 %uint = OpTypeInt 32 0
             %ptr_uint = OpTypePointer Uniform %uint
       %ptr_input_uint = OpTypePointer Input %uint
                %uint3 = OpTypeVector %uint 3
      %ptr_input_uint3 = OpTypePointer Input %uint3
                 %void = OpTypeVoid
               %voidFn = OpTypeFunction %void

               %uint_0 = OpConstant %uint 0
               %uint_1 = OpConstant %uint 1
                  %int = OpTypeInt 32 1
               %ra_int = OpTypeRuntimeArray %int
                 %int2 = OpTypeVector %int 2
              %ptr_int = OpTypePointer Uniform %int
          %struct_int2 = OpTypeStruct %ra_int
      %ptr_struct_int2 = OpTypePointer Uniform %struct_int2

%gl_GlobalInvocationId = OpVariable %ptr_input_uint3 Input
                %input = OpVariable %ptr_struct_int2 Uniform

               %output = OpVariable %ptr_struct_int2 Uniform
                 %main = OpFunction %void None %voidFn
            %mainStart = OpLabel
            %index_ptr = OpAccessChain %ptr_input_uint %gl_GlobalInvocationId %uint_0
                %index = OpLoad %uint %index_ptr
               %in_ptr = OpAccessChain %ptr_int %input %uint_0 %index
              %invalue = OpLoad %int %in_ptr

              %out_ptr = OpAccessChain %ptr_int %output %uint_0 %index
               %result = OpAtomicUMin %int %out_ptr %uint_1 %uint_0 %invalue


                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader

                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationId
                         OpExecutionMode %main LocalSize 1 1 1

                         OpDecorate %gl_GlobalInvocationId BuiltIn GlobalInvocationId
                         OpDecorate %ra_int ArrayStride 4
                         OpDecorate %struct_uint3 BufferBlock
                         OpMemberDecorate %struct_uint3 0 Offset 0
                         OpDecorate %struct_int3 BufferBlock
                         OpMemberDecorate %struct_int3 0 Offset 0
                         OpDecorate %input0 DescriptorSet 0
                         OpDecorate %input0 Binding 0
                         OpDecorate %input1 DescriptorSet 0
                         OpDecorate %input1 Binding 1
                         OpDecorate %output DescriptorSet 0
                         OpDecorate %output Binding 2

                 %uint = OpTypeInt 32 0
             %ptr_uint = OpTypePointer Uniform %uint
       %ptr_input_uint = OpTypePointer Input %uint
                %uint3 = OpTypeVector %uint 3
      %ptr_input_uint3 = OpTypePointer Input %uint3
                 %void = OpTypeVoid
               %voidFn = OpTypeFunction %void

               %uint_0 = OpConstant %uint 0
               %uint_1 = OpConstant %uint 1
                  %int = OpTypeInt 32 1
               %ra_int = OpTypeRuntimeArray %int
              %ra_uint = OpTypeRuntimeArray %uint
         %struct_uint3 = OpTypeStruct %ra_uint
     %ptr_struct_uint3 = OpTypePointer Uniform %struct_uint3
                 %int3 = OpTypeVector %int 3
              %ptr_int = OpTypePointer Uniform %int
          %struct_int3 = OpTypeStruct %ra_int
      %ptr_struct_int3 = OpTypePointer Uniform %struct_int3
                  %bool = OpTypeBool
                 %int_0 = OpConstant %int 0
                 %int_1 = OpConstant %int 1
%gl_GlobalInvocationId = OpVariable %ptr_input_uint3 Input
               %input0 = OpVariable %ptr_struct_int3 Uniform
               %input1 = OpVariable %ptr_struct_int3 Uniform

               %output = OpVariable %ptr_struct_int3 Uniform
                 %main = OpFunction %void None %voidFn
            %mainStart = OpLabel
            %index_ptr = OpAccessChain %ptr_input_uint %gl_GlobalInvocationId %uint_0
                %index = OpLoad %uint %index_ptr
              %in_ptr0 = OpAccessChain %ptr_int %input0 %uint_0 %index
             %invalue0 = OpLoad %int %in_ptr0
              %in_ptr1 = OpAccessChain %ptr_int %input1 %uint_0 %index
             %invalue1 = OpLoad %int %in_ptr1

             %result = OpUGreaterThan %bool %invalue0 %invalue1
		   %outvalue = OpSelect %int %result %int_1 %int_0

              %out_ptr = OpAccessChain %ptr_int %output %uint_0 %index
                         OpStore %out_ptr %outvalue

                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader

                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationId
                         OpExecutionMode %main LocalSize 1 1 1

                         OpDecorate %gl_GlobalInvocationId BuiltIn GlobalInvocationId
                         OpDecorate %ra_int ArrayStride 4
                         OpDecorate %struct_uint3 BufferBlock
                         OpMemberDecorate %struct_uint3 0 Offset 0
                         OpDecorate %struct_int3 BufferBlock
                         OpMemberDecorate %struct_int3 0 Offset 0
                         OpDecorate %input0 DescriptorSet 0
                         OpDecorate %input0 Binding 0
                         OpDecorate %input1 DescriptorSet 0
                         OpDecorate %input1 Binding 1
                         OpDecorate %output DescriptorSet 0
                         OpDecorate %output Binding 2

                 %uint = OpTypeInt 32 0
             %ptr_uint = OpTypePointer Uniform %uint
       %ptr_input_uint = OpTypePointer Input %uint
                %uint3 = OpTypeVector %uint 3
      %ptr_input_uint3 = OpTypePointer Input %uint3
                 %void = OpTypeVoid
               %voidFn = OpTypeFunction %void

               %uint_0 = OpConstant %uint 0
               %uint_1 = OpConstant %uint 1
                  %int = OpTypeInt 32 1
               %ra_int = OpTypeRuntimeArray %int
              %ra_uint = OpTypeRuntimeArray %uint
         %struct_uint3 = OpTypeStruct %ra_uint
     %ptr_struct_uint3 = OpTypePointer Uniform %struct_uint3
                 %int3 = OpTypeVector %int 3
              %ptr_int = OpTypePointer Uniform %int
          %struct_int3 = OpTypeStruct %ra_int
      %ptr_struct_int3 = OpTypePointer Uniform %struct_int3
                  %bool = OpTypeBool
                 %int_0 = OpConstant %int 0
                 %int_1 = OpConstant %int 1
%gl_GlobalInvocationId = OpVariable %ptr_input_uint3 Input
               %input0 = OpVariable %ptr_struct_int3 Uniform
               %input1 = OpVariable %ptr_struct_int3 Uniform

               %output = OpVariable %ptr_struct_int3 Uniform
                 %main = OpFunction %void None %voidFn
            %mainStart = OpLabel
            %index_ptr = OpAccessChain %ptr_input_uint %gl_GlobalInvocationId %uint_0
                %index = OpLoad %uint %index_ptr
              %in_ptr0 = OpAccessChain %ptr_int %input0 %uint_0 %index
             %invalue0 = OpLoad %int %in_ptr0
              %in_ptr1 = OpAccessChain %ptr_int %input1 %uint_0 %index
             %invalue1 = OpLoad %int %in_ptr1

             %result = OpUGreaterThanEqual %bool %invalue0 %invalue1
		   %outvalue = OpSelect %int %result %int_1 %int_0

              %out_ptr = OpAccessChain %ptr_int %output %uint_0 %index
                         OpStore %out_ptr %outvalue

                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader

                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationId
                         OpExecutionMode %main LocalSize 1 1 1

                         OpDecorate %gl_GlobalInvocationId BuiltIn GlobalInvocationId
                         OpDecorate %ra_int ArrayStride 4
                         OpDecorate %struct_uint3 BufferBlock
                         OpMemberDecorate %struct_uint3 0 Offset 0
                         OpDecorate %struct_int3 BufferBlock
                         OpMemberDecorate %struct_int3 0 Offset 0
                         OpDecorate %input0 DescriptorSet 0
                         OpDecorate %input0 Binding 0
                         OpDecorate %input1 DescriptorSet 0
                         OpDecorate %input1 Binding 1
                         OpDecorate %output DescriptorSet 0
                         OpDecorate %output Binding 2

                 %uint = OpTypeInt 32 0
             %ptr_uint = OpTypePointer Uniform %uint
       %ptr_input_uint = OpTypePointer Input %uint
                %uint3 = OpTypeVector %uint 3
      %ptr_input_uint3 = OpTypePointer Input %uint3
                 %void = OpTypeVoid
               %voidFn = OpTypeFunction %void

               %uint_0 = OpConstant %uint 0
               %uint_1 = OpConstant %uint 1
                  %int = OpTypeInt 32 1
               %ra_int = OpTypeRuntimeArray %int
              %ra_uint = OpTypeRuntimeArray %uint
         %struct_uint3 = OpTypeStruct %ra_uint
     %ptr_struct_uint3 = OpTypePointer Uniform %struct_uint3
                 %int3 = OpTypeVector %int 3
              %ptr_int = OpTypePointer Uniform %int
          %struct_int3 = OpTypeStruct %ra_int
      %ptr_struct_int3 = OpTypePointer Uniform %struct_int3
                  %bool = OpTypeBool
                 %int_0 = OpConstant %int 0
                 %int_1 = OpConstant %int 1
%gl_GlobalInvocationId = OpVariable %ptr_input_uint3 Input
               %input0 = OpVariable %ptr_struct_int3 Uniform
               %input1 = OpVariable %ptr_struct_int3 Uniform

               %output = OpVariable %ptr_struct_int3 Uniform
                 %main = OpFunction %void None %voidFn
            %mainStart = OpLabel
            %index_ptr = OpAccessChain %ptr_input_uint %gl_GlobalInvocationId %uint_0
                %index = OpLoad %uint %index_ptr
              %in_ptr0 = OpAccessChain %ptr_int %input0 %uint_0 %index
             %invalue0 = OpLoad %int %in_ptr0
              %in_ptr1 = OpAccessChain %ptr_int %input1 %uint_0 %index
             %invalue1 = OpLoad %int %in_ptr1

             %result = OpULessThan %bool %invalue0 %invalue1
		   %outvalue = OpSelect %int %result %int_1 %int_0

              %out_ptr = OpAccessChain %ptr_int %output %uint_0 %index
                         OpStore %out_ptr %outvalue

                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader

                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationId
                         OpExecutionMode %main LocalSize 1 1 1

                         OpDecorate %gl_GlobalInvocationId BuiltIn GlobalInvocationId
                         OpDecorate %ra_int ArrayStride 4
                         OpDecorate %struct_uint3 BufferBlock
                         OpMemberDecorate %struct_uint3 0 Offset 0
                         OpDecorate %struct_int3 BufferBlock
                         OpMemberDecorate %struct_int3 0 Offset 0
                         OpDecorate %input0 DescriptorSet 0
                         OpDecorate %input0 Binding 0
                         OpDecorate %input1 DescriptorSet 0
                         OpDecorate %input1 Binding 1
                         OpDecorate %output DescriptorSet 0
                         OpDecorate %output Binding 2

                 %uint = OpTypeInt 32 0
             %ptr_uint = OpTypePointer Uniform %uint
       %ptr_input_uint = OpTypePointer Input %uint
                %uint3 = OpTypeVector %uint 3
      %ptr_input_uint3 = OpTypePointer Input %uint3
                 %void = OpTypeVoid
               %voidFn = OpTypeFunction %void

               %uint_0 = OpConstant %uint 0
               %uint_1 = OpConstant %uint 1
                  %int = OpTypeInt 32 1
               %ra_int = OpTypeRuntimeArray %int
              %ra_uint = OpTypeRuntimeArray %uint
         %struct_uint3 = OpTypeStruct %ra_uint
     %ptr_struct_uint3 = OpTypePointer Uniform %struct_uint3
                 %int3 = OpTypeVector %int 3
              %ptr_int = OpTypePointer Uniform %int
          %struct_int3 = OpTypeStruct %ra_int
      %ptr_struct_int3 = OpTypePointer Uniform %struct_int3
                  %bool = OpTypeBool
                 %int_0 = OpConstant %int 0
                 %int_1 = OpConstant %int 1
%gl_GlobalInvocationId = OpVariable %ptr_input_uint3 Input
               %input0 = OpVariable %ptr_struct_int3 Uniform
               %input1 = OpVariable %ptr_struct_int3 Uniform

               %output = OpVariable %ptr_struct_int3 Uniform
                 %main = OpFunction %void None %voidFn
            %mainStart = OpLabel
            %index_ptr = OpAccessChain %ptr_input_uint %gl_GlobalInvocationId %uint_0
                %index = OpLoad %uint %index_ptr
              %in_ptr0 = OpAccessChain %ptr_int %input0 %uint_0 %index
             %invalue0 = OpLoad %int %in_ptr0
              %in_ptr1 = OpAccessChain %ptr_int %input1 %uint_0 %index
             %invalue1 = OpLoad %int %in_ptr1

             %result = OpULessThanEqual %bool %invalue0 %invalue1
		   %outvalue = OpSelect %int %result %int_1 %int_0

              %out_ptr = OpAccessChain %ptr_int %output %uint_0 %index
                         OpStore %out_ptr %outvalue

                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader
                 %glsl = OpExtInstImport "GLSL.std.450"

                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationId
                         OpExecutionMode %main LocalSize 1 1 1

                         OpDecorate %gl_GlobalInvocationId BuiltIn GlobalInvocationId
                         OpDecorate %ra_uint ArrayStride 4
                         OpDecorate %struct_uint2 BufferBlock
                         OpMemberDecorate %struct_uint2 0 Offset 0
                         OpDecorate %input DescriptorSet 0
                         OpDecorate %input Binding 0
                         OpDecorate %output DescriptorSet 0
                         OpDecorate %output Binding 1

                 %uint = OpTypeInt 32 0
             %ptr_uint = OpTypePointer Uniform %uint
       %ptr_input_uint = OpTypePointer Input %uint
                %uint3 = OpTypeVector %uint 3
      %ptr_input_uint3 = OpTypePointer Input %uint3
                 %void = OpTypeVoid
               %voidFn = OpTypeFunction %void

               %uint_0 = OpConstant %uint 0
               %uint_1 = OpConstant %uint 1
              %ra_uint = OpTypeRuntimeArray %uint
                %uint2 = OpTypeVector %uint 2
         %struct_uint2 = OpTypeStruct %ra_uint
     %ptr_struct_uint2 = OpTypePointer Uniform %struct_uint2

%gl_GlobalInvocationId = OpVariable %ptr_input_uint3 Input
                %input = OpVariable %ptr_struct_uint2 Uniform

               %output = OpVariable %ptr_struct_uint2 Uniform
                 %main = OpFunction %void None %voidFn
            %mainStart = OpLabel
            %index_ptr = OpAccessChain %ptr_input_uint %gl_GlobalInvocationId %uint_0
                %index = OpLoad %uint %index_ptr
               %in_ptr = OpAccessChain %ptr_uint %input %uint_0 %index
              %invalue = OpLoad %uint %in_ptr

              %out_ptr = OpAccessChain %ptr_uint %output %uint_0 %index
               %result = OpAtomicSMax %uint %out_ptr %uint_1 %uint_0 %invalue


                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader

                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationId
                         OpExecutionMode %main LocalSize 1 1 1

                         OpDecorate %gl_GlobalInvocationId BuiltIn GlobalInvocationId
                         OpDecorate %ra_uint ArrayStride 4
                         OpDecorate %struct_uint2 BufferBlock
                         OpMemberDecorate %struct_uint2 0 Offset 0
                         OpDecorate %input DescriptorSet 0
                         OpDecorate %input Binding 0
                         OpDecorate %output DescriptorSet 0
                         OpDecorate %output Binding 1

                 %uint = OpTypeInt 32 0
             %ptr_uint = OpTypePointer Uniform %uint
       %ptr_input_uint = OpTypePointer Input %uint
                %uint3 = OpTypeVector %uint 3
      %ptr_input_uint3 = OpTypePointer Input %uint3
                 %void = OpTypeVoid
               %voidFn = OpTypeFunction %void

               %uint_0 = OpConstant %uint 0
               %uint_1 = OpConstant %uint 1
              %ra_uint = OpTypeRuntimeArray %uint
                %uint2 = OpTypeVector %uint 2
         %struct_uint2 = OpTypeStruct %ra_uint
     %ptr_struct_uint2 = OpTypePointer Uniform %struct_uint2

%gl_GlobalInvocationId = OpVariable %ptr_input_uint3 Input
                %input = OpVariable %ptr_struct_uint2 Uniform

               %output = OpVariable %ptr_struct_uint2 Uniform
                 %main = OpFunction %void None %voidFn
            %mainStart = OpLabel
            %index_ptr = OpAccessChain %ptr_input_uint %gl_GlobalInvocationId %uint_0
                %index = OpLoad %uint %index_ptr
               %in_ptr = OpAccessChain %ptr_uint %input %uint_0 %index
              %invalue = OpLoad %uint %in_ptr

              %out_ptr = OpAccessChain %ptr_uint %output %uint_0 %index
               %result = OpAtomicSMin %uint %out_ptr %uint_1 %uint_0 %invalue


                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader

                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationId
                         OpExecutionMode %main LocalSize 1 1 1

                         OpDecorate %gl_GlobalInvocationId BuiltIn GlobalInvocationId
                         OpDecorate %ra_uint ArrayStride 4
                         OpDecorate %struct_uint3 BufferBlock
                         OpMemberDecorate %struct_uint3 0 Offset 0
                         OpDecorate %input0 DescriptorSet 0
                         OpDecorate %input0 Binding 0
                         OpDecorate %input1 DescriptorSet 0
                         OpDecorate %input1 Binding 1
                         OpDecorate %output DescriptorSet 0
                         OpDecorate %output Binding 2

                 %uint = OpTypeInt 32 0
             %ptr_uint = OpTypePointer Uniform %uint
       %ptr_input_uint = OpTypePointer Input %uint
                %uint3 = OpTypeVector %uint 3
      %ptr_input_uint3 = OpTypePointer Input %uint3
                 %void = OpTypeVoid
               %voidFn = OpTypeFunction %void

               %uint_0 = OpConstant %uint 0
               %uint_1 = OpConstant %uint 1
              %ra_uint = OpTypeRuntimeArray %uint
         %struct_uint3 = OpTypeStruct %ra_uint
     %ptr_struct_uint3 = OpTypePointer Uniform %struct_uint3

%gl_GlobalInvocationId = OpVariable %ptr_input_uint3 Input
               %input0 = OpVariable %ptr_struct_uint3 Uniform
               %input1 = OpVariable %ptr_struct_uint3 Uniform

               %output = OpVariable %ptr_struct_uint3 Uniform
                 %main = OpFunction %void None %voidFn
            %mainStart = OpLabel
            %index_ptr = OpAccessChain %ptr_input_uint %gl_GlobalInvocationId %uint_0
                %index = OpLoad %uint %index_ptr
              %in_ptr0 = OpAccessChain %ptr_uint %input0 %uint_0 %index
             %invalue0 = OpLoad %uint %in_ptr0
              %in_ptr1 = OpAccessChain %ptr_uint %input1 %uint_0 %index
             %invalue1 = OpLoad %uint %in_ptr1

             %outvalue = OpSDiv %uint %invalue0 %invalue1
              %out_ptr = OpAccessChain %ptr_uint %output %uint_0 %index
                         OpStore %out_ptr %outvalue

                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader

                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationId
                         OpExecutionMode %main LocalSize 1 1 1

                         OpDecorate %gl_GlobalInvocationId BuiltIn GlobalInvocationId
                         OpDecorate %ra_uint ArrayStride 4
                         OpDecorate %struct_uint4 BufferBlock
                         OpMemberDecorate %struct_uint4 0 Offset 0
                         OpDecorate %input0 DescriptorSet 0
                         OpDecorate %input0 Binding 0
                         OpDecorate %input1 DescriptorSet 0
                         OpDecorate %input1 Binding 1
                         OpDecorate %output0 DescriptorSet 0
                         OpDecorate %output0 Binding 2
                         OpDecorate %output1 DescriptorSet 0
                         OpDecorate %output1 Binding 3

                 %uint = OpTypeInt 32 0
             %ptr_uint = OpTypePointer Uniform %uint
       %ptr_input_uint = OpTypePointer Input %uint
                %uint3 = OpTypeVector %uint 3
      %ptr_input_uint3 = OpTypePointer Input %uint3
                 %void = OpTypeVoid
               %voidFn = OpTypeFunction %void

               %uint_0 = OpConstant %uint 0
               %uint_1 = OpConstant %uint 1
              %ra_uint = OpTypeRuntimeArray %uint
                %uint4 = OpTypeVector %uint 4
         %struct_uint4 = OpTypeStruct %ra_uint
     %ptr_struct_uint4 = OpTypePointer Uniform %struct_uint4
           %resulttype = OpTypeStruct %uint %uint
%gl_GlobalInvocationId = OpVariable %ptr_input_uint3 Input
               %input0 = OpVariable %ptr_struct_uint4 Uniform
               %input1 = OpVariable %ptr_struct_uint4 Uniform

              %output0 = OpVariable %ptr_struct_uint4 Uniform
              %output1 = OpVariable %ptr_struct_uint4 Uniform

                 %main = OpFunction %void None %voidFn
            %mainStart = OpLabel
            %index_ptr = OpAccessChain %ptr_input_uint %gl_GlobalInvocationId %uint_0
                %index = OpLoad %uint %index_ptr
              %in_ptr0 = OpAccessChain %ptr_uint %input0 %uint_0 %index
             %invalue0 = OpLoad %uint %in_ptr0
              %in_ptr1 = OpAccessChain %ptr_uint %input1 %uint_0 %index
             %invalue1 = OpLoad %uint %in_ptr1

             %outvalue = OpSMulExtended %resulttype %invalue0 %invalue1
            %outvalue0 = OpCompositeExtract %uint %outvalue 0
             %out_ptr0 = OpAccessChain %ptr_uint %output0 %uint_0 %index
                         OpStore %out_ptr0 %outvalue0
            %outvalue1 = OpCompositeExtract %uint %outvalue 1
             %out_ptr1 = OpAccessChain %ptr_uint %output1 %uint_0 %index
                         OpStore %out_ptr1 %outvalue1


                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader

                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationId
                         OpExecutionMode %main LocalSize 1 1 1

                         OpDecorate %gl_GlobalInvocationId BuiltIn GlobalInvocationId
                         OpDecorate %ra_uint ArrayStride 4
                         OpDecorate %struct_uint2 BufferBlock
                         OpMemberDecorate %struct_uint2 0 Offset 0
                         OpDecorate %input DescriptorSet 0
                         OpDecorate %input Binding 0
                         OpDecorate %output DescriptorSet 0
                         OpDecorate %output Binding 1

                 %uint = OpTypeInt 32 0
             %ptr_uint = OpTypePointer Uniform %uint
       %ptr_input_uint = OpTypePointer Input %uint
                %uint3 = OpTypeVector %uint 3
      %ptr_input_uint3 = OpTypePointer Input %uint3
                 %void = OpTypeVoid
               %voidFn = OpTypeFunction %void

               %uint_0 = OpConstant %uint 0
               %uint_1 = OpConstant %uint 1
              %ra_uint = OpTypeRuntimeArray %uint
                %uint2 = OpTypeVector %uint 2
         %struct_uint2 = OpTypeStruct %ra_uint
     %ptr_struct_uint2 = OpTypePointer Uniform %struct_uint2

%gl_GlobalInvocationId = OpVariable %ptr_input_uint3 Input
                %input = OpVariable %ptr_struct_uint2 Uniform

               %output = OpVariable %ptr_struct_uint2 Uniform
                 %main = OpFunction %void None %voidFn
            %mainStart = OpLabel
            %index_ptr = OpAccessChain %ptr_input_uint %gl_GlobalInvocationId %uint_0
                %index = OpLoad %uint %index_ptr
               %in_ptr = OpAccessChain %ptr_uint %input %uint_0 %index
              %invalue = OpLoad %uint %in_ptr

             %outvalue = OpSNegate %uint %invalue
              %out_ptr = OpAccessChain %ptr_uint %output %uint_0 %index
                         OpStore %out_ptr %outvalue

                         OpReturn
                         OpFunctionEnd
                         OpCapability Shader

                         OpMemoryModel Logical GLSL450
                         OpEntryPoint GLCompute %main "main" %gl_GlobalInvocationId
                         OpExecutionMode %main LocalSize 1 1 1

                         OpDecorate %gl_GlobalInvocationId BuiltIn GlobalInvocationId
                         OpDecorate %struct_uint4 BufferBlock
                         OpMemberDecorate %struct_uint4 0 Offset 0
                         OpDecorate %input0 DescriptorSet 0
                         OpDecorate %input0 Binding 0
                         OpDecorate %input1 DescriptorSet 0
                         OpDecorate %input1 Binding 1
                         OpDecorate %output0 DescriptorSet 0
                         OpDecorate %output0 Binding 2
                         OpDecorate %output1 DescriptorSet 0
                         OpDecorate %output1 Binding 3

                 %uint = OpTypeInt 32 0
             %ptr_uint = OpTypePointer Uniform %uint
       %ptr_input_uint = OpTypePointer Input %uint
                %uint3 = OpTypeVector %uint 3
      %ptr_input_uint3 = OpTypePointer Input %uint3
                 %void = OpTypeVoid
               %voidFn = OpTypeFunction %void

               %uint_0 = OpConstant %uint 0
               %uint_1 = OpConstant %uint 1
                %uint4 = OpTypeVector %uint 4
         %struct_uint4 = OpTypeStruct %uint4
     %ptr_struct_uint4 = OpTypePointer Uniform %struct_uint4
           %resulttype = OpTypeStruct %uint %uint
%gl_GlobalInvocationId = OpVariable %ptr_input_uint3 Input
               %input0 = OpVariable %ptr_struct_uint4 Uniform
               %input1 = OpVariable %ptr_struct_uint4 Uniform

              %output0 = OpVariable %ptr_struct_uint4 Uniform
              %output1 = OpVariable %ptr_struct_uint4 Uniform

                 %main = OpFunction %void None %voidFn
            %mainStart = OpLabel
            %index_ptr = OpAccessChain %ptr_input_uint %gl_GlobalInvocationId %uint_0
                %index = OpLoad %uint %index_ptr
              %in_ptr0 = OpAccessChain %ptr_uint %input0 %uint_0 %index
             %invalue0 = OpLoad %uint %in_ptr0
              %in_ptr1 = OpAccessChain %ptr_uint %input1 %uint_0 %index
             %invalue1 = OpLoad %uint %in_ptr1

             %outvalue = OpUMulExtended %resulttype %invalue0 %invalue1
            %outvalue0 = OpCompositeExtract %uint %outvalue 0
             %out_ptr0 = OpAccessChain %ptr_uint %output0 %uint_0 %index
                         OpStore %out_ptr0 %outvalue0
            %outvalue1 = OpCompositeExtract %uint %outvalue 1
             %out_ptr1 = OpAccessChain %ptr_uint %output1 %uint_0 %index
                         OpStore %out_ptr1 %outvalue1


                         OpReturn
                         OpFunctionEnd
               OpCapability Shader
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %18 "main" %gl_GlobalInvocationID
               OpExecutionMode %18 LocalSize 1 1 1
               OpSource OpenCL_C 120
               OpDecorate %_runtimearr_uint ArrayStride 4
               OpMemberDecorate %_struct_3 0 Offset 0
               OpDecorate %_struct_3 BufferBlock
               OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
               OpDecorate %15 DescriptorSet 0
               OpDecorate %15 Binding 0
               OpDecorate %16 DescriptorSet 0
               OpDecorate %16 Binding 1
               OpDecorate %17 DescriptorSet 0
               OpDecorate %17 Binding 2
       %uint = OpTypeInt 32 0
%_runtimearr_uint = OpTypeRuntimeArray %uint
  %_struct_3 = OpTypeStruct %_runtimearr_uint
%_ptr_Uniform__struct_3 = OpTypePointer Uniform %_struct_3
       %void = OpTypeVoid
          %6 = OpTypeFunction %void
     %v3uint = OpTypeVector %uint 3
%_ptr_Input_v3uint = OpTypePointer Input %v3uint
%_ptr_Input_uint = OpTypePointer Input %uint
%_ptr_Uniform_uint = OpTypePointer Uniform %uint
       %bool = OpTypeBool
     %uint_0 = OpConstant %uint 0
     %uint_1 = OpConstant %uint 1
%gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %15 = OpVariable %_ptr_Uniform__struct_3 Uniform
         %16 = OpVariable %_ptr_Uniform__struct_3 Uniform
         %17 = OpVariable %_ptr_Uniform__struct_3 Uniform
         %18 = OpFunction %void None %6
         %19 = OpLabel
         %20 = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
         %21 = OpLoad %uint %20
         %22 = OpAccessChain %_ptr_Uniform_uint %15 %uint_0 %21
         %23 = OpLoad %uint %22
         %24 = OpAccessChain %_ptr_Uniform_uint %16 %uint_0 %21
         %25 = OpLoad %uint %24
         %26 = OpSGreaterThan %bool %23 %25
         %27 = OpSelect %uint %26 %uint_1 %uint_0
         %28 = OpAccessChain %_ptr_Uniform_uint %17 %uint_0 %21
               OpStore %28 %27
               OpReturn
               OpFunctionEnd
               OpCapability Shader
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %18 "main" %gl_GlobalInvocationID
               OpExecutionMode %18 LocalSize 1 1 1
               OpSource OpenCL_C 120
               OpDecorate %_runtimearr_uint ArrayStride 4
               OpMemberDecorate %_struct_3 0 Offset 0
               OpDecorate %_struct_3 BufferBlock
               OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
               OpDecorate %15 DescriptorSet 0
               OpDecorate %15 Binding 0
               OpDecorate %16 DescriptorSet 0
               OpDecorate %16 Binding 1
               OpDecorate %17 DescriptorSet 0
               OpDecorate %17 Binding 2
       %uint = OpTypeInt 32 0
%_runtimearr_uint = OpTypeRuntimeArray %uint
  %_struct_3 = OpTypeStruct %_runtimearr_uint
%_ptr_Uniform__struct_3 = OpTypePointer Uniform %_struct_3
       %void = OpTypeVoid
          %6 = OpTypeFunction %void
     %v3uint = OpTypeVector %uint 3
%_ptr_Input_v3uint = OpTypePointer Input %v3uint
%_ptr_Input_uint = OpTypePointer Input %uint
%_ptr_Uniform_uint = OpTypePointer Uniform %uint
       %bool = OpTypeBool
     %uint_0 = OpConstant %uint 0
     %uint_1 = OpConstant %uint 1
%gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %15 = OpVariable %_ptr_Uniform__struct_3 Uniform
         %16 = OpVariable %_ptr_Uniform__struct_3 Uniform
         %17 = OpVariable %_ptr_Uniform__struct_3 Uniform
         %18 = OpFunction %void None %6
         %19 = OpLabel
         %20 = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
         %21 = OpLoad %uint %20
         %22 = OpAccessChain %_ptr_Uniform_uint %15 %uint_0 %21
         %23 = OpLoad %uint %22
         %24 = OpAccessChain %_ptr_Uniform_uint %16 %uint_0 %21
         %25 = OpLoad %uint %24
         %26 = OpSGreaterThanEqual %bool %23 %25
         %27 = OpSelect %uint %26 %uint_1 %uint_0
         %28 = OpAccessChain %_ptr_Uniform_uint %17 %uint_0 %21
               OpStore %28 %27
               OpReturn
               OpFunctionEnd
               OpCapability Shader
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %18 "main" %gl_GlobalInvocationID
               OpExecutionMode %18 LocalSize 1 1 1
               OpSource OpenCL_C 120
               OpDecorate %_runtimearr_uint ArrayStride 4
               OpMemberDecorate %_struct_3 0 Offset 0
               OpDecorate %_struct_3 BufferBlock
               OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
               OpDecorate %15 DescriptorSet 0
               OpDecorate %15 Binding 0
               OpDecorate %16 DescriptorSet 0
               OpDecorate %16 Binding 1
               OpDecorate %17 DescriptorSet 0
               OpDecorate %17 Binding 2
       %uint = OpTypeInt 32 0
%_runtimearr_uint = OpTypeRuntimeArray %uint
  %_struct_3 = OpTypeStruct %_runtimearr_uint
%_ptr_Uniform__struct_3 = OpTypePointer Uniform %_struct_3
       %void = OpTypeVoid
          %6 = OpTypeFunction %void
     %v3uint = OpTypeVector %uint 3
%_ptr_Input_v3uint = OpTypePointer Input %v3uint
%_ptr_Input_uint = OpTypePointer Input %uint
%_ptr_Uniform_uint = OpTypePointer Uniform %uint
       %bool = OpTypeBool
     %uint_0 = OpConstant %uint 0
     %uint_1 = OpConstant %uint 1
%gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %15 = OpVariable %_ptr_Uniform__struct_3 Uniform
         %16 = OpVariable %_ptr_Uniform__struct_3 Uniform
         %17 = OpVariable %_ptr_Uniform__struct_3 Uniform
         %18 = OpFunction %void None %6
         %19 = OpLabel
         %20 = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
         %21 = OpLoad %uint %20
         %22 = OpAccessChain %_ptr_Uniform_uint %15 %uint_0 %21
         %23 = OpLoad %uint %22
         %24 = OpAccessChain %_ptr_Uniform_uint %16 %uint_0 %21
         %25 = OpLoad %uint %24
         %26 = OpSLessThan %bool %23 %25
         %27 = OpSelect %uint %26 %uint_1 %uint_0
         %28 = OpAccessChain %_ptr_Uniform_uint %17 %uint_0 %21
               OpStore %28 %27
               OpReturn
               OpFunctionEnd
               OpCapability Shader
               OpMemoryModel Logical GLSL450
               OpEntryPoint GLCompute %18 "main" %gl_GlobalInvocationID
               OpExecutionMode %18 LocalSize 1 1 1
               OpSource OpenCL_C 120
               OpDecorate %_runtimearr_uint ArrayStride 4
               OpMemberDecorate %_struct_3 0 Offset 0
               OpDecorate %_struct_3 BufferBlock
               OpDecorate %gl_GlobalInvocationID BuiltIn GlobalInvocationId
               OpDecorate %15 DescriptorSet 0
               OpDecorate %15 Binding 0
               OpDecorate %16 DescriptorSet 0
               OpDecorate %16 Binding 1
               OpDecorate %17 DescriptorSet 0
               OpDecorate %17 Binding 2
       %uint = OpTypeInt 32 0
%_runtimearr_uint = OpTypeRuntimeArray %uint
  %_struct_3 = OpTypeStruct %_runtimearr_uint
%_ptr_Uniform__struct_3 = OpTypePointer Uniform %_struct_3
       %void = OpTypeVoid
          %6 = OpTypeFunction %void
     %v3uint = OpTypeVector %uint 3
%_ptr_Input_v3uint = OpTypePointer Input %v3uint
%_ptr_Input_uint = OpTypePointer Input %uint
%_ptr_Uniform_uint = OpTypePointer Uniform %uint
       %bool = OpTypeBool
     %uint_0 = OpConstant %uint 0
     %uint_1 = OpConstant %uint 1
%gl_GlobalInvocationID = OpVariable %_ptr_Input_v3uint Input
         %15 = OpVariable %_ptr_Uniform__struct_3 Uniform
         %16 = OpVariable %_ptr_Uniform__struct_3 Uniform
         %17 = OpVariable %_ptr_Uniform__struct_3 Uniform
         %18 = OpFunction %void None %6
         %19 = OpLabel
         %20 = OpAccessChain %_ptr_Input_uint %gl_GlobalInvocationID %uint_0
         %21 = OpLoad %uint %20
         %22 = OpAccessChain %_ptr_Uniform_uint %15 %uint_0 %21
         %23 = OpLoad %uint %22
         %24 = OpAccessChain %_ptr_Uniform_uint %16 %uint_0 %21
         %25 = OpLoad %uint %24
         %26 = OpSLessThanEqual %bool %23 %25
         %27 = OpSelect %uint %26 %uint_1 %uint_0
         %28 = OpAccessChain %_ptr_Uniform_uint %17 %uint_0 %21
               OpStore %28 %27
               OpReturn
               OpFunctionEnd
