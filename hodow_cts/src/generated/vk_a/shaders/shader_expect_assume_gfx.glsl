#version 460
#extension GL_EXT_spirv_intrinsics: enable

spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
bool expectKHR(bool, bool);
precision highp float;
precision highp int;
layout(location = 0) in vec4 in_position;
layout(location = 0) out flat uint value;
bool kThisIsTrue = true;
void main() {
    bool control = false;
    if ( expectKHR(kThisIsTrue, true) == true ) {
        control = true;
    } else {
        // set wrong value
        control = false;
    }
    gl_Position  = in_position;
    value = uint(control == true);
}
#version 460
precision highp float;
precision highp int;
layout(location = 0) in flat uint value;
layout(location = 0) out uvec2 out_color;
void main()
{
    out_color.r = uint(gl_FragCoord.x);
    out_color.g = value;
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable

spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
bool expectKHR(bool, bool);
precision highp float;
precision highp int;
layout(location = 0) in vec4 in_position;
layout(location = 0) out flat uint value;
layout (constant_id = 0) const bool scThisIsTrue = false;
void main() {
    bool control = false;
    if ( expectKHR(scThisIsTrue, true) == true ) {
        control = true;
    } else {
        // set wrong value
        control = false;
    }
    gl_Position  = in_position;
    value = uint(control == true);
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable

spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
bool expectKHR(bool, bool);
precision highp float;
precision highp int;
layout(location = 0) in vec4 in_position;
layout(location = 0) out flat uint value;
layout( push_constant, std430 ) uniform pc { layout(offset = 0) bool pcThisIsTrue; };
void main() {
    bool control = false;
    if ( expectKHR(pcThisIsTrue, true) == true ) {
        control = true;
    } else {
        // set wrong value
        control = false;
    }
    gl_Position  = in_position;
    value = uint(control == true);
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable

spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
bool expectKHR(bool, bool);
precision highp float;
precision highp int;
layout(location = 0) in vec4 in_position;
layout(location = 0) out flat uint value;
layout(set = 0, binding = 0, std430) buffer Block1 { bool inputBuffer[]; };
void main() {
    bool control = bool(false);
    if ( expectKHR(inputBuffer[gl_VertexIndex], bool(true)) == bool(true) ) {
        control = bool(true);
    } else {
        // set wrong value
        control = bool(false);
    }
    gl_Position  = in_position;
    value = uint(control == bool(true));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int8: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
int8_t expectKHR(int8_t, int8_t);
precision highp float;
precision highp int;
layout(location = 0) in vec4 in_position;
layout(location = 0) out flat uint value;
layout(set = 0, binding = 0, std430) buffer Block1 { int8_t inputBuffer[]; };
void main() {
    int8_t control = int8_t(gl_VertexIndex*2 + 3);
    if ( expectKHR(inputBuffer[gl_VertexIndex], int8_t(gl_VertexIndex)) == int8_t(gl_VertexIndex) ) {
        control = int8_t(gl_VertexIndex);
    } else {
        // set wrong value
        control = int8_t(gl_VertexIndex*2 + 3);
    }
    gl_Position  = in_position;
    value = uint(control == int8_t(gl_VertexIndex));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int16: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
int16_t expectKHR(int16_t, int16_t);
precision highp float;
precision highp int;
layout(location = 0) in vec4 in_position;
layout(location = 0) out flat uint value;
layout(set = 0, binding = 0, std430) buffer Block1 { int16_t inputBuffer[]; };
void main() {
    int16_t control = int16_t(gl_VertexIndex*2 + 3);
    if ( expectKHR(inputBuffer[gl_VertexIndex], int16_t(gl_VertexIndex)) == int16_t(gl_VertexIndex) ) {
        control = int16_t(gl_VertexIndex);
    } else {
        // set wrong value
        control = int16_t(gl_VertexIndex*2 + 3);
    }
    gl_Position  = in_position;
    value = uint(control == int16_t(gl_VertexIndex));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int32: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
int32_t expectKHR(int32_t, int32_t);
precision highp float;
precision highp int;
layout(location = 0) in vec4 in_position;
layout(location = 0) out flat uint value;
layout(set = 0, binding = 0, std430) buffer Block1 { int32_t inputBuffer[]; };
void main() {
    int32_t control = int32_t(gl_VertexIndex*2 + 3);
    if ( expectKHR(inputBuffer[gl_VertexIndex], int32_t(gl_VertexIndex)) == int32_t(gl_VertexIndex) ) {
        control = int32_t(gl_VertexIndex);
    } else {
        // set wrong value
        control = int32_t(gl_VertexIndex*2 + 3);
    }
    gl_Position  = in_position;
    value = uint(control == int32_t(gl_VertexIndex));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
int64_t expectKHR(int64_t, int64_t);
precision highp float;
precision highp int;
layout(location = 0) in vec4 in_position;
layout(location = 0) out flat uint value;
layout(set = 0, binding = 0, std430) buffer Block1 { int64_t inputBuffer[]; };
void main() {
    int64_t control = int64_t(gl_VertexIndex*2 + 3);
    if ( expectKHR(inputBuffer[gl_VertexIndex], int64_t(gl_VertexIndex)) == int64_t(gl_VertexIndex) ) {
        control = int64_t(gl_VertexIndex);
    } else {
        // set wrong value
        control = int64_t(gl_VertexIndex*2 + 3);
    }
    gl_Position  = in_position;
    value = uint(control == int64_t(gl_VertexIndex));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable

spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
bool expectKHR(bool, bool);
precision highp float;
precision highp int;
layout(location = 0) in vec4 in_position;
layout(location = 0) out flat uint value;
bool kThisIsTrue = true;
void main() {
    assumeTrueKHR (kThisIsTrue);
    gl_Position  = in_position;
    value = uint(kThisIsTrue);
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable

spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
bool expectKHR(bool, bool);
precision highp float;
precision highp int;
layout(location = 0) in vec4 in_position;
layout(location = 0) out flat uint value;
layout (constant_id = 0) const bool scThisIsTrue = false;
void main() {
    assumeTrueKHR (scThisIsTrue);
    gl_Position  = in_position;
    value = uint(scThisIsTrue);
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable

spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
bool expectKHR(bool, bool);
precision highp float;
precision highp int;
layout(location = 0) in vec4 in_position;
layout(location = 0) out flat uint value;
layout( push_constant, std430 ) uniform pc { layout(offset = 0) bool pcThisIsTrue; };
void main() {
    assumeTrueKHR (pcThisIsTrue);
    gl_Position  = in_position;
    value = uint(pcThisIsTrue);
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable

spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
bool expectKHR(bool, bool);
precision highp float;
precision highp int;
layout(location = 0) in vec4 in_position;
layout(location = 0) out flat uint value;
layout(set = 0, binding = 0, std430) buffer Block1 { bool inputBuffer[]; };
void main() {
    assumeTrueKHR (inputBuffer[gl_VertexIndex]);
    gl_Position  = in_position;
    value = uint(inputBuffer[gl_VertexIndex]);
}
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
    value = uint(control == bvec2(true));
}
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
    value = uint(control == i16vec2(gl_VertexIndex, gl_VertexIndex + 1));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int32: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i32vec2 expectKHR(i32vec2, i32vec2);
precision highp float;
precision highp int;
layout(location = 0) in vec4 in_position;
layout(location = 0) out flat uint value;
layout(set = 0, binding = 0, std430) buffer Block1 { i32vec2 inputBuffer[]; };
void main() {
    i32vec2 control = i32vec2(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1);
    if ( expectKHR(inputBuffer[gl_VertexIndex], i32vec2(gl_VertexIndex, gl_VertexIndex + 1)) == i32vec2(gl_VertexIndex, gl_VertexIndex + 1) ) {
        control = i32vec2(gl_VertexIndex, gl_VertexIndex + 1);
    } else {
        // set wrong value
        control = i32vec2(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1);
    }
    gl_Position  = in_position;
    value = uint(control == i32vec2(gl_VertexIndex, gl_VertexIndex + 1));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i64vec2 expectKHR(i64vec2, i64vec2);
precision highp float;
precision highp int;
layout(location = 0) in vec4 in_position;
layout(location = 0) out flat uint value;
layout(set = 0, binding = 0, std430) buffer Block1 { i64vec2 inputBuffer[]; };
void main() {
    i64vec2 control = i64vec2(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1);
    if ( expectKHR(inputBuffer[gl_VertexIndex], i64vec2(gl_VertexIndex, gl_VertexIndex + 1)) == i64vec2(gl_VertexIndex, gl_VertexIndex + 1) ) {
        control = i64vec2(gl_VertexIndex, gl_VertexIndex + 1);
    } else {
        // set wrong value
        control = i64vec2(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1);
    }
    gl_Position  = in_position;
    value = uint(control == i64vec2(gl_VertexIndex, gl_VertexIndex + 1));
}
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
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int8: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i8vec3 expectKHR(i8vec3, i8vec3);
precision highp float;
precision highp int;
layout(location = 0) in vec4 in_position;
layout(location = 0) out flat uint value;
layout(set = 0, binding = 0, std430) buffer Block1 { i8vec3 inputBuffer[]; };
void main() {
    i8vec3 control = i8vec3(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1, gl_VertexIndex*2 + 3 + 2);
    if ( expectKHR(inputBuffer[gl_VertexIndex], i8vec3(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2)) == i8vec3(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2) ) {
        control = i8vec3(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2);
    } else {
        // set wrong value
        control = i8vec3(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1, gl_VertexIndex*2 + 3 + 2);
    }
    gl_Position  = in_position;
    value = uint(control == i8vec3(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int16: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i16vec3 expectKHR(i16vec3, i16vec3);
precision highp float;
precision highp int;
layout(location = 0) in vec4 in_position;
layout(location = 0) out flat uint value;
layout(set = 0, binding = 0, std430) buffer Block1 { i16vec3 inputBuffer[]; };
void main() {
    i16vec3 control = i16vec3(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1, gl_VertexIndex*2 + 3 + 2);
    if ( expectKHR(inputBuffer[gl_VertexIndex], i16vec3(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2)) == i16vec3(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2) ) {
        control = i16vec3(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2);
    } else {
        // set wrong value
        control = i16vec3(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1, gl_VertexIndex*2 + 3 + 2);
    }
    gl_Position  = in_position;
    value = uint(control == i16vec3(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int32: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i32vec3 expectKHR(i32vec3, i32vec3);
precision highp float;
precision highp int;
layout(location = 0) in vec4 in_position;
layout(location = 0) out flat uint value;
layout(set = 0, binding = 0, std430) buffer Block1 { i32vec3 inputBuffer[]; };
void main() {
    i32vec3 control = i32vec3(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1, gl_VertexIndex*2 + 3 + 2);
    if ( expectKHR(inputBuffer[gl_VertexIndex], i32vec3(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2)) == i32vec3(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2) ) {
        control = i32vec3(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2);
    } else {
        // set wrong value
        control = i32vec3(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1, gl_VertexIndex*2 + 3 + 2);
    }
    gl_Position  = in_position;
    value = uint(control == i32vec3(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i64vec3 expectKHR(i64vec3, i64vec3);
precision highp float;
precision highp int;
layout(location = 0) in vec4 in_position;
layout(location = 0) out flat uint value;
layout(set = 0, binding = 0, std430) buffer Block1 { i64vec3 inputBuffer[]; };
void main() {
    i64vec3 control = i64vec3(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1, gl_VertexIndex*2 + 3 + 2);
    if ( expectKHR(inputBuffer[gl_VertexIndex], i64vec3(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2)) == i64vec3(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2) ) {
        control = i64vec3(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2);
    } else {
        // set wrong value
        control = i64vec3(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1, gl_VertexIndex*2 + 3 + 2);
    }
    gl_Position  = in_position;
    value = uint(control == i64vec3(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable

spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
bvec4 expectKHR(bvec4, bvec4);
precision highp float;
precision highp int;
layout(location = 0) in vec4 in_position;
layout(location = 0) out flat uint value;
layout(set = 0, binding = 0, std430) buffer Block1 { bvec4 inputBuffer[]; };
void main() {
    bvec4 control = bvec4(false);
    if ( expectKHR(inputBuffer[gl_VertexIndex], bvec4(true)) == bvec4(true) ) {
        control = bvec4(true);
    } else {
        // set wrong value
        control = bvec4(false);
    }
    gl_Position  = in_position;
    value = uint(control == bvec4(true));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int8: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i8vec4 expectKHR(i8vec4, i8vec4);
precision highp float;
precision highp int;
layout(location = 0) in vec4 in_position;
layout(location = 0) out flat uint value;
layout(set = 0, binding = 0, std430) buffer Block1 { i8vec4 inputBuffer[]; };
void main() {
    i8vec4 control = i8vec4(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1, gl_VertexIndex*2 + 3 + 2, gl_VertexIndex*2 + 3 + 3);
    if ( expectKHR(inputBuffer[gl_VertexIndex], i8vec4(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2, gl_VertexIndex + 3)) == i8vec4(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2, gl_VertexIndex + 3) ) {
        control = i8vec4(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2, gl_VertexIndex + 3);
    } else {
        // set wrong value
        control = i8vec4(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1, gl_VertexIndex*2 + 3 + 2, gl_VertexIndex*2 + 3 + 3);
    }
    gl_Position  = in_position;
    value = uint(control == i8vec4(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2, gl_VertexIndex + 3));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int16: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i16vec4 expectKHR(i16vec4, i16vec4);
precision highp float;
precision highp int;
layout(location = 0) in vec4 in_position;
layout(location = 0) out flat uint value;
layout(set = 0, binding = 0, std430) buffer Block1 { i16vec4 inputBuffer[]; };
void main() {
    i16vec4 control = i16vec4(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1, gl_VertexIndex*2 + 3 + 2, gl_VertexIndex*2 + 3 + 3);
    if ( expectKHR(inputBuffer[gl_VertexIndex], i16vec4(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2, gl_VertexIndex + 3)) == i16vec4(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2, gl_VertexIndex + 3) ) {
        control = i16vec4(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2, gl_VertexIndex + 3);
    } else {
        // set wrong value
        control = i16vec4(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1, gl_VertexIndex*2 + 3 + 2, gl_VertexIndex*2 + 3 + 3);
    }
    gl_Position  = in_position;
    value = uint(control == i16vec4(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2, gl_VertexIndex + 3));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int32: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i32vec4 expectKHR(i32vec4, i32vec4);
precision highp float;
precision highp int;
layout(location = 0) in vec4 in_position;
layout(location = 0) out flat uint value;
layout(set = 0, binding = 0, std430) buffer Block1 { i32vec4 inputBuffer[]; };
void main() {
    i32vec4 control = i32vec4(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1, gl_VertexIndex*2 + 3 + 2, gl_VertexIndex*2 + 3 + 3);
    if ( expectKHR(inputBuffer[gl_VertexIndex], i32vec4(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2, gl_VertexIndex + 3)) == i32vec4(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2, gl_VertexIndex + 3) ) {
        control = i32vec4(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2, gl_VertexIndex + 3);
    } else {
        // set wrong value
        control = i32vec4(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1, gl_VertexIndex*2 + 3 + 2, gl_VertexIndex*2 + 3 + 3);
    }
    gl_Position  = in_position;
    value = uint(control == i32vec4(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2, gl_VertexIndex + 3));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i64vec4 expectKHR(i64vec4, i64vec4);
precision highp float;
precision highp int;
layout(location = 0) in vec4 in_position;
layout(location = 0) out flat uint value;
layout(set = 0, binding = 0, std430) buffer Block1 { i64vec4 inputBuffer[]; };
void main() {
    i64vec4 control = i64vec4(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1, gl_VertexIndex*2 + 3 + 2, gl_VertexIndex*2 + 3 + 3);
    if ( expectKHR(inputBuffer[gl_VertexIndex], i64vec4(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2, gl_VertexIndex + 3)) == i64vec4(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2, gl_VertexIndex + 3) ) {
        control = i64vec4(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2, gl_VertexIndex + 3);
    } else {
        // set wrong value
        control = i64vec4(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1, gl_VertexIndex*2 + 3 + 2, gl_VertexIndex*2 + 3 + 3);
    }
    gl_Position  = in_position;
    value = uint(control == i64vec4(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2, gl_VertexIndex + 3));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable

spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
bool expectKHR(bool, bool);
precision highp float;
precision highp int;
layout(location = 0) in vec4 in_position;
layout(location = 0) out flat uint value;
layout(set = 0, binding = 0, std430) buffer Block1 { bool inputBuffer[]; };
void main() {
    bool control = bool(false);
    if ( expectKHR(inputBuffer[gl_VertexIndex], bool(true)) == bool(true) ) {
        control = bool(true);
    } else {
        // set wrong value
        control = bool(false);
    }
    gl_Position  = in_position;
    value = uint(control == bool(false));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int8: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
int8_t expectKHR(int8_t, int8_t);
precision highp float;
precision highp int;
layout(location = 0) in vec4 in_position;
layout(location = 0) out flat uint value;
layout(set = 0, binding = 0, std430) buffer Block1 { int8_t inputBuffer[]; };
void main() {
    int8_t control = int8_t(gl_VertexIndex*2 + 3);
    if ( expectKHR(inputBuffer[gl_VertexIndex], int8_t(gl_VertexIndex)) == int8_t(gl_VertexIndex) ) {
        control = int8_t(gl_VertexIndex);
    } else {
        // set wrong value
        control = int8_t(gl_VertexIndex*2 + 3);
    }
    gl_Position  = in_position;
    value = uint(control == int8_t(gl_VertexIndex*2 + 3));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int16: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
int16_t expectKHR(int16_t, int16_t);
precision highp float;
precision highp int;
layout(location = 0) in vec4 in_position;
layout(location = 0) out flat uint value;
layout(set = 0, binding = 0, std430) buffer Block1 { int16_t inputBuffer[]; };
void main() {
    int16_t control = int16_t(gl_VertexIndex*2 + 3);
    if ( expectKHR(inputBuffer[gl_VertexIndex], int16_t(gl_VertexIndex)) == int16_t(gl_VertexIndex) ) {
        control = int16_t(gl_VertexIndex);
    } else {
        // set wrong value
        control = int16_t(gl_VertexIndex*2 + 3);
    }
    gl_Position  = in_position;
    value = uint(control == int16_t(gl_VertexIndex*2 + 3));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int32: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
int32_t expectKHR(int32_t, int32_t);
precision highp float;
precision highp int;
layout(location = 0) in vec4 in_position;
layout(location = 0) out flat uint value;
layout(set = 0, binding = 0, std430) buffer Block1 { int32_t inputBuffer[]; };
void main() {
    int32_t control = int32_t(gl_VertexIndex*2 + 3);
    if ( expectKHR(inputBuffer[gl_VertexIndex], int32_t(gl_VertexIndex)) == int32_t(gl_VertexIndex) ) {
        control = int32_t(gl_VertexIndex);
    } else {
        // set wrong value
        control = int32_t(gl_VertexIndex*2 + 3);
    }
    gl_Position  = in_position;
    value = uint(control == int32_t(gl_VertexIndex*2 + 3));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
int64_t expectKHR(int64_t, int64_t);
precision highp float;
precision highp int;
layout(location = 0) in vec4 in_position;
layout(location = 0) out flat uint value;
layout(set = 0, binding = 0, std430) buffer Block1 { int64_t inputBuffer[]; };
void main() {
    int64_t control = int64_t(gl_VertexIndex*2 + 3);
    if ( expectKHR(inputBuffer[gl_VertexIndex], int64_t(gl_VertexIndex)) == int64_t(gl_VertexIndex) ) {
        control = int64_t(gl_VertexIndex);
    } else {
        // set wrong value
        control = int64_t(gl_VertexIndex*2 + 3);
    }
    gl_Position  = in_position;
    value = uint(control == int64_t(gl_VertexIndex*2 + 3));
}
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
    value = uint(control == i8vec2(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1));
}
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
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int32: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i32vec2 expectKHR(i32vec2, i32vec2);
precision highp float;
precision highp int;
layout(location = 0) in vec4 in_position;
layout(location = 0) out flat uint value;
layout(set = 0, binding = 0, std430) buffer Block1 { i32vec2 inputBuffer[]; };
void main() {
    i32vec2 control = i32vec2(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1);
    if ( expectKHR(inputBuffer[gl_VertexIndex], i32vec2(gl_VertexIndex, gl_VertexIndex + 1)) == i32vec2(gl_VertexIndex, gl_VertexIndex + 1) ) {
        control = i32vec2(gl_VertexIndex, gl_VertexIndex + 1);
    } else {
        // set wrong value
        control = i32vec2(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1);
    }
    gl_Position  = in_position;
    value = uint(control == i32vec2(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i64vec2 expectKHR(i64vec2, i64vec2);
precision highp float;
precision highp int;
layout(location = 0) in vec4 in_position;
layout(location = 0) out flat uint value;
layout(set = 0, binding = 0, std430) buffer Block1 { i64vec2 inputBuffer[]; };
void main() {
    i64vec2 control = i64vec2(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1);
    if ( expectKHR(inputBuffer[gl_VertexIndex], i64vec2(gl_VertexIndex, gl_VertexIndex + 1)) == i64vec2(gl_VertexIndex, gl_VertexIndex + 1) ) {
        control = i64vec2(gl_VertexIndex, gl_VertexIndex + 1);
    } else {
        // set wrong value
        control = i64vec2(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1);
    }
    gl_Position  = in_position;
    value = uint(control == i64vec2(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1));
}
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
    value = uint(control == bvec3(false));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int8: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i8vec3 expectKHR(i8vec3, i8vec3);
precision highp float;
precision highp int;
layout(location = 0) in vec4 in_position;
layout(location = 0) out flat uint value;
layout(set = 0, binding = 0, std430) buffer Block1 { i8vec3 inputBuffer[]; };
void main() {
    i8vec3 control = i8vec3(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1, gl_VertexIndex*2 + 3 + 2);
    if ( expectKHR(inputBuffer[gl_VertexIndex], i8vec3(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2)) == i8vec3(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2) ) {
        control = i8vec3(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2);
    } else {
        // set wrong value
        control = i8vec3(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1, gl_VertexIndex*2 + 3 + 2);
    }
    gl_Position  = in_position;
    value = uint(control == i8vec3(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1, gl_VertexIndex*2 + 3 + 2));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int16: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i16vec3 expectKHR(i16vec3, i16vec3);
precision highp float;
precision highp int;
layout(location = 0) in vec4 in_position;
layout(location = 0) out flat uint value;
layout(set = 0, binding = 0, std430) buffer Block1 { i16vec3 inputBuffer[]; };
void main() {
    i16vec3 control = i16vec3(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1, gl_VertexIndex*2 + 3 + 2);
    if ( expectKHR(inputBuffer[gl_VertexIndex], i16vec3(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2)) == i16vec3(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2) ) {
        control = i16vec3(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2);
    } else {
        // set wrong value
        control = i16vec3(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1, gl_VertexIndex*2 + 3 + 2);
    }
    gl_Position  = in_position;
    value = uint(control == i16vec3(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1, gl_VertexIndex*2 + 3 + 2));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int32: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i32vec3 expectKHR(i32vec3, i32vec3);
precision highp float;
precision highp int;
layout(location = 0) in vec4 in_position;
layout(location = 0) out flat uint value;
layout(set = 0, binding = 0, std430) buffer Block1 { i32vec3 inputBuffer[]; };
void main() {
    i32vec3 control = i32vec3(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1, gl_VertexIndex*2 + 3 + 2);
    if ( expectKHR(inputBuffer[gl_VertexIndex], i32vec3(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2)) == i32vec3(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2) ) {
        control = i32vec3(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2);
    } else {
        // set wrong value
        control = i32vec3(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1, gl_VertexIndex*2 + 3 + 2);
    }
    gl_Position  = in_position;
    value = uint(control == i32vec3(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1, gl_VertexIndex*2 + 3 + 2));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i64vec3 expectKHR(i64vec3, i64vec3);
precision highp float;
precision highp int;
layout(location = 0) in vec4 in_position;
layout(location = 0) out flat uint value;
layout(set = 0, binding = 0, std430) buffer Block1 { i64vec3 inputBuffer[]; };
void main() {
    i64vec3 control = i64vec3(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1, gl_VertexIndex*2 + 3 + 2);
    if ( expectKHR(inputBuffer[gl_VertexIndex], i64vec3(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2)) == i64vec3(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2) ) {
        control = i64vec3(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2);
    } else {
        // set wrong value
        control = i64vec3(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1, gl_VertexIndex*2 + 3 + 2);
    }
    gl_Position  = in_position;
    value = uint(control == i64vec3(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1, gl_VertexIndex*2 + 3 + 2));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable

spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
bvec4 expectKHR(bvec4, bvec4);
precision highp float;
precision highp int;
layout(location = 0) in vec4 in_position;
layout(location = 0) out flat uint value;
layout(set = 0, binding = 0, std430) buffer Block1 { bvec4 inputBuffer[]; };
void main() {
    bvec4 control = bvec4(false);
    if ( expectKHR(inputBuffer[gl_VertexIndex], bvec4(true)) == bvec4(true) ) {
        control = bvec4(true);
    } else {
        // set wrong value
        control = bvec4(false);
    }
    gl_Position  = in_position;
    value = uint(control == bvec4(false));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int8: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i8vec4 expectKHR(i8vec4, i8vec4);
precision highp float;
precision highp int;
layout(location = 0) in vec4 in_position;
layout(location = 0) out flat uint value;
layout(set = 0, binding = 0, std430) buffer Block1 { i8vec4 inputBuffer[]; };
void main() {
    i8vec4 control = i8vec4(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1, gl_VertexIndex*2 + 3 + 2, gl_VertexIndex*2 + 3 + 3);
    if ( expectKHR(inputBuffer[gl_VertexIndex], i8vec4(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2, gl_VertexIndex + 3)) == i8vec4(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2, gl_VertexIndex + 3) ) {
        control = i8vec4(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2, gl_VertexIndex + 3);
    } else {
        // set wrong value
        control = i8vec4(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1, gl_VertexIndex*2 + 3 + 2, gl_VertexIndex*2 + 3 + 3);
    }
    gl_Position  = in_position;
    value = uint(control == i8vec4(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1, gl_VertexIndex*2 + 3 + 2, gl_VertexIndex*2 + 3 + 3));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int16: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i16vec4 expectKHR(i16vec4, i16vec4);
precision highp float;
precision highp int;
layout(location = 0) in vec4 in_position;
layout(location = 0) out flat uint value;
layout(set = 0, binding = 0, std430) buffer Block1 { i16vec4 inputBuffer[]; };
void main() {
    i16vec4 control = i16vec4(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1, gl_VertexIndex*2 + 3 + 2, gl_VertexIndex*2 + 3 + 3);
    if ( expectKHR(inputBuffer[gl_VertexIndex], i16vec4(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2, gl_VertexIndex + 3)) == i16vec4(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2, gl_VertexIndex + 3) ) {
        control = i16vec4(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2, gl_VertexIndex + 3);
    } else {
        // set wrong value
        control = i16vec4(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1, gl_VertexIndex*2 + 3 + 2, gl_VertexIndex*2 + 3 + 3);
    }
    gl_Position  = in_position;
    value = uint(control == i16vec4(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1, gl_VertexIndex*2 + 3 + 2, gl_VertexIndex*2 + 3 + 3));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int32: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i32vec4 expectKHR(i32vec4, i32vec4);
precision highp float;
precision highp int;
layout(location = 0) in vec4 in_position;
layout(location = 0) out flat uint value;
layout(set = 0, binding = 0, std430) buffer Block1 { i32vec4 inputBuffer[]; };
void main() {
    i32vec4 control = i32vec4(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1, gl_VertexIndex*2 + 3 + 2, gl_VertexIndex*2 + 3 + 3);
    if ( expectKHR(inputBuffer[gl_VertexIndex], i32vec4(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2, gl_VertexIndex + 3)) == i32vec4(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2, gl_VertexIndex + 3) ) {
        control = i32vec4(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2, gl_VertexIndex + 3);
    } else {
        // set wrong value
        control = i32vec4(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1, gl_VertexIndex*2 + 3 + 2, gl_VertexIndex*2 + 3 + 3);
    }
    gl_Position  = in_position;
    value = uint(control == i32vec4(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1, gl_VertexIndex*2 + 3 + 2, gl_VertexIndex*2 + 3 + 3));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i64vec4 expectKHR(i64vec4, i64vec4);
precision highp float;
precision highp int;
layout(location = 0) in vec4 in_position;
layout(location = 0) out flat uint value;
layout(set = 0, binding = 0, std430) buffer Block1 { i64vec4 inputBuffer[]; };
void main() {
    i64vec4 control = i64vec4(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1, gl_VertexIndex*2 + 3 + 2, gl_VertexIndex*2 + 3 + 3);
    if ( expectKHR(inputBuffer[gl_VertexIndex], i64vec4(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2, gl_VertexIndex + 3)) == i64vec4(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2, gl_VertexIndex + 3) ) {
        control = i64vec4(gl_VertexIndex, gl_VertexIndex + 1, gl_VertexIndex + 2, gl_VertexIndex + 3);
    } else {
        // set wrong value
        control = i64vec4(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1, gl_VertexIndex*2 + 3 + 2, gl_VertexIndex*2 + 3 + 3);
    }
    gl_Position  = in_position;
    value = uint(control == i64vec4(gl_VertexIndex*2 + 3, gl_VertexIndex*2 + 3 + 1, gl_VertexIndex*2 + 3 + 2, gl_VertexIndex*2 + 3 + 3));
}
#version 460
precision highp float;
precision highp int;
layout(location = 0) in vec4 in_position;
void main() {
    gl_Position  = in_position;
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable

spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
bool expectKHR(bool, bool);
precision highp float;
precision highp int;
layout(location = 0) out uvec2 out_color;
bool kThisIsTrue = true;
void main()
{
    bool control = false;
    if ( expectKHR(kThisIsTrue, true) == true ) {
        control = true;
    } else {
        // set wrong value
        control = false;
    }
    out_color.r = int(gl_FragCoord.x);
    out_color.g = uint(control == true);
}
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
#version 460
#extension GL_EXT_spirv_intrinsics: enable

spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
bool expectKHR(bool, bool);
precision highp float;
precision highp int;
layout(location = 0) out uvec2 out_color;
layout( push_constant, std430 ) uniform pc { layout(offset = 0) bool pcThisIsTrue; };
void main()
{
    bool control = false;
    if ( expectKHR(pcThisIsTrue, true) == true ) {
        control = true;
    } else {
        // set wrong value
        control = false;
    }
    out_color.r = int(gl_FragCoord.x);
    out_color.g = uint(control == true);
}
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
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int8: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
int8_t expectKHR(int8_t, int8_t);
precision highp float;
precision highp int;
layout(location = 0) out uvec2 out_color;
layout(set = 0, binding = 0, std430) buffer Block1 { int8_t inputBuffer[]; };
void main()
{
    int8_t control = int8_t(uint(gl_FragCoord.x)*2 + 3);
    if ( expectKHR(inputBuffer[uint(gl_FragCoord.x)], int8_t(uint(gl_FragCoord.x))) == int8_t(uint(gl_FragCoord.x)) ) {
        control = int8_t(uint(gl_FragCoord.x));
    } else {
        // set wrong value
        control = int8_t(uint(gl_FragCoord.x)*2 + 3);
    }
    out_color.r = int(gl_FragCoord.x);
    out_color.g = uint(control == int8_t(uint(gl_FragCoord.x)));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int16: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
int16_t expectKHR(int16_t, int16_t);
precision highp float;
precision highp int;
layout(location = 0) out uvec2 out_color;
layout(set = 0, binding = 0, std430) buffer Block1 { int16_t inputBuffer[]; };
void main()
{
    int16_t control = int16_t(uint(gl_FragCoord.x)*2 + 3);
    if ( expectKHR(inputBuffer[uint(gl_FragCoord.x)], int16_t(uint(gl_FragCoord.x))) == int16_t(uint(gl_FragCoord.x)) ) {
        control = int16_t(uint(gl_FragCoord.x));
    } else {
        // set wrong value
        control = int16_t(uint(gl_FragCoord.x)*2 + 3);
    }
    out_color.r = int(gl_FragCoord.x);
    out_color.g = uint(control == int16_t(uint(gl_FragCoord.x)));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int32: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
int32_t expectKHR(int32_t, int32_t);
precision highp float;
precision highp int;
layout(location = 0) out uvec2 out_color;
layout(set = 0, binding = 0, std430) buffer Block1 { int32_t inputBuffer[]; };
void main()
{
    int32_t control = int32_t(uint(gl_FragCoord.x)*2 + 3);
    if ( expectKHR(inputBuffer[uint(gl_FragCoord.x)], int32_t(uint(gl_FragCoord.x))) == int32_t(uint(gl_FragCoord.x)) ) {
        control = int32_t(uint(gl_FragCoord.x));
    } else {
        // set wrong value
        control = int32_t(uint(gl_FragCoord.x)*2 + 3);
    }
    out_color.r = int(gl_FragCoord.x);
    out_color.g = uint(control == int32_t(uint(gl_FragCoord.x)));
}
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
    out_color.g = uint(control == int64_t(uint(gl_FragCoord.x)));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable

spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
bool expectKHR(bool, bool);
precision highp float;
precision highp int;
layout(location = 0) out uvec2 out_color;
bool kThisIsTrue = true;
void main()
{
    assumeTrueKHR (kThisIsTrue);
    out_color.r = int(gl_FragCoord.x);
    out_color.g = uint(kThisIsTrue);
}
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
    assumeTrueKHR (scThisIsTrue);
    out_color.r = int(gl_FragCoord.x);
    out_color.g = uint(scThisIsTrue);
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable

spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
bool expectKHR(bool, bool);
precision highp float;
precision highp int;
layout(location = 0) out uvec2 out_color;
layout( push_constant, std430 ) uniform pc { layout(offset = 0) bool pcThisIsTrue; };
void main()
{
    assumeTrueKHR (pcThisIsTrue);
    out_color.r = int(gl_FragCoord.x);
    out_color.g = uint(pcThisIsTrue);
}
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
    assumeTrueKHR (inputBuffer[uint(gl_FragCoord.x)]);
    out_color.r = int(gl_FragCoord.x);
    out_color.g = uint(inputBuffer[uint(gl_FragCoord.x)]);
}
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
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int16: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i16vec2 expectKHR(i16vec2, i16vec2);
precision highp float;
precision highp int;
layout(location = 0) out uvec2 out_color;
layout(set = 0, binding = 0, std430) buffer Block1 { i16vec2 inputBuffer[]; };
void main()
{
    i16vec2 control = i16vec2(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1);
    if ( expectKHR(inputBuffer[uint(gl_FragCoord.x)], i16vec2(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1)) == i16vec2(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1) ) {
        control = i16vec2(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1);
    } else {
        // set wrong value
        control = i16vec2(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1);
    }
    out_color.r = int(gl_FragCoord.x);
    out_color.g = uint(control == i16vec2(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int32: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i32vec2 expectKHR(i32vec2, i32vec2);
precision highp float;
precision highp int;
layout(location = 0) out uvec2 out_color;
layout(set = 0, binding = 0, std430) buffer Block1 { i32vec2 inputBuffer[]; };
void main()
{
    i32vec2 control = i32vec2(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1);
    if ( expectKHR(inputBuffer[uint(gl_FragCoord.x)], i32vec2(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1)) == i32vec2(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1) ) {
        control = i32vec2(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1);
    } else {
        // set wrong value
        control = i32vec2(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1);
    }
    out_color.r = int(gl_FragCoord.x);
    out_color.g = uint(control == i32vec2(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i64vec2 expectKHR(i64vec2, i64vec2);
precision highp float;
precision highp int;
layout(location = 0) out uvec2 out_color;
layout(set = 0, binding = 0, std430) buffer Block1 { i64vec2 inputBuffer[]; };
void main()
{
    i64vec2 control = i64vec2(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1);
    if ( expectKHR(inputBuffer[uint(gl_FragCoord.x)], i64vec2(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1)) == i64vec2(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1) ) {
        control = i64vec2(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1);
    } else {
        // set wrong value
        control = i64vec2(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1);
    }
    out_color.r = int(gl_FragCoord.x);
    out_color.g = uint(control == i64vec2(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable

spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
bvec3 expectKHR(bvec3, bvec3);
precision highp float;
precision highp int;
layout(location = 0) out uvec2 out_color;
layout(set = 0, binding = 0, std430) buffer Block1 { bvec3 inputBuffer[]; };
void main()
{
    bvec3 control = bvec3(false);
    if ( expectKHR(inputBuffer[uint(gl_FragCoord.x)], bvec3(true)) == bvec3(true) ) {
        control = bvec3(true);
    } else {
        // set wrong value
        control = bvec3(false);
    }
    out_color.r = int(gl_FragCoord.x);
    out_color.g = uint(control == bvec3(true));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int8: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i8vec3 expectKHR(i8vec3, i8vec3);
precision highp float;
precision highp int;
layout(location = 0) out uvec2 out_color;
layout(set = 0, binding = 0, std430) buffer Block1 { i8vec3 inputBuffer[]; };
void main()
{
    i8vec3 control = i8vec3(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1, uint(gl_FragCoord.x)*2 + 3 + 2);
    if ( expectKHR(inputBuffer[uint(gl_FragCoord.x)], i8vec3(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2)) == i8vec3(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2) ) {
        control = i8vec3(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2);
    } else {
        // set wrong value
        control = i8vec3(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1, uint(gl_FragCoord.x)*2 + 3 + 2);
    }
    out_color.r = int(gl_FragCoord.x);
    out_color.g = uint(control == i8vec3(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int16: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i16vec3 expectKHR(i16vec3, i16vec3);
precision highp float;
precision highp int;
layout(location = 0) out uvec2 out_color;
layout(set = 0, binding = 0, std430) buffer Block1 { i16vec3 inputBuffer[]; };
void main()
{
    i16vec3 control = i16vec3(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1, uint(gl_FragCoord.x)*2 + 3 + 2);
    if ( expectKHR(inputBuffer[uint(gl_FragCoord.x)], i16vec3(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2)) == i16vec3(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2) ) {
        control = i16vec3(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2);
    } else {
        // set wrong value
        control = i16vec3(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1, uint(gl_FragCoord.x)*2 + 3 + 2);
    }
    out_color.r = int(gl_FragCoord.x);
    out_color.g = uint(control == i16vec3(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2));
}
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
    out_color.g = uint(control == i32vec3(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i64vec3 expectKHR(i64vec3, i64vec3);
precision highp float;
precision highp int;
layout(location = 0) out uvec2 out_color;
layout(set = 0, binding = 0, std430) buffer Block1 { i64vec3 inputBuffer[]; };
void main()
{
    i64vec3 control = i64vec3(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1, uint(gl_FragCoord.x)*2 + 3 + 2);
    if ( expectKHR(inputBuffer[uint(gl_FragCoord.x)], i64vec3(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2)) == i64vec3(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2) ) {
        control = i64vec3(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2);
    } else {
        // set wrong value
        control = i64vec3(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1, uint(gl_FragCoord.x)*2 + 3 + 2);
    }
    out_color.r = int(gl_FragCoord.x);
    out_color.g = uint(control == i64vec3(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable

spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
bvec4 expectKHR(bvec4, bvec4);
precision highp float;
precision highp int;
layout(location = 0) out uvec2 out_color;
layout(set = 0, binding = 0, std430) buffer Block1 { bvec4 inputBuffer[]; };
void main()
{
    bvec4 control = bvec4(false);
    if ( expectKHR(inputBuffer[uint(gl_FragCoord.x)], bvec4(true)) == bvec4(true) ) {
        control = bvec4(true);
    } else {
        // set wrong value
        control = bvec4(false);
    }
    out_color.r = int(gl_FragCoord.x);
    out_color.g = uint(control == bvec4(true));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int8: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i8vec4 expectKHR(i8vec4, i8vec4);
precision highp float;
precision highp int;
layout(location = 0) out uvec2 out_color;
layout(set = 0, binding = 0, std430) buffer Block1 { i8vec4 inputBuffer[]; };
void main()
{
    i8vec4 control = i8vec4(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1, uint(gl_FragCoord.x)*2 + 3 + 2, uint(gl_FragCoord.x)*2 + 3 + 3);
    if ( expectKHR(inputBuffer[uint(gl_FragCoord.x)], i8vec4(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2, uint(gl_FragCoord.x) + 3)) == i8vec4(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2, uint(gl_FragCoord.x) + 3) ) {
        control = i8vec4(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2, uint(gl_FragCoord.x) + 3);
    } else {
        // set wrong value
        control = i8vec4(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1, uint(gl_FragCoord.x)*2 + 3 + 2, uint(gl_FragCoord.x)*2 + 3 + 3);
    }
    out_color.r = int(gl_FragCoord.x);
    out_color.g = uint(control == i8vec4(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2, uint(gl_FragCoord.x) + 3));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int16: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i16vec4 expectKHR(i16vec4, i16vec4);
precision highp float;
precision highp int;
layout(location = 0) out uvec2 out_color;
layout(set = 0, binding = 0, std430) buffer Block1 { i16vec4 inputBuffer[]; };
void main()
{
    i16vec4 control = i16vec4(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1, uint(gl_FragCoord.x)*2 + 3 + 2, uint(gl_FragCoord.x)*2 + 3 + 3);
    if ( expectKHR(inputBuffer[uint(gl_FragCoord.x)], i16vec4(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2, uint(gl_FragCoord.x) + 3)) == i16vec4(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2, uint(gl_FragCoord.x) + 3) ) {
        control = i16vec4(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2, uint(gl_FragCoord.x) + 3);
    } else {
        // set wrong value
        control = i16vec4(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1, uint(gl_FragCoord.x)*2 + 3 + 2, uint(gl_FragCoord.x)*2 + 3 + 3);
    }
    out_color.r = int(gl_FragCoord.x);
    out_color.g = uint(control == i16vec4(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2, uint(gl_FragCoord.x) + 3));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int32: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i32vec4 expectKHR(i32vec4, i32vec4);
precision highp float;
precision highp int;
layout(location = 0) out uvec2 out_color;
layout(set = 0, binding = 0, std430) buffer Block1 { i32vec4 inputBuffer[]; };
void main()
{
    i32vec4 control = i32vec4(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1, uint(gl_FragCoord.x)*2 + 3 + 2, uint(gl_FragCoord.x)*2 + 3 + 3);
    if ( expectKHR(inputBuffer[uint(gl_FragCoord.x)], i32vec4(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2, uint(gl_FragCoord.x) + 3)) == i32vec4(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2, uint(gl_FragCoord.x) + 3) ) {
        control = i32vec4(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2, uint(gl_FragCoord.x) + 3);
    } else {
        // set wrong value
        control = i32vec4(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1, uint(gl_FragCoord.x)*2 + 3 + 2, uint(gl_FragCoord.x)*2 + 3 + 3);
    }
    out_color.r = int(gl_FragCoord.x);
    out_color.g = uint(control == i32vec4(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2, uint(gl_FragCoord.x) + 3));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i64vec4 expectKHR(i64vec4, i64vec4);
precision highp float;
precision highp int;
layout(location = 0) out uvec2 out_color;
layout(set = 0, binding = 0, std430) buffer Block1 { i64vec4 inputBuffer[]; };
void main()
{
    i64vec4 control = i64vec4(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1, uint(gl_FragCoord.x)*2 + 3 + 2, uint(gl_FragCoord.x)*2 + 3 + 3);
    if ( expectKHR(inputBuffer[uint(gl_FragCoord.x)], i64vec4(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2, uint(gl_FragCoord.x) + 3)) == i64vec4(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2, uint(gl_FragCoord.x) + 3) ) {
        control = i64vec4(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2, uint(gl_FragCoord.x) + 3);
    } else {
        // set wrong value
        control = i64vec4(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1, uint(gl_FragCoord.x)*2 + 3 + 2, uint(gl_FragCoord.x)*2 + 3 + 3);
    }
    out_color.r = int(gl_FragCoord.x);
    out_color.g = uint(control == i64vec4(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2, uint(gl_FragCoord.x) + 3));
}
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
    out_color.g = uint(control == bool(false));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int8: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
int8_t expectKHR(int8_t, int8_t);
precision highp float;
precision highp int;
layout(location = 0) out uvec2 out_color;
layout(set = 0, binding = 0, std430) buffer Block1 { int8_t inputBuffer[]; };
void main()
{
    int8_t control = int8_t(uint(gl_FragCoord.x)*2 + 3);
    if ( expectKHR(inputBuffer[uint(gl_FragCoord.x)], int8_t(uint(gl_FragCoord.x))) == int8_t(uint(gl_FragCoord.x)) ) {
        control = int8_t(uint(gl_FragCoord.x));
    } else {
        // set wrong value
        control = int8_t(uint(gl_FragCoord.x)*2 + 3);
    }
    out_color.r = int(gl_FragCoord.x);
    out_color.g = uint(control == int8_t(uint(gl_FragCoord.x)*2 + 3));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int16: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
int16_t expectKHR(int16_t, int16_t);
precision highp float;
precision highp int;
layout(location = 0) out uvec2 out_color;
layout(set = 0, binding = 0, std430) buffer Block1 { int16_t inputBuffer[]; };
void main()
{
    int16_t control = int16_t(uint(gl_FragCoord.x)*2 + 3);
    if ( expectKHR(inputBuffer[uint(gl_FragCoord.x)], int16_t(uint(gl_FragCoord.x))) == int16_t(uint(gl_FragCoord.x)) ) {
        control = int16_t(uint(gl_FragCoord.x));
    } else {
        // set wrong value
        control = int16_t(uint(gl_FragCoord.x)*2 + 3);
    }
    out_color.r = int(gl_FragCoord.x);
    out_color.g = uint(control == int16_t(uint(gl_FragCoord.x)*2 + 3));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int32: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
int32_t expectKHR(int32_t, int32_t);
precision highp float;
precision highp int;
layout(location = 0) out uvec2 out_color;
layout(set = 0, binding = 0, std430) buffer Block1 { int32_t inputBuffer[]; };
void main()
{
    int32_t control = int32_t(uint(gl_FragCoord.x)*2 + 3);
    if ( expectKHR(inputBuffer[uint(gl_FragCoord.x)], int32_t(uint(gl_FragCoord.x))) == int32_t(uint(gl_FragCoord.x)) ) {
        control = int32_t(uint(gl_FragCoord.x));
    } else {
        // set wrong value
        control = int32_t(uint(gl_FragCoord.x)*2 + 3);
    }
    out_color.r = int(gl_FragCoord.x);
    out_color.g = uint(control == int32_t(uint(gl_FragCoord.x)*2 + 3));
}
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
    out_color.g = uint(control == bvec2(false));
}
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
    out_color.g = uint(control == i8vec2(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int16: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i16vec2 expectKHR(i16vec2, i16vec2);
precision highp float;
precision highp int;
layout(location = 0) out uvec2 out_color;
layout(set = 0, binding = 0, std430) buffer Block1 { i16vec2 inputBuffer[]; };
void main()
{
    i16vec2 control = i16vec2(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1);
    if ( expectKHR(inputBuffer[uint(gl_FragCoord.x)], i16vec2(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1)) == i16vec2(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1) ) {
        control = i16vec2(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1);
    } else {
        // set wrong value
        control = i16vec2(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1);
    }
    out_color.r = int(gl_FragCoord.x);
    out_color.g = uint(control == i16vec2(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int32: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i32vec2 expectKHR(i32vec2, i32vec2);
precision highp float;
precision highp int;
layout(location = 0) out uvec2 out_color;
layout(set = 0, binding = 0, std430) buffer Block1 { i32vec2 inputBuffer[]; };
void main()
{
    i32vec2 control = i32vec2(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1);
    if ( expectKHR(inputBuffer[uint(gl_FragCoord.x)], i32vec2(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1)) == i32vec2(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1) ) {
        control = i32vec2(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1);
    } else {
        // set wrong value
        control = i32vec2(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1);
    }
    out_color.r = int(gl_FragCoord.x);
    out_color.g = uint(control == i32vec2(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i64vec2 expectKHR(i64vec2, i64vec2);
precision highp float;
precision highp int;
layout(location = 0) out uvec2 out_color;
layout(set = 0, binding = 0, std430) buffer Block1 { i64vec2 inputBuffer[]; };
void main()
{
    i64vec2 control = i64vec2(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1);
    if ( expectKHR(inputBuffer[uint(gl_FragCoord.x)], i64vec2(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1)) == i64vec2(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1) ) {
        control = i64vec2(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1);
    } else {
        // set wrong value
        control = i64vec2(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1);
    }
    out_color.r = int(gl_FragCoord.x);
    out_color.g = uint(control == i64vec2(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable

spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
bvec3 expectKHR(bvec3, bvec3);
precision highp float;
precision highp int;
layout(location = 0) out uvec2 out_color;
layout(set = 0, binding = 0, std430) buffer Block1 { bvec3 inputBuffer[]; };
void main()
{
    bvec3 control = bvec3(false);
    if ( expectKHR(inputBuffer[uint(gl_FragCoord.x)], bvec3(true)) == bvec3(true) ) {
        control = bvec3(true);
    } else {
        // set wrong value
        control = bvec3(false);
    }
    out_color.r = int(gl_FragCoord.x);
    out_color.g = uint(control == bvec3(false));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int8: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i8vec3 expectKHR(i8vec3, i8vec3);
precision highp float;
precision highp int;
layout(location = 0) out uvec2 out_color;
layout(set = 0, binding = 0, std430) buffer Block1 { i8vec3 inputBuffer[]; };
void main()
{
    i8vec3 control = i8vec3(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1, uint(gl_FragCoord.x)*2 + 3 + 2);
    if ( expectKHR(inputBuffer[uint(gl_FragCoord.x)], i8vec3(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2)) == i8vec3(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2) ) {
        control = i8vec3(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2);
    } else {
        // set wrong value
        control = i8vec3(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1, uint(gl_FragCoord.x)*2 + 3 + 2);
    }
    out_color.r = int(gl_FragCoord.x);
    out_color.g = uint(control == i8vec3(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1, uint(gl_FragCoord.x)*2 + 3 + 2));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int16: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i16vec3 expectKHR(i16vec3, i16vec3);
precision highp float;
precision highp int;
layout(location = 0) out uvec2 out_color;
layout(set = 0, binding = 0, std430) buffer Block1 { i16vec3 inputBuffer[]; };
void main()
{
    i16vec3 control = i16vec3(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1, uint(gl_FragCoord.x)*2 + 3 + 2);
    if ( expectKHR(inputBuffer[uint(gl_FragCoord.x)], i16vec3(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2)) == i16vec3(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2) ) {
        control = i16vec3(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2);
    } else {
        // set wrong value
        control = i16vec3(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1, uint(gl_FragCoord.x)*2 + 3 + 2);
    }
    out_color.r = int(gl_FragCoord.x);
    out_color.g = uint(control == i16vec3(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1, uint(gl_FragCoord.x)*2 + 3 + 2));
}
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
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i64vec3 expectKHR(i64vec3, i64vec3);
precision highp float;
precision highp int;
layout(location = 0) out uvec2 out_color;
layout(set = 0, binding = 0, std430) buffer Block1 { i64vec3 inputBuffer[]; };
void main()
{
    i64vec3 control = i64vec3(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1, uint(gl_FragCoord.x)*2 + 3 + 2);
    if ( expectKHR(inputBuffer[uint(gl_FragCoord.x)], i64vec3(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2)) == i64vec3(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2) ) {
        control = i64vec3(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2);
    } else {
        // set wrong value
        control = i64vec3(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1, uint(gl_FragCoord.x)*2 + 3 + 2);
    }
    out_color.r = int(gl_FragCoord.x);
    out_color.g = uint(control == i64vec3(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1, uint(gl_FragCoord.x)*2 + 3 + 2));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable

spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
bvec4 expectKHR(bvec4, bvec4);
precision highp float;
precision highp int;
layout(location = 0) out uvec2 out_color;
layout(set = 0, binding = 0, std430) buffer Block1 { bvec4 inputBuffer[]; };
void main()
{
    bvec4 control = bvec4(false);
    if ( expectKHR(inputBuffer[uint(gl_FragCoord.x)], bvec4(true)) == bvec4(true) ) {
        control = bvec4(true);
    } else {
        // set wrong value
        control = bvec4(false);
    }
    out_color.r = int(gl_FragCoord.x);
    out_color.g = uint(control == bvec4(false));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int8: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i8vec4 expectKHR(i8vec4, i8vec4);
precision highp float;
precision highp int;
layout(location = 0) out uvec2 out_color;
layout(set = 0, binding = 0, std430) buffer Block1 { i8vec4 inputBuffer[]; };
void main()
{
    i8vec4 control = i8vec4(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1, uint(gl_FragCoord.x)*2 + 3 + 2, uint(gl_FragCoord.x)*2 + 3 + 3);
    if ( expectKHR(inputBuffer[uint(gl_FragCoord.x)], i8vec4(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2, uint(gl_FragCoord.x) + 3)) == i8vec4(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2, uint(gl_FragCoord.x) + 3) ) {
        control = i8vec4(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2, uint(gl_FragCoord.x) + 3);
    } else {
        // set wrong value
        control = i8vec4(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1, uint(gl_FragCoord.x)*2 + 3 + 2, uint(gl_FragCoord.x)*2 + 3 + 3);
    }
    out_color.r = int(gl_FragCoord.x);
    out_color.g = uint(control == i8vec4(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1, uint(gl_FragCoord.x)*2 + 3 + 2, uint(gl_FragCoord.x)*2 + 3 + 3));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int16: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i16vec4 expectKHR(i16vec4, i16vec4);
precision highp float;
precision highp int;
layout(location = 0) out uvec2 out_color;
layout(set = 0, binding = 0, std430) buffer Block1 { i16vec4 inputBuffer[]; };
void main()
{
    i16vec4 control = i16vec4(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1, uint(gl_FragCoord.x)*2 + 3 + 2, uint(gl_FragCoord.x)*2 + 3 + 3);
    if ( expectKHR(inputBuffer[uint(gl_FragCoord.x)], i16vec4(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2, uint(gl_FragCoord.x) + 3)) == i16vec4(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2, uint(gl_FragCoord.x) + 3) ) {
        control = i16vec4(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2, uint(gl_FragCoord.x) + 3);
    } else {
        // set wrong value
        control = i16vec4(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1, uint(gl_FragCoord.x)*2 + 3 + 2, uint(gl_FragCoord.x)*2 + 3 + 3);
    }
    out_color.r = int(gl_FragCoord.x);
    out_color.g = uint(control == i16vec4(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1, uint(gl_FragCoord.x)*2 + 3 + 2, uint(gl_FragCoord.x)*2 + 3 + 3));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int32: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i32vec4 expectKHR(i32vec4, i32vec4);
precision highp float;
precision highp int;
layout(location = 0) out uvec2 out_color;
layout(set = 0, binding = 0, std430) buffer Block1 { i32vec4 inputBuffer[]; };
void main()
{
    i32vec4 control = i32vec4(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1, uint(gl_FragCoord.x)*2 + 3 + 2, uint(gl_FragCoord.x)*2 + 3 + 3);
    if ( expectKHR(inputBuffer[uint(gl_FragCoord.x)], i32vec4(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2, uint(gl_FragCoord.x) + 3)) == i32vec4(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2, uint(gl_FragCoord.x) + 3) ) {
        control = i32vec4(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2, uint(gl_FragCoord.x) + 3);
    } else {
        // set wrong value
        control = i32vec4(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1, uint(gl_FragCoord.x)*2 + 3 + 2, uint(gl_FragCoord.x)*2 + 3 + 3);
    }
    out_color.r = int(gl_FragCoord.x);
    out_color.g = uint(control == i32vec4(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1, uint(gl_FragCoord.x)*2 + 3 + 2, uint(gl_FragCoord.x)*2 + 3 + 3));
}
#version 460
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i64vec4 expectKHR(i64vec4, i64vec4);
precision highp float;
precision highp int;
layout(location = 0) out uvec2 out_color;
layout(set = 0, binding = 0, std430) buffer Block1 { i64vec4 inputBuffer[]; };
void main()
{
    i64vec4 control = i64vec4(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1, uint(gl_FragCoord.x)*2 + 3 + 2, uint(gl_FragCoord.x)*2 + 3 + 3);
    if ( expectKHR(inputBuffer[uint(gl_FragCoord.x)], i64vec4(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2, uint(gl_FragCoord.x) + 3)) == i64vec4(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2, uint(gl_FragCoord.x) + 3) ) {
        control = i64vec4(uint(gl_FragCoord.x), uint(gl_FragCoord.x) + 1, uint(gl_FragCoord.x) + 2, uint(gl_FragCoord.x) + 3);
    } else {
        // set wrong value
        control = i64vec4(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1, uint(gl_FragCoord.x)*2 + 3 + 2, uint(gl_FragCoord.x)*2 + 3 + 3);
    }
    out_color.r = int(gl_FragCoord.x);
    out_color.g = uint(control == i64vec4(uint(gl_FragCoord.x)*2 + 3, uint(gl_FragCoord.x)*2 + 3 + 1, uint(gl_FragCoord.x)*2 + 3 + 2, uint(gl_FragCoord.x)*2 + 3 + 3));
}
