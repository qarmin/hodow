// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/shaderrender/vktShaderRender.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `ShaderRenderCase` and `ShaderRenderCaseInstance` reduced to what the cases that use plain
// position, coordinate and constant attributes and integer or float uniforms need: the `QuadGrid` (positions, coords, unit coords and the constant
// attribute one at locations 0 to 3), one uniform buffer per `useUniform` binding, a 128x128 RGBA8 target cleared to the default colour, the
// CPU reference of `computeVertexReference` / `computeFragmentReference` and the fuzzy comparison (threshold 0.2). Textures, user attributes,
// push constants, sparse images, multisampling and the compute variant are not ported. The shaders are written by
// `scripts/gen_shader_render_programs.py`, `gen_shader_render_loops.py` and `gen_shader_render_indexing.py` (`shaders/manifest/shader_render.toml`, `shader_render_loops.toml`,
// `shader_render_indexing.toml`, one
// `sr_<group>_<case>` set with `vert` and `frag` each).

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::generated::shaders::shader_render::ALL_SHARED_PROGRAM;
use crate::generated::shaders::shader_render_builtin_var::ALL_SHARED_PROGRAM as BUILTIN_VAR_SHARED_PROGRAM;
use crate::generated::shaders::shader_render_derivate::ALL_SHARED_PROGRAM as DERIVATE_SHARED_PROGRAM;
use crate::generated::shaders::shader_render_indexing::ALL_SHARED_PROGRAM as INDEXING_SHARED_PROGRAM;
use crate::generated::shaders::shader_render_loops::ALL_SHARED_PROGRAM as LOOPS_SHARED_PROGRAM;
use crate::generated::shaders::shader_render_matrix::ALL_SHARED_PROGRAM as MATRIX_SHARED_PROGRAM;
use crate::generated::shaders::shader_render_operator::ALL_SHARED_PROGRAM as OPERATOR_SHARED_PROGRAM;
use crate::generated::shaders::shader_render_struct::ALL_SHARED_PROGRAM as STRUCT_SHARED_PROGRAM;
use crate::tcu::fuzzy_image_compare::fuzzy_compare_ok;
use crate::tcu::pixel::TextureLevel;
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat};
use crate::tcu::{IVec2, TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::image_util::{
    ImageWithMemory, make_image_create_info, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_framebuffer, make_pipeline_layout_with_push_constants, make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline};
use crate::vkt::{Context, TestCase, TestInstance};

const RENDER_WIDTH: u32 = 128;
const RENDER_HEIGHT: u32 = 128;
const GRID_SIZE_DEFAULT_VERTEX: usize = 90;
const GRID_SIZE_DEFAULT_FRAGMENT: usize = 4;
const DEFAULT_CLEAR_COLOR: [f32; 4] = [0.125, 0.25, 0.5, 1.0];
const FUZZY_THRESHOLD: f32 = 0.2;
/// `ShaderRenderCaseInstance::getDefaultConstCoords`
pub const DEFAULT_CONST_COORDS: [f32; 4] = [0.125, 0.25, 0.5, 1.0];

/// `ShaderEvalContext`
pub struct ShaderEvalContext {
    pub coords: [f32; 4],
    pub const_coords: [f32; 4],
    pub unit_coords: [f32; 4],
    /// `in[n]`: the user attributes
    pub inputs: [[f32; 4]; 4],
    pub color: [f32; 4],
    pub is_discarded: bool,
}

impl ShaderEvalContext {
    /// `ShaderEvalContext::reset`
    fn reset(&mut self, sx: f32, sy: f32, transforms: &[AttribTransform]) {
        self.color = [0.0, 0.0, 0.0, 1.0];
        self.is_discarded = false;
        self.const_coords = DEFAULT_CONST_COORDS;
        self.coords = quad_coords(sx, sy);
        self.unit_coords = quad_unit_coords(sx, sy);
        for (input, transform) in self.inputs.iter_mut().zip(transforms) {
            *input = apply_transform(transform, sx, sy);
        }
    }

    /// `ShaderEvalContext::discard`
    pub fn discard(&mut self) {
        self.is_discarded = true;
    }

    /// `color.xyz() = coords.swizzle(a, b, c)`
    pub fn set_color_from_coords(&mut self, a: usize, b: usize, c: usize) {
        self.color[0] = self.coords[a];
        self.color[1] = self.coords[b];
        self.color[2] = self.coords[c];
    }
}

/// `ShaderEvalFunc`
pub type ShaderEvalFunc = fn(&mut ShaderEvalContext);

/// The values of `BaseUniformType` the ported cases use, written as one `int` or `float` into a uniform buffer.
#[derive(Clone, Copy, Debug)]
pub enum UniformValue {
    Int(i32),
    Float(f32),
    /// `addUniform(binding, UNIFORM_BUFFER, sizeof(Vec4) * 4, ...)`: an array of four vec4
    Vec4s([[f32; 4]; 4]),
    /// `addUniform(binding, UNIFORM_BUFFER, sizeof(S), &s)`: a std140 struct written out by `gen_shader_render_struct.py` from the constant coordinates
    Raw(&'static [u8]),
}

impl UniformValue {
    fn to_bytes(self) -> Vec<u8> {
        match self {
            Self::Int(value) => value.to_ne_bytes().to_vec(),
            Self::Float(value) => value.to_ne_bytes().to_vec(),
            Self::Vec4s(values) => values.iter().flatten().flat_map(|value| value.to_ne_bytes()).collect(),
            Self::Raw(bytes) => bytes.to_vec(),
        }
    }
}

/// A user attribute transform (`m_userAttribTransforms`): the rows of the matrix applied to (sx, sy, 0, 1)
pub type AttribTransform = [[f32; 4]; 4];

/// `QuadGrid::getUserAttrib`
fn apply_transform(transform: &AttribTransform, sx: f32, sy: f32) -> [f32; 4] {
    std::array::from_fn(|row| transform[row][0] * sx + transform[row][1] * sy + transform[row][3])
}

/// `QuadGrid::getCoords`
fn quad_coords(sx: f32, sy: f32) -> [f32; 4] {
    let fx = 2.0 * sx - 1.0;
    let fy = 2.0 * sy - 1.0;
    [fx, fy, -fx + 0.33 * fy, -0.275 * fx - fy]
}

/// `QuadGrid::getUnitCoords`
fn quad_unit_coords(sx: f32, sy: f32) -> [f32; 4] {
    [sx, sy, 0.33 * sx + 0.5 * sy, 0.5 * sx + 0.25 * sy]
}

/// `QuadGrid`, with the vertex arrays and the indices of the triangles
struct QuadGrid {
    grid_size: usize,
    positions: Vec<[f32; 4]>,
    coords: Vec<[f32; 4]>,
    unit_coords: Vec<[f32; 4]>,
    attrib_one: Vec<f32>,
    user_attribs: Vec<Vec<[f32; 4]>>,
    indices: Vec<u16>,
}

impl QuadGrid {
    fn new(grid_size: usize, transforms: &[AttribTransform]) -> Self {
        let num_vertices = (grid_size + 1) * (grid_size + 1);
        let mut grid = Self {
            grid_size,
            positions: Vec::with_capacity(num_vertices),
            coords: Vec::with_capacity(num_vertices),
            unit_coords: Vec::with_capacity(num_vertices),
            attrib_one: vec![1.0; num_vertices],
            user_attribs: vec![Vec::with_capacity(num_vertices); transforms.len()],
            indices: Vec::with_capacity(grid_size * grid_size * 6),
        };

        for y in 0..=grid_size {
            for x in 0..=grid_size {
                let sx = x as f32 / grid_size as f32;
                let sy = y as f32 / grid_size as f32;
                grid.positions.push([2.0 * sx - 1.0, 2.0 * sy - 1.0, 0.0, 1.0]);
                grid.coords.push(quad_coords(sx, sy));
                grid.unit_coords.push(quad_unit_coords(sx, sy));
                for (attribs, transform) in grid.user_attribs.iter_mut().zip(transforms) {
                    attribs.push(apply_transform(transform, sx, sy));
                }
            }
        }

        let stride = grid_size + 1;
        for y in 0..grid_size {
            for x in 0..grid_size {
                let v00 = (y * stride + x) as u16;
                let v01 = (y * stride + x + 1) as u16;
                let v10 = ((y + 1) * stride + x) as u16;
                let v11 = ((y + 1) * stride + x + 1) as u16;
                grid.indices.extend_from_slice(&[v10, v00, v01, v10, v01, v11]);
            }
        }
        grid
    }

    fn num_vertices(&self) -> usize {
        self.positions.len()
    }
}

/// The reference colour as the 8 bit pixel `tcu::RGBA(Vec4)` makes of it
fn to_rgba8(color: [f32; 4]) -> [f32; 4] {
    color.map(|channel| (channel.clamp(0.0, 1.0) * 255.0 + 0.5).floor() / 255.0)
}

/// `ShaderRenderCase`
pub struct ShaderRenderCase {
    name: String,
    key: String,
    is_vertex_case: bool,
    eval: Box<dyn Fn(&mut ShaderEvalContext) + Send + Sync>,
    uniforms: Vec<(u32, UniformValue)>,
    /// `pixelThresholdCompare` with a threshold of one instead of the fuzzy comparison
    exact_compare: bool,
    requires_demote: bool,
    /// The reason a case that needs something this port lacks does not run
    stub: Option<&'static str>,
    user_attrib_transforms: Vec<AttribTransform>,
    grid_size: Option<usize>,
    first_user_location: u32,
    /// Replaces the reference image comparison: judges the rendered RGBA8 bytes
    verifier: Option<Box<dyn Fn(&[u8]) -> bool + Send + Sync>>,
    render_size: (u32, u32),
    geometry: Option<CustomGeometry>,
    requires_quad_subgroups: bool,
    color_format: vk::Format,
    sample_count: vk::SampleCountFlags,
    texture: Option<TextureSpec>,
    /// `setPushConstantRanges` with one fragment stage vec4 at offset 0, pushed before the draw
    fragment_push_constant: Option<[f32; 4]>,
}

/// A 2D texture with one level, sampled with nearest filtering and clamping at `binding` (`TextureBinding` of the cases that use one)
pub struct TextureSpec {
    pub binding: u32,
    pub format: vk::Format,
    pub width: u32,
    pub height: u32,
    pub data: Vec<u8>,
    /// Linear minification and magnification filters instead of nearest
    pub linear: bool,
}

/// The vertices and indices of a case that draws its own triangles in place of the grid
pub struct CustomGeometry {
    pub positions: Vec<[f32; 4]>,
    pub coords: Vec<[f32; 4]>,
    pub indices: Vec<u16>,
}

impl ShaderRenderCase {
    /// `key` is the manifest name `sr_<group>_<case>` of the generated shaders.
    pub fn new(
        name: String,
        key: String,
        is_vertex_case: bool,
        eval: ShaderEvalFunc,
        uniforms: &[(u32, UniformValue)],
    ) -> Self {
        Self {
            name,
            key,
            is_vertex_case,
            eval: Box::new(eval),
            uniforms: uniforms.to_vec(),
            exact_compare: false,
            requires_demote: false,
            stub: None,
            user_attrib_transforms: Vec::new(),
            grid_size: None,
            first_user_location: 4,
            verifier: None,
            render_size: (128, 128),
            geometry: None,
            requires_quad_subgroups: false,
            color_format: vk::Format::R8G8B8A8_UNORM,
            sample_count: vk::SampleCountFlags::_1,
            texture: None,
            fragment_push_constant: None,
        }
    }

    /// The same with an evaluation closure, for the cases whose function depends on the data type.
    pub fn with_closure(
        name: String,
        key: String,
        is_vertex_case: bool,
        eval: Box<dyn Fn(&mut ShaderEvalContext) + Send + Sync>,
        uniforms: Vec<(u32, UniformValue)>,
    ) -> Self {
        Self {
            name,
            key,
            is_vertex_case,
            eval,
            uniforms,
            exact_compare: false,
            requires_demote: false,
            stub: None,
            user_attrib_transforms: Vec::new(),
            grid_size: None,
            first_user_location: 4,
            verifier: None,
            render_size: (128, 128),
            geometry: None,
            requires_quad_subgroups: false,
            color_format: vk::Format::R8G8B8A8_UNORM,
            sample_count: vk::SampleCountFlags::_1,
            texture: None,
            fragment_push_constant: None,
        }
    }

    /// The case compares with `pixelThresholdCompare` (threshold 1) rather than `fuzzyCompare`.
    pub fn exact_compare(mut self) -> Self {
        self.exact_compare = true;
        self
    }

    /// `checkSupport` asks for `shaderDemoteToHelperInvocation`.
    pub fn requires_demote(mut self) -> Self {
        self.requires_demote = true;
        self
    }

    /// Adds the user attributes at locations 4 and up, one transform each
    pub fn with_user_attributes(mut self, transforms: Vec<AttribTransform>) -> Self {
        self.user_attrib_transforms = transforms;
        self
    }

    /// The size of the render target (128x128 by default)
    pub fn with_render_size(mut self, width: u32, height: u32) -> Self {
        self.render_size = (width, height);
        self
    }

    /// Draws these triangles in place of the grid
    pub fn with_geometry(mut self, geometry: CustomGeometry) -> Self {
        self.geometry = Some(geometry);
        self
    }

    /// `checkSupport` asks for fragment stage quad subgroup operations and a subgroup size of at least 4
    pub fn requires_quad_subgroups(mut self) -> Self {
        self.requires_quad_subgroups = true;
        self
    }

    /// The format of the colour attachment (`m_colorFormat`, RGBA8 by default); the verifier gets its raw bytes
    pub fn with_color_format(mut self, format: vk::Format) -> Self {
        self.color_format = format;
        self
    }

    /// `setSampleCount`: renders into a multisampled image that is resolved into the one that is read back
    pub fn with_sample_count(mut self, sample_count: vk::SampleCountFlags) -> Self {
        self.sample_count = sample_count;
        self
    }

    /// Binds this texture, sampled with nearest filtering and clamping to the edge
    pub fn with_texture(mut self, texture: TextureSpec) -> Self {
        self.texture = Some(texture);
        self
    }

    /// A vec4 push constant of the fragment stage
    pub fn with_fragment_push_constant(mut self, value: [f32; 4]) -> Self {
        self.fragment_push_constant = Some(value);
        self
    }

    /// Judges the rendered image instead of comparing it with the evaluator's reference
    pub fn with_verifier(mut self, verifier: Box<dyn Fn(&[u8]) -> bool + Send + Sync>) -> Self {
        self.verifier = Some(verifier);
        self
    }

    /// The location of the first user attribute (4 by default)
    pub fn with_first_user_location(mut self, location: u32) -> Self {
        self.first_user_location = location;
        self
    }

    /// The grid size in place of `GRID_SIZE_DEFAULTS`
    pub fn with_grid_size(mut self, grid_size: usize) -> Self {
        self.grid_size = Some(grid_size);
        self
    }

    /// Registers the case without running it.
    pub fn stub(mut self, reason: &'static str) -> Self {
        self.stub = Some(reason);
        self
    }
}

impl TestCase for ShaderRenderCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.requires_demote {
            let mut demote_features = vk::PhysicalDeviceShaderDemoteToHelperInvocationFeatures::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut demote_features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
            if demote_features.shader_demote_to_helper_invocation == vk::FALSE {
                return Err(TestError::NotSupported(
                    "VK_EXT_shader_demote_to_helper_invocation not supported".to_string(),
                ));
            }
        }
        if self.color_format != vk::Format::R8G8B8A8_UNORM || self.sample_count != vk::SampleCountFlags::_1 {
            let properties = unsafe {
                context.get_instance().get_physical_device_image_format_properties(
                    context.get_physical_device(),
                    self.color_format,
                    vk::ImageType::_2D,
                    vk::ImageTiling::OPTIMAL,
                    vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
                    vk::ImageCreateFlags::empty(),
                )
            };
            match properties {
                Err(error) if error == vk::ErrorCode::FORMAT_NOT_SUPPORTED => {
                    return Err(TestError::NotSupported("Format not supported".to_string()));
                }
                Ok(properties) if !properties.sample_counts.contains(self.sample_count) => {
                    return Err(TestError::NotSupported("Format not supported".to_string()));
                }
                _ => {}
            }
        }
        if self.requires_quad_subgroups {
            let mut subgroup_properties = vk::PhysicalDeviceSubgroupProperties::default();
            let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut subgroup_properties);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
            };
            if !subgroup_properties
                .supported_stages
                .contains(vk::ShaderStageFlags::FRAGMENT)
                || !subgroup_properties
                    .supported_operations
                    .contains(vk::SubgroupFeatureFlags::QUAD | vk::SubgroupFeatureFlags::BALLOT)
                || subgroup_properties.subgroup_size < 4
            {
                return Err(TestError::NotSupported(
                    "quad and ballot subgroup operations and a subgroup size of at least 4 are required".to_string(),
                ));
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        ALL_SHARED_PROGRAM
            .iter()
            .chain(LOOPS_SHARED_PROGRAM.iter())
            .chain(INDEXING_SHARED_PROGRAM.iter())
            .chain(STRUCT_SHARED_PROGRAM.iter())
            .chain(OPERATOR_SHARED_PROGRAM.iter())
            .chain(MATRIX_SHARED_PROGRAM.iter())
            .chain(DERIVATE_SHARED_PROGRAM.iter())
            .chain(BUILTIN_VAR_SHARED_PROGRAM.iter())
            .find(|program| program.name == self.key)
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ShaderRenderCaseInstance { context, case: self })
    }

    fn is_stub(&self) -> bool {
        self.stub.is_some()
    }
}

/// `ShaderRenderCaseInstance`
struct ShaderRenderCaseInstance<'a> {
    context: &'a Context<'a>,
    case: &'a ShaderRenderCase,
}

fn host_buffer_with<'a>(
    context: &'a Context<'_>,
    bytes: &[u8],
    usage: vk::BufferUsageFlags,
) -> Result<BufferWithMemory<'a>, TestError> {
    let buffer = BufferWithMemory::new(
        context.get_device(),
        context.get_default_allocator(),
        make_buffer_create_info(bytes.len().max(1) as vk::DeviceSize, usage),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    unsafe { std::ptr::copy_nonoverlapping(bytes.as_ptr(), buffer.get_allocation().get_host_ptr(), bytes.len()) };
    flush_alloc(context.get_device(), buffer.get_allocation())?;
    Ok(buffer)
}

/// The render pass of `ShaderRenderCaseInstance::render` for a multisampled case: the colour attachment and the single-sample one it resolves into.
fn make_resolve_render_pass(
    device: &Device,
    color_format: vk::Format,
    samples: vk::SampleCountFlags,
) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    let attachments = [
        vk::AttachmentDescription::builder()
            .format(color_format)
            .samples(samples)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build(),
        vk::AttachmentDescription::builder()
            .format(color_format)
            .samples(vk::SampleCountFlags::_1)
            .load_op(vk::AttachmentLoadOp::DONT_CARE)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build(),
    ];
    let color_refs = [vk::AttachmentReference::builder()
        .attachment(0)
        .layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
        .build()];
    let resolve_refs = [vk::AttachmentReference::builder()
        .attachment(1)
        .layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
        .build()];
    let subpasses = [vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .color_attachments(&color_refs)
        .resolve_attachments(&resolve_refs)
        .build()];
    let info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachments)
        .subpasses(&subpasses);
    let render_pass = unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?;
    Ok(Unique::new(device, render_pass))
}

/// The image, the view and the sampler of a `TextureSpec`, filled by a copy from a staging buffer
struct SampledTexture<'a> {
    view: Unique<'a, vk::ImageView>,
    sampler: Unique<'a, vk::Sampler>,
    _image: ImageWithMemory<'a>,
}

fn create_sampled_texture<'a>(context: &'a Context<'a>, spec: &TextureSpec) -> Result<SampledTexture<'a>, TestError> {
    let device = context.get_device();
    let range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let mut image_info = make_image_create_info(
        IVec2::new(spec.width as i32, spec.height as i32),
        spec.format,
        vk::ImageUsageFlags::SAMPLED | vk::ImageUsageFlags::TRANSFER_DST,
    );
    image_info.tiling = vk::ImageTiling::OPTIMAL;
    let image = ImageWithMemory::new(
        device,
        context.get_default_allocator(),
        image_info,
        MemoryRequirement::ANY,
    )?;
    let view = make_image_view(device, image.get(), vk::ImageViewType::_2D, spec.format, range)?;
    let filter = if spec.linear {
        vk::Filter::LINEAR
    } else {
        vk::Filter::NEAREST
    };
    let sampler_info = vk::SamplerCreateInfo::builder()
        .mag_filter(filter)
        .min_filter(filter)
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
        .max_lod(0.25)
        .border_color(vk::BorderColor::FLOAT_TRANSPARENT_BLACK)
        .unnormalized_coordinates(false);
    let sampler = Unique::new(
        device,
        unsafe { device.create_sampler(&sampler_info, None) }.vk_check("vkCreateSampler")?,
    );

    let staging = host_buffer_with(context, &spec.data, vk::BufferUsageFlags::TRANSFER_SRC)?;
    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;
    begin_command_buffer(device, cmd)?;
    unsafe {
        let to_transfer = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            image.get(),
            range,
        );
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::HOST,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[to_transfer],
        );
        let copy = vk::BufferImageCopy {
            buffer_offset: 0,
            buffer_row_length: 0,
            buffer_image_height: 0,
            image_subresource: vk::ImageSubresourceLayers {
                aspect_mask: vk::ImageAspectFlags::COLOR,
                mip_level: 0,
                base_array_layer: 0,
                layer_count: 1,
            },
            image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
            image_extent: vk::Extent3D {
                width: spec.width,
                height: spec.height,
                depth: 1,
            },
        };
        device.cmd_copy_buffer_to_image(
            cmd,
            staging.get(),
            image.get(),
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            &[copy],
        );
        let to_sampled = make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::SHADER_READ,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
            image.get(),
            range,
        );
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::ALL_COMMANDS,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[to_sampled],
        );
    }
    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

    Ok(SampledTexture {
        view,
        sampler,
        _image: image,
    })
}

fn as_bytes<T: Copy>(values: &[T]) -> &[u8] {
    unsafe { std::slice::from_raw_parts(values.as_ptr().cast::<u8>(), std::mem::size_of_val(values)) }
}

impl ShaderRenderCaseInstance<'_> {
    /// `ShaderRenderCaseInstance::render`: the grid as an indexed triangle list into the colour image, read back as RGBA8
    fn render(&self, quad_grid: &QuadGrid) -> Result<TextureLevel, TestError> {
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let color_format = self.case.color_format;
        let sample_count = self.case.sample_count;
        let multisampled = sample_count != vk::SampleCountFlags::_1;
        let render_size = (self.case.render_size.0, self.case.render_size.1);

        let color_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let image_size = IVec2::new(self.case.render_size.0 as i32, self.case.render_size.1 as i32);
        let color_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC;
        let mut color_image_info = make_image_create_info(image_size, color_format, color_usage);
        color_image_info.samples = sample_count;
        let color_image = ImageWithMemory::new(device, allocator, color_image_info, MemoryRequirement::ANY)?;
        let color_view = make_image_view(
            device,
            color_image.get(),
            vk::ImageViewType::_2D,
            color_format,
            color_range,
        )?;
        let resolved_image = if multisampled {
            Some(ImageWithMemory::new(
                device,
                allocator,
                make_image_create_info(image_size, color_format, color_usage),
                MemoryRequirement::ANY,
            )?)
        } else {
            None
        };
        let resolved_view = match &resolved_image {
            Some(image) => Some(make_image_view(
                device,
                image.get(),
                vk::ImageViewType::_2D,
                color_format,
                color_range,
            )?),
            None => None,
        };
        let render_pass = if multisampled {
            make_resolve_render_pass(device, color_format, sample_count)?
        } else {
            make_render_pass(device, color_format)?
        };
        let attachments: Vec<vk::ImageView> = std::iter::once(*color_view)
            .chain(resolved_view.as_ref().map(|view| **view))
            .collect();
        let framebuffer = make_framebuffer(
            device,
            *render_pass,
            &attachments,
            self.case.render_size.0,
            self.case.render_size.1,
            1,
        )?;

        let vertex_usage = vk::BufferUsageFlags::VERTEX_BUFFER;
        let vertex_buffers = [
            host_buffer_with(context, as_bytes(&quad_grid.positions), vertex_usage)?,
            host_buffer_with(context, as_bytes(&quad_grid.coords), vertex_usage)?,
            host_buffer_with(context, as_bytes(&quad_grid.unit_coords), vertex_usage)?,
            host_buffer_with(context, as_bytes(&quad_grid.attrib_one), vertex_usage)?,
        ];
        let user_buffers = quad_grid
            .user_attribs
            .iter()
            .map(|attribs| host_buffer_with(context, as_bytes(attribs), vertex_usage))
            .collect::<Result<Vec<_>, _>>()?;
        let index_buffer = host_buffer_with(
            context,
            as_bytes(&quad_grid.indices),
            vk::BufferUsageFlags::INDEX_BUFFER,
        )?;

        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST)
            .with_full_viewport(self.case.render_size.0, self.case.render_size.1);
        state.color_attachment_count = 1;
        state.samples = sample_count;
        let attribute_formats = [
            vk::Format::R32G32B32A32_SFLOAT,
            vk::Format::R32G32B32A32_SFLOAT,
            vk::Format::R32G32B32A32_SFLOAT,
            vk::Format::R32_SFLOAT,
        ];
        let strides = [16u32, 16, 16, 4];
        for location in 0..4u32 {
            state.bindings.push(vk::VertexInputBindingDescription {
                binding: location,
                stride: strides[location as usize],
                input_rate: vk::VertexInputRate::VERTEX,
            });
            state.attributes.push(vk::VertexInputAttributeDescription {
                location,
                binding: location,
                format: attribute_formats[location as usize],
                offset: 0,
            });
        }

        for ndx in 0..user_buffers.len() as u32 {
            let location = self.case.first_user_location + ndx;
            state.bindings.push(vk::VertexInputBindingDescription {
                binding: location,
                stride: 16,
                input_rate: vk::VertexInputRate::VERTEX,
            });
            state.attributes.push(vk::VertexInputAttributeDescription {
                location,
                binding: location,
                format: vk::Format::R32G32B32A32_SFLOAT,
                offset: 0,
            });
        }

        let uniform_buffers = self
            .case
            .uniforms
            .iter()
            .map(|(_, value)| host_buffer_with(context, &value.to_bytes(), vk::BufferUsageFlags::UNIFORM_BUFFER))
            .collect::<Result<Vec<_>, _>>()?;
        let texture = match &self.case.texture {
            Some(spec) => Some((spec.binding, create_sampled_texture(context, spec)?)),
            None => None,
        };
        let uniform_resources = if self.case.uniforms.is_empty() && texture.is_none() {
            None
        } else {
            let mut layout_builder = DescriptorSetLayoutBuilder::new();
            let mut pool_builder = DescriptorPoolBuilder::new();
            for (binding, _) in &self.case.uniforms {
                layout_builder = layout_builder.add_indexed_binding(
                    vk::DescriptorType::UNIFORM_BUFFER,
                    vk::ShaderStageFlags::ALL,
                    *binding,
                    1,
                );
                pool_builder = pool_builder.add_type(vk::DescriptorType::UNIFORM_BUFFER, 1);
            }
            if let Some((binding, _)) = &texture {
                layout_builder = layout_builder.add_indexed_binding(
                    vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                    vk::ShaderStageFlags::ALL,
                    *binding,
                    1,
                );
                pool_builder = pool_builder.add_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, 1);
            }
            let descriptor_set_layout = layout_builder.build(device)?;
            let descriptor_pool = pool_builder.build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
            let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
            let buffer_infos: Vec<vk::DescriptorBufferInfo> = uniform_buffers
                .iter()
                .map(|buffer| vk::DescriptorBufferInfo {
                    buffer: buffer.get(),
                    offset: 0,
                    range: vk::WHOLE_SIZE,
                })
                .collect();
            let mut update = DescriptorSetUpdateBuilder::new();
            for ((binding, _), info) in self.case.uniforms.iter().zip(&buffer_infos) {
                update = update.write_single(
                    descriptor_set.get(),
                    Location::binding(*binding),
                    vk::DescriptorType::UNIFORM_BUFFER,
                    info,
                );
            }
            update.update(device);
            if let Some((binding, texture)) = &texture {
                let image_info = [vk::DescriptorImageInfo {
                    sampler: *texture.sampler,
                    image_view: *texture.view,
                    image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                }];
                let write = vk::WriteDescriptorSet {
                    s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
                    next: std::ptr::null(),
                    dst_set: descriptor_set.get(),
                    dst_binding: *binding,
                    dst_array_element: 0,
                    descriptor_count: 1,
                    descriptor_type: vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                    image_info: image_info.as_ptr(),
                    buffer_info: std::ptr::null(),
                    texel_buffer_view: std::ptr::null(),
                };
                unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };
            }
            Some((descriptor_set, descriptor_pool, descriptor_set_layout))
        };

        let set_layouts: Vec<vk::DescriptorSetLayout> =
            uniform_resources.iter().map(|(_, _, layout)| **layout).collect();
        let push_constant_ranges = [vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::FRAGMENT,
            offset: 0,
            size: std::mem::size_of::<[f32; 4]>() as u32,
        }];
        let pipeline_layout = make_pipeline_layout_with_push_constants(
            device,
            &set_layouts,
            if self.case.fragment_push_constant.is_some() {
                &push_constant_ranges[..]
            } else {
                &[]
            },
        )?;
        let binaries = context.get_binary_collection();
        let vertex_module = create_shader_module(device, binaries.get("vert")?)?;
        let fragment_module = create_shader_module(device, binaries.get("frag")?)?;
        let stages = [
            (vk::ShaderStageFlags::VERTEX, *vertex_module),
            (vk::ShaderStageFlags::FRAGMENT, *fragment_module),
        ];
        let pipeline = create_draw_pipeline(device, *pipeline_layout, *render_pass, &stages, &state)?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;
        begin_command_buffer(device, cmd)?;
        begin_render_pass(
            device,
            cmd,
            *render_pass,
            *framebuffer,
            make_rect_2d(0, 0, self.case.render_size.0, self.case.render_size.1),
            if color_format == vk::Format::R32G32B32A32_UINT {
                vk::ClearValue {
                    color: vk::ClearColorValue { uint32: [0; 4] },
                }
            } else {
                vk::ClearValue {
                    color: vk::ClearColorValue {
                        float32: DEFAULT_CLEAR_COLOR,
                    },
                }
            },
        );
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            if let Some(value) = &self.case.fragment_push_constant {
                let bytes: Vec<u8> = value.iter().flat_map(|component| component.to_ne_bytes()).collect();
                device.cmd_push_constants(cmd, *pipeline_layout, vk::ShaderStageFlags::FRAGMENT, 0, &bytes);
            }
            if let Some((descriptor_set, _, _)) = &uniform_resources {
                device.cmd_bind_descriptor_sets(
                    cmd,
                    vk::PipelineBindPoint::GRAPHICS,
                    *pipeline_layout,
                    0,
                    &[descriptor_set.get()],
                    &[] as &[u32],
                );
            }
            let buffers: Vec<vk::Buffer> = vertex_buffers.iter().map(|buffer| buffer.get()).collect();
            device.cmd_bind_vertex_buffers(cmd, 0, &buffers, &[0; 4]);
            for (ndx, buffer) in user_buffers.iter().enumerate() {
                device.cmd_bind_vertex_buffers(cmd, self.case.first_user_location + ndx as u32, &[buffer.get()], &[0]);
            }
            device.cmd_bind_index_buffer(cmd, index_buffer.get(), 0, vk::IndexType::UINT16);
            device.cmd_draw_indexed(cmd, quad_grid.indices.len() as u32, 1, 0, 0, 0);
        }
        end_render_pass(device, cmd);
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        crate::vkt::tests::pipeline::pipeline_util::read_color_attachment(
            context,
            resolved_image.as_ref().unwrap_or(&color_image).get(),
            color_format,
            render_size,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )
    }

    fn new_reference_level(&self) -> Result<TextureLevel, TestError> {
        TextureLevel::new(
            TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8),
            self.case.render_size.0,
            self.case.render_size.1,
            1,
        )
        .map_err(|_| TestError::NotPorted("reference image allocation failed".to_string()))
    }

    /// `computeVertexReference`
    fn compute_vertex_reference(&self, quad_grid: &QuadGrid) -> Result<TextureLevel, TestError> {
        let mut result = self.new_reference_level()?;
        let (width, height) = (self.case.render_size.0 as i32, self.case.render_size.1 as i32);
        let grid_size = quad_grid.grid_size as i32;
        let stride = grid_size + 1;
        let mut eval_ctx = ShaderEvalContext {
            coords: [0.0; 4],
            const_coords: DEFAULT_CONST_COORDS,
            unit_coords: [0.0; 4],
            inputs: [[0.0; 4]; 4],
            color: [0.0; 4],
            is_discarded: false,
        };

        let mut colors = vec![[0.0f32; 4]; ((grid_size + 1) * (grid_size + 1)) as usize];
        for y in 0..=grid_size {
            for x in 0..=grid_size {
                let sx = x as f32 / grid_size as f32;
                let sy = y as f32 / grid_size as f32;
                eval_ctx.reset(sx, sy, &self.case.user_attrib_transforms);
                (self.case.eval)(&mut eval_ctx);
                colors[(y * stride + x) as usize] = eval_ctx.color;
            }
        }

        let mut access = result.get_access();
        for y in 0..grid_size {
            for x in 0..grid_size {
                let x0 = x as f32 / grid_size as f32;
                let x1 = (x + 1) as f32 / grid_size as f32;
                let y0 = y as f32 / grid_size as f32;
                let y1 = (y + 1) as f32 / grid_size as f32;

                let sx0 = x0 * width as f32;
                let sx1 = x1 * width as f32;
                let sy0 = y0 * height as f32;
                let sy1 = y1 * height as f32;
                let oosx = 1.0 / (sx1 - sx0);
                let oosy = 1.0 / (sy1 - sy0);

                let ix0 = (sx0 - 0.5).ceil() as i32;
                let ix1 = (sx1 - 0.5).ceil() as i32;
                let iy0 = (sy0 - 0.5).ceil() as i32;
                let iy1 = (sy1 - 0.5).ceil() as i32;

                let c00 = colors[(y * stride + x) as usize];
                let c01 = colors[(y * stride + x + 1) as usize];
                let c10 = colors[((y + 1) * stride + x) as usize];
                let c11 = colors[((y + 1) * stride + x + 1) as usize];

                for iy in iy0..iy1 {
                    for ix in ix0..ix1 {
                        let sfx = ix as f32 + 0.5;
                        let sfy = iy as f32 + 0.5;
                        let fx1 = ((sfx - sx0) * oosx).clamp(0.0, 1.0);
                        let fy1 = ((sfy - sy0) * oosy).clamp(0.0, 1.0);

                        // Triangle quad interpolation.
                        let tri = fx1 + fy1 <= 1.0;
                        let tx = if tri { fx1 } else { 1.0 - fx1 };
                        let ty = if tri { fy1 } else { 1.0 - fy1 };
                        let (t0, t1, t2) = if tri { (c00, c01, c10) } else { (c11, c10, c01) };
                        let color = std::array::from_fn(|c| t0[c] + (t1[c] - t0[c]) * tx + (t2[c] - t0[c]) * ty);

                        access.set_pixel(to_rgba8(color), ix as u32, iy as u32, 0);
                    }
                }
            }
        }
        drop(access);
        Ok(result)
    }

    /// `computeFragmentReference`
    fn compute_fragment_reference(&self) -> Result<TextureLevel, TestError> {
        let mut result = self.new_reference_level()?;
        let mut eval_ctx = ShaderEvalContext {
            coords: [0.0; 4],
            const_coords: DEFAULT_CONST_COORDS,
            unit_coords: [0.0; 4],
            inputs: [[0.0; 4]; 4],
            color: [0.0; 4],
            is_discarded: false,
        };

        let mut access = result.get_access();
        for y in 0..self.case.render_size.1 {
            for x in 0..self.case.render_size.0 {
                let sx = (x as f32 + 0.5) / self.case.render_size.0 as f32;
                let sy = (y as f32 + 0.5) / self.case.render_size.1 as f32;

                eval_ctx.reset(sx, sy, &self.case.user_attrib_transforms);
                (self.case.eval)(&mut eval_ctx);
                // Select either clear color or computed color based on discarded bit.
                let color = if eval_ctx.is_discarded {
                    DEFAULT_CLEAR_COLOR
                } else {
                    eval_ctx.color
                };
                access.set_pixel(to_rgba8(color), x, y, 0);
            }
        }
        drop(access);
        Ok(result)
    }
}

impl TestInstance for ShaderRenderCaseInstance<'_> {
    /// `ShaderRenderCaseInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        if let Some(reason) = self.case.stub {
            return Err(TestError::NotPorted(reason.to_string()));
        }
        let default_grid_size = if self.case.is_vertex_case {
            GRID_SIZE_DEFAULT_VERTEX
        } else {
            GRID_SIZE_DEFAULT_FRAGMENT
        };
        let mut quad_grid = QuadGrid::new(
            self.case.grid_size.unwrap_or(default_grid_size),
            &self.case.user_attrib_transforms,
        );
        if let Some(geometry) = &self.case.geometry {
            let count = geometry.positions.len();
            quad_grid.positions = geometry.positions.clone();
            quad_grid.coords = geometry.coords.clone();
            quad_grid.indices = geometry.indices.clone();
            quad_grid.unit_coords = vec![[0.0; 4]; count];
            quad_grid.attrib_one = vec![1.0; count];
            for attribs in quad_grid.user_attribs.iter_mut() {
                *attribs = vec![[0.0; 4]; count];
            }
        }
        debug_assert!(
            self.case.geometry.is_some()
                || quad_grid.num_vertices() == (quad_grid.grid_size + 1) * (quad_grid.grid_size + 1)
        );

        let res_image = self.render(&quad_grid)?;
        if let Some(verifier) = &self.case.verifier {
            return Ok(if verifier(res_image.data()) {
                TestStatus::pass("Pass")
            } else {
                TestStatus::fail("Image comparison failed")
            });
        }
        let ref_image = if self.case.is_vertex_case {
            self.compute_vertex_reference(&quad_grid)?
        } else {
            self.compute_fragment_reference()?
        };

        let compare_ok = if self.case.exact_compare {
            // `tcu::pixelThresholdCompare` with `RGBA(1, 1, 1, 1)`
            ref_image.data().len() == res_image.data().len()
                && ref_image
                    .data()
                    .iter()
                    .zip(res_image.data())
                    .all(|(expected, result)| expected.abs_diff(*result) <= 1)
        } else {
            fuzzy_compare_ok(
                &ref_image.get_const_access(),
                &res_image.get_const_access(),
                FUZZY_THRESHOLD,
            )
            .ok_or_else(|| TestError::NotPorted("the fuzzy comparison does not take the image format".to_string()))?
        };
        if compare_ok {
            Ok(TestStatus::pass("Result image matches reference"))
        } else {
            Ok(TestStatus::fail("Image mismatch"))
        }
    }
}

/// `useUniform(0, UI_ZERO)`
pub static UNIFORM_ZERO: [(u32, UniformValue); 1] = [(0, UniformValue::Int(0))];

/// `useUniform(0, UI_ONE)`
pub static UNIFORM_ONE: [(u32, UniformValue); 1] = [(0, UniformValue::Int(1))];

/// `useUniform(0, UI_TWO)`
pub static UNIFORM_TWO: [(u32, UniformValue); 1] = [(0, UniformValue::Int(2))];

/// The shader of the cases is found by the manifest name of the generator
pub fn case_key(group: &str, name: &str) -> String {
    format!("sr_{group}_{name}")
}
