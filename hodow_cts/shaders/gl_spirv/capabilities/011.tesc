#version 450

layout (vertices = 3) out;
layout (location = 3) in vec2 texCoordIn[];
layout (location = 3) out vec2 texCoordOut[];

void main()
{
    if (gl_InvocationID == 0) {
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelInner[0] = 1.0;
    }

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
    texCoordOut[gl_InvocationID] = texCoordIn[gl_InvocationID];
}
