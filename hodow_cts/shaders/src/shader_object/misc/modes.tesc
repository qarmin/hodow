#version 450

layout(vertices = 4) out;

void main (void)
{
    if (gl_InvocationID == 0) {
    float subdivision = float(${subdivision});
        gl_TessLevelInner[0] = subdivision;
        gl_TessLevelInner[1] = subdivision;
        gl_TessLevelOuter[0] = subdivision;
        gl_TessLevelOuter[1] = subdivision;
        gl_TessLevelOuter[2] = subdivision;
        gl_TessLevelOuter[3] = subdivision;
    }
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
