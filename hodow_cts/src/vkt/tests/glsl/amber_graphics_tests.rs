// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/data/vulkan/amber/crash_test/divbyzero_{vert,frag,geom,tesc,tese}.amber
//   external/vulkancts/data/vulkan/amber/logical_copy/{initialized_struct,undefined_memory}.amber
//   external/vulkancts/data/vulkan/amber/combined_operations/{negintdivand,notxor}.amber
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2019 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. What an Amber graphics pipeline does for these scripts is done directly: a colour attachment
// (250x250 unless the script names a FRAMEBUFFER_SIZE) cleared to zero, one draw of either two triangles that cover `DRAW_RECT POS 0 0 SIZE w h`
// or a patch list of the script's own vertex data, an optional storage buffer (`BIND BUFFER .. AS storage DESCRIPTOR_SET 0 BINDING 0`) visible to the
// pre-rasterisation stages, an optional push constant block, and the expectations of the script (`EXPECT <buffer> IDX <byte offset> EQ <value>`
// on the storage buffer, `EXPECT framebuffer IDX x y SIZE w h EQ_RGBA` on the colour). The shaders are in `shaders/manifest/glsl_amber_graphics.toml`,
// written by `scripts/gen_glsl_amber_graphics_shaders.py`. A script's `DEVICE_FEATURE`s are what `check_support` asks for.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::glsl_amber_graphics::*;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, make_rect_2d, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, make_image_subresource_range, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_framebuffer,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::pipeline::pipeline_util::read_color_attachment;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `EXPECT framebuffer IDX x y SIZE w h EQ_RGBA r g b a`
#[derive(Clone, Copy)]
struct ExpectedRect {
    x: u32,
    y: u32,
    width: u32,
    height: u32,
    rgba: [u8; 4],
}

#[derive(Clone, Copy)]
struct Params {
    name: &'static str,
    /// The script's group: the shader names are `<group>_<script>_<stage>`.
    group: &'static str,
    script: &'static str,
    format: vk::Format,
    framebuffer: u32,
    /// `DRAW_RECT POS 0 0 SIZE n n`
    rect: u32,
    geometry: bool,
    tessellation: bool,
    /// The initial contents of the storage buffer, in 32-bit words; empty for a script without one.
    storage: &'static [u32],
    /// `EXPECT ssbo_buffer IDX <byte offset> EQ <value>`, as (word, value).
    expected_words: &'static [(usize, u32)],
    /// The two words of the `push_constant` buffer.
    push_constants: Option<[u32; 2]>,
    expected_rects: &'static [ExpectedRect],
}

const BASE: Params = Params {
    name: "",
    group: "",
    script: "",
    format: vk::Format::B8G8R8A8_UNORM,
    framebuffer: 250,
    rect: 32,
    geometry: false,
    tessellation: false,
    storage: &[],
    expected_words: &[],
    push_constants: None,
    expected_rects: &[],
};

const CRASH_TEST_STORAGE: [u32; 20] = [0; 20];

struct AmberGraphicsCase {
    params: Params,
}

impl AmberGraphicsCase {
    fn program_name(&self, stage: &str) -> String {
        format!("{}_{}_{}", self.params.group, self.params.script, stage)
    }

    fn storage_stages(&self) -> vk::ShaderStageFlags {
        let mut stages = vk::ShaderStageFlags::VERTEX;
        if self.params.geometry {
            stages |= vk::ShaderStageFlags::GEOMETRY;
        }
        if self.params.tessellation {
            stages |= vk::ShaderStageFlags::TESSELLATION_CONTROL | vk::ShaderStageFlags::TESSELLATION_EVALUATION;
        }
        stages
    }
}

impl TestCase for AmberGraphicsCase {
    fn name(&self) -> &str {
        self.params.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let features = context.get_device_features();
        if self.params.geometry && features.geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "Features.geometryShader not supported".to_string(),
            ));
        }
        if self.params.tessellation && features.tessellation_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "Features.tessellationShader not supported".to_string(),
            ));
        }
        if !self.params.storage.is_empty() && features.vertex_pipeline_stores_and_atomics == vk::FALSE {
            return Err(TestError::NotSupported(
                "Features.vertexPipelineStoresAndAtomics not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        GLSL_AMBER_GRAPHICS.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(AmberGraphicsInstance { context, case: self })
    }
}

struct AmberGraphicsInstance<'a> {
    context: &'a Context<'a>,
    case: &'a AmberGraphicsCase,
}

impl TestInstance for AmberGraphicsInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let case = self.case;
        let params = case.params;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let size = params.framebuffer;
        let extent = vk::Extent3D {
            width: size,
            height: size,
            depth: 1,
        };

        let image_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(params.format)
            .extent(extent)
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let color = ImageWithMemory::new(device, allocator, image_info, MemoryRequirement::ANY)?;
        let color_view = make_image_view(
            device,
            color.get(),
            vk::ImageViewType::_2D,
            params.format,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        )?;

        let attachments = [vk::AttachmentDescription::builder()
            .format(params.format)
            .samples(vk::SampleCountFlags::_1)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build()];
        let color_reference = [vk::AttachmentReference {
            attachment: 0,
            layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        }];
        let subpasses = [vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&color_reference)
            .build()];
        let render_pass_info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachments)
            .subpasses(&subpasses);
        let render_pass = Unique::new(
            device,
            unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
        );
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_view], size, size, 1)?;

        let has_storage = !params.storage.is_empty();
        let storage_bytes = (params.storage.len() * 4) as u64;
        let storage_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(storage_bytes.max(4), vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        if has_storage {
            let bytes: Vec<u8> = params.storage.iter().flat_map(|word| word.to_ne_bytes()).collect();
            unsafe {
                std::ptr::copy_nonoverlapping(
                    bytes.as_ptr(),
                    storage_buffer.get_allocation().get_host_ptr(),
                    bytes.len(),
                )
            };
            flush_alloc(device, storage_buffer.get_allocation())?;
        }

        let descriptor_set_layout = if has_storage {
            DescriptorSetLayoutBuilder::new()
                .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, case.storage_stages())
                .build(device)?
        } else {
            DescriptorSetLayoutBuilder::new().build(device)?
        };
        let push_ranges = [vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::FRAGMENT,
            offset: 0,
            size: 8,
        }];
        let set_layouts = [*descriptor_set_layout];
        let layout_info = vk::PipelineLayoutCreateInfo::builder()
            .set_layouts(&set_layouts)
            .push_constant_ranges(if params.push_constants.is_some() {
                &push_ranges[..]
            } else {
                &[]
            });
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
        if has_storage {
            let info = make_descriptor_buffer_info(storage_buffer.get(), 0, storage_bytes);
            DescriptorSetUpdateBuilder::new()
                .write_single(
                    *descriptor_set,
                    Location::binding(0),
                    vk::DescriptorType::STORAGE_BUFFER,
                    &info,
                )
                .update(device);
        }

        let binaries = context.get_binary_collection();
        let vertex_module = create_shader_module(device, binaries.get(&case.program_name("vert"))?)?;
        let fragment_module = create_shader_module(device, binaries.get(&case.program_name("frag"))?)?;
        let geometry_module = if params.geometry {
            Some(create_shader_module(device, binaries.get(&case.program_name("geom"))?)?)
        } else {
            None
        };
        let control_module = if params.tessellation {
            Some(create_shader_module(device, binaries.get(&case.program_name("tesc"))?)?)
        } else {
            None
        };
        let evaluation_module = if params.tessellation {
            Some(create_shader_module(device, binaries.get(&case.program_name("tese"))?)?)
        } else {
            None
        };
        let entry = c"main";
        let stage = |flags: vk::ShaderStageFlags, module: vk::ShaderModule| {
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(flags)
                .module(module)
                .name(entry.to_bytes_with_nul())
                .build()
        };
        let mut stages = vec![stage(vk::ShaderStageFlags::VERTEX, *vertex_module)];
        if let (Some(control), Some(evaluation)) = (&control_module, &evaluation_module) {
            stages.push(stage(vk::ShaderStageFlags::TESSELLATION_CONTROL, **control));
            stages.push(stage(vk::ShaderStageFlags::TESSELLATION_EVALUATION, **evaluation));
        }
        if let Some(geometry) = &geometry_module {
            stages.push(stage(vk::ShaderStageFlags::GEOMETRY, **geometry));
        }
        stages.push(stage(vk::ShaderStageFlags::FRAGMENT, *fragment_module));

        let bindings = [vk::VertexInputBindingDescription {
            binding: 0,
            stride: 12,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        let attributes = [vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vk::Format::R32G32B32_SFLOAT,
            offset: 0,
        }];
        let vertex_input = vk::PipelineVertexInputStateCreateInfo::builder()
            .vertex_binding_descriptions(&bindings)
            .vertex_attribute_descriptions(&attributes);
        let topology = if params.tessellation {
            vk::PrimitiveTopology::PATCH_LIST
        } else {
            vk::PrimitiveTopology::TRIANGLE_LIST
        };
        let input_assembly = vk::PipelineInputAssemblyStateCreateInfo::builder().topology(topology);
        let tessellation_state = vk::PipelineTessellationStateCreateInfo::builder().patch_control_points(3);
        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: size as f32,
            height: size as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        let scissors = [make_rect_2d(0, 0, size, size)];
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
            .viewports(&viewports)
            .scissors(&scissors);
        let rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(vk::CullModeFlags::NONE)
            .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
            .line_width(1.0);
        let multisample =
            vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);
        let blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
            .blend_enable(false)
            .color_write_mask(vk::ColorComponentFlags::all())
            .build()];
        let color_blend = vk::PipelineColorBlendStateCreateInfo::builder().attachments(&blend_attachments);
        let mut pipeline_info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(&stages)
            .vertex_input_state(&vertex_input)
            .input_assembly_state(&input_assembly)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterization)
            .multisample_state(&multisample)
            .color_blend_state(&color_blend)
            .layout(*pipeline_layout)
            .render_pass(*render_pass)
            .subpass(0)
            .base_pipeline_index(0);
        if params.tessellation {
            pipeline_info = pipeline_info.tessellation_state(&tessellation_state);
        }
        let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
            .vk_check("vkCreateGraphicsPipelines")?;
        let pipeline = Unique::new(device, pipelines.0[0]);

        // The tessellation scripts draw their own six vertices; `DRAW_RECT POS 0 0 SIZE n n` is two triangles over the first n pixels.
        let positions: Vec<[f32; 3]> = if params.tessellation {
            vec![
                [-0.5, -0.5, 0.0],
                [0.5, -0.5, 0.0],
                [0.5, 0.5, 0.0],
                [0.5, 0.5, 0.0],
                [-0.5, 0.5, 0.0],
                [-0.5, -0.5, 0.0],
            ]
        } else {
            let far = -1.0 + 2.0 * params.rect as f32 / size as f32;
            vec![
                [-1.0, -1.0, 0.0],
                [far, -1.0, 0.0],
                [-1.0, far, 0.0],
                [-1.0, far, 0.0],
                [far, -1.0, 0.0],
                [far, far, 0.0],
            ]
        };
        let vertex_bytes = (positions.len() * 12) as u64;
        let vertex_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(vertex_bytes, vk::BufferUsageFlags::VERTEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                positions.as_ptr().cast::<u8>(),
                vertex_buffer.get_allocation().get_host_ptr(),
                vertex_bytes as usize,
            )
        };
        flush_alloc(device, vertex_buffer.get_allocation())?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        begin_command_buffer(device, *cmd_buffer)?;
        let clear_values = [vk::ClearValue {
            color: vk::ClearColorValue {
                float32: [0.0, 0.0, 0.0, 0.0],
            },
        }];
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(make_rect_2d(0, 0, size, size))
            .clear_values(&clear_values);
        unsafe {
            device.cmd_begin_render_pass(*cmd_buffer, &begin_info, vk::SubpassContents::INLINE);
            device.cmd_bind_pipeline(*cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            if has_storage {
                device.cmd_bind_descriptor_sets(
                    *cmd_buffer,
                    vk::PipelineBindPoint::GRAPHICS,
                    *pipeline_layout,
                    0,
                    &[*descriptor_set],
                    &[],
                );
            }
            if let Some(words) = params.push_constants {
                let bytes: Vec<u8> = words.iter().flat_map(|word| word.to_ne_bytes()).collect();
                device.cmd_push_constants(*cmd_buffer, *pipeline_layout, vk::ShaderStageFlags::FRAGMENT, 0, &bytes);
            }
            device.cmd_bind_vertex_buffers(*cmd_buffer, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_draw(*cmd_buffer, positions.len() as u32, 1, 0, 0);
            device.cmd_end_render_pass(*cmd_buffer);
        }
        end_command_buffer(device, *cmd_buffer)?;
        submit_commands_and_wait(device, context.get_universal_queue(), *cmd_buffer)?;

        if has_storage {
            invalidate_alloc(device, storage_buffer.get_allocation())?;
            let bytes = unsafe {
                std::slice::from_raw_parts(
                    storage_buffer.get_allocation().get_host_ptr().cast_const(),
                    storage_bytes as usize,
                )
            };
            for &(word, expected) in params.expected_words {
                let value = u32::from_ne_bytes(bytes[word * 4..word * 4 + 4].try_into().expect("four bytes"));
                if value != expected {
                    return Ok(TestStatus::fail(format!(
                        "Storage buffer word {word} holds {value}, expected {expected}"
                    )));
                }
            }
        }

        if !params.expected_rects.is_empty() {
            let result = read_color_attachment(
                context,
                color.get(),
                params.format,
                (size, size),
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            )?;
            let pixels = result.get_const_access();
            for rect in params.expected_rects {
                for y in rect.y..rect.y + rect.height {
                    for x in rect.x..rect.x + rect.width {
                        let pixel = pixels.get_pixel(x, y, 0);
                        let actual = pixel.map(|channel| (channel * 255.0).round() as i32);
                        if actual != rect.rgba.map(i32::from) {
                            return Ok(TestStatus::fail(format!(
                                "Unexpected colour {actual:?} at ({x}, {y}), expected {:?}",
                                rect.rgba
                            )));
                        }
                    }
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

fn boxed(params: Params) -> Box<dyn TestCase> {
    Box::new(AmberGraphicsCase { params })
}

/// The `crash_test` group of `glsl`: `divbyzero_comp` is the compute Amber script, the five graphics ones are here.
pub fn create_crash_test_group() -> TestCaseGroup {
    const RED_PIXEL: [ExpectedRect; 1] = [ExpectedRect {
        x: 0,
        y: 0,
        width: 1,
        height: 1,
        rgba: [255, 0, 0, 255],
    }];
    let storage = Params {
        group: "crash_test",
        storage: &CRASH_TEST_STORAGE,
        expected_words: &[(0, 42)],
        ..BASE
    };
    let mut group = crate::vkt::tests::spirv_assembly::amber_tests::create_glsl_crash_test_group();
    group.add_child(boxed(Params {
        name: "divbyzero_vert",
        script: "divbyzero_vert",
        ..storage
    }));
    group.add_child(boxed(Params {
        name: "divbyzero_frag",
        group: "crash_test",
        script: "divbyzero_frag",
        expected_rects: &RED_PIXEL,
        ..BASE
    }));
    group.add_child(boxed(Params {
        name: "divbyzero_geom",
        script: "divbyzero_geom",
        format: vk::Format::R8G8B8A8_UNORM,
        geometry: true,
        ..storage
    }));
    group.add_child(boxed(Params {
        name: "divbyzero_tesc",
        script: "divbyzero_tesc",
        format: vk::Format::R8G8B8A8_UNORM,
        tessellation: true,
        ..storage
    }));
    group.add_child(boxed(Params {
        name: "divbyzero_tese",
        script: "divbyzero_tese",
        format: vk::Format::R8G8B8A8_UNORM,
        tessellation: true,
        ..storage
    }));
    group
}

/// `glsl.logical_copy`
pub fn create_logical_copy_group() -> TestCaseGroup {
    const WORDS: [u32; 12] = [1; 12];
    let base = Params {
        group: "logical_copy",
        storage: &WORDS,
        ..BASE
    };
    let mut group = TestCaseGroup::new("logical_copy");
    // EXPECT ssbo_buffer IDX 16, 20, 24 and 28 EQ 0 are the words 4 to 7.
    group.add_child(boxed(Params {
        name: "initialized_struct",
        script: "initialized_struct",
        expected_words: &[(4, 0), (5, 0), (6, 0), (7, 0)],
        ..base
    }));
    group.add_child(boxed(Params {
        name: "undefined_memory",
        script: "undefined_memory",
        ..base
    }));
    group
}

/// `glsl.combined_operations`
pub fn create_combined_operations_group() -> TestCaseGroup {
    const NEGINTDIVAND: [ExpectedRect; 2] = [
        ExpectedRect {
            x: 0,
            y: 220,
            width: 30,
            height: 30,
            rgba: [0, 255, 255, 255],
        },
        ExpectedRect {
            x: 0,
            y: 0,
            width: 30,
            height: 30,
            rgba: [255, 0, 0, 255],
        },
    ];
    const NOTXOR: [ExpectedRect; 1] = [ExpectedRect {
        x: 0,
        y: 0,
        width: 16,
        height: 16,
        rgba: [255, 255, 255, 255],
    }];
    let base = Params {
        group: "combined_operations",
        ..BASE
    };
    let mut group = TestCaseGroup::new("combined_operations");
    group.add_child(boxed(Params {
        name: "negintdivand",
        script: "negintdivand",
        rect: 250,
        expected_rects: &NEGINTDIVAND,
        ..base
    }));
    group.add_child(boxed(Params {
        name: "notxor",
        script: "notxor",
        framebuffer: 16,
        rect: 16,
        push_constants: Some([0xaaaaaaab, 0x55555555]),
        expected_rects: &NOTXOR,
        ..base
    }));
    group
}
