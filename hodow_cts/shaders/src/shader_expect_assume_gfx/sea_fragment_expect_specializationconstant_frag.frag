#version 460
#extension GL_EXT_spirv_intrinsics: enable

spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
bool expectKHR(bool, bool);
precision highp float;
precision highp int;
layout(location = 0) out uvec2 out_color;
layout (constant_id = 0) const bool scThisIsTrue = false;
void main()
{
    bool control = false;
    if ( expectKHR(scThisIsTrue, true) == true ) {
        control = true;
    } else {
        // set wrong value
        control = false;
    }
    out_color.r = int(gl_FragCoord.x);
    out_color.g = uint(control == true);
}
