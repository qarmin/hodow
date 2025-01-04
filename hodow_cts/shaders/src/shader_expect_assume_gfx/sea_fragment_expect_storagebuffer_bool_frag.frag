#version 460
#extension GL_EXT_spirv_intrinsics: enable

spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
bool expectKHR(bool, bool);
precision highp float;
precision highp int;
layout(location = 0) out uvec2 out_color;
layout(set = 0, binding = 0, std430) buffer Block1 { bool inputBuffer[]; };
void main()
{
    bool control = bool(false);
    if ( expectKHR(inputBuffer[uint(gl_FragCoord.x)], bool(true)) == bool(true) ) {
        control = bool(true);
    } else {
        // set wrong value
        control = bool(false);
    }
    out_color.r = int(gl_FragCoord.x);
    out_color.g = uint(control == bool(true));
}
