#version 460
layout (location=0) in vec4 inPos;
out gl_PerVertex
{
    vec4 gl_Position;
};
void main (void) {
    gl_Position = inPos;
}
#version 460
layout (location=0) out vec4 outColor;
void main (void) {
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
}
#version 460
layout (vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
    vec4 gl_Position;
} gl_out[];
void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;
    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 460
layout (triangles, fractional_odd_spacing, cw) in;
in gl_PerVertex
{
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
    vec4 gl_Position;
};
void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
}
#version 460
layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
};
void main ()
{
    gl_Position = gl_in[0].gl_Position; EmitVertex();
    gl_Position = gl_in[1].gl_Position; EmitVertex();
    gl_Position = gl_in[2].gl_Position; EmitVertex();
}
#version 460
layout (location=0) in vec4 inPos;
layout (location=1) in vec4 inColor;
layout (location=0) out vec4 outColor;
void main (void) {
    gl_Position = inPos;
    outColor = inColor;
}
#version 460
layout (location=0) in vec4 inColor;
layout (location=0) out vec4 outColor;
void main (void) {
    outColor = inColor;
}
#version 460
layout (location=0) in vec4 inPos;
layout (location=1) in ivec4 inColor;
layout (location=0) out vec4 outColor;
void main (void) {
    gl_Position = inPos;
    outColor = vec4(inColor);
}
#version 450
layout (location=0) in vec4 inPos;
layout (location=1) in vec4 inColor;
layout (location=0) out vec4 outColor;
layout (set = 0, binding = 0) buffer ssbo {
    int data[];
} outData;
void main (void) {
    gl_Position = inPos;
    outColor = inColor;
    outData.data[gl_VertexIndex] = gl_VertexIndex + 1;
}
#version 450
layout (location=0) in vec4 inColor;
layout (location=0) out vec4 outColor;
void main (void) {
    outColor = inColor;
}
