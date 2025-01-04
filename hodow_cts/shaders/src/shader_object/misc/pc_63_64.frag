#version 450
#extension GL_EXT_shader_8bit_storage : require
layout(push_constant) uniform PushConsts {
    layout(offset = 253) uint8_t g63;
    uint8_t b63;
} pushConst;
layout (location = 0) out uvec4 outColor;
void main() {
    uvec4 color = uvec4(0);
    color += uvec4(255, pushConst.b63, pushConst.g63, 17);
    outColor = color;
}
