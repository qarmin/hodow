#version 430

layout(location = 0) in vec4 position;

void main()
{
  gl_Position = vec4(position.xy, 0.5, 1.0);
}
              OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %main "main" %color_out %gl_FragDepth
               OpExecutionMode %main OriginUpperLeft
               OpExecutionMode %main EarlyFragmentTests
               OpExecutionMode %main DepthReplacing
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
  %float_0_3 = OpConstant %float 0.3
       %main = OpFunction %void None %3
          %5 = OpLabel
               OpStore %color_out %12
               OpStore %gl_FragDepth %float_0_3
               OpReturn
               OpFunctionEnd
#version 430
layout(location = 0) in vec4 position;
void main() {
  gl_Position = position;
}
#version 430

layout(location = 0) out vec4 outColor;
uniform layout(set=0, binding=0) sampler2D imageSampler;

const float expectedValue = 0.5;
const float tolerance = 0.01;

void main()
{
  float value = texelFetch(imageSampler, ivec2(gl_FragCoord.xy), 0).r;

  if (abs(value - expectedValue) < tolerance)
    outColor = vec4(0.0f, 1.0f, 0.0f, 1.0f);
  else
    outColor = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
#version 430

layout(location = 0) in vec4 position;

void main()
{
  gl_Position = vec4(position.xy, 0.6, 1.0);
}
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %main "main" %color_out %gl_FragDepth
               OpExecutionMode %main OriginUpperLeft
               OpExecutionMode %main EarlyFragmentTests
               OpExecutionMode %main DepthReplacing
               OpExecutionMode %main DepthGreater
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
#version 430

layout(location = 0) out vec4 outColor;
uniform layout(set=0, binding=0) sampler2D imageSampler;

const float expectedValue = 0.6;
const float tolerance = 0.01;

void main()
{
  float value = texelFetch(imageSampler, ivec2(gl_FragCoord.xy), 0).r;

  if (abs(value - expectedValue) < tolerance)
    outColor = vec4(0.0f, 1.0f, 0.0f, 1.0f);
  else
    outColor = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}

#version 430

layout(location = 0) out vec4 outColor;
uniform layout(set=0, binding=0) sampler2D imageSampler;

const float expectedValue = 0.5;
const float tolerance = 0.01;

void main()
{
  float value = texelFetch(imageSampler, ivec2(gl_FragCoord.xy), 0).r;
  if (abs(value - expectedValue) < tolerance)
    outColor = vec4(0.0f, 1.0f, 0.0f, 1.0f);
  else
    outColor = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
#version 430

layout(location = 0) in vec4 position;

void main()
{
  gl_Position = vec4(position.xy, 0.4, 1.0);
}
               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %main "main" %color_out %gl_FragDepth
               OpExecutionMode %main OriginUpperLeft
               OpExecutionMode %main EarlyFragmentTests
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
%float_0_7 = OpConstant %float 0.7
       %main = OpFunction %void None %3
          %5 = OpLabel
               OpStore %color_out %12
               OpStore %gl_FragDepth %float_0_7
               OpReturn
               OpFunctionEnd

#version 430

layout(location = 0) out vec4 outColor;
uniform layout(set=0, binding=0) sampler2D imageSampler;

const float expectedValue = 0.4;
const float tolerance = 0.01;

void main()
{
  float value = texelFetch(imageSampler, ivec2(gl_FragCoord.xy), 0).r;
  if (abs(value - expectedValue) < tolerance)
    outColor = vec4(0.0f, 1.0f, 0.0f, 1.0f);
  else
    outColor = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
              OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %main "main" %color_out %gl_FragDepth
               OpExecutionMode %main OriginUpperLeft
               OpExecutionMode %main EarlyFragmentTests
               OpExecutionMode %main DepthReplacing
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
  %float_0_7 = OpConstant %float 0.7
       %main = OpFunction %void None %3
          %5 = OpLabel
               OpStore %color_out %12
               OpStore %gl_FragDepth %float_0_7
               OpReturn
               OpFunctionEnd
#version 430

layout(location = 0) in vec4 position;

void main()
{
  gl_Position = vec4(position.xy, 0.3, 1.0);
}
              OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %main "main" %color_out %gl_FragDepth
               OpExecutionMode %main OriginUpperLeft
               OpExecutionMode %main EarlyFragmentTests
               OpExecutionMode %main DepthReplacing
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
  %float_0_5 = OpConstant %float 0.5
       %main = OpFunction %void None %3
          %5 = OpLabel
               OpStore %color_out %12
               OpStore %gl_FragDepth %float_0_5
               OpReturn
               OpFunctionEnd
#version 430

layout(location = 0) out vec4 outColor;
uniform layout(set=0, binding=0) sampler2D imageSampler;

const float expectedValue = 0.3;
const float tolerance = 0.01;

void main()
{
  float value = texelFetch(imageSampler, ivec2(gl_FragCoord.xy), 0).r;

  if (abs(value - expectedValue) < tolerance)
    outColor = vec4(0.0f, 1.0f, 0.0f, 1.0f);
  else
    outColor = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
              OpCapability Shader
			  OpExtension "SPV_AMD_shader_early_and_late_fragment_tests"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %main "main" %color_out %gl_FragDepth
               OpExecutionMode %main OriginUpperLeft
               OpExecutionMode %main EarlyAndLateFragmentTestsAMD
               OpExecutionMode %main DepthReplacing
               OpExecutionMode %main DepthGreater
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
  %float_0_6 = OpConstant %float 0.6
       %main = OpFunction %void None %3
          %5 = OpLabel
               OpStore %color_out %12
               OpStore %gl_FragDepth %float_0_6
               OpReturn
               OpFunctionEnd
               OpCapability Shader
               OpExtension "SPV_AMD_shader_early_and_late_fragment_tests"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %main "main" %color_out %gl_FragDepth
               OpExecutionMode %main OriginUpperLeft
               OpExecutionMode %main EarlyAndLateFragmentTestsAMD
               OpExecutionMode %main DepthReplacing
               OpExecutionMode %main DepthGreater
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
%float_0_7 = OpConstant %float 0.7
       %main = OpFunction %void None %3
          %5 = OpLabel
               OpStore %color_out %12
               OpStore %gl_FragDepth %float_0_7
               OpReturn
               OpFunctionEnd
#version 430

layout(location = 0) out vec4 outColor;
uniform layout(set=0, binding=0) sampler2D imageSampler;

const float expectedValue = 0.7;
const float tolerance = 0.01;

void main()
{
  float value = texelFetch(imageSampler, ivec2(gl_FragCoord.xy), 0).r;

  if (abs(value - expectedValue) < tolerance)
    outColor = vec4(0.0f, 1.0f, 0.0f, 1.0f);
  else
    outColor = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
              OpCapability Shader
			  OpExtension "SPV_AMD_shader_early_and_late_fragment_tests"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %main "main" %color_out %gl_FragDepth
               OpExecutionMode %main OriginUpperLeft
               OpExecutionMode %main EarlyAndLateFragmentTestsAMD
               OpExecutionMode %main DepthReplacing
               OpExecutionMode %main DepthGreater
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
  %float_0_7 = OpConstant %float 0.7
       %main = OpFunction %void None %3
          %5 = OpLabel
               OpStore %color_out %12
               OpStore %gl_FragDepth %float_0_7
               OpReturn
               OpFunctionEnd

#version 430

layout(location = 0) out vec4 outColor;
uniform layout(set=0, binding=0) sampler2D imageSampler;

const float expectedValue = 0.7;
const float tolerance = 0.01;

void main()
{
  float value = texelFetch(imageSampler, ivec2(gl_FragCoord.xy), 0).r;
  if (abs(value - expectedValue) < tolerance)
    outColor = vec4(0.0f, 1.0f, 0.0f, 1.0f);
  else
    outColor = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
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
              OpCapability Shader
              OpExtension "SPV_AMD_shader_early_and_late_fragment_tests"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %main "main" %color_out %gl_FragDepth
               OpExecutionMode %main OriginUpperLeft
               OpExecutionMode %main EarlyAndLateFragmentTestsAMD
               OpExecutionMode %main DepthReplacing
               OpExecutionMode %main DepthUnchanged
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
  %float_0_7 = OpConstant %float 0.7
       %main = OpFunction %void None %3
          %5 = OpLabel
               OpStore %color_out %12
               OpStore %gl_FragDepth %float_0_7
               OpReturn
               OpFunctionEnd
              OpCapability Shader
              OpExtension "SPV_AMD_shader_early_and_late_fragment_tests"
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %main "main" %color_out %gl_FragDepth
               OpExecutionMode %main OriginUpperLeft
               OpExecutionMode %main EarlyAndLateFragmentTestsAMD
               OpExecutionMode %main DepthReplacing
               OpExecutionMode %main DepthUnchanged
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
  %float_0_5 = OpConstant %float 0.5
       %main = OpFunction %void None %3
          %5 = OpLabel
               OpStore %color_out %12
               OpStore %gl_FragDepth %float_0_5
               OpReturn
               OpFunctionEnd
#version 430
layout(location = 0) in vec4 position;

void main()
{
    gl_Position = vec4(position.xy, 0.6, 1.0);
}

               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %main "main" %outColor %gl_FragDepth
               OpExecutionMode %main OriginUpperLeft
               OpExecutionMode %main DepthReplacing
               OpExecutionMode %main DepthGreater
               OpSource GLSL 430
               OpName %main "main"
               OpName %outColor "outColor"
               OpName %gl_FragDepth "gl_FragDepth"
               OpDecorate %outColor Location 0
               OpDecorate %gl_FragDepth BuiltIn FragDepth
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
%_ptr_Output_v4float = OpTypePointer Output %v4float
   %outColor = OpVariable %_ptr_Output_v4float Output
    %float_0 = OpConstant %float 0
         %11 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_0
%_ptr_Output_float = OpTypePointer Output %float
%gl_FragDepth = OpVariable %_ptr_Output_float Output
%float_out_depth = OpConstant %float 0.7
       %main = OpFunction %void None %3
          %5 = OpLabel
               OpStore %outColor %11
               OpStore %gl_FragDepth %float_out_depth
               OpReturn
               OpFunctionEnd

#version 430

layout(location = 0) out vec4 outColor;
uniform layout(set=0, binding=0) sampler2D imageSampler;
const float expectedValue = 0.7;
const float tolerance = 0.01;

void main()
{
  float value = texelFetch(imageSampler, ivec2(gl_FragCoord.xy), 0).r;
  if (abs(value - expectedValue) < tolerance)
    outColor = vec4(0.0, 1.0, 0.0, 1.0);
  else
    outColor = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 430
layout(location = 0) in vec4 position;

void main()
{
    gl_Position = vec4(position.xy, 0.7, 1.0);
}

               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %main "main" %outColor %gl_FragDepth
               OpExecutionMode %main OriginUpperLeft
               OpExecutionMode %main DepthReplacing
               OpExecutionMode %main DepthGreater
               OpSource GLSL 430
               OpName %main "main"
               OpName %outColor "outColor"
               OpName %gl_FragDepth "gl_FragDepth"
               OpDecorate %outColor Location 0
               OpDecorate %gl_FragDepth BuiltIn FragDepth
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
%_ptr_Output_v4float = OpTypePointer Output %v4float
   %outColor = OpVariable %_ptr_Output_v4float Output
    %float_0 = OpConstant %float 0
         %11 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_0
%_ptr_Output_float = OpTypePointer Output %float
%gl_FragDepth = OpVariable %_ptr_Output_float Output
%float_out_depth = OpConstant %float 0.6
       %main = OpFunction %void None %3
          %5 = OpLabel
               OpStore %outColor %11
               OpStore %gl_FragDepth %float_out_depth
               OpReturn
               OpFunctionEnd

#version 430

layout(location = 0) out vec4 outColor;
uniform layout(set=0, binding=0) sampler2D imageSampler;
const float expectedValue = 0.6;
const float tolerance = 0.01;

void main()
{
  float value = texelFetch(imageSampler, ivec2(gl_FragCoord.xy), 0).r;
  if (abs(value - expectedValue) < tolerance)
    outColor = vec4(0.0, 1.0, 0.0, 1.0);
  else
    outColor = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 430
layout(location = 0) in vec4 position;

void main()
{
    gl_Position = vec4(position.xy, 0.2, 1.0);
}

               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %main "main" %outColor %gl_FragDepth
               OpExecutionMode %main OriginUpperLeft
               OpExecutionMode %main DepthReplacing
               OpExecutionMode %main DepthGreater
               OpSource GLSL 430
               OpName %main "main"
               OpName %outColor "outColor"
               OpName %gl_FragDepth "gl_FragDepth"
               OpDecorate %outColor Location 0
               OpDecorate %gl_FragDepth BuiltIn FragDepth
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
%_ptr_Output_v4float = OpTypePointer Output %v4float
   %outColor = OpVariable %_ptr_Output_v4float Output
    %float_0 = OpConstant %float 0
         %11 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_0
%_ptr_Output_float = OpTypePointer Output %float
%gl_FragDepth = OpVariable %_ptr_Output_float Output
%float_out_depth = OpConstant %float 0.3
       %main = OpFunction %void None %3
          %5 = OpLabel
               OpStore %outColor %11
               OpStore %gl_FragDepth %float_out_depth
               OpReturn
               OpFunctionEnd

#version 430

layout(location = 0) out vec4 outColor;
uniform layout(set=0, binding=0) sampler2D imageSampler;
const float expectedValue = 0.5;
const float tolerance = 0.01;

void main()
{
  float value = texelFetch(imageSampler, ivec2(gl_FragCoord.xy), 0).r;
  if (abs(value - expectedValue) < tolerance)
    outColor = vec4(0.0, 1.0, 0.0, 1.0);
  else
    outColor = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 430
layout(location = 0) in vec4 position;

void main()
{
    gl_Position = vec4(position.xy, 0.4, 1.0);
}

               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %main "main" %outColor %gl_FragDepth
               OpExecutionMode %main OriginUpperLeft
               OpExecutionMode %main DepthReplacing
               OpExecutionMode %main DepthLess
               OpSource GLSL 430
               OpName %main "main"
               OpName %outColor "outColor"
               OpName %gl_FragDepth "gl_FragDepth"
               OpDecorate %outColor Location 0
               OpDecorate %gl_FragDepth BuiltIn FragDepth
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
%_ptr_Output_v4float = OpTypePointer Output %v4float
   %outColor = OpVariable %_ptr_Output_v4float Output
    %float_0 = OpConstant %float 0
         %11 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_0
%_ptr_Output_float = OpTypePointer Output %float
%gl_FragDepth = OpVariable %_ptr_Output_float Output
%float_out_depth = OpConstant %float 0.1
       %main = OpFunction %void None %3
          %5 = OpLabel
               OpStore %outColor %11
               OpStore %gl_FragDepth %float_out_depth
               OpReturn
               OpFunctionEnd

#version 430

layout(location = 0) out vec4 outColor;
uniform layout(set=0, binding=0) sampler2D imageSampler;
const float expectedValue = 0.1;
const float tolerance = 0.01;

void main()
{
  float value = texelFetch(imageSampler, ivec2(gl_FragCoord.xy), 0).r;
  if (abs(value - expectedValue) < tolerance)
    outColor = vec4(0.0, 1.0, 0.0, 1.0);
  else
    outColor = vec4(1.0, 0.0, 0.0, 1.0);
}

               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %main "main" %outColor %gl_FragDepth
               OpExecutionMode %main OriginUpperLeft
               OpExecutionMode %main DepthReplacing
               OpExecutionMode %main DepthLess
               OpSource GLSL 430
               OpName %main "main"
               OpName %outColor "outColor"
               OpName %gl_FragDepth "gl_FragDepth"
               OpDecorate %outColor Location 0
               OpDecorate %gl_FragDepth BuiltIn FragDepth
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
%_ptr_Output_v4float = OpTypePointer Output %v4float
   %outColor = OpVariable %_ptr_Output_v4float Output
    %float_0 = OpConstant %float 0
         %11 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_0
%_ptr_Output_float = OpTypePointer Output %float
%gl_FragDepth = OpVariable %_ptr_Output_float Output
%float_out_depth = OpConstant %float 0.3
       %main = OpFunction %void None %3
          %5 = OpLabel
               OpStore %outColor %11
               OpStore %gl_FragDepth %float_out_depth
               OpReturn
               OpFunctionEnd

#version 430

layout(location = 0) out vec4 outColor;
uniform layout(set=0, binding=0) sampler2D imageSampler;
const float expectedValue = 0.3;
const float tolerance = 0.01;

void main()
{
  float value = texelFetch(imageSampler, ivec2(gl_FragCoord.xy), 0).r;
  if (abs(value - expectedValue) < tolerance)
    outColor = vec4(0.0, 1.0, 0.0, 1.0);
  else
    outColor = vec4(1.0, 0.0, 0.0, 1.0);
}

               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %main "main" %outColor %gl_FragDepth
               OpExecutionMode %main OriginUpperLeft
               OpExecutionMode %main DepthReplacing
               OpExecutionMode %main DepthLess
               OpSource GLSL 430
               OpName %main "main"
               OpName %outColor "outColor"
               OpName %gl_FragDepth "gl_FragDepth"
               OpDecorate %outColor Location 0
               OpDecorate %gl_FragDepth BuiltIn FragDepth
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
%_ptr_Output_v4float = OpTypePointer Output %v4float
   %outColor = OpVariable %_ptr_Output_v4float Output
    %float_0 = OpConstant %float 0
         %11 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_0
%_ptr_Output_float = OpTypePointer Output %float
%gl_FragDepth = OpVariable %_ptr_Output_float Output
%float_out_depth = OpConstant %float 0.6
       %main = OpFunction %void None %3
          %5 = OpLabel
               OpStore %outColor %11
               OpStore %gl_FragDepth %float_out_depth
               OpReturn
               OpFunctionEnd


               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %main "main" %outColor %gl_FragDepth
               OpExecutionMode %main OriginUpperLeft
               OpExecutionMode %main DepthReplacing
               OpExecutionMode %main DepthLess
               OpSource GLSL 430
               OpName %main "main"
               OpName %outColor "outColor"
               OpName %gl_FragDepth "gl_FragDepth"
               OpDecorate %outColor Location 0
               OpDecorate %gl_FragDepth BuiltIn FragDepth
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
%_ptr_Output_v4float = OpTypePointer Output %v4float
   %outColor = OpVariable %_ptr_Output_v4float Output
    %float_0 = OpConstant %float 0
         %11 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_0
%_ptr_Output_float = OpTypePointer Output %float
%gl_FragDepth = OpVariable %_ptr_Output_float Output
%float_out_depth = OpConstant %float 0.7
       %main = OpFunction %void None %3
          %5 = OpLabel
               OpStore %outColor %11
               OpStore %gl_FragDepth %float_out_depth
               OpReturn
               OpFunctionEnd


               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %main "main" %outColor %gl_FragDepth %gl_FragCoord
               OpExecutionMode %main OriginUpperLeft
               OpExecutionMode %main DepthReplacing
               OpExecutionMode %main DepthUnchanged
               OpSource GLSL 430
               OpName %main "main"
               OpName %outColor "outColor"
               OpName %gl_FragDepth "gl_FragDepth"
               OpName %gl_FragCoord "gl_FragCoord"
               OpDecorate %outColor Location 0
               OpDecorate %gl_FragDepth BuiltIn FragDepth
               OpDecorate %gl_FragCoord BuiltIn FragCoord
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
%_ptr_Output_v4float = OpTypePointer Output %v4float
   %outColor = OpVariable %_ptr_Output_v4float Output
    %float_0 = OpConstant %float 0
         %11 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_0
%_ptr_Output_float = OpTypePointer Output %float
%gl_FragDepth = OpVariable %_ptr_Output_float Output
%_ptr_Input_v4float = OpTypePointer Input %v4float
%gl_FragCoord = OpVariable %_ptr_Input_v4float Input
       %uint = OpTypeInt 32 0
     %uint_2 = OpConstant %uint 2
%_ptr_Input_float = OpTypePointer Input %float
       %main = OpFunction %void None %3
          %5 = OpLabel
               OpStore %outColor %11
         %19 = OpAccessChain %_ptr_Input_float %gl_FragCoord %uint_2
         %20 = OpLoad %float %19
               OpStore %gl_FragDepth %20
               OpReturn
               OpFunctionEnd


               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %main "main" %outColor %gl_FragDepth
               OpExecutionMode %main OriginUpperLeft
               OpExecutionMode %main DepthReplacing
               OpExecutionMode %main DepthUnchanged
               OpSource GLSL 430
               OpName %main "main"
               OpName %outColor "outColor"
               OpName %gl_FragDepth "gl_FragDepth"
               OpDecorate %outColor Location 0
               OpDecorate %gl_FragDepth BuiltIn FragDepth
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
%_ptr_Output_v4float = OpTypePointer Output %v4float
   %outColor = OpVariable %_ptr_Output_v4float Output
    %float_0 = OpConstant %float 0
         %11 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_0
%_ptr_Output_float = OpTypePointer Output %float
%gl_FragDepth = OpVariable %_ptr_Output_float Output
%float_out_depth = OpConstant %float 0.7
       %main = OpFunction %void None %3
          %5 = OpLabel
               OpStore %outColor %11
               OpStore %gl_FragDepth %float_out_depth
               OpReturn
               OpFunctionEnd

#version 430
layout(location = 0) in vec4 position;

void main()
{
    gl_Position = vec4(position.xy, 0.3, 1.0);
}

               OpCapability Shader
          %1 = OpExtInstImport "GLSL.std.450"
               OpMemoryModel Logical GLSL450
               OpEntryPoint Fragment %main "main" %outColor %gl_FragDepth
               OpExecutionMode %main OriginUpperLeft
               OpExecutionMode %main DepthReplacing
               OpExecutionMode %main DepthUnchanged
               OpSource GLSL 430
               OpName %main "main"
               OpName %outColor "outColor"
               OpName %gl_FragDepth "gl_FragDepth"
               OpDecorate %outColor Location 0
               OpDecorate %gl_FragDepth BuiltIn FragDepth
       %void = OpTypeVoid
          %3 = OpTypeFunction %void
      %float = OpTypeFloat 32
    %v4float = OpTypeVector %float 4
%_ptr_Output_v4float = OpTypePointer Output %v4float
   %outColor = OpVariable %_ptr_Output_v4float Output
    %float_0 = OpConstant %float 0
         %11 = OpConstantComposite %v4float %float_0 %float_0 %float_0 %float_0
%_ptr_Output_float = OpTypePointer Output %float
%gl_FragDepth = OpVariable %_ptr_Output_float Output
%float_out_depth = OpConstant %float 0.4
       %main = OpFunction %void None %3
          %5 = OpLabel
               OpStore %outColor %11
               OpStore %gl_FragDepth %float_out_depth
               OpReturn
               OpFunctionEnd

