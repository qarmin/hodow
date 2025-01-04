#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;

struct TaskData { uint value; }; taskPayloadSharedEXT TaskData td;

layout (set=0, binding=0) uniform UniformBuffer { uint value; } ub;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    td.value = 0u;
    if (pc.readVal > 0u) { td.value = ub.value; }
    EmitMeshTasksEXT(1u, 1u, 1u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

struct TaskData { uint value; }; taskPayloadSharedEXT TaskData td;
layout (location=0) out perprimitiveEXT uint primitiveValue[];


void main ()
{
    SetMeshOutputsEXT(3u, 1u);
    primitiveValue[0] = td.value;

    gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
    gl_MeshVerticesEXT[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (location=0) in perprimitiveEXT flat uint primitiveValue;
layout (location=0) out uvec4 outColor;


void main ()
{
    outColor = uvec4(primitiveValue, 0, 0, 0);
    uint readVal = 0u;
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;

struct TaskData { uint value; }; taskPayloadSharedEXT TaskData td;

void main ()
{
    td.value = 0u;
    EmitMeshTasksEXT(1u, 1u, 1u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (location=0) in perprimitiveEXT flat uint primitiveValue;
layout (location=0) out uvec4 outColor;

void main ()
{
    outColor = uvec4(primitiveValue, 0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

layout (location=0) out perprimitiveEXT uint primitiveValue[];

void main ()
{
    SetMeshOutputsEXT(3u, 1u);
    primitiveValue[0] = 0u;

    gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
    gl_MeshVerticesEXT[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

struct TaskData { uint value; }; taskPayloadSharedEXT TaskData td;
layout (location=0) out perprimitiveEXT uint primitiveValue[];

void main ()
{
    SetMeshOutputsEXT(3u, 1u);
    primitiveValue[0] = td.value;

    gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
    gl_MeshVerticesEXT[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;

struct TaskData { uint value; }; taskPayloadSharedEXT TaskData td;

layout (set=0, binding=0) readonly buffer StorageBuffer { uint value; } sb;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    td.value = 0u;
    if (pc.readVal > 0u) { td.value = sb.value; }
    EmitMeshTasksEXT(1u, 1u, 1u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

layout (location=0) out perprimitiveEXT uint primitiveValue[];

layout (set=0, binding=0) uniform UniformBuffer { uint value; } ub;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    SetMeshOutputsEXT(3u, 1u);
    if (pc.readVal > 0u) { primitiveValue[0] = ub.value; }

    gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
    gl_MeshVerticesEXT[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

layout (location=0) out perprimitiveEXT uint primitiveValue[];

layout (set=0, binding=0) readonly buffer StorageBuffer { uint value; } sb;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    SetMeshOutputsEXT(3u, 1u);
    if (pc.readVal > 0u) { primitiveValue[0] = sb.value; }

    gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
    gl_MeshVerticesEXT[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;

struct TaskData { uint value; }; taskPayloadSharedEXT TaskData td;

layout (set=0, binding=0, r32ui) readonly uniform uimage2D si;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    td.value = 0u;
    if (pc.readVal > 0u) { td.value = imageLoad(si, ivec2(0, 0)).x; }
    EmitMeshTasksEXT(1u, 1u, 1u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;

struct TaskData { uint value; }; taskPayloadSharedEXT TaskData td;

layout (set=0, binding=0) uniform usampler2D sampled;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    td.value = 0u;
    if (pc.readVal > 0u) { td.value = texture(sampled, vec2(0.5, 0.5)).x; }
    EmitMeshTasksEXT(1u, 1u, 1u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

layout (location=0) out perprimitiveEXT uint primitiveValue[];

layout (set=0, binding=0, r32ui) readonly uniform uimage2D si;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    SetMeshOutputsEXT(3u, 1u);
    if (pc.readVal > 0u) { primitiveValue[0] = imageLoad(si, ivec2(0, 0)).x; }

    gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
    gl_MeshVerticesEXT[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

layout (location=0) out perprimitiveEXT uint primitiveValue[];

layout (set=0, binding=0) uniform usampler2D sampled;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    SetMeshOutputsEXT(3u, 1u);
    if (pc.readVal > 0u) { primitiveValue[0] = texture(sampled, vec2(0.5, 0.5)).x; }

    gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
    gl_MeshVerticesEXT[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;

struct TaskData { uint value; }; taskPayloadSharedEXT TaskData td;

layout (set=0, binding=0) buffer StorageBuffer { uint value; } sb;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    td.value = 0u;
    if (pc.writeVal > 0u) { sb.value = 1628510156; }
    EmitMeshTasksEXT(1u, 1u, 1u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

layout (location=0) out perprimitiveEXT uint primitiveValue[];

layout (set=0, binding=0) buffer StorageBuffer { uint value; } sb;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    SetMeshOutputsEXT(3u, 1u);
    if (pc.readVal > 0u) { primitiveValue[0] = sb.value; }

    gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
    gl_MeshVerticesEXT[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;

struct TaskData { uint value; }; taskPayloadSharedEXT TaskData td;

layout (set=0, binding=0) buffer StorageBuffer { uint value; } sb;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    td.value = 0u;
    if (pc.writeVal > 0u) { sb.value = 1628510157; }
    EmitMeshTasksEXT(1u, 1u, 1u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;

struct TaskData { uint value; }; taskPayloadSharedEXT TaskData td;

layout (set=0, binding=0) buffer StorageBuffer { uint value; } sb;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    td.value = 0u;
    if (pc.writeVal > 0u) { sb.value = 1628510158; }
    EmitMeshTasksEXT(1u, 1u, 1u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;

struct TaskData { uint value; }; taskPayloadSharedEXT TaskData td;

layout (set=0, binding=0, r32ui) uniform uimage2D si;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    td.value = 0u;
    if (pc.writeVal > 0u) { imageStore(si, ivec2(0, 0), uvec4(1628510159, 0, 0, 0)); }
    EmitMeshTasksEXT(1u, 1u, 1u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

layout (location=0) out perprimitiveEXT uint primitiveValue[];

layout (set=0, binding=0, r32ui) uniform uimage2D si;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    SetMeshOutputsEXT(3u, 1u);
    if (pc.readVal > 0u) { primitiveValue[0] = imageLoad(si, ivec2(0, 0)).x; }

    gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
    gl_MeshVerticesEXT[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;

struct TaskData { uint value; }; taskPayloadSharedEXT TaskData td;

layout (set=0, binding=0, r32ui) uniform uimage2D si;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    td.value = 0u;
    if (pc.writeVal > 0u) { imageStore(si, ivec2(0, 0), uvec4(1628510160, 0, 0, 0)); }
    EmitMeshTasksEXT(1u, 1u, 1u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;

struct TaskData { uint value; }; taskPayloadSharedEXT TaskData td;

layout (set=0, binding=0, r32ui) uniform uimage2D si;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    td.value = 0u;
    if (pc.writeVal > 0u) { imageStore(si, ivec2(0, 0), uvec4(1628510161, 0, 0, 0)); }
    EmitMeshTasksEXT(1u, 1u, 1u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;

struct TaskData { uint value; }; taskPayloadSharedEXT TaskData td;

layout (set=0, binding=0) buffer StorageBuffer { uint value; } sb;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    td.value = 0u;
    if (pc.writeVal > 0u) { sb.value = 1628510162; }
    EmitMeshTasksEXT(1u, 1u, 1u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (location=0) in perprimitiveEXT flat uint primitiveValue;
layout (location=0) out uvec4 outColor;

layout (set=0, binding=0) buffer StorageBuffer { uint value; } sb;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    outColor = uvec4(primitiveValue, 0, 0, 0);
    uint readVal = 0u;
    if (pc.readVal > 0u) { readVal = sb.value; }
    outColor = uvec4(readVal, 0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;

struct TaskData { uint value; }; taskPayloadSharedEXT TaskData td;

layout (set=0, binding=0) buffer StorageBuffer { uint value; } sb;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    td.value = 0u;
    if (pc.writeVal > 0u) { sb.value = 1628510163; }
    EmitMeshTasksEXT(1u, 1u, 1u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;

struct TaskData { uint value; }; taskPayloadSharedEXT TaskData td;

layout (set=0, binding=0) buffer StorageBuffer { uint value; } sb;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    td.value = 0u;
    if (pc.writeVal > 0u) { sb.value = 1628510164; }
    EmitMeshTasksEXT(1u, 1u, 1u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;

struct TaskData { uint value; }; taskPayloadSharedEXT TaskData td;

layout (set=0, binding=0, r32ui) uniform uimage2D si;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    td.value = 0u;
    if (pc.writeVal > 0u) { imageStore(si, ivec2(0, 0), uvec4(1628510165, 0, 0, 0)); }
    EmitMeshTasksEXT(1u, 1u, 1u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (location=0) in perprimitiveEXT flat uint primitiveValue;
layout (location=0) out uvec4 outColor;

layout (set=0, binding=0, r32ui) uniform uimage2D si;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    outColor = uvec4(primitiveValue, 0, 0, 0);
    uint readVal = 0u;
    if (pc.readVal > 0u) { readVal = imageLoad(si, ivec2(0, 0)).x; }
    outColor = uvec4(readVal, 0, 0, 0);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;

struct TaskData { uint value; }; taskPayloadSharedEXT TaskData td;

layout (set=0, binding=0, r32ui) uniform uimage2D si;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    td.value = 0u;
    if (pc.writeVal > 0u) { imageStore(si, ivec2(0, 0), uvec4(1628510166, 0, 0, 0)); }
    EmitMeshTasksEXT(1u, 1u, 1u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;

struct TaskData { uint value; }; taskPayloadSharedEXT TaskData td;

layout (set=0, binding=0, r32ui) uniform uimage2D si;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    td.value = 0u;
    if (pc.writeVal > 0u) { imageStore(si, ivec2(0, 0), uvec4(1628510167, 0, 0, 0)); }
    EmitMeshTasksEXT(1u, 1u, 1u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;

struct TaskData { uint value; }; taskPayloadSharedEXT TaskData td;

layout (set=0, binding=0) buffer StorageBuffer { uint value; } sb;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    td.value = 0u;
    if (pc.writeVal > 0u) { sb.value = 1628510168; }
    EmitMeshTasksEXT(1u, 1u, 1u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;

struct TaskData { uint value; }; taskPayloadSharedEXT TaskData td;

layout (set=0, binding=0) buffer StorageBuffer { uint value; } sb;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    td.value = 0u;
    if (pc.writeVal > 0u) { sb.value = 1628510169; }
    EmitMeshTasksEXT(1u, 1u, 1u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;

struct TaskData { uint value; }; taskPayloadSharedEXT TaskData td;

layout (set=0, binding=0, r32ui) uniform uimage2D si;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    td.value = 0u;
    if (pc.writeVal > 0u) { imageStore(si, ivec2(0, 0), uvec4(1628510170, 0, 0, 0)); }
    EmitMeshTasksEXT(1u, 1u, 1u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;

struct TaskData { uint value; }; taskPayloadSharedEXT TaskData td;

layout (set=0, binding=0, r32ui) uniform uimage2D si;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    td.value = 0u;
    if (pc.writeVal > 0u) { imageStore(si, ivec2(0, 0), uvec4(1628510171, 0, 0, 0)); }
    EmitMeshTasksEXT(1u, 1u, 1u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;

struct TaskData { uint value; }; taskPayloadSharedEXT TaskData td;

layout (set=0, binding=0) buffer StorageBuffer { uint value; } sb;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    td.value = 0u;
    if (pc.writeVal > 0u) { sb.value = 1628510172; }
    EmitMeshTasksEXT(1u, 1u, 1u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;

struct TaskData { uint value; }; taskPayloadSharedEXT TaskData td;

layout (set=0, binding=0) buffer StorageBuffer { uint value; } sb;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    td.value = 0u;
    if (pc.writeVal > 0u) { sb.value = 1628510173; }
    EmitMeshTasksEXT(1u, 1u, 1u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

layout (location=0) out perprimitiveEXT uint primitiveValue[];

layout (set=0, binding=0) buffer StorageBuffer { uint value; } sb;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    SetMeshOutputsEXT(3u, 1u);
    if (pc.writeVal > 0u) { sb.value = 1628510174; }

    gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
    gl_MeshVerticesEXT[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

layout (location=0) out perprimitiveEXT uint primitiveValue[];

layout (set=0, binding=0) buffer StorageBuffer { uint value; } sb;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    SetMeshOutputsEXT(3u, 1u);
    if (pc.writeVal > 0u) { sb.value = 1628510175; }

    gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
    gl_MeshVerticesEXT[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

layout (location=0) out perprimitiveEXT uint primitiveValue[];

layout (set=0, binding=0) buffer StorageBuffer { uint value; } sb;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    SetMeshOutputsEXT(3u, 1u);
    if (pc.writeVal > 0u) { sb.value = 1628510176; }

    gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
    gl_MeshVerticesEXT[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

layout (location=0) out perprimitiveEXT uint primitiveValue[];

layout (set=0, binding=0, r32ui) uniform uimage2D si;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    SetMeshOutputsEXT(3u, 1u);
    if (pc.writeVal > 0u) { imageStore(si, ivec2(0, 0), uvec4(1628510177, 0, 0, 0)); }

    gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
    gl_MeshVerticesEXT[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

layout (location=0) out perprimitiveEXT uint primitiveValue[];

layout (set=0, binding=0, r32ui) uniform uimage2D si;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    SetMeshOutputsEXT(3u, 1u);
    if (pc.writeVal > 0u) { imageStore(si, ivec2(0, 0), uvec4(1628510178, 0, 0, 0)); }

    gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
    gl_MeshVerticesEXT[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

layout (location=0) out perprimitiveEXT uint primitiveValue[];

layout (set=0, binding=0, r32ui) uniform uimage2D si;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    SetMeshOutputsEXT(3u, 1u);
    if (pc.writeVal > 0u) { imageStore(si, ivec2(0, 0), uvec4(1628510179, 0, 0, 0)); }

    gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
    gl_MeshVerticesEXT[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

layout (location=0) out perprimitiveEXT uint primitiveValue[];

layout (set=0, binding=0) buffer StorageBuffer { uint value; } sb;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    SetMeshOutputsEXT(3u, 1u);
    if (pc.writeVal > 0u) { sb.value = 1628510180; }

    gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
    gl_MeshVerticesEXT[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

layout (location=0) out perprimitiveEXT uint primitiveValue[];

layout (set=0, binding=0) buffer StorageBuffer { uint value; } sb;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    SetMeshOutputsEXT(3u, 1u);
    if (pc.writeVal > 0u) { sb.value = 1628510181; }

    gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
    gl_MeshVerticesEXT[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

layout (location=0) out perprimitiveEXT uint primitiveValue[];

layout (set=0, binding=0, r32ui) uniform uimage2D si;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    SetMeshOutputsEXT(3u, 1u);
    if (pc.writeVal > 0u) { imageStore(si, ivec2(0, 0), uvec4(1628510182, 0, 0, 0)); }

    gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
    gl_MeshVerticesEXT[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

layout (location=0) out perprimitiveEXT uint primitiveValue[];

layout (set=0, binding=0, r32ui) uniform uimage2D si;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    SetMeshOutputsEXT(3u, 1u);
    if (pc.writeVal > 0u) { imageStore(si, ivec2(0, 0), uvec4(1628510183, 0, 0, 0)); }

    gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
    gl_MeshVerticesEXT[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

layout (location=0) out perprimitiveEXT uint primitiveValue[];

layout (set=0, binding=0) buffer StorageBuffer { uint value; } sb;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    SetMeshOutputsEXT(3u, 1u);
    if (pc.writeVal > 0u) { sb.value = 1628510184; }

    gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
    gl_MeshVerticesEXT[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

layout (location=0) out perprimitiveEXT uint primitiveValue[];

layout (set=0, binding=0) buffer StorageBuffer { uint value; } sb;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    SetMeshOutputsEXT(3u, 1u);
    if (pc.writeVal > 0u) { sb.value = 1628510185; }

    gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
    gl_MeshVerticesEXT[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;

struct TaskData { uint value; }; taskPayloadSharedEXT TaskData td;

layout (set=0, binding=0) buffer StorageBuffer { uint value; } sb;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    td.value = 0u;
    if (pc.readVal > 0u) { td.value = sb.value; }
    EmitMeshTasksEXT(1u, 1u, 1u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

layout (location=0) out perprimitiveEXT uint primitiveValue[];

layout (set=0, binding=0) buffer StorageBuffer { uint value; } sb;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    SetMeshOutputsEXT(3u, 1u);
    if (pc.writeVal > 0u) { sb.value = 1628510186; }

    gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
    gl_MeshVerticesEXT[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

layout (location=0) out perprimitiveEXT uint primitiveValue[];

layout (set=0, binding=0) buffer StorageBuffer { uint value; } sb;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    SetMeshOutputsEXT(3u, 1u);
    if (pc.writeVal > 0u) { sb.value = 1628510187; }

    gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
    gl_MeshVerticesEXT[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

layout (location=0) out perprimitiveEXT uint primitiveValue[];

layout (set=0, binding=0) buffer StorageBuffer { uint value; } sb;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    SetMeshOutputsEXT(3u, 1u);
    if (pc.writeVal > 0u) { sb.value = 1628510188; }

    gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
    gl_MeshVerticesEXT[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;

struct TaskData { uint value; }; taskPayloadSharedEXT TaskData td;

layout (set=0, binding=0, r32ui) uniform uimage2D si;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    td.value = 0u;
    if (pc.readVal > 0u) { td.value = imageLoad(si, ivec2(0, 0)).x; }
    EmitMeshTasksEXT(1u, 1u, 1u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

layout (location=0) out perprimitiveEXT uint primitiveValue[];

layout (set=0, binding=0, r32ui) uniform uimage2D si;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    SetMeshOutputsEXT(3u, 1u);
    if (pc.writeVal > 0u) { imageStore(si, ivec2(0, 0), uvec4(1628510189, 0, 0, 0)); }

    gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
    gl_MeshVerticesEXT[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

layout (location=0) out perprimitiveEXT uint primitiveValue[];

layout (set=0, binding=0, r32ui) uniform uimage2D si;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    SetMeshOutputsEXT(3u, 1u);
    if (pc.writeVal > 0u) { imageStore(si, ivec2(0, 0), uvec4(1628510190, 0, 0, 0)); }

    gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
    gl_MeshVerticesEXT[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

layout (location=0) out perprimitiveEXT uint primitiveValue[];

layout (set=0, binding=0, r32ui) uniform uimage2D si;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    SetMeshOutputsEXT(3u, 1u);
    if (pc.writeVal > 0u) { imageStore(si, ivec2(0, 0), uvec4(1628510191, 0, 0, 0)); }

    gl_MeshVerticesEXT[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesEXT[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
    gl_MeshVerticesEXT[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (location=0) in perprimitiveEXT flat uint primitiveValue;
layout (location=0) out uvec4 outColor;

layout (set=0, binding=0) buffer StorageBuffer { uint value; } sb;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    outColor = uvec4(primitiveValue, 0, 0, 0);
    uint readVal = 0u;
    if (pc.writeVal > 0u) { sb.value = 1628510192; }
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (location=0) in perprimitiveEXT flat uint primitiveValue;
layout (location=0) out uvec4 outColor;

layout (set=0, binding=0) buffer StorageBuffer { uint value; } sb;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    outColor = uvec4(primitiveValue, 0, 0, 0);
    uint readVal = 0u;
    if (pc.writeVal > 0u) { sb.value = 1628510193; }
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (location=0) in perprimitiveEXT flat uint primitiveValue;
layout (location=0) out uvec4 outColor;

layout (set=0, binding=0) buffer StorageBuffer { uint value; } sb;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    outColor = uvec4(primitiveValue, 0, 0, 0);
    uint readVal = 0u;
    if (pc.writeVal > 0u) { sb.value = 1628510194; }
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (location=0) in perprimitiveEXT flat uint primitiveValue;
layout (location=0) out uvec4 outColor;

layout (set=0, binding=0, r32ui) uniform uimage2D si;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    outColor = uvec4(primitiveValue, 0, 0, 0);
    uint readVal = 0u;
    if (pc.writeVal > 0u) { imageStore(si, ivec2(0, 0), uvec4(1628510195, 0, 0, 0)); }
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (location=0) in perprimitiveEXT flat uint primitiveValue;
layout (location=0) out uvec4 outColor;

layout (set=0, binding=0, r32ui) uniform uimage2D si;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    outColor = uvec4(primitiveValue, 0, 0, 0);
    uint readVal = 0u;
    if (pc.writeVal > 0u) { imageStore(si, ivec2(0, 0), uvec4(1628510196, 0, 0, 0)); }
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (location=0) in perprimitiveEXT flat uint primitiveValue;
layout (location=0) out uvec4 outColor;

layout (set=0, binding=0, r32ui) uniform uimage2D si;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    outColor = uvec4(primitiveValue, 0, 0, 0);
    uint readVal = 0u;
    if (pc.writeVal > 0u) { imageStore(si, ivec2(0, 0), uvec4(1628510197, 0, 0, 0)); }
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (location=0) in perprimitiveEXT flat uint primitiveValue;
layout (location=0) out uvec4 outColor;

layout (set=0, binding=0) buffer StorageBuffer { uint value; } sb;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    outColor = uvec4(primitiveValue, 0, 0, 0);
    uint readVal = 0u;
    if (pc.writeVal > 0u) { sb.value = 1628510198; }
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (location=0) in perprimitiveEXT flat uint primitiveValue;
layout (location=0) out uvec4 outColor;

layout (set=0, binding=0) buffer StorageBuffer { uint value; } sb;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    outColor = uvec4(primitiveValue, 0, 0, 0);
    uint readVal = 0u;
    if (pc.writeVal > 0u) { sb.value = 1628510199; }
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (location=0) in perprimitiveEXT flat uint primitiveValue;
layout (location=0) out uvec4 outColor;

layout (set=0, binding=0) buffer StorageBuffer { uint value; } sb;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    outColor = uvec4(primitiveValue, 0, 0, 0);
    uint readVal = 0u;
    if (pc.writeVal > 0u) { sb.value = 1628510200; }
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (location=0) in perprimitiveEXT flat uint primitiveValue;
layout (location=0) out uvec4 outColor;

layout (set=0, binding=0, r32ui) uniform uimage2D si;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    outColor = uvec4(primitiveValue, 0, 0, 0);
    uint readVal = 0u;
    if (pc.writeVal > 0u) { imageStore(si, ivec2(0, 0), uvec4(1628510201, 0, 0, 0)); }
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (location=0) in perprimitiveEXT flat uint primitiveValue;
layout (location=0) out uvec4 outColor;

layout (set=0, binding=0, r32ui) uniform uimage2D si;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    outColor = uvec4(primitiveValue, 0, 0, 0);
    uint readVal = 0u;
    if (pc.writeVal > 0u) { imageStore(si, ivec2(0, 0), uvec4(1628510202, 0, 0, 0)); }
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (location=0) in perprimitiveEXT flat uint primitiveValue;
layout (location=0) out uvec4 outColor;

layout (set=0, binding=0, r32ui) uniform uimage2D si;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    outColor = uvec4(primitiveValue, 0, 0, 0);
    uint readVal = 0u;
    if (pc.writeVal > 0u) { imageStore(si, ivec2(0, 0), uvec4(1628510203, 0, 0, 0)); }
}
#version 450
layout(local_size_x=128) in;
layout (set=0, binding=0, std430) buffer OutputBlock {
    uint values[];
} outBuffer;
layout (set=0, binding=1, std430) buffer VerificationBlock {
    uint values[];
} verificationBuffer;
void main ()
{
    outBuffer.values[gl_GlobalInvocationID.x] = gl_GlobalInvocationID.x;
}
#version 450
#extension GL_EXT_mesh_shader : enable
layout(local_size_x=128) in;
layout (set=0, binding=0, std430) buffer OutputBlock {
    uint values[];
} outBuffer;
layout (set=0, binding=1, std430) buffer VerificationBlock {
    uint values[];
} verificationBuffer;
void main ()
{
    const uint verifResult = ((outBuffer.values[gl_GlobalInvocationID.x] == gl_GlobalInvocationID.x) ? 1u : 0u);
    verificationBuffer.values[gl_GlobalInvocationID.x] = verifResult;
    EmitMeshTasksEXT(0u, 0u, 0u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

void main ()
{
    SetMeshOutputsEXT(0u, 0u);
}
