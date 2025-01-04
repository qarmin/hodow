#version 460
#extension GL_EXT_spirv_intrinsics: enable

spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
bvec3 expectKHR(bvec3, bvec3);
precision highp float;
precision highp int;
layout(location = 0) in vec4 in_position;
layout(location = 0) out flat uint value;
layout(set = 0, binding = 0, std430) buffer Block1 { bvec3 inputBuffer[]; };
void main() {
    bvec3 control = bvec3(false);
    if ( expectKHR(inputBuffer[gl_VertexIndex], bvec3(true)) == bvec3(true) ) {
        control = bvec3(true);
    } else {
        // set wrong value
        control = bvec3(false);
    }
    gl_Position  = in_position;
    value = uint(control == bvec3(true));
}
