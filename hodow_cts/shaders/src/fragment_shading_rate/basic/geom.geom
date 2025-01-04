#version 450 core
#extension GL_EXT_fragment_shading_rate : enable

layout(push_constant) uniform PC {
    int shadingRate;
} pc;

in gl_PerVertex
{
   vec4 gl_Position;
} gl_in[3];

layout(location = 0) in int inInstanceIndex[];
layout(location = 0) out int outInstanceIndex;
layout(location = 1) out int readbackok;
layout(location = 2) out float zero;
layout(triangles) in;
layout(triangle_strip, max_vertices=3) out;

out gl_PerVertex {
   vec4 gl_Position;
};

void main(void)
{
   gl_Position = gl_in[0].gl_Position;
   outInstanceIndex = inInstanceIndex[0];
   readbackok  = 1;
   zero = 0;
${shading_rate_writes}   EmitVertex();
   gl_Position = gl_in[1].gl_Position;
   outInstanceIndex = inInstanceIndex[1];
   readbackok = 1;
   zero = 0;
${shading_rate_writes}   EmitVertex();
   gl_Position = gl_in[2].gl_Position;
   outInstanceIndex = inInstanceIndex[2];
   readbackok = 1;
   zero = 0;
${shading_rate_writes}   EmitVertex();}
