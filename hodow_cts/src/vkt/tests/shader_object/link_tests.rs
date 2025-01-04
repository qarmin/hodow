// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/shader_object/vktShaderObjectLinkTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The programs are `SHADER_OBJECT_LINK` and `SHADER_OBJECT_LINK_MESH` of
// `shaders/manifest/shader_object_link.toml`. Pixels are compared as bytes (R8G8B8A8_UNORM, so white is 255 on every channel and black is
// 0 with alpha 255), which is exactly what upstream's float compare against 1.0 and 0.0 decides. The ONE_LINKED_UNLINKED branch of the
// vertex shader that upstream reaches only with `linkedAdded` already set is unreachable there and is not written out.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ExtMeshShaderExtensionDeviceCommands, ExtShaderObjectExtensionDeviceCommands, Handle};

use super::util::{
    ShaderObject, bind_graphics_shaders, bind_null_rasterization_shaders, bind_null_task_mesh_shaders,
    create_shaders_raw, get_mesh_shader_features, make_shader_create_info, remove_unsupported_shader_object_extensions,
    set_default_shader_object_dynamic_states, shader_create_info,
};
use crate::generated::shaders::shader_object_link::{SHADER_OBJECT_LINK, SHADER_OBJECT_LINK_MESH};
use crate::tcu::random::Random;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_set, make_pipeline_layout,
};
use crate::vk::programs::BinaryCollection;
pub use crate::vk::programs::SharedProgram;
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{begin_rendering, end_rendering, rect_2d};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

pub(super) const RENDER_SIZE: u32 = 32;
const DRAW_COUNT: u32 = 4;
const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;

#[derive(Clone, Copy, PartialEq, Eq)]
enum ShaderType {
    Unused,
    Linked,
    Unlinked,
}

use ShaderType::{Linked, Unlinked, Unused};

#[derive(Clone, Copy)]
struct Shaders {
    vertex: ShaderType,
    tessellation_control: ShaderType,
    tessellation_evaluation: ShaderType,
    geometry: ShaderType,
    fragment: ShaderType,
}

#[derive(Clone, Copy)]
struct MeshShaders {
    task: ShaderType,
    mesh: ShaderType,
    fragment: ShaderType,
}

#[derive(Clone, Copy, Default)]
struct NextStages {
    vert_next_stage: vk::ShaderStageFlags,
    tesc_next_stage: vk::ShaderStageFlags,
    tese_next_stage: vk::ShaderStageFlags,
    geom_next_stage: vk::ShaderStageFlags,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum BindType {
    Separate,
    OneLinkedUnlinked,
    All,
}

#[derive(Clone, Copy)]
struct TestParams {
    shaders: Shaders,
    random_order: bool,
    next_stages: NextStages,
    separate_linked: bool,
    separate_bind: BindType,
    same_layout: bool,
}

#[derive(Clone, Copy)]
struct MeshParams {
    shaders: MeshShaders,
    random_order: bool,
    task_next_stage: vk::ShaderStageFlags,
    mesh_next_stage: vk::ShaderStageFlags,
}

fn type_to_string(shader_type: ShaderType) -> &'static str {
    match shader_type {
        Unused => "unused",
        Linked => "linked",
        Unlinked => "unlinked",
    }
}

/// `ShaderObjectLinkInstance::getNextStage`
fn get_next_stage(params: &TestParams, current_stage: vk::ShaderStageFlags) -> vk::ShaderStageFlags {
    let shaders = &params.shaders;
    let linked_next = (|| {
        if current_stage == vk::ShaderStageFlags::VERTEX && shaders.vertex == Linked {
            if shaders.tessellation_control != Unused {
                if shaders.tessellation_control == Linked {
                    return Some(vk::ShaderStageFlags::TESSELLATION_CONTROL);
                }
            } else if shaders.geometry != Unused {
                if shaders.geometry == Linked {
                    return Some(vk::ShaderStageFlags::GEOMETRY);
                }
            } else if shaders.fragment != Unused && shaders.fragment == Linked {
                return Some(vk::ShaderStageFlags::FRAGMENT);
            }
        } else if current_stage == vk::ShaderStageFlags::TESSELLATION_CONTROL
            && shaders.tessellation_control == Linked
            && shaders.tessellation_evaluation == Linked
        {
            return Some(vk::ShaderStageFlags::TESSELLATION_EVALUATION);
        } else if current_stage == vk::ShaderStageFlags::TESSELLATION_EVALUATION
            && shaders.tessellation_evaluation == Linked
        {
            if shaders.geometry != Unused {
                if shaders.geometry == Linked {
                    return Some(vk::ShaderStageFlags::GEOMETRY);
                }
            } else if shaders.fragment != Unused && shaders.fragment == Linked {
                return Some(vk::ShaderStageFlags::FRAGMENT);
            }
        } else if current_stage == vk::ShaderStageFlags::GEOMETRY
            && shaders.geometry == Linked
            && shaders.fragment != Unused
            && shaders.fragment == Linked
        {
            return Some(vk::ShaderStageFlags::FRAGMENT);
        }
        None
    })();
    if let Some(next) = linked_next {
        return next;
    }

    if current_stage == vk::ShaderStageFlags::VERTEX {
        return params.next_stages.vert_next_stage;
    }
    if current_stage == vk::ShaderStageFlags::TESSELLATION_CONTROL {
        return params.next_stages.tesc_next_stage;
    }
    if current_stage == vk::ShaderStageFlags::TESSELLATION_EVALUATION {
        return params.next_stages.tese_next_stage;
    }
    if current_stage == vk::ShaderStageFlags::GEOMETRY {
        return params.next_stages.geom_next_stage;
    }
    vk::ShaderStageFlags::empty()
}

pub(super) struct ColorTarget<'a> {
    pub(super) image: ImageWithMemory<'a>,
    pub(super) view: Unique<'a, vk::ImageView>,
    pub(super) output_buffer: BufferWithMemory<'a>,
}

pub(super) fn create_color_target<'a>(context: &'a Context<'_>) -> Result<ColorTarget<'a>, TestError> {
    create_color_target_with_format(context, COLOR_FORMAT)
}

/// The same target over any 32 bit colour format.
pub(super) fn create_color_target_with_format<'a>(
    context: &'a Context<'_>,
    format: vk::Format,
) -> Result<ColorTarget<'a>, TestError> {
    create_color_target_on(context.get_device(), context.get_default_allocator(), format)
}

/// The same target on a device and allocator of the caller's choice.
pub(super) fn create_color_target_on<'a>(
    device: &'a vulkanalia::Device,
    allocator: &crate::vk::mem_util::SimpleAllocator,
    format: vk::Format,
) -> Result<ColorTarget<'a>, TestError> {
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
        usage: vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
        sharing_mode: vk::SharingMode::EXCLUSIVE,
        queue_family_index_count: 0,
        queue_family_indices: std::ptr::null(),
        initial_layout: vk::ImageLayout::UNDEFINED,
    };
    let image = ImageWithMemory::new(device, allocator, create_info, MemoryRequirement::ANY)?;
    let view = make_image_view(
        device,
        image.get(),
        vk::ImageViewType::_2D,
        format,
        make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
    )?;
    let output_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(
            u64::from(RENDER_SIZE * RENDER_SIZE * 4),
            vk::BufferUsageFlags::TRANSFER_DST,
        ),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    Ok(ColorTarget {
        image,
        view,
        output_buffer,
    })
}

pub(super) fn color_range() -> vk::ImageSubresourceRange {
    make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1)
}

pub(super) fn record_pre_barrier(device: &Device, cmd: vk::CommandBuffer, image: vk::Image) {
    let barrier = make_image_memory_barrier(
        vk::AccessFlags::empty(),
        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        vk::ImageLayout::UNDEFINED,
        vk::ImageLayout::GENERAL,
        image,
        color_range(),
    );
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[barrier],
        )
    };
}

/// The image barrier after rendering, the optional shader-write barrier of the storage buffer, the copy into the output buffer and the host
/// barrier on it.
pub(super) fn record_readback(
    device: &Device,
    cmd: vk::CommandBuffer,
    target: &ColorTarget<'_>,
    storage_buffer: Option<(vk::Buffer, vk::DeviceSize)>,
) {
    let post_barrier = make_image_memory_barrier(
        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        vk::AccessFlags::TRANSFER_READ,
        vk::ImageLayout::GENERAL,
        vk::ImageLayout::GENERAL,
        target.image.get(),
        color_range(),
    );
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[post_barrier],
        )
    };

    if let Some((buffer, size)) = storage_buffer {
        let barrier = make_buffer_memory_barrier(
            vk::AccessFlags::SHADER_WRITE,
            vk::AccessFlags::HOST_READ,
            buffer,
            0,
            size,
        );
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::ALL_GRAPHICS,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[barrier],
                &[] as &[vk::ImageMemoryBarrier],
            )
        };
    }

    let copy_region = make_buffer_image_copy(
        vk::Extent3D {
            width: RENDER_SIZE,
            height: RENDER_SIZE,
            depth: 1,
        },
        make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
    );
    let copy_barrier = make_buffer_memory_barrier(
        vk::AccessFlags::TRANSFER_WRITE,
        vk::AccessFlags::HOST_READ,
        target.output_buffer.get(),
        0,
        vk::WHOLE_SIZE,
    );
    unsafe {
        device.cmd_copy_image_to_buffer(
            cmd,
            target.image.get(),
            vk::ImageLayout::GENERAL,
            target.output_buffer.get(),
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
        )
    };
}

pub(super) fn clear_black() -> vk::ClearValue {
    vk::ClearValue {
        color: vk::ClearColorValue {
            float32: [0.0, 0.0, 0.0, 1.0],
        },
    }
}

pub(super) fn read_pixels<'a>(target: &'a ColorTarget<'_>) -> &'a [u8] {
    unsafe {
        std::slice::from_raw_parts(
            target.output_buffer.get_allocation().get_host_ptr().cast_const(),
            (RENDER_SIZE * RENDER_SIZE * 4) as usize,
        )
    }
}

/// The two-stage creation both link instances share: the linked create infos go in one call (or one by one), an optional random pair of
/// them swapped on the way in and swapped back on the way out. Returns the handles in create-info order.
fn create_linked_shaders(
    device: &Device,
    create_infos: &mut [vk::ShaderCreateInfoEXT],
    random_order: bool,
    separate: bool,
) -> Vec<vk::ShaderEXT> {
    let mut shaders = vec![vk::ShaderEXT::null(); create_infos.len()];
    let mut i = 0;
    let mut j = 0;
    if random_order && create_infos.len() > 1 {
        let mut random = Random::new(102030);
        i = random.get_uint32() as usize % shaders.len();
        loop {
            j = random.get_uint32() as usize % shaders.len();
            if i != j {
                break;
            }
        }
        create_infos.swap(i, j);
    }
    if separate {
        for k in 0..shaders.len() {
            create_shaders_raw(device, &create_infos[k..k + 1], &mut shaders[k..k + 1]);
        }
    } else {
        create_shaders_raw(device, create_infos, &mut shaders);
    }
    if random_order && create_infos.len() > 1 {
        shaders.swap(i, j);
    }
    shaders
}

pub(super) fn create_unlinked_shader(device: &Device, create_info: &vk::ShaderCreateInfoEXT) -> vk::ShaderEXT {
    let mut shader = [vk::ShaderEXT::null()];
    create_shaders_raw(device, std::slice::from_ref(create_info), &mut shader);
    shader[0]
}

#[derive(Default)]
struct BindLists {
    together_stages: Vec<vk::ShaderStageFlags>,
    together_shaders: Vec<vk::ShaderEXT>,
    separate_stages: Vec<vk::ShaderStageFlags>,
    separate_shaders: Vec<vk::ShaderEXT>,
    linked_added: bool,
}

impl BindLists {
    /// One of the five identical blocks of the ONE_LINKED_UNLINKED branch.
    fn add(&mut self, shader_type: ShaderType, stage: vk::ShaderStageFlags, shader: vk::ShaderEXT) {
        if (!self.linked_added && shader_type == Linked) || shader_type == Unlinked {
            self.together_stages.push(stage);
            self.together_shaders.push(shader);
            self.linked_added = true;
        } else if shader_type == Linked {
            self.separate_stages.push(stage);
            self.separate_shaders.push(shader);
        }
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// link.<shaders>.<bind type>.<order> and link.next_stage.*
// ---------------------------------------------------------------------------------------------------------------------

fn run_link(context: &Context<'_>, params: &TestParams) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let allocator = context.get_default_allocator();
    let extensions = remove_unsupported_shader_object_extensions(context)?;
    let tessellation_supported = context.get_device_features().tessellation_shader != vk::FALSE;
    let geometry_supported = context.get_device_features().geometry_shader != vk::FALSE;
    let mesh_features = get_mesh_shader_features(context);
    let task_supported = mesh_features.task_shader != vk::FALSE;
    let mesh_supported = mesh_features.mesh_shader != vk::FALSE;

    let shaders = &params.shaders;
    let use_storage_buffer = shaders.fragment == Unused;

    let storage_buffer_stage = if !use_storage_buffer {
        None
    } else if shaders.geometry != Unused {
        Some(vk::ShaderStageFlags::GEOMETRY)
    } else if shaders.tessellation_evaluation != Unused {
        Some(vk::ShaderStageFlags::TESSELLATION_EVALUATION)
    } else {
        Some(vk::ShaderStageFlags::VERTEX)
    };

    let target = create_color_target(context)?;

    let layout_indices: [usize; 4] = if params.same_layout { [0, 0, 0, 0] } else { [0, 1, 2, 3] };
    let buffer_size_bytes = (std::mem::size_of::<u32>() as u64) * u64::from(DRAW_COUNT);

    let mut storage_buffer = None;
    let mut descriptor_set_layouts = Vec::new();
    let mut _descriptor_pool = None;
    let mut descriptor_set = None;
    let mut pipeline_layout = None;
    let mut set_layout_handles: Vec<vk::DescriptorSetLayout> = Vec::new();
    if use_storage_buffer {
        let buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(buffer_size_bytes, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let layout_count = if params.same_layout { 1 } else { 4 };
        for _ in 0..layout_count {
            descriptor_set_layouts.push(
                DescriptorSetLayoutBuilder::new()
                    .add_single_binding(
                        vk::DescriptorType::STORAGE_BUFFER,
                        vk::ShaderStageFlags::VERTEX
                            | vk::ShaderStageFlags::TESSELLATION_EVALUATION
                            | vk::ShaderStageFlags::GEOMETRY,
                    )
                    .build(device)?,
            );
        }
        set_layout_handles = descriptor_set_layouts.iter().map(|layout| **layout).collect();

        let pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let set = make_descriptor_set(device, *pool, set_layout_handles[0])?;

        let buffer_info = [vk::DescriptorBufferInfo {
            buffer: buffer.get(),
            offset: 0,
            range: buffer_size_bytes,
        }];
        let write = vk::WriteDescriptorSet::builder()
            .dst_set(set.get())
            .dst_binding(0)
            .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
            .buffer_info(&buffer_info)
            .build();
        unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

        pipeline_layout = Some(make_pipeline_layout(device, &set_layout_handles[..1])?);
        _descriptor_pool = Some(pool);
        descriptor_set = Some(set);
        storage_buffer = Some(buffer);
    }

    let binaries = context.get_binary_collection();
    let vert = binaries.get(if storage_buffer_stage == Some(vk::ShaderStageFlags::VERTEX) {
        "vert2"
    } else {
        "vert"
    })?;
    let tesc = binaries.get("tesc")?;
    let tese = binaries.get(
        if storage_buffer_stage == Some(vk::ShaderStageFlags::TESSELLATION_EVALUATION) {
            "tese2"
        } else {
            "tese"
        },
    )?;
    let geom = binaries.get(if storage_buffer_stage == Some(vk::ShaderStageFlags::GEOMETRY) {
        "geom2"
    } else {
        "geom"
    })?;
    let frag = binaries.get("frag")?;
    let comp = binaries.get("comp2")?;

    let mut create_infos: Vec<vk::ShaderCreateInfoEXT> = Vec::new();

    // Each stage: the create info, the layout it uses when the storage buffer is on, how it is created
    let stage_setup = [
        (vk::ShaderStageFlags::VERTEX, &vert, shaders.vertex, layout_indices[0]),
        (
            vk::ShaderStageFlags::TESSELLATION_CONTROL,
            &tesc,
            shaders.tessellation_control,
            layout_indices[1],
        ),
        (
            vk::ShaderStageFlags::TESSELLATION_EVALUATION,
            &tese,
            shaders.tessellation_evaluation,
            layout_indices[2],
        ),
        (
            vk::ShaderStageFlags::GEOMETRY,
            &geom,
            shaders.geometry,
            layout_indices[3],
        ),
        (vk::ShaderStageFlags::FRAGMENT, &frag, shaders.fragment, 0),
    ];
    let mut unlinked_handles = [vk::ShaderEXT::null(); 5];
    for (index, &(stage, binary, shader_type, layout_index)) in stage_setup.iter().enumerate() {
        let mut create_info =
            make_shader_create_info(stage, binary, tessellation_supported, geometry_supported, None, None);
        create_info.next_stage = get_next_stage(params, stage);
        if use_storage_buffer && stage != vk::ShaderStageFlags::FRAGMENT {
            create_info.set_layout_count = 1;
            create_info.set_layouts = &set_layout_handles[layout_index];
        }

        if shader_type == Linked {
            create_info.flags = vk::ShaderCreateFlagsEXT::LINK_STAGE;
            create_infos.push(create_info);
        } else if shader_type == Unlinked {
            unlinked_handles[index] = create_unlinked_shader(device, &create_info);
        }
    }
    let [
        mut vert_shader,
        mut tesc_shader,
        mut tese_shader,
        mut geom_shader,
        mut frag_shader,
    ] = unlinked_handles;
    let mut comp_shader = vk::ShaderEXT::null();

    let comp_create_info = make_shader_create_info(
        vk::ShaderStageFlags::COMPUTE,
        &comp,
        tessellation_supported,
        geometry_supported,
        None,
        None,
    );
    if !create_infos.is_empty() {
        create_infos.push(comp_create_info);
    }

    let primitive_topology = if shaders.tessellation_control != Unused {
        vk::PrimitiveTopology::PATCH_LIST
    } else {
        vk::PrimitiveTopology::TRIANGLE_STRIP
    };

    if !create_infos.is_empty() {
        let linked = create_linked_shaders(device, &mut create_infos, params.random_order, params.separate_linked);
        let mut n = 0;
        if shaders.vertex == Linked {
            vert_shader = linked[n];
            n += 1;
        }
        if shaders.tessellation_control == Linked {
            tesc_shader = linked[n];
            n += 1;
        }
        if shaders.tessellation_evaluation == Linked {
            tese_shader = linked[n];
            n += 1;
        }
        if shaders.geometry == Linked {
            geom_shader = linked[n];
            n += 1;
        }
        if shaders.fragment == Linked {
            frag_shader = linked[n];
            n += 1;
        }
        comp_shader = linked[n];
    }

    let owned_shaders: Vec<ShaderObject<'_>> = [
        (shaders.vertex, vert_shader),
        (shaders.tessellation_control, tesc_shader),
        (shaders.tessellation_evaluation, tese_shader),
        (shaders.geometry, geom_shader),
        (shaders.fragment, frag_shader),
    ]
    .into_iter()
    .filter(|&(shader_type, _)| shader_type != Unused)
    .map(|(_, handle)| ShaderObject::new(device, handle))
    .chain((comp_shader != vk::ShaderEXT::null()).then(|| ShaderObject::new(device, comp_shader)))
    .collect();

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    begin_command_buffer(device, cmd)?;
    record_pre_barrier(device, cmd, target.image.get());

    let stage_for = |stage: vk::ShaderStageFlags,
                     shader_type: ShaderType,
                     handle: vk::ShaderEXT|
     -> (vk::ShaderStageFlags, vk::ShaderEXT) {
        (
            stage,
            if shader_type != Unused {
                handle
            } else {
                vk::ShaderEXT::null()
            },
        )
    };
    match params.separate_bind {
        BindType::Separate => {
            let binds = [
                stage_for(vk::ShaderStageFlags::VERTEX, shaders.vertex, vert_shader),
                stage_for(
                    vk::ShaderStageFlags::TESSELLATION_CONTROL,
                    shaders.tessellation_control,
                    tesc_shader,
                ),
                stage_for(
                    vk::ShaderStageFlags::TESSELLATION_EVALUATION,
                    shaders.tessellation_evaluation,
                    tese_shader,
                ),
                stage_for(vk::ShaderStageFlags::GEOMETRY, shaders.geometry, geom_shader),
                stage_for(vk::ShaderStageFlags::FRAGMENT, shaders.fragment, frag_shader),
            ];
            for (stage, handle) in binds {
                unsafe { device.cmd_bind_shaders_ext(cmd, &[stage], &[handle]) };
            }
        }
        BindType::OneLinkedUnlinked => {
            let mut lists = BindLists::default();
            lists.add(shaders.vertex, vk::ShaderStageFlags::VERTEX, vert_shader);
            lists.add(
                shaders.tessellation_control,
                vk::ShaderStageFlags::TESSELLATION_CONTROL,
                tesc_shader,
            );
            lists.add(
                shaders.tessellation_evaluation,
                vk::ShaderStageFlags::TESSELLATION_EVALUATION,
                tese_shader,
            );
            lists.add(shaders.geometry, vk::ShaderStageFlags::GEOMETRY, geom_shader);
            lists.add(shaders.fragment, vk::ShaderStageFlags::FRAGMENT, frag_shader);

            let null = vk::ShaderEXT::null();
            bind_graphics_shaders(
                device,
                cmd,
                null,
                null,
                null,
                null,
                null,
                task_supported,
                mesh_supported,
            );
            unsafe {
                if !lists.together_shaders.is_empty() {
                    device.cmd_bind_shaders_ext(cmd, &lists.together_stages, &lists.together_shaders);
                }
                if !lists.separate_shaders.is_empty() {
                    device.cmd_bind_shaders_ext(cmd, &lists.separate_stages, &lists.separate_shaders);
                }
            }
        }
        BindType::All => {
            let used = |shader_type: ShaderType, handle: vk::ShaderEXT| {
                if shader_type != Unused {
                    handle
                } else {
                    vk::ShaderEXT::null()
                }
            };
            bind_graphics_shaders(
                device,
                cmd,
                used(shaders.vertex, vert_shader),
                used(shaders.tessellation_control, tesc_shader),
                used(shaders.tessellation_evaluation, tese_shader),
                used(shaders.geometry, geom_shader),
                used(shaders.fragment, frag_shader),
                task_supported,
                mesh_supported,
            );
        }
    }
    set_default_shader_object_dynamic_states(
        device,
        cmd,
        &extensions,
        primitive_topology,
        false,
        false,
        RENDER_SIZE,
        RENDER_SIZE,
    );

    bind_null_task_mesh_shaders(device, cmd, &mesh_features);

    begin_rendering(
        device,
        cmd,
        *target.view,
        rect_2d(RENDER_SIZE, RENDER_SIZE),
        clear_black(),
        vk::ImageLayout::GENERAL,
        vk::AttachmentLoadOp::CLEAR,
        vk::RenderingFlags::empty(),
        1,
        0,
    );
    if let (Some(layout), Some(set)) = (&pipeline_layout, &descriptor_set) {
        unsafe {
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                layout.get(),
                0,
                &[set.get()],
                &[] as &[u32],
            )
        };
    }
    unsafe { device.cmd_draw(cmd, DRAW_COUNT, 1, 0, 0) };
    end_rendering(device, cmd);

    record_readback(
        device,
        cmd,
        &target,
        storage_buffer.as_ref().map(|buffer| (buffer.get(), vk::WHOLE_SIZE)),
    );

    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, queue, cmd)?;

    invalidate_alloc(device, target.output_buffer.get_allocation())?;

    drop(owned_shaders);

    let x_offset = if shaders.tessellation_control != Unused { 4 } else { 8 };
    let y_offset = if shaders.geometry != Unused { 4 } else { 8 };

    if shaders.fragment != Unused {
        let pixels = read_pixels(&target);
        let size = RENDER_SIZE as usize;
        for j in 0..size {
            for i in 0..size {
                let offset = (j * size + i) * 4;
                let color = &pixels[offset..offset + 4];
                if i >= x_offset && i < size - x_offset && j >= y_offset && j < size - y_offset {
                    if color != [255, 255, 255, 255] {
                        log::info!("Color at ({i}, {j}) is expected to be (1.0, 1.0, 1.0, 1.0), but was ({color:?})");
                        return Ok(TestStatus::fail("Fail"));
                    }
                } else if color != [0, 0, 0, 255] {
                    log::info!("Color at ({i}, {j}) is expected to be (0.0, 0.0, 0.0, 0.0), but was ({color:?})");
                    return Ok(TestStatus::fail("Fail"));
                }
            }
        }
    } else if let Some(buffer) = &storage_buffer {
        let allocation = buffer.get_allocation();
        invalidate_alloc(device, allocation)?;

        let result = unsafe {
            std::slice::from_raw_parts(
                allocation.get_host_ptr().cast_const().cast::<u32>(),
                DRAW_COUNT as usize,
            )
        };
        for i in 0..DRAW_COUNT as usize {
            if result[i] != i as u32 + 1 {
                log::info!(
                    "Buffer value at [{i}] is expected to be {}, but was ({})",
                    i + 1,
                    result[i]
                );
                return Ok(TestStatus::fail("Fail"));
            }
        }
    }

    Ok(TestStatus::pass("Pass"))
}

struct ShaderObjectLinkCase {
    name: String,
    params: TestParams,
}

impl TestCase for ShaderObjectLinkCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_shader_object")?;

        // Upstream's `(nextStage | BIT) > 0` is true for every value, so both features are required by every case
        let tessellation_required = self.params.shaders.tessellation_control != Unused
            || self.params.shaders.tessellation_evaluation != Unused
            || !(self.params.next_stages.vert_next_stage | vk::ShaderStageFlags::TESSELLATION_CONTROL).is_empty();
        if tessellation_required && context.get_device_features().tessellation_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "tessellationShader feature not supported".to_string(),
            ));
        }

        let geometry_required = self.params.shaders.geometry != Unused
            || !(self.params.next_stages.vert_next_stage | vk::ShaderStageFlags::GEOMETRY).is_empty()
            || !(self.params.next_stages.tese_next_stage | vk::ShaderStageFlags::GEOMETRY).is_empty();
        if geometry_required && context.get_device_features().geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "geometryShader feature not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        SHADER_OBJECT_LINK.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ShaderObjectLinkInstance {
            context,
            params: self.params,
        })
    }
}

struct ShaderObjectLinkInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

impl TestInstance for ShaderObjectLinkInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        run_link(self.context, &self.params)
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// link.mesh_*
// ---------------------------------------------------------------------------------------------------------------------

/// `MeshShaderObjectLinkInstance::getNextStage`
fn get_mesh_next_stage(params: &MeshParams, current_stage: vk::ShaderStageFlags) -> vk::ShaderStageFlags {
    if current_stage == vk::ShaderStageFlags::TASK_EXT {
        if params.shaders.task == Linked {
            return vk::ShaderStageFlags::MESH_EXT;
        }
        return params.task_next_stage;
    }
    if current_stage == vk::ShaderStageFlags::MESH_EXT {
        if params.shaders.mesh == Linked {
            return vk::ShaderStageFlags::FRAGMENT;
        }
        return params.mesh_next_stage;
    }
    vk::ShaderStageFlags::empty()
}

fn run_mesh_link(context: &Context<'_>, params: &MeshParams) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let allocator = context.get_default_allocator();
    let extensions = remove_unsupported_shader_object_extensions(context)?;
    let shaders = &params.shaders;

    let target = create_color_target(context)?;

    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::MESH_EXT)
        .build(device)?;
    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;

    let buffer_size_bytes = (std::mem::size_of::<u32>() * 4) as u64;
    let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
    let output_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(buffer_size_bytes, vk::BufferUsageFlags::STORAGE_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    let buffer_info = [vk::DescriptorBufferInfo {
        buffer: output_buffer.get(),
        offset: 0,
        range: buffer_size_bytes,
    }];
    let write = vk::WriteDescriptorSet::builder()
        .dst_set(descriptor_set.get())
        .dst_binding(0)
        .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
        .buffer_info(&buffer_info)
        .build();
    unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

    let set_layout = [*descriptor_set_layout];
    let pipeline_layout = make_pipeline_layout(device, &set_layout)?;

    let binaries = context.get_binary_collection();
    let task = binaries.get("task")?;
    let mesh = binaries.get("mesh")?;
    let frag = binaries.get("frag")?;
    let comp = binaries.get("comp2")?;

    let mesh_info =
        |binary: &crate::vk::programs::ProgramBinary, flags: vk::ShaderCreateFlagsEXT, stage: vk::ShaderStageFlags| {
            shader_create_info(
                flags,
                stage,
                get_mesh_next_stage(params, stage),
                vk::ShaderCodeTypeEXT::SPIRV,
                std::mem::size_of_val(binary.spirv),
                binary.spirv.as_ptr().cast(),
                &set_layout,
                &[],
            )
        };

    let mut task_shader = vk::ShaderEXT::null();
    let mut mesh_shader = vk::ShaderEXT::null();
    let mut frag_shader = vk::ShaderEXT::null();
    let mut comp_shader = vk::ShaderEXT::null();

    let mut create_infos: Vec<vk::ShaderCreateInfoEXT> = Vec::new();

    let mut task_info = mesh_info(&task, vk::ShaderCreateFlagsEXT::empty(), vk::ShaderStageFlags::TASK_EXT);
    if shaders.task == Linked {
        task_info.flags = vk::ShaderCreateFlagsEXT::LINK_STAGE;
        create_infos.push(task_info);
    } else if shaders.task == Unlinked {
        task_shader = create_unlinked_shader(device, &task_info);
    }

    let mesh_flags = if shaders.task == Unused {
        vk::ShaderCreateFlagsEXT::NO_TASK_SHADER
    } else {
        vk::ShaderCreateFlagsEXT::empty()
    };
    let mut mesh_info_value = mesh_info(&mesh, mesh_flags, vk::ShaderStageFlags::MESH_EXT);
    if shaders.mesh == Linked {
        mesh_info_value.flags = vk::ShaderCreateFlagsEXT::LINK_STAGE;
        create_infos.push(mesh_info_value);
    } else if shaders.mesh == Unlinked {
        mesh_shader = create_unlinked_shader(device, &mesh_info_value);
    }

    let mut frag_info = mesh_info(&frag, vk::ShaderCreateFlagsEXT::empty(), vk::ShaderStageFlags::FRAGMENT);
    if shaders.fragment == Linked {
        frag_info.flags = vk::ShaderCreateFlagsEXT::LINK_STAGE;
        create_infos.push(frag_info);
    } else if shaders.fragment == Unlinked {
        frag_shader = create_unlinked_shader(device, &frag_info);
    }

    let comp_info = make_shader_create_info(vk::ShaderStageFlags::COMPUTE, &comp, false, false, None, None);
    if !create_infos.is_empty() {
        create_infos.push(comp_info);
    }

    if !create_infos.is_empty() {
        let linked = create_linked_shaders(device, &mut create_infos, params.random_order, false);
        let mut n = 0;
        if shaders.task == Linked {
            task_shader = linked[n];
            n += 1;
        }
        if shaders.mesh == Linked {
            mesh_shader = linked[n];
            n += 1;
        }
        if shaders.fragment == Linked {
            frag_shader = linked[n];
            n += 1;
        }
        comp_shader = linked[n];
    }

    let owned_shaders: Vec<ShaderObject<'_>> = [
        (shaders.task, task_shader),
        (shaders.mesh, mesh_shader),
        (shaders.fragment, frag_shader),
    ]
    .into_iter()
    .filter(|&(shader_type, _)| shader_type != Unused)
    .map(|(_, handle)| ShaderObject::new(device, handle))
    .chain((comp_shader != vk::ShaderEXT::null()).then(|| ShaderObject::new(device, comp_shader)))
    .collect();

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    begin_command_buffer(device, cmd)?;
    record_pre_barrier(device, cmd, target.image.get());

    begin_rendering(
        device,
        cmd,
        *target.view,
        rect_2d(RENDER_SIZE, RENDER_SIZE),
        clear_black(),
        vk::ImageLayout::GENERAL,
        vk::AttachmentLoadOp::CLEAR,
        vk::RenderingFlags::empty(),
        1,
        0,
    );
    set_default_shader_object_dynamic_states(
        device,
        cmd,
        &extensions,
        vk::PrimitiveTopology::TRIANGLE_LIST,
        true,
        false,
        RENDER_SIZE,
        RENDER_SIZE,
    );
    unsafe {
        device.cmd_bind_descriptor_sets(
            cmd,
            vk::PipelineBindPoint::GRAPHICS,
            pipeline_layout.get(),
            0,
            &[descriptor_set.get()],
            &[] as &[u32],
        )
    };

    bind_null_rasterization_shaders(device, cmd, context.get_device_features());
    let used = |shader_type: ShaderType, handle: vk::ShaderEXT| {
        if shader_type != Unused {
            handle
        } else {
            vk::ShaderEXT::null()
        }
    };
    let stages = [
        vk::ShaderStageFlags::TASK_EXT,
        vk::ShaderStageFlags::MESH_EXT,
        vk::ShaderStageFlags::FRAGMENT,
    ];
    let handles = [
        used(shaders.task, task_shader),
        used(shaders.mesh, mesh_shader),
        used(shaders.fragment, frag_shader),
    ];
    unsafe {
        device.cmd_bind_shaders_ext(cmd, &stages, &handles);
        device.cmd_draw_mesh_tasks_ext(cmd, 1, 1, 1);
    }
    end_rendering(device, cmd);

    record_readback(device, cmd, &target, None);
    let output_barrier = make_buffer_memory_barrier(
        vk::AccessFlags::SHADER_WRITE,
        vk::AccessFlags::HOST_READ,
        output_buffer.get(),
        0,
        buffer_size_bytes,
    );
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::ALL_GRAPHICS,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[output_barrier],
            &[] as &[vk::ImageMemoryBarrier],
        )
    };

    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, queue, cmd)?;

    invalidate_alloc(device, target.output_buffer.get_allocation())?;

    drop(owned_shaders);

    if shaders.fragment != Unused {
        let pixels = read_pixels(&target);
        let size = RENDER_SIZE as usize;
        for j in 0..size {
            for i in 0..size {
                let offset = (j * size + i) * 4;
                let color = &pixels[offset..offset + 4];
                if color != [255, 255, 255, 255] {
                    log::info!("Color at ({i}, {j}) is expected to be (1.0, 1.0, 1.0, 1.0), but was ({color:?})");
                    return Ok(TestStatus::fail("Fail"));
                }
            }
        }
    }
    if shaders.mesh != Unused {
        let allocation = output_buffer.get_allocation();
        invalidate_alloc(device, allocation)?;

        let values = unsafe { std::slice::from_raw_parts(allocation.get_host_ptr().cast_const().cast::<u32>(), 4) };
        if values[0] != 0 || values[1] != 1 || values[2] != 2 || values[3] != 3 {
            log::info!(
                "Buffer values were expected to be [0, 1, 2, 3], but were[{}, {}, {}, {}, ]",
                values[0],
                values[1],
                values[2],
                values[3]
            );
            return Ok(TestStatus::fail("Fail"));
        }
    }

    Ok(TestStatus::pass("Pass"))
}

struct MeshShaderObjectLinkCase {
    name: &'static str,
    params: MeshParams,
}

impl TestCase for MeshShaderObjectLinkCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_shader_object")?;
        context.require_device_functionality("VK_EXT_mesh_shader")?;

        let features = get_mesh_shader_features(context);
        if features.task_shader == vk::FALSE {
            return Err(TestError::NotSupported("Task shaders not supported".to_string()));
        }
        if features.mesh_shader == vk::FALSE {
            return Err(TestError::NotSupported("Mesh shaders not supported".to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        SHADER_OBJECT_LINK_MESH.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MeshShaderObjectLinkInstance {
            context,
            params: self.params,
        })
    }
}

struct MeshShaderObjectLinkInstance<'a> {
    context: &'a Context<'a>,
    params: MeshParams,
}

impl TestInstance for MeshShaderObjectLinkInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        run_mesh_link(self.context, &self.params)
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// createShaderObjectLinkTests
// ---------------------------------------------------------------------------------------------------------------------

/// `createShaderObjectLinkTests`
pub fn create_shader_object_link_tests() -> TestCaseGroup {
    let mut link_group = TestCaseGroup::new("link");

    let shader_tests = [
        Shaders {
            vertex: Linked,
            tessellation_control: Linked,
            tessellation_evaluation: Unlinked,
            geometry: Unused,
            fragment: Unlinked,
        },
        Shaders {
            vertex: Linked,
            tessellation_control: Linked,
            tessellation_evaluation: Linked,
            geometry: Unused,
            fragment: Unlinked,
        },
        Shaders {
            vertex: Linked,
            tessellation_control: Linked,
            tessellation_evaluation: Linked,
            geometry: Unlinked,
            fragment: Unlinked,
        },
        Shaders {
            vertex: Linked,
            tessellation_control: Linked,
            tessellation_evaluation: Linked,
            geometry: Linked,
            fragment: Unlinked,
        },
        Shaders {
            vertex: Linked,
            tessellation_control: Linked,
            tessellation_evaluation: Linked,
            geometry: Linked,
            fragment: Linked,
        },
        Shaders {
            vertex: Linked,
            tessellation_control: Unused,
            tessellation_evaluation: Unused,
            geometry: Linked,
            fragment: Unlinked,
        },
        Shaders {
            vertex: Linked,
            tessellation_control: Unused,
            tessellation_evaluation: Unused,
            geometry: Linked,
            fragment: Linked,
        },
        Shaders {
            vertex: Linked,
            tessellation_control: Unused,
            tessellation_evaluation: Unused,
            geometry: Unused,
            fragment: Linked,
        },
        Shaders {
            vertex: Unlinked,
            tessellation_control: Unlinked,
            tessellation_evaluation: Unlinked,
            geometry: Unused,
            fragment: Unlinked,
        },
        Shaders {
            vertex: Unlinked,
            tessellation_control: Unused,
            tessellation_evaluation: Unused,
            geometry: Unlinked,
            fragment: Unlinked,
        },
        Shaders {
            vertex: Unlinked,
            tessellation_control: Unused,
            tessellation_evaluation: Unused,
            geometry: Unused,
            fragment: Unlinked,
        },
        Shaders {
            vertex: Unlinked,
            tessellation_control: Linked,
            tessellation_evaluation: Linked,
            geometry: Unused,
            fragment: Unlinked,
        },
        Shaders {
            vertex: Unlinked,
            tessellation_control: Linked,
            tessellation_evaluation: Linked,
            geometry: Linked,
            fragment: Unlinked,
        },
        Shaders {
            vertex: Unlinked,
            tessellation_control: Linked,
            tessellation_evaluation: Linked,
            geometry: Unused,
            fragment: Linked,
        },
        Shaders {
            vertex: Unlinked,
            tessellation_control: Linked,
            tessellation_evaluation: Linked,
            geometry: Linked,
            fragment: Linked,
        },
        Shaders {
            vertex: Unlinked,
            tessellation_control: Unused,
            tessellation_evaluation: Unused,
            geometry: Linked,
            fragment: Linked,
        },
    ];

    let random_order_tests = [false, true];

    let bind_type_tests = [
        (BindType::Separate, "separate"),
        (BindType::OneLinkedUnlinked, "one_linked_unlinked"),
        (BindType::All, "all"),
    ];

    for shaders in shader_tests {
        let shaders_name = format!(
            "{}_{}_{}_{}_{}",
            type_to_string(shaders.vertex),
            type_to_string(shaders.tessellation_control),
            type_to_string(shaders.tessellation_evaluation),
            type_to_string(shaders.geometry),
            type_to_string(shaders.fragment)
        );
        let mut shaders_group = TestCaseGroup::new(shaders_name);

        for (bind_type, bind_name) in bind_type_tests {
            let mut bind_group = TestCaseGroup::new(bind_name);
            for random_order in random_order_tests {
                let mut next_stages = NextStages::default();
                if shaders.tessellation_control != Unused {
                    next_stages.vert_next_stage |= vk::ShaderStageFlags::TESSELLATION_CONTROL;
                    next_stages.tesc_next_stage |= vk::ShaderStageFlags::TESSELLATION_EVALUATION;
                }
                if shaders.geometry != Unused {
                    next_stages.vert_next_stage |= vk::ShaderStageFlags::GEOMETRY;
                    next_stages.tese_next_stage |= vk::ShaderStageFlags::GEOMETRY;
                }
                if shaders.fragment != Unused {
                    next_stages.vert_next_stage |= vk::ShaderStageFlags::FRAGMENT;
                    next_stages.tese_next_stage |= vk::ShaderStageFlags::FRAGMENT;
                    next_stages.geom_next_stage |= vk::ShaderStageFlags::FRAGMENT;
                }

                let params = TestParams {
                    shaders,
                    random_order,
                    next_stages,
                    separate_linked: false,
                    separate_bind: bind_type,
                    same_layout: true,
                };
                let name = if random_order { "random_order" } else { "default" };
                bind_group.add_child(Box::new(ShaderObjectLinkCase {
                    name: name.to_string(),
                    params,
                }) as Box<dyn TestCase>);
            }

            if shaders.vertex == Linked
                || shaders.tessellation_control == Linked
                || shaders.tessellation_evaluation == Linked
                || shaders.geometry == Linked
                || shaders.fragment == Linked
            {
                let params = TestParams {
                    shaders,
                    random_order: false,
                    next_stages: NextStages {
                        vert_next_stage: vk::ShaderStageFlags::TESSELLATION_CONTROL
                            | vk::ShaderStageFlags::GEOMETRY
                            | vk::ShaderStageFlags::FRAGMENT,
                        tesc_next_stage: vk::ShaderStageFlags::TESSELLATION_EVALUATION,
                        tese_next_stage: vk::ShaderStageFlags::GEOMETRY | vk::ShaderStageFlags::FRAGMENT,
                        geom_next_stage: vk::ShaderStageFlags::FRAGMENT,
                    },
                    separate_linked: true,
                    separate_bind: BindType::All,
                    same_layout: true,
                };
                bind_group.add_child(Box::new(ShaderObjectLinkCase {
                    name: "separate_link".to_string(),
                    params,
                }) as Box<dyn TestCase>);
            }
            shaders_group.add_child(bind_group);
        }
        link_group.add_child(shaders_group);
    }

    let tesc = vk::ShaderStageFlags::TESSELLATION_CONTROL;
    let tese = vk::ShaderStageFlags::TESSELLATION_EVALUATION;
    let geom = vk::ShaderStageFlags::GEOMETRY;
    let frag = vk::ShaderStageFlags::FRAGMENT;
    let none = vk::ShaderStageFlags::empty();
    let all_unlinked = Shaders {
        vertex: Unlinked,
        tessellation_control: Unlinked,
        tessellation_evaluation: Unlinked,
        geometry: Unlinked,
        fragment: Unlinked,
    };
    let vert_frag = Shaders {
        vertex: Unlinked,
        tessellation_control: Unused,
        tessellation_evaluation: Unused,
        geometry: Unused,
        fragment: Unlinked,
    };
    let vert_geom_frag = Shaders {
        vertex: Unlinked,
        tessellation_control: Unused,
        tessellation_evaluation: Unused,
        geometry: Unlinked,
        fragment: Unlinked,
    };
    let vert_tess_frag = Shaders {
        vertex: Unlinked,
        tessellation_control: Unlinked,
        tessellation_evaluation: Unlinked,
        geometry: Unused,
        fragment: Unlinked,
    };
    let no_frag = |tessellation: ShaderType, geometry: ShaderType| Shaders {
        vertex: Unlinked,
        tessellation_control: tessellation,
        tessellation_evaluation: tessellation,
        geometry,
        fragment: Unused,
    };
    let stages = |vert_next_stage, tesc_next_stage, tese_next_stage, geom_next_stage| NextStages {
        vert_next_stage,
        tesc_next_stage,
        tese_next_stage,
        geom_next_stage,
    };

    let next_stage_tests = [
        (vert_frag, stages(tesc | frag, tese, frag, none), true, "vert_t"),
        (vert_geom_frag, stages(geom, none, none, frag), true, "vert_g"),
        (all_unlinked, stages(tesc | geom, tese, geom, frag), true, "vert_tg"),
        (vert_frag, stages(frag, none, none, none), true, "vert_f"),
        (vert_tess_frag, stages(tesc | frag, tese, frag, none), true, "vert_tf"),
        (vert_geom_frag, stages(geom | frag, none, none, frag), true, "vert_gf"),
        (
            all_unlinked,
            stages(tesc | geom | frag, tese, geom, frag),
            true,
            "vert_tgf",
        ),
        (vert_tess_frag, stages(tesc, tese, frag, none), true, "tesc_t"),
        (all_unlinked, stages(tesc, tese, geom, frag), true, "tese_g"),
        (vert_tess_frag, stages(tesc, tese, frag, none), true, "tese_f"),
        (all_unlinked, stages(tesc, tese, geom | frag, frag), true, "tese_gf"),
        (vert_geom_frag, stages(geom, none, none, frag), true, "geom_f"),
        (
            no_frag(Unused, Unused),
            stages(tesc, none, none, none),
            true,
            "vert_no_frag",
        ),
        (
            no_frag(Unlinked, Unused),
            stages(tesc, tese, none, none),
            true,
            "tess_no_frag",
        ),
        (
            no_frag(Unlinked, Unlinked),
            stages(tesc, tese, geom, none),
            true,
            "geom_no_frag",
        ),
        (
            no_frag(Unlinked, Unlinked),
            stages(tesc, tese, geom, none),
            false,
            "identically_defined_layouts",
        ),
    ];

    let mut next_stage_group = TestCaseGroup::new("next_stage");
    for (shaders, next_stages, same_layout, name) in next_stage_tests {
        let params = TestParams {
            shaders,
            random_order: false,
            next_stages,
            separate_linked: false,
            separate_bind: BindType::All,
            same_layout,
        };
        next_stage_group.add_child(Box::new(ShaderObjectLinkCase {
            name: name.to_string(),
            params,
        }) as Box<dyn TestCase>);
    }
    link_group.add_child(next_stage_group);

    let mesh_shader_tests = [
        MeshShaders {
            task: Unlinked,
            mesh: Unlinked,
            fragment: Unlinked,
        },
        MeshShaders {
            task: Unlinked,
            mesh: Unlinked,
            fragment: Unused,
        },
        MeshShaders {
            task: Linked,
            mesh: Linked,
            fragment: Unlinked,
        },
        MeshShaders {
            task: Unlinked,
            mesh: Linked,
            fragment: Linked,
        },
        MeshShaders {
            task: Linked,
            mesh: Linked,
            fragment: Linked,
        },
    ];

    for mesh_shaders in mesh_shader_tests {
        let name = format!(
            "mesh_{}_{}_{}",
            type_to_string(mesh_shaders.task),
            type_to_string(mesh_shaders.mesh),
            type_to_string(mesh_shaders.fragment)
        );
        let mut mesh_group = TestCaseGroup::new(name);

        for random_order in random_order_tests {
            let task_next_stage = if mesh_shaders.mesh != Unused {
                vk::ShaderStageFlags::MESH_EXT
            } else {
                none
            };
            let mesh_next_stage = if mesh_shaders.fragment != Unused {
                vk::ShaderStageFlags::FRAGMENT
            } else {
                none
            };
            let params = MeshParams {
                shaders: mesh_shaders,
                random_order,
                task_next_stage,
                mesh_next_stage,
            };
            let case_name = if random_order { "random_order" } else { "default" };
            mesh_group.add_child(Box::new(MeshShaderObjectLinkCase {
                name: case_name,
                params,
            }) as Box<dyn TestCase>);
        }
        link_group.add_child(mesh_group);
    }

    link_group
}
