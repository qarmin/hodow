#version 450 core
#extension GL_EXT_fragment_shading_rate : enable
#extension GL_ARB_shader_stencil_export : enable
#extension GL_ARB_fragment_shader_interlock : enable
${'#extension GL_AMD_shader_early_and_late_fragment_tests : enable\n' if early_late else ''}layout(location = 0) out uvec4 col0;
layout(set = 0, binding = 0) buffer Block { uint counter; } buf;
layout(set = 0, binding = 3) uniform usampler2D tex;
layout(location = 0) flat in int instanceIndex;
layout(location = 1) flat in int readbackok;
layout(location = 2) ${'sample ' if sample_shading_input else ''}in float zero;
${'layout(early_and_late_fragment_tests_amd) in;\n' if early_late else ''}${'layout(depth_less) out float gl_FragDepth;\n' if (frag_depth and early_late) else ''}${'layout(stencil_ref_less_front_amd) out int gl_FragStencilRefARB;\n' if (frag_stencil and early_late) else ''}${'layout(pixel_interlock_ordered) in;\n' if interlock else ''}void main()
{
${'  beginInvocationInterlockARB();\n' if interlock else ''}  col0.x = gl_ShadingRateEXT;
${'  col0.y = uint(gl_HelperInvocation);\n' if helper_invocation else '  col0.y = 0;\n'}  col0.z = (instanceIndex << 24) | ((atomicAdd(buf.counter, 1) + 1) & 0x00FFFFFFu);
  ivec2 fragCoordXY = ivec2(gl_FragCoord.xy);
  ivec2 fragSize = ivec2(1<<((gl_ShadingRateEXT/4)&3), 1<<(gl_ShadingRateEXT&3));
  col0.w = uint(zero)${' * gl_SampleID' if sample_shading_input else ''};
  if (((fragCoordXY - fragSize / 2) % fragSize) != ivec2(0,0))
    col0.w = 1;
${'  if (readbackok != 1)\n    col0.w = 2;\n' if shader_writes_rate else ''}${'  if (dFdx(gl_FragCoord.xy) != ivec2(fragSize.x, 0) || dFdy(gl_FragCoord.xy) != ivec2(0, fragSize.y))\n    col0.w = (fragSize.y << 26) | (fragSize.x << 20) | (int(dFdx(gl_FragCoord.xy)) << 14) | (int(dFdx(gl_FragCoord.xy)) << 8) | 3;\n  uint implicitDerivX = texture(tex, vec2(gl_FragCoord.x / textureSize(tex, 0).x, 0)).x;\n  uint implicitDerivY = texture(tex, vec2(0, gl_FragCoord.y / textureSize(tex, 0).y)).x;\n  if (implicitDerivX != fragSize.x || implicitDerivY != fragSize.y)\n    col0.w = (fragSize.y << 26) | (fragSize.x << 20) | (implicitDerivY << 14) | (implicitDerivX << 8) | 4;\n' if not (sample_shading_enable or sample_shading_input) else ''}${'  gl_SampleMask[0] = 0x55555555;\n' if sample_mask_out else ''}${('  col0.y = (gl_SampleMaskIn[0]' + (' & 0x55555555' if sample_mask_out else '') + ');\n') if (sample_mask_in or sample_mask_out) else ''}${'  gl_FragDepth = float(instanceIndex) / float(81);\n' if frag_depth else ''}${'  gl_FragStencilRefARB = instanceIndex;\n' if frag_stencil else ''}${'  endInvocationInterlockARB();\n' if interlock else ''}}
