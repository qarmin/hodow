// SPDX-License-Identifier: Apache-2.0
//
// Ported from external/vulkancts/modules/vulkan/transform_feedback/
// vktPrimitivesGeneratedQueryTests.cpp

use vulkanalia::vk;

use crate::tcu::TestCaseGroup;

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

/// A case that only carries its parameters so far; the instance lands next.
struct PrimitivesGeneratedQueryTestCase {
    name: String,
    #[allow(dead_code)]
    parameters: TestParameters,
}

impl crate::vkt::TestCase for PrimitivesGeneratedQueryTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, _context: &crate::vkt::Context<'_>) -> Result<(), crate::vkt::TestError> {
        Err(crate::vkt::TestError::NotSupported("primitives_generated_query: instance not implemented yet".into()))
    }

    fn programs(&self) -> crate::vk::programs::BinaryCollection {
        crate::vk::programs::BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, _context: &'a crate::vkt::Context<'a>) -> Box<dyn crate::vkt::TestInstance + 'a> {
        unreachable!("check_support rejects every case until the instance lands")
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
