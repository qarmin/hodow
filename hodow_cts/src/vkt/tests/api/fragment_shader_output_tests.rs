// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiFragmentShaderOutputTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2022 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// A fragment shader writes one output per attachment, with a GLSL type chosen from the format it is
// meant to target; the attachments are R8 UNORM/SNORM/UINT/SINT in various orders. The three groups
// drop the output of one attachment, move it to a location with no attachment, or mismatch the type
// and the format outright. Upstream builds the shader text per case; here every distinct
// (case, types) pair is one entry of `shaders/manifest/api_fragment_shader_output.toml`.

use vulkanalia::prelude::v1_0::*;

use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_subresource_layers, make_image_subresource_range,
    make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_graphics_pipeline_full, make_memory_barrier, make_pipeline_layout,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// The manifest declares its cases with this: the shader pair plus the two things it was built from.
pub struct FragmentOutputProgram {
    pub name: &'static str,
    pub kind: u32,
    pub types: &'static str,
    pub programs: BinaryCollection,
}

use crate::generated::shaders::api_fragment_shader_output::ALL_FRAGMENT_OUTPUT_PROGRAM;

const UNSIGNED_INT_COLOR: u32 = 123;
const SIGNED_INT_COLOR: i32 = 111;

/// `ShaderOutputCases`
#[derive(Clone, Copy, PartialEq, Eq)]
enum ShaderOutputCases {
    LocationNoAttachment,
    AttachmentNoLocation,
    DifferentSignedness,
}

impl ShaderOutputCases {
    /// The `kind` the manifest names the case by.
    fn kind(self) -> u32 {
        match self {
            ShaderOutputCases::LocationNoAttachment => 0,
            ShaderOutputCases::AttachmentNoLocation => 1,
            ShaderOutputCases::DifferentSignedness => 2,
        }
    }
}

/// The four formats of `formatsWithNames`, in the order upstream lists them.
#[derive(Clone, Copy, PartialEq, Eq)]
enum OutputFormat {
    Unorm,
    Snorm,
    Uint,
    Sint,
}

const ALL_FORMATS: [OutputFormat; 4] = [
    OutputFormat::Unorm,
    OutputFormat::Snorm,
    OutputFormat::Uint,
    OutputFormat::Sint,
];

impl OutputFormat {
    fn vk_format(self) -> vk::Format {
        match self {
            OutputFormat::Unorm => vk::Format::R8_UNORM,
            OutputFormat::Snorm => vk::Format::R8_SNORM,
            OutputFormat::Uint => vk::Format::R8_UINT,
            OutputFormat::Sint => vk::Format::R8_SINT,
        }
    }

    fn name(self) -> &'static str {
        match self {
            OutputFormat::Unorm => "unorm",
            OutputFormat::Snorm => "snorm",
            OutputFormat::Uint => "uint",
            OutputFormat::Sint => "sint",
        }
    }

    /// The third member of upstream's `FormatWithName` tuple.
    fn is_integer(self) -> bool {
        matches!(self, OutputFormat::Uint | OutputFormat::Sint)
    }

    fn is_uint(self) -> bool {
        self == OutputFormat::Uint
    }

    fn is_int(self) -> bool {
        self == OutputFormat::Sint
    }

    fn is_unorm(self) -> bool {
        self == OutputFormat::Unorm
    }

    /// The letter the manifest uses for the GLSL type of the shader output.
    fn type_letter(self) -> char {
        if self.is_uint() {
            'u'
        } else if self.is_int() {
            's'
        } else {
            'f'
        }
    }
}

/// `TestConfig`: (shader format, render format) per attachment.
#[derive(Clone)]
struct TestConfig {
    the_case: ShaderOutputCases,
    formats: Vec<(OutputFormat, OutputFormat)>,
}

impl TestConfig {
    fn shader_formats(&self) -> Vec<OutputFormat> {
        self.formats.iter().map(|pair| pair.0).collect()
    }

    fn render_formats(&self) -> Vec<OutputFormat> {
        self.formats.iter().map(|pair| pair.1).collect()
    }
}

/// `FragmentShaderOutputCase`
struct FragmentShaderOutputCase {
    name: String,
    config: TestConfig,
}

impl TestCase for FragmentShaderOutputCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let render_formats = self.config.render_formats();
        let max_color_attachments = context.get_device_properties().limits.max_color_attachments;

        if self.config.the_case == ShaderOutputCases::LocationNoAttachment {
            if render_formats.len() as u32 + 1 > max_color_attachments {
                return Err(TestError::NotSupported(format!(
                    "Shader output location ({}) exceeds VkPhysicalDeviceLimits::maxColorAttachments ({})",
                    render_formats.len() + 1,
                    max_color_attachments
                )));
            }
        } else if render_formats.len() as u32 > max_color_attachments {
            return Err(TestError::NotSupported(format!(
                "Used attachment count ({}) exceeds VkPhysicalDeviceLimits::maxColorAttachments ({})",
                render_formats.len(),
                max_color_attachments
            )));
        }

        let required = vk::FormatFeatureFlags::COLOR_ATTACHMENT | vk::FormatFeatureFlags::TRANSFER_SRC;
        for format in render_formats {
            let format_props = unsafe {
                context
                    .get_instance()
                    .get_physical_device_format_properties(context.get_physical_device(), format.vk_format())
            };
            if (format_props.optimal_tiling_features & required) != required {
                return Err(TestError::NotSupported(
                    "Unable to find a format with VK_FORMAT_FEATURE_COLOR_ATTACHMENT_BIT & VK_FORMAT_FEATURE_TRANSFER_SRC_BIT supported".to_string(),
                ));
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.program().programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(FragmentShaderOutputInstance {
            context,
            config: self.config.clone(),
        })
    }
}

impl FragmentShaderOutputCase {
    /// `initPrograms`: the entry whose shader this configuration would have generated.
    fn program(&self) -> &'static FragmentOutputProgram {
        let types: String = self
            .config
            .shader_formats()
            .iter()
            .map(|format| format.type_letter())
            .collect();
        let kind = self.config.the_case.kind();
        ALL_FRAGMENT_OUTPUT_PROGRAM
            .iter()
            .copied()
            .find(|program| program.kind == kind && program.types == types)
            .expect("the manifest covers every case/type combination")
    }
}

/// `ut::makeClearColors`
fn make_clear_colors(formats: &[OutputFormat]) -> Vec<vk::ClearValue> {
    let mut clear_colors = Vec::new();
    let mut float_step = 0.5f32;
    let mut unsigned_step = 128u32;
    let mut signed_step = 64i32;

    for format in formats {
        if format.is_unorm() {
            clear_colors.push(vk::ClearValue {
                color: vk::ClearColorValue {
                    float32: [float_step / 2.0, float_step / 4.0, float_step / 8.0, 1.0],
                },
            });
            float_step /= 2.0;
        } else if format.is_uint() {
            clear_colors.push(vk::ClearValue {
                color: vk::ClearColorValue {
                    uint32: [unsigned_step / 2, unsigned_step / 4, unsigned_step / 8, 255],
                },
            });
            unsigned_step /= 2;
        } else {
            clear_colors.push(vk::ClearValue {
                color: vk::ClearColorValue {
                    int32: [signed_step / 2, signed_step / 4, signed_step / 8, 127],
                },
            });
            signed_step /= 2;
        }
    }
    clear_colors
}

/// The first channel of a texel of one of the four R8 formats, as the `tcu` accessor the
/// verification uses would return it.
fn pixel_uint(texel: u8) -> u32 {
    u32::from(texel)
}

fn pixel_int(texel: u8) -> i32 {
    i32::from(texel as i8)
}

fn pixel_float(format: OutputFormat, texel: u8) -> f32 {
    if format.is_unorm() {
        f32::from(texel) / 255.0
    } else {
        (f32::from(texel as i8) / 127.0).max(-1.0)
    }
}

fn buffer_texels<'b>(buffers: &'b [BufferWithMemory<'_>], buffer_index: usize, texel_count: usize) -> &'b [u8] {
    // SAFETY: the buffer holds one byte for each of `width * height` R8 texels and has been invalidated.
    unsafe { std::slice::from_raw_parts(buffers[buffer_index].get_allocation().get_host_ptr(), texel_count) }
}

/// `FragmentShaderOutputInstance`
struct FragmentShaderOutputInstance<'a> {
    context: &'a Context<'a>,
    config: TestConfig,
}

impl FragmentShaderOutputInstance<'_> {
    /// `createColorRenderPass`
    fn create_color_render_pass(&self, formats: &[OutputFormat]) -> Result<Unique<'_, vk::RenderPass>, TestError> {
        let device = self.context.get_device();
        let final_layout = vk::ImageLayout::TRANSFER_SRC_OPTIMAL;

        let attachment_descriptions: Vec<vk::AttachmentDescription> = formats
            .iter()
            .map(|format| {
                vk::AttachmentDescription::builder()
                    .format(format.vk_format())
                    .samples(vk::SampleCountFlags::_1)
                    .load_op(vk::AttachmentLoadOp::CLEAR)
                    .store_op(vk::AttachmentStoreOp::STORE)
                    .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                    .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                    .initial_layout(vk::ImageLayout::UNDEFINED)
                    .final_layout(final_layout)
                    .build()
            })
            .collect();
        let attachment_references: Vec<vk::AttachmentReference> = (0..formats.len() as u32)
            .map(|attachment| {
                vk::AttachmentReference::builder()
                    .attachment(attachment)
                    .layout(final_layout)
                    .build()
            })
            .collect();

        let subpasses = [vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&attachment_references)
            .build()];
        let info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachment_descriptions)
            .subpasses(&subpasses);
        let handle = unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?;
        Ok(Unique::new(device, handle))
    }

    /// `verifyResults`
    fn verify_results(
        &self,
        buffers: &[BufferWithMemory<'_>],
        clear_colors: &[vk::ClearValue],
        width: u32,
        height: u32,
    ) -> Result<(), String> {
        let shader_formats = self.config.shader_formats();
        let render_formats = self.config.render_formats();
        let attachments = buffers.len();
        let texel_count = (width * height) as usize;

        let texels = |buffer_index: usize| buffer_texels(buffers, buffer_index, texel_count);

        let is_buffer_unchanged = |buffer_index: usize| -> bool {
            let render_format = render_formats[buffer_index];
            let clear = clear_colors[buffer_index];
            texels(buffer_index).iter().all(|&texel| {
                if render_format.is_uint() {
                    pixel_uint(texel) == unsafe { clear.color.uint32[0] }
                } else if render_format.is_int() {
                    pixel_int(texel) == unsafe { clear.color.int32[0] }
                } else {
                    let expected = unsafe { clear.color.float32[0] };
                    let actual = pixel_float(render_format, texel);
                    actual >= expected - 0.001 && actual <= expected + 0.001
                }
            })
        };
        let is_buffer_rendered = |buffer_index: usize| -> bool {
            let shader_format = shader_formats[buffer_index];
            let render_format = render_formats[buffer_index];
            texels(buffer_index).iter().all(|&texel| {
                if render_format.is_uint() {
                    let expected = if shader_format.is_int() {
                        SIGNED_INT_COLOR as u32
                    } else {
                        UNSIGNED_INT_COLOR
                    };
                    pixel_uint(texel) == expected
                } else if render_format.is_int() {
                    let expected = if shader_format.is_int() {
                        SIGNED_INT_COLOR
                    } else {
                        UNSIGNED_INT_COLOR as i32
                    };
                    pixel_int(texel) == expected
                } else {
                    pixel_float(render_format, texel) == 1.0
                }
            })
        };

        let result = if self.config.the_case == ShaderOutputCases::DifferentSignedness {
            (0..attachments).all(is_buffer_rendered)
        } else {
            let expected_location = attachments / 2;
            is_buffer_unchanged(expected_location)
                && (0..attachments)
                    .filter(|&a| a != expected_location)
                    .all(is_buffer_rendered)
        };

        if result {
            Ok(())
        } else {
            Err("One or more attachments rendered incorrectly".to_string())
        }
    }
}

impl TestInstance for FragmentShaderOutputInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let family_index = context.get_universal_queue_family_index();
        let allocator = context.get_default_allocator();

        let width = 64u32;
        let height = 64u32;

        let binaries = context.get_binary_collection();
        let vertex = create_shader_module(device, binaries.get("vert")?)?;
        let fragment = create_shader_module(device, binaries.get("frag")?)?;

        let vertices: [f32; 24] = [
            1.0, -1.0, 0.0, 0.0, -1.0, -1.0, 0.0, 0.0, -1.0, 1.0, 0.0, 0.0, -1.0, 1.0, 0.0, 0.0, 1.0, 1.0, 0.0, 0.0,
            1.0, -1.0, 0.0, 0.0,
        ];
        let vertex_size = std::mem::size_of_val(&vertices) as vk::DeviceSize;
        let vertex_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(vertex_size, vk::BufferUsageFlags::VERTEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE | MemoryRequirement::COHERENT,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                vertices.as_ptr() as *const u8,
                vertex_buffer.get_allocation().get_host_ptr(),
                vertex_size as usize,
            )
        };

        let attachments = self.config.formats.len();
        let formats = self.config.render_formats();
        let clear_colors = make_clear_colors(&formats);

        let mut images = Vec::with_capacity(attachments);
        let mut buffers = Vec::with_capacity(attachments);
        let mut image_views = Vec::with_capacity(attachments);
        for format in &formats {
            let image_info = vk::ImageCreateInfo::builder()
                .image_type(vk::ImageType::_2D)
                .format(format.vk_format())
                .extent(vk::Extent3D {
                    width,
                    height,
                    depth: 1,
                })
                .mip_levels(1)
                .array_layers(1)
                .samples(vk::SampleCountFlags::_1)
                .tiling(vk::ImageTiling::OPTIMAL)
                .usage(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC)
                .sharing_mode(vk::SharingMode::EXCLUSIVE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .build();
            let image = ImageWithMemory::new(device, allocator, image_info, MemoryRequirement::ANY)?;
            let buffer = BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info((width * height) as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_DST),
                MemoryRequirement::HOST_VISIBLE | MemoryRequirement::COHERENT,
            )?;
            let view = make_image_view(
                device,
                image.get(),
                vk::ImageViewType::_2D,
                format.vk_format(),
                make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
            )?;
            images.push(image);
            buffers.push(buffer);
            image_views.push(view);
        }
        let views: Vec<vk::ImageView> = image_views.iter().map(|view| **view).collect();

        let sres_layers = make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1);
        let copy_region = make_buffer_image_copy(
            vk::Extent3D {
                width,
                height,
                depth: 1,
            },
            sres_layers,
        );
        let pre_copy = make_memory_barrier(vk::AccessFlags::COLOR_ATTACHMENT_WRITE, vk::AccessFlags::TRANSFER_READ);

        let render_pass = self.create_color_render_pass(&formats)?;
        let framebuffer = make_framebuffer(device, *render_pass, &views, width, height, 1)?;
        let layout = make_pipeline_layout(device, &[])?;
        let pipeline = make_graphics_pipeline_full(
            device,
            *layout,
            *vertex,
            *fragment,
            *render_pass,
            (width, height),
            vk::PrimitiveTopology::TRIANGLE_LIST,
            vk::SampleCountFlags::_1,
            None,
            attachments,
            None,
        )?;

        let cmd_pool = make_command_pool(device, family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);

            let render_pass_begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(*render_pass)
                .framebuffer(*framebuffer)
                .render_area(vk::Rect2D {
                    offset: vk::Offset2D { x: 0, y: 0 },
                    extent: vk::Extent2D { width, height },
                })
                .clear_values(&clear_colors);
            device.cmd_begin_render_pass(cmd, &render_pass_begin_info, vk::SubpassContents::INLINE);
            device.cmd_draw(cmd, (vertices.len() / 4) as u32, 1, 0, 0);
            device.cmd_end_render_pass(cmd);

            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::BY_REGION,
                &[pre_copy],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
            for (image, buffer) in images.iter().zip(&buffers) {
                device.cmd_copy_image_to_buffer(
                    cmd,
                    image.get(),
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    buffer.get(),
                    &[copy_region],
                );
            }
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        for buffer in &buffers {
            invalidate_alloc(device, buffer.get_allocation())?;
        }

        Ok(match self.verify_results(&buffers, &clear_colors, width, height) {
            Ok(()) => TestStatus::pass(String::new()),
            Err(error) => TestStatus::fail(error),
        })
    }
}

/// `std::next_permutation` over indices.
fn next_permutation(indices: &mut [usize]) -> bool {
    let mut i = indices.len().saturating_sub(1);
    while i > 0 && indices[i - 1] >= indices[i] {
        i -= 1;
    }
    if i == 0 {
        return false;
    }
    let mut j = indices.len() - 1;
    while indices[j] <= indices[i - 1] {
        j -= 1;
    }
    indices.swap(i - 1, j);
    indices[i..].reverse();
    true
}

/// `makeTitle`
fn make_title(formats: &[(OutputFormat, OutputFormat)]) -> String {
    formats
        .iter()
        .map(|(shader, render)| format!("{}2{}", shader.name(), render.name()))
        .collect::<Vec<_>>()
        .join("_")
}

/// `createFragmentShaderOutputTests`
pub fn create_fragment_shader_output_tests() -> TestCaseGroup {
    let cases = [
        (ShaderOutputCases::LocationNoAttachment, "location_no_attachment", false),
        (ShaderOutputCases::AttachmentNoLocation, "attachment_no_location", false),
        (ShaderOutputCases::DifferentSignedness, "different_signedness", true),
    ];

    // The pairs for which the integer-ness of the two formats agrees, as `!(a ^ b)` selects.
    let mut signedness_formats: Vec<(OutputFormat, OutputFormat)> = Vec::new();
    for shader_format in ALL_FORMATS {
        for render_format in ALL_FORMATS {
            if shader_format.is_integer() == render_format.is_integer() {
                signedness_formats.push((shader_format, render_format));
            }
        }
    }

    let mut root = TestCaseGroup::new("fragment_shader_output");
    for (the_case, name, signedness) in cases {
        let mut format_group = TestCaseGroup::new(name);
        if signedness {
            for first in &signedness_formats {
                for second in &signedness_formats {
                    if first.0 == second.0 || first.1 == second.1 {
                        continue;
                    }

                    let config = TestConfig {
                        the_case,
                        formats: vec![*first, *second],
                    };
                    let title = make_title(&config.formats);
                    format_group
                        .add_child(Box::new(FragmentShaderOutputCase { name: title, config }) as Box<dyn TestCase>);
                }
            }
        } else {
            let mut permutation = [0usize, 1, 2, 3];
            while next_permutation(&mut permutation) {
                let formats = permutation
                    .iter()
                    .map(|&index| (ALL_FORMATS[index], ALL_FORMATS[index]))
                    .collect();
                let config = TestConfig { the_case, formats };
                let title = make_title(&config.formats);
                format_group.add_child(Box::new(FragmentShaderOutputCase { name: title, config }) as Box<dyn TestCase>);
            }
        }
        root.add_child(format_group);
    }
    root
}
