#version 460
layout (quads, point_mode) in;
layout (location=0) out vec4 vertColor;
void main (void) {
    const bool goodPVI = (gl_PatchVerticesIn == 4);
    const float posOffset = (goodPVI ? 0.0 : 10.0);

    const float u = gl_TessCoord.x;
    const float v = gl_TessCoord.y;
    const vec4 p0 = gl_in[0].gl_Position;
    const vec4 p1 = gl_in[1].gl_Position;
    const vec4 p2 = gl_in[2].gl_Position;
    const vec4 p3 = gl_in[3].gl_Position;
    gl_Position = ((1 - u) * (1 - v) * p0 + (1 - u) * v * p1 + u * (1 - v) * p2 + u * v * p3) + posOffset;
    gl_PointSize = 1.0;
    vertColor = vec4(0.0, 1.0, 1.0, 1.0);
}
