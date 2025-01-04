#version 450

layout(location = 0) out vec4 out0;

out gl_PerVertex
{
    vec4  gl_Position;
};

void main(void)
{
    gl_Position  = vec4(0.0, 0.0, 0.0, 1.0);
    float n = 4.0 * float(gl_VertexIndex);
    out0 = vec4(n + 0.0, n + 1.0, n + 2.0, n + 3.0);
}
#version 450

layout(location = 0) out vec4 out0;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main(void)
{
    gl_Position  = vec4(0.0, 0.0, 0.0, 1.0);
    gl_PointSize = 1.0;
    float n = 4.0 * float(gl_VertexIndex);
    out0 = vec4(n + 0.0, n + 1.0, n + 2.0, n + 3.0);
}
#version 450

layout(points) in;
layout(location = 0) in vec4 in0[];

layout(points, max_vertices = 1) out;
layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    out0 = in0[0];
    EmitVertex();
    EndPrimitive();
}
#version 450

layout(points) in;
layout(location = 0) in vec4 in0[];

layout(points, max_vertices = 1) out;
layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    EmitVertex();
    EndPrimitive();
}
#version 450

layout(points) in;
layout(location = 0) in vec4 in0[];

layout(points, max_vertices = 1) out;
layout(stream = 1, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    out0 = in0[0];
    EmitStreamVertex(1);
    EndStreamPrimitive(1);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 64
; Schema: 0
               OpCapability Geometry
               OpCapability TransformFeedback
               OpCapability GeometryStreams
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Geometry %main "main" %outBlock %in0 %InputBuiltInArrayVar %OutputBuiltInsVar
               OpExecutionMode %main Xfb
               OpExecutionMode %main InputPoints
               OpExecutionMode %main Invocations 1
               OpExecutionMode %main OutputPoints
               OpExecutionMode %main OutputVertices 1
               OpSource GLSL 450
               OpSourceExtension "GL_ARB_enhanced_layouts"
               OpName %main "main"
               OpName %OutBlock "OutBlock"
               OpMemberName %OutBlock 0 "out0"
               OpName %outBlock "outBlock"
               OpName %in0 "in0"
               OpMemberDecorate %OutBlock 0 Location 0
               OpMemberDecorate %OutBlock 0 Offset 0
               OpMemberDecorate %OutBlock 0 Stream 1
               OpMemberDecorate %OutBlock 0 XfbBuffer 0
               OpMemberDecorate %OutBlock 0 XfbStride 16
               OpDecorate %OutBlock Block
               OpMemberDecorate %BuiltIns 0 BuiltIn Position
               OpDecorate %BuiltIns Block
               OpDecorate %in0 Location 0
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
   %OutBlock = OpTypeStruct %v4float
%_ptr_Output_OutBlock = OpTypePointer Output %OutBlock
   %outBlock = OpVariable %_ptr_Output_OutBlock Output
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%int_1 = OpConstant %int 1
       %uint = OpTypeInt 32 0
     %uint_0 = OpConstant %uint 1
%_arr_v4float_uint_0 = OpTypeArray %v4float %uint_0
%_ptr_Input__arr_v4float_uint_0 = OpTypePointer Input %_arr_v4float_uint_0
        %in0 = OpVariable %_ptr_Input__arr_v4float_uint_0 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Input_float = OpTypePointer Input %float
%_ptr_Output_v4float = OpTypePointer Output %v4float
%_ptr_Output_float = OpTypePointer Output %float
  %streamNum = OpConstant %int 1
%BuiltIns = OpTypeStruct %v4float
%InputBuiltInArray = OpTypeArray %BuiltIns %int_1
%InputBuiltInArrayPtr = OpTypePointer Input %InputBuiltInArray
%InputBuiltInArrayVar = OpVariable %InputBuiltInArrayPtr Input
%OutputBuiltInsPtr = OpTypePointer Output %BuiltIns
%OutputBuiltInsVar = OpVariable %OutputBuiltInsPtr Output
       %main = OpFunction %void None %3
          %5 = OpLabel
%in_gl_Position_Ptr = OpAccessChain %_ptr_Input_v4float %InputBuiltInArrayVar %int_0 %int_0
%in_gl_Position = OpLoad %v4float %in_gl_Position_Ptr
%out_gl_Position_Ptr = OpAccessChain %_ptr_Output_v4float %OutputBuiltInsVar %int_0
%11 = OpAccessChain %_ptr_Input_v4float %in0 %int_1
          %12 = OpLoad %v4float %11
          %13 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %13 %12
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpEmitStreamVertex %streamNum
               OpEndStreamPrimitive %streamNum
               OpReturn
               OpFunctionEnd
#version 450

layout(points) in;
layout(location = 0) in vec4 in0[];

layout(points, max_vertices = 1) out;
layout(stream = 3, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    out0 = in0[0];
    EmitStreamVertex(3);
    EndStreamPrimitive(3);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 64
; Schema: 0
               OpCapability Geometry
               OpCapability TransformFeedback
               OpCapability GeometryStreams
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Geometry %main "main" %outBlock %in0 %InputBuiltInArrayVar %OutputBuiltInsVar
               OpExecutionMode %main Xfb
               OpExecutionMode %main InputPoints
               OpExecutionMode %main Invocations 1
               OpExecutionMode %main OutputPoints
               OpExecutionMode %main OutputVertices 1
               OpSource GLSL 450
               OpSourceExtension "GL_ARB_enhanced_layouts"
               OpName %main "main"
               OpName %OutBlock "OutBlock"
               OpMemberName %OutBlock 0 "out0"
               OpName %outBlock "outBlock"
               OpName %in0 "in0"
               OpMemberDecorate %OutBlock 0 Location 0
               OpMemberDecorate %OutBlock 0 Offset 0
               OpMemberDecorate %OutBlock 0 Stream 3
               OpMemberDecorate %OutBlock 0 XfbBuffer 0
               OpMemberDecorate %OutBlock 0 XfbStride 16
               OpDecorate %OutBlock Block
               OpMemberDecorate %BuiltIns 0 BuiltIn Position
               OpDecorate %BuiltIns Block
               OpDecorate %in0 Location 0
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
   %OutBlock = OpTypeStruct %v4float
%_ptr_Output_OutBlock = OpTypePointer Output %OutBlock
   %outBlock = OpVariable %_ptr_Output_OutBlock Output
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%int_1 = OpConstant %int 1
       %uint = OpTypeInt 32 0
     %uint_0 = OpConstant %uint 1
%_arr_v4float_uint_0 = OpTypeArray %v4float %uint_0
%_ptr_Input__arr_v4float_uint_0 = OpTypePointer Input %_arr_v4float_uint_0
        %in0 = OpVariable %_ptr_Input__arr_v4float_uint_0 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Input_float = OpTypePointer Input %float
%_ptr_Output_v4float = OpTypePointer Output %v4float
%_ptr_Output_float = OpTypePointer Output %float
  %streamNum = OpConstant %int 3
%BuiltIns = OpTypeStruct %v4float
%InputBuiltInArray = OpTypeArray %BuiltIns %int_1
%InputBuiltInArrayPtr = OpTypePointer Input %InputBuiltInArray
%InputBuiltInArrayVar = OpVariable %InputBuiltInArrayPtr Input
%OutputBuiltInsPtr = OpTypePointer Output %BuiltIns
%OutputBuiltInsVar = OpVariable %OutputBuiltInsPtr Output
       %main = OpFunction %void None %3
          %5 = OpLabel
%in_gl_Position_Ptr = OpAccessChain %_ptr_Input_v4float %InputBuiltInArrayVar %int_0 %int_0
%in_gl_Position = OpLoad %v4float %in_gl_Position_Ptr
%out_gl_Position_Ptr = OpAccessChain %_ptr_Output_v4float %OutputBuiltInsVar %int_0
%11 = OpAccessChain %_ptr_Input_v4float %in0 %int_1
          %12 = OpLoad %v4float %11
          %13 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %13 %12
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpEmitStreamVertex %streamNum
               OpEndStreamPrimitive %streamNum
               OpReturn
               OpFunctionEnd
#version 450

layout(points) in;
layout(location = 0) in vec4 in0[];

layout(points, max_vertices = 1) out;
layout(stream = 6, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    out0 = in0[0];
    EmitStreamVertex(6);
    EndStreamPrimitive(6);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 64
; Schema: 0
               OpCapability Geometry
               OpCapability TransformFeedback
               OpCapability GeometryStreams
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Geometry %main "main" %outBlock %in0 %InputBuiltInArrayVar %OutputBuiltInsVar
               OpExecutionMode %main Xfb
               OpExecutionMode %main InputPoints
               OpExecutionMode %main Invocations 1
               OpExecutionMode %main OutputPoints
               OpExecutionMode %main OutputVertices 1
               OpSource GLSL 450
               OpSourceExtension "GL_ARB_enhanced_layouts"
               OpName %main "main"
               OpName %OutBlock "OutBlock"
               OpMemberName %OutBlock 0 "out0"
               OpName %outBlock "outBlock"
               OpName %in0 "in0"
               OpMemberDecorate %OutBlock 0 Location 0
               OpMemberDecorate %OutBlock 0 Offset 0
               OpMemberDecorate %OutBlock 0 Stream 6
               OpMemberDecorate %OutBlock 0 XfbBuffer 0
               OpMemberDecorate %OutBlock 0 XfbStride 16
               OpDecorate %OutBlock Block
               OpMemberDecorate %BuiltIns 0 BuiltIn Position
               OpDecorate %BuiltIns Block
               OpDecorate %in0 Location 0
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
   %OutBlock = OpTypeStruct %v4float
%_ptr_Output_OutBlock = OpTypePointer Output %OutBlock
   %outBlock = OpVariable %_ptr_Output_OutBlock Output
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%int_1 = OpConstant %int 1
       %uint = OpTypeInt 32 0
     %uint_0 = OpConstant %uint 1
%_arr_v4float_uint_0 = OpTypeArray %v4float %uint_0
%_ptr_Input__arr_v4float_uint_0 = OpTypePointer Input %_arr_v4float_uint_0
        %in0 = OpVariable %_ptr_Input__arr_v4float_uint_0 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Input_float = OpTypePointer Input %float
%_ptr_Output_v4float = OpTypePointer Output %v4float
%_ptr_Output_float = OpTypePointer Output %float
  %streamNum = OpConstant %int 6
%BuiltIns = OpTypeStruct %v4float
%InputBuiltInArray = OpTypeArray %BuiltIns %int_1
%InputBuiltInArrayPtr = OpTypePointer Input %InputBuiltInArray
%InputBuiltInArrayVar = OpVariable %InputBuiltInArrayPtr Input
%OutputBuiltInsPtr = OpTypePointer Output %BuiltIns
%OutputBuiltInsVar = OpVariable %OutputBuiltInsPtr Output
       %main = OpFunction %void None %3
          %5 = OpLabel
%in_gl_Position_Ptr = OpAccessChain %_ptr_Input_v4float %InputBuiltInArrayVar %int_0 %int_0
%in_gl_Position = OpLoad %v4float %in_gl_Position_Ptr
%out_gl_Position_Ptr = OpAccessChain %_ptr_Output_v4float %OutputBuiltInsVar %int_0
%11 = OpAccessChain %_ptr_Input_v4float %in0 %int_1
          %12 = OpLoad %v4float %11
          %13 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %13 %12
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpEmitStreamVertex %streamNum
               OpEndStreamPrimitive %streamNum
               OpReturn
               OpFunctionEnd
#version 450

layout(points) in;
layout(location = 0) in vec4 in0[];

layout(points, max_vertices = 1) out;
layout(stream = 14, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    out0 = in0[0];
    EmitStreamVertex(14);
    EndStreamPrimitive(14);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 64
; Schema: 0
               OpCapability Geometry
               OpCapability TransformFeedback
               OpCapability GeometryStreams
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Geometry %main "main" %outBlock %in0 %InputBuiltInArrayVar %OutputBuiltInsVar
               OpExecutionMode %main Xfb
               OpExecutionMode %main InputPoints
               OpExecutionMode %main Invocations 1
               OpExecutionMode %main OutputPoints
               OpExecutionMode %main OutputVertices 1
               OpSource GLSL 450
               OpSourceExtension "GL_ARB_enhanced_layouts"
               OpName %main "main"
               OpName %OutBlock "OutBlock"
               OpMemberName %OutBlock 0 "out0"
               OpName %outBlock "outBlock"
               OpName %in0 "in0"
               OpMemberDecorate %OutBlock 0 Location 0
               OpMemberDecorate %OutBlock 0 Offset 0
               OpMemberDecorate %OutBlock 0 Stream 14
               OpMemberDecorate %OutBlock 0 XfbBuffer 0
               OpMemberDecorate %OutBlock 0 XfbStride 16
               OpDecorate %OutBlock Block
               OpMemberDecorate %BuiltIns 0 BuiltIn Position
               OpDecorate %BuiltIns Block
               OpDecorate %in0 Location 0
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
   %OutBlock = OpTypeStruct %v4float
%_ptr_Output_OutBlock = OpTypePointer Output %OutBlock
   %outBlock = OpVariable %_ptr_Output_OutBlock Output
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%int_1 = OpConstant %int 1
       %uint = OpTypeInt 32 0
     %uint_0 = OpConstant %uint 1
%_arr_v4float_uint_0 = OpTypeArray %v4float %uint_0
%_ptr_Input__arr_v4float_uint_0 = OpTypePointer Input %_arr_v4float_uint_0
        %in0 = OpVariable %_ptr_Input__arr_v4float_uint_0 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Input_float = OpTypePointer Input %float
%_ptr_Output_v4float = OpTypePointer Output %v4float
%_ptr_Output_float = OpTypePointer Output %float
  %streamNum = OpConstant %int 14
%BuiltIns = OpTypeStruct %v4float
%InputBuiltInArray = OpTypeArray %BuiltIns %int_1
%InputBuiltInArrayPtr = OpTypePointer Input %InputBuiltInArray
%InputBuiltInArrayVar = OpVariable %InputBuiltInArrayPtr Input
%OutputBuiltInsPtr = OpTypePointer Output %BuiltIns
%OutputBuiltInsVar = OpVariable %OutputBuiltInsPtr Output
       %main = OpFunction %void None %3
          %5 = OpLabel
%in_gl_Position_Ptr = OpAccessChain %_ptr_Input_v4float %InputBuiltInArrayVar %int_0 %int_0
%in_gl_Position = OpLoad %v4float %in_gl_Position_Ptr
%out_gl_Position_Ptr = OpAccessChain %_ptr_Output_v4float %OutputBuiltInsVar %int_0
%11 = OpAccessChain %_ptr_Input_v4float %in0 %int_1
          %12 = OpLoad %v4float %11
          %13 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %13 %12
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpEmitStreamVertex %streamNum
               OpEndStreamPrimitive %streamNum
               OpReturn
               OpFunctionEnd
#version 450

layout(points) in;
layout(location = 0) in vec4 in0[];

layout(points, max_vertices = 1) out;
layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;
    out0 = in0[0];
    EmitVertex();
    EndPrimitive();
}
#version 450

layout(points) in;
layout(location = 0) in vec4 in0[];

layout(points, max_vertices = 1) out;
layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;
    EmitVertex();
    EndPrimitive();
}
#version 450

layout(points) in;
layout(location = 0) in vec4 in0[];

layout(points, max_vertices = 1) out;
layout(stream = 1, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;
    out0 = in0[0];
    EmitStreamVertex(1);
    EndStreamPrimitive(1);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 64
; Schema: 0
               OpCapability Geometry
               OpCapability TransformFeedback
               OpCapability GeometryStreams
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Geometry %main "main" %outBlock %in0 %InputBuiltInArrayVar %OutputBuiltInsVar
               OpExecutionMode %main Xfb
               OpExecutionMode %main InputPoints
               OpExecutionMode %main Invocations 1
               OpExecutionMode %main OutputPoints
               OpExecutionMode %main OutputVertices 1
               OpSource GLSL 450
               OpSourceExtension "GL_ARB_enhanced_layouts"
               OpName %main "main"
               OpName %OutBlock "OutBlock"
               OpMemberName %OutBlock 0 "out0"
               OpName %outBlock "outBlock"
               OpName %in0 "in0"
               OpMemberDecorate %OutBlock 0 Location 0
               OpMemberDecorate %OutBlock 0 Offset 0
               OpMemberDecorate %OutBlock 0 Stream 1
               OpMemberDecorate %OutBlock 0 XfbBuffer 0
               OpMemberDecorate %OutBlock 0 XfbStride 16
               OpDecorate %OutBlock Block
               OpMemberDecorate %BuiltIns 0 BuiltIn Position
               OpMemberDecorate %BuiltIns 1 BuiltIn PointSize
               OpDecorate %BuiltIns Block
               OpDecorate %in0 Location 0
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
   %OutBlock = OpTypeStruct %v4float
%_ptr_Output_OutBlock = OpTypePointer Output %OutBlock
   %outBlock = OpVariable %_ptr_Output_OutBlock Output
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%int_1 = OpConstant %int 1
       %uint = OpTypeInt 32 0
     %uint_0 = OpConstant %uint 1
%_arr_v4float_uint_0 = OpTypeArray %v4float %uint_0
%_ptr_Input__arr_v4float_uint_0 = OpTypePointer Input %_arr_v4float_uint_0
        %in0 = OpVariable %_ptr_Input__arr_v4float_uint_0 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Input_float = OpTypePointer Input %float
%_ptr_Output_v4float = OpTypePointer Output %v4float
%_ptr_Output_float = OpTypePointer Output %float
  %streamNum = OpConstant %int 1
%BuiltIns = OpTypeStruct %v4float %float
%InputBuiltInArray = OpTypeArray %BuiltIns %int_1
%InputBuiltInArrayPtr = OpTypePointer Input %InputBuiltInArray
%InputBuiltInArrayVar = OpVariable %InputBuiltInArrayPtr Input
%OutputBuiltInsPtr = OpTypePointer Output %BuiltIns
%OutputBuiltInsVar = OpVariable %OutputBuiltInsPtr Output
       %main = OpFunction %void None %3
          %5 = OpLabel
%in_gl_Position_Ptr = OpAccessChain %_ptr_Input_v4float %InputBuiltInArrayVar %int_0 %int_0
%in_gl_Position = OpLoad %v4float %in_gl_Position_Ptr
%out_gl_Position_Ptr = OpAccessChain %_ptr_Output_v4float %OutputBuiltInsVar %int_0
%in_gl_PointSize_Ptr = OpAccessChain %_ptr_Input_float %InputBuiltInArrayVar %int_0 %int_1
%in_gl_PointSize = OpLoad %float %in_gl_PointSize_Ptr
%out_gl_PointSize_Ptr = OpAccessChain %_ptr_Output_float %OutputBuiltInsVar %int_1
%11 = OpAccessChain %_ptr_Input_v4float %in0 %int_1
          %12 = OpLoad %v4float %11
          %13 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %13 %12
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpStore %out_gl_PointSize_Ptr %in_gl_PointSize
               OpEmitStreamVertex %streamNum
               OpEndStreamPrimitive %streamNum
               OpReturn
               OpFunctionEnd
#version 450

layout(points) in;
layout(location = 0) in vec4 in0[];

layout(points, max_vertices = 1) out;
layout(stream = 3, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;
    out0 = in0[0];
    EmitStreamVertex(3);
    EndStreamPrimitive(3);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 64
; Schema: 0
               OpCapability Geometry
               OpCapability TransformFeedback
               OpCapability GeometryStreams
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Geometry %main "main" %outBlock %in0 %InputBuiltInArrayVar %OutputBuiltInsVar
               OpExecutionMode %main Xfb
               OpExecutionMode %main InputPoints
               OpExecutionMode %main Invocations 1
               OpExecutionMode %main OutputPoints
               OpExecutionMode %main OutputVertices 1
               OpSource GLSL 450
               OpSourceExtension "GL_ARB_enhanced_layouts"
               OpName %main "main"
               OpName %OutBlock "OutBlock"
               OpMemberName %OutBlock 0 "out0"
               OpName %outBlock "outBlock"
               OpName %in0 "in0"
               OpMemberDecorate %OutBlock 0 Location 0
               OpMemberDecorate %OutBlock 0 Offset 0
               OpMemberDecorate %OutBlock 0 Stream 3
               OpMemberDecorate %OutBlock 0 XfbBuffer 0
               OpMemberDecorate %OutBlock 0 XfbStride 16
               OpDecorate %OutBlock Block
               OpMemberDecorate %BuiltIns 0 BuiltIn Position
               OpMemberDecorate %BuiltIns 1 BuiltIn PointSize
               OpDecorate %BuiltIns Block
               OpDecorate %in0 Location 0
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
   %OutBlock = OpTypeStruct %v4float
%_ptr_Output_OutBlock = OpTypePointer Output %OutBlock
   %outBlock = OpVariable %_ptr_Output_OutBlock Output
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%int_1 = OpConstant %int 1
       %uint = OpTypeInt 32 0
     %uint_0 = OpConstant %uint 1
%_arr_v4float_uint_0 = OpTypeArray %v4float %uint_0
%_ptr_Input__arr_v4float_uint_0 = OpTypePointer Input %_arr_v4float_uint_0
        %in0 = OpVariable %_ptr_Input__arr_v4float_uint_0 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Input_float = OpTypePointer Input %float
%_ptr_Output_v4float = OpTypePointer Output %v4float
%_ptr_Output_float = OpTypePointer Output %float
  %streamNum = OpConstant %int 3
%BuiltIns = OpTypeStruct %v4float %float
%InputBuiltInArray = OpTypeArray %BuiltIns %int_1
%InputBuiltInArrayPtr = OpTypePointer Input %InputBuiltInArray
%InputBuiltInArrayVar = OpVariable %InputBuiltInArrayPtr Input
%OutputBuiltInsPtr = OpTypePointer Output %BuiltIns
%OutputBuiltInsVar = OpVariable %OutputBuiltInsPtr Output
       %main = OpFunction %void None %3
          %5 = OpLabel
%in_gl_Position_Ptr = OpAccessChain %_ptr_Input_v4float %InputBuiltInArrayVar %int_0 %int_0
%in_gl_Position = OpLoad %v4float %in_gl_Position_Ptr
%out_gl_Position_Ptr = OpAccessChain %_ptr_Output_v4float %OutputBuiltInsVar %int_0
%in_gl_PointSize_Ptr = OpAccessChain %_ptr_Input_float %InputBuiltInArrayVar %int_0 %int_1
%in_gl_PointSize = OpLoad %float %in_gl_PointSize_Ptr
%out_gl_PointSize_Ptr = OpAccessChain %_ptr_Output_float %OutputBuiltInsVar %int_1
%11 = OpAccessChain %_ptr_Input_v4float %in0 %int_1
          %12 = OpLoad %v4float %11
          %13 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %13 %12
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpStore %out_gl_PointSize_Ptr %in_gl_PointSize
               OpEmitStreamVertex %streamNum
               OpEndStreamPrimitive %streamNum
               OpReturn
               OpFunctionEnd
#version 450

layout(points) in;
layout(location = 0) in vec4 in0[];

layout(points, max_vertices = 1) out;
layout(stream = 6, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;
    out0 = in0[0];
    EmitStreamVertex(6);
    EndStreamPrimitive(6);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 64
; Schema: 0
               OpCapability Geometry
               OpCapability TransformFeedback
               OpCapability GeometryStreams
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Geometry %main "main" %outBlock %in0 %InputBuiltInArrayVar %OutputBuiltInsVar
               OpExecutionMode %main Xfb
               OpExecutionMode %main InputPoints
               OpExecutionMode %main Invocations 1
               OpExecutionMode %main OutputPoints
               OpExecutionMode %main OutputVertices 1
               OpSource GLSL 450
               OpSourceExtension "GL_ARB_enhanced_layouts"
               OpName %main "main"
               OpName %OutBlock "OutBlock"
               OpMemberName %OutBlock 0 "out0"
               OpName %outBlock "outBlock"
               OpName %in0 "in0"
               OpMemberDecorate %OutBlock 0 Location 0
               OpMemberDecorate %OutBlock 0 Offset 0
               OpMemberDecorate %OutBlock 0 Stream 6
               OpMemberDecorate %OutBlock 0 XfbBuffer 0
               OpMemberDecorate %OutBlock 0 XfbStride 16
               OpDecorate %OutBlock Block
               OpMemberDecorate %BuiltIns 0 BuiltIn Position
               OpMemberDecorate %BuiltIns 1 BuiltIn PointSize
               OpDecorate %BuiltIns Block
               OpDecorate %in0 Location 0
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
   %OutBlock = OpTypeStruct %v4float
%_ptr_Output_OutBlock = OpTypePointer Output %OutBlock
   %outBlock = OpVariable %_ptr_Output_OutBlock Output
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%int_1 = OpConstant %int 1
       %uint = OpTypeInt 32 0
     %uint_0 = OpConstant %uint 1
%_arr_v4float_uint_0 = OpTypeArray %v4float %uint_0
%_ptr_Input__arr_v4float_uint_0 = OpTypePointer Input %_arr_v4float_uint_0
        %in0 = OpVariable %_ptr_Input__arr_v4float_uint_0 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Input_float = OpTypePointer Input %float
%_ptr_Output_v4float = OpTypePointer Output %v4float
%_ptr_Output_float = OpTypePointer Output %float
  %streamNum = OpConstant %int 6
%BuiltIns = OpTypeStruct %v4float %float
%InputBuiltInArray = OpTypeArray %BuiltIns %int_1
%InputBuiltInArrayPtr = OpTypePointer Input %InputBuiltInArray
%InputBuiltInArrayVar = OpVariable %InputBuiltInArrayPtr Input
%OutputBuiltInsPtr = OpTypePointer Output %BuiltIns
%OutputBuiltInsVar = OpVariable %OutputBuiltInsPtr Output
       %main = OpFunction %void None %3
          %5 = OpLabel
%in_gl_Position_Ptr = OpAccessChain %_ptr_Input_v4float %InputBuiltInArrayVar %int_0 %int_0
%in_gl_Position = OpLoad %v4float %in_gl_Position_Ptr
%out_gl_Position_Ptr = OpAccessChain %_ptr_Output_v4float %OutputBuiltInsVar %int_0
%in_gl_PointSize_Ptr = OpAccessChain %_ptr_Input_float %InputBuiltInArrayVar %int_0 %int_1
%in_gl_PointSize = OpLoad %float %in_gl_PointSize_Ptr
%out_gl_PointSize_Ptr = OpAccessChain %_ptr_Output_float %OutputBuiltInsVar %int_1
%11 = OpAccessChain %_ptr_Input_v4float %in0 %int_1
          %12 = OpLoad %v4float %11
          %13 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %13 %12
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpStore %out_gl_PointSize_Ptr %in_gl_PointSize
               OpEmitStreamVertex %streamNum
               OpEndStreamPrimitive %streamNum
               OpReturn
               OpFunctionEnd
#version 450

layout(points) in;
layout(location = 0) in vec4 in0[];

layout(points, max_vertices = 1) out;
layout(stream = 14, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;
    out0 = in0[0];
    EmitStreamVertex(14);
    EndStreamPrimitive(14);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 64
; Schema: 0
               OpCapability Geometry
               OpCapability TransformFeedback
               OpCapability GeometryStreams
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Geometry %main "main" %outBlock %in0 %InputBuiltInArrayVar %OutputBuiltInsVar
               OpExecutionMode %main Xfb
               OpExecutionMode %main InputPoints
               OpExecutionMode %main Invocations 1
               OpExecutionMode %main OutputPoints
               OpExecutionMode %main OutputVertices 1
               OpSource GLSL 450
               OpSourceExtension "GL_ARB_enhanced_layouts"
               OpName %main "main"
               OpName %OutBlock "OutBlock"
               OpMemberName %OutBlock 0 "out0"
               OpName %outBlock "outBlock"
               OpName %in0 "in0"
               OpMemberDecorate %OutBlock 0 Location 0
               OpMemberDecorate %OutBlock 0 Offset 0
               OpMemberDecorate %OutBlock 0 Stream 14
               OpMemberDecorate %OutBlock 0 XfbBuffer 0
               OpMemberDecorate %OutBlock 0 XfbStride 16
               OpDecorate %OutBlock Block
               OpMemberDecorate %BuiltIns 0 BuiltIn Position
               OpMemberDecorate %BuiltIns 1 BuiltIn PointSize
               OpDecorate %BuiltIns Block
               OpDecorate %in0 Location 0
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
   %OutBlock = OpTypeStruct %v4float
%_ptr_Output_OutBlock = OpTypePointer Output %OutBlock
   %outBlock = OpVariable %_ptr_Output_OutBlock Output
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%int_1 = OpConstant %int 1
       %uint = OpTypeInt 32 0
     %uint_0 = OpConstant %uint 1
%_arr_v4float_uint_0 = OpTypeArray %v4float %uint_0
%_ptr_Input__arr_v4float_uint_0 = OpTypePointer Input %_arr_v4float_uint_0
        %in0 = OpVariable %_ptr_Input__arr_v4float_uint_0 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Input_float = OpTypePointer Input %float
%_ptr_Output_v4float = OpTypePointer Output %v4float
%_ptr_Output_float = OpTypePointer Output %float
  %streamNum = OpConstant %int 14
%BuiltIns = OpTypeStruct %v4float %float
%InputBuiltInArray = OpTypeArray %BuiltIns %int_1
%InputBuiltInArrayPtr = OpTypePointer Input %InputBuiltInArray
%InputBuiltInArrayVar = OpVariable %InputBuiltInArrayPtr Input
%OutputBuiltInsPtr = OpTypePointer Output %BuiltIns
%OutputBuiltInsVar = OpVariable %OutputBuiltInsPtr Output
       %main = OpFunction %void None %3
          %5 = OpLabel
%in_gl_Position_Ptr = OpAccessChain %_ptr_Input_v4float %InputBuiltInArrayVar %int_0 %int_0
%in_gl_Position = OpLoad %v4float %in_gl_Position_Ptr
%out_gl_Position_Ptr = OpAccessChain %_ptr_Output_v4float %OutputBuiltInsVar %int_0
%in_gl_PointSize_Ptr = OpAccessChain %_ptr_Input_float %InputBuiltInArrayVar %int_0 %int_1
%in_gl_PointSize = OpLoad %float %in_gl_PointSize_Ptr
%out_gl_PointSize_Ptr = OpAccessChain %_ptr_Output_float %OutputBuiltInsVar %int_1
%11 = OpAccessChain %_ptr_Input_v4float %in0 %int_1
          %12 = OpLoad %v4float %11
          %13 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %13 %12
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpStore %out_gl_PointSize_Ptr %in_gl_PointSize
               OpEmitStreamVertex %streamNum
               OpEndStreamPrimitive %streamNum
               OpReturn
               OpFunctionEnd
#version 450

layout(lines) in;
layout(location = 0) in vec4 in0[];

layout(line_strip, max_vertices = 2) out;
layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    out0 = in0[0];
    EmitVertex();
    out0 = in0[1];
    EmitVertex();
    EndPrimitive();
}
#version 450

layout(lines) in;
layout(location = 0) in vec4 in0[];

layout(line_strip, max_vertices = 2) out;
layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    EmitVertex();
    EmitVertex();
    EndPrimitive();
}
#version 450

layout(lines) in;
layout(location = 0) in vec4 in0[];

layout(line_strip, max_vertices = 2) out;
layout(stream = 1, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    out0 = in0[0];
    EmitStreamVertex(1);
    out0 = in0[1];
    EmitStreamVertex(1);
    EndStreamPrimitive(1);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 64
; Schema: 0
               OpCapability Geometry
               OpCapability TransformFeedback
               OpCapability GeometryStreams
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Geometry %main "main" %outBlock %in0 %InputBuiltInArrayVar %OutputBuiltInsVar
               OpExecutionMode %main Xfb
               OpExecutionMode %main InputLines
               OpExecutionMode %main Invocations 1
               OpExecutionMode %main OutputLineStrip
               OpExecutionMode %main OutputVertices 2
               OpSource GLSL 450
               OpSourceExtension "GL_ARB_enhanced_layouts"
               OpName %main "main"
               OpName %OutBlock "OutBlock"
               OpMemberName %OutBlock 0 "out0"
               OpName %outBlock "outBlock"
               OpName %in0 "in0"
               OpMemberDecorate %OutBlock 0 Location 0
               OpMemberDecorate %OutBlock 0 Offset 0
               OpMemberDecorate %OutBlock 0 Stream 1
               OpMemberDecorate %OutBlock 0 XfbBuffer 0
               OpMemberDecorate %OutBlock 0 XfbStride 16
               OpDecorate %OutBlock Block
               OpMemberDecorate %BuiltIns 0 BuiltIn Position
               OpDecorate %BuiltIns Block
               OpDecorate %in0 Location 0
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
   %OutBlock = OpTypeStruct %v4float
%_ptr_Output_OutBlock = OpTypePointer Output %OutBlock
   %outBlock = OpVariable %_ptr_Output_OutBlock Output
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%int_1 = OpConstant %int 1
%int_2 = OpConstant %int 2
       %uint = OpTypeInt 32 0
     %uint_0 = OpConstant %uint 2
%_arr_v4float_uint_0 = OpTypeArray %v4float %uint_0
%_ptr_Input__arr_v4float_uint_0 = OpTypePointer Input %_arr_v4float_uint_0
        %in0 = OpVariable %_ptr_Input__arr_v4float_uint_0 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Input_float = OpTypePointer Input %float
%_ptr_Output_v4float = OpTypePointer Output %v4float
%_ptr_Output_float = OpTypePointer Output %float
  %streamNum = OpConstant %int 1
%BuiltIns = OpTypeStruct %v4float
%InputBuiltInArray = OpTypeArray %BuiltIns %int_1
%InputBuiltInArrayPtr = OpTypePointer Input %InputBuiltInArray
%InputBuiltInArrayVar = OpVariable %InputBuiltInArrayPtr Input
%OutputBuiltInsPtr = OpTypePointer Output %BuiltIns
%OutputBuiltInsVar = OpVariable %OutputBuiltInsPtr Output
       %main = OpFunction %void None %3
          %5 = OpLabel
%in_gl_Position_Ptr = OpAccessChain %_ptr_Input_v4float %InputBuiltInArrayVar %int_0 %int_0
%in_gl_Position = OpLoad %v4float %in_gl_Position_Ptr
%out_gl_Position_Ptr = OpAccessChain %_ptr_Output_v4float %OutputBuiltInsVar %int_0
%11 = OpAccessChain %_ptr_Input_v4float %in0 %int_1
          %12 = OpLoad %v4float %11
          %13 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %13 %12
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpEmitStreamVertex %streamNum
%21 = OpAccessChain %_ptr_Input_v4float %in0 %int_2
          %22 = OpLoad %v4float %21
          %23 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %23 %22
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpEmitStreamVertex %streamNum
               OpEndStreamPrimitive %streamNum
               OpReturn
               OpFunctionEnd
#version 450

layout(lines) in;
layout(location = 0) in vec4 in0[];

layout(line_strip, max_vertices = 2) out;
layout(stream = 3, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    out0 = in0[0];
    EmitStreamVertex(3);
    out0 = in0[1];
    EmitStreamVertex(3);
    EndStreamPrimitive(3);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 64
; Schema: 0
               OpCapability Geometry
               OpCapability TransformFeedback
               OpCapability GeometryStreams
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Geometry %main "main" %outBlock %in0 %InputBuiltInArrayVar %OutputBuiltInsVar
               OpExecutionMode %main Xfb
               OpExecutionMode %main InputLines
               OpExecutionMode %main Invocations 1
               OpExecutionMode %main OutputLineStrip
               OpExecutionMode %main OutputVertices 2
               OpSource GLSL 450
               OpSourceExtension "GL_ARB_enhanced_layouts"
               OpName %main "main"
               OpName %OutBlock "OutBlock"
               OpMemberName %OutBlock 0 "out0"
               OpName %outBlock "outBlock"
               OpName %in0 "in0"
               OpMemberDecorate %OutBlock 0 Location 0
               OpMemberDecorate %OutBlock 0 Offset 0
               OpMemberDecorate %OutBlock 0 Stream 3
               OpMemberDecorate %OutBlock 0 XfbBuffer 0
               OpMemberDecorate %OutBlock 0 XfbStride 16
               OpDecorate %OutBlock Block
               OpMemberDecorate %BuiltIns 0 BuiltIn Position
               OpDecorate %BuiltIns Block
               OpDecorate %in0 Location 0
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
   %OutBlock = OpTypeStruct %v4float
%_ptr_Output_OutBlock = OpTypePointer Output %OutBlock
   %outBlock = OpVariable %_ptr_Output_OutBlock Output
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%int_1 = OpConstant %int 1
%int_2 = OpConstant %int 2
       %uint = OpTypeInt 32 0
     %uint_0 = OpConstant %uint 2
%_arr_v4float_uint_0 = OpTypeArray %v4float %uint_0
%_ptr_Input__arr_v4float_uint_0 = OpTypePointer Input %_arr_v4float_uint_0
        %in0 = OpVariable %_ptr_Input__arr_v4float_uint_0 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Input_float = OpTypePointer Input %float
%_ptr_Output_v4float = OpTypePointer Output %v4float
%_ptr_Output_float = OpTypePointer Output %float
  %streamNum = OpConstant %int 3
%BuiltIns = OpTypeStruct %v4float
%InputBuiltInArray = OpTypeArray %BuiltIns %int_1
%InputBuiltInArrayPtr = OpTypePointer Input %InputBuiltInArray
%InputBuiltInArrayVar = OpVariable %InputBuiltInArrayPtr Input
%OutputBuiltInsPtr = OpTypePointer Output %BuiltIns
%OutputBuiltInsVar = OpVariable %OutputBuiltInsPtr Output
       %main = OpFunction %void None %3
          %5 = OpLabel
%in_gl_Position_Ptr = OpAccessChain %_ptr_Input_v4float %InputBuiltInArrayVar %int_0 %int_0
%in_gl_Position = OpLoad %v4float %in_gl_Position_Ptr
%out_gl_Position_Ptr = OpAccessChain %_ptr_Output_v4float %OutputBuiltInsVar %int_0
%11 = OpAccessChain %_ptr_Input_v4float %in0 %int_1
          %12 = OpLoad %v4float %11
          %13 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %13 %12
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpEmitStreamVertex %streamNum
%21 = OpAccessChain %_ptr_Input_v4float %in0 %int_2
          %22 = OpLoad %v4float %21
          %23 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %23 %22
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpEmitStreamVertex %streamNum
               OpEndStreamPrimitive %streamNum
               OpReturn
               OpFunctionEnd
#version 450

layout(lines) in;
layout(location = 0) in vec4 in0[];

layout(line_strip, max_vertices = 2) out;
layout(stream = 6, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    out0 = in0[0];
    EmitStreamVertex(6);
    out0 = in0[1];
    EmitStreamVertex(6);
    EndStreamPrimitive(6);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 64
; Schema: 0
               OpCapability Geometry
               OpCapability TransformFeedback
               OpCapability GeometryStreams
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Geometry %main "main" %outBlock %in0 %InputBuiltInArrayVar %OutputBuiltInsVar
               OpExecutionMode %main Xfb
               OpExecutionMode %main InputLines
               OpExecutionMode %main Invocations 1
               OpExecutionMode %main OutputLineStrip
               OpExecutionMode %main OutputVertices 2
               OpSource GLSL 450
               OpSourceExtension "GL_ARB_enhanced_layouts"
               OpName %main "main"
               OpName %OutBlock "OutBlock"
               OpMemberName %OutBlock 0 "out0"
               OpName %outBlock "outBlock"
               OpName %in0 "in0"
               OpMemberDecorate %OutBlock 0 Location 0
               OpMemberDecorate %OutBlock 0 Offset 0
               OpMemberDecorate %OutBlock 0 Stream 6
               OpMemberDecorate %OutBlock 0 XfbBuffer 0
               OpMemberDecorate %OutBlock 0 XfbStride 16
               OpDecorate %OutBlock Block
               OpMemberDecorate %BuiltIns 0 BuiltIn Position
               OpDecorate %BuiltIns Block
               OpDecorate %in0 Location 0
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
   %OutBlock = OpTypeStruct %v4float
%_ptr_Output_OutBlock = OpTypePointer Output %OutBlock
   %outBlock = OpVariable %_ptr_Output_OutBlock Output
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%int_1 = OpConstant %int 1
%int_2 = OpConstant %int 2
       %uint = OpTypeInt 32 0
     %uint_0 = OpConstant %uint 2
%_arr_v4float_uint_0 = OpTypeArray %v4float %uint_0
%_ptr_Input__arr_v4float_uint_0 = OpTypePointer Input %_arr_v4float_uint_0
        %in0 = OpVariable %_ptr_Input__arr_v4float_uint_0 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Input_float = OpTypePointer Input %float
%_ptr_Output_v4float = OpTypePointer Output %v4float
%_ptr_Output_float = OpTypePointer Output %float
  %streamNum = OpConstant %int 6
%BuiltIns = OpTypeStruct %v4float
%InputBuiltInArray = OpTypeArray %BuiltIns %int_1
%InputBuiltInArrayPtr = OpTypePointer Input %InputBuiltInArray
%InputBuiltInArrayVar = OpVariable %InputBuiltInArrayPtr Input
%OutputBuiltInsPtr = OpTypePointer Output %BuiltIns
%OutputBuiltInsVar = OpVariable %OutputBuiltInsPtr Output
       %main = OpFunction %void None %3
          %5 = OpLabel
%in_gl_Position_Ptr = OpAccessChain %_ptr_Input_v4float %InputBuiltInArrayVar %int_0 %int_0
%in_gl_Position = OpLoad %v4float %in_gl_Position_Ptr
%out_gl_Position_Ptr = OpAccessChain %_ptr_Output_v4float %OutputBuiltInsVar %int_0
%11 = OpAccessChain %_ptr_Input_v4float %in0 %int_1
          %12 = OpLoad %v4float %11
          %13 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %13 %12
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpEmitStreamVertex %streamNum
%21 = OpAccessChain %_ptr_Input_v4float %in0 %int_2
          %22 = OpLoad %v4float %21
          %23 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %23 %22
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpEmitStreamVertex %streamNum
               OpEndStreamPrimitive %streamNum
               OpReturn
               OpFunctionEnd
#version 450

layout(lines) in;
layout(location = 0) in vec4 in0[];

layout(line_strip, max_vertices = 2) out;
layout(stream = 14, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    out0 = in0[0];
    EmitStreamVertex(14);
    out0 = in0[1];
    EmitStreamVertex(14);
    EndStreamPrimitive(14);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 64
; Schema: 0
               OpCapability Geometry
               OpCapability TransformFeedback
               OpCapability GeometryStreams
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Geometry %main "main" %outBlock %in0 %InputBuiltInArrayVar %OutputBuiltInsVar
               OpExecutionMode %main Xfb
               OpExecutionMode %main InputLines
               OpExecutionMode %main Invocations 1
               OpExecutionMode %main OutputLineStrip
               OpExecutionMode %main OutputVertices 2
               OpSource GLSL 450
               OpSourceExtension "GL_ARB_enhanced_layouts"
               OpName %main "main"
               OpName %OutBlock "OutBlock"
               OpMemberName %OutBlock 0 "out0"
               OpName %outBlock "outBlock"
               OpName %in0 "in0"
               OpMemberDecorate %OutBlock 0 Location 0
               OpMemberDecorate %OutBlock 0 Offset 0
               OpMemberDecorate %OutBlock 0 Stream 14
               OpMemberDecorate %OutBlock 0 XfbBuffer 0
               OpMemberDecorate %OutBlock 0 XfbStride 16
               OpDecorate %OutBlock Block
               OpMemberDecorate %BuiltIns 0 BuiltIn Position
               OpDecorate %BuiltIns Block
               OpDecorate %in0 Location 0
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
   %OutBlock = OpTypeStruct %v4float
%_ptr_Output_OutBlock = OpTypePointer Output %OutBlock
   %outBlock = OpVariable %_ptr_Output_OutBlock Output
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%int_1 = OpConstant %int 1
%int_2 = OpConstant %int 2
       %uint = OpTypeInt 32 0
     %uint_0 = OpConstant %uint 2
%_arr_v4float_uint_0 = OpTypeArray %v4float %uint_0
%_ptr_Input__arr_v4float_uint_0 = OpTypePointer Input %_arr_v4float_uint_0
        %in0 = OpVariable %_ptr_Input__arr_v4float_uint_0 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Input_float = OpTypePointer Input %float
%_ptr_Output_v4float = OpTypePointer Output %v4float
%_ptr_Output_float = OpTypePointer Output %float
  %streamNum = OpConstant %int 14
%BuiltIns = OpTypeStruct %v4float
%InputBuiltInArray = OpTypeArray %BuiltIns %int_1
%InputBuiltInArrayPtr = OpTypePointer Input %InputBuiltInArray
%InputBuiltInArrayVar = OpVariable %InputBuiltInArrayPtr Input
%OutputBuiltInsPtr = OpTypePointer Output %BuiltIns
%OutputBuiltInsVar = OpVariable %OutputBuiltInsPtr Output
       %main = OpFunction %void None %3
          %5 = OpLabel
%in_gl_Position_Ptr = OpAccessChain %_ptr_Input_v4float %InputBuiltInArrayVar %int_0 %int_0
%in_gl_Position = OpLoad %v4float %in_gl_Position_Ptr
%out_gl_Position_Ptr = OpAccessChain %_ptr_Output_v4float %OutputBuiltInsVar %int_0
%11 = OpAccessChain %_ptr_Input_v4float %in0 %int_1
          %12 = OpLoad %v4float %11
          %13 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %13 %12
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpEmitStreamVertex %streamNum
%21 = OpAccessChain %_ptr_Input_v4float %in0 %int_2
          %22 = OpLoad %v4float %21
          %23 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %23 %22
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpEmitStreamVertex %streamNum
               OpEndStreamPrimitive %streamNum
               OpReturn
               OpFunctionEnd
#version 450

layout(lines) in;
layout(location = 0) in vec4 in0[];

layout(line_strip, max_vertices = 2) out;
layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;
    out0 = in0[0];
    EmitVertex();
    out0 = in0[1];
    EmitVertex();
    EndPrimitive();
}
#version 450

layout(lines) in;
layout(location = 0) in vec4 in0[];

layout(line_strip, max_vertices = 2) out;
layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;
    EmitVertex();
    EmitVertex();
    EndPrimitive();
}
#version 450

layout(lines) in;
layout(location = 0) in vec4 in0[];

layout(line_strip, max_vertices = 2) out;
layout(stream = 1, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;
    out0 = in0[0];
    EmitStreamVertex(1);
    out0 = in0[1];
    EmitStreamVertex(1);
    EndStreamPrimitive(1);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 64
; Schema: 0
               OpCapability Geometry
               OpCapability TransformFeedback
               OpCapability GeometryStreams
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Geometry %main "main" %outBlock %in0 %InputBuiltInArrayVar %OutputBuiltInsVar
               OpExecutionMode %main Xfb
               OpExecutionMode %main InputLines
               OpExecutionMode %main Invocations 1
               OpExecutionMode %main OutputLineStrip
               OpExecutionMode %main OutputVertices 2
               OpSource GLSL 450
               OpSourceExtension "GL_ARB_enhanced_layouts"
               OpName %main "main"
               OpName %OutBlock "OutBlock"
               OpMemberName %OutBlock 0 "out0"
               OpName %outBlock "outBlock"
               OpName %in0 "in0"
               OpMemberDecorate %OutBlock 0 Location 0
               OpMemberDecorate %OutBlock 0 Offset 0
               OpMemberDecorate %OutBlock 0 Stream 1
               OpMemberDecorate %OutBlock 0 XfbBuffer 0
               OpMemberDecorate %OutBlock 0 XfbStride 16
               OpDecorate %OutBlock Block
               OpMemberDecorate %BuiltIns 0 BuiltIn Position
               OpMemberDecorate %BuiltIns 1 BuiltIn PointSize
               OpDecorate %BuiltIns Block
               OpDecorate %in0 Location 0
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
   %OutBlock = OpTypeStruct %v4float
%_ptr_Output_OutBlock = OpTypePointer Output %OutBlock
   %outBlock = OpVariable %_ptr_Output_OutBlock Output
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%int_1 = OpConstant %int 1
%int_2 = OpConstant %int 2
       %uint = OpTypeInt 32 0
     %uint_0 = OpConstant %uint 2
%_arr_v4float_uint_0 = OpTypeArray %v4float %uint_0
%_ptr_Input__arr_v4float_uint_0 = OpTypePointer Input %_arr_v4float_uint_0
        %in0 = OpVariable %_ptr_Input__arr_v4float_uint_0 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Input_float = OpTypePointer Input %float
%_ptr_Output_v4float = OpTypePointer Output %v4float
%_ptr_Output_float = OpTypePointer Output %float
  %streamNum = OpConstant %int 1
%BuiltIns = OpTypeStruct %v4float %float
%InputBuiltInArray = OpTypeArray %BuiltIns %int_1
%InputBuiltInArrayPtr = OpTypePointer Input %InputBuiltInArray
%InputBuiltInArrayVar = OpVariable %InputBuiltInArrayPtr Input
%OutputBuiltInsPtr = OpTypePointer Output %BuiltIns
%OutputBuiltInsVar = OpVariable %OutputBuiltInsPtr Output
       %main = OpFunction %void None %3
          %5 = OpLabel
%in_gl_Position_Ptr = OpAccessChain %_ptr_Input_v4float %InputBuiltInArrayVar %int_0 %int_0
%in_gl_Position = OpLoad %v4float %in_gl_Position_Ptr
%out_gl_Position_Ptr = OpAccessChain %_ptr_Output_v4float %OutputBuiltInsVar %int_0
%in_gl_PointSize_Ptr = OpAccessChain %_ptr_Input_float %InputBuiltInArrayVar %int_0 %int_1
%in_gl_PointSize = OpLoad %float %in_gl_PointSize_Ptr
%out_gl_PointSize_Ptr = OpAccessChain %_ptr_Output_float %OutputBuiltInsVar %int_1
%11 = OpAccessChain %_ptr_Input_v4float %in0 %int_1
          %12 = OpLoad %v4float %11
          %13 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %13 %12
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpStore %out_gl_PointSize_Ptr %in_gl_PointSize
               OpEmitStreamVertex %streamNum
%21 = OpAccessChain %_ptr_Input_v4float %in0 %int_2
          %22 = OpLoad %v4float %21
          %23 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %23 %22
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpStore %out_gl_PointSize_Ptr %in_gl_PointSize
               OpEmitStreamVertex %streamNum
               OpEndStreamPrimitive %streamNum
               OpReturn
               OpFunctionEnd
#version 450

layout(lines) in;
layout(location = 0) in vec4 in0[];

layout(line_strip, max_vertices = 2) out;
layout(stream = 3, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;
    out0 = in0[0];
    EmitStreamVertex(3);
    out0 = in0[1];
    EmitStreamVertex(3);
    EndStreamPrimitive(3);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 64
; Schema: 0
               OpCapability Geometry
               OpCapability TransformFeedback
               OpCapability GeometryStreams
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Geometry %main "main" %outBlock %in0 %InputBuiltInArrayVar %OutputBuiltInsVar
               OpExecutionMode %main Xfb
               OpExecutionMode %main InputLines
               OpExecutionMode %main Invocations 1
               OpExecutionMode %main OutputLineStrip
               OpExecutionMode %main OutputVertices 2
               OpSource GLSL 450
               OpSourceExtension "GL_ARB_enhanced_layouts"
               OpName %main "main"
               OpName %OutBlock "OutBlock"
               OpMemberName %OutBlock 0 "out0"
               OpName %outBlock "outBlock"
               OpName %in0 "in0"
               OpMemberDecorate %OutBlock 0 Location 0
               OpMemberDecorate %OutBlock 0 Offset 0
               OpMemberDecorate %OutBlock 0 Stream 3
               OpMemberDecorate %OutBlock 0 XfbBuffer 0
               OpMemberDecorate %OutBlock 0 XfbStride 16
               OpDecorate %OutBlock Block
               OpMemberDecorate %BuiltIns 0 BuiltIn Position
               OpMemberDecorate %BuiltIns 1 BuiltIn PointSize
               OpDecorate %BuiltIns Block
               OpDecorate %in0 Location 0
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
   %OutBlock = OpTypeStruct %v4float
%_ptr_Output_OutBlock = OpTypePointer Output %OutBlock
   %outBlock = OpVariable %_ptr_Output_OutBlock Output
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%int_1 = OpConstant %int 1
%int_2 = OpConstant %int 2
       %uint = OpTypeInt 32 0
     %uint_0 = OpConstant %uint 2
%_arr_v4float_uint_0 = OpTypeArray %v4float %uint_0
%_ptr_Input__arr_v4float_uint_0 = OpTypePointer Input %_arr_v4float_uint_0
        %in0 = OpVariable %_ptr_Input__arr_v4float_uint_0 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Input_float = OpTypePointer Input %float
%_ptr_Output_v4float = OpTypePointer Output %v4float
%_ptr_Output_float = OpTypePointer Output %float
  %streamNum = OpConstant %int 3
%BuiltIns = OpTypeStruct %v4float %float
%InputBuiltInArray = OpTypeArray %BuiltIns %int_1
%InputBuiltInArrayPtr = OpTypePointer Input %InputBuiltInArray
%InputBuiltInArrayVar = OpVariable %InputBuiltInArrayPtr Input
%OutputBuiltInsPtr = OpTypePointer Output %BuiltIns
%OutputBuiltInsVar = OpVariable %OutputBuiltInsPtr Output
       %main = OpFunction %void None %3
          %5 = OpLabel
%in_gl_Position_Ptr = OpAccessChain %_ptr_Input_v4float %InputBuiltInArrayVar %int_0 %int_0
%in_gl_Position = OpLoad %v4float %in_gl_Position_Ptr
%out_gl_Position_Ptr = OpAccessChain %_ptr_Output_v4float %OutputBuiltInsVar %int_0
%in_gl_PointSize_Ptr = OpAccessChain %_ptr_Input_float %InputBuiltInArrayVar %int_0 %int_1
%in_gl_PointSize = OpLoad %float %in_gl_PointSize_Ptr
%out_gl_PointSize_Ptr = OpAccessChain %_ptr_Output_float %OutputBuiltInsVar %int_1
%11 = OpAccessChain %_ptr_Input_v4float %in0 %int_1
          %12 = OpLoad %v4float %11
          %13 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %13 %12
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpStore %out_gl_PointSize_Ptr %in_gl_PointSize
               OpEmitStreamVertex %streamNum
%21 = OpAccessChain %_ptr_Input_v4float %in0 %int_2
          %22 = OpLoad %v4float %21
          %23 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %23 %22
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpStore %out_gl_PointSize_Ptr %in_gl_PointSize
               OpEmitStreamVertex %streamNum
               OpEndStreamPrimitive %streamNum
               OpReturn
               OpFunctionEnd
#version 450

layout(lines) in;
layout(location = 0) in vec4 in0[];

layout(line_strip, max_vertices = 2) out;
layout(stream = 6, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;
    out0 = in0[0];
    EmitStreamVertex(6);
    out0 = in0[1];
    EmitStreamVertex(6);
    EndStreamPrimitive(6);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 64
; Schema: 0
               OpCapability Geometry
               OpCapability TransformFeedback
               OpCapability GeometryStreams
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Geometry %main "main" %outBlock %in0 %InputBuiltInArrayVar %OutputBuiltInsVar
               OpExecutionMode %main Xfb
               OpExecutionMode %main InputLines
               OpExecutionMode %main Invocations 1
               OpExecutionMode %main OutputLineStrip
               OpExecutionMode %main OutputVertices 2
               OpSource GLSL 450
               OpSourceExtension "GL_ARB_enhanced_layouts"
               OpName %main "main"
               OpName %OutBlock "OutBlock"
               OpMemberName %OutBlock 0 "out0"
               OpName %outBlock "outBlock"
               OpName %in0 "in0"
               OpMemberDecorate %OutBlock 0 Location 0
               OpMemberDecorate %OutBlock 0 Offset 0
               OpMemberDecorate %OutBlock 0 Stream 6
               OpMemberDecorate %OutBlock 0 XfbBuffer 0
               OpMemberDecorate %OutBlock 0 XfbStride 16
               OpDecorate %OutBlock Block
               OpMemberDecorate %BuiltIns 0 BuiltIn Position
               OpMemberDecorate %BuiltIns 1 BuiltIn PointSize
               OpDecorate %BuiltIns Block
               OpDecorate %in0 Location 0
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
   %OutBlock = OpTypeStruct %v4float
%_ptr_Output_OutBlock = OpTypePointer Output %OutBlock
   %outBlock = OpVariable %_ptr_Output_OutBlock Output
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%int_1 = OpConstant %int 1
%int_2 = OpConstant %int 2
       %uint = OpTypeInt 32 0
     %uint_0 = OpConstant %uint 2
%_arr_v4float_uint_0 = OpTypeArray %v4float %uint_0
%_ptr_Input__arr_v4float_uint_0 = OpTypePointer Input %_arr_v4float_uint_0
        %in0 = OpVariable %_ptr_Input__arr_v4float_uint_0 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Input_float = OpTypePointer Input %float
%_ptr_Output_v4float = OpTypePointer Output %v4float
%_ptr_Output_float = OpTypePointer Output %float
  %streamNum = OpConstant %int 6
%BuiltIns = OpTypeStruct %v4float %float
%InputBuiltInArray = OpTypeArray %BuiltIns %int_1
%InputBuiltInArrayPtr = OpTypePointer Input %InputBuiltInArray
%InputBuiltInArrayVar = OpVariable %InputBuiltInArrayPtr Input
%OutputBuiltInsPtr = OpTypePointer Output %BuiltIns
%OutputBuiltInsVar = OpVariable %OutputBuiltInsPtr Output
       %main = OpFunction %void None %3
          %5 = OpLabel
%in_gl_Position_Ptr = OpAccessChain %_ptr_Input_v4float %InputBuiltInArrayVar %int_0 %int_0
%in_gl_Position = OpLoad %v4float %in_gl_Position_Ptr
%out_gl_Position_Ptr = OpAccessChain %_ptr_Output_v4float %OutputBuiltInsVar %int_0
%in_gl_PointSize_Ptr = OpAccessChain %_ptr_Input_float %InputBuiltInArrayVar %int_0 %int_1
%in_gl_PointSize = OpLoad %float %in_gl_PointSize_Ptr
%out_gl_PointSize_Ptr = OpAccessChain %_ptr_Output_float %OutputBuiltInsVar %int_1
%11 = OpAccessChain %_ptr_Input_v4float %in0 %int_1
          %12 = OpLoad %v4float %11
          %13 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %13 %12
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpStore %out_gl_PointSize_Ptr %in_gl_PointSize
               OpEmitStreamVertex %streamNum
%21 = OpAccessChain %_ptr_Input_v4float %in0 %int_2
          %22 = OpLoad %v4float %21
          %23 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %23 %22
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpStore %out_gl_PointSize_Ptr %in_gl_PointSize
               OpEmitStreamVertex %streamNum
               OpEndStreamPrimitive %streamNum
               OpReturn
               OpFunctionEnd
#version 450

layout(lines) in;
layout(location = 0) in vec4 in0[];

layout(line_strip, max_vertices = 2) out;
layout(stream = 14, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;
    out0 = in0[0];
    EmitStreamVertex(14);
    out0 = in0[1];
    EmitStreamVertex(14);
    EndStreamPrimitive(14);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 64
; Schema: 0
               OpCapability Geometry
               OpCapability TransformFeedback
               OpCapability GeometryStreams
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Geometry %main "main" %outBlock %in0 %InputBuiltInArrayVar %OutputBuiltInsVar
               OpExecutionMode %main Xfb
               OpExecutionMode %main InputLines
               OpExecutionMode %main Invocations 1
               OpExecutionMode %main OutputLineStrip
               OpExecutionMode %main OutputVertices 2
               OpSource GLSL 450
               OpSourceExtension "GL_ARB_enhanced_layouts"
               OpName %main "main"
               OpName %OutBlock "OutBlock"
               OpMemberName %OutBlock 0 "out0"
               OpName %outBlock "outBlock"
               OpName %in0 "in0"
               OpMemberDecorate %OutBlock 0 Location 0
               OpMemberDecorate %OutBlock 0 Offset 0
               OpMemberDecorate %OutBlock 0 Stream 14
               OpMemberDecorate %OutBlock 0 XfbBuffer 0
               OpMemberDecorate %OutBlock 0 XfbStride 16
               OpDecorate %OutBlock Block
               OpMemberDecorate %BuiltIns 0 BuiltIn Position
               OpMemberDecorate %BuiltIns 1 BuiltIn PointSize
               OpDecorate %BuiltIns Block
               OpDecorate %in0 Location 0
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
   %OutBlock = OpTypeStruct %v4float
%_ptr_Output_OutBlock = OpTypePointer Output %OutBlock
   %outBlock = OpVariable %_ptr_Output_OutBlock Output
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%int_1 = OpConstant %int 1
%int_2 = OpConstant %int 2
       %uint = OpTypeInt 32 0
     %uint_0 = OpConstant %uint 2
%_arr_v4float_uint_0 = OpTypeArray %v4float %uint_0
%_ptr_Input__arr_v4float_uint_0 = OpTypePointer Input %_arr_v4float_uint_0
        %in0 = OpVariable %_ptr_Input__arr_v4float_uint_0 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Input_float = OpTypePointer Input %float
%_ptr_Output_v4float = OpTypePointer Output %v4float
%_ptr_Output_float = OpTypePointer Output %float
  %streamNum = OpConstant %int 14
%BuiltIns = OpTypeStruct %v4float %float
%InputBuiltInArray = OpTypeArray %BuiltIns %int_1
%InputBuiltInArrayPtr = OpTypePointer Input %InputBuiltInArray
%InputBuiltInArrayVar = OpVariable %InputBuiltInArrayPtr Input
%OutputBuiltInsPtr = OpTypePointer Output %BuiltIns
%OutputBuiltInsVar = OpVariable %OutputBuiltInsPtr Output
       %main = OpFunction %void None %3
          %5 = OpLabel
%in_gl_Position_Ptr = OpAccessChain %_ptr_Input_v4float %InputBuiltInArrayVar %int_0 %int_0
%in_gl_Position = OpLoad %v4float %in_gl_Position_Ptr
%out_gl_Position_Ptr = OpAccessChain %_ptr_Output_v4float %OutputBuiltInsVar %int_0
%in_gl_PointSize_Ptr = OpAccessChain %_ptr_Input_float %InputBuiltInArrayVar %int_0 %int_1
%in_gl_PointSize = OpLoad %float %in_gl_PointSize_Ptr
%out_gl_PointSize_Ptr = OpAccessChain %_ptr_Output_float %OutputBuiltInsVar %int_1
%11 = OpAccessChain %_ptr_Input_v4float %in0 %int_1
          %12 = OpLoad %v4float %11
          %13 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %13 %12
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpStore %out_gl_PointSize_Ptr %in_gl_PointSize
               OpEmitStreamVertex %streamNum
%21 = OpAccessChain %_ptr_Input_v4float %in0 %int_2
          %22 = OpLoad %v4float %21
          %23 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %23 %22
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpStore %out_gl_PointSize_Ptr %in_gl_PointSize
               OpEmitStreamVertex %streamNum
               OpEndStreamPrimitive %streamNum
               OpReturn
               OpFunctionEnd
#version 450

layout(triangles) in;
layout(location = 0) in vec4 in0[];

layout(triangle_strip, max_vertices = 3) out;
layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    out0 = in0[0];
    EmitVertex();
    out0 = in0[1];
    EmitVertex();
    out0 = in0[2];
    EmitVertex();
    EndPrimitive();
}
#version 450

layout(triangles) in;
layout(location = 0) in vec4 in0[];

layout(triangle_strip, max_vertices = 3) out;
layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    EmitVertex();
    EmitVertex();
    EmitVertex();
    EndPrimitive();
}
#version 450

layout(triangles) in;
layout(location = 0) in vec4 in0[];

layout(triangle_strip, max_vertices = 3) out;
layout(stream = 1, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    out0 = in0[0];
    EmitStreamVertex(1);
    out0 = in0[1];
    EmitStreamVertex(1);
    out0 = in0[2];
    EmitStreamVertex(1);
    EndStreamPrimitive(1);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 64
; Schema: 0
               OpCapability Geometry
               OpCapability TransformFeedback
               OpCapability GeometryStreams
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Geometry %main "main" %outBlock %in0 %InputBuiltInArrayVar %OutputBuiltInsVar
               OpExecutionMode %main Xfb
               OpExecutionMode %main Triangles
               OpExecutionMode %main Invocations 1
               OpExecutionMode %main OutputTriangleStrip
               OpExecutionMode %main OutputVertices 3
               OpSource GLSL 450
               OpSourceExtension "GL_ARB_enhanced_layouts"
               OpName %main "main"
               OpName %OutBlock "OutBlock"
               OpMemberName %OutBlock 0 "out0"
               OpName %outBlock "outBlock"
               OpName %in0 "in0"
               OpMemberDecorate %OutBlock 0 Location 0
               OpMemberDecorate %OutBlock 0 Offset 0
               OpMemberDecorate %OutBlock 0 Stream 1
               OpMemberDecorate %OutBlock 0 XfbBuffer 0
               OpMemberDecorate %OutBlock 0 XfbStride 16
               OpDecorate %OutBlock Block
               OpMemberDecorate %BuiltIns 0 BuiltIn Position
               OpDecorate %BuiltIns Block
               OpDecorate %in0 Location 0
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
   %OutBlock = OpTypeStruct %v4float
%_ptr_Output_OutBlock = OpTypePointer Output %OutBlock
   %outBlock = OpVariable %_ptr_Output_OutBlock Output
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%int_1 = OpConstant %int 1
%int_2 = OpConstant %int 2
%int_3 = OpConstant %int 3
       %uint = OpTypeInt 32 0
     %uint_0 = OpConstant %uint 3
%_arr_v4float_uint_0 = OpTypeArray %v4float %uint_0
%_ptr_Input__arr_v4float_uint_0 = OpTypePointer Input %_arr_v4float_uint_0
        %in0 = OpVariable %_ptr_Input__arr_v4float_uint_0 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Input_float = OpTypePointer Input %float
%_ptr_Output_v4float = OpTypePointer Output %v4float
%_ptr_Output_float = OpTypePointer Output %float
  %streamNum = OpConstant %int 1
%BuiltIns = OpTypeStruct %v4float
%InputBuiltInArray = OpTypeArray %BuiltIns %int_1
%InputBuiltInArrayPtr = OpTypePointer Input %InputBuiltInArray
%InputBuiltInArrayVar = OpVariable %InputBuiltInArrayPtr Input
%OutputBuiltInsPtr = OpTypePointer Output %BuiltIns
%OutputBuiltInsVar = OpVariable %OutputBuiltInsPtr Output
       %main = OpFunction %void None %3
          %5 = OpLabel
%in_gl_Position_Ptr = OpAccessChain %_ptr_Input_v4float %InputBuiltInArrayVar %int_0 %int_0
%in_gl_Position = OpLoad %v4float %in_gl_Position_Ptr
%out_gl_Position_Ptr = OpAccessChain %_ptr_Output_v4float %OutputBuiltInsVar %int_0
%11 = OpAccessChain %_ptr_Input_v4float %in0 %int_1
          %12 = OpLoad %v4float %11
          %13 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %13 %12
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpEmitStreamVertex %streamNum
%21 = OpAccessChain %_ptr_Input_v4float %in0 %int_2
          %22 = OpLoad %v4float %21
          %23 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %23 %22
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpEmitStreamVertex %streamNum
%31 = OpAccessChain %_ptr_Input_v4float %in0 %int_3
          %32 = OpLoad %v4float %31
          %33 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %33 %32
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpEmitStreamVertex %streamNum
               OpEndStreamPrimitive %streamNum
               OpReturn
               OpFunctionEnd
#version 450

layout(triangles) in;
layout(location = 0) in vec4 in0[];

layout(triangle_strip, max_vertices = 3) out;
layout(stream = 3, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    out0 = in0[0];
    EmitStreamVertex(3);
    out0 = in0[1];
    EmitStreamVertex(3);
    out0 = in0[2];
    EmitStreamVertex(3);
    EndStreamPrimitive(3);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 64
; Schema: 0
               OpCapability Geometry
               OpCapability TransformFeedback
               OpCapability GeometryStreams
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Geometry %main "main" %outBlock %in0 %InputBuiltInArrayVar %OutputBuiltInsVar
               OpExecutionMode %main Xfb
               OpExecutionMode %main Triangles
               OpExecutionMode %main Invocations 1
               OpExecutionMode %main OutputTriangleStrip
               OpExecutionMode %main OutputVertices 3
               OpSource GLSL 450
               OpSourceExtension "GL_ARB_enhanced_layouts"
               OpName %main "main"
               OpName %OutBlock "OutBlock"
               OpMemberName %OutBlock 0 "out0"
               OpName %outBlock "outBlock"
               OpName %in0 "in0"
               OpMemberDecorate %OutBlock 0 Location 0
               OpMemberDecorate %OutBlock 0 Offset 0
               OpMemberDecorate %OutBlock 0 Stream 3
               OpMemberDecorate %OutBlock 0 XfbBuffer 0
               OpMemberDecorate %OutBlock 0 XfbStride 16
               OpDecorate %OutBlock Block
               OpMemberDecorate %BuiltIns 0 BuiltIn Position
               OpDecorate %BuiltIns Block
               OpDecorate %in0 Location 0
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
   %OutBlock = OpTypeStruct %v4float
%_ptr_Output_OutBlock = OpTypePointer Output %OutBlock
   %outBlock = OpVariable %_ptr_Output_OutBlock Output
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%int_1 = OpConstant %int 1
%int_2 = OpConstant %int 2
%int_3 = OpConstant %int 3
       %uint = OpTypeInt 32 0
     %uint_0 = OpConstant %uint 3
%_arr_v4float_uint_0 = OpTypeArray %v4float %uint_0
%_ptr_Input__arr_v4float_uint_0 = OpTypePointer Input %_arr_v4float_uint_0
        %in0 = OpVariable %_ptr_Input__arr_v4float_uint_0 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Input_float = OpTypePointer Input %float
%_ptr_Output_v4float = OpTypePointer Output %v4float
%_ptr_Output_float = OpTypePointer Output %float
  %streamNum = OpConstant %int 3
%BuiltIns = OpTypeStruct %v4float
%InputBuiltInArray = OpTypeArray %BuiltIns %int_1
%InputBuiltInArrayPtr = OpTypePointer Input %InputBuiltInArray
%InputBuiltInArrayVar = OpVariable %InputBuiltInArrayPtr Input
%OutputBuiltInsPtr = OpTypePointer Output %BuiltIns
%OutputBuiltInsVar = OpVariable %OutputBuiltInsPtr Output
       %main = OpFunction %void None %3
          %5 = OpLabel
%in_gl_Position_Ptr = OpAccessChain %_ptr_Input_v4float %InputBuiltInArrayVar %int_0 %int_0
%in_gl_Position = OpLoad %v4float %in_gl_Position_Ptr
%out_gl_Position_Ptr = OpAccessChain %_ptr_Output_v4float %OutputBuiltInsVar %int_0
%11 = OpAccessChain %_ptr_Input_v4float %in0 %int_1
          %12 = OpLoad %v4float %11
          %13 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %13 %12
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpEmitStreamVertex %streamNum
%21 = OpAccessChain %_ptr_Input_v4float %in0 %int_2
          %22 = OpLoad %v4float %21
          %23 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %23 %22
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpEmitStreamVertex %streamNum
%31 = OpAccessChain %_ptr_Input_v4float %in0 %int_3
          %32 = OpLoad %v4float %31
          %33 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %33 %32
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpEmitStreamVertex %streamNum
               OpEndStreamPrimitive %streamNum
               OpReturn
               OpFunctionEnd
#version 450

layout(triangles) in;
layout(location = 0) in vec4 in0[];

layout(triangle_strip, max_vertices = 3) out;
layout(stream = 6, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    out0 = in0[0];
    EmitStreamVertex(6);
    out0 = in0[1];
    EmitStreamVertex(6);
    out0 = in0[2];
    EmitStreamVertex(6);
    EndStreamPrimitive(6);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 64
; Schema: 0
               OpCapability Geometry
               OpCapability TransformFeedback
               OpCapability GeometryStreams
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Geometry %main "main" %outBlock %in0 %InputBuiltInArrayVar %OutputBuiltInsVar
               OpExecutionMode %main Xfb
               OpExecutionMode %main Triangles
               OpExecutionMode %main Invocations 1
               OpExecutionMode %main OutputTriangleStrip
               OpExecutionMode %main OutputVertices 3
               OpSource GLSL 450
               OpSourceExtension "GL_ARB_enhanced_layouts"
               OpName %main "main"
               OpName %OutBlock "OutBlock"
               OpMemberName %OutBlock 0 "out0"
               OpName %outBlock "outBlock"
               OpName %in0 "in0"
               OpMemberDecorate %OutBlock 0 Location 0
               OpMemberDecorate %OutBlock 0 Offset 0
               OpMemberDecorate %OutBlock 0 Stream 6
               OpMemberDecorate %OutBlock 0 XfbBuffer 0
               OpMemberDecorate %OutBlock 0 XfbStride 16
               OpDecorate %OutBlock Block
               OpMemberDecorate %BuiltIns 0 BuiltIn Position
               OpDecorate %BuiltIns Block
               OpDecorate %in0 Location 0
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
   %OutBlock = OpTypeStruct %v4float
%_ptr_Output_OutBlock = OpTypePointer Output %OutBlock
   %outBlock = OpVariable %_ptr_Output_OutBlock Output
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%int_1 = OpConstant %int 1
%int_2 = OpConstant %int 2
%int_3 = OpConstant %int 3
       %uint = OpTypeInt 32 0
     %uint_0 = OpConstant %uint 3
%_arr_v4float_uint_0 = OpTypeArray %v4float %uint_0
%_ptr_Input__arr_v4float_uint_0 = OpTypePointer Input %_arr_v4float_uint_0
        %in0 = OpVariable %_ptr_Input__arr_v4float_uint_0 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Input_float = OpTypePointer Input %float
%_ptr_Output_v4float = OpTypePointer Output %v4float
%_ptr_Output_float = OpTypePointer Output %float
  %streamNum = OpConstant %int 6
%BuiltIns = OpTypeStruct %v4float
%InputBuiltInArray = OpTypeArray %BuiltIns %int_1
%InputBuiltInArrayPtr = OpTypePointer Input %InputBuiltInArray
%InputBuiltInArrayVar = OpVariable %InputBuiltInArrayPtr Input
%OutputBuiltInsPtr = OpTypePointer Output %BuiltIns
%OutputBuiltInsVar = OpVariable %OutputBuiltInsPtr Output
       %main = OpFunction %void None %3
          %5 = OpLabel
%in_gl_Position_Ptr = OpAccessChain %_ptr_Input_v4float %InputBuiltInArrayVar %int_0 %int_0
%in_gl_Position = OpLoad %v4float %in_gl_Position_Ptr
%out_gl_Position_Ptr = OpAccessChain %_ptr_Output_v4float %OutputBuiltInsVar %int_0
%11 = OpAccessChain %_ptr_Input_v4float %in0 %int_1
          %12 = OpLoad %v4float %11
          %13 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %13 %12
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpEmitStreamVertex %streamNum
%21 = OpAccessChain %_ptr_Input_v4float %in0 %int_2
          %22 = OpLoad %v4float %21
          %23 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %23 %22
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpEmitStreamVertex %streamNum
%31 = OpAccessChain %_ptr_Input_v4float %in0 %int_3
          %32 = OpLoad %v4float %31
          %33 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %33 %32
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpEmitStreamVertex %streamNum
               OpEndStreamPrimitive %streamNum
               OpReturn
               OpFunctionEnd
#version 450

layout(triangles) in;
layout(location = 0) in vec4 in0[];

layout(triangle_strip, max_vertices = 3) out;
layout(stream = 14, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    out0 = in0[0];
    EmitStreamVertex(14);
    out0 = in0[1];
    EmitStreamVertex(14);
    out0 = in0[2];
    EmitStreamVertex(14);
    EndStreamPrimitive(14);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 64
; Schema: 0
               OpCapability Geometry
               OpCapability TransformFeedback
               OpCapability GeometryStreams
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Geometry %main "main" %outBlock %in0 %InputBuiltInArrayVar %OutputBuiltInsVar
               OpExecutionMode %main Xfb
               OpExecutionMode %main Triangles
               OpExecutionMode %main Invocations 1
               OpExecutionMode %main OutputTriangleStrip
               OpExecutionMode %main OutputVertices 3
               OpSource GLSL 450
               OpSourceExtension "GL_ARB_enhanced_layouts"
               OpName %main "main"
               OpName %OutBlock "OutBlock"
               OpMemberName %OutBlock 0 "out0"
               OpName %outBlock "outBlock"
               OpName %in0 "in0"
               OpMemberDecorate %OutBlock 0 Location 0
               OpMemberDecorate %OutBlock 0 Offset 0
               OpMemberDecorate %OutBlock 0 Stream 14
               OpMemberDecorate %OutBlock 0 XfbBuffer 0
               OpMemberDecorate %OutBlock 0 XfbStride 16
               OpDecorate %OutBlock Block
               OpMemberDecorate %BuiltIns 0 BuiltIn Position
               OpDecorate %BuiltIns Block
               OpDecorate %in0 Location 0
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
   %OutBlock = OpTypeStruct %v4float
%_ptr_Output_OutBlock = OpTypePointer Output %OutBlock
   %outBlock = OpVariable %_ptr_Output_OutBlock Output
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%int_1 = OpConstant %int 1
%int_2 = OpConstant %int 2
%int_3 = OpConstant %int 3
       %uint = OpTypeInt 32 0
     %uint_0 = OpConstant %uint 3
%_arr_v4float_uint_0 = OpTypeArray %v4float %uint_0
%_ptr_Input__arr_v4float_uint_0 = OpTypePointer Input %_arr_v4float_uint_0
        %in0 = OpVariable %_ptr_Input__arr_v4float_uint_0 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Input_float = OpTypePointer Input %float
%_ptr_Output_v4float = OpTypePointer Output %v4float
%_ptr_Output_float = OpTypePointer Output %float
  %streamNum = OpConstant %int 14
%BuiltIns = OpTypeStruct %v4float
%InputBuiltInArray = OpTypeArray %BuiltIns %int_1
%InputBuiltInArrayPtr = OpTypePointer Input %InputBuiltInArray
%InputBuiltInArrayVar = OpVariable %InputBuiltInArrayPtr Input
%OutputBuiltInsPtr = OpTypePointer Output %BuiltIns
%OutputBuiltInsVar = OpVariable %OutputBuiltInsPtr Output
       %main = OpFunction %void None %3
          %5 = OpLabel
%in_gl_Position_Ptr = OpAccessChain %_ptr_Input_v4float %InputBuiltInArrayVar %int_0 %int_0
%in_gl_Position = OpLoad %v4float %in_gl_Position_Ptr
%out_gl_Position_Ptr = OpAccessChain %_ptr_Output_v4float %OutputBuiltInsVar %int_0
%11 = OpAccessChain %_ptr_Input_v4float %in0 %int_1
          %12 = OpLoad %v4float %11
          %13 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %13 %12
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpEmitStreamVertex %streamNum
%21 = OpAccessChain %_ptr_Input_v4float %in0 %int_2
          %22 = OpLoad %v4float %21
          %23 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %23 %22
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpEmitStreamVertex %streamNum
%31 = OpAccessChain %_ptr_Input_v4float %in0 %int_3
          %32 = OpLoad %v4float %31
          %33 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %33 %32
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpEmitStreamVertex %streamNum
               OpEndStreamPrimitive %streamNum
               OpReturn
               OpFunctionEnd
#version 450

layout(triangles) in;
layout(location = 0) in vec4 in0[];

layout(triangle_strip, max_vertices = 3) out;
layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;
    out0 = in0[0];
    EmitVertex();
    out0 = in0[1];
    EmitVertex();
    out0 = in0[2];
    EmitVertex();
    EndPrimitive();
}
#version 450

layout(triangles) in;
layout(location = 0) in vec4 in0[];

layout(triangle_strip, max_vertices = 3) out;
layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;
    EmitVertex();
    EmitVertex();
    EmitVertex();
    EndPrimitive();
}
#version 450

layout(triangles) in;
layout(location = 0) in vec4 in0[];

layout(triangle_strip, max_vertices = 3) out;
layout(stream = 1, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;
    out0 = in0[0];
    EmitStreamVertex(1);
    out0 = in0[1];
    EmitStreamVertex(1);
    out0 = in0[2];
    EmitStreamVertex(1);
    EndStreamPrimitive(1);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 64
; Schema: 0
               OpCapability Geometry
               OpCapability TransformFeedback
               OpCapability GeometryStreams
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Geometry %main "main" %outBlock %in0 %InputBuiltInArrayVar %OutputBuiltInsVar
               OpExecutionMode %main Xfb
               OpExecutionMode %main Triangles
               OpExecutionMode %main Invocations 1
               OpExecutionMode %main OutputTriangleStrip
               OpExecutionMode %main OutputVertices 3
               OpSource GLSL 450
               OpSourceExtension "GL_ARB_enhanced_layouts"
               OpName %main "main"
               OpName %OutBlock "OutBlock"
               OpMemberName %OutBlock 0 "out0"
               OpName %outBlock "outBlock"
               OpName %in0 "in0"
               OpMemberDecorate %OutBlock 0 Location 0
               OpMemberDecorate %OutBlock 0 Offset 0
               OpMemberDecorate %OutBlock 0 Stream 1
               OpMemberDecorate %OutBlock 0 XfbBuffer 0
               OpMemberDecorate %OutBlock 0 XfbStride 16
               OpDecorate %OutBlock Block
               OpMemberDecorate %BuiltIns 0 BuiltIn Position
               OpMemberDecorate %BuiltIns 1 BuiltIn PointSize
               OpDecorate %BuiltIns Block
               OpDecorate %in0 Location 0
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
   %OutBlock = OpTypeStruct %v4float
%_ptr_Output_OutBlock = OpTypePointer Output %OutBlock
   %outBlock = OpVariable %_ptr_Output_OutBlock Output
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%int_1 = OpConstant %int 1
%int_2 = OpConstant %int 2
%int_3 = OpConstant %int 3
       %uint = OpTypeInt 32 0
     %uint_0 = OpConstant %uint 3
%_arr_v4float_uint_0 = OpTypeArray %v4float %uint_0
%_ptr_Input__arr_v4float_uint_0 = OpTypePointer Input %_arr_v4float_uint_0
        %in0 = OpVariable %_ptr_Input__arr_v4float_uint_0 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Input_float = OpTypePointer Input %float
%_ptr_Output_v4float = OpTypePointer Output %v4float
%_ptr_Output_float = OpTypePointer Output %float
  %streamNum = OpConstant %int 1
%BuiltIns = OpTypeStruct %v4float %float
%InputBuiltInArray = OpTypeArray %BuiltIns %int_1
%InputBuiltInArrayPtr = OpTypePointer Input %InputBuiltInArray
%InputBuiltInArrayVar = OpVariable %InputBuiltInArrayPtr Input
%OutputBuiltInsPtr = OpTypePointer Output %BuiltIns
%OutputBuiltInsVar = OpVariable %OutputBuiltInsPtr Output
       %main = OpFunction %void None %3
          %5 = OpLabel
%in_gl_Position_Ptr = OpAccessChain %_ptr_Input_v4float %InputBuiltInArrayVar %int_0 %int_0
%in_gl_Position = OpLoad %v4float %in_gl_Position_Ptr
%out_gl_Position_Ptr = OpAccessChain %_ptr_Output_v4float %OutputBuiltInsVar %int_0
%in_gl_PointSize_Ptr = OpAccessChain %_ptr_Input_float %InputBuiltInArrayVar %int_0 %int_1
%in_gl_PointSize = OpLoad %float %in_gl_PointSize_Ptr
%out_gl_PointSize_Ptr = OpAccessChain %_ptr_Output_float %OutputBuiltInsVar %int_1
%11 = OpAccessChain %_ptr_Input_v4float %in0 %int_1
          %12 = OpLoad %v4float %11
          %13 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %13 %12
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpStore %out_gl_PointSize_Ptr %in_gl_PointSize
               OpEmitStreamVertex %streamNum
%21 = OpAccessChain %_ptr_Input_v4float %in0 %int_2
          %22 = OpLoad %v4float %21
          %23 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %23 %22
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpStore %out_gl_PointSize_Ptr %in_gl_PointSize
               OpEmitStreamVertex %streamNum
%31 = OpAccessChain %_ptr_Input_v4float %in0 %int_3
          %32 = OpLoad %v4float %31
          %33 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %33 %32
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpStore %out_gl_PointSize_Ptr %in_gl_PointSize
               OpEmitStreamVertex %streamNum
               OpEndStreamPrimitive %streamNum
               OpReturn
               OpFunctionEnd
#version 450

layout(triangles) in;
layout(location = 0) in vec4 in0[];

layout(triangle_strip, max_vertices = 3) out;
layout(stream = 3, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;
    out0 = in0[0];
    EmitStreamVertex(3);
    out0 = in0[1];
    EmitStreamVertex(3);
    out0 = in0[2];
    EmitStreamVertex(3);
    EndStreamPrimitive(3);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 64
; Schema: 0
               OpCapability Geometry
               OpCapability TransformFeedback
               OpCapability GeometryStreams
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Geometry %main "main" %outBlock %in0 %InputBuiltInArrayVar %OutputBuiltInsVar
               OpExecutionMode %main Xfb
               OpExecutionMode %main Triangles
               OpExecutionMode %main Invocations 1
               OpExecutionMode %main OutputTriangleStrip
               OpExecutionMode %main OutputVertices 3
               OpSource GLSL 450
               OpSourceExtension "GL_ARB_enhanced_layouts"
               OpName %main "main"
               OpName %OutBlock "OutBlock"
               OpMemberName %OutBlock 0 "out0"
               OpName %outBlock "outBlock"
               OpName %in0 "in0"
               OpMemberDecorate %OutBlock 0 Location 0
               OpMemberDecorate %OutBlock 0 Offset 0
               OpMemberDecorate %OutBlock 0 Stream 3
               OpMemberDecorate %OutBlock 0 XfbBuffer 0
               OpMemberDecorate %OutBlock 0 XfbStride 16
               OpDecorate %OutBlock Block
               OpMemberDecorate %BuiltIns 0 BuiltIn Position
               OpMemberDecorate %BuiltIns 1 BuiltIn PointSize
               OpDecorate %BuiltIns Block
               OpDecorate %in0 Location 0
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
   %OutBlock = OpTypeStruct %v4float
%_ptr_Output_OutBlock = OpTypePointer Output %OutBlock
   %outBlock = OpVariable %_ptr_Output_OutBlock Output
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%int_1 = OpConstant %int 1
%int_2 = OpConstant %int 2
%int_3 = OpConstant %int 3
       %uint = OpTypeInt 32 0
     %uint_0 = OpConstant %uint 3
%_arr_v4float_uint_0 = OpTypeArray %v4float %uint_0
%_ptr_Input__arr_v4float_uint_0 = OpTypePointer Input %_arr_v4float_uint_0
        %in0 = OpVariable %_ptr_Input__arr_v4float_uint_0 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Input_float = OpTypePointer Input %float
%_ptr_Output_v4float = OpTypePointer Output %v4float
%_ptr_Output_float = OpTypePointer Output %float
  %streamNum = OpConstant %int 3
%BuiltIns = OpTypeStruct %v4float %float
%InputBuiltInArray = OpTypeArray %BuiltIns %int_1
%InputBuiltInArrayPtr = OpTypePointer Input %InputBuiltInArray
%InputBuiltInArrayVar = OpVariable %InputBuiltInArrayPtr Input
%OutputBuiltInsPtr = OpTypePointer Output %BuiltIns
%OutputBuiltInsVar = OpVariable %OutputBuiltInsPtr Output
       %main = OpFunction %void None %3
          %5 = OpLabel
%in_gl_Position_Ptr = OpAccessChain %_ptr_Input_v4float %InputBuiltInArrayVar %int_0 %int_0
%in_gl_Position = OpLoad %v4float %in_gl_Position_Ptr
%out_gl_Position_Ptr = OpAccessChain %_ptr_Output_v4float %OutputBuiltInsVar %int_0
%in_gl_PointSize_Ptr = OpAccessChain %_ptr_Input_float %InputBuiltInArrayVar %int_0 %int_1
%in_gl_PointSize = OpLoad %float %in_gl_PointSize_Ptr
%out_gl_PointSize_Ptr = OpAccessChain %_ptr_Output_float %OutputBuiltInsVar %int_1
%11 = OpAccessChain %_ptr_Input_v4float %in0 %int_1
          %12 = OpLoad %v4float %11
          %13 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %13 %12
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpStore %out_gl_PointSize_Ptr %in_gl_PointSize
               OpEmitStreamVertex %streamNum
%21 = OpAccessChain %_ptr_Input_v4float %in0 %int_2
          %22 = OpLoad %v4float %21
          %23 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %23 %22
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpStore %out_gl_PointSize_Ptr %in_gl_PointSize
               OpEmitStreamVertex %streamNum
%31 = OpAccessChain %_ptr_Input_v4float %in0 %int_3
          %32 = OpLoad %v4float %31
          %33 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %33 %32
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpStore %out_gl_PointSize_Ptr %in_gl_PointSize
               OpEmitStreamVertex %streamNum
               OpEndStreamPrimitive %streamNum
               OpReturn
               OpFunctionEnd
#version 450

layout(triangles) in;
layout(location = 0) in vec4 in0[];

layout(triangle_strip, max_vertices = 3) out;
layout(stream = 6, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;
    out0 = in0[0];
    EmitStreamVertex(6);
    out0 = in0[1];
    EmitStreamVertex(6);
    out0 = in0[2];
    EmitStreamVertex(6);
    EndStreamPrimitive(6);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 64
; Schema: 0
               OpCapability Geometry
               OpCapability TransformFeedback
               OpCapability GeometryStreams
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Geometry %main "main" %outBlock %in0 %InputBuiltInArrayVar %OutputBuiltInsVar
               OpExecutionMode %main Xfb
               OpExecutionMode %main Triangles
               OpExecutionMode %main Invocations 1
               OpExecutionMode %main OutputTriangleStrip
               OpExecutionMode %main OutputVertices 3
               OpSource GLSL 450
               OpSourceExtension "GL_ARB_enhanced_layouts"
               OpName %main "main"
               OpName %OutBlock "OutBlock"
               OpMemberName %OutBlock 0 "out0"
               OpName %outBlock "outBlock"
               OpName %in0 "in0"
               OpMemberDecorate %OutBlock 0 Location 0
               OpMemberDecorate %OutBlock 0 Offset 0
               OpMemberDecorate %OutBlock 0 Stream 6
               OpMemberDecorate %OutBlock 0 XfbBuffer 0
               OpMemberDecorate %OutBlock 0 XfbStride 16
               OpDecorate %OutBlock Block
               OpMemberDecorate %BuiltIns 0 BuiltIn Position
               OpMemberDecorate %BuiltIns 1 BuiltIn PointSize
               OpDecorate %BuiltIns Block
               OpDecorate %in0 Location 0
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
   %OutBlock = OpTypeStruct %v4float
%_ptr_Output_OutBlock = OpTypePointer Output %OutBlock
   %outBlock = OpVariable %_ptr_Output_OutBlock Output
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%int_1 = OpConstant %int 1
%int_2 = OpConstant %int 2
%int_3 = OpConstant %int 3
       %uint = OpTypeInt 32 0
     %uint_0 = OpConstant %uint 3
%_arr_v4float_uint_0 = OpTypeArray %v4float %uint_0
%_ptr_Input__arr_v4float_uint_0 = OpTypePointer Input %_arr_v4float_uint_0
        %in0 = OpVariable %_ptr_Input__arr_v4float_uint_0 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Input_float = OpTypePointer Input %float
%_ptr_Output_v4float = OpTypePointer Output %v4float
%_ptr_Output_float = OpTypePointer Output %float
  %streamNum = OpConstant %int 6
%BuiltIns = OpTypeStruct %v4float %float
%InputBuiltInArray = OpTypeArray %BuiltIns %int_1
%InputBuiltInArrayPtr = OpTypePointer Input %InputBuiltInArray
%InputBuiltInArrayVar = OpVariable %InputBuiltInArrayPtr Input
%OutputBuiltInsPtr = OpTypePointer Output %BuiltIns
%OutputBuiltInsVar = OpVariable %OutputBuiltInsPtr Output
       %main = OpFunction %void None %3
          %5 = OpLabel
%in_gl_Position_Ptr = OpAccessChain %_ptr_Input_v4float %InputBuiltInArrayVar %int_0 %int_0
%in_gl_Position = OpLoad %v4float %in_gl_Position_Ptr
%out_gl_Position_Ptr = OpAccessChain %_ptr_Output_v4float %OutputBuiltInsVar %int_0
%in_gl_PointSize_Ptr = OpAccessChain %_ptr_Input_float %InputBuiltInArrayVar %int_0 %int_1
%in_gl_PointSize = OpLoad %float %in_gl_PointSize_Ptr
%out_gl_PointSize_Ptr = OpAccessChain %_ptr_Output_float %OutputBuiltInsVar %int_1
%11 = OpAccessChain %_ptr_Input_v4float %in0 %int_1
          %12 = OpLoad %v4float %11
          %13 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %13 %12
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpStore %out_gl_PointSize_Ptr %in_gl_PointSize
               OpEmitStreamVertex %streamNum
%21 = OpAccessChain %_ptr_Input_v4float %in0 %int_2
          %22 = OpLoad %v4float %21
          %23 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %23 %22
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpStore %out_gl_PointSize_Ptr %in_gl_PointSize
               OpEmitStreamVertex %streamNum
%31 = OpAccessChain %_ptr_Input_v4float %in0 %int_3
          %32 = OpLoad %v4float %31
          %33 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %33 %32
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpStore %out_gl_PointSize_Ptr %in_gl_PointSize
               OpEmitStreamVertex %streamNum
               OpEndStreamPrimitive %streamNum
               OpReturn
               OpFunctionEnd
#version 450

layout(triangles) in;
layout(location = 0) in vec4 in0[];

layout(triangle_strip, max_vertices = 3) out;
layout(stream = 14, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;
    out0 = in0[0];
    EmitStreamVertex(14);
    out0 = in0[1];
    EmitStreamVertex(14);
    out0 = in0[2];
    EmitStreamVertex(14);
    EndStreamPrimitive(14);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 64
; Schema: 0
               OpCapability Geometry
               OpCapability TransformFeedback
               OpCapability GeometryStreams
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Geometry %main "main" %outBlock %in0 %InputBuiltInArrayVar %OutputBuiltInsVar
               OpExecutionMode %main Xfb
               OpExecutionMode %main Triangles
               OpExecutionMode %main Invocations 1
               OpExecutionMode %main OutputTriangleStrip
               OpExecutionMode %main OutputVertices 3
               OpSource GLSL 450
               OpSourceExtension "GL_ARB_enhanced_layouts"
               OpName %main "main"
               OpName %OutBlock "OutBlock"
               OpMemberName %OutBlock 0 "out0"
               OpName %outBlock "outBlock"
               OpName %in0 "in0"
               OpMemberDecorate %OutBlock 0 Location 0
               OpMemberDecorate %OutBlock 0 Offset 0
               OpMemberDecorate %OutBlock 0 Stream 14
               OpMemberDecorate %OutBlock 0 XfbBuffer 0
               OpMemberDecorate %OutBlock 0 XfbStride 16
               OpDecorate %OutBlock Block
               OpMemberDecorate %BuiltIns 0 BuiltIn Position
               OpMemberDecorate %BuiltIns 1 BuiltIn PointSize
               OpDecorate %BuiltIns Block
               OpDecorate %in0 Location 0
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
   %OutBlock = OpTypeStruct %v4float
%_ptr_Output_OutBlock = OpTypePointer Output %OutBlock
   %outBlock = OpVariable %_ptr_Output_OutBlock Output
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%int_1 = OpConstant %int 1
%int_2 = OpConstant %int 2
%int_3 = OpConstant %int 3
       %uint = OpTypeInt 32 0
     %uint_0 = OpConstant %uint 3
%_arr_v4float_uint_0 = OpTypeArray %v4float %uint_0
%_ptr_Input__arr_v4float_uint_0 = OpTypePointer Input %_arr_v4float_uint_0
        %in0 = OpVariable %_ptr_Input__arr_v4float_uint_0 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Input_float = OpTypePointer Input %float
%_ptr_Output_v4float = OpTypePointer Output %v4float
%_ptr_Output_float = OpTypePointer Output %float
  %streamNum = OpConstant %int 14
%BuiltIns = OpTypeStruct %v4float %float
%InputBuiltInArray = OpTypeArray %BuiltIns %int_1
%InputBuiltInArrayPtr = OpTypePointer Input %InputBuiltInArray
%InputBuiltInArrayVar = OpVariable %InputBuiltInArrayPtr Input
%OutputBuiltInsPtr = OpTypePointer Output %BuiltIns
%OutputBuiltInsVar = OpVariable %OutputBuiltInsPtr Output
       %main = OpFunction %void None %3
          %5 = OpLabel
%in_gl_Position_Ptr = OpAccessChain %_ptr_Input_v4float %InputBuiltInArrayVar %int_0 %int_0
%in_gl_Position = OpLoad %v4float %in_gl_Position_Ptr
%out_gl_Position_Ptr = OpAccessChain %_ptr_Output_v4float %OutputBuiltInsVar %int_0
%in_gl_PointSize_Ptr = OpAccessChain %_ptr_Input_float %InputBuiltInArrayVar %int_0 %int_1
%in_gl_PointSize = OpLoad %float %in_gl_PointSize_Ptr
%out_gl_PointSize_Ptr = OpAccessChain %_ptr_Output_float %OutputBuiltInsVar %int_1
%11 = OpAccessChain %_ptr_Input_v4float %in0 %int_1
          %12 = OpLoad %v4float %11
          %13 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %13 %12
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpStore %out_gl_PointSize_Ptr %in_gl_PointSize
               OpEmitStreamVertex %streamNum
%21 = OpAccessChain %_ptr_Input_v4float %in0 %int_2
          %22 = OpLoad %v4float %21
          %23 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %23 %22
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpStore %out_gl_PointSize_Ptr %in_gl_PointSize
               OpEmitStreamVertex %streamNum
%31 = OpAccessChain %_ptr_Input_v4float %in0 %int_3
          %32 = OpLoad %v4float %31
          %33 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %33 %32
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpStore %out_gl_PointSize_Ptr %in_gl_PointSize
               OpEmitStreamVertex %streamNum
               OpEndStreamPrimitive %streamNum
               OpReturn
               OpFunctionEnd
#version 450

layout(lines_adjacency) in;
layout(location = 0) in vec4 in0[];

layout(line_strip, max_vertices = 2) out;
layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    out0 = in0[0];
    EmitVertex();
    out0 = in0[1];
    EmitVertex();
    EndPrimitive();
}
#version 450

layout(lines_adjacency) in;
layout(location = 0) in vec4 in0[];

layout(line_strip, max_vertices = 2) out;
layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    EmitVertex();
    EmitVertex();
    EndPrimitive();
}
#version 450

layout(lines_adjacency) in;
layout(location = 0) in vec4 in0[];

layout(line_strip, max_vertices = 2) out;
layout(stream = 1, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    out0 = in0[0];
    EmitStreamVertex(1);
    out0 = in0[1];
    EmitStreamVertex(1);
    EndStreamPrimitive(1);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 64
; Schema: 0
               OpCapability Geometry
               OpCapability TransformFeedback
               OpCapability GeometryStreams
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Geometry %main "main" %outBlock %in0 %InputBuiltInArrayVar %OutputBuiltInsVar
               OpExecutionMode %main Xfb
               OpExecutionMode %main InputLinesAdjacency
               OpExecutionMode %main Invocations 1
               OpExecutionMode %main OutputLineStrip
               OpExecutionMode %main OutputVertices 2
               OpSource GLSL 450
               OpSourceExtension "GL_ARB_enhanced_layouts"
               OpName %main "main"
               OpName %OutBlock "OutBlock"
               OpMemberName %OutBlock 0 "out0"
               OpName %outBlock "outBlock"
               OpName %in0 "in0"
               OpMemberDecorate %OutBlock 0 Location 0
               OpMemberDecorate %OutBlock 0 Offset 0
               OpMemberDecorate %OutBlock 0 Stream 1
               OpMemberDecorate %OutBlock 0 XfbBuffer 0
               OpMemberDecorate %OutBlock 0 XfbStride 16
               OpDecorate %OutBlock Block
               OpMemberDecorate %BuiltIns 0 BuiltIn Position
               OpDecorate %BuiltIns Block
               OpDecorate %in0 Location 0
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
   %OutBlock = OpTypeStruct %v4float
%_ptr_Output_OutBlock = OpTypePointer Output %OutBlock
   %outBlock = OpVariable %_ptr_Output_OutBlock Output
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%int_1 = OpConstant %int 1
%int_2 = OpConstant %int 2
       %uint = OpTypeInt 32 0
     %uint_0 = OpConstant %uint 2
%_arr_v4float_uint_0 = OpTypeArray %v4float %uint_0
%_ptr_Input__arr_v4float_uint_0 = OpTypePointer Input %_arr_v4float_uint_0
        %in0 = OpVariable %_ptr_Input__arr_v4float_uint_0 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Input_float = OpTypePointer Input %float
%_ptr_Output_v4float = OpTypePointer Output %v4float
%_ptr_Output_float = OpTypePointer Output %float
  %streamNum = OpConstant %int 1
%BuiltIns = OpTypeStruct %v4float
%InputBuiltInArray = OpTypeArray %BuiltIns %int_1
%InputBuiltInArrayPtr = OpTypePointer Input %InputBuiltInArray
%InputBuiltInArrayVar = OpVariable %InputBuiltInArrayPtr Input
%OutputBuiltInsPtr = OpTypePointer Output %BuiltIns
%OutputBuiltInsVar = OpVariable %OutputBuiltInsPtr Output
       %main = OpFunction %void None %3
          %5 = OpLabel
%in_gl_Position_Ptr = OpAccessChain %_ptr_Input_v4float %InputBuiltInArrayVar %int_0 %int_0
%in_gl_Position = OpLoad %v4float %in_gl_Position_Ptr
%out_gl_Position_Ptr = OpAccessChain %_ptr_Output_v4float %OutputBuiltInsVar %int_0
%11 = OpAccessChain %_ptr_Input_v4float %in0 %int_1
          %12 = OpLoad %v4float %11
          %13 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %13 %12
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpEmitStreamVertex %streamNum
%21 = OpAccessChain %_ptr_Input_v4float %in0 %int_2
          %22 = OpLoad %v4float %21
          %23 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %23 %22
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpEmitStreamVertex %streamNum
               OpEndStreamPrimitive %streamNum
               OpReturn
               OpFunctionEnd
#version 450

layout(lines_adjacency) in;
layout(location = 0) in vec4 in0[];

layout(line_strip, max_vertices = 2) out;
layout(stream = 3, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    out0 = in0[0];
    EmitStreamVertex(3);
    out0 = in0[1];
    EmitStreamVertex(3);
    EndStreamPrimitive(3);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 64
; Schema: 0
               OpCapability Geometry
               OpCapability TransformFeedback
               OpCapability GeometryStreams
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Geometry %main "main" %outBlock %in0 %InputBuiltInArrayVar %OutputBuiltInsVar
               OpExecutionMode %main Xfb
               OpExecutionMode %main InputLinesAdjacency
               OpExecutionMode %main Invocations 1
               OpExecutionMode %main OutputLineStrip
               OpExecutionMode %main OutputVertices 2
               OpSource GLSL 450
               OpSourceExtension "GL_ARB_enhanced_layouts"
               OpName %main "main"
               OpName %OutBlock "OutBlock"
               OpMemberName %OutBlock 0 "out0"
               OpName %outBlock "outBlock"
               OpName %in0 "in0"
               OpMemberDecorate %OutBlock 0 Location 0
               OpMemberDecorate %OutBlock 0 Offset 0
               OpMemberDecorate %OutBlock 0 Stream 3
               OpMemberDecorate %OutBlock 0 XfbBuffer 0
               OpMemberDecorate %OutBlock 0 XfbStride 16
               OpDecorate %OutBlock Block
               OpMemberDecorate %BuiltIns 0 BuiltIn Position
               OpDecorate %BuiltIns Block
               OpDecorate %in0 Location 0
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
   %OutBlock = OpTypeStruct %v4float
%_ptr_Output_OutBlock = OpTypePointer Output %OutBlock
   %outBlock = OpVariable %_ptr_Output_OutBlock Output
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%int_1 = OpConstant %int 1
%int_2 = OpConstant %int 2
       %uint = OpTypeInt 32 0
     %uint_0 = OpConstant %uint 2
%_arr_v4float_uint_0 = OpTypeArray %v4float %uint_0
%_ptr_Input__arr_v4float_uint_0 = OpTypePointer Input %_arr_v4float_uint_0
        %in0 = OpVariable %_ptr_Input__arr_v4float_uint_0 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Input_float = OpTypePointer Input %float
%_ptr_Output_v4float = OpTypePointer Output %v4float
%_ptr_Output_float = OpTypePointer Output %float
  %streamNum = OpConstant %int 3
%BuiltIns = OpTypeStruct %v4float
%InputBuiltInArray = OpTypeArray %BuiltIns %int_1
%InputBuiltInArrayPtr = OpTypePointer Input %InputBuiltInArray
%InputBuiltInArrayVar = OpVariable %InputBuiltInArrayPtr Input
%OutputBuiltInsPtr = OpTypePointer Output %BuiltIns
%OutputBuiltInsVar = OpVariable %OutputBuiltInsPtr Output
       %main = OpFunction %void None %3
          %5 = OpLabel
%in_gl_Position_Ptr = OpAccessChain %_ptr_Input_v4float %InputBuiltInArrayVar %int_0 %int_0
%in_gl_Position = OpLoad %v4float %in_gl_Position_Ptr
%out_gl_Position_Ptr = OpAccessChain %_ptr_Output_v4float %OutputBuiltInsVar %int_0
%11 = OpAccessChain %_ptr_Input_v4float %in0 %int_1
          %12 = OpLoad %v4float %11
          %13 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %13 %12
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpEmitStreamVertex %streamNum
%21 = OpAccessChain %_ptr_Input_v4float %in0 %int_2
          %22 = OpLoad %v4float %21
          %23 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %23 %22
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpEmitStreamVertex %streamNum
               OpEndStreamPrimitive %streamNum
               OpReturn
               OpFunctionEnd
#version 450

layout(lines_adjacency) in;
layout(location = 0) in vec4 in0[];

layout(line_strip, max_vertices = 2) out;
layout(stream = 6, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    out0 = in0[0];
    EmitStreamVertex(6);
    out0 = in0[1];
    EmitStreamVertex(6);
    EndStreamPrimitive(6);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 64
; Schema: 0
               OpCapability Geometry
               OpCapability TransformFeedback
               OpCapability GeometryStreams
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Geometry %main "main" %outBlock %in0 %InputBuiltInArrayVar %OutputBuiltInsVar
               OpExecutionMode %main Xfb
               OpExecutionMode %main InputLinesAdjacency
               OpExecutionMode %main Invocations 1
               OpExecutionMode %main OutputLineStrip
               OpExecutionMode %main OutputVertices 2
               OpSource GLSL 450
               OpSourceExtension "GL_ARB_enhanced_layouts"
               OpName %main "main"
               OpName %OutBlock "OutBlock"
               OpMemberName %OutBlock 0 "out0"
               OpName %outBlock "outBlock"
               OpName %in0 "in0"
               OpMemberDecorate %OutBlock 0 Location 0
               OpMemberDecorate %OutBlock 0 Offset 0
               OpMemberDecorate %OutBlock 0 Stream 6
               OpMemberDecorate %OutBlock 0 XfbBuffer 0
               OpMemberDecorate %OutBlock 0 XfbStride 16
               OpDecorate %OutBlock Block
               OpMemberDecorate %BuiltIns 0 BuiltIn Position
               OpDecorate %BuiltIns Block
               OpDecorate %in0 Location 0
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
   %OutBlock = OpTypeStruct %v4float
%_ptr_Output_OutBlock = OpTypePointer Output %OutBlock
   %outBlock = OpVariable %_ptr_Output_OutBlock Output
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%int_1 = OpConstant %int 1
%int_2 = OpConstant %int 2
       %uint = OpTypeInt 32 0
     %uint_0 = OpConstant %uint 2
%_arr_v4float_uint_0 = OpTypeArray %v4float %uint_0
%_ptr_Input__arr_v4float_uint_0 = OpTypePointer Input %_arr_v4float_uint_0
        %in0 = OpVariable %_ptr_Input__arr_v4float_uint_0 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Input_float = OpTypePointer Input %float
%_ptr_Output_v4float = OpTypePointer Output %v4float
%_ptr_Output_float = OpTypePointer Output %float
  %streamNum = OpConstant %int 6
%BuiltIns = OpTypeStruct %v4float
%InputBuiltInArray = OpTypeArray %BuiltIns %int_1
%InputBuiltInArrayPtr = OpTypePointer Input %InputBuiltInArray
%InputBuiltInArrayVar = OpVariable %InputBuiltInArrayPtr Input
%OutputBuiltInsPtr = OpTypePointer Output %BuiltIns
%OutputBuiltInsVar = OpVariable %OutputBuiltInsPtr Output
       %main = OpFunction %void None %3
          %5 = OpLabel
%in_gl_Position_Ptr = OpAccessChain %_ptr_Input_v4float %InputBuiltInArrayVar %int_0 %int_0
%in_gl_Position = OpLoad %v4float %in_gl_Position_Ptr
%out_gl_Position_Ptr = OpAccessChain %_ptr_Output_v4float %OutputBuiltInsVar %int_0
%11 = OpAccessChain %_ptr_Input_v4float %in0 %int_1
          %12 = OpLoad %v4float %11
          %13 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %13 %12
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpEmitStreamVertex %streamNum
%21 = OpAccessChain %_ptr_Input_v4float %in0 %int_2
          %22 = OpLoad %v4float %21
          %23 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %23 %22
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpEmitStreamVertex %streamNum
               OpEndStreamPrimitive %streamNum
               OpReturn
               OpFunctionEnd
#version 450

layout(lines_adjacency) in;
layout(location = 0) in vec4 in0[];

layout(line_strip, max_vertices = 2) out;
layout(stream = 14, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    out0 = in0[0];
    EmitStreamVertex(14);
    out0 = in0[1];
    EmitStreamVertex(14);
    EndStreamPrimitive(14);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 64
; Schema: 0
               OpCapability Geometry
               OpCapability TransformFeedback
               OpCapability GeometryStreams
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Geometry %main "main" %outBlock %in0 %InputBuiltInArrayVar %OutputBuiltInsVar
               OpExecutionMode %main Xfb
               OpExecutionMode %main InputLinesAdjacency
               OpExecutionMode %main Invocations 1
               OpExecutionMode %main OutputLineStrip
               OpExecutionMode %main OutputVertices 2
               OpSource GLSL 450
               OpSourceExtension "GL_ARB_enhanced_layouts"
               OpName %main "main"
               OpName %OutBlock "OutBlock"
               OpMemberName %OutBlock 0 "out0"
               OpName %outBlock "outBlock"
               OpName %in0 "in0"
               OpMemberDecorate %OutBlock 0 Location 0
               OpMemberDecorate %OutBlock 0 Offset 0
               OpMemberDecorate %OutBlock 0 Stream 14
               OpMemberDecorate %OutBlock 0 XfbBuffer 0
               OpMemberDecorate %OutBlock 0 XfbStride 16
               OpDecorate %OutBlock Block
               OpMemberDecorate %BuiltIns 0 BuiltIn Position
               OpDecorate %BuiltIns Block
               OpDecorate %in0 Location 0
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
   %OutBlock = OpTypeStruct %v4float
%_ptr_Output_OutBlock = OpTypePointer Output %OutBlock
   %outBlock = OpVariable %_ptr_Output_OutBlock Output
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%int_1 = OpConstant %int 1
%int_2 = OpConstant %int 2
       %uint = OpTypeInt 32 0
     %uint_0 = OpConstant %uint 2
%_arr_v4float_uint_0 = OpTypeArray %v4float %uint_0
%_ptr_Input__arr_v4float_uint_0 = OpTypePointer Input %_arr_v4float_uint_0
        %in0 = OpVariable %_ptr_Input__arr_v4float_uint_0 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Input_float = OpTypePointer Input %float
%_ptr_Output_v4float = OpTypePointer Output %v4float
%_ptr_Output_float = OpTypePointer Output %float
  %streamNum = OpConstant %int 14
%BuiltIns = OpTypeStruct %v4float
%InputBuiltInArray = OpTypeArray %BuiltIns %int_1
%InputBuiltInArrayPtr = OpTypePointer Input %InputBuiltInArray
%InputBuiltInArrayVar = OpVariable %InputBuiltInArrayPtr Input
%OutputBuiltInsPtr = OpTypePointer Output %BuiltIns
%OutputBuiltInsVar = OpVariable %OutputBuiltInsPtr Output
       %main = OpFunction %void None %3
          %5 = OpLabel
%in_gl_Position_Ptr = OpAccessChain %_ptr_Input_v4float %InputBuiltInArrayVar %int_0 %int_0
%in_gl_Position = OpLoad %v4float %in_gl_Position_Ptr
%out_gl_Position_Ptr = OpAccessChain %_ptr_Output_v4float %OutputBuiltInsVar %int_0
%11 = OpAccessChain %_ptr_Input_v4float %in0 %int_1
          %12 = OpLoad %v4float %11
          %13 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %13 %12
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpEmitStreamVertex %streamNum
%21 = OpAccessChain %_ptr_Input_v4float %in0 %int_2
          %22 = OpLoad %v4float %21
          %23 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %23 %22
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpEmitStreamVertex %streamNum
               OpEndStreamPrimitive %streamNum
               OpReturn
               OpFunctionEnd
#version 450

layout(lines_adjacency) in;
layout(location = 0) in vec4 in0[];

layout(line_strip, max_vertices = 2) out;
layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;
    out0 = in0[0];
    EmitVertex();
    out0 = in0[1];
    EmitVertex();
    EndPrimitive();
}
#version 450

layout(lines_adjacency) in;
layout(location = 0) in vec4 in0[];

layout(line_strip, max_vertices = 2) out;
layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;
    EmitVertex();
    EmitVertex();
    EndPrimitive();
}
#version 450

layout(lines_adjacency) in;
layout(location = 0) in vec4 in0[];

layout(line_strip, max_vertices = 2) out;
layout(stream = 1, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;
    out0 = in0[0];
    EmitStreamVertex(1);
    out0 = in0[1];
    EmitStreamVertex(1);
    EndStreamPrimitive(1);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 64
; Schema: 0
               OpCapability Geometry
               OpCapability TransformFeedback
               OpCapability GeometryStreams
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Geometry %main "main" %outBlock %in0 %InputBuiltInArrayVar %OutputBuiltInsVar
               OpExecutionMode %main Xfb
               OpExecutionMode %main InputLinesAdjacency
               OpExecutionMode %main Invocations 1
               OpExecutionMode %main OutputLineStrip
               OpExecutionMode %main OutputVertices 2
               OpSource GLSL 450
               OpSourceExtension "GL_ARB_enhanced_layouts"
               OpName %main "main"
               OpName %OutBlock "OutBlock"
               OpMemberName %OutBlock 0 "out0"
               OpName %outBlock "outBlock"
               OpName %in0 "in0"
               OpMemberDecorate %OutBlock 0 Location 0
               OpMemberDecorate %OutBlock 0 Offset 0
               OpMemberDecorate %OutBlock 0 Stream 1
               OpMemberDecorate %OutBlock 0 XfbBuffer 0
               OpMemberDecorate %OutBlock 0 XfbStride 16
               OpDecorate %OutBlock Block
               OpMemberDecorate %BuiltIns 0 BuiltIn Position
               OpMemberDecorate %BuiltIns 1 BuiltIn PointSize
               OpDecorate %BuiltIns Block
               OpDecorate %in0 Location 0
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
   %OutBlock = OpTypeStruct %v4float
%_ptr_Output_OutBlock = OpTypePointer Output %OutBlock
   %outBlock = OpVariable %_ptr_Output_OutBlock Output
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%int_1 = OpConstant %int 1
%int_2 = OpConstant %int 2
       %uint = OpTypeInt 32 0
     %uint_0 = OpConstant %uint 2
%_arr_v4float_uint_0 = OpTypeArray %v4float %uint_0
%_ptr_Input__arr_v4float_uint_0 = OpTypePointer Input %_arr_v4float_uint_0
        %in0 = OpVariable %_ptr_Input__arr_v4float_uint_0 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Input_float = OpTypePointer Input %float
%_ptr_Output_v4float = OpTypePointer Output %v4float
%_ptr_Output_float = OpTypePointer Output %float
  %streamNum = OpConstant %int 1
%BuiltIns = OpTypeStruct %v4float %float
%InputBuiltInArray = OpTypeArray %BuiltIns %int_1
%InputBuiltInArrayPtr = OpTypePointer Input %InputBuiltInArray
%InputBuiltInArrayVar = OpVariable %InputBuiltInArrayPtr Input
%OutputBuiltInsPtr = OpTypePointer Output %BuiltIns
%OutputBuiltInsVar = OpVariable %OutputBuiltInsPtr Output
       %main = OpFunction %void None %3
          %5 = OpLabel
%in_gl_Position_Ptr = OpAccessChain %_ptr_Input_v4float %InputBuiltInArrayVar %int_0 %int_0
%in_gl_Position = OpLoad %v4float %in_gl_Position_Ptr
%out_gl_Position_Ptr = OpAccessChain %_ptr_Output_v4float %OutputBuiltInsVar %int_0
%in_gl_PointSize_Ptr = OpAccessChain %_ptr_Input_float %InputBuiltInArrayVar %int_0 %int_1
%in_gl_PointSize = OpLoad %float %in_gl_PointSize_Ptr
%out_gl_PointSize_Ptr = OpAccessChain %_ptr_Output_float %OutputBuiltInsVar %int_1
%11 = OpAccessChain %_ptr_Input_v4float %in0 %int_1
          %12 = OpLoad %v4float %11
          %13 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %13 %12
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpStore %out_gl_PointSize_Ptr %in_gl_PointSize
               OpEmitStreamVertex %streamNum
%21 = OpAccessChain %_ptr_Input_v4float %in0 %int_2
          %22 = OpLoad %v4float %21
          %23 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %23 %22
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpStore %out_gl_PointSize_Ptr %in_gl_PointSize
               OpEmitStreamVertex %streamNum
               OpEndStreamPrimitive %streamNum
               OpReturn
               OpFunctionEnd
#version 450

layout(lines_adjacency) in;
layout(location = 0) in vec4 in0[];

layout(line_strip, max_vertices = 2) out;
layout(stream = 3, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;
    out0 = in0[0];
    EmitStreamVertex(3);
    out0 = in0[1];
    EmitStreamVertex(3);
    EndStreamPrimitive(3);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 64
; Schema: 0
               OpCapability Geometry
               OpCapability TransformFeedback
               OpCapability GeometryStreams
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Geometry %main "main" %outBlock %in0 %InputBuiltInArrayVar %OutputBuiltInsVar
               OpExecutionMode %main Xfb
               OpExecutionMode %main InputLinesAdjacency
               OpExecutionMode %main Invocations 1
               OpExecutionMode %main OutputLineStrip
               OpExecutionMode %main OutputVertices 2
               OpSource GLSL 450
               OpSourceExtension "GL_ARB_enhanced_layouts"
               OpName %main "main"
               OpName %OutBlock "OutBlock"
               OpMemberName %OutBlock 0 "out0"
               OpName %outBlock "outBlock"
               OpName %in0 "in0"
               OpMemberDecorate %OutBlock 0 Location 0
               OpMemberDecorate %OutBlock 0 Offset 0
               OpMemberDecorate %OutBlock 0 Stream 3
               OpMemberDecorate %OutBlock 0 XfbBuffer 0
               OpMemberDecorate %OutBlock 0 XfbStride 16
               OpDecorate %OutBlock Block
               OpMemberDecorate %BuiltIns 0 BuiltIn Position
               OpMemberDecorate %BuiltIns 1 BuiltIn PointSize
               OpDecorate %BuiltIns Block
               OpDecorate %in0 Location 0
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
   %OutBlock = OpTypeStruct %v4float
%_ptr_Output_OutBlock = OpTypePointer Output %OutBlock
   %outBlock = OpVariable %_ptr_Output_OutBlock Output
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%int_1 = OpConstant %int 1
%int_2 = OpConstant %int 2
       %uint = OpTypeInt 32 0
     %uint_0 = OpConstant %uint 2
%_arr_v4float_uint_0 = OpTypeArray %v4float %uint_0
%_ptr_Input__arr_v4float_uint_0 = OpTypePointer Input %_arr_v4float_uint_0
        %in0 = OpVariable %_ptr_Input__arr_v4float_uint_0 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Input_float = OpTypePointer Input %float
%_ptr_Output_v4float = OpTypePointer Output %v4float
%_ptr_Output_float = OpTypePointer Output %float
  %streamNum = OpConstant %int 3
%BuiltIns = OpTypeStruct %v4float %float
%InputBuiltInArray = OpTypeArray %BuiltIns %int_1
%InputBuiltInArrayPtr = OpTypePointer Input %InputBuiltInArray
%InputBuiltInArrayVar = OpVariable %InputBuiltInArrayPtr Input
%OutputBuiltInsPtr = OpTypePointer Output %BuiltIns
%OutputBuiltInsVar = OpVariable %OutputBuiltInsPtr Output
       %main = OpFunction %void None %3
          %5 = OpLabel
%in_gl_Position_Ptr = OpAccessChain %_ptr_Input_v4float %InputBuiltInArrayVar %int_0 %int_0
%in_gl_Position = OpLoad %v4float %in_gl_Position_Ptr
%out_gl_Position_Ptr = OpAccessChain %_ptr_Output_v4float %OutputBuiltInsVar %int_0
%in_gl_PointSize_Ptr = OpAccessChain %_ptr_Input_float %InputBuiltInArrayVar %int_0 %int_1
%in_gl_PointSize = OpLoad %float %in_gl_PointSize_Ptr
%out_gl_PointSize_Ptr = OpAccessChain %_ptr_Output_float %OutputBuiltInsVar %int_1
%11 = OpAccessChain %_ptr_Input_v4float %in0 %int_1
          %12 = OpLoad %v4float %11
          %13 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %13 %12
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpStore %out_gl_PointSize_Ptr %in_gl_PointSize
               OpEmitStreamVertex %streamNum
%21 = OpAccessChain %_ptr_Input_v4float %in0 %int_2
          %22 = OpLoad %v4float %21
          %23 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %23 %22
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpStore %out_gl_PointSize_Ptr %in_gl_PointSize
               OpEmitStreamVertex %streamNum
               OpEndStreamPrimitive %streamNum
               OpReturn
               OpFunctionEnd
#version 450

layout(lines_adjacency) in;
layout(location = 0) in vec4 in0[];

layout(line_strip, max_vertices = 2) out;
layout(stream = 6, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;
    out0 = in0[0];
    EmitStreamVertex(6);
    out0 = in0[1];
    EmitStreamVertex(6);
    EndStreamPrimitive(6);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 64
; Schema: 0
               OpCapability Geometry
               OpCapability TransformFeedback
               OpCapability GeometryStreams
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Geometry %main "main" %outBlock %in0 %InputBuiltInArrayVar %OutputBuiltInsVar
               OpExecutionMode %main Xfb
               OpExecutionMode %main InputLinesAdjacency
               OpExecutionMode %main Invocations 1
               OpExecutionMode %main OutputLineStrip
               OpExecutionMode %main OutputVertices 2
               OpSource GLSL 450
               OpSourceExtension "GL_ARB_enhanced_layouts"
               OpName %main "main"
               OpName %OutBlock "OutBlock"
               OpMemberName %OutBlock 0 "out0"
               OpName %outBlock "outBlock"
               OpName %in0 "in0"
               OpMemberDecorate %OutBlock 0 Location 0
               OpMemberDecorate %OutBlock 0 Offset 0
               OpMemberDecorate %OutBlock 0 Stream 6
               OpMemberDecorate %OutBlock 0 XfbBuffer 0
               OpMemberDecorate %OutBlock 0 XfbStride 16
               OpDecorate %OutBlock Block
               OpMemberDecorate %BuiltIns 0 BuiltIn Position
               OpMemberDecorate %BuiltIns 1 BuiltIn PointSize
               OpDecorate %BuiltIns Block
               OpDecorate %in0 Location 0
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
   %OutBlock = OpTypeStruct %v4float
%_ptr_Output_OutBlock = OpTypePointer Output %OutBlock
   %outBlock = OpVariable %_ptr_Output_OutBlock Output
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%int_1 = OpConstant %int 1
%int_2 = OpConstant %int 2
       %uint = OpTypeInt 32 0
     %uint_0 = OpConstant %uint 2
%_arr_v4float_uint_0 = OpTypeArray %v4float %uint_0
%_ptr_Input__arr_v4float_uint_0 = OpTypePointer Input %_arr_v4float_uint_0
        %in0 = OpVariable %_ptr_Input__arr_v4float_uint_0 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Input_float = OpTypePointer Input %float
%_ptr_Output_v4float = OpTypePointer Output %v4float
%_ptr_Output_float = OpTypePointer Output %float
  %streamNum = OpConstant %int 6
%BuiltIns = OpTypeStruct %v4float %float
%InputBuiltInArray = OpTypeArray %BuiltIns %int_1
%InputBuiltInArrayPtr = OpTypePointer Input %InputBuiltInArray
%InputBuiltInArrayVar = OpVariable %InputBuiltInArrayPtr Input
%OutputBuiltInsPtr = OpTypePointer Output %BuiltIns
%OutputBuiltInsVar = OpVariable %OutputBuiltInsPtr Output
       %main = OpFunction %void None %3
          %5 = OpLabel
%in_gl_Position_Ptr = OpAccessChain %_ptr_Input_v4float %InputBuiltInArrayVar %int_0 %int_0
%in_gl_Position = OpLoad %v4float %in_gl_Position_Ptr
%out_gl_Position_Ptr = OpAccessChain %_ptr_Output_v4float %OutputBuiltInsVar %int_0
%in_gl_PointSize_Ptr = OpAccessChain %_ptr_Input_float %InputBuiltInArrayVar %int_0 %int_1
%in_gl_PointSize = OpLoad %float %in_gl_PointSize_Ptr
%out_gl_PointSize_Ptr = OpAccessChain %_ptr_Output_float %OutputBuiltInsVar %int_1
%11 = OpAccessChain %_ptr_Input_v4float %in0 %int_1
          %12 = OpLoad %v4float %11
          %13 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %13 %12
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpStore %out_gl_PointSize_Ptr %in_gl_PointSize
               OpEmitStreamVertex %streamNum
%21 = OpAccessChain %_ptr_Input_v4float %in0 %int_2
          %22 = OpLoad %v4float %21
          %23 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %23 %22
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpStore %out_gl_PointSize_Ptr %in_gl_PointSize
               OpEmitStreamVertex %streamNum
               OpEndStreamPrimitive %streamNum
               OpReturn
               OpFunctionEnd
#version 450

layout(lines_adjacency) in;
layout(location = 0) in vec4 in0[];

layout(line_strip, max_vertices = 2) out;
layout(stream = 14, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;
    out0 = in0[0];
    EmitStreamVertex(14);
    out0 = in0[1];
    EmitStreamVertex(14);
    EndStreamPrimitive(14);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 64
; Schema: 0
               OpCapability Geometry
               OpCapability TransformFeedback
               OpCapability GeometryStreams
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Geometry %main "main" %outBlock %in0 %InputBuiltInArrayVar %OutputBuiltInsVar
               OpExecutionMode %main Xfb
               OpExecutionMode %main InputLinesAdjacency
               OpExecutionMode %main Invocations 1
               OpExecutionMode %main OutputLineStrip
               OpExecutionMode %main OutputVertices 2
               OpSource GLSL 450
               OpSourceExtension "GL_ARB_enhanced_layouts"
               OpName %main "main"
               OpName %OutBlock "OutBlock"
               OpMemberName %OutBlock 0 "out0"
               OpName %outBlock "outBlock"
               OpName %in0 "in0"
               OpMemberDecorate %OutBlock 0 Location 0
               OpMemberDecorate %OutBlock 0 Offset 0
               OpMemberDecorate %OutBlock 0 Stream 14
               OpMemberDecorate %OutBlock 0 XfbBuffer 0
               OpMemberDecorate %OutBlock 0 XfbStride 16
               OpDecorate %OutBlock Block
               OpMemberDecorate %BuiltIns 0 BuiltIn Position
               OpMemberDecorate %BuiltIns 1 BuiltIn PointSize
               OpDecorate %BuiltIns Block
               OpDecorate %in0 Location 0
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
   %OutBlock = OpTypeStruct %v4float
%_ptr_Output_OutBlock = OpTypePointer Output %OutBlock
   %outBlock = OpVariable %_ptr_Output_OutBlock Output
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%int_1 = OpConstant %int 1
%int_2 = OpConstant %int 2
       %uint = OpTypeInt 32 0
     %uint_0 = OpConstant %uint 2
%_arr_v4float_uint_0 = OpTypeArray %v4float %uint_0
%_ptr_Input__arr_v4float_uint_0 = OpTypePointer Input %_arr_v4float_uint_0
        %in0 = OpVariable %_ptr_Input__arr_v4float_uint_0 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Input_float = OpTypePointer Input %float
%_ptr_Output_v4float = OpTypePointer Output %v4float
%_ptr_Output_float = OpTypePointer Output %float
  %streamNum = OpConstant %int 14
%BuiltIns = OpTypeStruct %v4float %float
%InputBuiltInArray = OpTypeArray %BuiltIns %int_1
%InputBuiltInArrayPtr = OpTypePointer Input %InputBuiltInArray
%InputBuiltInArrayVar = OpVariable %InputBuiltInArrayPtr Input
%OutputBuiltInsPtr = OpTypePointer Output %BuiltIns
%OutputBuiltInsVar = OpVariable %OutputBuiltInsPtr Output
       %main = OpFunction %void None %3
          %5 = OpLabel
%in_gl_Position_Ptr = OpAccessChain %_ptr_Input_v4float %InputBuiltInArrayVar %int_0 %int_0
%in_gl_Position = OpLoad %v4float %in_gl_Position_Ptr
%out_gl_Position_Ptr = OpAccessChain %_ptr_Output_v4float %OutputBuiltInsVar %int_0
%in_gl_PointSize_Ptr = OpAccessChain %_ptr_Input_float %InputBuiltInArrayVar %int_0 %int_1
%in_gl_PointSize = OpLoad %float %in_gl_PointSize_Ptr
%out_gl_PointSize_Ptr = OpAccessChain %_ptr_Output_float %OutputBuiltInsVar %int_1
%11 = OpAccessChain %_ptr_Input_v4float %in0 %int_1
          %12 = OpLoad %v4float %11
          %13 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %13 %12
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpStore %out_gl_PointSize_Ptr %in_gl_PointSize
               OpEmitStreamVertex %streamNum
%21 = OpAccessChain %_ptr_Input_v4float %in0 %int_2
          %22 = OpLoad %v4float %21
          %23 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %23 %22
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpStore %out_gl_PointSize_Ptr %in_gl_PointSize
               OpEmitStreamVertex %streamNum
               OpEndStreamPrimitive %streamNum
               OpReturn
               OpFunctionEnd
#version 450

layout(triangles_adjacency) in;
layout(location = 0) in vec4 in0[];

layout(triangle_strip, max_vertices = 3) out;
layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    out0 = in0[0];
    EmitVertex();
    out0 = in0[1];
    EmitVertex();
    out0 = in0[2];
    EmitVertex();
    EndPrimitive();
}
#version 450

layout(triangles_adjacency) in;
layout(location = 0) in vec4 in0[];

layout(triangle_strip, max_vertices = 3) out;
layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    EmitVertex();
    EmitVertex();
    EmitVertex();
    EndPrimitive();
}
#version 450

layout(triangles_adjacency) in;
layout(location = 0) in vec4 in0[];

layout(triangle_strip, max_vertices = 3) out;
layout(stream = 1, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    out0 = in0[0];
    EmitStreamVertex(1);
    out0 = in0[1];
    EmitStreamVertex(1);
    out0 = in0[2];
    EmitStreamVertex(1);
    EndStreamPrimitive(1);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 64
; Schema: 0
               OpCapability Geometry
               OpCapability TransformFeedback
               OpCapability GeometryStreams
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Geometry %main "main" %outBlock %in0 %InputBuiltInArrayVar %OutputBuiltInsVar
               OpExecutionMode %main Xfb
               OpExecutionMode %main InputTrianglesAdjacency
               OpExecutionMode %main Invocations 1
               OpExecutionMode %main OutputTriangleStrip
               OpExecutionMode %main OutputVertices 3
               OpSource GLSL 450
               OpSourceExtension "GL_ARB_enhanced_layouts"
               OpName %main "main"
               OpName %OutBlock "OutBlock"
               OpMemberName %OutBlock 0 "out0"
               OpName %outBlock "outBlock"
               OpName %in0 "in0"
               OpMemberDecorate %OutBlock 0 Location 0
               OpMemberDecorate %OutBlock 0 Offset 0
               OpMemberDecorate %OutBlock 0 Stream 1
               OpMemberDecorate %OutBlock 0 XfbBuffer 0
               OpMemberDecorate %OutBlock 0 XfbStride 16
               OpDecorate %OutBlock Block
               OpMemberDecorate %BuiltIns 0 BuiltIn Position
               OpDecorate %BuiltIns Block
               OpDecorate %in0 Location 0
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
   %OutBlock = OpTypeStruct %v4float
%_ptr_Output_OutBlock = OpTypePointer Output %OutBlock
   %outBlock = OpVariable %_ptr_Output_OutBlock Output
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%int_1 = OpConstant %int 1
%int_2 = OpConstant %int 2
%int_3 = OpConstant %int 3
       %uint = OpTypeInt 32 0
     %uint_0 = OpConstant %uint 3
%_arr_v4float_uint_0 = OpTypeArray %v4float %uint_0
%_ptr_Input__arr_v4float_uint_0 = OpTypePointer Input %_arr_v4float_uint_0
        %in0 = OpVariable %_ptr_Input__arr_v4float_uint_0 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Input_float = OpTypePointer Input %float
%_ptr_Output_v4float = OpTypePointer Output %v4float
%_ptr_Output_float = OpTypePointer Output %float
  %streamNum = OpConstant %int 1
%BuiltIns = OpTypeStruct %v4float
%InputBuiltInArray = OpTypeArray %BuiltIns %int_1
%InputBuiltInArrayPtr = OpTypePointer Input %InputBuiltInArray
%InputBuiltInArrayVar = OpVariable %InputBuiltInArrayPtr Input
%OutputBuiltInsPtr = OpTypePointer Output %BuiltIns
%OutputBuiltInsVar = OpVariable %OutputBuiltInsPtr Output
       %main = OpFunction %void None %3
          %5 = OpLabel
%in_gl_Position_Ptr = OpAccessChain %_ptr_Input_v4float %InputBuiltInArrayVar %int_0 %int_0
%in_gl_Position = OpLoad %v4float %in_gl_Position_Ptr
%out_gl_Position_Ptr = OpAccessChain %_ptr_Output_v4float %OutputBuiltInsVar %int_0
%11 = OpAccessChain %_ptr_Input_v4float %in0 %int_1
          %12 = OpLoad %v4float %11
          %13 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %13 %12
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpEmitStreamVertex %streamNum
%21 = OpAccessChain %_ptr_Input_v4float %in0 %int_2
          %22 = OpLoad %v4float %21
          %23 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %23 %22
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpEmitStreamVertex %streamNum
%31 = OpAccessChain %_ptr_Input_v4float %in0 %int_3
          %32 = OpLoad %v4float %31
          %33 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %33 %32
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpEmitStreamVertex %streamNum
               OpEndStreamPrimitive %streamNum
               OpReturn
               OpFunctionEnd
#version 450

layout(triangles_adjacency) in;
layout(location = 0) in vec4 in0[];

layout(triangle_strip, max_vertices = 3) out;
layout(stream = 3, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    out0 = in0[0];
    EmitStreamVertex(3);
    out0 = in0[1];
    EmitStreamVertex(3);
    out0 = in0[2];
    EmitStreamVertex(3);
    EndStreamPrimitive(3);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 64
; Schema: 0
               OpCapability Geometry
               OpCapability TransformFeedback
               OpCapability GeometryStreams
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Geometry %main "main" %outBlock %in0 %InputBuiltInArrayVar %OutputBuiltInsVar
               OpExecutionMode %main Xfb
               OpExecutionMode %main InputTrianglesAdjacency
               OpExecutionMode %main Invocations 1
               OpExecutionMode %main OutputTriangleStrip
               OpExecutionMode %main OutputVertices 3
               OpSource GLSL 450
               OpSourceExtension "GL_ARB_enhanced_layouts"
               OpName %main "main"
               OpName %OutBlock "OutBlock"
               OpMemberName %OutBlock 0 "out0"
               OpName %outBlock "outBlock"
               OpName %in0 "in0"
               OpMemberDecorate %OutBlock 0 Location 0
               OpMemberDecorate %OutBlock 0 Offset 0
               OpMemberDecorate %OutBlock 0 Stream 3
               OpMemberDecorate %OutBlock 0 XfbBuffer 0
               OpMemberDecorate %OutBlock 0 XfbStride 16
               OpDecorate %OutBlock Block
               OpMemberDecorate %BuiltIns 0 BuiltIn Position
               OpDecorate %BuiltIns Block
               OpDecorate %in0 Location 0
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
   %OutBlock = OpTypeStruct %v4float
%_ptr_Output_OutBlock = OpTypePointer Output %OutBlock
   %outBlock = OpVariable %_ptr_Output_OutBlock Output
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%int_1 = OpConstant %int 1
%int_2 = OpConstant %int 2
%int_3 = OpConstant %int 3
       %uint = OpTypeInt 32 0
     %uint_0 = OpConstant %uint 3
%_arr_v4float_uint_0 = OpTypeArray %v4float %uint_0
%_ptr_Input__arr_v4float_uint_0 = OpTypePointer Input %_arr_v4float_uint_0
        %in0 = OpVariable %_ptr_Input__arr_v4float_uint_0 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Input_float = OpTypePointer Input %float
%_ptr_Output_v4float = OpTypePointer Output %v4float
%_ptr_Output_float = OpTypePointer Output %float
  %streamNum = OpConstant %int 3
%BuiltIns = OpTypeStruct %v4float
%InputBuiltInArray = OpTypeArray %BuiltIns %int_1
%InputBuiltInArrayPtr = OpTypePointer Input %InputBuiltInArray
%InputBuiltInArrayVar = OpVariable %InputBuiltInArrayPtr Input
%OutputBuiltInsPtr = OpTypePointer Output %BuiltIns
%OutputBuiltInsVar = OpVariable %OutputBuiltInsPtr Output
       %main = OpFunction %void None %3
          %5 = OpLabel
%in_gl_Position_Ptr = OpAccessChain %_ptr_Input_v4float %InputBuiltInArrayVar %int_0 %int_0
%in_gl_Position = OpLoad %v4float %in_gl_Position_Ptr
%out_gl_Position_Ptr = OpAccessChain %_ptr_Output_v4float %OutputBuiltInsVar %int_0
%11 = OpAccessChain %_ptr_Input_v4float %in0 %int_1
          %12 = OpLoad %v4float %11
          %13 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %13 %12
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpEmitStreamVertex %streamNum
%21 = OpAccessChain %_ptr_Input_v4float %in0 %int_2
          %22 = OpLoad %v4float %21
          %23 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %23 %22
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpEmitStreamVertex %streamNum
%31 = OpAccessChain %_ptr_Input_v4float %in0 %int_3
          %32 = OpLoad %v4float %31
          %33 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %33 %32
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpEmitStreamVertex %streamNum
               OpEndStreamPrimitive %streamNum
               OpReturn
               OpFunctionEnd
#version 450

layout(triangles_adjacency) in;
layout(location = 0) in vec4 in0[];

layout(triangle_strip, max_vertices = 3) out;
layout(stream = 6, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    out0 = in0[0];
    EmitStreamVertex(6);
    out0 = in0[1];
    EmitStreamVertex(6);
    out0 = in0[2];
    EmitStreamVertex(6);
    EndStreamPrimitive(6);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 64
; Schema: 0
               OpCapability Geometry
               OpCapability TransformFeedback
               OpCapability GeometryStreams
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Geometry %main "main" %outBlock %in0 %InputBuiltInArrayVar %OutputBuiltInsVar
               OpExecutionMode %main Xfb
               OpExecutionMode %main InputTrianglesAdjacency
               OpExecutionMode %main Invocations 1
               OpExecutionMode %main OutputTriangleStrip
               OpExecutionMode %main OutputVertices 3
               OpSource GLSL 450
               OpSourceExtension "GL_ARB_enhanced_layouts"
               OpName %main "main"
               OpName %OutBlock "OutBlock"
               OpMemberName %OutBlock 0 "out0"
               OpName %outBlock "outBlock"
               OpName %in0 "in0"
               OpMemberDecorate %OutBlock 0 Location 0
               OpMemberDecorate %OutBlock 0 Offset 0
               OpMemberDecorate %OutBlock 0 Stream 6
               OpMemberDecorate %OutBlock 0 XfbBuffer 0
               OpMemberDecorate %OutBlock 0 XfbStride 16
               OpDecorate %OutBlock Block
               OpMemberDecorate %BuiltIns 0 BuiltIn Position
               OpDecorate %BuiltIns Block
               OpDecorate %in0 Location 0
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
   %OutBlock = OpTypeStruct %v4float
%_ptr_Output_OutBlock = OpTypePointer Output %OutBlock
   %outBlock = OpVariable %_ptr_Output_OutBlock Output
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%int_1 = OpConstant %int 1
%int_2 = OpConstant %int 2
%int_3 = OpConstant %int 3
       %uint = OpTypeInt 32 0
     %uint_0 = OpConstant %uint 3
%_arr_v4float_uint_0 = OpTypeArray %v4float %uint_0
%_ptr_Input__arr_v4float_uint_0 = OpTypePointer Input %_arr_v4float_uint_0
        %in0 = OpVariable %_ptr_Input__arr_v4float_uint_0 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Input_float = OpTypePointer Input %float
%_ptr_Output_v4float = OpTypePointer Output %v4float
%_ptr_Output_float = OpTypePointer Output %float
  %streamNum = OpConstant %int 6
%BuiltIns = OpTypeStruct %v4float
%InputBuiltInArray = OpTypeArray %BuiltIns %int_1
%InputBuiltInArrayPtr = OpTypePointer Input %InputBuiltInArray
%InputBuiltInArrayVar = OpVariable %InputBuiltInArrayPtr Input
%OutputBuiltInsPtr = OpTypePointer Output %BuiltIns
%OutputBuiltInsVar = OpVariable %OutputBuiltInsPtr Output
       %main = OpFunction %void None %3
          %5 = OpLabel
%in_gl_Position_Ptr = OpAccessChain %_ptr_Input_v4float %InputBuiltInArrayVar %int_0 %int_0
%in_gl_Position = OpLoad %v4float %in_gl_Position_Ptr
%out_gl_Position_Ptr = OpAccessChain %_ptr_Output_v4float %OutputBuiltInsVar %int_0
%11 = OpAccessChain %_ptr_Input_v4float %in0 %int_1
          %12 = OpLoad %v4float %11
          %13 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %13 %12
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpEmitStreamVertex %streamNum
%21 = OpAccessChain %_ptr_Input_v4float %in0 %int_2
          %22 = OpLoad %v4float %21
          %23 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %23 %22
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpEmitStreamVertex %streamNum
%31 = OpAccessChain %_ptr_Input_v4float %in0 %int_3
          %32 = OpLoad %v4float %31
          %33 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %33 %32
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpEmitStreamVertex %streamNum
               OpEndStreamPrimitive %streamNum
               OpReturn
               OpFunctionEnd
#version 450

layout(triangles_adjacency) in;
layout(location = 0) in vec4 in0[];

layout(triangle_strip, max_vertices = 3) out;
layout(stream = 14, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    out0 = in0[0];
    EmitStreamVertex(14);
    out0 = in0[1];
    EmitStreamVertex(14);
    out0 = in0[2];
    EmitStreamVertex(14);
    EndStreamPrimitive(14);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 64
; Schema: 0
               OpCapability Geometry
               OpCapability TransformFeedback
               OpCapability GeometryStreams
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Geometry %main "main" %outBlock %in0 %InputBuiltInArrayVar %OutputBuiltInsVar
               OpExecutionMode %main Xfb
               OpExecutionMode %main InputTrianglesAdjacency
               OpExecutionMode %main Invocations 1
               OpExecutionMode %main OutputTriangleStrip
               OpExecutionMode %main OutputVertices 3
               OpSource GLSL 450
               OpSourceExtension "GL_ARB_enhanced_layouts"
               OpName %main "main"
               OpName %OutBlock "OutBlock"
               OpMemberName %OutBlock 0 "out0"
               OpName %outBlock "outBlock"
               OpName %in0 "in0"
               OpMemberDecorate %OutBlock 0 Location 0
               OpMemberDecorate %OutBlock 0 Offset 0
               OpMemberDecorate %OutBlock 0 Stream 14
               OpMemberDecorate %OutBlock 0 XfbBuffer 0
               OpMemberDecorate %OutBlock 0 XfbStride 16
               OpDecorate %OutBlock Block
               OpMemberDecorate %BuiltIns 0 BuiltIn Position
               OpDecorate %BuiltIns Block
               OpDecorate %in0 Location 0
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
   %OutBlock = OpTypeStruct %v4float
%_ptr_Output_OutBlock = OpTypePointer Output %OutBlock
   %outBlock = OpVariable %_ptr_Output_OutBlock Output
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%int_1 = OpConstant %int 1
%int_2 = OpConstant %int 2
%int_3 = OpConstant %int 3
       %uint = OpTypeInt 32 0
     %uint_0 = OpConstant %uint 3
%_arr_v4float_uint_0 = OpTypeArray %v4float %uint_0
%_ptr_Input__arr_v4float_uint_0 = OpTypePointer Input %_arr_v4float_uint_0
        %in0 = OpVariable %_ptr_Input__arr_v4float_uint_0 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Input_float = OpTypePointer Input %float
%_ptr_Output_v4float = OpTypePointer Output %v4float
%_ptr_Output_float = OpTypePointer Output %float
  %streamNum = OpConstant %int 14
%BuiltIns = OpTypeStruct %v4float
%InputBuiltInArray = OpTypeArray %BuiltIns %int_1
%InputBuiltInArrayPtr = OpTypePointer Input %InputBuiltInArray
%InputBuiltInArrayVar = OpVariable %InputBuiltInArrayPtr Input
%OutputBuiltInsPtr = OpTypePointer Output %BuiltIns
%OutputBuiltInsVar = OpVariable %OutputBuiltInsPtr Output
       %main = OpFunction %void None %3
          %5 = OpLabel
%in_gl_Position_Ptr = OpAccessChain %_ptr_Input_v4float %InputBuiltInArrayVar %int_0 %int_0
%in_gl_Position = OpLoad %v4float %in_gl_Position_Ptr
%out_gl_Position_Ptr = OpAccessChain %_ptr_Output_v4float %OutputBuiltInsVar %int_0
%11 = OpAccessChain %_ptr_Input_v4float %in0 %int_1
          %12 = OpLoad %v4float %11
          %13 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %13 %12
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpEmitStreamVertex %streamNum
%21 = OpAccessChain %_ptr_Input_v4float %in0 %int_2
          %22 = OpLoad %v4float %21
          %23 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %23 %22
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpEmitStreamVertex %streamNum
%31 = OpAccessChain %_ptr_Input_v4float %in0 %int_3
          %32 = OpLoad %v4float %31
          %33 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %33 %32
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpEmitStreamVertex %streamNum
               OpEndStreamPrimitive %streamNum
               OpReturn
               OpFunctionEnd
#version 450

layout(triangles_adjacency) in;
layout(location = 0) in vec4 in0[];

layout(triangle_strip, max_vertices = 3) out;
layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;
    out0 = in0[0];
    EmitVertex();
    out0 = in0[1];
    EmitVertex();
    out0 = in0[2];
    EmitVertex();
    EndPrimitive();
}
#version 450

layout(triangles_adjacency) in;
layout(location = 0) in vec4 in0[];

layout(triangle_strip, max_vertices = 3) out;
layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;
    EmitVertex();
    EmitVertex();
    EmitVertex();
    EndPrimitive();
}
#version 450

layout(triangles_adjacency) in;
layout(location = 0) in vec4 in0[];

layout(triangle_strip, max_vertices = 3) out;
layout(stream = 1, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;
    out0 = in0[0];
    EmitStreamVertex(1);
    out0 = in0[1];
    EmitStreamVertex(1);
    out0 = in0[2];
    EmitStreamVertex(1);
    EndStreamPrimitive(1);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 64
; Schema: 0
               OpCapability Geometry
               OpCapability TransformFeedback
               OpCapability GeometryStreams
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Geometry %main "main" %outBlock %in0 %InputBuiltInArrayVar %OutputBuiltInsVar
               OpExecutionMode %main Xfb
               OpExecutionMode %main InputTrianglesAdjacency
               OpExecutionMode %main Invocations 1
               OpExecutionMode %main OutputTriangleStrip
               OpExecutionMode %main OutputVertices 3
               OpSource GLSL 450
               OpSourceExtension "GL_ARB_enhanced_layouts"
               OpName %main "main"
               OpName %OutBlock "OutBlock"
               OpMemberName %OutBlock 0 "out0"
               OpName %outBlock "outBlock"
               OpName %in0 "in0"
               OpMemberDecorate %OutBlock 0 Location 0
               OpMemberDecorate %OutBlock 0 Offset 0
               OpMemberDecorate %OutBlock 0 Stream 1
               OpMemberDecorate %OutBlock 0 XfbBuffer 0
               OpMemberDecorate %OutBlock 0 XfbStride 16
               OpDecorate %OutBlock Block
               OpMemberDecorate %BuiltIns 0 BuiltIn Position
               OpMemberDecorate %BuiltIns 1 BuiltIn PointSize
               OpDecorate %BuiltIns Block
               OpDecorate %in0 Location 0
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
   %OutBlock = OpTypeStruct %v4float
%_ptr_Output_OutBlock = OpTypePointer Output %OutBlock
   %outBlock = OpVariable %_ptr_Output_OutBlock Output
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%int_1 = OpConstant %int 1
%int_2 = OpConstant %int 2
%int_3 = OpConstant %int 3
       %uint = OpTypeInt 32 0
     %uint_0 = OpConstant %uint 3
%_arr_v4float_uint_0 = OpTypeArray %v4float %uint_0
%_ptr_Input__arr_v4float_uint_0 = OpTypePointer Input %_arr_v4float_uint_0
        %in0 = OpVariable %_ptr_Input__arr_v4float_uint_0 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Input_float = OpTypePointer Input %float
%_ptr_Output_v4float = OpTypePointer Output %v4float
%_ptr_Output_float = OpTypePointer Output %float
  %streamNum = OpConstant %int 1
%BuiltIns = OpTypeStruct %v4float %float
%InputBuiltInArray = OpTypeArray %BuiltIns %int_1
%InputBuiltInArrayPtr = OpTypePointer Input %InputBuiltInArray
%InputBuiltInArrayVar = OpVariable %InputBuiltInArrayPtr Input
%OutputBuiltInsPtr = OpTypePointer Output %BuiltIns
%OutputBuiltInsVar = OpVariable %OutputBuiltInsPtr Output
       %main = OpFunction %void None %3
          %5 = OpLabel
%in_gl_Position_Ptr = OpAccessChain %_ptr_Input_v4float %InputBuiltInArrayVar %int_0 %int_0
%in_gl_Position = OpLoad %v4float %in_gl_Position_Ptr
%out_gl_Position_Ptr = OpAccessChain %_ptr_Output_v4float %OutputBuiltInsVar %int_0
%in_gl_PointSize_Ptr = OpAccessChain %_ptr_Input_float %InputBuiltInArrayVar %int_0 %int_1
%in_gl_PointSize = OpLoad %float %in_gl_PointSize_Ptr
%out_gl_PointSize_Ptr = OpAccessChain %_ptr_Output_float %OutputBuiltInsVar %int_1
%11 = OpAccessChain %_ptr_Input_v4float %in0 %int_1
          %12 = OpLoad %v4float %11
          %13 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %13 %12
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpStore %out_gl_PointSize_Ptr %in_gl_PointSize
               OpEmitStreamVertex %streamNum
%21 = OpAccessChain %_ptr_Input_v4float %in0 %int_2
          %22 = OpLoad %v4float %21
          %23 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %23 %22
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpStore %out_gl_PointSize_Ptr %in_gl_PointSize
               OpEmitStreamVertex %streamNum
%31 = OpAccessChain %_ptr_Input_v4float %in0 %int_3
          %32 = OpLoad %v4float %31
          %33 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %33 %32
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpStore %out_gl_PointSize_Ptr %in_gl_PointSize
               OpEmitStreamVertex %streamNum
               OpEndStreamPrimitive %streamNum
               OpReturn
               OpFunctionEnd
#version 450

layout(triangles_adjacency) in;
layout(location = 0) in vec4 in0[];

layout(triangle_strip, max_vertices = 3) out;
layout(stream = 3, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;
    out0 = in0[0];
    EmitStreamVertex(3);
    out0 = in0[1];
    EmitStreamVertex(3);
    out0 = in0[2];
    EmitStreamVertex(3);
    EndStreamPrimitive(3);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 64
; Schema: 0
               OpCapability Geometry
               OpCapability TransformFeedback
               OpCapability GeometryStreams
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Geometry %main "main" %outBlock %in0 %InputBuiltInArrayVar %OutputBuiltInsVar
               OpExecutionMode %main Xfb
               OpExecutionMode %main InputTrianglesAdjacency
               OpExecutionMode %main Invocations 1
               OpExecutionMode %main OutputTriangleStrip
               OpExecutionMode %main OutputVertices 3
               OpSource GLSL 450
               OpSourceExtension "GL_ARB_enhanced_layouts"
               OpName %main "main"
               OpName %OutBlock "OutBlock"
               OpMemberName %OutBlock 0 "out0"
               OpName %outBlock "outBlock"
               OpName %in0 "in0"
               OpMemberDecorate %OutBlock 0 Location 0
               OpMemberDecorate %OutBlock 0 Offset 0
               OpMemberDecorate %OutBlock 0 Stream 3
               OpMemberDecorate %OutBlock 0 XfbBuffer 0
               OpMemberDecorate %OutBlock 0 XfbStride 16
               OpDecorate %OutBlock Block
               OpMemberDecorate %BuiltIns 0 BuiltIn Position
               OpMemberDecorate %BuiltIns 1 BuiltIn PointSize
               OpDecorate %BuiltIns Block
               OpDecorate %in0 Location 0
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
   %OutBlock = OpTypeStruct %v4float
%_ptr_Output_OutBlock = OpTypePointer Output %OutBlock
   %outBlock = OpVariable %_ptr_Output_OutBlock Output
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%int_1 = OpConstant %int 1
%int_2 = OpConstant %int 2
%int_3 = OpConstant %int 3
       %uint = OpTypeInt 32 0
     %uint_0 = OpConstant %uint 3
%_arr_v4float_uint_0 = OpTypeArray %v4float %uint_0
%_ptr_Input__arr_v4float_uint_0 = OpTypePointer Input %_arr_v4float_uint_0
        %in0 = OpVariable %_ptr_Input__arr_v4float_uint_0 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Input_float = OpTypePointer Input %float
%_ptr_Output_v4float = OpTypePointer Output %v4float
%_ptr_Output_float = OpTypePointer Output %float
  %streamNum = OpConstant %int 3
%BuiltIns = OpTypeStruct %v4float %float
%InputBuiltInArray = OpTypeArray %BuiltIns %int_1
%InputBuiltInArrayPtr = OpTypePointer Input %InputBuiltInArray
%InputBuiltInArrayVar = OpVariable %InputBuiltInArrayPtr Input
%OutputBuiltInsPtr = OpTypePointer Output %BuiltIns
%OutputBuiltInsVar = OpVariable %OutputBuiltInsPtr Output
       %main = OpFunction %void None %3
          %5 = OpLabel
%in_gl_Position_Ptr = OpAccessChain %_ptr_Input_v4float %InputBuiltInArrayVar %int_0 %int_0
%in_gl_Position = OpLoad %v4float %in_gl_Position_Ptr
%out_gl_Position_Ptr = OpAccessChain %_ptr_Output_v4float %OutputBuiltInsVar %int_0
%in_gl_PointSize_Ptr = OpAccessChain %_ptr_Input_float %InputBuiltInArrayVar %int_0 %int_1
%in_gl_PointSize = OpLoad %float %in_gl_PointSize_Ptr
%out_gl_PointSize_Ptr = OpAccessChain %_ptr_Output_float %OutputBuiltInsVar %int_1
%11 = OpAccessChain %_ptr_Input_v4float %in0 %int_1
          %12 = OpLoad %v4float %11
          %13 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %13 %12
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpStore %out_gl_PointSize_Ptr %in_gl_PointSize
               OpEmitStreamVertex %streamNum
%21 = OpAccessChain %_ptr_Input_v4float %in0 %int_2
          %22 = OpLoad %v4float %21
          %23 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %23 %22
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpStore %out_gl_PointSize_Ptr %in_gl_PointSize
               OpEmitStreamVertex %streamNum
%31 = OpAccessChain %_ptr_Input_v4float %in0 %int_3
          %32 = OpLoad %v4float %31
          %33 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %33 %32
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpStore %out_gl_PointSize_Ptr %in_gl_PointSize
               OpEmitStreamVertex %streamNum
               OpEndStreamPrimitive %streamNum
               OpReturn
               OpFunctionEnd
#version 450

layout(triangles_adjacency) in;
layout(location = 0) in vec4 in0[];

layout(triangle_strip, max_vertices = 3) out;
layout(stream = 6, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;
    out0 = in0[0];
    EmitStreamVertex(6);
    out0 = in0[1];
    EmitStreamVertex(6);
    out0 = in0[2];
    EmitStreamVertex(6);
    EndStreamPrimitive(6);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 64
; Schema: 0
               OpCapability Geometry
               OpCapability TransformFeedback
               OpCapability GeometryStreams
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Geometry %main "main" %outBlock %in0 %InputBuiltInArrayVar %OutputBuiltInsVar
               OpExecutionMode %main Xfb
               OpExecutionMode %main InputTrianglesAdjacency
               OpExecutionMode %main Invocations 1
               OpExecutionMode %main OutputTriangleStrip
               OpExecutionMode %main OutputVertices 3
               OpSource GLSL 450
               OpSourceExtension "GL_ARB_enhanced_layouts"
               OpName %main "main"
               OpName %OutBlock "OutBlock"
               OpMemberName %OutBlock 0 "out0"
               OpName %outBlock "outBlock"
               OpName %in0 "in0"
               OpMemberDecorate %OutBlock 0 Location 0
               OpMemberDecorate %OutBlock 0 Offset 0
               OpMemberDecorate %OutBlock 0 Stream 6
               OpMemberDecorate %OutBlock 0 XfbBuffer 0
               OpMemberDecorate %OutBlock 0 XfbStride 16
               OpDecorate %OutBlock Block
               OpMemberDecorate %BuiltIns 0 BuiltIn Position
               OpMemberDecorate %BuiltIns 1 BuiltIn PointSize
               OpDecorate %BuiltIns Block
               OpDecorate %in0 Location 0
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
   %OutBlock = OpTypeStruct %v4float
%_ptr_Output_OutBlock = OpTypePointer Output %OutBlock
   %outBlock = OpVariable %_ptr_Output_OutBlock Output
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%int_1 = OpConstant %int 1
%int_2 = OpConstant %int 2
%int_3 = OpConstant %int 3
       %uint = OpTypeInt 32 0
     %uint_0 = OpConstant %uint 3
%_arr_v4float_uint_0 = OpTypeArray %v4float %uint_0
%_ptr_Input__arr_v4float_uint_0 = OpTypePointer Input %_arr_v4float_uint_0
        %in0 = OpVariable %_ptr_Input__arr_v4float_uint_0 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Input_float = OpTypePointer Input %float
%_ptr_Output_v4float = OpTypePointer Output %v4float
%_ptr_Output_float = OpTypePointer Output %float
  %streamNum = OpConstant %int 6
%BuiltIns = OpTypeStruct %v4float %float
%InputBuiltInArray = OpTypeArray %BuiltIns %int_1
%InputBuiltInArrayPtr = OpTypePointer Input %InputBuiltInArray
%InputBuiltInArrayVar = OpVariable %InputBuiltInArrayPtr Input
%OutputBuiltInsPtr = OpTypePointer Output %BuiltIns
%OutputBuiltInsVar = OpVariable %OutputBuiltInsPtr Output
       %main = OpFunction %void None %3
          %5 = OpLabel
%in_gl_Position_Ptr = OpAccessChain %_ptr_Input_v4float %InputBuiltInArrayVar %int_0 %int_0
%in_gl_Position = OpLoad %v4float %in_gl_Position_Ptr
%out_gl_Position_Ptr = OpAccessChain %_ptr_Output_v4float %OutputBuiltInsVar %int_0
%in_gl_PointSize_Ptr = OpAccessChain %_ptr_Input_float %InputBuiltInArrayVar %int_0 %int_1
%in_gl_PointSize = OpLoad %float %in_gl_PointSize_Ptr
%out_gl_PointSize_Ptr = OpAccessChain %_ptr_Output_float %OutputBuiltInsVar %int_1
%11 = OpAccessChain %_ptr_Input_v4float %in0 %int_1
          %12 = OpLoad %v4float %11
          %13 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %13 %12
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpStore %out_gl_PointSize_Ptr %in_gl_PointSize
               OpEmitStreamVertex %streamNum
%21 = OpAccessChain %_ptr_Input_v4float %in0 %int_2
          %22 = OpLoad %v4float %21
          %23 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %23 %22
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpStore %out_gl_PointSize_Ptr %in_gl_PointSize
               OpEmitStreamVertex %streamNum
%31 = OpAccessChain %_ptr_Input_v4float %in0 %int_3
          %32 = OpLoad %v4float %31
          %33 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %33 %32
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpStore %out_gl_PointSize_Ptr %in_gl_PointSize
               OpEmitStreamVertex %streamNum
               OpEndStreamPrimitive %streamNum
               OpReturn
               OpFunctionEnd
#version 450

layout(triangles_adjacency) in;
layout(location = 0) in vec4 in0[];

layout(triangle_strip, max_vertices = 3) out;
layout(stream = 14, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16, location = 0) out vec4 out0;

in gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main(void)
{
    gl_Position  = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;
    out0 = in0[0];
    EmitStreamVertex(14);
    out0 = in0[1];
    EmitStreamVertex(14);
    out0 = in0[2];
    EmitStreamVertex(14);
    EndStreamPrimitive(14);
}
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 10
; Bound: 64
; Schema: 0
               OpCapability Geometry
               OpCapability TransformFeedback
               OpCapability GeometryStreams
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Geometry %main "main" %outBlock %in0 %InputBuiltInArrayVar %OutputBuiltInsVar
               OpExecutionMode %main Xfb
               OpExecutionMode %main InputTrianglesAdjacency
               OpExecutionMode %main Invocations 1
               OpExecutionMode %main OutputTriangleStrip
               OpExecutionMode %main OutputVertices 3
               OpSource GLSL 450
               OpSourceExtension "GL_ARB_enhanced_layouts"
               OpName %main "main"
               OpName %OutBlock "OutBlock"
               OpMemberName %OutBlock 0 "out0"
               OpName %outBlock "outBlock"
               OpName %in0 "in0"
               OpMemberDecorate %OutBlock 0 Location 0
               OpMemberDecorate %OutBlock 0 Offset 0
               OpMemberDecorate %OutBlock 0 Stream 14
               OpMemberDecorate %OutBlock 0 XfbBuffer 0
               OpMemberDecorate %OutBlock 0 XfbStride 16
               OpDecorate %OutBlock Block
               OpMemberDecorate %BuiltIns 0 BuiltIn Position
               OpMemberDecorate %BuiltIns 1 BuiltIn PointSize
               OpDecorate %BuiltIns Block
               OpDecorate %in0 Location 0
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
   %OutBlock = OpTypeStruct %v4float
%_ptr_Output_OutBlock = OpTypePointer Output %OutBlock
   %outBlock = OpVariable %_ptr_Output_OutBlock Output
        %int = OpTypeInt 32 1
      %int_0 = OpConstant %int 0
%int_1 = OpConstant %int 1
%int_2 = OpConstant %int 2
%int_3 = OpConstant %int 3
       %uint = OpTypeInt 32 0
     %uint_0 = OpConstant %uint 3
%_arr_v4float_uint_0 = OpTypeArray %v4float %uint_0
%_ptr_Input__arr_v4float_uint_0 = OpTypePointer Input %_arr_v4float_uint_0
        %in0 = OpVariable %_ptr_Input__arr_v4float_uint_0 Input
%_ptr_Input_v4float = OpTypePointer Input %v4float
%_ptr_Input_float = OpTypePointer Input %float
%_ptr_Output_v4float = OpTypePointer Output %v4float
%_ptr_Output_float = OpTypePointer Output %float
  %streamNum = OpConstant %int 14
%BuiltIns = OpTypeStruct %v4float %float
%InputBuiltInArray = OpTypeArray %BuiltIns %int_1
%InputBuiltInArrayPtr = OpTypePointer Input %InputBuiltInArray
%InputBuiltInArrayVar = OpVariable %InputBuiltInArrayPtr Input
%OutputBuiltInsPtr = OpTypePointer Output %BuiltIns
%OutputBuiltInsVar = OpVariable %OutputBuiltInsPtr Output
       %main = OpFunction %void None %3
          %5 = OpLabel
%in_gl_Position_Ptr = OpAccessChain %_ptr_Input_v4float %InputBuiltInArrayVar %int_0 %int_0
%in_gl_Position = OpLoad %v4float %in_gl_Position_Ptr
%out_gl_Position_Ptr = OpAccessChain %_ptr_Output_v4float %OutputBuiltInsVar %int_0
%in_gl_PointSize_Ptr = OpAccessChain %_ptr_Input_float %InputBuiltInArrayVar %int_0 %int_1
%in_gl_PointSize = OpLoad %float %in_gl_PointSize_Ptr
%out_gl_PointSize_Ptr = OpAccessChain %_ptr_Output_float %OutputBuiltInsVar %int_1
%11 = OpAccessChain %_ptr_Input_v4float %in0 %int_1
          %12 = OpLoad %v4float %11
          %13 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %13 %12
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpStore %out_gl_PointSize_Ptr %in_gl_PointSize
               OpEmitStreamVertex %streamNum
%21 = OpAccessChain %_ptr_Input_v4float %in0 %int_2
          %22 = OpLoad %v4float %21
          %23 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %23 %22
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpStore %out_gl_PointSize_Ptr %in_gl_PointSize
               OpEmitStreamVertex %streamNum
%31 = OpAccessChain %_ptr_Input_v4float %in0 %int_3
          %32 = OpLoad %v4float %31
          %33 = OpAccessChain %_ptr_Output_v4float %outBlock %int_0
               OpStore %33 %32
               OpStore %out_gl_Position_Ptr %in_gl_Position
               OpStore %out_gl_PointSize_Ptr %in_gl_PointSize
               OpEmitStreamVertex %streamNum
               OpEndStreamPrimitive %streamNum
               OpReturn
               OpFunctionEnd
