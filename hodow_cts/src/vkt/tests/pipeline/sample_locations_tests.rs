// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineMultisampleSampleLocationsExtTests.cpp
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineSampleLocationsUtil.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2018 The Khronos Group Inc.
// Copyright (c) 2018 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Monolithic pipelines only, without the VK_KHR_fragment_shading_rate
// variants. The two groups of upstream's `createMultisampleSampleLocationsTests` are built here, `sample_locations_ext`
// and `std_sample_locations`, each with the `query` cases (extension group only), `verify_location`,
// `verify_interpolation` and `draw`. `RenderTarget` is reduced to the one subpass it is used with in those cases. The grid sizes a
// case iterates over are looped inside `iterate` instead of returning `incomplete` between them, and the log output of
// the pixel grid is dropped.
//
// The `draw` groups are in `sample_locations_draw_tests`.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    DeviceV1_3, ExtExtendedDynamicState3ExtensionDeviceCommands, ExtSampleLocationsExtensionDeviceCommands,
    ExtSampleLocationsExtensionInstanceCommands, InstanceV1_1,
};

use crate::generated::shaders::pipeline_multisample_sample_locations::{
    SAMPLE_LOCATIONS_VERIFY_INTERPOLATION, SAMPLE_LOCATIONS_VERIFY_LOCATION,
};
use crate::tcu::random::Random;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_framebuffer, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::api::case_util::{add_case, add_function_case};
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{DrawPipelineState, clear_value_color, create_draw_pipeline, rect_2d};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::tests::pipeline::shader_object_draw::{end_dynamic_rendering, make_shader_objects};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const CLEAR_COLOR_0: [f32; 4] = [0.0, 0.0, 0.0, 1.0];
/// `SampleDataSSBO::STATIC_SIZE`
const SAMPLE_DATA_STATIC_SIZE: usize = 6 * std::mem::size_of::<u32>();

const TEST_OPTION_DYNAMIC_STATE_BIT: u32 = 1 << 0;
const TEST_OPTION_CLOSELY_PACKED_BIT: u32 = 1 << 1;
const TEST_OPTION_VARIABLE_SAMPLE_LOCATIONS_BIT: u32 = 1 << 3;
const TEST_OPTION_STD_SAMPLE_LOCATIONS_BIT: u32 = 1 << 4;

pub(super) const VERIFY_SAMPLE_COUNTS: [vk::SampleCountFlags; 5] = [
    vk::SampleCountFlags::_1,
    vk::SampleCountFlags::_2,
    vk::SampleCountFlags::_4,
    vk::SampleCountFlags::_8,
    vk::SampleCountFlags::_16,
];

/// `MultisamplePixelGrid`
pub(super) struct MultisamplePixelGrid {
    grid_size: (u32, u32),
    num_samples: vk::SampleCountFlags,
    sample_locations: Vec<vk::SampleLocationEXT>,
}

impl MultisamplePixelGrid {
    pub(super) fn new(grid_size: (u32, u32), num_samples: vk::SampleCountFlags) -> Self {
        let count = (grid_size.0 * grid_size.1 * num_samples.bits()) as usize;
        Self {
            grid_size,
            num_samples,
            sample_locations: vec![vk::SampleLocationEXT { x: 0.0, y: 0.0 }; count],
        }
    }

    fn samples_per_pixel(&self) -> u32 {
        self.num_samples.bits()
    }

    fn sample_index(&self, grid_x: u32, grid_y: u32, sample_ndx: u32) -> usize {
        let grid_x = grid_x % self.grid_size.0;
        let grid_y = grid_y % self.grid_size.1;
        ((grid_y * self.grid_size.0 + grid_x) * self.samples_per_pixel() + sample_ndx) as usize
    }

    /// If grid x,y is larger than the grid size, then each coordinate is wrapped.
    fn get_sample(&self, grid_x: u32, grid_y: u32, sample_ndx: u32) -> vk::SampleLocationEXT {
        self.sample_locations[self.sample_index(grid_x, grid_y, sample_ndx)]
    }

    fn set_sample(&mut self, grid_x: u32, grid_y: u32, sample_ndx: u32, location: vk::SampleLocationEXT) {
        let index = self.sample_index(grid_x, grid_y, sample_ndx);
        self.sample_locations[index] = location;
    }

    /// `makeSampleLocationsInfo`; references the data inside the grid.
    pub(super) fn locations_info(&self) -> vk::SampleLocationsInfoEXT {
        vk::SampleLocationsInfoEXT {
            s_type: vk::StructureType::SAMPLE_LOCATIONS_INFO_EXT,
            next: std::ptr::null(),
            sample_locations_per_pixel: self.num_samples,
            sample_location_grid_size: vk::Extent2D {
                width: self.grid_size.0,
                height: self.grid_size.1,
            },
            sample_locations_count: self.sample_locations.len() as u32,
            sample_locations: self.sample_locations.as_ptr(),
        }
    }
}

/// `fillSampleLocationsStd`
pub(super) fn fill_sample_locations_std(grid: &mut MultisamplePixelGrid) -> Result<(), TestError> {
    let std_locations: &[(f32, f32)] = match grid.samples_per_pixel() {
        1 => &[(0.5, 0.5)],
        2 => &[(0.75, 0.75), (0.25, 0.25)],
        4 => &[(0.375, 0.125), (0.875, 0.375), (0.125, 0.625), (0.625, 0.875)],
        8 => &[
            (0.5625, 0.3125),
            (0.4375, 0.6875),
            (0.8125, 0.5625),
            (0.3125, 0.1875),
            (0.1875, 0.8125),
            (0.0625, 0.4375),
            (0.6875, 0.9375),
            (0.9375, 0.0625),
        ],
        16 => &[
            (0.5625, 0.5625),
            (0.4375, 0.3125),
            (0.3125, 0.625),
            (0.75, 0.4375),
            (0.1875, 0.375),
            (0.625, 0.8125),
            (0.8125, 0.6875),
            (0.6875, 0.1875),
            (0.375, 0.875),
            (0.5, 0.0625),
            (0.25, 0.125),
            (0.125, 0.75),
            (0.0, 0.5),
            (0.9375, 0.25),
            (0.875, 0.9375),
            (0.0625, 0.0),
        ],
        _ => return Err(TestError::InternalError("Unexpected sample count".to_string())),
    };

    for grid_y in 0..grid.grid_size.1 {
        for grid_x in 0..grid.grid_size.0 {
            for (sample_ndx, &(x, y)) in std_locations.iter().enumerate() {
                grid.set_sample(grid_x, grid_y, sample_ndx as u32, vk::SampleLocationEXT { x, y });
            }
        }
    }
    Ok(())
}

/// `fillSampleLocationsRandom`: each grid pixel gets a distinct samples pattern, rounded to `sub_pixel_bits`.
pub(super) fn fill_sample_locations_random(grid: &mut MultisamplePixelGrid, sub_pixel_bits: u32, seed: u32) {
    let guard_offset = 1u32; // don't put samples on the right or the bottom edge of the pixel
    let max_location_index = 1u32 << sub_pixel_bits;
    let mut rng = Random::new(seed);

    for grid_y in 0..grid.grid_size.1 {
        for grid_x in 0..grid.grid_size.0 {
            let mut taken_location_indices = std::collections::BTreeSet::new();
            let mut sample_ndx = 0;
            while sample_ndx < grid.samples_per_pixel() {
                let location_x = rng.get_uint32() % (max_location_index + 1 - guard_offset);
                let location_y = rng.get_uint32() % (max_location_index + 1 - guard_offset);

                if taken_location_indices.insert((location_x, location_y)) {
                    let location = vk::SampleLocationEXT {
                        x: location_x as f32 / max_location_index as f32,
                        y: location_y as f32 / max_location_index as f32,
                    };
                    grid.set_sample(grid_x, grid_y, sample_ndx, location);
                    sample_ndx += 1;
                }
            }
        }
    }
}

/// `fillSampleLocationsPacked`: samples very close to each other.
fn fill_sample_locations_packed(grid: &mut MultisamplePixelGrid, sub_pixel_bits: u32) {
    let num_locations = 1u32 << sub_pixel_bits;
    let offset = [-1i32, 0, 1];
    let mut rng = Random::new(214);

    for grid_y in 0..grid.grid_size.1 {
        for grid_x in 0..grid.grid_size.0 {
            // Will start placing from this location
            let base_x = rng.get_uint32() % num_locations;
            let base_y = rng.get_uint32() % num_locations;
            let (mut location_x, mut location_y) = (base_x, base_y);

            let mut taken_location_indices = std::collections::BTreeSet::new();
            let mut sample_ndx = 0;
            while sample_ndx < grid.samples_per_pixel() {
                if !taken_location_indices.contains(&(location_x, location_y)) {
                    let location = vk::SampleLocationEXT {
                        x: location_x as f32 / num_locations as f32,
                        y: location_y as f32 / num_locations as f32,
                    };
                    grid.set_sample(grid_x, grid_y, sample_ndx, location);
                    taken_location_indices.insert((location_x, location_y));

                    sample_ndx += 1;
                }

                // Find next location by applying a small offset. Just keep iterating if a redundant location is chosen
                location_x = (location_x as i32 + offset[(rng.get_uint32() % offset.len() as u32) as usize])
                    .clamp(0, num_locations as i32 - 1) as u32;
                location_y = (location_y as i32 + offset[(rng.get_uint32() % offset.len() as u32) as usize])
                    .clamp(0, num_locations as i32 - 1) as u32;
            }
        }
    }
}

/// `genFramebufferSampleLocations`: NDC space sample locations at each framebuffer pixel, starting at pixel (0,0)
/// with `samplesPerPixel` locations per pixel.
fn gen_framebuffer_sample_locations(
    pixel_grid: &MultisamplePixelGrid,
    grid_size: (u32, u32),
    framebuffer_size: (u32, u32),
) -> Vec<[f32; 2]> {
    let mut locations = Vec::new();

    for y in 0..framebuffer_size.1 {
        for x in 0..framebuffer_size.0 {
            for sample_ndx in 0..pixel_grid.samples_per_pixel() {
                let location = pixel_grid.get_sample(x % grid_size.0, y % grid_size.1, sample_ndx);
                let global_x = location.x + x as f32;
                let global_y = location.y + y as f32;

                // Transform to [-1, 1] space
                locations.push([
                    -1.0 + 2.0 * (global_x / framebuffer_size.0 as f32),
                    -1.0 + 2.0 * (global_y / framebuffer_size.1 as f32),
                ]);
            }
        }
    }
    locations
}

/// `genVerticesFullQuad` with the default colour and z, as position and colour pairs.
fn gen_vertices_full_quad() -> Vec<[[f32; 4]; 2]> {
    let color = [1.0f32; 4];
    let z = 0.0f32;
    vec![
        [[1.0, -1.0, z, 1.0], color],
        [[-1.0, -1.0, z, 1.0], color],
        [[-1.0, 1.0, z, 1.0], color],
        [[-1.0, 1.0, z, 1.0], color],
        [[1.0, 1.0, z, 1.0], color],
        [[1.0, -1.0, z, 1.0], color],
    ]
}

/// `getSampleLocationsPropertiesEXT`
pub(super) fn get_sample_locations_properties(context: &Context<'_>) -> vk::PhysicalDeviceSampleLocationsPropertiesEXT {
    let mut sample_locations_properties = vk::PhysicalDeviceSampleLocationsPropertiesEXT::default();
    {
        let mut properties = vk::PhysicalDeviceProperties2::builder().push_next(&mut sample_locations_properties);
        unsafe {
            context
                .get_instance()
                .get_physical_device_properties2(context.get_physical_device(), &mut properties)
        };
    }
    sample_locations_properties
}

pub(super) fn check_sample_locations_ext(context: &Context<'_>) -> Result<(), TestError> {
    context.require_device_functionality("VK_EXT_sample_locations")
}

/// `testQuerySampleLocationProperties`
fn test_query_sample_location_properties(context: &Context<'_>) -> TestOutcome {
    let props = get_sample_locations_properties(context);

    let allowed_sample_counts = vk::SampleCountFlags::_1
        | vk::SampleCountFlags::_2
        | vk::SampleCountFlags::_4
        | vk::SampleCountFlags::_8
        | vk::SampleCountFlags::_16
        | vk::SampleCountFlags::_32
        | vk::SampleCountFlags::_64;

    if (props.sample_location_sample_counts & allowed_sample_counts).is_empty() {
        return Err(TestError::Fail("VkPhysicalDeviceSampleLocationsPropertiesEXT: sampleLocationSampleCounts should specify at least one MSAA sample count".to_string()));
    }

    // max not specified, but try to catch nonsense values like -1
    if props.max_sample_location_grid_size.width == 0
        || props.max_sample_location_grid_size.height == 0
        || props.max_sample_location_grid_size.width > 16384
        || props.max_sample_location_grid_size.height > 16384
    {
        return Err(TestError::Fail(
            "VkPhysicalDeviceSampleLocationsPropertiesEXT: maxSampleLocationGridSize must be at least (1,1) size"
                .to_string(),
        ));
    }

    for range in props.sample_location_coordinate_range {
        if !(0.0..=1.0).contains(&range) {
            return Err(TestError::Fail("VkPhysicalDeviceSampleLocationsPropertiesEXT: sampleLocationCoordinateRange[] values must be in [0, 1] range".to_string()));
        }
    }

    // max not specified, but try to catch nonsense values
    if props.sample_location_sub_pixel_bits == 0 || props.sample_location_sub_pixel_bits > 64 {
        return Err(TestError::Fail(
            "VkPhysicalDeviceSampleLocationsPropertiesEXT: sampleLocationSubPixelBits should be greater than 0"
                .to_string(),
        ));
    }

    Ok(TestStatus::pass("Pass"))
}

/// `testQueryMultisampleProperties`: verify results of vkGetPhysicalDeviceMultisamplePropertiesEXT queries
fn test_query_multisample_properties(context: &Context<'_>) -> TestOutcome {
    let props = get_sample_locations_properties(context);

    let sample_count_range = [
        vk::SampleCountFlags::_1,
        vk::SampleCountFlags::_2,
        vk::SampleCountFlags::_4,
        vk::SampleCountFlags::_8,
        vk::SampleCountFlags::_16,
        vk::SampleCountFlags::_32,
        vk::SampleCountFlags::_64,
    ];

    let mut all_ok = true;
    for samples in sample_count_range {
        let mut multisample_properties = vk::MultisamplePropertiesEXT::default();
        unsafe {
            context.get_instance().get_physical_device_multisample_properties_ext(
                context.get_physical_device(),
                samples,
                &mut multisample_properties,
            )
        };

        let grid_size = multisample_properties.max_sample_location_grid_size;
        if props.sample_location_sample_counts.contains(samples) {
            // Grid size should be the same or larger than maxSampleLocationGridSize
            if !(grid_size.width >= props.max_sample_location_grid_size.width
                && grid_size.height >= props.max_sample_location_grid_size.height)
            {
                all_ok = false;
            }
        } else if !(grid_size.width == 0 && grid_size.height == 0) {
            // Expected (0, 0) grid size
            all_ok = false;
        }
    }

    if !all_ok {
        return Err(TestError::Fail("Some values were incorrect".to_string()));
    }

    Ok(TestStatus::pass("Pass"))
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum VerifyKind {
    Location,
    Interpolation,
}

/// `VerifySamples::TestParams`, without the construction type
#[derive(Clone, Copy)]
struct VerifyParams {
    num_samples: vk::SampleCountFlags,
    options: u32,
}

impl VerifyParams {
    fn use_std_locations(&self) -> bool {
        self.options & TEST_OPTION_STD_SAMPLE_LOCATIONS_BIT != 0
    }
}

/// `getString(VkSampleCountFlagBits)`
pub(super) fn samples_string(samples: vk::SampleCountFlags) -> String {
    format!("samples_{}", samples.bits())
}

fn make_image<'a>(
    context: &'a Context<'a>,
    size: (u32, u32),
    samples: vk::SampleCountFlags,
    usage: vk::ImageUsageFlags,
) -> Result<ImageWithMemory<'a>, TestError> {
    let info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(COLOR_FORMAT)
        .extent(vk::Extent3D {
            width: size.0,
            height: size.1,
            depth: 1,
        })
        .mip_levels(1)
        .array_layers(1)
        .samples(samples)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(usage)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build();
    ImageWithMemory::new(
        context.get_device(),
        context.get_default_allocator(),
        info,
        MemoryRequirement::ANY,
    )
}

/// The render pass of `TestBase::drawSinglePass`: the multisampled colour attachment, resolved into the second one when the sample count is above one.
fn make_verify_render_pass<'a>(
    device: &'a Device,
    num_samples: vk::SampleCountFlags,
    msaa: bool,
) -> Result<Unique<'a, vk::RenderPass>, TestError> {
    let attachments = [
        vk::AttachmentDescription::builder()
            .format(COLOR_FORMAT)
            .samples(num_samples)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build(),
        vk::AttachmentDescription::builder()
            .format(COLOR_FORMAT)
            .samples(vk::SampleCountFlags::_1)
            .load_op(vk::AttachmentLoadOp::DONT_CARE)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build(),
    ];
    let color_refs = [vk::AttachmentReference {
        attachment: 0,
        layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    }];
    let resolve_refs = [if msaa {
        vk::AttachmentReference {
            attachment: 1,
            layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        }
    } else {
        vk::AttachmentReference {
            attachment: vk::ATTACHMENT_UNUSED,
            layout: vk::ImageLayout::UNDEFINED,
        }
    }];
    let subpasses = [vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .color_attachments(&color_refs)
        .resolve_attachments(&resolve_refs)
        .build()];
    // a final dependency to synchronize results for the copy commands that follow the render pass
    let dependencies = [vk::SubpassDependency {
        src_subpass: 0,
        dst_subpass: vk::SUBPASS_EXTERNAL,
        src_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
        dst_stage_mask: vk::PipelineStageFlags::TRANSFER,
        src_access_mask: vk::AccessFlags::COLOR_ATTACHMENT_WRITE | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
        dst_access_mask: vk::AccessFlags::TRANSFER_READ,
        dependency_flags: vk::DependencyFlags::empty(),
    }];
    let info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachments)
        .subpasses(&subpasses)
        .dependencies(&dependencies);
    Ok(Unique::new(
        device,
        unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?,
    ))
}

/// One iteration of `TestBase::iterate` for a grid size, with `testPixelGrid` of the case; true when the image is green.
fn test_pixel_grid<'a>(
    context: &'a Context<'a>,
    params: &VerifyParams,
    props: &vk::PhysicalDeviceSampleLocationsPropertiesEXT,
    kind: VerifyKind,
    grid_size: (u32, u32),
) -> Result<bool, TestError> {
    let device = context.get_device();
    let allocator = context.get_default_allocator();
    let use_std_locations = params.use_std_locations();
    let msaa = params.num_samples != vk::SampleCountFlags::_1;

    // Prepare the pixel grid
    let pixel_grid_repetitions = 2;
    let render_size = (
        pixel_grid_repetitions * grid_size.0,
        pixel_grid_repetitions * grid_size.1,
    );
    let mut pixel_grid = MultisamplePixelGrid::new(grid_size, params.num_samples);
    if use_std_locations {
        fill_sample_locations_std(&mut pixel_grid)?;
    } else if params.options & TEST_OPTION_CLOSELY_PACKED_BIT != 0 {
        fill_sample_locations_packed(&mut pixel_grid, props.sample_location_sub_pixel_bits);
    } else {
        fill_sample_locations_random(&mut pixel_grid, props.sample_location_sub_pixel_bits, 142);
    }

    // Create images
    let color_usage = if msaa {
        vk::ImageUsageFlags::COLOR_ATTACHMENT
    } else {
        vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC
    };
    let color_image = make_image(context, render_size, params.num_samples, color_usage)?;
    let color_view = make_image_view(
        device,
        color_image.get(),
        vk::ImageViewType::_2D,
        COLOR_FORMAT,
        make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
    )?;
    let resolve_image = make_image(
        context,
        render_size,
        vk::SampleCountFlags::_1,
        vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
    )?;
    let resolve_view = make_image_view(
        device,
        resolve_image.get(),
        vk::ImageViewType::_2D,
        COLOR_FORMAT,
        make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
    )?;
    let color_buffer_size = (render_size.0 * render_size.1 * 4) as vk::DeviceSize;
    let color_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(color_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    // Vertices and sample data of the case
    let num_samples_per_pixel = pixel_grid.samples_per_pixel();
    let locations = gen_framebuffer_sample_locations(&pixel_grid, pixel_grid.grid_size, render_size);
    let (vertex_buffer, num_vertices, vertex_stride, sample_data_size) = match kind {
        VerifyKind::Location => {
            // For each sample location (in the whole framebuffer), create a sub-pixel triangle that contains it.
            // NDC viewport size is 2.0 in X and Y and NDC pixel width/height depends on the framebuffer resolution.
            let pixel_size = [2.0 / render_size.0 as f32, 2.0 / render_size.1 as f32];
            let std_precision = (((params.num_samples.bits() * 2) as f32).log2() + 0.5) as u32;
            let sub_pixel_bits = std::cmp::max(
                1,
                if use_std_locations {
                    std_precision
                } else {
                    props.sample_location_sub_pixel_bits
                },
            );
            let offset = [
                pixel_size[0] / (1u32 << sub_pixel_bits) as f32,
                pixel_size[1] / (1u32 << sub_pixel_bits) as f32,
            ];

            // Surround with a roughly centered triangle
            let y1 = 0.5 * offset[1];
            let y2 = 0.35 * offset[1];
            let x1 = 0.5 * offset[0];

            let mut vertices: Vec<[f32; 4]> = Vec::new();
            for location in &locations {
                vertices.push([location[0], location[1] - y1, 0.0, 1.0]);
                vertices.push([location[0] - x1, location[1] + y2, 0.0, 1.0]);
                vertices.push([location[0] + x1, location[1] + y2, 0.0, 1.0]);
            }
            let buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;
            (buffer, vertices.len() as u32, 16u32, SAMPLE_DATA_STATIC_SIZE) // no per-sample data used
        }
        VerifyKind::Interpolation => {
            let vertices = gen_vertices_full_quad();
            let buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;
            let num_data_entries = (num_samples_per_pixel * render_size.0 * render_size.1) as usize;
            (
                buffer,
                vertices.len() as u32,
                32u32,
                SAMPLE_DATA_STATIC_SIZE + std::mem::size_of::<[f32; 2]>() * num_data_entries,
            )
        }
    };

    // createSampleDataBufferAndDescriptors
    let sample_data_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(sample_data_size as vk::DeviceSize, vk::BufferUsageFlags::STORAGE_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::FRAGMENT)
        .build(device)?;
    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
    let buffer_descriptor_info = vk::DescriptorBufferInfo {
        buffer: sample_data_buffer.get(),
        offset: 0,
        range: sample_data_size as vk::DeviceSize,
    };
    DescriptorSetUpdateBuilder::new()
        .write_single(
            descriptor_set.get(),
            Location::binding(0),
            vk::DescriptorType::STORAGE_BUFFER,
            &buffer_descriptor_info,
        )
        .update(device);

    {
        let base = sample_data_buffer.get_allocation().get_host_ptr();
        let header = [
            render_size.0,
            render_size.1,
            pixel_grid.grid_size.0,
            pixel_grid.grid_size.1,
            num_samples_per_pixel,
        ];
        for (index, value) in header.into_iter().enumerate() {
            unsafe {
                base.add(index * std::mem::size_of::<u32>())
                    .cast::<u32>()
                    .write_unaligned(value)
            };
        }
        if kind == VerifyKind::Interpolation {
            // Fill SSBO with interpolated values (here: from -1.0 to 1.0 across the render area in both x and y)
            for (index, location) in locations.iter().enumerate() {
                let entry = unsafe {
                    base.add(SAMPLE_DATA_STATIC_SIZE + index * std::mem::size_of::<[f32; 2]>())
                        .cast::<f32>()
                };
                unsafe {
                    entry.write_unaligned(location[0]);
                    entry.add(1).write_unaligned(location[1]);
                }
            }
        }
        flush_alloc(device, sample_data_buffer.get_allocation())?;
    }

    // drawSinglePass: sample locations are taken from the pixel grid
    let render_pass = make_verify_render_pass(device, params.num_samples, msaa)?;
    let framebuffer = make_framebuffer(
        device,
        *render_pass,
        &[*color_view, *resolve_view],
        render_size.0,
        render_size.1,
        1,
    )?;
    let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
    let binaries = context.get_binary_collection();
    let vert_module = create_shader_module(device, binaries.get("vert")?)?;
    let frag_module = create_shader_module(device, binaries.get("frag")?)?;

    let use_dynamic_state_sample_locations = params.options & TEST_OPTION_DYNAMIC_STATE_BIT != 0;
    let sample_locations_info = pixel_grid.locations_info();

    let mut state =
        DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST).with_full_viewport(render_size.0, render_size.1);
    state.bindings = vec![vk::VertexInputBindingDescription {
        binding: 0,
        stride: vertex_stride,
        input_rate: vk::VertexInputRate::VERTEX,
    }];
    state.attributes = vec![vk::VertexInputAttributeDescription {
        location: 0,
        binding: 0,
        format: vk::Format::R32G32B32A32_SFLOAT,
        offset: 0,
    }];
    if vertex_stride == 32 {
        state.attributes.push(vk::VertexInputAttributeDescription {
            location: 1,
            binding: 0,
            format: vk::Format::R32G32B32A32_SFLOAT,
            offset: 16,
        });
    }
    state.samples = params.num_samples;
    state.sample_shading = true;
    state.min_sample_shading = 1.0;
    if use_dynamic_state_sample_locations {
        state.dynamic_states = vec![vk::DynamicState::SAMPLE_LOCATIONS_EXT];
        state.sample_locations = Some((true, vk::SampleLocationsInfoEXT::default()));
    } else if !use_std_locations {
        state.sample_locations = Some((true, sample_locations_info));
    }
    let shader_objects = make_shader_objects(context, "vert", Some("frag"), &[*descriptor_set_layout], &[])?;
    let pipeline = if shader_objects.is_some() {
        None
    } else {
        Some(create_draw_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vert_module),
                (vk::ShaderStageFlags::FRAGMENT, *frag_module),
            ],
            &state,
        )?)
    };

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    begin_command_buffer(device, cmd)?;

    let clear_values = [
        clear_value_color(CLEAR_COLOR_0),
        vk::ClearValue {
            color: vk::ClearColorValue { float32: [0.0; 4] },
        },
    ];
    if let Some(objects) = &shader_objects {
        let color_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let to_attachment = [
            make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                color_image.get(),
                color_range,
            ),
            make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                resolve_image.get(),
                color_range,
            ),
        ];
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &to_attachment,
            );
        }
        let mut color_attachment = vk::RenderingAttachmentInfo::builder()
            .image_view(*color_view)
            .image_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .resolve_mode(vk::ResolveModeFlags::NONE)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::STORE)
            .clear_value(clear_values[0]);
        if msaa {
            color_attachment = color_attachment
                .resolve_mode(vk::ResolveModeFlags::AVERAGE)
                .resolve_image_view(*resolve_view)
                .resolve_image_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL);
        }
        let color_attachments = [color_attachment.build()];
        let rendering_info = vk::RenderingInfo::builder()
            .render_area(rect_2d(render_size.0, render_size.1))
            .layer_count(1)
            .view_mask(0)
            .color_attachments(&color_attachments);
        unsafe { device.cmd_begin_rendering(cmd, &rendering_info) };
        objects.bind(cmd, &state);
        unsafe {
            // Custom locations are given by the command, standard ones are left to the implementation.
            device.cmd_set_sample_locations_enable_ext(cmd, !use_std_locations);
            if !use_std_locations {
                device.cmd_set_sample_locations_ext(cmd, &sample_locations_info);
            }
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );
            device.cmd_draw(cmd, num_vertices, 1, 0, 0);
        }
        end_dynamic_rendering(device, cmd);
    } else if let Some(pipeline) = &pipeline {
        let post_subpass_sample_locations = [vk::SubpassSampleLocationsEXT {
            subpass_index: 0,
            sample_locations_info,
        }];
        let mut sample_locations_begin_info = vk::RenderPassSampleLocationsBeginInfoEXT::builder()
            .post_subpass_sample_locations(&post_subpass_sample_locations);
        let mut begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(rect_2d(render_size.0, render_size.1))
            .clear_values(&clear_values);
        if !use_std_locations {
            begin_info = begin_info.push_next(&mut sample_locations_begin_info);
        }
        unsafe {
            device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);

            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, **pipeline);

            if use_dynamic_state_sample_locations {
                device.cmd_set_sample_locations_ext(cmd, &sample_locations_info);
            }

            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );
            device.cmd_draw(cmd, num_vertices, 1, 0, 0);
            device.cmd_end_render_pass(cmd);
        }
    }

    // Color/Resolve image -> host buffer
    let source_image = if msaa { resolve_image.get() } else { color_image.get() };
    copy_image_to_buffer(
        device,
        cmd,
        source_image,
        color_buffer.get(),
        render_size.0,
        render_size.1,
    );

    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

    invalidate_alloc(device, color_buffer.get_allocation())?;

    // Verify: unorm/int compare, very low threshold as we are expecting near-exact values
    let pixels =
        unsafe { std::slice::from_raw_parts(color_buffer.get_allocation().get_host_ptr(), color_buffer_size as usize) };
    let green = [0u8, 255, 0, 255];
    Ok(pixels.chunks_exact(4).all(|pixel| {
        pixel
            .iter()
            .zip(green)
            .all(|(&value, expected)| value.abs_diff(expected) <= 2)
    }))
}

/// `TestBase::iterate`, over every grid size in turn
fn iterate_verify<'a>(context: &'a Context<'a>, params: &VerifyParams, kind: VerifyKind) -> TestOutcome {
    let use_std_locations = params.use_std_locations();
    let props = if use_std_locations {
        vk::PhysicalDeviceSampleLocationsPropertiesEXT::default()
    } else {
        get_sample_locations_properties(context)
    };

    // Generate grid size combinations
    let mut grid_sizes = Vec::new();
    if use_std_locations {
        grid_sizes.push((1u32, 1u32));
    } else {
        let mut multisample_properties = vk::MultisamplePropertiesEXT::default();
        unsafe {
            context.get_instance().get_physical_device_multisample_properties_ext(
                context.get_physical_device(),
                params.num_samples,
                &mut multisample_properties,
            )
        };

        let mut y = multisample_properties.max_sample_location_grid_size.height;
        while y >= 1 {
            let mut x = multisample_properties.max_sample_location_grid_size.width;
            while x >= 1 {
                grid_sizes.push((x, y));
                x >>= 1;
            }
            y >>= 1;
        }
    }

    if grid_sizes.is_empty() {
        return Err(TestError::Fail("maxSampleLocationGridSize is invalid".to_string()));
    }

    for grid_size in grid_sizes {
        if !test_pixel_grid(context, params, &props, kind, grid_size)? {
            return Err(TestError::Fail("Fail".to_string()));
        }
    }

    Ok(TestStatus::pass("Pass"))
}

/// `addInstanceTestCaseWithPrograms<VerifyLocationTest / VerifyInterpolationTest>`
struct VerifyCase {
    name: String,
    params: VerifyParams,
    kind: VerifyKind,
}

impl TestCase for VerifyCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkSupportVerifyTests` (and `checkSupportVerifyTestsPrimID` for the location cases)
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        // Some tests use gl_PrimitiveID from the fragment shader, which requires the Geometry capability.
        if self.kind == VerifyKind::Location && context.get_device_features().geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "Requires VkPhysicalDeviceFeatures::geometryShader".to_string(),
            ));
        }

        let use_std_locations = self.params.use_std_locations();
        if use_std_locations {
            if context.get_device_properties().limits.standard_sample_locations == vk::FALSE {
                return Err(TestError::NotSupported(
                    "standardSampleLocations not supported".to_string(),
                ));
            }
        } else {
            check_sample_locations_ext(context)?;
        }

        if context.get_device_features().sample_rate_shading == vk::FALSE {
            return Err(TestError::NotSupported(
                "Requires VkPhysicalDeviceFeatures::sampleRateShading".to_string(),
            ));
        }

        if !context
            .get_device_properties()
            .limits
            .framebuffer_color_sample_counts
            .contains(self.params.num_samples)
        {
            return Err(TestError::NotSupported(
                "framebufferColorSampleCounts: sample count not supported".to_string(),
            ));
        }

        if !use_std_locations
            && !get_sample_locations_properties(context)
                .sample_location_sample_counts
                .contains(self.params.num_samples)
        {
            return Err(TestError::NotSupported(
                "VkPhysicalDeviceSampleLocationsPropertiesEXT: sample count not supported".to_string(),
            ));
        }

        if self.params.options & TEST_OPTION_VARIABLE_SAMPLE_LOCATIONS_BIT != 0
            && get_sample_locations_properties(context).variable_sample_locations == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "VkPhysicalDeviceSampleLocationsPropertiesEXT: variableSampleLocations not supported".to_string(),
            ));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match self.kind {
            VerifyKind::Location => SAMPLE_LOCATIONS_VERIFY_LOCATION.programs,
            VerifyKind::Interpolation => SAMPLE_LOCATIONS_VERIFY_INTERPOLATION.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(VerifyInstance {
            context,
            params: self.params,
            kind: self.kind,
        })
    }
}

struct VerifyInstance<'a> {
    context: &'a Context<'a>,
    params: VerifyParams,
    kind: VerifyKind,
}

impl TestInstance for VerifyInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        iterate_verify(self.context, &self.params, self.kind)
    }
}

/// `VerifySamples::addCases`
fn add_verify_cases(
    group: &mut TestCaseGroup,
    num_samples: vk::SampleCountFlags,
    use_std_locations: bool,
    kind: VerifyKind,
) {
    let mut base_flags = 0u32;
    if use_std_locations {
        base_flags |= TEST_OPTION_STD_SAMPLE_LOCATIONS_BIT;
    }

    let mut test_opts: Vec<(&str, u32)> = Vec::new();
    if !use_std_locations {
        test_opts.push(("", base_flags | TEST_OPTION_VARIABLE_SAMPLE_LOCATIONS_BIT));
    }
    test_opts.push(("_invariable", base_flags));

    for (suffix, flags) in test_opts {
        let mut params = VerifyParams {
            num_samples,
            options: flags,
        };
        let samples_name = samples_string(num_samples);

        add_case(
            group,
            VerifyCase {
                name: format!("{samples_name}{suffix}"),
                params,
                kind,
            },
        );

        if !use_std_locations {
            params.options |= TEST_OPTION_DYNAMIC_STATE_BIT;
            add_case(
                group,
                VerifyCase {
                    name: format!("{samples_name}_dynamic{suffix}"),
                    params,
                    kind,
                },
            );

            // This is redundant for single-sampled.
            if num_samples != vk::SampleCountFlags::_1 {
                params.options |= TEST_OPTION_CLOSELY_PACKED_BIT;
                add_case(
                    group,
                    VerifyCase {
                        name: format!("{samples_name}_packed{suffix}"),
                        params,
                        kind,
                    },
                );
            }
        }
    }
}

/// `createMultisampleSampleLocationsTests` for the monolithic construction type, without fragment shading rate.
fn create_multisample_sample_locations_tests(
    use_std_locations: bool,
    with_queries: bool,
    with_draw: bool,
) -> TestCaseGroup {
    let mut root_group = TestCaseGroup::new(if use_std_locations {
        "std_sample_locations"
    } else {
        "sample_locations_ext"
    });

    // Queries
    if !use_std_locations && with_queries {
        let mut group = TestCaseGroup::new("query");
        add_function_case(
            &mut group,
            "sample_locations_properties",
            check_sample_locations_ext,
            test_query_sample_location_properties,
        );
        add_function_case(
            &mut group,
            "multisample_properties",
            check_sample_locations_ext,
            test_query_multisample_properties,
        );
        root_group.add_child(group);
    }

    // Verify custom sample locations and interpolation
    let mut group_location = TestCaseGroup::new("verify_location");
    let mut group_interpolation = TestCaseGroup::new("verify_interpolation");
    for num_samples in VERIFY_SAMPLE_COUNTS {
        add_verify_cases(
            &mut group_location,
            num_samples,
            use_std_locations,
            VerifyKind::Location,
        );
        add_verify_cases(
            &mut group_interpolation,
            num_samples,
            use_std_locations,
            VerifyKind::Interpolation,
        );
    }
    root_group.add_child(group_location);
    root_group.add_child(group_interpolation);
    if with_draw {
        root_group.add_child(super::sample_locations_draw_tests::create_draw_group(use_std_locations));
    }

    root_group
}

/// The `sample_locations_ext` and `std_sample_locations` children of upstream's `multisample` group.
pub fn add_sample_locations_tests(multisample_tests: &mut TestCaseGroup) {
    multisample_tests.add_child(create_multisample_sample_locations_tests(false, true, true));
    multisample_tests.add_child(create_multisample_sample_locations_tests(true, true, true));
}

/// The same two groups of the fragment shading rate repetition, which has no `query` cases.
pub fn add_sample_locations_tests_without_queries(multisample_tests: &mut TestCaseGroup) {
    multisample_tests.add_child(create_multisample_sample_locations_tests(false, false, true));
    multisample_tests.add_child(create_multisample_sample_locations_tests(true, false, true));
}

/// The two groups of the shader object types, with the `verify_*` cases only (no queries, and the `draw` cases use render pass sample
/// locations).
pub fn add_sample_locations_tests_shader_object(multisample_tests: &mut TestCaseGroup) {
    multisample_tests.add_child(create_multisample_sample_locations_tests(false, false, false));
    multisample_tests.add_child(create_multisample_sample_locations_tests(true, false, false));
}
