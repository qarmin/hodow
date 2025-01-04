#version 450
#extension GL_EXT_tessellation_shader : require
layout (vertices=6) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];

${dataStruct}

layout (location=0) in ${typePrefix} inData[]${typeSuffix};
layout (location=0) out ${typePrefix} outData[]${typeSuffix};

void main (void)
{
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    outData[gl_InvocationID] = inData[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
