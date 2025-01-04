#version 460
const vec2 positions[4] = vec2[](
    vec2(-1.0 + 0.015625, -1.0 + 0.015625),
    vec2(-1.0 + 0.015625,  1.0 - 0.015625),
    vec2( 1.0 - 0.015625, -1.0 + 0.015625),
    vec2( 1.0 - 0.015625,  1.0 - 0.015625)
);
layout (vertices=3) out;
void main() {
    if (gl_InvocationID >= gl_PatchVerticesIn) {
        gl_out[gl_InvocationID].gl_Position  = vec4(positions[3], 0.0, 1.0);
        gl_out[gl_InvocationID].gl_PointSize = 1.0;
    }
    else {
        gl_out[gl_InvocationID].gl_Position  = gl_in[gl_InvocationID].gl_Position;
        gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
    }
    if (gl_InvocationID == 0) {
        gl_TessLevelOuter[0] = 3.25;
        gl_TessLevelOuter[1] = 5.25;
        gl_TessLevelOuter[2] = 7.25;
        gl_TessLevelOuter[3] = 9.25;
        gl_TessLevelInner[0] = 3.25;
        gl_TessLevelInner[1] = 5.25;
    }
}
