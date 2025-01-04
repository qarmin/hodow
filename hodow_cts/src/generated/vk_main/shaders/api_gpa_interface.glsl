#version 460
layout (local_size_x=64) in;
layout (set=0, binding=0, std430) buffer BufferBlock { uint values[]; } ssbo;
void main(void) { ssbo.values[gl_GlobalInvocationID.x] = 1u; }
#version 460
out gl_PerVertex {
    vec4 gl_Position;
};
layout (location=0) in vec4 inPos;
layout (location=0) out vec4 outColor;
void main(void) {
    gl_Position = inPos;
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
}
#version 460
layout (location=0) in vec4 inColor;
layout (location=0) out vec4 outColor;
void main(void) {
    outColor = inColor;
}
#version 460
#extension GL_EXT_tessellation_shader : require
layout(vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
    vec4 gl_Position;
} gl_out[];
void main() {
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
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
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4 gl_Position;
};
layout (location=0) out vec4 outColor;
void main() {
    outColor = vec4(0.0, 1.0, 1.0, 1.0);
    gl_Position = (gl_in[0].gl_Position * gl_TessCoord.x + 
                   gl_in[1].gl_Position * gl_TessCoord.y + 
                   gl_in[2].gl_Position * gl_TessCoord.z);
}
#version 460
layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex {
    vec4 gl_Position;
} gl_in[3];
out gl_PerVertex {
    vec4 gl_Position;
};
layout (location=0) out vec4 outColor;
void main() {
    for (uint i = 0; i < 3; ++i) {
        outColor = vec4(1.0, 1.0, 1.0, 1.0);
        gl_Position = gl_in[i].gl_Position;
        EmitVertex();
    }
}
