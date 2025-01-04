#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[1]; } outputBuffer;

layout (set=0, binding=0) buffer sboBlock_0_0 { uint val; } ssbo_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ssbo_0_0.val;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
      ssbo_0_0.val = (readValue | 0xff000000u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[1]; } outputBuffer;

layout (set=0, binding=0) uniform uboBlock_0_0 { uint val; } ubo_0_0;
layout (set=0, binding=1) buffer sboBlock_0_1 { uint val; } ssbo_0_1;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ubo_0_0.val;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_1.val;
      debugPrintfEXT("iteration-0_0_1: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000100u) ? 0u : 1u);
      ssbo_0_1.val = (readValue | 0xff000000u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[6]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;

layout (set=0, binding=0) uniform utexture2D sampledImage_0_0;
layout (set=0, binding=1) uniform utexture2D sampledImage_0_1;
layout (set=0, binding=2, r32ui) uniform uimage2D storageImage_0_2;
layout (set=0, binding=3, r32ui) uniform uimage2D storageImage_0_3;
layout (set=0, binding=4) uniform utextureBuffer uniformTexel_0_4;
layout (set=0, binding=5) uniform utextureBuffer uniformTexel_0_5;
layout (set=0, binding=6, r32ui) uniform uimageBuffer storageTexel_0_6;
layout (set=0, binding=7, r32ui) uniform uimageBuffer storageTexel_0_7;
layout (set=0, binding=8) uniform uboBlock_0_8 { uint val; } ubo_0_8;
layout (set=0, binding=9) uniform uboBlock_0_9 { uint val; } ubo_0_9;
layout (set=0, binding=10) buffer sboBlock_0_10 { uint val; } ssbo_0_10;
layout (set=0, binding=11) buffer sboBlock_0_11 { uint val; } ssbo_0_11;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(usampler2D(sampledImage_0_0, externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1, externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_1: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000100u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_2, ivec2(0, 0)).x;
      debugPrintfEXT("iteration-0_0_2: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000200u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_2, ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3, ivec2(0, 0)).x;
      debugPrintfEXT("iteration-0_0_3: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000300u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3, ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_4, 0).x;
      debugPrintfEXT("iteration-0_0_4: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000400u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5, 0).x;
      debugPrintfEXT("iteration-0_0_5: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000500u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_6, 0).x;
      debugPrintfEXT("iteration-0_0_6: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000600u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_6, 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7, 0).x;
      debugPrintfEXT("iteration-0_0_7: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000700u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7, 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_8.val;
      debugPrintfEXT("iteration-0_0_8: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000800u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9.val;
      debugPrintfEXT("iteration-0_0_9: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000900u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_10.val;
      debugPrintfEXT("iteration-0_0_10: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000a00u) ? 0u : 1u);
      ssbo_0_10.val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11.val;
      debugPrintfEXT("iteration-0_0_11: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000b00u) ? 0u : 1u);
      ssbo_0_11.val = (readValue | 0xff000000u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[6]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;

layout (set=0, binding=0, r32ui) uniform uimage2D storageImage_0_0;
layout (set=0, binding=1) uniform utexture2D sampledImage_0_1;
layout (set=0, binding=2) uniform utextureBuffer uniformTexel_0_2;
layout (set=0, binding=3, r32ui) uniform uimage2D storageImage_0_3;
layout (set=0, binding=4, r32ui) uniform uimageBuffer storageTexel_0_4;
layout (set=0, binding=5) uniform utextureBuffer uniformTexel_0_5;
layout (set=0, binding=6) uniform uboBlock_0_6 { uint val; } ubo_0_6;
layout (set=0, binding=7, r32ui) uniform uimageBuffer storageTexel_0_7;
layout (set=0, binding=8) buffer sboBlock_0_8 { uint val; } ssbo_0_8;
layout (set=0, binding=9) uniform uboBlock_0_9 { uint val; } ubo_0_9;
layout (set=0, binding=10) uniform utexture2D sampledImage_0_10;
layout (set=0, binding=11) buffer sboBlock_0_11 { uint val; } ssbo_0_11;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageImage_0_0, ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0, ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1, externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_1: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010100u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_2, 0).x;
      debugPrintfEXT("iteration-1_0_2: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010200u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_3, ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_3: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010300u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3, ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_4, 0).x;
      debugPrintfEXT("iteration-1_0_4: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010400u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_4, 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5, 0).x;
      debugPrintfEXT("iteration-1_0_5: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010500u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_6.val;
      debugPrintfEXT("iteration-1_0_6: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010600u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_7, 0).x;
      debugPrintfEXT("iteration-1_0_7: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010700u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7, 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ssbo_0_8.val;
      debugPrintfEXT("iteration-1_0_8: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010800u) ? 0u : 1u);
      ssbo_0_8.val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ubo_0_9.val;
      debugPrintfEXT("iteration-1_0_9: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010900u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_10, externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_10: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010a00u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_11.val;
      debugPrintfEXT("iteration-1_0_11: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010b00u) ? 0u : 1u);
      ssbo_0_11.val = (readValue | 0xff000000u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[6]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;

layout (set=0, binding=0) uniform utextureBuffer uniformTexel_0_0;
layout (set=0, binding=1) uniform utexture2D sampledImage_0_1;
layout (set=0, binding=2, r32ui) uniform uimageBuffer storageTexel_0_2;
layout (set=0, binding=3, r32ui) uniform uimage2D storageImage_0_3;
layout (set=0, binding=4) uniform uboBlock_0_4 { uint val; } ubo_0_4;
layout (set=0, binding=5) uniform utextureBuffer uniformTexel_0_5;
layout (set=0, binding=6) buffer sboBlock_0_6 { uint val; } ssbo_0_6;
layout (set=0, binding=7, r32ui) uniform uimageBuffer storageTexel_0_7;
layout (set=0, binding=8) uniform utexture2D sampledImage_0_8;
layout (set=0, binding=9) uniform uboBlock_0_9 { uint val; } ubo_0_9;
layout (set=0, binding=10, r32ui) uniform uimage2D storageImage_0_10;
layout (set=0, binding=11) buffer sboBlock_0_11 { uint val; } ssbo_0_11;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[2], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texelFetch(uniformTexel_0_0, 0).x;
      debugPrintfEXT("iteration-2_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020000u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1, externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-2_0_1: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020100u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_2, 0).x;
      debugPrintfEXT("iteration-2_0_2: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020200u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_2, 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3, ivec2(0, 0)).x;
      debugPrintfEXT("iteration-2_0_3: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020300u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3, ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_4.val;
      debugPrintfEXT("iteration-2_0_4: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020400u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5, 0).x;
      debugPrintfEXT("iteration-2_0_5: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020500u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_6.val;
      debugPrintfEXT("iteration-2_0_6: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020600u) ? 0u : 1u);
      ssbo_0_6.val = (readValue | 0xff000000u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_7, 0).x;
      debugPrintfEXT("iteration-2_0_7: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020700u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7, 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_8, externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-2_0_8: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020800u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9.val;
      debugPrintfEXT("iteration-2_0_9: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020900u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_10, ivec2(0, 0)).x;
      debugPrintfEXT("iteration-2_0_10: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020a00u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_10, ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ssbo_0_11.val;
      debugPrintfEXT("iteration-2_0_11: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020b00u) ? 0u : 1u);
      ssbo_0_11.val = (readValue | 0xff000000u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[2], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[6]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;

layout (set=0, binding=0, r32ui) uniform uimageBuffer storageTexel_0_0;
layout (set=0, binding=1) uniform utexture2D sampledImage_0_1;
layout (set=0, binding=2) uniform uboBlock_0_2 { uint val; } ubo_0_2;
layout (set=0, binding=3, r32ui) uniform uimage2D storageImage_0_3;
layout (set=0, binding=4) buffer sboBlock_0_4 { uint val; } ssbo_0_4;
layout (set=0, binding=5) uniform utextureBuffer uniformTexel_0_5;
layout (set=0, binding=6) uniform utexture2D sampledImage_0_6;
layout (set=0, binding=7, r32ui) uniform uimageBuffer storageTexel_0_7;
layout (set=0, binding=8, r32ui) uniform uimage2D storageImage_0_8;
layout (set=0, binding=9) uniform uboBlock_0_9 { uint val; } ubo_0_9;
layout (set=0, binding=10) uniform utextureBuffer uniformTexel_0_10;
layout (set=0, binding=11) buffer sboBlock_0_11 { uint val; } ssbo_0_11;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[3], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageTexel_0_0, 0).x;
      debugPrintfEXT("iteration-3_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0, 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1, externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-3_0_1: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030100u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_2.val;
      debugPrintfEXT("iteration-3_0_2: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030200u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_3, ivec2(0, 0)).x;
      debugPrintfEXT("iteration-3_0_3: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030300u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3, ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ssbo_0_4.val;
      debugPrintfEXT("iteration-3_0_4: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030400u) ? 0u : 1u);
      ssbo_0_4.val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5, 0).x;
      debugPrintfEXT("iteration-3_0_5: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030500u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_6, externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-3_0_6: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030600u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_7, 0).x;
      debugPrintfEXT("iteration-3_0_7: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030700u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7, 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_8, ivec2(0, 0)).x;
      debugPrintfEXT("iteration-3_0_8: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030800u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_8, ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_9.val;
      debugPrintfEXT("iteration-3_0_9: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030900u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_10, 0).x;
      debugPrintfEXT("iteration-3_0_10: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030a00u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_11.val;
      debugPrintfEXT("iteration-3_0_11: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030b00u) ? 0u : 1u);
      ssbo_0_11.val = (readValue | 0xff000000u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[3], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[6]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;

layout (set=0, binding=0) uniform uboBlock_0_0 { uint val; } ubo_0_0;
layout (set=0, binding=1) uniform utexture2D sampledImage_0_1;
layout (set=0, binding=2) buffer sboBlock_0_2 { uint val; } ssbo_0_2;
layout (set=0, binding=3, r32ui) uniform uimage2D storageImage_0_3;
layout (set=0, binding=4) uniform utexture2D sampledImage_0_4;
layout (set=0, binding=5) uniform utextureBuffer uniformTexel_0_5;
layout (set=0, binding=6, r32ui) uniform uimage2D storageImage_0_6;
layout (set=0, binding=7, r32ui) uniform uimageBuffer storageTexel_0_7;
layout (set=0, binding=8) uniform utextureBuffer uniformTexel_0_8;
layout (set=0, binding=9) uniform uboBlock_0_9 { uint val; } ubo_0_9;
layout (set=0, binding=10, r32ui) uniform uimageBuffer storageTexel_0_10;
layout (set=0, binding=11) buffer sboBlock_0_11 { uint val; } ssbo_0_11;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[4], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ubo_0_0.val;
      debugPrintfEXT("iteration-4_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040000u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1, externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-4_0_1: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040100u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_2.val;
      debugPrintfEXT("iteration-4_0_2: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040200u) ? 0u : 1u);
      ssbo_0_2.val = (readValue | 0xff000000u);
    }
    {
      uint readValue = imageLoad(storageImage_0_3, ivec2(0, 0)).x;
      debugPrintfEXT("iteration-4_0_3: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040300u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3, ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_4, externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-4_0_4: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040400u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5, 0).x;
      debugPrintfEXT("iteration-4_0_5: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040500u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_6, ivec2(0, 0)).x;
      debugPrintfEXT("iteration-4_0_6: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040600u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_6, ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7, 0).x;
      debugPrintfEXT("iteration-4_0_7: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040700u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7, 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_8, 0).x;
      debugPrintfEXT("iteration-4_0_8: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040800u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9.val;
      debugPrintfEXT("iteration-4_0_9: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040900u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_10, 0).x;
      debugPrintfEXT("iteration-4_0_10: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040a00u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_10, 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ssbo_0_11.val;
      debugPrintfEXT("iteration-4_0_11: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040b00u) ? 0u : 1u);
      ssbo_0_11.val = (readValue | 0xff000000u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[4], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[6]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;

layout (set=0, binding=0) buffer sboBlock_0_0 { uint val; } ssbo_0_0;
layout (set=0, binding=1) uniform utexture2D sampledImage_0_1;
layout (set=0, binding=2) uniform utexture2D sampledImage_0_2;
layout (set=0, binding=3, r32ui) uniform uimage2D storageImage_0_3;
layout (set=0, binding=4, r32ui) uniform uimage2D storageImage_0_4;
layout (set=0, binding=5) uniform utextureBuffer uniformTexel_0_5;
layout (set=0, binding=6) uniform utextureBuffer uniformTexel_0_6;
layout (set=0, binding=7, r32ui) uniform uimageBuffer storageTexel_0_7;
layout (set=0, binding=8, r32ui) uniform uimageBuffer storageTexel_0_8;
layout (set=0, binding=9) uniform uboBlock_0_9 { uint val; } ubo_0_9;
layout (set=0, binding=10) uniform uboBlock_0_10 { uint val; } ubo_0_10;
layout (set=0, binding=11) buffer sboBlock_0_11 { uint val; } ssbo_0_11;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[5], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ssbo_0_0.val;
      debugPrintfEXT("iteration-5_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050000u) ? 0u : 1u);
      ssbo_0_0.val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1, externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-5_0_1: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050100u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_2, externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-5_0_2: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050200u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_3, ivec2(0, 0)).x;
      debugPrintfEXT("iteration-5_0_3: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050300u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3, ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_4, ivec2(0, 0)).x;
      debugPrintfEXT("iteration-5_0_4: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050400u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_4, ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5, 0).x;
      debugPrintfEXT("iteration-5_0_5: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050500u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_6, 0).x;
      debugPrintfEXT("iteration-5_0_6: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050600u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_7, 0).x;
      debugPrintfEXT("iteration-5_0_7: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050700u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7, 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_8, 0).x;
      debugPrintfEXT("iteration-5_0_8: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050800u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_8, 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_9.val;
      debugPrintfEXT("iteration-5_0_9: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050900u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_10.val;
      debugPrintfEXT("iteration-5_0_10: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050a00u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_11.val;
      debugPrintfEXT("iteration-5_0_11: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050b00u) ? 0u : 1u);
      ssbo_0_11.val = (readValue | 0xff000000u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[5], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[6]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;

layout (set=0, binding=0) uniform utexture2D sampledImage_0_0[6];
layout (set=0, binding=0, r32ui) uniform uimage2D storageImage_0_0[6];
layout (set=0, binding=0) uniform utextureBuffer uniformTexel_0_0[6];
layout (set=0, binding=0, r32ui) uniform uimageBuffer storageTexel_0_0[6];
layout (set=0, binding=0) uniform uboBlock_0_0 { uint val; } ubo_0_0[6];
layout (set=0, binding=0) buffer sboBlock_0_0 { uint val; } ssbo_0_0[6];
layout (set=0, binding=1, r32ui) uniform uimage2D storageImage_0_1[6];
layout (set=0, binding=1) uniform utextureBuffer uniformTexel_0_1[6];
layout (set=0, binding=1, r32ui) uniform uimageBuffer storageTexel_0_1[6];
layout (set=0, binding=1) uniform uboBlock_0_1 { uint val; } ubo_0_1[6];
layout (set=0, binding=1) buffer sboBlock_0_1 { uint val; } ssbo_0_1[6];
layout (set=0, binding=1) uniform utexture2D sampledImage_0_1[6];
layout (set=0, binding=2) uniform utextureBuffer uniformTexel_0_2[6];
layout (set=0, binding=2, r32ui) uniform uimageBuffer storageTexel_0_2[6];
layout (set=0, binding=2) uniform uboBlock_0_2 { uint val; } ubo_0_2[6];
layout (set=0, binding=2) buffer sboBlock_0_2 { uint val; } ssbo_0_2[6];
layout (set=0, binding=2) uniform utexture2D sampledImage_0_2[6];
layout (set=0, binding=2, r32ui) uniform uimage2D storageImage_0_2[6];
layout (set=0, binding=3, r32ui) uniform uimageBuffer storageTexel_0_3[6];
layout (set=0, binding=3) uniform uboBlock_0_3 { uint val; } ubo_0_3[6];
layout (set=0, binding=3) buffer sboBlock_0_3 { uint val; } ssbo_0_3[6];
layout (set=0, binding=3) uniform utexture2D sampledImage_0_3[6];
layout (set=0, binding=3, r32ui) uniform uimage2D storageImage_0_3[6];
layout (set=0, binding=3) uniform utextureBuffer uniformTexel_0_3[6];
layout (set=0, binding=4) uniform uboBlock_0_4 { uint val; } ubo_0_4[6];
layout (set=0, binding=4) buffer sboBlock_0_4 { uint val; } ssbo_0_4[6];
layout (set=0, binding=4) uniform utexture2D sampledImage_0_4[6];
layout (set=0, binding=4, r32ui) uniform uimage2D storageImage_0_4[6];
layout (set=0, binding=4) uniform utextureBuffer uniformTexel_0_4[6];
layout (set=0, binding=4, r32ui) uniform uimageBuffer storageTexel_0_4[6];
layout (set=0, binding=5) buffer sboBlock_0_5 { uint val; } ssbo_0_5[];
layout (set=0, binding=5) uniform utexture2D sampledImage_0_5[];
layout (set=0, binding=5, r32ui) uniform uimage2D storageImage_0_5[];
layout (set=0, binding=5) uniform utextureBuffer uniformTexel_0_5[];
layout (set=0, binding=5, r32ui) uniform uimageBuffer storageTexel_0_5[];
layout (set=0, binding=5) uniform uboBlock_0_5 { uint val; } ubo_0_5[];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(usampler2D(sampledImage_0_0[0], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_0[0]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_0[1], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-0_0_0[1]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000001u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0[1], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_0[2], 0).x;
      debugPrintfEXT("iteration-0_0_0[2]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000002u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_0[3], 0).x;
      debugPrintfEXT("iteration-0_0_0[3]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000003u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0[3], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_0[4].val;
      debugPrintfEXT("iteration-0_0_0[4]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000004u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_0[5].val;
      debugPrintfEXT("iteration-0_0_0[5]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000005u) ? 0u : 1u);
      ssbo_0_0[5].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = imageLoad(storageImage_0_1[0], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-0_0_1[0]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000100u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_1[0], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_1[1], 0).x;
      debugPrintfEXT("iteration-0_0_1[1]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000101u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_1[2], 0).x;
      debugPrintfEXT("iteration-0_0_1[2]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000102u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_1[2], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_1[3].val;
      debugPrintfEXT("iteration-0_0_1[3]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000103u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_1[4].val;
      debugPrintfEXT("iteration-0_0_1[4]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000104u) ? 0u : 1u);
      ssbo_0_1[4].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[5], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_1[5]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000105u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_2[0], 0).x;
      debugPrintfEXT("iteration-0_0_2[0]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000200u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_2[1], 0).x;
      debugPrintfEXT("iteration-0_0_2[1]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000201u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_2[1], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_2[2].val;
      debugPrintfEXT("iteration-0_0_2[2]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000202u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_2[3].val;
      debugPrintfEXT("iteration-0_0_2[3]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000203u) ? 0u : 1u);
      ssbo_0_2[3].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_2[4], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_2[4]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000204u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_2[5], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-0_0_2[5]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000205u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_2[5], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_3[0], 0).x;
      debugPrintfEXT("iteration-0_0_3[0]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000300u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_3[0], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_3[1].val;
      debugPrintfEXT("iteration-0_0_3[1]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000301u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_3[2].val;
      debugPrintfEXT("iteration-0_0_3[2]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000302u) ? 0u : 1u);
      ssbo_0_3[2].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_3[3], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_3[3]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000303u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_3[4], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-0_0_3[4]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000304u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[4], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_3[5], 0).x;
      debugPrintfEXT("iteration-0_0_3[5]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000305u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_4[0].val;
      debugPrintfEXT("iteration-0_0_4[0]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000400u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_4[1].val;
      debugPrintfEXT("iteration-0_0_4[1]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000401u) ? 0u : 1u);
      ssbo_0_4[1].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_4[2], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_4[2]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000402u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_4[3], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-0_0_4[3]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000403u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_4[3], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_4[4], 0).x;
      debugPrintfEXT("iteration-0_0_4[4]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000404u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_4[5], 0).x;
      debugPrintfEXT("iteration-0_0_4[5]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000405u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_4[5], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ssbo_0_5[0].val;
      debugPrintfEXT("iteration-0_0_5[0]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000500u) ? 0u : 1u);
      ssbo_0_5[0].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_5[1], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_5[1]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000501u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_5[2], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-0_0_5[2]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000502u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_5[2], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[3], 0).x;
      debugPrintfEXT("iteration-0_0_5[3]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000503u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_5[4], 0).x;
      debugPrintfEXT("iteration-0_0_5[4]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000504u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_5[4], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_5[5].val;
      debugPrintfEXT("iteration-0_0_5[5]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000505u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[6]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;

layout (set=0, binding=0, r32ui) uniform uimage2D storageImage_0_0[6];
layout (set=0, binding=0) uniform utextureBuffer uniformTexel_0_0[6];
layout (set=0, binding=0, r32ui) uniform uimageBuffer storageTexel_0_0[6];
layout (set=0, binding=0) uniform uboBlock_0_0 { uint val; } ubo_0_0[6];
layout (set=0, binding=0) buffer sboBlock_0_0 { uint val; } ssbo_0_0[6];
layout (set=0, binding=0) uniform utexture2D sampledImage_0_0[6];
layout (set=0, binding=1) uniform utextureBuffer uniformTexel_0_1[6];
layout (set=0, binding=1, r32ui) uniform uimageBuffer storageTexel_0_1[6];
layout (set=0, binding=1) uniform uboBlock_0_1 { uint val; } ubo_0_1[6];
layout (set=0, binding=1) buffer sboBlock_0_1 { uint val; } ssbo_0_1[6];
layout (set=0, binding=1) uniform utexture2D sampledImage_0_1[6];
layout (set=0, binding=1, r32ui) uniform uimage2D storageImage_0_1[6];
layout (set=0, binding=2, r32ui) uniform uimageBuffer storageTexel_0_2[6];
layout (set=0, binding=2) uniform uboBlock_0_2 { uint val; } ubo_0_2[6];
layout (set=0, binding=2) buffer sboBlock_0_2 { uint val; } ssbo_0_2[6];
layout (set=0, binding=2) uniform utexture2D sampledImage_0_2[6];
layout (set=0, binding=2, r32ui) uniform uimage2D storageImage_0_2[6];
layout (set=0, binding=2) uniform utextureBuffer uniformTexel_0_2[6];
layout (set=0, binding=3) uniform uboBlock_0_3 { uint val; } ubo_0_3[6];
layout (set=0, binding=3) buffer sboBlock_0_3 { uint val; } ssbo_0_3[6];
layout (set=0, binding=3) uniform utexture2D sampledImage_0_3[6];
layout (set=0, binding=3, r32ui) uniform uimage2D storageImage_0_3[6];
layout (set=0, binding=3) uniform utextureBuffer uniformTexel_0_3[6];
layout (set=0, binding=3, r32ui) uniform uimageBuffer storageTexel_0_3[6];
layout (set=0, binding=4) buffer sboBlock_0_4 { uint val; } ssbo_0_4[6];
layout (set=0, binding=4) uniform utexture2D sampledImage_0_4[6];
layout (set=0, binding=4, r32ui) uniform uimage2D storageImage_0_4[6];
layout (set=0, binding=4) uniform utextureBuffer uniformTexel_0_4[6];
layout (set=0, binding=4, r32ui) uniform uimageBuffer storageTexel_0_4[6];
layout (set=0, binding=4) uniform uboBlock_0_4 { uint val; } ubo_0_4[6];
layout (set=0, binding=5) uniform utexture2D sampledImage_0_5[];
layout (set=0, binding=5, r32ui) uniform uimage2D storageImage_0_5[];
layout (set=0, binding=5) uniform utextureBuffer uniformTexel_0_5[];
layout (set=0, binding=5, r32ui) uniform uimageBuffer storageTexel_0_5[];
layout (set=0, binding=5) uniform uboBlock_0_5 { uint val; } ubo_0_5[];
layout (set=0, binding=5) buffer sboBlock_0_5 { uint val; } ssbo_0_5[];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageImage_0_0[0], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_0[0]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0[0], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_0[1], 0).x;
      debugPrintfEXT("iteration-1_0_0[1]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010001u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_0[2], 0).x;
      debugPrintfEXT("iteration-1_0_0[2]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010002u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0[2], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_0[3].val;
      debugPrintfEXT("iteration-1_0_0[3]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010003u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_0[4].val;
      debugPrintfEXT("iteration-1_0_0[4]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010004u) ? 0u : 1u);
      ssbo_0_0[4].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_0[5], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_0[5]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010005u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_1[0], 0).x;
      debugPrintfEXT("iteration-1_0_1[0]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010100u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_1[1], 0).x;
      debugPrintfEXT("iteration-1_0_1[1]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010101u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_1[1], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_1[2].val;
      debugPrintfEXT("iteration-1_0_1[2]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010102u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_1[3].val;
      debugPrintfEXT("iteration-1_0_1[3]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010103u) ? 0u : 1u);
      ssbo_0_1[3].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[4], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_1[4]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010104u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_1[5], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_1[5]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010105u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_1[5], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_2[0], 0).x;
      debugPrintfEXT("iteration-1_0_2[0]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010200u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_2[0], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_2[1].val;
      debugPrintfEXT("iteration-1_0_2[1]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010201u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_2[2].val;
      debugPrintfEXT("iteration-1_0_2[2]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010202u) ? 0u : 1u);
      ssbo_0_2[2].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_2[3], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_2[3]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010203u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_2[4], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_2[4]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010204u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_2[4], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_2[5], 0).x;
      debugPrintfEXT("iteration-1_0_2[5]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010205u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_3[0].val;
      debugPrintfEXT("iteration-1_0_3[0]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010300u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_3[1].val;
      debugPrintfEXT("iteration-1_0_3[1]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010301u) ? 0u : 1u);
      ssbo_0_3[1].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_3[2], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_3[2]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010302u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_3[3], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_3[3]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010303u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[3], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_3[4], 0).x;
      debugPrintfEXT("iteration-1_0_3[4]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010304u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_3[5], 0).x;
      debugPrintfEXT("iteration-1_0_3[5]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010305u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_3[5], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ssbo_0_4[0].val;
      debugPrintfEXT("iteration-1_0_4[0]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010400u) ? 0u : 1u);
      ssbo_0_4[0].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_4[1], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_4[1]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010401u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_4[2], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_4[2]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010402u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_4[2], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_4[3], 0).x;
      debugPrintfEXT("iteration-1_0_4[3]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010403u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_4[4], 0).x;
      debugPrintfEXT("iteration-1_0_4[4]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010404u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_4[4], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_4[5].val;
      debugPrintfEXT("iteration-1_0_4[5]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010405u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_5[0], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_5[0]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010500u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_5[1], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_5[1]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010501u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_5[1], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[2], 0).x;
      debugPrintfEXT("iteration-1_0_5[2]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010502u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_5[3], 0).x;
      debugPrintfEXT("iteration-1_0_5[3]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010503u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_5[3], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_5[4].val;
      debugPrintfEXT("iteration-1_0_5[4]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010504u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_5[5].val;
      debugPrintfEXT("iteration-1_0_5[5]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010505u) ? 0u : 1u);
      ssbo_0_5[5].val = (readValue | 0xff000000u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[6]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;

layout (set=0, binding=0) uniform utextureBuffer uniformTexel_0_0[6];
layout (set=0, binding=0, r32ui) uniform uimageBuffer storageTexel_0_0[6];
layout (set=0, binding=0) uniform uboBlock_0_0 { uint val; } ubo_0_0[6];
layout (set=0, binding=0) buffer sboBlock_0_0 { uint val; } ssbo_0_0[6];
layout (set=0, binding=0) uniform utexture2D sampledImage_0_0[6];
layout (set=0, binding=0, r32ui) uniform uimage2D storageImage_0_0[6];
layout (set=0, binding=1, r32ui) uniform uimageBuffer storageTexel_0_1[6];
layout (set=0, binding=1) uniform uboBlock_0_1 { uint val; } ubo_0_1[6];
layout (set=0, binding=1) buffer sboBlock_0_1 { uint val; } ssbo_0_1[6];
layout (set=0, binding=1) uniform utexture2D sampledImage_0_1[6];
layout (set=0, binding=1, r32ui) uniform uimage2D storageImage_0_1[6];
layout (set=0, binding=1) uniform utextureBuffer uniformTexel_0_1[6];
layout (set=0, binding=2) uniform uboBlock_0_2 { uint val; } ubo_0_2[6];
layout (set=0, binding=2) buffer sboBlock_0_2 { uint val; } ssbo_0_2[6];
layout (set=0, binding=2) uniform utexture2D sampledImage_0_2[6];
layout (set=0, binding=2, r32ui) uniform uimage2D storageImage_0_2[6];
layout (set=0, binding=2) uniform utextureBuffer uniformTexel_0_2[6];
layout (set=0, binding=2, r32ui) uniform uimageBuffer storageTexel_0_2[6];
layout (set=0, binding=3) buffer sboBlock_0_3 { uint val; } ssbo_0_3[6];
layout (set=0, binding=3) uniform utexture2D sampledImage_0_3[6];
layout (set=0, binding=3, r32ui) uniform uimage2D storageImage_0_3[6];
layout (set=0, binding=3) uniform utextureBuffer uniformTexel_0_3[6];
layout (set=0, binding=3, r32ui) uniform uimageBuffer storageTexel_0_3[6];
layout (set=0, binding=3) uniform uboBlock_0_3 { uint val; } ubo_0_3[6];
layout (set=0, binding=4) uniform utexture2D sampledImage_0_4[6];
layout (set=0, binding=4, r32ui) uniform uimage2D storageImage_0_4[6];
layout (set=0, binding=4) uniform utextureBuffer uniformTexel_0_4[6];
layout (set=0, binding=4, r32ui) uniform uimageBuffer storageTexel_0_4[6];
layout (set=0, binding=4) uniform uboBlock_0_4 { uint val; } ubo_0_4[6];
layout (set=0, binding=4) buffer sboBlock_0_4 { uint val; } ssbo_0_4[6];
layout (set=0, binding=5, r32ui) uniform uimage2D storageImage_0_5[];
layout (set=0, binding=5) uniform utextureBuffer uniformTexel_0_5[];
layout (set=0, binding=5, r32ui) uniform uimageBuffer storageTexel_0_5[];
layout (set=0, binding=5) uniform uboBlock_0_5 { uint val; } ubo_0_5[];
layout (set=0, binding=5) buffer sboBlock_0_5 { uint val; } ssbo_0_5[];
layout (set=0, binding=5) uniform utexture2D sampledImage_0_5[];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[2], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texelFetch(uniformTexel_0_0[0], 0).x;
      debugPrintfEXT("iteration-2_0_0[0]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020000u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_0[1], 0).x;
      debugPrintfEXT("iteration-2_0_0[1]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020001u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0[1], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_0[2].val;
      debugPrintfEXT("iteration-2_0_0[2]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020002u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_0[3].val;
      debugPrintfEXT("iteration-2_0_0[3]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020003u) ? 0u : 1u);
      ssbo_0_0[3].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_0[4], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-2_0_0[4]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020004u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_0[5], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-2_0_0[5]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020005u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0[5], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_1[0], 0).x;
      debugPrintfEXT("iteration-2_0_1[0]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020100u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_1[0], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_1[1].val;
      debugPrintfEXT("iteration-2_0_1[1]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020101u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_1[2].val;
      debugPrintfEXT("iteration-2_0_1[2]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020102u) ? 0u : 1u);
      ssbo_0_1[2].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[3], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-2_0_1[3]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020103u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_1[4], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-2_0_1[4]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020104u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_1[4], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_1[5], 0).x;
      debugPrintfEXT("iteration-2_0_1[5]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020105u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_2[0].val;
      debugPrintfEXT("iteration-2_0_2[0]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020200u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_2[1].val;
      debugPrintfEXT("iteration-2_0_2[1]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020201u) ? 0u : 1u);
      ssbo_0_2[1].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_2[2], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-2_0_2[2]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020202u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_2[3], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-2_0_2[3]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020203u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_2[3], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_2[4], 0).x;
      debugPrintfEXT("iteration-2_0_2[4]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020204u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_2[5], 0).x;
      debugPrintfEXT("iteration-2_0_2[5]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020205u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_2[5], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ssbo_0_3[0].val;
      debugPrintfEXT("iteration-2_0_3[0]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020300u) ? 0u : 1u);
      ssbo_0_3[0].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_3[1], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-2_0_3[1]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020301u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_3[2], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-2_0_3[2]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020302u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[2], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_3[3], 0).x;
      debugPrintfEXT("iteration-2_0_3[3]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020303u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_3[4], 0).x;
      debugPrintfEXT("iteration-2_0_3[4]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020304u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_3[4], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_3[5].val;
      debugPrintfEXT("iteration-2_0_3[5]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020305u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_4[0], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-2_0_4[0]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020400u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_4[1], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-2_0_4[1]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020401u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_4[1], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_4[2], 0).x;
      debugPrintfEXT("iteration-2_0_4[2]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020402u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_4[3], 0).x;
      debugPrintfEXT("iteration-2_0_4[3]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020403u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_4[3], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_4[4].val;
      debugPrintfEXT("iteration-2_0_4[4]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020404u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_4[5].val;
      debugPrintfEXT("iteration-2_0_4[5]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020405u) ? 0u : 1u);
      ssbo_0_4[5].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = imageLoad(storageImage_0_5[0], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-2_0_5[0]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020500u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_5[0], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[1], 0).x;
      debugPrintfEXT("iteration-2_0_5[1]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020501u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_5[2], 0).x;
      debugPrintfEXT("iteration-2_0_5[2]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020502u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_5[2], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_5[3].val;
      debugPrintfEXT("iteration-2_0_5[3]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020503u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_5[4].val;
      debugPrintfEXT("iteration-2_0_5[4]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020504u) ? 0u : 1u);
      ssbo_0_5[4].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_5[5], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-2_0_5[5]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020505u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[2], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[6]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;

layout (set=0, binding=0, r32ui) uniform uimageBuffer storageTexel_0_0[6];
layout (set=0, binding=0) uniform uboBlock_0_0 { uint val; } ubo_0_0[6];
layout (set=0, binding=0) buffer sboBlock_0_0 { uint val; } ssbo_0_0[6];
layout (set=0, binding=0) uniform utexture2D sampledImage_0_0[6];
layout (set=0, binding=0, r32ui) uniform uimage2D storageImage_0_0[6];
layout (set=0, binding=0) uniform utextureBuffer uniformTexel_0_0[6];
layout (set=0, binding=1) uniform uboBlock_0_1 { uint val; } ubo_0_1[6];
layout (set=0, binding=1) buffer sboBlock_0_1 { uint val; } ssbo_0_1[6];
layout (set=0, binding=1) uniform utexture2D sampledImage_0_1[6];
layout (set=0, binding=1, r32ui) uniform uimage2D storageImage_0_1[6];
layout (set=0, binding=1) uniform utextureBuffer uniformTexel_0_1[6];
layout (set=0, binding=1, r32ui) uniform uimageBuffer storageTexel_0_1[6];
layout (set=0, binding=2) buffer sboBlock_0_2 { uint val; } ssbo_0_2[6];
layout (set=0, binding=2) uniform utexture2D sampledImage_0_2[6];
layout (set=0, binding=2, r32ui) uniform uimage2D storageImage_0_2[6];
layout (set=0, binding=2) uniform utextureBuffer uniformTexel_0_2[6];
layout (set=0, binding=2, r32ui) uniform uimageBuffer storageTexel_0_2[6];
layout (set=0, binding=2) uniform uboBlock_0_2 { uint val; } ubo_0_2[6];
layout (set=0, binding=3) uniform utexture2D sampledImage_0_3[6];
layout (set=0, binding=3, r32ui) uniform uimage2D storageImage_0_3[6];
layout (set=0, binding=3) uniform utextureBuffer uniformTexel_0_3[6];
layout (set=0, binding=3, r32ui) uniform uimageBuffer storageTexel_0_3[6];
layout (set=0, binding=3) uniform uboBlock_0_3 { uint val; } ubo_0_3[6];
layout (set=0, binding=3) buffer sboBlock_0_3 { uint val; } ssbo_0_3[6];
layout (set=0, binding=4, r32ui) uniform uimage2D storageImage_0_4[6];
layout (set=0, binding=4) uniform utextureBuffer uniformTexel_0_4[6];
layout (set=0, binding=4, r32ui) uniform uimageBuffer storageTexel_0_4[6];
layout (set=0, binding=4) uniform uboBlock_0_4 { uint val; } ubo_0_4[6];
layout (set=0, binding=4) buffer sboBlock_0_4 { uint val; } ssbo_0_4[6];
layout (set=0, binding=4) uniform utexture2D sampledImage_0_4[6];
layout (set=0, binding=5) uniform utextureBuffer uniformTexel_0_5[];
layout (set=0, binding=5, r32ui) uniform uimageBuffer storageTexel_0_5[];
layout (set=0, binding=5) uniform uboBlock_0_5 { uint val; } ubo_0_5[];
layout (set=0, binding=5) buffer sboBlock_0_5 { uint val; } ssbo_0_5[];
layout (set=0, binding=5) uniform utexture2D sampledImage_0_5[];
layout (set=0, binding=5, r32ui) uniform uimage2D storageImage_0_5[];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[3], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageTexel_0_0[0], 0).x;
      debugPrintfEXT("iteration-3_0_0[0]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0[0], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_0[1].val;
      debugPrintfEXT("iteration-3_0_0[1]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030001u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_0[2].val;
      debugPrintfEXT("iteration-3_0_0[2]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030002u) ? 0u : 1u);
      ssbo_0_0[2].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_0[3], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-3_0_0[3]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030003u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_0[4], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-3_0_0[4]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030004u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0[4], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_0[5], 0).x;
      debugPrintfEXT("iteration-3_0_0[5]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030005u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_1[0].val;
      debugPrintfEXT("iteration-3_0_1[0]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030100u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_1[1].val;
      debugPrintfEXT("iteration-3_0_1[1]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030101u) ? 0u : 1u);
      ssbo_0_1[1].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[2], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-3_0_1[2]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030102u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_1[3], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-3_0_1[3]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030103u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_1[3], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_1[4], 0).x;
      debugPrintfEXT("iteration-3_0_1[4]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030104u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_1[5], 0).x;
      debugPrintfEXT("iteration-3_0_1[5]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030105u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_1[5], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ssbo_0_2[0].val;
      debugPrintfEXT("iteration-3_0_2[0]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030200u) ? 0u : 1u);
      ssbo_0_2[0].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_2[1], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-3_0_2[1]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030201u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_2[2], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-3_0_2[2]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030202u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_2[2], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_2[3], 0).x;
      debugPrintfEXT("iteration-3_0_2[3]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030203u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_2[4], 0).x;
      debugPrintfEXT("iteration-3_0_2[4]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030204u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_2[4], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_2[5].val;
      debugPrintfEXT("iteration-3_0_2[5]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030205u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_3[0], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-3_0_3[0]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030300u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_3[1], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-3_0_3[1]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030301u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[1], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_3[2], 0).x;
      debugPrintfEXT("iteration-3_0_3[2]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030302u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_3[3], 0).x;
      debugPrintfEXT("iteration-3_0_3[3]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030303u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_3[3], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_3[4].val;
      debugPrintfEXT("iteration-3_0_3[4]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030304u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_3[5].val;
      debugPrintfEXT("iteration-3_0_3[5]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030305u) ? 0u : 1u);
      ssbo_0_3[5].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = imageLoad(storageImage_0_4[0], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-3_0_4[0]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030400u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_4[0], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_4[1], 0).x;
      debugPrintfEXT("iteration-3_0_4[1]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030401u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_4[2], 0).x;
      debugPrintfEXT("iteration-3_0_4[2]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030402u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_4[2], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_4[3].val;
      debugPrintfEXT("iteration-3_0_4[3]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030403u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_4[4].val;
      debugPrintfEXT("iteration-3_0_4[4]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030404u) ? 0u : 1u);
      ssbo_0_4[4].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_4[5], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-3_0_4[5]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030405u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[0], 0).x;
      debugPrintfEXT("iteration-3_0_5[0]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030500u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_5[1], 0).x;
      debugPrintfEXT("iteration-3_0_5[1]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030501u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_5[1], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_5[2].val;
      debugPrintfEXT("iteration-3_0_5[2]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030502u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_5[3].val;
      debugPrintfEXT("iteration-3_0_5[3]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030503u) ? 0u : 1u);
      ssbo_0_5[3].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_5[4], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-3_0_5[4]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030504u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_5[5], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-3_0_5[5]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030505u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_5[5], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[3], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[6]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;

layout (set=0, binding=0) uniform uboBlock_0_0 { uint val; } ubo_0_0[6];
layout (set=0, binding=0) buffer sboBlock_0_0 { uint val; } ssbo_0_0[6];
layout (set=0, binding=0) uniform utexture2D sampledImage_0_0[6];
layout (set=0, binding=0, r32ui) uniform uimage2D storageImage_0_0[6];
layout (set=0, binding=0) uniform utextureBuffer uniformTexel_0_0[6];
layout (set=0, binding=0, r32ui) uniform uimageBuffer storageTexel_0_0[6];
layout (set=0, binding=1) buffer sboBlock_0_1 { uint val; } ssbo_0_1[6];
layout (set=0, binding=1) uniform utexture2D sampledImage_0_1[6];
layout (set=0, binding=1, r32ui) uniform uimage2D storageImage_0_1[6];
layout (set=0, binding=1) uniform utextureBuffer uniformTexel_0_1[6];
layout (set=0, binding=1, r32ui) uniform uimageBuffer storageTexel_0_1[6];
layout (set=0, binding=1) uniform uboBlock_0_1 { uint val; } ubo_0_1[6];
layout (set=0, binding=2) uniform utexture2D sampledImage_0_2[6];
layout (set=0, binding=2, r32ui) uniform uimage2D storageImage_0_2[6];
layout (set=0, binding=2) uniform utextureBuffer uniformTexel_0_2[6];
layout (set=0, binding=2, r32ui) uniform uimageBuffer storageTexel_0_2[6];
layout (set=0, binding=2) uniform uboBlock_0_2 { uint val; } ubo_0_2[6];
layout (set=0, binding=2) buffer sboBlock_0_2 { uint val; } ssbo_0_2[6];
layout (set=0, binding=3, r32ui) uniform uimage2D storageImage_0_3[6];
layout (set=0, binding=3) uniform utextureBuffer uniformTexel_0_3[6];
layout (set=0, binding=3, r32ui) uniform uimageBuffer storageTexel_0_3[6];
layout (set=0, binding=3) uniform uboBlock_0_3 { uint val; } ubo_0_3[6];
layout (set=0, binding=3) buffer sboBlock_0_3 { uint val; } ssbo_0_3[6];
layout (set=0, binding=3) uniform utexture2D sampledImage_0_3[6];
layout (set=0, binding=4) uniform utextureBuffer uniformTexel_0_4[6];
layout (set=0, binding=4, r32ui) uniform uimageBuffer storageTexel_0_4[6];
layout (set=0, binding=4) uniform uboBlock_0_4 { uint val; } ubo_0_4[6];
layout (set=0, binding=4) buffer sboBlock_0_4 { uint val; } ssbo_0_4[6];
layout (set=0, binding=4) uniform utexture2D sampledImage_0_4[6];
layout (set=0, binding=4, r32ui) uniform uimage2D storageImage_0_4[6];
layout (set=0, binding=5, r32ui) uniform uimageBuffer storageTexel_0_5[];
layout (set=0, binding=5) uniform uboBlock_0_5 { uint val; } ubo_0_5[];
layout (set=0, binding=5) buffer sboBlock_0_5 { uint val; } ssbo_0_5[];
layout (set=0, binding=5) uniform utexture2D sampledImage_0_5[];
layout (set=0, binding=5, r32ui) uniform uimage2D storageImage_0_5[];
layout (set=0, binding=5) uniform utextureBuffer uniformTexel_0_5[];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[4], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ubo_0_0[0].val;
      debugPrintfEXT("iteration-4_0_0[0]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040000u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_0[1].val;
      debugPrintfEXT("iteration-4_0_0[1]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040001u) ? 0u : 1u);
      ssbo_0_0[1].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_0[2], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-4_0_0[2]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040002u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_0[3], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-4_0_0[3]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040003u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0[3], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_0[4], 0).x;
      debugPrintfEXT("iteration-4_0_0[4]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040004u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_0[5], 0).x;
      debugPrintfEXT("iteration-4_0_0[5]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040005u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0[5], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ssbo_0_1[0].val;
      debugPrintfEXT("iteration-4_0_1[0]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040100u) ? 0u : 1u);
      ssbo_0_1[0].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[1], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-4_0_1[1]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040101u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_1[2], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-4_0_1[2]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040102u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_1[2], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_1[3], 0).x;
      debugPrintfEXT("iteration-4_0_1[3]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040103u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_1[4], 0).x;
      debugPrintfEXT("iteration-4_0_1[4]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040104u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_1[4], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_1[5].val;
      debugPrintfEXT("iteration-4_0_1[5]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040105u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_2[0], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-4_0_2[0]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040200u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_2[1], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-4_0_2[1]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040201u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_2[1], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_2[2], 0).x;
      debugPrintfEXT("iteration-4_0_2[2]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040202u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_2[3], 0).x;
      debugPrintfEXT("iteration-4_0_2[3]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040203u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_2[3], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_2[4].val;
      debugPrintfEXT("iteration-4_0_2[4]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040204u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_2[5].val;
      debugPrintfEXT("iteration-4_0_2[5]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040205u) ? 0u : 1u);
      ssbo_0_2[5].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = imageLoad(storageImage_0_3[0], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-4_0_3[0]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040300u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[0], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_3[1], 0).x;
      debugPrintfEXT("iteration-4_0_3[1]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040301u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_3[2], 0).x;
      debugPrintfEXT("iteration-4_0_3[2]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040302u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_3[2], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_3[3].val;
      debugPrintfEXT("iteration-4_0_3[3]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040303u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_3[4].val;
      debugPrintfEXT("iteration-4_0_3[4]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040304u) ? 0u : 1u);
      ssbo_0_3[4].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_3[5], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-4_0_3[5]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040305u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_4[0], 0).x;
      debugPrintfEXT("iteration-4_0_4[0]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040400u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_4[1], 0).x;
      debugPrintfEXT("iteration-4_0_4[1]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040401u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_4[1], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_4[2].val;
      debugPrintfEXT("iteration-4_0_4[2]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040402u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_4[3].val;
      debugPrintfEXT("iteration-4_0_4[3]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040403u) ? 0u : 1u);
      ssbo_0_4[3].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_4[4], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-4_0_4[4]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040404u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_4[5], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-4_0_4[5]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040405u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_4[5], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_5[0], 0).x;
      debugPrintfEXT("iteration-4_0_5[0]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040500u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_5[0], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_5[1].val;
      debugPrintfEXT("iteration-4_0_5[1]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040501u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_5[2].val;
      debugPrintfEXT("iteration-4_0_5[2]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040502u) ? 0u : 1u);
      ssbo_0_5[2].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_5[3], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-4_0_5[3]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040503u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_5[4], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-4_0_5[4]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040504u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_5[4], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[5], 0).x;
      debugPrintfEXT("iteration-4_0_5[5]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040505u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[4], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[6]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;

layout (set=0, binding=0) buffer sboBlock_0_0 { uint val; } ssbo_0_0[6];
layout (set=0, binding=0) uniform utexture2D sampledImage_0_0[6];
layout (set=0, binding=0, r32ui) uniform uimage2D storageImage_0_0[6];
layout (set=0, binding=0) uniform utextureBuffer uniformTexel_0_0[6];
layout (set=0, binding=0, r32ui) uniform uimageBuffer storageTexel_0_0[6];
layout (set=0, binding=0) uniform uboBlock_0_0 { uint val; } ubo_0_0[6];
layout (set=0, binding=1) uniform utexture2D sampledImage_0_1[6];
layout (set=0, binding=1, r32ui) uniform uimage2D storageImage_0_1[6];
layout (set=0, binding=1) uniform utextureBuffer uniformTexel_0_1[6];
layout (set=0, binding=1, r32ui) uniform uimageBuffer storageTexel_0_1[6];
layout (set=0, binding=1) uniform uboBlock_0_1 { uint val; } ubo_0_1[6];
layout (set=0, binding=1) buffer sboBlock_0_1 { uint val; } ssbo_0_1[6];
layout (set=0, binding=2, r32ui) uniform uimage2D storageImage_0_2[6];
layout (set=0, binding=2) uniform utextureBuffer uniformTexel_0_2[6];
layout (set=0, binding=2, r32ui) uniform uimageBuffer storageTexel_0_2[6];
layout (set=0, binding=2) uniform uboBlock_0_2 { uint val; } ubo_0_2[6];
layout (set=0, binding=2) buffer sboBlock_0_2 { uint val; } ssbo_0_2[6];
layout (set=0, binding=2) uniform utexture2D sampledImage_0_2[6];
layout (set=0, binding=3) uniform utextureBuffer uniformTexel_0_3[6];
layout (set=0, binding=3, r32ui) uniform uimageBuffer storageTexel_0_3[6];
layout (set=0, binding=3) uniform uboBlock_0_3 { uint val; } ubo_0_3[6];
layout (set=0, binding=3) buffer sboBlock_0_3 { uint val; } ssbo_0_3[6];
layout (set=0, binding=3) uniform utexture2D sampledImage_0_3[6];
layout (set=0, binding=3, r32ui) uniform uimage2D storageImage_0_3[6];
layout (set=0, binding=4, r32ui) uniform uimageBuffer storageTexel_0_4[6];
layout (set=0, binding=4) uniform uboBlock_0_4 { uint val; } ubo_0_4[6];
layout (set=0, binding=4) buffer sboBlock_0_4 { uint val; } ssbo_0_4[6];
layout (set=0, binding=4) uniform utexture2D sampledImage_0_4[6];
layout (set=0, binding=4, r32ui) uniform uimage2D storageImage_0_4[6];
layout (set=0, binding=4) uniform utextureBuffer uniformTexel_0_4[6];
layout (set=0, binding=5) uniform uboBlock_0_5 { uint val; } ubo_0_5[];
layout (set=0, binding=5) buffer sboBlock_0_5 { uint val; } ssbo_0_5[];
layout (set=0, binding=5) uniform utexture2D sampledImage_0_5[];
layout (set=0, binding=5, r32ui) uniform uimage2D storageImage_0_5[];
layout (set=0, binding=5) uniform utextureBuffer uniformTexel_0_5[];
layout (set=0, binding=5, r32ui) uniform uimageBuffer storageTexel_0_5[];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[5], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ssbo_0_0[0].val;
      debugPrintfEXT("iteration-5_0_0[0]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050000u) ? 0u : 1u);
      ssbo_0_0[0].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_0[1], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-5_0_0[1]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050001u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_0[2], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-5_0_0[2]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050002u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0[2], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_0[3], 0).x;
      debugPrintfEXT("iteration-5_0_0[3]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050003u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_0[4], 0).x;
      debugPrintfEXT("iteration-5_0_0[4]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050004u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0[4], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_0[5].val;
      debugPrintfEXT("iteration-5_0_0[5]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050005u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[0], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-5_0_1[0]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050100u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_1[1], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-5_0_1[1]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050101u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_1[1], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_1[2], 0).x;
      debugPrintfEXT("iteration-5_0_1[2]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050102u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_1[3], 0).x;
      debugPrintfEXT("iteration-5_0_1[3]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050103u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_1[3], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_1[4].val;
      debugPrintfEXT("iteration-5_0_1[4]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050104u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_1[5].val;
      debugPrintfEXT("iteration-5_0_1[5]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050105u) ? 0u : 1u);
      ssbo_0_1[5].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = imageLoad(storageImage_0_2[0], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-5_0_2[0]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050200u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_2[0], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_2[1], 0).x;
      debugPrintfEXT("iteration-5_0_2[1]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050201u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_2[2], 0).x;
      debugPrintfEXT("iteration-5_0_2[2]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050202u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_2[2], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_2[3].val;
      debugPrintfEXT("iteration-5_0_2[3]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050203u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_2[4].val;
      debugPrintfEXT("iteration-5_0_2[4]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050204u) ? 0u : 1u);
      ssbo_0_2[4].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_2[5], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-5_0_2[5]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050205u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_3[0], 0).x;
      debugPrintfEXT("iteration-5_0_3[0]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050300u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_3[1], 0).x;
      debugPrintfEXT("iteration-5_0_3[1]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050301u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_3[1], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_3[2].val;
      debugPrintfEXT("iteration-5_0_3[2]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050302u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_3[3].val;
      debugPrintfEXT("iteration-5_0_3[3]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050303u) ? 0u : 1u);
      ssbo_0_3[3].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_3[4], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-5_0_3[4]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050304u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_3[5], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-5_0_3[5]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050305u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[5], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_4[0], 0).x;
      debugPrintfEXT("iteration-5_0_4[0]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050400u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_4[0], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_4[1].val;
      debugPrintfEXT("iteration-5_0_4[1]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050401u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_4[2].val;
      debugPrintfEXT("iteration-5_0_4[2]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050402u) ? 0u : 1u);
      ssbo_0_4[2].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_4[3], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-5_0_4[3]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050403u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_4[4], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-5_0_4[4]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050404u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_4[4], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_4[5], 0).x;
      debugPrintfEXT("iteration-5_0_4[5]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050405u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_5[0].val;
      debugPrintfEXT("iteration-5_0_5[0]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050500u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_5[1].val;
      debugPrintfEXT("iteration-5_0_5[1]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050501u) ? 0u : 1u);
      ssbo_0_5[1].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_5[2], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-5_0_5[2]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050502u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_5[3], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-5_0_5[3]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050503u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_5[3], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[4], 0).x;
      debugPrintfEXT("iteration-5_0_5[4]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050504u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_5[5], 0).x;
      debugPrintfEXT("iteration-5_0_5[5]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050505u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_5[5], 0, uvec4(readValue, 0, 0, 0));
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[5], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[6]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;
layout (push_constant, std430) uniform PushConstantBlock { uint zero; } pc;

layout (set=0, binding=0) uniform utexture2D sampledImage_0_0[6];
layout (set=0, binding=0, r32ui) uniform uimage2D storageImage_0_0[6];
layout (set=0, binding=0) uniform utextureBuffer uniformTexel_0_0[6];
layout (set=0, binding=0, r32ui) uniform uimageBuffer storageTexel_0_0[6];
layout (set=0, binding=0) uniform uboBlock_0_0 { uint val; } ubo_0_0[6];
layout (set=0, binding=0) buffer sboBlock_0_0 { uint val; } ssbo_0_0[6];
layout (set=0, binding=1) uniform utexture2D sampledImage_0_1[6];
layout (set=0, binding=2, r32ui) uniform uimage2D storageImage_0_2[6];
layout (set=0, binding=2) uniform utextureBuffer uniformTexel_0_2[6];
layout (set=0, binding=2, r32ui) uniform uimageBuffer storageTexel_0_2[6];
layout (set=0, binding=2) uniform uboBlock_0_2 { uint val; } ubo_0_2[6];
layout (set=0, binding=2) buffer sboBlock_0_2 { uint val; } ssbo_0_2[6];
layout (set=0, binding=2) uniform utexture2D sampledImage_0_2[6];
layout (set=0, binding=3, r32ui) uniform uimage2D storageImage_0_3[6];
layout (set=0, binding=4) uniform utextureBuffer uniformTexel_0_4[6];
layout (set=0, binding=4, r32ui) uniform uimageBuffer storageTexel_0_4[6];
layout (set=0, binding=4) uniform uboBlock_0_4 { uint val; } ubo_0_4[6];
layout (set=0, binding=4) buffer sboBlock_0_4 { uint val; } ssbo_0_4[6];
layout (set=0, binding=4) uniform utexture2D sampledImage_0_4[6];
layout (set=0, binding=4, r32ui) uniform uimage2D storageImage_0_4[6];
layout (set=0, binding=5) uniform utextureBuffer uniformTexel_0_5[6];
layout (set=0, binding=6, r32ui) uniform uimageBuffer storageTexel_0_6[6];
layout (set=0, binding=6) uniform uboBlock_0_6 { uint val; } ubo_0_6[6];
layout (set=0, binding=6) buffer sboBlock_0_6 { uint val; } ssbo_0_6[6];
layout (set=0, binding=6) uniform utexture2D sampledImage_0_6[6];
layout (set=0, binding=6, r32ui) uniform uimage2D storageImage_0_6[6];
layout (set=0, binding=6) uniform utextureBuffer uniformTexel_0_6[6];
layout (set=0, binding=7, r32ui) uniform uimageBuffer storageTexel_0_7[6];
layout (set=0, binding=8) uniform uboBlock_0_8 { uint val; } ubo_0_8[6];
layout (set=0, binding=8) buffer sboBlock_0_8 { uint val; } ssbo_0_8[6];
layout (set=0, binding=8) uniform utexture2D sampledImage_0_8[6];
layout (set=0, binding=8, r32ui) uniform uimage2D storageImage_0_8[6];
layout (set=0, binding=8) uniform utextureBuffer uniformTexel_0_8[6];
layout (set=0, binding=8, r32ui) uniform uimageBuffer storageTexel_0_8[6];
layout (set=0, binding=9) uniform uboBlock_0_9 { uint val; } ubo_0_9[6];
layout (set=0, binding=10) buffer sboBlock_0_10 { uint val; } ssbo_0_10[6];
layout (set=0, binding=10) uniform utexture2D sampledImage_0_10[6];
layout (set=0, binding=10, r32ui) uniform uimage2D storageImage_0_10[6];
layout (set=0, binding=10) uniform utextureBuffer uniformTexel_0_10[6];
layout (set=0, binding=10, r32ui) uniform uimageBuffer storageTexel_0_10[6];
layout (set=0, binding=10) uniform uboBlock_0_10 { uint val; } ubo_0_10[6];
layout (set=0, binding=11) buffer sboBlock_0_11 { uint val; } ssbo_0_11[6];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(usampler2D(sampledImage_0_0[0 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_0[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_0[1 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-0_0_0[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000001u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0[1 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_0[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_0[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000002u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_0[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_0[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000003u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0[3 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_0[4 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_0[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000004u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_0[5 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_0[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000005u) ? 0u : 1u);
      ssbo_0_0[5 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[0 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_1[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000100u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[1 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_1[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000101u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[2 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_1[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000102u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[3 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_1[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000103u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[4 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_1[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000104u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[5 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_1[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000105u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_2[0 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-0_0_2[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000200u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_2[0 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_2[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_2[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000201u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_2[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_2[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000202u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_2[2 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_2[3 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_2[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000203u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_2[4 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_2[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000204u) ? 0u : 1u);
      ssbo_0_2[4 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_2[5 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_2[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000205u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_3[0 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-0_0_3[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000300u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[0 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[1 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-0_0_3[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000301u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[1 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[2 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-0_0_3[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000302u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[2 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[3 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-0_0_3[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000303u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[3 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[4 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-0_0_3[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000304u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[4 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[5 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-0_0_3[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000305u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[5 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_4[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_4[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000400u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_4[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_4[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000401u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_4[1 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_4[2 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_4[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000402u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_4[3 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_4[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000403u) ? 0u : 1u);
      ssbo_0_4[3 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_4[4 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_4[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000404u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_4[5 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-0_0_4[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000405u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_4[5 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_5[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000500u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_5[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000501u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_5[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000502u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_5[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000503u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_5[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000504u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_5[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000505u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_6[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_6[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000600u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_6[0 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_6[1 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_6[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000601u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_6[2 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_6[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000602u) ? 0u : 1u);
      ssbo_0_6[2 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_6[3 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_6[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000603u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_6[4 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-0_0_6[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000604u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_6[4 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_6[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_6[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000605u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_7[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000700u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[0 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_7[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000701u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[1 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_7[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000702u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[2 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_7[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000703u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[3 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_7[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000704u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[4 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_7[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000705u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[5 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_8[0 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_8[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000800u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_8[1 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_8[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000801u) ? 0u : 1u);
      ssbo_0_8[1 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_8[2 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_8[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000802u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_8[3 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-0_0_8[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000803u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_8[3 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_8[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_8[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000804u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_8[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_8[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000805u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_8[5 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_9[0 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_9[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000900u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[1 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_9[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000901u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[2 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_9[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000902u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[3 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_9[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000903u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[4 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_9[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000904u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[5 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_9[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000905u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_10[0 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_10[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000a00u) ? 0u : 1u);
      ssbo_0_10[0 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_10[1 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_10[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000a01u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_10[2 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-0_0_10[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000a02u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_10[2 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_10[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_10[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000a03u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_10[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_10[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000a04u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_10[4 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_10[5 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_10[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000a05u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_11[0 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_11[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000b00u) ? 0u : 1u);
      ssbo_0_11[0 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[1 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_11[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000b01u) ? 0u : 1u);
      ssbo_0_11[1 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[2 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_11[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000b02u) ? 0u : 1u);
      ssbo_0_11[2 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[3 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_11[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000b03u) ? 0u : 1u);
      ssbo_0_11[3 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[4 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_11[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000b04u) ? 0u : 1u);
      ssbo_0_11[4 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[5 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_11[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000b05u) ? 0u : 1u);
      ssbo_0_11[5 + pc.zero].val = (readValue | 0xff000000u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[6]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;
layout (push_constant, std430) uniform PushConstantBlock { uint zero; } pc;

layout (set=0, binding=0, r32ui) uniform uimage2D storageImage_0_0[6];
layout (set=0, binding=0) uniform utextureBuffer uniformTexel_0_0[6];
layout (set=0, binding=0, r32ui) uniform uimageBuffer storageTexel_0_0[6];
layout (set=0, binding=0) uniform uboBlock_0_0 { uint val; } ubo_0_0[6];
layout (set=0, binding=0) buffer sboBlock_0_0 { uint val; } ssbo_0_0[6];
layout (set=0, binding=0) uniform utexture2D sampledImage_0_0[6];
layout (set=0, binding=1) uniform utexture2D sampledImage_0_1[6];
layout (set=0, binding=2) uniform utextureBuffer uniformTexel_0_2[6];
layout (set=0, binding=2, r32ui) uniform uimageBuffer storageTexel_0_2[6];
layout (set=0, binding=2) uniform uboBlock_0_2 { uint val; } ubo_0_2[6];
layout (set=0, binding=2) buffer sboBlock_0_2 { uint val; } ssbo_0_2[6];
layout (set=0, binding=2) uniform utexture2D sampledImage_0_2[6];
layout (set=0, binding=2, r32ui) uniform uimage2D storageImage_0_2[6];
layout (set=0, binding=3, r32ui) uniform uimage2D storageImage_0_3[6];
layout (set=0, binding=4, r32ui) uniform uimageBuffer storageTexel_0_4[6];
layout (set=0, binding=4) uniform uboBlock_0_4 { uint val; } ubo_0_4[6];
layout (set=0, binding=4) buffer sboBlock_0_4 { uint val; } ssbo_0_4[6];
layout (set=0, binding=4) uniform utexture2D sampledImage_0_4[6];
layout (set=0, binding=4, r32ui) uniform uimage2D storageImage_0_4[6];
layout (set=0, binding=4) uniform utextureBuffer uniformTexel_0_4[6];
layout (set=0, binding=5) uniform utextureBuffer uniformTexel_0_5[6];
layout (set=0, binding=6) uniform uboBlock_0_6 { uint val; } ubo_0_6[6];
layout (set=0, binding=6) buffer sboBlock_0_6 { uint val; } ssbo_0_6[6];
layout (set=0, binding=6) uniform utexture2D sampledImage_0_6[6];
layout (set=0, binding=6, r32ui) uniform uimage2D storageImage_0_6[6];
layout (set=0, binding=6) uniform utextureBuffer uniformTexel_0_6[6];
layout (set=0, binding=6, r32ui) uniform uimageBuffer storageTexel_0_6[6];
layout (set=0, binding=7, r32ui) uniform uimageBuffer storageTexel_0_7[6];
layout (set=0, binding=8) buffer sboBlock_0_8 { uint val; } ssbo_0_8[6];
layout (set=0, binding=8) uniform utexture2D sampledImage_0_8[6];
layout (set=0, binding=8, r32ui) uniform uimage2D storageImage_0_8[6];
layout (set=0, binding=8) uniform utextureBuffer uniformTexel_0_8[6];
layout (set=0, binding=8, r32ui) uniform uimageBuffer storageTexel_0_8[6];
layout (set=0, binding=8) uniform uboBlock_0_8 { uint val; } ubo_0_8[6];
layout (set=0, binding=9) uniform uboBlock_0_9 { uint val; } ubo_0_9[6];
layout (set=0, binding=10) uniform utexture2D sampledImage_0_10[6];
layout (set=0, binding=10, r32ui) uniform uimage2D storageImage_0_10[6];
layout (set=0, binding=10) uniform utextureBuffer uniformTexel_0_10[6];
layout (set=0, binding=10, r32ui) uniform uimageBuffer storageTexel_0_10[6];
layout (set=0, binding=10) uniform uboBlock_0_10 { uint val; } ubo_0_10[6];
layout (set=0, binding=10) buffer sboBlock_0_10 { uint val; } ssbo_0_10[6];
layout (set=0, binding=11) buffer sboBlock_0_11 { uint val; } ssbo_0_11[6];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageImage_0_0[0 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_0[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0[0 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_0[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_0[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010001u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_0[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_0[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010002u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0[2 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_0[3 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_0[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010003u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_0[4 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_0[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010004u) ? 0u : 1u);
      ssbo_0_0[4 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_0[5 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_0[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010005u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[0 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_1[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010100u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[1 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_1[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010101u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[2 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_1[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010102u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[3 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_1[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010103u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[4 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_1[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010104u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[5 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_1[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010105u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_2[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_2[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010200u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_2[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_2[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010201u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_2[1 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_2[2 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_2[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010202u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_2[3 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_2[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010203u) ? 0u : 1u);
      ssbo_0_2[3 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_2[4 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_2[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010204u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_2[5 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_2[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010205u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_2[5 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[0 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_3[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010300u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[0 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[1 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_3[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010301u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[1 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[2 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_3[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010302u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[2 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[3 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_3[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010303u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[3 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[4 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_3[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010304u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[4 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[5 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_3[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010305u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[5 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_4[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_4[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010400u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_4[0 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_4[1 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_4[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010401u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_4[2 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_4[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010402u) ? 0u : 1u);
      ssbo_0_4[2 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_4[3 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_4[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010403u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_4[4 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_4[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010404u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_4[4 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_4[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_4[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010405u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_5[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010500u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_5[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010501u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_5[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010502u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_5[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010503u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_5[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010504u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_5[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010505u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_6[0 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_6[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010600u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_6[1 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_6[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010601u) ? 0u : 1u);
      ssbo_0_6[1 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_6[2 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_6[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010602u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_6[3 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_6[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010603u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_6[3 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_6[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_6[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010604u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_6[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_6[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010605u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_6[5 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_7[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010700u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[0 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_7[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010701u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[1 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_7[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010702u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[2 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_7[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010703u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[3 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_7[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010704u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[4 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_7[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010705u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[5 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ssbo_0_8[0 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_8[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010800u) ? 0u : 1u);
      ssbo_0_8[0 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_8[1 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_8[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010801u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_8[2 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_8[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010802u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_8[2 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_8[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_8[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010803u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_8[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_8[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010804u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_8[4 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_8[5 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_8[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010805u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[0 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_9[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010900u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[1 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_9[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010901u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[2 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_9[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010902u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[3 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_9[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010903u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[4 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_9[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010904u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[5 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_9[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010905u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_10[0 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_10[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010a00u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_10[1 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_10[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010a01u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_10[1 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_10[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_10[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010a02u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_10[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_10[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010a03u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_10[3 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_10[4 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_10[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010a04u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_10[5 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_10[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010a05u) ? 0u : 1u);
      ssbo_0_10[5 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[0 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_11[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010b00u) ? 0u : 1u);
      ssbo_0_11[0 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[1 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_11[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010b01u) ? 0u : 1u);
      ssbo_0_11[1 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[2 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_11[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010b02u) ? 0u : 1u);
      ssbo_0_11[2 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[3 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_11[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010b03u) ? 0u : 1u);
      ssbo_0_11[3 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[4 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_11[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010b04u) ? 0u : 1u);
      ssbo_0_11[4 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[5 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_11[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010b05u) ? 0u : 1u);
      ssbo_0_11[5 + pc.zero].val = (readValue | 0xff000000u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[6]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;
layout (push_constant, std430) uniform PushConstantBlock { uint zero; } pc;

layout (set=0, binding=0) uniform utextureBuffer uniformTexel_0_0[6];
layout (set=0, binding=0, r32ui) uniform uimageBuffer storageTexel_0_0[6];
layout (set=0, binding=0) uniform uboBlock_0_0 { uint val; } ubo_0_0[6];
layout (set=0, binding=0) buffer sboBlock_0_0 { uint val; } ssbo_0_0[6];
layout (set=0, binding=0) uniform utexture2D sampledImage_0_0[6];
layout (set=0, binding=0, r32ui) uniform uimage2D storageImage_0_0[6];
layout (set=0, binding=1) uniform utexture2D sampledImage_0_1[6];
layout (set=0, binding=2, r32ui) uniform uimageBuffer storageTexel_0_2[6];
layout (set=0, binding=2) uniform uboBlock_0_2 { uint val; } ubo_0_2[6];
layout (set=0, binding=2) buffer sboBlock_0_2 { uint val; } ssbo_0_2[6];
layout (set=0, binding=2) uniform utexture2D sampledImage_0_2[6];
layout (set=0, binding=2, r32ui) uniform uimage2D storageImage_0_2[6];
layout (set=0, binding=2) uniform utextureBuffer uniformTexel_0_2[6];
layout (set=0, binding=3, r32ui) uniform uimage2D storageImage_0_3[6];
layout (set=0, binding=4) uniform uboBlock_0_4 { uint val; } ubo_0_4[6];
layout (set=0, binding=4) buffer sboBlock_0_4 { uint val; } ssbo_0_4[6];
layout (set=0, binding=4) uniform utexture2D sampledImage_0_4[6];
layout (set=0, binding=4, r32ui) uniform uimage2D storageImage_0_4[6];
layout (set=0, binding=4) uniform utextureBuffer uniformTexel_0_4[6];
layout (set=0, binding=4, r32ui) uniform uimageBuffer storageTexel_0_4[6];
layout (set=0, binding=5) uniform utextureBuffer uniformTexel_0_5[6];
layout (set=0, binding=6) buffer sboBlock_0_6 { uint val; } ssbo_0_6[6];
layout (set=0, binding=6) uniform utexture2D sampledImage_0_6[6];
layout (set=0, binding=6, r32ui) uniform uimage2D storageImage_0_6[6];
layout (set=0, binding=6) uniform utextureBuffer uniformTexel_0_6[6];
layout (set=0, binding=6, r32ui) uniform uimageBuffer storageTexel_0_6[6];
layout (set=0, binding=6) uniform uboBlock_0_6 { uint val; } ubo_0_6[6];
layout (set=0, binding=7, r32ui) uniform uimageBuffer storageTexel_0_7[6];
layout (set=0, binding=8) uniform utexture2D sampledImage_0_8[6];
layout (set=0, binding=8, r32ui) uniform uimage2D storageImage_0_8[6];
layout (set=0, binding=8) uniform utextureBuffer uniformTexel_0_8[6];
layout (set=0, binding=8, r32ui) uniform uimageBuffer storageTexel_0_8[6];
layout (set=0, binding=8) uniform uboBlock_0_8 { uint val; } ubo_0_8[6];
layout (set=0, binding=8) buffer sboBlock_0_8 { uint val; } ssbo_0_8[6];
layout (set=0, binding=9) uniform uboBlock_0_9 { uint val; } ubo_0_9[6];
layout (set=0, binding=10, r32ui) uniform uimage2D storageImage_0_10[6];
layout (set=0, binding=10) uniform utextureBuffer uniformTexel_0_10[6];
layout (set=0, binding=10, r32ui) uniform uimageBuffer storageTexel_0_10[6];
layout (set=0, binding=10) uniform uboBlock_0_10 { uint val; } ubo_0_10[6];
layout (set=0, binding=10) buffer sboBlock_0_10 { uint val; } ssbo_0_10[6];
layout (set=0, binding=10) uniform utexture2D sampledImage_0_10[6];
layout (set=0, binding=11) buffer sboBlock_0_11 { uint val; } ssbo_0_11[6];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[2], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texelFetch(uniformTexel_0_0[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_0[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020000u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_0[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_0[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020001u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0[1 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_0[2 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_0[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020002u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_0[3 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_0[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020003u) ? 0u : 1u);
      ssbo_0_0[3 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_0[4 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-2_0_0[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020004u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_0[5 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-2_0_0[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020005u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0[5 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[0 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-2_0_1[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020100u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[1 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-2_0_1[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020101u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[2 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-2_0_1[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020102u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[3 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-2_0_1[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020103u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[4 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-2_0_1[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020104u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[5 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-2_0_1[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020105u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_2[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_2[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020200u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_2[0 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_2[1 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_2[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020201u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_2[2 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_2[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020202u) ? 0u : 1u);
      ssbo_0_2[2 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_2[3 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-2_0_2[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020203u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_2[4 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-2_0_2[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020204u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_2[4 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_2[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_2[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020205u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_3[0 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-2_0_3[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020300u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[0 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[1 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-2_0_3[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020301u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[1 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[2 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-2_0_3[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020302u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[2 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[3 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-2_0_3[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020303u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[3 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[4 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-2_0_3[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020304u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[4 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[5 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-2_0_3[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020305u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[5 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_4[0 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_4[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020400u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_4[1 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_4[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020401u) ? 0u : 1u);
      ssbo_0_4[1 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_4[2 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-2_0_4[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020402u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_4[3 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-2_0_4[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020403u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_4[3 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_4[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_4[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020404u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_4[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_4[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020405u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_4[5 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_5[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020500u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_5[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020501u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_5[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020502u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_5[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020503u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_5[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020504u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_5[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020505u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_6[0 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_6[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020600u) ? 0u : 1u);
      ssbo_0_6[0 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_6[1 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-2_0_6[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020601u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_6[2 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-2_0_6[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020602u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_6[2 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_6[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_6[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020603u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_6[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_6[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020604u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_6[4 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_6[5 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_6[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020605u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_7[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020700u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[0 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_7[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020701u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[1 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_7[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020702u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[2 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_7[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020703u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[3 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_7[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020704u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[4 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_7[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020705u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[5 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_8[0 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-2_0_8[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020800u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_8[1 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-2_0_8[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020801u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_8[1 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_8[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_8[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020802u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_8[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_8[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020803u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_8[3 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_8[4 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_8[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020804u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_8[5 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_8[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020805u) ? 0u : 1u);
      ssbo_0_8[5 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ubo_0_9[0 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_9[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020900u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[1 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_9[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020901u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[2 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_9[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020902u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[3 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_9[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020903u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[4 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_9[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020904u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[5 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_9[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020905u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_10[0 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-2_0_10[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020a00u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_10[0 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_10[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_10[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020a01u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_10[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_10[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020a02u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_10[2 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_10[3 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_10[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020a03u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_10[4 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_10[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020a04u) ? 0u : 1u);
      ssbo_0_10[4 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_10[5 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-2_0_10[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020a05u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_11[0 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_11[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020b00u) ? 0u : 1u);
      ssbo_0_11[0 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[1 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_11[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020b01u) ? 0u : 1u);
      ssbo_0_11[1 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[2 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_11[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020b02u) ? 0u : 1u);
      ssbo_0_11[2 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[3 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_11[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020b03u) ? 0u : 1u);
      ssbo_0_11[3 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[4 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_11[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020b04u) ? 0u : 1u);
      ssbo_0_11[4 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[5 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_11[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020b05u) ? 0u : 1u);
      ssbo_0_11[5 + pc.zero].val = (readValue | 0xff000000u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[2], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[6]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;
layout (push_constant, std430) uniform PushConstantBlock { uint zero; } pc;

layout (set=0, binding=0, r32ui) uniform uimageBuffer storageTexel_0_0[6];
layout (set=0, binding=0) uniform uboBlock_0_0 { uint val; } ubo_0_0[6];
layout (set=0, binding=0) buffer sboBlock_0_0 { uint val; } ssbo_0_0[6];
layout (set=0, binding=0) uniform utexture2D sampledImage_0_0[6];
layout (set=0, binding=0, r32ui) uniform uimage2D storageImage_0_0[6];
layout (set=0, binding=0) uniform utextureBuffer uniformTexel_0_0[6];
layout (set=0, binding=1) uniform utexture2D sampledImage_0_1[6];
layout (set=0, binding=2) uniform uboBlock_0_2 { uint val; } ubo_0_2[6];
layout (set=0, binding=2) buffer sboBlock_0_2 { uint val; } ssbo_0_2[6];
layout (set=0, binding=2) uniform utexture2D sampledImage_0_2[6];
layout (set=0, binding=2, r32ui) uniform uimage2D storageImage_0_2[6];
layout (set=0, binding=2) uniform utextureBuffer uniformTexel_0_2[6];
layout (set=0, binding=2, r32ui) uniform uimageBuffer storageTexel_0_2[6];
layout (set=0, binding=3, r32ui) uniform uimage2D storageImage_0_3[6];
layout (set=0, binding=4) buffer sboBlock_0_4 { uint val; } ssbo_0_4[6];
layout (set=0, binding=4) uniform utexture2D sampledImage_0_4[6];
layout (set=0, binding=4, r32ui) uniform uimage2D storageImage_0_4[6];
layout (set=0, binding=4) uniform utextureBuffer uniformTexel_0_4[6];
layout (set=0, binding=4, r32ui) uniform uimageBuffer storageTexel_0_4[6];
layout (set=0, binding=4) uniform uboBlock_0_4 { uint val; } ubo_0_4[6];
layout (set=0, binding=5) uniform utextureBuffer uniformTexel_0_5[6];
layout (set=0, binding=6) uniform utexture2D sampledImage_0_6[6];
layout (set=0, binding=6, r32ui) uniform uimage2D storageImage_0_6[6];
layout (set=0, binding=6) uniform utextureBuffer uniformTexel_0_6[6];
layout (set=0, binding=6, r32ui) uniform uimageBuffer storageTexel_0_6[6];
layout (set=0, binding=6) uniform uboBlock_0_6 { uint val; } ubo_0_6[6];
layout (set=0, binding=6) buffer sboBlock_0_6 { uint val; } ssbo_0_6[6];
layout (set=0, binding=7, r32ui) uniform uimageBuffer storageTexel_0_7[6];
layout (set=0, binding=8, r32ui) uniform uimage2D storageImage_0_8[6];
layout (set=0, binding=8) uniform utextureBuffer uniformTexel_0_8[6];
layout (set=0, binding=8, r32ui) uniform uimageBuffer storageTexel_0_8[6];
layout (set=0, binding=8) uniform uboBlock_0_8 { uint val; } ubo_0_8[6];
layout (set=0, binding=8) buffer sboBlock_0_8 { uint val; } ssbo_0_8[6];
layout (set=0, binding=8) uniform utexture2D sampledImage_0_8[6];
layout (set=0, binding=9) uniform uboBlock_0_9 { uint val; } ubo_0_9[6];
layout (set=0, binding=10) uniform utextureBuffer uniformTexel_0_10[6];
layout (set=0, binding=10, r32ui) uniform uimageBuffer storageTexel_0_10[6];
layout (set=0, binding=10) uniform uboBlock_0_10 { uint val; } ubo_0_10[6];
layout (set=0, binding=10) buffer sboBlock_0_10 { uint val; } ssbo_0_10[6];
layout (set=0, binding=10) uniform utexture2D sampledImage_0_10[6];
layout (set=0, binding=10, r32ui) uniform uimage2D storageImage_0_10[6];
layout (set=0, binding=11) buffer sboBlock_0_11 { uint val; } ssbo_0_11[6];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[3], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageTexel_0_0[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_0[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0[0 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_0[1 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_0[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030001u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_0[2 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_0[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030002u) ? 0u : 1u);
      ssbo_0_0[2 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_0[3 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-3_0_0[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030003u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_0[4 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-3_0_0[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030004u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0[4 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_0[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_0[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030005u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[0 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-3_0_1[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030100u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[1 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-3_0_1[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030101u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[2 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-3_0_1[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030102u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[3 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-3_0_1[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030103u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[4 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-3_0_1[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030104u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[5 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-3_0_1[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030105u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_2[0 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_2[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030200u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_2[1 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_2[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030201u) ? 0u : 1u);
      ssbo_0_2[1 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_2[2 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-3_0_2[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030202u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_2[3 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-3_0_2[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030203u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_2[3 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_2[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_2[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030204u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_2[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_2[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030205u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_2[5 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[0 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-3_0_3[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030300u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[0 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[1 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-3_0_3[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030301u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[1 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[2 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-3_0_3[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030302u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[2 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[3 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-3_0_3[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030303u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[3 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[4 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-3_0_3[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030304u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[4 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[5 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-3_0_3[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030305u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[5 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ssbo_0_4[0 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_4[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030400u) ? 0u : 1u);
      ssbo_0_4[0 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_4[1 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-3_0_4[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030401u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_4[2 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-3_0_4[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030402u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_4[2 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_4[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_4[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030403u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_4[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_4[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030404u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_4[4 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_4[5 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_4[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030405u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_5[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030500u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_5[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030501u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_5[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030502u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_5[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030503u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_5[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030504u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_5[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030505u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_6[0 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-3_0_6[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030600u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_6[1 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-3_0_6[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030601u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_6[1 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_6[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_6[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030602u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_6[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_6[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030603u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_6[3 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_6[4 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_6[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030604u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_6[5 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_6[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030605u) ? 0u : 1u);
      ssbo_0_6[5 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_7[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030700u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[0 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_7[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030701u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[1 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_7[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030702u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[2 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_7[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030703u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[3 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_7[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030704u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[4 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_7[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030705u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[5 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_8[0 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-3_0_8[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030800u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_8[0 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_8[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_8[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030801u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_8[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_8[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030802u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_8[2 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_8[3 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_8[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030803u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_8[4 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_8[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030804u) ? 0u : 1u);
      ssbo_0_8[4 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_8[5 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-3_0_8[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030805u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[0 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_9[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030900u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[1 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_9[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030901u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[2 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_9[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030902u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[3 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_9[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030903u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[4 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_9[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030904u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[5 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_9[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030905u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_10[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_10[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030a00u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_10[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_10[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030a01u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_10[1 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_10[2 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_10[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030a02u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_10[3 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_10[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030a03u) ? 0u : 1u);
      ssbo_0_10[3 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_10[4 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-3_0_10[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030a04u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_10[5 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-3_0_10[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030a05u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_10[5 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ssbo_0_11[0 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_11[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030b00u) ? 0u : 1u);
      ssbo_0_11[0 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[1 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_11[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030b01u) ? 0u : 1u);
      ssbo_0_11[1 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[2 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_11[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030b02u) ? 0u : 1u);
      ssbo_0_11[2 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[3 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_11[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030b03u) ? 0u : 1u);
      ssbo_0_11[3 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[4 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_11[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030b04u) ? 0u : 1u);
      ssbo_0_11[4 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[5 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_11[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030b05u) ? 0u : 1u);
      ssbo_0_11[5 + pc.zero].val = (readValue | 0xff000000u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[3], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[6]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;
layout (push_constant, std430) uniform PushConstantBlock { uint zero; } pc;

layout (set=0, binding=0) uniform uboBlock_0_0 { uint val; } ubo_0_0[6];
layout (set=0, binding=0) buffer sboBlock_0_0 { uint val; } ssbo_0_0[6];
layout (set=0, binding=0) uniform utexture2D sampledImage_0_0[6];
layout (set=0, binding=0, r32ui) uniform uimage2D storageImage_0_0[6];
layout (set=0, binding=0) uniform utextureBuffer uniformTexel_0_0[6];
layout (set=0, binding=0, r32ui) uniform uimageBuffer storageTexel_0_0[6];
layout (set=0, binding=1) uniform utexture2D sampledImage_0_1[6];
layout (set=0, binding=2) buffer sboBlock_0_2 { uint val; } ssbo_0_2[6];
layout (set=0, binding=2) uniform utexture2D sampledImage_0_2[6];
layout (set=0, binding=2, r32ui) uniform uimage2D storageImage_0_2[6];
layout (set=0, binding=2) uniform utextureBuffer uniformTexel_0_2[6];
layout (set=0, binding=2, r32ui) uniform uimageBuffer storageTexel_0_2[6];
layout (set=0, binding=2) uniform uboBlock_0_2 { uint val; } ubo_0_2[6];
layout (set=0, binding=3, r32ui) uniform uimage2D storageImage_0_3[6];
layout (set=0, binding=4) uniform utexture2D sampledImage_0_4[6];
layout (set=0, binding=4, r32ui) uniform uimage2D storageImage_0_4[6];
layout (set=0, binding=4) uniform utextureBuffer uniformTexel_0_4[6];
layout (set=0, binding=4, r32ui) uniform uimageBuffer storageTexel_0_4[6];
layout (set=0, binding=4) uniform uboBlock_0_4 { uint val; } ubo_0_4[6];
layout (set=0, binding=4) buffer sboBlock_0_4 { uint val; } ssbo_0_4[6];
layout (set=0, binding=5) uniform utextureBuffer uniformTexel_0_5[6];
layout (set=0, binding=6, r32ui) uniform uimage2D storageImage_0_6[6];
layout (set=0, binding=6) uniform utextureBuffer uniformTexel_0_6[6];
layout (set=0, binding=6, r32ui) uniform uimageBuffer storageTexel_0_6[6];
layout (set=0, binding=6) uniform uboBlock_0_6 { uint val; } ubo_0_6[6];
layout (set=0, binding=6) buffer sboBlock_0_6 { uint val; } ssbo_0_6[6];
layout (set=0, binding=6) uniform utexture2D sampledImage_0_6[6];
layout (set=0, binding=7, r32ui) uniform uimageBuffer storageTexel_0_7[6];
layout (set=0, binding=8) uniform utextureBuffer uniformTexel_0_8[6];
layout (set=0, binding=8, r32ui) uniform uimageBuffer storageTexel_0_8[6];
layout (set=0, binding=8) uniform uboBlock_0_8 { uint val; } ubo_0_8[6];
layout (set=0, binding=8) buffer sboBlock_0_8 { uint val; } ssbo_0_8[6];
layout (set=0, binding=8) uniform utexture2D sampledImage_0_8[6];
layout (set=0, binding=8, r32ui) uniform uimage2D storageImage_0_8[6];
layout (set=0, binding=9) uniform uboBlock_0_9 { uint val; } ubo_0_9[6];
layout (set=0, binding=10, r32ui) uniform uimageBuffer storageTexel_0_10[6];
layout (set=0, binding=10) uniform uboBlock_0_10 { uint val; } ubo_0_10[6];
layout (set=0, binding=10) buffer sboBlock_0_10 { uint val; } ssbo_0_10[6];
layout (set=0, binding=10) uniform utexture2D sampledImage_0_10[6];
layout (set=0, binding=10, r32ui) uniform uimage2D storageImage_0_10[6];
layout (set=0, binding=10) uniform utextureBuffer uniformTexel_0_10[6];
layout (set=0, binding=11) buffer sboBlock_0_11 { uint val; } ssbo_0_11[6];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[4], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ubo_0_0[0 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_0[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040000u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_0[1 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_0[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040001u) ? 0u : 1u);
      ssbo_0_0[1 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_0[2 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-4_0_0[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040002u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_0[3 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-4_0_0[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040003u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0[3 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_0[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_0[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040004u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_0[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_0[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040005u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0[5 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[0 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-4_0_1[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040100u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[1 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-4_0_1[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040101u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[2 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-4_0_1[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040102u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[3 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-4_0_1[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040103u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[4 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-4_0_1[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040104u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[5 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-4_0_1[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040105u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_2[0 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_2[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040200u) ? 0u : 1u);
      ssbo_0_2[0 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_2[1 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-4_0_2[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040201u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_2[2 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-4_0_2[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040202u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_2[2 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_2[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_2[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040203u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_2[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_2[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040204u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_2[4 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_2[5 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_2[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040205u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_3[0 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-4_0_3[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040300u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[0 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[1 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-4_0_3[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040301u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[1 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[2 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-4_0_3[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040302u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[2 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[3 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-4_0_3[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040303u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[3 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[4 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-4_0_3[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040304u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[4 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[5 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-4_0_3[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040305u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[5 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_4[0 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-4_0_4[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040400u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_4[1 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-4_0_4[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040401u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_4[1 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_4[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_4[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040402u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_4[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_4[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040403u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_4[3 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_4[4 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_4[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040404u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_4[5 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_4[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040405u) ? 0u : 1u);
      ssbo_0_4[5 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_5[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040500u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_5[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040501u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_5[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040502u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_5[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040503u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_5[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040504u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_5[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040505u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_6[0 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-4_0_6[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040600u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_6[0 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_6[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_6[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040601u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_6[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_6[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040602u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_6[2 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_6[3 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_6[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040603u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_6[4 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_6[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040604u) ? 0u : 1u);
      ssbo_0_6[4 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_6[5 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-4_0_6[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040605u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_7[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040700u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[0 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_7[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040701u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[1 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_7[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040702u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[2 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_7[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040703u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[3 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_7[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040704u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[4 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_7[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040705u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[5 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_8[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_8[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040800u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_8[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_8[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040801u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_8[1 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_8[2 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_8[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040802u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_8[3 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_8[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040803u) ? 0u : 1u);
      ssbo_0_8[3 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_8[4 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-4_0_8[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040804u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_8[5 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-4_0_8[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040805u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_8[5 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_9[0 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_9[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040900u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[1 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_9[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040901u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[2 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_9[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040902u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[3 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_9[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040903u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[4 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_9[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040904u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[5 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_9[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040905u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_10[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_10[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040a00u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_10[0 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_10[1 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_10[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040a01u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_10[2 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_10[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040a02u) ? 0u : 1u);
      ssbo_0_10[2 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_10[3 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-4_0_10[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040a03u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_10[4 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-4_0_10[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040a04u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_10[4 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_10[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_10[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040a05u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_11[0 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_11[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040b00u) ? 0u : 1u);
      ssbo_0_11[0 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[1 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_11[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040b01u) ? 0u : 1u);
      ssbo_0_11[1 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[2 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_11[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040b02u) ? 0u : 1u);
      ssbo_0_11[2 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[3 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_11[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040b03u) ? 0u : 1u);
      ssbo_0_11[3 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[4 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_11[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040b04u) ? 0u : 1u);
      ssbo_0_11[4 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[5 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_11[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040b05u) ? 0u : 1u);
      ssbo_0_11[5 + pc.zero].val = (readValue | 0xff000000u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[4], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[6]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;
layout (push_constant, std430) uniform PushConstantBlock { uint zero; } pc;

layout (set=0, binding=0) buffer sboBlock_0_0 { uint val; } ssbo_0_0[6];
layout (set=0, binding=0) uniform utexture2D sampledImage_0_0[6];
layout (set=0, binding=0, r32ui) uniform uimage2D storageImage_0_0[6];
layout (set=0, binding=0) uniform utextureBuffer uniformTexel_0_0[6];
layout (set=0, binding=0, r32ui) uniform uimageBuffer storageTexel_0_0[6];
layout (set=0, binding=0) uniform uboBlock_0_0 { uint val; } ubo_0_0[6];
layout (set=0, binding=1) uniform utexture2D sampledImage_0_1[6];
layout (set=0, binding=2) uniform utexture2D sampledImage_0_2[6];
layout (set=0, binding=2, r32ui) uniform uimage2D storageImage_0_2[6];
layout (set=0, binding=2) uniform utextureBuffer uniformTexel_0_2[6];
layout (set=0, binding=2, r32ui) uniform uimageBuffer storageTexel_0_2[6];
layout (set=0, binding=2) uniform uboBlock_0_2 { uint val; } ubo_0_2[6];
layout (set=0, binding=2) buffer sboBlock_0_2 { uint val; } ssbo_0_2[6];
layout (set=0, binding=3, r32ui) uniform uimage2D storageImage_0_3[6];
layout (set=0, binding=4, r32ui) uniform uimage2D storageImage_0_4[6];
layout (set=0, binding=4) uniform utextureBuffer uniformTexel_0_4[6];
layout (set=0, binding=4, r32ui) uniform uimageBuffer storageTexel_0_4[6];
layout (set=0, binding=4) uniform uboBlock_0_4 { uint val; } ubo_0_4[6];
layout (set=0, binding=4) buffer sboBlock_0_4 { uint val; } ssbo_0_4[6];
layout (set=0, binding=4) uniform utexture2D sampledImage_0_4[6];
layout (set=0, binding=5) uniform utextureBuffer uniformTexel_0_5[6];
layout (set=0, binding=6) uniform utextureBuffer uniformTexel_0_6[6];
layout (set=0, binding=6, r32ui) uniform uimageBuffer storageTexel_0_6[6];
layout (set=0, binding=6) uniform uboBlock_0_6 { uint val; } ubo_0_6[6];
layout (set=0, binding=6) buffer sboBlock_0_6 { uint val; } ssbo_0_6[6];
layout (set=0, binding=6) uniform utexture2D sampledImage_0_6[6];
layout (set=0, binding=6, r32ui) uniform uimage2D storageImage_0_6[6];
layout (set=0, binding=7, r32ui) uniform uimageBuffer storageTexel_0_7[6];
layout (set=0, binding=8, r32ui) uniform uimageBuffer storageTexel_0_8[6];
layout (set=0, binding=8) uniform uboBlock_0_8 { uint val; } ubo_0_8[6];
layout (set=0, binding=8) buffer sboBlock_0_8 { uint val; } ssbo_0_8[6];
layout (set=0, binding=8) uniform utexture2D sampledImage_0_8[6];
layout (set=0, binding=8, r32ui) uniform uimage2D storageImage_0_8[6];
layout (set=0, binding=8) uniform utextureBuffer uniformTexel_0_8[6];
layout (set=0, binding=9) uniform uboBlock_0_9 { uint val; } ubo_0_9[6];
layout (set=0, binding=10) uniform uboBlock_0_10 { uint val; } ubo_0_10[6];
layout (set=0, binding=10) buffer sboBlock_0_10 { uint val; } ssbo_0_10[6];
layout (set=0, binding=10) uniform utexture2D sampledImage_0_10[6];
layout (set=0, binding=10, r32ui) uniform uimage2D storageImage_0_10[6];
layout (set=0, binding=10) uniform utextureBuffer uniformTexel_0_10[6];
layout (set=0, binding=10, r32ui) uniform uimageBuffer storageTexel_0_10[6];
layout (set=0, binding=11) buffer sboBlock_0_11 { uint val; } ssbo_0_11[6];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[5], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ssbo_0_0[0 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_0[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050000u) ? 0u : 1u);
      ssbo_0_0[0 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_0[1 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-5_0_0[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050001u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_0[2 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-5_0_0[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050002u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0[2 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_0[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_0[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050003u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_0[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_0[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050004u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0[4 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_0[5 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_0[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050005u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[0 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-5_0_1[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050100u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[1 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-5_0_1[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050101u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[2 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-5_0_1[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050102u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[3 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-5_0_1[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050103u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[4 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-5_0_1[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050104u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[5 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-5_0_1[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050105u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_2[0 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-5_0_2[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050200u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_2[1 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-5_0_2[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050201u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_2[1 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_2[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_2[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050202u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_2[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_2[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050203u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_2[3 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_2[4 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_2[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050204u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_2[5 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_2[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050205u) ? 0u : 1u);
      ssbo_0_2[5 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = imageLoad(storageImage_0_3[0 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-5_0_3[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050300u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[0 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[1 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-5_0_3[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050301u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[1 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[2 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-5_0_3[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050302u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[2 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[3 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-5_0_3[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050303u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[3 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[4 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-5_0_3[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050304u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[4 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[5 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-5_0_3[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050305u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[5 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_4[0 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-5_0_4[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050400u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_4[0 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_4[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_4[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050401u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_4[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_4[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050402u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_4[2 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_4[3 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_4[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050403u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_4[4 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_4[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050404u) ? 0u : 1u);
      ssbo_0_4[4 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_4[5 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-5_0_4[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050405u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_5[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050500u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_5[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050501u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_5[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050502u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_5[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050503u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_5[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050504u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_5[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050505u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_6[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_6[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050600u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_6[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_6[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050601u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_6[1 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_6[2 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_6[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050602u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_6[3 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_6[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050603u) ? 0u : 1u);
      ssbo_0_6[3 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_6[4 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-5_0_6[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050604u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_6[5 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-5_0_6[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050605u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_6[5 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_7[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050700u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[0 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_7[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050701u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[1 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_7[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050702u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[2 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_7[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050703u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[3 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_7[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050704u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[4 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_7[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050705u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[5 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_8[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_8[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050800u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_8[0 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_8[1 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_8[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050801u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_8[2 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_8[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050802u) ? 0u : 1u);
      ssbo_0_8[2 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_8[3 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-5_0_8[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050803u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_8[4 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-5_0_8[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050804u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_8[4 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_8[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_8[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050805u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[0 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_9[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050900u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[1 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_9[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050901u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[2 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_9[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050902u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[3 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_9[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050903u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[4 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_9[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050904u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[5 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_9[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050905u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_10[0 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_10[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050a00u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_10[1 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_10[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050a01u) ? 0u : 1u);
      ssbo_0_10[1 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_10[2 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-5_0_10[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050a02u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_10[3 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-5_0_10[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050a03u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_10[3 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_10[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_10[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050a04u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_10[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_10[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050a05u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_10[5 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ssbo_0_11[0 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_11[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050b00u) ? 0u : 1u);
      ssbo_0_11[0 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[1 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_11[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050b01u) ? 0u : 1u);
      ssbo_0_11[1 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[2 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_11[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050b02u) ? 0u : 1u);
      ssbo_0_11[2 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[3 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_11[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050b03u) ? 0u : 1u);
      ssbo_0_11[3 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[4 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_11[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050b04u) ? 0u : 1u);
      ssbo_0_11[4 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[5 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_11[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050b05u) ? 0u : 1u);
      ssbo_0_11[5 + pc.zero].val = (readValue | 0xff000000u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[5], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[6]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;
layout (push_constant, std430) uniform PushConstantBlock { uint zero; } pc;

layout (set=0, binding=0) uniform utexture2D sampledImage_0_0[6];
layout (set=0, binding=1) uniform utexture2D sampledImage_0_1[6];
layout (set=0, binding=2, r32ui) uniform uimage2D storageImage_0_2[6];
layout (set=0, binding=3, r32ui) uniform uimage2D storageImage_0_3[6];
layout (set=0, binding=4) uniform utextureBuffer uniformTexel_0_4[6];
layout (set=0, binding=5) uniform utextureBuffer uniformTexel_0_5[6];
layout (set=0, binding=6, r32ui) uniform uimageBuffer storageTexel_0_6[6];
layout (set=0, binding=7, r32ui) uniform uimageBuffer storageTexel_0_7[6];
layout (set=0, binding=8) uniform uboBlock_0_8 { uint val; } ubo_0_8[6];
layout (set=0, binding=9) uniform uboBlock_0_9 { uint val; } ubo_0_9[6];
layout (set=0, binding=10) buffer sboBlock_0_10 { uint val; } ssbo_0_10[6];
layout (set=0, binding=11) buffer sboBlock_0_11 { uint val; } ssbo_0_11[6];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(usampler2D(sampledImage_0_0[0 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_0[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_0[1 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_0[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000001u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_0[2 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_0[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000002u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_0[3 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_0[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000003u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_0[4 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_0[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000004u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_0[5 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_0[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000005u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[0 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_1[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000100u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[1 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_1[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000101u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[2 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_1[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000102u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[3 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_1[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000103u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[4 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_1[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000104u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[5 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_1[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000105u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_2[0 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-0_0_2[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000200u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_2[0 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_2[1 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-0_0_2[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000201u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_2[1 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_2[2 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-0_0_2[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000202u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_2[2 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_2[3 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-0_0_2[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000203u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_2[3 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_2[4 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-0_0_2[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000204u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_2[4 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_2[5 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-0_0_2[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000205u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_2[5 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[0 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-0_0_3[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000300u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[0 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[1 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-0_0_3[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000301u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[1 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[2 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-0_0_3[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000302u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[2 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[3 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-0_0_3[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000303u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[3 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[4 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-0_0_3[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000304u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[4 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[5 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-0_0_3[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000305u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[5 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_4[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_4[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000400u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_4[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_4[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000401u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_4[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_4[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000402u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_4[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_4[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000403u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_4[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_4[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000404u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_4[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_4[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000405u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_5[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000500u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_5[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000501u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_5[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000502u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_5[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000503u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_5[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000504u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_5[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000505u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_6[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_6[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000600u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_6[0 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_6[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_6[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000601u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_6[1 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_6[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_6[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000602u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_6[2 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_6[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_6[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000603u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_6[3 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_6[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_6[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000604u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_6[4 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_6[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_6[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000605u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_6[5 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_7[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000700u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[0 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_7[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000701u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[1 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_7[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000702u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[2 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_7[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000703u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[3 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_7[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000704u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[4 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_7[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000705u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[5 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_8[0 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_8[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000800u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_8[1 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_8[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000801u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_8[2 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_8[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000802u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_8[3 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_8[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000803u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_8[4 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_8[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000804u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_8[5 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_8[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000805u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[0 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_9[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000900u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[1 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_9[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000901u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[2 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_9[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000902u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[3 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_9[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000903u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[4 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_9[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000904u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[5 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_9[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000905u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_10[0 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_10[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000a00u) ? 0u : 1u);
      ssbo_0_10[0 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_10[1 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_10[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000a01u) ? 0u : 1u);
      ssbo_0_10[1 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_10[2 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_10[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000a02u) ? 0u : 1u);
      ssbo_0_10[2 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_10[3 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_10[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000a03u) ? 0u : 1u);
      ssbo_0_10[3 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_10[4 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_10[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000a04u) ? 0u : 1u);
      ssbo_0_10[4 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_10[5 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_10[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000a05u) ? 0u : 1u);
      ssbo_0_10[5 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[0 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_11[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000b00u) ? 0u : 1u);
      ssbo_0_11[0 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[1 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_11[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000b01u) ? 0u : 1u);
      ssbo_0_11[1 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[2 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_11[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000b02u) ? 0u : 1u);
      ssbo_0_11[2 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[3 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_11[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000b03u) ? 0u : 1u);
      ssbo_0_11[3 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[4 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_11[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000b04u) ? 0u : 1u);
      ssbo_0_11[4 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[5 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_11[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000b05u) ? 0u : 1u);
      ssbo_0_11[5 + pc.zero].val = (readValue | 0xff000000u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[6]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;
layout (push_constant, std430) uniform PushConstantBlock { uint zero; } pc;

layout (set=0, binding=0, r32ui) uniform uimage2D storageImage_0_0[6];
layout (set=0, binding=1) uniform utexture2D sampledImage_0_1[6];
layout (set=0, binding=2) uniform utextureBuffer uniformTexel_0_2[6];
layout (set=0, binding=3, r32ui) uniform uimage2D storageImage_0_3[6];
layout (set=0, binding=4, r32ui) uniform uimageBuffer storageTexel_0_4[6];
layout (set=0, binding=5) uniform utextureBuffer uniformTexel_0_5[6];
layout (set=0, binding=6) uniform uboBlock_0_6 { uint val; } ubo_0_6[6];
layout (set=0, binding=7, r32ui) uniform uimageBuffer storageTexel_0_7[6];
layout (set=0, binding=8) buffer sboBlock_0_8 { uint val; } ssbo_0_8[6];
layout (set=0, binding=9) uniform uboBlock_0_9 { uint val; } ubo_0_9[6];
layout (set=0, binding=10) uniform utexture2D sampledImage_0_10[6];
layout (set=0, binding=11) buffer sboBlock_0_11 { uint val; } ssbo_0_11[6];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageImage_0_0[0 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_0[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0[0 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_0[1 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_0[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010001u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0[1 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_0[2 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_0[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010002u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0[2 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_0[3 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_0[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010003u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0[3 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_0[4 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_0[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010004u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0[4 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_0[5 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_0[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010005u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0[5 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[0 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_1[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010100u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[1 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_1[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010101u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[2 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_1[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010102u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[3 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_1[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010103u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[4 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_1[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010104u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[5 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_1[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010105u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_2[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_2[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010200u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_2[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_2[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010201u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_2[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_2[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010202u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_2[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_2[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010203u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_2[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_2[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010204u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_2[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_2[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010205u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_3[0 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_3[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010300u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[0 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[1 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_3[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010301u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[1 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[2 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_3[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010302u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[2 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[3 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_3[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010303u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[3 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[4 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_3[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010304u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[4 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[5 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_3[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010305u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[5 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_4[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_4[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010400u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_4[0 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_4[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_4[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010401u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_4[1 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_4[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_4[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010402u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_4[2 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_4[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_4[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010403u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_4[3 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_4[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_4[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010404u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_4[4 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_4[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_4[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010405u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_4[5 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_5[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010500u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_5[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010501u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_5[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010502u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_5[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010503u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_5[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010504u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_5[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010505u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_6[0 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_6[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010600u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_6[1 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_6[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010601u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_6[2 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_6[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010602u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_6[3 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_6[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010603u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_6[4 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_6[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010604u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_6[5 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_6[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010605u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_7[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010700u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[0 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_7[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010701u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[1 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_7[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010702u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[2 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_7[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010703u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[3 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_7[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010704u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[4 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_7[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010705u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[5 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ssbo_0_8[0 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_8[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010800u) ? 0u : 1u);
      ssbo_0_8[0 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_8[1 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_8[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010801u) ? 0u : 1u);
      ssbo_0_8[1 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_8[2 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_8[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010802u) ? 0u : 1u);
      ssbo_0_8[2 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_8[3 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_8[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010803u) ? 0u : 1u);
      ssbo_0_8[3 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_8[4 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_8[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010804u) ? 0u : 1u);
      ssbo_0_8[4 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_8[5 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_8[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010805u) ? 0u : 1u);
      ssbo_0_8[5 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ubo_0_9[0 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_9[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010900u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[1 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_9[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010901u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[2 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_9[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010902u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[3 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_9[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010903u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[4 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_9[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010904u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[5 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_9[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010905u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_10[0 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_10[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010a00u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_10[1 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_10[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010a01u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_10[2 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_10[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010a02u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_10[3 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_10[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010a03u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_10[4 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_10[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010a04u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_10[5 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_10[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010a05u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_11[0 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_11[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010b00u) ? 0u : 1u);
      ssbo_0_11[0 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[1 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_11[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010b01u) ? 0u : 1u);
      ssbo_0_11[1 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[2 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_11[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010b02u) ? 0u : 1u);
      ssbo_0_11[2 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[3 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_11[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010b03u) ? 0u : 1u);
      ssbo_0_11[3 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[4 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_11[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010b04u) ? 0u : 1u);
      ssbo_0_11[4 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[5 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_11[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010b05u) ? 0u : 1u);
      ssbo_0_11[5 + pc.zero].val = (readValue | 0xff000000u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[6]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;
layout (push_constant, std430) uniform PushConstantBlock { uint zero; } pc;

layout (set=0, binding=0) uniform utextureBuffer uniformTexel_0_0[6];
layout (set=0, binding=1) uniform utexture2D sampledImage_0_1[6];
layout (set=0, binding=2, r32ui) uniform uimageBuffer storageTexel_0_2[6];
layout (set=0, binding=3, r32ui) uniform uimage2D storageImage_0_3[6];
layout (set=0, binding=4) uniform uboBlock_0_4 { uint val; } ubo_0_4[6];
layout (set=0, binding=5) uniform utextureBuffer uniformTexel_0_5[6];
layout (set=0, binding=6) buffer sboBlock_0_6 { uint val; } ssbo_0_6[6];
layout (set=0, binding=7, r32ui) uniform uimageBuffer storageTexel_0_7[6];
layout (set=0, binding=8) uniform utexture2D sampledImage_0_8[6];
layout (set=0, binding=9) uniform uboBlock_0_9 { uint val; } ubo_0_9[6];
layout (set=0, binding=10, r32ui) uniform uimage2D storageImage_0_10[6];
layout (set=0, binding=11) buffer sboBlock_0_11 { uint val; } ssbo_0_11[6];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[2], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texelFetch(uniformTexel_0_0[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_0[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020000u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_0[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_0[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020001u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_0[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_0[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020002u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_0[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_0[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020003u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_0[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_0[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020004u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_0[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_0[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020005u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[0 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-2_0_1[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020100u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[1 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-2_0_1[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020101u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[2 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-2_0_1[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020102u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[3 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-2_0_1[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020103u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[4 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-2_0_1[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020104u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[5 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-2_0_1[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020105u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_2[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_2[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020200u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_2[0 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_2[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_2[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020201u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_2[1 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_2[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_2[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020202u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_2[2 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_2[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_2[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020203u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_2[3 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_2[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_2[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020204u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_2[4 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_2[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_2[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020205u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_2[5 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[0 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-2_0_3[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020300u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[0 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[1 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-2_0_3[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020301u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[1 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[2 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-2_0_3[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020302u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[2 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[3 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-2_0_3[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020303u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[3 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[4 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-2_0_3[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020304u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[4 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[5 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-2_0_3[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020305u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[5 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_4[0 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_4[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020400u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_4[1 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_4[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020401u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_4[2 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_4[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020402u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_4[3 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_4[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020403u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_4[4 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_4[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020404u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_4[5 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_4[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020405u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_5[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020500u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_5[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020501u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_5[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020502u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_5[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020503u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_5[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020504u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_5[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020505u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_6[0 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_6[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020600u) ? 0u : 1u);
      ssbo_0_6[0 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_6[1 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_6[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020601u) ? 0u : 1u);
      ssbo_0_6[1 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_6[2 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_6[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020602u) ? 0u : 1u);
      ssbo_0_6[2 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_6[3 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_6[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020603u) ? 0u : 1u);
      ssbo_0_6[3 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_6[4 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_6[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020604u) ? 0u : 1u);
      ssbo_0_6[4 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_6[5 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_6[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020605u) ? 0u : 1u);
      ssbo_0_6[5 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_7[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020700u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[0 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_7[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020701u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[1 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_7[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020702u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[2 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_7[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020703u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[3 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_7[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020704u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[4 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_7[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020705u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[5 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_8[0 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-2_0_8[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020800u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_8[1 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-2_0_8[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020801u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_8[2 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-2_0_8[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020802u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_8[3 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-2_0_8[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020803u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_8[4 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-2_0_8[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020804u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_8[5 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-2_0_8[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020805u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[0 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_9[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020900u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[1 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_9[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020901u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[2 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_9[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020902u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[3 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_9[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020903u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[4 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_9[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020904u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[5 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_9[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020905u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_10[0 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-2_0_10[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020a00u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_10[0 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_10[1 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-2_0_10[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020a01u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_10[1 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_10[2 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-2_0_10[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020a02u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_10[2 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_10[3 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-2_0_10[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020a03u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_10[3 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_10[4 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-2_0_10[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020a04u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_10[4 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_10[5 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-2_0_10[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020a05u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_10[5 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ssbo_0_11[0 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_11[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020b00u) ? 0u : 1u);
      ssbo_0_11[0 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[1 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_11[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020b01u) ? 0u : 1u);
      ssbo_0_11[1 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[2 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_11[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020b02u) ? 0u : 1u);
      ssbo_0_11[2 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[3 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_11[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020b03u) ? 0u : 1u);
      ssbo_0_11[3 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[4 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_11[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020b04u) ? 0u : 1u);
      ssbo_0_11[4 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[5 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_11[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020b05u) ? 0u : 1u);
      ssbo_0_11[5 + pc.zero].val = (readValue | 0xff000000u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[2], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[6]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;
layout (push_constant, std430) uniform PushConstantBlock { uint zero; } pc;

layout (set=0, binding=0, r32ui) uniform uimageBuffer storageTexel_0_0[6];
layout (set=0, binding=1) uniform utexture2D sampledImage_0_1[6];
layout (set=0, binding=2) uniform uboBlock_0_2 { uint val; } ubo_0_2[6];
layout (set=0, binding=3, r32ui) uniform uimage2D storageImage_0_3[6];
layout (set=0, binding=4) buffer sboBlock_0_4 { uint val; } ssbo_0_4[6];
layout (set=0, binding=5) uniform utextureBuffer uniformTexel_0_5[6];
layout (set=0, binding=6) uniform utexture2D sampledImage_0_6[6];
layout (set=0, binding=7, r32ui) uniform uimageBuffer storageTexel_0_7[6];
layout (set=0, binding=8, r32ui) uniform uimage2D storageImage_0_8[6];
layout (set=0, binding=9) uniform uboBlock_0_9 { uint val; } ubo_0_9[6];
layout (set=0, binding=10) uniform utextureBuffer uniformTexel_0_10[6];
layout (set=0, binding=11) buffer sboBlock_0_11 { uint val; } ssbo_0_11[6];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[3], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageTexel_0_0[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_0[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0[0 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_0[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_0[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030001u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0[1 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_0[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_0[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030002u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0[2 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_0[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_0[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030003u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0[3 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_0[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_0[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030004u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0[4 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_0[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_0[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030005u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0[5 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[0 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-3_0_1[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030100u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[1 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-3_0_1[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030101u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[2 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-3_0_1[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030102u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[3 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-3_0_1[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030103u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[4 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-3_0_1[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030104u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[5 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-3_0_1[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030105u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_2[0 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_2[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030200u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_2[1 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_2[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030201u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_2[2 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_2[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030202u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_2[3 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_2[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030203u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_2[4 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_2[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030204u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_2[5 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_2[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030205u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_3[0 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-3_0_3[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030300u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[0 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[1 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-3_0_3[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030301u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[1 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[2 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-3_0_3[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030302u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[2 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[3 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-3_0_3[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030303u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[3 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[4 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-3_0_3[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030304u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[4 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[5 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-3_0_3[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030305u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[5 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ssbo_0_4[0 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_4[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030400u) ? 0u : 1u);
      ssbo_0_4[0 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_4[1 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_4[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030401u) ? 0u : 1u);
      ssbo_0_4[1 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_4[2 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_4[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030402u) ? 0u : 1u);
      ssbo_0_4[2 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_4[3 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_4[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030403u) ? 0u : 1u);
      ssbo_0_4[3 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_4[4 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_4[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030404u) ? 0u : 1u);
      ssbo_0_4[4 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_4[5 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_4[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030405u) ? 0u : 1u);
      ssbo_0_4[5 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_5[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030500u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_5[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030501u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_5[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030502u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_5[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030503u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_5[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030504u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_5[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030505u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_6[0 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-3_0_6[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030600u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_6[1 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-3_0_6[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030601u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_6[2 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-3_0_6[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030602u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_6[3 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-3_0_6[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030603u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_6[4 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-3_0_6[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030604u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_6[5 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-3_0_6[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030605u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_7[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030700u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[0 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_7[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030701u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[1 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_7[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030702u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[2 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_7[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030703u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[3 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_7[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030704u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[4 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_7[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030705u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[5 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_8[0 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-3_0_8[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030800u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_8[0 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_8[1 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-3_0_8[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030801u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_8[1 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_8[2 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-3_0_8[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030802u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_8[2 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_8[3 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-3_0_8[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030803u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_8[3 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_8[4 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-3_0_8[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030804u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_8[4 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_8[5 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-3_0_8[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030805u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_8[5 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_9[0 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_9[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030900u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[1 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_9[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030901u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[2 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_9[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030902u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[3 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_9[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030903u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[4 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_9[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030904u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[5 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_9[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030905u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_10[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_10[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030a00u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_10[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_10[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030a01u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_10[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_10[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030a02u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_10[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_10[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030a03u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_10[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_10[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030a04u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_10[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_10[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030a05u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_11[0 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_11[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030b00u) ? 0u : 1u);
      ssbo_0_11[0 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[1 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_11[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030b01u) ? 0u : 1u);
      ssbo_0_11[1 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[2 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_11[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030b02u) ? 0u : 1u);
      ssbo_0_11[2 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[3 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_11[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030b03u) ? 0u : 1u);
      ssbo_0_11[3 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[4 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_11[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030b04u) ? 0u : 1u);
      ssbo_0_11[4 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[5 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_11[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030b05u) ? 0u : 1u);
      ssbo_0_11[5 + pc.zero].val = (readValue | 0xff000000u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[3], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[6]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;
layout (push_constant, std430) uniform PushConstantBlock { uint zero; } pc;

layout (set=0, binding=0) uniform uboBlock_0_0 { uint val; } ubo_0_0[6];
layout (set=0, binding=1) uniform utexture2D sampledImage_0_1[6];
layout (set=0, binding=2) buffer sboBlock_0_2 { uint val; } ssbo_0_2[6];
layout (set=0, binding=3, r32ui) uniform uimage2D storageImage_0_3[6];
layout (set=0, binding=4) uniform utexture2D sampledImage_0_4[6];
layout (set=0, binding=5) uniform utextureBuffer uniformTexel_0_5[6];
layout (set=0, binding=6, r32ui) uniform uimage2D storageImage_0_6[6];
layout (set=0, binding=7, r32ui) uniform uimageBuffer storageTexel_0_7[6];
layout (set=0, binding=8) uniform utextureBuffer uniformTexel_0_8[6];
layout (set=0, binding=9) uniform uboBlock_0_9 { uint val; } ubo_0_9[6];
layout (set=0, binding=10, r32ui) uniform uimageBuffer storageTexel_0_10[6];
layout (set=0, binding=11) buffer sboBlock_0_11 { uint val; } ssbo_0_11[6];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[4], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ubo_0_0[0 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_0[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040000u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_0[1 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_0[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040001u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_0[2 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_0[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040002u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_0[3 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_0[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040003u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_0[4 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_0[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040004u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_0[5 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_0[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040005u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[0 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-4_0_1[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040100u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[1 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-4_0_1[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040101u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[2 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-4_0_1[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040102u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[3 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-4_0_1[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040103u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[4 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-4_0_1[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040104u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[5 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-4_0_1[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040105u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_2[0 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_2[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040200u) ? 0u : 1u);
      ssbo_0_2[0 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_2[1 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_2[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040201u) ? 0u : 1u);
      ssbo_0_2[1 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_2[2 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_2[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040202u) ? 0u : 1u);
      ssbo_0_2[2 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_2[3 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_2[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040203u) ? 0u : 1u);
      ssbo_0_2[3 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_2[4 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_2[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040204u) ? 0u : 1u);
      ssbo_0_2[4 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_2[5 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_2[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040205u) ? 0u : 1u);
      ssbo_0_2[5 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = imageLoad(storageImage_0_3[0 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-4_0_3[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040300u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[0 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[1 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-4_0_3[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040301u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[1 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[2 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-4_0_3[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040302u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[2 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[3 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-4_0_3[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040303u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[3 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[4 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-4_0_3[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040304u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[4 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[5 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-4_0_3[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040305u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[5 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_4[0 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-4_0_4[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040400u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_4[1 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-4_0_4[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040401u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_4[2 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-4_0_4[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040402u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_4[3 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-4_0_4[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040403u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_4[4 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-4_0_4[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040404u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_4[5 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-4_0_4[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040405u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_5[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040500u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_5[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040501u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_5[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040502u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_5[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040503u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_5[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040504u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_5[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040505u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_6[0 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-4_0_6[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040600u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_6[0 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_6[1 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-4_0_6[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040601u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_6[1 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_6[2 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-4_0_6[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040602u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_6[2 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_6[3 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-4_0_6[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040603u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_6[3 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_6[4 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-4_0_6[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040604u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_6[4 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_6[5 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-4_0_6[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040605u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_6[5 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_7[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040700u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[0 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_7[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040701u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[1 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_7[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040702u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[2 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_7[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040703u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[3 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_7[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040704u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[4 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_7[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040705u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[5 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_8[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_8[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040800u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_8[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_8[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040801u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_8[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_8[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040802u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_8[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_8[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040803u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_8[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_8[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040804u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_8[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_8[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040805u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[0 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_9[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040900u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[1 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_9[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040901u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[2 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_9[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040902u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[3 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_9[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040903u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[4 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_9[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040904u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[5 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_9[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040905u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_10[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_10[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040a00u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_10[0 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_10[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_10[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040a01u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_10[1 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_10[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_10[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040a02u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_10[2 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_10[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_10[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040a03u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_10[3 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_10[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_10[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040a04u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_10[4 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_10[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_10[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040a05u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_10[5 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ssbo_0_11[0 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_11[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040b00u) ? 0u : 1u);
      ssbo_0_11[0 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[1 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_11[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040b01u) ? 0u : 1u);
      ssbo_0_11[1 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[2 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_11[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040b02u) ? 0u : 1u);
      ssbo_0_11[2 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[3 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_11[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040b03u) ? 0u : 1u);
      ssbo_0_11[3 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[4 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_11[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040b04u) ? 0u : 1u);
      ssbo_0_11[4 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[5 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_11[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040b05u) ? 0u : 1u);
      ssbo_0_11[5 + pc.zero].val = (readValue | 0xff000000u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[4], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[6]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;
layout (push_constant, std430) uniform PushConstantBlock { uint zero; } pc;

layout (set=0, binding=0) buffer sboBlock_0_0 { uint val; } ssbo_0_0[6];
layout (set=0, binding=1) uniform utexture2D sampledImage_0_1[6];
layout (set=0, binding=2) uniform utexture2D sampledImage_0_2[6];
layout (set=0, binding=3, r32ui) uniform uimage2D storageImage_0_3[6];
layout (set=0, binding=4, r32ui) uniform uimage2D storageImage_0_4[6];
layout (set=0, binding=5) uniform utextureBuffer uniformTexel_0_5[6];
layout (set=0, binding=6) uniform utextureBuffer uniformTexel_0_6[6];
layout (set=0, binding=7, r32ui) uniform uimageBuffer storageTexel_0_7[6];
layout (set=0, binding=8, r32ui) uniform uimageBuffer storageTexel_0_8[6];
layout (set=0, binding=9) uniform uboBlock_0_9 { uint val; } ubo_0_9[6];
layout (set=0, binding=10) uniform uboBlock_0_10 { uint val; } ubo_0_10[6];
layout (set=0, binding=11) buffer sboBlock_0_11 { uint val; } ssbo_0_11[6];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[5], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ssbo_0_0[0 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_0[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050000u) ? 0u : 1u);
      ssbo_0_0[0 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_0[1 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_0[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050001u) ? 0u : 1u);
      ssbo_0_0[1 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_0[2 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_0[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050002u) ? 0u : 1u);
      ssbo_0_0[2 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_0[3 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_0[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050003u) ? 0u : 1u);
      ssbo_0_0[3 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_0[4 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_0[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050004u) ? 0u : 1u);
      ssbo_0_0[4 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_0[5 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_0[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050005u) ? 0u : 1u);
      ssbo_0_0[5 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[0 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-5_0_1[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050100u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[1 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-5_0_1[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050101u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[2 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-5_0_1[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050102u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[3 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-5_0_1[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050103u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[4 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-5_0_1[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050104u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[5 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-5_0_1[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050105u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_2[0 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-5_0_2[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050200u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_2[1 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-5_0_2[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050201u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_2[2 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-5_0_2[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050202u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_2[3 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-5_0_2[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050203u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_2[4 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-5_0_2[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050204u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_2[5 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-5_0_2[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050205u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_3[0 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-5_0_3[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050300u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[0 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[1 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-5_0_3[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050301u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[1 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[2 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-5_0_3[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050302u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[2 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[3 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-5_0_3[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050303u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[3 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[4 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-5_0_3[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050304u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[4 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_3[5 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-5_0_3[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050305u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_3[5 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_4[0 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-5_0_4[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050400u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_4[0 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_4[1 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-5_0_4[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050401u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_4[1 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_4[2 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-5_0_4[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050402u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_4[2 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_4[3 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-5_0_4[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050403u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_4[3 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_4[4 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-5_0_4[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050404u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_4[4 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_4[5 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-5_0_4[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050405u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_4[5 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_5[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050500u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_5[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050501u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_5[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050502u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_5[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050503u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_5[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050504u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_5[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_5[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050505u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_6[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_6[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050600u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_6[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_6[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050601u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_6[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_6[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050602u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_6[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_6[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050603u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_6[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_6[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050604u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_6[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_6[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050605u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_7[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050700u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[0 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_7[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050701u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[1 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_7[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050702u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[2 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_7[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050703u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[3 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_7[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050704u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[4 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_7[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_7[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050705u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_7[5 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_8[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_8[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050800u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_8[0 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_8[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_8[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050801u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_8[1 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_8[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_8[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050802u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_8[2 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_8[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_8[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050803u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_8[3 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_8[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_8[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050804u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_8[4 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_8[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_8[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050805u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_8[5 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_9[0 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_9[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050900u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[1 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_9[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050901u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[2 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_9[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050902u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[3 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_9[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050903u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[4 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_9[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050904u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_9[5 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_9[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050905u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_10[0 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_10[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050a00u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_10[1 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_10[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050a01u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_10[2 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_10[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050a02u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_10[3 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_10[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050a03u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_10[4 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_10[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050a04u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_10[5 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_10[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050a05u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_11[0 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_11[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050b00u) ? 0u : 1u);
      ssbo_0_11[0 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[1 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_11[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050b01u) ? 0u : 1u);
      ssbo_0_11[1 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[2 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_11[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050b02u) ? 0u : 1u);
      ssbo_0_11[2 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[3 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_11[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050b03u) ? 0u : 1u);
      ssbo_0_11[3 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[4 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_11[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050b04u) ? 0u : 1u);
      ssbo_0_11[4 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_11[5 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_11[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050b05u) ? 0u : 1u);
      ssbo_0_11[5 + pc.zero].val = (readValue | 0xff000000u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[5], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[6]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;
layout (push_constant, std430) uniform PushConstantBlock { uint zero; } pc;

layout (set=0, binding=0) uniform utexture2D sampledImage_0_0[6];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(usampler2D(sampledImage_0_0[0 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_0[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_0[1 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_0[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000001u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_0[2 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_0[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000002u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_0[3 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_0[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000003u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_0[4 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_0[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000004u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_0[5 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_0[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000005u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[6]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;
layout (push_constant, std430) uniform PushConstantBlock { uint zero; } pc;

layout (set=0, binding=0, r32ui) uniform uimage2D storageImage_0_0[6];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageImage_0_0[0 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_0[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0[0 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_0[1 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_0[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010001u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0[1 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_0[2 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_0[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010002u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0[2 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_0[3 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_0[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010003u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0[3 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_0[4 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_0[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010004u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0[4 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_0[5 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_0[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010005u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0[5 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[6]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;
layout (push_constant, std430) uniform PushConstantBlock { uint zero; } pc;

layout (set=0, binding=0) uniform utextureBuffer uniformTexel_0_0[6];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[2], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texelFetch(uniformTexel_0_0[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_0[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020000u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_0[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_0[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020001u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_0[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_0[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020002u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_0[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_0[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020003u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_0[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_0[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020004u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_0[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_0[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020005u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[2], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[6]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;
layout (push_constant, std430) uniform PushConstantBlock { uint zero; } pc;

layout (set=0, binding=0, r32ui) uniform uimageBuffer storageTexel_0_0[6];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[3], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageTexel_0_0[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_0[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0[0 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_0[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_0[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030001u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0[1 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_0[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_0[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030002u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0[2 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_0[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_0[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030003u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0[3 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_0[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_0[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030004u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0[4 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_0[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_0[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030005u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0[5 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[3], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[6]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;
layout (push_constant, std430) uniform PushConstantBlock { uint zero; } pc;

layout (set=0, binding=0) uniform uboBlock_0_0 { uint val; } ubo_0_0[6];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[4], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ubo_0_0[0 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_0[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040000u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_0[1 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_0[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040001u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_0[2 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_0[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040002u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_0[3 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_0[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040003u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_0[4 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_0[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040004u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_0[5 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_0[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040005u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[4], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[6]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;
layout (push_constant, std430) uniform PushConstantBlock { uint zero; } pc;

layout (set=0, binding=0) buffer sboBlock_0_0 { uint val; } ssbo_0_0[6];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[5], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ssbo_0_0[0 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_0[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050000u) ? 0u : 1u);
      ssbo_0_0[0 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_0[1 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_0[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050001u) ? 0u : 1u);
      ssbo_0_0[1 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_0[2 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_0[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050002u) ? 0u : 1u);
      ssbo_0_0[2 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_0[3 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_0[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050003u) ? 0u : 1u);
      ssbo_0_0[3 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_0[4 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_0[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050004u) ? 0u : 1u);
      ssbo_0_0[4 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_0[5 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_0[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050005u) ? 0u : 1u);
      ssbo_0_0[5 + pc.zero].val = (readValue | 0xff000000u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[5], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[6]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;
layout (push_constant, std430) uniform PushConstantBlock { uint zero; } pc;

layout (set=0, binding=0) uniform utexture2D sampledImage_0_0[];
layout (set=0, binding=0, r32ui) uniform uimage2D storageImage_0_0[];
layout (set=0, binding=0) uniform utextureBuffer uniformTexel_0_0[];
layout (set=0, binding=0, r32ui) uniform uimageBuffer storageTexel_0_0[];
layout (set=0, binding=0) uniform uboBlock_0_0 { uint val; } ubo_0_0[];
layout (set=0, binding=0) buffer sboBlock_0_0 { uint val; } ssbo_0_0[];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(usampler2D(sampledImage_0_0[0 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_0[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_0[1 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-0_0_0[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000001u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0[1 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_0[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_0[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000002u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_0[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_0[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000003u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0[3 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_0[4 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_0[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000004u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_0[5 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_0[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000005u) ? 0u : 1u);
      ssbo_0_0[5 + pc.zero].val = (readValue | 0xff000000u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[6]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;
layout (push_constant, std430) uniform PushConstantBlock { uint zero; } pc;

layout (set=0, binding=0, r32ui) uniform uimage2D storageImage_0_0[];
layout (set=0, binding=0) uniform utextureBuffer uniformTexel_0_0[];
layout (set=0, binding=0, r32ui) uniform uimageBuffer storageTexel_0_0[];
layout (set=0, binding=0) uniform uboBlock_0_0 { uint val; } ubo_0_0[];
layout (set=0, binding=0) buffer sboBlock_0_0 { uint val; } ssbo_0_0[];
layout (set=0, binding=0) uniform utexture2D sampledImage_0_0[];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageImage_0_0[0 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_0[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0[0 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_0[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_0[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010001u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_0[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_0[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010002u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0[2 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_0[3 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_0[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010003u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_0[4 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_0[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010004u) ? 0u : 1u);
      ssbo_0_0[4 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_0[5 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_0[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010005u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[6]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;
layout (push_constant, std430) uniform PushConstantBlock { uint zero; } pc;

layout (set=0, binding=0) uniform utextureBuffer uniformTexel_0_0[];
layout (set=0, binding=0, r32ui) uniform uimageBuffer storageTexel_0_0[];
layout (set=0, binding=0) uniform uboBlock_0_0 { uint val; } ubo_0_0[];
layout (set=0, binding=0) buffer sboBlock_0_0 { uint val; } ssbo_0_0[];
layout (set=0, binding=0) uniform utexture2D sampledImage_0_0[];
layout (set=0, binding=0, r32ui) uniform uimage2D storageImage_0_0[];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[2], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texelFetch(uniformTexel_0_0[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_0[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020000u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_0[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_0[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020001u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0[1 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_0[2 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_0[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020002u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_0[3 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_0[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020003u) ? 0u : 1u);
      ssbo_0_0[3 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_0[4 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-2_0_0[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020004u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_0[5 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-2_0_0[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020005u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0[5 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[2], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[6]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;
layout (push_constant, std430) uniform PushConstantBlock { uint zero; } pc;

layout (set=0, binding=0, r32ui) uniform uimageBuffer storageTexel_0_0[];
layout (set=0, binding=0) uniform uboBlock_0_0 { uint val; } ubo_0_0[];
layout (set=0, binding=0) buffer sboBlock_0_0 { uint val; } ssbo_0_0[];
layout (set=0, binding=0) uniform utexture2D sampledImage_0_0[];
layout (set=0, binding=0, r32ui) uniform uimage2D storageImage_0_0[];
layout (set=0, binding=0) uniform utextureBuffer uniformTexel_0_0[];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[3], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageTexel_0_0[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_0[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0[0 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_0[1 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_0[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030001u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_0[2 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_0[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030002u) ? 0u : 1u);
      ssbo_0_0[2 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_0[3 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-3_0_0[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030003u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_0[4 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-3_0_0[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030004u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0[4 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_0[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_0[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030005u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[3], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[6]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;
layout (push_constant, std430) uniform PushConstantBlock { uint zero; } pc;

layout (set=0, binding=0) uniform uboBlock_0_0 { uint val; } ubo_0_0[];
layout (set=0, binding=0) buffer sboBlock_0_0 { uint val; } ssbo_0_0[];
layout (set=0, binding=0) uniform utexture2D sampledImage_0_0[];
layout (set=0, binding=0, r32ui) uniform uimage2D storageImage_0_0[];
layout (set=0, binding=0) uniform utextureBuffer uniformTexel_0_0[];
layout (set=0, binding=0, r32ui) uniform uimageBuffer storageTexel_0_0[];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[4], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ubo_0_0[0 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_0[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040000u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_0[1 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_0[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040001u) ? 0u : 1u);
      ssbo_0_0[1 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_0[2 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-4_0_0[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040002u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_0[3 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-4_0_0[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040003u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0[3 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_0[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_0[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040004u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_0[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_0[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040005u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0[5 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[4], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[6]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;
layout (push_constant, std430) uniform PushConstantBlock { uint zero; } pc;

layout (set=0, binding=0) buffer sboBlock_0_0 { uint val; } ssbo_0_0[];
layout (set=0, binding=0) uniform utexture2D sampledImage_0_0[];
layout (set=0, binding=0, r32ui) uniform uimage2D storageImage_0_0[];
layout (set=0, binding=0) uniform utextureBuffer uniformTexel_0_0[];
layout (set=0, binding=0, r32ui) uniform uimageBuffer storageTexel_0_0[];
layout (set=0, binding=0) uniform uboBlock_0_0 { uint val; } ubo_0_0[];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[5], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ssbo_0_0[0 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_0[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050000u) ? 0u : 1u);
      ssbo_0_0[0 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_0[1 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-5_0_0[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050001u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_0[2 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-5_0_0[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050002u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0[2 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_0[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_0[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050003u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_0[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_0[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050004u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0[4 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_0[5 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_0[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050005u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[5], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_tracing : enable
#extension GL_EXT_ray_query : enable

layout (location=0) rayPayloadInEXT float unusedRayPayload;
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[1]; } outputBuffer;

layout (set=0, binding=0) uniform accelerationStructureEXT accelerationStructure_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      const uint cullMask = 0xFF;
      const vec3 origin = vec3(0.0, 0.0, 0.0);
      const vec3 direction = vec3(0.0, 0.0, 1.0);
      const float tmin = 1.0;
      const float tmax = 10.0;
      uint candidateFound = 0u;
      rayQueryEXT rq;
      rayQueryInitializeEXT(rq, accelerationStructure_0_0, gl_RayFlagsNoneEXT, cullMask, origin, tmin, direction, tmax);
      while (rayQueryProceedEXT(rq)) {
        const uint candidateType = rayQueryGetIntersectionTypeEXT(rq, false);
        if (candidateType == gl_RayQueryCandidateIntersectionTriangleEXT || candidateType == gl_RayQueryCandidateIntersectionAABBEXT) {
          candidateFound = 1u;
        }
      }
      anyError |= ((candidateFound == 1u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460 core
#extension GL_EXT_ray_tracing : require
layout (set=1, binding=1) uniform accelerationStructureEXT externalAS;
layout (location=0) rayPayloadEXT float unusedRayPayload;

void main()
{
  const uint cullMask = 0xFF;
  const float tMin = 1.0;
  const float tMax = 10.0;
  const vec3 origin = vec3(0.0, 0.0, 0.0);
  const vec3 direction = vec3(0.0, 0.0, 1.0);
  traceRayEXT(externalAS, gl_RayFlagsNoneEXT, cullMask, 0, 0, 0, origin, tMin, direction, tMax, 0);
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_query : enable

layout (triangles, fractional_odd_spacing, cw) in;
in gl_PerVertex
{
  vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
  vec4 gl_Position;
};
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[1]; } outputBuffer;

layout (set=0, binding=0) uniform accelerationStructureEXT accelerationStructure_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      const uint cullMask = 0xFF;
      const vec3 origin = vec3(0.0, 0.0, 0.0);
      const vec3 direction = vec3(0.0, 0.0, 1.0);
      const float tmin = 1.0;
      const float tmax = 10.0;
      uint candidateFound = 0u;
      rayQueryEXT rq;
      rayQueryInitializeEXT(rq, accelerationStructure_0_0, gl_RayFlagsNoneEXT, cullMask, origin, tmin, direction, tmax);
      while (rayQueryProceedEXT(rq)) {
        const uint candidateType = rayQueryGetIntersectionTypeEXT(rq, false);
        if (candidateType == gl_RayQueryCandidateIntersectionTriangleEXT || candidateType == gl_RayQueryCandidateIntersectionAABBEXT) {
          candidateFound = 1u;
        }
      }
      anyError |= ((candidateFound == 1u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
  gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                (gl_TessCoord.y * gl_in[1].gl_Position) +
                (gl_TessCoord.z * gl_in[2].gl_Position);
}
#version 460
layout (vertices=3) out;
in gl_PerVertex
{
  vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
  vec4 gl_Position;
} gl_out[];
void main (void)
{
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelInner[1] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
  gl_TessLevelOuter[3] = 1.0;
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 460
out gl_PerVertex
{
  vec4 gl_Position;
};
vec2 vertexPositions[3] = vec2[](
  vec2(0.0, -0.5),
  vec2(0.5, 0.5),
  vec2(-0.5, 0.5)
);
void main() {
  gl_Position = vec4(vertexPositions[gl_VertexIndex], 0.0, 1.0);
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_tracing : enable

layout (location=0) rayPayloadInEXT float unusedRayPayload;
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[1]; } outputBuffer;

layout (set=0, binding=0) uniform usampler2D combinedSampler_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(combinedSampler_0_0, vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460 core
#extension GL_EXT_ray_tracing : require
layout (set=1, binding=1) uniform accelerationStructureEXT externalAS;
layout (location=0) rayPayloadEXT float unusedRayPayload;

void main()
{
  const uint cullMask = 0xFF;
  const float tMin = 1.0;
  const float tMax = 10.0;
  const vec3 origin = vec3(0.0, 0.0, 0.0);
  const vec3 direction = vec3(0.0, 0.0, -1.0);
  traceRayEXT(externalAS, gl_RayFlagsNoneEXT, cullMask, 0, 0, 0, origin, tMin, direction, tMax, 0);
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (triangles, fractional_odd_spacing, cw) in;
in gl_PerVertex
{
  vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
  vec4 gl_Position;
};
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[1]; } outputBuffer;

layout (set=0, binding=0) uniform usampler2D combinedSampler_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(combinedSampler_0_0, vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
  gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                (gl_TessCoord.y * gl_in[1].gl_Position) +
                (gl_TessCoord.z * gl_in[2].gl_Position);
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_tracing : enable

layout (location=0) rayPayloadInEXT float unusedRayPayload;
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[1]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;

layout (set=0, binding=0) uniform utexture2D sampledImage_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(usampler2D(sampledImage_0_0, externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460 core
#extension GL_EXT_ray_tracing : require
layout (set=1, binding=2) uniform accelerationStructureEXT externalAS;
layout (location=0) rayPayloadEXT float unusedRayPayload;

void main()
{
  const uint cullMask = 0xFF;
  const float tMin = 1.0;
  const float tMax = 10.0;
  const vec3 origin = vec3(0.0, 0.0, 0.0);
  const vec3 direction = vec3(0.0, 0.0, 1.0);
  traceRayEXT(externalAS, gl_RayFlagsNoneEXT, cullMask, 0, 0, 0, origin, tMin, direction, tMax, 0);
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[1]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;

layout (set=0, binding=0) uniform utexture2D sampledImage_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(usampler2D(sampledImage_0_0, externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
  vec4 gl_Position;
} gl_in[3];
out gl_PerVertex
{
  vec4 gl_Position;
};
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[1]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;

layout (set=0, binding=0) uniform utexture2D sampledImage_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(usampler2D(sampledImage_0_0, externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
  gl_Position = gl_in[0].gl_Position; EmitVertex();
  gl_Position = gl_in[1].gl_Position; EmitVertex();
  gl_Position = gl_in[2].gl_Position; EmitVertex();
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (triangles, fractional_odd_spacing, cw) in;
in gl_PerVertex
{
  vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
  vec4 gl_Position;
};
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[1]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;

layout (set=0, binding=0) uniform utexture2D sampledImage_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(usampler2D(sampledImage_0_0, externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
  gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                (gl_TessCoord.y * gl_in[1].gl_Position) +
                (gl_TessCoord.z * gl_in[2].gl_Position);
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_tracing : enable

layout (location=0) rayPayloadInEXT float unusedRayPayload;
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[1]; } outputBuffer;
layout (set=1, binding=1) uniform utexture2D externalSampledImage;

layout (set=0, binding=0) uniform sampler sampler_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(usampler2D(externalSampledImage, sampler_0_0), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x41322314u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[1]; } outputBuffer;

layout (set=0, binding=0) buffer sboBlock_0_0 { uint val; } ssbo_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ssbo_0_0.val;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
      ssbo_0_0.val = (readValue | 0xff000000u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_tracing : enable

layout (location=0) rayPayloadInEXT float unusedRayPayload;
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[1]; } outputBuffer;

layout (set=0, binding=0) buffer sboBlock_0_0 { uint val; } ssbo_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ssbo_0_0.val;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
      ssbo_0_0.val = (readValue | 0xff000000u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_tracing : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[1]; } outputBuffer;

layout (set=0, binding=0) buffer sboBlock_0_0 { uint val; } ssbo_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ssbo_0_0.val;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
      ssbo_0_0.val = (readValue | 0xff000000u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_tracing : enable

layout (location=0) callableDataInEXT float unusedCallableData;
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[1]; } outputBuffer;

layout (set=0, binding=0, r32ui) uniform uimage2D storageImage_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageImage_0_0, ivec2(0, 0)).x;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0, ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460 core
#extension GL_EXT_ray_tracing : require
layout (set=1, binding=1) uniform accelerationStructureEXT externalAS;
layout (location=0) callableDataEXT float unusedCallableData;

void main()
{
  executeCallableEXT(0, 0);
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[1]; } outputBuffer;

layout (set=0, binding=0, r32ui) uniform uimage2D storageImage_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageImage_0_0, ivec2(0, 0)).x;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0, ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
  vec4 gl_Position;
} gl_in[3];
out gl_PerVertex
{
  vec4 gl_Position;
};
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[1]; } outputBuffer;

layout (set=0, binding=0, r32ui) uniform uimage2D storageImage_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageImage_0_0, ivec2(0, 0)).x;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0, ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
  gl_Position = gl_in[0].gl_Position; EmitVertex();
  gl_Position = gl_in[1].gl_Position; EmitVertex();
  gl_Position = gl_in[2].gl_Position; EmitVertex();
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_tracing : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[1]; } outputBuffer;

layout (set=0, binding=0, r32ui) uniform uimage2D storageImage_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageImage_0_0, ivec2(0, 0)).x;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0, ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (triangles, fractional_odd_spacing, cw) in;
in gl_PerVertex
{
  vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
  vec4 gl_Position;
};
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[1]; } outputBuffer;

layout (set=0, binding=0, r32ui) uniform uimage2D storageImage_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageImage_0_0, ivec2(0, 0)).x;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0, ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
  gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                (gl_TessCoord.y * gl_in[1].gl_Position) +
                (gl_TessCoord.z * gl_in[2].gl_Position);
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (vertices=3) out;
in gl_PerVertex
{
  vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
  vec4 gl_Position;
} gl_out[];
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[1]; } outputBuffer;

layout (set=0, binding=0, r32ui) uniform uimageBuffer storageTexel_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageTexel_0_0, 0).x;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0, 0, uvec4(readValue, 0, 0, 0));
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelInner[1] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
  gl_TessLevelOuter[3] = 1.0;
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 460
layout (triangles, fractional_odd_spacing, cw) in;
in gl_PerVertex
{
  vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
  vec4 gl_Position;
};
void main (void)
{
  gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                (gl_TessCoord.y * gl_in[1].gl_Position) +
                (gl_TessCoord.z * gl_in[2].gl_Position);
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (triangles, fractional_odd_spacing, cw) in;
in gl_PerVertex
{
  vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
  vec4 gl_Position;
};
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[1]; } outputBuffer;

layout (set=0, binding=0, r32ui) uniform uimageBuffer storageTexel_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageTexel_0_0, 0).x;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0, 0, uvec4(readValue, 0, 0, 0));
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
  gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                (gl_TessCoord.y * gl_in[1].gl_Position) +
                (gl_TessCoord.z * gl_in[2].gl_Position);
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_tracing : enable
#extension GL_EXT_ray_query : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0) uniform accelerationStructureEXT accelerationStructure_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      const uint cullMask = 0xFF;
      const vec3 origin = vec3(0.0, 0.0, 0.0);
      const vec3 direction = vec3(0.0, 0.0, 1.0);
      const float tmin = 1.0;
      const float tmax = 10.0;
      uint candidateFound = 0u;
      rayQueryEXT rq;
      rayQueryInitializeEXT(rq, accelerationStructure_0_0, gl_RayFlagsNoneEXT, cullMask, origin, tmin, direction, tmax);
      while (rayQueryProceedEXT(rq)) {
        const uint candidateType = rayQueryGetIntersectionTypeEXT(rq, false);
        if (candidateType == gl_RayQueryCandidateIntersectionTriangleEXT || candidateType == gl_RayQueryCandidateIntersectionAABBEXT) {
          candidateFound = 1u;
        }
      }
      anyError |= ((candidateFound == 1u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_tracing : enable
#extension GL_EXT_ray_query : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0) uniform usampler2D combinedSampler_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(combinedSampler_0_0, vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_query : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0) uniform accelerationStructureEXT accelerationStructure_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      const uint cullMask = 0xFF;
      const vec3 origin = vec3(0.0, 0.0, 0.0);
      const vec3 direction = vec3(0.0, 0.0, 1.0);
      const float tmin = 1.0;
      const float tmax = 10.0;
      uint candidateFound = 0u;
      rayQueryEXT rq;
      rayQueryInitializeEXT(rq, accelerationStructure_0_0, gl_RayFlagsNoneEXT, cullMask, origin, tmin, direction, tmax);
      while (rayQueryProceedEXT(rq)) {
        const uint candidateType = rayQueryGetIntersectionTypeEXT(rq, false);
        if (candidateType == gl_RayQueryCandidateIntersectionTriangleEXT || candidateType == gl_RayQueryCandidateIntersectionAABBEXT) {
          candidateFound = 1u;
        }
      }
      anyError |= ((candidateFound == 1u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_query : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0, input_attachment_index=0) uniform usubpassInput inputAttachment_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = subpassLoad(inputAttachment_0_0).x;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_query : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;

layout (set=0, binding=0) uniform accelerationStructureEXT accelerationStructure_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      const uint cullMask = 0xFF;
      const vec3 origin = vec3(0.0, 0.0, 0.0);
      const vec3 direction = vec3(0.0, 0.0, 1.0);
      const float tmin = 1.0;
      const float tmax = 10.0;
      uint candidateFound = 0u;
      rayQueryEXT rq;
      rayQueryInitializeEXT(rq, accelerationStructure_0_0, gl_RayFlagsNoneEXT, cullMask, origin, tmin, direction, tmax);
      while (rayQueryProceedEXT(rq)) {
        const uint candidateType = rayQueryGetIntersectionTypeEXT(rq, false);
        if (candidateType == gl_RayQueryCandidateIntersectionTriangleEXT || candidateType == gl_RayQueryCandidateIntersectionAABBEXT) {
          candidateFound = 1u;
        }
      }
      anyError |= ((candidateFound == 1u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_query : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;

layout (set=0, binding=0) uniform utexture2D sampledImage_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(usampler2D(sampledImage_0_0, externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_query : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0) uniform accelerationStructureEXT accelerationStructure_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      const uint cullMask = 0xFF;
      const vec3 origin = vec3(0.0, 0.0, 0.0);
      const vec3 direction = vec3(0.0, 0.0, 1.0);
      const float tmin = 1.0;
      const float tmax = 10.0;
      uint candidateFound = 0u;
      rayQueryEXT rq;
      rayQueryInitializeEXT(rq, accelerationStructure_0_0, gl_RayFlagsNoneEXT, cullMask, origin, tmin, direction, tmax);
      while (rayQueryProceedEXT(rq)) {
        const uint candidateType = rayQueryGetIntersectionTypeEXT(rq, false);
        if (candidateType == gl_RayQueryCandidateIntersectionTriangleEXT || candidateType == gl_RayQueryCandidateIntersectionAABBEXT) {
          candidateFound = 1u;
        }
      }
      anyError |= ((candidateFound == 1u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_query : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0, r32ui) uniform uimageBuffer storageTexel_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageTexel_0_0, 0).x;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0, 0, uvec4(readValue, 0, 0, 0));
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_tracing : enable
#extension GL_EXT_ray_query : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0, r32ui) uniform uimageBuffer storageTexel_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageTexel_0_0, 0).x;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0, 0, uvec4(readValue, 0, 0, 0));
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_query : enable

vec2 vertexPositions[3] = vec2[](
  vec2(0.0, -0.5),
  vec2(0.5, 0.5),
  vec2(-0.5, 0.5)
);
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0) uniform accelerationStructureEXT accelerationStructure_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      const uint cullMask = 0xFF;
      const vec3 origin = vec3(0.0, 0.0, 0.0);
      const vec3 direction = vec3(0.0, 0.0, 1.0);
      const float tmin = 1.0;
      const float tmax = 10.0;
      uint candidateFound = 0u;
      rayQueryEXT rq;
      rayQueryInitializeEXT(rq, accelerationStructure_0_0, gl_RayFlagsNoneEXT, cullMask, origin, tmin, direction, tmax);
      while (rayQueryProceedEXT(rq)) {
        const uint candidateType = rayQueryGetIntersectionTypeEXT(rq, false);
        if (candidateType == gl_RayQueryCandidateIntersectionTriangleEXT || candidateType == gl_RayQueryCandidateIntersectionAABBEXT) {
          candidateFound = 1u;
        }
      }
      anyError |= ((candidateFound == 1u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
  gl_Position = vec4(vertexPositions[gl_VertexIndex], 0.0, 1.0);
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_query : enable

vec2 vertexPositions[3] = vec2[](
  vec2(0.0, -0.5),
  vec2(0.5, 0.5),
  vec2(-0.5, 0.5)
);
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0, r32ui) uniform uimageBuffer storageTexel_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageTexel_0_0, 0).x;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0, 0, uvec4(readValue, 0, 0, 0));
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
  gl_Position = vec4(vertexPositions[gl_VertexIndex], 0.0, 1.0);
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_query : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0) uniform usampler2D combinedSampler_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(combinedSampler_0_0, vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_query : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0) uniform accelerationStructureEXT accelerationStructure_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      const uint cullMask = 0xFF;
      const vec3 origin = vec3(0.0, 0.0, 0.0);
      const vec3 direction = vec3(0.0, 0.0, 1.0);
      const float tmin = 1.0;
      const float tmax = 10.0;
      uint candidateFound = 0u;
      rayQueryEXT rq;
      rayQueryInitializeEXT(rq, accelerationStructure_0_0, gl_RayFlagsNoneEXT, cullMask, origin, tmin, direction, tmax);
      while (rayQueryProceedEXT(rq)) {
        const uint candidateType = rayQueryGetIntersectionTypeEXT(rq, false);
        if (candidateType == gl_RayQueryCandidateIntersectionTriangleEXT || candidateType == gl_RayQueryCandidateIntersectionAABBEXT) {
          candidateFound = 1u;
        }
      }
      anyError |= ((candidateFound == 1u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_query : enable

vec2 vertexPositions[3] = vec2[](
  vec2(0.0, -0.5),
  vec2(0.5, 0.5),
  vec2(-0.5, 0.5)
);
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0) uniform usampler2D combinedSampler_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(combinedSampler_0_0, vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
  gl_Position = vec4(vertexPositions[gl_VertexIndex], 0.0, 1.0);
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_query : enable

vec2 vertexPositions[3] = vec2[](
  vec2(0.0, -0.5),
  vec2(0.5, 0.5),
  vec2(-0.5, 0.5)
);
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0) uniform accelerationStructureEXT accelerationStructure_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      const uint cullMask = 0xFF;
      const vec3 origin = vec3(0.0, 0.0, 0.0);
      const vec3 direction = vec3(0.0, 0.0, 1.0);
      const float tmin = 1.0;
      const float tmax = 10.0;
      uint candidateFound = 0u;
      rayQueryEXT rq;
      rayQueryInitializeEXT(rq, accelerationStructure_0_0, gl_RayFlagsNoneEXT, cullMask, origin, tmin, direction, tmax);
      while (rayQueryProceedEXT(rq)) {
        const uint candidateType = rayQueryGetIntersectionTypeEXT(rq, false);
        if (candidateType == gl_RayQueryCandidateIntersectionTriangleEXT || candidateType == gl_RayQueryCandidateIntersectionAABBEXT) {
          candidateFound = 1u;
        }
      }
      anyError |= ((candidateFound == 1u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
  gl_Position = vec4(vertexPositions[gl_VertexIndex], 0.0, 1.0);
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_tracing : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;

layout (set=0, binding=0) uniform usampler2D combinedSampler_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(combinedSampler_0_0, vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_tracing : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;

layout (set=0, binding=0) uniform utexture2D sampledImage_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(usampler2D(sampledImage_0_0, externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_tracing : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform utexture2D externalSampledImage;

layout (set=0, binding=0) uniform usampler2D combinedSampler_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(combinedSampler_0_0, vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_tracing : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform utexture2D externalSampledImage;

layout (set=0, binding=0) uniform sampler sampler_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(usampler2D(externalSampledImage, sampler_0_0), vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x41322314u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

vec2 vertexPositions[3] = vec2[](
  vec2(0.0, -0.5),
  vec2(0.5, 0.5),
  vec2(-0.5, 0.5)
);
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0) uniform usampler2D combinedSampler_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(combinedSampler_0_0, vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
  gl_Position = vec4(vertexPositions[gl_VertexIndex], 0.0, 1.0);
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

vec2 vertexPositions[3] = vec2[](
  vec2(0.0, -0.5),
  vec2(0.5, 0.5),
  vec2(-0.5, 0.5)
);
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0) buffer sboBlock_0_0 { uint val; } ssbo_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ssbo_0_0.val;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
      ssbo_0_0.val = (readValue | 0xff000000u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
  gl_Position = vec4(vertexPositions[gl_VertexIndex], 0.0, 1.0);
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0) uniform usampler2D combinedSampler_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(combinedSampler_0_0, vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0, r32ui) uniform uimage2D storageImage_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageImage_0_0, ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0, ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

vec2 vertexPositions[3] = vec2[](
  vec2(0.0, -0.5),
  vec2(0.5, 0.5),
  vec2(-0.5, 0.5)
);
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0, r32ui) uniform uimage2D storageImage_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageImage_0_0, ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0, ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
  gl_Position = vec4(vertexPositions[gl_VertexIndex], 0.0, 1.0);
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0, r32ui) uniform uimageBuffer storageTexel_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageTexel_0_0, 0).x;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0, 0, uvec4(readValue, 0, 0, 0));
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_tracing : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0) uniform usampler2D combinedSampler_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(combinedSampler_0_0, vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_tracing : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0) uniform uboBlock_0_0 { uint val; } ubo_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ubo_0_0.val;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;

layout (set=0, binding=0, input_attachment_index=0) uniform usubpassInput inputAttachment_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = subpassLoad(inputAttachment_0_0).x;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;

layout (set=0, binding=0) uniform utexture2D sampledImage_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(usampler2D(sampledImage_0_0, externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_query : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;

layout (set=0, binding=0) uniform utexture2D sampledImage_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(usampler2D(sampledImage_0_0, externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_query : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;

layout (set=0, binding=0) uniform accelerationStructureEXT accelerationStructure_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      const uint cullMask = 0xFF;
      const vec3 origin = vec3(0.0, 0.0, 0.0);
      const vec3 direction = vec3(0.0, 0.0, 1.0);
      const float tmin = 1.0;
      const float tmax = 10.0;
      uint candidateFound = 0u;
      rayQueryEXT rq;
      rayQueryInitializeEXT(rq, accelerationStructure_0_0, gl_RayFlagsNoneEXT, cullMask, origin, tmin, direction, tmax);
      while (rayQueryProceedEXT(rq)) {
        const uint candidateType = rayQueryGetIntersectionTypeEXT(rq, false);
        if (candidateType == gl_RayQueryCandidateIntersectionTriangleEXT || candidateType == gl_RayQueryCandidateIntersectionAABBEXT) {
          candidateFound = 1u;
        }
      }
      anyError |= ((candidateFound == 1u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_query : enable

vec2 vertexPositions[3] = vec2[](
  vec2(0.0, -0.5),
  vec2(0.5, 0.5),
  vec2(-0.5, 0.5)
);
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;

layout (set=0, binding=0) uniform utexture2D sampledImage_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(usampler2D(sampledImage_0_0, externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
  gl_Position = vec4(vertexPositions[gl_VertexIndex], 0.0, 1.0);
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_query : enable

vec2 vertexPositions[3] = vec2[](
  vec2(0.0, -0.5),
  vec2(0.5, 0.5),
  vec2(-0.5, 0.5)
);
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;

layout (set=0, binding=0) uniform accelerationStructureEXT accelerationStructure_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      const uint cullMask = 0xFF;
      const vec3 origin = vec3(0.0, 0.0, 0.0);
      const vec3 direction = vec3(0.0, 0.0, 1.0);
      const float tmin = 1.0;
      const float tmax = 10.0;
      uint candidateFound = 0u;
      rayQueryEXT rq;
      rayQueryInitializeEXT(rq, accelerationStructure_0_0, gl_RayFlagsNoneEXT, cullMask, origin, tmin, direction, tmax);
      while (rayQueryProceedEXT(rq)) {
        const uint candidateType = rayQueryGetIntersectionTypeEXT(rq, false);
        if (candidateType == gl_RayQueryCandidateIntersectionTriangleEXT || candidateType == gl_RayQueryCandidateIntersectionAABBEXT) {
          candidateFound = 1u;
        }
      }
      anyError |= ((candidateFound == 1u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
  gl_Position = vec4(vertexPositions[gl_VertexIndex], 0.0, 1.0);
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_tracing : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;

layout (set=0, binding=0) uniform utexture2D sampledImage_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(usampler2D(sampledImage_0_0, externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_tracing : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;

layout (set=0, binding=0) uniform usampler2D combinedSampler_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(combinedSampler_0_0, vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

vec2 vertexPositions[3] = vec2[](
  vec2(0.0, -0.5),
  vec2(0.5, 0.5),
  vec2(-0.5, 0.5)
);
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;

layout (set=0, binding=0) uniform utexture2D sampledImage_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(usampler2D(sampledImage_0_0, externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
  gl_Position = vec4(vertexPositions[gl_VertexIndex], 0.0, 1.0);
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

vec2 vertexPositions[3] = vec2[](
  vec2(0.0, -0.5),
  vec2(0.5, 0.5),
  vec2(-0.5, 0.5)
);
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;

layout (set=0, binding=0) uniform usampler2D combinedSampler_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(combinedSampler_0_0, vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
  gl_Position = vec4(vertexPositions[gl_VertexIndex], 0.0, 1.0);
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_tracing : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform utexture2D externalSampledImage;
layout (set=1, binding=2) uniform sampler externalSampler;

layout (set=0, binding=0) uniform utexture2D sampledImage_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(usampler2D(sampledImage_0_0, externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_tracing : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform utexture2D externalSampledImage;
layout (set=1, binding=2) uniform sampler externalSampler;

layout (set=0, binding=0) uniform sampler sampler_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(usampler2D(externalSampledImage, sampler_0_0), vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x41322314u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;

layout (set=0, binding=0) uniform utexture2D sampledImage_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(usampler2D(sampledImage_0_0, externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;

layout (set=0, binding=0) buffer sboBlock_0_0 { uint val; } ssbo_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ssbo_0_0.val;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
      ssbo_0_0.val = (readValue | 0xff000000u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;

layout (set=0, binding=0) uniform utexture2D sampledImage_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(usampler2D(sampledImage_0_0, externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;

layout (set=0, binding=0, r32ui) uniform uimage2D storageImage_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageImage_0_0, ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0, ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_tracing : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;

layout (set=0, binding=0, r32ui) uniform uimageBuffer storageTexel_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageTexel_0_0, 0).x;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0, 0, uvec4(readValue, 0, 0, 0));
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_tracing : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;

layout (set=0, binding=0) uniform uboBlock_0_0 { uint val; } ubo_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ubo_0_0.val;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

vec2 vertexPositions[3] = vec2[](
  vec2(0.0, -0.5),
  vec2(0.5, 0.5),
  vec2(-0.5, 0.5)
);
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;

layout (set=0, binding=0) uniform uboBlock_0_0 { uint val; } ubo_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ubo_0_0.val;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
  gl_Position = vec4(vertexPositions[gl_VertexIndex], 0.0, 1.0);
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;

layout (set=0, binding=0) uniform utextureBuffer uniformTexel_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texelFetch(uniformTexel_0_0, 0).x;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_tracing : enable
#extension GL_EXT_ray_query : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform utexture2D externalSampledImage;

layout (set=0, binding=0) uniform sampler sampler_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(usampler2D(externalSampledImage, sampler_0_0), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x41322314u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_tracing : enable
#extension GL_EXT_ray_query : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform utexture2D externalSampledImage;

layout (set=0, binding=0) uniform accelerationStructureEXT accelerationStructure_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      const uint cullMask = 0xFF;
      const vec3 origin = vec3(0.0, 0.0, 0.0);
      const vec3 direction = vec3(0.0, 0.0, 1.0);
      const float tmin = 1.0;
      const float tmax = 10.0;
      uint candidateFound = 0u;
      rayQueryEXT rq;
      rayQueryInitializeEXT(rq, accelerationStructure_0_0, gl_RayFlagsNoneEXT, cullMask, origin, tmin, direction, tmax);
      while (rayQueryProceedEXT(rq)) {
        const uint candidateType = rayQueryGetIntersectionTypeEXT(rq, false);
        if (candidateType == gl_RayQueryCandidateIntersectionTriangleEXT || candidateType == gl_RayQueryCandidateIntersectionAABBEXT) {
          candidateFound = 1u;
        }
      }
      anyError |= ((candidateFound == 1u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_query : enable

vec2 vertexPositions[3] = vec2[](
  vec2(0.0, -0.5),
  vec2(0.5, 0.5),
  vec2(-0.5, 0.5)
);
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform utexture2D externalSampledImage;

layout (set=0, binding=0) uniform sampler sampler_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(usampler2D(externalSampledImage, sampler_0_0), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x41322314u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
  gl_Position = vec4(vertexPositions[gl_VertexIndex], 0.0, 1.0);
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_query : enable

vec2 vertexPositions[3] = vec2[](
  vec2(0.0, -0.5),
  vec2(0.5, 0.5),
  vec2(-0.5, 0.5)
);
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform utexture2D externalSampledImage;

layout (set=0, binding=0) uniform accelerationStructureEXT accelerationStructure_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      const uint cullMask = 0xFF;
      const vec3 origin = vec3(0.0, 0.0, 0.0);
      const vec3 direction = vec3(0.0, 0.0, 1.0);
      const float tmin = 1.0;
      const float tmax = 10.0;
      uint candidateFound = 0u;
      rayQueryEXT rq;
      rayQueryInitializeEXT(rq, accelerationStructure_0_0, gl_RayFlagsNoneEXT, cullMask, origin, tmin, direction, tmax);
      while (rayQueryProceedEXT(rq)) {
        const uint candidateType = rayQueryGetIntersectionTypeEXT(rq, false);
        if (candidateType == gl_RayQueryCandidateIntersectionTriangleEXT || candidateType == gl_RayQueryCandidateIntersectionAABBEXT) {
          candidateFound = 1u;
        }
      }
      anyError |= ((candidateFound == 1u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
  gl_Position = vec4(vertexPositions[gl_VertexIndex], 0.0, 1.0);
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform utexture2D externalSampledImage;

layout (set=0, binding=0) uniform sampler sampler_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(usampler2D(externalSampledImage, sampler_0_0), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x41322314u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform utexture2D externalSampledImage;

layout (set=0, binding=0, input_attachment_index=0) uniform usubpassInput inputAttachment_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = subpassLoad(inputAttachment_0_0).x;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform utexture2D externalSampledImage;
layout (set=1, binding=2) uniform sampler externalSampler;

layout (set=0, binding=0) uniform sampler sampler_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(usampler2D(externalSampledImage, sampler_0_0), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x41322314u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform utexture2D externalSampledImage;
layout (set=1, binding=2) uniform sampler externalSampler;

layout (set=0, binding=0) uniform utexture2D sampledImage_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(usampler2D(sampledImage_0_0, externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

vec2 vertexPositions[3] = vec2[](
  vec2(0.0, -0.5),
  vec2(0.5, 0.5),
  vec2(-0.5, 0.5)
);
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform utexture2D externalSampledImage;
layout (set=1, binding=2) uniform sampler externalSampler;

layout (set=0, binding=0) uniform sampler sampler_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(usampler2D(externalSampledImage, sampler_0_0), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x41322314u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
  gl_Position = vec4(vertexPositions[gl_VertexIndex], 0.0, 1.0);
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

vec2 vertexPositions[3] = vec2[](
  vec2(0.0, -0.5),
  vec2(0.5, 0.5),
  vec2(-0.5, 0.5)
);
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform utexture2D externalSampledImage;
layout (set=1, binding=2) uniform sampler externalSampler;

layout (set=0, binding=0) uniform utexture2D sampledImage_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(usampler2D(sampledImage_0_0, externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
  gl_Position = vec4(vertexPositions[gl_VertexIndex], 0.0, 1.0);
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_tracing : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform utexture2D externalSampledImage;

layout (set=0, binding=0) uniform sampler sampler_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(usampler2D(externalSampledImage, sampler_0_0), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x41322314u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_tracing : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform utexture2D externalSampledImage;

layout (set=0, binding=0) buffer sboBlock_0_0 { uint val; } ssbo_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ssbo_0_0.val;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
      ssbo_0_0.val = (readValue | 0xff000000u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

vec2 vertexPositions[3] = vec2[](
  vec2(0.0, -0.5),
  vec2(0.5, 0.5),
  vec2(-0.5, 0.5)
);
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform utexture2D externalSampledImage;

layout (set=0, binding=0) uniform sampler sampler_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(usampler2D(externalSampledImage, sampler_0_0), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x41322314u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
  gl_Position = vec4(vertexPositions[gl_VertexIndex], 0.0, 1.0);
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

vec2 vertexPositions[3] = vec2[](
  vec2(0.0, -0.5),
  vec2(0.5, 0.5),
  vec2(-0.5, 0.5)
);
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform utexture2D externalSampledImage;

layout (set=0, binding=0) buffer sboBlock_0_0 { uint val; } ssbo_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ssbo_0_0.val;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
      ssbo_0_0.val = (readValue | 0xff000000u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
  gl_Position = vec4(vertexPositions[gl_VertexIndex], 0.0, 1.0);
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform utexture2D externalSampledImage;

layout (set=0, binding=0) uniform sampler sampler_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(usampler2D(externalSampledImage, sampler_0_0), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x41322314u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform utexture2D externalSampledImage;

layout (set=0, binding=0, r32ui) uniform uimageBuffer storageTexel_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageTexel_0_0, 0).x;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0, 0, uvec4(readValue, 0, 0, 0));
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform utexture2D externalSampledImage;

layout (set=0, binding=0, r32ui) uniform uimageBuffer storageTexel_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageTexel_0_0, 0).x;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0, 0, uvec4(readValue, 0, 0, 0));
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

vec2 vertexPositions[3] = vec2[](
  vec2(0.0, -0.5),
  vec2(0.5, 0.5),
  vec2(-0.5, 0.5)
);
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform utexture2D externalSampledImage;

layout (set=0, binding=0, r32ui) uniform uimageBuffer storageTexel_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageTexel_0_0, 0).x;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0, 0, uvec4(readValue, 0, 0, 0));
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
  gl_Position = vec4(vertexPositions[gl_VertexIndex], 0.0, 1.0);
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_tracing : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform utexture2D externalSampledImage;

layout (set=0, binding=0) uniform utextureBuffer uniformTexel_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texelFetch(uniformTexel_0_0, 0).x;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

vec2 vertexPositions[3] = vec2[](
  vec2(0.0, -0.5),
  vec2(0.5, 0.5),
  vec2(-0.5, 0.5)
);
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform utexture2D externalSampledImage;

layout (set=0, binding=0) uniform utextureBuffer uniformTexel_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texelFetch(uniformTexel_0_0, 0).x;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
  gl_Position = vec4(vertexPositions[gl_VertexIndex], 0.0, 1.0);
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_tracing : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0) buffer sboBlock_0_0 { uint val; } ssbo_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ssbo_0_0.val;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
      ssbo_0_0.val = (readValue | 0xff000000u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_tracing : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0) uniform usampler2D combinedSampler_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(combinedSampler_0_0, vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform utexture2D externalSampledImage;

layout (set=0, binding=0) buffer sboBlock_0_0 { uint val; } ssbo_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ssbo_0_0.val;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
      ssbo_0_0.val = (readValue | 0xff000000u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform utexture2D externalSampledImage;

layout (set=0, binding=0) uniform sampler sampler_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(usampler2D(externalSampledImage, sampler_0_0), vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x41322314u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

vec2 vertexPositions[3] = vec2[](
  vec2(0.0, -0.5),
  vec2(0.5, 0.5),
  vec2(-0.5, 0.5)
);
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform utexture2D externalSampledImage;

layout (set=0, binding=0) buffer sboBlock_0_0 { uint val; } ssbo_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ssbo_0_0.val;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
      ssbo_0_0.val = (readValue | 0xff000000u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
  gl_Position = vec4(vertexPositions[gl_VertexIndex], 0.0, 1.0);
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

vec2 vertexPositions[3] = vec2[](
  vec2(0.0, -0.5),
  vec2(0.5, 0.5),
  vec2(-0.5, 0.5)
);
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform utexture2D externalSampledImage;

layout (set=0, binding=0) uniform sampler sampler_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(usampler2D(externalSampledImage, sampler_0_0), vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x41322314u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
  gl_Position = vec4(vertexPositions[gl_VertexIndex], 0.0, 1.0);
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0) buffer sboBlock_0_0 { uint val; } ssbo_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ssbo_0_0.val;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
      ssbo_0_0.val = (readValue | 0xff000000u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0) uniform uboBlock_0_0 { uint val; } ubo_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ubo_0_0.val;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0) uniform utextureBuffer uniformTexel_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texelFetch(uniformTexel_0_0, 0).x;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_query : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0, r32ui) uniform uimage2D storageImage_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageImage_0_0, ivec2(0, 0)).x;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0, ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_tracing : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0, r32ui) uniform uimage2D storageImage_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageImage_0_0, ivec2(0, 0)).x;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0, ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

vec2 vertexPositions[3] = vec2[](
  vec2(0.0, -0.5),
  vec2(0.5, 0.5),
  vec2(-0.5, 0.5)
);
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;

layout (set=0, binding=0, r32ui) uniform uimage2D storageImage_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageImage_0_0, ivec2(0, 0)).x;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0, ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
  gl_Position = vec4(vertexPositions[gl_VertexIndex], 0.0, 1.0);
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

vec2 vertexPositions[3] = vec2[](
  vec2(0.0, -0.5),
  vec2(0.5, 0.5),
  vec2(-0.5, 0.5)
);
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;

layout (set=0, binding=0) uniform utexture2D sampledImage_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(usampler2D(sampledImage_0_0, externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
  gl_Position = vec4(vertexPositions[gl_VertexIndex], 0.0, 1.0);
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform utexture2D externalSampledImage;

layout (set=0, binding=0, r32ui) uniform uimage2D storageImage_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageImage_0_0, ivec2(0, 0)).x;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0, ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_tracing : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform utexture2D externalSampledImage;

layout (set=0, binding=0, r32ui) uniform uimage2D storageImage_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageImage_0_0, ivec2(0, 0)).x;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0, ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_tracing : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0) buffer sboBlock_0_0 { uint val; } ssbo_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ssbo_0_0.val;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
      ssbo_0_0.val = (readValue | 0xff000000u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

vec2 vertexPositions[3] = vec2[](
  vec2(0.0, -0.5),
  vec2(0.5, 0.5),
  vec2(-0.5, 0.5)
);
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0, r32ui) uniform uimage2D storageImage_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageImage_0_0, ivec2(0, 0)).x;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0, ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
  gl_Position = vec4(vertexPositions[gl_VertexIndex], 0.0, 1.0);
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_query : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0, r32ui) uniform uimageBuffer storageTexel_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageTexel_0_0, 0).x;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0, 0, uvec4(readValue, 0, 0, 0));
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_query : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0) uniform accelerationStructureEXT accelerationStructure_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      const uint cullMask = 0xFF;
      const vec3 origin = vec3(0.0, 0.0, 0.0);
      const vec3 direction = vec3(0.0, 0.0, 1.0);
      const float tmin = 1.0;
      const float tmax = 10.0;
      uint candidateFound = 0u;
      rayQueryEXT rq;
      rayQueryInitializeEXT(rq, accelerationStructure_0_0, gl_RayFlagsNoneEXT, cullMask, origin, tmin, direction, tmax);
      while (rayQueryProceedEXT(rq)) {
        const uint candidateType = rayQueryGetIntersectionTypeEXT(rq, false);
        if (candidateType == gl_RayQueryCandidateIntersectionTriangleEXT || candidateType == gl_RayQueryCandidateIntersectionAABBEXT) {
          candidateFound = 1u;
        }
      }
      anyError |= ((candidateFound == 1u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0, r32ui) uniform uimageBuffer storageTexel_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageTexel_0_0, 0).x;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0, 0, uvec4(readValue, 0, 0, 0));
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0, input_attachment_index=0) uniform usubpassInput inputAttachment_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = subpassLoad(inputAttachment_0_0).x;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_tracing : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform utexture2D externalSampledImage;

layout (set=0, binding=0, r32ui) uniform uimageBuffer storageTexel_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageTexel_0_0, 0).x;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0, 0, uvec4(readValue, 0, 0, 0));
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

vec2 vertexPositions[3] = vec2[](
  vec2(0.0, -0.5),
  vec2(0.5, 0.5),
  vec2(-0.5, 0.5)
);
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform utexture2D externalSampledImage;

layout (set=0, binding=0, r32ui) uniform uimageBuffer storageTexel_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageTexel_0_0, 0).x;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0, 0, uvec4(readValue, 0, 0, 0));
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
  gl_Position = vec4(vertexPositions[gl_VertexIndex], 0.0, 1.0);
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0) buffer sboBlock_0_0 { uint val; } ssbo_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ssbo_0_0.val;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
      ssbo_0_0.val = (readValue | 0xff000000u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

vec2 vertexPositions[3] = vec2[](
  vec2(0.0, -0.5),
  vec2(0.5, 0.5),
  vec2(-0.5, 0.5)
);
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0, r32ui) uniform uimageBuffer storageTexel_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageTexel_0_0, 0).x;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0, 0, uvec4(readValue, 0, 0, 0));
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
  gl_Position = vec4(vertexPositions[gl_VertexIndex], 0.0, 1.0);
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_tracing : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0, r32ui) uniform uimageBuffer storageTexel_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageTexel_0_0, 0).x;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0, 0, uvec4(readValue, 0, 0, 0));
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_tracing : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0, r32ui) uniform uimage2D storageImage_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageImage_0_0, ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0, ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

vec2 vertexPositions[3] = vec2[](
  vec2(0.0, -0.5),
  vec2(0.5, 0.5),
  vec2(-0.5, 0.5)
);
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0) uniform uboBlock_0_0 { uint val; } ubo_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ubo_0_0.val;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
  gl_Position = vec4(vertexPositions[gl_VertexIndex], 0.0, 1.0);
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_tracing : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0) uniform utextureBuffer uniformTexel_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texelFetch(uniformTexel_0_0, 0).x;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

vec2 vertexPositions[3] = vec2[](
  vec2(0.0, -0.5),
  vec2(0.5, 0.5),
  vec2(-0.5, 0.5)
);
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0) uniform uboBlock_0_0 { uint val; } ubo_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ubo_0_0.val;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
  gl_Position = vec4(vertexPositions[gl_VertexIndex], 0.0, 1.0);
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

vec2 vertexPositions[3] = vec2[](
  vec2(0.0, -0.5),
  vec2(0.5, 0.5),
  vec2(-0.5, 0.5)
);
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0) uniform usampler2D combinedSampler_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(combinedSampler_0_0, vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
  gl_Position = vec4(vertexPositions[gl_VertexIndex], 0.0, 1.0);
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0) uniform uboBlock_0_0 { uint val; } ubo_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ubo_0_0.val;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;

layout (set=0, binding=0) uniform uboBlock_0_0 { uint val; } ubo_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ubo_0_0.val;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_tracing : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;

layout (set=0, binding=0) uniform uboBlock_0_0 { uint val; } ubo_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ubo_0_0.val;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_tracing : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0) uniform uboBlock_0_0 { uint val; } ubo_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ubo_0_0.val;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_tracing : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0, r32ui) uniform uimageBuffer storageTexel_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageTexel_0_0, 0).x;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0, 0, uvec4(readValue, 0, 0, 0));
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_tracing : enable
#extension GL_EXT_ray_query : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0) uniform utextureBuffer uniformTexel_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texelFetch(uniformTexel_0_0, 0).x;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_tracing : enable
#extension GL_EXT_ray_query : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0) uniform accelerationStructureEXT accelerationStructure_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      const uint cullMask = 0xFF;
      const vec3 origin = vec3(0.0, 0.0, 0.0);
      const vec3 direction = vec3(0.0, 0.0, 1.0);
      const float tmin = 1.0;
      const float tmax = 10.0;
      uint candidateFound = 0u;
      rayQueryEXT rq;
      rayQueryInitializeEXT(rq, accelerationStructure_0_0, gl_RayFlagsNoneEXT, cullMask, origin, tmin, direction, tmax);
      while (rayQueryProceedEXT(rq)) {
        const uint candidateType = rayQueryGetIntersectionTypeEXT(rq, false);
        if (candidateType == gl_RayQueryCandidateIntersectionTriangleEXT || candidateType == gl_RayQueryCandidateIntersectionAABBEXT) {
          candidateFound = 1u;
        }
      }
      anyError |= ((candidateFound == 1u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0) uniform utextureBuffer uniformTexel_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texelFetch(uniformTexel_0_0, 0).x;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0) uniform usampler2D combinedSampler_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(combinedSampler_0_0, vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform utexture2D externalSampledImage;

layout (set=0, binding=0) uniform utextureBuffer uniformTexel_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texelFetch(uniformTexel_0_0, 0).x;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_tracing : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform utexture2D externalSampledImage;

layout (set=0, binding=0) uniform utextureBuffer uniformTexel_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texelFetch(uniformTexel_0_0, 0).x;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

vec2 vertexPositions[3] = vec2[](
  vec2(0.0, -0.5),
  vec2(0.5, 0.5),
  vec2(-0.5, 0.5)
);
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;
layout (set=1, binding=1) uniform utexture2D externalSampledImage;

layout (set=0, binding=0) uniform utextureBuffer uniformTexel_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texelFetch(uniformTexel_0_0, 0).x;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
  gl_Position = vec4(vertexPositions[gl_VertexIndex], 0.0, 1.0);
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_tracing : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0) uniform utextureBuffer uniformTexel_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texelFetch(uniformTexel_0_0, 0).x;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0, r32ui) uniform uimageBuffer storageTexel_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageTexel_0_0, 0).x;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0, 0, uvec4(readValue, 0, 0, 0));
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

vec2 vertexPositions[3] = vec2[](
  vec2(0.0, -0.5),
  vec2(0.5, 0.5),
  vec2(-0.5, 0.5)
);
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0) uniform utextureBuffer uniformTexel_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texelFetch(uniformTexel_0_0, 0).x;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
  gl_Position = vec4(vertexPositions[gl_VertexIndex], 0.0, 1.0);
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

vec2 vertexPositions[3] = vec2[](
  vec2(0.0, -0.5),
  vec2(0.5, 0.5),
  vec2(-0.5, 0.5)
);
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0, r32ui) uniform uimageBuffer storageTexel_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageTexel_0_0, 0).x;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0, 0, uvec4(readValue, 0, 0, 0));
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
  gl_Position = vec4(vertexPositions[gl_VertexIndex], 0.0, 1.0);
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[2]; } outputBuffer;

layout (set=0, binding=0) uniform uboBlock_0_0 { uint val; } ubo_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ubo_0_0.val;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[1]; } outputBuffer;

layout (set=0, binding=0) uniform uboBlock_0_0 { uint val; } ubo_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ubo_0_0.val;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_tracing : enable

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[1]; } outputBuffer;

layout (set=0, binding=0) uniform uboBlock_0_0 { uint val; } ubo_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ubo_0_0.val;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (vertices=3) out;
in gl_PerVertex
{
  vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
  vec4 gl_Position;
} gl_out[];
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[1]; } outputBuffer;

layout (set=0, binding=0) uniform uboBlock_0_0 { uint val; } ubo_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ubo_0_0.val;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelInner[1] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
  gl_TessLevelOuter[3] = 1.0;
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (triangles, fractional_odd_spacing, cw) in;
in gl_PerVertex
{
  vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
  vec4 gl_Position;
};
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[1]; } outputBuffer;

layout (set=0, binding=0) uniform uboBlock_0_0 { uint val; } ubo_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ubo_0_0.val;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
  gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                (gl_TessCoord.y * gl_in[1].gl_Position) +
                (gl_TessCoord.z * gl_in[2].gl_Position);
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_tracing : enable

layout (location=0) rayPayloadInEXT float unusedRayPayload;
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[1]; } outputBuffer;

layout (set=0, binding=0) uniform utextureBuffer uniformTexel_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texelFetch(uniformTexel_0_0, 0).x;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

vec2 vertexPositions[3] = vec2[](
  vec2(0.0, -0.5),
  vec2(0.5, 0.5),
  vec2(-0.5, 0.5)
);
layout (set=1, binding=0) buffer OutputBufferBlock { uint value[1]; } outputBuffer;

layout (set=0, binding=0) uniform utextureBuffer uniformTexel_0_0;

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texelFetch(uniformTexel_0_0, 0).x;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
  gl_Position = vec4(vertexPositions[gl_VertexIndex], 0.0, 1.0);
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_query : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[7]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;
layout (push_constant, std430) uniform PushConstantBlock { uint zero; } pc;

layout (set=0, binding=0) uniform utexture2D sampledImage_0_0;
layout (set=0, binding=1) uniform utexture2D sampledImage_0_1[7];
layout (set=0, binding=1, r32ui) uniform uimage2D storageImage_0_1[7];
layout (set=0, binding=1) uniform utextureBuffer uniformTexel_0_1[7];
layout (set=0, binding=1, r32ui) uniform uimageBuffer storageTexel_0_1[7];
layout (set=0, binding=1) uniform uboBlock_0_1 { uint val; } ubo_0_1[7];
layout (set=0, binding=1) buffer sboBlock_0_1 { uint val; } ssbo_0_1[7];
layout (set=0, binding=1) uniform accelerationStructureEXT accelerationStructure_0_1[7];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(usampler2D(sampledImage_0_0, externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[0 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_1[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000100u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_1[1 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-0_0_1[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000101u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_1[1 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_1[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_1[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000102u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_1[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-0_0_1[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000103u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_1[3 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_1[4 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_1[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000104u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_1[5 + pc.zero].val;
      debugPrintfEXT("iteration-0_0_1[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000105u) ? 0u : 1u);
      ssbo_0_1[5 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      const uint cullMask = 0xFF;
      const vec3 origin = vec3(262.0, 0.0, 0.0);
      const vec3 direction = vec3(0.0, 0.0, 1.0);
      const float tmin = 1.0;
      const float tmax = 10.0;
      uint candidateFound = 0u;
      rayQueryEXT rq;
      rayQueryInitializeEXT(rq, accelerationStructure_0_1[6 + pc.zero], gl_RayFlagsNoneEXT, cullMask, origin, tmin, direction, tmax);
      while (rayQueryProceedEXT(rq)) {
        const uint candidateType = rayQueryGetIntersectionTypeEXT(rq, false);
        if (candidateType == gl_RayQueryCandidateIntersectionTriangleEXT || candidateType == gl_RayQueryCandidateIntersectionAABBEXT) {
          candidateFound = 1u;
        }
      }
      anyError |= ((candidateFound == 1u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_query : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[7]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;
layout (push_constant, std430) uniform PushConstantBlock { uint zero; } pc;

layout (set=0, binding=0, r32ui) uniform uimage2D storageImage_0_0;
layout (set=0, binding=1, r32ui) uniform uimage2D storageImage_0_1[7];
layout (set=0, binding=1) uniform utextureBuffer uniformTexel_0_1[7];
layout (set=0, binding=1, r32ui) uniform uimageBuffer storageTexel_0_1[7];
layout (set=0, binding=1) uniform uboBlock_0_1 { uint val; } ubo_0_1[7];
layout (set=0, binding=1) buffer sboBlock_0_1 { uint val; } ssbo_0_1[7];
layout (set=0, binding=1) uniform accelerationStructureEXT accelerationStructure_0_1[7];
layout (set=0, binding=1) uniform utexture2D sampledImage_0_1[7];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageImage_0_0, ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0, ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_1[0 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_1[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010100u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_1[0 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_1[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_1[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010101u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_1[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-1_0_1[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010102u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_1[2 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_1[3 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_1[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010103u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_1[4 + pc.zero].val;
      debugPrintfEXT("iteration-1_0_1[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010104u) ? 0u : 1u);
      ssbo_0_1[4 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      const uint cullMask = 0xFF;
      const vec3 origin = vec3(261.0, 0.0, 0.0);
      const vec3 direction = vec3(0.0, 0.0, 1.0);
      const float tmin = 1.0;
      const float tmax = 10.0;
      uint candidateFound = 0u;
      rayQueryEXT rq;
      rayQueryInitializeEXT(rq, accelerationStructure_0_1[5 + pc.zero], gl_RayFlagsNoneEXT, cullMask, origin, tmin, direction, tmax);
      while (rayQueryProceedEXT(rq)) {
        const uint candidateType = rayQueryGetIntersectionTypeEXT(rq, false);
        if (candidateType == gl_RayQueryCandidateIntersectionTriangleEXT || candidateType == gl_RayQueryCandidateIntersectionAABBEXT) {
          candidateFound = 1u;
        }
      }
      anyError |= ((candidateFound == 1u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[6 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_1[6 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010106u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_query : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[7]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;
layout (push_constant, std430) uniform PushConstantBlock { uint zero; } pc;

layout (set=0, binding=0) uniform utextureBuffer uniformTexel_0_0;
layout (set=0, binding=1) uniform utextureBuffer uniformTexel_0_1[7];
layout (set=0, binding=1, r32ui) uniform uimageBuffer storageTexel_0_1[7];
layout (set=0, binding=1) uniform uboBlock_0_1 { uint val; } ubo_0_1[7];
layout (set=0, binding=1) buffer sboBlock_0_1 { uint val; } ssbo_0_1[7];
layout (set=0, binding=1) uniform accelerationStructureEXT accelerationStructure_0_1[7];
layout (set=0, binding=1) uniform utexture2D sampledImage_0_1[7];
layout (set=0, binding=1, r32ui) uniform uimage2D storageImage_0_1[7];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[2], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texelFetch(uniformTexel_0_0, 0).x;
      debugPrintfEXT("iteration-2_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020000u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_1[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_1[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020100u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_1[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_1[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020101u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_1[1 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_1[2 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_1[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020102u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_1[3 + pc.zero].val;
      debugPrintfEXT("iteration-2_0_1[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020103u) ? 0u : 1u);
      ssbo_0_1[3 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      const uint cullMask = 0xFF;
      const vec3 origin = vec3(260.0, 0.0, 0.0);
      const vec3 direction = vec3(0.0, 0.0, 1.0);
      const float tmin = 1.0;
      const float tmax = 10.0;
      uint candidateFound = 0u;
      rayQueryEXT rq;
      rayQueryInitializeEXT(rq, accelerationStructure_0_1[4 + pc.zero], gl_RayFlagsNoneEXT, cullMask, origin, tmin, direction, tmax);
      while (rayQueryProceedEXT(rq)) {
        const uint candidateType = rayQueryGetIntersectionTypeEXT(rq, false);
        if (candidateType == gl_RayQueryCandidateIntersectionTriangleEXT || candidateType == gl_RayQueryCandidateIntersectionAABBEXT) {
          candidateFound = 1u;
        }
      }
      anyError |= ((candidateFound == 1u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[5 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-2_0_1[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020105u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_1[6 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-2_0_1[6 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020106u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_1[6 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[2], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_query : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[7]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;
layout (push_constant, std430) uniform PushConstantBlock { uint zero; } pc;

layout (set=0, binding=0, r32ui) uniform uimageBuffer storageTexel_0_0;
layout (set=0, binding=1, r32ui) uniform uimageBuffer storageTexel_0_1[7];
layout (set=0, binding=1) uniform uboBlock_0_1 { uint val; } ubo_0_1[7];
layout (set=0, binding=1) buffer sboBlock_0_1 { uint val; } ssbo_0_1[7];
layout (set=0, binding=1) uniform accelerationStructureEXT accelerationStructure_0_1[7];
layout (set=0, binding=1) uniform utexture2D sampledImage_0_1[7];
layout (set=0, binding=1, r32ui) uniform uimage2D storageImage_0_1[7];
layout (set=0, binding=1) uniform utextureBuffer uniformTexel_0_1[7];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[3], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageTexel_0_0, 0).x;
      debugPrintfEXT("iteration-3_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0, 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_1[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_1[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030100u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_1[0 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_1[1 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_1[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030101u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_1[2 + pc.zero].val;
      debugPrintfEXT("iteration-3_0_1[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030102u) ? 0u : 1u);
      ssbo_0_1[2 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      const uint cullMask = 0xFF;
      const vec3 origin = vec3(259.0, 0.0, 0.0);
      const vec3 direction = vec3(0.0, 0.0, 1.0);
      const float tmin = 1.0;
      const float tmax = 10.0;
      uint candidateFound = 0u;
      rayQueryEXT rq;
      rayQueryInitializeEXT(rq, accelerationStructure_0_1[3 + pc.zero], gl_RayFlagsNoneEXT, cullMask, origin, tmin, direction, tmax);
      while (rayQueryProceedEXT(rq)) {
        const uint candidateType = rayQueryGetIntersectionTypeEXT(rq, false);
        if (candidateType == gl_RayQueryCandidateIntersectionTriangleEXT || candidateType == gl_RayQueryCandidateIntersectionAABBEXT) {
          candidateFound = 1u;
        }
      }
      anyError |= ((candidateFound == 1u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[4 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-3_0_1[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030104u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_1[5 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-3_0_1[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030105u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_1[5 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_1[6 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_1[6 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030106u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[3], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_query : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[7]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;
layout (push_constant, std430) uniform PushConstantBlock { uint zero; } pc;

layout (set=0, binding=0) uniform uboBlock_0_0 { uint val; } ubo_0_0;
layout (set=0, binding=1) uniform uboBlock_0_1 { uint val; } ubo_0_1[7];
layout (set=0, binding=1) buffer sboBlock_0_1 { uint val; } ssbo_0_1[7];
layout (set=0, binding=1) uniform accelerationStructureEXT accelerationStructure_0_1[7];
layout (set=0, binding=1) uniform utexture2D sampledImage_0_1[7];
layout (set=0, binding=1, r32ui) uniform uimage2D storageImage_0_1[7];
layout (set=0, binding=1) uniform utextureBuffer uniformTexel_0_1[7];
layout (set=0, binding=1, r32ui) uniform uimageBuffer storageTexel_0_1[7];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[4], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ubo_0_0.val;
      debugPrintfEXT("iteration-4_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040000u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_1[0 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_1[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040100u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_1[1 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_1[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040101u) ? 0u : 1u);
      ssbo_0_1[1 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      const uint cullMask = 0xFF;
      const vec3 origin = vec3(258.0, 0.0, 0.0);
      const vec3 direction = vec3(0.0, 0.0, 1.0);
      const float tmin = 1.0;
      const float tmax = 10.0;
      uint candidateFound = 0u;
      rayQueryEXT rq;
      rayQueryInitializeEXT(rq, accelerationStructure_0_1[2 + pc.zero], gl_RayFlagsNoneEXT, cullMask, origin, tmin, direction, tmax);
      while (rayQueryProceedEXT(rq)) {
        const uint candidateType = rayQueryGetIntersectionTypeEXT(rq, false);
        if (candidateType == gl_RayQueryCandidateIntersectionTriangleEXT || candidateType == gl_RayQueryCandidateIntersectionAABBEXT) {
          candidateFound = 1u;
        }
      }
      anyError |= ((candidateFound == 1u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[3 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-4_0_1[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040103u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_1[4 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-4_0_1[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040104u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_1[4 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_1[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_1[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040105u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_1[6 + pc.zero], 0).x;
      debugPrintfEXT("iteration-4_0_1[6 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040106u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_1[6 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[4], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_query : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[7]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;
layout (push_constant, std430) uniform PushConstantBlock { uint zero; } pc;

layout (set=0, binding=0) buffer sboBlock_0_0 { uint val; } ssbo_0_0;
layout (set=0, binding=1) buffer sboBlock_0_1 { uint val; } ssbo_0_1[7];
layout (set=0, binding=1) uniform accelerationStructureEXT accelerationStructure_0_1[7];
layout (set=0, binding=1) uniform utexture2D sampledImage_0_1[7];
layout (set=0, binding=1, r32ui) uniform uimage2D storageImage_0_1[7];
layout (set=0, binding=1) uniform utextureBuffer uniformTexel_0_1[7];
layout (set=0, binding=1, r32ui) uniform uimageBuffer storageTexel_0_1[7];
layout (set=0, binding=1) uniform uboBlock_0_1 { uint val; } ubo_0_1[7];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[5], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ssbo_0_0.val;
      debugPrintfEXT("iteration-5_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050000u) ? 0u : 1u);
      ssbo_0_0.val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_1[0 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_1[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050100u) ? 0u : 1u);
      ssbo_0_1[0 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      const uint cullMask = 0xFF;
      const vec3 origin = vec3(257.0, 0.0, 0.0);
      const vec3 direction = vec3(0.0, 0.0, 1.0);
      const float tmin = 1.0;
      const float tmax = 10.0;
      uint candidateFound = 0u;
      rayQueryEXT rq;
      rayQueryInitializeEXT(rq, accelerationStructure_0_1[1 + pc.zero], gl_RayFlagsNoneEXT, cullMask, origin, tmin, direction, tmax);
      while (rayQueryProceedEXT(rq)) {
        const uint candidateType = rayQueryGetIntersectionTypeEXT(rq, false);
        if (candidateType == gl_RayQueryCandidateIntersectionTriangleEXT || candidateType == gl_RayQueryCandidateIntersectionAABBEXT) {
          candidateFound = 1u;
        }
      }
      anyError |= ((candidateFound == 1u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[2 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-5_0_1[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050102u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_1[3 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-5_0_1[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050103u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_1[3 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_1[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_1[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050104u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_1[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-5_0_1[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050105u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_1[5 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_1[6 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_1[6 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050106u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[5], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_query : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[7]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;
layout (push_constant, std430) uniform PushConstantBlock { uint zero; } pc;

layout (set=0, binding=0) uniform accelerationStructureEXT accelerationStructure_0_0;
layout (set=0, binding=1) uniform accelerationStructureEXT accelerationStructure_0_1[7];
layout (set=0, binding=1) uniform utexture2D sampledImage_0_1[7];
layout (set=0, binding=1, r32ui) uniform uimage2D storageImage_0_1[7];
layout (set=0, binding=1) uniform utextureBuffer uniformTexel_0_1[7];
layout (set=0, binding=1, r32ui) uniform uimageBuffer storageTexel_0_1[7];
layout (set=0, binding=1) uniform uboBlock_0_1 { uint val; } ubo_0_1[7];
layout (set=0, binding=1) buffer sboBlock_0_1 { uint val; } ssbo_0_1[7];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[6], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      const uint cullMask = 0xFF;
      const vec3 origin = vec3(0.0, 0.0, 0.0);
      const vec3 direction = vec3(0.0, 0.0, 1.0);
      const float tmin = 1.0;
      const float tmax = 10.0;
      uint candidateFound = 0u;
      rayQueryEXT rq;
      rayQueryInitializeEXT(rq, accelerationStructure_0_0, gl_RayFlagsNoneEXT, cullMask, origin, tmin, direction, tmax);
      while (rayQueryProceedEXT(rq)) {
        const uint candidateType = rayQueryGetIntersectionTypeEXT(rq, false);
        if (candidateType == gl_RayQueryCandidateIntersectionTriangleEXT || candidateType == gl_RayQueryCandidateIntersectionAABBEXT) {
          candidateFound = 1u;
        }
      }
      anyError |= ((candidateFound == 1u) ? 0u : 1u);
    }
    {
      const uint cullMask = 0xFF;
      const vec3 origin = vec3(256.0, 0.0, 0.0);
      const vec3 direction = vec3(0.0, 0.0, 1.0);
      const float tmin = 1.0;
      const float tmax = 10.0;
      uint candidateFound = 0u;
      rayQueryEXT rq;
      rayQueryInitializeEXT(rq, accelerationStructure_0_1[0 + pc.zero], gl_RayFlagsNoneEXT, cullMask, origin, tmin, direction, tmax);
      while (rayQueryProceedEXT(rq)) {
        const uint candidateType = rayQueryGetIntersectionTypeEXT(rq, false);
        if (candidateType == gl_RayQueryCandidateIntersectionTriangleEXT || candidateType == gl_RayQueryCandidateIntersectionAABBEXT) {
          candidateFound = 1u;
        }
      }
      anyError |= ((candidateFound == 1u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[1 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-6_0_1[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a060101u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_1[2 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-6_0_1[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a060102u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_1[2 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_1[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-6_0_1[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a060103u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_1[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-6_0_1[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a060104u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_1[4 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_1[5 + pc.zero].val;
      debugPrintfEXT("iteration-6_0_1[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a060105u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_1[6 + pc.zero].val;
      debugPrintfEXT("iteration-6_0_1[6 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a060106u) ? 0u : 1u);
      ssbo_0_1[6 + pc.zero].val = (readValue | 0xff000000u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[6], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_query : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[7]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;
layout (push_constant, std430) uniform PushConstantBlock { uint zero; } pc;

layout (set=0, binding=0) uniform utexture2D sampledImage_0_0;
layout (set=0, binding=1) uniform utexture2D sampledImage_0_1[7];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(usampler2D(sampledImage_0_0, externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[0 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_1[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000100u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[1 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_1[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000101u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[2 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_1[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000102u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[3 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_1[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000103u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[4 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_1[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000104u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[5 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_1[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000105u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[6 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_1[6 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000106u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_query : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[7]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;
layout (push_constant, std430) uniform PushConstantBlock { uint zero; } pc;

layout (set=0, binding=0, r32ui) uniform uimage2D storageImage_0_0;
layout (set=0, binding=1, r32ui) uniform uimage2D storageImage_0_1[7];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageImage_0_0, ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0, ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_1[0 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_1[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010100u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_1[0 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_1[1 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_1[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010101u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_1[1 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_1[2 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_1[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010102u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_1[2 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_1[3 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_1[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010103u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_1[3 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_1[4 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_1[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010104u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_1[4 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_1[5 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_1[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010105u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_1[5 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_1[6 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_1[6 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010106u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_1[6 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_query : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[7]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;
layout (push_constant, std430) uniform PushConstantBlock { uint zero; } pc;

layout (set=0, binding=0) uniform utextureBuffer uniformTexel_0_0;
layout (set=0, binding=1) uniform utextureBuffer uniformTexel_0_1[7];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[2], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texelFetch(uniformTexel_0_0, 0).x;
      debugPrintfEXT("iteration-2_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020000u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_1[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_1[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020100u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_1[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_1[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020101u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_1[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_1[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020102u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_1[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_1[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020103u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_1[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_1[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020104u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_1[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_1[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020105u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_1[6 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_1[6 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020106u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[2], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_query : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[7]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;
layout (push_constant, std430) uniform PushConstantBlock { uint zero; } pc;

layout (set=0, binding=0, r32ui) uniform uimageBuffer storageTexel_0_0;
layout (set=0, binding=1, r32ui) uniform uimageBuffer storageTexel_0_1[7];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[3], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageTexel_0_0, 0).x;
      debugPrintfEXT("iteration-3_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0, 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_1[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_1[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030100u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_1[0 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_1[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_1[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030101u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_1[1 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_1[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_1[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030102u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_1[2 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_1[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_1[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030103u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_1[3 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_1[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_1[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030104u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_1[4 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_1[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_1[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030105u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_1[5 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_1[6 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_1[6 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030106u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_1[6 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[3], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_query : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[7]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;
layout (push_constant, std430) uniform PushConstantBlock { uint zero; } pc;

layout (set=0, binding=0) uniform uboBlock_0_0 { uint val; } ubo_0_0;
layout (set=0, binding=1) uniform uboBlock_0_1 { uint val; } ubo_0_1[7];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[4], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ubo_0_0.val;
      debugPrintfEXT("iteration-4_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040000u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_1[0 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_1[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040100u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_1[1 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_1[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040101u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_1[2 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_1[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040102u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_1[3 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_1[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040103u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_1[4 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_1[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040104u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_1[5 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_1[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040105u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_1[6 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_1[6 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040106u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[4], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_query : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[7]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;
layout (push_constant, std430) uniform PushConstantBlock { uint zero; } pc;

layout (set=0, binding=0) buffer sboBlock_0_0 { uint val; } ssbo_0_0;
layout (set=0, binding=1) buffer sboBlock_0_1 { uint val; } ssbo_0_1[7];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[5], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ssbo_0_0.val;
      debugPrintfEXT("iteration-5_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050000u) ? 0u : 1u);
      ssbo_0_0.val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_1[0 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_1[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050100u) ? 0u : 1u);
      ssbo_0_1[0 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_1[1 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_1[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050101u) ? 0u : 1u);
      ssbo_0_1[1 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_1[2 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_1[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050102u) ? 0u : 1u);
      ssbo_0_1[2 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_1[3 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_1[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050103u) ? 0u : 1u);
      ssbo_0_1[3 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_1[4 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_1[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050104u) ? 0u : 1u);
      ssbo_0_1[4 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_1[5 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_1[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050105u) ? 0u : 1u);
      ssbo_0_1[5 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_1[6 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_1[6 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050106u) ? 0u : 1u);
      ssbo_0_1[6 + pc.zero].val = (readValue | 0xff000000u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[5], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable
#extension GL_EXT_ray_query : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[7]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;
layout (push_constant, std430) uniform PushConstantBlock { uint zero; } pc;

layout (set=0, binding=0) uniform accelerationStructureEXT accelerationStructure_0_0;
layout (set=0, binding=1) uniform accelerationStructureEXT accelerationStructure_0_1[7];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[6], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      const uint cullMask = 0xFF;
      const vec3 origin = vec3(0.0, 0.0, 0.0);
      const vec3 direction = vec3(0.0, 0.0, 1.0);
      const float tmin = 1.0;
      const float tmax = 10.0;
      uint candidateFound = 0u;
      rayQueryEXT rq;
      rayQueryInitializeEXT(rq, accelerationStructure_0_0, gl_RayFlagsNoneEXT, cullMask, origin, tmin, direction, tmax);
      while (rayQueryProceedEXT(rq)) {
        const uint candidateType = rayQueryGetIntersectionTypeEXT(rq, false);
        if (candidateType == gl_RayQueryCandidateIntersectionTriangleEXT || candidateType == gl_RayQueryCandidateIntersectionAABBEXT) {
          candidateFound = 1u;
        }
      }
      anyError |= ((candidateFound == 1u) ? 0u : 1u);
    }
    {
      const uint cullMask = 0xFF;
      const vec3 origin = vec3(256.0, 0.0, 0.0);
      const vec3 direction = vec3(0.0, 0.0, 1.0);
      const float tmin = 1.0;
      const float tmax = 10.0;
      uint candidateFound = 0u;
      rayQueryEXT rq;
      rayQueryInitializeEXT(rq, accelerationStructure_0_1[0 + pc.zero], gl_RayFlagsNoneEXT, cullMask, origin, tmin, direction, tmax);
      while (rayQueryProceedEXT(rq)) {
        const uint candidateType = rayQueryGetIntersectionTypeEXT(rq, false);
        if (candidateType == gl_RayQueryCandidateIntersectionTriangleEXT || candidateType == gl_RayQueryCandidateIntersectionAABBEXT) {
          candidateFound = 1u;
        }
      }
      anyError |= ((candidateFound == 1u) ? 0u : 1u);
    }
    {
      const uint cullMask = 0xFF;
      const vec3 origin = vec3(257.0, 0.0, 0.0);
      const vec3 direction = vec3(0.0, 0.0, 1.0);
      const float tmin = 1.0;
      const float tmax = 10.0;
      uint candidateFound = 0u;
      rayQueryEXT rq;
      rayQueryInitializeEXT(rq, accelerationStructure_0_1[1 + pc.zero], gl_RayFlagsNoneEXT, cullMask, origin, tmin, direction, tmax);
      while (rayQueryProceedEXT(rq)) {
        const uint candidateType = rayQueryGetIntersectionTypeEXT(rq, false);
        if (candidateType == gl_RayQueryCandidateIntersectionTriangleEXT || candidateType == gl_RayQueryCandidateIntersectionAABBEXT) {
          candidateFound = 1u;
        }
      }
      anyError |= ((candidateFound == 1u) ? 0u : 1u);
    }
    {
      const uint cullMask = 0xFF;
      const vec3 origin = vec3(258.0, 0.0, 0.0);
      const vec3 direction = vec3(0.0, 0.0, 1.0);
      const float tmin = 1.0;
      const float tmax = 10.0;
      uint candidateFound = 0u;
      rayQueryEXT rq;
      rayQueryInitializeEXT(rq, accelerationStructure_0_1[2 + pc.zero], gl_RayFlagsNoneEXT, cullMask, origin, tmin, direction, tmax);
      while (rayQueryProceedEXT(rq)) {
        const uint candidateType = rayQueryGetIntersectionTypeEXT(rq, false);
        if (candidateType == gl_RayQueryCandidateIntersectionTriangleEXT || candidateType == gl_RayQueryCandidateIntersectionAABBEXT) {
          candidateFound = 1u;
        }
      }
      anyError |= ((candidateFound == 1u) ? 0u : 1u);
    }
    {
      const uint cullMask = 0xFF;
      const vec3 origin = vec3(259.0, 0.0, 0.0);
      const vec3 direction = vec3(0.0, 0.0, 1.0);
      const float tmin = 1.0;
      const float tmax = 10.0;
      uint candidateFound = 0u;
      rayQueryEXT rq;
      rayQueryInitializeEXT(rq, accelerationStructure_0_1[3 + pc.zero], gl_RayFlagsNoneEXT, cullMask, origin, tmin, direction, tmax);
      while (rayQueryProceedEXT(rq)) {
        const uint candidateType = rayQueryGetIntersectionTypeEXT(rq, false);
        if (candidateType == gl_RayQueryCandidateIntersectionTriangleEXT || candidateType == gl_RayQueryCandidateIntersectionAABBEXT) {
          candidateFound = 1u;
        }
      }
      anyError |= ((candidateFound == 1u) ? 0u : 1u);
    }
    {
      const uint cullMask = 0xFF;
      const vec3 origin = vec3(260.0, 0.0, 0.0);
      const vec3 direction = vec3(0.0, 0.0, 1.0);
      const float tmin = 1.0;
      const float tmax = 10.0;
      uint candidateFound = 0u;
      rayQueryEXT rq;
      rayQueryInitializeEXT(rq, accelerationStructure_0_1[4 + pc.zero], gl_RayFlagsNoneEXT, cullMask, origin, tmin, direction, tmax);
      while (rayQueryProceedEXT(rq)) {
        const uint candidateType = rayQueryGetIntersectionTypeEXT(rq, false);
        if (candidateType == gl_RayQueryCandidateIntersectionTriangleEXT || candidateType == gl_RayQueryCandidateIntersectionAABBEXT) {
          candidateFound = 1u;
        }
      }
      anyError |= ((candidateFound == 1u) ? 0u : 1u);
    }
    {
      const uint cullMask = 0xFF;
      const vec3 origin = vec3(261.0, 0.0, 0.0);
      const vec3 direction = vec3(0.0, 0.0, 1.0);
      const float tmin = 1.0;
      const float tmax = 10.0;
      uint candidateFound = 0u;
      rayQueryEXT rq;
      rayQueryInitializeEXT(rq, accelerationStructure_0_1[5 + pc.zero], gl_RayFlagsNoneEXT, cullMask, origin, tmin, direction, tmax);
      while (rayQueryProceedEXT(rq)) {
        const uint candidateType = rayQueryGetIntersectionTypeEXT(rq, false);
        if (candidateType == gl_RayQueryCandidateIntersectionTriangleEXT || candidateType == gl_RayQueryCandidateIntersectionAABBEXT) {
          candidateFound = 1u;
        }
      }
      anyError |= ((candidateFound == 1u) ? 0u : 1u);
    }
    {
      const uint cullMask = 0xFF;
      const vec3 origin = vec3(262.0, 0.0, 0.0);
      const vec3 direction = vec3(0.0, 0.0, 1.0);
      const float tmin = 1.0;
      const float tmax = 10.0;
      uint candidateFound = 0u;
      rayQueryEXT rq;
      rayQueryInitializeEXT(rq, accelerationStructure_0_1[6 + pc.zero], gl_RayFlagsNoneEXT, cullMask, origin, tmin, direction, tmax);
      while (rayQueryProceedEXT(rq)) {
        const uint candidateType = rayQueryGetIntersectionTypeEXT(rq, false);
        if (candidateType == gl_RayQueryCandidateIntersectionTriangleEXT || candidateType == gl_RayQueryCandidateIntersectionAABBEXT) {
          candidateFound = 1u;
        }
      }
      anyError |= ((candidateFound == 1u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[6], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[7]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;

layout (set=0, binding=0) uniform utexture2D sampledImage_0_0;
layout (set=0, binding=1) uniform utexture2D sampledImage_0_1[7];
layout (set=0, binding=1, r32ui) uniform uimage2D storageImage_0_1[7];
layout (set=0, binding=1) uniform utextureBuffer uniformTexel_0_1[7];
layout (set=0, binding=1, r32ui) uniform uimageBuffer storageTexel_0_1[7];
layout (set=0, binding=1) uniform uboBlock_0_1 { uint val; } ubo_0_1[7];
layout (set=0, binding=1) buffer sboBlock_0_1 { uint val; } ssbo_0_1[7];
layout (set=0, binding=1) uniform usampler2D combinedSampler_0_1[7];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(usampler2D(sampledImage_0_0, externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[0], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_1[0]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000100u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_1[1], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-0_0_1[1]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000101u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_1[1], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_1[2], 0).x;
      debugPrintfEXT("iteration-0_0_1[2]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000102u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_1[3], 0).x;
      debugPrintfEXT("iteration-0_0_1[3]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000103u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_1[3], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_1[4].val;
      debugPrintfEXT("iteration-0_0_1[4]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000104u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_1[5].val;
      debugPrintfEXT("iteration-0_0_1[5]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000105u) ? 0u : 1u);
      ssbo_0_1[5].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(combinedSampler_0_1[6], vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_1[6]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000106u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[7]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;

layout (set=0, binding=0, r32ui) uniform uimage2D storageImage_0_0;
layout (set=0, binding=1, r32ui) uniform uimage2D storageImage_0_1[7];
layout (set=0, binding=1) uniform utextureBuffer uniformTexel_0_1[7];
layout (set=0, binding=1, r32ui) uniform uimageBuffer storageTexel_0_1[7];
layout (set=0, binding=1) uniform uboBlock_0_1 { uint val; } ubo_0_1[7];
layout (set=0, binding=1) buffer sboBlock_0_1 { uint val; } ssbo_0_1[7];
layout (set=0, binding=1) uniform usampler2D combinedSampler_0_1[7];
layout (set=0, binding=1) uniform utexture2D sampledImage_0_1[7];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageImage_0_0, ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0, ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_1[0], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_1[0]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010100u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_1[0], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_1[1], 0).x;
      debugPrintfEXT("iteration-1_0_1[1]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010101u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_1[2], 0).x;
      debugPrintfEXT("iteration-1_0_1[2]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010102u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_1[2], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_1[3].val;
      debugPrintfEXT("iteration-1_0_1[3]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010103u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_1[4].val;
      debugPrintfEXT("iteration-1_0_1[4]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010104u) ? 0u : 1u);
      ssbo_0_1[4].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(combinedSampler_0_1[5], vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_1[5]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010105u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[6], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-1_0_1[6]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010106u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[7]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;

layout (set=0, binding=0) uniform utextureBuffer uniformTexel_0_0;
layout (set=0, binding=1) uniform utextureBuffer uniformTexel_0_1[7];
layout (set=0, binding=1, r32ui) uniform uimageBuffer storageTexel_0_1[7];
layout (set=0, binding=1) uniform uboBlock_0_1 { uint val; } ubo_0_1[7];
layout (set=0, binding=1) buffer sboBlock_0_1 { uint val; } ssbo_0_1[7];
layout (set=0, binding=1) uniform usampler2D combinedSampler_0_1[7];
layout (set=0, binding=1) uniform utexture2D sampledImage_0_1[7];
layout (set=0, binding=1, r32ui) uniform uimage2D storageImage_0_1[7];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[2], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texelFetch(uniformTexel_0_0, 0).x;
      debugPrintfEXT("iteration-2_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020000u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_1[0], 0).x;
      debugPrintfEXT("iteration-2_0_1[0]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020100u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_1[1], 0).x;
      debugPrintfEXT("iteration-2_0_1[1]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020101u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_1[1], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_1[2].val;
      debugPrintfEXT("iteration-2_0_1[2]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020102u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_1[3].val;
      debugPrintfEXT("iteration-2_0_1[3]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020103u) ? 0u : 1u);
      ssbo_0_1[3].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(combinedSampler_0_1[4], vec2(0, 0)).r;
      debugPrintfEXT("iteration-2_0_1[4]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020104u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[5], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-2_0_1[5]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020105u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_1[6], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-2_0_1[6]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020106u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_1[6], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[2], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[7]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;

layout (set=0, binding=0, r32ui) uniform uimageBuffer storageTexel_0_0;
layout (set=0, binding=1, r32ui) uniform uimageBuffer storageTexel_0_1[7];
layout (set=0, binding=1) uniform uboBlock_0_1 { uint val; } ubo_0_1[7];
layout (set=0, binding=1) buffer sboBlock_0_1 { uint val; } ssbo_0_1[7];
layout (set=0, binding=1) uniform usampler2D combinedSampler_0_1[7];
layout (set=0, binding=1) uniform utexture2D sampledImage_0_1[7];
layout (set=0, binding=1, r32ui) uniform uimage2D storageImage_0_1[7];
layout (set=0, binding=1) uniform utextureBuffer uniformTexel_0_1[7];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[3], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageTexel_0_0, 0).x;
      debugPrintfEXT("iteration-3_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0, 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_1[0], 0).x;
      debugPrintfEXT("iteration-3_0_1[0]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030100u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_1[0], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_1[1].val;
      debugPrintfEXT("iteration-3_0_1[1]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030101u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_1[2].val;
      debugPrintfEXT("iteration-3_0_1[2]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030102u) ? 0u : 1u);
      ssbo_0_1[2].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(combinedSampler_0_1[3], vec2(0, 0)).r;
      debugPrintfEXT("iteration-3_0_1[3]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030103u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[4], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-3_0_1[4]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030104u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_1[5], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-3_0_1[5]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030105u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_1[5], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_1[6], 0).x;
      debugPrintfEXT("iteration-3_0_1[6]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030106u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[3], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[7]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;

layout (set=0, binding=0) uniform uboBlock_0_0 { uint val; } ubo_0_0;
layout (set=0, binding=1) uniform uboBlock_0_1 { uint val; } ubo_0_1[7];
layout (set=0, binding=1) buffer sboBlock_0_1 { uint val; } ssbo_0_1[7];
layout (set=0, binding=1) uniform usampler2D combinedSampler_0_1[7];
layout (set=0, binding=1) uniform utexture2D sampledImage_0_1[7];
layout (set=0, binding=1, r32ui) uniform uimage2D storageImage_0_1[7];
layout (set=0, binding=1) uniform utextureBuffer uniformTexel_0_1[7];
layout (set=0, binding=1, r32ui) uniform uimageBuffer storageTexel_0_1[7];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[4], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ubo_0_0.val;
      debugPrintfEXT("iteration-4_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040000u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_1[0].val;
      debugPrintfEXT("iteration-4_0_1[0]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040100u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_1[1].val;
      debugPrintfEXT("iteration-4_0_1[1]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040101u) ? 0u : 1u);
      ssbo_0_1[1].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(combinedSampler_0_1[2], vec2(0, 0)).r;
      debugPrintfEXT("iteration-4_0_1[2]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040102u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[3], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-4_0_1[3]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040103u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_1[4], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-4_0_1[4]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040104u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_1[4], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_1[5], 0).x;
      debugPrintfEXT("iteration-4_0_1[5]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040105u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_1[6], 0).x;
      debugPrintfEXT("iteration-4_0_1[6]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040106u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_1[6], 0, uvec4(readValue, 0, 0, 0));
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[4], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[7]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;

layout (set=0, binding=0) buffer sboBlock_0_0 { uint val; } ssbo_0_0;
layout (set=0, binding=1) buffer sboBlock_0_1 { uint val; } ssbo_0_1[7];
layout (set=0, binding=1) uniform usampler2D combinedSampler_0_1[7];
layout (set=0, binding=1) uniform utexture2D sampledImage_0_1[7];
layout (set=0, binding=1, r32ui) uniform uimage2D storageImage_0_1[7];
layout (set=0, binding=1) uniform utextureBuffer uniformTexel_0_1[7];
layout (set=0, binding=1, r32ui) uniform uimageBuffer storageTexel_0_1[7];
layout (set=0, binding=1) uniform uboBlock_0_1 { uint val; } ubo_0_1[7];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[5], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ssbo_0_0.val;
      debugPrintfEXT("iteration-5_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050000u) ? 0u : 1u);
      ssbo_0_0.val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_1[0].val;
      debugPrintfEXT("iteration-5_0_1[0]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050100u) ? 0u : 1u);
      ssbo_0_1[0].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = texture(combinedSampler_0_1[1], vec2(0, 0)).r;
      debugPrintfEXT("iteration-5_0_1[1]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050101u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[2], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-5_0_1[2]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050102u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_1[3], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-5_0_1[3]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050103u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_1[3], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_1[4], 0).x;
      debugPrintfEXT("iteration-5_0_1[4]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050104u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_1[5], 0).x;
      debugPrintfEXT("iteration-5_0_1[5]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050105u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_1[5], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_1[6].val;
      debugPrintfEXT("iteration-5_0_1[6]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050106u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[5], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[7]; } outputBuffer;
layout (set=1, binding=1) uniform sampler externalSampler;

layout (set=0, binding=0) uniform usampler2D combinedSampler_0_0;
layout (set=0, binding=1) uniform usampler2D combinedSampler_0_1[7];
layout (set=0, binding=1) uniform utexture2D sampledImage_0_1[7];
layout (set=0, binding=1, r32ui) uniform uimage2D storageImage_0_1[7];
layout (set=0, binding=1) uniform utextureBuffer uniformTexel_0_1[7];
layout (set=0, binding=1, r32ui) uniform uimageBuffer storageTexel_0_1[7];
layout (set=0, binding=1) uniform uboBlock_0_1 { uint val; } ubo_0_1[7];
layout (set=0, binding=1) buffer sboBlock_0_1 { uint val; } ssbo_0_1[7];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[6], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(combinedSampler_0_0, vec2(0, 0)).r;
      debugPrintfEXT("iteration-6_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a060000u) ? 0u : 1u);
    }
    {
      uint readValue = texture(combinedSampler_0_1[0], vec2(0, 0)).r;
      debugPrintfEXT("iteration-6_0_1[0]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a060100u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[1], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-6_0_1[1]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a060101u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageImage_0_1[2], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-6_0_1[2]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a060102u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_1[2], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = texelFetch(uniformTexel_0_1[3], 0).x;
      debugPrintfEXT("iteration-6_0_1[3]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a060103u) ? 0u : 1u);
    }
    {
      uint readValue = imageLoad(storageTexel_0_1[4], 0).x;
      debugPrintfEXT("iteration-6_0_1[4]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a060104u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_1[4], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = ubo_0_1[5].val;
      debugPrintfEXT("iteration-6_0_1[5]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a060105u) ? 0u : 1u);
    }
    {
      uint readValue = ssbo_0_1[6].val;
      debugPrintfEXT("iteration-6_0_1[6]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a060106u) ? 0u : 1u);
      ssbo_0_1[6].val = (readValue | 0xff000000u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[6], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[7]; } outputBuffer;
layout (set=1, binding=1) uniform utexture2D externalSampledImage;
layout (set=1, binding=2) uniform sampler externalSampler;

layout (set=0, binding=0) uniform utexture2D sampledImage_0_0;
layout (set=0, binding=1) uniform utexture2D sampledImage_0_1[7];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(usampler2D(sampledImage_0_0, externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[0], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_1[0]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000100u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[1], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_1[1]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000101u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[2], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_1[2]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000102u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[3], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_1[3]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000103u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[4], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_1[4]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000104u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[5], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_1[5]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000105u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[6], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_1[6]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000106u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[7]; } outputBuffer;
layout (set=1, binding=1) uniform utexture2D externalSampledImage;
layout (set=1, binding=2) uniform sampler externalSampler;

layout (set=0, binding=0, r32ui) uniform uimage2D storageImage_0_0;
layout (set=0, binding=1, r32ui) uniform uimage2D storageImage_0_1[7];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageImage_0_0, ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0, ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_1[0], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_1[0]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010100u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_1[0], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_1[1], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_1[1]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010101u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_1[1], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_1[2], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_1[2]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010102u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_1[2], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_1[3], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_1[3]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010103u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_1[3], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_1[4], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_1[4]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010104u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_1[4], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_1[5], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_1[5]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010105u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_1[5], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_1[6], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_1[6]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010106u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_1[6], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[7]; } outputBuffer;
layout (set=1, binding=1) uniform utexture2D externalSampledImage;
layout (set=1, binding=2) uniform sampler externalSampler;

layout (set=0, binding=0) uniform utextureBuffer uniformTexel_0_0;
layout (set=0, binding=1) uniform utextureBuffer uniformTexel_0_1[7];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[2], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texelFetch(uniformTexel_0_0, 0).x;
      debugPrintfEXT("iteration-2_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020000u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_1[0], 0).x;
      debugPrintfEXT("iteration-2_0_1[0]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020100u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_1[1], 0).x;
      debugPrintfEXT("iteration-2_0_1[1]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020101u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_1[2], 0).x;
      debugPrintfEXT("iteration-2_0_1[2]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020102u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_1[3], 0).x;
      debugPrintfEXT("iteration-2_0_1[3]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020103u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_1[4], 0).x;
      debugPrintfEXT("iteration-2_0_1[4]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020104u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_1[5], 0).x;
      debugPrintfEXT("iteration-2_0_1[5]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020105u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_1[6], 0).x;
      debugPrintfEXT("iteration-2_0_1[6]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020106u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[2], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[7]; } outputBuffer;
layout (set=1, binding=1) uniform utexture2D externalSampledImage;
layout (set=1, binding=2) uniform sampler externalSampler;

layout (set=0, binding=0, r32ui) uniform uimageBuffer storageTexel_0_0;
layout (set=0, binding=1, r32ui) uniform uimageBuffer storageTexel_0_1[7];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[3], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageTexel_0_0, 0).x;
      debugPrintfEXT("iteration-3_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0, 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_1[0], 0).x;
      debugPrintfEXT("iteration-3_0_1[0]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030100u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_1[0], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_1[1], 0).x;
      debugPrintfEXT("iteration-3_0_1[1]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030101u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_1[1], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_1[2], 0).x;
      debugPrintfEXT("iteration-3_0_1[2]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030102u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_1[2], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_1[3], 0).x;
      debugPrintfEXT("iteration-3_0_1[3]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030103u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_1[3], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_1[4], 0).x;
      debugPrintfEXT("iteration-3_0_1[4]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030104u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_1[4], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_1[5], 0).x;
      debugPrintfEXT("iteration-3_0_1[5]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030105u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_1[5], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_1[6], 0).x;
      debugPrintfEXT("iteration-3_0_1[6]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030106u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_1[6], 0, uvec4(readValue, 0, 0, 0));
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[3], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[7]; } outputBuffer;
layout (set=1, binding=1) uniform utexture2D externalSampledImage;
layout (set=1, binding=2) uniform sampler externalSampler;

layout (set=0, binding=0) uniform uboBlock_0_0 { uint val; } ubo_0_0;
layout (set=0, binding=1) uniform uboBlock_0_1 { uint val; } ubo_0_1[7];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[4], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ubo_0_0.val;
      debugPrintfEXT("iteration-4_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040000u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_1[0].val;
      debugPrintfEXT("iteration-4_0_1[0]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040100u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_1[1].val;
      debugPrintfEXT("iteration-4_0_1[1]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040101u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_1[2].val;
      debugPrintfEXT("iteration-4_0_1[2]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040102u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_1[3].val;
      debugPrintfEXT("iteration-4_0_1[3]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040103u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_1[4].val;
      debugPrintfEXT("iteration-4_0_1[4]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040104u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_1[5].val;
      debugPrintfEXT("iteration-4_0_1[5]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040105u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_1[6].val;
      debugPrintfEXT("iteration-4_0_1[6]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040106u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[4], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[7]; } outputBuffer;
layout (set=1, binding=1) uniform utexture2D externalSampledImage;
layout (set=1, binding=2) uniform sampler externalSampler;

layout (set=0, binding=0) buffer sboBlock_0_0 { uint val; } ssbo_0_0;
layout (set=0, binding=1) buffer sboBlock_0_1 { uint val; } ssbo_0_1[7];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[5], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ssbo_0_0.val;
      debugPrintfEXT("iteration-5_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050000u) ? 0u : 1u);
      ssbo_0_0.val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_1[0].val;
      debugPrintfEXT("iteration-5_0_1[0]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050100u) ? 0u : 1u);
      ssbo_0_1[0].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_1[1].val;
      debugPrintfEXT("iteration-5_0_1[1]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050101u) ? 0u : 1u);
      ssbo_0_1[1].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_1[2].val;
      debugPrintfEXT("iteration-5_0_1[2]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050102u) ? 0u : 1u);
      ssbo_0_1[2].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_1[3].val;
      debugPrintfEXT("iteration-5_0_1[3]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050103u) ? 0u : 1u);
      ssbo_0_1[3].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_1[4].val;
      debugPrintfEXT("iteration-5_0_1[4]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050104u) ? 0u : 1u);
      ssbo_0_1[4].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_1[5].val;
      debugPrintfEXT("iteration-5_0_1[5]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050105u) ? 0u : 1u);
      ssbo_0_1[5].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_1[6].val;
      debugPrintfEXT("iteration-5_0_1[6]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050106u) ? 0u : 1u);
      ssbo_0_1[6].val = (readValue | 0xff000000u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[5], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[7]; } outputBuffer;
layout (set=1, binding=1) uniform utexture2D externalSampledImage;
layout (set=1, binding=2) uniform sampler externalSampler;

layout (set=0, binding=0) uniform sampler sampler_0_0;
layout (set=0, binding=1) uniform sampler sampler_0_1[7];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[6], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(usampler2D(externalSampledImage, sampler_0_0), vec2(0, 0)).r;
      debugPrintfEXT("iteration-6_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x41322314u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(externalSampledImage, sampler_0_1[0]), vec2(0, 0)).r;
      debugPrintfEXT("iteration-6_0_1[0]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x41322314u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(externalSampledImage, sampler_0_1[1]), vec2(0, 0)).r;
      debugPrintfEXT("iteration-6_0_1[1]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x41322314u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(externalSampledImage, sampler_0_1[2]), vec2(0, 0)).r;
      debugPrintfEXT("iteration-6_0_1[2]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x41322314u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(externalSampledImage, sampler_0_1[3]), vec2(0, 0)).r;
      debugPrintfEXT("iteration-6_0_1[3]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x41322314u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(externalSampledImage, sampler_0_1[4]), vec2(0, 0)).r;
      debugPrintfEXT("iteration-6_0_1[4]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x41322314u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(externalSampledImage, sampler_0_1[5]), vec2(0, 0)).r;
      debugPrintfEXT("iteration-6_0_1[5]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x41322314u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(externalSampledImage, sampler_0_1[6]), vec2(0, 0)).r;
      debugPrintfEXT("iteration-6_0_1[6]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x41322314u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[6], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[7]; } outputBuffer;
layout (set=1, binding=1) uniform utexture2D externalSampledImage;
layout (set=1, binding=2) uniform sampler externalSampler;
layout (push_constant, std430) uniform PushConstantBlock { uint zero; } pc;

layout (set=0, binding=0) uniform utexture2D sampledImage_0_0;
layout (set=0, binding=1) uniform utexture2D sampledImage_0_1[7];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[0], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(usampler2D(sampledImage_0_0, externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000000u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[0 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_1[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000100u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[1 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_1[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000101u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[2 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_1[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000102u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[3 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_1[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000103u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[4 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_1[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000104u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[5 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_1[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000105u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(sampledImage_0_1[6 + pc.zero], externalSampler), vec2(0, 0)).r;
      debugPrintfEXT("iteration-0_0_1[6 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a000106u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[0], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[7]; } outputBuffer;
layout (set=1, binding=1) uniform utexture2D externalSampledImage;
layout (set=1, binding=2) uniform sampler externalSampler;
layout (push_constant, std430) uniform PushConstantBlock { uint zero; } pc;

layout (set=0, binding=0, r32ui) uniform uimage2D storageImage_0_0;
layout (set=0, binding=1, r32ui) uniform uimage2D storageImage_0_1[7];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[1], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageImage_0_0, ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_0, ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_1[0 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_1[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010100u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_1[0 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_1[1 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_1[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010101u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_1[1 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_1[2 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_1[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010102u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_1[2 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_1[3 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_1[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010103u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_1[3 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_1[4 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_1[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010104u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_1[4 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_1[5 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_1[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010105u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_1[5 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageImage_0_1[6 + pc.zero], ivec2(0, 0)).x;
      debugPrintfEXT("iteration-1_0_1[6 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a010106u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageImage_0_1[6 + pc.zero], ivec2(0, 0), uvec4(readValue, 0, 0, 0));
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[1], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[7]; } outputBuffer;
layout (set=1, binding=1) uniform utexture2D externalSampledImage;
layout (set=1, binding=2) uniform sampler externalSampler;
layout (push_constant, std430) uniform PushConstantBlock { uint zero; } pc;

layout (set=0, binding=0) uniform utextureBuffer uniformTexel_0_0;
layout (set=0, binding=1) uniform utextureBuffer uniformTexel_0_1[7];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[2], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texelFetch(uniformTexel_0_0, 0).x;
      debugPrintfEXT("iteration-2_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020000u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_1[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_1[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020100u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_1[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_1[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020101u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_1[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_1[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020102u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_1[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_1[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020103u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_1[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_1[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020104u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_1[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_1[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020105u) ? 0u : 1u);
    }
    {
      uint readValue = texelFetch(uniformTexel_0_1[6 + pc.zero], 0).x;
      debugPrintfEXT("iteration-2_0_1[6 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a020106u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[2], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[7]; } outputBuffer;
layout (set=1, binding=1) uniform utexture2D externalSampledImage;
layout (set=1, binding=2) uniform sampler externalSampler;
layout (push_constant, std430) uniform PushConstantBlock { uint zero; } pc;

layout (set=0, binding=0, r32ui) uniform uimageBuffer storageTexel_0_0;
layout (set=0, binding=1, r32ui) uniform uimageBuffer storageTexel_0_1[7];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[3], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = imageLoad(storageTexel_0_0, 0).x;
      debugPrintfEXT("iteration-3_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030000u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_0, 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_1[0 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_1[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030100u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_1[0 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_1[1 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_1[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030101u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_1[1 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_1[2 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_1[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030102u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_1[2 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_1[3 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_1[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030103u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_1[3 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_1[4 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_1[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030104u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_1[4 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_1[5 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_1[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030105u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_1[5 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    {
      uint readValue = imageLoad(storageTexel_0_1[6 + pc.zero], 0).x;
      debugPrintfEXT("iteration-3_0_1[6 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a030106u) ? 0u : 1u);
      readValue |= 0xff000000u;
      imageStore(storageTexel_0_1[6 + pc.zero], 0, uvec4(readValue, 0, 0, 0));
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[3], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[7]; } outputBuffer;
layout (set=1, binding=1) uniform utexture2D externalSampledImage;
layout (set=1, binding=2) uniform sampler externalSampler;
layout (push_constant, std430) uniform PushConstantBlock { uint zero; } pc;

layout (set=0, binding=0) uniform uboBlock_0_0 { uint val; } ubo_0_0;
layout (set=0, binding=1) uniform uboBlock_0_1 { uint val; } ubo_0_1[7];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[4], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ubo_0_0.val;
      debugPrintfEXT("iteration-4_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040000u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_1[0 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_1[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040100u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_1[1 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_1[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040101u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_1[2 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_1[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040102u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_1[3 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_1[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040103u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_1[4 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_1[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040104u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_1[5 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_1[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040105u) ? 0u : 1u);
    }
    {
      uint readValue = ubo_0_1[6 + pc.zero].val;
      debugPrintfEXT("iteration-4_0_1[6 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a040106u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[4], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[7]; } outputBuffer;
layout (set=1, binding=1) uniform utexture2D externalSampledImage;
layout (set=1, binding=2) uniform sampler externalSampler;
layout (push_constant, std430) uniform PushConstantBlock { uint zero; } pc;

layout (set=0, binding=0) buffer sboBlock_0_0 { uint val; } ssbo_0_0;
layout (set=0, binding=1) buffer sboBlock_0_1 { uint val; } ssbo_0_1[7];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[5], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = ssbo_0_0.val;
      debugPrintfEXT("iteration-5_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050000u) ? 0u : 1u);
      ssbo_0_0.val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_1[0 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_1[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050100u) ? 0u : 1u);
      ssbo_0_1[0 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_1[1 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_1[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050101u) ? 0u : 1u);
      ssbo_0_1[1 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_1[2 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_1[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050102u) ? 0u : 1u);
      ssbo_0_1[2 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_1[3 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_1[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050103u) ? 0u : 1u);
      ssbo_0_1[3 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_1[4 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_1[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050104u) ? 0u : 1u);
      ssbo_0_1[4 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_1[5 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_1[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050105u) ? 0u : 1u);
      ssbo_0_1[5 + pc.zero].val = (readValue | 0xff000000u);
    }
    {
      uint readValue = ssbo_0_1[6 + pc.zero].val;
      debugPrintfEXT("iteration-5_0_1[6 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x5a050106u) ? 0u : 1u);
      ssbo_0_1[6 + pc.zero].val = (readValue | 0xff000000u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[5], 1u);
    }
  }
}
#version 460
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_debug_printf : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=1, binding=0) buffer OutputBufferBlock { uint value[7]; } outputBuffer;
layout (set=1, binding=1) uniform utexture2D externalSampledImage;
layout (set=1, binding=2) uniform sampler externalSampler;
layout (push_constant, std430) uniform PushConstantBlock { uint zero; } pc;

layout (set=0, binding=0) uniform sampler sampler_0_0;
layout (set=0, binding=1) uniform sampler sampler_0_1[7];

void main() {
  const uint flag = atomicCompSwap(outputBuffer.value[6], 0u, 1u);
  if (flag == 0u) {
    uint anyError = 0u;
    {
      uint readValue = texture(usampler2D(externalSampledImage, sampler_0_0), vec2(0, 0)).r;
      debugPrintfEXT("iteration-6_0_0: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x41322314u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(externalSampledImage, sampler_0_1[0 + pc.zero]), vec2(0, 0)).r;
      debugPrintfEXT("iteration-6_0_1[0 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x41322314u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(externalSampledImage, sampler_0_1[1 + pc.zero]), vec2(0, 0)).r;
      debugPrintfEXT("iteration-6_0_1[1 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x41322314u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(externalSampledImage, sampler_0_1[2 + pc.zero]), vec2(0, 0)).r;
      debugPrintfEXT("iteration-6_0_1[2 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x41322314u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(externalSampledImage, sampler_0_1[3 + pc.zero]), vec2(0, 0)).r;
      debugPrintfEXT("iteration-6_0_1[3 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x41322314u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(externalSampledImage, sampler_0_1[4 + pc.zero]), vec2(0, 0)).r;
      debugPrintfEXT("iteration-6_0_1[4 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x41322314u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(externalSampledImage, sampler_0_1[5 + pc.zero]), vec2(0, 0)).r;
      debugPrintfEXT("iteration-6_0_1[5 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x41322314u) ? 0u : 1u);
    }
    {
      uint readValue = texture(usampler2D(externalSampledImage, sampler_0_1[6 + pc.zero]), vec2(0, 0)).r;
      debugPrintfEXT("iteration-6_0_1[6 + pc.zero]: 0x%xu\n", readValue);
      anyError |= ((readValue == 0x41322314u) ? 0u : 1u);
    }
    if (anyError == 0u) {
      atomicAdd(outputBuffer.value[6], 1u);
    }
  }
}
