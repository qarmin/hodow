// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/tessellation/vktTessellationPrimitiveDiscardTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// These tests correspond to dEQP-GLES31.functional.tessellation.primitive_discard.*
// \note Original test used transform feedback (TF) to capture the number of output vertices. The behavior of TF differs
//       significantly from SSBO approach, especially for non-point_mode rendering. TF returned all coordinates, while
//       SSBO computes the count based on the number of shader invocations which yields a much smaller number because
//       invocations for duplicate coordinates are often eliminated. Because of this, the test was changed to:
//       - always compute the number of expected coordinates as if point_mode was enabled
//       - not fail if implementation returned more coordinates than expected

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::tessellation_primitive_discard::ALL_SHARED_PROGRAM;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{make_image_memory_barrier, make_image_subresource_range};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_set, make_framebuffer, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, ImageWithBuffer, clear_value_color, create_draw_pipeline, make_color_render_pass, rect_2d,
};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::tests::tessellation::util::{
    SpacingMode, TessPrimitiveType, Winding, is_patch_discarded, reference_point_mode_vertex_count,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy)]
struct CaseDefinition {
    primitive_type: TessPrimitiveType,
    spacing_mode: SpacingMode,
    #[allow(dead_code)]
    winding: Winding,
    use_point_mode: bool,
    use_less_than_one_inner_levels: bool,
}

fn less_than_one_inner_levels_defined(case_def: &CaseDefinition) -> bool {
    // From Vulkan API specification:
    // >> When tessellating triangles or quads (with/without point mode) with fractional odd spacing, the tessellator
    // >> ***may*** produce interior vertices that are positioned on the edge of the patch if an inner
    // >> tessellation level is less than or equal to one.
    !((case_def.primitive_type == TessPrimitiveType::Quads || case_def.primitive_type == TessPrimitiveType::Triangles)
        && case_def.spacing_mode == SpacingMode::FractionalOdd)
}

fn int_pow(base: i32, exp: i32) -> i32 {
    debug_assert!(exp >= 0);
    if exp == 0 {
        1
    } else {
        let sub = int_pow(base, exp / 2);
        if exp % 2 == 0 { sub * sub } else { sub * sub * base }
    }
}

fn gen_attributes(use_less_than_one_inner_levels: bool) -> Vec<f32> {
    // Generate input attributes (tessellation levels, and position scale and offset) for a number of primitives. Each
    // primitive has a different combination of tessellatio levels; each level is either a valid value or an "invalid"
    // value (negative or zero, chosen from invalidTessLevelChoices).
    // \note The attributes are generated in such an order that all of the valid attribute tuples come before the first
    //       invalid one both in the result vector, and when scanning the resulting 2d grid of primitives is scanned in
    //       y-major order. This makes verification somewhat simpler.
    let base_tess_levels = [3.0f32, 4.0, 5.0, 6.0, 7.0, 8.0];
    let invalid_tess_level_choices = [-0.42f32, 0.0];
    let num_choices = 1 + invalid_tess_level_choices.len();
    let mut choices = [[0.0f32; 3]; 6];
    let mut result = Vec::new();

    for level_ndx in 0..6 {
        for choice_ndx in 0..num_choices {
            choices[level_ndx][choice_ndx] = if choice_ndx == 0 || !use_less_than_one_inner_levels {
                base_tess_levels[level_ndx]
            } else {
                invalid_tess_level_choices[choice_ndx - 1]
            };
        }
    }

    let num_cols = int_pow(num_choices as i32, 6 / 2); // sqrt(numChoices**6) == sqrt(number of primitives)
    let num_rows = num_cols;
    let mut index = 0;

    // We could do this with some generic combination-generation function, but meh, it's not that bad.
    for i2 in 0..num_choices {
        // First outer
        for i3 in 0..num_choices {
            // Second outer
            for i4 in 0..num_choices {
                // Third outer
                for i5 in 0..num_choices {
                    // Fourth outer
                    for i0 in 0..num_choices {
                        // First inner
                        for i1 in 0..num_choices {
                            // Second inner
                            let i = [i0, i1, i2, i3, i4, i5];
                            for j in 0..6 {
                                result.push(choices[j][i[j]]);
                            }

                            let col = index % num_cols;
                            let row = index / num_cols;
                            // Position scale.
                            result.push(2.0 / num_cols as f32);
                            result.push(2.0 / num_rows as f32);
                            // Position offset.
                            result.push(col as f32 / num_cols as f32 * 2.0 - 1.0);
                            result.push(row as f32 / num_rows as f32 * 2.0 - 1.0);

                            index += 1;
                        }
                    }
                }
            }
        }
    }
    result
}

/// Check that white pixels are found around every non-discarded patch, and that only black pixels are found after the
/// last non-discarded patch. Returns true on successful comparison.
fn verify_result_image(
    num_primitives: usize,
    num_attribs_per_primitive: usize,
    primitive_type: TessPrimitiveType,
    attributes: &[f32],
    pixels: &[u8],
    width: i32,
    height: i32,
) -> bool {
    let black = [0u8, 0, 0, 255];
    let white = [255u8, 255, 255, 255];
    let pixel = |x: i32, y: i32| &pixels[((y * width + x) * 4) as usize..((y * width + x) * 4 + 4) as usize];

    let mut last_white_pixel_row = 0;
    let mut second_to_last_white_pixel_row = 0;
    let mut last_white_pixel_column_on_second_to_last_white_pixel_row = 0;

    for patch_ndx in 0..num_primitives {
        let attr = &attributes[num_attribs_per_primitive * patch_ndx..];
        let valid_levels = !is_patch_discarded(primitive_type, &attr[2..]);

        if valid_levels {
            // Not a discarded patch; check that at least one white pixel is found in its area.
            let scale = &attr[6..];
            let offset = &attr[8..];
            let x0 = ((offset[0] + 1.0) * 0.5 * width as f32) as i32 - 1;
            let x1 = ((scale[0] + offset[0] + 1.0) * 0.5 * width as f32) as i32 + 1;
            let y0 = ((offset[1] + 1.0) * 0.5 * height as f32) as i32 - 1;
            let y1 = ((scale[1] + offset[1] + 1.0) * 0.5 * height as f32) as i32 + 1;
            let mut pixel_ok = false;

            if y1 > last_white_pixel_row {
                second_to_last_white_pixel_row = last_white_pixel_row;
                last_white_pixel_row = y1;
            }
            last_white_pixel_column_on_second_to_last_white_pixel_row = x1;

            let mut y = y0;
            while y <= y1 && !pixel_ok {
                let mut x = x0;
                while x <= x1 && !pixel_ok {
                    if (0..width).contains(&x) && (0..height).contains(&y) && pixel(x, y) == white {
                        pixel_ok = true;
                    }
                    x += 1;
                }
                y += 1;
            }

            if !pixel_ok {
                // Failure: expected at least one white pixel in the rectangle [x0, y0, x1, y1]
                return false;
            }
        } else {
            // First discarded primitive patch; the remaining are guaranteed to be discarded ones as well.
            for y in 0..height {
                for x in 0..width {
                    if (y > last_white_pixel_row
                        || (y > second_to_last_white_pixel_row
                            && x > last_white_pixel_column_on_second_to_last_white_pixel_row))
                        && pixel(x, y) != black
                    {
                        // Failure: expected all pixels to be black in the area of patches that should be discarded
                        return false;
                    }
                }
            }
            break;
        }
    }
    true
}

fn expected_vertex_count(
    num_primitives: usize,
    num_attribs_per_primitive: usize,
    primitive_type: TessPrimitiveType,
    spacing_mode: SpacingMode,
    attributes: &[f32],
) -> i32 {
    (0..num_primitives)
        .map(|patch_ndx| {
            reference_point_mode_vertex_count(
                primitive_type,
                spacing_mode,
                &attributes[num_attribs_per_primitive * patch_ndx..],
                &attributes[num_attribs_per_primitive * patch_ndx + 2..],
            )
        })
        .sum()
}

struct PrimitiveDiscardCase {
    name: String,
    /// The name of the case in the shader manifest.
    program_name: String,
    case_def: CaseDefinition,
}

impl TestCase for PrimitiveDiscardCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkSupportCase` and `requireFeatures`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let features = context.get_device_features();
        if features.tessellation_shader == vk::FALSE {
            return Err(TestError::NotSupported("Tessellation shader not supported".to_string()));
        }
        if features.vertex_pipeline_stores_and_atomics == vk::FALSE {
            return Err(TestError::NotSupported(
                "SSBO and image writes not supported in vertex pipeline".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == self.program_name)
            .unwrap_or_else(|| panic!("the shader manifest has no case named {}", self.program_name))
            .programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(PrimitiveDiscardInstance {
            context,
            case_def: self.case_def,
        })
    }
}

struct PrimitiveDiscardInstance<'a> {
    context: &'a Context<'a>,
    case_def: CaseDefinition,
}

impl TestInstance for PrimitiveDiscardInstance<'_> {
    /// Test that patch is discarded if relevant outer level <= 0.0
    ///
    /// Draws patches with different combinations of tessellation levels, varying which levels are negative. Verifies by
    /// checking that white pixels exist inside the area of valid primitives, and only black pixels exist inside the area
    /// of discarded primitives. An additional sanity test is done, checking that the number of primitives written by
    /// shader is correct.
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let case_def = self.case_def;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let alloc = context.get_default_allocator();

        let attributes = gen_attributes(case_def.use_less_than_one_inner_levels);
        const NUM_ATTRIBS_PER_PRIMITIVE: usize = 6 + 2 + 2; // Tess levels, scale, offset.
        let num_primitives = attributes.len() / NUM_ATTRIBS_PER_PRIMITIVE;
        let num_expected_vertices = expected_vertex_count(
            num_primitives,
            NUM_ATTRIBS_PER_PRIMITIVE,
            case_def.primitive_type,
            case_def.spacing_mode,
            &attributes,
        );

        // Check the convenience assertion that all discarded patches come after the last non-discarded patch.
        {
            let mut discarded_patch_encountered = false;
            for patch_ndx in 0..num_primitives {
                let discard = is_patch_discarded(
                    case_def.primitive_type,
                    &attributes[NUM_ATTRIBS_PER_PRIMITIVE * patch_ndx + 2..],
                );
                debug_assert!(discard || !discarded_patch_encountered);
                discarded_patch_encountered = discard;
            }
            let _ = discarded_patch_encountered;
        }

        // Vertex input attributes buffer
        let vertex_format = vk::Format::R32_SFLOAT;
        let vertex_stride = std::mem::size_of::<f32>() as u32;
        debug_assert!(attributes.len() == num_primitives * NUM_ATTRIBS_PER_PRIMITIVE);
        let vertex_buffer = create_host_buffer(context, &attributes, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        // Output buffer: number of invocations
        let result_buffer_size_bytes = std::mem::size_of::<i32>() as vk::DeviceSize;
        let result_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(result_buffer_size_bytes, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::write_bytes(
                result_buffer.get_allocation().get_host_ptr(),
                0,
                result_buffer_size_bytes as usize,
            )
        };
        flush_alloc(device, result_buffer.get_allocation())?;

        // Color attachment, and the buffer its image is copied to for verification
        const RENDER_SIZE: u32 = 256;
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let color_buffer = ImageWithBuffer::new(
            context,
            RENDER_SIZE,
            RENDER_SIZE,
            color_format,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            4,
        )?;

        // Descriptors
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(
                vk::DescriptorType::STORAGE_BUFFER,
                vk::ShaderStageFlags::TESSELLATION_EVALUATION,
            )
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        let result_buffer_info = vk::DescriptorBufferInfo {
            buffer: result_buffer.get(),
            offset: 0,
            range: result_buffer_size_bytes,
        };
        DescriptorSetUpdateBuilder::new()
            .write_single(
                descriptor_set.get(),
                Location::binding(0),
                vk::DescriptorType::STORAGE_BUFFER,
                &result_buffer_info,
            )
            .update(device);

        // Pipeline
        let render_pass = make_color_render_pass(
            device,
            color_format,
            vk::AttachmentLoadOp::CLEAR,
            vk::AttachmentStoreOp::STORE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_buffer.view], RENDER_SIZE, RENDER_SIZE, 1)?;
        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        let need_point_size_write = context
            .get_device_features()
            .shader_tessellation_and_geometry_point_size
            != vk::FALSE
            && case_def.use_point_mode;

        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let tesc_module = create_shader_module(device, binaries.get("tesc")?)?;
        let tese_module = create_shader_module(
            device,
            binaries.get(if need_point_size_write { "tese_psw" } else { "tese" })?,
        )?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;

        let mut state =
            DrawPipelineState::new(vk::PrimitiveTopology::PATCH_LIST).with_full_viewport(RENDER_SIZE, RENDER_SIZE);
        state.bindings = vec![vk::VertexInputBindingDescription {
            binding: 0,
            stride: vertex_stride,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        state.attributes = vec![vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vertex_format,
            offset: 0,
        }];
        state.patch_control_points = Some(NUM_ATTRIBS_PER_PRIMITIVE as u32);
        let pipeline = create_draw_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vert_module),
                (vk::ShaderStageFlags::TESSELLATION_CONTROL, *tesc_module),
                (vk::ShaderStageFlags::TESSELLATION_EVALUATION, *tese_module),
                (vk::ShaderStageFlags::FRAGMENT, *frag_module),
            ],
            &state,
        )?;

        // Note: rendering `num_primitives` patches; first patches have valid relevant outer levels, but later patches have
        // one or more invalid (i.e. less than or equal to 0.0) relevant outer levels

        // Draw commands
        begin_command_buffer(device, *cmd_buffer)?;

        // Change color attachment image layout
        {
            let color_attachment_layout_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                color_buffer.image.get(),
                make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
            );
            unsafe {
                device.cmd_pipeline_barrier(
                    *cmd_buffer,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[color_attachment_layout_barrier],
                );
            }
        }

        // Begin render pass
        let clear_values = [clear_value_color([0.0, 0.0, 0.0, 1.0])];
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(rect_2d(RENDER_SIZE, RENDER_SIZE))
            .clear_values(&clear_values);
        unsafe {
            device.cmd_begin_render_pass(*cmd_buffer, &begin_info, vk::SubpassContents::INLINE);
            device.cmd_bind_pipeline(*cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_bind_descriptor_sets(
                *cmd_buffer,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );
            device.cmd_bind_vertex_buffers(*cmd_buffer, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_draw(*cmd_buffer, attributes.len() as u32, 1, 0, 0);
            device.cmd_end_render_pass(*cmd_buffer);
        }

        // Copy render result to a host-visible buffer
        copy_image_to_buffer(
            device,
            *cmd_buffer,
            color_buffer.image.get(),
            color_buffer.buffer.get(),
            RENDER_SIZE,
            RENDER_SIZE,
        );
        {
            let shader_write_barrier = make_buffer_memory_barrier(
                vk::AccessFlags::SHADER_WRITE,
                vk::AccessFlags::HOST_READ,
                result_buffer.get(),
                0,
                result_buffer_size_bytes,
            );
            unsafe {
                device.cmd_pipeline_barrier(
                    *cmd_buffer,
                    vk::PipelineStageFlags::ALL_GRAPHICS,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[shader_write_barrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }
        end_command_buffer(device, *cmd_buffer)?;
        submit_commands_and_wait(device, queue, *cmd_buffer)?;

        // Verify case result
        let image_pixel_access = color_buffer.read_bytes(device)?;

        invalidate_alloc(device, result_buffer.get_allocation())?;
        let num_result_vertices =
            unsafe { std::ptr::read_unaligned(result_buffer.get_allocation().get_host_ptr().cast::<i32>()) };

        if !less_than_one_inner_levels_defined(&case_def) && case_def.use_less_than_one_inner_levels {
            // Since we cannot explicitly determine whether or not such interior vertices are going to be generated, we
            // will not verify the number of generated vertices for fractional odd + quads/triangles tessellation
            // configurations.
        } else if num_result_vertices < num_expected_vertices {
            return Ok(TestStatus::fail("Wrong number of tessellation coordinates"));
        }

        Ok(
            if verify_result_image(
                num_primitives,
                NUM_ATTRIBS_PER_PRIMITIVE,
                case_def.primitive_type,
                &attributes,
                image_pixel_access,
                RENDER_SIZE as i32,
                RENDER_SIZE as i32,
            ) {
                TestStatus::pass("OK")
            } else {
                TestStatus::fail("Image verification failed")
            },
        )
    }
}

/// `createPrimitiveDiscardTests`
pub fn create_primitive_discard_tests() -> TestCaseGroup {
    // Test primitive discard with relevant outer tessellation level <= 0.0
    let mut group = TestCaseGroup::new("primitive_discard");

    for primitive_type in TessPrimitiveType::ALL {
        for spacing_mode in SpacingMode::ALL {
            for winding in Winding::ALL {
                for use_point_mode in [false, true] {
                    for use_less_than_one_inner_levels in [false, true] {
                        let case_def = CaseDefinition {
                            primitive_type,
                            spacing_mode,
                            winding,
                            use_point_mode,
                            use_less_than_one_inner_levels,
                        };

                        if less_than_one_inner_levels_defined(&case_def) && !case_def.use_less_than_one_inner_levels {
                            continue; // No point generating a separate case as <= 1 inner level behavior is well-defined
                        }

                        let program_name = format!(
                            "{}_{}_{}{}",
                            primitive_type.shader_name(),
                            spacing_mode.shader_name(),
                            winding.shader_name(),
                            if use_point_mode { "_point_mode" } else { "" }
                        );
                        let name = format!(
                            "{program_name}{}",
                            if use_less_than_one_inner_levels {
                                ""
                            } else {
                                "_valid_levels"
                            }
                        );

                        group.add_child(Box::new(PrimitiveDiscardCase {
                            name,
                            program_name,
                            case_def,
                        }) as Box<dyn TestCase>);
                    }
                }
            }
        }
    }
    group
}
