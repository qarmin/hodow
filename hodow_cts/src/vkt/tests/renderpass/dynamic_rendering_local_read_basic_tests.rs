// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/renderpass/vktDynamicRenderingLocalReadTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Copyright (c) 2023 Valve Corporation.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `LocalReadTestCase` for the test types `BasicLocalReadTestInstance` runs: max_input_attachments,
// max_attachments_remapped_repeatedly, input_attachments_without_mapping, unused_writen_discarded, the six depth_stencil_*/depth_mapping_* cases and
// the color_write_enable and extended_dynamic_state3 interactions. The pipelines are monolithic and built without `GraphicsPipelineWrapper`, and
// the log of the color attachments after a failure is dropped. With `secondary` every draw is recorded in a secondary command buffer.
// The shaders are `shaders/manifest/renderpass_local_read_basic.toml` (scripts/gen_local_read_basic_manifest.py), one set per test type.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    DeviceV1_3, ExtColorWriteEnableExtensionDeviceCommands, ExtExtendedDynamicState3ExtensionDeviceCommands,
    InstanceV1_1, KhrDynamicRenderingLocalReadExtensionDeviceCommands,
};

use super::dynamic_rendering_local_read_extra_tests::{ExtraLocalReadTestCase, ExtraType};
use crate::generated::shaders::renderpass_local_read_basic::{
    LRB_COLOR_WRITE, LRB_DEPTH_NOT_STENCIL, LRB_DS_DEPTH_CLEAR, LRB_DS_NO_INDEX, LRB_DS_STENCIL_CLEAR, LRB_LARGE_INDEX,
    LRB_MAX_INPUT, LRB_MAX_REMAPPED, LRB_SAME_INDEX, LRB_UNUSED_WRITTEN, LRB_WITHOUT_MAPPING,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_memory_barrier, make_pipeline_layout_with_push_constants,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{rect_2d, viewport};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const RENDER_SIZE: u32 = 16;
const UNUSED: u32 = vk::ATTACHMENT_UNUSED;

/// The `TestType`s `BasicLocalReadTestInstance` handles
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum BasicType {
    MaxInputAttachments,
    MaxAttachmentsRemappedRepeatedly,
    InputAttachmentsWithoutMapping,
    UnusedWritenDiscarded,
    DepthStencilMappingToNoIndex,
    DepthStencilMappingToNoIndexDepthClear,
    DepthStencilMappingToNoIndexStencilClear,
    DepthStencilMappingToSameIndex,
    DepthStencilMappingToLargeIndex,
    DepthMappingStencilNot,
    InteractionWithColorWriteEnable,
    InteractionWithExtendedDynamicState3,
}

impl BasicType {
    fn programs(self) -> BinaryCollection {
        match self {
            BasicType::MaxInputAttachments => LRB_MAX_INPUT.programs,
            BasicType::MaxAttachmentsRemappedRepeatedly => LRB_MAX_REMAPPED.programs,
            BasicType::InputAttachmentsWithoutMapping => LRB_WITHOUT_MAPPING.programs,
            BasicType::UnusedWritenDiscarded => LRB_UNUSED_WRITTEN.programs,
            BasicType::DepthStencilMappingToNoIndex => LRB_DS_NO_INDEX.programs,
            BasicType::DepthStencilMappingToNoIndexDepthClear => LRB_DS_DEPTH_CLEAR.programs,
            BasicType::DepthStencilMappingToNoIndexStencilClear => LRB_DS_STENCIL_CLEAR.programs,
            BasicType::DepthStencilMappingToSameIndex => LRB_SAME_INDEX.programs,
            BasicType::DepthStencilMappingToLargeIndex => LRB_LARGE_INDEX.programs,
            BasicType::DepthMappingStencilNot => LRB_DEPTH_NOT_STENCIL.programs,
            BasicType::InteractionWithColorWriteEnable | BasicType::InteractionWithExtendedDynamicState3 => {
                LRB_COLOR_WRITE.programs
            }
        }
    }

    fn reads_depth_stencil(self) -> bool {
        matches!(
            self,
            BasicType::DepthStencilMappingToSameIndex
                | BasicType::DepthStencilMappingToNoIndex
                | BasicType::DepthStencilMappingToLargeIndex
                | BasicType::DepthMappingStencilNot
                | BasicType::DepthStencilMappingToNoIndexDepthClear
                | BasicType::DepthStencilMappingToNoIndexStencilClear
        )
    }
}

fn drlr_vulkan14_properties(context: &Context<'_>) -> vk::PhysicalDeviceVulkan14Properties {
    let mut properties14 = vk::PhysicalDeviceVulkan14Properties::default();
    {
        let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut properties14);
        unsafe {
            context
                .get_instance()
                .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
        };
    }
    properties14
}

fn ds_format_supported(context: &Context<'_>, format: vk::Format) -> bool {
    unsafe {
        context.get_instance().get_physical_device_image_format_properties(
            context.get_physical_device(),
            format,
            vk::ImageType::_2D,
            vk::ImageTiling::OPTIMAL,
            vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT | vk::ImageUsageFlags::INPUT_ATTACHMENT,
            vk::ImageCreateFlags::empty(),
        )
    }
    .is_ok()
}

struct BasicLocalReadTestCase {
    name: &'static str,
    test_type: BasicType,
    secondary: bool,
}

impl TestCase for BasicLocalReadTestCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `LocalReadTestCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let test_type = self.test_type;
        context.require_device_functionality("VK_KHR_dynamic_rendering_local_read")?;

        match test_type {
            BasicType::DepthStencilMappingToLargeIndex => {
                if context
                    .get_device_properties()
                    .limits
                    .max_per_stage_descriptor_input_attachments
                    < 21
                {
                    return Err(TestError::NotSupported(
                        "maxPerStageDescriptorInputAttachments is too small".to_string(),
                    ));
                }
            }
            BasicType::DepthStencilMappingToNoIndexDepthClear | BasicType::DepthStencilMappingToNoIndexStencilClear => {
                let format = if test_type == BasicType::DepthStencilMappingToNoIndexStencilClear {
                    vk::Format::S8_UINT
                } else {
                    vk::Format::D32_SFLOAT
                };
                if !ds_format_supported(context, format) {
                    return Err(TestError::NotSupported(
                        "Depth/stencil format not supported".to_string(),
                    ));
                }
            }
            BasicType::InteractionWithColorWriteEnable => {
                context.require_device_functionality("VK_EXT_color_write_enable")?;
            }
            BasicType::InteractionWithExtendedDynamicState3 => {
                context.require_device_functionality("VK_EXT_extended_dynamic_state3")?;
                let mut features3 = vk::PhysicalDeviceExtendedDynamicState3FeaturesEXT::default();
                {
                    let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features3);
                    unsafe {
                        context
                            .get_instance()
                            .get_physical_device_features2(context.get_physical_device(), &mut features2)
                    };
                }
                if features3.extended_dynamic_state3_rasterization_samples == vk::FALSE {
                    return Err(TestError::NotSupported(
                        "extendedDynamicState3RasterizationSamples not supported".to_string(),
                    ));
                }
            }
            _ => {}
        }

        if context.api_version() > (1, 3, 0)
            && drlr_vulkan14_properties(context).dynamic_rendering_local_read_depth_stencil_attachments == vk::FALSE
            && test_type.reads_depth_stencil()
        {
            return Err(TestError::NotSupported(
                "dynamicRenderingLocalReadDepthStencilAttachments not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.test_type.programs()
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(BasicLocalReadTestInstance {
            context,
            test_type: self.test_type,
            secondary: self.secondary,
        })
    }
}

struct BasicLocalReadTestInstance<'a> {
    context: &'a Context<'a>,
    test_type: BasicType,
    secondary: bool,
}

impl TestInstance for BasicLocalReadTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let config = Config::new(self.context, self.test_type);
        run_basic(self.context, self.test_type, config, self.secondary)
    }
}

/// The members `BasicLocalReadTestInstance`'s constructor sets up
struct Config {
    ds_format: vk::Format,
    ds_aspect_mask: vk::ImageAspectFlags,
    ds_clear_value: vk::ClearDepthStencilValue,
    color_attachment_count: u32,
    input_draws_count: u32,
    output_draws_count: u32,
    write_frag_name: String,
    read_frag_name: String,
    color_attachment_locations: Vec<Vec<u32>>,
    color_attachment_input_indices: Vec<Vec<u32>>,
    depth_input_attachment_index: u32,
    stencil_input_attachment_index: u32,
    color_write_enables: [vk::Bool32; 4],
    use_mapping: bool,
    use_depth_in_read_frag: bool,
    use_stencil_in_read_frag: bool,
    expected_values: Vec<u32>,
}

impl Config {
    fn new(context: &Context<'_>, test_type: BasicType) -> Self {
        let limits = &context.get_device_properties().limits;

        let mut config = Config {
            ds_format: vk::Format::D24_UNORM_S8_UINT,
            ds_aspect_mask: vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL,
            ds_clear_value: vk::ClearDepthStencilValue { depth: 0.0, stencil: 0 },
            color_attachment_count: 4,
            input_draws_count: 1,
            output_draws_count: 1,
            write_frag_name: "frag0".to_string(),
            read_frag_name: "frag1".to_string(),
            color_attachment_locations: vec![vec![0, 1, 2, 3]],
            color_attachment_input_indices: vec![vec![0, 1, 2, 3]],
            depth_input_attachment_index: 4,
            stencil_input_attachment_index: 5,
            color_write_enables: [0, 1, 0, 1],
            use_mapping: true,
            use_depth_in_read_frag: true,
            use_stencil_in_read_frag: true,
            expected_values: vec![0],
        };

        // pick depth stencil format (one of those two has to be supported)
        if !ds_format_supported(context, config.ds_format) {
            config.ds_format = vk::Format::D32_SFLOAT_S8_UINT;
        }

        // after promoting DRLR to vk1.4 reading depth/stencil is guarded by a property
        let read_depth_stencil = context.api_version() < (1, 4, 0)
            || drlr_vulkan14_properties(context).dynamic_rendering_local_read_depth_stencil_attachments != vk::FALSE;

        match test_type {
            BasicType::MaxInputAttachments => {
                let ds_attachments_count = 2 * u32::from(read_depth_stencil);
                config.color_attachment_count = limits
                    .max_color_attachments
                    .min(limits.max_per_stage_descriptor_input_attachments - ds_attachments_count);

                config.write_frag_name += &format!("_{}", config.color_attachment_count);
                config.read_frag_name += &format!("_{}", config.color_attachment_count + ds_attachments_count);
                config.depth_input_attachment_index = config.color_attachment_count;
                config.stencil_input_attachment_index = config.color_attachment_count + 1;

                let count = config.color_attachment_count as usize;
                config.color_attachment_locations[0] = (0..count as u32).collect();
                config.color_attachment_input_indices[0] = (0..count as u32).collect();
            }
            BasicType::MaxAttachmentsRemappedRepeatedly => {
                let ds_attachments_count = 2 * u32::from(read_depth_stencil);
                config.color_attachment_count = limits
                    .max_color_attachments
                    .min(limits.max_per_stage_descriptor_input_attachments - ds_attachments_count);
                config.input_draws_count = config.color_attachment_count / 2;
                config.color_attachment_count = config.input_draws_count * 2;
                config.output_draws_count = 3;
                config.read_frag_name += &format!("_{}", config.color_attachment_count + ds_attachments_count);
                config.depth_input_attachment_index = config.color_attachment_count;
                config.stencil_input_attachment_index = config.color_attachment_count + 1;

                // each input draw uses just two color attachments; each time its different pair that is always mapped to location 0 and 1
                let count = config.color_attachment_count as usize;
                config.color_attachment_locations = vec![vec![UNUSED; count]; config.input_draws_count as usize];
                for input_draw in 0..config.input_draws_count as usize {
                    let index = 2 * input_draw;
                    config.color_attachment_locations[input_draw][index] = 0;
                    config.color_attachment_locations[input_draw][index + 1] = 1;
                }

                // each output draw will use all input attachments but remapped differently
                config.color_attachment_input_indices = vec![vec![0; count]; config.output_draws_count as usize];
                let total = config.color_attachment_count;
                for att_index in 0..total {
                    config.color_attachment_input_indices[0][att_index as usize] = total - 1 - att_index;
                    config.color_attachment_input_indices[1][att_index as usize] = if att_index % 2 != 0 {
                        total - 1 - att_index / 2
                    } else {
                        att_index / 2
                    };
                    config.color_attachment_input_indices[2][att_index as usize] = att_index;
                }
            }
            BasicType::InputAttachmentsWithoutMapping => {
                config.use_stencil_in_read_frag = false;
                config.color_attachment_count = 3;
                config.use_mapping = false;
                config.stencil_input_attachment_index = UNUSED;
            }
            BasicType::UnusedWritenDiscarded => {
                config.use_stencil_in_read_frag = true;
                config.color_attachment_count = 4;
                config.color_attachment_locations[0][0] = UNUSED;
                config.color_attachment_locations[0][2] = UNUSED;
            }
            BasicType::DepthStencilMappingToNoIndex => {
                config.use_stencil_in_read_frag = true;
                config.color_attachment_count = 2;
                config.depth_input_attachment_index = UNUSED;
                config.stencil_input_attachment_index = UNUSED;
            }
            BasicType::DepthStencilMappingToNoIndexDepthClear => {
                config.ds_format = vk::Format::D32_SFLOAT;
                config.ds_aspect_mask = vk::ImageAspectFlags::DEPTH;
                config.ds_clear_value = vk::ClearDepthStencilValue { depth: 0.4, stencil: 1 };
                config.input_draws_count = 0;
                config.use_stencil_in_read_frag = false;
                config.color_attachment_count = 0;
            }
            BasicType::DepthStencilMappingToNoIndexStencilClear => {
                config.ds_format = vk::Format::S8_UINT;
                config.ds_aspect_mask = vk::ImageAspectFlags::STENCIL;
                config.ds_clear_value = vk::ClearDepthStencilValue { depth: 0.6, stencil: 5 };
                config.input_draws_count = 0;
                config.use_depth_in_read_frag = false;
                config.color_attachment_count = 0;
            }
            BasicType::DepthStencilMappingToSameIndex => {
                config.use_stencil_in_read_frag = true;
                config.color_attachment_count = 2;
                config.depth_input_attachment_index = 2;
                config.stencil_input_attachment_index = 2;
            }
            BasicType::DepthStencilMappingToLargeIndex => {
                config.use_stencil_in_read_frag = true;
                config.color_attachment_count = 2;
                config.depth_input_attachment_index = 20;
                config.stencil_input_attachment_index = 21;
            }
            BasicType::DepthMappingStencilNot => {
                config.use_stencil_in_read_frag = false;
                config.color_attachment_count = 4;
                config.depth_input_attachment_index = 4;
                config.stencil_input_attachment_index = UNUSED;
            }
            BasicType::InteractionWithColorWriteEnable | BasicType::InteractionWithExtendedDynamicState3 => {
                config.use_stencil_in_read_frag = false;
                config.color_attachment_count = 4;
                config.color_attachment_locations = vec![vec![0, 3, 1, 2]];
                config.depth_input_attachment_index = 4;
                config.stencil_input_attachment_index = UNUSED;
            }
        }

        // overwrite some of the configuration for vk1.4 when dynamicRenderingLocalReadDepthStencilAttachments is not available, to allow some
        // tests to be executed without a depth/stencil attachment
        if !read_depth_stencil {
            if config.use_depth_in_read_frag || config.use_stencil_in_read_frag {
                config.read_frag_name += "_no_ds";
            }
            config.use_depth_in_read_frag = false;
            config.use_stencil_in_read_frag = false;
            config.depth_input_attachment_index = UNUSED;
            config.stencil_input_attachment_index = UNUSED;
        }

        config.calculate_expected_values(test_type);
        config
    }

    /// `GetRemappedColorAttachment`
    fn remapped_color_attachment(&self, input_draw_id: usize, location: u32) -> u32 {
        for i in 0..self.color_attachment_count {
            if location == self.color_attachment_locations[input_draw_id][i as usize] {
                return i;
            }
        }
        UNUSED
    }

    /// `GetRemappedColorInputAttachment`
    fn remapped_color_input_attachment(&self, output_draw_id: usize, input_attachment_idx: u32) -> u32 {
        for i in 0..self.color_attachment_count {
            if input_attachment_idx == self.color_attachment_input_indices[output_draw_id][i as usize] {
                return i;
            }
        }
        UNUSED
    }

    /// `CalculateExpectedValues`
    fn calculate_expected_values(&mut self, test_type: BasicType) {
        let use_color_write_enable = test_type == BasicType::InteractionWithColorWriteEnable;

        // generate same values for each attachment as in the frag0 shader
        let mut values_per_color_attachment = vec![0u32; self.color_attachment_count as usize];

        for input_draw in 0..self.input_draws_count {
            for color_idx in 0..self.color_attachment_count / self.input_draws_count {
                let mut out_color = 0u32;
                let att_index_remapped = self.remapped_color_attachment(input_draw as usize, color_idx);

                if !use_color_write_enable || self.color_write_enables[att_index_remapped as usize] == 1 {
                    let value = 2 * input_draw + color_idx + 1;
                    out_color = value * value;
                }

                if att_index_remapped != UNUSED {
                    values_per_color_attachment[att_index_remapped as usize] = out_color;
                }
            }
        }

        // calculate expected values for all output draws, same as it will be done in the frag1 shader
        self.expected_values = vec![0; self.output_draws_count as usize];

        for output_draw in 0..self.output_draws_count as usize {
            // Depth read is 0.6 and stencil read is 1, except for the two clear cases.
            let depth_read = (if test_type == BasicType::DepthStencilMappingToNoIndexDepthClear {
                0.4f32
            } else {
                0.6f32
            } * 1000.0) as u32;
            let stencil_read = if test_type == BasicType::DepthStencilMappingToNoIndexStencilClear {
                5
            } else {
                1
            };

            self.expected_values[output_draw] = match test_type {
                BasicType::DepthStencilMappingToNoIndex => {
                    // Depth read and stencil read are both enabled
                    depth_read + stencil_read * 100
                }
                BasicType::DepthStencilMappingToSameIndex
                | BasicType::DepthStencilMappingToLargeIndex
                | BasicType::DepthStencilMappingToNoIndexDepthClear
                | BasicType::DepthStencilMappingToNoIndexStencilClear => {
                    u32::from(self.use_depth_in_read_frag) * depth_read
                        + u32::from(self.use_stencil_in_read_frag) * stencil_read
                }
                _ => {
                    u32::from(self.use_depth_in_read_frag) * depth_read
                        + u32::from(self.use_stencil_in_read_frag) * stencil_read * 1000
                }
            };

            // each output draw uses all attachments but remapped differently
            for att_index in 0..self.color_attachment_count {
                let att_index_remapped = self.remapped_color_input_attachment(output_draw, att_index);
                let value = values_per_color_attachment[att_index_remapped as usize];

                match test_type {
                    BasicType::DepthStencilMappingToNoIndex => {
                        // Accumulate inColor_i, in which inColor_i is the color attachment with location = i in shader
                        self.expected_values[output_draw] += value;
                    }
                    BasicType::DepthStencilMappingToSameIndex | BasicType::DepthStencilMappingToLargeIndex => {
                        // No color is read
                        break;
                    }
                    _ => {
                        // Accumulate i * inColor_i, in which inColor_i is the color attachment with location = i in shader
                        self.expected_values[output_draw] += (att_index + 1) * value;
                    }
                }
            }
        }
    }
}

fn make_image<'a>(
    context: &'a Context<'_>,
    format: vk::Format,
    usage: vk::ImageUsageFlags,
) -> Result<ImageWithMemory<'a>, TestError> {
    let create_info = vk::ImageCreateInfo {
        s_type: vk::StructureType::IMAGE_CREATE_INFO,
        next: std::ptr::null(),
        flags: vk::ImageCreateFlags::empty(),
        image_type: vk::ImageType::_2D,
        format,
        extent: vk::Extent3D {
            width: RENDER_SIZE,
            height: RENDER_SIZE,
            depth: 1,
        },
        mip_levels: 1,
        array_layers: 1,
        samples: vk::SampleCountFlags::_1,
        tiling: vk::ImageTiling::OPTIMAL,
        usage,
        sharing_mode: vk::SharingMode::EXCLUSIVE,
        queue_family_index_count: 0,
        queue_family_indices: std::ptr::null(),
        initial_layout: vk::ImageLayout::UNDEFINED,
    };
    ImageWithMemory::new(
        context.get_device(),
        context.get_default_allocator(),
        create_info,
        MemoryRequirement::ANY,
    )
}

pub(super) fn write_input_attachment(device: &Device, set: vk::DescriptorSet, binding: u32, view: vk::ImageView) {
    let info = vk::DescriptorImageInfo {
        sampler: vk::Sampler::null(),
        image_view: view,
        image_layout: vk::ImageLayout::RENDERING_LOCAL_READ,
    };
    let write = vk::WriteDescriptorSet {
        s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
        next: std::ptr::null(),
        dst_set: set,
        dst_binding: binding,
        dst_array_element: 0,
        descriptor_count: 1,
        descriptor_type: vk::DescriptorType::INPUT_ATTACHMENT,
        image_info: &info,
        buffer_info: std::ptr::null(),
        texel_buffer_view: std::ptr::null(),
    };
    unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };
}

pub(super) fn write_storage_buffer(device: &Device, set: vk::DescriptorSet, buffer: vk::Buffer) {
    let info = vk::DescriptorBufferInfo {
        buffer,
        offset: 0,
        range: vk::WHOLE_SIZE,
    };
    let write = vk::WriteDescriptorSet {
        s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
        next: std::ptr::null(),
        dst_set: set,
        dst_binding: 0,
        dst_array_element: 0,
        descriptor_count: 1,
        descriptor_type: vk::DescriptorType::STORAGE_BUFFER,
        image_info: std::ptr::null(),
        buffer_info: &info,
        texel_buffer_view: std::ptr::null(),
    };
    unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };
}

pub(super) struct PipelineSetup<'a> {
    pub(super) layout: vk::PipelineLayout,
    pub(super) vert: vk::ShaderModule,
    pub(super) frag: vk::ShaderModule,
    pub(super) color_formats: &'a [vk::Format],
    pub(super) depth_format: vk::Format,
    pub(super) stencil_format: vk::Format,
    pub(super) blend_states: &'a [vk::PipelineColorBlendAttachmentState],
    pub(super) samples: vk::SampleCountFlags,
    pub(super) sample_shading: bool,
    pub(super) depth_stencil: vk::PipelineDepthStencilStateCreateInfo,
    pub(super) dynamic_state: Option<vk::DynamicState>,
    pub(super) location_info: Option<vk::RenderingAttachmentLocationInfo>,
    pub(super) input_index_info: Option<vk::RenderingInputAttachmentIndexInfo>,
}

pub(super) fn make_pipeline<'a>(
    device: &'a Device,
    setup: &PipelineSetup<'_>,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let stages = [
        vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::VERTEX)
            .module(setup.vert)
            .name(b"main\0")
            .build(),
        vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::FRAGMENT)
            .module(setup.frag)
            .name(b"main\0")
            .build(),
    ];
    let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder();
    let input_assembly_state =
        vk::PipelineInputAssemblyStateCreateInfo::builder().topology(vk::PrimitiveTopology::TRIANGLE_STRIP);
    let viewports = [viewport(0.0, 0.0, RENDER_SIZE as f32, RENDER_SIZE as f32, 0.0, 1.0)];
    let scissors = [rect_2d(RENDER_SIZE, RENDER_SIZE)];
    let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
        .viewports(&viewports)
        .scissors(&scissors);
    let rasterization_state = vk::PipelineRasterizationStateCreateInfo::builder()
        .depth_clamp_enable(false)
        .rasterizer_discard_enable(false)
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(vk::CullModeFlags::NONE)
        .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
        .depth_bias_enable(false)
        .line_width(1.0);
    let multisample_state = vk::PipelineMultisampleStateCreateInfo::builder()
        .rasterization_samples(setup.samples)
        .sample_shading_enable(setup.sample_shading)
        .min_sample_shading(1.0);
    let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder().attachments(setup.blend_states);

    let dynamic_states: Vec<vk::DynamicState> = setup.dynamic_state.into_iter().collect();
    let dynamic_state = vk::PipelineDynamicStateCreateInfo::builder().dynamic_states(&dynamic_states);

    let mut rendering_create_info = vk::PipelineRenderingCreateInfo::builder()
        .view_mask(0)
        .color_attachment_formats(setup.color_formats)
        .depth_attachment_format(setup.depth_format)
        .stencil_attachment_format(setup.stencil_format);

    let mut location_info = setup.location_info;
    let mut input_index_info = setup.input_index_info;

    let mut info = vk::GraphicsPipelineCreateInfo::builder()
        .stages(&stages)
        .vertex_input_state(&vertex_input_state)
        .input_assembly_state(&input_assembly_state)
        .viewport_state(&viewport_state)
        .rasterization_state(&rasterization_state)
        .multisample_state(&multisample_state)
        .depth_stencil_state(&setup.depth_stencil)
        .color_blend_state(&color_blend_state)
        .dynamic_state(&dynamic_state)
        .layout(setup.layout)
        .render_pass(vk::RenderPass::null())
        .subpass(0)
        .base_pipeline_index(0)
        .push_next(&mut rendering_create_info);
    if let Some(location_info) = location_info.as_mut() {
        info = info.push_next(location_info);
    }
    if let Some(input_index_info) = input_index_info.as_mut() {
        info = info.push_next(input_index_info);
    }

    let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[info], None) }
        .vk_check("vkCreateGraphicsPipelines")?;
    Ok(Unique::new(device, pipelines.0[0]))
}

/// `vkBeginCommandBuffer` of a secondary command buffer that continues a dynamic rendering pass (`VkCommandBufferInheritanceRenderingInfo`), whose
/// `pNext` chain is `next`
pub(super) fn begin_secondary_rendering_buffer(
    device: &Device,
    cmd: vk::CommandBuffer,
    next: *const std::ffi::c_void,
    color_formats: &[vk::Format],
    depth_format: vk::Format,
    stencil_format: vk::Format,
    samples: vk::SampleCountFlags,
) -> Result<(), TestError> {
    let rendering = vk::CommandBufferInheritanceRenderingInfo {
        s_type: vk::StructureType::COMMAND_BUFFER_INHERITANCE_RENDERING_INFO,
        next,
        flags: vk::RenderingFlags::empty(),
        view_mask: 0,
        color_attachment_count: color_formats.len() as u32,
        color_attachment_formats: ptr_or_null(color_formats),
        depth_attachment_format: depth_format,
        stencil_attachment_format: stencil_format,
        rasterization_samples: samples,
    };
    let inheritance = vk::CommandBufferInheritanceInfo {
        s_type: vk::StructureType::COMMAND_BUFFER_INHERITANCE_INFO,
        next: (&raw const rendering).cast(),
        render_pass: vk::RenderPass::null(),
        subpass: 0,
        framebuffer: vk::Framebuffer::null(),
        occlusion_query_enable: vk::FALSE,
        query_flags: vk::QueryControlFlags::empty(),
        pipeline_statistics: vk::QueryPipelineStatisticFlags::empty(),
    };
    let info = vk::CommandBufferBeginInfo {
        s_type: vk::StructureType::COMMAND_BUFFER_BEGIN_INFO,
        next: std::ptr::null(),
        flags: vk::CommandBufferUsageFlags::RENDER_PASS_CONTINUE,
        inheritance_info: &inheritance,
    };
    unsafe { device.begin_command_buffer(cmd, &info) }.vk_check("vkBeginCommandBuffer")
}

pub(super) fn ptr_or_null<T>(items: &[T]) -> *const T {
    if items.is_empty() {
        std::ptr::null()
    } else {
        items.as_ptr()
    }
}

/// `BasicLocalReadTestInstance::iterate`
fn run_basic(context: &Context<'_>, test_type: BasicType, mut config: Config, secondary: bool) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let allocator = context.get_default_allocator();

    let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let d_srr = make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, 0, 1);
    let s_srr = make_image_subresource_range(vk::ImageAspectFlags::STENCIL, 0, 1, 0, 1);
    let ds_srr = make_image_subresource_range(config.ds_aspect_mask, 0, 1, 0, 1);
    let actual_sample_count = vk::SampleCountFlags::_1;

    let use_depth_aspect = config.ds_aspect_mask.contains(vk::ImageAspectFlags::DEPTH);
    let use_stencil_aspect = config.ds_aspect_mask.contains(vk::ImageAspectFlags::STENCIL);
    let use_color_write_enable = test_type == BasicType::InteractionWithColorWriteEnable;
    let use_extended_dynamic_state3 = test_type == BasicType::InteractionWithExtendedDynamicState3;

    let color_count = config.color_attachment_count as usize;
    let color_image_formats = vec![vk::Format::R32_UINT; color_count];

    let image_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT
        | vk::ImageUsageFlags::INPUT_ATTACHMENT
        | vk::ImageUsageFlags::TRANSFER_DST
        | vk::ImageUsageFlags::TRANSFER_SRC;

    // create images and image views for the color attachments
    let mut color_images: Vec<ImageWithMemory<'_>> = Vec::new();
    let mut color_views: Vec<Unique<'_, vk::ImageView>> = Vec::new();
    for _ in 0..color_count {
        let image = make_image(context, vk::Format::R32_UINT, image_usage)?;
        color_views.push(make_image_view(
            device,
            image.get(),
            vk::ImageViewType::_2D,
            vk::Format::R32_UINT,
            color_srr,
        )?);
        color_images.push(image);
    }

    // create image and image views for the depth/stencil attachments
    let ds_image = make_image(
        context,
        config.ds_format,
        vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT
            | vk::ImageUsageFlags::INPUT_ATTACHMENT
            | vk::ImageUsageFlags::TRANSFER_DST,
    )?;
    let depth_view = if use_depth_aspect {
        Some(make_image_view(
            device,
            ds_image.get(),
            vk::ImageViewType::_2D,
            config.ds_format,
            d_srr,
        )?)
    } else {
        None
    };
    let stencil_view = if use_stencil_aspect {
        Some(make_image_view(
            device,
            ds_image.get(),
            vk::ImageViewType::_2D,
            config.ds_format,
            s_srr,
        )?)
    } else {
        None
    };
    let ds_view = make_image_view(device, ds_image.get(), vk::ImageViewType::_2D, config.ds_format, ds_srr)?;

    // define buffers for output
    let output_buffer_size = u64::from(RENDER_SIZE * RENDER_SIZE) * 4;
    let mut output_buffers: Vec<BufferWithMemory<'_>> = Vec::new();
    for _ in 0..config.output_draws_count {
        output_buffers.push(BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                output_buffer_size,
                vk::BufferUsageFlags::STORAGE_BUFFER | vk::BufferUsageFlags::TRANSFER_SRC,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?);
    }

    // create descriptors, they are needed just for the read pipelines
    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(
            vk::DescriptorType::INPUT_ATTACHMENT,
            (config.color_attachment_count + 2) * config.output_draws_count,
        )
        .add_type(vk::DescriptorType::STORAGE_BUFFER, config.output_draws_count)
        .build(
            device,
            vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
            2 * config.output_draws_count,
        )?;

    // first descriptor set contains all input attachments
    let mut set_layout_a_builder = DescriptorSetLayoutBuilder::new();
    for _ in 0..config.color_attachment_count + 2 {
        set_layout_a_builder = set_layout_a_builder
            .add_single_binding(vk::DescriptorType::INPUT_ATTACHMENT, vk::ShaderStageFlags::FRAGMENT);
    }
    let descriptor_set_layout_a = set_layout_a_builder.build(device)?;

    // second and following descriptor sets contain just a single output buffer each
    let descriptor_set_layout_b = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::FRAGMENT)
        .build(device)?;

    let mut buffer_descriptor_sets = Vec::new();
    let mut input_attachments_descriptor_sets = Vec::new();
    for _ in 0..config.output_draws_count {
        input_attachments_descriptor_sets.push(make_descriptor_set(
            device,
            *descriptor_pool,
            *descriptor_set_layout_a,
        )?);
        buffer_descriptor_sets.push(make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout_b)?);
    }

    // set descriptor sets for all input attachments
    for i in 0..config.output_draws_count as usize {
        // content of the descriptor set with input attachment bindings must be consistent with the remapping
        for att_index in 0..config.color_attachment_count {
            let remapped_index = config.remapped_color_input_attachment(i, att_index);
            write_input_attachment(
                device,
                input_attachments_descriptor_sets[i].get(),
                att_index,
                *color_views[remapped_index as usize],
            );
        }
        if let Some(view) = &depth_view {
            write_input_attachment(
                device,
                input_attachments_descriptor_sets[i].get(),
                config.color_attachment_count,
                **view,
            );
        }
        if let Some(view) = &stencil_view {
            write_input_attachment(
                device,
                input_attachments_descriptor_sets[i].get(),
                config.color_attachment_count + u32::from(use_depth_aspect),
                **view,
            );
        }
    }

    // set descriptor sets for all output buffers
    for (set, buffer) in buffer_descriptor_sets.iter().zip(&output_buffers) {
        write_storage_buffer(device, set.get(), buffer.get());
    }

    // reuse the MAX_INPUT_ATTACHMENTS case to also test pColorAttachmentInputIndices set to NULL
    if test_type == BasicType::MaxInputAttachments {
        config.color_attachment_input_indices[0].clear();
    }

    // create components for pipelines
    let push_constant_range = vk::PushConstantRange {
        stage_flags: vk::ShaderStageFlags::FRAGMENT,
        offset: 0,
        size: 4,
    };
    let write_pipeline_layout = make_pipeline_layout_with_push_constants(device, &[], &[push_constant_range])?;
    let read_pipeline_layout =
        make_pipeline_layout_with_push_constants(device, &[*descriptor_set_layout_a, *descriptor_set_layout_b], &[])?;
    let binaries = context.get_binary_collection();
    let vert_shader = create_shader_module(device, binaries.get("vert")?)?;
    let write_frag_shader = create_shader_module(device, binaries.get(&config.write_frag_name)?)?;
    let read_frag_shader = create_shader_module(device, binaries.get(&config.read_frag_name)?)?;

    // define ColorBlendState so that we can write to multiple color attachments
    let mut color_blend_attachment_states = vec![
        vk::PipelineColorBlendAttachmentState::builder()
            .blend_enable(false)
            .src_color_blend_factor(vk::BlendFactor::ZERO)
            .dst_color_blend_factor(vk::BlendFactor::ZERO)
            .color_blend_op(vk::BlendOp::ADD)
            .src_alpha_blend_factor(vk::BlendFactor::ZERO)
            .dst_alpha_blend_factor(vk::BlendFactor::ZERO)
            .alpha_blend_op(vk::BlendOp::ADD)
            .color_write_mask(vk::ColorComponentFlags::all())
            .build();
        color_count
    ];

    // MultisampleState is only needed to test that vkCmdSetRasterizationSamplesEXT does not affect the local_read remappings
    let write_samples = if use_extended_dynamic_state3 {
        vk::SampleCountFlags::_2
    } else {
        actual_sample_count
    };

    // define DepthStencilState so that we can write to the depth and stencil attachments
    let stencil_op_state = vk::StencilOpState {
        fail_op: vk::StencilOp::KEEP,
        pass_op: vk::StencilOp::INCREMENT_AND_CLAMP,
        depth_fail_op: vk::StencilOp::KEEP,
        compare_op: vk::CompareOp::ALWAYS,
        compare_mask: 0xff,
        write_mask: 0xff,
        reference: 0,
    };
    let mut depth_stencil_state = vk::PipelineDepthStencilStateCreateInfo {
        s_type: vk::StructureType::PIPELINE_DEPTH_STENCIL_STATE_CREATE_INFO,
        next: std::ptr::null(),
        flags: vk::PipelineDepthStencilStateCreateFlags::empty(),
        depth_test_enable: vk::Bool32::from(use_depth_aspect),
        depth_write_enable: vk::TRUE,
        depth_compare_op: vk::CompareOp::GREATER,
        depth_bounds_test_enable: vk::FALSE,
        stencil_test_enable: vk::Bool32::from(use_stencil_aspect),
        front: stencil_op_state,
        back: stencil_op_state,
        min_depth_bounds: 0.0,
        max_depth_bounds: 1.0,
    };
    let default_depth_stencil_state = vk::PipelineDepthStencilStateCreateInfo::default();

    let write_dynamic_state = if use_color_write_enable {
        Some(vk::DynamicState::COLOR_WRITE_ENABLE_EXT)
    } else if use_extended_dynamic_state3 {
        Some(vk::DynamicState::RASTERIZATION_SAMPLES_EXT)
    } else {
        None
    };

    let use_ds_input_attachment_index = use_depth_aspect && use_stencil_aspect;
    let rendering_depth_format = if use_depth_aspect {
        config.ds_format
    } else {
        vk::Format::UNDEFINED
    };
    let rendering_stencil_format = if use_stencil_aspect {
        config.ds_format
    } else {
        vk::Format::UNDEFINED
    };

    // create write pipelines that write to the color attachments
    let mut write_pipelines: Vec<Unique<'_, vk::Pipeline>> = Vec::new();
    for pipeline_index in 0..config.input_draws_count as usize {
        let location_info = config.use_mapping.then(|| vk::RenderingAttachmentLocationInfo {
            s_type: vk::StructureType::RENDERING_ATTACHMENT_LOCATION_INFO,
            next: std::ptr::null(),
            color_attachment_count: config.color_attachment_count,
            color_attachment_locations: config.color_attachment_locations[pipeline_index].as_ptr(),
        });
        write_pipelines.push(make_pipeline(
            device,
            &PipelineSetup {
                layout: *write_pipeline_layout,
                vert: *vert_shader,
                frag: *write_frag_shader,
                color_formats: &color_image_formats,
                depth_format: rendering_depth_format,
                stencil_format: rendering_stencil_format,
                blend_states: &color_blend_attachment_states,
                samples: write_samples,
                sample_shading: false,
                depth_stencil: depth_stencil_state,
                dynamic_state: write_dynamic_state,
                location_info,
                input_index_info: None,
            },
        )?);

        // write to depth and stencil only in the first pipeline
        depth_stencil_state.depth_test_enable = vk::FALSE;
        depth_stencil_state.stencil_test_enable = vk::FALSE;
    }

    // read pipelines don't write to the color attachments
    for state in &mut color_blend_attachment_states {
        state.color_write_mask = vk::ColorComponentFlags::empty();
    }

    // Per spec, if either of pDepthInputAttachmentIndex or pStencilInputAttachmentIndex is set to NULL, these are only accessible in the shader
    // if the shader does not associate these input attachments with an InputAttachmentIndex.
    let pass_ds_input_indices = use_ds_input_attachment_index && test_type != BasicType::DepthStencilMappingToNoIndex;

    let mut read_pipelines: Vec<Unique<'_, vk::Pipeline>> = Vec::new();
    for pipeline_index in 0..config.output_draws_count as usize {
        // In some depth/stencil input tests, simultaneously write to depth/stencil. The read should happen before the depth/stencil write.
        let write_to_depth_stencil = matches!(
            test_type,
            BasicType::DepthStencilMappingToNoIndexDepthClear | BasicType::DepthStencilMappingToNoIndexStencilClear
        );
        let mut overwrite_state = depth_stencil_state;
        overwrite_state.depth_compare_op = vk::CompareOp::ALWAYS;
        overwrite_state.front.fail_op = vk::StencilOp::INCREMENT_AND_CLAMP;
        overwrite_state.front.pass_op = vk::StencilOp::INCREMENT_AND_CLAMP;
        overwrite_state.front.depth_fail_op = vk::StencilOp::INCREMENT_AND_CLAMP;
        overwrite_state.back.fail_op = vk::StencilOp::INCREMENT_AND_CLAMP;
        overwrite_state.back.pass_op = vk::StencilOp::INCREMENT_AND_CLAMP;
        overwrite_state.back.depth_fail_op = vk::StencilOp::INCREMENT_AND_CLAMP;

        let input_index_info = config.use_mapping.then(|| vk::RenderingInputAttachmentIndexInfo {
            s_type: vk::StructureType::RENDERING_INPUT_ATTACHMENT_INDEX_INFO,
            next: std::ptr::null(),
            color_attachment_count: config.color_attachment_count,
            color_attachment_input_indices: ptr_or_null(&config.color_attachment_input_indices[pipeline_index]),
            depth_input_attachment_index: if pass_ds_input_indices {
                &config.depth_input_attachment_index
            } else {
                std::ptr::null()
            },
            stencil_input_attachment_index: if pass_ds_input_indices {
                &config.stencil_input_attachment_index
            } else {
                std::ptr::null()
            },
        });
        read_pipelines.push(make_pipeline(
            device,
            &PipelineSetup {
                layout: *read_pipeline_layout,
                vert: *vert_shader,
                frag: *read_frag_shader,
                color_formats: &color_image_formats,
                depth_format: rendering_depth_format,
                stencil_format: rendering_stencil_format,
                blend_states: &color_blend_attachment_states,
                samples: actual_sample_count,
                sample_shading: false,
                depth_stencil: if write_to_depth_stencil {
                    overwrite_state
                } else {
                    default_depth_stencil_state
                },
                dynamic_state: None,
                location_info: None,
                input_index_info,
            },
        )?);
    }

    // rendering info
    let clear_value = vk::ClearValue {
        depth_stencil: config.ds_clear_value,
    };
    let make_attachment = |view: vk::ImageView| vk::RenderingAttachmentInfo {
        s_type: vk::StructureType::RENDERING_ATTACHMENT_INFO,
        next: std::ptr::null(),
        image_view: view,
        image_layout: vk::ImageLayout::RENDERING_LOCAL_READ,
        resolve_mode: vk::ResolveModeFlags::NONE,
        resolve_image_view: vk::ImageView::null(),
        resolve_image_layout: vk::ImageLayout::UNDEFINED,
        load_op: vk::AttachmentLoadOp::CLEAR,
        store_op: vk::AttachmentStoreOp::STORE,
        clear_value,
    };
    let color_attachments: Vec<vk::RenderingAttachmentInfo> =
        color_views.iter().map(|view| make_attachment(**view)).collect();
    let depth_stencil_attachment = make_attachment(*ds_view);

    let render_area = rect_2d(RENDER_SIZE, RENDER_SIZE);
    let rendering_info = vk::RenderingInfo {
        s_type: vk::StructureType::RENDERING_INFO,
        next: std::ptr::null(),
        flags: if secondary {
            vk::RenderingFlags::CONTENTS_SECONDARY_COMMAND_BUFFERS
        } else {
            vk::RenderingFlags::empty()
        },
        render_area,
        layer_count: 1,
        view_mask: 0,
        color_attachment_count: config.color_attachment_count,
        color_attachments: ptr_or_null(&color_attachments),
        depth_attachment: if use_depth_aspect {
            &depth_stencil_attachment
        } else {
            std::ptr::null()
        },
        stencil_attachment: if use_stencil_aspect {
            &depth_stencil_attachment
        } else {
            std::ptr::null()
        },
    };

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    let record_input = |cmd: vk::CommandBuffer, index: usize| unsafe {
        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, write_pipelines[index].get());
        if use_color_write_enable {
            device.cmd_set_color_write_enable_ext(cmd, &config.color_write_enables);
        }
        if use_extended_dynamic_state3 {
            device.cmd_set_rasterization_samples_ext(cmd, actual_sample_count);
        }
        device.cmd_push_constants(
            cmd,
            *write_pipeline_layout,
            vk::ShaderStageFlags::FRAGMENT,
            0,
            &(index as u32).to_ne_bytes(),
        );
        device.cmd_draw(cmd, 4, 1, 0, 0);
    };

    let record_output = |cmd: vk::CommandBuffer, index: usize| unsafe {
        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, read_pipelines[index].get());
        device.cmd_bind_descriptor_sets(
            cmd,
            vk::PipelineBindPoint::GRAPHICS,
            *read_pipeline_layout,
            0,
            &[
                input_attachments_descriptor_sets[index].get(),
                buffer_descriptor_sets[index].get(),
            ],
            &[] as &[u32],
        );
        device.cmd_draw(cmd, 4, 1, 0, 0);
    };

    let input_index_info_for = |index: usize| vk::RenderingInputAttachmentIndexInfo {
        s_type: vk::StructureType::RENDERING_INPUT_ATTACHMENT_INDEX_INFO,
        next: std::ptr::null(),
        color_attachment_count: config.color_attachment_count,
        color_attachment_input_indices: ptr_or_null(&config.color_attachment_input_indices[index]),
        depth_input_attachment_index: if pass_ds_input_indices {
            &config.depth_input_attachment_index
        } else {
            std::ptr::null()
        },
        stencil_input_attachment_index: if pass_ds_input_indices {
            &config.stencil_input_attachment_index
        } else {
            std::ptr::null()
        },
    };

    let mut input_secondaries = Vec::new();
    let mut output_secondaries = Vec::new();
    if secondary {
        for index in 0..config.input_draws_count as usize {
            let buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?;
            let location_info = vk::RenderingAttachmentLocationInfo {
                s_type: vk::StructureType::RENDERING_ATTACHMENT_LOCATION_INFO,
                next: std::ptr::null(),
                color_attachment_count: config.color_attachment_count,
                color_attachment_locations: config.color_attachment_locations[index].as_ptr(),
            };
            begin_secondary_rendering_buffer(
                device,
                *buffer,
                if config.use_mapping {
                    (&raw const location_info).cast()
                } else {
                    std::ptr::null()
                },
                &color_image_formats,
                rendering_depth_format,
                rendering_stencil_format,
                actual_sample_count,
            )?;
            record_input(*buffer, index);
            end_command_buffer(device, *buffer)?;
            input_secondaries.push(buffer);
        }

        for index in 0..config.output_draws_count as usize {
            let buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?;
            let input_index_info = input_index_info_for(index);
            begin_secondary_rendering_buffer(
                device,
                *buffer,
                if config.use_mapping {
                    (&raw const input_index_info).cast()
                } else {
                    std::ptr::null()
                },
                &color_image_formats,
                rendering_depth_format,
                rendering_stencil_format,
                actual_sample_count,
            )?;
            record_output(*buffer, index);
            end_command_buffer(device, *buffer)?;
            output_secondaries.push(buffer);
        }
    }

    begin_command_buffer(device, cmd)?;

    // transition all images to proper layouts
    let color_barriers: Vec<vk::ImageMemoryBarrier> = color_images
        .iter()
        .map(|image| {
            make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::RENDERING_LOCAL_READ,
                image.get(),
                color_srr,
            )
        })
        .collect();
    let ds_barrier = make_image_memory_barrier(
        vk::AccessFlags::empty(),
        vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
        vk::ImageLayout::UNDEFINED,
        vk::ImageLayout::RENDERING_LOCAL_READ,
        ds_image.get(),
        ds_srr,
    );
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::empty(),
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &color_barriers,
        );
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::empty(),
            vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[ds_barrier],
        );
        device.cmd_begin_rendering(cmd, &rendering_info);
    }

    // draw using the write pipelines
    for pipeline_index in 0..config.input_draws_count as usize {
        if config.use_mapping {
            let location_info = vk::RenderingAttachmentLocationInfo {
                s_type: vk::StructureType::RENDERING_ATTACHMENT_LOCATION_INFO,
                next: std::ptr::null(),
                color_attachment_count: config.color_attachment_count,
                color_attachment_locations: config.color_attachment_locations[pipeline_index].as_ptr(),
            };
            unsafe { device.cmd_set_rendering_attachment_locations_khr(cmd, &location_info) };
        }

        if secondary {
            unsafe { device.cmd_execute_commands(cmd, &[*input_secondaries[pipeline_index]]) };
        } else {
            record_input(cmd, pipeline_index);
        }
    }

    // finish rendering before the reads
    let memory_barrier = make_memory_barrier(
        vk::AccessFlags::COLOR_ATTACHMENT_WRITE | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
        vk::AccessFlags::INPUT_ATTACHMENT_READ,
    );
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
            vk::PipelineStageFlags::FRAGMENT_SHADER,
            vk::DependencyFlags::BY_REGION,
            &[memory_barrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        )
    };

    if config.use_mapping {
        let location_info = vk::RenderingAttachmentLocationInfo {
            s_type: vk::StructureType::RENDERING_ATTACHMENT_LOCATION_INFO,
            next: std::ptr::null(),
            color_attachment_count: config.color_attachment_count,
            color_attachment_locations: std::ptr::null(),
        };
        unsafe { device.cmd_set_rendering_attachment_locations_khr(cmd, &location_info) };
    }

    // draw using the read pipelines
    for pipeline_index in 0..config.output_draws_count as usize {
        if config.use_mapping {
            let input_index_info = input_index_info_for(pipeline_index);
            unsafe { device.cmd_set_rendering_input_attachment_indices_khr(cmd, &input_index_info) };
        }

        if secondary {
            unsafe { device.cmd_execute_commands(cmd, &[*output_secondaries[pipeline_index]]) };
        } else {
            record_output(cmd, pipeline_index);
        }
    }

    unsafe { device.cmd_end_rendering(cmd) };

    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, queue, cmd)?;

    // verify all output buffers
    let mut all_ok = true;
    for (buffer, &expected) in output_buffers.iter().zip(&config.expected_values) {
        let allocation = buffer.get_allocation();
        invalidate_alloc(device, allocation)?;

        let values = unsafe {
            std::slice::from_raw_parts(
                allocation.get_host_ptr().cast_const().cast::<u32>(),
                (RENDER_SIZE * RENDER_SIZE) as usize,
            )
        };
        if let Some((index, value)) = values.iter().enumerate().find(|&(_, &value)| value != expected) {
            log::info!("Result for buffer: expected {expected} got {value} at index {index}");
            all_ok = false;
        }
    }

    if all_ok {
        Ok(TestStatus::pass("Pass"))
    } else {
        Ok(TestStatus::fail("Fail"))
    }
}

/// How a `testConfigs` entry is run
enum Kind {
    Basic(BasicType),
    Extra(ExtraType),
    NotPorted,
}

/// `testConfigs` of `createDynamicRenderingLocalReadTests`, in upstream's order
const TEST_CONFIGS: [(&str, Kind); 22] = [
    ("max_input_attachments", Kind::Basic(BasicType::MaxInputAttachments)),
    (
        "max_attachments_remapped_repeatedly",
        Kind::Basic(BasicType::MaxAttachmentsRemappedRepeatedly),
    ),
    (
        "input_attachments_without_mapping",
        Kind::Basic(BasicType::InputAttachmentsWithoutMapping),
    ),
    ("unused_writen_discarded", Kind::Basic(BasicType::UnusedWritenDiscarded)),
    (
        "depth_stencil_mapping_to_no_index",
        Kind::Basic(BasicType::DepthStencilMappingToNoIndex),
    ),
    (
        "depth_stencil_mapping_to_no_index_depth_clear",
        Kind::Basic(BasicType::DepthStencilMappingToNoIndexDepthClear),
    ),
    (
        "depth_stencil_mapping_to_no_index_stencil_clear",
        Kind::Basic(BasicType::DepthStencilMappingToNoIndexStencilClear),
    ),
    (
        "depth_stencil_mapping_to_same_index",
        Kind::Basic(BasicType::DepthStencilMappingToSameIndex),
    ),
    (
        "depth_stencil_mapping_to_large_index",
        Kind::Basic(BasicType::DepthStencilMappingToLargeIndex),
    ),
    (
        "depth_mapping_stencil_not",
        Kind::Basic(BasicType::DepthMappingStencilNot),
    ),
    ("mapping_not_affecting_blend_state", Kind::Extra(ExtraType::BlendState)),
    (
        "interaction_with_color_write_enable",
        Kind::Basic(BasicType::InteractionWithColorWriteEnable),
    ),
    ("interaction_with_graphics_pipeline_library", Kind::NotPorted),
    (
        "interaction_with_extended_dynamic_state3",
        Kind::Basic(BasicType::InteractionWithExtendedDynamicState3),
    ),
    ("interaction_with_shader_object", Kind::NotPorted),
    ("remap_single_attachment_monolithic", Kind::NotPorted),
    ("remap_single_attachment_fast_lib", Kind::NotPorted),
    ("remap_single_attachment_shader_object", Kind::NotPorted),
    ("feedback_loop", Kind::Extra(ExtraType::FeedbackLoop)),
    ("feedback_loop_with_shader_object", Kind::NotPorted),
    ("feedback_loop_msaa", Kind::Extra(ExtraType::FeedbackLoopMsaa)),
    ("frag_shader_only_color", Kind::Extra(ExtraType::FragShaderOnlyColor)),
];

/// The `local_read` cases with a gap between attachments (`RemappingWithGapTestCase`), not ported
const GAP_CONFIGS: [&str; 3] = [
    "max_remapped_attachments_with_gap_read_only",
    "max_remapped_attachments_with_gap_write_only",
    "max_remapped_attachments_with_gap_write_read",
];

/// A `local_read` case whose body is not ported
struct NotPortedLocalReadCase {
    name: &'static str,
}

impl TestCase for NotPortedLocalReadCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_dynamic_rendering_local_read")?;
        Err(TestError::NotPorted("this local_read test".to_string()))
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, _context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(NotPortedLocalReadInstance)
    }

    fn is_stub(&self) -> bool {
        true
    }
}

struct NotPortedLocalReadInstance;

impl TestInstance for NotPortedLocalReadInstance {
    fn iterate(&mut self) -> TestOutcome {
        Err(TestError::NotPorted("this local_read test".to_string()))
    }
}

/// The first part of `createDynamicRenderingLocalReadTests`: the `LocalReadTestCase` entries of `testConfigs`, for primary command buffers or
/// (`secondary`) with every draw recorded in a secondary command buffer
pub fn add_local_read_test_configs(group: &mut TestCaseGroup, secondary: bool) {
    for (name, kind) in TEST_CONFIGS {
        match kind {
            Kind::Basic(test_type) => {
                group.add_child(Box::new(BasicLocalReadTestCase {
                    name,
                    test_type,
                    secondary,
                }) as Box<dyn TestCase>);
            }
            Kind::Extra(test_type) => {
                group.add_child(Box::new(ExtraLocalReadTestCase {
                    name,
                    test_type,
                    secondary,
                }) as Box<dyn TestCase>);
            }
            Kind::NotPorted => {
                group.add_child(Box::new(NotPortedLocalReadCase { name }) as Box<dyn TestCase>);
            }
        }
    }
}

/// The last part: the `RemappingWithGapTestCase` entries
pub fn add_local_read_gap_cases(group: &mut TestCaseGroup) {
    for name in GAP_CONFIGS {
        group.add_child(Box::new(NotPortedLocalReadCase { name }) as Box<dyn TestCase>);
    }
}
