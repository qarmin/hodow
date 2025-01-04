#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) in vec4 position;

layout(binding = 0, std140) uniform InBuffer
{
    mat4 inMatrix[128];
};

layout(binding = 1, std430) buffer OutBuffer
{
    mat4 outMatrix[128];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};


out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    mat4 tmp = inMatrix[inIndex];
    outMatrix[outIndex] = tmp;
    gl_Position = position;
}
#version 440
precision highp float;
layout(location = 0) out vec4 fragColor;

void main (void)
{
    fragColor = vec4(1.0);
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) in vec4 position;

layout(binding = 0, std430) buffer InBuffer
{
    mat4 inMatrix[128];
};

layout(binding = 1, std430) buffer OutBuffer
{
    mat4 outMatrix[128];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};


out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    mat4 tmp = inMatrix[inIndex];
    outMatrix[outIndex] = tmp;
    gl_Position = position;
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) in vec4 position;

layout(binding = 0, std140) uniform InBuffer
{
    ivec4 inVecs[128][4];
};

layout(binding = 1, std430) buffer OutBuffer
{
    ivec4 outVecs[128][4];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};


out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    outVecs[outIndex][0] = inVecs[inIndex][0];
    outVecs[outIndex][1] = inVecs[inIndex][1];
    outVecs[outIndex][2] = inVecs[inIndex][2];
    outVecs[outIndex][3] = inVecs[inIndex][3];
    gl_Position = position;
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) in vec4 position;

layout(binding = 0, std430) buffer readonly InBuffer
{
    ivec4 inVecs[128][4];
};

layout(binding = 1, std430) buffer OutBuffer
{
    ivec4 outVecs[128][4];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};


out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    outVecs[outIndex][0] = inVecs[inIndex][0];
    outVecs[outIndex][1] = inVecs[inIndex][1];
    outVecs[outIndex][2] = inVecs[inIndex][2];
    outVecs[outIndex][3] = inVecs[inIndex][3];
    gl_Position = position;
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) in vec4 position;

layout(binding = 0, std140) uniform InBuffer
{
    uvec4 inVecs[128][4];
};

layout(binding = 1, std430) buffer OutBuffer
{
    uvec4 outVecs[128][4];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};


out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    outVecs[outIndex][0] = inVecs[inIndex][0];
    outVecs[outIndex][1] = inVecs[inIndex][1];
    outVecs[outIndex][2] = inVecs[inIndex][2];
    outVecs[outIndex][3] = inVecs[inIndex][3];
    gl_Position = position;
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) in vec4 position;

layout(binding = 0, std430) buffer readonly InBuffer
{
    uvec4 inVecs[128][4];
};

layout(binding = 1, std430) buffer OutBuffer
{
    uvec4 outVecs[128][4];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};


out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    outVecs[outIndex][0] = inVecs[inIndex][0];
    outVecs[outIndex][1] = inVecs[inIndex][1];
    outVecs[outIndex][2] = inVecs[inIndex][2];
    outVecs[outIndex][3] = inVecs[inIndex][3];
    gl_Position = position;
}
#version 440
#extension GL_EXT_texture_buffer : require
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
precision highp float;
layout(location = 0) in vec4 position;

layout(binding = 0, std140) uniform InBuffer
{
    i64vec4 inVecs[128][4];
};

layout(binding = 1, std430) buffer OutBuffer
{
    i64vec4 outVecs[128][4];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};


out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    outVecs[outIndex][0][0] = inVecs[inIndex][0][0];
    outVecs[outIndex][0][1] = inVecs[inIndex][0][1];
    outVecs[outIndex][0][2] = inVecs[inIndex][0][2];
    outVecs[outIndex][0][3] = inVecs[inIndex][0][3];
    outVecs[outIndex][1][0] = inVecs[inIndex][1][0];
    outVecs[outIndex][1][1] = inVecs[inIndex][1][1];
    outVecs[outIndex][1][2] = inVecs[inIndex][1][2];
    outVecs[outIndex][1][3] = inVecs[inIndex][1][3];
    outVecs[outIndex][2][0] = inVecs[inIndex][2][0];
    outVecs[outIndex][2][1] = inVecs[inIndex][2][1];
    outVecs[outIndex][2][2] = inVecs[inIndex][2][2];
    outVecs[outIndex][2][3] = inVecs[inIndex][2][3];
    outVecs[outIndex][3][0] = inVecs[inIndex][3][0];
    outVecs[outIndex][3][1] = inVecs[inIndex][3][1];
    outVecs[outIndex][3][2] = inVecs[inIndex][3][2];
    outVecs[outIndex][3][3] = inVecs[inIndex][3][3];
    gl_Position = position;
}
#version 440
#extension GL_EXT_texture_buffer : require
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
precision highp float;
layout(location = 0) in vec4 position;

layout(binding = 0, std430) buffer readonly InBuffer
{
    i64vec4 inVecs[128][4];
};

layout(binding = 1, std430) buffer OutBuffer
{
    i64vec4 outVecs[128][4];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};


out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    outVecs[outIndex][0][0] = inVecs[inIndex][0][0];
    outVecs[outIndex][0][1] = inVecs[inIndex][0][1];
    outVecs[outIndex][0][2] = inVecs[inIndex][0][2];
    outVecs[outIndex][0][3] = inVecs[inIndex][0][3];
    outVecs[outIndex][1][0] = inVecs[inIndex][1][0];
    outVecs[outIndex][1][1] = inVecs[inIndex][1][1];
    outVecs[outIndex][1][2] = inVecs[inIndex][1][2];
    outVecs[outIndex][1][3] = inVecs[inIndex][1][3];
    outVecs[outIndex][2][0] = inVecs[inIndex][2][0];
    outVecs[outIndex][2][1] = inVecs[inIndex][2][1];
    outVecs[outIndex][2][2] = inVecs[inIndex][2][2];
    outVecs[outIndex][2][3] = inVecs[inIndex][2][3];
    outVecs[outIndex][3][0] = inVecs[inIndex][3][0];
    outVecs[outIndex][3][1] = inVecs[inIndex][3][1];
    outVecs[outIndex][3][2] = inVecs[inIndex][3][2];
    outVecs[outIndex][3][3] = inVecs[inIndex][3][3];
    gl_Position = position;
}
#version 440
#extension GL_EXT_texture_buffer : require
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
precision highp float;
layout(location = 0) in vec4 position;

layout(binding = 0, std140) uniform InBuffer
{
    u64vec4 inVecs[128][4];
};

layout(binding = 1, std430) buffer OutBuffer
{
    u64vec4 outVecs[128][4];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};


out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    outVecs[outIndex][0][0] = inVecs[inIndex][0][0];
    outVecs[outIndex][0][1] = inVecs[inIndex][0][1];
    outVecs[outIndex][0][2] = inVecs[inIndex][0][2];
    outVecs[outIndex][0][3] = inVecs[inIndex][0][3];
    outVecs[outIndex][1][0] = inVecs[inIndex][1][0];
    outVecs[outIndex][1][1] = inVecs[inIndex][1][1];
    outVecs[outIndex][1][2] = inVecs[inIndex][1][2];
    outVecs[outIndex][1][3] = inVecs[inIndex][1][3];
    outVecs[outIndex][2][0] = inVecs[inIndex][2][0];
    outVecs[outIndex][2][1] = inVecs[inIndex][2][1];
    outVecs[outIndex][2][2] = inVecs[inIndex][2][2];
    outVecs[outIndex][2][3] = inVecs[inIndex][2][3];
    outVecs[outIndex][3][0] = inVecs[inIndex][3][0];
    outVecs[outIndex][3][1] = inVecs[inIndex][3][1];
    outVecs[outIndex][3][2] = inVecs[inIndex][3][2];
    outVecs[outIndex][3][3] = inVecs[inIndex][3][3];
    gl_Position = position;
}
#version 440
#extension GL_EXT_texture_buffer : require
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
precision highp float;
layout(location = 0) in vec4 position;

layout(binding = 0, std430) buffer readonly InBuffer
{
    u64vec4 inVecs[128][4];
};

layout(binding = 1, std430) buffer OutBuffer
{
    u64vec4 outVecs[128][4];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};


out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    outVecs[outIndex][0][0] = inVecs[inIndex][0][0];
    outVecs[outIndex][0][1] = inVecs[inIndex][0][1];
    outVecs[outIndex][0][2] = inVecs[inIndex][0][2];
    outVecs[outIndex][0][3] = inVecs[inIndex][0][3];
    outVecs[outIndex][1][0] = inVecs[inIndex][1][0];
    outVecs[outIndex][1][1] = inVecs[inIndex][1][1];
    outVecs[outIndex][1][2] = inVecs[inIndex][1][2];
    outVecs[outIndex][1][3] = inVecs[inIndex][1][3];
    outVecs[outIndex][2][0] = inVecs[inIndex][2][0];
    outVecs[outIndex][2][1] = inVecs[inIndex][2][1];
    outVecs[outIndex][2][2] = inVecs[inIndex][2][2];
    outVecs[outIndex][2][3] = inVecs[inIndex][2][3];
    outVecs[outIndex][3][0] = inVecs[inIndex][3][0];
    outVecs[outIndex][3][1] = inVecs[inIndex][3][1];
    outVecs[outIndex][3][2] = inVecs[inIndex][3][2];
    outVecs[outIndex][3][3] = inVecs[inIndex][3][3];
    gl_Position = position;
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) in vec4 position;

layout(binding = 0, std140) uniform InBuffer
{
    mat4 inMatrix[128];
};

layout(binding = 1, std430) buffer OutBuffer
{
    mat4 outMatrix[128];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};


out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    outMatrix[outIndex][0] = inMatrix[inIndex][0];
    outMatrix[outIndex][1] = inMatrix[inIndex][1];
    outMatrix[outIndex][2] = inMatrix[inIndex][2];
    outMatrix[outIndex][3] = inMatrix[inIndex][3];
    gl_Position = position;
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) in vec4 position;

layout(binding = 0, std430) buffer InBuffer
{
    mat4 inMatrix[128];
};

layout(binding = 1, std430) buffer OutBuffer
{
    mat4 outMatrix[128];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};


out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    outMatrix[outIndex][0] = inMatrix[inIndex][0];
    outMatrix[outIndex][1] = inMatrix[inIndex][1];
    outMatrix[outIndex][2] = inMatrix[inIndex][2];
    outMatrix[outIndex][3] = inMatrix[inIndex][3];
    gl_Position = position;
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) in vec4 position;

layout(binding = 0, std140) uniform InBuffer
{
    ivec4 inVec;
};

layout(binding = 1, std430) buffer OutBuffer
{
    ivec4 outVec;
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};


out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    outVec[outIndex] = inVec[inIndex];
    outVec[outIndex + 1] = inVec[inIndex + 1];
    outVec[outIndex + 2] = inVec[inIndex + 2];
    outVec[outIndex + 3] = inVec[inIndex + 3];
    gl_Position = position;
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) in vec4 position;

layout(binding = 0, std430) buffer readonly InBuffer
{
    ivec4 inVec;
};

layout(binding = 1, std430) buffer OutBuffer
{
    ivec4 outVec;
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};


out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    outVec[outIndex] = inVec[inIndex];
    outVec[outIndex + 1] = inVec[inIndex + 1];
    outVec[outIndex + 2] = inVec[inIndex + 2];
    outVec[outIndex + 3] = inVec[inIndex + 3];
    gl_Position = position;
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) in vec4 position;

layout(binding = 0, std140) uniform InBuffer
{
    uvec4 inVec;
};

layout(binding = 1, std430) buffer OutBuffer
{
    uvec4 outVec;
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};


out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    outVec[outIndex] = inVec[inIndex];
    outVec[outIndex + 1] = inVec[inIndex + 1];
    outVec[outIndex + 2] = inVec[inIndex + 2];
    outVec[outIndex + 3] = inVec[inIndex + 3];
    gl_Position = position;
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) in vec4 position;

layout(binding = 0, std430) buffer readonly InBuffer
{
    uvec4 inVec;
};

layout(binding = 1, std430) buffer OutBuffer
{
    uvec4 outVec;
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};


out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    outVec[outIndex] = inVec[inIndex];
    outVec[outIndex + 1] = inVec[inIndex + 1];
    outVec[outIndex + 2] = inVec[inIndex + 2];
    outVec[outIndex + 3] = inVec[inIndex + 3];
    gl_Position = position;
}
#version 440
#extension GL_EXT_texture_buffer : require
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
precision highp float;
layout(location = 0) in vec4 position;

layout(binding = 0, std140) uniform InBuffer
{
    i64vec4 inVec;
};

layout(binding = 1, std430) buffer OutBuffer
{
    i64vec4 outVec;
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};


out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    outVec[outIndex] = inVec[inIndex];
    outVec[outIndex + 1] = inVec[inIndex + 1];
    outVec[outIndex + 2] = inVec[inIndex + 2];
    outVec[outIndex + 3] = inVec[inIndex + 3];
    gl_Position = position;
}
#version 440
#extension GL_EXT_texture_buffer : require
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
precision highp float;
layout(location = 0) in vec4 position;

layout(binding = 0, std430) buffer readonly InBuffer
{
    i64vec4 inVec;
};

layout(binding = 1, std430) buffer OutBuffer
{
    i64vec4 outVec;
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};


out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    outVec[outIndex] = inVec[inIndex];
    outVec[outIndex + 1] = inVec[inIndex + 1];
    outVec[outIndex + 2] = inVec[inIndex + 2];
    outVec[outIndex + 3] = inVec[inIndex + 3];
    gl_Position = position;
}
#version 440
#extension GL_EXT_texture_buffer : require
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
precision highp float;
layout(location = 0) in vec4 position;

layout(binding = 0, std140) uniform InBuffer
{
    u64vec4 inVec;
};

layout(binding = 1, std430) buffer OutBuffer
{
    u64vec4 outVec;
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};


out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    outVec[outIndex] = inVec[inIndex];
    outVec[outIndex + 1] = inVec[inIndex + 1];
    outVec[outIndex + 2] = inVec[inIndex + 2];
    outVec[outIndex + 3] = inVec[inIndex + 3];
    gl_Position = position;
}
#version 440
#extension GL_EXT_texture_buffer : require
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
precision highp float;
layout(location = 0) in vec4 position;

layout(binding = 0, std430) buffer readonly InBuffer
{
    u64vec4 inVec;
};

layout(binding = 1, std430) buffer OutBuffer
{
    u64vec4 outVec;
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};


out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    outVec[outIndex] = inVec[inIndex];
    outVec[outIndex + 1] = inVec[inIndex + 1];
    outVec[outIndex + 2] = inVec[inIndex + 2];
    outVec[outIndex + 3] = inVec[inIndex + 3];
    gl_Position = position;
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) in vec4 position;

layout(binding = 0, std140) uniform InBuffer
{
    vec4 inVec;
};

layout(binding = 1, std430) buffer OutBuffer
{
    vec4 outVec;
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};


out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    outVec[outIndex] = inVec[inIndex];
    outVec[outIndex + 1] = inVec[inIndex + 1];
    outVec[outIndex + 2] = inVec[inIndex + 2];
    outVec[outIndex + 3] = inVec[inIndex + 3];
    gl_Position = position;
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) in vec4 position;

layout(binding = 0, std430) buffer readonly InBuffer
{
    vec4 inVec;
};

layout(binding = 1, std430) buffer OutBuffer
{
    vec4 outVec;
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};


out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    outVec[outIndex] = inVec[inIndex];
    outVec[outIndex + 1] = inVec[inIndex + 1];
    outVec[outIndex + 2] = inVec[inIndex + 2];
    outVec[outIndex + 3] = inVec[inIndex + 3];
    gl_Position = position;
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) in vec4 position;

layout(binding = 0, std140) uniform InBuffer
{
    ivec4 inVecs[128][4];
};

layout(binding = 1, std430) buffer OutBuffer
{
    ivec4 outVecs[128][4];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};


out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    outVecs[outIndex][0][0] = inVecs[inIndex][0][0];
    outVecs[outIndex][0][1] = inVecs[inIndex][0][1];
    outVecs[outIndex][0][2] = inVecs[inIndex][0][2];
    outVecs[outIndex][0][3] = inVecs[inIndex][0][3];
    outVecs[outIndex][1][0] = inVecs[inIndex][1][0];
    outVecs[outIndex][1][1] = inVecs[inIndex][1][1];
    outVecs[outIndex][1][2] = inVecs[inIndex][1][2];
    outVecs[outIndex][1][3] = inVecs[inIndex][1][3];
    outVecs[outIndex][2][0] = inVecs[inIndex][2][0];
    outVecs[outIndex][2][1] = inVecs[inIndex][2][1];
    outVecs[outIndex][2][2] = inVecs[inIndex][2][2];
    outVecs[outIndex][2][3] = inVecs[inIndex][2][3];
    outVecs[outIndex][3][0] = inVecs[inIndex][3][0];
    outVecs[outIndex][3][1] = inVecs[inIndex][3][1];
    outVecs[outIndex][3][2] = inVecs[inIndex][3][2];
    outVecs[outIndex][3][3] = inVecs[inIndex][3][3];
    gl_Position = position;
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) in vec4 position;

layout(binding = 0, std430) buffer readonly InBuffer
{
    ivec4 inVecs[128][4];
};

layout(binding = 1, std430) buffer OutBuffer
{
    ivec4 outVecs[128][4];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};


out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    outVecs[outIndex][0][0] = inVecs[inIndex][0][0];
    outVecs[outIndex][0][1] = inVecs[inIndex][0][1];
    outVecs[outIndex][0][2] = inVecs[inIndex][0][2];
    outVecs[outIndex][0][3] = inVecs[inIndex][0][3];
    outVecs[outIndex][1][0] = inVecs[inIndex][1][0];
    outVecs[outIndex][1][1] = inVecs[inIndex][1][1];
    outVecs[outIndex][1][2] = inVecs[inIndex][1][2];
    outVecs[outIndex][1][3] = inVecs[inIndex][1][3];
    outVecs[outIndex][2][0] = inVecs[inIndex][2][0];
    outVecs[outIndex][2][1] = inVecs[inIndex][2][1];
    outVecs[outIndex][2][2] = inVecs[inIndex][2][2];
    outVecs[outIndex][2][3] = inVecs[inIndex][2][3];
    outVecs[outIndex][3][0] = inVecs[inIndex][3][0];
    outVecs[outIndex][3][1] = inVecs[inIndex][3][1];
    outVecs[outIndex][3][2] = inVecs[inIndex][3][2];
    outVecs[outIndex][3][3] = inVecs[inIndex][3][3];
    gl_Position = position;
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) in vec4 position;

layout(binding = 0, std140) uniform InBuffer
{
    uvec4 inVecs[128][4];
};

layout(binding = 1, std430) buffer OutBuffer
{
    uvec4 outVecs[128][4];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};


out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    outVecs[outIndex][0][0] = inVecs[inIndex][0][0];
    outVecs[outIndex][0][1] = inVecs[inIndex][0][1];
    outVecs[outIndex][0][2] = inVecs[inIndex][0][2];
    outVecs[outIndex][0][3] = inVecs[inIndex][0][3];
    outVecs[outIndex][1][0] = inVecs[inIndex][1][0];
    outVecs[outIndex][1][1] = inVecs[inIndex][1][1];
    outVecs[outIndex][1][2] = inVecs[inIndex][1][2];
    outVecs[outIndex][1][3] = inVecs[inIndex][1][3];
    outVecs[outIndex][2][0] = inVecs[inIndex][2][0];
    outVecs[outIndex][2][1] = inVecs[inIndex][2][1];
    outVecs[outIndex][2][2] = inVecs[inIndex][2][2];
    outVecs[outIndex][2][3] = inVecs[inIndex][2][3];
    outVecs[outIndex][3][0] = inVecs[inIndex][3][0];
    outVecs[outIndex][3][1] = inVecs[inIndex][3][1];
    outVecs[outIndex][3][2] = inVecs[inIndex][3][2];
    outVecs[outIndex][3][3] = inVecs[inIndex][3][3];
    gl_Position = position;
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) in vec4 position;

layout(binding = 0, std430) buffer readonly InBuffer
{
    uvec4 inVecs[128][4];
};

layout(binding = 1, std430) buffer OutBuffer
{
    uvec4 outVecs[128][4];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};


out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    outVecs[outIndex][0][0] = inVecs[inIndex][0][0];
    outVecs[outIndex][0][1] = inVecs[inIndex][0][1];
    outVecs[outIndex][0][2] = inVecs[inIndex][0][2];
    outVecs[outIndex][0][3] = inVecs[inIndex][0][3];
    outVecs[outIndex][1][0] = inVecs[inIndex][1][0];
    outVecs[outIndex][1][1] = inVecs[inIndex][1][1];
    outVecs[outIndex][1][2] = inVecs[inIndex][1][2];
    outVecs[outIndex][1][3] = inVecs[inIndex][1][3];
    outVecs[outIndex][2][0] = inVecs[inIndex][2][0];
    outVecs[outIndex][2][1] = inVecs[inIndex][2][1];
    outVecs[outIndex][2][2] = inVecs[inIndex][2][2];
    outVecs[outIndex][2][3] = inVecs[inIndex][2][3];
    outVecs[outIndex][3][0] = inVecs[inIndex][3][0];
    outVecs[outIndex][3][1] = inVecs[inIndex][3][1];
    outVecs[outIndex][3][2] = inVecs[inIndex][3][2];
    outVecs[outIndex][3][3] = inVecs[inIndex][3][3];
    gl_Position = position;
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) in vec4 position;

layout(binding = 0, std140) uniform InBuffer
{
    mat4 inMatrix[128];
};

layout(binding = 1, std430) buffer OutBuffer
{
    mat4 outMatrix[128];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};


out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    outMatrix[outIndex][0][0] = inMatrix[inIndex][0][0];
    outMatrix[outIndex][0][1] = inMatrix[inIndex][0][1];
    outMatrix[outIndex][0][2] = inMatrix[inIndex][0][2];
    outMatrix[outIndex][0][3] = inMatrix[inIndex][0][3];
    outMatrix[outIndex][1][0] = inMatrix[inIndex][1][0];
    outMatrix[outIndex][1][1] = inMatrix[inIndex][1][1];
    outMatrix[outIndex][1][2] = inMatrix[inIndex][1][2];
    outMatrix[outIndex][1][3] = inMatrix[inIndex][1][3];
    outMatrix[outIndex][2][0] = inMatrix[inIndex][2][0];
    outMatrix[outIndex][2][1] = inMatrix[inIndex][2][1];
    outMatrix[outIndex][2][2] = inMatrix[inIndex][2][2];
    outMatrix[outIndex][2][3] = inMatrix[inIndex][2][3];
    outMatrix[outIndex][3][0] = inMatrix[inIndex][3][0];
    outMatrix[outIndex][3][1] = inMatrix[inIndex][3][1];
    outMatrix[outIndex][3][2] = inMatrix[inIndex][3][2];
    outMatrix[outIndex][3][3] = inMatrix[inIndex][3][3];
    gl_Position = position;
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) in vec4 position;

layout(binding = 0, std430) buffer InBuffer
{
    mat4 inMatrix[128];
};

layout(binding = 1, std430) buffer OutBuffer
{
    mat4 outMatrix[128];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};


out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    outMatrix[outIndex][0][0] = inMatrix[inIndex][0][0];
    outMatrix[outIndex][0][1] = inMatrix[inIndex][0][1];
    outMatrix[outIndex][0][2] = inMatrix[inIndex][0][2];
    outMatrix[outIndex][0][3] = inMatrix[inIndex][0][3];
    outMatrix[outIndex][1][0] = inMatrix[inIndex][1][0];
    outMatrix[outIndex][1][1] = inMatrix[inIndex][1][1];
    outMatrix[outIndex][1][2] = inMatrix[inIndex][1][2];
    outMatrix[outIndex][1][3] = inMatrix[inIndex][1][3];
    outMatrix[outIndex][2][0] = inMatrix[inIndex][2][0];
    outMatrix[outIndex][2][1] = inMatrix[inIndex][2][1];
    outMatrix[outIndex][2][2] = inMatrix[inIndex][2][2];
    outMatrix[outIndex][2][3] = inMatrix[inIndex][2][3];
    outMatrix[outIndex][3][0] = inMatrix[inIndex][3][0];
    outMatrix[outIndex][3][1] = inMatrix[inIndex][3][1];
    outMatrix[outIndex][3][2] = inMatrix[inIndex][3][2];
    outMatrix[outIndex][3][3] = inMatrix[inIndex][3][3];
    gl_Position = position;
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) in vec4 position;

layout(set = 0, binding = 0) uniform highp itextureBuffer inImage;
layout(set = 0, binding = 1, rgba32i) uniform highp writeonly iimageBuffer outImage;
layout(binding = 2, std140) uniform Offsets
{
    int inOffset;
    int outOffset;
};


out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    for (int i = 0; i < 4; i++)
    {
        imageStore(outImage, outOffset + i, texelFetch(inImage, inOffset + i));
    }
    gl_Position = position;
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) in vec4 position;

layout(set = 0, binding = 0, rgba32i) uniform highp readonly iimageBuffer inImage;
layout(set = 0, binding = 1, rgba32i) uniform highp writeonly iimageBuffer outImage;
layout(binding = 2, std140) uniform Offsets
{
    int inOffset;
    int outOffset;
};


out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    for (int i = 0; i < 4; i++)
    {
        imageStore(outImage, outOffset + i, imageLoad(inImage, inOffset + i));
    }
    gl_Position = position;
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) in vec4 position;

layout(set = 0, binding = 0) uniform highp utextureBuffer inImage;
layout(set = 0, binding = 1, rgba32ui) uniform highp writeonly uimageBuffer outImage;
layout(binding = 2, std140) uniform Offsets
{
    int inOffset;
    int outOffset;
};


out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    for (int i = 0; i < 4; i++)
    {
        imageStore(outImage, outOffset + i, texelFetch(inImage, inOffset + i));
    }
    gl_Position = position;
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) in vec4 position;

layout(set = 0, binding = 0, rgba32ui) uniform highp readonly uimageBuffer inImage;
layout(set = 0, binding = 1, rgba32ui) uniform highp writeonly uimageBuffer outImage;
layout(binding = 2, std140) uniform Offsets
{
    int inOffset;
    int outOffset;
};


out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    for (int i = 0; i < 4; i++)
    {
        imageStore(outImage, outOffset + i, imageLoad(inImage, inOffset + i));
    }
    gl_Position = position;
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) in vec4 position;

layout(set = 0, binding = 0) uniform highp textureBuffer inImage;
layout(set = 0, binding = 1, rgba32f) uniform highp writeonly imageBuffer outImage;
layout(binding = 2, std140) uniform Offsets
{
    int inOffset;
    int outOffset;
};


out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    for (int i = 0; i < 4; i++)
    {
        imageStore(outImage, outOffset + i, texelFetch(inImage, inOffset + i));
    }
    gl_Position = position;
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) in vec4 position;

layout(set = 0, binding = 0, rgba32f) uniform highp readonly imageBuffer inImage;
layout(set = 0, binding = 1, rgba32f) uniform highp writeonly imageBuffer outImage;
layout(binding = 2, std140) uniform Offsets
{
    int inOffset;
    int outOffset;
};


out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    for (int i = 0; i < 4; i++)
    {
        imageStore(outImage, outOffset + i, imageLoad(inImage, inOffset + i));
    }
    gl_Position = position;
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) in vec4 position;

layout(set = 0, binding = 0) uniform highp textureBuffer inImage;
layout(set = 0, binding = 1, rgb10_a2) uniform highp writeonly imageBuffer outImage;
layout(binding = 2, std140) uniform Offsets
{
    int inOffset;
    int outOffset;
};


out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    for (int i = 0; i < 16; i++)
    {
        imageStore(outImage, outOffset + i, texelFetch(inImage, inOffset + i));
    }
    gl_Position = position;
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) in vec4 position;

layout(set = 0, binding = 0, rgb10_a2) uniform highp readonly imageBuffer inImage;
layout(set = 0, binding = 1, rgb10_a2) uniform highp writeonly imageBuffer outImage;
layout(binding = 2, std140) uniform Offsets
{
    int inOffset;
    int outOffset;
};


out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    for (int i = 0; i < 16; i++)
    {
        imageStore(outImage, outOffset + i, imageLoad(inImage, inOffset + i));
    }
    gl_Position = position;
}
#version 440
precision highp float;
layout(location = 0) in vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    gl_Position = position;
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) out vec4 fragColor;
layout(binding = 0, std140) uniform InBuffer
{
    mat4 inMatrix[128];
};

layout(binding = 1, std430) buffer OutBuffer
{
    mat4 outMatrix[128];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    mat4 tmp = inMatrix[inIndex];
    outMatrix[outIndex] = tmp;
    fragColor = vec4(1.0);
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) out vec4 fragColor;
layout(binding = 0, std430) buffer InBuffer
{
    mat4 inMatrix[128];
};

layout(binding = 1, std430) buffer OutBuffer
{
    mat4 outMatrix[128];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    mat4 tmp = inMatrix[inIndex];
    outMatrix[outIndex] = tmp;
    fragColor = vec4(1.0);
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) out vec4 fragColor;
layout(binding = 0, std140) uniform InBuffer
{
    ivec4 inVecs[128][4];
};

layout(binding = 1, std430) buffer OutBuffer
{
    ivec4 outVecs[128][4];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outVecs[outIndex][0] = inVecs[inIndex][0];
    outVecs[outIndex][1] = inVecs[inIndex][1];
    outVecs[outIndex][2] = inVecs[inIndex][2];
    outVecs[outIndex][3] = inVecs[inIndex][3];
    fragColor = vec4(1.0);
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) out vec4 fragColor;
layout(binding = 0, std430) buffer readonly InBuffer
{
    ivec4 inVecs[128][4];
};

layout(binding = 1, std430) buffer OutBuffer
{
    ivec4 outVecs[128][4];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outVecs[outIndex][0] = inVecs[inIndex][0];
    outVecs[outIndex][1] = inVecs[inIndex][1];
    outVecs[outIndex][2] = inVecs[inIndex][2];
    outVecs[outIndex][3] = inVecs[inIndex][3];
    fragColor = vec4(1.0);
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) out vec4 fragColor;
layout(binding = 0, std140) uniform InBuffer
{
    uvec4 inVecs[128][4];
};

layout(binding = 1, std430) buffer OutBuffer
{
    uvec4 outVecs[128][4];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outVecs[outIndex][0] = inVecs[inIndex][0];
    outVecs[outIndex][1] = inVecs[inIndex][1];
    outVecs[outIndex][2] = inVecs[inIndex][2];
    outVecs[outIndex][3] = inVecs[inIndex][3];
    fragColor = vec4(1.0);
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) out vec4 fragColor;
layout(binding = 0, std430) buffer readonly InBuffer
{
    uvec4 inVecs[128][4];
};

layout(binding = 1, std430) buffer OutBuffer
{
    uvec4 outVecs[128][4];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outVecs[outIndex][0] = inVecs[inIndex][0];
    outVecs[outIndex][1] = inVecs[inIndex][1];
    outVecs[outIndex][2] = inVecs[inIndex][2];
    outVecs[outIndex][3] = inVecs[inIndex][3];
    fragColor = vec4(1.0);
}
#version 440
#extension GL_EXT_texture_buffer : require
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
precision highp float;
layout(location = 0) out vec4 fragColor;
layout(binding = 0, std140) uniform InBuffer
{
    i64vec4 inVecs[128][4];
};

layout(binding = 1, std430) buffer OutBuffer
{
    i64vec4 outVecs[128][4];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outVecs[outIndex][0][0] = inVecs[inIndex][0][0];
    outVecs[outIndex][0][1] = inVecs[inIndex][0][1];
    outVecs[outIndex][0][2] = inVecs[inIndex][0][2];
    outVecs[outIndex][0][3] = inVecs[inIndex][0][3];
    outVecs[outIndex][1][0] = inVecs[inIndex][1][0];
    outVecs[outIndex][1][1] = inVecs[inIndex][1][1];
    outVecs[outIndex][1][2] = inVecs[inIndex][1][2];
    outVecs[outIndex][1][3] = inVecs[inIndex][1][3];
    outVecs[outIndex][2][0] = inVecs[inIndex][2][0];
    outVecs[outIndex][2][1] = inVecs[inIndex][2][1];
    outVecs[outIndex][2][2] = inVecs[inIndex][2][2];
    outVecs[outIndex][2][3] = inVecs[inIndex][2][3];
    outVecs[outIndex][3][0] = inVecs[inIndex][3][0];
    outVecs[outIndex][3][1] = inVecs[inIndex][3][1];
    outVecs[outIndex][3][2] = inVecs[inIndex][3][2];
    outVecs[outIndex][3][3] = inVecs[inIndex][3][3];
    fragColor = vec4(1.0);
}
#version 440
#extension GL_EXT_texture_buffer : require
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
precision highp float;
layout(location = 0) out vec4 fragColor;
layout(binding = 0, std430) buffer readonly InBuffer
{
    i64vec4 inVecs[128][4];
};

layout(binding = 1, std430) buffer OutBuffer
{
    i64vec4 outVecs[128][4];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outVecs[outIndex][0][0] = inVecs[inIndex][0][0];
    outVecs[outIndex][0][1] = inVecs[inIndex][0][1];
    outVecs[outIndex][0][2] = inVecs[inIndex][0][2];
    outVecs[outIndex][0][3] = inVecs[inIndex][0][3];
    outVecs[outIndex][1][0] = inVecs[inIndex][1][0];
    outVecs[outIndex][1][1] = inVecs[inIndex][1][1];
    outVecs[outIndex][1][2] = inVecs[inIndex][1][2];
    outVecs[outIndex][1][3] = inVecs[inIndex][1][3];
    outVecs[outIndex][2][0] = inVecs[inIndex][2][0];
    outVecs[outIndex][2][1] = inVecs[inIndex][2][1];
    outVecs[outIndex][2][2] = inVecs[inIndex][2][2];
    outVecs[outIndex][2][3] = inVecs[inIndex][2][3];
    outVecs[outIndex][3][0] = inVecs[inIndex][3][0];
    outVecs[outIndex][3][1] = inVecs[inIndex][3][1];
    outVecs[outIndex][3][2] = inVecs[inIndex][3][2];
    outVecs[outIndex][3][3] = inVecs[inIndex][3][3];
    fragColor = vec4(1.0);
}
#version 440
#extension GL_EXT_texture_buffer : require
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
precision highp float;
layout(location = 0) out vec4 fragColor;
layout(binding = 0, std140) uniform InBuffer
{
    u64vec4 inVecs[128][4];
};

layout(binding = 1, std430) buffer OutBuffer
{
    u64vec4 outVecs[128][4];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outVecs[outIndex][0][0] = inVecs[inIndex][0][0];
    outVecs[outIndex][0][1] = inVecs[inIndex][0][1];
    outVecs[outIndex][0][2] = inVecs[inIndex][0][2];
    outVecs[outIndex][0][3] = inVecs[inIndex][0][3];
    outVecs[outIndex][1][0] = inVecs[inIndex][1][0];
    outVecs[outIndex][1][1] = inVecs[inIndex][1][1];
    outVecs[outIndex][1][2] = inVecs[inIndex][1][2];
    outVecs[outIndex][1][3] = inVecs[inIndex][1][3];
    outVecs[outIndex][2][0] = inVecs[inIndex][2][0];
    outVecs[outIndex][2][1] = inVecs[inIndex][2][1];
    outVecs[outIndex][2][2] = inVecs[inIndex][2][2];
    outVecs[outIndex][2][3] = inVecs[inIndex][2][3];
    outVecs[outIndex][3][0] = inVecs[inIndex][3][0];
    outVecs[outIndex][3][1] = inVecs[inIndex][3][1];
    outVecs[outIndex][3][2] = inVecs[inIndex][3][2];
    outVecs[outIndex][3][3] = inVecs[inIndex][3][3];
    fragColor = vec4(1.0);
}
#version 440
#extension GL_EXT_texture_buffer : require
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
precision highp float;
layout(location = 0) out vec4 fragColor;
layout(binding = 0, std430) buffer readonly InBuffer
{
    u64vec4 inVecs[128][4];
};

layout(binding = 1, std430) buffer OutBuffer
{
    u64vec4 outVecs[128][4];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outVecs[outIndex][0][0] = inVecs[inIndex][0][0];
    outVecs[outIndex][0][1] = inVecs[inIndex][0][1];
    outVecs[outIndex][0][2] = inVecs[inIndex][0][2];
    outVecs[outIndex][0][3] = inVecs[inIndex][0][3];
    outVecs[outIndex][1][0] = inVecs[inIndex][1][0];
    outVecs[outIndex][1][1] = inVecs[inIndex][1][1];
    outVecs[outIndex][1][2] = inVecs[inIndex][1][2];
    outVecs[outIndex][1][3] = inVecs[inIndex][1][3];
    outVecs[outIndex][2][0] = inVecs[inIndex][2][0];
    outVecs[outIndex][2][1] = inVecs[inIndex][2][1];
    outVecs[outIndex][2][2] = inVecs[inIndex][2][2];
    outVecs[outIndex][2][3] = inVecs[inIndex][2][3];
    outVecs[outIndex][3][0] = inVecs[inIndex][3][0];
    outVecs[outIndex][3][1] = inVecs[inIndex][3][1];
    outVecs[outIndex][3][2] = inVecs[inIndex][3][2];
    outVecs[outIndex][3][3] = inVecs[inIndex][3][3];
    fragColor = vec4(1.0);
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) out vec4 fragColor;
layout(binding = 0, std140) uniform InBuffer
{
    mat4 inMatrix[128];
};

layout(binding = 1, std430) buffer OutBuffer
{
    mat4 outMatrix[128];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outMatrix[outIndex][0] = inMatrix[inIndex][0];
    outMatrix[outIndex][1] = inMatrix[inIndex][1];
    outMatrix[outIndex][2] = inMatrix[inIndex][2];
    outMatrix[outIndex][3] = inMatrix[inIndex][3];
    fragColor = vec4(1.0);
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) out vec4 fragColor;
layout(binding = 0, std430) buffer InBuffer
{
    mat4 inMatrix[128];
};

layout(binding = 1, std430) buffer OutBuffer
{
    mat4 outMatrix[128];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outMatrix[outIndex][0] = inMatrix[inIndex][0];
    outMatrix[outIndex][1] = inMatrix[inIndex][1];
    outMatrix[outIndex][2] = inMatrix[inIndex][2];
    outMatrix[outIndex][3] = inMatrix[inIndex][3];
    fragColor = vec4(1.0);
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) out vec4 fragColor;
layout(binding = 0, std140) uniform InBuffer
{
    ivec4 inVec;
};

layout(binding = 1, std430) buffer OutBuffer
{
    ivec4 outVec;
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outVec[outIndex] = inVec[inIndex];
    outVec[outIndex + 1] = inVec[inIndex + 1];
    outVec[outIndex + 2] = inVec[inIndex + 2];
    outVec[outIndex + 3] = inVec[inIndex + 3];
    fragColor = vec4(1.0);
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) out vec4 fragColor;
layout(binding = 0, std430) buffer readonly InBuffer
{
    ivec4 inVec;
};

layout(binding = 1, std430) buffer OutBuffer
{
    ivec4 outVec;
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outVec[outIndex] = inVec[inIndex];
    outVec[outIndex + 1] = inVec[inIndex + 1];
    outVec[outIndex + 2] = inVec[inIndex + 2];
    outVec[outIndex + 3] = inVec[inIndex + 3];
    fragColor = vec4(1.0);
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) out vec4 fragColor;
layout(binding = 0, std140) uniform InBuffer
{
    uvec4 inVec;
};

layout(binding = 1, std430) buffer OutBuffer
{
    uvec4 outVec;
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outVec[outIndex] = inVec[inIndex];
    outVec[outIndex + 1] = inVec[inIndex + 1];
    outVec[outIndex + 2] = inVec[inIndex + 2];
    outVec[outIndex + 3] = inVec[inIndex + 3];
    fragColor = vec4(1.0);
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) out vec4 fragColor;
layout(binding = 0, std430) buffer readonly InBuffer
{
    uvec4 inVec;
};

layout(binding = 1, std430) buffer OutBuffer
{
    uvec4 outVec;
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outVec[outIndex] = inVec[inIndex];
    outVec[outIndex + 1] = inVec[inIndex + 1];
    outVec[outIndex + 2] = inVec[inIndex + 2];
    outVec[outIndex + 3] = inVec[inIndex + 3];
    fragColor = vec4(1.0);
}
#version 440
#extension GL_EXT_texture_buffer : require
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
precision highp float;
layout(location = 0) out vec4 fragColor;
layout(binding = 0, std140) uniform InBuffer
{
    i64vec4 inVec;
};

layout(binding = 1, std430) buffer OutBuffer
{
    i64vec4 outVec;
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outVec[outIndex] = inVec[inIndex];
    outVec[outIndex + 1] = inVec[inIndex + 1];
    outVec[outIndex + 2] = inVec[inIndex + 2];
    outVec[outIndex + 3] = inVec[inIndex + 3];
    fragColor = vec4(1.0);
}
#version 440
#extension GL_EXT_texture_buffer : require
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
precision highp float;
layout(location = 0) out vec4 fragColor;
layout(binding = 0, std430) buffer readonly InBuffer
{
    i64vec4 inVec;
};

layout(binding = 1, std430) buffer OutBuffer
{
    i64vec4 outVec;
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outVec[outIndex] = inVec[inIndex];
    outVec[outIndex + 1] = inVec[inIndex + 1];
    outVec[outIndex + 2] = inVec[inIndex + 2];
    outVec[outIndex + 3] = inVec[inIndex + 3];
    fragColor = vec4(1.0);
}
#version 440
#extension GL_EXT_texture_buffer : require
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
precision highp float;
layout(location = 0) out vec4 fragColor;
layout(binding = 0, std140) uniform InBuffer
{
    u64vec4 inVec;
};

layout(binding = 1, std430) buffer OutBuffer
{
    u64vec4 outVec;
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outVec[outIndex] = inVec[inIndex];
    outVec[outIndex + 1] = inVec[inIndex + 1];
    outVec[outIndex + 2] = inVec[inIndex + 2];
    outVec[outIndex + 3] = inVec[inIndex + 3];
    fragColor = vec4(1.0);
}
#version 440
#extension GL_EXT_texture_buffer : require
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
precision highp float;
layout(location = 0) out vec4 fragColor;
layout(binding = 0, std430) buffer readonly InBuffer
{
    u64vec4 inVec;
};

layout(binding = 1, std430) buffer OutBuffer
{
    u64vec4 outVec;
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outVec[outIndex] = inVec[inIndex];
    outVec[outIndex + 1] = inVec[inIndex + 1];
    outVec[outIndex + 2] = inVec[inIndex + 2];
    outVec[outIndex + 3] = inVec[inIndex + 3];
    fragColor = vec4(1.0);
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) out vec4 fragColor;
layout(binding = 0, std140) uniform InBuffer
{
    vec4 inVec;
};

layout(binding = 1, std430) buffer OutBuffer
{
    vec4 outVec;
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outVec[outIndex] = inVec[inIndex];
    outVec[outIndex + 1] = inVec[inIndex + 1];
    outVec[outIndex + 2] = inVec[inIndex + 2];
    outVec[outIndex + 3] = inVec[inIndex + 3];
    fragColor = vec4(1.0);
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) out vec4 fragColor;
layout(binding = 0, std430) buffer readonly InBuffer
{
    vec4 inVec;
};

layout(binding = 1, std430) buffer OutBuffer
{
    vec4 outVec;
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outVec[outIndex] = inVec[inIndex];
    outVec[outIndex + 1] = inVec[inIndex + 1];
    outVec[outIndex + 2] = inVec[inIndex + 2];
    outVec[outIndex + 3] = inVec[inIndex + 3];
    fragColor = vec4(1.0);
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) out vec4 fragColor;
layout(binding = 0, std140) uniform InBuffer
{
    ivec4 inVecs[128][4];
};

layout(binding = 1, std430) buffer OutBuffer
{
    ivec4 outVecs[128][4];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outVecs[outIndex][0][0] = inVecs[inIndex][0][0];
    outVecs[outIndex][0][1] = inVecs[inIndex][0][1];
    outVecs[outIndex][0][2] = inVecs[inIndex][0][2];
    outVecs[outIndex][0][3] = inVecs[inIndex][0][3];
    outVecs[outIndex][1][0] = inVecs[inIndex][1][0];
    outVecs[outIndex][1][1] = inVecs[inIndex][1][1];
    outVecs[outIndex][1][2] = inVecs[inIndex][1][2];
    outVecs[outIndex][1][3] = inVecs[inIndex][1][3];
    outVecs[outIndex][2][0] = inVecs[inIndex][2][0];
    outVecs[outIndex][2][1] = inVecs[inIndex][2][1];
    outVecs[outIndex][2][2] = inVecs[inIndex][2][2];
    outVecs[outIndex][2][3] = inVecs[inIndex][2][3];
    outVecs[outIndex][3][0] = inVecs[inIndex][3][0];
    outVecs[outIndex][3][1] = inVecs[inIndex][3][1];
    outVecs[outIndex][3][2] = inVecs[inIndex][3][2];
    outVecs[outIndex][3][3] = inVecs[inIndex][3][3];
    fragColor = vec4(1.0);
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) out vec4 fragColor;
layout(binding = 0, std430) buffer readonly InBuffer
{
    ivec4 inVecs[128][4];
};

layout(binding = 1, std430) buffer OutBuffer
{
    ivec4 outVecs[128][4];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outVecs[outIndex][0][0] = inVecs[inIndex][0][0];
    outVecs[outIndex][0][1] = inVecs[inIndex][0][1];
    outVecs[outIndex][0][2] = inVecs[inIndex][0][2];
    outVecs[outIndex][0][3] = inVecs[inIndex][0][3];
    outVecs[outIndex][1][0] = inVecs[inIndex][1][0];
    outVecs[outIndex][1][1] = inVecs[inIndex][1][1];
    outVecs[outIndex][1][2] = inVecs[inIndex][1][2];
    outVecs[outIndex][1][3] = inVecs[inIndex][1][3];
    outVecs[outIndex][2][0] = inVecs[inIndex][2][0];
    outVecs[outIndex][2][1] = inVecs[inIndex][2][1];
    outVecs[outIndex][2][2] = inVecs[inIndex][2][2];
    outVecs[outIndex][2][3] = inVecs[inIndex][2][3];
    outVecs[outIndex][3][0] = inVecs[inIndex][3][0];
    outVecs[outIndex][3][1] = inVecs[inIndex][3][1];
    outVecs[outIndex][3][2] = inVecs[inIndex][3][2];
    outVecs[outIndex][3][3] = inVecs[inIndex][3][3];
    fragColor = vec4(1.0);
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) out vec4 fragColor;
layout(binding = 0, std140) uniform InBuffer
{
    uvec4 inVecs[128][4];
};

layout(binding = 1, std430) buffer OutBuffer
{
    uvec4 outVecs[128][4];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outVecs[outIndex][0][0] = inVecs[inIndex][0][0];
    outVecs[outIndex][0][1] = inVecs[inIndex][0][1];
    outVecs[outIndex][0][2] = inVecs[inIndex][0][2];
    outVecs[outIndex][0][3] = inVecs[inIndex][0][3];
    outVecs[outIndex][1][0] = inVecs[inIndex][1][0];
    outVecs[outIndex][1][1] = inVecs[inIndex][1][1];
    outVecs[outIndex][1][2] = inVecs[inIndex][1][2];
    outVecs[outIndex][1][3] = inVecs[inIndex][1][3];
    outVecs[outIndex][2][0] = inVecs[inIndex][2][0];
    outVecs[outIndex][2][1] = inVecs[inIndex][2][1];
    outVecs[outIndex][2][2] = inVecs[inIndex][2][2];
    outVecs[outIndex][2][3] = inVecs[inIndex][2][3];
    outVecs[outIndex][3][0] = inVecs[inIndex][3][0];
    outVecs[outIndex][3][1] = inVecs[inIndex][3][1];
    outVecs[outIndex][3][2] = inVecs[inIndex][3][2];
    outVecs[outIndex][3][3] = inVecs[inIndex][3][3];
    fragColor = vec4(1.0);
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) out vec4 fragColor;
layout(binding = 0, std430) buffer readonly InBuffer
{
    uvec4 inVecs[128][4];
};

layout(binding = 1, std430) buffer OutBuffer
{
    uvec4 outVecs[128][4];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outVecs[outIndex][0][0] = inVecs[inIndex][0][0];
    outVecs[outIndex][0][1] = inVecs[inIndex][0][1];
    outVecs[outIndex][0][2] = inVecs[inIndex][0][2];
    outVecs[outIndex][0][3] = inVecs[inIndex][0][3];
    outVecs[outIndex][1][0] = inVecs[inIndex][1][0];
    outVecs[outIndex][1][1] = inVecs[inIndex][1][1];
    outVecs[outIndex][1][2] = inVecs[inIndex][1][2];
    outVecs[outIndex][1][3] = inVecs[inIndex][1][3];
    outVecs[outIndex][2][0] = inVecs[inIndex][2][0];
    outVecs[outIndex][2][1] = inVecs[inIndex][2][1];
    outVecs[outIndex][2][2] = inVecs[inIndex][2][2];
    outVecs[outIndex][2][3] = inVecs[inIndex][2][3];
    outVecs[outIndex][3][0] = inVecs[inIndex][3][0];
    outVecs[outIndex][3][1] = inVecs[inIndex][3][1];
    outVecs[outIndex][3][2] = inVecs[inIndex][3][2];
    outVecs[outIndex][3][3] = inVecs[inIndex][3][3];
    fragColor = vec4(1.0);
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) out vec4 fragColor;
layout(binding = 0, std140) uniform InBuffer
{
    mat4 inMatrix[128];
};

layout(binding = 1, std430) buffer OutBuffer
{
    mat4 outMatrix[128];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outMatrix[outIndex][0][0] = inMatrix[inIndex][0][0];
    outMatrix[outIndex][0][1] = inMatrix[inIndex][0][1];
    outMatrix[outIndex][0][2] = inMatrix[inIndex][0][2];
    outMatrix[outIndex][0][3] = inMatrix[inIndex][0][3];
    outMatrix[outIndex][1][0] = inMatrix[inIndex][1][0];
    outMatrix[outIndex][1][1] = inMatrix[inIndex][1][1];
    outMatrix[outIndex][1][2] = inMatrix[inIndex][1][2];
    outMatrix[outIndex][1][3] = inMatrix[inIndex][1][3];
    outMatrix[outIndex][2][0] = inMatrix[inIndex][2][0];
    outMatrix[outIndex][2][1] = inMatrix[inIndex][2][1];
    outMatrix[outIndex][2][2] = inMatrix[inIndex][2][2];
    outMatrix[outIndex][2][3] = inMatrix[inIndex][2][3];
    outMatrix[outIndex][3][0] = inMatrix[inIndex][3][0];
    outMatrix[outIndex][3][1] = inMatrix[inIndex][3][1];
    outMatrix[outIndex][3][2] = inMatrix[inIndex][3][2];
    outMatrix[outIndex][3][3] = inMatrix[inIndex][3][3];
    fragColor = vec4(1.0);
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) out vec4 fragColor;
layout(binding = 0, std430) buffer InBuffer
{
    mat4 inMatrix[128];
};

layout(binding = 1, std430) buffer OutBuffer
{
    mat4 outMatrix[128];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outMatrix[outIndex][0][0] = inMatrix[inIndex][0][0];
    outMatrix[outIndex][0][1] = inMatrix[inIndex][0][1];
    outMatrix[outIndex][0][2] = inMatrix[inIndex][0][2];
    outMatrix[outIndex][0][3] = inMatrix[inIndex][0][3];
    outMatrix[outIndex][1][0] = inMatrix[inIndex][1][0];
    outMatrix[outIndex][1][1] = inMatrix[inIndex][1][1];
    outMatrix[outIndex][1][2] = inMatrix[inIndex][1][2];
    outMatrix[outIndex][1][3] = inMatrix[inIndex][1][3];
    outMatrix[outIndex][2][0] = inMatrix[inIndex][2][0];
    outMatrix[outIndex][2][1] = inMatrix[inIndex][2][1];
    outMatrix[outIndex][2][2] = inMatrix[inIndex][2][2];
    outMatrix[outIndex][2][3] = inMatrix[inIndex][2][3];
    outMatrix[outIndex][3][0] = inMatrix[inIndex][3][0];
    outMatrix[outIndex][3][1] = inMatrix[inIndex][3][1];
    outMatrix[outIndex][3][2] = inMatrix[inIndex][3][2];
    outMatrix[outIndex][3][3] = inMatrix[inIndex][3][3];
    fragColor = vec4(1.0);
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) out vec4 fragColor;
layout(set = 0, binding = 0) uniform highp itextureBuffer inImage;
layout(set = 0, binding = 1, rgba32i) uniform highp writeonly iimageBuffer outImage;
layout(binding = 2, std140) uniform Offsets
{
    int inOffset;
    int outOffset;
};

void main (void)
{
    for (int i = 0; i < 4; i++)
    {
        imageStore(outImage, outOffset + i, texelFetch(inImage, inOffset + i));
    }
    fragColor = vec4(1.0);
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) out vec4 fragColor;
layout(set = 0, binding = 0, rgba32i) uniform highp readonly iimageBuffer inImage;
layout(set = 0, binding = 1, rgba32i) uniform highp writeonly iimageBuffer outImage;
layout(binding = 2, std140) uniform Offsets
{
    int inOffset;
    int outOffset;
};

void main (void)
{
    for (int i = 0; i < 4; i++)
    {
        imageStore(outImage, outOffset + i, imageLoad(inImage, inOffset + i));
    }
    fragColor = vec4(1.0);
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) out vec4 fragColor;
layout(set = 0, binding = 0) uniform highp utextureBuffer inImage;
layout(set = 0, binding = 1, rgba32ui) uniform highp writeonly uimageBuffer outImage;
layout(binding = 2, std140) uniform Offsets
{
    int inOffset;
    int outOffset;
};

void main (void)
{
    for (int i = 0; i < 4; i++)
    {
        imageStore(outImage, outOffset + i, texelFetch(inImage, inOffset + i));
    }
    fragColor = vec4(1.0);
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) out vec4 fragColor;
layout(set = 0, binding = 0, rgba32ui) uniform highp readonly uimageBuffer inImage;
layout(set = 0, binding = 1, rgba32ui) uniform highp writeonly uimageBuffer outImage;
layout(binding = 2, std140) uniform Offsets
{
    int inOffset;
    int outOffset;
};

void main (void)
{
    for (int i = 0; i < 4; i++)
    {
        imageStore(outImage, outOffset + i, imageLoad(inImage, inOffset + i));
    }
    fragColor = vec4(1.0);
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) out vec4 fragColor;
layout(set = 0, binding = 0) uniform highp textureBuffer inImage;
layout(set = 0, binding = 1, rgba32f) uniform highp writeonly imageBuffer outImage;
layout(binding = 2, std140) uniform Offsets
{
    int inOffset;
    int outOffset;
};

void main (void)
{
    for (int i = 0; i < 4; i++)
    {
        imageStore(outImage, outOffset + i, texelFetch(inImage, inOffset + i));
    }
    fragColor = vec4(1.0);
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) out vec4 fragColor;
layout(set = 0, binding = 0, rgba32f) uniform highp readonly imageBuffer inImage;
layout(set = 0, binding = 1, rgba32f) uniform highp writeonly imageBuffer outImage;
layout(binding = 2, std140) uniform Offsets
{
    int inOffset;
    int outOffset;
};

void main (void)
{
    for (int i = 0; i < 4; i++)
    {
        imageStore(outImage, outOffset + i, imageLoad(inImage, inOffset + i));
    }
    fragColor = vec4(1.0);
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) out vec4 fragColor;
layout(set = 0, binding = 0) uniform highp textureBuffer inImage;
layout(set = 0, binding = 1, rgb10_a2) uniform highp writeonly imageBuffer outImage;
layout(binding = 2, std140) uniform Offsets
{
    int inOffset;
    int outOffset;
};

void main (void)
{
    for (int i = 0; i < 16; i++)
    {
        imageStore(outImage, outOffset + i, texelFetch(inImage, inOffset + i));
    }
    fragColor = vec4(1.0);
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) out vec4 fragColor;
layout(set = 0, binding = 0, rgb10_a2) uniform highp readonly imageBuffer inImage;
layout(set = 0, binding = 1, rgb10_a2) uniform highp writeonly imageBuffer outImage;
layout(binding = 2, std140) uniform Offsets
{
    int inOffset;
    int outOffset;
};

void main (void)
{
    for (int i = 0; i < 16; i++)
    {
        imageStore(outImage, outOffset + i, imageLoad(inImage, inOffset + i));
    }
    fragColor = vec4(1.0);
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(binding = 0, std140) uniform InBuffer
{
    mat4 inMatrix[128];
};

layout(binding = 1, std430) buffer OutBuffer
{
    mat4 outMatrix[128];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    mat4 tmp = inMatrix[inIndex];
    outMatrix[outIndex] = tmp;
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(binding = 0, std430) buffer InBuffer
{
    mat4 inMatrix[128];
};

layout(binding = 1, std430) buffer OutBuffer
{
    mat4 outMatrix[128];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    mat4 tmp = inMatrix[inIndex];
    outMatrix[outIndex] = tmp;
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(binding = 0, std140) uniform InBuffer
{
    ivec4 inVecs[128][4];
};

layout(binding = 1, std430) buffer OutBuffer
{
    ivec4 outVecs[128][4];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outVecs[outIndex][0] = inVecs[inIndex][0];
    outVecs[outIndex][1] = inVecs[inIndex][1];
    outVecs[outIndex][2] = inVecs[inIndex][2];
    outVecs[outIndex][3] = inVecs[inIndex][3];
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(binding = 0, std430) buffer readonly InBuffer
{
    ivec4 inVecs[128][4];
};

layout(binding = 1, std430) buffer OutBuffer
{
    ivec4 outVecs[128][4];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outVecs[outIndex][0] = inVecs[inIndex][0];
    outVecs[outIndex][1] = inVecs[inIndex][1];
    outVecs[outIndex][2] = inVecs[inIndex][2];
    outVecs[outIndex][3] = inVecs[inIndex][3];
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(binding = 0, std140) uniform InBuffer
{
    uvec4 inVecs[128][4];
};

layout(binding = 1, std430) buffer OutBuffer
{
    uvec4 outVecs[128][4];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outVecs[outIndex][0] = inVecs[inIndex][0];
    outVecs[outIndex][1] = inVecs[inIndex][1];
    outVecs[outIndex][2] = inVecs[inIndex][2];
    outVecs[outIndex][3] = inVecs[inIndex][3];
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(binding = 0, std430) buffer readonly InBuffer
{
    uvec4 inVecs[128][4];
};

layout(binding = 1, std430) buffer OutBuffer
{
    uvec4 outVecs[128][4];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outVecs[outIndex][0] = inVecs[inIndex][0];
    outVecs[outIndex][1] = inVecs[inIndex][1];
    outVecs[outIndex][2] = inVecs[inIndex][2];
    outVecs[outIndex][3] = inVecs[inIndex][3];
}
#version 440
#extension GL_EXT_texture_buffer : require
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
precision highp float;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(binding = 0, std140) uniform InBuffer
{
    i64vec4 inVecs[128][4];
};

layout(binding = 1, std430) buffer OutBuffer
{
    i64vec4 outVecs[128][4];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outVecs[outIndex][0][0] = inVecs[inIndex][0][0];
    outVecs[outIndex][0][1] = inVecs[inIndex][0][1];
    outVecs[outIndex][0][2] = inVecs[inIndex][0][2];
    outVecs[outIndex][0][3] = inVecs[inIndex][0][3];
    outVecs[outIndex][1][0] = inVecs[inIndex][1][0];
    outVecs[outIndex][1][1] = inVecs[inIndex][1][1];
    outVecs[outIndex][1][2] = inVecs[inIndex][1][2];
    outVecs[outIndex][1][3] = inVecs[inIndex][1][3];
    outVecs[outIndex][2][0] = inVecs[inIndex][2][0];
    outVecs[outIndex][2][1] = inVecs[inIndex][2][1];
    outVecs[outIndex][2][2] = inVecs[inIndex][2][2];
    outVecs[outIndex][2][3] = inVecs[inIndex][2][3];
    outVecs[outIndex][3][0] = inVecs[inIndex][3][0];
    outVecs[outIndex][3][1] = inVecs[inIndex][3][1];
    outVecs[outIndex][3][2] = inVecs[inIndex][3][2];
    outVecs[outIndex][3][3] = inVecs[inIndex][3][3];
}
#version 440
#extension GL_EXT_texture_buffer : require
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
precision highp float;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(binding = 0, std430) buffer readonly InBuffer
{
    i64vec4 inVecs[128][4];
};

layout(binding = 1, std430) buffer OutBuffer
{
    i64vec4 outVecs[128][4];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outVecs[outIndex][0][0] = inVecs[inIndex][0][0];
    outVecs[outIndex][0][1] = inVecs[inIndex][0][1];
    outVecs[outIndex][0][2] = inVecs[inIndex][0][2];
    outVecs[outIndex][0][3] = inVecs[inIndex][0][3];
    outVecs[outIndex][1][0] = inVecs[inIndex][1][0];
    outVecs[outIndex][1][1] = inVecs[inIndex][1][1];
    outVecs[outIndex][1][2] = inVecs[inIndex][1][2];
    outVecs[outIndex][1][3] = inVecs[inIndex][1][3];
    outVecs[outIndex][2][0] = inVecs[inIndex][2][0];
    outVecs[outIndex][2][1] = inVecs[inIndex][2][1];
    outVecs[outIndex][2][2] = inVecs[inIndex][2][2];
    outVecs[outIndex][2][3] = inVecs[inIndex][2][3];
    outVecs[outIndex][3][0] = inVecs[inIndex][3][0];
    outVecs[outIndex][3][1] = inVecs[inIndex][3][1];
    outVecs[outIndex][3][2] = inVecs[inIndex][3][2];
    outVecs[outIndex][3][3] = inVecs[inIndex][3][3];
}
#version 440
#extension GL_EXT_texture_buffer : require
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
precision highp float;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(binding = 0, std140) uniform InBuffer
{
    u64vec4 inVecs[128][4];
};

layout(binding = 1, std430) buffer OutBuffer
{
    u64vec4 outVecs[128][4];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outVecs[outIndex][0][0] = inVecs[inIndex][0][0];
    outVecs[outIndex][0][1] = inVecs[inIndex][0][1];
    outVecs[outIndex][0][2] = inVecs[inIndex][0][2];
    outVecs[outIndex][0][3] = inVecs[inIndex][0][3];
    outVecs[outIndex][1][0] = inVecs[inIndex][1][0];
    outVecs[outIndex][1][1] = inVecs[inIndex][1][1];
    outVecs[outIndex][1][2] = inVecs[inIndex][1][2];
    outVecs[outIndex][1][3] = inVecs[inIndex][1][3];
    outVecs[outIndex][2][0] = inVecs[inIndex][2][0];
    outVecs[outIndex][2][1] = inVecs[inIndex][2][1];
    outVecs[outIndex][2][2] = inVecs[inIndex][2][2];
    outVecs[outIndex][2][3] = inVecs[inIndex][2][3];
    outVecs[outIndex][3][0] = inVecs[inIndex][3][0];
    outVecs[outIndex][3][1] = inVecs[inIndex][3][1];
    outVecs[outIndex][3][2] = inVecs[inIndex][3][2];
    outVecs[outIndex][3][3] = inVecs[inIndex][3][3];
}
#version 440
#extension GL_EXT_texture_buffer : require
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
precision highp float;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(binding = 0, std430) buffer readonly InBuffer
{
    u64vec4 inVecs[128][4];
};

layout(binding = 1, std430) buffer OutBuffer
{
    u64vec4 outVecs[128][4];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outVecs[outIndex][0][0] = inVecs[inIndex][0][0];
    outVecs[outIndex][0][1] = inVecs[inIndex][0][1];
    outVecs[outIndex][0][2] = inVecs[inIndex][0][2];
    outVecs[outIndex][0][3] = inVecs[inIndex][0][3];
    outVecs[outIndex][1][0] = inVecs[inIndex][1][0];
    outVecs[outIndex][1][1] = inVecs[inIndex][1][1];
    outVecs[outIndex][1][2] = inVecs[inIndex][1][2];
    outVecs[outIndex][1][3] = inVecs[inIndex][1][3];
    outVecs[outIndex][2][0] = inVecs[inIndex][2][0];
    outVecs[outIndex][2][1] = inVecs[inIndex][2][1];
    outVecs[outIndex][2][2] = inVecs[inIndex][2][2];
    outVecs[outIndex][2][3] = inVecs[inIndex][2][3];
    outVecs[outIndex][3][0] = inVecs[inIndex][3][0];
    outVecs[outIndex][3][1] = inVecs[inIndex][3][1];
    outVecs[outIndex][3][2] = inVecs[inIndex][3][2];
    outVecs[outIndex][3][3] = inVecs[inIndex][3][3];
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(binding = 0, std140) uniform InBuffer
{
    mat4 inMatrix[128];
};

layout(binding = 1, std430) buffer OutBuffer
{
    mat4 outMatrix[128];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outMatrix[outIndex][0] = inMatrix[inIndex][0];
    outMatrix[outIndex][1] = inMatrix[inIndex][1];
    outMatrix[outIndex][2] = inMatrix[inIndex][2];
    outMatrix[outIndex][3] = inMatrix[inIndex][3];
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(binding = 0, std430) buffer InBuffer
{
    mat4 inMatrix[128];
};

layout(binding = 1, std430) buffer OutBuffer
{
    mat4 outMatrix[128];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outMatrix[outIndex][0] = inMatrix[inIndex][0];
    outMatrix[outIndex][1] = inMatrix[inIndex][1];
    outMatrix[outIndex][2] = inMatrix[inIndex][2];
    outMatrix[outIndex][3] = inMatrix[inIndex][3];
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(binding = 0, std140) uniform InBuffer
{
    ivec4 inVec;
};

layout(binding = 1, std430) buffer OutBuffer
{
    ivec4 outVec;
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outVec[outIndex] = inVec[inIndex];
    outVec[outIndex + 1] = inVec[inIndex + 1];
    outVec[outIndex + 2] = inVec[inIndex + 2];
    outVec[outIndex + 3] = inVec[inIndex + 3];
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(binding = 0, std430) buffer readonly InBuffer
{
    ivec4 inVec;
};

layout(binding = 1, std430) buffer OutBuffer
{
    ivec4 outVec;
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outVec[outIndex] = inVec[inIndex];
    outVec[outIndex + 1] = inVec[inIndex + 1];
    outVec[outIndex + 2] = inVec[inIndex + 2];
    outVec[outIndex + 3] = inVec[inIndex + 3];
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(binding = 0, std140) uniform InBuffer
{
    uvec4 inVec;
};

layout(binding = 1, std430) buffer OutBuffer
{
    uvec4 outVec;
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outVec[outIndex] = inVec[inIndex];
    outVec[outIndex + 1] = inVec[inIndex + 1];
    outVec[outIndex + 2] = inVec[inIndex + 2];
    outVec[outIndex + 3] = inVec[inIndex + 3];
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(binding = 0, std430) buffer readonly InBuffer
{
    uvec4 inVec;
};

layout(binding = 1, std430) buffer OutBuffer
{
    uvec4 outVec;
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outVec[outIndex] = inVec[inIndex];
    outVec[outIndex + 1] = inVec[inIndex + 1];
    outVec[outIndex + 2] = inVec[inIndex + 2];
    outVec[outIndex + 3] = inVec[inIndex + 3];
}
#version 440
#extension GL_EXT_texture_buffer : require
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
precision highp float;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(binding = 0, std140) uniform InBuffer
{
    i64vec4 inVec;
};

layout(binding = 1, std430) buffer OutBuffer
{
    i64vec4 outVec;
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outVec[outIndex] = inVec[inIndex];
    outVec[outIndex + 1] = inVec[inIndex + 1];
    outVec[outIndex + 2] = inVec[inIndex + 2];
    outVec[outIndex + 3] = inVec[inIndex + 3];
}
#version 440
#extension GL_EXT_texture_buffer : require
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
precision highp float;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(binding = 0, std430) buffer readonly InBuffer
{
    i64vec4 inVec;
};

layout(binding = 1, std430) buffer OutBuffer
{
    i64vec4 outVec;
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outVec[outIndex] = inVec[inIndex];
    outVec[outIndex + 1] = inVec[inIndex + 1];
    outVec[outIndex + 2] = inVec[inIndex + 2];
    outVec[outIndex + 3] = inVec[inIndex + 3];
}
#version 440
#extension GL_EXT_texture_buffer : require
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
precision highp float;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(binding = 0, std140) uniform InBuffer
{
    u64vec4 inVec;
};

layout(binding = 1, std430) buffer OutBuffer
{
    u64vec4 outVec;
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outVec[outIndex] = inVec[inIndex];
    outVec[outIndex + 1] = inVec[inIndex + 1];
    outVec[outIndex + 2] = inVec[inIndex + 2];
    outVec[outIndex + 3] = inVec[inIndex + 3];
}
#version 440
#extension GL_EXT_texture_buffer : require
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
precision highp float;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(binding = 0, std430) buffer readonly InBuffer
{
    u64vec4 inVec;
};

layout(binding = 1, std430) buffer OutBuffer
{
    u64vec4 outVec;
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outVec[outIndex] = inVec[inIndex];
    outVec[outIndex + 1] = inVec[inIndex + 1];
    outVec[outIndex + 2] = inVec[inIndex + 2];
    outVec[outIndex + 3] = inVec[inIndex + 3];
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(binding = 0, std140) uniform InBuffer
{
    vec4 inVec;
};

layout(binding = 1, std430) buffer OutBuffer
{
    vec4 outVec;
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outVec[outIndex] = inVec[inIndex];
    outVec[outIndex + 1] = inVec[inIndex + 1];
    outVec[outIndex + 2] = inVec[inIndex + 2];
    outVec[outIndex + 3] = inVec[inIndex + 3];
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(binding = 0, std430) buffer readonly InBuffer
{
    vec4 inVec;
};

layout(binding = 1, std430) buffer OutBuffer
{
    vec4 outVec;
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outVec[outIndex] = inVec[inIndex];
    outVec[outIndex + 1] = inVec[inIndex + 1];
    outVec[outIndex + 2] = inVec[inIndex + 2];
    outVec[outIndex + 3] = inVec[inIndex + 3];
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(binding = 0, std140) uniform InBuffer
{
    ivec4 inVecs[128][4];
};

layout(binding = 1, std430) buffer OutBuffer
{
    ivec4 outVecs[128][4];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outVecs[outIndex][0][0] = inVecs[inIndex][0][0];
    outVecs[outIndex][0][1] = inVecs[inIndex][0][1];
    outVecs[outIndex][0][2] = inVecs[inIndex][0][2];
    outVecs[outIndex][0][3] = inVecs[inIndex][0][3];
    outVecs[outIndex][1][0] = inVecs[inIndex][1][0];
    outVecs[outIndex][1][1] = inVecs[inIndex][1][1];
    outVecs[outIndex][1][2] = inVecs[inIndex][1][2];
    outVecs[outIndex][1][3] = inVecs[inIndex][1][3];
    outVecs[outIndex][2][0] = inVecs[inIndex][2][0];
    outVecs[outIndex][2][1] = inVecs[inIndex][2][1];
    outVecs[outIndex][2][2] = inVecs[inIndex][2][2];
    outVecs[outIndex][2][3] = inVecs[inIndex][2][3];
    outVecs[outIndex][3][0] = inVecs[inIndex][3][0];
    outVecs[outIndex][3][1] = inVecs[inIndex][3][1];
    outVecs[outIndex][3][2] = inVecs[inIndex][3][2];
    outVecs[outIndex][3][3] = inVecs[inIndex][3][3];
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(binding = 0, std430) buffer readonly InBuffer
{
    ivec4 inVecs[128][4];
};

layout(binding = 1, std430) buffer OutBuffer
{
    ivec4 outVecs[128][4];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outVecs[outIndex][0][0] = inVecs[inIndex][0][0];
    outVecs[outIndex][0][1] = inVecs[inIndex][0][1];
    outVecs[outIndex][0][2] = inVecs[inIndex][0][2];
    outVecs[outIndex][0][3] = inVecs[inIndex][0][3];
    outVecs[outIndex][1][0] = inVecs[inIndex][1][0];
    outVecs[outIndex][1][1] = inVecs[inIndex][1][1];
    outVecs[outIndex][1][2] = inVecs[inIndex][1][2];
    outVecs[outIndex][1][3] = inVecs[inIndex][1][3];
    outVecs[outIndex][2][0] = inVecs[inIndex][2][0];
    outVecs[outIndex][2][1] = inVecs[inIndex][2][1];
    outVecs[outIndex][2][2] = inVecs[inIndex][2][2];
    outVecs[outIndex][2][3] = inVecs[inIndex][2][3];
    outVecs[outIndex][3][0] = inVecs[inIndex][3][0];
    outVecs[outIndex][3][1] = inVecs[inIndex][3][1];
    outVecs[outIndex][3][2] = inVecs[inIndex][3][2];
    outVecs[outIndex][3][3] = inVecs[inIndex][3][3];
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(binding = 0, std140) uniform InBuffer
{
    uvec4 inVecs[128][4];
};

layout(binding = 1, std430) buffer OutBuffer
{
    uvec4 outVecs[128][4];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outVecs[outIndex][0][0] = inVecs[inIndex][0][0];
    outVecs[outIndex][0][1] = inVecs[inIndex][0][1];
    outVecs[outIndex][0][2] = inVecs[inIndex][0][2];
    outVecs[outIndex][0][3] = inVecs[inIndex][0][3];
    outVecs[outIndex][1][0] = inVecs[inIndex][1][0];
    outVecs[outIndex][1][1] = inVecs[inIndex][1][1];
    outVecs[outIndex][1][2] = inVecs[inIndex][1][2];
    outVecs[outIndex][1][3] = inVecs[inIndex][1][3];
    outVecs[outIndex][2][0] = inVecs[inIndex][2][0];
    outVecs[outIndex][2][1] = inVecs[inIndex][2][1];
    outVecs[outIndex][2][2] = inVecs[inIndex][2][2];
    outVecs[outIndex][2][3] = inVecs[inIndex][2][3];
    outVecs[outIndex][3][0] = inVecs[inIndex][3][0];
    outVecs[outIndex][3][1] = inVecs[inIndex][3][1];
    outVecs[outIndex][3][2] = inVecs[inIndex][3][2];
    outVecs[outIndex][3][3] = inVecs[inIndex][3][3];
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(binding = 0, std430) buffer readonly InBuffer
{
    uvec4 inVecs[128][4];
};

layout(binding = 1, std430) buffer OutBuffer
{
    uvec4 outVecs[128][4];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outVecs[outIndex][0][0] = inVecs[inIndex][0][0];
    outVecs[outIndex][0][1] = inVecs[inIndex][0][1];
    outVecs[outIndex][0][2] = inVecs[inIndex][0][2];
    outVecs[outIndex][0][3] = inVecs[inIndex][0][3];
    outVecs[outIndex][1][0] = inVecs[inIndex][1][0];
    outVecs[outIndex][1][1] = inVecs[inIndex][1][1];
    outVecs[outIndex][1][2] = inVecs[inIndex][1][2];
    outVecs[outIndex][1][3] = inVecs[inIndex][1][3];
    outVecs[outIndex][2][0] = inVecs[inIndex][2][0];
    outVecs[outIndex][2][1] = inVecs[inIndex][2][1];
    outVecs[outIndex][2][2] = inVecs[inIndex][2][2];
    outVecs[outIndex][2][3] = inVecs[inIndex][2][3];
    outVecs[outIndex][3][0] = inVecs[inIndex][3][0];
    outVecs[outIndex][3][1] = inVecs[inIndex][3][1];
    outVecs[outIndex][3][2] = inVecs[inIndex][3][2];
    outVecs[outIndex][3][3] = inVecs[inIndex][3][3];
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(binding = 0, std140) uniform InBuffer
{
    mat4 inMatrix[128];
};

layout(binding = 1, std430) buffer OutBuffer
{
    mat4 outMatrix[128];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outMatrix[outIndex][0][0] = inMatrix[inIndex][0][0];
    outMatrix[outIndex][0][1] = inMatrix[inIndex][0][1];
    outMatrix[outIndex][0][2] = inMatrix[inIndex][0][2];
    outMatrix[outIndex][0][3] = inMatrix[inIndex][0][3];
    outMatrix[outIndex][1][0] = inMatrix[inIndex][1][0];
    outMatrix[outIndex][1][1] = inMatrix[inIndex][1][1];
    outMatrix[outIndex][1][2] = inMatrix[inIndex][1][2];
    outMatrix[outIndex][1][3] = inMatrix[inIndex][1][3];
    outMatrix[outIndex][2][0] = inMatrix[inIndex][2][0];
    outMatrix[outIndex][2][1] = inMatrix[inIndex][2][1];
    outMatrix[outIndex][2][2] = inMatrix[inIndex][2][2];
    outMatrix[outIndex][2][3] = inMatrix[inIndex][2][3];
    outMatrix[outIndex][3][0] = inMatrix[inIndex][3][0];
    outMatrix[outIndex][3][1] = inMatrix[inIndex][3][1];
    outMatrix[outIndex][3][2] = inMatrix[inIndex][3][2];
    outMatrix[outIndex][3][3] = inMatrix[inIndex][3][3];
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(binding = 0, std430) buffer InBuffer
{
    mat4 inMatrix[128];
};

layout(binding = 1, std430) buffer OutBuffer
{
    mat4 outMatrix[128];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outMatrix[outIndex][0][0] = inMatrix[inIndex][0][0];
    outMatrix[outIndex][0][1] = inMatrix[inIndex][0][1];
    outMatrix[outIndex][0][2] = inMatrix[inIndex][0][2];
    outMatrix[outIndex][0][3] = inMatrix[inIndex][0][3];
    outMatrix[outIndex][1][0] = inMatrix[inIndex][1][0];
    outMatrix[outIndex][1][1] = inMatrix[inIndex][1][1];
    outMatrix[outIndex][1][2] = inMatrix[inIndex][1][2];
    outMatrix[outIndex][1][3] = inMatrix[inIndex][1][3];
    outMatrix[outIndex][2][0] = inMatrix[inIndex][2][0];
    outMatrix[outIndex][2][1] = inMatrix[inIndex][2][1];
    outMatrix[outIndex][2][2] = inMatrix[inIndex][2][2];
    outMatrix[outIndex][2][3] = inMatrix[inIndex][2][3];
    outMatrix[outIndex][3][0] = inMatrix[inIndex][3][0];
    outMatrix[outIndex][3][1] = inMatrix[inIndex][3][1];
    outMatrix[outIndex][3][2] = inMatrix[inIndex][3][2];
    outMatrix[outIndex][3][3] = inMatrix[inIndex][3][3];
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) uniform highp itextureBuffer inImage;
layout(set = 0, binding = 1, rgba32i) uniform highp writeonly iimageBuffer outImage;
layout(binding = 2, std140) uniform Offsets
{
    int inOffset;
    int outOffset;
};

void main (void)
{
    for (int i = 0; i < 4; i++)
    {
        imageStore(outImage, outOffset + i, texelFetch(inImage, inOffset + i));
    }
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, rgba32i) uniform highp readonly iimageBuffer inImage;
layout(set = 0, binding = 1, rgba32i) uniform highp writeonly iimageBuffer outImage;
layout(binding = 2, std140) uniform Offsets
{
    int inOffset;
    int outOffset;
};

void main (void)
{
    for (int i = 0; i < 4; i++)
    {
        imageStore(outImage, outOffset + i, imageLoad(inImage, inOffset + i));
    }
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) uniform highp utextureBuffer inImage;
layout(set = 0, binding = 1, rgba32ui) uniform highp writeonly uimageBuffer outImage;
layout(binding = 2, std140) uniform Offsets
{
    int inOffset;
    int outOffset;
};

void main (void)
{
    for (int i = 0; i < 4; i++)
    {
        imageStore(outImage, outOffset + i, texelFetch(inImage, inOffset + i));
    }
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, rgba32ui) uniform highp readonly uimageBuffer inImage;
layout(set = 0, binding = 1, rgba32ui) uniform highp writeonly uimageBuffer outImage;
layout(binding = 2, std140) uniform Offsets
{
    int inOffset;
    int outOffset;
};

void main (void)
{
    for (int i = 0; i < 4; i++)
    {
        imageStore(outImage, outOffset + i, imageLoad(inImage, inOffset + i));
    }
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) uniform highp textureBuffer inImage;
layout(set = 0, binding = 1, rgba32f) uniform highp writeonly imageBuffer outImage;
layout(binding = 2, std140) uniform Offsets
{
    int inOffset;
    int outOffset;
};

void main (void)
{
    for (int i = 0; i < 4; i++)
    {
        imageStore(outImage, outOffset + i, texelFetch(inImage, inOffset + i));
    }
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, rgba32f) uniform highp readonly imageBuffer inImage;
layout(set = 0, binding = 1, rgba32f) uniform highp writeonly imageBuffer outImage;
layout(binding = 2, std140) uniform Offsets
{
    int inOffset;
    int outOffset;
};

void main (void)
{
    for (int i = 0; i < 4; i++)
    {
        imageStore(outImage, outOffset + i, imageLoad(inImage, inOffset + i));
    }
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) uniform highp textureBuffer inImage;
layout(set = 0, binding = 1, rgb10_a2) uniform highp writeonly imageBuffer outImage;
layout(binding = 2, std140) uniform Offsets
{
    int inOffset;
    int outOffset;
};

void main (void)
{
    for (int i = 0; i < 16; i++)
    {
        imageStore(outImage, outOffset + i, texelFetch(inImage, inOffset + i));
    }
}
#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, rgb10_a2) uniform highp readonly imageBuffer inImage;
layout(set = 0, binding = 1, rgb10_a2) uniform highp writeonly imageBuffer outImage;
layout(binding = 2, std140) uniform Offsets
{
    int inOffset;
    int outOffset;
};

void main (void)
{
    for (int i = 0; i < 16; i++)
    {
        imageStore(outImage, outOffset + i, imageLoad(inImage, inOffset + i));
    }
}
