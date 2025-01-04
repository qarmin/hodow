#version 450 core

/*
 * For the workgroup barriers to be optimized to wave ones, each TCS output patch must be part of a
 * single wave.
 */
layout(vertices = 4) out;

layout(location=0) in uint patch_index_in[];

void main() {
   gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

   /* The compiler must either know that all invocations define tessellation levels or that a
    * workgroup barrier exists. This test ensures that both are true.
    */
   barrier();

   /*
    * We assume that the TCS workgroup has 256 invocations (64 patches). All waves in the workgroup
    * will discard all patches except for the last. If the timing is right, the bug causes the
    * factors of the last wave to be dismissed when determining whether all waves in the workgroup
    * write zero as a factor.
   */
   uint patch_index = patch_index_in[gl_InvocationID];
   uint wave32_in_workgroup = patch_index % 64u / 8u;
   if (wave32_in_workgroup == 7) {
      uint index_in_wave32 = patch_index % 8u;
      uint workgroup_index = patch_index / 64u;
      uint index = (workgroup_index * 8u) + index_in_wave32;
      uint grid_size = 256;
      vec2 pos = (vec2(index % grid_size, index / grid_size) + gl_out[gl_InvocationID].gl_Position.xy);
      gl_out[gl_InvocationID].gl_Position.xy = pos / float(grid_size) * 2.0 - 1.0;

      gl_TessLevelOuter = float[4](1.0, 1.0, 1.0, 1.0);
   } else {
      gl_TessLevelOuter = float[4](0.0, 0.0, 0.0, 0.0);
   }
   gl_TessLevelInner = float[2](0.0, 0.0);
}
