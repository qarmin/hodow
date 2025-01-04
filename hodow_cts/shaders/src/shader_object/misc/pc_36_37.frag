#version 450
#extension GL_EXT_shader_8bit_storage : require
layout(push_constant) uniform PushConsts {
    layout(offset = 145) uint8_t g36;
    uint8_t b36;
} pushConst;
layout (location = 0) out uvec4 outColor;
void main() {
    uvec4 color = uvec4(0);
    color += uvec4(255, pushConst.b36, pushConst.g36, 17);
    outColor = color;
}
