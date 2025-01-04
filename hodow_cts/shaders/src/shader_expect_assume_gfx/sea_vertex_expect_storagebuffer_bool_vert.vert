#version 460
#extension GL_EXT_spirv_intrinsics: enable

spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
bool expectKHR(bool, bool);
precision highp float;
precision highp int;
layout(location = 0) in vec4 in_position;
layout(location = 0) out flat uint value;
layout(set = 0, binding = 0, std430) buffer Block1 { bool inputBuffer[]; };
void main() {
    bool control = bool(false);
    if ( expectKHR(inputBuffer[gl_VertexIndex], bool(true)) == bool(true) ) {
        control = bool(true);
    } else {
        // set wrong value
        control = bool(false);
    }
    gl_Position  = in_position;
    value = uint(control == bool(true));
}
