#version 450
layout(location = 0) in vec4 position;

void main()
{
    gl_Position = position;
}
#version 450
layout(location=0) out vec4 out_color;
void main() {
  out_color = vec4(0.0, 1.0, 0.0, 1.0);
}
#version 450

layout(location = 0) in vec4 position;
layout(location = 0) out vec2 textureCoordinates;

void main() {
  gl_Position = position;
  textureCoordinates = vec2(0.0, 0.0);
}
                           OpCapability Shader
                           OpMemoryModel Logical GLSL450
                           OpEntryPoint Fragment %main "main" %fragColor %vtxTexCoords
                           OpExecutionMode %main OriginUpperLeft
                           OpDecorate %fragColor Location 0 ; Output
                           OpDecorate %vtxTexCoords Location 0 ; Input
                           OpDecorate %sampler_ptr DescriptorSet 0
                           OpDecorate %sampler_ptr Binding 0

                           ; Basic types.
                   %void = OpTypeVoid
            %void_func_t = OpTypeFunction %void
                  %float = OpTypeFloat 32
                %v2float = OpTypeVector %float 2
                %v4float = OpTypeVector %float 4
               %image_2d = OpTypeImage %float 2D 0 0 0 1 Unknown
            %sampled_img = OpTypeSampledImage %image_2d
        %sampling_func_t = OpTypeFunction %v4float %sampled_img %v2float

                           ; Pointer types.
%sampled_img_uniform_ptr = OpTypePointer UniformConstant %sampled_img
        %v4float_out_ptr = OpTypePointer Output %v4float
      %v2float_input_ptr = OpTypePointer Input %v2float

                           ; In/Out variables.
              %fragColor = OpVariable %v4float_out_ptr Output
            %sampler_ptr = OpVariable %sampled_img_uniform_ptr UniformConstant
           %vtxTexCoords = OpVariable %v2float_input_ptr Input

                           ; Main function.
                   %main = OpFunction %void None %void_func_t
             %main_label = OpLabel
             %tex_coords = OpLoad %v2float %vtxTexCoords
            %sampler_arg = OpLoad %sampled_img %sampler_ptr
         %frag_color_val = OpFunctionCall %v4float %sampling_func %sampler_arg %tex_coords
                           OpStore %fragColor %frag_color_val
                           OpReturn
                           OpFunctionEnd

                           ; Auxiliar texture sampling function, receiving a sampled image as its argument.
          %sampling_func = OpFunction %v4float None %sampling_func_t
                %sampler = OpFunctionParameter %sampled_img
                 %coords = OpFunctionParameter %v2float
    %sampling_func_label = OpLabel
                 %retval = OpImageSampleImplicitLod %v4float %sampler %coords
                           OpReturnValue %retval
                           OpFunctionEnd
