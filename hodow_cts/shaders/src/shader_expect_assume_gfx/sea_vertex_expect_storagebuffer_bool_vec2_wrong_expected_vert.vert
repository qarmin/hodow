#version 460
#extension GL_EXT_spirv_intrinsics: enable

spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
bvec2 expectKHR(bvec2, bvec2);
precision highp float;
precision highp int;
layout(location = 0) in vec4 in_position;
layout(location = 0) out flat uint value;
layout(set = 0, binding = 0, std430) buffer Block1 { bvec2 inputBuffer[]; };
void main() {
    bvec2 control = bvec2(false);
    if ( expectKHR(inputBuffer[gl_VertexIndex], bvec2(true)) == bvec2(true) ) {
        control = bvec2(true);
    } else {
        // set wrong value
        control = bvec2(false);
    }
    gl_Position  = in_position;
    value = uint(control == bvec2(false));
}
