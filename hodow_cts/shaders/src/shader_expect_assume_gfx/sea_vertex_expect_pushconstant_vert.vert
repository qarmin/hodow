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
layout( push_constant, std430 ) uniform pc { layout(offset = 0) bool pcThisIsTrue; };
void main() {
    bool control = false;
    if ( expectKHR(pcThisIsTrue, true) == true ) {
        control = true;
    } else {
        // set wrong value
        control = false;
    }
    gl_Position  = in_position;
    value = uint(control == true);
}
