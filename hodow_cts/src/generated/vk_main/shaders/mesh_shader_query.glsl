#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=10, local_size_y=4, local_size_z=1) in;
layout (points) out;
layout (max_vertices=256, max_primitives=256) out;

layout (push_constant, std430) uniform PushConstants {
    uint prevDrawCalls;
} pc;


shared uint currentCol;

void main (void)
{
    atomicExchange(currentCol, 0u);
    barrier();

    const uint colCount = uint(32);
    const uint rowCount = uint(0);
    const uint rowsPerDraw = uint(4);

    const float pixWidth = 2.0 / float(colCount);
    const float pixHeight = 2.0 / float(rowCount);
    const float horDelta = pixWidth / 4.0;
    const float verDelta = (pixHeight * 3.0) / 8.0;

    const uint DrawIndex = uint(gl_DrawID);
    const uint currentWGIndex = (gl_WorkGroupID.x + gl_WorkGroupID.y + gl_WorkGroupID.z);
    const uint row = (pc.prevDrawCalls + DrawIndex) * rowsPerDraw + currentWGIndex;
    const uint vertsPerPrimitive = 1;

    SetMeshOutputsEXT(colCount * vertsPerPrimitive, colCount);

    const uint col = atomicAdd(currentCol, 1);
    if (col < colCount)
    {
        const float xCenter = (float(col) + 0.5) / colCount * 2.0 - 1.0;
        const float yCenter = (float(row) + 0.5) / rowCount * 2.0 - 1.0;

        const uint firstVert = col * vertsPerPrimitive;

        gl_MeshVerticesEXT[firstVert].gl_Position = vec4(xCenter, yCenter, 0.0, 1.0);
        gl_MeshVerticesEXT[firstVert].gl_PointSize = 1.0;
        gl_PrimitivePointIndicesEXT[col] = firstVert;
    }
}
#version 460
layout (location=0) out vec4 outColor;
void main (void) { outColor = vec4(0.0, 0.0, 1.0, 1.0); }
#version 460
#extension GL_EXT_multiview : enable
layout (location=0) out vec4 outColor;
void main (void) { outColor = vec4(0.0, float(gl_ViewIndex), 1.0, 1.0); }
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1, local_size_y=4, local_size_z=6) in;

struct TaskData {
    uint branch[24];
    uint drawIndex;
};
taskPayloadSharedEXT TaskData td;

void main ()
{
   td.branch[gl_LocalInvocationIndex] = gl_WorkGroupID.x + gl_WorkGroupID.y + gl_WorkGroupID.z;
   td.drawIndex = uint(gl_DrawID);
   EmitMeshTasksEXT(2, 1, 1);
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=10, local_size_y=4, local_size_z=1) in;
layout (points) out;
layout (max_vertices=256, max_primitives=256) out;

layout (push_constant, std430) uniform PushConstants {
    uint prevDrawCalls;
} pc;

struct TaskData {
    uint branch[24];
    uint drawIndex;
};
taskPayloadSharedEXT TaskData td;


shared uint currentCol;

void main (void)
{
    atomicExchange(currentCol, 0u);
    barrier();

    const uint colCount = uint(32);
    const uint rowCount = uint(0);
    const uint rowsPerDraw = uint(4);

    const float pixWidth = 2.0 / float(colCount);
    const float pixHeight = 2.0 / float(rowCount);
    const float horDelta = pixWidth / 4.0;
    const float verDelta = (pixHeight * 3.0) / 8.0;

    const uint DrawIndex = td.drawIndex;
    const uint currentWGIndex = (2u * td.branch[min(gl_LocalInvocationIndex, 23)] + gl_WorkGroupID.x + gl_WorkGroupID.y + gl_WorkGroupID.z);
    const uint row = (pc.prevDrawCalls + DrawIndex) * rowsPerDraw + currentWGIndex;
    const uint vertsPerPrimitive = 1;

    SetMeshOutputsEXT(colCount * vertsPerPrimitive, colCount);

    const uint col = atomicAdd(currentCol, 1);
    if (col < colCount)
    {
        const float xCenter = (float(col) + 0.5) / colCount * 2.0 - 1.0;
        const float yCenter = (float(row) + 0.5) / rowCount * 2.0 - 1.0;

        const uint firstVert = col * vertsPerPrimitive;

        gl_MeshVerticesEXT[firstVert].gl_Position = vec4(xCenter, yCenter, 0.0, 1.0);
        gl_MeshVerticesEXT[firstVert].gl_PointSize = 1.0;
        gl_PrimitivePointIndicesEXT[col] = firstVert;
    }
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1, local_size_y=4, local_size_z=6) in;

struct TaskData {
    uint branch[24];
    uint drawIndex;
};
taskPayloadSharedEXT TaskData td;

void main ()
{
   td.branch[gl_LocalInvocationIndex] = gl_WorkGroupID.x + gl_WorkGroupID.y + gl_WorkGroupID.z;
   td.drawIndex = uint(gl_DrawID);
   EmitMeshTasksEXT(1, 2, 1);
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1, local_size_y=4, local_size_z=6) in;

struct TaskData {
    uint branch[24];
    uint drawIndex;
};
taskPayloadSharedEXT TaskData td;

void main ()
{
   td.branch[gl_LocalInvocationIndex] = gl_WorkGroupID.x + gl_WorkGroupID.y + gl_WorkGroupID.z;
   td.drawIndex = uint(gl_DrawID);
   EmitMeshTasksEXT(1, 1, 2);
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=10, local_size_y=4, local_size_z=1) in;
layout (points) out;
layout (max_vertices=256, max_primitives=256) out;

layout (push_constant, std430) uniform PushConstants {
    uint prevDrawCalls;
} pc;


shared uint currentCol;

void main (void)
{
    atomicExchange(currentCol, 0u);
    barrier();

    const uint colCount = uint(32);
    const uint rowCount = uint(40);
    const uint rowsPerDraw = uint(4);

    const float pixWidth = 2.0 / float(colCount);
    const float pixHeight = 2.0 / float(rowCount);
    const float horDelta = pixWidth / 4.0;
    const float verDelta = (pixHeight * 3.0) / 8.0;

    const uint DrawIndex = uint(gl_DrawID);
    const uint currentWGIndex = (gl_WorkGroupID.x + gl_WorkGroupID.y + gl_WorkGroupID.z);
    const uint row = (pc.prevDrawCalls + DrawIndex) * rowsPerDraw + currentWGIndex;
    const uint vertsPerPrimitive = 1;

    SetMeshOutputsEXT(colCount * vertsPerPrimitive, colCount);

    const uint col = atomicAdd(currentCol, 1);
    if (col < colCount)
    {
        const float xCenter = (float(col) + 0.5) / colCount * 2.0 - 1.0;
        const float yCenter = (float(row) + 0.5) / rowCount * 2.0 - 1.0;

        const uint firstVert = col * vertsPerPrimitive;

        gl_MeshVerticesEXT[firstVert].gl_Position = vec4(xCenter, yCenter, 0.0, 1.0);
        gl_MeshVerticesEXT[firstVert].gl_PointSize = 1.0;
        gl_PrimitivePointIndicesEXT[col] = firstVert;
    }
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=10, local_size_y=4, local_size_z=1) in;
layout (points) out;
layout (max_vertices=256, max_primitives=256) out;

layout (push_constant, std430) uniform PushConstants {
    uint prevDrawCalls;
} pc;

struct TaskData {
    uint branch[24];
    uint drawIndex;
};
taskPayloadSharedEXT TaskData td;


shared uint currentCol;

void main (void)
{
    atomicExchange(currentCol, 0u);
    barrier();

    const uint colCount = uint(32);
    const uint rowCount = uint(40);
    const uint rowsPerDraw = uint(4);

    const float pixWidth = 2.0 / float(colCount);
    const float pixHeight = 2.0 / float(rowCount);
    const float horDelta = pixWidth / 4.0;
    const float verDelta = (pixHeight * 3.0) / 8.0;

    const uint DrawIndex = td.drawIndex;
    const uint currentWGIndex = (2u * td.branch[min(gl_LocalInvocationIndex, 23)] + gl_WorkGroupID.x + gl_WorkGroupID.y + gl_WorkGroupID.z);
    const uint row = (pc.prevDrawCalls + DrawIndex) * rowsPerDraw + currentWGIndex;
    const uint vertsPerPrimitive = 1;

    SetMeshOutputsEXT(colCount * vertsPerPrimitive, colCount);

    const uint col = atomicAdd(currentCol, 1);
    if (col < colCount)
    {
        const float xCenter = (float(col) + 0.5) / colCount * 2.0 - 1.0;
        const float yCenter = (float(row) + 0.5) / rowCount * 2.0 - 1.0;

        const uint firstVert = col * vertsPerPrimitive;

        gl_MeshVerticesEXT[firstVert].gl_Position = vec4(xCenter, yCenter, 0.0, 1.0);
        gl_MeshVerticesEXT[firstVert].gl_PointSize = 1.0;
        gl_PrimitivePointIndicesEXT[col] = firstVert;
    }
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=10, local_size_y=4, local_size_z=1) in;
layout (points) out;
layout (max_vertices=256, max_primitives=256) out;

layout (push_constant, std430) uniform PushConstants {
    uint prevDrawCalls;
} pc;


shared uint currentCol;

void main (void)
{
    atomicExchange(currentCol, 0u);
    barrier();

    const uint colCount = uint(32);
    const uint rowCount = uint(240);
    const uint rowsPerDraw = uint(4);

    const float pixWidth = 2.0 / float(colCount);
    const float pixHeight = 2.0 / float(rowCount);
    const float horDelta = pixWidth / 4.0;
    const float verDelta = (pixHeight * 3.0) / 8.0;

    const uint DrawIndex = uint(gl_DrawID);
    const uint currentWGIndex = (gl_WorkGroupID.x + gl_WorkGroupID.y + gl_WorkGroupID.z);
    const uint row = (pc.prevDrawCalls + DrawIndex) * rowsPerDraw + currentWGIndex;
    const uint vertsPerPrimitive = 1;

    SetMeshOutputsEXT(colCount * vertsPerPrimitive, colCount);

    const uint col = atomicAdd(currentCol, 1);
    if (col < colCount)
    {
        const float xCenter = (float(col) + 0.5) / colCount * 2.0 - 1.0;
        const float yCenter = (float(row) + 0.5) / rowCount * 2.0 - 1.0;

        const uint firstVert = col * vertsPerPrimitive;

        gl_MeshVerticesEXT[firstVert].gl_Position = vec4(xCenter, yCenter, 0.0, 1.0);
        gl_MeshVerticesEXT[firstVert].gl_PointSize = 1.0;
        gl_PrimitivePointIndicesEXT[col] = firstVert;
    }
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=10, local_size_y=4, local_size_z=1) in;
layout (points) out;
layout (max_vertices=256, max_primitives=256) out;

layout (push_constant, std430) uniform PushConstants {
    uint prevDrawCalls;
} pc;

struct TaskData {
    uint branch[24];
    uint drawIndex;
};
taskPayloadSharedEXT TaskData td;


shared uint currentCol;

void main (void)
{
    atomicExchange(currentCol, 0u);
    barrier();

    const uint colCount = uint(32);
    const uint rowCount = uint(240);
    const uint rowsPerDraw = uint(4);

    const float pixWidth = 2.0 / float(colCount);
    const float pixHeight = 2.0 / float(rowCount);
    const float horDelta = pixWidth / 4.0;
    const float verDelta = (pixHeight * 3.0) / 8.0;

    const uint DrawIndex = td.drawIndex;
    const uint currentWGIndex = (2u * td.branch[min(gl_LocalInvocationIndex, 23)] + gl_WorkGroupID.x + gl_WorkGroupID.y + gl_WorkGroupID.z);
    const uint row = (pc.prevDrawCalls + DrawIndex) * rowsPerDraw + currentWGIndex;
    const uint vertsPerPrimitive = 1;

    SetMeshOutputsEXT(colCount * vertsPerPrimitive, colCount);

    const uint col = atomicAdd(currentCol, 1);
    if (col < colCount)
    {
        const float xCenter = (float(col) + 0.5) / colCount * 2.0 - 1.0;
        const float yCenter = (float(row) + 0.5) / rowCount * 2.0 - 1.0;

        const uint firstVert = col * vertsPerPrimitive;

        gl_MeshVerticesEXT[firstVert].gl_Position = vec4(xCenter, yCenter, 0.0, 1.0);
        gl_MeshVerticesEXT[firstVert].gl_PointSize = 1.0;
        gl_PrimitivePointIndicesEXT[col] = firstVert;
    }
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=10, local_size_y=4, local_size_z=1) in;
layout (lines) out;
layout (max_vertices=256, max_primitives=256) out;

layout (push_constant, std430) uniform PushConstants {
    uint prevDrawCalls;
} pc;


shared uint currentCol;

void main (void)
{
    atomicExchange(currentCol, 0u);
    barrier();

    const uint colCount = uint(32);
    const uint rowCount = uint(0);
    const uint rowsPerDraw = uint(4);

    const float pixWidth = 2.0 / float(colCount);
    const float pixHeight = 2.0 / float(rowCount);
    const float horDelta = pixWidth / 4.0;
    const float verDelta = (pixHeight * 3.0) / 8.0;

    const uint DrawIndex = uint(gl_DrawID);
    const uint currentWGIndex = (gl_WorkGroupID.x + gl_WorkGroupID.y + gl_WorkGroupID.z);
    const uint row = (pc.prevDrawCalls + DrawIndex) * rowsPerDraw + currentWGIndex;
    const uint vertsPerPrimitive = 2;

    SetMeshOutputsEXT(colCount * vertsPerPrimitive, colCount);

    const uint col = atomicAdd(currentCol, 1);
    if (col < colCount)
    {
        const float xCenter = (float(col) + 0.5) / colCount * 2.0 - 1.0;
        const float yCenter = (float(row) + 0.5) / rowCount * 2.0 - 1.0;

        const uint firstVert = col * vertsPerPrimitive;

        gl_MeshVerticesEXT[firstVert + 0].gl_Position = vec4(xCenter - horDelta, yCenter, 0.0, 1.0);
        gl_MeshVerticesEXT[firstVert + 1].gl_Position = vec4(xCenter + horDelta, yCenter - verDelta, 0.0, 1.0);
        gl_PrimitiveLineIndicesEXT[col] = uvec2(firstVert, firstVert + 1);
    }
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=10, local_size_y=4, local_size_z=1) in;
layout (lines) out;
layout (max_vertices=256, max_primitives=256) out;

layout (push_constant, std430) uniform PushConstants {
    uint prevDrawCalls;
} pc;

struct TaskData {
    uint branch[24];
    uint drawIndex;
};
taskPayloadSharedEXT TaskData td;


shared uint currentCol;

void main (void)
{
    atomicExchange(currentCol, 0u);
    barrier();

    const uint colCount = uint(32);
    const uint rowCount = uint(0);
    const uint rowsPerDraw = uint(4);

    const float pixWidth = 2.0 / float(colCount);
    const float pixHeight = 2.0 / float(rowCount);
    const float horDelta = pixWidth / 4.0;
    const float verDelta = (pixHeight * 3.0) / 8.0;

    const uint DrawIndex = td.drawIndex;
    const uint currentWGIndex = (2u * td.branch[min(gl_LocalInvocationIndex, 23)] + gl_WorkGroupID.x + gl_WorkGroupID.y + gl_WorkGroupID.z);
    const uint row = (pc.prevDrawCalls + DrawIndex) * rowsPerDraw + currentWGIndex;
    const uint vertsPerPrimitive = 2;

    SetMeshOutputsEXT(colCount * vertsPerPrimitive, colCount);

    const uint col = atomicAdd(currentCol, 1);
    if (col < colCount)
    {
        const float xCenter = (float(col) + 0.5) / colCount * 2.0 - 1.0;
        const float yCenter = (float(row) + 0.5) / rowCount * 2.0 - 1.0;

        const uint firstVert = col * vertsPerPrimitive;

        gl_MeshVerticesEXT[firstVert + 0].gl_Position = vec4(xCenter - horDelta, yCenter, 0.0, 1.0);
        gl_MeshVerticesEXT[firstVert + 1].gl_Position = vec4(xCenter + horDelta, yCenter - verDelta, 0.0, 1.0);
        gl_PrimitiveLineIndicesEXT[col] = uvec2(firstVert, firstVert + 1);
    }
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=10, local_size_y=4, local_size_z=1) in;
layout (lines) out;
layout (max_vertices=256, max_primitives=256) out;

layout (push_constant, std430) uniform PushConstants {
    uint prevDrawCalls;
} pc;


shared uint currentCol;

void main (void)
{
    atomicExchange(currentCol, 0u);
    barrier();

    const uint colCount = uint(32);
    const uint rowCount = uint(40);
    const uint rowsPerDraw = uint(4);

    const float pixWidth = 2.0 / float(colCount);
    const float pixHeight = 2.0 / float(rowCount);
    const float horDelta = pixWidth / 4.0;
    const float verDelta = (pixHeight * 3.0) / 8.0;

    const uint DrawIndex = uint(gl_DrawID);
    const uint currentWGIndex = (gl_WorkGroupID.x + gl_WorkGroupID.y + gl_WorkGroupID.z);
    const uint row = (pc.prevDrawCalls + DrawIndex) * rowsPerDraw + currentWGIndex;
    const uint vertsPerPrimitive = 2;

    SetMeshOutputsEXT(colCount * vertsPerPrimitive, colCount);

    const uint col = atomicAdd(currentCol, 1);
    if (col < colCount)
    {
        const float xCenter = (float(col) + 0.5) / colCount * 2.0 - 1.0;
        const float yCenter = (float(row) + 0.5) / rowCount * 2.0 - 1.0;

        const uint firstVert = col * vertsPerPrimitive;

        gl_MeshVerticesEXT[firstVert + 0].gl_Position = vec4(xCenter - horDelta, yCenter, 0.0, 1.0);
        gl_MeshVerticesEXT[firstVert + 1].gl_Position = vec4(xCenter + horDelta, yCenter - verDelta, 0.0, 1.0);
        gl_PrimitiveLineIndicesEXT[col] = uvec2(firstVert, firstVert + 1);
    }
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=10, local_size_y=4, local_size_z=1) in;
layout (lines) out;
layout (max_vertices=256, max_primitives=256) out;

layout (push_constant, std430) uniform PushConstants {
    uint prevDrawCalls;
} pc;

struct TaskData {
    uint branch[24];
    uint drawIndex;
};
taskPayloadSharedEXT TaskData td;


shared uint currentCol;

void main (void)
{
    atomicExchange(currentCol, 0u);
    barrier();

    const uint colCount = uint(32);
    const uint rowCount = uint(40);
    const uint rowsPerDraw = uint(4);

    const float pixWidth = 2.0 / float(colCount);
    const float pixHeight = 2.0 / float(rowCount);
    const float horDelta = pixWidth / 4.0;
    const float verDelta = (pixHeight * 3.0) / 8.0;

    const uint DrawIndex = td.drawIndex;
    const uint currentWGIndex = (2u * td.branch[min(gl_LocalInvocationIndex, 23)] + gl_WorkGroupID.x + gl_WorkGroupID.y + gl_WorkGroupID.z);
    const uint row = (pc.prevDrawCalls + DrawIndex) * rowsPerDraw + currentWGIndex;
    const uint vertsPerPrimitive = 2;

    SetMeshOutputsEXT(colCount * vertsPerPrimitive, colCount);

    const uint col = atomicAdd(currentCol, 1);
    if (col < colCount)
    {
        const float xCenter = (float(col) + 0.5) / colCount * 2.0 - 1.0;
        const float yCenter = (float(row) + 0.5) / rowCount * 2.0 - 1.0;

        const uint firstVert = col * vertsPerPrimitive;

        gl_MeshVerticesEXT[firstVert + 0].gl_Position = vec4(xCenter - horDelta, yCenter, 0.0, 1.0);
        gl_MeshVerticesEXT[firstVert + 1].gl_Position = vec4(xCenter + horDelta, yCenter - verDelta, 0.0, 1.0);
        gl_PrimitiveLineIndicesEXT[col] = uvec2(firstVert, firstVert + 1);
    }
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=10, local_size_y=4, local_size_z=1) in;
layout (lines) out;
layout (max_vertices=256, max_primitives=256) out;

layout (push_constant, std430) uniform PushConstants {
    uint prevDrawCalls;
} pc;


shared uint currentCol;

void main (void)
{
    atomicExchange(currentCol, 0u);
    barrier();

    const uint colCount = uint(32);
    const uint rowCount = uint(240);
    const uint rowsPerDraw = uint(4);

    const float pixWidth = 2.0 / float(colCount);
    const float pixHeight = 2.0 / float(rowCount);
    const float horDelta = pixWidth / 4.0;
    const float verDelta = (pixHeight * 3.0) / 8.0;

    const uint DrawIndex = uint(gl_DrawID);
    const uint currentWGIndex = (gl_WorkGroupID.x + gl_WorkGroupID.y + gl_WorkGroupID.z);
    const uint row = (pc.prevDrawCalls + DrawIndex) * rowsPerDraw + currentWGIndex;
    const uint vertsPerPrimitive = 2;

    SetMeshOutputsEXT(colCount * vertsPerPrimitive, colCount);

    const uint col = atomicAdd(currentCol, 1);
    if (col < colCount)
    {
        const float xCenter = (float(col) + 0.5) / colCount * 2.0 - 1.0;
        const float yCenter = (float(row) + 0.5) / rowCount * 2.0 - 1.0;

        const uint firstVert = col * vertsPerPrimitive;

        gl_MeshVerticesEXT[firstVert + 0].gl_Position = vec4(xCenter - horDelta, yCenter, 0.0, 1.0);
        gl_MeshVerticesEXT[firstVert + 1].gl_Position = vec4(xCenter + horDelta, yCenter - verDelta, 0.0, 1.0);
        gl_PrimitiveLineIndicesEXT[col] = uvec2(firstVert, firstVert + 1);
    }
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=10, local_size_y=4, local_size_z=1) in;
layout (lines) out;
layout (max_vertices=256, max_primitives=256) out;

layout (push_constant, std430) uniform PushConstants {
    uint prevDrawCalls;
} pc;

struct TaskData {
    uint branch[24];
    uint drawIndex;
};
taskPayloadSharedEXT TaskData td;


shared uint currentCol;

void main (void)
{
    atomicExchange(currentCol, 0u);
    barrier();

    const uint colCount = uint(32);
    const uint rowCount = uint(240);
    const uint rowsPerDraw = uint(4);

    const float pixWidth = 2.0 / float(colCount);
    const float pixHeight = 2.0 / float(rowCount);
    const float horDelta = pixWidth / 4.0;
    const float verDelta = (pixHeight * 3.0) / 8.0;

    const uint DrawIndex = td.drawIndex;
    const uint currentWGIndex = (2u * td.branch[min(gl_LocalInvocationIndex, 23)] + gl_WorkGroupID.x + gl_WorkGroupID.y + gl_WorkGroupID.z);
    const uint row = (pc.prevDrawCalls + DrawIndex) * rowsPerDraw + currentWGIndex;
    const uint vertsPerPrimitive = 2;

    SetMeshOutputsEXT(colCount * vertsPerPrimitive, colCount);

    const uint col = atomicAdd(currentCol, 1);
    if (col < colCount)
    {
        const float xCenter = (float(col) + 0.5) / colCount * 2.0 - 1.0;
        const float yCenter = (float(row) + 0.5) / rowCount * 2.0 - 1.0;

        const uint firstVert = col * vertsPerPrimitive;

        gl_MeshVerticesEXT[firstVert + 0].gl_Position = vec4(xCenter - horDelta, yCenter, 0.0, 1.0);
        gl_MeshVerticesEXT[firstVert + 1].gl_Position = vec4(xCenter + horDelta, yCenter - verDelta, 0.0, 1.0);
        gl_PrimitiveLineIndicesEXT[col] = uvec2(firstVert, firstVert + 1);
    }
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=10, local_size_y=4, local_size_z=1) in;
layout (triangles) out;
layout (max_vertices=256, max_primitives=256) out;

layout (push_constant, std430) uniform PushConstants {
    uint prevDrawCalls;
} pc;


shared uint currentCol;

void main (void)
{
    atomicExchange(currentCol, 0u);
    barrier();

    const uint colCount = uint(32);
    const uint rowCount = uint(0);
    const uint rowsPerDraw = uint(4);

    const float pixWidth = 2.0 / float(colCount);
    const float pixHeight = 2.0 / float(rowCount);
    const float horDelta = pixWidth / 4.0;
    const float verDelta = (pixHeight * 3.0) / 8.0;

    const uint DrawIndex = uint(gl_DrawID);
    const uint currentWGIndex = (gl_WorkGroupID.x + gl_WorkGroupID.y + gl_WorkGroupID.z);
    const uint row = (pc.prevDrawCalls + DrawIndex) * rowsPerDraw + currentWGIndex;
    const uint vertsPerPrimitive = 3;

    SetMeshOutputsEXT(colCount * vertsPerPrimitive, colCount);

    const uint col = atomicAdd(currentCol, 1);
    if (col < colCount)
    {
        const float xCenter = (float(col) + 0.5) / colCount * 2.0 - 1.0;
        const float yCenter = (float(row) + 0.5) / rowCount * 2.0 - 1.0;

        const uint firstVert = col * vertsPerPrimitive;

        gl_MeshVerticesEXT[firstVert + 0].gl_Position = vec4(xCenter           , yCenter - verDelta, 0.0, 1.0);
        gl_MeshVerticesEXT[firstVert + 1].gl_Position = vec4(xCenter - horDelta, yCenter + verDelta, 0.0, 1.0);
        gl_MeshVerticesEXT[firstVert + 2].gl_Position = vec4(xCenter + horDelta, yCenter + verDelta, 0.0, 1.0);
        gl_PrimitiveTriangleIndicesEXT[col] = uvec3(firstVert, firstVert + 1, firstVert + 2);
    }
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=10, local_size_y=4, local_size_z=1) in;
layout (triangles) out;
layout (max_vertices=256, max_primitives=256) out;

layout (push_constant, std430) uniform PushConstants {
    uint prevDrawCalls;
} pc;

struct TaskData {
    uint branch[24];
    uint drawIndex;
};
taskPayloadSharedEXT TaskData td;


shared uint currentCol;

void main (void)
{
    atomicExchange(currentCol, 0u);
    barrier();

    const uint colCount = uint(32);
    const uint rowCount = uint(0);
    const uint rowsPerDraw = uint(4);

    const float pixWidth = 2.0 / float(colCount);
    const float pixHeight = 2.0 / float(rowCount);
    const float horDelta = pixWidth / 4.0;
    const float verDelta = (pixHeight * 3.0) / 8.0;

    const uint DrawIndex = td.drawIndex;
    const uint currentWGIndex = (2u * td.branch[min(gl_LocalInvocationIndex, 23)] + gl_WorkGroupID.x + gl_WorkGroupID.y + gl_WorkGroupID.z);
    const uint row = (pc.prevDrawCalls + DrawIndex) * rowsPerDraw + currentWGIndex;
    const uint vertsPerPrimitive = 3;

    SetMeshOutputsEXT(colCount * vertsPerPrimitive, colCount);

    const uint col = atomicAdd(currentCol, 1);
    if (col < colCount)
    {
        const float xCenter = (float(col) + 0.5) / colCount * 2.0 - 1.0;
        const float yCenter = (float(row) + 0.5) / rowCount * 2.0 - 1.0;

        const uint firstVert = col * vertsPerPrimitive;

        gl_MeshVerticesEXT[firstVert + 0].gl_Position = vec4(xCenter           , yCenter - verDelta, 0.0, 1.0);
        gl_MeshVerticesEXT[firstVert + 1].gl_Position = vec4(xCenter - horDelta, yCenter + verDelta, 0.0, 1.0);
        gl_MeshVerticesEXT[firstVert + 2].gl_Position = vec4(xCenter + horDelta, yCenter + verDelta, 0.0, 1.0);
        gl_PrimitiveTriangleIndicesEXT[col] = uvec3(firstVert, firstVert + 1, firstVert + 2);
    }
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=10, local_size_y=4, local_size_z=1) in;
layout (triangles) out;
layout (max_vertices=256, max_primitives=256) out;

layout (push_constant, std430) uniform PushConstants {
    uint prevDrawCalls;
} pc;


shared uint currentCol;

void main (void)
{
    atomicExchange(currentCol, 0u);
    barrier();

    const uint colCount = uint(32);
    const uint rowCount = uint(40);
    const uint rowsPerDraw = uint(4);

    const float pixWidth = 2.0 / float(colCount);
    const float pixHeight = 2.0 / float(rowCount);
    const float horDelta = pixWidth / 4.0;
    const float verDelta = (pixHeight * 3.0) / 8.0;

    const uint DrawIndex = uint(gl_DrawID);
    const uint currentWGIndex = (gl_WorkGroupID.x + gl_WorkGroupID.y + gl_WorkGroupID.z);
    const uint row = (pc.prevDrawCalls + DrawIndex) * rowsPerDraw + currentWGIndex;
    const uint vertsPerPrimitive = 3;

    SetMeshOutputsEXT(colCount * vertsPerPrimitive, colCount);

    const uint col = atomicAdd(currentCol, 1);
    if (col < colCount)
    {
        const float xCenter = (float(col) + 0.5) / colCount * 2.0 - 1.0;
        const float yCenter = (float(row) + 0.5) / rowCount * 2.0 - 1.0;

        const uint firstVert = col * vertsPerPrimitive;

        gl_MeshVerticesEXT[firstVert + 0].gl_Position = vec4(xCenter           , yCenter - verDelta, 0.0, 1.0);
        gl_MeshVerticesEXT[firstVert + 1].gl_Position = vec4(xCenter - horDelta, yCenter + verDelta, 0.0, 1.0);
        gl_MeshVerticesEXT[firstVert + 2].gl_Position = vec4(xCenter + horDelta, yCenter + verDelta, 0.0, 1.0);
        gl_PrimitiveTriangleIndicesEXT[col] = uvec3(firstVert, firstVert + 1, firstVert + 2);
    }
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=10, local_size_y=4, local_size_z=1) in;
layout (triangles) out;
layout (max_vertices=256, max_primitives=256) out;

layout (push_constant, std430) uniform PushConstants {
    uint prevDrawCalls;
} pc;

struct TaskData {
    uint branch[24];
    uint drawIndex;
};
taskPayloadSharedEXT TaskData td;


shared uint currentCol;

void main (void)
{
    atomicExchange(currentCol, 0u);
    barrier();

    const uint colCount = uint(32);
    const uint rowCount = uint(40);
    const uint rowsPerDraw = uint(4);

    const float pixWidth = 2.0 / float(colCount);
    const float pixHeight = 2.0 / float(rowCount);
    const float horDelta = pixWidth / 4.0;
    const float verDelta = (pixHeight * 3.0) / 8.0;

    const uint DrawIndex = td.drawIndex;
    const uint currentWGIndex = (2u * td.branch[min(gl_LocalInvocationIndex, 23)] + gl_WorkGroupID.x + gl_WorkGroupID.y + gl_WorkGroupID.z);
    const uint row = (pc.prevDrawCalls + DrawIndex) * rowsPerDraw + currentWGIndex;
    const uint vertsPerPrimitive = 3;

    SetMeshOutputsEXT(colCount * vertsPerPrimitive, colCount);

    const uint col = atomicAdd(currentCol, 1);
    if (col < colCount)
    {
        const float xCenter = (float(col) + 0.5) / colCount * 2.0 - 1.0;
        const float yCenter = (float(row) + 0.5) / rowCount * 2.0 - 1.0;

        const uint firstVert = col * vertsPerPrimitive;

        gl_MeshVerticesEXT[firstVert + 0].gl_Position = vec4(xCenter           , yCenter - verDelta, 0.0, 1.0);
        gl_MeshVerticesEXT[firstVert + 1].gl_Position = vec4(xCenter - horDelta, yCenter + verDelta, 0.0, 1.0);
        gl_MeshVerticesEXT[firstVert + 2].gl_Position = vec4(xCenter + horDelta, yCenter + verDelta, 0.0, 1.0);
        gl_PrimitiveTriangleIndicesEXT[col] = uvec3(firstVert, firstVert + 1, firstVert + 2);
    }
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=10, local_size_y=4, local_size_z=1) in;
layout (triangles) out;
layout (max_vertices=256, max_primitives=256) out;

layout (push_constant, std430) uniform PushConstants {
    uint prevDrawCalls;
} pc;


shared uint currentCol;

void main (void)
{
    atomicExchange(currentCol, 0u);
    barrier();

    const uint colCount = uint(32);
    const uint rowCount = uint(240);
    const uint rowsPerDraw = uint(4);

    const float pixWidth = 2.0 / float(colCount);
    const float pixHeight = 2.0 / float(rowCount);
    const float horDelta = pixWidth / 4.0;
    const float verDelta = (pixHeight * 3.0) / 8.0;

    const uint DrawIndex = uint(gl_DrawID);
    const uint currentWGIndex = (gl_WorkGroupID.x + gl_WorkGroupID.y + gl_WorkGroupID.z);
    const uint row = (pc.prevDrawCalls + DrawIndex) * rowsPerDraw + currentWGIndex;
    const uint vertsPerPrimitive = 3;

    SetMeshOutputsEXT(colCount * vertsPerPrimitive, colCount);

    const uint col = atomicAdd(currentCol, 1);
    if (col < colCount)
    {
        const float xCenter = (float(col) + 0.5) / colCount * 2.0 - 1.0;
        const float yCenter = (float(row) + 0.5) / rowCount * 2.0 - 1.0;

        const uint firstVert = col * vertsPerPrimitive;

        gl_MeshVerticesEXT[firstVert + 0].gl_Position = vec4(xCenter           , yCenter - verDelta, 0.0, 1.0);
        gl_MeshVerticesEXT[firstVert + 1].gl_Position = vec4(xCenter - horDelta, yCenter + verDelta, 0.0, 1.0);
        gl_MeshVerticesEXT[firstVert + 2].gl_Position = vec4(xCenter + horDelta, yCenter + verDelta, 0.0, 1.0);
        gl_PrimitiveTriangleIndicesEXT[col] = uvec3(firstVert, firstVert + 1, firstVert + 2);
    }
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=10, local_size_y=4, local_size_z=1) in;
layout (triangles) out;
layout (max_vertices=256, max_primitives=256) out;

layout (push_constant, std430) uniform PushConstants {
    uint prevDrawCalls;
} pc;

struct TaskData {
    uint branch[24];
    uint drawIndex;
};
taskPayloadSharedEXT TaskData td;


shared uint currentCol;

void main (void)
{
    atomicExchange(currentCol, 0u);
    barrier();

    const uint colCount = uint(32);
    const uint rowCount = uint(240);
    const uint rowsPerDraw = uint(4);

    const float pixWidth = 2.0 / float(colCount);
    const float pixHeight = 2.0 / float(rowCount);
    const float horDelta = pixWidth / 4.0;
    const float verDelta = (pixHeight * 3.0) / 8.0;

    const uint DrawIndex = td.drawIndex;
    const uint currentWGIndex = (2u * td.branch[min(gl_LocalInvocationIndex, 23)] + gl_WorkGroupID.x + gl_WorkGroupID.y + gl_WorkGroupID.z);
    const uint row = (pc.prevDrawCalls + DrawIndex) * rowsPerDraw + currentWGIndex;
    const uint vertsPerPrimitive = 3;

    SetMeshOutputsEXT(colCount * vertsPerPrimitive, colCount);

    const uint col = atomicAdd(currentCol, 1);
    if (col < colCount)
    {
        const float xCenter = (float(col) + 0.5) / colCount * 2.0 - 1.0;
        const float yCenter = (float(row) + 0.5) / rowCount * 2.0 - 1.0;

        const uint firstVert = col * vertsPerPrimitive;

        gl_MeshVerticesEXT[firstVert + 0].gl_Position = vec4(xCenter           , yCenter - verDelta, 0.0, 1.0);
        gl_MeshVerticesEXT[firstVert + 1].gl_Position = vec4(xCenter - horDelta, yCenter + verDelta, 0.0, 1.0);
        gl_MeshVerticesEXT[firstVert + 2].gl_Position = vec4(xCenter + horDelta, yCenter + verDelta, 0.0, 1.0);
        gl_PrimitiveTriangleIndicesEXT[col] = uvec3(firstVert, firstVert + 1, firstVert + 2);
    }
}
