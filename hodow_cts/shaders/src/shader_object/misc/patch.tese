#version 460
#extension GL_EXT_tessellation_shader : require
layout(quads) in;
in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4 gl_Position;
};
layout (location=1) patch in vec4 patchColor;
layout (location=0) out vec4 outColor;
void main() {
    outColor = patchColor;
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    float omu = 1.0f - u;
    float omv = 1.0f - v;
    gl_Position = omu * omv * gl_in[0].gl_Position +
                  u   * omv * gl_in[2].gl_Position +
                  u   * v   * gl_in[3].gl_Position +
                  omu * v   * gl_in[1].gl_Position;
}
