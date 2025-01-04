// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/renderpass/vktDynamicRenderingMultiviewClearTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Every value the test clears to (0.0, 1.0, 0, 255) is exactly representable in each of
// the formats, so the readback is compared as raw texels against the encoded reference
// instead of going through tcu::PixelBufferAccess and a threshold of 0.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::DeviceV1_3;

use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool};
use crate::vk::programs::BinaryCollection;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const NO_PROGRAMS: BinaryCollection = BinaryCollection::new(&[]);

const INITIAL_COLOR: [f32; 4] = [0.0, 0.0, 0.0, 1.0];
const INITIAL_DEPTH: f32 = 0.0;
const INITIAL_STENCIL: u32 = 0;
const RP_CLEAR_COLOR: [f32; 4] = [1.0, 1.0, 1.0, 1.0];
const RP_CLEAR_DEPTH: f32 = 1.0;
const RP_CLEAR_STENCIL: u32 = 255;

#[derive(Clone)]
struct TestParams {
    view_mask: u32,
    format: vk::Format,
    extent: [u32; 3],
    /// If not empty, `vkCmdClearAttachments` is used.
    clear_rects: Vec<vk::Rect2D>,
}

impl TestParams {
    fn new(view_mask: u32, format: vk::Format) -> Self {
        // A large default extent enables colour compression in some implementations.
        Self {
            view_mask,
            format,
            extent: [1024, 1024, 4],
            clear_rects: Vec::new(),
        }
    }

    fn is_depth_stencil(&self) -> bool {
        self.aspect_flags() != vk::ImageAspectFlags::COLOR
    }

    fn aspect_flags(&self) -> vk::ImageAspectFlags {
        match self.format {
            vk::Format::D16_UNORM => vk::ImageAspectFlags::DEPTH,
            vk::Format::D24_UNORM_S8_UINT | vk::Format::D32_SFLOAT_S8_UINT => {
                vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL
            }
            vk::Format::S8_UINT => vk::ImageAspectFlags::STENCIL,
            _ => vk::ImageAspectFlags::COLOR,
        }
    }

    fn usage(&self) -> vk::ImageUsageFlags {
        let attachment = if self.is_depth_stencil() {
            vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT
        } else {
            vk::ImageUsageFlags::COLOR_ATTACHMENT
        };
        attachment | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST
    }

    fn image_create_info(&self) -> vk::ImageCreateInfo {
        vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(self.format)
            .extent(vk::Extent3D {
                width: self.extent[0],
                height: self.extent[1],
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(self.extent[2])
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(self.usage())
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build()
    }

    fn pixel_count(&self) -> usize {
        self.extent[0] as usize * self.extent[1] as usize * self.extent[2] as usize
    }
}

/// How one aspect of the image is laid out in the buffer it is copied to: the texel size,
/// how many leading bytes of a texel carry the value, and the encoded initial/cleared texel.
struct PlaneEncoding {
    texel_size: usize,
    compared_bytes: usize,
    initial: Vec<u8>,
    cleared: Vec<u8>,
}

fn color_encoding() -> PlaneEncoding {
    let encode = |v: [f32; 4]| v.iter().map(|c| (c * 255.0).round() as u8).collect::<Vec<u8>>();
    PlaneEncoding {
        texel_size: 4,
        compared_bytes: 4,
        initial: encode(INITIAL_COLOR),
        cleared: encode(RP_CLEAR_COLOR),
    }
}

/// `getDepthCopyFormat`: D16 stays 16 bit, D24 is copied as X8_D24 (padding is not
/// compared), D32 as float.
fn depth_encoding(format: vk::Format) -> PlaneEncoding {
    match format {
        vk::Format::D16_UNORM => PlaneEncoding {
            texel_size: 2,
            compared_bytes: 2,
            initial: vec![0x00, 0x00],
            cleared: vec![0xff, 0xff],
        },
        vk::Format::D24_UNORM_S8_UINT => PlaneEncoding {
            texel_size: 4,
            compared_bytes: 3,
            initial: vec![0x00, 0x00, 0x00, 0x00],
            cleared: vec![0xff, 0xff, 0xff, 0x00],
        },
        _ => PlaneEncoding {
            texel_size: 4,
            compared_bytes: 4,
            initial: INITIAL_DEPTH.to_le_bytes().to_vec(),
            cleared: RP_CLEAR_DEPTH.to_le_bytes().to_vec(),
        },
    }
}

fn stencil_encoding() -> PlaneEncoding {
    PlaneEncoding {
        texel_size: 1,
        compared_bytes: 1,
        initial: vec![INITIAL_STENCIL as u8],
        cleared: vec![RP_CLEAR_STENCIL as u8],
    }
}

pub struct MultiviewClearTest {
    name: String,
    params: TestParams,
}

fn rect_contains(rect: &vk::Rect2D, x: i32, y: i32) -> bool {
    x >= rect.offset.x
        && y >= rect.offset.y
        && x < rect.offset.x + rect.extent.width as i32
        && y < rect.offset.y + rect.extent.height as i32
}

impl TestParams {
    /// Whether the reference has the clear value, rather than the initial one, at a texel.
    fn is_cleared(&self, x: i32, y: i32, z: u32) -> bool {
        if (1u32 << z) & self.view_mask == 0 {
            return false;
        }
        if self.clear_rects.is_empty() {
            return true;
        }
        self.clear_rects.iter().any(|rect| rect_contains(rect, x, y))
    }
}

impl TestCase for MultiviewClearTest {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_dynamic_rendering")?;
        context.require_device_functionality("VK_KHR_multiview")?;

        let create_info = self.params.image_create_info();
        let result = unsafe {
            context.get_instance().get_physical_device_image_format_properties(
                context.get_physical_device(),
                create_info.format,
                create_info.image_type,
                create_info.tiling,
                create_info.usage,
                create_info.flags,
            )
        };
        let format_properties = match result {
            Ok(properties) => properties,
            Err(vk::ErrorCode::FORMAT_NOT_SUPPORTED) => {
                return Err(TestError::NotSupported("Format not supported".into()));
            }
            Err(_) => {
                return Err(TestError::Fail(
                    "vkGetPhysicalDeviceImageFormatProperties failed unexpectedly".into(),
                ));
            }
        };

        if format_properties.max_array_layers < create_info.array_layers {
            return Err(TestError::NotSupported(
                "Required number of layers not supported".into(),
            ));
        }
        if format_properties.max_extent.width < create_info.extent.width
            || format_properties.max_extent.height < create_info.extent.height
        {
            return Err(TestError::NotSupported("Required extent not supported".into()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        NO_PROGRAMS
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MultiviewClearInstance {
            context,
            params: self.params.clone(),
        })
    }
}

struct MultiviewClearInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

impl MultiviewClearInstance<'_> {
    fn make_buffer(&self, plane: &PlaneEncoding) -> Result<BufferWithMemory<'_>, TestError> {
        let size = (plane.texel_size * self.params.pixel_count()) as u64;
        BufferWithMemory::new(
            self.context.get_device(),
            self.context.get_default_allocator(),
            make_buffer_create_info(size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )
    }

    /// Compares every layer of one plane against the reference; the first mismatch is described.
    fn verify_plane(
        &self,
        name: &str,
        buffer: &BufferWithMemory<'_>,
        plane: &PlaneEncoding,
    ) -> Result<Option<String>, TestError> {
        let device = self.context.get_device();
        invalidate_alloc(device, buffer.get_allocation())?;
        let total = plane.texel_size * self.params.pixel_count();
        let bytes = unsafe { std::slice::from_raw_parts(buffer.get_allocation().get_host_ptr(), total) };

        let [width, height, layers] = self.params.extent;
        for z in 0..layers {
            for y in 0..height as i32 {
                for x in 0..width as i32 {
                    let expected = if self.params.is_cleared(x, y, z) {
                        &plane.cleared
                    } else {
                        &plane.initial
                    };
                    let offset =
                        ((z as usize * height as usize + y as usize) * width as usize + x as usize) * plane.texel_size;
                    let texel = &bytes[offset..offset + plane.compared_bytes];
                    if texel != &expected[..plane.compared_bytes] {
                        return Ok(Some(format!(
                            "{name}-Layer{z}: texel ({x}, {y}) is {texel:02x?}, expected {:02x?}",
                            &expected[..plane.compared_bytes]
                        )));
                    }
                }
            }
        }
        Ok(None)
    }
}

fn image_barrier(
    image: vk::Image,
    range: vk::ImageSubresourceRange,
    src_access: vk::AccessFlags,
    dst_access: vk::AccessFlags,
    old_layout: vk::ImageLayout,
    new_layout: vk::ImageLayout,
) -> vk::ImageMemoryBarrier {
    vk::ImageMemoryBarrier::builder()
        .src_access_mask(src_access)
        .dst_access_mask(dst_access)
        .old_layout(old_layout)
        .new_layout(new_layout)
        .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
        .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
        .image(image)
        .subresource_range(range)
        .build()
}

impl TestInstance for MultiviewClearInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let params = &self.params;
        let device = self.context.get_device();
        let queue = self.context.get_universal_queue();

        let use_cmd = !params.clear_rects.is_empty();
        let create_info = params.image_create_info();
        let aspect_flags = params.aspect_flags();
        let has_color = aspect_flags.contains(vk::ImageAspectFlags::COLOR);
        let has_depth = aspect_flags.contains(vk::ImageAspectFlags::DEPTH);
        let has_stencil = aspect_flags.contains(vk::ImageAspectFlags::STENCIL);
        let is_ds = has_depth || has_stencil;
        let srr = vk::ImageSubresourceRange {
            aspect_mask: aspect_flags,
            base_mip_level: 0,
            level_count: create_info.mip_levels,
            base_array_layer: 0,
            layer_count: create_info.array_layers,
        };
        let rp_layout = if is_ds {
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL
        } else {
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL
        };

        let image = ImageWithMemory::new(
            device,
            self.context.get_default_allocator(),
            create_info,
            MemoryRequirement::ANY,
        )?;
        let image_view = make_image_view(device, image.get(), vk::ImageViewType::_2D_ARRAY, params.format, srr)?;

        let color_or_depth_plane = if has_color {
            Some(color_encoding())
        } else if has_depth {
            Some(depth_encoding(params.format))
        } else {
            None
        };
        let stencil_plane = has_stencil.then(stencil_encoding);
        let color_or_depth_buffer = color_or_depth_plane
            .as_ref()
            .map(|plane| self.make_buffer(plane))
            .transpose()?;
        let stencil_buffer = stencil_plane
            .as_ref()
            .map(|plane| self.make_buffer(plane))
            .transpose()?;

        let command_pool = make_command_pool(device, self.context.get_universal_queue_family_index())?;
        let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *command_buffer;

        let color_stages = vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT;
        let ds_stages = vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS;
        let t_dst = vk::ImageLayout::TRANSFER_DST_OPTIMAL;

        begin_command_buffer(device, cmd)?;
        unsafe {
            // Clear the image to a known value before starting.
            let barrier = image_barrier(
                image.get(),
                srr,
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                t_dst,
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[barrier],
            );
            if is_ds {
                device.cmd_clear_depth_stencil_image(
                    cmd,
                    image.get(),
                    t_dst,
                    &vk::ClearDepthStencilValue {
                        depth: INITIAL_DEPTH,
                        stencil: INITIAL_STENCIL,
                    },
                    &[srr],
                );
            } else {
                device.cmd_clear_color_image(
                    cmd,
                    image.get(),
                    t_dst,
                    &vk::ClearColorValue { float32: INITIAL_COLOR },
                    &[srr],
                );
            }
            let (dst_access, dst_stage) = if is_ds {
                (
                    vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                    ds_stages,
                )
            } else {
                (
                    vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    color_stages,
                )
            };
            let barrier = image_barrier(
                image.get(),
                srr,
                vk::AccessFlags::TRANSFER_WRITE,
                dst_access,
                t_dst,
                rp_layout,
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                dst_stage,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[barrier],
            );
        }

        let load_op = if use_cmd {
            vk::AttachmentLoadOp::LOAD
        } else {
            vk::AttachmentLoadOp::CLEAR
        };
        let rp_clear_value = if is_ds {
            vk::ClearValue {
                depth_stencil: vk::ClearDepthStencilValue {
                    depth: RP_CLEAR_DEPTH,
                    stencil: RP_CLEAR_STENCIL,
                },
            }
        } else {
            vk::ClearValue {
                color: vk::ClearColorValue {
                    float32: RP_CLEAR_COLOR,
                },
            }
        };
        let attachment_info = vk::RenderingAttachmentInfo::builder()
            .image_view(*image_view)
            .image_layout(rp_layout)
            .resolve_mode(vk::ResolveModeFlags::NONE)
            .resolve_image_layout(vk::ImageLayout::UNDEFINED)
            .load_op(load_op)
            .store_op(vk::AttachmentStoreOp::STORE)
            .clear_value(rp_clear_value)
            .build();
        let color_attachments = [attachment_info];
        let mut rendering_info = vk::RenderingInfo::builder()
            .render_area(vk::Rect2D {
                offset: vk::Offset2D { x: 0, y: 0 },
                extent: vk::Extent2D {
                    width: params.extent[0],
                    height: params.extent[1],
                },
            })
            .layer_count(1)
            .view_mask(params.view_mask);
        if has_color {
            rendering_info = rendering_info.color_attachments(&color_attachments);
        }
        if has_depth {
            rendering_info = rendering_info.depth_attachment(&attachment_info);
        }
        if has_stencil {
            rendering_info = rendering_info.stencil_attachment(&attachment_info);
        }

        unsafe {
            device.cmd_begin_rendering(cmd, &rendering_info);
            if use_cmd {
                let att_info = vk::ClearAttachment {
                    aspect_mask: aspect_flags,
                    color_attachment: 0,
                    clear_value: rp_clear_value,
                };
                // Layer info for the rectangles: 0 and 1 for multiview.
                let clear_rects: Vec<vk::ClearRect> = params
                    .clear_rects
                    .iter()
                    .map(|rect| vk::ClearRect {
                        rect: *rect,
                        base_array_layer: 0,
                        layer_count: 1,
                    })
                    .collect();
                device.cmd_clear_attachments(cmd, &[att_info], &clear_rects);
            }
            device.cmd_end_rendering(cmd);

            let (src_access, src_stage) = if is_ds {
                (vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE, ds_stages)
            } else {
                (vk::AccessFlags::COLOR_ATTACHMENT_WRITE, color_stages)
            };
            let barrier = image_barrier(
                image.get(),
                srr,
                src_access,
                vk::AccessFlags::TRANSFER_READ,
                rp_layout,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            );
            device.cmd_pipeline_barrier(
                cmd,
                src_stage,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[barrier],
            );

            let copy_region = |aspect_mask: vk::ImageAspectFlags| vk::BufferImageCopy {
                buffer_offset: 0,
                buffer_row_length: 0,
                buffer_image_height: 0,
                image_subresource: vk::ImageSubresourceLayers {
                    aspect_mask,
                    mip_level: 0,
                    base_array_layer: 0,
                    layer_count: params.extent[2],
                },
                image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                image_extent: vk::Extent3D {
                    width: params.extent[0],
                    height: params.extent[1],
                    depth: 1,
                },
            };
            if let Some(buffer) = &color_or_depth_buffer {
                let copy_aspect = if has_color {
                    vk::ImageAspectFlags::COLOR
                } else {
                    vk::ImageAspectFlags::DEPTH
                };
                device.cmd_copy_image_to_buffer(
                    cmd,
                    image.get(),
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    buffer.get(),
                    &[copy_region(copy_aspect)],
                );
            }
            if let Some(buffer) = &stencil_buffer {
                device.cmd_copy_image_to_buffer(
                    cmd,
                    image.get(),
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    buffer.get(),
                    &[copy_region(vk::ImageAspectFlags::STENCIL)],
                );
            }

            let host_barrier = vk::MemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
                .dst_access_mask(vk::AccessFlags::HOST_READ)
                .build();
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[host_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        let mut failures = Vec::new();
        if let (Some(buffer), Some(plane)) = (&color_or_depth_buffer, &color_or_depth_plane) {
            let name = if has_color { "Color" } else { "Depth" };
            failures.extend(self.verify_plane(name, buffer, plane)?);
        }
        if let (Some(buffer), Some(plane)) = (&stencil_buffer, &stencil_plane) {
            failures.extend(self.verify_plane("Stencil", buffer, plane)?);
        }

        if failures.is_empty() {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail(format!(
                "Unexpected results found in output buffers: {}",
                failures.join("; ")
            )))
        }
    }
}

/// `createDynamicRenderingMultiviewClearTests`
pub fn create_dynamic_rendering_multiview_clear_tests() -> TestCaseGroup {
    let mut main_group = TestCaseGroup::new("multiview_clear");

    let format_list = [
        (vk::Format::R8G8B8A8_UNORM, "r8g8b8a8_unorm"),
        (vk::Format::D16_UNORM, "d16_unorm"),
        (vk::Format::D24_UNORM_S8_UINT, "d24_unorm_s8_uint"),
        (vk::Format::D32_SFLOAT_S8_UINT, "d32_sfloat_s8_uint"),
        (vk::Format::S8_UINT, "s8_uint"),
    ];

    for (format, group_name) in format_list {
        let mut format_group = TestCaseGroup::new(group_name);
        for view_mask in [1u32, 2, 4, 8, 15] {
            let test_name = format!("view_mask_0x{view_mask:x}");

            let mut params = TestParams::new(view_mask, format);
            format_group.add_child(Box::new(MultiviewClearTest {
                name: format!("{test_name}_render_pass"),
                params: params.clone(),
            }) as Box<dyn TestCase>);

            let quad_w = params.extent[0] / 2;
            let quad_h = params.extent[1] / 2;
            let quad_extent = vk::Extent2D {
                width: quad_w,
                height: quad_h,
            };
            params.clear_rects.push(vk::Rect2D {
                offset: vk::Offset2D { x: quad_w as i32, y: 0 },
                extent: quad_extent,
            });
            params.clear_rects.push(vk::Rect2D {
                offset: vk::Offset2D { x: 0, y: quad_h as i32 },
                extent: quad_extent,
            });
            format_group.add_child(Box::new(MultiviewClearTest {
                name: format!("{test_name}_clear_regions"),
                params: params.clone(),
            }) as Box<dyn TestCase>);

            params.clear_rects.clear();
            params.clear_rects.push(vk::Rect2D {
                offset: vk::Offset2D { x: 0, y: 0 },
                extent: vk::Extent2D {
                    width: params.extent[0],
                    height: params.extent[1],
                },
            });
            format_group.add_child(Box::new(MultiviewClearTest {
                name: format!("{test_name}_clear_full"),
                params,
            }) as Box<dyn TestCase>);
        }
        main_group.add_child(format_group);
    }

    main_group
}
