#version 450
#extension GL_NV_mesh_shader : enable

layout(local_size_x=1) in;

out taskNV TaskData { uint value; } td;

layout (set=0, binding=0) uniform UniformBuffer { uint value; } ub;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    gl_TaskCountNV = 1u;
    td.value = 0u;
    if (pc.readVal > 0u) { td.value = ub.value; }
}
#version 450
#extension GL_NV_mesh_shader : enable

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

in taskNV TaskData { uint value; } td;
layout (location=0) out perprimitiveNV uint primitiveValue[];


void main ()
{
    gl_PrimitiveCountNV = 1u;
    primitiveValue[0] = td.value;

    gl_MeshVerticesNV[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesNV[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
    gl_MeshVerticesNV[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    gl_PrimitiveIndicesNV[0] = 0;
    gl_PrimitiveIndicesNV[1] = 1;
    gl_PrimitiveIndicesNV[2] = 2;
}
#version 450
#extension GL_NV_mesh_shader : enable

layout (location=0) in perprimitiveNV flat uint primitiveValue;
layout (location=0) out uvec4 outColor;


void main ()
{
    outColor = uvec4(primitiveValue, 0, 0, 0);
    uint readVal = 0u;
}
#version 450
#extension GL_NV_mesh_shader : enable

layout(local_size_x=1) in;

out taskNV TaskData { uint value; } td;

layout (set=0, binding=0) readonly buffer StorageBuffer { uint value; } sb;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    gl_TaskCountNV = 1u;
    td.value = 0u;
    if (pc.readVal > 0u) { td.value = sb.value; }
}
#version 450
#extension GL_NV_mesh_shader : enable

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

layout (location=0) out perprimitiveNV uint primitiveValue[];

layout (set=0, binding=0) uniform UniformBuffer { uint value; } ub;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    gl_PrimitiveCountNV = 1u;
    if (pc.readVal > 0u) { primitiveValue[0] = ub.value; }

    gl_MeshVerticesNV[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesNV[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
    gl_MeshVerticesNV[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    gl_PrimitiveIndicesNV[0] = 0;
    gl_PrimitiveIndicesNV[1] = 1;
    gl_PrimitiveIndicesNV[2] = 2;
}
#version 450
#extension GL_NV_mesh_shader : enable

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

layout (location=0) out perprimitiveNV uint primitiveValue[];

layout (set=0, binding=0) readonly buffer StorageBuffer { uint value; } sb;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    gl_PrimitiveCountNV = 1u;
    if (pc.readVal > 0u) { primitiveValue[0] = sb.value; }

    gl_MeshVerticesNV[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesNV[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
    gl_MeshVerticesNV[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    gl_PrimitiveIndicesNV[0] = 0;
    gl_PrimitiveIndicesNV[1] = 1;
    gl_PrimitiveIndicesNV[2] = 2;
}
#version 450
#extension GL_NV_mesh_shader : enable

layout(local_size_x=1) in;

out taskNV TaskData { uint value; } td;

layout (set=0, binding=0, r32ui) readonly uniform uimage2D si;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    gl_TaskCountNV = 1u;
    td.value = 0u;
    if (pc.readVal > 0u) { td.value = imageLoad(si, ivec2(0, 0)).x; }
}
#version 450
#extension GL_NV_mesh_shader : enable

layout(local_size_x=1) in;

out taskNV TaskData { uint value; } td;

layout (set=0, binding=0) uniform usampler2D sampled;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    gl_TaskCountNV = 1u;
    td.value = 0u;
    if (pc.readVal > 0u) { td.value = texture(sampled, vec2(0.5, 0.5)).x; }
}
#version 450
#extension GL_NV_mesh_shader : enable

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

layout (location=0) out perprimitiveNV uint primitiveValue[];

layout (set=0, binding=0, r32ui) readonly uniform uimage2D si;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    gl_PrimitiveCountNV = 1u;
    if (pc.readVal > 0u) { primitiveValue[0] = imageLoad(si, ivec2(0, 0)).x; }

    gl_MeshVerticesNV[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesNV[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
    gl_MeshVerticesNV[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    gl_PrimitiveIndicesNV[0] = 0;
    gl_PrimitiveIndicesNV[1] = 1;
    gl_PrimitiveIndicesNV[2] = 2;
}
#version 450
#extension GL_NV_mesh_shader : enable

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

layout (location=0) out perprimitiveNV uint primitiveValue[];

layout (set=0, binding=0) uniform usampler2D sampled;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    gl_PrimitiveCountNV = 1u;
    if (pc.readVal > 0u) { primitiveValue[0] = texture(sampled, vec2(0.5, 0.5)).x; }

    gl_MeshVerticesNV[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesNV[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
    gl_MeshVerticesNV[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    gl_PrimitiveIndicesNV[0] = 0;
    gl_PrimitiveIndicesNV[1] = 1;
    gl_PrimitiveIndicesNV[2] = 2;
}
#version 450
#extension GL_NV_mesh_shader : enable

layout(local_size_x=1) in;

out taskNV TaskData { uint value; } td;

layout (set=0, binding=0) buffer StorageBuffer { uint value; } sb;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    gl_TaskCountNV = 1u;
    td.value = 0u;
    if (pc.writeVal > 0u) { sb.value = 1628510156; }
}
#version 450
#extension GL_NV_mesh_shader : enable

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

in taskNV TaskData { uint value; } td;
layout (location=0) out perprimitiveNV uint primitiveValue[];

layout (set=0, binding=0) buffer StorageBuffer { uint value; } sb;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    gl_PrimitiveCountNV = 1u;
    primitiveValue[0] = td.value;
    if (pc.readVal > 0u) { primitiveValue[0] = sb.value; }

    gl_MeshVerticesNV[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesNV[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
    gl_MeshVerticesNV[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    gl_PrimitiveIndicesNV[0] = 0;
    gl_PrimitiveIndicesNV[1] = 1;
    gl_PrimitiveIndicesNV[2] = 2;
}
#version 450
#extension GL_NV_mesh_shader : enable

layout(local_size_x=1) in;

out taskNV TaskData { uint value; } td;

layout (set=0, binding=0, r32ui) uniform uimage2D si;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    gl_TaskCountNV = 1u;
    td.value = 0u;
    if (pc.writeVal > 0u) { imageStore(si, ivec2(0, 0), uvec4(1628510157, 0, 0, 0)); }
}
#version 450
#extension GL_NV_mesh_shader : enable

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

in taskNV TaskData { uint value; } td;
layout (location=0) out perprimitiveNV uint primitiveValue[];

layout (set=0, binding=0, r32ui) uniform uimage2D si;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    gl_PrimitiveCountNV = 1u;
    primitiveValue[0] = td.value;
    if (pc.readVal > 0u) { primitiveValue[0] = imageLoad(si, ivec2(0, 0)).x; }

    gl_MeshVerticesNV[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesNV[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
    gl_MeshVerticesNV[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    gl_PrimitiveIndicesNV[0] = 0;
    gl_PrimitiveIndicesNV[1] = 1;
    gl_PrimitiveIndicesNV[2] = 2;
}
#version 450
#extension GL_NV_mesh_shader : enable

layout(local_size_x=1) in;

out taskNV TaskData { uint value; } td;

layout (set=0, binding=0) buffer StorageBuffer { uint value; } sb;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    gl_TaskCountNV = 1u;
    td.value = 0u;
    if (pc.writeVal > 0u) { sb.value = 1628510158; }
}
#version 450
#extension GL_NV_mesh_shader : enable

layout (location=0) in perprimitiveNV flat uint primitiveValue;
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
#extension GL_NV_mesh_shader : enable

layout(local_size_x=1) in;

out taskNV TaskData { uint value; } td;

layout (set=0, binding=0, r32ui) uniform uimage2D si;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    gl_TaskCountNV = 1u;
    td.value = 0u;
    if (pc.writeVal > 0u) { imageStore(si, ivec2(0, 0), uvec4(1628510159, 0, 0, 0)); }
}
#version 450
#extension GL_NV_mesh_shader : enable

layout (location=0) in perprimitiveNV flat uint primitiveValue;
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
#extension GL_NV_mesh_shader : enable

layout(local_size_x=1) in;

out taskNV TaskData { uint value; } td;

layout (set=0, binding=0) buffer StorageBuffer { uint value; } sb;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    gl_TaskCountNV = 1u;
    td.value = 0u;
    if (pc.writeVal > 0u) { sb.value = 1628510160; }
}
#version 450
#extension GL_NV_mesh_shader : enable

layout(local_size_x=1) in;

out taskNV TaskData { uint value; } td;

layout (set=0, binding=0) buffer StorageBuffer { uint value; } sb;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    gl_TaskCountNV = 1u;
    td.value = 0u;
    if (pc.writeVal > 0u) { sb.value = 1628510161; }
}
#version 450
#extension GL_NV_mesh_shader : enable

layout(local_size_x=1) in;

out taskNV TaskData { uint value; } td;

layout (set=0, binding=0, r32ui) uniform uimage2D si;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    gl_TaskCountNV = 1u;
    td.value = 0u;
    if (pc.writeVal > 0u) { imageStore(si, ivec2(0, 0), uvec4(1628510162, 0, 0, 0)); }
}
#version 450
#extension GL_NV_mesh_shader : enable

layout(local_size_x=1) in;

out taskNV TaskData { uint value; } td;

layout (set=0, binding=0, r32ui) uniform uimage2D si;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    gl_TaskCountNV = 1u;
    td.value = 0u;
    if (pc.writeVal > 0u) { imageStore(si, ivec2(0, 0), uvec4(1628510163, 0, 0, 0)); }
}
#version 450
#extension GL_NV_mesh_shader : enable

layout(local_size_x=1) in;

out taskNV TaskData { uint value; } td;

layout (set=0, binding=0) buffer StorageBuffer { uint value; } sb;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    gl_TaskCountNV = 1u;
    td.value = 0u;
    if (pc.writeVal > 0u) { sb.value = 1628510164; }
}
#version 450
#extension GL_NV_mesh_shader : enable

layout(local_size_x=1) in;

out taskNV TaskData { uint value; } td;

layout (set=0, binding=0) buffer StorageBuffer { uint value; } sb;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    gl_TaskCountNV = 1u;
    td.value = 0u;
    if (pc.writeVal > 0u) { sb.value = 1628510165; }
}
#version 450
#extension GL_NV_mesh_shader : enable

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

layout (location=0) out perprimitiveNV uint primitiveValue[];

layout (set=0, binding=0) buffer StorageBuffer { uint value; } sb;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    gl_PrimitiveCountNV = 1u;
    if (pc.writeVal > 0u) { sb.value = 1628510166; }

    gl_MeshVerticesNV[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesNV[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
    gl_MeshVerticesNV[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    gl_PrimitiveIndicesNV[0] = 0;
    gl_PrimitiveIndicesNV[1] = 1;
    gl_PrimitiveIndicesNV[2] = 2;
}
#version 450
#extension GL_NV_mesh_shader : enable

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

layout (location=0) out perprimitiveNV uint primitiveValue[];

layout (set=0, binding=0, r32ui) uniform uimage2D si;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    gl_PrimitiveCountNV = 1u;
    if (pc.writeVal > 0u) { imageStore(si, ivec2(0, 0), uvec4(1628510167, 0, 0, 0)); }

    gl_MeshVerticesNV[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesNV[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
    gl_MeshVerticesNV[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    gl_PrimitiveIndicesNV[0] = 0;
    gl_PrimitiveIndicesNV[1] = 1;
    gl_PrimitiveIndicesNV[2] = 2;
}
#version 450
#extension GL_NV_mesh_shader : enable

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

layout (location=0) out perprimitiveNV uint primitiveValue[];

layout (set=0, binding=0) buffer StorageBuffer { uint value; } sb;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    gl_PrimitiveCountNV = 1u;
    if (pc.writeVal > 0u) { sb.value = 1628510168; }

    gl_MeshVerticesNV[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesNV[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
    gl_MeshVerticesNV[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    gl_PrimitiveIndicesNV[0] = 0;
    gl_PrimitiveIndicesNV[1] = 1;
    gl_PrimitiveIndicesNV[2] = 2;
}
#version 450
#extension GL_NV_mesh_shader : enable

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

layout (location=0) out perprimitiveNV uint primitiveValue[];

layout (set=0, binding=0) buffer StorageBuffer { uint value; } sb;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    gl_PrimitiveCountNV = 1u;
    if (pc.writeVal > 0u) { sb.value = 1628510169; }

    gl_MeshVerticesNV[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesNV[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
    gl_MeshVerticesNV[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    gl_PrimitiveIndicesNV[0] = 0;
    gl_PrimitiveIndicesNV[1] = 1;
    gl_PrimitiveIndicesNV[2] = 2;
}
#version 450
#extension GL_NV_mesh_shader : enable

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

layout (location=0) out perprimitiveNV uint primitiveValue[];

layout (set=0, binding=0, r32ui) uniform uimage2D si;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    gl_PrimitiveCountNV = 1u;
    if (pc.writeVal > 0u) { imageStore(si, ivec2(0, 0), uvec4(1628510170, 0, 0, 0)); }

    gl_MeshVerticesNV[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesNV[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
    gl_MeshVerticesNV[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    gl_PrimitiveIndicesNV[0] = 0;
    gl_PrimitiveIndicesNV[1] = 1;
    gl_PrimitiveIndicesNV[2] = 2;
}
#version 450
#extension GL_NV_mesh_shader : enable

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

layout (location=0) out perprimitiveNV uint primitiveValue[];

layout (set=0, binding=0, r32ui) uniform uimage2D si;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    gl_PrimitiveCountNV = 1u;
    if (pc.writeVal > 0u) { imageStore(si, ivec2(0, 0), uvec4(1628510171, 0, 0, 0)); }

    gl_MeshVerticesNV[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesNV[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
    gl_MeshVerticesNV[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    gl_PrimitiveIndicesNV[0] = 0;
    gl_PrimitiveIndicesNV[1] = 1;
    gl_PrimitiveIndicesNV[2] = 2;
}
#version 450
#extension GL_NV_mesh_shader : enable

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

layout (location=0) out perprimitiveNV uint primitiveValue[];

layout (set=0, binding=0) buffer StorageBuffer { uint value; } sb;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    gl_PrimitiveCountNV = 1u;
    if (pc.writeVal > 0u) { sb.value = 1628510172; }

    gl_MeshVerticesNV[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesNV[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
    gl_MeshVerticesNV[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    gl_PrimitiveIndicesNV[0] = 0;
    gl_PrimitiveIndicesNV[1] = 1;
    gl_PrimitiveIndicesNV[2] = 2;
}
#version 450
#extension GL_NV_mesh_shader : enable

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

layout (location=0) out perprimitiveNV uint primitiveValue[];

layout (set=0, binding=0) buffer StorageBuffer { uint value; } sb;
layout (push_constant, std430) uniform PushConstantBlock {
    uint writeVal;
    uint readVal;
} pc;

void main ()
{
    gl_PrimitiveCountNV = 1u;
    if (pc.writeVal > 0u) { sb.value = 1628510173; }

    gl_MeshVerticesNV[0].gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);
    gl_MeshVerticesNV[1].gl_Position = vec4(-1.0,  3.0, 0.0, 1.0);
    gl_MeshVerticesNV[2].gl_Position = vec4( 3.0, -1.0, 0.0, 1.0);
    gl_PrimitiveIndicesNV[0] = 0;
    gl_PrimitiveIndicesNV[1] = 1;
    gl_PrimitiveIndicesNV[2] = 2;
}
