#version 460
layout (triangles, fractional_odd_spacing, cw) in;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void) {
    gl_Position  = (gl_TessCoord.x * gl_in[0].gl_Position) +
                   (gl_TessCoord.y * gl_in[1].gl_Position) +
                   (gl_TessCoord.z * gl_in[2].gl_Position);
}
