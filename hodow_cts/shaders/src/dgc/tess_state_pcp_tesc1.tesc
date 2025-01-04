#version 460
layout (vertices=4) out;
void main (void) {
    const bool goodPVI = (gl_PatchVerticesIn == 4);
    const float posOffset = (goodPVI ? 0.0 : 10.0);

    gl_out[gl_InvocationID].gl_Position  = gl_in[gl_InvocationID].gl_Position + posOffset;
    gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;

    const float extraLevels = 1.0;
    if (gl_InvocationID == 0) {
        gl_TessLevelOuter[0] = 3.0 + extraLevels;
        gl_TessLevelOuter[1] = 5.0 + extraLevels;
        gl_TessLevelOuter[2] = 7.0 + extraLevels;
        gl_TessLevelOuter[3] = 9.0 + extraLevels;
        gl_TessLevelInner[0] = 3.0 + extraLevels;
        gl_TessLevelInner[1] = 5.0 + extraLevels;
    }
}
