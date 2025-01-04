#version 460 core
#extension GL_EXT_spirv_intrinsics: enable

spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
bool expectKHR(bool, bool);
precision highp float;
precision highp int;
layout(set = 0, binding = 0, std430) buffer Block0 { uvec2 outputBuffer[]; };
bool kThisIsTrue = true;
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
void main()
{
    bool control = false;
    if ( expectKHR(kThisIsTrue, true) == true ) {
        control = true;
    } else {
        // set wrong value
        control = false;
    }
    outputBuffer[gl_GlobalInvocationID.x].x = gl_GlobalInvocationID.x;
    outputBuffer[gl_GlobalInvocationID.x].y = uint(control == true);
}
#version 460 core
#extension GL_EXT_spirv_intrinsics: enable

spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
bool expectKHR(bool, bool);
precision highp float;
precision highp int;
layout(set = 0, binding = 0, std430) buffer Block0 { uvec2 outputBuffer[]; };
layout (constant_id = 0) const bool scThisIsTrue = false;
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
void main()
{
    bool control = false;
    if ( expectKHR(scThisIsTrue, true) == true ) {
        control = true;
    } else {
        // set wrong value
        control = false;
    }
    outputBuffer[gl_GlobalInvocationID.x].x = gl_GlobalInvocationID.x;
    outputBuffer[gl_GlobalInvocationID.x].y = uint(control == true);
}
#version 460 core
#extension GL_EXT_spirv_intrinsics: enable

spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
bool expectKHR(bool, bool);
precision highp float;
precision highp int;
layout(set = 0, binding = 0, std430) buffer Block0 { uvec2 outputBuffer[]; };
layout( push_constant, std430 ) uniform pc { layout(offset = 0) bool pcThisIsTrue; };
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
void main()
{
    bool control = false;
    if ( expectKHR(pcThisIsTrue, true) == true ) {
        control = true;
    } else {
        // set wrong value
        control = false;
    }
    outputBuffer[gl_GlobalInvocationID.x].x = gl_GlobalInvocationID.x;
    outputBuffer[gl_GlobalInvocationID.x].y = uint(control == true);
}
#version 460 core
#extension GL_EXT_spirv_intrinsics: enable

spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
bool expectKHR(bool, bool);
precision highp float;
precision highp int;
layout(set = 0, binding = 0, std430) buffer Block0 { uvec2 outputBuffer[]; };
layout(set = 0, binding = 1, std430) buffer Block1 { bool inputBuffer[]; };
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
void main()
{
    bool control = bool(false);
    if ( expectKHR(inputBuffer[gl_GlobalInvocationID.x], bool(true)) == bool(true) ) {
        control = bool(true);
    } else {
        // set wrong value
        control = bool(false);
    }
    outputBuffer[gl_GlobalInvocationID.x].x = gl_GlobalInvocationID.x;
    outputBuffer[gl_GlobalInvocationID.x].y = uint(control == bool(true));
}
#version 460 core
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int8: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
int8_t expectKHR(int8_t, int8_t);
precision highp float;
precision highp int;
layout(set = 0, binding = 0, std430) buffer Block0 { uvec2 outputBuffer[]; };
layout(set = 0, binding = 1, std430) buffer Block1 { int8_t inputBuffer[]; };
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
void main()
{
    int8_t control = int8_t(gl_GlobalInvocationID.x*2 + 3);
    if ( expectKHR(inputBuffer[gl_GlobalInvocationID.x], int8_t(gl_GlobalInvocationID.x)) == int8_t(gl_GlobalInvocationID.x) ) {
        control = int8_t(gl_GlobalInvocationID.x);
    } else {
        // set wrong value
        control = int8_t(gl_GlobalInvocationID.x*2 + 3);
    }
    outputBuffer[gl_GlobalInvocationID.x].x = gl_GlobalInvocationID.x;
    outputBuffer[gl_GlobalInvocationID.x].y = uint(control == int8_t(gl_GlobalInvocationID.x));
}
#version 460 core
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int16: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
int16_t expectKHR(int16_t, int16_t);
precision highp float;
precision highp int;
layout(set = 0, binding = 0, std430) buffer Block0 { uvec2 outputBuffer[]; };
layout(set = 0, binding = 1, std430) buffer Block1 { int16_t inputBuffer[]; };
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
void main()
{
    int16_t control = int16_t(gl_GlobalInvocationID.x*2 + 3);
    if ( expectKHR(inputBuffer[gl_GlobalInvocationID.x], int16_t(gl_GlobalInvocationID.x)) == int16_t(gl_GlobalInvocationID.x) ) {
        control = int16_t(gl_GlobalInvocationID.x);
    } else {
        // set wrong value
        control = int16_t(gl_GlobalInvocationID.x*2 + 3);
    }
    outputBuffer[gl_GlobalInvocationID.x].x = gl_GlobalInvocationID.x;
    outputBuffer[gl_GlobalInvocationID.x].y = uint(control == int16_t(gl_GlobalInvocationID.x));
}
#version 460 core
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int32: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
int32_t expectKHR(int32_t, int32_t);
precision highp float;
precision highp int;
layout(set = 0, binding = 0, std430) buffer Block0 { uvec2 outputBuffer[]; };
layout(set = 0, binding = 1, std430) buffer Block1 { int32_t inputBuffer[]; };
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
void main()
{
    int32_t control = int32_t(gl_GlobalInvocationID.x*2 + 3);
    if ( expectKHR(inputBuffer[gl_GlobalInvocationID.x], int32_t(gl_GlobalInvocationID.x)) == int32_t(gl_GlobalInvocationID.x) ) {
        control = int32_t(gl_GlobalInvocationID.x);
    } else {
        // set wrong value
        control = int32_t(gl_GlobalInvocationID.x*2 + 3);
    }
    outputBuffer[gl_GlobalInvocationID.x].x = gl_GlobalInvocationID.x;
    outputBuffer[gl_GlobalInvocationID.x].y = uint(control == int32_t(gl_GlobalInvocationID.x));
}
#version 460 core
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
int64_t expectKHR(int64_t, int64_t);
precision highp float;
precision highp int;
layout(set = 0, binding = 0, std430) buffer Block0 { uvec2 outputBuffer[]; };
layout(set = 0, binding = 1, std430) buffer Block1 { int64_t inputBuffer[]; };
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
void main()
{
    int64_t control = int64_t(gl_GlobalInvocationID.x*2 + 3);
    if ( expectKHR(inputBuffer[gl_GlobalInvocationID.x], int64_t(gl_GlobalInvocationID.x)) == int64_t(gl_GlobalInvocationID.x) ) {
        control = int64_t(gl_GlobalInvocationID.x);
    } else {
        // set wrong value
        control = int64_t(gl_GlobalInvocationID.x*2 + 3);
    }
    outputBuffer[gl_GlobalInvocationID.x].x = gl_GlobalInvocationID.x;
    outputBuffer[gl_GlobalInvocationID.x].y = uint(control == int64_t(gl_GlobalInvocationID.x));
}
#version 460 core
#extension GL_EXT_spirv_intrinsics: enable

spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
bool expectKHR(bool, bool);
precision highp float;
precision highp int;
layout(set = 0, binding = 0, std430) buffer Block0 { uvec2 outputBuffer[]; };
bool kThisIsTrue = true;
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
void main()
{
    assumeTrueKHR (kThisIsTrue);
    outputBuffer[gl_GlobalInvocationID.x].x = gl_GlobalInvocationID.x;
    outputBuffer[gl_GlobalInvocationID.x].y = uint(kThisIsTrue);
}
#version 460 core
#extension GL_EXT_spirv_intrinsics: enable

spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
bool expectKHR(bool, bool);
precision highp float;
precision highp int;
layout(set = 0, binding = 0, std430) buffer Block0 { uvec2 outputBuffer[]; };
layout (constant_id = 0) const bool scThisIsTrue = false;
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
void main()
{
    assumeTrueKHR (scThisIsTrue);
    outputBuffer[gl_GlobalInvocationID.x].x = gl_GlobalInvocationID.x;
    outputBuffer[gl_GlobalInvocationID.x].y = uint(scThisIsTrue);
}
#version 460 core
#extension GL_EXT_spirv_intrinsics: enable

spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
bool expectKHR(bool, bool);
precision highp float;
precision highp int;
layout(set = 0, binding = 0, std430) buffer Block0 { uvec2 outputBuffer[]; };
layout( push_constant, std430 ) uniform pc { layout(offset = 0) bool pcThisIsTrue; };
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
void main()
{
    assumeTrueKHR (pcThisIsTrue);
    outputBuffer[gl_GlobalInvocationID.x].x = gl_GlobalInvocationID.x;
    outputBuffer[gl_GlobalInvocationID.x].y = uint(pcThisIsTrue);
}
#version 460 core
#extension GL_EXT_spirv_intrinsics: enable

spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
bool expectKHR(bool, bool);
precision highp float;
precision highp int;
layout(set = 0, binding = 0, std430) buffer Block0 { uvec2 outputBuffer[]; };
layout(set = 0, binding = 1, std430) buffer Block1 { bool inputBuffer[]; };
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
void main()
{
    assumeTrueKHR (inputBuffer[gl_GlobalInvocationID.x]);
    outputBuffer[gl_GlobalInvocationID.x].x = gl_GlobalInvocationID.x;
    outputBuffer[gl_GlobalInvocationID.x].y = uint(inputBuffer[gl_GlobalInvocationID.x]);
}
#version 460 core
#extension GL_EXT_spirv_intrinsics: enable

spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
bvec2 expectKHR(bvec2, bvec2);
precision highp float;
precision highp int;
layout(set = 0, binding = 0, std430) buffer Block0 { uvec2 outputBuffer[]; };
layout(set = 0, binding = 1, std430) buffer Block1 { bvec2 inputBuffer[]; };
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
void main()
{
    bvec2 control = bvec2(false);
    if ( expectKHR(inputBuffer[gl_GlobalInvocationID.x], bvec2(true)) == bvec2(true) ) {
        control = bvec2(true);
    } else {
        // set wrong value
        control = bvec2(false);
    }
    outputBuffer[gl_GlobalInvocationID.x].x = gl_GlobalInvocationID.x;
    outputBuffer[gl_GlobalInvocationID.x].y = uint(control == bvec2(true));
}
#version 460 core
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int8: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i8vec2 expectKHR(i8vec2, i8vec2);
precision highp float;
precision highp int;
layout(set = 0, binding = 0, std430) buffer Block0 { uvec2 outputBuffer[]; };
layout(set = 0, binding = 1, std430) buffer Block1 { i8vec2 inputBuffer[]; };
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
void main()
{
    i8vec2 control = i8vec2(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1);
    if ( expectKHR(inputBuffer[gl_GlobalInvocationID.x], i8vec2(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1)) == i8vec2(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1) ) {
        control = i8vec2(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1);
    } else {
        // set wrong value
        control = i8vec2(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1);
    }
    outputBuffer[gl_GlobalInvocationID.x].x = gl_GlobalInvocationID.x;
    outputBuffer[gl_GlobalInvocationID.x].y = uint(control == i8vec2(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1));
}
#version 460 core
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int16: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i16vec2 expectKHR(i16vec2, i16vec2);
precision highp float;
precision highp int;
layout(set = 0, binding = 0, std430) buffer Block0 { uvec2 outputBuffer[]; };
layout(set = 0, binding = 1, std430) buffer Block1 { i16vec2 inputBuffer[]; };
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
void main()
{
    i16vec2 control = i16vec2(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1);
    if ( expectKHR(inputBuffer[gl_GlobalInvocationID.x], i16vec2(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1)) == i16vec2(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1) ) {
        control = i16vec2(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1);
    } else {
        // set wrong value
        control = i16vec2(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1);
    }
    outputBuffer[gl_GlobalInvocationID.x].x = gl_GlobalInvocationID.x;
    outputBuffer[gl_GlobalInvocationID.x].y = uint(control == i16vec2(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1));
}
#version 460 core
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int32: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i32vec2 expectKHR(i32vec2, i32vec2);
precision highp float;
precision highp int;
layout(set = 0, binding = 0, std430) buffer Block0 { uvec2 outputBuffer[]; };
layout(set = 0, binding = 1, std430) buffer Block1 { i32vec2 inputBuffer[]; };
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
void main()
{
    i32vec2 control = i32vec2(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1);
    if ( expectKHR(inputBuffer[gl_GlobalInvocationID.x], i32vec2(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1)) == i32vec2(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1) ) {
        control = i32vec2(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1);
    } else {
        // set wrong value
        control = i32vec2(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1);
    }
    outputBuffer[gl_GlobalInvocationID.x].x = gl_GlobalInvocationID.x;
    outputBuffer[gl_GlobalInvocationID.x].y = uint(control == i32vec2(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1));
}
#version 460 core
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i64vec2 expectKHR(i64vec2, i64vec2);
precision highp float;
precision highp int;
layout(set = 0, binding = 0, std430) buffer Block0 { uvec2 outputBuffer[]; };
layout(set = 0, binding = 1, std430) buffer Block1 { i64vec2 inputBuffer[]; };
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
void main()
{
    i64vec2 control = i64vec2(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1);
    if ( expectKHR(inputBuffer[gl_GlobalInvocationID.x], i64vec2(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1)) == i64vec2(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1) ) {
        control = i64vec2(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1);
    } else {
        // set wrong value
        control = i64vec2(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1);
    }
    outputBuffer[gl_GlobalInvocationID.x].x = gl_GlobalInvocationID.x;
    outputBuffer[gl_GlobalInvocationID.x].y = uint(control == i64vec2(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1));
}
#version 460 core
#extension GL_EXT_spirv_intrinsics: enable

spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
bvec3 expectKHR(bvec3, bvec3);
precision highp float;
precision highp int;
layout(set = 0, binding = 0, std430) buffer Block0 { uvec2 outputBuffer[]; };
layout(set = 0, binding = 1, std430) buffer Block1 { bvec3 inputBuffer[]; };
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
void main()
{
    bvec3 control = bvec3(false);
    if ( expectKHR(inputBuffer[gl_GlobalInvocationID.x], bvec3(true)) == bvec3(true) ) {
        control = bvec3(true);
    } else {
        // set wrong value
        control = bvec3(false);
    }
    outputBuffer[gl_GlobalInvocationID.x].x = gl_GlobalInvocationID.x;
    outputBuffer[gl_GlobalInvocationID.x].y = uint(control == bvec3(true));
}
#version 460 core
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int8: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i8vec3 expectKHR(i8vec3, i8vec3);
precision highp float;
precision highp int;
layout(set = 0, binding = 0, std430) buffer Block0 { uvec2 outputBuffer[]; };
layout(set = 0, binding = 1, std430) buffer Block1 { i8vec3 inputBuffer[]; };
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
void main()
{
    i8vec3 control = i8vec3(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1, gl_GlobalInvocationID.x*2 + 3 + 2);
    if ( expectKHR(inputBuffer[gl_GlobalInvocationID.x], i8vec3(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2)) == i8vec3(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2) ) {
        control = i8vec3(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2);
    } else {
        // set wrong value
        control = i8vec3(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1, gl_GlobalInvocationID.x*2 + 3 + 2);
    }
    outputBuffer[gl_GlobalInvocationID.x].x = gl_GlobalInvocationID.x;
    outputBuffer[gl_GlobalInvocationID.x].y = uint(control == i8vec3(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2));
}
#version 460 core
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int16: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i16vec3 expectKHR(i16vec3, i16vec3);
precision highp float;
precision highp int;
layout(set = 0, binding = 0, std430) buffer Block0 { uvec2 outputBuffer[]; };
layout(set = 0, binding = 1, std430) buffer Block1 { i16vec3 inputBuffer[]; };
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
void main()
{
    i16vec3 control = i16vec3(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1, gl_GlobalInvocationID.x*2 + 3 + 2);
    if ( expectKHR(inputBuffer[gl_GlobalInvocationID.x], i16vec3(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2)) == i16vec3(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2) ) {
        control = i16vec3(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2);
    } else {
        // set wrong value
        control = i16vec3(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1, gl_GlobalInvocationID.x*2 + 3 + 2);
    }
    outputBuffer[gl_GlobalInvocationID.x].x = gl_GlobalInvocationID.x;
    outputBuffer[gl_GlobalInvocationID.x].y = uint(control == i16vec3(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2));
}
#version 460 core
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int32: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i32vec3 expectKHR(i32vec3, i32vec3);
precision highp float;
precision highp int;
layout(set = 0, binding = 0, std430) buffer Block0 { uvec2 outputBuffer[]; };
layout(set = 0, binding = 1, std430) buffer Block1 { i32vec3 inputBuffer[]; };
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
void main()
{
    i32vec3 control = i32vec3(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1, gl_GlobalInvocationID.x*2 + 3 + 2);
    if ( expectKHR(inputBuffer[gl_GlobalInvocationID.x], i32vec3(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2)) == i32vec3(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2) ) {
        control = i32vec3(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2);
    } else {
        // set wrong value
        control = i32vec3(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1, gl_GlobalInvocationID.x*2 + 3 + 2);
    }
    outputBuffer[gl_GlobalInvocationID.x].x = gl_GlobalInvocationID.x;
    outputBuffer[gl_GlobalInvocationID.x].y = uint(control == i32vec3(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2));
}
#version 460 core
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i64vec3 expectKHR(i64vec3, i64vec3);
precision highp float;
precision highp int;
layout(set = 0, binding = 0, std430) buffer Block0 { uvec2 outputBuffer[]; };
layout(set = 0, binding = 1, std430) buffer Block1 { i64vec3 inputBuffer[]; };
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
void main()
{
    i64vec3 control = i64vec3(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1, gl_GlobalInvocationID.x*2 + 3 + 2);
    if ( expectKHR(inputBuffer[gl_GlobalInvocationID.x], i64vec3(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2)) == i64vec3(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2) ) {
        control = i64vec3(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2);
    } else {
        // set wrong value
        control = i64vec3(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1, gl_GlobalInvocationID.x*2 + 3 + 2);
    }
    outputBuffer[gl_GlobalInvocationID.x].x = gl_GlobalInvocationID.x;
    outputBuffer[gl_GlobalInvocationID.x].y = uint(control == i64vec3(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2));
}
#version 460 core
#extension GL_EXT_spirv_intrinsics: enable

spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
bvec4 expectKHR(bvec4, bvec4);
precision highp float;
precision highp int;
layout(set = 0, binding = 0, std430) buffer Block0 { uvec2 outputBuffer[]; };
layout(set = 0, binding = 1, std430) buffer Block1 { bvec4 inputBuffer[]; };
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
void main()
{
    bvec4 control = bvec4(false);
    if ( expectKHR(inputBuffer[gl_GlobalInvocationID.x], bvec4(true)) == bvec4(true) ) {
        control = bvec4(true);
    } else {
        // set wrong value
        control = bvec4(false);
    }
    outputBuffer[gl_GlobalInvocationID.x].x = gl_GlobalInvocationID.x;
    outputBuffer[gl_GlobalInvocationID.x].y = uint(control == bvec4(true));
}
#version 460 core
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int8: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i8vec4 expectKHR(i8vec4, i8vec4);
precision highp float;
precision highp int;
layout(set = 0, binding = 0, std430) buffer Block0 { uvec2 outputBuffer[]; };
layout(set = 0, binding = 1, std430) buffer Block1 { i8vec4 inputBuffer[]; };
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
void main()
{
    i8vec4 control = i8vec4(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1, gl_GlobalInvocationID.x*2 + 3 + 2, gl_GlobalInvocationID.x*2 + 3 + 3);
    if ( expectKHR(inputBuffer[gl_GlobalInvocationID.x], i8vec4(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2, gl_GlobalInvocationID.x + 3)) == i8vec4(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2, gl_GlobalInvocationID.x + 3) ) {
        control = i8vec4(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2, gl_GlobalInvocationID.x + 3);
    } else {
        // set wrong value
        control = i8vec4(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1, gl_GlobalInvocationID.x*2 + 3 + 2, gl_GlobalInvocationID.x*2 + 3 + 3);
    }
    outputBuffer[gl_GlobalInvocationID.x].x = gl_GlobalInvocationID.x;
    outputBuffer[gl_GlobalInvocationID.x].y = uint(control == i8vec4(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2, gl_GlobalInvocationID.x + 3));
}
#version 460 core
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int16: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i16vec4 expectKHR(i16vec4, i16vec4);
precision highp float;
precision highp int;
layout(set = 0, binding = 0, std430) buffer Block0 { uvec2 outputBuffer[]; };
layout(set = 0, binding = 1, std430) buffer Block1 { i16vec4 inputBuffer[]; };
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
void main()
{
    i16vec4 control = i16vec4(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1, gl_GlobalInvocationID.x*2 + 3 + 2, gl_GlobalInvocationID.x*2 + 3 + 3);
    if ( expectKHR(inputBuffer[gl_GlobalInvocationID.x], i16vec4(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2, gl_GlobalInvocationID.x + 3)) == i16vec4(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2, gl_GlobalInvocationID.x + 3) ) {
        control = i16vec4(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2, gl_GlobalInvocationID.x + 3);
    } else {
        // set wrong value
        control = i16vec4(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1, gl_GlobalInvocationID.x*2 + 3 + 2, gl_GlobalInvocationID.x*2 + 3 + 3);
    }
    outputBuffer[gl_GlobalInvocationID.x].x = gl_GlobalInvocationID.x;
    outputBuffer[gl_GlobalInvocationID.x].y = uint(control == i16vec4(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2, gl_GlobalInvocationID.x + 3));
}
#version 460 core
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int32: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i32vec4 expectKHR(i32vec4, i32vec4);
precision highp float;
precision highp int;
layout(set = 0, binding = 0, std430) buffer Block0 { uvec2 outputBuffer[]; };
layout(set = 0, binding = 1, std430) buffer Block1 { i32vec4 inputBuffer[]; };
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
void main()
{
    i32vec4 control = i32vec4(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1, gl_GlobalInvocationID.x*2 + 3 + 2, gl_GlobalInvocationID.x*2 + 3 + 3);
    if ( expectKHR(inputBuffer[gl_GlobalInvocationID.x], i32vec4(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2, gl_GlobalInvocationID.x + 3)) == i32vec4(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2, gl_GlobalInvocationID.x + 3) ) {
        control = i32vec4(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2, gl_GlobalInvocationID.x + 3);
    } else {
        // set wrong value
        control = i32vec4(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1, gl_GlobalInvocationID.x*2 + 3 + 2, gl_GlobalInvocationID.x*2 + 3 + 3);
    }
    outputBuffer[gl_GlobalInvocationID.x].x = gl_GlobalInvocationID.x;
    outputBuffer[gl_GlobalInvocationID.x].y = uint(control == i32vec4(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2, gl_GlobalInvocationID.x + 3));
}
#version 460 core
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i64vec4 expectKHR(i64vec4, i64vec4);
precision highp float;
precision highp int;
layout(set = 0, binding = 0, std430) buffer Block0 { uvec2 outputBuffer[]; };
layout(set = 0, binding = 1, std430) buffer Block1 { i64vec4 inputBuffer[]; };
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
void main()
{
    i64vec4 control = i64vec4(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1, gl_GlobalInvocationID.x*2 + 3 + 2, gl_GlobalInvocationID.x*2 + 3 + 3);
    if ( expectKHR(inputBuffer[gl_GlobalInvocationID.x], i64vec4(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2, gl_GlobalInvocationID.x + 3)) == i64vec4(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2, gl_GlobalInvocationID.x + 3) ) {
        control = i64vec4(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2, gl_GlobalInvocationID.x + 3);
    } else {
        // set wrong value
        control = i64vec4(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1, gl_GlobalInvocationID.x*2 + 3 + 2, gl_GlobalInvocationID.x*2 + 3 + 3);
    }
    outputBuffer[gl_GlobalInvocationID.x].x = gl_GlobalInvocationID.x;
    outputBuffer[gl_GlobalInvocationID.x].y = uint(control == i64vec4(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2, gl_GlobalInvocationID.x + 3));
}
#version 460 core
#extension GL_EXT_spirv_intrinsics: enable

spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
bool expectKHR(bool, bool);
precision highp float;
precision highp int;
layout(set = 0, binding = 0, std430) buffer Block0 { uvec2 outputBuffer[]; };
layout(set = 0, binding = 1, std430) buffer Block1 { bool inputBuffer[]; };
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
void main()
{
    bool control = bool(false);
    if ( expectKHR(inputBuffer[gl_GlobalInvocationID.x], bool(true)) == bool(true) ) {
        control = bool(true);
    } else {
        // set wrong value
        control = bool(false);
    }
    outputBuffer[gl_GlobalInvocationID.x].x = gl_GlobalInvocationID.x;
    outputBuffer[gl_GlobalInvocationID.x].y = uint(control == bool(false));
}
#version 460 core
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int8: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
int8_t expectKHR(int8_t, int8_t);
precision highp float;
precision highp int;
layout(set = 0, binding = 0, std430) buffer Block0 { uvec2 outputBuffer[]; };
layout(set = 0, binding = 1, std430) buffer Block1 { int8_t inputBuffer[]; };
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
void main()
{
    int8_t control = int8_t(gl_GlobalInvocationID.x*2 + 3);
    if ( expectKHR(inputBuffer[gl_GlobalInvocationID.x], int8_t(gl_GlobalInvocationID.x)) == int8_t(gl_GlobalInvocationID.x) ) {
        control = int8_t(gl_GlobalInvocationID.x);
    } else {
        // set wrong value
        control = int8_t(gl_GlobalInvocationID.x*2 + 3);
    }
    outputBuffer[gl_GlobalInvocationID.x].x = gl_GlobalInvocationID.x;
    outputBuffer[gl_GlobalInvocationID.x].y = uint(control == int8_t(gl_GlobalInvocationID.x*2 + 3));
}
#version 460 core
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int16: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
int16_t expectKHR(int16_t, int16_t);
precision highp float;
precision highp int;
layout(set = 0, binding = 0, std430) buffer Block0 { uvec2 outputBuffer[]; };
layout(set = 0, binding = 1, std430) buffer Block1 { int16_t inputBuffer[]; };
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
void main()
{
    int16_t control = int16_t(gl_GlobalInvocationID.x*2 + 3);
    if ( expectKHR(inputBuffer[gl_GlobalInvocationID.x], int16_t(gl_GlobalInvocationID.x)) == int16_t(gl_GlobalInvocationID.x) ) {
        control = int16_t(gl_GlobalInvocationID.x);
    } else {
        // set wrong value
        control = int16_t(gl_GlobalInvocationID.x*2 + 3);
    }
    outputBuffer[gl_GlobalInvocationID.x].x = gl_GlobalInvocationID.x;
    outputBuffer[gl_GlobalInvocationID.x].y = uint(control == int16_t(gl_GlobalInvocationID.x*2 + 3));
}
#version 460 core
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int32: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
int32_t expectKHR(int32_t, int32_t);
precision highp float;
precision highp int;
layout(set = 0, binding = 0, std430) buffer Block0 { uvec2 outputBuffer[]; };
layout(set = 0, binding = 1, std430) buffer Block1 { int32_t inputBuffer[]; };
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
void main()
{
    int32_t control = int32_t(gl_GlobalInvocationID.x*2 + 3);
    if ( expectKHR(inputBuffer[gl_GlobalInvocationID.x], int32_t(gl_GlobalInvocationID.x)) == int32_t(gl_GlobalInvocationID.x) ) {
        control = int32_t(gl_GlobalInvocationID.x);
    } else {
        // set wrong value
        control = int32_t(gl_GlobalInvocationID.x*2 + 3);
    }
    outputBuffer[gl_GlobalInvocationID.x].x = gl_GlobalInvocationID.x;
    outputBuffer[gl_GlobalInvocationID.x].y = uint(control == int32_t(gl_GlobalInvocationID.x*2 + 3));
}
#version 460 core
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
int64_t expectKHR(int64_t, int64_t);
precision highp float;
precision highp int;
layout(set = 0, binding = 0, std430) buffer Block0 { uvec2 outputBuffer[]; };
layout(set = 0, binding = 1, std430) buffer Block1 { int64_t inputBuffer[]; };
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
void main()
{
    int64_t control = int64_t(gl_GlobalInvocationID.x*2 + 3);
    if ( expectKHR(inputBuffer[gl_GlobalInvocationID.x], int64_t(gl_GlobalInvocationID.x)) == int64_t(gl_GlobalInvocationID.x) ) {
        control = int64_t(gl_GlobalInvocationID.x);
    } else {
        // set wrong value
        control = int64_t(gl_GlobalInvocationID.x*2 + 3);
    }
    outputBuffer[gl_GlobalInvocationID.x].x = gl_GlobalInvocationID.x;
    outputBuffer[gl_GlobalInvocationID.x].y = uint(control == int64_t(gl_GlobalInvocationID.x*2 + 3));
}
#version 460 core
#extension GL_EXT_spirv_intrinsics: enable

spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
bvec2 expectKHR(bvec2, bvec2);
precision highp float;
precision highp int;
layout(set = 0, binding = 0, std430) buffer Block0 { uvec2 outputBuffer[]; };
layout(set = 0, binding = 1, std430) buffer Block1 { bvec2 inputBuffer[]; };
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
void main()
{
    bvec2 control = bvec2(false);
    if ( expectKHR(inputBuffer[gl_GlobalInvocationID.x], bvec2(true)) == bvec2(true) ) {
        control = bvec2(true);
    } else {
        // set wrong value
        control = bvec2(false);
    }
    outputBuffer[gl_GlobalInvocationID.x].x = gl_GlobalInvocationID.x;
    outputBuffer[gl_GlobalInvocationID.x].y = uint(control == bvec2(false));
}
#version 460 core
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int8: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i8vec2 expectKHR(i8vec2, i8vec2);
precision highp float;
precision highp int;
layout(set = 0, binding = 0, std430) buffer Block0 { uvec2 outputBuffer[]; };
layout(set = 0, binding = 1, std430) buffer Block1 { i8vec2 inputBuffer[]; };
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
void main()
{
    i8vec2 control = i8vec2(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1);
    if ( expectKHR(inputBuffer[gl_GlobalInvocationID.x], i8vec2(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1)) == i8vec2(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1) ) {
        control = i8vec2(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1);
    } else {
        // set wrong value
        control = i8vec2(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1);
    }
    outputBuffer[gl_GlobalInvocationID.x].x = gl_GlobalInvocationID.x;
    outputBuffer[gl_GlobalInvocationID.x].y = uint(control == i8vec2(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1));
}
#version 460 core
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int16: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i16vec2 expectKHR(i16vec2, i16vec2);
precision highp float;
precision highp int;
layout(set = 0, binding = 0, std430) buffer Block0 { uvec2 outputBuffer[]; };
layout(set = 0, binding = 1, std430) buffer Block1 { i16vec2 inputBuffer[]; };
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
void main()
{
    i16vec2 control = i16vec2(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1);
    if ( expectKHR(inputBuffer[gl_GlobalInvocationID.x], i16vec2(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1)) == i16vec2(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1) ) {
        control = i16vec2(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1);
    } else {
        // set wrong value
        control = i16vec2(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1);
    }
    outputBuffer[gl_GlobalInvocationID.x].x = gl_GlobalInvocationID.x;
    outputBuffer[gl_GlobalInvocationID.x].y = uint(control == i16vec2(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1));
}
#version 460 core
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int32: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i32vec2 expectKHR(i32vec2, i32vec2);
precision highp float;
precision highp int;
layout(set = 0, binding = 0, std430) buffer Block0 { uvec2 outputBuffer[]; };
layout(set = 0, binding = 1, std430) buffer Block1 { i32vec2 inputBuffer[]; };
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
void main()
{
    i32vec2 control = i32vec2(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1);
    if ( expectKHR(inputBuffer[gl_GlobalInvocationID.x], i32vec2(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1)) == i32vec2(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1) ) {
        control = i32vec2(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1);
    } else {
        // set wrong value
        control = i32vec2(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1);
    }
    outputBuffer[gl_GlobalInvocationID.x].x = gl_GlobalInvocationID.x;
    outputBuffer[gl_GlobalInvocationID.x].y = uint(control == i32vec2(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1));
}
#version 460 core
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i64vec2 expectKHR(i64vec2, i64vec2);
precision highp float;
precision highp int;
layout(set = 0, binding = 0, std430) buffer Block0 { uvec2 outputBuffer[]; };
layout(set = 0, binding = 1, std430) buffer Block1 { i64vec2 inputBuffer[]; };
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
void main()
{
    i64vec2 control = i64vec2(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1);
    if ( expectKHR(inputBuffer[gl_GlobalInvocationID.x], i64vec2(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1)) == i64vec2(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1) ) {
        control = i64vec2(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1);
    } else {
        // set wrong value
        control = i64vec2(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1);
    }
    outputBuffer[gl_GlobalInvocationID.x].x = gl_GlobalInvocationID.x;
    outputBuffer[gl_GlobalInvocationID.x].y = uint(control == i64vec2(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1));
}
#version 460 core
#extension GL_EXT_spirv_intrinsics: enable

spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
bvec3 expectKHR(bvec3, bvec3);
precision highp float;
precision highp int;
layout(set = 0, binding = 0, std430) buffer Block0 { uvec2 outputBuffer[]; };
layout(set = 0, binding = 1, std430) buffer Block1 { bvec3 inputBuffer[]; };
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
void main()
{
    bvec3 control = bvec3(false);
    if ( expectKHR(inputBuffer[gl_GlobalInvocationID.x], bvec3(true)) == bvec3(true) ) {
        control = bvec3(true);
    } else {
        // set wrong value
        control = bvec3(false);
    }
    outputBuffer[gl_GlobalInvocationID.x].x = gl_GlobalInvocationID.x;
    outputBuffer[gl_GlobalInvocationID.x].y = uint(control == bvec3(false));
}
#version 460 core
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int8: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i8vec3 expectKHR(i8vec3, i8vec3);
precision highp float;
precision highp int;
layout(set = 0, binding = 0, std430) buffer Block0 { uvec2 outputBuffer[]; };
layout(set = 0, binding = 1, std430) buffer Block1 { i8vec3 inputBuffer[]; };
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
void main()
{
    i8vec3 control = i8vec3(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1, gl_GlobalInvocationID.x*2 + 3 + 2);
    if ( expectKHR(inputBuffer[gl_GlobalInvocationID.x], i8vec3(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2)) == i8vec3(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2) ) {
        control = i8vec3(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2);
    } else {
        // set wrong value
        control = i8vec3(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1, gl_GlobalInvocationID.x*2 + 3 + 2);
    }
    outputBuffer[gl_GlobalInvocationID.x].x = gl_GlobalInvocationID.x;
    outputBuffer[gl_GlobalInvocationID.x].y = uint(control == i8vec3(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1, gl_GlobalInvocationID.x*2 + 3 + 2));
}
#version 460 core
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int16: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i16vec3 expectKHR(i16vec3, i16vec3);
precision highp float;
precision highp int;
layout(set = 0, binding = 0, std430) buffer Block0 { uvec2 outputBuffer[]; };
layout(set = 0, binding = 1, std430) buffer Block1 { i16vec3 inputBuffer[]; };
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
void main()
{
    i16vec3 control = i16vec3(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1, gl_GlobalInvocationID.x*2 + 3 + 2);
    if ( expectKHR(inputBuffer[gl_GlobalInvocationID.x], i16vec3(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2)) == i16vec3(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2) ) {
        control = i16vec3(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2);
    } else {
        // set wrong value
        control = i16vec3(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1, gl_GlobalInvocationID.x*2 + 3 + 2);
    }
    outputBuffer[gl_GlobalInvocationID.x].x = gl_GlobalInvocationID.x;
    outputBuffer[gl_GlobalInvocationID.x].y = uint(control == i16vec3(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1, gl_GlobalInvocationID.x*2 + 3 + 2));
}
#version 460 core
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int32: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i32vec3 expectKHR(i32vec3, i32vec3);
precision highp float;
precision highp int;
layout(set = 0, binding = 0, std430) buffer Block0 { uvec2 outputBuffer[]; };
layout(set = 0, binding = 1, std430) buffer Block1 { i32vec3 inputBuffer[]; };
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
void main()
{
    i32vec3 control = i32vec3(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1, gl_GlobalInvocationID.x*2 + 3 + 2);
    if ( expectKHR(inputBuffer[gl_GlobalInvocationID.x], i32vec3(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2)) == i32vec3(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2) ) {
        control = i32vec3(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2);
    } else {
        // set wrong value
        control = i32vec3(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1, gl_GlobalInvocationID.x*2 + 3 + 2);
    }
    outputBuffer[gl_GlobalInvocationID.x].x = gl_GlobalInvocationID.x;
    outputBuffer[gl_GlobalInvocationID.x].y = uint(control == i32vec3(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1, gl_GlobalInvocationID.x*2 + 3 + 2));
}
#version 460 core
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i64vec3 expectKHR(i64vec3, i64vec3);
precision highp float;
precision highp int;
layout(set = 0, binding = 0, std430) buffer Block0 { uvec2 outputBuffer[]; };
layout(set = 0, binding = 1, std430) buffer Block1 { i64vec3 inputBuffer[]; };
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
void main()
{
    i64vec3 control = i64vec3(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1, gl_GlobalInvocationID.x*2 + 3 + 2);
    if ( expectKHR(inputBuffer[gl_GlobalInvocationID.x], i64vec3(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2)) == i64vec3(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2) ) {
        control = i64vec3(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2);
    } else {
        // set wrong value
        control = i64vec3(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1, gl_GlobalInvocationID.x*2 + 3 + 2);
    }
    outputBuffer[gl_GlobalInvocationID.x].x = gl_GlobalInvocationID.x;
    outputBuffer[gl_GlobalInvocationID.x].y = uint(control == i64vec3(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1, gl_GlobalInvocationID.x*2 + 3 + 2));
}
#version 460 core
#extension GL_EXT_spirv_intrinsics: enable

spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
bvec4 expectKHR(bvec4, bvec4);
precision highp float;
precision highp int;
layout(set = 0, binding = 0, std430) buffer Block0 { uvec2 outputBuffer[]; };
layout(set = 0, binding = 1, std430) buffer Block1 { bvec4 inputBuffer[]; };
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
void main()
{
    bvec4 control = bvec4(false);
    if ( expectKHR(inputBuffer[gl_GlobalInvocationID.x], bvec4(true)) == bvec4(true) ) {
        control = bvec4(true);
    } else {
        // set wrong value
        control = bvec4(false);
    }
    outputBuffer[gl_GlobalInvocationID.x].x = gl_GlobalInvocationID.x;
    outputBuffer[gl_GlobalInvocationID.x].y = uint(control == bvec4(false));
}
#version 460 core
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int8: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i8vec4 expectKHR(i8vec4, i8vec4);
precision highp float;
precision highp int;
layout(set = 0, binding = 0, std430) buffer Block0 { uvec2 outputBuffer[]; };
layout(set = 0, binding = 1, std430) buffer Block1 { i8vec4 inputBuffer[]; };
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
void main()
{
    i8vec4 control = i8vec4(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1, gl_GlobalInvocationID.x*2 + 3 + 2, gl_GlobalInvocationID.x*2 + 3 + 3);
    if ( expectKHR(inputBuffer[gl_GlobalInvocationID.x], i8vec4(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2, gl_GlobalInvocationID.x + 3)) == i8vec4(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2, gl_GlobalInvocationID.x + 3) ) {
        control = i8vec4(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2, gl_GlobalInvocationID.x + 3);
    } else {
        // set wrong value
        control = i8vec4(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1, gl_GlobalInvocationID.x*2 + 3 + 2, gl_GlobalInvocationID.x*2 + 3 + 3);
    }
    outputBuffer[gl_GlobalInvocationID.x].x = gl_GlobalInvocationID.x;
    outputBuffer[gl_GlobalInvocationID.x].y = uint(control == i8vec4(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1, gl_GlobalInvocationID.x*2 + 3 + 2, gl_GlobalInvocationID.x*2 + 3 + 3));
}
#version 460 core
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int16: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i16vec4 expectKHR(i16vec4, i16vec4);
precision highp float;
precision highp int;
layout(set = 0, binding = 0, std430) buffer Block0 { uvec2 outputBuffer[]; };
layout(set = 0, binding = 1, std430) buffer Block1 { i16vec4 inputBuffer[]; };
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
void main()
{
    i16vec4 control = i16vec4(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1, gl_GlobalInvocationID.x*2 + 3 + 2, gl_GlobalInvocationID.x*2 + 3 + 3);
    if ( expectKHR(inputBuffer[gl_GlobalInvocationID.x], i16vec4(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2, gl_GlobalInvocationID.x + 3)) == i16vec4(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2, gl_GlobalInvocationID.x + 3) ) {
        control = i16vec4(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2, gl_GlobalInvocationID.x + 3);
    } else {
        // set wrong value
        control = i16vec4(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1, gl_GlobalInvocationID.x*2 + 3 + 2, gl_GlobalInvocationID.x*2 + 3 + 3);
    }
    outputBuffer[gl_GlobalInvocationID.x].x = gl_GlobalInvocationID.x;
    outputBuffer[gl_GlobalInvocationID.x].y = uint(control == i16vec4(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1, gl_GlobalInvocationID.x*2 + 3 + 2, gl_GlobalInvocationID.x*2 + 3 + 3));
}
#version 460 core
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int32: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i32vec4 expectKHR(i32vec4, i32vec4);
precision highp float;
precision highp int;
layout(set = 0, binding = 0, std430) buffer Block0 { uvec2 outputBuffer[]; };
layout(set = 0, binding = 1, std430) buffer Block1 { i32vec4 inputBuffer[]; };
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
void main()
{
    i32vec4 control = i32vec4(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1, gl_GlobalInvocationID.x*2 + 3 + 2, gl_GlobalInvocationID.x*2 + 3 + 3);
    if ( expectKHR(inputBuffer[gl_GlobalInvocationID.x], i32vec4(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2, gl_GlobalInvocationID.x + 3)) == i32vec4(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2, gl_GlobalInvocationID.x + 3) ) {
        control = i32vec4(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2, gl_GlobalInvocationID.x + 3);
    } else {
        // set wrong value
        control = i32vec4(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1, gl_GlobalInvocationID.x*2 + 3 + 2, gl_GlobalInvocationID.x*2 + 3 + 3);
    }
    outputBuffer[gl_GlobalInvocationID.x].x = gl_GlobalInvocationID.x;
    outputBuffer[gl_GlobalInvocationID.x].y = uint(control == i32vec4(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1, gl_GlobalInvocationID.x*2 + 3 + 2, gl_GlobalInvocationID.x*2 + 3 + 3));
}
#version 460 core
#extension GL_EXT_spirv_intrinsics: enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64: enable
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5630)
void assumeTrueKHR(bool);
spirv_instruction (extensions = ["SPV_KHR_expect_assume"], capabilities = [5629], id = 5631)
i64vec4 expectKHR(i64vec4, i64vec4);
precision highp float;
precision highp int;
layout(set = 0, binding = 0, std430) buffer Block0 { uvec2 outputBuffer[]; };
layout(set = 0, binding = 1, std430) buffer Block1 { i64vec4 inputBuffer[]; };
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;
void main()
{
    i64vec4 control = i64vec4(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1, gl_GlobalInvocationID.x*2 + 3 + 2, gl_GlobalInvocationID.x*2 + 3 + 3);
    if ( expectKHR(inputBuffer[gl_GlobalInvocationID.x], i64vec4(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2, gl_GlobalInvocationID.x + 3)) == i64vec4(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2, gl_GlobalInvocationID.x + 3) ) {
        control = i64vec4(gl_GlobalInvocationID.x, gl_GlobalInvocationID.x + 1, gl_GlobalInvocationID.x + 2, gl_GlobalInvocationID.x + 3);
    } else {
        // set wrong value
        control = i64vec4(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1, gl_GlobalInvocationID.x*2 + 3 + 2, gl_GlobalInvocationID.x*2 + 3 + 3);
    }
    outputBuffer[gl_GlobalInvocationID.x].x = gl_GlobalInvocationID.x;
    outputBuffer[gl_GlobalInvocationID.x].y = uint(control == i64vec4(gl_GlobalInvocationID.x*2 + 3, gl_GlobalInvocationID.x*2 + 3 + 1, gl_GlobalInvocationID.x*2 + 3 + 2, gl_GlobalInvocationID.x*2 + 3 + 3));
}
