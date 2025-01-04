                              OpCapability MeshShadingEXT
                              OpExtension "SPV_EXT_mesh_shader"
                         %1 = OpExtInstImport "GLSL.std.450"
                              OpMemoryModel Logical GLSL450
                              OpEntryPoint MeshEXT %main "main" %local_invocation_index %mesh_vertices %primitive_point_indices %primitive_colors
                              OpExecutionModeId %main LocalSizeId %constand_id_20 %constant_id_21 %constant_id_22
                              OpExecutionMode %main OutputVertices 32
                              OpExecutionMode %main OutputPrimitivesNV 32
                              OpExecutionMode %main OutputPoints
                              OpDecorate %local_invocation_index BuiltIn LocalInvocationIndex
                              OpMemberDecorate %mesh_vertices_struct 0 BuiltIn Position
                              OpMemberDecorate %mesh_vertices_struct 1 BuiltIn PointSize
                              OpMemberDecorate %mesh_vertices_struct 2 BuiltIn ClipDistance
                              OpMemberDecorate %mesh_vertices_struct 3 BuiltIn CullDistance
                              OpDecorate %mesh_vertices_struct Block
                              OpDecorate %primitive_point_indices BuiltIn PrimitivePointIndicesEXT
                              OpDecorate %primitive_colors PerPrimitiveEXT
                              OpDecorate %primitive_colors Location 0
                              OpDecorate %constand_id_20 SpecId 20
                              OpDecorate %constant_id_21 SpecId 21
                              OpDecorate %constant_id_22 SpecId 22
                 %type_void = OpTypeVoid
                 %void_func = OpTypeFunction %type_void
                       %int = OpTypeInt 32 1
                      %uint = OpTypeInt 32 0
                     %float = OpTypeFloat 32
                      %vec4 = OpTypeVector %float 4
                     %uvec3 = OpTypeVector %uint 3
                     %int_0 = OpConstant %int 0
                     %int_1 = OpConstant %int 1
                    %uint_1 = OpConstant %uint 1
                   %uint_32 = OpConstant %uint 32
                   %float_0 = OpConstant %float 0
                   %float_1 = OpConstant %float 1
                 %float_0_5 = OpConstant %float 0.5
                  %float_32 = OpConstant %float 32
                   %float_2 = OpConstant %float 2
             %float_array_1 = OpTypeArray %float %uint_1
             %func_uint_ptr = OpTypePointer Function %uint
            %input_uint_ptr = OpTypePointer Input %uint
    %local_invocation_index = OpVariable %input_uint_ptr Input
      %mesh_vertices_struct = OpTypeStruct %vec4 %float %float_array_1 %float_array_1
       %mesh_vertices_array = OpTypeArray %mesh_vertices_struct %uint_32
     %mesh_vertices_out_ptr = OpTypePointer Output %mesh_vertices_array
             %mesh_vertices = OpVariable %mesh_vertices_out_ptr Output
          %output_float_ptr = OpTypePointer Output %float
           %output_vec4_ptr = OpTypePointer Output %vec4
             %uint_array_32 = OpTypeArray %uint %uint_32

  %output_uint_array_32_ptr = OpTypePointer Output %uint_array_32
   %primitive_point_indices = OpVariable %output_uint_array_32_ptr Output
           %output_uint_ptr = OpTypePointer Output %uint
             %vec4_array_32 = OpTypeArray %vec4 %uint_32
  %output_vec4_array_32_ptr = OpTypePointer Output %vec4_array_32
          %primitive_colors = OpVariable %output_vec4_array_32_ptr Output
                      %blue = OpConstantComposite %vec4 %float_0 %float_0 %float_1 %float_1
            %constand_id_20 = OpSpecConstant %uint 1
            %constant_id_21 = OpSpecConstant %uint 1
            %constant_id_22 = OpSpecConstant %uint 1
                      %main = OpFunction %type_void None %void_func
                %main_label = OpLabel
                  %pixel_id = OpVariable %func_uint_ptr Function
%local_invocation_index_val = OpLoad %uint %local_invocation_index
                              OpStore %pixel_id %local_invocation_index_val
                              OpSetMeshOutputsEXT %uint_32 %uint_32
              %pixel_id_val = OpLoad %uint %pixel_id
                %point_size = OpAccessChain %output_float_ptr %mesh_vertices %pixel_id_val %int_1
                              OpStore %point_size %float_1
        %pixel_id_val_float = OpConvertUToF %float %pixel_id_val
       %pixel_id_val_center = OpFAdd %float %pixel_id_val_float %float_0_5
                   %x_unorm = OpFDiv %float %pixel_id_val_center %float_32
                 %x_unorm_2 = OpFMul %float %x_unorm %float_2
                    %x_norm = OpFSub %float %x_unorm_2 %float_1
                 %point_pos = OpCompositeConstruct %vec4 %x_norm %float_0 %float_0 %float_1
           %gl_position_ptr = OpAccessChain %output_vec4_ptr %mesh_vertices %pixel_id_val %int_0
                              OpStore %gl_position_ptr %point_pos
           %point_index_ptr = OpAccessChain %output_uint_ptr %primitive_point_indices %pixel_id_val
                              OpStore %point_index_ptr %pixel_id_val
           %point_color_ptr = OpAccessChain %output_vec4_ptr %primitive_colors %pixel_id_val
                              OpStore %point_color_ptr %blue
                              OpReturn
                              OpFunctionEnd
#version 450
#extension GL_EXT_mesh_shader : enable

layout (location=0) in perprimitiveEXT vec4 primitiveColor;
layout (location=0) out vec4 outColor;

void main ()
{
    outColor = primitiveColor;
}
                              OpCapability MeshShadingEXT
                              OpExtension "SPV_EXT_mesh_shader"
                         %1 = OpExtInstImport "GLSL.std.450"
                              OpMemoryModel Logical GLSL450
                              OpEntryPoint MeshEXT %main "main" %local_invocation_index %mesh_vertices %primitive_point_indices %primitive_colors %task_data
                              OpExecutionModeId %main LocalSizeId %constand_id_20 %constant_id_21 %constant_id_22
                              OpExecutionMode %main OutputVertices 32
                              OpExecutionMode %main OutputPrimitivesNV 32
                              OpExecutionMode %main OutputPoints
                              OpDecorate %local_invocation_index BuiltIn LocalInvocationIndex
                              OpMemberDecorate %mesh_vertices_struct 0 BuiltIn Position
                              OpMemberDecorate %mesh_vertices_struct 1 BuiltIn PointSize
                              OpMemberDecorate %mesh_vertices_struct 2 BuiltIn ClipDistance
                              OpMemberDecorate %mesh_vertices_struct 3 BuiltIn CullDistance
                              OpDecorate %mesh_vertices_struct Block
                              OpDecorate %primitive_point_indices BuiltIn PrimitivePointIndicesEXT
                              OpDecorate %primitive_colors PerPrimitiveEXT
                              OpDecorate %primitive_colors Location 0
                              OpDecorate %constand_id_20 SpecId 20
                              OpDecorate %constant_id_21 SpecId 21
                              OpDecorate %constant_id_22 SpecId 22
                 %type_void = OpTypeVoid
                 %void_func = OpTypeFunction %type_void
                       %int = OpTypeInt 32 1
                      %uint = OpTypeInt 32 0
                     %float = OpTypeFloat 32
                      %vec4 = OpTypeVector %float 4
                     %uvec3 = OpTypeVector %uint 3
                     %int_0 = OpConstant %int 0
                     %int_1 = OpConstant %int 1
                    %uint_1 = OpConstant %uint 1
                   %uint_32 = OpConstant %uint 32
                   %float_0 = OpConstant %float 0
                   %float_1 = OpConstant %float 1
                 %float_0_5 = OpConstant %float 0.5
                  %float_32 = OpConstant %float 32
                   %float_2 = OpConstant %float 2
             %float_array_1 = OpTypeArray %float %uint_1
             %func_uint_ptr = OpTypePointer Function %uint
            %input_uint_ptr = OpTypePointer Input %uint
    %local_invocation_index = OpVariable %input_uint_ptr Input
      %mesh_vertices_struct = OpTypeStruct %vec4 %float %float_array_1 %float_array_1
       %mesh_vertices_array = OpTypeArray %mesh_vertices_struct %uint_32
     %mesh_vertices_out_ptr = OpTypePointer Output %mesh_vertices_array
             %mesh_vertices = OpVariable %mesh_vertices_out_ptr Output
          %output_float_ptr = OpTypePointer Output %float
           %output_vec4_ptr = OpTypePointer Output %vec4
             %uint_array_32 = OpTypeArray %uint %uint_32


%uint_array_32_struct                  = OpTypeStruct %uint_array_32
%task_payload_uint_array_32_struct_ptr = OpTypePointer TaskPayloadWorkgroupEXT %uint_array_32_struct
%task_data                             = OpVariable %task_payload_uint_array_32_struct_ptr TaskPayloadWorkgroupEXT
%task_payload_uint_ptr                 = OpTypePointer TaskPayloadWorkgroupEXT %uint

  %output_uint_array_32_ptr = OpTypePointer Output %uint_array_32
   %primitive_point_indices = OpVariable %output_uint_array_32_ptr Output
           %output_uint_ptr = OpTypePointer Output %uint
             %vec4_array_32 = OpTypeArray %vec4 %uint_32
  %output_vec4_array_32_ptr = OpTypePointer Output %vec4_array_32
          %primitive_colors = OpVariable %output_vec4_array_32_ptr Output
                      %blue = OpConstantComposite %vec4 %float_0 %float_0 %float_1 %float_1
            %constand_id_20 = OpSpecConstant %uint 1
            %constant_id_21 = OpSpecConstant %uint 1
            %constant_id_22 = OpSpecConstant %uint 1
                      %main = OpFunction %type_void None %void_func
                %main_label = OpLabel
                  %pixel_id = OpVariable %func_uint_ptr Function
%local_invocation_index_val = OpLoad %uint %local_invocation_index
           %td_pixel_id_ptr = OpAccessChain %task_payload_uint_ptr %task_data %int_0 %local_invocation_index_val
           %td_pixel_id_val = OpLoad %uint %td_pixel_id_ptr
                              OpStore %pixel_id %td_pixel_id_val
                              OpSetMeshOutputsEXT %uint_32 %uint_32
              %pixel_id_val = OpLoad %uint %pixel_id
                %point_size = OpAccessChain %output_float_ptr %mesh_vertices %pixel_id_val %int_1
                              OpStore %point_size %float_1
        %pixel_id_val_float = OpConvertUToF %float %pixel_id_val
       %pixel_id_val_center = OpFAdd %float %pixel_id_val_float %float_0_5
                   %x_unorm = OpFDiv %float %pixel_id_val_center %float_32
                 %x_unorm_2 = OpFMul %float %x_unorm %float_2
                    %x_norm = OpFSub %float %x_unorm_2 %float_1
                 %point_pos = OpCompositeConstruct %vec4 %x_norm %float_0 %float_0 %float_1
           %gl_position_ptr = OpAccessChain %output_vec4_ptr %mesh_vertices %pixel_id_val %int_0
                              OpStore %gl_position_ptr %point_pos
           %point_index_ptr = OpAccessChain %output_uint_ptr %primitive_point_indices %pixel_id_val
                              OpStore %point_index_ptr %pixel_id_val
           %point_color_ptr = OpAccessChain %output_vec4_ptr %primitive_colors %pixel_id_val
                              OpStore %point_color_ptr %blue
                              OpReturn
                              OpFunctionEnd
      ; SPIR-V
      ; Version: 1.0
      ; Generator: Khronos Glslang Reference Front End; 10
      ; Bound: 26
      ; Schema: 0
      OpCapability MeshShadingEXT
      OpExtension "SPV_EXT_mesh_shader"
 %1 = OpExtInstImport "GLSL.std.450"
      OpMemoryModel Logical GLSL450
      OpEntryPoint TaskEXT %4 "main" %11 %15
      OpExecutionModeId %4 LocalSizeId %21 %22 %23
      OpDecorate %15 BuiltIn LocalInvocationIndex
      OpDecorate %21 SpecId 10
      OpDecorate %22 SpecId 11
      OpDecorate %23 SpecId 12
 %2 = OpTypeVoid
 %3 = OpTypeFunction %2
 %6 = OpTypeInt 32 0
 %7 = OpConstant %6 32
 %8 = OpTypeArray %6 %7
 %9 = OpTypeStruct %8
%10 = OpTypePointer TaskPayloadWorkgroupEXT %9
%11 = OpVariable %10 TaskPayloadWorkgroupEXT
%12 = OpTypeInt 32 1
%13 = OpConstant %12 0
%14 = OpTypePointer Input %6
%15 = OpVariable %14 Input
%18 = OpTypePointer TaskPayloadWorkgroupEXT %6
%20 = OpConstant %6 1
%21 = OpSpecConstant %6 1
%22 = OpSpecConstant %6 1
%23 = OpSpecConstant %6 1
 %4 = OpFunction %2 None %3
 %5 = OpLabel
%16 = OpLoad %6 %15
%17 = OpLoad %6 %15
%19 = OpAccessChain %18 %11 %13 %16
      OpStore %19 %17
      OpEmitMeshTasksEXT %20 %20 %20 %11
      OpFunctionEnd
