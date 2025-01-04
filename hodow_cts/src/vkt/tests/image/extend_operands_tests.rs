// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/image/vktImageLoadStoreTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2016 Samsung Electronics Co., Ltd.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Of that file only `ImageExtendOperandTest` is here, which makes the `extend_operands_spirv1p4` and
// `nontemporal_operand` groups. Upstream runs it through `BaseTestInstance`, i.e. once on every queue of the device; it runs once on the
// universal queue here. The SPIR-V assembly of `initPrograms` is specialized by scripts/gen_image_extend_operands_manifest.py into
// shaders/manifest/image_extend_operands.toml, one program per case, found by `extend_key`. A group of an integral format without a SPIR-V format is
// not created, where upstream creates it empty.
//
// A storage image of the read format is filled from a buffer, an assembly shader copies it texel by texel to a storage image of the write format
// with a SignExtend, ZeroExtend or Nontemporal image operand, and the result is read back and compared with the input.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::image_extend_operands::ALL_SHARED_PROGRAM;
use crate::tcu::pixel::{TextureLevel, get_texture_format_bit_depth};
use crate::tcu::texture::{ChannelType, TextureChannelClass, TextureFormat, map_vk_format};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_layers, make_image_subresource_range,
    make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_set, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const WIDTH: u32 = 8;
const HEIGHT: u32 = 8;

/// The integral formats of `s_formats` that have a SPIR-V format, then the two 64 bit ones: (format, short name).
const EXTENSION_OPERAND_FORMATS: [(vk::Format, &str); 21] = [
    (vk::Format::R32G32B32A32_UINT, "r32g32b32a32_uint"),
    (vk::Format::R16G16B16A16_UINT, "r16g16b16a16_uint"),
    (vk::Format::R8G8B8A8_UINT, "r8g8b8a8_uint"),
    (vk::Format::R32_UINT, "r32_uint"),
    (vk::Format::R32G32B32A32_SINT, "r32g32b32a32_sint"),
    (vk::Format::R16G16B16A16_SINT, "r16g16b16a16_sint"),
    (vk::Format::R8G8B8A8_SINT, "r8g8b8a8_sint"),
    (vk::Format::R32_SINT, "r32_sint"),
    (vk::Format::A2B10G10R10_UINT_PACK32, "a2b10g10r10_uint_pack32"),
    (vk::Format::R32G32_UINT, "r32g32_uint"),
    (vk::Format::R16G16_UINT, "r16g16_uint"),
    (vk::Format::R16_UINT, "r16_uint"),
    (vk::Format::R8G8_UINT, "r8g8_uint"),
    (vk::Format::R8_UINT, "r8_uint"),
    (vk::Format::R32G32_SINT, "r32g32_sint"),
    (vk::Format::R16G16_SINT, "r16g16_sint"),
    (vk::Format::R16_SINT, "r16_sint"),
    (vk::Format::R8G8_SINT, "r8g8_sint"),
    (vk::Format::R8_SINT, "r8_sint"),
    (vk::Format::R64_SINT, "r64_sint"),
    (vk::Format::R64_UINT, "r64_uint"),
];

fn short_name(format: vk::Format) -> &'static str {
    EXTENSION_OPERAND_FORMATS
        .iter()
        .find(|(f, _)| *f == format)
        .map(|(_, name)| *name)
        .expect("format of the extension operand list")
}

fn tex_format(format: vk::Format) -> TextureFormat {
    map_vk_format(format).expect("format of the extension operand list has a tcu format")
}

fn is_signed_format(format: vk::Format) -> bool {
    tex_format(format).channel_class() == TextureChannelClass::SignedInteger
}

/// `is64BitIntegerFormat`
fn is_64_bit_integer_format(format: vk::Format) -> bool {
    matches!(
        tex_format(format).type_,
        ChannelType::UNSIGNED_INT64 | ChannelType::SIGNED_INT64
    )
}

/// `getShaderExtensionOperandFormat`
fn get_shader_extension_operand_format(is_signed: bool, is_64_bit: bool) -> vk::Format {
    let formats = [
        vk::Format::R32G32B32A32_UINT,
        vk::Format::R32G32B32A32_SINT,
        vk::Format::R64_UINT,
        vk::Format::R64_SINT,
    ];
    formats[2 * usize::from(is_64_bit) + usize::from(is_signed)]
}

/// `relaxedOK`
fn relaxed_ok(format: vk::Format) -> bool {
    let bit_depth = get_texture_format_bit_depth(tex_format(format));
    bit_depth.into_iter().max().unwrap_or(0) <= 16
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum ExtendTestType {
    Read,
    Write,
    WriteNontemporal,
}

impl ExtendTestType {
    fn key_name(self) -> &'static str {
        match self {
            Self::Read => "read",
            Self::Write => "write",
            Self::WriteNontemporal => "nontemporal",
        }
    }

    #[allow(dead_code)]
    fn is_write_test(self) -> bool {
        matches!(self, Self::Write | Self::WriteNontemporal)
    }
}

/// The key of the manifest entry of a case.
fn extend_key(
    test_type: ExtendTestType,
    read_format: vk::Format,
    write_format: vk::Format,
    operand_force: bool,
    relaxed_precision: bool,
) -> String {
    format!(
        "ext_{}_{}_{}_{}_{}",
        test_type.key_name(),
        short_name(read_format),
        short_name(write_format),
        u32::from(operand_force),
        u32::from(relaxed_precision)
    )
}

struct ImageExtendOperandCase {
    name: String,
    read_format: vk::Format,
    write_format: vk::Format,
    operand_force: bool,
    relaxed_precision: bool,
    test_type: ExtendTestType,
}

/// `checkFormatProperties`
fn check_format_properties(
    context: &Context<'_>,
    format: vk::Format,
    required_fmt_feat_xfer: vk::FormatFeatureFlags,
) -> Result<(), TestError> {
    let features = unsafe {
        context
            .get_instance()
            .get_physical_device_format_properties(context.get_physical_device(), format)
    }
    .optimal_tiling_features;

    if !features.contains(vk::FormatFeatureFlags::STORAGE_IMAGE) {
        return Err(TestError::NotSupported(
            "Format not supported for storage images".to_string(),
        ));
    }

    if !features.contains(required_fmt_feat_xfer) {
        return Err(TestError::NotSupported("Format not supported for transfer".to_string()));
    }

    Ok(())
}

impl TestCase for ImageExtendOperandCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `ImageExtendOperandTest::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_spirv_1_4")?;

        if self.test_type == ExtendTestType::WriteNontemporal && context.api_version() < (1, 3, 0) {
            return Err(TestError::NotSupported(
                "Vulkan 1.3 or higher is required for this test to run".to_string(),
            ));
        }

        // check64BitSupportIfNeeded
        if (is_64_bit_integer_format(self.read_format) || is_64_bit_integer_format(self.write_format))
            && context.get_device_features().shader_int64 == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "64-bit integers not supported in shaders".to_string(),
            ));
        }

        check_format_properties(context, self.read_format, vk::FormatFeatureFlags::TRANSFER_DST)?;
        check_format_properties(context, self.write_format, vk::FormatFeatureFlags::TRANSFER_SRC)?;
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ImageExtendOperandInstance {
            context,
            read_format: self.read_format,
            write_format: self.write_format,
            relaxed_precision: self.relaxed_precision,
            key: extend_key(
                self.test_type,
                self.read_format,
                self.write_format,
                self.operand_force,
                self.relaxed_precision,
            ),
        })
    }
}

struct ImageExtendOperandInstance<'a> {
    context: &'a Context<'a>,
    read_format: vk::Format,
    write_format: vk::Format,
    relaxed_precision: bool,
    key: String,
}

impl TestInstance for ImageExtendOperandInstance<'_> {
    /// `ImageExtendOperandTestInstance` and the part of `BaseTestInstance::iterate` that runs it, on one queue
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let read_tcu_format = tex_format(self.read_format);
        let write_tcu_format = tex_format(self.write_format);

        // Generate reference image
        let is_signed = is_signed_format(self.read_format);
        let mut input_image_data = TextureLevel::new(read_tcu_format, WIDTH, HEIGHT, 1)?;
        let value_start = if is_signed { -(WIDTH as i32) / 2 } else { 0 };
        {
            let mut access = input_image_data.get_access();
            for x in 0..WIDTH {
                for y in 0..HEIGHT {
                    let _ = access.set_pixel_int(
                        [value_start + x as i32, value_start + y as i32, value_start, value_start],
                        x,
                        y,
                        0,
                    );
                }
            }
        }

        let subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let image_info = |format: vk::Format, usage: vk::ImageUsageFlags| {
            vk::ImageCreateInfo::builder()
                .image_type(vk::ImageType::_2D)
                .format(format)
                .extent(vk::Extent3D {
                    width: WIDTH,
                    height: HEIGHT,
                    depth: 1,
                })
                .mip_levels(1)
                .array_layers(1)
                .samples(vk::SampleCountFlags::_1)
                .tiling(vk::ImageTiling::OPTIMAL)
                .usage(usage)
                .sharing_mode(vk::SharingMode::EXCLUSIVE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .build()
        };

        // Create source and destination images
        let image_src = ImageWithMemory::new(
            device,
            allocator,
            image_info(
                self.read_format,
                vk::ImageUsageFlags::STORAGE | vk::ImageUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::ANY,
        )?;
        let image_dst = ImageWithMemory::new(
            device,
            allocator,
            image_info(
                self.write_format,
                vk::ImageUsageFlags::STORAGE | vk::ImageUsageFlags::TRANSFER_SRC,
            ),
            MemoryRequirement::ANY,
        )?;

        // Compute image and buffer sizes
        let read_pixel_size = read_tcu_format
            .pixel_size()
            .ok_or_else(|| TestError::NotPorted("pixel size of the read format".to_string()))?;
        let write_pixel_size = write_tcu_format
            .pixel_size()
            .ok_or_else(|| TestError::NotPorted("pixel size of the write format".to_string()))?;
        let image_src_size = vk::DeviceSize::from(WIDTH * HEIGHT * read_pixel_size);
        let image_dst_size = vk::DeviceSize::from(WIDTH * HEIGHT * write_pixel_size);
        let buffer_size_bytes = image_src_size.max(image_dst_size);

        // Create helper buffer able to store input data and image write result
        let buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                buffer_size_bytes,
                vk::BufferUsageFlags::STORAGE_TEXEL_BUFFER
                    | vk::BufferUsageFlags::TRANSFER_SRC
                    | vk::BufferUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                input_image_data.data().as_ptr(),
                buffer.get_allocation().get_host_ptr(),
                image_src_size as usize,
            )
        };
        flush_alloc(device, buffer.get_allocation())?;

        // Descriptors
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::COMPUTE)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_IMAGE, 1)
            .add_type(vk::DescriptorType::STORAGE_IMAGE, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
        let image_src_view = make_image_view(
            device,
            image_src.get(),
            vk::ImageViewType::_2D,
            self.read_format,
            subresource_range,
        )?;
        let image_dst_view = make_image_view(
            device,
            image_dst.get(),
            vk::ImageViewType::_2D,
            self.write_format,
            subresource_range,
        )?;

        // Pipeline
        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
        let program = ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == self.key)
            .ok_or_else(|| TestError::InternalError(format!("no shader {}", self.key)))?;
        let shader_module = create_shader_module(device, program.programs.get("comp")?)?;
        let stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(*shader_module)
            .name(b"main\0");
        let compute_info = vk::ComputePipelineCreateInfo::builder()
            .stage(*stage)
            .layout(*pipeline_layout)
            .base_pipeline_index(0);
        let pipelines = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[compute_info], None) }
            .vk_check("vkCreateComputePipelines")?;
        let pipeline = Unique::new(device, pipelines.0[0]);

        let command_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *command_buffer;
        begin_command_buffer(device, cmd)?;

        // commandBeforeCompute
        {
            let pre_copy_image_barriers = [
                make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    image_src.get(),
                    subresource_range,
                ),
                make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::SHADER_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::GENERAL,
                    image_dst.get(),
                    subresource_range,
                ),
            ];
            let barrier_flush_host_write_before_copy = make_buffer_memory_barrier(
                vk::AccessFlags::HOST_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                buffer.get(),
                0,
                image_src_size,
            );

            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::HOST,
                    vk::PipelineStageFlags::COMPUTE_SHADER | vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[barrier_flush_host_write_before_copy],
                    &pre_copy_image_barriers,
                );
            }
        }
        {
            let barrier_after_copy = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::SHADER_READ,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::GENERAL,
                image_src.get(),
                subresource_range,
            );
            let copy_region = vk::BufferImageCopy {
                buffer_offset: 0,
                buffer_row_length: 0,
                buffer_image_height: 0,
                image_subresource: make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
                image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                image_extent: vk::Extent3D {
                    width: WIDTH,
                    height: HEIGHT,
                    depth: 1,
                },
            };

            unsafe {
                device.cmd_copy_buffer_to_image(
                    cmd,
                    buffer.get(),
                    image_src.get(),
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &[copy_region],
                );
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[barrier_after_copy],
                );
            }
        }

        // Compute
        let descriptor_src_image_info = [vk::DescriptorImageInfo {
            sampler: vk::Sampler::null(),
            image_view: *image_src_view,
            image_layout: vk::ImageLayout::GENERAL,
        }];
        let descriptor_dst_image_info = [vk::DescriptorImageInfo {
            sampler: vk::Sampler::null(),
            image_view: *image_dst_view,
            image_layout: vk::ImageLayout::GENERAL,
        }];
        let writes = [
            vk::WriteDescriptorSet::builder()
                .dst_set(descriptor_set.get())
                .dst_binding(0)
                .dst_array_element(0)
                .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
                .image_info(&descriptor_src_image_info)
                .build(),
            vk::WriteDescriptorSet::builder()
                .dst_set(descriptor_set.get())
                .dst_binding(1)
                .dst_array_element(0)
                .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
                .image_info(&descriptor_dst_image_info)
                .build(),
        ];
        unsafe {
            device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]);
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *pipeline);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::COMPUTE,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );
            device.cmd_dispatch(cmd, WIDTH, HEIGHT, 1);
        }

        // commandAfterCompute: commandCopyImageToBuffer
        {
            let prepare_for_transfer_barrier = make_image_memory_barrier(
                vk::AccessFlags::SHADER_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::GENERAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                image_dst.get(),
                subresource_range,
            );
            let copy_region = vk::BufferImageCopy {
                buffer_offset: 0,
                buffer_row_length: 0,
                buffer_image_height: 0,
                image_subresource: make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
                image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                image_extent: vk::Extent3D {
                    width: WIDTH,
                    height: HEIGHT,
                    depth: 1,
                },
            };
            let copy_barrier = make_buffer_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::HOST_READ,
                buffer.get(),
                0,
                image_dst_size,
            );

            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[prepare_for_transfer_barrier],
                );
                device.cmd_copy_image_to_buffer(
                    cmd,
                    image_dst.get(),
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    buffer.get(),
                    &[copy_region],
                );
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[copy_barrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        // verifyResult
        invalidate_alloc(device, buffer.get_allocation())?;
        let result_data = unsafe {
            std::slice::from_raw_parts(
                buffer.get_allocation().get_host_ptr().cast_const(),
                image_dst_size as usize,
            )
        };
        let result = crate::tcu::pixel::ConstPixelBufferAccess::new(write_tcu_format, [WIDTH, HEIGHT, 1], result_data);
        let input = input_image_data.get_const_access();
        let is_64_bit = is_64_bit_integer_format(self.write_format);

        for y in 0..HEIGHT {
            for x in 0..WIDTH {
                // the reference is the input converted to the write format, so only its int value matters
                let reference = input.get_pixel_int(x, y, 0);
                let matches = if is_64_bit {
                    let output = result.get_pixel_int64(x, y, 0);
                    (0..4).all(|c| {
                        if self.relaxed_precision {
                            (output[c] & 0xFFFF) == (i64::from(reference[c]) & 0xFFFF)
                        } else {
                            output[c] == i64::from(reference[c])
                        }
                    })
                } else {
                    let output = result.get_pixel_int(x, y, 0);
                    (0..4).all(|c| {
                        if self.relaxed_precision {
                            (output[c] as u32 & 0xFFFF) == (reference[c] as u32 & 0xFFFF)
                        } else {
                            output[c] == reference[c]
                        }
                    })
                };

                if !matches {
                    log::info!("Comparison failed at ({x}, {y})");
                    return Ok(TestStatus::fail("Image comparison failed"));
                }
            }
        }

        Ok(TestStatus::pass("Passed"))
    }
}

/// `createImageExtendOperandsTests`
pub fn create_image_extend_operands_tests() -> TestCaseGroup {
    let mut test_group = TestCaseGroup::new("extend_operands_spirv1p4");

    let test_types = [(ExtendTestType::Read, "read"), (ExtendTestType::Write, "write")];

    for &(format, format_name) in &EXTENSION_OPERAND_FORMATS {
        let is_int = is_signed_format(format);
        let is_uint = !is_int;
        let use_64_bits = is_64_bit_integer_format(format);

        let mut format_group = TestCaseGroup::new(format_name);

        for (test_type, test_type_name) in test_types {
            let mut test_type_group = TestCaseGroup::new(test_type_name);

            for mismatched in [false, true] {
                // SPIR-V does not allow this kind of sampled type override.
                if mismatched && is_uint {
                    continue;
                }

                let mut match_group = TestCaseGroup::new(if mismatched { "mismatched_sign" } else { "matched_sign" });

                for relaxed_precision in [false, true] {
                    let precision_name = if relaxed_precision {
                        "relaxed_precision"
                    } else {
                        "normal_precision"
                    };
                    let signed_other = (is_int && !mismatched) || (is_uint && mismatched);
                    let other_format = get_shader_extension_operand_format(signed_other, use_64_bits);
                    let read_format = if test_type == ExtendTestType::Read {
                        format
                    } else {
                        other_format
                    };
                    let write_format = if test_type == ExtendTestType::Write {
                        format
                    } else {
                        other_format
                    };

                    if relaxed_precision && !relaxed_ok(read_format) {
                        continue;
                    }

                    match_group.add_child(Box::new(ImageExtendOperandCase {
                        name: precision_name.to_string(),
                        read_format,
                        write_format,
                        operand_force: mismatched,
                        relaxed_precision,
                        test_type,
                    }) as Box<dyn TestCase>);
                }

                test_type_group.add_child(match_group);
            }

            format_group.add_child(test_type_group);
        }

        test_group.add_child(format_group);
    }

    test_group
}

/// `createImageNontemporalOperandTests`
pub fn create_image_nontemporal_operand_tests() -> TestCaseGroup {
    let mut test_group = TestCaseGroup::new("nontemporal_operand");

    // using just integer formats for tests so that ImageExtendOperandTest could be reused
    for &(format, format_name) in &EXTENSION_OPERAND_FORMATS {
        let read_format = format;
        let write_format =
            get_shader_extension_operand_format(is_signed_format(format), is_64_bit_integer_format(format));

        // note: just testing OpImageWrite as OpImageRead is tested with addComputeImageSamplerTest
        test_group.add_child(Box::new(ImageExtendOperandCase {
            name: format_name.to_string(),
            read_format,
            write_format,
            operand_force: false,
            relaxed_precision: false,
            test_type: ExtendTestType::WriteNontemporal,
        }) as Box<dyn TestCase>);
    }

    test_group
}
