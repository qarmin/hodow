#version 450 core

layout(set = 0, binding = 0) buffer coherent block {
   uint ssbo_val;
};

layout(location=0) in vec2 position;
layout(location=0) out uint patch_index;

void main() {
   gl_Position = vec4(position, 0.0, 1.0);
   patch_index = gl_InstanceIndex;

   /*
    * RADV groups TCS wave in workgroups similar to compute ones.
    *
    * This test assumes that the TCS workgroup has at most 256 invocations (64 patches). Try to
    * cause the first wave of the workgroup to start the TCS much later than ones which write
    * non-zero factors.
    *
    * This loop makes the test much more likely to fail.
   */
   uint wave32_in_workgroup = patch_index % 64u / 8u;
   uint threshold = patch_index / 64u % 8u;
   if (wave32_in_workgroup <= threshold) {
      /*for (uint i = 0; i < 8192; i++) {
         patch_index += (i & 0x1) == 0 ? -1 : 1;
      }*/
      for (uint i = 0; i < 160; i++)
         atomicAdd(ssbo_val, i);
   }
}
