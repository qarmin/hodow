#version 450
#extension GL_EXT_buffer_reference2 : require
#extension GL_EXT_scalar_block_layout : require

layout(buffer_reference, buffer_reference_align = 4, scalar) buffer Payload {
    uvec3 payload[];
};

layout(set = 2, binding = 0, std430) buffer SSBO {
    Payload outData[4];
};

layout(set = 0, binding = 0) uniform sampler2D s;
layout(location = 0) out vec4 color;

void main()
{
    outData[0].payload[0] = uvec3(2, 3, 4);
    color = texture(s, vec2(0.0));
}
