#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, std430) buffer OutputBlock { uint data[64]; } outputValues;
void main (void) {
    outputValues.data[gl_LocalInvocationIndex] += gl_LocalInvocationIndex + 1000000u;
}
#version 460
layout (local_size_x=1, local_size_y=1, local_size_z=1) in;
layout (push_constant, std430) uniform PushConstantBlock { uint index; } pc;
layout (set=0, binding=0, std430) buffer OutputBlock { uint data[]; } outputValues;
void main (void) {
    outputValues.data[pc.index] += pc.index + 1000000u;
}
#version 460
layout (location=0) in vec4 inPos;
void main (void) {
    gl_PointSize = 1.0;
    gl_Position = inPos;
}
#version 460
layout (location=0) out vec4 outColor;
void main (void) {
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
}
#version 460
layout (local_size_x=1, local_size_y=1, local_size_z=1) in;
layout (push_constant, std430) uniform PCBlock { vec4 value; } pc;
layout (set=0, binding=0, std430) buffer OutBlock { vec4 value; } outBuffer;
void main(void) {
    outBuffer.value = pc.value;
}
#version 460
layout (local_size_x=1, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=1, std430) readonly buffer InBlock { vec4 value; } inBuffer;
layout (set=0, binding=0, std430) buffer OutBlock { vec4 value; } outBuffer;
void main(void) {
    outBuffer.value = inBuffer.value;
}
#version 310 es

layout(local_size_x = 1u, local_size_y = 1u, local_size_z = 1u) in;
layout(set = 0, binding = 0, std140) buffer InOutBuf
{
    coherent uint count;
} b_in_out;
void main(void)
{
    atomicAdd(b_in_out.count, 1u);
}
#version 310 es

layout(local_size_x = 1u, local_size_y = 1u, local_size_z = 1u) in;
layout(set = 0, binding = 1u, std140) uniform BufferName
{
    highp vec4 colorA;
    highp vec4 colorB;
} b_instance;
layout(set = 0, binding = 0, std140) writeonly buffer OutBuf
{
    highp vec4 read_colors[4];
} b_out;
void main(void)
{
    highp int quadrant_id = int(gl_WorkGroupID.x);
    highp vec4 result_color;
    if (quadrant_id == 1 || quadrant_id == 2)
        result_color = b_instance.colorA;
    else
        result_color = b_instance.colorB;
    b_out.read_colors[gl_WorkGroupID.x] = result_color;
}
#version 310 es

layout(local_size_x = 1u, local_size_y = 1u, local_size_z = 1u) in;
layout(set = 0, binding = 1u, std140) uniform BufferName
{
    highp vec4 colorA;
    highp vec4 colorB;
} b_instance;
layout(set = 0, binding = 0, std140) writeonly buffer OutBuf
{
    highp vec4 read_colors[4];
} b_out;
void main(void)
{
    highp int quadrant_id = int(gl_WorkGroupID.x);
    highp vec4 result_color;
    if (quadrant_id == 1 || quadrant_id == 2)
        result_color = b_instance.colorA;
    else
        result_color = b_instance.colorB;
    b_out.read_colors[gl_WorkGroupID.x] = vec4(0.0, 0.0, 0.0, 0.0);
}
#version 450
void main() {
    vec2 pos = vec2(float(gl_VertexIndex & 1), float((gl_VertexIndex >> 1) & 1));
    gl_Position = vec4(pos * 2.0f - 1.0f, 0.0f, 1.0f);
}
#version 450
layout(location = 0) out uvec4 outColor;
void main() {
    outColor = uvec4(255u, 0u, 0u, 255u);
}
#version 450

layout(location=0) in vec2 inCoords;
layout(location=1) in uvec4 inColor;

layout(location=0) out flat uvec4 outColor;

void main()
{
    gl_Position = vec4(inCoords, 0.0, 1.0);
    outColor = inColor;
}
#version 450

layout(location=0) in flat uvec4 inColor;
layout(location=0) out uvec4 outColor;

void main()
{
    outColor = inColor;
}
#version 460
layout (local_size_x=1, local_size_y=1, local_size_z=1) in;
layout (push_constant, std430) uniform PCBlock { uint index; } pc;
layout (set=0, binding=0, std430) buffer BufferBlock { uint values[]; } ssbo;
layout (constant_id=0) const uint value = 0;
void main(void) { ssbo.values[pc.index] = value; }
