#version 460
#extension GL_EXT_spirv_intrinsics: enable

spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
bvec2 expectKHR(bvec2, bvec2);
precision highp float;
precision highp int;
layout(location = 0) out uvec2 out_color;
layout(set = 0, binding = 0, std430) buffer Block1 { bvec2 inputBuffer[]; };
void main()
{
    bvec2 control = bvec2(false);
    if ( expectKHR(inputBuffer[uint(gl_FragCoord.x)], bvec2(true)) == bvec2(true) ) {
        control = bvec2(true);
    } else {
        // set wrong value
        control = bvec2(false);
    }
    out_color.r = int(gl_FragCoord.x);
    out_color.g = uint(control == bvec2(true));
}
