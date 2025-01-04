#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int16: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i16vec2 expectKHR(i16vec2, i16vec2);
precision highp float;
precision highp int;
layout(location = 0) in vec4 in_position;
layout(location = 0) out flat uint value;
layout(set = 0, binding = 0, std430) buffer Block1 { i16vec2 inputBuffer[]; };
void main() {
    i16vec2 control = i16vec2(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1);
    if ( expectKHR(inputBuffer[gl_VertexIndex], i16vec2(gl_VertexIndex, gl_VertexIndex + 1)) == i16vec2(gl_VertexIndex, gl_VertexIndex + 1) ) {
        control = i16vec2(gl_VertexIndex, gl_VertexIndex + 1);
    } else {
        // set wrong value
        control = i16vec2(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1);
    }
    gl_Position  = in_position;
    value = uint(control == i16vec2(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1));
}
