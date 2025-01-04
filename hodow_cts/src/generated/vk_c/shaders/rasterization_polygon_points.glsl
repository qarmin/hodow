#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=6, local_size_y=1, local_size_z=1) in;
layout (triangles) out;
layout (max_vertices=6, max_primitives=2) out;

out gl_MeshPerVertexEXT {
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

layout (set=0, binding=0, std430) readonly buffer VertexData {
    vec4 vertices[];
} vertexBuffer;

void main (void) {
    SetMeshOutputsEXT(6, 2);
    gl_MeshVerticesEXT[gl_LocalInvocationIndex].gl_Position = vertexBuffer.vertices[gl_LocalInvocationIndex];
    gl_MeshVerticesEXT[gl_LocalInvocationIndex].gl_PointSize = 2.000000;
    if (gl_LocalInvocationIndex < 2) {
        const uint baseIndex = gl_LocalInvocationIndex * 3u;
        gl_PrimitiveTriangleIndicesEXT[gl_LocalInvocationIndex] = uvec3(baseIndex, baseIndex + 1u, baseIndex + 2u);
    }
}
#version 460
layout (location=0) out vec4 outColor;
void main (void) {
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
}
#version 460
layout (location=0) in vec4 inPosition;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void) {
    gl_Position  = inPosition;
    gl_PointSize = 2.000000;
}
#version 460
layout (vertices=3) out;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_out[];
void main (void) {
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelInner[1] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
  gl_TessLevelOuter[3] = 1.0;
  gl_out[gl_InvocationID].gl_Position  = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 460
layout (triangles, fractional_odd_spacing, cw) in;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void) {
    gl_Position  = (gl_TessCoord.x * gl_in[0].gl_Position) +
                   (gl_TessCoord.y * gl_in[1].gl_Position) +
                   (gl_TessCoord.z * gl_in[2].gl_Position);
    gl_PointSize = gl_in[0].gl_PointSize;
}
#version 460
layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void) {
    for (uint i = 0u; i < 3u; ++i) {
        gl_Position  = gl_in[i].gl_Position;
        gl_PointSize = gl_in[i].gl_PointSize;
        EmitVertex();
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=6, local_size_y=1, local_size_z=1) in;
layout (triangles) out;
layout (max_vertices=6, max_primitives=2) out;

out gl_MeshPerVertexEXT {
    vec4  gl_Position;
    float gl_PointSize;
} gl_MeshVerticesEXT[];

layout (set=0, binding=0, std430) readonly buffer VertexData {
    vec4 vertices[];
} vertexBuffer;

void main (void) {
    SetMeshOutputsEXT(6, 2);
    gl_MeshVerticesEXT[gl_LocalInvocationIndex].gl_Position = vertexBuffer.vertices[gl_LocalInvocationIndex];
    if (gl_LocalInvocationIndex < 2) {
        const uint baseIndex = gl_LocalInvocationIndex * 3u;
        gl_PrimitiveTriangleIndicesEXT[gl_LocalInvocationIndex] = uvec3(baseIndex, baseIndex + 1u, baseIndex + 2u);
    }
}
#version 460
layout (location=0) in vec4 inPosition;
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void) {
    gl_Position  = inPosition;
}
#version 460
layout (vertices=3) out;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_out[];
void main (void) {
  gl_TessLevelInner[0] = 1.0;
  gl_TessLevelInner[1] = 1.0;
  gl_TessLevelOuter[0] = 1.0;
  gl_TessLevelOuter[1] = 1.0;
  gl_TessLevelOuter[2] = 1.0;
  gl_TessLevelOuter[3] = 1.0;
  gl_out[gl_InvocationID].gl_Position  = gl_in[gl_InvocationID].gl_Position;
}
#version 460
layout (triangles, fractional_odd_spacing, cw) in;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void) {
    gl_Position  = (gl_TessCoord.x * gl_in[0].gl_Position) +
                   (gl_TessCoord.y * gl_in[1].gl_Position) +
                   (gl_TessCoord.z * gl_in[2].gl_Position);
}
#version 460
layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};
void main (void) {
    for (uint i = 0u; i < 3u; ++i) {
        gl_Position  = gl_in[i].gl_Position;
        EmitVertex();
    }
}
