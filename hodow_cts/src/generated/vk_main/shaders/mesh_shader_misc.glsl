#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1) in;

struct RowId {
    uint id;
};

struct WorkGroupData {
    float WorkGroupIdPlusOnex1000Iota[10];
    RowId rowId;
    uvec3 WorkGroupIdPlusOnex2000Iota;
    vec2  WorkGroupIdPlusOnex3000Iota;
};

struct ExternalData {
    float OneMillion;
    uint  TwoMillion;
    WorkGroupData workGroupData;
};

struct TaskData {
    uint yes;
    ExternalData externalData;
};
taskPayloadSharedEXT TaskData td;

void main ()
{
    td.yes = 1u;
    td.externalData.OneMillion = 1000000.0;
    td.externalData.TwoMillion = 2000000u;
    for (uint i = 0; i < 10; i++) {
        td.externalData.workGroupData.WorkGroupIdPlusOnex1000Iota[i] = float((gl_WorkGroupID.x + 1u) * 1000 + i);
    }
    {
        uint baseVal = (gl_WorkGroupID.x + 1u) * 2000;
        td.externalData.workGroupData.WorkGroupIdPlusOnex2000Iota = uvec3(baseVal, baseVal + 1, baseVal + 2);
    }
    {
        uint baseVal = (gl_WorkGroupID.x + 1u) * 3000;
        td.externalData.workGroupData.WorkGroupIdPlusOnex3000Iota = vec2(baseVal, baseVal + 1);
    }
    td.externalData.workGroupData.rowId.id = gl_WorkGroupID.x;
    EmitMeshTasksEXT(2u, 1u, 1u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=2) in;
layout(triangles) out;
layout(max_vertices=4, max_primitives=2) out;

layout (location=0) out perprimitiveEXT vec4 triangleColor[];

struct RowId {
    uint id;
};

struct WorkGroupData {
    float WorkGroupIdPlusOnex1000Iota[10];
    RowId rowId;
    uvec3 WorkGroupIdPlusOnex2000Iota;
    vec2  WorkGroupIdPlusOnex3000Iota;
};

struct ExternalData {
    float OneMillion;
    uint  TwoMillion;
    WorkGroupData workGroupData;
};

struct TaskData {
    uint yes;
    ExternalData externalData;
};
taskPayloadSharedEXT TaskData td;

void main ()
{
    bool dataOK = true;
    dataOK = (dataOK && (td.yes == 1u));
    dataOK = (dataOK && (td.externalData.OneMillion == 1000000.0 && td.externalData.TwoMillion == 2000000u));
    uint rowId = td.externalData.workGroupData.rowId.id;
    dataOK = (dataOK && (rowId == 0u || rowId == 1u));

    {
        uint baseVal = (rowId + 1u) * 1000u;
        for (uint i = 0; i < 10; i++) {
            if (td.externalData.workGroupData.WorkGroupIdPlusOnex1000Iota[i] != float(baseVal + i)) {
                dataOK = false;
                break;
            }
        }
    }

    {
        uint baseVal = (rowId + 1u) * 2000;
        uvec3 expected = uvec3(baseVal, baseVal + 1, baseVal + 2);
        if (td.externalData.workGroupData.WorkGroupIdPlusOnex2000Iota != expected) {
            dataOK = false;
        }
    }

    {
        uint baseVal = (rowId + 1u) * 3000;
        vec2 expected = vec2(baseVal, baseVal + 1);
        if (td.externalData.workGroupData.WorkGroupIdPlusOnex3000Iota != expected) {
            dataOK = false;
        }
    }

    uint columnId = gl_WorkGroupID.x;

    uvec2 vertPrim = uvec2(0u, 0u);
    if (dataOK) {
        vertPrim = uvec2(4u, 2u);
    }
    SetMeshOutputsEXT(vertPrim.x, vertPrim.y);
    if (vertPrim.y == 0u) {
        return;
    }

    const vec4 outColor = vec4(rowId, columnId, 1.0f, 1.0f);
    triangleColor[0] = outColor;
    triangleColor[1] = outColor;

    // Each local invocation will generate two points and one triangle from the quad.
    // The first local invocation will generate the top quad vertices.
    // The second invocation will generate the two bottom vertices.
    vec4 left  = vec4(0.0, 0.0, 0.0, 1.0);
    vec4 right = vec4(1.0, 0.0, 0.0, 1.0);

    float localInvocationOffsetY = float(gl_LocalInvocationIndex);
    left.y  += localInvocationOffsetY;
    right.y += localInvocationOffsetY;

    // The code above creates a quad from (0, 0) to (1, 1) but we need to offset it
    // in X and/or Y depending on the row and column, to place it in other quadrants.
    float quadrantOffsetX = float(int(columnId) - 1);
    float quadrantOffsetY = float(int(rowId) - 1);

    left.x  += quadrantOffsetX;
    right.x += quadrantOffsetX;

    left.y  += quadrantOffsetY;
    right.y += quadrantOffsetY;

    uint baseVertexId = 2*gl_LocalInvocationIndex;
    gl_MeshVerticesEXT[baseVertexId + 0].gl_Position = left;
    gl_MeshVerticesEXT[baseVertexId + 1].gl_Position = right;

    // 0,1,2 or 1,2,3 (note: triangles alternate front face this way)
    const uvec3 indices = uvec3(0 + gl_LocalInvocationIndex, 1 + gl_LocalInvocationIndex, 2 + gl_LocalInvocationIndex);
    gl_PrimitiveTriangleIndicesEXT[gl_LocalInvocationIndex] = indices;
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (location=0) in perprimitiveEXT vec4 primitiveColor;
layout (location=0) out vec4 outColor;

void main ()
{
    outColor = primitiveColor;
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;
layout(points) out;
layout(max_vertices=256, max_primitives=256) out;

layout (location=0) out perprimitiveEXT vec4 pointColor[];

void main ()
{
    SetMeshOutputsEXT(1u, 1u);
    pointColor[0] = vec4(0.0f, 1.0f, 1.0f, 1.0f);
    gl_MeshVerticesEXT[0].gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
    gl_MeshVerticesEXT[0].gl_PointSize = 1.0f;
    gl_PrimitivePointIndicesEXT[0] = 0;
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;
layout(points) out;
layout(max_vertices=256, max_primitives=256) out;

layout (location=0) out perprimitiveEXT vec4 pointColor[];

void main ()
{
    SetMeshOutputsEXT(1u, 1u);
    pointColor[0] = vec4(0.0f, 1.0f, 1.0f, 1.0f);
    gl_MeshVerticesEXT[0].gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
    gl_PrimitivePointIndicesEXT[0] = 0;
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;
layout(lines) out;
layout(max_vertices=256, max_primitives=256) out;

layout (location=0) out perprimitiveEXT vec4 lineColor[];

void main ()
{
    SetMeshOutputsEXT(2u, 1u);
    lineColor[0] = vec4(0.0f, 1.0f, 1.0f, 1.0f);
    gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0f, 0.0f, 0.0f, 1.0f);
    gl_MeshVerticesEXT[1].gl_Position = vec4( 1.0f, 0.0f, 0.0f, 1.0f);
    gl_PrimitiveLineIndicesEXT[gl_LocalInvocationIndex] = uvec2(0u, 1u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=256, max_primitives=256) out;

layout (location=0) out perprimitiveEXT vec4 triangleColor[];

void main ()
{
    SetMeshOutputsEXT(3u, 1u);
    triangleColor[0] = vec4(0.0f, 1.0f, 1.0f, 1.0f);
    gl_MeshVerticesEXT[0].gl_Position = vec4(0.285714, -0.4, 0.0f, 1.0f);
    gl_MeshVerticesEXT[1].gl_Position = vec4(0.285714, 0.4, 0.0f, 1.0f);
    gl_MeshVerticesEXT[2].gl_Position = vec4(-0.285714, 0.0f, 0.0f, 1.0f);
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0u, 1u, 2u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=8, local_size_y=2, local_size_z=4) in;
layout(points) out;
layout(max_vertices=256, max_primitives=256) out;

layout (location=0) out perprimitiveEXT vec4 pointColor[];

void main ()
{
    SetMeshOutputsEXT(256u, 256u);
    uint firstPixel = 4u * gl_LocalInvocationIndex;
    uint row = firstPixel / 16u;
    uint col = firstPixel % 16u;
    float pixSize = 2.0f / 16.0f;
    float yCoord = pixSize * (float(row) + 0.5f) - 1.0f;
    float baseXCoord = pixSize * (float(col) + 0.5f) - 1.0f;
    for (uint i = 0; i < 4u; i++) {
        float xCoord = baseXCoord + pixSize * float(i);
        uint pixId = firstPixel + i;
        gl_MeshVerticesEXT[pixId].gl_Position = vec4(xCoord, yCoord, 0.0f, 1.0f);
        gl_MeshVerticesEXT[pixId].gl_PointSize = 1.0f;
        gl_PrimitivePointIndicesEXT[pixId] = pixId;
        pointColor[pixId] = vec4(((xCoord + 1.0f) / 2.0f), ((yCoord + 1.0f) / 2.0f), 0.0f, 1.0f);
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=4, local_size_y=2, local_size_z=8) in;
layout(lines) out;
layout(max_vertices=256, max_primitives=255) out;

layout (location=0) out perprimitiveEXT vec4 lineColor[];

void main ()
{
    SetMeshOutputsEXT(256u, 255u);
    uint firstLine = 4u * gl_LocalInvocationIndex;
    for (uint i = 0u; i < 4u; i++) {
        uint lineId = firstLine + i;
        uint topPixel = 4u * lineId;
        uint bottomPixel = 3u + topPixel;
        if (bottomPixel < 1020u) {
            float bottomCoord = ((float(bottomPixel) + 1.0f) / 1020.0) * 2.0 - 1.0;
            gl_MeshVerticesEXT[lineId + 1u].gl_Position = vec4(0.0, bottomCoord, 0.0f, 1.0f);
            gl_PrimitiveLineIndicesEXT[lineId] = uvec2(lineId, lineId + 1u);
            lineColor[lineId] = vec4(0.0f, 1.0f, float(lineId) / 255.0f, 1.0f);
        } else {
            // The last iteration of the last invocation emits the first point
            gl_MeshVerticesEXT[0].gl_Position = vec4(0.0, -1.0, 0.0f, 1.0f);
        }
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=2, local_size_y=4, local_size_z=8) in;
layout(triangles) out;
layout(max_vertices=256, max_primitives=254) out;

layout (location=0) out perprimitiveEXT vec4 triangleColor[];

const float PI_2 = 1.57079632679489661923;
const float RADIUS = 4.5;

void main ()
{
    const uint trianglesPerInvocation = 4u;
    const uint numVertices = 256u;
    const uint numTriangles = 254u;
    const float fNumTriangles = float(numTriangles);
    SetMeshOutputsEXT(numVertices, numTriangles);
    uint firstTriangle = trianglesPerInvocation * gl_LocalInvocationIndex;
    for (uint i = 0u; i < trianglesPerInvocation; i++) {
        uint triangleId = firstTriangle + i;
        if (triangleId < numTriangles) {
            uint vertexId = triangleId + 2u;
            float angleProportion = float(vertexId - 1u) / fNumTriangles;
            float angle = PI_2 * angleProportion;
            float xCoord = cos(angle) * RADIUS - 1.0;
            float yCoord = sin(angle) * RADIUS - 1.0;
            gl_MeshVerticesEXT[vertexId].gl_Position = vec4(xCoord, yCoord, 0.0, 1.0);
            gl_PrimitiveTriangleIndicesEXT[triangleId] = uvec3(0u, triangleId + 1u, triangleId + 2u);
            triangleColor[triangleId] = vec4(0.0f, 0.0f, 1.0f, 1.0f);
        } else {
            // The last iterations of the last invocation emit the first two vertices
            uint vertexId = triangleId - numTriangles;
            if (vertexId == 0u) {
                gl_MeshVerticesEXT[0u].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
            } else {
                gl_MeshVerticesEXT[1u].gl_Position = vec4(RADIUS, -1.0, 0.0, 1.0);
            }
        }
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=4, local_size_y=2, local_size_z=4) in;
layout(triangles) out;
layout(max_vertices=256, max_primitives=254) out;

layout (location=0) out perprimitiveEXT vec4 triangleColor[];

const float PI_2 = 1.57079632679489661923;
const float RADIUS = 4.5;

void main ()
{
    const uint trianglesPerInvocation = 8u;
    const uint numVertices = 256u;
    const uint numTriangles = 254u;
    const float fNumTriangles = float(numTriangles);
    SetMeshOutputsEXT(numVertices, numTriangles);
    uint firstTriangle = trianglesPerInvocation * gl_LocalInvocationIndex;
    for (uint i = 0u; i < trianglesPerInvocation; i++) {
        uint triangleId = firstTriangle + i;
        if (triangleId < numTriangles) {
            uint vertexId = triangleId + 2u;
            float angleProportion = float(vertexId - 1u) / fNumTriangles;
            float angle = PI_2 * angleProportion;
            float xCoord = cos(angle) * RADIUS - 1.0;
            float yCoord = sin(angle) * RADIUS - 1.0;
            gl_MeshVerticesEXT[vertexId].gl_Position = vec4(xCoord, yCoord, 0.0, 1.0);
            gl_PrimitiveTriangleIndicesEXT[triangleId] = uvec3(0u, triangleId + 1u, triangleId + 2u);
            triangleColor[triangleId] = vec4(0.0f, 0.0f, 1.0f, 1.0f);
        } else {
            // The last iterations of the last invocation emit the first two vertices
            uint vertexId = triangleId - numTriangles;
            if (vertexId == 0u) {
                gl_MeshVerticesEXT[0u].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
            } else {
                gl_MeshVerticesEXT[1u].gl_Position = vec4(RADIUS, -1.0, 0.0, 1.0);
            }
        }
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=2, local_size_y=2, local_size_z=4) in;
layout(triangles) out;
layout(max_vertices=256, max_primitives=254) out;

layout (location=0) out perprimitiveEXT vec4 triangleColor[];

const float PI_2 = 1.57079632679489661923;
const float RADIUS = 4.5;

void main ()
{
    const uint trianglesPerInvocation = 16u;
    const uint numVertices = 256u;
    const uint numTriangles = 254u;
    const float fNumTriangles = float(numTriangles);
    SetMeshOutputsEXT(numVertices, numTriangles);
    uint firstTriangle = trianglesPerInvocation * gl_LocalInvocationIndex;
    for (uint i = 0u; i < trianglesPerInvocation; i++) {
        uint triangleId = firstTriangle + i;
        if (triangleId < numTriangles) {
            uint vertexId = triangleId + 2u;
            float angleProportion = float(vertexId - 1u) / fNumTriangles;
            float angle = PI_2 * angleProportion;
            float xCoord = cos(angle) * RADIUS - 1.0;
            float yCoord = sin(angle) * RADIUS - 1.0;
            gl_MeshVerticesEXT[vertexId].gl_Position = vec4(xCoord, yCoord, 0.0, 1.0);
            gl_PrimitiveTriangleIndicesEXT[triangleId] = uvec3(0u, triangleId + 1u, triangleId + 2u);
            triangleColor[triangleId] = vec4(0.0f, 0.0f, 1.0f, 1.0f);
        } else {
            // The last iterations of the last invocation emit the first two vertices
            uint vertexId = triangleId - numTriangles;
            if (vertexId == 0u) {
                gl_MeshVerticesEXT[0u].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
            } else {
                gl_MeshVerticesEXT[1u].gl_Position = vec4(RADIUS, -1.0, 0.0, 1.0);
            }
        }
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

struct TaskData {
    uint parentTask[1];
};
taskPayloadSharedEXT TaskData td;

layout(binding = 0, rgba8) writeonly uniform highp image2D u_dstImg;
void main () {
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z + gl_NumWorkGroups.x * gl_WorkGroupID.y + gl_WorkGroupID.x;
    td.parentTask[gl_LocalInvocationIndex] = workGroupIndex;
    imageStore(u_dstImg, ivec2(mod(workGroupIndex, 2040u), workGroupIndex / 2040u), vec4(0.0, 0.0, 1.0, 1.0));
    EmitMeshTasksEXT(0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;
layout (points) out;
layout (max_vertices=1, max_primitives=1) out;

struct TaskData {
    uint parentTask[1];
};
taskPayloadSharedEXT TaskData td;

layout (location=0) out perprimitiveEXT vec4 pointColor[];

void main () {
    uint parentTask = td.parentTask[0];
    if (td.parentTask[gl_LocalInvocationIndex] != parentTask || parentTask >= 4194240) {
        return;
    }
    SetMeshOutputsEXT(1, 1);
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z + gl_NumWorkGroups.x * gl_WorkGroupID.y + gl_WorkGroupID.x;
    uint jobId = ((parentTask * 0) + workGroupIndex) * 1 + gl_LocalInvocationIndex;
    uint row = jobId / 2040;
    uint col = jobId % 2040;
    float yCoord = (float(row + 0.5) / 2056.0) * 2.0 - 1.0;
    float xCoord = (float(col + 0.5) / 2040.0) * 2.0 - 1.0;
    gl_MeshVerticesEXT[gl_LocalInvocationIndex].gl_Position = vec4(xCoord, yCoord, 0.0, 1.0);
    gl_MeshVerticesEXT[gl_LocalInvocationIndex].gl_PointSize = 1.0;
    gl_PrimitivePointIndicesEXT[gl_LocalInvocationIndex] = gl_LocalInvocationIndex;
    vec4 resultColor = vec4(0.0, 0.0, 1.0, 1.0);
    pointColor[gl_LocalInvocationIndex] = resultColor;
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;
layout (points) out;
layout (max_vertices=1, max_primitives=1) out;


layout (location=0) out perprimitiveEXT vec4 pointColor[];

void main () {
    uint parentTask = 0;
    SetMeshOutputsEXT(1, 1);
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z + gl_NumWorkGroups.x * gl_WorkGroupID.y + gl_WorkGroupID.x;
    uint jobId = ((parentTask * 4194240) + workGroupIndex) * 1 + gl_LocalInvocationIndex;
    uint row = jobId / 2040;
    uint col = jobId % 2040;
    float yCoord = (float(row + 0.5) / 2056.0) * 2.0 - 1.0;
    float xCoord = (float(col + 0.5) / 2040.0) * 2.0 - 1.0;
    gl_MeshVerticesEXT[gl_LocalInvocationIndex].gl_Position = vec4(xCoord, yCoord, 0.0, 1.0);
    gl_MeshVerticesEXT[gl_LocalInvocationIndex].gl_PointSize = 1.0;
    gl_PrimitivePointIndicesEXT[gl_LocalInvocationIndex] = gl_LocalInvocationIndex;
    vec4 resultColor = vec4(0.0, 0.0, 1.0, 1.0);
    pointColor[gl_LocalInvocationIndex] = resultColor;
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=128, local_size_y=1, local_size_z=1) in;

struct TaskData {
    uint parentTask[128];
};
taskPayloadSharedEXT TaskData td;

void main () {
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z + gl_NumWorkGroups.x * gl_WorkGroupID.y + gl_WorkGroupID.x;
    td.parentTask[gl_LocalInvocationIndex] = workGroupIndex;
   EmitMeshTasksEXT(256, 1, 1);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=128, local_size_y=1, local_size_z=1) in;
layout (points) out;
layout (max_vertices=128, max_primitives=128) out;

struct TaskData {
    uint parentTask[128];
};
taskPayloadSharedEXT TaskData td;

layout (location=0) out perprimitiveEXT vec4 pointColor[];

void main () {
    uint parentTask = td.parentTask[0];
    if (td.parentTask[gl_LocalInvocationIndex] != parentTask || parentTask >= 128) {
        return;
    }
    SetMeshOutputsEXT(128, 128);
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z + gl_NumWorkGroups.x * gl_WorkGroupID.y + gl_WorkGroupID.x;
    uint jobId = ((parentTask * 256) + workGroupIndex) * 128 + gl_LocalInvocationIndex;
    uint row = jobId / 2048;
    uint col = jobId % 2048;
    float yCoord = (float(row + 0.5) / 2048.0) * 2.0 - 1.0;
    float xCoord = (float(col + 0.5) / 2048.0) * 2.0 - 1.0;
    gl_MeshVerticesEXT[gl_LocalInvocationIndex].gl_Position = vec4(xCoord, yCoord, 0.0, 1.0);
    gl_MeshVerticesEXT[gl_LocalInvocationIndex].gl_PointSize = 1.0;
    gl_PrimitivePointIndicesEXT[gl_LocalInvocationIndex] = gl_LocalInvocationIndex;
    vec4 resultColor = vec4(0.0, 0.0, 1.0, 1.0);
    pointColor[gl_LocalInvocationIndex] = resultColor;
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1, local_size_y=128, local_size_z=1) in;

struct TaskData {
    uint parentTask[128];
};
taskPayloadSharedEXT TaskData td;

void main () {
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z + gl_NumWorkGroups.x * gl_WorkGroupID.y + gl_WorkGroupID.x;
    td.parentTask[gl_LocalInvocationIndex] = workGroupIndex;
   EmitMeshTasksEXT(1, 256, 1);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1, local_size_y=128, local_size_z=1) in;
layout (points) out;
layout (max_vertices=128, max_primitives=128) out;

struct TaskData {
    uint parentTask[128];
};
taskPayloadSharedEXT TaskData td;

layout (location=0) out perprimitiveEXT vec4 pointColor[];

void main () {
    uint parentTask = td.parentTask[0];
    if (td.parentTask[gl_LocalInvocationIndex] != parentTask || parentTask >= 128) {
        return;
    }
    SetMeshOutputsEXT(128, 128);
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z + gl_NumWorkGroups.x * gl_WorkGroupID.y + gl_WorkGroupID.x;
    uint jobId = ((parentTask * 256) + workGroupIndex) * 128 + gl_LocalInvocationIndex;
    uint row = jobId / 2048;
    uint col = jobId % 2048;
    float yCoord = (float(row + 0.5) / 2048.0) * 2.0 - 1.0;
    float xCoord = (float(col + 0.5) / 2048.0) * 2.0 - 1.0;
    gl_MeshVerticesEXT[gl_LocalInvocationIndex].gl_Position = vec4(xCoord, yCoord, 0.0, 1.0);
    gl_MeshVerticesEXT[gl_LocalInvocationIndex].gl_PointSize = 1.0;
    gl_PrimitivePointIndicesEXT[gl_LocalInvocationIndex] = gl_LocalInvocationIndex;
    vec4 resultColor = vec4(0.0, 0.0, 1.0, 1.0);
    pointColor[gl_LocalInvocationIndex] = resultColor;
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1, local_size_y=1, local_size_z=128) in;

struct TaskData {
    uint parentTask[128];
};
taskPayloadSharedEXT TaskData td;

void main () {
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z + gl_NumWorkGroups.x * gl_WorkGroupID.y + gl_WorkGroupID.x;
    td.parentTask[gl_LocalInvocationIndex] = workGroupIndex;
   EmitMeshTasksEXT(1, 1, 256);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1, local_size_y=1, local_size_z=128) in;
layout (points) out;
layout (max_vertices=128, max_primitives=128) out;

struct TaskData {
    uint parentTask[128];
};
taskPayloadSharedEXT TaskData td;

layout (location=0) out perprimitiveEXT vec4 pointColor[];

void main () {
    uint parentTask = td.parentTask[0];
    if (td.parentTask[gl_LocalInvocationIndex] != parentTask || parentTask >= 128) {
        return;
    }
    SetMeshOutputsEXT(128, 128);
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z + gl_NumWorkGroups.x * gl_WorkGroupID.y + gl_WorkGroupID.x;
    uint jobId = ((parentTask * 256) + workGroupIndex) * 128 + gl_LocalInvocationIndex;
    uint row = jobId / 2048;
    uint col = jobId % 2048;
    float yCoord = (float(row + 0.5) / 2048.0) * 2.0 - 1.0;
    float xCoord = (float(col + 0.5) / 2048.0) * 2.0 - 1.0;
    gl_MeshVerticesEXT[gl_LocalInvocationIndex].gl_Position = vec4(xCoord, yCoord, 0.0, 1.0);
    gl_MeshVerticesEXT[gl_LocalInvocationIndex].gl_PointSize = 1.0;
    gl_PrimitivePointIndicesEXT[gl_LocalInvocationIndex] = gl_LocalInvocationIndex;
    vec4 resultColor = vec4(0.0, 0.0, 1.0, 1.0);
    pointColor[gl_LocalInvocationIndex] = resultColor;
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=128) in;
layout (points) out;
layout (max_vertices=256, max_primitives=256) out;

layout (location=0) out perprimitiveEXT vec4 primitiveColor[];

void main () {
    SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=128) in;
layout (lines) out;
layout (max_vertices=256, max_primitives=256) out;

layout (location=0) out perprimitiveEXT vec4 primitiveColor[];

void main () {
    SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=128) in;
layout (triangles) out;
layout (max_vertices=256, max_primitives=256) out;

layout (location=0) out perprimitiveEXT vec4 primitiveColor[];

void main () {
    SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=32) in;

shared uint counter;

void main ()
{
    uvec3 workGroupSize = uvec3(0u, 0u, 0u);
counter = 0;
memoryBarrierShared();
barrier();
atomicAdd(counter, 1u);
memoryBarrierShared();
barrier();
if (gl_LocalInvocationIndex == 0u) {
    if (counter == 32) {

workGroupSize = uvec3(1u, 1u, 1u);

    } else {

workGroupSize = uvec3(0u, 0u, 0u);

    }
}
    EmitMeshTasksEXT(workGroupSize.x, workGroupSize.y, workGroupSize.z);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1) in;
layout (points) out;
layout (max_vertices=1, max_primitives=1) out;

layout (location=0) out perprimitiveEXT vec4 primitiveColor[];

void main ()
{
    uvec2 vertPrim = uvec2(0u, 0u);
vertPrim = uvec2(1u, 1u);
    SetMeshOutputsEXT(vertPrim.x, vertPrim.y);
    if (gl_LocalInvocationIndex == 0u && vertPrim.x > 0u) {
        gl_MeshVerticesEXT[0].gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
        gl_MeshVerticesEXT[0].gl_PointSize = 1.0;
        primitiveColor[0] = vec4(0.0, 0.0, 1.0, 1.0);
        gl_PrimitivePointIndicesEXT[0] = 0;
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=32) in;
layout (points) out;
layout (max_vertices=1, max_primitives=1) out;

layout (location=0) out perprimitiveEXT vec4 primitiveColor[];

shared uint counter;

void main ()
{
    uvec2 vertPrim = uvec2(0u, 0u);
counter = 0;
memoryBarrierShared();
barrier();
atomicAdd(counter, 1u);
memoryBarrierShared();
barrier();
if (gl_LocalInvocationIndex == 0u) {
    if (counter == 32) {

vertPrim = uvec2(1u, 1u);

    } else {

vertPrim = uvec2(0u, 0u);

    }
}
    SetMeshOutputsEXT(vertPrim.x, vertPrim.y);
    if (gl_LocalInvocationIndex == 0u && vertPrim.x > 0u) {
        gl_MeshVerticesEXT[0].gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
        gl_MeshVerticesEXT[0].gl_PointSize = 1.0;
        primitiveColor[0] = vec4(0.0, 0.0, 1.0, 1.0);
        gl_PrimitivePointIndicesEXT[0] = 0;
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=2) in;

shared uint flags[2];

struct TaskData { float blue; }; taskPayloadSharedEXT TaskData td;

void main ()
{
    uvec3 workGroupSize = uvec3(0u, 0u, 0u);
flags[gl_LocalInvocationIndex] = 0u;
barrier();
flags[gl_LocalInvocationIndex] = 1u;
memoryBarrierShared();
uint otherInvocation = 1u - gl_LocalInvocationIndex;
uint iterations = 0u;
while (flags[otherInvocation] != 1u) {
    iterations++;
}
if (gl_LocalInvocationIndex == 0u) {

td.blue = float(iterations % 2u);
workGroupSize = uvec3(1u, 1u, 1u);

}
    EmitMeshTasksEXT(workGroupSize.x, workGroupSize.y, workGroupSize.z);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1) in;
layout (points) out;
layout (max_vertices=1, max_primitives=1) out;

layout (location=0) out perprimitiveEXT vec4 primitiveColor[];

struct TaskData { float blue; }; taskPayloadSharedEXT TaskData td;

void main ()
{
    uvec2 vertPrim = uvec2(0u, 0u);
vertPrim = uvec2(1u, 1u);
    SetMeshOutputsEXT(vertPrim.x, vertPrim.y);
    if (gl_LocalInvocationIndex == 0u && vertPrim.x > 0u) {
        gl_MeshVerticesEXT[0].gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
        gl_MeshVerticesEXT[0].gl_PointSize = 1.0;
        primitiveColor[0] = vec4(0.0, 0.0, td.blue, 1.0);
        gl_PrimitivePointIndicesEXT[0] = 0;
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=2) in;

shared uint flags[2];

taskPayloadSharedEXT float blue;

void main ()
{
    uvec3 workGroupSize = uvec3(0u, 0u, 0u);
flags[gl_LocalInvocationIndex] = 0u;
barrier();
flags[gl_LocalInvocationIndex] = 1u;
memoryBarrierShared();
uint otherInvocation = 1u - gl_LocalInvocationIndex;
uint iterations = 0u;
while (flags[otherInvocation] != 1u) {
    iterations++;
}
if (gl_LocalInvocationIndex == 0u) {

blue = float(iterations % 2u);
workGroupSize = uvec3(1u, 1u, 1u);

}
    EmitMeshTasksEXT(workGroupSize.x, workGroupSize.y, workGroupSize.z);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1) in;
layout (points) out;
layout (max_vertices=1, max_primitives=1) out;

layout (location=0) out perprimitiveEXT vec4 primitiveColor[];

taskPayloadSharedEXT float blue;

void main ()
{
    uvec2 vertPrim = uvec2(0u, 0u);
vertPrim = uvec2(1u, 1u);
    SetMeshOutputsEXT(vertPrim.x, vertPrim.y);
    if (gl_LocalInvocationIndex == 0u && vertPrim.x > 0u) {
        gl_MeshVerticesEXT[0].gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
        gl_MeshVerticesEXT[0].gl_PointSize = 1.0;
        primitiveColor[0] = vec4(0.0, 0.0, blue, 1.0);
        gl_PrimitivePointIndicesEXT[0] = 0;
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=2) in;

shared uint flags[2];

taskPayloadSharedEXT vec4 blue;

void main ()
{
    uvec3 workGroupSize = uvec3(0u, 0u, 0u);
flags[gl_LocalInvocationIndex] = 0u;
barrier();
flags[gl_LocalInvocationIndex] = 1u;
memoryBarrierShared();
uint otherInvocation = 1u - gl_LocalInvocationIndex;
uint iterations = 0u;
while (flags[otherInvocation] != 1u) {
    iterations++;
}
if (gl_LocalInvocationIndex == 0u) {

blue = vec4(7.0f, float(iterations % 2u), 7.0f, 7.0f);
workGroupSize = uvec3(1u, 1u, 1u);

}
    EmitMeshTasksEXT(workGroupSize.x, workGroupSize.y, workGroupSize.z);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1) in;
layout (points) out;
layout (max_vertices=1, max_primitives=1) out;

layout (location=0) out perprimitiveEXT vec4 primitiveColor[];

taskPayloadSharedEXT vec4 blue;

void main ()
{
    uvec2 vertPrim = uvec2(0u, 0u);
vertPrim = uvec2(1u, 1u);
    SetMeshOutputsEXT(vertPrim.x, vertPrim.y);
    if (gl_LocalInvocationIndex == 0u && vertPrim.x > 0u) {
        gl_MeshVerticesEXT[0].gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
        gl_MeshVerticesEXT[0].gl_PointSize = 1.0;
        primitiveColor[0] = vec4(0.0, 0.0, blue.y, 1.0);
        gl_PrimitivePointIndicesEXT[0] = 0;
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=2) in;

shared uint flags[2];

taskPayloadSharedEXT float blue[4];

void main ()
{
    uvec3 workGroupSize = uvec3(0u, 0u, 0u);
flags[gl_LocalInvocationIndex] = 0u;
barrier();
flags[gl_LocalInvocationIndex] = 1u;
memoryBarrierShared();
uint otherInvocation = 1u - gl_LocalInvocationIndex;
uint iterations = 0u;
while (flags[otherInvocation] != 1u) {
    iterations++;
}
if (gl_LocalInvocationIndex == 0u) {

blue[0] = 7.0f;
blue[1] = 7.0f;
blue[2] = float(iterations % 2u);
blue[3]=7.0f;
workGroupSize = uvec3(1u, 1u, 1u);

}
    EmitMeshTasksEXT(workGroupSize.x, workGroupSize.y, workGroupSize.z);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1) in;
layout (points) out;
layout (max_vertices=1, max_primitives=1) out;

layout (location=0) out perprimitiveEXT vec4 primitiveColor[];

taskPayloadSharedEXT float blue[4];

void main ()
{
    uvec2 vertPrim = uvec2(0u, 0u);
vertPrim = uvec2(1u, 1u);
    SetMeshOutputsEXT(vertPrim.x, vertPrim.y);
    if (gl_LocalInvocationIndex == 0u && vertPrim.x > 0u) {
        gl_MeshVerticesEXT[0].gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
        gl_MeshVerticesEXT[0].gl_PointSize = 1.0;
        primitiveColor[0] = vec4(0.0, 0.0, blue[2], 1.0);
        gl_PrimitivePointIndicesEXT[0] = 0;
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable

layout (local_size_x=2) in;

shared uint flags[2];

taskPayloadSharedEXT uint64_t blue;

void main ()
{
    uvec3 workGroupSize = uvec3(0u, 0u, 0u);
flags[gl_LocalInvocationIndex] = 0u;
barrier();
flags[gl_LocalInvocationIndex] = 1u;
memoryBarrierShared();
uint otherInvocation = 1u - gl_LocalInvocationIndex;
uint iterations = 0u;
while (flags[otherInvocation] != 1u) {
    iterations++;
}
if (gl_LocalInvocationIndex == 0u) {

blue = uint64_t(iterations % 2u) << 24;
workGroupSize = uvec3(1u, 1u, 1u);

}
    EmitMeshTasksEXT(workGroupSize.x, workGroupSize.y, workGroupSize.z);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable

layout (local_size_x=1) in;
layout (points) out;
layout (max_vertices=1, max_primitives=1) out;

layout (location=0) out perprimitiveEXT vec4 primitiveColor[];

taskPayloadSharedEXT uint64_t blue;

void main ()
{
    uvec2 vertPrim = uvec2(0u, 0u);
vertPrim = uvec2(1u, 1u);
    SetMeshOutputsEXT(vertPrim.x, vertPrim.y);
    if (gl_LocalInvocationIndex == 0u && vertPrim.x > 0u) {
        gl_MeshVerticesEXT[0].gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
        gl_MeshVerticesEXT[0].gl_PointSize = 1.0;
        primitiveColor[0] = vec4(0.0, 0.0, float(blue >> 24), 1.0);
        gl_PrimitivePointIndicesEXT[0] = 0;
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=2) in;
layout (points) out;
layout (max_vertices=1, max_primitives=1) out;

layout (location=0) out perprimitiveEXT vec4 primitiveColor[];

shared uint flags[2];

void main ()
{
    uvec2 vertPrim = uvec2(0u, 0u);
flags[gl_LocalInvocationIndex] = 0u;
barrier();
flags[gl_LocalInvocationIndex] = 1u;
memoryBarrierShared();
uint otherInvocation = 1u - gl_LocalInvocationIndex;
uint iterations = 0u;
while (flags[otherInvocation] != 1u) {
    iterations++;
}
if (gl_LocalInvocationIndex == 0u) {

vertPrim = uvec2(1u, 1u);

}
    SetMeshOutputsEXT(vertPrim.x, vertPrim.y);
    if (gl_LocalInvocationIndex == 0u && vertPrim.x > 0u) {
        gl_MeshVerticesEXT[0].gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
        gl_MeshVerticesEXT[0].gl_PointSize = 1.0;
        primitiveColor[0] = vec4(0.0, 0.0, float(iterations % 2u), 1.0);
        gl_PrimitivePointIndicesEXT[0] = 0;
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable

layout (local_size_x=2) in;
layout (points) out;
layout (max_vertices=1, max_primitives=1) out;

layout (location=0) out perprimitiveEXT vec4 primitiveColor[];

shared uint flags[2];

void main ()
{
    uvec2 vertPrim = uvec2(0u, 0u);
flags[gl_LocalInvocationIndex] = 0u;
barrier();
flags[gl_LocalInvocationIndex] = 1u;
memoryBarrierShared();
uint otherInvocation = 1u - gl_LocalInvocationIndex;
uint iterations = 0u;
while (flags[otherInvocation] != 1u) {
    iterations++;
}
if (gl_LocalInvocationIndex == 0u) {

vertPrim = uvec2(1u, 1u);

}
    SetMeshOutputsEXT(vertPrim.x, vertPrim.y);
    if (gl_LocalInvocationIndex == 0u && vertPrim.x > 0u) {
        gl_MeshVerticesEXT[0].gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
        gl_MeshVerticesEXT[0].gl_PointSize = 1.0;
        primitiveColor[0] = vec4(0.0, 0.0, float(iterations % 2u), 1.0);
        gl_PrimitivePointIndicesEXT[0] = 0;
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=2) in;

shared uint flags[2];

struct TaskData { float blue; }; taskPayloadSharedEXT TaskData td;

void main ()
{
    uvec3 workGroupSize = uvec3(0u, 0u, 0u);
flags[gl_LocalInvocationIndex] = 0u;
barrier();
flags[gl_LocalInvocationIndex] = 1u;
groupMemoryBarrier();
uint otherInvocation = 1u - gl_LocalInvocationIndex;
uint iterations = 0u;
while (flags[otherInvocation] != 1u) {
    iterations++;
}
if (gl_LocalInvocationIndex == 0u) {

td.blue = float(iterations % 2u);
workGroupSize = uvec3(1u, 1u, 1u);

}
    EmitMeshTasksEXT(workGroupSize.x, workGroupSize.y, workGroupSize.z);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=2) in;

shared uint flags[2];

taskPayloadSharedEXT float blue;

void main ()
{
    uvec3 workGroupSize = uvec3(0u, 0u, 0u);
flags[gl_LocalInvocationIndex] = 0u;
barrier();
flags[gl_LocalInvocationIndex] = 1u;
groupMemoryBarrier();
uint otherInvocation = 1u - gl_LocalInvocationIndex;
uint iterations = 0u;
while (flags[otherInvocation] != 1u) {
    iterations++;
}
if (gl_LocalInvocationIndex == 0u) {

blue = float(iterations % 2u);
workGroupSize = uvec3(1u, 1u, 1u);

}
    EmitMeshTasksEXT(workGroupSize.x, workGroupSize.y, workGroupSize.z);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=2) in;

shared uint flags[2];

taskPayloadSharedEXT vec4 blue;

void main ()
{
    uvec3 workGroupSize = uvec3(0u, 0u, 0u);
flags[gl_LocalInvocationIndex] = 0u;
barrier();
flags[gl_LocalInvocationIndex] = 1u;
groupMemoryBarrier();
uint otherInvocation = 1u - gl_LocalInvocationIndex;
uint iterations = 0u;
while (flags[otherInvocation] != 1u) {
    iterations++;
}
if (gl_LocalInvocationIndex == 0u) {

blue = vec4(7.0f, float(iterations % 2u), 7.0f, 7.0f);
workGroupSize = uvec3(1u, 1u, 1u);

}
    EmitMeshTasksEXT(workGroupSize.x, workGroupSize.y, workGroupSize.z);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=2) in;

shared uint flags[2];

taskPayloadSharedEXT float blue[4];

void main ()
{
    uvec3 workGroupSize = uvec3(0u, 0u, 0u);
flags[gl_LocalInvocationIndex] = 0u;
barrier();
flags[gl_LocalInvocationIndex] = 1u;
groupMemoryBarrier();
uint otherInvocation = 1u - gl_LocalInvocationIndex;
uint iterations = 0u;
while (flags[otherInvocation] != 1u) {
    iterations++;
}
if (gl_LocalInvocationIndex == 0u) {

blue[0] = 7.0f;
blue[1] = 7.0f;
blue[2] = float(iterations % 2u);
blue[3]=7.0f;
workGroupSize = uvec3(1u, 1u, 1u);

}
    EmitMeshTasksEXT(workGroupSize.x, workGroupSize.y, workGroupSize.z);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable

layout (local_size_x=2) in;

shared uint flags[2];

taskPayloadSharedEXT uint64_t blue;

void main ()
{
    uvec3 workGroupSize = uvec3(0u, 0u, 0u);
flags[gl_LocalInvocationIndex] = 0u;
barrier();
flags[gl_LocalInvocationIndex] = 1u;
groupMemoryBarrier();
uint otherInvocation = 1u - gl_LocalInvocationIndex;
uint iterations = 0u;
while (flags[otherInvocation] != 1u) {
    iterations++;
}
if (gl_LocalInvocationIndex == 0u) {

blue = uint64_t(iterations % 2u) << 24;
workGroupSize = uvec3(1u, 1u, 1u);

}
    EmitMeshTasksEXT(workGroupSize.x, workGroupSize.y, workGroupSize.z);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=2) in;
layout (points) out;
layout (max_vertices=1, max_primitives=1) out;

layout (location=0) out perprimitiveEXT vec4 primitiveColor[];

shared uint flags[2];

void main ()
{
    uvec2 vertPrim = uvec2(0u, 0u);
flags[gl_LocalInvocationIndex] = 0u;
barrier();
flags[gl_LocalInvocationIndex] = 1u;
groupMemoryBarrier();
uint otherInvocation = 1u - gl_LocalInvocationIndex;
uint iterations = 0u;
while (flags[otherInvocation] != 1u) {
    iterations++;
}
if (gl_LocalInvocationIndex == 0u) {

vertPrim = uvec2(1u, 1u);

}
    SetMeshOutputsEXT(vertPrim.x, vertPrim.y);
    if (gl_LocalInvocationIndex == 0u && vertPrim.x > 0u) {
        gl_MeshVerticesEXT[0].gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
        gl_MeshVerticesEXT[0].gl_PointSize = 1.0;
        primitiveColor[0] = vec4(0.0, 0.0, float(iterations % 2u), 1.0);
        gl_PrimitivePointIndicesEXT[0] = 0;
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable

layout (local_size_x=2) in;
layout (points) out;
layout (max_vertices=1, max_primitives=1) out;

layout (location=0) out perprimitiveEXT vec4 primitiveColor[];

shared uint flags[2];

void main ()
{
    uvec2 vertPrim = uvec2(0u, 0u);
flags[gl_LocalInvocationIndex] = 0u;
barrier();
flags[gl_LocalInvocationIndex] = 1u;
groupMemoryBarrier();
uint otherInvocation = 1u - gl_LocalInvocationIndex;
uint iterations = 0u;
while (flags[otherInvocation] != 1u) {
    iterations++;
}
if (gl_LocalInvocationIndex == 0u) {

vertPrim = uvec2(1u, 1u);

}
    SetMeshOutputsEXT(vertPrim.x, vertPrim.y);
    if (gl_LocalInvocationIndex == 0u && vertPrim.x > 0u) {
        gl_MeshVerticesEXT[0].gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
        gl_MeshVerticesEXT[0].gl_PointSize = 1.0;
        primitiveColor[0] = vec4(0.0, 0.0, float(iterations % 2u), 1.0);
        gl_PrimitivePointIndicesEXT[0] = 0;
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=128) in;

struct TaskData {
    uint verificationCodes[128];
    vec4 color;
};
taskPayloadSharedEXT TaskData td;
shared uint verificationOK[128];

void main ()
{
    td.verificationCodes[gl_LocalInvocationIndex] = (256 - gl_LocalInvocationIndex);
    memoryBarrierShared();
    barrier();
    uint verificationResult = 1u;
    for (uint i = 0u; i < 128; ++i) {
        if (td.verificationCodes[i] != (256 - i)) {
            verificationResult = 0u;
            break;
        }
    }
    verificationOK[gl_LocalInvocationIndex] = verificationResult;
    memoryBarrierShared();
    barrier();
    if (gl_LocalInvocationIndex == 0u) {
        vec4 color = vec4(0.0, 0.0, 1.0, 1.0);
        for (uint i = 0u; i < 128; ++i) {
            if (verificationOK[i] == 0u) {
                color = vec4(0.0, 0.0, 0.0, 1.0);
            }
        }
        td.color = color;
    }
    EmitMeshTasksEXT(1, 1, 1);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1) in;
layout (triangles) out;
layout (max_vertices=3, max_primitives=1) out;

layout (location=0) out perprimitiveEXT vec4 primitiveColor[];
struct TaskData {
    uint verificationCodes[128];
    vec4 color;
};
taskPayloadSharedEXT TaskData td;

void main ()
{
    uint verificationResult = 1u;
    for (uint i = 0u; i < 128; ++i) {
        if (td.verificationCodes[i] != (256 - i)) {
            verificationResult = 0u;
            break;
        }
    }
    const vec4 finalColor = ((verificationResult == 0u) ? vec4(0.0, 0.0, 0.0, 1.0) : td.color);

    SetMeshOutputsEXT(3u, 1u);

    gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[1].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[2].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);

    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
    primitiveColor[0] = finalColor;
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=32) in;
layout(points) out;
layout(max_vertices=128, max_primitives=256) out;

layout (location=0) out perprimitiveEXT vec4 pointColor[];

const uint verticesPerInvocation = 4;
const uint primitivesPerVertex   = 2;

vec4 colors[primitivesPerVertex] = vec4[](
    vec4(0.0, 0.0, 1.0, 1.0),
    vec4(1.0, 0.0, 0.0, 1.0)
);
void main ()
{
    SetMeshOutputsEXT(128, 256);
    const uint firstVertex = gl_LocalInvocationIndex * verticesPerInvocation;
    for (uint i = 0u; i < verticesPerInvocation; ++i)
    {
        const uint vertexNumber = firstVertex + i;
        const float xCoord = ((float(vertexNumber) + 0.5) / 128.0) * 2.0 - 1.0;
        const float yCoord = 0.0;
        gl_MeshVerticesEXT[vertexNumber].gl_Position = vec4(xCoord, yCoord, 0.0f, 1.0f);
        gl_MeshVerticesEXT[vertexNumber].gl_PointSize = 1.0f;
        for (uint j = 0u; j < primitivesPerVertex; ++j)
        {
            const uint primitiveNumber = vertexNumber * primitivesPerVertex + j;
            gl_PrimitivePointIndicesEXT[primitiveNumber] = vertexNumber;
            pointColor[primitiveNumber] = colors[j];
        }
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=32) in;
layout(triangles) out;
layout(max_vertices=256, max_primitives=128) out;

layout (location=0) out perprimitiveEXT vec4 triangleColor[];

const uint pixelsPerInvocation     = 2;
const uint verticesPerInvocation   = 8;
const uint primitivesPerInvocation = 4;
const uint indicesPerInvocation    = primitivesPerInvocation * 3u;
const uint verticesPerPixel        = 4;
const uint primitivesPerPixel      = 2;
const uint indicesPerPixel         = primitivesPerPixel * 3u;

void main ()
{
    SetMeshOutputsEXT(256, 128);

    const uint firstPixel    = gl_LocalInvocationIndex * pixelsPerInvocation;
    const float pixelWidth   = 2.0 / float(64);
    const float quarterWidth = pixelWidth / 4.0;

    for (uint pixelIdx = 0u; pixelIdx < pixelsPerInvocation; ++pixelIdx)
    {
        const uint pixelId      = firstPixel + pixelIdx;
        const float pixelCenter = (float(pixelId) + 0.5) / float(64) * 2.0 - 1.0;
        const float left        = pixelCenter - quarterWidth;
        const float right       = pixelCenter + quarterWidth;

        const uint firstVertex = gl_LocalInvocationIndex * verticesPerInvocation + pixelIdx * verticesPerPixel;
        gl_MeshVerticesEXT[firstVertex + 0].gl_Position = vec4(left,  -1.0, 0.0f, 1.0f);
        gl_MeshVerticesEXT[firstVertex + 1].gl_Position = vec4(left,   1.0, 0.0f, 1.0f);
        gl_MeshVerticesEXT[firstVertex + 2].gl_Position = vec4(right, -1.0, 0.0f, 1.0f);
        gl_MeshVerticesEXT[firstVertex + 3].gl_Position = vec4(right,  1.0, 0.0f, 1.0f);

        const uint firstPrimitive = gl_LocalInvocationIndex * primitivesPerInvocation + pixelIdx * primitivesPerPixel;
        triangleColor[firstPrimitive + 0] = vec4(0.0, 0.0, 1.0, 1.0);
        triangleColor[firstPrimitive + 1] = vec4(0.0, 0.0, 1.0, 1.0);

        const uint firstIndex = gl_LocalInvocationIndex * indicesPerInvocation + pixelIdx * indicesPerPixel;
        gl_PrimitiveTriangleIndicesEXT[firstPrimitive + 0] = uvec3(firstVertex + 0, firstVertex + 1, firstVertex + 2);
        gl_PrimitiveTriangleIndicesEXT[firstPrimitive + 1] = uvec3(firstVertex + 1, firstVertex + 3, firstVertex + 2);
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=32) in;
layout(points) out;
layout(max_vertices=16, max_primitives=16) out;

layout (location=0) out perprimitiveEXT vec4 pointColor[];

void main ()
{
    SetMeshOutputsEXT(16, 16);
    const uint pixelId = gl_LocalInvocationIndex / 2u;
    if (gl_LocalInvocationIndex % 2u == 0u)
    {
        const float xCoord = (float(pixelId) + 0.5) / float(16) * 2.0 - 1.0;
        gl_MeshVerticesEXT[pixelId].gl_Position = vec4(xCoord, 0.0, 0.0f, 1.0f);
        gl_MeshVerticesEXT[pixelId].gl_PointSize = 1.0f;
    }
    else
    {
        gl_PrimitivePointIndicesEXT[pixelId] = pixelId;
        pointColor[pixelId] = vec4(0.0, 0.0, 1.0, 1.0);
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=64) in;
layout(points) out;
layout(max_vertices=32, max_primitives=32) out;

layout (location=0) out perprimitiveEXT vec4 pointColor[];

void main ()
{
    SetMeshOutputsEXT(32, 32);
    const uint pixelId = gl_LocalInvocationIndex / 2u;
    if (gl_LocalInvocationIndex % 2u == 0u)
    {
        const float xCoord = (float(pixelId) + 0.5) / float(32) * 2.0 - 1.0;
        gl_MeshVerticesEXT[pixelId].gl_Position = vec4(xCoord, 0.0, 0.0f, 1.0f);
        gl_MeshVerticesEXT[pixelId].gl_PointSize = 1.0f;
    }
    else
    {
        gl_PrimitivePointIndicesEXT[pixelId] = pixelId;
        pointColor[pixelId] = vec4(0.0, 0.0, 1.0, 1.0);
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=128) in;
layout(points) out;
layout(max_vertices=64, max_primitives=64) out;

layout (location=0) out perprimitiveEXT vec4 pointColor[];

void main ()
{
    SetMeshOutputsEXT(64, 64);
    const uint pixelId = gl_LocalInvocationIndex / 2u;
    if (gl_LocalInvocationIndex % 2u == 0u)
    {
        const float xCoord = (float(pixelId) + 0.5) / float(64) * 2.0 - 1.0;
        gl_MeshVerticesEXT[pixelId].gl_Position = vec4(xCoord, 0.0, 0.0f, 1.0f);
        gl_MeshVerticesEXT[pixelId].gl_PointSize = 1.0f;
    }
    else
    {
        gl_PrimitivePointIndicesEXT[pixelId] = pixelId;
        pointColor[pixelId] = vec4(0.0, 0.0, 1.0, 1.0);
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=256) in;
layout(points) out;
layout(max_vertices=128, max_primitives=128) out;

layout (location=0) out perprimitiveEXT vec4 pointColor[];

void main ()
{
    SetMeshOutputsEXT(128, 128);
    const uint pixelId = gl_LocalInvocationIndex / 2u;
    if (gl_LocalInvocationIndex % 2u == 0u)
    {
        const float xCoord = (float(pixelId) + 0.5) / float(128) * 2.0 - 1.0;
        gl_MeshVerticesEXT[pixelId].gl_Position = vec4(xCoord, 0.0, 0.0f, 1.0f);
        gl_MeshVerticesEXT[pixelId].gl_PointSize = 1.0f;
    }
    else
    {
        gl_PrimitivePointIndicesEXT[pixelId] = pixelId;
        pointColor[pixelId] = vec4(0.0, 0.0, 1.0, 1.0);
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_basic : enable

layout(local_size_x=128, local_size_y=1, local_size_z=1) in;
layout(points) out;
layout(max_primitives=128, max_vertices=128) out;

layout (location=0) out perprimitiveEXT vec4 pointColor[];

void main ()
{
    uint total_points = max(120 / 2u, 1u);
    
    if (gl_LocalInvocationIndex == 0u) {
        total_points = 120;
    } else if (gl_SubgroupID > 0u) {
        total_points = max(120 / 4u, 1u);
    }
    
    SetMeshOutputsEXT(total_points, total_points);
    if (gl_LocalInvocationIndex < 120) {
        gl_MeshVerticesEXT[gl_LocalInvocationIndex].gl_PointSize = 1.0;
        gl_MeshVerticesEXT[gl_LocalInvocationIndex].gl_Position = vec4(((float(gl_LocalInvocationIndex) + 0.5) / 128) * 2.0 - 1.0, 0.0, 0.0, 1.0);
        gl_PrimitivePointIndicesEXT[gl_LocalInvocationIndex] = gl_LocalInvocationIndex;
        pointColor[gl_LocalInvocationIndex] = vec4(0.0, 0.0, 1.0, 1.0);
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_basic : enable

layout(local_size_x=128, local_size_y=1, local_size_z=1) in;

struct TaskData {
    uint values[128];
};
taskPayloadSharedEXT TaskData td;

void main ()
{
    td.values[gl_LocalInvocationIndex] = gl_LocalInvocationIndex * 2u;

    uint total_jobs = max(120 / 2u, 1u);
    if (gl_LocalInvocationIndex == 0u) {
        total_jobs = 120;
    } else if (gl_SubgroupID > 0u) {
        total_jobs = max(120 / 4u, 1u);
    }

    EmitMeshTasksEXT(total_jobs, 1u, 1u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_KHR_shader_subgroup_basic : enable

layout(local_size_x=1, local_size_y=1, local_size_z=1) in;
layout(points) out;
layout(max_primitives=1, max_vertices=1) out;

layout (location=0) out perprimitiveEXT vec4 pointColor[];
struct TaskData {
    uint values[128];
};
taskPayloadSharedEXT TaskData td;

void main ()
{
    uint total_points = max(1 / 2u, 1u);
    
    SetMeshOutputsEXT(total_points, total_points);
    if (gl_LocalInvocationIndex < 1) {
        gl_MeshVerticesEXT[gl_LocalInvocationIndex].gl_PointSize = 1.0;
        gl_MeshVerticesEXT[gl_LocalInvocationIndex].gl_Position = vec4(((float(gl_WorkGroupID.x) + 0.5) / 128) * 2.0 - 1.0, 0.0, 0.0, 1.0);
        gl_PrimitivePointIndicesEXT[gl_LocalInvocationIndex] = gl_LocalInvocationIndex;
        pointColor[gl_LocalInvocationIndex] = vec4(0.0, 0.0, 1.0, 1.0);
    }
}
#version 460
#extension GL_EXT_mesh_shader : require

layout (local_size_x=1) in;
layout (max_vertices=3, max_primitives=1) out;
layout (triangles) out;

layout (location=0) out vec4 color[];

void main()
{
    SetMeshOutputsEXT(3, 1);

    color[0] = vec4(0.0, 0.0, 0.0, 1.0);
    color[1] = vec4(0.0, 0.0, 1.0, 1.0);
    color[2] = vec4(1.0, 0.0, 0.0, 1.0);

    gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
    gl_MeshVerticesEXT[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);

    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
}
#version 460
layout (location=0) in vec4 inColor;
layout (location=0) out vec4 outColor;
void main() {
    outColor = inColor;
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x = 1) in;
layout(triangles) out;
layout(max_vertices = 3, max_primitives = 2) out;

layout(location = 0) perprimitiveEXT out PrimBlock {
    float field_a;
    vec3  field_b;
    float field_c;
} prim_out[];

out perprimitiveEXT gl_MeshPerPrimitiveEXT {
    int gl_PrimitiveID;
} gl_MeshPrimitivesEXT[];

out gl_MeshPerVertexEXT {
    vec4 gl_Position;
} gl_MeshVerticesEXT[];

void main()
{
    SetMeshOutputsEXT(3u, 2u);

    gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[1].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[2].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);

    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0u, 1u, 2u);
    gl_PrimitiveTriangleIndicesEXT[1] = uvec3(0u, 1u, 2u);

    for (uint prim = 0u; prim < 2u; ++prim)
    {
        gl_MeshPrimitivesEXT[prim].gl_PrimitiveID = int(prim);
        prim_out[prim].field_a = 0.25 * float(prim) + 0.25;
        prim_out[prim].field_b = vec3(0.5, 0.25 * float(prim) + 0.25, 0.75);
        prim_out[prim].field_c = 0.5  * float(prim) + 0.25;
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(location = 0) perprimitiveEXT in PrimBlock {
    float field_a;
    vec3  field_b;
    float field_c;
} prim_in;

layout(location = 0) out vec4 outColor;

void main()
{
    uint  prim = uint(gl_PrimitiveID);
    float expA = 0.25 * float(prim) + 0.25;
    vec3  expB = vec3(0.5, 0.25 * float(prim) + 0.25, 0.75);
    float expC = 0.5  * float(prim) + 0.25;
    const float eps = 0.005;

    bool ok = abs(prim_in.field_a - expA) < eps
           && all(lessThan(abs(prim_in.field_b - expB), vec3(eps)))
           && abs(prim_in.field_c - expC) < eps;

    vec4 primColor = (prim == 0u) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 1.0, 0.0, 1.0);
    outColor = ok ? primColor : vec4(1.0, 0.0, 1.0, 1.0);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

layout (location=0) out perprimitiveEXT vec4 triangleColor[];

layout (push_constant, std430) uniform PushConstantBlock {
    layout (offset=0) float values[4];
} pc;

void main ()
{
    SetMeshOutputsEXT(3u, 1u);

    gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[1].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[2].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);

    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
    triangleColor[0] = vec4(0.0, 0.0, pc.values[0] + pc.values[2], pc.values[1] + pc.values[3]);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;

struct TaskData {
    float values[2];
};
taskPayloadSharedEXT TaskData td;

layout (push_constant, std430) uniform PushConstantBlock {
    layout (offset=8) float values[2];
} pc;

void main ()
{
    td.values[0] = pc.values[0];
    td.values[1] = pc.values[1];

    EmitMeshTasksEXT(1, 1, 1);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

layout (location=0) out perprimitiveEXT vec4 triangleColor[];

layout (push_constant, std430) uniform PushConstantBlock {
    layout (offset=0) float values[2];
} pc;

struct TaskData {
    float values[2];
};
taskPayloadSharedEXT TaskData td;

void main ()
{
    SetMeshOutputsEXT(3u, 1u);

    gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[1].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[2].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);

    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
    triangleColor[0] = vec4(0.0, 0.0, td.values[0] + pc.values[0], td.values[1] + pc.values[1]);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1) in;
layout (max_primitives=2, max_vertices=4) out;
layout (triangles) out;

out gl_MeshPerVertexEXT {
    vec4  gl_Position;
    float gl_PointSize;
    float gl_ClipDistance[1];
} gl_MeshVerticesEXT[];

layout (location=0) out vec4 customAttribute1[];
layout (location=1) out flat float customAttribute2[];
layout (location=2) out int customAttribute3[];

layout (location=3) out perprimitiveEXT uvec4 customAttribute4[];
layout (location=4) out perprimitiveEXT float customAttribute5[];

out perprimitiveEXT gl_MeshPerPrimitiveEXT {
  int gl_PrimitiveID;
  int gl_ViewportIndex;
} gl_MeshPrimitivesEXT[];

layout (set=0, binding=0, std430) buffer PerVertexData {
    vec4 positions[4];
    float pointSizes[4];
    float clipDistances[4];
    vec4 custom1[4];
    float custom2[4];
    int custom3[4];
} pvd;
layout (set=0, binding=1) uniform PerPrimitiveData {
    int primitiveIds[2];
    int viewportIndices[2];
    uvec4 custom4[2];
    float custom5[2];
} ppd;

void main ()
{
    SetMeshOutputsEXT(4u, 2u);

    gl_MeshVerticesEXT[0].gl_Position = pvd.positions[0];
    gl_MeshVerticesEXT[1].gl_Position = pvd.positions[1];
    gl_MeshVerticesEXT[2].gl_Position = pvd.positions[2];
    gl_MeshVerticesEXT[3].gl_Position = pvd.positions[3];

    gl_MeshVerticesEXT[0].gl_PointSize = pvd.pointSizes[0];
    gl_MeshVerticesEXT[1].gl_PointSize = pvd.pointSizes[1];
    gl_MeshVerticesEXT[2].gl_PointSize = pvd.pointSizes[2];
    gl_MeshVerticesEXT[3].gl_PointSize = pvd.pointSizes[3];

    // Remove geometry on the right side.
    gl_MeshVerticesEXT[0].gl_ClipDistance[0] = pvd.clipDistances[0];
    gl_MeshVerticesEXT[1].gl_ClipDistance[0] = pvd.clipDistances[1];
    gl_MeshVerticesEXT[2].gl_ClipDistance[0] = pvd.clipDistances[2];
    gl_MeshVerticesEXT[3].gl_ClipDistance[0] = pvd.clipDistances[3];
    
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
    gl_PrimitiveTriangleIndicesEXT[1] = uvec3(2, 3, 1);

    gl_MeshPrimitivesEXT[0].gl_PrimitiveID = ppd.primitiveIds[0];
    gl_MeshPrimitivesEXT[1].gl_PrimitiveID = ppd.primitiveIds[1];

    gl_MeshPrimitivesEXT[0].gl_ViewportIndex = ppd.viewportIndices[0];
    gl_MeshPrimitivesEXT[1].gl_ViewportIndex = ppd.viewportIndices[1];

    // Custom per-vertex attributes
    customAttribute1[0] = pvd.custom1[0];
    customAttribute1[1] = pvd.custom1[1];
    customAttribute1[2] = pvd.custom1[2];
    customAttribute1[3] = pvd.custom1[3];

    customAttribute2[0] = pvd.custom2[0];
    customAttribute2[1] = pvd.custom2[1];
    customAttribute2[2] = pvd.custom2[2];
    customAttribute2[3] = pvd.custom2[3];

    customAttribute3[0] = pvd.custom3[0];
    customAttribute3[1] = pvd.custom3[1];
    customAttribute3[2] = pvd.custom3[2];
    customAttribute3[3] = pvd.custom3[3];

    // Custom per-primitive attributes.
    customAttribute4[0] = ppd.custom4[0];
    customAttribute4[1] = ppd.custom4[1];

    customAttribute5[0] = ppd.custom5[0];
    customAttribute5[1] = ppd.custom5[1];
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (location=0) in vec4 customAttribute1;
layout (location=1) in flat float customAttribute2;
layout (location=2) in flat int customAttribute3;

layout (location=3) in perprimitiveEXT flat uvec4 customAttribute4;
layout (location=4) in perprimitiveEXT float customAttribute5;

layout (location=0) out vec4 outColor;

void main ()
{
    bool goodPrimitiveID = (gl_PrimitiveID == 1000 || gl_PrimitiveID == 1001);
    bool goodViewportIndex = (gl_ViewportIndex == 1);
    bool goodCustom1 = (customAttribute1.x >= 0.25 && customAttribute1.x <= 0.5 &&
                        customAttribute1.y >= 0.5  && customAttribute1.y <= 1.0 &&
                        customAttribute1.z >= 10.0 && customAttribute1.z <= 20.0 &&
                        customAttribute1.w == 3.0);
    bool goodCustom2 = (customAttribute2 == 1.0 || customAttribute2 == 2.0);
    bool goodCustom3 = (customAttribute3 == 3 || customAttribute3 == 4);
    bool goodCustom4 = ((gl_PrimitiveID == 1000 && customAttribute4 == uvec4(100, 101, 102, 103)) ||
                        (gl_PrimitiveID == 1001 && customAttribute4 == uvec4(200, 201, 202, 203)));
    bool goodCustom5 = ((gl_PrimitiveID == 1000 && customAttribute5 == 6.0) ||
                        (gl_PrimitiveID == 1001 && customAttribute5 == 7.0));
    
    if (goodPrimitiveID && goodViewportIndex && goodCustom1 && goodCustom2 && goodCustom3 && goodCustom4 && goodCustom5) {
        outColor = vec4(0.0, 0.0, 1.0, 1.0);
    } else {
        outColor = vec4(0.0, 0.0, 0.0, 1.0);
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable

struct TaskData {
    vec4 positions[4];
    float pointSizes[4];
    float clipDistances[4];
    vec4 custom1[4];
    float custom2[4];
    int custom3[4];
    int primitiveIds[2];
    int viewportIndices[2];
    uvec4 custom4[2];
    float custom5[2];
};
taskPayloadSharedEXT TaskData td;

layout (set=0, binding=0, std430) buffer PerVertexData {
    vec4 positions[4];
    float pointSizes[4];
    float clipDistances[4];
    vec4 custom1[4];
    float custom2[4];
    int custom3[4];
} pvd;
layout (set=0, binding=1) uniform PerPrimitiveData {
    int primitiveIds[2];
    int viewportIndices[2];
    uvec4 custom4[2];
    float custom5[2];
} ppd;

void main ()
{
    td.positions[0] = pvd.positions[0];
    td.positions[1] = pvd.positions[1];
    td.positions[2] = pvd.positions[2];
    td.positions[3] = pvd.positions[3];

    td.pointSizes[0] = pvd.pointSizes[0];
    td.pointSizes[1] = pvd.pointSizes[1];
    td.pointSizes[2] = pvd.pointSizes[2];
    td.pointSizes[3] = pvd.pointSizes[3];

    td.clipDistances[0] = pvd.clipDistances[0];
    td.clipDistances[1] = pvd.clipDistances[1];
    td.clipDistances[2] = pvd.clipDistances[2];
    td.clipDistances[3] = pvd.clipDistances[3];

    td.custom1[0] = pvd.custom1[0];
    td.custom1[1] = pvd.custom1[1];
    td.custom1[2] = pvd.custom1[2];
    td.custom1[3] = pvd.custom1[3];

    td.custom2[0] = pvd.custom2[0];
    td.custom2[1] = pvd.custom2[1];
    td.custom2[2] = pvd.custom2[2];
    td.custom2[3] = pvd.custom2[3];

    td.custom3[0] = pvd.custom3[0];
    td.custom3[1] = pvd.custom3[1];
    td.custom3[2] = pvd.custom3[2];
    td.custom3[3] = pvd.custom3[3];

    td.primitiveIds[0] = ppd.primitiveIds[0];
    td.primitiveIds[1] = ppd.primitiveIds[1];

    td.viewportIndices[0] = ppd.viewportIndices[0];
    td.viewportIndices[1] = ppd.viewportIndices[1];

    td.custom4[0] = ppd.custom4[0];
    td.custom4[1] = ppd.custom4[1];

    td.custom5[0] = ppd.custom5[0];
    td.custom5[1] = ppd.custom5[1];

    EmitMeshTasksEXT(1, 1, 1);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1) in;
layout (max_primitives=2, max_vertices=4) out;
layout (triangles) out;

out gl_MeshPerVertexEXT {
    vec4  gl_Position;
    float gl_PointSize;
    float gl_ClipDistance[1];
} gl_MeshVerticesEXT[];

layout (location=0) out vec4 customAttribute1[];
layout (location=1) out flat float customAttribute2[];
layout (location=2) out int customAttribute3[];

layout (location=3) out perprimitiveEXT uvec4 customAttribute4[];
layout (location=4) out perprimitiveEXT float customAttribute5[];

out perprimitiveEXT gl_MeshPerPrimitiveEXT {
  int gl_PrimitiveID;
  int gl_ViewportIndex;
} gl_MeshPrimitivesEXT[];

struct TaskData {
    vec4 positions[4];
    float pointSizes[4];
    float clipDistances[4];
    vec4 custom1[4];
    float custom2[4];
    int custom3[4];
    int primitiveIds[2];
    int viewportIndices[2];
    uvec4 custom4[2];
    float custom5[2];
};
taskPayloadSharedEXT TaskData td;

void main ()
{
    SetMeshOutputsEXT(4u, 2u);

    gl_MeshVerticesEXT[0].gl_Position = td.positions[0];
    gl_MeshVerticesEXT[1].gl_Position = td.positions[1];
    gl_MeshVerticesEXT[2].gl_Position = td.positions[2];
    gl_MeshVerticesEXT[3].gl_Position = td.positions[3];

    gl_MeshVerticesEXT[0].gl_PointSize = td.pointSizes[0];
    gl_MeshVerticesEXT[1].gl_PointSize = td.pointSizes[1];
    gl_MeshVerticesEXT[2].gl_PointSize = td.pointSizes[2];
    gl_MeshVerticesEXT[3].gl_PointSize = td.pointSizes[3];

    // Remove geometry on the right side.
    gl_MeshVerticesEXT[0].gl_ClipDistance[0] = td.clipDistances[0];
    gl_MeshVerticesEXT[1].gl_ClipDistance[0] = td.clipDistances[1];
    gl_MeshVerticesEXT[2].gl_ClipDistance[0] = td.clipDistances[2];
    gl_MeshVerticesEXT[3].gl_ClipDistance[0] = td.clipDistances[3];
    
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
    gl_PrimitiveTriangleIndicesEXT[1] = uvec3(2, 3, 1);

    gl_MeshPrimitivesEXT[0].gl_PrimitiveID = td.primitiveIds[0];
    gl_MeshPrimitivesEXT[1].gl_PrimitiveID = td.primitiveIds[1];

    gl_MeshPrimitivesEXT[0].gl_ViewportIndex = td.viewportIndices[0];
    gl_MeshPrimitivesEXT[1].gl_ViewportIndex = td.viewportIndices[1];

    // Custom per-vertex attributes
    customAttribute1[0] = td.custom1[0];
    customAttribute1[1] = td.custom1[1];
    customAttribute1[2] = td.custom1[2];
    customAttribute1[3] = td.custom1[3];

    customAttribute2[0] = td.custom2[0];
    customAttribute2[1] = td.custom2[1];
    customAttribute2[2] = td.custom2[2];
    customAttribute2[3] = td.custom2[3];

    customAttribute3[0] = td.custom3[0];
    customAttribute3[1] = td.custom3[1];
    customAttribute3[2] = td.custom3[2];
    customAttribute3[3] = td.custom3[3];

    // Custom per-primitive attributes.
    customAttribute4[0] = td.custom4[0];
    customAttribute4[1] = td.custom4[1];

    customAttribute5[0] = td.custom5[0];
    customAttribute5[1] = td.custom5[1];
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1) in;
layout (max_primitives=2, max_vertices=4) out;
layout (triangles) out;

out gl_MeshPerVertexEXT {
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

layout (location=0) out vec4 customAttribute1[];
layout (location=1) out flat float customAttribute2[];
layout (location=2) out int customAttribute3[];

layout (location=3) out perprimitiveEXT uvec4 customAttribute4[];
layout (location=4) out perprimitiveEXT float customAttribute5[];

out perprimitiveEXT gl_MeshPerPrimitiveEXT {
  int gl_PrimitiveID;
  int gl_ViewportIndex;
} gl_MeshPrimitivesEXT[];

layout (set=0, binding=0, std430) buffer PerVertexData {
    vec4 positions[4];
    float pointSizes[4];
    float unused[4];
    vec4 custom1[4];
    float custom2[4];
    int custom3[4];
} pvd;
layout (set=0, binding=1) uniform PerPrimitiveData {
    int primitiveIds[2];
    int viewportIndices[2];
    uvec4 custom4[2];
    float custom5[2];
} ppd;

void main ()
{
    SetMeshOutputsEXT(4u, 2u);

    gl_MeshVerticesEXT[0].gl_Position = pvd.positions[0];
    gl_MeshVerticesEXT[1].gl_Position = pvd.positions[1];
    gl_MeshVerticesEXT[2].gl_Position = pvd.positions[2];
    gl_MeshVerticesEXT[3].gl_Position = pvd.positions[3];

    gl_MeshVerticesEXT[0].gl_PointSize = pvd.pointSizes[0];
    gl_MeshVerticesEXT[1].gl_PointSize = pvd.pointSizes[1];
    gl_MeshVerticesEXT[2].gl_PointSize = pvd.pointSizes[2];
    gl_MeshVerticesEXT[3].gl_PointSize = pvd.pointSizes[3];

    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
    gl_PrimitiveTriangleIndicesEXT[1] = uvec3(2, 3, 1);

    gl_MeshPrimitivesEXT[0].gl_PrimitiveID = ppd.primitiveIds[0];
    gl_MeshPrimitivesEXT[1].gl_PrimitiveID = ppd.primitiveIds[1];

    gl_MeshPrimitivesEXT[0].gl_ViewportIndex = ppd.viewportIndices[0];
    gl_MeshPrimitivesEXT[1].gl_ViewportIndex = ppd.viewportIndices[1];

    // Custom per-vertex attributes
    customAttribute1[0] = pvd.custom1[0];
    customAttribute1[1] = pvd.custom1[1];
    customAttribute1[2] = pvd.custom1[2];
    customAttribute1[3] = pvd.custom1[3];

    customAttribute2[0] = pvd.custom2[0];
    customAttribute2[1] = pvd.custom2[1];
    customAttribute2[2] = pvd.custom2[2];
    customAttribute2[3] = pvd.custom2[3];

    customAttribute3[0] = pvd.custom3[0];
    customAttribute3[1] = pvd.custom3[1];
    customAttribute3[2] = pvd.custom3[2];
    customAttribute3[3] = pvd.custom3[3];

    // Custom per-primitive attributes.
    customAttribute4[0] = ppd.custom4[0];
    customAttribute4[1] = ppd.custom4[1];

    customAttribute5[0] = ppd.custom5[0];
    customAttribute5[1] = ppd.custom5[1];
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (location=0) in vec4 customAttribute1;
layout (location=1) in flat float customAttribute2;
layout (location=2) in flat int customAttribute3;

layout (location=3) in perprimitiveEXT flat uvec4 customAttribute4;
layout (location=4) in perprimitiveEXT float customAttribute5;

layout (location=0) out vec4 outColor;

void main ()
{
    bool goodPrimitiveID = (gl_PrimitiveID == 1000 || gl_PrimitiveID == 1001);
    bool goodViewportIndex = (gl_ViewportIndex == 1);
    bool goodCustom1 = (customAttribute1.x >= 0.25 && customAttribute1.x <= 0.5 &&
                        customAttribute1.y >= 0.5  && customAttribute1.y <= 1.0 &&
                        customAttribute1.z >= 10.0 && customAttribute1.z <= 20.0 &&
                        customAttribute1.w == 3.0);
    bool goodCustom2 = (gl_PrimitiveID == 1000 &&  customAttribute2 == 1.0)  || (gl_PrimitiveID == 1001 && customAttribute2 == 2.0);
    bool goodCustom3 = (customAttribute3 == 3 || customAttribute3 == 4);
    bool goodCustom4 = ((gl_PrimitiveID == 1000 && customAttribute4 == uvec4(100, 101, 102, 103)) ||
                        (gl_PrimitiveID == 1001 && customAttribute4 == uvec4(200, 201, 202, 203)));
    bool goodCustom5 = ((gl_PrimitiveID == 1000 && customAttribute5 == 6.0) ||
                        (gl_PrimitiveID == 1001 && customAttribute5 == 7.0));
    
    if (goodPrimitiveID && goodViewportIndex && goodCustom1 && goodCustom2 && goodCustom3 && goodCustom4 && goodCustom5) {
        outColor = vec4(0.0, 0.0, 1.0, 1.0);
    } else {
        outColor = vec4(0.0, 0.0, 0.0, 1.0);
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (location=0) in vec4 customAttribute1;
layout (location=1) in flat float customAttribute2;
layout (location=2) in flat int customAttribute3;

layout (location=3) in perprimitiveEXT flat uvec4 customAttribute4;
layout (location=4) in perprimitiveEXT float customAttribute5;

layout (location=0) out vec4 outColor;

void main ()
{
    bool goodPrimitiveID = (gl_PrimitiveID == 1000 || gl_PrimitiveID == 1001);
    bool goodViewportIndex = (gl_ViewportIndex == 1);
    bool goodCustom1 = (customAttribute1.x >= 0.25 && customAttribute1.x <= 0.5 &&
                        customAttribute1.y >= 0.5  && customAttribute1.y <= 1.0 &&
                        customAttribute1.z >= 10.0 && customAttribute1.z <= 20.0 &&
                        customAttribute1.w == 3.0);
    bool goodCustom2 = (gl_PrimitiveID == 1000 &&  customAttribute2 == 2.0)  || (gl_PrimitiveID == 1001 && customAttribute2 == 1.0);
    bool goodCustom3 = (customAttribute3 == 3 || customAttribute3 == 4);
    bool goodCustom4 = ((gl_PrimitiveID == 1000 && customAttribute4 == uvec4(100, 101, 102, 103)) ||
                        (gl_PrimitiveID == 1001 && customAttribute4 == uvec4(200, 201, 202, 203)));
    bool goodCustom5 = ((gl_PrimitiveID == 1000 && customAttribute5 == 6.0) ||
                        (gl_PrimitiveID == 1001 && customAttribute5 == 7.0));
    
    if (goodPrimitiveID && goodViewportIndex && goodCustom1 && goodCustom2 && goodCustom3 && goodCustom4 && goodCustom5) {
        outColor = vec4(0.0, 0.0, 1.0, 1.0);
    } else {
        outColor = vec4(0.0, 0.0, 0.0, 1.0);
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable

struct TaskData {
    vec4 positions[4];
    float pointSizes[4];
    float unused[4];
    vec4 custom1[4];
    float custom2[4];
    int custom3[4];
    int primitiveIds[2];
    int viewportIndices[2];
    uvec4 custom4[2];
    float custom5[2];
};
taskPayloadSharedEXT TaskData td;

layout (set=0, binding=0, std430) buffer PerVertexData {
    vec4 positions[4];
    float pointSizes[4];
    float unused[4];
    vec4 custom1[4];
    float custom2[4];
    int custom3[4];
} pvd;
layout (set=0, binding=1) uniform PerPrimitiveData {
    int primitiveIds[2];
    int viewportIndices[2];
    uvec4 custom4[2];
    float custom5[2];
} ppd;

void main ()
{
    td.positions[0] = pvd.positions[0];
    td.positions[1] = pvd.positions[1];
    td.positions[2] = pvd.positions[2];
    td.positions[3] = pvd.positions[3];

    td.pointSizes[0] = pvd.pointSizes[0];
    td.pointSizes[1] = pvd.pointSizes[1];
    td.pointSizes[2] = pvd.pointSizes[2];
    td.pointSizes[3] = pvd.pointSizes[3];

    td.custom1[0] = pvd.custom1[0];
    td.custom1[1] = pvd.custom1[1];
    td.custom1[2] = pvd.custom1[2];
    td.custom1[3] = pvd.custom1[3];

    td.custom2[0] = pvd.custom2[0];
    td.custom2[1] = pvd.custom2[1];
    td.custom2[2] = pvd.custom2[2];
    td.custom2[3] = pvd.custom2[3];

    td.custom3[0] = pvd.custom3[0];
    td.custom3[1] = pvd.custom3[1];
    td.custom3[2] = pvd.custom3[2];
    td.custom3[3] = pvd.custom3[3];

    td.primitiveIds[0] = ppd.primitiveIds[0];
    td.primitiveIds[1] = ppd.primitiveIds[1];

    td.viewportIndices[0] = ppd.viewportIndices[0];
    td.viewportIndices[1] = ppd.viewportIndices[1];

    td.custom4[0] = ppd.custom4[0];
    td.custom4[1] = ppd.custom4[1];

    td.custom5[0] = ppd.custom5[0];
    td.custom5[1] = ppd.custom5[1];

    EmitMeshTasksEXT(1, 1, 1);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1) in;
layout (max_primitives=2, max_vertices=4) out;
layout (triangles) out;

out gl_MeshPerVertexEXT {
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

layout (location=0) out vec4 customAttribute1[];
layout (location=1) out flat float customAttribute2[];
layout (location=2) out int customAttribute3[];

layout (location=3) out perprimitiveEXT uvec4 customAttribute4[];
layout (location=4) out perprimitiveEXT float customAttribute5[];

out perprimitiveEXT gl_MeshPerPrimitiveEXT {
  int gl_PrimitiveID;
  int gl_ViewportIndex;
} gl_MeshPrimitivesEXT[];

struct TaskData {
    vec4 positions[4];
    float pointSizes[4];
    float unused[4];
    vec4 custom1[4];
    float custom2[4];
    int custom3[4];
    int primitiveIds[2];
    int viewportIndices[2];
    uvec4 custom4[2];
    float custom5[2];
};
taskPayloadSharedEXT TaskData td;

void main ()
{
    SetMeshOutputsEXT(4u, 2u);

    gl_MeshVerticesEXT[0].gl_Position = td.positions[0];
    gl_MeshVerticesEXT[1].gl_Position = td.positions[1];
    gl_MeshVerticesEXT[2].gl_Position = td.positions[2];
    gl_MeshVerticesEXT[3].gl_Position = td.positions[3];

    gl_MeshVerticesEXT[0].gl_PointSize = td.pointSizes[0];
    gl_MeshVerticesEXT[1].gl_PointSize = td.pointSizes[1];
    gl_MeshVerticesEXT[2].gl_PointSize = td.pointSizes[2];
    gl_MeshVerticesEXT[3].gl_PointSize = td.pointSizes[3];

    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
    gl_PrimitiveTriangleIndicesEXT[1] = uvec3(2, 3, 1);

    gl_MeshPrimitivesEXT[0].gl_PrimitiveID = td.primitiveIds[0];
    gl_MeshPrimitivesEXT[1].gl_PrimitiveID = td.primitiveIds[1];

    gl_MeshPrimitivesEXT[0].gl_ViewportIndex = td.viewportIndices[0];
    gl_MeshPrimitivesEXT[1].gl_ViewportIndex = td.viewportIndices[1];

    // Custom per-vertex attributes
    customAttribute1[0] = td.custom1[0];
    customAttribute1[1] = td.custom1[1];
    customAttribute1[2] = td.custom1[2];
    customAttribute1[3] = td.custom1[3];

    customAttribute2[0] = td.custom2[0];
    customAttribute2[1] = td.custom2[1];
    customAttribute2[2] = td.custom2[2];
    customAttribute2[3] = td.custom2[3];

    customAttribute3[0] = td.custom3[0];
    customAttribute3[1] = td.custom3[1];
    customAttribute3[2] = td.custom3[2];
    customAttribute3[3] = td.custom3[3];

    // Custom per-primitive attributes.
    customAttribute4[0] = td.custom4[0];
    customAttribute4[1] = td.custom4[1];

    customAttribute5[0] = td.custom5[0];
    customAttribute5[1] = td.custom5[1];
}
#version 460
#extension GL_EXT_mesh_shader : require

layout (local_size_x=1) in;
layout (max_vertices=3, max_primitives=1) out;
layout (triangles) out;

layout (location=0) out vec4 color[];

taskPayloadSharedEXT float payload;layout(push_constant) uniform PushConst {
    float value;
};

void main()
{
    float three = 3.0f;
    if (value > 2.0f) {
        three = payload;
    }

    SetMeshOutputsEXT(3, 1);

    color[0] = vec4(0.0, 0.0, 0.0, 1.0);
    color[1] = vec4(0.0, 0.0, 1.0, 1.0);
    color[2] = vec4(1.0, 0.0, 0.0, 1.0);

    gl_MeshVerticesEXT[0].gl_Position = vec4( -1.0,  -1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[1].gl_Position = vec4( -1.0, three, 0.0, 1.0);
    gl_MeshVerticesEXT[2].gl_Position = vec4(three,  -1.0, 0.0, 1.0);

    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1) in;

void main ()
{
    if (gl_WorkGroupID.x != 0 || gl_WorkGroupID.y != 0 || gl_WorkGroupID.z != 0) {
        EmitMeshTasksEXT(2u, 1u, 1u);
    } else {
        EmitMeshTasksEXT(1u, 1u, 1u);
    }
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

void main ()
{
    SetMeshOutputsEXT(3u, 1u);
    if (gl_WorkGroupID.x != 0) {
        // Cover the right side of the framebuffer
        gl_MeshVerticesEXT[0].gl_Position = vec4( 0.0f, -1.0f, 0.0f, 1.0f);
        gl_MeshVerticesEXT[1].gl_Position = vec4( 0.0f,  3.0f, 0.0f, 1.0f);
        gl_MeshVerticesEXT[2].gl_Position = vec4( 3.0f, -1.0f, 0.0f, 1.0f);
    } else {
        // Cover the left side of the framebuffer
        gl_MeshVerticesEXT[0].gl_Position = vec4( 0.0f, -1.0f, 0.0f, 1.0f);
        gl_MeshVerticesEXT[1].gl_Position = vec4(-3.0f, -1.0f, 0.0f, 1.0f);
        gl_MeshVerticesEXT[2].gl_Position = vec4( 0.0f,  3.0f, 0.0f, 1.0f);
    }
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
}
#version 460
layout (location=0) out vec4 outColor;
void main(void) { outColor = vec4(0.0, 0.0, 1.0, 1.0); }
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1) in;

void main ()
{
    if (gl_WorkGroupID.x == 0 && gl_WorkGroupID.y == 0 && gl_WorkGroupID.z == 0) {
        EmitMeshTasksEXT(1u, 1u, 1u);
    } else {
        EmitMeshTasksEXT(2u, 1u, 1u);
    }
}
#version 450

void main()
{
    const float x = (-1.0+2.0*((gl_VertexIndex & 2)>>1));
    const float y = ( 1.0-2.0* (gl_VertexIndex % 2));
    gl_Position = vec4(x, y, 0.0, 1.0);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=4) in;
layout(triangles) out;
layout(max_vertices=4, max_primitives=2) out;

void main ()
{
    SetMeshOutputsEXT(4u, 2u);
    const float x = (-1.0+2.0*((gl_LocalInvocationIndex & 2)>>1));
    const float y = ( 1.0-2.0*((gl_LocalInvocationIndex & 1)   ));
    gl_MeshVerticesEXT[gl_LocalInvocationIndex].gl_Position = vec4(x, y, 0.0, 1.0);
    if (gl_LocalInvocationIndex == 0u) {
        gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0u, 1u, 2u);
        gl_PrimitiveTriangleIndicesEXT[1] = uvec3(2u, 1u, 3u);
    }
}
#version 450

layout (location=0) out vec4 outColor;
layout (push_constant, std430) uniform PushConstantBlock {
    vec4 color;
} pc;

void main ()
{
    outColor = pc.color;
}
#version 450
#extension GL_EXT_mesh_shader : enable
layout (local_size_x=1, local_size_y=1, local_size_z=1) in;

layout (set=0, binding=0, std430) readonly buffer SSBOBlock { float redComponent; } ssbo;
struct TaskData { float redComponent; }; taskPayloadSharedEXT TaskData td;

void main (void)
{
    td.redComponent = ssbo.redComponent;
    EmitMeshTasksEXT(1u, 1u, 1u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
layout (local_size_x=1, local_size_y=1, local_size_z=1) in;
layout (triangles) out;
layout (max_vertices=4, max_primitives=2) out;

layout (set=0, binding=1) uniform sampler2D greenComponent;
layout (push_constant, std430) uniform PCBlock { float offsetX; float offsetY; float blueComponent; } pc;
struct TaskData { float redComponent; }; taskPayloadSharedEXT TaskData td;
layout (location=0) out perprimitiveEXT vec4 primitiveColor[];

void main (void)
{
    SetMeshOutputsEXT(4u, 2u);

    gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0 + pc.offsetX, -1.0 + pc.offsetY, 0.0, 1.0);
    gl_MeshVerticesEXT[1].gl_Position = vec4( 0.0 + pc.offsetX, -1.0 + pc.offsetY, 0.0, 1.0);
    gl_MeshVerticesEXT[2].gl_Position = vec4(-1.0 + pc.offsetX,  0.0 + pc.offsetY, 0.0, 1.0);
    gl_MeshVerticesEXT[3].gl_Position = vec4( 0.0 + pc.offsetX,  0.0 + pc.offsetY, 0.0, 1.0);

    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(2u, 1u, 0u);
    gl_PrimitiveTriangleIndicesEXT[1] = uvec3(2u, 3u, 1u);

    const vec4 primColor = vec4(td.redComponent, texture(greenComponent, vec2(0.5, 0.5)).x, pc.blueComponent, 1.0);
    primitiveColor[0] = primColor;
    primitiveColor[1] = primColor;
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1) in;
layout (triangles) out;
layout (max_vertices=3, max_primitives=1) out;

layout (set=0, binding=0, std430) readonly buffer VBO { vec4 vertices[]; };
layout (set=0, binding=1, std430) readonly buffer IBO { uint indices[]; };

void main ()
{
    SetMeshOutputsEXT(3u, 1u);

    gl_MeshVerticesEXT[0].gl_Position = vertices[0];
    gl_MeshVerticesEXT[1].gl_Position = vertices[1];
    gl_MeshVerticesEXT[2].gl_Position = vertices[2];

    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(indices[0], indices[1], indices[2]);
}
#version 460
layout (location=0) out vec4 outColor;
void main(void) {
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
}
