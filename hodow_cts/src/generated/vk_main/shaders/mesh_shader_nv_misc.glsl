#version 450
#extension GL_NV_mesh_shader : enable

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

out taskNV TaskData {
    uint yes;
    ExternalData externalData;
} td;

void main ()
{
    gl_TaskCountNV = 2u;
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
}
#version 450
#extension GL_NV_mesh_shader : enable

layout(local_size_x=2) in;
layout(triangles) out;
layout(max_vertices=4, max_primitives=2) out;

layout (location=0) out perprimitiveNV vec4 triangleColor[];

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

in taskNV TaskData {
    uint yes;
    ExternalData externalData;
} td;

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

    if (dataOK) {
        gl_PrimitiveCountNV = 2u;
    }
    else {
        gl_PrimitiveCountNV = 0u;
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

    float localInvocationOffsetY = float(gl_LocalInvocationID.x);
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

    uint baseVertexId = 2*gl_LocalInvocationID.x;
    gl_MeshVerticesNV[baseVertexId + 0].gl_Position = left;
    gl_MeshVerticesNV[baseVertexId + 1].gl_Position = right;

    uint baseIndexId = 3*gl_LocalInvocationID.x;
    // 0,1,2 or 1,2,3 (note: triangles alternate front face this way)
    gl_PrimitiveIndicesNV[baseIndexId + 0] = 0 + gl_LocalInvocationID.x;
    gl_PrimitiveIndicesNV[baseIndexId + 1] = 1 + gl_LocalInvocationID.x;
    gl_PrimitiveIndicesNV[baseIndexId + 2] = 2 + gl_LocalInvocationID.x;
}
#version 450
#extension GL_NV_mesh_shader : enable

layout (location=0) in perprimitiveNV vec4 primitiveColor;
layout (location=0) out vec4 outColor;

void main ()
{
    outColor = primitiveColor;
}
#version 450
#extension GL_NV_mesh_shader : enable

layout(local_size_x=1) in;
layout(points) out;
layout(max_vertices=256, max_primitives=256) out;

layout (location=0) out perprimitiveNV vec4 pointColor[];

void main ()
{
    gl_PrimitiveCountNV = 1u;
    pointColor[0] = vec4(0.0f, 1.0f, 1.0f, 1.0f);
    gl_MeshVerticesNV[0].gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
    gl_MeshVerticesNV[0].gl_PointSize = 1.0f;
    gl_PrimitiveIndicesNV[0] = 0;
}
#version 450
#extension GL_NV_mesh_shader : enable

layout(local_size_x=1) in;
layout(lines) out;
layout(max_vertices=256, max_primitives=256) out;

layout (location=0) out perprimitiveNV vec4 lineColor[];

void main ()
{
    gl_PrimitiveCountNV = 1u;
    lineColor[0] = vec4(0.0f, 1.0f, 1.0f, 1.0f);
    gl_MeshVerticesNV[0].gl_Position = vec4(-1.0f, 0.0f, 0.0f, 1.0f);
    gl_MeshVerticesNV[1].gl_Position = vec4( 1.0f, 0.0f, 0.0f, 1.0f);
    gl_PrimitiveIndicesNV[0] = 0;
    gl_PrimitiveIndicesNV[1] = 1;
}
#version 450
#extension GL_NV_mesh_shader : enable

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=256, max_primitives=256) out;

layout (location=0) out perprimitiveNV vec4 triangleColor[];

void main ()
{
    gl_PrimitiveCountNV = 1u;
    triangleColor[0] = vec4(0.0f, 1.0f, 1.0f, 1.0f);
    gl_MeshVerticesNV[0].gl_Position = vec4(0.285714, -0.4, 0.0f, 1.0f);
    gl_MeshVerticesNV[1].gl_Position = vec4(0.285714, 0.4, 0.0f, 1.0f);
    gl_MeshVerticesNV[2].gl_Position = vec4(-0.285714, 0.0f, 0.0f, 1.0f);
    gl_PrimitiveIndicesNV[0] = 0;
    gl_PrimitiveIndicesNV[1] = 1;
    gl_PrimitiveIndicesNV[2] = 2;
}
#version 450
#extension GL_NV_mesh_shader : enable

layout(local_size_x=32) in;
layout(points) out;
layout(max_vertices=256, max_primitives=256) out;

layout (location=0) out perprimitiveNV vec4 pointColor[];

void main ()
{
    gl_PrimitiveCountNV = 256u;
    uint firstPixel = 8u * gl_LocalInvocationID.x;
    uint row = firstPixel / 16u;
    uint col = firstPixel % 16u;
    float pixSize = 2.0f / 16.0f;
    float yCoord = pixSize * (float(row) + 0.5f) - 1.0f;
    float baseXCoord = pixSize * (float(col) + 0.5f) - 1.0f;
    for (uint i = 0; i < 8u; i++) {
        float xCoord = baseXCoord + pixSize * float(i);
        uint pixId = firstPixel + i;
        gl_MeshVerticesNV[pixId].gl_Position = vec4(xCoord, yCoord, 0.0f, 1.0f);
        gl_MeshVerticesNV[pixId].gl_PointSize = 1.0f;
        gl_PrimitiveIndicesNV[pixId] = pixId;
        pointColor[pixId] = vec4(((xCoord + 1.0f) / 2.0f), ((yCoord + 1.0f) / 2.0f), 0.0f, 1.0f);
    }
}
#version 450
#extension GL_NV_mesh_shader : enable

layout(local_size_x=32) in;
layout(lines) out;
layout(max_vertices=256, max_primitives=255) out;

layout (location=0) out perprimitiveNV vec4 lineColor[];

void main ()
{
    gl_PrimitiveCountNV = 255u;
    uint firstLine = 8u * gl_LocalInvocationID.x;
    for (uint i = 0u; i < 8u; i++) {
        uint lineId = firstLine + i;
        uint topPixel = 4u * lineId;
        uint bottomPixel = 3u + topPixel;
        if (bottomPixel < 1020u) {
            float bottomCoord = ((float(bottomPixel) + 1.0f) / 1020.0) * 2.0 - 1.0;
            gl_MeshVerticesNV[lineId + 1u].gl_Position = vec4(0.0, bottomCoord, 0.0f, 1.0f);
            gl_PrimitiveIndicesNV[lineId * 2u] = lineId;
            gl_PrimitiveIndicesNV[lineId * 2u + 1u] = lineId + 1u;
            lineColor[lineId] = vec4(0.0f, 1.0f, float(lineId) / 255.0f, 1.0f);
        } else {
            // The last iteration of the last invocation emits the first point
            gl_MeshVerticesNV[0].gl_Position = vec4(0.0, -1.0, 0.0f, 1.0f);
        }
    }
}
#version 450
#extension GL_NV_mesh_shader : enable

layout(local_size_x=32) in;
layout(triangles) out;
layout(max_vertices=256, max_primitives=254) out;

layout (location=0) out perprimitiveNV vec4 triangleColor[];

const float PI_2 = 1.57079632679489661923;
const float RADIUS = 4.5;

void main ()
{
    gl_PrimitiveCountNV = 254u;
    uint firstTriangle = 8u * gl_LocalInvocationID.x;
    for (uint i = 0u; i < 8u; i++) {
        uint triangleId = firstTriangle + i;
        if (triangleId < 254u) {
            uint vertexId = triangleId + 2u;
            float angleProportion = float(vertexId - 1u) / 254.0f;
            float angle = PI_2 * angleProportion;
            float xCoord = cos(angle) * RADIUS - 1.0;
            float yCoord = sin(angle) * RADIUS - 1.0;
            gl_MeshVerticesNV[vertexId].gl_Position = vec4(xCoord, yCoord, 0.0, 1.0);
            gl_PrimitiveIndicesNV[triangleId * 3u + 0u] = 0u;
            gl_PrimitiveIndicesNV[triangleId * 3u + 1u] = triangleId + 1u;
            gl_PrimitiveIndicesNV[triangleId * 3u + 2u] = triangleId + 2u;
            triangleColor[triangleId] = vec4(0.0f, 0.0f, 1.0f, 1.0f);
        } else {
            // The last iterations of the last invocation emit the first two vertices
            uint vertexId = triangleId - 254u;
            if (vertexId == 0u) {
                gl_MeshVerticesNV[0u].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
            } else {
                gl_MeshVerticesNV[1u].gl_Position = vec4(RADIUS, -1.0, 0.0, 1.0);
            }
        }
    }
}
#version 450
#extension GL_NV_mesh_shader : enable

layout (local_size_x=32) in;

out taskNV TaskData {
    uint parentTask[32];
} td;

void main () {
    gl_TaskCountNV = 1;
    td.parentTask[gl_LocalInvocationID.x] = gl_WorkGroupID.x;
}
#version 450
#extension GL_NV_mesh_shader : enable

layout (local_size_x=32) in;
layout (points) out;
layout (max_vertices=32, max_primitives=32) out;

in taskNV TaskData {
    uint parentTask[32];
} td;

layout (location=0) out perprimitiveNV vec4 pointColor[];

void main () {
    uint parentTask = td.parentTask[0];
    if (td.parentTask[gl_LocalInvocationID.x] != parentTask) {
        return;
    }
    gl_PrimitiveCountNV = 32;
    uint jobId = ((parentTask * 1) + gl_WorkGroupID.x) * 32 + gl_LocalInvocationID.x;
    uint row = jobId / 1360;
    uint col = jobId % 1360;
    float yCoord = (float(row + 0.5) / 1542.0) * 2.0 - 1.0;
    float xCoord = (float(col + 0.5) / 1360.0) * 2.0 - 1.0;
    gl_MeshVerticesNV[gl_LocalInvocationID.x].gl_Position = vec4(xCoord, yCoord, 0.0, 1.0);
    gl_MeshVerticesNV[gl_LocalInvocationID.x].gl_PointSize = 1.0;
    gl_PrimitiveIndicesNV[gl_LocalInvocationID.x] = gl_LocalInvocationID.x;
    pointColor[gl_LocalInvocationID.x] = vec4(0.0, 0.0, 1.0, 1.0);
}
#version 450
#extension GL_NV_mesh_shader : enable

layout (local_size_x=32) in;
layout (points) out;
layout (max_vertices=32, max_primitives=32) out;


layout (location=0) out perprimitiveNV vec4 pointColor[];

void main () {
    uint parentTask = 0;
    gl_PrimitiveCountNV = 32;
    uint jobId = ((parentTask * 65535) + gl_WorkGroupID.x) * 32 + gl_LocalInvocationID.x;
    uint row = jobId / 1360;
    uint col = jobId % 1360;
    float yCoord = (float(row + 0.5) / 1542.0) * 2.0 - 1.0;
    float xCoord = (float(col + 0.5) / 1360.0) * 2.0 - 1.0;
    gl_MeshVerticesNV[gl_LocalInvocationID.x].gl_Position = vec4(xCoord, yCoord, 0.0, 1.0);
    gl_MeshVerticesNV[gl_LocalInvocationID.x].gl_PointSize = 1.0;
    gl_PrimitiveIndicesNV[gl_LocalInvocationID.x] = gl_LocalInvocationID.x;
    pointColor[gl_LocalInvocationID.x] = vec4(0.0, 0.0, 1.0, 1.0);
}
#version 450
#extension GL_NV_mesh_shader : enable

layout (local_size_x=32) in;

out taskNV TaskData {
    uint parentTask[32];
} td;

void main () {
    gl_TaskCountNV = 512;
    td.parentTask[gl_LocalInvocationID.x] = gl_WorkGroupID.x;
}
#version 450
#extension GL_NV_mesh_shader : enable

layout (local_size_x=32) in;
layout (points) out;
layout (max_vertices=32, max_primitives=32) out;

in taskNV TaskData {
    uint parentTask[32];
} td;

layout (location=0) out perprimitiveNV vec4 pointColor[];

void main () {
    uint parentTask = td.parentTask[0];
    if (td.parentTask[gl_LocalInvocationID.x] != parentTask) {
        return;
    }
    gl_PrimitiveCountNV = 32;
    uint jobId = ((parentTask * 512) + gl_WorkGroupID.x) * 32 + gl_LocalInvocationID.x;
    uint row = jobId / 4096;
    uint col = jobId % 4096;
    float yCoord = (float(row + 0.5) / 2048.0) * 2.0 - 1.0;
    float xCoord = (float(col + 0.5) / 4096.0) * 2.0 - 1.0;
    gl_MeshVerticesNV[gl_LocalInvocationID.x].gl_Position = vec4(xCoord, yCoord, 0.0, 1.0);
    gl_MeshVerticesNV[gl_LocalInvocationID.x].gl_PointSize = 1.0;
    gl_PrimitiveIndicesNV[gl_LocalInvocationID.x] = gl_LocalInvocationID.x;
    pointColor[gl_LocalInvocationID.x] = vec4(0.0, 0.0, 1.0, 1.0);
}
#version 450
#extension GL_NV_mesh_shader : enable

layout (local_size_x=32) in;
layout (points) out;
layout (max_vertices=256, max_primitives=256) out;

layout (location=0) out perprimitiveNV vec4 primitiveColor[];

void main () {
    gl_PrimitiveCountNV = 0u;
}
#version 450
#extension GL_NV_mesh_shader : enable

layout (local_size_x=32) in;
layout (lines) out;
layout (max_vertices=256, max_primitives=256) out;

layout (location=0) out perprimitiveNV vec4 primitiveColor[];

void main () {
    gl_PrimitiveCountNV = 0u;
}
#version 450
#extension GL_NV_mesh_shader : enable

layout (local_size_x=32) in;
layout (triangles) out;
layout (max_vertices=256, max_primitives=256) out;

layout (location=0) out perprimitiveNV vec4 primitiveColor[];

void main () {
    gl_PrimitiveCountNV = 0u;
}
#version 450
#extension GL_NV_mesh_shader : enable

layout (local_size_x=32) in;

out taskNV TaskData {
    uint localInvocations[32];
} td;

void main () {
    gl_TaskCountNV = 1;
    td.localInvocations[gl_LocalInvocationID.x] = gl_LocalInvocationID.x;
}
#version 450
#extension GL_NV_mesh_shader : enable

layout (local_size_x=32) in;
layout (points) out;
layout (max_vertices=32, max_primitives=32) out;

in taskNV TaskData {
    uint localInvocations[32];
} td;

layout (location=0) out perprimitiveNV vec4 primitiveColor[];

shared uint sumOfIds;

const float PI_2 = 1.57079632679489661923;
const float RADIUS = 1.0f;

void main ()
{
    sumOfIds = 0u;
    memoryBarrierShared();
    barrier();
    atomicAdd(sumOfIds, td.localInvocations[gl_LocalInvocationID.x]);
    memoryBarrierShared();
    barrier();
    // This should dynamically give 0
    gl_PrimitiveCountNV = sumOfIds - (496);

    // Emit points and primitives to the arrays in any case
    if (gl_LocalInvocationID.x > 0u) {
        float proportion = (float(gl_LocalInvocationID.x - 1u) + 0.5f) / float(32 - 1u);
        float angle = PI_2 * proportion;
        float xCoord = cos(angle) * RADIUS - 1.0;
        float yCoord = sin(angle) * RADIUS - 1.0;
        gl_MeshVerticesNV[gl_LocalInvocationID.x].gl_Position = vec4(xCoord, yCoord, 0.0, 1.0);
        gl_MeshVerticesNV[gl_LocalInvocationID.x].gl_PointSize = 1.0;
    } else {
        gl_MeshVerticesNV[gl_LocalInvocationID.x].gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
        gl_MeshVerticesNV[gl_LocalInvocationID.x].gl_PointSize = 1.0;
    }
    uint primitiveId = max(gl_LocalInvocationID.x, 31);
    primitiveColor[primitiveId] = vec4(0.0, 0.0, 1.0, 1.0);
    gl_PrimitiveIndicesNV[primitiveId] = primitiveId;
}
#version 450
#extension GL_NV_mesh_shader : enable

layout (local_size_x=32) in;
layout (lines) out;
layout (max_vertices=32, max_primitives=31) out;

in taskNV TaskData {
    uint localInvocations[32];
} td;

layout (location=0) out perprimitiveNV vec4 primitiveColor[];

shared uint sumOfIds;

const float PI_2 = 1.57079632679489661923;
const float RADIUS = 1.0f;

void main ()
{
    sumOfIds = 0u;
    memoryBarrierShared();
    barrier();
    atomicAdd(sumOfIds, td.localInvocations[gl_LocalInvocationID.x]);
    memoryBarrierShared();
    barrier();
    // This should dynamically give 0
    gl_PrimitiveCountNV = sumOfIds - (496);

    // Emit points and primitives to the arrays in any case
    if (gl_LocalInvocationID.x > 0u) {
        float proportion = (float(gl_LocalInvocationID.x - 1u) + 0.5f) / float(32 - 1u);
        float angle = PI_2 * proportion;
        float xCoord = cos(angle) * RADIUS - 1.0;
        float yCoord = sin(angle) * RADIUS - 1.0;
        gl_MeshVerticesNV[gl_LocalInvocationID.x].gl_Position = vec4(xCoord, yCoord, 0.0, 1.0);
    } else {
        gl_MeshVerticesNV[gl_LocalInvocationID.x].gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
    }
    uint primitiveId = max(gl_LocalInvocationID.x, 30);
    primitiveColor[primitiveId] = vec4(0.0, 0.0, 1.0, 1.0);
    gl_PrimitiveIndicesNV[primitiveId * 2u + 0u] = primitiveId + 0u;
    gl_PrimitiveIndicesNV[primitiveId * 2u + 1u] = primitiveId + 1u;
}
#version 450
#extension GL_NV_mesh_shader : enable

layout (local_size_x=32) in;
layout (triangles) out;
layout (max_vertices=32, max_primitives=30) out;

in taskNV TaskData {
    uint localInvocations[32];
} td;

layout (location=0) out perprimitiveNV vec4 primitiveColor[];

shared uint sumOfIds;

const float PI_2 = 1.57079632679489661923;
const float RADIUS = 1.0f;

void main ()
{
    sumOfIds = 0u;
    memoryBarrierShared();
    barrier();
    atomicAdd(sumOfIds, td.localInvocations[gl_LocalInvocationID.x]);
    memoryBarrierShared();
    barrier();
    // This should dynamically give 0
    gl_PrimitiveCountNV = sumOfIds - (496);

    // Emit points and primitives to the arrays in any case
    if (gl_LocalInvocationID.x > 0u) {
        float proportion = (float(gl_LocalInvocationID.x - 1u) + 0.5f) / float(32 - 1u);
        float angle = PI_2 * proportion;
        float xCoord = cos(angle) * RADIUS - 1.0;
        float yCoord = sin(angle) * RADIUS - 1.0;
        gl_MeshVerticesNV[gl_LocalInvocationID.x].gl_Position = vec4(xCoord, yCoord, 0.0, 1.0);
    } else {
        gl_MeshVerticesNV[gl_LocalInvocationID.x].gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
    }
    uint primitiveId = max(gl_LocalInvocationID.x, 29);
    primitiveColor[primitiveId] = vec4(0.0, 0.0, 1.0, 1.0);
    gl_PrimitiveIndicesNV[primitiveId * 3u + 0u] = 0u;
    gl_PrimitiveIndicesNV[primitiveId * 3u + 1u] = primitiveId + 1u;
    gl_PrimitiveIndicesNV[primitiveId * 3u + 2u] = primitiveId + 3u;
}
#version 450
#extension GL_NV_mesh_shader : enable

layout (local_size_x=32) in;

shared uint counter;

void main ()
{
counter = 0;
memoryBarrierShared();
barrier();
atomicAdd(counter, 1u);
memoryBarrierShared();
barrier();
if (gl_LocalInvocationID.x == 0u) {
    if (counter == 32) {

gl_TaskCountNV = 1u;

    } else {

gl_TaskCountNV = 0u;

    }
}
}
#version 450
#extension GL_NV_mesh_shader : enable

layout (local_size_x=1) in;
layout (points) out;
layout (max_vertices=1, max_primitives=1) out;

layout (location=0) out perprimitiveNV vec4 primitiveColor[];

void main ()
{
gl_PrimitiveCountNV = 1u;
gl_MeshVerticesNV[0].gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
gl_MeshVerticesNV[0].gl_PointSize = 1.0;
primitiveColor[0] = vec4(0.0, 0.0, 1.0, 1.0);
gl_PrimitiveIndicesNV[0] = 0;
}
#version 450
#extension GL_NV_mesh_shader : enable

layout (local_size_x=32) in;
layout (points) out;
layout (max_vertices=1, max_primitives=1) out;

layout (location=0) out perprimitiveNV vec4 primitiveColor[];

shared uint counter;

void main ()
{
counter = 0;
memoryBarrierShared();
barrier();
atomicAdd(counter, 1u);
memoryBarrierShared();
barrier();
if (gl_LocalInvocationID.x == 0u) {
    if (counter == 32) {

gl_PrimitiveCountNV = 1u;
gl_MeshVerticesNV[0].gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
gl_MeshVerticesNV[0].gl_PointSize = 1.0;
primitiveColor[0] = vec4(0.0, 0.0, 1.0, 1.0);
gl_PrimitiveIndicesNV[0] = 0;

    } else {

gl_PrimitiveCountNV = 0u;

    }
}
}
#version 450
#extension GL_NV_mesh_shader : enable

layout (local_size_x=2) in;

shared uint flags[2];

out taskNV TaskData { float blue; } td;

void main ()
{
flags[gl_LocalInvocationID.x] = 0u;
barrier();
flags[gl_LocalInvocationID.x] = 1u;
memoryBarrierShared();
uint otherInvocation = 1u - gl_LocalInvocationID.x;
uint iterations = 0u;
while (flags[otherInvocation] != 1u) {
    iterations++;
}
if (gl_LocalInvocationID.x == 0u) {

gl_TaskCountNV = 1u;
td.blue = float(iterations % 2u);

}
}
#version 450
#extension GL_NV_mesh_shader : enable

layout (local_size_x=1) in;
layout (points) out;
layout (max_vertices=1, max_primitives=1) out;

layout (location=0) out perprimitiveNV vec4 primitiveColor[];

in taskNV TaskData { float blue; } td;

void main ()
{
gl_PrimitiveCountNV = 1u;
gl_MeshVerticesNV[0].gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
gl_MeshVerticesNV[0].gl_PointSize = 1.0;
primitiveColor[0] = vec4(0.0, 0.0, td.blue, 1.0);
gl_PrimitiveIndicesNV[0] = 0;
}
#version 450
#extension GL_NV_mesh_shader : enable

layout (local_size_x=2) in;
layout (points) out;
layout (max_vertices=1, max_primitives=1) out;

layout (location=0) out perprimitiveNV vec4 primitiveColor[];

shared uint flags[2];

void main ()
{
flags[gl_LocalInvocationID.x] = 0u;
barrier();
flags[gl_LocalInvocationID.x] = 1u;
memoryBarrierShared();
uint otherInvocation = 1u - gl_LocalInvocationID.x;
uint iterations = 0u;
while (flags[otherInvocation] != 1u) {
    iterations++;
}
if (gl_LocalInvocationID.x == 0u) {

gl_PrimitiveCountNV = 1u;
gl_MeshVerticesNV[0].gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
gl_MeshVerticesNV[0].gl_PointSize = 1.0;
primitiveColor[0] = vec4(0.0, 0.0, float(iterations % 2u), 1.0);
gl_PrimitiveIndicesNV[0] = 0;

}
}
#version 450
#extension GL_NV_mesh_shader : enable

layout (local_size_x=2) in;

shared uint flags[2];

out taskNV TaskData { float blue; } td;

void main ()
{
flags[gl_LocalInvocationID.x] = 0u;
barrier();
flags[gl_LocalInvocationID.x] = 1u;
groupMemoryBarrier();
uint otherInvocation = 1u - gl_LocalInvocationID.x;
uint iterations = 0u;
while (flags[otherInvocation] != 1u) {
    iterations++;
}
if (gl_LocalInvocationID.x == 0u) {

gl_TaskCountNV = 1u;
td.blue = float(iterations % 2u);

}
}
#version 450
#extension GL_NV_mesh_shader : enable

layout (local_size_x=2) in;
layout (points) out;
layout (max_vertices=1, max_primitives=1) out;

layout (location=0) out perprimitiveNV vec4 primitiveColor[];

shared uint flags[2];

void main ()
{
flags[gl_LocalInvocationID.x] = 0u;
barrier();
flags[gl_LocalInvocationID.x] = 1u;
groupMemoryBarrier();
uint otherInvocation = 1u - gl_LocalInvocationID.x;
uint iterations = 0u;
while (flags[otherInvocation] != 1u) {
    iterations++;
}
if (gl_LocalInvocationID.x == 0u) {

gl_PrimitiveCountNV = 1u;
gl_MeshVerticesNV[0].gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
gl_MeshVerticesNV[0].gl_PointSize = 1.0;
primitiveColor[0] = vec4(0.0, 0.0, float(iterations % 2u), 1.0);
gl_PrimitiveIndicesNV[0] = 0;

}
}
#version 450
#extension GL_NV_mesh_shader : enable

layout (local_size_x=1) in;
layout (max_primitives=2, max_vertices=4) out;
layout (triangles) out;

out gl_MeshPerVertexNV {
    vec4  gl_Position;
    float gl_PointSize;
    float gl_ClipDistance[1];
} gl_MeshVerticesNV[];

layout (location=0) out vec4 customAttribute1[];
layout (location=1) out flat float customAttribute2[];
layout (location=2) out int customAttribute3[];

layout (location=3) out perprimitiveNV uvec4 customAttribute4[];
layout (location=4) out perprimitiveNV float customAttribute5[];

out perprimitiveNV gl_MeshPerPrimitiveNV {
  int gl_PrimitiveID;
  int gl_ViewportIndex;
} gl_MeshPrimitivesNV[];

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
    gl_PrimitiveCountNV = 2u;

    gl_MeshVerticesNV[0].gl_Position = pvd.positions[0]; //vec4(-1.0, -1.0, 0.0, 1.0)
    gl_MeshVerticesNV[1].gl_Position = pvd.positions[1]; //vec4( 1.0, -1.0, 0.0, 1.0)
    gl_MeshVerticesNV[2].gl_Position = pvd.positions[2]; //vec4(-1.0,  1.0, 0.0, 1.0)
    gl_MeshVerticesNV[3].gl_Position = pvd.positions[3]; //vec4( 1.0,  1.0, 0.0, 1.0)

    gl_MeshVerticesNV[0].gl_PointSize = pvd.pointSizes[0]; //1.0
    gl_MeshVerticesNV[1].gl_PointSize = pvd.pointSizes[1]; //1.0
    gl_MeshVerticesNV[2].gl_PointSize = pvd.pointSizes[2]; //1.0
    gl_MeshVerticesNV[3].gl_PointSize = pvd.pointSizes[3]; //1.0

    // Remove geometry on the right side.
    gl_MeshVerticesNV[0].gl_ClipDistance[0] = pvd.clipDistances[0]; // 1.0
    gl_MeshVerticesNV[1].gl_ClipDistance[0] = pvd.clipDistances[1]; //-1.0
    gl_MeshVerticesNV[2].gl_ClipDistance[0] = pvd.clipDistances[2]; // 1.0
    gl_MeshVerticesNV[3].gl_ClipDistance[0] = pvd.clipDistances[3]; //-1.0
    
    gl_PrimitiveIndicesNV[0] = 0;
    gl_PrimitiveIndicesNV[1] = 2;
    gl_PrimitiveIndicesNV[2] = 1;

    gl_PrimitiveIndicesNV[3] = 2;
    gl_PrimitiveIndicesNV[4] = 3;
    gl_PrimitiveIndicesNV[5] = 1;

    gl_MeshPrimitivesNV[0].gl_PrimitiveID = ppd.primitiveIds[0]; //1000
    gl_MeshPrimitivesNV[1].gl_PrimitiveID = ppd.primitiveIds[1]; //1001

    gl_MeshPrimitivesNV[0].gl_ViewportIndex = ppd.viewportIndices[0]; //1
    gl_MeshPrimitivesNV[1].gl_ViewportIndex = ppd.viewportIndices[1]; //1

    // Custom per-vertex attributes
    customAttribute1[0] = pvd.custom1[0]; //vec4(0.25, 0.5, 10.0, 3.0)
    customAttribute1[1] = pvd.custom1[1]; //vec4(0.25, 1.0, 20.0, 3.0)
    customAttribute1[2] = pvd.custom1[2]; //vec4( 0.5, 0.5, 20.0, 3.0)
    customAttribute1[3] = pvd.custom1[3]; //vec4( 0.5, 1.0, 10.0, 3.0)

    customAttribute2[0] = pvd.custom2[0]; //1.0f
    customAttribute2[1] = pvd.custom2[1]; //1.0f
    customAttribute2[2] = pvd.custom2[2]; //2.0f
    customAttribute2[3] = pvd.custom2[3]; //2.0f

    customAttribute3[0] = pvd.custom3[0]; //3
    customAttribute3[1] = pvd.custom3[1]; //3
    customAttribute3[2] = pvd.custom3[2]; //4
    customAttribute3[3] = pvd.custom3[3]; //4

    // Custom per-primitive attributes.
    customAttribute4[0] = ppd.custom4[0]; //uvec4(100, 101, 102, 103)
    customAttribute4[1] = ppd.custom4[1]; //uvec4(200, 201, 202, 203)

    customAttribute5[0] = ppd.custom5[0]; //6.0
    customAttribute5[1] = ppd.custom5[1]; //7.0
}
#version 450
#extension GL_NV_mesh_shader : enable

layout (location=0) in vec4 customAttribute1;
layout (location=1) in flat float customAttribute2;
layout (location=2) in flat int customAttribute3;

layout (location=3) in perprimitiveNV flat uvec4 customAttribute4;
layout (location=4) in perprimitiveNV float customAttribute5;

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
#extension GL_NV_mesh_shader : enable

out taskNV TaskData {
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
} td;

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
    gl_TaskCountNV = 1;

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
}
#version 450
#extension GL_NV_mesh_shader : enable

layout (local_size_x=1) in;
layout (max_primitives=2, max_vertices=4) out;
layout (triangles) out;

out gl_MeshPerVertexNV {
    vec4  gl_Position;
    float gl_PointSize;
    float gl_ClipDistance[1];
} gl_MeshVerticesNV[];

layout (location=0) out vec4 customAttribute1[];
layout (location=1) out flat float customAttribute2[];
layout (location=2) out int customAttribute3[];

layout (location=3) out perprimitiveNV uvec4 customAttribute4[];
layout (location=4) out perprimitiveNV float customAttribute5[];

out perprimitiveNV gl_MeshPerPrimitiveNV {
  int gl_PrimitiveID;
  int gl_ViewportIndex;
} gl_MeshPrimitivesNV[];

in taskNV TaskData {
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
} td;

void main ()
{
    gl_PrimitiveCountNV = 2u;

    gl_MeshVerticesNV[0].gl_Position = td.positions[0]; //vec4(-1.0, -1.0, 0.0, 1.0)
    gl_MeshVerticesNV[1].gl_Position = td.positions[1]; //vec4( 1.0, -1.0, 0.0, 1.0)
    gl_MeshVerticesNV[2].gl_Position = td.positions[2]; //vec4(-1.0,  1.0, 0.0, 1.0)
    gl_MeshVerticesNV[3].gl_Position = td.positions[3]; //vec4( 1.0,  1.0, 0.0, 1.0)

    gl_MeshVerticesNV[0].gl_PointSize = td.pointSizes[0]; //1.0
    gl_MeshVerticesNV[1].gl_PointSize = td.pointSizes[1]; //1.0
    gl_MeshVerticesNV[2].gl_PointSize = td.pointSizes[2]; //1.0
    gl_MeshVerticesNV[3].gl_PointSize = td.pointSizes[3]; //1.0

    // Remove geometry on the right side.
    gl_MeshVerticesNV[0].gl_ClipDistance[0] = td.clipDistances[0]; // 1.0
    gl_MeshVerticesNV[1].gl_ClipDistance[0] = td.clipDistances[1]; //-1.0
    gl_MeshVerticesNV[2].gl_ClipDistance[0] = td.clipDistances[2]; // 1.0
    gl_MeshVerticesNV[3].gl_ClipDistance[0] = td.clipDistances[3]; //-1.0
    
    gl_PrimitiveIndicesNV[0] = 0;
    gl_PrimitiveIndicesNV[1] = 2;
    gl_PrimitiveIndicesNV[2] = 1;

    gl_PrimitiveIndicesNV[3] = 2;
    gl_PrimitiveIndicesNV[4] = 3;
    gl_PrimitiveIndicesNV[5] = 1;

    gl_MeshPrimitivesNV[0].gl_PrimitiveID = td.primitiveIds[0]; //1000
    gl_MeshPrimitivesNV[1].gl_PrimitiveID = td.primitiveIds[1]; //1001

    gl_MeshPrimitivesNV[0].gl_ViewportIndex = td.viewportIndices[0]; //1
    gl_MeshPrimitivesNV[1].gl_ViewportIndex = td.viewportIndices[1]; //1

    // Custom per-vertex attributes
    customAttribute1[0] = td.custom1[0]; //vec4(0.25, 0.5, 10.0, 3.0)
    customAttribute1[1] = td.custom1[1]; //vec4(0.25, 1.0, 20.0, 3.0)
    customAttribute1[2] = td.custom1[2]; //vec4( 0.5, 0.5, 20.0, 3.0)
    customAttribute1[3] = td.custom1[3]; //vec4( 0.5, 1.0, 10.0, 3.0)

    customAttribute2[0] = td.custom2[0]; //1.0f
    customAttribute2[1] = td.custom2[1]; //1.0f
    customAttribute2[2] = td.custom2[2]; //2.0f
    customAttribute2[3] = td.custom2[3]; //2.0f

    customAttribute3[0] = td.custom3[0]; //3
    customAttribute3[1] = td.custom3[1]; //3
    customAttribute3[2] = td.custom3[2]; //4
    customAttribute3[3] = td.custom3[3]; //4

    // Custom per-primitive attributes.
    customAttribute4[0] = td.custom4[0]; //uvec4(100, 101, 102, 103)
    customAttribute4[1] = td.custom4[1]; //uvec4(200, 201, 202, 203)

    customAttribute5[0] = td.custom5[0]; //6.0
    customAttribute5[1] = td.custom5[1]; //7.0
}
#version 450
#extension GL_NV_mesh_shader : enable

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

layout (location=0) out perprimitiveNV vec4 triangleColor[];

layout (push_constant, std430) uniform PushConstantBlock {
    layout (offset=0) float values[4];
} pc;

void main ()
{
    gl_PrimitiveCountNV = 1;

    gl_MeshVerticesNV[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesNV[1].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesNV[2].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);

    gl_PrimitiveIndicesNV[0] = 0;
    gl_PrimitiveIndicesNV[1] = 1;
    gl_PrimitiveIndicesNV[2] = 2;

    triangleColor[0] = vec4(0.0, 0.0, pc.values[0] + pc.values[2], pc.values[1] + pc.values[3]);
}
#version 450
#extension GL_NV_mesh_shader : enable

layout(local_size_x=1) in;

out taskNV TaskData {
    float values[2];
} td;

layout (push_constant, std430) uniform PushConstantBlock {
    layout (offset=8) float values[2];
} pc;

void main ()
{
    gl_TaskCountNV = 1;

    td.values[0] = pc.values[0];
    td.values[1] = pc.values[1];
}
#version 450
#extension GL_NV_mesh_shader : enable

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

layout (location=0) out perprimitiveNV vec4 triangleColor[];

layout (push_constant, std430) uniform PushConstantBlock {
    layout (offset=0) float values[2];
} pc;

in taskNV TaskData {
    float values[2];
} td;

void main ()
{
    gl_PrimitiveCountNV = 1;

    gl_MeshVerticesNV[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesNV[1].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesNV[2].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);

    gl_PrimitiveIndicesNV[0] = 0;
    gl_PrimitiveIndicesNV[1] = 1;
    gl_PrimitiveIndicesNV[2] = 2;

    triangleColor[0] = vec4(0.0, 0.0, td.values[0] + pc.values[0], td.values[1] + pc.values[1]);
}
#version 450
#extension GL_NV_mesh_shader : enable

layout(local_size_x=32) in;
layout(points) out;
layout(max_vertices=128, max_primitives=256) out;

layout (location=0) out perprimitiveNV vec4 pointColor[];

const uint verticesPerInvocation = 4;
const uint primitivesPerVertex   = 2;

vec4 colors[primitivesPerVertex] = vec4[](
    vec4(0.0, 0.0, 1.0, 1.0),
    vec4(1.0, 0.0, 0.0, 1.0)
);
void main ()
{
    gl_PrimitiveCountNV = 256;
    const uint firstVertex = gl_LocalInvocationIndex * verticesPerInvocation;
    for (uint i = 0u; i < verticesPerInvocation; ++i)
    {
        const uint vertexNumber = firstVertex + i;
        const float xCoord = ((float(vertexNumber) + 0.5) / 128.0) * 2.0 - 1.0;
        const float yCoord = 0.0;
        gl_MeshVerticesNV[vertexNumber].gl_Position = vec4(xCoord, yCoord, 0.0f, 1.0f);
        gl_MeshVerticesNV[vertexNumber].gl_PointSize = 1.0f;
        for (uint j = 0u; j < primitivesPerVertex; ++j)
        {
            const uint primitiveNumber = vertexNumber * primitivesPerVertex + j;
            gl_PrimitiveIndicesNV[primitiveNumber] = vertexNumber;
            pointColor[primitiveNumber] = colors[j];
        }
    }
}
#version 450
#extension GL_NV_mesh_shader : enable

layout(local_size_x=32) in;
layout(triangles) out;
layout(max_vertices=256, max_primitives=128) out;

layout (location=0) out perprimitiveNV vec4 triangleColor[];

const uint pixelsPerInvocation     = 2;
const uint verticesPerInvocation   = 8;
const uint primitivesPerInvocation = 4;
const uint indicesPerInvocation    = primitivesPerInvocation * 3u;
const uint verticesPerPixel        = 4;
const uint primitivesPerPixel      = 2;
const uint indicesPerPixel         = primitivesPerPixel * 3u;

void main ()
{
    gl_PrimitiveCountNV = 128;

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
        gl_MeshVerticesNV[firstVertex + 0].gl_Position = vec4(left,  -1.0, 0.0f, 1.0f);
        gl_MeshVerticesNV[firstVertex + 1].gl_Position = vec4(left,   1.0, 0.0f, 1.0f);
        gl_MeshVerticesNV[firstVertex + 2].gl_Position = vec4(right, -1.0, 0.0f, 1.0f);
        gl_MeshVerticesNV[firstVertex + 3].gl_Position = vec4(right,  1.0, 0.0f, 1.0f);

        const uint firstPrimitive = gl_LocalInvocationIndex * primitivesPerInvocation + pixelIdx * primitivesPerPixel;
        triangleColor[firstPrimitive + 0] = vec4(0.0, 0.0, 1.0, 1.0);
        triangleColor[firstPrimitive + 1] = vec4(0.0, 0.0, 1.0, 1.0);

        const uint firstIndex = gl_LocalInvocationIndex * indicesPerInvocation + pixelIdx * indicesPerPixel;
        gl_PrimitiveIndicesNV[firstIndex + 0] = firstVertex + 0;
        gl_PrimitiveIndicesNV[firstIndex + 1] = firstVertex + 1;
        gl_PrimitiveIndicesNV[firstIndex + 2] = firstVertex + 2;
        gl_PrimitiveIndicesNV[firstIndex + 3] = firstVertex + 1;
        gl_PrimitiveIndicesNV[firstIndex + 4] = firstVertex + 3;
        gl_PrimitiveIndicesNV[firstIndex + 5] = firstVertex + 2;
    }
}
#version 450
#extension GL_NV_mesh_shader : enable

layout(local_size_x=32) in;
layout(points) out;
layout(max_vertices=16, max_primitives=16) out;

layout (location=0) out perprimitiveNV vec4 pointColor[];

void main ()
{
    gl_PrimitiveCountNV = 16;
    const uint pixelId = gl_LocalInvocationIndex / 2u;
    if (gl_LocalInvocationIndex % 2u == 0u)
    {
        const float xCoord = (float(pixelId) + 0.5) / float(16) * 2.0 - 1.0;
        gl_MeshVerticesNV[pixelId].gl_Position = vec4(xCoord, 0.0, 0.0f, 1.0f);
        gl_MeshVerticesNV[pixelId].gl_PointSize = 1.0f;
    }
    else
    {
        gl_PrimitiveIndicesNV[pixelId] = pixelId;
        pointColor[pixelId] = vec4(0.0, 0.0, 1.0, 1.0);
    }
}
#version 450
#extension GL_NV_mesh_shader : enable

layout(local_size_x=64) in;
layout(points) out;
layout(max_vertices=32, max_primitives=32) out;

layout (location=0) out perprimitiveNV vec4 pointColor[];

void main ()
{
    gl_PrimitiveCountNV = 32;
    const uint pixelId = gl_LocalInvocationIndex / 2u;
    if (gl_LocalInvocationIndex % 2u == 0u)
    {
        const float xCoord = (float(pixelId) + 0.5) / float(32) * 2.0 - 1.0;
        gl_MeshVerticesNV[pixelId].gl_Position = vec4(xCoord, 0.0, 0.0f, 1.0f);
        gl_MeshVerticesNV[pixelId].gl_PointSize = 1.0f;
    }
    else
    {
        gl_PrimitiveIndicesNV[pixelId] = pixelId;
        pointColor[pixelId] = vec4(0.0, 0.0, 1.0, 1.0);
    }
}
#version 450
#extension GL_NV_mesh_shader : enable

layout(local_size_x=128) in;
layout(points) out;
layout(max_vertices=64, max_primitives=64) out;

layout (location=0) out perprimitiveNV vec4 pointColor[];

void main ()
{
    gl_PrimitiveCountNV = 64;
    const uint pixelId = gl_LocalInvocationIndex / 2u;
    if (gl_LocalInvocationIndex % 2u == 0u)
    {
        const float xCoord = (float(pixelId) + 0.5) / float(64) * 2.0 - 1.0;
        gl_MeshVerticesNV[pixelId].gl_Position = vec4(xCoord, 0.0, 0.0f, 1.0f);
        gl_MeshVerticesNV[pixelId].gl_PointSize = 1.0f;
    }
    else
    {
        gl_PrimitiveIndicesNV[pixelId] = pixelId;
        pointColor[pixelId] = vec4(0.0, 0.0, 1.0, 1.0);
    }
}
#version 450
#extension GL_NV_mesh_shader : enable

layout(local_size_x=256) in;
layout(points) out;
layout(max_vertices=128, max_primitives=128) out;

layout (location=0) out perprimitiveNV vec4 pointColor[];

void main ()
{
    gl_PrimitiveCountNV = 128;
    const uint pixelId = gl_LocalInvocationIndex / 2u;
    if (gl_LocalInvocationIndex % 2u == 0u)
    {
        const float xCoord = (float(pixelId) + 0.5) / float(128) * 2.0 - 1.0;
        gl_MeshVerticesNV[pixelId].gl_Position = vec4(xCoord, 0.0, 0.0f, 1.0f);
        gl_MeshVerticesNV[pixelId].gl_PointSize = 1.0f;
    }
    else
    {
        gl_PrimitiveIndicesNV[pixelId] = pixelId;
        pointColor[pixelId] = vec4(0.0, 0.0, 1.0, 1.0);
    }
}
