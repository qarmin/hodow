// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiCopyMemoryIndirectTests.cpp   (addCopyMemoryToImageTests and the add*MemoryToImageTests)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The cases are `CopyBufferToImageCase`s with `indirect_copy` set, which records
// `vkCmdCopyMemoryToImageIndirectKHR` over a table of commands whose stride is longer than the command. `2d_mipmap_images` is
// `compressed_image_to_buffer_tests::add_2d_mipmap_images`. Not ported: `checkTransferQueueGranularity` on the transfer queue.

use vulkanalia::prelude::v1_0::*;

use super::copies_buffer_tests::{AllocationKind, CopyCommandVariant, QueueSelection};
use super::copies_image_tests::{BufferImageCopy, CopyBufferToImageCase, FillMode, GroupParams, ImageParms};
use crate::vkt::TestCaseGroup;

const DEFAULT_SIZE: u32 = 64;
const DEFAULT_HALF_SIZE: u32 = DEFAULT_SIZE / 2;
const DEFAULT_QUARTER_SIZE: u32 = DEFAULT_SIZE / 4;
const DEFAULT_1D_EXTENT: [u32; 3] = [DEFAULT_SIZE, 1, 1];
const DEFAULT_EXTENT: [u32; 3] = [DEFAULT_SIZE, DEFAULT_SIZE, 1];
const DEFAULT_HALF_EXTENT: [u32; 3] = [DEFAULT_HALF_SIZE, DEFAULT_HALF_SIZE, 1];
const REMAINING_ARRAY_LAYERS: u32 = u32::MAX;

/// `defaultSourceLayer` and the region around it.
fn copy_region(
    buffer_offset: u64,
    row_length: u32,
    image_height: u32,
    base_layer: u32,
    layer_count: u32,
    image_offset: [i32; 3],
    image_extent: [u32; 3],
) -> BufferImageCopy {
    BufferImageCopy {
        aspect_mask: vk::ImageAspectFlags::COLOR,
        buffer_offset,
        buffer_row_length: row_length,
        buffer_image_height: image_height,
        base_array_layer: base_layer,
        layer_count,
        image_offset,
        image_extent,
    }
}

fn image(
    image_type: vk::ImageType,
    format: vk::Format,
    extent: [u32; 3],
    tiling: vk::ImageTiling,
    fill_mode: FillMode,
) -> ImageParms {
    ImageParms {
        image_type,
        format,
        extent,
        tiling,
        fill_mode,
        create_flags: None,
    }
}

fn texel_size(format: vk::Format) -> u64 {
    crate::tcu::map_vk_format(format)
        .and_then(|f| f.pixel_size())
        .unwrap_or(4) as u64
}

fn with_depth(extent: [u32; 3], depth: u32) -> [u32; 3] {
    [extent[0], extent[1], depth]
}

/// `add1dMemoryToImageTests`
fn add_1d_memory_to_image_tests(group: &mut TestCaseGroup, gp: &GroupParams) {
    let optimal = vk::ImageTiling::OPTIMAL;
    let one_d = vk::ImageType::_1D;
    let whole = |buffer_image_height: u32| copy_region(0, 0, buffer_image_height, 0, 1, [0, 0, 0], DEFAULT_1D_EXTENT);

    group.add_child(CopyBufferToImageCase::memory_to_image(
        "tightly_sized_buffer",
        DEFAULT_SIZE,
        FillMode::Gradient,
        image(
            one_d,
            vk::Format::R8G8B8A8_UINT,
            DEFAULT_1D_EXTENT,
            optimal,
            FillMode::Gradient,
        ),
        vec![whole(0)],
        gp,
        false,
        false,
        None,
    ));

    let buffer_image_height = DEFAULT_SIZE + 1;
    group.add_child(CopyBufferToImageCase::memory_to_image(
        "larger_buffer",
        buffer_image_height,
        FillMode::Gradient,
        image(
            one_d,
            vk::Format::R8G8B8A8_UINT,
            DEFAULT_1D_EXTENT,
            optimal,
            FillMode::Gradient,
        ),
        vec![whole(buffer_image_height)],
        gp,
        false,
        false,
        None,
    ));

    let array_layers = 16u32;
    let rgba8 = vk::Format::R8G8B8A8_UNORM;
    let pixel_size = texel_size(rgba8);
    let per_layer = |buffer_image_height: u32| -> Vec<BufferImageCopy> {
        (0..array_layers)
            .map(|layer| {
                copy_region(
                    u64::from(DEFAULT_SIZE) * pixel_size * u64::from(layer),
                    0,
                    buffer_image_height,
                    layer,
                    1,
                    [0, 0, 0],
                    DEFAULT_1D_EXTENT,
                )
            })
            .collect()
    };
    group.add_child(CopyBufferToImageCase::memory_to_image(
        "array_tightly_sized_buffer",
        DEFAULT_SIZE * array_layers,
        FillMode::Gradient,
        image(
            one_d,
            rgba8,
            with_depth(DEFAULT_1D_EXTENT, array_layers),
            optimal,
            FillMode::Gradient,
        ),
        per_layer(0),
        gp,
        false,
        false,
        None,
    ));

    for (name, base_layer) in [
        ("array_all_remaining_layers", 0u32),
        ("array_not_all_remaining_layers", 2u32),
    ] {
        group.add_child(CopyBufferToImageCase::memory_to_image(
            name,
            DEFAULT_SIZE * array_layers,
            FillMode::Red,
            image(
                one_d,
                rgba8,
                with_depth(DEFAULT_1D_EXTENT, array_layers),
                optimal,
                FillMode::Red,
            ),
            vec![copy_region(
                0,
                0,
                0,
                base_layer,
                REMAINING_ARRAY_LAYERS,
                [0, 0, 0],
                DEFAULT_1D_EXTENT,
            )],
            gp,
            true,
            false,
            None,
        ));
    }

    let larger_height = DEFAULT_SIZE + 1;
    group.add_child(CopyBufferToImageCase::memory_to_image(
        "array_larger_buffer",
        DEFAULT_SIZE * array_layers,
        FillMode::Gradient,
        image(
            one_d,
            rgba8,
            with_depth(DEFAULT_1D_EXTENT, array_layers),
            optimal,
            FillMode::Gradient,
        ),
        per_layer(larger_height),
        gp,
        false,
        false,
        None,
    ));
}

/// `add1dFormatTestCase` / `add2dFormatTestCase` over the format list both `add*AdditionalFormatsTests` share.
fn add_additional_formats_tests(group: &mut TestCaseGroup, gp: &GroupParams, image_type: vk::ImageType) {
    let (extent, buffer_size) = if image_type == vk::ImageType::_1D {
        (DEFAULT_1D_EXTENT, DEFAULT_SIZE)
    } else {
        (DEFAULT_EXTENT, DEFAULT_SIZE * DEFAULT_SIZE)
    };
    let formats: &[(vk::Format, &str, vk::ImageTiling)] = &[
        (vk::Format::R8G8_UNORM, "r8g8_unorm", vk::ImageTiling::OPTIMAL),
        (vk::Format::R8G8_UINT, "r8g8_uint", vk::ImageTiling::OPTIMAL),
        (
            vk::Format::A2R10G10B10_UNORM_PACK32,
            "a2r10g10b10_unorm",
            vk::ImageTiling::OPTIMAL,
        ),
        (vk::Format::R16_UINT, "r16_uint", vk::ImageTiling::OPTIMAL),
        (vk::Format::R16_SFLOAT, "r16_sfloat", vk::ImageTiling::OPTIMAL),
        (vk::Format::R16G16_UNORM, "r16g16_unorm", vk::ImageTiling::OPTIMAL),
        (
            vk::Format::R16G16B16A16_SNORM,
            "r16g16b16a16_snorm",
            vk::ImageTiling::OPTIMAL,
        ),
        (vk::Format::R32G32_UINT, "r32g32_uint", vk::ImageTiling::OPTIMAL),
        (vk::Format::R32G32_SFLOAT, "r32g32_sfloat", vk::ImageTiling::OPTIMAL),
        (vk::Format::R32G32B32_UINT, "r32g32b32_uint", vk::ImageTiling::OPTIMAL),
        (vk::Format::R32G32B32_SINT, "r32g32b32_sint", vk::ImageTiling::OPTIMAL),
        (
            vk::Format::R32G32B32_SFLOAT,
            "r32g32b32_sfloat",
            vk::ImageTiling::OPTIMAL,
        ),
        (
            vk::Format::R32G32B32_UINT,
            "r32g32b32_uint_linear",
            vk::ImageTiling::LINEAR,
        ),
        (
            vk::Format::R32G32B32_SINT,
            "r32g32b32_sint_linear",
            vk::ImageTiling::LINEAR,
        ),
        (
            vk::Format::R32G32B32_SFLOAT,
            "r32g32b32_sfloat_linear",
            vk::ImageTiling::LINEAR,
        ),
        (
            vk::Format::R32G32B32A32_UINT,
            "r32g32b32a32_uint",
            vk::ImageTiling::OPTIMAL,
        ),
    ];
    for &(format, name, tiling) in formats {
        // The 1D group has no linear variants.
        if image_type == vk::ImageType::_1D && tiling == vk::ImageTiling::LINEAR {
            continue;
        }
        group.add_child(CopyBufferToImageCase::memory_to_image(
            name,
            buffer_size,
            FillMode::Gradient,
            image(image_type, format, extent, tiling, FillMode::Gradient),
            vec![copy_region(0, 0, 0, 0, 1, [0, 0, 0], extent)],
            gp,
            false,
            false,
            None,
        ));
    }
}

/// `add2dMemoryToImageTests`
fn add_2d_memory_to_image_tests(group: &mut TestCaseGroup, gp: &GroupParams) {
    let optimal = vk::ImageTiling::OPTIMAL;
    let two_d = vk::ImageType::_2D;
    let rgba8 = vk::Format::R8G8B8A8_UNORM;
    let gradient = FillMode::Gradient;
    let case = |name: &str,
                buffer_size: u32,
                fill: FillMode,
                dst: ImageParms,
                regions: Vec<BufferImageCopy>,
                needs_maintenance5: bool,
                needs_maintenance11: bool,
                conditional: Option<u32>| {
        CopyBufferToImageCase::memory_to_image(
            name,
            buffer_size,
            fill,
            dst,
            regions,
            gp,
            needs_maintenance5,
            needs_maintenance11,
            conditional,
        )
    };
    let half_offset = [DEFAULT_QUARTER_SIZE as i32, DEFAULT_QUARTER_SIZE as i32, 0];

    let whole_image = image(two_d, vk::Format::R8G8B8A8_UINT, DEFAULT_EXTENT, optimal, gradient);
    let whole_region = vec![copy_region(0, 0, 0, 0, 1, [0, 0, 0], DEFAULT_EXTENT)];
    group.add_child(case(
        "whole",
        DEFAULT_SIZE * DEFAULT_SIZE,
        gradient,
        whole_image,
        whole_region.clone(),
        false,
        false,
        None,
    ));
    group.add_child(case(
        "conditional_off",
        DEFAULT_SIZE * DEFAULT_SIZE,
        gradient,
        whole_image,
        whole_region.clone(),
        false,
        false,
        Some(0),
    ));
    group.add_child(case(
        "conditional_on",
        DEFAULT_SIZE * DEFAULT_SIZE,
        gradient,
        whole_image,
        whole_region,
        false,
        false,
        Some(1),
    ));

    let mut regions = Vec::new();
    let mut divisor = 1u32;
    let mut offset = 0i32;
    while (offset + (DEFAULT_QUARTER_SIZE / divisor) as i32) < DEFAULT_SIZE as i32 && DEFAULT_QUARTER_SIZE > divisor {
        let size = DEFAULT_QUARTER_SIZE / divisor;
        regions.push(copy_region(
            0,
            0,
            0,
            0,
            1,
            [offset, DEFAULT_HALF_SIZE as i32, 0],
            [size, size, 1],
        ));
        offset += (DEFAULT_QUARTER_SIZE / divisor) as i32;
        divisor += 1;
    }
    group.add_child(case(
        "regions",
        DEFAULT_SIZE * DEFAULT_SIZE,
        gradient,
        image(two_d, rgba8, DEFAULT_EXTENT, optimal, gradient),
        regions,
        false,
        false,
        None,
    ));

    let row = DEFAULT_HALF_SIZE + DEFAULT_QUARTER_SIZE;
    group.add_child(case(
        "buffer_offset",
        DEFAULT_SIZE * DEFAULT_SIZE,
        gradient,
        image(two_d, rgba8, DEFAULT_EXTENT, optimal, gradient),
        vec![copy_region(
            u64::from(DEFAULT_QUARTER_SIZE),
            row,
            row,
            0,
            1,
            half_offset,
            DEFAULT_HALF_EXTENT,
        )],
        false,
        false,
        None,
    ));

    let relaxed = gp.queue_selection == QueueSelection::Universal || gp.queue_selection == QueueSelection::TransferOnly;
    if relaxed {
        group.add_child(case(
            "buffer_offset_relaxed",
            DEFAULT_SIZE * DEFAULT_SIZE,
            gradient,
            image(two_d, vk::Format::R8_UNORM, DEFAULT_EXTENT, optimal, gradient),
            vec![copy_region(
                u64::from(DEFAULT_QUARTER_SIZE) + 1,
                row,
                row,
                0,
                1,
                half_offset,
                DEFAULT_HALF_EXTENT,
            )],
            false,
            gp.queue_selection == QueueSelection::TransferOnly,
            None,
        ));
    }

    group.add_child(case(
        "tightly_sized_buffer",
        (DEFAULT_HALF_SIZE - 1) * DEFAULT_SIZE + DEFAULT_HALF_SIZE,
        gradient,
        image(two_d, rgba8, DEFAULT_EXTENT, optimal, gradient),
        vec![copy_region(
            0,
            DEFAULT_SIZE,
            DEFAULT_SIZE,
            0,
            1,
            half_offset,
            DEFAULT_HALF_EXTENT,
        )],
        false,
        false,
        None,
    ));

    let buffer_image_height = DEFAULT_SIZE + 1;
    group.add_child(case(
        "larger_buffer",
        DEFAULT_SIZE * buffer_image_height,
        gradient,
        image(two_d, rgba8, DEFAULT_EXTENT, optimal, gradient),
        vec![copy_region(
            0,
            DEFAULT_SIZE,
            buffer_image_height,
            0,
            1,
            [0, 0, 0],
            DEFAULT_HALF_EXTENT,
        )],
        false,
        false,
        None,
    ));

    group.add_child(case(
        "tightly_sized_buffer_offset",
        (DEFAULT_HALF_SIZE - 1) * DEFAULT_SIZE + DEFAULT_HALF_SIZE + DEFAULT_QUARTER_SIZE,
        gradient,
        image(two_d, rgba8, DEFAULT_EXTENT, optimal, gradient),
        vec![copy_region(
            u64::from(DEFAULT_QUARTER_SIZE),
            DEFAULT_SIZE,
            DEFAULT_SIZE,
            0,
            1,
            half_offset,
            DEFAULT_HALF_EXTENT,
        )],
        false,
        false,
        None,
    ));

    let array_layers = 16u32;
    let pixel_size = texel_size(rgba8);
    let half_area = u64::from(DEFAULT_HALF_SIZE) * u64::from(DEFAULT_HALF_SIZE);
    let array_image = image(
        two_d,
        rgba8,
        with_depth(DEFAULT_HALF_EXTENT, array_layers),
        optimal,
        gradient,
    );
    let per_layer = |row_length: u32, image_height: u32, layer_pitch_rows: u32| -> Vec<BufferImageCopy> {
        (0..array_layers)
            .map(|layer| {
                let offset = u64::from(DEFAULT_HALF_SIZE) * u64::from(layer_pitch_rows) * pixel_size * u64::from(layer);
                copy_region(
                    offset,
                    row_length,
                    image_height,
                    layer,
                    1,
                    [0, 0, 0],
                    DEFAULT_HALF_EXTENT,
                )
            })
            .collect()
    };
    group.add_child(case(
        "array",
        (half_area as u32) * array_layers,
        gradient,
        array_image,
        per_layer(0, 0, DEFAULT_HALF_SIZE),
        false,
        false,
        None,
    ));
    let array_height = DEFAULT_HALF_SIZE + 1;
    group.add_child(case(
        "array_larger_buffer",
        DEFAULT_HALF_SIZE * array_height * array_layers,
        gradient,
        array_image,
        per_layer(DEFAULT_HALF_SIZE, array_height, array_height),
        false,
        false,
        None,
    ));
    group.add_child(case(
        "array_tightly_sized_buffer",
        (half_area as u32) * array_layers,
        gradient,
        array_image,
        per_layer(DEFAULT_HALF_SIZE, DEFAULT_HALF_SIZE, DEFAULT_HALF_SIZE),
        false,
        false,
        None,
    ));

    for (name, base_layer) in [
        ("array_all_remaining_layers", 0u32),
        ("array_not_all_remaining_layers", 2u32),
    ] {
        group.add_child(case(
            name,
            (half_area as u32) * array_layers,
            FillMode::Red,
            image(
                two_d,
                rgba8,
                with_depth(DEFAULT_HALF_EXTENT, array_layers),
                optimal,
                FillMode::Red,
            ),
            vec![copy_region(
                0,
                0,
                0,
                base_layer,
                REMAINING_ARRAY_LAYERS,
                [0, 0, 0],
                DEFAULT_HALF_EXTENT,
            )],
            true,
            false,
            None,
        ));
    }
}

/// `add3dMemoryToImageTests`: slices go in as array layers, which is how an indirect copy addresses a 3D image.
fn add_3d_memory_to_image_tests(group: &mut TestCaseGroup, gp: &GroupParams) {
    let optimal = vk::ImageTiling::OPTIMAL;
    let three_d = vk::ImageType::_3D;
    let depth_layers = 16u32;
    let buffer_size = DEFAULT_HALF_SIZE * DEFAULT_HALF_SIZE * depth_layers;
    let extent = with_depth(DEFAULT_HALF_EXTENT, depth_layers);
    let case = |name: &str, format: vk::Format, regions: Vec<BufferImageCopy>| {
        CopyBufferToImageCase::memory_to_image(
            name,
            buffer_size,
            FillMode::Gradient,
            image(three_d, format, extent, optimal, FillMode::Gradient),
            regions,
            gp,
            false,
            false,
            None,
        )
    };
    let per_slice = |format: vk::Format| -> Vec<BufferImageCopy> {
        let pixel_size = texel_size(format);
        (0..depth_layers)
            .map(|slice| {
                copy_region(
                    u64::from(DEFAULT_HALF_SIZE) * u64::from(DEFAULT_HALF_SIZE) * pixel_size * u64::from(slice),
                    0,
                    0,
                    slice,
                    1,
                    [0, 0, 0],
                    DEFAULT_HALF_EXTENT,
                )
            })
            .collect()
    };

    group.add_child(case(
        "r8g8b8a8_copy_per_slice",
        vk::Format::R8G8B8A8_UNORM,
        per_slice(vk::Format::R8G8B8A8_UNORM),
    ));

    let rgba8 = vk::Format::R8G8B8A8_UNORM;
    let pixel_size = texel_size(rgba8) as u32;
    let quadrant_width = (DEFAULT_HALF_EXTENT[0] / 2) as i32;
    let quadrant_height = (DEFAULT_HALF_EXTENT[1] / 2) as i32;
    let mut quadrants = Vec::new();
    for slice in 0..depth_layers {
        for quad_y in 0..2i32 {
            for quad_x in 0..2i32 {
                let base_slice_offset = DEFAULT_HALF_SIZE * DEFAULT_HALF_SIZE * pixel_size * slice;
                let quadrant_offset = quad_y as u32 * (quadrant_height as u32 * DEFAULT_HALF_SIZE * pixel_size)
                    + quad_x as u32 * (quadrant_width as u32 * pixel_size);
                quadrants.push(copy_region(
                    u64::from(base_slice_offset + quadrant_offset),
                    DEFAULT_HALF_SIZE,
                    0,
                    slice,
                    1,
                    [quad_x * quadrant_width, quad_y * quadrant_height, slice as i32],
                    [quadrant_width as u32, quadrant_height as u32, 1],
                ));
            }
        }
    }
    group.add_child(case("r8g8b8a8_quadrant_copies", rgba8, quadrants));
    group.add_child(case(
        "r32g32_sfloat_copy_per_slice",
        vk::Format::R32G32_SFLOAT,
        per_slice(vk::Format::R32G32_SFLOAT),
    ));

    let all_slices = vec![copy_region(0, 0, 0, 0, depth_layers, [0, 0, 0], DEFAULT_HALF_EXTENT)];
    group.add_child(case("r8g8b8a8_all_slices_at_once", rgba8, all_slices.clone()));
    group.add_child(case(
        "r8g8_sint_all_slices_at_once",
        vk::Format::R8G8_SINT,
        all_slices.clone(),
    ));
    group.add_child(case(
        "r32g32_sfloat_all_slices_at_once",
        vk::Format::R32G32_SFLOAT,
        all_slices,
    ));
}

/// The `memory_to_image_indirect*` groups of `addIndirectCopyTests`.
pub fn add_memory_to_image_indirect_groups(
    parent: &mut TestCaseGroup,
    name: &str,
    allocation_kind: AllocationKind,
    queue_selection: QueueSelection,
) {
    let gp = GroupParams {
        indirect_copy: true,
        allocation_kind,
        command_variant: CopyCommandVariant::Core,
        queue_selection,
        general_layout: false,
        use_sparse_binding: false,
    };
    let mut group = TestCaseGroup::new(name);

    let mut images_1d = TestCaseGroup::new("1d_images");
    add_1d_memory_to_image_tests(&mut images_1d, &gp);
    group.add_child(images_1d);

    let mut formats_1d = TestCaseGroup::new("1d_additional_formats");
    add_additional_formats_tests(&mut formats_1d, &gp, vk::ImageType::_1D);
    group.add_child(formats_1d);

    let mut images_2d = TestCaseGroup::new("2d_images");
    add_2d_memory_to_image_tests(&mut images_2d, &gp);
    group.add_child(images_2d);

    let mut mipmap_images = TestCaseGroup::new("2d_mipmap_images");
    super::compressed_image_to_buffer_tests::add_2d_mipmap_images(&mut mipmap_images, &gp);
    group.add_child(mipmap_images);

    let mut formats_2d = TestCaseGroup::new("2d_additional_formats");
    add_additional_formats_tests(&mut formats_2d, &gp, vk::ImageType::_2D);
    group.add_child(formats_2d);

    let mut images_3d = TestCaseGroup::new("3d_images");
    add_3d_memory_to_image_tests(&mut images_3d, &gp);
    group.add_child(images_3d);

    parent.add_child(group);
}
