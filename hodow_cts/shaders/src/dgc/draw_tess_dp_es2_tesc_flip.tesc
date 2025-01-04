#version 460
layout (vertices=3) out;
in gl_PerVertex
{
    vec4  gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
    vec4  gl_Position;
} gl_out[];
layout (location=0) in int inInstanceIndex[gl_MaxPatchVertices];
layout (location=1) in float inRedOffset[gl_MaxPatchVertices];
layout (location=3) in int inDrawIndex[gl_MaxPatchVertices];
layout (location=4) in int inBaseVertex[gl_MaxPatchVertices];
layout (location=5) in int inBaseInstance[gl_MaxPatchVertices];
layout (location=0) out int outInstanceIndex[];
layout (location=1) out float outRedOffset[];
layout (location=3) out int outDrawIndex[];
layout (location=4) out int outBaseVertex[];
layout (location=5) out int outBaseInstance[];
layout (location=2) in float inXCoordFactor[gl_MaxPatchVertices];
void main (void)
{
    const float xCoordFactor = inXCoordFactor[gl_InvocationID];
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;
    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;
    gl_out[gl_InvocationID].gl_Position = vec4(gl_in[gl_InvocationID].gl_Position.x * xCoordFactor, gl_in[gl_InvocationID].gl_Position.yzw);
    outInstanceIndex[gl_InvocationID] = inInstanceIndex[gl_InvocationID];
    outRedOffset[gl_InvocationID] = inRedOffset[gl_InvocationID];
    outDrawIndex[gl_InvocationID] = inDrawIndex[gl_InvocationID];
    outBaseVertex[gl_InvocationID] = inBaseVertex[gl_InvocationID];
    outBaseInstance[gl_InvocationID] = inBaseInstance[gl_InvocationID];
}
