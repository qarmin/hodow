// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineNoPositionTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2019 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Not ported: `device_index_as_view_index` (a custom device group instance).

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::generated::shaders::pipeline_no_position::ALL_NO_POSITION_PROGRAMS;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_framebuffer, make_memory_barrier, make_pipeline_layout,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{DrawPipelineState, clear_value_color, create_draw_pipeline, rect_2d};
use crate::vkt::tests::pipeline::shader_object_draw::{begin_draw, end_draw, make_shader_objects_stages};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const STAGE_VERTEX: u32 = 1 << 0;
const STAGE_TESS_CONTROL: u32 = 1 << 1;
const STAGE_TESS_EVALUATION: u32 = 1 << 2;
const STAGE_GEOMETRY: u32 = 1 << 3;
const STAGE_MASK_COUNT: u32 = 1 << 4;

const STAGE_COUNT: u32 = 4;
const FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const EXTENT: u32 = 64;
const BACKGROUND_COLOR: [u8; 4] = [0, 0, 255, 255];

/// The `rust_type` of the manifest entries.
#[derive(Clone, Copy)]
pub struct NoPositionPrograms {
    pub name: &'static str,
    pub explicit: bool,
    pub ssbo: bool,
    pub views: u32,
    pub stages: u32,
    pub writes: u32,
    pub programs: BinaryCollection,
}

/// `TestParams`
#[derive(Clone, Copy)]
struct TestParams {
    /// Stages that will be present in the pipeline.
    selected_stages: u32,
    /// Subset of `selected_stages` that will write to the Position built-in.
    write_stages: u32,
    num_views: u32,
    /// Explicitly declare the input and output blocks or not.
    explicit_declarations: bool,
    /// Write to an SSBO from the selected stages.
    use_ssbo: bool,
}

impl TestParams {
    fn tessellation(&self) -> bool {
        self.selected_stages & (STAGE_TESS_CONTROL | STAGE_TESS_EVALUATION) != 0
    }

    fn geometry(&self) -> bool {
        self.selected_stages & STAGE_GEOMETRY != 0
    }
}

/// `getWriteSubCases`: the combinations list of stage flags for writeStages when a given subset of stages are selected.
fn get_write_sub_cases(selected_stages: u32) -> Vec<u32> {
    let mut unique_cases: Vec<u32> = (0..STAGE_MASK_COUNT).map(|stages| stages & selected_stages).collect();
    unique_cases.sort_unstable();
    unique_cases.dedup();
    unique_cases
}

struct NoPositionCase {
    name: String,
    params: TestParams,
}

impl TestCase for NoPositionCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `NoPositionCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let features = context.get_device_features();
        let has_tess = self.params.tessellation();
        let has_geom = self.params.geometry();

        if has_tess && features.tessellation_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "Tessellation shaders not supported".to_string(),
            ));
        }
        if has_geom && features.geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported("Geometry shaders not supported".to_string()));
        }

        if self.params.num_views > 1 {
            context.require_device_functionality("VK_KHR_multiview")?;

            let mut multiview_features = vk::PhysicalDeviceMultiviewFeatures::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut multiview_features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
            if multiview_features.multiview == vk::FALSE {
                return Err(TestError::NotSupported("Multiview not supported".to_string()));
            }
            if has_tess && multiview_features.multiview_tessellation_shader == vk::FALSE {
                return Err(TestError::NotSupported(
                    "Multiview not supported with tessellation shaders".to_string(),
                ));
            }
            if has_geom && multiview_features.multiview_geometry_shader == vk::FALSE {
                return Err(TestError::NotSupported(
                    "Multiview not supported with geometry shaders".to_string(),
                ));
            }

            let mut multiview_properties = vk::PhysicalDeviceMultiviewProperties::default();
            let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut multiview_properties);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
            };
            if self.params.num_views > multiview_properties.max_multiview_view_count {
                return Err(TestError::NotSupported("Not enough views supported".to_string()));
            }
        }

        if self.params.use_ssbo && features.vertex_pipeline_stores_and_atomics == vk::FALSE {
            return Err(TestError::NotSupported(
                "Vertex pipeline stores and atomics not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let params = &self.params;
        ALL_NO_POSITION_PROGRAMS
            .iter()
            .find(|p| {
                p.explicit == params.explicit_declarations
                    && p.ssbo == params.use_ssbo
                    && p.views == params.num_views
                    && p.stages == params.selected_stages
                    && p.writes == params.write_stages
            })
            .map_or_else(|| BinaryCollection::new(&[]), |p| p.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(NoPositionInstance {
            context,
            params: self.params,
        })
    }
}

struct NoPositionInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

impl TestInstance for NoPositionInstance<'_> {
    /// `NoPositionInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let num_views = params.num_views;
        let tess = params.tessellation();
        let layers = num_views;

        // Shader modules.
        let binaries = context.get_binary_collection();
        let mut modules = Vec::new();
        let mut stage_names: Vec<(vk::ShaderStageFlags, &str)> = Vec::new();
        let mut stage_flags = vk::ShaderStageFlags::empty();
        let stage_table = [
            (STAGE_VERTEX, "vert", vk::ShaderStageFlags::VERTEX),
            (STAGE_TESS_CONTROL, "tesc", vk::ShaderStageFlags::TESSELLATION_CONTROL),
            (
                STAGE_TESS_EVALUATION,
                "tese",
                vk::ShaderStageFlags::TESSELLATION_EVALUATION,
            ),
            (STAGE_GEOMETRY, "geom", vk::ShaderStageFlags::GEOMETRY),
        ];
        for (bit, name, flag) in stage_table {
            if params.selected_stages & bit != 0 {
                modules.push((flag, create_shader_module(device, binaries.get(name)?)?));
                stage_names.push((flag, name));
                stage_flags |= flag;
            }
        }
        modules.push((
            vk::ShaderStageFlags::FRAGMENT,
            create_shader_module(device, binaries.get("frag")?)?,
        ));
        stage_names.push((vk::ShaderStageFlags::FRAGMENT, "frag"));
        stage_flags |= vk::ShaderStageFlags::FRAGMENT;
        let stages: Vec<(vk::ShaderStageFlags, vk::ShaderModule)> =
            modules.iter().map(|(flag, module)| (*flag, **module)).collect();

        // Color attachment.
        let color_image_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(FORMAT)
            .extent(vk::Extent3D {
                width: EXTENT,
                height: EXTENT,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(layers)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::COLOR_ATTACHMENT)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let color_image = ImageWithMemory::new(device, allocator, color_image_info, MemoryRequirement::ANY)?;
        let subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, layers);
        let view_type = if num_views > 1 {
            vk::ImageViewType::_2D_ARRAY
        } else {
            vk::ImageViewType::_2D
        };
        let color_attachment = make_image_view(device, color_image.get(), view_type, FORMAT, subresource_range)?;

        // Vertices and vertex buffer.
        let vertices: [[f32; 4]; 3] = [[0.0, -0.5, 0.0, 1.0], [0.5, 0.5, 0.0, 1.0], [-0.5, 0.5, 0.0, 1.0]];
        let vertex_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        // Render pass, with one view mask covering every view when multiview is used.
        let view_masks = [(1u32 << num_views) - 1];
        let correlation_masks = [(1u32 << num_views) - 1];
        let mut multiview_info = vk::RenderPassMultiviewCreateInfo::builder()
            .view_masks(&view_masks)
            .correlation_masks(&correlation_masks);
        let attachment_descriptions = [vk::AttachmentDescription::builder()
            .format(FORMAT)
            .samples(vk::SampleCountFlags::_1)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build()];
        let color_attachment_references = [vk::AttachmentReference::builder()
            .attachment(0)
            .layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build()];
        let subpasses = [vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&color_attachment_references)
            .build()];
        let mut render_pass_info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachment_descriptions)
            .subpasses(&subpasses);
        if num_views > 1 {
            render_pass_info = render_pass_info.push_next(&mut multiview_info);
        }
        let render_pass = crate::vk::ref_util::Unique::new(
            device,
            unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
        );

        // Descriptor set layout and pipeline layout.
        let mut layout_builder = DescriptorSetLayoutBuilder::new();
        if params.use_ssbo {
            layout_builder = layout_builder.add_single_binding(vk::DescriptorType::STORAGE_BUFFER, stage_flags);
        }
        let descriptor_set_layout = layout_builder.build(device)?;
        let pipeline_layout = make_pipeline_layout(device, &[descriptor_set_layout.get()])?;

        // Pipeline.
        let primitive_topology = if tess {
            vk::PrimitiveTopology::PATCH_LIST
        } else {
            vk::PrimitiveTopology::TRIANGLE_LIST
        };
        let mut state = DrawPipelineState::new(primitive_topology)
            .with_position_input()
            .with_full_viewport(EXTENT, EXTENT);
        state.rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(vk::CullModeFlags::NONE)
            .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
            .line_width(1.0)
            .build();
        if tess {
            state.patch_control_points = Some(3);
        }
        state.create_flags = vk::PipelineCreateFlags::ALLOW_DERIVATIVES;
        let shader_objects = make_shader_objects_stages(context, &stage_names, &[descriptor_set_layout.get()], &[])?;
        let pipeline = if shader_objects.is_some() {
            None
        } else {
            Some(create_draw_pipeline(
                device,
                *pipeline_layout,
                *render_pass,
                &stages,
                &state,
            )?)
        };
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_attachment], EXTENT, EXTENT, 1)?;

        // Descriptor set and output SSBO if needed.
        let num_counters_per_stage = num_views;
        let ssbo_element_count = (STAGE_COUNT * num_counters_per_stage) as usize;
        let ssbo_buffer = if params.use_ssbo {
            Some(create_host_buffer(
                context,
                &vec![0u32; ssbo_element_count],
                vk::BufferUsageFlags::STORAGE_BUFFER,
            )?)
        } else {
            None
        };
        let (_descriptor_pool, descriptor_set) = if let Some(ssbo_buffer) = &ssbo_buffer {
            let pool = DescriptorPoolBuilder::new()
                .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
                .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
            let set = make_descriptor_set(device, *pool, descriptor_set_layout.get())?;
            let ssbo_write_info = make_descriptor_buffer_info(
                ssbo_buffer.get(),
                0,
                (ssbo_element_count * std::mem::size_of::<u32>()) as vk::DeviceSize,
            );
            DescriptorSetUpdateBuilder::new()
                .write_single(
                    set.get(),
                    Location::binding(0),
                    vk::DescriptorType::STORAGE_BUFFER,
                    &ssbo_write_info,
                )
                .update(device);
            (Some(pool), Some(set))
        } else {
            (None, None)
        };

        // Command pool and buffer.
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        // Output verification buffer.
        let layer_bytes = (EXTENT * EXTENT * 4) as usize;
        let total_bytes = layer_bytes * num_views as usize;
        let verification_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(total_bytes as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Render triangle.
        begin_command_buffer(device, cmd)?;
        let clear_values = [clear_value_color([0.0, 0.0, 1.0, 1.0])];
        begin_draw(
            device,
            cmd,
            shader_objects.as_ref(),
            &state,
            pipeline.as_ref().map(|pipeline| **pipeline),
            *render_pass,
            *framebuffer,
            rect_2d(EXTENT, EXTENT),
            &clear_values,
            &[(color_image.get(), *color_attachment)],
        );
        unsafe {
            if let Some(descriptor_set) = &descriptor_set {
                device.cmd_bind_descriptor_sets(
                    cmd,
                    vk::PipelineBindPoint::GRAPHICS,
                    *pipeline_layout,
                    0,
                    &[descriptor_set.get()],
                    &[] as &[u32],
                );
            }
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_draw(cmd, 3, 1, 0, 0);
        }
        end_draw(device, cmd, shader_objects.is_some());

        // Copy output image to verification buffer.
        let pre_transfer_barrier = make_image_memory_barrier(
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            color_image.get(),
            subresource_range,
        );
        let copy_region = make_buffer_image_copy(
            vk::Extent3D {
                width: EXTENT,
                height: EXTENT,
                depth: 1,
            },
            make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, num_views),
        );
        let post_transfer_barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[pre_transfer_barrier],
            );
            device.cmd_copy_image_to_buffer(
                cmd,
                color_image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                verification_buffer.get(),
                &[copy_region],
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[post_transfer_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        // Output SSBO to host barrier.
        if params.use_ssbo {
            let ssbo_barrier = make_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ);
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::ALL_GRAPHICS,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[ssbo_barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        // Verify the image has the background color.
        let verification_alloc = verification_buffer.get_allocation();
        invalidate_alloc(device, verification_alloc)?;
        let pixels = unsafe { std::slice::from_raw_parts(verification_alloc.get_host_ptr(), total_bytes) };
        for layer in 0..num_views as usize {
            let layer_pixels = &pixels[layer * layer_bytes..(layer + 1) * layer_bytes];
            for y in 0..EXTENT {
                for x in 0..EXTENT {
                    let offset = ((y * EXTENT + x) * 4) as usize;
                    if layer_pixels[offset..offset + 4] != BACKGROUND_COLOR {
                        return Err(TestError::Fail(format!(
                            "Unexpected color found at pixel ({x}, {y}) in layer {layer}"
                        )));
                    }
                }
            }
        }

        // Verify SSBO if used.
        if let Some(ssbo_buffer) = &ssbo_buffer {
            let ssbo_alloc = ssbo_buffer.get_allocation();
            invalidate_alloc(device, ssbo_alloc)?;
            let ssbo_counters =
                unsafe { std::slice::from_raw_parts(ssbo_alloc.get_host_ptr().cast::<u32>(), ssbo_element_count) };

            // Vertex, Tessellation Control, Tesellation Evaluation, Geometry.
            let expected_counters = [3u32, 3, 3, 1];
            let stage_names = ["vertex", "tessellation control", "tessellation evaluation", "geometry"];
            for stage_idx in 0..STAGE_COUNT as usize {
                for counter_idx in 0..num_views as usize {
                    // If the stage is not selected, the expected value is exactly zero. Otherwise, it must be at least as expectedCounters.
                    let expected_val = expected_counters[stage_idx];
                    let min_val = if params.selected_stages & (1 << stage_idx) != 0 {
                        expected_val
                    } else {
                        0
                    };
                    let stored_val = ssbo_counters[stage_idx * num_counters_per_stage as usize + counter_idx];

                    // All shaders must process at least gl_ViewIndex times.
                    let ok = if min_val != 0 {
                        stored_val != 0 && (stored_val == min_val || stored_val % min_val == 0)
                    } else {
                        true
                    };
                    if !ok {
                        return Err(TestError::Fail(format!(
                            "Unexpected SSBO counter value in view {counter_idx} for the {} shader: got {stored_val} but expected {min_val}",
                            stage_names[stage_idx]
                        )));
                    }
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createNoPositionTests`
pub fn create_no_position_tests() -> TestCaseGroup {
    create_no_position_tests_for(false)
}

/// `createNoPositionTests`; the shader object construction types leave out the multiview cases.
pub fn create_no_position_tests_for(shader_object: bool) -> TestCaseGroup {
    // Tests with shaders that do not write to the Position built-in
    let mut group = TestCaseGroup::new("no_position");
    for explicit_declarations in [false, true] {
        let mut decl_group = TestCaseGroup::new(if explicit_declarations {
            "explicit_declarations"
        } else {
            "implicit_declarations"
        });

        for use_ssbo in [false, true] {
            let mut ssbo_group = TestCaseGroup::new(if use_ssbo { "ssbo_writes" } else { "basic" });

            for view_count in 1..=2u32 {
                if view_count != 1 && shader_object {
                    continue;
                }
                let mut view_group = TestCaseGroup::new(if view_count == 1 { "single_view" } else { "multiview" });

                for stages in 0..STAGE_MASK_COUNT {
                    // Vertex must always be present.
                    if stages & STAGE_VERTEX == 0 {
                        continue;
                    }
                    // Tessellation stages must both be present or none must be.
                    if (stages & STAGE_TESS_CONTROL != 0) != (stages & STAGE_TESS_EVALUATION != 0) {
                        continue;
                    }

                    for write_mask in get_write_sub_cases(stages) {
                        let mut test_name = String::new();
                        for (bit, letter) in [
                            (STAGE_VERTEX, "v"),
                            (STAGE_TESS_CONTROL, "c"),
                            (STAGE_TESS_EVALUATION, "e"),
                            (STAGE_GEOMETRY, "g"),
                        ] {
                            if stages & bit != 0 {
                                if !test_name.is_empty() {
                                    test_name.push('_');
                                }
                                test_name.push_str(letter);
                                test_name.push(if write_mask & bit != 0 { '1' } else { '0' });
                            }
                        }

                        let params = TestParams {
                            selected_stages: stages,
                            write_stages: write_mask,
                            num_views: view_count,
                            explicit_declarations,
                            use_ssbo,
                        };
                        view_group.add_child(Box::new(NoPositionCase {
                            name: test_name,
                            params,
                        }) as Box<dyn TestCase>);
                    }
                }
                ssbo_group.add_child(view_group);
            }
            decl_group.add_child(ssbo_group);
        }
        group.add_child(decl_group);
    }
    group
}
