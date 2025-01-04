#version 450
#extension GL_EXT_shader_8bit_storage : require
layout(push_constant) uniform PushConsts {
    layout(offset = 69) uint8_t g17;
    uint8_t b17;
} pushConst;
layout (location = 0) out uvec4 outColor;
void main() {
    uvec4 color = uvec4(0);
    color += uvec4(255, pushConst.b17, pushConst.g17, 17);
    outColor = color;
}
