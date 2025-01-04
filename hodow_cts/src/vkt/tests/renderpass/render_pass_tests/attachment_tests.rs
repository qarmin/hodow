// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/renderpass/vktRenderPassTests.cpp (`addSimpleTests`, `addAttachmentTests`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the render pass and renderpass2 variants exist here, so the branches
// that skip cases for dynamic rendering are not ported. The fragment shaders of both groups come from
// `scripts/gen_renderpass_attachment_shaders.py`, which replays the random draws of `addAttachmentTests` - any change to the
// order of the draws below has to be made there as well.

use super::*;

/// `s_coreDepthStencilFormats`
pub(super) const CORE_DEPTH_STENCIL_FORMATS: [vk::Format; 5] = [
    vk::Format::D16_UNORM,
    vk::Format::X8_D24_UNORM_PACK32,
    vk::Format::D32_SFLOAT,
    vk::Format::D24_UNORM_S8_UINT,
    vk::Format::D32_SFLOAT_S8_UINT,
];

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

fn single_subpass(
    color_attachments: Vec<AttachmentReference>,
    depth_stencil_attachment: AttachmentReference,
) -> Subpass {
    Subpass {
        input_attachments: Vec::new(),
        color_attachments,
        depth_stencil_attachment,
        omit_blend_state: false,
        preserve_attachments: Vec::new(),
    }
}

/// `addSimpleTests`
pub(super) fn add_simple_tests(
    group: &mut TestCaseGroup,
    allocation_kind: AllocationKind,
    render_pass_type: RenderPassType,
) {
    const TARGET_SIZE: [u32; 2] = [64, 64];
    const RENDER_POS: [u32; 2] = [0, 0];
    const RENDER_SIZE: [u32; 2] = [64, 64];

    let color_layout = vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL;
    let ds_layout = vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL;
    let unused_ds = AttachmentReference::new(ATTACHMENT_UNUSED, vk::ImageLayout::GENERAL);

    let color_attachment = attachment(
        vk::Format::R8G8B8A8_UNORM,
        vk::AttachmentLoadOp::CLEAR,
        vk::AttachmentStoreOp::STORE,
        vk::AttachmentLoadOp::DONT_CARE,
        vk::AttachmentStoreOp::DONT_CARE,
        color_layout,
        color_layout,
    );
    let depth_attachment = attachment(
        vk::Format::X8_D24_UNORM_PACK32,
        vk::AttachmentLoadOp::CLEAR,
        vk::AttachmentStoreOp::STORE,
        vk::AttachmentLoadOp::DONT_CARE,
        vk::AttachmentStoreOp::DONT_CARE,
        ds_layout,
        ds_layout,
    );
    let stencil_attachment = attachment(
        vk::Format::S8_UINT,
        vk::AttachmentLoadOp::DONT_CARE,
        vk::AttachmentStoreOp::DONT_CARE,
        vk::AttachmentLoadOp::CLEAR,
        vk::AttachmentStoreOp::STORE,
        ds_layout,
        ds_layout,
    );
    let depth_stencil_attachment = attachment(
        vk::Format::D24_UNORM_S8_UINT,
        vk::AttachmentLoadOp::CLEAR,
        vk::AttachmentStoreOp::STORE,
        vk::AttachmentLoadOp::CLEAR,
        vk::AttachmentStoreOp::STORE,
        ds_layout,
        ds_layout,
    );

    let cases: Vec<(&str, RenderPassDesc)> = vec![
        (
            "color",
            RenderPassDesc {
                attachments: vec![color_attachment],
                subpasses: vec![single_subpass(
                    vec![AttachmentReference::new(0, color_layout)],
                    unused_ds,
                )],
                dependencies: Vec::new(),
                input_aspects: Vec::new(),
            },
        ),
        (
            "depth",
            RenderPassDesc {
                attachments: vec![depth_attachment],
                subpasses: vec![single_subpass(Vec::new(), AttachmentReference::new(0, ds_layout))],
                dependencies: Vec::new(),
                input_aspects: Vec::new(),
            },
        ),
        (
            "stencil",
            RenderPassDesc {
                attachments: vec![stencil_attachment],
                subpasses: vec![single_subpass(Vec::new(), AttachmentReference::new(0, ds_layout))],
                dependencies: Vec::new(),
                input_aspects: Vec::new(),
            },
        ),
        (
            "depth_stencil",
            RenderPassDesc {
                attachments: vec![depth_stencil_attachment],
                subpasses: vec![single_subpass(Vec::new(), AttachmentReference::new(0, ds_layout))],
                dependencies: Vec::new(),
                input_aspects: Vec::new(),
            },
        ),
        (
            "color_depth",
            RenderPassDesc {
                attachments: vec![color_attachment, depth_attachment],
                subpasses: vec![single_subpass(
                    vec![AttachmentReference::new(0, color_layout)],
                    AttachmentReference::new(1, ds_layout),
                )],
                dependencies: Vec::new(),
                input_aspects: Vec::new(),
            },
        ),
        (
            "color_stencil",
            RenderPassDesc {
                attachments: vec![color_attachment, stencil_attachment],
                subpasses: vec![single_subpass(
                    vec![AttachmentReference::new(0, color_layout)],
                    AttachmentReference::new(1, ds_layout),
                )],
                dependencies: Vec::new(),
                input_aspects: Vec::new(),
            },
        ),
        (
            "color_depth_stencil",
            RenderPassDesc {
                attachments: vec![color_attachment, depth_stencil_attachment],
                subpasses: vec![single_subpass(
                    vec![AttachmentReference::new(0, color_layout)],
                    AttachmentReference::new(1, ds_layout),
                )],
                dependencies: Vec::new(),
                input_aspects: Vec::new(),
            },
        ),
        (
            "no_attachments",
            RenderPassDesc {
                attachments: Vec::new(),
                subpasses: vec![single_subpass(Vec::new(), unused_ds)],
                dependencies: Vec::new(),
                input_aspects: Vec::new(),
            },
        ),
        (
            // First subpass uses the colour attachment with a colour blend state, the second only references an unused one and
            // is created without a blend state.
            "color_unused_omit_blend_state",
            RenderPassDesc {
                attachments: vec![color_attachment],
                subpasses: vec![
                    single_subpass(vec![AttachmentReference::new(0, color_layout)], unused_ds),
                    Subpass {
                        input_attachments: Vec::new(),
                        color_attachments: vec![AttachmentReference::new(ATTACHMENT_UNUSED, color_layout)],
                        depth_stencil_attachment: unused_ds,
                        omit_blend_state: true,
                        preserve_attachments: Vec::new(),
                    },
                ],
                dependencies: Vec::new(),
                input_aspects: Vec::new(),
            },
        ),
    ];

    for (name, render_pass) in cases {
        // Subpasses cannot be translated to dynamic rendering.
        if render_pass_type.is_dynamic_rendering() && name == "color_unused_omit_blend_state" {
            continue;
        }
        let config = TestConfig::new(
            render_pass,
            RenderTypes::DRAW,
            TARGET_SIZE,
            RENDER_POS,
            RENDER_SIZE,
            false,
            90239,
            allocation_kind,
            render_pass_type,
        );
        group.add_child(Box::new(RenderPassTestCase {
            name: name.to_string(),
            config,
        }) as Box<dyn TestCase>);
    }
}

/// `addAttachmentTests`
pub(super) fn add_attachment_tests(
    group: &mut TestCaseGroup,
    allocation_kind: AllocationKind,
    render_pass_type: RenderPassType,
) {
    let attachment_counts = [1usize, 3, 4, 8];
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
    let initial_and_final_depth_stencil_layouts_lazy = [
        vk::ImageLayout::GENERAL,
        vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
        vk::ImageLayout::DEPTH_STENCIL_READ_ONLY_OPTIMAL,
        vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
    ];

    let subpass_layouts = [vk::ImageLayout::GENERAL, vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL];
    let depth_stencil_layouts = [
        vk::ImageLayout::GENERAL,
        vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
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

    // `s_coreColorFormats` is the first 48 entries of the list the `formats` group registers; the last one, A8_UNORM, is
    // appended there on its own.
    let color_formats = &CORE_COLOR_FORMATS[..CORE_COLOR_FORMATS.len() - 1];

    let use_dynamic_rendering = render_pass_type.is_dynamic_rendering();
    let mut rng = Random::new(1433774382);

    for (attachment_count_ndx, &attachment_count) in attachment_counts.iter().enumerate() {
        let test_case_count = if attachment_count == 1 { 100 } else { 200 };
        let mut attachment_count_group = TestCaseGroup::new(attachment_count.to_string());

        for test_case_ndx in 0..test_case_count {
            let use_depth_stencil = rng.get_bool();
            let image_memory = *rng.choose(&image_memories);
            let color_layouts: &[vk::ImageLayout] = if image_memory == ImageMemory::STRICT {
                &initial_and_final_color_layouts
            } else {
                &initial_and_final_color_layouts_lazy
            };
            let depth_stencil_layout_choices: &[vk::ImageLayout] = if image_memory == ImageMemory::STRICT {
                &initial_and_final_depth_stencil_layouts
            } else {
                &initial_and_final_depth_stencil_layouts_lazy
            };
            let mut depth_stencil_layout = vk::ImageLayout::GENERAL;
            let mut attachments = Vec::new();
            let mut color_attachment_references = Vec::new();

            // Dynamic rendering has no automatic layout transitions, and the cases that would need extra barriers add no coverage. The
            // configuration of every case is drawn all the same, so the ones that remain have the names of their render pass twins.
            let mut execute_for_dynamic_rendering = true;

            for attachment_ndx in 0..attachment_count {
                let format = rng.choose(color_formats).0;
                let load_op = *rng.choose(&load_ops);
                let store_op = *rng.choose(&store_ops);
                let initial_layout = *rng.choose(color_layouts);
                let mut final_layout = *rng.choose(color_layouts);
                let subpass_layout = *rng.choose(&subpass_layouts);
                let stencil_load_op = *rng.choose(&load_ops);
                let stencil_store_op = *rng.choose(&store_ops);

                if use_dynamic_rendering {
                    if initial_layout == vk::ImageLayout::GENERAL
                        || initial_layout == vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL
                    {
                        final_layout = initial_layout;
                    } else {
                        execute_for_dynamic_rendering = false;
                    }
                }

                attachments.push(attachment(
                    format,
                    load_op,
                    store_op,
                    stencil_load_op,
                    stencil_store_op,
                    initial_layout,
                    final_layout,
                ));
                color_attachment_references.push(AttachmentReference::new(attachment_ndx as u32, subpass_layout));
            }

            if use_depth_stencil {
                let format = *rng.choose(&CORE_DEPTH_STENCIL_FORMATS);
                let load_op = *rng.choose(&load_ops);
                let store_op = *rng.choose(&store_ops);
                let initial_layout = *rng.choose(depth_stencil_layout_choices);
                let mut final_layout = *rng.choose(depth_stencil_layout_choices);
                let stencil_load_op = *rng.choose(&load_ops);
                let stencil_store_op = *rng.choose(&store_ops);

                if use_dynamic_rendering {
                    if initial_layout == vk::ImageLayout::GENERAL
                        || initial_layout == vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL
                        || initial_layout == vk::ImageLayout::DEPTH_STENCIL_READ_ONLY_OPTIMAL
                    {
                        final_layout = initial_layout;
                    } else {
                        execute_for_dynamic_rendering = false;
                    }
                }

                depth_stencil_layout = *rng.choose(&depth_stencil_layouts);
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

            let render_types = *rng.choose(&render_commands);
            let command_buffer_types = *rng.choose(&command_buffers);
            let subpasses = vec![single_subpass(
                color_attachment_references,
                AttachmentReference::new(
                    if use_depth_stencil {
                        (attachments.len() - 1) as u32
                    } else {
                        ATTACHMENT_UNUSED
                    },
                    depth_stencil_layout,
                ),
            )];
            let test_case_name = (attachment_count_ndx * test_case_count + test_case_ndx).to_string();
            let render_pass = RenderPassDesc {
                attachments,
                subpasses,
                dependencies: Vec::new(),
                input_aspects: Vec::new(),
            };
            let target_size = *rng.choose(&target_sizes);
            let render_pos = *rng.choose(&render_positions);
            let render_size = *rng.choose(&render_sizes);

            // Skipped only now that every number has been drawn.
            if use_dynamic_rendering && !execute_for_dynamic_rendering {
                continue;
            }

            // The cases that do not record into a secondary command buffer are not repeated for the variant where it holds the whole
            // rendering.
            if render_pass_type == RenderPassType::DynamicRenderingCompleteSecondary
                && command_buffer_types != CommandBufferTypes::SECONDARY
            {
                continue;
            }

            let config = TestConfig::with_memory(
                render_pass,
                render_types,
                command_buffer_types,
                image_memory,
                target_size,
                render_pos,
                render_size,
                false,
                1293809,
                allocation_kind,
                render_pass_type,
            );
            attachment_count_group.add_child(Box::new(RenderPassTestCase {
                name: test_case_name,
                config,
            }) as Box<dyn TestCase>);
        }

        group.add_child(attachment_count_group);
    }
}

/// `addAttachmentWriteMaskTests`
pub(super) fn add_attachment_write_mask_tests(
    group: &mut TestCaseGroup,
    allocation_kind: AllocationKind,
    render_pass_type: RenderPassType,
) {
    let attachment_counts = [1u32, 2, 3, 4, 8];
    let attachment_formats = [
        vk::Format::R8G8B8A8_UINT,
        vk::Format::R8G8B8A8_UNORM,
        vk::Format::R5G6B5_UNORM_PACK16,
        vk::Format::R8G8_UNORM,
    ];

    for attachment_count in attachment_counts {
        let mut attachment_count_group = TestCaseGroup::new(format!("attachment_count_{attachment_count}"));

        for draw_start_ndx in 0..attachment_count {
            let mut attachments = Vec::new();
            let mut color_attachment_references = Vec::new();

            for attachment_ndx in 0..attachment_count {
                attachments.push(attachment(
                    attachment_formats[attachment_ndx as usize % attachment_formats.len()],
                    vk::AttachmentLoadOp::CLEAR,
                    vk::AttachmentStoreOp::STORE,
                    vk::AttachmentLoadOp::CLEAR,
                    vk::AttachmentStoreOp::STORE,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    if render_pass_type.is_dynamic_rendering() {
                        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL
                    } else {
                        vk::ImageLayout::TRANSFER_SRC_OPTIMAL
                    },
                ));
                color_attachment_references.push(AttachmentReference::new(attachment_ndx, vk::ImageLayout::GENERAL));
            }

            let render_pass = RenderPassDesc {
                attachments,
                subpasses: vec![single_subpass(
                    color_attachment_references,
                    AttachmentReference::new(ATTACHMENT_UNUSED, vk::ImageLayout::GENERAL),
                )],
                dependencies: Vec::new(),
                input_aspects: Vec::new(),
            };

            let mut config = TestConfig::with_memory(
                render_pass,
                RenderTypes::DRAW,
                CommandBufferTypes::INLINE,
                ImageMemory::LAZY,
                [64, 64],
                [0, 0],
                [64, 64],
                true,
                1293809,
                allocation_kind,
                render_pass_type,
            );
            config.draw_start_ndx = draw_start_ndx;
            config.requires_independent_blend = true;

            attachment_count_group.add_child(Box::new(RenderPassTestCase {
                name: format!("start_index_{draw_start_ndx}"),
                config,
            }) as Box<dyn TestCase>);
        }

        group.add_child(attachment_count_group);
    }
}

/// `addIgnoreDepthStencilAspectTests` - a combined depth/stencil image whose framebuffer view only has the aspect opposite to
/// the one the render pass uses it as.
pub(super) fn add_ignore_depth_stencil_aspect_tests(
    group: &mut TestCaseGroup,
    allocation_kind: AllocationKind,
    render_pass_type: RenderPassType,
) {
    const TARGET_SIZE: [u32; 2] = [64, 64];
    const RENDER_POS: [u32; 2] = [0, 0];
    const RENDER_SIZE: [u32; 2] = [64, 64];

    let load_ops = [
        ("clear", vk::AttachmentLoadOp::CLEAR),
        ("load", vk::AttachmentLoadOp::LOAD),
        ("dont_care", vk::AttachmentLoadOp::DONT_CARE),
    ];
    let render_types = [
        ("clear", RenderTypes::CLEAR),
        ("draw", RenderTypes::DRAW),
        ("clear_draw", RenderTypes::CLEAR.or(RenderTypes::DRAW)),
    ];
    let combined_depth_stencil_formats = [
        (vk::Format::D24_UNORM_S8_UINT, "d24_unorm_s8_uint"),
        (vk::Format::D32_SFLOAT_S8_UINT, "d32_sfloat_s8_uint"),
    ];

    for (format, format_name) in combined_depth_stencil_formats {
        let mut format_group = TestCaseGroup::new(format_name);

        for is_depth_attachment in [true, false] {
            for is_stencil_attachment in [true, false] {
                if is_depth_attachment == is_stencil_attachment {
                    continue;
                }

                // Use the aspect opposite to the attachment type
                let use_aspect = if is_depth_attachment {
                    vk::ImageAspectFlags::STENCIL
                } else {
                    vk::ImageAspectFlags::DEPTH
                };
                let combo_group_name = format!(
                    "{}_attachment_{}_aspect",
                    if is_depth_attachment { "depth" } else { "stencil" },
                    if use_aspect == vk::ImageAspectFlags::DEPTH {
                        "depth"
                    } else {
                        "stencil"
                    }
                );
                let mut combo_group = TestCaseGroup::new(combo_group_name);

                for (load_op_name, load_op) in load_ops {
                    let mut load_op_group = TestCaseGroup::new(load_op_name);

                    for (render_type_name, render_type) in render_types {
                        let mut ds_attachment = attachment(
                            format,
                            if is_depth_attachment {
                                load_op
                            } else {
                                vk::AttachmentLoadOp::DONT_CARE
                            },
                            if is_depth_attachment {
                                vk::AttachmentStoreOp::STORE
                            } else {
                                vk::AttachmentStoreOp::DONT_CARE
                            },
                            if is_stencil_attachment {
                                load_op
                            } else {
                                vk::AttachmentLoadOp::DONT_CARE
                            },
                            if is_stencil_attachment {
                                vk::AttachmentStoreOp::STORE
                            } else {
                                vk::AttachmentStoreOp::DONT_CARE
                            },
                            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                        );
                        ds_attachment.aspect = use_aspect;

                        let render_pass = RenderPassDesc {
                            attachments: vec![ds_attachment],
                            subpasses: vec![single_subpass(
                                Vec::new(),
                                AttachmentReference::new(0, vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL),
                            )],
                            dependencies: Vec::new(),
                            input_aspects: Vec::new(),
                        };
                        let config = TestConfig::new(
                            render_pass,
                            render_type,
                            TARGET_SIZE,
                            RENDER_POS,
                            RENDER_SIZE,
                            false,
                            90239,
                            allocation_kind,
                            render_pass_type,
                        );

                        load_op_group.add_child(Box::new(RenderPassTestCase {
                            name: render_type_name.to_string(),
                            config,
                        }) as Box<dyn TestCase>);
                    }

                    combo_group.add_child(load_op_group);
                }

                format_group.add_child(combo_group);
            }
        }

        group.add_child(format_group);
    }
}
