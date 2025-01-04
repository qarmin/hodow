#version 460
#extension GL_EXT_tessellation_shader : require
layout (push_constant, std430) uniform PCBlock { float red; float green; float blue; } pc;
layout(triangles) in;
in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4 gl_Position;
};
layout (location=0) out vec4 outColor;
void main() {
    outColor = vec4(pc.red, pc.green, pc.blue, 1.0);
    gl_Position = (gl_in[0].gl_Position * gl_TessCoord.x + 
                   gl_in[1].gl_Position * gl_TessCoord.y + 
                   gl_in[2].gl_Position * gl_TessCoord.z);
}
