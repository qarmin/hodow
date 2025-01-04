OpCapability Shader
OpExtension "SPV_KHR_non_semantic_info"
%extInstSet = OpExtInstImport "NonSemantic.KHR.DebugInfo"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
%fileStr = OpString "path\to\source.file"
OpSource GLSL 430 %fileStr
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %image DescriptorSet 0
OpDecorate %image Binding 1
OpDecorate %image NonWritable
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 2
OpDecorate %f32arr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer Uniform %buf
%indata    = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id         = OpVariable %uvec3ptr Input
%image_type = OpTypeImage %f32 2D 0 0 0 2 Rgba8
%image_ptr  = OpTypePointer UniformConstant %image_type
%image      = OpVariable %image_ptr UniformConstant
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%idval      = OpLoad %uvec3 %id
%x          = OpCompositeExtract %u32 %idval 0
%inloc      = OpAccessChain %f32ptr %indata %zero %x
%outloc     = OpAccessChain %f32ptr %outdata %zero %x
%inval      = OpLoad %f32 %inloc
%tmp = OpExtInst %void %extInstSet 1 %main %fileStr
             OpStore %outloc %inval
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpExtension "SPV_KHR_non_semantic_info"
%extInstSet = OpExtInstImport "NonSemantic.P.B.NonexistingSet"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
%testStrA = OpString "this.is.test"
%testStrB = OpString "yet another test"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %image DescriptorSet 0
OpDecorate %image Binding 1
OpDecorate %image NonWritable
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 2
OpDecorate %f32arr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer Uniform %buf
%indata    = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id         = OpVariable %uvec3ptr Input
%image_type = OpTypeImage %f32 2D 0 0 0 2 Rgba8
%image_ptr  = OpTypePointer UniformConstant %image_type
%image      = OpVariable %image_ptr UniformConstant
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%idval      = OpLoad %uvec3 %id
%x          = OpCompositeExtract %u32 %idval 0
%inloc      = OpAccessChain %f32ptr %indata %zero %x
%outloc     = OpAccessChain %f32ptr %outdata %zero %x
%inval      = OpLoad %f32 %inloc
%tmpA = OpExtInst %void %extInstSet 55 %id %testStrA %testStrB
OpLine %testStrA 1 1
%tmpB = OpExtInst %void %extInstSet 99 %testStrA %main %testStrA
OpLine %testStrB 2 2
OpNoLine
             OpStore %outloc %inval
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpExtension "SPV_KHR_non_semantic_info"
%extInstSet = OpExtInstImport "NonSemantic.KHR.DebugInfo"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %image DescriptorSet 0
OpDecorate %image Binding 1
OpDecorate %image NonWritable
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 2
OpDecorate %f32arr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer Uniform %buf
%indata    = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id         = OpVariable %uvec3ptr Input
%image_type = OpTypeImage %f32 2D 0 0 0 2 Rgba8
%image_ptr  = OpTypePointer UniformConstant %image_type
%image      = OpVariable %image_ptr UniformConstant
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%idval      = OpLoad %uvec3 %id
%x          = OpCompositeExtract %u32 %idval 0
%inloc      = OpAccessChain %f32ptr %indata %zero %x
%outloc     = OpAccessChain %f32ptr %outdata %zero %x
%inval      = OpLoad %f32 %inloc
%tmpA = OpExtInst %void %extInstSet 4294967294 %main
%tmpB = OpExtInst %void %extInstSet 4294967290 %main
             OpStore %outloc %inval
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpExtension "SPV_KHR_non_semantic_info"
%extInstSet = OpExtInstImport "NonSemantic.KHR.DebugInfo"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
%testStr0 = OpString "0"
%testStr1 = OpString "1"
%testStr2 = OpString "2"
%testStr3 = OpString "3"
%testStr4 = OpString "4"
%testStr5 = OpString "5"
%testStr6 = OpString "6"
%testStr7 = OpString "7"
%testStr8 = OpString "8"
%testStr9 = OpString "9"
%testStr10 = OpString "10"
%testStr11 = OpString "11"
%testStr12 = OpString "12"
%testStr13 = OpString "13"
%testStr14 = OpString "14"
%testStr15 = OpString "15"
%testStr16 = OpString "16"
%testStr17 = OpString "17"
%testStr18 = OpString "18"
%testStr19 = OpString "19"
%testStr20 = OpString "20"
%testStr21 = OpString "21"
%testStr22 = OpString "22"
%testStr23 = OpString "23"
%testStr24 = OpString "24"
%testStr25 = OpString "25"
%testStr26 = OpString "26"
%testStr27 = OpString "27"
%testStr28 = OpString "28"
%testStr29 = OpString "29"
%testStr30 = OpString "30"
%testStr31 = OpString "31"
%testStr32 = OpString "32"
%testStr33 = OpString "33"
%testStr34 = OpString "34"
%testStr35 = OpString "35"
%testStr36 = OpString "36"
%testStr37 = OpString "37"
%testStr38 = OpString "38"
%testStr39 = OpString "39"
%testStr40 = OpString "40"
%testStr41 = OpString "41"
%testStr42 = OpString "42"
%testStr43 = OpString "43"
%testStr44 = OpString "44"
%testStr45 = OpString "45"
%testStr46 = OpString "46"
%testStr47 = OpString "47"
%testStr48 = OpString "48"
%testStr49 = OpString "49"
%testStr50 = OpString "50"
%testStr51 = OpString "51"
%testStr52 = OpString "52"
%testStr53 = OpString "53"
%testStr54 = OpString "54"
%testStr55 = OpString "55"
%testStr56 = OpString "56"
%testStr57 = OpString "57"
%testStr58 = OpString "58"
%testStr59 = OpString "59"
%testStr60 = OpString "60"
%testStr61 = OpString "61"
%testStr62 = OpString "62"
%testStr63 = OpString "63"
%testStr64 = OpString "64"
%testStr65 = OpString "65"
%testStr66 = OpString "66"
%testStr67 = OpString "67"
%testStr68 = OpString "68"
%testStr69 = OpString "69"
%testStr70 = OpString "70"
%testStr71 = OpString "71"
%testStr72 = OpString "72"
%testStr73 = OpString "73"
%testStr74 = OpString "74"
%testStr75 = OpString "75"
%testStr76 = OpString "76"
%testStr77 = OpString "77"
%testStr78 = OpString "78"
%testStr79 = OpString "79"
%testStr80 = OpString "80"
%testStr81 = OpString "81"
%testStr82 = OpString "82"
%testStr83 = OpString "83"
%testStr84 = OpString "84"
%testStr85 = OpString "85"
%testStr86 = OpString "86"
%testStr87 = OpString "87"
%testStr88 = OpString "88"
%testStr89 = OpString "89"
%testStr90 = OpString "90"
%testStr91 = OpString "91"
%testStr92 = OpString "92"
%testStr93 = OpString "93"
%testStr94 = OpString "94"
%testStr95 = OpString "95"
%testStr96 = OpString "96"
%testStr97 = OpString "97"
%testStr98 = OpString "98"
%testStr99 = OpString "99"
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %image DescriptorSet 0
OpDecorate %image Binding 1
OpDecorate %image NonWritable
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 2
OpDecorate %f32arr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer Uniform %buf
%indata    = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id         = OpVariable %uvec3ptr Input
%image_type = OpTypeImage %f32 2D 0 0 0 2 Rgba8
%image_ptr  = OpTypePointer UniformConstant %image_type
%image      = OpVariable %image_ptr UniformConstant
%zero       = OpConstant %i32 0
%main       = OpFunction %void None %voidf
%label      = OpLabel
%idval      = OpLoad %uvec3 %id
%x          = OpCompositeExtract %u32 %idval 0
%inloc      = OpAccessChain %f32ptr %indata %zero %x
%outloc     = OpAccessChain %f32ptr %outdata %zero %x
%inval      = OpLoad %f32 %inloc
%tmp = OpExtInst %void %extInstSet 1234 %testStr0 %testStr1 %testStr2 %testStr3 %testStr4 %testStr5 %testStr6 %testStr7 %testStr8 %testStr9 %testStr10 %testStr11 %testStr12 %testStr13 %testStr14 %testStr15 %testStr16 %testStr17 %testStr18 %testStr19 %testStr20 %testStr21 %testStr22 %testStr23 %testStr24 %testStr25 %testStr26 %testStr27 %testStr28 %testStr29 %testStr30 %testStr31 %testStr32 %testStr33 %testStr34 %testStr35 %testStr36 %testStr37 %testStr38 %testStr39 %testStr40 %testStr41 %testStr42 %testStr43 %testStr44 %testStr45 %testStr46 %testStr47 %testStr48 %testStr49 %testStr50 %testStr51 %testStr52 %testStr53 %testStr54 %testStr55 %testStr56 %testStr57 %testStr58 %testStr59 %testStr60 %testStr61 %testStr62 %testStr63 %testStr64 %testStr65 %testStr66 %testStr67 %testStr68 %testStr69 %testStr70 %testStr71 %testStr72 %testStr73 %testStr74 %testStr75 %testStr76 %testStr77 %testStr78 %testStr79 %testStr80 %testStr81 %testStr82 %testStr83 %testStr84 %testStr85 %testStr86 %testStr87 %testStr88 %testStr89 %testStr90 %testStr91 %testStr92 %testStr93 %testStr94 %testStr95 %testStr96 %testStr97 %testStr98 %testStr99
             OpStore %outloc %inval
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpExtension "SPV_KHR_non_semantic_info"
%extInstSet = OpExtInstImport "NonSemantic.KHR.DebugInfo"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
%testStr = OpString ""
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %image DescriptorSet 0
OpDecorate %image Binding 1
OpDecorate %image NonWritable
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 2
OpDecorate %f32arr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
OpMemberDecorate %struct 0 Offset 0
OpMemberDecorate %struct 1 Offset 4
OpMemberDecorate %struct 2 Offset 16
%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer Uniform %buf
%indata    = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id         = OpVariable %uvec3ptr Input
%image_type = OpTypeImage %f32 2D 0 0 0 2 Rgba8
%image_ptr  = OpTypePointer UniformConstant %image_type
%image      = OpVariable %image_ptr UniformConstant
%zero       = OpConstant %i32 0
%struct             = OpTypeStruct %f32 %fvec3 %i32
%c_array_size       = OpConstant %u32 4
%array4             = OpTypeArray %f32 %c_array_size
%matrix3x3          = OpTypeMatrix %fvec3 3
%undef      = OpUndef %i32
%c_i32      = OpConstant %i32 -45
%c_u32      = OpConstant %u32 99
%c_f32      = OpConstant %f32 0.0
%c_fvec3    = OpConstantComposite %fvec3 %c_f32 %c_f32 %c_f32
%c_struct   = OpConstantComposite %struct %c_f32 %c_fvec3 %undef
%c_array    = OpConstantComposite %array4 %c_f32 %c_f32 %c_f32 %c_f32
%c_matrix   = OpConstantComposite %matrix3x3 %c_fvec3 %c_fvec3 %c_fvec3
%main       = OpFunction %void None %voidf
%label      = OpLabel
%idval      = OpLoad %uvec3 %id
%x          = OpCompositeExtract %u32 %idval 0
%inloc      = OpAccessChain %f32ptr %indata %zero %x
%outloc     = OpAccessChain %f32ptr %outdata %zero %x
%inval      = OpLoad %f32 %inloc
%tmp = OpExtInst %void %extInstSet 999 %main %undef %c_i32 %c_u32 %c_f32 %c_struct %c_fvec3 %c_array %testStr %c_matrix
             OpStore %outloc %inval
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpExtension "SPV_KHR_non_semantic_info"
%extInstSet = OpExtInstImport "NonSemantic.KHR.DebugInfo"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
%testStr = OpString ""
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %image DescriptorSet 0
OpDecorate %image Binding 1
OpDecorate %image NonWritable
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 2
OpDecorate %f32arr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
OpMemberDecorate %struct 0 Offset 0
OpMemberDecorate %struct 1 Offset 4
OpMemberDecorate %struct 2 Offset 16
%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer Uniform %buf
%indata    = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id         = OpVariable %uvec3ptr Input
%image_type = OpTypeImage %f32 2D 0 0 0 2 Rgba8
%image_ptr  = OpTypePointer UniformConstant %image_type
%image      = OpVariable %image_ptr UniformConstant
%zero       = OpConstant %i32 0
%struct             = OpTypeStruct %f32 %fvec3 %i32
%c_array_size       = OpConstant %u32 4
%array4             = OpTypeArray %f32 %c_array_size
%matrix3x3          = OpTypeMatrix %fvec3 3
%undef      = OpUndef %i32
%c_i32      = OpConstant %i32 -45
%c_u32      = OpConstant %u32 99
%c_f32      = OpConstant %f32 0.0
%c_fvec3    = OpConstantComposite %fvec3 %c_f32 %c_f32 %c_f32
%c_struct   = OpConstantComposite %struct %c_f32 %c_fvec3 %undef
%c_array    = OpConstantComposite %array4 %c_f32 %c_f32 %c_f32 %c_f32
%c_matrix   = OpConstantComposite %matrix3x3 %c_fvec3 %c_fvec3 %c_fvec3
%main       = OpFunction %void None %voidf
%label      = OpLabel
%idval      = OpLoad %uvec3 %id
%x          = OpCompositeExtract %u32 %idval 0
%inloc      = OpAccessChain %f32ptr %indata %zero %x
%outloc     = OpAccessChain %f32ptr %outdata %zero %x
%inval      = OpLoad %f32 %inloc
%tmp = OpExtInst %void %extInstSet 999 %main %undef %c_i32 %c_u32 %c_f32 %c_struct %c_fvec3 %c_array %testStr %c_matrix
%tmp01      = OpCompositeExtract %f32 %c_fvec3 2
%tmp02      = OpFAdd %f32 %tmp01 %c_f32
%tmp03      = OpCompositeExtract %f32 %c_struct 0
%tmp04      = OpFAdd %f32 %tmp02 %tmp03
%tmp05      = OpCompositeExtract %f32 %c_array 1
%tmp06      = OpFAdd %f32 %tmp04 %tmp05
%tmp07      = OpCompositeExtract %fvec3 %c_matrix 1
%tmp08      = OpCompositeExtract %f32 %tmp07 1
%tmp09      = OpFMul %f32 %tmp06 %tmp08
%tmp10      = OpConvertSToF %f32 %c_i32
%tmp11      = OpFMul %f32 %tmp09 %tmp10
              OpStore %outloc %tmp11
             OpStore %outloc %inval
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpExtension "SPV_KHR_non_semantic_info"
%extInstSet = OpExtInstImport "NonSemantic.KHR.DebugInfo"
%std450 = OpExtInstImport "GLSL.std.450"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %image DescriptorSet 0
OpDecorate %image Binding 1
OpDecorate %image NonWritable
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 2
OpDecorate %f32arr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
OpMemberDecorate %struct 0 Offset 0
OpMemberDecorate %struct 1 Offset 4
OpMemberDecorate %struct 2 Offset 16
%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer Uniform %buf
%indata    = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id         = OpVariable %uvec3ptr Input
%image_type = OpTypeImage %f32 2D 0 0 0 2 Rgba8
%image_ptr  = OpTypePointer UniformConstant %image_type
%image      = OpVariable %image_ptr UniformConstant
%zero       = OpConstant %i32 0
%struct             = OpTypeStruct %f32 %fvec3 %f32
%struct_ptr         = OpTypePointer Function %struct
%c_array_size       = OpConstant %u32 4
%array4             = OpTypeArray %f32 %c_array_size
%array4_ptr         = OpTypePointer Function %array4
%matrix3x3          = OpTypeMatrix %fvec3 3
%matrix3x3_ptr      = OpTypePointer Function %matrix3x3
%ivec2              = OpTypeVector %i32 2
%fvec4              = OpTypeVector %f32 4
%uv                 = OpConstantComposite %ivec2 %zero %zero
%main       = OpFunction %void None %voidf
%label      = OpLabel
%struct_var = OpVariable %struct_ptr Function
%array_var  = OpVariable %array4_ptr Function
%matrix_var = OpVariable %matrix3x3_ptr Function
%idval      = OpLoad %uvec3 %id
%x          = OpCompositeExtract %u32 %idval 0
%inloc      = OpAccessChain %f32ptr %indata %zero %x
%outloc     = OpAccessChain %f32ptr %outdata %zero %x
%inval      = OpLoad %f32 %inloc
%tmp01      = OpExtInst %void %extInstSet 486 %main %id %x %idval %struct_var %array_var %matrix_var %uvec3ptr %indata
%arithmRes  = OpIAdd %u32 %x %x
%extInstRes = OpExtInst %f32 %std450 FAbs %inval
%logicRes   = OpIsNan %bool %inval
%imgLoadRes = OpLoad %image_type %image
%tmp02      = OpExtInst %void %extInstSet 963 %tmp01 %arithmRes %inloc %outloc %inval %extInstRes %logicRes %imgLoadRes %std450
             OpStore %outloc %inval
             OpReturn
             OpFunctionEnd
OpCapability Shader
OpExtension "SPV_KHR_non_semantic_info"
%extInstSet = OpExtInstImport "NonSemantic.KHR.DebugInfo"
OpMemoryModel Logical GLSL450
OpEntryPoint GLCompute %main "main" %id 
OpExecutionMode %main LocalSize 1 1 1
OpDecorate %id BuiltIn GlobalInvocationId
OpDecorate %buf BufferBlock
OpDecorate %indata DescriptorSet 0
OpDecorate %indata Binding 0
OpDecorate %image DescriptorSet 0
OpDecorate %image Binding 1
OpDecorate %image NonWritable
OpDecorate %outdata DescriptorSet 0
OpDecorate %outdata Binding 2
OpDecorate %f32arr ArrayStride 4
OpMemberDecorate %buf 0 Offset 0
%bool      = OpTypeBool
%void      = OpTypeVoid
%voidf     = OpTypeFunction %void
%u32       = OpTypeInt 32 0
%i32       = OpTypeInt 32 1
%f32       = OpTypeFloat 32
%uvec3     = OpTypeVector %u32 3
%fvec3     = OpTypeVector %f32 3
%uvec3ptr  = OpTypePointer Input %uvec3
%i32ptr    = OpTypePointer Uniform %i32
%f32ptr    = OpTypePointer Uniform %f32
%i32arr    = OpTypeRuntimeArray %i32
%f32arr    = OpTypeRuntimeArray %f32
%buf     = OpTypeStruct %f32arr
%bufptr  = OpTypePointer Uniform %buf
%indata    = OpVariable %bufptr Uniform
%outdata   = OpVariable %bufptr Uniform
%id         = OpVariable %uvec3ptr Input
%image_type = OpTypeImage %f32 2D 0 0 0 2 Rgba8
%image_ptr  = OpTypePointer UniformConstant %image_type
%image      = OpVariable %image_ptr UniformConstant
%zero       = OpConstant %i32 0
%extInstA   = OpExtInst %void %extInstSet 1 %id
%floatf     = OpTypeFunction %f32 %f32
%funDefA    = OpFunction %f32 None %floatf
%funApa     = OpFunctionParameter %f32
%funA       = OpLabel
              OpReturnValue %funApa
              OpFunctionEnd
%extInstB  = OpExtInst %void %extInstSet 3 %id
%main       = OpFunction %void None %voidf
%label      = OpLabel
%idval      = OpLoad %uvec3 %id
%x          = OpCompositeExtract %u32 %idval 0
%inloc      = OpAccessChain %f32ptr %indata %zero %x
%outloc     = OpAccessChain %f32ptr %outdata %zero %x
%inval      = OpLoad %f32 %inloc
%aRes       = OpFunctionCall %f32 %funDefA %inval
%extInstC   = OpExtInst %void %extInstSet 4 %aRes
              OpStore %outloc %aRes
             OpStore %outloc %inval
             OpReturn
             OpFunctionEnd
