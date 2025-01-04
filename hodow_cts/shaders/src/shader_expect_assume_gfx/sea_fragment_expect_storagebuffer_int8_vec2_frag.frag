#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int8: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i8vec2 expectKHR(i8vec2, i8vec2);
precision highp float;
precision highp int;
layout(location = 0) out uvec2 out_color;
layout(set = 0, binding = 0, std430) buffer Block1 { i8vec2 inputBuffer[]; };
void main()
{
    i8vec2 control = i8vec2(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1);
    if ( expectKHR(inputBuffer[uint(gl_FragCoord.x)], i8vec2(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1)) == i8vec2(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1) ) {
        control = i8vec2(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1);
    } else {
        // set wrong value
        control = i8vec2(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1);
    }
    out_color.r = int(gl_FragCoord.x);
    out_color.g = uint(control == i8vec2(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1));
}
