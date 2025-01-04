// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineCacheTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Intel Corporation
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the monolithic construction type is built, in `TestMode::CACHE` and
// (`add_pipeline_binary_basic_tests`, over `binary_tests::PipelineBinaryWrapper`) `TestMode::BINARY`; the library
// flavours do not exist here. The work upstream does in the constructors of the instance classes happens at the
// top of `iterate` instead, in the same order. The two renders are compared byte by byte with a threshold of one,
// which is `tcu::intThresholdCompare` over an RGBA8 image.

use std::mem::size_of;

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::pipeline_cache::{
    CACHE_COMPUTE, CACHE_INTERNALLY_SYNCHRONIZED, CACHE_VERT_FRAG, CACHE_VERT_FRAG_MISS, CACHE_VERT_GEOM_FRAG,
    CACHE_VERT_GEOM_FRAG_MISS, CACHE_VERT_TESS_FRAG, CACHE_VERT_TESS_FRAG_MISS,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_framebuffer, make_pipeline_layout,
};
use crate::vk::pipeline_construction::ambient_construction_type;
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::{Unique, UniqueCommandBuffer};
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{DrawPipelineState, clear_value_color, create_draw_pipeline, rect_2d};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::tests::pipeline::binary_tests::PipelineBinaryWrapper;
use crate::vkt::tests::pipeline::shader_object_draw::{
    RenderingAttachment, ShaderObjectDraw, begin_dynamic_rendering, end_dynamic_rendering, make_shader_objects_stages,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const RENDER_SIZE: u32 = 32;
const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const DEPTH_FORMAT: vk::Format = vk::Format::D16_UNORM;
const DEFAULT_CLEAR_COLOR: [f32; 4] = [0.39, 0.58, 0.93, 1.0];
const UUID_SIZE: usize = 16;
const COMPUTE_ELEMENTS: usize = 128;
const COMPUTE_BUFFER_SIZE: usize = size_of::<[f32; 4]>() * COMPUTE_ELEMENTS;
const THREAD_ITERATIONS: u32 = 1000;

/// What a pipeline of `TestMode::BINARY` adds to `preparePipelineWrapper`.
struct BinaryPipelineOptions {
    use_shader_modules: bool,
    binaries: Option<Vec<vk::PipelineBinaryKHR>>,
}

/// `vkReleaseCapturedPipelineDataKHR`; the result is ignored, as upstream does.
fn release_captured_pipeline_data(device: &Device, pipeline: vk::Pipeline) {
    let info = vk::ReleaseCapturedPipelineDataInfoKHR {
        pipeline,
        ..Default::default()
    };
    unsafe { (device.commands().release_captured_pipeline_data_khr)(device.handle(), &info, std::ptr::null()) };
}

/// The shader stage sets `createPipelineBlobTestsInternal` builds its pipelines from.
#[derive(Clone, Copy, PartialEq, Eq)]
enum Stages {
    VertFrag,
    VertGeomFrag,
    VertTessFrag,
    Compute,
}

/// `TestParam`, with the mode and the construction type left out.
#[derive(Clone, Copy)]
struct TestParam {
    stages: Stages,
    compile_miss_shaders: bool,
    cache_create_flags: vk::PipelineCacheCreateFlags,
    /// `TestMode::BINARY`
    binary: bool,
    use_binaries_from_binary_data: bool,
}

impl TestParam {
    fn new(stages: Stages, compile_miss_shaders: bool, cache_create_flags: vk::PipelineCacheCreateFlags) -> Self {
        Self {
            stages,
            compile_miss_shaders,
            cache_create_flags,
            binary: false,
            use_binaries_from_binary_data: false,
        }
    }

    fn new_binary(stages: Stages, use_binaries_from_binary_data: bool) -> Self {
        Self {
            stages,
            compile_miss_shaders: false,
            cache_create_flags: vk::PipelineCacheCreateFlags::empty(),
            binary: true,
            use_binaries_from_binary_data,
        }
    }

    /// `TestParam::generateTestName`
    fn generate_test_name(&self) -> String {
        let mut name = match self.stages {
            Stages::Compute => "compute_stage".to_string(),
            Stages::VertFrag => "vertex_stage_fragment_stage".to_string(),
            Stages::VertGeomFrag => "vertex_stage_geometry_stage_fragment_stage".to_string(),
            Stages::VertTessFrag => {
                "vertex_stage_tessellation_control_stage_tessellation_evaluation_stage_fragment_stage".to_string()
            }
        };
        if self.cache_create_flags == vk::PipelineCacheCreateFlags::EXTERNALLY_SYNCHRONIZED {
            name += "_externally_synchronized";
        }
        if self.use_binaries_from_binary_data {
            name += "_use_binary_data";
        }
        name
    }
}

/// `MergeBlobsType`
#[derive(Clone, Copy)]
enum MergeBlobsType {
    Empty,
    FromData,
    Hit,
    Miss,
    MissAndHit,
    Merged,
}

const MERGE_BLOBS_TYPES: [MergeBlobsType; 6] = [
    MergeBlobsType::Empty,
    MergeBlobsType::FromData,
    MergeBlobsType::Hit,
    MergeBlobsType::Miss,
    MergeBlobsType::MissAndHit,
    MergeBlobsType::Merged,
];

/// `getMergeBlobsTypeStr`
fn merge_blobs_type_str(ty: MergeBlobsType) -> &'static str {
    match ty {
        MergeBlobsType::Empty => "empty",
        MergeBlobsType::FromData => "from_data",
        MergeBlobsType::Hit => "hit",
        MergeBlobsType::Miss => "miss",
        MergeBlobsType::MissAndHit => "misshit",
        MergeBlobsType::Merged => "merged",
    }
}

/// `getMergeBlobsTypesStr`
fn merge_blobs_types_str(types: &[MergeBlobsType]) -> String {
    types
        .iter()
        .map(|&ty| merge_blobs_type_str(ty))
        .collect::<Vec<_>>()
        .join("_")
}

#[derive(Clone)]
struct MergeBlobsTestParam {
    dest_blobs_type: MergeBlobsType,
    src_blob_types: Vec<MergeBlobsType>,
}

#[derive(Clone)]
enum Kind {
    Graphics,
    PipelineFromBlobs,
    PipelineFromIncompleteBlobs,
    MergeBlobs(MergeBlobsTestParam),
    CacheHeader,
    InvalidSize,
    ZeroSize,
    InvalidBlob,
    Compute,
    InternallySynchronized,
}

struct CacheTestCase {
    name: String,
    param: TestParam,
    kind: Kind,
}

impl TestCase for CacheTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `GraphicsTest::checkSupport` (the pipeline binary half does not apply to the cache mode)
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.param.binary {
            context.require_device_functionality("VK_KHR_pipeline_binary")?;
        }
        match self.kind {
            // `InternallySynchronizedTest::checkSupport`
            Kind::InternallySynchronized => context.require_device_functionality("VK_KHR_maintenance8"),
            Kind::Compute => Ok(()),
            _ => {
                if self.param.stages == Stages::VertGeomFrag
                    && context.get_device_features().geometry_shader == vk::FALSE
                {
                    return Err(TestError::NotSupported(
                        "Requires VkPhysicalDeviceFeatures::geometryShader".to_string(),
                    ));
                }
                if self.param.stages == Stages::VertTessFrag
                    && context.get_device_features().tessellation_shader == vk::FALSE
                {
                    return Err(TestError::NotSupported(
                        "Requires VkPhysicalDeviceFeatures::tessellationShader".to_string(),
                    ));
                }
                Ok(())
            }
        }
    }

    fn programs(&self) -> BinaryCollection {
        match (&self.kind, self.param.stages, self.param.compile_miss_shaders) {
            (Kind::InternallySynchronized, _, _) => CACHE_INTERNALLY_SYNCHRONIZED.programs,
            (Kind::Compute, _, _) => CACHE_COMPUTE.programs,
            (_, Stages::VertFrag, false) => CACHE_VERT_FRAG.programs,
            (_, Stages::VertFrag, true) => CACHE_VERT_FRAG_MISS.programs,
            (_, Stages::VertGeomFrag, false) => CACHE_VERT_GEOM_FRAG.programs,
            (_, Stages::VertGeomFrag, true) => CACHE_VERT_GEOM_FRAG_MISS.programs,
            (_, Stages::VertTessFrag, false) => CACHE_VERT_TESS_FRAG.programs,
            (_, Stages::VertTessFrag, true) => CACHE_VERT_TESS_FRAG_MISS.programs,
            (_, Stages::Compute, _) => CACHE_COMPUTE.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(CacheTestInstance { context, case: self })
    }
}

struct CacheTestInstance<'a> {
    context: &'a Context<'a>,
    case: &'a CacheTestCase,
}

impl TestInstance for CacheTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        match self.case.kind {
            Kind::InternallySynchronized => iterate_internally_synchronized(self.context),
            Kind::Compute => iterate_compute(self.context, &self.case.param),
            _ => iterate_graphics(self.context, self.case),
        }
    }
}

#[derive(Clone, Copy)]
#[repr(C)]
pub(super) struct Vertex4Rgba {
    pub(super) position: [f32; 4],
    pub(super) color: [f32; 4],
}

/// `createOverlappingQuads`
pub(super) fn create_overlapping_quads() -> Vec<Vertex4Rgba> {
    let translations = [[-0.25f32, -0.25], [-1.0, -0.25], [-1.0, -1.0], [-0.25, -1.0]];
    let quad_colors = [
        [1.0f32, 0.0, 0.0, 1.0],
        [0.0, 1.0, 0.0, 1.0],
        [0.0, 0.0, 1.0, 1.0],
        [1.0, 0.0, 1.0, 1.0],
    ];
    let quad_size = 1.25f32;

    let mut vertices = Vec::new();
    for quad_ndx in 0..4 {
        let [tx, ty] = translations[quad_ndx];
        let color = quad_colors[quad_ndx];

        let lower_left = Vertex4Rgba {
            position: [tx, ty, 0.0, 1.0],
            color,
        };
        let upper_left = Vertex4Rgba {
            position: [tx, ty + quad_size, 0.0, 1.0],
            color,
        };
        let lower_right = Vertex4Rgba {
            position: [tx + quad_size, ty, 0.0, 1.0],
            color,
        };
        let upper_right = Vertex4Rgba {
            position: [tx + quad_size, ty + quad_size, 0.0, 1.0],
            color,
        };

        // Triangle 1, CCW
        vertices.push(lower_left);
        vertices.push(lower_right);
        vertices.push(upper_left);

        // Triangle 2, CW
        vertices.push(lower_right);
        vertices.push(upper_left);
        vertices.push(upper_right);
    }
    vertices
}

/// `vk::getPipelineCacheData`, both calls
fn get_cache_data(device: &Device, cache: vk::PipelineCache) -> Result<Vec<u8>, TestError> {
    unsafe { device.get_pipeline_cache_data(cache) }.vk_check("vkGetPipelineCacheData")
}

/// One raw `vkGetPipelineCacheData` call, for the cases that look at the result code.
fn get_cache_data_raw(device: &Device, cache: vk::PipelineCache, data_size: &mut usize, data: &mut [u8]) -> vk::Result {
    let get_data = device.commands().get_pipeline_cache_data;
    let data_ptr = if data.is_empty() {
        std::ptr::null_mut()
    } else {
        data.as_mut_ptr().cast()
    };
    unsafe { get_data(device.handle(), cache, data_size, data_ptr) }
}

fn create_pipeline_cache<'a>(
    device: &'a Device,
    flags: vk::PipelineCacheCreateFlags,
    initial_data: &[u8],
) -> Result<Unique<'a, vk::PipelineCache>, TestError> {
    let mut info = vk::PipelineCacheCreateInfo::builder().flags(flags);
    if !initial_data.is_empty() {
        info = info.initial_data(initial_data);
    }
    Ok(Unique::new(
        device,
        unsafe { device.create_pipeline_cache(&info, None) }.vk_check("vkCreatePipelineCache")?,
    ))
}

fn create_image_2d<'a>(
    context: &'a Context<'a>,
    format: vk::Format,
    usage: vk::ImageUsageFlags,
) -> Result<ImageWithMemory<'a>, TestError> {
    let info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(format)
        .extent(vk::Extent3D {
            width: RENDER_SIZE,
            height: RENDER_SIZE,
            depth: 1,
        })
        .mip_levels(1)
        .array_layers(1)
        .samples(vk::SampleCountFlags::_1)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(usage)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build();
    ImageWithMemory::new(
        context.get_device(),
        context.get_default_allocator(),
        info,
        MemoryRequirement::ANY,
    )
}

/// The two render passes share the attachments, so the depth image keeps its layout between them.
pub fn make_render_pass(
    device: &Device,
    depth_initial_layout: vk::ImageLayout,
) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    let attachments = [
        vk::AttachmentDescription::builder()
            .format(COLOR_FORMAT)
            .samples(vk::SampleCountFlags::_1)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build(),
        vk::AttachmentDescription::builder()
            .format(DEPTH_FORMAT)
            .samples(vk::SampleCountFlags::_1)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(depth_initial_layout)
            .final_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
            .build(),
    ];
    let color_ref = [vk::AttachmentReference {
        attachment: 0,
        layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    }];
    let depth_ref = vk::AttachmentReference {
        attachment: 1,
        layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
    };
    let subpasses = [vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .color_attachments(&color_ref)
        .depth_stencil_attachment(&depth_ref)
        .build()];
    let info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachments)
        .subpasses(&subpasses);
    Ok(Unique::new(
        device,
        unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?,
    ))
}

/// What `preparePipelineWrapper` made: a pipeline, or the shader objects of a shader object construction type.
enum Prepared<'a> {
    Pipeline(Unique<'a, vk::Pipeline>),
    Objects(ShaderObjectDraw<'a>),
}

/// `GraphicsTestInstance` together with the `BaseTestInstance` it derives from. Field order is drop order.
struct GraphicsFixture<'a> {
    framebuffers: Vec<Unique<'a, vk::Framebuffer>>,
    pipeline_layout: Unique<'a, vk::PipelineLayout>,
    render_passes: Vec<Unique<'a, vk::RenderPass>>,
    #[allow(dead_code)]
    depth_view: Unique<'a, vk::ImageView>,
    #[allow(dead_code)]
    color_views: Vec<Unique<'a, vk::ImageView>>,
    depth_image: ImageWithMemory<'a>,
    color_images: Vec<ImageWithMemory<'a>>,
    vertex_buffer: BufferWithMemory<'a>,
    num_vertices: u32,
    cmd_buffer: UniqueCommandBuffer<'a>,
    cmd_pool: Unique<'a, vk::CommandPool>,
    cache: Unique<'a, vk::PipelineCache>,
    context: &'a Context<'a>,
    device: &'a Device,
    param: TestParam,
}

impl<'a> GraphicsFixture<'a> {
    fn new(context: &'a Context<'a>, param: TestParam) -> Result<Self, TestError> {
        let device = context.get_device();

        // BaseTestInstance
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cache = create_pipeline_cache(device, param.cache_create_flags, &[])?;

        // Create vertex buffer
        let vertices = create_overlapping_quads();
        let vertex_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        // Create render passes
        let render_passes = vec![
            make_render_pass(device, vk::ImageLayout::UNDEFINED)?,
            make_render_pass(device, vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)?,
        ];

        // Create color and depth images
        let color_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC;
        let color_images = vec![
            create_image_2d(context, COLOR_FORMAT, color_usage)?,
            create_image_2d(context, COLOR_FORMAT, color_usage)?,
        ];
        let depth_image = create_image_2d(context, DEPTH_FORMAT, vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT)?;

        // Create attachment views
        let color_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let color_views = vec![
            make_image_view(
                device,
                color_images[0].get(),
                vk::ImageViewType::_2D,
                COLOR_FORMAT,
                color_range,
            )?,
            make_image_view(
                device,
                color_images[1].get(),
                vk::ImageViewType::_2D,
                COLOR_FORMAT,
                color_range,
            )?,
        ];
        let depth_view = make_image_view(
            device,
            depth_image.get(),
            vk::ImageViewType::_2D,
            DEPTH_FORMAT,
            make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, 0, 1),
        )?;

        // Create framebuffers
        let framebuffers = vec![
            make_framebuffer(
                device,
                *render_passes[0],
                &[*color_views[0], *depth_view],
                RENDER_SIZE,
                RENDER_SIZE,
                1,
            )?,
            make_framebuffer(
                device,
                *render_passes[1],
                &[*color_views[1], *depth_view],
                RENDER_SIZE,
                RENDER_SIZE,
                1,
            )?,
        ];

        // Create pipeline layout
        let pipeline_layout = make_pipeline_layout(device, &[])?;

        Ok(Self {
            framebuffers,
            pipeline_layout,
            render_passes,
            depth_view,
            color_views,
            depth_image,
            color_images,
            vertex_buffer,
            num_vertices: vertices.len() as u32,
            cmd_buffer,
            cmd_pool,
            cache,
            context,
            device,
            param,
        })
    }

    /// `GraphicsTestInstance::preparePipelineWrapper`: a monolithic pipeline, or the shader objects when the case runs with
    /// a shader object construction type (the cache is not involved then, as upstream's wrapper does not use it for them).
    fn prepare_pipeline(&self, cache: vk::PipelineCache, use_miss_shaders: bool) -> Result<Prepared<'a>, TestError> {
        if ambient_construction_type().is_shader_object() {
            return self.prepare_shader_objects(use_miss_shaders).map(Prepared::Objects);
        }
        Ok(Prepared::Pipeline(self.prepare_pipeline_with(
            cache,
            use_miss_shaders,
            None,
        )?))
    }

    fn prepare_shader_objects(&self, use_miss_shaders: bool) -> Result<ShaderObjectDraw<'a>, TestError> {
        let postfix = if use_miss_shaders { "_miss" } else { "" };
        let mut names = vec![(vk::ShaderStageFlags::VERTEX, format!("color_vert{postfix}"))];
        match self.param.stages {
            Stages::VertTessFrag => {
                names.push((
                    vk::ShaderStageFlags::TESSELLATION_CONTROL,
                    format!("basic_tcs{postfix}"),
                ));
                names.push((
                    vk::ShaderStageFlags::TESSELLATION_EVALUATION,
                    format!("basic_tes{postfix}"),
                ));
            }
            Stages::VertGeomFrag => names.push((vk::ShaderStageFlags::GEOMETRY, format!("unused_geo{postfix}"))),
            _ => {}
        }
        names.push((vk::ShaderStageFlags::FRAGMENT, format!("color_frag{postfix}")));
        let names: Vec<(vk::ShaderStageFlags, &str)> =
            names.iter().map(|(stage, name)| (*stage, name.as_str())).collect();
        make_shader_objects_stages(self.context, &names, &[], &[])?
            .ok_or_else(|| TestError::InternalError("not a shader object construction type".to_string()))
    }

    /// The fixed state of the pipelines of `prepare_pipeline_with`, which shader objects take as dynamic state.
    fn make_draw_state(&self) -> DrawPipelineState {
        let has_tessellation = self.param.stages == Stages::VertTessFrag;
        let mut state = DrawPipelineState::new(if has_tessellation {
            vk::PrimitiveTopology::PATCH_LIST
        } else {
            vk::PrimitiveTopology::TRIANGLE_LIST
        })
        .with_full_viewport(RENDER_SIZE, RENDER_SIZE);
        state.bindings = vec![vk::VertexInputBindingDescription {
            binding: 0,
            stride: size_of::<Vertex4Rgba>() as u32,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        state.attributes = vec![
            vk::VertexInputAttributeDescription {
                location: 0,
                binding: 0,
                format: vk::Format::R32G32B32A32_SFLOAT,
                offset: 0,
            },
            vk::VertexInputAttributeDescription {
                location: 1,
                binding: 0,
                format: vk::Format::R32G32B32A32_SFLOAT,
                offset: 16,
            },
        ];
        state.rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
            .depth_clamp_enable(false)
            .rasterizer_discard_enable(false)
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(vk::CullModeFlags::NONE)
            .front_face(vk::FrontFace::CLOCKWISE)
            .depth_bias_enable(false)
            .line_width(1.0)
            .build();
        let stencil = vk::StencilOpState::builder()
            .fail_op(vk::StencilOp::KEEP)
            .pass_op(vk::StencilOp::KEEP)
            .depth_fail_op(vk::StencilOp::KEEP)
            .compare_op(vk::CompareOp::NEVER)
            .compare_mask(0)
            .write_mask(0)
            .reference(0)
            .build();
        state.depth_stencil = vk::PipelineDepthStencilStateCreateInfo::builder()
            .depth_test_enable(true)
            .depth_write_enable(true)
            .depth_compare_op(vk::CompareOp::LESS_OR_EQUAL)
            .depth_bounds_test_enable(false)
            .stencil_test_enable(false)
            .front(stencil)
            .back(stencil)
            .min_depth_bounds(0.0)
            .max_depth_bounds(1.0)
            .build();
        if has_tessellation {
            state.patch_control_points = Some(3);
        }
        state
    }

    /// The same with the `useShaderModules` and `monolithicBinaryInfo` arguments of the pipeline binary mode.
    fn prepare_pipeline_with(
        &self,
        cache: vk::PipelineCache,
        use_miss_shaders: bool,
        binary: Option<&BinaryPipelineOptions>,
    ) -> Result<Unique<'a, vk::Pipeline>, TestError> {
        let device = self.device;
        let binaries = self.context.get_binary_collection();
        let postfix = if use_miss_shaders { "_miss" } else { "" };
        let create_module = |name: &str| create_shader_module(device, binaries.get(&format!("{name}{postfix}"))?);

        let vert_module = create_module("color_vert")?;
        let frag_module = create_module("color_frag")?;
        let has_geometry = self.param.stages == Stages::VertGeomFrag;
        let has_tessellation = self.param.stages == Stages::VertTessFrag;
        let geom_module = if has_geometry {
            Some(create_module("unused_geo")?)
        } else {
            None
        };
        let tesc_module = if has_tessellation {
            Some(create_module("basic_tcs")?)
        } else {
            None
        };
        let tese_module = if has_tessellation {
            Some(create_module("basic_tes")?)
        } else {
            None
        };

        let mut stages = vec![(vk::ShaderStageFlags::VERTEX, *vert_module)];
        if let Some(module) = &tesc_module {
            stages.push((vk::ShaderStageFlags::TESSELLATION_CONTROL, **module));
        }
        if let Some(module) = &tese_module {
            stages.push((vk::ShaderStageFlags::TESSELLATION_EVALUATION, **module));
        }
        if let Some(module) = &geom_module {
            stages.push((vk::ShaderStageFlags::GEOMETRY, **module));
        }
        stages.push((vk::ShaderStageFlags::FRAGMENT, *frag_module));

        let mut state = self.make_draw_state();
        state.pipeline_cache = cache;
        if let Some(options) = binary {
            // Both pipelines of a binary test capture their data, as `setPipelineCreateFlags2` does upstream
            state.create_flags2 = Some(vk::PipelineCreateFlags2::CAPTURE_DATA_KHR);
            state.null_shader_modules = !options.use_shader_modules;
            state.check_pipeline_key = options.use_shader_modules;
            state.binary_info = options.binaries.clone();
        }

        create_draw_pipeline(device, *self.pipeline_layout, *self.render_passes[0], &stages, &state)
    }

    /// `GraphicsTestInstance::preparePipelinesForBinaries`: the first pipeline from the shaders, the second from its binaries.
    fn prepare_pipelines_for_binaries(
        &self,
        create_from_blobs: bool,
    ) -> Result<([Unique<'a, vk::Pipeline>; 2], PipelineBinaryWrapper<'a>), TestError> {
        let device = self.device;
        let mut binaries = PipelineBinaryWrapper::new(device);

        let pipeline0 = self.prepare_pipeline_with(
            vk::PipelineCache::null(),
            false,
            Some(&BinaryPipelineOptions {
                use_shader_modules: true,
                binaries: None,
            }),
        )?;

        binaries.create_from_pipeline(*pipeline0);

        if create_from_blobs {
            // read binaries data out of the device
            let blobs = binaries.get_pipeline_binary_data()?;

            // clear pipeline binaries objects
            binaries.delete_binaries_keep_keys();

            // recreate binaries from data blobs
            binaries.create_from_binary_data(&blobs);
        } else {
            release_captured_pipeline_data(device, *pipeline0);
        }

        let binary_handles = if binaries.handles().is_empty() {
            None
        } else {
            Some(binaries.handles().to_vec())
        };
        let pipeline1 = self.prepare_pipeline_with(
            vk::PipelineCache::null(),
            false,
            Some(&BinaryPipelineOptions {
                use_shader_modules: false,
                binaries: binary_handles,
            }),
        )?;

        Ok(([pipeline0, pipeline1], binaries))
    }

    /// `GraphicsTestInstance::prepareCommandBuffer`, recording both draws
    fn prepare_command_buffer(&self, pipelines: [&Prepared<'a>; 2]) -> Result<(), TestError> {
        let device = self.device;
        let cmd = *self.cmd_buffer;

        begin_command_buffer(device, cmd)?;

        let color_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let barriers = [
            make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                self.color_images[0].get(),
                color_range,
            ),
            make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                self.color_images[1].get(),
                color_range,
            ),
            make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                self.depth_image.get(),
                make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, 0, 1),
            ),
        ];
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &barriers,
            );
        }

        let clear_values = [
            clear_value_color(DEFAULT_CLEAR_COLOR),
            vk::ClearValue {
                depth_stencil: vk::ClearDepthStencilValue { depth: 1.0, stencil: 0 },
            },
        ];
        // After the first render pass the images are in the layouts the second one expects.
        for ndx in 0..2 {
            match pipelines[ndx] {
                Prepared::Pipeline(pipeline) => {
                    let begin_info = vk::RenderPassBeginInfo::builder()
                        .render_pass(*self.render_passes[ndx])
                        .framebuffer(*self.framebuffers[ndx])
                        .render_area(rect_2d(RENDER_SIZE, RENDER_SIZE))
                        .clear_values(&clear_values);
                    unsafe {
                        device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
                        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, **pipeline);
                        device.cmd_bind_vertex_buffers(cmd, 0, &[self.vertex_buffer.get()], &[0]);
                        device.cmd_draw(cmd, self.num_vertices, 1, 0, 0);
                        device.cmd_end_render_pass(cmd);
                    }
                }
                Prepared::Objects(shader_objects) => {
                    let color = RenderingAttachment {
                        view: *self.color_views[ndx],
                        layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                        clear_value: clear_values[0],
                    };
                    let depth = RenderingAttachment {
                        view: *self.depth_view,
                        layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                        clear_value: clear_values[1],
                    };
                    begin_dynamic_rendering(
                        device,
                        cmd,
                        rect_2d(RENDER_SIZE, RENDER_SIZE),
                        &[color],
                        Some(depth),
                        None,
                    );
                    shader_objects.bind(cmd, &self.make_draw_state());
                    unsafe {
                        device.cmd_bind_vertex_buffers(cmd, 0, &[self.vertex_buffer.get()], &[0]);
                        device.cmd_draw(cmd, self.num_vertices, 1, 0, 0);
                    }
                    end_dynamic_rendering(device, cmd);
                }
            }
        }

        end_command_buffer(device, cmd)
    }

    /// `readColorAttachment`
    fn read_color_image(&self, image: vk::Image) -> Result<Vec<u8>, TestError> {
        let device = self.device;
        let size = (RENDER_SIZE * RENDER_SIZE * 4) as usize;
        let buffer = BufferWithMemory::new(
            device,
            self.context.get_default_allocator(),
            make_buffer_create_info(size as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let cmd_buffer = allocate_command_buffer(device, *self.cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;
        begin_command_buffer(device, cmd)?;
        copy_image_to_buffer(device, cmd, image, buffer.get(), RENDER_SIZE, RENDER_SIZE);
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, self.context.get_universal_queue(), cmd)?;
        invalidate_alloc(device, buffer.get_allocation())?;
        Ok(unsafe { std::slice::from_raw_parts(buffer.get_allocation().get_host_ptr(), size) }.to_vec())
    }

    /// `BaseTestInstance::iterate` over the two pipelines, then `GraphicsTestInstance::verifyTestResult`
    fn run(&self, pipelines: [&Prepared<'a>; 2]) -> TestOutcome {
        self.prepare_command_buffer(pipelines)?;
        submit_commands_and_wait(self.device, self.context.get_universal_queue(), *self.cmd_buffer)?;

        let result_no_cache = self.read_color_image(self.color_images[0].get())?;
        let result_cache = self.read_color_image(self.color_images[1].get())?;

        let compare_ok = result_no_cache
            .iter()
            .zip(&result_cache)
            .all(|(&a, &b)| a.abs_diff(b) <= 1);
        if compare_ok {
            Ok(TestStatus::pass("Render images w/o cached pipeline match."))
        } else {
            Ok(TestStatus::fail("Render Images mismatch."))
        }
    }

    /// `MergeBlobsTestInstance::createPipelineCache`
    fn create_blobs_cache(&self, ty: MergeBlobsType) -> Result<Unique<'a, vk::PipelineCache>, TestError> {
        let device = self.device;
        match ty {
            MergeBlobsType::Empty => create_pipeline_cache(device, vk::PipelineCacheCreateFlags::empty(), &[]),
            MergeBlobsType::FromData => {
                // Create a cache with init data from the fixture's cache
                let data = get_cache_data(device, *self.cache)?;
                create_pipeline_cache(device, vk::PipelineCacheCreateFlags::empty(), &data)
            }
            MergeBlobsType::Hit => {
                let ret = self.create_blobs_cache(MergeBlobsType::Empty)?;
                let _pipeline = self.prepare_pipeline(*ret, false)?;
                Ok(ret)
            }
            MergeBlobsType::Miss => {
                let ret = self.create_blobs_cache(MergeBlobsType::Empty)?;
                let _pipeline = self.prepare_pipeline(*ret, true)?;
                Ok(ret)
            }
            MergeBlobsType::MissAndHit => {
                let ret = self.create_blobs_cache(MergeBlobsType::Empty)?;
                let _pipeline = self.prepare_pipeline(*ret, false)?;
                let _miss_pipeline = self.prepare_pipeline(*ret, true)?;
                Ok(ret)
            }
            MergeBlobsType::Merged => {
                let cache1 = self.create_blobs_cache(MergeBlobsType::FromData)?;
                let cache2 = self.create_blobs_cache(MergeBlobsType::Hit)?;
                let cache3 = self.create_blobs_cache(MergeBlobsType::Miss)?;
                let ret = self.create_blobs_cache(MergeBlobsType::Empty)?;
                unsafe { device.merge_pipeline_caches(*ret, &[*cache1, *cache2, *cache3]) }
                    .vk_check("vkMergePipelineCaches")?;
                Ok(ret)
            }
        }
    }
}

/// `CacheHeaderTestInstance::CacheHeaderTestInstance`
fn check_cache_header(fixture: &GraphicsFixture<'_>) -> Result<(), TestError> {
    let context = fixture.context;
    let data = get_cache_data(fixture.device, *fixture.cache)?;

    const HEADER_SIZE: usize = 16 + UUID_SIZE;
    if data.len() < HEADER_SIZE {
        return Err(TestError::Fail(
            "Pipeline cache size is smaller than header size".to_string(),
        ));
    }

    let read_u32 =
        |offset: usize| u32::from_ne_bytes([data[offset], data[offset + 1], data[offset + 2], data[offset + 3]]);
    let (header_length, header_version, vendor_id, device_id) = (read_u32(0), read_u32(4), read_u32(8), read_u32(12));
    let pipeline_cache_uuid = &data[16..16 + UUID_SIZE];

    if header_length.wrapping_sub(UUID_SIZE as u32) != 16 {
        return Err(TestError::Fail("Invalid header size!".to_string()));
    }
    if header_version != 1 {
        return Err(TestError::Fail("Invalid header version!".to_string()));
    }
    let properties = context.get_device_properties();
    if vendor_id != properties.vendor_id {
        return Err(TestError::Fail("Invalid header vendor ID!".to_string()));
    }
    if device_id != properties.device_id {
        return Err(TestError::Fail("Invalid header device ID!".to_string()));
    }
    if pipeline_cache_uuid != &properties.pipeline_cache_uuid.0[..] {
        return Err(TestError::Fail("Invalid header pipeline cache UUID!".to_string()));
    }
    Ok(())
}

/// `InvalidSizeTestInstance::InvalidSizeTestInstance`
fn check_invalid_size(fixture: &GraphicsFixture<'_>) -> Result<(), TestError> {
    let device = fixture.device;
    let cache = *fixture.cache;
    const INCOMPLETE_ERROR: &str = "GetPipelineCacheData should return VK_INCOMPLETE state!";

    let mut data_size = 0usize;
    let result = get_cache_data_raw(device, cache, &mut data_size, &mut []);
    if result != vk::Result::SUCCESS {
        return Err(TestError::InternalError(format!(
            "vkGetPipelineCacheData returned {result:?}"
        )));
    }
    let saved_data_size = data_size;

    // If the value of dataSize is less than the maximum size that can be retrieved by the pipeline cache,
    // at most pDataSize bytes will be written to pData, and vkGetPipelineCacheData will return VK_INCOMPLETE.
    data_size = saved_data_size.saturating_sub(1);
    let mut data = vec![0u8; saved_data_size];
    if get_cache_data_raw(device, cache, &mut data_size, &mut data) != vk::Result::INCOMPLETE {
        return Err(TestError::Fail(INCOMPLETE_ERROR.to_string()));
    }

    // If the value of dataSize is less than what is necessary to store the header,
    // nothing will be written to pData and zero will be written to dataSize.
    data_size = 16 + UUID_SIZE - 1;
    let mut data = vec![0u8; saved_data_size];
    if get_cache_data_raw(device, cache, &mut data_size, &mut data) != vk::Result::INCOMPLETE {
        return Err(TestError::Fail(INCOMPLETE_ERROR.to_string()));
    }

    if data.iter().any(|&byte| byte != 0) || data_size != 0 {
        return Err(TestError::Fail(
            "Data needs to be empty and data size should be 0 when invalid size is passed to GetPipelineCacheData!"
                .to_string(),
        ));
    }
    Ok(())
}

/// `ZeroSizeTestInstance::ZeroSizeTestInstance`
fn check_zero_size(fixture: &GraphicsFixture<'_>) -> Result<(), TestError> {
    let device = fixture.device;
    let data = get_cache_data(device, *fixture.cache)?;

    // Create a cache with initialDataSize = 0 & pInitialData != NULL
    let mut info = vk::PipelineCacheCreateInfo::builder().initial_data(&data);
    info.initial_data_size = 0;
    let _pipeline_cache = Unique::new(
        device,
        unsafe { device.create_pipeline_cache(&info, None) }.vk_check("vkCreatePipelineCache")?,
    );
    Ok(())
}

/// `InvalidBlobTestInstance::InvalidBlobTestInstance`
fn check_invalid_blob(fixture: &GraphicsFixture<'_>) -> Result<(), TestError> {
    let device = fixture.device;
    let mut data = get_cache_data(device, *fixture.cache)?;

    // pipeline cache header version, vendor ID, device ID and pipeline cache ID
    for offset in [4usize, 8, 12, 16] {
        // Add arbitrary number to create an invalid value
        data[offset] = data[offset].wrapping_add(13);

        let _pipeline_cache = create_pipeline_cache(device, vk::PipelineCacheCreateFlags::empty(), &data)?;

        // Return to original value
        data[offset] = data[offset].wrapping_sub(13);
    }
    Ok(())
}

/// The graphics-derived tests: the constructor work of the instance class, then the common `iterate`.
fn iterate_graphics<'a>(context: &'a Context<'a>, case: &CacheTestCase) -> TestOutcome {
    let fixture = GraphicsFixture::new(context, case.param)?;
    let device = fixture.device;

    match &case.kind {
        Kind::Graphics | Kind::PipelineFromBlobs if case.param.binary => {
            let (pipelines, _binaries) =
                fixture.prepare_pipelines_for_binaries(matches!(case.kind, Kind::PipelineFromBlobs))?;
            let [pipeline0, pipeline1] = pipelines;
            fixture.run([&Prepared::Pipeline(pipeline0), &Prepared::Pipeline(pipeline1)])
        }
        Kind::Graphics => {
            let pipeline0 = fixture.prepare_pipeline(*fixture.cache, false)?;
            let pipeline1 = fixture.prepare_pipeline(*fixture.cache, false)?;
            fixture.run([&pipeline0, &pipeline1])
        }
        Kind::PipelineFromBlobs => {
            // Create more pipeline caches
            let data = get_cache_data(device, *fixture.cache)?;
            let new_cache = create_pipeline_cache(device, vk::PipelineCacheCreateFlags::empty(), &data)?;

            let pipeline0 = fixture.prepare_pipeline(*fixture.cache, false)?;
            let pipeline1 = fixture.prepare_pipeline(*new_cache, false)?;
            fixture.run([&pipeline0, &pipeline1])
        }
        Kind::PipelineFromIncompleteBlobs => {
            // Create more pipeline caches
            let mut data_size = 0usize;
            let result = get_cache_data_raw(device, *fixture.cache, &mut data_size, &mut []);
            if result != vk::Result::SUCCESS {
                return Err(TestError::InternalError(format!(
                    "vkGetPipelineCacheData returned {result:?}"
                )));
            }
            if data_size == 0 {
                return Err(TestError::NotSupported(
                    "Empty pipeline cache - unable to test".to_string(),
                ));
            }

            data_size -= 1;
            let mut data = vec![0u8; data_size];
            if get_cache_data_raw(device, *fixture.cache, &mut data_size, &mut data) != vk::Result::INCOMPLETE {
                return Err(TestError::Fail(
                    "GetPipelineCacheData should return VK_INCOMPLETE state!".to_string(),
                ));
            }
            let new_cache = create_pipeline_cache(device, vk::PipelineCacheCreateFlags::empty(), &data[..data_size])?;

            let pipeline0 = fixture.prepare_pipeline(*fixture.cache, false)?;
            let pipeline1 = fixture.prepare_pipeline(*new_cache, false)?;
            fixture.run([&pipeline0, &pipeline1])
        }
        Kind::MergeBlobs(merge_param) => {
            // Create a merge destination cache
            let cache_merged = fixture.create_blobs_cache(merge_param.dest_blobs_type)?;

            // Create more pipeline caches
            let mut source_caches = Vec::new();
            for &src_type in &merge_param.src_blob_types {
                source_caches.push(fixture.create_blobs_cache(src_type)?);
            }

            // Merge the caches
            let source_handles: Vec<vk::PipelineCache> = source_caches.iter().map(|cache| **cache).collect();
            unsafe { device.merge_pipeline_caches(*cache_merged, &source_handles) }
                .vk_check("vkMergePipelineCaches")?;

            let pipeline0 = fixture.prepare_pipeline(*fixture.cache, false)?;
            // Create pipeline from merged cache
            let pipeline1 = fixture.prepare_pipeline(*cache_merged, false)?;
            fixture.run([&pipeline0, &pipeline1])
        }
        Kind::CacheHeader | Kind::InvalidSize | Kind::ZeroSize | Kind::InvalidBlob => {
            match case.kind {
                Kind::CacheHeader => check_cache_header(&fixture)?,
                Kind::InvalidSize => check_invalid_size(&fixture)?,
                Kind::ZeroSize => check_zero_size(&fixture)?,
                _ => check_invalid_blob(&fixture)?,
            }

            let pipeline0 = fixture.prepare_pipeline(*fixture.cache, false)?;
            let pipeline1 = fixture.prepare_pipeline(*fixture.cache, false)?;
            fixture.run([&pipeline0, &pipeline1])
        }
        Kind::Compute | Kind::InternallySynchronized => {
            Err(TestError::InternalError("not a graphics case".to_string()))
        }
    }
}

/// `ComputeTestInstance`
fn iterate_compute<'a>(context: &'a Context<'a>, param: &TestParam) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();

    // BaseTestInstance
    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cache = create_pipeline_cache(device, param.cache_create_flags, &[])?;

    // buildBuffers: create buffer object, allocate storage, and generate input data
    let input_buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(
            COMPUTE_BUFFER_SIZE as vk::DeviceSize,
            vk::BufferUsageFlags::STORAGE_BUFFER,
        ),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    {
        let elements = input_buffer.get_allocation().get_host_ptr().cast::<f32>();
        for ndx in 0..COMPUTE_ELEMENTS {
            for component in 0..4 {
                unsafe {
                    elements
                        .add(ndx * 4 + component)
                        .write_unaligned((ndx * (component + 1)) as f32)
                };
            }
        }
        flush_alloc(device, input_buffer.get_allocation())?;
    }

    let make_output = || -> Result<BufferWithMemory<'a>, TestError> {
        // Clear the output buffer
        let output = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(
                COMPUTE_BUFFER_SIZE as vk::DeviceSize,
                vk::BufferUsageFlags::STORAGE_BUFFER,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe { std::ptr::write_bytes(output.get_allocation().get_host_ptr(), 0, COMPUTE_BUFFER_SIZE) };
        flush_alloc(device, output.get_allocation())?;
        Ok(output)
    };
    let outputs = [make_output()?, make_output()?];

    // buildDescriptorSets
    let mut sides = Vec::new();
    for output in &outputs {
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 2)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        let descriptor_infos = [
            [vk::DescriptorBufferInfo {
                buffer: input_buffer.get(),
                offset: 0,
                range: COMPUTE_BUFFER_SIZE as vk::DeviceSize,
            }],
            [vk::DescriptorBufferInfo {
                buffer: output.get(),
                offset: 0,
                range: COMPUTE_BUFFER_SIZE as vk::DeviceSize,
            }],
        ];
        let writes: Vec<_> = (0..2)
            .map(|binding| {
                vk::WriteDescriptorSet::builder()
                    .dst_set(descriptor_set.get())
                    .dst_binding(binding as u32)
                    .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                    .buffer_info(&descriptor_infos[binding])
            })
            .collect();
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        sides.push((descriptor_set, descriptor_pool, descriptor_set_layout));
    }

    // buildShader
    let compute_module = create_shader_module(device, context.get_binary_collection().get("basic_compute")?)?;

    // buildPipeline
    let mut pipelines = Vec::new();
    let mut compute_binaries = PipelineBinaryWrapper::new(device);
    for (ndx, (_, _, descriptor_set_layout)) in sides.iter().enumerate() {
        let pipeline_layout = make_pipeline_layout(device, &[**descriptor_set_layout])?;
        let stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(*compute_module)
            .name(b"main\0")
            .build();
        if !param.binary {
            let pipeline_info = vk::ComputePipelineCreateInfo::builder()
                .stage(stage)
                .layout(*pipeline_layout)
                .base_pipeline_index(0)
                .build();
            let created = unsafe { device.create_compute_pipelines(*cache, &[pipeline_info], None) }
                .vk_check("vkCreateComputePipelines")?;
            pipelines.push((Unique::new(device, created.0[0]), pipeline_layout));
        } else if ndx == 0 {
            let mut flags2_info =
                vk::PipelineCreateFlags2CreateInfo::builder().flags(vk::PipelineCreateFlags2::CAPTURE_DATA_KHR);
            let pipeline_info = vk::ComputePipelineCreateInfo::builder()
                .stage(stage)
                .layout(*pipeline_layout)
                .base_pipeline_index(0)
                .push_next(&mut flags2_info);

            let pipeline_key =
                compute_binaries.get_pipeline_key((&*pipeline_info as *const vk::ComputePipelineCreateInfo).cast())?;
            if pipeline_key.key_size == 0 {
                return Err(TestError::Fail("vkGetPipelineKeyKHR returned keySize == 0".to_string()));
            }

            // create pipeline
            let created =
                unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[*pipeline_info], None) }
                    .vk_check("vkCreateComputePipelines")?;
            let pipeline = Unique::new(device, created.0[0]);

            // prepare pipeline binaries
            compute_binaries.create_from_pipeline(*pipeline);

            if param.use_binaries_from_binary_data {
                // read binaries data out of the device
                let blobs = compute_binaries.get_pipeline_binary_data()?;

                // clear pipeline binaries objects
                compute_binaries.delete_binaries_keep_keys();

                // recreate binaries from data blobs
                compute_binaries.create_from_binary_data(&blobs);
            }
            pipelines.push((pipeline, pipeline_layout));
        } else {
            // create pipeline using binary data and use pipelineCreateInfo with no shader stage
            let binary_handles = compute_binaries.handles().to_vec();
            let mut binary_info = vk::PipelineBinaryInfoKHR::builder().pipeline_binaries(&binary_handles);
            let mut stage_without_module = stage;
            stage_without_module.module = vk::ShaderModule::null();
            let pipeline_info = vk::ComputePipelineCreateInfo::builder()
                .stage(stage_without_module)
                .layout(*pipeline_layout)
                .base_pipeline_index(0)
                .push_next(&mut binary_info);
            let created =
                unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[*pipeline_info], None) }
                    .vk_check("vkCreateComputePipelines")?;
            pipelines.push((Unique::new(device, created.0[0]), pipeline_layout));
        }
    }

    // prepareCommandBuffer
    let cmd = *cmd_buffer;
    begin_command_buffer(device, cmd)?;
    for ((descriptor_set, _, _), (pipeline, pipeline_layout)) in sides.iter().zip(&pipelines) {
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, **pipeline);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::COMPUTE,
                **pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[],
            );
            device.cmd_dispatch(cmd, COMPUTE_ELEMENTS as u32, 1, 1);
        }
    }
    end_command_buffer(device, cmd)?;

    submit_commands_and_wait(device, queue, cmd)?;

    // verifyTestResult: read the content of output buffers and compare it
    invalidate_alloc(device, outputs[0].get_allocation())?;
    invalidate_alloc(device, outputs[1].get_allocation())?;
    let buf_no_cache =
        unsafe { std::slice::from_raw_parts(outputs[0].get_allocation().get_host_ptr(), COMPUTE_BUFFER_SIZE) };
    let buf_cached =
        unsafe { std::slice::from_raw_parts(outputs[1].get_allocation().get_host_ptr(), COMPUTE_BUFFER_SIZE) };
    if buf_no_cache != buf_cached {
        return Ok(TestStatus::fail("Output buffers w/o pipeline blobs mismatch."));
    }

    Ok(TestStatus::pass("Output buffers w/o pipeline blobs match."))
}

/// `CreatePipelineThread::run`
fn create_pipeline_thread(
    device: &Device,
    compute_module: vk::ShaderModule,
    pipeline_layout: vk::PipelineLayout,
    pipeline_cache: vk::PipelineCache,
) -> Result<(), TestError> {
    for _ in 0..THREAD_ITERATIONS {
        let stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(compute_module)
            .name(b"main\0")
            .build();
        let pipeline_info = vk::ComputePipelineCreateInfo::builder()
            .stage(stage)
            .layout(pipeline_layout)
            .base_pipeline_index(0)
            .build();
        let created = unsafe { device.create_compute_pipelines(pipeline_cache, &[pipeline_info], None) }
            .vk_check("vkCreateComputePipelines")?;
        let _pipeline = Unique::new(device, created.0[0]);
    }
    Ok(())
}

/// `MergePipelineCacheThread::run`
fn merge_pipeline_cache_thread(
    device: &Device,
    compute_module: vk::ShaderModule,
    pipeline_layout: vk::PipelineLayout,
    pipeline_cache: vk::PipelineCache,
) -> Result<(), TestError> {
    for iter_idx in 0..THREAD_ITERATIONS {
        let mut flags = vk::PipelineCacheCreateFlags::empty();
        if iter_idx % 2 == 0 {
            flags |= vk::PipelineCacheCreateFlags::EXTERNALLY_SYNCHRONIZED;
        }
        let local_pipeline_cache = create_pipeline_cache(device, flags, &[])?;

        let stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(compute_module)
            .name(b"main\0")
            .build();
        let pipeline_info = vk::ComputePipelineCreateInfo::builder()
            .stage(stage)
            .layout(pipeline_layout)
            .base_pipeline_index(0)
            .build();
        let created = unsafe { device.create_compute_pipelines(*local_pipeline_cache, &[pipeline_info], None) }
            .vk_check("vkCreateComputePipelines")?;
        let _pipeline = Unique::new(device, created.0[0]);

        // Upstream ignores the result of the merge
        let _ = unsafe { device.merge_pipeline_caches(pipeline_cache, &[*local_pipeline_cache]) };
    }
    Ok(())
}

/// `InternallySynchronizedInstance::iterate`
fn iterate_internally_synchronized<'a>(context: &'a Context<'a>) -> TestOutcome {
    let device = context.get_device();

    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
        .build(device)?;
    let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
    let compute_module = create_shader_module(device, context.get_binary_collection().get("basic_compute")?)?;

    let cache_flags = vk::PipelineCacheCreateFlags::INTERNALLY_SYNCHRONIZED_MERGE_KHR;
    let global_pipeline_cache = create_pipeline_cache(device, cache_flags, &[])?;

    let (module_handle, layout_handle, cache_handle) = (*compute_module, *pipeline_layout, *global_pipeline_cache);
    let (create_result, merge_result) = std::thread::scope(|scope| {
        let create_thread = scope.spawn(|| create_pipeline_thread(device, module_handle, layout_handle, cache_handle));
        let merge_thread =
            scope.spawn(|| merge_pipeline_cache_thread(device, module_handle, layout_handle, cache_handle));
        (create_thread.join(), merge_thread.join())
    });
    create_result.map_err(|_| TestError::Fail("Pipeline creation thread panicked".to_string()))??;
    merge_result.map_err(|_| TestError::Fail("Pipeline cache merge thread panicked".to_string()))??;

    let cache_data = get_cache_data(device, *global_pipeline_cache)?;

    drop(global_pipeline_cache);

    let global_pipeline_cache = create_pipeline_cache(device, cache_flags, &cache_data)?;

    {
        let _cache_data2 = get_cache_data(device, *global_pipeline_cache)?;
    }

    let stage = vk::PipelineShaderStageCreateInfo::builder()
        .stage(vk::ShaderStageFlags::COMPUTE)
        .module(*compute_module)
        .name(b"main\0")
        .build();
    let pipeline_info = vk::ComputePipelineCreateInfo::builder()
        .stage(stage)
        .layout(*pipeline_layout)
        .base_pipeline_index(0)
        .build();
    for _ in 0..2 {
        let created = unsafe { device.create_compute_pipelines(*global_pipeline_cache, &[pipeline_info], None) }
            .vk_check("vkCreateComputePipelines")?;
        let _pipeline = Unique::new(device, created.0[0]);
    }

    Ok(TestStatus::pass("Pass"))
}

fn add_case(group: &mut TestCaseGroup, name: String, param: TestParam, kind: Kind) {
    group.add_child(Box::new(CacheTestCase { name, param, kind }) as Box<dyn TestCase>);
}

/// `createCacheTests` for the monolithic construction type: `createPipelineBlobTestsInternal` with `TestMode::CACHE`.
pub fn create_cache_tests() -> TestCaseGroup {
    create_cache_tests_for(false)
}

/// `createCacheTests`; the shader object construction types leave out the compute and internally synchronized cases.
pub fn create_cache_tests_for(shader_object: bool) -> TestCaseGroup {
    let mut cache_tests = TestCaseGroup::new("cache");
    let no_flags = vk::PipelineCacheCreateFlags::empty();
    let externally_synchronized = vk::PipelineCacheCreateFlags::EXTERNALLY_SYNCHRONIZED;
    let graphics_stages = [Stages::VertFrag, Stages::VertGeomFrag, Stages::VertTessFrag];

    // Graphics Pipeline Tests
    {
        let mut graphics_tests = TestCaseGroup::new("graphics_tests");
        for flags in [no_flags, externally_synchronized] {
            for stages in graphics_stages {
                let param = TestParam::new(stages, false, flags);
                add_case(&mut graphics_tests, param.generate_test_name(), param, Kind::Graphics);
            }
        }
        cache_tests.add_child(graphics_tests);
    }

    // Graphics Pipeline Tests
    {
        let mut graphics_tests = TestCaseGroup::new("pipeline_from_get_data");
        for stages in graphics_stages {
            let param = TestParam::new(stages, false, no_flags);
            add_case(
                &mut graphics_tests,
                param.generate_test_name(),
                param,
                Kind::PipelineFromBlobs,
            );
        }
        cache_tests.add_child(graphics_tests);
    }

    // Graphics Pipeline Tests
    {
        let mut graphics_tests = TestCaseGroup::new("pipeline_from_incomplete_get_data");
        for stages in graphics_stages {
            let param = TestParam::new(stages, false, no_flags);
            add_case(
                &mut graphics_tests,
                param.generate_test_name(),
                param,
                Kind::PipelineFromIncompleteBlobs,
            );
        }
        cache_tests.add_child(graphics_tests);
    }

    // Compute Pipeline Tests
    if !shader_object {
        let mut compute_tests = TestCaseGroup::new("compute_tests");
        let param = TestParam::new(Stages::Compute, false, no_flags);
        add_case(&mut compute_tests, param.generate_test_name(), param, Kind::Compute);
        cache_tests.add_child(compute_tests);
    }

    // Merge blobs tests
    {
        let mut merge_tests = TestCaseGroup::new("merge");
        for stages in graphics_stages {
            let param = TestParam::new(stages, true, no_flags);
            let mut merge_stages_tests = TestCaseGroup::new(param.generate_test_name());

            for dest_type in MERGE_BLOBS_TYPES {
                for src_type1 in MERGE_BLOBS_TYPES {
                    let merge_param = MergeBlobsTestParam {
                        dest_blobs_type: dest_type,
                        src_blob_types: vec![src_type1],
                    };

                    // merge with one cache
                    {
                        let name = format!(
                            "src_{}_dst_{}",
                            merge_blobs_types_str(&merge_param.src_blob_types),
                            merge_blobs_type_str(merge_param.dest_blobs_type)
                        );
                        add_case(
                            &mut merge_stages_tests,
                            name,
                            param,
                            Kind::MergeBlobs(merge_param.clone()),
                        );
                    }

                    // merge with two caches
                    for src_type2 in MERGE_BLOBS_TYPES {
                        let mut two_caches_param = merge_param.clone();
                        two_caches_param.src_blob_types.push(src_type2);

                        let name = format!(
                            "src_{}_dst_{}",
                            merge_blobs_types_str(&two_caches_param.src_blob_types),
                            merge_blobs_type_str(two_caches_param.dest_blobs_type)
                        );
                        add_case(&mut merge_stages_tests, name, param, Kind::MergeBlobs(two_caches_param));
                    }
                }
            }
            merge_tests.add_child(merge_stages_tests);
        }
        cache_tests.add_child(merge_tests);
    }

    // Misc Tests
    {
        let mut misc_tests = TestCaseGroup::new("misc_tests");
        let param = TestParam::new(Stages::VertFrag, false, no_flags);
        add_case(
            &mut misc_tests,
            "cache_header_test".to_string(),
            param,
            Kind::CacheHeader,
        );
        add_case(
            &mut misc_tests,
            "invalid_size_test".to_string(),
            param,
            Kind::InvalidSize,
        );
        add_case(&mut misc_tests, "zero_size_test".to_string(), param, Kind::ZeroSize);
        add_case(
            &mut misc_tests,
            "invalid_blob_test".to_string(),
            param,
            Kind::InvalidBlob,
        );
        if !shader_object {
            add_case(
                &mut misc_tests,
                "internally_synchronized_test".to_string(),
                param,
                Kind::InternallySynchronized,
            );
        }
        cache_tests.add_child(misc_tests);
    }

    cache_tests
}

/// `addPipelineBinaryBasicTests` for the monolithic construction type: `createPipelineBlobTestsInternal` with
/// `TestMode::BINARY`, whose groups go straight into upstream's `pipeline_binary` group.
pub(super) fn add_pipeline_binary_basic_tests(binary_tests: &mut TestCaseGroup) {
    let graphics_stages = [Stages::VertFrag, Stages::VertGeomFrag, Stages::VertTessFrag];

    // Graphics Pipeline Tests (the cache create flags are tested only for the cache cases)
    {
        let mut graphics_tests = TestCaseGroup::new("graphics_tests");
        for stages in graphics_stages {
            let param = TestParam::new_binary(stages, false);
            add_case(&mut graphics_tests, param.generate_test_name(), param, Kind::Graphics);
        }
        binary_tests.add_child(graphics_tests);
    }

    // Graphics Pipeline Tests
    {
        let mut graphics_tests = TestCaseGroup::new("pipeline_from_get_data");
        for stages in graphics_stages {
            let param = TestParam::new_binary(stages, false);
            add_case(
                &mut graphics_tests,
                param.generate_test_name(),
                param,
                Kind::PipelineFromBlobs,
            );
        }
        binary_tests.add_child(graphics_tests);
    }

    // Compute Pipeline Tests
    {
        let mut compute_tests = TestCaseGroup::new("compute_tests");
        for use_binary_data in [false, true] {
            let param = TestParam::new_binary(Stages::Compute, use_binary_data);
            add_case(&mut compute_tests, param.generate_test_name(), param, Kind::Compute);
        }
        binary_tests.add_child(compute_tests);
    }
}
