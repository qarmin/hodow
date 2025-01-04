#version 460 core
#extension GL_EXT_long_vector : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_EXT_shader_16bit_storage : enable
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer SSBO_t { vector<float16_t, 13> val[]; } ssbo0_1;
float16_t refData[117] = float16_t[](float16_t(3), float16_t(5), float16_t(7), float16_t(9), float16_t(11), float16_t(13), float16_t(15), float16_t(17), float16_t(19), float16_t(21), float16_t(23), float16_t(25), float16_t(27), float16_t(29), float16_t(31), float16_t(33), float16_t(35), float16_t(37), float16_t(39), float16_t(41), float16_t(43), float16_t(45), float16_t(47), float16_t(49), float16_t(51), float16_t(53), float16_t(55), float16_t(57), float16_t(59), float16_t(61), float16_t(63), float16_t(65), float16_t(67), float16_t(69), float16_t(71), float16_t(73), float16_t(75), float16_t(77), float16_t(79), float16_t(81), float16_t(83), float16_t(85), float16_t(87), float16_t(89), float16_t(91), float16_t(93), float16_t(95), float16_t(97), float16_t(99), float16_t(101), float16_t(103), float16_t(105), float16_t(107), float16_t(109), float16_t(111), float16_t(113), float16_t(115), float16_t(117), float16_t(119), float16_t(121), float16_t(123), float16_t(125), float16_t(127), float16_t(129), float16_t(131), float16_t(133), float16_t(135), float16_t(137), float16_t(139), float16_t(141), float16_t(143), float16_t(145), float16_t(147), float16_t(149), float16_t(151), float16_t(153), float16_t(155), float16_t(157), float16_t(159), float16_t(161), float16_t(163), float16_t(165), float16_t(167), float16_t(169), float16_t(171), float16_t(173), float16_t(175), float16_t(177), float16_t(179), float16_t(181), float16_t(183), float16_t(185), float16_t(187), float16_t(189), float16_t(191), float16_t(193), float16_t(195), float16_t(197), float16_t(199), float16_t(201), float16_t(203), float16_t(205), float16_t(207), float16_t(209), float16_t(211), float16_t(213), float16_t(215), float16_t(217), float16_t(219), float16_t(221), float16_t(223), float16_t(225), float16_t(227), float16_t(229), float16_t(231), float16_t(233), float16_t(235));
const int N            = 13;
const int INBOUND      = 9;
const int LOOP_LOW     = -10;
const int LOOP_HIGH    = 19;
const float16_t STORE_VAL = float16_t(7777);
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
    uint accum = 0u;
    vector<float16_t, 13> v;
    float16_t expected;
    [[dont_unroll]]
    for (int c = LOOP_LOW; c <= LOOP_HIGH; ++c) {
        bool inb = (c >= 0 && c < INBOUND);
        v = ssbo0_1.val[c];
        [[unroll]] for (int i = 0; i < N; ++i) {
            if (inb) {
                expected = refData[c * N + i];
            } else {
                expected = float16_t(0);
            }
            if (v[i] != expected) accum += 1u;
        }
    }
    uvec4 color = (accum != 0u) ? uvec4(0, 0, 0, 1) : uvec4(1, 0, 0, 1);
    imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_long_vector : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_EXT_shader_16bit_storage : enable
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) uniform UBO_t { vector<float16_t, 5> val[204]; } ubo0_1;
float16_t refData[130] = float16_t[](float16_t(3), float16_t(5), float16_t(7), float16_t(9), float16_t(11), float16_t(13), float16_t(15), float16_t(17), float16_t(19), float16_t(21), float16_t(23), float16_t(25), float16_t(27), float16_t(29), float16_t(31), float16_t(33), float16_t(35), float16_t(37), float16_t(39), float16_t(41), float16_t(43), float16_t(45), float16_t(47), float16_t(49), float16_t(51), float16_t(53), float16_t(55), float16_t(57), float16_t(59), float16_t(61), float16_t(63), float16_t(65), float16_t(67), float16_t(69), float16_t(71), float16_t(73), float16_t(75), float16_t(77), float16_t(79), float16_t(81), float16_t(83), float16_t(85), float16_t(87), float16_t(89), float16_t(91), float16_t(93), float16_t(95), float16_t(97), float16_t(99), float16_t(101), float16_t(103), float16_t(105), float16_t(107), float16_t(109), float16_t(111), float16_t(113), float16_t(115), float16_t(117), float16_t(119), float16_t(121), float16_t(123), float16_t(125), float16_t(127), float16_t(129), float16_t(131), float16_t(133), float16_t(135), float16_t(137), float16_t(139), float16_t(141), float16_t(143), float16_t(145), float16_t(147), float16_t(149), float16_t(151), float16_t(153), float16_t(155), float16_t(157), float16_t(159), float16_t(161), float16_t(163), float16_t(165), float16_t(167), float16_t(169), float16_t(171), float16_t(173), float16_t(175), float16_t(177), float16_t(179), float16_t(181), float16_t(183), float16_t(185), float16_t(187), float16_t(189), float16_t(191), float16_t(193), float16_t(195), float16_t(197), float16_t(199), float16_t(201), float16_t(203), float16_t(205), float16_t(207), float16_t(209), float16_t(211), float16_t(213), float16_t(215), float16_t(217), float16_t(219), float16_t(221), float16_t(223), float16_t(225), float16_t(227), float16_t(229), float16_t(231), float16_t(233), float16_t(235), float16_t(237), float16_t(239), float16_t(241), float16_t(243), float16_t(245), float16_t(247), float16_t(249), float16_t(251), float16_t(253), float16_t(255), float16_t(257), float16_t(259), float16_t(261));
const int N            = 5;
const int INBOUND      = 26;
const int LOOP_LOW     = -10;
const int LOOP_HIGH    = 36;
const float16_t STORE_VAL = float16_t(7777);
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
    uint accum = 0u;
    vector<float16_t, 5> v;
    float16_t expected;
    [[unroll]]
    for (int c = LOOP_LOW; c <= LOOP_HIGH; ++c) {
        bool inb = (c >= 0 && c < INBOUND);
        v = ubo0_1.val[c];
        [[unroll]] for (int i = 0; i < N; ++i) {
            if (inb) {
                expected = refData[c * N + i];
            } else {
                expected = float16_t(0);
            }
            if (v[i] != expected) accum += 1u;
        }
    }
    uvec4 color = (accum != 0u) ? uvec4(0, 0, 0, 1) : uvec4(1, 0, 0, 1);
    imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_long_vector : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_EXT_shader_16bit_storage : enable
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer SSBO_t { vector<float16_t, 8> val[]; } ssbo0_1;
float16_t refData[128] = float16_t[](float16_t(3), float16_t(5), float16_t(7), float16_t(9), float16_t(11), float16_t(13), float16_t(15), float16_t(17), float16_t(19), float16_t(21), float16_t(23), float16_t(25), float16_t(27), float16_t(29), float16_t(31), float16_t(33), float16_t(35), float16_t(37), float16_t(39), float16_t(41), float16_t(43), float16_t(45), float16_t(47), float16_t(49), float16_t(51), float16_t(53), float16_t(55), float16_t(57), float16_t(59), float16_t(61), float16_t(63), float16_t(65), float16_t(67), float16_t(69), float16_t(71), float16_t(73), float16_t(75), float16_t(77), float16_t(79), float16_t(81), float16_t(83), float16_t(85), float16_t(87), float16_t(89), float16_t(91), float16_t(93), float16_t(95), float16_t(97), float16_t(99), float16_t(101), float16_t(103), float16_t(105), float16_t(107), float16_t(109), float16_t(111), float16_t(113), float16_t(115), float16_t(117), float16_t(119), float16_t(121), float16_t(123), float16_t(125), float16_t(127), float16_t(129), float16_t(131), float16_t(133), float16_t(135), float16_t(137), float16_t(139), float16_t(141), float16_t(143), float16_t(145), float16_t(147), float16_t(149), float16_t(151), float16_t(153), float16_t(155), float16_t(157), float16_t(159), float16_t(161), float16_t(163), float16_t(165), float16_t(167), float16_t(169), float16_t(171), float16_t(173), float16_t(175), float16_t(177), float16_t(179), float16_t(181), float16_t(183), float16_t(185), float16_t(187), float16_t(189), float16_t(191), float16_t(193), float16_t(195), float16_t(197), float16_t(199), float16_t(201), float16_t(203), float16_t(205), float16_t(207), float16_t(209), float16_t(211), float16_t(213), float16_t(215), float16_t(217), float16_t(219), float16_t(221), float16_t(223), float16_t(225), float16_t(227), float16_t(229), float16_t(231), float16_t(233), float16_t(235), float16_t(237), float16_t(239), float16_t(241), float16_t(243), float16_t(245), float16_t(247), float16_t(249), float16_t(251), float16_t(253), float16_t(255), float16_t(257));
const int N            = 8;
const int INBOUND      = 16;
const int LOOP_LOW     = -10;
const int LOOP_HIGH    = 26;
const float16_t STORE_VAL = float16_t(7777);
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
    uint accum = 0u;
    vector<float16_t, 8> v;
    float16_t expected;
    [[dont_unroll]]
    for (int c = LOOP_LOW; c <= LOOP_HIGH; ++c) {
        bool inb = (c >= 0 && c < INBOUND);
        v = ssbo0_1.val[c];
        [[unroll]] for (int i = 0; i < N; ++i) {
            if (inb) {
                expected = refData[c * N + i];
            } else {
                expected = float16_t(0);
            }
            if (v[i] != expected) accum += 1u;
        }
    }
    uvec4 color = (accum != 0u) ? uvec4(0, 0, 0, 1) : uvec4(1, 0, 0, 1);
    imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_long_vector : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#extension GL_EXT_shader_16bit_storage : enable
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) buffer SSBO_t { vector<float16_t, 8> val[]; } ssbo0_1;
float16_t refData[16] = float16_t[](float16_t(3), float16_t(5), float16_t(7), float16_t(9), float16_t(11), float16_t(13), float16_t(15), float16_t(17), float16_t(19), float16_t(21), float16_t(23), float16_t(25), float16_t(27), float16_t(29), float16_t(31), float16_t(33));
const int N            = 8;
const int INBOUND      = 2;
const int LOOP_LOW     = -10;
const int LOOP_HIGH    = 12;
const float16_t STORE_VAL = float16_t(7777);
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
    uint accum = 0u;
    vector<float16_t, 8> v;
    float16_t expected;
    [[unroll]]
    for (int c = LOOP_LOW; c <= LOOP_HIGH; ++c) {
        bool inb = (c >= 0 && c < INBOUND);
        v = ssbo0_1.val[c];
        [[unroll]] for (int i = 0; i < N; ++i) {
            if (inb) {
                expected = refData[c * N + i];
            } else {
                expected = float16_t(0);
            }
            if (v[i] != expected) accum += 1u;
        }
    }
    [[unroll]]
    for (int c = LOOP_LOW; c <= LOOP_HIGH; ++c) {
        bool oob = (c < 0 || c >= INBOUND);
        if (oob) {
            ssbo0_1.val[c] = vector<float16_t, 8>(STORE_VAL);
        }
    }
    memoryBarrierBuffer();
    [[unroll]]
    for (int c = LOOP_LOW; c <= LOOP_HIGH; ++c) {
        bool inb = (c >= 0 && c < INBOUND);
        v = ssbo0_1.val[c];
        [[unroll]] for (int i = 0; i < N; ++i) {
            if (inb) {
                expected = refData[c * N + i];
            } else {
                expected = float16_t(0);
            }
            if (v[i] != expected) accum += 1u;
        }
    }
    uvec4 color = (accum != 0u) ? uvec4(0, 0, 0, 1) : uvec4(1, 0, 0, 1);
    imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_long_vector : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer SSBO_t { vector<float, 11> val[]; } ssbo0_1;
float refData[55] = float[](float(3), float(5), float(7), float(9), float(11), float(13), float(15), float(17), float(19), float(21), float(23), float(25), float(27), float(29), float(31), float(33), float(35), float(37), float(39), float(41), float(43), float(45), float(47), float(49), float(51), float(53), float(55), float(57), float(59), float(61), float(63), float(65), float(67), float(69), float(71), float(73), float(75), float(77), float(79), float(81), float(83), float(85), float(87), float(89), float(91), float(93), float(95), float(97), float(99), float(101), float(103), float(105), float(107), float(109), float(111));
const int N            = 11;
const int INBOUND      = 5;
const int LOOP_LOW     = -10;
const int LOOP_HIGH    = 15;
const float STORE_VAL = float(7777);
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
    uint accum = 0u;
    vector<float, 11> v;
    float expected;
    [[dont_unroll]]
    for (int c = LOOP_LOW; c <= LOOP_HIGH; ++c) {
        bool inb = (c >= 0 && c < INBOUND);
        v = ssbo0_1.val[c];
        [[unroll]] for (int i = 0; i < N; ++i) {
            if (inb) {
                expected = refData[c * N + i];
            } else {
                expected = float(0);
            }
            if (v[i] != expected) accum += 1u;
        }
    }
    uvec4 color = (accum != 0u) ? uvec4(0, 0, 0, 1) : uvec4(1, 0, 0, 1);
    imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_long_vector : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) buffer SSBO_t { vector<float, 11> val[]; } ssbo0_1;
float refData[55] = float[](float(3), float(5), float(7), float(9), float(11), float(13), float(15), float(17), float(19), float(21), float(23), float(25), float(27), float(29), float(31), float(33), float(35), float(37), float(39), float(41), float(43), float(45), float(47), float(49), float(51), float(53), float(55), float(57), float(59), float(61), float(63), float(65), float(67), float(69), float(71), float(73), float(75), float(77), float(79), float(81), float(83), float(85), float(87), float(89), float(91), float(93), float(95), float(97), float(99), float(101), float(103), float(105), float(107), float(109), float(111));
const int N            = 11;
const int INBOUND      = 5;
const int LOOP_LOW     = -10;
const int LOOP_HIGH    = 15;
const float STORE_VAL = float(7777);
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
    uint accum = 0u;
    vector<float, 11> v;
    float expected;
    [[unroll]]
    for (int c = LOOP_LOW; c <= LOOP_HIGH; ++c) {
        bool inb = (c >= 0 && c < INBOUND);
        v = ssbo0_1.val[c];
        [[unroll]] for (int i = 0; i < N; ++i) {
            if (inb) {
                expected = refData[c * N + i];
            } else {
                expected = float(0);
            }
            if (v[i] != expected) accum += 1u;
        }
    }
    [[unroll]]
    for (int c = LOOP_LOW; c <= LOOP_HIGH; ++c) {
        bool oob = (c < 0 || c >= INBOUND);
        if (oob) {
            ssbo0_1.val[c] = vector<float, 11>(STORE_VAL);
        }
    }
    memoryBarrierBuffer();
    [[unroll]]
    for (int c = LOOP_LOW; c <= LOOP_HIGH; ++c) {
        bool inb = (c >= 0 && c < INBOUND);
        v = ssbo0_1.val[c];
        [[unroll]] for (int i = 0; i < N; ++i) {
            if (inb) {
                expected = refData[c * N + i];
            } else {
                expected = float(0);
            }
            if (v[i] != expected) accum += 1u;
        }
    }
    uvec4 color = (accum != 0u) ? uvec4(0, 0, 0, 1) : uvec4(1, 0, 0, 1);
    imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_long_vector : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer SSBO_t { vector<float, 11> val[]; } ssbo0_1;
float refData[55] = float[](float(3), float(5), float(7), float(9), float(11), float(13), float(15), float(17), float(19), float(21), float(23), float(25), float(27), float(29), float(31), float(33), float(35), float(37), float(39), float(41), float(43), float(45), float(47), float(49), float(51), float(53), float(55), float(57), float(59), float(61), float(63), float(65), float(67), float(69), float(71), float(73), float(75), float(77), float(79), float(81), float(83), float(85), float(87), float(89), float(91), float(93), float(95), float(97), float(99), float(101), float(103), float(105), float(107), float(109), float(111));
const int N            = 11;
const int INBOUND      = 5;
const int LOOP_LOW     = -10;
const int LOOP_HIGH    = 15;
const float STORE_VAL = float(7777);
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
    uint accum = 0u;
    vector<float, 11> v;
    float expected;
    [[unroll]]
    for (int c = LOOP_LOW; c <= LOOP_HIGH; ++c) {
        bool inb = (c >= 0 && c < INBOUND);
        v = ssbo0_1.val[c];
        [[unroll]] for (int i = 0; i < N; ++i) {
            if (inb) {
                expected = refData[c * N + i];
            } else {
                expected = float(0);
            }
            if (v[i] != expected) accum += 1u;
        }
    }
    uvec4 color = (accum != 0u) ? uvec4(0, 0, 0, 1) : uvec4(1, 0, 0, 1);
    imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_long_vector : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) uniform UBO_t { vector<float, 16> val[64]; } ubo0_1;
float refData[64] = float[](float(3), float(5), float(7), float(9), float(11), float(13), float(15), float(17), float(19), float(21), float(23), float(25), float(27), float(29), float(31), float(33), float(35), float(37), float(39), float(41), float(43), float(45), float(47), float(49), float(51), float(53), float(55), float(57), float(59), float(61), float(63), float(65), float(67), float(69), float(71), float(73), float(75), float(77), float(79), float(81), float(83), float(85), float(87), float(89), float(91), float(93), float(95), float(97), float(99), float(101), float(103), float(105), float(107), float(109), float(111), float(113), float(115), float(117), float(119), float(121), float(123), float(125), float(127), float(129));
const int N            = 16;
const int INBOUND      = 4;
const int LOOP_LOW     = -10;
const int LOOP_HIGH    = 14;
const float STORE_VAL = float(7777);
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
    uint accum = 0u;
    vector<float, 16> v;
    float expected;
    [[dont_unroll]]
    for (int c = LOOP_LOW; c <= LOOP_HIGH; ++c) {
        bool inb = (c >= 0 && c < INBOUND);
        v = ubo0_1.val[c];
        [[unroll]] for (int i = 0; i < N; ++i) {
            if (inb) {
                expected = refData[c * N + i];
            } else {
                expected = float(0);
            }
            if (v[i] != expected) accum += 1u;
        }
    }
    uvec4 color = (accum != 0u) ? uvec4(0, 0, 0, 1) : uvec4(1, 0, 0, 1);
    imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_long_vector : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) uniform UBO_t { vector<float, 5> val[204]; } ubo0_1;
float refData[65] = float[](float(3), float(5), float(7), float(9), float(11), float(13), float(15), float(17), float(19), float(21), float(23), float(25), float(27), float(29), float(31), float(33), float(35), float(37), float(39), float(41), float(43), float(45), float(47), float(49), float(51), float(53), float(55), float(57), float(59), float(61), float(63), float(65), float(67), float(69), float(71), float(73), float(75), float(77), float(79), float(81), float(83), float(85), float(87), float(89), float(91), float(93), float(95), float(97), float(99), float(101), float(103), float(105), float(107), float(109), float(111), float(113), float(115), float(117), float(119), float(121), float(123), float(125), float(127), float(129), float(131));
const int N            = 5;
const int INBOUND      = 13;
const int LOOP_LOW     = -10;
const int LOOP_HIGH    = 23;
const float STORE_VAL = float(7777);
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
    uint accum = 0u;
    vector<float, 5> v;
    float expected;
    [[dont_unroll]]
    for (int c = LOOP_LOW; c <= LOOP_HIGH; ++c) {
        bool inb = (c >= 0 && c < INBOUND);
        v = ubo0_1.val[c];
        [[unroll]] for (int i = 0; i < N; ++i) {
            if (inb) {
                expected = refData[c * N + i];
            } else {
                expected = float(0);
            }
            if (v[i] != expected) accum += 1u;
        }
    }
    uvec4 color = (accum != 0u) ? uvec4(0, 0, 0, 1) : uvec4(1, 0, 0, 1);
    imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_long_vector : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) buffer SSBO_t { vector<float, 7> val[]; } ssbo0_1;
float refData[63] = float[](float(3), float(5), float(7), float(9), float(11), float(13), float(15), float(17), float(19), float(21), float(23), float(25), float(27), float(29), float(31), float(33), float(35), float(37), float(39), float(41), float(43), float(45), float(47), float(49), float(51), float(53), float(55), float(57), float(59), float(61), float(63), float(65), float(67), float(69), float(71), float(73), float(75), float(77), float(79), float(81), float(83), float(85), float(87), float(89), float(91), float(93), float(95), float(97), float(99), float(101), float(103), float(105), float(107), float(109), float(111), float(113), float(115), float(117), float(119), float(121), float(123), float(125), float(127));
const int N            = 7;
const int INBOUND      = 9;
const int LOOP_LOW     = -10;
const int LOOP_HIGH    = 19;
const float STORE_VAL = float(7777);
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
    uint accum = 0u;
    vector<float, 7> v;
    float expected;
    [[dont_unroll]]
    for (int c = LOOP_LOW; c <= LOOP_HIGH; ++c) {
        bool inb = (c >= 0 && c < INBOUND);
        v = ssbo0_1.val[c];
        [[unroll]] for (int i = 0; i < N; ++i) {
            if (inb) {
                expected = refData[c * N + i];
            } else {
                expected = float(0);
            }
            if (v[i] != expected) accum += 1u;
        }
    }
    [[dont_unroll]]
    for (int c = LOOP_LOW; c <= LOOP_HIGH; ++c) {
        bool oob = (c < 0 || c >= INBOUND);
        if (oob) {
            ssbo0_1.val[c] = vector<float, 7>(STORE_VAL);
        }
    }
    memoryBarrierBuffer();
    [[dont_unroll]]
    for (int c = LOOP_LOW; c <= LOOP_HIGH; ++c) {
        bool inb = (c >= 0 && c < INBOUND);
        v = ssbo0_1.val[c];
        [[unroll]] for (int i = 0; i < N; ++i) {
            if (inb) {
                expected = refData[c * N + i];
            } else {
                expected = float(0);
            }
            if (v[i] != expected) accum += 1u;
        }
    }
    uvec4 color = (accum != 0u) ? uvec4(0, 0, 0, 1) : uvec4(1, 0, 0, 1);
    imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_long_vector : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer SSBO_t { vector<float, 7> val[]; } ssbo0_1;
float refData[63] = float[](float(3), float(5), float(7), float(9), float(11), float(13), float(15), float(17), float(19), float(21), float(23), float(25), float(27), float(29), float(31), float(33), float(35), float(37), float(39), float(41), float(43), float(45), float(47), float(49), float(51), float(53), float(55), float(57), float(59), float(61), float(63), float(65), float(67), float(69), float(71), float(73), float(75), float(77), float(79), float(81), float(83), float(85), float(87), float(89), float(91), float(93), float(95), float(97), float(99), float(101), float(103), float(105), float(107), float(109), float(111), float(113), float(115), float(117), float(119), float(121), float(123), float(125), float(127));
const int N            = 7;
const int INBOUND      = 9;
const int LOOP_LOW     = -10;
const int LOOP_HIGH    = 19;
const float STORE_VAL = float(7777);
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
    uint accum = 0u;
    vector<float, 7> v;
    float expected;
    [[dont_unroll]]
    for (int c = LOOP_LOW; c <= LOOP_HIGH; ++c) {
        bool inb = (c >= 0 && c < INBOUND);
        v = ssbo0_1.val[c];
        [[unroll]] for (int i = 0; i < N; ++i) {
            if (inb) {
                expected = refData[c * N + i];
            } else {
                expected = float(0);
            }
            if (v[i] != expected) accum += 1u;
        }
    }
    uvec4 color = (accum != 0u) ? uvec4(0, 0, 0, 1) : uvec4(1, 0, 0, 1);
    imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_long_vector : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) uniform UBO_t { vector<float, 7> val[146]; } ubo0_1;
float refData[63] = float[](float(3), float(5), float(7), float(9), float(11), float(13), float(15), float(17), float(19), float(21), float(23), float(25), float(27), float(29), float(31), float(33), float(35), float(37), float(39), float(41), float(43), float(45), float(47), float(49), float(51), float(53), float(55), float(57), float(59), float(61), float(63), float(65), float(67), float(69), float(71), float(73), float(75), float(77), float(79), float(81), float(83), float(85), float(87), float(89), float(91), float(93), float(95), float(97), float(99), float(101), float(103), float(105), float(107), float(109), float(111), float(113), float(115), float(117), float(119), float(121), float(123), float(125), float(127));
const int N            = 7;
const int INBOUND      = 9;
const int LOOP_LOW     = -10;
const int LOOP_HIGH    = 19;
const float STORE_VAL = float(7777);
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
    uint accum = 0u;
    vector<float, 7> v;
    float expected;
    [[unroll]]
    for (int c = LOOP_LOW; c <= LOOP_HIGH; ++c) {
        bool inb = (c >= 0 && c < INBOUND);
        v = ubo0_1.val[c];
        [[unroll]] for (int i = 0; i < N; ++i) {
            if (inb) {
                expected = refData[c * N + i];
            } else {
                expected = float(0);
            }
            if (v[i] != expected) accum += 1u;
        }
    }
    uvec4 color = (accum != 0u) ? uvec4(0, 0, 0, 1) : uvec4(1, 0, 0, 1);
    imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_long_vector : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer SSBO_t { vector<float, 8> val[]; } ssbo0_1;
float refData[64] = float[](float(3), float(5), float(7), float(9), float(11), float(13), float(15), float(17), float(19), float(21), float(23), float(25), float(27), float(29), float(31), float(33), float(35), float(37), float(39), float(41), float(43), float(45), float(47), float(49), float(51), float(53), float(55), float(57), float(59), float(61), float(63), float(65), float(67), float(69), float(71), float(73), float(75), float(77), float(79), float(81), float(83), float(85), float(87), float(89), float(91), float(93), float(95), float(97), float(99), float(101), float(103), float(105), float(107), float(109), float(111), float(113), float(115), float(117), float(119), float(121), float(123), float(125), float(127), float(129));
const int N            = 8;
const int INBOUND      = 8;
const int LOOP_LOW     = -10;
const int LOOP_HIGH    = 18;
const float STORE_VAL = float(7777);
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
    uint accum = 0u;
    vector<float, 8> v;
    float expected;
    [[dont_unroll]]
    for (int c = LOOP_LOW; c <= LOOP_HIGH; ++c) {
        bool inb = (c >= 0 && c < INBOUND);
        v = ssbo0_1.val[c];
        [[unroll]] for (int i = 0; i < N; ++i) {
            if (inb) {
                expected = refData[c * N + i];
            } else {
                expected = float(0);
            }
            if (v[i] != expected) accum += 1u;
        }
    }
    uvec4 color = (accum != 0u) ? uvec4(0, 0, 0, 1) : uvec4(1, 0, 0, 1);
    imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_long_vector : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer SSBO_t { vector<int, 13> val[]; } ssbo0_1;
int refData[52] = int[](int(3), int(5), int(7), int(9), int(11), int(13), int(15), int(17), int(19), int(21), int(23), int(25), int(27), int(29), int(31), int(33), int(35), int(37), int(39), int(41), int(43), int(45), int(47), int(49), int(51), int(53), int(55), int(57), int(59), int(61), int(63), int(65), int(67), int(69), int(71), int(73), int(75), int(77), int(79), int(81), int(83), int(85), int(87), int(89), int(91), int(93), int(95), int(97), int(99), int(101), int(103), int(105));
const int N            = 13;
const int INBOUND      = 4;
const int LOOP_LOW     = -10;
const int LOOP_HIGH    = 14;
const int STORE_VAL = int(7777);
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
    uint accum = 0u;
    vector<int, 13> v;
    int expected;
    [[unroll]]
    for (int c = LOOP_LOW; c <= LOOP_HIGH; ++c) {
        bool inb = (c >= 0 && c < INBOUND);
        v = ssbo0_1.val[c];
        [[unroll]] for (int i = 0; i < N; ++i) {
            if (inb) {
                expected = refData[c * N + i];
            } else {
                expected = int(0);
            }
            if (v[i] != expected) accum += 1u;
        }
    }
    uvec4 color = (accum != 0u) ? uvec4(0, 0, 0, 1) : uvec4(1, 0, 0, 1);
    imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_long_vector : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) buffer SSBO_t { vector<int, 16> val[]; } ssbo0_1;
int refData[64] = int[](int(3), int(5), int(7), int(9), int(11), int(13), int(15), int(17), int(19), int(21), int(23), int(25), int(27), int(29), int(31), int(33), int(35), int(37), int(39), int(41), int(43), int(45), int(47), int(49), int(51), int(53), int(55), int(57), int(59), int(61), int(63), int(65), int(67), int(69), int(71), int(73), int(75), int(77), int(79), int(81), int(83), int(85), int(87), int(89), int(91), int(93), int(95), int(97), int(99), int(101), int(103), int(105), int(107), int(109), int(111), int(113), int(115), int(117), int(119), int(121), int(123), int(125), int(127), int(129));
const int N            = 16;
const int INBOUND      = 4;
const int LOOP_LOW     = -10;
const int LOOP_HIGH    = 14;
const int STORE_VAL = int(7777);
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
    uint accum = 0u;
    vector<int, 16> v;
    int expected;
    [[dont_unroll]]
    for (int c = LOOP_LOW; c <= LOOP_HIGH; ++c) {
        bool inb = (c >= 0 && c < INBOUND);
        v = ssbo0_1.val[c];
        [[unroll]] for (int i = 0; i < N; ++i) {
            if (inb) {
                expected = refData[c * N + i];
            } else {
                expected = int(0);
            }
            if (v[i] != expected) accum += 1u;
        }
    }
    [[dont_unroll]]
    for (int c = LOOP_LOW; c <= LOOP_HIGH; ++c) {
        bool oob = (c < 0 || c >= INBOUND);
        if (oob) {
            ssbo0_1.val[c] = vector<int, 16>(STORE_VAL);
        }
    }
    memoryBarrierBuffer();
    [[dont_unroll]]
    for (int c = LOOP_LOW; c <= LOOP_HIGH; ++c) {
        bool inb = (c >= 0 && c < INBOUND);
        v = ssbo0_1.val[c];
        [[unroll]] for (int i = 0; i < N; ++i) {
            if (inb) {
                expected = refData[c * N + i];
            } else {
                expected = int(0);
            }
            if (v[i] != expected) accum += 1u;
        }
    }
    uvec4 color = (accum != 0u) ? uvec4(0, 0, 0, 1) : uvec4(1, 0, 0, 1);
    imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_long_vector : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer SSBO_t { vector<int, 5> val[]; } ssbo0_1;
int refData[65] = int[](int(3), int(5), int(7), int(9), int(11), int(13), int(15), int(17), int(19), int(21), int(23), int(25), int(27), int(29), int(31), int(33), int(35), int(37), int(39), int(41), int(43), int(45), int(47), int(49), int(51), int(53), int(55), int(57), int(59), int(61), int(63), int(65), int(67), int(69), int(71), int(73), int(75), int(77), int(79), int(81), int(83), int(85), int(87), int(89), int(91), int(93), int(95), int(97), int(99), int(101), int(103), int(105), int(107), int(109), int(111), int(113), int(115), int(117), int(119), int(121), int(123), int(125), int(127), int(129), int(131));
const int N            = 5;
const int INBOUND      = 13;
const int LOOP_LOW     = -10;
const int LOOP_HIGH    = 23;
const int STORE_VAL = int(7777);
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
    uint accum = 0u;
    vector<int, 5> v;
    int expected;
    [[dont_unroll]]
    for (int c = LOOP_LOW; c <= LOOP_HIGH; ++c) {
        bool inb = (c >= 0 && c < INBOUND);
        v = ssbo0_1.val[c];
        [[unroll]] for (int i = 0; i < N; ++i) {
            if (inb) {
                expected = refData[c * N + i];
            } else {
                expected = int(0);
            }
            if (v[i] != expected) accum += 1u;
        }
    }
    uvec4 color = (accum != 0u) ? uvec4(0, 0, 0, 1) : uvec4(1, 0, 0, 1);
    imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_long_vector : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) buffer SSBO_t { vector<int, 7> val[]; } ssbo0_1;
int refData[63] = int[](int(3), int(5), int(7), int(9), int(11), int(13), int(15), int(17), int(19), int(21), int(23), int(25), int(27), int(29), int(31), int(33), int(35), int(37), int(39), int(41), int(43), int(45), int(47), int(49), int(51), int(53), int(55), int(57), int(59), int(61), int(63), int(65), int(67), int(69), int(71), int(73), int(75), int(77), int(79), int(81), int(83), int(85), int(87), int(89), int(91), int(93), int(95), int(97), int(99), int(101), int(103), int(105), int(107), int(109), int(111), int(113), int(115), int(117), int(119), int(121), int(123), int(125), int(127));
const int N            = 7;
const int INBOUND      = 9;
const int LOOP_LOW     = -10;
const int LOOP_HIGH    = 19;
const int STORE_VAL = int(7777);
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
    uint accum = 0u;
    vector<int, 7> v;
    int expected;
    [[dont_unroll]]
    for (int c = LOOP_LOW; c <= LOOP_HIGH; ++c) {
        bool inb = (c >= 0 && c < INBOUND);
        v = ssbo0_1.val[c];
        [[unroll]] for (int i = 0; i < N; ++i) {
            if (inb) {
                expected = refData[c * N + i];
            } else {
                expected = int(0);
            }
            if (v[i] != expected) accum += 1u;
        }
    }
    [[dont_unroll]]
    for (int c = LOOP_LOW; c <= LOOP_HIGH; ++c) {
        bool oob = (c < 0 || c >= INBOUND);
        if (oob) {
            ssbo0_1.val[c] = vector<int, 7>(STORE_VAL);
        }
    }
    memoryBarrierBuffer();
    [[dont_unroll]]
    for (int c = LOOP_LOW; c <= LOOP_HIGH; ++c) {
        bool inb = (c >= 0 && c < INBOUND);
        v = ssbo0_1.val[c];
        [[unroll]] for (int i = 0; i < N; ++i) {
            if (inb) {
                expected = refData[c * N + i];
            } else {
                expected = int(0);
            }
            if (v[i] != expected) accum += 1u;
        }
    }
    uvec4 color = (accum != 0u) ? uvec4(0, 0, 0, 1) : uvec4(1, 0, 0, 1);
    imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_long_vector : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) buffer SSBO_t { vector<int, 7> val[]; } ssbo0_1;
int refData[7] = int[](int(3), int(5), int(7), int(9), int(11), int(13), int(15));
const int N            = 7;
const int INBOUND      = 1;
const int LOOP_LOW     = -10;
const int LOOP_HIGH    = 11;
const int STORE_VAL = int(7777);
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
    uint accum = 0u;
    vector<int, 7> v;
    int expected;
    [[unroll]]
    for (int c = LOOP_LOW; c <= LOOP_HIGH; ++c) {
        bool inb = (c >= 0 && c < INBOUND);
        v = ssbo0_1.val[c];
        [[unroll]] for (int i = 0; i < N; ++i) {
            if (inb) {
                expected = refData[c * N + i];
            } else {
                expected = int(0);
            }
            if (v[i] != expected) accum += 1u;
        }
    }
    [[unroll]]
    for (int c = LOOP_LOW; c <= LOOP_HIGH; ++c) {
        bool oob = (c < 0 || c >= INBOUND);
        if (oob) {
            ssbo0_1.val[c] = vector<int, 7>(STORE_VAL);
        }
    }
    memoryBarrierBuffer();
    [[unroll]]
    for (int c = LOOP_LOW; c <= LOOP_HIGH; ++c) {
        bool inb = (c >= 0 && c < INBOUND);
        v = ssbo0_1.val[c];
        [[unroll]] for (int i = 0; i < N; ++i) {
            if (inb) {
                expected = refData[c * N + i];
            } else {
                expected = int(0);
            }
            if (v[i] != expected) accum += 1u;
        }
    }
    uvec4 color = (accum != 0u) ? uvec4(0, 0, 0, 1) : uvec4(1, 0, 0, 1);
    imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_long_vector : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) uniform UBO_t { vector<uint, 13> val[78]; } ubo0_1;
uint refData[65] = uint[](uint(3), uint(5), uint(7), uint(9), uint(11), uint(13), uint(15), uint(17), uint(19), uint(21), uint(23), uint(25), uint(27), uint(29), uint(31), uint(33), uint(35), uint(37), uint(39), uint(41), uint(43), uint(45), uint(47), uint(49), uint(51), uint(53), uint(55), uint(57), uint(59), uint(61), uint(63), uint(65), uint(67), uint(69), uint(71), uint(73), uint(75), uint(77), uint(79), uint(81), uint(83), uint(85), uint(87), uint(89), uint(91), uint(93), uint(95), uint(97), uint(99), uint(101), uint(103), uint(105), uint(107), uint(109), uint(111), uint(113), uint(115), uint(117), uint(119), uint(121), uint(123), uint(125), uint(127), uint(129), uint(131));
const int N            = 13;
const int INBOUND      = 5;
const int LOOP_LOW     = -10;
const int LOOP_HIGH    = 15;
const uint STORE_VAL = uint(7777);
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
    uint accum = 0u;
    vector<uint, 13> v;
    uint expected;
    [[unroll]]
    for (int c = LOOP_LOW; c <= LOOP_HIGH; ++c) {
        bool inb = (c >= 0 && c < INBOUND);
        v = ubo0_1.val[c];
        [[unroll]] for (int i = 0; i < N; ++i) {
            if (inb) {
                expected = refData[c * N + i];
            } else {
                expected = uint(0);
            }
            if (v[i] != expected) accum += 1u;
        }
    }
    uvec4 color = (accum != 0u) ? uvec4(0, 0, 0, 1) : uvec4(1, 0, 0, 1);
    imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_long_vector : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_nonuniform_qualifier : enable
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) uniform UBO_t { vector<uint, 5> val[204]; } ubo0_1;
uint refData[5] = uint[](uint(3), uint(5), uint(7), uint(9), uint(11));
const int N            = 5;
const int INBOUND      = 1;
const int LOOP_LOW     = -10;
const int LOOP_HIGH    = 11;
const uint STORE_VAL = uint(7777);
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
    uint accum = 0u;
    vector<uint, 5> v;
    uint expected;
    [[dont_unroll]]
    for (int c = LOOP_LOW; c <= LOOP_HIGH; ++c) {
        bool inb = (c >= 0 && c < INBOUND);
        v = ubo0_1.val[c];
        [[unroll]] for (int i = 0; i < N; ++i) {
            if (inb) {
                expected = refData[c * N + i];
            } else {
                expected = uint(0);
            }
            if (v[i] != expected) accum += 1u;
        }
    }
    uvec4 color = (accum != 0u) ? uvec4(0, 0, 0, 1) : uvec4(1, 0, 0, 1);
    imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform samplerCubeArray texture0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec4((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5), 0.25));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec4((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5), 0.25), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec4((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5), 0.25), ivec3(1.0, 0, 0), ivec3(1.0, 0, 0));
    temp -= expectedIB2;
    accum += abs(temp);
    inboundcoords = 5;
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec4(0.25 / float(5), (c+0.25) / float(5), 0.25 / float(5), 0.25));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec4(0.25 / float(5), (c+0.25) / float(5), 0.25 / float(5), 0.25), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec4(0.25 / float(5), (c+0.25) / float(5), 0.25 / float(5), 0.25), ivec3(0, 1.0, 0), ivec3(0, 1.0, 0));
    temp -= expectedIB2;
    accum += abs(temp);
    inboundcoords = 6;
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec4(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6), 0.25));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec4(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6), 0.25), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec4(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6), 0.25), ivec3(0, 0, 1.0), ivec3(0, 0, 1.0));
    temp -= expectedIB2;
    accum += abs(temp);
    inboundcoords = 6;
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec4(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6), 0.25));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec4(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6), 0.25), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec4(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6), 0.25), ivec3(0, 0, 0), ivec3(0, 0, 0));
    temp -= expectedIB2;
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(r32f, set = 0, binding = 1) uniform image1D image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform image1D image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xxxx;
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform image1DArray image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(r32f, set = 0, binding = 1) volatile uniform image2DMS image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(c, 0), 0, vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, c), 0, vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, 0), c, vec4(123));
    temp = imageLoad(image0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (temp == zzzz) temp = vec4(0);
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) volatile uniform image2DArray image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform image2DMSArray image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), 0, vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), 0, vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), 0, vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec3(0, 0, 0), c, vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = vec4(0);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(r32f, set = 0, binding = 1) uniform image2DMSArray image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), 0, vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), 0, vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), 0, vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec3(0, 0, 0), c, vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = vec4(0);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(r32f, set = 0, binding = 1) volatile uniform image2DMSArray image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), 0, vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), 0, vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), 0, vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec3(0, 0, 0), c, vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = vec4(0);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(r32f, set = 0, binding = 1) volatile uniform image2DMSArray image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), 0, vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), 0, vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), 0, vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec3(0, 0, 0), c, vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = vec4(0);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(r32f, set = 0, binding = 1) uniform image3D image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform imageCube image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), vec4(123));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(r32f, set = 0, binding = 1) uniform imageCube image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), vec4(123));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(r32f, set = 0, binding = 1) uniform imageCubeArray image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), vec4(123));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[8] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { float val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; float val[]; } ssbo0_1_pad;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 5;
    temp = vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == vec4(float(123), 0, 0, 0)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[8] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1 { float val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1_pad { vec4 pad; float val[]; } ssbo0_1_pad;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 7;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = float(123);
    temp = vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == vec4(float(123), 0, 0, 0)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[12] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44, 2.66247e-44, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { float val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; float val[]; } ssbo0_1_pad;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 9;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = float(123);
    temp = vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) volatile uniform imageBuffer image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 3;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) volatile uniform imageBuffer image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 4;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[8] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform imageBuffer image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[68] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44, 2.66247e-44, 2.94273e-44, 3.22299e-44, 3.50325e-44, 3.78351e-44, 4.06377e-44, 4.34403e-44, 4.62428e-44, 4.90454e-44, 5.1848e-44, 5.46506e-44, 5.74532e-44, 6.02558e-44, 6.30584e-44, 6.5861e-44, 6.86636e-44, 7.14662e-44, 7.42688e-44, 7.70714e-44, 7.9874e-44, 8.26766e-44, 8.54792e-44, 8.82818e-44, 9.10844e-44, 9.3887e-44, 9.66896e-44, 9.94922e-44, 1.02295e-43, 1.05097e-43, 1.079e-43, 1.10703e-43, 1.13505e-43, 1.16308e-43, 1.1911e-43, 1.21913e-43, 1.24716e-43, 1.27518e-43, 1.30321e-43, 1.33123e-43, 1.35926e-43, 1.38729e-43, 1.41531e-43, 1.44334e-43, 1.47136e-43, 1.49939e-43, 1.52742e-43, 1.55544e-43, 1.58347e-43, 1.61149e-43, 1.63952e-43, 1.66755e-43, 1.69557e-43, 1.7236e-43, 1.75162e-43, 1.77965e-43, 1.80768e-43, 1.8357e-43, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(r32f, set = 0, binding = 1) volatile uniform imageBuffer image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 68);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 65;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[12] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44, 2.66247e-44, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(r32f, set = 0, binding = 1) volatile uniform imageBuffer image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 9;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {4.2039e-45, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(r32f, set = 0, binding = 1) volatile uniform imageBuffer image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 1;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(r32f, set = 0, binding = 1) uniform imageBuffer image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[64] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { float val[1024]; } ubo0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = 0; c <= 10; ++c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    int paddedinboundcoords = 64;
    inboundcoords = 4;
    temp = vec4(ubo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (c >= 0 && c < paddedinboundcoords && temp == expectedIB2) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[64] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { float val[1024]; } ubo0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = 0; c <= 10; ++c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    int paddedinboundcoords = 64;
    inboundcoords = 5;
    temp = vec4(ubo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (c >= 0 && c < paddedinboundcoords && temp == expectedIB2) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[128] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44, 2.66247e-44, 2.94273e-44, 3.22299e-44, 3.50325e-44, 3.78351e-44, 4.06377e-44, 4.34403e-44, 4.62428e-44, 4.90454e-44, 5.1848e-44, 5.46506e-44, 5.74532e-44, 6.02558e-44, 6.30584e-44, 6.5861e-44, 6.86636e-44, 7.14662e-44, 7.42688e-44, 7.70714e-44, 7.9874e-44, 8.26766e-44, 8.54792e-44, 8.82818e-44, 9.10844e-44, 9.3887e-44, 9.66896e-44, 9.94922e-44, 1.02295e-43, 1.05097e-43, 1.079e-43, 1.10703e-43, 1.13505e-43, 1.16308e-43, 1.1911e-43, 1.21913e-43, 1.24716e-43, 1.27518e-43, 1.30321e-43, 1.33123e-43, 1.35926e-43, 1.38729e-43, 1.41531e-43, 1.44334e-43, 1.47136e-43, 1.49939e-43, 1.52742e-43, 1.55544e-43, 1.58347e-43, 1.61149e-43, 1.63952e-43, 1.66755e-43, 1.69557e-43, 1.7236e-43, 1.75162e-43, 1.77965e-43, 1.80768e-43, 1.8357e-43, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { float val[1024]; } ubo0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1023; c >= 0; --c) {
    int idx = smod(c * 1, 128);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    int paddedinboundcoords = 128;
    inboundcoords = 65;
    temp = vec4(ubo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (c >= 0 && c < paddedinboundcoords && temp == expectedIB2) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform sampler1D texture0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    temp = texelFetch(texture0_1, c, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, 0, c); else temp = vec4(0);
    if (c != 0) temp -= zzzz;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, (c+0.25) / float(5));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureLod(texture0_1, (c+0.25) / float(5), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureGrad(texture0_1, (c+0.25) / float(5), 1.0, 1.0);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xxxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xxxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483647).xxxx;
    accum += abs(temp);
  }
  temp_ql = float(textureQueryLevels(texture0_1));
  temp = vec4(temp_ql);
  accum += abs(temp);
  vec2 lod = textureQueryLod(texture0_1, gl_FragCoord.x);
  temp_ql = float(ceil(abs(lod.x) + abs(lod.y)));
  temp = vec4(temp_ql);
  accum += abs(temp);
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 450 core
void main()
{
  gl_Position = vec4( 2.0*float(gl_VertexIndex&2) - 1.0, 4.0*(gl_VertexIndex&1)-1.0, 1.0 - 2.0 * float(gl_VertexIndex&1), 1);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform sampler2D texture0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    temp = texelFetch(texture0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec2(0, 0), c); else temp = vec4(0);
    if (c != 0) temp -= zzzz;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec2((c+0.25) / float(5), 0.25 / float(5)));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec2((c+0.25) / float(5), 0.25 / float(5)), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec2((c+0.25) / float(5), 0.25 / float(5)), ivec2(1.0, 0), ivec2(1.0, 0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483647).xyxx;
    accum += abs(temp);
    temp = texelFetch(texture0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec2(0, 0), c); else temp = vec4(0);
    if (c != 0) temp -= zzzz;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec2(0.25 / float(11), (c+0.25) / float(11)));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec2(0.25 / float(11), (c+0.25) / float(11)), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec2(0.25 / float(11), (c+0.25) / float(11)), ivec2(0, 1.0), ivec2(0, 1.0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, -1).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483646).xyxx;
    accum += abs(temp);
  }
  temp_ql = float(textureQueryLevels(texture0_1));
  temp = vec4(temp_ql);
  accum += abs(temp);
  vec2 lod = textureQueryLod(texture0_1, gl_FragCoord.xy);
  temp_ql = float(ceil(abs(lod.x) + abs(lod.y)));
  temp = vec4(temp_ql);
  accum += abs(temp);
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform sampler2DMS texture0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    temp = texelFetch(texture0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = texelFetch(texture0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = texelFetch(texture0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = vec4(0);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform sampler2DMSArray texture0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    temp = texelFetch(texture0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = textureSize(texture0_1).xyzx;
    accum += abs(temp);
    temp = textureSamples(texture0_1).xxxx;
    accum += abs(temp);
    temp = texelFetch(texture0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = textureSize(texture0_1).xyzx;
    accum += abs(temp);
    temp = textureSamples(texture0_1).xxxx;
    accum += abs(temp);
    temp = texelFetch(texture0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = textureSize(texture0_1).xyzx;
    accum += abs(temp);
    temp = textureSamples(texture0_1).xxxx;
    accum += abs(temp);
    temp = texelFetch(texture0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = vec4(0);
    accum += abs(temp);
    temp = textureSize(texture0_1).xyzx;
    accum += abs(temp);
    temp = textureSamples(texture0_1).xxxx;
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(r32f, set = 0, binding = 1) volatile uniform image1D image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xxxx;
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(r32f, set = 0, binding = 1) uniform image1DArray image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(c, 0), vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, c), vec4(123));
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(r32f, set = 0, binding = 1) uniform image2D image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform image2DMS image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), 0, vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), 0, vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec2(0, 0), c, vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = vec4(0);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(r32f, set = 0, binding = 1) uniform image2DMS image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), 0, vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), 0, vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec2(0, 0), c, vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = vec4(0);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(r32f, set = 0, binding = 1) uniform image2DMS image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), 0, vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), 0, vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec2(0, 0), c, vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = vec4(0);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) volatile uniform image2DMS image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(c, 0), 0, vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, c), 0, vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, 0), c, vec4(123));
    temp = imageLoad(image0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(r32f, set = 0, binding = 1) uniform image2DArray image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(r32f, set = 0, binding = 1) volatile uniform image2DArray image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) volatile uniform image2DMSArray image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), 0, vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), 0, vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), 0, vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec3(0, 0, 0), c, vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = vec4(0);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) volatile uniform image2DMSArray image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), 0, vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), 0, vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), 0, vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, 0), c, vec4(123));
    temp = imageLoad(image0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(r32f, set = 0, binding = 1) volatile uniform image3D image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), vec4(123));
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) volatile uniform imageCube image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), vec4(123));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(r32f, set = 0, binding = 1) volatile uniform imageCube image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), vec4(123));
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(r32f, set = 0, binding = 1) volatile uniform imageCubeArray image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), vec4(123));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1 { float val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1_pad { vec4 pad; float val[]; } ssbo0_1_pad;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 3;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = float(123);
    temp = vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == vec4(float(123), 0, 0, 0)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[8] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { float val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; float val[]; } ssbo0_1_pad;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = float(123);
    temp = vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[8] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { float val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; float val[]; } ssbo0_1_pad;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 5;
    temp = vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[68] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44, 2.66247e-44, 2.94273e-44, 3.22299e-44, 3.50325e-44, 3.78351e-44, 4.06377e-44, 4.34403e-44, 4.62428e-44, 4.90454e-44, 5.1848e-44, 5.46506e-44, 5.74532e-44, 6.02558e-44, 6.30584e-44, 6.5861e-44, 6.86636e-44, 7.14662e-44, 7.42688e-44, 7.70714e-44, 7.9874e-44, 8.26766e-44, 8.54792e-44, 8.82818e-44, 9.10844e-44, 9.3887e-44, 9.66896e-44, 9.94922e-44, 1.02295e-43, 1.05097e-43, 1.079e-43, 1.10703e-43, 1.13505e-43, 1.16308e-43, 1.1911e-43, 1.21913e-43, 1.24716e-43, 1.27518e-43, 1.30321e-43, 1.33123e-43, 1.35926e-43, 1.38729e-43, 1.41531e-43, 1.44334e-43, 1.47136e-43, 1.49939e-43, 1.52742e-43, 1.55544e-43, 1.58347e-43, 1.61149e-43, 1.63952e-43, 1.66755e-43, 1.69557e-43, 1.7236e-43, 1.75162e-43, 1.77965e-43, 1.80768e-43, 1.8357e-43, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { float val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; float val[]; } ssbo0_1_pad;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 68);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 65;
    temp = vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == vec4(float(123), 0, 0, 0)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[12] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44, 2.66247e-44, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1 { float val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1_pad { vec4 pad; float val[]; } ssbo0_1_pad;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 9;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = float(123);
    temp = vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == vec4(float(123), 0, 0, 0)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[12] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44, 2.66247e-44, 2.94273e-44, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { float val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; float val[]; } ssbo0_1_pad;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 10;
    temp = vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1 { float val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1_pad { vec4 pad; float val[]; } ssbo0_1_pad;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) ssbo0_1.val[c] = float(123);
    temp = vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == vec4(float(123), 0, 0, 0)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = vec4(ssbo0_1.val.length());
    accum += abs(temp);
    temp = vec4(ssbo0_1_pad.val.length());
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[64] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44, 2.66247e-44, 2.94273e-44, 3.22299e-44, 3.50325e-44, 3.78351e-44, 4.06377e-44, 4.34403e-44, 4.62428e-44, 4.90454e-44, 5.1848e-44, 5.46506e-44, 5.74532e-44, 6.02558e-44, 6.30584e-44, 6.5861e-44, 6.86636e-44, 7.14662e-44, 7.42688e-44, 7.70714e-44, 7.9874e-44, 8.26766e-44, 8.54792e-44, 8.82818e-44, 9.10844e-44, 9.3887e-44, 9.66896e-44, 9.94922e-44, 1.02295e-43, 1.05097e-43, 1.079e-43, 1.10703e-43, 1.13505e-43, 1.16308e-43, 1.1911e-43, 1.21913e-43, 1.24716e-43, 1.27518e-43, 1.30321e-43, 1.33123e-43, 1.35926e-43, 1.38729e-43, 1.41531e-43, 1.44334e-43, 1.47136e-43, 1.49939e-43, 1.52742e-43, 1.55544e-43, 1.58347e-43, 1.61149e-43, 1.63952e-43, 1.66755e-43, 1.69557e-43, 1.7236e-43, 1.75162e-43, 1.77965e-43, 1.80768e-43};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform imageBuffer image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 64;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[8] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(r32f, set = 0, binding = 1) uniform imageBuffer image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 8;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[12] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44, 2.66247e-44, 2.94273e-44, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) volatile uniform imageBuffer image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 10;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[12] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44, 2.66247e-44, 2.94273e-44, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(r32f, set = 0, binding = 1) volatile uniform imageBuffer image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 10;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {4.2039e-45, 7.00649e-45, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform imageBuffer image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 2;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {4.2039e-45, 7.00649e-45, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(r32f, set = 0, binding = 1) uniform imageBuffer image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 2;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform imageBuffer image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[64] = {4.2039e-45, 7.00649e-45, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { float val[1024]; } ubo0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1023; c >= 0; --c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    int paddedinboundcoords = 64;
    inboundcoords = 2;
    temp = vec4(ubo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (c >= 0 && c < paddedinboundcoords && temp == expectedIB2) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[64] = {4.2039e-45, 7.00649e-45, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { float val[1024]; } ubo0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = 0; c <= 10; ++c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    int paddedinboundcoords = 64;
    inboundcoords = 2;
    temp = vec4(ubo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (c >= 0 && c < paddedinboundcoords && temp == expectedIB2) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform textureBuffer texbo0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 3;
    temp = texelFetch(texbo0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {4.2039e-45, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform textureBuffer texbo0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 1;
    temp = texelFetch(texbo0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform sampler1D texture0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    temp = texelFetch(texture0_1, c, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, 0, c); else temp = vec4(0);
    if (c != 0) temp -= zzzz;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, (c+0.25) / float(5));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureLod(texture0_1, (c+0.25) / float(5), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureGrad(texture0_1, (c+0.25) / float(5), 1.0, 1.0);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xxxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xxxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483647).xxxx;
    accum += abs(temp);
  }
  temp_ql = float(textureQueryLevels(texture0_1));
  temp = vec4(temp_ql);
  accum += abs(temp);
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform sampler1DArray texture0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    temp = texelFetch(texture0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec2(0, 0), c); else temp = vec4(0);
    if (c != 0) temp -= zzzo;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec2((c+0.25) / float(5), 0.25));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec2((c+0.25) / float(5), 0.25), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec2((c+0.25) / float(5), 0.25), 1.0, 1.0);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    inboundcoords = 11;
    temp = texelFetch(texture0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec2(0, 0), c); else temp = vec4(0);
    if (c != 0) temp -= zzzo;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    clampedLayer = clamp(c, 0, 10);
    expectedIB2 += vec4(clampedLayer, 0, 0, 0);
    temp = texture(texture0_1, vec2(0.25 / float(11), (c+0.25)));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec2(0.25 / float(11), (c+0.25)), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec2(0.25 / float(11), (c+0.25)), 1.0, 1.0);
    temp -= expectedIB2;
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform sampler1DArray texture0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    temp = texelFetch(texture0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec2(0, 0), c); else temp = vec4(0);
    if (c != 0) temp -= zzzz;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec2((c+0.25) / float(5), 0.25));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec2((c+0.25) / float(5), 0.25), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec2((c+0.25) / float(5), 0.25), 1.0, 1.0);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483647).xyxx;
    accum += abs(temp);
    temp = texelFetch(texture0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec2(0, 0), c); else temp = vec4(0);
    if (c != 0) temp -= zzzz;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec2(0.25 / float(11), (c+0.25)));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec2(0.25 / float(11), (c+0.25)), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec2(0.25 / float(11), (c+0.25)), 1.0, 1.0);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, -1).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483646).xyxx;
    accum += abs(temp);
  }
  temp_ql = float(textureQueryLevels(texture0_1));
  temp = vec4(temp_ql);
  accum += abs(temp);
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform sampler2D texture0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    temp = texelFetch(texture0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec2(0, 0), c); else temp = vec4(0);
    if (c != 0) temp -= zzzo;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec2((c+0.25) / float(5), 0.25 / float(5)));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec2((c+0.25) / float(5), 0.25 / float(5)), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec2((c+0.25) / float(5), 0.25 / float(5)), ivec2(1.0, 0), ivec2(1.0, 0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    inboundcoords = 11;
    temp = texelFetch(texture0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec2(0, 0), c); else temp = vec4(0);
    if (c != 0) temp -= zzzo;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec2(0.25 / float(11), (c+0.25) / float(11)));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec2(0.25 / float(11), (c+0.25) / float(11)), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec2(0.25 / float(11), (c+0.25) / float(11)), ivec2(0, 1.0), ivec2(0, 1.0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform sampler2DMS texture0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    temp = texelFetch(texture0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = texelFetch(texture0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = texelFetch(texture0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = vec4(0);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform sampler2DArray texture0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    temp = texelFetch(texture0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec3(0, 0, 0), c); else temp = vec4(0);
    if (c != 0) temp -= zzzo;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25), ivec2(1.0, 0), ivec2(1.0, 0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    inboundcoords = 11;
    temp = texelFetch(texture0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec3(0, 0, 0), c); else temp = vec4(0);
    if (c != 0) temp -= zzzo;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25), ivec2(0, 1.0), ivec2(0, 1.0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    inboundcoords = 6;
    temp = texelFetch(texture0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec3(0, 0, 0), c); else temp = vec4(0);
    if (c != 0) temp -= zzzo;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    clampedLayer = clamp(c, 0, 5);
    expectedIB2 += vec4(clampedLayer, 0, 0, 0);
    temp = texture(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25)));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25)), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25)), ivec2(0, 0), ivec2(0, 0));
    temp -= expectedIB2;
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform sampler2DMSArray texture0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    temp = texelFetch(texture0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = texelFetch(texture0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = texelFetch(texture0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = texelFetch(texture0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = vec4(0);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(r32f, set = 0, binding = 1) volatile uniform image1D image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(r32f, set = 0, binding = 1) uniform image2D image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(c, 0), vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, c), vec4(123));
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(r32f, set = 0, binding = 1) volatile uniform image2D image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(c, 0), vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, c), vec4(123));
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(r32f, set = 0, binding = 1) volatile uniform image2D image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(c, 0), vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, c), vec4(123));
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(r32f, set = 0, binding = 1) uniform image2DMS image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(c, 0), 0, vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, c), 0, vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, 0), c, vec4(123));
    temp = imageLoad(image0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (temp == zzzz) temp = vec4(0);
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform image2DMSArray image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), 0, vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), 0, vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), 0, vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec3(0, 0, 0), c, vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = vec4(0);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(r32f, set = 0, binding = 1) uniform image2DMSArray image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), 0, vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), 0, vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), 0, vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec3(0, 0, 0), c, vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = vec4(0);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform image2DMSArray image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), 0, vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), 0, vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), 0, vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, 0), c, vec4(123));
    temp = imageLoad(image0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) volatile uniform image3D image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), vec4(123));
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform imageCube image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), vec4(123));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform imageCube image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), vec4(123));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(r32f, set = 0, binding = 1) uniform imageCube image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), vec4(123));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) volatile uniform imageCubeArray image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), vec4(123));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1 { float val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1_pad { vec4 pad; float val[]; } ssbo0_1_pad;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 4;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = float(123);
    temp = vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == vec4(float(123), 0, 0, 0)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { float val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; float val[]; } ssbo0_1_pad;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 4;
    temp = vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == vec4(float(123), 0, 0, 0)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { float val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; float val[]; } ssbo0_1_pad;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 4;
    temp = vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[8] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { float val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; float val[]; } ssbo0_1_pad;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 8;
    temp = vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[12] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44, 2.66247e-44, 2.94273e-44, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1 { float val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1_pad { vec4 pad; float val[]; } ssbo0_1_pad;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 10;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = float(123);
    temp = vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == vec4(float(123), 0, 0, 0)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { float val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; float val[]; } ssbo0_1_pad;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    temp = vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = vec4(ssbo0_1.val.length());
    accum += abs(temp);
    temp = vec4(ssbo0_1_pad.val.length());
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) volatile uniform imageBuffer image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 3;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[8] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) volatile uniform imageBuffer image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[68] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44, 2.66247e-44, 2.94273e-44, 3.22299e-44, 3.50325e-44, 3.78351e-44, 4.06377e-44, 4.34403e-44, 4.62428e-44, 4.90454e-44, 5.1848e-44, 5.46506e-44, 5.74532e-44, 6.02558e-44, 6.30584e-44, 6.5861e-44, 6.86636e-44, 7.14662e-44, 7.42688e-44, 7.70714e-44, 7.9874e-44, 8.26766e-44, 8.54792e-44, 8.82818e-44, 9.10844e-44, 9.3887e-44, 9.66896e-44, 9.94922e-44, 1.02295e-43, 1.05097e-43, 1.079e-43, 1.10703e-43, 1.13505e-43, 1.16308e-43, 1.1911e-43, 1.21913e-43, 1.24716e-43, 1.27518e-43, 1.30321e-43, 1.33123e-43, 1.35926e-43, 1.38729e-43, 1.41531e-43, 1.44334e-43, 1.47136e-43, 1.49939e-43, 1.52742e-43, 1.55544e-43, 1.58347e-43, 1.61149e-43, 1.63952e-43, 1.66755e-43, 1.69557e-43, 1.7236e-43, 1.75162e-43, 1.77965e-43, 1.80768e-43, 1.8357e-43, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(r32f, set = 0, binding = 1) volatile uniform imageBuffer image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 68);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 65;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[8] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) volatile uniform imageBuffer image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 8;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {4.2039e-45, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(r32f, set = 0, binding = 1) volatile uniform imageBuffer image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 1;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[64] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44, 2.66247e-44, 2.94273e-44, 3.22299e-44, 3.50325e-44, 3.78351e-44, 4.06377e-44, 4.34403e-44, 4.62428e-44, 4.90454e-44, 5.1848e-44, 5.46506e-44, 5.74532e-44, 6.02558e-44, 6.30584e-44, 6.5861e-44, 6.86636e-44, 7.14662e-44, 7.42688e-44, 7.70714e-44, 7.9874e-44, 8.26766e-44, 8.54792e-44, 8.82818e-44, 9.10844e-44, 9.3887e-44, 9.66896e-44, 9.94922e-44, 1.02295e-43, 1.05097e-43, 1.079e-43, 1.10703e-43, 1.13505e-43, 1.16308e-43, 1.1911e-43, 1.21913e-43, 1.24716e-43, 1.27518e-43, 1.30321e-43, 1.33123e-43, 1.35926e-43, 1.38729e-43, 1.41531e-43, 1.44334e-43, 1.47136e-43, 1.49939e-43, 1.52742e-43, 1.55544e-43, 1.58347e-43, 1.61149e-43, 1.63952e-43, 1.66755e-43, 1.69557e-43, 1.7236e-43, 1.75162e-43, 1.77965e-43, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { float val[1024]; } ubo0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = 0; c <= 10; ++c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    int paddedinboundcoords = 64;
    inboundcoords = 63;
    temp = vec4(ubo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (c >= 0 && c < paddedinboundcoords && temp == expectedIB2) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[64] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44, 2.66247e-44, 2.94273e-44, 3.22299e-44, 3.50325e-44, 3.78351e-44, 4.06377e-44, 4.34403e-44, 4.62428e-44, 4.90454e-44, 5.1848e-44, 5.46506e-44, 5.74532e-44, 6.02558e-44, 6.30584e-44, 6.5861e-44, 6.86636e-44, 7.14662e-44, 7.42688e-44, 7.70714e-44, 7.9874e-44, 8.26766e-44, 8.54792e-44, 8.82818e-44, 9.10844e-44, 9.3887e-44, 9.66896e-44, 9.94922e-44, 1.02295e-43, 1.05097e-43, 1.079e-43, 1.10703e-43, 1.13505e-43, 1.16308e-43, 1.1911e-43, 1.21913e-43, 1.24716e-43, 1.27518e-43, 1.30321e-43, 1.33123e-43, 1.35926e-43, 1.38729e-43, 1.41531e-43, 1.44334e-43, 1.47136e-43, 1.49939e-43, 1.52742e-43, 1.55544e-43, 1.58347e-43, 1.61149e-43, 1.63952e-43, 1.66755e-43, 1.69557e-43, 1.7236e-43, 1.75162e-43, 1.77965e-43, 1.80768e-43};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { float val[1024]; } ubo0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = 0; c <= 10; ++c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    int paddedinboundcoords = 64;
    inboundcoords = 64;
    temp = vec4(ubo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (c >= 0 && c < paddedinboundcoords && temp == expectedIB2) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[8] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform textureBuffer texbo0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    temp = texelFetch(texbo0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform sampler1DArray texture0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    temp = texelFetch(texture0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec2(0, 0), c); else temp = vec4(0);
    if (c != 0) temp -= zzzo;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec2((c+0.25) / float(5), 0.25));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec2((c+0.25) / float(5), 0.25), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec2((c+0.25) / float(5), 0.25), 1.0, 1.0);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    inboundcoords = 11;
    temp = texelFetch(texture0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec2(0, 0), c); else temp = vec4(0);
    if (c != 0) temp -= zzzo;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    clampedLayer = clamp(c, 0, 10);
    expectedIB2 += vec4(clampedLayer, 0, 0, 0);
    temp = texture(texture0_1, vec2(0.25 / float(11), (c+0.25)));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec2(0.25 / float(11), (c+0.25)), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec2(0.25 / float(11), (c+0.25)), 1.0, 1.0);
    temp -= expectedIB2;
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform sampler2DMS texture0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    temp = texelFetch(texture0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = texelFetch(texture0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = texelFetch(texture0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = vec4(0);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform sampler2DArray texture0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    temp = texelFetch(texture0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = vec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = vec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25), ivec2(1.0, 0), ivec2(1.0, 0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = vec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = texelFetch(texture0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = vec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = vec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25), ivec2(0, 1.0), ivec2(0, 1.0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = vec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = texelFetch(texture0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    expectedIB2 = expectedIB;
    clampedLayer = clamp(c, 0, 5);
    expectedIB2 += vec4(clampedLayer, 0, 0, 0);
    temp = texture(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25)));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25)), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25)), ivec2(0, 0), ivec2(0, 0));
    temp -= expectedIB2;
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(r32f, set = 0, binding = 1) uniform image1D image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(r32f, set = 0, binding = 1) volatile uniform image1D image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform image1D image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xxxx;
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(r32f, set = 0, binding = 1) uniform image1DArray image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform image1DArray image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(c, 0), vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, c), vec4(123));
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) volatile uniform image2D image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(c, 0), vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, c), vec4(123));
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) volatile uniform image2DMS image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), 0, vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), 0, vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec2(0, 0), c, vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = vec4(0);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform image2DMS image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), 0, vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), 0, vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec2(0, 0), c, vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = vec4(0);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) volatile uniform image2DMSArray image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), 0, vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), 0, vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), 0, vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec3(0, 0, 0), c, vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = vec4(0);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(r32f, set = 0, binding = 1) uniform image2DMSArray image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), 0, vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), 0, vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), 0, vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec3(0, 0, 0), c, vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = vec4(0);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(r32f, set = 0, binding = 1) volatile uniform image2DMSArray image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), 0, vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), 0, vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), 0, vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, 0), c, vec4(123));
    temp = imageLoad(image0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (temp == zzzz) temp = vec4(0);
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform image3D image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), vec4(123));
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) volatile uniform imageCube image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), vec4(123));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1 { float val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1_pad { vec4 pad; float val[]; } ssbo0_1_pad;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 3;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = float(123);
    temp = vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == vec4(float(123), 0, 0, 0)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { float val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; float val[]; } ssbo0_1_pad;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 4;
    temp = vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { float val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; float val[]; } ssbo0_1_pad;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 4;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = float(123);
    temp = vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[64] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44, 2.66247e-44, 2.94273e-44, 3.22299e-44, 3.50325e-44, 3.78351e-44, 4.06377e-44, 4.34403e-44, 4.62428e-44, 4.90454e-44, 5.1848e-44, 5.46506e-44, 5.74532e-44, 6.02558e-44, 6.30584e-44, 6.5861e-44, 6.86636e-44, 7.14662e-44, 7.42688e-44, 7.70714e-44, 7.9874e-44, 8.26766e-44, 8.54792e-44, 8.82818e-44, 9.10844e-44, 9.3887e-44, 9.66896e-44, 9.94922e-44, 1.02295e-43, 1.05097e-43, 1.079e-43, 1.10703e-43, 1.13505e-43, 1.16308e-43, 1.1911e-43, 1.21913e-43, 1.24716e-43, 1.27518e-43, 1.30321e-43, 1.33123e-43, 1.35926e-43, 1.38729e-43, 1.41531e-43, 1.44334e-43, 1.47136e-43, 1.49939e-43, 1.52742e-43, 1.55544e-43, 1.58347e-43, 1.61149e-43, 1.63952e-43, 1.66755e-43, 1.69557e-43, 1.7236e-43, 1.75162e-43, 1.77965e-43, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { float val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; float val[]; } ssbo0_1_pad;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 63;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = float(123);
    temp = vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[64] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44, 2.66247e-44, 2.94273e-44, 3.22299e-44, 3.50325e-44, 3.78351e-44, 4.06377e-44, 4.34403e-44, 4.62428e-44, 4.90454e-44, 5.1848e-44, 5.46506e-44, 5.74532e-44, 6.02558e-44, 6.30584e-44, 6.5861e-44, 6.86636e-44, 7.14662e-44, 7.42688e-44, 7.70714e-44, 7.9874e-44, 8.26766e-44, 8.54792e-44, 8.82818e-44, 9.10844e-44, 9.3887e-44, 9.66896e-44, 9.94922e-44, 1.02295e-43, 1.05097e-43, 1.079e-43, 1.10703e-43, 1.13505e-43, 1.16308e-43, 1.1911e-43, 1.21913e-43, 1.24716e-43, 1.27518e-43, 1.30321e-43, 1.33123e-43, 1.35926e-43, 1.38729e-43, 1.41531e-43, 1.44334e-43, 1.47136e-43, 1.49939e-43, 1.52742e-43, 1.55544e-43, 1.58347e-43, 1.61149e-43, 1.63952e-43, 1.66755e-43, 1.69557e-43, 1.7236e-43, 1.75162e-43, 1.77965e-43, 1.80768e-43};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { float val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; float val[]; } ssbo0_1_pad;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 64;
    temp = vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {4.2039e-45, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { float val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; float val[]; } ssbo0_1_pad;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 1;
    temp = vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == vec4(float(123), 0, 0, 0)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {4.2039e-45, 7.00649e-45, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { float val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; float val[]; } ssbo0_1_pad;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 2;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = float(123);
    temp = vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(r32f, set = 0, binding = 1) volatile uniform imageBuffer image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 3;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(r32f, set = 0, binding = 1) uniform imageBuffer image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 4;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[64] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44, 2.66247e-44, 2.94273e-44, 3.22299e-44, 3.50325e-44, 3.78351e-44, 4.06377e-44, 4.34403e-44, 4.62428e-44, 4.90454e-44, 5.1848e-44, 5.46506e-44, 5.74532e-44, 6.02558e-44, 6.30584e-44, 6.5861e-44, 6.86636e-44, 7.14662e-44, 7.42688e-44, 7.70714e-44, 7.9874e-44, 8.26766e-44, 8.54792e-44, 8.82818e-44, 9.10844e-44, 9.3887e-44, 9.66896e-44, 9.94922e-44, 1.02295e-43, 1.05097e-43, 1.079e-43, 1.10703e-43, 1.13505e-43, 1.16308e-43, 1.1911e-43, 1.21913e-43, 1.24716e-43, 1.27518e-43, 1.30321e-43, 1.33123e-43, 1.35926e-43, 1.38729e-43, 1.41531e-43, 1.44334e-43, 1.47136e-43, 1.49939e-43, 1.52742e-43, 1.55544e-43, 1.58347e-43, 1.61149e-43, 1.63952e-43, 1.66755e-43, 1.69557e-43, 1.7236e-43, 1.75162e-43, 1.77965e-43, 1.80768e-43};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(r32f, set = 0, binding = 1) uniform imageBuffer image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 64;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[64] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44, 2.66247e-44, 2.94273e-44, 3.22299e-44, 3.50325e-44, 3.78351e-44, 4.06377e-44, 4.34403e-44, 4.62428e-44, 4.90454e-44, 5.1848e-44, 5.46506e-44, 5.74532e-44, 6.02558e-44, 6.30584e-44, 6.5861e-44, 6.86636e-44, 7.14662e-44, 7.42688e-44, 7.70714e-44, 7.9874e-44, 8.26766e-44, 8.54792e-44, 8.82818e-44, 9.10844e-44, 9.3887e-44, 9.66896e-44, 9.94922e-44, 1.02295e-43, 1.05097e-43, 1.079e-43, 1.10703e-43, 1.13505e-43, 1.16308e-43, 1.1911e-43, 1.21913e-43, 1.24716e-43, 1.27518e-43, 1.30321e-43, 1.33123e-43, 1.35926e-43, 1.38729e-43, 1.41531e-43, 1.44334e-43, 1.47136e-43, 1.49939e-43, 1.52742e-43, 1.55544e-43, 1.58347e-43, 1.61149e-43, 1.63952e-43, 1.66755e-43, 1.69557e-43, 1.7236e-43, 1.75162e-43, 1.77965e-43, 1.80768e-43};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(r32f, set = 0, binding = 1) volatile uniform imageBuffer image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 64;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[64] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44, 2.66247e-44, 2.94273e-44, 3.22299e-44, 3.50325e-44, 3.78351e-44, 4.06377e-44, 4.34403e-44, 4.62428e-44, 4.90454e-44, 5.1848e-44, 5.46506e-44, 5.74532e-44, 6.02558e-44, 6.30584e-44, 6.5861e-44, 6.86636e-44, 7.14662e-44, 7.42688e-44, 7.70714e-44, 7.9874e-44, 8.26766e-44, 8.54792e-44, 8.82818e-44, 9.10844e-44, 9.3887e-44, 9.66896e-44, 9.94922e-44, 1.02295e-43, 1.05097e-43, 1.079e-43, 1.10703e-43, 1.13505e-43, 1.16308e-43, 1.1911e-43, 1.21913e-43, 1.24716e-43, 1.27518e-43, 1.30321e-43, 1.33123e-43, 1.35926e-43, 1.38729e-43, 1.41531e-43, 1.44334e-43, 1.47136e-43, 1.49939e-43, 1.52742e-43, 1.55544e-43, 1.58347e-43, 1.61149e-43, 1.63952e-43, 1.66755e-43, 1.69557e-43, 1.7236e-43, 1.75162e-43, 1.77965e-43, 1.80768e-43};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform imageBuffer image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 64;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[64] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44, 2.66247e-44, 2.94273e-44, 3.22299e-44, 3.50325e-44, 3.78351e-44, 4.06377e-44, 4.34403e-44, 4.62428e-44, 4.90454e-44, 5.1848e-44, 5.46506e-44, 5.74532e-44, 6.02558e-44, 6.30584e-44, 6.5861e-44, 6.86636e-44, 7.14662e-44, 7.42688e-44, 7.70714e-44, 7.9874e-44, 8.26766e-44, 8.54792e-44, 8.82818e-44, 9.10844e-44, 9.3887e-44, 9.66896e-44, 9.94922e-44, 1.02295e-43, 1.05097e-43, 1.079e-43, 1.10703e-43, 1.13505e-43, 1.16308e-43, 1.1911e-43, 1.21913e-43, 1.24716e-43, 1.27518e-43, 1.30321e-43, 1.33123e-43, 1.35926e-43, 1.38729e-43, 1.41531e-43, 1.44334e-43, 1.47136e-43, 1.49939e-43, 1.52742e-43, 1.55544e-43, 1.58347e-43, 1.61149e-43, 1.63952e-43, 1.66755e-43, 1.69557e-43, 1.7236e-43, 1.75162e-43, 1.77965e-43, 1.80768e-43};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(r32f, set = 0, binding = 1) uniform imageBuffer image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 64;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[68] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44, 2.66247e-44, 2.94273e-44, 3.22299e-44, 3.50325e-44, 3.78351e-44, 4.06377e-44, 4.34403e-44, 4.62428e-44, 4.90454e-44, 5.1848e-44, 5.46506e-44, 5.74532e-44, 6.02558e-44, 6.30584e-44, 6.5861e-44, 6.86636e-44, 7.14662e-44, 7.42688e-44, 7.70714e-44, 7.9874e-44, 8.26766e-44, 8.54792e-44, 8.82818e-44, 9.10844e-44, 9.3887e-44, 9.66896e-44, 9.94922e-44, 1.02295e-43, 1.05097e-43, 1.079e-43, 1.10703e-43, 1.13505e-43, 1.16308e-43, 1.1911e-43, 1.21913e-43, 1.24716e-43, 1.27518e-43, 1.30321e-43, 1.33123e-43, 1.35926e-43, 1.38729e-43, 1.41531e-43, 1.44334e-43, 1.47136e-43, 1.49939e-43, 1.52742e-43, 1.55544e-43, 1.58347e-43, 1.61149e-43, 1.63952e-43, 1.66755e-43, 1.69557e-43, 1.7236e-43, 1.75162e-43, 1.77965e-43, 1.80768e-43, 1.8357e-43, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(r32f, set = 0, binding = 1) uniform imageBuffer image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 68);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 65;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[8] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(r32f, set = 0, binding = 1) uniform imageBuffer image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 8;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[64] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { float val[1024]; } ubo0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1023; c >= 0; --c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    int paddedinboundcoords = 64;
    inboundcoords = 4;
    temp = vec4(ubo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (c >= 0 && c < paddedinboundcoords && temp == expectedIB2) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[64] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44, 2.66247e-44, 2.94273e-44, 3.22299e-44, 3.50325e-44, 3.78351e-44, 4.06377e-44, 4.34403e-44, 4.62428e-44, 4.90454e-44, 5.1848e-44, 5.46506e-44, 5.74532e-44, 6.02558e-44, 6.30584e-44, 6.5861e-44, 6.86636e-44, 7.14662e-44, 7.42688e-44, 7.70714e-44, 7.9874e-44, 8.26766e-44, 8.54792e-44, 8.82818e-44, 9.10844e-44, 9.3887e-44, 9.66896e-44, 9.94922e-44, 1.02295e-43, 1.05097e-43, 1.079e-43, 1.10703e-43, 1.13505e-43, 1.16308e-43, 1.1911e-43, 1.21913e-43, 1.24716e-43, 1.27518e-43, 1.30321e-43, 1.33123e-43, 1.35926e-43, 1.38729e-43, 1.41531e-43, 1.44334e-43, 1.47136e-43, 1.49939e-43, 1.52742e-43, 1.55544e-43, 1.58347e-43, 1.61149e-43, 1.63952e-43, 1.66755e-43, 1.69557e-43, 1.7236e-43, 1.75162e-43, 1.77965e-43, 1.80768e-43};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { float val[1024]; } ubo0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1023; c >= 0; --c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    int paddedinboundcoords = 64;
    inboundcoords = 64;
    temp = vec4(ubo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (c >= 0 && c < paddedinboundcoords && temp == expectedIB2) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[128] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44, 2.66247e-44, 2.94273e-44, 3.22299e-44, 3.50325e-44, 3.78351e-44, 4.06377e-44, 4.34403e-44, 4.62428e-44, 4.90454e-44, 5.1848e-44, 5.46506e-44, 5.74532e-44, 6.02558e-44, 6.30584e-44, 6.5861e-44, 6.86636e-44, 7.14662e-44, 7.42688e-44, 7.70714e-44, 7.9874e-44, 8.26766e-44, 8.54792e-44, 8.82818e-44, 9.10844e-44, 9.3887e-44, 9.66896e-44, 9.94922e-44, 1.02295e-43, 1.05097e-43, 1.079e-43, 1.10703e-43, 1.13505e-43, 1.16308e-43, 1.1911e-43, 1.21913e-43, 1.24716e-43, 1.27518e-43, 1.30321e-43, 1.33123e-43, 1.35926e-43, 1.38729e-43, 1.41531e-43, 1.44334e-43, 1.47136e-43, 1.49939e-43, 1.52742e-43, 1.55544e-43, 1.58347e-43, 1.61149e-43, 1.63952e-43, 1.66755e-43, 1.69557e-43, 1.7236e-43, 1.75162e-43, 1.77965e-43, 1.80768e-43, 1.8357e-43, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { float val[1024]; } ubo0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1023; c >= 0; --c) {
    int idx = smod(c * 1, 128);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    int paddedinboundcoords = 128;
    inboundcoords = 65;
    temp = vec4(ubo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (c >= 0 && c < paddedinboundcoords && temp == expectedIB2) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[64] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44, 2.66247e-44, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { float val[1024]; } ubo0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1023; c >= 0; --c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    int paddedinboundcoords = 64;
    inboundcoords = 9;
    temp = vec4(ubo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (c >= 0 && c < paddedinboundcoords && temp == expectedIB2) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[64] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44, 2.66247e-44, 2.94273e-44, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { float val[1024]; } ubo0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = 0; c <= 10; ++c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    int paddedinboundcoords = 64;
    inboundcoords = 10;
    temp = vec4(ubo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (c >= 0 && c < paddedinboundcoords && temp == expectedIB2) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform textureBuffer texbo0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 4;
    temp = texelFetch(texbo0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[12] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44, 2.66247e-44, 2.94273e-44, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform textureBuffer texbo0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 10;
    temp = texelFetch(texbo0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(location = 0) in vec4 attr;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(gl_VertexIndex * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 3;
    temp = attr;
    if (gl_VertexIndex >= 0 && gl_VertexIndex < inboundcoords) temp -= expectedIB; else temp -= zzzo;
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[8] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(r32f, set = 0, binding = 0) uniform image2D image0_0;
layout(location = 0) in vec4 attr;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(gl_VertexIndex * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 7;
    temp = attr;
    if (gl_VertexIndex >= 0 && gl_VertexIndex < inboundcoords) temp -= expectedIB; else temp -= zzzo;
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform isampler1DArray texture0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    temp = texelFetch(texture0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec2(0, 0), c); else temp = ivec4(0);
    if (c != 0) temp -= zzzz;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec2((c+0.25) / float(5), 0.25));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec2((c+0.25) / float(5), 0.25), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec2((c+0.25) / float(5), 0.25), 1.0, 1.0);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483647).xyxx;
    accum += abs(temp);
    temp = texelFetch(texture0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec2(0, 0), c); else temp = ivec4(0);
    if (c != 0) temp -= zzzz;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec2(0.25 / float(11), (c+0.25)));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec2(0.25 / float(11), (c+0.25)), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec2(0.25 / float(11), (c+0.25)), 1.0, 1.0);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, -1).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483646).xyxx;
    accum += abs(temp);
  }
  temp_ql = int(textureQueryLevels(texture0_1));
  temp = ivec4(temp_ql);
  accum += abs(temp);
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform isampler2D texture0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    temp = texelFetch(texture0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec2(0, 0), c); else temp = ivec4(0);
    if (c != 0) temp -= zzzo;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec2((c+0.25) / float(5), 0.25 / float(5)));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec2((c+0.25) / float(5), 0.25 / float(5)), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec2((c+0.25) / float(5), 0.25 / float(5)), ivec2(1.0, 0), ivec2(1.0, 0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    inboundcoords = 11;
    temp = texelFetch(texture0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec2(0, 0), c); else temp = ivec4(0);
    if (c != 0) temp -= zzzo;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec2(0.25 / float(11), (c+0.25) / float(11)));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec2(0.25 / float(11), (c+0.25) / float(11)), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec2(0.25 / float(11), (c+0.25) / float(11)), ivec2(0, 1.0), ivec2(0, 1.0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform isampler2DArray texture0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    temp = texelFetch(texture0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = ivec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = ivec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25), ivec2(1.0, 0), ivec2(1.0, 0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = ivec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = texelFetch(texture0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = ivec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = ivec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25), ivec2(0, 1.0), ivec2(0, 1.0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = ivec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = texelFetch(texture0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += ivec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    expectedIB2 = expectedIB;
    clampedLayer = clamp(c, 0, 5);
    expectedIB2 += ivec4(clampedLayer, 0, 0, 0);
    temp = texture(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25)));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25)), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25)), ivec2(0, 0), ivec2(0, 0));
    temp -= expectedIB2;
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform isampler3D texture0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    temp = texelFetch(texture0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5)));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = ivec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5)), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = ivec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5)), ivec3(1.0, 0, 0), ivec3(1.0, 0, 0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = ivec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = texelFetch(texture0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25 / float(11)));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = ivec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25 / float(11)), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = ivec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25 / float(11)), ivec3(0, 1.0, 0), ivec3(0, 1.0, 0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = ivec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = texelFetch(texture0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6)));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = ivec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6)), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = ivec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6)), ivec3(0, 0, 1.0), ivec3(0, 0, 1.0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = ivec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform iimage1D image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform iimage1D image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(r32i, set = 0, binding = 1) volatile uniform iimage1D image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, c, int(10));
    inboundcoords = 5;
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(r32i, set = 0, binding = 1) uniform iimage1D image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, c, ivec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, c, int(10));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xxxx;
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(r32i, set = 0, binding = 1) uniform iimage1DArray image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec2(c, 0), int(10));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec2(0, c), int(10));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += ivec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform iimage1DArray image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(c, 0), ivec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, c), ivec4(123));
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(r32i, set = 0, binding = 1) uniform iimage2D image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec2(c, 0), int(10));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec2(0, c), int(10));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(r32i, set = 0, binding = 1) volatile uniform iimage2D image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(c, 0), ivec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec2(c, 0), int(10));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, c), ivec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec2(0, c), int(10));
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform iimage2D image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(c, 0), ivec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, c), ivec4(123));
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform iimage2DMS image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), 0, ivec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), 0, ivec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec2(0, 0), c, ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = ivec4(0);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform iimage2DArray image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), ivec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), ivec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += ivec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform iimage2DArray image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), ivec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), ivec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), ivec4(123));
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(r32i, set = 0, binding = 1) uniform iimage2DMSArray image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), 0, ivec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec3(c, 0, 0), 0, int(10));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), 0, ivec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec3(0, c, 0), 0, int(10));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), 0, ivec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec3(0, 0, c), 0, int(10));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, 0), c, ivec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec3(0, 0, 0), c, int(10));
    temp = imageLoad(image0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(r32i, set = 0, binding = 1) volatile uniform iimage3D image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), ivec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec3(c, 0, 0), int(10));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), ivec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec3(0, c, 0), int(10));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), ivec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec3(0, 0, c), int(10));
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform iimageCube image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), ivec4(123));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), ivec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(r32i, set = 0, binding = 1) uniform iimageCube image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(c, 0, 0), int(10));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(0, c, 0), int(10));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(0, 0, c), int(10));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(r32i, set = 0, binding = 1) volatile uniform iimageCube image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(c, 0, 0), int(10));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(0, c, 0), int(10));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(0, 0, c), int(10));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(r32i, set = 0, binding = 1) volatile uniform iimageCube image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), ivec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec3(c, 0, 0), int(10));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), ivec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec3(0, c, 0), int(10));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), ivec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec3(0, 0, c), int(10));
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform iimageCubeArray image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), ivec4(123));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), ivec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {3, 5, 7, 9};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1 { int val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1_pad { vec4 pad; int val[]; } ssbo0_1_pad;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 4;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = int(123);
    if (c < 0 || c >= inboundcoords) atomicAdd(ssbo0_1.val[c], int(10));
    temp = ivec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == ivec4(int(123), 0, 0, 0)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[64] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95, 97, 99, 101, 103, 105, 107, 109, 111, 113, 115, 117, 119, 121, 123, 125, 127, 129};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { int val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; int val[]; } ssbo0_1_pad;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 64;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = int(123);
    if (c < 0 || c >= inboundcoords) atomicAdd(ssbo0_1.val[c], int(10));
    temp = ivec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[8] = {3, 5, 7, 9, 11, 13, 15, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { int val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; int val[]; } ssbo0_1_pad;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 7;
    temp = ivec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[8] = {3, 5, 7, 9, 11, 13, 15, 17};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { int val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; int val[]; } ssbo0_1_pad;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 8;
    temp = ivec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == ivec4(int(123), 0, 0, 0)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[8] = {3, 5, 7, 9, 11, 13, 15, 17};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { int val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; int val[]; } ssbo0_1_pad;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 8;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = int(123);
    if (c < 0 || c >= inboundcoords) atomicAdd(ssbo0_1.val[c], int(10));
    temp = ivec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {3, 5, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform iimageBuffer image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 2;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, ivec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[64] = {3, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { int val[1024]; } ubo0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1023; c >= 0; --c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    int paddedinboundcoords = 64;
    inboundcoords = 2;
    temp = ivec4(ubo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (c >= 0 && c < paddedinboundcoords && temp == expectedIB2) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {3, 5, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform itextureBuffer texbo0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 2;
    temp = texelFetch(texbo0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform isampler1D texture0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    temp = texelFetch(texture0_1, c, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, 0, c); else temp = ivec4(0);
    if (c != 0) temp -= zzzo;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, (c+0.25) / float(5));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    temp = textureLod(texture0_1, (c+0.25) / float(5), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    temp = textureGrad(texture0_1, (c+0.25) / float(5), 1.0, 1.0);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform isamplerCube texture0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5)));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5)), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5)), ivec3(1.0, 0, 0), ivec3(1.0, 0, 0));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483647).xyxx;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3(0.25 / float(5), (c+0.25) / float(5), 0.25 / float(5)));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3(0.25 / float(5), (c+0.25) / float(5), 0.25 / float(5)), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3(0.25 / float(5), (c+0.25) / float(5), 0.25 / float(5)), ivec3(0, 1.0, 0), ivec3(0, 1.0, 0));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, -1).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483646).xyxx;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6)));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6)), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6)), ivec3(0, 0, 1.0), ivec3(0, 0, 1.0));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, -2).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483645).xyxx;
    accum += abs(temp);
  }
  temp_ql = int(textureQueryLevels(texture0_1));
  temp = ivec4(temp_ql);
  accum += abs(temp);
  vec2 lod = textureQueryLod(texture0_1, gl_FragCoord.xyz);
  temp_ql = int(ceil(abs(lod.x) + abs(lod.y)));
  temp = ivec4(temp_ql);
  accum += abs(temp);
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(r32i, set = 0, binding = 1) volatile uniform iimage1D image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, c, int(10));
    inboundcoords = 5;
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform iimage1DArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), ivec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += ivec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform iimage1DArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), ivec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += ivec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform iimage1DArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), ivec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += ivec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(r32i, set = 0, binding = 1) volatile uniform iimage1DArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(c, 0), ivec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec2(c, 0), int(10));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, c), ivec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec2(0, c), int(10));
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform iimage2D image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(c, 0), ivec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, c), ivec4(123));
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(r32i, set = 0, binding = 1) uniform iimage2DMS image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), 0, ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec2(c, 0), 0, int(10));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), 0, ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec2(0, c), 0, int(10));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec2(0, 0), c, ivec4(123));
    if (c < 0 || c >= 4) imageAtomicAdd(image0_1, ivec2(0, 0), c, int(10));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = ivec4(0);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform iimage2DMSArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), 0, ivec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), 0, ivec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), 0, ivec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec3(0, 0, 0), c, ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += ivec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = ivec4(0);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform iimage2DMSArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), 0, ivec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), 0, ivec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), 0, ivec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec3(0, 0, 0), c, ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += ivec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = ivec4(0);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(r32i, set = 0, binding = 1) volatile uniform iimage2DMSArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), 0, ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(c, 0, 0), 0, int(10));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), 0, ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(0, c, 0), 0, int(10));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), 0, ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(0, 0, c), 0, int(10));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec3(0, 0, 0), c, ivec4(123));
    if (c < 0 || c >= 4) imageAtomicAdd(image0_1, ivec3(0, 0, 0), c, int(10));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += ivec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = ivec4(0);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(r32i, set = 0, binding = 1) volatile uniform iimage2DMSArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), 0, ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(c, 0, 0), 0, int(10));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), 0, ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(0, c, 0), 0, int(10));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), 0, ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(0, 0, c), 0, int(10));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec3(0, 0, 0), c, ivec4(123));
    if (c < 0 || c >= 4) imageAtomicAdd(image0_1, ivec3(0, 0, 0), c, int(10));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += ivec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = ivec4(0);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(r32i, set = 0, binding = 1) uniform iimage2DMSArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), 0, ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(c, 0, 0), 0, int(10));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), 0, ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(0, c, 0), 0, int(10));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), 0, ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(0, 0, c), 0, int(10));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec3(0, 0, 0), c, ivec4(123));
    if (c < 0 || c >= 4) imageAtomicAdd(image0_1, ivec3(0, 0, 0), c, int(10));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += ivec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = ivec4(0);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(r32i, set = 0, binding = 1) uniform iimage2DMSArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), 0, ivec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec3(c, 0, 0), 0, int(10));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), 0, ivec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec3(0, c, 0), 0, int(10));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), 0, ivec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec3(0, 0, c), 0, int(10));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, 0), c, ivec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec3(0, 0, 0), c, int(10));
    temp = imageLoad(image0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(r32i, set = 0, binding = 1) uniform iimage3D image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(c, 0, 0), int(10));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(0, c, 0), int(10));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(0, 0, c), int(10));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(r32i, set = 0, binding = 1) uniform iimage3D image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), ivec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec3(c, 0, 0), int(10));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), ivec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec3(0, c, 0), int(10));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), ivec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec3(0, 0, c), int(10));
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform iimageCube image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), ivec4(123));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), ivec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform iimageCube image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), ivec4(123));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), ivec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform iimageCubeArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), ivec4(123));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), ivec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(r32i, set = 0, binding = 1) volatile uniform iimageCubeArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(c, 0, 0), int(10));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(0, c, 0), int(10));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(0, 0, c), int(10));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform iimageCubeArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), ivec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), ivec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), ivec4(123));
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[68] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95, 97, 99, 101, 103, 105, 107, 109, 111, 113, 115, 117, 119, 121, 123, 125, 127, 129, 131, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { int val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; int val[]; } ssbo0_1_pad;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 68);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 65;
    temp = ivec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[68] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95, 97, 99, 101, 103, 105, 107, 109, 111, 113, 115, 117, 119, 121, 123, 125, 127, 129, 131, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { int val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; int val[]; } ssbo0_1_pad;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 68);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 65;
    temp = ivec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[12] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { int val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; int val[]; } ssbo0_1_pad;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 9;
    temp = ivec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[12] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { int val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; int val[]; } ssbo0_1_pad;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 9;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = int(123);
    if (c < 0 || c >= inboundcoords) atomicAdd(ssbo0_1.val[c], int(10));
    temp = ivec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[12] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform iimageBuffer image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 10;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, ivec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[12] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(r32i, set = 0, binding = 1) volatile uniform iimageBuffer image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 10;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, c, int(10));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[12] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform iimageBuffer image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 10;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, ivec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[64] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { int val[1024]; } ubo0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1023; c >= 0; --c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    int paddedinboundcoords = 64;
    inboundcoords = 10;
    temp = ivec4(ubo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (c >= 0 && c < paddedinboundcoords && temp == expectedIB2) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[64] = {3, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { int val[1024]; } ubo0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1023; c >= 0; --c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    int paddedinboundcoords = 64;
    inboundcoords = 2;
    temp = ivec4(ubo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (c >= 0 && c < paddedinboundcoords && temp == expectedIB2) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform isampler1D texture0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    temp = texelFetch(texture0_1, c, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, 0, c); else temp = ivec4(0);
    if (c != 0) temp -= zzzo;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, (c+0.25) / float(5));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    temp = textureLod(texture0_1, (c+0.25) / float(5), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    temp = textureGrad(texture0_1, (c+0.25) / float(5), 1.0, 1.0);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform isampler1DArray texture0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    temp = texelFetch(texture0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec2(0, 0), c); else temp = ivec4(0);
    if (c != 0) temp -= zzzz;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec2((c+0.25) / float(5), 0.25));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec2((c+0.25) / float(5), 0.25), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec2((c+0.25) / float(5), 0.25), 1.0, 1.0);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483647).xyxx;
    accum += abs(temp);
    temp = texelFetch(texture0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec2(0, 0), c); else temp = ivec4(0);
    if (c != 0) temp -= zzzz;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec2(0.25 / float(11), (c+0.25)));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec2(0.25 / float(11), (c+0.25)), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec2(0.25 / float(11), (c+0.25)), 1.0, 1.0);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, -1).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483646).xyxx;
    accum += abs(temp);
  }
  temp_ql = int(textureQueryLevels(texture0_1));
  temp = ivec4(temp_ql);
  accum += abs(temp);
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform isampler2DMS texture0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    temp = texelFetch(texture0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = textureSize(texture0_1).xyxx;
    accum += abs(temp);
    temp = textureSamples(texture0_1).xxxx;
    accum += abs(temp);
    temp = texelFetch(texture0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = textureSize(texture0_1).xyxx;
    accum += abs(temp);
    temp = textureSamples(texture0_1).xxxx;
    accum += abs(temp);
    temp = texelFetch(texture0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = ivec4(0);
    accum += abs(temp);
    temp = textureSize(texture0_1).xyxx;
    accum += abs(temp);
    temp = textureSamples(texture0_1).xxxx;
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform isampler2DArray texture0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    temp = texelFetch(texture0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = ivec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = ivec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25), ivec2(1.0, 0), ivec2(1.0, 0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = ivec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = texelFetch(texture0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = ivec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = ivec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25), ivec2(0, 1.0), ivec2(0, 1.0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = ivec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = texelFetch(texture0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += ivec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    expectedIB2 = expectedIB;
    clampedLayer = clamp(c, 0, 5);
    expectedIB2 += ivec4(clampedLayer, 0, 0, 0);
    temp = texture(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25)));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25)), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25)), ivec2(0, 0), ivec2(0, 0));
    temp -= expectedIB2;
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(r32i, set = 0, binding = 1) uniform iimage1DArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec2(c, 0), int(10));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec2(0, c), int(10));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += ivec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(r32i, set = 0, binding = 1) volatile uniform iimage1DArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(c, 0), ivec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec2(c, 0), int(10));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, c), ivec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec2(0, c), int(10));
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform iimage2D image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), ivec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(r32i, set = 0, binding = 1) uniform iimage2DMS image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), 0, ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec2(c, 0), 0, int(10));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), 0, ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec2(0, c), 0, int(10));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec2(0, 0), c, ivec4(123));
    if (c < 0 || c >= 4) imageAtomicAdd(image0_1, ivec2(0, 0), c, int(10));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = ivec4(0);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(r32i, set = 0, binding = 1) volatile uniform iimage2DMS image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), 0, ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec2(c, 0), 0, int(10));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), 0, ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec2(0, c), 0, int(10));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec2(0, 0), c, ivec4(123));
    if (c < 0 || c >= 4) imageAtomicAdd(image0_1, ivec2(0, 0), c, int(10));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = ivec4(0);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform iimage2DMS image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), 0, ivec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), 0, ivec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec2(0, 0), c, ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = ivec4(0);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform iimage2DMS image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(c, 0), 0, ivec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, c), 0, ivec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, 0), c, ivec4(123));
    temp = imageLoad(image0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(r32i, set = 0, binding = 1) volatile uniform iimage2DMS image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(c, 0), 0, ivec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec2(c, 0), 0, int(10));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, c), 0, ivec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec2(0, c), 0, int(10));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, 0), c, ivec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec2(0, 0), c, int(10));
    temp = imageLoad(image0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(r32i, set = 0, binding = 1) volatile uniform iimage2DMSArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), 0, ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(c, 0, 0), 0, int(10));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), 0, ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(0, c, 0), 0, int(10));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), 0, ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(0, 0, c), 0, int(10));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec3(0, 0, 0), c, ivec4(123));
    if (c < 0 || c >= 4) imageAtomicAdd(image0_1, ivec3(0, 0, 0), c, int(10));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += ivec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = ivec4(0);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(r32i, set = 0, binding = 1) volatile uniform iimageCube image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(c, 0, 0), int(10));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(0, c, 0), int(10));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(0, 0, c), int(10));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform iimageCube image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), ivec4(123));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), ivec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {3, 5, 7, 9};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { int val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; int val[]; } ssbo0_1_pad;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 4;
    temp = ivec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[64] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95, 97, 99, 101, 103, 105, 107, 109, 111, 113, 115, 117, 119, 121, 123, 125, 127, 129};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { int val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; int val[]; } ssbo0_1_pad;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 64;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = int(123);
    if (c < 0 || c >= inboundcoords) atomicAdd(ssbo0_1.val[c], int(10));
    temp = ivec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[8] = {3, 5, 7, 9, 11, 13, 15, 17};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { int val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; int val[]; } ssbo0_1_pad;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 8;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = int(123);
    if (c < 0 || c >= inboundcoords) atomicAdd(ssbo0_1.val[c], int(10));
    temp = ivec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {3, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1 { int val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1_pad { vec4 pad; int val[]; } ssbo0_1_pad;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 1;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = int(123);
    if (c < 0 || c >= inboundcoords) atomicAdd(ssbo0_1.val[c], int(10));
    temp = ivec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == ivec4(int(123), 0, 0, 0)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1 { int val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1_pad { vec4 pad; int val[]; } ssbo0_1_pad;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) ssbo0_1.val[c] = int(123);
    if (c < 0 || c >= 0) atomicAdd(ssbo0_1.val[c], int(10));
    temp = ivec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == ivec4(int(123), 0, 0, 0)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = ivec4(ssbo0_1.val.length());
    accum += abs(temp);
    temp = ivec4(ssbo0_1_pad.val.length());
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {3, 5, 7, 9};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(r32i, set = 0, binding = 1) volatile uniform iimageBuffer image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 4;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, c, int(10));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[8] = {3, 5, 7, 9, 11, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(r32i, set = 0, binding = 1) volatile uniform iimageBuffer image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, c, int(10));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[64] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95, 97, 99, 101, 103, 105, 107, 109, 111, 113, 115, 117, 119, 121, 123, 125, 127, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(r32i, set = 0, binding = 1) uniform iimageBuffer image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 63;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, c, int(10));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[64] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95, 97, 99, 101, 103, 105, 107, 109, 111, 113, 115, 117, 119, 121, 123, 125, 127, 129};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform iimageBuffer image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 64;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, ivec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[64] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95, 97, 99, 101, 103, 105, 107, 109, 111, 113, 115, 117, 119, 121, 123, 125, 127, 129};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(r32i, set = 0, binding = 1) uniform iimageBuffer image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 64;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, c, int(10));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[8] = {3, 5, 7, 9, 11, 13, 15, 17};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(r32i, set = 0, binding = 1) uniform iimageBuffer image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 8;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, c, int(10));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {3, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(r32i, set = 0, binding = 1) uniform iimageBuffer image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 1;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, c, int(10));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[12] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform iimageBuffer image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 10;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, ivec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[64] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95, 97, 99, 101, 103, 105, 107, 109, 111, 113, 115, 117, 119, 121, 123, 125, 127, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { int val[1024]; } ubo0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = 0; c <= 10; ++c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    int paddedinboundcoords = 64;
    inboundcoords = 63;
    temp = ivec4(ubo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (c >= 0 && c < paddedinboundcoords && temp == expectedIB2) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[128] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95, 97, 99, 101, 103, 105, 107, 109, 111, 113, 115, 117, 119, 121, 123, 125, 127, 129, 131, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { int val[1024]; } ubo0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1023; c >= 0; --c) {
    int idx = smod(c * 1, 128);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    int paddedinboundcoords = 128;
    inboundcoords = 65;
    temp = ivec4(ubo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (c >= 0 && c < paddedinboundcoords && temp == expectedIB2) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[68] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95, 97, 99, 101, 103, 105, 107, 109, 111, 113, 115, 117, 119, 121, 123, 125, 127, 129, 131, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform itextureBuffer texbo0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 68);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 65;
    temp = texelFetch(texbo0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {3, 5, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform itextureBuffer texbo0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 2;
    temp = texelFetch(texbo0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform isampler1D texture0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    temp = texelFetch(texture0_1, c, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, 0, c); else temp = ivec4(0);
    if (c != 0) temp -= zzzo;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, (c+0.25) / float(5));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    temp = textureLod(texture0_1, (c+0.25) / float(5), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    temp = textureGrad(texture0_1, (c+0.25) / float(5), 1.0, 1.0);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform isampler2DArray texture0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    temp = texelFetch(texture0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec3(0, 0, 0), c); else temp = ivec4(0);
    if (c != 0) temp -= zzzo;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25), ivec2(1.0, 0), ivec2(1.0, 0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    inboundcoords = 11;
    temp = texelFetch(texture0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec3(0, 0, 0), c); else temp = ivec4(0);
    if (c != 0) temp -= zzzo;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25), ivec2(0, 1.0), ivec2(0, 1.0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    inboundcoords = 6;
    temp = texelFetch(texture0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += ivec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec3(0, 0, 0), c); else temp = ivec4(0);
    if (c != 0) temp -= zzzo;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    clampedLayer = clamp(c, 0, 5);
    expectedIB2 += ivec4(clampedLayer, 0, 0, 0);
    temp = texture(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25)));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25)), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25)), ivec2(0, 0), ivec2(0, 0));
    temp -= expectedIB2;
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform isampler2DArray texture0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    temp = texelFetch(texture0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec3(0, 0, 0), c); else temp = ivec4(0);
    if (c != 0) temp -= zzzz;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25), ivec2(1.0, 0), ivec2(1.0, 0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyzx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyzx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483647).xyzx;
    accum += abs(temp);
    temp = texelFetch(texture0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec3(0, 0, 0), c); else temp = ivec4(0);
    if (c != 0) temp -= zzzz;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25), ivec2(0, 1.0), ivec2(0, 1.0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyzx;
    accum += abs(temp);
    temp = textureSize(texture0_1, -1).xyzx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483646).xyzx;
    accum += abs(temp);
    temp = texelFetch(texture0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec3(0, 0, 0), c); else temp = ivec4(0);
    if (c != 0) temp -= zzzz;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25)));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25)), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25)), ivec2(0, 0), ivec2(0, 0));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyzx;
    accum += abs(temp);
    temp = textureSize(texture0_1, -2).xyzx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483645).xyzx;
    accum += abs(temp);
  }
  temp_ql = int(textureQueryLevels(texture0_1));
  temp = ivec4(temp_ql);
  accum += abs(temp);
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform isampler2DMSArray texture0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    temp = texelFetch(texture0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = texelFetch(texture0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = texelFetch(texture0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += ivec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = texelFetch(texture0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = ivec4(0);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform isamplerCube texture0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5)));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5)), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5)), ivec3(1.0, 0, 0), ivec3(1.0, 0, 0));
    temp -= expectedIB2;
    accum += abs(temp);
    inboundcoords = 5;
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3(0.25 / float(5), (c+0.25) / float(5), 0.25 / float(5)));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3(0.25 / float(5), (c+0.25) / float(5), 0.25 / float(5)), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3(0.25 / float(5), (c+0.25) / float(5), 0.25 / float(5)), ivec3(0, 1.0, 0), ivec3(0, 1.0, 0));
    temp -= expectedIB2;
    accum += abs(temp);
    inboundcoords = 6;
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6)));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6)), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6)), ivec3(0, 0, 1.0), ivec3(0, 0, 1.0));
    temp -= expectedIB2;
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform isamplerCubeArray texture0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec4((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5), 0.25));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec4((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5), 0.25), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec4((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5), 0.25), ivec3(1.0, 0, 0), ivec3(1.0, 0, 0));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyzx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyzx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483647).xyzx;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec4(0.25 / float(5), (c+0.25) / float(5), 0.25 / float(5), 0.25));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec4(0.25 / float(5), (c+0.25) / float(5), 0.25 / float(5), 0.25), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec4(0.25 / float(5), (c+0.25) / float(5), 0.25 / float(5), 0.25), ivec3(0, 1.0, 0), ivec3(0, 1.0, 0));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyzx;
    accum += abs(temp);
    temp = textureSize(texture0_1, -1).xyzx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483646).xyzx;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec4(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6), 0.25));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec4(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6), 0.25), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec4(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6), 0.25), ivec3(0, 0, 1.0), ivec3(0, 0, 1.0));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyzx;
    accum += abs(temp);
    temp = textureSize(texture0_1, -2).xyzx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483645).xyzx;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec4(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6), 0.25));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec4(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6), 0.25), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec4(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6), 0.25), ivec3(0, 0, 0), ivec3(0, 0, 0));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyzx;
    accum += abs(temp);
    temp = textureSize(texture0_1, -3).xyzx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483644).xyzx;
    accum += abs(temp);
  }
  temp_ql = int(textureQueryLevels(texture0_1));
  temp = ivec4(temp_ql);
  accum += abs(temp);
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform iimage1D image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(r32i, set = 0, binding = 1) uniform iimage1DArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec2(c, 0), int(10));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec2(0, c), int(10));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += ivec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform iimage1DArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), ivec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += ivec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(r32i, set = 0, binding = 1) volatile uniform iimage1DArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec2(c, 0), int(10));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec2(0, c), int(10));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += ivec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(r32i, set = 0, binding = 1) volatile uniform iimage1DArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(c, 0), ivec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec2(c, 0), int(10));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, c), ivec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec2(0, c), int(10));
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(r32i, set = 0, binding = 1) volatile uniform iimage2D image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec2(c, 0), int(10));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec2(0, c), int(10));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform iimage2D image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), ivec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(r32i, set = 0, binding = 1) volatile uniform iimage2D image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec2(c, 0), int(10));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec2(0, c), int(10));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(r32i, set = 0, binding = 1) uniform iimage2D image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(c, 0), ivec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec2(c, 0), int(10));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, c), ivec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec2(0, c), int(10));
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform iimage2DMS image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), 0, ivec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), 0, ivec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec2(0, 0), c, ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = ivec4(0);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform iimage2DMS image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), 0, ivec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), 0, ivec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec2(0, 0), c, ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = ivec4(0);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(r32i, set = 0, binding = 1) volatile uniform iimage2DMS image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), 0, ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec2(c, 0), 0, int(10));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), 0, ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec2(0, c), 0, int(10));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec2(0, 0), c, ivec4(123));
    if (c < 0 || c >= 4) imageAtomicAdd(image0_1, ivec2(0, 0), c, int(10));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = ivec4(0);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform iimage2DArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), ivec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), ivec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), ivec4(123));
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform iimage2DArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), ivec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), ivec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), ivec4(123));
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(r32i, set = 0, binding = 1) volatile uniform iimage2DMSArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), 0, ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(c, 0, 0), 0, int(10));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), 0, ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(0, c, 0), 0, int(10));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), 0, ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(0, 0, c), 0, int(10));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec3(0, 0, 0), c, ivec4(123));
    if (c < 0 || c >= 4) imageAtomicAdd(image0_1, ivec3(0, 0, 0), c, int(10));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += ivec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = ivec4(0);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(r32i, set = 0, binding = 1) uniform iimage3D image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(c, 0, 0), int(10));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(0, c, 0), int(10));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(0, 0, c), int(10));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(r32i, set = 0, binding = 1) volatile uniform iimage3D image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(c, 0, 0), int(10));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(0, c, 0), int(10));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(0, 0, c), int(10));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(r32i, set = 0, binding = 1) uniform iimage3D image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), ivec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec3(c, 0, 0), int(10));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), ivec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec3(0, c, 0), int(10));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), ivec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec3(0, 0, c), int(10));
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform iimageCube image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), ivec4(123));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), ivec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(r32i, set = 0, binding = 1) volatile uniform iimageCube image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), ivec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec3(c, 0, 0), int(10));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), ivec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec3(0, c, 0), int(10));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), ivec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec3(0, 0, c), int(10));
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform iimageCubeArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), ivec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), ivec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), ivec4(123));
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {3, 5, 7, 9};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { int val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; int val[]; } ssbo0_1_pad;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 4;
    temp = ivec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == ivec4(int(123), 0, 0, 0)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[64] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95, 97, 99, 101, 103, 105, 107, 109, 111, 113, 115, 117, 119, 121, 123, 125, 127, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { int val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; int val[]; } ssbo0_1_pad;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 63;
    temp = ivec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == ivec4(int(123), 0, 0, 0)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[68] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95, 97, 99, 101, 103, 105, 107, 109, 111, 113, 115, 117, 119, 121, 123, 125, 127, 129, 131, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { int val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; int val[]; } ssbo0_1_pad;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 68);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 65;
    temp = ivec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == ivec4(int(123), 0, 0, 0)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[8] = {3, 5, 7, 9, 11, 13, 15, 17};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { int val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; int val[]; } ssbo0_1_pad;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 8;
    temp = ivec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == ivec4(int(123), 0, 0, 0)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {3, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { int val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; int val[]; } ssbo0_1_pad;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 1;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = int(123);
    if (c < 0 || c >= inboundcoords) atomicAdd(ssbo0_1.val[c], int(10));
    temp = ivec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[12] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { int val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; int val[]; } ssbo0_1_pad;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 10;
    temp = ivec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == ivec4(int(123), 0, 0, 0)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[8] = {3, 5, 7, 9, 11, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(r32i, set = 0, binding = 1) uniform iimageBuffer image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, c, int(10));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[8] = {3, 5, 7, 9, 11, 13, 15, 17};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(r32i, set = 0, binding = 1) volatile uniform iimageBuffer image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 8;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, ivec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, c, int(10));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[64] = {3, 5, 7, 9, 11, 13, 15, 17, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { int val[1024]; } ubo0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = 0; c <= 10; ++c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    int paddedinboundcoords = 64;
    inboundcoords = 8;
    temp = ivec4(ubo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (c >= 0 && c < paddedinboundcoords && temp == expectedIB2) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[64] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { int val[1024]; } ubo0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1023; c >= 0; --c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    int paddedinboundcoords = 64;
    inboundcoords = 10;
    temp = ivec4(ubo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (c >= 0 && c < paddedinboundcoords && temp == expectedIB2) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[12] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(r32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform itextureBuffer texbo0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 9;
    temp = texelFetch(texbo0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform usampler1D texture0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    temp = texelFetch(texture0_1, c, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, 0, c); else temp = uvec4(0);
    if (c != 0) temp -= zzzo;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, (c+0.25) / float(5));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    temp = textureLod(texture0_1, (c+0.25) / float(5), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    temp = textureGrad(texture0_1, (c+0.25) / float(5), 1.0, 1.0);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform usampler1DArray texture0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    temp = texelFetch(texture0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec2(0, 0), c); else temp = uvec4(0);
    if (c != 0) temp -= zzzo;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec2((c+0.25) / float(5), 0.25));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec2((c+0.25) / float(5), 0.25), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec2((c+0.25) / float(5), 0.25), 1.0, 1.0);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    inboundcoords = 11;
    temp = texelFetch(texture0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += uvec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec2(0, 0), c); else temp = uvec4(0);
    if (c != 0) temp -= zzzo;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    clampedLayer = clamp(c, 0, 10);
    expectedIB2 += uvec4(clampedLayer, 0, 0, 0);
    temp = texture(texture0_1, vec2(0.25 / float(11), (c+0.25)));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec2(0.25 / float(11), (c+0.25)), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec2(0.25 / float(11), (c+0.25)), 1.0, 1.0);
    temp -= expectedIB2;
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform usampler2D texture0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    temp = texelFetch(texture0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec2((c+0.25) / float(5), 0.25 / float(5)));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = uvec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureLod(texture0_1, vec2((c+0.25) / float(5), 0.25 / float(5)), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = uvec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec2((c+0.25) / float(5), 0.25 / float(5)), ivec2(1.0, 0), ivec2(1.0, 0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = uvec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = texelFetch(texture0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec2(0.25 / float(11), (c+0.25) / float(11)));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = uvec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureLod(texture0_1, vec2(0.25 / float(11), (c+0.25) / float(11)), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = uvec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec2(0.25 / float(11), (c+0.25) / float(11)), ivec2(0, 1.0), ivec2(0, 1.0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = uvec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform usampler2DMS texture0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    temp = texelFetch(texture0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = textureSize(texture0_1).xyxx;
    accum += abs(temp);
    temp = textureSamples(texture0_1).xxxx;
    accum += abs(temp);
    temp = texelFetch(texture0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = textureSize(texture0_1).xyxx;
    accum += abs(temp);
    temp = textureSamples(texture0_1).xxxx;
    accum += abs(temp);
    temp = texelFetch(texture0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = uvec4(0);
    accum += abs(temp);
    temp = textureSize(texture0_1).xyxx;
    accum += abs(temp);
    temp = textureSamples(texture0_1).xxxx;
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform usampler3D texture0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    temp = texelFetch(texture0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec3(0, 0, 0), c); else temp = uvec4(0);
    if (c != 0) temp -= zzzz;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5)));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5)), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5)), ivec3(1.0, 0, 0), ivec3(1.0, 0, 0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyzx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyzx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483647).xyzx;
    accum += abs(temp);
    temp = texelFetch(texture0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec3(0, 0, 0), c); else temp = uvec4(0);
    if (c != 0) temp -= zzzz;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25 / float(11)));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25 / float(11)), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25 / float(11)), ivec3(0, 1.0, 0), ivec3(0, 1.0, 0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyzx;
    accum += abs(temp);
    temp = textureSize(texture0_1, -1).xyzx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483646).xyzx;
    accum += abs(temp);
    temp = texelFetch(texture0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec3(0, 0, 0), c); else temp = uvec4(0);
    if (c != 0) temp -= zzzz;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6)));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6)), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6)), ivec3(0, 0, 1.0), ivec3(0, 0, 1.0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyzx;
    accum += abs(temp);
    temp = textureSize(texture0_1, -2).xyzx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483645).xyzx;
    accum += abs(temp);
  }
  temp_ql = uint(textureQueryLevels(texture0_1));
  temp = uvec4(temp_ql);
  accum += abs(temp);
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(r32ui, set = 0, binding = 1) volatile uniform uimage1D image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, uvec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, c, uint(10));
    inboundcoords = 5;
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform uimage1D image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, uvec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(r32ui, set = 0, binding = 1) volatile uniform uimage1D image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, uvec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, c, uint(10));
    inboundcoords = 5;
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform uimage1D image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, c, uvec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xxxx;
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform uimage1DArray image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), uvec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), uvec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += uvec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform uimage1DArray image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), uvec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), uvec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += uvec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(r32ui, set = 0, binding = 1) volatile uniform uimage2DMS image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), 0, uvec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec2(c, 0), 0, uint(10));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), 0, uvec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec2(0, c), 0, uint(10));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec2(0, 0), c, uvec4(123));
    if (c < 0 || c >= 4) imageAtomicAdd(image0_1, ivec2(0, 0), c, uint(10));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = uvec4(0);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform uimage2DArray image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), uvec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), uvec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), uvec4(123));
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform uimage2DMSArray image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), 0, uvec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), 0, uvec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), 0, uvec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec3(0, 0, 0), c, uvec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += uvec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = uvec4(0);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(r32ui, set = 0, binding = 1) volatile uniform uimage2DMSArray image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), 0, uvec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec3(c, 0, 0), 0, uint(10));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), 0, uvec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec3(0, c, 0), 0, uint(10));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), 0, uvec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec3(0, 0, c), 0, uint(10));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, 0), c, uvec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec3(0, 0, 0), c, uint(10));
    temp = imageLoad(image0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (temp == zzzz) temp = uvec4(0);
    else if (temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(r32ui, set = 0, binding = 1) uniform uimage3D image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), uvec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(c, 0, 0), uint(10));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), uvec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(0, c, 0), uint(10));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), uvec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(0, 0, c), uint(10));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(r32ui, set = 0, binding = 1) uniform uimage3D image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), uvec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec3(c, 0, 0), uint(10));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), uvec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec3(0, c, 0), uint(10));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), uvec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec3(0, 0, c), uint(10));
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(r32ui, set = 0, binding = 1) uniform uimageCube image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), uvec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(c, 0, 0), uint(10));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), uvec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(0, c, 0), uint(10));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), uvec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(0, 0, c), uint(10));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[64] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95, 97, 99, 101, 103, 105, 107, 109, 111, 113, 115, 117, 119, 121, 123, 125, 127, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { uint val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; uint val[]; } ssbo0_1_pad;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 63;
    temp = uvec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(uint(123), 0, 0, 0)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[68] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95, 97, 99, 101, 103, 105, 107, 109, 111, 113, 115, 117, 119, 121, 123, 125, 127, 129, 131, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { uint val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; uint val[]; } ssbo0_1_pad;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 68);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 65;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = uint(123);
    if (c < 0 || c >= inboundcoords) atomicAdd(ssbo0_1.val[c], uint(10));
    temp = uvec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
