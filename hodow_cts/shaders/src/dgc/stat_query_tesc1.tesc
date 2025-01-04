#version 460
#extension GL_EXT_tessellation_shader : require
layout (vertices=3) out;
layout (location=0) in vec4 inColor[];
layout (location=0) out vec4 outColor[];
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];
void main(void) {
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;
    outColor[gl_InvocationID] = vec4(inColor[gl_InvocationID].r, 1.0, inColor[gl_InvocationID].ba);
}
