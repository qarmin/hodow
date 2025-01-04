#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=128, local_size_y=1, local_size_z=1) in;
layout (constant_id=0) const uint payloadElements = 1u;
layout (constant_id=1) const uint sharedMemoryElements = 1u;
layout (set=0, binding=0, std430) buffer ResultBlock {
    uint sharedOK;
    uint payloadOK;
} result;
struct TaskData {
    uint elements[payloadElements];
};
taskPayloadSharedEXT TaskData td;

void main () {
    if (gl_LocalInvocationIndex == 0u) {
        result.sharedOK = 1u;
    }
    const uint payloadElementsPerInvocation = uint(ceil(float(payloadElements) / float(128)));
    for (uint i = 0u; i < payloadElementsPerInvocation; ++i) {
        const uint elemIdx = payloadElementsPerInvocation * gl_LocalInvocationIndex + i;
        if (elemIdx < payloadElements) {
            td.elements[elemIdx] = elemIdx + 2000u;
        }
    }

    EmitMeshTasksEXT(1u, 1u, 1u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;
layout (triangles) out;
layout (max_vertices=3, max_primitives=1) out;
layout (constant_id=0) const uint payloadElements = 1u;
layout (constant_id=1) const uint sharedMemoryElements = 1u;
layout (set=0, binding=0, std430) buffer ResultBlock {
    uint sharedOK;
    uint payloadOK;
} result;
struct TaskData {
    uint elements[payloadElements];
};
taskPayloadSharedEXT TaskData td;

void main () {
    bool allOK = true;
    for (uint i = 0u; i < payloadElements; ++i) {
        if (td.elements[i] != i + 2000u) {
            allOK = false;
            break;
        }
    }
    result.payloadOK = (allOK ? 1u : 0u);

    SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=128, local_size_y=1, local_size_z=1) in;
layout (constant_id=0) const uint payloadElements = 1u;
layout (constant_id=1) const uint sharedMemoryElements = 1u;
layout (set=0, binding=0, std430) buffer ResultBlock {
    uint sharedOK;
    uint payloadOK;
} result;
shared uint sharedElements[sharedMemoryElements];

void main () {
    const uint shMemElementsPerInvocation = uint(ceil(float(sharedMemoryElements) / float(128)));
    for (uint i = 0u; i < shMemElementsPerInvocation; ++i) {
        const uint elemIdx = shMemElementsPerInvocation * gl_LocalInvocationIndex + i;
        if (elemIdx < sharedMemoryElements) {
            sharedElements[elemIdx] = elemIdx * 2u + 1000u;
        }
    }
    memoryBarrierShared();
    barrier();
    for (uint i = 0u; i < shMemElementsPerInvocation; ++i) {
        const uint elemIdx = shMemElementsPerInvocation * gl_LocalInvocationIndex + i;
        if (elemIdx < sharedMemoryElements) {
            const uint accessIdx = sharedMemoryElements - 1u - elemIdx;
            sharedElements[accessIdx] += accessIdx;
        }
    }
    memoryBarrierShared();
    barrier();
    if (gl_LocalInvocationIndex == 0u) {
        bool allOK = true;
        for (uint i = 0u; i < sharedMemoryElements; ++i) {
            if (sharedElements[i] != i*3u + 1000u) {
                allOK = false;
                break;
            }
        }
        result.sharedOK = (allOK ? 1u : 0u);
    }

    EmitMeshTasksEXT(1u, 1u, 1u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;
layout (triangles) out;
layout (max_vertices=3, max_primitives=1) out;
layout (constant_id=0) const uint payloadElements = 1u;
layout (constant_id=1) const uint sharedMemoryElements = 1u;
layout (set=0, binding=0, std430) buffer ResultBlock {
    uint sharedOK;
    uint payloadOK;
} result;

void main () {
    result.payloadOK = 1u;
    SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=128, local_size_y=1, local_size_z=1) in;
layout (constant_id=0) const uint payloadElements = 1u;
layout (constant_id=1) const uint sharedMemoryElements = 1u;
layout (set=0, binding=0, std430) buffer ResultBlock {
    uint sharedOK;
    uint payloadOK;
} result;
struct TaskData {
    uint elements[payloadElements];
};
taskPayloadSharedEXT TaskData td;
shared uint sharedElements[sharedMemoryElements];

void main () {
    const uint shMemElementsPerInvocation = uint(ceil(float(sharedMemoryElements) / float(128)));
    for (uint i = 0u; i < shMemElementsPerInvocation; ++i) {
        const uint elemIdx = shMemElementsPerInvocation * gl_LocalInvocationIndex + i;
        if (elemIdx < sharedMemoryElements) {
            sharedElements[elemIdx] = elemIdx * 2u + 1000u;
        }
    }
    memoryBarrierShared();
    barrier();
    for (uint i = 0u; i < shMemElementsPerInvocation; ++i) {
        const uint elemIdx = shMemElementsPerInvocation * gl_LocalInvocationIndex + i;
        if (elemIdx < sharedMemoryElements) {
            const uint accessIdx = sharedMemoryElements - 1u - elemIdx;
            sharedElements[accessIdx] += accessIdx;
        }
    }
    memoryBarrierShared();
    barrier();
    if (gl_LocalInvocationIndex == 0u) {
        bool allOK = true;
        for (uint i = 0u; i < sharedMemoryElements; ++i) {
            if (sharedElements[i] != i*3u + 1000u) {
                allOK = false;
                break;
            }
        }
        result.sharedOK = (allOK ? 1u : 0u);
    }

    const uint payloadElementsPerInvocation = uint(ceil(float(payloadElements) / float(128)));
    for (uint i = 0u; i < payloadElementsPerInvocation; ++i) {
        const uint elemIdx = payloadElementsPerInvocation * gl_LocalInvocationIndex + i;
        if (elemIdx < payloadElements) {
            td.elements[elemIdx] = elemIdx + 2000u;
        }
    }

    EmitMeshTasksEXT(1u, 1u, 1u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=128, local_size_y=1, local_size_z=1) in;
layout (constant_id=0) const uint payloadElements = 1u;
layout (constant_id=1) const uint sharedMemoryElements = 1u;
layout (set=0, binding=0, std430) buffer ResultBlock {
    uint sharedOK;
    uint payloadOK;
} result;
struct TaskData {
    uint elements[payloadElements];
};
taskPayloadSharedEXT TaskData td;

void main () {
    const uint payloadElementsPerInvocation = uint(ceil(float(payloadElements) / float(128)));
    for (uint i = 0u; i < payloadElementsPerInvocation; ++i) {
        const uint elemIdx = payloadElementsPerInvocation * gl_LocalInvocationIndex + i;
        if (elemIdx < payloadElements) {
            td.elements[elemIdx] = elemIdx + 2000u;
        }
    }

    EmitMeshTasksEXT(1u, 1u, 1u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=128, local_size_y=1, local_size_z=1) in;
layout (triangles) out;
layout (max_vertices=3, max_primitives=1) out;
layout (constant_id=0) const uint payloadElements = 1u;
layout (constant_id=1) const uint sharedMemoryElements = 1u;
layout (set=0, binding=0, std430) buffer ResultBlock {
    uint sharedOK;
    uint payloadOK;
} result;
struct TaskData {
    uint elements[payloadElements];
};
taskPayloadSharedEXT TaskData td;

void main () {
    if (gl_LocalInvocationIndex == 0u) {
        result.sharedOK = 1u;
    }
    if (gl_LocalInvocationIndex == 0u) {
        bool allOK = true;
        for (uint i = 0u; i < payloadElements; ++i) {
            if (td.elements[i] != i + 2000u) {
                allOK = false;
                break;
            }
        }
        result.payloadOK = (allOK ? 1u : 0u);
    }

    SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=128, local_size_y=1, local_size_z=1) in;
layout (triangles) out;
layout (max_vertices=3, max_primitives=1) out;
layout (constant_id=0) const uint payloadElements = 1u;
layout (constant_id=1) const uint sharedMemoryElements = 1u;
layout (set=0, binding=0, std430) buffer ResultBlock {
    uint sharedOK;
    uint payloadOK;
} result;
shared uint sharedElements[sharedMemoryElements];

void main () {
    const uint shMemElementsPerInvocation = uint(ceil(float(sharedMemoryElements) / float(128)));
    for (uint i = 0u; i < shMemElementsPerInvocation; ++i) {
        const uint elemIdx = shMemElementsPerInvocation * gl_LocalInvocationIndex + i;
        if (elemIdx < sharedMemoryElements) {
            sharedElements[elemIdx] = elemIdx * 2u + 1000u;
        }
    }
    memoryBarrierShared();
    barrier();
    for (uint i = 0u; i < shMemElementsPerInvocation; ++i) {
        const uint elemIdx = shMemElementsPerInvocation * gl_LocalInvocationIndex + i;
        if (elemIdx < sharedMemoryElements) {
            const uint accessIdx = sharedMemoryElements - 1u - elemIdx;
            sharedElements[accessIdx] += accessIdx;
        }
    }
    memoryBarrierShared();
    barrier();
    if (gl_LocalInvocationIndex == 0u) {
        bool allOK = true;
        for (uint i = 0u; i < sharedMemoryElements; ++i) {
            if (sharedElements[i] != i*3u + 1000u) {
                allOK = false;
                break;
            }
        }
        result.sharedOK = (allOK ? 1u : 0u);
    }

    result.payloadOK = 1u;
    SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=128, local_size_y=1, local_size_z=1) in;
layout (triangles) out;
layout (max_vertices=3, max_primitives=1) out;
layout (constant_id=0) const uint payloadElements = 1u;
layout (constant_id=1) const uint sharedMemoryElements = 1u;
layout (set=0, binding=0, std430) buffer ResultBlock {
    uint sharedOK;
    uint payloadOK;
} result;
struct TaskData {
    uint elements[payloadElements];
};
taskPayloadSharedEXT TaskData td;
shared uint sharedElements[sharedMemoryElements];

void main () {
    const uint shMemElementsPerInvocation = uint(ceil(float(sharedMemoryElements) / float(128)));
    for (uint i = 0u; i < shMemElementsPerInvocation; ++i) {
        const uint elemIdx = shMemElementsPerInvocation * gl_LocalInvocationIndex + i;
        if (elemIdx < sharedMemoryElements) {
            sharedElements[elemIdx] = elemIdx * 2u + 1000u;
        }
    }
    memoryBarrierShared();
    barrier();
    for (uint i = 0u; i < shMemElementsPerInvocation; ++i) {
        const uint elemIdx = shMemElementsPerInvocation * gl_LocalInvocationIndex + i;
        if (elemIdx < sharedMemoryElements) {
            const uint accessIdx = sharedMemoryElements - 1u - elemIdx;
            sharedElements[accessIdx] += accessIdx;
        }
    }
    memoryBarrierShared();
    barrier();
    if (gl_LocalInvocationIndex == 0u) {
        bool allOK = true;
        for (uint i = 0u; i < sharedMemoryElements; ++i) {
            if (sharedElements[i] != i*3u + 1000u) {
                allOK = false;
                break;
            }
        }
        result.sharedOK = (allOK ? 1u : 0u);
    }

    if (gl_LocalInvocationIndex == 0u) {
        bool allOK = true;
        for (uint i = 0u; i < payloadElements; ++i) {
            if (td.elements[i] != i + 2000u) {
                allOK = false;
                break;
            }
        }
        result.payloadOK = (allOK ? 1u : 0u);
    }

    SetMeshOutputsEXT(0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;
layout (triangles) out;
layout (max_vertices=3, max_primitives=1) out;

void main (void) {
    SetMeshOutputsEXT(3u, 1u);

    gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
    gl_MeshVerticesEXT[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0u, 1u, 2u);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_multiview : enable

layout (location=0) out uvec4 outColor;

void main (void) {
    outColor = uvec4(uint(gl_ViewIndex) + 1u, 0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;
layout (triangles) out;
layout (max_vertices=3, max_primitives=1) out;

void main (void) {
    SetMeshOutputsEXT(3u, 1u);

    gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
    gl_MeshVerticesEXT[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);

    gl_MeshPrimitivesEXT[0].gl_Layer = int(gl_WorkGroupID.x);
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0u, 1u, 2u);
}
#version 450

layout (location=0) out uvec4 outColor;

void main (void) {
    outColor = uvec4(uint(gl_Layer) + 1u, 0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=128, local_size_y=1, local_size_z=1) in;
layout (points) out;
layout (max_vertices=1, max_primitives=256) out;

out gl_MeshPerVertexEXT {
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

perprimitiveEXT out gl_MeshPerPrimitiveEXT {
    int gl_PrimitiveID;
} gl_MeshPrimitivesEXT[];

void main (void) {
    const uint localInvs = 128u;
    const uint maxVertices = 1u;
    const uint maxPoints = 256u;
    const uint verticesPerInvocation = (maxVertices + localInvs - 1u) / localInvs;
    const uint primitivesPerInvocation = (maxPoints + localInvs - 1u) / localInvs;

    SetMeshOutputsEXT(maxVertices, maxPoints);

    for (uint i = 0u; i < verticesPerInvocation; ++i) {
        const uint vertexID = gl_LocalInvocationIndex * verticesPerInvocation + i;
        if (vertexID >= maxVertices) {
            break;
        }
        const float xCoord = 0.0;
        gl_MeshVerticesEXT[vertexID].gl_Position = vec4(xCoord, 0.0, 0.0, 1.0);
        gl_MeshVerticesEXT[vertexID].gl_PointSize = 1.0f;
    }

    for (uint i = 0u; i < primitivesPerInvocation; ++i) {
        const uint primitiveID = gl_LocalInvocationIndex * primitivesPerInvocation + i;
        if (primitiveID >= maxPoints) {
            break;
        }
        gl_MeshPrimitivesEXT[primitiveID].gl_PrimitiveID = int(primitiveID);
        gl_PrimitivePointIndicesEXT[primitiveID] = 0u;
    }
}
#version 450

layout (set=0, binding=0, std430) buffer OutputBlock {
    uint flags[];
} ssbo;

void main (void) {
    ssbo.flags[gl_PrimitiveID] = 1u;
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=128, local_size_y=1, local_size_z=1) in;
layout (points) out;
layout (max_vertices=1, max_primitives=512) out;

out gl_MeshPerVertexEXT {
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

perprimitiveEXT out gl_MeshPerPrimitiveEXT {
    int gl_PrimitiveID;
} gl_MeshPrimitivesEXT[];

void main (void) {
    const uint localInvs = 128u;
    const uint maxVertices = 1u;
    const uint maxPoints = 512u;
    const uint verticesPerInvocation = (maxVertices + localInvs - 1u) / localInvs;
    const uint primitivesPerInvocation = (maxPoints + localInvs - 1u) / localInvs;

    SetMeshOutputsEXT(maxVertices, maxPoints);

    for (uint i = 0u; i < verticesPerInvocation; ++i) {
        const uint vertexID = gl_LocalInvocationIndex * verticesPerInvocation + i;
        if (vertexID >= maxVertices) {
            break;
        }
        const float xCoord = 0.0;
        gl_MeshVerticesEXT[vertexID].gl_Position = vec4(xCoord, 0.0, 0.0, 1.0);
        gl_MeshVerticesEXT[vertexID].gl_PointSize = 1.0f;
    }

    for (uint i = 0u; i < primitivesPerInvocation; ++i) {
        const uint primitiveID = gl_LocalInvocationIndex * primitivesPerInvocation + i;
        if (primitiveID >= maxPoints) {
            break;
        }
        gl_MeshPrimitivesEXT[primitiveID].gl_PrimitiveID = int(primitiveID);
        gl_PrimitivePointIndicesEXT[primitiveID] = 0u;
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=128, local_size_y=1, local_size_z=1) in;
layout (points) out;
layout (max_vertices=1, max_primitives=1024) out;

out gl_MeshPerVertexEXT {
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

perprimitiveEXT out gl_MeshPerPrimitiveEXT {
    int gl_PrimitiveID;
} gl_MeshPrimitivesEXT[];

void main (void) {
    const uint localInvs = 128u;
    const uint maxVertices = 1u;
    const uint maxPoints = 1024u;
    const uint verticesPerInvocation = (maxVertices + localInvs - 1u) / localInvs;
    const uint primitivesPerInvocation = (maxPoints + localInvs - 1u) / localInvs;

    SetMeshOutputsEXT(maxVertices, maxPoints);

    for (uint i = 0u; i < verticesPerInvocation; ++i) {
        const uint vertexID = gl_LocalInvocationIndex * verticesPerInvocation + i;
        if (vertexID >= maxVertices) {
            break;
        }
        const float xCoord = 0.0;
        gl_MeshVerticesEXT[vertexID].gl_Position = vec4(xCoord, 0.0, 0.0, 1.0);
        gl_MeshVerticesEXT[vertexID].gl_PointSize = 1.0f;
    }

    for (uint i = 0u; i < primitivesPerInvocation; ++i) {
        const uint primitiveID = gl_LocalInvocationIndex * primitivesPerInvocation + i;
        if (primitiveID >= maxPoints) {
            break;
        }
        gl_MeshPrimitivesEXT[primitiveID].gl_PrimitiveID = int(primitiveID);
        gl_PrimitivePointIndicesEXT[primitiveID] = 0u;
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=128, local_size_y=1, local_size_z=1) in;
layout (points) out;
layout (max_vertices=1, max_primitives=2048) out;

out gl_MeshPerVertexEXT {
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

perprimitiveEXT out gl_MeshPerPrimitiveEXT {
    int gl_PrimitiveID;
} gl_MeshPrimitivesEXT[];

void main (void) {
    const uint localInvs = 128u;
    const uint maxVertices = 1u;
    const uint maxPoints = 2048u;
    const uint verticesPerInvocation = (maxVertices + localInvs - 1u) / localInvs;
    const uint primitivesPerInvocation = (maxPoints + localInvs - 1u) / localInvs;

    SetMeshOutputsEXT(maxVertices, maxPoints);

    for (uint i = 0u; i < verticesPerInvocation; ++i) {
        const uint vertexID = gl_LocalInvocationIndex * verticesPerInvocation + i;
        if (vertexID >= maxVertices) {
            break;
        }
        const float xCoord = 0.0;
        gl_MeshVerticesEXT[vertexID].gl_Position = vec4(xCoord, 0.0, 0.0, 1.0);
        gl_MeshVerticesEXT[vertexID].gl_PointSize = 1.0f;
    }

    for (uint i = 0u; i < primitivesPerInvocation; ++i) {
        const uint primitiveID = gl_LocalInvocationIndex * primitivesPerInvocation + i;
        if (primitiveID >= maxPoints) {
            break;
        }
        gl_MeshPrimitivesEXT[primitiveID].gl_PrimitiveID = int(primitiveID);
        gl_PrimitivePointIndicesEXT[primitiveID] = 0u;
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=128, local_size_y=1, local_size_z=1) in;
layout (points) out;
layout (max_vertices=256, max_primitives=256) out;

out gl_MeshPerVertexEXT {
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main (void) {
    const uint localInvs = 128u;
    const uint maxVertices = 256u;
    const uint maxPoints = 256u;
    const uint verticesPerInvocation = (maxVertices + localInvs - 1u) / localInvs;
    const uint primitivesPerInvocation = (maxPoints + localInvs - 1u) / localInvs;

    SetMeshOutputsEXT(maxVertices, maxPoints);

    for (uint i = 0u; i < verticesPerInvocation; ++i) {
        const uint vertexID = gl_LocalInvocationIndex * verticesPerInvocation + i;
        if (vertexID >= maxVertices) {
            break;
        }
        const float xCoord = (float(vertexID) + 0.5) / float(maxVertices) * 2.0 - 1.0;
        gl_MeshVerticesEXT[vertexID].gl_Position = vec4(xCoord, 0.0, 0.0, 1.0);
        gl_MeshVerticesEXT[vertexID].gl_PointSize = 1.0f;
    }

    for (uint i = 0u; i < primitivesPerInvocation; ++i) {
        const uint primitiveID = gl_LocalInvocationIndex * primitivesPerInvocation + i;
        if (primitiveID >= maxPoints) {
            break;
        }
        gl_PrimitivePointIndicesEXT[primitiveID] = primitiveID;
    }
}
#version 450

layout (set=0, binding=0, std430) buffer OutputBlock {
    uint flags[];
} ssbo;

void main (void) {
    ssbo.flags[uint(gl_FragCoord.x)] = 1u;
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=128, local_size_y=1, local_size_z=1) in;
layout (points) out;
layout (max_vertices=512, max_primitives=512) out;

out gl_MeshPerVertexEXT {
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main (void) {
    const uint localInvs = 128u;
    const uint maxVertices = 512u;
    const uint maxPoints = 512u;
    const uint verticesPerInvocation = (maxVertices + localInvs - 1u) / localInvs;
    const uint primitivesPerInvocation = (maxPoints + localInvs - 1u) / localInvs;

    SetMeshOutputsEXT(maxVertices, maxPoints);

    for (uint i = 0u; i < verticesPerInvocation; ++i) {
        const uint vertexID = gl_LocalInvocationIndex * verticesPerInvocation + i;
        if (vertexID >= maxVertices) {
            break;
        }
        const float xCoord = (float(vertexID) + 0.5) / float(maxVertices) * 2.0 - 1.0;
        gl_MeshVerticesEXT[vertexID].gl_Position = vec4(xCoord, 0.0, 0.0, 1.0);
        gl_MeshVerticesEXT[vertexID].gl_PointSize = 1.0f;
    }

    for (uint i = 0u; i < primitivesPerInvocation; ++i) {
        const uint primitiveID = gl_LocalInvocationIndex * primitivesPerInvocation + i;
        if (primitiveID >= maxPoints) {
            break;
        }
        gl_PrimitivePointIndicesEXT[primitiveID] = primitiveID;
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=128, local_size_y=1, local_size_z=1) in;
layout (points) out;
layout (max_vertices=1024, max_primitives=1024) out;

out gl_MeshPerVertexEXT {
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main (void) {
    const uint localInvs = 128u;
    const uint maxVertices = 1024u;
    const uint maxPoints = 1024u;
    const uint verticesPerInvocation = (maxVertices + localInvs - 1u) / localInvs;
    const uint primitivesPerInvocation = (maxPoints + localInvs - 1u) / localInvs;

    SetMeshOutputsEXT(maxVertices, maxPoints);

    for (uint i = 0u; i < verticesPerInvocation; ++i) {
        const uint vertexID = gl_LocalInvocationIndex * verticesPerInvocation + i;
        if (vertexID >= maxVertices) {
            break;
        }
        const float xCoord = (float(vertexID) + 0.5) / float(maxVertices) * 2.0 - 1.0;
        gl_MeshVerticesEXT[vertexID].gl_Position = vec4(xCoord, 0.0, 0.0, 1.0);
        gl_MeshVerticesEXT[vertexID].gl_PointSize = 1.0f;
    }

    for (uint i = 0u; i < primitivesPerInvocation; ++i) {
        const uint primitiveID = gl_LocalInvocationIndex * primitivesPerInvocation + i;
        if (primitiveID >= maxPoints) {
            break;
        }
        gl_PrimitivePointIndicesEXT[primitiveID] = primitiveID;
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=128, local_size_y=1, local_size_z=1) in;
layout (points) out;
layout (max_vertices=2048, max_primitives=2048) out;

out gl_MeshPerVertexEXT {
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main (void) {
    const uint localInvs = 128u;
    const uint maxVertices = 2048u;
    const uint maxPoints = 2048u;
    const uint verticesPerInvocation = (maxVertices + localInvs - 1u) / localInvs;
    const uint primitivesPerInvocation = (maxPoints + localInvs - 1u) / localInvs;

    SetMeshOutputsEXT(maxVertices, maxPoints);

    for (uint i = 0u; i < verticesPerInvocation; ++i) {
        const uint vertexID = gl_LocalInvocationIndex * verticesPerInvocation + i;
        if (vertexID >= maxVertices) {
            break;
        }
        const float xCoord = (float(vertexID) + 0.5) / float(maxVertices) * 2.0 - 1.0;
        gl_MeshVerticesEXT[vertexID].gl_Position = vec4(xCoord, 0.0, 0.0, 1.0);
        gl_MeshVerticesEXT[vertexID].gl_PointSize = 1.0f;
    }

    for (uint i = 0u; i < primitivesPerInvocation; ++i) {
        const uint primitiveID = gl_LocalInvocationIndex * primitivesPerInvocation + i;
        if (primitiveID >= maxPoints) {
            break;
        }
        gl_PrimitivePointIndicesEXT[primitiveID] = primitiveID;
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;
layout (triangles) out;
layout (max_vertices=3, max_primitives=1) out;

out gl_MeshPerVertexEXT {
    vec4  gl_Position;
} gl_MeshVerticesEXT[];

layout (constant_id=0) const uint maxLocations = 1u;
struct LocationStruct {
    uvec4 location_var[maxLocations];
};
layout (location=0) perprimitiveEXT flat out LocationStruct ls[];

void main (void) {
    SetMeshOutputsEXT(3u, 1u);
    gl_MeshVerticesEXT[0].gl_Position = vec4( 0.0, -0.5, 0.0, 1.0);
    gl_MeshVerticesEXT[1].gl_Position = vec4(-0.5,  0.5, 0.0, 1.0);
    gl_MeshVerticesEXT[2].gl_Position = vec4( 0.5,  0.5, 0.0, 1.0);
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0u, 1u, 2u);

    for (uint i = 0u; i < maxLocations; ++i) {
        const uint baseVal = 10000u * (i + 1u);
        const uvec4 expectedValue = uvec4(baseVal + 1u, baseVal + 2u, baseVal + 3u, baseVal + 4u);
        ls[0].location_var[i] = expectedValue;
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (location=0) out vec4 outColor;

layout (constant_id=0) const uint maxLocations = 1u;
struct LocationStruct {
    uvec4 location_var[maxLocations];
};
layout (location=0) perprimitiveEXT flat in LocationStruct ls;

void main (void) {
    bool success = true;
    for (uint i = 0u; i < maxLocations; ++i) {
        const uint baseVal = 10000u * (i + 1u);
        const uvec4 expectedValue = uvec4(baseVal + 1u, baseVal + 2u, baseVal + 3u, baseVal + 4u);
        success = success && (ls.location_var[i] == expectedValue);
    }
    outColor = (success ? vec4(0.0, 0.0, 1.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0));
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;
layout (points) out;
layout (max_vertices=96, max_primitives=96) out;

out gl_MeshPerVertexEXT {
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

layout (constant_id=0) const uint payloadElements = 1u;
layout (constant_id=1) const uint locationCount = 1u;

struct LocationBlock {
    uvec4 elements[locationCount];
};
layout (location=0) out perprimitiveEXT LocationBlock loc[];

void main (void) {
    bool payloadOK = true;

    SetMeshOutputsEXT(96, 96);
    const uint payloadOffset = (payloadOK ? 10u : 0u);
    const uint compOffset = 0u;
    for (uint pointIdx = 0u; pointIdx < 96; ++pointIdx) {
        const float xCoord = ((float(pointIdx) + 0.5) / float(96)) * 2.0 - 1.0;
        gl_MeshVerticesEXT[pointIdx].gl_Position = vec4(xCoord, 0.0, 0.0, 1.0);
        gl_MeshVerticesEXT[pointIdx].gl_PointSize = 1.0f;
        gl_PrimitivePointIndicesEXT[pointIdx] = pointIdx;
        for (uint elemIdx = 0; elemIdx < locationCount; ++elemIdx) {
            const uint baseVal = 200000000u + 100000u * pointIdx + 1000u * elemIdx + payloadOffset;
            loc[pointIdx].elements[elemIdx] = uvec4(baseVal + 1u + compOffset, baseVal + 2u + compOffset, baseVal + 3u + compOffset, baseVal + 4u + compOffset);
        }
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (location=0) out vec4 outColor;
layout (constant_id=0) const uint payloadElements = 1u;
layout (constant_id=1) const uint locationCount = 1u;
struct LocationBlock {
    uvec4 elements[locationCount];
};
layout (location=0) in flat perprimitiveEXT LocationBlock loc;

void main (void) {
    bool pointOK = true;
    const uint pointIdx = uint(gl_FragCoord.x);
    const uint expectedPayloadOffset = 10u;
    const uint compOffset = 0u;
    for (uint elemIdx = 0; elemIdx < locationCount; ++elemIdx) {
        const uint baseVal = 200000000u + 100000u * pointIdx + 1000u * elemIdx + expectedPayloadOffset;
        const uvec4 expectedVal = uvec4(baseVal + 1u + compOffset, baseVal + 2u + compOffset, baseVal + 3u + compOffset, baseVal + 4u + compOffset);
        if (loc.elements[elemIdx] != expectedVal) {
            pointOK = false;
            break;
        }
    }
    const vec4 okColor = vec4(0.0, 0.0, 1.0, 1.0);
    const vec4 failColor = vec4(0.0, 0.0, 0.0, 1.0);
    outColor = (pointOK ? okColor : failColor);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_multiview : enable

layout (location=0) out vec4 outColor;
layout (constant_id=0) const uint payloadElements = 1u;
layout (constant_id=1) const uint locationCount = 1u;
struct LocationBlock {
    uvec4 elements[locationCount];
};
layout (location=0) in flat perprimitiveEXT LocationBlock loc;

void main (void) {
    bool pointOK = true;
    const uint pointIdx = uint(gl_FragCoord.x);
    const uint expectedPayloadOffset = 10u;
    const uint compOffset = 0u;
    for (uint elemIdx = 0; elemIdx < locationCount; ++elemIdx) {
        const uint baseVal = 200000000u + 100000u * pointIdx + 1000u * elemIdx + expectedPayloadOffset;
        const uvec4 expectedVal = uvec4(baseVal + 1u + compOffset, baseVal + 2u + compOffset, baseVal + 3u + compOffset, baseVal + 4u + compOffset);
        if (loc.elements[elemIdx] != expectedVal) {
            pointOK = false;
            break;
        }
    }
    const vec4 okColor = vec4(0.0, 0.0, 1.0, 1.0);
    const vec4 failColor = vec4(0.0, 0.0, 0.0, 1.0);
    outColor = (pointOK ? okColor : failColor);
    outColor.r += float(gl_ViewIndex);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_multiview : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;
layout (points) out;
layout (max_vertices=96, max_primitives=96) out;

out gl_MeshPerVertexEXT {
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

layout (constant_id=0) const uint payloadElements = 1u;
layout (constant_id=1) const uint locationCount = 1u;

struct LocationBlock {
    uvec4 elements[locationCount];
};
layout (location=0) out perprimitiveEXT LocationBlock loc[];

void main (void) {
    bool payloadOK = true;

    SetMeshOutputsEXT(96, 96);
    const uint payloadOffset = (payloadOK ? 10u : 0u);
    const uint compOffset = (4u * uint(gl_ViewIndex));
    for (uint pointIdx = 0u; pointIdx < 96; ++pointIdx) {
        const float xCoord = ((float(pointIdx) + 0.5) / float(96)) * 2.0 - 1.0;
        gl_MeshVerticesEXT[pointIdx].gl_Position = vec4(xCoord, 0.0, 0.0, 1.0);
        gl_MeshVerticesEXT[pointIdx].gl_PointSize = 1.0f;
        gl_PrimitivePointIndicesEXT[pointIdx] = pointIdx;
        for (uint elemIdx = 0; elemIdx < locationCount; ++elemIdx) {
            const uint baseVal = 200000000u + 100000u * pointIdx + 1000u * elemIdx + payloadOffset;
            loc[pointIdx].elements[elemIdx] = uvec4(baseVal + 1u + compOffset, baseVal + 2u + compOffset, baseVal + 3u + compOffset, baseVal + 4u + compOffset);
        }
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_multiview : enable

layout (location=0) out vec4 outColor;
layout (constant_id=0) const uint payloadElements = 1u;
layout (constant_id=1) const uint locationCount = 1u;
struct LocationBlock {
    uvec4 elements[locationCount];
};
layout (location=0) in flat perprimitiveEXT LocationBlock loc;

void main (void) {
    bool pointOK = true;
    const uint pointIdx = uint(gl_FragCoord.x);
    const uint expectedPayloadOffset = 10u;
    const uint compOffset = (4u * uint(gl_ViewIndex));
    for (uint elemIdx = 0; elemIdx < locationCount; ++elemIdx) {
        const uint baseVal = 200000000u + 100000u * pointIdx + 1000u * elemIdx + expectedPayloadOffset;
        const uvec4 expectedVal = uvec4(baseVal + 1u + compOffset, baseVal + 2u + compOffset, baseVal + 3u + compOffset, baseVal + 4u + compOffset);
        if (loc.elements[elemIdx] != expectedVal) {
            pointOK = false;
            break;
        }
    }
    const vec4 okColor = vec4(0.0, 0.0, 1.0, 1.0);
    const vec4 failColor = vec4(0.0, 0.0, 0.0, 1.0);
    outColor = (pointOK ? okColor : failColor);
    outColor.r += float(gl_ViewIndex);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;
layout (points) out;
layout (max_vertices=96, max_primitives=96) out;

out gl_MeshPerVertexEXT {
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

layout (constant_id=0) const uint payloadElements = 1u;
layout (constant_id=1) const uint locationCount = 1u;

struct LocationBlock {
    uvec4 elements[locationCount];
};
layout (location=0) out  LocationBlock loc[];

void main (void) {
    bool payloadOK = true;

    SetMeshOutputsEXT(96, 96);
    const uint payloadOffset = (payloadOK ? 10u : 0u);
    const uint compOffset = 0u;
    for (uint pointIdx = 0u; pointIdx < 96; ++pointIdx) {
        const float xCoord = ((float(pointIdx) + 0.5) / float(96)) * 2.0 - 1.0;
        gl_MeshVerticesEXT[pointIdx].gl_Position = vec4(xCoord, 0.0, 0.0, 1.0);
        gl_MeshVerticesEXT[pointIdx].gl_PointSize = 1.0f;
        gl_PrimitivePointIndicesEXT[pointIdx] = pointIdx;
        for (uint elemIdx = 0; elemIdx < locationCount; ++elemIdx) {
            const uint baseVal = 200000000u + 100000u * pointIdx + 1000u * elemIdx + payloadOffset;
            loc[pointIdx].elements[elemIdx] = uvec4(baseVal + 1u + compOffset, baseVal + 2u + compOffset, baseVal + 3u + compOffset, baseVal + 4u + compOffset);
        }
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (location=0) out vec4 outColor;
layout (constant_id=0) const uint payloadElements = 1u;
layout (constant_id=1) const uint locationCount = 1u;
struct LocationBlock {
    uvec4 elements[locationCount];
};
layout (location=0) in flat  LocationBlock loc;

void main (void) {
    bool pointOK = true;
    const uint pointIdx = uint(gl_FragCoord.x);
    const uint expectedPayloadOffset = 10u;
    const uint compOffset = 0u;
    for (uint elemIdx = 0; elemIdx < locationCount; ++elemIdx) {
        const uint baseVal = 200000000u + 100000u * pointIdx + 1000u * elemIdx + expectedPayloadOffset;
        const uvec4 expectedVal = uvec4(baseVal + 1u + compOffset, baseVal + 2u + compOffset, baseVal + 3u + compOffset, baseVal + 4u + compOffset);
        if (loc.elements[elemIdx] != expectedVal) {
            pointOK = false;
            break;
        }
    }
    const vec4 okColor = vec4(0.0, 0.0, 1.0, 1.0);
    const vec4 failColor = vec4(0.0, 0.0, 0.0, 1.0);
    outColor = (pointOK ? okColor : failColor);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_multiview : enable

layout (location=0) out vec4 outColor;
layout (constant_id=0) const uint payloadElements = 1u;
layout (constant_id=1) const uint locationCount = 1u;
struct LocationBlock {
    uvec4 elements[locationCount];
};
layout (location=0) in flat  LocationBlock loc;

void main (void) {
    bool pointOK = true;
    const uint pointIdx = uint(gl_FragCoord.x);
    const uint expectedPayloadOffset = 10u;
    const uint compOffset = 0u;
    for (uint elemIdx = 0; elemIdx < locationCount; ++elemIdx) {
        const uint baseVal = 200000000u + 100000u * pointIdx + 1000u * elemIdx + expectedPayloadOffset;
        const uvec4 expectedVal = uvec4(baseVal + 1u + compOffset, baseVal + 2u + compOffset, baseVal + 3u + compOffset, baseVal + 4u + compOffset);
        if (loc.elements[elemIdx] != expectedVal) {
            pointOK = false;
            break;
        }
    }
    const vec4 okColor = vec4(0.0, 0.0, 1.0, 1.0);
    const vec4 failColor = vec4(0.0, 0.0, 0.0, 1.0);
    outColor = (pointOK ? okColor : failColor);
    outColor.r += float(gl_ViewIndex);
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_multiview : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;
layout (points) out;
layout (max_vertices=96, max_primitives=96) out;

out gl_MeshPerVertexEXT {
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

layout (constant_id=0) const uint payloadElements = 1u;
layout (constant_id=1) const uint locationCount = 1u;

struct LocationBlock {
    uvec4 elements[locationCount];
};
layout (location=0) out  LocationBlock loc[];

void main (void) {
    bool payloadOK = true;

    SetMeshOutputsEXT(96, 96);
    const uint payloadOffset = (payloadOK ? 10u : 0u);
    const uint compOffset = (4u * uint(gl_ViewIndex));
    for (uint pointIdx = 0u; pointIdx < 96; ++pointIdx) {
        const float xCoord = ((float(pointIdx) + 0.5) / float(96)) * 2.0 - 1.0;
        gl_MeshVerticesEXT[pointIdx].gl_Position = vec4(xCoord, 0.0, 0.0, 1.0);
        gl_MeshVerticesEXT[pointIdx].gl_PointSize = 1.0f;
        gl_PrimitivePointIndicesEXT[pointIdx] = pointIdx;
        for (uint elemIdx = 0; elemIdx < locationCount; ++elemIdx) {
            const uint baseVal = 200000000u + 100000u * pointIdx + 1000u * elemIdx + payloadOffset;
            loc[pointIdx].elements[elemIdx] = uvec4(baseVal + 1u + compOffset, baseVal + 2u + compOffset, baseVal + 3u + compOffset, baseVal + 4u + compOffset);
        }
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_multiview : enable

layout (location=0) out vec4 outColor;
layout (constant_id=0) const uint payloadElements = 1u;
layout (constant_id=1) const uint locationCount = 1u;
struct LocationBlock {
    uvec4 elements[locationCount];
};
layout (location=0) in flat  LocationBlock loc;

void main (void) {
    bool pointOK = true;
    const uint pointIdx = uint(gl_FragCoord.x);
    const uint expectedPayloadOffset = 10u;
    const uint compOffset = (4u * uint(gl_ViewIndex));
    for (uint elemIdx = 0; elemIdx < locationCount; ++elemIdx) {
        const uint baseVal = 200000000u + 100000u * pointIdx + 1000u * elemIdx + expectedPayloadOffset;
        const uvec4 expectedVal = uvec4(baseVal + 1u + compOffset, baseVal + 2u + compOffset, baseVal + 3u + compOffset, baseVal + 4u + compOffset);
        if (loc.elements[elemIdx] != expectedVal) {
            pointOK = false;
            break;
        }
    }
    const vec4 okColor = vec4(0.0, 0.0, 1.0, 1.0);
    const vec4 failColor = vec4(0.0, 0.0, 0.0, 1.0);
    outColor = (pointOK ? okColor : failColor);
    outColor.r += float(gl_ViewIndex);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;
layout (constant_id=0) const uint payloadElements = 1u;
layout (constant_id=1) const uint locationCount = 1u;
struct TaskData {
    uint elements[payloadElements];
};
taskPayloadSharedEXT TaskData td;

void main (void) {
    for (uint i = 0; i < payloadElements; ++i) {
        td.elements[i] = 1000000u + i;
    }
    EmitMeshTasksEXT(1u, 1u, 1u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;
layout (points) out;
layout (max_vertices=96, max_primitives=96) out;

out gl_MeshPerVertexEXT {
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

layout (constant_id=0) const uint payloadElements = 1u;
layout (constant_id=1) const uint locationCount = 1u;
struct TaskData {
    uint elements[payloadElements];
};
taskPayloadSharedEXT TaskData td;

struct LocationBlock {
    uvec4 elements[locationCount];
};
layout (location=0) out perprimitiveEXT LocationBlock loc[];

void main (void) {
    bool payloadOK = true;
    for (uint i = 0; i < payloadElements; ++i) {
        if (td.elements[i] != 1000000u + i) {
            payloadOK = false;
            break;
        }
    }

    SetMeshOutputsEXT(96, 96);
    const uint payloadOffset = (payloadOK ? 10u : 0u);
    const uint compOffset = 0u;
    for (uint pointIdx = 0u; pointIdx < 96; ++pointIdx) {
        const float xCoord = ((float(pointIdx) + 0.5) / float(96)) * 2.0 - 1.0;
        gl_MeshVerticesEXT[pointIdx].gl_Position = vec4(xCoord, 0.0, 0.0, 1.0);
        gl_MeshVerticesEXT[pointIdx].gl_PointSize = 1.0f;
        gl_PrimitivePointIndicesEXT[pointIdx] = pointIdx;
        for (uint elemIdx = 0; elemIdx < locationCount; ++elemIdx) {
            const uint baseVal = 200000000u + 100000u * pointIdx + 1000u * elemIdx + payloadOffset;
            loc[pointIdx].elements[elemIdx] = uvec4(baseVal + 1u + compOffset, baseVal + 2u + compOffset, baseVal + 3u + compOffset, baseVal + 4u + compOffset);
        }
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_multiview : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;
layout (points) out;
layout (max_vertices=96, max_primitives=96) out;

out gl_MeshPerVertexEXT {
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

layout (constant_id=0) const uint payloadElements = 1u;
layout (constant_id=1) const uint locationCount = 1u;
struct TaskData {
    uint elements[payloadElements];
};
taskPayloadSharedEXT TaskData td;

struct LocationBlock {
    uvec4 elements[locationCount];
};
layout (location=0) out perprimitiveEXT LocationBlock loc[];

void main (void) {
    bool payloadOK = true;
    for (uint i = 0; i < payloadElements; ++i) {
        if (td.elements[i] != 1000000u + i) {
            payloadOK = false;
            break;
        }
    }

    SetMeshOutputsEXT(96, 96);
    const uint payloadOffset = (payloadOK ? 10u : 0u);
    const uint compOffset = (4u * uint(gl_ViewIndex));
    for (uint pointIdx = 0u; pointIdx < 96; ++pointIdx) {
        const float xCoord = ((float(pointIdx) + 0.5) / float(96)) * 2.0 - 1.0;
        gl_MeshVerticesEXT[pointIdx].gl_Position = vec4(xCoord, 0.0, 0.0, 1.0);
        gl_MeshVerticesEXT[pointIdx].gl_PointSize = 1.0f;
        gl_PrimitivePointIndicesEXT[pointIdx] = pointIdx;
        for (uint elemIdx = 0; elemIdx < locationCount; ++elemIdx) {
            const uint baseVal = 200000000u + 100000u * pointIdx + 1000u * elemIdx + payloadOffset;
            loc[pointIdx].elements[elemIdx] = uvec4(baseVal + 1u + compOffset, baseVal + 2u + compOffset, baseVal + 3u + compOffset, baseVal + 4u + compOffset);
        }
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;
layout (points) out;
layout (max_vertices=96, max_primitives=96) out;

out gl_MeshPerVertexEXT {
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

layout (constant_id=0) const uint payloadElements = 1u;
layout (constant_id=1) const uint locationCount = 1u;
struct TaskData {
    uint elements[payloadElements];
};
taskPayloadSharedEXT TaskData td;

struct LocationBlock {
    uvec4 elements[locationCount];
};
layout (location=0) out  LocationBlock loc[];

void main (void) {
    bool payloadOK = true;
    for (uint i = 0; i < payloadElements; ++i) {
        if (td.elements[i] != 1000000u + i) {
            payloadOK = false;
            break;
        }
    }

    SetMeshOutputsEXT(96, 96);
    const uint payloadOffset = (payloadOK ? 10u : 0u);
    const uint compOffset = 0u;
    for (uint pointIdx = 0u; pointIdx < 96; ++pointIdx) {
        const float xCoord = ((float(pointIdx) + 0.5) / float(96)) * 2.0 - 1.0;
        gl_MeshVerticesEXT[pointIdx].gl_Position = vec4(xCoord, 0.0, 0.0, 1.0);
        gl_MeshVerticesEXT[pointIdx].gl_PointSize = 1.0f;
        gl_PrimitivePointIndicesEXT[pointIdx] = pointIdx;
        for (uint elemIdx = 0; elemIdx < locationCount; ++elemIdx) {
            const uint baseVal = 200000000u + 100000u * pointIdx + 1000u * elemIdx + payloadOffset;
            loc[pointIdx].elements[elemIdx] = uvec4(baseVal + 1u + compOffset, baseVal + 2u + compOffset, baseVal + 3u + compOffset, baseVal + 4u + compOffset);
        }
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_multiview : enable

layout (local_size_x=1, local_size_y=1, local_size_z=1) in;
layout (points) out;
layout (max_vertices=96, max_primitives=96) out;

out gl_MeshPerVertexEXT {
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

layout (constant_id=0) const uint payloadElements = 1u;
layout (constant_id=1) const uint locationCount = 1u;
struct TaskData {
    uint elements[payloadElements];
};
taskPayloadSharedEXT TaskData td;

struct LocationBlock {
    uvec4 elements[locationCount];
};
layout (location=0) out  LocationBlock loc[];

void main (void) {
    bool payloadOK = true;
    for (uint i = 0; i < payloadElements; ++i) {
        if (td.elements[i] != 1000000u + i) {
            payloadOK = false;
            break;
        }
    }

    SetMeshOutputsEXT(96, 96);
    const uint payloadOffset = (payloadOK ? 10u : 0u);
    const uint compOffset = (4u * uint(gl_ViewIndex));
    for (uint pointIdx = 0u; pointIdx < 96; ++pointIdx) {
        const float xCoord = ((float(pointIdx) + 0.5) / float(96)) * 2.0 - 1.0;
        gl_MeshVerticesEXT[pointIdx].gl_Position = vec4(xCoord, 0.0, 0.0, 1.0);
        gl_MeshVerticesEXT[pointIdx].gl_PointSize = 1.0f;
        gl_PrimitivePointIndicesEXT[pointIdx] = pointIdx;
        for (uint elemIdx = 0; elemIdx < locationCount; ++elemIdx) {
            const uint baseVal = 200000000u + 100000u * pointIdx + 1000u * elemIdx + payloadOffset;
            loc[pointIdx].elements[elemIdx] = uvec4(baseVal + 1u + compOffset, baseVal + 2u + compOffset, baseVal + 3u + compOffset, baseVal + 4u + compOffset);
        }
    }
}
