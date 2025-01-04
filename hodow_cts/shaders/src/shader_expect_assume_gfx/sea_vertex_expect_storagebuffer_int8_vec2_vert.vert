#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int8: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i8vec2 expectKHR(i8vec2, i8vec2);
precision highp float;
precision highp int;
layout(location = 0) in vec4 in_position;
layout(location = 0) out flat uint value;
layout(set = 0, binding = 0, std430) buffer Block1 { i8vec2 inputBuffer[]; };
void main() {
    i8vec2 control = i8vec2(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1);
    if ( expectKHR(inputBuffer[gl_VertexIndex], i8vec2(gl_VertexIndex, gl_VertexIndex + 1)) == i8vec2(gl_VertexIndex, gl_VertexIndex + 1) ) {
        control = i8vec2(gl_VertexIndex, gl_VertexIndex + 1);
    } else {
        // set wrong value
        control = i8vec2(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1);
    }
    gl_Position  = in_position;
    value = uint(control == i8vec2(gl_VertexIndex, gl_VertexIndex + 1));
}
