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
layout (location=0) in int inInstanceIndex[3];
layout (location=1) in float inRedOffset[3];
layout (location=0) out flat int outInstanceIndex;
layout (location=1) out flat float outRedOffset;
void main() {
    for (int i = 0; i < 3; ++i) {
        const float xCoordFactor = 1.0;
        gl_Position = vec4(gl_in[i].gl_Position.x * xCoordFactor, gl_in[i].gl_Position.yzw);
        outInstanceIndex = inInstanceIndex[i];
        outRedOffset = inRedOffset[i];
        EmitVertex();
    }
}
