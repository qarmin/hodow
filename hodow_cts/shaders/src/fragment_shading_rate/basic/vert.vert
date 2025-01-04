#version 450 core
#extension GL_EXT_fragment_shading_rate : enable
#extension GL_ARB_shader_viewport_layer_array : enable
layout(push_constant) uniform PC {
    int shadingRate;
} pc;
layout(location = 0) in vec2 pos;
layout(location = 0) out int instanceIndex;
layout(location = 1) out int readbackok;
layout(location = 2) out float zero;
out gl_PerVertex
{
   vec4 gl_Position;
};
void main()
{
  float vtxDepth = ${'0.4' if vtx_depth else '0.0'};
  gl_Position = vec4(pos, vtxDepth, 1);
  instanceIndex = gl_InstanceIndex;
  readbackok = 1;
  zero = 0;
${('  gl_PrimitiveShadingRateEXT = pc.shadingRate;\n  if (gl_PrimitiveShadingRateEXT != pc.shadingRate) readbackok = 0;\n' + ('' if geometry_shader else (('  gl_ViewportIndex = instanceIndex & 1;\n' if multi_viewport else '') + ('  gl_Layer = ((instanceIndex & 2) >> 1);\n' if color_layered else '')))) if shader_writes_rate else ''}}
