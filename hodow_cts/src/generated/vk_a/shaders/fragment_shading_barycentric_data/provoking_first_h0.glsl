#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out float data;
layout(location = 1) out float dataInterp;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = float(n);
    dataInterp    = float(n);
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 1) in float dataIntrp;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in float data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = w * y + x;
    const bool even = (p%2 == 0);

    float eA; { const int n = 1 + (p); eA = float(n); }
    float eB; { const int n = 1 + (p); eB = float(n); }
    float eC; { const int n = 1 + (p); eC = float(n); }

    float e[3] = { eA,eB,eC };
    float eIntrpV; {eIntrpV = float(eA * gl_BaryCoordEXT.x + eB * gl_BaryCoordEXT.y + eC * gl_BaryCoordEXT.z); }
    float eIntrp[3 / 3] = { eIntrpV };

    float vA; { vA = data[0]; }
    float vB; { vB = data[1]; }
    float vC; { vC = data[2]; }
    float vIntrpV; { vIntrpV = dataIntrp; }
    float vIntrp[3 / 3] = { vIntrpV };

    float v[3] = { vA,vB,vC };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<3 / 3; i++)
        if (abs(eIntrp[i] - vIntrp[i]) < 0.001)
            mask.y = mask.y | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(points) out;
layout(max_vertices=1, max_primitives = 1) out;
layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[64];
} pvd;
layout (location=0) out vec4 data[];
layout(location = 1) out vec4 dataInterp[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    SetMeshOutputsEXT(1u, 1u);
    const uint vertex = gl_LocalInvocationIndex;
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z + gl_NumWorkGroups.x * gl_WorkGroupID.y + gl_WorkGroupID.x;
    uint jobId = workGroupIndex + gl_LocalInvocationIndex;
    gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[jobId];
    gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
    gl_PrimitivePointIndicesEXT[vertex] = vertex;
    uint n  = jobId + 1;
    data[vertex] = vec4(float(n), float(2*n), float(4*n), float(8*n));
    dataInterp[vertex]    = vec4(float(n), float(2*n), float(4*n), float(8*n));
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 1) in vec4 dataIntrp;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec4 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = w * y + x;
    const bool even = (p%2 == 0);

    vec4 eA; { const int n = 1 + (p); eA = vec4(float(n), float(2*n), float(4*n), float(8*n)); }
    vec4 eB; { const int n = 1 + (p); eB = vec4(float(n), float(2*n), float(4*n), float(8*n)); }
    vec4 eC; { const int n = 1 + (p); eC = vec4(float(n), float(2*n), float(4*n), float(8*n)); }

    float e[12] = { eA.x,eA.y,eA.z,eA.w,eB.x,eB.y,eB.z,eB.w,eC.x,eC.y,eC.z,eC.w };
    vec4 eIntrpV; {eIntrpV = vec4(eA * gl_BaryCoordEXT.x + eB * gl_BaryCoordEXT.y + eC * gl_BaryCoordEXT.z); }
    float eIntrp[12 / 3] = { eIntrpV.x,eIntrpV.y,eIntrpV.z,eIntrpV.w };

    vec4 vA; { vA = data[0]; }
    vec4 vB; { vB = data[1]; }
    vec4 vC; { vC = data[2]; }
    vec4 vIntrpV; { vIntrpV = dataIntrp; }
    float vIntrp[12 / 3] = { vIntrpV.x,vIntrpV.y,vIntrpV.z,vIntrpV.w };

    float v[12] = { vA.x,vA.y,vA.z,vA.w,vB.x,vB.y,vB.z,vB.w,vC.x,vC.y,vC.z,vC.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<12 / 3; i++)
        if (abs(eIntrp[i] - vIntrp[i]) < 0.001)
            mask.y = mask.y | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(points) out;
layout(max_vertices=1, max_primitives = 1) out;
layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[64];
} pvd;
layout (location=0) out dvec2 data[];
layout(location = 2) out dvec2 dataFlat[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    SetMeshOutputsEXT(1u, 1u);
    const uint vertex = gl_LocalInvocationIndex;
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z + gl_NumWorkGroups.x * gl_WorkGroupID.y + gl_WorkGroupID.x;
    uint jobId = workGroupIndex + gl_LocalInvocationIndex;
    gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[jobId];
    gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
    gl_PrimitivePointIndicesEXT[vertex] = vertex;
    uint n  = jobId + 1;
    data[vertex] = dvec2(double(n), double(2*n));
    dataFlat[vertex]      = dvec2(double(n), double(2*n));
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 2) flat in dvec2 dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec2 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = w * y + x;
    const bool even = (p%2 == 0);

    dvec2 eA; { const int n = 1 + (p); eA = dvec2(double(n), double(2*n)); }
    dvec2 eB; { const int n = 1 + (p); eB = dvec2(double(n), double(2*n)); }
    dvec2 eC; { const int n = 1 + (p); eC = dvec2(double(n), double(2*n)); }

    double e[6] = { eA.x,eA.y,eB.x,eB.y,eC.x,eC.y };
    dvec2 eFlatV; { const int n = 1 + (p); eFlatV = dvec2(double(n), double(2*n)); }
    double eFlat[6 / 3] = { eFlatV.x,eFlatV.y };

    dvec2 vA; { vA = data[0]; }
    dvec2 vB; { vB = data[1]; }
    dvec2 vC; { vC = data[2]; }
    dvec2 vFlatV; { vFlatV = dataFlat; }
    double vFlat[6 / 3] = { vFlatV.x,vFlatV.y};

    double v[6] = { vA.x,vA.y,vB.x,vB.y,vC.x,vC.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(points) out;
layout(max_vertices=1, max_primitives = 1) out;
layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[64];
} pvd;
layout (location=0) out dvec4 data[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    SetMeshOutputsEXT(1u, 1u);
    const uint vertex = gl_LocalInvocationIndex;
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z + gl_NumWorkGroups.x * gl_WorkGroupID.y + gl_WorkGroupID.x;
    uint jobId = workGroupIndex + gl_LocalInvocationIndex;
    gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[jobId];
    gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
    gl_PrimitivePointIndicesEXT[vertex] = vertex;
    uint n  = jobId + 1;
    data[vertex] = dvec4(double(n), double(2*n), double(4*n), double(8*n));
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec4 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = w * y + x;
    const bool even = (p%2 == 0);

    dvec4 eA; { const int n = 1 + (p); eA = dvec4(double(n), double(2*n), double(4*n), double(8*n)); }
    dvec4 eB; { const int n = 1 + (p); eB = dvec4(double(n), double(2*n), double(4*n), double(8*n)); }
    dvec4 eC; { const int n = 1 + (p); eC = dvec4(double(n), double(2*n), double(4*n), double(8*n)); }

    double e[12] = { eA.x,eA.y,eA.z,eA.w,eB.x,eB.y,eB.z,eB.w,eC.x,eC.y,eC.z,eC.w };

    dvec4 vA; { vA = data[0]; }
    dvec4 vB; { vB = data[1]; }
    dvec4 vC; { vC = data[2]; }

    double v[12] = { vA.x,vA.y,vA.z,vA.w,vB.x,vB.y,vB.z,vB.w,vC.x,vC.y,vC.z,vC.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out int data;
layout(location = 1) out int dataFlat;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = int(n);
    dataFlat      = int(n);
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 1) flat in int dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in int data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = w * y + x;
    const bool even = (p%2 == 0);

    int eA; { const int n = 1 + (p); eA = int(n); }
    int eB; { const int n = 1 + (p); eB = int(n); }
    int eC; { const int n = 1 + (p); eC = int(n); }

    int e[3] = { eA,eB,eC };
    int eFlatV; { const int n = 1 + (p); eFlatV = int(n); }
    int eFlat[3 / 3] = { eFlatV };

    int vA; { vA = data[0]; }
    int vB; { vB = data[1]; }
    int vC; { vC = data[2]; }
    int vFlatV; { vFlatV = dataFlat; }
    int vFlat[3 / 3] = { vFlatV};

    int v[3] = { vA,vB,vC };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<3 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(points) out;
layout(max_vertices=1, max_primitives = 1) out;
layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[64];
} pvd;
layout (location=0) out ivec2 data[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    SetMeshOutputsEXT(1u, 1u);
    const uint vertex = gl_LocalInvocationIndex;
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z + gl_NumWorkGroups.x * gl_WorkGroupID.y + gl_WorkGroupID.x;
    uint jobId = workGroupIndex + gl_LocalInvocationIndex;
    gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[jobId];
    gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
    gl_PrimitivePointIndicesEXT[vertex] = vertex;
    uint n  = jobId + 1;
    data[vertex] = ivec2(int(n), int(2*n));
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in ivec2 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = w * y + x;
    const bool even = (p%2 == 0);

    ivec2 eA; { const int n = 1 + (p); eA = ivec2(int(n), int(2*n)); }
    ivec2 eB; { const int n = 1 + (p); eB = ivec2(int(n), int(2*n)); }
    ivec2 eC; { const int n = 1 + (p); eC = ivec2(int(n), int(2*n)); }

    int e[6] = { eA.x,eA.y,eB.x,eB.y,eC.x,eC.y };

    ivec2 vA; { vA = data[0]; }
    ivec2 vB; { vB = data[1]; }
    ivec2 vC; { vC = data[2]; }

    int v[6] = { vA.x,vA.y,vB.x,vB.y,vC.x,vC.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out ivec2 data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = ivec2(int(n), int(2*n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out ivec4 data;
layout(location = 1) out ivec4 dataFlat;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = ivec4(int(n), int(2*n), int(4*n), int(8*n));
    dataFlat      = ivec4(int(n), int(2*n), int(4*n), int(8*n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 1) flat in ivec4 dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in ivec4 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = w * y + x;
    const bool even = (p%2 == 0);

    ivec4 eA; { const int n = 1 + (p); eA = ivec4(int(n), int(2*n), int(4*n), int(8*n)); }
    ivec4 eB; { const int n = 1 + (p); eB = ivec4(int(n), int(2*n), int(4*n), int(8*n)); }
    ivec4 eC; { const int n = 1 + (p); eC = ivec4(int(n), int(2*n), int(4*n), int(8*n)); }

    int e[12] = { eA.x,eA.y,eA.z,eA.w,eB.x,eB.y,eB.z,eB.w,eC.x,eC.y,eC.z,eC.w };
    ivec4 eFlatV; { const int n = 1 + (p); eFlatV = ivec4(int(n), int(2*n), int(4*n), int(8*n)); }
    int eFlat[12 / 3] = { eFlatV.x,eFlatV.y,eFlatV.z,eFlatV.w };

    ivec4 vA; { vA = data[0]; }
    ivec4 vB; { vB = data[1]; }
    ivec4 vC; { vC = data[2]; }
    ivec4 vFlatV; { vFlatV = dataFlat; }
    int vFlat[12 / 3] = { vFlatV.x,vFlatV.y,vFlatV.z,vFlatV.w};

    int v[12] = { vA.x,vA.y,vA.z,vA.w,vB.x,vB.y,vB.z,vB.w,vC.x,vC.y,vC.z,vC.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<12 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out uint data;
layout(location = 1) out uint dataFlat;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = uint(n);
    dataFlat      = uint(n);
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 1) flat in uint dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uint data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = w * y + x;
    const bool even = (p%2 == 0);

    uint eA; { const int n = 1 + (p); eA = uint(n); }
    uint eB; { const int n = 1 + (p); eB = uint(n); }
    uint eC; { const int n = 1 + (p); eC = uint(n); }

    uint e[3] = { eA,eB,eC };
    uint eFlatV; { const int n = 1 + (p); eFlatV = uint(n); }
    uint eFlat[3 / 3] = { eFlatV };

    uint vA; { vA = data[0]; }
    uint vB; { vB = data[1]; }
    uint vC; { vC = data[2]; }
    uint vFlatV; { vFlatV = dataFlat; }
    uint vFlat[3 / 3] = { vFlatV};

    uint v[3] = { vA,vB,vC };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<3 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable

struct DataStruct {vec2 q;};
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(points) out;
layout(max_vertices=1, max_primitives = 1) out;
layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[64];
} pvd;
layout (location=0) out DataStruct data[];
layout(location = 1) out DataStruct dataFlat[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    SetMeshOutputsEXT(1u, 1u);
    const uint vertex = gl_LocalInvocationIndex;
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z + gl_NumWorkGroups.x * gl_WorkGroupID.y + gl_WorkGroupID.x;
    uint jobId = workGroupIndex + gl_LocalInvocationIndex;
    gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[jobId];
    gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
    gl_PrimitivePointIndicesEXT[vertex] = vertex;
    uint n  = jobId + 1;
    data[vertex] = DataStruct(vec2(float(n), float(2*n)));
    dataFlat[vertex]      = DataStruct(vec2(float(n), float(2*n)));
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec2 q;};


layout(location = 1) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = w * y + x;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (p); eA = DataStruct(vec2(float(n), float(2*n))); }
    DataStruct eB; { const int n = 1 + (p); eB = DataStruct(vec2(float(n), float(2*n))); }
    DataStruct eC; { const int n = 1 + (p); eC = DataStruct(vec2(float(n), float(2*n))); }

    float e[6] = { eA.q.x,eA.q.y,eB.q.x,eB.q.y,eC.q.x,eC.q.y };
    DataStruct eFlatV; { const int n = 1 + (p); eFlatV = DataStruct(vec2(float(n), float(2*n))); }
    float eFlat[6 / 3] = { eFlatV.q.x,eFlatV.q.y };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    float vFlat[6 / 3] = { vFlatV.q.x,vFlatV.q.y};

    float v[6] = { vA.q.x,vA.q.y,vB.q.x,vB.q.y,vC.q.x,vC.q.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable

struct DataStruct {vec4 q;};
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(points) out;
layout(max_vertices=1, max_primitives = 1) out;
layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[64];
} pvd;
layout (location=0) out DataStruct data[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    SetMeshOutputsEXT(1u, 1u);
    const uint vertex = gl_LocalInvocationIndex;
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z + gl_NumWorkGroups.x * gl_WorkGroupID.y + gl_WorkGroupID.x;
    uint jobId = workGroupIndex + gl_LocalInvocationIndex;
    gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[jobId];
    gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
    gl_PrimitivePointIndicesEXT[vertex] = vertex;
    uint n  = jobId + 1;
    data[vertex] = DataStruct(vec4(float(n), float(2*n), float(4*n), float(8*n)));
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec4 q;};


layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = w * y + x;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (p); eA = DataStruct(vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    DataStruct eB; { const int n = 1 + (p); eB = DataStruct(vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    DataStruct eC; { const int n = 1 + (p); eC = DataStruct(vec4(float(n), float(2*n), float(4*n), float(8*n))); }

    float e[12] = { eA.q.x,eA.q.y,eA.q.z,eA.q.w,eB.q.x,eB.q.y,eB.q.z,eB.q.w,eC.q.x,eC.q.y,eC.q.z,eC.q.w };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }

    float v[12] = { vA.q.x,vA.q.y,vA.q.z,vA.q.w,vB.q.x,vB.q.y,vB.q.z,vB.q.w,vC.q.x,vC.q.y,vC.q.z,vC.q.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable

struct DataStruct {dvec4 q;};
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(points) out;
layout(max_vertices=1, max_primitives = 1) out;
layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[64];
} pvd;
layout (location=0) out DataStruct data[];
layout(location = 2) out DataStruct dataFlat[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    SetMeshOutputsEXT(1u, 1u);
    const uint vertex = gl_LocalInvocationIndex;
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z + gl_NumWorkGroups.x * gl_WorkGroupID.y + gl_WorkGroupID.x;
    uint jobId = workGroupIndex + gl_LocalInvocationIndex;
    gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[jobId];
    gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
    gl_PrimitivePointIndicesEXT[vertex] = vertex;
    uint n  = jobId + 1;
    data[vertex] = DataStruct(dvec4(double(n), double(2*n), double(4*n), double(8*n)));
    dataFlat[vertex]      = DataStruct(dvec4(double(n), double(2*n), double(4*n), double(8*n)));
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {dvec4 q;};


layout(location = 2) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = w * y + x;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (p); eA = DataStruct(dvec4(double(n), double(2*n), double(4*n), double(8*n))); }
    DataStruct eB; { const int n = 1 + (p); eB = DataStruct(dvec4(double(n), double(2*n), double(4*n), double(8*n))); }
    DataStruct eC; { const int n = 1 + (p); eC = DataStruct(dvec4(double(n), double(2*n), double(4*n), double(8*n))); }

    double e[12] = { eA.q.x,eA.q.y,eA.q.z,eA.q.w,eB.q.x,eB.q.y,eB.q.z,eB.q.w,eC.q.x,eC.q.y,eC.q.z,eC.q.w };
    DataStruct eFlatV; { const int n = 1 + (p); eFlatV = DataStruct(dvec4(double(n), double(2*n), double(4*n), double(8*n))); }
    double eFlat[12 / 3] = { eFlatV.q.x,eFlatV.q.y,eFlatV.q.z,eFlatV.q.w };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    double vFlat[12 / 3] = { vFlatV.q.x,vFlatV.q.y,vFlatV.q.z,vFlatV.q.w};

    double v[12] = { vA.q.x,vA.q.y,vA.q.z,vA.q.w,vB.q.x,vB.q.y,vB.q.z,vB.q.w,vC.q.x,vC.q.y,vC.q.z,vC.q.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<12 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {ivec2 q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(ivec2(int(n), int(2*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {ivec2 q;};


layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = w * y + x;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (p); eA = DataStruct(ivec2(int(n), int(2*n))); }
    DataStruct eB; { const int n = 1 + (p); eB = DataStruct(ivec2(int(n), int(2*n))); }
    DataStruct eC; { const int n = 1 + (p); eC = DataStruct(ivec2(int(n), int(2*n))); }

    int e[6] = { eA.q.x,eA.q.y,eB.q.x,eB.q.y,eC.q.x,eC.q.y };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }

    int v[6] = { vA.q.x,vA.q.y,vB.q.x,vB.q.y,vC.q.x,vC.q.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable

struct DataStruct {ivec3 q;};
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(points) out;
layout(max_vertices=1, max_primitives = 1) out;
layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[64];
} pvd;
layout (location=0) out DataStruct data[];
layout(location = 1) out DataStruct dataFlat[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    SetMeshOutputsEXT(1u, 1u);
    const uint vertex = gl_LocalInvocationIndex;
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z + gl_NumWorkGroups.x * gl_WorkGroupID.y + gl_WorkGroupID.x;
    uint jobId = workGroupIndex + gl_LocalInvocationIndex;
    gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[jobId];
    gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
    gl_PrimitivePointIndicesEXT[vertex] = vertex;
    uint n  = jobId + 1;
    data[vertex] = DataStruct(ivec3(int(n), int(2*n), int(4*n)));
    dataFlat[vertex]      = DataStruct(ivec3(int(n), int(2*n), int(4*n)));
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {ivec3 q;};


layout(location = 1) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = w * y + x;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (p); eA = DataStruct(ivec3(int(n), int(2*n), int(4*n))); }
    DataStruct eB; { const int n = 1 + (p); eB = DataStruct(ivec3(int(n), int(2*n), int(4*n))); }
    DataStruct eC; { const int n = 1 + (p); eC = DataStruct(ivec3(int(n), int(2*n), int(4*n))); }

    int e[9] = { eA.q.x,eA.q.y,eA.q.z,eB.q.x,eB.q.y,eB.q.z,eC.q.x,eC.q.y,eC.q.z };
    DataStruct eFlatV; { const int n = 1 + (p); eFlatV = DataStruct(ivec3(int(n), int(2*n), int(4*n))); }
    int eFlat[9 / 3] = { eFlatV.q.x,eFlatV.q.y,eFlatV.q.z };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    int vFlat[9 / 3] = { vFlatV.q.x,vFlatV.q.y,vFlatV.q.z};

    int v[9] = { vA.q.x,vA.q.y,vA.q.z,vB.q.x,vB.q.y,vB.q.z,vC.q.x,vC.q.y,vC.q.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<9 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {uint q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(uint(n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {uint q;};


layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = w * y + x;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (p); eA = DataStruct(uint(n)); }
    DataStruct eB; { const int n = 1 + (p); eB = DataStruct(uint(n)); }
    DataStruct eC; { const int n = 1 + (p); eC = DataStruct(uint(n)); }

    uint e[3] = { eA.q,eB.q,eC.q };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }

    uint v[3] = { vA.q,vB.q,vC.q };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable

struct DataStruct {uvec4 q;};
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(points) out;
layout(max_vertices=1, max_primitives = 1) out;
layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[64];
} pvd;
layout (location=0) out DataStruct data[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    SetMeshOutputsEXT(1u, 1u);
    const uint vertex = gl_LocalInvocationIndex;
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z + gl_NumWorkGroups.x * gl_WorkGroupID.y + gl_WorkGroupID.x;
    uint jobId = workGroupIndex + gl_LocalInvocationIndex;
    gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[jobId];
    gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
    gl_PrimitivePointIndicesEXT[vertex] = vertex;
    uint n  = jobId + 1;
    data[vertex] = DataStruct(uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)));
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {uvec4 q;};


layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = w * y + x;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (p); eA = DataStruct(uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }
    DataStruct eB; { const int n = 1 + (p); eB = DataStruct(uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }
    DataStruct eC; { const int n = 1 + (p); eC = DataStruct(uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }

    uint e[12] = { eA.q.x,eA.q.y,eA.q.z,eA.q.w,eB.q.x,eB.q.y,eB.q.z,eB.q.w,eC.q.x,eC.q.y,eC.q.z,eC.q.w };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }

    uint v[12] = { vA.q.x,vA.q.y,vA.q.z,vA.q.w,vB.q.x,vB.q.y,vB.q.z,vB.q.w,vC.q.x,vC.q.y,vC.q.z,vC.q.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out vec3 data[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec3 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = w * y + x;
    const bool even = (p%2 == 0);

    vec3 eA[2]; { const int n = 1 + (p); eA = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n))); }
    vec3 eB[2]; { const int n = 1 + (p); eB = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n))); }
    vec3 eC[2]; { const int n = 1 + (p); eC = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n))); }

    float e[18] = { eA[0].x,eA[0].y,eA[0].z,eA[1].x,eA[1].y,eA[1].z,eB[0].x,eB[0].y,eB[0].z,eB[1].x,eB[1].y,eB[1].z,eC[0].x,eC[0].y,eC[0].z,eC[1].x,eC[1].y,eC[1].z };

    vec3 vA[2]; { vA = vec3[2](data[0][0],data[0][1]); }
    vec3 vB[2]; { vB = vec3[2](data[1][0],data[1][1]); }
    vec3 vC[2]; { vC = vec3[2](data[2][0],data[2][1]); }

    float v[18] = { vA[0].x,vA[0].y,vA[0].z,vA[1].x,vA[1].y,vA[1].z,vB[0].x,vB[0].y,vB[0].z,vB[1].x,vB[1].y,vB[1].z,vC[0].x,vC[0].y,vC[0].z,vC[1].x,vC[1].y,vC[1].z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<18; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(points) out;
layout(max_vertices=1, max_primitives = 1) out;
layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[64];
} pvd;
layout (location=0) out vec4 data[][2];
layout(location = 2) out vec4 dataInterp[][2];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    SetMeshOutputsEXT(1u, 1u);
    const uint vertex = gl_LocalInvocationIndex;
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z + gl_NumWorkGroups.x * gl_WorkGroupID.y + gl_WorkGroupID.x;
    uint jobId = workGroupIndex + gl_LocalInvocationIndex;
    gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[jobId];
    gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
    gl_PrimitivePointIndicesEXT[vertex] = vertex;
    uint n  = jobId + 1;
    data[vertex] = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n)));
    dataInterp[vertex]    = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n)));
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 2) in vec4 dataIntrp[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec4 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = w * y + x;
    const bool even = (p%2 == 0);

    vec4 eA[2]; { const int n = 1 + (p); eA = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    vec4 eB[2]; { const int n = 1 + (p); eB = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    vec4 eC[2]; { const int n = 1 + (p); eC = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n))); }

    float e[24] = { eA[0].x,eA[0].y,eA[0].z,eA[0].w,eA[1].x,eA[1].y,eA[1].z,eA[1].w,eB[0].x,eB[0].y,eB[0].z,eB[0].w,eB[1].x,eB[1].y,eB[1].z,eB[1].w,eC[0].x,eC[0].y,eC[0].z,eC[0].w,eC[1].x,eC[1].y,eC[1].z,eC[1].w };
    vec4 eIntrpV[2]; {eIntrpV = vec4[2](eA[0] * gl_BaryCoordEXT.x + eB[0] * gl_BaryCoordEXT.y + eC[0] * gl_BaryCoordEXT.z, eA[1] * gl_BaryCoordEXT.x + eB[1] * gl_BaryCoordEXT.y + eC[1] * gl_BaryCoordEXT.z); }
    float eIntrp[24 / 3] = { eIntrpV[0].x,eIntrpV[0].y,eIntrpV[0].z,eIntrpV[0].w,eIntrpV[1].x,eIntrpV[1].y,eIntrpV[1].z,eIntrpV[1].w };

    vec4 vA[2]; { vA = vec4[2](data[0][0],data[0][1]); }
    vec4 vB[2]; { vB = vec4[2](data[1][0],data[1][1]); }
    vec4 vC[2]; { vC = vec4[2](data[2][0],data[2][1]); }
    vec4 vIntrpV[2]; { vIntrpV = vec4[2](dataIntrp[0],dataIntrp[1]); }
    float vIntrp[24 / 3] = { vIntrpV[0].x,vIntrpV[0].y,vIntrpV[0].z,vIntrpV[0].w,vIntrpV[1].x,vIntrpV[1].y,vIntrpV[1].z,vIntrpV[1].w };

    float v[24] = { vA[0].x,vA[0].y,vA[0].z,vA[0].w,vA[1].x,vA[1].y,vA[1].z,vA[1].w,vB[0].x,vB[0].y,vB[0].z,vB[0].w,vB[1].x,vB[1].y,vB[1].z,vB[1].w,vC[0].x,vC[0].y,vC[0].z,vC[0].w,vC[1].x,vC[1].y,vC[1].z,vC[1].w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<24; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<24 / 3; i++)
        if (abs(eIntrp[i] - vIntrp[i]) < 0.001)
            mask.y = mask.y | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(points) out;
layout(max_vertices=1, max_primitives = 1) out;
layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[64];
} pvd;
layout (location=0) out vec4 data[][2];
layout(location = 2) out vec4 dataFlat[][2];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    SetMeshOutputsEXT(1u, 1u);
    const uint vertex = gl_LocalInvocationIndex;
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z + gl_NumWorkGroups.x * gl_WorkGroupID.y + gl_WorkGroupID.x;
    uint jobId = workGroupIndex + gl_LocalInvocationIndex;
    gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[jobId];
    gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
    gl_PrimitivePointIndicesEXT[vertex] = vertex;
    uint n  = jobId + 1;
    data[vertex] = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n)));
    dataFlat[vertex]      = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n)));
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 2) flat in vec4 dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec4 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = w * y + x;
    const bool even = (p%2 == 0);

    vec4 eA[2]; { const int n = 1 + (p); eA = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    vec4 eB[2]; { const int n = 1 + (p); eB = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    vec4 eC[2]; { const int n = 1 + (p); eC = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n))); }

    float e[24] = { eA[0].x,eA[0].y,eA[0].z,eA[0].w,eA[1].x,eA[1].y,eA[1].z,eA[1].w,eB[0].x,eB[0].y,eB[0].z,eB[0].w,eB[1].x,eB[1].y,eB[1].z,eB[1].w,eC[0].x,eC[0].y,eC[0].z,eC[0].w,eC[1].x,eC[1].y,eC[1].z,eC[1].w };
    vec4 eFlatV[2]; { const int n = 1 + (p); eFlatV = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    float eFlat[24 / 3] = { eFlatV[0].x,eFlatV[0].y,eFlatV[0].z,eFlatV[0].w,eFlatV[1].x,eFlatV[1].y,eFlatV[1].z,eFlatV[1].w };

    vec4 vA[2]; { vA = vec4[2](data[0][0],data[0][1]); }
    vec4 vB[2]; { vB = vec4[2](data[1][0],data[1][1]); }
    vec4 vC[2]; { vC = vec4[2](data[2][0],data[2][1]); }
    vec4 vFlatV[2]; { vFlatV = vec4[2](dataFlat[0],dataFlat[1]); }
    float vFlat[24 / 3] = { vFlatV[0].x,vFlatV[0].y,vFlatV[0].z,vFlatV[0].w,vFlatV[1].x,vFlatV[1].y,vFlatV[1].z,vFlatV[1].w};

    float v[24] = { vA[0].x,vA[0].y,vA[0].z,vA[0].w,vA[1].x,vA[1].y,vA[1].z,vA[1].w,vB[0].x,vB[0].y,vB[0].z,vB[0].w,vB[1].x,vB[1].y,vB[1].z,vB[1].w,vC[0].x,vC[0].y,vC[0].z,vC[0].w,vC[1].x,vC[1].y,vC[1].z,vC[1].w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<24; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<24 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(points) out;
layout(max_vertices=1, max_primitives = 1) out;
layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[64];
} pvd;
layout (location=0) out double data[][2];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    SetMeshOutputsEXT(1u, 1u);
    const uint vertex = gl_LocalInvocationIndex;
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z + gl_NumWorkGroups.x * gl_WorkGroupID.y + gl_WorkGroupID.x;
    uint jobId = workGroupIndex + gl_LocalInvocationIndex;
    gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[jobId];
    gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
    gl_PrimitivePointIndicesEXT[vertex] = vertex;
    uint n  = jobId + 1;
    data[vertex] = double[2](double(n), double(3)*double(n));
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in double data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = w * y + x;
    const bool even = (p%2 == 0);

    double eA[2]; { const int n = 1 + (p); eA = double[2](double(n), double(3)*double(n)); }
    double eB[2]; { const int n = 1 + (p); eB = double[2](double(n), double(3)*double(n)); }
    double eC[2]; { const int n = 1 + (p); eC = double[2](double(n), double(3)*double(n)); }

    double e[6] = { eA[0],eA[1],eB[0],eB[1],eC[0],eC[1] };

    double vA[2]; { vA = double[2](data[0][0],data[0][1]); }
    double vB[2]; { vB = double[2](data[1][0],data[1][1]); }
    double vC[2]; { vC = double[2](data[2][0],data[2][1]); }

    double v[6] = { vA[0],vA[1],vB[0],vB[1],vC[0],vC[1] };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(points) out;
layout(max_vertices=1, max_primitives = 1) out;
layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[64];
} pvd;
layout (location=0) out ivec2 data[][2];
layout(location = 2) out ivec2 dataFlat[][2];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    SetMeshOutputsEXT(1u, 1u);
    const uint vertex = gl_LocalInvocationIndex;
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z + gl_NumWorkGroups.x * gl_WorkGroupID.y + gl_WorkGroupID.x;
    uint jobId = workGroupIndex + gl_LocalInvocationIndex;
    gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[jobId];
    gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
    gl_PrimitivePointIndicesEXT[vertex] = vertex;
    uint n  = jobId + 1;
    data[vertex] = ivec2[2](ivec2(int(n), int(2*n)), int(3)*ivec2(int(n), int(2*n)));
    dataFlat[vertex]      = ivec2[2](ivec2(int(n), int(2*n)), int(3)*ivec2(int(n), int(2*n)));
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 2) flat in ivec2 dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in ivec2 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = w * y + x;
    const bool even = (p%2 == 0);

    ivec2 eA[2]; { const int n = 1 + (p); eA = ivec2[2](ivec2(int(n), int(2*n)), int(3)*ivec2(int(n), int(2*n))); }
    ivec2 eB[2]; { const int n = 1 + (p); eB = ivec2[2](ivec2(int(n), int(2*n)), int(3)*ivec2(int(n), int(2*n))); }
    ivec2 eC[2]; { const int n = 1 + (p); eC = ivec2[2](ivec2(int(n), int(2*n)), int(3)*ivec2(int(n), int(2*n))); }

    int e[12] = { eA[0].x,eA[0].y,eA[1].x,eA[1].y,eB[0].x,eB[0].y,eB[1].x,eB[1].y,eC[0].x,eC[0].y,eC[1].x,eC[1].y };
    ivec2 eFlatV[2]; { const int n = 1 + (p); eFlatV = ivec2[2](ivec2(int(n), int(2*n)), int(3)*ivec2(int(n), int(2*n))); }
    int eFlat[12 / 3] = { eFlatV[0].x,eFlatV[0].y,eFlatV[1].x,eFlatV[1].y };

    ivec2 vA[2]; { vA = ivec2[2](data[0][0],data[0][1]); }
    ivec2 vB[2]; { vB = ivec2[2](data[1][0],data[1][1]); }
    ivec2 vC[2]; { vC = ivec2[2](data[2][0],data[2][1]); }
    ivec2 vFlatV[2]; { vFlatV = ivec2[2](dataFlat[0],dataFlat[1]); }
    int vFlat[12 / 3] = { vFlatV[0].x,vFlatV[0].y,vFlatV[1].x,vFlatV[1].y};

    int v[12] = { vA[0].x,vA[0].y,vA[1].x,vA[1].y,vB[0].x,vB[0].y,vB[1].x,vB[1].y,vC[0].x,vC[0].y,vC[1].x,vC[1].y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<12 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out ivec4 data[2];
layout(location = 2) out ivec4 dataFlat[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n)));
    dataFlat      = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 2) flat in ivec4 dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in ivec4 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = w * y + x;
    const bool even = (p%2 == 0);

    ivec4 eA[2]; { const int n = 1 + (p); eA = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n))); }
    ivec4 eB[2]; { const int n = 1 + (p); eB = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n))); }
    ivec4 eC[2]; { const int n = 1 + (p); eC = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n))); }

    int e[24] = { eA[0].x,eA[0].y,eA[0].z,eA[0].w,eA[1].x,eA[1].y,eA[1].z,eA[1].w,eB[0].x,eB[0].y,eB[0].z,eB[0].w,eB[1].x,eB[1].y,eB[1].z,eB[1].w,eC[0].x,eC[0].y,eC[0].z,eC[0].w,eC[1].x,eC[1].y,eC[1].z,eC[1].w };
    ivec4 eFlatV[2]; { const int n = 1 + (p); eFlatV = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n))); }
    int eFlat[24 / 3] = { eFlatV[0].x,eFlatV[0].y,eFlatV[0].z,eFlatV[0].w,eFlatV[1].x,eFlatV[1].y,eFlatV[1].z,eFlatV[1].w };

    ivec4 vA[2]; { vA = ivec4[2](data[0][0],data[0][1]); }
    ivec4 vB[2]; { vB = ivec4[2](data[1][0],data[1][1]); }
    ivec4 vC[2]; { vC = ivec4[2](data[2][0],data[2][1]); }
    ivec4 vFlatV[2]; { vFlatV = ivec4[2](dataFlat[0],dataFlat[1]); }
    int vFlat[24 / 3] = { vFlatV[0].x,vFlatV[0].y,vFlatV[0].z,vFlatV[0].w,vFlatV[1].x,vFlatV[1].y,vFlatV[1].z,vFlatV[1].w};

    int v[24] = { vA[0].x,vA[0].y,vA[0].z,vA[0].w,vA[1].x,vA[1].y,vA[1].z,vA[1].w,vB[0].x,vB[0].y,vB[0].z,vB[0].w,vB[1].x,vB[1].y,vB[1].z,vB[1].w,vC[0].x,vC[0].y,vC[0].z,vC[0].w,vC[1].x,vC[1].y,vC[1].z,vC[1].w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<24; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<24 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out uint data[2];
layout(location = 2) out uint dataFlat[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = uint[2](uint(n), uint(3)*uint(n));
    dataFlat      = uint[2](uint(n), uint(3)*uint(n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 2) flat in uint dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uint data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = w * y + x;
    const bool even = (p%2 == 0);

    uint eA[2]; { const int n = 1 + (p); eA = uint[2](uint(n), uint(3)*uint(n)); }
    uint eB[2]; { const int n = 1 + (p); eB = uint[2](uint(n), uint(3)*uint(n)); }
    uint eC[2]; { const int n = 1 + (p); eC = uint[2](uint(n), uint(3)*uint(n)); }

    uint e[6] = { eA[0],eA[1],eB[0],eB[1],eC[0],eC[1] };
    uint eFlatV[2]; { const int n = 1 + (p); eFlatV = uint[2](uint(n), uint(3)*uint(n)); }
    uint eFlat[6 / 3] = { eFlatV[0],eFlatV[1] };

    uint vA[2]; { vA = uint[2](data[0][0],data[0][1]); }
    uint vB[2]; { vB = uint[2](data[1][0],data[1][1]); }
    uint vC[2]; { vC = uint[2](data[2][0],data[2][1]); }
    uint vFlatV[2]; { vFlatV = uint[2](dataFlat[0],dataFlat[1]); }
    uint vFlat[6 / 3] = { vFlatV[0],vFlatV[1]};

    uint v[6] = { vA[0],vA[1],vB[0],vB[1],vC[0],vC[1] };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out vec2 data;
layout(location = 1) out vec2 dataInterp;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = vec2(float(n), float(2*n));
    dataInterp    = vec2(float(n), float(2*n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 1) in vec2 dataIntrp;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec2 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    vec2 eA; { const int n = 1 + (2*p); eA = vec2(float(n), float(2*n)); }
    vec2 eB; { const int n = 1 + (2*p+1); eB = vec2(float(n), float(2*n)); }
    vec2 eC; { const int n = 1 + (2*p+1); eC = vec2(float(n), float(2*n)); }

    float e[6] = { eA.x,eA.y,eB.x,eB.y,eC.x,eC.y };
    vec2 eIntrpV; {eIntrpV = vec2(eA * gl_BaryCoordEXT.x + eB * gl_BaryCoordEXT.y + eC * gl_BaryCoordEXT.z); }
    float eIntrp[6 / 3] = { eIntrpV.x,eIntrpV.y };

    vec2 vA; { vA = data[0]; }
    vec2 vB; { vB = data[1]; }
    vec2 vC; { vC = data[2]; }
    vec2 vIntrpV; { vIntrpV = dataIntrp; }
    float vIntrp[6 / 3] = { vIntrpV.x,vIntrpV.y };

    float v[6] = { vA.x,vA.y,vB.x,vB.y,vC.x,vC.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (abs(eIntrp[i] - vIntrp[i]) < 0.001)
            mask.y = mask.y | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out vec3 data;
layout(location = 1) out vec3 dataInterp;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = vec3(float(n), float(2*n), float(4*n));
    dataInterp    = vec3(float(n), float(2*n), float(4*n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 1) in vec3 dataIntrp;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec3 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    vec3 eA; { const int n = 1 + (2*p); eA = vec3(float(n), float(2*n), float(4*n)); }
    vec3 eB; { const int n = 1 + (2*p+1); eB = vec3(float(n), float(2*n), float(4*n)); }
    vec3 eC; { const int n = 1 + (2*p+1); eC = vec3(float(n), float(2*n), float(4*n)); }

    float e[9] = { eA.x,eA.y,eA.z,eB.x,eB.y,eB.z,eC.x,eC.y,eC.z };
    vec3 eIntrpV; {eIntrpV = vec3(eA * gl_BaryCoordEXT.x + eB * gl_BaryCoordEXT.y + eC * gl_BaryCoordEXT.z); }
    float eIntrp[9 / 3] = { eIntrpV.x,eIntrpV.y,eIntrpV.z };

    vec3 vA; { vA = data[0]; }
    vec3 vB; { vB = data[1]; }
    vec3 vC; { vC = data[2]; }
    vec3 vIntrpV; { vIntrpV = dataIntrp; }
    float vIntrp[9 / 3] = { vIntrpV.x,vIntrpV.y,vIntrpV.z };

    float v[9] = { vA.x,vA.y,vA.z,vB.x,vB.y,vB.z,vC.x,vC.y,vC.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<9 / 3; i++)
        if (abs(eIntrp[i] - vIntrp[i]) < 0.001)
            mask.y = mask.y | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out vec4 data;
layout(location = 1) out vec4 dataFlat;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = vec4(float(n), float(2*n), float(4*n), float(8*n));
    dataFlat      = vec4(float(n), float(2*n), float(4*n), float(8*n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 1) flat in vec4 dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec4 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    vec4 eA; { const int n = 1 + (2*p); eA = vec4(float(n), float(2*n), float(4*n), float(8*n)); }
    vec4 eB; { const int n = 1 + (2*p+1); eB = vec4(float(n), float(2*n), float(4*n), float(8*n)); }
    vec4 eC; { const int n = 1 + (2*p+1); eC = vec4(float(n), float(2*n), float(4*n), float(8*n)); }

    float e[12] = { eA.x,eA.y,eA.z,eA.w,eB.x,eB.y,eB.z,eB.w,eC.x,eC.y,eC.z,eC.w };
    vec4 eFlatV; { const int n = 1 + (2*p); eFlatV = vec4(float(n), float(2*n), float(4*n), float(8*n)); }
    float eFlat[12 / 3] = { eFlatV.x,eFlatV.y,eFlatV.z,eFlatV.w };

    vec4 vA; { vA = data[0]; }
    vec4 vB; { vB = data[1]; }
    vec4 vC; { vC = data[2]; }
    vec4 vFlatV; { vFlatV = dataFlat; }
    float vFlat[12 / 3] = { vFlatV.x,vFlatV.y,vFlatV.z,vFlatV.w};

    float v[12] = { vA.x,vA.y,vA.z,vA.w,vB.x,vB.y,vB.z,vB.w,vC.x,vC.y,vC.z,vC.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<12 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out double data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = double(n);
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in double data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    double eA; { const int n = 1 + (2*p); eA = double(n); }
    double eB; { const int n = 1 + (2*p+1); eB = double(n); }
    double eC; { const int n = 1 + (2*p+1); eC = double(n); }

    double e[3] = { eA,eB,eC };

    double vA; { vA = data[0]; }
    double vB; { vB = data[1]; }
    double vC; { vC = data[2]; }

    double v[3] = { vA,vB,vC };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(lines) out;
layout(max_vertices=16, max_primitives=16) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[16];
} pvd;
layout (location=0) out dvec4 data[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 16;
    uint maxPrimitive = 8;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = dvec4(double(n), double(2*n), double(4*n), double(8*n));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveLineIndicesEXT[vertex] = uvec2(vertex * 2, vertex * 2 + 1u);
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec4 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    dvec4 eA; { const int n = 1 + (2*p); eA = dvec4(double(n), double(2*n), double(4*n), double(8*n)); }
    dvec4 eB; { const int n = 1 + (2*p+1); eB = dvec4(double(n), double(2*n), double(4*n), double(8*n)); }
    dvec4 eC; { const int n = 1 + (2*p+1); eC = dvec4(double(n), double(2*n), double(4*n), double(8*n)); }

    double e[12] = { eA.x,eA.y,eA.z,eA.w,eB.x,eB.y,eB.z,eB.w,eC.x,eC.y,eC.z,eC.w };

    dvec4 vA; { vA = data[0]; }
    dvec4 vB; { vB = data[1]; }
    dvec4 vC; { vC = data[2]; }

    double v[12] = { vA.x,vA.y,vA.z,vA.w,vB.x,vB.y,vB.z,vB.w,vC.x,vC.y,vC.z,vC.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(lines) out;
layout(max_vertices=16, max_primitives=16) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[16];
} pvd;
layout (location=0) out ivec2 data[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 16;
    uint maxPrimitive = 8;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = ivec2(int(n), int(2*n));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveLineIndicesEXT[vertex] = uvec2(vertex * 2, vertex * 2 + 1u);
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in ivec2 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    ivec2 eA; { const int n = 1 + (2*p); eA = ivec2(int(n), int(2*n)); }
    ivec2 eB; { const int n = 1 + (2*p+1); eB = ivec2(int(n), int(2*n)); }
    ivec2 eC; { const int n = 1 + (2*p+1); eC = ivec2(int(n), int(2*n)); }

    int e[6] = { eA.x,eA.y,eB.x,eB.y,eC.x,eC.y };

    ivec2 vA; { vA = data[0]; }
    ivec2 vB; { vB = data[1]; }
    ivec2 vC; { vC = data[2]; }

    int v[6] = { vA.x,vA.y,vB.x,vB.y,vC.x,vC.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(lines) out;
layout(max_vertices=16, max_primitives=16) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[16];
} pvd;
layout (location=0) out ivec2 data[];
layout(location = 1) out ivec2 dataFlat[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 16;
    uint maxPrimitive = 8;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = ivec2(int(n), int(2*n));
    dataFlat[vertex]      = ivec2(int(n), int(2*n));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveLineIndicesEXT[vertex] = uvec2(vertex * 2, vertex * 2 + 1u);
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 1) flat in ivec2 dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in ivec2 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    ivec2 eA; { const int n = 1 + (2*p); eA = ivec2(int(n), int(2*n)); }
    ivec2 eB; { const int n = 1 + (2*p+1); eB = ivec2(int(n), int(2*n)); }
    ivec2 eC; { const int n = 1 + (2*p+1); eC = ivec2(int(n), int(2*n)); }

    int e[6] = { eA.x,eA.y,eB.x,eB.y,eC.x,eC.y };
    ivec2 eFlatV; { const int n = 1 + (2*p); eFlatV = ivec2(int(n), int(2*n)); }
    int eFlat[6 / 3] = { eFlatV.x,eFlatV.y };

    ivec2 vA; { vA = data[0]; }
    ivec2 vB; { vB = data[1]; }
    ivec2 vC; { vC = data[2]; }
    ivec2 vFlatV; { vFlatV = dataFlat; }
    int vFlat[6 / 3] = { vFlatV.x,vFlatV.y};

    int v[6] = { vA.x,vA.y,vB.x,vB.y,vC.x,vC.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out uint data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = uint(n);
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uint data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    uint eA; { const int n = 1 + (2*p); eA = uint(n); }
    uint eB; { const int n = 1 + (2*p+1); eB = uint(n); }
    uint eC; { const int n = 1 + (2*p+1); eC = uint(n); }

    uint e[3] = { eA,eB,eC };

    uint vA; { vA = data[0]; }
    uint vB; { vB = data[1]; }
    uint vC; { vC = data[2]; }

    uint v[3] = { vA,vB,vC };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out uvec3 data;
layout(location = 1) out uvec3 dataFlat;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = uvec3(uint(n), uint(2*n), uint(4*n));
    dataFlat      = uvec3(uint(n), uint(2*n), uint(4*n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 1) flat in uvec3 dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uvec3 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    uvec3 eA; { const int n = 1 + (2*p); eA = uvec3(uint(n), uint(2*n), uint(4*n)); }
    uvec3 eB; { const int n = 1 + (2*p+1); eB = uvec3(uint(n), uint(2*n), uint(4*n)); }
    uvec3 eC; { const int n = 1 + (2*p+1); eC = uvec3(uint(n), uint(2*n), uint(4*n)); }

    uint e[9] = { eA.x,eA.y,eA.z,eB.x,eB.y,eB.z,eC.x,eC.y,eC.z };
    uvec3 eFlatV; { const int n = 1 + (2*p); eFlatV = uvec3(uint(n), uint(2*n), uint(4*n)); }
    uint eFlat[9 / 3] = { eFlatV.x,eFlatV.y,eFlatV.z };

    uvec3 vA; { vA = data[0]; }
    uvec3 vB; { vB = data[1]; }
    uvec3 vC; { vC = data[2]; }
    uvec3 vFlatV; { vFlatV = dataFlat; }
    uint vFlat[9 / 3] = { vFlatV.x,vFlatV.y,vFlatV.z};

    uint v[9] = { vA.x,vA.y,vA.z,vB.x,vB.y,vB.z,vC.x,vC.y,vC.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<9 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec2 q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;
layout(location = 1) out DataStruct dataFlat;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(vec2(float(n), float(2*n)));
    dataFlat      = DataStruct(vec2(float(n), float(2*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec2 q;};


layout(location = 1) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (2*p); eA = DataStruct(vec2(float(n), float(2*n))); }
    DataStruct eB; { const int n = 1 + (2*p+1); eB = DataStruct(vec2(float(n), float(2*n))); }
    DataStruct eC; { const int n = 1 + (2*p+1); eC = DataStruct(vec2(float(n), float(2*n))); }

    float e[6] = { eA.q.x,eA.q.y,eB.q.x,eB.q.y,eC.q.x,eC.q.y };
    DataStruct eFlatV; { const int n = 1 + (2*p); eFlatV = DataStruct(vec2(float(n), float(2*n))); }
    float eFlat[6 / 3] = { eFlatV.q.x,eFlatV.q.y };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    float vFlat[6 / 3] = { vFlatV.q.x,vFlatV.q.y};

    float v[6] = { vA.q.x,vA.q.y,vB.q.x,vB.q.y,vC.q.x,vC.q.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable

struct DataStruct {dvec2 q;};
layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(lines) out;
layout(max_vertices=16, max_primitives=16) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[16];
} pvd;
layout (location=0) out DataStruct data[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 16;
    uint maxPrimitive = 8;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = DataStruct(dvec2(double(n), double(2*n)));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveLineIndicesEXT[vertex] = uvec2(vertex * 2, vertex * 2 + 1u);
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {dvec2 q;};


layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (2*p); eA = DataStruct(dvec2(double(n), double(2*n))); }
    DataStruct eB; { const int n = 1 + (2*p+1); eB = DataStruct(dvec2(double(n), double(2*n))); }
    DataStruct eC; { const int n = 1 + (2*p+1); eC = DataStruct(dvec2(double(n), double(2*n))); }

    double e[6] = { eA.q.x,eA.q.y,eB.q.x,eB.q.y,eC.q.x,eC.q.y };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }

    double v[6] = { vA.q.x,vA.q.y,vB.q.x,vB.q.y,vC.q.x,vC.q.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {int q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(int(n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {int q;};


layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (2*p); eA = DataStruct(int(n)); }
    DataStruct eB; { const int n = 1 + (2*p+1); eB = DataStruct(int(n)); }
    DataStruct eC; { const int n = 1 + (2*p+1); eC = DataStruct(int(n)); }

    int e[3] = { eA.q,eB.q,eC.q };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }

    int v[3] = { vA.q,vB.q,vC.q };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {ivec2 q;};


layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (2*p); eA = DataStruct(ivec2(int(n), int(2*n))); }
    DataStruct eB; { const int n = 1 + (2*p+1); eB = DataStruct(ivec2(int(n), int(2*n))); }
    DataStruct eC; { const int n = 1 + (2*p+1); eC = DataStruct(ivec2(int(n), int(2*n))); }

    int e[6] = { eA.q.x,eA.q.y,eB.q.x,eB.q.y,eC.q.x,eC.q.y };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }

    int v[6] = { vA.q.x,vA.q.y,vB.q.x,vB.q.y,vC.q.x,vC.q.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {ivec3 q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;
layout(location = 1) out DataStruct dataFlat;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(ivec3(int(n), int(2*n), int(4*n)));
    dataFlat      = DataStruct(ivec3(int(n), int(2*n), int(4*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {ivec3 q;};


layout(location = 1) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (2*p); eA = DataStruct(ivec3(int(n), int(2*n), int(4*n))); }
    DataStruct eB; { const int n = 1 + (2*p+1); eB = DataStruct(ivec3(int(n), int(2*n), int(4*n))); }
    DataStruct eC; { const int n = 1 + (2*p+1); eC = DataStruct(ivec3(int(n), int(2*n), int(4*n))); }

    int e[9] = { eA.q.x,eA.q.y,eA.q.z,eB.q.x,eB.q.y,eB.q.z,eC.q.x,eC.q.y,eC.q.z };
    DataStruct eFlatV; { const int n = 1 + (2*p); eFlatV = DataStruct(ivec3(int(n), int(2*n), int(4*n))); }
    int eFlat[9 / 3] = { eFlatV.q.x,eFlatV.q.y,eFlatV.q.z };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    int vFlat[9 / 3] = { vFlatV.q.x,vFlatV.q.y,vFlatV.q.z};

    int v[9] = { vA.q.x,vA.q.y,vA.q.z,vB.q.x,vB.q.y,vB.q.z,vC.q.x,vC.q.y,vC.q.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<9 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable

struct DataStruct {ivec4 q;};
layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(lines) out;
layout(max_vertices=16, max_primitives=16) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[16];
} pvd;
layout (location=0) out DataStruct data[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 16;
    uint maxPrimitive = 8;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = DataStruct(ivec4(int(n), int(2*n), int(4*n), int(8*n)));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveLineIndicesEXT[vertex] = uvec2(vertex * 2, vertex * 2 + 1u);
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {ivec4 q;};


layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (2*p); eA = DataStruct(ivec4(int(n), int(2*n), int(4*n), int(8*n))); }
    DataStruct eB; { const int n = 1 + (2*p+1); eB = DataStruct(ivec4(int(n), int(2*n), int(4*n), int(8*n))); }
    DataStruct eC; { const int n = 1 + (2*p+1); eC = DataStruct(ivec4(int(n), int(2*n), int(4*n), int(8*n))); }

    int e[12] = { eA.q.x,eA.q.y,eA.q.z,eA.q.w,eB.q.x,eB.q.y,eB.q.z,eB.q.w,eC.q.x,eC.q.y,eC.q.z,eC.q.w };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }

    int v[12] = { vA.q.x,vA.q.y,vA.q.z,vA.q.w,vB.q.x,vB.q.y,vB.q.z,vB.q.w,vC.q.x,vC.q.y,vC.q.z,vC.q.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable

struct DataStruct {uvec2 q;};
layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(lines) out;
layout(max_vertices=16, max_primitives=16) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[16];
} pvd;
layout (location=0) out DataStruct data[];
layout(location = 1) out DataStruct dataFlat[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 16;
    uint maxPrimitive = 8;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = DataStruct(uvec2(uint(n), uint(2*n)));
    dataFlat[vertex]      = DataStruct(uvec2(uint(n), uint(2*n)));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveLineIndicesEXT[vertex] = uvec2(vertex * 2, vertex * 2 + 1u);
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {uvec2 q;};


layout(location = 1) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (2*p); eA = DataStruct(uvec2(uint(n), uint(2*n))); }
    DataStruct eB; { const int n = 1 + (2*p+1); eB = DataStruct(uvec2(uint(n), uint(2*n))); }
    DataStruct eC; { const int n = 1 + (2*p+1); eC = DataStruct(uvec2(uint(n), uint(2*n))); }

    uint e[6] = { eA.q.x,eA.q.y,eB.q.x,eB.q.y,eC.q.x,eC.q.y };
    DataStruct eFlatV; { const int n = 1 + (2*p); eFlatV = DataStruct(uvec2(uint(n), uint(2*n))); }
    uint eFlat[6 / 3] = { eFlatV.q.x,eFlatV.q.y };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    uint vFlat[6 / 3] = { vFlatV.q.x,vFlatV.q.y};

    uint v[6] = { vA.q.x,vA.q.y,vB.q.x,vB.q.y,vC.q.x,vC.q.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out float data[2];
layout(location = 2) out float dataFlat[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = float[2](float(n), float(3)*float(n));
    dataFlat      = float[2](float(n), float(3)*float(n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 2) flat in float dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in float data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    float eA[2]; { const int n = 1 + (2*p); eA = float[2](float(n), float(3)*float(n)); }
    float eB[2]; { const int n = 1 + (2*p+1); eB = float[2](float(n), float(3)*float(n)); }
    float eC[2]; { const int n = 1 + (2*p+1); eC = float[2](float(n), float(3)*float(n)); }

    float e[6] = { eA[0],eA[1],eB[0],eB[1],eC[0],eC[1] };
    float eFlatV[2]; { const int n = 1 + (2*p); eFlatV = float[2](float(n), float(3)*float(n)); }
    float eFlat[6 / 3] = { eFlatV[0],eFlatV[1] };

    float vA[2]; { vA = float[2](data[0][0],data[0][1]); }
    float vB[2]; { vB = float[2](data[1][0],data[1][1]); }
    float vC[2]; { vC = float[2](data[2][0],data[2][1]); }
    float vFlatV[2]; { vFlatV = float[2](dataFlat[0],dataFlat[1]); }
    float vFlat[6 / 3] = { vFlatV[0],vFlatV[1]};

    float v[6] = { vA[0],vA[1],vB[0],vB[1],vC[0],vC[1] };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out vec3 data[2];
layout(location = 2) out vec3 dataFlat[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n)));
    dataFlat      = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 2) flat in vec3 dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec3 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    vec3 eA[2]; { const int n = 1 + (2*p); eA = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n))); }
    vec3 eB[2]; { const int n = 1 + (2*p+1); eB = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n))); }
    vec3 eC[2]; { const int n = 1 + (2*p+1); eC = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n))); }

    float e[18] = { eA[0].x,eA[0].y,eA[0].z,eA[1].x,eA[1].y,eA[1].z,eB[0].x,eB[0].y,eB[0].z,eB[1].x,eB[1].y,eB[1].z,eC[0].x,eC[0].y,eC[0].z,eC[1].x,eC[1].y,eC[1].z };
    vec3 eFlatV[2]; { const int n = 1 + (2*p); eFlatV = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n))); }
    float eFlat[18 / 3] = { eFlatV[0].x,eFlatV[0].y,eFlatV[0].z,eFlatV[1].x,eFlatV[1].y,eFlatV[1].z };

    vec3 vA[2]; { vA = vec3[2](data[0][0],data[0][1]); }
    vec3 vB[2]; { vB = vec3[2](data[1][0],data[1][1]); }
    vec3 vC[2]; { vC = vec3[2](data[2][0],data[2][1]); }
    vec3 vFlatV[2]; { vFlatV = vec3[2](dataFlat[0],dataFlat[1]); }
    float vFlat[18 / 3] = { vFlatV[0].x,vFlatV[0].y,vFlatV[0].z,vFlatV[1].x,vFlatV[1].y,vFlatV[1].z};

    float v[18] = { vA[0].x,vA[0].y,vA[0].z,vA[1].x,vA[1].y,vA[1].z,vB[0].x,vB[0].y,vB[0].z,vB[1].x,vB[1].y,vB[1].z,vC[0].x,vC[0].y,vC[0].z,vC[1].x,vC[1].y,vC[1].z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<18; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<18 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(lines) out;
layout(max_vertices=16, max_primitives=16) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[16];
} pvd;
layout (location=0) out dvec3 data[][2];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 16;
    uint maxPrimitive = 8;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n)));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveLineIndicesEXT[vertex] = uvec2(vertex * 2, vertex * 2 + 1u);
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec3 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    dvec3 eA[2]; { const int n = 1 + (2*p); eA = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n))); }
    dvec3 eB[2]; { const int n = 1 + (2*p+1); eB = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n))); }
    dvec3 eC[2]; { const int n = 1 + (2*p+1); eC = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n))); }

    double e[18] = { eA[0].x,eA[0].y,eA[0].z,eA[1].x,eA[1].y,eA[1].z,eB[0].x,eB[0].y,eB[0].z,eB[1].x,eB[1].y,eB[1].z,eC[0].x,eC[0].y,eC[0].z,eC[1].x,eC[1].y,eC[1].z };

    dvec3 vA[2]; { vA = dvec3[2](data[0][0],data[0][1]); }
    dvec3 vB[2]; { vB = dvec3[2](data[1][0],data[1][1]); }
    dvec3 vC[2]; { vC = dvec3[2](data[2][0],data[2][1]); }

    double v[18] = { vA[0].x,vA[0].y,vA[0].z,vA[1].x,vA[1].y,vA[1].z,vB[0].x,vB[0].y,vB[0].z,vB[1].x,vB[1].y,vB[1].z,vC[0].x,vC[0].y,vC[0].z,vC[1].x,vC[1].y,vC[1].z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<18; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out ivec2 data[2];
layout(location = 2) out ivec2 dataFlat[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = ivec2[2](ivec2(int(n), int(2*n)), int(3)*ivec2(int(n), int(2*n)));
    dataFlat      = ivec2[2](ivec2(int(n), int(2*n)), int(3)*ivec2(int(n), int(2*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 2) flat in ivec2 dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in ivec2 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    ivec2 eA[2]; { const int n = 1 + (2*p); eA = ivec2[2](ivec2(int(n), int(2*n)), int(3)*ivec2(int(n), int(2*n))); }
    ivec2 eB[2]; { const int n = 1 + (2*p+1); eB = ivec2[2](ivec2(int(n), int(2*n)), int(3)*ivec2(int(n), int(2*n))); }
    ivec2 eC[2]; { const int n = 1 + (2*p+1); eC = ivec2[2](ivec2(int(n), int(2*n)), int(3)*ivec2(int(n), int(2*n))); }

    int e[12] = { eA[0].x,eA[0].y,eA[1].x,eA[1].y,eB[0].x,eB[0].y,eB[1].x,eB[1].y,eC[0].x,eC[0].y,eC[1].x,eC[1].y };
    ivec2 eFlatV[2]; { const int n = 1 + (2*p); eFlatV = ivec2[2](ivec2(int(n), int(2*n)), int(3)*ivec2(int(n), int(2*n))); }
    int eFlat[12 / 3] = { eFlatV[0].x,eFlatV[0].y,eFlatV[1].x,eFlatV[1].y };

    ivec2 vA[2]; { vA = ivec2[2](data[0][0],data[0][1]); }
    ivec2 vB[2]; { vB = ivec2[2](data[1][0],data[1][1]); }
    ivec2 vC[2]; { vC = ivec2[2](data[2][0],data[2][1]); }
    ivec2 vFlatV[2]; { vFlatV = ivec2[2](dataFlat[0],dataFlat[1]); }
    int vFlat[12 / 3] = { vFlatV[0].x,vFlatV[0].y,vFlatV[1].x,vFlatV[1].y};

    int v[12] = { vA[0].x,vA[0].y,vA[1].x,vA[1].y,vB[0].x,vB[0].y,vB[1].x,vB[1].y,vC[0].x,vC[0].y,vC[1].x,vC[1].y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<12 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(lines) out;
layout(max_vertices=16, max_primitives=16) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[16];
} pvd;
layout (location=0) out uvec3 data[][2];
layout(location = 2) out uvec3 dataFlat[][2];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 16;
    uint maxPrimitive = 8;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = uvec3[2](uvec3(uint(n), uint(2*n), uint(4*n)), uint(3)*uvec3(uint(n), uint(2*n), uint(4*n)));
    dataFlat[vertex]      = uvec3[2](uvec3(uint(n), uint(2*n), uint(4*n)), uint(3)*uvec3(uint(n), uint(2*n), uint(4*n)));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveLineIndicesEXT[vertex] = uvec2(vertex * 2, vertex * 2 + 1u);
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 2) flat in uvec3 dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uvec3 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    uvec3 eA[2]; { const int n = 1 + (2*p); eA = uvec3[2](uvec3(uint(n), uint(2*n), uint(4*n)), uint(3)*uvec3(uint(n), uint(2*n), uint(4*n))); }
    uvec3 eB[2]; { const int n = 1 + (2*p+1); eB = uvec3[2](uvec3(uint(n), uint(2*n), uint(4*n)), uint(3)*uvec3(uint(n), uint(2*n), uint(4*n))); }
    uvec3 eC[2]; { const int n = 1 + (2*p+1); eC = uvec3[2](uvec3(uint(n), uint(2*n), uint(4*n)), uint(3)*uvec3(uint(n), uint(2*n), uint(4*n))); }

    uint e[18] = { eA[0].x,eA[0].y,eA[0].z,eA[1].x,eA[1].y,eA[1].z,eB[0].x,eB[0].y,eB[0].z,eB[1].x,eB[1].y,eB[1].z,eC[0].x,eC[0].y,eC[0].z,eC[1].x,eC[1].y,eC[1].z };
    uvec3 eFlatV[2]; { const int n = 1 + (2*p); eFlatV = uvec3[2](uvec3(uint(n), uint(2*n), uint(4*n)), uint(3)*uvec3(uint(n), uint(2*n), uint(4*n))); }
    uint eFlat[18 / 3] = { eFlatV[0].x,eFlatV[0].y,eFlatV[0].z,eFlatV[1].x,eFlatV[1].y,eFlatV[1].z };

    uvec3 vA[2]; { vA = uvec3[2](data[0][0],data[0][1]); }
    uvec3 vB[2]; { vB = uvec3[2](data[1][0],data[1][1]); }
    uvec3 vC[2]; { vC = uvec3[2](data[2][0],data[2][1]); }
    uvec3 vFlatV[2]; { vFlatV = uvec3[2](dataFlat[0],dataFlat[1]); }
    uint vFlat[18 / 3] = { vFlatV[0].x,vFlatV[0].y,vFlatV[0].z,vFlatV[1].x,vFlatV[1].y,vFlatV[1].z};

    uint v[18] = { vA[0].x,vA[0].y,vA[0].z,vA[1].x,vA[1].y,vA[1].z,vB[0].x,vB[0].y,vB[0].z,vB[1].x,vB[1].y,vB[1].z,vC[0].x,vC[0].y,vC[0].z,vC[1].x,vC[1].y,vC[1].z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<18; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<18 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out vec4 data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = vec4(float(n), float(2*n), float(4*n), float(8*n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec4 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = 2*y;
    const bool even = (p%2 == 0);

    vec4 eA; { const int n = 1 + (p); eA = vec4(float(n), float(2*n), float(4*n), float(8*n)); }
    vec4 eB; { const int n = 1 + (p+1); eB = vec4(float(n), float(2*n), float(4*n), float(8*n)); }
    vec4 eC; { const int n = 1 + (p+1); eC = vec4(float(n), float(2*n), float(4*n), float(8*n)); }

    float e[12] = { eA.x,eA.y,eA.z,eA.w,eB.x,eB.y,eB.z,eB.w,eC.x,eC.y,eC.z,eC.w };

    vec4 vA; { vA = data[0]; }
    vec4 vB; { vB = data[1]; }
    vec4 vC; { vC = data[2]; }

    float v[12] = { vA.x,vA.y,vA.z,vA.w,vB.x,vB.y,vB.z,vB.w,vC.x,vC.y,vC.z,vC.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 1) flat in vec4 dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec4 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = 2*y;
    const bool even = (p%2 == 0);

    vec4 eA; { const int n = 1 + (p); eA = vec4(float(n), float(2*n), float(4*n), float(8*n)); }
    vec4 eB; { const int n = 1 + (p+1); eB = vec4(float(n), float(2*n), float(4*n), float(8*n)); }
    vec4 eC; { const int n = 1 + (p+1); eC = vec4(float(n), float(2*n), float(4*n), float(8*n)); }

    float e[12] = { eA.x,eA.y,eA.z,eA.w,eB.x,eB.y,eB.z,eB.w,eC.x,eC.y,eC.z,eC.w };
    vec4 eFlatV; { const int n = 1 + (p); eFlatV = vec4(float(n), float(2*n), float(4*n), float(8*n)); }
    float eFlat[12 / 3] = { eFlatV.x,eFlatV.y,eFlatV.z,eFlatV.w };

    vec4 vA; { vA = data[0]; }
    vec4 vB; { vB = data[1]; }
    vec4 vC; { vC = data[2]; }
    vec4 vFlatV; { vFlatV = dataFlat; }
    float vFlat[12 / 3] = { vFlatV.x,vFlatV.y,vFlatV.z,vFlatV.w};

    float v[12] = { vA.x,vA.y,vA.z,vA.w,vB.x,vB.y,vB.z,vB.w,vC.x,vC.y,vC.z,vC.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<12 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in double data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = 2*y;
    const bool even = (p%2 == 0);

    double eA; { const int n = 1 + (p); eA = double(n); }
    double eB; { const int n = 1 + (p+1); eB = double(n); }
    double eC; { const int n = 1 + (p+1); eC = double(n); }

    double e[3] = { eA,eB,eC };

    double vA; { vA = data[0]; }
    double vB; { vB = data[1]; }
    double vC; { vC = data[2]; }

    double v[3] = { vA,vB,vC };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 1) flat in uvec3 dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uvec3 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = 2*y;
    const bool even = (p%2 == 0);

    uvec3 eA; { const int n = 1 + (p); eA = uvec3(uint(n), uint(2*n), uint(4*n)); }
    uvec3 eB; { const int n = 1 + (p+1); eB = uvec3(uint(n), uint(2*n), uint(4*n)); }
    uvec3 eC; { const int n = 1 + (p+1); eC = uvec3(uint(n), uint(2*n), uint(4*n)); }

    uint e[9] = { eA.x,eA.y,eA.z,eB.x,eB.y,eB.z,eC.x,eC.y,eC.z };
    uvec3 eFlatV; { const int n = 1 + (p); eFlatV = uvec3(uint(n), uint(2*n), uint(4*n)); }
    uint eFlat[9 / 3] = { eFlatV.x,eFlatV.y,eFlatV.z };

    uvec3 vA; { vA = data[0]; }
    uvec3 vB; { vB = data[1]; }
    uvec3 vC; { vC = data[2]; }
    uvec3 vFlatV; { vFlatV = dataFlat; }
    uint vFlat[9 / 3] = { vFlatV.x,vFlatV.y,vFlatV.z};

    uint v[9] = { vA.x,vA.y,vA.z,vB.x,vB.y,vB.z,vC.x,vC.y,vC.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<9 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {int q;};


layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = 2*y;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (p); eA = DataStruct(int(n)); }
    DataStruct eB; { const int n = 1 + (p+1); eB = DataStruct(int(n)); }
    DataStruct eC; { const int n = 1 + (p+1); eC = DataStruct(int(n)); }

    int e[3] = { eA.q,eB.q,eC.q };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }

    int v[3] = { vA.q,vB.q,vC.q };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {uvec3 q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;
layout(location = 1) out DataStruct dataFlat;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(uvec3(uint(n), uint(2*n), uint(4*n)));
    dataFlat      = DataStruct(uvec3(uint(n), uint(2*n), uint(4*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {uvec3 q;};


layout(location = 1) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = 2*y;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (p); eA = DataStruct(uvec3(uint(n), uint(2*n), uint(4*n))); }
    DataStruct eB; { const int n = 1 + (p+1); eB = DataStruct(uvec3(uint(n), uint(2*n), uint(4*n))); }
    DataStruct eC; { const int n = 1 + (p+1); eC = DataStruct(uvec3(uint(n), uint(2*n), uint(4*n))); }

    uint e[9] = { eA.q.x,eA.q.y,eA.q.z,eB.q.x,eB.q.y,eB.q.z,eC.q.x,eC.q.y,eC.q.z };
    DataStruct eFlatV; { const int n = 1 + (p); eFlatV = DataStruct(uvec3(uint(n), uint(2*n), uint(4*n))); }
    uint eFlat[9 / 3] = { eFlatV.q.x,eFlatV.q.y,eFlatV.q.z };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    uint vFlat[9 / 3] = { vFlatV.q.x,vFlatV.q.y,vFlatV.q.z};

    uint v[9] = { vA.q.x,vA.q.y,vA.q.z,vB.q.x,vB.q.y,vB.q.z,vC.q.x,vC.q.y,vC.q.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<9 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out double data[2];
layout(location = 4) out double dataFlat[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = double[2](double(n), double(3)*double(n));
    dataFlat      = double[2](double(n), double(3)*double(n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 4) flat in double dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in double data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = 2*y;
    const bool even = (p%2 == 0);

    double eA[2]; { const int n = 1 + (p); eA = double[2](double(n), double(3)*double(n)); }
    double eB[2]; { const int n = 1 + (p+1); eB = double[2](double(n), double(3)*double(n)); }
    double eC[2]; { const int n = 1 + (p+1); eC = double[2](double(n), double(3)*double(n)); }

    double e[6] = { eA[0],eA[1],eB[0],eB[1],eC[0],eC[1] };
    double eFlatV[2]; { const int n = 1 + (p); eFlatV = double[2](double(n), double(3)*double(n)); }
    double eFlat[6 / 3] = { eFlatV[0],eFlatV[1] };

    double vA[2]; { vA = double[2](data[0][0],data[0][1]); }
    double vB[2]; { vB = double[2](data[1][0],data[1][1]); }
    double vC[2]; { vC = double[2](data[2][0],data[2][1]); }
    double vFlatV[2]; { vFlatV = double[2](dataFlat[0],dataFlat[1]); }
    double vFlat[6 / 3] = { vFlatV[0],vFlatV[1]};

    double v[6] = { vA[0],vA[1],vB[0],vB[1],vC[0],vC[1] };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out dvec4 data[2];
layout(location = 4) out dvec4 dataFlat[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = dvec4[2](dvec4(double(n), double(2*n), double(4*n), double(8*n)), double(3)*dvec4(double(n), double(2*n), double(4*n), double(8*n)));
    dataFlat      = dvec4[2](dvec4(double(n), double(2*n), double(4*n), double(8*n)), double(3)*dvec4(double(n), double(2*n), double(4*n), double(8*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 4) flat in dvec4 dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec4 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = 2*y;
    const bool even = (p%2 == 0);

    dvec4 eA[2]; { const int n = 1 + (p); eA = dvec4[2](dvec4(double(n), double(2*n), double(4*n), double(8*n)), double(3)*dvec4(double(n), double(2*n), double(4*n), double(8*n))); }
    dvec4 eB[2]; { const int n = 1 + (p+1); eB = dvec4[2](dvec4(double(n), double(2*n), double(4*n), double(8*n)), double(3)*dvec4(double(n), double(2*n), double(4*n), double(8*n))); }
    dvec4 eC[2]; { const int n = 1 + (p+1); eC = dvec4[2](dvec4(double(n), double(2*n), double(4*n), double(8*n)), double(3)*dvec4(double(n), double(2*n), double(4*n), double(8*n))); }

    double e[24] = { eA[0].x,eA[0].y,eA[0].z,eA[0].w,eA[1].x,eA[1].y,eA[1].z,eA[1].w,eB[0].x,eB[0].y,eB[0].z,eB[0].w,eB[1].x,eB[1].y,eB[1].z,eB[1].w,eC[0].x,eC[0].y,eC[0].z,eC[0].w,eC[1].x,eC[1].y,eC[1].z,eC[1].w };
    dvec4 eFlatV[2]; { const int n = 1 + (p); eFlatV = dvec4[2](dvec4(double(n), double(2*n), double(4*n), double(8*n)), double(3)*dvec4(double(n), double(2*n), double(4*n), double(8*n))); }
    double eFlat[24 / 3] = { eFlatV[0].x,eFlatV[0].y,eFlatV[0].z,eFlatV[0].w,eFlatV[1].x,eFlatV[1].y,eFlatV[1].z,eFlatV[1].w };

    dvec4 vA[2]; { vA = dvec4[2](data[0][0],data[0][1]); }
    dvec4 vB[2]; { vB = dvec4[2](data[1][0],data[1][1]); }
    dvec4 vC[2]; { vC = dvec4[2](data[2][0],data[2][1]); }
    dvec4 vFlatV[2]; { vFlatV = dvec4[2](dataFlat[0],dataFlat[1]); }
    double vFlat[24 / 3] = { vFlatV[0].x,vFlatV[0].y,vFlatV[0].z,vFlatV[0].w,vFlatV[1].x,vFlatV[1].y,vFlatV[1].z,vFlatV[1].w};

    double v[24] = { vA[0].x,vA[0].y,vA[0].z,vA[0].w,vA[1].x,vA[1].y,vA[1].z,vA[1].w,vB[0].x,vB[0].y,vB[0].z,vB[0].w,vB[1].x,vB[1].y,vB[1].z,vB[1].w,vC[0].x,vC[0].y,vC[0].z,vC[0].w,vC[1].x,vC[1].y,vC[1].z,vC[1].w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<24; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<24 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out ivec2 data[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = ivec2[2](ivec2(int(n), int(2*n)), int(3)*ivec2(int(n), int(2*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in ivec2 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = 2*y;
    const bool even = (p%2 == 0);

    ivec2 eA[2]; { const int n = 1 + (p); eA = ivec2[2](ivec2(int(n), int(2*n)), int(3)*ivec2(int(n), int(2*n))); }
    ivec2 eB[2]; { const int n = 1 + (p+1); eB = ivec2[2](ivec2(int(n), int(2*n)), int(3)*ivec2(int(n), int(2*n))); }
    ivec2 eC[2]; { const int n = 1 + (p+1); eC = ivec2[2](ivec2(int(n), int(2*n)), int(3)*ivec2(int(n), int(2*n))); }

    int e[12] = { eA[0].x,eA[0].y,eA[1].x,eA[1].y,eB[0].x,eB[0].y,eB[1].x,eB[1].y,eC[0].x,eC[0].y,eC[1].x,eC[1].y };

    ivec2 vA[2]; { vA = ivec2[2](data[0][0],data[0][1]); }
    ivec2 vB[2]; { vB = ivec2[2](data[1][0],data[1][1]); }
    ivec2 vC[2]; { vC = ivec2[2](data[2][0],data[2][1]); }

    int v[12] = { vA[0].x,vA[0].y,vA[1].x,vA[1].y,vB[0].x,vB[0].y,vB[1].x,vB[1].y,vC[0].x,vC[0].y,vC[1].x,vC[1].y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out uvec2 data[2];
layout(location = 2) out uvec2 dataFlat[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = uvec2[2](uvec2(uint(n), uint(2*n)), uint(3)*uvec2(uint(n), uint(2*n)));
    dataFlat      = uvec2[2](uvec2(uint(n), uint(2*n)), uint(3)*uvec2(uint(n), uint(2*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 2) flat in uvec2 dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uvec2 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = 2*y;
    const bool even = (p%2 == 0);

    uvec2 eA[2]; { const int n = 1 + (p); eA = uvec2[2](uvec2(uint(n), uint(2*n)), uint(3)*uvec2(uint(n), uint(2*n))); }
    uvec2 eB[2]; { const int n = 1 + (p+1); eB = uvec2[2](uvec2(uint(n), uint(2*n)), uint(3)*uvec2(uint(n), uint(2*n))); }
    uvec2 eC[2]; { const int n = 1 + (p+1); eC = uvec2[2](uvec2(uint(n), uint(2*n)), uint(3)*uvec2(uint(n), uint(2*n))); }

    uint e[12] = { eA[0].x,eA[0].y,eA[1].x,eA[1].y,eB[0].x,eB[0].y,eB[1].x,eB[1].y,eC[0].x,eC[0].y,eC[1].x,eC[1].y };
    uvec2 eFlatV[2]; { const int n = 1 + (p); eFlatV = uvec2[2](uvec2(uint(n), uint(2*n)), uint(3)*uvec2(uint(n), uint(2*n))); }
    uint eFlat[12 / 3] = { eFlatV[0].x,eFlatV[0].y,eFlatV[1].x,eFlatV[1].y };

    uvec2 vA[2]; { vA = uvec2[2](data[0][0],data[0][1]); }
    uvec2 vB[2]; { vB = uvec2[2](data[1][0],data[1][1]); }
    uvec2 vC[2]; { vC = uvec2[2](data[2][0],data[2][1]); }
    uvec2 vFlatV[2]; { vFlatV = uvec2[2](dataFlat[0],dataFlat[1]); }
    uint vFlat[12 / 3] = { vFlatV[0].x,vFlatV[0].y,vFlatV[1].x,vFlatV[1].y};

    uint v[12] = { vA[0].x,vA[0].y,vA[1].x,vA[1].y,vB[0].x,vB[0].y,vB[1].x,vB[1].y,vC[0].x,vC[0].y,vC[1].x,vC[1].y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<12 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(triangles) out;
layout(max_vertices=6, max_primitives=6) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[6];
} pvd;
layout (location=0) out float data[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 6;
    uint maxPrimitive = 2;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    const uvec3 indices[2] = uvec3[](
        uvec3(0, 1, 2),
        uvec3(3, 4, 5)
    );
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = float(n);
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveTriangleIndicesEXT[primitive] = indices[primitive];
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in float data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    float eA; { const int n = 1 + (3*p); eA = float(n); }
    float eB; { const int n = 1 + (3*p+1); eB = float(n); }
    float eC; { const int n = 1 + (3*p+2); eC = float(n); }

    float e[3] = { eA,eB,eC };

    float vA; { vA = data[0]; }
    float vB; { vB = data[1]; }
    float vC; { vC = data[2]; }

    float v[3] = { vA,vB,vC };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out float data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = float(n);
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(triangles) out;
layout(max_vertices=6, max_primitives=6) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[6];
} pvd;
layout (location=0) out vec3 data[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 6;
    uint maxPrimitive = 2;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    const uvec3 indices[2] = uvec3[](
        uvec3(0, 1, 2),
        uvec3(3, 4, 5)
    );
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = vec3(float(n), float(2*n), float(4*n));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveTriangleIndicesEXT[primitive] = indices[primitive];
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec3 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    vec3 eA; { const int n = 1 + (3*p); eA = vec3(float(n), float(2*n), float(4*n)); }
    vec3 eB; { const int n = 1 + (3*p+1); eB = vec3(float(n), float(2*n), float(4*n)); }
    vec3 eC; { const int n = 1 + (3*p+2); eC = vec3(float(n), float(2*n), float(4*n)); }

    float e[9] = { eA.x,eA.y,eA.z,eB.x,eB.y,eB.z,eC.x,eC.y,eC.z };

    vec3 vA; { vA = data[0]; }
    vec3 vB; { vB = data[1]; }
    vec3 vC; { vC = data[2]; }

    float v[9] = { vA.x,vA.y,vA.z,vB.x,vB.y,vB.z,vC.x,vC.y,vC.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(triangles) out;
layout(max_vertices=6, max_primitives=6) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[6];
} pvd;
layout (location=0) out vec4 data[];
layout(location = 1) out vec4 dataFlat[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 6;
    uint maxPrimitive = 2;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    const uvec3 indices[2] = uvec3[](
        uvec3(0, 1, 2),
        uvec3(3, 4, 5)
    );
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = vec4(float(n), float(2*n), float(4*n), float(8*n));
    dataFlat[vertex]      = vec4(float(n), float(2*n), float(4*n), float(8*n));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveTriangleIndicesEXT[primitive] = indices[primitive];
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 1) flat in vec4 dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec4 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    vec4 eA; { const int n = 1 + (3*p); eA = vec4(float(n), float(2*n), float(4*n), float(8*n)); }
    vec4 eB; { const int n = 1 + (3*p+1); eB = vec4(float(n), float(2*n), float(4*n), float(8*n)); }
    vec4 eC; { const int n = 1 + (3*p+2); eC = vec4(float(n), float(2*n), float(4*n), float(8*n)); }

    float e[12] = { eA.x,eA.y,eA.z,eA.w,eB.x,eB.y,eB.z,eB.w,eC.x,eC.y,eC.z,eC.w };
    vec4 eFlatV; { const int n = 1 + (3*p); eFlatV = vec4(float(n), float(2*n), float(4*n), float(8*n)); }
    float eFlat[12 / 3] = { eFlatV.x,eFlatV.y,eFlatV.z,eFlatV.w };

    vec4 vA; { vA = data[0]; }
    vec4 vB; { vB = data[1]; }
    vec4 vC; { vC = data[2]; }
    vec4 vFlatV; { vFlatV = dataFlat; }
    float vFlat[12 / 3] = { vFlatV.x,vFlatV.y,vFlatV.z,vFlatV.w};

    float v[12] = { vA.x,vA.y,vA.z,vA.w,vB.x,vB.y,vB.z,vB.w,vC.x,vC.y,vC.z,vC.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<12 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out dvec2 data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = dvec2(double(n), double(2*n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec2 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    dvec2 eA; { const int n = 1 + (3*p); eA = dvec2(double(n), double(2*n)); }
    dvec2 eB; { const int n = 1 + (3*p+1); eB = dvec2(double(n), double(2*n)); }
    dvec2 eC; { const int n = 1 + (3*p+2); eC = dvec2(double(n), double(2*n)); }

    double e[6] = { eA.x,eA.y,eB.x,eB.y,eC.x,eC.y };

    dvec2 vA; { vA = data[0]; }
    dvec2 vB; { vB = data[1]; }
    dvec2 vC; { vC = data[2]; }

    double v[6] = { vA.x,vA.y,vB.x,vB.y,vC.x,vC.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out dvec3 data;
layout(location = 2) out dvec3 dataFlat;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = dvec3(double(n), double(2*n), double(4*n));
    dataFlat      = dvec3(double(n), double(2*n), double(4*n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 2) flat in dvec3 dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec3 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    dvec3 eA; { const int n = 1 + (3*p); eA = dvec3(double(n), double(2*n), double(4*n)); }
    dvec3 eB; { const int n = 1 + (3*p+1); eB = dvec3(double(n), double(2*n), double(4*n)); }
    dvec3 eC; { const int n = 1 + (3*p+2); eC = dvec3(double(n), double(2*n), double(4*n)); }

    double e[9] = { eA.x,eA.y,eA.z,eB.x,eB.y,eB.z,eC.x,eC.y,eC.z };
    dvec3 eFlatV; { const int n = 1 + (3*p); eFlatV = dvec3(double(n), double(2*n), double(4*n)); }
    double eFlat[9 / 3] = { eFlatV.x,eFlatV.y,eFlatV.z };

    dvec3 vA; { vA = data[0]; }
    dvec3 vB; { vB = data[1]; }
    dvec3 vC; { vC = data[2]; }
    dvec3 vFlatV; { vFlatV = dataFlat; }
    double vFlat[9 / 3] = { vFlatV.x,vFlatV.y,vFlatV.z};

    double v[9] = { vA.x,vA.y,vA.z,vB.x,vB.y,vB.z,vC.x,vC.y,vC.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<9 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(triangles) out;
layout(max_vertices=6, max_primitives=6) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[6];
} pvd;
layout (location=0) out ivec2 data[];
layout(location = 1) out ivec2 dataFlat[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 6;
    uint maxPrimitive = 2;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    const uvec3 indices[2] = uvec3[](
        uvec3(0, 1, 2),
        uvec3(3, 4, 5)
    );
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = ivec2(int(n), int(2*n));
    dataFlat[vertex]      = ivec2(int(n), int(2*n));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveTriangleIndicesEXT[primitive] = indices[primitive];
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 1) flat in ivec2 dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in ivec2 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    ivec2 eA; { const int n = 1 + (3*p); eA = ivec2(int(n), int(2*n)); }
    ivec2 eB; { const int n = 1 + (3*p+1); eB = ivec2(int(n), int(2*n)); }
    ivec2 eC; { const int n = 1 + (3*p+2); eC = ivec2(int(n), int(2*n)); }

    int e[6] = { eA.x,eA.y,eB.x,eB.y,eC.x,eC.y };
    ivec2 eFlatV; { const int n = 1 + (3*p); eFlatV = ivec2(int(n), int(2*n)); }
    int eFlat[6 / 3] = { eFlatV.x,eFlatV.y };

    ivec2 vA; { vA = data[0]; }
    ivec2 vB; { vB = data[1]; }
    ivec2 vC; { vC = data[2]; }
    ivec2 vFlatV; { vFlatV = dataFlat; }
    int vFlat[6 / 3] = { vFlatV.x,vFlatV.y};

    int v[6] = { vA.x,vA.y,vB.x,vB.y,vC.x,vC.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(triangles) out;
layout(max_vertices=6, max_primitives=6) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[6];
} pvd;
layout (location=0) out uvec3 data[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 6;
    uint maxPrimitive = 2;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    const uvec3 indices[2] = uvec3[](
        uvec3(0, 1, 2),
        uvec3(3, 4, 5)
    );
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = uvec3(uint(n), uint(2*n), uint(4*n));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveTriangleIndicesEXT[primitive] = indices[primitive];
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uvec3 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    uvec3 eA; { const int n = 1 + (3*p); eA = uvec3(uint(n), uint(2*n), uint(4*n)); }
    uvec3 eB; { const int n = 1 + (3*p+1); eB = uvec3(uint(n), uint(2*n), uint(4*n)); }
    uvec3 eC; { const int n = 1 + (3*p+2); eC = uvec3(uint(n), uint(2*n), uint(4*n)); }

    uint e[9] = { eA.x,eA.y,eA.z,eB.x,eB.y,eB.z,eC.x,eC.y,eC.z };

    uvec3 vA; { vA = data[0]; }
    uvec3 vB; { vB = data[1]; }
    uvec3 vC; { vC = data[2]; }

    uint v[9] = { vA.x,vA.y,vA.z,vB.x,vB.y,vB.z,vC.x,vC.y,vC.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable

struct DataStruct {float q;};
layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(triangles) out;
layout(max_vertices=6, max_primitives=6) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[6];
} pvd;
layout (location=0) out DataStruct data[];
layout(location = 1) out DataStruct dataFlat[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 6;
    uint maxPrimitive = 2;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    const uvec3 indices[2] = uvec3[](
        uvec3(0, 1, 2),
        uvec3(3, 4, 5)
    );
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = DataStruct(float(n));
    dataFlat[vertex]      = DataStruct(float(n));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveTriangleIndicesEXT[primitive] = indices[primitive];
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {float q;};


layout(location = 1) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(float(n)); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(float(n)); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(float(n)); }

    float e[3] = { eA.q,eB.q,eC.q };
    DataStruct eFlatV; { const int n = 1 + (3*p); eFlatV = DataStruct(float(n)); }
    float eFlat[3 / 3] = { eFlatV.q };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    float vFlat[3 / 3] = { vFlatV.q};

    float v[3] = { vA.q,vB.q,vC.q };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<3 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec4 q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(vec4(float(n), float(2*n), float(4*n), float(8*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec4 q;};


layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(vec4(float(n), float(2*n), float(4*n), float(8*n))); }

    float e[12] = { eA.q.x,eA.q.y,eA.q.z,eA.q.w,eB.q.x,eB.q.y,eB.q.z,eB.q.w,eC.q.x,eC.q.y,eC.q.z,eC.q.w };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }

    float v[12] = { vA.q.x,vA.q.y,vA.q.z,vA.q.w,vB.q.x,vB.q.y,vB.q.z,vB.q.w,vC.q.x,vC.q.y,vC.q.z,vC.q.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec4 q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;
layout(location = 1) out DataStruct dataFlat;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(vec4(float(n), float(2*n), float(4*n), float(8*n)));
    dataFlat      = DataStruct(vec4(float(n), float(2*n), float(4*n), float(8*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec4 q;};


layout(location = 1) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(vec4(float(n), float(2*n), float(4*n), float(8*n))); }

    float e[12] = { eA.q.x,eA.q.y,eA.q.z,eA.q.w,eB.q.x,eB.q.y,eB.q.z,eB.q.w,eC.q.x,eC.q.y,eC.q.z,eC.q.w };
    DataStruct eFlatV; { const int n = 1 + (3*p); eFlatV = DataStruct(vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    float eFlat[12 / 3] = { eFlatV.q.x,eFlatV.q.y,eFlatV.q.z,eFlatV.q.w };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    float vFlat[12 / 3] = { vFlatV.q.x,vFlatV.q.y,vFlatV.q.z,vFlatV.q.w};

    float v[12] = { vA.q.x,vA.q.y,vA.q.z,vA.q.w,vB.q.x,vB.q.y,vB.q.z,vB.q.w,vC.q.x,vC.q.y,vC.q.z,vC.q.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<12 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {double q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;
layout(location = 2) out DataStruct dataFlat;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(double(n));
    dataFlat      = DataStruct(double(n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {double q;};


layout(location = 2) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(double(n)); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(double(n)); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(double(n)); }

    double e[3] = { eA.q,eB.q,eC.q };
    DataStruct eFlatV; { const int n = 1 + (3*p); eFlatV = DataStruct(double(n)); }
    double eFlat[3 / 3] = { eFlatV.q };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    double vFlat[3 / 3] = { vFlatV.q};

    double v[3] = { vA.q,vB.q,vC.q };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<3 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable

struct DataStruct {dvec3 q;};
layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(triangles) out;
layout(max_vertices=6, max_primitives=6) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[6];
} pvd;
layout (location=0) out DataStruct data[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 6;
    uint maxPrimitive = 2;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    const uvec3 indices[2] = uvec3[](
        uvec3(0, 1, 2),
        uvec3(3, 4, 5)
    );
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = DataStruct(dvec3(double(n), double(2*n), double(4*n)));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveTriangleIndicesEXT[primitive] = indices[primitive];
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {dvec3 q;};


layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(dvec3(double(n), double(2*n), double(4*n))); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(dvec3(double(n), double(2*n), double(4*n))); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(dvec3(double(n), double(2*n), double(4*n))); }

    double e[9] = { eA.q.x,eA.q.y,eA.q.z,eB.q.x,eB.q.y,eB.q.z,eC.q.x,eC.q.y,eC.q.z };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }

    double v[9] = { vA.q.x,vA.q.y,vA.q.z,vB.q.x,vB.q.y,vB.q.z,vC.q.x,vC.q.y,vC.q.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable

struct DataStruct {dvec3 q;};
layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(triangles) out;
layout(max_vertices=6, max_primitives=6) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[6];
} pvd;
layout (location=0) out DataStruct data[];
layout(location = 2) out DataStruct dataFlat[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 6;
    uint maxPrimitive = 2;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    const uvec3 indices[2] = uvec3[](
        uvec3(0, 1, 2),
        uvec3(3, 4, 5)
    );
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = DataStruct(dvec3(double(n), double(2*n), double(4*n)));
    dataFlat[vertex]      = DataStruct(dvec3(double(n), double(2*n), double(4*n)));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveTriangleIndicesEXT[primitive] = indices[primitive];
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {dvec3 q;};


layout(location = 2) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(dvec3(double(n), double(2*n), double(4*n))); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(dvec3(double(n), double(2*n), double(4*n))); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(dvec3(double(n), double(2*n), double(4*n))); }

    double e[9] = { eA.q.x,eA.q.y,eA.q.z,eB.q.x,eB.q.y,eB.q.z,eC.q.x,eC.q.y,eC.q.z };
    DataStruct eFlatV; { const int n = 1 + (3*p); eFlatV = DataStruct(dvec3(double(n), double(2*n), double(4*n))); }
    double eFlat[9 / 3] = { eFlatV.q.x,eFlatV.q.y,eFlatV.q.z };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    double vFlat[9 / 3] = { vFlatV.q.x,vFlatV.q.y,vFlatV.q.z};

    double v[9] = { vA.q.x,vA.q.y,vA.q.z,vB.q.x,vB.q.y,vB.q.z,vC.q.x,vC.q.y,vC.q.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<9 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {dvec4 q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(dvec4(double(n), double(2*n), double(4*n), double(8*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {dvec4 q;};


layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(dvec4(double(n), double(2*n), double(4*n), double(8*n))); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(dvec4(double(n), double(2*n), double(4*n), double(8*n))); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(dvec4(double(n), double(2*n), double(4*n), double(8*n))); }

    double e[12] = { eA.q.x,eA.q.y,eA.q.z,eA.q.w,eB.q.x,eB.q.y,eB.q.z,eB.q.w,eC.q.x,eC.q.y,eC.q.z,eC.q.w };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }

    double v[12] = { vA.q.x,vA.q.y,vA.q.z,vA.q.w,vB.q.x,vB.q.y,vB.q.z,vB.q.w,vC.q.x,vC.q.y,vC.q.z,vC.q.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable

struct DataStruct {int q;};
layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(triangles) out;
layout(max_vertices=6, max_primitives=6) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[6];
} pvd;
layout (location=0) out DataStruct data[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 6;
    uint maxPrimitive = 2;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    const uvec3 indices[2] = uvec3[](
        uvec3(0, 1, 2),
        uvec3(3, 4, 5)
    );
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = DataStruct(int(n));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveTriangleIndicesEXT[primitive] = indices[primitive];
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {int q;};


layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(int(n)); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(int(n)); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(int(n)); }

    int e[3] = { eA.q,eB.q,eC.q };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }

    int v[3] = { vA.q,vB.q,vC.q };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable

struct DataStruct {ivec4 q;};
layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(triangles) out;
layout(max_vertices=6, max_primitives=6) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[6];
} pvd;
layout (location=0) out DataStruct data[];
layout(location = 1) out DataStruct dataFlat[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 6;
    uint maxPrimitive = 2;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    const uvec3 indices[2] = uvec3[](
        uvec3(0, 1, 2),
        uvec3(3, 4, 5)
    );
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = DataStruct(ivec4(int(n), int(2*n), int(4*n), int(8*n)));
    dataFlat[vertex]      = DataStruct(ivec4(int(n), int(2*n), int(4*n), int(8*n)));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveTriangleIndicesEXT[primitive] = indices[primitive];
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {ivec4 q;};


layout(location = 1) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(ivec4(int(n), int(2*n), int(4*n), int(8*n))); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(ivec4(int(n), int(2*n), int(4*n), int(8*n))); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(ivec4(int(n), int(2*n), int(4*n), int(8*n))); }

    int e[12] = { eA.q.x,eA.q.y,eA.q.z,eA.q.w,eB.q.x,eB.q.y,eB.q.z,eB.q.w,eC.q.x,eC.q.y,eC.q.z,eC.q.w };
    DataStruct eFlatV; { const int n = 1 + (3*p); eFlatV = DataStruct(ivec4(int(n), int(2*n), int(4*n), int(8*n))); }
    int eFlat[12 / 3] = { eFlatV.q.x,eFlatV.q.y,eFlatV.q.z,eFlatV.q.w };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    int vFlat[12 / 3] = { vFlatV.q.x,vFlatV.q.y,vFlatV.q.z,vFlatV.q.w};

    int v[12] = { vA.q.x,vA.q.y,vA.q.z,vA.q.w,vB.q.x,vB.q.y,vB.q.z,vB.q.w,vC.q.x,vC.q.y,vC.q.z,vC.q.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<12 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {ivec4 q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;
layout(location = 1) out DataStruct dataFlat;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(ivec4(int(n), int(2*n), int(4*n), int(8*n)));
    dataFlat      = DataStruct(ivec4(int(n), int(2*n), int(4*n), int(8*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_mesh_shader : enable

struct DataStruct {uint q;};
layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(triangles) out;
layout(max_vertices=6, max_primitives=6) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[6];
} pvd;
layout (location=0) out DataStruct data[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 6;
    uint maxPrimitive = 2;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    const uvec3 indices[2] = uvec3[](
        uvec3(0, 1, 2),
        uvec3(3, 4, 5)
    );
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = DataStruct(uint(n));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveTriangleIndicesEXT[primitive] = indices[primitive];
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {uint q;};


layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(uint(n)); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(uint(n)); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(uint(n)); }

    uint e[3] = { eA.q,eB.q,eC.q };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }

    uint v[3] = { vA.q,vB.q,vC.q };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {uvec3 q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(uvec3(uint(n), uint(2*n), uint(4*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {uvec3 q;};


layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(uvec3(uint(n), uint(2*n), uint(4*n))); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(uvec3(uint(n), uint(2*n), uint(4*n))); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(uvec3(uint(n), uint(2*n), uint(4*n))); }

    uint e[9] = { eA.q.x,eA.q.y,eA.q.z,eB.q.x,eB.q.y,eB.q.z,eC.q.x,eC.q.y,eC.q.z };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }

    uint v[9] = { vA.q.x,vA.q.y,vA.q.z,vB.q.x,vB.q.y,vB.q.z,vC.q.x,vC.q.y,vC.q.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out vec2 data[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = vec2[2](vec2(float(n), float(2*n)), float(3)*vec2(float(n), float(2*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec2 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    vec2 eA[2]; { const int n = 1 + (3*p); eA = vec2[2](vec2(float(n), float(2*n)), float(3)*vec2(float(n), float(2*n))); }
    vec2 eB[2]; { const int n = 1 + (3*p+1); eB = vec2[2](vec2(float(n), float(2*n)), float(3)*vec2(float(n), float(2*n))); }
    vec2 eC[2]; { const int n = 1 + (3*p+2); eC = vec2[2](vec2(float(n), float(2*n)), float(3)*vec2(float(n), float(2*n))); }

    float e[12] = { eA[0].x,eA[0].y,eA[1].x,eA[1].y,eB[0].x,eB[0].y,eB[1].x,eB[1].y,eC[0].x,eC[0].y,eC[1].x,eC[1].y };

    vec2 vA[2]; { vA = vec2[2](data[0][0],data[0][1]); }
    vec2 vB[2]; { vB = vec2[2](data[1][0],data[1][1]); }
    vec2 vC[2]; { vC = vec2[2](data[2][0],data[2][1]); }

    float v[12] = { vA[0].x,vA[0].y,vA[1].x,vA[1].y,vB[0].x,vB[0].y,vB[1].x,vB[1].y,vC[0].x,vC[0].y,vC[1].x,vC[1].y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(triangles) out;
layout(max_vertices=6, max_primitives=6) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[6];
} pvd;
layout (location=0) out vec3 data[][2];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 6;
    uint maxPrimitive = 2;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    const uvec3 indices[2] = uvec3[](
        uvec3(0, 1, 2),
        uvec3(3, 4, 5)
    );
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n)));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveTriangleIndicesEXT[primitive] = indices[primitive];
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec3 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    vec3 eA[2]; { const int n = 1 + (3*p); eA = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n))); }
    vec3 eB[2]; { const int n = 1 + (3*p+1); eB = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n))); }
    vec3 eC[2]; { const int n = 1 + (3*p+2); eC = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n))); }

    float e[18] = { eA[0].x,eA[0].y,eA[0].z,eA[1].x,eA[1].y,eA[1].z,eB[0].x,eB[0].y,eB[0].z,eB[1].x,eB[1].y,eB[1].z,eC[0].x,eC[0].y,eC[0].z,eC[1].x,eC[1].y,eC[1].z };

    vec3 vA[2]; { vA = vec3[2](data[0][0],data[0][1]); }
    vec3 vB[2]; { vB = vec3[2](data[1][0],data[1][1]); }
    vec3 vC[2]; { vC = vec3[2](data[2][0],data[2][1]); }

    float v[18] = { vA[0].x,vA[0].y,vA[0].z,vA[1].x,vA[1].y,vA[1].z,vB[0].x,vB[0].y,vB[0].z,vB[1].x,vB[1].y,vB[1].z,vC[0].x,vC[0].y,vC[0].z,vC[1].x,vC[1].y,vC[1].z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<18; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(triangles) out;
layout(max_vertices=6, max_primitives=6) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[6];
} pvd;
layout (location=0) out dvec2 data[][2];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 6;
    uint maxPrimitive = 2;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    const uvec3 indices[2] = uvec3[](
        uvec3(0, 1, 2),
        uvec3(3, 4, 5)
    );
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = dvec2[2](dvec2(double(n), double(2*n)), double(3)*dvec2(double(n), double(2*n)));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveTriangleIndicesEXT[primitive] = indices[primitive];
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec2 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    dvec2 eA[2]; { const int n = 1 + (3*p); eA = dvec2[2](dvec2(double(n), double(2*n)), double(3)*dvec2(double(n), double(2*n))); }
    dvec2 eB[2]; { const int n = 1 + (3*p+1); eB = dvec2[2](dvec2(double(n), double(2*n)), double(3)*dvec2(double(n), double(2*n))); }
    dvec2 eC[2]; { const int n = 1 + (3*p+2); eC = dvec2[2](dvec2(double(n), double(2*n)), double(3)*dvec2(double(n), double(2*n))); }

    double e[12] = { eA[0].x,eA[0].y,eA[1].x,eA[1].y,eB[0].x,eB[0].y,eB[1].x,eB[1].y,eC[0].x,eC[0].y,eC[1].x,eC[1].y };

    dvec2 vA[2]; { vA = dvec2[2](data[0][0],data[0][1]); }
    dvec2 vB[2]; { vB = dvec2[2](data[1][0],data[1][1]); }
    dvec2 vC[2]; { vC = dvec2[2](data[2][0],data[2][1]); }

    double v[12] = { vA[0].x,vA[0].y,vA[1].x,vA[1].y,vB[0].x,vB[0].y,vB[1].x,vB[1].y,vC[0].x,vC[0].y,vC[1].x,vC[1].y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(triangles) out;
layout(max_vertices=6, max_primitives=6) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[6];
} pvd;
layout (location=0) out dvec2 data[][2];
layout(location = 4) out dvec2 dataFlat[][2];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 6;
    uint maxPrimitive = 2;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    const uvec3 indices[2] = uvec3[](
        uvec3(0, 1, 2),
        uvec3(3, 4, 5)
    );
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = dvec2[2](dvec2(double(n), double(2*n)), double(3)*dvec2(double(n), double(2*n)));
    dataFlat[vertex]      = dvec2[2](dvec2(double(n), double(2*n)), double(3)*dvec2(double(n), double(2*n)));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveTriangleIndicesEXT[primitive] = indices[primitive];
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 4) flat in dvec2 dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec2 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    dvec2 eA[2]; { const int n = 1 + (3*p); eA = dvec2[2](dvec2(double(n), double(2*n)), double(3)*dvec2(double(n), double(2*n))); }
    dvec2 eB[2]; { const int n = 1 + (3*p+1); eB = dvec2[2](dvec2(double(n), double(2*n)), double(3)*dvec2(double(n), double(2*n))); }
    dvec2 eC[2]; { const int n = 1 + (3*p+2); eC = dvec2[2](dvec2(double(n), double(2*n)), double(3)*dvec2(double(n), double(2*n))); }

    double e[12] = { eA[0].x,eA[0].y,eA[1].x,eA[1].y,eB[0].x,eB[0].y,eB[1].x,eB[1].y,eC[0].x,eC[0].y,eC[1].x,eC[1].y };
    dvec2 eFlatV[2]; { const int n = 1 + (3*p); eFlatV = dvec2[2](dvec2(double(n), double(2*n)), double(3)*dvec2(double(n), double(2*n))); }
    double eFlat[12 / 3] = { eFlatV[0].x,eFlatV[0].y,eFlatV[1].x,eFlatV[1].y };

    dvec2 vA[2]; { vA = dvec2[2](data[0][0],data[0][1]); }
    dvec2 vB[2]; { vB = dvec2[2](data[1][0],data[1][1]); }
    dvec2 vC[2]; { vC = dvec2[2](data[2][0],data[2][1]); }
    dvec2 vFlatV[2]; { vFlatV = dvec2[2](dataFlat[0],dataFlat[1]); }
    double vFlat[12 / 3] = { vFlatV[0].x,vFlatV[0].y,vFlatV[1].x,vFlatV[1].y};

    double v[12] = { vA[0].x,vA[0].y,vA[1].x,vA[1].y,vB[0].x,vB[0].y,vB[1].x,vB[1].y,vC[0].x,vC[0].y,vC[1].x,vC[1].y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<12 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out dvec3 data[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec3 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    dvec3 eA[2]; { const int n = 1 + (3*p); eA = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n))); }
    dvec3 eB[2]; { const int n = 1 + (3*p+1); eB = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n))); }
    dvec3 eC[2]; { const int n = 1 + (3*p+2); eC = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n))); }

    double e[18] = { eA[0].x,eA[0].y,eA[0].z,eA[1].x,eA[1].y,eA[1].z,eB[0].x,eB[0].y,eB[0].z,eB[1].x,eB[1].y,eB[1].z,eC[0].x,eC[0].y,eC[0].z,eC[1].x,eC[1].y,eC[1].z };

    dvec3 vA[2]; { vA = dvec3[2](data[0][0],data[0][1]); }
    dvec3 vB[2]; { vB = dvec3[2](data[1][0],data[1][1]); }
    dvec3 vC[2]; { vC = dvec3[2](data[2][0],data[2][1]); }

    double v[18] = { vA[0].x,vA[0].y,vA[0].z,vA[1].x,vA[1].y,vA[1].z,vB[0].x,vB[0].y,vB[0].z,vB[1].x,vB[1].y,vB[1].z,vC[0].x,vC[0].y,vC[0].z,vC[1].x,vC[1].y,vC[1].z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<18; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out int data[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = int[2](int(n), int(3)*int(n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in int data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    int eA[2]; { const int n = 1 + (3*p); eA = int[2](int(n), int(3)*int(n)); }
    int eB[2]; { const int n = 1 + (3*p+1); eB = int[2](int(n), int(3)*int(n)); }
    int eC[2]; { const int n = 1 + (3*p+2); eC = int[2](int(n), int(3)*int(n)); }

    int e[6] = { eA[0],eA[1],eB[0],eB[1],eC[0],eC[1] };

    int vA[2]; { vA = int[2](data[0][0],data[0][1]); }
    int vB[2]; { vB = int[2](data[1][0],data[1][1]); }
    int vC[2]; { vC = int[2](data[2][0],data[2][1]); }

    int v[6] = { vA[0],vA[1],vB[0],vB[1],vC[0],vC[1] };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out int data[2];
layout(location = 2) out int dataFlat[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = int[2](int(n), int(3)*int(n));
    dataFlat      = int[2](int(n), int(3)*int(n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 2) flat in int dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in int data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    int eA[2]; { const int n = 1 + (3*p); eA = int[2](int(n), int(3)*int(n)); }
    int eB[2]; { const int n = 1 + (3*p+1); eB = int[2](int(n), int(3)*int(n)); }
    int eC[2]; { const int n = 1 + (3*p+2); eC = int[2](int(n), int(3)*int(n)); }

    int e[6] = { eA[0],eA[1],eB[0],eB[1],eC[0],eC[1] };
    int eFlatV[2]; { const int n = 1 + (3*p); eFlatV = int[2](int(n), int(3)*int(n)); }
    int eFlat[6 / 3] = { eFlatV[0],eFlatV[1] };

    int vA[2]; { vA = int[2](data[0][0],data[0][1]); }
    int vB[2]; { vB = int[2](data[1][0],data[1][1]); }
    int vC[2]; { vC = int[2](data[2][0],data[2][1]); }
    int vFlatV[2]; { vFlatV = int[2](dataFlat[0],dataFlat[1]); }
    int vFlat[6 / 3] = { vFlatV[0],vFlatV[1]};

    int v[6] = { vA[0],vA[1],vB[0],vB[1],vC[0],vC[1] };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(triangles) out;
layout(max_vertices=6, max_primitives=6) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[6];
} pvd;
layout (location=0) out ivec4 data[][2];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 6;
    uint maxPrimitive = 2;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    const uvec3 indices[2] = uvec3[](
        uvec3(0, 1, 2),
        uvec3(3, 4, 5)
    );
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n)));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveTriangleIndicesEXT[primitive] = indices[primitive];
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in ivec4 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    ivec4 eA[2]; { const int n = 1 + (3*p); eA = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n))); }
    ivec4 eB[2]; { const int n = 1 + (3*p+1); eB = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n))); }
    ivec4 eC[2]; { const int n = 1 + (3*p+2); eC = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n))); }

    int e[24] = { eA[0].x,eA[0].y,eA[0].z,eA[0].w,eA[1].x,eA[1].y,eA[1].z,eA[1].w,eB[0].x,eB[0].y,eB[0].z,eB[0].w,eB[1].x,eB[1].y,eB[1].z,eB[1].w,eC[0].x,eC[0].y,eC[0].z,eC[0].w,eC[1].x,eC[1].y,eC[1].z,eC[1].w };

    ivec4 vA[2]; { vA = ivec4[2](data[0][0],data[0][1]); }
    ivec4 vB[2]; { vB = ivec4[2](data[1][0],data[1][1]); }
    ivec4 vC[2]; { vC = ivec4[2](data[2][0],data[2][1]); }

    int v[24] = { vA[0].x,vA[0].y,vA[0].z,vA[0].w,vA[1].x,vA[1].y,vA[1].z,vA[1].w,vB[0].x,vB[0].y,vB[0].z,vB[0].w,vB[1].x,vB[1].y,vB[1].z,vB[1].w,vC[0].x,vC[0].y,vC[0].z,vC[0].w,vC[1].x,vC[1].y,vC[1].z,vC[1].w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<24; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out uvec4 data[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = uvec4[2](uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)), uint(3)*uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uvec4 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    uvec4 eA[2]; { const int n = 1 + (3*p); eA = uvec4[2](uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)), uint(3)*uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }
    uvec4 eB[2]; { const int n = 1 + (3*p+1); eB = uvec4[2](uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)), uint(3)*uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }
    uvec4 eC[2]; { const int n = 1 + (3*p+2); eC = uvec4[2](uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)), uint(3)*uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }

    uint e[24] = { eA[0].x,eA[0].y,eA[0].z,eA[0].w,eA[1].x,eA[1].y,eA[1].z,eA[1].w,eB[0].x,eB[0].y,eB[0].z,eB[0].w,eB[1].x,eB[1].y,eB[1].z,eB[1].w,eC[0].x,eC[0].y,eC[0].z,eC[0].w,eC[1].x,eC[1].y,eC[1].z,eC[1].w };

    uvec4 vA[2]; { vA = uvec4[2](data[0][0],data[0][1]); }
    uvec4 vB[2]; { vB = uvec4[2](data[1][0],data[1][1]); }
    uvec4 vC[2]; { vC = uvec4[2](data[2][0],data[2][1]); }

    uint v[24] = { vA[0].x,vA[0].y,vA[0].z,vA[0].w,vA[1].x,vA[1].y,vA[1].z,vA[1].w,vB[0].x,vB[0].y,vB[0].z,vB[0].w,vB[1].x,vB[1].y,vB[1].z,vB[1].w,vC[0].x,vC[0].y,vC[0].z,vC[0].w,vC[1].x,vC[1].y,vC[1].z,vC[1].w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<24; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 1) in float dataIntrp;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in float data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ((x - 2) * 2 < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    float eA; { const int n = 1 + (3*p); eA = float(n); }
    float eB; { const int n = 1 + (3*p+1); eB = float(n); }
    float eC; { const int n = 1 + (3*p+2); eC = float(n); }

    float e[3] = { eA,eB,eC };
    float eIntrpV; {eIntrpV = float(eA * gl_BaryCoordEXT.x + eB * gl_BaryCoordEXT.y + eC * gl_BaryCoordEXT.z); }
    float eIntrp[3 / 3] = { eIntrpV };

    float vA; { vA = data[0]; }
    float vB; { vB = data[1]; }
    float vC; { vC = data[2]; }
    float vIntrpV; { vIntrpV = dataIntrp; }
    float vIntrp[3 / 3] = { vIntrpV };

    float v[3] = { vA,vB,vC };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<3 / 3; i++)
        if (abs(eIntrp[i] - vIntrp[i]) < 0.001)
            mask.y = mask.y | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out float data;
layout(location = 1) out float dataFlat;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = float(n);
    dataFlat      = float(n);
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 1) flat in float dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in float data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ((x - 2) * 2 < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    float eA; { const int n = 1 + (3*p); eA = float(n); }
    float eB; { const int n = 1 + (3*p+1); eB = float(n); }
    float eC; { const int n = 1 + (3*p+2); eC = float(n); }

    float e[3] = { eA,eB,eC };
    float eFlatV; { const int n = 1 + (3*p); eFlatV = float(n); }
    float eFlat[3 / 3] = { eFlatV };

    float vA; { vA = data[0]; }
    float vB; { vB = data[1]; }
    float vC; { vC = data[2]; }
    float vFlatV; { vFlatV = dataFlat; }
    float vFlat[3 / 3] = { vFlatV};

    float v[3] = { vA,vB,vC };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<3 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 1) flat in ivec2 dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in ivec2 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ((x - 2) * 2 < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    ivec2 eA; { const int n = 1 + (3*p); eA = ivec2(int(n), int(2*n)); }
    ivec2 eB; { const int n = 1 + (3*p+1); eB = ivec2(int(n), int(2*n)); }
    ivec2 eC; { const int n = 1 + (3*p+2); eC = ivec2(int(n), int(2*n)); }

    int e[6] = { eA.x,eA.y,eB.x,eB.y,eC.x,eC.y };
    ivec2 eFlatV; { const int n = 1 + (3*p); eFlatV = ivec2(int(n), int(2*n)); }
    int eFlat[6 / 3] = { eFlatV.x,eFlatV.y };

    ivec2 vA; { vA = data[0]; }
    ivec2 vB; { vB = data[1]; }
    ivec2 vC; { vC = data[2]; }
    ivec2 vFlatV; { vFlatV = dataFlat; }
    int vFlat[6 / 3] = { vFlatV.x,vFlatV.y};

    int v[6] = { vA.x,vA.y,vB.x,vB.y,vC.x,vC.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out ivec2 data;
layout(location = 1) out ivec2 dataFlat;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = ivec2(int(n), int(2*n));
    dataFlat      = ivec2(int(n), int(2*n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(triangles) out;
layout(max_vertices=6, max_primitives=6) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[6];
} pvd;
layout (location=0) out uvec2 data[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 6;
    uint maxPrimitive = 2;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    const uvec3 indices[2] = uvec3[](
        uvec3(0, 1, 2),
        uvec3(3, 4, 5)
    );
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = uvec2(uint(n), uint(2*n));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveTriangleIndicesEXT[primitive] = indices[primitive];
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uvec2 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ((x - 2) * 2 < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    uvec2 eA; { const int n = 1 + (3*p); eA = uvec2(uint(n), uint(2*n)); }
    uvec2 eB; { const int n = 1 + (3*p+1); eB = uvec2(uint(n), uint(2*n)); }
    uvec2 eC; { const int n = 1 + (3*p+2); eC = uvec2(uint(n), uint(2*n)); }

    uint e[6] = { eA.x,eA.y,eB.x,eB.y,eC.x,eC.y };

    uvec2 vA; { vA = data[0]; }
    uvec2 vB; { vB = data[1]; }
    uvec2 vC; { vC = data[2]; }

    uint v[6] = { vA.x,vA.y,vB.x,vB.y,vC.x,vC.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec2 q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(vec2(float(n), float(2*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec2 q;};


layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ((x - 2) * 2 < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(vec2(float(n), float(2*n))); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(vec2(float(n), float(2*n))); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(vec2(float(n), float(2*n))); }

    float e[6] = { eA.q.x,eA.q.y,eB.q.x,eB.q.y,eC.q.x,eC.q.y };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }

    float v[6] = { vA.q.x,vA.q.y,vB.q.x,vB.q.y,vC.q.x,vC.q.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec2 q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;
layout(location = 1) out DataStruct dataInterp;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(vec2(float(n), float(2*n)));
    dataInterp    = DataStruct(vec2(float(n), float(2*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec2 q;};


layout(location = 1) in DataStruct dataIntrp;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ((x - 2) * 2 < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(vec2(float(n), float(2*n))); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(vec2(float(n), float(2*n))); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(vec2(float(n), float(2*n))); }

    float e[6] = { eA.q.x,eA.q.y,eB.q.x,eB.q.y,eC.q.x,eC.q.y };
    DataStruct eIntrpV; {eIntrpV = DataStruct(eA.q * gl_BaryCoordEXT.x + eB.q * gl_BaryCoordEXT.y + eC.q * gl_BaryCoordEXT.z); }
    float eIntrp[6 / 3] = { eIntrpV.q.x,eIntrpV.q.y };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }
    DataStruct vIntrpV; { vIntrpV = dataIntrp; }
    float vIntrp[6 / 3] = { vIntrpV.q.x,vIntrpV.q.y };

    float v[6] = { vA.q.x,vA.q.y,vB.q.x,vB.q.y,vC.q.x,vC.q.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (abs(eIntrp[i] - vIntrp[i]) < 0.001)
            mask.y = mask.y | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec3 q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;
layout(location = 1) out DataStruct dataInterp;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(vec3(float(n), float(2*n), float(4*n)));
    dataInterp    = DataStruct(vec3(float(n), float(2*n), float(4*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec3 q;};


layout(location = 1) in DataStruct dataIntrp;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ((x - 2) * 2 < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(vec3(float(n), float(2*n), float(4*n))); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(vec3(float(n), float(2*n), float(4*n))); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(vec3(float(n), float(2*n), float(4*n))); }

    float e[9] = { eA.q.x,eA.q.y,eA.q.z,eB.q.x,eB.q.y,eB.q.z,eC.q.x,eC.q.y,eC.q.z };
    DataStruct eIntrpV; {eIntrpV = DataStruct(eA.q * gl_BaryCoordEXT.x + eB.q * gl_BaryCoordEXT.y + eC.q * gl_BaryCoordEXT.z); }
    float eIntrp[9 / 3] = { eIntrpV.q.x,eIntrpV.q.y,eIntrpV.q.z };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }
    DataStruct vIntrpV; { vIntrpV = dataIntrp; }
    float vIntrp[9 / 3] = { vIntrpV.q.x,vIntrpV.q.y,vIntrpV.q.z };

    float v[9] = { vA.q.x,vA.q.y,vA.q.z,vB.q.x,vB.q.y,vB.q.z,vC.q.x,vC.q.y,vC.q.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<9 / 3; i++)
        if (abs(eIntrp[i] - vIntrp[i]) < 0.001)
            mask.y = mask.y | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable

struct DataStruct {vec4 q;};
layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(triangles) out;
layout(max_vertices=6, max_primitives=6) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[6];
} pvd;
layout (location=0) out DataStruct data[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 6;
    uint maxPrimitive = 2;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    const uvec3 indices[2] = uvec3[](
        uvec3(0, 1, 2),
        uvec3(3, 4, 5)
    );
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = DataStruct(vec4(float(n), float(2*n), float(4*n), float(8*n)));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveTriangleIndicesEXT[primitive] = indices[primitive];
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec4 q;};


layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ((x - 2) * 2 < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(vec4(float(n), float(2*n), float(4*n), float(8*n))); }

    float e[12] = { eA.q.x,eA.q.y,eA.q.z,eA.q.w,eB.q.x,eB.q.y,eB.q.z,eB.q.w,eC.q.x,eC.q.y,eC.q.z,eC.q.w };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }

    float v[12] = { vA.q.x,vA.q.y,vA.q.z,vA.q.w,vB.q.x,vB.q.y,vB.q.z,vB.q.w,vC.q.x,vC.q.y,vC.q.z,vC.q.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable

struct DataStruct {dvec2 q;};
layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(triangles) out;
layout(max_vertices=6, max_primitives=6) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[6];
} pvd;
layout (location=0) out DataStruct data[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 6;
    uint maxPrimitive = 2;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    const uvec3 indices[2] = uvec3[](
        uvec3(0, 1, 2),
        uvec3(3, 4, 5)
    );
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = DataStruct(dvec2(double(n), double(2*n)));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveTriangleIndicesEXT[primitive] = indices[primitive];
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {dvec2 q;};


layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ((x - 2) * 2 < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(dvec2(double(n), double(2*n))); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(dvec2(double(n), double(2*n))); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(dvec2(double(n), double(2*n))); }

    double e[6] = { eA.q.x,eA.q.y,eB.q.x,eB.q.y,eC.q.x,eC.q.y };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }

    double v[6] = { vA.q.x,vA.q.y,vB.q.x,vB.q.y,vC.q.x,vC.q.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {int q;};


layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ((x - 2) * 2 < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(int(n)); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(int(n)); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(int(n)); }

    int e[3] = { eA.q,eB.q,eC.q };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }

    int v[3] = { vA.q,vB.q,vC.q };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable

struct DataStruct {ivec4 q;};
layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(triangles) out;
layout(max_vertices=6, max_primitives=6) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[6];
} pvd;
layout (location=0) out DataStruct data[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 6;
    uint maxPrimitive = 2;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    const uvec3 indices[2] = uvec3[](
        uvec3(0, 1, 2),
        uvec3(3, 4, 5)
    );
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = DataStruct(ivec4(int(n), int(2*n), int(4*n), int(8*n)));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveTriangleIndicesEXT[primitive] = indices[primitive];
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {ivec4 q;};


layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ((x - 2) * 2 < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(ivec4(int(n), int(2*n), int(4*n), int(8*n))); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(ivec4(int(n), int(2*n), int(4*n), int(8*n))); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(ivec4(int(n), int(2*n), int(4*n), int(8*n))); }

    int e[12] = { eA.q.x,eA.q.y,eA.q.z,eA.q.w,eB.q.x,eB.q.y,eB.q.z,eB.q.w,eC.q.x,eC.q.y,eC.q.z,eC.q.w };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }

    int v[12] = { vA.q.x,vA.q.y,vA.q.z,vA.q.w,vB.q.x,vB.q.y,vB.q.z,vB.q.w,vC.q.x,vC.q.y,vC.q.z,vC.q.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable

struct DataStruct {uint q;};
layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(triangles) out;
layout(max_vertices=6, max_primitives=6) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[6];
} pvd;
layout (location=0) out DataStruct data[];
layout(location = 1) out DataStruct dataFlat[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 6;
    uint maxPrimitive = 2;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    const uvec3 indices[2] = uvec3[](
        uvec3(0, 1, 2),
        uvec3(3, 4, 5)
    );
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = DataStruct(uint(n));
    dataFlat[vertex]      = DataStruct(uint(n));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveTriangleIndicesEXT[primitive] = indices[primitive];
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {uint q;};


layout(location = 1) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ((x - 2) * 2 < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(uint(n)); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(uint(n)); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(uint(n)); }

    uint e[3] = { eA.q,eB.q,eC.q };
    DataStruct eFlatV; { const int n = 1 + (3*p); eFlatV = DataStruct(uint(n)); }
    uint eFlat[3 / 3] = { eFlatV.q };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    uint vFlat[3 / 3] = { vFlatV.q};

    uint v[3] = { vA.q,vB.q,vC.q };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<3 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {uvec2 q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(uvec2(uint(n), uint(2*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {uvec2 q;};


layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ((x - 2) * 2 < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(uvec2(uint(n), uint(2*n))); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(uvec2(uint(n), uint(2*n))); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(uvec2(uint(n), uint(2*n))); }

    uint e[6] = { eA.q.x,eA.q.y,eB.q.x,eB.q.y,eC.q.x,eC.q.y };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }

    uint v[6] = { vA.q.x,vA.q.y,vB.q.x,vB.q.y,vC.q.x,vC.q.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out float data[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = float[2](float(n), float(3)*float(n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in float data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ((x - 2) * 2 < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    float eA[2]; { const int n = 1 + (3*p); eA = float[2](float(n), float(3)*float(n)); }
    float eB[2]; { const int n = 1 + (3*p+1); eB = float[2](float(n), float(3)*float(n)); }
    float eC[2]; { const int n = 1 + (3*p+2); eC = float[2](float(n), float(3)*float(n)); }

    float e[6] = { eA[0],eA[1],eB[0],eB[1],eC[0],eC[1] };

    float vA[2]; { vA = float[2](data[0][0],data[0][1]); }
    float vB[2]; { vB = float[2](data[1][0],data[1][1]); }
    float vC[2]; { vC = float[2](data[2][0],data[2][1]); }

    float v[6] = { vA[0],vA[1],vB[0],vB[1],vC[0],vC[1] };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(triangles) out;
layout(max_vertices=6, max_primitives=6) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[6];
} pvd;
layout (location=0) out vec3 data[][2];
layout(location = 2) out vec3 dataFlat[][2];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 6;
    uint maxPrimitive = 2;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    const uvec3 indices[2] = uvec3[](
        uvec3(0, 1, 2),
        uvec3(3, 4, 5)
    );
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n)));
    dataFlat[vertex]      = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n)));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveTriangleIndicesEXT[primitive] = indices[primitive];
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 2) flat in vec3 dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec3 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ((x - 2) * 2 < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    vec3 eA[2]; { const int n = 1 + (3*p); eA = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n))); }
    vec3 eB[2]; { const int n = 1 + (3*p+1); eB = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n))); }
    vec3 eC[2]; { const int n = 1 + (3*p+2); eC = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n))); }

    float e[18] = { eA[0].x,eA[0].y,eA[0].z,eA[1].x,eA[1].y,eA[1].z,eB[0].x,eB[0].y,eB[0].z,eB[1].x,eB[1].y,eB[1].z,eC[0].x,eC[0].y,eC[0].z,eC[1].x,eC[1].y,eC[1].z };
    vec3 eFlatV[2]; { const int n = 1 + (3*p); eFlatV = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n))); }
    float eFlat[18 / 3] = { eFlatV[0].x,eFlatV[0].y,eFlatV[0].z,eFlatV[1].x,eFlatV[1].y,eFlatV[1].z };

    vec3 vA[2]; { vA = vec3[2](data[0][0],data[0][1]); }
    vec3 vB[2]; { vB = vec3[2](data[1][0],data[1][1]); }
    vec3 vC[2]; { vC = vec3[2](data[2][0],data[2][1]); }
    vec3 vFlatV[2]; { vFlatV = vec3[2](dataFlat[0],dataFlat[1]); }
    float vFlat[18 / 3] = { vFlatV[0].x,vFlatV[0].y,vFlatV[0].z,vFlatV[1].x,vFlatV[1].y,vFlatV[1].z};

    float v[18] = { vA[0].x,vA[0].y,vA[0].z,vA[1].x,vA[1].y,vA[1].z,vB[0].x,vB[0].y,vB[0].z,vB[1].x,vB[1].y,vB[1].z,vC[0].x,vC[0].y,vC[0].z,vC[1].x,vC[1].y,vC[1].z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<18; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<18 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out vec4 data[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec4 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ((x - 2) * 2 < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    vec4 eA[2]; { const int n = 1 + (3*p); eA = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    vec4 eB[2]; { const int n = 1 + (3*p+1); eB = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    vec4 eC[2]; { const int n = 1 + (3*p+2); eC = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n))); }

    float e[24] = { eA[0].x,eA[0].y,eA[0].z,eA[0].w,eA[1].x,eA[1].y,eA[1].z,eA[1].w,eB[0].x,eB[0].y,eB[0].z,eB[0].w,eB[1].x,eB[1].y,eB[1].z,eB[1].w,eC[0].x,eC[0].y,eC[0].z,eC[0].w,eC[1].x,eC[1].y,eC[1].z,eC[1].w };

    vec4 vA[2]; { vA = vec4[2](data[0][0],data[0][1]); }
    vec4 vB[2]; { vB = vec4[2](data[1][0],data[1][1]); }
    vec4 vC[2]; { vC = vec4[2](data[2][0],data[2][1]); }

    float v[24] = { vA[0].x,vA[0].y,vA[0].z,vA[0].w,vA[1].x,vA[1].y,vA[1].z,vA[1].w,vB[0].x,vB[0].y,vB[0].z,vB[0].w,vB[1].x,vB[1].y,vB[1].z,vB[1].w,vC[0].x,vC[0].y,vC[0].z,vC[0].w,vC[1].x,vC[1].y,vC[1].z,vC[1].w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<24; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out vec4 data[2];
layout(location = 2) out vec4 dataInterp[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n)));
    dataInterp    = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 2) in vec4 dataIntrp[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec4 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ((x - 2) * 2 < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    vec4 eA[2]; { const int n = 1 + (3*p); eA = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    vec4 eB[2]; { const int n = 1 + (3*p+1); eB = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    vec4 eC[2]; { const int n = 1 + (3*p+2); eC = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n))); }

    float e[24] = { eA[0].x,eA[0].y,eA[0].z,eA[0].w,eA[1].x,eA[1].y,eA[1].z,eA[1].w,eB[0].x,eB[0].y,eB[0].z,eB[0].w,eB[1].x,eB[1].y,eB[1].z,eB[1].w,eC[0].x,eC[0].y,eC[0].z,eC[0].w,eC[1].x,eC[1].y,eC[1].z,eC[1].w };
    vec4 eIntrpV[2]; {eIntrpV = vec4[2](eA[0] * gl_BaryCoordEXT.x + eB[0] * gl_BaryCoordEXT.y + eC[0] * gl_BaryCoordEXT.z, eA[1] * gl_BaryCoordEXT.x + eB[1] * gl_BaryCoordEXT.y + eC[1] * gl_BaryCoordEXT.z); }
    float eIntrp[24 / 3] = { eIntrpV[0].x,eIntrpV[0].y,eIntrpV[0].z,eIntrpV[0].w,eIntrpV[1].x,eIntrpV[1].y,eIntrpV[1].z,eIntrpV[1].w };

    vec4 vA[2]; { vA = vec4[2](data[0][0],data[0][1]); }
    vec4 vB[2]; { vB = vec4[2](data[1][0],data[1][1]); }
    vec4 vC[2]; { vC = vec4[2](data[2][0],data[2][1]); }
    vec4 vIntrpV[2]; { vIntrpV = vec4[2](dataIntrp[0],dataIntrp[1]); }
    float vIntrp[24 / 3] = { vIntrpV[0].x,vIntrpV[0].y,vIntrpV[0].z,vIntrpV[0].w,vIntrpV[1].x,vIntrpV[1].y,vIntrpV[1].z,vIntrpV[1].w };

    float v[24] = { vA[0].x,vA[0].y,vA[0].z,vA[0].w,vA[1].x,vA[1].y,vA[1].z,vA[1].w,vB[0].x,vB[0].y,vB[0].z,vB[0].w,vB[1].x,vB[1].y,vB[1].z,vB[1].w,vC[0].x,vC[0].y,vC[0].z,vC[0].w,vC[1].x,vC[1].y,vC[1].z,vC[1].w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<24; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<24 / 3; i++)
        if (abs(eIntrp[i] - vIntrp[i]) < 0.001)
            mask.y = mask.y | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out vec4 data[2];
layout(location = 2) out vec4 dataFlat[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n)));
    dataFlat      = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 2) flat in vec4 dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec4 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ((x - 2) * 2 < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    vec4 eA[2]; { const int n = 1 + (3*p); eA = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    vec4 eB[2]; { const int n = 1 + (3*p+1); eB = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    vec4 eC[2]; { const int n = 1 + (3*p+2); eC = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n))); }

    float e[24] = { eA[0].x,eA[0].y,eA[0].z,eA[0].w,eA[1].x,eA[1].y,eA[1].z,eA[1].w,eB[0].x,eB[0].y,eB[0].z,eB[0].w,eB[1].x,eB[1].y,eB[1].z,eB[1].w,eC[0].x,eC[0].y,eC[0].z,eC[0].w,eC[1].x,eC[1].y,eC[1].z,eC[1].w };
    vec4 eFlatV[2]; { const int n = 1 + (3*p); eFlatV = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    float eFlat[24 / 3] = { eFlatV[0].x,eFlatV[0].y,eFlatV[0].z,eFlatV[0].w,eFlatV[1].x,eFlatV[1].y,eFlatV[1].z,eFlatV[1].w };

    vec4 vA[2]; { vA = vec4[2](data[0][0],data[0][1]); }
    vec4 vB[2]; { vB = vec4[2](data[1][0],data[1][1]); }
    vec4 vC[2]; { vC = vec4[2](data[2][0],data[2][1]); }
    vec4 vFlatV[2]; { vFlatV = vec4[2](dataFlat[0],dataFlat[1]); }
    float vFlat[24 / 3] = { vFlatV[0].x,vFlatV[0].y,vFlatV[0].z,vFlatV[0].w,vFlatV[1].x,vFlatV[1].y,vFlatV[1].z,vFlatV[1].w};

    float v[24] = { vA[0].x,vA[0].y,vA[0].z,vA[0].w,vA[1].x,vA[1].y,vA[1].z,vA[1].w,vB[0].x,vB[0].y,vB[0].z,vB[0].w,vB[1].x,vB[1].y,vB[1].z,vB[1].w,vC[0].x,vC[0].y,vC[0].z,vC[0].w,vC[1].x,vC[1].y,vC[1].z,vC[1].w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<24; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<24 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out dvec2 data[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = dvec2[2](dvec2(double(n), double(2*n)), double(3)*dvec2(double(n), double(2*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec2 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ((x - 2) * 2 < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    dvec2 eA[2]; { const int n = 1 + (3*p); eA = dvec2[2](dvec2(double(n), double(2*n)), double(3)*dvec2(double(n), double(2*n))); }
    dvec2 eB[2]; { const int n = 1 + (3*p+1); eB = dvec2[2](dvec2(double(n), double(2*n)), double(3)*dvec2(double(n), double(2*n))); }
    dvec2 eC[2]; { const int n = 1 + (3*p+2); eC = dvec2[2](dvec2(double(n), double(2*n)), double(3)*dvec2(double(n), double(2*n))); }

    double e[12] = { eA[0].x,eA[0].y,eA[1].x,eA[1].y,eB[0].x,eB[0].y,eB[1].x,eB[1].y,eC[0].x,eC[0].y,eC[1].x,eC[1].y };

    dvec2 vA[2]; { vA = dvec2[2](data[0][0],data[0][1]); }
    dvec2 vB[2]; { vB = dvec2[2](data[1][0],data[1][1]); }
    dvec2 vC[2]; { vC = dvec2[2](data[2][0],data[2][1]); }

    double v[12] = { vA[0].x,vA[0].y,vA[1].x,vA[1].y,vB[0].x,vB[0].y,vB[1].x,vB[1].y,vC[0].x,vC[0].y,vC[1].x,vC[1].y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(triangles) out;
layout(max_vertices=6, max_primitives=6) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[6];
} pvd;
layout (location=0) out dvec3 data[][2];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 6;
    uint maxPrimitive = 2;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    const uvec3 indices[2] = uvec3[](
        uvec3(0, 1, 2),
        uvec3(3, 4, 5)
    );
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n)));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveTriangleIndicesEXT[primitive] = indices[primitive];
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec3 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ((x - 2) * 2 < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    dvec3 eA[2]; { const int n = 1 + (3*p); eA = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n))); }
    dvec3 eB[2]; { const int n = 1 + (3*p+1); eB = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n))); }
    dvec3 eC[2]; { const int n = 1 + (3*p+2); eC = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n))); }

    double e[18] = { eA[0].x,eA[0].y,eA[0].z,eA[1].x,eA[1].y,eA[1].z,eB[0].x,eB[0].y,eB[0].z,eB[1].x,eB[1].y,eB[1].z,eC[0].x,eC[0].y,eC[0].z,eC[1].x,eC[1].y,eC[1].z };

    dvec3 vA[2]; { vA = dvec3[2](data[0][0],data[0][1]); }
    dvec3 vB[2]; { vB = dvec3[2](data[1][0],data[1][1]); }
    dvec3 vC[2]; { vC = dvec3[2](data[2][0],data[2][1]); }

    double v[18] = { vA[0].x,vA[0].y,vA[0].z,vA[1].x,vA[1].y,vA[1].z,vB[0].x,vB[0].y,vB[0].z,vB[1].x,vB[1].y,vB[1].z,vC[0].x,vC[0].y,vC[0].z,vC[1].x,vC[1].y,vC[1].z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<18; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 2) flat in ivec4 dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in ivec4 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ((x - 2) * 2 < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    ivec4 eA[2]; { const int n = 1 + (3*p); eA = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n))); }
    ivec4 eB[2]; { const int n = 1 + (3*p+1); eB = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n))); }
    ivec4 eC[2]; { const int n = 1 + (3*p+2); eC = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n))); }

    int e[24] = { eA[0].x,eA[0].y,eA[0].z,eA[0].w,eA[1].x,eA[1].y,eA[1].z,eA[1].w,eB[0].x,eB[0].y,eB[0].z,eB[0].w,eB[1].x,eB[1].y,eB[1].z,eB[1].w,eC[0].x,eC[0].y,eC[0].z,eC[0].w,eC[1].x,eC[1].y,eC[1].z,eC[1].w };
    ivec4 eFlatV[2]; { const int n = 1 + (3*p); eFlatV = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n))); }
    int eFlat[24 / 3] = { eFlatV[0].x,eFlatV[0].y,eFlatV[0].z,eFlatV[0].w,eFlatV[1].x,eFlatV[1].y,eFlatV[1].z,eFlatV[1].w };

    ivec4 vA[2]; { vA = ivec4[2](data[0][0],data[0][1]); }
    ivec4 vB[2]; { vB = ivec4[2](data[1][0],data[1][1]); }
    ivec4 vC[2]; { vC = ivec4[2](data[2][0],data[2][1]); }
    ivec4 vFlatV[2]; { vFlatV = ivec4[2](dataFlat[0],dataFlat[1]); }
    int vFlat[24 / 3] = { vFlatV[0].x,vFlatV[0].y,vFlatV[0].z,vFlatV[0].w,vFlatV[1].x,vFlatV[1].y,vFlatV[1].z,vFlatV[1].w};

    int v[24] = { vA[0].x,vA[0].y,vA[0].z,vA[0].w,vA[1].x,vA[1].y,vA[1].z,vA[1].w,vB[0].x,vB[0].y,vB[0].z,vB[0].w,vB[1].x,vB[1].y,vB[1].z,vB[1].w,vC[0].x,vC[0].y,vC[0].z,vC[0].w,vC[1].x,vC[1].y,vC[1].z,vC[1].w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<24; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<24 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(triangles) out;
layout(max_vertices=6, max_primitives=6) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[6];
} pvd;
layout (location=0) out uvec4 data[][2];
layout(location = 2) out uvec4 dataFlat[][2];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 6;
    uint maxPrimitive = 2;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    const uvec3 indices[2] = uvec3[](
        uvec3(0, 1, 2),
        uvec3(3, 4, 5)
    );
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = uvec4[2](uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)), uint(3)*uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)));
    dataFlat[vertex]      = uvec4[2](uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)), uint(3)*uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveTriangleIndicesEXT[primitive] = indices[primitive];
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 2) flat in uvec4 dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uvec4 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ((x - 2) * 2 < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    uvec4 eA[2]; { const int n = 1 + (3*p); eA = uvec4[2](uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)), uint(3)*uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }
    uvec4 eB[2]; { const int n = 1 + (3*p+1); eB = uvec4[2](uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)), uint(3)*uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }
    uvec4 eC[2]; { const int n = 1 + (3*p+2); eC = uvec4[2](uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)), uint(3)*uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }

    uint e[24] = { eA[0].x,eA[0].y,eA[0].z,eA[0].w,eA[1].x,eA[1].y,eA[1].z,eA[1].w,eB[0].x,eB[0].y,eB[0].z,eB[0].w,eB[1].x,eB[1].y,eB[1].z,eB[1].w,eC[0].x,eC[0].y,eC[0].z,eC[0].w,eC[1].x,eC[1].y,eC[1].z,eC[1].w };
    uvec4 eFlatV[2]; { const int n = 1 + (3*p); eFlatV = uvec4[2](uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)), uint(3)*uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }
    uint eFlat[24 / 3] = { eFlatV[0].x,eFlatV[0].y,eFlatV[0].z,eFlatV[0].w,eFlatV[1].x,eFlatV[1].y,eFlatV[1].z,eFlatV[1].w };

    uvec4 vA[2]; { vA = uvec4[2](data[0][0],data[0][1]); }
    uvec4 vB[2]; { vB = uvec4[2](data[1][0],data[1][1]); }
    uvec4 vC[2]; { vC = uvec4[2](data[2][0],data[2][1]); }
    uvec4 vFlatV[2]; { vFlatV = uvec4[2](dataFlat[0],dataFlat[1]); }
    uint vFlat[24 / 3] = { vFlatV[0].x,vFlatV[0].y,vFlatV[0].z,vFlatV[0].w,vFlatV[1].x,vFlatV[1].y,vFlatV[1].z,vFlatV[1].w};

    uint v[24] = { vA[0].x,vA[0].y,vA[0].z,vA[0].w,vA[1].x,vA[1].y,vA[1].z,vA[1].w,vB[0].x,vB[0].y,vB[0].z,vB[0].w,vB[1].x,vB[1].y,vB[1].z,vB[1].w,vC[0].x,vC[0].y,vC[0].z,vC[0].w,vC[1].x,vC[1].y,vC[1].z,vC[1].w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<24; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<24 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out vec2 data;
layout(location = 1) out vec2 dataFlat;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = vec2(float(n), float(2*n));
    dataFlat      = vec2(float(n), float(2*n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 1) flat in vec2 dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec2 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    vec2 eA; { const int n = 1 + (p); eA = vec2(float(n), float(2*n)); }
    vec2 eB; { const int n = 1 + (even?p+1:p+2); eB = vec2(float(n), float(2*n)); }
    vec2 eC; { const int n = 1 + (even?p+2:p+1); eC = vec2(float(n), float(2*n)); }

    float e[6] = { eA.x,eA.y,eB.x,eB.y,eC.x,eC.y };
    vec2 eFlatV; { const int n = 1 + (p); eFlatV = vec2(float(n), float(2*n)); }
    float eFlat[6 / 3] = { eFlatV.x,eFlatV.y };

    vec2 vA; { vA = data[0]; }
    vec2 vB; { vB = data[1]; }
    vec2 vC; { vC = data[2]; }
    vec2 vFlatV; { vFlatV = dataFlat; }
    float vFlat[6 / 3] = { vFlatV.x,vFlatV.y};

    float v[6] = { vA.x,vA.y,vB.x,vB.y,vC.x,vC.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out double data;
layout(location = 2) out double dataFlat;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = double(n);
    dataFlat      = double(n);
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 2) flat in double dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in double data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    double eA; { const int n = 1 + (p); eA = double(n); }
    double eB; { const int n = 1 + (even?p+1:p+2); eB = double(n); }
    double eC; { const int n = 1 + (even?p+2:p+1); eC = double(n); }

    double e[3] = { eA,eB,eC };
    double eFlatV; { const int n = 1 + (p); eFlatV = double(n); }
    double eFlat[3 / 3] = { eFlatV };

    double vA; { vA = data[0]; }
    double vB; { vB = data[1]; }
    double vC; { vC = data[2]; }
    double vFlatV; { vFlatV = dataFlat; }
    double vFlat[3 / 3] = { vFlatV};

    double v[3] = { vA,vB,vC };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<3 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 2) flat in dvec3 dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec3 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    dvec3 eA; { const int n = 1 + (p); eA = dvec3(double(n), double(2*n), double(4*n)); }
    dvec3 eB; { const int n = 1 + (even?p+1:p+2); eB = dvec3(double(n), double(2*n), double(4*n)); }
    dvec3 eC; { const int n = 1 + (even?p+2:p+1); eC = dvec3(double(n), double(2*n), double(4*n)); }

    double e[9] = { eA.x,eA.y,eA.z,eB.x,eB.y,eB.z,eC.x,eC.y,eC.z };
    dvec3 eFlatV; { const int n = 1 + (p); eFlatV = dvec3(double(n), double(2*n), double(4*n)); }
    double eFlat[9 / 3] = { eFlatV.x,eFlatV.y,eFlatV.z };

    dvec3 vA; { vA = data[0]; }
    dvec3 vB; { vB = data[1]; }
    dvec3 vC; { vC = data[2]; }
    dvec3 vFlatV; { vFlatV = dataFlat; }
    double vFlat[9 / 3] = { vFlatV.x,vFlatV.y,vFlatV.z};

    double v[9] = { vA.x,vA.y,vA.z,vB.x,vB.y,vB.z,vC.x,vC.y,vC.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<9 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out uvec2 data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = uvec2(uint(n), uint(2*n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uvec2 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    uvec2 eA; { const int n = 1 + (p); eA = uvec2(uint(n), uint(2*n)); }
    uvec2 eB; { const int n = 1 + (even?p+1:p+2); eB = uvec2(uint(n), uint(2*n)); }
    uvec2 eC; { const int n = 1 + (even?p+2:p+1); eC = uvec2(uint(n), uint(2*n)); }

    uint e[6] = { eA.x,eA.y,eB.x,eB.y,eC.x,eC.y };

    uvec2 vA; { vA = data[0]; }
    uvec2 vB; { vB = data[1]; }
    uvec2 vC; { vC = data[2]; }

    uint v[6] = { vA.x,vA.y,vB.x,vB.y,vC.x,vC.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec2 q;};


layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (p); eA = DataStruct(vec2(float(n), float(2*n))); }
    DataStruct eB; { const int n = 1 + (even?p+1:p+2); eB = DataStruct(vec2(float(n), float(2*n))); }
    DataStruct eC; { const int n = 1 + (even?p+2:p+1); eC = DataStruct(vec2(float(n), float(2*n))); }

    float e[6] = { eA.q.x,eA.q.y,eB.q.x,eB.q.y,eC.q.x,eC.q.y };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }

    float v[6] = { vA.q.x,vA.q.y,vB.q.x,vB.q.y,vC.q.x,vC.q.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec2 q;};


layout(location = 1) in DataStruct dataIntrp;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (p); eA = DataStruct(vec2(float(n), float(2*n))); }
    DataStruct eB; { const int n = 1 + (even?p+1:p+2); eB = DataStruct(vec2(float(n), float(2*n))); }
    DataStruct eC; { const int n = 1 + (even?p+2:p+1); eC = DataStruct(vec2(float(n), float(2*n))); }

    float e[6] = { eA.q.x,eA.q.y,eB.q.x,eB.q.y,eC.q.x,eC.q.y };
    DataStruct eIntrpV; {eIntrpV = DataStruct(eA.q * gl_BaryCoordEXT.x + eB.q * gl_BaryCoordEXT.y + eC.q * gl_BaryCoordEXT.z); }
    float eIntrp[6 / 3] = { eIntrpV.q.x,eIntrpV.q.y };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }
    DataStruct vIntrpV; { vIntrpV = dataIntrp; }
    float vIntrp[6 / 3] = { vIntrpV.q.x,vIntrpV.q.y };

    float v[6] = { vA.q.x,vA.q.y,vB.q.x,vB.q.y,vC.q.x,vC.q.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (abs(eIntrp[i] - vIntrp[i]) < 0.001)
            mask.y = mask.y | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec3 q;};


layout(location = 1) in DataStruct dataIntrp;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (p); eA = DataStruct(vec3(float(n), float(2*n), float(4*n))); }
    DataStruct eB; { const int n = 1 + (even?p+1:p+2); eB = DataStruct(vec3(float(n), float(2*n), float(4*n))); }
    DataStruct eC; { const int n = 1 + (even?p+2:p+1); eC = DataStruct(vec3(float(n), float(2*n), float(4*n))); }

    float e[9] = { eA.q.x,eA.q.y,eA.q.z,eB.q.x,eB.q.y,eB.q.z,eC.q.x,eC.q.y,eC.q.z };
    DataStruct eIntrpV; {eIntrpV = DataStruct(eA.q * gl_BaryCoordEXT.x + eB.q * gl_BaryCoordEXT.y + eC.q * gl_BaryCoordEXT.z); }
    float eIntrp[9 / 3] = { eIntrpV.q.x,eIntrpV.q.y,eIntrpV.q.z };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }
    DataStruct vIntrpV; { vIntrpV = dataIntrp; }
    float vIntrp[9 / 3] = { vIntrpV.q.x,vIntrpV.q.y,vIntrpV.q.z };

    float v[9] = { vA.q.x,vA.q.y,vA.q.z,vB.q.x,vB.q.y,vB.q.z,vC.q.x,vC.q.y,vC.q.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<9 / 3; i++)
        if (abs(eIntrp[i] - vIntrp[i]) < 0.001)
            mask.y = mask.y | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {dvec3 q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;
layout(location = 2) out DataStruct dataFlat;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(dvec3(double(n), double(2*n), double(4*n)));
    dataFlat      = DataStruct(dvec3(double(n), double(2*n), double(4*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {dvec3 q;};


layout(location = 2) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (p); eA = DataStruct(dvec3(double(n), double(2*n), double(4*n))); }
    DataStruct eB; { const int n = 1 + (even?p+1:p+2); eB = DataStruct(dvec3(double(n), double(2*n), double(4*n))); }
    DataStruct eC; { const int n = 1 + (even?p+2:p+1); eC = DataStruct(dvec3(double(n), double(2*n), double(4*n))); }

    double e[9] = { eA.q.x,eA.q.y,eA.q.z,eB.q.x,eB.q.y,eB.q.z,eC.q.x,eC.q.y,eC.q.z };
    DataStruct eFlatV; { const int n = 1 + (p); eFlatV = DataStruct(dvec3(double(n), double(2*n), double(4*n))); }
    double eFlat[9 / 3] = { eFlatV.q.x,eFlatV.q.y,eFlatV.q.z };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    double vFlat[9 / 3] = { vFlatV.q.x,vFlatV.q.y,vFlatV.q.z};

    double v[9] = { vA.q.x,vA.q.y,vA.q.z,vB.q.x,vB.q.y,vB.q.z,vC.q.x,vC.q.y,vC.q.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<9 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {uint q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;
layout(location = 1) out DataStruct dataFlat;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(uint(n));
    dataFlat      = DataStruct(uint(n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {uint q;};


layout(location = 1) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (p); eA = DataStruct(uint(n)); }
    DataStruct eB; { const int n = 1 + (even?p+1:p+2); eB = DataStruct(uint(n)); }
    DataStruct eC; { const int n = 1 + (even?p+2:p+1); eC = DataStruct(uint(n)); }

    uint e[3] = { eA.q,eB.q,eC.q };
    DataStruct eFlatV; { const int n = 1 + (p); eFlatV = DataStruct(uint(n)); }
    uint eFlat[3 / 3] = { eFlatV.q };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    uint vFlat[3 / 3] = { vFlatV.q};

    uint v[3] = { vA.q,vB.q,vC.q };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<3 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec4 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    vec4 eA[2]; { const int n = 1 + (p); eA = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    vec4 eB[2]; { const int n = 1 + (even?p+1:p+2); eB = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    vec4 eC[2]; { const int n = 1 + (even?p+2:p+1); eC = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n))); }

    float e[24] = { eA[0].x,eA[0].y,eA[0].z,eA[0].w,eA[1].x,eA[1].y,eA[1].z,eA[1].w,eB[0].x,eB[0].y,eB[0].z,eB[0].w,eB[1].x,eB[1].y,eB[1].z,eB[1].w,eC[0].x,eC[0].y,eC[0].z,eC[0].w,eC[1].x,eC[1].y,eC[1].z,eC[1].w };

    vec4 vA[2]; { vA = vec4[2](data[0][0],data[0][1]); }
    vec4 vB[2]; { vB = vec4[2](data[1][0],data[1][1]); }
    vec4 vC[2]; { vC = vec4[2](data[2][0],data[2][1]); }

    float v[24] = { vA[0].x,vA[0].y,vA[0].z,vA[0].w,vA[1].x,vA[1].y,vA[1].z,vA[1].w,vB[0].x,vB[0].y,vB[0].z,vB[0].w,vB[1].x,vB[1].y,vB[1].z,vB[1].w,vC[0].x,vC[0].y,vC[0].z,vC[0].w,vC[1].x,vC[1].y,vC[1].z,vC[1].w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<24; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 2) in vec4 dataIntrp[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec4 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    vec4 eA[2]; { const int n = 1 + (p); eA = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    vec4 eB[2]; { const int n = 1 + (even?p+1:p+2); eB = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    vec4 eC[2]; { const int n = 1 + (even?p+2:p+1); eC = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n))); }

    float e[24] = { eA[0].x,eA[0].y,eA[0].z,eA[0].w,eA[1].x,eA[1].y,eA[1].z,eA[1].w,eB[0].x,eB[0].y,eB[0].z,eB[0].w,eB[1].x,eB[1].y,eB[1].z,eB[1].w,eC[0].x,eC[0].y,eC[0].z,eC[0].w,eC[1].x,eC[1].y,eC[1].z,eC[1].w };
    vec4 eIntrpV[2]; {eIntrpV = vec4[2](eA[0] * gl_BaryCoordEXT.x + eB[0] * gl_BaryCoordEXT.y + eC[0] * gl_BaryCoordEXT.z, eA[1] * gl_BaryCoordEXT.x + eB[1] * gl_BaryCoordEXT.y + eC[1] * gl_BaryCoordEXT.z); }
    float eIntrp[24 / 3] = { eIntrpV[0].x,eIntrpV[0].y,eIntrpV[0].z,eIntrpV[0].w,eIntrpV[1].x,eIntrpV[1].y,eIntrpV[1].z,eIntrpV[1].w };

    vec4 vA[2]; { vA = vec4[2](data[0][0],data[0][1]); }
    vec4 vB[2]; { vB = vec4[2](data[1][0],data[1][1]); }
    vec4 vC[2]; { vC = vec4[2](data[2][0],data[2][1]); }
    vec4 vIntrpV[2]; { vIntrpV = vec4[2](dataIntrp[0],dataIntrp[1]); }
    float vIntrp[24 / 3] = { vIntrpV[0].x,vIntrpV[0].y,vIntrpV[0].z,vIntrpV[0].w,vIntrpV[1].x,vIntrpV[1].y,vIntrpV[1].z,vIntrpV[1].w };

    float v[24] = { vA[0].x,vA[0].y,vA[0].z,vA[0].w,vA[1].x,vA[1].y,vA[1].z,vA[1].w,vB[0].x,vB[0].y,vB[0].z,vB[0].w,vB[1].x,vB[1].y,vB[1].z,vB[1].w,vC[0].x,vC[0].y,vC[0].z,vC[0].w,vC[1].x,vC[1].y,vC[1].z,vC[1].w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<24; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<24 / 3; i++)
        if (abs(eIntrp[i] - vIntrp[i]) < 0.001)
            mask.y = mask.y | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out dvec2 data[2];
layout(location = 4) out dvec2 dataFlat[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = dvec2[2](dvec2(double(n), double(2*n)), double(3)*dvec2(double(n), double(2*n)));
    dataFlat      = dvec2[2](dvec2(double(n), double(2*n)), double(3)*dvec2(double(n), double(2*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 4) flat in dvec2 dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec2 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    dvec2 eA[2]; { const int n = 1 + (p); eA = dvec2[2](dvec2(double(n), double(2*n)), double(3)*dvec2(double(n), double(2*n))); }
    dvec2 eB[2]; { const int n = 1 + (even?p+1:p+2); eB = dvec2[2](dvec2(double(n), double(2*n)), double(3)*dvec2(double(n), double(2*n))); }
    dvec2 eC[2]; { const int n = 1 + (even?p+2:p+1); eC = dvec2[2](dvec2(double(n), double(2*n)), double(3)*dvec2(double(n), double(2*n))); }

    double e[12] = { eA[0].x,eA[0].y,eA[1].x,eA[1].y,eB[0].x,eB[0].y,eB[1].x,eB[1].y,eC[0].x,eC[0].y,eC[1].x,eC[1].y };
    dvec2 eFlatV[2]; { const int n = 1 + (p); eFlatV = dvec2[2](dvec2(double(n), double(2*n)), double(3)*dvec2(double(n), double(2*n))); }
    double eFlat[12 / 3] = { eFlatV[0].x,eFlatV[0].y,eFlatV[1].x,eFlatV[1].y };

    dvec2 vA[2]; { vA = dvec2[2](data[0][0],data[0][1]); }
    dvec2 vB[2]; { vB = dvec2[2](data[1][0],data[1][1]); }
    dvec2 vC[2]; { vC = dvec2[2](data[2][0],data[2][1]); }
    dvec2 vFlatV[2]; { vFlatV = dvec2[2](dataFlat[0],dataFlat[1]); }
    double vFlat[12 / 3] = { vFlatV[0].x,vFlatV[0].y,vFlatV[1].x,vFlatV[1].y};

    double v[12] = { vA[0].x,vA[0].y,vA[1].x,vA[1].y,vB[0].x,vB[0].y,vB[1].x,vB[1].y,vC[0].x,vC[0].y,vC[1].x,vC[1].y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<12 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 2) flat in int dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in int data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    int eA[2]; { const int n = 1 + (p); eA = int[2](int(n), int(3)*int(n)); }
    int eB[2]; { const int n = 1 + (even?p+1:p+2); eB = int[2](int(n), int(3)*int(n)); }
    int eC[2]; { const int n = 1 + (even?p+2:p+1); eC = int[2](int(n), int(3)*int(n)); }

    int e[6] = { eA[0],eA[1],eB[0],eB[1],eC[0],eC[1] };
    int eFlatV[2]; { const int n = 1 + (p); eFlatV = int[2](int(n), int(3)*int(n)); }
    int eFlat[6 / 3] = { eFlatV[0],eFlatV[1] };

    int vA[2]; { vA = int[2](data[0][0],data[0][1]); }
    int vB[2]; { vB = int[2](data[1][0],data[1][1]); }
    int vC[2]; { vC = int[2](data[2][0],data[2][1]); }
    int vFlatV[2]; { vFlatV = int[2](dataFlat[0],dataFlat[1]); }
    int vFlat[6 / 3] = { vFlatV[0],vFlatV[1]};

    int v[6] = { vA[0],vA[1],vB[0],vB[1],vC[0],vC[1] };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in ivec2 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    ivec2 eA[2]; { const int n = 1 + (p); eA = ivec2[2](ivec2(int(n), int(2*n)), int(3)*ivec2(int(n), int(2*n))); }
    ivec2 eB[2]; { const int n = 1 + (even?p+1:p+2); eB = ivec2[2](ivec2(int(n), int(2*n)), int(3)*ivec2(int(n), int(2*n))); }
    ivec2 eC[2]; { const int n = 1 + (even?p+2:p+1); eC = ivec2[2](ivec2(int(n), int(2*n)), int(3)*ivec2(int(n), int(2*n))); }

    int e[12] = { eA[0].x,eA[0].y,eA[1].x,eA[1].y,eB[0].x,eB[0].y,eB[1].x,eB[1].y,eC[0].x,eC[0].y,eC[1].x,eC[1].y };

    ivec2 vA[2]; { vA = ivec2[2](data[0][0],data[0][1]); }
    ivec2 vB[2]; { vB = ivec2[2](data[1][0],data[1][1]); }
    ivec2 vC[2]; { vC = ivec2[2](data[2][0],data[2][1]); }

    int v[12] = { vA[0].x,vA[0].y,vA[1].x,vA[1].y,vB[0].x,vB[0].y,vB[1].x,vB[1].y,vC[0].x,vC[0].y,vC[1].x,vC[1].y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out uvec4 data[2];
layout(location = 2) out uvec4 dataFlat[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = uvec4[2](uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)), uint(3)*uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)));
    dataFlat      = uvec4[2](uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)), uint(3)*uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 2) flat in uvec4 dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uvec4 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    uvec4 eA[2]; { const int n = 1 + (p); eA = uvec4[2](uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)), uint(3)*uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }
    uvec4 eB[2]; { const int n = 1 + (even?p+1:p+2); eB = uvec4[2](uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)), uint(3)*uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }
    uvec4 eC[2]; { const int n = 1 + (even?p+2:p+1); eC = uvec4[2](uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)), uint(3)*uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }

    uint e[24] = { eA[0].x,eA[0].y,eA[0].z,eA[0].w,eA[1].x,eA[1].y,eA[1].z,eA[1].w,eB[0].x,eB[0].y,eB[0].z,eB[0].w,eB[1].x,eB[1].y,eB[1].z,eB[1].w,eC[0].x,eC[0].y,eC[0].z,eC[0].w,eC[1].x,eC[1].y,eC[1].z,eC[1].w };
    uvec4 eFlatV[2]; { const int n = 1 + (p); eFlatV = uvec4[2](uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)), uint(3)*uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }
    uint eFlat[24 / 3] = { eFlatV[0].x,eFlatV[0].y,eFlatV[0].z,eFlatV[0].w,eFlatV[1].x,eFlatV[1].y,eFlatV[1].z,eFlatV[1].w };

    uvec4 vA[2]; { vA = uvec4[2](data[0][0],data[0][1]); }
    uvec4 vB[2]; { vB = uvec4[2](data[1][0],data[1][1]); }
    uvec4 vC[2]; { vC = uvec4[2](data[2][0],data[2][1]); }
    uvec4 vFlatV[2]; { vFlatV = uvec4[2](dataFlat[0],dataFlat[1]); }
    uint vFlat[24 / 3] = { vFlatV[0].x,vFlatV[0].y,vFlatV[0].z,vFlatV[0].w,vFlatV[1].x,vFlatV[1].y,vFlatV[1].z,vFlatV[1].w};

    uint v[24] = { vA[0].x,vA[0].y,vA[0].z,vA[0].w,vA[1].x,vA[1].y,vA[1].z,vA[1].w,vB[0].x,vB[0].y,vB[0].z,vB[0].w,vB[1].x,vB[1].y,vB[1].z,vB[1].w,vC[0].x,vC[0].y,vC[0].z,vC[0].w,vC[1].x,vC[1].y,vC[1].z,vC[1].w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<24; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<24 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 1) in float dataIntrp;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in float data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    float eA; { const int n = 1 + (p+1); eA = float(n); }
    float eB; { const int n = 1 + (p+2); eB = float(n); }
    float eC; { const int n = 1 + (0); eC = float(n); }

    float e[3] = { eA,eB,eC };
    float eIntrpV; {eIntrpV = float(eA * gl_BaryCoordEXT.x + eB * gl_BaryCoordEXT.y + eC * gl_BaryCoordEXT.z); }
    float eIntrp[3 / 3] = { eIntrpV };

    float vA; { vA = data[0]; }
    float vB; { vB = data[1]; }
    float vC; { vC = data[2]; }
    float vIntrpV; { vIntrpV = dataIntrp; }
    float vIntrp[3 / 3] = { vIntrpV };

    float v[3] = { vA,vB,vC };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<3 / 3; i++)
        if (abs(eIntrp[i] - vIntrp[i]) < 0.001)
            mask.y = mask.y | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 1) flat in float dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in float data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    float eA; { const int n = 1 + (p+1); eA = float(n); }
    float eB; { const int n = 1 + (p+2); eB = float(n); }
    float eC; { const int n = 1 + (0); eC = float(n); }

    float e[3] = { eA,eB,eC };
    float eFlatV; { const int n = 1 + (p+1); eFlatV = float(n); }
    float eFlat[3 / 3] = { eFlatV };

    float vA; { vA = data[0]; }
    float vB; { vB = data[1]; }
    float vC; { vC = data[2]; }
    float vFlatV; { vFlatV = dataFlat; }
    float vFlat[3 / 3] = { vFlatV};

    float v[3] = { vA,vB,vC };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<3 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out dvec4 data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = dvec4(double(n), double(2*n), double(4*n), double(8*n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec4 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    dvec4 eA; { const int n = 1 + (p+1); eA = dvec4(double(n), double(2*n), double(4*n), double(8*n)); }
    dvec4 eB; { const int n = 1 + (p+2); eB = dvec4(double(n), double(2*n), double(4*n), double(8*n)); }
    dvec4 eC; { const int n = 1 + (0); eC = dvec4(double(n), double(2*n), double(4*n), double(8*n)); }

    double e[12] = { eA.x,eA.y,eA.z,eA.w,eB.x,eB.y,eB.z,eB.w,eC.x,eC.y,eC.z,eC.w };

    dvec4 vA; { vA = data[0]; }
    dvec4 vB; { vB = data[1]; }
    dvec4 vC; { vC = data[2]; }

    double v[12] = { vA.x,vA.y,vA.z,vA.w,vB.x,vB.y,vB.z,vB.w,vC.x,vC.y,vC.z,vC.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 1) flat in ivec2 dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in ivec2 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    ivec2 eA; { const int n = 1 + (p+1); eA = ivec2(int(n), int(2*n)); }
    ivec2 eB; { const int n = 1 + (p+2); eB = ivec2(int(n), int(2*n)); }
    ivec2 eC; { const int n = 1 + (0); eC = ivec2(int(n), int(2*n)); }

    int e[6] = { eA.x,eA.y,eB.x,eB.y,eC.x,eC.y };
    ivec2 eFlatV; { const int n = 1 + (p+1); eFlatV = ivec2(int(n), int(2*n)); }
    int eFlat[6 / 3] = { eFlatV.x,eFlatV.y };

    ivec2 vA; { vA = data[0]; }
    ivec2 vB; { vB = data[1]; }
    ivec2 vC; { vC = data[2]; }
    ivec2 vFlatV; { vFlatV = dataFlat; }
    int vFlat[6 / 3] = { vFlatV.x,vFlatV.y};

    int v[6] = { vA.x,vA.y,vB.x,vB.y,vC.x,vC.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uint data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    uint eA; { const int n = 1 + (p+1); eA = uint(n); }
    uint eB; { const int n = 1 + (p+2); eB = uint(n); }
    uint eC; { const int n = 1 + (0); eC = uint(n); }

    uint e[3] = { eA,eB,eC };

    uint vA; { vA = data[0]; }
    uint vB; { vB = data[1]; }
    uint vC; { vC = data[2]; }

    uint v[3] = { vA,vB,vC };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out uvec3 data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = uvec3(uint(n), uint(2*n), uint(4*n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uvec3 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    uvec3 eA; { const int n = 1 + (p+1); eA = uvec3(uint(n), uint(2*n), uint(4*n)); }
    uvec3 eB; { const int n = 1 + (p+2); eB = uvec3(uint(n), uint(2*n), uint(4*n)); }
    uvec3 eC; { const int n = 1 + (0); eC = uvec3(uint(n), uint(2*n), uint(4*n)); }

    uint e[9] = { eA.x,eA.y,eA.z,eB.x,eB.y,eB.z,eC.x,eC.y,eC.z };

    uvec3 vA; { vA = data[0]; }
    uvec3 vB; { vB = data[1]; }
    uvec3 vC; { vC = data[2]; }

    uint v[9] = { vA.x,vA.y,vA.z,vB.x,vB.y,vB.z,vC.x,vC.y,vC.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec3 q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(vec3(float(n), float(2*n), float(4*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec3 q;};


layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (p+1); eA = DataStruct(vec3(float(n), float(2*n), float(4*n))); }
    DataStruct eB; { const int n = 1 + (p+2); eB = DataStruct(vec3(float(n), float(2*n), float(4*n))); }
    DataStruct eC; { const int n = 1 + (0); eC = DataStruct(vec3(float(n), float(2*n), float(4*n))); }

    float e[9] = { eA.q.x,eA.q.y,eA.q.z,eB.q.x,eB.q.y,eB.q.z,eC.q.x,eC.q.y,eC.q.z };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }

    float v[9] = { vA.q.x,vA.q.y,vA.q.z,vB.q.x,vB.q.y,vB.q.z,vC.q.x,vC.q.y,vC.q.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {dvec3 q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(dvec3(double(n), double(2*n), double(4*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {dvec3 q;};


layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (p+1); eA = DataStruct(dvec3(double(n), double(2*n), double(4*n))); }
    DataStruct eB; { const int n = 1 + (p+2); eB = DataStruct(dvec3(double(n), double(2*n), double(4*n))); }
    DataStruct eC; { const int n = 1 + (0); eC = DataStruct(dvec3(double(n), double(2*n), double(4*n))); }

    double e[9] = { eA.q.x,eA.q.y,eA.q.z,eB.q.x,eB.q.y,eB.q.z,eC.q.x,eC.q.y,eC.q.z };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }

    double v[9] = { vA.q.x,vA.q.y,vA.q.z,vB.q.x,vB.q.y,vB.q.z,vC.q.x,vC.q.y,vC.q.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {uvec4 q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {uvec4 q;};


layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (p+1); eA = DataStruct(uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }
    DataStruct eB; { const int n = 1 + (p+2); eB = DataStruct(uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }
    DataStruct eC; { const int n = 1 + (0); eC = DataStruct(uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }

    uint e[12] = { eA.q.x,eA.q.y,eA.q.z,eA.q.w,eB.q.x,eB.q.y,eB.q.z,eB.q.w,eC.q.x,eC.q.y,eC.q.z,eC.q.w };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }

    uint v[12] = { vA.q.x,vA.q.y,vA.q.z,vA.q.w,vB.q.x,vB.q.y,vB.q.z,vB.q.w,vC.q.x,vC.q.y,vC.q.z,vC.q.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 2) flat in vec4 dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec4 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    vec4 eA[2]; { const int n = 1 + (p+1); eA = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    vec4 eB[2]; { const int n = 1 + (p+2); eB = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    vec4 eC[2]; { const int n = 1 + (0); eC = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n))); }

    float e[24] = { eA[0].x,eA[0].y,eA[0].z,eA[0].w,eA[1].x,eA[1].y,eA[1].z,eA[1].w,eB[0].x,eB[0].y,eB[0].z,eB[0].w,eB[1].x,eB[1].y,eB[1].z,eB[1].w,eC[0].x,eC[0].y,eC[0].z,eC[0].w,eC[1].x,eC[1].y,eC[1].z,eC[1].w };
    vec4 eFlatV[2]; { const int n = 1 + (p+1); eFlatV = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    float eFlat[24 / 3] = { eFlatV[0].x,eFlatV[0].y,eFlatV[0].z,eFlatV[0].w,eFlatV[1].x,eFlatV[1].y,eFlatV[1].z,eFlatV[1].w };

    vec4 vA[2]; { vA = vec4[2](data[0][0],data[0][1]); }
    vec4 vB[2]; { vB = vec4[2](data[1][0],data[1][1]); }
    vec4 vC[2]; { vC = vec4[2](data[2][0],data[2][1]); }
    vec4 vFlatV[2]; { vFlatV = vec4[2](dataFlat[0],dataFlat[1]); }
    float vFlat[24 / 3] = { vFlatV[0].x,vFlatV[0].y,vFlatV[0].z,vFlatV[0].w,vFlatV[1].x,vFlatV[1].y,vFlatV[1].z,vFlatV[1].w};

    float v[24] = { vA[0].x,vA[0].y,vA[0].z,vA[0].w,vA[1].x,vA[1].y,vA[1].z,vA[1].w,vB[0].x,vB[0].y,vB[0].z,vB[0].w,vB[1].x,vB[1].y,vB[1].z,vB[1].w,vC[0].x,vC[0].y,vC[0].z,vC[0].w,vC[1].x,vC[1].y,vC[1].z,vC[1].w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<24; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<24 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 4) flat in double dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in double data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    double eA[2]; { const int n = 1 + (p+1); eA = double[2](double(n), double(3)*double(n)); }
    double eB[2]; { const int n = 1 + (p+2); eB = double[2](double(n), double(3)*double(n)); }
    double eC[2]; { const int n = 1 + (0); eC = double[2](double(n), double(3)*double(n)); }

    double e[6] = { eA[0],eA[1],eB[0],eB[1],eC[0],eC[1] };
    double eFlatV[2]; { const int n = 1 + (p+1); eFlatV = double[2](double(n), double(3)*double(n)); }
    double eFlat[6 / 3] = { eFlatV[0],eFlatV[1] };

    double vA[2]; { vA = double[2](data[0][0],data[0][1]); }
    double vB[2]; { vB = double[2](data[1][0],data[1][1]); }
    double vC[2]; { vC = double[2](data[2][0],data[2][1]); }
    double vFlatV[2]; { vFlatV = double[2](dataFlat[0],dataFlat[1]); }
    double vFlat[6 / 3] = { vFlatV[0],vFlatV[1]};

    double v[6] = { vA[0],vA[1],vB[0],vB[1],vC[0],vC[1] };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out dvec4 data[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = dvec4[2](dvec4(double(n), double(2*n), double(4*n), double(8*n)), double(3)*dvec4(double(n), double(2*n), double(4*n), double(8*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec4 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    dvec4 eA[2]; { const int n = 1 + (p+1); eA = dvec4[2](dvec4(double(n), double(2*n), double(4*n), double(8*n)), double(3)*dvec4(double(n), double(2*n), double(4*n), double(8*n))); }
    dvec4 eB[2]; { const int n = 1 + (p+2); eB = dvec4[2](dvec4(double(n), double(2*n), double(4*n), double(8*n)), double(3)*dvec4(double(n), double(2*n), double(4*n), double(8*n))); }
    dvec4 eC[2]; { const int n = 1 + (0); eC = dvec4[2](dvec4(double(n), double(2*n), double(4*n), double(8*n)), double(3)*dvec4(double(n), double(2*n), double(4*n), double(8*n))); }

    double e[24] = { eA[0].x,eA[0].y,eA[0].z,eA[0].w,eA[1].x,eA[1].y,eA[1].z,eA[1].w,eB[0].x,eB[0].y,eB[0].z,eB[0].w,eB[1].x,eB[1].y,eB[1].z,eB[1].w,eC[0].x,eC[0].y,eC[0].z,eC[0].w,eC[1].x,eC[1].y,eC[1].z,eC[1].w };

    dvec4 vA[2]; { vA = dvec4[2](data[0][0],data[0][1]); }
    dvec4 vB[2]; { vB = dvec4[2](data[1][0],data[1][1]); }
    dvec4 vC[2]; { vC = dvec4[2](data[2][0],data[2][1]); }

    double v[24] = { vA[0].x,vA[0].y,vA[0].z,vA[0].w,vA[1].x,vA[1].y,vA[1].z,vA[1].w,vB[0].x,vB[0].y,vB[0].z,vB[0].w,vB[1].x,vB[1].y,vB[1].z,vB[1].w,vC[0].x,vC[0].y,vC[0].z,vC[0].w,vC[1].x,vC[1].y,vC[1].z,vC[1].w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<24; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 2) flat in ivec4 dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in ivec4 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    ivec4 eA[2]; { const int n = 1 + (p+1); eA = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n))); }
    ivec4 eB[2]; { const int n = 1 + (p+2); eB = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n))); }
    ivec4 eC[2]; { const int n = 1 + (0); eC = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n))); }

    int e[24] = { eA[0].x,eA[0].y,eA[0].z,eA[0].w,eA[1].x,eA[1].y,eA[1].z,eA[1].w,eB[0].x,eB[0].y,eB[0].z,eB[0].w,eB[1].x,eB[1].y,eB[1].z,eB[1].w,eC[0].x,eC[0].y,eC[0].z,eC[0].w,eC[1].x,eC[1].y,eC[1].z,eC[1].w };
    ivec4 eFlatV[2]; { const int n = 1 + (p+1); eFlatV = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n))); }
    int eFlat[24 / 3] = { eFlatV[0].x,eFlatV[0].y,eFlatV[0].z,eFlatV[0].w,eFlatV[1].x,eFlatV[1].y,eFlatV[1].z,eFlatV[1].w };

    ivec4 vA[2]; { vA = ivec4[2](data[0][0],data[0][1]); }
    ivec4 vB[2]; { vB = ivec4[2](data[1][0],data[1][1]); }
    ivec4 vC[2]; { vC = ivec4[2](data[2][0],data[2][1]); }
    ivec4 vFlatV[2]; { vFlatV = ivec4[2](dataFlat[0],dataFlat[1]); }
    int vFlat[24 / 3] = { vFlatV[0].x,vFlatV[0].y,vFlatV[0].z,vFlatV[0].w,vFlatV[1].x,vFlatV[1].y,vFlatV[1].z,vFlatV[1].w};

    int v[24] = { vA[0].x,vA[0].y,vA[0].z,vA[0].w,vA[1].x,vA[1].y,vA[1].z,vA[1].w,vB[0].x,vB[0].y,vB[0].z,vB[0].w,vB[1].x,vB[1].y,vB[1].z,vB[1].w,vC[0].x,vC[0].y,vC[0].z,vC[0].w,vC[1].x,vC[1].y,vC[1].z,vC[1].w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<24; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<24 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out uint data[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = uint[2](uint(n), uint(3)*uint(n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uint data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    uint eA[2]; { const int n = 1 + (p+1); eA = uint[2](uint(n), uint(3)*uint(n)); }
    uint eB[2]; { const int n = 1 + (p+2); eB = uint[2](uint(n), uint(3)*uint(n)); }
    uint eC[2]; { const int n = 1 + (0); eC = uint[2](uint(n), uint(3)*uint(n)); }

    uint e[6] = { eA[0],eA[1],eB[0],eB[1],eC[0],eC[1] };

    uint vA[2]; { vA = uint[2](data[0][0],data[0][1]); }
    uint vB[2]; { vB = uint[2](data[1][0],data[1][1]); }
    uint vC[2]; { vC = uint[2](data[2][0],data[2][1]); }

    uint v[6] = { vA[0],vA[1],vB[0],vB[1],vC[0],vC[1] };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out uvec3 data[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = uvec3[2](uvec3(uint(n), uint(2*n), uint(4*n)), uint(3)*uvec3(uint(n), uint(2*n), uint(4*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uvec3 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    uvec3 eA[2]; { const int n = 1 + (p+1); eA = uvec3[2](uvec3(uint(n), uint(2*n), uint(4*n)), uint(3)*uvec3(uint(n), uint(2*n), uint(4*n))); }
    uvec3 eB[2]; { const int n = 1 + (p+2); eB = uvec3[2](uvec3(uint(n), uint(2*n), uint(4*n)), uint(3)*uvec3(uint(n), uint(2*n), uint(4*n))); }
    uvec3 eC[2]; { const int n = 1 + (0); eC = uvec3[2](uvec3(uint(n), uint(2*n), uint(4*n)), uint(3)*uvec3(uint(n), uint(2*n), uint(4*n))); }

    uint e[18] = { eA[0].x,eA[0].y,eA[0].z,eA[1].x,eA[1].y,eA[1].z,eB[0].x,eB[0].y,eB[0].z,eB[1].x,eB[1].y,eB[1].z,eC[0].x,eC[0].y,eC[0].z,eC[1].x,eC[1].y,eC[1].z };

    uvec3 vA[2]; { vA = uvec3[2](data[0][0],data[0][1]); }
    uvec3 vB[2]; { vB = uvec3[2](data[1][0],data[1][1]); }
    uvec3 vC[2]; { vC = uvec3[2](data[2][0],data[2][1]); }

    uint v[18] = { vA[0].x,vA[0].y,vA[0].z,vA[1].x,vA[1].y,vA[1].z,vB[0].x,vB[0].y,vB[0].z,vB[1].x,vB[1].y,vB[1].z,vC[0].x,vC[0].y,vC[0].z,vC[1].x,vC[1].y,vC[1].z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<18; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in double data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    double eA; { const int n = 1 + (4*p+1); eA = double(n); }
    double eB; { const int n = 1 + (4*p+2); eB = double(n); }
    double eC; { const int n = 1 + (4*p+2); eC = double(n); }

    double e[3] = { eA,eB,eC };

    double vA; { vA = data[0]; }
    double vB; { vB = data[1]; }
    double vC; { vC = data[2]; }

    double v[3] = { vA,vB,vC };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out ivec4 data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = ivec4(int(n), int(2*n), int(4*n), int(8*n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in ivec4 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    ivec4 eA; { const int n = 1 + (4*p+1); eA = ivec4(int(n), int(2*n), int(4*n), int(8*n)); }
    ivec4 eB; { const int n = 1 + (4*p+2); eB = ivec4(int(n), int(2*n), int(4*n), int(8*n)); }
    ivec4 eC; { const int n = 1 + (4*p+2); eC = ivec4(int(n), int(2*n), int(4*n), int(8*n)); }

    int e[12] = { eA.x,eA.y,eA.z,eA.w,eB.x,eB.y,eB.z,eB.w,eC.x,eC.y,eC.z,eC.w };

    ivec4 vA; { vA = data[0]; }
    ivec4 vB; { vB = data[1]; }
    ivec4 vC; { vC = data[2]; }

    int v[12] = { vA.x,vA.y,vA.z,vA.w,vB.x,vB.y,vB.z,vB.w,vC.x,vC.y,vC.z,vC.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 1) flat in uvec3 dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uvec3 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    uvec3 eA; { const int n = 1 + (4*p+1); eA = uvec3(uint(n), uint(2*n), uint(4*n)); }
    uvec3 eB; { const int n = 1 + (4*p+2); eB = uvec3(uint(n), uint(2*n), uint(4*n)); }
    uvec3 eC; { const int n = 1 + (4*p+2); eC = uvec3(uint(n), uint(2*n), uint(4*n)); }

    uint e[9] = { eA.x,eA.y,eA.z,eB.x,eB.y,eB.z,eC.x,eC.y,eC.z };
    uvec3 eFlatV; { const int n = 1 + (4*p+1); eFlatV = uvec3(uint(n), uint(2*n), uint(4*n)); }
    uint eFlat[9 / 3] = { eFlatV.x,eFlatV.y,eFlatV.z };

    uvec3 vA; { vA = data[0]; }
    uvec3 vB; { vB = data[1]; }
    uvec3 vC; { vC = data[2]; }
    uvec3 vFlatV; { vFlatV = dataFlat; }
    uint vFlat[9 / 3] = { vFlatV.x,vFlatV.y,vFlatV.z};

    uint v[9] = { vA.x,vA.y,vA.z,vB.x,vB.y,vB.z,vC.x,vC.y,vC.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<9 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {dvec4 q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;
layout(location = 2) out DataStruct dataFlat;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(dvec4(double(n), double(2*n), double(4*n), double(8*n)));
    dataFlat      = DataStruct(dvec4(double(n), double(2*n), double(4*n), double(8*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {dvec4 q;};


layout(location = 2) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (4*p+1); eA = DataStruct(dvec4(double(n), double(2*n), double(4*n), double(8*n))); }
    DataStruct eB; { const int n = 1 + (4*p+2); eB = DataStruct(dvec4(double(n), double(2*n), double(4*n), double(8*n))); }
    DataStruct eC; { const int n = 1 + (4*p+2); eC = DataStruct(dvec4(double(n), double(2*n), double(4*n), double(8*n))); }

    double e[12] = { eA.q.x,eA.q.y,eA.q.z,eA.q.w,eB.q.x,eB.q.y,eB.q.z,eB.q.w,eC.q.x,eC.q.y,eC.q.z,eC.q.w };
    DataStruct eFlatV; { const int n = 1 + (4*p+1); eFlatV = DataStruct(dvec4(double(n), double(2*n), double(4*n), double(8*n))); }
    double eFlat[12 / 3] = { eFlatV.q.x,eFlatV.q.y,eFlatV.q.z,eFlatV.q.w };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    double vFlat[12 / 3] = { vFlatV.q.x,vFlatV.q.y,vFlatV.q.z,vFlatV.q.w};

    double v[12] = { vA.q.x,vA.q.y,vA.q.z,vA.q.w,vB.q.x,vB.q.y,vB.q.z,vB.q.w,vC.q.x,vC.q.y,vC.q.z,vC.q.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<12 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {uvec2 q;};


layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (4*p+1); eA = DataStruct(uvec2(uint(n), uint(2*n))); }
    DataStruct eB; { const int n = 1 + (4*p+2); eB = DataStruct(uvec2(uint(n), uint(2*n))); }
    DataStruct eC; { const int n = 1 + (4*p+2); eC = DataStruct(uvec2(uint(n), uint(2*n))); }

    uint e[6] = { eA.q.x,eA.q.y,eB.q.x,eB.q.y,eC.q.x,eC.q.y };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }

    uint v[6] = { vA.q.x,vA.q.y,vB.q.x,vB.q.y,vC.q.x,vC.q.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {uvec2 q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;
layout(location = 1) out DataStruct dataFlat;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(uvec2(uint(n), uint(2*n)));
    dataFlat      = DataStruct(uvec2(uint(n), uint(2*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {uvec2 q;};


layout(location = 1) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (4*p+1); eA = DataStruct(uvec2(uint(n), uint(2*n))); }
    DataStruct eB; { const int n = 1 + (4*p+2); eB = DataStruct(uvec2(uint(n), uint(2*n))); }
    DataStruct eC; { const int n = 1 + (4*p+2); eC = DataStruct(uvec2(uint(n), uint(2*n))); }

    uint e[6] = { eA.q.x,eA.q.y,eB.q.x,eB.q.y,eC.q.x,eC.q.y };
    DataStruct eFlatV; { const int n = 1 + (4*p+1); eFlatV = DataStruct(uvec2(uint(n), uint(2*n))); }
    uint eFlat[6 / 3] = { eFlatV.q.x,eFlatV.q.y };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    uint vFlat[6 / 3] = { vFlatV.q.x,vFlatV.q.y};

    uint v[6] = { vA.q.x,vA.q.y,vB.q.x,vB.q.y,vC.q.x,vC.q.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in float data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    float eA[2]; { const int n = 1 + (4*p+1); eA = float[2](float(n), float(3)*float(n)); }
    float eB[2]; { const int n = 1 + (4*p+2); eB = float[2](float(n), float(3)*float(n)); }
    float eC[2]; { const int n = 1 + (4*p+2); eC = float[2](float(n), float(3)*float(n)); }

    float e[6] = { eA[0],eA[1],eB[0],eB[1],eC[0],eC[1] };

    float vA[2]; { vA = float[2](data[0][0],data[0][1]); }
    float vB[2]; { vB = float[2](data[1][0],data[1][1]); }
    float vC[2]; { vC = float[2](data[2][0],data[2][1]); }

    float v[6] = { vA[0],vA[1],vB[0],vB[1],vC[0],vC[1] };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out double data[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = double[2](double(n), double(3)*double(n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in double data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    double eA[2]; { const int n = 1 + (4*p+1); eA = double[2](double(n), double(3)*double(n)); }
    double eB[2]; { const int n = 1 + (4*p+2); eB = double[2](double(n), double(3)*double(n)); }
    double eC[2]; { const int n = 1 + (4*p+2); eC = double[2](double(n), double(3)*double(n)); }

    double e[6] = { eA[0],eA[1],eB[0],eB[1],eC[0],eC[1] };

    double vA[2]; { vA = double[2](data[0][0],data[0][1]); }
    double vB[2]; { vB = double[2](data[1][0],data[1][1]); }
    double vC[2]; { vC = double[2](data[2][0],data[2][1]); }

    double v[6] = { vA[0],vA[1],vB[0],vB[1],vC[0],vC[1] };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec2 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    dvec2 eA[2]; { const int n = 1 + (4*p+1); eA = dvec2[2](dvec2(double(n), double(2*n)), double(3)*dvec2(double(n), double(2*n))); }
    dvec2 eB[2]; { const int n = 1 + (4*p+2); eB = dvec2[2](dvec2(double(n), double(2*n)), double(3)*dvec2(double(n), double(2*n))); }
    dvec2 eC[2]; { const int n = 1 + (4*p+2); eC = dvec2[2](dvec2(double(n), double(2*n)), double(3)*dvec2(double(n), double(2*n))); }

    double e[12] = { eA[0].x,eA[0].y,eA[1].x,eA[1].y,eB[0].x,eB[0].y,eB[1].x,eB[1].y,eC[0].x,eC[0].y,eC[1].x,eC[1].y };

    dvec2 vA[2]; { vA = dvec2[2](data[0][0],data[0][1]); }
    dvec2 vB[2]; { vB = dvec2[2](data[1][0],data[1][1]); }
    dvec2 vC[2]; { vC = dvec2[2](data[2][0],data[2][1]); }

    double v[12] = { vA[0].x,vA[0].y,vA[1].x,vA[1].y,vB[0].x,vB[0].y,vB[1].x,vB[1].y,vC[0].x,vC[0].y,vC[1].x,vC[1].y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out uvec3 data[2];
layout(location = 2) out uvec3 dataFlat[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = uvec3[2](uvec3(uint(n), uint(2*n), uint(4*n)), uint(3)*uvec3(uint(n), uint(2*n), uint(4*n)));
    dataFlat      = uvec3[2](uvec3(uint(n), uint(2*n), uint(4*n)), uint(3)*uvec3(uint(n), uint(2*n), uint(4*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 2) flat in uvec3 dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uvec3 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    uvec3 eA[2]; { const int n = 1 + (4*p+1); eA = uvec3[2](uvec3(uint(n), uint(2*n), uint(4*n)), uint(3)*uvec3(uint(n), uint(2*n), uint(4*n))); }
    uvec3 eB[2]; { const int n = 1 + (4*p+2); eB = uvec3[2](uvec3(uint(n), uint(2*n), uint(4*n)), uint(3)*uvec3(uint(n), uint(2*n), uint(4*n))); }
    uvec3 eC[2]; { const int n = 1 + (4*p+2); eC = uvec3[2](uvec3(uint(n), uint(2*n), uint(4*n)), uint(3)*uvec3(uint(n), uint(2*n), uint(4*n))); }

    uint e[18] = { eA[0].x,eA[0].y,eA[0].z,eA[1].x,eA[1].y,eA[1].z,eB[0].x,eB[0].y,eB[0].z,eB[1].x,eB[1].y,eB[1].z,eC[0].x,eC[0].y,eC[0].z,eC[1].x,eC[1].y,eC[1].z };
    uvec3 eFlatV[2]; { const int n = 1 + (4*p+1); eFlatV = uvec3[2](uvec3(uint(n), uint(2*n), uint(4*n)), uint(3)*uvec3(uint(n), uint(2*n), uint(4*n))); }
    uint eFlat[18 / 3] = { eFlatV[0].x,eFlatV[0].y,eFlatV[0].z,eFlatV[1].x,eFlatV[1].y,eFlatV[1].z };

    uvec3 vA[2]; { vA = uvec3[2](data[0][0],data[0][1]); }
    uvec3 vB[2]; { vB = uvec3[2](data[1][0],data[1][1]); }
    uvec3 vC[2]; { vC = uvec3[2](data[2][0],data[2][1]); }
    uvec3 vFlatV[2]; { vFlatV = uvec3[2](dataFlat[0],dataFlat[1]); }
    uint vFlat[18 / 3] = { vFlatV[0].x,vFlatV[0].y,vFlatV[0].z,vFlatV[1].x,vFlatV[1].y,vFlatV[1].z};

    uint v[18] = { vA[0].x,vA[0].y,vA[0].z,vA[1].x,vA[1].y,vA[1].z,vB[0].x,vB[0].y,vB[0].z,vB[1].x,vB[1].y,vB[1].z,vC[0].x,vC[0].y,vC[0].z,vC[1].x,vC[1].y,vC[1].z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<18; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<18 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out ivec3 data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = ivec3(int(n), int(2*n), int(4*n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in ivec3 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = 2*y;
    const bool even = (p%2 == 0);

    ivec3 eA; { const int n = 1 + (p+1); eA = ivec3(int(n), int(2*n), int(4*n)); }
    ivec3 eB; { const int n = 1 + (p+2); eB = ivec3(int(n), int(2*n), int(4*n)); }
    ivec3 eC; { const int n = 1 + (p+2); eC = ivec3(int(n), int(2*n), int(4*n)); }

    int e[9] = { eA.x,eA.y,eA.z,eB.x,eB.y,eB.z,eC.x,eC.y,eC.z };

    ivec3 vA; { vA = data[0]; }
    ivec3 vB; { vB = data[1]; }
    ivec3 vC; { vC = data[2]; }

    int v[9] = { vA.x,vA.y,vA.z,vB.x,vB.y,vB.z,vC.x,vC.y,vC.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uint data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = 2*y;
    const bool even = (p%2 == 0);

    uint eA; { const int n = 1 + (p+1); eA = uint(n); }
    uint eB; { const int n = 1 + (p+2); eB = uint(n); }
    uint eC; { const int n = 1 + (p+2); eC = uint(n); }

    uint e[3] = { eA,eB,eC };

    uint vA; { vA = data[0]; }
    uint vB; { vB = data[1]; }
    uint vC; { vC = data[2]; }

    uint v[3] = { vA,vB,vC };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {double q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(double(n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {double q;};


layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = 2*y;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (p+1); eA = DataStruct(double(n)); }
    DataStruct eB; { const int n = 1 + (p+2); eB = DataStruct(double(n)); }
    DataStruct eC; { const int n = 1 + (p+2); eC = DataStruct(double(n)); }

    double e[3] = { eA.q,eB.q,eC.q };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }

    double v[3] = { vA.q,vB.q,vC.q };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {dvec3 q;};


layout(location = 2) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = 2*y;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (p+1); eA = DataStruct(dvec3(double(n), double(2*n), double(4*n))); }
    DataStruct eB; { const int n = 1 + (p+2); eB = DataStruct(dvec3(double(n), double(2*n), double(4*n))); }
    DataStruct eC; { const int n = 1 + (p+2); eC = DataStruct(dvec3(double(n), double(2*n), double(4*n))); }

    double e[9] = { eA.q.x,eA.q.y,eA.q.z,eB.q.x,eB.q.y,eB.q.z,eC.q.x,eC.q.y,eC.q.z };
    DataStruct eFlatV; { const int n = 1 + (p+1); eFlatV = DataStruct(dvec3(double(n), double(2*n), double(4*n))); }
    double eFlat[9 / 3] = { eFlatV.q.x,eFlatV.q.y,eFlatV.q.z };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    double vFlat[9 / 3] = { vFlatV.q.x,vFlatV.q.y,vFlatV.q.z};

    double v[9] = { vA.q.x,vA.q.y,vA.q.z,vB.q.x,vB.q.y,vB.q.z,vC.q.x,vC.q.y,vC.q.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<9 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {uint q;};


layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = 2*y;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (p+1); eA = DataStruct(uint(n)); }
    DataStruct eB; { const int n = 1 + (p+2); eB = DataStruct(uint(n)); }
    DataStruct eC; { const int n = 1 + (p+2); eC = DataStruct(uint(n)); }

    uint e[3] = { eA.q,eB.q,eC.q };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }

    uint v[3] = { vA.q,vB.q,vC.q };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {uvec2 q;};


layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = 2*y;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (p+1); eA = DataStruct(uvec2(uint(n), uint(2*n))); }
    DataStruct eB; { const int n = 1 + (p+2); eB = DataStruct(uvec2(uint(n), uint(2*n))); }
    DataStruct eC; { const int n = 1 + (p+2); eC = DataStruct(uvec2(uint(n), uint(2*n))); }

    uint e[6] = { eA.q.x,eA.q.y,eB.q.x,eB.q.y,eC.q.x,eC.q.y };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }

    uint v[6] = { vA.q.x,vA.q.y,vB.q.x,vB.q.y,vC.q.x,vC.q.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in float data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = 2*y;
    const bool even = (p%2 == 0);

    float eA[2]; { const int n = 1 + (p+1); eA = float[2](float(n), float(3)*float(n)); }
    float eB[2]; { const int n = 1 + (p+2); eB = float[2](float(n), float(3)*float(n)); }
    float eC[2]; { const int n = 1 + (p+2); eC = float[2](float(n), float(3)*float(n)); }

    float e[6] = { eA[0],eA[1],eB[0],eB[1],eC[0],eC[1] };

    float vA[2]; { vA = float[2](data[0][0],data[0][1]); }
    float vB[2]; { vB = float[2](data[1][0],data[1][1]); }
    float vC[2]; { vC = float[2](data[2][0],data[2][1]); }

    float v[6] = { vA[0],vA[1],vB[0],vB[1],vC[0],vC[1] };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec3 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = 2*y;
    const bool even = (p%2 == 0);

    vec3 eA[2]; { const int n = 1 + (p+1); eA = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n))); }
    vec3 eB[2]; { const int n = 1 + (p+2); eB = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n))); }
    vec3 eC[2]; { const int n = 1 + (p+2); eC = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n))); }

    float e[18] = { eA[0].x,eA[0].y,eA[0].z,eA[1].x,eA[1].y,eA[1].z,eB[0].x,eB[0].y,eB[0].z,eB[1].x,eB[1].y,eB[1].z,eC[0].x,eC[0].y,eC[0].z,eC[1].x,eC[1].y,eC[1].z };

    vec3 vA[2]; { vA = vec3[2](data[0][0],data[0][1]); }
    vec3 vB[2]; { vB = vec3[2](data[1][0],data[1][1]); }
    vec3 vC[2]; { vC = vec3[2](data[2][0],data[2][1]); }

    float v[18] = { vA[0].x,vA[0].y,vA[0].z,vA[1].x,vA[1].y,vA[1].z,vB[0].x,vB[0].y,vB[0].z,vB[1].x,vB[1].y,vB[1].z,vC[0].x,vC[0].y,vC[0].z,vC[1].x,vC[1].y,vC[1].z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<18; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec2 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = 2*y;
    const bool even = (p%2 == 0);

    dvec2 eA[2]; { const int n = 1 + (p+1); eA = dvec2[2](dvec2(double(n), double(2*n)), double(3)*dvec2(double(n), double(2*n))); }
    dvec2 eB[2]; { const int n = 1 + (p+2); eB = dvec2[2](dvec2(double(n), double(2*n)), double(3)*dvec2(double(n), double(2*n))); }
    dvec2 eC[2]; { const int n = 1 + (p+2); eC = dvec2[2](dvec2(double(n), double(2*n)), double(3)*dvec2(double(n), double(2*n))); }

    double e[12] = { eA[0].x,eA[0].y,eA[1].x,eA[1].y,eB[0].x,eB[0].y,eB[1].x,eB[1].y,eC[0].x,eC[0].y,eC[1].x,eC[1].y };

    dvec2 vA[2]; { vA = dvec2[2](data[0][0],data[0][1]); }
    dvec2 vB[2]; { vB = dvec2[2](data[1][0],data[1][1]); }
    dvec2 vC[2]; { vC = dvec2[2](data[2][0],data[2][1]); }

    double v[12] = { vA[0].x,vA[0].y,vA[1].x,vA[1].y,vB[0].x,vB[0].y,vB[1].x,vB[1].y,vC[0].x,vC[0].y,vC[1].x,vC[1].y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 4) flat in dvec2 dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec2 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = 2*y;
    const bool even = (p%2 == 0);

    dvec2 eA[2]; { const int n = 1 + (p+1); eA = dvec2[2](dvec2(double(n), double(2*n)), double(3)*dvec2(double(n), double(2*n))); }
    dvec2 eB[2]; { const int n = 1 + (p+2); eB = dvec2[2](dvec2(double(n), double(2*n)), double(3)*dvec2(double(n), double(2*n))); }
    dvec2 eC[2]; { const int n = 1 + (p+2); eC = dvec2[2](dvec2(double(n), double(2*n)), double(3)*dvec2(double(n), double(2*n))); }

    double e[12] = { eA[0].x,eA[0].y,eA[1].x,eA[1].y,eB[0].x,eB[0].y,eB[1].x,eB[1].y,eC[0].x,eC[0].y,eC[1].x,eC[1].y };
    dvec2 eFlatV[2]; { const int n = 1 + (p+1); eFlatV = dvec2[2](dvec2(double(n), double(2*n)), double(3)*dvec2(double(n), double(2*n))); }
    double eFlat[12 / 3] = { eFlatV[0].x,eFlatV[0].y,eFlatV[1].x,eFlatV[1].y };

    dvec2 vA[2]; { vA = dvec2[2](data[0][0],data[0][1]); }
    dvec2 vB[2]; { vB = dvec2[2](data[1][0],data[1][1]); }
    dvec2 vC[2]; { vC = dvec2[2](data[2][0],data[2][1]); }
    dvec2 vFlatV[2]; { vFlatV = dvec2[2](dataFlat[0],dataFlat[1]); }
    double vFlat[12 / 3] = { vFlatV[0].x,vFlatV[0].y,vFlatV[1].x,vFlatV[1].y};

    double v[12] = { vA[0].x,vA[0].y,vA[1].x,vA[1].y,vB[0].x,vB[0].y,vB[1].x,vB[1].y,vC[0].x,vC[0].y,vC[1].x,vC[1].y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<12 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 2) flat in uvec4 dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uvec4 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = 2*y;
    const bool even = (p%2 == 0);

    uvec4 eA[2]; { const int n = 1 + (p+1); eA = uvec4[2](uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)), uint(3)*uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }
    uvec4 eB[2]; { const int n = 1 + (p+2); eB = uvec4[2](uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)), uint(3)*uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }
    uvec4 eC[2]; { const int n = 1 + (p+2); eC = uvec4[2](uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)), uint(3)*uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }

    uint e[24] = { eA[0].x,eA[0].y,eA[0].z,eA[0].w,eA[1].x,eA[1].y,eA[1].z,eA[1].w,eB[0].x,eB[0].y,eB[0].z,eB[0].w,eB[1].x,eB[1].y,eB[1].z,eB[1].w,eC[0].x,eC[0].y,eC[0].z,eC[0].w,eC[1].x,eC[1].y,eC[1].z,eC[1].w };
    uvec4 eFlatV[2]; { const int n = 1 + (p+1); eFlatV = uvec4[2](uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)), uint(3)*uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }
    uint eFlat[24 / 3] = { eFlatV[0].x,eFlatV[0].y,eFlatV[0].z,eFlatV[0].w,eFlatV[1].x,eFlatV[1].y,eFlatV[1].z,eFlatV[1].w };

    uvec4 vA[2]; { vA = uvec4[2](data[0][0],data[0][1]); }
    uvec4 vB[2]; { vB = uvec4[2](data[1][0],data[1][1]); }
    uvec4 vC[2]; { vC = uvec4[2](data[2][0],data[2][1]); }
    uvec4 vFlatV[2]; { vFlatV = uvec4[2](dataFlat[0],dataFlat[1]); }
    uint vFlat[24 / 3] = { vFlatV[0].x,vFlatV[0].y,vFlatV[0].z,vFlatV[0].w,vFlatV[1].x,vFlatV[1].y,vFlatV[1].z,vFlatV[1].w};

    uint v[24] = { vA[0].x,vA[0].y,vA[0].z,vA[0].w,vA[1].x,vA[1].y,vA[1].z,vA[1].w,vB[0].x,vB[0].y,vB[0].z,vB[0].w,vB[1].x,vB[1].y,vB[1].z,vB[1].w,vC[0].x,vC[0].y,vC[0].z,vC[0].w,vC[1].x,vC[1].y,vC[1].z,vC[1].w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<24; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<24 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 1) flat in float dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in float data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    float eA; { const int n = 1 + (6*p); eA = float(n); }
    float eB; { const int n = 1 + (6*p+2); eB = float(n); }
    float eC; { const int n = 1 + (6*p+4); eC = float(n); }

    float e[3] = { eA,eB,eC };
    float eFlatV; { const int n = 1 + (6*p); eFlatV = float(n); }
    float eFlat[3 / 3] = { eFlatV };

    float vA; { vA = data[0]; }
    float vB; { vB = data[1]; }
    float vC; { vC = data[2]; }
    float vFlatV; { vFlatV = dataFlat; }
    float vFlat[3 / 3] = { vFlatV};

    float v[3] = { vA,vB,vC };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<3 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 1) flat in ivec2 dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in ivec2 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    ivec2 eA; { const int n = 1 + (6*p); eA = ivec2(int(n), int(2*n)); }
    ivec2 eB; { const int n = 1 + (6*p+2); eB = ivec2(int(n), int(2*n)); }
    ivec2 eC; { const int n = 1 + (6*p+4); eC = ivec2(int(n), int(2*n)); }

    int e[6] = { eA.x,eA.y,eB.x,eB.y,eC.x,eC.y };
    ivec2 eFlatV; { const int n = 1 + (6*p); eFlatV = ivec2(int(n), int(2*n)); }
    int eFlat[6 / 3] = { eFlatV.x,eFlatV.y };

    ivec2 vA; { vA = data[0]; }
    ivec2 vB; { vB = data[1]; }
    ivec2 vC; { vC = data[2]; }
    ivec2 vFlatV; { vFlatV = dataFlat; }
    int vFlat[6 / 3] = { vFlatV.x,vFlatV.y};

    int v[6] = { vA.x,vA.y,vB.x,vB.y,vC.x,vC.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {float q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;
layout(location = 1) out DataStruct dataFlat;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(float(n));
    dataFlat      = DataStruct(float(n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {float q;};


layout(location = 1) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (6*p); eA = DataStruct(float(n)); }
    DataStruct eB; { const int n = 1 + (6*p+2); eB = DataStruct(float(n)); }
    DataStruct eC; { const int n = 1 + (6*p+4); eC = DataStruct(float(n)); }

    float e[3] = { eA.q,eB.q,eC.q };
    DataStruct eFlatV; { const int n = 1 + (6*p); eFlatV = DataStruct(float(n)); }
    float eFlat[3 / 3] = { eFlatV.q };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    float vFlat[3 / 3] = { vFlatV.q};

    float v[3] = { vA.q,vB.q,vC.q };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<3 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec4 q;};


layout(location = 1) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (6*p); eA = DataStruct(vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    DataStruct eB; { const int n = 1 + (6*p+2); eB = DataStruct(vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    DataStruct eC; { const int n = 1 + (6*p+4); eC = DataStruct(vec4(float(n), float(2*n), float(4*n), float(8*n))); }

    float e[12] = { eA.q.x,eA.q.y,eA.q.z,eA.q.w,eB.q.x,eB.q.y,eB.q.z,eB.q.w,eC.q.x,eC.q.y,eC.q.z,eC.q.w };
    DataStruct eFlatV; { const int n = 1 + (6*p); eFlatV = DataStruct(vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    float eFlat[12 / 3] = { eFlatV.q.x,eFlatV.q.y,eFlatV.q.z,eFlatV.q.w };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    float vFlat[12 / 3] = { vFlatV.q.x,vFlatV.q.y,vFlatV.q.z,vFlatV.q.w};

    float v[12] = { vA.q.x,vA.q.y,vA.q.z,vA.q.w,vB.q.x,vB.q.y,vB.q.z,vB.q.w,vC.q.x,vC.q.y,vC.q.z,vC.q.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<12 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {double q;};


layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (6*p); eA = DataStruct(double(n)); }
    DataStruct eB; { const int n = 1 + (6*p+2); eB = DataStruct(double(n)); }
    DataStruct eC; { const int n = 1 + (6*p+4); eC = DataStruct(double(n)); }

    double e[3] = { eA.q,eB.q,eC.q };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }

    double v[3] = { vA.q,vB.q,vC.q };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {double q;};


layout(location = 2) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (6*p); eA = DataStruct(double(n)); }
    DataStruct eB; { const int n = 1 + (6*p+2); eB = DataStruct(double(n)); }
    DataStruct eC; { const int n = 1 + (6*p+4); eC = DataStruct(double(n)); }

    double e[3] = { eA.q,eB.q,eC.q };
    DataStruct eFlatV; { const int n = 1 + (6*p); eFlatV = DataStruct(double(n)); }
    double eFlat[3 / 3] = { eFlatV.q };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    double vFlat[3 / 3] = { vFlatV.q};

    double v[3] = { vA.q,vB.q,vC.q };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<3 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {int q;};


layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (6*p); eA = DataStruct(int(n)); }
    DataStruct eB; { const int n = 1 + (6*p+2); eB = DataStruct(int(n)); }
    DataStruct eC; { const int n = 1 + (6*p+4); eC = DataStruct(int(n)); }

    int e[3] = { eA.q,eB.q,eC.q };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }

    int v[3] = { vA.q,vB.q,vC.q };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {ivec2 q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;
layout(location = 1) out DataStruct dataFlat;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(ivec2(int(n), int(2*n)));
    dataFlat      = DataStruct(ivec2(int(n), int(2*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {ivec2 q;};


layout(location = 1) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (6*p); eA = DataStruct(ivec2(int(n), int(2*n))); }
    DataStruct eB; { const int n = 1 + (6*p+2); eB = DataStruct(ivec2(int(n), int(2*n))); }
    DataStruct eC; { const int n = 1 + (6*p+4); eC = DataStruct(ivec2(int(n), int(2*n))); }

    int e[6] = { eA.q.x,eA.q.y,eB.q.x,eB.q.y,eC.q.x,eC.q.y };
    DataStruct eFlatV; { const int n = 1 + (6*p); eFlatV = DataStruct(ivec2(int(n), int(2*n))); }
    int eFlat[6 / 3] = { eFlatV.q.x,eFlatV.q.y };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    int vFlat[6 / 3] = { vFlatV.q.x,vFlatV.q.y};

    int v[6] = { vA.q.x,vA.q.y,vB.q.x,vB.q.y,vC.q.x,vC.q.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {ivec3 q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(ivec3(int(n), int(2*n), int(4*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {ivec3 q;};


layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (6*p); eA = DataStruct(ivec3(int(n), int(2*n), int(4*n))); }
    DataStruct eB; { const int n = 1 + (6*p+2); eB = DataStruct(ivec3(int(n), int(2*n), int(4*n))); }
    DataStruct eC; { const int n = 1 + (6*p+4); eC = DataStruct(ivec3(int(n), int(2*n), int(4*n))); }

    int e[9] = { eA.q.x,eA.q.y,eA.q.z,eB.q.x,eB.q.y,eB.q.z,eC.q.x,eC.q.y,eC.q.z };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }

    int v[9] = { vA.q.x,vA.q.y,vA.q.z,vB.q.x,vB.q.y,vB.q.z,vC.q.x,vC.q.y,vC.q.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {uint q;};


layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (6*p); eA = DataStruct(uint(n)); }
    DataStruct eB; { const int n = 1 + (6*p+2); eB = DataStruct(uint(n)); }
    DataStruct eC; { const int n = 1 + (6*p+4); eC = DataStruct(uint(n)); }

    uint e[3] = { eA.q,eB.q,eC.q };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }

    uint v[3] = { vA.q,vB.q,vC.q };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec3 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    vec3 eA[2]; { const int n = 1 + (6*p); eA = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n))); }
    vec3 eB[2]; { const int n = 1 + (6*p+2); eB = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n))); }
    vec3 eC[2]; { const int n = 1 + (6*p+4); eC = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n))); }

    float e[18] = { eA[0].x,eA[0].y,eA[0].z,eA[1].x,eA[1].y,eA[1].z,eB[0].x,eB[0].y,eB[0].z,eB[1].x,eB[1].y,eB[1].z,eC[0].x,eC[0].y,eC[0].z,eC[1].x,eC[1].y,eC[1].z };

    vec3 vA[2]; { vA = vec3[2](data[0][0],data[0][1]); }
    vec3 vB[2]; { vB = vec3[2](data[1][0],data[1][1]); }
    vec3 vC[2]; { vC = vec3[2](data[2][0],data[2][1]); }

    float v[18] = { vA[0].x,vA[0].y,vA[0].z,vA[1].x,vA[1].y,vA[1].z,vB[0].x,vB[0].y,vB[0].z,vB[1].x,vB[1].y,vB[1].z,vC[0].x,vC[0].y,vC[0].z,vC[1].x,vC[1].y,vC[1].z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<18; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out ivec3 data[2];
layout(location = 2) out ivec3 dataFlat[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = ivec3[2](ivec3(int(n), int(2*n), int(4*n)), int(3)*ivec3(int(n), int(2*n), int(4*n)));
    dataFlat      = ivec3[2](ivec3(int(n), int(2*n), int(4*n)), int(3)*ivec3(int(n), int(2*n), int(4*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 2) flat in ivec3 dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in ivec3 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    ivec3 eA[2]; { const int n = 1 + (6*p); eA = ivec3[2](ivec3(int(n), int(2*n), int(4*n)), int(3)*ivec3(int(n), int(2*n), int(4*n))); }
    ivec3 eB[2]; { const int n = 1 + (6*p+2); eB = ivec3[2](ivec3(int(n), int(2*n), int(4*n)), int(3)*ivec3(int(n), int(2*n), int(4*n))); }
    ivec3 eC[2]; { const int n = 1 + (6*p+4); eC = ivec3[2](ivec3(int(n), int(2*n), int(4*n)), int(3)*ivec3(int(n), int(2*n), int(4*n))); }

    int e[18] = { eA[0].x,eA[0].y,eA[0].z,eA[1].x,eA[1].y,eA[1].z,eB[0].x,eB[0].y,eB[0].z,eB[1].x,eB[1].y,eB[1].z,eC[0].x,eC[0].y,eC[0].z,eC[1].x,eC[1].y,eC[1].z };
    ivec3 eFlatV[2]; { const int n = 1 + (6*p); eFlatV = ivec3[2](ivec3(int(n), int(2*n), int(4*n)), int(3)*ivec3(int(n), int(2*n), int(4*n))); }
    int eFlat[18 / 3] = { eFlatV[0].x,eFlatV[0].y,eFlatV[0].z,eFlatV[1].x,eFlatV[1].y,eFlatV[1].z };

    ivec3 vA[2]; { vA = ivec3[2](data[0][0],data[0][1]); }
    ivec3 vB[2]; { vB = ivec3[2](data[1][0],data[1][1]); }
    ivec3 vC[2]; { vC = ivec3[2](data[2][0],data[2][1]); }
    ivec3 vFlatV[2]; { vFlatV = ivec3[2](dataFlat[0],dataFlat[1]); }
    int vFlat[18 / 3] = { vFlatV[0].x,vFlatV[0].y,vFlatV[0].z,vFlatV[1].x,vFlatV[1].y,vFlatV[1].z};

    int v[18] = { vA[0].x,vA[0].y,vA[0].z,vA[1].x,vA[1].y,vA[1].z,vB[0].x,vB[0].y,vB[0].z,vB[1].x,vB[1].y,vB[1].z,vC[0].x,vC[0].y,vC[0].z,vC[1].x,vC[1].y,vC[1].z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<18; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<18 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out ivec4 data[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in ivec4 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    ivec4 eA[2]; { const int n = 1 + (6*p); eA = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n))); }
    ivec4 eB[2]; { const int n = 1 + (6*p+2); eB = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n))); }
    ivec4 eC[2]; { const int n = 1 + (6*p+4); eC = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n))); }

    int e[24] = { eA[0].x,eA[0].y,eA[0].z,eA[0].w,eA[1].x,eA[1].y,eA[1].z,eA[1].w,eB[0].x,eB[0].y,eB[0].z,eB[0].w,eB[1].x,eB[1].y,eB[1].z,eB[1].w,eC[0].x,eC[0].y,eC[0].z,eC[0].w,eC[1].x,eC[1].y,eC[1].z,eC[1].w };

    ivec4 vA[2]; { vA = ivec4[2](data[0][0],data[0][1]); }
    ivec4 vB[2]; { vB = ivec4[2](data[1][0],data[1][1]); }
    ivec4 vC[2]; { vC = ivec4[2](data[2][0],data[2][1]); }

    int v[24] = { vA[0].x,vA[0].y,vA[0].z,vA[0].w,vA[1].x,vA[1].y,vA[1].z,vA[1].w,vB[0].x,vB[0].y,vB[0].z,vB[0].w,vB[1].x,vB[1].y,vB[1].z,vB[1].w,vC[0].x,vC[0].y,vC[0].z,vC[0].w,vC[1].x,vC[1].y,vC[1].z,vC[1].w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<24; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in float data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    float eA; { const int n = 1 + (2*p); eA = float(n); }
    float eB; { const int n = 1 + (even?2*p+2:2*p+4); eB = float(n); }
    float eC; { const int n = 1 + (even?2*p+4:2*p+2); eC = float(n); }

    float e[3] = { eA,eB,eC };

    float vA; { vA = data[0]; }
    float vB; { vB = data[1]; }
    float vC; { vC = data[2]; }

    float v[3] = { vA,vB,vC };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 1) in float dataIntrp;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in float data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    float eA; { const int n = 1 + (2*p); eA = float(n); }
    float eB; { const int n = 1 + (even?2*p+2:2*p+4); eB = float(n); }
    float eC; { const int n = 1 + (even?2*p+4:2*p+2); eC = float(n); }

    float e[3] = { eA,eB,eC };
    float eIntrpV; {eIntrpV = float(eA * gl_BaryCoordEXT.x + eB * gl_BaryCoordEXT.y + eC * gl_BaryCoordEXT.z); }
    float eIntrp[3 / 3] = { eIntrpV };

    float vA; { vA = data[0]; }
    float vB; { vB = data[1]; }
    float vC; { vC = data[2]; }
    float vIntrpV; { vIntrpV = dataIntrp; }
    float vIntrp[3 / 3] = { vIntrpV };

    float v[3] = { vA,vB,vC };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<3 / 3; i++)
        if (abs(eIntrp[i] - vIntrp[i]) < 0.001)
            mask.y = mask.y | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 1) in vec2 dataIntrp;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec2 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    vec2 eA; { const int n = 1 + (2*p); eA = vec2(float(n), float(2*n)); }
    vec2 eB; { const int n = 1 + (even?2*p+2:2*p+4); eB = vec2(float(n), float(2*n)); }
    vec2 eC; { const int n = 1 + (even?2*p+4:2*p+2); eC = vec2(float(n), float(2*n)); }

    float e[6] = { eA.x,eA.y,eB.x,eB.y,eC.x,eC.y };
    vec2 eIntrpV; {eIntrpV = vec2(eA * gl_BaryCoordEXT.x + eB * gl_BaryCoordEXT.y + eC * gl_BaryCoordEXT.z); }
    float eIntrp[6 / 3] = { eIntrpV.x,eIntrpV.y };

    vec2 vA; { vA = data[0]; }
    vec2 vB; { vB = data[1]; }
    vec2 vC; { vC = data[2]; }
    vec2 vIntrpV; { vIntrpV = dataIntrp; }
    float vIntrp[6 / 3] = { vIntrpV.x,vIntrpV.y };

    float v[6] = { vA.x,vA.y,vB.x,vB.y,vC.x,vC.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (abs(eIntrp[i] - vIntrp[i]) < 0.001)
            mask.y = mask.y | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 1) flat in vec2 dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec2 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    vec2 eA; { const int n = 1 + (2*p); eA = vec2(float(n), float(2*n)); }
    vec2 eB; { const int n = 1 + (even?2*p+2:2*p+4); eB = vec2(float(n), float(2*n)); }
    vec2 eC; { const int n = 1 + (even?2*p+4:2*p+2); eC = vec2(float(n), float(2*n)); }

    float e[6] = { eA.x,eA.y,eB.x,eB.y,eC.x,eC.y };
    vec2 eFlatV; { const int n = 1 + (2*p); eFlatV = vec2(float(n), float(2*n)); }
    float eFlat[6 / 3] = { eFlatV.x,eFlatV.y };

    vec2 vA; { vA = data[0]; }
    vec2 vB; { vB = data[1]; }
    vec2 vC; { vC = data[2]; }
    vec2 vFlatV; { vFlatV = dataFlat; }
    float vFlat[6 / 3] = { vFlatV.x,vFlatV.y};

    float v[6] = { vA.x,vA.y,vB.x,vB.y,vC.x,vC.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 1) in vec3 dataIntrp;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec3 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    vec3 eA; { const int n = 1 + (2*p); eA = vec3(float(n), float(2*n), float(4*n)); }
    vec3 eB; { const int n = 1 + (even?2*p+2:2*p+4); eB = vec3(float(n), float(2*n), float(4*n)); }
    vec3 eC; { const int n = 1 + (even?2*p+4:2*p+2); eC = vec3(float(n), float(2*n), float(4*n)); }

    float e[9] = { eA.x,eA.y,eA.z,eB.x,eB.y,eB.z,eC.x,eC.y,eC.z };
    vec3 eIntrpV; {eIntrpV = vec3(eA * gl_BaryCoordEXT.x + eB * gl_BaryCoordEXT.y + eC * gl_BaryCoordEXT.z); }
    float eIntrp[9 / 3] = { eIntrpV.x,eIntrpV.y,eIntrpV.z };

    vec3 vA; { vA = data[0]; }
    vec3 vB; { vB = data[1]; }
    vec3 vC; { vC = data[2]; }
    vec3 vIntrpV; { vIntrpV = dataIntrp; }
    float vIntrp[9 / 3] = { vIntrpV.x,vIntrpV.y,vIntrpV.z };

    float v[9] = { vA.x,vA.y,vA.z,vB.x,vB.y,vB.z,vC.x,vC.y,vC.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<9 / 3; i++)
        if (abs(eIntrp[i] - vIntrp[i]) < 0.001)
            mask.y = mask.y | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec4 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    vec4 eA; { const int n = 1 + (2*p); eA = vec4(float(n), float(2*n), float(4*n), float(8*n)); }
    vec4 eB; { const int n = 1 + (even?2*p+2:2*p+4); eB = vec4(float(n), float(2*n), float(4*n), float(8*n)); }
    vec4 eC; { const int n = 1 + (even?2*p+4:2*p+2); eC = vec4(float(n), float(2*n), float(4*n), float(8*n)); }

    float e[12] = { eA.x,eA.y,eA.z,eA.w,eB.x,eB.y,eB.z,eB.w,eC.x,eC.y,eC.z,eC.w };

    vec4 vA; { vA = data[0]; }
    vec4 vB; { vB = data[1]; }
    vec4 vC; { vC = data[2]; }

    float v[12] = { vA.x,vA.y,vA.z,vA.w,vB.x,vB.y,vB.z,vB.w,vC.x,vC.y,vC.z,vC.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec2 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    dvec2 eA; { const int n = 1 + (2*p); eA = dvec2(double(n), double(2*n)); }
    dvec2 eB; { const int n = 1 + (even?2*p+2:2*p+4); eB = dvec2(double(n), double(2*n)); }
    dvec2 eC; { const int n = 1 + (even?2*p+4:2*p+2); eC = dvec2(double(n), double(2*n)); }

    double e[6] = { eA.x,eA.y,eB.x,eB.y,eC.x,eC.y };

    dvec2 vA; { vA = data[0]; }
    dvec2 vB; { vB = data[1]; }
    dvec2 vC; { vC = data[2]; }

    double v[6] = { vA.x,vA.y,vB.x,vB.y,vC.x,vC.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out dvec4 data;
layout(location = 2) out dvec4 dataFlat;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = dvec4(double(n), double(2*n), double(4*n), double(8*n));
    dataFlat      = dvec4(double(n), double(2*n), double(4*n), double(8*n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 2) flat in dvec4 dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec4 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    dvec4 eA; { const int n = 1 + (2*p); eA = dvec4(double(n), double(2*n), double(4*n), double(8*n)); }
    dvec4 eB; { const int n = 1 + (even?2*p+2:2*p+4); eB = dvec4(double(n), double(2*n), double(4*n), double(8*n)); }
    dvec4 eC; { const int n = 1 + (even?2*p+4:2*p+2); eC = dvec4(double(n), double(2*n), double(4*n), double(8*n)); }

    double e[12] = { eA.x,eA.y,eA.z,eA.w,eB.x,eB.y,eB.z,eB.w,eC.x,eC.y,eC.z,eC.w };
    dvec4 eFlatV; { const int n = 1 + (2*p); eFlatV = dvec4(double(n), double(2*n), double(4*n), double(8*n)); }
    double eFlat[12 / 3] = { eFlatV.x,eFlatV.y,eFlatV.z,eFlatV.w };

    dvec4 vA; { vA = data[0]; }
    dvec4 vB; { vB = data[1]; }
    dvec4 vC; { vC = data[2]; }
    dvec4 vFlatV; { vFlatV = dataFlat; }
    double vFlat[12 / 3] = { vFlatV.x,vFlatV.y,vFlatV.z,vFlatV.w};

    double v[12] = { vA.x,vA.y,vA.z,vA.w,vB.x,vB.y,vB.z,vB.w,vC.x,vC.y,vC.z,vC.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<12 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out uvec2 data;
layout(location = 1) out uvec2 dataFlat;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = uvec2(uint(n), uint(2*n));
    dataFlat      = uvec2(uint(n), uint(2*n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 1) flat in uvec2 dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uvec2 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    uvec2 eA; { const int n = 1 + (2*p); eA = uvec2(uint(n), uint(2*n)); }
    uvec2 eB; { const int n = 1 + (even?2*p+2:2*p+4); eB = uvec2(uint(n), uint(2*n)); }
    uvec2 eC; { const int n = 1 + (even?2*p+4:2*p+2); eC = uvec2(uint(n), uint(2*n)); }

    uint e[6] = { eA.x,eA.y,eB.x,eB.y,eC.x,eC.y };
    uvec2 eFlatV; { const int n = 1 + (2*p); eFlatV = uvec2(uint(n), uint(2*n)); }
    uint eFlat[6 / 3] = { eFlatV.x,eFlatV.y };

    uvec2 vA; { vA = data[0]; }
    uvec2 vB; { vB = data[1]; }
    uvec2 vC; { vC = data[2]; }
    uvec2 vFlatV; { vFlatV = dataFlat; }
    uint vFlat[6 / 3] = { vFlatV.x,vFlatV.y};

    uint v[6] = { vA.x,vA.y,vB.x,vB.y,vC.x,vC.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec2 q;};


layout(location = 1) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (2*p); eA = DataStruct(vec2(float(n), float(2*n))); }
    DataStruct eB; { const int n = 1 + (even?2*p+2:2*p+4); eB = DataStruct(vec2(float(n), float(2*n))); }
    DataStruct eC; { const int n = 1 + (even?2*p+4:2*p+2); eC = DataStruct(vec2(float(n), float(2*n))); }

    float e[6] = { eA.q.x,eA.q.y,eB.q.x,eB.q.y,eC.q.x,eC.q.y };
    DataStruct eFlatV; { const int n = 1 + (2*p); eFlatV = DataStruct(vec2(float(n), float(2*n))); }
    float eFlat[6 / 3] = { eFlatV.q.x,eFlatV.q.y };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    float vFlat[6 / 3] = { vFlatV.q.x,vFlatV.q.y};

    float v[6] = { vA.q.x,vA.q.y,vB.q.x,vB.q.y,vC.q.x,vC.q.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {int q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;
layout(location = 1) out DataStruct dataFlat;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(int(n));
    dataFlat      = DataStruct(int(n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {int q;};


layout(location = 1) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (2*p); eA = DataStruct(int(n)); }
    DataStruct eB; { const int n = 1 + (even?2*p+2:2*p+4); eB = DataStruct(int(n)); }
    DataStruct eC; { const int n = 1 + (even?2*p+4:2*p+2); eC = DataStruct(int(n)); }

    int e[3] = { eA.q,eB.q,eC.q };
    DataStruct eFlatV; { const int n = 1 + (2*p); eFlatV = DataStruct(int(n)); }
    int eFlat[3 / 3] = { eFlatV.q };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    int vFlat[3 / 3] = { vFlatV.q};

    int v[3] = { vA.q,vB.q,vC.q };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<3 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {ivec2 q;};


layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (2*p); eA = DataStruct(ivec2(int(n), int(2*n))); }
    DataStruct eB; { const int n = 1 + (even?2*p+2:2*p+4); eB = DataStruct(ivec2(int(n), int(2*n))); }
    DataStruct eC; { const int n = 1 + (even?2*p+4:2*p+2); eC = DataStruct(ivec2(int(n), int(2*n))); }

    int e[6] = { eA.q.x,eA.q.y,eB.q.x,eB.q.y,eC.q.x,eC.q.y };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }

    int v[6] = { vA.q.x,vA.q.y,vB.q.x,vB.q.y,vC.q.x,vC.q.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 2) flat in vec3 dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec3 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    vec3 eA[2]; { const int n = 1 + (2*p); eA = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n))); }
    vec3 eB[2]; { const int n = 1 + (even?2*p+2:2*p+4); eB = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n))); }
    vec3 eC[2]; { const int n = 1 + (even?2*p+4:2*p+2); eC = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n))); }

    float e[18] = { eA[0].x,eA[0].y,eA[0].z,eA[1].x,eA[1].y,eA[1].z,eB[0].x,eB[0].y,eB[0].z,eB[1].x,eB[1].y,eB[1].z,eC[0].x,eC[0].y,eC[0].z,eC[1].x,eC[1].y,eC[1].z };
    vec3 eFlatV[2]; { const int n = 1 + (2*p); eFlatV = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n))); }
    float eFlat[18 / 3] = { eFlatV[0].x,eFlatV[0].y,eFlatV[0].z,eFlatV[1].x,eFlatV[1].y,eFlatV[1].z };

    vec3 vA[2]; { vA = vec3[2](data[0][0],data[0][1]); }
    vec3 vB[2]; { vB = vec3[2](data[1][0],data[1][1]); }
    vec3 vC[2]; { vC = vec3[2](data[2][0],data[2][1]); }
    vec3 vFlatV[2]; { vFlatV = vec3[2](dataFlat[0],dataFlat[1]); }
    float vFlat[18 / 3] = { vFlatV[0].x,vFlatV[0].y,vFlatV[0].z,vFlatV[1].x,vFlatV[1].y,vFlatV[1].z};

    float v[18] = { vA[0].x,vA[0].y,vA[0].z,vA[1].x,vA[1].y,vA[1].z,vB[0].x,vB[0].y,vB[0].z,vB[1].x,vB[1].y,vB[1].z,vC[0].x,vC[0].y,vC[0].z,vC[1].x,vC[1].y,vC[1].z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<18; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<18 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in int data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    int eA[2]; { const int n = 1 + (2*p); eA = int[2](int(n), int(3)*int(n)); }
    int eB[2]; { const int n = 1 + (even?2*p+2:2*p+4); eB = int[2](int(n), int(3)*int(n)); }
    int eC[2]; { const int n = 1 + (even?2*p+4:2*p+2); eC = int[2](int(n), int(3)*int(n)); }

    int e[6] = { eA[0],eA[1],eB[0],eB[1],eC[0],eC[1] };

    int vA[2]; { vA = int[2](data[0][0],data[0][1]); }
    int vB[2]; { vB = int[2](data[1][0],data[1][1]); }
    int vC[2]; { vC = int[2](data[2][0],data[2][1]); }

    int v[6] = { vA[0],vA[1],vB[0],vB[1],vC[0],vC[1] };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 2) flat in ivec4 dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in ivec4 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    ivec4 eA[2]; { const int n = 1 + (2*p); eA = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n))); }
    ivec4 eB[2]; { const int n = 1 + (even?2*p+2:2*p+4); eB = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n))); }
    ivec4 eC[2]; { const int n = 1 + (even?2*p+4:2*p+2); eC = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n))); }

    int e[24] = { eA[0].x,eA[0].y,eA[0].z,eA[0].w,eA[1].x,eA[1].y,eA[1].z,eA[1].w,eB[0].x,eB[0].y,eB[0].z,eB[0].w,eB[1].x,eB[1].y,eB[1].z,eB[1].w,eC[0].x,eC[0].y,eC[0].z,eC[0].w,eC[1].x,eC[1].y,eC[1].z,eC[1].w };
    ivec4 eFlatV[2]; { const int n = 1 + (2*p); eFlatV = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n))); }
    int eFlat[24 / 3] = { eFlatV[0].x,eFlatV[0].y,eFlatV[0].z,eFlatV[0].w,eFlatV[1].x,eFlatV[1].y,eFlatV[1].z,eFlatV[1].w };

    ivec4 vA[2]; { vA = ivec4[2](data[0][0],data[0][1]); }
    ivec4 vB[2]; { vB = ivec4[2](data[1][0],data[1][1]); }
    ivec4 vC[2]; { vC = ivec4[2](data[2][0],data[2][1]); }
    ivec4 vFlatV[2]; { vFlatV = ivec4[2](dataFlat[0],dataFlat[1]); }
    int vFlat[24 / 3] = { vFlatV[0].x,vFlatV[0].y,vFlatV[0].z,vFlatV[0].w,vFlatV[1].x,vFlatV[1].y,vFlatV[1].z,vFlatV[1].w};

    int v[24] = { vA[0].x,vA[0].y,vA[0].z,vA[0].w,vA[1].x,vA[1].y,vA[1].z,vA[1].w,vB[0].x,vB[0].y,vB[0].z,vB[0].w,vB[1].x,vB[1].y,vB[1].z,vB[1].w,vC[0].x,vC[0].y,vC[0].z,vC[0].w,vC[1].x,vC[1].y,vC[1].z,vC[1].w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<24; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<24 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out vec3 data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = vec3(float(n), float(2*n), float(4*n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec3 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = w * y + x;
    const bool even = (p%2 == 0);

    vec3 eA; { const int n = 1 + (p); eA = vec3(float(n), float(2*n), float(4*n)); }
    vec3 eB; { const int n = 1 + (p); eB = vec3(float(n), float(2*n), float(4*n)); }
    vec3 eC; { const int n = 1 + (p); eC = vec3(float(n), float(2*n), float(4*n)); }

    float e[9] = { eA.x,eA.y,eA.z,eB.x,eB.y,eB.z,eC.x,eC.y,eC.z };

    vec3 vA; { vA = data[pc.n[0]]; }
    vec3 vB; { vB = data[pc.n[1]]; }
    vec3 vC; { vC = data[pc.n[2]]; }

    float v[9] = { vA.x,vA.y,vA.z,vB.x,vB.y,vB.z,vC.x,vC.y,vC.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(points) out;
layout(max_vertices=1, max_primitives = 1) out;
layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[64];
} pvd;
layout (location=0) out double data[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    SetMeshOutputsEXT(1u, 1u);
    const uint vertex = gl_LocalInvocationIndex;
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z + gl_NumWorkGroups.x * gl_WorkGroupID.y + gl_WorkGroupID.x;
    uint jobId = workGroupIndex + gl_LocalInvocationIndex;
    gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[jobId];
    gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
    gl_PrimitivePointIndicesEXT[vertex] = vertex;
    uint n  = jobId + 1;
    data[vertex] = double(n);
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in double data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = w * y + x;
    const bool even = (p%2 == 0);

    double eA; { const int n = 1 + (p); eA = double(n); }
    double eB; { const int n = 1 + (p); eB = double(n); }
    double eC; { const int n = 1 + (p); eC = double(n); }

    double e[3] = { eA,eB,eC };

    double vA; { vA = data[pc.n[0]]; }
    double vB; { vB = data[pc.n[1]]; }
    double vC; { vC = data[pc.n[2]]; }

    double v[3] = { vA,vB,vC };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out dvec2 data;
layout(location = 2) out dvec2 dataFlat;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = dvec2(double(n), double(2*n));
    dataFlat      = dvec2(double(n), double(2*n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 2) flat in dvec2 dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec2 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = w * y + x;
    const bool even = (p%2 == 0);

    dvec2 eA; { const int n = 1 + (p); eA = dvec2(double(n), double(2*n)); }
    dvec2 eB; { const int n = 1 + (p); eB = dvec2(double(n), double(2*n)); }
    dvec2 eC; { const int n = 1 + (p); eC = dvec2(double(n), double(2*n)); }

    double e[6] = { eA.x,eA.y,eB.x,eB.y,eC.x,eC.y };
    dvec2 eFlatV; { const int n = 1 + (p); eFlatV = dvec2(double(n), double(2*n)); }
    double eFlat[6 / 3] = { eFlatV.x,eFlatV.y };

    dvec2 vA; { vA = data[pc.n[0]]; }
    dvec2 vB; { vB = data[pc.n[1]]; }
    dvec2 vC; { vC = data[pc.n[2]]; }
    dvec2 vFlatV; { vFlatV = dataFlat; }
    double vFlat[6 / 3] = { vFlatV.x,vFlatV.y};

    double v[6] = { vA.x,vA.y,vB.x,vB.y,vC.x,vC.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out dvec3 data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = dvec3(double(n), double(2*n), double(4*n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec3 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = w * y + x;
    const bool even = (p%2 == 0);

    dvec3 eA; { const int n = 1 + (p); eA = dvec3(double(n), double(2*n), double(4*n)); }
    dvec3 eB; { const int n = 1 + (p); eB = dvec3(double(n), double(2*n), double(4*n)); }
    dvec3 eC; { const int n = 1 + (p); eC = dvec3(double(n), double(2*n), double(4*n)); }

    double e[9] = { eA.x,eA.y,eA.z,eB.x,eB.y,eB.z,eC.x,eC.y,eC.z };

    dvec3 vA; { vA = data[pc.n[0]]; }
    dvec3 vB; { vB = data[pc.n[1]]; }
    dvec3 vC; { vC = data[pc.n[2]]; }

    double v[9] = { vA.x,vA.y,vA.z,vB.x,vB.y,vB.z,vC.x,vC.y,vC.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(points) out;
layout(max_vertices=1, max_primitives = 1) out;
layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[64];
} pvd;
layout (location=0) out ivec3 data[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    SetMeshOutputsEXT(1u, 1u);
    const uint vertex = gl_LocalInvocationIndex;
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z + gl_NumWorkGroups.x * gl_WorkGroupID.y + gl_WorkGroupID.x;
    uint jobId = workGroupIndex + gl_LocalInvocationIndex;
    gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[jobId];
    gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
    gl_PrimitivePointIndicesEXT[vertex] = vertex;
    uint n  = jobId + 1;
    data[vertex] = ivec3(int(n), int(2*n), int(4*n));
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in ivec3 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = w * y + x;
    const bool even = (p%2 == 0);

    ivec3 eA; { const int n = 1 + (p); eA = ivec3(int(n), int(2*n), int(4*n)); }
    ivec3 eB; { const int n = 1 + (p); eB = ivec3(int(n), int(2*n), int(4*n)); }
    ivec3 eC; { const int n = 1 + (p); eC = ivec3(int(n), int(2*n), int(4*n)); }

    int e[9] = { eA.x,eA.y,eA.z,eB.x,eB.y,eB.z,eC.x,eC.y,eC.z };

    ivec3 vA; { vA = data[pc.n[0]]; }
    ivec3 vB; { vB = data[pc.n[1]]; }
    ivec3 vC; { vC = data[pc.n[2]]; }

    int v[9] = { vA.x,vA.y,vA.z,vB.x,vB.y,vB.z,vC.x,vC.y,vC.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out uvec4 data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uvec4 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = w * y + x;
    const bool even = (p%2 == 0);

    uvec4 eA; { const int n = 1 + (p); eA = uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)); }
    uvec4 eB; { const int n = 1 + (p); eB = uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)); }
    uvec4 eC; { const int n = 1 + (p); eC = uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)); }

    uint e[12] = { eA.x,eA.y,eA.z,eA.w,eB.x,eB.y,eB.z,eB.w,eC.x,eC.y,eC.z,eC.w };

    uvec4 vA; { vA = data[pc.n[0]]; }
    uvec4 vB; { vB = data[pc.n[1]]; }
    uvec4 vC; { vC = data[pc.n[2]]; }

    uint v[12] = { vA.x,vA.y,vA.z,vA.w,vB.x,vB.y,vB.z,vB.w,vC.x,vC.y,vC.z,vC.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(points) out;
layout(max_vertices=1, max_primitives = 1) out;
layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[64];
} pvd;
layout (location=0) out uvec4 data[];
layout(location = 1) out uvec4 dataFlat[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    SetMeshOutputsEXT(1u, 1u);
    const uint vertex = gl_LocalInvocationIndex;
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z + gl_NumWorkGroups.x * gl_WorkGroupID.y + gl_WorkGroupID.x;
    uint jobId = workGroupIndex + gl_LocalInvocationIndex;
    gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[jobId];
    gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
    gl_PrimitivePointIndicesEXT[vertex] = vertex;
    uint n  = jobId + 1;
    data[vertex] = uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n));
    dataFlat[vertex]      = uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n));
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) flat in uvec4 dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uvec4 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = w * y + x;
    const bool even = (p%2 == 0);

    uvec4 eA; { const int n = 1 + (p); eA = uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)); }
    uvec4 eB; { const int n = 1 + (p); eB = uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)); }
    uvec4 eC; { const int n = 1 + (p); eC = uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)); }

    uint e[12] = { eA.x,eA.y,eA.z,eA.w,eB.x,eB.y,eB.z,eB.w,eC.x,eC.y,eC.z,eC.w };
    uvec4 eFlatV; { const int n = 1 + (p); eFlatV = uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)); }
    uint eFlat[12 / 3] = { eFlatV.x,eFlatV.y,eFlatV.z,eFlatV.w };

    uvec4 vA; { vA = data[pc.n[0]]; }
    uvec4 vB; { vB = data[pc.n[1]]; }
    uvec4 vC; { vC = data[pc.n[2]]; }
    uvec4 vFlatV; { vFlatV = dataFlat; }
    uint vFlat[12 / 3] = { vFlatV.x,vFlatV.y,vFlatV.z,vFlatV.w};

    uint v[12] = { vA.x,vA.y,vA.z,vA.w,vB.x,vB.y,vB.z,vB.w,vC.x,vC.y,vC.z,vC.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<12 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out uvec4 data;
layout(location = 1) out uvec4 dataFlat;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n));
    dataFlat      = uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {float q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;
layout(location = 1) out DataStruct dataInterp;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(float(n));
    dataInterp    = DataStruct(float(n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {float q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) in DataStruct dataIntrp;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = w * y + x;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (p); eA = DataStruct(float(n)); }
    DataStruct eB; { const int n = 1 + (p); eB = DataStruct(float(n)); }
    DataStruct eC; { const int n = 1 + (p); eC = DataStruct(float(n)); }

    float e[3] = { eA.q,eB.q,eC.q };
    DataStruct eIntrpV; {eIntrpV = DataStruct(eA.q * gl_BaryCoordEXT.x + eB.q * gl_BaryCoordEXT.y + eC.q * gl_BaryCoordEXT.z); }
    float eIntrp[3 / 3] = { eIntrpV.q };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }
    DataStruct vIntrpV; { vIntrpV = dataIntrp; }
    float vIntrp[3 / 3] = { vIntrpV.q };

    float v[3] = { vA.q,vB.q,vC.q };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<3 / 3; i++)
        if (abs(eIntrp[i] - vIntrp[i]) < 0.001)
            mask.y = mask.y | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable

struct DataStruct {vec2 q;};
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(points) out;
layout(max_vertices=1, max_primitives = 1) out;
layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[64];
} pvd;
layout (location=0) out DataStruct data[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    SetMeshOutputsEXT(1u, 1u);
    const uint vertex = gl_LocalInvocationIndex;
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z + gl_NumWorkGroups.x * gl_WorkGroupID.y + gl_WorkGroupID.x;
    uint jobId = workGroupIndex + gl_LocalInvocationIndex;
    gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[jobId];
    gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
    gl_PrimitivePointIndicesEXT[vertex] = vertex;
    uint n  = jobId + 1;
    data[vertex] = DataStruct(vec2(float(n), float(2*n)));
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec2 q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = w * y + x;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (p); eA = DataStruct(vec2(float(n), float(2*n))); }
    DataStruct eB; { const int n = 1 + (p); eB = DataStruct(vec2(float(n), float(2*n))); }
    DataStruct eC; { const int n = 1 + (p); eC = DataStruct(vec2(float(n), float(2*n))); }

    float e[6] = { eA.q.x,eA.q.y,eB.q.x,eB.q.y,eC.q.x,eC.q.y };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }

    float v[6] = { vA.q.x,vA.q.y,vB.q.x,vB.q.y,vC.q.x,vC.q.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable

struct DataStruct {vec3 q;};
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(points) out;
layout(max_vertices=1, max_primitives = 1) out;
layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[64];
} pvd;
layout (location=0) out DataStruct data[];
layout(location = 1) out DataStruct dataInterp[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    SetMeshOutputsEXT(1u, 1u);
    const uint vertex = gl_LocalInvocationIndex;
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z + gl_NumWorkGroups.x * gl_WorkGroupID.y + gl_WorkGroupID.x;
    uint jobId = workGroupIndex + gl_LocalInvocationIndex;
    gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[jobId];
    gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
    gl_PrimitivePointIndicesEXT[vertex] = vertex;
    uint n  = jobId + 1;
    data[vertex] = DataStruct(vec3(float(n), float(2*n), float(4*n)));
    dataInterp[vertex]    = DataStruct(vec3(float(n), float(2*n), float(4*n)));
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec3 q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) in DataStruct dataIntrp;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = w * y + x;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (p); eA = DataStruct(vec3(float(n), float(2*n), float(4*n))); }
    DataStruct eB; { const int n = 1 + (p); eB = DataStruct(vec3(float(n), float(2*n), float(4*n))); }
    DataStruct eC; { const int n = 1 + (p); eC = DataStruct(vec3(float(n), float(2*n), float(4*n))); }

    float e[9] = { eA.q.x,eA.q.y,eA.q.z,eB.q.x,eB.q.y,eB.q.z,eC.q.x,eC.q.y,eC.q.z };
    DataStruct eIntrpV; {eIntrpV = DataStruct(eA.q * gl_BaryCoordEXT.x + eB.q * gl_BaryCoordEXT.y + eC.q * gl_BaryCoordEXT.z); }
    float eIntrp[9 / 3] = { eIntrpV.q.x,eIntrpV.q.y,eIntrpV.q.z };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }
    DataStruct vIntrpV; { vIntrpV = dataIntrp; }
    float vIntrp[9 / 3] = { vIntrpV.q.x,vIntrpV.q.y,vIntrpV.q.z };

    float v[9] = { vA.q.x,vA.q.y,vA.q.z,vB.q.x,vB.q.y,vB.q.z,vC.q.x,vC.q.y,vC.q.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<9 / 3; i++)
        if (abs(eIntrp[i] - vIntrp[i]) < 0.001)
            mask.y = mask.y | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {dvec2 q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;
layout(location = 2) out DataStruct dataFlat;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(dvec2(double(n), double(2*n)));
    dataFlat      = DataStruct(dvec2(double(n), double(2*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {dvec2 q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 2) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = w * y + x;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (p); eA = DataStruct(dvec2(double(n), double(2*n))); }
    DataStruct eB; { const int n = 1 + (p); eB = DataStruct(dvec2(double(n), double(2*n))); }
    DataStruct eC; { const int n = 1 + (p); eC = DataStruct(dvec2(double(n), double(2*n))); }

    double e[6] = { eA.q.x,eA.q.y,eB.q.x,eB.q.y,eC.q.x,eC.q.y };
    DataStruct eFlatV; { const int n = 1 + (p); eFlatV = DataStruct(dvec2(double(n), double(2*n))); }
    double eFlat[6 / 3] = { eFlatV.q.x,eFlatV.q.y };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    double vFlat[6 / 3] = { vFlatV.q.x,vFlatV.q.y};

    double v[6] = { vA.q.x,vA.q.y,vB.q.x,vB.q.y,vC.q.x,vC.q.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable

struct DataStruct {uvec2 q;};
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(points) out;
layout(max_vertices=1, max_primitives = 1) out;
layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[64];
} pvd;
layout (location=0) out DataStruct data[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    SetMeshOutputsEXT(1u, 1u);
    const uint vertex = gl_LocalInvocationIndex;
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z + gl_NumWorkGroups.x * gl_WorkGroupID.y + gl_WorkGroupID.x;
    uint jobId = workGroupIndex + gl_LocalInvocationIndex;
    gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[jobId];
    gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
    gl_PrimitivePointIndicesEXT[vertex] = vertex;
    uint n  = jobId + 1;
    data[vertex] = DataStruct(uvec2(uint(n), uint(2*n)));
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {uvec2 q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = w * y + x;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (p); eA = DataStruct(uvec2(uint(n), uint(2*n))); }
    DataStruct eB; { const int n = 1 + (p); eB = DataStruct(uvec2(uint(n), uint(2*n))); }
    DataStruct eC; { const int n = 1 + (p); eC = DataStruct(uvec2(uint(n), uint(2*n))); }

    uint e[6] = { eA.q.x,eA.q.y,eB.q.x,eB.q.y,eC.q.x,eC.q.y };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }

    uint v[6] = { vA.q.x,vA.q.y,vB.q.x,vB.q.y,vC.q.x,vC.q.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable

struct DataStruct {uvec3 q;};
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(points) out;
layout(max_vertices=1, max_primitives = 1) out;
layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[64];
} pvd;
layout (location=0) out DataStruct data[];
layout(location = 1) out DataStruct dataFlat[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    SetMeshOutputsEXT(1u, 1u);
    const uint vertex = gl_LocalInvocationIndex;
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z + gl_NumWorkGroups.x * gl_WorkGroupID.y + gl_WorkGroupID.x;
    uint jobId = workGroupIndex + gl_LocalInvocationIndex;
    gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[jobId];
    gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
    gl_PrimitivePointIndicesEXT[vertex] = vertex;
    uint n  = jobId + 1;
    data[vertex] = DataStruct(uvec3(uint(n), uint(2*n), uint(4*n)));
    dataFlat[vertex]      = DataStruct(uvec3(uint(n), uint(2*n), uint(4*n)));
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {uvec3 q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = w * y + x;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (p); eA = DataStruct(uvec3(uint(n), uint(2*n), uint(4*n))); }
    DataStruct eB; { const int n = 1 + (p); eB = DataStruct(uvec3(uint(n), uint(2*n), uint(4*n))); }
    DataStruct eC; { const int n = 1 + (p); eC = DataStruct(uvec3(uint(n), uint(2*n), uint(4*n))); }

    uint e[9] = { eA.q.x,eA.q.y,eA.q.z,eB.q.x,eB.q.y,eB.q.z,eC.q.x,eC.q.y,eC.q.z };
    DataStruct eFlatV; { const int n = 1 + (p); eFlatV = DataStruct(uvec3(uint(n), uint(2*n), uint(4*n))); }
    uint eFlat[9 / 3] = { eFlatV.q.x,eFlatV.q.y,eFlatV.q.z };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    uint vFlat[9 / 3] = { vFlatV.q.x,vFlatV.q.y,vFlatV.q.z};

    uint v[9] = { vA.q.x,vA.q.y,vA.q.z,vB.q.x,vB.q.y,vB.q.z,vC.q.x,vC.q.y,vC.q.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<9 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {uvec4 q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;
layout(location = 1) out DataStruct dataFlat;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)));
    dataFlat      = DataStruct(uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {uvec4 q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = w * y + x;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (p); eA = DataStruct(uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }
    DataStruct eB; { const int n = 1 + (p); eB = DataStruct(uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }
    DataStruct eC; { const int n = 1 + (p); eC = DataStruct(uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }

    uint e[12] = { eA.q.x,eA.q.y,eA.q.z,eA.q.w,eB.q.x,eB.q.y,eB.q.z,eB.q.w,eC.q.x,eC.q.y,eC.q.z,eC.q.w };
    DataStruct eFlatV; { const int n = 1 + (p); eFlatV = DataStruct(uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }
    uint eFlat[12 / 3] = { eFlatV.q.x,eFlatV.q.y,eFlatV.q.z,eFlatV.q.w };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    uint vFlat[12 / 3] = { vFlatV.q.x,vFlatV.q.y,vFlatV.q.z,vFlatV.q.w};

    uint v[12] = { vA.q.x,vA.q.y,vA.q.z,vA.q.w,vB.q.x,vB.q.y,vB.q.z,vB.q.w,vC.q.x,vC.q.y,vC.q.z,vC.q.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<12 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(points) out;
layout(max_vertices=1, max_primitives = 1) out;
layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[64];
} pvd;
layout (location=0) out float data[][2];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    SetMeshOutputsEXT(1u, 1u);
    const uint vertex = gl_LocalInvocationIndex;
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z + gl_NumWorkGroups.x * gl_WorkGroupID.y + gl_WorkGroupID.x;
    uint jobId = workGroupIndex + gl_LocalInvocationIndex;
    gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[jobId];
    gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
    gl_PrimitivePointIndicesEXT[vertex] = vertex;
    uint n  = jobId + 1;
    data[vertex] = float[2](float(n), float(3)*float(n));
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in float data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = w * y + x;
    const bool even = (p%2 == 0);

    float eA[2]; { const int n = 1 + (p); eA = float[2](float(n), float(3)*float(n)); }
    float eB[2]; { const int n = 1 + (p); eB = float[2](float(n), float(3)*float(n)); }
    float eC[2]; { const int n = 1 + (p); eC = float[2](float(n), float(3)*float(n)); }

    float e[6] = { eA[0],eA[1],eB[0],eB[1],eC[0],eC[1] };

    float vA[2]; { vA = float[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    float vB[2]; { vB = float[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    float vC[2]; { vC = float[2](data[pc.n[2]][0],data[pc.n[2]][1]); }

    float v[6] = { vA[0],vA[1],vB[0],vB[1],vC[0],vC[1] };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(points) out;
layout(max_vertices=1, max_primitives = 1) out;
layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[64];
} pvd;
layout (location=0) out vec2 data[][2];
layout(location = 2) out vec2 dataInterp[][2];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    SetMeshOutputsEXT(1u, 1u);
    const uint vertex = gl_LocalInvocationIndex;
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z + gl_NumWorkGroups.x * gl_WorkGroupID.y + gl_WorkGroupID.x;
    uint jobId = workGroupIndex + gl_LocalInvocationIndex;
    gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[jobId];
    gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
    gl_PrimitivePointIndicesEXT[vertex] = vertex;
    uint n  = jobId + 1;
    data[vertex] = vec2[2](vec2(float(n), float(2*n)), float(3)*vec2(float(n), float(2*n)));
    dataInterp[vertex]    = vec2[2](vec2(float(n), float(2*n)), float(3)*vec2(float(n), float(2*n)));
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 2) in vec2 dataIntrp[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec2 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = w * y + x;
    const bool even = (p%2 == 0);

    vec2 eA[2]; { const int n = 1 + (p); eA = vec2[2](vec2(float(n), float(2*n)), float(3)*vec2(float(n), float(2*n))); }
    vec2 eB[2]; { const int n = 1 + (p); eB = vec2[2](vec2(float(n), float(2*n)), float(3)*vec2(float(n), float(2*n))); }
    vec2 eC[2]; { const int n = 1 + (p); eC = vec2[2](vec2(float(n), float(2*n)), float(3)*vec2(float(n), float(2*n))); }

    float e[12] = { eA[0].x,eA[0].y,eA[1].x,eA[1].y,eB[0].x,eB[0].y,eB[1].x,eB[1].y,eC[0].x,eC[0].y,eC[1].x,eC[1].y };
    vec2 eIntrpV[2]; {eIntrpV = vec2[2](eA[0] * gl_BaryCoordEXT.x + eB[0] * gl_BaryCoordEXT.y + eC[0] * gl_BaryCoordEXT.z, eA[1] * gl_BaryCoordEXT.x + eB[1] * gl_BaryCoordEXT.y + eC[1] * gl_BaryCoordEXT.z); }
    float eIntrp[12 / 3] = { eIntrpV[0].x,eIntrpV[0].y,eIntrpV[1].x,eIntrpV[1].y };

    vec2 vA[2]; { vA = vec2[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    vec2 vB[2]; { vB = vec2[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    vec2 vC[2]; { vC = vec2[2](data[pc.n[2]][0],data[pc.n[2]][1]); }
    vec2 vIntrpV[2]; { vIntrpV = vec2[2](dataIntrp[0],dataIntrp[1]); }
    float vIntrp[12 / 3] = { vIntrpV[0].x,vIntrpV[0].y,vIntrpV[1].x,vIntrpV[1].y };

    float v[12] = { vA[0].x,vA[0].y,vA[1].x,vA[1].y,vB[0].x,vB[0].y,vB[1].x,vB[1].y,vC[0].x,vC[0].y,vC[1].x,vC[1].y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<12 / 3; i++)
        if (abs(eIntrp[i] - vIntrp[i]) < 0.001)
            mask.y = mask.y | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec4 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = w * y + x;
    const bool even = (p%2 == 0);

    vec4 eA[2]; { const int n = 1 + (p); eA = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    vec4 eB[2]; { const int n = 1 + (p); eB = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    vec4 eC[2]; { const int n = 1 + (p); eC = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n))); }

    float e[24] = { eA[0].x,eA[0].y,eA[0].z,eA[0].w,eA[1].x,eA[1].y,eA[1].z,eA[1].w,eB[0].x,eB[0].y,eB[0].z,eB[0].w,eB[1].x,eB[1].y,eB[1].z,eB[1].w,eC[0].x,eC[0].y,eC[0].z,eC[0].w,eC[1].x,eC[1].y,eC[1].z,eC[1].w };

    vec4 vA[2]; { vA = vec4[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    vec4 vB[2]; { vB = vec4[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    vec4 vC[2]; { vC = vec4[2](data[pc.n[2]][0],data[pc.n[2]][1]); }

    float v[24] = { vA[0].x,vA[0].y,vA[0].z,vA[0].w,vA[1].x,vA[1].y,vA[1].z,vA[1].w,vB[0].x,vB[0].y,vB[0].z,vB[0].w,vB[1].x,vB[1].y,vB[1].z,vB[1].w,vC[0].x,vC[0].y,vC[0].z,vC[0].w,vC[1].x,vC[1].y,vC[1].z,vC[1].w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<24; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(points) out;
layout(max_vertices=1, max_primitives = 1) out;
layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[64];
} pvd;
layout (location=0) out double data[][2];
layout(location = 4) out double dataFlat[][2];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    SetMeshOutputsEXT(1u, 1u);
    const uint vertex = gl_LocalInvocationIndex;
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z + gl_NumWorkGroups.x * gl_WorkGroupID.y + gl_WorkGroupID.x;
    uint jobId = workGroupIndex + gl_LocalInvocationIndex;
    gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[jobId];
    gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
    gl_PrimitivePointIndicesEXT[vertex] = vertex;
    uint n  = jobId + 1;
    data[vertex] = double[2](double(n), double(3)*double(n));
    dataFlat[vertex]      = double[2](double(n), double(3)*double(n));
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 4) flat in double dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in double data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = w * y + x;
    const bool even = (p%2 == 0);

    double eA[2]; { const int n = 1 + (p); eA = double[2](double(n), double(3)*double(n)); }
    double eB[2]; { const int n = 1 + (p); eB = double[2](double(n), double(3)*double(n)); }
    double eC[2]; { const int n = 1 + (p); eC = double[2](double(n), double(3)*double(n)); }

    double e[6] = { eA[0],eA[1],eB[0],eB[1],eC[0],eC[1] };
    double eFlatV[2]; { const int n = 1 + (p); eFlatV = double[2](double(n), double(3)*double(n)); }
    double eFlat[6 / 3] = { eFlatV[0],eFlatV[1] };

    double vA[2]; { vA = double[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    double vB[2]; { vB = double[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    double vC[2]; { vC = double[2](data[pc.n[2]][0],data[pc.n[2]][1]); }
    double vFlatV[2]; { vFlatV = double[2](dataFlat[0],dataFlat[1]); }
    double vFlat[6 / 3] = { vFlatV[0],vFlatV[1]};

    double v[6] = { vA[0],vA[1],vB[0],vB[1],vC[0],vC[1] };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec2 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = w * y + x;
    const bool even = (p%2 == 0);

    dvec2 eA[2]; { const int n = 1 + (p); eA = dvec2[2](dvec2(double(n), double(2*n)), double(3)*dvec2(double(n), double(2*n))); }
    dvec2 eB[2]; { const int n = 1 + (p); eB = dvec2[2](dvec2(double(n), double(2*n)), double(3)*dvec2(double(n), double(2*n))); }
    dvec2 eC[2]; { const int n = 1 + (p); eC = dvec2[2](dvec2(double(n), double(2*n)), double(3)*dvec2(double(n), double(2*n))); }

    double e[12] = { eA[0].x,eA[0].y,eA[1].x,eA[1].y,eB[0].x,eB[0].y,eB[1].x,eB[1].y,eC[0].x,eC[0].y,eC[1].x,eC[1].y };

    dvec2 vA[2]; { vA = dvec2[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    dvec2 vB[2]; { vB = dvec2[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    dvec2 vC[2]; { vC = dvec2[2](data[pc.n[2]][0],data[pc.n[2]][1]); }

    double v[12] = { vA[0].x,vA[0].y,vA[1].x,vA[1].y,vB[0].x,vB[0].y,vB[1].x,vB[1].y,vC[0].x,vC[0].y,vC[1].x,vC[1].y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out dvec3 data[2];
layout(location = 4) out dvec3 dataFlat[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n)));
    dataFlat      = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 4) flat in dvec3 dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec3 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = w * y + x;
    const bool even = (p%2 == 0);

    dvec3 eA[2]; { const int n = 1 + (p); eA = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n))); }
    dvec3 eB[2]; { const int n = 1 + (p); eB = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n))); }
    dvec3 eC[2]; { const int n = 1 + (p); eC = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n))); }

    double e[18] = { eA[0].x,eA[0].y,eA[0].z,eA[1].x,eA[1].y,eA[1].z,eB[0].x,eB[0].y,eB[0].z,eB[1].x,eB[1].y,eB[1].z,eC[0].x,eC[0].y,eC[0].z,eC[1].x,eC[1].y,eC[1].z };
    dvec3 eFlatV[2]; { const int n = 1 + (p); eFlatV = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n))); }
    double eFlat[18 / 3] = { eFlatV[0].x,eFlatV[0].y,eFlatV[0].z,eFlatV[1].x,eFlatV[1].y,eFlatV[1].z };

    dvec3 vA[2]; { vA = dvec3[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    dvec3 vB[2]; { vB = dvec3[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    dvec3 vC[2]; { vC = dvec3[2](data[pc.n[2]][0],data[pc.n[2]][1]); }
    dvec3 vFlatV[2]; { vFlatV = dvec3[2](dataFlat[0],dataFlat[1]); }
    double vFlat[18 / 3] = { vFlatV[0].x,vFlatV[0].y,vFlatV[0].z,vFlatV[1].x,vFlatV[1].y,vFlatV[1].z};

    double v[18] = { vA[0].x,vA[0].y,vA[0].z,vA[1].x,vA[1].y,vA[1].z,vB[0].x,vB[0].y,vB[0].z,vB[1].x,vB[1].y,vB[1].z,vC[0].x,vC[0].y,vC[0].z,vC[1].x,vC[1].y,vC[1].z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<18; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<18 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(points) out;
layout(max_vertices=1, max_primitives = 1) out;
layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[64];
} pvd;
layout (location=0) out uvec2 data[][2];
layout(location = 2) out uvec2 dataFlat[][2];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    SetMeshOutputsEXT(1u, 1u);
    const uint vertex = gl_LocalInvocationIndex;
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z + gl_NumWorkGroups.x * gl_WorkGroupID.y + gl_WorkGroupID.x;
    uint jobId = workGroupIndex + gl_LocalInvocationIndex;
    gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[jobId];
    gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
    gl_PrimitivePointIndicesEXT[vertex] = vertex;
    uint n  = jobId + 1;
    data[vertex] = uvec2[2](uvec2(uint(n), uint(2*n)), uint(3)*uvec2(uint(n), uint(2*n)));
    dataFlat[vertex]      = uvec2[2](uvec2(uint(n), uint(2*n)), uint(3)*uvec2(uint(n), uint(2*n)));
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 2) flat in uvec2 dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uvec2 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = w * y + x;
    const bool even = (p%2 == 0);

    uvec2 eA[2]; { const int n = 1 + (p); eA = uvec2[2](uvec2(uint(n), uint(2*n)), uint(3)*uvec2(uint(n), uint(2*n))); }
    uvec2 eB[2]; { const int n = 1 + (p); eB = uvec2[2](uvec2(uint(n), uint(2*n)), uint(3)*uvec2(uint(n), uint(2*n))); }
    uvec2 eC[2]; { const int n = 1 + (p); eC = uvec2[2](uvec2(uint(n), uint(2*n)), uint(3)*uvec2(uint(n), uint(2*n))); }

    uint e[12] = { eA[0].x,eA[0].y,eA[1].x,eA[1].y,eB[0].x,eB[0].y,eB[1].x,eB[1].y,eC[0].x,eC[0].y,eC[1].x,eC[1].y };
    uvec2 eFlatV[2]; { const int n = 1 + (p); eFlatV = uvec2[2](uvec2(uint(n), uint(2*n)), uint(3)*uvec2(uint(n), uint(2*n))); }
    uint eFlat[12 / 3] = { eFlatV[0].x,eFlatV[0].y,eFlatV[1].x,eFlatV[1].y };

    uvec2 vA[2]; { vA = uvec2[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    uvec2 vB[2]; { vB = uvec2[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    uvec2 vC[2]; { vC = uvec2[2](data[pc.n[2]][0],data[pc.n[2]][1]); }
    uvec2 vFlatV[2]; { vFlatV = uvec2[2](dataFlat[0],dataFlat[1]); }
    uint vFlat[12 / 3] = { vFlatV[0].x,vFlatV[0].y,vFlatV[1].x,vFlatV[1].y};

    uint v[12] = { vA[0].x,vA[0].y,vA[1].x,vA[1].y,vB[0].x,vB[0].y,vB[1].x,vB[1].y,vC[0].x,vC[0].y,vC[1].x,vC[1].y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<12 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(points) out;
layout(max_vertices=1, max_primitives = 1) out;
layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[64];
} pvd;
layout (location=0) out uvec3 data[][2];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    SetMeshOutputsEXT(1u, 1u);
    const uint vertex = gl_LocalInvocationIndex;
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z + gl_NumWorkGroups.x * gl_WorkGroupID.y + gl_WorkGroupID.x;
    uint jobId = workGroupIndex + gl_LocalInvocationIndex;
    gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[jobId];
    gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
    gl_PrimitivePointIndicesEXT[vertex] = vertex;
    uint n  = jobId + 1;
    data[vertex] = uvec3[2](uvec3(uint(n), uint(2*n), uint(4*n)), uint(3)*uvec3(uint(n), uint(2*n), uint(4*n)));
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uvec3 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = w * y + x;
    const bool even = (p%2 == 0);

    uvec3 eA[2]; { const int n = 1 + (p); eA = uvec3[2](uvec3(uint(n), uint(2*n), uint(4*n)), uint(3)*uvec3(uint(n), uint(2*n), uint(4*n))); }
    uvec3 eB[2]; { const int n = 1 + (p); eB = uvec3[2](uvec3(uint(n), uint(2*n), uint(4*n)), uint(3)*uvec3(uint(n), uint(2*n), uint(4*n))); }
    uvec3 eC[2]; { const int n = 1 + (p); eC = uvec3[2](uvec3(uint(n), uint(2*n), uint(4*n)), uint(3)*uvec3(uint(n), uint(2*n), uint(4*n))); }

    uint e[18] = { eA[0].x,eA[0].y,eA[0].z,eA[1].x,eA[1].y,eA[1].z,eB[0].x,eB[0].y,eB[0].z,eB[1].x,eB[1].y,eB[1].z,eC[0].x,eC[0].y,eC[0].z,eC[1].x,eC[1].y,eC[1].z };

    uvec3 vA[2]; { vA = uvec3[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    uvec3 vB[2]; { vB = uvec3[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    uvec3 vC[2]; { vC = uvec3[2](data[pc.n[2]][0],data[pc.n[2]][1]); }

    uint v[18] = { vA[0].x,vA[0].y,vA[0].z,vA[1].x,vA[1].y,vA[1].z,vB[0].x,vB[0].y,vB[0].z,vB[1].x,vB[1].y,vB[1].z,vC[0].x,vC[0].y,vC[0].z,vC[1].x,vC[1].y,vC[1].z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<18; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(lines) out;
layout(max_vertices=16, max_primitives=16) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[16];
} pvd;
layout (location=0) out float data[];
layout(location = 1) out float dataInterp[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 16;
    uint maxPrimitive = 8;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = float(n);
    dataInterp[vertex]    = float(n);
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveLineIndicesEXT[vertex] = uvec2(vertex * 2, vertex * 2 + 1u);
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) in float dataIntrp;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in float data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    float eA; { const int n = 1 + (2*p); eA = float(n); }
    float eB; { const int n = 1 + (2*p+1); eB = float(n); }
    float eC; { const int n = 1 + (2*p+1); eC = float(n); }

    float e[3] = { eA,eB,eC };
    float eIntrpV; {eIntrpV = float(eA * gl_BaryCoordEXT.x + eB * gl_BaryCoordEXT.y + eC * gl_BaryCoordEXT.z); }
    float eIntrp[3 / 3] = { eIntrpV };

    float vA; { vA = data[pc.n[0]]; }
    float vB; { vB = data[pc.n[1]]; }
    float vC; { vC = data[pc.n[2]]; }
    float vIntrpV; { vIntrpV = dataIntrp; }
    float vIntrp[3 / 3] = { vIntrpV };

    float v[3] = { vA,vB,vC };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<3 / 3; i++)
        if (abs(eIntrp[i] - vIntrp[i]) < 0.001)
            mask.y = mask.y | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(lines) out;
layout(max_vertices=16, max_primitives=16) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[16];
} pvd;
layout (location=0) out vec3 data[];
layout(location = 1) out vec3 dataInterp[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 16;
    uint maxPrimitive = 8;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = vec3(float(n), float(2*n), float(4*n));
    dataInterp[vertex]    = vec3(float(n), float(2*n), float(4*n));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveLineIndicesEXT[vertex] = uvec2(vertex * 2, vertex * 2 + 1u);
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) in vec3 dataIntrp;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec3 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    vec3 eA; { const int n = 1 + (2*p); eA = vec3(float(n), float(2*n), float(4*n)); }
    vec3 eB; { const int n = 1 + (2*p+1); eB = vec3(float(n), float(2*n), float(4*n)); }
    vec3 eC; { const int n = 1 + (2*p+1); eC = vec3(float(n), float(2*n), float(4*n)); }

    float e[9] = { eA.x,eA.y,eA.z,eB.x,eB.y,eB.z,eC.x,eC.y,eC.z };
    vec3 eIntrpV; {eIntrpV = vec3(eA * gl_BaryCoordEXT.x + eB * gl_BaryCoordEXT.y + eC * gl_BaryCoordEXT.z); }
    float eIntrp[9 / 3] = { eIntrpV.x,eIntrpV.y,eIntrpV.z };

    vec3 vA; { vA = data[pc.n[0]]; }
    vec3 vB; { vB = data[pc.n[1]]; }
    vec3 vC; { vC = data[pc.n[2]]; }
    vec3 vIntrpV; { vIntrpV = dataIntrp; }
    float vIntrp[9 / 3] = { vIntrpV.x,vIntrpV.y,vIntrpV.z };

    float v[9] = { vA.x,vA.y,vA.z,vB.x,vB.y,vB.z,vC.x,vC.y,vC.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<9 / 3; i++)
        if (abs(eIntrp[i] - vIntrp[i]) < 0.001)
            mask.y = mask.y | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(lines) out;
layout(max_vertices=16, max_primitives=16) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[16];
} pvd;
layout (location=0) out vec4 data[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 16;
    uint maxPrimitive = 8;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = vec4(float(n), float(2*n), float(4*n), float(8*n));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveLineIndicesEXT[vertex] = uvec2(vertex * 2, vertex * 2 + 1u);
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec4 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    vec4 eA; { const int n = 1 + (2*p); eA = vec4(float(n), float(2*n), float(4*n), float(8*n)); }
    vec4 eB; { const int n = 1 + (2*p+1); eB = vec4(float(n), float(2*n), float(4*n), float(8*n)); }
    vec4 eC; { const int n = 1 + (2*p+1); eC = vec4(float(n), float(2*n), float(4*n), float(8*n)); }

    float e[12] = { eA.x,eA.y,eA.z,eA.w,eB.x,eB.y,eB.z,eB.w,eC.x,eC.y,eC.z,eC.w };

    vec4 vA; { vA = data[pc.n[0]]; }
    vec4 vB; { vB = data[pc.n[1]]; }
    vec4 vC; { vC = data[pc.n[2]]; }

    float v[12] = { vA.x,vA.y,vA.z,vA.w,vB.x,vB.y,vB.z,vB.w,vC.x,vC.y,vC.z,vC.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(lines) out;
layout(max_vertices=16, max_primitives=16) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[16];
} pvd;
layout (location=0) out dvec2 data[];
layout(location = 2) out dvec2 dataFlat[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 16;
    uint maxPrimitive = 8;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = dvec2(double(n), double(2*n));
    dataFlat[vertex]      = dvec2(double(n), double(2*n));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveLineIndicesEXT[vertex] = uvec2(vertex * 2, vertex * 2 + 1u);
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 2) flat in dvec2 dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec2 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    dvec2 eA; { const int n = 1 + (2*p); eA = dvec2(double(n), double(2*n)); }
    dvec2 eB; { const int n = 1 + (2*p+1); eB = dvec2(double(n), double(2*n)); }
    dvec2 eC; { const int n = 1 + (2*p+1); eC = dvec2(double(n), double(2*n)); }

    double e[6] = { eA.x,eA.y,eB.x,eB.y,eC.x,eC.y };
    dvec2 eFlatV; { const int n = 1 + (2*p); eFlatV = dvec2(double(n), double(2*n)); }
    double eFlat[6 / 3] = { eFlatV.x,eFlatV.y };

    dvec2 vA; { vA = data[pc.n[0]]; }
    dvec2 vB; { vB = data[pc.n[1]]; }
    dvec2 vC; { vC = data[pc.n[2]]; }
    dvec2 vFlatV; { vFlatV = dataFlat; }
    double vFlat[6 / 3] = { vFlatV.x,vFlatV.y};

    double v[6] = { vA.x,vA.y,vB.x,vB.y,vC.x,vC.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(lines) out;
layout(max_vertices=16, max_primitives=16) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[16];
} pvd;
layout (location=0) out dvec3 data[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 16;
    uint maxPrimitive = 8;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = dvec3(double(n), double(2*n), double(4*n));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveLineIndicesEXT[vertex] = uvec2(vertex * 2, vertex * 2 + 1u);
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec3 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    dvec3 eA; { const int n = 1 + (2*p); eA = dvec3(double(n), double(2*n), double(4*n)); }
    dvec3 eB; { const int n = 1 + (2*p+1); eB = dvec3(double(n), double(2*n), double(4*n)); }
    dvec3 eC; { const int n = 1 + (2*p+1); eC = dvec3(double(n), double(2*n), double(4*n)); }

    double e[9] = { eA.x,eA.y,eA.z,eB.x,eB.y,eB.z,eC.x,eC.y,eC.z };

    dvec3 vA; { vA = data[pc.n[0]]; }
    dvec3 vB; { vB = data[pc.n[1]]; }
    dvec3 vC; { vC = data[pc.n[2]]; }

    double v[9] = { vA.x,vA.y,vA.z,vB.x,vB.y,vB.z,vC.x,vC.y,vC.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec4 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    dvec4 eA; { const int n = 1 + (2*p); eA = dvec4(double(n), double(2*n), double(4*n), double(8*n)); }
    dvec4 eB; { const int n = 1 + (2*p+1); eB = dvec4(double(n), double(2*n), double(4*n), double(8*n)); }
    dvec4 eC; { const int n = 1 + (2*p+1); eC = dvec4(double(n), double(2*n), double(4*n), double(8*n)); }

    double e[12] = { eA.x,eA.y,eA.z,eA.w,eB.x,eB.y,eB.z,eB.w,eC.x,eC.y,eC.z,eC.w };

    dvec4 vA; { vA = data[pc.n[0]]; }
    dvec4 vB; { vB = data[pc.n[1]]; }
    dvec4 vC; { vC = data[pc.n[2]]; }

    double v[12] = { vA.x,vA.y,vA.z,vA.w,vB.x,vB.y,vB.z,vB.w,vC.x,vC.y,vC.z,vC.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 2) flat in dvec4 dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec4 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    dvec4 eA; { const int n = 1 + (2*p); eA = dvec4(double(n), double(2*n), double(4*n), double(8*n)); }
    dvec4 eB; { const int n = 1 + (2*p+1); eB = dvec4(double(n), double(2*n), double(4*n), double(8*n)); }
    dvec4 eC; { const int n = 1 + (2*p+1); eC = dvec4(double(n), double(2*n), double(4*n), double(8*n)); }

    double e[12] = { eA.x,eA.y,eA.z,eA.w,eB.x,eB.y,eB.z,eB.w,eC.x,eC.y,eC.z,eC.w };
    dvec4 eFlatV; { const int n = 1 + (2*p); eFlatV = dvec4(double(n), double(2*n), double(4*n), double(8*n)); }
    double eFlat[12 / 3] = { eFlatV.x,eFlatV.y,eFlatV.z,eFlatV.w };

    dvec4 vA; { vA = data[pc.n[0]]; }
    dvec4 vB; { vB = data[pc.n[1]]; }
    dvec4 vC; { vC = data[pc.n[2]]; }
    dvec4 vFlatV; { vFlatV = dataFlat; }
    double vFlat[12 / 3] = { vFlatV.x,vFlatV.y,vFlatV.z,vFlatV.w};

    double v[12] = { vA.x,vA.y,vA.z,vA.w,vB.x,vB.y,vB.z,vB.w,vC.x,vC.y,vC.z,vC.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<12 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) flat in int dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in int data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    int eA; { const int n = 1 + (2*p); eA = int(n); }
    int eB; { const int n = 1 + (2*p+1); eB = int(n); }
    int eC; { const int n = 1 + (2*p+1); eC = int(n); }

    int e[3] = { eA,eB,eC };
    int eFlatV; { const int n = 1 + (2*p); eFlatV = int(n); }
    int eFlat[3 / 3] = { eFlatV };

    int vA; { vA = data[pc.n[0]]; }
    int vB; { vB = data[pc.n[1]]; }
    int vC; { vC = data[pc.n[2]]; }
    int vFlatV; { vFlatV = dataFlat; }
    int vFlat[3 / 3] = { vFlatV};

    int v[3] = { vA,vB,vC };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<3 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(lines) out;
layout(max_vertices=16, max_primitives=16) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[16];
} pvd;
layout (location=0) out uint data[];
layout(location = 1) out uint dataFlat[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 16;
    uint maxPrimitive = 8;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = uint(n);
    dataFlat[vertex]      = uint(n);
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveLineIndicesEXT[vertex] = uvec2(vertex * 2, vertex * 2 + 1u);
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) flat in uint dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uint data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    uint eA; { const int n = 1 + (2*p); eA = uint(n); }
    uint eB; { const int n = 1 + (2*p+1); eB = uint(n); }
    uint eC; { const int n = 1 + (2*p+1); eC = uint(n); }

    uint e[3] = { eA,eB,eC };
    uint eFlatV; { const int n = 1 + (2*p); eFlatV = uint(n); }
    uint eFlat[3 / 3] = { eFlatV };

    uint vA; { vA = data[pc.n[0]]; }
    uint vB; { vB = data[pc.n[1]]; }
    uint vC; { vC = data[pc.n[2]]; }
    uint vFlatV; { vFlatV = dataFlat; }
    uint vFlat[3 / 3] = { vFlatV};

    uint v[3] = { vA,vB,vC };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<3 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) flat in uvec2 dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uvec2 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    uvec2 eA; { const int n = 1 + (2*p); eA = uvec2(uint(n), uint(2*n)); }
    uvec2 eB; { const int n = 1 + (2*p+1); eB = uvec2(uint(n), uint(2*n)); }
    uvec2 eC; { const int n = 1 + (2*p+1); eC = uvec2(uint(n), uint(2*n)); }

    uint e[6] = { eA.x,eA.y,eB.x,eB.y,eC.x,eC.y };
    uvec2 eFlatV; { const int n = 1 + (2*p); eFlatV = uvec2(uint(n), uint(2*n)); }
    uint eFlat[6 / 3] = { eFlatV.x,eFlatV.y };

    uvec2 vA; { vA = data[pc.n[0]]; }
    uvec2 vB; { vB = data[pc.n[1]]; }
    uvec2 vC; { vC = data[pc.n[2]]; }
    uvec2 vFlatV; { vFlatV = dataFlat; }
    uint vFlat[6 / 3] = { vFlatV.x,vFlatV.y};

    uint v[6] = { vA.x,vA.y,vB.x,vB.y,vC.x,vC.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uvec3 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    uvec3 eA; { const int n = 1 + (2*p); eA = uvec3(uint(n), uint(2*n), uint(4*n)); }
    uvec3 eB; { const int n = 1 + (2*p+1); eB = uvec3(uint(n), uint(2*n), uint(4*n)); }
    uvec3 eC; { const int n = 1 + (2*p+1); eC = uvec3(uint(n), uint(2*n), uint(4*n)); }

    uint e[9] = { eA.x,eA.y,eA.z,eB.x,eB.y,eB.z,eC.x,eC.y,eC.z };

    uvec3 vA; { vA = data[pc.n[0]]; }
    uvec3 vB; { vB = data[pc.n[1]]; }
    uvec3 vC; { vC = data[pc.n[2]]; }

    uint v[9] = { vA.x,vA.y,vA.z,vB.x,vB.y,vB.z,vC.x,vC.y,vC.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {float q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) in DataStruct dataIntrp;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (2*p); eA = DataStruct(float(n)); }
    DataStruct eB; { const int n = 1 + (2*p+1); eB = DataStruct(float(n)); }
    DataStruct eC; { const int n = 1 + (2*p+1); eC = DataStruct(float(n)); }

    float e[3] = { eA.q,eB.q,eC.q };
    DataStruct eIntrpV; {eIntrpV = DataStruct(eA.q * gl_BaryCoordEXT.x + eB.q * gl_BaryCoordEXT.y + eC.q * gl_BaryCoordEXT.z); }
    float eIntrp[3 / 3] = { eIntrpV.q };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }
    DataStruct vIntrpV; { vIntrpV = dataIntrp; }
    float vIntrp[3 / 3] = { vIntrpV.q };

    float v[3] = { vA.q,vB.q,vC.q };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<3 / 3; i++)
        if (abs(eIntrp[i] - vIntrp[i]) < 0.001)
            mask.y = mask.y | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable

struct DataStruct {vec2 q;};
layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(lines) out;
layout(max_vertices=16, max_primitives=16) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[16];
} pvd;
layout (location=0) out DataStruct data[];
layout(location = 1) out DataStruct dataInterp[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 16;
    uint maxPrimitive = 8;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = DataStruct(vec2(float(n), float(2*n)));
    dataInterp[vertex]    = DataStruct(vec2(float(n), float(2*n)));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveLineIndicesEXT[vertex] = uvec2(vertex * 2, vertex * 2 + 1u);
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec2 q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) in DataStruct dataIntrp;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (2*p); eA = DataStruct(vec2(float(n), float(2*n))); }
    DataStruct eB; { const int n = 1 + (2*p+1); eB = DataStruct(vec2(float(n), float(2*n))); }
    DataStruct eC; { const int n = 1 + (2*p+1); eC = DataStruct(vec2(float(n), float(2*n))); }

    float e[6] = { eA.q.x,eA.q.y,eB.q.x,eB.q.y,eC.q.x,eC.q.y };
    DataStruct eIntrpV; {eIntrpV = DataStruct(eA.q * gl_BaryCoordEXT.x + eB.q * gl_BaryCoordEXT.y + eC.q * gl_BaryCoordEXT.z); }
    float eIntrp[6 / 3] = { eIntrpV.q.x,eIntrpV.q.y };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }
    DataStruct vIntrpV; { vIntrpV = dataIntrp; }
    float vIntrp[6 / 3] = { vIntrpV.q.x,vIntrpV.q.y };

    float v[6] = { vA.q.x,vA.q.y,vB.q.x,vB.q.y,vC.q.x,vC.q.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (abs(eIntrp[i] - vIntrp[i]) < 0.001)
            mask.y = mask.y | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable

struct DataStruct {vec3 q;};
layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(lines) out;
layout(max_vertices=16, max_primitives=16) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[16];
} pvd;
layout (location=0) out DataStruct data[];
layout(location = 1) out DataStruct dataFlat[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 16;
    uint maxPrimitive = 8;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = DataStruct(vec3(float(n), float(2*n), float(4*n)));
    dataFlat[vertex]      = DataStruct(vec3(float(n), float(2*n), float(4*n)));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveLineIndicesEXT[vertex] = uvec2(vertex * 2, vertex * 2 + 1u);
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec3 q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (2*p); eA = DataStruct(vec3(float(n), float(2*n), float(4*n))); }
    DataStruct eB; { const int n = 1 + (2*p+1); eB = DataStruct(vec3(float(n), float(2*n), float(4*n))); }
    DataStruct eC; { const int n = 1 + (2*p+1); eC = DataStruct(vec3(float(n), float(2*n), float(4*n))); }

    float e[9] = { eA.q.x,eA.q.y,eA.q.z,eB.q.x,eB.q.y,eB.q.z,eC.q.x,eC.q.y,eC.q.z };
    DataStruct eFlatV; { const int n = 1 + (2*p); eFlatV = DataStruct(vec3(float(n), float(2*n), float(4*n))); }
    float eFlat[9 / 3] = { eFlatV.q.x,eFlatV.q.y,eFlatV.q.z };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    float vFlat[9 / 3] = { vFlatV.q.x,vFlatV.q.y,vFlatV.q.z};

    float v[9] = { vA.q.x,vA.q.y,vA.q.z,vB.q.x,vB.q.y,vB.q.z,vC.q.x,vC.q.y,vC.q.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<9 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable

struct DataStruct {vec4 q;};
layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(lines) out;
layout(max_vertices=16, max_primitives=16) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[16];
} pvd;
layout (location=0) out DataStruct data[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 16;
    uint maxPrimitive = 8;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = DataStruct(vec4(float(n), float(2*n), float(4*n), float(8*n)));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveLineIndicesEXT[vertex] = uvec2(vertex * 2, vertex * 2 + 1u);
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec4 q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (2*p); eA = DataStruct(vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    DataStruct eB; { const int n = 1 + (2*p+1); eB = DataStruct(vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    DataStruct eC; { const int n = 1 + (2*p+1); eC = DataStruct(vec4(float(n), float(2*n), float(4*n), float(8*n))); }

    float e[12] = { eA.q.x,eA.q.y,eA.q.z,eA.q.w,eB.q.x,eB.q.y,eB.q.z,eB.q.w,eC.q.x,eC.q.y,eC.q.z,eC.q.w };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }

    float v[12] = { vA.q.x,vA.q.y,vA.q.z,vA.q.w,vB.q.x,vB.q.y,vB.q.z,vB.q.w,vC.q.x,vC.q.y,vC.q.z,vC.q.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec4 q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;
layout(location = 1) out DataStruct dataInterp;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(vec4(float(n), float(2*n), float(4*n), float(8*n)));
    dataInterp    = DataStruct(vec4(float(n), float(2*n), float(4*n), float(8*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec4 q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) in DataStruct dataIntrp;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (2*p); eA = DataStruct(vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    DataStruct eB; { const int n = 1 + (2*p+1); eB = DataStruct(vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    DataStruct eC; { const int n = 1 + (2*p+1); eC = DataStruct(vec4(float(n), float(2*n), float(4*n), float(8*n))); }

    float e[12] = { eA.q.x,eA.q.y,eA.q.z,eA.q.w,eB.q.x,eB.q.y,eB.q.z,eB.q.w,eC.q.x,eC.q.y,eC.q.z,eC.q.w };
    DataStruct eIntrpV; {eIntrpV = DataStruct(eA.q * gl_BaryCoordEXT.x + eB.q * gl_BaryCoordEXT.y + eC.q * gl_BaryCoordEXT.z); }
    float eIntrp[12 / 3] = { eIntrpV.q.x,eIntrpV.q.y,eIntrpV.q.z,eIntrpV.q.w };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }
    DataStruct vIntrpV; { vIntrpV = dataIntrp; }
    float vIntrp[12 / 3] = { vIntrpV.q.x,vIntrpV.q.y,vIntrpV.q.z,vIntrpV.q.w };

    float v[12] = { vA.q.x,vA.q.y,vA.q.z,vA.q.w,vB.q.x,vB.q.y,vB.q.z,vB.q.w,vC.q.x,vC.q.y,vC.q.z,vC.q.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<12 / 3; i++)
        if (abs(eIntrp[i] - vIntrp[i]) < 0.001)
            mask.y = mask.y | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable

struct DataStruct {double q;};
layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(lines) out;
layout(max_vertices=16, max_primitives=16) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[16];
} pvd;
layout (location=0) out DataStruct data[];
layout(location = 2) out DataStruct dataFlat[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 16;
    uint maxPrimitive = 8;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = DataStruct(double(n));
    dataFlat[vertex]      = DataStruct(double(n));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveLineIndicesEXT[vertex] = uvec2(vertex * 2, vertex * 2 + 1u);
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {double q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 2) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (2*p); eA = DataStruct(double(n)); }
    DataStruct eB; { const int n = 1 + (2*p+1); eB = DataStruct(double(n)); }
    DataStruct eC; { const int n = 1 + (2*p+1); eC = DataStruct(double(n)); }

    double e[3] = { eA.q,eB.q,eC.q };
    DataStruct eFlatV; { const int n = 1 + (2*p); eFlatV = DataStruct(double(n)); }
    double eFlat[3 / 3] = { eFlatV.q };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    double vFlat[3 / 3] = { vFlatV.q};

    double v[3] = { vA.q,vB.q,vC.q };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<3 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable

struct DataStruct {dvec2 q;};
layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(lines) out;
layout(max_vertices=16, max_primitives=16) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[16];
} pvd;
layout (location=0) out DataStruct data[];
layout(location = 2) out DataStruct dataFlat[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 16;
    uint maxPrimitive = 8;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = DataStruct(dvec2(double(n), double(2*n)));
    dataFlat[vertex]      = DataStruct(dvec2(double(n), double(2*n)));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveLineIndicesEXT[vertex] = uvec2(vertex * 2, vertex * 2 + 1u);
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {dvec2 q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 2) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (2*p); eA = DataStruct(dvec2(double(n), double(2*n))); }
    DataStruct eB; { const int n = 1 + (2*p+1); eB = DataStruct(dvec2(double(n), double(2*n))); }
    DataStruct eC; { const int n = 1 + (2*p+1); eC = DataStruct(dvec2(double(n), double(2*n))); }

    double e[6] = { eA.q.x,eA.q.y,eB.q.x,eB.q.y,eC.q.x,eC.q.y };
    DataStruct eFlatV; { const int n = 1 + (2*p); eFlatV = DataStruct(dvec2(double(n), double(2*n))); }
    double eFlat[6 / 3] = { eFlatV.q.x,eFlatV.q.y };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    double vFlat[6 / 3] = { vFlatV.q.x,vFlatV.q.y};

    double v[6] = { vA.q.x,vA.q.y,vB.q.x,vB.q.y,vC.q.x,vC.q.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable

struct DataStruct {dvec4 q;};
layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(lines) out;
layout(max_vertices=16, max_primitives=16) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[16];
} pvd;
layout (location=0) out DataStruct data[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 16;
    uint maxPrimitive = 8;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = DataStruct(dvec4(double(n), double(2*n), double(4*n), double(8*n)));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveLineIndicesEXT[vertex] = uvec2(vertex * 2, vertex * 2 + 1u);
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {dvec4 q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (2*p); eA = DataStruct(dvec4(double(n), double(2*n), double(4*n), double(8*n))); }
    DataStruct eB; { const int n = 1 + (2*p+1); eB = DataStruct(dvec4(double(n), double(2*n), double(4*n), double(8*n))); }
    DataStruct eC; { const int n = 1 + (2*p+1); eC = DataStruct(dvec4(double(n), double(2*n), double(4*n), double(8*n))); }

    double e[12] = { eA.q.x,eA.q.y,eA.q.z,eA.q.w,eB.q.x,eB.q.y,eB.q.z,eB.q.w,eC.q.x,eC.q.y,eC.q.z,eC.q.w };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }

    double v[12] = { vA.q.x,vA.q.y,vA.q.z,vA.q.w,vB.q.x,vB.q.y,vB.q.z,vB.q.w,vC.q.x,vC.q.y,vC.q.z,vC.q.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {int q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (2*p); eA = DataStruct(int(n)); }
    DataStruct eB; { const int n = 1 + (2*p+1); eB = DataStruct(int(n)); }
    DataStruct eC; { const int n = 1 + (2*p+1); eC = DataStruct(int(n)); }

    int e[3] = { eA.q,eB.q,eC.q };
    DataStruct eFlatV; { const int n = 1 + (2*p); eFlatV = DataStruct(int(n)); }
    int eFlat[3 / 3] = { eFlatV.q };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    int vFlat[3 / 3] = { vFlatV.q};

    int v[3] = { vA.q,vB.q,vC.q };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<3 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable

struct DataStruct {ivec2 q;};
layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(lines) out;
layout(max_vertices=16, max_primitives=16) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[16];
} pvd;
layout (location=0) out DataStruct data[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 16;
    uint maxPrimitive = 8;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = DataStruct(ivec2(int(n), int(2*n)));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveLineIndicesEXT[vertex] = uvec2(vertex * 2, vertex * 2 + 1u);
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {ivec2 q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (2*p); eA = DataStruct(ivec2(int(n), int(2*n))); }
    DataStruct eB; { const int n = 1 + (2*p+1); eB = DataStruct(ivec2(int(n), int(2*n))); }
    DataStruct eC; { const int n = 1 + (2*p+1); eC = DataStruct(ivec2(int(n), int(2*n))); }

    int e[6] = { eA.q.x,eA.q.y,eB.q.x,eB.q.y,eC.q.x,eC.q.y };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }

    int v[6] = { vA.q.x,vA.q.y,vB.q.x,vB.q.y,vC.q.x,vC.q.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {uint q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (2*p); eA = DataStruct(uint(n)); }
    DataStruct eB; { const int n = 1 + (2*p+1); eB = DataStruct(uint(n)); }
    DataStruct eC; { const int n = 1 + (2*p+1); eC = DataStruct(uint(n)); }

    uint e[3] = { eA.q,eB.q,eC.q };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }

    uint v[3] = { vA.q,vB.q,vC.q };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(lines) out;
layout(max_vertices=16, max_primitives=16) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[16];
} pvd;
layout (location=0) out float data[][2];
layout(location = 2) out float dataFlat[][2];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 16;
    uint maxPrimitive = 8;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = float[2](float(n), float(3)*float(n));
    dataFlat[vertex]      = float[2](float(n), float(3)*float(n));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveLineIndicesEXT[vertex] = uvec2(vertex * 2, vertex * 2 + 1u);
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 2) flat in float dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in float data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    float eA[2]; { const int n = 1 + (2*p); eA = float[2](float(n), float(3)*float(n)); }
    float eB[2]; { const int n = 1 + (2*p+1); eB = float[2](float(n), float(3)*float(n)); }
    float eC[2]; { const int n = 1 + (2*p+1); eC = float[2](float(n), float(3)*float(n)); }

    float e[6] = { eA[0],eA[1],eB[0],eB[1],eC[0],eC[1] };
    float eFlatV[2]; { const int n = 1 + (2*p); eFlatV = float[2](float(n), float(3)*float(n)); }
    float eFlat[6 / 3] = { eFlatV[0],eFlatV[1] };

    float vA[2]; { vA = float[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    float vB[2]; { vB = float[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    float vC[2]; { vC = float[2](data[pc.n[2]][0],data[pc.n[2]][1]); }
    float vFlatV[2]; { vFlatV = float[2](dataFlat[0],dataFlat[1]); }
    float vFlat[6 / 3] = { vFlatV[0],vFlatV[1]};

    float v[6] = { vA[0],vA[1],vB[0],vB[1],vC[0],vC[1] };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out vec2 data[2];
layout(location = 2) out vec2 dataInterp[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = vec2[2](vec2(float(n), float(2*n)), float(3)*vec2(float(n), float(2*n)));
    dataInterp    = vec2[2](vec2(float(n), float(2*n)), float(3)*vec2(float(n), float(2*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 2) in vec2 dataIntrp[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec2 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    vec2 eA[2]; { const int n = 1 + (2*p); eA = vec2[2](vec2(float(n), float(2*n)), float(3)*vec2(float(n), float(2*n))); }
    vec2 eB[2]; { const int n = 1 + (2*p+1); eB = vec2[2](vec2(float(n), float(2*n)), float(3)*vec2(float(n), float(2*n))); }
    vec2 eC[2]; { const int n = 1 + (2*p+1); eC = vec2[2](vec2(float(n), float(2*n)), float(3)*vec2(float(n), float(2*n))); }

    float e[12] = { eA[0].x,eA[0].y,eA[1].x,eA[1].y,eB[0].x,eB[0].y,eB[1].x,eB[1].y,eC[0].x,eC[0].y,eC[1].x,eC[1].y };
    vec2 eIntrpV[2]; {eIntrpV = vec2[2](eA[0] * gl_BaryCoordEXT.x + eB[0] * gl_BaryCoordEXT.y + eC[0] * gl_BaryCoordEXT.z, eA[1] * gl_BaryCoordEXT.x + eB[1] * gl_BaryCoordEXT.y + eC[1] * gl_BaryCoordEXT.z); }
    float eIntrp[12 / 3] = { eIntrpV[0].x,eIntrpV[0].y,eIntrpV[1].x,eIntrpV[1].y };

    vec2 vA[2]; { vA = vec2[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    vec2 vB[2]; { vB = vec2[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    vec2 vC[2]; { vC = vec2[2](data[pc.n[2]][0],data[pc.n[2]][1]); }
    vec2 vIntrpV[2]; { vIntrpV = vec2[2](dataIntrp[0],dataIntrp[1]); }
    float vIntrp[12 / 3] = { vIntrpV[0].x,vIntrpV[0].y,vIntrpV[1].x,vIntrpV[1].y };

    float v[12] = { vA[0].x,vA[0].y,vA[1].x,vA[1].y,vB[0].x,vB[0].y,vB[1].x,vB[1].y,vC[0].x,vC[0].y,vC[1].x,vC[1].y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<12 / 3; i++)
        if (abs(eIntrp[i] - vIntrp[i]) < 0.001)
            mask.y = mask.y | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec3 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    vec3 eA[2]; { const int n = 1 + (2*p); eA = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n))); }
    vec3 eB[2]; { const int n = 1 + (2*p+1); eB = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n))); }
    vec3 eC[2]; { const int n = 1 + (2*p+1); eC = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n))); }

    float e[18] = { eA[0].x,eA[0].y,eA[0].z,eA[1].x,eA[1].y,eA[1].z,eB[0].x,eB[0].y,eB[0].z,eB[1].x,eB[1].y,eB[1].z,eC[0].x,eC[0].y,eC[0].z,eC[1].x,eC[1].y,eC[1].z };

    vec3 vA[2]; { vA = vec3[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    vec3 vB[2]; { vB = vec3[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    vec3 vC[2]; { vC = vec3[2](data[pc.n[2]][0],data[pc.n[2]][1]); }

    float v[18] = { vA[0].x,vA[0].y,vA[0].z,vA[1].x,vA[1].y,vA[1].z,vB[0].x,vB[0].y,vB[0].z,vB[1].x,vB[1].y,vB[1].z,vC[0].x,vC[0].y,vC[0].z,vC[1].x,vC[1].y,vC[1].z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<18; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(lines) out;
layout(max_vertices=16, max_primitives=16) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[16];
} pvd;
layout (location=0) out vec3 data[][2];
layout(location = 2) out vec3 dataInterp[][2];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 16;
    uint maxPrimitive = 8;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n)));
    dataInterp[vertex]    = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n)));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveLineIndicesEXT[vertex] = uvec2(vertex * 2, vertex * 2 + 1u);
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 2) in vec3 dataIntrp[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec3 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    vec3 eA[2]; { const int n = 1 + (2*p); eA = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n))); }
    vec3 eB[2]; { const int n = 1 + (2*p+1); eB = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n))); }
    vec3 eC[2]; { const int n = 1 + (2*p+1); eC = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n))); }

    float e[18] = { eA[0].x,eA[0].y,eA[0].z,eA[1].x,eA[1].y,eA[1].z,eB[0].x,eB[0].y,eB[0].z,eB[1].x,eB[1].y,eB[1].z,eC[0].x,eC[0].y,eC[0].z,eC[1].x,eC[1].y,eC[1].z };
    vec3 eIntrpV[2]; {eIntrpV = vec3[2](eA[0] * gl_BaryCoordEXT.x + eB[0] * gl_BaryCoordEXT.y + eC[0] * gl_BaryCoordEXT.z, eA[1] * gl_BaryCoordEXT.x + eB[1] * gl_BaryCoordEXT.y + eC[1] * gl_BaryCoordEXT.z); }
    float eIntrp[18 / 3] = { eIntrpV[0].x,eIntrpV[0].y,eIntrpV[0].z,eIntrpV[1].x,eIntrpV[1].y,eIntrpV[1].z };

    vec3 vA[2]; { vA = vec3[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    vec3 vB[2]; { vB = vec3[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    vec3 vC[2]; { vC = vec3[2](data[pc.n[2]][0],data[pc.n[2]][1]); }
    vec3 vIntrpV[2]; { vIntrpV = vec3[2](dataIntrp[0],dataIntrp[1]); }
    float vIntrp[18 / 3] = { vIntrpV[0].x,vIntrpV[0].y,vIntrpV[0].z,vIntrpV[1].x,vIntrpV[1].y,vIntrpV[1].z };

    float v[18] = { vA[0].x,vA[0].y,vA[0].z,vA[1].x,vA[1].y,vA[1].z,vB[0].x,vB[0].y,vB[0].z,vB[1].x,vB[1].y,vB[1].z,vC[0].x,vC[0].y,vC[0].z,vC[1].x,vC[1].y,vC[1].z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<18; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<18 / 3; i++)
        if (abs(eIntrp[i] - vIntrp[i]) < 0.001)
            mask.y = mask.y | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out vec3 data[2];
layout(location = 2) out vec3 dataInterp[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n)));
    dataInterp    = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(lines) out;
layout(max_vertices=16, max_primitives=16) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[16];
} pvd;
layout (location=0) out double data[][2];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 16;
    uint maxPrimitive = 8;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = double[2](double(n), double(3)*double(n));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveLineIndicesEXT[vertex] = uvec2(vertex * 2, vertex * 2 + 1u);
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in double data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    double eA[2]; { const int n = 1 + (2*p); eA = double[2](double(n), double(3)*double(n)); }
    double eB[2]; { const int n = 1 + (2*p+1); eB = double[2](double(n), double(3)*double(n)); }
    double eC[2]; { const int n = 1 + (2*p+1); eC = double[2](double(n), double(3)*double(n)); }

    double e[6] = { eA[0],eA[1],eB[0],eB[1],eC[0],eC[1] };

    double vA[2]; { vA = double[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    double vB[2]; { vB = double[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    double vC[2]; { vC = double[2](data[pc.n[2]][0],data[pc.n[2]][1]); }

    double v[6] = { vA[0],vA[1],vB[0],vB[1],vC[0],vC[1] };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(lines) out;
layout(max_vertices=16, max_primitives=16) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[16];
} pvd;
layout (location=0) out dvec3 data[][2];
layout(location = 4) out dvec3 dataFlat[][2];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 16;
    uint maxPrimitive = 8;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n)));
    dataFlat[vertex]      = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n)));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveLineIndicesEXT[vertex] = uvec2(vertex * 2, vertex * 2 + 1u);
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 4) flat in dvec3 dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec3 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    dvec3 eA[2]; { const int n = 1 + (2*p); eA = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n))); }
    dvec3 eB[2]; { const int n = 1 + (2*p+1); eB = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n))); }
    dvec3 eC[2]; { const int n = 1 + (2*p+1); eC = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n))); }

    double e[18] = { eA[0].x,eA[0].y,eA[0].z,eA[1].x,eA[1].y,eA[1].z,eB[0].x,eB[0].y,eB[0].z,eB[1].x,eB[1].y,eB[1].z,eC[0].x,eC[0].y,eC[0].z,eC[1].x,eC[1].y,eC[1].z };
    dvec3 eFlatV[2]; { const int n = 1 + (2*p); eFlatV = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n))); }
    double eFlat[18 / 3] = { eFlatV[0].x,eFlatV[0].y,eFlatV[0].z,eFlatV[1].x,eFlatV[1].y,eFlatV[1].z };

    dvec3 vA[2]; { vA = dvec3[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    dvec3 vB[2]; { vB = dvec3[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    dvec3 vC[2]; { vC = dvec3[2](data[pc.n[2]][0],data[pc.n[2]][1]); }
    dvec3 vFlatV[2]; { vFlatV = dvec3[2](dataFlat[0],dataFlat[1]); }
    double vFlat[18 / 3] = { vFlatV[0].x,vFlatV[0].y,vFlatV[0].z,vFlatV[1].x,vFlatV[1].y,vFlatV[1].z};

    double v[18] = { vA[0].x,vA[0].y,vA[0].z,vA[1].x,vA[1].y,vA[1].z,vB[0].x,vB[0].y,vB[0].z,vB[1].x,vB[1].y,vB[1].z,vC[0].x,vC[0].y,vC[0].z,vC[1].x,vC[1].y,vC[1].z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<18; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<18 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in ivec2 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    ivec2 eA[2]; { const int n = 1 + (2*p); eA = ivec2[2](ivec2(int(n), int(2*n)), int(3)*ivec2(int(n), int(2*n))); }
    ivec2 eB[2]; { const int n = 1 + (2*p+1); eB = ivec2[2](ivec2(int(n), int(2*n)), int(3)*ivec2(int(n), int(2*n))); }
    ivec2 eC[2]; { const int n = 1 + (2*p+1); eC = ivec2[2](ivec2(int(n), int(2*n)), int(3)*ivec2(int(n), int(2*n))); }

    int e[12] = { eA[0].x,eA[0].y,eA[1].x,eA[1].y,eB[0].x,eB[0].y,eB[1].x,eB[1].y,eC[0].x,eC[0].y,eC[1].x,eC[1].y };

    ivec2 vA[2]; { vA = ivec2[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    ivec2 vB[2]; { vB = ivec2[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    ivec2 vC[2]; { vC = ivec2[2](data[pc.n[2]][0],data[pc.n[2]][1]); }

    int v[12] = { vA[0].x,vA[0].y,vA[1].x,vA[1].y,vB[0].x,vB[0].y,vB[1].x,vB[1].y,vC[0].x,vC[0].y,vC[1].x,vC[1].y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(lines) out;
layout(max_vertices=16, max_primitives=16) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[16];
} pvd;
layout (location=0) out ivec3 data[][2];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 16;
    uint maxPrimitive = 8;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = ivec3[2](ivec3(int(n), int(2*n), int(4*n)), int(3)*ivec3(int(n), int(2*n), int(4*n)));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveLineIndicesEXT[vertex] = uvec2(vertex * 2, vertex * 2 + 1u);
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in ivec3 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    ivec3 eA[2]; { const int n = 1 + (2*p); eA = ivec3[2](ivec3(int(n), int(2*n), int(4*n)), int(3)*ivec3(int(n), int(2*n), int(4*n))); }
    ivec3 eB[2]; { const int n = 1 + (2*p+1); eB = ivec3[2](ivec3(int(n), int(2*n), int(4*n)), int(3)*ivec3(int(n), int(2*n), int(4*n))); }
    ivec3 eC[2]; { const int n = 1 + (2*p+1); eC = ivec3[2](ivec3(int(n), int(2*n), int(4*n)), int(3)*ivec3(int(n), int(2*n), int(4*n))); }

    int e[18] = { eA[0].x,eA[0].y,eA[0].z,eA[1].x,eA[1].y,eA[1].z,eB[0].x,eB[0].y,eB[0].z,eB[1].x,eB[1].y,eB[1].z,eC[0].x,eC[0].y,eC[0].z,eC[1].x,eC[1].y,eC[1].z };

    ivec3 vA[2]; { vA = ivec3[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    ivec3 vB[2]; { vB = ivec3[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    ivec3 vC[2]; { vC = ivec3[2](data[pc.n[2]][0],data[pc.n[2]][1]); }

    int v[18] = { vA[0].x,vA[0].y,vA[0].z,vA[1].x,vA[1].y,vA[1].z,vB[0].x,vB[0].y,vB[0].z,vB[1].x,vB[1].y,vB[1].z,vC[0].x,vC[0].y,vC[0].z,vC[1].x,vC[1].y,vC[1].z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<18; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(lines) out;
layout(max_vertices=16, max_primitives=16) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[16];
} pvd;
layout (location=0) out ivec4 data[][2];
layout(location = 2) out ivec4 dataFlat[][2];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 16;
    uint maxPrimitive = 8;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n)));
    dataFlat[vertex]      = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n)));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveLineIndicesEXT[vertex] = uvec2(vertex * 2, vertex * 2 + 1u);
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 2) flat in ivec4 dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in ivec4 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    ivec4 eA[2]; { const int n = 1 + (2*p); eA = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n))); }
    ivec4 eB[2]; { const int n = 1 + (2*p+1); eB = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n))); }
    ivec4 eC[2]; { const int n = 1 + (2*p+1); eC = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n))); }

    int e[24] = { eA[0].x,eA[0].y,eA[0].z,eA[0].w,eA[1].x,eA[1].y,eA[1].z,eA[1].w,eB[0].x,eB[0].y,eB[0].z,eB[0].w,eB[1].x,eB[1].y,eB[1].z,eB[1].w,eC[0].x,eC[0].y,eC[0].z,eC[0].w,eC[1].x,eC[1].y,eC[1].z,eC[1].w };
    ivec4 eFlatV[2]; { const int n = 1 + (2*p); eFlatV = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n))); }
    int eFlat[24 / 3] = { eFlatV[0].x,eFlatV[0].y,eFlatV[0].z,eFlatV[0].w,eFlatV[1].x,eFlatV[1].y,eFlatV[1].z,eFlatV[1].w };

    ivec4 vA[2]; { vA = ivec4[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    ivec4 vB[2]; { vB = ivec4[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    ivec4 vC[2]; { vC = ivec4[2](data[pc.n[2]][0],data[pc.n[2]][1]); }
    ivec4 vFlatV[2]; { vFlatV = ivec4[2](dataFlat[0],dataFlat[1]); }
    int vFlat[24 / 3] = { vFlatV[0].x,vFlatV[0].y,vFlatV[0].z,vFlatV[0].w,vFlatV[1].x,vFlatV[1].y,vFlatV[1].z,vFlatV[1].w};

    int v[24] = { vA[0].x,vA[0].y,vA[0].z,vA[0].w,vA[1].x,vA[1].y,vA[1].z,vA[1].w,vB[0].x,vB[0].y,vB[0].z,vB[0].w,vB[1].x,vB[1].y,vB[1].z,vB[1].w,vC[0].x,vC[0].y,vC[0].z,vC[0].w,vC[1].x,vC[1].y,vC[1].z,vC[1].w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<24; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<24 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(lines) out;
layout(max_vertices=16, max_primitives=16) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[16];
} pvd;
layout (location=0) out uint data[][2];
layout(location = 2) out uint dataFlat[][2];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 16;
    uint maxPrimitive = 8;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = uint[2](uint(n), uint(3)*uint(n));
    dataFlat[vertex]      = uint[2](uint(n), uint(3)*uint(n));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveLineIndicesEXT[vertex] = uvec2(vertex * 2, vertex * 2 + 1u);
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 2) flat in uint dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uint data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    uint eA[2]; { const int n = 1 + (2*p); eA = uint[2](uint(n), uint(3)*uint(n)); }
    uint eB[2]; { const int n = 1 + (2*p+1); eB = uint[2](uint(n), uint(3)*uint(n)); }
    uint eC[2]; { const int n = 1 + (2*p+1); eC = uint[2](uint(n), uint(3)*uint(n)); }

    uint e[6] = { eA[0],eA[1],eB[0],eB[1],eC[0],eC[1] };
    uint eFlatV[2]; { const int n = 1 + (2*p); eFlatV = uint[2](uint(n), uint(3)*uint(n)); }
    uint eFlat[6 / 3] = { eFlatV[0],eFlatV[1] };

    uint vA[2]; { vA = uint[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    uint vB[2]; { vB = uint[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    uint vC[2]; { vC = uint[2](data[pc.n[2]][0],data[pc.n[2]][1]); }
    uint vFlatV[2]; { vFlatV = uint[2](dataFlat[0],dataFlat[1]); }
    uint vFlat[6 / 3] = { vFlatV[0],vFlatV[1]};

    uint v[6] = { vA[0],vA[1],vB[0],vB[1],vC[0],vC[1] };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec4 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = 2*y;
    const bool even = (p%2 == 0);

    dvec4 eA; { const int n = 1 + (p); eA = dvec4(double(n), double(2*n), double(4*n), double(8*n)); }
    dvec4 eB; { const int n = 1 + (p+1); eB = dvec4(double(n), double(2*n), double(4*n), double(8*n)); }
    dvec4 eC; { const int n = 1 + (p+1); eC = dvec4(double(n), double(2*n), double(4*n), double(8*n)); }

    double e[12] = { eA.x,eA.y,eA.z,eA.w,eB.x,eB.y,eB.z,eB.w,eC.x,eC.y,eC.z,eC.w };

    dvec4 vA; { vA = data[pc.n[0]]; }
    dvec4 vB; { vB = data[pc.n[1]]; }
    dvec4 vC; { vC = data[pc.n[2]]; }

    double v[12] = { vA.x,vA.y,vA.z,vA.w,vB.x,vB.y,vB.z,vB.w,vC.x,vC.y,vC.z,vC.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) flat in int dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in int data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = 2*y;
    const bool even = (p%2 == 0);

    int eA; { const int n = 1 + (p); eA = int(n); }
    int eB; { const int n = 1 + (p+1); eB = int(n); }
    int eC; { const int n = 1 + (p+1); eC = int(n); }

    int e[3] = { eA,eB,eC };
    int eFlatV; { const int n = 1 + (p); eFlatV = int(n); }
    int eFlat[3 / 3] = { eFlatV };

    int vA; { vA = data[pc.n[0]]; }
    int vB; { vB = data[pc.n[1]]; }
    int vC; { vC = data[pc.n[2]]; }
    int vFlatV; { vFlatV = dataFlat; }
    int vFlat[3 / 3] = { vFlatV};

    int v[3] = { vA,vB,vC };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<3 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out ivec3 data;
layout(location = 1) out ivec3 dataFlat;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = ivec3(int(n), int(2*n), int(4*n));
    dataFlat      = ivec3(int(n), int(2*n), int(4*n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) flat in ivec3 dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in ivec3 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = 2*y;
    const bool even = (p%2 == 0);

    ivec3 eA; { const int n = 1 + (p); eA = ivec3(int(n), int(2*n), int(4*n)); }
    ivec3 eB; { const int n = 1 + (p+1); eB = ivec3(int(n), int(2*n), int(4*n)); }
    ivec3 eC; { const int n = 1 + (p+1); eC = ivec3(int(n), int(2*n), int(4*n)); }

    int e[9] = { eA.x,eA.y,eA.z,eB.x,eB.y,eB.z,eC.x,eC.y,eC.z };
    ivec3 eFlatV; { const int n = 1 + (p); eFlatV = ivec3(int(n), int(2*n), int(4*n)); }
    int eFlat[9 / 3] = { eFlatV.x,eFlatV.y,eFlatV.z };

    ivec3 vA; { vA = data[pc.n[0]]; }
    ivec3 vB; { vB = data[pc.n[1]]; }
    ivec3 vC; { vC = data[pc.n[2]]; }
    ivec3 vFlatV; { vFlatV = dataFlat; }
    int vFlat[9 / 3] = { vFlatV.x,vFlatV.y,vFlatV.z};

    int v[9] = { vA.x,vA.y,vA.z,vB.x,vB.y,vB.z,vC.x,vC.y,vC.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<9 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uvec3 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = 2*y;
    const bool even = (p%2 == 0);

    uvec3 eA; { const int n = 1 + (p); eA = uvec3(uint(n), uint(2*n), uint(4*n)); }
    uvec3 eB; { const int n = 1 + (p+1); eB = uvec3(uint(n), uint(2*n), uint(4*n)); }
    uvec3 eC; { const int n = 1 + (p+1); eC = uvec3(uint(n), uint(2*n), uint(4*n)); }

    uint e[9] = { eA.x,eA.y,eA.z,eB.x,eB.y,eB.z,eC.x,eC.y,eC.z };

    uvec3 vA; { vA = data[pc.n[0]]; }
    uvec3 vB; { vB = data[pc.n[1]]; }
    uvec3 vC; { vC = data[pc.n[2]]; }

    uint v[9] = { vA.x,vA.y,vA.z,vB.x,vB.y,vB.z,vC.x,vC.y,vC.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {float q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(float(n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {float q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = 2*y;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (p); eA = DataStruct(float(n)); }
    DataStruct eB; { const int n = 1 + (p+1); eB = DataStruct(float(n)); }
    DataStruct eC; { const int n = 1 + (p+1); eC = DataStruct(float(n)); }

    float e[3] = { eA.q,eB.q,eC.q };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }

    float v[3] = { vA.q,vB.q,vC.q };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {float q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = 2*y;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (p); eA = DataStruct(float(n)); }
    DataStruct eB; { const int n = 1 + (p+1); eB = DataStruct(float(n)); }
    DataStruct eC; { const int n = 1 + (p+1); eC = DataStruct(float(n)); }

    float e[3] = { eA.q,eB.q,eC.q };
    DataStruct eFlatV; { const int n = 1 + (p); eFlatV = DataStruct(float(n)); }
    float eFlat[3 / 3] = { eFlatV.q };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    float vFlat[3 / 3] = { vFlatV.q};

    float v[3] = { vA.q,vB.q,vC.q };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<3 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {dvec2 q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(dvec2(double(n), double(2*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {dvec2 q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = 2*y;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (p); eA = DataStruct(dvec2(double(n), double(2*n))); }
    DataStruct eB; { const int n = 1 + (p+1); eB = DataStruct(dvec2(double(n), double(2*n))); }
    DataStruct eC; { const int n = 1 + (p+1); eC = DataStruct(dvec2(double(n), double(2*n))); }

    double e[6] = { eA.q.x,eA.q.y,eB.q.x,eB.q.y,eC.q.x,eC.q.y };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }

    double v[6] = { vA.q.x,vA.q.y,vB.q.x,vB.q.y,vC.q.x,vC.q.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {ivec2 q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = 2*y;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (p); eA = DataStruct(ivec2(int(n), int(2*n))); }
    DataStruct eB; { const int n = 1 + (p+1); eB = DataStruct(ivec2(int(n), int(2*n))); }
    DataStruct eC; { const int n = 1 + (p+1); eC = DataStruct(ivec2(int(n), int(2*n))); }

    int e[6] = { eA.q.x,eA.q.y,eB.q.x,eB.q.y,eC.q.x,eC.q.y };
    DataStruct eFlatV; { const int n = 1 + (p); eFlatV = DataStruct(ivec2(int(n), int(2*n))); }
    int eFlat[6 / 3] = { eFlatV.q.x,eFlatV.q.y };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    int vFlat[6 / 3] = { vFlatV.q.x,vFlatV.q.y};

    int v[6] = { vA.q.x,vA.q.y,vB.q.x,vB.q.y,vC.q.x,vC.q.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 2) flat in ivec3 dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in ivec3 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = 2*y;
    const bool even = (p%2 == 0);

    ivec3 eA[2]; { const int n = 1 + (p); eA = ivec3[2](ivec3(int(n), int(2*n), int(4*n)), int(3)*ivec3(int(n), int(2*n), int(4*n))); }
    ivec3 eB[2]; { const int n = 1 + (p+1); eB = ivec3[2](ivec3(int(n), int(2*n), int(4*n)), int(3)*ivec3(int(n), int(2*n), int(4*n))); }
    ivec3 eC[2]; { const int n = 1 + (p+1); eC = ivec3[2](ivec3(int(n), int(2*n), int(4*n)), int(3)*ivec3(int(n), int(2*n), int(4*n))); }

    int e[18] = { eA[0].x,eA[0].y,eA[0].z,eA[1].x,eA[1].y,eA[1].z,eB[0].x,eB[0].y,eB[0].z,eB[1].x,eB[1].y,eB[1].z,eC[0].x,eC[0].y,eC[0].z,eC[1].x,eC[1].y,eC[1].z };
    ivec3 eFlatV[2]; { const int n = 1 + (p); eFlatV = ivec3[2](ivec3(int(n), int(2*n), int(4*n)), int(3)*ivec3(int(n), int(2*n), int(4*n))); }
    int eFlat[18 / 3] = { eFlatV[0].x,eFlatV[0].y,eFlatV[0].z,eFlatV[1].x,eFlatV[1].y,eFlatV[1].z };

    ivec3 vA[2]; { vA = ivec3[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    ivec3 vB[2]; { vB = ivec3[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    ivec3 vC[2]; { vC = ivec3[2](data[pc.n[2]][0],data[pc.n[2]][1]); }
    ivec3 vFlatV[2]; { vFlatV = ivec3[2](dataFlat[0],dataFlat[1]); }
    int vFlat[18 / 3] = { vFlatV[0].x,vFlatV[0].y,vFlatV[0].z,vFlatV[1].x,vFlatV[1].y,vFlatV[1].z};

    int v[18] = { vA[0].x,vA[0].y,vA[0].z,vA[1].x,vA[1].y,vA[1].z,vB[0].x,vB[0].y,vB[0].z,vB[1].x,vB[1].y,vB[1].z,vC[0].x,vC[0].y,vC[0].z,vC[1].x,vC[1].y,vC[1].z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<18; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<18 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 2) flat in uint dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uint data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = 2*y;
    const bool even = (p%2 == 0);

    uint eA[2]; { const int n = 1 + (p); eA = uint[2](uint(n), uint(3)*uint(n)); }
    uint eB[2]; { const int n = 1 + (p+1); eB = uint[2](uint(n), uint(3)*uint(n)); }
    uint eC[2]; { const int n = 1 + (p+1); eC = uint[2](uint(n), uint(3)*uint(n)); }

    uint e[6] = { eA[0],eA[1],eB[0],eB[1],eC[0],eC[1] };
    uint eFlatV[2]; { const int n = 1 + (p); eFlatV = uint[2](uint(n), uint(3)*uint(n)); }
    uint eFlat[6 / 3] = { eFlatV[0],eFlatV[1] };

    uint vA[2]; { vA = uint[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    uint vB[2]; { vB = uint[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    uint vC[2]; { vC = uint[2](data[pc.n[2]][0],data[pc.n[2]][1]); }
    uint vFlatV[2]; { vFlatV = uint[2](dataFlat[0],dataFlat[1]); }
    uint vFlat[6 / 3] = { vFlatV[0],vFlatV[1]};

    uint v[6] = { vA[0],vA[1],vB[0],vB[1],vC[0],vC[1] };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out uvec2 data[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = uvec2[2](uvec2(uint(n), uint(2*n)), uint(3)*uvec2(uint(n), uint(2*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uvec2 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = 2*y;
    const bool even = (p%2 == 0);

    uvec2 eA[2]; { const int n = 1 + (p); eA = uvec2[2](uvec2(uint(n), uint(2*n)), uint(3)*uvec2(uint(n), uint(2*n))); }
    uvec2 eB[2]; { const int n = 1 + (p+1); eB = uvec2[2](uvec2(uint(n), uint(2*n)), uint(3)*uvec2(uint(n), uint(2*n))); }
    uvec2 eC[2]; { const int n = 1 + (p+1); eC = uvec2[2](uvec2(uint(n), uint(2*n)), uint(3)*uvec2(uint(n), uint(2*n))); }

    uint e[12] = { eA[0].x,eA[0].y,eA[1].x,eA[1].y,eB[0].x,eB[0].y,eB[1].x,eB[1].y,eC[0].x,eC[0].y,eC[1].x,eC[1].y };

    uvec2 vA[2]; { vA = uvec2[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    uvec2 vB[2]; { vB = uvec2[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    uvec2 vC[2]; { vC = uvec2[2](data[pc.n[2]][0],data[pc.n[2]][1]); }

    uint v[12] = { vA[0].x,vA[0].y,vA[1].x,vA[1].y,vB[0].x,vB[0].y,vB[1].x,vB[1].y,vC[0].x,vC[0].y,vC[1].x,vC[1].y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(triangles) out;
layout(max_vertices=6, max_primitives=6) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[6];
} pvd;
layout (location=0) out float data[];
layout(location = 1) out float dataInterp[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 6;
    uint maxPrimitive = 2;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    const uvec3 indices[2] = uvec3[](
        uvec3(0, 1, 2),
        uvec3(3, 4, 5)
    );
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = float(n);
    dataInterp[vertex]    = float(n);
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveTriangleIndicesEXT[primitive] = indices[primitive];
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) in float dataIntrp;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in float data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    float eA; { const int n = 1 + (3*p); eA = float(n); }
    float eB; { const int n = 1 + (3*p+1); eB = float(n); }
    float eC; { const int n = 1 + (3*p+2); eC = float(n); }

    float e[3] = { eA,eB,eC };
    float eIntrpV; {eIntrpV = float(eA * gl_BaryCoordEXT.x + eB * gl_BaryCoordEXT.y + eC * gl_BaryCoordEXT.z); }
    float eIntrp[3 / 3] = { eIntrpV };

    float vA; { vA = data[pc.n[0]]; }
    float vB; { vB = data[pc.n[1]]; }
    float vC; { vC = data[pc.n[2]]; }
    float vIntrpV; { vIntrpV = dataIntrp; }
    float vIntrp[3 / 3] = { vIntrpV };

    float v[3] = { vA,vB,vC };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<3 / 3; i++)
        if (abs(eIntrp[i] - vIntrp[i]) < 0.001)
            mask.y = mask.y | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec4 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    vec4 eA; { const int n = 1 + (3*p); eA = vec4(float(n), float(2*n), float(4*n), float(8*n)); }
    vec4 eB; { const int n = 1 + (3*p+1); eB = vec4(float(n), float(2*n), float(4*n), float(8*n)); }
    vec4 eC; { const int n = 1 + (3*p+2); eC = vec4(float(n), float(2*n), float(4*n), float(8*n)); }

    float e[12] = { eA.x,eA.y,eA.z,eA.w,eB.x,eB.y,eB.z,eB.w,eC.x,eC.y,eC.z,eC.w };

    vec4 vA; { vA = data[pc.n[0]]; }
    vec4 vB; { vB = data[pc.n[1]]; }
    vec4 vC; { vC = data[pc.n[2]]; }

    float v[12] = { vA.x,vA.y,vA.z,vA.w,vB.x,vB.y,vB.z,vB.w,vC.x,vC.y,vC.z,vC.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec3 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    dvec3 eA; { const int n = 1 + (3*p); eA = dvec3(double(n), double(2*n), double(4*n)); }
    dvec3 eB; { const int n = 1 + (3*p+1); eB = dvec3(double(n), double(2*n), double(4*n)); }
    dvec3 eC; { const int n = 1 + (3*p+2); eC = dvec3(double(n), double(2*n), double(4*n)); }

    double e[9] = { eA.x,eA.y,eA.z,eB.x,eB.y,eB.z,eC.x,eC.y,eC.z };

    dvec3 vA; { vA = data[pc.n[0]]; }
    dvec3 vB; { vB = data[pc.n[1]]; }
    dvec3 vC; { vC = data[pc.n[2]]; }

    double v[9] = { vA.x,vA.y,vA.z,vB.x,vB.y,vB.z,vC.x,vC.y,vC.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 2) flat in dvec4 dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec4 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    dvec4 eA; { const int n = 1 + (3*p); eA = dvec4(double(n), double(2*n), double(4*n), double(8*n)); }
    dvec4 eB; { const int n = 1 + (3*p+1); eB = dvec4(double(n), double(2*n), double(4*n), double(8*n)); }
    dvec4 eC; { const int n = 1 + (3*p+2); eC = dvec4(double(n), double(2*n), double(4*n), double(8*n)); }

    double e[12] = { eA.x,eA.y,eA.z,eA.w,eB.x,eB.y,eB.z,eB.w,eC.x,eC.y,eC.z,eC.w };
    dvec4 eFlatV; { const int n = 1 + (3*p); eFlatV = dvec4(double(n), double(2*n), double(4*n), double(8*n)); }
    double eFlat[12 / 3] = { eFlatV.x,eFlatV.y,eFlatV.z,eFlatV.w };

    dvec4 vA; { vA = data[pc.n[0]]; }
    dvec4 vB; { vB = data[pc.n[1]]; }
    dvec4 vC; { vC = data[pc.n[2]]; }
    dvec4 vFlatV; { vFlatV = dataFlat; }
    double vFlat[12 / 3] = { vFlatV.x,vFlatV.y,vFlatV.z,vFlatV.w};

    double v[12] = { vA.x,vA.y,vA.z,vA.w,vB.x,vB.y,vB.z,vB.w,vC.x,vC.y,vC.z,vC.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<12 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(triangles) out;
layout(max_vertices=6, max_primitives=6) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[6];
} pvd;
layout (location=0) out ivec3 data[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 6;
    uint maxPrimitive = 2;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    const uvec3 indices[2] = uvec3[](
        uvec3(0, 1, 2),
        uvec3(3, 4, 5)
    );
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = ivec3(int(n), int(2*n), int(4*n));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveTriangleIndicesEXT[primitive] = indices[primitive];
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in ivec3 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    ivec3 eA; { const int n = 1 + (3*p); eA = ivec3(int(n), int(2*n), int(4*n)); }
    ivec3 eB; { const int n = 1 + (3*p+1); eB = ivec3(int(n), int(2*n), int(4*n)); }
    ivec3 eC; { const int n = 1 + (3*p+2); eC = ivec3(int(n), int(2*n), int(4*n)); }

    int e[9] = { eA.x,eA.y,eA.z,eB.x,eB.y,eB.z,eC.x,eC.y,eC.z };

    ivec3 vA; { vA = data[pc.n[0]]; }
    ivec3 vB; { vB = data[pc.n[1]]; }
    ivec3 vC; { vC = data[pc.n[2]]; }

    int v[9] = { vA.x,vA.y,vA.z,vB.x,vB.y,vB.z,vC.x,vC.y,vC.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) flat in uvec2 dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uvec2 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    uvec2 eA; { const int n = 1 + (3*p); eA = uvec2(uint(n), uint(2*n)); }
    uvec2 eB; { const int n = 1 + (3*p+1); eB = uvec2(uint(n), uint(2*n)); }
    uvec2 eC; { const int n = 1 + (3*p+2); eC = uvec2(uint(n), uint(2*n)); }

    uint e[6] = { eA.x,eA.y,eB.x,eB.y,eC.x,eC.y };
    uvec2 eFlatV; { const int n = 1 + (3*p); eFlatV = uvec2(uint(n), uint(2*n)); }
    uint eFlat[6 / 3] = { eFlatV.x,eFlatV.y };

    uvec2 vA; { vA = data[pc.n[0]]; }
    uvec2 vB; { vB = data[pc.n[1]]; }
    uvec2 vC; { vC = data[pc.n[2]]; }
    uvec2 vFlatV; { vFlatV = dataFlat; }
    uint vFlat[6 / 3] = { vFlatV.x,vFlatV.y};

    uint v[6] = { vA.x,vA.y,vB.x,vB.y,vC.x,vC.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uvec4 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    uvec4 eA; { const int n = 1 + (3*p); eA = uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)); }
    uvec4 eB; { const int n = 1 + (3*p+1); eB = uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)); }
    uvec4 eC; { const int n = 1 + (3*p+2); eC = uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)); }

    uint e[12] = { eA.x,eA.y,eA.z,eA.w,eB.x,eB.y,eB.z,eB.w,eC.x,eC.y,eC.z,eC.w };

    uvec4 vA; { vA = data[pc.n[0]]; }
    uvec4 vB; { vB = data[pc.n[1]]; }
    uvec4 vC; { vC = data[pc.n[2]]; }

    uint v[12] = { vA.x,vA.y,vA.z,vA.w,vB.x,vB.y,vB.z,vB.w,vC.x,vC.y,vC.z,vC.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(triangles) out;
layout(max_vertices=6, max_primitives=6) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[6];
} pvd;
layout (location=0) out uvec4 data[];
layout(location = 1) out uvec4 dataFlat[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 6;
    uint maxPrimitive = 2;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    const uvec3 indices[2] = uvec3[](
        uvec3(0, 1, 2),
        uvec3(3, 4, 5)
    );
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n));
    dataFlat[vertex]      = uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveTriangleIndicesEXT[primitive] = indices[primitive];
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) flat in uvec4 dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uvec4 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    uvec4 eA; { const int n = 1 + (3*p); eA = uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)); }
    uvec4 eB; { const int n = 1 + (3*p+1); eB = uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)); }
    uvec4 eC; { const int n = 1 + (3*p+2); eC = uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)); }

    uint e[12] = { eA.x,eA.y,eA.z,eA.w,eB.x,eB.y,eB.z,eB.w,eC.x,eC.y,eC.z,eC.w };
    uvec4 eFlatV; { const int n = 1 + (3*p); eFlatV = uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)); }
    uint eFlat[12 / 3] = { eFlatV.x,eFlatV.y,eFlatV.z,eFlatV.w };

    uvec4 vA; { vA = data[pc.n[0]]; }
    uvec4 vB; { vB = data[pc.n[1]]; }
    uvec4 vC; { vC = data[pc.n[2]]; }
    uvec4 vFlatV; { vFlatV = dataFlat; }
    uint vFlat[12 / 3] = { vFlatV.x,vFlatV.y,vFlatV.z,vFlatV.w};

    uint v[12] = { vA.x,vA.y,vA.z,vA.w,vB.x,vB.y,vB.z,vB.w,vC.x,vC.y,vC.z,vC.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<12 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec3 q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(vec3(float(n), float(2*n), float(4*n))); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(vec3(float(n), float(2*n), float(4*n))); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(vec3(float(n), float(2*n), float(4*n))); }

    float e[9] = { eA.q.x,eA.q.y,eA.q.z,eB.q.x,eB.q.y,eB.q.z,eC.q.x,eC.q.y,eC.q.z };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }

    float v[9] = { vA.q.x,vA.q.y,vA.q.z,vB.q.x,vB.q.y,vB.q.z,vC.q.x,vC.q.y,vC.q.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable

struct DataStruct {double q;};
layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(triangles) out;
layout(max_vertices=6, max_primitives=6) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[6];
} pvd;
layout (location=0) out DataStruct data[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 6;
    uint maxPrimitive = 2;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    const uvec3 indices[2] = uvec3[](
        uvec3(0, 1, 2),
        uvec3(3, 4, 5)
    );
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = DataStruct(double(n));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveTriangleIndicesEXT[primitive] = indices[primitive];
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {double q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(double(n)); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(double(n)); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(double(n)); }

    double e[3] = { eA.q,eB.q,eC.q };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }

    double v[3] = { vA.q,vB.q,vC.q };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable

struct DataStruct {dvec2 q;};
layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(triangles) out;
layout(max_vertices=6, max_primitives=6) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[6];
} pvd;
layout (location=0) out DataStruct data[];
layout(location = 2) out DataStruct dataFlat[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 6;
    uint maxPrimitive = 2;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    const uvec3 indices[2] = uvec3[](
        uvec3(0, 1, 2),
        uvec3(3, 4, 5)
    );
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = DataStruct(dvec2(double(n), double(2*n)));
    dataFlat[vertex]      = DataStruct(dvec2(double(n), double(2*n)));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveTriangleIndicesEXT[primitive] = indices[primitive];
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {dvec2 q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 2) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(dvec2(double(n), double(2*n))); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(dvec2(double(n), double(2*n))); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(dvec2(double(n), double(2*n))); }

    double e[6] = { eA.q.x,eA.q.y,eB.q.x,eB.q.y,eC.q.x,eC.q.y };
    DataStruct eFlatV; { const int n = 1 + (3*p); eFlatV = DataStruct(dvec2(double(n), double(2*n))); }
    double eFlat[6 / 3] = { eFlatV.q.x,eFlatV.q.y };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    double vFlat[6 / 3] = { vFlatV.q.x,vFlatV.q.y};

    double v[6] = { vA.q.x,vA.q.y,vB.q.x,vB.q.y,vC.q.x,vC.q.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {int q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(int(n)); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(int(n)); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(int(n)); }

    int e[3] = { eA.q,eB.q,eC.q };
    DataStruct eFlatV; { const int n = 1 + (3*p); eFlatV = DataStruct(int(n)); }
    int eFlat[3 / 3] = { eFlatV.q };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    int vFlat[3 / 3] = { vFlatV.q};

    int v[3] = { vA.q,vB.q,vC.q };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<3 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {ivec4 q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(ivec4(int(n), int(2*n), int(4*n), int(8*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {ivec4 q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(ivec4(int(n), int(2*n), int(4*n), int(8*n))); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(ivec4(int(n), int(2*n), int(4*n), int(8*n))); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(ivec4(int(n), int(2*n), int(4*n), int(8*n))); }

    int e[12] = { eA.q.x,eA.q.y,eA.q.z,eA.q.w,eB.q.x,eB.q.y,eB.q.z,eB.q.w,eC.q.x,eC.q.y,eC.q.z,eC.q.w };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }

    int v[12] = { vA.q.x,vA.q.y,vA.q.z,vA.q.w,vB.q.x,vB.q.y,vB.q.z,vB.q.w,vC.q.x,vC.q.y,vC.q.z,vC.q.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable

struct DataStruct {uvec2 q;};
layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(triangles) out;
layout(max_vertices=6, max_primitives=6) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[6];
} pvd;
layout (location=0) out DataStruct data[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 6;
    uint maxPrimitive = 2;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    const uvec3 indices[2] = uvec3[](
        uvec3(0, 1, 2),
        uvec3(3, 4, 5)
    );
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = DataStruct(uvec2(uint(n), uint(2*n)));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveTriangleIndicesEXT[primitive] = indices[primitive];
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {uvec2 q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(uvec2(uint(n), uint(2*n))); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(uvec2(uint(n), uint(2*n))); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(uvec2(uint(n), uint(2*n))); }

    uint e[6] = { eA.q.x,eA.q.y,eB.q.x,eB.q.y,eC.q.x,eC.q.y };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }

    uint v[6] = { vA.q.x,vA.q.y,vB.q.x,vB.q.y,vC.q.x,vC.q.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(triangles) out;
layout(max_vertices=6, max_primitives=6) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[6];
} pvd;
layout (location=0) out float data[][2];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 6;
    uint maxPrimitive = 2;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    const uvec3 indices[2] = uvec3[](
        uvec3(0, 1, 2),
        uvec3(3, 4, 5)
    );
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = float[2](float(n), float(3)*float(n));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveTriangleIndicesEXT[primitive] = indices[primitive];
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in float data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    float eA[2]; { const int n = 1 + (3*p); eA = float[2](float(n), float(3)*float(n)); }
    float eB[2]; { const int n = 1 + (3*p+1); eB = float[2](float(n), float(3)*float(n)); }
    float eC[2]; { const int n = 1 + (3*p+2); eC = float[2](float(n), float(3)*float(n)); }

    float e[6] = { eA[0],eA[1],eB[0],eB[1],eC[0],eC[1] };

    float vA[2]; { vA = float[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    float vB[2]; { vB = float[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    float vC[2]; { vC = float[2](data[pc.n[2]][0],data[pc.n[2]][1]); }

    float v[6] = { vA[0],vA[1],vB[0],vB[1],vC[0],vC[1] };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(triangles) out;
layout(max_vertices=6, max_primitives=6) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[6];
} pvd;
layout (location=0) out float data[][2];
layout(location = 2) out float dataFlat[][2];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 6;
    uint maxPrimitive = 2;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    const uvec3 indices[2] = uvec3[](
        uvec3(0, 1, 2),
        uvec3(3, 4, 5)
    );
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = float[2](float(n), float(3)*float(n));
    dataFlat[vertex]      = float[2](float(n), float(3)*float(n));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveTriangleIndicesEXT[primitive] = indices[primitive];
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 2) flat in float dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in float data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    float eA[2]; { const int n = 1 + (3*p); eA = float[2](float(n), float(3)*float(n)); }
    float eB[2]; { const int n = 1 + (3*p+1); eB = float[2](float(n), float(3)*float(n)); }
    float eC[2]; { const int n = 1 + (3*p+2); eC = float[2](float(n), float(3)*float(n)); }

    float e[6] = { eA[0],eA[1],eB[0],eB[1],eC[0],eC[1] };
    float eFlatV[2]; { const int n = 1 + (3*p); eFlatV = float[2](float(n), float(3)*float(n)); }
    float eFlat[6 / 3] = { eFlatV[0],eFlatV[1] };

    float vA[2]; { vA = float[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    float vB[2]; { vB = float[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    float vC[2]; { vC = float[2](data[pc.n[2]][0],data[pc.n[2]][1]); }
    float vFlatV[2]; { vFlatV = float[2](dataFlat[0],dataFlat[1]); }
    float vFlat[6 / 3] = { vFlatV[0],vFlatV[1]};

    float v[6] = { vA[0],vA[1],vB[0],vB[1],vC[0],vC[1] };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(triangles) out;
layout(max_vertices=6, max_primitives=6) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[6];
} pvd;
layout (location=0) out vec2 data[][2];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 6;
    uint maxPrimitive = 2;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    const uvec3 indices[2] = uvec3[](
        uvec3(0, 1, 2),
        uvec3(3, 4, 5)
    );
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = vec2[2](vec2(float(n), float(2*n)), float(3)*vec2(float(n), float(2*n)));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveTriangleIndicesEXT[primitive] = indices[primitive];
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec2 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    vec2 eA[2]; { const int n = 1 + (3*p); eA = vec2[2](vec2(float(n), float(2*n)), float(3)*vec2(float(n), float(2*n))); }
    vec2 eB[2]; { const int n = 1 + (3*p+1); eB = vec2[2](vec2(float(n), float(2*n)), float(3)*vec2(float(n), float(2*n))); }
    vec2 eC[2]; { const int n = 1 + (3*p+2); eC = vec2[2](vec2(float(n), float(2*n)), float(3)*vec2(float(n), float(2*n))); }

    float e[12] = { eA[0].x,eA[0].y,eA[1].x,eA[1].y,eB[0].x,eB[0].y,eB[1].x,eB[1].y,eC[0].x,eC[0].y,eC[1].x,eC[1].y };

    vec2 vA[2]; { vA = vec2[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    vec2 vB[2]; { vB = vec2[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    vec2 vC[2]; { vC = vec2[2](data[pc.n[2]][0],data[pc.n[2]][1]); }

    float v[12] = { vA[0].x,vA[0].y,vA[1].x,vA[1].y,vB[0].x,vB[0].y,vB[1].x,vB[1].y,vC[0].x,vC[0].y,vC[1].x,vC[1].y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(triangles) out;
layout(max_vertices=6, max_primitives=6) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[6];
} pvd;
layout (location=0) out vec4 data[][2];
layout(location = 2) out vec4 dataInterp[][2];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 6;
    uint maxPrimitive = 2;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    const uvec3 indices[2] = uvec3[](
        uvec3(0, 1, 2),
        uvec3(3, 4, 5)
    );
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n)));
    dataInterp[vertex]    = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n)));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveTriangleIndicesEXT[primitive] = indices[primitive];
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 2) in vec4 dataIntrp[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec4 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    vec4 eA[2]; { const int n = 1 + (3*p); eA = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    vec4 eB[2]; { const int n = 1 + (3*p+1); eB = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    vec4 eC[2]; { const int n = 1 + (3*p+2); eC = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n))); }

    float e[24] = { eA[0].x,eA[0].y,eA[0].z,eA[0].w,eA[1].x,eA[1].y,eA[1].z,eA[1].w,eB[0].x,eB[0].y,eB[0].z,eB[0].w,eB[1].x,eB[1].y,eB[1].z,eB[1].w,eC[0].x,eC[0].y,eC[0].z,eC[0].w,eC[1].x,eC[1].y,eC[1].z,eC[1].w };
    vec4 eIntrpV[2]; {eIntrpV = vec4[2](eA[0] * gl_BaryCoordEXT.x + eB[0] * gl_BaryCoordEXT.y + eC[0] * gl_BaryCoordEXT.z, eA[1] * gl_BaryCoordEXT.x + eB[1] * gl_BaryCoordEXT.y + eC[1] * gl_BaryCoordEXT.z); }
    float eIntrp[24 / 3] = { eIntrpV[0].x,eIntrpV[0].y,eIntrpV[0].z,eIntrpV[0].w,eIntrpV[1].x,eIntrpV[1].y,eIntrpV[1].z,eIntrpV[1].w };

    vec4 vA[2]; { vA = vec4[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    vec4 vB[2]; { vB = vec4[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    vec4 vC[2]; { vC = vec4[2](data[pc.n[2]][0],data[pc.n[2]][1]); }
    vec4 vIntrpV[2]; { vIntrpV = vec4[2](dataIntrp[0],dataIntrp[1]); }
    float vIntrp[24 / 3] = { vIntrpV[0].x,vIntrpV[0].y,vIntrpV[0].z,vIntrpV[0].w,vIntrpV[1].x,vIntrpV[1].y,vIntrpV[1].z,vIntrpV[1].w };

    float v[24] = { vA[0].x,vA[0].y,vA[0].z,vA[0].w,vA[1].x,vA[1].y,vA[1].z,vA[1].w,vB[0].x,vB[0].y,vB[0].z,vB[0].w,vB[1].x,vB[1].y,vB[1].z,vB[1].w,vC[0].x,vC[0].y,vC[0].z,vC[0].w,vC[1].x,vC[1].y,vC[1].z,vC[1].w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<24; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<24 / 3; i++)
        if (abs(eIntrp[i] - vIntrp[i]) < 0.001)
            mask.y = mask.y | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(triangles) out;
layout(max_vertices=6, max_primitives=6) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[6];
} pvd;
layout (location=0) out dvec3 data[][2];
layout(location = 4) out dvec3 dataFlat[][2];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 6;
    uint maxPrimitive = 2;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    const uvec3 indices[2] = uvec3[](
        uvec3(0, 1, 2),
        uvec3(3, 4, 5)
    );
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n)));
    dataFlat[vertex]      = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n)));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveTriangleIndicesEXT[primitive] = indices[primitive];
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 4) flat in dvec3 dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec3 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    dvec3 eA[2]; { const int n = 1 + (3*p); eA = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n))); }
    dvec3 eB[2]; { const int n = 1 + (3*p+1); eB = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n))); }
    dvec3 eC[2]; { const int n = 1 + (3*p+2); eC = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n))); }

    double e[18] = { eA[0].x,eA[0].y,eA[0].z,eA[1].x,eA[1].y,eA[1].z,eB[0].x,eB[0].y,eB[0].z,eB[1].x,eB[1].y,eB[1].z,eC[0].x,eC[0].y,eC[0].z,eC[1].x,eC[1].y,eC[1].z };
    dvec3 eFlatV[2]; { const int n = 1 + (3*p); eFlatV = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n))); }
    double eFlat[18 / 3] = { eFlatV[0].x,eFlatV[0].y,eFlatV[0].z,eFlatV[1].x,eFlatV[1].y,eFlatV[1].z };

    dvec3 vA[2]; { vA = dvec3[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    dvec3 vB[2]; { vB = dvec3[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    dvec3 vC[2]; { vC = dvec3[2](data[pc.n[2]][0],data[pc.n[2]][1]); }
    dvec3 vFlatV[2]; { vFlatV = dvec3[2](dataFlat[0],dataFlat[1]); }
    double vFlat[18 / 3] = { vFlatV[0].x,vFlatV[0].y,vFlatV[0].z,vFlatV[1].x,vFlatV[1].y,vFlatV[1].z};

    double v[18] = { vA[0].x,vA[0].y,vA[0].z,vA[1].x,vA[1].y,vA[1].z,vB[0].x,vB[0].y,vB[0].z,vB[1].x,vB[1].y,vB[1].z,vC[0].x,vC[0].y,vC[0].z,vC[1].x,vC[1].y,vC[1].z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<18; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<18 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out ivec3 data[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = ivec3[2](ivec3(int(n), int(2*n), int(4*n)), int(3)*ivec3(int(n), int(2*n), int(4*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in ivec3 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    ivec3 eA[2]; { const int n = 1 + (3*p); eA = ivec3[2](ivec3(int(n), int(2*n), int(4*n)), int(3)*ivec3(int(n), int(2*n), int(4*n))); }
    ivec3 eB[2]; { const int n = 1 + (3*p+1); eB = ivec3[2](ivec3(int(n), int(2*n), int(4*n)), int(3)*ivec3(int(n), int(2*n), int(4*n))); }
    ivec3 eC[2]; { const int n = 1 + (3*p+2); eC = ivec3[2](ivec3(int(n), int(2*n), int(4*n)), int(3)*ivec3(int(n), int(2*n), int(4*n))); }

    int e[18] = { eA[0].x,eA[0].y,eA[0].z,eA[1].x,eA[1].y,eA[1].z,eB[0].x,eB[0].y,eB[0].z,eB[1].x,eB[1].y,eB[1].z,eC[0].x,eC[0].y,eC[0].z,eC[1].x,eC[1].y,eC[1].z };

    ivec3 vA[2]; { vA = ivec3[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    ivec3 vB[2]; { vB = ivec3[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    ivec3 vC[2]; { vC = ivec3[2](data[pc.n[2]][0],data[pc.n[2]][1]); }

    int v[18] = { vA[0].x,vA[0].y,vA[0].z,vA[1].x,vA[1].y,vA[1].z,vB[0].x,vB[0].y,vB[0].z,vB[1].x,vB[1].y,vB[1].z,vC[0].x,vC[0].y,vC[0].z,vC[1].x,vC[1].y,vC[1].z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<18; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(triangles) out;
layout(max_vertices=6, max_primitives=6) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[6];
} pvd;
layout (location=0) out ivec4 data[][2];
layout(location = 2) out ivec4 dataFlat[][2];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 6;
    uint maxPrimitive = 2;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    const uvec3 indices[2] = uvec3[](
        uvec3(0, 1, 2),
        uvec3(3, 4, 5)
    );
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n)));
    dataFlat[vertex]      = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n)));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveTriangleIndicesEXT[primitive] = indices[primitive];
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 2) flat in ivec4 dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in ivec4 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    ivec4 eA[2]; { const int n = 1 + (3*p); eA = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n))); }
    ivec4 eB[2]; { const int n = 1 + (3*p+1); eB = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n))); }
    ivec4 eC[2]; { const int n = 1 + (3*p+2); eC = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n))); }

    int e[24] = { eA[0].x,eA[0].y,eA[0].z,eA[0].w,eA[1].x,eA[1].y,eA[1].z,eA[1].w,eB[0].x,eB[0].y,eB[0].z,eB[0].w,eB[1].x,eB[1].y,eB[1].z,eB[1].w,eC[0].x,eC[0].y,eC[0].z,eC[0].w,eC[1].x,eC[1].y,eC[1].z,eC[1].w };
    ivec4 eFlatV[2]; { const int n = 1 + (3*p); eFlatV = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n))); }
    int eFlat[24 / 3] = { eFlatV[0].x,eFlatV[0].y,eFlatV[0].z,eFlatV[0].w,eFlatV[1].x,eFlatV[1].y,eFlatV[1].z,eFlatV[1].w };

    ivec4 vA[2]; { vA = ivec4[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    ivec4 vB[2]; { vB = ivec4[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    ivec4 vC[2]; { vC = ivec4[2](data[pc.n[2]][0],data[pc.n[2]][1]); }
    ivec4 vFlatV[2]; { vFlatV = ivec4[2](dataFlat[0],dataFlat[1]); }
    int vFlat[24 / 3] = { vFlatV[0].x,vFlatV[0].y,vFlatV[0].z,vFlatV[0].w,vFlatV[1].x,vFlatV[1].y,vFlatV[1].z,vFlatV[1].w};

    int v[24] = { vA[0].x,vA[0].y,vA[0].z,vA[0].w,vA[1].x,vA[1].y,vA[1].z,vA[1].w,vB[0].x,vB[0].y,vB[0].z,vB[0].w,vB[1].x,vB[1].y,vB[1].z,vB[1].w,vC[0].x,vC[0].y,vC[0].z,vC[0].w,vC[1].x,vC[1].y,vC[1].z,vC[1].w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<24; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<24 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uint data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    uint eA[2]; { const int n = 1 + (3*p); eA = uint[2](uint(n), uint(3)*uint(n)); }
    uint eB[2]; { const int n = 1 + (3*p+1); eB = uint[2](uint(n), uint(3)*uint(n)); }
    uint eC[2]; { const int n = 1 + (3*p+2); eC = uint[2](uint(n), uint(3)*uint(n)); }

    uint e[6] = { eA[0],eA[1],eB[0],eB[1],eC[0],eC[1] };

    uint vA[2]; { vA = uint[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    uint vB[2]; { vB = uint[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    uint vC[2]; { vC = uint[2](data[pc.n[2]][0],data[pc.n[2]][1]); }

    uint v[6] = { vA[0],vA[1],vB[0],vB[1],vC[0],vC[1] };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 2) flat in uint dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uint data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    uint eA[2]; { const int n = 1 + (3*p); eA = uint[2](uint(n), uint(3)*uint(n)); }
    uint eB[2]; { const int n = 1 + (3*p+1); eB = uint[2](uint(n), uint(3)*uint(n)); }
    uint eC[2]; { const int n = 1 + (3*p+2); eC = uint[2](uint(n), uint(3)*uint(n)); }

    uint e[6] = { eA[0],eA[1],eB[0],eB[1],eC[0],eC[1] };
    uint eFlatV[2]; { const int n = 1 + (3*p); eFlatV = uint[2](uint(n), uint(3)*uint(n)); }
    uint eFlat[6 / 3] = { eFlatV[0],eFlatV[1] };

    uint vA[2]; { vA = uint[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    uint vB[2]; { vB = uint[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    uint vC[2]; { vC = uint[2](data[pc.n[2]][0],data[pc.n[2]][1]); }
    uint vFlatV[2]; { vFlatV = uint[2](dataFlat[0],dataFlat[1]); }
    uint vFlat[6 / 3] = { vFlatV[0],vFlatV[1]};

    uint v[6] = { vA[0],vA[1],vB[0],vB[1],vC[0],vC[1] };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(triangles) out;
layout(max_vertices=6, max_primitives=6) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[6];
} pvd;
layout (location=0) out uvec3 data[][2];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 6;
    uint maxPrimitive = 2;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    const uvec3 indices[2] = uvec3[](
        uvec3(0, 1, 2),
        uvec3(3, 4, 5)
    );
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = uvec3[2](uvec3(uint(n), uint(2*n), uint(4*n)), uint(3)*uvec3(uint(n), uint(2*n), uint(4*n)));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveTriangleIndicesEXT[primitive] = indices[primitive];
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uvec3 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    uvec3 eA[2]; { const int n = 1 + (3*p); eA = uvec3[2](uvec3(uint(n), uint(2*n), uint(4*n)), uint(3)*uvec3(uint(n), uint(2*n), uint(4*n))); }
    uvec3 eB[2]; { const int n = 1 + (3*p+1); eB = uvec3[2](uvec3(uint(n), uint(2*n), uint(4*n)), uint(3)*uvec3(uint(n), uint(2*n), uint(4*n))); }
    uvec3 eC[2]; { const int n = 1 + (3*p+2); eC = uvec3[2](uvec3(uint(n), uint(2*n), uint(4*n)), uint(3)*uvec3(uint(n), uint(2*n), uint(4*n))); }

    uint e[18] = { eA[0].x,eA[0].y,eA[0].z,eA[1].x,eA[1].y,eA[1].z,eB[0].x,eB[0].y,eB[0].z,eB[1].x,eB[1].y,eB[1].z,eC[0].x,eC[0].y,eC[0].z,eC[1].x,eC[1].y,eC[1].z };

    uvec3 vA[2]; { vA = uvec3[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    uvec3 vB[2]; { vB = uvec3[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    uvec3 vC[2]; { vC = uvec3[2](data[pc.n[2]][0],data[pc.n[2]][1]); }

    uint v[18] = { vA[0].x,vA[0].y,vA[0].z,vA[1].x,vA[1].y,vA[1].z,vB[0].x,vB[0].y,vB[0].z,vB[1].x,vB[1].y,vB[1].z,vC[0].x,vC[0].y,vC[0].z,vC[1].x,vC[1].y,vC[1].z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<18; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in float data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ((x - 2) * 2 < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    float eA; { const int n = 1 + (3*p); eA = float(n); }
    float eB; { const int n = 1 + (3*p+1); eB = float(n); }
    float eC; { const int n = 1 + (3*p+2); eC = float(n); }

    float e[3] = { eA,eB,eC };

    float vA; { vA = data[pc.n[0]]; }
    float vB; { vB = data[pc.n[1]]; }
    float vC; { vC = data[pc.n[2]]; }

    float v[3] = { vA,vB,vC };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) in float dataIntrp;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in float data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ((x - 2) * 2 < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    float eA; { const int n = 1 + (3*p); eA = float(n); }
    float eB; { const int n = 1 + (3*p+1); eB = float(n); }
    float eC; { const int n = 1 + (3*p+2); eC = float(n); }

    float e[3] = { eA,eB,eC };
    float eIntrpV; {eIntrpV = float(eA * gl_BaryCoordEXT.x + eB * gl_BaryCoordEXT.y + eC * gl_BaryCoordEXT.z); }
    float eIntrp[3 / 3] = { eIntrpV };

    float vA; { vA = data[pc.n[0]]; }
    float vB; { vB = data[pc.n[1]]; }
    float vC; { vC = data[pc.n[2]]; }
    float vIntrpV; { vIntrpV = dataIntrp; }
    float vIntrp[3 / 3] = { vIntrpV };

    float v[3] = { vA,vB,vC };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<3 / 3; i++)
        if (abs(eIntrp[i] - vIntrp[i]) < 0.001)
            mask.y = mask.y | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec3 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ((x - 2) * 2 < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    vec3 eA; { const int n = 1 + (3*p); eA = vec3(float(n), float(2*n), float(4*n)); }
    vec3 eB; { const int n = 1 + (3*p+1); eB = vec3(float(n), float(2*n), float(4*n)); }
    vec3 eC; { const int n = 1 + (3*p+2); eC = vec3(float(n), float(2*n), float(4*n)); }

    float e[9] = { eA.x,eA.y,eA.z,eB.x,eB.y,eB.z,eC.x,eC.y,eC.z };

    vec3 vA; { vA = data[pc.n[0]]; }
    vec3 vB; { vB = data[pc.n[1]]; }
    vec3 vC; { vC = data[pc.n[2]]; }

    float v[9] = { vA.x,vA.y,vA.z,vB.x,vB.y,vB.z,vC.x,vC.y,vC.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out vec4 data;
layout(location = 1) out vec4 dataInterp;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = vec4(float(n), float(2*n), float(4*n), float(8*n));
    dataInterp    = vec4(float(n), float(2*n), float(4*n), float(8*n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) in vec4 dataIntrp;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec4 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ((x - 2) * 2 < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    vec4 eA; { const int n = 1 + (3*p); eA = vec4(float(n), float(2*n), float(4*n), float(8*n)); }
    vec4 eB; { const int n = 1 + (3*p+1); eB = vec4(float(n), float(2*n), float(4*n), float(8*n)); }
    vec4 eC; { const int n = 1 + (3*p+2); eC = vec4(float(n), float(2*n), float(4*n), float(8*n)); }

    float e[12] = { eA.x,eA.y,eA.z,eA.w,eB.x,eB.y,eB.z,eB.w,eC.x,eC.y,eC.z,eC.w };
    vec4 eIntrpV; {eIntrpV = vec4(eA * gl_BaryCoordEXT.x + eB * gl_BaryCoordEXT.y + eC * gl_BaryCoordEXT.z); }
    float eIntrp[12 / 3] = { eIntrpV.x,eIntrpV.y,eIntrpV.z,eIntrpV.w };

    vec4 vA; { vA = data[pc.n[0]]; }
    vec4 vB; { vB = data[pc.n[1]]; }
    vec4 vC; { vC = data[pc.n[2]]; }
    vec4 vIntrpV; { vIntrpV = dataIntrp; }
    float vIntrp[12 / 3] = { vIntrpV.x,vIntrpV.y,vIntrpV.z,vIntrpV.w };

    float v[12] = { vA.x,vA.y,vA.z,vA.w,vB.x,vB.y,vB.z,vB.w,vC.x,vC.y,vC.z,vC.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<12 / 3; i++)
        if (abs(eIntrp[i] - vIntrp[i]) < 0.001)
            mask.y = mask.y | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) flat in vec4 dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec4 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ((x - 2) * 2 < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    vec4 eA; { const int n = 1 + (3*p); eA = vec4(float(n), float(2*n), float(4*n), float(8*n)); }
    vec4 eB; { const int n = 1 + (3*p+1); eB = vec4(float(n), float(2*n), float(4*n), float(8*n)); }
    vec4 eC; { const int n = 1 + (3*p+2); eC = vec4(float(n), float(2*n), float(4*n), float(8*n)); }

    float e[12] = { eA.x,eA.y,eA.z,eA.w,eB.x,eB.y,eB.z,eB.w,eC.x,eC.y,eC.z,eC.w };
    vec4 eFlatV; { const int n = 1 + (3*p); eFlatV = vec4(float(n), float(2*n), float(4*n), float(8*n)); }
    float eFlat[12 / 3] = { eFlatV.x,eFlatV.y,eFlatV.z,eFlatV.w };

    vec4 vA; { vA = data[pc.n[0]]; }
    vec4 vB; { vB = data[pc.n[1]]; }
    vec4 vC; { vC = data[pc.n[2]]; }
    vec4 vFlatV; { vFlatV = dataFlat; }
    float vFlat[12 / 3] = { vFlatV.x,vFlatV.y,vFlatV.z,vFlatV.w};

    float v[12] = { vA.x,vA.y,vA.z,vA.w,vB.x,vB.y,vB.z,vB.w,vC.x,vC.y,vC.z,vC.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<12 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(triangles) out;
layout(max_vertices=6, max_primitives=6) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[6];
} pvd;
layout (location=0) out double data[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 6;
    uint maxPrimitive = 2;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    const uvec3 indices[2] = uvec3[](
        uvec3(0, 1, 2),
        uvec3(3, 4, 5)
    );
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = double(n);
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveTriangleIndicesEXT[primitive] = indices[primitive];
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in double data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ((x - 2) * 2 < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    double eA; { const int n = 1 + (3*p); eA = double(n); }
    double eB; { const int n = 1 + (3*p+1); eB = double(n); }
    double eC; { const int n = 1 + (3*p+2); eC = double(n); }

    double e[3] = { eA,eB,eC };

    double vA; { vA = data[pc.n[0]]; }
    double vB; { vB = data[pc.n[1]]; }
    double vC; { vC = data[pc.n[2]]; }

    double v[3] = { vA,vB,vC };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec4 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ((x - 2) * 2 < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    dvec4 eA; { const int n = 1 + (3*p); eA = dvec4(double(n), double(2*n), double(4*n), double(8*n)); }
    dvec4 eB; { const int n = 1 + (3*p+1); eB = dvec4(double(n), double(2*n), double(4*n), double(8*n)); }
    dvec4 eC; { const int n = 1 + (3*p+2); eC = dvec4(double(n), double(2*n), double(4*n), double(8*n)); }

    double e[12] = { eA.x,eA.y,eA.z,eA.w,eB.x,eB.y,eB.z,eB.w,eC.x,eC.y,eC.z,eC.w };

    dvec4 vA; { vA = data[pc.n[0]]; }
    dvec4 vB; { vB = data[pc.n[1]]; }
    dvec4 vC; { vC = data[pc.n[2]]; }

    double v[12] = { vA.x,vA.y,vA.z,vA.w,vB.x,vB.y,vB.z,vB.w,vC.x,vC.y,vC.z,vC.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 2) flat in dvec4 dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec4 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ((x - 2) * 2 < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    dvec4 eA; { const int n = 1 + (3*p); eA = dvec4(double(n), double(2*n), double(4*n), double(8*n)); }
    dvec4 eB; { const int n = 1 + (3*p+1); eB = dvec4(double(n), double(2*n), double(4*n), double(8*n)); }
    dvec4 eC; { const int n = 1 + (3*p+2); eC = dvec4(double(n), double(2*n), double(4*n), double(8*n)); }

    double e[12] = { eA.x,eA.y,eA.z,eA.w,eB.x,eB.y,eB.z,eB.w,eC.x,eC.y,eC.z,eC.w };
    dvec4 eFlatV; { const int n = 1 + (3*p); eFlatV = dvec4(double(n), double(2*n), double(4*n), double(8*n)); }
    double eFlat[12 / 3] = { eFlatV.x,eFlatV.y,eFlatV.z,eFlatV.w };

    dvec4 vA; { vA = data[pc.n[0]]; }
    dvec4 vB; { vB = data[pc.n[1]]; }
    dvec4 vC; { vC = data[pc.n[2]]; }
    dvec4 vFlatV; { vFlatV = dataFlat; }
    double vFlat[12 / 3] = { vFlatV.x,vFlatV.y,vFlatV.z,vFlatV.w};

    double v[12] = { vA.x,vA.y,vA.z,vA.w,vB.x,vB.y,vB.z,vB.w,vC.x,vC.y,vC.z,vC.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<12 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(triangles) out;
layout(max_vertices=6, max_primitives=6) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[6];
} pvd;
layout (location=0) out uint data[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 6;
    uint maxPrimitive = 2;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    const uvec3 indices[2] = uvec3[](
        uvec3(0, 1, 2),
        uvec3(3, 4, 5)
    );
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = uint(n);
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveTriangleIndicesEXT[primitive] = indices[primitive];
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uint data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ((x - 2) * 2 < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    uint eA; { const int n = 1 + (3*p); eA = uint(n); }
    uint eB; { const int n = 1 + (3*p+1); eB = uint(n); }
    uint eC; { const int n = 1 + (3*p+2); eC = uint(n); }

    uint e[3] = { eA,eB,eC };

    uint vA; { vA = data[pc.n[0]]; }
    uint vB; { vB = data[pc.n[1]]; }
    uint vC; { vC = data[pc.n[2]]; }

    uint v[3] = { vA,vB,vC };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) flat in uvec2 dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uvec2 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ((x - 2) * 2 < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    uvec2 eA; { const int n = 1 + (3*p); eA = uvec2(uint(n), uint(2*n)); }
    uvec2 eB; { const int n = 1 + (3*p+1); eB = uvec2(uint(n), uint(2*n)); }
    uvec2 eC; { const int n = 1 + (3*p+2); eC = uvec2(uint(n), uint(2*n)); }

    uint e[6] = { eA.x,eA.y,eB.x,eB.y,eC.x,eC.y };
    uvec2 eFlatV; { const int n = 1 + (3*p); eFlatV = uvec2(uint(n), uint(2*n)); }
    uint eFlat[6 / 3] = { eFlatV.x,eFlatV.y };

    uvec2 vA; { vA = data[pc.n[0]]; }
    uvec2 vB; { vB = data[pc.n[1]]; }
    uvec2 vC; { vC = data[pc.n[2]]; }
    uvec2 vFlatV; { vFlatV = dataFlat; }
    uint vFlat[6 / 3] = { vFlatV.x,vFlatV.y};

    uint v[6] = { vA.x,vA.y,vB.x,vB.y,vC.x,vC.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uvec3 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ((x - 2) * 2 < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    uvec3 eA; { const int n = 1 + (3*p); eA = uvec3(uint(n), uint(2*n), uint(4*n)); }
    uvec3 eB; { const int n = 1 + (3*p+1); eB = uvec3(uint(n), uint(2*n), uint(4*n)); }
    uvec3 eC; { const int n = 1 + (3*p+2); eC = uvec3(uint(n), uint(2*n), uint(4*n)); }

    uint e[9] = { eA.x,eA.y,eA.z,eB.x,eB.y,eB.z,eC.x,eC.y,eC.z };

    uvec3 vA; { vA = data[pc.n[0]]; }
    uvec3 vB; { vB = data[pc.n[1]]; }
    uvec3 vC; { vC = data[pc.n[2]]; }

    uint v[9] = { vA.x,vA.y,vA.z,vB.x,vB.y,vB.z,vC.x,vC.y,vC.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(triangles) out;
layout(max_vertices=6, max_primitives=6) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[6];
} pvd;
layout (location=0) out uvec3 data[];
layout(location = 1) out uvec3 dataFlat[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 6;
    uint maxPrimitive = 2;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    const uvec3 indices[2] = uvec3[](
        uvec3(0, 1, 2),
        uvec3(3, 4, 5)
    );
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = uvec3(uint(n), uint(2*n), uint(4*n));
    dataFlat[vertex]      = uvec3(uint(n), uint(2*n), uint(4*n));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveTriangleIndicesEXT[primitive] = indices[primitive];
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) flat in uvec3 dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uvec3 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ((x - 2) * 2 < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    uvec3 eA; { const int n = 1 + (3*p); eA = uvec3(uint(n), uint(2*n), uint(4*n)); }
    uvec3 eB; { const int n = 1 + (3*p+1); eB = uvec3(uint(n), uint(2*n), uint(4*n)); }
    uvec3 eC; { const int n = 1 + (3*p+2); eC = uvec3(uint(n), uint(2*n), uint(4*n)); }

    uint e[9] = { eA.x,eA.y,eA.z,eB.x,eB.y,eB.z,eC.x,eC.y,eC.z };
    uvec3 eFlatV; { const int n = 1 + (3*p); eFlatV = uvec3(uint(n), uint(2*n), uint(4*n)); }
    uint eFlat[9 / 3] = { eFlatV.x,eFlatV.y,eFlatV.z };

    uvec3 vA; { vA = data[pc.n[0]]; }
    uvec3 vB; { vB = data[pc.n[1]]; }
    uvec3 vC; { vC = data[pc.n[2]]; }
    uvec3 vFlatV; { vFlatV = dataFlat; }
    uint vFlat[9 / 3] = { vFlatV.x,vFlatV.y,vFlatV.z};

    uint v[9] = { vA.x,vA.y,vA.z,vB.x,vB.y,vB.z,vC.x,vC.y,vC.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<9 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable

struct DataStruct {vec2 q;};
layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(triangles) out;
layout(max_vertices=6, max_primitives=6) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[6];
} pvd;
layout (location=0) out DataStruct data[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 6;
    uint maxPrimitive = 2;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    const uvec3 indices[2] = uvec3[](
        uvec3(0, 1, 2),
        uvec3(3, 4, 5)
    );
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = DataStruct(vec2(float(n), float(2*n)));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveTriangleIndicesEXT[primitive] = indices[primitive];
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec2 q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ((x - 2) * 2 < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(vec2(float(n), float(2*n))); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(vec2(float(n), float(2*n))); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(vec2(float(n), float(2*n))); }

    float e[6] = { eA.q.x,eA.q.y,eB.q.x,eB.q.y,eC.q.x,eC.q.y };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }

    float v[6] = { vA.q.x,vA.q.y,vB.q.x,vB.q.y,vC.q.x,vC.q.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec3 q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;
layout(location = 1) out DataStruct dataFlat;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(vec3(float(n), float(2*n), float(4*n)));
    dataFlat      = DataStruct(vec3(float(n), float(2*n), float(4*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec3 q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ((x - 2) * 2 < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(vec3(float(n), float(2*n), float(4*n))); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(vec3(float(n), float(2*n), float(4*n))); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(vec3(float(n), float(2*n), float(4*n))); }

    float e[9] = { eA.q.x,eA.q.y,eA.q.z,eB.q.x,eB.q.y,eB.q.z,eC.q.x,eC.q.y,eC.q.z };
    DataStruct eFlatV; { const int n = 1 + (3*p); eFlatV = DataStruct(vec3(float(n), float(2*n), float(4*n))); }
    float eFlat[9 / 3] = { eFlatV.q.x,eFlatV.q.y,eFlatV.q.z };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    float vFlat[9 / 3] = { vFlatV.q.x,vFlatV.q.y,vFlatV.q.z};

    float v[9] = { vA.q.x,vA.q.y,vA.q.z,vB.q.x,vB.q.y,vB.q.z,vC.q.x,vC.q.y,vC.q.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<9 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {dvec2 q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 2) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ((x - 2) * 2 < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(dvec2(double(n), double(2*n))); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(dvec2(double(n), double(2*n))); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(dvec2(double(n), double(2*n))); }

    double e[6] = { eA.q.x,eA.q.y,eB.q.x,eB.q.y,eC.q.x,eC.q.y };
    DataStruct eFlatV; { const int n = 1 + (3*p); eFlatV = DataStruct(dvec2(double(n), double(2*n))); }
    double eFlat[6 / 3] = { eFlatV.q.x,eFlatV.q.y };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    double vFlat[6 / 3] = { vFlatV.q.x,vFlatV.q.y};

    double v[6] = { vA.q.x,vA.q.y,vB.q.x,vB.q.y,vC.q.x,vC.q.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable

struct DataStruct {dvec4 q;};
layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(triangles) out;
layout(max_vertices=6, max_primitives=6) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[6];
} pvd;
layout (location=0) out DataStruct data[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 6;
    uint maxPrimitive = 2;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    const uvec3 indices[2] = uvec3[](
        uvec3(0, 1, 2),
        uvec3(3, 4, 5)
    );
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = DataStruct(dvec4(double(n), double(2*n), double(4*n), double(8*n)));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveTriangleIndicesEXT[primitive] = indices[primitive];
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {dvec4 q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ((x - 2) * 2 < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(dvec4(double(n), double(2*n), double(4*n), double(8*n))); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(dvec4(double(n), double(2*n), double(4*n), double(8*n))); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(dvec4(double(n), double(2*n), double(4*n), double(8*n))); }

    double e[12] = { eA.q.x,eA.q.y,eA.q.z,eA.q.w,eB.q.x,eB.q.y,eB.q.z,eB.q.w,eC.q.x,eC.q.y,eC.q.z,eC.q.w };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }

    double v[12] = { vA.q.x,vA.q.y,vA.q.z,vA.q.w,vB.q.x,vB.q.y,vB.q.z,vB.q.w,vC.q.x,vC.q.y,vC.q.z,vC.q.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {int q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ((x - 2) * 2 < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(int(n)); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(int(n)); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(int(n)); }

    int e[3] = { eA.q,eB.q,eC.q };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }

    int v[3] = { vA.q,vB.q,vC.q };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {int q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ((x - 2) * 2 < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(int(n)); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(int(n)); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(int(n)); }

    int e[3] = { eA.q,eB.q,eC.q };
    DataStruct eFlatV; { const int n = 1 + (3*p); eFlatV = DataStruct(int(n)); }
    int eFlat[3 / 3] = { eFlatV.q };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    int vFlat[3 / 3] = { vFlatV.q};

    int v[3] = { vA.q,vB.q,vC.q };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<3 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable

struct DataStruct {ivec2 q;};
layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(triangles) out;
layout(max_vertices=6, max_primitives=6) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[6];
} pvd;
layout (location=0) out DataStruct data[];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 6;
    uint maxPrimitive = 2;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    const uvec3 indices[2] = uvec3[](
        uvec3(0, 1, 2),
        uvec3(3, 4, 5)
    );
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = DataStruct(ivec2(int(n), int(2*n)));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveTriangleIndicesEXT[primitive] = indices[primitive];
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {ivec2 q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ((x - 2) * 2 < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(ivec2(int(n), int(2*n))); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(ivec2(int(n), int(2*n))); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(ivec2(int(n), int(2*n))); }

    int e[6] = { eA.q.x,eA.q.y,eB.q.x,eB.q.y,eC.q.x,eC.q.y };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }

    int v[6] = { vA.q.x,vA.q.y,vB.q.x,vB.q.y,vC.q.x,vC.q.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {uint q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ((x - 2) * 2 < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(uint(n)); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(uint(n)); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(uint(n)); }

    uint e[3] = { eA.q,eB.q,eC.q };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }

    uint v[3] = { vA.q,vB.q,vC.q };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {uvec4 q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ((x - 2) * 2 < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }

    uint e[12] = { eA.q.x,eA.q.y,eA.q.z,eA.q.w,eB.q.x,eB.q.y,eB.q.z,eB.q.w,eC.q.x,eC.q.y,eC.q.z,eC.q.w };
    DataStruct eFlatV; { const int n = 1 + (3*p); eFlatV = DataStruct(uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }
    uint eFlat[12 / 3] = { eFlatV.q.x,eFlatV.q.y,eFlatV.q.z,eFlatV.q.w };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    uint vFlat[12 / 3] = { vFlatV.q.x,vFlatV.q.y,vFlatV.q.z,vFlatV.q.w};

    uint v[12] = { vA.q.x,vA.q.y,vA.q.z,vA.q.w,vB.q.x,vB.q.y,vB.q.z,vB.q.w,vC.q.x,vC.q.y,vC.q.z,vC.q.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<12 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 2) flat in float dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in float data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ((x - 2) * 2 < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    float eA[2]; { const int n = 1 + (3*p); eA = float[2](float(n), float(3)*float(n)); }
    float eB[2]; { const int n = 1 + (3*p+1); eB = float[2](float(n), float(3)*float(n)); }
    float eC[2]; { const int n = 1 + (3*p+2); eC = float[2](float(n), float(3)*float(n)); }

    float e[6] = { eA[0],eA[1],eB[0],eB[1],eC[0],eC[1] };
    float eFlatV[2]; { const int n = 1 + (3*p); eFlatV = float[2](float(n), float(3)*float(n)); }
    float eFlat[6 / 3] = { eFlatV[0],eFlatV[1] };

    float vA[2]; { vA = float[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    float vB[2]; { vB = float[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    float vC[2]; { vC = float[2](data[pc.n[2]][0],data[pc.n[2]][1]); }
    float vFlatV[2]; { vFlatV = float[2](dataFlat[0],dataFlat[1]); }
    float vFlat[6 / 3] = { vFlatV[0],vFlatV[1]};

    float v[6] = { vA[0],vA[1],vB[0],vB[1],vC[0],vC[1] };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out vec2 data[2];
layout(location = 2) out vec2 dataFlat[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = vec2[2](vec2(float(n), float(2*n)), float(3)*vec2(float(n), float(2*n)));
    dataFlat      = vec2[2](vec2(float(n), float(2*n)), float(3)*vec2(float(n), float(2*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 2) flat in vec2 dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec2 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ((x - 2) * 2 < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    vec2 eA[2]; { const int n = 1 + (3*p); eA = vec2[2](vec2(float(n), float(2*n)), float(3)*vec2(float(n), float(2*n))); }
    vec2 eB[2]; { const int n = 1 + (3*p+1); eB = vec2[2](vec2(float(n), float(2*n)), float(3)*vec2(float(n), float(2*n))); }
    vec2 eC[2]; { const int n = 1 + (3*p+2); eC = vec2[2](vec2(float(n), float(2*n)), float(3)*vec2(float(n), float(2*n))); }

    float e[12] = { eA[0].x,eA[0].y,eA[1].x,eA[1].y,eB[0].x,eB[0].y,eB[1].x,eB[1].y,eC[0].x,eC[0].y,eC[1].x,eC[1].y };
    vec2 eFlatV[2]; { const int n = 1 + (3*p); eFlatV = vec2[2](vec2(float(n), float(2*n)), float(3)*vec2(float(n), float(2*n))); }
    float eFlat[12 / 3] = { eFlatV[0].x,eFlatV[0].y,eFlatV[1].x,eFlatV[1].y };

    vec2 vA[2]; { vA = vec2[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    vec2 vB[2]; { vB = vec2[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    vec2 vC[2]; { vC = vec2[2](data[pc.n[2]][0],data[pc.n[2]][1]); }
    vec2 vFlatV[2]; { vFlatV = vec2[2](dataFlat[0],dataFlat[1]); }
    float vFlat[12 / 3] = { vFlatV[0].x,vFlatV[0].y,vFlatV[1].x,vFlatV[1].y};

    float v[12] = { vA[0].x,vA[0].y,vA[1].x,vA[1].y,vB[0].x,vB[0].y,vB[1].x,vB[1].y,vC[0].x,vC[0].y,vC[1].x,vC[1].y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<12 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec3 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ((x - 2) * 2 < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    vec3 eA[2]; { const int n = 1 + (3*p); eA = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n))); }
    vec3 eB[2]; { const int n = 1 + (3*p+1); eB = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n))); }
    vec3 eC[2]; { const int n = 1 + (3*p+2); eC = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n))); }

    float e[18] = { eA[0].x,eA[0].y,eA[0].z,eA[1].x,eA[1].y,eA[1].z,eB[0].x,eB[0].y,eB[0].z,eB[1].x,eB[1].y,eB[1].z,eC[0].x,eC[0].y,eC[0].z,eC[1].x,eC[1].y,eC[1].z };

    vec3 vA[2]; { vA = vec3[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    vec3 vB[2]; { vB = vec3[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    vec3 vC[2]; { vC = vec3[2](data[pc.n[2]][0],data[pc.n[2]][1]); }

    float v[18] = { vA[0].x,vA[0].y,vA[0].z,vA[1].x,vA[1].y,vA[1].z,vB[0].x,vB[0].y,vB[0].z,vB[1].x,vB[1].y,vB[1].z,vC[0].x,vC[0].y,vC[0].z,vC[1].x,vC[1].y,vC[1].z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<18; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(triangles) out;
layout(max_vertices=6, max_primitives=6) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[6];
} pvd;
layout (location=0) out double data[][2];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 6;
    uint maxPrimitive = 2;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    const uvec3 indices[2] = uvec3[](
        uvec3(0, 1, 2),
        uvec3(3, 4, 5)
    );
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = double[2](double(n), double(3)*double(n));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveTriangleIndicesEXT[primitive] = indices[primitive];
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in double data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ((x - 2) * 2 < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    double eA[2]; { const int n = 1 + (3*p); eA = double[2](double(n), double(3)*double(n)); }
    double eB[2]; { const int n = 1 + (3*p+1); eB = double[2](double(n), double(3)*double(n)); }
    double eC[2]; { const int n = 1 + (3*p+2); eC = double[2](double(n), double(3)*double(n)); }

    double e[6] = { eA[0],eA[1],eB[0],eB[1],eC[0],eC[1] };

    double vA[2]; { vA = double[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    double vB[2]; { vB = double[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    double vC[2]; { vC = double[2](data[pc.n[2]][0],data[pc.n[2]][1]); }

    double v[6] = { vA[0],vA[1],vB[0],vB[1],vC[0],vC[1] };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 4) flat in dvec3 dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec3 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ((x - 2) * 2 < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    dvec3 eA[2]; { const int n = 1 + (3*p); eA = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n))); }
    dvec3 eB[2]; { const int n = 1 + (3*p+1); eB = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n))); }
    dvec3 eC[2]; { const int n = 1 + (3*p+2); eC = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n))); }

    double e[18] = { eA[0].x,eA[0].y,eA[0].z,eA[1].x,eA[1].y,eA[1].z,eB[0].x,eB[0].y,eB[0].z,eB[1].x,eB[1].y,eB[1].z,eC[0].x,eC[0].y,eC[0].z,eC[1].x,eC[1].y,eC[1].z };
    dvec3 eFlatV[2]; { const int n = 1 + (3*p); eFlatV = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n))); }
    double eFlat[18 / 3] = { eFlatV[0].x,eFlatV[0].y,eFlatV[0].z,eFlatV[1].x,eFlatV[1].y,eFlatV[1].z };

    dvec3 vA[2]; { vA = dvec3[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    dvec3 vB[2]; { vB = dvec3[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    dvec3 vC[2]; { vC = dvec3[2](data[pc.n[2]][0],data[pc.n[2]][1]); }
    dvec3 vFlatV[2]; { vFlatV = dvec3[2](dataFlat[0],dataFlat[1]); }
    double vFlat[18 / 3] = { vFlatV[0].x,vFlatV[0].y,vFlatV[0].z,vFlatV[1].x,vFlatV[1].y,vFlatV[1].z};

    double v[18] = { vA[0].x,vA[0].y,vA[0].z,vA[1].x,vA[1].y,vA[1].z,vB[0].x,vB[0].y,vB[0].z,vB[1].x,vB[1].y,vB[1].z,vC[0].x,vC[0].y,vC[0].z,vC[1].x,vC[1].y,vC[1].z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<18; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<18 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_mesh_shader : enable


layout(local_size_x = 8, local_size_y = 4, local_size_z = 1) in;
layout(triangles) out;
layout(max_vertices=6, max_primitives=6) out;

layout(set = 0, binding = 0) buffer PerVertexData{ 
    vec4 vertexBuffer[6];
} pvd;
layout (location=0) out ivec3 data[][2];

out gl_MeshPerVertexEXT 
{
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

void main()
{
    uint maxVertex = 6;
    uint maxPrimitive = 2;
    SetMeshOutputsEXT(maxVertex, maxPrimitive);
    const uint vertex = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;
    const uvec3 indices[2] = uvec3[](
        uvec3(0, 1, 2),
        uvec3(3, 4, 5)
    );
    if (vertex < maxVertex)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = pvd.vertexBuffer[vertex];
        gl_MeshVerticesEXT[vertex].gl_PointSize = 1.0;
        uint n  = vertex + 1;
        data[vertex] = ivec3[2](ivec3(int(n), int(2*n), int(4*n)), int(3)*ivec3(int(n), int(2*n), int(4*n)));
    }
    if(primitive < maxPrimitive){
        gl_PrimitiveTriangleIndicesEXT[primitive] = indices[primitive];
    }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in ivec3 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ((x - 2) * 2 < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    ivec3 eA[2]; { const int n = 1 + (3*p); eA = ivec3[2](ivec3(int(n), int(2*n), int(4*n)), int(3)*ivec3(int(n), int(2*n), int(4*n))); }
    ivec3 eB[2]; { const int n = 1 + (3*p+1); eB = ivec3[2](ivec3(int(n), int(2*n), int(4*n)), int(3)*ivec3(int(n), int(2*n), int(4*n))); }
    ivec3 eC[2]; { const int n = 1 + (3*p+2); eC = ivec3[2](ivec3(int(n), int(2*n), int(4*n)), int(3)*ivec3(int(n), int(2*n), int(4*n))); }

    int e[18] = { eA[0].x,eA[0].y,eA[0].z,eA[1].x,eA[1].y,eA[1].z,eB[0].x,eB[0].y,eB[0].z,eB[1].x,eB[1].y,eB[1].z,eC[0].x,eC[0].y,eC[0].z,eC[1].x,eC[1].y,eC[1].z };

    ivec3 vA[2]; { vA = ivec3[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    ivec3 vB[2]; { vB = ivec3[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    ivec3 vC[2]; { vC = ivec3[2](data[pc.n[2]][0],data[pc.n[2]][1]); }

    int v[18] = { vA[0].x,vA[0].y,vA[0].z,vA[1].x,vA[1].y,vA[1].z,vB[0].x,vB[0].y,vB[0].z,vB[1].x,vB[1].y,vB[1].z,vC[0].x,vC[0].y,vC[0].z,vC[1].x,vC[1].y,vC[1].z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<18; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 2) flat in ivec4 dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in ivec4 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ((x - 2) * 2 < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    ivec4 eA[2]; { const int n = 1 + (3*p); eA = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n))); }
    ivec4 eB[2]; { const int n = 1 + (3*p+1); eB = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n))); }
    ivec4 eC[2]; { const int n = 1 + (3*p+2); eC = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n))); }

    int e[24] = { eA[0].x,eA[0].y,eA[0].z,eA[0].w,eA[1].x,eA[1].y,eA[1].z,eA[1].w,eB[0].x,eB[0].y,eB[0].z,eB[0].w,eB[1].x,eB[1].y,eB[1].z,eB[1].w,eC[0].x,eC[0].y,eC[0].z,eC[0].w,eC[1].x,eC[1].y,eC[1].z,eC[1].w };
    ivec4 eFlatV[2]; { const int n = 1 + (3*p); eFlatV = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n))); }
    int eFlat[24 / 3] = { eFlatV[0].x,eFlatV[0].y,eFlatV[0].z,eFlatV[0].w,eFlatV[1].x,eFlatV[1].y,eFlatV[1].z,eFlatV[1].w };

    ivec4 vA[2]; { vA = ivec4[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    ivec4 vB[2]; { vB = ivec4[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    ivec4 vC[2]; { vC = ivec4[2](data[pc.n[2]][0],data[pc.n[2]][1]); }
    ivec4 vFlatV[2]; { vFlatV = ivec4[2](dataFlat[0],dataFlat[1]); }
    int vFlat[24 / 3] = { vFlatV[0].x,vFlatV[0].y,vFlatV[0].z,vFlatV[0].w,vFlatV[1].x,vFlatV[1].y,vFlatV[1].z,vFlatV[1].w};

    int v[24] = { vA[0].x,vA[0].y,vA[0].z,vA[0].w,vA[1].x,vA[1].y,vA[1].z,vA[1].w,vB[0].x,vB[0].y,vB[0].z,vB[0].w,vB[1].x,vB[1].y,vB[1].z,vB[1].w,vC[0].x,vC[0].y,vC[0].z,vC[0].w,vC[1].x,vC[1].y,vC[1].z,vC[1].w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<24; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<24 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in float data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    float eA; { const int n = 1 + (p); eA = float(n); }
    float eB; { const int n = 1 + (even?p+1:p+2); eB = float(n); }
    float eC; { const int n = 1 + (even?p+2:p+1); eC = float(n); }

    float e[3] = { eA,eB,eC };

    float vA; { vA = data[pc.n[0]]; }
    float vB; { vB = data[pc.n[1]]; }
    float vC; { vC = data[pc.n[2]]; }

    float v[3] = { vA,vB,vC };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) in float dataIntrp;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in float data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    float eA; { const int n = 1 + (p); eA = float(n); }
    float eB; { const int n = 1 + (even?p+1:p+2); eB = float(n); }
    float eC; { const int n = 1 + (even?p+2:p+1); eC = float(n); }

    float e[3] = { eA,eB,eC };
    float eIntrpV; {eIntrpV = float(eA * gl_BaryCoordEXT.x + eB * gl_BaryCoordEXT.y + eC * gl_BaryCoordEXT.z); }
    float eIntrp[3 / 3] = { eIntrpV };

    float vA; { vA = data[pc.n[0]]; }
    float vB; { vB = data[pc.n[1]]; }
    float vC; { vC = data[pc.n[2]]; }
    float vIntrpV; { vIntrpV = dataIntrp; }
    float vIntrp[3 / 3] = { vIntrpV };

    float v[3] = { vA,vB,vC };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<3 / 3; i++)
        if (abs(eIntrp[i] - vIntrp[i]) < 0.001)
            mask.y = mask.y | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec2 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    dvec2 eA; { const int n = 1 + (p); eA = dvec2(double(n), double(2*n)); }
    dvec2 eB; { const int n = 1 + (even?p+1:p+2); eB = dvec2(double(n), double(2*n)); }
    dvec2 eC; { const int n = 1 + (even?p+2:p+1); eC = dvec2(double(n), double(2*n)); }

    double e[6] = { eA.x,eA.y,eB.x,eB.y,eC.x,eC.y };

    dvec2 vA; { vA = data[pc.n[0]]; }
    dvec2 vB; { vB = data[pc.n[1]]; }
    dvec2 vC; { vC = data[pc.n[2]]; }

    double v[6] = { vA.x,vA.y,vB.x,vB.y,vC.x,vC.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) flat in ivec4 dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in ivec4 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    ivec4 eA; { const int n = 1 + (p); eA = ivec4(int(n), int(2*n), int(4*n), int(8*n)); }
    ivec4 eB; { const int n = 1 + (even?p+1:p+2); eB = ivec4(int(n), int(2*n), int(4*n), int(8*n)); }
    ivec4 eC; { const int n = 1 + (even?p+2:p+1); eC = ivec4(int(n), int(2*n), int(4*n), int(8*n)); }

    int e[12] = { eA.x,eA.y,eA.z,eA.w,eB.x,eB.y,eB.z,eB.w,eC.x,eC.y,eC.z,eC.w };
    ivec4 eFlatV; { const int n = 1 + (p); eFlatV = ivec4(int(n), int(2*n), int(4*n), int(8*n)); }
    int eFlat[12 / 3] = { eFlatV.x,eFlatV.y,eFlatV.z,eFlatV.w };

    ivec4 vA; { vA = data[pc.n[0]]; }
    ivec4 vB; { vB = data[pc.n[1]]; }
    ivec4 vC; { vC = data[pc.n[2]]; }
    ivec4 vFlatV; { vFlatV = dataFlat; }
    int vFlat[12 / 3] = { vFlatV.x,vFlatV.y,vFlatV.z,vFlatV.w};

    int v[12] = { vA.x,vA.y,vA.z,vA.w,vB.x,vB.y,vB.z,vB.w,vC.x,vC.y,vC.z,vC.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<12 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {dvec3 q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (p); eA = DataStruct(dvec3(double(n), double(2*n), double(4*n))); }
    DataStruct eB; { const int n = 1 + (even?p+1:p+2); eB = DataStruct(dvec3(double(n), double(2*n), double(4*n))); }
    DataStruct eC; { const int n = 1 + (even?p+2:p+1); eC = DataStruct(dvec3(double(n), double(2*n), double(4*n))); }

    double e[9] = { eA.q.x,eA.q.y,eA.q.z,eB.q.x,eB.q.y,eB.q.z,eC.q.x,eC.q.y,eC.q.z };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }

    double v[9] = { vA.q.x,vA.q.y,vA.q.z,vB.q.x,vB.q.y,vB.q.z,vC.q.x,vC.q.y,vC.q.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {uvec4 q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (p); eA = DataStruct(uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }
    DataStruct eB; { const int n = 1 + (even?p+1:p+2); eB = DataStruct(uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }
    DataStruct eC; { const int n = 1 + (even?p+2:p+1); eC = DataStruct(uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }

    uint e[12] = { eA.q.x,eA.q.y,eA.q.z,eA.q.w,eB.q.x,eB.q.y,eB.q.z,eB.q.w,eC.q.x,eC.q.y,eC.q.z,eC.q.w };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }

    uint v[12] = { vA.q.x,vA.q.y,vA.q.z,vA.q.w,vB.q.x,vB.q.y,vB.q.z,vB.q.w,vC.q.x,vC.q.y,vC.q.z,vC.q.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec4 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    dvec4 eA[2]; { const int n = 1 + (p); eA = dvec4[2](dvec4(double(n), double(2*n), double(4*n), double(8*n)), double(3)*dvec4(double(n), double(2*n), double(4*n), double(8*n))); }
    dvec4 eB[2]; { const int n = 1 + (even?p+1:p+2); eB = dvec4[2](dvec4(double(n), double(2*n), double(4*n), double(8*n)), double(3)*dvec4(double(n), double(2*n), double(4*n), double(8*n))); }
    dvec4 eC[2]; { const int n = 1 + (even?p+2:p+1); eC = dvec4[2](dvec4(double(n), double(2*n), double(4*n), double(8*n)), double(3)*dvec4(double(n), double(2*n), double(4*n), double(8*n))); }

    double e[24] = { eA[0].x,eA[0].y,eA[0].z,eA[0].w,eA[1].x,eA[1].y,eA[1].z,eA[1].w,eB[0].x,eB[0].y,eB[0].z,eB[0].w,eB[1].x,eB[1].y,eB[1].z,eB[1].w,eC[0].x,eC[0].y,eC[0].z,eC[0].w,eC[1].x,eC[1].y,eC[1].z,eC[1].w };

    dvec4 vA[2]; { vA = dvec4[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    dvec4 vB[2]; { vB = dvec4[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    dvec4 vC[2]; { vC = dvec4[2](data[pc.n[2]][0],data[pc.n[2]][1]); }

    double v[24] = { vA[0].x,vA[0].y,vA[0].z,vA[0].w,vA[1].x,vA[1].y,vA[1].z,vA[1].w,vB[0].x,vB[0].y,vB[0].z,vB[0].w,vB[1].x,vB[1].y,vB[1].z,vB[1].w,vC[0].x,vC[0].y,vC[0].z,vC[0].w,vC[1].x,vC[1].y,vC[1].z,vC[1].w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<24; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in int data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    int eA[2]; { const int n = 1 + (p); eA = int[2](int(n), int(3)*int(n)); }
    int eB[2]; { const int n = 1 + (even?p+1:p+2); eB = int[2](int(n), int(3)*int(n)); }
    int eC[2]; { const int n = 1 + (even?p+2:p+1); eC = int[2](int(n), int(3)*int(n)); }

    int e[6] = { eA[0],eA[1],eB[0],eB[1],eC[0],eC[1] };

    int vA[2]; { vA = int[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    int vB[2]; { vB = int[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    int vC[2]; { vC = int[2](data[pc.n[2]][0],data[pc.n[2]][1]); }

    int v[6] = { vA[0],vA[1],vB[0],vB[1],vC[0],vC[1] };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 2) flat in ivec4 dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in ivec4 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    ivec4 eA[2]; { const int n = 1 + (p); eA = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n))); }
    ivec4 eB[2]; { const int n = 1 + (even?p+1:p+2); eB = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n))); }
    ivec4 eC[2]; { const int n = 1 + (even?p+2:p+1); eC = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n))); }

    int e[24] = { eA[0].x,eA[0].y,eA[0].z,eA[0].w,eA[1].x,eA[1].y,eA[1].z,eA[1].w,eB[0].x,eB[0].y,eB[0].z,eB[0].w,eB[1].x,eB[1].y,eB[1].z,eB[1].w,eC[0].x,eC[0].y,eC[0].z,eC[0].w,eC[1].x,eC[1].y,eC[1].z,eC[1].w };
    ivec4 eFlatV[2]; { const int n = 1 + (p); eFlatV = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n))); }
    int eFlat[24 / 3] = { eFlatV[0].x,eFlatV[0].y,eFlatV[0].z,eFlatV[0].w,eFlatV[1].x,eFlatV[1].y,eFlatV[1].z,eFlatV[1].w };

    ivec4 vA[2]; { vA = ivec4[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    ivec4 vB[2]; { vB = ivec4[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    ivec4 vC[2]; { vC = ivec4[2](data[pc.n[2]][0],data[pc.n[2]][1]); }
    ivec4 vFlatV[2]; { vFlatV = ivec4[2](dataFlat[0],dataFlat[1]); }
    int vFlat[24 / 3] = { vFlatV[0].x,vFlatV[0].y,vFlatV[0].z,vFlatV[0].w,vFlatV[1].x,vFlatV[1].y,vFlatV[1].z,vFlatV[1].w};

    int v[24] = { vA[0].x,vA[0].y,vA[0].z,vA[0].w,vA[1].x,vA[1].y,vA[1].z,vA[1].w,vB[0].x,vB[0].y,vB[0].z,vB[0].w,vB[1].x,vB[1].y,vB[1].z,vB[1].w,vC[0].x,vC[0].y,vC[0].z,vC[0].w,vC[1].x,vC[1].y,vC[1].z,vC[1].w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<24; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<24 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 2) flat in uint dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uint data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    uint eA[2]; { const int n = 1 + (p); eA = uint[2](uint(n), uint(3)*uint(n)); }
    uint eB[2]; { const int n = 1 + (even?p+1:p+2); eB = uint[2](uint(n), uint(3)*uint(n)); }
    uint eC[2]; { const int n = 1 + (even?p+2:p+1); eC = uint[2](uint(n), uint(3)*uint(n)); }

    uint e[6] = { eA[0],eA[1],eB[0],eB[1],eC[0],eC[1] };
    uint eFlatV[2]; { const int n = 1 + (p); eFlatV = uint[2](uint(n), uint(3)*uint(n)); }
    uint eFlat[6 / 3] = { eFlatV[0],eFlatV[1] };

    uint vA[2]; { vA = uint[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    uint vB[2]; { vB = uint[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    uint vC[2]; { vC = uint[2](data[pc.n[2]][0],data[pc.n[2]][1]); }
    uint vFlatV[2]; { vFlatV = uint[2](dataFlat[0],dataFlat[1]); }
    uint vFlat[6 / 3] = { vFlatV[0],vFlatV[1]};

    uint v[6] = { vA[0],vA[1],vB[0],vB[1],vC[0],vC[1] };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uvec3 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    uvec3 eA[2]; { const int n = 1 + (p); eA = uvec3[2](uvec3(uint(n), uint(2*n), uint(4*n)), uint(3)*uvec3(uint(n), uint(2*n), uint(4*n))); }
    uvec3 eB[2]; { const int n = 1 + (even?p+1:p+2); eB = uvec3[2](uvec3(uint(n), uint(2*n), uint(4*n)), uint(3)*uvec3(uint(n), uint(2*n), uint(4*n))); }
    uvec3 eC[2]; { const int n = 1 + (even?p+2:p+1); eC = uvec3[2](uvec3(uint(n), uint(2*n), uint(4*n)), uint(3)*uvec3(uint(n), uint(2*n), uint(4*n))); }

    uint e[18] = { eA[0].x,eA[0].y,eA[0].z,eA[1].x,eA[1].y,eA[1].z,eB[0].x,eB[0].y,eB[0].z,eB[1].x,eB[1].y,eB[1].z,eC[0].x,eC[0].y,eC[0].z,eC[1].x,eC[1].y,eC[1].z };

    uvec3 vA[2]; { vA = uvec3[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    uvec3 vB[2]; { vB = uvec3[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    uvec3 vC[2]; { vC = uvec3[2](data[pc.n[2]][0],data[pc.n[2]][1]); }

    uint v[18] = { vA[0].x,vA[0].y,vA[0].z,vA[1].x,vA[1].y,vA[1].z,vB[0].x,vB[0].y,vB[0].z,vB[1].x,vB[1].y,vB[1].z,vC[0].x,vC[0].y,vC[0].z,vC[1].x,vC[1].y,vC[1].z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<18; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out vec2 data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = vec2(float(n), float(2*n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec2 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    vec2 eA; { const int n = 1 + (p+1); eA = vec2(float(n), float(2*n)); }
    vec2 eB; { const int n = 1 + (p+2); eB = vec2(float(n), float(2*n)); }
    vec2 eC; { const int n = 1 + (0); eC = vec2(float(n), float(2*n)); }

    float e[6] = { eA.x,eA.y,eB.x,eB.y,eC.x,eC.y };

    vec2 vA; { vA = data[pc.n[0]]; }
    vec2 vB; { vB = data[pc.n[1]]; }
    vec2 vC; { vC = data[pc.n[2]]; }

    float v[6] = { vA.x,vA.y,vB.x,vB.y,vC.x,vC.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) in vec2 dataIntrp;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec2 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    vec2 eA; { const int n = 1 + (p+1); eA = vec2(float(n), float(2*n)); }
    vec2 eB; { const int n = 1 + (p+2); eB = vec2(float(n), float(2*n)); }
    vec2 eC; { const int n = 1 + (0); eC = vec2(float(n), float(2*n)); }

    float e[6] = { eA.x,eA.y,eB.x,eB.y,eC.x,eC.y };
    vec2 eIntrpV; {eIntrpV = vec2(eA * gl_BaryCoordEXT.x + eB * gl_BaryCoordEXT.y + eC * gl_BaryCoordEXT.z); }
    float eIntrp[6 / 3] = { eIntrpV.x,eIntrpV.y };

    vec2 vA; { vA = data[pc.n[0]]; }
    vec2 vB; { vB = data[pc.n[1]]; }
    vec2 vC; { vC = data[pc.n[2]]; }
    vec2 vIntrpV; { vIntrpV = dataIntrp; }
    float vIntrp[6 / 3] = { vIntrpV.x,vIntrpV.y };

    float v[6] = { vA.x,vA.y,vB.x,vB.y,vC.x,vC.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (abs(eIntrp[i] - vIntrp[i]) < 0.001)
            mask.y = mask.y | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) in vec3 dataIntrp;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec3 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    vec3 eA; { const int n = 1 + (p+1); eA = vec3(float(n), float(2*n), float(4*n)); }
    vec3 eB; { const int n = 1 + (p+2); eB = vec3(float(n), float(2*n), float(4*n)); }
    vec3 eC; { const int n = 1 + (0); eC = vec3(float(n), float(2*n), float(4*n)); }

    float e[9] = { eA.x,eA.y,eA.z,eB.x,eB.y,eB.z,eC.x,eC.y,eC.z };
    vec3 eIntrpV; {eIntrpV = vec3(eA * gl_BaryCoordEXT.x + eB * gl_BaryCoordEXT.y + eC * gl_BaryCoordEXT.z); }
    float eIntrp[9 / 3] = { eIntrpV.x,eIntrpV.y,eIntrpV.z };

    vec3 vA; { vA = data[pc.n[0]]; }
    vec3 vB; { vB = data[pc.n[1]]; }
    vec3 vC; { vC = data[pc.n[2]]; }
    vec3 vIntrpV; { vIntrpV = dataIntrp; }
    float vIntrp[9 / 3] = { vIntrpV.x,vIntrpV.y,vIntrpV.z };

    float v[9] = { vA.x,vA.y,vA.z,vB.x,vB.y,vB.z,vC.x,vC.y,vC.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<9 / 3; i++)
        if (abs(eIntrp[i] - vIntrp[i]) < 0.001)
            mask.y = mask.y | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out int data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = int(n);
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in int data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    int eA; { const int n = 1 + (p+1); eA = int(n); }
    int eB; { const int n = 1 + (p+2); eB = int(n); }
    int eC; { const int n = 1 + (0); eC = int(n); }

    int e[3] = { eA,eB,eC };

    int vA; { vA = data[pc.n[0]]; }
    int vB; { vB = data[pc.n[1]]; }
    int vC; { vC = data[pc.n[2]]; }

    int v[3] = { vA,vB,vC };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in ivec3 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    ivec3 eA; { const int n = 1 + (p+1); eA = ivec3(int(n), int(2*n), int(4*n)); }
    ivec3 eB; { const int n = 1 + (p+2); eB = ivec3(int(n), int(2*n), int(4*n)); }
    ivec3 eC; { const int n = 1 + (0); eC = ivec3(int(n), int(2*n), int(4*n)); }

    int e[9] = { eA.x,eA.y,eA.z,eB.x,eB.y,eB.z,eC.x,eC.y,eC.z };

    ivec3 vA; { vA = data[pc.n[0]]; }
    ivec3 vB; { vB = data[pc.n[1]]; }
    ivec3 vC; { vC = data[pc.n[2]]; }

    int v[9] = { vA.x,vA.y,vA.z,vB.x,vB.y,vB.z,vC.x,vC.y,vC.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) flat in uvec3 dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uvec3 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    uvec3 eA; { const int n = 1 + (p+1); eA = uvec3(uint(n), uint(2*n), uint(4*n)); }
    uvec3 eB; { const int n = 1 + (p+2); eB = uvec3(uint(n), uint(2*n), uint(4*n)); }
    uvec3 eC; { const int n = 1 + (0); eC = uvec3(uint(n), uint(2*n), uint(4*n)); }

    uint e[9] = { eA.x,eA.y,eA.z,eB.x,eB.y,eB.z,eC.x,eC.y,eC.z };
    uvec3 eFlatV; { const int n = 1 + (p+1); eFlatV = uvec3(uint(n), uint(2*n), uint(4*n)); }
    uint eFlat[9 / 3] = { eFlatV.x,eFlatV.y,eFlatV.z };

    uvec3 vA; { vA = data[pc.n[0]]; }
    uvec3 vB; { vB = data[pc.n[1]]; }
    uvec3 vC; { vC = data[pc.n[2]]; }
    uvec3 vFlatV; { vFlatV = dataFlat; }
    uint vFlat[9 / 3] = { vFlatV.x,vFlatV.y,vFlatV.z};

    uint v[9] = { vA.x,vA.y,vA.z,vB.x,vB.y,vB.z,vC.x,vC.y,vC.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<9 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec2 q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (p+1); eA = DataStruct(vec2(float(n), float(2*n))); }
    DataStruct eB; { const int n = 1 + (p+2); eB = DataStruct(vec2(float(n), float(2*n))); }
    DataStruct eC; { const int n = 1 + (0); eC = DataStruct(vec2(float(n), float(2*n))); }

    float e[6] = { eA.q.x,eA.q.y,eB.q.x,eB.q.y,eC.q.x,eC.q.y };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }

    float v[6] = { vA.q.x,vA.q.y,vB.q.x,vB.q.y,vC.q.x,vC.q.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec2 q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (p+1); eA = DataStruct(vec2(float(n), float(2*n))); }
    DataStruct eB; { const int n = 1 + (p+2); eB = DataStruct(vec2(float(n), float(2*n))); }
    DataStruct eC; { const int n = 1 + (0); eC = DataStruct(vec2(float(n), float(2*n))); }

    float e[6] = { eA.q.x,eA.q.y,eB.q.x,eB.q.y,eC.q.x,eC.q.y };
    DataStruct eFlatV; { const int n = 1 + (p+1); eFlatV = DataStruct(vec2(float(n), float(2*n))); }
    float eFlat[6 / 3] = { eFlatV.q.x,eFlatV.q.y };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    float vFlat[6 / 3] = { vFlatV.q.x,vFlatV.q.y};

    float v[6] = { vA.q.x,vA.q.y,vB.q.x,vB.q.y,vC.q.x,vC.q.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {double q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 2) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (p+1); eA = DataStruct(double(n)); }
    DataStruct eB; { const int n = 1 + (p+2); eB = DataStruct(double(n)); }
    DataStruct eC; { const int n = 1 + (0); eC = DataStruct(double(n)); }

    double e[3] = { eA.q,eB.q,eC.q };
    DataStruct eFlatV; { const int n = 1 + (p+1); eFlatV = DataStruct(double(n)); }
    double eFlat[3 / 3] = { eFlatV.q };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    double vFlat[3 / 3] = { vFlatV.q};

    double v[3] = { vA.q,vB.q,vC.q };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<3 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {dvec2 q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 2) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (p+1); eA = DataStruct(dvec2(double(n), double(2*n))); }
    DataStruct eB; { const int n = 1 + (p+2); eB = DataStruct(dvec2(double(n), double(2*n))); }
    DataStruct eC; { const int n = 1 + (0); eC = DataStruct(dvec2(double(n), double(2*n))); }

    double e[6] = { eA.q.x,eA.q.y,eB.q.x,eB.q.y,eC.q.x,eC.q.y };
    DataStruct eFlatV; { const int n = 1 + (p+1); eFlatV = DataStruct(dvec2(double(n), double(2*n))); }
    double eFlat[6 / 3] = { eFlatV.q.x,eFlatV.q.y };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    double vFlat[6 / 3] = { vFlatV.q.x,vFlatV.q.y};

    double v[6] = { vA.q.x,vA.q.y,vB.q.x,vB.q.y,vC.q.x,vC.q.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {dvec4 q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (p+1); eA = DataStruct(dvec4(double(n), double(2*n), double(4*n), double(8*n))); }
    DataStruct eB; { const int n = 1 + (p+2); eB = DataStruct(dvec4(double(n), double(2*n), double(4*n), double(8*n))); }
    DataStruct eC; { const int n = 1 + (0); eC = DataStruct(dvec4(double(n), double(2*n), double(4*n), double(8*n))); }

    double e[12] = { eA.q.x,eA.q.y,eA.q.z,eA.q.w,eB.q.x,eB.q.y,eB.q.z,eB.q.w,eC.q.x,eC.q.y,eC.q.z,eC.q.w };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }

    double v[12] = { vA.q.x,vA.q.y,vA.q.z,vA.q.w,vB.q.x,vB.q.y,vB.q.z,vB.q.w,vC.q.x,vC.q.y,vC.q.z,vC.q.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {uvec3 q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (p+1); eA = DataStruct(uvec3(uint(n), uint(2*n), uint(4*n))); }
    DataStruct eB; { const int n = 1 + (p+2); eB = DataStruct(uvec3(uint(n), uint(2*n), uint(4*n))); }
    DataStruct eC; { const int n = 1 + (0); eC = DataStruct(uvec3(uint(n), uint(2*n), uint(4*n))); }

    uint e[9] = { eA.q.x,eA.q.y,eA.q.z,eB.q.x,eB.q.y,eB.q.z,eC.q.x,eC.q.y,eC.q.z };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }

    uint v[9] = { vA.q.x,vA.q.y,vA.q.z,vB.q.x,vB.q.y,vB.q.z,vC.q.x,vC.q.y,vC.q.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {uvec4 q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (p+1); eA = DataStruct(uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }
    DataStruct eB; { const int n = 1 + (p+2); eB = DataStruct(uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }
    DataStruct eC; { const int n = 1 + (0); eC = DataStruct(uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }

    uint e[12] = { eA.q.x,eA.q.y,eA.q.z,eA.q.w,eB.q.x,eB.q.y,eB.q.z,eB.q.w,eC.q.x,eC.q.y,eC.q.z,eC.q.w };
    DataStruct eFlatV; { const int n = 1 + (p+1); eFlatV = DataStruct(uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }
    uint eFlat[12 / 3] = { eFlatV.q.x,eFlatV.q.y,eFlatV.q.z,eFlatV.q.w };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    uint vFlat[12 / 3] = { vFlatV.q.x,vFlatV.q.y,vFlatV.q.z,vFlatV.q.w};

    uint v[12] = { vA.q.x,vA.q.y,vA.q.z,vA.q.w,vB.q.x,vB.q.y,vB.q.z,vB.q.w,vC.q.x,vC.q.y,vC.q.z,vC.q.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<12 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 2) flat in vec3 dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec3 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    vec3 eA[2]; { const int n = 1 + (p+1); eA = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n))); }
    vec3 eB[2]; { const int n = 1 + (p+2); eB = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n))); }
    vec3 eC[2]; { const int n = 1 + (0); eC = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n))); }

    float e[18] = { eA[0].x,eA[0].y,eA[0].z,eA[1].x,eA[1].y,eA[1].z,eB[0].x,eB[0].y,eB[0].z,eB[1].x,eB[1].y,eB[1].z,eC[0].x,eC[0].y,eC[0].z,eC[1].x,eC[1].y,eC[1].z };
    vec3 eFlatV[2]; { const int n = 1 + (p+1); eFlatV = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n))); }
    float eFlat[18 / 3] = { eFlatV[0].x,eFlatV[0].y,eFlatV[0].z,eFlatV[1].x,eFlatV[1].y,eFlatV[1].z };

    vec3 vA[2]; { vA = vec3[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    vec3 vB[2]; { vB = vec3[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    vec3 vC[2]; { vC = vec3[2](data[pc.n[2]][0],data[pc.n[2]][1]); }
    vec3 vFlatV[2]; { vFlatV = vec3[2](dataFlat[0],dataFlat[1]); }
    float vFlat[18 / 3] = { vFlatV[0].x,vFlatV[0].y,vFlatV[0].z,vFlatV[1].x,vFlatV[1].y,vFlatV[1].z};

    float v[18] = { vA[0].x,vA[0].y,vA[0].z,vA[1].x,vA[1].y,vA[1].z,vB[0].x,vB[0].y,vB[0].z,vB[1].x,vB[1].y,vB[1].z,vC[0].x,vC[0].y,vC[0].z,vC[1].x,vC[1].y,vC[1].z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<18; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<18 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec4 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    vec4 eA[2]; { const int n = 1 + (p+1); eA = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    vec4 eB[2]; { const int n = 1 + (p+2); eB = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    vec4 eC[2]; { const int n = 1 + (0); eC = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n))); }

    float e[24] = { eA[0].x,eA[0].y,eA[0].z,eA[0].w,eA[1].x,eA[1].y,eA[1].z,eA[1].w,eB[0].x,eB[0].y,eB[0].z,eB[0].w,eB[1].x,eB[1].y,eB[1].z,eB[1].w,eC[0].x,eC[0].y,eC[0].z,eC[0].w,eC[1].x,eC[1].y,eC[1].z,eC[1].w };

    vec4 vA[2]; { vA = vec4[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    vec4 vB[2]; { vB = vec4[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    vec4 vC[2]; { vC = vec4[2](data[pc.n[2]][0],data[pc.n[2]][1]); }

    float v[24] = { vA[0].x,vA[0].y,vA[0].z,vA[0].w,vA[1].x,vA[1].y,vA[1].z,vA[1].w,vB[0].x,vB[0].y,vB[0].z,vB[0].w,vB[1].x,vB[1].y,vB[1].z,vB[1].w,vC[0].x,vC[0].y,vC[0].z,vC[0].w,vC[1].x,vC[1].y,vC[1].z,vC[1].w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<24; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec3 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    dvec3 eA[2]; { const int n = 1 + (p+1); eA = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n))); }
    dvec3 eB[2]; { const int n = 1 + (p+2); eB = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n))); }
    dvec3 eC[2]; { const int n = 1 + (0); eC = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n))); }

    double e[18] = { eA[0].x,eA[0].y,eA[0].z,eA[1].x,eA[1].y,eA[1].z,eB[0].x,eB[0].y,eB[0].z,eB[1].x,eB[1].y,eB[1].z,eC[0].x,eC[0].y,eC[0].z,eC[1].x,eC[1].y,eC[1].z };

    dvec3 vA[2]; { vA = dvec3[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    dvec3 vB[2]; { vB = dvec3[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    dvec3 vC[2]; { vC = dvec3[2](data[pc.n[2]][0],data[pc.n[2]][1]); }

    double v[18] = { vA[0].x,vA[0].y,vA[0].z,vA[1].x,vA[1].y,vA[1].z,vB[0].x,vB[0].y,vB[0].z,vB[1].x,vB[1].y,vB[1].z,vC[0].x,vC[0].y,vC[0].z,vC[1].x,vC[1].y,vC[1].z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<18; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 4) flat in dvec3 dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec3 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    dvec3 eA[2]; { const int n = 1 + (p+1); eA = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n))); }
    dvec3 eB[2]; { const int n = 1 + (p+2); eB = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n))); }
    dvec3 eC[2]; { const int n = 1 + (0); eC = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n))); }

    double e[18] = { eA[0].x,eA[0].y,eA[0].z,eA[1].x,eA[1].y,eA[1].z,eB[0].x,eB[0].y,eB[0].z,eB[1].x,eB[1].y,eB[1].z,eC[0].x,eC[0].y,eC[0].z,eC[1].x,eC[1].y,eC[1].z };
    dvec3 eFlatV[2]; { const int n = 1 + (p+1); eFlatV = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n))); }
    double eFlat[18 / 3] = { eFlatV[0].x,eFlatV[0].y,eFlatV[0].z,eFlatV[1].x,eFlatV[1].y,eFlatV[1].z };

    dvec3 vA[2]; { vA = dvec3[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    dvec3 vB[2]; { vB = dvec3[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    dvec3 vC[2]; { vC = dvec3[2](data[pc.n[2]][0],data[pc.n[2]][1]); }
    dvec3 vFlatV[2]; { vFlatV = dvec3[2](dataFlat[0],dataFlat[1]); }
    double vFlat[18 / 3] = { vFlatV[0].x,vFlatV[0].y,vFlatV[0].z,vFlatV[1].x,vFlatV[1].y,vFlatV[1].z};

    double v[18] = { vA[0].x,vA[0].y,vA[0].z,vA[1].x,vA[1].y,vA[1].z,vB[0].x,vB[0].y,vB[0].z,vB[1].x,vB[1].y,vB[1].z,vC[0].x,vC[0].y,vC[0].z,vC[1].x,vC[1].y,vC[1].z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<18; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<18 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uvec4 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    uvec4 eA[2]; { const int n = 1 + (p+1); eA = uvec4[2](uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)), uint(3)*uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }
    uvec4 eB[2]; { const int n = 1 + (p+2); eB = uvec4[2](uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)), uint(3)*uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }
    uvec4 eC[2]; { const int n = 1 + (0); eC = uvec4[2](uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)), uint(3)*uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }

    uint e[24] = { eA[0].x,eA[0].y,eA[0].z,eA[0].w,eA[1].x,eA[1].y,eA[1].z,eA[1].w,eB[0].x,eB[0].y,eB[0].z,eB[0].w,eB[1].x,eB[1].y,eB[1].z,eB[1].w,eC[0].x,eC[0].y,eC[0].z,eC[0].w,eC[1].x,eC[1].y,eC[1].z,eC[1].w };

    uvec4 vA[2]; { vA = uvec4[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    uvec4 vB[2]; { vB = uvec4[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    uvec4 vC[2]; { vC = uvec4[2](data[pc.n[2]][0],data[pc.n[2]][1]); }

    uint v[24] = { vA[0].x,vA[0].y,vA[0].z,vA[0].w,vA[1].x,vA[1].y,vA[1].z,vA[1].w,vB[0].x,vB[0].y,vB[0].z,vB[0].w,vB[1].x,vB[1].y,vB[1].z,vB[1].w,vC[0].x,vC[0].y,vC[0].z,vC[0].w,vC[1].x,vC[1].y,vC[1].z,vC[1].w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<24; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) in vec4 dataIntrp;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec4 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    vec4 eA; { const int n = 1 + (4*p+1); eA = vec4(float(n), float(2*n), float(4*n), float(8*n)); }
    vec4 eB; { const int n = 1 + (4*p+2); eB = vec4(float(n), float(2*n), float(4*n), float(8*n)); }
    vec4 eC; { const int n = 1 + (4*p+2); eC = vec4(float(n), float(2*n), float(4*n), float(8*n)); }

    float e[12] = { eA.x,eA.y,eA.z,eA.w,eB.x,eB.y,eB.z,eB.w,eC.x,eC.y,eC.z,eC.w };
    vec4 eIntrpV; {eIntrpV = vec4(eA * gl_BaryCoordEXT.x + eB * gl_BaryCoordEXT.y + eC * gl_BaryCoordEXT.z); }
    float eIntrp[12 / 3] = { eIntrpV.x,eIntrpV.y,eIntrpV.z,eIntrpV.w };

    vec4 vA; { vA = data[pc.n[0]]; }
    vec4 vB; { vB = data[pc.n[1]]; }
    vec4 vC; { vC = data[pc.n[2]]; }
    vec4 vIntrpV; { vIntrpV = dataIntrp; }
    float vIntrp[12 / 3] = { vIntrpV.x,vIntrpV.y,vIntrpV.z,vIntrpV.w };

    float v[12] = { vA.x,vA.y,vA.z,vA.w,vB.x,vB.y,vB.z,vB.w,vC.x,vC.y,vC.z,vC.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<12 / 3; i++)
        if (abs(eIntrp[i] - vIntrp[i]) < 0.001)
            mask.y = mask.y | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 2) flat in dvec4 dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec4 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    dvec4 eA; { const int n = 1 + (4*p+1); eA = dvec4(double(n), double(2*n), double(4*n), double(8*n)); }
    dvec4 eB; { const int n = 1 + (4*p+2); eB = dvec4(double(n), double(2*n), double(4*n), double(8*n)); }
    dvec4 eC; { const int n = 1 + (4*p+2); eC = dvec4(double(n), double(2*n), double(4*n), double(8*n)); }

    double e[12] = { eA.x,eA.y,eA.z,eA.w,eB.x,eB.y,eB.z,eB.w,eC.x,eC.y,eC.z,eC.w };
    dvec4 eFlatV; { const int n = 1 + (4*p+1); eFlatV = dvec4(double(n), double(2*n), double(4*n), double(8*n)); }
    double eFlat[12 / 3] = { eFlatV.x,eFlatV.y,eFlatV.z,eFlatV.w };

    dvec4 vA; { vA = data[pc.n[0]]; }
    dvec4 vB; { vB = data[pc.n[1]]; }
    dvec4 vC; { vC = data[pc.n[2]]; }
    dvec4 vFlatV; { vFlatV = dataFlat; }
    double vFlat[12 / 3] = { vFlatV.x,vFlatV.y,vFlatV.z,vFlatV.w};

    double v[12] = { vA.x,vA.y,vA.z,vA.w,vB.x,vB.y,vB.z,vB.w,vC.x,vC.y,vC.z,vC.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<12 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) flat in int dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in int data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    int eA; { const int n = 1 + (4*p+1); eA = int(n); }
    int eB; { const int n = 1 + (4*p+2); eB = int(n); }
    int eC; { const int n = 1 + (4*p+2); eC = int(n); }

    int e[3] = { eA,eB,eC };
    int eFlatV; { const int n = 1 + (4*p+1); eFlatV = int(n); }
    int eFlat[3 / 3] = { eFlatV };

    int vA; { vA = data[pc.n[0]]; }
    int vB; { vB = data[pc.n[1]]; }
    int vC; { vC = data[pc.n[2]]; }
    int vFlatV; { vFlatV = dataFlat; }
    int vFlat[3 / 3] = { vFlatV};

    int v[3] = { vA,vB,vC };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<3 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in ivec4 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    ivec4 eA; { const int n = 1 + (4*p+1); eA = ivec4(int(n), int(2*n), int(4*n), int(8*n)); }
    ivec4 eB; { const int n = 1 + (4*p+2); eB = ivec4(int(n), int(2*n), int(4*n), int(8*n)); }
    ivec4 eC; { const int n = 1 + (4*p+2); eC = ivec4(int(n), int(2*n), int(4*n), int(8*n)); }

    int e[12] = { eA.x,eA.y,eA.z,eA.w,eB.x,eB.y,eB.z,eB.w,eC.x,eC.y,eC.z,eC.w };

    ivec4 vA; { vA = data[pc.n[0]]; }
    ivec4 vB; { vB = data[pc.n[1]]; }
    ivec4 vC; { vC = data[pc.n[2]]; }

    int v[12] = { vA.x,vA.y,vA.z,vA.w,vB.x,vB.y,vB.z,vB.w,vC.x,vC.y,vC.z,vC.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) flat in uvec2 dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uvec2 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    uvec2 eA; { const int n = 1 + (4*p+1); eA = uvec2(uint(n), uint(2*n)); }
    uvec2 eB; { const int n = 1 + (4*p+2); eB = uvec2(uint(n), uint(2*n)); }
    uvec2 eC; { const int n = 1 + (4*p+2); eC = uvec2(uint(n), uint(2*n)); }

    uint e[6] = { eA.x,eA.y,eB.x,eB.y,eC.x,eC.y };
    uvec2 eFlatV; { const int n = 1 + (4*p+1); eFlatV = uvec2(uint(n), uint(2*n)); }
    uint eFlat[6 / 3] = { eFlatV.x,eFlatV.y };

    uvec2 vA; { vA = data[pc.n[0]]; }
    uvec2 vB; { vB = data[pc.n[1]]; }
    uvec2 vC; { vC = data[pc.n[2]]; }
    uvec2 vFlatV; { vFlatV = dataFlat; }
    uint vFlat[6 / 3] = { vFlatV.x,vFlatV.y};

    uint v[6] = { vA.x,vA.y,vB.x,vB.y,vC.x,vC.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {float q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (4*p+1); eA = DataStruct(float(n)); }
    DataStruct eB; { const int n = 1 + (4*p+2); eB = DataStruct(float(n)); }
    DataStruct eC; { const int n = 1 + (4*p+2); eC = DataStruct(float(n)); }

    float e[3] = { eA.q,eB.q,eC.q };
    DataStruct eFlatV; { const int n = 1 + (4*p+1); eFlatV = DataStruct(float(n)); }
    float eFlat[3 / 3] = { eFlatV.q };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    float vFlat[3 / 3] = { vFlatV.q};

    float v[3] = { vA.q,vB.q,vC.q };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<3 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec2 q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) in DataStruct dataIntrp;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (4*p+1); eA = DataStruct(vec2(float(n), float(2*n))); }
    DataStruct eB; { const int n = 1 + (4*p+2); eB = DataStruct(vec2(float(n), float(2*n))); }
    DataStruct eC; { const int n = 1 + (4*p+2); eC = DataStruct(vec2(float(n), float(2*n))); }

    float e[6] = { eA.q.x,eA.q.y,eB.q.x,eB.q.y,eC.q.x,eC.q.y };
    DataStruct eIntrpV; {eIntrpV = DataStruct(eA.q * gl_BaryCoordEXT.x + eB.q * gl_BaryCoordEXT.y + eC.q * gl_BaryCoordEXT.z); }
    float eIntrp[6 / 3] = { eIntrpV.q.x,eIntrpV.q.y };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }
    DataStruct vIntrpV; { vIntrpV = dataIntrp; }
    float vIntrp[6 / 3] = { vIntrpV.q.x,vIntrpV.q.y };

    float v[6] = { vA.q.x,vA.q.y,vB.q.x,vB.q.y,vC.q.x,vC.q.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (abs(eIntrp[i] - vIntrp[i]) < 0.001)
            mask.y = mask.y | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec3 q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (4*p+1); eA = DataStruct(vec3(float(n), float(2*n), float(4*n))); }
    DataStruct eB; { const int n = 1 + (4*p+2); eB = DataStruct(vec3(float(n), float(2*n), float(4*n))); }
    DataStruct eC; { const int n = 1 + (4*p+2); eC = DataStruct(vec3(float(n), float(2*n), float(4*n))); }

    float e[9] = { eA.q.x,eA.q.y,eA.q.z,eB.q.x,eB.q.y,eB.q.z,eC.q.x,eC.q.y,eC.q.z };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }

    float v[9] = { vA.q.x,vA.q.y,vA.q.z,vB.q.x,vB.q.y,vB.q.z,vC.q.x,vC.q.y,vC.q.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec3 q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) in DataStruct dataIntrp;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (4*p+1); eA = DataStruct(vec3(float(n), float(2*n), float(4*n))); }
    DataStruct eB; { const int n = 1 + (4*p+2); eB = DataStruct(vec3(float(n), float(2*n), float(4*n))); }
    DataStruct eC; { const int n = 1 + (4*p+2); eC = DataStruct(vec3(float(n), float(2*n), float(4*n))); }

    float e[9] = { eA.q.x,eA.q.y,eA.q.z,eB.q.x,eB.q.y,eB.q.z,eC.q.x,eC.q.y,eC.q.z };
    DataStruct eIntrpV; {eIntrpV = DataStruct(eA.q * gl_BaryCoordEXT.x + eB.q * gl_BaryCoordEXT.y + eC.q * gl_BaryCoordEXT.z); }
    float eIntrp[9 / 3] = { eIntrpV.q.x,eIntrpV.q.y,eIntrpV.q.z };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }
    DataStruct vIntrpV; { vIntrpV = dataIntrp; }
    float vIntrp[9 / 3] = { vIntrpV.q.x,vIntrpV.q.y,vIntrpV.q.z };

    float v[9] = { vA.q.x,vA.q.y,vA.q.z,vB.q.x,vB.q.y,vB.q.z,vC.q.x,vC.q.y,vC.q.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<9 / 3; i++)
        if (abs(eIntrp[i] - vIntrp[i]) < 0.001)
            mask.y = mask.y | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec3 q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (4*p+1); eA = DataStruct(vec3(float(n), float(2*n), float(4*n))); }
    DataStruct eB; { const int n = 1 + (4*p+2); eB = DataStruct(vec3(float(n), float(2*n), float(4*n))); }
    DataStruct eC; { const int n = 1 + (4*p+2); eC = DataStruct(vec3(float(n), float(2*n), float(4*n))); }

    float e[9] = { eA.q.x,eA.q.y,eA.q.z,eB.q.x,eB.q.y,eB.q.z,eC.q.x,eC.q.y,eC.q.z };
    DataStruct eFlatV; { const int n = 1 + (4*p+1); eFlatV = DataStruct(vec3(float(n), float(2*n), float(4*n))); }
    float eFlat[9 / 3] = { eFlatV.q.x,eFlatV.q.y,eFlatV.q.z };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    float vFlat[9 / 3] = { vFlatV.q.x,vFlatV.q.y,vFlatV.q.z};

    float v[9] = { vA.q.x,vA.q.y,vA.q.z,vB.q.x,vB.q.y,vB.q.z,vC.q.x,vC.q.y,vC.q.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<9 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {int q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (4*p+1); eA = DataStruct(int(n)); }
    DataStruct eB; { const int n = 1 + (4*p+2); eB = DataStruct(int(n)); }
    DataStruct eC; { const int n = 1 + (4*p+2); eC = DataStruct(int(n)); }

    int e[3] = { eA.q,eB.q,eC.q };
    DataStruct eFlatV; { const int n = 1 + (4*p+1); eFlatV = DataStruct(int(n)); }
    int eFlat[3 / 3] = { eFlatV.q };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    int vFlat[3 / 3] = { vFlatV.q};

    int v[3] = { vA.q,vB.q,vC.q };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<3 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {ivec2 q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (4*p+1); eA = DataStruct(ivec2(int(n), int(2*n))); }
    DataStruct eB; { const int n = 1 + (4*p+2); eB = DataStruct(ivec2(int(n), int(2*n))); }
    DataStruct eC; { const int n = 1 + (4*p+2); eC = DataStruct(ivec2(int(n), int(2*n))); }

    int e[6] = { eA.q.x,eA.q.y,eB.q.x,eB.q.y,eC.q.x,eC.q.y };
    DataStruct eFlatV; { const int n = 1 + (4*p+1); eFlatV = DataStruct(ivec2(int(n), int(2*n))); }
    int eFlat[6 / 3] = { eFlatV.q.x,eFlatV.q.y };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    int vFlat[6 / 3] = { vFlatV.q.x,vFlatV.q.y};

    int v[6] = { vA.q.x,vA.q.y,vB.q.x,vB.q.y,vC.q.x,vC.q.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 2) flat in vec2 dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec2 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    vec2 eA[2]; { const int n = 1 + (4*p+1); eA = vec2[2](vec2(float(n), float(2*n)), float(3)*vec2(float(n), float(2*n))); }
    vec2 eB[2]; { const int n = 1 + (4*p+2); eB = vec2[2](vec2(float(n), float(2*n)), float(3)*vec2(float(n), float(2*n))); }
    vec2 eC[2]; { const int n = 1 + (4*p+2); eC = vec2[2](vec2(float(n), float(2*n)), float(3)*vec2(float(n), float(2*n))); }

    float e[12] = { eA[0].x,eA[0].y,eA[1].x,eA[1].y,eB[0].x,eB[0].y,eB[1].x,eB[1].y,eC[0].x,eC[0].y,eC[1].x,eC[1].y };
    vec2 eFlatV[2]; { const int n = 1 + (4*p+1); eFlatV = vec2[2](vec2(float(n), float(2*n)), float(3)*vec2(float(n), float(2*n))); }
    float eFlat[12 / 3] = { eFlatV[0].x,eFlatV[0].y,eFlatV[1].x,eFlatV[1].y };

    vec2 vA[2]; { vA = vec2[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    vec2 vB[2]; { vB = vec2[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    vec2 vC[2]; { vC = vec2[2](data[pc.n[2]][0],data[pc.n[2]][1]); }
    vec2 vFlatV[2]; { vFlatV = vec2[2](dataFlat[0],dataFlat[1]); }
    float vFlat[12 / 3] = { vFlatV[0].x,vFlatV[0].y,vFlatV[1].x,vFlatV[1].y};

    float v[12] = { vA[0].x,vA[0].y,vA[1].x,vA[1].y,vB[0].x,vB[0].y,vB[1].x,vB[1].y,vC[0].x,vC[0].y,vC[1].x,vC[1].y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<12 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 2) in vec4 dataIntrp[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec4 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    vec4 eA[2]; { const int n = 1 + (4*p+1); eA = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    vec4 eB[2]; { const int n = 1 + (4*p+2); eB = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    vec4 eC[2]; { const int n = 1 + (4*p+2); eC = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n))); }

    float e[24] = { eA[0].x,eA[0].y,eA[0].z,eA[0].w,eA[1].x,eA[1].y,eA[1].z,eA[1].w,eB[0].x,eB[0].y,eB[0].z,eB[0].w,eB[1].x,eB[1].y,eB[1].z,eB[1].w,eC[0].x,eC[0].y,eC[0].z,eC[0].w,eC[1].x,eC[1].y,eC[1].z,eC[1].w };
    vec4 eIntrpV[2]; {eIntrpV = vec4[2](eA[0] * gl_BaryCoordEXT.x + eB[0] * gl_BaryCoordEXT.y + eC[0] * gl_BaryCoordEXT.z, eA[1] * gl_BaryCoordEXT.x + eB[1] * gl_BaryCoordEXT.y + eC[1] * gl_BaryCoordEXT.z); }
    float eIntrp[24 / 3] = { eIntrpV[0].x,eIntrpV[0].y,eIntrpV[0].z,eIntrpV[0].w,eIntrpV[1].x,eIntrpV[1].y,eIntrpV[1].z,eIntrpV[1].w };

    vec4 vA[2]; { vA = vec4[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    vec4 vB[2]; { vB = vec4[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    vec4 vC[2]; { vC = vec4[2](data[pc.n[2]][0],data[pc.n[2]][1]); }
    vec4 vIntrpV[2]; { vIntrpV = vec4[2](dataIntrp[0],dataIntrp[1]); }
    float vIntrp[24 / 3] = { vIntrpV[0].x,vIntrpV[0].y,vIntrpV[0].z,vIntrpV[0].w,vIntrpV[1].x,vIntrpV[1].y,vIntrpV[1].z,vIntrpV[1].w };

    float v[24] = { vA[0].x,vA[0].y,vA[0].z,vA[0].w,vA[1].x,vA[1].y,vA[1].z,vA[1].w,vB[0].x,vB[0].y,vB[0].z,vB[0].w,vB[1].x,vB[1].y,vB[1].z,vB[1].w,vC[0].x,vC[0].y,vC[0].z,vC[0].w,vC[1].x,vC[1].y,vC[1].z,vC[1].w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<24; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<24 / 3; i++)
        if (abs(eIntrp[i] - vIntrp[i]) < 0.001)
            mask.y = mask.y | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in ivec2 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    ivec2 eA[2]; { const int n = 1 + (4*p+1); eA = ivec2[2](ivec2(int(n), int(2*n)), int(3)*ivec2(int(n), int(2*n))); }
    ivec2 eB[2]; { const int n = 1 + (4*p+2); eB = ivec2[2](ivec2(int(n), int(2*n)), int(3)*ivec2(int(n), int(2*n))); }
    ivec2 eC[2]; { const int n = 1 + (4*p+2); eC = ivec2[2](ivec2(int(n), int(2*n)), int(3)*ivec2(int(n), int(2*n))); }

    int e[12] = { eA[0].x,eA[0].y,eA[1].x,eA[1].y,eB[0].x,eB[0].y,eB[1].x,eB[1].y,eC[0].x,eC[0].y,eC[1].x,eC[1].y };

    ivec2 vA[2]; { vA = ivec2[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    ivec2 vB[2]; { vB = ivec2[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    ivec2 vC[2]; { vC = ivec2[2](data[pc.n[2]][0],data[pc.n[2]][1]); }

    int v[12] = { vA[0].x,vA[0].y,vA[1].x,vA[1].y,vB[0].x,vB[0].y,vB[1].x,vB[1].y,vC[0].x,vC[0].y,vC[1].x,vC[1].y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 2) flat in ivec3 dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in ivec3 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    ivec3 eA[2]; { const int n = 1 + (4*p+1); eA = ivec3[2](ivec3(int(n), int(2*n), int(4*n)), int(3)*ivec3(int(n), int(2*n), int(4*n))); }
    ivec3 eB[2]; { const int n = 1 + (4*p+2); eB = ivec3[2](ivec3(int(n), int(2*n), int(4*n)), int(3)*ivec3(int(n), int(2*n), int(4*n))); }
    ivec3 eC[2]; { const int n = 1 + (4*p+2); eC = ivec3[2](ivec3(int(n), int(2*n), int(4*n)), int(3)*ivec3(int(n), int(2*n), int(4*n))); }

    int e[18] = { eA[0].x,eA[0].y,eA[0].z,eA[1].x,eA[1].y,eA[1].z,eB[0].x,eB[0].y,eB[0].z,eB[1].x,eB[1].y,eB[1].z,eC[0].x,eC[0].y,eC[0].z,eC[1].x,eC[1].y,eC[1].z };
    ivec3 eFlatV[2]; { const int n = 1 + (4*p+1); eFlatV = ivec3[2](ivec3(int(n), int(2*n), int(4*n)), int(3)*ivec3(int(n), int(2*n), int(4*n))); }
    int eFlat[18 / 3] = { eFlatV[0].x,eFlatV[0].y,eFlatV[0].z,eFlatV[1].x,eFlatV[1].y,eFlatV[1].z };

    ivec3 vA[2]; { vA = ivec3[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    ivec3 vB[2]; { vB = ivec3[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    ivec3 vC[2]; { vC = ivec3[2](data[pc.n[2]][0],data[pc.n[2]][1]); }
    ivec3 vFlatV[2]; { vFlatV = ivec3[2](dataFlat[0],dataFlat[1]); }
    int vFlat[18 / 3] = { vFlatV[0].x,vFlatV[0].y,vFlatV[0].z,vFlatV[1].x,vFlatV[1].y,vFlatV[1].z};

    int v[18] = { vA[0].x,vA[0].y,vA[0].z,vA[1].x,vA[1].y,vA[1].z,vB[0].x,vB[0].y,vB[0].z,vB[1].x,vB[1].y,vB[1].z,vC[0].x,vC[0].y,vC[0].z,vC[1].x,vC[1].y,vC[1].z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<18; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<18 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uint data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = y;
    const bool even = (p%2 == 0);

    uint eA[2]; { const int n = 1 + (4*p+1); eA = uint[2](uint(n), uint(3)*uint(n)); }
    uint eB[2]; { const int n = 1 + (4*p+2); eB = uint[2](uint(n), uint(3)*uint(n)); }
    uint eC[2]; { const int n = 1 + (4*p+2); eC = uint[2](uint(n), uint(3)*uint(n)); }

    uint e[6] = { eA[0],eA[1],eB[0],eB[1],eC[0],eC[1] };

    uint vA[2]; { vA = uint[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    uint vB[2]; { vB = uint[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    uint vC[2]; { vC = uint[2](data[pc.n[2]][0],data[pc.n[2]][1]); }

    uint v[6] = { vA[0],vA[1],vB[0],vB[1],vC[0],vC[1] };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) in vec2 dataIntrp;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec2 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = 2*y;
    const bool even = (p%2 == 0);

    vec2 eA; { const int n = 1 + (p+1); eA = vec2(float(n), float(2*n)); }
    vec2 eB; { const int n = 1 + (p+2); eB = vec2(float(n), float(2*n)); }
    vec2 eC; { const int n = 1 + (p+2); eC = vec2(float(n), float(2*n)); }

    float e[6] = { eA.x,eA.y,eB.x,eB.y,eC.x,eC.y };
    vec2 eIntrpV; {eIntrpV = vec2(eA * gl_BaryCoordEXT.x + eB * gl_BaryCoordEXT.y + eC * gl_BaryCoordEXT.z); }
    float eIntrp[6 / 3] = { eIntrpV.x,eIntrpV.y };

    vec2 vA; { vA = data[pc.n[0]]; }
    vec2 vB; { vB = data[pc.n[1]]; }
    vec2 vC; { vC = data[pc.n[2]]; }
    vec2 vIntrpV; { vIntrpV = dataIntrp; }
    float vIntrp[6 / 3] = { vIntrpV.x,vIntrpV.y };

    float v[6] = { vA.x,vA.y,vB.x,vB.y,vC.x,vC.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (abs(eIntrp[i] - vIntrp[i]) < 0.001)
            mask.y = mask.y | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) in vec3 dataIntrp;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec3 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = 2*y;
    const bool even = (p%2 == 0);

    vec3 eA; { const int n = 1 + (p+1); eA = vec3(float(n), float(2*n), float(4*n)); }
    vec3 eB; { const int n = 1 + (p+2); eB = vec3(float(n), float(2*n), float(4*n)); }
    vec3 eC; { const int n = 1 + (p+2); eC = vec3(float(n), float(2*n), float(4*n)); }

    float e[9] = { eA.x,eA.y,eA.z,eB.x,eB.y,eB.z,eC.x,eC.y,eC.z };
    vec3 eIntrpV; {eIntrpV = vec3(eA * gl_BaryCoordEXT.x + eB * gl_BaryCoordEXT.y + eC * gl_BaryCoordEXT.z); }
    float eIntrp[9 / 3] = { eIntrpV.x,eIntrpV.y,eIntrpV.z };

    vec3 vA; { vA = data[pc.n[0]]; }
    vec3 vB; { vB = data[pc.n[1]]; }
    vec3 vC; { vC = data[pc.n[2]]; }
    vec3 vIntrpV; { vIntrpV = dataIntrp; }
    float vIntrp[9 / 3] = { vIntrpV.x,vIntrpV.y,vIntrpV.z };

    float v[9] = { vA.x,vA.y,vA.z,vB.x,vB.y,vB.z,vC.x,vC.y,vC.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<9 / 3; i++)
        if (abs(eIntrp[i] - vIntrp[i]) < 0.001)
            mask.y = mask.y | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 2) flat in dvec3 dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec3 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = 2*y;
    const bool even = (p%2 == 0);

    dvec3 eA; { const int n = 1 + (p+1); eA = dvec3(double(n), double(2*n), double(4*n)); }
    dvec3 eB; { const int n = 1 + (p+2); eB = dvec3(double(n), double(2*n), double(4*n)); }
    dvec3 eC; { const int n = 1 + (p+2); eC = dvec3(double(n), double(2*n), double(4*n)); }

    double e[9] = { eA.x,eA.y,eA.z,eB.x,eB.y,eB.z,eC.x,eC.y,eC.z };
    dvec3 eFlatV; { const int n = 1 + (p+1); eFlatV = dvec3(double(n), double(2*n), double(4*n)); }
    double eFlat[9 / 3] = { eFlatV.x,eFlatV.y,eFlatV.z };

    dvec3 vA; { vA = data[pc.n[0]]; }
    dvec3 vB; { vB = data[pc.n[1]]; }
    dvec3 vC; { vC = data[pc.n[2]]; }
    dvec3 vFlatV; { vFlatV = dataFlat; }
    double vFlat[9 / 3] = { vFlatV.x,vFlatV.y,vFlatV.z};

    double v[9] = { vA.x,vA.y,vA.z,vB.x,vB.y,vB.z,vC.x,vC.y,vC.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<9 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec4 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = 2*y;
    const bool even = (p%2 == 0);

    dvec4 eA; { const int n = 1 + (p+1); eA = dvec4(double(n), double(2*n), double(4*n), double(8*n)); }
    dvec4 eB; { const int n = 1 + (p+2); eB = dvec4(double(n), double(2*n), double(4*n), double(8*n)); }
    dvec4 eC; { const int n = 1 + (p+2); eC = dvec4(double(n), double(2*n), double(4*n), double(8*n)); }

    double e[12] = { eA.x,eA.y,eA.z,eA.w,eB.x,eB.y,eB.z,eB.w,eC.x,eC.y,eC.z,eC.w };

    dvec4 vA; { vA = data[pc.n[0]]; }
    dvec4 vB; { vB = data[pc.n[1]]; }
    dvec4 vC; { vC = data[pc.n[2]]; }

    double v[12] = { vA.x,vA.y,vA.z,vA.w,vB.x,vB.y,vB.z,vB.w,vC.x,vC.y,vC.z,vC.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uint data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = 2*y;
    const bool even = (p%2 == 0);

    uint eA; { const int n = 1 + (p+1); eA = uint(n); }
    uint eB; { const int n = 1 + (p+2); eB = uint(n); }
    uint eC; { const int n = 1 + (p+2); eC = uint(n); }

    uint e[3] = { eA,eB,eC };

    uint vA; { vA = data[pc.n[0]]; }
    uint vB; { vB = data[pc.n[1]]; }
    uint vC; { vC = data[pc.n[2]]; }

    uint v[3] = { vA,vB,vC };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uvec3 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = 2*y;
    const bool even = (p%2 == 0);

    uvec3 eA; { const int n = 1 + (p+1); eA = uvec3(uint(n), uint(2*n), uint(4*n)); }
    uvec3 eB; { const int n = 1 + (p+2); eB = uvec3(uint(n), uint(2*n), uint(4*n)); }
    uvec3 eC; { const int n = 1 + (p+2); eC = uvec3(uint(n), uint(2*n), uint(4*n)); }

    uint e[9] = { eA.x,eA.y,eA.z,eB.x,eB.y,eB.z,eC.x,eC.y,eC.z };

    uvec3 vA; { vA = data[pc.n[0]]; }
    uvec3 vB; { vB = data[pc.n[1]]; }
    uvec3 vC; { vC = data[pc.n[2]]; }

    uint v[9] = { vA.x,vA.y,vA.z,vB.x,vB.y,vB.z,vC.x,vC.y,vC.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec2 q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = 2*y;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (p+1); eA = DataStruct(vec2(float(n), float(2*n))); }
    DataStruct eB; { const int n = 1 + (p+2); eB = DataStruct(vec2(float(n), float(2*n))); }
    DataStruct eC; { const int n = 1 + (p+2); eC = DataStruct(vec2(float(n), float(2*n))); }

    float e[6] = { eA.q.x,eA.q.y,eB.q.x,eB.q.y,eC.q.x,eC.q.y };
    DataStruct eFlatV; { const int n = 1 + (p+1); eFlatV = DataStruct(vec2(float(n), float(2*n))); }
    float eFlat[6 / 3] = { eFlatV.q.x,eFlatV.q.y };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    float vFlat[6 / 3] = { vFlatV.q.x,vFlatV.q.y};

    float v[6] = { vA.q.x,vA.q.y,vB.q.x,vB.q.y,vC.q.x,vC.q.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {uvec3 q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = 2*y;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (p+1); eA = DataStruct(uvec3(uint(n), uint(2*n), uint(4*n))); }
    DataStruct eB; { const int n = 1 + (p+2); eB = DataStruct(uvec3(uint(n), uint(2*n), uint(4*n))); }
    DataStruct eC; { const int n = 1 + (p+2); eC = DataStruct(uvec3(uint(n), uint(2*n), uint(4*n))); }

    uint e[9] = { eA.q.x,eA.q.y,eA.q.z,eB.q.x,eB.q.y,eB.q.z,eC.q.x,eC.q.y,eC.q.z };
    DataStruct eFlatV; { const int n = 1 + (p+1); eFlatV = DataStruct(uvec3(uint(n), uint(2*n), uint(4*n))); }
    uint eFlat[9 / 3] = { eFlatV.q.x,eFlatV.q.y,eFlatV.q.z };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    uint vFlat[9 / 3] = { vFlatV.q.x,vFlatV.q.y,vFlatV.q.z};

    uint v[9] = { vA.q.x,vA.q.y,vA.q.z,vB.q.x,vB.q.y,vB.q.z,vC.q.x,vC.q.y,vC.q.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<9 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 2) flat in vec3 dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec3 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = 2*y;
    const bool even = (p%2 == 0);

    vec3 eA[2]; { const int n = 1 + (p+1); eA = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n))); }
    vec3 eB[2]; { const int n = 1 + (p+2); eB = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n))); }
    vec3 eC[2]; { const int n = 1 + (p+2); eC = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n))); }

    float e[18] = { eA[0].x,eA[0].y,eA[0].z,eA[1].x,eA[1].y,eA[1].z,eB[0].x,eB[0].y,eB[0].z,eB[1].x,eB[1].y,eB[1].z,eC[0].x,eC[0].y,eC[0].z,eC[1].x,eC[1].y,eC[1].z };
    vec3 eFlatV[2]; { const int n = 1 + (p+1); eFlatV = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n))); }
    float eFlat[18 / 3] = { eFlatV[0].x,eFlatV[0].y,eFlatV[0].z,eFlatV[1].x,eFlatV[1].y,eFlatV[1].z };

    vec3 vA[2]; { vA = vec3[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    vec3 vB[2]; { vB = vec3[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    vec3 vC[2]; { vC = vec3[2](data[pc.n[2]][0],data[pc.n[2]][1]); }
    vec3 vFlatV[2]; { vFlatV = vec3[2](dataFlat[0],dataFlat[1]); }
    float vFlat[18 / 3] = { vFlatV[0].x,vFlatV[0].y,vFlatV[0].z,vFlatV[1].x,vFlatV[1].y,vFlatV[1].z};

    float v[18] = { vA[0].x,vA[0].y,vA[0].z,vA[1].x,vA[1].y,vA[1].z,vB[0].x,vB[0].y,vB[0].z,vB[1].x,vB[1].y,vB[1].z,vC[0].x,vC[0].y,vC[0].z,vC[1].x,vC[1].y,vC[1].z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<18; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<18 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 4) flat in dvec4 dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec4 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = 2*y;
    const bool even = (p%2 == 0);

    dvec4 eA[2]; { const int n = 1 + (p+1); eA = dvec4[2](dvec4(double(n), double(2*n), double(4*n), double(8*n)), double(3)*dvec4(double(n), double(2*n), double(4*n), double(8*n))); }
    dvec4 eB[2]; { const int n = 1 + (p+2); eB = dvec4[2](dvec4(double(n), double(2*n), double(4*n), double(8*n)), double(3)*dvec4(double(n), double(2*n), double(4*n), double(8*n))); }
    dvec4 eC[2]; { const int n = 1 + (p+2); eC = dvec4[2](dvec4(double(n), double(2*n), double(4*n), double(8*n)), double(3)*dvec4(double(n), double(2*n), double(4*n), double(8*n))); }

    double e[24] = { eA[0].x,eA[0].y,eA[0].z,eA[0].w,eA[1].x,eA[1].y,eA[1].z,eA[1].w,eB[0].x,eB[0].y,eB[0].z,eB[0].w,eB[1].x,eB[1].y,eB[1].z,eB[1].w,eC[0].x,eC[0].y,eC[0].z,eC[0].w,eC[1].x,eC[1].y,eC[1].z,eC[1].w };
    dvec4 eFlatV[2]; { const int n = 1 + (p+1); eFlatV = dvec4[2](dvec4(double(n), double(2*n), double(4*n), double(8*n)), double(3)*dvec4(double(n), double(2*n), double(4*n), double(8*n))); }
    double eFlat[24 / 3] = { eFlatV[0].x,eFlatV[0].y,eFlatV[0].z,eFlatV[0].w,eFlatV[1].x,eFlatV[1].y,eFlatV[1].z,eFlatV[1].w };

    dvec4 vA[2]; { vA = dvec4[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    dvec4 vB[2]; { vB = dvec4[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    dvec4 vC[2]; { vC = dvec4[2](data[pc.n[2]][0],data[pc.n[2]][1]); }
    dvec4 vFlatV[2]; { vFlatV = dvec4[2](dataFlat[0],dataFlat[1]); }
    double vFlat[24 / 3] = { vFlatV[0].x,vFlatV[0].y,vFlatV[0].z,vFlatV[0].w,vFlatV[1].x,vFlatV[1].y,vFlatV[1].z,vFlatV[1].w};

    double v[24] = { vA[0].x,vA[0].y,vA[0].z,vA[0].w,vA[1].x,vA[1].y,vA[1].z,vA[1].w,vB[0].x,vB[0].y,vB[0].z,vB[0].w,vB[1].x,vB[1].y,vB[1].z,vB[1].w,vC[0].x,vC[0].y,vC[0].z,vC[0].w,vC[1].x,vC[1].y,vC[1].z,vC[1].w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<24; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<24 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 2) flat in int dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in int data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = 2*y;
    const bool even = (p%2 == 0);

    int eA[2]; { const int n = 1 + (p+1); eA = int[2](int(n), int(3)*int(n)); }
    int eB[2]; { const int n = 1 + (p+2); eB = int[2](int(n), int(3)*int(n)); }
    int eC[2]; { const int n = 1 + (p+2); eC = int[2](int(n), int(3)*int(n)); }

    int e[6] = { eA[0],eA[1],eB[0],eB[1],eC[0],eC[1] };
    int eFlatV[2]; { const int n = 1 + (p+1); eFlatV = int[2](int(n), int(3)*int(n)); }
    int eFlat[6 / 3] = { eFlatV[0],eFlatV[1] };

    int vA[2]; { vA = int[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    int vB[2]; { vB = int[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    int vC[2]; { vC = int[2](data[pc.n[2]][0],data[pc.n[2]][1]); }
    int vFlatV[2]; { vFlatV = int[2](dataFlat[0],dataFlat[1]); }
    int vFlat[6 / 3] = { vFlatV[0],vFlatV[1]};

    int v[6] = { vA[0],vA[1],vB[0],vB[1],vC[0],vC[1] };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in ivec2 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = 2*y;
    const bool even = (p%2 == 0);

    ivec2 eA[2]; { const int n = 1 + (p+1); eA = ivec2[2](ivec2(int(n), int(2*n)), int(3)*ivec2(int(n), int(2*n))); }
    ivec2 eB[2]; { const int n = 1 + (p+2); eB = ivec2[2](ivec2(int(n), int(2*n)), int(3)*ivec2(int(n), int(2*n))); }
    ivec2 eC[2]; { const int n = 1 + (p+2); eC = ivec2[2](ivec2(int(n), int(2*n)), int(3)*ivec2(int(n), int(2*n))); }

    int e[12] = { eA[0].x,eA[0].y,eA[1].x,eA[1].y,eB[0].x,eB[0].y,eB[1].x,eB[1].y,eC[0].x,eC[0].y,eC[1].x,eC[1].y };

    ivec2 vA[2]; { vA = ivec2[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    ivec2 vB[2]; { vB = ivec2[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    ivec2 vC[2]; { vC = ivec2[2](data[pc.n[2]][0],data[pc.n[2]][1]); }

    int v[12] = { vA[0].x,vA[0].y,vA[1].x,vA[1].y,vB[0].x,vB[0].y,vB[1].x,vB[1].y,vC[0].x,vC[0].y,vC[1].x,vC[1].y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 2) flat in uvec2 dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uvec2 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = 2*y;
    const bool even = (p%2 == 0);

    uvec2 eA[2]; { const int n = 1 + (p+1); eA = uvec2[2](uvec2(uint(n), uint(2*n)), uint(3)*uvec2(uint(n), uint(2*n))); }
    uvec2 eB[2]; { const int n = 1 + (p+2); eB = uvec2[2](uvec2(uint(n), uint(2*n)), uint(3)*uvec2(uint(n), uint(2*n))); }
    uvec2 eC[2]; { const int n = 1 + (p+2); eC = uvec2[2](uvec2(uint(n), uint(2*n)), uint(3)*uvec2(uint(n), uint(2*n))); }

    uint e[12] = { eA[0].x,eA[0].y,eA[1].x,eA[1].y,eB[0].x,eB[0].y,eB[1].x,eB[1].y,eC[0].x,eC[0].y,eC[1].x,eC[1].y };
    uvec2 eFlatV[2]; { const int n = 1 + (p+1); eFlatV = uvec2[2](uvec2(uint(n), uint(2*n)), uint(3)*uvec2(uint(n), uint(2*n))); }
    uint eFlat[12 / 3] = { eFlatV[0].x,eFlatV[0].y,eFlatV[1].x,eFlatV[1].y };

    uvec2 vA[2]; { vA = uvec2[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    uvec2 vB[2]; { vB = uvec2[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    uvec2 vC[2]; { vC = uvec2[2](data[pc.n[2]][0],data[pc.n[2]][1]); }
    uvec2 vFlatV[2]; { vFlatV = uvec2[2](dataFlat[0],dataFlat[1]); }
    uint vFlat[12 / 3] = { vFlatV[0].x,vFlatV[0].y,vFlatV[1].x,vFlatV[1].y};

    uint v[12] = { vA[0].x,vA[0].y,vA[1].x,vA[1].y,vB[0].x,vB[0].y,vB[1].x,vB[1].y,vC[0].x,vC[0].y,vC[1].x,vC[1].y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<12 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out vec3 data;
layout(location = 1) out vec3 dataFlat;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = vec3(float(n), float(2*n), float(4*n));
    dataFlat      = vec3(float(n), float(2*n), float(4*n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) flat in vec3 dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec3 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    vec3 eA; { const int n = 1 + (6*p); eA = vec3(float(n), float(2*n), float(4*n)); }
    vec3 eB; { const int n = 1 + (6*p+2); eB = vec3(float(n), float(2*n), float(4*n)); }
    vec3 eC; { const int n = 1 + (6*p+4); eC = vec3(float(n), float(2*n), float(4*n)); }

    float e[9] = { eA.x,eA.y,eA.z,eB.x,eB.y,eB.z,eC.x,eC.y,eC.z };
    vec3 eFlatV; { const int n = 1 + (6*p); eFlatV = vec3(float(n), float(2*n), float(4*n)); }
    float eFlat[9 / 3] = { eFlatV.x,eFlatV.y,eFlatV.z };

    vec3 vA; { vA = data[pc.n[0]]; }
    vec3 vB; { vB = data[pc.n[1]]; }
    vec3 vC; { vC = data[pc.n[2]]; }
    vec3 vFlatV; { vFlatV = dataFlat; }
    float vFlat[9 / 3] = { vFlatV.x,vFlatV.y,vFlatV.z};

    float v[9] = { vA.x,vA.y,vA.z,vB.x,vB.y,vB.z,vC.x,vC.y,vC.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<9 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 2) flat in dvec3 dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec3 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    dvec3 eA; { const int n = 1 + (6*p); eA = dvec3(double(n), double(2*n), double(4*n)); }
    dvec3 eB; { const int n = 1 + (6*p+2); eB = dvec3(double(n), double(2*n), double(4*n)); }
    dvec3 eC; { const int n = 1 + (6*p+4); eC = dvec3(double(n), double(2*n), double(4*n)); }

    double e[9] = { eA.x,eA.y,eA.z,eB.x,eB.y,eB.z,eC.x,eC.y,eC.z };
    dvec3 eFlatV; { const int n = 1 + (6*p); eFlatV = dvec3(double(n), double(2*n), double(4*n)); }
    double eFlat[9 / 3] = { eFlatV.x,eFlatV.y,eFlatV.z };

    dvec3 vA; { vA = data[pc.n[0]]; }
    dvec3 vB; { vB = data[pc.n[1]]; }
    dvec3 vC; { vC = data[pc.n[2]]; }
    dvec3 vFlatV; { vFlatV = dataFlat; }
    double vFlat[9 / 3] = { vFlatV.x,vFlatV.y,vFlatV.z};

    double v[9] = { vA.x,vA.y,vA.z,vB.x,vB.y,vB.z,vC.x,vC.y,vC.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<9 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uint data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    uint eA; { const int n = 1 + (6*p); eA = uint(n); }
    uint eB; { const int n = 1 + (6*p+2); eB = uint(n); }
    uint eC; { const int n = 1 + (6*p+4); eC = uint(n); }

    uint e[3] = { eA,eB,eC };

    uint vA; { vA = data[pc.n[0]]; }
    uint vB; { vB = data[pc.n[1]]; }
    uint vC; { vC = data[pc.n[2]]; }

    uint v[3] = { vA,vB,vC };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uvec2 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    uvec2 eA; { const int n = 1 + (6*p); eA = uvec2(uint(n), uint(2*n)); }
    uvec2 eB; { const int n = 1 + (6*p+2); eB = uvec2(uint(n), uint(2*n)); }
    uvec2 eC; { const int n = 1 + (6*p+4); eC = uvec2(uint(n), uint(2*n)); }

    uint e[6] = { eA.x,eA.y,eB.x,eB.y,eC.x,eC.y };

    uvec2 vA; { vA = data[pc.n[0]]; }
    uvec2 vB; { vB = data[pc.n[1]]; }
    uvec2 vC; { vC = data[pc.n[2]]; }

    uint v[6] = { vA.x,vA.y,vB.x,vB.y,vC.x,vC.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec2 q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (6*p); eA = DataStruct(vec2(float(n), float(2*n))); }
    DataStruct eB; { const int n = 1 + (6*p+2); eB = DataStruct(vec2(float(n), float(2*n))); }
    DataStruct eC; { const int n = 1 + (6*p+4); eC = DataStruct(vec2(float(n), float(2*n))); }

    float e[6] = { eA.q.x,eA.q.y,eB.q.x,eB.q.y,eC.q.x,eC.q.y };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }

    float v[6] = { vA.q.x,vA.q.y,vB.q.x,vB.q.y,vC.q.x,vC.q.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {dvec3 q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (6*p); eA = DataStruct(dvec3(double(n), double(2*n), double(4*n))); }
    DataStruct eB; { const int n = 1 + (6*p+2); eB = DataStruct(dvec3(double(n), double(2*n), double(4*n))); }
    DataStruct eC; { const int n = 1 + (6*p+4); eC = DataStruct(dvec3(double(n), double(2*n), double(4*n))); }

    double e[9] = { eA.q.x,eA.q.y,eA.q.z,eB.q.x,eB.q.y,eB.q.z,eC.q.x,eC.q.y,eC.q.z };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }

    double v[9] = { vA.q.x,vA.q.y,vA.q.z,vB.q.x,vB.q.y,vB.q.z,vC.q.x,vC.q.y,vC.q.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {uvec3 q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (6*p); eA = DataStruct(uvec3(uint(n), uint(2*n), uint(4*n))); }
    DataStruct eB; { const int n = 1 + (6*p+2); eB = DataStruct(uvec3(uint(n), uint(2*n), uint(4*n))); }
    DataStruct eC; { const int n = 1 + (6*p+4); eC = DataStruct(uvec3(uint(n), uint(2*n), uint(4*n))); }

    uint e[9] = { eA.q.x,eA.q.y,eA.q.z,eB.q.x,eB.q.y,eB.q.z,eC.q.x,eC.q.y,eC.q.z };
    DataStruct eFlatV; { const int n = 1 + (6*p); eFlatV = DataStruct(uvec3(uint(n), uint(2*n), uint(4*n))); }
    uint eFlat[9 / 3] = { eFlatV.q.x,eFlatV.q.y,eFlatV.q.z };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    uint vFlat[9 / 3] = { vFlatV.q.x,vFlatV.q.y,vFlatV.q.z};

    uint v[9] = { vA.q.x,vA.q.y,vA.q.z,vB.q.x,vB.q.y,vB.q.z,vC.q.x,vC.q.y,vC.q.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<9 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {uvec4 q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (6*p); eA = DataStruct(uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }
    DataStruct eB; { const int n = 1 + (6*p+2); eB = DataStruct(uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }
    DataStruct eC; { const int n = 1 + (6*p+4); eC = DataStruct(uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }

    uint e[12] = { eA.q.x,eA.q.y,eA.q.z,eA.q.w,eB.q.x,eB.q.y,eB.q.z,eB.q.w,eC.q.x,eC.q.y,eC.q.z,eC.q.w };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }

    uint v[12] = { vA.q.x,vA.q.y,vA.q.z,vA.q.w,vB.q.x,vB.q.y,vB.q.z,vB.q.w,vC.q.x,vC.q.y,vC.q.z,vC.q.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec4 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    vec4 eA[2]; { const int n = 1 + (6*p); eA = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    vec4 eB[2]; { const int n = 1 + (6*p+2); eB = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    vec4 eC[2]; { const int n = 1 + (6*p+4); eC = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n))); }

    float e[24] = { eA[0].x,eA[0].y,eA[0].z,eA[0].w,eA[1].x,eA[1].y,eA[1].z,eA[1].w,eB[0].x,eB[0].y,eB[0].z,eB[0].w,eB[1].x,eB[1].y,eB[1].z,eB[1].w,eC[0].x,eC[0].y,eC[0].z,eC[0].w,eC[1].x,eC[1].y,eC[1].z,eC[1].w };

    vec4 vA[2]; { vA = vec4[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    vec4 vB[2]; { vB = vec4[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    vec4 vC[2]; { vC = vec4[2](data[pc.n[2]][0],data[pc.n[2]][1]); }

    float v[24] = { vA[0].x,vA[0].y,vA[0].z,vA[0].w,vA[1].x,vA[1].y,vA[1].z,vA[1].w,vB[0].x,vB[0].y,vB[0].z,vB[0].w,vB[1].x,vB[1].y,vB[1].z,vB[1].w,vC[0].x,vC[0].y,vC[0].z,vC[0].w,vC[1].x,vC[1].y,vC[1].z,vC[1].w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<24; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec4 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    dvec4 eA[2]; { const int n = 1 + (6*p); eA = dvec4[2](dvec4(double(n), double(2*n), double(4*n), double(8*n)), double(3)*dvec4(double(n), double(2*n), double(4*n), double(8*n))); }
    dvec4 eB[2]; { const int n = 1 + (6*p+2); eB = dvec4[2](dvec4(double(n), double(2*n), double(4*n), double(8*n)), double(3)*dvec4(double(n), double(2*n), double(4*n), double(8*n))); }
    dvec4 eC[2]; { const int n = 1 + (6*p+4); eC = dvec4[2](dvec4(double(n), double(2*n), double(4*n), double(8*n)), double(3)*dvec4(double(n), double(2*n), double(4*n), double(8*n))); }

    double e[24] = { eA[0].x,eA[0].y,eA[0].z,eA[0].w,eA[1].x,eA[1].y,eA[1].z,eA[1].w,eB[0].x,eB[0].y,eB[0].z,eB[0].w,eB[1].x,eB[1].y,eB[1].z,eB[1].w,eC[0].x,eC[0].y,eC[0].z,eC[0].w,eC[1].x,eC[1].y,eC[1].z,eC[1].w };

    dvec4 vA[2]; { vA = dvec4[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    dvec4 vB[2]; { vB = dvec4[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    dvec4 vC[2]; { vC = dvec4[2](data[pc.n[2]][0],data[pc.n[2]][1]); }

    double v[24] = { vA[0].x,vA[0].y,vA[0].z,vA[0].w,vA[1].x,vA[1].y,vA[1].z,vA[1].w,vB[0].x,vB[0].y,vB[0].z,vB[0].w,vB[1].x,vB[1].y,vB[1].z,vB[1].w,vC[0].x,vC[0].y,vC[0].z,vC[0].w,vC[1].x,vC[1].y,vC[1].z,vC[1].w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<24; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 4) flat in dvec4 dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec4 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    dvec4 eA[2]; { const int n = 1 + (6*p); eA = dvec4[2](dvec4(double(n), double(2*n), double(4*n), double(8*n)), double(3)*dvec4(double(n), double(2*n), double(4*n), double(8*n))); }
    dvec4 eB[2]; { const int n = 1 + (6*p+2); eB = dvec4[2](dvec4(double(n), double(2*n), double(4*n), double(8*n)), double(3)*dvec4(double(n), double(2*n), double(4*n), double(8*n))); }
    dvec4 eC[2]; { const int n = 1 + (6*p+4); eC = dvec4[2](dvec4(double(n), double(2*n), double(4*n), double(8*n)), double(3)*dvec4(double(n), double(2*n), double(4*n), double(8*n))); }

    double e[24] = { eA[0].x,eA[0].y,eA[0].z,eA[0].w,eA[1].x,eA[1].y,eA[1].z,eA[1].w,eB[0].x,eB[0].y,eB[0].z,eB[0].w,eB[1].x,eB[1].y,eB[1].z,eB[1].w,eC[0].x,eC[0].y,eC[0].z,eC[0].w,eC[1].x,eC[1].y,eC[1].z,eC[1].w };
    dvec4 eFlatV[2]; { const int n = 1 + (6*p); eFlatV = dvec4[2](dvec4(double(n), double(2*n), double(4*n), double(8*n)), double(3)*dvec4(double(n), double(2*n), double(4*n), double(8*n))); }
    double eFlat[24 / 3] = { eFlatV[0].x,eFlatV[0].y,eFlatV[0].z,eFlatV[0].w,eFlatV[1].x,eFlatV[1].y,eFlatV[1].z,eFlatV[1].w };

    dvec4 vA[2]; { vA = dvec4[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    dvec4 vB[2]; { vB = dvec4[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    dvec4 vC[2]; { vC = dvec4[2](data[pc.n[2]][0],data[pc.n[2]][1]); }
    dvec4 vFlatV[2]; { vFlatV = dvec4[2](dataFlat[0],dataFlat[1]); }
    double vFlat[24 / 3] = { vFlatV[0].x,vFlatV[0].y,vFlatV[0].z,vFlatV[0].w,vFlatV[1].x,vFlatV[1].y,vFlatV[1].z,vFlatV[1].w};

    double v[24] = { vA[0].x,vA[0].y,vA[0].z,vA[0].w,vA[1].x,vA[1].y,vA[1].z,vA[1].w,vB[0].x,vB[0].y,vB[0].z,vB[0].w,vB[1].x,vB[1].y,vB[1].z,vB[1].w,vC[0].x,vC[0].y,vC[0].z,vC[0].w,vC[1].x,vC[1].y,vC[1].z,vC[1].w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<24; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<24 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 2) flat in int dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in int data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    int eA[2]; { const int n = 1 + (6*p); eA = int[2](int(n), int(3)*int(n)); }
    int eB[2]; { const int n = 1 + (6*p+2); eB = int[2](int(n), int(3)*int(n)); }
    int eC[2]; { const int n = 1 + (6*p+4); eC = int[2](int(n), int(3)*int(n)); }

    int e[6] = { eA[0],eA[1],eB[0],eB[1],eC[0],eC[1] };
    int eFlatV[2]; { const int n = 1 + (6*p); eFlatV = int[2](int(n), int(3)*int(n)); }
    int eFlat[6 / 3] = { eFlatV[0],eFlatV[1] };

    int vA[2]; { vA = int[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    int vB[2]; { vB = int[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    int vC[2]; { vC = int[2](data[pc.n[2]][0],data[pc.n[2]][1]); }
    int vFlatV[2]; { vFlatV = int[2](dataFlat[0],dataFlat[1]); }
    int vFlat[6 / 3] = { vFlatV[0],vFlatV[1]};

    int v[6] = { vA[0],vA[1],vB[0],vB[1],vC[0],vC[1] };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 2) flat in uvec2 dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uvec2 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    uvec2 eA[2]; { const int n = 1 + (6*p); eA = uvec2[2](uvec2(uint(n), uint(2*n)), uint(3)*uvec2(uint(n), uint(2*n))); }
    uvec2 eB[2]; { const int n = 1 + (6*p+2); eB = uvec2[2](uvec2(uint(n), uint(2*n)), uint(3)*uvec2(uint(n), uint(2*n))); }
    uvec2 eC[2]; { const int n = 1 + (6*p+4); eC = uvec2[2](uvec2(uint(n), uint(2*n)), uint(3)*uvec2(uint(n), uint(2*n))); }

    uint e[12] = { eA[0].x,eA[0].y,eA[1].x,eA[1].y,eB[0].x,eB[0].y,eB[1].x,eB[1].y,eC[0].x,eC[0].y,eC[1].x,eC[1].y };
    uvec2 eFlatV[2]; { const int n = 1 + (6*p); eFlatV = uvec2[2](uvec2(uint(n), uint(2*n)), uint(3)*uvec2(uint(n), uint(2*n))); }
    uint eFlat[12 / 3] = { eFlatV[0].x,eFlatV[0].y,eFlatV[1].x,eFlatV[1].y };

    uvec2 vA[2]; { vA = uvec2[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    uvec2 vB[2]; { vB = uvec2[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    uvec2 vC[2]; { vC = uvec2[2](data[pc.n[2]][0],data[pc.n[2]][1]); }
    uvec2 vFlatV[2]; { vFlatV = uvec2[2](dataFlat[0],dataFlat[1]); }
    uint vFlat[12 / 3] = { vFlatV[0].x,vFlatV[0].y,vFlatV[1].x,vFlatV[1].y};

    uint v[12] = { vA[0].x,vA[0].y,vA[1].x,vA[1].y,vB[0].x,vB[0].y,vB[1].x,vB[1].y,vC[0].x,vC[0].y,vC[1].x,vC[1].y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<12 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uvec3 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    uvec3 eA[2]; { const int n = 1 + (6*p); eA = uvec3[2](uvec3(uint(n), uint(2*n), uint(4*n)), uint(3)*uvec3(uint(n), uint(2*n), uint(4*n))); }
    uvec3 eB[2]; { const int n = 1 + (6*p+2); eB = uvec3[2](uvec3(uint(n), uint(2*n), uint(4*n)), uint(3)*uvec3(uint(n), uint(2*n), uint(4*n))); }
    uvec3 eC[2]; { const int n = 1 + (6*p+4); eC = uvec3[2](uvec3(uint(n), uint(2*n), uint(4*n)), uint(3)*uvec3(uint(n), uint(2*n), uint(4*n))); }

    uint e[18] = { eA[0].x,eA[0].y,eA[0].z,eA[1].x,eA[1].y,eA[1].z,eB[0].x,eB[0].y,eB[0].z,eB[1].x,eB[1].y,eB[1].z,eC[0].x,eC[0].y,eC[0].z,eC[1].x,eC[1].y,eC[1].z };

    uvec3 vA[2]; { vA = uvec3[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    uvec3 vB[2]; { vB = uvec3[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    uvec3 vC[2]; { vC = uvec3[2](data[pc.n[2]][0],data[pc.n[2]][1]); }

    uint v[18] = { vA[0].x,vA[0].y,vA[0].z,vA[1].x,vA[1].y,vA[1].z,vB[0].x,vB[0].y,vB[0].z,vB[1].x,vB[1].y,vB[1].z,vC[0].x,vC[0].y,vC[0].z,vC[1].x,vC[1].y,vC[1].z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<18; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) flat in ivec4 dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in ivec4 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    ivec4 eA; { const int n = 1 + (2*p); eA = ivec4(int(n), int(2*n), int(4*n), int(8*n)); }
    ivec4 eB; { const int n = 1 + (even?2*p+2:2*p+4); eB = ivec4(int(n), int(2*n), int(4*n), int(8*n)); }
    ivec4 eC; { const int n = 1 + (even?2*p+4:2*p+2); eC = ivec4(int(n), int(2*n), int(4*n), int(8*n)); }

    int e[12] = { eA.x,eA.y,eA.z,eA.w,eB.x,eB.y,eB.z,eB.w,eC.x,eC.y,eC.z,eC.w };
    ivec4 eFlatV; { const int n = 1 + (2*p); eFlatV = ivec4(int(n), int(2*n), int(4*n), int(8*n)); }
    int eFlat[12 / 3] = { eFlatV.x,eFlatV.y,eFlatV.z,eFlatV.w };

    ivec4 vA; { vA = data[pc.n[0]]; }
    ivec4 vB; { vB = data[pc.n[1]]; }
    ivec4 vC; { vC = data[pc.n[2]]; }
    ivec4 vFlatV; { vFlatV = dataFlat; }
    int vFlat[12 / 3] = { vFlatV.x,vFlatV.y,vFlatV.z,vFlatV.w};

    int v[12] = { vA.x,vA.y,vA.z,vA.w,vB.x,vB.y,vB.z,vB.w,vC.x,vC.y,vC.z,vC.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<12 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uvec2 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    uvec2 eA; { const int n = 1 + (2*p); eA = uvec2(uint(n), uint(2*n)); }
    uvec2 eB; { const int n = 1 + (even?2*p+2:2*p+4); eB = uvec2(uint(n), uint(2*n)); }
    uvec2 eC; { const int n = 1 + (even?2*p+4:2*p+2); eC = uvec2(uint(n), uint(2*n)); }

    uint e[6] = { eA.x,eA.y,eB.x,eB.y,eC.x,eC.y };

    uvec2 vA; { vA = data[pc.n[0]]; }
    uvec2 vB; { vB = data[pc.n[1]]; }
    uvec2 vC; { vC = data[pc.n[2]]; }

    uint v[6] = { vA.x,vA.y,vB.x,vB.y,vC.x,vC.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {float q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (2*p); eA = DataStruct(float(n)); }
    DataStruct eB; { const int n = 1 + (even?2*p+2:2*p+4); eB = DataStruct(float(n)); }
    DataStruct eC; { const int n = 1 + (even?2*p+4:2*p+2); eC = DataStruct(float(n)); }

    float e[3] = { eA.q,eB.q,eC.q };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }

    float v[3] = { vA.q,vB.q,vC.q };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec3 q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (2*p); eA = DataStruct(vec3(float(n), float(2*n), float(4*n))); }
    DataStruct eB; { const int n = 1 + (even?2*p+2:2*p+4); eB = DataStruct(vec3(float(n), float(2*n), float(4*n))); }
    DataStruct eC; { const int n = 1 + (even?2*p+4:2*p+2); eC = DataStruct(vec3(float(n), float(2*n), float(4*n))); }

    float e[9] = { eA.q.x,eA.q.y,eA.q.z,eB.q.x,eB.q.y,eB.q.z,eC.q.x,eC.q.y,eC.q.z };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }

    float v[9] = { vA.q.x,vA.q.y,vA.q.z,vB.q.x,vB.q.y,vB.q.z,vC.q.x,vC.q.y,vC.q.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {double q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 2) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (2*p); eA = DataStruct(double(n)); }
    DataStruct eB; { const int n = 1 + (even?2*p+2:2*p+4); eB = DataStruct(double(n)); }
    DataStruct eC; { const int n = 1 + (even?2*p+4:2*p+2); eC = DataStruct(double(n)); }

    double e[3] = { eA.q,eB.q,eC.q };
    DataStruct eFlatV; { const int n = 1 + (2*p); eFlatV = DataStruct(double(n)); }
    double eFlat[3 / 3] = { eFlatV.q };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    double vFlat[3 / 3] = { vFlatV.q};

    double v[3] = { vA.q,vB.q,vC.q };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<3 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {dvec2 q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (2*p); eA = DataStruct(dvec2(double(n), double(2*n))); }
    DataStruct eB; { const int n = 1 + (even?2*p+2:2*p+4); eB = DataStruct(dvec2(double(n), double(2*n))); }
    DataStruct eC; { const int n = 1 + (even?2*p+4:2*p+2); eC = DataStruct(dvec2(double(n), double(2*n))); }

    double e[6] = { eA.q.x,eA.q.y,eB.q.x,eB.q.y,eC.q.x,eC.q.y };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }

    double v[6] = { vA.q.x,vA.q.y,vB.q.x,vB.q.y,vC.q.x,vC.q.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {dvec2 q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 2) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (2*p); eA = DataStruct(dvec2(double(n), double(2*n))); }
    DataStruct eB; { const int n = 1 + (even?2*p+2:2*p+4); eB = DataStruct(dvec2(double(n), double(2*n))); }
    DataStruct eC; { const int n = 1 + (even?2*p+4:2*p+2); eC = DataStruct(dvec2(double(n), double(2*n))); }

    double e[6] = { eA.q.x,eA.q.y,eB.q.x,eB.q.y,eC.q.x,eC.q.y };
    DataStruct eFlatV; { const int n = 1 + (2*p); eFlatV = DataStruct(dvec2(double(n), double(2*n))); }
    double eFlat[6 / 3] = { eFlatV.q.x,eFlatV.q.y };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    double vFlat[6 / 3] = { vFlatV.q.x,vFlatV.q.y};

    double v[6] = { vA.q.x,vA.q.y,vB.q.x,vB.q.y,vC.q.x,vC.q.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<6 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {uvec4 q;};

layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 1) flat in DataStruct dataFlat;
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (2*p); eA = DataStruct(uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }
    DataStruct eB; { const int n = 1 + (even?2*p+2:2*p+4); eB = DataStruct(uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }
    DataStruct eC; { const int n = 1 + (even?2*p+4:2*p+2); eC = DataStruct(uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }

    uint e[12] = { eA.q.x,eA.q.y,eA.q.z,eA.q.w,eB.q.x,eB.q.y,eB.q.z,eB.q.w,eC.q.x,eC.q.y,eC.q.z,eC.q.w };
    DataStruct eFlatV; { const int n = 1 + (2*p); eFlatV = DataStruct(uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }
    uint eFlat[12 / 3] = { eFlatV.q.x,eFlatV.q.y,eFlatV.q.z,eFlatV.q.w };

    DataStruct vA; { vA = data[pc.n[0]]; }
    DataStruct vB; { vB = data[pc.n[1]]; }
    DataStruct vC; { vC = data[pc.n[2]]; }
    DataStruct vFlatV; { vFlatV = dataFlat; }
    uint vFlat[12 / 3] = { vFlatV.q.x,vFlatV.q.y,vFlatV.q.z,vFlatV.q.w};

    uint v[12] = { vA.q.x,vA.q.y,vA.q.z,vA.q.w,vB.q.x,vB.q.y,vB.q.z,vB.q.w,vC.q.x,vC.q.y,vC.q.z,vC.q.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<12 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 4) flat in dvec3 dataFlat[2];
layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec3 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    dvec3 eA[2]; { const int n = 1 + (2*p); eA = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n))); }
    dvec3 eB[2]; { const int n = 1 + (even?2*p+2:2*p+4); eB = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n))); }
    dvec3 eC[2]; { const int n = 1 + (even?2*p+4:2*p+2); eC = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n))); }

    double e[18] = { eA[0].x,eA[0].y,eA[0].z,eA[1].x,eA[1].y,eA[1].z,eB[0].x,eB[0].y,eB[0].z,eB[1].x,eB[1].y,eB[1].z,eC[0].x,eC[0].y,eC[0].z,eC[1].x,eC[1].y,eC[1].z };
    dvec3 eFlatV[2]; { const int n = 1 + (2*p); eFlatV = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n))); }
    double eFlat[18 / 3] = { eFlatV[0].x,eFlatV[0].y,eFlatV[0].z,eFlatV[1].x,eFlatV[1].y,eFlatV[1].z };

    dvec3 vA[2]; { vA = dvec3[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    dvec3 vB[2]; { vB = dvec3[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    dvec3 vC[2]; { vC = dvec3[2](data[pc.n[2]][0],data[pc.n[2]][1]); }
    dvec3 vFlatV[2]; { vFlatV = dvec3[2](dataFlat[0],dataFlat[1]); }
    double vFlat[18 / 3] = { vFlatV[0].x,vFlatV[0].y,vFlatV[0].z,vFlatV[1].x,vFlatV[1].y,vFlatV[1].z};

    double v[18] = { vA[0].x,vA[0].y,vA[0].z,vA[1].x,vA[1].y,vA[1].z,vB[0].x,vB[0].y,vB[0].z,vB[1].x,vB[1].y,vB[1].z,vC[0].x,vC[0].y,vC[0].z,vC[1].x,vC[1].y,vC[1].z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<18; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    for (int i = 0; i<18 / 3; i++)
        if (eFlat[i] == vFlat[i])
            mask.z = mask.z | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uint data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    uint eA[2]; { const int n = 1 + (2*p); eA = uint[2](uint(n), uint(3)*uint(n)); }
    uint eB[2]; { const int n = 1 + (even?2*p+2:2*p+4); eB = uint[2](uint(n), uint(3)*uint(n)); }
    uint eC[2]; { const int n = 1 + (even?2*p+4:2*p+2); eC = uint[2](uint(n), uint(3)*uint(n)); }

    uint e[6] = { eA[0],eA[1],eB[0],eB[1],eC[0],eC[1] };

    uint vA[2]; { vA = uint[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    uint vB[2]; { vB = uint[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    uint vC[2]; { vC = uint[2](data[pc.n[2]][0],data[pc.n[2]][1]); }

    uint v[6] = { vA[0],vA[1],vB[0],vB[1],vC[0],vC[1] };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(push_constant) uniform PushConstant { uint n[3]; } pc;

layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uvec2 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    uvec2 eA[2]; { const int n = 1 + (2*p); eA = uvec2[2](uvec2(uint(n), uint(2*n)), uint(3)*uvec2(uint(n), uint(2*n))); }
    uvec2 eB[2]; { const int n = 1 + (even?2*p+2:2*p+4); eB = uvec2[2](uvec2(uint(n), uint(2*n)), uint(3)*uvec2(uint(n), uint(2*n))); }
    uvec2 eC[2]; { const int n = 1 + (even?2*p+4:2*p+2); eC = uvec2[2](uvec2(uint(n), uint(2*n)), uint(3)*uvec2(uint(n), uint(2*n))); }

    uint e[12] = { eA[0].x,eA[0].y,eA[1].x,eA[1].y,eB[0].x,eB[0].y,eB[1].x,eB[1].y,eC[0].x,eC[0].y,eC[1].x,eC[1].y };

    uvec2 vA[2]; { vA = uvec2[2](data[pc.n[0]][0],data[pc.n[0]][1]); }
    uvec2 vB[2]; { vB = uvec2[2](data[pc.n[1]][0],data[pc.n[1]][1]); }
    uvec2 vC[2]; { vC = uvec2[2](data[pc.n[2]][0],data[pc.n[2]][1]); }

    uint v[12] = { vA[0].x,vA[0].y,vA[1].x,vA[1].y,vB[0].x,vB[0].y,vB[1].x,vB[1].y,vC[0].x,vC[0].y,vC[1].x,vC[1].y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
