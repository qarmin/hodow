#version 460
layout (triangles, fractional_odd_spacing, cw) in;
layout (location=0) out float added;
layout (location=1) out float multiplied;
in gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void)
{
    vec4 pos     = (gl_TessCoord.x * gl_in[0].gl_Position) +
                   (gl_TessCoord.y * gl_in[1].gl_Position) +
                   (gl_TessCoord.z * gl_in[2].gl_Position);
    gl_Position  = pos;
    gl_PointSize = gl_in[0].gl_PointSize;
    added        = pos.x + 1000.0;
    multiplied   = pos.y * 1000.0;
}
