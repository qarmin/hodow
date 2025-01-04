#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
int64_t expectKHR(int64_t, int64_t);
precision highp float;
precision highp int;
layout(location = 0) out uvec2 out_color;
layout(set = 0, binding = 0, std430) buffer Block1 { int64_t inputBuffer[]; };
void main()
{
    int64_t control = int64_t(uint(gl_FragCoord.x)*2 + 3);
    if ( expectKHR(inputBuffer[uint(gl_FragCoord.x)], int64_t(uint(gl_FragCoord.x))) == int64_t(uint(gl_FragCoord.x)) ) {
        control = int64_t(uint(gl_FragCoord.x));
    } else {
        // set wrong value
        control = int64_t(uint(gl_FragCoord.x)*2 + 3);
    }
    out_color.r = int(gl_FragCoord.x);
    out_color.g = uint(control == int64_t(uint(gl_FragCoord.x)*2 + 3));
}
