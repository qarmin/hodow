// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/shaderrender/vktShaderRenderBuiltinVarTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `fragcoord_msaa` and `fragcoord_msaa_input` groups of `builtin_var`: a quad is drawn into a multisampled target and the
// fragment shader stores gl_FragCoord into an rgba32f storage image, per sample (sample shading) or per pixel. The shaders are in
// `shaders/manifest/shader_render_builtin_var.toml` (`fragcoord_msaa_s<N>`, `fragcoord_msaa_noshading`, `fragcoord_msaa_centroid`, the last one SPIR-V assembly as upstream).
// The result image is not logged.

use vulkanalia::prelude::v1_0::*;

use super::shader_render_builtin_var_fragdepth_tests::copy_image_to_buffer;
use crate::generated::shaders::shader_render_builtin_var::ALL_SHARED_PROGRAM;
use crate::tcu::vector::{IVec2, Vec4};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_image_create_info, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
};
use crate::vk::programs::BinaryCollection;
use crate::vkt::tests::util::draw_util::{
    DrawCallData, FrameBufferState, PipelineState, VulkanDrawContext, VulkanProgram, VulkanShader,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const RENDERWIDTH: u32 = 16;
const RENDERHEIGHT: u32 = 16;

const SAMPLE_COUNT_1_BIT: [[f32; 2]; 1] = [[0.5, 0.5]];
const SAMPLE_COUNT_2_BIT: [[f32; 2]; 2] = [[0.25, 0.25], [0.75, 0.75]];
const SAMPLE_COUNT_4_BIT: [[f32; 2]; 4] = [[0.375, 0.125], [0.875, 0.375], [0.125, 0.625], [0.625, 0.875]];
const SAMPLE_COUNT_8_BIT: [[f32; 2]; 8] = [
    [0.5625, 0.3125],
    [0.4375, 0.6875],
    [0.8125, 0.5625],
    [0.3125, 0.1875],
    [0.1875, 0.8125],
    [0.0625, 0.4375],
    [0.6875, 0.9375],
    [0.9375, 0.0625],
];
const SAMPLE_COUNT_16_BIT: [[f32; 2]; 16] = [
    [0.5625, 0.5625],
    [0.4375, 0.3125],
    [0.3125, 0.6250],
    [0.7500, 0.4375],
    [0.1875, 0.3750],
    [0.6250, 0.8125],
    [0.8125, 0.6875],
    [0.6875, 0.1875],
    [0.3750, 0.8750],
    [0.5000, 0.0625],
    [0.2500, 0.1250],
    [0.1250, 0.7500],
    [0.0000, 0.5000],
    [0.9375, 0.2500],
    [0.8750, 0.9375],
    [0.0625, 0.0000],
];

fn standard_sample_locations(log_sample_count: u32) -> Option<&'static [[f32; 2]]> {
    match log_sample_count {
        0 => Some(&SAMPLE_COUNT_1_BIT),
        1 => Some(&SAMPLE_COUNT_2_BIT),
        2 => Some(&SAMPLE_COUNT_4_BIT),
        3 => Some(&SAMPLE_COUNT_8_BIT),
        4 => Some(&SAMPLE_COUNT_16_BIT),
        _ => None,
    }
}

/// `BuiltinFragCoordMsaaTestCase`
struct FragCoordMsaaCase {
    name: String,
    samples: u32,
    sample_shading: bool,
    sample_mask_array: Vec<u32>,
    use_centroid: bool,
    use_enable: bool,
}

impl FragCoordMsaaCase {
    fn sample_flags(&self) -> vk::SampleCountFlags {
        vk::SampleCountFlags::from_bits_truncate(self.samples)
    }

    fn program_key(&self) -> String {
        if self.sample_shading {
            format!("sr_builtin_var_fragcoord_msaa_s{}", self.samples)
        } else if self.use_centroid {
            "sr_builtin_var_fragcoord_msaa_centroid".to_string()
        } else {
            "sr_builtin_var_fragcoord_msaa_noshading".to_string()
        }
    }
}

impl TestCase for FragCoordMsaaCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// The checks of `BuiltinFragCoordMsaaCaseInstance`'s constructor
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let features = context.get_device_features();
        if features.sample_rate_shading == vk::FALSE {
            return Err(TestError::NotSupported("sampleRateShading not supported".to_string()));
        }
        if features.fragment_stores_and_atomics == vk::FALSE {
            return Err(TestError::NotSupported(
                "fragmentStoresAndAtomics not supported".to_string(),
            ));
        }

        let image_format_properties = unsafe {
            context.get_instance().get_physical_device_image_format_properties(
                context.get_physical_device(),
                vk::Format::R32G32B32A32_SFLOAT,
                vk::ImageType::_2D,
                vk::ImageTiling::OPTIMAL,
                vk::ImageUsageFlags::COLOR_ATTACHMENT,
                vk::ImageCreateFlags::empty(),
            )
        };
        let image_format_properties = match image_format_properties {
            Ok(properties) => properties,
            Err(error) if error == vk::ErrorCode::FORMAT_NOT_SUPPORTED => {
                return Err(TestError::NotSupported("Image format not supported".to_string()));
            }
            Err(error) => {
                return Err(TestError::Fail(format!(
                    "vkGetPhysicalDeviceImageFormatProperties: {error:?}"
                )));
            }
        };
        if !image_format_properties.sample_counts.contains(self.sample_flags()) {
            return Err(TestError::NotSupported(
                "Image format and sample count not supported".to_string(),
            ));
        }

        let format_properties = unsafe {
            context
                .get_instance()
                .get_physical_device_format_properties(context.get_physical_device(), vk::Format::R32G32B32A32_SFLOAT)
        };
        if !format_properties
            .optimal_tiling_features
            .contains(vk::FormatFeatureFlags::STORAGE_IMAGE)
        {
            return Err(TestError::NotSupported(
                "Output format not supported as storage image".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let key = self.program_key();
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == key)
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(FragCoordMsaaInstance {
            context,
            samples: self.samples,
            sample_flags: self.sample_flags(),
            sample_shading: self.sample_shading,
            sample_mask_array: self.sample_mask_array.clone(),
            use_enable: self.use_enable,
        })
    }
}

/// `BuiltinFragCoordMsaaCaseInstance`
struct FragCoordMsaaInstance<'a> {
    context: &'a Context<'a>,
    samples: u32,
    sample_flags: vk::SampleCountFlags,
    sample_shading: bool,
    sample_mask_array: Vec<u32>,
    use_enable: bool,
}

impl FragCoordMsaaInstance<'_> {
    /// `BuiltinFragCoordMsaaCaseInstance::validateSampleLocations` over rgba32f texels, `samples * RENDERWIDTH` wide
    fn validate_sample_locations(&self, buffer: &[u8]) -> bool {
        let row_texels = (self.samples * RENDERWIDTH) as usize;
        let pixel = |x: usize, y: usize| -> [f32; 4] {
            let offset = (y * row_texels + x) * 16;
            std::array::from_fn(|channel| {
                f32::from_le_bytes(
                    buffer[offset + channel * 4..offset + channel * 4 + 4]
                        .try_into()
                        .expect("four bytes"),
                )
            })
        };
        let log_sample_count = self.samples.trailing_zeros();
        let standard_sample_locations_supported = unsafe {
            self.context
                .get_instance()
                .get_physical_device_properties(self.context.get_physical_device())
        }
        .limits
        .standard_sample_locations
            != vk::FALSE;

        for row_ndx in 0..RENDERHEIGHT as usize {
            for col_ndx in 0..RENDERWIDTH as usize {
                if self.sample_shading {
                    let mut locations: Vec<[f32; 2]> = Vec::new();
                    for sample_ndx in 0..self.samples as usize {
                        let pixel_data = pixel(sample_ndx + self.samples as usize * col_ndx, row_ndx);
                        if pixel_data[2] != 0.0 || pixel_data[3] != 1.0 {
                            return false;
                        }
                        locations.push([pixel_data[0], pixel_data[1]]);
                    }

                    locations.sort_by(|a, b| a[0].partial_cmp(&b[0]).unwrap_or(std::cmp::Ordering::Equal));

                    for location in &locations {
                        let (floor_x, floor_y) = (location[0].floor() as i32, location[1].floor() as i32);
                        let (ceil_x, ceil_y) = (location[0].ceil() as i32, location[1].ceil() as i32);
                        if floor_x < col_ndx as i32
                            || ceil_x > col_ndx as i32 + 1
                            || floor_y < row_ndx as i32
                            || ceil_y > row_ndx as i32 + 1
                        {
                            return false;
                        }
                    }

                    // std::unique only compares neighbours
                    if locations.windows(2).any(|pair| pair[0] == pair[1]) {
                        return false;
                    }

                    if let Some(table) = standard_sample_locations(log_sample_count) {
                        if standard_sample_locations_supported {
                            for standard in table.iter().take(self.samples as usize) {
                                let expected = [standard[0] + col_ndx as f32, standard[1] + row_ndx as f32];
                                if !locations.contains(&expected) {
                                    return false;
                                }
                            }
                        }
                    }
                } else {
                    let pixel_data = pixel(col_ndx, row_ndx);
                    if pixel_data[2] != 0.0 || pixel_data[3] != 1.0 {
                        return false;
                    }
                    if !(pixel_data[0].fract() == 0.5 && pixel_data[1].fract() == 0.5) {
                        return false;
                    }
                }
            }
        }
        true
    }
}

impl TestInstance for FragCoordMsaaInstance<'_> {
    /// `BuiltinFragCoordMsaaCaseInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let allocator = context.get_default_allocator();
        let queue_family_index = context.get_universal_queue_family_index();
        let wide_size = IVec2::new((self.samples * RENDERWIDTH) as i32, RENDERHEIGHT as i32);
        let color_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);

        let output_image = ImageWithMemory::new(
            device,
            allocator,
            make_image_create_info(
                wide_size,
                vk::Format::R32G32B32A32_SFLOAT,
                vk::ImageUsageFlags::STORAGE | vk::ImageUsageFlags::TRANSFER_SRC,
            ),
            MemoryRequirement::ANY,
        )?;
        let output_image_view = make_image_view(
            device,
            output_image.get(),
            vk::ImageViewType::_2D,
            vk::Format::R32G32B32A32_SFLOAT,
            color_range,
        )?;

        let byte_count = (self.samples * RENDERWIDTH * RENDERHEIGHT * 16) as usize;
        let sample_location_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(byte_count as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::FRAGMENT)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_IMAGE, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
        let image_info = [vk::DescriptorImageInfo {
            sampler: vk::Sampler::null(),
            image_view: *output_image_view,
            image_layout: vk::ImageLayout::GENERAL,
        }];
        let write = vk::WriteDescriptorSet::builder()
            .dst_set(descriptor_set.get())
            .dst_binding(0)
            .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
            .image_info(&image_info)
            .build();
        unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let transfer_cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = transfer_cmd_buffer.get();

        {
            let barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::SHADER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::GENERAL,
                output_image.get(),
                color_range,
            );
            begin_command_buffer(device, cmd)?;
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::FRAGMENT_SHADER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[barrier],
                );
            }
            end_command_buffer(device, cmd)?;
            submit_commands_and_wait(device, queue, cmd)?;
        }

        {
            let vertices = [
                Vec4::new(-1.0, -1.0, 0.0, 1.0),
                Vec4::new(-1.0, 1.0, 0.0, 1.0),
                Vec4::new(1.0, -1.0, 0.0, 1.0),
                Vec4::new(1.0, 1.0, 0.0, 1.0),
            ];
            let binaries = context.get_binary_collection();
            let shaders = vec![
                VulkanShader {
                    stage: vk::ShaderStageFlags::VERTEX,
                    binary: binaries.get("FragCoordMsaaVert")?,
                },
                VulkanShader {
                    stage: vk::ShaderStageFlags::FRAGMENT,
                    binary: binaries.get("FragCoordMsaaFrag")?,
                },
            ];

            let mut framebuffer_state = FrameBufferState::new(RENDERWIDTH, RENDERHEIGHT);
            let mut pipeline_state =
                PipelineState::new(context.get_device_properties().limits.sub_pixel_precision_bits as i32);
            let draw_call_data = DrawCallData {
                topology: vk::PrimitiveTopology::TRIANGLE_STRIP,
                vertices: &vertices,
            };
            let mut vulkan_program = VulkanProgram::new(shaders);

            framebuffer_state.num_samples = self.sample_flags;
            // When use_enable is false, the gl_SampleID input is what enables sample shading
            pipeline_state.sample_shading_enable = self.use_enable;
            pipeline_state.sample_masks = self.sample_mask_array.clone();
            vulkan_program.descriptor_set_layout = *descriptor_set_layout;
            vulkan_program.descriptor_set = descriptor_set.get();

            let mut draw_context = VulkanDrawContext::new(context, &framebuffer_state)?;
            draw_context.register_draw_object(&pipeline_state, &vulkan_program, &draw_call_data)?;
            draw_context.draw()?;
        }

        begin_command_buffer(device, cmd)?;
        copy_image_to_buffer(
            device,
            cmd,
            output_image.get(),
            sample_location_buffer.get(),
            wide_size,
            vk::AccessFlags::SHADER_WRITE,
            vk::ImageLayout::GENERAL,
        );
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;
        invalidate_alloc(device, sample_location_buffer.get_allocation())?;

        // SAFETY: the buffer is host visible, `byte_count` long and was just invalidated.
        let data =
            unsafe { std::slice::from_raw_parts(sample_location_buffer.get_allocation().get_host_ptr(), byte_count) };
        if self.validate_sample_locations(data) {
            Ok(TestStatus::pass("FragCoordMsaa passed"))
        } else {
            Ok(TestStatus::fail("FragCoordMsaa failed"))
        }
    }
}

/// The `fragcoord_msaa` and `fragcoord_msaa_input` groups of `createBuiltinVarTests`
pub fn create_frag_coord_msaa_tests() -> (TestCaseGroup, TestCaseGroup) {
    const CASES: [(&str, u32); 7] = [
        ("1_bit", 1),
        ("2_bit", 2),
        ("4_bit", 4),
        ("8_bit", 8),
        ("16_bit", 16),
        ("32_bit", 32),
        ("64_bit", 64),
    ];

    let mut frag_coord_msaa_group = TestCaseGroup::new("fragcoord_msaa");
    let mut frag_coord_msaa_input_group = TestCaseGroup::new("fragcoord_msaa_input");
    let case = |name: String,
                samples: u32,
                sample_shading: bool,
                sample_mask_array: Vec<u32>,
                use_centroid: bool,
                use_enable: bool| {
        Box::new(FragCoordMsaaCase {
            name,
            samples,
            sample_shading,
            sample_mask_array,
            use_centroid,
            use_enable,
        }) as Box<dyn TestCase>
    };

    // Standard sample tests
    for (name, samples) in CASES {
        frag_coord_msaa_group.add_child(case(name.to_string(), samples, true, Vec::new(), false, true));
        frag_coord_msaa_input_group.add_child(case(name.to_string(), samples, true, Vec::new(), false, false));
    }

    // No sample shading tests
    for (name, samples) in CASES {
        frag_coord_msaa_input_group.add_child(case(
            format!("{name}_no_sample_shading"),
            samples,
            false,
            vec![1],
            false,
            false,
        ));
    }

    // No sample shading tests with centroid interpolation decoration
    for (name, samples) in CASES {
        frag_coord_msaa_input_group.add_child(case(
            format!("{name}_no_sample_shading_centroid_interpolation"),
            samples,
            false,
            vec![1],
            true,
            false,
        ));
    }
    (frag_coord_msaa_group, frag_coord_msaa_input_group)
}
