#version 460
layout (vertices=3) out;
in gl_PerVertex
{
  vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
  vec4 gl_Position;
  float gl_PointSize;
} gl_out[];
layout (location=0, component=0) in  float tcInA[];
layout (location=0, component=1) in  float tcInB[];
layout (location=0, component=2) in  vec2  tcInCD[];
layout (location=1)              in  vec4  tcInEFGH[];
layout (location=0, component=0) out float tcOutA[];
layout (location=0, component=1) out float tcOutB[];
layout (location=0, component=2) out vec2  tcOutCD[];
layout (location=1)              out vec4  tcOutEFGH[];
void main() {
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    gl_out[gl_InvocationID].gl_PointSize = 1.0;
    tcOutA[gl_InvocationID]    = tcInA[gl_InvocationID];
    tcOutB[gl_InvocationID]    = tcInB[gl_InvocationID];
    tcOutCD[gl_InvocationID]   = tcInCD[gl_InvocationID];
    tcOutEFGH[gl_InvocationID] = tcInEFGH[gl_InvocationID];
}
