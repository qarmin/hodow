// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineImage2DViewOf3DTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2022 The Khronos Group Inc.
// Copyright (c) 2022 Google LLC.
// Copyright (c) 2023 LunarG, Inc.
// Copyright (c) 2023 Nintendo
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Monolithic pipelines only. The shaders depend on the image access type, the stage
// and the width of the tested mip level, so the manifest holds one program set per combination and `programs()` looks it up. The
// sparse variants bind memory on the universal queue instead of a dedicated sparse queue.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::generated::shaders::pipeline_image_2d_view_of_3d::ALL_IMAGE_VIEW_PROGRAMS;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_framebuffer, make_pipeline_layout,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline, rect_2d};
use crate::vkt::tests::pipeline::shader_object_draw::{begin_draw, end_draw, make_shader_objects};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const IMAGE_DIMENSION: u32 = 64;
const MIP_LEVEL_COUNT: u32 = 3;
const FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;

/// The `rust_type` of the manifest entries.
#[derive(Clone, Copy)]
pub struct ImageViewPrograms {
    pub name: &'static str,
    pub image_type: &'static str,
    pub stage: &'static str,
    pub size: u32,
    pub programs: BinaryCollection,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum ImageAccessType {
    StorageImage,
    Sampler,
    CombinedImageSampler,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum TestType {
    Compute,
    Fragment,
}

/// `TestParameters`; the image size, the format and the construction type are the constants above.
#[derive(Clone, Copy)]
struct TestParameters {
    mip_level: u32,
    layer_ndx: i32,
    image_type: ImageAccessType,
    test_type: TestType,
    sparse: bool,
}

impl TestParameters {
    fn use_sampler(&self) -> bool {
        self.image_type != ImageAccessType::StorageImage
    }

    fn mip_level_size(&self) -> (u32, u32, u32) {
        let dim = compute_mip_level_dimension(IMAGE_DIMENSION, self.mip_level);
        (dim, dim, dim)
    }
}

/// `computeMipLevelDimension`
fn compute_mip_level_dimension(base_level_dimension: u32, mip_level: u32) -> u32 {
    (base_level_dimension >> mip_level).max(1)
}

/// `fillImage` for an RGBA8 image: a chess pattern on `layer`, white everywhere else.
fn fill_image(size: (u32, u32, u32), layer: u32) -> Vec<u8> {
    let (width, height, depth) = size;
    let mut data = Vec::with_capacity((width * height * depth * 4) as usize);
    for z in 0..depth {
        for y in 0..height {
            for x in 0..width {
                if z == layer {
                    let c = (((x + y) & 1) * 255) as u8;
                    data.extend_from_slice(&[c, c, c, 255]);
                } else {
                    data.extend_from_slice(&[255, 255, 255, 255]);
                }
            }
        }
    }
    data
}

fn pipeline_image_memory_barrier(
    device: &Device,
    cmd: vk::CommandBuffer,
    src_stage: vk::PipelineStageFlags,
    dst_stage: vk::PipelineStageFlags,
    barrier: vk::ImageMemoryBarrier,
) {
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            src_stage,
            dst_stage,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[barrier],
        );
    }
}

/// `copyImageLayerToBuffer`
#[allow(clippy::too_many_arguments)]
fn copy_image_layer_to_buffer(
    device: &Device,
    cmd: vk::CommandBuffer,
    image: vk::Image,
    buffer: vk::Buffer,
    size: (u32, u32),
    src_access_mask: vk::AccessFlags,
    old_layout: vk::ImageLayout,
    layer_to_copy: u32,
    mip_level: u32,
) {
    let subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, mip_level, 1, 0, 1);
    let image_barrier = vk::ImageMemoryBarrier {
        s_type: vk::StructureType::IMAGE_MEMORY_BARRIER,
        next: std::ptr::null(),
        src_access_mask,
        dst_access_mask: vk::AccessFlags::TRANSFER_READ,
        old_layout,
        new_layout: vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        src_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
        dst_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
        image,
        subresource_range,
    };
    pipeline_image_memory_barrier(
        device,
        cmd,
        vk::PipelineStageFlags::ALL_COMMANDS,
        vk::PipelineStageFlags::TRANSFER,
        image_barrier,
    );

    let region = vk::BufferImageCopy {
        buffer_offset: 0,
        buffer_row_length: 0,
        buffer_image_height: 0,
        image_subresource: make_image_subresource_layers(subresource_range.aspect_mask, mip_level, 0, 1),
        image_offset: vk::Offset3D {
            x: 0,
            y: 0,
            z: layer_to_copy as i32,
        },
        image_extent: vk::Extent3D {
            width: size.0,
            height: size.1,
            depth: 1,
        },
    };
    unsafe { device.cmd_copy_image_to_buffer(cmd, image, vk::ImageLayout::TRANSFER_SRC_OPTIMAL, buffer, &[region]) };

    let buffer_barrier = vk::BufferMemoryBarrier {
        s_type: vk::StructureType::BUFFER_MEMORY_BARRIER,
        next: std::ptr::null(),
        src_access_mask: vk::AccessFlags::TRANSFER_WRITE,
        dst_access_mask: vk::AccessFlags::HOST_READ,
        src_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
        dst_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
        buffer,
        offset: 0,
        size: vk::WHOLE_SIZE,
    };
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[buffer_barrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
}

/// `commonSubmission`; with a semaphore the submission waits on it at the transfer stage.
fn common_submission(
    device: &Device,
    queue: vk::Queue,
    cmd: vk::CommandBuffer,
    sparse_image_semaphore: Option<vk::Semaphore>,
) -> Result<(), TestError> {
    let Some(semaphore) = sparse_image_semaphore else {
        return submit_commands_and_wait(device, queue, cmd);
    };

    let fence = Unique::new(
        device,
        unsafe { device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?,
    );
    let wait_semaphores = [semaphore];
    let wait_stages = [vk::PipelineStageFlags::TRANSFER];
    let cmd_buffers = [cmd];
    let submit_info = vk::SubmitInfo::builder()
        .wait_semaphores(&wait_semaphores)
        .wait_dst_stage_mask(&wait_stages)
        .command_buffers(&cmd_buffers);
    unsafe { device.queue_submit(queue, &[submit_info], *fence) }.vk_check("vkQueueSubmit")?;
    unsafe { device.wait_for_fences(&[*fence], true, u64::MAX) }.vk_check("vkWaitForFences")?;
    Ok(())
}

fn create_compute_pipeline<'a>(
    device: &'a Device,
    layout: vk::PipelineLayout,
    module: vk::ShaderModule,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let stage = vk::PipelineShaderStageCreateInfo::builder()
        .stage(vk::ShaderStageFlags::COMPUTE)
        .module(module)
        .name(b"main\0")
        .build();
    let info = vk::ComputePipelineCreateInfo::builder()
        .stage(stage)
        .layout(layout)
        .base_pipeline_index(-1)
        .build();
    let pipelines = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[info], None) }
        .vk_check("vkCreateComputePipelines")?;
    Ok(Unique::new(device, pipelines.0[0]))
}

/// `Image2DView3DImageTest::checkSupport`, shared by the compute and the fragment variant.
fn check_common_support(context: &Context<'_>, params: &TestParameters) -> Result<(), TestError> {
    context.require_device_functionality("VK_EXT_image_2d_view_of_3d")?;

    let mut view_features = vk::PhysicalDeviceImage2DViewOf3DFeaturesEXT::default();
    let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut view_features);
    unsafe {
        context
            .get_instance()
            .get_physical_device_features2(context.get_physical_device(), &mut features2)
    };

    if view_features.image_2d_view_of_3d == vk::FALSE {
        return Err(TestError::NotSupported("image2DViewOf3D not supported.".to_string()));
    }
    if params.use_sampler() && view_features.sampler_2d_view_of_3d == vk::FALSE {
        return Err(TestError::NotSupported("sampler2DViewOf3D not supported.".to_string()));
    }
    Ok(())
}

fn check_sparse_support(context: &Context<'_>, params: &TestParameters) -> Result<(), TestError> {
    if !params.sparse {
        return Ok(());
    }

    if context.get_device_features().sparse_binding == vk::FALSE {
        return Err(TestError::NotSupported("sparseBinding not supported".to_string()));
    }
    context.require_device_functionality("VK_KHR_maintenance9")?;

    let mut maintenance9 = vk::PhysicalDeviceMaintenance9PropertiesKHR::default();
    let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut maintenance9);
    unsafe {
        context
            .get_instance()
            .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
    };
    if maintenance9.image_2d_view_of_3d_sparse == vk::FALSE {
        return Err(TestError::NotSupported(
            "image2DViewOf3DSparse not supported".to_string(),
        ));
    }
    Ok(())
}

/// `ComputeImage2DView3DImageTest` and `FragmentImage2DView3DImageTest`
struct Image2DView3DImageTest {
    name: String,
    params: TestParameters,
}

impl TestCase for Image2DView3DImageTest {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_common_support(context, &self.params)?;

        if self.params.test_type == TestType::Fragment
            && context.get_device_features().fragment_stores_and_atomics == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "fragmentStoresAndAtomics not supported".to_string(),
            ));
        }

        check_sparse_support(context, &self.params)
    }

    fn programs(&self) -> BinaryCollection {
        let params = &self.params;
        let image_type = match params.image_type {
            ImageAccessType::StorageImage => "storage",
            ImageAccessType::Sampler => "sampler",
            ImageAccessType::CombinedImageSampler => "combined_image_sampler",
        };
        let stage = if params.test_type == TestType::Compute {
            "comp"
        } else {
            "frag"
        };
        let size = if params.use_sampler() {
            params.mip_level_size().0
        } else {
            0
        };
        ALL_IMAGE_VIEW_PROGRAMS
            .iter()
            .find(|p| p.image_type == image_type && p.stage == stage && p.size == size)
            .map_or_else(|| BinaryCollection::new(&[]), |p| p.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(Image2DView3DImageInstance {
            context,
            params: self.params,
        })
    }
}

struct Image2DView3DImageInstance<'a> {
    context: &'a Context<'a>,
    params: TestParameters,
}

impl<'a> Image2DView3DImageInstance<'a> {
    /// `runComputePipeline`
    #[allow(clippy::too_many_arguments)]
    fn run_compute_pipeline(
        &self,
        descriptor_set: vk::DescriptorSet,
        descriptor_set_layout: vk::DescriptorSetLayout,
        test_mip_level_size: (u32, u32, u32),
        cmd: vk::CommandBuffer,
        image: vk::Image,
        output_buffer: vk::Buffer,
        sparse_image_semaphore: Option<vk::Semaphore>,
    ) -> Result<(), TestError> {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let use_sampler = self.params.use_sampler();

        let binaries = context.get_binary_collection();
        let shader_module = create_shader_module(device, binaries.get("comp")?)?;
        let pipeline_layout = make_pipeline_layout(device, &[descriptor_set_layout])?;
        let pipeline = create_compute_pipeline(device, *pipeline_layout, *shader_module)?;

        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, pipeline.get());
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::COMPUTE,
                *pipeline_layout,
                0,
                &[descriptor_set],
                &[] as &[u32],
            );
            device.cmd_dispatch(cmd, test_mip_level_size.0, test_mip_level_size.1, 1);
        }

        // Copy the result image to a buffer.
        copy_image_layer_to_buffer(
            device,
            cmd,
            image,
            output_buffer,
            (test_mip_level_size.0, test_mip_level_size.1),
            vk::AccessFlags::SHADER_WRITE,
            vk::ImageLayout::GENERAL,
            if use_sampler { 0 } else { self.params.layer_ndx as u32 },
            if use_sampler { 0 } else { self.params.mip_level },
        );

        end_command_buffer(device, cmd)?;

        // Wait for completion.
        common_submission(device, queue, cmd, sparse_image_semaphore)
    }

    /// `runGraphicsPipeline`
    #[allow(clippy::too_many_arguments)]
    fn run_graphics_pipeline(
        &self,
        descriptor_set: vk::DescriptorSet,
        descriptor_set_layout: vk::DescriptorSetLayout,
        test_mip_level_size: (u32, u32, u32),
        cmd: vk::CommandBuffer,
        image: vk::Image,
        output_buffer: vk::Buffer,
        sparse_image_semaphore: Option<vk::Semaphore>,
    ) -> Result<(), TestError> {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let use_sampler = self.params.use_sampler();

        let binaries = context.get_binary_collection();
        let vert_shader = create_shader_module(device, binaries.get("vert")?)?;
        let frag_shader = create_shader_module(device, binaries.get("frag")?)?;
        let pipeline_layout = make_pipeline_layout(device, &[descriptor_set_layout])?;

        // A render pass without attachments: the shaders only store to the image.
        let subpasses = [vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .build()];
        let render_pass_info = vk::RenderPassCreateInfo::builder().subpasses(&subpasses);
        let render_pass = Unique::new(
            device,
            unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
        );

        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_FAN)
            .with_position_input()
            .with_full_viewport(IMAGE_DIMENSION, IMAGE_DIMENSION);
        state.color_attachment_count = 0;
        let shader_objects = make_shader_objects(context, "vert", Some("frag"), &[descriptor_set_layout], &[])?;
        let pipeline = if shader_objects.is_some() {
            None
        } else {
            Some(create_draw_pipeline(
                device,
                *pipeline_layout,
                *render_pass,
                &[
                    (vk::ShaderStageFlags::VERTEX, *vert_shader),
                    (vk::ShaderStageFlags::FRAGMENT, *frag_shader),
                ],
                &state,
            )?)
        };

        let framebuffer = make_framebuffer(
            device,
            *render_pass,
            &[],
            test_mip_level_size.0,
            test_mip_level_size.1,
            1,
        )?;

        // Create vertex buffer and fill it with full screen quad.
        let vertex_data: [[f32; 4]; 4] = [
            [-1.0, -1.0, 1.0, 1.0],
            [1.0, -1.0, 1.0, 1.0],
            [1.0, 1.0, 1.0, 1.0],
            [-1.0, 1.0, 1.0, 1.0],
        ];
        let vertex_buffer = create_host_buffer(context, &vertex_data, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        unsafe {
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[descriptor_set],
                &[] as &[u32],
            );
        }

        begin_draw(
            device,
            cmd,
            shader_objects.as_ref(),
            &state,
            pipeline.as_ref().map(|pipeline| pipeline.get()),
            *render_pass,
            *framebuffer,
            rect_2d(test_mip_level_size.0, test_mip_level_size.1),
            &[],
            &[],
        );
        unsafe { device.cmd_draw(cmd, 4, 1, 0, 0) };
        end_draw(device, cmd, shader_objects.is_some());

        // Copy the result image to a buffer.
        copy_image_layer_to_buffer(
            device,
            cmd,
            image,
            output_buffer,
            (test_mip_level_size.0, test_mip_level_size.1),
            vk::AccessFlags::SHADER_WRITE,
            vk::ImageLayout::GENERAL,
            if use_sampler { 0 } else { self.params.layer_ndx as u32 },
            if use_sampler { 0 } else { self.params.mip_level },
        );

        end_command_buffer(device, cmd)?;

        // Wait for completion.
        common_submission(device, queue, cmd, sparse_image_semaphore)
    }

    /// `makeSparseMemoryBinding` for every `alignment` sized piece of the image, followed by the bind itself.
    /// Returns the memory that has to outlive the image and the semaphore the bind signals.
    fn bind_sparse_image(
        &self,
        test_image: vk::Image,
    ) -> Result<(Vec<Unique<'a, vk::DeviceMemory>>, Unique<'a, vk::Semaphore>), TestError> {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();

        let image_memory_reqs = unsafe { device.get_image_memory_requirements(test_image) };

        if image_memory_reqs.size > context.get_device_properties().limits.sparse_address_space_size {
            return Err(TestError::NotSupported(
                "Required memory size for sparse resource exceeds device limits".to_string(),
            ));
        }

        let memory_properties = unsafe {
            context
                .get_instance()
                .get_physical_device_memory_properties(context.get_physical_device())
        };
        let Some(memory_type) =
            (0..memory_properties.memory_type_count).find(|&idx| image_memory_reqs.memory_type_bits & (1 << idx) != 0)
        else {
            return Err(TestError::Fail(
                "Required memory type for sparse resouce not found".to_string(),
            ));
        };

        let num_sparse_bindings = (image_memory_reqs.size / image_memory_reqs.alignment) as u32;
        let mut device_memory = Vec::new();
        let mut sparse_memory_bindings = Vec::new();
        for binding_idx in 0..num_sparse_bindings {
            let alloc_info = vk::MemoryAllocateInfo::builder()
                .allocation_size(image_memory_reqs.alignment)
                .memory_type_index(memory_type);
            let memory = unsafe { device.allocate_memory(&alloc_info, None) }.vk_check("vkAllocateMemory")?;
            device_memory.push(Unique::new(device, memory));

            sparse_memory_bindings.push(vk::SparseMemoryBind {
                resource_offset: image_memory_reqs.alignment * binding_idx as vk::DeviceSize,
                size: image_memory_reqs.alignment,
                memory,
                memory_offset: 0,
                flags: vk::SparseMemoryBindFlags::empty(),
            });
        }

        let opaque_binding_info = [vk::SparseImageOpaqueMemoryBindInfo::builder()
            .image(test_image)
            .binds(&sparse_memory_bindings)
            .build()];

        let semaphore = Unique::new(
            device,
            unsafe { device.create_semaphore(&vk::SemaphoreCreateInfo::builder(), None) }
                .vk_check("vkCreateSemaphore")?,
        );
        let signal_semaphores = [*semaphore];
        let bind_sparse_info = vk::BindSparseInfo::builder()
            .image_opaque_binds(&opaque_binding_info)
            .signal_semaphores(&signal_semaphores);

        unsafe { device.queue_bind_sparse(queue, &[bind_sparse_info], vk::Fence::null()) }
            .vk_check("vkQueueBindSparse")?;

        Ok((device_memory, semaphore))
    }

    fn run(&self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let params = &self.params;
        let queue_family_index = context.get_universal_queue_family_index();
        let use_sampler = params.use_sampler();
        let use_sparse_binding = params.sparse;
        let image_size = (IMAGE_DIMENSION, IMAGE_DIMENSION, IMAGE_DIMENSION);

        let test_mip_level_size = params.mip_level_size();
        let buffer_size = (test_mip_level_size.0 * test_mip_level_size.1 * test_mip_level_size.2 * 4) as vk::DeviceSize;
        let output_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Input image is used with sampler cases only. Initialize the input image's mip level and fill the target layer with a
        // chess pattern, others will be white.
        let input_image_buffer = if use_sampler {
            let input_data = fill_image(test_mip_level_size, params.layer_ndx as u32);
            Some(create_host_buffer(
                context,
                &input_data,
                vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST,
            )?)
        } else {
            None
        };

        let mut flags = vk::ImageCreateFlags::_2D_VIEW_COMPATIBLE_EXT;
        if use_sparse_binding {
            flags |= vk::ImageCreateFlags::SPARSE_BINDING;
        }

        // Create the test image: sampled image or storage image, depending on the test type.
        let usage = vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST
            | if use_sampler {
                vk::ImageUsageFlags::SAMPLED
            } else {
                vk::ImageUsageFlags::STORAGE
            };
        let image_create_info = vk::ImageCreateInfo::builder()
            .flags(flags)
            .image_type(vk::ImageType::_3D)
            .format(FORMAT)
            .extent(vk::Extent3D {
                width: image_size.0,
                height: image_size.1,
                depth: image_size.2,
            })
            .mip_levels(MIP_LEVEL_COUNT)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(usage)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();

        // A normal image gets its memory now, a sparse one is bound later.
        let normal_image = if use_sparse_binding {
            None
        } else {
            Some(ImageWithMemory::new(
                device,
                context.get_default_allocator(),
                image_create_info,
                MemoryRequirement::ANY,
            )?)
        };
        let sparse_image = if use_sparse_binding {
            Some(Unique::new(
                device,
                unsafe { device.create_image(&image_create_info, None) }.vk_check("vkCreateImage")?,
            ))
        } else {
            None
        };
        let test_image = match (&normal_image, &sparse_image) {
            (Some(image), _) => image.get(),
            (None, Some(image)) => image.get(),
            (None, None) => unreachable!(),
        };

        let sparse_binding = if use_sparse_binding {
            Some(self.bind_sparse_image(test_image)?)
        } else {
            None
        };
        let sparse_image_semaphore = sparse_binding.as_ref().map(|(_, semaphore)| semaphore.get());

        // Make an image view covering one of the mip levels.
        let view_subresource_range = make_image_subresource_range(
            vk::ImageAspectFlags::COLOR,
            params.mip_level,
            1,
            params.layer_ndx as u32,
            1,
        );
        let image_view = make_image_view(
            device,
            test_image,
            vk::ImageViewType::_2D,
            FORMAT,
            view_subresource_range,
        )?;

        // resultImage is used in sampler / combined image sampler tests to verify the sampled image.
        let result_img_subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let (result_image, result_image_view, sampler) = if use_sampler {
            let result_image_create_info = vk::ImageCreateInfo::builder()
                .image_type(vk::ImageType::_2D)
                .format(FORMAT)
                .extent(vk::Extent3D {
                    width: test_mip_level_size.0,
                    height: test_mip_level_size.1,
                    depth: 1,
                })
                .mip_levels(1)
                .array_layers(1)
                .samples(vk::SampleCountFlags::_1)
                .tiling(vk::ImageTiling::OPTIMAL)
                .usage(
                    vk::ImageUsageFlags::STORAGE
                        | vk::ImageUsageFlags::TRANSFER_SRC
                        | vk::ImageUsageFlags::TRANSFER_DST,
                )
                .sharing_mode(vk::SharingMode::EXCLUSIVE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .build();
            let result_image = ImageWithMemory::new(
                device,
                context.get_default_allocator(),
                result_image_create_info,
                MemoryRequirement::ANY,
            )?;
            let result_image_view = make_image_view(
                device,
                result_image.get(),
                vk::ImageViewType::_2D,
                FORMAT,
                result_img_subresource_range,
            )?;

            let sampler_create_info = vk::SamplerCreateInfo::builder()
                .mag_filter(vk::Filter::NEAREST)
                .min_filter(vk::Filter::NEAREST)
                .mipmap_mode(vk::SamplerMipmapMode::NEAREST)
                .address_mode_u(vk::SamplerAddressMode::CLAMP_TO_EDGE)
                .address_mode_v(vk::SamplerAddressMode::CLAMP_TO_EDGE)
                .address_mode_w(vk::SamplerAddressMode::CLAMP_TO_EDGE)
                .mip_lod_bias(0.0)
                .anisotropy_enable(false)
                .max_anisotropy(1.0)
                .compare_enable(false)
                .compare_op(vk::CompareOp::ALWAYS)
                .min_lod(0.0)
                .max_lod(1.0)
                .border_color(vk::BorderColor::FLOAT_TRANSPARENT_BLACK)
                .unnormalized_coordinates(false);
            let sampler = Unique::new(
                device,
                unsafe { device.create_sampler(&sampler_create_info, None) }.vk_check("vkCreateSampler")?,
            );
            (Some(result_image), Some(result_image_view), Some(sampler))
        } else {
            (None, None, None)
        };

        // Create the descriptor set.
        let shader_stage = if params.test_type == TestType::Compute {
            vk::ShaderStageFlags::COMPUTE
        } else {
            vk::ShaderStageFlags::FRAGMENT
        };
        let pipeline_stage = if params.test_type == TestType::Compute {
            vk::PipelineStageFlags::COMPUTE_SHADER
        } else {
            vk::PipelineStageFlags::FRAGMENT_SHADER
        };
        let (set_layout_builder, pool_builder) = match params.image_type {
            ImageAccessType::StorageImage => (
                DescriptorSetLayoutBuilder::new().add_single_binding(vk::DescriptorType::STORAGE_IMAGE, shader_stage),
                DescriptorPoolBuilder::new().add_type(vk::DescriptorType::STORAGE_IMAGE, 1),
            ),
            ImageAccessType::Sampler => (
                DescriptorSetLayoutBuilder::new()
                    .add_single_binding(vk::DescriptorType::SAMPLED_IMAGE, shader_stage)
                    .add_single_binding(vk::DescriptorType::SAMPLER, shader_stage)
                    .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, shader_stage),
                DescriptorPoolBuilder::new()
                    .add_type(vk::DescriptorType::SAMPLED_IMAGE, 1)
                    .add_type(vk::DescriptorType::SAMPLER, 1)
                    .add_type(vk::DescriptorType::STORAGE_IMAGE, 1),
            ),
            ImageAccessType::CombinedImageSampler => (
                DescriptorSetLayoutBuilder::new()
                    .add_single_binding(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, shader_stage)
                    .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, shader_stage),
                DescriptorPoolBuilder::new()
                    .add_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, 1)
                    .add_type(vk::DescriptorType::STORAGE_IMAGE, 1),
            ),
        };

        // Prepare the command buffer.
        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        // Start recording commands.
        begin_command_buffer(device, cmd)?;

        let clear_color = vk::ClearColorValue {
            float32: [0.0, 0.0, 0.0, 1.0],
        };
        if let Some(result_image) = &result_image {
            // Clear the result image.
            let pre_image_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                result_image.get(),
                result_img_subresource_range,
            );
            pipeline_image_memory_barrier(
                device,
                cmd,
                vk::PipelineStageFlags::HOST,
                vk::PipelineStageFlags::TRANSFER,
                pre_image_barrier,
            );

            unsafe {
                device.cmd_clear_color_image(
                    cmd,
                    result_image.get(),
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &clear_color,
                    &[result_img_subresource_range],
                )
            };

            let post_image_barrier = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::SHADER_WRITE,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::GENERAL,
                result_image.get(),
                result_img_subresource_range,
            );
            pipeline_image_memory_barrier(
                device,
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                pipeline_stage,
                post_image_barrier,
            );
        } else {
            let single_mip_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
            let all_mips_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, MIP_LEVEL_COUNT, 0, 1);

            // Clear the test image.
            let pre_image_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                test_image,
                all_mips_srr,
            );
            pipeline_image_memory_barrier(
                device,
                cmd,
                vk::PipelineStageFlags::HOST,
                vk::PipelineStageFlags::TRANSFER,
                pre_image_barrier,
            );

            unsafe {
                device.cmd_clear_color_image(
                    cmd,
                    test_image,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &clear_color,
                    &[single_mip_srr],
                )
            };

            let post_image_barrier = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::SHADER_WRITE,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::GENERAL,
                test_image,
                all_mips_srr,
            );
            pipeline_image_memory_barrier(
                device,
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                pipeline_stage,
                post_image_barrier,
            );
        }

        if let Some(input_image_buffer) = &input_image_buffer {
            // `copyBufferToImage` with a GENERAL destination layout: copy the input image to the target mip level.
            let all_mips_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, MIP_LEVEL_COUNT, 0, 1);
            let pre_buffer_barrier = vk::BufferMemoryBarrier {
                s_type: vk::StructureType::BUFFER_MEMORY_BARRIER,
                next: std::ptr::null(),
                src_access_mask: vk::AccessFlags::HOST_WRITE,
                dst_access_mask: vk::AccessFlags::TRANSFER_READ,
                src_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
                dst_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
                buffer: input_image_buffer.get(),
                offset: 0,
                size: buffer_size,
            };
            let pre_image_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::GENERAL,
                test_image,
                all_mips_srr,
            );
            let post_image_barrier = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::SHADER_READ,
                vk::ImageLayout::GENERAL,
                vk::ImageLayout::GENERAL,
                test_image,
                all_mips_srr,
            );
            let copy_region = make_buffer_image_copy(
                vk::Extent3D {
                    width: test_mip_level_size.0,
                    height: test_mip_level_size.1,
                    depth: test_mip_level_size.2,
                },
                make_image_subresource_layers(vk::ImageAspectFlags::COLOR, params.mip_level, 0, 1),
            );
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::HOST,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[pre_buffer_barrier],
                    &[pre_image_barrier],
                );
                device.cmd_copy_buffer_to_image(
                    cmd,
                    input_image_buffer.get(),
                    test_image,
                    vk::ImageLayout::GENERAL,
                    &[copy_region],
                );
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    pipeline_stage,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[post_image_barrier],
                );
            }
        }

        let descriptor_set_layout = set_layout_builder.build(device)?;
        let descriptor_pool = pool_builder.build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
        let sampler_handle = sampler.as_ref().map_or_else(vk::Sampler::null, |s| s.get());
        let test_image_descriptor_info = [vk::DescriptorImageInfo::builder()
            .sampler(sampler_handle)
            .image_view(*image_view)
            .image_layout(vk::ImageLayout::GENERAL)
            .build()];

        // Write descriptor update.
        {
            let mut binding_idx = 0;
            let mut writes = Vec::new();
            match params.image_type {
                ImageAccessType::StorageImage => {
                    writes.push(
                        vk::WriteDescriptorSet::builder()
                            .dst_set(descriptor_set.get())
                            .dst_binding(0)
                            .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
                            .image_info(&test_image_descriptor_info)
                            .build(),
                    );
                }
                ImageAccessType::Sampler => {
                    writes.push(
                        vk::WriteDescriptorSet::builder()
                            .dst_set(descriptor_set.get())
                            .dst_binding(binding_idx)
                            .descriptor_type(vk::DescriptorType::SAMPLED_IMAGE)
                            .image_info(&test_image_descriptor_info)
                            .build(),
                    );
                    binding_idx += 1;
                    writes.push(
                        vk::WriteDescriptorSet::builder()
                            .dst_set(descriptor_set.get())
                            .dst_binding(binding_idx)
                            .descriptor_type(vk::DescriptorType::SAMPLER)
                            .image_info(&test_image_descriptor_info)
                            .build(),
                    );
                    binding_idx += 1;
                }
                ImageAccessType::CombinedImageSampler => {
                    writes.push(
                        vk::WriteDescriptorSet::builder()
                            .dst_set(descriptor_set.get())
                            .dst_binding(binding_idx)
                            .descriptor_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER)
                            .image_info(&test_image_descriptor_info)
                            .build(),
                    );
                    binding_idx += 1;
                }
            }

            let result_image_descriptor_info = result_image_view.as_ref().map(|view| {
                [vk::DescriptorImageInfo::builder()
                    .sampler(vk::Sampler::null())
                    .image_view(**view)
                    .image_layout(vk::ImageLayout::GENERAL)
                    .build()]
            });
            if let Some(info) = &result_image_descriptor_info {
                writes.push(
                    vk::WriteDescriptorSet::builder()
                        .dst_set(descriptor_set.get())
                        .dst_binding(binding_idx)
                        .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
                        .image_info(info)
                        .build(),
                );
            }

            unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };
        }

        let verify_image = match &result_image {
            Some(result_image) => result_image.get(),
            None => test_image,
        };
        if params.test_type == TestType::Compute {
            self.run_compute_pipeline(
                descriptor_set.get(),
                *descriptor_set_layout,
                test_mip_level_size,
                cmd,
                verify_image,
                output_buffer.get(),
                sparse_image_semaphore,
            )?;
        } else {
            self.run_graphics_pipeline(
                descriptor_set.get(),
                *descriptor_set_layout,
                test_mip_level_size,
                cmd,
                verify_image,
                output_buffer.get(),
                sparse_image_semaphore,
            )?;
        }

        // Validate the results. The reference image has always a depth of 1, because it is compared to the 2D result image (sampler
        // cases) or to a single layer of a 3D image.
        let reference_image = fill_image((test_mip_level_size.0, test_mip_level_size.1, 1), 0);

        let output_alloc = output_buffer.get_allocation();
        invalidate_alloc(device, output_alloc)?;
        let result = unsafe { std::slice::from_raw_parts(output_alloc.get_host_ptr(), reference_image.len()) };

        // `tcu::floatThresholdCompare` with 0.01 on UNORM8 channels: a difference of up to 2.55 steps.
        if result
            .iter()
            .zip(&reference_image)
            .any(|(&got, &want)| got.abs_diff(want) > 2)
        {
            return Ok(TestStatus::fail("Pixel comparison failed."));
        }

        // The sparse memory is only released after everything that used it has finished.
        drop(sparse_binding);
        Ok(TestStatus::pass("pass"))
    }
}

impl TestInstance for Image2DView3DImageInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        self.run()
    }
}

/// `createImage2DViewOf3DTests`
pub fn create_image_2d_view_of_3d_tests() -> TestCaseGroup {
    create_image_2d_view_of_3d_tests_for(false)
}

/// The shader object types leave out the compute group.
pub fn create_image_2d_view_of_3d_tests_for(shader_object: bool) -> TestCaseGroup {
    let mut image_tests = TestCaseGroup::new("image_2d_view_3d_image");

    let access_types = [
        (ImageAccessType::StorageImage, "storage"),
        (ImageAccessType::Sampler, "sampler"),
        (ImageAccessType::CombinedImageSampler, "combined_image_sampler"),
    ];

    let mut compute_group = TestCaseGroup::new("compute");
    let mut fragment_group = TestCaseGroup::new("fragment");

    for (image_type, access_name) in access_types {
        let mut compute_sub_group = TestCaseGroup::new(access_name);
        let mut fragment_sub_group = TestCaseGroup::new(access_name);
        for mip_level in [0u32, 2] {
            // Test the first and the last layer of the mip level.
            let layers = [0i32, compute_mip_level_dimension(IMAGE_DIMENSION, mip_level) as i32 - 1];
            for layer in layers {
                for sparse in [false, true] {
                    let test_name = format!("mip{mip_level}_layer{layer}{}", if sparse { "_sparse" } else { "" });
                    let mut params = TestParameters {
                        mip_level,
                        layer_ndx: layer,
                        image_type,
                        test_type: TestType::Fragment,
                        sparse,
                    };
                    fragment_sub_group.add_child(Box::new(Image2DView3DImageTest {
                        name: test_name.clone(),
                        params,
                    }) as Box<dyn TestCase>);

                    params.test_type = TestType::Compute;
                    compute_sub_group.add_child(Box::new(Image2DView3DImageTest {
                        name: test_name,
                        params,
                    }) as Box<dyn TestCase>);
                }
            }
        }
        compute_group.add_child(compute_sub_group);
        fragment_group.add_child(fragment_sub_group);
    }

    if !shader_object {
        image_tests.add_child(compute_group);
    }
    image_tests.add_child(fragment_group);
    image_tests
}
