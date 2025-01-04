#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int32: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i32vec3 expectKHR(i32vec3, i32vec3);
precision highp float;
precision highp int;
layout(location = 0) out uvec2 out_color;
layout(set = 0, binding = 0, std430) buffer Block1 { i32vec3 inputBuffer[]; };
void main()
{
    i32vec3 control = i32vec3(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1, uint(gl_FragCoord.x)*2 + 3 + 2);
    if ( expectKHR(inputBuffer[uint(gl_FragCoord.x)], i32vec3(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2)) == i32vec3(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2) ) {
        control = i32vec3(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2);
    } else {
        // set wrong value
        control = i32vec3(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1, uint(gl_FragCoord.x)*2 + 3 + 2);
    }
    out_color.r = int(gl_FragCoord.x);
    out_color.g = uint(control == i32vec3(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1, uint(gl_FragCoord.x)*2 + 3 + 2));
}
