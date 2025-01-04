#version 460
layout (local_size_x=64) in;
layout (push_constant, std430) uniform PCBlock { uint wgOffset; } pc;
layout (set=0, binding=0, std430) buffer BufferBlock {
    uint values[];
} ssbo;
void main(void) {
    uint global_id = (gl_WorkGroupID.x + pc.wgOffset) * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    ssbo.values[global_id] = 1u;
}
#version 460
layout (local_size_x=64) in;
layout (push_constant, std430) uniform PCBlock { uint wgOffset; } pc;
layout (set=0, binding=0, std430) buffer BufferBlock {
    uint values[];
} ssbo;
void main(void) {
    uint global_id = (gl_WorkGroupID.x + pc.wgOffset) * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    ssbo.values[global_id] = 2u;
}
#version 460
#extension GL_EXT_tessellation_shader : require
layout (vertices=3) out;
layout (location=0) in vec4 inColor[];
layout (location=0) out vec4 outColor[];
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];
void main(void) {
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;
    outColor[gl_InvocationID] = inColor[gl_InvocationID];
}
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
    outColor = inColor[0];
}
#version 460
layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
};
layout (location=0) in vec4 inColor[];
layout (location=0) out vec4 outColor;
void main() {
    for (uint i = 0; i < 3; ++i) {
        gl_Position = gl_in[i].gl_Position;
        gl_PointSize = gl_in[i].gl_PointSize;
        outColor = inColor[i];
        EmitVertex();
    }
}
#version 460
#extension GL_EXT_tessellation_shader : require
layout (vertices=3) out;
layout (location=0) in vec4 inColor[];
layout (location=0) out vec4 outColor[];
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];
void main(void) {
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;
    outColor[gl_InvocationID] = vec4(inColor[gl_InvocationID].r, 1.0, inColor[gl_InvocationID].ba);
}
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
#version 460
layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
};
layout (location=0) in vec4 inColor[];
layout (location=0) out vec4 outColor;
void main() {
    for (uint i = 0; i < 3; ++i) {
        gl_Position = gl_in[i].gl_Position;
        gl_PointSize = gl_in[i].gl_PointSize;
        outColor = inColor[i].gbra;
        EmitVertex();
    }
}
#version 460
layout (location=0) in vec4 inPos;
layout (location=0) out vec4 outColor;
out gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
};
void main(void) {
    gl_Position = inPos;
    gl_PointSize = 1.0;
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
}
#version 460
layout (location=0) in vec4 inColor;
layout (location=0) out vec4 outColor;
void main(void) {
    outColor = inColor;
}
#version 460
layout (location=0) in vec4 inPos;
layout (location=0) out vec4 outColor;
out gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
};
void main(void) {
    gl_Position = inPos;
    gl_PointSize = 1.0;
    outColor = vec4(1.0, 0.0, 1.0, 1.0);
}
#version 460
layout (location=0) in vec4 inColor;
layout (location=0) out vec4 outColor;
void main(void) {
    outColor = inColor.gbra;
}
