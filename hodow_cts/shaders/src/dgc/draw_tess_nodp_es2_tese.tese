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
layout (location=0) in int inInstanceIndex[];
layout (location=1) in float inRedOffset[];
layout (location=0) out flat int outInstanceIndex;
layout (location=1) out flat float outRedOffset;
void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    outInstanceIndex = inInstanceIndex[0];
    outRedOffset = inRedOffset[0];
}
