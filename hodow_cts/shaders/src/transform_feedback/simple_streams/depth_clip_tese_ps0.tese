#version 450
layout(triangles, ccw) in;
in gl_PerVertex
{
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
layout(xfb_buffer = 0, xfb_offset = 0) out gl_PerVertex
{
    vec4 gl_Position;
};

void main (void)
{
    vec4 p0 = gl_TessCoord.x * gl_in[0].gl_Position;
    vec4 p1 = gl_TessCoord.y * gl_in[1].gl_Position;
    vec4 p2 = gl_TessCoord.z * gl_in[2].gl_Position;
    gl_Position = p0 + p1 + p2;
}
