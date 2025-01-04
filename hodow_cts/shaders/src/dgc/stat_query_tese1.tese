#version 460
#extension GL_EXT_tessellation_shader : require
layout (triangles) in;
in gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
};
layout (location=0) in vec4 inColor[];
layout (location=0) out vec4 outColor;
void main(void) {
    gl_Position = (gl_in[0].gl_Position * gl_TessCoord.x +
                   gl_in[1].gl_Position * gl_TessCoord.y +
                   gl_in[2].gl_Position * gl_TessCoord.z);
    gl_PointSize = gl_in[0].gl_PointSize;
    outColor = vec4(1.0 - inColor[0].r, 1.0 - inColor[0].g, 1.0 - inColor[0].b, inColor[0].a);
}
