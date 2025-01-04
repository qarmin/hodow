// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/tensor/vktTensorCopies.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Copyright (c) 2025 Arm Ltd.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `LinearTensorCopyTestCase<T>` / `OptimalTensorCopyTestCase<T>` carry an `ElementKind` instead of a template
// parameter; the cases are returned keyed by their dotted path so `tensor::create_tests` can swap them in for the gated names of `cases.txt`.

use std::collections::HashMap;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::ArmTensorsExtensionDeviceCommands;

use super::tensor_util::{
    ElementKind, StridedMemory, TensorDescription, TensorParameters, TensorWithMemory, clear_tensor,
    compare_strided_memory, device_supports_non_packed_tensors, download_from_tensor, format_support_tensor_flags,
    get_format_size, params_to_string, require_format_extensions, require_tensor_shape_supported, upload_to_tensor,
};
use crate::tcu::{TestError, TestOutcome};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::MemoryRequirement;
use crate::vk::obj_util::{allocate_command_buffer, make_command_pool, make_memory_barrier};
use crate::vk::programs::BinaryCollection;
use crate::vkt::{Context, TestCase, TestInstance};

struct LinearTensorCopyTestCase {
    name: String,
    src_parameters: TensorParameters,
    dst_parameters: TensorParameters,
    kind: ElementKind,
}

impl TestCase for LinearTensorCopyTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_ARM_tensors")?;
        require_format_extensions(context, &[self.src_parameters.format, self.dst_parameters.format])?;

        require_tensor_shape_supported(context, &self.src_parameters)?;
        require_tensor_shape_supported(context, &self.dst_parameters)?;

        if !format_support_tensor_flags(
            context,
            self.src_parameters.format,
            self.src_parameters.tiling,
            vk::FormatFeatureFlags2::TRANSFER_SRC,
        ) {
            return Err(TestError::NotSupported("Source format not supported".to_string()));
        }

        if !format_support_tensor_flags(
            context,
            self.dst_parameters.format,
            self.dst_parameters.tiling,
            vk::FormatFeatureFlags2::TRANSFER_DST,
        ) {
            return Err(TestError::NotSupported("Destination format not supported".to_string()));
        }

        if (!self.src_parameters.packed() || !self.dst_parameters.packed())
            && !device_supports_non_packed_tensors(context)
        {
            return Err(TestError::NotSupported("Non-packed tensors not supported".to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(LinearTensorCopyTestInstance {
            context,
            src_parameters: &self.src_parameters,
            dst_parameters: &self.dst_parameters,
            kind: self.kind,
        })
    }
}

struct LinearTensorCopyTestInstance<'a> {
    context: &'a Context<'a>,
    src_parameters: &'a TensorParameters,
    dst_parameters: &'a TensorParameters,
    kind: ElementKind,
}

impl LinearTensorCopyTestInstance<'_> {
    fn run(&self) -> TestOutcome {
        assert_eq!(self.src_parameters.dimensions, self.dst_parameters.dimensions);

        let context = self.context;
        let device = context.get_device();

        let src_tensor_desc = TensorDescription::new(
            self.src_parameters.tiling,
            self.src_parameters.format,
            &self.src_parameters.dimensions,
            &self.src_parameters.strides,
            vk::TensorUsageFlagsARM::TRANSFER_SRC,
        );
        let src_tensor = TensorWithMemory::new(context, &src_tensor_desc, MemoryRequirement::ANY)?;

        let dst_tensor_desc = TensorDescription::new(
            self.dst_parameters.tiling,
            self.dst_parameters.format,
            &self.dst_parameters.dimensions,
            &self.dst_parameters.strides,
            vk::TensorUsageFlagsARM::TRANSFER_DST,
        );
        let dst_tensor = TensorWithMemory::new(context, &dst_tensor_desc, MemoryRequirement::ANY)?;

        let mut input_data =
            StridedMemory::new(&self.src_parameters.dimensions, &self.src_parameters.strides, self.kind);
        input_data.fill();

        upload_to_tensor(context, &src_tensor, input_data.data())?;
        clear_tensor(context, &dst_tensor)?;

        {
            let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
            let cmd_buffer = allocate_command_buffer(device, cmd_pool.get(), vk::CommandBufferLevel::PRIMARY)?;

            begin_command_buffer(device, cmd_buffer.get())?;

            let tensor_regions = vk::TensorCopyARM {
                dimension_count: self.src_parameters.dimensions.len() as u32,
                ..Default::default()
            };
            let copy_info = vk::CopyTensorInfoARM {
                src_tensor: src_tensor.get(),
                dst_tensor: dst_tensor.get(),
                regions: &tensor_regions,
                region_count: 1,
                ..Default::default()
            };
            unsafe { device.cmd_copy_tensor_arm(cmd_buffer.get(), &copy_info) };

            end_command_buffer(device, cmd_buffer.get())?;
            submit_commands_and_wait(device, context.get_universal_queue(), cmd_buffer.get())?;
        }

        let mut result = StridedMemory::new(&self.dst_parameters.dimensions, &self.dst_parameters.strides, self.kind);
        let downloaded = download_from_tensor(context, &dst_tensor, result.memory_size())?;
        result.data_mut().copy_from_slice(&downloaded);

        Ok(compare_strided_memory(&result, &input_data))
    }
}

impl TestInstance for LinearTensorCopyTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        self.run()
    }
}

fn check_support_linear_src_storage_tensor(context: &Context<'_>, format: vk::Format) -> bool {
    format_support_tensor_flags(
        context,
        format,
        vk::TensorTilingARM::LINEAR,
        vk::FormatFeatureFlags2::TRANSFER_SRC,
    )
}

fn check_support_linear_dst_storage_tensor(context: &Context<'_>, format: vk::Format) -> bool {
    format_support_tensor_flags(
        context,
        format,
        vk::TensorTilingARM::LINEAR,
        vk::FormatFeatureFlags2::TRANSFER_DST,
    )
}

fn check_support_optimal_storage_tensor(context: &Context<'_>, format: vk::Format) -> bool {
    format_support_tensor_flags(
        context,
        format,
        vk::TensorTilingARM::OPTIMAL,
        vk::FormatFeatureFlags2::TRANSFER_SRC | vk::FormatFeatureFlags2::TRANSFER_DST,
    )
}

struct OptimalTensorCopyTestCase {
    name: String,
    src_parameters: TensorParameters,
    dst_parameters: TensorParameters,
    kind: ElementKind,
}

impl TestCase for OptimalTensorCopyTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_ARM_tensors")?;

        require_tensor_shape_supported(context, &self.src_parameters)?;
        require_tensor_shape_supported(context, &self.dst_parameters)?;

        if !check_support_linear_src_storage_tensor(context, self.src_parameters.format)
            || !check_support_optimal_storage_tensor(context, self.src_parameters.format)
            || !check_support_optimal_storage_tensor(context, self.dst_parameters.format)
            || !check_support_linear_dst_storage_tensor(context, self.dst_parameters.format)
        {
            return Err(TestError::NotSupported("Format not supported".to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(OptimalTensorCopyTestInstance {
            context,
            src_parameters: &self.src_parameters,
            dst_parameters: &self.dst_parameters,
            kind: self.kind,
        })
    }
}

struct OptimalTensorCopyTestInstance<'a> {
    context: &'a Context<'a>,
    src_parameters: &'a TensorParameters,
    dst_parameters: &'a TensorParameters,
    kind: ElementKind,
}

impl OptimalTensorCopyTestInstance<'_> {
    fn run(&self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let both_transfer = vk::TensorUsageFlagsARM::TRANSFER_SRC | vk::TensorUsageFlagsARM::TRANSFER_DST;

        // Linear > Optimal > Optimal > Linear: the first and last tensors must have linear strides to be written and read manually
        let src_tensor_desc_linear = TensorDescription::new(
            vk::TensorTilingARM::LINEAR,
            self.src_parameters.format,
            &self.src_parameters.dimensions,
            &self.src_parameters.strides,
            vk::TensorUsageFlagsARM::TRANSFER_SRC,
        );
        let src_tensor_linear = TensorWithMemory::new(context, &src_tensor_desc_linear, MemoryRequirement::ANY)?;

        let src_tensor_desc_optimal = TensorDescription::new(
            vk::TensorTilingARM::OPTIMAL,
            self.src_parameters.format,
            &self.src_parameters.dimensions,
            &self.src_parameters.strides,
            both_transfer,
        );
        let src_tensor_optimal = TensorWithMemory::new(context, &src_tensor_desc_optimal, MemoryRequirement::ANY)?;

        let dst_tensor_desc_optimal = TensorDescription::new(
            vk::TensorTilingARM::OPTIMAL,
            self.dst_parameters.format,
            &self.dst_parameters.dimensions,
            &self.dst_parameters.strides,
            both_transfer,
        );
        let dst_tensor_optimal = TensorWithMemory::new(context, &dst_tensor_desc_optimal, MemoryRequirement::ANY)?;

        let dst_tensor_desc_linear = TensorDescription::new(
            vk::TensorTilingARM::LINEAR,
            self.dst_parameters.format,
            &self.dst_parameters.dimensions,
            &self.dst_parameters.strides,
            vk::TensorUsageFlagsARM::TRANSFER_DST,
        );
        let dst_tensor_linear = TensorWithMemory::new(context, &dst_tensor_desc_linear, MemoryRequirement::ANY)?;

        let mut input_data =
            StridedMemory::new(&self.src_parameters.dimensions, &self.src_parameters.strides, self.kind);
        input_data.fill();

        upload_to_tensor(context, &src_tensor_linear, input_data.data())?;
        clear_tensor(context, &dst_tensor_linear)?;

        {
            let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
            let cmd_buffer = allocate_command_buffer(device, cmd_pool.get(), vk::CommandBufferLevel::PRIMARY)?;

            begin_command_buffer(device, cmd_buffer.get())?;

            let inter_copies_barrier =
                make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::TRANSFER_READ);

            let tensor_regions = vk::TensorCopyARM {
                dimension_count: self.src_parameters.dimensions.len() as u32,
                ..Default::default()
            };

            let copies = [
                (src_tensor_linear.get(), src_tensor_optimal.get()),
                (src_tensor_optimal.get(), dst_tensor_optimal.get()),
                (dst_tensor_optimal.get(), dst_tensor_linear.get()),
            ];
            for (index, (src, dst)) in copies.into_iter().enumerate() {
                let copy_info = vk::CopyTensorInfoARM {
                    src_tensor: src,
                    dst_tensor: dst,
                    regions: &tensor_regions,
                    region_count: 1,
                    ..Default::default()
                };
                unsafe { device.cmd_copy_tensor_arm(cmd_buffer.get(), &copy_info) };
                if index + 1 < copies.len() {
                    unsafe {
                        device.cmd_pipeline_barrier(
                            cmd_buffer.get(),
                            vk::PipelineStageFlags::TRANSFER,
                            vk::PipelineStageFlags::TRANSFER,
                            vk::DependencyFlags::empty(),
                            &[inter_copies_barrier],
                            &[] as &[vk::BufferMemoryBarrier],
                            &[] as &[vk::ImageMemoryBarrier],
                        )
                    };
                }
            }

            end_command_buffer(device, cmd_buffer.get())?;
            submit_commands_and_wait(device, context.get_universal_queue(), cmd_buffer.get())?;
        }

        let mut result = StridedMemory::new(&self.dst_parameters.dimensions, &self.dst_parameters.strides, self.kind);
        let downloaded = download_from_tensor(context, &dst_tensor_linear, result.memory_size())?;
        result.data_mut().copy_from_slice(&downloaded);

        Ok(compare_strided_memory(&result, &input_data))
    }
}

impl TestInstance for OptimalTensorCopyTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        self.run()
    }
}

/// `compatibleFormats<T>::formats`
fn compatible_formats(element_size: u64) -> &'static [vk::Format] {
    match element_size {
        1 => &[
            vk::Format::R8_UINT,
            vk::Format::R8_SINT,
            vk::Format::R8_BOOL_ARM,
            vk::Format::R8_SFLOAT_FPENCODING_FLOAT8E5M2_ARM,
            vk::Format::R8_SFLOAT_FPENCODING_FLOAT8E4M3_ARM,
        ],
        2 => &[
            vk::Format::R16_UINT,
            vk::Format::R16_SINT,
            vk::Format::R16_SFLOAT,
            vk::Format::R16_SFLOAT_FPENCODING_BFLOAT16_ARM,
        ],
        4 => &[vk::Format::R32_UINT, vk::Format::R32_SINT, vk::Format::R32_SFLOAT],
        _ => &[vk::Format::R64_UINT, vk::Format::R64_SINT, vk::Format::R64_SFLOAT],
    }
}

/// `addTensorCopyTests<SrcFormat>`
fn add_tensor_copy_tests(cases: &mut HashMap<String, Box<dyn TestCase>>, src_format: vk::Format) {
    const SHAPES: [&[i64]; 5] = [
        &[71693],
        &[263, 269],
        &[37, 43, 47],
        &[13, 17, 19, 23],
        &[7, 11, 13, 17, 19, 23],
    ];

    let kind = ElementKind::for_format(src_format);
    let element_size = get_format_size(src_format);

    let mut add_linear = |src_parameters: TensorParameters, dst_parameters: TensorParameters| {
        let name = format!(
            "{}_to_{}",
            params_to_string(&src_parameters),
            params_to_string(&dst_parameters)
        );
        cases.insert(
            format!("copies.{name}"),
            Box::new(LinearTensorCopyTestCase {
                name,
                src_parameters,
                dst_parameters,
                kind,
            }),
        );
    };

    for shape in SHAPES {
        for &dst_format in compatible_formats(element_size) {
            add_linear(
                TensorParameters::new(src_format, vk::TensorTilingARM::LINEAR, shape, &[]),
                TensorParameters::new(dst_format, vk::TensorTilingARM::LINEAR, shape, &[]),
            );

            let rank = shape.len();
            let element_size_i = element_size as i64;

            let mut padded_strides = vec![0i64; rank];
            padded_strides[rank - 1] = element_size_i;
            for i in 2..=rank {
                padded_strides[rank - i] = padded_strides[rank - i + 1] * shape[rank - i + 1] + 13 * element_size_i;
            }

            if rank > 1 {
                add_linear(
                    TensorParameters::new(src_format, vk::TensorTilingARM::LINEAR, shape, &[]),
                    TensorParameters::new(dst_format, vk::TensorTilingARM::LINEAR, shape, &padded_strides),
                );
            }

            if rank > 1 {
                add_linear(
                    TensorParameters::new(src_format, vk::TensorTilingARM::LINEAR, shape, &padded_strides),
                    TensorParameters::new(dst_format, vk::TensorTilingARM::LINEAR, shape, &[]),
                );
            }
        }
    }
}

fn add_optimal_tensor_copy_tests(cases: &mut HashMap<String, Box<dyn TestCase>>, src_format: vk::Format) {
    const SHAPES: [&[i64]; 5] = [
        &[71693],
        &[263, 269],
        &[37, 43, 47],
        &[13, 17, 19, 23],
        &[7, 11, 13, 17, 19, 23],
    ];

    let kind = ElementKind::for_format(src_format);
    for shape in SHAPES {
        for &dst_format in compatible_formats(get_format_size(src_format)) {
            let src_parameters = TensorParameters::new(src_format, vk::TensorTilingARM::OPTIMAL, shape, &[]);
            let dst_parameters = TensorParameters::new(dst_format, vk::TensorTilingARM::OPTIMAL, shape, &[]);
            let name = format!(
                "{}_to_{}",
                params_to_string(&src_parameters),
                params_to_string(&dst_parameters)
            );
            cases.insert(
                format!("copies.{name}"),
                Box::new(OptimalTensorCopyTestCase {
                    name,
                    src_parameters,
                    dst_parameters,
                    kind,
                }),
            );
        }
    }
}

/// `createTensorCopyTests`: the cases keyed by their dotted path (`copies.<name>`)
pub fn create_tensor_copy_cases() -> HashMap<String, Box<dyn TestCase>> {
    let mut cases = HashMap::new();
    for format in [
        vk::Format::R8_UINT,
        vk::Format::R8_SINT,
        vk::Format::R16_UINT,
        vk::Format::R16_SINT,
        vk::Format::R32_UINT,
        vk::Format::R32_SINT,
        vk::Format::R64_UINT,
        vk::Format::R64_SINT,
        vk::Format::R16_SFLOAT,
        vk::Format::R32_SFLOAT,
    ] {
        add_tensor_copy_tests(&mut cases, format);
        add_optimal_tensor_copy_tests(&mut cases, format);
    }
    cases
}
