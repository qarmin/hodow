#version 450
layout(push_constant, std430) uniform PushConstantsBlock {
    vec4  triangleColor;
    float depthValue;
    int   viewPortIndex;
    float scaleX;
    float scaleY;
    float offsetX;
    float offsetY;
    float stripScale;
} pushConstants;
layout(location=0) in vec2 position;
out gl_PerVertex
{
    vec4 gl_Position;
};

void main() {
    vec2 vertexCoords = position;
    gl_Position = vec4(vertexCoords.x * pushConstants.scaleX + pushConstants.offsetX, vertexCoords.y * pushConstants.scaleY + pushConstants.offsetY, pushConstants.depthValue, 1.0);
    vec2 stripOffset;
    switch (gl_VertexIndex) {
    case 0: stripOffset = vec2(0.0, 0.0); break;
    case 1: stripOffset = vec2(0.0, 1.0); break;
    case 2: stripOffset = vec2(1.0, 0.0); break;
    case 3: stripOffset = vec2(1.0, 1.0); break;
    case 4: stripOffset = vec2(2.0, 0.0); break;
    case 5: stripOffset = vec2(2.0, 1.0); break;
    default: stripOffset = vec2(-1000.0); break;
    }
    gl_Position.xy += pushConstants.stripScale * stripOffset;
}
#version 450
layout(push_constant, std430) uniform PushConstantsBlock {
    vec4  triangleColor;
    float depthValue;
    int   viewPortIndex;
    float scaleX;
    float scaleY;
    float offsetX;
    float offsetY;
    float stripScale;
} pushConstants;
layout(location=0) in vec2 position;
layout(location=1) in vec2 ones;
out gl_PerVertex
{
    vec4 gl_Position;
};

void main() {
    vec2 vertexCoords = position;
    vertexCoords = vertexCoords * ones;
    gl_Position = vec4(vertexCoords.x * pushConstants.scaleX + pushConstants.offsetX, vertexCoords.y * pushConstants.scaleY + pushConstants.offsetY, pushConstants.depthValue, 1.0);
    vec2 stripOffset;
    switch (gl_VertexIndex) {
    case 0: stripOffset = vec2(0.0, 0.0); break;
    case 1: stripOffset = vec2(0.0, 1.0); break;
    case 2: stripOffset = vec2(1.0, 0.0); break;
    case 3: stripOffset = vec2(1.0, 1.0); break;
    case 4: stripOffset = vec2(2.0, 0.0); break;
    case 5: stripOffset = vec2(2.0, 1.0); break;
    default: stripOffset = vec2(-1000.0); break;
    }
    gl_Position.xy += pushConstants.stripScale * stripOffset;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require
layout(push_constant, std430) uniform PushConstantsBlock {
    vec4  triangleColor;
    float depthValue;
    int   viewPortIndex;
    float scaleX;
    float scaleY;
    float offsetX;
    float offsetY;
    float stripScale;
} pushConstants;
layout(location=0) in f16vec2 position;
out gl_PerVertex
{
    vec4 gl_Position;
};

void main() {
    f16vec2 vertexCoords = position;
    gl_Position = vec4(vertexCoords.x * pushConstants.scaleX + pushConstants.offsetX, vertexCoords.y * pushConstants.scaleY + pushConstants.offsetY, pushConstants.depthValue, 1.0);
    vec2 stripOffset;
    switch (gl_VertexIndex) {
    case 0: stripOffset = vec2(0.0, 0.0); break;
    case 1: stripOffset = vec2(0.0, 1.0); break;
    case 2: stripOffset = vec2(1.0, 0.0); break;
    case 3: stripOffset = vec2(1.0, 1.0); break;
    case 4: stripOffset = vec2(2.0, 0.0); break;
    case 5: stripOffset = vec2(2.0, 1.0); break;
    default: stripOffset = vec2(-1000.0); break;
    }
    gl_Position.xy += pushConstants.stripScale * stripOffset;
}
#version 450
layout(push_constant, std430) uniform PushConstantsBlock {
    vec4  triangleColor;
    float depthValue;
    int   viewPortIndex;
    float scaleX;
    float scaleY;
    float offsetX;
    float offsetY;
    float stripScale;
} pushConstants;
layout(location=0) in vec2 position;
layout(location=1) in vec2 scaleAndOffsetY;
out gl_PerVertex
{
    vec4 gl_Position;
};

void main() {
    vec2 vertexCoords = vec2(position.x, position.y * scaleAndOffsetY.x + scaleAndOffsetY.y);
    gl_Position = vec4(vertexCoords.x * pushConstants.scaleX + pushConstants.offsetX, vertexCoords.y * pushConstants.scaleY + pushConstants.offsetY, pushConstants.depthValue, 1.0);
    vec2 stripOffset;
    switch (gl_VertexIndex) {
    case 0: stripOffset = vec2(0.0, 0.0); break;
    case 1: stripOffset = vec2(0.0, 1.0); break;
    case 2: stripOffset = vec2(1.0, 0.0); break;
    case 3: stripOffset = vec2(1.0, 1.0); break;
    case 4: stripOffset = vec2(2.0, 0.0); break;
    case 5: stripOffset = vec2(2.0, 1.0); break;
    default: stripOffset = vec2(-1000.0); break;
    }
    gl_Position.xy += pushConstants.stripScale * stripOffset;
}
#version 450
layout(push_constant, std430) uniform PushConstantsBlock {
    vec4  triangleColor;
    float depthValue;
    int   viewPortIndex;
    float scaleX;
    float scaleY;
    float offsetX;
    float offsetY;
    float stripScale;
} pushConstants;
layout(location=0) in vec2 ones;
layout(location=1) in vec2 position;
layout(location=2) in vec4 oneZero;
out gl_PerVertex
{
    vec4 gl_Position;
};

void main() {
    vec2 vertexCoords = position;
    vertexCoords = ((vertexCoords * ones) + oneZero.zw) * oneZero.xy;
    gl_Position = vec4(vertexCoords.x * pushConstants.scaleX + pushConstants.offsetX, vertexCoords.y * pushConstants.scaleY + pushConstants.offsetY, pushConstants.depthValue, 1.0);
    vec2 stripOffset;
    switch (gl_VertexIndex) {
    case 0: stripOffset = vec2(0.0, 0.0); break;
    case 1: stripOffset = vec2(0.0, 1.0); break;
    case 2: stripOffset = vec2(1.0, 0.0); break;
    case 3: stripOffset = vec2(1.0, 1.0); break;
    case 4: stripOffset = vec2(2.0, 0.0); break;
    case 5: stripOffset = vec2(2.0, 1.0); break;
    default: stripOffset = vec2(-1000.0); break;
    }
    gl_Position.xy += pushConstants.stripScale * stripOffset;
}
#version 450
layout(push_constant, std430) uniform PushConstantsBlock {
    vec4  triangleColor;
    float depthValue;
    int   viewPortIndex;
    float scaleX;
    float scaleY;
    float offsetX;
    float offsetY;
    float stripScale;
} pushConstants;
layout(location=0) out vec4 color;
void main() {
    color = vec4(pushConstants.triangleColor);
}
#version 450
layout(push_constant, std430) uniform PushConstantsBlock {
    vec4  triangleColor;
    float depthValue;
    int   viewPortIndex;
    float scaleX;
    float scaleY;
    float offsetX;
    float offsetY;
    float stripScale;
} pushConstants;
layout(location=0, index=0) out vec4 color;
layout(location=0, index=1) out vec4 color1;
void main() {
    color = vec4(1.0, 1.0, 1.0, 1.0);
    color1 = vec4(pushConstants.triangleColor);
}
#version 450
layout(early_fragment_tests) in;
layout(push_constant, std430) uniform PushConstantsBlock {
    vec4  triangleColor;
    float depthValue;
    int   viewPortIndex;
    float scaleX;
    float scaleY;
    float offsetX;
    float offsetY;
    float stripScale;
} pushConstants;
layout(set=0, binding=0, std430) buffer AtomicBlock { uint fragCounter; } counterBuffer;
layout(location=0) out vec4 color;
void main() {
    color = vec4(pushConstants.triangleColor);
    atomicAdd(counterBuffer.fragCounter, 1u);
}
#version 450
layout(push_constant, std430) uniform PushConstantsBlock {
    vec4  triangleColor;
    float depthValue;
    int   viewPortIndex;
    float scaleX;
    float scaleY;
    float offsetX;
    float offsetY;
    float stripScale;
} pushConstants;
layout(set=0, binding=0, std430) buffer AtomicBlock { uint fragCounter; } counterBuffer;
layout(location=0) out vec4 color;
void main() {
    color = vec4(pushConstants.triangleColor);
    atomicAdd(counterBuffer.fragCounter, 1u);
    uint sampleId = gl_SampleID;
}
#version 450
layout(push_constant, std430) uniform PushConstantsBlock {
    vec4  triangleColor;
    float depthValue;
    int   viewPortIndex;
    float scaleX;
    float scaleY;
    float offsetX;
    float offsetY;
    float stripScale;
} pushConstants;
layout(location=0) out uvec4 color;
void main() {
    color = uvec4(pushConstants.triangleColor);
}
#version 450
layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
layout(push_constant, std430) uniform PushConstantsBlock {
    vec4  triangleColor;
    float depthValue;
    int   viewPortIndex;
    float scaleX;
    float scaleY;
    float offsetX;
    float offsetY;
    float stripScale;
} pushConstants;
in gl_PerVertex
{
    vec4 gl_Position;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
};
void main() {
    gl_ViewportIndex = pushConstants.viewPortIndex;
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 450
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
void main() {
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
}
#version 450
layout (lines) in;
layout (line_strip, max_vertices=2) out;
in gl_PerVertex
{
    vec4 gl_Position;
} gl_in[2];
out gl_PerVertex
{
    vec4 gl_Position;
};
void main() {
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    EmitVertex();
}
#version 450
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
  gl_TessLevelOuter[0] = 3.0;
  gl_TessLevelOuter[1] = 3.0;
  gl_TessLevelOuter[2] = 3.0;
  gl_TessLevelInner[0] = 3.0;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout(triangles) in;
in gl_PerVertex
{
  vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
  vec4 gl_Position;
};
void main() {
  gl_Position = (gl_in[0].gl_Position * gl_TessCoord.x + 
                 gl_in[1].gl_Position * gl_TessCoord.y + 
                 gl_in[2].gl_Position * gl_TessCoord.z);
}
#version 450
layout(push_constant, std430) uniform PushConstantsBlock {
    vec4  triangleColor;
    float depthValue;
    int   viewPortIndex;
    float scaleX;
    float scaleY;
    float offsetX;
    float offsetY;
    float stripScale;
} pushConstants;
layout(location=0) in vec2 position;
layout(location=0) flat out uint colorMultiplier;
out gl_PerVertex
{
    vec4 gl_Position;
};

void main() {
    vec2 vertexCoords = position;
    const bool provokingLast = false;
    colorMultiplier = (((!provokingLast && gl_VertexIndex == 0) || (provokingLast && gl_VertexIndex == 2)) ? 1 : 0);
    gl_Position = vec4(vertexCoords.x * pushConstants.scaleX + pushConstants.offsetX, vertexCoords.y * pushConstants.scaleY + pushConstants.offsetY, pushConstants.depthValue, 1.0);
    vec2 stripOffset;
    switch (gl_VertexIndex) {
    case 0: stripOffset = vec2(0.0, 0.0); break;
    case 1: stripOffset = vec2(0.0, 1.0); break;
    case 2: stripOffset = vec2(1.0, 0.0); break;
    case 3: stripOffset = vec2(1.0, 1.0); break;
    case 4: stripOffset = vec2(2.0, 0.0); break;
    case 5: stripOffset = vec2(2.0, 1.0); break;
    default: stripOffset = vec2(-1000.0); break;
    }
    gl_Position.xy += pushConstants.stripScale * stripOffset;
}
#version 450
layout(push_constant, std430) uniform PushConstantsBlock {
    vec4  triangleColor;
    float depthValue;
    int   viewPortIndex;
    float scaleX;
    float scaleY;
    float offsetX;
    float offsetY;
    float stripScale;
} pushConstants;
layout(location=0) in vec2 position;
layout(location=0) flat out uint colorMultiplier;
out gl_PerVertex
{
    vec4 gl_Position;
};

void main() {
    vec2 vertexCoords = position;
    const bool provokingLast = true;
    colorMultiplier = (((!provokingLast && gl_VertexIndex == 0) || (provokingLast && gl_VertexIndex == 2)) ? 1 : 0);
    gl_Position = vec4(vertexCoords.x * pushConstants.scaleX + pushConstants.offsetX, vertexCoords.y * pushConstants.scaleY + pushConstants.offsetY, pushConstants.depthValue, 1.0);
    vec2 stripOffset;
    switch (gl_VertexIndex) {
    case 0: stripOffset = vec2(0.0, 0.0); break;
    case 1: stripOffset = vec2(0.0, 1.0); break;
    case 2: stripOffset = vec2(1.0, 0.0); break;
    case 3: stripOffset = vec2(1.0, 1.0); break;
    case 4: stripOffset = vec2(2.0, 0.0); break;
    case 5: stripOffset = vec2(2.0, 1.0); break;
    default: stripOffset = vec2(-1000.0); break;
    }
    gl_Position.xy += pushConstants.stripScale * stripOffset;
}
#version 450
layout(push_constant, std430) uniform PushConstantsBlock {
    vec4  triangleColor;
    float depthValue;
    int   viewPortIndex;
    float scaleX;
    float scaleY;
    float offsetX;
    float offsetY;
    float stripScale;
} pushConstants;
layout(location=0) flat in uint colorMultiplier;
layout(location=0) out vec4 color;
void main() {
    color = vec4(pushConstants.triangleColor);
    color = color * float(colorMultiplier);
}
