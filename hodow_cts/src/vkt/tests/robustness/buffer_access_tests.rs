// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/robustness/vktRobustnessBufferAccessTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Copyright (c) 2016 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shader source depends on the stage, the copy kind, the format and whether
// the input is read from storage, so shaders/manifest/robustness_buffer_access.toml holds one program set for each. Only the
// `buffer_access` and `pipeline_robustness_buffer_access` groups are ported, the latter on a `RobustnessDevice` with robustBufferAccess
// switched off, and the two descriptor heap variants of them (`descriptor_heap_buffer_access`, `pipeline_robustness_heap_buffer_access`),
// which put the three descriptors in a resource heap instead of a descriptor set. The checks
// the instance constructor makes upstream run in `checkSupport` or at the start of `iterate`.
//
// Reads and writes buffers through descriptors whose range is smaller than what the shader accesses (uniform and storage
// buffers and texel buffers, in the vertex, fragment and compute stages) and checks every out of bounds read returns a value
// from the buffer's memory or zero and every out of bounds write leaves the output untouched or lands inside the memory.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ExtDescriptorHeapExtensionDeviceCommands, InstanceV1_1};

use crate::generated::shaders::robustness_buffer_access::*;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::submit_commands_and_wait;
use crate::vk::mem_util::invalidate_alloc;
use crate::vk::obj_util::{make_descriptor_buffer_info, make_descriptor_set};
use crate::vk::programs::BinaryCollection;
pub use crate::vk::programs::SharedProgram;
use crate::vk::ref_util::Unique;
use crate::vkt::context::{RobustnessDevice, RobustnessFeatures};
use crate::vkt::tests::robustness::robustness_util::{
    ComputeEnvironment, DescriptorHeapEnvironmentParams, DrawConfig, GraphicsEnvironment, HostBuffer, is_float_format,
    is_int_format, is_uint_format, is_value_within_buffer_or_zero, log_value, pixel_size,
    populate_buffer_with_test_values, verify_out_of_bounds_vec4,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const TEST_ARRAY_SIZE: u32 = 128; // Fit within minimum required maxUniformBufferRange
const TEST_VECTOR_SIZE: i32 = 4; // vec4
const NUMBER_OF_BYTES_ACCESSED: u32 = 16 * 4; // size of mat4
const NUMBER_OF_VECTOR_BYTES_ACCESSED: u32 = 4 * 4; // size of vec4

#[derive(Clone, Copy, PartialEq, Eq)]
enum ShaderType {
    MatrixCopy,
    VectorCopy,
    VectorMemberCopy,
    ScalarCopy,
    TexelCopy,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum Stage {
    Vertex,
    Fragment,
    Compute,
}

impl Stage {
    fn name(self) -> &'static str {
        match self {
            Stage::Vertex => "vertex",
            Stage::Fragment => "fragment",
            Stage::Compute => "compute",
        }
    }
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum BufferAccessType {
    Read,
    ReadFromStorage,
    Write,
}

fn get_number_of_bytes_accessed(shader_type: ShaderType) -> u32 {
    if shader_type == ShaderType::VectorMemberCopy {
        NUMBER_OF_VECTOR_BYTES_ACCESSED
    } else {
        NUMBER_OF_BYTES_ACCESSED
    }
}

fn programs_for(
    stage: Stage,
    shader_type: ShaderType,
    format: vk::Format,
    read_from_storage: bool,
) -> BinaryCollection {
    match (stage, shader_type, format, read_from_storage) {
        (Stage::Vertex, ShaderType::MatrixCopy, vk::Format::R32_SFLOAT, false) => {
            BA_VERTEX_MAT4_R32_SFLOAT_UBO.programs
        }
        (Stage::Vertex, ShaderType::MatrixCopy, vk::Format::R32_SFLOAT, true) => {
            BA_VERTEX_MAT4_R32_SFLOAT_SSBO.programs
        }
        (Stage::Vertex, ShaderType::VectorCopy, vk::Format::R32_SINT, false) => BA_VERTEX_VEC4_R32_SINT_UBO.programs,
        (Stage::Vertex, ShaderType::VectorCopy, vk::Format::R32_SINT, true) => BA_VERTEX_VEC4_R32_SINT_SSBO.programs,
        (Stage::Vertex, ShaderType::VectorCopy, vk::Format::R32_UINT, false) => BA_VERTEX_VEC4_R32_UINT_UBO.programs,
        (Stage::Vertex, ShaderType::VectorCopy, vk::Format::R32_UINT, true) => BA_VERTEX_VEC4_R32_UINT_SSBO.programs,
        (Stage::Vertex, ShaderType::VectorCopy, vk::Format::R64_SINT, false) => BA_VERTEX_VEC4_R64_SINT_UBO.programs,
        (Stage::Vertex, ShaderType::VectorCopy, vk::Format::R64_SINT, true) => BA_VERTEX_VEC4_R64_SINT_SSBO.programs,
        (Stage::Vertex, ShaderType::VectorCopy, vk::Format::R64_UINT, false) => BA_VERTEX_VEC4_R64_UINT_UBO.programs,
        (Stage::Vertex, ShaderType::VectorCopy, vk::Format::R64_UINT, true) => BA_VERTEX_VEC4_R64_UINT_SSBO.programs,
        (Stage::Vertex, ShaderType::VectorCopy, vk::Format::R32_SFLOAT, false) => {
            BA_VERTEX_VEC4_R32_SFLOAT_UBO.programs
        }
        (Stage::Vertex, ShaderType::VectorCopy, vk::Format::R32_SFLOAT, true) => {
            BA_VERTEX_VEC4_R32_SFLOAT_SSBO.programs
        }
        (Stage::Vertex, ShaderType::VectorMemberCopy, vk::Format::R32_SINT, false) => {
            BA_VERTEX_MEMBER_R32_SINT_UBO.programs
        }
        (Stage::Vertex, ShaderType::VectorMemberCopy, vk::Format::R32_SINT, true) => {
            BA_VERTEX_MEMBER_R32_SINT_SSBO.programs
        }
        (Stage::Vertex, ShaderType::VectorMemberCopy, vk::Format::R32_UINT, false) => {
            BA_VERTEX_MEMBER_R32_UINT_UBO.programs
        }
        (Stage::Vertex, ShaderType::VectorMemberCopy, vk::Format::R32_UINT, true) => {
            BA_VERTEX_MEMBER_R32_UINT_SSBO.programs
        }
        (Stage::Vertex, ShaderType::VectorMemberCopy, vk::Format::R64_SINT, false) => {
            BA_VERTEX_MEMBER_R64_SINT_UBO.programs
        }
        (Stage::Vertex, ShaderType::VectorMemberCopy, vk::Format::R64_SINT, true) => {
            BA_VERTEX_MEMBER_R64_SINT_SSBO.programs
        }
        (Stage::Vertex, ShaderType::VectorMemberCopy, vk::Format::R64_UINT, false) => {
            BA_VERTEX_MEMBER_R64_UINT_UBO.programs
        }
        (Stage::Vertex, ShaderType::VectorMemberCopy, vk::Format::R64_UINT, true) => {
            BA_VERTEX_MEMBER_R64_UINT_SSBO.programs
        }
        (Stage::Vertex, ShaderType::VectorMemberCopy, vk::Format::R32_SFLOAT, false) => {
            BA_VERTEX_MEMBER_R32_SFLOAT_UBO.programs
        }
        (Stage::Vertex, ShaderType::VectorMemberCopy, vk::Format::R32_SFLOAT, true) => {
            BA_VERTEX_MEMBER_R32_SFLOAT_SSBO.programs
        }
        (Stage::Vertex, ShaderType::ScalarCopy, vk::Format::R32_SINT, false) => BA_VERTEX_SCALAR_R32_SINT_UBO.programs,
        (Stage::Vertex, ShaderType::ScalarCopy, vk::Format::R32_SINT, true) => BA_VERTEX_SCALAR_R32_SINT_SSBO.programs,
        (Stage::Vertex, ShaderType::ScalarCopy, vk::Format::R32_UINT, false) => BA_VERTEX_SCALAR_R32_UINT_UBO.programs,
        (Stage::Vertex, ShaderType::ScalarCopy, vk::Format::R32_UINT, true) => BA_VERTEX_SCALAR_R32_UINT_SSBO.programs,
        (Stage::Vertex, ShaderType::ScalarCopy, vk::Format::R64_SINT, false) => BA_VERTEX_SCALAR_R64_SINT_UBO.programs,
        (Stage::Vertex, ShaderType::ScalarCopy, vk::Format::R64_SINT, true) => BA_VERTEX_SCALAR_R64_SINT_SSBO.programs,
        (Stage::Vertex, ShaderType::ScalarCopy, vk::Format::R64_UINT, false) => BA_VERTEX_SCALAR_R64_UINT_UBO.programs,
        (Stage::Vertex, ShaderType::ScalarCopy, vk::Format::R64_UINT, true) => BA_VERTEX_SCALAR_R64_UINT_SSBO.programs,
        (Stage::Vertex, ShaderType::ScalarCopy, vk::Format::R32_SFLOAT, false) => {
            BA_VERTEX_SCALAR_R32_SFLOAT_UBO.programs
        }
        (Stage::Vertex, ShaderType::ScalarCopy, vk::Format::R32_SFLOAT, true) => {
            BA_VERTEX_SCALAR_R32_SFLOAT_SSBO.programs
        }
        (Stage::Vertex, ShaderType::TexelCopy, vk::Format::R32G32B32A32_SINT, false) => {
            BA_VERTEX_TEXEL_R32G32B32A32_SINT_UBO.programs
        }
        (Stage::Vertex, ShaderType::TexelCopy, vk::Format::R32G32B32A32_SINT, true) => {
            BA_VERTEX_TEXEL_R32G32B32A32_SINT_SSBO.programs
        }
        (Stage::Vertex, ShaderType::TexelCopy, vk::Format::R32G32B32A32_UINT, false) => {
            BA_VERTEX_TEXEL_R32G32B32A32_UINT_UBO.programs
        }
        (Stage::Vertex, ShaderType::TexelCopy, vk::Format::R32G32B32A32_UINT, true) => {
            BA_VERTEX_TEXEL_R32G32B32A32_UINT_SSBO.programs
        }
        (Stage::Vertex, ShaderType::TexelCopy, vk::Format::R32G32B32A32_SFLOAT, false) => {
            BA_VERTEX_TEXEL_R32G32B32A32_SFLOAT_UBO.programs
        }
        (Stage::Vertex, ShaderType::TexelCopy, vk::Format::R32G32B32A32_SFLOAT, true) => {
            BA_VERTEX_TEXEL_R32G32B32A32_SFLOAT_SSBO.programs
        }
        (Stage::Vertex, ShaderType::TexelCopy, vk::Format::A2B10G10R10_UNORM_PACK32, false) => {
            BA_VERTEX_TEXEL_A2B10G10R10_UNORM_PACK32_UBO.programs
        }
        (Stage::Vertex, ShaderType::TexelCopy, vk::Format::A2B10G10R10_UNORM_PACK32, true) => {
            BA_VERTEX_TEXEL_A2B10G10R10_UNORM_PACK32_SSBO.programs
        }
        (Stage::Fragment, ShaderType::MatrixCopy, vk::Format::R32_SFLOAT, false) => {
            BA_FRAGMENT_MAT4_R32_SFLOAT_UBO.programs
        }
        (Stage::Fragment, ShaderType::MatrixCopy, vk::Format::R32_SFLOAT, true) => {
            BA_FRAGMENT_MAT4_R32_SFLOAT_SSBO.programs
        }
        (Stage::Fragment, ShaderType::VectorCopy, vk::Format::R32_SINT, false) => {
            BA_FRAGMENT_VEC4_R32_SINT_UBO.programs
        }
        (Stage::Fragment, ShaderType::VectorCopy, vk::Format::R32_SINT, true) => {
            BA_FRAGMENT_VEC4_R32_SINT_SSBO.programs
        }
        (Stage::Fragment, ShaderType::VectorCopy, vk::Format::R32_UINT, false) => {
            BA_FRAGMENT_VEC4_R32_UINT_UBO.programs
        }
        (Stage::Fragment, ShaderType::VectorCopy, vk::Format::R32_UINT, true) => {
            BA_FRAGMENT_VEC4_R32_UINT_SSBO.programs
        }
        (Stage::Fragment, ShaderType::VectorCopy, vk::Format::R64_SINT, false) => {
            BA_FRAGMENT_VEC4_R64_SINT_UBO.programs
        }
        (Stage::Fragment, ShaderType::VectorCopy, vk::Format::R64_SINT, true) => {
            BA_FRAGMENT_VEC4_R64_SINT_SSBO.programs
        }
        (Stage::Fragment, ShaderType::VectorCopy, vk::Format::R64_UINT, false) => {
            BA_FRAGMENT_VEC4_R64_UINT_UBO.programs
        }
        (Stage::Fragment, ShaderType::VectorCopy, vk::Format::R64_UINT, true) => {
            BA_FRAGMENT_VEC4_R64_UINT_SSBO.programs
        }
        (Stage::Fragment, ShaderType::VectorCopy, vk::Format::R32_SFLOAT, false) => {
            BA_FRAGMENT_VEC4_R32_SFLOAT_UBO.programs
        }
        (Stage::Fragment, ShaderType::VectorCopy, vk::Format::R32_SFLOAT, true) => {
            BA_FRAGMENT_VEC4_R32_SFLOAT_SSBO.programs
        }
        (Stage::Fragment, ShaderType::VectorMemberCopy, vk::Format::R32_SINT, false) => {
            BA_FRAGMENT_MEMBER_R32_SINT_UBO.programs
        }
        (Stage::Fragment, ShaderType::VectorMemberCopy, vk::Format::R32_SINT, true) => {
            BA_FRAGMENT_MEMBER_R32_SINT_SSBO.programs
        }
        (Stage::Fragment, ShaderType::VectorMemberCopy, vk::Format::R32_UINT, false) => {
            BA_FRAGMENT_MEMBER_R32_UINT_UBO.programs
        }
        (Stage::Fragment, ShaderType::VectorMemberCopy, vk::Format::R32_UINT, true) => {
            BA_FRAGMENT_MEMBER_R32_UINT_SSBO.programs
        }
        (Stage::Fragment, ShaderType::VectorMemberCopy, vk::Format::R64_SINT, false) => {
            BA_FRAGMENT_MEMBER_R64_SINT_UBO.programs
        }
        (Stage::Fragment, ShaderType::VectorMemberCopy, vk::Format::R64_SINT, true) => {
            BA_FRAGMENT_MEMBER_R64_SINT_SSBO.programs
        }
        (Stage::Fragment, ShaderType::VectorMemberCopy, vk::Format::R64_UINT, false) => {
            BA_FRAGMENT_MEMBER_R64_UINT_UBO.programs
        }
        (Stage::Fragment, ShaderType::VectorMemberCopy, vk::Format::R64_UINT, true) => {
            BA_FRAGMENT_MEMBER_R64_UINT_SSBO.programs
        }
        (Stage::Fragment, ShaderType::VectorMemberCopy, vk::Format::R32_SFLOAT, false) => {
            BA_FRAGMENT_MEMBER_R32_SFLOAT_UBO.programs
        }
        (Stage::Fragment, ShaderType::VectorMemberCopy, vk::Format::R32_SFLOAT, true) => {
            BA_FRAGMENT_MEMBER_R32_SFLOAT_SSBO.programs
        }
        (Stage::Fragment, ShaderType::ScalarCopy, vk::Format::R32_SINT, false) => {
            BA_FRAGMENT_SCALAR_R32_SINT_UBO.programs
        }
        (Stage::Fragment, ShaderType::ScalarCopy, vk::Format::R32_SINT, true) => {
            BA_FRAGMENT_SCALAR_R32_SINT_SSBO.programs
        }
        (Stage::Fragment, ShaderType::ScalarCopy, vk::Format::R32_UINT, false) => {
            BA_FRAGMENT_SCALAR_R32_UINT_UBO.programs
        }
        (Stage::Fragment, ShaderType::ScalarCopy, vk::Format::R32_UINT, true) => {
            BA_FRAGMENT_SCALAR_R32_UINT_SSBO.programs
        }
        (Stage::Fragment, ShaderType::ScalarCopy, vk::Format::R64_SINT, false) => {
            BA_FRAGMENT_SCALAR_R64_SINT_UBO.programs
        }
        (Stage::Fragment, ShaderType::ScalarCopy, vk::Format::R64_SINT, true) => {
            BA_FRAGMENT_SCALAR_R64_SINT_SSBO.programs
        }
        (Stage::Fragment, ShaderType::ScalarCopy, vk::Format::R64_UINT, false) => {
            BA_FRAGMENT_SCALAR_R64_UINT_UBO.programs
        }
        (Stage::Fragment, ShaderType::ScalarCopy, vk::Format::R64_UINT, true) => {
            BA_FRAGMENT_SCALAR_R64_UINT_SSBO.programs
        }
        (Stage::Fragment, ShaderType::ScalarCopy, vk::Format::R32_SFLOAT, false) => {
            BA_FRAGMENT_SCALAR_R32_SFLOAT_UBO.programs
        }
        (Stage::Fragment, ShaderType::ScalarCopy, vk::Format::R32_SFLOAT, true) => {
            BA_FRAGMENT_SCALAR_R32_SFLOAT_SSBO.programs
        }
        (Stage::Fragment, ShaderType::TexelCopy, vk::Format::R32G32B32A32_SINT, false) => {
            BA_FRAGMENT_TEXEL_R32G32B32A32_SINT_UBO.programs
        }
        (Stage::Fragment, ShaderType::TexelCopy, vk::Format::R32G32B32A32_SINT, true) => {
            BA_FRAGMENT_TEXEL_R32G32B32A32_SINT_SSBO.programs
        }
        (Stage::Fragment, ShaderType::TexelCopy, vk::Format::R32G32B32A32_UINT, false) => {
            BA_FRAGMENT_TEXEL_R32G32B32A32_UINT_UBO.programs
        }
        (Stage::Fragment, ShaderType::TexelCopy, vk::Format::R32G32B32A32_UINT, true) => {
            BA_FRAGMENT_TEXEL_R32G32B32A32_UINT_SSBO.programs
        }
        (Stage::Fragment, ShaderType::TexelCopy, vk::Format::R32G32B32A32_SFLOAT, false) => {
            BA_FRAGMENT_TEXEL_R32G32B32A32_SFLOAT_UBO.programs
        }
        (Stage::Fragment, ShaderType::TexelCopy, vk::Format::R32G32B32A32_SFLOAT, true) => {
            BA_FRAGMENT_TEXEL_R32G32B32A32_SFLOAT_SSBO.programs
        }
        (Stage::Fragment, ShaderType::TexelCopy, vk::Format::A2B10G10R10_UNORM_PACK32, false) => {
            BA_FRAGMENT_TEXEL_A2B10G10R10_UNORM_PACK32_UBO.programs
        }
        (Stage::Fragment, ShaderType::TexelCopy, vk::Format::A2B10G10R10_UNORM_PACK32, true) => {
            BA_FRAGMENT_TEXEL_A2B10G10R10_UNORM_PACK32_SSBO.programs
        }
        (Stage::Compute, ShaderType::MatrixCopy, vk::Format::R32_SFLOAT, false) => {
            BA_COMPUTE_MAT4_R32_SFLOAT_UBO.programs
        }
        (Stage::Compute, ShaderType::MatrixCopy, vk::Format::R32_SFLOAT, true) => {
            BA_COMPUTE_MAT4_R32_SFLOAT_SSBO.programs
        }
        (Stage::Compute, ShaderType::VectorCopy, vk::Format::R32_SINT, false) => BA_COMPUTE_VEC4_R32_SINT_UBO.programs,
        (Stage::Compute, ShaderType::VectorCopy, vk::Format::R32_SINT, true) => BA_COMPUTE_VEC4_R32_SINT_SSBO.programs,
        (Stage::Compute, ShaderType::VectorCopy, vk::Format::R32_UINT, false) => BA_COMPUTE_VEC4_R32_UINT_UBO.programs,
        (Stage::Compute, ShaderType::VectorCopy, vk::Format::R32_UINT, true) => BA_COMPUTE_VEC4_R32_UINT_SSBO.programs,
        (Stage::Compute, ShaderType::VectorCopy, vk::Format::R64_SINT, false) => BA_COMPUTE_VEC4_R64_SINT_UBO.programs,
        (Stage::Compute, ShaderType::VectorCopy, vk::Format::R64_SINT, true) => BA_COMPUTE_VEC4_R64_SINT_SSBO.programs,
        (Stage::Compute, ShaderType::VectorCopy, vk::Format::R64_UINT, false) => BA_COMPUTE_VEC4_R64_UINT_UBO.programs,
        (Stage::Compute, ShaderType::VectorCopy, vk::Format::R64_UINT, true) => BA_COMPUTE_VEC4_R64_UINT_SSBO.programs,
        (Stage::Compute, ShaderType::VectorCopy, vk::Format::R32_SFLOAT, false) => {
            BA_COMPUTE_VEC4_R32_SFLOAT_UBO.programs
        }
        (Stage::Compute, ShaderType::VectorCopy, vk::Format::R32_SFLOAT, true) => {
            BA_COMPUTE_VEC4_R32_SFLOAT_SSBO.programs
        }
        (Stage::Compute, ShaderType::VectorMemberCopy, vk::Format::R32_SINT, false) => {
            BA_COMPUTE_MEMBER_R32_SINT_UBO.programs
        }
        (Stage::Compute, ShaderType::VectorMemberCopy, vk::Format::R32_SINT, true) => {
            BA_COMPUTE_MEMBER_R32_SINT_SSBO.programs
        }
        (Stage::Compute, ShaderType::VectorMemberCopy, vk::Format::R32_UINT, false) => {
            BA_COMPUTE_MEMBER_R32_UINT_UBO.programs
        }
        (Stage::Compute, ShaderType::VectorMemberCopy, vk::Format::R32_UINT, true) => {
            BA_COMPUTE_MEMBER_R32_UINT_SSBO.programs
        }
        (Stage::Compute, ShaderType::VectorMemberCopy, vk::Format::R64_SINT, false) => {
            BA_COMPUTE_MEMBER_R64_SINT_UBO.programs
        }
        (Stage::Compute, ShaderType::VectorMemberCopy, vk::Format::R64_SINT, true) => {
            BA_COMPUTE_MEMBER_R64_SINT_SSBO.programs
        }
        (Stage::Compute, ShaderType::VectorMemberCopy, vk::Format::R64_UINT, false) => {
            BA_COMPUTE_MEMBER_R64_UINT_UBO.programs
        }
        (Stage::Compute, ShaderType::VectorMemberCopy, vk::Format::R64_UINT, true) => {
            BA_COMPUTE_MEMBER_R64_UINT_SSBO.programs
        }
        (Stage::Compute, ShaderType::VectorMemberCopy, vk::Format::R32_SFLOAT, false) => {
            BA_COMPUTE_MEMBER_R32_SFLOAT_UBO.programs
        }
        (Stage::Compute, ShaderType::VectorMemberCopy, vk::Format::R32_SFLOAT, true) => {
            BA_COMPUTE_MEMBER_R32_SFLOAT_SSBO.programs
        }
        (Stage::Compute, ShaderType::ScalarCopy, vk::Format::R32_SINT, false) => {
            BA_COMPUTE_SCALAR_R32_SINT_UBO.programs
        }
        (Stage::Compute, ShaderType::ScalarCopy, vk::Format::R32_SINT, true) => {
            BA_COMPUTE_SCALAR_R32_SINT_SSBO.programs
        }
        (Stage::Compute, ShaderType::ScalarCopy, vk::Format::R32_UINT, false) => {
            BA_COMPUTE_SCALAR_R32_UINT_UBO.programs
        }
        (Stage::Compute, ShaderType::ScalarCopy, vk::Format::R32_UINT, true) => {
            BA_COMPUTE_SCALAR_R32_UINT_SSBO.programs
        }
        (Stage::Compute, ShaderType::ScalarCopy, vk::Format::R64_SINT, false) => {
            BA_COMPUTE_SCALAR_R64_SINT_UBO.programs
        }
        (Stage::Compute, ShaderType::ScalarCopy, vk::Format::R64_SINT, true) => {
            BA_COMPUTE_SCALAR_R64_SINT_SSBO.programs
        }
        (Stage::Compute, ShaderType::ScalarCopy, vk::Format::R64_UINT, false) => {
            BA_COMPUTE_SCALAR_R64_UINT_UBO.programs
        }
        (Stage::Compute, ShaderType::ScalarCopy, vk::Format::R64_UINT, true) => {
            BA_COMPUTE_SCALAR_R64_UINT_SSBO.programs
        }
        (Stage::Compute, ShaderType::ScalarCopy, vk::Format::R32_SFLOAT, false) => {
            BA_COMPUTE_SCALAR_R32_SFLOAT_UBO.programs
        }
        (Stage::Compute, ShaderType::ScalarCopy, vk::Format::R32_SFLOAT, true) => {
            BA_COMPUTE_SCALAR_R32_SFLOAT_SSBO.programs
        }
        (Stage::Compute, ShaderType::TexelCopy, vk::Format::R32G32B32A32_SINT, false) => {
            BA_COMPUTE_TEXEL_R32G32B32A32_SINT_UBO.programs
        }
        (Stage::Compute, ShaderType::TexelCopy, vk::Format::R32G32B32A32_SINT, true) => {
            BA_COMPUTE_TEXEL_R32G32B32A32_SINT_SSBO.programs
        }
        (Stage::Compute, ShaderType::TexelCopy, vk::Format::R32G32B32A32_UINT, false) => {
            BA_COMPUTE_TEXEL_R32G32B32A32_UINT_UBO.programs
        }
        (Stage::Compute, ShaderType::TexelCopy, vk::Format::R32G32B32A32_UINT, true) => {
            BA_COMPUTE_TEXEL_R32G32B32A32_UINT_SSBO.programs
        }
        (Stage::Compute, ShaderType::TexelCopy, vk::Format::R32G32B32A32_SFLOAT, false) => {
            BA_COMPUTE_TEXEL_R32G32B32A32_SFLOAT_UBO.programs
        }
        (Stage::Compute, ShaderType::TexelCopy, vk::Format::R32G32B32A32_SFLOAT, true) => {
            BA_COMPUTE_TEXEL_R32G32B32A32_SFLOAT_SSBO.programs
        }
        (Stage::Compute, ShaderType::TexelCopy, vk::Format::A2B10G10R10_UNORM_PACK32, false) => {
            BA_COMPUTE_TEXEL_A2B10G10R10_UNORM_PACK32_UBO.programs
        }
        (Stage::Compute, ShaderType::TexelCopy, vk::Format::A2B10G10R10_UNORM_PACK32, true) => {
            BA_COMPUTE_TEXEL_A2B10G10R10_UNORM_PACK32_SSBO.programs
        }
        _ => unreachable!("no buffer access program for this combination"),
    }
}

fn is_r64(format: vk::Format) -> bool {
    format == vk::Format::R64_UINT || format == vk::Format::R64_SINT
}

#[derive(Clone, Copy)]
struct TestParams {
    shader_stage: Stage,
    shader_type: ShaderType,
    buffer_format: vk::Format,
    buffer_access_type: BufferAccessType,
    in_buffer_access_range: vk::DeviceSize,
    out_buffer_access_range: vk::DeviceSize,
    access_out_of_backing_memory: bool,
    test_pipeline_robustness: bool,
    test_descriptor_heaps: bool,
    programs: BinaryCollection,
}

/// `RobustBufferReadTest` and `RobustBufferWriteTest`
struct RobustBufferAccessTest {
    name: String,
    params: TestParams,
}

impl TestCase for RobustBufferAccessTest {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkSupport`, with what upstream's `BufferAccessInstance` constructor checks.
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = &self.params;
        let features = context.get_device_features();

        if params.test_pipeline_robustness {
            context.require_device_functionality("VK_EXT_pipeline_robustness")?;

            let mut pipeline_robustness_features = vk::PhysicalDevicePipelineRobustnessFeatures::default();
            {
                let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut pipeline_robustness_features);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_features2(context.get_physical_device(), &mut features2)
                };
            }
            if pipeline_robustness_features.pipeline_robustness == vk::FALSE {
                return Err(TestError::NotSupported("pipelineRobustness not supported".to_string()));
            }
        } else if features.robust_buffer_access == vk::FALSE {
            return Err(TestError::NotSupported(
                "robustBufferAccess not supported by this implementation".to_string(),
            ));
        }

        if params.test_descriptor_heaps {
            context.require_device_functionality("VK_EXT_descriptor_heap")?;
            context.require_device_functionality("VK_KHR_buffer_device_address")?;

            let mut descriptor_heap_features = vk::PhysicalDeviceDescriptorHeapFeaturesEXT::default();
            {
                let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut descriptor_heap_features);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_features2(context.get_physical_device(), &mut features2)
                };
            }
            if descriptor_heap_features.descriptor_heap == vk::FALSE {
                return Err(TestError::NotSupported("descriptorHeap not supported".to_string()));
            }
        }

        if is_r64(params.buffer_format) {
            if features.shader_int64 == vk::FALSE {
                return Err(TestError::NotSupported("shaderInt64 not supported".to_string()));
            }
            context.require_device_functionality("VK_EXT_shader_image_atomic_int64")?;
        }

        // Check storage support
        match params.shader_stage {
            Stage::Vertex if features.vertex_pipeline_stores_and_atomics == vk::FALSE => {
                return Err(TestError::NotSupported(
                    "Stores not supported in vertex stage".to_string(),
                ));
            }
            Stage::Fragment if features.fragment_stores_and_atomics == vk::FALSE => {
                return Err(TestError::NotSupported(
                    "Stores not supported in fragment stage".to_string(),
                ));
            }
            _ => {}
        }

        // Check format support
        if params.shader_type == ShaderType::TexelCopy {
            let required_format_features =
                vk::FormatFeatureFlags::STORAGE_TEXEL_BUFFER | vk::FormatFeatureFlags::UNIFORM_TEXEL_BUFFER;
            let format_properties = unsafe {
                context
                    .get_instance()
                    .get_physical_device_format_properties(context.get_physical_device(), params.buffer_format)
            };

            if !format_properties.buffer_features.contains(required_format_features) {
                return Err(TestError::NotSupported(format!(
                    "Format cannot be used in uniform and storage texel buffers: {:?}",
                    params.buffer_format
                )));
            }
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.params.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(BufferAccessInstance {
            context,
            params: self.params,
        })
    }
}

struct BufferAccessInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

/// The buffers a run touches, with the numbers `verifyResult` needs.
struct Buffers<'a> {
    in_buffer: HostBuffer<'a>,
    in_max_access_range: vk::DeviceSize,
    out_buffer: HostBuffer<'a>,
    out_max_access_range: vk::DeviceSize,
}

impl TestInstance for BufferAccessInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = &self.params;
        let robust_device = if params.test_pipeline_robustness {
            Some(RobustnessDevice::new(
                context.get_instance(),
                context.get_physical_device(),
                context.get_universal_queue_family_index(),
                RobustnessFeatures {
                    pipeline_robustness: true,
                    shader_image_int64_atomics: true,
                    ..Default::default()
                },
            )?)
        } else {
            None
        };
        let device = robust_device
            .as_ref()
            .map_or_else(|| context.get_device(), |d| d.device());
        let queue = robust_device
            .as_ref()
            .map_or_else(|| context.get_universal_queue(), |d| d.queue());
        let is_texel_access = params.shader_type == ShaderType::TexelCopy;
        let read_from_storage = params.buffer_access_type == BufferAccessType::ReadFromStorage;
        let number_of_bytes_accessed = get_number_of_bytes_accessed(params.shader_type);

        debug_assert!(number_of_bytes_accessed.is_multiple_of(4));
        debug_assert!(params.in_buffer_access_range <= vk::DeviceSize::from(number_of_bytes_accessed));
        debug_assert!(params.out_buffer_access_range <= vk::DeviceSize::from(number_of_bytes_accessed));

        // Create buffer to read data from
        let in_buffer_usage = if is_texel_access {
            if read_from_storage {
                vk::BufferUsageFlags::STORAGE_TEXEL_BUFFER
            } else {
                vk::BufferUsageFlags::UNIFORM_TEXEL_BUFFER
            }
        } else if read_from_storage {
            vk::BufferUsageFlags::STORAGE_BUFFER
        } else {
            vk::BufferUsageFlags::UNIFORM_BUFFER
        };
        let in_buffer = HostBuffer::new_on_for_heap(
            device,
            context,
            params.in_buffer_access_range,
            in_buffer_usage,
            params.test_descriptor_heaps,
        )?;
        // Size of the most restrictive bound
        let in_max_access_range = in_buffer
            .alloc_size
            .min(in_buffer.size.min(params.in_buffer_access_range));
        in_buffer.with_bytes_mut(|bytes| populate_buffer_with_test_values(bytes, params.buffer_format));
        in_buffer.flush(device)?;

        log::info!("inBufferAllocSize = {}", in_buffer.alloc_size);
        log::info!("inBufferMaxAccessRange = {in_max_access_range}");

        // Create buffer to write data into
        let out_buffer_usage = if is_texel_access {
            vk::BufferUsageFlags::STORAGE_TEXEL_BUFFER
        } else {
            vk::BufferUsageFlags::STORAGE_BUFFER
        };
        let out_buffer = HostBuffer::new_on_for_heap(
            device,
            context,
            params.out_buffer_access_range,
            out_buffer_usage,
            params.test_descriptor_heaps,
        )?;

        // If we are requesting access out of the memory that backs the buffer, make sure the test is able to do so.
        if params.access_out_of_backing_memory
            && out_buffer.alloc_size >= vk::DeviceSize::from((TEST_ARRAY_SIZE + 1) * number_of_bytes_accessed)
        {
            return Err(TestError::NotSupported(
                "Cannot access beyond the end of the memory that backs the buffer".to_string(),
            ));
        }

        // Size of the most restrictive bound
        let out_max_access_range = out_buffer
            .alloc_size
            .min(out_buffer.size.min(params.out_buffer_access_range));
        out_buffer.with_bytes_mut(|bytes| bytes.fill(0xFF));
        out_buffer.flush(device)?;

        log::info!("outBufferAllocSize = {}", out_buffer.alloc_size);
        log::info!("outBufferMaxAccessRange = {out_max_access_range}");

        // Create buffer for indices/offsets
        let mut indices_buffer_size: vk::DeviceSize = 8;
        if params.test_descriptor_heaps {
            // Align up by uniform buffer alignment requirements
            let alignment = context
                .get_device_properties()
                .limits
                .min_uniform_buffer_offset_alignment
                .max(1);
            indices_buffer_size = indices_buffer_size.div_ceil(alignment) * alignment;
        }
        let indices_buffer = HostBuffer::new_on_for_heap(
            device,
            context,
            indices_buffer_size,
            vk::BufferUsageFlags::UNIFORM_BUFFER,
            params.test_descriptor_heaps,
        )?;
        {
            let mut in_index = 0i32;
            let mut out_index = 0i32;

            if params.access_out_of_backing_memory {
                let last = if params.shader_type == ShaderType::VectorMemberCopy {
                    TEST_VECTOR_SIZE - 1
                } else {
                    (TEST_ARRAY_SIZE - 1) as i32
                };
                if params.buffer_access_type == BufferAccessType::Write {
                    out_index = last;
                } else {
                    in_index = last;
                }
            }

            indices_buffer.with_bytes_mut(|bytes| {
                bytes[..indices_buffer_size as usize].fill(0);
                bytes[0..4].copy_from_slice(&in_index.to_ne_bytes());
                bytes[4..8].copy_from_slice(&out_index.to_ne_bytes());
            });
            indices_buffer.flush(device)?;

            log::info!("inIndex = {in_index}");
            log::info!("outIndex = {out_index}");
        }

        let (in_buffer_descriptor_type, out_buffer_descriptor_type) = if is_texel_access {
            (
                if read_from_storage {
                    vk::DescriptorType::STORAGE_TEXEL_BUFFER
                } else {
                    vk::DescriptorType::UNIFORM_TEXEL_BUFFER
                },
                vk::DescriptorType::STORAGE_TEXEL_BUFFER,
            )
        } else {
            (
                if read_from_storage {
                    vk::DescriptorType::STORAGE_BUFFER
                } else {
                    vk::DescriptorType::UNIFORM_BUFFER
                },
                vk::DescriptorType::STORAGE_BUFFER,
            )
        };

        // Create descriptor data
        let descriptor_data = if params.test_descriptor_heaps {
            None
        } else {
            let descriptor_pool = DescriptorPoolBuilder::new()
                .add_type(in_buffer_descriptor_type, 1)
                .add_type(out_buffer_descriptor_type, 1)
                .add_type(vk::DescriptorType::UNIFORM_BUFFER, 1)
                .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;

            let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
                .add_single_binding(in_buffer_descriptor_type, vk::ShaderStageFlags::ALL)
                .add_single_binding(out_buffer_descriptor_type, vk::ShaderStageFlags::ALL)
                .add_single_binding(vk::DescriptorType::UNIFORM_BUFFER, vk::ShaderStageFlags::ALL)
                .build(device)?;
            let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

            let mut in_texel_buffer_view: Option<Unique<'_, vk::BufferView>> = None;
            let mut out_texel_buffer_view: Option<Unique<'_, vk::BufferView>> = None;
            if is_texel_access {
                let in_view_info = vk::BufferViewCreateInfo::builder()
                    .buffer(in_buffer.get())
                    .format(params.buffer_format)
                    .offset(0)
                    .range(params.in_buffer_access_range);
                in_texel_buffer_view = Some(Unique::new(
                    device,
                    unsafe { device.create_buffer_view(&in_view_info, None) }.vk_check("vkCreateBufferView")?,
                ));

                let out_view_info = vk::BufferViewCreateInfo::builder()
                    .buffer(out_buffer.get())
                    .format(params.buffer_format)
                    .offset(0)
                    .range(params.out_buffer_access_range);
                out_texel_buffer_view = Some(Unique::new(
                    device,
                    unsafe { device.create_buffer_view(&out_view_info, None) }.vk_check("vkCreateBufferView")?,
                ));
            }

            {
                let in_buffer_descriptor_info = [make_descriptor_buffer_info(
                    in_buffer.get(),
                    0,
                    params.in_buffer_access_range,
                )];
                let out_buffer_descriptor_info = [make_descriptor_buffer_info(
                    out_buffer.get(),
                    0,
                    params.out_buffer_access_range,
                )];
                let indices_buffer_descriptor_info = [make_descriptor_buffer_info(indices_buffer.get(), 0, 8)];
                let in_texel_views = [in_texel_buffer_view
                    .as_ref()
                    .map_or(vk::BufferView::null(), |view| **view)];
                let out_texel_views = [out_texel_buffer_view
                    .as_ref()
                    .map_or(vk::BufferView::null(), |view| **view)];

                let mut writes: Vec<vk::WriteDescriptorSet> = Vec::new();
                if is_texel_access {
                    writes.push(
                        vk::WriteDescriptorSet::builder()
                            .dst_set(*descriptor_set)
                            .dst_binding(0)
                            .descriptor_type(in_buffer_descriptor_type)
                            .texel_buffer_view(&in_texel_views)
                            .build(),
                    );
                    writes.push(
                        vk::WriteDescriptorSet::builder()
                            .dst_set(*descriptor_set)
                            .dst_binding(1)
                            .descriptor_type(out_buffer_descriptor_type)
                            .texel_buffer_view(&out_texel_views)
                            .build(),
                    );
                } else {
                    writes.push(
                        vk::WriteDescriptorSet::builder()
                            .dst_set(*descriptor_set)
                            .dst_binding(0)
                            .descriptor_type(in_buffer_descriptor_type)
                            .buffer_info(&in_buffer_descriptor_info)
                            .build(),
                    );
                    writes.push(
                        vk::WriteDescriptorSet::builder()
                            .dst_set(*descriptor_set)
                            .dst_binding(1)
                            .descriptor_type(out_buffer_descriptor_type)
                            .buffer_info(&out_buffer_descriptor_info)
                            .build(),
                    );
                }
                writes.push(
                    vk::WriteDescriptorSet::builder()
                        .dst_set(*descriptor_set)
                        .dst_binding(2)
                        .descriptor_type(vk::DescriptorType::UNIFORM_BUFFER)
                        .buffer_info(&indices_buffer_descriptor_info)
                        .build(),
                );
                unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };
            }
            Some((
                descriptor_pool,
                descriptor_set_layout,
                descriptor_set,
                in_texel_buffer_view,
                out_texel_buffer_view,
            ))
        };

        // Create descriptor heap data
        let (descriptor_set_layout, descriptor_set) = descriptor_data.as_ref().map_or(
            (vk::DescriptorSetLayout::null(), vk::DescriptorSet::null()),
            |(_, layout, set, _, _)| (**layout, **set),
        );
        let resource_heap: Option<HostBuffer<'_>>;
        let heap_params: Option<DescriptorHeapEnvironmentParams> = if params.test_descriptor_heaps {
            let mut heap_props = vk::PhysicalDeviceDescriptorHeapPropertiesEXT::default();
            {
                let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut heap_props);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
                };
            }

            let align_up = |value: u64, alignment: u64| value.div_ceil(alignment.max(1)) * alignment.max(1);
            let descriptor_size = if is_texel_access {
                heap_props.image_descriptor_size
            } else {
                heap_props.buffer_descriptor_size
            };
            let descriptor_alignment = if is_texel_access {
                heap_props.image_descriptor_alignment
            } else {
                heap_props.buffer_descriptor_alignment
            };

            let mut user_resource_heap_size = heap_props.buffer_descriptor_size;
            user_resource_heap_size = align_up(user_resource_heap_size, descriptor_alignment);
            let test_resource_offset = user_resource_heap_size;
            user_resource_heap_size += 2 * descriptor_size;
            user_resource_heap_size = align_up(user_resource_heap_size, heap_props.resource_heap_alignment);

            let resource_heap_size = user_resource_heap_size + heap_props.min_resource_heap_reserved_range;
            let heap = HostBuffer::new_resource_heap(device, context, resource_heap_size)?;
            let heap_data = heap.buffer.get_allocation().get_host_ptr();

            let in_address_range = vk::DeviceAddressRangeEXT {
                address: in_buffer.device_address(device),
                size: params.in_buffer_access_range,
            };
            let out_address_range = vk::DeviceAddressRangeEXT {
                address: out_buffer.device_address(device),
                size: params.out_buffer_access_range,
            };
            let indices_address_range = vk::DeviceAddressRangeEXT {
                address: indices_buffer.device_address(device),
                size: indices_buffer_size,
            };
            let in_texel_info = vk::TexelBufferDescriptorInfoEXT {
                address_range: in_address_range,
                format: params.buffer_format,
                ..Default::default()
            };
            let out_texel_info = vk::TexelBufferDescriptorInfoEXT {
                address_range: out_address_range,
                format: params.buffer_format,
                ..Default::default()
            };

            let (in_data, out_data) = if is_texel_access {
                (
                    vk::ResourceDescriptorDataEXT {
                        texel_buffer: &in_texel_info,
                    },
                    vk::ResourceDescriptorDataEXT {
                        texel_buffer: &out_texel_info,
                    },
                )
            } else {
                (
                    vk::ResourceDescriptorDataEXT {
                        address_range: &in_address_range,
                    },
                    vk::ResourceDescriptorDataEXT {
                        address_range: &out_address_range,
                    },
                )
            };
            let resource_infos = [
                vk::ResourceDescriptorInfoEXT {
                    type_: in_buffer_descriptor_type,
                    data: in_data,
                    ..Default::default()
                },
                vk::ResourceDescriptorInfoEXT {
                    type_: out_buffer_descriptor_type,
                    data: out_data,
                    ..Default::default()
                },
                vk::ResourceDescriptorInfoEXT {
                    type_: vk::DescriptorType::UNIFORM_BUFFER,
                    data: vk::ResourceDescriptorDataEXT {
                        address_range: &indices_address_range,
                    },
                    ..Default::default()
                },
            ];

            let host_range = |offset: u64, size: u64| vk::HostAddressRangeEXT {
                address: unsafe { heap_data.add(offset as usize) }.cast(),
                size: size as usize,
            };
            let descriptor_writes = [
                host_range(test_resource_offset, descriptor_size),
                host_range(test_resource_offset + descriptor_size, descriptor_size),
                host_range(0, heap_props.buffer_descriptor_size),
            ];
            unsafe { device.write_resource_descriptors_ext(&resource_infos[..], &descriptor_writes[..]) }
                .vk_check("vkWriteResourceDescriptorsEXT")?;
            heap.flush(device)?;

            let mapping = |first_binding: u32, heap_offset: u64| vk::DescriptorSetAndBindingMappingEXT {
                descriptor_set: 0,
                first_binding,
                binding_count: 1,
                resource_mask: vk::SpirvResourceTypeFlagsEXT::ALL,
                source: vk::DescriptorMappingSourceEXT::HEAP_WITH_CONSTANT_OFFSET,
                source_data: vk::DescriptorMappingSourceDataEXT {
                    constant_offset: vk::DescriptorMappingSourceConstantOffsetEXT {
                        heap_offset: heap_offset as u32,
                        ..Default::default()
                    },
                },
                ..Default::default()
            };
            let mappings = vec![
                mapping(0, test_resource_offset),
                mapping(1, test_resource_offset + descriptor_size),
                mapping(2, 0),
            ];

            let resource_heap_info = vk::BindHeapInfoEXT {
                heap_range: vk::DeviceAddressRangeEXT {
                    address: heap.device_address(device),
                    size: resource_heap_size,
                },
                reserved_range_offset: user_resource_heap_size,
                reserved_range_size: heap_props.min_resource_heap_reserved_range,
                ..Default::default()
            };
            resource_heap = Some(heap);
            Some(DescriptorHeapEnvironmentParams {
                mappings,
                resource_heap: resource_heap_info,
            })
        } else {
            resource_heap = None;
            None
        };
        let _resource_heap = resource_heap;

        let compute_environment;
        let graphics_environment;
        let vertex_buffer;
        let cmd_buffer = if params.shader_stage == Stage::Compute {
            compute_environment = ComputeEnvironment::new_on_with_heap(
                device,
                context,
                descriptor_set_layout,
                descriptor_set,
                params.test_pipeline_robustness,
                heap_params.as_ref(),
            )?;
            compute_environment.get_command_buffer()
        } else {
            let vertex_input_binding_description = vk::VertexInputBindingDescription {
                binding: 0,
                stride: 16,
                input_rate: vk::VertexInputRate::VERTEX,
            };
            let vertex_input_attribute_description = vk::VertexInputAttributeDescription {
                location: 0,
                binding: 0,
                format: vk::Format::R32G32B32A32_SFLOAT,
                offset: 0,
            };

            let vertices: [[f32; 4]; 3] = [[-1.0, -1.0, 0.0, 1.0], [-1.0, 1.0, 0.0, 1.0], [1.0, -1.0, 0.0, 1.0]];

            // Create vertex buffer
            vertex_buffer = HostBuffer::new_on(device, context, 4 * 16, vk::BufferUsageFlags::VERTEX_BUFFER)?;
            // Load vertices into vertex buffer
            unsafe {
                std::ptr::copy_nonoverlapping(
                    vertices.as_ptr().cast::<u8>(),
                    vertex_buffer.buffer.get_allocation().get_host_ptr(),
                    std::mem::size_of_val(&vertices),
                )
            };
            vertex_buffer.flush(device)?;

            let draw_with_one_vertex_buffer = DrawConfig {
                vertex_buffers: vec![vertex_buffer.get()],
                vertex_count: vertices.len() as u32,
                instance_count: 1,
                index_buffer: vk::Buffer::null(),
                index_count: 0,
            };

            graphics_environment = GraphicsEnvironment::new_on_with_heap(
                device,
                context,
                descriptor_set_layout,
                descriptor_set,
                &[vertex_input_binding_description],
                &[vertex_input_attribute_description],
                &draw_with_one_vertex_buffer,
                params.test_pipeline_robustness,
                heap_params.as_ref(),
            )?;
            graphics_environment.get_command_buffer()
        };

        // Submit command buffer
        submit_commands_and_wait(device, queue, cmd_buffer)?;

        // Prepare result buffer for read
        invalidate_alloc(device, out_buffer.buffer.get_allocation())?;

        let buffers = Buffers {
            in_buffer,
            in_max_access_range,
            out_buffer,
            out_max_access_range,
        };
        if self.verify_result(&buffers) {
            Ok(TestStatus::pass("All values OK"))
        } else {
            Ok(TestStatus::fail("Invalid value(s) found"))
        }
    }
}

impl BufferAccessInstance<'_> {
    /// `isExpectedValueFromInBuffer` - the buffer holds what `populateBufferWithTestValues` wrote at a given offset.
    fn is_expected_value_from_in_buffer(&self, offset_in_bytes: u64, value: &[u8]) -> bool {
        debug_assert!(offset_in_bytes.is_multiple_of(4));

        let format = self.params.buffer_format;
        let value_index = (offset_in_bytes / 4) as u32 + 2;

        let expected: u32 = if is_uint_format(format) {
            value_index
        } else if is_int_format(format) {
            (-(value_index as i32)) as u32
        } else if is_float_format(format) {
            (value_index as f32).to_bits()
        } else if format == vk::Format::A2B10G10R10_UNORM_PACK32 {
            let r = value_index & ((2u32 << 10) - 1);
            let g = (value_index + 1) & ((2u32 << 10) - 1);
            let b = (value_index + 2) & ((2u32 << 10) - 1);
            let a = value_index & ((2u32 << 2) - 1);
            (a << 30) | (b << 20) | (g << 10) | r
        } else {
            debug_assert!(false, "unexpected format");
            return false;
        };

        value == expected.to_ne_bytes()
    }

    /// `verifyResult`
    fn verify_result(&self, buffers: &Buffers<'_>) -> bool {
        let params = &self.params;
        let format = params.buffer_format;
        let mut log_msg = String::new();
        let is_read_access = matches!(
            params.buffer_access_type,
            BufferAccessType::Read | BufferAccessType::ReadFromStorage
        );
        let in_data = buffers.in_buffer.bytes();
        let out_data = buffers.out_buffer.bytes();
        let out_alloc_size = buffers.out_buffer.alloc_size;
        let mut all_ok = true;
        let mut value_ndx = 0u32;
        let max_access_range = if is_read_access {
            buffers.in_max_access_range
        } else {
            buffers.out_max_access_range
        };

        // `isOutBufferValueUnchanged`
        let is_out_buffer_value_unchanged = |offset_in_bytes: u64, value_size: u64| -> bool {
            out_data[offset_in_bytes as usize..(offset_in_bytes + value_size) as usize]
                .iter()
                .all(|&byte| byte == 0xFF)
        };

        let mut offset_in_bytes = 0u64;
        while offset_in_bytes < out_alloc_size {
            let out_value_size = 4u64.min(out_alloc_size - offset_in_bytes);
            let out_value = &out_data[offset_in_bytes as usize..(offset_in_bytes + out_value_size) as usize];

            if offset_in_bytes >= u64::from(get_number_of_bytes_accessed(params.shader_type)) {
                // The shader will only write 16 values into the result buffer. The rest of the values should remain unchanged
                // or may be modified if we are writing out of bounds.
                if !is_out_buffer_value_unchanged(offset_in_bytes, out_value_size)
                    && (is_read_access || !is_value_within_buffer_or_zero(in_data, out_value))
                {
                    use std::fmt::Write;
                    let _ = write!(
                        log_msg,
                        "\nValue {value_ndx} has been modified with an unknown value: {}",
                        u32::from_ne_bytes(out_value.try_into().unwrap_or([0; 4]))
                    );
                    value_ndx += 1;
                    all_ok = false;
                }
            } else {
                use std::fmt::Write;

                let distance_to_out_of_bounds = max_access_range as i32 - offset_in_bytes as i32;

                let _ = write!(log_msg, "\n{value_ndx}: ");
                value_ndx += 1;

                log_value(&mut log_msg, out_value, format, out_value_size as usize);

                let is_out_of_bounds_access = if params.access_out_of_backing_memory {
                    true
                } else {
                    // Check if the shader operation accessed an operand located less than 16 bytes away from the out of bounds
                    // address.
                    let operand_size: u64 = match params.shader_type {
                        ShaderType::ScalarCopy => 4,                                      // Size of scalar
                        ShaderType::VectorCopy => 4 * if is_r64(format) { 8 } else { 4 }, // Size of vec4
                        ShaderType::VectorMemberCopy => {
                            if is_r64(format) {
                                8
                            } else {
                                4
                            }
                        }
                        ShaderType::MatrixCopy => 4 * 16, // Size of mat4
                        ShaderType::TexelCopy => u64::from(pixel_size(format)),
                    };

                    max_access_range < 16
                        || (offset_in_bytes / operand_size + 1) * operand_size > max_access_range.wrapping_sub(16)
                };

                if is_out_of_bounds_access {
                    let _ = write!(
                        log_msg,
                        " (out of bounds {})",
                        if is_read_access { "read" } else { "write" }
                    );

                    let is_value_partially_out_of_bounds =
                        distance_to_out_of_bounds > 0 && (distance_to_out_of_bounds as u32) < 4;
                    let mut is_valid_value;

                    if is_value_partially_out_of_bounds && !params.access_out_of_backing_memory {
                        // The value is partially out of bounds
                        let distance = distance_to_out_of_bounds as u64;
                        let first = &out_value[..distance as usize];
                        let last = &out_value[distance as usize..];

                        let (is_within_bounds_part_ok, is_out_of_bounds_part_ok) = if is_read_access {
                            (
                                is_value_within_buffer_or_zero(in_data, first),
                                is_value_within_buffer_or_zero(in_data, last),
                            )
                        } else {
                            (
                                is_value_within_buffer_or_zero(in_data, first)
                                    || is_out_buffer_value_unchanged(offset_in_bytes, distance),
                                is_value_within_buffer_or_zero(in_data, last)
                                    || is_out_buffer_value_unchanged(
                                        offset_in_bytes + distance,
                                        out_value_size - distance,
                                    ),
                            )
                        };

                        let _ = write!(
                            log_msg,
                            ", first {distance} byte(s) {}",
                            if is_within_bounds_part_ok { "OK" } else { "wrong" }
                        );
                        let _ = write!(
                            log_msg,
                            ", last {} byte(s) {}",
                            out_value_size - distance,
                            if is_out_of_bounds_part_ok { "OK" } else { "wrong" }
                        );

                        is_valid_value = is_within_bounds_part_ok && is_out_of_bounds_part_ok;
                    } else if is_read_access {
                        is_valid_value = is_value_within_buffer_or_zero(in_data, out_value);
                    } else {
                        is_valid_value = is_out_buffer_value_unchanged(offset_in_bytes, out_value_size);

                        if !is_valid_value {
                            // Out of bounds writes may modify values withing the memory ranges bound to the buffer
                            is_valid_value = is_value_within_buffer_or_zero(in_data, out_value);

                            if is_valid_value {
                                log_msg.push_str(", OK, written within the memory range bound to the buffer");
                            }
                        }
                    }

                    if !is_valid_value {
                        // Check if we are satisfying the [0, 0, 0, x] pattern, where x may be either 0 or 1, or the maximum
                        // representable positive integer value (if the format is integer-based).
                        let can_match_vec4_pattern = is_read_access
                            && !is_value_partially_out_of_bounds
                            && matches!(
                                params.shader_type,
                                ShaderType::VectorCopy | ShaderType::VectorMemberCopy | ShaderType::TexelCopy
                            )
                            && ((offset_in_bytes / 4 + 1).is_multiple_of(4)
                                || format == vk::Format::A2B10G10R10_UNORM_PACK32);
                        let mut matches_vec4_pattern = false;

                        if can_match_vec4_pattern {
                            if format == vk::Format::A2B10G10R10_UNORM_PACK32 {
                                matches_vec4_pattern = verify_out_of_bounds_vec4(out_value, format);
                            } else {
                                let start = offset_in_bytes as usize - 12;
                                matches_vec4_pattern = verify_out_of_bounds_vec4(&out_data[start..], format);
                            }
                        }

                        if !can_match_vec4_pattern || !matches_vec4_pattern {
                            log_msg.push_str(". Failed: ");

                            if is_read_access {
                                log_msg.push_str("expected value within the buffer range or 0");

                                if can_match_vec4_pattern {
                                    log_msg.push_str(", or the [0, 0, 0, x] pattern");
                                }
                            } else {
                                log_msg.push_str("written out of the range");
                            }

                            all_ok = false;
                        }
                    }
                } else if is_read_access {
                    // We are within bounds
                    if !self.is_expected_value_from_in_buffer(offset_in_bytes, out_value) {
                        log_msg.push_str(", Failed: unexpected value");
                        all_ok = false;
                    }
                } else {
                    // Out of bounds writes may change values within the bounds.
                    let in_range = &in_data[..(params.in_buffer_access_range.min(in_data.len() as u64)) as usize];
                    if !is_value_within_buffer_or_zero(in_range, out_value) {
                        log_msg.push_str(", Failed: unexpected value");
                        all_ok = false;
                    }
                }
            }

            offset_in_bytes += 4;
        }

        log::info!("{log_msg}");

        all_ok
    }
}

fn buffer_format_name(format: vk::Format) -> &'static str {
    match format {
        vk::Format::R32_SINT => "r32_sint",
        vk::Format::R32_UINT => "r32_uint",
        vk::Format::R64_SINT => "r64_sint",
        vk::Format::R64_UINT => "r64_uint",
        vk::Format::R32_SFLOAT => "r32_sfloat",
        vk::Format::R32G32B32A32_SINT => "r32g32b32a32_sint",
        vk::Format::R32G32B32A32_UINT => "r32g32b32a32_uint",
        vk::Format::R32G32B32A32_SFLOAT => "r32g32b32a32_sfloat",
        _ => "a2b10g10r10_unorm_pack32",
    }
}

#[allow(clippy::too_many_arguments)]
fn make_test(
    name: &str,
    stage: Stage,
    shader_type: ShaderType,
    buffer_format: vk::Format,
    access_type: BufferAccessType,
    range: vk::DeviceSize,
    access_out_of_backing_memory: bool,
    test_pipeline_robustness: bool,
    test_descriptor_heaps: bool,
) -> Box<dyn TestCase> {
    let read_from_storage = access_type == BufferAccessType::ReadFromStorage;
    let number_of_bytes_accessed = vk::DeviceSize::from(get_number_of_bytes_accessed(shader_type));
    let (in_range, out_range) = if access_type == BufferAccessType::Write {
        (number_of_bytes_accessed, range)
    } else {
        (range, number_of_bytes_accessed)
    };

    let params = TestParams {
        shader_stage: stage,
        shader_type,
        buffer_format,
        buffer_access_type: access_type,
        in_buffer_access_range: in_range,
        out_buffer_access_range: out_range,
        access_out_of_backing_memory,
        test_pipeline_robustness,
        test_descriptor_heaps,
        programs: programs_for(stage, shader_type, buffer_format, read_from_storage),
    };
    Box::new(RobustBufferAccessTest {
        name: name.to_string(),
        params,
    })
}

/// `addBufferAccessTests`
fn add_buffer_access_tests(
    parent_node: &mut TestCaseGroup,
    test_pipeline_robustness: bool,
    test_descriptor_heaps: bool,
) {
    let buffer_access_stages = [Stage::Vertex, Stage::Fragment, Stage::Compute];

    let buffer_formats = [
        vk::Format::R32_SINT,
        vk::Format::R32_UINT,
        vk::Format::R64_SINT,
        vk::Format::R64_UINT,
        vk::Format::R32_SFLOAT,
    ];

    let texel_buffer_formats = [
        vk::Format::R32G32B32A32_SINT,
        vk::Format::R32G32B32A32_UINT,
        vk::Format::R32G32B32A32_SFLOAT,
        vk::Format::A2B10G10R10_UNORM_PACK32,
    ];

    let buffer_range_configs: [(&str, vk::DeviceSize); 4] = [
        ("range_1_byte", 1),
        ("range_3_bytes", 3),
        ("range_4_bytes", 4),   // size of float
        ("range_32_bytes", 32), // size of half mat4
    ];

    let texel_buffer_range_configs: [(&str, vk::DeviceSize); 2] = [("range_1_texel", 1), ("range_3_texels", 3)];

    let shader_types = [
        (ShaderType::MatrixCopy, "mat4_copy"),
        (ShaderType::VectorCopy, "vec4_copy"),
        (ShaderType::VectorMemberCopy, "vec4_member_copy"),
        (ShaderType::ScalarCopy, "scalar_copy"),
        (ShaderType::TexelCopy, "texel_copy"),
    ];

    for stage in buffer_access_stages {
        let mut stage_tests = TestCaseGroup::new(stage.name());

        for (shader_type, shader_type_name) in shader_types {
            let mut shader_type_tests = TestCaseGroup::new(shader_type_name);

            let (formats, ranges): (&[vk::Format], &[(&str, vk::DeviceSize)]) = if shader_type == ShaderType::TexelCopy
            {
                (&texel_buffer_formats, &texel_buffer_range_configs)
            } else {
                (&buffer_formats, &buffer_range_configs)
            };

            for &buffer_format in formats {
                let range_multiplier = if shader_type == ShaderType::TexelCopy {
                    vk::DeviceSize::from(pixel_size(buffer_format))
                } else {
                    1
                };

                if !is_float_format(buffer_format) && shader_type == ShaderType::MatrixCopy {
                    // Use SHADER_TYPE_MATRIX_COPY with floating-point formats only
                    break;
                }

                // Avoid too much duplication by excluding certain test cases
                if test_pipeline_robustness
                    && !matches!(
                        buffer_format,
                        vk::Format::R32_UINT
                            | vk::Format::R64_SINT
                            | vk::Format::R32_SFLOAT
                            | vk::Format::A2B10G10R10_UNORM_PACK32
                    )
                {
                    continue;
                }

                let mut format_tests = TestCaseGroup::new(buffer_format_name(buffer_format));

                let mut ubo_read_tests = TestCaseGroup::new("oob_uniform_read");
                let mut ssbo_read_tests = TestCaseGroup::new("oob_storage_read");
                let mut ssbo_write_tests = TestCaseGroup::new("oob_storage_write");

                for &(range_name, range) in ranges {
                    let range_in_bytes = range * range_multiplier;

                    if range_in_bytes > 16 && shader_type == ShaderType::VectorMemberCopy {
                        continue;
                    }

                    ubo_read_tests.add_child(make_test(
                        range_name,
                        stage,
                        shader_type,
                        buffer_format,
                        BufferAccessType::Read,
                        range_in_bytes,
                        false,
                        test_pipeline_robustness,
                        test_descriptor_heaps,
                    ));

                    // Avoid too much duplication by excluding certain test cases
                    if !test_pipeline_robustness {
                        ssbo_read_tests.add_child(make_test(
                            range_name,
                            stage,
                            shader_type,
                            buffer_format,
                            BufferAccessType::ReadFromStorage,
                            range_in_bytes,
                            false,
                            test_pipeline_robustness,
                            test_descriptor_heaps,
                        ));
                    }

                    ssbo_write_tests.add_child(make_test(
                        range_name,
                        stage,
                        shader_type,
                        buffer_format,
                        BufferAccessType::Write,
                        range_in_bytes,
                        false,
                        test_pipeline_robustness,
                        test_descriptor_heaps,
                    ));
                }

                format_tests.add_child(ubo_read_tests);
                format_tests.add_child(ssbo_read_tests);
                format_tests.add_child(ssbo_write_tests);

                shader_type_tests.add_child(format_tests);
            }

            // Read/write out of the memory that backs the buffer
            {
                let mut out_of_alloc_tests = TestCaseGroup::new("out_of_alloc");

                let format = if shader_type == ShaderType::TexelCopy {
                    vk::Format::R32G32B32A32_SFLOAT
                } else {
                    vk::Format::R32_SFLOAT
                };

                let write_access_range: vk::DeviceSize = if shader_type == ShaderType::VectorMemberCopy {
                    8
                } else {
                    16
                };

                out_of_alloc_tests.add_child(make_test(
                    "oob_uniform_read",
                    stage,
                    shader_type,
                    format,
                    BufferAccessType::Read,
                    write_access_range,
                    true,
                    test_pipeline_robustness,
                    test_descriptor_heaps,
                ));

                // Avoid too much duplication by excluding certain test cases
                if !test_pipeline_robustness {
                    out_of_alloc_tests.add_child(make_test(
                        "oob_storage_read",
                        stage,
                        shader_type,
                        format,
                        BufferAccessType::ReadFromStorage,
                        write_access_range,
                        true,
                        test_pipeline_robustness,
                        test_descriptor_heaps,
                    ));
                }

                out_of_alloc_tests.add_child(make_test(
                    "oob_storage_write",
                    stage,
                    shader_type,
                    format,
                    BufferAccessType::Write,
                    write_access_range,
                    true,
                    test_pipeline_robustness,
                    test_descriptor_heaps,
                ));

                shader_type_tests.add_child(out_of_alloc_tests);
            }

            stage_tests.add_child(shader_type_tests);
        }
        parent_node.add_child(stage_tests);
    }
}

/// `createBufferAccessTests`
pub fn create_buffer_access_tests() -> TestCaseGroup {
    let mut buffer_access_tests = TestCaseGroup::new("buffer_access");

    add_buffer_access_tests(&mut buffer_access_tests, false, false);

    buffer_access_tests
}

/// `createPipelineRobustnessBufferAccessTests`
pub fn create_pipeline_robustness_buffer_access_tests() -> TestCaseGroup {
    let mut buffer_access_tests = TestCaseGroup::new("pipeline_robustness_buffer_access");

    add_buffer_access_tests(&mut buffer_access_tests, true, false);

    buffer_access_tests
}

/// `createDescriptorHeapBufferAccessTests`
pub fn create_descriptor_heap_buffer_access_tests() -> TestCaseGroup {
    let mut buffer_access_tests = TestCaseGroup::new("descriptor_heap_buffer_access");

    add_buffer_access_tests(&mut buffer_access_tests, false, true);

    buffer_access_tests
}

/// `createPipelineRobustnessHeapBufferAccessTests`
pub fn create_pipeline_robustness_heap_buffer_access_tests() -> TestCaseGroup {
    let mut buffer_access_tests = TestCaseGroup::new("pipeline_robustness_heap_buffer_access");

    add_buffer_access_tests(&mut buffer_access_tests, true, true);

    buffer_access_tests
}
