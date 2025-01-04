#version 460
out gl_PerVertex
{
    vec4 gl_Position;
};
layout (location=0) in vec4 inPos;
layout (location=0) out flat int instanceIndex;
layout (location=1) out flat float redOffset;
void main (void) {
    gl_Position = inPos;
    instanceIndex = gl_InstanceIndex;
    redOffset = 0.125;
}
#version 460
layout (push_constant, std430) uniform PushConstantBlock {
    float redValue;
} pc;
layout (location=0) in flat int instanceIndex;
layout (location=1) in flat float redOffset;
layout (location=0) out vec4 outColor;
void main (void) {
    bool drawParamsOK = true;
    const float alphaValue = (drawParamsOK ? 1.0 : 0.0);
    outColor = vec4(pc.redValue + redOffset, float(instanceIndex), 0, alphaValue);
}
#version 460
out gl_PerVertex
{
    vec4 gl_Position;
};
layout (location=0) in vec4 inPos;
layout (location=0) out flat int instanceIndex;
layout (location=1) out flat float redOffset;
void main (void) {
    const bool passFlipFactorDown = false;
    const bool flippedTriangle = (gl_VertexIndex < 3);
    const float xCoord = ((flippedTriangle && !passFlipFactorDown) ? (inPos.x * -1.0) : inPos.x);
    gl_Position = vec4(xCoord, inPos.yzw);
    instanceIndex = gl_InstanceIndex;
    redOffset = 0.25;
}
#version 460
layout (push_constant, std430) uniform PushConstantBlock {
    float redValue;
} pc;
layout (location=0) in flat int instanceIndex;
layout (location=1) in flat float redOffset;
layout (location=0) out vec4 outColor;
void main (void) {
    bool drawParamsOK = true;
    const float alphaValue = (drawParamsOK ? 1.0 : 0.0);
    outColor = vec4(pc.redValue + redOffset, float(instanceIndex), 1, alphaValue);
}
#version 460
out gl_PerVertex
{
    vec4 gl_Position;
};
layout (location=0) in vec4 inPos;
layout (location=0) out flat int instanceIndex;
layout (location=1) out flat float redOffset;
void main (void) {
    const bool passFlipFactorDown = false;
    const bool flippedTriangle = (gl_VertexIndex < 6);
    const float xCoord = ((flippedTriangle && !passFlipFactorDown) ? (inPos.x * -1.0) : inPos.x);
    gl_Position = vec4(xCoord, inPos.yzw);
    instanceIndex = gl_InstanceIndex;
    redOffset = 0.25;
}
#version 460
out gl_PerVertex
{
    vec4 gl_Position;
};
layout (location=0) in vec4 inPos;
layout (location=0) out flat int instanceIndex;
layout (location=1) out flat float redOffset;
layout (location=3) out flat int drawIndex;
layout (location=4) out flat int baseVertex;
layout (location=5) out flat int baseInstance;
void main (void) {
    gl_Position = inPos;
    instanceIndex = gl_InstanceIndex;
    redOffset = 0.125;
    drawIndex = gl_DrawID;
    baseVertex = gl_BaseVertex;
    baseInstance = gl_BaseInstance;
}
#version 460
layout (push_constant, std430) uniform PushConstantBlock {
    float redValue;
    int drawIndex;
    int baseVertex;
    int baseInstance;
} pc;
layout (location=0) in flat int instanceIndex;
layout (location=1) in flat float redOffset;
layout (location=3) in flat int drawIndex;
layout (location=4) in flat int baseVertex;
layout (location=5) in flat int baseInstance;
layout (location=0) out vec4 outColor;
void main (void) {
    bool drawParamsOK = true;
    drawParamsOK = (drawParamsOK && (drawIndex == pc.drawIndex));
    drawParamsOK = (drawParamsOK && (baseVertex == pc.baseVertex));
    drawParamsOK = (drawParamsOK && (baseInstance == pc.baseInstance));
    const float alphaValue = (drawParamsOK ? 1.0 : 0.0);
    outColor = vec4(pc.redValue + redOffset, float(instanceIndex), 0, alphaValue);
}
#version 460
out gl_PerVertex
{
    vec4 gl_Position;
};
layout (location=0) in vec4 inPos;
layout (location=0) out flat int instanceIndex;
layout (location=1) out flat float redOffset;
layout (location=3) out flat int drawIndex;
layout (location=4) out flat int baseVertex;
layout (location=5) out flat int baseInstance;
void main (void) {
    const bool passFlipFactorDown = false;
    const bool flippedTriangle = (gl_VertexIndex < 3);
    drawIndex = gl_DrawID;
    baseVertex = gl_BaseVertex;
    baseInstance = gl_BaseInstance;
    const float xCoord = ((flippedTriangle && !passFlipFactorDown) ? (inPos.x * -1.0) : inPos.x);
    gl_Position = vec4(xCoord, inPos.yzw);
    instanceIndex = gl_InstanceIndex;
    redOffset = 0.25;
}
#version 460
layout (push_constant, std430) uniform PushConstantBlock {
    float redValue;
    int drawIndex;
    int baseVertex;
    int baseInstance;
} pc;
layout (location=0) in flat int instanceIndex;
layout (location=1) in flat float redOffset;
layout (location=3) in flat int drawIndex;
layout (location=4) in flat int baseVertex;
layout (location=5) in flat int baseInstance;
layout (location=0) out vec4 outColor;
void main (void) {
    bool drawParamsOK = true;
    drawParamsOK = (drawParamsOK && (drawIndex == pc.drawIndex));
    drawParamsOK = (drawParamsOK && (baseVertex == pc.baseVertex));
    drawParamsOK = (drawParamsOK && (baseInstance == pc.baseInstance));
    const float alphaValue = (drawParamsOK ? 1.0 : 0.0);
    outColor = vec4(pc.redValue + redOffset, float(instanceIndex), 1, alphaValue);
}
#version 460
out gl_PerVertex
{
    vec4 gl_Position;
};
layout (location=0) in vec4 inPos;
layout (location=0) out flat int instanceIndex;
layout (location=1) out flat float redOffset;
layout (location=3) out flat int drawIndex;
layout (location=4) out flat int baseVertex;
layout (location=5) out flat int baseInstance;
void main (void) {
    const bool passFlipFactorDown = false;
    const bool flippedTriangle = (gl_VertexIndex < 6);
    drawIndex = gl_DrawID;
    baseVertex = gl_BaseVertex;
    baseInstance = gl_BaseInstance;
    const float xCoord = ((flippedTriangle && !passFlipFactorDown) ? (inPos.x * -1.0) : inPos.x);
    gl_Position = vec4(xCoord, inPos.yzw);
    instanceIndex = gl_InstanceIndex;
    redOffset = 0.25;
}
#version 460
layout (vertices=3) out;
in gl_PerVertex
{
    vec4  gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
    vec4  gl_Position;
} gl_out[];
layout (location=0) in int inInstanceIndex[gl_MaxPatchVertices];
layout (location=1) in float inRedOffset[gl_MaxPatchVertices];
layout (location=0) out int outInstanceIndex[];
layout (location=1) out float outRedOffset[];
void main (void)
{
    const float xCoordFactor = 1.0;
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;
    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;
    gl_out[gl_InvocationID].gl_Position = vec4(gl_in[gl_InvocationID].gl_Position.x * xCoordFactor, gl_in[gl_InvocationID].gl_Position.yzw);
    outInstanceIndex[gl_InvocationID] = inInstanceIndex[gl_InvocationID];
    outRedOffset[gl_InvocationID] = inRedOffset[gl_InvocationID];
}
#version 460
layout (triangles, fractional_odd_spacing, cw) in;
in gl_PerVertex
{
  vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
  vec4 gl_Position;
};
layout (location=0) in int inInstanceIndex[];
layout (location=1) in float inRedOffset[];
layout (location=0) out flat int outInstanceIndex;
layout (location=1) out flat float outRedOffset;
void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    outInstanceIndex = inInstanceIndex[0];
    outRedOffset = inRedOffset[0];
}
#version 460
out gl_PerVertex
{
    vec4 gl_Position;
};
layout (location=0) in vec4 inPos;
layout (location=0) out flat int instanceIndex;
layout (location=1) out flat float redOffset;
layout (location=2) out flat float xCoordFactor;
void main (void) {
    const bool passFlipFactorDown = true;
    const bool flippedTriangle = (gl_VertexIndex < 3);
    xCoordFactor = (flippedTriangle ? -1.0 : 1.0);
    const float xCoord = ((flippedTriangle && !passFlipFactorDown) ? (inPos.x * -1.0) : inPos.x);
    gl_Position = vec4(xCoord, inPos.yzw);
    instanceIndex = gl_InstanceIndex;
    redOffset = 0.25;
}
#version 460
layout (vertices=3) out;
in gl_PerVertex
{
    vec4  gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
    vec4  gl_Position;
} gl_out[];
layout (location=0) in int inInstanceIndex[gl_MaxPatchVertices];
layout (location=1) in float inRedOffset[gl_MaxPatchVertices];
layout (location=0) out int outInstanceIndex[];
layout (location=1) out float outRedOffset[];
layout (location=2) in float inXCoordFactor[gl_MaxPatchVertices];
void main (void)
{
    const float xCoordFactor = inXCoordFactor[gl_InvocationID];
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;
    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;
    gl_out[gl_InvocationID].gl_Position = vec4(gl_in[gl_InvocationID].gl_Position.x * xCoordFactor, gl_in[gl_InvocationID].gl_Position.yzw);
    outInstanceIndex[gl_InvocationID] = inInstanceIndex[gl_InvocationID];
    outRedOffset[gl_InvocationID] = inRedOffset[gl_InvocationID];
}
#version 460
out gl_PerVertex
{
    vec4 gl_Position;
};
layout (location=0) in vec4 inPos;
layout (location=0) out flat int instanceIndex;
layout (location=1) out flat float redOffset;
layout (location=2) out flat float xCoordFactor;
void main (void) {
    const bool passFlipFactorDown = true;
    const bool flippedTriangle = (gl_VertexIndex < 6);
    xCoordFactor = (flippedTriangle ? -1.0 : 1.0);
    const float xCoord = ((flippedTriangle && !passFlipFactorDown) ? (inPos.x * -1.0) : inPos.x);
    gl_Position = vec4(xCoord, inPos.yzw);
    instanceIndex = gl_InstanceIndex;
    redOffset = 0.25;
}
#version 460
layout (vertices=3) out;
in gl_PerVertex
{
    vec4  gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
    vec4  gl_Position;
} gl_out[];
layout (location=0) in int inInstanceIndex[gl_MaxPatchVertices];
layout (location=1) in float inRedOffset[gl_MaxPatchVertices];
layout (location=3) in int inDrawIndex[gl_MaxPatchVertices];
layout (location=4) in int inBaseVertex[gl_MaxPatchVertices];
layout (location=5) in int inBaseInstance[gl_MaxPatchVertices];
layout (location=0) out int outInstanceIndex[];
layout (location=1) out float outRedOffset[];
layout (location=3) out int outDrawIndex[];
layout (location=4) out int outBaseVertex[];
layout (location=5) out int outBaseInstance[];
void main (void)
{
    const float xCoordFactor = 1.0;
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;
    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;
    gl_out[gl_InvocationID].gl_Position = vec4(gl_in[gl_InvocationID].gl_Position.x * xCoordFactor, gl_in[gl_InvocationID].gl_Position.yzw);
    outInstanceIndex[gl_InvocationID] = inInstanceIndex[gl_InvocationID];
    outRedOffset[gl_InvocationID] = inRedOffset[gl_InvocationID];
    outDrawIndex[gl_InvocationID] = inDrawIndex[gl_InvocationID];
    outBaseVertex[gl_InvocationID] = inBaseVertex[gl_InvocationID];
    outBaseInstance[gl_InvocationID] = inBaseInstance[gl_InvocationID];
}
#version 460
layout (triangles, fractional_odd_spacing, cw) in;
in gl_PerVertex
{
  vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
  vec4 gl_Position;
};
layout (location=0) in int inInstanceIndex[];
layout (location=1) in float inRedOffset[];
layout (location=3) in int inDrawIndex[];
layout (location=4) in int inBaseVertex[];
layout (location=5) in int inBaseInstance[];
layout (location=0) out flat int outInstanceIndex;
layout (location=1) out flat float outRedOffset;
layout (location=3) out flat int outDrawIndex;
layout (location=4) out flat int outBaseVertex;
layout (location=5) out flat int outBaseInstance;
void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    outInstanceIndex = inInstanceIndex[0];
    outRedOffset = inRedOffset[0];
    outDrawIndex = inDrawIndex[0];
    outBaseVertex = inBaseVertex[0];
    outBaseInstance = inBaseInstance[0];
}
#version 460
out gl_PerVertex
{
    vec4 gl_Position;
};
layout (location=0) in vec4 inPos;
layout (location=0) out flat int instanceIndex;
layout (location=1) out flat float redOffset;
layout (location=2) out flat float xCoordFactor;
layout (location=3) out flat int drawIndex;
layout (location=4) out flat int baseVertex;
layout (location=5) out flat int baseInstance;
void main (void) {
    const bool passFlipFactorDown = true;
    const bool flippedTriangle = (gl_VertexIndex < 3);
    xCoordFactor = (flippedTriangle ? -1.0 : 1.0);
    drawIndex = gl_DrawID;
    baseVertex = gl_BaseVertex;
    baseInstance = gl_BaseInstance;
    const float xCoord = ((flippedTriangle && !passFlipFactorDown) ? (inPos.x * -1.0) : inPos.x);
    gl_Position = vec4(xCoord, inPos.yzw);
    instanceIndex = gl_InstanceIndex;
    redOffset = 0.25;
}
#version 460
layout (vertices=3) out;
in gl_PerVertex
{
    vec4  gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
    vec4  gl_Position;
} gl_out[];
layout (location=0) in int inInstanceIndex[gl_MaxPatchVertices];
layout (location=1) in float inRedOffset[gl_MaxPatchVertices];
layout (location=3) in int inDrawIndex[gl_MaxPatchVertices];
layout (location=4) in int inBaseVertex[gl_MaxPatchVertices];
layout (location=5) in int inBaseInstance[gl_MaxPatchVertices];
layout (location=0) out int outInstanceIndex[];
layout (location=1) out float outRedOffset[];
layout (location=3) out int outDrawIndex[];
layout (location=4) out int outBaseVertex[];
layout (location=5) out int outBaseInstance[];
layout (location=2) in float inXCoordFactor[gl_MaxPatchVertices];
void main (void)
{
    const float xCoordFactor = inXCoordFactor[gl_InvocationID];
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;
    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;
    gl_out[gl_InvocationID].gl_Position = vec4(gl_in[gl_InvocationID].gl_Position.x * xCoordFactor, gl_in[gl_InvocationID].gl_Position.yzw);
    outInstanceIndex[gl_InvocationID] = inInstanceIndex[gl_InvocationID];
    outRedOffset[gl_InvocationID] = inRedOffset[gl_InvocationID];
    outDrawIndex[gl_InvocationID] = inDrawIndex[gl_InvocationID];
    outBaseVertex[gl_InvocationID] = inBaseVertex[gl_InvocationID];
    outBaseInstance[gl_InvocationID] = inBaseInstance[gl_InvocationID];
}
#version 460
out gl_PerVertex
{
    vec4 gl_Position;
};
layout (location=0) in vec4 inPos;
layout (location=0) out flat int instanceIndex;
layout (location=1) out flat float redOffset;
layout (location=2) out flat float xCoordFactor;
layout (location=3) out flat int drawIndex;
layout (location=4) out flat int baseVertex;
layout (location=5) out flat int baseInstance;
void main (void) {
    const bool passFlipFactorDown = true;
    const bool flippedTriangle = (gl_VertexIndex < 6);
    xCoordFactor = (flippedTriangle ? -1.0 : 1.0);
    drawIndex = gl_DrawID;
    baseVertex = gl_BaseVertex;
    baseInstance = gl_BaseInstance;
    const float xCoord = ((flippedTriangle && !passFlipFactorDown) ? (inPos.x * -1.0) : inPos.x);
    gl_Position = vec4(xCoord, inPos.yzw);
    instanceIndex = gl_InstanceIndex;
    redOffset = 0.25;
}
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
layout (location=2) in float inXCoordFactor[3];
void main() {
    for (int i = 0; i < 3; ++i) {
        const float xCoordFactor = inXCoordFactor[i];
        gl_Position = vec4(gl_in[i].gl_Position.x * xCoordFactor, gl_in[i].gl_Position.yzw);
        outInstanceIndex = inInstanceIndex[i];
        outRedOffset = inRedOffset[i];
        EmitVertex();
    }
}
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
layout (location=3) in int inDrawIndex[3];
layout (location=4) in int inBaseVertex[3];
layout (location=5) in int inBaseInstance[3];
layout (location=0) out flat int outInstanceIndex;
layout (location=1) out flat float outRedOffset;
layout (location=3) out flat int outDrawIndex;
layout (location=4) out flat int outBaseVertex;
layout (location=5) out flat int outBaseInstance;
void main() {
    for (int i = 0; i < 3; ++i) {
        const float xCoordFactor = 1.0;
        gl_Position = vec4(gl_in[i].gl_Position.x * xCoordFactor, gl_in[i].gl_Position.yzw);
        outInstanceIndex = inInstanceIndex[i];
        outRedOffset = inRedOffset[i];
        outDrawIndex = inDrawIndex[i];
        outBaseVertex = inBaseVertex[i];
        outBaseInstance = inBaseInstance[i];
        EmitVertex();
    }
}
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
layout (location=3) in int inDrawIndex[3];
layout (location=4) in int inBaseVertex[3];
layout (location=5) in int inBaseInstance[3];
layout (location=0) out flat int outInstanceIndex;
layout (location=1) out flat float outRedOffset;
layout (location=3) out flat int outDrawIndex;
layout (location=4) out flat int outBaseVertex;
layout (location=5) out flat int outBaseInstance;
layout (location=2) in float inXCoordFactor[3];
void main() {
    for (int i = 0; i < 3; ++i) {
        const float xCoordFactor = inXCoordFactor[i];
        gl_Position = vec4(gl_in[i].gl_Position.x * xCoordFactor, gl_in[i].gl_Position.yzw);
        outInstanceIndex = inInstanceIndex[i];
        outRedOffset = inRedOffset[i];
        outDrawIndex = inDrawIndex[i];
        outBaseVertex = inBaseVertex[i];
        outBaseInstance = inBaseInstance[i];
        EmitVertex();
    }
}
#version 460
layout (location=0) in vec4 inPos;
void main (void) {
    gl_Position = inPos;
    const float pointSize = 1.0;
    gl_PointSize = pointSize;
}
#version 460
layout (push_constant, std430) uniform PCBlock { vec4 color; } pc;
layout (location=0) out vec4 outColor;
void main (void) {
    outColor = pc.color;
}
#version 460
layout (location=0) in vec4 inPos;
layout (push_constant, std430) uniform PCBlock { layout(offset=16) float ptSize; } pc;
void main (void) {
    gl_Position = inPos;
    const float pointSize = pc.ptSize;
    gl_PointSize = pointSize;
}
