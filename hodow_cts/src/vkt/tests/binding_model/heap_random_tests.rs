// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/binding_model/vktBindingDescriptorHeapRandomTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `initPrograms` draws the random layout of a case from `de::Random(seed)` and builds the GLSL from it;
// scripts/gen_heap_random_manifest.py replays those draws, so the shader of every case is a manifest entry (`heap_random_programs.rs` maps a seed
// to it) and the layout the instance needs is a column of `heap_random_cases/cases.txt` instead of a second run of `generateRandomLayout`.
//
// Randomly generated descriptor layouts driven through descriptor heaps: every descriptor is backed by a value equal to its global index, the shader
// reads each one it checks and accumulates the mismatch, then writes a pass/fail texel; some storage descriptors are written by the shader and
// verified on the host.

use std::collections::HashMap;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_2, ExtDescriptorHeapExtensionDeviceCommands, InstanceV1_1};

use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::gated::build_gated_groups_with;
use crate::vkt::tests::binding_model::heap_random_programs::PROGRAM_TABLE;
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const CASE_LINES: &str = include_str!("heap_random_cases/cases.txt");

const DIM: u32 = 8;

#[derive(Clone, Copy, PartialEq, Eq)]
enum IndexType {
    None,
    Constant,
    PushConstant,
    Dependent,
    RuntimeSize,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum Stage {
    Compute,
    Vertex,
    Fragment,
}

/// One binding of the random layout that has descriptors (`descriptorCount != 0`), in set and binding order.
struct BindingDef {
    set: u32,
    binding: u32,
    kind: u8,
    array_size: u32,
    shader_binding: u32,
}

impl BindingDef {
    fn count(&self) -> u32 {
        self.array_size.max(1)
    }

    fn descriptor_type(&self) -> vk::DescriptorType {
        match self.kind {
            b'U' => vk::DescriptorType::UNIFORM_BUFFER,
            b'S' => vk::DescriptorType::STORAGE_BUFFER,
            b'X' => vk::DescriptorType::STORAGE_TEXEL_BUFFER,
            b'I' => vk::DescriptorType::STORAGE_IMAGE,
            b'T' => vk::DescriptorType::UNIFORM_TEXEL_BUFFER,
            b'C' => vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
            _ => vk::DescriptorType::INPUT_ATTACHMENT,
        }
    }
}

/// `DescriptorId` with its `WriteInfo`.
struct WriteDef {
    set: u32,
    binding: u32,
    number: u32,
    generated: bool,
}

/// `CaseDef` and the `RandomLayout` of its seed.
struct CaseDef {
    seed: u32,
    index_type: IndexType,
    num_descriptor_sets: u32,
    max_per_stage_uniform_buffers: u32,
    max_per_stage_storage_buffers: u32,
    max_per_stage_sampled_images: u32,
    max_per_stage_storage_images: u32,
    max_per_stage_storage_texel_buffers: u32,
    max_per_stage_input_attachments: u32,
    stage: Stage,
    bindings: Vec<BindingDef>,
    writes: Vec<WriteDef>,
}

fn parse_numbers<const N: usize>(text: &str) -> [u32; N] {
    let mut numbers = [0u32; N];
    for (slot, part) in numbers.iter_mut().zip(text.split('.')) {
        *slot = part.parse().expect("a number in cases.txt");
    }
    numbers
}

fn parse_case(line: &str) -> (String, CaseDef) {
    let fields: Vec<&str> = line.split('|').collect();
    let number = |index: usize| -> u32 { fields[index].parse().expect("a number in cases.txt") };

    let bindings = fields[11]
        .split(',')
        .filter(|entry| !entry.is_empty())
        .map(|entry| {
            let parts: Vec<&str> = entry.split('.').collect();
            BindingDef {
                set: parts[0].parse().expect("set"),
                binding: parts[1].parse().expect("binding"),
                kind: parts[2].as_bytes()[0],
                array_size: parts[3].parse().expect("array size"),
                shader_binding: parts[4].parse().expect("shader binding"),
            }
        })
        .collect();
    let writes = fields[12]
        .split(',')
        .filter(|entry| !entry.is_empty())
        .map(|entry| {
            let [set, binding, number, generated] = parse_numbers::<4>(entry);
            WriteDef {
                set,
                binding,
                number,
                generated: generated != 0,
            }
        })
        .collect();

    let def = CaseDef {
        seed: number(1),
        index_type: match number(2) {
            0 => IndexType::None,
            1 => IndexType::Constant,
            2 => IndexType::PushConstant,
            3 => IndexType::Dependent,
            _ => IndexType::RuntimeSize,
        },
        num_descriptor_sets: number(3),
        max_per_stage_uniform_buffers: number(4),
        max_per_stage_storage_buffers: number(5),
        max_per_stage_sampled_images: number(6),
        max_per_stage_storage_images: number(7),
        max_per_stage_storage_texel_buffers: number(8),
        max_per_stage_input_attachments: number(9),
        stage: match number(10) {
            0 => Stage::Compute,
            1 => Stage::Vertex,
            _ => Stage::Fragment,
        },
        bindings,
        writes,
    };
    (fields[0].to_string(), def)
}

/// `DescriptorHeapRandomCase`
struct DescriptorHeapRandomCase {
    name: String,
    data: CaseDef,
}

impl TestCase for DescriptorHeapRandomCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_descriptor_heap")?;
        context.require_device_functionality("VK_KHR_shader_untyped_pointers")?;
        context.require_device_functionality("VK_KHR_maintenance5")?;
        context.require_device_functionality("VK_KHR_buffer_device_address")?;

        let mut descriptor_heap_features = vk::PhysicalDeviceDescriptorHeapFeaturesEXT::default();
        let mut vulkan12_features = vk::PhysicalDeviceVulkan12Features::default();
        {
            let mut features2 = vk::PhysicalDeviceFeatures2::builder()
                .push_next(&mut descriptor_heap_features)
                .push_next(&mut vulkan12_features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
        }
        if descriptor_heap_features.descriptor_heap == vk::FALSE {
            return Err(TestError::NotSupported("descriptorHeap is not supported".to_string()));
        }

        let data = &self.data;
        let features = context.get_device_features();
        let limits = &context.get_device_properties().limits;

        if data.num_descriptor_sets > limits.max_bound_descriptor_sets {
            return Err(TestError::NotSupported(
                "Not enough bound descriptor sets supported".to_string(),
            ));
        }

        let not_supported = |message: &str| Err(TestError::NotSupported(message.to_string()));

        if matches!(
            data.index_type,
            IndexType::PushConstant | IndexType::Dependent | IndexType::RuntimeSize
        ) {
            if data.max_per_stage_uniform_buffers > 0
                && features.shader_uniform_buffer_array_dynamic_indexing == vk::FALSE
            {
                return not_supported("shaderUniformBufferArrayDynamicIndexing not supported");
            }
            if data.max_per_stage_storage_buffers > 0
                && features.shader_storage_buffer_array_dynamic_indexing == vk::FALSE
            {
                return not_supported("shaderStorageBufferArrayDynamicIndexing not supported");
            }
            if data.max_per_stage_sampled_images > 0
                && vulkan12_features.shader_uniform_texel_buffer_array_dynamic_indexing == vk::FALSE
            {
                return not_supported("shaderUniformTexelBufferArrayDynamicIndexing not supported");
            }
            // Combined image samplers share the sampled-image budget and may be dynamically indexed.
            if data.max_per_stage_sampled_images > 0
                && features.shader_sampled_image_array_dynamic_indexing == vk::FALSE
            {
                return not_supported("shaderSampledImageArrayDynamicIndexing not supported");
            }
            if data.max_per_stage_storage_texel_buffers > 0
                && vulkan12_features.shader_storage_texel_buffer_array_dynamic_indexing == vk::FALSE
            {
                return not_supported("shaderStorageTexelBufferArrayDynamicIndexing not supported");
            }
            // The output storage image is never array-indexed, so only guard when more than one is present.
            if data.max_per_stage_storage_images > 1
                && features.shader_storage_image_array_dynamic_indexing == vk::FALSE
            {
                return not_supported("shaderStorageImageArrayDynamicIndexing not supported");
            }
        }

        if data.index_type == IndexType::RuntimeSize && vulkan12_features.runtime_descriptor_array == vk::FALSE {
            return not_supported("runtimeDescriptorArray not supported");
        }

        if data.stage == Stage::Vertex && features.vertex_pipeline_stores_and_atomics == vk::FALSE {
            return not_supported("vertexPipelineStoresAndAtomics not supported");
        }
        if data.stage == Stage::Fragment && features.fragment_stores_and_atomics == vk::FALSE {
            return not_supported("fragmentStoresAndAtomics not supported");
        }

        if data.max_per_stage_input_attachments > limits.max_per_stage_descriptor_input_attachments {
            return not_supported("maxPerStageDescriptorInputAttachments too low");
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        PROGRAM_TABLE[self.data.seed as usize].programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DescriptorHeapRandomInstance {
            context,
            data: &self.data,
        })
    }
}

struct DescriptorHeapRandomInstance<'a> {
    context: &'a Context<'a>,
    data: &'a CaseDef,
}

/// `HeapBuffer` - a host-visible buffer with a queryable device address, usable as a descriptor heap or backing store.
struct HeapBuffer<'a> {
    buffer: BufferWithMemory<'a>,
    alloc_size: vk::DeviceSize,
}

impl<'a> HeapBuffer<'a> {
    /// `createHeapBuffer`: the usage is given as `VkBufferUsageFlags2`, with the device address bit added.
    fn new(
        device: &'a Device,
        context: &Context<'_>,
        size: vk::DeviceSize,
        usage: vk::BufferUsageFlags2,
    ) -> Result<Self, TestError> {
        let flags2 = vk::BufferUsageFlags2CreateInfo {
            usage: usage | vk::BufferUsageFlags2::SHADER_DEVICE_ADDRESS,
            ..Default::default()
        };
        let mut create_info = make_buffer_create_info(size, vk::BufferUsageFlags::empty());
        create_info.next = (&flags2 as *const vk::BufferUsageFlags2CreateInfo).cast();
        let buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            create_info,
            MemoryRequirement::HOST_VISIBLE | MemoryRequirement::DEVICE_ADDRESS,
        )?;
        let alloc_size = unsafe { device.get_buffer_memory_requirements(buffer.get()) }.size;
        Ok(Self { buffer, alloc_size })
    }

    fn get(&self) -> vk::Buffer {
        self.buffer.get()
    }

    fn device_address(&self, device: &Device) -> vk::DeviceAddress {
        let info = vk::BufferDeviceAddressInfo::builder().buffer(self.buffer.get());
        unsafe { device.get_buffer_device_address(&info) }
    }

    fn bytes(&self) -> &[u8] {
        unsafe { std::slice::from_raw_parts(self.buffer.get_allocation().get_host_ptr(), self.alloc_size as usize) }
    }

    fn flush(&self, device: &Device) -> Result<(), TestError> {
        flush_alloc(device, self.buffer.get_allocation())
    }
}

/// `ValueImage`
struct ValueImage<'a> {
    image: ImageWithMemory<'a>,
    descriptor: u32,
    is_write: bool,
}

/// `createValueImage`
fn create_value_image<'a>(
    context: &Context<'_>,
    device: &'a Device,
    width: u32,
    height: u32,
    usage: vk::ImageUsageFlags,
) -> Result<ValueImage<'a>, TestError> {
    let create_info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(vk::Format::R32_SINT)
        .extent(vk::Extent3D {
            width,
            height,
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
    Ok(ValueImage {
        image: ImageWithMemory::new(
            device,
            context.get_default_allocator(),
            create_info,
            MemoryRequirement::ANY,
        )?,
        descriptor: 0,
        is_write: false,
    })
}

/// `makeStorageImageViewInfo`
fn make_storage_image_view_info(image: vk::Image) -> vk::ImageViewCreateInfo {
    vk::ImageViewCreateInfo::builder()
        .image(image)
        .view_type(vk::ImageViewType::_2D)
        .format(vk::Format::R32_SINT)
        .components(vk::ComponentMapping {
            r: vk::ComponentSwizzle::R,
            g: vk::ComponentSwizzle::G,
            b: vk::ComponentSwizzle::B,
            a: vk::ComponentSwizzle::A,
        })
        .subresource_range(color_subresource_range())
        .build()
}

fn color_subresource_range() -> vk::ImageSubresourceRange {
    vk::ImageSubresourceRange {
        aspect_mask: vk::ImageAspectFlags::COLOR,
        base_mip_level: 0,
        level_count: 1,
        base_array_layer: 0,
        layer_count: 1,
    }
}

fn align_up(value: u64, alignment: u64) -> u64 {
    value.div_ceil(alignment.max(1)) * alignment.max(1)
}

fn image_barrier(
    src_access: vk::AccessFlags,
    dst_access: vk::AccessFlags,
    old_layout: vk::ImageLayout,
    new_layout: vk::ImageLayout,
    image: vk::Image,
) -> vk::ImageMemoryBarrier {
    vk::ImageMemoryBarrier::builder()
        .src_access_mask(src_access)
        .dst_access_mask(dst_access)
        .old_layout(old_layout)
        .new_layout(new_layout)
        .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
        .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
        .image(image)
        .subresource_range(color_subresource_range())
        .build()
}

/// `ClearInfo`
struct ClearInfo {
    image: vk::Image,
    value: i32,
    final_layout: vk::ImageLayout,
}

/// Where the data of a heap descriptor comes from, as an index into the matching list.
enum DescriptorSource {
    Address(usize),
    Texel(usize),
    Image(usize),
}

impl TestInstance for DescriptorHeapRandomInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let data = self.data;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let limits = &context.get_device_properties().limits;

        let mut heap_properties = vk::PhysicalDeviceDescriptorHeapPropertiesEXT::default();
        {
            let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut heap_properties);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
            };
        }

        let resource_stride = align_up(
            heap_properties.buffer_descriptor_size,
            heap_properties.buffer_descriptor_alignment,
        )
        .max(align_up(
            heap_properties.image_descriptor_size,
            heap_properties.image_descriptor_alignment,
        ));

        // Slot size for the backing store; each descriptor stores its index at the start of its slot.
        let value_align = limits
            .min_uniform_buffer_offset_alignment
            .max(limits.min_storage_buffer_offset_alignment)
            .max(limits.min_texel_buffer_offset_alignment.max(4));

        // First pass: the global descriptor index of the first element of each binding.
        let mut binding_start: HashMap<(u32, u32), u32> = HashMap::new();
        let mut num_descriptors = 0u32;
        for binding in &data.bindings {
            binding_start.insert((binding.set, binding.binding), num_descriptors);
            num_descriptors += binding.count();
        }
        assert!(num_descriptors > 0);

        // Backing store: one value slot per descriptor.
        let backing_buffer = HeapBuffer::new(
            device,
            context,
            value_align * u64::from(num_descriptors),
            vk::BufferUsageFlags2::UNIFORM_BUFFER
                | vk::BufferUsageFlags2::STORAGE_BUFFER
                | vk::BufferUsageFlags2::UNIFORM_TEXEL_BUFFER
                | vk::BufferUsageFlags2::STORAGE_TEXEL_BUFFER,
        )?;
        let backing_host_ptr = backing_buffer.buffer.get_allocation().get_host_ptr();
        let backing_address = backing_buffer.device_address(device);
        let write_backing_value = |descriptor: u32, value: i32| unsafe {
            backing_host_ptr
                .add((value_align * u64::from(descriptor)) as usize)
                .cast::<i32>()
                .write_unaligned(value)
        };
        let read_backing_value = |descriptor: u32| unsafe {
            backing_host_ptr
                .add((value_align * u64::from(descriptor)) as usize)
                .cast::<i32>()
                .read_unaligned()
        };

        // Resource heap.
        let heap_user_size = align_up(
            resource_stride * u64::from(num_descriptors),
            heap_properties.resource_heap_alignment,
        );
        let heap_size = heap_user_size + heap_properties.min_resource_heap_reserved_range;
        let resource_heap = HeapBuffer::new(device, context, heap_size, vk::BufferUsageFlags2::DESCRIPTOR_HEAP_EXT)?;
        let resource_heap_host_ptr = resource_heap.buffer.get_allocation().get_host_ptr();

        let storage_image_usage =
            vk::ImageUsageFlags::STORAGE | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;
        let sampled_image_usage = vk::ImageUsageFlags::SAMPLED | vk::ImageUsageFlags::TRANSFER_DST;
        let input_attachment_usage = vk::ImageUsageFlags::INPUT_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_DST;

        // Output image (descriptor 0).
        let output_image = create_value_image(context, device, DIM, DIM, storage_image_usage)?;

        let mut view_infos: Vec<vk::ImageViewCreateInfo> = Vec::new();
        let mut image_infos: Vec<vk::ImageDescriptorInfoEXT> = Vec::new();
        let mut texel_infos: Vec<vk::TexelBufferDescriptorInfoEXT> = Vec::new();
        let mut address_ranges: Vec<vk::DeviceAddressRangeEXT> = Vec::new();
        let mut pending: Vec<(vk::DescriptorType, DescriptorSource)> = Vec::new();
        let mut resource_dests: Vec<vk::HostAddressRangeEXT> = Vec::new();

        let mut storage_images: Vec<ValueImage<'_>> = Vec::new();
        let mut sampled_images: Vec<ValueImage<'_>> = Vec::new();
        let mut input_attachment_images: Vec<ValueImage<'_>> = Vec::new();
        let mut input_attachment_views: Vec<Unique<'_, vk::ImageView>> = Vec::new();
        let mut image_clears: Vec<ClearInfo> = Vec::new();
        let mut uses_sampler = false;

        // Second pass: create resources, fill backing values, build heap descriptors.
        let mut descriptor = 0u32;
        for binding in &data.bindings {
            for ai in 0..binding.count() {
                let is_write = data
                    .writes
                    .iter()
                    .any(|write| write.set == binding.set && write.binding == binding.binding && write.number == ai);
                let value = if is_write { -1 } else { descriptor as i32 };

                resource_dests.push(vk::HostAddressRangeEXT {
                    address: unsafe { resource_heap_host_ptr.add((u64::from(descriptor) * resource_stride) as usize) }
                        .cast(),
                    size: resource_stride as usize,
                });

                let output_image_slot = binding.set == 0 && binding.binding == 0;

                match binding.kind {
                    b'U' | b'S' => {
                        write_backing_value(descriptor, value);
                        address_ranges.push(vk::DeviceAddressRangeEXT {
                            address: backing_address + u64::from(descriptor) * value_align,
                            size: value_align,
                        });
                        pending.push((
                            binding.descriptor_type(),
                            DescriptorSource::Address(address_ranges.len() - 1),
                        ));
                    }
                    b'T' | b'X' => {
                        write_backing_value(descriptor, value);
                        texel_infos.push(vk::TexelBufferDescriptorInfoEXT {
                            format: vk::Format::R32_SINT,
                            address_range: vk::DeviceAddressRangeEXT {
                                address: backing_address + u64::from(descriptor) * value_align,
                                size: value_align,
                            },
                            ..Default::default()
                        });
                        pending.push((
                            binding.descriptor_type(),
                            DescriptorSource::Texel(texel_infos.len() - 1),
                        ));
                    }
                    b'I' => {
                        let image = if output_image_slot {
                            let image = output_image.image.get();
                            // Output image cleared to 0.
                            image_clears.push(ClearInfo {
                                image,
                                value: 0,
                                final_layout: vk::ImageLayout::GENERAL,
                            });
                            image
                        } else {
                            let mut value_image = create_value_image(context, device, 1, 1, storage_image_usage)?;
                            value_image.descriptor = descriptor;
                            value_image.is_write = is_write;
                            let image = value_image.image.get();
                            image_clears.push(ClearInfo {
                                image,
                                value,
                                final_layout: vk::ImageLayout::GENERAL,
                            });
                            storage_images.push(value_image);
                            image
                        };

                        view_infos.push(make_storage_image_view_info(image));
                        image_infos.push(vk::ImageDescriptorInfoEXT {
                            layout: vk::ImageLayout::GENERAL,
                            ..Default::default()
                        });
                        pending.push((
                            vk::DescriptorType::STORAGE_IMAGE,
                            DescriptorSource::Image(image_infos.len() - 1),
                        ));
                    }
                    b'C' => {
                        // Read-only sampled image; the sampler comes from the sampler heap (shared slot 0).
                        let mut value_image = create_value_image(context, device, 1, 1, sampled_image_usage)?;
                        value_image.descriptor = descriptor;
                        let image = value_image.image.get();
                        image_clears.push(ClearInfo {
                            image,
                            value,
                            final_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                        });
                        sampled_images.push(value_image);

                        view_infos.push(make_storage_image_view_info(image));
                        image_infos.push(vk::ImageDescriptorInfoEXT {
                            layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                            ..Default::default()
                        });
                        pending.push((
                            vk::DescriptorType::SAMPLED_IMAGE,
                            DescriptorSource::Image(image_infos.len() - 1),
                        ));
                        uses_sampler = true;
                    }
                    _ => {
                        // DIM x DIM read-only image, pre-cleared to the descriptor index and used both as a render-pass input
                        // attachment and as the heap descriptor read via subpassLoad.
                        let mut value_image = create_value_image(context, device, DIM, DIM, input_attachment_usage)?;
                        value_image.descriptor = descriptor;
                        let image = value_image.image.get();
                        image_clears.push(ClearInfo {
                            image,
                            value,
                            final_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                        });

                        // Live view for the framebuffer (in input_attachment_index order).
                        input_attachment_views.push(make_image_view(
                            device,
                            image,
                            vk::ImageViewType::_2D,
                            vk::Format::R32_SINT,
                            color_subresource_range(),
                        )?);
                        input_attachment_images.push(value_image);

                        view_infos.push(make_storage_image_view_info(image));
                        image_infos.push(vk::ImageDescriptorInfoEXT {
                            layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                            ..Default::default()
                        });
                        pending.push((
                            vk::DescriptorType::INPUT_ATTACHMENT,
                            DescriptorSource::Image(image_infos.len() - 1),
                        ));
                    }
                }
                descriptor += 1;
            }
        }

        // The lists no longer grow, so the pointers into them stay valid.
        for (info, view_info) in image_infos.iter_mut().zip(&view_infos) {
            info.view = view_info;
        }
        let resource_infos: Vec<vk::ResourceDescriptorInfoEXT> = pending
            .iter()
            .map(|(descriptor_type, source)| vk::ResourceDescriptorInfoEXT {
                type_: *descriptor_type,
                data: match source {
                    DescriptorSource::Address(index) => vk::ResourceDescriptorDataEXT {
                        address_range: &address_ranges[*index],
                    },
                    DescriptorSource::Texel(index) => vk::ResourceDescriptorDataEXT {
                        texel_buffer: &texel_infos[*index],
                    },
                    DescriptorSource::Image(index) => vk::ResourceDescriptorDataEXT {
                        image: &image_infos[*index],
                    },
                },
                ..Default::default()
            })
            .collect();

        unsafe { device.write_resource_descriptors_ext(&resource_infos[..], &resource_dests[..]) }
            .vk_check("vkWriteResourceDescriptorsEXT")?;
        resource_heap.flush(device)?;
        backing_buffer.flush(device)?;

        // Build one mapping per binding.
        let mappings: Vec<vk::DescriptorSetAndBindingMappingEXT> = data
            .bindings
            .iter()
            .map(|binding| vk::DescriptorSetAndBindingMappingEXT {
                descriptor_set: binding.set,
                first_binding: binding.shader_binding,
                binding_count: binding.count(),
                resource_mask: vk::SpirvResourceTypeFlagsEXT::ALL,
                source: vk::DescriptorMappingSourceEXT::HEAP_WITH_CONSTANT_OFFSET,
                source_data: vk::DescriptorMappingSourceDataEXT {
                    constant_offset: vk::DescriptorMappingSourceConstantOffsetEXT {
                        heap_offset: (u64::from(binding_start[&(binding.set, binding.binding)]) * resource_stride)
                            as u32,
                        heap_array_stride: resource_stride as u32,
                        ..Default::default()
                    },
                },
                ..Default::default()
            })
            .collect();

        // Pipeline (no pipeline layout; descriptors come from the heap). The same mapping info is chained into every shader stage.
        let mapping_info = vk::ShaderDescriptorSetAndBindingMappingInfoEXT {
            mapping_count: mappings.len() as u32,
            mappings: mappings.as_ptr(),
            ..Default::default()
        };
        let pipeline_flags2 = vk::PipelineCreateFlags2CreateInfo {
            flags: vk::PipelineCreateFlags2::DESCRIPTOR_HEAP_EXT,
            ..Default::default()
        };

        let binaries = context.get_binary_collection();
        let main_module = create_shader_module(device, binaries.get("test")?)?;
        let mut vert_module = None;
        let mut render_pass: Option<Unique<'_, vk::RenderPass>> = None;
        let mut framebuffer: Option<Unique<'_, vk::Framebuffer>> = None;

        let pipeline: Unique<'_, vk::Pipeline> = if data.stage == Stage::Compute {
            let mut stage = vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::COMPUTE)
                .module(*main_module)
                .name(b"main\0")
                .build();
            stage.next = (&mapping_info as *const vk::ShaderDescriptorSetAndBindingMappingInfoEXT).cast();

            let mut pipeline_info = vk::ComputePipelineCreateInfo::builder()
                .stage(stage)
                .layout(vk::PipelineLayout::null())
                .base_pipeline_index(0)
                .build();
            pipeline_info.next = (&pipeline_flags2 as *const vk::PipelineCreateFlags2CreateInfo).cast();

            Unique::new(
                device,
                unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
                    .vk_check("vkCreateComputePipelines")?
                    .0[0],
            )
        } else {
            // The shader writes the output via a storage image, so the render pass has no color attachments. Any input attachments
            // are pre-cleared images read via subpassLoad; they are the only render-pass attachments (loadOp LOAD, kept in
            // SHADER_READ_ONLY_OPTIMAL).
            let num_input_attachments = input_attachment_views.len() as u32;

            let attachment_descs: Vec<vk::AttachmentDescription> = (0..num_input_attachments)
                .map(|_| {
                    vk::AttachmentDescription::builder()
                        .format(vk::Format::R32_SINT)
                        .samples(vk::SampleCountFlags::_1)
                        .load_op(vk::AttachmentLoadOp::LOAD)
                        .store_op(vk::AttachmentStoreOp::DONT_CARE)
                        .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                        .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                        .initial_layout(vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL)
                        .final_layout(vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL)
                        .build()
                })
                .collect();
            let input_refs: Vec<vk::AttachmentReference> = (0..num_input_attachments)
                .map(|attachment| vk::AttachmentReference {
                    attachment,
                    layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                })
                .collect();
            let framebuffer_views: Vec<vk::ImageView> = input_attachment_views.iter().map(|view| **view).collect();

            let subpasses = [vk::SubpassDescription::builder()
                .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                .input_attachments(&input_refs)
                .build()];
            let render_pass_info = vk::RenderPassCreateInfo::builder()
                .attachments(&attachment_descs)
                .subpasses(&subpasses);
            let created_render_pass = Unique::new(
                device,
                unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
            );

            let framebuffer_info = vk::FramebufferCreateInfo::builder()
                .render_pass(*created_render_pass)
                .attachments(&framebuffer_views)
                .width(DIM)
                .height(DIM)
                .layers(1);
            let created_framebuffer = Unique::new(
                device,
                unsafe { device.create_framebuffer(&framebuffer_info, None) }.vk_check("vkCreateFramebuffer")?,
            );

            let mut pipeline_state = DrawPipelineState::new(if data.stage == Stage::Vertex {
                vk::PrimitiveTopology::POINT_LIST
            } else {
                vk::PrimitiveTopology::TRIANGLE_LIST
            })
            .with_full_viewport(DIM, DIM);
            pipeline_state.color_attachment_count = 0;
            pipeline_state.rasterization.depth_bias_enable = vk::FALSE;
            pipeline_state.rasterization.rasterizer_discard_enable = if data.stage == Stage::Vertex {
                vk::TRUE
            } else {
                vk::FALSE
            };
            pipeline_state.create_flags2 = Some(vk::PipelineCreateFlags2::DESCRIPTOR_HEAP_EXT);
            pipeline_state.descriptor_heap_mappings = Some(mappings.clone());

            let created_pipeline = if data.stage == Stage::Vertex {
                create_draw_pipeline(
                    device,
                    vk::PipelineLayout::null(),
                    *created_render_pass,
                    &[(vk::ShaderStageFlags::VERTEX, *main_module)],
                    &pipeline_state,
                )?
            } else {
                let created_vert_module = create_shader_module(device, binaries.get("vert")?)?;
                let created_pipeline = create_draw_pipeline(
                    device,
                    vk::PipelineLayout::null(),
                    *created_render_pass,
                    &[
                        (vk::ShaderStageFlags::VERTEX, *created_vert_module),
                        (vk::ShaderStageFlags::FRAGMENT, *main_module),
                    ],
                    &pipeline_state,
                )?;
                vert_module = Some(created_vert_module);
                created_pipeline
            };
            render_pass = Some(created_render_pass);
            framebuffer = Some(created_framebuffer);
            created_pipeline
        };
        let _vert_module = vert_module;

        let shader_stage = match data.stage {
            Stage::Compute => vk::PipelineStageFlags::COMPUTE_SHADER,
            Stage::Vertex => vk::PipelineStageFlags::VERTEX_SHADER,
            Stage::Fragment => vk::PipelineStageFlags::FRAGMENT_SHADER,
        };
        let bind_point = if data.stage == Stage::Compute {
            vk::PipelineBindPoint::COMPUTE
        } else {
            vk::PipelineBindPoint::GRAPHICS
        };

        // Output copy buffer and per-write-image readback buffer.
        let copy_buffer_size = u64::from(DIM * DIM) * 4;
        let copy_buffer = HeapBuffer::new(device, context, copy_buffer_size, vk::BufferUsageFlags2::TRANSFER_DST)?;

        let write_images: Vec<&ValueImage<'_>> = storage_images.iter().filter(|image| image.is_write).collect();
        let readback_size = write_images.len().max(1) as u64 * 4;
        let readback_buffer = HeapBuffer::new(device, context, readback_size, vk::BufferUsageFlags2::TRANSFER_DST)?;

        let resource_heap_bind_info = vk::BindHeapInfoEXT {
            heap_range: vk::DeviceAddressRangeEXT {
                address: resource_heap.device_address(device),
                size: heap_size,
            },
            reserved_range_offset: heap_user_size,
            reserved_range_size: heap_properties.min_resource_heap_reserved_range,
            ..Default::default()
        };

        // Sampler heap with a single shared nearest sampler at slot 0, referenced by all combined image samplers (their mappings use
        // the default samplerHeapOffset = 0).
        let mut sampler_heap: Option<HeapBuffer<'_>> = None;
        let mut sampler_heap_bind_info = vk::BindHeapInfoEXT::default();
        if uses_sampler {
            let sampler_stride = align_up(
                heap_properties.sampler_descriptor_size,
                heap_properties.sampler_descriptor_alignment,
            );
            let sampler_user_size = align_up(sampler_stride, heap_properties.sampler_heap_alignment);
            let sampler_heap_size = sampler_user_size + heap_properties.min_sampler_heap_reserved_range;

            let heap = HeapBuffer::new(
                device,
                context,
                sampler_heap_size,
                vk::BufferUsageFlags2::DESCRIPTOR_HEAP_EXT,
            )?;

            let sampler_create_info = vk::SamplerCreateInfo::builder()
                .mag_filter(vk::Filter::NEAREST)
                .min_filter(vk::Filter::NEAREST)
                .mipmap_mode(vk::SamplerMipmapMode::NEAREST)
                .address_mode_u(vk::SamplerAddressMode::CLAMP_TO_EDGE)
                .address_mode_v(vk::SamplerAddressMode::CLAMP_TO_EDGE)
                .address_mode_w(vk::SamplerAddressMode::CLAMP_TO_EDGE)
                .max_anisotropy(1.0)
                .compare_op(vk::CompareOp::NEVER)
                .border_color(vk::BorderColor::INT_OPAQUE_BLACK)
                .unnormalized_coordinates(false)
                .build();
            let sampler_dst = vk::HostAddressRangeEXT {
                address: heap.buffer.get_allocation().get_host_ptr().cast(),
                size: sampler_stride as usize,
            };
            unsafe { device.write_sampler_descriptors_ext(&[sampler_create_info], &[sampler_dst]) }
                .vk_check("vkWriteSamplerDescriptorsEXT")?;
            heap.flush(device)?;

            sampler_heap_bind_info = vk::BindHeapInfoEXT {
                heap_range: vk::DeviceAddressRangeEXT {
                    address: heap.device_address(device),
                    size: sampler_heap_size,
                },
                reserved_range_offset: sampler_user_size,
                reserved_range_size: heap_properties.min_sampler_heap_reserved_range,
                ..Default::default()
            };
            sampler_heap = Some(heap);
        }
        let _sampler_heap = sampler_heap;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer_owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer_owner;

        begin_command_buffer(device, cmd)?;

        // Transition every cleared image UNDEFINED -> TRANSFER_DST.
        {
            let pre_clear: Vec<vk::ImageMemoryBarrier> = image_clears
                .iter()
                .map(|clear| {
                    image_barrier(
                        vk::AccessFlags::empty(),
                        vk::AccessFlags::TRANSFER_WRITE,
                        vk::ImageLayout::UNDEFINED,
                        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                        clear.image,
                    )
                })
                .collect();
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &pre_clear,
                );
            }
        }

        for clear in &image_clears {
            let clear_value = vk::ClearColorValue {
                int32: [clear.value, 0, 0, 0],
            };
            unsafe {
                device.cmd_clear_color_image(
                    cmd,
                    clear.image,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &clear_value,
                    &[color_subresource_range()],
                );
            }
        }

        // Clears (transfer writes) -> shader access, transitioning each image to its final layout.
        {
            // Input attachments (fragment only) are additionally read as INPUT_ATTACHMENT_READ.
            let read_only_access = if data.stage == Stage::Fragment {
                vk::AccessFlags::SHADER_READ | vk::AccessFlags::INPUT_ATTACHMENT_READ
            } else {
                vk::AccessFlags::SHADER_READ
            };

            let post_clear: Vec<vk::ImageMemoryBarrier> = image_clears
                .iter()
                .map(|clear| {
                    let dst_access = if clear.final_layout == vk::ImageLayout::GENERAL {
                        vk::AccessFlags::SHADER_READ | vk::AccessFlags::SHADER_WRITE
                    } else {
                        read_only_access
                    };
                    image_barrier(
                        vk::AccessFlags::TRANSFER_WRITE,
                        dst_access,
                        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                        clear.final_layout,
                        clear.image,
                    )
                })
                .collect();
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    shader_stage,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &post_clear,
                );
            }
        }

        unsafe {
            device.cmd_bind_resource_heap_ext(cmd, &resource_heap_bind_info);
            if uses_sampler {
                device.cmd_bind_sampler_heap_ext(cmd, &sampler_heap_bind_info);
            }
        }

        // Push the identity index array consumed by unifindexed shaders (identity[i] == i).
        let push_identity: Vec<i32> = (0..32).collect();
        if data.index_type == IndexType::PushConstant {
            let push_data_info = vk::PushDataInfoEXT {
                offset: 0,
                data: vk::HostAddressRangeConstEXT {
                    address: push_identity.as_ptr().cast(),
                    size: push_identity.len() * 4,
                },
                ..Default::default()
            };
            unsafe { device.cmd_push_data_ext(cmd, &push_data_info) };
        }

        unsafe { device.cmd_bind_pipeline(cmd, bind_point, *pipeline) };

        if data.stage == Stage::Compute {
            unsafe { device.cmd_dispatch(cmd, DIM, DIM, 1) };
        } else {
            let render_area = vk::Rect2D {
                offset: vk::Offset2D { x: 0, y: 0 },
                extent: vk::Extent2D {
                    width: DIM,
                    height: DIM,
                },
            };
            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(**render_pass.as_ref().expect("a graphics stage has a render pass"))
                .framebuffer(**framebuffer.as_ref().expect("a graphics stage has a framebuffer"))
                .render_area(render_area);
            unsafe {
                device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
                // One point per invocation for the vertex stage; a full-screen triangle for the fragment stage.
                device.cmd_draw(cmd, if data.stage == Stage::Vertex { DIM * DIM } else { 3 }, 1, 0, 0);
                device.cmd_end_render_pass(cmd);
            }
        }

        // Shader writes -> transfer reads / host reads.
        {
            let mut post_dispatch = vec![image_barrier(
                vk::AccessFlags::SHADER_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::GENERAL,
                vk::ImageLayout::GENERAL,
                output_image.image.get(),
            )];
            for image in &write_images {
                post_dispatch.push(image_barrier(
                    vk::AccessFlags::SHADER_WRITE,
                    vk::AccessFlags::TRANSFER_READ,
                    vk::ImageLayout::GENERAL,
                    vk::ImageLayout::GENERAL,
                    image.image.get(),
                ));
            }
            let buffer_barrier = vk::MemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::SHADER_WRITE)
                .dst_access_mask(vk::AccessFlags::HOST_READ)
                .build();
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    shader_stage,
                    vk::PipelineStageFlags::TRANSFER | vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[buffer_barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &post_dispatch,
                );
            }
        }

        let subresource_layers = vk::ImageSubresourceLayers {
            aspect_mask: vk::ImageAspectFlags::COLOR,
            mip_level: 0,
            base_array_layer: 0,
            layer_count: 1,
        };

        // Copy output image.
        {
            let region = vk::BufferImageCopy::builder()
                .buffer_offset(0)
                .image_subresource(subresource_layers)
                .image_extent(vk::Extent3D {
                    width: DIM,
                    height: DIM,
                    depth: 1,
                })
                .build();
            unsafe {
                device.cmd_copy_image_to_buffer(
                    cmd,
                    output_image.image.get(),
                    vk::ImageLayout::GENERAL,
                    copy_buffer.get(),
                    &[region],
                );
            }
        }

        // Copy each written storage image into the readback buffer.
        for (i, image) in write_images.iter().enumerate() {
            let region = vk::BufferImageCopy::builder()
                .buffer_offset((i * 4) as u64)
                .image_subresource(subresource_layers)
                .image_extent(vk::Extent3D {
                    width: 1,
                    height: 1,
                    depth: 1,
                })
                .build();
            unsafe {
                device.cmd_copy_image_to_buffer(
                    cmd,
                    image.image.get(),
                    vk::ImageLayout::GENERAL,
                    readback_buffer.get(),
                    &[region],
                );
            }
        }

        // Transfer writes -> host reads.
        {
            let barrier = vk::MemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
                .dst_access_mask(vk::AccessFlags::HOST_READ)
                .build();
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        invalidate_alloc(device, copy_buffer.buffer.get_allocation())?;
        invalidate_alloc(device, readback_buffer.buffer.get_allocation())?;
        invalidate_alloc(device, backing_buffer.buffer.get_allocation())?;

        let mut failures = 0u32;

        // Every output texel must be 1.
        {
            let output = &copy_buffer.bytes()[..copy_buffer_size as usize];
            for texel in output.chunks_exact(4) {
                if i32::from_ne_bytes(texel.try_into().expect("four bytes")) != 1 {
                    failures += 1;
                }
            }
        }

        // Verify generated writes.
        {
            let readback = readback_buffer.bytes();
            let mut image_write_values: HashMap<u32, i32> = HashMap::new();
            for (i, image) in write_images.iter().enumerate() {
                let value = i32::from_ne_bytes(readback[i * 4..i * 4 + 4].try_into().expect("four bytes"));
                image_write_values.insert(image.descriptor, value);
            }

            for write in &data.writes {
                if !write.generated {
                    continue;
                }

                let d = binding_start[&(write.set, write.binding)] + write.number;
                let kind = data
                    .bindings
                    .iter()
                    .find(|binding| binding.set == write.set && binding.binding == write.binding)
                    .map(|binding| binding.kind)
                    .expect("a write belongs to a binding");

                let got = if kind == b'I' {
                    image_write_values.get(&d).copied().unwrap_or(-1)
                } else {
                    read_backing_value(d)
                };

                if got != d as i32 {
                    failures += 1;
                }
            }
        }

        if failures != 0 {
            return Ok(TestStatus::fail(format!("Found {failures} incorrect values")));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createDescriptorHeapRandomTests` - the `descriptor_heap_random` group.
pub fn create_descriptor_heap_random_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("descriptor_heap_random");

    let mut cases: HashMap<String, CaseDef> = CASE_LINES.lines().map(parse_case).collect();
    let names: String = CASE_LINES
        .lines()
        .filter_map(|line| line.split('|').next())
        .collect::<Vec<_>>()
        .join("\n");

    let mut real = |path: &str| -> Option<Box<dyn TestCase>> {
        let data = cases.remove(path)?;
        let name = path.rsplit('.').next().unwrap_or(path).to_string();
        Some(Box::new(DescriptorHeapRandomCase { name, data }) as Box<dyn TestCase>)
    };
    for child in build_gated_groups_with(&names, &[], "the descriptor heap random tests", &mut real) {
        group.add_child(child);
    }
    group
}
