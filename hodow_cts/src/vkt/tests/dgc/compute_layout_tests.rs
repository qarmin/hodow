// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/device_generated_commands/vktDGCComputeLayoutTestsExt.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The pipeline, shader object and VK_EXT_descriptor_heap variants are ported (the heap
// ones create their pipelines and shaders directly, with the descriptor mapping of the output buffer, and use push data tokens). The programs are
// pre-expanded per test type in `shaders/manifest/dgc_compute_layout.toml` (`scripts/gen_dgc_compute_layout_manifest.py`). Each pipeline
// builds its own layout (identical to the others, so compatible).
//
// Note the smoke tests already cover the case of the layout containing dispatches only. In these tests we check other cases in ways that
// allow us to specialize each dispatch and write results to different areas. "complementary" tests use a push constant, either the first one
// or the last one, that's fixed for all dispatches and pushed outside the indirect commands, complementing the set of push constants from the
// indirect commands.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    ExtDescriptorHeapExtensionDeviceCommands, ExtDeviceGeneratedCommandsExtensionDeviceCommands,
    ExtShaderObjectExtensionDeviceCommands, InstanceV1_1,
};

use crate::generated::shaders::dgc_compute_layout::ALL_SHARED_PROGRAM;
use crate::tcu::random::Random;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::compute_pipeline::{ComputePipelineConstructionType, ComputePipelineWrapper};
use crate::vk::device_address_commands::buffer_device_address;
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_memory_barrier, make_pipeline_layout_with_push_constants,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::dgc::util_ext::{
    DgcBuffer, DgcComputeSupportType, DgcGenCmdsInfo, ExecutionSetManagerExt, IndirectCommandsLayoutBuilderExt,
    PreprocessBufferExt, check_dgc_ext_compute_support, device_generated_commands_properties,
};
use crate::vkt::tests::robustness::robustness_util::HostBuffer;
use crate::vkt::tests::shader_object::util::{ShaderObject, create_shader, shader_create_info};
use crate::vkt::{Context, TestCase, TestInstance};

#[derive(Clone, Copy, PartialEq, Eq)]
enum TestType {
    PushDispatch = 0,
    ComplementaryPushDispatch,
    ComplementaryPushIndexDispatch,
    MultiPushDispatch,
    /// Same as ExecutionSetDispatch but the execution set token uses a nonzero offset.
    OffsetExecutionSetDispatch,
    ExecutionSetDispatch,
    ExecutionSetPushDispatch,
    ExecutionSetIndexPushDispatch,
    ExecutionSetComplementaryPushDispatch,
}

impl TestType {
    fn has_execution_set(self) -> bool {
        matches!(
            self,
            TestType::OffsetExecutionSetDispatch
                | TestType::ExecutionSetDispatch
                | TestType::ExecutionSetPushDispatch
                | TestType::ExecutionSetIndexPushDispatch
                | TestType::ExecutionSetComplementaryPushDispatch
        )
    }

    fn has_sequence_index(self) -> bool {
        matches!(
            self,
            TestType::ComplementaryPushIndexDispatch | TestType::ExecutionSetIndexPushDispatch
        )
    }

    /// Has a fourth push constant that's pushed outside the indirect commands stream.
    fn has_complementary_push(self) -> bool {
        matches!(
            self,
            TestType::ComplementaryPushDispatch
                | TestType::ComplementaryPushIndexDispatch
                | TestType::ExecutionSetComplementaryPushDispatch
        )
    }

    fn name(self) -> &'static str {
        match self {
            TestType::PushDispatch => "push_dispatch",
            TestType::ComplementaryPushDispatch => "complementary_push_dispatch",
            TestType::ComplementaryPushIndexDispatch => "complementary_push_index_dispatch",
            TestType::MultiPushDispatch => "multi_push_dispatch",
            TestType::OffsetExecutionSetDispatch => "offset_execution_set_dispatch",
            TestType::ExecutionSetDispatch => "execution_set_dispatch",
            TestType::ExecutionSetPushDispatch => "execution_set_push_dispatch",
            TestType::ExecutionSetIndexPushDispatch => "execution_set_index_push_dispatch",
            TestType::ExecutionSetComplementaryPushDispatch => "execution_set_complementary_push_dispatch",
        }
    }
}

#[derive(Clone, Copy)]
struct TestParams {
    test_type: TestType,
    compute_queue: bool,
    /// Use dynamicGeneratedPipelineLayout.
    dynamic_pipeline_layout: bool,
    /// Shader objects instead of pipelines.
    shader_objects: bool,
    /// Destroy the set layout after using it in VkIndirectExecutionSetShaderLayoutInfoEXT.
    destroy_set_layout: bool,
    /// Use VK_EXT_descriptor_heap: a resource heap instead of a descriptor set, push data instead of push constants.
    descriptor_heap: bool,
}

/// The specialization data used in each dispatch. It may be used as specialization constants, as push constants or both.
#[derive(Clone, Copy)]
struct SpecializationData {
    /// Offset in the array for this dispatch.
    dispatch_offset: u32,
    /// This invocation will not perform the write.
    skip_index: u32,
    /// The local invocation index and workgroup index will be combined with this.
    value_offset: u32,
}

const LOCAL_INVOCATIONS: u32 = 64;
const SEQUENCE_COUNT: u32 = 4;
const CONSTANT_SIZE: u32 = std::mem::size_of::<u32>() as u32;

struct LayoutTestCase {
    name: String,
    params: TestParams,
}

impl TestCase for LayoutTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let require_binds = self.params.test_type.has_execution_set();
        let support_type = if !require_binds {
            DgcComputeSupportType::Basic
        } else if self.params.shader_objects {
            DgcComputeSupportType::BindShader
        } else {
            DgcComputeSupportType::BindPipeline
        };
        check_dgc_ext_compute_support(context, support_type)?;

        if self.params.shader_objects {
            context.require_device_functionality("VK_EXT_shader_object")?;
            if require_binds && device_generated_commands_properties(context).max_indirect_shader_object_count == 0 {
                return Err(TestError::NotSupported(
                    "maxIndirectShaderObjectCount is zero".to_string(),
                ));
            }
        }

        if self.params.compute_queue && context.get_compute_queue().is_none() {
            return Err(TestError::NotSupported("No compute queue available".to_string()));
        }

        if self.params.dynamic_pipeline_layout {
            let mut dgc_features = vk::PhysicalDeviceDeviceGeneratedCommandsFeaturesEXT::default();
            {
                let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut dgc_features);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_features2(context.get_physical_device(), &mut features2)
                };
            }
            if dgc_features.dynamic_generated_pipeline_layout == vk::FALSE {
                return Err(TestError::NotSupported(
                    "dynamicGeneratedPipelineLayout not supported".to_string(),
                ));
            }
        }

        if self.params.descriptor_heap {
            context.require_device_functionality("VK_EXT_descriptor_heap")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let key = format!("layout_{}", self.params.test_type.name());
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == key)
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(LayoutTestInstance {
            context,
            params: self.params,
        })
    }
}

struct LayoutTestInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

fn spec_data_bytes(data: &SpecializationData) -> Vec<u8> {
    [data.dispatch_offset, data.skip_index, data.value_offset]
        .iter()
        .flat_map(|value| value.to_ne_bytes())
        .collect()
}

/// `DGCComputeShaderExt`/`makeComputeShaderCreateInfo`: a compute shader object, optionally specialized.
pub(super) fn make_compute_shader<'a>(
    device: &'a Device,
    binary: &crate::vk::programs::ProgramBinary,
    indirect_bindable: bool,
    set_layouts: &[vk::DescriptorSetLayout],
    pc_ranges: &[vk::PushConstantRange],
    specialization: Option<(&[vk::SpecializationMapEntry], &[u8])>,
) -> Result<ShaderObject<'a>, TestError> {
    make_compute_shader_with_mapping(
        device,
        binary,
        indirect_bindable,
        set_layouts,
        pc_ranges,
        specialization,
        None,
    )
}

/// `make_compute_shader` with the descriptor heap mapping of the shader: the mapping info is chained and the descriptor heap flag set.
pub(super) fn make_compute_shader_with_mapping<'a>(
    device: &'a Device,
    binary: &crate::vk::programs::ProgramBinary,
    indirect_bindable: bool,
    set_layouts: &[vk::DescriptorSetLayout],
    pc_ranges: &[vk::PushConstantRange],
    specialization: Option<(&[vk::SpecializationMapEntry], &[u8])>,
    mapping_info: Option<&vk::ShaderDescriptorSetAndBindingMappingInfoEXT>,
) -> Result<ShaderObject<'a>, TestError> {
    let mut flags = if indirect_bindable {
        vk::ShaderCreateFlagsEXT::INDIRECT_BINDABLE
    } else {
        vk::ShaderCreateFlagsEXT::empty()
    };
    if mapping_info.is_some() {
        flags |= vk::ShaderCreateFlagsEXT::DESCRIPTOR_HEAP;
    }
    let mut create_info = shader_create_info(
        flags,
        vk::ShaderStageFlags::COMPUTE,
        vk::ShaderStageFlags::empty(),
        vk::ShaderCodeTypeEXT::SPIRV,
        std::mem::size_of_val(binary.spirv),
        binary.spirv.as_ptr().cast(),
        set_layouts,
        pc_ranges,
    );
    let spec_info = specialization.map(|(entries, data)| vk::SpecializationInfo {
        map_entry_count: entries.len() as u32,
        map_entries: entries.as_ptr(),
        data_size: data.len(),
        data: data.as_ptr().cast(),
    });
    if let Some(spec_info) = &spec_info {
        create_info.specialization_info = spec_info;
    }
    if let Some(mapping_info) = mapping_info {
        create_info.next = (mapping_info as *const vk::ShaderDescriptorSetAndBindingMappingInfoEXT).cast();
    }
    create_shader(device, &create_info)
}

/// `DGCComputePipelineExt` / the single pipeline of the heap variants: a compute pipeline without a layout, with the descriptor heap mapping
/// chained into the stage and the descriptor heap (and, when `indirect_bindable`, indirect bindable) flags.
fn make_heap_compute_pipeline<'a>(
    device: &'a Device,
    module: vk::ShaderModule,
    specialization: Option<(&[vk::SpecializationMapEntry], &[u8])>,
    indirect_bindable: bool,
    mapping_info: &vk::ShaderDescriptorSetAndBindingMappingInfoEXT,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let spec_info = specialization.map(|(entries, data)| vk::SpecializationInfo {
        map_entry_count: entries.len() as u32,
        map_entries: entries.as_ptr(),
        data_size: data.len(),
        data: data.as_ptr().cast(),
    });
    let mut stage = vk::PipelineShaderStageCreateInfo::builder()
        .stage(vk::ShaderStageFlags::COMPUTE)
        .module(module)
        .name(b"main\0")
        .build();
    stage.next = (mapping_info as *const vk::ShaderDescriptorSetAndBindingMappingInfoEXT).cast();
    if let Some(spec_info) = &spec_info {
        stage.specialization_info = spec_info;
    }
    let mut flags = vk::PipelineCreateFlags2::DESCRIPTOR_HEAP_EXT;
    if indirect_bindable {
        flags |= vk::PipelineCreateFlags2::INDIRECT_BINDABLE_EXT;
    }
    let flags2 = vk::PipelineCreateFlags2CreateInfo {
        flags,
        ..Default::default()
    };
    let mut info = vk::ComputePipelineCreateInfo::builder()
        .stage(stage)
        .layout(vk::PipelineLayout::null())
        .base_pipeline_index(-1)
        .build();
    info.next = (&flags2 as *const vk::PipelineCreateFlags2CreateInfo).cast();
    let pipelines = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[info], None) }
        .vk_check("vkCreateComputePipelines")?;
    Ok(Unique::new(device, pipelines.0[0]))
}

/// A push constant token, or a push data token with the descriptor heap.
fn add_pc_token(
    builder: &mut IndirectCommandsLayoutBuilderExt,
    descriptor_heap: bool,
    offset: u32,
    range: vk::PushConstantRange,
) {
    if descriptor_heap {
        builder.add_push_data_token(offset, range);
    } else {
        builder.add_push_constant_token(offset, range);
    }
}

/// A sequence index token, or its push data variant with the descriptor heap.
fn add_seq_token(
    builder: &mut IndirectCommandsLayoutBuilderExt,
    descriptor_heap: bool,
    offset: u32,
    range: vk::PushConstantRange,
) {
    if descriptor_heap {
        builder.add_push_data_sequence_index_token(offset, range);
    } else {
        builder.add_sequence_index_token(offset, range);
    }
}

impl<'a> LayoutTestInstance<'a> {
    /// `makeIndirectCommands`
    fn make_indirect_commands(&self, wg_counts: &[u32], specialization_data: &[SpecializationData]) -> Vec<u32> {
        let test_type = self.params.test_type;
        let mut indirect_cmds: Vec<u32> = Vec::new();

        // These will be interpreted as a VkDispatchIndirectCommand: .x=count .y=1 .z=1
        let push_dispatch_indirect_command =
            |indirect_cmds: &mut Vec<u32>, count: u32| indirect_cmds.extend([count, 1, 1]);

        match test_type {
            TestType::PushDispatch | TestType::ComplementaryPushDispatch | TestType::ComplementaryPushIndexDispatch => {
                let has_index = test_type == TestType::ComplementaryPushIndexDispatch;
                // 6-7 uint32_t in total per dispatch: 3 push constants, sequence index and the indirect dispatch dimensions.
                for (data, &wg_count) in specialization_data.iter().zip(wg_counts) {
                    indirect_cmds.extend([data.dispatch_offset, data.skip_index, data.value_offset]);
                    if has_index {
                        indirect_cmds.push(u32::MAX); // Sequence index placeholder.
                    }
                    push_dispatch_indirect_command(&mut indirect_cmds, wg_count);
                }
            }
            TestType::MultiPushDispatch => {
                // We have 3 push constants and we'll update them in two steps: 1,2 followed by 0.
                for (data, &wg_count) in specialization_data.iter().zip(wg_counts) {
                    indirect_cmds.extend([data.skip_index, data.value_offset, data.dispatch_offset]);
                    push_dispatch_indirect_command(&mut indirect_cmds, wg_count);
                }
            }
            TestType::ExecutionSetDispatch | TestType::OffsetExecutionSetDispatch => {
                // We have 4 uint32_t per dispatch: 1 for the pipeline index and 3 for the indirect dispatch command. However, there may be
                // one extra uint32_t when using an offset.
                let with_offset = test_type == TestType::OffsetExecutionSetDispatch;
                for (i, &wg_count) in wg_counts.iter().enumerate() {
                    if with_offset {
                        indirect_cmds.push(u32::MAX);
                    }
                    indirect_cmds.push(i as u32);
                    push_dispatch_indirect_command(&mut indirect_cmds, wg_count);
                }
            }
            TestType::ExecutionSetPushDispatch
            | TestType::ExecutionSetIndexPushDispatch
            | TestType::ExecutionSetComplementaryPushDispatch => {
                let has_index = test_type == TestType::ExecutionSetIndexPushDispatch;
                // We have 6-7 uint32_t per dispatch: 1 for the pipeline index, 2 for the push constants, 1 for sequence index and 3 for the
                // indirect dispatch command.
                for (i, (data, &wg_count)) in specialization_data.iter().zip(wg_counts).enumerate() {
                    indirect_cmds.push(i as u32); // Pipeline index.
                    if has_index {
                        indirect_cmds.push(u32::MAX); // Sequence index placeholder.
                    }
                    indirect_cmds.push(data.dispatch_offset);
                    indirect_cmds.push(data.skip_index);
                    // value_offset provided as a specialization constant in the shader.
                    push_dispatch_indirect_command(&mut indirect_cmds, wg_count);
                }
            }
        }
        indirect_cmds
    }
}

impl TestInstance for LayoutTestInstance<'_> {
    /// `LayoutTestInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let test_type = params.test_type;
        let device = context.get_device();
        let shader_stage = vk::ShaderStageFlags::COMPUTE;
        let bind_point = vk::PipelineBindPoint::COMPUTE;
        let (queue, qf_index) = if params.compute_queue {
            context
                .get_compute_queue()
                .ok_or_else(|| TestError::NotSupported("No compute queue available".to_string()))?
        } else {
            (
                context.get_universal_queue(),
                context.get_universal_queue_family_index(),
            )
        };
        let extra_push = test_type.has_complementary_push();
        let has_seq_index = test_type.has_sequence_index();
        let sequence_index = has_seq_index;
        let value_offset2 = if extra_push { LOCAL_INVOCATIONS } else { 0 };

        // Generate the work group count for each dispatch.
        let min_dispatch_size = 1;
        let max_dispatch_size = 16;

        let seed = 0xff0000u32 | test_type as u32;
        let mut rnd = Random::new(seed);

        // Work group count for each dispatch.
        let wg_counts: Vec<u32> = (0..SEQUENCE_COUNT)
            .map(|_| rnd.get_int(min_dispatch_size, max_dispatch_size) as u32)
            .collect();

        // Specialization data for each dispatch.
        let mut specialization_data = Vec::with_capacity(wg_counts.len());
        {
            let mut prev_wgs = 0u32;
            for (i, &wg_count) in wg_counts.iter().enumerate() {
                specialization_data.push(SpecializationData {
                    dispatch_offset: prev_wgs * LOCAL_INVOCATIONS,
                    skip_index: rnd.get_int(0, LOCAL_INVOCATIONS as i32 - 1) as u32,
                    value_offset: (i as u32 + 1) << 20,
                });
                prev_wgs += wg_count;
            }
        }

        // Calculate the required size of the output buffer.
        let total_num_work_groups: u32 = wg_counts.iter().sum();
        let total_invocations = LOCAL_INVOCATIONS * total_num_work_groups;
        let output_buffer_size = vk::DeviceSize::from(total_invocations) * std::mem::size_of::<u32>() as vk::DeviceSize;

        // Create a host-visible output buffer.
        let descriptor_heap = params.descriptor_heap;
        let output_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(
                output_buffer_size,
                if descriptor_heap {
                    vk::BufferUsageFlags::STORAGE_BUFFER | vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS
                } else {
                    vk::BufferUsageFlags::STORAGE_BUFFER
                },
            ),
            if descriptor_heap {
                MemoryRequirement::HOST_VISIBLE | MemoryRequirement::DEVICE_ADDRESS
            } else {
                MemoryRequirement::HOST_VISIBLE
            },
        )?;
        let output_buffer_alloc = output_buffer.get_allocation();
        unsafe { std::ptr::write_bytes(output_buffer_alloc.get_host_ptr(), 0, output_buffer_size as usize) };
        flush_alloc(device, output_buffer_alloc)?;

        // Create the descriptor set layout, descriptor set and update it, or the resource heap holding the descriptor.
        let output_buffer_type = vk::DescriptorType::STORAGE_BUFFER;
        let mut set_layout: Option<Unique<'_, vk::DescriptorSetLayout>> = None;
        let mut descriptor_pool = None;
        let mut descriptor_set = None;
        let mut resource_heap: Option<HostBuffer<'_>> = None;
        let mut bind_heap_info = vk::BindHeapInfoEXT::default();
        if descriptor_heap {
            let mut heap_props = vk::PhysicalDeviceDescriptorHeapPropertiesEXT::default();
            {
                let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut heap_props);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
                };
            }

            // `CreateResourceHeap`: the user part holds one buffer descriptor, then comes the reserved range.
            let user_heap_size = heap_props
                .buffer_descriptor_size
                .div_ceil(heap_props.resource_heap_alignment.max(1))
                * heap_props.resource_heap_alignment.max(1);
            let resource_heap_size = user_heap_size + heap_props.min_resource_heap_reserved_range;
            let heap = HostBuffer::new_resource_heap(device, context, resource_heap_size)?;
            bind_heap_info = vk::BindHeapInfoEXT {
                heap_range: vk::DeviceAddressRangeEXT {
                    address: heap.device_address(device),
                    size: resource_heap_size,
                },
                reserved_range_offset: user_heap_size,
                reserved_range_size: heap_props.min_resource_heap_reserved_range,
                ..Default::default()
            };

            let address_range = vk::DeviceAddressRangeEXT {
                address: buffer_device_address(device, output_buffer.get()),
                size: output_buffer_size,
            };
            let descriptor_host_range = vk::HostAddressRangeEXT {
                address: heap.buffer.get_allocation().get_host_ptr().cast(),
                size: heap_props.buffer_descriptor_size as usize,
            };
            let resource_descriptor_info = vk::ResourceDescriptorInfoEXT {
                type_: vk::DescriptorType::STORAGE_BUFFER,
                data: vk::ResourceDescriptorDataEXT {
                    address_range: &address_range,
                },
                ..Default::default()
            };
            unsafe { device.write_resource_descriptors_ext(&[resource_descriptor_info], &[descriptor_host_range]) }
                .vk_check("vkWriteResourceDescriptorsEXT")?;
            heap.flush(device)?;
            resource_heap = Some(heap);
        } else {
            let layout = DescriptorSetLayoutBuilder::new()
                .add_single_binding(output_buffer_type, shader_stage)
                .build(device)?;
            let pool = DescriptorPoolBuilder::new().add_type(output_buffer_type, 1).build(
                device,
                vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
                1,
            )?;
            let set = make_descriptor_set(device, *pool, *layout)?;
            let output_buffer_desc_info = make_descriptor_buffer_info(output_buffer.get(), 0, output_buffer_size);
            DescriptorSetUpdateBuilder::new()
                .write_single(
                    set.get(),
                    Location::binding(0),
                    output_buffer_type,
                    &output_buffer_desc_info,
                )
                .update(device);
            set_layout = Some(layout);
            descriptor_pool = Some(pool);
            descriptor_set = Some(set);
        }
        let _ = (&descriptor_pool, &resource_heap);
        // A null set layout stands in for the missing one of the heap variants, as the upstream code passes `*m_setLayout` as is.
        let set_layout_handle = set_layout
            .as_ref()
            .map_or(vk::DescriptorSetLayout::null(), |layout| **layout);

        // The descriptor heap mapping of binding 0 of set 0 (the output buffer): the first descriptor of the heap.
        let heap_mapping = vk::DescriptorSetAndBindingMappingEXT {
            descriptor_set: 0,
            first_binding: 0,
            binding_count: 1,
            resource_mask: vk::SpirvResourceTypeFlagsEXT::ALL,
            source: vk::DescriptorMappingSourceEXT::HEAP_WITH_CONSTANT_OFFSET,
            source_data: vk::DescriptorMappingSourceDataEXT {
                constant_offset: vk::DescriptorMappingSourceConstantOffsetEXT {
                    heap_offset: 0,
                    ..Default::default()
                },
            },
            ..Default::default()
        };
        let heap_mapping_info = vk::ShaderDescriptorSetAndBindingMappingInfoEXT {
            mapping_count: 1,
            mappings: &heap_mapping,
            ..Default::default()
        };
        let mapping_info = descriptor_heap.then_some(&heap_mapping_info);

        // Create the pipelines (`createPipelinesOrShaders`).
        let uses_execution_set = test_type.has_execution_set();
        let mut pc_token_data_size = 0u32;
        let mut pc_ranges: Vec<vk::PushConstantRange> = Vec::new();
        let mut dgc_pipelines: Vec<ComputePipelineWrapper<'_>> = Vec::new();
        let mut single_pipeline: Option<ComputePipelineWrapper<'_>> = None;
        let shader_objects = params.shader_objects;
        let mut dgc_shaders: Vec<ShaderObject<'_>> = Vec::new();
        let mut single_shader: Option<ShaderObject<'_>> = None;
        let mut shader_pipeline_layout = None;
        let binary_comp = context.get_binary_collection().get("comp")?;
        let mut heap_pipelines: Vec<Unique<'_, vk::Pipeline>> = Vec::new();
        let mut single_heap_pipeline: Option<Unique<'_, vk::Pipeline>> = None;
        let heap_module = if descriptor_heap && !shader_objects {
            Some(create_shader_module(
                device,
                context.get_binary_collection().get("comp")?,
            )?)
        } else {
            None
        };

        if uses_execution_set {
            // The sequence includes a set-pipeline token, so we'll populate dgc_pipelines with one different pipeline per dispatch.

            // Specialization constant ids used by the shader.
            let constant_ids: Vec<u32> = if matches!(
                test_type,
                TestType::ExecutionSetDispatch | TestType::OffsetExecutionSetDispatch
            ) {
                // 3 constants with ids 0, 1, 2; see shader code.
                vec![0, 1, 2]
            } else {
                // Single constant with id 2; see shader code.
                vec![2]
            };

            // Specialization map entries, depending on constant_ids. Note for the case of a single constant with id 2 (when the first 2
            // constants are passed as push constants), we don't use offset 0 in the map entry. This is because the specialization info
            // always uses the base address of the SpecializationData structure as the base address for the spec constant data, so the
            // offset we pass here will match the position of the spec constant data in the structure.
            let map_entries: Vec<vk::SpecializationMapEntry> = constant_ids
                .iter()
                .map(|&constant_id| vk::SpecializationMapEntry {
                    constant_id,
                    offset: CONSTANT_SIZE * constant_id,
                    size: CONSTANT_SIZE as usize,
                })
                .collect();

            // Prepare the right layout.
            if !matches!(
                test_type,
                TestType::ExecutionSetDispatch | TestType::OffsetExecutionSetDispatch
            ) {
                // See shader: mix of push constants and spec constants. 2 push constants (+1 for complementary push, +1 for sequence
                // index) and 1 spec constant.
                let pc_items = 2u32;
                pc_token_data_size = pc_items * CONSTANT_SIZE;
                let mut layout_pc_size = pc_token_data_size;
                if sequence_index {
                    layout_pc_size += CONSTANT_SIZE;
                }
                if extra_push {
                    layout_pc_size += CONSTANT_SIZE;
                }
                pc_ranges.push(vk::PushConstantRange {
                    stage_flags: shader_stage,
                    offset: 0,
                    size: layout_pc_size,
                });
            }

            if shader_objects && !descriptor_heap {
                shader_pipeline_layout = Some(make_pipeline_layout_with_push_constants(
                    device,
                    &[set_layout_handle],
                    &pc_ranges,
                )?);
            }

            for data in &specialization_data {
                if shader_objects {
                    let data_bytes = spec_data_bytes(data);
                    dgc_shaders.push(make_compute_shader_with_mapping(
                        device,
                        &binary_comp,
                        true,
                        &[set_layout_handle],
                        &pc_ranges,
                        Some((&map_entries[..], &data_bytes[..])),
                        mapping_info,
                    )?);
                    continue;
                }
                if let Some(module) = &heap_module {
                    let data_bytes = spec_data_bytes(data);
                    heap_pipelines.push(make_heap_compute_pipeline(
                        device,
                        **module,
                        Some((&map_entries[..], &data_bytes[..])),
                        true,
                        &heap_mapping_info,
                    )?);
                    continue;
                }
                let mut pipeline = ComputePipelineWrapper::new(
                    device,
                    ComputePipelineConstructionType::Pipeline,
                    context.get_binary_collection().get("comp")?,
                );
                pipeline.set_descriptor_set_layout(set_layout_handle);
                for range in &pc_ranges {
                    pipeline.add_push_constant_range(*range);
                }
                pipeline.set_specialization_info(map_entries.clone(), spec_data_bytes(data));
                pipeline.set_pipeline_create_flags2(vk::PipelineCreateFlags2::INDIRECT_BINDABLE_EXT);
                pipeline.build_pipeline()?;
                dgc_pipelines.push(pipeline);
            }
        } else {
            // Create single_pipeline. This case uses push constants only.
            pc_token_data_size = std::mem::size_of::<SpecializationData>() as u32;
            let mut layout_pc_size = pc_token_data_size;
            if extra_push {
                let extra_constants = if sequence_index { 2 } else { 1 };
                layout_pc_size += CONSTANT_SIZE * extra_constants; // Partially outside the cmd stream.
            }
            let pc_range = vk::PushConstantRange {
                stage_flags: shader_stage,
                offset: 0,
                size: layout_pc_size,
            };
            pc_ranges.push(pc_range);

            if shader_objects && descriptor_heap {
                single_shader = Some(make_compute_shader_with_mapping(
                    device,
                    &binary_comp,
                    false,
                    &[],
                    &[],
                    None,
                    mapping_info,
                )?);
            } else if shader_objects {
                shader_pipeline_layout = Some(make_pipeline_layout_with_push_constants(
                    device,
                    &[set_layout_handle],
                    &[pc_range],
                )?);
                single_shader = Some(make_compute_shader(
                    device,
                    &binary_comp,
                    false,
                    &[set_layout_handle],
                    &[pc_range],
                    None,
                )?);
            } else if let Some(module) = &heap_module {
                single_heap_pipeline = Some(make_heap_compute_pipeline(
                    device,
                    **module,
                    None,
                    false,
                    &heap_mapping_info,
                )?);
            } else {
                let mut pipeline = ComputePipelineWrapper::new(
                    device,
                    ComputePipelineConstructionType::Pipeline,
                    context.get_binary_collection().get("comp")?,
                );
                pipeline.set_descriptor_set_layout(set_layout_handle);
                pipeline.add_push_constant_range(pc_range);
                pipeline.build_pipeline()?;
                single_pipeline = Some(pipeline);
            }
        }
        let first_pipeline = single_pipeline.as_ref().or_else(|| dgc_pipelines.first());
        let first_shader = single_shader.as_ref().or_else(|| dgc_shaders.first());
        let pipeline_layout = if descriptor_heap {
            vk::PipelineLayout::null()
        } else {
            match (&shader_pipeline_layout, first_pipeline) {
                (Some(layout), _) => **layout,
                (None, Some(pipeline)) => pipeline.get_pipeline_layout(),
                (None, None) => return Err(TestError::InternalError("no pipeline was built".to_string())),
            }
        };
        let single_pipeline_handle = if descriptor_heap {
            single_heap_pipeline
                .as_ref()
                .map_or(vk::Pipeline::null(), |pipeline| **pipeline)
        } else {
            single_pipeline
                .as_ref()
                .map_or(vk::Pipeline::null(), ComputePipelineWrapper::get_pipeline)
        };
        let dgc_pipeline_handles: Vec<vk::Pipeline> = if descriptor_heap {
            heap_pipelines.iter().map(|pipeline| **pipeline).collect()
        } else {
            dgc_pipelines.iter().map(ComputePipelineWrapper::get_pipeline).collect()
        };
        let first_pipeline_handle = if single_pipeline_handle != vk::Pipeline::null() {
            single_pipeline_handle
        } else {
            dgc_pipeline_handles.first().copied().unwrap_or_else(vk::Pipeline::null)
        };

        // Create the indirect execution set. To make things a bit more interesting, we're going to defer updating the execution set until
        // we've allocated the preprocess buffer. This means the memory requirements will have to be calculated without knowing the
        // specific pipelines.
        let mut execution_set = if uses_execution_set && shader_objects {
            let mut manager = {
                // If needed, destroy the set layout immediately after the execution set creation.
                let set_layout_copy = if params.destroy_set_layout {
                    let mut builder = DescriptorSetLayoutBuilder::new();
                    if !descriptor_heap {
                        builder = builder.add_single_binding(output_buffer_type, shader_stage);
                    }
                    Some(builder.build(device)?)
                } else {
                    None
                };
                let ies_set_layout = set_layout_copy.as_ref().map_or(set_layout_handle, |copy| **copy);
                let first = first_shader
                    .ok_or_else(|| TestError::InternalError("no shader was built".to_string()))?
                    .get();
                // Initialize with the first one, then overwrite.
                ExecutionSetManagerExt::new_shader(
                    device,
                    &[(first, vec![ies_set_layout])],
                    &pc_ranges,
                    dgc_shaders.len() as u32,
                )?
            };
            for (i, shader) in dgc_shaders.iter().enumerate() {
                manager.add_shader(i as u32, shader.get());
            }
            Some(manager)
        } else if uses_execution_set {
            // Initialize with the first one, then overwrite.
            let mut manager = ExecutionSetManagerExt::new_pipeline(
                device,
                dgc_pipeline_handles[0],
                dgc_pipeline_handles.len() as u32,
            )?;
            for (i, &pipeline) in dgc_pipeline_handles.iter().enumerate() {
                manager.add_pipeline(i as u32, pipeline);
            }
            Some(manager)
        } else {
            None
        };

        // Make the commands layout (`makeCommandsLayout`).
        let pipeline_layout_create_info = vk::PipelineLayoutCreateInfo {
            set_layout_count: 1,
            set_layouts: &set_layout_handle,
            push_constant_range_count: pc_ranges.len() as u32,
            push_constant_ranges: pc_ranges.as_ptr(),
            ..Default::default()
        };
        let use_dynamic_layout = params.dynamic_pipeline_layout && !descriptor_heap;
        let commands_layout_pipeline_layout = if use_dynamic_layout {
            vk::PipelineLayout::null()
        } else {
            pipeline_layout
        };
        let pc_token_stage = if descriptor_heap {
            vk::ShaderStageFlags::ALL
        } else {
            shader_stage
        };
        let range = |offset: u32, size: u32| vk::PushConstantRange {
            stage_flags: pc_token_stage,
            offset,
            size,
        };

        // Note we always add the dispatch token at the end.
        let mut cmds_layout_builder = IndirectCommandsLayoutBuilderExt::new(
            vk::IndirectCommandsLayoutUsageFlagsEXT::empty(),
            shader_stage,
            commands_layout_pipeline_layout,
        );
        if use_dynamic_layout {
            cmds_layout_builder.set_pipeline_layout_create_info(&pipeline_layout_create_info);
        }

        match test_type {
            TestType::PushDispatch | TestType::ComplementaryPushDispatch | TestType::ComplementaryPushIndexDispatch => {
                debug_assert!(pc_token_data_size != 0);
                add_pc_token(
                    &mut cmds_layout_builder,
                    descriptor_heap,
                    0,
                    range(0, pc_token_data_size),
                );

                if sequence_index {
                    // COMPLEMENTARY_PUSH_INDEX_DISPATCH: indirect push constants + extra push constant + index. In the indirect commands
                    // buffer, the sequence index placeholder comes after the other indirect push constants, but the push constant offset
                    // has to take into account the complentary push constant.
                    let stream_range = cmds_layout_builder.get_stream_stride();
                    add_seq_token(
                        &mut cmds_layout_builder,
                        descriptor_heap,
                        stream_range,
                        range(pc_token_data_size + CONSTANT_SIZE, CONSTANT_SIZE),
                    );
                }
            }
            TestType::MultiPushDispatch => {
                // We have 3 push constants and we'll update them in two steps: 1,2 followed by 0.
                add_pc_token(
                    &mut cmds_layout_builder,
                    descriptor_heap,
                    0,
                    range(CONSTANT_SIZE, CONSTANT_SIZE * 2),
                );
                let stream_range = cmds_layout_builder.get_stream_stride();
                add_pc_token(
                    &mut cmds_layout_builder,
                    descriptor_heap,
                    stream_range,
                    range(0, CONSTANT_SIZE),
                );
            }
            TestType::ExecutionSetDispatch | TestType::OffsetExecutionSetDispatch => {
                let token_offset = if test_type == TestType::OffsetExecutionSetDispatch {
                    4
                } else {
                    0
                };
                if shader_objects {
                    cmds_layout_builder.add_compute_shader_object_token(token_offset);
                } else {
                    cmds_layout_builder.add_compute_pipeline_token(token_offset);
                }
            }
            TestType::ExecutionSetPushDispatch
            | TestType::ExecutionSetIndexPushDispatch
            | TestType::ExecutionSetComplementaryPushDispatch => {
                debug_assert!(pc_token_data_size != 0);
                if shader_objects {
                    cmds_layout_builder.add_compute_shader_object_token(0);
                } else {
                    cmds_layout_builder.add_compute_pipeline_token(0);
                }

                let pc_offset = if test_type == TestType::ExecutionSetComplementaryPushDispatch {
                    CONSTANT_SIZE
                } else {
                    0
                };

                if sequence_index {
                    debug_assert_eq!(pc_offset, 0);
                    let stream_range = cmds_layout_builder.get_stream_stride();
                    add_seq_token(
                        &mut cmds_layout_builder,
                        descriptor_heap,
                        stream_range,
                        range(pc_offset + pc_token_data_size, CONSTANT_SIZE),
                    );
                }

                let stream_range = cmds_layout_builder.get_stream_stride();
                add_pc_token(
                    &mut cmds_layout_builder,
                    descriptor_heap,
                    stream_range,
                    range(pc_offset, pc_token_data_size),
                );
            }
        }

        // The dispatch always comes last.
        let stream_range = cmds_layout_builder.get_stream_stride();
        cmds_layout_builder.add_dispatch_token(stream_range);
        let commands_layout = cmds_layout_builder.build(device)?;

        // Create indirect commands buffer contents.
        let indirect_commands = self.make_indirect_commands(&wg_counts, &specialization_data);

        // Create a host-visible buffer to store them.
        let indirect_cmds_buffer_size = std::mem::size_of_val(indirect_commands.as_slice()) as vk::DeviceSize;
        let indirect_cmds_buffer = DgcBuffer::new(
            context,
            indirect_cmds_buffer_size,
            vk::BufferUsageFlags::empty(),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        {
            let alloc = indirect_cmds_buffer.get_allocation();
            unsafe {
                std::ptr::copy_nonoverlapping(
                    indirect_commands.as_ptr().cast::<u8>(),
                    alloc.get_host_ptr(),
                    indirect_cmds_buffer_size as usize,
                )
            };
            flush_alloc(device, alloc)?;
        }

        // Create a preprocess buffer. Note the execution set still misses the update() call.
        let execution_set_handle = execution_set
            .as_ref()
            .map_or(vk::IndirectExecutionSetEXT::null(), ExecutionSetManagerExt::get);
        let single_shader_handles: Vec<vk::ShaderEXT> = single_shader.iter().map(ShaderObject::get).collect();
        let preprocess_buffer = PreprocessBufferExt::new_with_shaders(
            context,
            execution_set_handle,
            commands_layout.get(),
            wg_counts.len() as u32,
            0,
            single_pipeline_handle, // This will be null when appropriate.
            &single_shader_handles,
            0,
        )?;

        // Now update the indirect execution set. See above for the reason to wait a bit to do this.
        if let Some(manager) = execution_set.as_mut() {
            manager.update();
        }

        let cmd_pool = make_command_pool(device, qf_index)?;
        let cmd_buffer_owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer_owner.get();

        begin_command_buffer(device, cmd_buffer)?;

        if descriptor_heap {
            unsafe { device.cmd_bind_resource_heap_ext(cmd_buffer, &bind_heap_info) };
        } else if let Some(descriptor_set) = &descriptor_set {
            unsafe {
                device.cmd_bind_descriptor_sets(
                    cmd_buffer,
                    bind_point,
                    pipeline_layout,
                    0,
                    &[descriptor_set.get()],
                    &[] as &[u32],
                );
            }
        }

        // Bind or prepare pipelines.
        if descriptor_heap && first_pipeline_handle != vk::Pipeline::null() {
            unsafe { device.cmd_bind_pipeline(cmd_buffer, bind_point, first_pipeline_handle) };
        } else if let Some(pipeline) = first_pipeline {
            pipeline.bind(cmd_buffer);
        } else if let Some(shader) = first_shader {
            unsafe { device.cmd_bind_shaders_ext(cmd_buffer, &[shader_stage], &[shader.get()]) };
        }

        if extra_push {
            // Must match the offset and size of valueOffset2 in the shaders.
            let no_ies = matches!(
                test_type,
                TestType::ComplementaryPushDispatch | TestType::ComplementaryPushIndexDispatch
            );
            let pc_offset = if no_ies { pc_token_data_size } else { 0 };
            let value_offset2_bytes = value_offset2.to_ne_bytes();
            if descriptor_heap {
                let push_data_info = vk::PushDataInfoEXT {
                    offset: pc_offset,
                    data: vk::HostAddressRangeConstEXT {
                        address: value_offset2_bytes.as_ptr().cast(),
                        size: value_offset2_bytes.len(),
                    },
                    ..Default::default()
                };
                unsafe { device.cmd_push_data_ext(cmd_buffer, &push_data_info) };
            } else {
                unsafe {
                    device.cmd_push_constants(
                        cmd_buffer,
                        pipeline_layout,
                        shader_stage,
                        pc_offset,
                        &value_offset2_bytes,
                    )
                };
            }
        }

        // Execute indirect commands.
        let generated_commands_info = if single_shader_handles.is_empty() {
            DgcGenCmdsInfo::new(
                shader_stage,
                execution_set_handle,
                commands_layout.get(),
                indirect_cmds_buffer.get_device_address(),
                indirect_cmds_buffer_size,
                preprocess_buffer.get_device_address(),
                preprocess_buffer.get_size(),
                wg_counts.len() as u32,
                0,
                0,
                single_pipeline_handle,
            )
        } else {
            DgcGenCmdsInfo::new_with_shaders(
                shader_stage,
                execution_set_handle,
                commands_layout.get(),
                indirect_cmds_buffer.get_device_address(),
                indirect_cmds_buffer_size,
                preprocess_buffer.get_device_address(),
                preprocess_buffer.get_size(),
                wg_counts.len() as u32,
                0,
                0,
                &single_shader_handles,
            )
        };
        unsafe { device.cmd_execute_generated_commands_ext(cmd_buffer, false, generated_commands_info.get()) };

        // Sync writes to the output buffer.
        {
            let barrier = make_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ);
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }

        end_command_buffer(device, cmd_buffer)?;
        submit_commands_and_wait(device, queue, cmd_buffer)?;

        // Retrieve output values.
        invalidate_alloc(device, output_buffer_alloc)?;
        let mut output_buffer_values = vec![0u32; total_invocations as usize];
        unsafe {
            std::ptr::copy_nonoverlapping(
                output_buffer_alloc.get_host_ptr().cast::<u32>(),
                output_buffer_values.as_mut_ptr(),
                output_buffer_values.len(),
            )
        };

        // Verify results.
        let mut fail = false;
        let mut value_index = 0usize;

        for (dispatch_idx, (&wg_count, data)) in wg_counts.iter().zip(&specialization_data).enumerate() {
            let skip_index = data.skip_index;
            let value_offset = data.value_offset;

            for wg_idx in 0..wg_count {
                for invocation_idx in 0..LOCAL_INVOCATIONS {
                    // Must match the calculation in the shader, obviously.
                    let expected = if invocation_idx == skip_index {
                        0
                    } else {
                        value_offset
                            + (wg_idx << 10)
                            + invocation_idx
                            + value_offset2
                            + if has_seq_index { dispatch_idx as u32 } else { 0 }
                    };
                    let result = output_buffer_values[value_index];

                    if expected != result {
                        log::error!(
                            "Unexpected value at index {value_index}; expected {expected} but found {result} ; dispatchIndex={dispatch_idx} workGroupIndex={wg_idx} invocationIndex={invocation_idx} skipIndex={skip_index} valueOffset={value_offset}"
                        );
                        fail = true;
                    }

                    value_index += 1;
                }
            }
        }

        drop(execution_set);
        drop(dgc_shaders);
        drop(single_shader);

        if fail {
            for wg_count in &wg_counts {
                log::error!("Dispatch size: {wg_count}");
            }
            return Ok(TestStatus::fail(
                "Unexpected output values found; check log for details",
            ));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// The pipeline variants of `createDGCComputeLayoutTestsExt`: the cases by their full dotted path in `dgc`.
pub fn create_dgc_compute_layout_tests_ext() -> Vec<(String, Box<dyn TestCase>)> {
    let test_types = [
        TestType::PushDispatch,
        TestType::ComplementaryPushDispatch,
        TestType::ComplementaryPushIndexDispatch,
        TestType::MultiPushDispatch,
        TestType::OffsetExecutionSetDispatch,
        TestType::ExecutionSetDispatch,
        TestType::ExecutionSetPushDispatch,
        TestType::ExecutionSetIndexPushDispatch,
        TestType::ExecutionSetComplementaryPushDispatch,
    ];

    let mut cases = Vec::new();
    for descriptor_heap in [false, true] {
        for compute_queue in [false, true] {
            for shader_objects in [false, true] {
                for destroy_set_layout in [false, true] {
                    // Destroying the layouts of VkIndirectExecutionSetShaderLayoutInfoEXT only applies to execution sets of shader objects.
                    if destroy_set_layout && !shader_objects {
                        continue;
                    }
                    for dynamic_pipeline_layout in [false, true] {
                        for test_type in test_types {
                            if destroy_set_layout && !test_type.has_execution_set() {
                                continue;
                            }
                            let params = TestParams {
                                test_type,
                                compute_queue,
                                dynamic_pipeline_layout,
                                shader_objects,
                                destroy_set_layout,
                                descriptor_heap,
                            };
                            let test_name = format!(
                                "{}{}{}{}{}{}",
                                test_type.name(),
                                if shader_objects { "_shader_objects" } else { "" },
                                if compute_queue { "_cq" } else { "" },
                                if dynamic_pipeline_layout {
                                    "_dynamic_pipeline_layout"
                                } else {
                                    ""
                                },
                                if destroy_set_layout {
                                    "_destroy_ies_set_layout"
                                } else {
                                    ""
                                },
                                if descriptor_heap { "_descriptor_heap" } else { "" },
                            );
                            cases.push((
                                format!("ext.compute.layout.{test_name}"),
                                Box::new(LayoutTestCase {
                                    name: test_name,
                                    params,
                                }) as Box<dyn TestCase>,
                            ));
                        }
                    }
                }
            }
        }
    }
    cases
}
