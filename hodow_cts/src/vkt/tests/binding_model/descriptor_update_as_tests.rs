// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/binding_model/vktBindingDescriptorUpdateASTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The virtual functions of `BindingAcceleratioStructureTestInstance` are the `AsPipeline` trait, whose
// implementations hold what upstream's subclasses hold as members; the state the base class holds is `Shared`. The shaders are written out by
// `scripts/gen_descriptor_update_as_manifest.py`; the acceleration structures are `vk::accel_struct::DeferredAccelerationStructure`.

use std::ffi::c_void;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    DeviceV1_1, Handle, InstanceV1_1, KhrPushDescriptorExtensionDeviceCommands,
    KhrRayTracingPipelineExtensionDeviceCommands,
};

use crate::generated::shaders::binding_model_descriptor_update_as as g;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::accel_struct::DeferredAccelerationStructure;
use crate::vk::builder_util::DescriptorSetLayoutBuilder;
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, GraphicsPipelineStages, allocate_command_buffer, make_buffer_create_info, make_command_pool,
    make_descriptor_set, make_framebuffer, make_graphics_pipeline_staged, make_memory_barrier, make_pipeline_layout,
    make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ray_tracing_util::{RayTracingPipelineBuilder, create_shader_binding_table, shader_group_sizes};
use crate::vk::ref_util::{Unique, UniqueDescriptorSet};
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const TEST_WIDTH: u32 = 16;
const TEST_HEIGHT: u32 = 16;
const FIXED_POINT_DIVISOR: u32 = 1024 * 1024;
const PLAIN_Z0: f32 = 2.0;
const PLAIN_Z1: f32 = 4.0;
const NO_GROUP: u32 = u32::MAX;

fn all_ray_tracing_stages() -> vk::ShaderStageFlags {
    vk::ShaderStageFlags::RAYGEN_KHR
        | vk::ShaderStageFlags::ANY_HIT_KHR
        | vk::ShaderStageFlags::CLOSEST_HIT_KHR
        | vk::ShaderStageFlags::MISS_KHR
        | vk::ShaderStageFlags::INTERSECTION_KHR
        | vk::ShaderStageFlags::CALLABLE_KHR
}

fn hit_stages() -> vk::ShaderStageFlags {
    vk::ShaderStageFlags::ANY_HIT_KHR | vk::ShaderStageFlags::CLOSEST_HIT_KHR | vk::ShaderStageFlags::INTERSECTION_KHR
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum TestType {
    UsingRayQuery,
    UsingRayTracing,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum UpdateMethod {
    Normal,
    WithTemplate,
    WithPush,
    WithPushTemplate,
}

#[derive(Clone, Copy)]
struct TestParams {
    width: u32,
    height: u32,
    depth: u32,
    test_type: TestType,
    update_method: UpdateMethod,
    stage: vk::ShaderStageFlags,
    format: vk::Format,
    programs: BinaryCollection,
}

fn is_push_update_method(update_method: UpdateMethod) -> bool {
    matches!(update_method, UpdateMethod::WithPush | UpdateMethod::WithPushTemplate)
}

fn is_template_update_method(update_method: UpdateMethod) -> bool {
    matches!(
        update_method,
        UpdateMethod::WithTemplate | UpdateMethod::WithPushTemplate
    )
}

fn make_image_create_info(
    format: vk::Format,
    width: u32,
    height: u32,
    depth: u32,
    image_type: vk::ImageType,
    usage: vk::ImageUsageFlags,
) -> vk::ImageCreateInfo {
    vk::ImageCreateInfo {
        s_type: vk::StructureType::IMAGE_CREATE_INFO,
        next: std::ptr::null(),
        flags: vk::ImageCreateFlags::empty(),
        image_type,
        format,
        extent: vk::Extent3D { width, height, depth },
        mip_levels: 1,
        array_layers: 1,
        samples: vk::SampleCountFlags::_1,
        tiling: vk::ImageTiling::OPTIMAL,
        usage,
        sharing_mode: vk::SharingMode::EXCLUSIVE,
        queue_family_index_count: 0,
        queue_family_indices: std::ptr::null(),
        initial_layout: vk::ImageLayout::UNDEFINED,
    }
}

fn acceleration_structure_write(
    set: vk::DescriptorSet,
    write: &vk::WriteDescriptorSetAccelerationStructureKHR,
) -> vk::WriteDescriptorSet {
    vk::WriteDescriptorSet {
        next: (write as *const vk::WriteDescriptorSetAccelerationStructureKHR).cast::<c_void>(),
        dst_set: set,
        dst_binding: 0,
        dst_array_element: 0,
        descriptor_count: 1,
        descriptor_type: vk::DescriptorType::ACCELERATION_STRUCTURE_KHR,
        ..Default::default()
    }
}

/// A descriptor update template, destroyed when it goes out of scope.
struct UpdateTemplate<'a> {
    device: &'a Device,
    handle: vk::DescriptorUpdateTemplate,
}

impl Drop for UpdateTemplate<'_> {
    fn drop(&mut self) {
        unsafe { self.device.destroy_descriptor_update_template(self.handle, None) };
    }
}

fn zero_region() -> vk::StridedDeviceAddressRegionKHR {
    vk::StridedDeviceAddressRegionKHR {
        device_address: 0,
        stride: 0,
        size: 0,
    }
}

/// What `BindingAcceleratioStructureTestInstance` holds as members.
struct Shared<'a> {
    params: TestParams,
    // A bare handle: the pool is owned by `iterate` and has to outlive the sets that are freed back to it.
    descriptor_pool: vk::DescriptorPool,
    set_layout_img: Unique<'a, vk::DescriptorSetLayout>,
    set_layout_as: Unique<'a, vk::DescriptorSetLayout>,
    pipeline_layout: Option<Unique<'a, vk::PipelineLayout>>,
    pipeline: Option<Unique<'a, vk::Pipeline>>,
}

impl Shared<'_> {
    fn pipeline_layout(&self) -> vk::PipelineLayout {
        **self
            .pipeline_layout
            .as_ref()
            .expect("initPipeline makes the pipeline layout")
    }
}

/// The virtual functions of `BindingAcceleratioStructureTestInstance`.
trait AsPipeline<'a> {
    fn init_pipeline(&mut self, shared: &mut Shared<'a>) -> Result<(), TestError>;
    fn extra_acceleration_descriptor_count(&self) -> u32;
    fn shader_stage_flags(&self) -> vk::ShaderStageFlags;
    fn pipeline_bind_point(&self) -> vk::PipelineBindPoint;
    fn fill_command_buffer(&mut self, shared: &Shared<'a>, cmd: vk::CommandBuffer) -> Result<(), TestError>;
}

struct AsInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
    pipeline: Box<dyn AsPipeline<'a> + 'a>,
}

impl<'a> TestInstance for AsInstance<'a> {
    /// `BindingAcceleratioStructureTestInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let alloc = context.get_default_allocator();
        let queue_family_index = context.get_universal_queue_family_index();
        let template_update_method = is_template_update_method(params.update_method);
        let push_update_method = is_push_update_method(params.update_method);
        let bind_point = self.pipeline.pipeline_bind_point();

        let (width, height, depth) = (params.width, params.height, params.depth);
        let image_create_info = make_image_create_info(
            params.format,
            width,
            height,
            depth,
            vk::ImageType::_3D,
            vk::ImageUsageFlags::STORAGE | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST,
        );
        let image_subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let image = ImageWithMemory::new(device, alloc, image_create_info, MemoryRequirement::ANY)?;
        let image_view = make_image_view(
            device,
            image.get(),
            vk::ImageViewType::_3D,
            params.format,
            image_subresource_range,
        )?;

        let pixel_size = 4u32;
        let result_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(
                u64::from(width * height * depth * pixel_size),
                vk::BufferUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let result_buffer_image_subresource_layers =
            make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1);
        let result_buffer_image_region = make_buffer_image_copy(
            vk::Extent3D { width, height, depth },
            result_buffer_image_subresource_layers,
        );
        let result_image_info = vk::DescriptorImageInfo {
            sampler: vk::Sampler::null(),
            image_view: *image_view,
            image_layout: vk::ImageLayout::GENERAL,
        };

        let command_pool = make_command_pool(device, queue_family_index)?;
        let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *command_buffer;

        let top_acceleration_structure = create_acceleration_structures(context)?;
        let write_descriptor_set_acceleration_structure = vk::WriteDescriptorSetAccelerationStructureKHR {
            acceleration_structure_count: 1,
            acceleration_structures: top_acceleration_structure.tlas(),
            ..Default::default()
        };
        let acceleration_structure_descriptor_count = 1 + self.pipeline.extra_acceleration_descriptor_count();
        let mut update_count = 0u32;

        let pool_sizes = [
            vk::DescriptorPoolSize {
                type_: vk::DescriptorType::STORAGE_IMAGE,
                descriptor_count: 1,
            },
            vk::DescriptorPoolSize {
                type_: vk::DescriptorType::ACCELERATION_STRUCTURE_KHR,
                descriptor_count: acceleration_structure_descriptor_count,
            },
        ];
        let pool_info = vk::DescriptorPoolCreateInfo::builder()
            .flags(vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET)
            .max_sets(1 + acceleration_structure_descriptor_count)
            .pool_sizes(&pool_sizes);
        let descriptor_pool = Unique::new(
            device,
            unsafe { device.create_descriptor_pool(&pool_info, None) }.vk_check("vkCreateDescriptorPool")?,
        );

        let shader_stage_flags = self.pipeline.shader_stage_flags();
        let set_layout_img = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, shader_stage_flags)
            .build(device)?;
        let set_img = make_descriptor_set(device, *descriptor_pool, *set_layout_img)?;
        let image_infos = [result_image_info];
        let image_write = vk::WriteDescriptorSet::builder()
            .dst_set(set_img.get())
            .dst_binding(0)
            .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
            .image_info(&image_infos)
            .build();
        unsafe { device.update_descriptor_sets(&[image_write], &[] as &[vk::CopyDescriptorSet]) };

        let set_layout_flags = if push_update_method {
            vk::DescriptorSetLayoutCreateFlags::PUSH_DESCRIPTOR
        } else {
            vk::DescriptorSetLayoutCreateFlags::empty()
        };
        let set_layout_as = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::ACCELERATION_STRUCTURE_KHR, shader_stage_flags)
            .build_with_flags(device, set_layout_flags)?;
        let set_as: Option<UniqueDescriptorSet<'_>> = if push_update_method {
            None
        } else {
            Some(make_descriptor_set(device, *descriptor_pool, *set_layout_as)?)
        };

        let mut shared = Shared {
            params,
            descriptor_pool: *descriptor_pool,
            set_layout_img,
            set_layout_as,
            pipeline_layout: None,
            pipeline: None,
        };
        self.pipeline.init_pipeline(&mut shared)?;
        let pipeline_layout = shared.pipeline_layout();

        if params.update_method == UpdateMethod::Normal {
            let write = acceleration_structure_write(
                set_as.as_ref().expect("a regular update has a set").get(),
                &write_descriptor_set_acceleration_structure,
            );
            unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };
            update_count += 1;
        }

        let tlas_data = (top_acceleration_structure.tlas() as *const vk::AccelerationStructureKHR).cast::<c_void>();
        let mut update_template: Option<UpdateTemplate<'_>> = None;
        if template_update_method {
            let template_type = if push_update_method {
                vk::DescriptorUpdateTemplateType::PUSH_DESCRIPTORS
            } else {
                vk::DescriptorUpdateTemplateType::DESCRIPTOR_SET
            };
            let entries = [vk::DescriptorUpdateTemplateEntry {
                dst_binding: 0,
                dst_array_element: 0,
                descriptor_count: 1,
                descriptor_type: vk::DescriptorType::ACCELERATION_STRUCTURE_KHR,
                offset: 0,
                stride: 0,
            }];
            let template_create_info = vk::DescriptorUpdateTemplateCreateInfo::builder()
                .descriptor_update_entries(&entries)
                .template_type(template_type)
                .descriptor_set_layout(*shared.set_layout_as)
                .pipeline_bind_point(bind_point)
                .pipeline_layout(pipeline_layout)
                .set(0);
            let handle = unsafe { device.create_descriptor_update_template(&template_create_info, None) }
                .vk_check("vkCreateDescriptorUpdateTemplate")?;
            update_template = Some(UpdateTemplate { device, handle });

            if !push_update_method {
                unsafe {
                    device.update_descriptor_set_with_template(
                        set_as.as_ref().expect("a template update has a set").get(),
                        handle,
                        tlas_data,
                    )
                };
                update_count += 1;
            }
        }

        begin_command_buffer(device, cmd)?;
        {
            let clear_value = vk::ClearColorValue { uint32: [0; 4] };
            let pre_image_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                image.get(),
                image_subresource_range,
            );
            let post_image_barrier = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::ACCELERATION_STRUCTURE_READ_KHR | vk::AccessFlags::ACCELERATION_STRUCTURE_WRITE_KHR,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::GENERAL,
                image.get(),
                image_subresource_range,
            );
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[pre_image_barrier],
                );
                device.cmd_clear_color_image(
                    cmd,
                    image.get(),
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &clear_value,
                    &[image_subresource_range],
                );
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::ACCELERATION_STRUCTURE_BUILD_KHR,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[post_image_barrier],
                );
                device.cmd_bind_descriptor_sets(cmd, bind_point, pipeline_layout, 1, &[set_img.get()], &[] as &[u32]);
            }
        }

        match params.update_method {
            UpdateMethod::Normal | UpdateMethod::WithTemplate => unsafe {
                device.cmd_bind_descriptor_sets(
                    cmd,
                    bind_point,
                    pipeline_layout,
                    0,
                    &[set_as.as_ref().expect("a non-push update has a set").get()],
                    &[] as &[u32],
                );
            },
            UpdateMethod::WithPush => {
                let write = acceleration_structure_write(
                    vk::DescriptorSet::null(),
                    &write_descriptor_set_acceleration_structure,
                );
                unsafe { device.cmd_push_descriptor_set_khr(cmd, bind_point, pipeline_layout, 0, &[write]) };
                update_count += 1;
            }
            UpdateMethod::WithPushTemplate => {
                let template = update_template.as_ref().expect("a template update has a template");
                unsafe {
                    device.cmd_push_descriptor_set_with_template_khr(
                        cmd,
                        template.handle,
                        pipeline_layout,
                        0,
                        tlas_data,
                    )
                };
                update_count += 1;
            }
        }

        {
            let pre_trace_memory_barrier = make_memory_barrier(
                vk::AccessFlags::ACCELERATION_STRUCTURE_WRITE_KHR,
                vk::AccessFlags::ACCELERATION_STRUCTURE_READ_KHR,
            );
            top_acceleration_structure.record_build(cmd);
            // Upstream's destination stage is the build stage, not a shader stage.
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::ACCELERATION_STRUCTURE_BUILD_KHR,
                    vk::PipelineStageFlags::ACCELERATION_STRUCTURE_BUILD_KHR,
                    vk::DependencyFlags::empty(),
                    &[pre_trace_memory_barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }

        self.pipeline.fill_command_buffer(&shared, cmd)?;

        {
            let post_test_memory_barrier = make_memory_barrier(
                vk::AccessFlags::SHADER_READ | vk::AccessFlags::SHADER_WRITE,
                vk::AccessFlags::TRANSFER_READ,
            );
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::ALL_COMMANDS,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[post_test_memory_barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }

        unsafe {
            device.cmd_copy_image_to_buffer(
                cmd,
                image.get(),
                vk::ImageLayout::GENERAL,
                result_buffer.get(),
                &[result_buffer_image_region],
            );
        }
        end_command_buffer(device, cmd)?;

        if update_count != 1 {
            return Err(TestError::InternalError("Invalid descriptor update".to_string()));
        }

        submit_commands_and_wait(device, queue, cmd)?;
        invalidate_alloc(device, result_buffer.get_allocation())?;

        if verify(&result_buffer, &params) {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Fail"))
        }
    }
}

/// `createAccelerationStructures`: a square in a plane that is tilted around the Z axis.
fn create_acceleration_structures<'a>(
    context: &'a Context<'a>,
) -> Result<DeferredAccelerationStructure<'a>, TestError> {
    let mid = (PLAIN_Z0 + PLAIN_Z1) / 2.0;
    let geometry_data = [
        [0.0, 0.0, PLAIN_Z0],
        [1.0, 0.0, mid],
        [0.0, 1.0, mid],
        [1.0, 1.0, PLAIN_Z1],
        [0.0, 1.0, mid],
        [1.0, 0.0, mid],
    ];
    DeferredAccelerationStructure::create(
        context.get_device(),
        context.get_default_allocator(),
        &geometry_data,
        true,
    )
}

fn mix(x: f32, y: f32, a: f32) -> f32 {
    x * (1.0 - a) + y * a
}

/// `verify`
fn verify(result_buffer: &BufferWithMemory<'_>, params: &TestParams) -> bool {
    let (width, height) = (params.width as usize, params.height as usize);
    let retrieved: &[i32] = unsafe {
        std::slice::from_raw_parts(
            result_buffer.get_allocation().get_host_ptr().cast::<i32>(),
            width * height,
        )
    };
    let mut expected: Vec<i32> = Vec::with_capacity(width * height);

    for y in 0..height {
        let expected_y = mix(PLAIN_Z0, PLAIN_Z1, (0.5 + y as f32) / height as f32);

        for x in 0..width {
            let expected_x = mix(PLAIN_Z0, PLAIN_Z1, (0.5 + x as f32) / width as f32);
            expected.push(((FIXED_POINT_DIVISOR / 2) as f32 * (expected_x + expected_y)) as i32);
        }
    }

    retrieved == expected.as_slice()
}

// ---------------------------------------------------------------------------------
// Graphics
// ---------------------------------------------------------------------------------

/// `BindingAcceleratioStructureGraphicsTestInstance`
struct GraphicsPipeline<'a> {
    context: &'a Context<'a>,
    params: TestParams,
    framebuffer_format: vk::Format,
    framebuffer_image: Option<ImageWithMemory<'a>>,
    framebuffer_attachment: Option<Unique<'a, vk::ImageView>>,
    vert_shader_module: Option<Unique<'a, vk::ShaderModule>>,
    geom_shader_module: Option<Unique<'a, vk::ShaderModule>>,
    tesc_shader_module: Option<Unique<'a, vk::ShaderModule>>,
    tese_shader_module: Option<Unique<'a, vk::ShaderModule>>,
    frag_shader_module: Option<Unique<'a, vk::ShaderModule>>,
    render_pass: Option<Unique<'a, vk::RenderPass>>,
    framebuffer: Option<Unique<'a, vk::Framebuffer>>,
    vertex_count: u32,
    vertex_buffer: Option<BufferWithMemory<'a>>,
}

impl<'a> GraphicsPipeline<'a> {
    fn new(context: &'a Context<'a>, params: TestParams) -> Self {
        Self {
            context,
            params,
            framebuffer_format: vk::Format::R8G8B8A8_UNORM,
            framebuffer_image: None,
            framebuffer_attachment: None,
            vert_shader_module: None,
            geom_shader_module: None,
            tesc_shader_module: None,
            tese_shader_module: None,
            frag_shader_module: None,
            render_pass: None,
            framebuffer: None,
            vertex_count: 0,
            vertex_buffer: None,
        }
    }

    /// `initVertexBuffer`
    fn init_vertex_buffer(&mut self) -> Result<(), TestError> {
        let (width, height) = (self.params.width, self.params.height);
        let mut vertices: Vec<[f32; 4]> = Vec::new();

        if self.params.stage == vk::ShaderStageFlags::FRAGMENT {
            let z = 1.0f32;
            let (a, b, c, d) = (
                [-1.0, -1.0, z, 1.0],
                [1.0, -1.0, z, 1.0],
                [-1.0, 1.0, z, 1.0],
                [1.0, 1.0, z, 1.0],
            );
            vertices.extend([a, b, c, b, c, d]);
        } else {
            let mut z = 0.0f32;

            vertices.reserve((3 * height * width) as usize);

            for y in 0..height {
                for x in 0..width {
                    let x0 = x as f32 / width as f32;
                    let y0 = y as f32 / height as f32;
                    let x1 = (x + 1) as f32 / width as f32;
                    let y1 = (y + 1) as f32 / height as f32;
                    let xm = (x0 + x1) / 2.0;
                    let ym = (y0 + y1) / 2.0;

                    vertices.push([x0, y0, z, 1.0]);
                    vertices.push([xm, y1, z, 1.0]);
                    vertices.push([x1, ym, z, 1.0]);

                    z += 1.0;
                }
            }
        }

        self.vertex_count = vertices.len() as u32;
        self.vertex_buffer = Some(create_host_buffer(
            self.context,
            &vertices,
            vk::BufferUsageFlags::VERTEX_BUFFER,
        )?);
        Ok(())
    }
}

impl<'a> AsPipeline<'a> for GraphicsPipeline<'a> {
    fn init_pipeline(&mut self, shared: &mut Shared<'a>) -> Result<(), TestError> {
        let context = self.context;
        let device = context.get_device();
        let alloc = context.get_default_allocator();
        let collection = context.get_binary_collection();
        let (width, height) = (self.params.width, self.params.height);

        if collection.contains("vert") {
            self.vert_shader_module = Some(create_shader_module(device, collection.get("vert")?)?);
        }
        if collection.contains("geom") {
            self.geom_shader_module = Some(create_shader_module(device, collection.get("geom")?)?);
        }
        if collection.contains("tesc") {
            self.tesc_shader_module = Some(create_shader_module(device, collection.get("tesc")?)?);
        }
        if collection.contains("tese") {
            self.tese_shader_module = Some(create_shader_module(device, collection.get("tese")?)?);
        }
        if collection.contains("frag") {
            self.frag_shader_module = Some(create_shader_module(device, collection.get("frag")?)?);
        }

        let image = ImageWithMemory::new(
            device,
            alloc,
            make_image_create_info(
                self.framebuffer_format,
                width,
                height,
                1,
                vk::ImageType::_2D,
                vk::ImageUsageFlags::COLOR_ATTACHMENT,
            ),
            MemoryRequirement::ANY,
        )?;
        let attachment = make_image_view(
            device,
            image.get(),
            vk::ImageViewType::_2D,
            self.framebuffer_format,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        )?;
        let render_pass = make_render_pass(device, self.framebuffer_format)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*attachment], width, height, 1)?;
        let pipeline_layout = make_pipeline_layout(device, &[*shared.set_layout_as, *shared.set_layout_img])?;

        let tess_stage_test = self.params.stage == vk::ShaderStageFlags::TESSELLATION_CONTROL
            || self.params.stage == vk::ShaderStageFlags::TESSELLATION_EVALUATION;
        let topology = if tess_stage_test {
            vk::PrimitiveTopology::PATCH_LIST
        } else {
            vk::PrimitiveTopology::TRIANGLE_LIST
        };
        let module = |m: &Option<Unique<'a, vk::ShaderModule>>| m.as_ref().map(|m| **m);
        let stages = GraphicsPipelineStages {
            vertex: module(&self.vert_shader_module).expect("every graphics case has a vertex shader"),
            fragment: module(&self.frag_shader_module).unwrap_or_else(vk::ShaderModule::null),
            tessellation_control: module(&self.tesc_shader_module),
            tessellation_evaluation: module(&self.tese_shader_module),
            geometry: module(&self.geom_shader_module),
        };
        let pipeline = make_graphics_pipeline_staged(
            device,
            *pipeline_layout,
            stages,
            *render_pass,
            (width, height),
            topology,
            vk::SampleCountFlags::_1,
            None,
            1,
            None,
            None,
        )?;

        self.framebuffer_image = Some(image);
        self.framebuffer_attachment = Some(attachment);
        self.render_pass = Some(render_pass);
        self.framebuffer = Some(framebuffer);
        shared.pipeline_layout = Some(pipeline_layout);
        shared.pipeline = Some(pipeline);

        self.init_vertex_buffer()
    }

    fn extra_acceleration_descriptor_count(&self) -> u32 {
        0
    }

    fn shader_stage_flags(&self) -> vk::ShaderStageFlags {
        vk::ShaderStageFlags::ALL_GRAPHICS
    }

    fn pipeline_bind_point(&self) -> vk::PipelineBindPoint {
        vk::PipelineBindPoint::GRAPHICS
    }

    fn fill_command_buffer(&mut self, shared: &Shared<'a>, cmd: vk::CommandBuffer) -> Result<(), TestError> {
        let device = self.context.get_device();
        let pipeline = shared.pipeline.as_ref().expect("initPipeline makes the pipeline");
        let vertex_buffer = self.vertex_buffer.as_ref().expect("initVertexBuffer made the buffer");

        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline.get());
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
        }

        begin_render_pass(
            device,
            cmd,
            **self.render_pass.as_ref().expect("initPipeline makes the render pass"),
            **self.framebuffer.as_ref().expect("initPipeline makes the framebuffer"),
            make_rect_2d(0, 0, self.params.width, self.params.height),
            vk::ClearValue {
                color: vk::ClearColorValue { uint32: [0; 4] },
            },
        );
        unsafe { device.cmd_draw(cmd, self.vertex_count, 1, 0, 0) };
        end_render_pass(device, cmd);
        Ok(())
    }
}

/// `BindingAcceleratioStructureGraphicsTestInstance::checkSupport`
fn graphics_check_support(context: &Context<'_>, params: &TestParams) -> Result<(), TestError> {
    let features = context.get_device_features();
    let stage = params.stage;

    if (stage == vk::ShaderStageFlags::VERTEX
        || stage == vk::ShaderStageFlags::TESSELLATION_CONTROL
        || stage == vk::ShaderStageFlags::TESSELLATION_EVALUATION
        || stage == vk::ShaderStageFlags::GEOMETRY)
        && features.vertex_pipeline_stores_and_atomics == vk::FALSE
    {
        return Err(TestError::NotSupported(
            "Requires the vertexPipelineStoresAndAtomics feature".to_string(),
        ));
    }
    if (stage == vk::ShaderStageFlags::TESSELLATION_CONTROL || stage == vk::ShaderStageFlags::TESSELLATION_EVALUATION)
        && features.tessellation_shader == vk::FALSE
    {
        return Err(TestError::NotSupported(
            "Requires the tessellationShader feature".to_string(),
        ));
    }
    if stage == vk::ShaderStageFlags::GEOMETRY && features.geometry_shader == vk::FALSE {
        return Err(TestError::NotSupported(
            "Requires the geometryShader feature".to_string(),
        ));
    }
    Ok(())
}

// ---------------------------------------------------------------------------------
// Compute
// ---------------------------------------------------------------------------------

/// `BindingAcceleratioStructureComputeTestInstance`
struct ComputePipeline<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

impl<'a> AsPipeline<'a> for ComputePipeline<'a> {
    fn init_pipeline(&mut self, shared: &mut Shared<'a>) -> Result<(), TestError> {
        let device = self.context.get_device();
        let shader_module = create_shader_module(device, self.context.get_binary_collection().get("comp")?)?;
        let pipeline_layout = make_pipeline_layout(device, &[*shared.set_layout_as, *shared.set_layout_img])?;
        let stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(*shader_module)
            .name(b"main\0")
            .build();
        let info = vk::ComputePipelineCreateInfo::builder()
            .stage(stage)
            .layout(*pipeline_layout)
            .base_pipeline_index(0);
        let pipelines = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[info], None) }
            .vk_check("vkCreateComputePipelines")?;
        shared.pipeline = Some(Unique::new(device, pipelines.0[0]));
        shared.pipeline_layout = Some(pipeline_layout);
        Ok(())
    }

    fn extra_acceleration_descriptor_count(&self) -> u32 {
        0
    }

    fn shader_stage_flags(&self) -> vk::ShaderStageFlags {
        vk::ShaderStageFlags::COMPUTE
    }

    fn pipeline_bind_point(&self) -> vk::PipelineBindPoint {
        vk::PipelineBindPoint::COMPUTE
    }

    fn fill_command_buffer(&mut self, shared: &Shared<'a>, cmd: vk::CommandBuffer) -> Result<(), TestError> {
        let device = self.context.get_device();
        let pipeline = shared.pipeline.as_ref().expect("initPipeline makes the pipeline");
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, pipeline.get());
            device.cmd_dispatch(cmd, self.params.width, self.params.height, 1);
        }
        Ok(())
    }
}

// ---------------------------------------------------------------------------------
// Ray tracing
// ---------------------------------------------------------------------------------

fn acceleration_structure_features(context: &Context<'_>) -> vk::PhysicalDeviceAccelerationStructureFeaturesKHR {
    let mut features = vk::PhysicalDeviceAccelerationStructureFeaturesKHR::default();
    let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
    unsafe {
        context
            .get_instance()
            .get_physical_device_features2(context.get_physical_device(), &mut features2)
    };
    features
}

fn ray_query_features(context: &Context<'_>) -> vk::PhysicalDeviceRayQueryFeaturesKHR {
    let mut features = vk::PhysicalDeviceRayQueryFeaturesKHR::default();
    let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
    unsafe {
        context
            .get_instance()
            .get_physical_device_features2(context.get_physical_device(), &mut features2)
    };
    features
}

fn ray_tracing_pipeline_features(context: &Context<'_>) -> vk::PhysicalDeviceRayTracingPipelineFeaturesKHR {
    let mut features = vk::PhysicalDeviceRayTracingPipelineFeaturesKHR::default();
    let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
    unsafe {
        context
            .get_instance()
            .get_physical_device_features2(context.get_physical_device(), &mut features2)
    };
    features
}

fn max_ray_recursion_depth(context: &Context<'_>) -> u32 {
    let mut properties = vk::PhysicalDeviceRayTracingPipelinePropertiesKHR::default();
    let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut properties);
    unsafe {
        context
            .get_instance()
            .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
    };
    properties.max_ray_recursion_depth
}

/// `BindingAcceleratioStructureRayTracingTestInstance::checkSupport` and the upstream one of the ray tracing test type, which the recursion depth is added to.
fn ray_tracing_check_support(context: &Context<'_>, params: &TestParams) -> Result<(), TestError> {
    context.require_device_functionality("VK_KHR_ray_tracing_pipeline")?;

    if ray_tracing_pipeline_features(context).ray_tracing_pipeline == vk::FALSE {
        return Err(TestError::NotSupported(
            "Requires VkPhysicalDeviceRayTracingPipelineFeaturesKHR.rayTracingPipeline".to_string(),
        ));
    }
    if params.test_type == TestType::UsingRayTracing
        && max_ray_recursion_depth(context) < 2
        && (params.stage == vk::ShaderStageFlags::CLOSEST_HIT_KHR || params.stage == vk::ShaderStageFlags::MISS_KHR)
    {
        return Err(TestError::NotSupported(
            "rayTracingPipelinePropertiesKHR.maxRayRecursionDepth is smaller than required".to_string(),
        ));
    }
    Ok(())
}

/// `setDefaultGeometryData`: the geometry of the structure the ray tracing stages trace against.
fn default_geometry_data(stage: vk::ShaderStageFlags) -> (Vec<[f32; 3]>, bool) {
    let z = if stage == vk::ShaderStageFlags::MISS_KHR {
        -9.9
    } else {
        -1.0
    };
    let triangles = stage != vk::ShaderStageFlags::INTERSECTION_KHR;

    if triangles {
        (
            vec![
                [-1.0, -1.0, z],
                [-1.0, 1.0, z],
                [1.0, -1.0, z],
                [1.0, -1.0, z],
                [-1.0, 1.0, z],
                [1.0, 1.0, z],
            ],
            true,
        )
    } else {
        (vec![[-1.0, -1.0, z], [1.0, 1.0, z]], false)
    }
}

/// The shader binding tables and their regions, as `vkCmdTraceRaysKHR` takes them.
struct Sbt<'a> {
    #[expect(dead_code, reason = "mirrors upstream's member, which this port never reads")]
    buffers: Vec<BufferWithMemory<'a>>,
    raygen: vk::StridedDeviceAddressRegionKHR,
    miss: vk::StridedDeviceAddressRegionKHR,
    hit: vk::StridedDeviceAddressRegionKHR,
    callable: vk::StridedDeviceAddressRegionKHR,
}

impl Default for Sbt<'_> {
    fn default() -> Self {
        Self {
            buffers: Vec::new(),
            raygen: zero_region(),
            miss: zero_region(),
            hit: zero_region(),
            callable: zero_region(),
        }
    }
}

/// `createShaderBindingTable`, none when `group` is not one of the pipeline's.
fn make_sbt<'a>(
    context: &'a Context<'a>,
    pipeline: vk::Pipeline,
    shader_group_count: u32,
    group: u32,
    group_count: u32,
) -> Result<Option<(BufferWithMemory<'a>, vk::StridedDeviceAddressRegionKHR)>, TestError> {
    if group >= shader_group_count {
        return Ok(None);
    }
    let (handle_size, base_alignment) = shader_group_sizes(context.get_instance(), context.get_physical_device());
    Ok(Some(create_shader_binding_table(
        context.get_device(),
        context.get_default_allocator(),
        pipeline,
        handle_size,
        base_alignment,
        group,
        group_count,
    )?))
}

/// A set that is not freed on its own: the pool of the case goes away before the instance does.
fn allocate_descriptor_set(
    device: &Device,
    pool: vk::DescriptorPool,
    layout: vk::DescriptorSetLayout,
) -> Result<vk::DescriptorSet, TestError> {
    let layouts = [layout];
    let info = vk::DescriptorSetAllocateInfo::builder()
        .descriptor_pool(pool)
        .set_layouts(&layouts);
    let sets = unsafe { device.allocate_descriptor_sets(&info) }.vk_check("vkAllocateDescriptorSets")?;
    Ok(sets[0])
}

fn svc_set_layout<'a>(device: &'a Device) -> Result<Unique<'a, vk::DescriptorSetLayout>, TestError> {
    DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::ACCELERATION_STRUCTURE_KHR, all_ray_tracing_stages())
        .build(device)
}

/// Builds the structure the ray tracing stages trace against into `cmd` and points the service set at it.
fn build_service_structure<'a>(
    context: &'a Context<'a>,
    stage: vk::ShaderStageFlags,
    set_svc: vk::DescriptorSet,
    cmd: vk::CommandBuffer,
) -> Result<DeferredAccelerationStructure<'a>, TestError> {
    let device = context.get_device();
    let (geometry_data, triangles) = default_geometry_data(stage);
    let structure =
        DeferredAccelerationStructure::create(device, context.get_default_allocator(), &geometry_data, triangles)?;
    structure.record_build(cmd);
    let barrier = make_memory_barrier(
        vk::AccessFlags::ACCELERATION_STRUCTURE_WRITE_KHR,
        vk::AccessFlags::ACCELERATION_STRUCTURE_READ_KHR,
    );
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::ACCELERATION_STRUCTURE_BUILD_KHR,
            vk::PipelineStageFlags::RAY_TRACING_SHADER_KHR,
            vk::DependencyFlags::empty(),
            &[barrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }

    let write = vk::WriteDescriptorSetAccelerationStructureKHR {
        acceleration_structure_count: 1,
        acceleration_structures: structure.tlas(),
        ..Default::default()
    };
    let descriptor_write = acceleration_structure_write(set_svc, &write);
    unsafe { device.update_descriptor_sets(&[descriptor_write], &[] as &[vk::CopyDescriptorSet]) };
    Ok(structure)
}

/// The rest of `fillCommandBuffer` of both ray tracing instances: bind the service set and the pipeline, trace.
fn bind_and_trace(
    context: &Context<'_>,
    shared: &Shared<'_>,
    set_svc: vk::DescriptorSet,
    sbt: &Sbt<'_>,
    cmd: vk::CommandBuffer,
) {
    let device = context.get_device();
    unsafe {
        device.cmd_bind_descriptor_sets(
            cmd,
            vk::PipelineBindPoint::RAY_TRACING_KHR,
            shared.pipeline_layout(),
            2,
            &[set_svc],
            &[] as &[u32],
        );
        device.cmd_bind_pipeline(
            cmd,
            vk::PipelineBindPoint::RAY_TRACING_KHR,
            shared.pipeline.as_ref().expect("initPipeline makes the pipeline").get(),
        );
        device.cmd_trace_rays_khr(
            cmd,
            &sbt.raygen,
            &sbt.miss,
            &sbt.hit,
            &sbt.callable,
            shared.params.width,
            shared.params.height,
            1,
        );
    }
}

/// `BindingAcceleratioStructureRayTracingTestInstance`
struct RayTracingPipeline<'a> {
    context: &'a Context<'a>,
    params: TestParams,
    shader_group_count: u32,
    set_layout_svc: Option<Unique<'a, vk::DescriptorSetLayout>>,
    set_svc: Option<vk::DescriptorSet>,
    sbt: Sbt<'a>,
    service_structure: Option<DeferredAccelerationStructure<'a>>,
}

impl<'a> RayTracingPipeline<'a> {
    fn new(context: &'a Context<'a>, params: TestParams) -> Self {
        Self {
            context,
            params,
            shader_group_count: 0,
            set_layout_svc: None,
            set_svc: None,
            sbt: Sbt::default(),
            service_structure: None,
        }
    }
}

impl<'a> AsPipeline<'a> for RayTracingPipeline<'a> {
    fn init_pipeline(&mut self, shared: &mut Shared<'a>) -> Result<(), TestError> {
        let context = self.context;
        let device = context.get_device();
        let collection = context.get_binary_collection();
        let mut shaders = vk::ShaderStageFlags::empty();
        let (mut raygen_group, mut miss_group, mut hit_group, mut callable_group) =
            (NO_GROUP, NO_GROUP, NO_GROUP, NO_GROUP);

        self.shader_group_count = 0;

        for (name, stage) in [
            ("rgen", vk::ShaderStageFlags::RAYGEN_KHR),
            ("ahit", vk::ShaderStageFlags::ANY_HIT_KHR),
            ("chit", vk::ShaderStageFlags::CLOSEST_HIT_KHR),
            ("miss", vk::ShaderStageFlags::MISS_KHR),
            ("sect", vk::ShaderStageFlags::INTERSECTION_KHR),
            ("call", vk::ShaderStageFlags::CALLABLE_KHR),
        ] {
            if collection.contains(name) {
                shaders |= stage;
            }
        }

        if shaders.contains(vk::ShaderStageFlags::RAYGEN_KHR) {
            raygen_group = self.shader_group_count;
            self.shader_group_count += 1;
        }
        if shaders.contains(vk::ShaderStageFlags::MISS_KHR) {
            miss_group = self.shader_group_count;
            self.shader_group_count += 1;
        }
        if shaders.intersects(hit_stages()) {
            hit_group = self.shader_group_count;
            self.shader_group_count += 1;
        }
        if shaders.contains(vk::ShaderStageFlags::CALLABLE_KHR) {
            callable_group = self.shader_group_count;
            self.shader_group_count += 1;
        }

        let set_layout_svc = svc_set_layout(device)?;
        self.set_svc = Some(allocate_descriptor_set(
            device,
            shared.descriptor_pool,
            *set_layout_svc,
        )?);

        let mut builder = RayTracingPipelineBuilder::new();
        let mut modules = Vec::new();
        for (name, stage, group) in [
            ("rgen", vk::ShaderStageFlags::RAYGEN_KHR, raygen_group),
            ("ahit", vk::ShaderStageFlags::ANY_HIT_KHR, hit_group),
            ("chit", vk::ShaderStageFlags::CLOSEST_HIT_KHR, hit_group),
            ("miss", vk::ShaderStageFlags::MISS_KHR, miss_group),
            ("sect", vk::ShaderStageFlags::INTERSECTION_KHR, hit_group),
            ("call", vk::ShaderStageFlags::CALLABLE_KHR, callable_group),
        ] {
            if shaders.contains(stage) {
                let module = create_shader_module(device, collection.get(name)?)?;
                builder.add_shader(stage, *module, group as usize);
                modules.push(module);
            }
        }

        let pipeline_layout = make_pipeline_layout(
            device,
            &[*shared.set_layout_as, *shared.set_layout_img, *set_layout_svc],
        )?;
        let pipeline = builder.create_pipeline(device, *pipeline_layout)?;

        let sbt_size = |sbt: Option<(BufferWithMemory<'a>, vk::StridedDeviceAddressRegionKHR)>,
                        buffers: &mut Vec<BufferWithMemory<'a>>| match sbt {
            Some((buffer, region)) => {
                buffers.push(buffer);
                region
            }
            None => zero_region(),
        };
        let mut buffers = Vec::new();
        let raygen = sbt_size(
            make_sbt(context, *pipeline, self.shader_group_count, raygen_group, 1)?,
            &mut buffers,
        );
        let miss = sbt_size(
            make_sbt(context, *pipeline, self.shader_group_count, miss_group, 1)?,
            &mut buffers,
        );
        let hit = sbt_size(
            make_sbt(context, *pipeline, self.shader_group_count, hit_group, 1)?,
            &mut buffers,
        );
        let callable = sbt_size(
            make_sbt(context, *pipeline, self.shader_group_count, callable_group, 1)?,
            &mut buffers,
        );
        self.sbt = Sbt {
            buffers,
            raygen,
            miss,
            hit,
            callable,
        };

        self.set_layout_svc = Some(set_layout_svc);
        shared.pipeline_layout = Some(pipeline_layout);
        shared.pipeline = Some(pipeline);
        Ok(())
    }

    fn extra_acceleration_descriptor_count(&self) -> u32 {
        1
    }

    fn shader_stage_flags(&self) -> vk::ShaderStageFlags {
        all_ray_tracing_stages()
    }

    fn pipeline_bind_point(&self) -> vk::PipelineBindPoint {
        vk::PipelineBindPoint::RAY_TRACING_KHR
    }

    fn fill_command_buffer(&mut self, shared: &Shared<'a>, cmd: vk::CommandBuffer) -> Result<(), TestError> {
        let set_svc = self.set_svc.expect("initPipeline makes the service set");
        self.service_structure = Some(build_service_structure(self.context, self.params.stage, set_svc, cmd)?);
        bind_and_trace(self.context, shared, set_svc, &self.sbt, cmd);
        Ok(())
    }
}

/// `BindingAcceleratioStructureRayTracingRayTracingTestInstance`: the shaders of the tested stage trace rays themselves, against a second hit group and miss shader.
struct RayTracingRayTracingPipeline<'a> {
    context: &'a Context<'a>,
    params: TestParams,
    shader_group_count: u32,
    set_layout_svc: Option<Unique<'a, vk::DescriptorSetLayout>>,
    set_svc: Option<vk::DescriptorSet>,
    sbt: Sbt<'a>,
    service_structure: Option<DeferredAccelerationStructure<'a>>,
}

impl<'a> RayTracingRayTracingPipeline<'a> {
    fn new(context: &'a Context<'a>, params: TestParams) -> Self {
        Self {
            context,
            params,
            shader_group_count: 0,
            set_layout_svc: None,
            set_svc: None,
            sbt: Sbt::default(),
            service_structure: None,
        }
    }
}

/// `calcShaderGroup`: returns the group of `shader_stage_flags` and how many groups it has.
fn calc_shader_group(
    shader_group_counter: &mut u32,
    shaders1: vk::ShaderStageFlags,
    shaders2: vk::ShaderStageFlags,
    shader_stage_flags: vk::ShaderStageFlags,
) -> (u32, u32) {
    let shader1_count = u32::from(shaders1.intersects(shader_stage_flags));
    let shader2_count = u32::from(shaders2.intersects(shader_stage_flags));
    let shader_group_count = shader1_count + shader2_count;
    let mut shader_group = NO_GROUP;

    if shader_group_count != 0 {
        shader_group = *shader_group_counter;
        *shader_group_counter += shader_group_count;
    }
    (shader_group, shader_group_count)
}

impl<'a> AsPipeline<'a> for RayTracingRayTracingPipeline<'a> {
    fn init_pipeline(&mut self, shared: &mut Shared<'a>) -> Result<(), TestError> {
        let context = self.context;
        let device = context.get_device();
        let collection = context.get_binary_collection();
        let mut shaders = vk::ShaderStageFlags::empty();
        let mut shaders0 = vk::ShaderStageFlags::empty();

        self.shader_group_count = 0;

        for (name, stage) in [
            ("rgen", vk::ShaderStageFlags::RAYGEN_KHR),
            ("ahit", vk::ShaderStageFlags::ANY_HIT_KHR),
            ("chit", vk::ShaderStageFlags::CLOSEST_HIT_KHR),
            ("miss", vk::ShaderStageFlags::MISS_KHR),
        ] {
            if collection.contains(name) {
                shaders |= stage;
            }
        }
        for (name, stage) in [
            ("ahit0", vk::ShaderStageFlags::ANY_HIT_KHR),
            ("chit0", vk::ShaderStageFlags::CLOSEST_HIT_KHR),
            ("miss0", vk::ShaderStageFlags::MISS_KHR),
        ] {
            if collection.contains(name) {
                shaders0 |= stage;
            }
        }

        let (raygen_group, raygen_group_count) = calc_shader_group(
            &mut self.shader_group_count,
            shaders,
            shaders0,
            vk::ShaderStageFlags::RAYGEN_KHR,
        );
        let (miss_group, miss_group_count) = calc_shader_group(
            &mut self.shader_group_count,
            shaders,
            shaders0,
            vk::ShaderStageFlags::MISS_KHR,
        );
        let (hit_group, hit_group_count) =
            calc_shader_group(&mut self.shader_group_count, shaders, shaders0, hit_stages());

        let set_layout_svc = svc_set_layout(device)?;
        self.set_svc = Some(allocate_descriptor_set(
            device,
            shared.descriptor_pool,
            *set_layout_svc,
        )?);

        let mut builder = RayTracingPipelineBuilder::new();
        let mut modules = Vec::new();
        for (name, stage, group) in [
            ("rgen", vk::ShaderStageFlags::RAYGEN_KHR, raygen_group),
            ("ahit", vk::ShaderStageFlags::ANY_HIT_KHR, hit_group),
            ("chit", vk::ShaderStageFlags::CLOSEST_HIT_KHR, hit_group),
            ("miss", vk::ShaderStageFlags::MISS_KHR, miss_group),
        ] {
            if shaders.contains(stage) {
                let module = create_shader_module(device, collection.get(name)?)?;
                builder.add_shader(stage, *module, group as usize);
                modules.push(module);
            }
        }

        // The "chit" and "miss" cases both generate more rays from their shaders.
        if self.params.test_type == TestType::UsingRayTracing
            && (self.params.stage == vk::ShaderStageFlags::CLOSEST_HIT_KHR
                || self.params.stage == vk::ShaderStageFlags::MISS_KHR)
        {
            builder.set_max_recursion_depth(2);
        }

        for (name, stage, group) in [
            ("ahit0", vk::ShaderStageFlags::ANY_HIT_KHR, hit_group.wrapping_add(1)),
            (
                "chit0",
                vk::ShaderStageFlags::CLOSEST_HIT_KHR,
                hit_group.wrapping_add(1),
            ),
            ("miss0", vk::ShaderStageFlags::MISS_KHR, miss_group.wrapping_add(1)),
        ] {
            if shaders0.contains(stage) {
                let module = create_shader_module(device, collection.get(name)?)?;
                builder.add_shader(stage, *module, group as usize);
                modules.push(module);
            }
        }

        let pipeline_layout = make_pipeline_layout(
            device,
            &[*shared.set_layout_as, *shared.set_layout_img, *set_layout_svc],
        )?;
        let pipeline = builder.create_pipeline(device, *pipeline_layout)?;

        let mut buffers = Vec::new();
        let mut region = |group: u32, group_count: u32| -> Result<vk::StridedDeviceAddressRegionKHR, TestError> {
            match make_sbt(context, *pipeline, self.shader_group_count, group, group_count)? {
                Some((buffer, region)) => {
                    buffers.push(buffer);
                    Ok(region)
                }
                None => Ok(zero_region()),
            }
        };
        let raygen = region(raygen_group, raygen_group_count)?;
        let miss = region(miss_group, miss_group_count)?;
        let hit = region(hit_group, hit_group_count)?;
        self.sbt = Sbt {
            buffers,
            raygen,
            miss,
            hit,
            callable: zero_region(),
        };

        self.set_layout_svc = Some(set_layout_svc);
        shared.pipeline_layout = Some(pipeline_layout);
        shared.pipeline = Some(pipeline);
        Ok(())
    }

    fn extra_acceleration_descriptor_count(&self) -> u32 {
        1
    }

    fn shader_stage_flags(&self) -> vk::ShaderStageFlags {
        all_ray_tracing_stages()
    }

    fn pipeline_bind_point(&self) -> vk::PipelineBindPoint {
        vk::PipelineBindPoint::RAY_TRACING_KHR
    }

    fn fill_command_buffer(&mut self, shared: &Shared<'a>, cmd: vk::CommandBuffer) -> Result<(), TestError> {
        let set_svc = self.set_svc.expect("initPipeline makes the service set");
        self.service_structure = Some(build_service_structure(self.context, self.params.stage, set_svc, cmd)?);
        bind_and_trace(self.context, shared, set_svc, &self.sbt, cmd);
        Ok(())
    }
}

// ---------------------------------------------------------------------------------
// The case
// ---------------------------------------------------------------------------------

/// `BindingAccelerationStructureTestCase`
struct BindingAccelerationStructureTestCase {
    name: &'static str,
    params: TestParams,
}

impl BindingAccelerationStructureTestCase {
    fn is_ray_tracing_stage(&self) -> bool {
        self.params.stage == vk::ShaderStageFlags::RAYGEN_KHR
            || self.params.stage == vk::ShaderStageFlags::ANY_HIT_KHR
            || self.params.stage == vk::ShaderStageFlags::CLOSEST_HIT_KHR
            || self.params.stage == vk::ShaderStageFlags::MISS_KHR
            || self.params.stage == vk::ShaderStageFlags::INTERSECTION_KHR
            || self.params.stage == vk::ShaderStageFlags::CALLABLE_KHR
    }
}

impl TestCase for BindingAccelerationStructureTestCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_acceleration_structure")?;

        if acceleration_structure_features(context).acceleration_structure == vk::FALSE {
            return Err(TestError::Fail(
                "Requires VkPhysicalDeviceAccelerationStructureFeaturesKHR.accelerationStructure".to_string(),
            ));
        }

        match self.params.test_type {
            TestType::UsingRayQuery => {
                context.require_device_functionality("VK_KHR_ray_query")?;

                if ray_query_features(context).ray_query == vk::FALSE {
                    return Err(TestError::NotSupported(
                        "Requires VkPhysicalDeviceRayQueryFeaturesKHR.rayQuery".to_string(),
                    ));
                }
            }
            TestType::UsingRayTracing => {
                context.require_device_functionality("VK_KHR_ray_tracing_pipeline")?;

                if ray_tracing_pipeline_features(context).ray_tracing_pipeline == vk::FALSE {
                    return Err(TestError::NotSupported(
                        "Requires VkPhysicalDeviceRayTracingPipelineFeaturesKHR.rayTracingPipeline".to_string(),
                    ));
                }
            }
        }

        match self.params.update_method {
            UpdateMethod::Normal => {}
            UpdateMethod::WithTemplate => context.require_device_functionality("VK_KHR_descriptor_update_template")?,
            UpdateMethod::WithPush => context.require_device_functionality("VK_KHR_push_descriptor")?,
            UpdateMethod::WithPushTemplate => {
                context.require_device_functionality("VK_KHR_push_descriptor")?;
                context.require_device_functionality("VK_KHR_descriptor_update_template")?;
            }
        }

        if self.params.test_type == TestType::UsingRayTracing || self.is_ray_tracing_stage() {
            ray_tracing_check_support(context, &self.params)
        } else if self.params.stage == vk::ShaderStageFlags::COMPUTE {
            Ok(())
        } else {
            graphics_check_support(context, &self.params)
        }
    }

    fn programs(&self) -> BinaryCollection {
        self.params.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        let params = self.params;
        let pipeline: Box<dyn AsPipeline<'a> + 'a> = match params.test_type {
            TestType::UsingRayQuery => {
                if self.is_ray_tracing_stage() {
                    Box::new(RayTracingPipeline::new(context, params))
                } else if params.stage == vk::ShaderStageFlags::COMPUTE {
                    Box::new(ComputePipeline { context, params })
                } else {
                    Box::new(GraphicsPipeline::new(context, params))
                }
            }
            TestType::UsingRayTracing => Box::new(RayTracingRayTracingPipeline::new(context, params)),
        };
        Box::new(AsInstance {
            context,
            params,
            pipeline,
        })
    }
}

fn programs_for(test_type: TestType, stage_name: &str) -> &'static SharedProgram {
    match (test_type, stage_name) {
        (TestType::UsingRayQuery, "vert") => &g::RQ_VERT,
        (TestType::UsingRayQuery, "tesc") => &g::RQ_TESC,
        (TestType::UsingRayQuery, "tese") => &g::RQ_TESE,
        (TestType::UsingRayQuery, "geom") => &g::RQ_GEOM,
        (TestType::UsingRayQuery, "frag") => &g::RQ_FRAG,
        (TestType::UsingRayQuery, "comp") => &g::RQ_COMP,
        (TestType::UsingRayQuery, "rgen") => &g::RQ_RGEN,
        (TestType::UsingRayQuery, "ahit") => &g::RQ_AHIT,
        (TestType::UsingRayQuery, "chit") => &g::RQ_CHIT,
        (TestType::UsingRayQuery, "miss") => &g::RQ_MISS,
        (TestType::UsingRayQuery, "sect") => &g::RQ_SECT,
        (TestType::UsingRayQuery, "call") => &g::RQ_CALL,
        (TestType::UsingRayTracing, "rgen") => &g::RT_RGEN,
        (TestType::UsingRayTracing, "chit") => &g::RT_CHIT,
        (TestType::UsingRayTracing, "miss") => &g::RT_MISS,
        _ => unreachable!("no program set for this stage"),
    }
}

/// `createDescriptorUpdateASTests`
pub fn create_descriptor_update_as_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("acceleration_structure");

    let test_types = [
        (TestType::UsingRayQuery, "ray_query"),
        (TestType::UsingRayTracing, "ray_tracing"),
    ];
    let update_methods = [
        (UpdateMethod::Normal, "regular"),
        (UpdateMethod::WithTemplate, "with_template"),
        (UpdateMethod::WithPush, "with_push"),
        (UpdateMethod::WithPushTemplate, "with_push_template"),
    ];
    let pipeline_stages = [
        (vk::ShaderStageFlags::VERTEX, "vert", false),
        (vk::ShaderStageFlags::TESSELLATION_CONTROL, "tesc", false),
        (vk::ShaderStageFlags::TESSELLATION_EVALUATION, "tese", false),
        (vk::ShaderStageFlags::GEOMETRY, "geom", false),
        (vk::ShaderStageFlags::FRAGMENT, "frag", false),
        (vk::ShaderStageFlags::COMPUTE, "comp", false),
        (vk::ShaderStageFlags::RAYGEN_KHR, "rgen", true),
        (vk::ShaderStageFlags::ANY_HIT_KHR, "ahit", false),
        (vk::ShaderStageFlags::CLOSEST_HIT_KHR, "chit", true),
        (vk::ShaderStageFlags::MISS_KHR, "miss", true),
        (vk::ShaderStageFlags::INTERSECTION_KHR, "sect", false),
        (vk::ShaderStageFlags::CALLABLE_KHR, "call", false),
    ];

    for (test_type, test_type_name) in test_types {
        let mut test_type_group = TestCaseGroup::new(test_type_name);
        let image_depth = 1;

        for (update_method, update_method_name) in update_methods {
            let mut update_methods_group = TestCaseGroup::new(update_method_name);

            for (stage, stage_name, ray_tracing) in pipeline_stages {
                if test_type == TestType::UsingRayTracing && !ray_tracing {
                    continue;
                }

                let params = TestParams {
                    width: TEST_WIDTH,
                    height: TEST_HEIGHT,
                    depth: image_depth,
                    test_type,
                    update_method,
                    stage,
                    format: vk::Format::R32_SINT,
                    programs: programs_for(test_type, stage_name).programs,
                };
                update_methods_group.add_child(Box::new(BindingAccelerationStructureTestCase {
                    name: stage_name,
                    params,
                }) as Box<dyn TestCase>);
            }

            test_type_group.add_child(update_methods_group);
        }

        group.add_child(test_type_group);
    }

    group
}
