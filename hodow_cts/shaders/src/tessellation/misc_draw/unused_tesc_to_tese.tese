#version 460
layout (triangles, equal_spacing, ccw) in;
in gl_PerVertex
{
  vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
  vec4 gl_Position;
};
layout (location=0, component=0) in  float teInA[];
layout (location=0, component=1) in  float teInB[];
layout (location=0, component=2) in  vec2  teInCD[];
layout (location=1)              in  vec4  teInEFGH[];
layout (location=0, component=0) out float teOutA;
layout (location=0, component=1) out float teOutB;
layout (location=0, component=2) out vec2  teOutCD;
layout (location=1)              out vec4  teOutEFGH;
void main() {
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position
                + gl_TessCoord.y * gl_in[1].gl_Position
                + gl_TessCoord.z * gl_in[2].gl_Position;
    teOutA    = teInA[0];
    teOutB    = teInB[0];
    teOutCD   = teInCD[0];
    teOutEFGH = teInEFGH[0];
}
