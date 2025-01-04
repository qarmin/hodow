// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/mesh_shader/vktMeshShaderInOutTestsEXT.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream picks 40 pseudorandom permutations of the interface variables each
// requirement group allows and formats the shaders from them at run time. Here the manifest holds the same permutations
// (same generator, seed and shuffle) with every shader set written out, so a case only needs its group, permutation and task flag to
// find its programs. The input data is built exactly as upstream's generated initializers do (member k of the per-vertex and
// per-primitive structs holds 1000 + 10 * k + component + 1, with a fractional part for the interpolated floats), as a tightly packed
// byte image of the C++ structs.
//
// Passes values from storage buffers through task, mesh and fragment shader interfaces and has the fragment shader check them.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ExtMeshShaderExtensionDeviceCommands, InstanceV1_1};

use crate::generated::shaders::mesh_shader_in_out::{
    IN_OUT_R0_P0_MESH, IN_OUT_R0_P0_TASK, IN_OUT_R0_P1_MESH, IN_OUT_R0_P1_TASK, IN_OUT_R0_P2_MESH, IN_OUT_R0_P2_TASK,
    IN_OUT_R0_P3_MESH, IN_OUT_R0_P3_TASK, IN_OUT_R0_P4_MESH, IN_OUT_R0_P4_TASK, IN_OUT_R0_P5_MESH, IN_OUT_R0_P5_TASK,
    IN_OUT_R0_P6_MESH, IN_OUT_R0_P6_TASK, IN_OUT_R0_P7_MESH, IN_OUT_R0_P7_TASK, IN_OUT_R0_P8_MESH, IN_OUT_R0_P8_TASK,
    IN_OUT_R0_P9_MESH, IN_OUT_R0_P9_TASK, IN_OUT_R0_P10_MESH, IN_OUT_R0_P10_TASK, IN_OUT_R0_P11_MESH,
    IN_OUT_R0_P11_TASK, IN_OUT_R0_P12_MESH, IN_OUT_R0_P12_TASK, IN_OUT_R0_P13_MESH, IN_OUT_R0_P13_TASK,
    IN_OUT_R0_P14_MESH, IN_OUT_R0_P14_TASK, IN_OUT_R0_P15_MESH, IN_OUT_R0_P15_TASK, IN_OUT_R0_P16_MESH,
    IN_OUT_R0_P16_TASK, IN_OUT_R0_P17_MESH, IN_OUT_R0_P17_TASK, IN_OUT_R0_P18_MESH, IN_OUT_R0_P18_TASK,
    IN_OUT_R0_P19_MESH, IN_OUT_R0_P19_TASK, IN_OUT_R0_P20_MESH, IN_OUT_R0_P20_TASK, IN_OUT_R0_P21_MESH,
    IN_OUT_R0_P21_TASK, IN_OUT_R0_P22_MESH, IN_OUT_R0_P22_TASK, IN_OUT_R0_P23_MESH, IN_OUT_R0_P23_TASK,
    IN_OUT_R0_P24_MESH, IN_OUT_R0_P24_TASK, IN_OUT_R0_P25_MESH, IN_OUT_R0_P25_TASK, IN_OUT_R0_P26_MESH,
    IN_OUT_R0_P26_TASK, IN_OUT_R0_P27_MESH, IN_OUT_R0_P27_TASK, IN_OUT_R0_P28_MESH, IN_OUT_R0_P28_TASK,
    IN_OUT_R0_P29_MESH, IN_OUT_R0_P29_TASK, IN_OUT_R0_P30_MESH, IN_OUT_R0_P30_TASK, IN_OUT_R0_P31_MESH,
    IN_OUT_R0_P31_TASK, IN_OUT_R0_P32_MESH, IN_OUT_R0_P32_TASK, IN_OUT_R0_P33_MESH, IN_OUT_R0_P33_TASK,
    IN_OUT_R0_P34_MESH, IN_OUT_R0_P34_TASK, IN_OUT_R0_P35_MESH, IN_OUT_R0_P35_TASK, IN_OUT_R0_P36_MESH,
    IN_OUT_R0_P36_TASK, IN_OUT_R0_P37_MESH, IN_OUT_R0_P37_TASK, IN_OUT_R0_P38_MESH, IN_OUT_R0_P38_TASK,
    IN_OUT_R0_P39_MESH, IN_OUT_R0_P39_TASK, IN_OUT_R1_P0_MESH, IN_OUT_R1_P0_TASK, IN_OUT_R1_P1_MESH, IN_OUT_R1_P1_TASK,
    IN_OUT_R1_P2_MESH, IN_OUT_R1_P2_TASK, IN_OUT_R1_P3_MESH, IN_OUT_R1_P3_TASK, IN_OUT_R1_P4_MESH, IN_OUT_R1_P4_TASK,
    IN_OUT_R1_P5_MESH, IN_OUT_R1_P5_TASK, IN_OUT_R1_P6_MESH, IN_OUT_R1_P6_TASK, IN_OUT_R1_P7_MESH, IN_OUT_R1_P7_TASK,
    IN_OUT_R1_P8_MESH, IN_OUT_R1_P8_TASK, IN_OUT_R1_P9_MESH, IN_OUT_R1_P9_TASK, IN_OUT_R1_P10_MESH, IN_OUT_R1_P10_TASK,
    IN_OUT_R1_P11_MESH, IN_OUT_R1_P11_TASK, IN_OUT_R1_P12_MESH, IN_OUT_R1_P12_TASK, IN_OUT_R1_P13_MESH,
    IN_OUT_R1_P13_TASK, IN_OUT_R1_P14_MESH, IN_OUT_R1_P14_TASK, IN_OUT_R1_P15_MESH, IN_OUT_R1_P15_TASK,
    IN_OUT_R1_P16_MESH, IN_OUT_R1_P16_TASK, IN_OUT_R1_P17_MESH, IN_OUT_R1_P17_TASK, IN_OUT_R1_P18_MESH,
    IN_OUT_R1_P18_TASK, IN_OUT_R1_P19_MESH, IN_OUT_R1_P19_TASK, IN_OUT_R1_P20_MESH, IN_OUT_R1_P20_TASK,
    IN_OUT_R1_P21_MESH, IN_OUT_R1_P21_TASK, IN_OUT_R1_P22_MESH, IN_OUT_R1_P22_TASK, IN_OUT_R1_P23_MESH,
    IN_OUT_R1_P23_TASK, IN_OUT_R1_P24_MESH, IN_OUT_R1_P24_TASK, IN_OUT_R1_P25_MESH, IN_OUT_R1_P25_TASK,
    IN_OUT_R1_P26_MESH, IN_OUT_R1_P26_TASK, IN_OUT_R1_P27_MESH, IN_OUT_R1_P27_TASK, IN_OUT_R1_P28_MESH,
    IN_OUT_R1_P28_TASK, IN_OUT_R1_P29_MESH, IN_OUT_R1_P29_TASK, IN_OUT_R1_P30_MESH, IN_OUT_R1_P30_TASK,
    IN_OUT_R1_P31_MESH, IN_OUT_R1_P31_TASK, IN_OUT_R1_P32_MESH, IN_OUT_R1_P32_TASK, IN_OUT_R1_P33_MESH,
    IN_OUT_R1_P33_TASK, IN_OUT_R1_P34_MESH, IN_OUT_R1_P34_TASK, IN_OUT_R1_P35_MESH, IN_OUT_R1_P35_TASK,
    IN_OUT_R1_P36_MESH, IN_OUT_R1_P36_TASK, IN_OUT_R1_P37_MESH, IN_OUT_R1_P37_TASK, IN_OUT_R1_P38_MESH,
    IN_OUT_R1_P38_TASK, IN_OUT_R1_P39_MESH, IN_OUT_R1_P39_TASK, IN_OUT_R2_P0_MESH, IN_OUT_R2_P0_TASK,
    IN_OUT_R2_P1_MESH, IN_OUT_R2_P1_TASK, IN_OUT_R2_P2_MESH, IN_OUT_R2_P2_TASK, IN_OUT_R2_P3_MESH, IN_OUT_R2_P3_TASK,
    IN_OUT_R2_P4_MESH, IN_OUT_R2_P4_TASK, IN_OUT_R2_P5_MESH, IN_OUT_R2_P5_TASK, IN_OUT_R2_P6_MESH, IN_OUT_R2_P6_TASK,
    IN_OUT_R2_P7_MESH, IN_OUT_R2_P7_TASK, IN_OUT_R2_P8_MESH, IN_OUT_R2_P8_TASK, IN_OUT_R2_P9_MESH, IN_OUT_R2_P9_TASK,
    IN_OUT_R2_P10_MESH, IN_OUT_R2_P10_TASK, IN_OUT_R2_P11_MESH, IN_OUT_R2_P11_TASK, IN_OUT_R2_P12_MESH,
    IN_OUT_R2_P12_TASK, IN_OUT_R2_P13_MESH, IN_OUT_R2_P13_TASK, IN_OUT_R2_P14_MESH, IN_OUT_R2_P14_TASK,
    IN_OUT_R2_P15_MESH, IN_OUT_R2_P15_TASK, IN_OUT_R2_P16_MESH, IN_OUT_R2_P16_TASK, IN_OUT_R2_P17_MESH,
    IN_OUT_R2_P17_TASK, IN_OUT_R2_P18_MESH, IN_OUT_R2_P18_TASK, IN_OUT_R2_P19_MESH, IN_OUT_R2_P19_TASK,
    IN_OUT_R2_P20_MESH, IN_OUT_R2_P20_TASK, IN_OUT_R2_P21_MESH, IN_OUT_R2_P21_TASK, IN_OUT_R2_P22_MESH,
    IN_OUT_R2_P22_TASK, IN_OUT_R2_P23_MESH, IN_OUT_R2_P23_TASK, IN_OUT_R2_P24_MESH, IN_OUT_R2_P24_TASK,
    IN_OUT_R2_P25_MESH, IN_OUT_R2_P25_TASK, IN_OUT_R2_P26_MESH, IN_OUT_R2_P26_TASK, IN_OUT_R2_P27_MESH,
    IN_OUT_R2_P27_TASK, IN_OUT_R2_P28_MESH, IN_OUT_R2_P28_TASK, IN_OUT_R2_P29_MESH, IN_OUT_R2_P29_TASK,
    IN_OUT_R2_P30_MESH, IN_OUT_R2_P30_TASK, IN_OUT_R2_P31_MESH, IN_OUT_R2_P31_TASK, IN_OUT_R2_P32_MESH,
    IN_OUT_R2_P32_TASK, IN_OUT_R2_P33_MESH, IN_OUT_R2_P33_TASK, IN_OUT_R2_P34_MESH, IN_OUT_R2_P34_TASK,
    IN_OUT_R2_P35_MESH, IN_OUT_R2_P35_TASK, IN_OUT_R2_P36_MESH, IN_OUT_R2_P36_TASK, IN_OUT_R2_P37_MESH,
    IN_OUT_R2_P37_TASK, IN_OUT_R2_P38_MESH, IN_OUT_R2_P38_TASK, IN_OUT_R2_P39_MESH, IN_OUT_R2_P39_TASK,
    IN_OUT_R3_P0_MESH, IN_OUT_R3_P0_TASK, IN_OUT_R3_P1_MESH, IN_OUT_R3_P1_TASK, IN_OUT_R3_P2_MESH, IN_OUT_R3_P2_TASK,
    IN_OUT_R3_P3_MESH, IN_OUT_R3_P3_TASK, IN_OUT_R3_P4_MESH, IN_OUT_R3_P4_TASK, IN_OUT_R3_P5_MESH, IN_OUT_R3_P5_TASK,
    IN_OUT_R3_P6_MESH, IN_OUT_R3_P6_TASK, IN_OUT_R3_P7_MESH, IN_OUT_R3_P7_TASK, IN_OUT_R3_P8_MESH, IN_OUT_R3_P8_TASK,
    IN_OUT_R3_P9_MESH, IN_OUT_R3_P9_TASK, IN_OUT_R3_P10_MESH, IN_OUT_R3_P10_TASK, IN_OUT_R3_P11_MESH,
    IN_OUT_R3_P11_TASK, IN_OUT_R3_P12_MESH, IN_OUT_R3_P12_TASK, IN_OUT_R3_P13_MESH, IN_OUT_R3_P13_TASK,
    IN_OUT_R3_P14_MESH, IN_OUT_R3_P14_TASK, IN_OUT_R3_P15_MESH, IN_OUT_R3_P15_TASK, IN_OUT_R3_P16_MESH,
    IN_OUT_R3_P16_TASK, IN_OUT_R3_P17_MESH, IN_OUT_R3_P17_TASK, IN_OUT_R3_P18_MESH, IN_OUT_R3_P18_TASK,
    IN_OUT_R3_P19_MESH, IN_OUT_R3_P19_TASK, IN_OUT_R3_P20_MESH, IN_OUT_R3_P20_TASK, IN_OUT_R3_P21_MESH,
    IN_OUT_R3_P21_TASK, IN_OUT_R3_P22_MESH, IN_OUT_R3_P22_TASK, IN_OUT_R3_P23_MESH, IN_OUT_R3_P23_TASK,
    IN_OUT_R3_P24_MESH, IN_OUT_R3_P24_TASK, IN_OUT_R3_P25_MESH, IN_OUT_R3_P25_TASK, IN_OUT_R3_P26_MESH,
    IN_OUT_R3_P26_TASK, IN_OUT_R3_P27_MESH, IN_OUT_R3_P27_TASK, IN_OUT_R3_P28_MESH, IN_OUT_R3_P28_TASK,
    IN_OUT_R3_P29_MESH, IN_OUT_R3_P29_TASK, IN_OUT_R3_P30_MESH, IN_OUT_R3_P30_TASK, IN_OUT_R3_P31_MESH,
    IN_OUT_R3_P31_TASK, IN_OUT_R3_P32_MESH, IN_OUT_R3_P32_TASK, IN_OUT_R3_P33_MESH, IN_OUT_R3_P33_TASK,
    IN_OUT_R3_P34_MESH, IN_OUT_R3_P34_TASK, IN_OUT_R3_P35_MESH, IN_OUT_R3_P35_TASK, IN_OUT_R3_P36_MESH,
    IN_OUT_R3_P36_TASK, IN_OUT_R3_P37_MESH, IN_OUT_R3_P37_TASK, IN_OUT_R3_P38_MESH, IN_OUT_R3_P38_TASK,
    IN_OUT_R3_P39_MESH, IN_OUT_R3_P39_TASK, IN_OUT_R4_P0_MESH, IN_OUT_R4_P0_TASK, IN_OUT_R4_P1_MESH, IN_OUT_R4_P1_TASK,
    IN_OUT_R4_P2_MESH, IN_OUT_R4_P2_TASK, IN_OUT_R4_P3_MESH, IN_OUT_R4_P3_TASK, IN_OUT_R4_P4_MESH, IN_OUT_R4_P4_TASK,
    IN_OUT_R4_P5_MESH, IN_OUT_R4_P5_TASK, IN_OUT_R4_P6_MESH, IN_OUT_R4_P6_TASK, IN_OUT_R4_P7_MESH, IN_OUT_R4_P7_TASK,
    IN_OUT_R4_P8_MESH, IN_OUT_R4_P8_TASK, IN_OUT_R4_P9_MESH, IN_OUT_R4_P9_TASK, IN_OUT_R4_P10_MESH, IN_OUT_R4_P10_TASK,
    IN_OUT_R4_P11_MESH, IN_OUT_R4_P11_TASK, IN_OUT_R4_P12_MESH, IN_OUT_R4_P12_TASK, IN_OUT_R4_P13_MESH,
    IN_OUT_R4_P13_TASK, IN_OUT_R4_P14_MESH, IN_OUT_R4_P14_TASK, IN_OUT_R4_P15_MESH, IN_OUT_R4_P15_TASK,
    IN_OUT_R4_P16_MESH, IN_OUT_R4_P16_TASK, IN_OUT_R4_P17_MESH, IN_OUT_R4_P17_TASK, IN_OUT_R4_P18_MESH,
    IN_OUT_R4_P18_TASK, IN_OUT_R4_P19_MESH, IN_OUT_R4_P19_TASK, IN_OUT_R4_P20_MESH, IN_OUT_R4_P20_TASK,
    IN_OUT_R4_P21_MESH, IN_OUT_R4_P21_TASK, IN_OUT_R4_P22_MESH, IN_OUT_R4_P22_TASK, IN_OUT_R4_P23_MESH,
    IN_OUT_R4_P23_TASK, IN_OUT_R4_P24_MESH, IN_OUT_R4_P24_TASK, IN_OUT_R4_P25_MESH, IN_OUT_R4_P25_TASK,
    IN_OUT_R4_P26_MESH, IN_OUT_R4_P26_TASK, IN_OUT_R4_P27_MESH, IN_OUT_R4_P27_TASK, IN_OUT_R4_P28_MESH,
    IN_OUT_R4_P28_TASK, IN_OUT_R4_P29_MESH, IN_OUT_R4_P29_TASK, IN_OUT_R4_P30_MESH, IN_OUT_R4_P30_TASK,
    IN_OUT_R4_P31_MESH, IN_OUT_R4_P31_TASK, IN_OUT_R4_P32_MESH, IN_OUT_R4_P32_TASK, IN_OUT_R4_P33_MESH,
    IN_OUT_R4_P33_TASK, IN_OUT_R4_P34_MESH, IN_OUT_R4_P34_TASK, IN_OUT_R4_P35_MESH, IN_OUT_R4_P35_TASK,
    IN_OUT_R4_P36_MESH, IN_OUT_R4_P36_TASK, IN_OUT_R4_P37_MESH, IN_OUT_R4_P37_TASK, IN_OUT_R4_P38_MESH,
    IN_OUT_R4_P38_TASK, IN_OUT_R4_P39_MESH, IN_OUT_R4_P39_TASK, IN_OUT_R5_P0_MESH, IN_OUT_R5_P0_TASK,
    IN_OUT_R5_P1_MESH, IN_OUT_R5_P1_TASK, IN_OUT_R5_P2_MESH, IN_OUT_R5_P2_TASK, IN_OUT_R5_P3_MESH, IN_OUT_R5_P3_TASK,
    IN_OUT_R5_P4_MESH, IN_OUT_R5_P4_TASK, IN_OUT_R5_P5_MESH, IN_OUT_R5_P5_TASK, IN_OUT_R5_P6_MESH, IN_OUT_R5_P6_TASK,
    IN_OUT_R5_P7_MESH, IN_OUT_R5_P7_TASK, IN_OUT_R5_P8_MESH, IN_OUT_R5_P8_TASK, IN_OUT_R5_P9_MESH, IN_OUT_R5_P9_TASK,
    IN_OUT_R5_P10_MESH, IN_OUT_R5_P10_TASK, IN_OUT_R5_P11_MESH, IN_OUT_R5_P11_TASK, IN_OUT_R5_P12_MESH,
    IN_OUT_R5_P12_TASK, IN_OUT_R5_P13_MESH, IN_OUT_R5_P13_TASK, IN_OUT_R5_P14_MESH, IN_OUT_R5_P14_TASK,
    IN_OUT_R5_P15_MESH, IN_OUT_R5_P15_TASK, IN_OUT_R5_P16_MESH, IN_OUT_R5_P16_TASK, IN_OUT_R5_P17_MESH,
    IN_OUT_R5_P17_TASK, IN_OUT_R5_P18_MESH, IN_OUT_R5_P18_TASK, IN_OUT_R5_P19_MESH, IN_OUT_R5_P19_TASK,
    IN_OUT_R5_P20_MESH, IN_OUT_R5_P20_TASK, IN_OUT_R5_P21_MESH, IN_OUT_R5_P21_TASK, IN_OUT_R5_P22_MESH,
    IN_OUT_R5_P22_TASK, IN_OUT_R5_P23_MESH, IN_OUT_R5_P23_TASK, IN_OUT_R5_P24_MESH, IN_OUT_R5_P24_TASK,
    IN_OUT_R5_P25_MESH, IN_OUT_R5_P25_TASK, IN_OUT_R5_P26_MESH, IN_OUT_R5_P26_TASK, IN_OUT_R5_P27_MESH,
    IN_OUT_R5_P27_TASK, IN_OUT_R5_P28_MESH, IN_OUT_R5_P28_TASK, IN_OUT_R5_P29_MESH, IN_OUT_R5_P29_TASK,
    IN_OUT_R5_P30_MESH, IN_OUT_R5_P30_TASK, IN_OUT_R5_P31_MESH, IN_OUT_R5_P31_TASK, IN_OUT_R5_P32_MESH,
    IN_OUT_R5_P32_TASK, IN_OUT_R5_P33_MESH, IN_OUT_R5_P33_TASK, IN_OUT_R5_P34_MESH, IN_OUT_R5_P34_TASK,
    IN_OUT_R5_P35_MESH, IN_OUT_R5_P35_TASK, IN_OUT_R5_P36_MESH, IN_OUT_R5_P36_TASK, IN_OUT_R5_P37_MESH,
    IN_OUT_R5_P37_TASK, IN_OUT_R5_P38_MESH, IN_OUT_R5_P38_TASK, IN_OUT_R5_P39_MESH, IN_OUT_R5_P39_TASK,
    IN_OUT_R6_P0_MESH, IN_OUT_R6_P0_TASK, IN_OUT_R6_P1_MESH, IN_OUT_R6_P1_TASK, IN_OUT_R6_P2_MESH, IN_OUT_R6_P2_TASK,
    IN_OUT_R6_P3_MESH, IN_OUT_R6_P3_TASK, IN_OUT_R6_P4_MESH, IN_OUT_R6_P4_TASK, IN_OUT_R6_P5_MESH, IN_OUT_R6_P5_TASK,
    IN_OUT_R6_P6_MESH, IN_OUT_R6_P6_TASK, IN_OUT_R6_P7_MESH, IN_OUT_R6_P7_TASK, IN_OUT_R6_P8_MESH, IN_OUT_R6_P8_TASK,
    IN_OUT_R6_P9_MESH, IN_OUT_R6_P9_TASK, IN_OUT_R6_P10_MESH, IN_OUT_R6_P10_TASK, IN_OUT_R6_P11_MESH,
    IN_OUT_R6_P11_TASK, IN_OUT_R6_P12_MESH, IN_OUT_R6_P12_TASK, IN_OUT_R6_P13_MESH, IN_OUT_R6_P13_TASK,
    IN_OUT_R6_P14_MESH, IN_OUT_R6_P14_TASK, IN_OUT_R6_P15_MESH, IN_OUT_R6_P15_TASK, IN_OUT_R6_P16_MESH,
    IN_OUT_R6_P16_TASK, IN_OUT_R6_P17_MESH, IN_OUT_R6_P17_TASK, IN_OUT_R6_P18_MESH, IN_OUT_R6_P18_TASK,
    IN_OUT_R6_P19_MESH, IN_OUT_R6_P19_TASK, IN_OUT_R6_P20_MESH, IN_OUT_R6_P20_TASK, IN_OUT_R6_P21_MESH,
    IN_OUT_R6_P21_TASK, IN_OUT_R6_P22_MESH, IN_OUT_R6_P22_TASK, IN_OUT_R6_P23_MESH, IN_OUT_R6_P23_TASK,
    IN_OUT_R6_P24_MESH, IN_OUT_R6_P24_TASK, IN_OUT_R6_P25_MESH, IN_OUT_R6_P25_TASK, IN_OUT_R6_P26_MESH,
    IN_OUT_R6_P26_TASK, IN_OUT_R6_P27_MESH, IN_OUT_R6_P27_TASK, IN_OUT_R6_P28_MESH, IN_OUT_R6_P28_TASK,
    IN_OUT_R6_P29_MESH, IN_OUT_R6_P29_TASK, IN_OUT_R6_P30_MESH, IN_OUT_R6_P30_TASK, IN_OUT_R6_P31_MESH,
    IN_OUT_R6_P31_TASK, IN_OUT_R6_P32_MESH, IN_OUT_R6_P32_TASK, IN_OUT_R6_P33_MESH, IN_OUT_R6_P33_TASK,
    IN_OUT_R6_P34_MESH, IN_OUT_R6_P34_TASK, IN_OUT_R6_P35_MESH, IN_OUT_R6_P35_TASK, IN_OUT_R6_P36_MESH,
    IN_OUT_R6_P36_TASK, IN_OUT_R6_P37_MESH, IN_OUT_R6_P37_TASK, IN_OUT_R6_P38_MESH, IN_OUT_R6_P38_TASK,
    IN_OUT_R6_P39_MESH, IN_OUT_R6_P39_TASK,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::obj_util::{
    allocate_command_buffer, make_command_pool, make_descriptor_buffer_info, make_descriptor_set, make_framebuffer,
    make_pipeline_layout, make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, ImageWithBuffer, clear_value_color, create_draw_pipeline, rect_2d, viewport,
};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::tests::mesh_shader::util::{check_task_mesh_shader_support_ext, mesh_shader_properties};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const GLSLANG_BUILT_IN_COUNT: u32 = 4;
const MAX_LOCATIONS: u32 = 16;
const NUM_VERTICES: usize = 4;
const NUM_PRIMITIVES: usize = 2;

#[derive(Clone, Copy)]
struct Requirements {
    i64: bool,
    f64: bool,
    i16: bool,
    f16: bool,
    name: &'static str,
}

const REQUIRED_FEATURES: [Requirements; 7] = [
    // Restrict the number of combinations to avoid creating too many tests.
    Requirements {
        i64: false,
        f64: false,
        i16: false,
        f16: false,
        name: "32_bits_only",
    },
    Requirements {
        i64: true,
        f64: false,
        i16: false,
        f16: false,
        name: "with_i64",
    },
    Requirements {
        i64: false,
        f64: true,
        i16: false,
        f16: false,
        name: "with_f64",
    },
    Requirements {
        i64: true,
        f64: true,
        i16: false,
        f16: false,
        name: "all_but_16_bits",
    },
    Requirements {
        i64: false,
        f64: false,
        i16: true,
        f16: false,
        name: "with_i16",
    },
    Requirements {
        i64: false,
        f64: false,
        i16: false,
        f16: true,
        name: "with_f16",
    },
    Requirements {
        i64: true,
        f64: true,
        i16: true,
        f16: true,
        name: "all_types",
    },
];

const PERMUTATIONS: u32 = 40;

struct InterfaceVariablesCase {
    name: String,
    requirements: Requirements,
    requirements_index: u32,
    permutation: u32,
    use_task_shader: bool,
}

impl TestCase for InterfaceVariablesCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `InterfaceVariablesCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let reqs = self.requirements;
        check_task_mesh_shader_support_ext(context, self.use_task_shader, true)?;

        let features = context.get_device_features();
        if reqs.f64 && features.shader_float64 == vk::FALSE {
            return Err(TestError::NotSupported(
                "Requested core feature is not supported: shaderFloat64".to_string(),
            ));
        }
        if reqs.i64 && features.shader_int64 == vk::FALSE {
            return Err(TestError::NotSupported(
                "Requested core feature is not supported: shaderInt64".to_string(),
            ));
        }
        if reqs.i16 && features.shader_int16 == vk::FALSE {
            return Err(TestError::NotSupported(
                "Requested core feature is not supported: shaderInt16".to_string(),
            ));
        }

        if reqs.f16 {
            let mut float16_int8_features = vk::PhysicalDeviceShaderFloat16Int8Features::default();
            {
                let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut float16_int8_features);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_features2(context.get_physical_device(), &mut features2)
                };
            }
            if float16_int8_features.shader_float16 == vk::FALSE {
                return Err(TestError::NotSupported(
                    "shaderFloat16 feature not supported".to_string(),
                ));
            }
        }

        if reqs.i16 || reqs.f16 {
            let mut storage_features = vk::PhysicalDevice16BitStorageFeatures::default();
            {
                let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut storage_features);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_features2(context.get_physical_device(), &mut features2)
                };
            }
            if storage_features.storage_input_output16 == vk::FALSE {
                return Err(TestError::NotSupported(
                    "storageInputOutput16 feature not supported".to_string(),
                ));
            }
        }

        // glslang will use several built-ins in the generated mesh code, which count against the location and component limits.
        // Making this a failure since the minimum maxMeshOutputComponents is 128, which should allow us to use 32 locations and we use
        // only 16 plus a few built-ins.
        let needed_components = (GLSLANG_BUILT_IN_COUNT + MAX_LOCATIONS) * 4;
        if needed_components > mesh_shader_properties(context).max_mesh_output_components {
            return Err(TestError::Fail(
                "maxMeshOutputComponents too low to run this test".to_string(),
            ));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match (self.requirements_index, self.permutation, self.use_task_shader) {
            (0, 0, false) => IN_OUT_R0_P0_MESH.programs,
            (0, 0, true) => IN_OUT_R0_P0_TASK.programs,
            (0, 1, false) => IN_OUT_R0_P1_MESH.programs,
            (0, 1, true) => IN_OUT_R0_P1_TASK.programs,
            (0, 2, false) => IN_OUT_R0_P2_MESH.programs,
            (0, 2, true) => IN_OUT_R0_P2_TASK.programs,
            (0, 3, false) => IN_OUT_R0_P3_MESH.programs,
            (0, 3, true) => IN_OUT_R0_P3_TASK.programs,
            (0, 4, false) => IN_OUT_R0_P4_MESH.programs,
            (0, 4, true) => IN_OUT_R0_P4_TASK.programs,
            (0, 5, false) => IN_OUT_R0_P5_MESH.programs,
            (0, 5, true) => IN_OUT_R0_P5_TASK.programs,
            (0, 6, false) => IN_OUT_R0_P6_MESH.programs,
            (0, 6, true) => IN_OUT_R0_P6_TASK.programs,
            (0, 7, false) => IN_OUT_R0_P7_MESH.programs,
            (0, 7, true) => IN_OUT_R0_P7_TASK.programs,
            (0, 8, false) => IN_OUT_R0_P8_MESH.programs,
            (0, 8, true) => IN_OUT_R0_P8_TASK.programs,
            (0, 9, false) => IN_OUT_R0_P9_MESH.programs,
            (0, 9, true) => IN_OUT_R0_P9_TASK.programs,
            (0, 10, false) => IN_OUT_R0_P10_MESH.programs,
            (0, 10, true) => IN_OUT_R0_P10_TASK.programs,
            (0, 11, false) => IN_OUT_R0_P11_MESH.programs,
            (0, 11, true) => IN_OUT_R0_P11_TASK.programs,
            (0, 12, false) => IN_OUT_R0_P12_MESH.programs,
            (0, 12, true) => IN_OUT_R0_P12_TASK.programs,
            (0, 13, false) => IN_OUT_R0_P13_MESH.programs,
            (0, 13, true) => IN_OUT_R0_P13_TASK.programs,
            (0, 14, false) => IN_OUT_R0_P14_MESH.programs,
            (0, 14, true) => IN_OUT_R0_P14_TASK.programs,
            (0, 15, false) => IN_OUT_R0_P15_MESH.programs,
            (0, 15, true) => IN_OUT_R0_P15_TASK.programs,
            (0, 16, false) => IN_OUT_R0_P16_MESH.programs,
            (0, 16, true) => IN_OUT_R0_P16_TASK.programs,
            (0, 17, false) => IN_OUT_R0_P17_MESH.programs,
            (0, 17, true) => IN_OUT_R0_P17_TASK.programs,
            (0, 18, false) => IN_OUT_R0_P18_MESH.programs,
            (0, 18, true) => IN_OUT_R0_P18_TASK.programs,
            (0, 19, false) => IN_OUT_R0_P19_MESH.programs,
            (0, 19, true) => IN_OUT_R0_P19_TASK.programs,
            (0, 20, false) => IN_OUT_R0_P20_MESH.programs,
            (0, 20, true) => IN_OUT_R0_P20_TASK.programs,
            (0, 21, false) => IN_OUT_R0_P21_MESH.programs,
            (0, 21, true) => IN_OUT_R0_P21_TASK.programs,
            (0, 22, false) => IN_OUT_R0_P22_MESH.programs,
            (0, 22, true) => IN_OUT_R0_P22_TASK.programs,
            (0, 23, false) => IN_OUT_R0_P23_MESH.programs,
            (0, 23, true) => IN_OUT_R0_P23_TASK.programs,
            (0, 24, false) => IN_OUT_R0_P24_MESH.programs,
            (0, 24, true) => IN_OUT_R0_P24_TASK.programs,
            (0, 25, false) => IN_OUT_R0_P25_MESH.programs,
            (0, 25, true) => IN_OUT_R0_P25_TASK.programs,
            (0, 26, false) => IN_OUT_R0_P26_MESH.programs,
            (0, 26, true) => IN_OUT_R0_P26_TASK.programs,
            (0, 27, false) => IN_OUT_R0_P27_MESH.programs,
            (0, 27, true) => IN_OUT_R0_P27_TASK.programs,
            (0, 28, false) => IN_OUT_R0_P28_MESH.programs,
            (0, 28, true) => IN_OUT_R0_P28_TASK.programs,
            (0, 29, false) => IN_OUT_R0_P29_MESH.programs,
            (0, 29, true) => IN_OUT_R0_P29_TASK.programs,
            (0, 30, false) => IN_OUT_R0_P30_MESH.programs,
            (0, 30, true) => IN_OUT_R0_P30_TASK.programs,
            (0, 31, false) => IN_OUT_R0_P31_MESH.programs,
            (0, 31, true) => IN_OUT_R0_P31_TASK.programs,
            (0, 32, false) => IN_OUT_R0_P32_MESH.programs,
            (0, 32, true) => IN_OUT_R0_P32_TASK.programs,
            (0, 33, false) => IN_OUT_R0_P33_MESH.programs,
            (0, 33, true) => IN_OUT_R0_P33_TASK.programs,
            (0, 34, false) => IN_OUT_R0_P34_MESH.programs,
            (0, 34, true) => IN_OUT_R0_P34_TASK.programs,
            (0, 35, false) => IN_OUT_R0_P35_MESH.programs,
            (0, 35, true) => IN_OUT_R0_P35_TASK.programs,
            (0, 36, false) => IN_OUT_R0_P36_MESH.programs,
            (0, 36, true) => IN_OUT_R0_P36_TASK.programs,
            (0, 37, false) => IN_OUT_R0_P37_MESH.programs,
            (0, 37, true) => IN_OUT_R0_P37_TASK.programs,
            (0, 38, false) => IN_OUT_R0_P38_MESH.programs,
            (0, 38, true) => IN_OUT_R0_P38_TASK.programs,
            (0, 39, false) => IN_OUT_R0_P39_MESH.programs,
            (0, 39, true) => IN_OUT_R0_P39_TASK.programs,
            (1, 0, false) => IN_OUT_R1_P0_MESH.programs,
            (1, 0, true) => IN_OUT_R1_P0_TASK.programs,
            (1, 1, false) => IN_OUT_R1_P1_MESH.programs,
            (1, 1, true) => IN_OUT_R1_P1_TASK.programs,
            (1, 2, false) => IN_OUT_R1_P2_MESH.programs,
            (1, 2, true) => IN_OUT_R1_P2_TASK.programs,
            (1, 3, false) => IN_OUT_R1_P3_MESH.programs,
            (1, 3, true) => IN_OUT_R1_P3_TASK.programs,
            (1, 4, false) => IN_OUT_R1_P4_MESH.programs,
            (1, 4, true) => IN_OUT_R1_P4_TASK.programs,
            (1, 5, false) => IN_OUT_R1_P5_MESH.programs,
            (1, 5, true) => IN_OUT_R1_P5_TASK.programs,
            (1, 6, false) => IN_OUT_R1_P6_MESH.programs,
            (1, 6, true) => IN_OUT_R1_P6_TASK.programs,
            (1, 7, false) => IN_OUT_R1_P7_MESH.programs,
            (1, 7, true) => IN_OUT_R1_P7_TASK.programs,
            (1, 8, false) => IN_OUT_R1_P8_MESH.programs,
            (1, 8, true) => IN_OUT_R1_P8_TASK.programs,
            (1, 9, false) => IN_OUT_R1_P9_MESH.programs,
            (1, 9, true) => IN_OUT_R1_P9_TASK.programs,
            (1, 10, false) => IN_OUT_R1_P10_MESH.programs,
            (1, 10, true) => IN_OUT_R1_P10_TASK.programs,
            (1, 11, false) => IN_OUT_R1_P11_MESH.programs,
            (1, 11, true) => IN_OUT_R1_P11_TASK.programs,
            (1, 12, false) => IN_OUT_R1_P12_MESH.programs,
            (1, 12, true) => IN_OUT_R1_P12_TASK.programs,
            (1, 13, false) => IN_OUT_R1_P13_MESH.programs,
            (1, 13, true) => IN_OUT_R1_P13_TASK.programs,
            (1, 14, false) => IN_OUT_R1_P14_MESH.programs,
            (1, 14, true) => IN_OUT_R1_P14_TASK.programs,
            (1, 15, false) => IN_OUT_R1_P15_MESH.programs,
            (1, 15, true) => IN_OUT_R1_P15_TASK.programs,
            (1, 16, false) => IN_OUT_R1_P16_MESH.programs,
            (1, 16, true) => IN_OUT_R1_P16_TASK.programs,
            (1, 17, false) => IN_OUT_R1_P17_MESH.programs,
            (1, 17, true) => IN_OUT_R1_P17_TASK.programs,
            (1, 18, false) => IN_OUT_R1_P18_MESH.programs,
            (1, 18, true) => IN_OUT_R1_P18_TASK.programs,
            (1, 19, false) => IN_OUT_R1_P19_MESH.programs,
            (1, 19, true) => IN_OUT_R1_P19_TASK.programs,
            (1, 20, false) => IN_OUT_R1_P20_MESH.programs,
            (1, 20, true) => IN_OUT_R1_P20_TASK.programs,
            (1, 21, false) => IN_OUT_R1_P21_MESH.programs,
            (1, 21, true) => IN_OUT_R1_P21_TASK.programs,
            (1, 22, false) => IN_OUT_R1_P22_MESH.programs,
            (1, 22, true) => IN_OUT_R1_P22_TASK.programs,
            (1, 23, false) => IN_OUT_R1_P23_MESH.programs,
            (1, 23, true) => IN_OUT_R1_P23_TASK.programs,
            (1, 24, false) => IN_OUT_R1_P24_MESH.programs,
            (1, 24, true) => IN_OUT_R1_P24_TASK.programs,
            (1, 25, false) => IN_OUT_R1_P25_MESH.programs,
            (1, 25, true) => IN_OUT_R1_P25_TASK.programs,
            (1, 26, false) => IN_OUT_R1_P26_MESH.programs,
            (1, 26, true) => IN_OUT_R1_P26_TASK.programs,
            (1, 27, false) => IN_OUT_R1_P27_MESH.programs,
            (1, 27, true) => IN_OUT_R1_P27_TASK.programs,
            (1, 28, false) => IN_OUT_R1_P28_MESH.programs,
            (1, 28, true) => IN_OUT_R1_P28_TASK.programs,
            (1, 29, false) => IN_OUT_R1_P29_MESH.programs,
            (1, 29, true) => IN_OUT_R1_P29_TASK.programs,
            (1, 30, false) => IN_OUT_R1_P30_MESH.programs,
            (1, 30, true) => IN_OUT_R1_P30_TASK.programs,
            (1, 31, false) => IN_OUT_R1_P31_MESH.programs,
            (1, 31, true) => IN_OUT_R1_P31_TASK.programs,
            (1, 32, false) => IN_OUT_R1_P32_MESH.programs,
            (1, 32, true) => IN_OUT_R1_P32_TASK.programs,
            (1, 33, false) => IN_OUT_R1_P33_MESH.programs,
            (1, 33, true) => IN_OUT_R1_P33_TASK.programs,
            (1, 34, false) => IN_OUT_R1_P34_MESH.programs,
            (1, 34, true) => IN_OUT_R1_P34_TASK.programs,
            (1, 35, false) => IN_OUT_R1_P35_MESH.programs,
            (1, 35, true) => IN_OUT_R1_P35_TASK.programs,
            (1, 36, false) => IN_OUT_R1_P36_MESH.programs,
            (1, 36, true) => IN_OUT_R1_P36_TASK.programs,
            (1, 37, false) => IN_OUT_R1_P37_MESH.programs,
            (1, 37, true) => IN_OUT_R1_P37_TASK.programs,
            (1, 38, false) => IN_OUT_R1_P38_MESH.programs,
            (1, 38, true) => IN_OUT_R1_P38_TASK.programs,
            (1, 39, false) => IN_OUT_R1_P39_MESH.programs,
            (1, 39, true) => IN_OUT_R1_P39_TASK.programs,
            (2, 0, false) => IN_OUT_R2_P0_MESH.programs,
            (2, 0, true) => IN_OUT_R2_P0_TASK.programs,
            (2, 1, false) => IN_OUT_R2_P1_MESH.programs,
            (2, 1, true) => IN_OUT_R2_P1_TASK.programs,
            (2, 2, false) => IN_OUT_R2_P2_MESH.programs,
            (2, 2, true) => IN_OUT_R2_P2_TASK.programs,
            (2, 3, false) => IN_OUT_R2_P3_MESH.programs,
            (2, 3, true) => IN_OUT_R2_P3_TASK.programs,
            (2, 4, false) => IN_OUT_R2_P4_MESH.programs,
            (2, 4, true) => IN_OUT_R2_P4_TASK.programs,
            (2, 5, false) => IN_OUT_R2_P5_MESH.programs,
            (2, 5, true) => IN_OUT_R2_P5_TASK.programs,
            (2, 6, false) => IN_OUT_R2_P6_MESH.programs,
            (2, 6, true) => IN_OUT_R2_P6_TASK.programs,
            (2, 7, false) => IN_OUT_R2_P7_MESH.programs,
            (2, 7, true) => IN_OUT_R2_P7_TASK.programs,
            (2, 8, false) => IN_OUT_R2_P8_MESH.programs,
            (2, 8, true) => IN_OUT_R2_P8_TASK.programs,
            (2, 9, false) => IN_OUT_R2_P9_MESH.programs,
            (2, 9, true) => IN_OUT_R2_P9_TASK.programs,
            (2, 10, false) => IN_OUT_R2_P10_MESH.programs,
            (2, 10, true) => IN_OUT_R2_P10_TASK.programs,
            (2, 11, false) => IN_OUT_R2_P11_MESH.programs,
            (2, 11, true) => IN_OUT_R2_P11_TASK.programs,
            (2, 12, false) => IN_OUT_R2_P12_MESH.programs,
            (2, 12, true) => IN_OUT_R2_P12_TASK.programs,
            (2, 13, false) => IN_OUT_R2_P13_MESH.programs,
            (2, 13, true) => IN_OUT_R2_P13_TASK.programs,
            (2, 14, false) => IN_OUT_R2_P14_MESH.programs,
            (2, 14, true) => IN_OUT_R2_P14_TASK.programs,
            (2, 15, false) => IN_OUT_R2_P15_MESH.programs,
            (2, 15, true) => IN_OUT_R2_P15_TASK.programs,
            (2, 16, false) => IN_OUT_R2_P16_MESH.programs,
            (2, 16, true) => IN_OUT_R2_P16_TASK.programs,
            (2, 17, false) => IN_OUT_R2_P17_MESH.programs,
            (2, 17, true) => IN_OUT_R2_P17_TASK.programs,
            (2, 18, false) => IN_OUT_R2_P18_MESH.programs,
            (2, 18, true) => IN_OUT_R2_P18_TASK.programs,
            (2, 19, false) => IN_OUT_R2_P19_MESH.programs,
            (2, 19, true) => IN_OUT_R2_P19_TASK.programs,
            (2, 20, false) => IN_OUT_R2_P20_MESH.programs,
            (2, 20, true) => IN_OUT_R2_P20_TASK.programs,
            (2, 21, false) => IN_OUT_R2_P21_MESH.programs,
            (2, 21, true) => IN_OUT_R2_P21_TASK.programs,
            (2, 22, false) => IN_OUT_R2_P22_MESH.programs,
            (2, 22, true) => IN_OUT_R2_P22_TASK.programs,
            (2, 23, false) => IN_OUT_R2_P23_MESH.programs,
            (2, 23, true) => IN_OUT_R2_P23_TASK.programs,
            (2, 24, false) => IN_OUT_R2_P24_MESH.programs,
            (2, 24, true) => IN_OUT_R2_P24_TASK.programs,
            (2, 25, false) => IN_OUT_R2_P25_MESH.programs,
            (2, 25, true) => IN_OUT_R2_P25_TASK.programs,
            (2, 26, false) => IN_OUT_R2_P26_MESH.programs,
            (2, 26, true) => IN_OUT_R2_P26_TASK.programs,
            (2, 27, false) => IN_OUT_R2_P27_MESH.programs,
            (2, 27, true) => IN_OUT_R2_P27_TASK.programs,
            (2, 28, false) => IN_OUT_R2_P28_MESH.programs,
            (2, 28, true) => IN_OUT_R2_P28_TASK.programs,
            (2, 29, false) => IN_OUT_R2_P29_MESH.programs,
            (2, 29, true) => IN_OUT_R2_P29_TASK.programs,
            (2, 30, false) => IN_OUT_R2_P30_MESH.programs,
            (2, 30, true) => IN_OUT_R2_P30_TASK.programs,
            (2, 31, false) => IN_OUT_R2_P31_MESH.programs,
            (2, 31, true) => IN_OUT_R2_P31_TASK.programs,
            (2, 32, false) => IN_OUT_R2_P32_MESH.programs,
            (2, 32, true) => IN_OUT_R2_P32_TASK.programs,
            (2, 33, false) => IN_OUT_R2_P33_MESH.programs,
            (2, 33, true) => IN_OUT_R2_P33_TASK.programs,
            (2, 34, false) => IN_OUT_R2_P34_MESH.programs,
            (2, 34, true) => IN_OUT_R2_P34_TASK.programs,
            (2, 35, false) => IN_OUT_R2_P35_MESH.programs,
            (2, 35, true) => IN_OUT_R2_P35_TASK.programs,
            (2, 36, false) => IN_OUT_R2_P36_MESH.programs,
            (2, 36, true) => IN_OUT_R2_P36_TASK.programs,
            (2, 37, false) => IN_OUT_R2_P37_MESH.programs,
            (2, 37, true) => IN_OUT_R2_P37_TASK.programs,
            (2, 38, false) => IN_OUT_R2_P38_MESH.programs,
            (2, 38, true) => IN_OUT_R2_P38_TASK.programs,
            (2, 39, false) => IN_OUT_R2_P39_MESH.programs,
            (2, 39, true) => IN_OUT_R2_P39_TASK.programs,
            (3, 0, false) => IN_OUT_R3_P0_MESH.programs,
            (3, 0, true) => IN_OUT_R3_P0_TASK.programs,
            (3, 1, false) => IN_OUT_R3_P1_MESH.programs,
            (3, 1, true) => IN_OUT_R3_P1_TASK.programs,
            (3, 2, false) => IN_OUT_R3_P2_MESH.programs,
            (3, 2, true) => IN_OUT_R3_P2_TASK.programs,
            (3, 3, false) => IN_OUT_R3_P3_MESH.programs,
            (3, 3, true) => IN_OUT_R3_P3_TASK.programs,
            (3, 4, false) => IN_OUT_R3_P4_MESH.programs,
            (3, 4, true) => IN_OUT_R3_P4_TASK.programs,
            (3, 5, false) => IN_OUT_R3_P5_MESH.programs,
            (3, 5, true) => IN_OUT_R3_P5_TASK.programs,
            (3, 6, false) => IN_OUT_R3_P6_MESH.programs,
            (3, 6, true) => IN_OUT_R3_P6_TASK.programs,
            (3, 7, false) => IN_OUT_R3_P7_MESH.programs,
            (3, 7, true) => IN_OUT_R3_P7_TASK.programs,
            (3, 8, false) => IN_OUT_R3_P8_MESH.programs,
            (3, 8, true) => IN_OUT_R3_P8_TASK.programs,
            (3, 9, false) => IN_OUT_R3_P9_MESH.programs,
            (3, 9, true) => IN_OUT_R3_P9_TASK.programs,
            (3, 10, false) => IN_OUT_R3_P10_MESH.programs,
            (3, 10, true) => IN_OUT_R3_P10_TASK.programs,
            (3, 11, false) => IN_OUT_R3_P11_MESH.programs,
            (3, 11, true) => IN_OUT_R3_P11_TASK.programs,
            (3, 12, false) => IN_OUT_R3_P12_MESH.programs,
            (3, 12, true) => IN_OUT_R3_P12_TASK.programs,
            (3, 13, false) => IN_OUT_R3_P13_MESH.programs,
            (3, 13, true) => IN_OUT_R3_P13_TASK.programs,
            (3, 14, false) => IN_OUT_R3_P14_MESH.programs,
            (3, 14, true) => IN_OUT_R3_P14_TASK.programs,
            (3, 15, false) => IN_OUT_R3_P15_MESH.programs,
            (3, 15, true) => IN_OUT_R3_P15_TASK.programs,
            (3, 16, false) => IN_OUT_R3_P16_MESH.programs,
            (3, 16, true) => IN_OUT_R3_P16_TASK.programs,
            (3, 17, false) => IN_OUT_R3_P17_MESH.programs,
            (3, 17, true) => IN_OUT_R3_P17_TASK.programs,
            (3, 18, false) => IN_OUT_R3_P18_MESH.programs,
            (3, 18, true) => IN_OUT_R3_P18_TASK.programs,
            (3, 19, false) => IN_OUT_R3_P19_MESH.programs,
            (3, 19, true) => IN_OUT_R3_P19_TASK.programs,
            (3, 20, false) => IN_OUT_R3_P20_MESH.programs,
            (3, 20, true) => IN_OUT_R3_P20_TASK.programs,
            (3, 21, false) => IN_OUT_R3_P21_MESH.programs,
            (3, 21, true) => IN_OUT_R3_P21_TASK.programs,
            (3, 22, false) => IN_OUT_R3_P22_MESH.programs,
            (3, 22, true) => IN_OUT_R3_P22_TASK.programs,
            (3, 23, false) => IN_OUT_R3_P23_MESH.programs,
            (3, 23, true) => IN_OUT_R3_P23_TASK.programs,
            (3, 24, false) => IN_OUT_R3_P24_MESH.programs,
            (3, 24, true) => IN_OUT_R3_P24_TASK.programs,
            (3, 25, false) => IN_OUT_R3_P25_MESH.programs,
            (3, 25, true) => IN_OUT_R3_P25_TASK.programs,
            (3, 26, false) => IN_OUT_R3_P26_MESH.programs,
            (3, 26, true) => IN_OUT_R3_P26_TASK.programs,
            (3, 27, false) => IN_OUT_R3_P27_MESH.programs,
            (3, 27, true) => IN_OUT_R3_P27_TASK.programs,
            (3, 28, false) => IN_OUT_R3_P28_MESH.programs,
            (3, 28, true) => IN_OUT_R3_P28_TASK.programs,
            (3, 29, false) => IN_OUT_R3_P29_MESH.programs,
            (3, 29, true) => IN_OUT_R3_P29_TASK.programs,
            (3, 30, false) => IN_OUT_R3_P30_MESH.programs,
            (3, 30, true) => IN_OUT_R3_P30_TASK.programs,
            (3, 31, false) => IN_OUT_R3_P31_MESH.programs,
            (3, 31, true) => IN_OUT_R3_P31_TASK.programs,
            (3, 32, false) => IN_OUT_R3_P32_MESH.programs,
            (3, 32, true) => IN_OUT_R3_P32_TASK.programs,
            (3, 33, false) => IN_OUT_R3_P33_MESH.programs,
            (3, 33, true) => IN_OUT_R3_P33_TASK.programs,
            (3, 34, false) => IN_OUT_R3_P34_MESH.programs,
            (3, 34, true) => IN_OUT_R3_P34_TASK.programs,
            (3, 35, false) => IN_OUT_R3_P35_MESH.programs,
            (3, 35, true) => IN_OUT_R3_P35_TASK.programs,
            (3, 36, false) => IN_OUT_R3_P36_MESH.programs,
            (3, 36, true) => IN_OUT_R3_P36_TASK.programs,
            (3, 37, false) => IN_OUT_R3_P37_MESH.programs,
            (3, 37, true) => IN_OUT_R3_P37_TASK.programs,
            (3, 38, false) => IN_OUT_R3_P38_MESH.programs,
            (3, 38, true) => IN_OUT_R3_P38_TASK.programs,
            (3, 39, false) => IN_OUT_R3_P39_MESH.programs,
            (3, 39, true) => IN_OUT_R3_P39_TASK.programs,
            (4, 0, false) => IN_OUT_R4_P0_MESH.programs,
            (4, 0, true) => IN_OUT_R4_P0_TASK.programs,
            (4, 1, false) => IN_OUT_R4_P1_MESH.programs,
            (4, 1, true) => IN_OUT_R4_P1_TASK.programs,
            (4, 2, false) => IN_OUT_R4_P2_MESH.programs,
            (4, 2, true) => IN_OUT_R4_P2_TASK.programs,
            (4, 3, false) => IN_OUT_R4_P3_MESH.programs,
            (4, 3, true) => IN_OUT_R4_P3_TASK.programs,
            (4, 4, false) => IN_OUT_R4_P4_MESH.programs,
            (4, 4, true) => IN_OUT_R4_P4_TASK.programs,
            (4, 5, false) => IN_OUT_R4_P5_MESH.programs,
            (4, 5, true) => IN_OUT_R4_P5_TASK.programs,
            (4, 6, false) => IN_OUT_R4_P6_MESH.programs,
            (4, 6, true) => IN_OUT_R4_P6_TASK.programs,
            (4, 7, false) => IN_OUT_R4_P7_MESH.programs,
            (4, 7, true) => IN_OUT_R4_P7_TASK.programs,
            (4, 8, false) => IN_OUT_R4_P8_MESH.programs,
            (4, 8, true) => IN_OUT_R4_P8_TASK.programs,
            (4, 9, false) => IN_OUT_R4_P9_MESH.programs,
            (4, 9, true) => IN_OUT_R4_P9_TASK.programs,
            (4, 10, false) => IN_OUT_R4_P10_MESH.programs,
            (4, 10, true) => IN_OUT_R4_P10_TASK.programs,
            (4, 11, false) => IN_OUT_R4_P11_MESH.programs,
            (4, 11, true) => IN_OUT_R4_P11_TASK.programs,
            (4, 12, false) => IN_OUT_R4_P12_MESH.programs,
            (4, 12, true) => IN_OUT_R4_P12_TASK.programs,
            (4, 13, false) => IN_OUT_R4_P13_MESH.programs,
            (4, 13, true) => IN_OUT_R4_P13_TASK.programs,
            (4, 14, false) => IN_OUT_R4_P14_MESH.programs,
            (4, 14, true) => IN_OUT_R4_P14_TASK.programs,
            (4, 15, false) => IN_OUT_R4_P15_MESH.programs,
            (4, 15, true) => IN_OUT_R4_P15_TASK.programs,
            (4, 16, false) => IN_OUT_R4_P16_MESH.programs,
            (4, 16, true) => IN_OUT_R4_P16_TASK.programs,
            (4, 17, false) => IN_OUT_R4_P17_MESH.programs,
            (4, 17, true) => IN_OUT_R4_P17_TASK.programs,
            (4, 18, false) => IN_OUT_R4_P18_MESH.programs,
            (4, 18, true) => IN_OUT_R4_P18_TASK.programs,
            (4, 19, false) => IN_OUT_R4_P19_MESH.programs,
            (4, 19, true) => IN_OUT_R4_P19_TASK.programs,
            (4, 20, false) => IN_OUT_R4_P20_MESH.programs,
            (4, 20, true) => IN_OUT_R4_P20_TASK.programs,
            (4, 21, false) => IN_OUT_R4_P21_MESH.programs,
            (4, 21, true) => IN_OUT_R4_P21_TASK.programs,
            (4, 22, false) => IN_OUT_R4_P22_MESH.programs,
            (4, 22, true) => IN_OUT_R4_P22_TASK.programs,
            (4, 23, false) => IN_OUT_R4_P23_MESH.programs,
            (4, 23, true) => IN_OUT_R4_P23_TASK.programs,
            (4, 24, false) => IN_OUT_R4_P24_MESH.programs,
            (4, 24, true) => IN_OUT_R4_P24_TASK.programs,
            (4, 25, false) => IN_OUT_R4_P25_MESH.programs,
            (4, 25, true) => IN_OUT_R4_P25_TASK.programs,
            (4, 26, false) => IN_OUT_R4_P26_MESH.programs,
            (4, 26, true) => IN_OUT_R4_P26_TASK.programs,
            (4, 27, false) => IN_OUT_R4_P27_MESH.programs,
            (4, 27, true) => IN_OUT_R4_P27_TASK.programs,
            (4, 28, false) => IN_OUT_R4_P28_MESH.programs,
            (4, 28, true) => IN_OUT_R4_P28_TASK.programs,
            (4, 29, false) => IN_OUT_R4_P29_MESH.programs,
            (4, 29, true) => IN_OUT_R4_P29_TASK.programs,
            (4, 30, false) => IN_OUT_R4_P30_MESH.programs,
            (4, 30, true) => IN_OUT_R4_P30_TASK.programs,
            (4, 31, false) => IN_OUT_R4_P31_MESH.programs,
            (4, 31, true) => IN_OUT_R4_P31_TASK.programs,
            (4, 32, false) => IN_OUT_R4_P32_MESH.programs,
            (4, 32, true) => IN_OUT_R4_P32_TASK.programs,
            (4, 33, false) => IN_OUT_R4_P33_MESH.programs,
            (4, 33, true) => IN_OUT_R4_P33_TASK.programs,
            (4, 34, false) => IN_OUT_R4_P34_MESH.programs,
            (4, 34, true) => IN_OUT_R4_P34_TASK.programs,
            (4, 35, false) => IN_OUT_R4_P35_MESH.programs,
            (4, 35, true) => IN_OUT_R4_P35_TASK.programs,
            (4, 36, false) => IN_OUT_R4_P36_MESH.programs,
            (4, 36, true) => IN_OUT_R4_P36_TASK.programs,
            (4, 37, false) => IN_OUT_R4_P37_MESH.programs,
            (4, 37, true) => IN_OUT_R4_P37_TASK.programs,
            (4, 38, false) => IN_OUT_R4_P38_MESH.programs,
            (4, 38, true) => IN_OUT_R4_P38_TASK.programs,
            (4, 39, false) => IN_OUT_R4_P39_MESH.programs,
            (4, 39, true) => IN_OUT_R4_P39_TASK.programs,
            (5, 0, false) => IN_OUT_R5_P0_MESH.programs,
            (5, 0, true) => IN_OUT_R5_P0_TASK.programs,
            (5, 1, false) => IN_OUT_R5_P1_MESH.programs,
            (5, 1, true) => IN_OUT_R5_P1_TASK.programs,
            (5, 2, false) => IN_OUT_R5_P2_MESH.programs,
            (5, 2, true) => IN_OUT_R5_P2_TASK.programs,
            (5, 3, false) => IN_OUT_R5_P3_MESH.programs,
            (5, 3, true) => IN_OUT_R5_P3_TASK.programs,
            (5, 4, false) => IN_OUT_R5_P4_MESH.programs,
            (5, 4, true) => IN_OUT_R5_P4_TASK.programs,
            (5, 5, false) => IN_OUT_R5_P5_MESH.programs,
            (5, 5, true) => IN_OUT_R5_P5_TASK.programs,
            (5, 6, false) => IN_OUT_R5_P6_MESH.programs,
            (5, 6, true) => IN_OUT_R5_P6_TASK.programs,
            (5, 7, false) => IN_OUT_R5_P7_MESH.programs,
            (5, 7, true) => IN_OUT_R5_P7_TASK.programs,
            (5, 8, false) => IN_OUT_R5_P8_MESH.programs,
            (5, 8, true) => IN_OUT_R5_P8_TASK.programs,
            (5, 9, false) => IN_OUT_R5_P9_MESH.programs,
            (5, 9, true) => IN_OUT_R5_P9_TASK.programs,
            (5, 10, false) => IN_OUT_R5_P10_MESH.programs,
            (5, 10, true) => IN_OUT_R5_P10_TASK.programs,
            (5, 11, false) => IN_OUT_R5_P11_MESH.programs,
            (5, 11, true) => IN_OUT_R5_P11_TASK.programs,
            (5, 12, false) => IN_OUT_R5_P12_MESH.programs,
            (5, 12, true) => IN_OUT_R5_P12_TASK.programs,
            (5, 13, false) => IN_OUT_R5_P13_MESH.programs,
            (5, 13, true) => IN_OUT_R5_P13_TASK.programs,
            (5, 14, false) => IN_OUT_R5_P14_MESH.programs,
            (5, 14, true) => IN_OUT_R5_P14_TASK.programs,
            (5, 15, false) => IN_OUT_R5_P15_MESH.programs,
            (5, 15, true) => IN_OUT_R5_P15_TASK.programs,
            (5, 16, false) => IN_OUT_R5_P16_MESH.programs,
            (5, 16, true) => IN_OUT_R5_P16_TASK.programs,
            (5, 17, false) => IN_OUT_R5_P17_MESH.programs,
            (5, 17, true) => IN_OUT_R5_P17_TASK.programs,
            (5, 18, false) => IN_OUT_R5_P18_MESH.programs,
            (5, 18, true) => IN_OUT_R5_P18_TASK.programs,
            (5, 19, false) => IN_OUT_R5_P19_MESH.programs,
            (5, 19, true) => IN_OUT_R5_P19_TASK.programs,
            (5, 20, false) => IN_OUT_R5_P20_MESH.programs,
            (5, 20, true) => IN_OUT_R5_P20_TASK.programs,
            (5, 21, false) => IN_OUT_R5_P21_MESH.programs,
            (5, 21, true) => IN_OUT_R5_P21_TASK.programs,
            (5, 22, false) => IN_OUT_R5_P22_MESH.programs,
            (5, 22, true) => IN_OUT_R5_P22_TASK.programs,
            (5, 23, false) => IN_OUT_R5_P23_MESH.programs,
            (5, 23, true) => IN_OUT_R5_P23_TASK.programs,
            (5, 24, false) => IN_OUT_R5_P24_MESH.programs,
            (5, 24, true) => IN_OUT_R5_P24_TASK.programs,
            (5, 25, false) => IN_OUT_R5_P25_MESH.programs,
            (5, 25, true) => IN_OUT_R5_P25_TASK.programs,
            (5, 26, false) => IN_OUT_R5_P26_MESH.programs,
            (5, 26, true) => IN_OUT_R5_P26_TASK.programs,
            (5, 27, false) => IN_OUT_R5_P27_MESH.programs,
            (5, 27, true) => IN_OUT_R5_P27_TASK.programs,
            (5, 28, false) => IN_OUT_R5_P28_MESH.programs,
            (5, 28, true) => IN_OUT_R5_P28_TASK.programs,
            (5, 29, false) => IN_OUT_R5_P29_MESH.programs,
            (5, 29, true) => IN_OUT_R5_P29_TASK.programs,
            (5, 30, false) => IN_OUT_R5_P30_MESH.programs,
            (5, 30, true) => IN_OUT_R5_P30_TASK.programs,
            (5, 31, false) => IN_OUT_R5_P31_MESH.programs,
            (5, 31, true) => IN_OUT_R5_P31_TASK.programs,
            (5, 32, false) => IN_OUT_R5_P32_MESH.programs,
            (5, 32, true) => IN_OUT_R5_P32_TASK.programs,
            (5, 33, false) => IN_OUT_R5_P33_MESH.programs,
            (5, 33, true) => IN_OUT_R5_P33_TASK.programs,
            (5, 34, false) => IN_OUT_R5_P34_MESH.programs,
            (5, 34, true) => IN_OUT_R5_P34_TASK.programs,
            (5, 35, false) => IN_OUT_R5_P35_MESH.programs,
            (5, 35, true) => IN_OUT_R5_P35_TASK.programs,
            (5, 36, false) => IN_OUT_R5_P36_MESH.programs,
            (5, 36, true) => IN_OUT_R5_P36_TASK.programs,
            (5, 37, false) => IN_OUT_R5_P37_MESH.programs,
            (5, 37, true) => IN_OUT_R5_P37_TASK.programs,
            (5, 38, false) => IN_OUT_R5_P38_MESH.programs,
            (5, 38, true) => IN_OUT_R5_P38_TASK.programs,
            (5, 39, false) => IN_OUT_R5_P39_MESH.programs,
            (5, 39, true) => IN_OUT_R5_P39_TASK.programs,
            (6, 0, false) => IN_OUT_R6_P0_MESH.programs,
            (6, 0, true) => IN_OUT_R6_P0_TASK.programs,
            (6, 1, false) => IN_OUT_R6_P1_MESH.programs,
            (6, 1, true) => IN_OUT_R6_P1_TASK.programs,
            (6, 2, false) => IN_OUT_R6_P2_MESH.programs,
            (6, 2, true) => IN_OUT_R6_P2_TASK.programs,
            (6, 3, false) => IN_OUT_R6_P3_MESH.programs,
            (6, 3, true) => IN_OUT_R6_P3_TASK.programs,
            (6, 4, false) => IN_OUT_R6_P4_MESH.programs,
            (6, 4, true) => IN_OUT_R6_P4_TASK.programs,
            (6, 5, false) => IN_OUT_R6_P5_MESH.programs,
            (6, 5, true) => IN_OUT_R6_P5_TASK.programs,
            (6, 6, false) => IN_OUT_R6_P6_MESH.programs,
            (6, 6, true) => IN_OUT_R6_P6_TASK.programs,
            (6, 7, false) => IN_OUT_R6_P7_MESH.programs,
            (6, 7, true) => IN_OUT_R6_P7_TASK.programs,
            (6, 8, false) => IN_OUT_R6_P8_MESH.programs,
            (6, 8, true) => IN_OUT_R6_P8_TASK.programs,
            (6, 9, false) => IN_OUT_R6_P9_MESH.programs,
            (6, 9, true) => IN_OUT_R6_P9_TASK.programs,
            (6, 10, false) => IN_OUT_R6_P10_MESH.programs,
            (6, 10, true) => IN_OUT_R6_P10_TASK.programs,
            (6, 11, false) => IN_OUT_R6_P11_MESH.programs,
            (6, 11, true) => IN_OUT_R6_P11_TASK.programs,
            (6, 12, false) => IN_OUT_R6_P12_MESH.programs,
            (6, 12, true) => IN_OUT_R6_P12_TASK.programs,
            (6, 13, false) => IN_OUT_R6_P13_MESH.programs,
            (6, 13, true) => IN_OUT_R6_P13_TASK.programs,
            (6, 14, false) => IN_OUT_R6_P14_MESH.programs,
            (6, 14, true) => IN_OUT_R6_P14_TASK.programs,
            (6, 15, false) => IN_OUT_R6_P15_MESH.programs,
            (6, 15, true) => IN_OUT_R6_P15_TASK.programs,
            (6, 16, false) => IN_OUT_R6_P16_MESH.programs,
            (6, 16, true) => IN_OUT_R6_P16_TASK.programs,
            (6, 17, false) => IN_OUT_R6_P17_MESH.programs,
            (6, 17, true) => IN_OUT_R6_P17_TASK.programs,
            (6, 18, false) => IN_OUT_R6_P18_MESH.programs,
            (6, 18, true) => IN_OUT_R6_P18_TASK.programs,
            (6, 19, false) => IN_OUT_R6_P19_MESH.programs,
            (6, 19, true) => IN_OUT_R6_P19_TASK.programs,
            (6, 20, false) => IN_OUT_R6_P20_MESH.programs,
            (6, 20, true) => IN_OUT_R6_P20_TASK.programs,
            (6, 21, false) => IN_OUT_R6_P21_MESH.programs,
            (6, 21, true) => IN_OUT_R6_P21_TASK.programs,
            (6, 22, false) => IN_OUT_R6_P22_MESH.programs,
            (6, 22, true) => IN_OUT_R6_P22_TASK.programs,
            (6, 23, false) => IN_OUT_R6_P23_MESH.programs,
            (6, 23, true) => IN_OUT_R6_P23_TASK.programs,
            (6, 24, false) => IN_OUT_R6_P24_MESH.programs,
            (6, 24, true) => IN_OUT_R6_P24_TASK.programs,
            (6, 25, false) => IN_OUT_R6_P25_MESH.programs,
            (6, 25, true) => IN_OUT_R6_P25_TASK.programs,
            (6, 26, false) => IN_OUT_R6_P26_MESH.programs,
            (6, 26, true) => IN_OUT_R6_P26_TASK.programs,
            (6, 27, false) => IN_OUT_R6_P27_MESH.programs,
            (6, 27, true) => IN_OUT_R6_P27_TASK.programs,
            (6, 28, false) => IN_OUT_R6_P28_MESH.programs,
            (6, 28, true) => IN_OUT_R6_P28_TASK.programs,
            (6, 29, false) => IN_OUT_R6_P29_MESH.programs,
            (6, 29, true) => IN_OUT_R6_P29_TASK.programs,
            (6, 30, false) => IN_OUT_R6_P30_MESH.programs,
            (6, 30, true) => IN_OUT_R6_P30_TASK.programs,
            (6, 31, false) => IN_OUT_R6_P31_MESH.programs,
            (6, 31, true) => IN_OUT_R6_P31_TASK.programs,
            (6, 32, false) => IN_OUT_R6_P32_MESH.programs,
            (6, 32, true) => IN_OUT_R6_P32_TASK.programs,
            (6, 33, false) => IN_OUT_R6_P33_MESH.programs,
            (6, 33, true) => IN_OUT_R6_P33_TASK.programs,
            (6, 34, false) => IN_OUT_R6_P34_MESH.programs,
            (6, 34, true) => IN_OUT_R6_P34_TASK.programs,
            (6, 35, false) => IN_OUT_R6_P35_MESH.programs,
            (6, 35, true) => IN_OUT_R6_P35_TASK.programs,
            (6, 36, false) => IN_OUT_R6_P36_MESH.programs,
            (6, 36, true) => IN_OUT_R6_P36_TASK.programs,
            (6, 37, false) => IN_OUT_R6_P37_MESH.programs,
            (6, 37, true) => IN_OUT_R6_P37_TASK.programs,
            (6, 38, false) => IN_OUT_R6_P38_MESH.programs,
            (6, 38, true) => IN_OUT_R6_P38_TASK.programs,
            (6, 39, false) => IN_OUT_R6_P39_MESH.programs,
            (6, 39, true) => IN_OUT_R6_P39_TASK.programs,
            _ => unreachable!("every requirement group, permutation and task flag has a program set"),
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(InterfaceVariablesInstance { context })
    }
}

struct InterfaceVariablesInstance<'a> {
    context: &'a Context<'a>,
}

/// One member of the per-vertex or per-primitive data structs: the interpolated floats are the only ones with a fractional part.
struct Member {
    is_float: bool,
    dim: u32,
    is_flat: bool,
}

/// The members in declaration order. Per vertex: interpolated floats, flat floats, flat ints; per primitive: flat floats, flat ints.
/// Each group goes 64, 32 and 16 bits (the data is the same plain floats and ints for all of them), vec4 down to scalar, variable 0 then 1.
fn members(per_vertex: bool) -> Vec<Member> {
    let mut groups: Vec<(bool, bool)> = Vec::new();
    if per_vertex {
        groups.push((true, false));
    }
    groups.push((true, true));
    groups.push((false, true));

    let mut result = Vec::new();
    for (is_float, is_flat) in groups {
        for _width in 0..3 {
            for dim in [4u32, 3, 2, 1] {
                for _index in 0..2 {
                    result.push(Member { is_float, dim, is_flat });
                }
            }
        }
    }
    result
}

/// The byte image of `PerVertexData` or `PerPrimitiveData`, filled as the Python script quoted in the upstream test generated it.
fn binding_data(per_vertex: bool) -> Vec<u8> {
    const FLOAT_SUFFIXES: [[f32; 4]; 4] = [
        [0.25, 0.50, 0.875, 0.0],
        [0.25, 0.75, 0.875, 0.0],
        [0.50, 0.50, 0.875, 0.0],
        [0.50, 0.75, 0.875, 0.0],
    ];
    let array_size = if per_vertex { NUM_VERTICES } else { NUM_PRIMITIVES };

    let mut bytes = Vec::new();
    for (line_counter, member) in members(per_vertex).iter().enumerate() {
        let var_base_val = 1000 + 10 * (line_counter as u32 + 1);

        for suffixes in FLOAT_SUFFIXES.iter().take(array_size) {
            for comp in 0..member.dim {
                let comp_value = var_base_val + comp + 1;
                if member.is_float {
                    let value = comp_value as f32 + if member.is_flat { 0.0 } else { suffixes[comp as usize] };
                    bytes.extend_from_slice(&value.to_ne_bytes());
                } else {
                    bytes.extend_from_slice(&(comp_value as i32).to_ne_bytes());
                }
            }
        }
    }
    bytes
}

impl TestInstance for InterfaceVariablesInstance<'_> {
    /// `InterfaceVariablesInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let image_format = vk::Format::R8G8B8A8_UNORM;
        let (width, height) = (8u32, 8u32);

        let binaries = context.get_binary_collection();
        let has_task = binaries.contains("task");
        let buf_stages = vk::ShaderStageFlags::FRAGMENT
            | vk::ShaderStageFlags::MESH_EXT
            | if has_task {
                vk::ShaderStageFlags::TASK_EXT
            } else {
                vk::ShaderStageFlags::empty()
            };

        // Create color image, view and verification buffer.
        let color = ImageWithBuffer::new(
            context,
            width,
            height,
            image_format,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            4,
        )?;

        // Create and fill buffers with the bindings data.
        let pvd_bytes = binding_data(true);
        let ppd_bytes = binding_data(false);
        let pvd_data = create_host_buffer(context, &pvd_bytes, vk::BufferUsageFlags::STORAGE_BUFFER)?;
        let ppd_data = create_host_buffer(context, &ppd_bytes, vk::BufferUsageFlags::STORAGE_BUFFER)?;

        // Descriptor set layout, pool and set.
        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, buf_stages)
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, buf_stages)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 2)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, set_layout.get())?;

        let pvd_buffer_info = make_descriptor_buffer_info(pvd_data.get(), 0, pvd_bytes.len() as vk::DeviceSize);
        let ppd_buffer_info = make_descriptor_buffer_info(ppd_data.get(), 0, ppd_bytes.len() as vk::DeviceSize);
        DescriptorSetUpdateBuilder::new()
            .write_single(
                descriptor_set.get(),
                Location::binding(0),
                vk::DescriptorType::STORAGE_BUFFER,
                &pvd_buffer_info,
            )
            .write_single(
                descriptor_set.get(),
                Location::binding(1),
                vk::DescriptorType::STORAGE_BUFFER,
                &ppd_buffer_info,
            )
            .update(device);

        let pipeline_layout = make_pipeline_layout(device, &[set_layout.get()])?;

        // Shader modules.
        let mesh_shader = create_shader_module(device, binaries.get("mesh")?)?;
        let frag_shader = create_shader_module(device, binaries.get("frag")?)?;
        let task_shader = if has_task {
            Some(create_shader_module(device, binaries.get("task")?)?)
        } else {
            None
        };

        let render_pass = make_render_pass(device, image_format)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color.view], width, height, 1)?;

        // Two viewports: the full image and its top half.
        let mut stages = Vec::new();
        if let Some(task) = &task_shader {
            stages.push((vk::ShaderStageFlags::TASK_EXT, **task));
        }
        stages.push((vk::ShaderStageFlags::MESH_EXT, *mesh_shader));
        stages.push((vk::ShaderStageFlags::FRAGMENT, *frag_shader));
        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST);
        state.viewports = vec![
            viewport(0.0, 0.0, width as f32, height as f32, 0.0, 1.0),
            viewport(0.0, 0.0, width as f32, (height / 2) as f32, 0.0, 1.0),
        ];
        state.scissors = vec![rect_2d(width, height); 2];
        state.viewport_count = 2;
        state.rasterization.depth_bias_enable = vk::FALSE;
        let pipeline = create_draw_pipeline(device, *pipeline_layout, *render_pass, &stages, &state)?;

        // Command pool and buffer.
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;

        // Run pipeline.
        let clear_values = [clear_value_color([0.0, 0.0, 0.0, 0.0])];
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(rect_2d(width, height))
            .clear_values(&clear_values);
        unsafe {
            device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline.get());
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );
            device.cmd_draw_mesh_tasks_ext(cmd, 1, 1, 1);
            device.cmd_end_render_pass(cmd);
        }
        copy_image_to_buffer(device, cmd, color.image.get(), color.buffer.get(), width, height);
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        // Every pixel is blue, within the 0.005 threshold (1/256 < 0.005 < 2/256).
        let result = color.read_bytes(device)?;
        let blue = [0i32, 0, 255, 255];
        let matches = result.chunks_exact(4).all(|pixel| {
            pixel
                .iter()
                .zip(blue)
                .all(|(&value, want)| (value as i32 - want).abs() <= 1)
        });
        if !matches {
            return Err(TestError::Fail(
                "Result does not match reference; check log for details".to_string(),
            ));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createMeshShaderInOutTestsEXT`
pub fn create_mesh_shader_in_out_tests_ext() -> TestCaseGroup {
    let mut in_out_tests = TestCaseGroup::new("in_out");

    for (requirements_index, reqs) in REQUIRED_FEATURES.iter().enumerate() {
        let mut reqs_group = TestCaseGroup::new(reqs.name);

        for permutation in 0..PERMUTATIONS {
            let mut rnd_group = TestCaseGroup::new(format!("permutation_{permutation}"));

            for use_task_shader in [false, true] {
                let name = if use_task_shader { "task_mesh" } else { "mesh_only" };
                rnd_group.add_child(Box::new(InterfaceVariablesCase {
                    name: name.to_string(),
                    requirements: *reqs,
                    requirements_index: requirements_index as u32,
                    permutation,
                    use_task_shader,
                }) as Box<dyn TestCase>);
            }

            reqs_group.add_child(rnd_group);
        }

        in_out_tests.add_child(reqs_group);
    }

    in_out_tests
}
