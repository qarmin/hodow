// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/memory_model/vktMemoryModelMessagePassing.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2018-2019 The Khronos Group Inc.
// Copyright (c) 2018-2019 NVIDIA Corporation
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders are pre-expanded by hodow_cts/scripts/gen_memory_model_mp.py into
// shaders/manifest/memory_model_message_passing.toml, one entry per distinct parameter set, and looked up by the case's
// parameters. Not ported: the shaders of the split control barrier cases, which are
// always reported as not supported because vulkanalia has no VkPhysicalDeviceShaderSplitBarrierFeaturesEXT to query.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_2, InstanceV1_1};

use crate::generated::shaders::memory_model_message_passing::ALL_MESSAGE_PASSING_PROGRAMS;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, make_rect_2d, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_descriptor_set};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy, PartialEq, Eq)]
enum TestType {
    /// message passing
    Mp = 0,
    /// write-after-read hazard
    War = 1,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum SyncType {
    FenceFence = 0,
    FenceAtomic = 1,
    AtomicFence = 2,
    AtomicAtomic = 3,
    ControlBarrier = 4,
    ControlAndMemoryBarrier = 5,
    SplitControlBarrier = 6,
    SplitControlAndMemoryBarrier = 7,
    SplitControlBarrierAndBarrier = 8,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum StorageClass {
    Buffer = 0,
    Image = 1,
    Workgroup = 2,
    PhysBuffer = 3,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum Scope {
    Device = 0,
    QueueFamily = 1,
    Workgroup = 2,
    Subgroup = 3,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum Stage {
    Compute = 0,
    Vertex = 1,
    Fragment = 2,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum DataType {
    Uint = 0,
    Uint64 = 1,
    Float32 = 2,
    Float64 = 3,
}

#[derive(Clone, Copy)]
struct CaseDef {
    payload_mem_local: bool,
    guard_mem_local: bool,
    coherent: bool,
    core11: bool,
    atomic_rmw: bool,
    test_type: TestType,
    payload_sc: StorageClass,
    guard_sc: StorageClass,
    scope: Scope,
    sync_type: SyncType,
    stage: Stage,
    data_type: DataType,
    transitive: bool,
    transitive_vis: bool,
}

fn is_split_barrier(sync_type: SyncType) -> bool {
    matches!(
        sync_type,
        SyncType::SplitControlBarrier
            | SyncType::SplitControlAndMemoryBarrier
            | SyncType::SplitControlBarrierAndBarrier
    )
}

fn all_shader_stages() -> vk::ShaderStageFlags {
    vk::ShaderStageFlags::COMPUTE | vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT
}

fn vulkan12_features(context: &Context<'_>) -> vk::PhysicalDeviceVulkan12Features {
    let mut features12 = vk::PhysicalDeviceVulkan12Features::default();
    let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features12);
    unsafe {
        context
            .get_instance()
            .get_physical_device_features2(context.get_physical_device(), &mut features2)
    };
    features12
}

fn atomic_float_features(context: &Context<'_>) -> vk::PhysicalDeviceShaderAtomicFloatFeaturesEXT {
    let mut features = vk::PhysicalDeviceShaderAtomicFloatFeaturesEXT::default();
    let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
    unsafe {
        context
            .get_instance()
            .get_physical_device_features2(context.get_physical_device(), &mut features2)
    };
    features
}

/// `getCompatibleMemoryTypes(memProps, requirement) != 0`
fn has_compatible_memory_type(context: &Context<'_>, requirement: MemoryRequirement) -> bool {
    let memory_properties = context.get_default_allocator().memory_properties();
    (0..memory_properties.memory_type_count as usize)
        .any(|i| requirement.matches_heap(memory_properties.memory_types[i].property_flags))
}

struct MemoryModelTestCase {
    name: &'static str,
    data: CaseDef,
}

impl TestCase for MemoryModelTestCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let data = &self.data;
        let (major, minor, _) = context.api_version();
        if (major, minor) < (1, 1) {
            return Err(TestError::NotSupported("Vulkan 1.1 not supported".to_string()));
        }

        let features12 = vulkan12_features(context);

        if !data.core11 {
            if features12.vulkan_memory_model == vk::FALSE {
                return Err(TestError::NotSupported("vulkanMemoryModel not supported".to_string()));
            }

            if data.scope == Scope::Device && features12.vulkan_memory_model_device_scope == vk::FALSE {
                return Err(TestError::NotSupported(
                    "vulkanMemoryModelDeviceScope not supported".to_string(),
                ));
            }
        }

        if is_split_barrier(data.sync_type) {
            if data.stage != Stage::Compute {
                return Err(TestError::NotSupported(
                    "VK_EXT_shader_split_barrier is only supported in compute shaders".to_string(),
                ));
            }

            return Err(TestError::NotSupported(
                "shaderSplitBarrier feature not supported".to_string(),
            ));
        }

        if data.scope == Scope::Subgroup {
            // Check for subgroup support for scope_subgroup tests.
            let mut subgroup_properties = vk::PhysicalDeviceSubgroupProperties::default();
            let mut properties = vk::PhysicalDeviceProperties2::builder().push_next(&mut subgroup_properties);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_properties2(context.get_physical_device(), &mut properties)
            };

            let required =
                vk::SubgroupFeatureFlags::BASIC | vk::SubgroupFeatureFlags::BALLOT | vk::SubgroupFeatureFlags::SHUFFLE;
            if !subgroup_properties.supported_operations.contains(required) {
                return Err(TestError::NotSupported("Subgroup features not supported".to_string()));
            }

            let stage = match data.stage {
                Stage::Vertex => vk::ShaderStageFlags::VERTEX,
                Stage::Compute => vk::ShaderStageFlags::COMPUTE,
                Stage::Fragment => vk::ShaderStageFlags::FRAGMENT,
            };

            if !subgroup_properties.supported_stages.intersects(stage) {
                return Err(TestError::NotSupported(
                    "Device does not support subgroup operations for this stage".to_string(),
                ));
            }
        }
        if data.data_type == DataType::Uint64 {
            if context.get_device_features().shader_int64 == vk::FALSE {
                return Err(TestError::NotSupported(
                    "64-bit integer in shaders not supported".to_string(),
                ));
            }
            if features12.shader_buffer_int64_atomics == vk::FALSE
                && (data.guard_sc == StorageClass::Buffer || data.guard_sc == StorageClass::PhysBuffer)
            {
                return Err(TestError::NotSupported(
                    "64-bit integer buffer atomics not supported".to_string(),
                ));
            }
            if features12.shader_shared_int64_atomics == vk::FALSE && data.guard_sc == StorageClass::Workgroup {
                return Err(TestError::NotSupported(
                    "64-bit integer shared atomics not supported".to_string(),
                ));
            }
        }

        if data.data_type == DataType::Float32 {
            if !context.is_device_functionality_supported("VK_EXT_shader_atomic_float") {
                return Err(TestError::NotSupported(
                    "Missing extension: VK_EXT_shader_atomic_float".to_string(),
                ));
            }
            let atomic_float = atomic_float_features(context);

            if (data.guard_sc == StorageClass::Buffer || data.guard_sc == StorageClass::PhysBuffer)
                && atomic_float.shader_buffer_float32_atomics == vk::FALSE
            {
                return Err(TestError::NotSupported(
                    "VkShaderAtomicFloat32: 32-bit floating point buffer atomic operations not supported".to_string(),
                ));
            }

            if data.guard_sc == StorageClass::Image && atomic_float.shader_image_float32_atomics == vk::FALSE {
                return Err(TestError::NotSupported(
                    "VkShaderAtomicFloat32: 32-bit floating point image atomic operations not supported".to_string(),
                ));
            }

            if data.guard_sc == StorageClass::Workgroup && atomic_float.shader_shared_float32_atomics == vk::FALSE {
                return Err(TestError::NotSupported(
                    "VkShaderAtomicFloat32: 32-bit floating point shared atomic operations not supported".to_string(),
                ));
            }
        }

        if data.data_type == DataType::Float64 {
            if !context.is_device_functionality_supported("VK_EXT_shader_atomic_float") {
                return Err(TestError::NotSupported(
                    "Missing extension: VK_EXT_shader_atomic_float".to_string(),
                ));
            }
            let atomic_float = atomic_float_features(context);

            if (data.guard_sc == StorageClass::Buffer || data.guard_sc == StorageClass::PhysBuffer)
                && atomic_float.shader_buffer_float64_atomics == vk::FALSE
            {
                return Err(TestError::NotSupported(
                    "VkShaderAtomicFloat64: 64-bit floating point buffer atomic operations not supported".to_string(),
                ));
            }

            if data.guard_sc == StorageClass::Image || data.payload_sc == StorageClass::Image {
                return Err(TestError::NotSupported(
                    "VkShaderAtomicFloat64: 64-bit floating point image atomic operations not supported".to_string(),
                ));
            }

            if data.guard_sc == StorageClass::Workgroup && atomic_float.shader_shared_float64_atomics == vk::FALSE {
                return Err(TestError::NotSupported(
                    "VkShaderAtomicFloat64: 64-bit floating point shared atomic operations not supported".to_string(),
                ));
            }
        }

        if data.transitive && features12.vulkan_memory_model_availability_visibility_chains == vk::FALSE {
            return Err(TestError::NotSupported(
                "vulkanMemoryModelAvailabilityVisibilityChains not supported".to_string(),
            ));
        }

        if (data.payload_sc == StorageClass::PhysBuffer || data.guard_sc == StorageClass::PhysBuffer)
            && features12.buffer_device_address == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "Physical storage buffer pointers not supported".to_string(),
            ));
        }

        if data.stage == Stage::Vertex && context.get_device_features().vertex_pipeline_stores_and_atomics == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "vertexPipelineStoresAndAtomics not supported".to_string(),
            ));
        }
        if data.stage == Stage::Fragment && context.get_device_features().fragment_stores_and_atomics == vk::FALSE {
            return Err(TestError::NotSupported(
                "fragmentStoresAndAtomics not supported".to_string(),
            ));
        }

        // note alorgorithm here coresponds to the one in MemoryModelTestInstance::iterate
        let is_device_address_supported = context.is_device_functionality_supported("VK_KHR_buffer_device_address");
        for i in 0..3u32 {
            let (local, memory_device_address) = match i {
                0 => {
                    if data.payload_sc != StorageClass::Buffer && data.payload_sc != StorageClass::PhysBuffer {
                        continue;
                    }
                    (
                        data.payload_mem_local,
                        data.payload_sc == StorageClass::PhysBuffer && is_device_address_supported,
                    )
                }
                1 => {
                    if data.guard_sc != StorageClass::Buffer && data.guard_sc != StorageClass::PhysBuffer {
                        continue;
                    }
                    (
                        data.guard_mem_local,
                        data.guard_sc == StorageClass::PhysBuffer && is_device_address_supported,
                    )
                }
                _ => (true, false),
            };

            let mem_req = (if memory_device_address {
                MemoryRequirement::DEVICE_ADDRESS
            } else {
                MemoryRequirement::ANY
            }) | (if local {
                MemoryRequirement::LOCAL
            } else {
                MemoryRequirement::NON_LOCAL
            });
            if !has_compatible_memory_type(context, mem_req) {
                return Err(TestError::NotSupported(
                    "Test variant uses memory type which is not supported".to_string(),
                ));
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let data = &self.data;
        ALL_MESSAGE_PASSING_PROGRAMS
            .iter()
            .find(|p| {
                p.test_type == data.test_type as u32
                    && p.core11 == data.core11
                    && p.coherent == data.coherent
                    && p.atomic_rmw == data.atomic_rmw
                    && p.payload_sc == data.payload_sc as u32
                    && p.guard_sc == data.guard_sc as u32
                    && p.scope == data.scope as u32
                    && p.sync_type == data.sync_type as u32
                    && p.stage == data.stage as u32
                    && p.data_type == data.data_type as u32
                    && p.transitive == data.transitive
                    && p.transitive_vis == data.transitive_vis
            })
            .map_or_else(|| BinaryCollection::new(&[]), |p| p.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MemoryModelTestInstance {
            context,
            data: self.data,
        })
    }
}

/// The `rust_type` of the manifest entries.
#[derive(Clone, Copy)]
pub struct MessagePassingPrograms {
    pub name: &'static str,
    pub test_type: u32,
    pub core11: bool,
    pub coherent: bool,
    pub atomic_rmw: bool,
    pub payload_sc: u32,
    pub guard_sc: u32,
    pub scope: u32,
    pub sync_type: u32,
    pub stage: u32,
    pub data_type: u32,
    pub transitive: bool,
    pub transitive_vis: bool,
    pub programs: BinaryCollection,
}

struct MemoryModelTestInstance<'a> {
    context: &'a Context<'a>,
    data: CaseDef,
}

const WIDTH_DIM_DEFAULT: u32 = 31;
const NUM_WORKGROUP_EACH_DIM: u32 = 8;

impl MemoryModelTestInstance<'_> {
    /// `MemoryModelTestInstance::queuePass`
    fn queue_pass(&self, queue: vk::Queue, family_index: u32) -> TestOutcome {
        let context = self.context;
        let data = &self.data;
        let device = context.get_device();
        let allocator = context.get_default_allocator();

        let all_pipeline_stages = if data.stage == Stage::Compute {
            vk::PipelineStageFlags::COMPUTE_SHADER
        } else {
            vk::PipelineStageFlags::COMPUTE_SHADER
                | vk::PipelineStageFlags::VERTEX_SHADER
                | vk::PipelineStageFlags::FRAGMENT_SHADER
        };

        let mut dim = WIDTH_DIM_DEFAULT;
        let max_invocations = context
            .get_device_properties()
            .limits
            .max_compute_work_group_invocations;
        // If necessary, shrink workgroup size to fit HW limits
        if dim * dim > max_invocations {
            dim = (max_invocations as f32).sqrt() as u32;
        }
        let num_invocations = dim * dim * NUM_WORKGROUP_EACH_DIM * NUM_WORKGROUP_EACH_DIM;
        let render_extent = dim * NUM_WORKGROUP_EACH_DIM;

        let mut buffer_sizes = [0 as vk::DeviceSize; 3];
        let mut buffers: [Option<BufferWithMemory<'_>>; 3] = [None, None, None];

        for i in 0..3usize {
            let mut element_size = if matches!(data.data_type, DataType::Uint64 | DataType::Float64) {
                std::mem::size_of::<u64>()
            } else {
                std::mem::size_of::<u32>()
            };
            // buffer2 is the "fail" buffer, and is always uint
            if i == 2 {
                element_size = std::mem::size_of::<u32>();
            }
            buffer_sizes[i] = (num_invocations as usize * element_size) as vk::DeviceSize;

            let mut usage_flags = vk::BufferUsageFlags::STORAGE_BUFFER
                | vk::BufferUsageFlags::TRANSFER_DST
                | vk::BufferUsageFlags::TRANSFER_SRC;

            let mut memory_device_address = false;
            let is_device_address_supported = context.is_device_functionality_supported("VK_KHR_buffer_device_address");

            // note alorgorithm here coresponds to the one in MemoryModelTestCase::checkSupport
            let local = match i {
                0 => {
                    if data.payload_sc != StorageClass::Buffer && data.payload_sc != StorageClass::PhysBuffer {
                        continue;
                    }
                    if data.payload_sc == StorageClass::PhysBuffer {
                        usage_flags |= vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS;
                        memory_device_address = is_device_address_supported;
                    }
                    data.payload_mem_local
                }
                1 => {
                    if data.guard_sc != StorageClass::Buffer && data.guard_sc != StorageClass::PhysBuffer {
                        continue;
                    }
                    if data.guard_sc == StorageClass::PhysBuffer {
                        usage_flags |= vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS;
                        memory_device_address = is_device_address_supported;
                    }
                    data.guard_mem_local
                }
                _ => true,
            };

            let requirement = (if memory_device_address {
                MemoryRequirement::DEVICE_ADDRESS
            } else {
                MemoryRequirement::ANY
            }) | (if local {
                MemoryRequirement::LOCAL
            } else {
                MemoryRequirement::NON_LOCAL
            });
            buffers[i] = Some(BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(buffer_sizes[i], usage_flags),
                requirement,
            )?);
        }

        // Try to use cached host memory for the buffer the CPU will read from, else fallback to host visible.
        let copy_buffer = match BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(buffer_sizes[2], vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE | MemoryRequirement::CACHED,
        ) {
            Ok(buffer) => buffer,
            Err(TestError::NotSupported(_)) => BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(buffer_sizes[2], vk::BufferUsageFlags::TRANSFER_DST),
                MemoryRequirement::HOST_VISIBLE,
            )?,
            Err(e) => return Err(e),
        };

        let image_format = match data.data_type {
            DataType::Uint | DataType::Uint64 => vk::Format::R32_UINT,
            DataType::Float32 | DataType::Float64 => vk::Format::R32_SFLOAT,
        };

        let image_create_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(image_format)
            .extent(vk::Extent3D {
                width: render_extent,
                height: render_extent,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::STORAGE | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();

        let mut images: [Option<ImageWithMemory<'_>>; 2] = [None, None];
        let mut image_views: [Option<Unique<'_, vk::ImageView>>; 2] = [None, None];
        let mut image_descriptors = [vk::DescriptorImageInfo::default(); 2];

        for i in 0..2usize {
            let local = match i {
                0 => {
                    if data.payload_sc != StorageClass::Image {
                        continue;
                    }
                    data.payload_mem_local
                }
                _ => {
                    if data.guard_sc != StorageClass::Image {
                        continue;
                    }
                    data.guard_mem_local
                }
            };

            let image = match ImageWithMemory::new(
                device,
                allocator,
                image_create_info,
                if local {
                    MemoryRequirement::LOCAL
                } else {
                    MemoryRequirement::NON_LOCAL
                },
            ) {
                Ok(image) => image,
                Err(TestError::NotSupported(_)) if !local => {
                    return Err(TestError::NotSupported(
                        "Test variant uses non-device-local memory, which is not supported".to_string(),
                    ));
                }
                Err(e) => return Err(e),
            };
            let view = make_image_view(
                device,
                image.get(),
                vk::ImageViewType::_2D,
                image_format,
                make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
            )?;

            image_descriptors[i] = vk::DescriptorImageInfo {
                sampler: vk::Sampler::null(),
                image_view: *view,
                image_layout: vk::ImageLayout::GENERAL,
            };
            images[i] = Some(image);
            image_views[i] = Some(view);
        }

        let _keep_views_alive = &image_views;

        let mut layout_builder = DescriptorSetLayoutBuilder::new();
        for sc in [data.payload_sc, data.guard_sc] {
            layout_builder = match sc {
                StorageClass::Image => {
                    layout_builder.add_single_binding(vk::DescriptorType::STORAGE_IMAGE, all_shader_stages())
                }
                _ => layout_builder.add_single_binding(vk::DescriptorType::STORAGE_BUFFER, all_shader_stages()),
            };
        }
        layout_builder = layout_builder.add_single_binding(vk::DescriptorType::STORAGE_BUFFER, all_shader_stages());
        let descriptor_set_layout = layout_builder.build(device)?;

        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 3)
            .add_type(vk::DescriptorType::STORAGE_IMAGE, 3)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        let mut buffer_descriptors = [vk::DescriptorBufferInfo::default(); 3];
        for i in 0..3 {
            if let Some(buffer) = &buffers[i] {
                buffer_descriptors[i] = vk::DescriptorBufferInfo {
                    buffer: buffer.get(),
                    offset: 0,
                    range: buffer_sizes[i],
                };
            }
        }

        let mut writes: Vec<vk::WriteDescriptorSet> = Vec::new();
        let make_write =
            |binding: u32,
             descriptor_type: vk::DescriptorType,
             image_info: *const vk::DescriptorImageInfo,
             buffer_info: *const vk::DescriptorBufferInfo| vk::WriteDescriptorSet {
                s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
                next: std::ptr::null(),
                dst_set: descriptor_set.get(),
                dst_binding: binding,
                dst_array_element: 0,
                descriptor_count: 1,
                descriptor_type,
                image_info,
                buffer_info,
                texel_buffer_view: std::ptr::null(),
            };
        match data.payload_sc {
            StorageClass::PhysBuffer | StorageClass::Workgroup => {}
            StorageClass::Buffer => writes.push(make_write(
                0,
                vk::DescriptorType::STORAGE_BUFFER,
                std::ptr::null(),
                &buffer_descriptors[0],
            )),
            StorageClass::Image => writes.push(make_write(
                0,
                vk::DescriptorType::STORAGE_IMAGE,
                &image_descriptors[0],
                std::ptr::null(),
            )),
        }
        match data.guard_sc {
            StorageClass::PhysBuffer | StorageClass::Workgroup => {}
            StorageClass::Buffer => writes.push(make_write(
                1,
                vk::DescriptorType::STORAGE_BUFFER,
                std::ptr::null(),
                &buffer_descriptors[1],
            )),
            StorageClass::Image => writes.push(make_write(
                1,
                vk::DescriptorType::STORAGE_IMAGE,
                &image_descriptors[1],
                std::ptr::null(),
            )),
        }
        writes.push(make_write(
            2,
            vk::DescriptorType::STORAGE_BUFFER,
            std::ptr::null(),
            &buffer_descriptors[2],
        ));
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        let push_const_range = vk::PushConstantRange {
            stage_flags: all_shader_stages(),
            offset: 0,
            size: 16,
        };
        let set_layouts = [*descriptor_set_layout];
        let push_const_ranges = [push_const_range];
        let pipeline_layout_info = vk::PipelineLayoutCreateInfo::builder()
            .set_layouts(&set_layouts)
            .push_constant_ranges(&push_const_ranges);
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&pipeline_layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        let bind_point = if data.stage == Stage::Compute {
            vk::PipelineBindPoint::COMPUTE
        } else {
            vk::PipelineBindPoint::GRAPHICS
        };

        let mut spec_data = [0u8; 8];
        spec_data[..4].copy_from_slice(&dim.to_ne_bytes());
        spec_data[4..].copy_from_slice(&NUM_WORKGROUP_EACH_DIM.to_ne_bytes());
        let entries = [
            vk::SpecializationMapEntry {
                constant_id: 0,
                offset: 0,
                size: 4,
            },
            vk::SpecializationMapEntry {
                constant_id: 1,
                offset: 4,
                size: 4,
            },
        ];
        let spec_info = vk::SpecializationInfo {
            map_entry_count: 2,
            map_entries: entries.as_ptr(),
            data_size: spec_data.len(),
            data: spec_data.as_ptr().cast(),
        };

        let make_stage = |stage: vk::ShaderStageFlags, module: vk::ShaderModule| {
            let mut info = vk::PipelineShaderStageCreateInfo::builder()
                .stage(stage)
                .module(module)
                .name(b"main\0")
                .build();
            info.specialization_info = &spec_info;
            info
        };

        let binaries = context.get_binary_collection();
        let mut render_pass = None;
        let mut framebuffer = None;
        let pipeline;

        if data.stage == Stage::Compute {
            let shader = create_shader_module(device, binaries.get("test")?)?;
            let pipeline_info = vk::ComputePipelineCreateInfo::builder()
                .stage(make_stage(vk::ShaderStageFlags::COMPUTE, *shader))
                .layout(*pipeline_layout)
                .base_pipeline_index(0)
                .build();
            let pipelines =
                unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
                    .vk_check("vkCreateComputePipelines")?;
            pipeline = Unique::new(device, pipelines.0[0]);
        } else {
            let subpass_desc = vk::SubpassDescription::builder()
                .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                .build();
            let subpasses = [subpass_desc];
            let render_pass_params = vk::RenderPassCreateInfo::builder().subpasses(&subpasses);
            let pass = Unique::new(
                device,
                unsafe { device.create_render_pass(&render_pass_params, None) }.vk_check("vkCreateRenderPass")?,
            );

            let framebuffer_params = vk::FramebufferCreateInfo::builder()
                .render_pass(*pass)
                .width(render_extent)
                .height(render_extent)
                .layers(1);
            let fb = Unique::new(
                device,
                unsafe { device.create_framebuffer(&framebuffer_params, None) }.vk_check("vkCreateFramebuffer")?,
            );

            let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder();
            let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
                .topology(if data.stage == Stage::Vertex {
                    vk::PrimitiveTopology::POINT_LIST
                } else {
                    vk::PrimitiveTopology::TRIANGLE_STRIP
                })
                .primitive_restart_enable(false);
            let rasterization_state = vk::PipelineRasterizationStateCreateInfo::builder()
                .depth_clamp_enable(false)
                .rasterizer_discard_enable(data.stage == Stage::Vertex)
                .polygon_mode(vk::PolygonMode::FILL)
                .cull_mode(vk::CullModeFlags::NONE)
                .front_face(vk::FrontFace::CLOCKWISE)
                .depth_bias_enable(false)
                .line_width(1.0);
            let multisample_state = vk::PipelineMultisampleStateCreateInfo::builder()
                .rasterization_samples(vk::SampleCountFlags::_1)
                .sample_shading_enable(false)
                .min_sample_shading(1.0);
            let viewports = [vk::Viewport {
                x: 0.0,
                y: 0.0,
                width: render_extent as f32,
                height: render_extent as f32,
                min_depth: 0.0,
                max_depth: 1.0,
            }];
            let scissors = [make_rect_2d(0, 0, render_extent, render_extent)];
            let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
                .viewports(&viewports)
                .scissors(&scissors);

            let (vs, fs, num_stages) = if data.stage == Stage::Vertex {
                let vs = create_shader_module(device, binaries.get("test")?)?;
                // bogus, as upstream's
                let fs = create_shader_module(device, binaries.get("test")?)?;
                (vs, fs, 1usize)
            } else {
                (
                    create_shader_module(device, binaries.get("vert")?)?,
                    create_shader_module(device, binaries.get("test")?)?,
                    2usize,
                )
            };

            let shader_create_info = [
                make_stage(vk::ShaderStageFlags::VERTEX, *vs),
                make_stage(vk::ShaderStageFlags::FRAGMENT, *fs),
            ];

            let graphics_pipeline_info = vk::GraphicsPipelineCreateInfo::builder()
                .stages(&shader_create_info[..num_stages])
                .vertex_input_state(&vertex_input_state)
                .input_assembly_state(&input_assembly_state)
                .viewport_state(&viewport_state)
                .rasterization_state(&rasterization_state)
                .multisample_state(&multisample_state)
                .layout(*pipeline_layout)
                .render_pass(*pass)
                .subpass(0)
                .base_pipeline_index(0);

            let pipelines =
                unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[graphics_pipeline_info], None) }
                    .vk_check("vkCreateGraphicsPipelines")?;
            pipeline = Unique::new(device, pipelines.0[0]);
            render_pass = Some(pass);
            framebuffer = Some(fb);
        }

        let pool_info = vk::CommandPoolCreateInfo::builder()
            .flags(vk::CommandPoolCreateFlags::RESET_COMMAND_BUFFER)
            .queue_family_index(family_index);
        let cmd_pool = Unique::new(
            device,
            unsafe { device.create_command_pool(&pool_info, None) }.vk_check("vkCreateCommandPool")?,
        );
        let cmd_buffer_ptr = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer_ptr.get();

        let range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let clear_color = vk::ClearColorValue { uint32: [0, 0, 0, 0] };

        let copy_params = vk::BufferCopy {
            src_offset: 0,
            dst_offset: 0,
            size: buffer_sizes[2],
        };

        const NUM_SUBMITS: u32 = 4;

        let fail_buffer = buffers[2]
            .as_ref()
            .ok_or_else(|| TestError::InternalError("fail buffer missing".to_string()))?;

        for x in 0..NUM_SUBMITS {
            begin_command_buffer(device, cmd_buffer)?;

            if x == 0 {
                unsafe { device.cmd_fill_buffer(cmd_buffer, fail_buffer.get(), 0, buffer_sizes[2], 0) };
            }

            for image in images.iter().flatten() {
                let image_barrier = make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::GENERAL,
                    image.get(),
                    range,
                );
                unsafe {
                    device.cmd_pipeline_barrier(
                        cmd_buffer,
                        vk::PipelineStageFlags::BOTTOM_OF_PIPE,
                        vk::PipelineStageFlags::TRANSFER,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[] as &[vk::BufferMemoryBarrier],
                        &[image_barrier],
                    );
                }
            }

            unsafe {
                device.cmd_bind_descriptor_sets(
                    cmd_buffer,
                    bind_point,
                    *pipeline_layout,
                    0,
                    &[descriptor_set.get()],
                    &[] as &[u32],
                );
                device.cmd_bind_pipeline(cmd_buffer, bind_point, *pipeline);
            }

            if data.payload_sc == StorageClass::PhysBuffer {
                let buffer = buffers[0]
                    .as_ref()
                    .ok_or_else(|| TestError::InternalError("payload buffer missing".to_string()))?;
                let addr_info = vk::BufferDeviceAddressInfo::builder().buffer(buffer.get());
                let addr = unsafe { device.get_buffer_device_address(&addr_info) };
                unsafe {
                    device.cmd_push_constants(
                        cmd_buffer,
                        *pipeline_layout,
                        all_shader_stages(),
                        0,
                        &addr.to_ne_bytes(),
                    )
                };
            }
            if data.guard_sc == StorageClass::PhysBuffer {
                let buffer = buffers[1]
                    .as_ref()
                    .ok_or_else(|| TestError::InternalError("guard buffer missing".to_string()))?;
                let addr_info = vk::BufferDeviceAddressInfo::builder().buffer(buffer.get());
                let addr = unsafe { device.get_buffer_device_address(&addr_info) };
                unsafe {
                    device.cmd_push_constants(
                        cmd_buffer,
                        *pipeline_layout,
                        all_shader_stages(),
                        8,
                        &addr.to_ne_bytes(),
                    )
                };
            }

            for _iters in 0..50 {
                for i in 0..2usize {
                    if let Some(buffer) = &buffers[i] {
                        unsafe { device.cmd_fill_buffer(cmd_buffer, buffer.get(), 0, buffer_sizes[i], 0) };
                    }
                    if let Some(image) = &images[i] {
                        unsafe {
                            device.cmd_clear_color_image(
                                cmd_buffer,
                                image.get(),
                                vk::ImageLayout::GENERAL,
                                &clear_color,
                                &[range],
                            )
                        };
                    }
                }

                let mem_barrier = vk::MemoryBarrier::builder()
                    .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
                    .dst_access_mask(vk::AccessFlags::SHADER_READ | vk::AccessFlags::SHADER_WRITE)
                    .build();
                unsafe {
                    device.cmd_pipeline_barrier(
                        cmd_buffer,
                        vk::PipelineStageFlags::TRANSFER,
                        all_pipeline_stages,
                        vk::DependencyFlags::empty(),
                        &[mem_barrier],
                        &[] as &[vk::BufferMemoryBarrier],
                        &[] as &[vk::ImageMemoryBarrier],
                    );
                }

                if data.stage == Stage::Compute {
                    unsafe { device.cmd_dispatch(cmd_buffer, NUM_WORKGROUP_EACH_DIM, NUM_WORKGROUP_EACH_DIM, 1) };
                } else {
                    let (Some(pass), Some(fb)) = (render_pass.as_ref(), framebuffer.as_ref()) else {
                        return Err(TestError::InternalError(
                            "render pass or framebuffer missing".to_string(),
                        ));
                    };
                    let begin_info = vk::RenderPassBeginInfo::builder()
                        .render_pass(**pass)
                        .framebuffer(**fb)
                        .render_area(make_rect_2d(0, 0, render_extent, render_extent));
                    unsafe {
                        device.cmd_begin_render_pass(cmd_buffer, &begin_info, vk::SubpassContents::INLINE);
                        // Draw a point cloud for vertex shader testing, and a single quad for fragment shader testing
                        if data.stage == Stage::Vertex {
                            device.cmd_draw(cmd_buffer, num_invocations, 1, 0, 0);
                        } else {
                            device.cmd_draw(cmd_buffer, 4, 1, 0, 0);
                        }
                        device.cmd_end_render_pass(cmd_buffer);
                    }
                }

                let mem_barrier = vk::MemoryBarrier::builder()
                    .src_access_mask(vk::AccessFlags::SHADER_READ | vk::AccessFlags::SHADER_WRITE)
                    .dst_access_mask(vk::AccessFlags::TRANSFER_READ | vk::AccessFlags::TRANSFER_WRITE)
                    .build();
                unsafe {
                    device.cmd_pipeline_barrier(
                        cmd_buffer,
                        all_pipeline_stages,
                        vk::PipelineStageFlags::TRANSFER,
                        vk::DependencyFlags::empty(),
                        &[mem_barrier],
                        &[] as &[vk::BufferMemoryBarrier],
                        &[] as &[vk::ImageMemoryBarrier],
                    );
                }
            }

            if x == NUM_SUBMITS - 1 {
                let mem_barrier = vk::MemoryBarrier::builder()
                    .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
                    .dst_access_mask(vk::AccessFlags::HOST_READ)
                    .build();
                unsafe {
                    device.cmd_copy_buffer(cmd_buffer, fail_buffer.get(), copy_buffer.get(), &[copy_params]);
                    device.cmd_pipeline_barrier(
                        cmd_buffer,
                        vk::PipelineStageFlags::TRANSFER,
                        vk::PipelineStageFlags::HOST,
                        vk::DependencyFlags::empty(),
                        &[mem_barrier],
                        &[] as &[vk::BufferMemoryBarrier],
                        &[] as &[vk::ImageMemoryBarrier],
                    );
                }
            }

            end_command_buffer(device, cmd_buffer)?;
            submit_commands_and_wait(device, queue, cmd_buffer)?;
        }

        let copy_alloc = copy_buffer.get_allocation();
        invalidate_alloc(device, copy_alloc)?;
        let results =
            unsafe { std::slice::from_raw_parts(copy_alloc.get_host_ptr().cast::<u32>(), num_invocations as usize) };

        let num_errors = results.iter().filter(|&&r| r != 0).count();
        if num_errors != 0 {
            return Ok(TestStatus::fail("Fail"));
        }
        Ok(TestStatus::pass("Pass"))
    }

    /// `MultiQueueRunnerTestInstance(context, data.stage == STAGE_COMPUTE ? COMPUTE_QUEUE : GRAPHICS_QUEUE)`: the universal queue, plus
    /// the compute-only family's for a compute shader.
    fn queues(&self) -> Vec<(vk::Queue, u32)> {
        let mut queues = vec![(
            self.context.get_universal_queue(),
            self.context.get_universal_queue_family_index(),
        )];
        if self.data.stage == Stage::Compute
            && let Some((queue, family)) = self.context.get_compute_queue()
            && family != self.context.get_universal_queue_family_index()
        {
            queues.push((queue, family));
        }
        queues
    }
}

impl TestInstance for MemoryModelTestInstance<'_> {
    /// `MultiQueueRunnerTestInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        for (queue, family_index) in self.queues() {
            let status = self.queue_pass(queue, family_index)?;
            if status.is_fail() {
                return Ok(status);
            }
        }
        Ok(TestStatus::pass("Pass"))
    }
}

const TT_CASES: [(TestType, &str); 2] = [(TestType::Mp, "message_passing"), (TestType::War, "write_after_read")];
const CORE11_CASES: [(bool, &str); 2] = [
    // Supported by Vulkan1.1
    (true, "core11"),
    // Requires VK_KHR_vulkan_memory_model extension
    (false, "ext"),
];
const DT_CASES: [(DataType, &str); 4] = [
    // uint32_t atomics
    (DataType::Uint, "u32"),
    // uint64_t atomics
    (DataType::Uint64, "u64"),
    // float32 atomics
    (DataType::Float32, "f32"),
    // float64 atomics
    (DataType::Float64, "f64"),
];
const COH_CASES: [(bool, &str); 2] = [
    // coherent payload variable
    (true, "coherent"),
    // noncoherent payload variable
    (false, "noncoherent"),
];
const ST_CASES: [(SyncType, &str); 9] = [
    // release fence, acquire fence
    (SyncType::FenceFence, "fence_fence"),
    // release fence, atomic acquire
    (SyncType::FenceAtomic, "fence_atomic"),
    // atomic release, acquire fence
    (SyncType::AtomicFence, "atomic_fence"),
    // atomic release, atomic acquire
    (SyncType::AtomicAtomic, "atomic_atomic"),
    // control barrier
    (SyncType::ControlBarrier, "control_barrier"),
    // control barrier with separate memory barriers
    (SyncType::ControlAndMemoryBarrier, "control_and_memory_barrier"),
    // split control barrier with release/acquire
    (SyncType::SplitControlBarrier, "split_control_barrier"),
    // split control barrier with separate memory barriers
    (
        SyncType::SplitControlAndMemoryBarrier,
        "split_control_and_memory_barrier",
    ),
    // split control barrier with barrier
    (
        SyncType::SplitControlBarrierAndBarrier,
        "split_control_barrier_and_barrier",
    ),
];
const RMW_CASES: [(bool, &str); 2] = [(false, "atomicwrite"), (true, "atomicrmw")];
const SCOPE_CASES: [(Scope, &str); 4] = [
    (Scope::Device, "device"),
    (Scope::QueueFamily, "queuefamily"),
    (Scope::Workgroup, "workgroup"),
    (Scope::Subgroup, "subgroup"),
];
const PL_CASES: [(bool, &str); 2] = [
    // payload variable in non-local memory
    (false, "payload_nonlocal"),
    // payload variable in local memory
    (true, "payload_local"),
];
const PSC_CASES: [(StorageClass, &str); 4] = [
    // payload variable in buffer memory
    (StorageClass::Buffer, "buffer"),
    // payload variable in image memory
    (StorageClass::Image, "image"),
    // payload variable in workgroup memory
    (StorageClass::Workgroup, "workgroup"),
    // payload variable in physical storage buffer memory
    (StorageClass::PhysBuffer, "physbuffer"),
];
const GL_CASES: [(bool, &str); 2] = [
    // guard variable in non-local memory
    (false, "guard_nonlocal"),
    // guard variable in local memory
    (true, "guard_local"),
];
const GSC_CASES: [(StorageClass, &str); 4] = [
    // guard variable in buffer memory
    (StorageClass::Buffer, "buffer"),
    // guard variable in image memory
    (StorageClass::Image, "image"),
    // guard variable in workgroup memory
    (StorageClass::Workgroup, "workgroup"),
    // guard variable in physical storage buffer memory
    (StorageClass::PhysBuffer, "physbuffer"),
];
const STAGE_CASES: [(Stage, &str); 3] = [
    (Stage::Compute, "comp"),
    (Stage::Vertex, "vert"),
    (Stage::Fragment, "frag"),
];
const TRANS_VIS_CASES: [(bool, &str); 2] = [
    // destination invocation acquires
    (false, "nontransvis"),
    // invocation 0,0 acquires
    (true, "transvis"),
];

/// The skip filters of `createTests` for the non-transitive cases.
fn is_skipped(c: &CaseDef) -> bool {
    // Mustpass11 tests should only exercise things we expect to work on existing implementations. Exclude noncoherent tests which
    // require new extensions, and assume atomic synchronization wouldn't work (i.e. atomics may be implemented as relaxed atomics).
    // Exclude queuefamily scope which doesn't exist in Vulkan 1.1. Exclude physical storage buffer which doesn't support the legacy
    // decorations.
    if c.core11
        && (!c.coherent
            || matches!(
                c.sync_type,
                SyncType::FenceAtomic | SyncType::AtomicFence | SyncType::AtomicAtomic
            )
            || matches!(c.data_type, DataType::Uint64 | DataType::Float64)
            || c.scope == Scope::QueueFamily
            || c.payload_sc == StorageClass::PhysBuffer
            || c.guard_sc == StorageClass::PhysBuffer)
    {
        return true;
    }

    if c.stage != Stage::Compute && c.scope == Scope::Workgroup {
        return true;
    }

    // Don't exercise local and non-local for workgroup memory
    // Also don't exercise workgroup memory for non-compute stages
    if c.payload_sc == StorageClass::Workgroup && (c.payload_mem_local || c.stage != Stage::Compute) {
        return true;
    }

    if c.guard_sc == StorageClass::Workgroup && (c.guard_mem_local || c.stage != Stage::Compute) {
        return true;
    }

    // No support for control/split barrier with larger than workgroup scope, or non-compute stages
    if (matches!(
        c.sync_type,
        SyncType::ControlBarrier | SyncType::ControlAndMemoryBarrier
    ) || is_split_barrier(c.sync_type))
        && (c.scope == Scope::Device || c.scope == Scope::QueueFamily || c.stage != Stage::Compute)
    {
        return true;
    }

    if c.sync_type == SyncType::SplitControlBarrierAndBarrier && c.scope != Scope::Workgroup {
        return true;
    }

    // Limit RMW atomics to ST_ATOMIC_ATOMIC, just to reduce # of test cases
    if c.atomic_rmw && c.sync_type != SyncType::AtomicAtomic {
        return true;
    }

    // uint64/float32/float64 testing is primarily for atomics, so only test it for ST_ATOMIC_ATOMIC
    let atomic_testing = matches!(c.data_type, DataType::Uint64 | DataType::Float32 | DataType::Float64);
    if atomic_testing && c.sync_type != SyncType::AtomicAtomic {
        return true;
    }

    // No 64-bit image types, so skip tests with both payload and guard in image memory
    if c.data_type == DataType::Uint64 && c.payload_sc == StorageClass::Image && c.guard_sc == StorageClass::Image {
        return true;
    }

    // No support for atomic operations on 64-bit floating point images
    if c.data_type == DataType::Float64 && (c.payload_sc == StorageClass::Image || c.guard_sc == StorageClass::Image) {
        return true;
    }
    // Control barrier tests don't use a guard variable, so only run them with gsc,gl==0
    if matches!(
        c.sync_type,
        SyncType::ControlBarrier | SyncType::ControlAndMemoryBarrier
    ) && (c.guard_sc != StorageClass::Buffer || c.guard_mem_local)
    {
        return true;
    }

    false
}

/// `createTests`, without `padding` and `shared`, which the caller adds; `permuted_index` comes from the Amber conversion.
pub fn create_message_passing_tests() -> Vec<TestCaseGroup> {
    let mut groups = Vec::new();

    for (test_type, tt_name) in TT_CASES {
        let mut tt_group = TestCaseGroup::new(tt_name);
        if test_type == TestType::Mp {
            tt_group.add_child(crate::vkt::tests::spirv_assembly::amber_tests::create_permuted_index_group());
        }
        for (core11, core11_name) in CORE11_CASES {
            let mut core11_group = TestCaseGroup::new(core11_name);
            for (data_type, dt_name) in DT_CASES {
                let mut dt_group = TestCaseGroup::new(dt_name);
                for (coherent, coh_name) in COH_CASES {
                    let mut coh_group = TestCaseGroup::new(coh_name);
                    for (sync_type, st_name) in ST_CASES {
                        let mut st_group = TestCaseGroup::new(st_name);
                        for (atomic_rmw, rmw_name) in RMW_CASES {
                            let mut rmw_group = TestCaseGroup::new(rmw_name);
                            for (scope, scope_name) in SCOPE_CASES {
                                let mut scope_group = TestCaseGroup::new(scope_name);
                                for (payload_mem_local, pl_name) in PL_CASES {
                                    let mut pl_group = TestCaseGroup::new(pl_name);
                                    for (payload_sc, psc_name) in PSC_CASES {
                                        let mut psc_group = TestCaseGroup::new(psc_name);
                                        for (guard_mem_local, gl_name) in GL_CASES {
                                            let mut gl_group = TestCaseGroup::new(gl_name);
                                            for (guard_sc, gsc_name) in GSC_CASES {
                                                let mut gsc_group = TestCaseGroup::new(gsc_name);
                                                for (stage, stage_name) in STAGE_CASES {
                                                    let c = CaseDef {
                                                        payload_mem_local,
                                                        guard_mem_local,
                                                        coherent,
                                                        core11,
                                                        atomic_rmw,
                                                        test_type,
                                                        payload_sc,
                                                        guard_sc,
                                                        scope,
                                                        sync_type,
                                                        stage,
                                                        data_type,
                                                        transitive: false,
                                                        transitive_vis: false,
                                                    };

                                                    if is_skipped(&c) {
                                                        continue;
                                                    }

                                                    gsc_group.add_child(Box::new(MemoryModelTestCase {
                                                        name: stage_name,
                                                        data: c,
                                                    })
                                                        as Box<dyn TestCase>);
                                                }
                                                gl_group.add_child(gsc_group);
                                            }
                                            psc_group.add_child(gl_group);
                                        }
                                        pl_group.add_child(psc_group);
                                    }
                                    scope_group.add_child(pl_group);
                                }
                                rmw_group.add_child(scope_group);
                            }
                            st_group.add_child(rmw_group);
                        }
                        coh_group.add_child(st_group);
                    }
                    dt_group.add_child(coh_group);
                }
                core11_group.add_child(dt_group);
            }
            tt_group.add_child(core11_group);
        }
        groups.push(tt_group);
    }

    let mut trans_group = TestCaseGroup::new("transitive");
    for (coherent, coh_name) in COH_CASES {
        let mut coh_group = TestCaseGroup::new(coh_name);
        for (sync_type, st_name) in ST_CASES {
            let mut st_group = TestCaseGroup::new(st_name);
            for (payload_mem_local, pl_name) in PL_CASES {
                let mut pl_group = TestCaseGroup::new(pl_name);
                for (payload_sc, psc_name) in PSC_CASES {
                    let mut psc_group = TestCaseGroup::new(psc_name);
                    for (guard_mem_local, gl_name) in GL_CASES {
                        let mut gl_group = TestCaseGroup::new(gl_name);
                        for (guard_sc, gsc_name) in GSC_CASES {
                            let mut gsc_group = TestCaseGroup::new(gsc_name);
                            for (transitive_vis, vis_name) in TRANS_VIS_CASES {
                                let c = CaseDef {
                                    payload_mem_local,
                                    guard_mem_local,
                                    coherent,
                                    core11: false,
                                    atomic_rmw: false,
                                    test_type: TestType::Mp,
                                    payload_sc,
                                    guard_sc,
                                    scope: Scope::Device,
                                    sync_type,
                                    stage: Stage::Compute,
                                    data_type: DataType::Uint,
                                    transitive: true,
                                    transitive_vis,
                                };
                                if c.payload_sc == StorageClass::Workgroup || c.guard_sc == StorageClass::Workgroup {
                                    continue;
                                }
                                if matches!(
                                    c.sync_type,
                                    SyncType::ControlBarrier | SyncType::ControlAndMemoryBarrier
                                ) || is_split_barrier(c.sync_type)
                                {
                                    continue;
                                }
                                gsc_group.add_child(Box::new(MemoryModelTestCase {
                                    name: vis_name,
                                    data: c,
                                }) as Box<dyn TestCase>);
                            }
                            gl_group.add_child(gsc_group);
                        }
                        psc_group.add_child(gl_group);
                    }
                    pl_group.add_child(psc_group);
                }
                st_group.add_child(pl_group);
            }
            coh_group.add_child(st_group);
        }
        trans_group.add_child(coh_group);
    }
    groups.push(trans_group);

    groups
}
