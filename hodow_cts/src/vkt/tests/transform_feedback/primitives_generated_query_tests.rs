// SPDX-License-Identifier: Apache-2.0
//
// Ported from external/vulkancts/modules/vulkan/transform_feedback/
// vktPrimitivesGeneratedQueryTests.cpp

use vulkanalia::Device;
use vulkanalia::vk::{self, HasBuilder};

use crate::vk::programs::BinaryCollection;
use crate::vk::{Unique, VkResultExt};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestError, TestInstance};

/// The one program set, holding every distinct shader this group needs; a case picks
/// its own by name.
pub struct PgqPrograms {
    pub name: &'static str,
    pub programs: BinaryCollection,
}

/// `QueryReadType`
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum QueryReadType {
    Get,
    Copy,
}

/// `QueryResetType`
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum QueryResetType {
    Queue,
    Host,
}

/// `QueryResultType`
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum QueryResultType {
    Bits32,
    Bits64,
    Pgq32Xfb64,
    Pgq64Xfb32,
}

/// `ShaderStage` - which stage is the last one before the rasteriser, and so the one
/// whose output the query counts.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum ShaderStage {
    Vertex,
    TessellationEvaluation,
    Geometry,
}

/// `RasterizationCase`
#[derive(Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
pub enum RasterizationCase {
    Default,
    Discard,
    EmptyFrag,
    NoAttachment,
    ColorWriteDisableStatic,
    ColorWriteDisableDynamic,
}

/// `VertexStream`. `Default` means the query is begun with the non-indexed entry point,
/// which is not the same thing as naming stream 0 explicitly.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum VertexStream {
    Default,
    Stream0,
    Stream1,
}

/// `CommandBufferCase`
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum CommandBufferCase {
    SingleDraw,
    TwoDraws,
}

/// `QueryOrder`
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum QueryOrder {
    PgqFirst,
    XfbqFirst,
}

/// `OutsideDraw` - a draw outside the active queries, which must not be counted.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum OutsideDraw {
    None,
    Before,
    After,
}

/// `TestParameters`
#[derive(Clone, Copy)]
pub struct TestParameters {
    pub query_read_type: QueryReadType,
    pub query_reset_type: QueryResetType,
    pub query_result_type: QueryResultType,
    pub shader_stage: ShaderStage,
    pub transform_feedback: bool,
    pub rast_case: RasterizationCase,
    pub depth_stencil_attachment: bool,
    pub primitive_topology: vk::PrimitiveTopology,
    pub pgq_stream: VertexStream,
    pub xfb_stream: VertexStream,
    pub cmd_buf_case: CommandBufferCase,
    pub query_count: u32,
    pub query_order: QueryOrder,
    pub outside_draw: OutsideDraw,
    pub availability_bit: bool,
}

impl TestParameters {
    pub fn pgq_default(&self) -> bool {
        self.pgq_stream == VertexStream::Default
    }
    pub fn xfb_default(&self) -> bool {
        self.xfb_stream == VertexStream::Default
    }
    pub fn pgq_stream_index(&self) -> u32 {
        stream_index(self.pgq_stream)
    }
    pub fn xfb_stream_index(&self) -> u32 {
        stream_index(self.xfb_stream)
    }
    pub fn multiple_streams(&self) -> bool {
        self.pgq_stream_index() != self.xfb_stream_index()
    }
    pub fn non_zero_streams(&self) -> bool {
        self.pgq_stream_index() != 0 || self.xfb_stream_index() != 0
    }
    pub fn rast_discard(&self) -> bool {
        self.rast_case == RasterizationCase::Discard
    }
    pub fn color_attachment(&self) -> bool {
        !self.rast_discard() && self.rast_case != RasterizationCase::NoAttachment
    }
    pub fn static_color_write_disable(&self) -> bool {
        self.rast_case == RasterizationCase::ColorWriteDisableStatic
    }
    pub fn dynamic_color_write_disable(&self) -> bool {
        self.rast_case == RasterizationCase::ColorWriteDisableDynamic
    }
    pub fn color_write_disable(&self) -> bool {
        self.static_color_write_disable() || self.dynamic_color_write_disable()
    }
}

fn stream_index(stream: VertexStream) -> u32 {
    match stream {
        VertexStream::Default | VertexStream::Stream0 => 0,
        VertexStream::Stream1 => 1,
    }
}

/// `TopologyInfo` - `primitiveSize` and the geometry shader layout qualifiers are only
/// needed once the shaders exist; `hasAdjacency` and the two counting functions decide
/// the case tree and the expected values.
pub struct TopologyInfo {
    pub primitive_size: u32,
    pub has_adjacency: bool,
    pub input_string: &'static str,
    pub output_string: &'static str,
    pub num_primitives: fn(u64) -> u64,
    pub num_vertices: fn(u64) -> u64,
}

pub fn topology_data(topology: vk::PrimitiveTopology) -> TopologyInfo {
    match topology {
        vk::PrimitiveTopology::POINT_LIST => TopologyInfo {
            primitive_size: 1,
            has_adjacency: false,
            input_string: "points",
            output_string: "points",
            num_primitives: |v| v,
            num_vertices: |p| p,
        },
        vk::PrimitiveTopology::LINE_LIST => TopologyInfo {
            primitive_size: 2,
            has_adjacency: false,
            input_string: "lines",
            output_string: "line_strip",
            num_primitives: |v| v / 2,
            num_vertices: |p| p * 2,
        },
        vk::PrimitiveTopology::LINE_STRIP => TopologyInfo {
            primitive_size: 2,
            has_adjacency: false,
            input_string: "lines",
            output_string: "line_strip",
            num_primitives: |v| v - 1,
            num_vertices: |p| p + 1,
        },
        vk::PrimitiveTopology::TRIANGLE_LIST => TopologyInfo {
            primitive_size: 3,
            has_adjacency: false,
            input_string: "triangles",
            output_string: "triangle_strip",
            num_primitives: |v| v / 3,
            num_vertices: |p| p * 3,
        },
        vk::PrimitiveTopology::TRIANGLE_STRIP => TopologyInfo {
            primitive_size: 3,
            has_adjacency: false,
            input_string: "triangles",
            output_string: "triangle_strip",
            num_primitives: |v| v - 2,
            num_vertices: |p| p + 2,
        },
        vk::PrimitiveTopology::TRIANGLE_FAN => TopologyInfo {
            primitive_size: 3,
            has_adjacency: false,
            input_string: "triangles",
            output_string: "triangle_strip",
            num_primitives: |v| v - 2,
            num_vertices: |p| p + 2,
        },
        vk::PrimitiveTopology::LINE_LIST_WITH_ADJACENCY => TopologyInfo {
            primitive_size: 2,
            has_adjacency: true,
            input_string: "lines_adjacency",
            output_string: "line_strip",
            num_primitives: |v| v / 4,
            num_vertices: |p| p * 4,
        },
        vk::PrimitiveTopology::LINE_STRIP_WITH_ADJACENCY => TopologyInfo {
            primitive_size: 2,
            has_adjacency: true,
            input_string: "lines_adjacency",
            output_string: "line_strip",
            num_primitives: |v| v - 3,
            num_vertices: |p| p + 3,
        },
        vk::PrimitiveTopology::TRIANGLE_LIST_WITH_ADJACENCY => TopologyInfo {
            primitive_size: 3,
            has_adjacency: true,
            input_string: "triangles_adjacency",
            output_string: "triangle_strip",
            num_primitives: |v| v / 6,
            num_vertices: |p| p * 6,
        },
        vk::PrimitiveTopology::TRIANGLE_STRIP_WITH_ADJACENCY => TopologyInfo {
            primitive_size: 3,
            has_adjacency: true,
            input_string: "triangles_adjacency",
            output_string: "triangle_strip",
            num_primitives: |v| (v - 4) / 2,
            num_vertices: |p| p * 2 + 4,
        },
        // A patch list never reaches a geometry shader, so its layout qualifiers are
        // upstream's "ERROR" placeholder.
        vk::PrimitiveTopology::PATCH_LIST => TopologyInfo {
            primitive_size: 3,
            has_adjacency: false,
            input_string: "ERROR",
            output_string: "ERROR",
            num_primitives: |v| v / 3,
            num_vertices: |p| p * 3,
        },
        other => panic!("unhandled topology {other:?}"),
    }
}

/// `PrimitivesGeneratedQueryTestCase`
struct PrimitivesGeneratedQueryTestCase {
    name: String,
    parameters: TestParameters,
}

/// The extension feature structs this test asks about. Queried here rather than through
/// `Context` because nothing else needs them yet.
struct PgqFeatures {
    primitives_generated_query: bool,
    with_rasterizer_discard: bool,
    with_non_zero_streams: bool,
    transform_feedback: bool,
    transform_feedback_queries: bool,
    max_transform_feedback_streams: u32,
    color_write_enable: bool,
}

fn query_pgq_features(context: &Context<'_>) -> PgqFeatures {
    use vulkanalia::vk::InstanceV1_1;

    let mut pgq = vk::PhysicalDevicePrimitivesGeneratedQueryFeaturesEXT::default();
    let mut xfb = vk::PhysicalDeviceTransformFeedbackFeaturesEXT::default();
    let mut cwe = vk::PhysicalDeviceColorWriteEnableFeaturesEXT::default();
    let mut features = vk::PhysicalDeviceFeatures2::builder().push_next(&mut pgq).push_next(&mut xfb).push_next(&mut cwe);
    unsafe { context.get_instance().get_physical_device_features2(context.get_physical_device(), &mut features) };

    let mut xfb_props = vk::PhysicalDeviceTransformFeedbackPropertiesEXT::default();
    let mut props = vk::PhysicalDeviceProperties2::builder().push_next(&mut xfb_props);
    unsafe { context.get_instance().get_physical_device_properties2(context.get_physical_device(), &mut props) };

    PgqFeatures {
        primitives_generated_query: pgq.primitives_generated_query == vk::TRUE,
        with_rasterizer_discard: pgq.primitives_generated_query_with_rasterizer_discard == vk::TRUE,
        with_non_zero_streams: pgq.primitives_generated_query_with_non_zero_streams == vk::TRUE,
        transform_feedback: xfb.transform_feedback == vk::TRUE,
        transform_feedback_queries: xfb_props.transform_feedback_queries == vk::TRUE,
        max_transform_feedback_streams: xfb_props.max_transform_feedback_streams,
        color_write_enable: cwe.color_write_enable == vk::TRUE,
    }
}

impl TestCase for PrimitivesGeneratedQueryTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `PrimitivesGeneratedQueryTestCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let p = &self.parameters;
        context.require_device_functionality("VK_EXT_primitives_generated_query")?;
        context.require_device_functionality("VK_EXT_transform_feedback")?;

        let f = query_pgq_features(context);

        if !f.primitives_generated_query {
            return Err(TestError::NotSupported("VK_QUERY_TYPE_PRIMITIVES_GENERATED_EXT not supported".into()));
        }

        if p.rast_discard() && !f.with_rasterizer_discard {
            return Err(TestError::NotSupported("primitivesGeneratedQueryWithRasterizerDiscard not supported".into()));
        }

        if p.query_reset_type == QueryResetType::Host {
            context.require_device_functionality("VK_EXT_host_query_reset")?;
        }

        if (p.shader_stage == ShaderStage::Geometry || topology_data(p.primitive_topology).has_adjacency) && context.get_device_features().geometry_shader != vk::TRUE {
            return Err(TestError::NotSupported("geometryShader not supported".into()));
        }

        if p.shader_stage == ShaderStage::TessellationEvaluation && context.get_device_features().tessellation_shader != vk::TRUE {
            return Err(TestError::NotSupported("tessellationShader not supported".into()));
        }

        if p.non_zero_streams() {
            let required_streams = p.pgq_stream_index().max(p.xfb_stream_index());

            if p.pgq_stream_index() > 0 && !f.with_non_zero_streams {
                return Err(TestError::NotSupported("primitivesGeneratedQueryWithNonZeroStreams not supported".into()));
            }

            if f.max_transform_feedback_streams <= required_streams {
                return Err(TestError::NotSupported("Required amount of XFB streams not supported".into()));
            }
        }

        if p.transform_feedback {
            if !f.transform_feedback {
                return Err(TestError::NotSupported("transformFeedback not supported".into()));
            }
            if !f.transform_feedback_queries {
                return Err(TestError::NotSupported("transformFeedbackQueries not supported".into()));
            }
        }

        if p.color_write_disable() {
            context.require_device_functionality("VK_EXT_color_write_enable")?;
            if !f.color_write_enable {
                return Err(TestError::NotSupported("colorWriteEnable not supported".into()));
            }
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        crate::generated::shaders::transform_feedback_pgq::PGQ_PROGRAMS.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(PrimitivesGeneratedQueryTestInstance {
            context,
            parameters: self.parameters,
        })
    }
}

/// `IMAGE_WIDTH` / `IMAGE_HEIGHT`
const IMAGE_WIDTH: u32 = 64;
const IMAGE_HEIGHT: u32 = IMAGE_WIDTH;

/// The draw is sized so the counters have a value worth checking, and transform
/// feedback is deliberately given room for three primitives fewer than are generated -
/// that difference is what distinguishes "written" from "generated".
const PRIMITIVES_GENERATED: u64 = 32;

/// `topologyData.at(VK_PRIMITIVE_TOPOLOGY_PATCH_LIST).primitiveSize`
const PATCH_LIST_PRIMITIVE_SIZE: u32 = 3;

/// `PrimitivesGeneratedQueryTestInstance`
struct PrimitivesGeneratedQueryTestInstance<'a> {
    context: &'a Context<'a>,
    parameters: TestParameters,
}

impl PrimitivesGeneratedQueryTestInstance<'_> {
    /// `selectDepthStencilFormat`
    fn select_depth_stencil_format(&self) -> vk::Format {
        use vulkanalia::vk::InstanceV1_0;
        for format in [vk::Format::D32_SFLOAT_S8_UINT, vk::Format::D24_UNORM_S8_UINT] {
            let props = unsafe {
                self.context
                    .get_instance()
                    .get_physical_device_format_properties(self.context.get_physical_device(), format)
            };
            if props.optimal_tiling_features.contains(vk::FormatFeatureFlags::DEPTH_STENCIL_ATTACHMENT) {
                return format;
            }
        }
        vk::Format::UNDEFINED
    }

    /// `fillVertexBuffer` - positions chosen so every primitive is distinct and on
    /// screen; the counters are what matters, not what is drawn.
    ///
    /// Indexed rather than iterated on purpose: several topologies write two or three
    /// non-consecutive slots per step, and upstream's index arithmetic is what makes
    /// them comparable.
    #[allow(clippy::needless_range_loop)]
    fn fill_vertex_buffer(&self, vertices: &mut [[f32; 2]], primitives_generated: u64) {
        let step = 1.0f32 / primitives_generated as f32;
        let x = |i: f32| -1.0 + 2.0 * i * step;
        let n = primitives_generated as usize;

        match self.parameters.primitive_topology {
            vk::PrimitiveTopology::POINT_LIST => {
                for prim in 0..n {
                    vertices[prim] = [x(prim as f32), 0.0];
                }
            }
            vk::PrimitiveTopology::LINE_LIST => {
                for prim in 0..n {
                    vertices[2 * prim] = [x(prim as f32), 1.0];
                    vertices[2 * prim + 1] = [x(prim as f32), -1.0];
                }
            }
            vk::PrimitiveTopology::LINE_STRIP => {
                vertices[0] = [-1.0, -1.0];
                vertices[1] = [-1.0, 1.0];
                for prim in 1..n {
                    vertices[1 + prim] = [x(prim as f32), if prim % 2 == 0 { 1.0 } else { -1.0 }];
                }
            }
            vk::PrimitiveTopology::TRIANGLE_STRIP => {
                vertices[0] = [-1.0, 1.0];
                vertices[1] = [-1.0, -1.0];
                vertices[2] = [x(1.0), 1.0];
                for prim in 1..n {
                    vertices[2 + prim] = [x(prim as f32), if prim % 2 == 0 { 1.0 } else { -1.0 }];
                }
            }
            vk::PrimitiveTopology::TRIANGLE_FAN => {
                vertices[0] = [0.0, -1.0];
                for prim in 0..(n + 1) {
                    vertices[1 + prim] = [x(prim as f32), x(prim as f32)];
                }
            }
            vk::PrimitiveTopology::LINE_LIST_WITH_ADJACENCY => {
                for prim in 0..n {
                    vertices[4 * prim] = [x(prim as f32), 1.0];
                    vertices[4 * prim + 1] = [x(prim as f32), 0.5];
                    vertices[4 * prim + 2] = [x(prim as f32), -0.5];
                    vertices[4 * prim + 3] = [x(prim as f32), -1.0];
                }
            }
            vk::PrimitiveTopology::LINE_STRIP_WITH_ADJACENCY => {
                vertices[0] = [-1.0, 0.0];
                vertices[1] = [-1.0, -1.0];
                vertices[2] = [-1.0, 1.0];
                for prim in 1..n {
                    vertices[2 + prim] = [x(prim as f32), if prim % 2 == 0 { 1.0 } else { -1.0 }];
                }
                vertices[2 + n] = [1.0, 0.0];
            }
            vk::PrimitiveTopology::TRIANGLE_LIST | vk::PrimitiveTopology::PATCH_LIST => {
                for prim in 0..n {
                    let (a, b) = (prim as f32, prim as f32 + 1.0);
                    if prim % 2 == 0 {
                        vertices[3 * prim] = [x(a), 1.0];
                        vertices[3 * prim + 1] = [x(a), -1.0];
                        vertices[3 * prim + 2] = [x(b), -1.0];
                    } else {
                        vertices[3 * prim] = [x(b), -1.0];
                        vertices[3 * prim + 1] = [x(b), 1.0];
                        vertices[3 * prim + 2] = [x(a), 1.0];
                    }
                }
            }
            vk::PrimitiveTopology::TRIANGLE_LIST_WITH_ADJACENCY => {
                for prim in 0..n {
                    let (a, b) = (prim as f32, prim as f32 + 1.0);
                    let v = if prim % 2 == 0 {
                        [[x(a), 1.0], [x(a), 1.0], [x(a), -1.0], [x(a), -1.0], [x(b), -1.0], [x(b), -1.0]]
                    } else {
                        [[x(b), -1.0], [x(b), -1.0], [x(b), 1.0], [x(b), 1.0], [x(a), 1.0], [x(a), 1.0]]
                    };
                    vertices[6 * prim..6 * prim + 6].copy_from_slice(&v);
                }
            }
            vk::PrimitiveTopology::TRIANGLE_STRIP_WITH_ADJACENCY => {
                vertices[0] = [-1.0, 1.0];
                vertices[1] = [-1.0, 1.0];
                vertices[2] = [-1.0, -1.0];
                vertices[3] = [-1.0, -1.0];
                vertices[4] = [x(1.0), 1.0];
                vertices[5] = [x(1.0), 1.0];
                for prim in 1..n {
                    let y = if prim % 2 == 0 { 1.0 } else { -1.0 };
                    vertices[5 + prim] = [x(prim as f32), y];
                    vertices[5 + prim + 1] = [x(prim as f32), y];
                }
            }
            other => panic!("Unrecognized primitive topology {other:?}"),
        }
    }

    /// The name of the shader this case needs for each stage, out of the one collection
    /// that holds them all.
    fn shader_names(&self) -> (String, Option<&'static str>, Option<String>, Option<&'static str>) {
        let p = &self.parameters;
        let vert_xfb = p.transform_feedback && p.shader_stage == ShaderStage::Vertex;
        let vert_ps = p.primitive_topology == vk::PrimitiveTopology::POINT_LIST && p.shader_stage == ShaderStage::Vertex;
        let vert = format!("vert{}{}", if vert_xfb { "_xfb" } else { "" }, if vert_ps { "_ps" } else { "" });

        let tese = (p.shader_stage == ShaderStage::TessellationEvaluation).then_some(if p.transform_feedback { "tese_xfb" } else { "tese" });

        let geom = (p.shader_stage == ShaderStage::Geometry).then(|| {
            format!(
                "geom_{}_pgq{}_xfb{}{}",
                topology_name(p.primitive_topology),
                p.pgq_stream_index(),
                p.xfb_stream_index(),
                if p.transform_feedback { "_xfb" } else { "" }
            )
        });

        let frag = (!p.rast_discard()).then_some(if p.rast_case == RasterizationCase::EmptyFrag { "frag_empty" } else { "frag" });

        (vert, tese, geom, frag)
    }
}

/// The manifest names topologies the way upstream's group names do.
fn topology_name(topology: vk::PrimitiveTopology) -> &'static str {
    match topology {
        vk::PrimitiveTopology::POINT_LIST => "point_list",
        vk::PrimitiveTopology::LINE_LIST => "line_list",
        vk::PrimitiveTopology::LINE_STRIP => "line_strip",
        vk::PrimitiveTopology::TRIANGLE_LIST => "triangle_list",
        vk::PrimitiveTopology::TRIANGLE_STRIP => "triangle_strip",
        vk::PrimitiveTopology::TRIANGLE_FAN => "triangle_fan",
        vk::PrimitiveTopology::LINE_LIST_WITH_ADJACENCY => "line_list_with_adjacency",
        vk::PrimitiveTopology::LINE_STRIP_WITH_ADJACENCY => "line_strip_with_adjacency",
        vk::PrimitiveTopology::TRIANGLE_LIST_WITH_ADJACENCY => "triangle_list_with_adjacency",
        vk::PrimitiveTopology::TRIANGLE_STRIP_WITH_ADJACENCY => "triangle_strip_with_adjacency",
        vk::PrimitiveTopology::PATCH_LIST => "patch_list",
        other => panic!("unhandled topology {other:?}"),
    }
}

/// `vk::makeRenderPass` with the colour and depth/stencil formats this test asks for,
/// either of which may be UNDEFINED. Nothing is ever read back from the attachments -
/// they exist so the pipeline has somewhere to render - so the load op is DONT_CARE.
fn make_pgq_render_pass(device: &Device, color_format: vk::Format, ds_format: vk::Format) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    use vulkanalia::vk::DeviceV1_0;

    let mut attachments = Vec::new();
    let mut color_refs = Vec::new();
    let mut ds_ref = None;

    if color_format != vk::Format::UNDEFINED {
        color_refs.push(vk::AttachmentReference {
            attachment: attachments.len() as u32,
            layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        });
        attachments.push(
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
        );
    }

    if ds_format != vk::Format::UNDEFINED {
        ds_ref = Some(vk::AttachmentReference {
            attachment: attachments.len() as u32,
            layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
        });
        attachments.push(
            vk::AttachmentDescription::builder()
                .format(ds_format)
                .samples(vk::SampleCountFlags::_1)
                .load_op(vk::AttachmentLoadOp::DONT_CARE)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::STORE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .final_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
                .build(),
        );
    }

    let mut subpass = vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .color_attachments(&color_refs);
    if let Some(r) = &ds_ref {
        subpass = subpass.depth_stencil_attachment(r);
    }
    let subpasses = [subpass.build()];

    let info = vk::RenderPassCreateInfo::builder().attachments(&attachments).subpasses(&subpasses);
    let handle = unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?;
    Ok(Unique::new(device, handle))
}

fn make_query_pool(device: &Device, query_type: vk::QueryType, query_count: u32) -> Result<Unique<'_, vk::QueryPool>, TestError> {
    use vulkanalia::vk::DeviceV1_0;
    let info = vk::QueryPoolCreateInfo::builder().query_type(query_type).query_count(query_count);
    let handle = unsafe { device.create_query_pool(&info, None) }.vk_check("vkCreateQueryPool")?;
    Ok(Unique::new(device, handle))
}

fn make_subresource_range(aspect: vk::ImageAspectFlags) -> vk::ImageSubresourceRange {
    vk::ImageSubresourceRange {
        aspect_mask: aspect,
        base_mip_level: 0,
        level_count: 1,
        base_array_layer: 0,
        layer_count: 1,
    }
}

impl PrimitivesGeneratedQueryTestInstance<'_> {
    /// `PrimitivesGeneratedQueryTestInstance::makeGraphicsPipeline`. Built here rather
    /// than through the shared helper: rasteriser discard, the colour-write state and
    /// the patch control points are all particular to this test.
    fn make_graphics_pipeline(&self, pipeline_layout: vk::PipelineLayout, render_pass: vk::RenderPass) -> Result<Unique<'_, vk::Pipeline>, TestError> {
        use vulkanalia::vk::DeviceV1_0;

        let p = self.parameters;
        let device = self.context.get_device();
        let programs = self.context.get_binary_collection();
        let (vert_name, tese_name, geom_name, frag_name) = self.shader_names();

        let vert = crate::vk::programs::create_shader_module(device, programs.get(&vert_name)?)?;
        let tesc = tese_name
            .map(|_| programs.get("tesc"))
            .transpose()?
            .map(|b| crate::vk::programs::create_shader_module(device, b))
            .transpose()?;
        let tese = tese_name
            .map(|n| programs.get(n))
            .transpose()?
            .map(|b| crate::vk::programs::create_shader_module(device, b))
            .transpose()?;
        let geom = geom_name
            .as_deref()
            .map(|n| programs.get(n))
            .transpose()?
            .map(|b| crate::vk::programs::create_shader_module(device, b))
            .transpose()?;
        let frag = frag_name
            .map(|n| programs.get(n))
            .transpose()?
            .map(|b| crate::vk::programs::create_shader_module(device, b))
            .transpose()?;

        let entry = c"main";
        let make_stage = |stage: vk::ShaderStageFlags, module: vk::ShaderModule| {
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(stage)
                .module(module)
                .name(entry.to_bytes_with_nul())
                .build()
        };
        let mut stages = vec![make_stage(vk::ShaderStageFlags::VERTEX, *vert)];
        if let Some(m) = &tesc {
            stages.push(make_stage(vk::ShaderStageFlags::TESSELLATION_CONTROL, **m));
        }
        if let Some(m) = &tese {
            stages.push(make_stage(vk::ShaderStageFlags::TESSELLATION_EVALUATION, **m));
        }
        if let Some(m) = &geom {
            stages.push(make_stage(vk::ShaderStageFlags::GEOMETRY, **m));
        }
        if let Some(m) = &frag {
            stages.push(make_stage(vk::ShaderStageFlags::FRAGMENT, **m));
        }

        let binding = vk::VertexInputBindingDescription {
            binding: 0,
            stride: std::mem::size_of::<[f32; 2]>() as u32,
            input_rate: vk::VertexInputRate::VERTEX,
        };
        let attribute = vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vk::Format::R32G32_SFLOAT,
            offset: 0,
        };
        let bindings = [binding];
        let attributes = [attribute];
        let vertex_input = vk::PipelineVertexInputStateCreateInfo::builder()
            .vertex_binding_descriptions(&bindings)
            .vertex_attribute_descriptions(&attributes);

        let input_assembly = vk::PipelineInputAssemblyStateCreateInfo::builder().topology(p.primitive_topology);
        let tessellation = vk::PipelineTessellationStateCreateInfo::builder().patch_control_points(PATCH_LIST_PRIMITIVE_SIZE);

        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: IMAGE_WIDTH as f32,
            height: IMAGE_HEIGHT as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        let scissors = [vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D {
                width: IMAGE_WIDTH,
                height: IMAGE_HEIGHT,
            },
        }];
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder().viewports(&viewports).scissors(&scissors);

        let rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
            .depth_clamp_enable(false)
            .rasterizer_discard_enable(p.rast_discard())
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(vk::CullModeFlags::NONE)
            .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
            .depth_bias_enable(false)
            .line_width(1.0);

        let multisample = vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);

        let stencil_op = vk::StencilOpState {
            fail_op: vk::StencilOp::KEEP,
            pass_op: vk::StencilOp::KEEP,
            depth_fail_op: vk::StencilOp::KEEP,
            compare_op: vk::CompareOp::ALWAYS,
            compare_mask: 0xFF,
            write_mask: 0xFF,
            reference: 0,
        };
        let depth_stencil = vk::PipelineDepthStencilStateCreateInfo::builder()
            .depth_test_enable(true)
            .depth_write_enable(true)
            .depth_compare_op(vk::CompareOp::LESS)
            .depth_bounds_test_enable(false)
            .stencil_test_enable(false)
            .front(stencil_op)
            .back(stencil_op)
            .min_depth_bounds(0.0)
            .max_depth_bounds(1.0);

        // One blend attachment per colour attachment the subpass actually has - the
        // attachmentless case has none, and a count that disagrees with the render pass
        // is invalid rather than merely unused.
        let attachment_count = usize::from(p.color_attachment());
        let color_write_enables = [vk::FALSE];
        let mut color_write = vk::PipelineColorWriteCreateInfoEXT::builder().color_write_enables(&color_write_enables[..attachment_count]);
        let blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
            .blend_enable(false)
            .src_color_blend_factor(vk::BlendFactor::ZERO)
            .dst_color_blend_factor(vk::BlendFactor::ZERO)
            .color_blend_op(vk::BlendOp::ADD)
            .src_alpha_blend_factor(vk::BlendFactor::ZERO)
            .dst_alpha_blend_factor(vk::BlendFactor::ZERO)
            .alpha_blend_op(vk::BlendOp::ADD)
            .color_write_mask(vk::ColorComponentFlags::all())
            .build()];
        let blend_attachments = &blend_attachments[..attachment_count];
        let color_blend = vk::PipelineColorBlendStateCreateInfo::builder()
            .logic_op_enable(false)
            .logic_op(vk::LogicOp::NO_OP)
            .attachments(blend_attachments)
            .push_next(&mut color_write);
        // The same without the colour-write chain, for every case that is not testing it.
        // Upstream leaves this null and lets the CTS pipeline helper fill in a default;
        // a null blend state with rasterization on and a colour attachment present is
        // not legal on its own.
        let default_color_blend = vk::PipelineColorBlendStateCreateInfo::builder()
            .logic_op_enable(false)
            .logic_op(vk::LogicOp::NO_OP)
            .attachments(blend_attachments);

        let dynamic_states = [vk::DynamicState::COLOR_WRITE_ENABLE_EXT];
        let dynamic_state = vk::PipelineDynamicStateCreateInfo::builder().dynamic_states(&dynamic_states);

        let mut info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(&stages)
            .vertex_input_state(&vertex_input)
            .input_assembly_state(&input_assembly)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterization)
            .multisample_state(&multisample)
            .layout(pipeline_layout)
            .render_pass(render_pass)
            .subpass(0);

        if p.shader_stage == ShaderStage::TessellationEvaluation {
            info = info.tessellation_state(&tessellation);
        }
        if p.depth_stencil_attachment {
            info = info.depth_stencil_state(&depth_stencil);
        }
        if p.static_color_write_disable() {
            info = info.color_blend_state(&color_blend);
        } else if !p.rast_discard() {
            info = info.color_blend_state(&default_color_blend);
        }
        if p.dynamic_color_write_disable() {
            info = info.dynamic_state(&dynamic_state);
        }

        let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::default(), &[info], None) }.vk_check("vkCreateGraphicsPipelines")?;
        Ok(Unique::new(device, pipelines.0[0]))
    }
}

/// `testGenerator`
pub fn create_tests() -> TestCaseGroup {
    let mut pgq_group = TestCaseGroup::new("primitives_generated_query");

    const READ_TYPES: [(QueryReadType, &str); 2] = [(QueryReadType::Get, "get"), (QueryReadType::Copy, "copy")];
    const RESET_TYPES: [(QueryResetType, &str); 2] = [(QueryResetType::Queue, "queue_reset"), (QueryResetType::Host, "host_reset")];
    const RESULT_TYPES: [(QueryResultType, &str); 4] = [
        (QueryResultType::Bits32, "32bit"),
        (QueryResultType::Bits64, "64bit"),
        (QueryResultType::Pgq32Xfb64, "pgq_32bit_xfb_64bit"),
        (QueryResultType::Pgq64Xfb32, "pgq_64bit_xfb_32bit"),
    ];
    const SHADER_STAGES: [(ShaderStage, &str); 3] = [
        (ShaderStage::Vertex, "vert"),
        (ShaderStage::TessellationEvaluation, "tese"),
        (ShaderStage::Geometry, "geom"),
    ];
    const XFB_STATES: [(bool, &str); 2] = [(false, "no_xfb"), (true, "xfb")];
    const RAST_CASES: [(RasterizationCase, bool, &str); 8] = [
        (RasterizationCase::Discard, false, "no_rast"),
        (RasterizationCase::Default, false, "rast"),
        (RasterizationCase::EmptyFrag, false, "empty_frag"),
        (RasterizationCase::NoAttachment, false, "no_attachment"),
        (RasterizationCase::ColorWriteDisableStatic, false, "color_write_disable_static"),
        (RasterizationCase::ColorWriteDisableStatic, true, "color_write_disable_static_ds"),
        (RasterizationCase::ColorWriteDisableDynamic, false, "color_write_disable_dynamic"),
        (RasterizationCase::ColorWriteDisableDynamic, true, "color_write_disable_dynamic_ds"),
    ];
    const TOPOLOGIES: [(vk::PrimitiveTopology, &str); 11] = [
        (vk::PrimitiveTopology::POINT_LIST, "point_list"),
        (vk::PrimitiveTopology::LINE_LIST, "line_list"),
        (vk::PrimitiveTopology::LINE_STRIP, "line_strip"),
        (vk::PrimitiveTopology::TRIANGLE_LIST, "triangle_list"),
        (vk::PrimitiveTopology::TRIANGLE_STRIP, "triangle_strip"),
        (vk::PrimitiveTopology::TRIANGLE_FAN, "triangle_fan"),
        (vk::PrimitiveTopology::LINE_LIST_WITH_ADJACENCY, "line_list_with_adjacency"),
        (vk::PrimitiveTopology::LINE_STRIP_WITH_ADJACENCY, "line_strip_with_adjacency"),
        (vk::PrimitiveTopology::TRIANGLE_LIST_WITH_ADJACENCY, "triangle_list_with_adjacency"),
        (vk::PrimitiveTopology::TRIANGLE_STRIP_WITH_ADJACENCY, "triangle_strip_with_adjacency"),
        (vk::PrimitiveTopology::PATCH_LIST, "patch_list"),
    ];
    const STREAM_INDICES: [(VertexStream, &str); 3] = [(VertexStream::Default, "default"), (VertexStream::Stream0, "0"), (VertexStream::Stream1, "1")];
    const CMD_BUF_CASES: [(CommandBufferCase, &str); 2] = [(CommandBufferCase::SingleDraw, "single_draw"), (CommandBufferCase::TwoDraws, "two_draws")];
    const QUERY_COUNT_CASES: [(u32, &str); 2] = [(1, ""), (2, "_2_queries")];
    const QUERY_ORDER_CASES: [(QueryOrder, &str); 2] = [(QueryOrder::PgqFirst, "pqg_first"), (QueryOrder::XfbqFirst, "xfbq_first")];
    const OUTSIDE_DRAW_CASES: [(OutsideDraw, &str); 3] = [(OutsideDraw::None, "none"), (OutsideDraw::Before, "before"), (OutsideDraw::After, "after")];

    // `rasterizationCasesWithAvailability` / `topologiesWithAvailability`
    let rast_has_availability = |c: RasterizationCase| matches!(c, RasterizationCase::Discard | RasterizationCase::Default | RasterizationCase::NoAttachment);
    let topology_has_availability = |t: vk::PrimitiveTopology| {
        matches!(
            t,
            vk::PrimitiveTopology::LINE_LIST | vk::PrimitiveTopology::TRIANGLE_LIST | vk::PrimitiveTopology::PATCH_LIST
        )
    };

    for (read_type, read_name) in READ_TYPES {
        let mut read_group = TestCaseGroup::new(read_name);

        for (reset_type, reset_name) in RESET_TYPES {
            let mut reset_group = TestCaseGroup::new(reset_name);

            for (result_type, result_name) in RESULT_TYPES {
                let mut result_group = TestCaseGroup::new(result_name);

                for (shader_stage, shader_name) in SHADER_STAGES {
                    let mut shader_group = TestCaseGroup::new(shader_name);

                    for (xfb_enable, xfb_name) in XFB_STATES {
                        let mut xfb_group = TestCaseGroup::new(xfb_name);

                        // Only test multiple result types with XFB enabled.
                        if matches!(result_type, QueryResultType::Pgq32Xfb64 | QueryResultType::Pgq64Xfb32) && !xfb_enable {
                            continue;
                        }

                        for (rast_case, ds_attachment, rast_name) in RAST_CASES {
                            let mut rast_group = TestCaseGroup::new(rast_name);

                            // Skip uninteresting cases. The ordering is upstream's enum
                            // order, where everything past Discard is a rasterisation
                            // variant only worth one read/reset/result combination.
                            if rast_case > RasterizationCase::Discard
                                && (read_type != QueryReadType::Get || reset_type != QueryResetType::Queue || result_type != QueryResultType::Bits32)
                            {
                                continue;
                            }

                            for (topology, topology_name) in TOPOLOGIES {
                                let mut topology_group = TestCaseGroup::new(topology_name);

                                // Only test patch lists with tessellation shaders.
                                let is_patch = topology == vk::PrimitiveTopology::PATCH_LIST;
                                let is_tese = shader_stage == ShaderStage::TessellationEvaluation;
                                if (is_patch && !is_tese) || (!is_patch && is_tese) {
                                    continue;
                                }

                                // Only test adjacency topologies with geometry shaders.
                                if shader_stage != ShaderStage::Geometry && topology_data(topology).has_adjacency {
                                    continue;
                                }

                                for (pgq_stream, pgq_stream_name) in STREAM_INDICES {
                                    for (xfb_stream, xfb_stream_name) in STREAM_INDICES {
                                        let stream_group_name = if xfb_enable {
                                            format!("pgq_{pgq_stream_name}_xfb_{xfb_stream_name}")
                                        } else {
                                            format!("pgq_{pgq_stream_name}")
                                        };
                                        let mut stream_group = TestCaseGroup::new(&stream_group_name);

                                        // Only test nondefault vertex streams with geometry shaders.
                                        if (pgq_stream != VertexStream::Default || xfb_stream != VertexStream::Default) && shader_stage != ShaderStage::Geometry {
                                            continue;
                                        }

                                        // Skip nondefault vertex streams for XFB when not enabled.
                                        if !xfb_enable && xfb_stream != VertexStream::Default {
                                            continue;
                                        }

                                        for (cmd_buf_case, cmd_buf_name) in CMD_BUF_CASES {
                                            let mut cmd_buf_group = TestCaseGroup::new(cmd_buf_name);

                                            for (query_order, query_order_name) in QUERY_ORDER_CASES {
                                                if query_order == QueryOrder::XfbqFirst && !xfb_enable {
                                                    continue;
                                                }
                                                let mut query_order_group = TestCaseGroup::new(query_order_name);

                                                for (outside_draw, outside_draw_name) in OUTSIDE_DRAW_CASES {
                                                    for (query_count, count_suffix) in QUERY_COUNT_CASES {
                                                        for availability_bit in [false, true] {
                                                            if availability_bit
                                                                && (!topology_has_availability(topology)
                                                                    || !rast_has_availability(rast_case)
                                                                    || cmd_buf_case != CommandBufferCase::SingleDraw)
                                                            {
                                                                continue;
                                                            }

                                                            let parameters = TestParameters {
                                                                query_read_type: read_type,
                                                                query_reset_type: reset_type,
                                                                query_result_type: result_type,
                                                                shader_stage,
                                                                transform_feedback: xfb_enable,
                                                                rast_case,
                                                                depth_stencil_attachment: ds_attachment,
                                                                primitive_topology: topology,
                                                                pgq_stream,
                                                                xfb_stream,
                                                                cmd_buf_case,
                                                                query_count,
                                                                query_order,
                                                                outside_draw,
                                                                availability_bit,
                                                            };

                                                            let availability_suffix = if availability_bit { "_with_availability" } else { "" };
                                                            let name = format!("{outside_draw_name}{count_suffix}{availability_suffix}");
                                                            query_order_group
                                                                .add_child(Box::new(PrimitivesGeneratedQueryTestCase { name, parameters }) as Box<dyn crate::vkt::TestCase>);
                                                        }
                                                    }
                                                }

                                                cmd_buf_group.add_child(query_order_group);
                                            }

                                            stream_group.add_child(cmd_buf_group);
                                        }

                                        topology_group.add_child(stream_group);
                                    }
                                }

                                rast_group.add_child(topology_group);
                            }

                            xfb_group.add_child(rast_group);
                        }

                        shader_group.add_child(xfb_group);
                    }

                    result_group.add_child(shader_group);
                }

                reset_group.add_child(result_group);
            }

            read_group.add_child(reset_group);
        }

        pgq_group.add_child(read_group);
    }

    pgq_group
}

impl TestInstance for PrimitivesGeneratedQueryTestInstance<'_> {
    /// `PrimitivesGeneratedQueryTestInstance::iterate`
    fn iterate(&mut self) -> crate::tcu::TestOutcome {
        use vulkanalia::vk::{DeviceV1_0, DeviceV1_2, ExtTransformFeedbackExtensionDeviceCommands};

        let p = self.parameters;
        let device = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let queue_family_index = self.context.get_universal_queue_family_index();
        let queue = self.context.get_universal_queue();

        let color_format = if p.color_attachment() { vk::Format::R8G8B8A8_UNORM } else { vk::Format::UNDEFINED };
        let ds_format = if p.depth_stencil_attachment {
            self.select_depth_stencil_format()
        } else {
            vk::Format::UNDEFINED
        };
        if p.depth_stencil_attachment && ds_format == vk::Format::UNDEFINED {
            return Ok(crate::tcu::TestStatus::fail(
                "VK_FORMAT_FEATURE_DEPTH_STENCIL_ATTACHMENT_BIT feature must be supported for at least one of VK_FORMAT_D32_SFLOAT_S8_UINT and VK_FORMAT_D24_UNORM_S8_UINT",
            ));
        }

        // One attachment per query, so two queries cannot share a framebuffer and hide
        // an ordering mistake.
        let mut color_images = Vec::new();
        let mut color_views = Vec::new();
        let mut ds_images = Vec::new();
        let mut ds_views = Vec::new();

        let make_attachment = |format: vk::Format, usage: vk::ImageUsageFlags| {
            vk::ImageCreateInfo::builder()
                .image_type(vk::ImageType::_2D)
                .format(format)
                .extent(vk::Extent3D {
                    width: IMAGE_WIDTH,
                    height: IMAGE_HEIGHT,
                    depth: 1,
                })
                .mip_levels(1)
                .array_layers(1)
                .samples(vk::SampleCountFlags::_1)
                .tiling(vk::ImageTiling::OPTIMAL)
                .usage(usage)
                .sharing_mode(vk::SharingMode::EXCLUSIVE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .build()
        };

        for _ in 0..p.query_count {
            if p.color_attachment() {
                let image = crate::vk::image_util::ImageWithMemory::new(
                    device,
                    allocator,
                    make_attachment(color_format, vk::ImageUsageFlags::COLOR_ATTACHMENT),
                    crate::vk::mem_util::MemoryRequirement::ANY,
                )?;
                let view = crate::vk::image_util::make_image_view(
                    device,
                    image.get(),
                    vk::ImageViewType::_2D,
                    color_format,
                    make_subresource_range(vk::ImageAspectFlags::COLOR),
                )?;
                color_images.push(image);
                color_views.push(view);
            }
            if p.depth_stencil_attachment {
                let image = crate::vk::image_util::ImageWithMemory::new(
                    device,
                    allocator,
                    make_attachment(ds_format, vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT),
                    crate::vk::mem_util::MemoryRequirement::ANY,
                )?;
                let view = crate::vk::image_util::make_image_view(
                    device,
                    image.get(),
                    vk::ImageViewType::_2D,
                    ds_format,
                    make_subresource_range(vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL),
                )?;
                ds_images.push(image);
                ds_views.push(view);
            }
        }

        let render_pass = make_pgq_render_pass(device, color_format, ds_format)?;
        let pipeline_layout = crate::vk::obj_util::make_pipeline_layout(device, &[])?;
        let pipeline = self.make_graphics_pipeline(*pipeline_layout, *render_pass)?;

        let mut framebuffers = Vec::new();
        for query_idx in 0..p.query_count as usize {
            let mut views = Vec::new();
            if p.color_attachment() {
                views.push(*color_views[query_idx]);
            }
            if p.depth_stencil_attachment {
                views.push(*ds_views[query_idx]);
            }
            framebuffers.push(crate::vk::obj_util::make_framebuffer(device, *render_pass, &views, IMAGE_WIDTH, IMAGE_HEIGHT, 1)?);
        }

        let topology = topology_data(p.primitive_topology);
        let vertex_count = (topology.num_vertices)(PRIMITIVES_GENERATED) as u32;
        let vtx_buffer_size = vertex_count as vk::DeviceSize * std::mem::size_of::<[f32; 2]>() as vk::DeviceSize;
        let vtx_buffer = crate::vk::obj_util::BufferWithMemory::new(
            device,
            allocator,
            crate::vk::obj_util::make_buffer_create_info(vtx_buffer_size, vk::BufferUsageFlags::VERTEX_BUFFER),
            crate::vk::mem_util::MemoryRequirement::HOST_VISIBLE,
        )?;
        {
            let ptr = vtx_buffer.get_allocation().get_host_ptr().cast::<[f32; 2]>();
            let vertices = unsafe { std::slice::from_raw_parts_mut(ptr, vertex_count as usize) };
            self.fill_vertex_buffer(vertices, PRIMITIVES_GENERATED);
        }
        crate::vk::mem_util::flush_alloc(device, vtx_buffer.get_allocation())?;

        let pgq64 = matches!(p.query_result_type, QueryResultType::Bits64 | QueryResultType::Pgq64Xfb32);
        let xfb64 = matches!(p.query_result_type, QueryResultType::Bits64 | QueryResultType::Pgq32Xfb64);
        let availability_flags = if p.availability_bit {
            vk::QueryResultFlags::WITH_AVAILABILITY
        } else {
            vk::QueryResultFlags::empty()
        };
        let pgq_values_per_query = if p.availability_bit { 2 } else { 1 };
        let xfb_values_per_query = if p.availability_bit { 3 } else { 2 };
        let pgq_result_size = (if pgq64 { 8 } else { 4 }) * pgq_values_per_query;
        let xfb_result_size = (if xfb64 { 8 } else { 4 }) * xfb_values_per_query;
        let pgq_result_buffer_size = pgq_result_size * p.query_count as usize;
        let xfb_result_buffer_size = xfb_result_size * p.query_count as usize;
        let pgq_result_flags = vk::QueryResultFlags::WAIT | if pgq64 { vk::QueryResultFlags::_64 } else { vk::QueryResultFlags::empty() } | availability_flags;
        let xfb_result_flags = vk::QueryResultFlags::WAIT | if xfb64 { vk::QueryResultFlags::_64 } else { vk::QueryResultFlags::empty() } | availability_flags;

        // 255 so a query the driver never wrote reads back as an obviously wrong value
        // rather than as zero.
        let mut pgq_results = vec![255u8; pgq_result_buffer_size];
        let mut xfb_results = vec![255u8; xfb_result_buffer_size];

        let pgq_pool = make_query_pool(device, vk::QueryType::PRIMITIVES_GENERATED_EXT, p.query_count)?;
        let xfb_pool = p
            .transform_feedback
            .then(|| make_query_pool(device, vk::QueryType::TRANSFORM_FEEDBACK_STREAM_EXT, p.query_count))
            .transpose()?;

        let mut pgq_results_buffer = None;
        let mut xfb_results_buffer = None;
        if p.query_read_type == QueryReadType::Copy {
            pgq_results_buffer = Some(crate::vk::obj_util::BufferWithMemory::new(
                device,
                allocator,
                crate::vk::obj_util::make_buffer_create_info(pgq_result_buffer_size as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_DST),
                crate::vk::mem_util::MemoryRequirement::HOST_VISIBLE,
            )?);
            if p.transform_feedback {
                xfb_results_buffer = Some(crate::vk::obj_util::BufferWithMemory::new(
                    device,
                    allocator,
                    crate::vk::obj_util::make_buffer_create_info(xfb_result_buffer_size as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_DST),
                    crate::vk::mem_util::MemoryRequirement::HOST_VISIBLE,
                )?);
            }
        }

        // Transform feedback is given room for three primitives fewer than the draw
        // generates, so "written" and "generated" cannot be confused for one another.
        let primitives_written = PRIMITIVES_GENERATED - 3;
        let primitive_size = if p.non_zero_streams() { 1 } else { topology.primitive_size as u64 };
        let bytes_per_vertex = 4 * std::mem::size_of::<f32>() as u64;
        let xfb_buffer_size = primitives_written * primitive_size * bytes_per_vertex;

        let mut xfb_buffers = Vec::new();
        if p.transform_feedback {
            for _ in 0..p.query_count {
                xfb_buffers.push(crate::vk::obj_util::BufferWithMemory::new(
                    device,
                    allocator,
                    crate::vk::obj_util::make_buffer_create_info(xfb_buffer_size, vk::BufferUsageFlags::TRANSFORM_FEEDBACK_BUFFER_EXT),
                    crate::vk::mem_util::MemoryRequirement::HOST_VISIBLE,
                )?);
            }
        }

        let command_pool = crate::vk::obj_util::make_command_pool(device, queue_family_index)?;
        let command_buffer = crate::vk::obj_util::allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
        let reset_command_buffer = crate::vk::obj_util::allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;

        // Each query must be reset before use. A queue reset goes in its own submission
        // that is waited on, because the get path does not wait on a fence before
        // reading and would otherwise race the reset.
        if p.query_reset_type == QueryResetType::Queue {
            crate::vk::cmd_util::begin_command_buffer(device, *reset_command_buffer)?;
            unsafe {
                device.cmd_reset_query_pool(*reset_command_buffer, *pgq_pool, 0, p.query_count);
                if let Some(pool) = &xfb_pool {
                    device.cmd_reset_query_pool(*reset_command_buffer, **pool, 0, p.query_count);
                }
            }
            crate::vk::cmd_util::end_command_buffer(device, *reset_command_buffer)?;
            crate::vk::cmd_util::submit_commands_and_wait(device, queue, *reset_command_buffer)?;
        }

        crate::vk::cmd_util::begin_command_buffer(device, *command_buffer)?;
        unsafe {
            device.cmd_bind_pipeline(*command_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_bind_vertex_buffers(*command_buffer, 0, &[vtx_buffer.get()], &[0]);

            for query_idx in 0..p.query_count {
                let render_area = vk::Rect2D {
                    offset: vk::Offset2D { x: 0, y: 0 },
                    extent: vk::Extent2D {
                        width: IMAGE_WIDTH,
                        height: IMAGE_HEIGHT,
                    },
                };
                let begin_info = vk::RenderPassBeginInfo::builder()
                    .render_pass(*render_pass)
                    .framebuffer(*framebuffers[query_idx as usize])
                    .render_area(render_area);
                device.cmd_begin_render_pass(*command_buffer, &begin_info, vk::SubpassContents::INLINE);

                let query_control_flags = vk::QueryControlFlags::empty();
                let draw = || device.cmd_draw(*command_buffer, vertex_count, 1, 0, 0);

                if p.dynamic_color_write_disable() {
                    use vulkanalia::vk::ExtColorWriteEnableExtensionDeviceCommands;
                    device.cmd_set_color_write_enable_ext(*command_buffer, &[vk::FALSE]);
                }

                if p.outside_draw == OutsideDraw::Before {
                    draw();
                }

                let begin_pgq = || {
                    if p.pgq_default() {
                        device.cmd_begin_query(*command_buffer, *pgq_pool, query_idx, query_control_flags);
                    } else {
                        device.cmd_begin_query_indexed_ext(*command_buffer, *pgq_pool, query_idx, query_control_flags, p.pgq_stream_index());
                    }
                };

                if p.query_order == QueryOrder::PgqFirst {
                    begin_pgq();
                }

                if p.transform_feedback {
                    let pool = xfb_pool.as_ref().expect("created when transform feedback is on");
                    device.cmd_bind_transform_feedback_buffers_ext(*command_buffer, 0, &[xfb_buffers[query_idx as usize].get()], &[0], &[xfb_buffer_size]);

                    if p.xfb_default() {
                        device.cmd_begin_query(*command_buffer, **pool, query_idx, query_control_flags);
                    } else {
                        device.cmd_begin_query_indexed_ext(*command_buffer, **pool, query_idx, query_control_flags, p.xfb_stream_index());
                    }

                    device.cmd_begin_transform_feedback_ext(*command_buffer, 0, &[], &[]);
                }

                if p.query_order != QueryOrder::PgqFirst {
                    begin_pgq();
                }

                draw();
                if p.cmd_buf_case == CommandBufferCase::TwoDraws {
                    draw();
                }

                if p.pgq_default() {
                    device.cmd_end_query(*command_buffer, *pgq_pool, query_idx);
                } else {
                    device.cmd_end_query_indexed_ext(*command_buffer, *pgq_pool, query_idx, p.pgq_stream_index());
                }

                if p.transform_feedback {
                    let pool = xfb_pool.as_ref().expect("created when transform feedback is on");
                    if p.xfb_default() {
                        device.cmd_end_query(*command_buffer, **pool, query_idx);
                    } else {
                        device.cmd_end_query_indexed_ext(*command_buffer, **pool, query_idx, p.xfb_stream_index());
                    }
                    device.cmd_end_transform_feedback_ext(*command_buffer, 0, &[], &[]);
                }

                if p.outside_draw == OutsideDraw::After {
                    draw();
                }

                device.cmd_end_render_pass(*command_buffer);
            }

            if p.query_read_type == QueryReadType::Copy {
                let pgq_buffer = pgq_results_buffer.as_ref().expect("created for the copy path");
                let barrier = |buffer: vk::Buffer| {
                    vk::BufferMemoryBarrier::builder()
                        .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
                        .dst_access_mask(vk::AccessFlags::HOST_READ)
                        .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                        .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                        .buffer(buffer)
                        .offset(0)
                        .size(vk::WHOLE_SIZE)
                        .build()
                };

                device.cmd_copy_query_pool_results(
                    *command_buffer,
                    *pgq_pool,
                    0,
                    p.query_count,
                    pgq_buffer.get(),
                    0,
                    pgq_result_size as vk::DeviceSize,
                    pgq_result_flags,
                );
                device.cmd_pipeline_barrier(
                    *command_buffer,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[barrier(pgq_buffer.get())],
                    &[] as &[vk::ImageMemoryBarrier],
                );

                if p.transform_feedback {
                    let xfb_buffer = xfb_results_buffer.as_ref().expect("created for the copy path");
                    let pool = xfb_pool.as_ref().expect("created when transform feedback is on");
                    device.cmd_copy_query_pool_results(
                        *command_buffer,
                        **pool,
                        0,
                        p.query_count,
                        xfb_buffer.get(),
                        0,
                        xfb_result_size as vk::DeviceSize,
                        xfb_result_flags,
                    );
                    device.cmd_pipeline_barrier(
                        *command_buffer,
                        vk::PipelineStageFlags::TRANSFER,
                        vk::PipelineStageFlags::HOST,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[barrier(xfb_buffer.get())],
                        &[] as &[vk::ImageMemoryBarrier],
                    );
                }
            }
        }
        crate::vk::cmd_util::end_command_buffer(device, *command_buffer)?;

        if p.query_reset_type == QueryResetType::Host {
            unsafe {
                device.reset_query_pool(*pgq_pool, 0, p.query_count);
                if let Some(pool) = &xfb_pool {
                    device.reset_query_pool(**pool, 0, p.query_count);
                }
            }
        }

        crate::vk::cmd_util::submit_commands_and_wait(device, queue, *command_buffer)?;

        match p.query_read_type {
            QueryReadType::Get => unsafe {
                device
                    .get_query_pool_results(*pgq_pool, 0, p.query_count, &mut pgq_results, pgq_result_size as vk::DeviceSize, pgq_result_flags)
                    .vk_check("vkGetQueryPoolResults")?;
                if let Some(pool) = &xfb_pool {
                    device
                        .get_query_pool_results(**pool, 0, p.query_count, &mut xfb_results, xfb_result_size as vk::DeviceSize, xfb_result_flags)
                        .vk_check("vkGetQueryPoolResults")?;
                }
            },
            QueryReadType::Copy => {
                let pgq_buffer = pgq_results_buffer.as_ref().expect("created for the copy path");
                crate::vk::mem_util::invalidate_alloc(device, pgq_buffer.get_allocation())?;
                unsafe {
                    std::ptr::copy_nonoverlapping(pgq_buffer.get_allocation().get_host_ptr().cast::<u8>(), pgq_results.as_mut_ptr(), pgq_results.len());
                }
                if p.transform_feedback {
                    let xfb_buffer = xfb_results_buffer.as_ref().expect("created for the copy path");
                    crate::vk::mem_util::invalidate_alloc(device, xfb_buffer.get_allocation())?;
                    unsafe {
                        std::ptr::copy_nonoverlapping(xfb_buffer.get_allocation().get_host_ptr().cast::<u8>(), xfb_results.as_mut_ptr(), xfb_results.len());
                    }
                }
            }
        }

        // Validate counters.
        let read = |bytes: &[u8], wide: bool, index: usize| -> u64 {
            if wide {
                u64::from_ne_bytes(bytes[index * 8..index * 8 + 8].try_into().expect("sized above"))
            } else {
                u32::from_ne_bytes(bytes[index * 4..index * 4 + 4].try_into().expect("sized above")) as u64
            }
        };

        let draw_count = if p.cmd_buf_case == CommandBufferCase::TwoDraws { 2 } else { 1 };

        for query_idx in 0..p.query_count as usize {
            let pgq = &pgq_results[query_idx * pgq_result_size..(query_idx + 1) * pgq_result_size];
            let pgq_generated = read(pgq, pgq64, 0);
            let pgq_availability = if p.availability_bit { read(pgq, pgq64, 1) } else { 1 };

            if pgq_generated != PRIMITIVES_GENERATED * draw_count {
                return Ok(crate::tcu::TestStatus::fail(format!(
                    "[Query {query_idx}] pgqGenerated == {pgq_generated}, expected {}",
                    PRIMITIVES_GENERATED * draw_count
                )));
            }

            if pgq_availability != 1 {
                return Ok(crate::tcu::TestStatus::fail(format!(
                    "[Query {query_idx}] pgqAvailability == {pgq_availability}, expected 1"
                )));
            }

            if p.transform_feedback {
                let xfb = &xfb_results[query_idx * xfb_result_size..(query_idx + 1) * xfb_result_size];
                let xfb_written = read(xfb, xfb64, 0);
                let xfb_generated = read(xfb, xfb64, 1);
                let xfb_availability = if p.availability_bit { read(xfb, xfb64, 2) } else { 1 };

                if xfb_generated != PRIMITIVES_GENERATED * draw_count {
                    return Ok(crate::tcu::TestStatus::fail(format!(
                        "[Query {query_idx}] xfbGenerated == {xfb_generated}, expected {}",
                        PRIMITIVES_GENERATED * draw_count
                    )));
                }

                if xfb_written != primitives_written {
                    return Ok(crate::tcu::TestStatus::fail(format!(
                        "[Query {query_idx}] xfbWritten == {xfb_written}, expected {primitives_written}"
                    )));
                }

                if xfb_availability != 1 {
                    return Ok(crate::tcu::TestStatus::fail(format!(
                        "[Query {query_idx}] xfbAvailability == {xfb_availability}, expected 1"
                    )));
                }
            }
        }

        Ok(crate::tcu::TestStatus::pass("Counters OK"))
    }
}
