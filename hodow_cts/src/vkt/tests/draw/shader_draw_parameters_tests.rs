// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/draw/vktDrawShaderDrawParametersTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Copyright (c) 2016 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::generated::shaders::draw_shader_draw_parameters::{
    SHADER_DRAW_PARAMETERS, SHADER_DRAW_PARAMETERS_BASE_INST, SHADER_DRAW_PARAMETERS_BASE_VERT,
    SHADER_DRAW_PARAMETERS_DRAW_INDEX,
};
use crate::tcu::pixel::TextureLevel;
use crate::tcu::{ChannelOrder, ChannelType, TestError, TestOutcome, TestStatus, TextureFormat};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc};
use crate::vk::obj_util::{BufferWithMemory, make_buffer_create_info};
use crate::vk::programs::BinaryCollection;
pub use crate::vk::programs::SharedProgram;
use crate::vkt::tests::draw::base_class::{DrawTestsBase, GroupParams, VertexElementData};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const TEST_FLAG_INSTANCED: u32 = 1 << 0;
const TEST_FLAG_INDEXED: u32 = 1 << 1;
const TEST_FLAG_INDIRECT: u32 = 1 << 2;
/// multiDrawIndirect
const TEST_FLAG_MULTIDRAW: u32 = 1 << 3;
/// drawIndirectFirstInstance
const TEST_FLAG_FIRST_INSTANCE: u32 = 1 << 4;
const TEST_FLAG_BASE_VERT_ONLY: u32 = 1 << 5;
const TEST_FLAG_BASE_INST_ONLY: u32 = 1 << 6;

// Data layout in buffers (junk data and good data is intertwined). Values are largely arbitrary, but we try to
// avoid "nice" numbers to make sure the test doesn't pass by accident.
/// number of consecutive good vertices
const NUM_VERTICES: u32 = 4;
/// index of first good vertex data
const NDX_FIRST_VERTEX: u32 = 2;
/// index of second good vertex data
const NDX_SECOND_VERTEX: u32 = 9;
/// index of a first good index (in index data)
const NDX_FIRST_INDEX: u32 = 11;
/// index of a second good index
const NDX_SECOND_INDEX: u32 = 17;
/// offset added to the first index
const OFFSET_FIRST_INDEX: u32 = 1;
/// offset added to the second index
const OFFSET_SECOND_INDEX: u32 = 4;
/// max number of draw instances
const MAX_INSTANCE_COUNT: u32 = 3;
/// max drawCount of indirect calls
const MAX_INDIRECT_DRAW_COUNT: u32 = 3;

#[derive(Clone, Copy, PartialEq, Eq)]
enum VertexShader {
    Base,
    BaseVertOnly,
    BaseInstOnly,
    DrawIndex,
}

#[derive(Clone, Copy)]
struct TestSpec {
    group_params: GroupParams,
    flags: u32,
    vertex_shader: VertexShader,
}

struct DrawCase {
    name: String,
    spec: TestSpec,
}

impl TestCase for DrawCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let spec = &self.spec;
        context.require_device_functionality("VK_KHR_shader_draw_parameters")?;

        // Shader draw parameters is part of Vulkan 1.1 but is optional
        if context.get_device_properties().api_version >= vk::make_version(1, 1, 0) {
            let mut features = vk::PhysicalDeviceVulkan11Features::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
            if features.shader_draw_parameters == vk::FALSE {
                return Err(TestError::NotSupported(
                    "shaderDrawParameters feature not supported by the device".to_string(),
                ));
            }
        }

        if spec.group_params.use_dynamic_rendering {
            context.require_device_functionality("VK_KHR_dynamic_rendering")?;
        }

        if spec.flags & TEST_FLAG_MULTIDRAW != 0 && context.get_device_features().multi_draw_indirect == vk::FALSE {
            return Err(TestError::NotSupported(
                "multiDrawIndirect feature not supported by the device".to_string(),
            ));
        }

        if spec.flags & TEST_FLAG_FIRST_INSTANCE != 0
            && context.get_device_features().draw_indirect_first_instance == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "drawIndirectFirstInstance feature not supported by the device".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match self.spec.vertex_shader {
            VertexShader::Base => SHADER_DRAW_PARAMETERS.programs,
            VertexShader::BaseVertOnly => SHADER_DRAW_PARAMETERS_BASE_VERT.programs,
            VertexShader::BaseInstOnly => SHADER_DRAW_PARAMETERS_BASE_INST.programs,
            VertexShader::DrawIndex => SHADER_DRAW_PARAMETERS_DRAW_INDEX.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DrawTest {
            context,
            spec: self.spec,
        })
    }
}

/// `DrawTest`
struct DrawTest<'a> {
    context: &'a Context<'a>,
    spec: TestSpec,
}

impl DrawTest<'_> {
    fn is_instanced(&self) -> bool {
        self.spec.flags & TEST_FLAG_INSTANCED != 0
    }
    fn is_indexed(&self) -> bool {
        self.spec.flags & TEST_FLAG_INDEXED != 0
    }
    fn is_indirect(&self) -> bool {
        self.spec.flags & TEST_FLAG_INDIRECT != 0
    }
    fn is_multi_draw(&self) -> bool {
        self.spec.flags & TEST_FLAG_MULTIDRAW != 0
    }
    fn is_first_instance(&self) -> bool {
        self.spec.flags & TEST_FLAG_FIRST_INSTANCE != 0
    }
    fn is_base_vert_only(&self) -> bool {
        self.spec.flags & TEST_FLAG_BASE_VERT_ONLY != 0
    }
    fn is_base_inst_only(&self) -> bool {
        self.spec.flags & TEST_FLAG_BASE_INST_ONLY != 0
    }

    /// The vertex data `DrawTest::DrawTest` builds.
    fn build_vertex_data(&self) -> Vec<VertexElementData> {
        let white = [1.0f32; 4];
        let mut data = Vec::new();
        let junk = |data: &mut Vec<VertexElementData>, x: f32, y: f32| {
            data.push(VertexElementData::new([x, y, 1.0, 1.0], white, -1i32 as u32))
        };

        let mut ref_index = (NDX_FIRST_VERTEX - OFFSET_FIRST_INDEX) as i32;
        junk(&mut data, 1.0, -1.0);
        junk(&mut data, -1.0, 1.0);

        if !self.is_indexed() || self.is_base_inst_only() {
            ref_index = 0;
        }

        for (x, y) in [(-0.3, -0.3), (-0.3, 0.3), (0.3, -0.3), (0.3, 0.3)] {
            data.push(VertexElementData::new([x, y, 1.0, 1.0], white, ref_index as u32));
            ref_index += 1;
        }

        junk(&mut data, -1.0, 1.0);
        junk(&mut data, 1.0, -1.0);
        junk(&mut data, -1.0, -1.0);

        if !self.is_indexed() || self.is_base_inst_only() {
            ref_index = 0;
        }

        for (x, y) in [(-0.3, -0.3), (-0.3, 0.3), (0.3, -0.3), (0.3, 0.3)] {
            data.push(VertexElementData::new([x, y, 1.0, 1.0], white, ref_index as u32));
            ref_index += 1;
        }

        junk(&mut data, -1.0, 1.0);
        junk(&mut data, 1.0, -1.0);

        // Make sure constants are up to date
        debug_assert!(data.len() as u32 == NDX_SECOND_VERTEX + NUM_VERTICES + 2);
        const { assert!(NDX_SECOND_VERTEX - NDX_FIRST_VERTEX - NUM_VERTICES == 3) };
        data
    }

    /// `DrawTest::drawReferenceImage`. This function must be kept in sync with the shader.
    fn draw_reference_image(&self, ref_image: &mut TextureLevel, render_width: u32, render_height: u32) {
        let per_instance_offset = [[0.0f32, 0.0], [-0.3, 0.0], [0.0, 0.3]];
        let per_draw_offset = [[0.0f32, 0.0], [-0.3, -0.3], [0.3, 0.3]];
        let all_colors = [[1.0f32; 4], [0.0, 0.0, 1.0, 1.0], [0.0, 1.0, 0.0, 1.0]];
        let num_instances = (if self.is_instanced() { MAX_INSTANCE_COUNT } else { 1 }) as usize;
        let num_indirect_draws = (if self.is_multi_draw() {
            MAX_INDIRECT_DRAW_COUNT
        } else {
            1
        }) as usize;
        let rect_width = (render_width as f32 * 0.6 / 2.0) as i32;
        let rect_height = (render_height as f32 * 0.6 / 2.0) as i32;

        let mut access = ref_image.get_access();
        for y in 0..render_height {
            for x in 0..render_width {
                access.set_pixel([0.0, 0.0, 0.0, 1.0], x, y, 0);
            }
        }

        for draw_ndx in 0..num_indirect_draws {
            for instance_ndx in 0..num_instances {
                let offset_x = per_instance_offset[instance_ndx][0] + per_draw_offset[draw_ndx][0];
                let offset_y = per_instance_offset[instance_ndx][1] + per_draw_offset[draw_ndx][1];
                let color = all_colors[if self.is_multi_draw() { draw_ndx } else { instance_ndx }];
                let x0 = (render_width as f32 * (1.0 - 0.3 + offset_x) / 2.0) as i32;
                let y0 = (render_height as f32 * (1.0 - 0.3 + offset_y) / 2.0) as i32;

                for y in y0..y0 + rect_height {
                    for x in x0..x0 + rect_width {
                        access.set_pixel(color, x as u32, y as u32, 0);
                    }
                }
            }
        }
    }

    /// `DrawTest::draw`, with the vertex buffer and pipeline already bound by `record_and_submit`.
    fn draw(
        &self,
        cmd_buffer: vk::CommandBuffer,
        indirect_buffer: Option<&BufferWithMemory<'_>>,
        index_buffer: Option<&BufferWithMemory<'_>>,
    ) -> Result<(), TestError> {
        let device = self.context.get_device();

        if self.is_indexed() {
            unsafe {
                device.cmd_bind_index_buffer(
                    cmd_buffer,
                    index_buffer.expect("index buffer").get(),
                    0,
                    vk::IndexType::UINT32,
                )
            };
        }

        let num_instances = if self.is_instanced() { MAX_INSTANCE_COUNT } else { 1 };
        let first_instances = |a: u32, b: u32, c: u32| if self.is_first_instance() { [a, b, c] } else { [0, 0, 0] };

        if self.is_indirect() {
            let indirect_buffer = indirect_buffer.expect("indirect buffer");

            if self.is_indexed() {
                let first_instance = first_instances(2, 1, 3);
                let commands = [
                    vk::DrawIndexedIndirectCommand {
                        index_count: NUM_VERTICES,
                        instance_count: num_instances,
                        first_index: NDX_FIRST_INDEX,
                        vertex_offset: OFFSET_FIRST_INDEX as i32,
                        first_instance: first_instance[0],
                    },
                    vk::DrawIndexedIndirectCommand {
                        index_count: NUM_VERTICES,
                        instance_count: num_instances,
                        first_index: NDX_SECOND_INDEX,
                        vertex_offset: OFFSET_SECOND_INDEX as i32,
                        first_instance: first_instance[1],
                    },
                    vk::DrawIndexedIndirectCommand {
                        index_count: NUM_VERTICES,
                        instance_count: num_instances,
                        first_index: NDX_FIRST_INDEX,
                        vertex_offset: OFFSET_FIRST_INDEX as i32,
                        first_instance: first_instance[2],
                    },
                ];
                self.set_indirect_command(indirect_buffer, &commands)?;
            } else {
                let first_instance = first_instances(2, 1, 3);
                let commands = [
                    vk::DrawIndirectCommand {
                        vertex_count: NUM_VERTICES,
                        instance_count: num_instances,
                        first_vertex: NDX_FIRST_VERTEX,
                        first_instance: first_instance[0],
                    },
                    vk::DrawIndirectCommand {
                        vertex_count: NUM_VERTICES,
                        instance_count: num_instances,
                        first_vertex: NDX_SECOND_VERTEX,
                        first_instance: first_instance[1],
                    },
                    vk::DrawIndirectCommand {
                        vertex_count: NUM_VERTICES,
                        instance_count: num_instances,
                        first_vertex: NDX_FIRST_VERTEX,
                        first_instance: first_instance[2],
                    },
                ];
                self.set_indirect_command(indirect_buffer, &commands)?;
            }

            let num_indirect_draws = if self.is_multi_draw() {
                MAX_INDIRECT_DRAW_COUNT
            } else {
                1
            };

            unsafe {
                if self.is_indexed() {
                    device.cmd_draw_indexed_indirect(
                        cmd_buffer,
                        indirect_buffer.get(),
                        0,
                        num_indirect_draws,
                        std::mem::size_of::<vk::DrawIndexedIndirectCommand>() as u32,
                    );
                } else {
                    device.cmd_draw_indirect(
                        cmd_buffer,
                        indirect_buffer.get(),
                        0,
                        num_indirect_draws,
                        std::mem::size_of::<vk::DrawIndirectCommand>() as u32,
                    );
                }
            }
        } else {
            let first_instance = if self.is_base_vert_only() { 0 } else { 2 };

            unsafe {
                if self.is_indexed() {
                    device.cmd_draw_indexed(
                        cmd_buffer,
                        NUM_VERTICES,
                        num_instances,
                        NDX_FIRST_INDEX,
                        OFFSET_FIRST_INDEX as i32,
                        first_instance,
                    );
                } else {
                    device.cmd_draw(
                        cmd_buffer,
                        NUM_VERTICES,
                        num_instances,
                        NDX_FIRST_VERTEX,
                        first_instance,
                    );
                }
            }
        }
        Ok(())
    }

    /// `DrawTest::setIndirectCommand`
    fn set_indirect_command<T: Copy>(
        &self,
        indirect_buffer: &BufferWithMemory<'_>,
        commands: &[T],
    ) -> Result<(), TestError> {
        debug_assert!(!commands.is_empty() && commands.len() as u32 <= MAX_INDIRECT_DRAW_COUNT);

        let data_size = std::mem::size_of_val(commands);
        unsafe {
            std::ptr::copy_nonoverlapping(
                commands.as_ptr().cast::<u8>(),
                indirect_buffer.get_allocation().get_host_ptr(),
                data_size,
            )
        };
        flush_alloc(self.context.get_device(), indirect_buffer.get_allocation())
    }
}

impl TestInstance for DrawTest<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();

        debug_assert!(!self.is_multi_draw() || self.is_indirect());
        debug_assert!(!self.is_first_instance() || (self.is_indirect() && self.is_instanced()));

        let base = DrawTestsBase::new_default(
            context,
            "vert",
            "frag",
            self.spec.group_params,
            vk::PrimitiveTopology::TRIANGLE_STRIP,
            self.build_vertex_data(),
        )?;

        let indirect_buffer = if self.is_indirect() {
            // space for COUNT commands plus some gratuitous padding
            let indirect_buffer_size = (MAX_INDIRECT_DRAW_COUNT * 32) as usize;
            let buffer = BufferWithMemory::new(
                device,
                context.get_default_allocator(),
                make_buffer_create_info(
                    indirect_buffer_size as vk::DeviceSize,
                    vk::BufferUsageFlags::INDIRECT_BUFFER,
                ),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            unsafe { std::ptr::write_bytes(buffer.get_allocation().get_host_ptr(), 0, indirect_buffer_size) };
            flush_alloc(device, buffer.get_allocation())?;
            Some(buffer)
        } else {
            None
        };

        let index_buffer = if self.is_indexed() {
            const { assert!(NDX_FIRST_INDEX + NUM_VERTICES <= NDX_SECOND_INDEX) };
            let mut indices = vec![0u32; (NDX_SECOND_INDEX + NUM_VERTICES) as usize];
            for i in 0..NUM_VERTICES {
                indices[(NDX_FIRST_INDEX + i) as usize] = NDX_FIRST_VERTEX + i - OFFSET_FIRST_INDEX;
                indices[(NDX_SECOND_INDEX + i) as usize] = NDX_SECOND_VERTEX + i - OFFSET_SECOND_INDEX;
            }

            let index_buffer_size = std::mem::size_of_val(indices.as_slice());
            let buffer = BufferWithMemory::new(
                device,
                context.get_default_allocator(),
                make_buffer_create_info(index_buffer_size as vk::DeviceSize, vk::BufferUsageFlags::INDEX_BUFFER),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            unsafe {
                std::ptr::copy_nonoverlapping(
                    indices.as_ptr().cast::<u8>(),
                    buffer.get_allocation().get_host_ptr(),
                    index_buffer_size,
                )
            };
            flush_alloc(device, buffer.get_allocation())?;
            Some(buffer)
        } else {
            None
        };

        // Draw and submit
        base.record_and_submit(queue, |cmd_buffer| {
            self.draw(cmd_buffer, indirect_buffer.as_ref(), index_buffer.as_ref())
        })?;

        // Validate
        let mut reference_frame = TextureLevel::new(
            TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8),
            base.render_width,
            base.render_height,
            1,
        )?;
        self.draw_reference_image(&mut reference_frame, base.render_width, base.render_height);

        if !base.target_matches(queue, &reference_frame)? {
            return Ok(TestStatus::fail("Rendered image is incorrect"));
        }
        Ok(TestStatus::pass("OK"))
    }
}

/// `addDrawCase`
fn add_draw_case(group: &mut TestCaseGroup, mut spec: TestSpec, flags: u32) {
    let mut name = String::from("draw");

    if flags & TEST_FLAG_INDEXED != 0 {
        name.push_str("_indexed");
    }
    if flags & TEST_FLAG_INDIRECT != 0 {
        name.push_str("_indirect");
    }
    if flags & TEST_FLAG_INSTANCED != 0 {
        name.push_str("_instanced");
    }
    if flags & TEST_FLAG_FIRST_INSTANCE != 0 {
        name.push_str("_first_instance");
    }

    spec.flags |= flags;

    group.add_child(Box::new(DrawCase { name, spec }) as Box<dyn TestCase>);
}

/// `ShaderDrawParametersTests::init`
pub fn create_shader_draw_parameters_tests(group_params: GroupParams) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("shader_draw_parameters");

    {
        let mut spec = TestSpec {
            group_params,
            flags: 0,
            vertex_shader: VertexShader::Base,
        };

        let construct_test_group = |name: &str, spec: TestSpec| {
            let mut group = TestCaseGroup::new(name);
            add_draw_case(&mut group, spec, 0);
            add_draw_case(&mut group, spec, TEST_FLAG_INDEXED);
            add_draw_case(&mut group, spec, TEST_FLAG_INDIRECT);
            add_draw_case(&mut group, spec, TEST_FLAG_INDEXED | TEST_FLAG_INDIRECT);
            group
        };

        group.add_child(construct_test_group("base_vertex", spec));

        // limit number of repeated tests just to primary command buffers
        if !group_params.use_secondary_cmd_buffer {
            spec.flags = TEST_FLAG_BASE_VERT_ONLY;
            spec.vertex_shader = VertexShader::BaseVertOnly;
            group.add_child(construct_test_group("base_vertex_only", spec));
        }
    }
    {
        let mut spec = TestSpec {
            group_params,
            flags: TEST_FLAG_INSTANCED,
            vertex_shader: VertexShader::Base,
        };

        let construct_test_group = |name: &str, spec: TestSpec| {
            let mut group = TestCaseGroup::new(name);
            add_draw_case(&mut group, spec, 0);
            add_draw_case(&mut group, spec, TEST_FLAG_INDEXED);
            add_draw_case(&mut group, spec, TEST_FLAG_INDIRECT);
            add_draw_case(&mut group, spec, TEST_FLAG_INDIRECT | TEST_FLAG_FIRST_INSTANCE);
            add_draw_case(&mut group, spec, TEST_FLAG_INDEXED | TEST_FLAG_INDIRECT);
            add_draw_case(
                &mut group,
                spec,
                TEST_FLAG_INDEXED | TEST_FLAG_INDIRECT | TEST_FLAG_FIRST_INSTANCE,
            );
            group
        };

        group.add_child(construct_test_group("base_instance", spec));

        // limit number of repeated tests just to primary command buffers
        if !group_params.use_secondary_cmd_buffer {
            spec.flags |= TEST_FLAG_BASE_INST_ONLY;
            spec.vertex_shader = VertexShader::BaseInstOnly;
            group.add_child(construct_test_group("base_instance_only", spec));
        }
    }
    {
        let spec = TestSpec {
            group_params,
            flags: TEST_FLAG_INDIRECT | TEST_FLAG_MULTIDRAW,
            vertex_shader: VertexShader::DrawIndex,
        };

        let mut draw_index_group = TestCaseGroup::new("draw_index");
        add_draw_case(&mut draw_index_group, spec, 0);
        add_draw_case(&mut draw_index_group, spec, TEST_FLAG_INSTANCED);
        add_draw_case(&mut draw_index_group, spec, TEST_FLAG_INDEXED);
        add_draw_case(&mut draw_index_group, spec, TEST_FLAG_INDEXED | TEST_FLAG_INSTANCED);
        group.add_child(draw_index_group);
    }
    group
}
