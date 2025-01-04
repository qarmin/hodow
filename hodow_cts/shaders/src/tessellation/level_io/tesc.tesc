#version 450
#extension GL_EXT_tessellation_shader : require

layout (vertices = 4) out;

layout (location=0) out patch vec4 perPatchColor;

in gl_PerVertex {
    vec4  gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
} gl_out[];

void main ()
{
   perPatchColor = (gl_PrimitiveID == 0) ? vec4(0.0, 0.0, 1.0, 1.0) : vec4(1.0, 1.0, 0.0, 1.0);
   gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
${levels}}
