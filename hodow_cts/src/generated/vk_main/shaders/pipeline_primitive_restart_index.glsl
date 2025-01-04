#version 460
layout (location=0) in vec4 inPos;
out gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
};
void main(void) {
    gl_Position = inPos;
    gl_PointSize = 1.0;
}
#version 460
layout (location=0) out vec4 outColor;
layout (push_constant) uniform PCBlock { vec4 color; } pc;
void main(void) {
    outColor = pc.color;
}
#version 460
#extension GL_EXT_tessellation_shader : require
layout(vertices=3) out;
in gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];
void main() {
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;
}
#version 460
#extension GL_EXT_tessellation_shader : require
layout(triangles) in;
in gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
};
void main() {
    gl_Position = (gl_in[0].gl_Position * gl_TessCoord.x +
                   gl_in[1].gl_Position * gl_TessCoord.y +
                   gl_in[2].gl_Position * gl_TessCoord.z);
    gl_PointSize = gl_in[0].gl_PointSize;
}
