// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/renderpass/vktRenderPassTests.cpp (`addAttachmentAllocationTests`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the render pass and renderpass2 variants exist here: upstream skips the two
// input/output groups for dynamic rendering and runs the rest as one rendering over every subpass through
// VK_KHR_dynamic_rendering_local_read, which `push_dynamic_rendering_commands` (a single subpass) does not do. The fragment shaders
// come from `scripts/gen_renderpass_attachment_shaders.py`, which replays the draws below and keys each case by its place in the
// chain (`alloc/<group>/<case>`), so any change to the order of the draws has to be made there as well.

use std::collections::BTreeSet;

use super::attachment_tests::CORE_DEPTH_STENCIL_FORMATS;
use super::*;

#[derive(Clone, Copy, PartialEq, Eq)]
enum AllocationType {
    /// Each pass uses one more attachment than the previous one.
    Grow,
    /// Each pass uses one less attachment than the previous one.
    Shrink,
    /// Each pass drops one attachment and picks up a new one.
    Roll,
    /// Start by growing and end by shrinking.
    GrowShrink,
    /// Each subpass has a single input and a single output attachment.
    IoChain,
    /// Each subpass has multiple inputs and multiple output attachments.
    IoGeneric,
}

fn fragment_and_attachment_stages() -> vk::PipelineStageFlags {
    vk::PipelineStageFlags::FRAGMENT_SHADER
        | vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT
        | vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS
        | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS
}

fn attachment(
    format: vk::Format,
    load_op: vk::AttachmentLoadOp,
    store_op: vk::AttachmentStoreOp,
    stencil_load_op: vk::AttachmentLoadOp,
    stencil_store_op: vk::AttachmentStoreOp,
    initial_layout: vk::ImageLayout,
    final_layout: vk::ImageLayout,
) -> Attachment {
    Attachment {
        format,
        samples: vk::SampleCountFlags::_1,
        load_op,
        store_op,
        stencil_load_op,
        stencil_store_op,
        initial_layout,
        final_layout,
        aspect: vk::ImageAspectFlags::empty(),
    }
}

/// `chooseRandom`
fn choose_random(rng: &mut Random, values: &BTreeSet<u32>) -> u32 {
    let ndx = (rng.get_uint32() as usize) % values.len();
    *values.iter().nth(ndx).expect("the set is not empty")
}

/// A subpass of the colour-only groups: no inputs, no depth/stencil, nothing to preserve.
fn color_subpass(color_attachments: Vec<AttachmentReference>) -> Subpass {
    Subpass {
        input_attachments: Vec::new(),
        color_attachments,
        depth_stencil_attachment: AttachmentReference::new(ATTACHMENT_UNUSED, vk::ImageLayout::GENERAL),
        omit_blend_state: false,
        preserve_attachments: Vec::new(),
    }
}

/// Adds a dependency between two passes, or folds `merge` into the one already there.
fn add_dependency(
    dependencies: &mut Vec<SubpassDependency>,
    src_pass: u32,
    dst_pass: u32,
    src_access_mask: vk::AccessFlags,
    dst_access_mask: vk::AccessFlags,
    flags: vk::DependencyFlags,
    merge: impl Fn(&mut SubpassDependency),
) {
    if let Some(dependency) = dependencies
        .iter_mut()
        .find(|d| d.src_pass == src_pass && d.dst_pass == dst_pass)
    {
        merge(dependency);
        return;
    }

    dependencies.push(SubpassDependency {
        src_pass,
        dst_pass,
        src_stage_mask: fragment_and_attachment_stages(),
        dst_stage_mask: fragment_and_attachment_stages(),
        src_access_mask,
        dst_access_mask,
        flags,
    });
}

fn by_region(rng: &mut Random) -> vk::DependencyFlags {
    if rng.get_bool() {
        vk::DependencyFlags::BY_REGION
    } else {
        vk::DependencyFlags::empty()
    }
}

/// `addAttachmentAllocationTests`
pub(super) fn add_attachment_allocation_tests(
    group: &mut TestCaseGroup,
    allocation_kind: AllocationKind,
    render_pass_type: RenderPassType,
) {
    let attachment_counts = [4u32, 8];
    let load_ops = [
        vk::AttachmentLoadOp::LOAD,
        vk::AttachmentLoadOp::CLEAR,
        vk::AttachmentLoadOp::DONT_CARE,
    ];
    let store_ops = [vk::AttachmentStoreOp::STORE, vk::AttachmentStoreOp::DONT_CARE];

    let initial_and_final_color_layouts = [
        vk::ImageLayout::GENERAL,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
    ];
    let initial_and_final_color_layouts_lazy = [
        vk::ImageLayout::GENERAL,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
    ];
    let initial_and_final_depth_stencil_layouts = [
        vk::ImageLayout::GENERAL,
        vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
        vk::ImageLayout::DEPTH_STENCIL_READ_ONLY_OPTIMAL,
        vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
    ];

    let subpass_layouts_color = [vk::ImageLayout::GENERAL, vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL];
    let subpass_layouts_depth_stencil = [
        vk::ImageLayout::GENERAL,
        vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
    ];
    let subpass_layouts_input = [vk::ImageLayout::GENERAL, vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL];

    let allocation_types = [
        ("grow", AllocationType::Grow),
        ("shrink", AllocationType::Shrink),
        ("roll", AllocationType::Roll),
        ("grow_shrink", AllocationType::GrowShrink),
        ("input_output_chain", AllocationType::IoChain),
        ("input_output", AllocationType::IoGeneric),
    ];

    let render_commands = [
        RenderTypes::NONE,
        RenderTypes::CLEAR,
        RenderTypes::DRAW,
        RenderTypes::CLEAR.or(RenderTypes::DRAW),
    ];
    let command_buffers = [
        CommandBufferTypes::INLINE,
        CommandBufferTypes::SECONDARY,
        CommandBufferTypes::INLINE.or(CommandBufferTypes::SECONDARY),
    ];
    let image_memories = [
        ImageMemory::STRICT,
        ImageMemory::LAZY,
        ImageMemory::STRICT.or(ImageMemory::LAZY),
    ];

    let target_sizes = [[64u32, 64u32], [63, 65]];
    let render_positions = [[0u32, 0u32], [3, 17]];
    let render_sizes = [[32u32, 32u32], [60, 47]];

    // `s_coreColorFormats` is the first 48 entries of the list the `formats` group registers; A8_UNORM is appended there on its own.
    let color_formats = &CORE_COLOR_FORMATS[..CORE_COLOR_FORMATS.len() - 1];

    let mut rng = Random::new(3700649827);

    for (type_name, allocation_type) in allocation_types {
        let test_case_count = 100;
        let mut allocation_type_group = TestCaseGroup::new(type_name);

        for test_case_ndx in 0..test_case_count {
            let image_memory = *rng.choose(&image_memories);
            let strict = image_memory == ImageMemory::STRICT;
            let color_layouts: &[vk::ImageLayout] = if strict {
                &initial_and_final_color_layouts
            } else {
                &initial_and_final_color_layouts_lazy
            };

            let mut attachments: Vec<Attachment> = Vec::new();
            let mut subpasses: Vec<Subpass> = Vec::new();
            let mut dependencies: Vec<SubpassDependency> = Vec::new();

            if allocation_type == AllocationType::IoGeneric {
                let attachment_count = 4 + rng.get_uint32() % 31;
                let subpass_count = 4 + rng.get_uint32() % 31;

                let mut defined_attachments: BTreeSet<u32> = BTreeSet::new();
                let mut color_attachments: BTreeSet<u32> = BTreeSet::new();
                let mut depth_stencil_attachments: BTreeSet<u32> = BTreeSet::new();

                for attachment_index in 0..attachment_count {
                    let is_depth_stencil_attachment = rng.get_float() < 0.01f32;
                    let load_op = *rng.choose(&load_ops);
                    let store_op = *rng.choose(&store_ops);

                    let initial_layout = if is_depth_stencil_attachment {
                        *rng.choose(&initial_and_final_depth_stencil_layouts)
                    } else {
                        *rng.choose(color_layouts)
                    };
                    let final_layout = if is_depth_stencil_attachment {
                        *rng.choose(&initial_and_final_depth_stencil_layouts)
                    } else {
                        *rng.choose(color_layouts)
                    };

                    let stencil_load_op = *rng.choose(&load_ops);
                    let stencil_store_op = *rng.choose(&store_ops);

                    if is_depth_stencil_attachment {
                        let format = *rng.choose(&CORE_DEPTH_STENCIL_FORMATS);

                        if load_op == vk::AttachmentLoadOp::LOAD
                            || load_op == vk::AttachmentLoadOp::CLEAR
                            || stencil_load_op == vk::AttachmentLoadOp::LOAD
                            || stencil_load_op == vk::AttachmentLoadOp::CLEAR
                        {
                            defined_attachments.insert(attachment_index);
                        }

                        depth_stencil_attachments.insert(attachment_index);
                        attachments.push(attachment(
                            format,
                            load_op,
                            store_op,
                            stencil_load_op,
                            stencil_store_op,
                            initial_layout,
                            final_layout,
                        ));
                    } else {
                        let format = rng.choose(color_formats).0;

                        if load_op == vk::AttachmentLoadOp::LOAD || load_op == vk::AttachmentLoadOp::CLEAR {
                            defined_attachments.insert(attachment_index);
                        }

                        color_attachments.insert(attachment_index);
                        attachments.push(attachment(
                            format,
                            load_op,
                            store_op,
                            stencil_load_op,
                            stencil_store_op,
                            initial_layout,
                            final_layout,
                        ));
                    }
                }

                let mut last_use_of_attachment: Vec<Option<u32>> = vec![None; attachments.len()];

                for subpass_index in 0..subpass_count {
                    let max_color = (color_attachments.len() as u32).min(4);
                    let color_attachment_count = if depth_stencil_attachments.is_empty() {
                        1 + rng.get_uint32() % max_color
                    } else {
                        rng.get_uint32() % (max_color + 1)
                    };
                    let input_attachment_count = rng.get_uint32() % ((defined_attachments.len().min(4) as u32) + 1);
                    let use_depth_stencil_attachment =
                        !depth_stencil_attachments.is_empty() && (color_attachment_count == 0 || rng.get_bool());
                    let depth_stencil_attachment: Option<u32> = if use_depth_stencil_attachment {
                        Some(choose_random(&mut rng, &depth_stencil_attachments))
                    } else {
                        None
                    };

                    let color_pool: Vec<u32> = color_attachments.iter().copied().collect();
                    let defined_pool: Vec<u32> = defined_attachments.iter().copied().collect();
                    let subpass_color_attachments = rng.choose_n(&color_pool, color_attachment_count as usize);
                    let subpass_input_attachments = rng.choose_n(&defined_pool, input_attachment_count as usize);

                    for &color in &subpass_color_attachments {
                        defined_attachments.insert(color);
                    }
                    if let Some(depth_stencil) = depth_stencil_attachment {
                        defined_attachments.insert(depth_stencil);
                    }

                    let mut input_attachment_references: Vec<AttachmentReference> = Vec::new();
                    let mut color_attachment_references: Vec<AttachmentReference> = Vec::new();

                    for &color_attachment_index in &subpass_color_attachments {
                        if let Some(src_pass) = last_use_of_attachment[color_attachment_index as usize] {
                            let flags = by_region(&mut rng);
                            add_dependency(
                                &mut dependencies,
                                src_pass,
                                subpass_index,
                                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                                vk::AccessFlags::COLOR_ATTACHMENT_READ,
                                flags,
                                |dependency| dependency.dst_access_mask |= vk::AccessFlags::COLOR_ATTACHMENT_READ,
                            );
                        }

                        last_use_of_attachment[color_attachment_index as usize] = Some(subpass_index);
                        color_attachment_references.push(AttachmentReference::new(
                            color_attachment_index,
                            vk::ImageLayout::GENERAL,
                        ));
                    }

                    for &input_attachment_index in &subpass_input_attachments {
                        if let Some(src_pass) = last_use_of_attachment[input_attachment_index as usize] {
                            let flags = if src_pass == subpass_index || rng.get_bool() {
                                vk::DependencyFlags::BY_REGION
                            } else {
                                vk::DependencyFlags::empty()
                            };
                            add_dependency(
                                &mut dependencies,
                                src_pass,
                                subpass_index,
                                vk::AccessFlags::COLOR_ATTACHMENT_WRITE
                                    | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                                vk::AccessFlags::INPUT_ATTACHMENT_READ,
                                flags,
                                |dependency| dependency.dst_access_mask |= vk::AccessFlags::INPUT_ATTACHMENT_READ,
                            );

                            last_use_of_attachment[input_attachment_index as usize] = Some(subpass_index);

                            let aspect = if render_pass_type == RenderPassType::RenderPass2 {
                                if color_attachments.contains(&input_attachment_index) {
                                    vk::ImageAspectFlags::COLOR
                                } else {
                                    vk::ImageAspectFlags::DEPTH
                                }
                            } else {
                                vk::ImageAspectFlags::empty()
                            };
                            input_attachment_references.push(AttachmentReference::with_aspect(
                                input_attachment_index,
                                vk::ImageLayout::GENERAL,
                                aspect,
                            ));
                        }
                    }

                    let mut depth_stencil_attachment_reference =
                        AttachmentReference::new(ATTACHMENT_UNUSED, vk::ImageLayout::GENERAL);
                    if let Some(depth_stencil) = depth_stencil_attachment {
                        if let Some(src_pass) = last_use_of_attachment[depth_stencil as usize] {
                            let flags = if src_pass == subpass_index || rng.get_bool() {
                                vk::DependencyFlags::BY_REGION
                            } else {
                                vk::DependencyFlags::empty()
                            };
                            add_dependency(
                                &mut dependencies,
                                src_pass,
                                subpass_index,
                                vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                                vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ | vk::AccessFlags::INPUT_ATTACHMENT_READ,
                                flags,
                                |dependency| {
                                    dependency.dst_access_mask |= vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ
                                        | vk::AccessFlags::INPUT_ATTACHMENT_READ
                                },
                            );
                        }

                        last_use_of_attachment[depth_stencil as usize] = Some(subpass_index);
                        depth_stencil_attachment_reference =
                            AttachmentReference::new(depth_stencil, vk::ImageLayout::GENERAL);
                    }

                    let preserve_attachments: Vec<u32> = (0..attachments.len() as u32)
                        .filter(|&attachment_index| {
                            last_use_of_attachment[attachment_index as usize]
                                .is_some_and(|last_use| last_use != subpass_index)
                        })
                        .collect();

                    // Use random image layout when possible
                    for color_reference in &mut color_attachment_references {
                        let used_as_input = input_attachment_references
                            .iter()
                            .any(|input| input.attachment == color_reference.attachment);
                        if !used_as_input {
                            color_reference.layout = *rng.choose(&subpass_layouts_color);
                        }
                    }
                    for input_reference in &mut input_attachment_references {
                        let used_as_depth_stencil =
                            input_reference.attachment == depth_stencil_attachment_reference.attachment;
                        let used_as_color = color_attachment_references
                            .iter()
                            .any(|color| color.attachment == input_reference.attachment);
                        if !used_as_color && !used_as_depth_stencil {
                            input_reference.layout = *rng.choose(&subpass_layouts_input);
                        }
                    }
                    {
                        let used_as_input = input_attachment_references
                            .iter()
                            .any(|input| input.attachment == depth_stencil_attachment_reference.attachment);
                        if !used_as_input {
                            depth_stencil_attachment_reference.layout = *rng.choose(&subpass_layouts_depth_stencil);
                        }
                    }

                    subpasses.push(Subpass {
                        input_attachments: input_attachment_references,
                        color_attachments: color_attachment_references,
                        depth_stencil_attachment: depth_stencil_attachment_reference,
                        omit_blend_state: false,
                        preserve_attachments,
                    });
                }
            } else {
                let attachment_count = *rng.choose(&attachment_counts);

                for _ in 0..attachment_count {
                    let format = rng.choose(color_formats).0;
                    let load_op = *rng.choose(&load_ops);
                    let store_op = *rng.choose(&store_ops);
                    let initial_layout = *rng.choose(color_layouts);
                    let final_layout = *rng.choose(color_layouts);
                    let stencil_load_op = *rng.choose(&load_ops);
                    let stencil_store_op = *rng.choose(&store_ops);

                    attachments.push(attachment(
                        format,
                        load_op,
                        store_op,
                        stencil_load_op,
                        stencil_store_op,
                        initial_layout,
                        final_layout,
                    ));
                }

                let color_references =
                    |rng: &mut Random, indices: &mut dyn Iterator<Item = u32>| -> Vec<AttachmentReference> {
                        indices
                            .map(|attachment_ndx| {
                                AttachmentReference::new(attachment_ndx, *rng.choose(&subpass_layouts_color))
                            })
                            .collect()
                    };

                match allocation_type {
                    AllocationType::Grow => {
                        for subpass_ndx in 0..attachment_count {
                            let references = color_references(&mut rng, &mut (0..subpass_ndx + 1));
                            subpasses.push(color_subpass(references));
                        }
                    }
                    AllocationType::Shrink => {
                        for subpass_ndx in 0..attachment_count {
                            let references = color_references(&mut rng, &mut (0..attachment_count - subpass_ndx));
                            subpasses.push(color_subpass(references));
                        }
                    }
                    AllocationType::Roll => {
                        for subpass_ndx in 0..attachment_count / 2 {
                            let references = color_references(
                                &mut rng,
                                &mut (0..attachment_count / 2).map(|attachment_ndx| subpass_ndx + attachment_ndx),
                            );
                            subpasses.push(color_subpass(references));
                        }
                    }
                    AllocationType::GrowShrink => {
                        for subpass_ndx in 0..attachment_count {
                            let references = color_references(&mut rng, &mut (0..subpass_ndx + 1));
                            subpasses.push(color_subpass(references));
                        }
                        for subpass_ndx in 0..attachment_count {
                            let references = color_references(&mut rng, &mut (0..attachment_count - subpass_ndx));
                            subpasses.push(color_subpass(references));
                        }
                    }
                    AllocationType::IoChain => {
                        let first = color_references(&mut rng, &mut (0..1));
                        subpasses.push(color_subpass(first));

                        for subpass_ndx in 1..attachment_count {
                            let input_aspect = if render_pass_type == RenderPassType::RenderPass2 {
                                vk::ImageAspectFlags::COLOR
                            } else {
                                vk::ImageAspectFlags::empty()
                            };
                            let output = color_references(&mut rng, &mut (subpass_ndx..subpass_ndx + 1));
                            subpasses.push(Subpass {
                                input_attachments: vec![AttachmentReference::with_aspect(
                                    subpass_ndx - 1,
                                    vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                                    input_aspect,
                                )],
                                color_attachments: output,
                                depth_stencil_attachment: AttachmentReference::new(
                                    ATTACHMENT_UNUSED,
                                    vk::ImageLayout::GENERAL,
                                ),
                                omit_blend_state: false,
                                preserve_attachments: Vec::new(),
                            });
                        }
                    }
                    AllocationType::IoGeneric => unreachable!("handled above"),
                }
            }

            let render_types = *rng.choose(&render_commands);
            let command_buffer_types = *rng.choose(&command_buffers);
            let test_case_name = test_case_ndx.to_string();
            let target_size = *rng.choose(&target_sizes);
            let render_pos = *rng.choose(&render_positions);
            let render_size = *rng.choose(&render_sizes);

            if allocation_type != AllocationType::IoGeneric {
                for subpass_ndx in 0..subpasses.len() - 1 {
                    let by_region = rng.get_bool();
                    dependencies.push(SubpassDependency {
                        src_pass: subpass_ndx as u32,
                        dst_pass: subpass_ndx as u32 + 1,
                        src_stage_mask: fragment_and_attachment_stages(),
                        dst_stage_mask: fragment_and_attachment_stages(),
                        src_access_mask: vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                        dst_access_mask: vk::AccessFlags::COLOR_ATTACHMENT_READ
                            | vk::AccessFlags::INPUT_ATTACHMENT_READ,
                        flags: if by_region {
                            vk::DependencyFlags::BY_REGION
                        } else {
                            vk::DependencyFlags::empty()
                        },
                    });
                }
            }

            let render_pass = RenderPassDesc {
                attachments,
                subpasses,
                dependencies,
                input_aspects: Vec::new(),
            };
            let mut config = TestConfig::with_memory(
                render_pass,
                render_types,
                command_buffer_types,
                image_memory,
                target_size,
                render_pos,
                render_size,
                false,
                80329,
                allocation_kind,
                render_pass_type,
            );
            config.program_key = Some(format!("alloc/{type_name}/{test_case_ndx}"));

            allocation_type_group.add_child(Box::new(RenderPassTestCase {
                name: test_case_name,
                config,
            }) as Box<dyn TestCase>);
        }

        group.add_child(allocation_type_group);
    }
}
